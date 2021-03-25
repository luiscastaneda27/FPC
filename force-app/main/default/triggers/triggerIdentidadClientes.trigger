trigger triggerIdentidadClientes on Account (before insert, before update) {
    try{
        RecordType TipoR = [Select id 
                            From RecordType 
                            Where sObjectType = 'Account'
                            AND DeveloperName = 'Natural' Limit 1];
        
        For(Account cliente : trigger.new){
            if(cliente.recordTypeId == TipoR.id){
                cliente.Identificacion__c = cliente.Identificacion__c.replace('-','');
                cliente.Identificacion__c = cliente.Identificacion__c.replace(' ','');
            }
        }
        
    }Catch(Exception e){
        
    }
}