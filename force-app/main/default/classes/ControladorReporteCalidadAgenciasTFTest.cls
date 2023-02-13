@isTest
public class ControladorReporteCalidadAgenciasTFTest {

    @testSetup 
    static void setupMethod() {
        Usuarios_de_Pantallas__c usuario = new Usuarios_de_Pantallas__c ();
        usuario.Activo__c = true;
        usuario.Usuario__c = 'HN123';
        usuario.Contrase_a__c = 'juan123';
        usuario.name = 'Juan';
        usuario.Apellido__c='Perez';
        usuario.Email__c = 'juanperez@test.com';
        usuario.Perfil__c = 'SGS';
        insert usuario;
         Producto__C producto=New Producto__C();
        producto.Codigo__c='01';
        producto.CurrencyIsoCode='HNL';
        insert producto;
                
        SubProducto__C subP = new SubProducto__C ();
        subP.Producto__c = producto.id;
        subP.Codigo__c = 'FPC1O';
        subP.Name = 'Sub 1';
        insert subP;

        
        Oficial_X_Asesor__c asesor = new  Oficial_X_Asesor__c ( Codigo_Asesor__c = 'HN22258', Codigo_Oficial_SAC__c = usuario.Usuario__c);
        insert asesor; 
        
    }
    
    static testMethod void ControladorReporteCalidadAgenciasTFExecute(){
        Test.startTest();
        
        Usuarios_de_Pantallas__c user1 = [Select Usuario__c from Usuarios_de_Pantallas__c  limit 1]; 
        
        ApexPages.currentPage().getParameters().put('usuario',user1.Usuario__c);
        ControladorReporteCalidadAgenciasTF controller= new ControladorReporteCalidadAgenciasTF();
        
        controller.reinicar();
        controller.traerClientes();
        controller.idAfiliacion = controller.listAfiliaciones[0].Id;
        controller.editar();
        controller.Afiliacion.Documentacion_Recibida__c = 'S';
        controller.Afiliacion.Espediente_Completo__c = 'S';
        controller.Afiliacion.ExpedienteFisicoRecibido__c = 'S';
        controller.Afiliacion.FirmaExpediente__c = 'S';
        controller.guardar();
        Test.stopTest();
    }
    
}