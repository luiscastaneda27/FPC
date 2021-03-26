public class MilestoneUtils {
    public static void completeMilestone(List<Id> caseIds, String milestoneName, DateTime complDate) {  
        List<CaseMilestone> cmsToUpdate = [select Id, completionDate from CaseMilestone cm where caseId in :caseIds and completionDate = null limit 1];
        //System.debug('Lista: '+cmsToUpdate);
        if (cmsToUpdate.isEmpty() == false) { for (CaseMilestone cm : cmsToUpdate) { cm.completionDate = complDate; } update cmsToUpdate; updateCase.processCase(caseIds);
        }  
        
        List<Case> caso = new List<Case>();
        caso = [Select Id,Account.Name,Status,Tipo_de_Operacion__c From Case Where Id in: caseIds and Status = 'Cerrado' and Tipo_de_Operacion__c = 'A8'];
        if(!caso.IsEmpty()) {
            Set<Id> idCs = new Set<Id>();
            for(Case c2 : caso) {
            	idCs.add(c2.Id);    
            }
            List<Detalle_caso__c> detailCase = [Select Id,Caso__c,N_Cuenta_Bancaria__c,DAU_Dia_de_pago__c From Detalle_caso__c where Caso__c In: idCs Limit 1];
            if(!detailCase.IsEmpty()) {
            	//Salesforce_Tarjetas.processCase(idCs,'ADI',detailCase[0].N_Cuenta_Bancaria__c,caso[0].Account.Name,detailCase[0].DAU_Dia_de_pago__c);
            }    
        }
    }
}