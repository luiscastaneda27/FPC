@isTest
public class testRiesgoPrincipal {
    
    static testMethod void controladorRiesgoPrincipal(){ 
        test.startTest();
        
        controladorRiesgoPrincipal nv = new controladorRiesgoPrincipal();
        nv.ReporteFechaConsti();
        nv.RiesgoAPA();
        nv.RiesgoCliente();
        nv.Riesgodocumento();
        nv.RiesgoFechaAfilia();
        nv.RiesgoFechaConsti();
        nv.RiesgoFechaNacimiento();
        nv.RiesgoGeografico();
        nv.RiesgoProducto();
        nv.RiesgoTPE();
        nv.RiesgoVar();
        nv.TipoPersona();
        nv.VariablesRiesgo();
            
            }
    
}