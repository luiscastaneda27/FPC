@isTest
public class TestcontroladorPlanillasEnviadas {
    static testmethod void Colavoradore(){
        Account Empresa= new Account();
        Empresa.Name='Empresa Prueba';
        Empresa.RecordTypeId = '012j0000000i2TcAAI';
        Empresa.Identificacion__c = '012j0000';
        Empresa.Salario_Base_Pilar_Complementario__c=10000;
        Empresa.Salario_Base_Reserva_Laboral__c=10000;
        Empresa.PAPCT__c=3;
        Empresa.PAPCE__c=3;
        Empresa.Porcentaje_de_Aportaciones_Reserva_Labor__c=4;
        Empresa.Salario_Base_Seguro_Social__c=432;
        Empresa.Porc_Apor_SSoc_Empleador_IVM__c=3;
        Empresa.Porc_Apor_SSoc_Empleado_IVM__c=3;
        Empresa.Salario_Base_Seguro_Social_Mater__c=4;
        Empresa.Porc_Apor_SSoc_Empleador_Mater__c=5;
        Empresa.Porc_Apor_SSoc_Empleado_Mater__c=5;
        Empresa.Salario_Base_Seguro_Social_RP__c=43433;
        Empresa.Riesgo_Profecional_Patronal__c=6;
        insert Empresa;
        
        Account cliente= new Account();
        cliente.lastname='Doanire';
        cliente.firstname='Luis';
        cliente.RecordTypeId = '012j0000000i3wAAAQ';
        cliente.Identificacion__c='00000000000000';
        cliente.Tipo_Identificacion__c='Cedula de identidad';
        cliente.Sexo__c='Masculino';
        cliente.CurrencyIsoCode = 'HNL';
        cliente.Estado_Civil__pc='Soltero';
        insert cliente;
        
        
        Producto__C producto=New Producto__C();
        producto.Codigo__c='01';
        producto.CurrencyIsoCode='HNL';
        insert producto;
        
        //VOLUNTARIAS
        Cuentas__C cuentaColectiva = new Cuentas__C();
        cuentacolectiva.CurrencyIsoCode='HNL';
        cuentacolectiva.Codigo__c='00000';
        cuentacolectiva.Cliente__c=empresa.id;
        cuentacolectiva.Producto__c=producto.id;
        insert cuentacolectiva;
        
        Cuentas__C cuenta= new Cuentas__C();
        cuenta.CurrencyIsoCode='HNL';
        cuenta.Codigo__c='51600';
        cuenta.Cliente__c=Cliente.id;
        cuenta.Cuenta_colectiva2__c=cuentaColectiva.id;
        cuenta.Producto__c=producto.id;
        insert cuenta;
        
        Cuentas_Colectivas__c Colectiva= new Cuentas_Colectivas__c();
        colectiva.Tipo_Cuenta__c='Voluntarias';
        colectiva.Codigo__c='00000';
        colectiva.Empresa__c=empresa.id;
        insert colectiva;
        
        //Censatías 
        cuentaColectiva= new Cuentas__C();
        cuentacolectiva.CurrencyIsoCode='HNL';
        cuentacolectiva.Codigo__c='00001';
        cuentacolectiva.Cliente__c=empresa.id;
        cuentacolectiva.Producto__c=producto.id;
        insert cuentacolectiva;
        
        cuenta= new Cuentas__C();
        cuenta.CurrencyIsoCode='HNL';
        cuenta.Codigo__c='51601';
        cuenta.Cliente__c=Cliente.id;
        cuenta.Cuenta_colectiva2__c=cuentaColectiva.id;
        cuenta.Producto__c=producto.id;
        insert cuenta;
        
        Colectiva= new Cuentas_Colectivas__c();
        colectiva.Tipo_Cuenta__c='Censatías';
        colectiva.Codigo__c='00001';
        colectiva.Empresa__c=empresa.id;
        insert colectiva;
        
        
        //Pilar Complementario
        cuentaColectiva= new Cuentas__C();
        cuentacolectiva.CurrencyIsoCode='HNL';
        cuentacolectiva.Codigo__c='00002';
        cuentacolectiva.Cliente__c=empresa.id;
        cuentacolectiva.Producto__c=producto.id;
        insert cuentacolectiva;
        
        cuenta= new Cuentas__C();
        cuenta.CurrencyIsoCode='HNL';
        cuenta.Codigo__c='51602';
        cuenta.Cliente__c=Cliente.id;
        cuenta.Cuenta_colectiva2__c=cuentaColectiva.id;
        cuenta.Producto__c=producto.id;
        insert cuenta;
        
        Colectiva= new Cuentas_Colectivas__c();
        colectiva.Tipo_Cuenta__c='Pilar Complementario';
        colectiva.Codigo__c='00002';
        colectiva.Empresa__c=empresa.id;
        insert colectiva;
        
        empresa_x_empleado__C empleado= new empresa_x_empleado__C();
        empleado.Activo_Nueva_Planilla__c=true;
        empleado.Empresa2__c=empresa.id;
        empleado.Salario__c=20000;
        empleado.Estado__c='Activo';
        empleado.Empleado2__c=cliente.id;
        insert empleado;
        
        Autonumerico_cuentas_Syste__c form = new Autonumerico_cuentas_Syste__c(Id_Formulario_Sysde__c =21);
        insert form;
       
        test.startTest();
        
        Planilla__C planilla=new Planilla__C();
        planilla.Estado2__c='Pendiente Aprobación Ficohsa';
        planilla.Empresa2__c=empresa.id;
        planilla.mes_aporte__c = '1';
        planilla.Fecha__c=date.today();
        planilla.Tasa_compra__c = 1;
        insert planilla;
        
        contenido_planilla__C contenido=new contenido_planilla__C();
        contenido.empleado2__C=cliente.id;
        contenido.Salario__c=3254;
        contenido.Planilla__c=planilla.id;
        Contenido.Aporte_Empleado_Extraordinario__c  = 21;
        Contenido.Aporte_Patrono_Extraordinario__c  = 32;
        contenido.reserva_laboral__c = 21;
        contenido.Aporte_Patrono_obligatorio__c = 32;
        Contenido.Aporte_Seguro_de_Vida__c = 32;
        insert contenido;
        
        Cuenta_planilla__c cuentaPlanilla = new Cuenta_planilla__c ();
        cuentaPlanilla.Codigo_cuenta__c = '51600';
        cuentaPlanilla.Cuenta__c =cuenta.id;
        cuentaPlanilla.Valor_Monto__c = 21.21; 
        cuentaPlanilla.Contenido_Planilla__c=contenido.id; 
        insert cuentaPlanilla;
        
        cuentaPlanilla = new Cuenta_planilla__c ();
        cuentaPlanilla.Codigo_cuenta__c = '51601';
        cuentaPlanilla.Cuenta__c =cuenta.id;
        cuentaPlanilla.Valor_Monto__c = 21.21; 
        cuentaPlanilla.Contenido_Planilla__c=contenido.id; 
        insert cuentaPlanilla;
        
        cuentaPlanilla = new Cuenta_planilla__c ();
        cuentaPlanilla.Codigo_cuenta__c = '51602';
        cuentaPlanilla.Cuenta__c =cuenta.id;
        cuentaPlanilla.Valor_Monto__c = 21.21; 
        cuentaPlanilla.Contenido_Planilla__c=contenido.id; 
        insert cuentaPlanilla;
        
        planilla=new Planilla__C();
        planilla.Estado2__c='Pendiente Aprobación Ficohsa';
        planilla.Empresa2__c=empresa.id;
        planilla.mes_aporte__c = '1';
        planilla.Fecha__c=date.today();
        planilla.Tasa_compra__c = 0;
        insert planilla; 
        
        contenido=new contenido_planilla__C();
        contenido.empleado2__C=cliente.id;
        contenido.Salario__c=3254;
        Contenido.Aporte_Empleado_Extraordinario__c  = 21;
        Contenido.Aporte_Patrono_Extraordinario__c  = 32;
        Contenido.Aporte_Seguro_de_Vida__c = 32;
        contenido.Planilla__c=planilla.id;
        insert contenido;
        
        cuentaPlanilla = new Cuenta_planilla__c ();
        cuentaPlanilla.Codigo_cuenta__c = '51600';
        cuentaPlanilla.Cuenta__c =cuenta.id;
        cuentaPlanilla.Valor_Monto__c = 21.21; 
        cuentaPlanilla.Contenido_Planilla__c=contenido.id; 
        cuentaPlanilla.Valor_Monto_Patrono__c =21;
        insert cuentaPlanilla;
        
        planilla=new Planilla__C();
        planilla.Estado2__c='Pendiente Aprobación Ficohsa';
        planilla.Empresa2__c=empresa.id;
        planilla.mes_aporte__c = '1';
        planilla.Fecha__c=date.today();
        planilla.Tasa_compra__c = 1;
        insert planilla; 
        
        controladorPlanillasEnviadas planillaEnviada = new controladorPlanillasEnviadas();
        planillaEnviada.Id_Planilla = planillaEnviada.planillas[0].id_cambiarSalario;
        planillaEnviada.planillas[0].rezago = 'N';
        planillaEnviada.planillas[0].Planilla_Aprobada = date.today();
        //Rezagos
        planillaEnviada.Num_CodReferencia_Rez = 'FT20prueba4';
        planillaEnviada.CodRefTest = 'FT20prueba4';
        planillaEnviada.num_CodCuenta_Rez = '100110';
        planillaEnviada.Monto_Calculado = '40000';
        planillaEnviada.Monto_Sal = '40000';
        planillaEnviada.Monto = '40000';
        planillaEnviada.Moneda = 'HNL';
        planillaEnviada.Compra_Dolar = 'N';
        //
        planillaEnviada.Aprobarplanilla();
        
        
        planillaEnviada.Id_Planilla =planillaEnviada.planillas[0].id_cambiarSalario;
        planillaEnviada.planillas[0].rezago = 'N';
        planillaEnviada.planillas[0].Planilla_Aprobada = date.today();
        planillaEnviada.Aprobarplanilla();
        
        planillaEnviada.Id_Planilla = planillaEnviada.planillas[0].id_cambiarSalario;
        planillaEnviada.planillas[0].rezago = 'N';
        planillaEnviada.planillas[0].Planilla_Aprobada = date.today();
        planillaEnviada.Denegarplanilla();
        //Nuevo
        Planilla__C planilla2=new Planilla__C();
        planilla2.Estado2__c='Pendiente Aprobación Ficohsa';
        planilla2.Empresa2__c = empresa.id;
        planilla2.mes_aporte__c = '1';
        planilla2.Fecha__c=date.today();
        planilla2.Tasa_compra__c = 1;
        insert planilla2;
        
        contenido_planilla__C contenido2=new contenido_planilla__C();
        contenido2.empleado2__C=cliente.id;
        contenido2.Salario__c=3254;
        contenido2.Planilla__c=planilla.id;
        Contenido2.Aporte_Empleado_Extraordinario__c  = 21;
        Contenido2.Aporte_Patrono_Extraordinario__c  = 32;
        contenido2.reserva_laboral__c = 21;
        contenido2.Aporte_Patrono_obligatorio__c = 32;
        Contenido2.Aporte_Seguro_de_Vida__c = 32;
        insert contenido2;
        
        Cuenta_planilla__c cuentaPlanilla2 = new Cuenta_planilla__c ();
        cuentaPlanilla2.Codigo_cuenta__c = '51600';
        cuentaPlanilla2.Cuenta__c =cuenta.id;
        cuentaPlanilla2.Valor_Monto__c = 21.21; 
        cuentaPlanilla2.Contenido_Planilla__c=contenido2.id; 
        insert cuentaPlanilla2;
        
        cuentaPlanilla2 = new Cuenta_planilla__c ();
        cuentaPlanilla2.Codigo_cuenta__c = '51601';
        cuentaPlanilla2.Cuenta__c =cuenta.id;
        cuentaPlanilla2.Valor_Monto__c = 21.21; 
        cuentaPlanilla2.Contenido_Planilla__c=contenido2.id; 
        insert cuentaPlanilla2;
        
        cuentaPlanilla2 = new Cuenta_planilla__c ();
        cuentaPlanilla2.Codigo_cuenta__c = '51602';
        cuentaPlanilla2.Cuenta__c =cuenta.id;
        cuentaPlanilla2.Valor_Monto__c = 21.21; 
        cuentaPlanilla2.Contenido_Planilla__c=contenido2.id; 
        insert cuentaPlanilla2;
        
        planilla2=new Planilla__C();
        planilla2.Estado2__c='Pendiente Aprobación Ficohsa';
        planilla2.Empresa2__c=empresa.id;
        planilla2.mes_aporte__c = '1';
        planilla2.Fecha__c=date.today();
        planilla2.Tasa_compra__c = 0;
        insert planilla2; 
        
        contenido2=new contenido_planilla__C();
        contenido2.empleado2__C=cliente.id;
        contenido2.Salario__c=3254;
        Contenido2.Aporte_Empleado_Extraordinario__c  = 21;
        Contenido2.Aporte_Patrono_Extraordinario__c  = 32;
        Contenido2.Aporte_Seguro_de_Vida__c = 32;
        contenido2.Planilla__c=planilla2.id;
        insert contenido2;
        
        cuentaPlanilla2 = new Cuenta_planilla__c ();
        cuentaPlanilla2.Codigo_cuenta__c = '51600';
        cuentaPlanilla2.Cuenta__c =cuenta.id;
        cuentaPlanilla2.Valor_Monto__c = 21.21; 
        cuentaPlanilla2.Contenido_Planilla__c=contenido2.id; 
        cuentaPlanilla2.Valor_Monto_Patrono__c =21;
        insert cuentaPlanilla2;
        
        planilla2=new Planilla__C();
        planilla2.Estado2__c='Pendiente Aprobación Ficohsa';
        planilla2.Empresa2__c=empresa.id;
        planilla2.mes_aporte__c = '1';
        planilla2.Fecha__c=date.today();
        planilla2.Tasa_compra__c = 1;
        insert planilla2; 
        
        controladorPlanillasEnviadas planillaEnviada2 = new controladorPlanillasEnviadas();
        planillaEnviada2.Id_Planilla = planillaEnviada2.planillas[0].id_cambiarSalario;
        planillaEnviada2.planillas[0].rezago = 'S';
        planillaEnviada2.planillas[0].Planilla_Aprobada = date.today();
        //Rezagos
        planillaEnviada2.Num_CodReferencia_Rez = 'FT20prueba4';
        planillaEnviada2.CodRefTest = 'FT20prueba4';
        planillaEnviada2.num_CodCuenta_Rez = '100110';
        planillaEnviada2.Monto_Calculado = '40000';
        planillaEnviada2.Monto_Sal = '40000';
        planillaEnviada2.Monto = '40000';
        planillaEnviada2.Moneda = 'HNL';
        planillaEnviada2.Compra_Dolar = 'N';
        //
        planillaEnviada2.Aprobarplanilla();
        //
        planillaEnviada2.Id_Planilla = planillaEnviada2.planillas[1].id_cambiarSalario;
        planillaEnviada2.planillas[1].rezago = 'S';
        planillaEnviada2.planillas[1].Planilla_Aprobada = date.today();
        planillaEnviada2.Aprobarplanilla();
        
        planillaEnviada.id_pantalla = '2';
        planillaEnviada.Controladorbg();
        
        planillaEnviada.id_pantalla = '1';
        planillaEnviada.Controladorbg();
        
        planillaEnviada.cerrar();
        
        
        planillaEnviada.showPopup();
        planillaEnviada.SearchValores();
        planillaEnviada.Aplicar();
        
        test.stopTest();
    }
    
}