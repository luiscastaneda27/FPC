trigger CaseDetail on Detalle_caso__c (before Update) {
    //Inicio Evaluar SLA's de Caso
    set<Id> detalleCaso = new set<Id>();
    //if(CaseTriggerHandler.isFirstTime) {
        //CaseTriggerHandler.isFirstTime = false;
        for(Detalle_caso__c dc : Trigger.new) {                
            detalleCaso.add(dc.Caso__c);
        } 
        //Actualizando campo en caso para que no se cancele el SLA´s cuando el caso está en devolución y editan algun monto en el detalle del caso.       
        List<ProcessInstance> approvalProcess = new List<ProcessInstance>{};
        approvalProcess = [SELECT Id, Status, CreatedDate, CompletedDate, TargetObjectId 
                            from ProcessInstance 
                            Where TargetObjectId =:detalleCaso Order By CreatedDate Desc Limit 1];
        
        List<ProcessInstanceNode> nodes = new List<ProcessInstanceNode>{};
        if(approvalProcess.size() > 0) {
            nodes = [SELECT Id, NodeStatus, ProcessNodeName, ProcessInstanceId 
                                                   FROM processinstancenode 
                                                   WHERE processinstanceid =: approvalProcess[0].Id Order By CreatedDate Desc Limit 1];
        }   
        
        if(nodes.size() > 0) { 
            if(nodes[0].ProcessNodeName == 'Aprobación exoneraciones' && nodes[0].NodeStatus == 'Rejected') {
                List<Case> caso = [Select Id,Finalizar_SLA__c,Status,RecordType.DeveloperName From Case Where Id =: detalleCaso and Status = 'Devuelto' and RecordType.DeveloperName = 'Retiros' Limit 1];
                if(caso.size()>0) { caso[0].Finalizar_SLA__c = true; /*Campo de bandera para que no se cierre el SLA.*/ update caso;
                }
            }
            
            if(nodes[0].ProcessNodeName == 'Aprobación SubGerencia SAC' && nodes[0].NodeStatus == 'Rejected') {
                List<Case> caso = [Select Id,Finalizar_SLA__c,Status,RecordType.DeveloperName From Case Where Id =: detalleCaso and Status = 'Devuelto' and RecordType.DeveloperName = 'Constancia' Limit 1];
                if(caso.size()>0) { caso[0].Finalizar_SLA__c = true; /*Campo de bandera para que no se cierre el SLA.*/ update caso;
                }
            }
        }
    //} 
    //Fin Evaluar SLA's de Caso
}