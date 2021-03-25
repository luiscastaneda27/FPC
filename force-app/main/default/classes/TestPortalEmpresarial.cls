@istest
public class TestPortalEmpresarial {
	/*
    static testmethod void clasesutilizadas() 
    {
        test.startTest();  
         list<planilla> planil=new list<Planilla>(); 
        planil.add(new planilla('','','','','','','','',date.today(),'',7.7,7.7,7.7,7.7,7.7,7.7));
        planil.add(new planilla('','',7.7,7.7,''));
        list<cuenta> vf= new list<cuenta>();
        vf.add(new cuenta('',54.54));
        planil.add(new planilla('','','','','',7.7,7.7,7.7,7.7,7.7,7.7,vf,vf));
        planil.add(new planilla('','','','','',7.7,7.7,7.7,7.7,7.7,7.7,vf,vf,'','',''));
        planil.add(new planilla('','','','','',7.7,7.7,7.7,7.7,7.7,7.7,''));
        planil.add(new planilla('','','','','',7.7,7.7,7.7,7.7,7.7,7.7));
        planil.add(new planilla('',1));
        planil.add(new planilla('',1,''));
        planil.add(new planilla('',7.7,7.7,7.7,7.7,7.7));
        planil.add(new planilla('','',date.today(),'',9.0,'',''));
        planil.add(new planilla('','','','','','',7.7,7.7));
        planil.add(new planilla('','','','','',7.7,7.7,7.7,7.7,8.7,'',9.9));
        
        
        list<claseaportaciones> gtb = new list<claseaportaciones>();
        gtb.add(new claseaportaciones('','',7.7,7.7,''));
        
        list<claseColaboradores> ytu = new list<claseColaboradores>();
        ytu.add(new claseColaboradores('','','','','', date.today(),'C',6.7,''));
         ytu.add(new claseColaboradores('','','','','', date.today(),'S',6.7,''));
         ytu.add(new claseColaboradores('','','','','', date.today(),'V',6.7,''));
         ytu.add(new claseColaboradores('','','','','', date.today(),'D',6.7,''));
        test.stopTest();
    }
    
    static testmethod void claseutil () 
  	{
         Account EmpresaPrueba= new Account();
        empresaprueba.Name='Empresa Prueba';
        EmpresaPrueba.RecordTypeId = '012j0000000i2TcAAI';
        EmpresaPrueba.Identificacion__c='012j0000';
        insert EmpresaPrueba;
        
        test.startTest();
        string got=claseutil.urlSysde('Test');
        claseutil.stopTrigger();
        boolean gbvfg=claseutil.canIRun();
       // claseutil.metodoutil(); 
        
        
        
        
        
        
        
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
      usuario.Identidad__c='030302883';
      usuario.Nombre_Usuario__c='chemaab';
      insert usuario;
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
       hora.Usuario__c=usuario.id;
       hora.Hora_ultima_consulta__c=datetime.now();
       insert hora; 
        
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
        
        planilla__C pla= new planilla__C();
        pla.fecha__C=date.today();
        pla.Estado2__c='Nueva';
        pla.Tasa_compra__c=0.0;
        insert pla;
        claseutilplanillas.CompreDeDollar(pla.id);
		claseutilplanillas.correoEnvioPlanilla2('');        
        
        list<Account> mnb=new list<Account>();
        list<string> vc= new list<string>();
        vc.add('0404040404');
        mnb=aSysdePortalEmpresarial.agregarPersonaPlanilla(vc);
        list<claseaportaciones> mn =aSysdePortalEmpresarial.ConsultalAportesPatronales(vc, '54769');
        //aSysdePortalEmpresarial.EnviarAportesEmpleados('32,3,23,32,23,32,32,32,32,32::::',746,datetime.now(),'');
        aSysdePortalEmpresarial.metodoutil();
        aSysdePortalEmpresarial.metodoutil2();
        test.stopTest();
    }  
    */
    /*static testmethod void TestUsuario()
  	{
        Rubro__C Rubro= new Rubro__C();
        Rubro.Name='Finaciero';
        Rubro.Salario_Base_Pilar_Complementario__c=10000;
        Rubro.Salario_Base_Reserva_Laboral__c=10000;
        Rubro.PAPCT__c=3;
        Rubro.PAPCE__c=3;
        Rubro.Porcentaje_de_Aportaciones_Reserva_Labor__c=4;
        Rubro.Salario_Base_Seguro_Social__c=432;
        Rubro.Porc_Apor_SSoc_Empleador_IVM__c=3;
        Rubro.Porc_Apor_SSoc_Empleado_IVM__c=3;
        Rubro.Salario_Base_Seguro_Social_Mater__c=4;
        Rubro.Porc_Apor_SSoc_Empleador_Mater__c=5;
        Rubro.Porc_Apor_SSoc_Empleado_Mate__c=5;
        Rubro.Salario_Base_Seguro_Social_RP__c=43433;
        Rubro.Riesgo_Profecional_Patronal__c=6;
        insert Rubro;
        
        string idrubro=rubro.id;
        
       Account EmpresaPrueba= new Account();
        empresaprueba.Name='Empresa Prueba';
        EmpresaPrueba.RecordTypeId = '012j0000000i2TcAAI';
        EmpresaPrueba.Identificacion__c='012j0000';
        EmpresaPrueba.Salario_Base_Pilar_Complementario__c=10000;
        EmpresaPrueba.Salario_Base_Reserva_Laboral__c=10000;
        EmpresaPrueba.PAPCT__c=3;
        EmpresaPrueba.PAPCE__c=3;
        EmpresaPrueba.Porcentaje_de_Aportaciones_Reserva_Labor__c=4;
        EmpresaPrueba.Salario_Base_Seguro_Social__c=432;
        EmpresaPrueba.Porc_Apor_SSoc_Empleador_IVM__c=3;
        EmpresaPrueba.Porc_Apor_SSoc_Empleado_IVM__c=3;
        EmpresaPrueba.Salario_Base_Seguro_Social_Mater__c=4;
        EmpresaPrueba.Porc_Apor_SSoc_Empleador_Mater__c=5;
        EmpresaPrueba.Porc_Apor_SSoc_Empleado_Mater__c=5;
        EmpresaPrueba.Salario_Base_Seguro_Social_RP__c=43433;
        EmpresaPrueba.Riesgo_Profecional_Patronal__c=6;
        empresaprueba.Rubro__c=rubro.id;
        insert EmpresaPrueba;
        
      Usuario_Portal_Empresarial__c usuario = new Usuario_Portal_Empresarial__c();
      usuario.Apellidos__c='Meraz';
      usuario.Contrasena2__c='Cualquiera';
      usuario.Email__c='marcela.meraz@gmail.com';
      usuario.Name='Yenyh';
      //usuario.Respuesta__c='Lunes';
      usuario.Identidad__c='0303199702898';
      usuario.Nombre_Usuario__c='chegfma';
      insert usuario;
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
       hora.Usuario__c=usuario.id;
       hora.Hora_ultima_consulta__c=datetime.now();
       insert hora; 
        
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
        
       test.startTest();
        // Test usuario de usuario
        ApexPages.currentPage().getParameters().put('Eldudhdhyudb',empresaprueba.id);
        ApexPages.currentPage().getParameters().put('loetdncdhjch',usuario.id);
        ApexPages.currentPage().getParameters().put('jsdhvfuyssdfyuv','1');
        ApexPages.currentPage().getParameters().put('iden','0303199702883');
        ControladorUsuarios usuarioPrueba = new ControladorUsuarios();
       usuarioPrueba.Num_identidad='0303199702883';
        usuarioprueba.LLenarDatos();
        usuarioprueba.LimpiarPantalla();
        usuarioprueba.AprobacionUsuario=true;
        usuarioPrueba.Nombre='uj';
       usuarioPrueba.Apellido='fr';
       usuarioPrueba.correovf='gt@gt.com';
         usuarioPrueba.Num_identidad='0405199500435';
       usuarioPrueba.autorizacionCrearusuario();       
        usuarioPrueba.Nombre='uj';
       usuarioPrueba.Apellido='fr';
       usuarioPrueba.correovf='gt@ghy.com';
         usuarioPrueba.Num_identidad='0405189500435';
       usuarioPrueba.autorizacionCrearusuario(); 
        usuarioPrueba.Num_identidad='0405189500435';
        usuarioPrueba.autorizacionActualizarusuario();
        usuarioPrueba.ActualizarsinAutorizacion();
        //usuarioPrueba.metodoutil();
        
        
        // Test controladorCambioUsuarios
        Pregunta_seguridad__C h = new Pregunta_seguridad__C();
        h.name='Otros';
        insert h;
         ApexPages.currentPage().getParameters().put('loetdncdhjch',usuario.id);
        controladorCambioUsuarios cambiousuario = new controladorCambioUsuarios ();
        cambiousuario.Desbloqueo();
       cambiousuario.Salir();
         cambiousuario.UsuarioNuevo.Nombre_usuario__C='mjkzxcisjdcn';
      cambiousuario.reconfirmarcontrasenia='Jolk1234@';
      cambiousuario.reconfirmarcontrasenia2='Jolk1234@';
      cambiousuario.reconfirmarUsuario='mjkzxcisjdcn';
      cambiousuario.id_pregunta=h.id;
        cambiousuario.UsuarioNuevo.respuesta__C='mi';
     cambiousuario.Guardar();
        
      cambiousuario.UsuarioNuevo.Nombre_usuario__C='mi';
      cambiousuario.reconfirmarcontrasenia='Jolk@';
      cambiousuario.reconfirmarcontrasenia2='Jo34@';
      cambiousuario.reconfirmarUsuario='mjkzxci';
      cambiousuario.id_pregunta=h.id;
        cambiousuario.UsuarioNuevo.respuesta__C='mi';
     cambiousuario.Guardar();
        
        
    cambiousuario.UsuarioNuevo.Nombre_usuario__C='mjki';
      cambiousuario.reconfirmarcontrasenia='Jolk1234@';
      cambiousuario.reconfirmarcontrasenia2='Jolk1234@';
      cambiousuario.reconfirmarUsuario='mjkzxci';
      cambiousuario.id_pregunta=h.id;
        cambiousuario.UsuarioNuevo.respuesta__C='mi';
     cambiousuario.Guardar();
        
        cambiousuario.UsuarioNuevo.Nombre_usuario__C='cualquira';
      cambiousuario.reconfirmarcontrasenia='Jolk1234@';
      cambiousuario.reconfirmarcontrasenia2='Jolk1234@';
      cambiousuario.reconfirmarUsuario='mjki';
      cambiousuario.id_pregunta=h.id;
        cambiousuario.UsuarioNuevo.respuesta__C='mi';
     cambiousuario.Guardar();
        
        cambiousuario.UsuarioNuevo.Nombre_usuario__C='mjkzxci';
      cambiousuario.reconfirmarcontrasenia='Jolk1234@';
      cambiousuario.reconfirmarcontrasenia2='Jolk1234@';
      cambiousuario.reconfirmarUsuario='mjkzxci';
      cambiousuario.id_pregunta=h.id;
     cambiousuario.Guardar();
        
        
        
    
        
      //test recibo 
      Planilla__C vf= new Planilla__C();
      vf.CurrencyIsoCode='HNL';
      vf.Empresa2__c=empresaprueba.id;
      
      insert vf;
     ApexPages.currentPage().getParameters().put('id_Planilla',vf.id);
        controladorRecibo recibo = new controladorRecibo ();
        
        
       //TEST CREAR USUARIO FICOHSA
       ApexPages.StandardController stdController;
       ControladorCrearUsuario CREARUSUAUIO = NEW ControladorCrearUsuario(stdController);
       CREARUSUAUIO.regresar();
      CREARUSUAUIO.correo='frfr@cfd.com';
      CREARUSUAUIO.Nombre='frfrcfd.com';
        CREARUSUAUIO.Apellido='frfrfd.com';
      CREARUSUAUIO.Num_identidad='0404199500043';
       CREARUSUAUIO.crearUsuario();
        
        
       //Test rubro
      controladorcrearrubro crearrubro = new controladorcrearrubro();
      Rubro= new Rubro__C();
        Rubro.Name='Finaciero3';
        Rubro.Salario_Base_Pilar_Complementario__c=10000;
        Rubro.Salario_Base_Reserva_Laboral__c=10000;
        Rubro.PAPCT__c=3;
        Rubro.PAPCE__c=3;
        Rubro.Porcentaje_de_Aportaciones_Reserva_Labor__c=4;
        Rubro.Salario_Base_Seguro_Social__c=432;
        Rubro.Porc_Apor_SSoc_Empleador_IVM__c=3;
        Rubro.Porc_Apor_SSoc_Empleado_IVM__c=3;
        Rubro.Salario_Base_Seguro_Social_Mater__c=4;
        Rubro.Porc_Apor_SSoc_Empleador_Mater__c=5;
        Rubro.Porc_Apor_SSoc_Empleado_Mate__c=5;
        Rubro.Salario_Base_Seguro_Social_RP__c=43433;
        Rubro.Riesgo_Profecional_Patronal__c=6;
        crearrubro.rubro=rubro;
        crearrubro.Guardar();
        crearrubro.id_rubro=idrubro;
        crearrubro.LLenardatos();
        crearrubro.Modificar();
        
        crearrubro.id_rubro=idrubro;
        crearrubro.LLenardatos();
        crearrubro.rubro.Name='frtg';
        crearrubro.Modificar();
        
        // TEST CREAR EMPRESAS
        controladoCrearEmpresa CREAREMPRESAS = NEW controladoCrearEmpresa();
        CREAREMPRESAS.llenarRubros();
        CREAREMPRESAS.regresar();
        CREAREMPRESAS.id_Rubro=IDRUBRO;
        CREAREMPRESAS.LLenarDatosRubros();
        CREAREMPRESAS.id_Empresa=EMPRESAPRUEBA.ID;
        CREAREMPRESAS.cerrar();
        CREAREMPRESAS.ActPop();
        crearempresas.codigoCuenta='543';
        crearempresas.cuentas.Tipo_Cuenta__c='Voluntarias';
        crearempresas.GuardarCuentas();
        crearempresas.LLenarCuentas();
        crearempresas.ELiminarCuentas();
        
      test.stopTest();
        
        
     
        
    }*/
    
