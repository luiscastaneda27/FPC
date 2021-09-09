public class ContactController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
        try{
            system.debug('llego');
            Integer p = Integer.valueOf('s');
            
            return [
                SELECT FirstName, LastName, Email
                FROM Contact
                WITH SECURITY_ENFORCED
                ORDER BY Name 
            ];
        }catch (Exception e){
            throw new AuraHandledException('Forced error'); 
        }
    }

}