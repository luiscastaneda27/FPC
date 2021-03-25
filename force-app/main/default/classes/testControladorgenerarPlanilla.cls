@isTest
public class testControladorgenerarPlanilla {
    
    static testmethod void ControladorgenerarPlanilla(){
        
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
        
        Tasa_De_Cambio__c tasa =new Tasa_De_Cambio__c(Tasa__C = 12.12, fecha__C = date.today()); 
        insert tasa;
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
        //planilla.exportarE();
        //planilla.traerContenido();
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
        planilla.CancelarPlanilla();
        ApexPages.currentPage().getParameters().put('id_pla',planilla.planilla.id);
        ControladorExportarEPlanilla nhj= new ControladorExportarEPlanilla();
        nhj.CArgarPlanilla();  
        
        
        test.stopTest();

      
  	}
    

}