/**
*Class Name: BAT_CallCardServiceFicohsa
*Description: Clase Batch que llama al servicio de Salesforce Regional para Afiliar, Modificar, Cancelar Aportes. (Se ejecuta cuando el caso de cierra).
*Created Date: 2/12/2022 04:20 PM
*Created By: Cloud Code   
*Last Modified by: Cloud Code 01/02/2023 12:12 PM
*/
global class BAT_CallCardServiceFicohsa implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts {
    
    global Boolean enviarSolicitud;
    global List<Case> caseList = new List<Case>();
    global String caseId;
    global Set<Id> caseIds = new Set<Id>();
    global String tipoGestion;
    
    global BAT_CallCardServiceFicohsa(List<Detalle_caso__c> lstDetCase, String tipoGestion) {
        for(Detalle_caso__c dc : lstDetCase){
            caseId = dc.Caso__c;
        }
        this.tipoGestion = tipoGestion;
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {    System.debug('El Id Caso es: '+caseId);  
        return Database.getQueryLocator([SELECT Id,Caso__c,Caso__r.CaseNumber,Caso__r.Status,Nuevo_canal_aporte__c,Caso__r.Tipo_de_Operacion__c,
            Caso__r.Account.Name,Caso__r.Account.Identificacion__c,DAU_Dia_de_pago__c,Caso__r.DAU_Identidad__c,Caso__r.Respuesta_SF_Tarjetas__c,
            Cuenta__r.Seguro_Vida__c,Cuenta__r.CurrencyIsoCode,N_Cuenta_Bancaria__c,Caso__r.DAU_No_Cuenta__c,Cuenta__r.Name,Cuenta__r.Fecha_Aporte__c,
            Cuenta__r.Monto_aporte__c,Nueva_fecha_aporte__c,Nuevo_monto_aporte__c,CreatedDate,Caso__r.Account.Pais_Residencia__c
            From Detalle_caso__c Where Caso__r.Id =: caseId]);
    }
    
    global void execute(Database.BatchableContext bc, List<Detalle_caso__c> scope) {
        String Afiliacion, CodigoError, estadoGestion, Gestion;
        List<Case> searchCase = new List<Case>();
        List<Case> updateCase = new List<Case>();
        try {
            //Entra a llamar a servicios de Tarjeta Ficohsa Regional
            enviarSolicitud = false;
            String Comentarios = '';
            String MotivoBaja = '';
            String identidad,moneda;
            Integer DiaPago;
            String DAU_EndPoint, DAU_Usuario, DAU_Contrasenia; //DAU_Token;
            String tipoSubProducto;
            Decimal Dias;
            
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
            for(Detalle_caso__c dt : scope) {
                if(tipoGestion == 'ALTA') {
                    fechaComparacion = dt.Nueva_fecha_aporte__c.addDays(-Integer.ValueOf(Dias));
                    if(fechaComparacion <= Date.Today()) {
                        enviarSolicitud = true;
                        newListDet.add(dt);
                    } else {
                        System.debug('No se llama al servicio de tarjetas regional');
                    }
                } else {
                    enviarSolicitud = true; newListDet.add(dt);
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
                    
                    if(tipoGestion == 'MOD') {
                        DiaPago = dt.Cuenta__r.Fecha_Aporte__c.day();
                    } else if(tipoGestion == 'BAJA') {
                        if(dt.Cuenta__r.Fecha_Aporte__c ==  Null) {
                            DiaPago = 0;    
                        } else {
                            DiaPago = dt.Cuenta__r.Fecha_Aporte__c.day();
                        }    
                        Comentarios = 'Se Cancela la Afiliación';
                        MotivoBaja = 'Proceso de Cancelación';
                    } else {                        
                        DiaPago = Integer.valueOf(dt.DAU_Dia_de_pago__c);
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
                    SOAPXML += '<ws:Cuenta>'+dt.Caso__r.DAU_No_Cuenta__c+'</ws:Cuenta>\n';
                    //SOAPXML += '<ws:Cuenta>50009531998656</ws:Cuenta>\n';
                    SOAPXML += '<ws:SubProducto>'+tipoSubProducto+moneda+'</ws:SubProducto>\n';
                    //SOAPXML += '<ws:SubProducto>Pensiones y Cesantías - Personal Ordinario L</ws:SubProducto>\n';                                     
                    SOAPXML += '<ws:NumReferencia>'+dt.Cuenta__r.Name+'</ws:NumReferencia>\n';
                    //SOAPXML += '<ws:NumReferencia>95905</ws:NumReferencia>\n';
                    SOAPXML += '<ws:DiaPago>'+DiaPago+'</ws:DiaPago>\n';
                    //SOAPXML += '<ws:DiaPago>14</ws:DiaPago>\n';
                    SOAPXML += '<ws:Moneda>'+dt.Cuenta__r.CurrencyIsoCode+'</ws:Moneda>\n';
                    //SOAPXML += '<ws:Moneda>HNL</ws:Moneda>\n';
                    SOAPXML += '<ws:Monto>'+dt.Nuevo_monto_aporte__c+'</ws:Monto>\n';
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
            if(caseIds.size() > 0) { 
                searchCase = [Select Id, Respuesta_SF_Tarjetas__c From Case Where Id In : caseIds]; 
                for(Case cs : searchCase) { 
                    if(CodigoError != null && (CodigoError.contains('Error') || CodigoError.contains('System.ListException'))) {
                        cs.Respuesta_SF_Tarjetas__c = CodigoError;
                    } else if(CodigoError.contains('Class.WS_DAU_Pensiones.GestionDAU')) {
                        cs.Respuesta_SF_Tarjetas__c = 'La tarjeta ya se encuentra afiliada. Error devuelto por el servicio: ' + CodigoError;
                    } else if(Gestion == Null) { 
                        cs.Respuesta_SF_Tarjetas__c = Afiliacion + '\n' + CodigoError + '\n' + estadoGestion;    
                    } else {
                        cs.Respuesta_SF_Tarjetas__c = Afiliacion + '\n' + CodigoError + '\n' + estadoGestion + '\n' + Gestion;
                    } 
                    updateCase.add(cs);
                }
                
                Database.SaveResult[] srListCase = Database.update(updateCase, false);
    
                // Iterate through each returned result
                for(Database.SaveResult sr : srListCase) {
                    if (sr.isSuccess()) {
                        // Operation was successful, so get the ID of the record that was processed
                        System.debug('Successfully update case. Case ID: ' + sr.getId());
                        List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                        Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = sr.getId(), DAU_EjecutarSYSDE__c = true));
                        // Call method to publish events
                        List<Database.SaveResult> results = EventBus.publish(Logs);
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
            for(Case cs : searchCase) {
                cs.Respuesta_SF_Tarjetas__c = ex.getLineNumber()+'---'+ex.getMessage();
                updateCase.add(cs);
            }
            update updateCase;
        }    
    }  
    
    global void finish(Database.BatchableContext bc) { }
    
}