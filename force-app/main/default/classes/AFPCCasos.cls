public class AFPCCasos {     
    
    
    
    public static SolicitudCaso envioAprobacion(String idCaso, String proceso) {
         SolicitudCaso envio = new SolicitudCaso();
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setTimeout(120000);
            String url = claseUtilPlanillas.urlSysde('Casos');
            request.setEndpoint(url +'/'+ idCaso+'/'+proceso);
            request.setMethod('GET');
            Blob headerValue = Blob.valueOf(Label.RestCasoSUser + ':' + Label.RestCasoSPassword);
            String authorizationHeader = 'BASIC ' +
                EncodingUtil.base64Encode(headerValue);
            request.setHeader('Authorization', authorizationHeader);
            HttpResponse response =new HttpResponse();
            if(!test.isRunningTest()){
                response = http.send(request);
            }
            else{
                Approval.ProcessSubmitRequest req2 = new Approval.ProcessSubmitRequest();
                req2.setObjectId(idCaso);
                req2.setProcessDefinitionNameOrId(proceso);
                Approval.ProcessResult result = Approval.process(req2);
                envio.solicitudExitosa= true;
                response.setBody(JSON.serialize(envio));
            }
            String body = response.getBody();
            system.debug('Respuesta: '+body);
            envio = (SolicitudCaso)System.JSON.deserialize(body, SolicitudCaso.class);
        }catch(Exception ex){
            envio.error = 'Error: '+ex.getMessage()+', Error: '+ex.getLineNumber();
            envio.solicitudExitosa= false;
            system.debug('Error: '+ex.getMessage()+', Error: '+ex.getLineNumber());
        }
        return envio;
    }
    
    public static SolicitudCaso upsertCaso(Case caso) {
        SolicitudCaso envio = new SolicitudCaso();
        try{
            envio.solicitudExitosa = true;
            envio.caso = caso;
            envio.error = null;
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String url = claseUtilPlanillas.urlSysde('Casos');
            request.setEndpoint(url);
            request.setMethod('POST');
            Blob headerValue = Blob.valueOf(Label.RestCasoSUser + ':' + Label.RestCasoSPassword);
            String authorizationHeader = 'BASIC ' +
                EncodingUtil.base64Encode(headerValue);
            request.setHeader('Authorization', authorizationHeader);
            request.setTimeout(120000);
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            String cons = json.serialize(envio);
            system.debug('Mandamos: '+cons);
            envio = new SolicitudCaso();
            request.setBody(cons);
            HttpResponse response = new HttpResponse();
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                upsert caso;
                envio.solicitudExitosa = true;
                envio.caso = caso;
                response.setBody(JSON.serialize(envio));
            }
            String body = response.getBody();
            system.debug('Respuesta: '+body);
            system.debug('Respuesta: '+response.getStatusCode());
            envio = (SolicitudCaso)System.JSON.deserialize(body, SolicitudCaso.class);
        }catch(Exception ex){
            envio.error = 'Error: '+ex.getMessage()+', Error: '+ex.getLineNumber();
            envio.caso = caso;
            envio.solicitudExitosa= false;
            system.debug('Error: '+ex.getMessage()+', Error: '+ex.getLineNumber());
        }
        return envio;
    }
    
    

}