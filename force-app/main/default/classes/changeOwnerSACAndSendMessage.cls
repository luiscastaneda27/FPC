public class changeOwnerSACAndSendMessage {
    
    @future
    public static void processCase(String CaseID, String OwnerId) {
        
        Case cs = [Select Id,CaseNumber,OwnerId From Case Where Id =: CaseID];
        
        if(cs.Id != Null) {
            cs.OwnerId = OwnerId;
            update cs;
        }
        
    }

}