global class batchEnvioEDC implements Database.Batchable<sObject>, Database.AllowsCallouts{
    
    
    global batchEnvioEDC(){
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('select Contador_EDC__c, id from Autonumerico_cuentas_Syste__c');
    }
    
    global void execute(Database.BatchableContext bc, List<sObject> scope) {
        for(Sobject s : scope){
            Autonumerico_cuentas_Syste__c c = (Autonumerico_cuentas_Syste__c)s;
            c.Contador_EDC__c ++;
            if([select count() from Correo_estado_cuenta__c where enviado__C = false ] > 0){
                boolean d = EnvioCorreosEDC.enviarCorreos();
            }
            update c;
        }
    } 
    
    global void finish(Database.BatchableContext bc) {
        decimal contador = [select count() from Correo_estado_cuenta__c where enviado__C=false];
        Autonumerico_cuentas_Syste__c c= [select Contador_EDC__c, id from Autonumerico_cuentas_Syste__c limit 1];
        if(contador > 0 && c.Contador_EDC__c <48){ // DESARROLLO
       //if(contador > 0 && c.Contador_EDC__c <100){ // PRODUCCIÓN
            batchEnvioEDC l = new batchEnvioEDC();
            Id batchprocessid = Database.executeBatch(l,1);
        }else {
            c.Contador_EDC__c = 0;
            update c;
        }
    }
}