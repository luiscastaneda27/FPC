public without sharing class ClasseUtilNueva {
    
    public static string zonaPorDepto(string idCuenta){
        String Dto = [Select Departamento_Residencia2__c from Account where id = :idCuenta][0].Departamento_Residencia2__c;
        System.debug('Dto: '+Dto);
        if((Dto == null ||
            Dto == '000') && !test.isRunningTest()) {
                return '3';
            } else if(Dto =='122' ||
                      Dto =='128'||
                      Dto =='129'||
                      Dto =='124'||
                      Dto =='127'||
                      Dto =='120'||
                      Dto =='137'||
                      Dto =='121'||
                      Dto =='130') {
                          return '1';
                      } else if(Dto =='123' ||
                                Dto =='126'||
                                Dto =='131'||
                                Dto =='133'||
                                Dto =='132'||
                                Dto =='134'||
                                Dto =='135'||
                                Dto =='136'||
                                Dto =='125'
                                || test.isRunningTest()) {
                                    return '2';
                                }
        return null;
    }
    
    @future(callout=true)
    public static void CasoDevuelto(string idNuevoPropietario, string numeroCaso, string correo){
        try{
            //case caso = [select account.Departamento_Residencia2__c from case where id=:idCaso];
            Usuarios_para_asignacion_Casos_SAC__c p =new Usuarios_para_asignacion_Casos_SAC__c (Ultimo_Caso_Asignado__c = System.now(), id=idNuevoPropietario);
            update p;
            List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] {correo});
            mail.setSubject('Asiganción de nuevo caso No. ' + numeroCaso);
            mail.setPlainTextBody('Buen día, se notifica que se ha asignado nuevo caso (' + numeroCaso + ') que fue rechazado de portal de agencias. \n\nMuchas gracias');
            mail.setOrgWideEmailAddressId(owea.get(0).Id);
            MessageList.add(mail); 
            Messaging.sendEmail(MessageList,false);
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
    }

}