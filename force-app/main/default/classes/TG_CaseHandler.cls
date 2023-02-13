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
        TG_CaseHelper.CompleteResolutionTimeMilestone(Trigger.new);
        TG_CaseHelper.sendEmailAssignedCase(Trigger.new);
        TG_CaseHelper.createCancelationCase(Trigger.new);
    }
}