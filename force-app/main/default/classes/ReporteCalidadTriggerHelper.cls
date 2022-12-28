public class ReporteCalidadTriggerHelper {

    public static void asignarSubEstado(List<Reporte_Calidad__c> listRecords, Map<Id, Reporte_Calidad__c> mapRecords){
        for(Reporte_Calidad__c item: listRecords){
            if(item.Estado__c != mapRecords.get(item.Id).Estado__c && item.Estado__c == 'C'){
                item.SubEstadoRCSF__c = 'C';
            }
        }
    }
    
     public static void registraTiempoSLA(List<Reporte_Calidad__c> listRecords, Map<Id, Reporte_Calidad__c> mapRecords){
         Map<String, EstadoRC> mapRC = new Map<String, EstadoRC>(); 
         Map<String, Decimal> mapTiempo = new Map<String, Decimal>(); 
         for(Reporte_Calidad__c item: listRecords){
             EstadoRC estado = new EstadoRC();
             estado.recordId = item.Id;
             estado.tipoAfilaicion = item.Tipo_Afiliacion__c;
             
             if(getTipoAfiliacion(item.Tipo_Afiliacion__c) && ((item.SubEstadoRCSF__c != null && mapRecords == null) ||
                (mapRecords != null && item.SubEstadoRCSF__c != mapRecords.get(item.Id).SubEstadoRCSF__c))){
                    estado.estadoNuevo = item.SubEstadoRCSF__c;
                    estado.estadoAnterior = mapRecords != null ? mapRecords.get(item.Id).SubEstadoRCSF__c : null;
                    mapRC.put(item.Id, estado);
                }else if(!getTipoAfiliacion(item.Tipo_Afiliacion__c) && 
                         ((item.Estado__c != null && mapRecords == null) ||
                          (mapRecords != null && item.Estado__c != mapRecords.get(item.Id).Estado__c))){
                              estado.estadoNuevo = item.Estado__c;
                              estado.estadoAnterior = mapRecords != null ? mapRecords.get(item.Id).Estado__c : null;
                              mapRC.put(item.Id, estado);
                }
         }
         if(mapRC.size() > 0){
             for(FPC_TiemposSLARC__c item: [Select FPC_Tiempo__c, FPC_Codigo__c from FPC_TiemposSLARC__c ]){
                 mapTiempo.put(item.FPC_Codigo__c, item.FPC_Tiempo__c);
             }
             List<FPC_InicioFinSubEstadosSLARC__c> listTiempo = new List<FPC_InicioFinSubEstadosSLARC__c>();
             for(FPC_InicioFinSubEstadosSLARC__c item:  
                 [Select Id, FPC_EstadoSLA__c, FPC_ReporteCalidad__c, FPC_FechaInicio__c , FPC_FechaFin__c  
                  From FPC_InicioFinSubEstadosSLARC__c Where FPC_ReporteCalidad__c in : mapRC.keySet() and  FPC_FechaFin__c = null]){
                      //EstadoRC estado = mapRC.get(item.FPC_ReporteCalidad__c);
                      item.FPC_FechaFin__c = System.now();
                      listTiempo.add(item);
                  }
             for(String item: mapRC.keySet()){
                 EstadoRC estado = mapRC.get(item);
                 if(estado.estadoNuevo != 'C' && mapTiempo.containsKey(estado.estadoNuevo)){
                     FPC_InicioFinSubEstadosSLARC__c inicio = new FPC_InicioFinSubEstadosSLARC__c();
                     inicio.FPC_FechaInicio__c = System.now();
                     inicio.FPC_EstadoSLA__c = estado.estadoNuevo;
                     inicio.FPC_ReporteCalidad__c = item;
                     inicio.FPC_TiempoConfigurado__c = mapTiempo.containsKey(estado.estadoNuevo) ? mapTiempo.get(estado.estadoNuevo) : 0;
                     listTiempo.add(inicio); 
                 }
             }
             upsert listTiempo;
         }
    }

    public static Boolean getTipoAfiliacion(String tipoA){
        return (tipoA == 'FCA' || tipoA == 'TV' || tipoA == 'TF' || tipoA == 'BFK' || tipoA == 'PM' );
    }    
    public class EstadoRC{
        public String recordId;
        public String estadoNuevo;
        public String estadoAnterior;
        public String tipoAfilaicion;
    }
}