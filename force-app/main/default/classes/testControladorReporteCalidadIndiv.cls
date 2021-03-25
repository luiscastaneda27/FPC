@isTest
public class testControladorReporteCalidadIndiv {
    static oficial_X_asesor__C asesor;
    static Account cuenta;
    static Producto__c producto;
    static Subproducto__c subProd;
    static Cuentas__c cuenta2;
    static Reporte_calidad__C Afiliacion;
    
    @isTest static void executeTest() {
        Usuarios_de_Pantallas__c usuario = new Usuarios_de_Pantallas__c ();
        usuario.Activo__c = true;
        usuario.Usuario__c = 'juan123';
        usuario.Contrase_a__c = 'juan123';
        usuario.name = 'Juan';
        usuario.Apellido__c='Perez';
        usuario.Email__c = 'juanperez@test.com';
        insert usuario; 
        //Inicio insertando Oficial por Asesor
        Oficial_X_Asesor__c oficial2 = new Oficial_X_Asesor__c();
        oficial2.Codigo_Oficial_SAC__c = usuario.Usuario__c;
        oficial2.Oficial_SAC__c = userinfo.getUserId();
        oficial2.Codigo_Asesor__c = usuario.Usuario__c;
        oficial2.Asesor__c = userinfo.getUserId();
        insert oficial2;
        //Fin insertando Oficial por Asesor
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
        subProd.Name = 'FPC08 - FONDO INDIVIDUAL DE PENSIONES EMPRESARIAL L. CAPITAL SEMILLA';
        subProd.Producto__c = producto.Id;
        subProd.Codigo__c = 'FPC008';
        subProd.Tipo_Fondo__c = 'M';
        subProd.Tipo__c = 'Individual';
        insert subProd;
        //Fin insertando Subproducto
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
        //Fin insertando Cuentas__c
        //Inicio insertando Reporte de Calidad
        Reporte_calidad__C afiliacion = new Reporte_calidad__C();
        afiliacion.Identificacion__c = '123';
        afiliacion.Espediente_Completo__c = 'N';
        afiliacion.Name = 'Test';
        afiliacion.Codigo_Oficial_SAC__c = usuario.Usuario__c;
        afiliacion.Enviar_Sac__c = true;
        afiliacion.Tipo_Afiliacion__c  ='I';
        afiliacion.Identificacion__c = '12345';
        insert afiliacion;
        //Fin Insertando Reporte de Calidad
        Test.StartTest();
        ApexPages.currentPage().getParameters().put('usuario',usuario.Usuario__c);
        ControladorReporteCalidadIndividuales controller = new ControladorReporteCalidadIndividuales();
        controller.listSubProductos = new list<selectOption>();     
        controller.idAfiliacion = controller.listAfiliaciones[0].id;
        controller.editar();
        controller.afiliacion.Identificacion__c = '123456';
        controller.ValidacionIdentidad();
        controller.afiliacion.Espediente_Completo__c = 'N';
        controller.guardar();
        update afiliacion;
        controller.reinicar();
        controller.idAfiliacion = controller.listAfiliaciones[0].id;
        controller.editar();
        controller.afiliacion.Espediente_Completo__c = 'S';
        controller.guardar();
        controller.afiliacion.Espediente_Completo__c = 'S';
        controller.afiliacion.name ='wq';
        controller.afiliacion.Primer_Apellido__c ='121';
        controller.afiliacion.Tipo_Identificacion__c = '1';
        controller.afiliacion.Identificacion__c ='SASAS';
        controller.afiliacion.Tiene_Id__c ='S';
        controller.afiliacion.RTN__c = 'N';
        controller.afiliacion.FATCA__c ='S';
        controller.afiliacion.WAIVER__c ='S';
        controller.afiliacion.PEP__c ='S'; 
        controller.afiliacion.Procedencia__c ='S'; 
        controller.afiliacion.Addendum__c ='S';
        controller.guardar();
        controller.cerrar();
        controller.accionVacia();
        Test.StopTest();
    }
}