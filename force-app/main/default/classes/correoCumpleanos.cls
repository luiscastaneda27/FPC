global class correoCumpleanos implements Schedulable{
    global void execute(SchedulableContext SC){
    
        Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
        Date hoy = date.today();  
        String finalCump = hoy.day() + '-' + hoy.month();
        
        try{        
            list<Account> clientes = [SELECT Name,Correo_actual__c, PersonContactId  
                                      FROM Account
                                    WHERE recordType.DeveloperName = 'Natural' AND 
                                    Receive_Birthday_Emails__pc = True AND
                                    Nacimiento__c =: finalCump AND Correo_actual__c != null];  
        
            if(!clientes.isEmpty()){
                EmailTemplate Emailtemplate=[SELECT ID FROM EmailTemplate where DeveloperName =:'Correo_Felicidades'];
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
                
                for(Account item : clientes){
                   String[] toAddresses = new String[] {item.Correo_actual__c};
                   
                   Messaging.singleEmailMessage correo = new Messaging.singleEmailMessage();            
                   correo.setTemplateId(Emailtemplate.id);  
                   correo.saveAsActivity = false;    
                   correo.setTreatTargetObjectAsRecipient(false); 
                   correo.setToAddresses(toAddresses);  
                   correo.setTargetObjectId(item.PersonContactId);
                   correo.setOrgWideEmailAddressId(owea.get(0).Id);
                   listCorreo.add(correo);              
                }
                
                Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo);
                            
            }
        }Catch(Exception e){}
    }
    
}