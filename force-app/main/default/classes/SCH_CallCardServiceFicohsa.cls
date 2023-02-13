global class SCH_CallCardServiceFicohsa implements Queueable {
    
    global List<Detalle_caso__c> detCases = new List<Detalle_caso__c>();
    global String tipoGestion;

    global SCH_CallCardServiceFicohsa(List<Detalle_caso__c> lstDetCase, String tipoGestion) {
        for(Detalle_caso__c dc : lstDetCase){
        	detCases.add(dc);
        }
        this.tipoGestion = tipoGestion;
    }
    
    global void execute(QueueableContext sc) {
        // Implement any logic to be scheduled        
        Database.executeBatch(new BAT_CallCardServiceFicohsa(detCases, tipoGestion));
    }
}