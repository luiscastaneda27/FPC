public class DAU_GestionesBac {
    @future(callout=true)
    public static void execute(String CaseId, String Gestion) {        
        
        String respuesta = '';
        
        Case c = [Select Id,Status,Respuesta_SF_Tarjetas__c,Account.Identificacion__c,Account.Name,Account.PersonEmail,Account.Celular__c,
                      Account.Sexo__c From Case Where Id =: CaseId];
            
        System.debug('caso a procesar BAC: '+c);
        
        try{
                  
            System.debug('Caso: '+CaseId);
            
            Detalle_caso__c detC = [Select Id,Cuenta__r.Name,Cuenta__r.Monto_aporte__c,Cuenta__r.Fecha_Aporte__c,N_Cuenta_Bancaria__c,Mes__c,Ano_tarjeta__c,DAU_Dia_de_pago__c, Tipo_Operacion__c,	
                                    DAU_Tarjeta_Habiente__c,DAU_Tipo_Tarjeta__c,Nuevo_monto_aporte__c,toLabel(Banco__c), Nueva_fecha_aporte__c, Cuenta__r.Fondo_Inversion__c 
                                    From Detalle_caso__c Where Caso__c =: c.Id];
            
            System.debug('Detalle Caso: '+detC);
            
            //Start Get Metadata
            String servicio;
            DAU_BAC_Tipos_de_Fondos__mdt[] mdt = [SELECT MasterLabel,Codigo__c FROM DAU_BAC_Tipos_de_Fondos__mdt];
            For(DAU_BAC_Tipos_de_Fondos__mdt m : mdt) {
                if(m.Codigo__c == detC.Cuenta__r.Fondo_Inversion__c) {
                    servicio = m.MasterLabel;   
                }
            }
            //End Get Metadata
                       
            String tipoGestion = '';
            String montoDebito = '0';
            String estadoDebito = 'A';
            
            classGestionesBac datos = new classGestionesBac();
            if(detC.Tipo_Operacion__c == 'A3' || detC.Tipo_Operacion__c == 'A8' || Gestion == 'Afiliacion' 
              || (detC.Tipo_Operacion__c == 'A6' && c.Respuesta_SF_Tarjetas__c <> Null && c.Status == 'Cerrado')) {
                System.debug('Afiliación de Débito Automático');
                datos.tipoGestion = 'afiliaDebito';
                datos.identificacion = c.Account.Identificacion__c;
                datos.nombreCliente = c.Account.Name;
                datos.email = c.Account.PersonEmail;
                datos.celular = c.Account.Celular__c;
                datos.sexo = c.Account.Sexo__c;
                datos.servicio = servicio;
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
                if(detC.Tipo_Operacion__c == 'A6') {
                	datos.montoDebito = String.valueOf(detC.Cuenta__r.Monto_aporte__c);    
                } else {
                	datos.montoDebito = String.valueOf(detC.Nuevo_monto_aporte__c);    
                }
                datos.estadoDebito = estadoDebito;
            } else if(detC.Tipo_Operacion__c == 'A1' || detC.Tipo_Operacion__c == 'A2') {       
                System.debug('Aumento de Aporte	o Disminución de Aporte');
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
                datos.montoDebito = String.valueOf(detC.Nuevo_monto_aporte__c);   
                datos.estadoDebito = estadoDebito;                                              
            } else if(detC.Tipo_Operacion__c == 'A4') {       
                System.debug('Cambio de Fecha de Aporte');
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
            } else if(detC.Tipo_Operacion__c == 'A7' || (detC.Tipo_Operacion__c == 'A6' && c.Respuesta_SF_Tarjetas__c == Null)) {
                System.debug('Cancelación');
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
                datos.montoDebito = '0';    
                datos.estadoDebito = 'C';  
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
            //respuesta = 'Débito creado correctamente'; 
            system.debug('respuesta: '+respuesta);
            
            if(respuesta == 'Débito creado correctamente' || respuesta == 'Débito modificado correctamente') {
                if(detC.Tipo_Operacion__c == 'A7') {
                	c.Respuesta_SF_Tarjetas__c = 'Cancelación: // '+respuesta; 
                    List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                    Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id, DAU_EjecutarSYSDE__c = true));
                    // Call method to publish events
                    List<Database.SaveResult> results = EventBus.publish(Logs);
                } else if(detC.Tipo_Operacion__c == 'A6' && c.Respuesta_SF_Tarjetas__c == Null) {
                	c.Respuesta_SF_Tarjetas__c = 'Cancelación: // '+respuesta;     
                    List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                    Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id));
                    // Call method to publish events
                    List<Database.SaveResult> results = EventBus.publish(Logs);
                } else if(detC.Tipo_Operacion__c == 'A6' && c.Respuesta_SF_Tarjetas__c <> Null) {
                	c.Respuesta_SF_Tarjetas__c = c.Respuesta_SF_Tarjetas__c + ' --- Afiliación: // ' + respuesta; 
                } else {
                	c.Respuesta_SF_Tarjetas__c = respuesta;    
                }               
                update c;
                if(detC.Tipo_Operacion__c == 'A1' || detC.Tipo_Operacion__c == 'A2' || detC.Tipo_Operacion__c == 'A4') {
                    System.debug('Aumento de Aporte	o Disminución de Aporte	 o Cambio de Fecha de Aporte llama a Sysde');
                    List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                    Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id, DAU_EjecutarSYSDE__c = true));
                    // Call method to publish events
                    List<Database.SaveResult> results = EventBus.publish(Logs);
                }
                else if(detC.Tipo_Operacion__c == 'A6' && c.Respuesta_SF_Tarjetas__c.Contains('Afiliación')) {
                    System.debug('Cambio de # Tarjeta llama a Sysde');
                    List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                    Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id, DAU_EjecutarSYSDE__c = true));
                    // Call method to publish events
                    List<Database.SaveResult> results = EventBus.publish(Logs);
                } 
                else if(detC.Tipo_Operacion__c == 'A7') {
                	System.debug('Cancelación llama a Sysde');
                    List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                    Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id, DAU_EjecutarSYSDE__c = true));
                    // Call method to publish events
                    List<Database.SaveResult> results = EventBus.publish(Logs);    
                }
                else if(detC.Tipo_Operacion__c == 'A3' || detC.Tipo_Operacion__c == 'A8') {
                	System.debug('Cambio de Canal de Aporte	o Afiliación de Débito Automático llama a Sysde');
                    List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                    Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id, DAU_EjecutarSYSDE__c = true));
                    // Call method to publish events
                    List<Database.SaveResult> results = EventBus.publish(Logs);    
                }
            } else if(respuesta.contains('Error')){
            	c.Respuesta_SF_Tarjetas__c = c.Respuesta_SF_Tarjetas__c + ' ' + respuesta;
                update c;    
            }
		}catch(System.CalloutException e){
			system.debug('Mensaje Conexión: '+e.getMessage());
            respuesta = e.getMessage();
            c.Respuesta_SF_Tarjetas__c = c.Respuesta_SF_Tarjetas__c + ' ' + respuesta;
            update c; 
        }
		//return respuesta;     
    }    
}