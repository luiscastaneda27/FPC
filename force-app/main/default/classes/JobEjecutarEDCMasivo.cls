global with sharing class JobEjecutarEDCMasivo implements Schedulable { 
    global void execute(SchedulableContext ctx) {
        FechaDC_Sysde__c fcsd = [Select Fecha_cierre__c,id,Trimestre_Terminado__C From FechaDC_Sysde__c where name = 'CierreAlDia'];
        if(fcsd.Trimestre_Terminado__C){
            Id batch= Database.executeBatch(new batchCambioEstadoEDC(), 9999);
            aSysdeCallouts.EjecutarJobEDCMasivo(date.today());
        }
    }
}