@isTest
public class testConciliaRetiros {
    static testMethod void controllerCRetiros()
    {
        test.startTest();
        Retiro_Aprobacion__c w = new Retiro_Aprobacion__c();
        w.Aprobacion_Final__c = '';
        w.AprobacionM__c = '';
        w.banco_destino__c = '';
        w.cheque__c = null;
        w.compara_monto__c = '';
        w.Cuenta__c = '';
        w.cuenta_bancaria__c = '';
		w.cuenta_Destino__c = '';
        w.CurrencyIsoCode = 'HNL';
        w.Descripcion__c = '';
        w.Fecha_SalesForce__c = date.today();
        w.Fecha_Sysde__c = date.today();
        w.Forma_Pago__c = '';
        w.moneda__c = '';
        w.Monto_Salesforce__c = '1';
        w.Monto_Sysde__c = null;
        w.monto_total__c = '1';
        w.Numero_Referencia__c = '1234567';
        w.tasa_seguridad_poblacional__c = '1';
        w.tipo_cuenta__c = '';
        w.transferencia_ACH__c = '1';
        w.AprobacionM__c = 'S';
        w.Nombre_Cliente__c = 'Paola';
        w.Numero_Caso__c = '1';
        w.Tipo_Pago__c = 'dd';
        w.Monto_HNL__c = '1';
        w.Monto_USD__c = '2';
        insert w;
        
        Retiro_Aprobacion__c p = new Retiro_Aprobacion__c();
        p.Aprobacion_Final__c = '';
        p.banco_destino__c = '';
        p.cheque__c = null;
        p.compara_monto__c = '';
        p.Cuenta__c = '';
        p.cuenta_bancaria__c = '';
		p.cuenta_Destino__c = '';
        p.CurrencyIsoCode = 'HNL';
        p.Descripcion__c = '';
        p.Fecha_SalesForce__c = date.today();
        p.Fecha_Sysde__c = date.today();
        p.Forma_Pago__c = '';
        p.moneda__c = '';
        p.Monto_Salesforce__c = '1';
        p.Monto_Sysde__c = null;
        p.monto_total__c = '1';
        p.Numero_Referencia__c = '123456';
        p.tasa_seguridad_poblacional__c = '1';
        p.tipo_cuenta__c = '';
        p.transferencia_ACH__c = '1';
        p.AprobacionM__c = 'S';
        p.Nombre_Cliente__c = 'Paola';
        p.Numero_Caso__c = '1';
        p.Tipo_Pago__c ='prue';
        p.Monto_HNL__c = '1';
        p.Monto_USD__c = '2';
        insert p;    
        
        /*Retiro_Aprobacion__c wa = new Retiro_Aprobacion__c();
        wa.Aprobacion_Final__c = '';
        wa.AprobacionM__c = '';
        wa.banco_destino__c = '';
        wa.cheque__c = null;
        wa.compara_monto__c = '';
        wa.Cuenta__c = '';
        wa.cuenta_bancaria__c = '';
		wa.cuenta_Destino__c = '';
        wa.CurrencyIsoCode = 'HNL';
        wa.Descripcion__c = '';
        wa.Fecha_SalesForce__c = date.today();
        wa.Fecha_Sysde__c = date.today();
        wa.Forma_Pago__c = '';
        wa.moneda__c = '';
        wa.Monto_Salesforce__c = '1';
        wa.Monto_Sysde__c = null;
        wa.monto_total__c = '1';
        wa.Numero_Referencia__c = '1234567';
        wa.tasa_seguridad_poblacional__c = '1';
        wa.tipo_cuenta__c = '';
        wa.transferencia_ACH__c = '1';
        wa.AprobacionM__c = 'S';
        wa.Nombre_Cliente__c = 'Paola';
        wa.Numero_Caso__c = '1';
        wa.Tipo_Pago__c = 'dd';
        wa.Monto_HNL__c = '1';
        wa.Monto_USD__c = '2';
        insert wa;*/
                
        controllerCRetiros ra = new controllerCRetiros();
        
        ra.fecha = '';
        ra.fecha2 = date.today();
        ra.fecha3 = date.today();
        ra.fecha_retiro = date.today(); 
        ra.fechaSysdeRetiros = date.today();             
        
        //list<cuadreRetirosP> lu = new list<cuadreRetirosP>();
        //list<cuadreRetirosI> luu = new list<cuadreRetirosI>();        
        
        ra.conciliaRetiros();
        ra.mostrarTablaRetirosP = true;
        ra.mostrarTablaRetiros = true;
        ra.mostrarTablaRetirosC = true;
        ra.mostrarTablaRetirosI = true;
        ra.envioAprobacionI();
        ra.enviarListaTotalI();
        
        list<Retiro_Aprobacion__c> lii = new list<Retiro_Aprobacion__c>();
        ApexPages.currentPage().getParameters().put('id',w.id);
        ra.Eliminar();
        ra.Id=null;
        w.id=null;
        insert w;
        
        list<Retiro_Aprobacion__c> liii = new list<Retiro_Aprobacion__c>();
        ApexPages.currentPage().getParameters().put('id',p.id);
        ra.Eliminar();
        ra.Id=null;
        p.id=null;
        insert p;
        
        /*list<Retiro_Aprobacion__c> liiii = new list<Retiro_Aprobacion__c>();
        ApexPages.currentPage().getParameters().put('id',wa.id);
        ra.Eliminar();
        ra.Id=null;
        wa.id=null;
        insert wa;*/
                
        ra.envioAprobacion();
        ra.envioAprobacionP();
        ra.envioAprobacionI();
        ra.enviarListaTotalI();
                              
        list<cuadreRetiros> laa = new list<cuadreRetiros>();
        list<cuadreRetirosC> lee = new list<cuadreRetirosC>();
        list<cuadreRetirosP> llll = new list<cuadreRetirosP>();
        list<cuadreRetirosI> lllle = new list<cuadreRetirosI>();
                
        ra.conciliaRetiros();
        ra.enviarListaTotal();
        ra.enviarListaTotalP();
        
       //ra.ListPagosP[0].referencia= ra.ListEnvioRepetidosP[0].referencia;
       
        //Colavoradores.idEmpleado=Colavoradores.listClientes2[0].id;
        
        list<Retiro_Aprobacion__c> lo = new list<Retiro_Aprobacion__c>();

        //classCRetiros//
        classCRetiros h = new classCRetiros();
        //classRetiros
        classRetiros i = new classRetiros();
        //controllerApiCRetiros
        controllerApiCRetiros k = new controllerApiCRetiros();
        cuadreRetirosC2 hola = new cuadreRetirosC2();
        hola.fecha_retiro = dateTime.now();
        hola.fechaSysdeRetiros = dateTime.now();
        
        string wendy = controllerApiCRetiros.pagaRetiros(hola); 
    
        
        controllerApiCRetiros.classResPagoRetiros o = new controllerApiCRetiros.classResPagoRetiros();
        o.codReferencia = '';
        o.mensaje = '';
        //classRetiros
        classRetiros s = new classRetiros();
        //s.nombreCliente = '';
        //s.numeroCaso = 1;
        s.cuenta = '';
        s.cuentaOrigen = '';
        s.cuentaDestino = '';
        s.transferencia = true;
        s.tipoCuentaDestino = '';
        s.bancoCuentaDestino = '';
        s.monedaCuentaDestino = '';
        s.montoRetiro = 1;
        s.tipoRetiro = '';
        s.montoComisionPorRetiro = 1;
        s.montoTSP = 1;
        s.montoACH = 1;
        s.montoCheque = 1;
        s.formaPago = '';
        s.aportePatronal = true;
        //cuadreRetiros
        cuadreRetiros g = new cuadreRetiros('', '', '', 1.0, 1.0, 1.0, dateTime.now(), dateTime.now(), 1.0, '', 1.0, '', 1);
        //cuadreRetirosC
        //cuadreRetirosC x = new cuadreRetirosC('', '', '', '', 1.0, '', 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, dateTime.now(), dateTime.now(), 1.0,  1.0, '', '', '', '', '', 1);
        cuadreRetirosC x = new cuadreRetirosC('', '', '', '',1.0, '', 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                          1.0, 1.0, dateTime.now(), dateTime.now(), 1.0, 1.0,
                          '', '', '', '', '', 1);
        //cuadreRetirosP
        //cuadreRetirosP y = new cuadreRetirosP('', 1.0, '', '', '', 1.0, 1.0, 1.0, 1.0, 1.0, dateTime.now(), '', '', '', '', '', 1);
        cuadreRetirosP y = new cuadreRetirosP('', 1.0, '', '','',1.0, 
                           1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                           dateTime.now(), '', '', 
                           '', '', '', 1);
        
        cuadreRetirosI z = new cuadreRetirosI('', '', '', '',1.0, '', 
                          1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 
                          dateTime.now(), dateTime.now(), 1.0, 1.0,'', '', 
                          '', '', '', 1);
        //cuadreRetirosC2
        cuadreRetirosC2 f = new cuadreRetirosC2();
        f.fecha_retiro = null;
        f.fechaSysdeRetiros = date.today();
        //pagoRetirosC
        pagoRetirosC d = new pagoRetirosC();
        d.referencia = '';
        d.codCuenta = '';
        d.monMovimto = 0;
        d.monRetirar = 0;
        d.fecMovimto = null;
        d.fecSYSDE = null;
        d.comparacion = 0;
        d.fPago = '';
        d.comparaFecha = 0;
        d.descripcion = '';
        d.cuentaBancaria = '';
        d.cuentaDestino ='';
        d.monTotal = 0;
        d.bancoDestino = '';
        d.tCuenta = '';
        d.moneda = '';
        d.tsp = 0;
        d.ach = 0;
        d.ck = 0;
        //ControllerRetirosAproba
        ControllerRetirosAproba ul = new ControllerRetirosAproba();
        ul.AprobarRetiro();
        ControllerRetirosAproba u = new ControllerRetirosAproba();
        /*Retiro_Aprobacion__c pe = new Retiro_Aprobacion__c();
        pe.Aprobacion_Final__c = '';
        pe.AprobacionM__c = '';
        pe.banco_destino__c = '';
        pe.cheque__c = null;
        pe.compara_monto__c = '';
        pe.Cuenta__c = '';
        pe.cuenta_bancaria__c = '';
		pe.cuenta_Destino__c = '';
        pe.CurrencyIsoCode = 'HNL';
        pe.Descripcion__c = '';
        pe.Fecha_SalesForce__c = date.today();
        pe.Fecha_Sysde__c = date.today();
        pe.Forma_Pago__c = '';
        pe.moneda__c = '';
        pe.Monto_Salesforce__c = '1';
        pe.Monto_Sysde__c = null;
        pe.monto_total__c = '1';
        pe.Numero_Referencia__c = '123456';
        pe.tasa_seguridad_poblacional__c = '1';
        pe.tipo_cuenta__c = '';
        pe.transferencia_ACH__c = '1';
        //pe.AprobacionM__c = 'S';
        //pe.mo
        pe.Tipo_Pago__c = 'kkk';
        insert pe;*/
           
        list<Retiro_Aprobacion__c> ll = new list<Retiro_Aprobacion__c>();
        ApexPages.currentPage().getParameters().put('id',w.id);
        u.Eliminar();
        
        test.stopTest();
        
    }

}