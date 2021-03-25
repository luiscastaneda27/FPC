@RestResource(urlMapping='/Case/*')
global without sharing class RestCasos {
    
    @HttpPost
    global static SolicitudCaso doPost(Case caso, Boolean solicitudExitosa, String error) {
        SolicitudCaso solicitud = new SolicitudCaso();
        try{ 
            solicitud.solicitudExitosa = true;
            if(caso.Status == 'Cerrado' && Caso.Id != null){
                Case casoJob = [SELECT CaseNumber,Id,Status,CerrarCasoJob__c FROM CASE WHERE Id = :Caso.Id];
                casoJob.CerrarCasoJob__c = true;
                update CasoJob;
                caso.Status = CasoJob.Status;
                upsert caso;
                caso.Status = 'Cerrado';
                Datetime fecha = Datetime.now().addSeconds(15);
                String acron = fecha.second()+' '+fecha.minute()+' '+fecha.hour()+' '+fecha.day()+' '+fecha.month()+' ? '+fecha.year();
                CronClass.deleteCron('CerrarCasos');
                System.schedule('CerrarCasos', acron, new JobCerrarCaso());
            }else{
                upsert caso;
            }
            
            solicitud.caso = caso;
        }catch(Exception ex){
            solicitud.caso = caso;
            solicitud.solicitudExitosa = false;
            solicitud.error = ex.getMessage();
        }
        return solicitud; 
    }
    
    
    @HttpGet
    global static SolicitudCaso doGet() {
        SolicitudCaso solicitud = new SolicitudCaso();
        String body;
        try{ 
            solicitud.solicitudExitosa = true;
            RestRequest req = RestContext.request;
            RestResponse res = RestContext.response;
            body =  req.requestURI;
            List<String> listCaso = body.replace('/Case/', '').split('/');
            system.debug('Lo que llego: '+req.requestURI);
            Approval.ProcessSubmitRequest req2 = new Approval.ProcessSubmitRequest();
            req2.setObjectId(listCaso[0]);
            req2.setProcessDefinitionNameOrId(listCaso[1]);
            Approval.ProcessResult result = Approval.process(req2);
        }catch(Exception ex){
            solicitud.solicitudExitosa = false;
            solicitud.error = ex.getMessage() +'   '+body;
        }
        return solicitud;
    }

}