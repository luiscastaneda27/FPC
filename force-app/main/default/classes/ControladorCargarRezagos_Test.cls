@istest
global class ControladorCargarRezagos_Test {
    static testmethod void ControladorCargarRezagos(){
        
        Account EmpresaPrueba= new Account();
        empresaprueba.Name='Empresa Prueba';
        EmpresaPrueba.RecordTypeId = '012j0000000i2TcAAI';
        EmpresaPrueba.Identificacion__c='012j0000';
        insert EmpresaPrueba;
        
        Account ClientePrueba= new Account();
        ClientePrueba.lastname='Doanire';
        ClientePrueba.firstname='Luis';
        ClientePrueba.RecordTypeId = '012j0000000i3wAAAQ';
        ClientePrueba.Identificacion__c='0801-1994-11013';
        insert ClientePrueba;
        
        Producto__C producto=New Producto__C();
        producto.Codigo__c='01';
        producto.CurrencyIsoCode='HNL';
        insert producto;
        
        Cuentas_Colectivas__c Colectiva= new Cuentas_Colectivas__c();
        colectiva.Tipo_Cuenta__c='Voluntarias';
        colectiva.Codigo__c='32546';
        colectiva.Empresa__c=empresaprueba.id;
        insert colectiva;
        
        Cuentas__C cuentacolectiva= new Cuentas__C();
        cuentacolectiva.CurrencyIsoCode='HNL';
        cuentacolectiva.Codigo__c='32546';
        
        cuentacolectiva.Cliente__c=EmpresaPrueba.id;
        cuentacolectiva.Producto__c=producto.id;
        insert cuentacolectiva;

        Cuentas__C cuentaNormal= new Cuentas__C();
        cuentaNormal.CurrencyIsoCode='HNL';
        cuentaNormal.Codigo__c='51600';
        cuentaNormal.Cliente__c=ClientePrueba.id;
        cuentanormal.Cuenta_colectiva2__c=cuentacolectiva.id;
        cuentaNormal.Producto__c=producto.id;
        insert cuentaNormal;

        Usuario_Portal_Empresarial__c usuario = new Usuario_Portal_Empresarial__c();
        usuario.Apellidos__c='Meraz';
        usuario.Contrasena2__c='Cualquiera';
        usuario.Email__c='marcela.meraz@gmail.com';
        usuario.Name='Yeny';
        usuario.Respuesta__c='Lunes';
        usuario.Identidad__c='0303199702883';
        usuario.Nombre_Usuario__c='chema';
        insert usuario;
        
        Usuario_X_Empresa__c a = new Usuario_X_Empresa__c();
        a.empresa2__C=empresaprueba.id;
        a.Usuario__c=usuario.id;
        a.Activo__c=true;
        a.Aprobacion_Usuarios__c=TRUE;
        a.Calculo_De_Pilares__c=true;
        a.Cargar_Generar_Planilla__c=true;
        a.Crear_Usuarios__c=true;
        a.Nuevo_Personal__c=true;
        a.Reportes__c=true;
        a.Planilla_Seguro_Social__c=true;
        insert a;
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora.Usuario__c=usuario.id;
        hora.Hora_ultima_consulta__c=datetime.now();
        insert hora; 
        empresa_x_empleado__C empleado= new empresa_x_empleado__C();
        empleado.Activo_Nueva_Planilla__c=true;
        empleado.Empresa2__c=empresaprueba.id;
        empleado.Salario__c=20000;
        empleado.Estado__c='Activo';
        empleado.Empleado2__c=clienteprueba.id;
        insert empleado;
        
        Autonumerico_cuentas_Syste__c gtp= new Autonumerico_cuentas_Syste__c();
        gtp.Id_Formulario_Sysde__c=0;
        insert gtp;

        test.startTest();
        string stringCSV ='"FONDO ","REFERENCIA","FECHA DEL DEPOSITO","MONEDA DEL DEPOSITO","MONTO DEL DEPOSITO","DESCRIPCION","DESCRIPCION NOTA","BANCO","AGENCIA ORIGEN","ASESOR"\n101,9519458630,"8/4/20","HNL"," 3,000.00 ","Transferencia entre Cuentas","Descripcion",28,"AGN PRINCIPAL TGU","TODOS"\n101,9519458631,"8/4/20","HNL"," 3,000.00 ","Transferencia entre Cuentas","Descripcion",28,"AGN PRINCIPAL TGU","HN19964"';
        list<Rezago__c> error = new list<Rezago__c>();
        error = ControladorCargarRezagos.SUbirInformacion(stringCSV);
        ApexPages.currentPage().getParameters().put('Eldudhdhyudb',empresaprueba.id);
        ApexPages.currentPage().getParameters().put('loetdncdhjch',usuario.id);
        ApexPages.currentPage().getParameters().put('Moneda','HNL');
        ControladorCargarRezagos Crezagos = new ControladorCargarRezagos();
        
        Crezagos.Guardar();
        
        test.stopTest();
    }

}