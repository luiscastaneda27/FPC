public class CTRL_CallCardServiceFicohsa {
    
    public static Boolean enviarSolicitud;
    public static String caseId;
    public static Set<Id> caseIds = new Set<Id>();
    public static String tipoGestion;
    
	@Future(callout=true)
    public static void callServiceRegional(String caseId, String tipoGestion) {
        List<Detalle_caso__c> detCaso = [SELECT Id,Caso__c,Caso__r.CaseNumber,Caso__r.Status,Nuevo_canal_aporte__c,Caso__r.Tipo_de_Operacion__c,
            Caso__r.Account.Name,Caso__r.Account.Identificacion__c,DAU_Dia_de_pago__c,Caso__r.DAU_Identidad__c,Caso__r.Respuesta_SF_Tarjetas__c,
            Cuenta__r.Seguro_Vida__c,Cuenta__r.CurrencyIsoCode,N_Cuenta_Bancaria__c,Caso__r.DAU_No_Cuenta__c,Cuenta__r.Name,Cuenta__r.Fecha_Aporte__c,
            Cuenta__r.Codigo__c,
            Cuenta__r.Monto_aporte__c,Nueva_fecha_aporte__c,Nuevo_monto_aporte__c,CreatedDate,Caso__r.Account.Pais_Residencia__c,Tipo_Operacion__c,
            DAU_Borrar_Cuotas__c from Detalle_caso__c Where Caso__r.Id =: caseId];
            system.debug('tipoGestion: '+tipoGestion);
        String Afiliacion, CodigoError, estadoGestion, Gestion;
        List<Case> searchCase = new List<Case>();
        List<Case> updateCase = new List<Case>();
        try {
            //Entra a llamar a servicios de Tarjeta Ficohsa Regional
            enviarSolicitud = false;
            String Comentarios = '';
            String MotivoBaja = '';
            String identidad,moneda;
            Integer diaPago;
            String DAU_EndPoint, DAU_Usuario, DAU_Contrasenia; //DAU_Token;
            String tipoSubProducto, cuenta;
            Decimal Dias, monto = 0;
            
            Parametros_DAU__mdt[] mdt = [SELECT Id,DeveloperName,DAU_Usuario__c,DAU_Contrasenia__c,DAU_Token__c,DAU_Dias__c,DAU_EndPoint__c
                                         FROM Parametros_DAU__mdt];
            
            List<Detalle_caso__c> newListDet = new List<Detalle_caso__c>();
            
            for(Parametros_DAU__mdt m : mdt) {
                if(m.DeveloperName == 'Parametro_dias') {
                    Dias = m.DAU_Dias__c;   
                }
                if(m.DeveloperName == 'Salesforce_regional_login') {
                    DAU_EndPoint = m.DAU_EndPoint__c;
                    DAU_Usuario = m.DAU_Usuario__c; 
                    DAU_Contrasenia = m.DAU_Contrasenia__c + m.DAU_Token__c; 
                    //DAU_Token = m.DAU_Token__c;    
                }
            }
            
            //Validando la fecha
            Date fechaComparacion, fechaComparacion2;
            for(Detalle_caso__c dt : detCaso) {
                if(tipoGestion == 'ALTA') {
                    if((dt.Tipo_Operacion__c == 'A3' || dt.Tipo_Operacion__c == 'A8') && dt.Caso__r.Respuesta_SF_Tarjetas__c != Null) {
                        enviarSolicitud = false;  
                    } else if(dt.Tipo_Operacion__c == 'A6' && dt.Caso__r.Respuesta_SF_Tarjetas__c.contains('Afiliación')) {
                        enviarSolicitud = false;
                    } else { 
                        if(dt.Tipo_Operacion__c == 'A6') {
                            fechaComparacion = dt.Cuenta__r.Fecha_Aporte__c.addDays(-Integer.ValueOf(Dias));
                        } else {
                            fechaComparacion = dt.Nueva_fecha_aporte__c.addDays(-Integer.ValueOf(Dias));
                        }
                        if(fechaComparacion <= Date.Today()) {
                            enviarSolicitud = true;
                            newListDet.add(dt);
                        }
                    }   
                } else if(tipoGestion == 'BAJA') {
                    if(dt.Tipo_Operacion__c == 'A6' && dt.Caso__r.Respuesta_SF_Tarjetas__c != Null) {
                        enviarSolicitud = false;    
                    } else if(dt.Tipo_Operacion__c == 'A7' && dt.Caso__r.Respuesta_SF_Tarjetas__c != Null && (dt.Caso__r.Respuesta_SF_Tarjetas__c.contains('Error') || dt.Caso__r.Respuesta_SF_Tarjetas__c.contains('System.ListException') || dt.Caso__r.Respuesta_SF_Tarjetas__c.contains('Class.WS_DAU_Pensiones') || dt.Caso__r.Respuesta_SF_Tarjetas__c.contains('System.DmlException'))) {
                        enviarSolicitud = false;    
                    } else {
                        enviarSolicitud = true;
                        newListDet.add(dt);    
                    }
                } else {
                    enviarSolicitud = true; 
                    newListDet.add(dt);
                }  
            }
            //System.debug('enviarSolicitud: '+enviarSolicitud);
            if(enviarSolicitud == true) {
                for(Detalle_caso__c dt : newListDet) {
                    if(dt.Cuenta__r.Seguro_Vida__c == true) {
                        tipoSubProducto = 'Pensiones y Cesantías - Seguro de Vida ';
                    } else {
                        tipoSubProducto = 'Pensiones y Cesantías - Personal Ordinario ';       
                    }
                    
                    if(dt.Cuenta__r.CurrencyIsoCode == 'HNL') {
                        moneda = 'L';    
                    } else if(dt.Cuenta__r.CurrencyIsoCode == 'USD') {
                        moneda = '$';
                    } 
                    if(tipoGestion == 'ALTA') {
                        if(dt.Tipo_Operacion__c == 'A6' && !dt.Caso__r.Respuesta_SF_Tarjetas__c.contains('Afiliación')) {
                            cuenta = dt.Caso__r.DAU_No_Cuenta__c;
                            diaPago = Integer.valueof(dt.DAU_Dia_de_pago__c);
                        } else {
                            cuenta = dt.Caso__r.DAU_No_Cuenta__c;
                            diaPago = dt.Nueva_fecha_aporte__c.day();
                        }
                        monto = dt.Nuevo_monto_aporte__c;
                    } else if(tipoGestion == 'MOD') {
                        if(dt.Tipo_Operacion__c == 'A4') {
                            diaPago = dt.Nueva_fecha_aporte__c.day();
                            monto = dt.Cuenta__r.Monto_aporte__c;
                        } else if(dt.Tipo_Operacion__c == 'A7') {
                            monto = dt.Cuenta__r.Monto_aporte__c;
                        } else {    
                            diaPago = dt.Cuenta__r.Fecha_Aporte__c.day();
                            monto = dt.Nuevo_monto_aporte__c;
                        }
                        cuenta = dt.Caso__r.DAU_No_Cuenta__c;
                    } else if(tipoGestion == 'BAJA') {
                        if(dt.Cuenta__r.Fecha_Aporte__c == Null) {
                            diaPago = 0;    
                        } else {
                            diaPago = dt.Cuenta__r.Fecha_Aporte__c.day();
                        }    
                        cuenta = dt.Caso__r.DAU_No_Cuenta__c;
                        if(dt.Cuenta__r.Monto_aporte__c != Null) {
                            monto = dt.Cuenta__r.Monto_aporte__c;
                        } else {
                            monto = 0;
                        }
                        Comentarios = 'Se Cancela la Afiliación';
                        MotivoBaja = 'Proceso de Cancelación';
                    } else {                        
                        diaPago = Integer.valueOf(dt.DAU_Dia_de_pago__c);
                    }
                    
                    //partnerSoapSforceCom.Soap con = new partnerSoapSforceCom.Soap(); System.debug('Contraseña: '+DAU_Contrasenia);
                    //partnerSoapSforceCom.LoginResult loginResult = con.login(DAU_Usuario, DAU_Contrasenia); System.debug('loginResult: '+loginResult);
                    String sessionId = HPR_getToken.getToken(DAU_EndPoint, DAU_Usuario, DAU_Contrasenia);
                    
                    for(Parametros_DAU__mdt m : mdt) {
                        if(m.DeveloperName == 'Salesforce_regional_afiliacion') {
                            DAU_EndPoint = m.DAU_EndPoint__c;   
                        }
                    }
                    
                    http http = new Http();
                    HttpRequest request = new HttpRequest();
                    request.setEndpoint(DAU_EndPoint);
                    request.setMethod('POST');
                    request.setHeader('Content-Type', 'text/xml');
                    request.setHeader('SOAPAction','action');
                    request.setTimeout(120000);
                    System.debug('sessionId: '+sessionId); 
                    String SOAPXML = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ws="http://soap.sforce.com/schemas/class/WS_DAU_Pensiones">\n';
                    SOAPXML += '<soapenv:Header>\n';
                    SOAPXML += '<ws:SessionHeader>\n';
                    SOAPXML += '<ws:sessionId>'+sessionId+'</ws:sessionId>\n';
                    SOAPXML += '</ws:SessionHeader>\n';
                    SOAPXML += '</soapenv:Header>\n';        
                    SOAPXML += '<soapenv:Body>\n';
                    SOAPXML += '<ws:GestionDAU>\n';
                    SOAPXML += '<ws:Identidad>'+dt.Caso__r.DAU_Identidad__c+'</ws:Identidad>\n';
                    //SOAPXML += '<ws:Identidad>1621199800245</ws:Identidad>\n';
                    SOAPXML += '<ws:Cuenta>'+cuenta+'</ws:Cuenta>\n';
                    //SOAPXML += '<ws:Cuenta>50009531998656</ws:Cuenta>\n';
                    SOAPXML += '<ws:SubProducto>'+tipoSubProducto+moneda+'</ws:SubProducto>\n';
                    //SOAPXML += '<ws:SubProducto>Pensiones y Cesantías - Personal Ordinario L</ws:SubProducto>\n';                                     
                    SOAPXML += '<ws:NumReferencia>'+dt.Cuenta__r.Codigo__c+'</ws:NumReferencia>\n';
                    //SOAPXML += '<ws:NumReferencia>222355</ws:NumReferencia>\n';
                    SOAPXML += '<ws:DiaPago>'+diaPago+'</ws:DiaPago>\n';
                    //SOAPXML += '<ws:DiaPago>14</ws:DiaPago>\n';
                    SOAPXML += '<ws:Moneda>'+dt.Cuenta__r.CurrencyIsoCode+'</ws:Moneda>\n';
                    //SOAPXML += '<ws:Moneda>HNL</ws:Moneda>\n';
                    SOAPXML += '<ws:Monto>'+monto+'</ws:Monto>\n';
                    //SOAPXML += '<ws:Monto>100.0</ws:Monto>\n';
                    SOAPXML += '<ws:Pais>'+dt.Caso__r.Account.Pais_Residencia__c+'</ws:Pais>\n';
                    //SOAPXML += '<ws:Pais>HONDURAS</ws:Pais>\n';
                    SOAPXML += '<ws:Comentarios>'+Comentarios+'</ws:Comentarios>\n';
                    //SOAPXML += '<ws:Comentarios></ws:Comentarios>\n';
                    SOAPXML += '<ws:MotivoBaja>'+MotivoBaja+'</ws:MotivoBaja>\n';
                    //SOAPXML += '<ws:MotivoBaja></ws:MotivoBaja>\n';
                    SOAPXML += '<ws:TipoGestion>'+tipoGestion+'</ws:TipoGestion>\n';
                    //SOAPXML += '<ws:TipoGestion>ALTA</ws:TipoGestion>\n';
                    SOAPXML += '</ws:GestionDAU>\n';
                    SOAPXML += '</soapenv:Body>\n';
                    SOAPXML += '</soapenv:Envelope>';
            
                    System.debug(SOAPXML);
            
                    request.setBody(SOAPXML);
                    HttpResponse response = http.send(request);
                         
                    System.debug('La respuesta es: '+response.getBody());
                     
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
                            if ('faultstring' == reader.getLocalName()) { //if the tag is faultstring result
                                while(reader.hasNext()) { //while there are more XML events
                                    if (reader.getEventType() == XmlTag.END_ELEMENT) { //if this is the closing tag
                                        break; //exist the loop
                                    } else if (reader.getEventType() == XmlTag.CHARACTERS) { //if this is the content between the tags
                                        CodigoError = reader.getText(); //grab the content
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
                    
                    caseIds.add(dt.Caso__c);
                }    
            }

            searchCase = [Select Id, Respuesta_SF_Tarjetas__c, Tipo_de_Operacion__c From Case Where Id In : caseIds limit 1];

            if(caseIds.size() > 0) { 
                
                List<Detalle_caso__c> detcaso2 = [SELECT Id,Caso__c,Caso__r.CaseNumber,DAU_Borrar_Cuotas__c,
                                                         Caso__r.Respuesta_SF_Tarjetas__c,Tipo_Operacion__c 
                                                         From Detalle_caso__c Where Caso__r.Id =: searchCase[0].Id limit 1];
                for(Case cs : searchCase) { 
                    
                    if(tipoGestion == 'BAJA') {
                        cs.Respuesta_SF_Tarjetas__c = 'Cancelación:\n'+ Afiliacion + '\n' + CodigoError + '\n' + estadoGestion + '\n' + Gestion;
                    } else if(tipoGestion == 'ALTA' && cs.Tipo_de_Operacion__c == 'A6' && cs.Respuesta_SF_Tarjetas__c != Null && cs.Respuesta_SF_Tarjetas__c.contains('Cancelación')) {
                        cs.Respuesta_SF_Tarjetas__c = cs.Respuesta_SF_Tarjetas__c + '\n \n Afiliación: \n' + Afiliacion + '\n' + CodigoError + '\n' + estadoGestion + '\n' + Gestion;
                        if(cs.Respuesta_SF_Tarjetas__c.contains('Afiliación')) {
                            if(detcaso2[0].DAU_Borrar_Cuotas__c == '2' || detcaso2[0].DAU_Borrar_Cuotas__c == '3') { SYstem.debug('Entra 2');
                                System.debug('detcaso2[0].Caso__r.Id: '+detcaso2[0].Caso__r.Id);
                                List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                                Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = detcaso[0].Caso__r.Id, DAU_Borrar_Cuotas_S10__c = true));
                                // Call method to publish events
                                List<Database.SaveResult> results = EventBus.publish(Logs);
                            } else {
                                List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                                Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = detcaso[0].Caso__r.Id, DAU_EjecutarSYSDE__c = true));
                                // Call method to publish events
                                List<Database.SaveResult> results = EventBus.publish(Logs); 
                            } 
                        }
                    } else if(CodigoError != null && (CodigoError.contains('Error') || CodigoError.contains('System.ListException'))) {
                        cs.Respuesta_SF_Tarjetas__c = CodigoError;
                    } else if(CodigoError.contains('Class.WS_DAU_Pensiones.GestionDAU')) {
                        cs.Respuesta_SF_Tarjetas__c = 'La tarjeta ya se encuentra afiliada. Error devuelto por el servicio: ' + CodigoError;
                    } else if(Gestion == Null) { 
                        cs.Respuesta_SF_Tarjetas__c = Afiliacion + '\n' + CodigoError + '\n' + estadoGestion;    
                    } else {
                        cs.Respuesta_SF_Tarjetas__c = Afiliacion + '\n' + CodigoError + '\n' + estadoGestion + '\n' + Gestion;
                    } 
                    cs.Respuesta_SF_Tarjetas__c = String.isNotBlank(cuenta) ? cs.Respuesta_SF_Tarjetas__c : null; 
                    updateCase.add(cs);
                }
                
                Database.SaveResult[] srListCase = Database.update(updateCase, false);
    
                // Iterate through each returned result
                for(Database.SaveResult sr : srListCase) {
                    if (sr.isSuccess()) {
                        // Operation was successful, so get the ID of the record that was processed
                        System.debug('Successfully update case. Case ID: ' + sr.getId());

                        for(Detalle_caso__c dt : detcaso) {
                            if(tipoGestion == 'ALTA' && (dt.Tipo_Operacion__c == 'A3' || dt.Tipo_Operacion__c == 'A8')) {
                                if(detcaso[0].DAU_Borrar_Cuotas__c == '2' || detcaso[0].DAU_Borrar_Cuotas__c == '3') {
                                    System.debug('detcaso[0].Caso__r.Id: '+detcaso[0].Caso__r.Id);
                                    List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                                    Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = detcaso[0].Caso__r.Id, DAU_Borrar_Cuotas_S10__c = true));
                                    // Call method to publish events
                                    List<Database.SaveResult> results = EventBus.publish(Logs);
                                } else {
                                    List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                                    Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = detcaso[0].Caso__r.Id, DAU_EjecutarSYSDE__c = true));
                                    // Call method to publish events
                                    List<Database.SaveResult> results = EventBus.publish(Logs); 
                                } 
                            } else if(tipoGestion == 'Baja' && dt.Tipo_Operacion__c == 'A6') { 
								List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                                Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = detcaso[0].Caso__r.Id, DAU_PrimerServicio__c = true));
                                // Call method to publish events
                                List<Database.SaveResult> results = EventBus.publish(Logs);                                
                            } else if(dt.DAU_Borrar_Cuotas__c == '2' || dt.DAU_Borrar_Cuotas__c == '3') {
                                List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                                Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = dt.Caso__r.Id, DAU_Borrar_Cuotas_S10__c = true));
                                //Call method to publish events
                                List<Database.SaveResult> results = EventBus.publish(Logs);
                            } else {
                                List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                                Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = dt.Caso__r.Id, DAU_EjecutarSYSDE__c = true));
                                //Call method to publish events
                                List<Database.SaveResult> results = EventBus.publish(Logs); 
                            }   
                        }
                    }
                    else {
                        // Operation failed, so get all errors                
                        for(Database.Error err : sr.getErrors()) {
                            System.debug('The following error has occurred.');                    
                            System.debug(err.getStatusCode() + ': ' + err.getMessage());
                            System.debug('Case fields that affected this error: ' + err.getFields());
                        }
                    }
                }               
            } 
        } catch(Exception ex) {
            System.debug('Error en servicio de tarjeta regional: '+ex.getLineNumber()+'---'+ex.getMessage());
            /*for(Case cs : searchCase) {
                cs.Respuesta_SF_Tarjetas__c = ex.getLineNumber()+'---'+ex.getMessage();
                updateCase.add(cs);
            }
            update updateCase;*/
        }  
        
    }
}