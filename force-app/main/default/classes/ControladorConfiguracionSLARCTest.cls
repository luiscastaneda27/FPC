@isTest
public class ControladorConfiguracionSLARCTest {
    
    @testSetup 
    static void setupMethod() {
        // no necesita insertar registros
    }
    
    static testMethod void ControladorConfiguracionSLARCExecute(){
        ControladorConfiguracionSLARC controlador = new ControladorConfiguracionSLARC();
        controlador.tiempoSLA.FPC_PantallaRC__c = 'I';
        controlador.iniciar();
        controlador.listTiempo[0].FPC_Tiempo__c = 1;
        controlador.codigo = controlador.listTiempo[0].FPC_Codigo__c;
        controlador.guardar();
        controlador.listTiempo[1].FPC_Tiempo__c = 2;
        controlador.codigo = controlador.listTiempo[1].FPC_Codigo__c;
        controlador.guardar();
        controlador.codigo = controlador.listTiempo[0].Id;
        controlador.eliminar();
    }

}