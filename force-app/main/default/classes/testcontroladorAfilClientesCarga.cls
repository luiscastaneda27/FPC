@isTest
public class testcontroladorAfilClientesCarga {
    static Account cuenta;
    static Cuentas__c cuenta2;
    static Producto__c producto;
    static Subproducto__c subProd;
    static Reporte_calidad__C Afiliacion;
    @isTest static void executeTest() {
        
        Usuarios_de_Pantallas__c usuario = new Usuarios_de_Pantallas__c ();
        usuario.Activo__c = true;
        usuario.Usuario__c = 'Prueba123';
        usuario.Contrase_a__c = 'Prueba123';
        usuario.name = 'Prueba';
        usuario.Apellido__c='Prueba';
        usuario.Email__c = 'prueba123@test.com';
        insert usuario; 
        
        ID recipient;
        //string Usuario;
        //Inicio insertando cuenta
        cuenta = new Account();
        cuenta.Name = 'Company Test';
        cuenta.Identificacion__c = '0802-1745-4578';
        cuenta.Correo_actual__c = 'test123@gmail.com';
        Insert cuenta;
        //Fin insertando cuenta
        //Inicio insertando Producto
        producto = new Producto__c();
        producto.Name = 'Pensiones Dólares';
        producto.Codigo__c = '003';
        insert producto;
        //Fin insertando Producto
        //Inico insertando Subproducto
        subProd = new Subproducto__c();
        subProd.Name = 'FPC09 - FONDO INDIVIDUAL DE PENSIONES EMPRESARIAL L. CAPITAL SEMILLA';
        subProd.Producto__c = producto.Id;
        subProd.Codigo__c = 'FPC008';
        subProd.Tipo_Fondo__c = 'M';
        subProd.Tipo__c = 'Individual';
        insert subProd;
        
        subProd = new Subproducto__c();
        subProd.Name = 'FPC08 - FONDO INDIVIDUAL DE PENSIONES EMPRESARIAL L. CAPITAL SEMILLA';
        subProd.Producto__c = producto.Id;
        subProd.Codigo__c = 'FPC009';
        subProd.Tipo_Fondo__c = 'M';
        subProd.Tipo__c = 'Individual';
        insert subProd;
        //Fin insertando Subproducto
        
        Oficiales_X_Empresa__c oficial = new Oficiales_X_Empresa__c();
        oficial.Empresa__c = cuenta.id;
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
        
        //Inicio insertando Cuentas__c
        cuenta2 = new Cuentas__c();
        cuenta2.Name = '33108 - ADMINISTRADORA DE FONDOS DE PENSION FICOHSA';
        cuenta2.Codigo__c = '33108';    
        cuenta2.Cliente__c = cuenta.Id;
        cuenta2.Producto__c = producto.Id;
        cuenta2.Subproducto__c = subProd.Id;
        cuenta2.Tipo_Fondo__c = 'P';    
        cuenta2.Activo__c = true;
        cuenta2.Fecha_Apertura__c = System.today();    
        cuenta2.Estatus__c = 'A';
        insert cuenta2;
        //Fin Insertando Cuentas__c
        
        //Inicio insertando Reporte de Calidad
        Reporte_calidad__C afiliacion = new Reporte_calidad__C();
        afiliacion.Identificacion__c = '123';
        afiliacion.Espediente_Completo__c = 'S';
        afiliacion.Name = 'Test';
        afiliacion.Codigo_Oficial_SAC__c = usuario.Usuario__c;
        afiliacion.Codigo_Asesor_Comercial__c = usuario.Usuario__c;
        insert afiliacion;
        //Fin Insertando Reporte de Calidad
        Test.StartTest();
        ApexPages.currentPage().getParameters().put('usuario',usuario.Usuario__c);
        controladorAfiliacionClientesCargados controller = new controladorAfiliacionClientesCargados();
        
        controller.buscarSubProducto = 'FPC0wefdwe9';
        controller.SelectSubProducto();
        
        controller.NombreProducto = 'Test';
        controller.buscarSubProducto = 'FPC09';
        controller.SelectSubProducto();
        
        subProd.Name = 'FPC09 - FONDO INDIVIDUAL DE PENSIONES EMPRESARIAL L. CAPITAL SEMILLA';
        update subProd;
        
        controller.buscarSubProducto = 'FPC09';
        controller.SelectSubProducto();
        controller.Afiliacion.Subproducto__c = controller.listPopup[0].id;
        controller.SelectSubProductoPop();
        
        controller.buscarEmpresa = 'ercerfef';
        controller.BuscarEmpresa();
        
        controller.buscarEmpresa = 'Test';
        controller.BuscarEmpresa();
        controller.Afiliacion.Empresa__c = controller.listPopup[0].id;
        controller.selectCuenta();
        controller.Afiliacion.Identificacion__c = '3243323';
        controller.ValidacionIdentidad();
        
        
        controller.Afiliacion.name = 'PN';
        controller.Afiliacion.primer_apellido__C = 'PA';
        controller.Afiliacion.Tipo_Identificacion__c='1';
        controller.Afiliacion.Identificacion__c = '12345445';
        
        controller.Afiliacion.Tiene_Id__c = 'S';
        controller.Afiliacion.RTN__c = 'N';
        controller.Afiliacion.FATCA__c = 'N';
        controller.Afiliacion.WAIVER__c = 'N';
        controller.Afiliacion.PEP__c = 'N';
        controller.Afiliacion.Procedencia__c = 'N';
        controller.Afiliacion.Addendum__c = 'N';
        controller.Afiliacion.Tipo_Fondo__c = 'M';
        controller.Afiliacion.Formulario_Completo__c = 'S';
        controller.Afiliacion.Reporte_Calidad__c = null;
        controller.Afiliacion.Aplica_CS__c = 'S';
        controller.guardar();
        controller.Afiliacion.Reporte_Calidad__c = 'I';
        controller.guardar();
        
        controller.Afiliacion.name = 'PNN';
        controller.Afiliacion.primer_apellido__C = 'PA';
        controller.guardar();
        
        controller.reinicar();
        controller.idAfiliacion = controller.listAfiliaciones[0].id;
        controller.editar();
        controller.reinicar();
        controller.listAfiliaciones[0].enviar_sac__C = true;
        controller.Enviar();
        
        controller.Afiliacion.name = 'PNn';
        controller.Afiliacion.primer_apellido__C = 'PA';
        controller.Afiliacion.Tipo_Identificacion__c='1';
        controller.Afiliacion.Identificacion__c = '12345445';
        
        controller.Afiliacion.Tiene_Id__c = 'S';
        controller.Afiliacion.RTN__c = 'N';
        controller.Afiliacion.FATCA__c = 'N';
        controller.Afiliacion.WAIVER__c = 'N';
        controller.Afiliacion.PEP__c = 'N';
        controller.Afiliacion.Procedencia__c = 'N';
        controller.Afiliacion.Addendum__c = 'N';
        controller.Afiliacion.Tipo_Fondo__c = 'M';
        controller.Afiliacion.Formulario_Completo__c = 'N';
        controller.Afiliacion.Reporte_Calidad__c = 'I';
        controller.Afiliacion.Aplica_CS__c = 'S';
        controller.guardar();
        
        controller.idAfiliacion = controller.listAfiliaciones[0].id;
        controller.SelectPopEliminar();
        controller.EliminarAfiliacion();
        
        controller.accionVacia();
        controller.cerrar();
        
        controller.Afiliacion.Numero_Cuenta__c = 'N';
        controller.buscarCuenta();
        
        List<reporteT24__c> listReporte = new List<reporteT24__c>();
        reporteT24__c reporte = new reporteT24__c();
		reporte.identificacion__c = '000';
        reporte.subProducto__c = 'FPC009';
        reporte.rtnEmpleador__c = '0802-1745-4578';
        reporte.promotor__c = usuario.Usuario__c;
        reporte.noEmpleado__c = '12';
        listReporte.add(reporte);
        insert listReporte;
        controladorAfiliacionClientesCargados.crearAfilaicionT24(JSON.serialize(listReporte));
        Test.StopTest();
    } 
}