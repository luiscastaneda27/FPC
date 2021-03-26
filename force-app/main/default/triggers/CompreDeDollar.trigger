trigger CompreDeDollar on Planilla__c (after update) {
    try{
    List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
     OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
     Planilla__c planilla = trigger.new[0];
     if(planilla.Tasa_compra__c==0 && planilla.Estado2__c=='Pendiente Aprobación Ficohsa')
     {
         string nombreEmpresa =[select name from Account where id=:planilla.Empresa2__c].name;
         list<correos__c> correos = new list<Correos__C>();
         correos =[select correo__c,name from correos__C where cargo__c='Aprobación de Planillas'];
         for(integer i=0; i<correos.size(); i++)
         {
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {correos[i].correo__c});
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
                mail.setSenderDisplayName('FICOHSA PENSIONES Y CESANTíAS');
                mail.setSubject('Portal Empresarial Ficohsa');
                mail.setPlainTextBody('Buen día ' + correos[i].Name +'.\n\n La empresa ' +nombreEmpresa +
                                     ' ha subido una planilla y requiere que se le compren los dolares. \n\n Muchas Gracias.' );
                MessageList.add(mail);  
             system.debug('Enviado Corectamente');
         }
          Messaging.sendEmail(MessageList);
         system.debug('Enviado Corectamente 2');
     }
    }catch(Exception ex)
    {
        system.debug(ex.getMessage()+'    '+ex.getLineNumber());
    }
    
}