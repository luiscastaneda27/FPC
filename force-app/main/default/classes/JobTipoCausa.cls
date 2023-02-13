global without sharing class JobTipoCausa implements Schedulable { 
    
    global void execute(SchedulableContext ctx) {
        aSysdeReporteCalidad.actualizarCodCausa();
    }

}