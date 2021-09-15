public with sharing class LP_CaseMilestone extends fflib_SObjectDomain{
    private static final String STR_ASIGNACION = 'Asignado';
    private static final String STR_ENGESTION = 'En Gestión';
    private static final String STR_GESTIONADO = 'Gestionado';
    private static final String STR_FINALIZADO = 'Finalizado';
    
    public LP_CaseMilestone(List<CaseMilestone> sObjectList) {
        super(sObjectList);
    }
    
    public static void updateCaseMilestone(LP_Cases cases, Map<Id, Case> mapOld, fflib_SObjectUnitOfWork uow) {
        map<string, CaseMilestone> mapCaseMilestone = new map<string, CaseMilestone>();
        list<CaseMilestone> listCaseMilestoneToUpdate = new list<CaseMilestone>();
        for(CaseMilestone item : new LP_CaseMilestoneSelector().selectCaseMilestoneByCaseId(cases.Records)){
            mapCaseMilestone.put(item.CaseId + item.MilestoneType.Name, item);
        }
        
        boolean notUpdate = false;
        for(Case cas : (List<Case>) cases.Records) {
            if(cas.Status != 'Cancelado' && !cas.IsClosedOnCreate && cas.LP_Asignado__c && !mapOld.get(cas.id).LP_Asignado__c){
                listCaseMilestoneToUpdate.add(completeCaseMilestone(mapCaseMilestone.get(cas.id + STR_ASIGNACION)));

            }else if(!cas.LP_CierreAutomatico__c && cas.Status != 'Cancelado' && cas.Status == 'En Gestión' && !cas.IsClosedOnCreate && mapOld.get(cas.id).Status == 'Asignado'){
                listCaseMilestoneToUpdate.add(completeCaseMilestone(mapCaseMilestone.get(cas.id + STR_ENGESTION)));
            
            }else if(cas.Status == 'Cancelado' && !cas.IsClosedOnCreate && cas.Status != mapOld.get(cas.id).Status && mapOld.get(cas.id).Status == 'Asignado'){
                listCaseMilestoneToUpdate.add(completeCaseMilestone(mapCaseMilestone.get(cas.id + STR_ENGESTION)));
                
            }else if(!cas.LP_CierreAutomatico__c && cas.Status == 'Finalizado' && cas.Status != 'Cancelado' && !cas.IsClosedOnCreate && mapOld.get(cas.id).Status != 'Asignado' && mapOld.get(cas.id).Status != 'Gestionado'){
                listCaseMilestoneToUpdate.add(completeCaseMilestone(mapCaseMilestone.get(cas.id + STR_ENGESTION)));
            
            }else if(cas.Status != 'Cancelado' && !cas.IsClosedOnCreate && cas.Status == 'Gestionado' && cas.Status != mapOld.get(cas.id).Status){
                listCaseMilestoneToUpdate.add(completeCaseMilestone(mapCaseMilestone.get(cas.id + STR_GESTIONADO)));
                
            }else if( cas.LP_NumeroDeRechazos__c < 2 && cas.LP_CierreAutomatico__c && !cas.IsClosedOnCreate && (cas.Status == 'Finalizado' && cas.Status != 'Cancelado') && cas.Status != mapOld.get(cas.id).Status && mapOld.get(cas.id).Status != 'Asignado'){
                	listCaseMilestoneToUpdate.add(completeCaseMilestone(mapCaseMilestone.get(cas.id + STR_GESTIONADO)));    
                    
            }else if(cas.LP_NumeroDeRechazos__c == 2 && !cas.IsClosedOnCreate && cas.Status != 'Cancelado' && cas.Status != mapOld.get(cas.id).Status && mapOld.get(cas.id).Status != 'Asignado'){           
                	listCaseMilestoneToUpdate.add(completeCaseMilestone(mapCaseMilestone.get(cas.id + STR_GESTIONADO)));
                
            }else if(cas.LP_CierreAutomatico__c && cas.LP_NumeroDeRechazos__c < 2 && !cas.IsClosedOnCreate && cas.Status == 'Finalizado' && cas.Status != mapOld.get(cas.id).Status && mapOld.get(cas.id).Status != 'En Gestión' && mapOld.get(cas.id).Status != 'Asignado'){           
                	listCaseMilestoneToUpdate.add(completeCaseMilestone(mapCaseMilestone.get(cas.id + STR_GESTIONADO)));
            
            }else if( cas.LP_NumeroDeRechazos__c < 2 && !cas.LP_CierreAutomatico__c && !cas.IsClosedOnCreate && (cas.Status == 'Finalizado' && cas.Status != 'Cancelado') && cas.Status != mapOld.get(cas.id).Status && mapOld.get(cas.id).Status != 'Asignado'){           
                	listCaseMilestoneToUpdate.add(completeCaseMilestone(mapCaseMilestone.get(cas.id + STR_FINALIZADO)));
                
            }else{
                notUpdate = true;
            }
            uow.registerDirty(cas);
        }
        system.debug(listCaseMilestoneToUpdate);
        if(!notUpdate) update listCaseMilestoneToUpdate;

    }

    static CaseMilestone completeCaseMilestone(CaseMilestone caseM){
        caseM.CompletionDate = system.now();
        return caseM;
    }

}