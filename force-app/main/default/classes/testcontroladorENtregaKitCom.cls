@isTest
public class testcontroladorENtregaKitCom {
	@isTest static void executeTest() {
        Usuarios_de_Pantallas__c usuario = new Usuarios_de_Pantallas__c ();
        usuario.Activo__c = true;
        usuario.Usuario__c = 'juan123';
        usuario.Contrase_a__c = 'juan123';
        usuario.name = 'Juan';
        usuario.Apellido__c='Perez';
        usuario.Email__c = 'juanperez@test.com';
        insert usuario;
        
        Reporte_calidad__C afiliacion = new Reporte_calidad__C();
        afiliacion.Codigo_Asesor_Comercial__c = usuario.Usuario__c;
        afiliacion.Entrega_KIT__C = 'S';
        afiliacion.Espediente_Completo__c = 'S';
        afiliacion.Identificacion__c = '1234';
        insert afiliacion;
        
        afiliacion = new Reporte_calidad__C();
        afiliacion.Codigo_Asesor_Comercial__c = usuario.Usuario__c;
        afiliacion.Entrega_KIT__C = 'S';
        afiliacion.Espediente_Completo__c = 'S';
        afiliacion.Identificacion__c = '12345';
        insert afiliacion;
            
        
        
        
        Test.StartTest();
        ApexPages.currentPage().getParameters().put('usuario',usuario.Usuario__c);
        controladorENtregaKitCom controller = new controladorENtregaKitCom();
        controller.idAfiliacion = controller.listAfiliaciones[0].id;
        controller.editar();
        controller.guardar();
        controller.idAfiliacion = controller.listAfiliaciones[0].id;
        controller.editar();
        controller.ValidacionIdentidad();
        
       // controller.ValidacionIdentidad();
        
        
        /*controller.listSubProductos = new list<selectOption>();
        controller.listEmpresas = new list<selectOption>();
        controller.NombreProducto = 'Test';
        controller.URLPagina = 'url';
        controller.reiniciar();
        controller.editar();
        controller.guardar();
        controller.ValidacionIdentidad();
        Test.StopTest();*/
    }
}