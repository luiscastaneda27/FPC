@IsTest
public class testcontroladorAfiliacionCarga {
    
    @isTest static void executeTest(){
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
        
        empresa= new Account();
        empresa.Name='Empresa Prueba 2';
        empresa.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Juridico').getRecordTypeId();
        empresa.Identificacion__c='013M0000';
        empresa.Cliente_Unico_Banco__c = '123456';
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
        
        ApexPages.currentPage().getParameters().put('usuario',usuario.Usuario__c);
        controladorAfiliacionCarga controller= new controladorAfiliacionCarga();
        controller.idAfiliacion = afiliacion.Id;
        controller.NombreProducto = 'testProducto';
        controller.nombreAfiiacion = 'testAfiliación';
        
        controller.Afiliacion.name = 'PN';
        controller.Afiliacion.primer_apellido__C = 'PA';
        controller.Afiliacion.Tipo_Identificacion__c='1';
        controller.Afiliacion.Identificacion__c = '12345445';
        controller.ValidacionIdentidad();
        controller.afiliacion.empresa__c = empresa.id;
 
        controller.Afiliacion.Tiene_Id__c = 'S';
        controller.Afiliacion.RTN__c = 'N';
        controller.Afiliacion.FATCA__c = 'N';
        controller.Afiliacion.WAIVER__c = 'N';
        controller.Afiliacion.PEP__c = 'N';
        controller.Afiliacion.Procedencia__c = 'N';
        controller.Afiliacion.Addendum__c = 'N';
        controller.Afiliacion.Tipo_Fondo__c = 'M';
        controller.Afiliacion.espediente_completo__C = 'S';

        
        
        controller.guardar();
        controller.buscarEmpresa = 'Empresa';
        controller.BuscarEmpresa();
        controller.idAfiliacion = controller.listAfiliaciones[0].id;
        controller.afiliacion.Subproducto__c = subP.id;
        controller.SelectSubProductoPop();
        controller.editar();
        controller.listAfiliaciones[0].enviar_sac__c = true;
		controller.Enviar();
        controller.cerrar();
        controller.EliminarAfiliacion();
        controller.SelectPopEliminar();
        controller.ValidacionIdentidad();
        controller.selectCuenta();
        controller.accionVacia();
        controller.SelectSubProducto();
        
        String f= '"Primer Nombre","Segundo Nombre","Primer Apellido","Segundo Apellido","Tipo Identificación","Identificación","Tiene Id","RTN","FATCA","WAIVER","PEP","Procedencia","Addendum","Subproducto","Código Empresa","Reporte de Calidad","Oficial SAC","Formulario Completo","Aplica CS","Comentarios"\n"Luis","Enrique","Castaneda","Donaire","Cédula de Identidad","0303-1994-00043","Si","Si","Si","Si","Si","Si","Si","FI010",123456,"Contributivo","HN17575","Si","Si",';
        controladorAfiliacionCarga.subirInformacion(f, usuario.usuario__C);
        
        

    }   
}