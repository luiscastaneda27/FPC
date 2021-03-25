trigger CompleteResolutionTimeMilestone on Case (after Insert, after update) {
    if (Trigger.isUpdate) {
        if (Trigger.isAfter) {
            if (!System.isFuture()) { 
                               
                DateTime completionDate = System.now(); 
                List<Id> updateCases = new List<Id>();
                
                //Obtener id de Caso y proceso de aprobación
                set<Id> caso = new set<Id>();
                for(Case c : Trigger.new){        
                    caso.add(c.Id);
                }

                List<ProcessInstance> approvalProcess = new List<ProcessInstance>{};
                approvalProcess = [Select Id, LastActorId, ProcessDefinitionId, Status, TargetObjectId from ProcessInstance 
                                                        Where TargetObjectId =: caso Order By CreatedDate Desc Limit 1];
                //Fin obtener id de Caso y proceso de aprobación
                
                List<ProcessInstanceNode> nodes = new List<ProcessInstanceNode>{};
                if(approvalProcess.size() > 0) {
                    nodes = [SELECT Id, NodeStatus, ProcessNodeName, ProcessInstanceId FROM processinstancenode WHERE processinstanceid =: approvalProcess[0].Id Order By CreatedDate Desc Limit 1];
                }    
                    
                Boolean EnAprobacion;
                if(nodes.size() > 0) { EnAprobacion = Approval.isLocked(approvalProcess[0].TargetObjectId);
                }    

                List<ProcessInstanceWorkitem> actor;
                if(approvalProcess.size() > 0) { actor = [SELECT Id, ActorId, Actor.Name, Actor.Profile.Name, ProcessInstanceId From ProcessInstanceWorkitem Where ProcessInstanceId =: approvalProcess[0].Id and Actor.Name != 'Admin User'];    
                }     
                
                List<Case> lstCase = new List<Case>{};
                lstCase = [Select Id, Status, AccountId, Finalizar_SLA__c, Recordtype.Name, RecordType.DeveloperName from Case Where Id =: caso Limit 1];   
                
                for (Case c : Trigger.new) {                                                                        
                    //Requiere aprobación de exoneración
                    if((((c.Status == 'Devuelto' && c.Finalizar_SLA__c == false && nodes[0].NodeStatus != 'Rejected')||(c.Status == 'Pendiente de aprobación' && c.Finalizar_SLA_Aprobacion__c == false))&&(approvalProcess.size() > 0))&&((c.SlaStartDate <= completionDate)&&(c.SlaExitDate == null)&&(c.Requiere_aprobacion_exoneracion__c == true))) { 
                        updateCases.add(c.Id);                   
                    }    
                    //No requiere aprobación de exoneración
                    if((((c.Status == 'Devuelto' && c.Finalizar_SLA__c == false)||(c.Status == 'Pendiente de aprobación' && c.Finalizar_SLA_Aprobacion__c == false)||(c.Status == 'Devuelto' && c.N_Veces_Rechazado__c == 2 && c.Finalizar_SLA__c == false)||(c.Status == 'Devuelto' && c.N_Veces_Rechazado__c == 3))&&(approvalProcess.size() > 0))&&((c.SlaStartDate <= completionDate)&&(c.SlaExitDate == null)&&(c.Requiere_aprobacion_exoneracion__c == false))) { 
                        updateCases.add(c.Id);
                    } 
                    //Caso Pignoración
                    if(c.Status == 'Esperando Documentación' && c.Tiene_numero_Prestamo__c == false && (c.Es_primer_prestamo__c == false && c.Es_Refinanciamiento__c == false && c.No_Es_primer_prestamo__c == false)) { 
                        updateCases.add(c.Id);
                    }
                    //Caso Cerrado
                    if (((c.isClosed == true)||(c.Status == 'Cerrado')||(c.Status == 'No Aplica'))&&((c.SlaStartDate <= completionDate)&&(c.SlaExitDate == null))) { 
                        updateCases.add(c.Id);     
                    } else if (((c.isClosed == true)||(c.Status == 'Cerrado'))||(c.Status == 'No Aplica')) { 
                        updateCases.add(c.Id);      
                    }                  
                }
                if (updateCases.isEmpty() == false) { 
                    milestoneUtils.completeMilestone(updateCases, 'Resolution Time', completionDate);
                }   
                
                //Start send Email Assigned Case
                List<Case> casos = [Select id,CaseNumber,RecordTypeId,Recordtype.Name,Correo_Electronico__c,Type,Subject,ownerId,Status,SuppliedEmail,Identificacion__c,AccountId,Account.Name,Account.Identificacion__c,Constancia__c,Caso_Ingresado__c,ContactId,Viene_Portal_Autogestion__c From Case Where Id =: caso Limit 1];
                //List<User> usuario = [Select Id,Name From User Where Name = 'PortalAutoGestion Usuario invitado al sitio Web'];
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com']; 
                
                if((casos[0].RecordType.Name == 'Reposición de Carnet' || casos[0].RecordType.Name == 'Modificación de aportes' || casos[0].RecordType.Name == 'Otros' || (casos[0].RecordType.Name == 'Constancia' && casos[0].Constancia__c == 'A4')) && casos[0].AccountId != null && casos[0].SuppliedEmail != null && (casos[0].Status == 'Nuevo' || casos[0].Status == 'Pendiente de aprobación') && casos[0].Caso_Ingresado__c == false) { 
                    //Start send email        
                    List<EmailTemplate> lstEmailTemplates = [SELECT Id, Name, HtmlValue, Body, Subject from EmailTemplate Where Name = 'F_Caso_Email2Case - Email Caso Asignado'];            
                    String htmlBody = lstEmailTemplates[0].HtmlValue; System.debug('htmlBody: '+htmlBody);
                    htmlBody = htmlBody.replace('[XXXX]', casos[0].CaseNumber); 
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setTemplateId(lstEmailTemplates[0].Id);
                    mail.setSaveAsActivity(false);
                    mail.setSubject('El Caso '+casos[0].CaseNumber+',se ha Asignado a un Oficial');
                    //mail.setTargetObjectId(usuario[0].Id);            
                    mail.setHtmlBody(htmlBody);   
                    mail.setOrgWideEmailAddressId(owea.get(0).Id);
                    mail.setToAddresses(new String[] {casos[0].SuppliedEmail}); 
                    mail.setReplyTo(Null);
                    mail.setCcAddresses(Null);
                    Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });  
                    //End send email
                    casos[0].Caso_Ingresado__c = true;
                    update casos;
                }  
                //End send Email Assigned Case 
                
            }
        }
    }
    if (Trigger.isInsert) {
        if (Trigger.isAfter) {
            if (!System.isFuture()) {   
                set<Id> caseId = new set<Id>();
                for(Case c : Trigger.new) {
                    if(c.Id != null)
                    caseId.add(c.Id);
                }      
                updateCase.processCasePortalAuto(caseId); 
                
                //Start send autoresponse Email to Case (The client exist)
                List<Case> casos = [Select id,CaseNumber,RecordTypeId,RecordType.Name,Correo_Electronico__c,Type,Subject,ownerId,Status,SuppliedEmail,Identificacion__c,AccountId,Account.Identificacion__c From Case Where Id =: caseId];
                //List<User> usuario = [Select Id,Name From User Where Name = 'PortalAutoGestion Usuario invitado al sitio Web'];
                
                if(casos[0].RecordType.Name == 'Email to Case' && casos[0].AccountId != null) {                                    
                    //Start send email
                    OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];        
                    List<EmailTemplate> lstEmailTemplates = [SELECT Id, Name, HtmlValue, Body, Subject from EmailTemplate Where Name = 'F_Caso_Email2Case - Auto-respuesta'];            
                    String htmlBody = lstEmailTemplates[0].HtmlValue; System.debug('htmlBody: '+htmlBody);
                    htmlBody = htmlBody.replace('idCaso=', 'idCaso='+casos[0].Id); 
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setTemplateId(lstEmailTemplates[0].Id);
                    mail.setSaveAsActivity(false);
                    mail.setSubject('Su caso se creó correctamente: ' +casos[0].CaseNumber);
                    //mail.setTargetObjectId(usuario[0].Id);            
                    mail.setHtmlBody(htmlBody);   
                    mail.setOrgWideEmailAddressId(owea.get(0).Id);
                    mail.setToAddresses(new String[] {casos[0].SuppliedEmail});  
                    mail.setCcAddresses(null);
                    system.debug('Correo desde trigger: '+mail);
                    Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
                    //End send email
                //End send autoresponse Email to Case 
                
                //Start send autoresponse Email to Case (The client doesn't exist)
                } else if(casos[0].RecordType.Name == 'Email to Case' && casos[0].AccountId == null) {                                   
                    //Start send email
                    OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];        
                    List<EmailTemplate> lstEmailTemplates = [SELECT Id, Name, HtmlValue, Body, Subject from EmailTemplate Where Name = 'F_Caso_Email2Case - Auto-respuesta'];            
                    String htmlBody = lstEmailTemplates[0].HtmlValue; System.debug('htmlBody: '+htmlBody);
                    htmlBody = htmlBody.replace('idCaso=', 'idCaso='+casos[0].Id); 
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setTemplateId(lstEmailTemplates[0].Id);
                    mail.setSaveAsActivity(false);
                    mail.setSubject('Su caso se creó correctamente: ' +casos[0].CaseNumber);
                    //mail.setTargetObjectId(usuario[0].Id);            
                    mail.setHtmlBody(htmlBody);   
                    mail.setOrgWideEmailAddressId(owea.get(0).Id);
                    mail.setToAddresses(new String[] {casos[0].SuppliedEmail});            
                    Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });               
                    //End send email
                //End send autoresponse Email to Case    
                }  
                
            }
        }
    }
}