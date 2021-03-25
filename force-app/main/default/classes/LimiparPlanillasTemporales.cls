global with sharing class LimiparPlanillasTemporales implements Schedulable{
    global void execute(SchedulableContext SC){
        delete([select id from Contenido_planilla_Temporal__c limit 9950]);
        delete([select id from planilla_Temporal__c limit 50]);
    }  
    
}