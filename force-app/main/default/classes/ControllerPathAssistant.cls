public class ControllerPathAssistant {
    
    @AuraEnabled
    public static List<ObjectOption> getValuesPicklistByObject(String objectApiName){
        try{
            List<ObjectOption> lOptions = new List<ObjectOption>();
            Schema.DescribeSObjectResult oppDescribe = Schema.getGlobalDescribe().get(objectApiName).getDescribe();
            Map<String, Schema.SObjectField> fields = oppDescribe.fields.getMap();
            
            for (Schema.SObjectFIeld field: fields.values()){
                Schema.DisplayType fielddataType = field.getDescribe().getType();
                if(fielddataType == Schema.DisplayType.Picklist) {
                    //picklistMap.put(field.getDescribe().getName(), field.getDescribe().getLabel());
                    ObjectOption option = new ObjectOption();
                    option.label = field.getDescribe().getLabel();
                    option.value = field.getDescribe().getName();
                    lOptions.add(option);
                }
            }
            system.debug(lOptions);
            return lOptions;
        }catch(Exception ex){
            return null;
        }
    }
    
     @AuraEnabled
    public static List<PicklistOption> getPicklistOptions(String fieldApiName){
        system.debug('fieldApiName: '+fieldApiName);
        List<PicklistOption> lOptions = new List<PicklistOption>();
        SObjectType objectType = Schema.getGlobalDescribe().get('Task');
        List<Schema.PicklistEntry> ple = objectType.getDescribe()
                                                   .fields.getMap()
                                                   .get(fieldApiName)
                                                   .getDescribe().getPickListValues();
        for(Schema.PicklistEntry entry : ple){
            PicklistOption option = new PicklistOption();
            option.label = entry.getLabel();
            option.value = entry.getValue();
            if(fieldApiName != 'CallType__c' || (option.value == 'Ventas' || option.value == 'Servicio'))
            	lOptions.add(option);
		}
        return lOptions;
    }
    
    public class PicklistOption{
        @AuraEnabled public String label{get;set;}
        @AuraEnabled public String value{get;set;}

    }
    public class ObjectOption{
        @AuraEnabled public String label{get;set;}
        @AuraEnabled public String value{get;set;}

    }

}