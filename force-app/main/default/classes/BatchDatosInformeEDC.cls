global without sharing class BatchDatosInformeEDC implements Database.Batchable<sObject>, Database.AllowsCallouts{
    
    public DateTime desde;
    public DateTime hasta;
    
    global BatchDatosInformeEDC(DateTime desde, DateTime hasta){
        this.desde = desde;
        this.hasta = hasta;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('Select AccountId,Id, '+
            ' (Select Id, CreatedDate,FirstOpenDate,LastOpenDate,TimesOpened,Task.WhatId  '+
            ' From EmailStatuses '+
            ' where Task.Subject = \'Correo electrónico: Estado de cuenta.\' and Task.WhatId = null)' +
            ' From Contact  ');
    }
    
    global void execute(Database.BatchableContext bc, List<sObject> scope) {
        List<InformeEDC__c > listInformeEDC  = new List<InformeEDC__c >();
        List<String> listTareas = new  List<String>();
        for(Object s: scope){
            Contact contacto = (Contact) s;
            List<EmailStatus> ES = new List<EmailStatus>();
            ES = !test.isRunningTest() ?  contacto.EmailStatuses : getEmailStatus();
            for(EmailStatus emstat : ES){
                listTareas.add(emstat.TaskId);
            }
        }
        for(Object s: scope){
            
            Contact contacto = (Contact) s;
            List<EmailStatus> ES = new List<EmailStatus>();
            ES = !test.isRunningTest() ?  contacto.EmailStatuses : getEmailStatus();
            
            for(EmailStatus emstat : ES){
                if((desde != null && emstat.CreatedDate < desde) || (hasta != null && emstat.CreatedDate > hasta) ){
                    continue;
                }
                InformeEDC__c informeEDC  = new InformeEDC__c ();
                informeEDC.IdExterno__c = emstat.Id;
                informeEDC.Cliente__C = contacto.AccountId;
                informeEDC.FechaEnvio__c = emstat.CreatedDate;
                informeEDC.FechaQueSeAbrio__c = emstat.FirstOpenDate;
                informeEDC.UltimaFechaQueSeAbrio__c = emstat.LastOpenDate;
                informeEDC.NumeroVecesQueSeAbrio__c = emstat.TimesOpened;
                listInformeEDC.add(informeEDC);
                break;
                
            }
        }
        Database.upsert(listInformeEDC, InformeEDC__c.IdExterno__c, false);
       
    } 
    
    global void finish(Database.BatchableContext bc) {
        
    }
    
    public static List<EmailStatus> getEmailStatus(){
        String body = '[ { "WhoId": "0035400000JsVB3AAN", "Id": "01854000000vCrPAAU","CreatedDate": "2020-07-28T11:42:14.000+0000" ,"FirstOpenDate": "2020-07-28T19:42:14.000+0000", "LastOpenDate": "2020-07-28T19:42:14.000+0000", "TimesOpened": 1 } ]';
        return (List<EmailStatus>)System.JSON.deserialize(body, List<EmailStatus>.class);
    }
}