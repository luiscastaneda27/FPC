@isTest
public class ControlorReporteCalidadPenFisSacTest {
    
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
        
        Producto__c producto = new Producto__C();
        producto.Codigo__c = '01';
        producto.CurrencyIsoCode = 'HNL';
        insert producto;
                
        SubProducto__C subP = new SubProducto__C ();
        subP.Producto__c = producto.id;
        subP.Codigo__c = 'FPC1O';
        subP.Name = 'Sub 1';
        insert subP;

        
        Oficial_X_Asesor__c asesor = new  Oficial_X_Asesor__c ( Codigo_Asesor__c = 'HN22258', Codigo_Oficial_SAC__c = usuario.Usuario__c);
        insert asesor; 
        
        Reporte_calidad__c RC = new Reporte_calidad__c();
        RC.SubEstadoRCSF__c = 'PF';
        RC.Codigo_Asesor_Comercial__c = usuario.Usuario__c;
        insert RC;
        
    }
    
    static testMethod void ControlorReporteCalidadPenFisSacExecute(){
        Test.startTest();
        
        Usuarios_de_Pantallas__c user1 = [Select Usuario__c from Usuarios_de_Pantallas__c  limit 1]; 
        
        ApexPages.currentPage().getParameters().put('usuario',user1.Usuario__c);
        ControlorReporteCalidadPenFisSac controller = new ControlorReporteCalidadPenFisSac();
        controller.listAfiliaciones[0].Enviar_Sac__c = true;
        controller.Enviar();
        Test.stopTest();
    }
    

}