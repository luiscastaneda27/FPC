global with sharing class JobEDC implements Schedulable { 
    global void execute(SchedulableContext ctx) {
        decimal contador = [select count() from Correo_estado_cuenta__c where enviado__C=false];
        if(contador > 0){
            Database.executeBatch(new batchEnvioEDC(), 1);
        }
    }
}