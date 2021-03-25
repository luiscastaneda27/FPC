public class updateCase {
	@future
    public static void processCase(List<Id> caseIds) {
    	List<Case> lstCase = [Select Id, Milestone_operaciones__c, Status, Paso_por_devolucion__c From Case Where Id in :caseIds Limit 1];
        for(Case c : lstCase) {
            if(c.Status == 'Pendiente de aprobación') { c.Milestone_operaciones__c = true;
            } else if(c.Status == 'Devuelto' && c.Paso_por_devolucion__c == False) { c.Paso_por_devolucion__c = True; 
            }    
        }
        update lstCase;
    }
    @future
    public static void processCasePortalAuto(set<Id> caseId) {
        List<Case> lstCase = [SELECT Id,Reason,Owner.Profile.Name,EntitlementId FROM Case where Id IN :caseId and Owner.Profile.Name = 'PortalAutoGestion Perfil' and EntitlementId = null];
        for(Case c : lstCase) { c.Reason = 'Otro';
        }
        update lstCase;        
    }    
}