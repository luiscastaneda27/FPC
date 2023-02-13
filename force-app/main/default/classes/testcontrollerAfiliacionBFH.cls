@isTest
public class testcontrollerAfiliacionBFH {
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
        afiliacion.Codigo_Asesor_Comercial__c = usuario.Usuario__c;
        afiliacion.Tipo_Afiliacion__c = 'PM';
        insert afiliacion;
              
        Oficial_X_Asesor__c oficial2 = new Oficial_X_Asesor__c();
        oficial2.Codigo_Oficial_SAC__c = usuario.Usuario__c;
        oficial2.Oficial_SAC__c = userinfo.getUserId();
        oficial2.Codigo_Asesor__c = usuario.Usuario__c;
        oficial2.Asesor__c = userinfo.getUserId();
        insert oficial2;
        
        ApexPages.currentPage().getParameters().put('usuario',usuario.Usuario__c);
        ApexPages.currentPage().getParameters().put('pantalla','PM');
        controllerAfiliacionBFH controller= new controllerAfiliacionBFH();
        controller.idAfiliacion = controller.listAfiliaciones[0].id;
        controller.editar();
        controller.Afiliacion.name = 'PN';
        controller.Afiliacion.primer_apellido__C = 'PA';
        controller.Afiliacion.Tipo_Identificacion__c='1';
        controller.Afiliacion.Identificacion__c = '12345445';
        controller.afiliacion.empresa__c = empresa.id;
        controller.selectEmpresa();
        controller.Afiliacion.Tiene_Id__c = 'S';
        controller.Afiliacion.RTN__c = 'N';
        controller.Afiliacion.FATCA__c = 'N';
        controller.Afiliacion.WAIVER__c = 'N';
        controller.Afiliacion.PEP__c = 'N';
        controller.Afiliacion.Procedencia__c = 'N';
        controller.Afiliacion.Addendum__c = 'N';
        controller.Afiliacion.Tipo_Fondo__c = 'M';
        controller.Afiliacion.espediente_completo__C = 'S';
        controller.subEstado = 'S';

        controller.guardar();
        controller.idAfiliacion = controller.listAfiliaciones[0].id;
        controller.editar();
        
         controller.reinicar();
        controller.listAfiliaciones[0].enviar_sac__C = true;
        controller.Enviar();
        controller.nombreAfiiacion = 'testAfiliación';
		controller.cerrar();
        //controller.EliminarAfiliacion();
        controller.selectEmpresa();
        //controller.SelectPopEliminar();
        controller.ValidacionIdentidad();
        controller.afiliacion.Identificacion__c = afiliacion.Identificacion__c.replace('-','');
        controller.ValidacionIdentidad();
        controller.subEstado = 'S';
        controller.guardar();

        controller.accionVacia();
        controller.BuscarEmpresa();
        controller.SelectSubProducto();
        controller.SelectSubProductoPop();
        
        controller.SelectPopEliminar();
        controller.EliminarAfiliacion();

        
    }
}