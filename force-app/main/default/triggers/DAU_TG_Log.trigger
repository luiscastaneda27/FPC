trigger DAU_TG_Log on DAU_Salesforce_Tarjetas__e (after insert) {
    if(Trigger.isInsert) {
        if (Trigger.isAfter) {
            DAU_TG_LogHelper.ProcessLog(trigger.new);
        }
    }
}