    /*static testmethod void Colavoradore()
    {
         Account EmpresaPrueba= new Account();
        empresaprueba.Name='Empresa Prueba';
        EmpresaPrueba.RecordTypeId = '012j0000000i2TcAAI';
        EmpresaPrueba.Identificacion__c='012j0000';
        EmpresaPrueba.Salario_Base_Pilar_Complementario__c=10000;
        EmpresaPrueba.Salario_Base_Reserva_Laboral__c=10000;
        EmpresaPrueba.PAPCT__c=3;
        EmpresaPrueba.PAPCE__c=3;
        EmpresaPrueba.Porcentaje_de_Aportaciones_Reserva_Labor__c=4;
        EmpresaPrueba.Salario_Base_Seguro_Social__c=432;
        EmpresaPrueba.Porc_Apor_SSoc_Empleador_IVM__c=3;
        EmpresaPrueba.Porc_Apor_SSoc_Empleado_IVM__c=3;
        EmpresaPrueba.Salario_Base_Seguro_Social_Mater__c=4;
        EmpresaPrueba.Porc_Apor_SSoc_Empleador_Mater__c=5;
        EmpresaPrueba.Porc_Apor_SSoc_Empleado_Mater__c=5;
        
        EmpresaPrueba.Salario_Base_Seguro_Social_RP__c=43433;
        EmpresaPrueba.Riesgo_Profecional_Patronal__c=6;
       
        insert EmpresaPrueba;
        
        Account ClientePrueba= new Account();
		ClientePrueba.lastname='Doanire';
		ClientePrueba.firstname='Luis';
		ClientePrueba.RecordTypeId = '012j0000000i3wAAAQ';
		ClientePrueba.Identificacion__c='00000000000000';
        ClientePrueba.Tipo_Identificacion__c='Cedula de identidad';
		ClientePrueba.Sexo__c='Masculino';
		ClientePrueba.CurrencyIsoCode = 'HNL';
		ClientePrueba.Estado_Civil__pc='Soltero';
		insert ClientePrueba;
        
         Account ClientePrueba2= new Account();
		ClientePrueba2.lastname='Castañeda';
		ClientePrueba2.firstname='Enrique';
		ClientePrueba2.RecordTypeId = '012j0000000i3wAAAQ';
		ClientePrueba2.Identificacion__c='00000000000001';
		insert ClientePrueba2;
        
        Account ClientePrueba3= new Account();
		ClientePrueba3.lastname='Castañeda DOna';
		ClientePrueba3.firstname='Idania Casta'; 
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
       colectiva.Tipo_Cuenta__c='Voluntarias';
       colectiva.Codigo__c='32546';
       colectiva.Empresa__c=empresaprueba.id;
       insert colectiva;
        
       Colectiva= new Cuentas_Colectivas__c();
       colectiva.Tipo_Cuenta__c='Pilar Complementario';
       colectiva.Codigo__c='32746';
       colectiva.Empresa__c=empresaprueba.id;
       insert colectiva;
       
        Colectiva= new Cuentas_Colectivas__c();
       colectiva.Tipo_Cuenta__c='Censatías';
       colectiva.Codigo__c='032746';
       colectiva.Empresa__c=empresaprueba.id;
       insert colectiva;
        
       Cuentas__C cuentaNormal= new Cuentas__C();
       cuentaNormal.CurrencyIsoCode='HNL';
       cuentaNormal.Codigo__c='11';
       cuentaNormal.Cliente__c=ClientePrueba.id;
       cuentanormal.Cuenta_colectiva2__c=cuentacolectiva.id;
       cuentaNormal.Producto__c=producto.id;
       insert cuentaNormal;
        
       STRING CODIGOCEUNTA = cuentaNormal.ID;
        
       cuentaNormal= new Cuentas__C();
       cuentaNormal.CurrencyIsoCode='HNL';
       cuentaNormal.Codigo__c='der2';
       cuentaNormal.Cliente__c=ClientePrueba2.id;
       cuentanormal.Cuenta_colectiva2__c=cuentacolectiva.id;
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
       Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
       hora.Usuario__c=usuario.id;
       hora.Hora_ultima_consulta__c=datetime.now();
       insert hora;  
       Autonumerico_cuentas_Syste__c gert= new Autonumerico_cuentas_Syste__c();
       gert.Id_Formulario_Sysde__c=0;
        insert gert;
        
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
      
      Usuario_Portal_Empresarial__c u= new Usuario_Portal_Empresarial__c();
      u.Apellidos__c='Me54raz';
      u.Contrasena2__c='Cu54alquiera';
      u.Email__c='mar54cela.meraz@gmail.com';
      u.Name='Yeny';
      u.Respuesta__c='Lunes54';
      u.Identidad__c='0303199400038';
      u.Nombre_Usuario__c='kike';
      insert u;
        
        a = new Usuario_X_Empresa__c();
       a.empresa2__C=empresaprueba.id;
       a.Usuario__c=u.id;
       a.Activo__c=true;
       a.Aprobacion_Usuarios__c=TRUE;
       a.Calculo_De_Pilares__c=true;
       a.Cargar_Generar_Planilla__c=true;
       a.Crear_Usuarios__c=true;
       a.Nuevo_Personal__c=true;
       a.Reportes__c=true;
       a.Planilla_Seguro_Social__c=true;
       insert a;
      
        
        
        
        
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
       //insert empleado;  
       
      test.startTest();
        ApexPages.currentPage().getParameters().put('empresa',empresaprueba.id);
        controladorExportarExcelColavoradores frcds= new controladorExportarExcelColavoradores();
         // TEST COLAVORADORES VIGENTES NO INSERTAR EL EMPLEADO QUE GANA 30000
    
     ApexPages.currentPage().getParameters().put('Eldudhdhyudb',empresaprueba.id);
     ApexPages.currentPage().getParameters().put('loetdncdhjch',usuario.id);    
    controladorGenerarPersonal Colavoradores=new controladorGenerarPersonal();
    Colavoradores.SIGUIENTE();
    Colavoradores.anterior();
    Colavoradores.idEmpleado=Colavoradores.listClientes2[0].id;
   colavoradores.vertodos();
   colavoradores.TextoBusqueda='luis';
    colavoradores.buscarEmpleado();
     colavoradores.TextoBusqueda='luis gt';
    colavoradores.buscarEmpleado();
   colavoradores.ExportExcel();
   colavoradores.cerrar();
   colavoradores.mostrarNuevo();
   colavoradores.empleado.id=null;
   colavoradores.nombre='carlos 54';
   colavoradores.apellido='hu cds';
   colavoradores.Num_Identidad='050000r006500';
  colavoradores.empleado.tipo_identificacion__C='Cedula de identidad';
  colavoradores.empleado.sexo__C='Masculino';
  colavoradores.empleado.estado_civil__pc='Soltero';
  colavoradores.empleado.PersonBirthDate=date.today();
  colavoradores.tipoaportacion='Ambas';
  colavoradores.salario=2143;
  colavoradores.empleado.currencyIsoCode='HNL';
  colavoradores.AgregarPersonal();
        
   colavoradores.mostrarNuevo();
   colavoradores.empleado.id=null;
   colavoradores.nombre='carlos 54';
   colavoradores.apellido='hu cds';
   colavoradores.Num_Identidad='00000000000002';
  colavoradores.empleado.tipo_identificacion__C='Pasaporte';
  colavoradores.empleado.sexo__C='Femenino';
  colavoradores.empleado.estado_civil__pc='Casado';
  colavoradores.empleado.PersonBirthDate=date.today();
  colavoradores.tipoaportacion='Ambas';
  colavoradores.salario=2143;
  colavoradores.empleado.currencyIsoCode='HNL';
  colavoradores.AgregarPersonal();
   
   colavoradores.mostrarNuevo();
   colavoradores.empleado.id=null;
   colavoradores.nombre='carlos 54';
   colavoradores.apellido='hu cds';
   colavoradores.Num_Identidad='000000r000002';
  colavoradores.empleado.tipo_identificacion__C=null;
  colavoradores.empleado.sexo__C='Femenino';
  colavoradores.empleado.estado_civil__pc='Viudo';
  colavoradores.empleado.PersonBirthDate=date.today();
  colavoradores.tipoaportacion='Ambas';
  colavoradores.salario=2143;
  colavoradores.empleado.currencyIsoCode='HNL';
  colavoradores.AgregarPersonal(); 
        
  colavoradores.mostrarNuevo();
   colavoradores.empleado.id=null; 
   colavoradores.nombre='carlos 54';
   colavoradores.apellido='hu cds';
   colavoradores.Num_Identidad='000000r43002';
  colavoradores.empleado.tipo_identificacion__C=null;
  colavoradores.empleado.sexo__C='Femenino';
  colavoradores.empleado.estado_civil__pc='Unión Libre';
  colavoradores.empleado.PersonBirthDate=date.today();
  colavoradores.tipoaportacion='Ambas';
  colavoradores.salario=2143;
  colavoradores.empleado.currencyIsoCode='HNL';
  colavoradores.AgregarPersonal(); 
        
        
   
  colavoradores.idEmpleado=colavoradores.listClientes[0].id;     
  colavoradores.eliminar();
   colavoradores.tipoaportacion='Voluntarias'; 
  colavoradores.Enviarcuentas();
  colavoradores.tipoaportacion='Obligatorios'; 
  colavoradores.Enviarcuentas();
   colavoradores.Num_Identidad='000000r43002';
   colavoradores.buscar();
   colavoradores.iniciar();
   colavoradores.Inicio=0;
   colavoradores.fin=1;
   colavoradores.AgregarEMpleados();
   colavoradores.metodoutil();
        
         
    // TEST CALCULO DE PILARES
    ApexPages.currentPage().getParameters().put('Eldudhdhyudb',empresaprueba.id);
      ApexPages.currentPage().getParameters().put('loetdncdhjch',usuario.id);
     ControladorcalculoPilares calculoPilares = new ControladorcalculoPilares();
     calculoPilares.descargar();
     Calculopilares.siguiente();
    Calculopilares.anterior(); 
   test.stopTest();
        
    // TEST GENERACIÓN PLANILLA IHSS
    ApexPages.currentPage().getParameters().put('Eldudhdhyudb',empresaprueba.id);
      ApexPages.currentPage().getParameters().put('loetdncdhjch',usuario.id);
     controladorgenerarPlanillaIHSS Palnillaihss = new controladorgenerarPlanillaIHSS();
     Palnillaihss.descargar();
     Palnillaihss.siguiente();
    Palnillaihss.anterior(); 
        
   // TEST Reportes
  	 Planilla__C lop=new Planilla__C();
    lop.Estado2__c='Pendiente Aprobación Interna';
    lop.Empresa2__c=empresaprueba.id;
    lop.Fecha__c=date.today();
    insert lop;     
    contenido_planilla__C frg=new contenido_planilla__C();
    frg.empleado2__C=clienteprueba.id;
    frg.Salario__c=3254;
    frg.Planilla__c=lop.id;
    insert frg;
    ApexPages.currentPage().getParameters().put('Eldudhdhyudb',empresaprueba.id);
     controladorreportes reportes = new controladorreportes();
     reportes.MetodoUtil();
     reportes.idPilar='Ninguno';
     reportes.Desde=date.today();
     reportes.Hasta=date.today();
     reportes.buscar();
     reportes.id_planilla=lop.id;
    reportes.cerrar();
     reportes.VerPlanilla();
    
     reportes.idPilar='Pilar Voluntario';
     reportes.Desde=date.today();
     reportes.Hasta=date.today();
     reportes.buscar();
     reportes.id_planilla=lop.id;
    reportes.cerrar();
     reportes.VerPlanilla();
     reportes.siguiente();
    reportes.anterior();
        
     reportes.Num_Identidad=clienteprueba.Identificacion__C;
     reportes.idPilar='Ninguno';
     reportes.buscar();
     reportes.id_planilla=lop.id;
    reportes.cerrar();
     reportes.VerPlanilla();
     reportes.siguiente();
    reportes.anterior();
        
     reportes.Num_Identidad=clienteprueba.Identificacion__C;
     reportes.idPilar='Pilar Voluntario';
     reportes.Desde=date.today();
     reportes.Hasta=date.today();
     reportes.buscar();
     reportes.id_planilla=lop.id;
    reportes.cerrar();
     reportes.VerPlanilla();
      reportes.siguiente();
    reportes.anterior();   
        
     reportes.Num_Identidad='';
     reportes.idPilar='Seguro Social';
     reportes.Desde=date.today();
     reportes.Hasta=date.today();
     reportes.buscar();
     reportes.id_planilla=Palnillaihss.poo.id;
    reportes.cerrar();
     reportes.VerPlanilla();
     reportes.siguiente();
    reportes.anterior(); 
        
     reportes.Num_Identidad=clienteprueba.Identificacion__C;
     reportes.idPilar='Seguro Social';
     reportes.Desde=date.today();
     reportes.Hasta=date.today();
     reportes.buscar();
     reportes.id_planilla=Palnillaihss.poo.id;
    reportes.cerrar();
     reportes.VerPlanilla();    
      reportes.siguiente();
    reportes.anterior(); 
    reportes.ReportePlanilla();
    reportes.ReportePlanillaIHSS();
     
    ApexPages.currentPage().getParameters().put('IdPlanilla',lop.id);     
    controladorVerPlanillaNormal reporte= new controladorVerPlanillaNormal();     
     // TEST USUARIOS   
     
     ApexPages.currentPage().getParameters().put('Eldudhdhyudb',empresaprueba.id);
     ApexPages.currentPage().getParameters().put('loetdncdhjch',usuario.id); 
     b usuarios = new b();
     usuarios.verCambioContrasena();
        usuarios.banderatiempo=1;
      usuarios.contrasenaActual='Cualquiera';
    usuarios.contrasenaNueva='Hola1234@';
    usuarios.contrasenaRepetida='Ho234@';
    usuarios.cambiarContrasena();
      usuarios.contrasenaActual='Cualera';
    usuarios.contrasenaNueva='Hola1234@';
    usuarios.contrasenaRepetida='Hola1234@';
    usuarios.cambiarContrasena();
    usuarios.contrasenaActual='´Cualquiera';
    usuarios.contrasenaNueva='Hola1234@';
    usuarios.contrasenaRepetida='Hola1234@';
    usuarios.cambiarContrasena();
     usuarios.contrasenaActual='Cualquiera';
    usuarios.contrasenaNueva='Hola1234@';
    usuarios.contrasenaRepetida='Hola1234@';
    usuarios.cambiarContrasena();
    usuarios.ActivarModalModificarusuario();
   usuarios.ActivarModalCrearusuario();
        
    Usuario_Temporal__c usuario2 = new Usuario_Temporal__c();
      usuario2.Apellidos__c='Meraz';
      //usuario2.Contrasena2__c='Cualquiera';
      usuario2.Email__c='marcela.meraz@gmail.com';
      usuario2.Name='Yeny';
      //usuario2.Respuesta__c='Lunes';
      usuario2.Identidad__c='0303199702887';
     // usuario2.Nombre_Usuario__c='chema';
      insert usuario2;
        
       
       Usuario_Empresa_Temporal__c aa = new Usuario_Empresa_Temporal__c();
       aa.empresa2__C=empresaprueba.id;
       aa.Activo__c=true;
       aa.Aprobacion_Usuarios__c=TRUE;
       aa.Usuario__c=usuario2.id;
       aa.Estado__c=0;
       insert aa; 
       usuarios.Num_Identidad='0303199702887';
      usuarios.Denegar();
        
       usuario2 = new Usuario_Temporal__c();
      usuario2.Apellidos__c='Meraz';
      //usuario2.Contrasena2__c='Cualquiera';
      usuario2.Email__c='marcela.meraz@gmail.com';
      usuario2.Name='Yeny';
      //usuario2.Respuesta__c='Lunes';
      usuario2.Identidad__c='0303199702883';
     // usuario2.Nombre_Usuario__c='chema';
      insert usuario2;
        
       
        aa = new Usuario_Empresa_Temporal__c();
       aa.empresa2__C=empresaprueba.id;
       aa.Activo__c=true;
       aa.Aprobacion_Usuarios__c=TRUE;
       aa.Usuario__c=usuario2.id;
       aa.Estado__c=0;
       aa.modificado__C=true;
       insert aa; 
       usuarios.Num_Identidad='0303199702883';
      usuarios.Denegar();
     
      usuarios.Num_Identidad='0303199702883';
      usuarios.Aprobar();
        
      usuario2 = new Usuario_Temporal__c();
      usuario2.Apellidos__c='Meraz';
      //usuario2.Contrasena2__c='Cualquiera';
      usuario2.Email__c='marcela.meraz@gmail.com';
      usuario2.Name='Yeny';
      //usuario2.Respuesta__c='Lunes';
      usuario2.Identidad__c='03031199400038';
     // usuario2.Nombre_Usuario__c='chema';
      insert usuario2;
        
       
        aa = new Usuario_Empresa_Temporal__c();
       aa.empresa2__C=empresaprueba.id;
       aa.Activo__c=true;
       aa.Aprobacion_Usuarios__c=TRUE;
       aa.Usuario__c=usuario2.id;
       aa.Estado__c=0;
       aa.modificado__C=false;
       insert aa; 
       
      usuarios.Num_Identidad='03031199400038';
      usuarios.Aprobar();  
		
        
        
    // TEST PLANILLAS ENVIADAS
    Planilla__C planilla1= new Planilla__C();
      planilla1.CurrencyIsoCode='HNL';
      planilla1.Empresa2__c=empresaprueba.id;
      planilla1.Tasa_compra__c =1;
      planilla1.estado2__c='Pendiente aprobacion Ficohsa';
      planilla1.Fecha__c=date.today();
      insert planilla1;
      
     Planilla__C planilla2= new Planilla__C();
      planilla2.CurrencyIsoCode='USD';
      planilla2.Empresa2__c=empresaprueba.id;
      planilla2.Tasa_compra__c =0;
      planilla2.Fecha__c=date.today();
      planilla2.estado2__c='Pendiente aprobacion Ficohsa';
      insert planilla2;
        
      CONTENIDO_PLANILLA__c contenido = new CONTENIDO_PLANILLA__c();
      contenido.Aporte_Empleado_Obligatorio__c=21;
      contenido.Aporte_Patrono_Obligatorio__c=21;
      contenido.Aporte_Empleado_Voluntario__c=21;
     contenido.Aporte_Patrono_Voluntario__c=21;
     contenido.reserva_laboral__C=21;
     contenido.Planilla__c=planilla1.id;
     insert contenido;
        
      contenido = new CONTENIDO_PLANILLA__c();
        contenido.Empleado2__c=CLIENTEPRUEBA.ID;
      contenido.Aporte_Empleado_Obligatorio__c=21;
      contenido.Aporte_Patrono_Obligatorio__c=21;
      contenido.Aporte_Empleado_Voluntario__c=21;
     contenido.Aporte_Patrono_Voluntario__c=21;
     contenido.reserva_laboral__C=21;
     contenido.Planilla__c=planilla2.id;
     insert contenido;
        
    cuenta_planilla__C  cuentaplanilla =new cuenta_planilla__C();
    cuentaplanilla.Valor_Monto__c=435;
     cuentaplanilla.Valor_Monto_Patrono__c=43;
     CUENTAPLANILLA.Codigo_cuenta__c='11';
     cuentaplanilla.Contenido_Planilla__c=contenido.id;
     cuentaplanilla.Cuenta__c= CODIGOCEUNTA;
     insert cuentaplanilla;
       
     
        
     controladorplanillasenviadas gt = new controladorplanillasenviadas();  
     gt.id_planilla=gt.planillas[1].id_cambiarSalario;
     gt.planillas[1].APO=2;
     gt.CambioTasa();
        
     gt.id_planilla=gt.planillas[1].id_cambiarSalario;
     gt.Aprobarplanilla();
     //gt.id_planilla=gt.planillas[1].id_cambiarSalario;
     
     gt.Denegarplanilla(); 
     gt.id_pantalla='2';
     //gt.Controladorbg();
     gt.metodoutil();
     gt.OrdenarPlanilla();
   //test.stopTest();
    }
    */
    
    
    
