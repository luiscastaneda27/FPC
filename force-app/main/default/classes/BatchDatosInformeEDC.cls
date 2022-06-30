global without sharing class BatchDatosInformeEDC implements Database.Batchable<sObject>, Database.AllowsCallouts{
    
    public DateTime desde;
    public DateTime hasta;
    
    global BatchDatosInformeEDC(DateTime desde, DateTime hasta){
        this.desde = desde;
        this.hasta = hasta;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('Select AccountId,Id, EmailBouncedReason, IsEmailBounced,'+
                                        ' (Select Id, CreatedDate,FirstOpenDate,LastOpenDate,TimesOpened,Task.WhatId  '+
                                        ' From EmailStatuses '+
                                        ' where Task.Subject = \'Correo electrónico: Estado de cuenta.\' and Task.WhatId = null),' +
                                        ' (Select Id,CreatedDate,FPC_Error__c from Errores_Estados_De_Cuentas__r)'+
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
                if((desde != null && emstat.CreatedDate < desde) || (hasta != null && emstat.CreatedDate > hasta.addDays(1)) ){
                    continue;
                }
                InformeEDC__c informeEDC  = new InformeEDC__c ();
                informeEDC.IdExterno__c = emstat.Id;
                informeEDC.Cliente__C = contacto.AccountId;
                informeEDC.FechaEnvio__c = emstat.CreatedDate;
                informeEDC.FechaQueSeAbrio__c = emstat.FirstOpenDate;
                informeEDC.UltimaFechaQueSeAbrio__c = emstat.LastOpenDate;
                informeEDC.NumeroVecesQueSeAbrio__c = emstat.TimesOpened;
                informeEDC.FPC_ErrorEnvio__c = contacto.IsEmailBounced ? contacto.EmailBouncedReason : null;
                listInformeEDC.add(informeEDC);
                break;
                
            }
            for(FPC_ErroresEstadosDeCuenta__c item : contacto.Errores_Estados_De_Cuentas__r){
                if((desde != null && item.CreatedDate < desde) || (hasta != null && item.CreatedDate > hasta.addDays(1)) ){
                    continue;
                }
                InformeEDC__c informeEDC  = new InformeEDC__c ();
                informeEDC.IdExterno__c = item.Id;
                informeEDC.Cliente__c = contacto.AccountId;
                informeEDC.FechaEnvio__c = item.CreatedDate;
                informeEDC.FPC_ErrorEnvio__c = item.FPC_Error__c;
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