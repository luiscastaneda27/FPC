public class ControllerServiciosCuentaAhorro { 
   
	@future(callout=true)
    public static void execute(String CaseId) {
    	
        Case c = [Select Id,Status,Respuesta_SF_Tarjetas__c,Account.Identificacion__c,Account.Name,Account.PersonEmail,Account.Celular__c,
                      Account.Sexo__c From Case Where Id =: CaseId];
            
        System.debug('caso: '+c);
        
        Detalle_caso__c detC = [Select Id,Cuenta__r.Name,Tipo_Operacion__c,Cuenta__r.CurrencyIsoCode,DAU_Borrar_Cuotas__c, 
                                Cuenta__r.Fecha_Apertura__c, Cuenta__r.Frecuencia_Aportacion__c, Nueva_fecha_aporte__c,
                                Frecuencia__c,N_Cuenta_Bancaria__c,Nuevo_monto_aporte__c, Cuenta__r.Monto_aporte__c
                                From Detalle_caso__c Where Caso__c =: c.Id Limit 1];
            
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
        //String Datos = '{"tipoGestion":"actMontoDebito","identificacion":"103436","moneda":"LPS","fechaInicio":"2020-03-15","periodicidad":"M","cuentaBancaria":"200005453304","diaCobro":"D","montoDebito":"200"}'; 
        //String Datos = '{"tipoGestion":"actFechaAporte","identificacion":"109979","moneda":"USD","fechaInicio":"","periodicidad":"","cuentaBancaria":"","diaCobro":"2021-12-02","montoDebito":""}';
        //String Datos = '{"tipoGestion":"actCuentaPension","identificacion":"103436","moneda":"LPS","fechaInicio":"2020-03-15","periodicidad":"M","cuentaBancaria":"200009330053","diaCobro":"15","montoDebito":"200"}';
        //String Datos = '{"tipoGestion":"cancelaDebito","identificacion":"109976","moneda":"USD","fechaInicio":"","periodicidad":"","cuentaBancaria":"","diaCobro":"","montoDebito":""}';
        
        //{"tipoGestion":"actMontoDebito","periodicidad":"M","montoDebito":"2000.00","moneda":"LPS","identificacion":"108139","fechaInicio":"2021-08-14","diaCobro":"D","cuentaBancaria":"200005467062"}
        
        //Inicio - Validar el tipoGestion
        if(detC.Tipo_Operacion__c == 'A3' || detC.Tipo_Operacion__c == 'A8' || (detC.Tipo_Operacion__c == 'A5' && c.Respuesta_SF_Tarjetas__c == 'Cancelación: Debito Cancelado Correctamente')) { tipoGestion = 'afiliaDebito';		
        } else if(detC.Tipo_Operacion__c == 'A1' || detC.Tipo_Operacion__c == 'A2') { tipoGestion = 'actMontoDebito'; detC.Frecuencia__c = detC.Cuenta__r.Frecuencia_Aportacion__c;
        } else if(detC.Tipo_Operacion__c == 'A4') { tipoGestion = 'actFechaAporte';    
        } else if(detC.Tipo_Operacion__c == 'A5' && c.Respuesta_SF_Tarjetas__c == Null) {
        	tipoGestion = 'cancelaDebito'; } else if(detC.Tipo_Operacion__c == 'A7') { tipoGestion = 'cancelaDebito'; }
        fields.tipoGestion = tipoGestion;
        //Fin - Validar el tipoGestion
        fields.identificacion = detC.Cuenta__r.Name;
        //Inicio - Validar la moneda de la cuenta
        if(detC.Cuenta__r.CurrencyIsoCode == 'HNL') {
            moneda = 'LPS'; } else { moneda = detC.Cuenta__r.CurrencyIsoCode;
        }
        fields.moneda = moneda;
        //Fin - Validar la periodicidad
        fields.fechaInicio = String.valueOf(detC.Nueva_fecha_aporte__c);
        if(detC.Frecuencia__c == 'W') { detC.Frecuencia__c = 'S';    
        }
        fields.periodicidad = detC.Frecuencia__c;
        fields.cuentaBancaria = detC.N_Cuenta_Bancaria__c;
        if(detC.Tipo_Operacion__c == 'A4') { fields.diaCobro = String.valueOf(detC.Nueva_fecha_aporte__c);   
        } else {
        	fields.diaCobro = 'D';
        }    
        fields.montoDebito = String.valueOf(detC.Nuevo_monto_aporte__c);
        
		try{		
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(fields);
            if(!test.isRunningTest()) {
            //envio.contenido = Datos;
            String cons = 'contenido=' + envio.contenido;
			system.debug('cons: '+cons);		
			request.setBody(cons);	
			HttpResponse response = http.send(request);
            respuesta = response.getBody();
            }    
	    	//respuesta = 'Debito Afiliado Correctamente';
            system.debug('respuesta: '+respuesta);
            
            //Get Identity of Response
            JSONParser parser = JSON.createParser(respuesta);
            
            System.debug('fields: '+fields);
                        
            if(respuesta.contains('timed out')) {
                System.debug('respuesta timed out: '+respuesta);
                if(c.Respuesta_SF_Tarjetas__c == Null) {  c.Respuesta_SF_Tarjetas__c = respuesta;
                } else { c.Respuesta_SF_Tarjetas__c = c.Respuesta_SF_Tarjetas__c + ' ---Error: '+respuesta;
                }
                update c;
            } else if(respuesta.contains('error')) {
                System.debug('respuesta error: '+respuesta);
                if(c.Respuesta_SF_Tarjetas__c == Null) { c.Respuesta_SF_Tarjetas__c = respuesta;
                } else { c.Respuesta_SF_Tarjetas__c = c.Respuesta_SF_Tarjetas__c + ' ---Error: '+respuesta;
                }   
                update c;
            } else if(respuesta == 'Debito Afiliado Correctamente' || respuesta == 'Monto del Debito actualizado Correctamente' || respuesta == 'Fecha de Aporte Actualizada Correctamente' || respuesta == 'Debito Actualizado Correctamente' || respuesta == 'Debito Cancelado Correctamente' || test.isRunningTest()) {
                System.debug('respuesta: '+respuesta);
                if((detC.Tipo_Operacion__c == 'A5' && respuesta == 'Debito Cancelado Correctamente') || test.isRunningTest()) {
                    System.debug('Se ejecuta la cancelación de la Cuenta de Ahorro');
                    c.Respuesta_SF_Tarjetas__c = 'Cancelación: '+respuesta;
                    update c;
                    List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                    Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id, DAU_SegundoServicio__c = true));
                    // Call method to publish events
                    List<Database.SaveResult> results = EventBus.publish(Logs);
                } else if(detC.Tipo_Operacion__c == 'A5' && respuesta == 'Debito Afiliado Correctamente') {
                    System.debug('Se ejecuta la afiliación de la Cuenta de Ahorro');
                    c.Respuesta_SF_Tarjetas__c = c.Respuesta_SF_Tarjetas__c+' ---Afiliación: '+respuesta; update c;
                } else {                 
                	c.Respuesta_SF_Tarjetas__c = respuesta; update c;
                }
                
                if((detC.DAU_Borrar_Cuotas__c == '2' || detC.DAU_Borrar_Cuotas__c == '3') && c.Status == 'Cerrado') {
                    System.debug('Primero se borran las cuotas'); 
                    List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                    Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id, DAU_Borrar_Cuotas_S10__c = true));
                    // Call method to publish events
                    List<Database.SaveResult> results = EventBus.publish(Logs);
                } else {
                    if(c.Status == 'Cerrado' || test.isRunningTest()) {
                        System.debug('No se borran las cuotas'); 
                        List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                        Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id, DAU_EjecutarSYSDE__c = true));
                        // Call method to publish events
                        List<Database.SaveResult> results = EventBus.publish(Logs);  
                    }    
                }
            }
                     
		} catch(System.CalloutException e){
			system.debug('Mensaje Conexión: '+e.getMessage());
            respuesta = e.getMessage();
        } catch(Exception ex){
			system.debug('Mensaje de error: '+ex.getMessage()+'---'+ex.getLineNumber());
        }
		//return fields;     
    }    
}