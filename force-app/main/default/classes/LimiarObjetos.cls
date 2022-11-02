global without sharing class LimiarObjetos implements Schedulable{
    global void execute(SchedulableContext SC){
        Integer count = 10000;
        
        List<Contenido_planilla_Temporal__c> listPlanillaTemp = Database.query('Select Id from Contenido_planilla_Temporal__c limit '+count);
        count -= listPlanillaTemp.size();
        DataBase.delete(listPlanillaTemp, false);
        
        List<planilla_Temporal__c> listPlanilla = Database.query('Select Id from planilla_Temporal__c limit '+count);
        count -= listPlanilla.size();
        DataBase.delete(listPlanilla, false);
        
        List<InformeEDC__c> listInforme = Database.query('Select Id from InformeEDC__c limit '+count);
        count -= listInforme.size();
        DataBase.delete(listInforme, false);
        
        
        List<FPC_Log__c> listLogs = Database.query('Select Id from FPC_Log__c where CreatedDate < LAST_N_DAYS:'+Label.FPC_TiempoBorradoLogEDC +' limit '+count);
        count -= listInforme.size();
        DataBase.delete(listLogs, false);
    }  
    
}