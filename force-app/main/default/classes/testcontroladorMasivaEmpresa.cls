@isTest
public class testcontroladorMasivaEmpresa {
    @isTest static void executeTest() {
        
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
        insert producto;
        
        producto=New Producto__C();
        producto.Codigo__c='02';
        producto.CurrencyIsoCode='USD';
        insert producto;
        
        SubProducto__C subP = new SubProducto__C ();
        subP.Producto__c = producto.id;
        subP.Codigo__c = 'FI010';
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
        afiliacion.Identificacion__c = '123';
        afiliacion.Espediente_Completo__c = 'S';
        afiliacion.Name = 'Test';
        afiliacion.Codigo_Oficial_SAC__c = usuario.Usuario__c;
        insert afiliacion;
        
        Oficiales_X_Empresa__c oficial = new Oficiales_X_Empresa__c();
        oficial.Empresa__c = empresa.id;
        oficial.Asesor__c = userinfo.getUserId();
        oficial.Codigo_Asesor__c = usuario.Usuario__c;
        oficial.Oficial_SAC__c = userinfo.getUserId();
        oficial.Codigo_Oficial_SAC__c = usuario.Usuario__c;
        insert oficial;
        
        Oficial_X_Asesor__c oficial2 = new Oficial_X_Asesor__c();
        oficial2.Codigo_Oficial_SAC__c = usuario.Usuario__c;
        oficial2.Oficial_SAC__c = userinfo.getUserId();
        oficial2.Codigo_Asesor__c = usuario.Usuario__c;
        oficial2.Asesor__c = userinfo.getUserId();
        insert oficial2;
        
        //Test.StartTest();
        ApexPages.currentPage().getParameters().put('usuario',usuario.Usuario__c);
        controladorMasivaEmpresa controller = new controladorMasivaEmpresa();
        controller.buscarEmpresa = 'Empresa Prueba 1231';
        controller.BuscarEmpresa();
        controller.buscarEmpresa = 'Empresa';
        controller.BuscarEmpresa();
        controller.afiliacion.Empresa__c = controller.listPopup[0].id;
        controller.listPopup[0].seleccionado = true;
        controller.selectCuenta();
        controller.buscarSubProducto = '123214123';
        controller.SelectSubProducto();
        controller.buscarSubProducto = 'Sub';
        controller.Afiliacion.Subproducto__c = subP.id;
        controller.SelectSubProductoPop();
        controller.SelectSubProducto();
        controller.buscarSubProducto = 'Sub 1';
        controller.SelectSubProducto();
        controller.Afiliacion.Cantidad_Afiliaciones__c = 21;
        //controller.afiliacion.Empresa__c = empresa.id;
        controller.Afiliacion.Codigo_Asesor_Comercial__c = '21234';
        controller.Afiliacion.Asesor_Comercial__c = 'weqwe';
        //controller.Afiliacion.Codigo_T24__c = '12';
        controller.Enviar();
        controller.Afiliacion.Aplica_CS__c = 'N';
        controller.Enviar();
        controller.Enviar();
        controller.fileName = 'Test';
        controller.file = Blob.valueof('Hola');
        controller.Enviar();
        controller.accionVacia();
        controller.descargarArchivo();
        
    }
}