public class ReporteCalidadTriggerHandler {
    
    public static void beforeUpdate(List<Reporte_Calidad__c> listRecords, Map<Id, Reporte_Calidad__c> mapRecords){
        ReporteCalidadTriggerHelper.asignarSubEstado(listRecords, mapRecords);
    }
    
    public static void afterUpdate(List<Reporte_Calidad__c> listRecords, Map<Id, Reporte_Calidad__c> mapRecords){
        ReporteCalidadTriggerHelper.registraTiempoSLA(listRecords, mapRecords);
    }
    
    public static void afterInsert(List<Reporte_Calidad__c> listRecords, Map<Id, Reporte_Calidad__c> mapRecords){
        ReporteCalidadTriggerHelper.registraTiempoSLA(listRecords, mapRecords);
    }

}