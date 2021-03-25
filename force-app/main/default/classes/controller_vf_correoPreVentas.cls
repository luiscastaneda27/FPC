public with sharing class controller_vf_correoPreVentas {
    
    public task tarea{get;set;}
    public string idpre{get;set;}
    
    public controller_vf_correoPreVentas(){
        idpre = Apexpages.currentPage().getParameters().get('id');
        tarea = new task();
        
        PreVenta__c venta = [select id, Email__c from PreVenta__c where id =: idpre];
        
        tarea.Para1__c = venta.Email__c;
        tarea.De__c = [select email from user where id =: userinfo.getuserid()].email;
        
    }
    
    public PageReference guardar(){
        tarea.WhatId = idpre;
        
        string correos = '';
        if(tarea.Cc__c != null){
            correos = tarea.Para1__c + ',' + tarea.Cc__c;
        }
        else{
            correos = tarea.Para1__c;
        }
        
        
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();
        //correo individual
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] {correos };
            message.optOutPolicy = 'FILTER';
        message.subject = tarea.Subject; //Renovacion ' + b.Contacto__r.name;
        message.setHtmlBody(tarea.Cuerpo__c)  ; //'This is the message body.';        
        
        //agrega el correo a la lista de correos
        messages.add(message);
        
        //envia el correo
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        //valida si el envio fue exitoso o no
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: ' + results[0].errors[0].message);
        }
        
        
        insert tarea;
        PageReference myVFPage = new PageReference('/apex/vfPreVentasVer?id=' + idpre);
        myVFPage.setRedirect(true);
        return myVFPage;
    }
    
    
}