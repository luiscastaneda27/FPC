global without sharing class LimiarObjetos implements Schedulable{
    global void execute(SchedulableContext SC){
        Integer count = 10000;
        
        List<Contenido_planilla_Temporal__c> listPlanillaTemp = Database.query('Select Id from Contenido_planilla_Temporal__c limit '+count);
        count -=listPlanillaTemp.size();
        delete(listPlanillaTemp);
        
        List<planilla_Temporal__c> listPlanilla = Database.query('Select Id from planilla_Temporal__c limit '+count);
        count -=listPlanilla.size();
        delete(listPlanilla);
        
        List<InformeEDC__c> listInforme = Database.query('Select Id from InformeEDC__c limit '+count);
        delete(listInforme);
    }  
    
}