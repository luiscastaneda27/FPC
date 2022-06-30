global class batchCambioEstadoEDC implements Database.batchable<SObject>{ 
    
    public static Date fechacierre = Date.today();
    
    global batchCambioEstadoEDC(){
    }
    
    global Iterable<SObject> start(Database.BatchableContext bc) {
        String query = 'select  enviado__c, Id from Correo_estado_cuenta__c where enviado__C=true ';
        if(fechacierre.month() != 1 && fechacierre.month() != 4 && fechacierre.month() != 7 && fechacierre.month() != 10){
            query +='And Cliente__r.FrecuenciaEnvioEDC__c = \'Mensual\'';
        }
        query += ' limit 9999';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, Correo_estado_cuenta__c[] scope) {
        for(Correo_estado_cuenta__c item: scope){
            item.enviado__C=false;
        } 
        update scope;  
    }
    
    global void finish(Database.BatchableContext bc) {
        String query = 'Select  Id from Correo_estado_cuenta__c where enviado__C=true ';
        if(fechacierre.month() != 1 && fechacierre.month() != 4 && fechacierre.month() != 7 && fechacierre.month() != 10){
            query +='And Cliente__r.FrecuenciaEnvioEDC__c = \'Mensual\'';
        }
        query +=' limit 1';
        List<Correo_estado_cuenta__c> contador = DataBase.query(query);
        if(contador.size() > 0){
            Id batch= Database.executeBatch(new batchCambioEstadoEDC(), 9999);
        }
    }
}