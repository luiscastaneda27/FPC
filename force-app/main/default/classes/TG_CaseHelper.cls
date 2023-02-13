public class TG_CaseHelper {
    public static void callSalesfoceRegional(List<Case> cs) {
        
        String tipoRnombre;
        map<Id, RecordType> mapTiposRegistro = new map<Id, RecordType>([Select id, DeveloperName From RecordType 
                                                                        Where sObjectType = 'Case' AND isActive = True]);
        Set<Id> idCases = new Set<Id>();
        List<Detalle_caso__c> lstDetCase = new List<Detalle_caso__c>();
        
        for(Case item : cs) {
            tipoRnombre = mapTiposRegistro.get(item.recordTypeId).DeveloperName;
            if(tipoRnombre == 'Aumento_Disminucion_Aportes') {
                idCases.add(item.Id);
            }   
        } 
        
        if(idCases.size() > 0) {
        	lstDetCase = [SELECT Id,Caso__c,Caso__r.CaseNumber,Caso__r.Status,Nuevo_canal_aporte__c,Caso__r.Tipo_de_Operacion__c,Caso__r.Respuesta_SF_Tarjetas__c,
                    Caso__r.Account.Name,Caso__r.Account.Identificacion__c,DAU_Dia_de_pago__c,Caso__r.DAU_Identidad__c,Cuenta__r.Seguro_Vida__c,Caso__r.Description,
                    Cuenta__r.CurrencyIsoCode,N_Cuenta_Bancaria__c,Caso__r.DAU_No_Cuenta__c,Cuenta__r.Name,Nueva_fecha_aporte__c, Nuevo_monto_aporte__c,
                    CreatedDate,Caso__r.Account.Pais_Residencia__c, Tipo_Operacion__c, Cuenta__r.Forma_Aportacion__c,Banco__c,DAU_Borrar_Cuotas__c 
                    From Detalle_caso__c Where Caso__c In : idCases and Caso__r.Status = 'Cerrado'];
        }     
        
        if(!lstDetCase.isEmpty()) { 
            for(Detalle_caso__c detc : lstDetCase) {
            	if((detc.Nuevo_canal_aporte__c == 'TA' || detc.Banco__c == '28') && detc.Caso__r.Description != 'Tarjeta dada de baja') {
                    if((detc.Caso__r.Tipo_de_Operacion__c == 'A3' || detc.Caso__r.Tipo_de_Operacion__c == 'A8') && detc.Caso__r.Respuesta_SF_Tarjetas__c == Null) {
                        System.debug('Entra a llamar a servicios de Tarjeta Ficohsa para: '+detc.Caso__r.Tipo_de_Operacion__c); 
                        String tipoGestion = 'ALTA';
                        TG_CaseHelper.executeService(detc, tipoGestion);                       
                    } else if(detc.Caso__r.Tipo_de_Operacion__c == 'A4' && detc.Caso__r.Respuesta_SF_Tarjetas__c == Null) {
                        System.debug('Entra a llamar a servicios de Tarjeta Ficohsa para: '+detc.Caso__r.Tipo_de_Operacion__c); 
                        String tipoGestion = 'MOD';
                        TG_CaseHelper.executeService(detc, tipoGestion);
                    } else if(detc.Caso__r.Tipo_de_Operacion__c == 'A6' && detc.Caso__r.Respuesta_SF_Tarjetas__c == Null) {
                        System.debug('Entra a llamar a servicios de Tarjeta Ficohsa para: '+detc.Caso__r.Tipo_de_Operacion__c);
                        List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                        Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = detc.Caso__r.Id, DAU_PrimerServicio__c = true));
                        // Call method to publish events
                        List<Database.SaveResult> results = EventBus.publish(Logs);
                    } else if(detc.Caso__r.Tipo_de_Operacion__c == 'A7' && detc.Caso__r.Respuesta_SF_Tarjetas__c == Null) {
                        String tipoGestion = 'BAJA';
                      	TG_CaseHelper.executeService(detc, tipoGestion);
                    }
                } else if(detc.Nuevo_canal_aporte__c == 'TAOB' || detc.Banco__c == 'Otros Bancos') {
                    System.debug('Entra a llamar al servicio de Otros Bancos'); 
                    if(detc.Caso__r.Tipo_de_Operacion__c == 'A6' && detc.Caso__r.Respuesta_SF_Tarjetas__c == Null) {
                        System.debug('Entra a llamar a servicios de Tarjeta BAC para: '+detc.Caso__r.Tipo_de_Operacion__c);
                        List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                        Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = detc.Caso__r.Id, DAU_PrimerServicio__c = true));
                        // Call method to publish events
                        List<Database.SaveResult> results = EventBus.publish(Logs);
                    } else {
                    	DAU_GestionesBac.execute(detc.Caso__r.id);   
                    }    
                } else if((detc.Nuevo_canal_aporte__c == 'AH' || detc.Cuenta__r.Forma_Aportacion__c == 'AH') && detc.Caso__r.Status == 'Cerrado') {
                    System.debug('Entra a llamar a servicios de Cuenta de Ahorro');
                    if(detc.Caso__r.Tipo_de_Operacion__c == 'A5' && detc.Caso__r.Respuesta_SF_Tarjetas__c == Null) {
                        System.debug('Entra a llamar a servicios de Cuenta de Ahorro para: '+detc.Caso__r.Tipo_de_Operacion__c);
                        List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                        Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = detc.Caso__r.Id, DAU_PrimerServicio__c = true));
                        // Call method to publish events
                        List<Database.SaveResult> results = EventBus.publish(Logs);
                    } /*else if(detc.Nuevo_canal_aporte__c == 'AH') {
                        ControllerServiciosCuentaAhorro.execute(detc.Caso__r.id); 
                    }*/ else if(detc.Caso__r.Tipo_de_Operacion__c == 'A1' || detc.Caso__r.Tipo_de_Operacion__c == 'A2' || detc.Caso__r.Tipo_de_Operacion__c == 'A4' || detc.Caso__r.Tipo_de_Operacion__c == 'A7') { 
                        ControllerServiciosCuentaAhorro.execute(detc.Caso__r.id);    
                    } else {
                        if(!detc.Caso__r.Respuesta_SF_Tarjetas__c.contains('Error')) {
                        	aSysdeCallouts.aumentoDisminucion(detc.Caso__r.id);
                        }    
                    }   
                } /*else {
                    System.debug('Llama a sysde directamente');
                    aSysdeCallouts.aumentoDisminucion(detc.Caso__r.id); 
                }*/
        	}        
        }
    }
    
    public static void executeService(Detalle_caso__c detCase, String tipoGestion) {
        List<Detalle_caso__c> lstDetCase = new List<Detalle_caso__c>();
        lstDetCase.add(detCase);
        ID jobID = System.enqueueJob(new SCH_CallCardServiceFicohsa(lstDetCase, tipoGestion));
    }
    
    public static void CompleteResolutionTimeMilestone(List<Case> cs) {
        if(!System.isFuture()) {             
            DateTime completionDate = System.now(); 
            List<Id> updateCases = new List<Id>();
                    
            //Obtener id de Caso y proceso de aprobación
            set<Id> caso = new set<Id>();
            for(Case c : cs){        
                caso.add(c.Id);
            }
    
            List<ProcessInstance> approvalProcess = new List<ProcessInstance>{};
            approvalProcess = [Select Id, LastActorId, ProcessDefinitionId, Status, TargetObjectId from ProcessInstance 
                                                            Where TargetObjectId =: caso Order By CreatedDate Desc Limit 1];
            //Fin obtener id de Caso y proceso de aprobación
                    
            List<ProcessInstanceNode> nodes = new List<ProcessInstanceNode>{};
            if(approvalProcess.size() > 0) { nodes = [SELECT Id, NodeStatus, ProcessNodeName, ProcessInstanceId FROM processinstancenode WHERE processinstanceid =: approvalProcess[0].Id Order By CreatedDate Desc Limit 1];
            }    
                      
            Boolean EnAprobacion;
            if(nodes.size() > 0) { EnAprobacion = Approval.isLocked(approvalProcess[0].TargetObjectId);
            }    
    
            List<ProcessInstanceWorkitem> actor;
            if(approvalProcess.size() > 0) { actor = [SELECT Id, ActorId, Actor.Name, Actor.Profile.Name, ProcessInstanceId From ProcessInstanceWorkitem Where ProcessInstanceId =: approvalProcess[0].Id and Actor.Name != 'Admin User'];    
            }     
                    
            List<Detalle_caso__c> lstDetCase = new List<Detalle_caso__c>{};
            lstDetCase = [Select Id, DAU_Borrar_Cuotas__c, Cuenta__r.Forma_Aportacion__c, Nuevo_canal_aporte__c From Detalle_caso__c 
                           Where Caso__c IN : caso];
                 
            for (Case c : cs) {                                                                        
                //Requiere aprobación de exoneración
                if((((c.Status == 'Devuelto' && c.Finalizar_SLA__c == false && nodes[0].NodeStatus != 'Rejected') || 
                     (c.Status == 'Pendiente de aprobación' && c.Finalizar_SLA_Aprobacion__c == false)) && (approvalProcess.size() > 0))
                     &&((c.SlaStartDate <= completionDate)&&(c.SlaExitDate == null)&&(c.Requiere_aprobacion_exoneracion__c == true))) { 
                    updateCases.add(c.Id);                   
                }    
                //No requiere aprobación de exoneración
                if((((c.Status == 'Devuelto' && c.Finalizar_SLA__c == false)||(c.Status == 'Pendiente de aprobación' && 
                      c.Finalizar_SLA_Aprobacion__c == false)||(c.Status == 'Devuelto' && c.N_Veces_Rechazado__c == 2 && 
                      c.Finalizar_SLA__c == false)||(c.Status == 'Devuelto' && c.N_Veces_Rechazado__c == 3)) && (approvalProcess.size() > 0))
                      &&((c.SlaStartDate <= completionDate)&&(c.SlaExitDate == null)&&(c.Requiere_aprobacion_exoneracion__c == false))) { 
                    updateCases.add(c.Id);
                } 
                //Caso Pignoración
                if(c.Status == 'Esperando Documentación' && c.Tiene_numero_Prestamo__c == false && (c.Es_primer_prestamo__c == false && 
                   c.Es_Refinanciamiento__c == false && c.No_Es_primer_prestamo__c == false)) { 
                    updateCases.add(c.Id);
                }
                //Caso Cerrado
                if (((c.isClosed == true)||(c.Status == 'Cerrado')||(c.Status == 'No Aplica'))&&((c.SlaStartDate <= completionDate)&& (c.SlaExitDate == null))) { 
                    updateCases.add(c.Id);     
                } else if (((c.isClosed == true)||(c.Status == 'Cerrado'))||(c.Status == 'No Aplica')) { 
                    updateCases.add(c.Id);      
                }                  
            }
            if (updateCases.isEmpty() == false) { 
                milestoneUtils.completeMilestone(updateCases, 'Resolution Time', completionDate);
            }                  
        }
    }
    
    public static void sendEmailAssignedCase(List<Case> cs) {
        //Start send Email Assigned Case
        List<Case> csUpdate = new List<Case>();
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com']; 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        for(Case c : cs) { System.debug('El recodtype es: '+c.RecordType.DeveloperName);
            if((c.RecordType.DeveloperName == 'Reposicion_Carnet' || c.RecordType.DeveloperName == 'Otros' || (c.RecordType.DeveloperName == 'Constancia' && 
                c.Constancia__c == 'A4' || test.isRunningTest())) && c.AccountId != null && c.SuppliedEmail != null && (c.Status == 'Nuevo' || 
                c.Status == 'Pendiente de aprobación') && c.Caso_Ingresado__c == false) { 
                //Start send email        
                List<EmailTemplate> lstEmailTemplates = [SELECT Id, Name, HtmlValue, Body, Subject from EmailTemplate Where Name = 'F_Caso_Email2Case - Email Caso Asignado'];            
                String htmlBody = lstEmailTemplates[0].HtmlValue; 
                htmlBody = htmlBody.replace('[XXXX]', c.CaseNumber); 
                mail.setTemplateId(lstEmailTemplates[0].Id);
                mail.setSaveAsActivity(false);
                mail.setSubject('El Caso '+c.CaseNumber+',se ha Asignado a un Oficial');
                //mail.setTargetObjectId(usuario[0].Id);            
                mail.setHtmlBody(htmlBody);   
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
                mail.setToAddresses(new String[] {c.SuppliedEmail}); 
                mail.setReplyTo(Null);
                mail.setCcAddresses(Null);
                Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });  
                //End send email
                if(!test.isRunningTest()) { c.Caso_Ingresado__c = true; csUpdate.add(c);   
                }        
            }  
            if(csUpdate.size() > 0) { update csUpdate;
            }
        }    
        //End send Email Assigned Case
    }
    
    public static void createCancelationCase(List<Case> cs) {
        //Obtener id de Caso
        set<Id> caso = new set<Id>();
        for(Case c : cs){        
            caso.add(c.Id);
        }
        List<Detalle_caso__c> dc = [Select Id,Caso__c,Caso__r.Status,Caso__r.Recordtype.Name,Tipo_retiro__c,Cuenta__c,Caso__r.AccountId,
            Cuenta__r.Forma_Aportacion__c From Detalle_caso__c Where Caso__c In : caso and Tipo_retiro__c = '52'];
        String RecordTypeId = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;   
        List<Case> casoNew = new List<Case>();
        //Inicio Creando caso de Cancelación de aporte por retiro total  
        for(Detalle_caso__c d : dc) {
            if(d.Caso__r.Status == 'Cerrado' && d.Caso__r.Recordtype.Name == 'Retiros') { 
                if(d.Cuenta__r.Forma_Aportacion__c == 'AH' || d.Cuenta__r.Forma_Aportacion__c == 'CK' || d.Cuenta__r.Forma_Aportacion__c == 'TA') {
                    casoNew.add(new Case(No_Aplica_SLA__c = true,Origin = 'Agencias FPC',Reason = 'Otro', ParentId = d.Caso__r.Id, AccountId = d.Caso__r.AccountId,RecordTypeId = RecordTypeId,Status = 'Cerrado',Type = 'Solicitud',Priority = 'Media',Subject = 'Cancelación de Aporte por Retiro Total'));    
                }
            }
        }  
        if(!casoNew.isEmpty()) {
           	insert casoNew;                   
            List<Id> detail = new List<Id>();
            for(Case csnew: casoNew) {
                detail.add(csnew.Id);
                if(detail != null) {
                	updateCase.createDetail(detail, caso); 
                }
            }    
        }
        //Fin Creando caso de Cancelación de aporte por retiro total 
    }
    
    public static void sendMailPortalAutoGestion(List<Case> cs) {
        List<Case> caseUpdate = new List<Case>();
        if(!System.isFuture()) {   
            set<Id> caseId = new set<Id>();
            for(Case c : cs) {
                caseId.add(c.Id);
                if(c.Owner.Profile.Name == 'PortalAutoGestion Perfil') { 
                    updateCase.processCasePortalAuto(caseId);
                }    
            }   
               
            //Start send autoresponse Email to Case (The client exist)
            for(Case c : cs) { 
                if(c.Tipo_de_Operacion__c == 'A7' && c.ParentId <> '' && c.DAU_aprobacion__c == true) {
                    c.DAU_aprobacion__c = false; 
                    caseUpdate.add(c);
                }
            }   
                
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
            List<EmailTemplate> lstEmailTemplates = [SELECT Id, Name, HtmlValue, Body, Subject from EmailTemplate Where Name = 'F_Caso_Email2Case - Auto-respuesta']; 
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                
            for(Case c : cs) { 
                if(c.RecordType.DeveloperName == 'Email_to_Case' || test.isRunningTest()) { 
                    TG_CaseHelper.senEmailMessage(c.Id, c.CaseNumber, c.SuppliedEmail); 
                }
            }
             
            if(caseUpdate.size() > 0) {
                update caseUpdate;
            }           
        }
    }
    
    public static void senEmailMessage(String caseId, String caseNumber, String suppliedEmail) {
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
        List<EmailTemplate> lstEmailTemplates = [SELECT Id, Name, HtmlValue, Body, Subject from EmailTemplate Where Name = 'F_Caso_Email2Case - Auto-respuesta']; 
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        //Start send email         
        String htmlBody = lstEmailTemplates[0].HtmlValue;
        htmlBody = htmlBody.replace('idCaso=', 'idCaso='+caseId); 
        htmlBody = htmlBody.replace('[getLinkPortal]', ClaseUtil.urlSysde('PortalAutoGestion'));
        mail.setTemplateId(lstEmailTemplates[0].Id);
        mail.setSaveAsActivity(false);
        mail.setSubject('Su caso se creó correctamente: ' +caseNumber);           
        mail.setHtmlBody(htmlBody);   
        mail.setOrgWideEmailAddressId(owea.get(0).Id);
        if(suppliedEmail != Null) {
        	mail.setToAddresses(new String[] {suppliedEmail});
        } else {
        	mail.setToAddresses(new String[] {'admin@fichohsa.org.c'});
        } 
        mail.setCcAddresses(null);
        system.debug('Correo desde trigger: '+mail);
        Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
        //End send email
    }
    
}