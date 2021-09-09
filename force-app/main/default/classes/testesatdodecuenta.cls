@istest
public class testesatdodecuenta {
	
    static testmethod void clasesutilizadas() 
    {
        test.startTest(); 
         list<planilla> planil=new list<Planilla>(); 
        planil.add(new planilla('','','','','','','','',date.today(),'',7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7));
        planil.add(new planilla('','',7.7,7.7,7.7,7.7,7.7,''));
        list<cuenta> vf= new list<cuenta>();
        vf.add(new cuenta('',54.54));
        planil.add(new planilla('','','','','',7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,vf,vf,vf,vf,vf));
        planil.add(new planilla('','','','','',7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,vf,vf,vf,vf,vf,'','',''));
        planil.add(new planilla('','','','','',7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,''));
        planil.add(new planilla('','','','','',7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7));
        planil.add(new planilla('',1));
        planil.add(new planilla('','','','','',7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7));
        planil.add(new planilla('','',date.today(),'',9.0,'',''));
        planil.add(new planilla('','','','','','',7.7,7.7));
        planil.add(new planilla('','','','','',7.7,7.7,7.7,7.7,8.7,8.7,8.7,8.7,'',9.9));
        planil.add(new planilla('', '', '','','', 0.0, 0.0,0.0, 0.0,0.0, 0.0,0.0,0.0, 0.0));
        planil.add(new Planilla(0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0));
        planil.add(new Planilla('', 0, ''));
        planil.add(new Planilla('', 1, 0.0, 0.0,0.0,0.0,0.0,0.0,0.0,0.0));
        planil.add(new planilla('','',date.today(),'',9.0,'','','','',''));
         list<claseaportaciones> aportacio= new list<claseaportaciones>();
     aportacio.add(new claseaportaciones('','',65.65,65.65,65.65,65.65,65.65,''));  
    
     
    /*claseUtilPla ju = new claseUtilPla();
    ju.planilla=1;
    claseUtilPla2 juo = new claseUtilPla2();
    juo.planilla=1;*/
        
        
        
        
        
        
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
       cuentanormal.Cuenta_colectiva2__c=null;
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
       Planilla_Temporal__c tem = new Planilla_Temporal__c();
        tem.Name = EmpresaPrueba.Id;
        insert tem;
        
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
        temp.planilla__c = tem.Id;
        insert temp;
      
        ApexPages.currentPage().getParameters().put('empresa',empresaprueba.id);
        controladorExportarExcelColavoradores frcds= new controladorExportarExcelColavoradores();
         // TEST COLAVORADORES VIGENTES NO INSERTAR EL EMPLEADO QUE GANA 30000
    
     ApexPages.currentPage().getParameters().put('Eldudhdhyudb',empresaprueba.id);
     ApexPages.currentPage().getParameters().put('loetdncdhjch',usuario.id);    
    /*controladorGenerarPersonal Colavoradores=new controladorGenerarPersonal();
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
   colavoradores.AgregarEMpleados();*/
        
        string stringCSV ='"NUM IDENTIDAD", "APORTE PATRONO OBLIGATORIO", "APORTE EMPLEADO OBLIGATORIO", "RESERVA LABORAL", "APORTE PATRONO VOLUNTARIO",'+
        ' "CUENTA", "APORTE EMPLEADO EXTRAORDINARIO", "APORTE PATRONO EXTRAORDINARIO", "APORTE SEGURO DE VIDA", "APORTE EMPLEADO VOLUNTARIO"\n"0000000000040",15,15,15,15,"",15\n';
        classWRetorno2 error = new classWRetorno2();
     error=controladorCargarPlanilla.SUbirInformacion(stringCSV, empresaprueba.id);
        controladorCargarPlanilla Cplanilla = new controladorCargarPlanilla();
     
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