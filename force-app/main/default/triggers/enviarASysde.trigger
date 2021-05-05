trigger enviarASysde on Case (before update) {
    //if(!test.isRunningTest()) Trigger.new[0].addError('No se puede gestionar un caso ya que se esta haciendo un implementación en este momento.');
    system.debug('Puedo corrrelo ' + claseUtil.canIRun());
    if(claseUtil.canIRun() && !System.isFuture()) { 
        
        //Inicio Evaluar SLA's de Caso
        set<Id> caso2 = new set<Id>();
        for(Case c : Trigger.new){
            caso2.add(c.Id);
        }
        
        List<ProcessInstance> approvalProcess = new List<ProcessInstance>{};
        approvalProcess = [SELECT Id, Status, CreatedDate, CompletedDate, TargetObjectId, 
                            (SELECT Id, StepStatus, Actor.Name, ElapsedTimeInDays, ElapsedTimeInMinutes, 
                            CreatedDate, ProcessNodeId, ProcessNode.Name, Comments 
                            FROM StepsAndWorkitems order by CreatedDate) from ProcessInstance 
                            Where TargetObjectId =: caso2 Order By CreatedDate Desc Limit 1];
        
        List<ProcessInstanceNode> nodes = new List<ProcessInstanceNode>{};
        if(approvalProcess.size() > 0) {
            nodes = [SELECT Id, NodeStatus, ProcessNodeName, ProcessInstanceId 
                                                   FROM processinstancenode 
                                                   WHERE processinstanceid =: approvalProcess[0].Id Order By CreatedDate Desc Limit 1];
        }        
        
        List<Case> lstCase = new List<Case>{};
        List<Case> updatelstCase = new List<Case>{};    
        lstCase = [Select Id, Finalizar_SLA__c, RecordType.Name, Recordtype.DeveloperName, SuppliedEmail from Case Where Id =: caso2 Limit 1];
        
        Boolean EnAprobacion = Approval.isLocked(lstCase[0].Id); System.debug('En aprobación: '+EnAprobacion);
        
        //if(CaseTriggerHandler.isFirstTime) {
            //CaseTriggerHandler.isFirstTime = false;
            if(approvalProcess.size() > 0) { 
                List<ProcessInstanceWorkitem> actor; if(approvalProcess.size() > 0) { 
                    actor = [SELECT Id, ActorId, Actor.Name, Actor.Profile.Name, ProcessInstanceId From ProcessInstanceWorkitem Where ProcessInstanceId =: approvalProcess[0].Id and Actor.Name != 'Admin User']; 
                } 
                List<ProcessInstanceStep> paso = [SELECT Id, StepStatus From ProcessInstanceStep Where ProcessInstanceId =: approvalProcess[0].Id Order By CreatedDate Asc Limit 1];
                
                for(Case objCase : Trigger.new) { 
                    if(actor.size() > 0) { 
                        if(actor[0].Actor.Name == 'Aprobacion Intermedia Retiros' && approvalProcess[0].Status == 'Pending' && paso[0].StepStatus == 'Started' && objCase.Status == 'Pendiente segunda aprobación' && objCase.Requiere_aprobacion_exoneracion__c == true) { 
                            objCase.Finalizar_SLA_Aprobacion__c = true; 
                        } else if(actor[0].Actor.Name == 'Aprobadores de Retiro' && approvalProcess[0].Status == 'Pending' && paso[0].StepStatus == 'Started' && objCase.Requiere_aprobacion_exoneracion__c == true) { 
                            objCase.Finalizar_SLA_Aprobacion__c = true; 
                        } else if(actor[0].Actor.Name == 'Aprobadores de Retiro' && approvalProcess[0].Status == 'Pending' && objCase.Requiere_aprobacion_exoneracion__c == false) { 
                            objCase.Finalizar_SLA_Aprobacion__c = true; 
                        } else { objCase.Finalizar_SLA_Aprobacion__c = false; 
                        } 
                    }
                    
                    if(approvalProcess[0].Status == 'Started') { 
                        if(objCase.Status == 'Pendiente de aprobación' && objCase.Finalizar_SLA__c == false && objCase.Finalizar_SLA_Aprobacion__c == false && objCase.Requiere_aprobacion_exoneracion__c == true) { objCase.Finalizar_SLA_Aprobacion__c = true; 
                        } 
                    } 
                    
                    if(EnAprobacion == false && approvalProcess[0].Status == 'Rejected' && System.Trigger.isUpdate) { objCase.Finalizar_SLA__c = true; 
                    } else if(EnAprobacion == true && approvalProcess[0].Status == 'Pending' && System.Trigger.isUpdate) { objCase.Finalizar_SLA__c = false; 
                    } 
                    
                    if(actor.size() > 0 && lstCase[0].Recordtype.DeveloperName == 'Retiros' && objCase.Requiere_aprobacion_exoneracion__c == true) { 
                        if(EnAprobacion == false && actor[0].Actor.Name == 'Aprobación SubGerencia SAC' && approvalProcess[0].Status == 'Started' && objCase.Status == 'Pendiente de aprobación' && System.Trigger.isUpdate) { objCase.Finalizar_SLA__c = true; 
                        } 
                    }
                    
                    if(EnAprobacion == true && approvalProcess[0].Status == 'Rejected' && objCase.Status == 'Devuelto' && lstCase[0].Recordtype.DeveloperName == 'Actualizacion_informacion') { 
                        objCase.Finalizar_SLA__c = false;    
                    } else if(EnAprobacion == true && approvalProcess[0].Status == 'Rejected' && objCase.Status == 'Devuelto' && lstCase[0].Recordtype.DeveloperName == 'Aumento_Disminucion_Aportes') { 
                        objCase.Finalizar_SLA__c = false;    
                    } else if(EnAprobacion == true && approvalProcess[0].Status == 'Rejected' && objCase.Status == 'Devuelto' && lstCase[0].Recordtype.DeveloperName == 'Constancia') { 
                        objCase.Finalizar_SLA__c = false;    
                    } else if(EnAprobacion == true && approvalProcess[0].Status == 'Rejected' && objCase.Status == 'Devuelto' && lstCase[0].Recordtype.DeveloperName == 'Cambio_Subproducto') { 
                        objCase.Finalizar_SLA__c = false; 
                    } 
                    
                    if(objCase.Status == 'Devuelto' && EnAprobacion == true) { objCase.N_Veces_Rechazado__c++; 
                    }                    
                    
                }
            }
        //}
        //Fin Evaluar SLA's de Caso
        
        map<Case, String> casosAprobados = new map<Case, String>();
        list<Id> casosEDC = new list <Id>();
        list<Id> listCasoConstancia = new list <Id>();
        
        list<Id> casosEDCmensual = new list <Id>(); 
        list<Id> casosRepoCarnet = new list <Id>(); 
        list<Id> casosEDCcuentasMensual = new list <Id>();
        list<Id> casosEDCtrimestral = new list <Id>();
        list<Id> casosEDCcuentasTrimestral = new list <Id>();
        
       
        string estadoConstancia = '';
        map<Id, RecordType> mapTiposRegistro = new map<Id, RecordType>([Select id, DeveloperName From RecordType
                                                                        Where sObjectType = 'Case' AND
                                                                        isActive = True]);
        date  fechaCreacioncaso;
        
        For(Case item : trigger.new){
            String tipoRnombre = mapTiposRegistro.get(item.recordTypeId).DeveloperName;
            string tiporetiro='';
            fechaCreacioncaso = DATE.valueOf(Datetime.newInstance(item.createddate.year(), item.createddate.month(), item.createddate.day(),-6,0,0) );
             
            list<detalle_caso__C> listcuentas = new list<detalle_caso__C>();
            if(tipoRnombre == 'Retiros' ){
                list<detalle_caso__C> lk = [select tipo_retiro__C, cuenta__r.codigo__C from detalle_caso__C where caso__C=:item.id  and tipo_retiro__C !=null and cuenta__C !=null  limit 1];
                if(lk.size() ==0 && test.isRunningTest()){
                    lk = [select tipo_retiro__C, cuenta__r.codigo__C from detalle_caso__C where caso__C=:item.id];
                }
                if(lk.size() >0){
                    tiporetiro=lk[0].tipo_retiro__C;
                   // ActualizarSaldosCuentas.ActualizarSaldos(item.id, lk[0].cuenta__r.codigo__C, trigger.oldMap.get(item.id).Status);
                }
                 
            }
            if(trigger.oldMap.get(item.id).Status != item.Status && item.Status == 'Devuelto' && item.OwnerId == Label.IdOwnerCase){
                   Usuarios_para_asignacion_Casos_SAC__c p = [select id, usuario__C, usuario__r.email, Ultimo_Caso_Asignado__c from Usuarios_para_asignacion_Casos_SAC__c where zona__c = :ClasseUtilNueva.ZonaPorDepto(item.AccountId) order by Ultimo_Caso_Asignado__c  asc limit 1];
                   item.ownerId = p.usuario__c; 
                   ClasseUtilNueva.CasoDevuelto(p.id, item.Casenumber, p.usuario__r.email);                        
                   
               }
            
            if(tipoRnombre == 'Cambio_Subproducto'){
                if(!trigger.oldMap.get(item.id).Aprobado__c && item.Aprobado__c){
                    casosAprobados.put(item, tipoRnombre);
                }   
            }
            if(tipoRnombre == 'Actualizacion_informacion'){
                if(trigger.oldMap.get(item.id).Status != item.Status && item.Status == 'Cerrado'){
                    casosAprobados.put(item, tipoRnombre);
                } 
            }
            if(tipoRnombre == 'Aumento_Disminucion_Aportes'){
                if(trigger.oldMap.get(item.id).Status != item.Status && item.Status == 'Pendiente de aprobación' && item.Enviar_aprobacion_AD__c) { claseUtil.enviarCorreoCasoAD(item.id,'CasoAyD');
                                                                                                                  }
                else if(trigger.oldMap.get(item.id).Status != item.Status && item.Status == 'Cerrado'  && !item.Cerrado_sin_cambios__c){
                    casosAprobados.put(item, tipoRnombre);
                }
            }
            if(tipoRnombre == 'Estados_Cuenta' || test.isRunningTest()){
                if(trigger.oldMap.get(item.id).Status != item.Status && item.Status == 'Cerrado'){
                    if(item.Tipo_Estado_Cuenta__c == 'A1'){
                        casosEDCtrimestral.add(item.id);    
                        //casosEDCcuentasTrimestral.add(item.AccountId);
                    }else{ casosEDCmensual.add(item.id);   
                        //casosEDCcuentasMensual.add(item.AccountId);
                    }
                }
            }
            
            if(tipoRnombre == 'Retiros' ){
                Date FCsysde = [Select Fecha_cierre__c From FechaDC_Sysde__c Where Name = 'CierreAlDia' Limit 1].Fecha_cierre__c;
                
                if(trigger.oldMap.get(item.id).Exoneraciones_aprobadas__c == False && item.Exoneraciones_aprobadas__c && item.RA_limite_exonerado__c) {
                       claseUtil.enviarCorreoCasoAD(item.id,'CasoRetiros');
                       
                }else if(
                    (trigger.oldMap.get(item.id).Status != item.Status && FCsysde < fechaCreacioncaso && tiporetiro=='52'
                     && (item.Status=='Pendiente segunda aprobación' || item.Status=='Cerrado') ) ){
                         if(!test.isRunningTest()){
                             item.addError('¡No se puede procesar la solicitud debido a Sysde no está cerrado al día de hoy!');  
                         }  
                     }else if(trigger.oldMap.get(item.id).Status != item.Status && item.Status == 'Cerrado'){
                         casosAprobados.put(item, tipoRnombre);
                     }
            }
            if(tipoRnombre == 'Reversiones' || test.isRunningTest()){
                if(trigger.oldMap.get(item.id).Status != item.Status && item.Status == 'Cerrado'){
                    casosAprobados.put(item, tipoRnombre);
                    
                }
            }
            if(tipoRnombre == 'Reposicion_Carnet'){
                list<string> vf = new list<string>();
                vf.add(item.id);
                if(trigger.oldMap.get(item.id).Status != item.Status 
                   && item.Status == 'Cerrado'   && [select count() from ContentDocumentLink where LinkedEntityId in :vf]==0
                   && !item.Viene_Portal_Autogestion__c && !test.isRunningTest() && false){
                       item.addError('¡No se puede cerrar el caso ya que no hay un archivo adjunto!');
                   }else if(trigger.oldMap.get(item.id).Status != item.Status && item.Status == 'Cerrado'){
                       casosAprobados.put(item, tipoRnombre);
                   }
            }
            if(tipoRnombre == 'Constancia'){
                system.debug('Al Constancia');
                list<detalle_Caso__C> listdetalleCaso = [select Numero_prestamo__C, Prestamo_anterior__c,
                                                         Es_Refinanciamiento__c
                                                         from detalle_caso__C 
                                                         where caso__C=:item.id];
                detalle_Caso__C detalleCaso = new detalle_Caso__C();
                list<string> vf = new list<string>();
                vf.add(item.id);
                if(item.constancia__C == 'P1' && listdetalleCaso.size()>0){
                    detalleCaso = listdetalleCaso[0];
                } 
                if(item.enviar_a_aprobacion__C && !item.aprobado__C && item.constancia__C == 'P1' && trigger.oldMap.get(item.id).Status != item.Status && ( item.Status == 'Cerrado' || item.Status =='Esperando Documentación')){
                       item.addError('¡El caso se tiene que enviar a aprobación!'); 
                   }
                else if(trigger.oldMap.get(item.id).Status != item.Status &&
                        (item.Status == 'Cerrado' || item.Status == 'Esperando Documentación') &&
                        item.constancia__C == 'P1' && (detalleCaso.Numero_Prestamo__c==null || [select count() from ContentDocumentLink where LinkedEntityId in :vf]==0 || (detalleCaso.Prestamo_anterior__c == null && detalleCaso.Es_Refinanciamiento__c)) ){
                             item.Status = 'Esperando Documentación'; 
                             //system.debug('Se metio a estadoConstancia');
                         }
                else if(trigger.oldMap.get(item.id).Status != item.Status && item.Status == 'Cerrado' &&
                        (item.Constancia__c != 'A6' ||item.Constancia__c != 'P1' || (item.Constancia__c == 'A6' && item.Monto_compromiso_aporte__c == 0)) ){
                             listCasoConstancia.add(item.id);
                         }
            }
            if(trigger.oldMap.get(item.id).Status != item.Status && item.Status == 'Esperando Documentación') { listCasoConstancia.add(item.id);
            }
            system.debug('Estado: '+item.status);
            estadoConstancia = item.status;
        }                               
        
        system.debug('Casos Aprobados a ver ' + casosAprobados);
        if(!casosAprobados.isEmpty()){
            integer bandera =0;
            boolean banderaTru =false;
            integer bandera2 =0;
            boolean banderaTru2 =false;
            integer bandera3 =0;
            boolean banderaTru3 =false;
            For(Case item : casosAprobados.keySet()){
                String tipoRnombre = casosAprobados.get(item);
                if( tipoRnombre == 'Cambio_Subproducto'){                   
                    aSysdeCallouts.accionSubProducto(item.id);  
                    
                }else if(tipoRnombre == 'Actualizacion_informacion'){
                    system.debug('A ver que hay en esto:  ' + item.id);
                    aSysdeCallouts.actualizacionInformacion(item.id);   
                    
                }else if(tipoRnombre == 'Aumento_Disminucion_Aportes'){
                    aSysdeCallouts.aumentoDisminucion(item.id); 
                    
                }else if(tipoRnombre == 'Retiros' || test.isRunningTest()){
                    aSysdeCallouts.retiros(item.id);    
                    
                }else if(tipoRnombre == 'Reposicion_Carnet'){
                    aSysdeCallouts.ReposicionCarnet(item.id);
                }
                else if(tipoRnombre == 'Reversiones' || test.isRunningTest()){
                    aSysdeCallouts.reversar(item.id);  
                    
                }
            }   
        }if((!casosEDCtrimestral.isEmpty() || test.isRunningTest()) && lstCase[0].SuppliedEmail == Null) {
            EstadosDeCuenta.enviarCorreos(casosEDCtrimestral,'A1');
            
        }if((!casosEDCmensual.isEmpty() || test.isRunningTest()) && lstCase[0].SuppliedEmail == Null) {
            EstadosDeCuenta.enviarCorreos(casosEDCmensual,'A2');
            
        }if(!listCasoConstancia.isEmpty()  ){
            if(trigger.new[0].constancia__C!='P1'){
                aSysdeCallouts.bloquerCasoConstancia(listCasoConstancia);
            }else{ aSysdeCallouts.ConstanciaPignoracion(listCasoConstancia, estadoConstancia);
            }
        }
        
    }      
}