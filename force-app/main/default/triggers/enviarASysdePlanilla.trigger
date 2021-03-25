trigger enviarASysdePlanilla on Planilla__c (Before Update) {
    try{
        if(claseUtil.canIRun()){  
            set<Id> listEnviar = new set<Id>();     
            For(Planilla__c item : trigger.new){
                if(trigger.oldMap.get(item.id).Estado2__c != item.Estado2__c 
                  && item.Estado2__c == 'Cerrada'){
                    listEnviar.add(item.id);    
                }
            }
            if(!listEnviar.isEmpty())
                system.debug(listEnviar);
                aSysdePortalEmpresarial.cerrarPlanilla(listEnviar);
        }
    }Catch(Exception e){
        system.debug('Ha ocurrido un error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
    }
}