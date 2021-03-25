@istest
public class testaSysdePortalEmpresarial {
    
    static testmethod void aSysdePortalEmpresarial () {
        
        
        classDolares.classRespuestaDolares p = new classDolares.classRespuestaDolares();
        p.id='';
        p.monedaDestino='';
        p.monedaOrigen='';
        p.montoAcreditado='';
        p.tasaCambio = '';
        p.montoDebitado ='';
         Account Empresa= new Account();
        Empresa.Name='Empresa Prueba';
        Empresa.RecordTypeId = '012j0000000i2TcAAI';
        Empresa.Identificacion__c='012j0000';
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
        Cuentas__C cuentaColectiva= new Cuentas__C();
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
        
       
        
        
        
        
        aSysdePortalEmpresarial.CompraVentaDolares('USD', 32.32, 'Prueba');
        aSysdePortalEmpresarial.fechaCierreSysde();
        list<string> listIdentidades = new list<string>();
        listIdentidades.add('00000000000000');
        aSysdePortalEmpresarial.agregarPersonaPlanilla(listIdentidades);
        
        Tasa_De_Cambio__c tasac= new Tasa_De_Cambio__c();
        insert tasac;
        
        aSysdePortalEmpresarial.traertasacambio();
        asysdePortalEmpresarial.ConsultalAportesPatronales(listIdentidades, empresa.id);
        
        set<Id> listEnviar = new set<Id>();   
        listEnviar.add(planilla.id);
        aSysdePortalEmpresarial.cerrarPlanilla(listEnviar);
        aSysdePortalEmpresarial.EnviarAportesEmpleados('SF36,0801199411013,33101,51600,51600,1,1800.00,0.00,0,0,3000.00,0.00,0.00::::', 1, datetime.now(), planilla.id,'fd','fd');
        aSysdePortalEmpresarial.Afiliacionsysde('1', '0801199411013', '', '', '', '', '', '', 21.21, '00000', '00000','00000', '00000', '00000', '00000');
        aSysdePortalEmpresarial.VerificacionEmpleados('','');
        aSysdePortalEmpresarial.Afiliacionsysdemasiva('21,0801199411013,21,21,21,12,2,12,21,21,2121,21,21,21,21,2,21,21,21:::','', 1, 'Prueba');
        //aSysdePortalEmpresarial.fechaCierreSysde();
        /*aSysdePortalEmpresarial.CompraVentaDolares('USD', 32.32, 'Prueba')
        aSysdePortalEmpresarial.fechaCierreSysde();
        aSysdePortalEmpresarial.CompraVentaDolares('USD', 32.32, 'Prueba')
        aSysdePortalEmpresarial.fechaCierreSysde();*/
        
    }

}