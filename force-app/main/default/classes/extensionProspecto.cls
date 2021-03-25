public class extensionProspecto {
    public lead prospecto{get;Set;}
    public boolean natural{get;set;}
    
    public extensionProspecto(ApexPages.StandardController controller) {
        prospecto = (Lead)controller.getRecord();
        
        if(prospecto.id == null){
            prospecto.ownerId = userInfo.getUserId();
        }
        
        natural = false;
        RecordType tipoR = [Select developerName From RecordType Where Id =: prospecto.recordTypeId];
        if(tipoR.developerName == 'Natural'){
            natural = true;
        }  
    }

}