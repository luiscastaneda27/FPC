public class ControladorConfiguracionSLARC {
    
    public List<FPC_TiemposSLARC__c> listTiempo{get;set;}
    public String codigo{get;set;}
    
    public ControladorConfiguracionSLARC(){
        iniciar();
    }
    public void iniciar(){
        listTiempo = getPicklistOptions('Reporte_Calidad__c', 'SubEstadoRCSF__c');
        for(FPC_TiemposSLARC__c item: [Select Id, FPC_Estado__c, FPC_Tiempo__c, FPC_Codigo__c from FPC_TiemposSLARC__c]){
            for(FPC_TiemposSLARC__c tiempo: listTiempo){
                if(tiempo.FPC_Codigo__c == item.FPC_Codigo__c){
                    tiempo.Id = item.Id;
                    tiempo.FPC_Tiempo__c = item.FPC_Tiempo__c;
                }
            }
        }
    }
    public void guardar(){
        for(FPC_TiemposSLARC__c tiempo: listTiempo){
            if(tiempo.FPC_Codigo__c == codigo){
                if(tiempo.FPC_Tiempo__c == null || tiempo.FPC_Tiempo__c <= 0){
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'El tiempo del SLA debe ser mayor a cero.'));
                }else{
                    upsert tiempo;
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.CONFIRM, 'Datos guardados exitosamente.'));
                    iniciar();
                }
            }
        }
    }
    
    public void eliminar(){
        FPC_TiemposSLARC__c tiempo = new FPC_TiemposSLARC__c(Id = codigo);
        delete tiempo;
        iniciar();
    }
    
    public static List<FPC_TiemposSLARC__c> getPicklistOptions(String objApiName, String fieldApiName){
        List<FPC_TiemposSLARC__c> lOptions = new List<FPC_TiemposSLARC__c>();
        SObjectType objectType = Schema.getGlobalDescribe().get(objApiName);
        List<Schema.PicklistEntry> ple = objectType.getDescribe()
            .fields.getMap()
            .get(fieldApiName)
            .getDescribe().getPickListValues();
        for(Schema.PicklistEntry entry : ple)  {
            if(entry.getValue() != 'C'){
                lOptions.add(new FPC_TiemposSLARC__c(FPC_Estado__c = entry.getLabel(), FPC_Codigo__c = entry.getValue()));
            }
        }
        return lOptions;
    }
}