@istest
public class testcontroladorReporteCalidad_BFH_PM_FIC {
    
    static testMethod void controladorReporteCalidad_BFH_PM_FIC(){
        Usuarios_de_Pantallas__c usuario = new Usuarios_de_Pantallas__c ();
        usuario.Activo__c = true;
        usuario.Usuario__c = 'juan123';
        usuario.Contrase_a__c = 'juan123';
        usuario.name = 'Juan';
        usuario.Apellido__c='Perez';
        usuario.Email__c = 'juanperez@test.com';
        insert usuario; 
        
        Producto__C producto=New Producto__C();
        producto.Codigo__c='01';
        producto.CurrencyIsoCode='HNL';
        producto.Name = 'Test';
        insert producto;
        
        SubProducto__C subP = new SubProducto__C ();
        subP.Producto__c = producto.id;
        subP.Codigo__c = 'FPC1O';
        subP.Name = 'Sub 1';
        insert subP;
        
        subP = new SubProducto__C ();
        subP.Producto__c = producto.id;
        subP.Codigo__c = 'USD';
        subP.Name = 'Sub 2';
        insert subP;
        
        
        Account empresa= new Account();
        empresa.Name='Empresa Prueba 1';
        empresa.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Juridico').getRecordTypeId();
        empresa.Identificacion__c='012j0000';
        empresa.Cliente_Unico_Banco__c = '123';
        insert empresa;
        
        cuentas__C cuenta = new cuentas__C ();
        cuenta.Cliente__c = empresa.id;
        cuenta.Activo__c = true;
        cuenta.Producto__c = producto.Id;
        cuenta.Subproducto__c = subP.Id;
        cuenta.Codigo__c = '12345';
        insert cuenta;
        
        Reporte_calidad__C afiliacion = new Reporte_calidad__C();
        afiliacion.Enviar_Sac__C = true; 
        afiliacion.Codigo_Oficial_SAC__c = usuario.Usuario__c;
        afiliacion.Tipo_Afiliacion__C = 'BFK';
        insert afiliacion;
        afiliacion = new Reporte_calidad__C();
        
        Oficial_X_Asesor__c oficial = new Oficial_X_Asesor__c();
        oficial.Codigo_Oficial_SAC__c = usuario.Usuario__c;
        oficial.Oficial_SAC__c = userinfo.getUserId();
        oficial.Codigo_Oficial_SAC__c = usuario.Usuario__c;
        oficial.Asesor__c = userinfo.getUserId();
        insert oficial;
        
        
        
        ApexPages.currentPage().getParameters().put('usuario',usuario.Usuario__c);
        ApexPages.currentPage().getParameters().put('idPantalla','BFK'); 
        controladorReporteCalidad_BFH_PM_FIC controlador= new controladorReporteCalidad_BFH_PM_FIC();
        controlador.traerClientes();
        controlador.idAfiliacion = controlador.listAfiliaciones[0].id;
        afiliacion.id = controlador.listAfiliaciones[0].id;
        controlador.editar();
        controlador.Afiliacion.espediente_completo__C = 'N';
        controlador.guardar();
        
        afiliacion.Enviar_Sac__c = true;
        update afiliacion;
        controlador.reinicar();
        controlador.idAfiliacion = controlador.listAfiliaciones[0].id;
        controlador.editar();
        controlador.Afiliacion.espediente_completo__C = 'S';
        afiliacion.Documentacion_Recibida__c = 'S';
        controlador.subEstado = 'S';
        controlador.guardar();
        controlador.accionVacia();
        
    }
    
    
}