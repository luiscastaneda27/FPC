global class verificarFechaCierreSysde implements Schedulable{
    global void execute(SchedulableContext SC){
        aSysdeCallouts.fechaCierreSysde(date.today());
        /*try{
            Boolean cerradoHoy = aSysdeCallouts.fechaCierreSysde(date.today());
            if(cerradoHoy){
                FechaDC_Sysde__c fdcs = [Select Fecha_cierre__c From FechaDC_Sysde__c Where Name = 'CierreAlDia' Limit 1];
                fdcs.Fecha_cierre__c = date.today();
                update fdcs;
            }           
        }Catch(Exception e){
            System.debug('Error en la clase de verificarFechaCierreSysde');
        }*/
    }
}