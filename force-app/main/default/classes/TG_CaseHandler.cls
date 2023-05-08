/**
*Class Name: TG_CaseHandler
*Description: Clase handler para el trigger del objeto Caso: TG_Case.
*Created Date: 5/01/2023 01:07 PM
*Created By: Cloud Code   
*Last Modified by: Cloud Code 28/03/2023 14:56 PM
*/
public class TG_CaseHandler extends TriggerHandler {
	/*protected override void beforeInsert() {
        
    }*/
    
	protected override void afterInsert() {
        TG_CaseHelper.sendMailPortalAutoGestion(Trigger.new);
    }

    /*protected override void beforeUpdate() {
    	
    }*/
    
    protected override void afterUpdate() {
		TG_CaseHelper.callSalesfoceRegional(Trigger.new);  
        if(System.IsBatch() == false && System.isFuture() == false){
        	TG_CaseHelper.CompleteResolutionTimeMilestone(Trigger.new);
        }    
        TG_CaseHelper.sendEmailAssignedCase(Trigger.new);
        if(System.IsBatch() == false && System.isFuture() == false){
        	TG_CaseHelper.createCancelationCase(Trigger.new);
        }
        TG_CaseHelper.listenPlatformEvent(Trigger.new,(Map<Id,Case>)Trigger.oldMap);
    }
}