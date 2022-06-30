public without sharing class FPC_ClaseUtilEDC {
    
    public static void notificacionFinEnvioEDC(Decimal numeroCorreos){
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
        Boolean esTrimestral = (Date.today().month() == 1 || Date.today().month() == 4 || Date.today().month() == 7 || Date.today().month() == 10);
        String tipoEnvio = esTrimestral ? 'trimestre' : 'mes';
        Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
        email.setSubject('Finalizado proceso de envío de Estado de Cuenta '+date.today().format()); 
        email.setToAddresses(Label.FPC_CorreosInicioFinProcesoEDC.split(','));
        email.setPlainTextBody('Buen día, \n\n Se notifica que se ha terminado el proceso de envio de estados de cuenta de este '+tipoEnvio+', con un total de correos exitosos de: '+numeroCorreos.format());
        email.setOrgWideEmailAddressId(owea.get(0).Id);
        Messaging.SingleEmailMessage[] listEmail = new List<Messaging.SingleEmailMessage>(); 
        listEmail.add(email); 
        system.debug('Tamano de lista: '+listEmail.size());
        Messaging.sendEmail(listEmail, false); 
    }
    
    public static void notificacionInicioEnvioEDC(){
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
        Boolean esTrimestral = (Date.today().month() == 1 || Date.today().month() == 4 || Date.today().month() == 7 || Date.today().month() == 10);
        String tipoEnvio = esTrimestral ? 'trimestre' : 'mes';
        Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
        email.setSubject('Iniciando proceso de envío de Estado de Cuenta '+date.today().format()); 
        email.setToAddresses(Label.FPC_CorreosInicioFinProcesoEDC.split(','));
        email.setPlainTextBody('Buen día, \n\n Se notifica que el día de mañana se inicia el proceso de envío de estados de cuenta de este '+tipoEnvio+'.\n\n Muchas gracias ');
        email.setOrgWideEmailAddressId(owea.get(0).Id);
        Messaging.SingleEmailMessage[] listEmail = new List<Messaging.SingleEmailMessage>(); 
        listEmail.add(email); 
        system.debug('Tamano de lista: '+listEmail.size());
        Messaging.sendEmail(listEmail, false); 
    }
}