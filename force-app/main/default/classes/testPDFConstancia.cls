@isTest(SeeAllData=True)
private class testPDFConstancia {
    
    static testMethod void myUnitTest() {
        MultiStaticResourceCalloutMock mock = new MultiStaticResourceCalloutMock();
        mock.setStaticResource('http://190.5.68.11:9090/api/constancias','mockAportes');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        controllerConstanciaPdf.metodoutil();
        Account natural = new Account(FirstName = 'Juan', LastName = 'Perez', Identificacion__c = '12345999',
                                      RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Natural'].id);
        insert natural;
        
        Date hoy = date.today();
        Cuentas__c cuentaIndi = new Cuentas__c(Name = 'Cuenta', Codigo__c = '1239999', Cliente__c = natural.id, currencyIsoCode = 'HNL',
                                               Fecha_Apertura__c = hoy);
        insert cuentaIndi;
        
        Case casoConstancia = new Case(AccountId = natural.id, Status = 'Nuevo', Constancia__c = 'A2',
                                       RecordTypeId = [Select Name From RecordType Where DeveloperName = 'Constancia'].id,
                                       Fecha_desde__c = hoy, 
                                       Fecha_hasta__c = hoy + 10);
        
        insert casoConstancia;
        
        Detalle_caso__c detalle = new Detalle_Caso__c(Caso__c = casoConstancia.id,Cuenta__c = cuentaIndi.id, 
                                                      fecha_aporte__c = date.today(), Nuevo_monto_aporte__c = 5000);
        insert detalle;
        
        Case casoAumentoD = new Case(AccountId = natural.id, Status = 'Nuevo', DAU_Identidad__c =  '231312',
                                     RecordTypeId = [Select Name 
                                                     From RecordType Where DeveloperName = 'Aumento_Disminucion_Aportes'].id);
        insert casoAumentoD;
        
        Detalle_caso__c detalle1 = new Detalle_Caso__c(Caso__c = casoAumentoD.id,Cuenta__c = cuentaIndi.id, Tipo_Operacion__c = 'A6',
                                                       DAU_Dia_de_pago__c = '14', N_Cuenta_Bancaria__c = '1212',
                                                       fecha_aporte__c = date.today(), Nuevo_monto_aporte__c = 5000);
        insert detalle1;       
        
        /*Case casoActInfo = new Case(AccountId = natural.id, Status = 'Nuevo',
RecordTypeId = [Select Name 
From RecordType Where DeveloperName = 'Actualizacion_informacion'].id);
insert casoActInfo;

Detalle_caso__c detalle2 = new Detalle_Caso__c(Caso__c = casoActInfo.id,Cuenta__c = cuentaIndi.id);
insert detalle2;*/
        
        test.startTest();
        
        PageReference pageRef = Page.vfConstanciaPDFSite;
        Test.setCurrentPage(pageRef);
        controllerConstanciaPdf control = new controllerConstanciaPdf(new ApexPages.StandardController(casoConstancia));
        
        pageRef = Page.vfFormularioPDFSite;
        Test.setCurrentPage(pageRef);
        control = new controllerConstanciaPdf(new ApexPages.StandardController(casoConstancia));
        
        casoConstancia.Constancia__c = 'P1';
        update casoConstancia;          
        control = new controllerConstanciaPdf(new ApexPages.StandardController(casoConstancia));
        
        casoConstancia.Constancia__c = 'A5';
        update casoConstancia;          
        control = new controllerConstanciaPdf(new ApexPages.StandardController(casoConstancia));
        
        casoConstancia.Constancia__c = 'A1';
        update casoConstancia;          
        control = new controllerConstanciaPdf(new ApexPages.StandardController(casoConstancia));
        
        casoConstancia.Constancia__c = 'Saldo';
        update casoConstancia;          
        control = new controllerConstanciaPdf(new ApexPages.StandardController(casoConstancia));
        control.ponerDecimales(34.43);
        
        /*casoConstancia.Constancia__c = 'A6';
casoConstancia.Monto_compromiso_aporte__c = 100;
update casoConstancia;          
control = new controllerConstanciaPdf(new ApexPages.StandardController(casoConstancia));

casoConstancia.Constancia__c = 'A6';
casoConstancia.aprobado__c = true;
update casoConstancia;          
control = new controllerConstanciaPdf(new ApexPages.StandardController(casoConstancia));*/
        
        control = new controllerConstanciaPdf(new ApexPages.StandardController(casoAumentoD));
        control.getAlternativoHoyLetras();
        control.getFechaHoyMesLetras();
        control.nombreMes(hoy - 30);
        control.nombreMes(hoy - 60);
        control.nombreMes(hoy - 90);
        control.nombreMes(hoy - 120);
        control.nombreMes(hoy + 30);
        control.nombreMes(hoy + 90);
        control.nombreMes(hoy + 120);
        control.nombreMes(hoy + 150);
        
        //control = new controllerConstanciaPdf(new ApexPages.StandardController(casoActInfo));
        claseUtil.enviarCorreoCasoAD(casoConstancia.id,'CasoAyD');
        control = new controllerConstanciaPdf();
        test.stopTest();
    }
    
    static testMethod void myUnitTest2() {
        MultiStaticResourceCalloutMock mock = new MultiStaticResourceCalloutMock();
        mock.setStaticResource('http://190.5.68.11:9090/api/constancias','mockAportes');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        controllerConstanciaPdf.metodoutil();
        Account natural = new Account(FirstName = 'Juan', LastName = 'Perez', Identificacion__c = '12345999',
                                      RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Natural'].id);
        insert natural;
        
        Date hoy = date.today();
        Cuentas__c cuentaIndi = new Cuentas__c(Name = 'Cuenta', Codigo__c = '1239999', Cliente__c = natural.id, currencyIsoCode = 'HNL',
                                               Fecha_Apertura__c = hoy);
        insert cuentaIndi;
        
        Case caso = new Case(AccountId = natural.id, Status = 'Nuevo' ,Identificacion__c = 'Test',
                                       RecordTypeId = [Select Name From RecordType Where DeveloperName = 'Actualizacion_informacion'].id,
                                       Fecha_desde__c = hoy, 
                                       Fecha_hasta__c = hoy + 10);
        
        insert caso;
        
         Case casoConstancias = new Case(AccountId = natural.id, Status = 'Nuevo', DAU_Identidad__c =  '231312',Constancia__c = 'P1',
                                     RecordTypeId = [Select Name 
                                                     From RecordType Where DeveloperName = 'Constancia'].id, Tasa_Cambio__c = 1.1);
        insert casoConstancias;
        
        Detalle_caso__c detalle1 = new Detalle_Caso__c(Caso__c = casoConstancias.id,Cuenta__c = cuentaIndi.id,
                                                       DAU_Dia_de_pago__c = '14', N_Cuenta_Bancaria__c = '1212',Cambio_moneda__c = true,
                                                       fecha_aporte__c = date.today(), Nuevo_monto_aporte__c = 5000);
        insert detalle1;   
        
        test.startTest();
        
        PageReference pageRef = Page.vfConstanciaPDFSite;
        Test.setCurrentPage(pageRef);
        controllerConstanciaPdf control = new controllerConstanciaPdf(new ApexPages.StandardController(caso));
        
        pageRef = Page.vfFormularioPDFSite;
        Test.setCurrentPage(pageRef);
        control = new controllerConstanciaPdf(new ApexPages.StandardController(caso));
        
        pageRef = Page.vfConstanciaPDFSite;
        Test.setCurrentPage(pageRef);
        control = new controllerConstanciaPdf(new ApexPages.StandardController(casoConstancias));
        test.stopTest();
    }
    
    static testMethod void clasesAyuda() {
        test.startTest();
        classCuenta control = new classCuenta();
        control.cliente = '';
        control.cuenta = '';
        control.producto = '';
        control.subProducto = '';
        control.cuentaColectiva = '';
        control.cuentaActiva = true;
        control.fondo = '';
        control.fondoInversion = '';
        control.fechaApertura = date.today();
        control.tipoComision = '';
        control.matrizComision = '';
        control.fechaAporte = date.today();
        control.frecuenciaAporte = '';
        control.formaAporte = '';
        control.seguroVida = true;
        control.codigoBarra = '';
        
        classRespuestaCuentas control1 = new classRespuestaCuentas();
        control1.cuenta = '';
        control1.saldo = '';
        control1.fechaInclusion = '';
        control1.fechaExclusion = '';
        control1.cuentaActiva = true;
        control1.montoPactado = '';
        
        String x = ConvertirNumeros.convertirLetras(1000000000);
        x = ConvertirNumeros.convertirLetras(987654321);
        x = ConvertirNumeros.convertirLetras(876543210);
        x = ConvertirNumeros.convertirLetras(76543210);
        x = ConvertirNumeros.convertirLetras(6543210);
        x = ConvertirNumeros.convertirLetras(543210);
        x = ConvertirNumeros.convertirLetras(43210);
        x = ConvertirNumeros.convertirLetras(3210);
        x = ConvertirNumeros.convertirLetras(210);
        x = ConvertirNumeros.convertirLetras(10);
        x = ConvertirNumeros.convertirLetras(11);
        x = ConvertirNumeros.convertirLetras(21);
        x = ConvertirNumeros.convertirLetras(31);
        x = ConvertirNumeros.convertirLetras(41);
        x = ConvertirNumeros.convertirLetras(51);
        x = ConvertirNumeros.convertirLetras(61);
        x = ConvertirNumeros.convertirLetras(71);
        x = ConvertirNumeros.convertirLetras(81);
        x = ConvertirNumeros.convertirLetras(91);
        x = ConvertirNumeros.convertirLetras(100);
        
        x = ConvertirNumeros.convertirLetras(101);
        x = ConvertirNumeros.convertirLetras(201);
        x = ConvertirNumeros.convertirLetras(301);
        x = ConvertirNumeros.convertirLetras(401);
        x = ConvertirNumeros.convertirLetras(501);
        x = ConvertirNumeros.convertirLetras(601);
        x = ConvertirNumeros.convertirLetras(701);
        x = ConvertirNumeros.convertirLetras(801);
        x = ConvertirNumeros.convertirLetras(901);
        x = ConvertirNumeros.convertirLetras(1000);
        
        RecordType tipoR = claseUtil.getTipoRegistro('Case','Constancia');
        
        Date hoy = claseUtil.convertToDate('01-JAN-17');
        claseUtil.convertToDate('01-FEB-17');
        claseUtil.convertToDate('01-MAR-17');
        claseUtil.convertToDate('01-APR-17');
        claseUtil.convertToDate('01-MAY-17');
        claseUtil.convertToDate('01-JUL-17');
        claseUtil.convertToDate('01-JUN-17');
        claseUtil.convertToDate('01-AUG-17');
        claseUtil.convertToDate('01-SEP-17');
        claseUtil.convertToDate('01-OCT-17');
        claseUtil.convertToDate('01-NOV-17');
        claseUtil.convertToDate('01-DIC-17');
        
        
        DateTime hoymas = claseUtil.convertToDateTime('14/10/2011-11:46');
        
        classSaldos control6 = new classSaldos();
        control6.tipoSaldo = '';
        control6.montoSaldo = '';
        
        getSaldoCuenta control7 = new getSaldoCuenta();
        control7.cuenta = '';
        control7.saldoTotal = '';
        control7.saldos = new list<classSaldos>();
        
        test.stopTest();
        
    }
}