	static testmethod void TestPortalFPC()
  	{
        
       Account EmpresaPrueba= new Account();
        empresaprueba.Name='Empresa Prueba';
        EmpresaPrueba.RecordTypeId = '012j0000000i2TcAAI';
        EmpresaPrueba.Identificacion__c='012j0000';
        EmpresaPrueba.Salario_Base_Pilar_Complementario__c=10000;
        EmpresaPrueba.Salario_Base_Reserva_Laboral__c=10000;
        EmpresaPrueba.PAPCT__c=3;
        EmpresaPrueba.PAPCE__c=3;
        EmpresaPrueba.Porcentaje_de_Aportaciones_Reserva_Labor__c=4;
        EmpresaPrueba.Salario_Base_Seguro_Social__c=432;
        EmpresaPrueba.Porc_Apor_SSoc_Empleador_IVM__c=3;
        EmpresaPrueba.Porc_Apor_SSoc_Empleado_IVM__c=3;
        EmpresaPrueba.Salario_Base_Seguro_Social_Mater__c=4;
        EmpresaPrueba.Porc_Apor_SSoc_Empleador_Mater__c=5;
        EmpresaPrueba.Porc_Apor_SSoc_Empleado_Mater__c=5;
        
        EmpresaPrueba.Salario_Base_Seguro_Social_RP__c=43433;
        EmpresaPrueba.Riesgo_Profecional_Patronal__c=6;
       
        insert EmpresaPrueba;
        
        Account ClientePrueba= new Account();
		ClientePrueba.lastname='Doanire';
		ClientePrueba.firstname='Luis';
		ClientePrueba.RecordTypeId = '012j0000000i3wAAAQ';
		ClientePrueba.Identificacion__c='00000000000000';
        ClientePrueba.Tipo_Identificacion__c='Cedula de identidad';
		ClientePrueba.Sexo__c='Masculino';
		ClientePrueba.CurrencyIsoCode = 'HNL';
		ClientePrueba.Estado_Civil__pc='Soltero';
		insert ClientePrueba;
        
         Account ClientePrueba2= new Account();
		ClientePrueba2.lastname='Castañeda';
		ClientePrueba2.firstname='Enrique';
		ClientePrueba2.RecordTypeId = '012j0000000i3wAAAQ';
		ClientePrueba2.Identificacion__c='00000000000001';
		insert ClientePrueba2;
        
        Account ClientePrueba3= new Account();
		ClientePrueba3.lastname='Castañeda DOna';
		ClientePrueba3.firstname='Idania Casta';
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
       colectiva.Tipo_Cuenta__c='Voluntarias';
       colectiva.Codigo__c='32546';
       colectiva.Empresa__c=empresaprueba.id;
       insert colectiva;
        
       Colectiva= new Cuentas_Colectivas__c();
       colectiva.Tipo_Cuenta__c='Pilar Complementario';
       colectiva.Codigo__c='32746';
       colectiva.Empresa__c=empresaprueba.id;
       insert colectiva;
       
        Colectiva= new Cuentas_Colectivas__c();
       colectiva.Tipo_Cuenta__c='Censatías';
       colectiva.Codigo__c='032746';
       colectiva.Empresa__c=empresaprueba.id;
       insert colectiva;
        
       Cuentas__C cuentaNormal= new Cuentas__C();
       cuentaNormal.CurrencyIsoCode='HNL';
       cuentaNormal.Codigo__c='11';
       cuentaNormal.Cliente__c=ClientePrueba.id;
       cuentanormal.Cuenta_colectiva2__c=cuentacolectiva.id;
       cuentaNormal.Producto__c=producto.id;
       insert cuentaNormal;
        
       STRING CODIGOCEUNTA = cuentaNormal.ID;
        
       cuentaNormal= new Cuentas__C();
       cuentaNormal.CurrencyIsoCode='HNL';
       cuentaNormal.Codigo__c='der2';
       cuentaNormal.Cliente__c=ClientePrueba2.id;
       cuentanormal.Cuenta_colectiva2__c=cuentacolectiva.id;
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
       
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
       hora.Usuario__c=usuario.id;
       hora.Hora_ultima_consulta__c=datetime.now();
       insert hora; 
        
        
       Autonumerico_cuentas_Syste__c gert= new Autonumerico_cuentas_Syste__c();
       gert.Id_Formulario_Sysde__c=0;
        insert gert;
        
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
      
      Usuario_Portal_Empresarial__c u= new Usuario_Portal_Empresarial__c();
      u.Apellidos__c='Me54raz';
      u.Contrasena2__c='Cu54alquiera';
      u.Email__c='mar54cela.meraz@gmail.com';
      u.Name='Yeny';
      u.Respuesta__c='Lunes54';
      u.Identidad__c='0303199400038';
      u.Nombre_Usuario__c='kike';
      insert u;
        
        a = new Usuario_X_Empresa__c();
       a.empresa2__C=empresaprueba.id;
       a.Usuario__c=u.id;
       a.Activo__c=true;
       a.Aprobacion_Usuarios__c=TRUE;
       a.Calculo_De_Pilares__c=true;
       a.Cargar_Generar_Planilla__c=true;
       a.Crear_Usuarios__c=true;
       a.Nuevo_Personal__c=true;
       a.Reportes__c=true;
       a.Planilla_Seguro_Social__c=true;
       insert a;
      
        
        
        
        
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
      test.startTest();
        //     TEST LOGIN
   /*   controllerLoginEmpresarial tr= new controllerLoginEmpresarial();
      tr.usuario='Chema';
      tr.Contrasena='Cualquiera';
      tr.Cambiousuario='Chema';
      tr.sesionIniciada();
      tr.olvide();
      tr.salir();
      tr.cambiarclave();
        
      //TEST HOME
      ApexPages.currentPage().getParameters().put('Eldudhdhyudb',empresaprueba.id);
      ApexPages.currentPage().getParameters().put('loetdncdhjch',usuario.id);
     controladorhome home = new controladorhome();
      home.DatosHome();  
        
     //TEST MENUPRINCIPAL
     
       ApexPages.currentPage().getParameters().put('Eldudhdhyudb',empresaprueba.id);
      ApexPages.currentPage().getParameters().put('loetdncdhjch',usuario.id); 
      ControladorMenuPlanillas menu =new ControladorMenuPlanillas();
      menu.Home();
      menu.CalculoDePilares();
      menu.Colaboradesvigentes();
      menu.SeleccionarEmpresa();
      menu.CargarSalarios();
      menu.GenerarPlanillaHNL();
      menu.GenerarPlanillaUSD();
      menu.GenerarSalarios();
      menu.CargarPlanillaUSD();
      menu.CargarPlanillaHNL();
      menu.CargarPersonal();
      menu.GenerarPersonal();
      menu.AceptarPlanilla();
      menu.Reportes();
      menu.GenerarPlanillaSS();
      menu.CargarPlanillaSS();
      menu.CalculoDePilares();
      menu.CrearUsuarios();
      //menu.ModificarUsuarios();
      menu.MostarPantallas();
      menu.cerrar();
      menu.metodoutil();
      menu.metodoutil2();*/
      //TEST GENERAR PLANILLA
      ApexPages.currentPage().getParameters().put('Eldudhdhyudb',empresaprueba.id);
      ApexPages.currentPage().getParameters().put('loetdncdhjch',usuario.id); 
      ApexPages.currentPage().getParameters().put('Moneda','HNL');   
      ControladorgenerarPlanilla Planilla = new ControladorgenerarPlanilla();
      planilla.registrarTiempo();
      planilla.banderaTiempo=1;
      planilla.cerrar();
      planilla.metodoutil();
      planilla.generarNuevaPlanilla();
      planilla.CopiarPlanilla();
      planilla.idPlanilla=planilla.planilla.id;
      planilla.cambiarPlanilla();
      planilla.exportarE();
      planilla.traerContenido();
      //planilla.idempleado=planilla.contenidoPlanilla[0].empleado2__C;
      planilla.mostrarQuitarE();
      //planilla.idContenido=planilla.contenidoPlanilla[0].id;
      planilla.quitarEmpleado();
      //planilla.empleadoE.Motivo_despido__c='Otros';
      planilla.quitarEmpleado();
      planilla.mostrarAgregarEmpleado();
      planilla.listEmpleadosEmpresa[0].eliminado__C=true;
      planilla.agregarEmpleado();
      //planilla.idContenido=planilla.contenidoPlanilla[0].id;  
      planilla.mostrarModificarE();
      planilla.modificarEmpleado();
     Cuenta_planilla__c cuentaplanilla = new Cuenta_planilla__c();
      cuentaplanilla.Codigo_cuenta__c='der3';
      //cuentaplanilla.Tipo__c='Empresa';
      cuentaplanilla.Cuenta__c=cuentanormal.id;
      cuentaplanilla.Valor_Monto__c=200;
      cuentaplanilla.Valor_Monto_Patrono__c=200;
      //cuentaplanilla.Contenido_Planilla__c=planilla.contenidoPlanilla[0].id;
      //insert cuentaplanilla;
      planilla.esAPV=true;
      //planilla.idContenido=planilla.contenidoPlanilla[0].id;
      planilla.mostrarCuentas();
      planilla.aceptarCuentas(); 
      planilla.esAPV=false;
      //planilla.idContenido=planilla.contenidoPlanilla[0].id;
      planilla.mostrarCuentas();
      planilla.aceptarCuentas(); 
      planilla.guardarPlanilla();  
      planilla.enviarPlanilla();
      
      planilla.siguiente();
      planilla.anterior();   
      planilla.idPlanilla='gty';
      planilla.cambiarPlanilla();  
      planilla.idempleado='try';
      planilla.mostrarQuitarE();
      planilla.idContenido='try';
      planilla.quitarEmpleado();
      //planilla.empleadoE.Motivo_despido__c='Ots';
      planilla.quitarEmpleado();
        planilla.mostrarAgregarEmpleado();
        //planilla.listEmpleadosEmpresa[0].eliminado__C=null;
        planilla.agregarEmpleado();
        planilla.idContenido='try';  
        planilla.mostrarModificarE();
        planilla.modificarEmpleado();  
        planilla.guardarPlanilla();
        planilla.PruebaAportes();
        ApexPages.currentPage().getParameters().put('id_pla',planilla.planilla.id);
        ControladorExportarEPlanilla nhj= new ControladorExportarEPlanilla();
        nhj.CArgarPlanilla();    
        
        /*
        
    // Test Aceptar Planilla
    Planilla__C lo=new Planilla__C();
    lo.Estado2__c='Pendiente Aprobación Interna';
    lo.Empresa2__c=empresaprueba.id;
    lo.Fecha__c=date.today();
    insert lo;
    string hy=lo.id;
     lo.id=null;
     insert lo;  
     ApexPages.currentPage().getParameters().put('Eldudhdhyudb',empresaprueba.id);
     ApexPages.currentPage().getParameters().put('loetdncdhjch',usuario.id);    
    contenido_planilla__C fr=new contenido_planilla__C();
    fr.empleado2__C=clienteprueba.id;
    fr.Salario__c=3254;
    fr.Planilla__c=hy;
    insert fr;
    fr.id=null;
     insert fr;
    controladorAceptarPlanilla g = new controladorAceptarPlanilla();
   	g.aceptar();
    g.exportarE();
    g.cerrar();
    g.mostrarDenegar();
    g.siguiente();
    g.anterior();
    //g.denegar();
    g.metodoutil();
    
        
    claseUtilPla ju = new claseUtilPla(); 
    ju.planilla=1;
    claseUtilPla2 juo = new claseUtilPla2();
    juo.planilla=1;
    
     
   test.stopTest();

     */ 
  	}
    
    
    
    
    
}