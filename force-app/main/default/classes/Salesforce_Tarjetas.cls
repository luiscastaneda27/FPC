public class Salesforce_Tarjetas {
	@future(callout=true)
    public static void processCase(Set<Id> caseIds, String tipoGestion, String beneficiario, String diaPago) {
        List<Case> updateCase = new List<Case>();
        try {
    	List<Case> lstCase = [Select Id,Status,Account.Identificacion__c,Respuesta_desde_Sysde__c,Respuesta_SF_Tarjetas__c, DAU_No_Cuenta__c,
                              DAU_Identidad__c,Tipo_de_Operacion__c,DAU_Tarjeta_de_Sysde__c From Case Where Id in :caseIds Limit 1];
        List<Detalle_caso__c> detcaso = [Select Id,Caso__c,Cuenta__c,Cuenta__r.Name,Cuenta__r.CurrencyIsoCode,N_Cuenta_Bancaria__c 
                                         From Detalle_caso__c Where Caso__c In: caseIds Limit 1];
        String Identidad = lstCase[0].DAU_Identidad__c;
        System.debug('Identidad2: '+Identidad.substring(0,13));
        String moneda;
        if(detcaso[0].Cuenta__r.CurrencyIsoCode == 'HNL') {
        	moneda = 'L';    
        } else if(detcaso[0].Cuenta__r.CurrencyIsoCode == 'USD') {
            moneda = '$';
        }       
        for(Case c : lstCase) {           
            //if(/*c.Status <> 'Cerrado' && */c.Respuesta_desde_Sysde__c == Null) {
                //Creando caso en Salesforce Tarjetas
                partnerSoapSforceCom.Soap con = new partnerSoapSforceCom.Soap();
				partnerSoapSforceCom.LoginResult loginResult = con.login('pensiones.ficohsa@ficohsa.com.ficohsa', 'Pensiones2020' + '7dOJQar50mg3RDNP8XNvH63PS');
                WsGestiones.WS_GestionesDAU servDau = new WsGestiones.WS_GestionesDAU();
                WsGestiones.SessionHeader_element sessionHeader = new WsGestiones.SessionHeader_element();
                sessionHeader.sessionId = loginResult.sessionid;
                servDau.timeout_x = 120000;
                servDau.SessionHeader = sessionHeader;
                
            	String asunto = '';
                String CuentaBancaria = detcaso[0].N_Cuenta_Bancaria__c;
            
                if(c.Tipo_de_Operacion__c == 'A7') {
                	asunto = 'Cancelación DAU Pensiones';
                } else if(c.Tipo_de_Operacion__c == 'A3' || c.Tipo_de_Operacion__c == 'A8') {
                	asunto = 'Debito automático Pensiones';    
                } else if(c.Tipo_de_Operacion__c == 'A4') {
                	asunto = 'Modificacion de Beneficios';    
                } else if(c.Tipo_de_Operacion__c == 'A6' && c.Respuesta_SF_Tarjetas__c == Null) {
                	asunto = 'Cancelación DAU Pensiones';
                    CuentaBancaria = lstCase[0].DAU_Tarjeta_de_Sysde__c;
                } else if(c.Tipo_de_Operacion__c == 'A6' && c.Respuesta_SF_Tarjetas__c <> Null) {
                	asunto = 'Debito automático Pensiones';  
                }
            
                System.debug('tipoGestion: '+tipoGestion+'---'+'Identidad: '+lstCase[0].DAU_Identidad__c+'---'+'nroCuenta: '+lstCase[0].DAU_No_Cuenta__c+'---'+'# Cuenta Bancaria: '+CuentaBancaria+'---'+'moneda: '+moneda+'---'+'Cuenta Salesforce: '+detcaso[0].Cuenta__r.Name+'---'+'Asunto: '+asunto+'---'+'Beneficiario: '+beneficiario+'---'+'DiaPago: '+diaPago);
            
                String response = String.valueOf(servDau.crearGestion(tipoGestion,lstCase[0].DAU_Identidad__c,lstCase[0].DAU_No_Cuenta__c,CuentaBancaria,'Pensiones y Cesantías -Personal Ordinario '+moneda,detcaso[0].Cuenta__r.Name,asunto,'Otros',beneficiario,diaPago,'Ficohsa Pensiones','','','','','',''));
                System.debug('response: '+response);
                
                WsGestiones.crearGestionResponse_element resultado = new WsGestiones.crearGestionResponse_element();
                System.debug('resultado: '+resultado);
                                
                //Get Identity of Response
                String respuesta;
                JSONParser parser = JSON.createParser(JSON.serialize(resultado));
                System.debug('parser01: '+parser);
                while (parser.nextToken() != null) {
                    System.debug('parser.getCurrentName01(): '+parser.getCurrentName());
                    if(parser.getCurrentName() == 'field_order_type_info') {
                        parser.nextValue();
                        System.debug('field_order_type_info: ' +parser.getText());
                        respuesta = parser.getText();
                    }
                }  
                System.debug('respuesta: '+respuesta);
                
                /*String response = 'Gestión creada con éxito';
                String response2 = 'Gestión creada con éxito 2';*/
            
                //c.Respuesta_SF_Tarjetas__c = String.valueOf(respuesta);               
                if(response.contains('éxito')) {
                	System.debug('Gestión creada con éxito');    
                    if(c.Tipo_de_Operacion__c <> 'A6') {
                        c.Respuesta_SF_Tarjetas__c = String.valueOf(response);
                    }               
                    if(c.Tipo_de_Operacion__c == 'A6' && c.Respuesta_SF_Tarjetas__c == Null) {
                    	c.Respuesta_SF_Tarjetas__c = 'Cancelación: // '+String.valueOf(response); 
                        List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                        Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id, DAU_SegundoServicio__c = true));
                        // Call method to publish events
                        List<Database.SaveResult> results = EventBus.publish(Logs);
                    }                    
                    if(c.Tipo_de_Operacion__c == 'A6' && asunto == 'Debito automático Pensiones') {
                    	c.Respuesta_SF_Tarjetas__c = c.Respuesta_SF_Tarjetas__c + ' --- Afiliación: // ' + String.valueOf(response);  
                    	List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                        Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id, DAU_EjecutarSYSDE__c = true));
                        // Call method to publish events
                        List<Database.SaveResult> results = EventBus.publish(Logs);
                    }                    
                    if(c.Tipo_de_Operacion__c == 'A4' || c.Tipo_de_Operacion__c == 'A7') {
                    	List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                        Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id, DAU_EjecutarSYSDE__c = true));
                        // Call method to publish events
                        List<Database.SaveResult> results = EventBus.publish(Logs);
                    }
                    if(c.Tipo_de_Operacion__c == 'A3' || c.Tipo_de_Operacion__c == 'A8') {
                        List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                        Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = c.Id, DAU_EjecutarSYSDE__c = true));
                        // Call method to publish events
                        List<Database.SaveResult> results = EventBus.publish(Logs);
                    } 
                } else if(response.contains('error')) {
                    System.debug('Error al crear la gestion');
                    c.Respuesta_SF_Tarjetas__c = String.valueOf(response);
					c.DAU_aprobacion__c = false;  
                }
                updateCase.add(c);
            //}   
        }        
        } catch(Exception ex) {
        	System.debug('Error: '+ex.getLineNumber()+'---'+ex.getMessage());    
        } 
        Update updateCase;
    }	
    
}