@istest
public class ControladorCrearUsuarioTest {
    
    
    static testmethod void clasesutilizadas() {
        ApexPages.StandardController stdController = new ApexPages.StandardController(new Usuario_Portal_Empresarial__c());
        ControladorCrearUsuario controller = new ControladorCrearUsuario(stdController);
        controller.regresar();
        controller.correo='frfr@cfd.com';
        controller.Nombre='frfrcfd.com';
        controller.Apellido='frfrfd.com';
        controller.Num_identidad='0404199500043';
        controller.crearUsuario();
        controller.Num_identidad='040419950032';
        controller.Buscarusuario();
        controller.Num_identidad='0404199500043';
        controller.Buscarusuario();
        
    }
        

}