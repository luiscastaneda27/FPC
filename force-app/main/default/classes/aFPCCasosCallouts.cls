public class aFPCCasosCallouts {
    
    @future(callout=true)
    public static void callSevicio(){
        try{
            Case caso = [Select id from case where Status='Nuevo' limit 1];
            SolicitudCaso solicitud = AFPCCasos.upsertCaso(caso);        
            for(CronTrigger item : [SELECT id FROM CronTrigger where CronJobDetail.Name = 'Job Casos']){
                System.abortJob(item.id);
            }
            Datetime fecha = Datetime.now();
            fecha = fecha.addHours(Integer.valueOf(Label.HorasServicioCasos));
            String acron = fecha.second()+' '+fecha.minute()+' '+fecha.hour()+' '+fecha.day()+' '+fecha.month()+' ? '+fecha.year();
            System.schedule('Job Casos', acron, new JobCasos());
            if(!solicitud.solicitudExitosa || test.isRunningTest()){
                List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {'luis.castaneda@intellectsystem.net'});
                mail.setSubject('Falló el servicio '+Datetime.now().format());
                mail.setPlainTextBody('Buen día, se notifica que el servicio de casos falló \n\n.'+solicitud.error);
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
                MessageList.add(mail); 
                Messaging.sendEmail(MessageList,false);
            }
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
    }

}