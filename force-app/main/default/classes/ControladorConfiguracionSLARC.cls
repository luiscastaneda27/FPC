public class ControladorConfiguracionSLARC {
    
    public List<FPC_TiemposSLARC__c> listTiempo{get;set;}
    public FPC_TiemposSLARC__c tiempoSLA{get;set;}
    Map<String, String> mapPantallasLabel;
    
    public String codigo{get;set;}
    
    public ControladorConfiguracionSLARC(){
        tiempoSLA = new FPC_TiemposSLARC__c();
        mapPantallasLabel = new Map<String, String>();
        for(FPC_TiemposSLARC__c item: getPicklistOptions('FPC_TiemposSLARC__c', 'FPC_PantallaRC__c', null)){
            mapPantallasLabel.put(item.FPC_Codigo__c, item.FPC_Estado__c);
        }
    }
    public void iniciar(){
        listTiempo = getPicklistOptions('FPC_TiemposSLARC__c', 'FPC_EstadoSLA__c', tiempoSLA.FPC_PantallaRC__c);
        for(FPC_TiemposSLARC__c item: [Select Id, FPC_Estado__c, FPC_Tiempo__c, FPC_Codigo__c, FPC_PantallaRC__c from FPC_TiemposSLARC__c where FPC_PantallaRC__c =:tiempoSLA.FPC_PantallaRC__c]){
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
    
    public List<FPC_TiemposSLARC__c> getPicklistOptions(String objApiName, String fieldApiName, String value){
        List<FPC_TiemposSLARC__c> lOptions = new List<FPC_TiemposSLARC__c>();
        try{
            SObjectType objectType = Schema.getGlobalDescribe().get(objApiName);
            Map<String, FPC_TiemposSLARC__c> mapOptiones = new Map<String, FPC_TiemposSLARC__c>();
            List<Schema.PicklistEntry> ple = objectType.getDescribe()
                .fields.getMap()
                .get(fieldApiName)
                .getDescribe().getPickListValues();
            for(Schema.PicklistEntry entry : ple)  {
                FPC_TiemposSLARC__c option = new FPC_TiemposSLARC__c();
                option.FPC_Estado__c = entry.getLabel();
                option.FPC_Codigo__c = entry.getValue();
                option.FPC_PantallaRC__c = tiempoSLA.FPC_PantallaRC__c;
                option.FPC_EstadoSLA__c = entry.getValue();
                lOptions.add(option);
                mapOptiones.put(option.FPC_Estado__c, option);
            }
            if(value != null){
                Map<String, List<String>> dependent = dependentPicklist(objApiName, fieldApiName);
                lOptions = new List<FPC_TiemposSLARC__c>();
                value = mapPantallasLabel.get(value);
                for(String item: dependent.get(value)){
                    FPC_TiemposSLARC__c option = mapOptiones.get(item);
                    lOptions.add(option);
                }
            }
        }catch(Exception ex){
            System.debug('Error: '+ex.getLineNumber());
            listTiempo = new List<FPC_TiemposSLARC__c>();
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'Esta pantalla no tiene estados configurados.'));
        }
        return lOptions;
    }
    
    public Map<String, List<String>> getDependentPicklistValues(Schema.sObjectField dependToken) {
        Schema.DescribeFieldResult depend = dependToken.getDescribe();
        Schema.sObjectField controlToken = depend.getController();
        if (controlToken == null) {
            return new Map<String, List<String>>();
        }
        
        Schema.DescribeFieldResult control = controlToken.getDescribe();
        List<Schema.PicklistEntry> controlEntries;
        if(control.getType() != Schema.DisplayType.Boolean) {
            controlEntries = control.getPicklistValues();
        }
        
        String base64map = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
        Map<String,List<String>> dependentPicklistValues = new Map<String,List<String>>();
        for (Schema.PicklistEntry entry : depend.getPicklistValues()) {
            if (entry.isActive() && String.isNotEmpty(String.valueOf(((Map<String,Object>) JSON.deserializeUntyped(JSON.serialize(entry))).get('validFor')))) {
                List<String> base64chars =
                    String.valueOf(((Map<String,Object>) JSON.deserializeUntyped(JSON.serialize(entry))).get('validFor')).split('');
                for (Integer index = 0; index < (controlEntries != null ? controlEntries.size() : 2); index++) {
                    Object controlValue =
                        (controlEntries == null
                         ?   (Object) (index == 1)
                         :   (Object) (controlEntries[index].isActive() ? controlEntries[index].getLabel() : null)
                        );
                    Integer bitIndex = index / 6;
                    if (bitIndex > base64chars.size() - 1) {
                        break;
                    }
                    Integer bitShift = 5 - Math.mod(index, 6);
                    if  (controlValue == null || (base64map.indexOf( base64chars[ bitIndex ] ) & (1 << bitShift)) == 0)
                        continue;
                    if (!dependentPicklistValues.containsKey((String) controlValue)) {
                        dependentPicklistValues.put((String) controlValue, new List<String>());
                    }
                    dependentPicklistValues.get((String) controlValue).add(entry.getLabel());
                }
            }
        }
        return dependentPicklistValues;
    }
    
    public Map<String, List<String>> dependentPicklist(String objApiName, String fieldApiName){
        SObjectType objectType = Schema.getGlobalDescribe().get(objApiName);
        Schema.sObjectField dependToken = objectType.getDescribe()
            .fields.getMap()
            .get(fieldApiName)
            .getDescribe().getSObjectField();
        return getDependentPicklistValues(dependToken);
    }
}