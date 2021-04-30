public class ControllerServiciosCuentaAhorro {
	@future(callout=true)
    public static void execute(String CaseId) {
    	
        Case c = [Select Id,Respuesta_SF_Tarjetas__c,Account.Identificacion__c,Account.Name,Account.PersonEmail,Account.Celular__c,
                      Account.Sexo__c From Case Where Id =: CaseId];
            
        System.debug('caso: '+c);
        
        Detalle_caso__c detC = [Select Id,Cuenta__r.Name,Tipo_Operacion__c,Cuenta__r.CurrencyIsoCode, Cuenta__r.Fecha_Apertura__c, 
                                Frecuencia__c,N_Cuenta_Bancaria__c,Nuevo_monto_aporte__c
                                From Detalle_caso__c Where Caso__c =: c.Id];
            
        System.debug('Detalle Caso: '+detC);
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/gestionesBanco');
        
        FieldsBankManagement fields = new FieldsBankManagement();
		
        String respuesta = '';
        String tipoGestion = '';
        String moneda = '';

		system.debug('Entro al metodo API');
        
        //String Datos = '{"tipoGestion":"afiliaDebito","identificacion":"103436","moneda":"LPS","fechaInicio":"2020-03-15","periodicidad":"M","cuentaBancaria":"200009330053","diaCobro":"D","montoDebito":"100"}'; 
        String Datos = '{"tipoGestion":"actMontoDebito","identificacion":"103436","moneda":"LPS","fechaInicio":"2020-03-15","periodicidad":"M","cuentaBancaria":"200009330053","diaCobro":"D","montoDebito":"200"}'; 
        
        fields.tipoGestion = tipoGestion;
        fields.identificacion = detC.Cuenta__r.Name;
        //Inicio - Validar la moneda de la cuenta
        if(detC.Cuenta__r.CurrencyIsoCode == 'HNL') {
            moneda = 'LPS';
        } else {
            moneda = detC.Cuenta__r.CurrencyIsoCode;
        }
        fields.moneda = moneda;
        //Fin - Validar la periodicidad
        fields.fechaInicio = String.valueOf(detC.Cuenta__r.Fecha_Apertura__c);
        fields.periodicidad = detC.Frecuencia__c;
        fields.cuentaBancaria = detC.N_Cuenta_Bancaria__c;
        fields.diaCobro = 'D';
        fields.montoDebito = String.valueOf(detC.Nuevo_monto_aporte__c);
        
		try{		
			classJson envio = new classJson();
			//envio.contenido = JSON.serialize(envioDatos);
            envio.contenido = Datos;
            String cons = 'contenido=' + envio.contenido;
			system.debug('cons: '+cons);		
			request.setBody(cons);	
			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            //system.debug('respuesta: '+respuesta);
            
            //Get Identity of Response
            JSONParser parser = JSON.createParser(respuesta);
            //System.debug('respuesta: '+respuesta);
            
            if(respuesta.contains('timed out')) {
                System.debug('respuesta: '+respuesta);
            } else if(respuesta.contains('error')) {
                System.debug('respuesta: '+respuesta);
            } else if(respuesta == 'Monto del Debito actualizado Correctamente') {
                System.debug('respuesta: '+respuesta);
                c.Respuesta_SF_Tarjetas__c = respuesta;
                update c;
                List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id, DAU_EjecutarSYSDE__c = true));
                // Call method to publish events
                List<Database.SaveResult> results = EventBus.publish(Logs);
            }     
                     
		} catch(System.CalloutException e){
			system.debug('Mensaje Conexión: '+e.getMessage());
            respuesta = e.getMessage();
        }
		//return fields;     
    }    
}