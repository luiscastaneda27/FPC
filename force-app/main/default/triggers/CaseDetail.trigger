trigger CaseDetail on Detalle_caso__c (after Insert, before Update) {
    if (Trigger.isUpdate) {
        if (Trigger.isBefore) {
            try{
                //Inicio Evaluar SLA's de Caso
                set<Id> caso = new set<Id>();
                set<Id> detalleCaso = new set<Id>();
                //if(CaseTriggerHandler.isFirstTime) {
                    //CaseTriggerHandler.isFirstTime = false;
                    for(Detalle_caso__c dc : Trigger.new) {                
                        caso.add(dc.Caso__c);
                        detalleCaso.add(dc.Id);
                    } 
                    //Actualizando campo en caso para que no se cancele el SLA´s cuando el caso está en devolución y editan algun monto en el detalle del caso.       
                    List<ProcessInstance> approvalProcess = new List<ProcessInstance>{};
                    approvalProcess = [SELECT Id, Status, CreatedDate, CompletedDate, TargetObjectId 
                                        from ProcessInstance 
                                        Where TargetObjectId =:caso Order By CreatedDate Desc Limit 1];
                    
                    List<ProcessInstanceNode> nodes = new List<ProcessInstanceNode>{};
                    if(approvalProcess.size() > 0) {
                        nodes = [SELECT Id, NodeStatus, ProcessNodeName, ProcessInstanceId 
                                                               FROM processinstancenode 
                                                               WHERE processinstanceid =: approvalProcess[0].Id Order By CreatedDate Desc Limit 1];
                    }   
                    
                    List<Case> vcaso = new List<Case>();
                    if(nodes.size() > 0) { 
                        if(nodes[0].ProcessNodeName == 'Aprobación exoneraciones' && nodes[0].NodeStatus == 'Rejected') {
                            vcaso = [Select Id,Finalizar_SLA__c,Status,RecordType.DeveloperName From Case Where Id =: caso and Status = 'Devuelto' and RecordType.DeveloperName = 'Retiros' Limit 1];
                            if(vcaso.size()>0) { vcaso[0].Finalizar_SLA__c = true; /*Campo de bandera para que no se cierre el SLA.*/ update vcaso;
                            }
                        }
                        
                        if(nodes[0].ProcessNodeName == 'Aprobación SubGerencia SAC' && nodes[0].NodeStatus == 'Rejected') {
                            vcaso = [Select Id,Finalizar_SLA__c,Status,RecordType.DeveloperName From Case Where Id =: caso and Status = 'Devuelto' and RecordType.DeveloperName = 'Constancia' Limit 1];
                            if(vcaso.size()>0) { vcaso[0].Finalizar_SLA__c = true; /*Campo de bandera para que no se cierre el SLA.*/ update vcaso;
                            }
                        }
                    }
                //} 
                //Fin Evaluar SLA's de Caso
                
                List<Detalle_caso__c> dt = [Select Id,Caso__c,Nuevo_monto_aporte__c,Cuenta__c,Tipo_Operacion__c From Detalle_caso__c Where Id In: detalleCaso];
                List<Cuentas__c> cuentaC = new List<Cuentas__c>();
                List<Producto__c> prod = new List<Producto__c>();
                if(!dt.isEmpty()) {                    
                    List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                    Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = dt[0].Caso__c));
                    List<Database.SaveResult> results = EventBus.publish(Logs);
                }              
            } catch(Exception ex) {
                System.debug('Error: '+ex.getLineNumber()+'---'+ex.getMessage());
            }
        }
    }
    if (Trigger.isInsert) {
        if (Trigger.isAfter) {
        	set<Id> caso = new set<Id>();
            set<Id> detalleCaso = new set<Id>();
            for(Detalle_caso__c dc : Trigger.new) {                
            	caso.add(dc.Caso__c);
                detalleCaso.add(dc.Id);
        	}    
            List<Detalle_caso__c> dt = [Select Id,Nuevo_monto_aporte__c,Cuenta__c,Tipo_Operacion__c From Detalle_caso__c Where Id In: detalleCaso];
            List<Cuentas__c> cuentaC = new List<Cuentas__c>();
            List<Producto__c> prod = new List<Producto__c>();
            if(!dt.isEmpty()) {
            	if(dt[0].Tipo_Operacion__c == 'A8') {
                    List<Case> casoUpdate = [Select Id,DAU_aprobacion__c From Case Where Id =: caso and (Status = 'Nuevo' or Status = 'Devuelto' or Status = 'Pendiente de aprobación') and RecordType.DeveloperName = 'Aumento_Disminucion_Aportes' Limit 1];
                    casoUpdate[0].DAU_aprobacion__c = false;
                    update casoUpdate[0];    
                } else if(dt[0].Tipo_Operacion__c == 'A2') {
                    cuentaC = [Select Id, Producto__c From Cuentas__c Where Id =: dt[0].Cuenta__c and Activo__c = true];
                    if(!cuentaC.isEmpty()) {
                        prod = [Select Id,CurrencyIsoCode From Producto__c Where Id =: cuentaC[0].Producto__c];
                    }
                    List<Parametros_DAU__mdt> paramHNL = [Select Id,DeveloperName,Monto_a_Disminuir__c From Parametros_DAU__mdt Where DeveloperName = 'Disminucion_de_aporte_HNL']; 
                    List<Parametros_DAU__mdt> paramUSD = [Select Id,DeveloperName,Monto_a_Disminuir__c From Parametros_DAU__mdt Where DeveloperName = 'Disminucion_de_aporte_USD']; 
                    List<Case> casoUpdate = [Select Id,DAU_aprobacion__c From Case Where Id =: caso and (Status = 'Nuevo' or Status = 'Devuelto') and RecordType.DeveloperName = 'Aumento_Disminucion_Aportes' Limit 1];
                    if(!prod.isEmpty() && prod[0].CurrencyIsoCode == 'HNL') {
                        if(dt[0].Nuevo_monto_aporte__c >= paramHNL[0].Monto_a_Disminuir__c && !casoUpdate.isEmpty() && dt[0].Tipo_Operacion__c == 'A2') {  
                            casoUpdate[0].DAU_aprobacion__c = false;
                            update casoUpdate[0];
                        }
                    } else if(!prod.isEmpty() && prod[0].CurrencyIsoCode == 'USD') {
                        if(dt[0].Nuevo_monto_aporte__c >= paramUSD[0].Monto_a_Disminuir__c && !casoUpdate.isEmpty() && dt[0].Tipo_Operacion__c == 'A2') {  
                            casoUpdate[0].DAU_aprobacion__c = false;
                            update casoUpdate[0];
                        }
                    }
                } 
            }
        }
    }
}