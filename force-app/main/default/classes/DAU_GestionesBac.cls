public class DAU_GestionesBac {
    @future(callout=true)
    public static void execute(String CaseId/*, classGestionesBac envioDatos*/) {        
        
        System.debug('Caso: '+CaseId);
        
        Case c = [Select Id,Respuesta_SF_Tarjetas__c,Account.Identificacion__c,Account.Name,Account.PersonEmail,Account.Celular__c,
                  Account.Sexo__c From Case Where Id =: CaseId];
        
        Detalle_caso__c detC = [Select Id,Cuenta__r.Name,N_Cuenta_Bancaria__c,Mes__c,Ano_tarjeta__c,DAU_Dia_de_pago__c, Tipo_Operacion__c,	
                                DAU_Tarjeta_Habiente__c,DAU_Tipo_Tarjeta__c,Nuevo_monto_aporte__c,toLabel(Banco__c) 
                                From Detalle_caso__c Where Caso__c =: c.Id];
        
        String tipoGestion;
        String estadoDebito = 'A';
        
        classGestionesBac datos = new classGestionesBac();
        if(detC.Tipo_Operacion__c == 'A3' || detC.Tipo_Operacion__c == 'A8') {
            tipoGestion = 'afiliaDebito';
        } else if(detC.Tipo_Operacion__c == 'A4') {
            tipoGestion = 'modificaDebito';
        } else if(detC.Tipo_Operacion__c == 'A7') {
            tipoGestion = 'modificaDebito';
            estadoDebito = 'C';
        }
        datos.tipoGestion = tipoGestion;
        datos.identificacion = c.Account.Identificacion__c;
        datos.nombreCliente = String.valueOf(Account.Name);
        datos.email = String.valueOf(Account.PersonEmail);
        datos.celular = String.valueOf(Account.Celular__c);
        datos.sexo = String.valueOf(Account.Sexo__c);
        datos.servicio = 'Pensiones';
        datos.cuentaPensiones = detC.Cuenta__r.Name;
        datos.tipoTarjeta = detC.DAU_Tipo_Tarjeta__c;
        datos.nombreTarjetaHabiente = detC.DAU_Tarjeta_Habiente__c;
        datos.numeroTarjeta = detC.N_Cuenta_Bancaria__c; 
        String Anio = detC.Ano_tarjeta__c;
        Anio.Substring(Anio.length()-2);
        datos.fechaExpiracion = detC.Mes__c+Anio;
        datos.bancoTarjeta = detC.Banco__c;
        datos.diaCobro = detC.DAU_Dia_de_pago__c;
        datos.montoDebito = String.valueOf(detC.Nuevo_monto_aporte__c);
        datos.estadoDebito = estadoDebito;
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/gestionesBac');
        
		String respuesta = '';
		system.debug('Entro al metodo API');
		try{		
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(datos/*envioDatos*/);
            String cons = 'contenido=' + envio.contenido;
			system.debug('cons: '+cons);		
			request.setBody(cons);	
			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            system.debug('respuesta: '+respuesta);
            //respuesta = 'Débito creado correctamente';
            if(respuesta == 'Débito creado correctamente') {
                c.Respuesta_SF_Tarjetas__c = respuesta;
                update c;
            	System.debug('Entró'); 
                /*List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id, DAU_EjecutarSYSDE__c = true));
                // Call method to publish events
                List<Database.SaveResult> results = EventBus.publish(Logs);*/
            }
		}catch(System.CalloutException e){
			system.debug('Mensaje Conexión: '+e.getMessage());
            respuesta = e.getMessage();
        }
		//return respuesta;     
    }    
}