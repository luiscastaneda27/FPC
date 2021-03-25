global class batchCambioEstadoEDC implements Database.batchable<SObject>{ 
    
    global batchCambioEstadoEDC(){
    }
    
    global Iterable<SObject> start(Database.BatchableContext bc) {
        return Database.getQueryLocator('select  enviado__C, id from Correo_estado_cuenta__c where enviado__C=true  limit 9999');
    }
    
    global void execute(Database.BatchableContext bc, Correo_estado_cuenta__c[] scope) {
        for(Correo_estado_cuenta__c item: scope){
            item.enviado__C=false;
        } 
        update scope;  
    }
    
    global void finish(Database.BatchableContext bc) {
        decimal contador = [select count() from Correo_estado_cuenta__c where enviado__C=true];
        if(contador > 0){
            Id batch= Database.executeBatch(new batchCambioEstadoEDC(), 9999);
        }
    }
}