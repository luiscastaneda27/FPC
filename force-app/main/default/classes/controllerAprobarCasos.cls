public class controllerAprobarCasos {
    public Case caso{get;set;}
    public Detalle_caso__c detalleCaso{get;set;}
    public list<Detalle_caso__c> listSaldosCaso{get;Set;}
    public claseTipoCaso cTipoCaso{get;set;}
    public boolean mbAprobado{get;set;}
    public boolean popAdjuntar{get;set;}
    public string comentarios{get;Set;}
    public list<ProcessInstanceHistory> historialApp{get;set;}
    Id newWorkItemIds;
    
    public controllerAprobarCasos(){
        try{
            Caso = [Select Owner.Name, RecordTypeId, CaseNumber, Account.Name, Status, Type, Origin,
                    Priority, Subject, Description,Account.IsPersonAccount, RecordType.DeveloperName
                    From Case
                    Where Id =: ApexPages.currentPage().getParameters().get('id')];
            cTipoCaso = new claseTipoCaso(Caso.RecordType.DeveloperName);
                    
            listSaldosCaso = [Select Tipo_Operacion__c,Nuevo_monto_aporte__c,Nuevo_canal_aporte__c,N_Cuenta_Bancaria__c,
                    Nueva_fecha_aporte__c,Mes__c,Ano_tarjeta__c,Frecuencia__c, Cuenta__r.Name, Cuenta__r.Subproducto__r.Name,
                    Cuenta__r.Cuenta_Colectiva2__r.Name, Cuenta__r.Fecha_aporte__c, Cuenta__r.Monto_aporte__c,
                    Cuenta__r.Frecuencia_Aportacion__c, Cuenta__r.Forma_Aportacion__c
                    ,Tipo_retiro__c,Comision_Retiro_Anticipado__c,Cliente_quiere_capital_semilla__c,Cliente_sigue_Laborando__c,
                    Comision_retiro_anticipado_empresa__c,Porcentaje_comision__c,Cobrar_empleado_sigue_laborando__c,
                    Permitir_Retiro_Saldos_Patronales__c,Forma_Retiro__c,Cobro_TSP__c,Cobro_Cheque__c,
                    Banco__c,Tipo_Cuenta__c,currencyIsoCode,Cobro_ACH__c,Saldo_retirar__c,Monto_saldo__c,Monto_retirar__c
                    From Detalle_caso__c
                    Where Caso__c =: Caso.Id order by Cabeza_retiro__c desc];
            
            if(!listSaldosCaso.isEmpty()){
                detalleCaso = listSaldosCaso[0];
                if(cTipoCaso.retiros){
                    listSaldosCaso.remove(0);  
                }
            }

            comentarios = '';
            
            list<ProcessInstance> procesos = [SELECT Id, (SELECT Id, ActorId, IsPending, StepStatus, Comments FROM StepsAndWorkitems)
                    FROM ProcessInstance Where TargetObjectId =: Caso.id];
            
            newWorkItemIds = [SELECT Id FROM ProcessInstanceWorkitem 
                                 WHERE processInstance.TargetObjectId=: Caso.Id].Id;
           
            historialApp = new list<ProcessInstanceHistory>(); 
            For(ProcessInstance proceso : [SELECT Id, 
                          (SELECT Id, ActorId, IsPending, StepStatus, Comments,ProcessInstance.CompletedDate,
                          ElapsedTimeInDays,ElapsedTimeInHours,ElapsedTimeInMinutes,ProcessInstance.CreatedDate 
                          FROM StepsAndWorkitems order by ProcessInstance.CreatedDate desc)
                              FROM ProcessInstance Where TargetObjectId =: Caso.id order by CreatedDate desc]){
              
              For(ProcessInstanceHistory item : proceso.StepsAndWorkitems){
                historialApp.add(item);  
              }
            }
            
            mbAprobado = true;
            popAdjuntar = false;            
        }Catch(Exception e){
            mbAprobado = False; 
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, '¡No tiene proceso de aprobación pendiente!'));    
        }
    }
    
    public void cerrar(){
        popAdjuntar = false;
    }
    
    public void adjuntar(){
        popAdjuntar = true;
    }
    
    public void aprobar(){
        accionFinal('Approve');
    }   
    
    public void rechazar(){
        if(comentarios == null || comentarios == '' || comentarios.length() < 5){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR, 
                                'Debes especificar el motivo del rechazo en el campo comentario')); 
        }else{
            accionFinal('Reject');
        }
    }
    
    public void accionFinal(String accion){
        try{
            User user1 = [Select Id From User Where Alias = 'AUser' AND isActive = true Limit 1];
            
            //Id newWorkItemIds = [SELECT Id FROM ProcessInstanceWorkitem 
              //                   WHERE processInstance.TargetObjectId=: Caso.Id].Id;
            
            Approval.ProcessWorkitemRequest req2 = new Approval.ProcessWorkitemRequest();
            req2.setComments(comentarios);
            req2.setAction(accion);
            req2.setNextApproverIds(new Id[] {User1.id});
            
            req2.setWorkitemId(newWorkItemIds);
            
            Approval.ProcessResult result2 =  Approval.process(req2);          
            
            mbAprobado = true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Confirm, 'Gracias.!')); 
            mbAprobado = False; 
        }Catch(Exception e){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL, 'Error: No existe proceso de aprobación pendiente'));        
        }
    }
}