trigger ReporteCalidadTrigger on Reporte_Calidad__c (before insert, after insert, before update, after update) {
    if(trigger.isInsert){
        if(trigger.isAfter){
            ReporteCalidadTriggerHandler.afterInsert(trigger.new, null);
        }
    }else if(trigger.isUpdate){
        if(trigger.isBefore){
            ReporteCalidadTriggerHandler.beforeUpdate(trigger.new, trigger.oldMap);
        }else if(trigger.isAfter){
            ReporteCalidadTriggerHandler.afterUpdate(trigger.new, trigger.oldMap);
        }
    }
}