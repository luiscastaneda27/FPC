@istest
public class testbatchCambioEstadoEDC {
	
    static testmethod void clasesutilizadas() {
        Correo_estado_cuenta__c v = new Correo_estado_cuenta__c (enviado__C=true);
        insert v;
        
        FechaDC_Sysde__c b = new FechaDC_Sysde__c (Fecha_cierre__c=date.today(),Trimestre_Terminado__C = true,name = 'CierreAlDia');
        insert b;
        
        SchedulableContext ctx;
         JobEjecutarEDCMasivo n = new JobEjecutarEDCMasivo();
        n.execute(ctx);
        
        account natural2 = new account();
        
        ExtensionEmpresasEDC c = new ExtensionEmpresasEDC(new ApexPages.StandardController(natural2));
        c.ImprimirEDC();
    }
}