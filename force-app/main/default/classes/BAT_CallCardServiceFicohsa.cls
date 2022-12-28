global class BAT_CallCardServiceFicohsa implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts {
    
    public Boolean enviarSolicitud;
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
    	return Database.getQueryLocator([SELECT Id,Caso__c,Caso__r.CaseNumber,Caso__r.Status,Nuevo_canal_aporte__c,Caso__r.Tipo_de_Operacion__c,
                                         Caso__r.Account.Name,DAU_Dia_de_pago__c,Caso__r.DAU_Identidad__c,Cuenta__r.CurrencyIsoCode,
                                         N_Cuenta_Bancaria__c,Caso__r.DAU_No_Cuenta__c,Cuenta__r.Name,Nueva_fecha_aporte__c,CreatedDate 
                                         From Detalle_caso__c Where Caso__r.Id = '5006300000CxWIJAA3' and Caso__r.Status = 'Cerrado' 
                                         and Nuevo_canal_aporte__c = 'TA' and Caso__r.Tipo_de_Operacion__c = 'A8']); 
    }
	
	global void execute(Database.BatchableContext bc, List<Detalle_caso__c> scope) {
        try {
            //Entra a llamar a servicios de Tarjeta Ficohsa Regional
            enviarSolicitud = false;
            String tipoGestion = 'ALTA';
            String identidad,moneda;
            String DAU_Usuario, DAU_Contrasenia, DAU_Token;
            Decimal Dias;
            
            Parametros_DAU__mdt[] mdt = [SELECT Id,DeveloperName,DAU_Usuario__c,DAU_Contrasenia__c,DAU_Token__c,DAU_Dias__c 
                                         FROM Parametros_DAU__mdt];
            
            for(Parametros_DAU__mdt m : mdt) {
                if(m.DeveloperName == 'Parametro_dias') {
                    Dias = m.DAU_Dias__c;   
                }
                if(m.DeveloperName == 'Salesforce_regional') {
                	DAU_Usuario = m.DAU_Usuario__c; 
                    DAU_Contrasenia = m.DAU_Contrasenia__c; 
                    DAU_Token = m.DAU_Token__c;    
                }
            }
            
            //Validando la fecha
            Date fechaComparacion, fechaComparacion2;
            for(Detalle_caso__c dt : scope) {
                fechaComparacion = Date.valueOf(dt.CreatedDate.addDays(30));
                fechaComparacion2 = dt.Nueva_fecha_aporte__c.addDays(-Integer.ValueOf(Dias));
                if(fechaComparacion > dt.Nueva_fecha_aporte__c && fechaComparacion == Date.Today()) {
                    enviarSolicitud = true;
                } else if(fechaComparacion2 == Date.Today()) {
                	enviarSolicitud = true;    
                } else {
                    System.debug('No se llama al servicio de tarjetas regional');
                }
            }
            //System.debug('enviarSolicitud: '+enviarSolicitud);
            if(enviarSolicitud == true) {
                partnerSoapSforceCom.Soap con = new partnerSoapSforceCom.Soap();
                partnerSoapSforceCom.LoginResult loginResult = con.login(DAU_Usuario, DAU_Contrasenia + DAU_Token);
                
                http http = new Http();
                HttpRequest request = new HttpRequest();
                request.setEndpoint('https://cs211.salesforce.com/services/Soap/class/WS_DAU_Pensiones');
                request.setMethod('POST');
                request.setHeader('Content-Type', 'text/xml');
                request.setHeader('SOAPAction','action');
                request.setTimeout(120000);
                   
                String SOAPXML = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://soap.sforce.com/schemas/class/WS_DAU_Pensiones">\n';
                SOAPXML += '<soapenv:Header>\n';
                SOAPXML += '<ws:SessionHeader>\n';
                SOAPXML += '<ws:sessionId>'+loginResult.sessionid+'</ws:sessionId>\n';
                SOAPXML += '</ws:SessionHeader>\n';
                SOAPXML += '</soapenv:Header>\n';        
                SOAPXML += '<soapenv:Body>\n';
                SOAPXML += '<ws:GestionDAU>\n';
                SOAPXML += '<ws:Identidad>0801199403628</ws:Identidad>\n';
                SOAPXML += '<ws:Cuenta>0000051000399200672</ws:Cuenta>\n';
                SOAPXML += '<ws:SubProducto>Pensiones y Cesantías - Seguro de Vida L</ws:SubProducto>\n';
                SOAPXML += '<ws:NumReferencia>73232</ws:NumReferencia>\n';
                SOAPXML += '<ws:DiaPago>10</ws:DiaPago>\n';
                SOAPXML += '<ws:Moneda>HNL</ws:Moneda>\n';
                SOAPXML += '<ws:Monto>650</ws:Monto>\n';
                SOAPXML += '<ws:Pais>HONDURAS</ws:Pais>\n';
                SOAPXML += '<ws:Comentarios></ws:Comentarios>\n';
                SOAPXML += '<ws:MotivoBaja></ws:MotivoBaja>\n';
                SOAPXML += '<ws:TipoGestion>ALTA</ws:TipoGestion>\n';
                SOAPXML += '</ws:GestionDAU>\n';
                SOAPXML += '</soapenv:Body>\n';
                SOAPXML += '</soapenv:Envelope>';
        
                System.debug(SOAPXML);
        
                request.setBody(SOAPXML);
                HttpResponse response = http.send(request);
                     
                System.debug('La respuesta es: '+response.getBody());
                
                String Afiliacion, CodigoError, estadoGestion, Gestion; 
                String bodyXML = response.getBody(); //grab the body of the response
                XmlStreamReader reader = new XmlStreamReader(bodyXML); //construct an XmlStreamReader object
                while(reader.hasNext()) { //while there are more XML events
                    if (reader.getEventType() == XmlTag.START_ELEMENT) { //if this is the opening tag
                        if ('Afiliacion' == reader.getLocalName()) { //if the tag is Afiliacion
                            while(reader.hasNext()) { //while there are more XML events
                                if (reader.getEventType() == XmlTag.END_ELEMENT) { //if this is the closing tag
                                    break; //exist the loop
                                } else if (reader.getEventType() == XmlTag.CHARACTERS) { //if this is the content between the tags
                                    Afiliacion = reader.getText(); //grab the content
                                }
                                reader.next(); //advance to the next XML event
                            }
                        }
                        if ('CodigoError' == reader.getLocalName()) { //if the tag is CodigoError
                            while(reader.hasNext()) { //while there are more XML events
                                if (reader.getEventType() == XmlTag.END_ELEMENT) { //if this is the closing tag
                                    break; //exist the loop
                                } else if (reader.getEventType() == XmlTag.CHARACTERS) { //if this is the content between the tags
                                    CodigoError = reader.getText(); //grab the content
                                }
                                reader.next(); //advance to the next XML event
                            }
                        }
                        if ('estadoGestion' == reader.getLocalName()) { //if the tag is estadoGestion
                            while(reader.hasNext()) { //while there are more XML events
                                if (reader.getEventType() == XmlTag.END_ELEMENT) { //if this is the closing tag
                                    break; //exist the loop
                                } else if (reader.getEventType() == XmlTag.CHARACTERS) { //if this is the content between the tags
                                    estadoGestion = reader.getText(); //grab the content
                                }
                                reader.next(); //advance to the next XML event
                            }
                        }
                        if ('Gestion' == reader.getLocalName()) { //if the tag is Gestion
                            while(reader.hasNext()) { //while there are more XML events
                                if (reader.getEventType() == XmlTag.END_ELEMENT) { //if this is the closing tag
                                    break; //exist the loop
                                } else if (reader.getEventType() == XmlTag.CHARACTERS) { //if this is the content between the tags
                                    Gestion = reader.getText(); //grab the content
                                }
                                reader.next(); //advance to the next XML event
                            }
                        }
                    }
                    reader.next(); //advance to the next XML event   
                }
                system.debug('Afiliacion: '+Afiliacion);
                system.debug('CodigoError: '+CodigoError);
                system.debug('estadoGestion: '+estadoGestion);
                system.debug('Gestion: '+Gestion);
            }    
        } catch(Exception ex) {
            System.debug('Error en servicio: '+ex.getLineNumber()+'---'+ex.getMessage());
        }    
    }  
    
    global void finish(Database.BatchableContext bc) { }
    
}