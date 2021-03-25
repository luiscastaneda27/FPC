@istest
global class TestCargaPlanilla {
    /*static testmethod void claseutil ()
	{
Account EmpresaPrueba= new Account();
empresaprueba.Name='Empresa Prueba';
EmpresaPrueba.RecordTypeId = '012j0000000i2TcAAI'; 
EmpresaPrueba.Identificacion__c='012j0000';
insert EmpresaPrueba;

test.startTest();
string gt =claseutilplanillas.urlSysde('Test');
boolean t =claseutilplanillas.validarContrasena('Hola');
t =claseutilplanillas.validarContrasena('Holacsdfh');
t =claseutilplanillas.validarContrasena('Holac43sdbfh@');

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
a.Aceptar_Planilla__c=true;
a.Aprobacion_Usuarios__c=TRUE;
a.Calculo_De_Pilares__c=true;
a.Cargar_Generar_Planilla__c=true;
a.Crear_Usuarios__c=true;
a.Nuevo_Personal__c=true;
a.Reportes__c=true;
a.Planilla_Seguro_Social__c=true;
insert a;

claseutilplanillas.correoEnvioPlanilla(a);        

list<Account> mnb=new list<Account>();
list<string> vc= new list<string>();
vc.add('0404040404');
mnb=aSysdePortalEmpresarial.agregarPersonaPlanilla(vc);
list<claseaportaciones> mn =aSysdePortalEmpresarial.ConsultalAportesPatronales(vc, '54769');
//aSysdePortalEmpresarial.EnviarAportesEmpleados('32,3,23,32,23,32,32,32,32,32::::',746,datetime.now(),'');
aSysdePortalEmpresarial.metodoutil();
aSysdePortalEmpresarial.metodoutil2();


test.stopTest();
}*/
    
    static testmethod void TestPortalFPCCargasPlanilla()
    {
        test.startTest();
        Account EmpresaPrueba= new Account();
        empresaprueba.Name='Empresa Prueba';
        EmpresaPrueba.RecordTypeId = '012j0000000i2TcAAI';
        EmpresaPrueba.Identificacion__c='012j0000';
        insert EmpresaPrueba;       
        
        Account EmpresaPrueba2= new Account();
        EmpresaPrueba2.Name='Empresa Prueba3';
        EmpresaPrueba2.RecordTypeId = '012j0000000i2TcAAI';
        EmpresaPrueba2.Identificacion__c='01uy62j0000';
        insert EmpresaPrueba2;
        
        Account EmpresaPrueba3= new Account();
        EmpresaPrueba3.Name='Empresa Prueba3';
        EmpresaPrueba3.RecordTypeId = '012j0000000i2TcAAI';
        EmpresaPrueba3.Identificacion__c='012jkjn00';
        insert EmpresaPrueba3;
        
        Account ClientePrueba= new Account();
        ClientePrueba.lastname='Doanire';
        ClientePrueba.firstname='Luis';
        ClientePrueba.RecordTypeId = '012j0000000i3wAAAQ';
        ClientePrueba.Identificacion__c='00000000000000';
        insert ClientePrueba;
        
        Account ClientePrueba2= new Account();
        ClientePrueba2.lastname='Castañeda';
        ClientePrueba2.firstname='Enrique';
        ClientePrueba2.RecordTypeId = '012j0000000i3wAAAQ';
        ClientePrueba2.Identificacion__c='00000000000001';
        insert ClientePrueba2;
        
        Account ClientePrueba3= new Account();
        ClientePrueba3.lastname='Castañeda';
        ClientePrueba3.firstname='Idania';
        ClientePrueba3.RecordTypeId = '012j0000000i3wAAAQ';
        ClientePrueba3.Identificacion__c='00000000000002';
        insert ClientePrueba3;
        
        Producto__C producto=New Producto__C();
        producto.Codigo__c='01';
        producto.CurrencyIsoCode='HNL';
        insert producto;    
        
        Cuentas__C cuentacolectiva= new Cuentas__C();
        cuentacolectiva.CurrencyIsoCode='HNL';
        cuentacolectiva.Codigo__c='32546';
        cuentacolectiva.Cliente__c=EmpresaPrueba.id;
        cuentacolectiva.Producto__c=producto.id;
        insert cuentacolectiva;
        
        Cuentas_Colectivas__c Colectiva= new Cuentas_Colectivas__c();
        colectiva.Tipo_Cuenta__c='Censatías';
        colectiva.Codigo__c='32542';
        colectiva.Empresa__c=empresaprueba.id;
        insert colectiva;
        
        Cuentas_Colectivas__c Colectiva2= new Cuentas_Colectivas__c();
        colectiva2.Tipo_Cuenta__c='Voluntarias';
        colectiva2.Codigo__c='32546';
        colectiva2.Empresa__c=empresaprueba.id;
        insert colectiva2;
        
        Cuentas__C cuentaNormal= new Cuentas__C();
        cuentaNormal.CurrencyIsoCode='HNL';
        cuentaNormal.Codigo__c='der1';
        cuentaNormal.Cliente__c=ClientePrueba.id;
        cuentanormal.Cuenta_colectiva2__c=null;
        cuentaNormal.Producto__c=producto.id;
        insert cuentaNormal;
        
        
        
        cuentaNormal= new Cuentas__C();
        cuentaNormal.CurrencyIsoCode='HNL';
        cuentaNormal.Codigo__c='der3';
        cuentaNormal.Cliente__c=ClientePrueba3.id;
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
        
        empleado= new empresa_x_empleado__C();
        empleado.Activo_Nueva_Planilla__c=true;
        empleado.Empresa2__c=empresaprueba.id;
        empleado.Salario__c=15000;
        empleado.Estado__c='Activo';
        empleado.Empleado2__c=clienteprueba2.id;
        insert empleado;
        
        empleado= new empresa_x_empleado__C();
        empleado.Activo_Nueva_Planilla__c=false;
        empleado.Empresa2__c=empresaprueba.id;
        empleado.Salario__c=30000;
        empleado.Estado__c='Activo';
        empleado.Empleado2__c=clienteprueba3.id;
        insert empleado;
        
        Autonumerico_cuentas_Syste__c gtp= new Autonumerico_cuentas_Syste__c();
        gtp.Id_Formulario_Sysde__c=0;
        insert gtp;   
        
        
        
        
        
         
        
        string stringCSV = '"NUM IDENTIDAD", "APORTE PATRONO OBLIGATORIO", "APORTE EMPLEADO OBLIGATORIO", "RESERVA LABORAL", "APORTE PATRONO VOLUNTARIO",'+
            			   ' "CUENTA", "APORTE EMPLEADO EXTRAORDINARIO", "APORTE PATRONO EXTRAORDINARIO", "APORTE SEGURO DE VIDA", "APORTE EMPLEADO VOLUNTARIO"\n"0000000000040",12,12,12,12,12,12,12,"",12\n';
        classWRetorno2 error = new classWRetorno2();
        error=controladorCargarPlanilla.SUbirInformacion(stringCSV, empresaprueba.id);
        
        string stringCSV2 = '"NUM IDENTIDAD", "APORTE PATRONO OBLIGATORIO", "APORTE EMPLEADO OBLIGATORIO", "RESERVA LABORAL", "APORTE PATRONO VOLUNTARIO",'+
            				' "CUENTA", "APORTE EMPLEADO EXTRAORDINARIO", "APORTE PATRONO EXTRAORDINARIO", "APORTE SEGURO DE VIDA", "APORTE EMPLEADO VOLUNTARIO"\n"0000000000040",0,0,0,0,0,0,0,0,0,0\n';
        classWRetorno2 error2 = new classWRetorno2();
        error2=controladorCargarPlanilla.SUbirInformacion(stringCSV2, empresaprueba.id);
        
        string stringCSV3 = '"NUM IDENTIDAD", "APORTE PATRONO OBLIGATORIO", "APORTE EMPLEADO OBLIGATORIO", "RESERVA LABORAL", "APORTE PATRONO VOLUNTARIO",'+
            				' "CUENTA", "APORTE EMPLEADO EXTRAORDINARIO", "APORTE PATRONO EXTRAORDINARIO", "APORTE SEGURO DE VIDA", "APORTE EMPLEADO VOLUNTARIO"\n"0000000000040",12,12,12,12,"",12\n';
        classWRetorno2 error3 = new classWRetorno2();
        error3=controladorCargarPlanilla.SUbirInformacion(stringCSV3, empresaprueba.id);
        
        list<planilla> planil=new list<Planilla>(); 
        planil.add(new planilla('A','B','C','D','E','F','G','H',date.today(),'',7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7));
        
        //pp=controladorCargarPlanilla.SUbirInformacion(stringCSV2, empresaprueba.id);
        ApexPages.currentPage().getParameters().put('Eldudhdhyudb',empresaprueba.id);
        ApexPages.currentPage().getParameters().put('loetdncdhjch',usuario.id);
        ApexPages.currentPage().getParameters().put('Moneda','HNL');
        controladorCargarPlanilla Cplanilla = new controladorCargarPlanilla();
        
        Planilla_Temporal__c tem = new Planilla_Temporal__c();
        tem.Name = EmpresaPrueba.Id;
        insert tem;
        Planilla_Temporal__c NuevaPlanilla = new Planilla_Temporal__c();
        NuevaPlanilla =[select id, Numeracion_Automativa__c from Planilla_Temporal__c where name=:EmpresaPrueba.Id order by Numeracion_Automativa__c DESC limit 1];
            
        Contenido_Planilla_Temporal__c temp = new Contenido_Planilla_Temporal__c();
        temp.Identidad__c = ClientePrueba3.Identificacion__c;
        temp.Cuenta__c = cuentaNormal.Codigo__c;
        temp.Aporte_Empleado_Voluntario__c = 1.0;
        temp.Aporte_Empleado_Obligatorio__c = 0.0;
        temp.Aporte_Patronal_Obligatorio__c = 0.0;
        temp.Aporte_Patronal_Voluntario__c = 2.0;
        temp.Aporte_Reserva_Laboral__c = 0.0;
        temp.Aporte_Empleado_Extraordinario__c = 200.00;
        temp.Aporte_Patrono_Extraordinario__c =0.0;
        temp.Aporte_Seguro_de_Vida__c = 0.0;
        temp.planilla__c = NuevaPlanilla.Id;
        insert temp;
        cplanilla.VerPlanilla();
        cuentaNormal= new Cuentas__C();
        cuentaNormal.CurrencyIsoCode='HNL';
        cuentaNormal.Codigo__c='der2';
        cuentaNormal.Cliente__c=ClientePrueba2.id;
        cuentanormal.Cuenta_colectiva2__c=null;
        cuentaNormal.Producto__c=producto.id;
        insert cuentaNormal;
        cplanilla.VerPlanilla();
        cplanilla.Cargarmeses();
        cplanilla.sumas();
        cplanilla.popEnviar();
        cplanilla.popGuardar();
        cplanilla.Si();
        cplanilla.No();
        //cplanilla.EnviarPlanilla(2);
        cplanilla.siguiente();
        cplanilla.anterior();
        cplanilla.salir();
        cplanilla.NuevaCarga();
       
        cplanilla.CalculoDePilares();
        cplanilla.metodoutil();

        test.stopTest();
    }  
}