public class DAU_GestionesBac {
    @future(callout=true)
    public static void execute(String CaseId, String Gestion) {        
        
        String respuesta = '';
        
        Case c = [Select Id,Respuesta_SF_Tarjetas__c,Account.Identificacion__c,Account.Name,Account.PersonEmail,Account.Celular__c,
                      Account.Sexo__c From Case Where Id =: CaseId];
            
        System.debug('caso: '+c);
        
        try{
        
            System.debug('Caso: '+CaseId);
            
            Detalle_caso__c detC = [Select Id,Cuenta__r.Name,Cuenta__r.Monto_aporte__c,N_Cuenta_Bancaria__c,Mes__c,Ano_tarjeta__c,DAU_Dia_de_pago__c, Tipo_Operacion__c,	
                                    DAU_Tarjeta_Habiente__c,DAU_Tipo_Tarjeta__c,Nuevo_monto_aporte__c,toLabel(Banco__c), Nueva_fecha_aporte__c 
                                    From Detalle_caso__c Where Caso__c =: c.Id];
            
            System.debug('Detalle Caso: '+detC);
                       
            String tipoGestion = '';
            String montoDebito = '0';
            String estadoDebito = 'A';
            
            classGestionesBac datos = new classGestionesBac();
            if(detC.Tipo_Operacion__c == 'A8' || Gestion == 'Afiliacion') {
                datos.tipoGestion = 'afiliaDebito';
                datos.identificacion = c.Account.Identificacion__c;
                datos.nombreCliente = c.Account.Name;
                datos.email = c.Account.PersonEmail;
                datos.celular = c.Account.Celular__c;
                datos.sexo = c.Account.Sexo__c;
                datos.servicio = 'Pensiones';
                datos.cuentaPensiones = detC.Cuenta__r.Name;
                datos.tipoTarjeta = detC.DAU_Tipo_Tarjeta__c;
                datos.nombreTarjetaHabiente = detC.DAU_Tarjeta_Habiente__c;
                datos.numeroTarjeta = detC.N_Cuenta_Bancaria__c;
                if(detC.Mes__c != Null && detC.Ano_tarjeta__c != Null) {
                    String Anio = detC.Ano_tarjeta__c;
                    Anio.Substring(Anio.length()-2);
                    datos.fechaExpiracion = detC.Mes__c+Anio;
                } 
                datos.bancoTarjeta = detC.Banco__c;
                datos.diaCobro = detC.DAU_Dia_de_pago__c;
                datos.montoDebito = String.valueOf(detC.Nuevo_monto_aporte__c);
                datos.estadoDebito = estadoDebito;
            } else if(detC.Tipo_Operacion__c == 'A4') {                                            
                datos.tipoGestion = 'modificaDebito';
                datos.identificacion = c.Account.Identificacion__c;
                datos.nombreCliente = '';
                datos.email = '';
                datos.celular = '';
                datos.sexo = '';
                datos.servicio = '';
                datos.cuentaPensiones = detC.Cuenta__r.Name;
                datos.tipoTarjeta = '';              
                datos.nombreTarjetaHabiente = '';               
                datos.numeroTarjeta = '';                                            
                datos.fechaExpiracion = '';
                datos.bancoTarjeta = '';              
                Date myDate = Date.valueOf(detC.Nueva_fecha_aporte__c);
                datos.diaCobro = String.valueOf(myDate.Day());
                datos.montoDebito = String.valueOf(detC.Cuenta__r.Monto_aporte__c);   
                datos.estadoDebito = estadoDebito;                                              
            } else if(detC.Tipo_Operacion__c == 'A7' || detC.Tipo_Operacion__c == 'A3') {
                datos.tipoGestion = 'modificaDebito';
                datos.identificacion = c.Account.Identificacion__c;
                datos.nombreCliente = '';
                datos.email = '';
                datos.celular = '';
                datos.sexo = '';
                datos.servicio = '';
                datos.cuentaPensiones = detC.Cuenta__r.Name;
                datos.tipoTarjeta = '';              
                datos.nombreTarjetaHabiente = '';               
                datos.numeroTarjeta = '';                                            
                datos.fechaExpiracion = '';
                datos.bancoTarjeta = '';                              
                datos.diaCobro = '14';
                datos.montoDebito = String.valueOf(detC.Cuenta__r.Monto_aporte__c);    
                datos.estadoDebito = 'C';  
                if(detC.Tipo_Operacion__c == 'A3') {
                    List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                    Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id));
                    // Call method to publish events
                    List<Database.SaveResult> results = EventBus.publish(Logs);
                }
            }             
            
            System.debug('Datos: '+datos);
            
            //string datos2 = '{"tipoTarjeta":"","tipoGestion":"modificaDebito","sexo":"","servicio":"","numeroTarjeta":"","nombreTarjetaHabiente":"","nombreCliente":"","montoDebito":"0","identificacion":"0801198801164","fechaExpiracion":"","estadoDebito":"A","email":"","diaCobro":"26","cuentaPensiones":"1410","celular":"","bancoTarjeta":""}';
            //string datos2 = '{"tipoGestion":"afiliaDebito","identificacion":"0801198801164","nombreCliente":"F. Josue Blandon","email":"josue.blan123@gmail.com","celular":"99999999","sexo":"M","servicio":"Pensiones","cuentaPensiones":"1410","tipoTarjeta":"Visa","nombreTarjetaHabiente":"Josue Blandon","numeroTarjeta":"4716633973297125","fechaExpiracion":"1222","bancoTarjeta":"Davivienda","diaCobro":"24","montoDebito":"105","estadoDebito":"A"}';
            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String url = claseUtil.urlSysde('Test');		
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            request.setTimeout(120000);
            request.setEndpoint(url + 'api/gestionesBac');
            
            system.debug('Entro al metodo API');
				
			classJson envio = new classJson();
            envio.contenido = JSON.serialize(datos);
            String cons = 'contenido=' + envio.contenido;
			system.debug('cons: '+cons); 		
			request.setBody(cons);	
			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            system.debug('respuesta: '+respuesta);
            if(respuesta == 'Débito creado correctamente' || respuesta == 'Débito modificado correctamente') {
                c.Respuesta_SF_Tarjetas__c = respuesta;
                update c;
                if(detC.Tipo_Operacion__c != 'A3' || Gestion == 'Afiliacion') {
                    List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                    Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id, DAU_EjecutarSYSDE__c = true));
                    // Call method to publish events
                    List<Database.SaveResult> results = EventBus.publish(Logs);
                }    
            } else if(respuesta.contains('Error')){
            	c.Respuesta_SF_Tarjetas__c = respuesta;
                update c;    
            }
		}catch(System.CalloutException e){
			system.debug('Mensaje Conexión: '+e.getMessage());
            respuesta = e.getMessage();
            c.Respuesta_SF_Tarjetas__c = respuesta;
            update c; 
        }
		//return respuesta;     
    }    
}