@isTest(SeeAllData=true)
public with sharing class testEDC {
    static testMethod void runEDC(){
        Test.setMock(HttpCalloutMock.class, new testMocks());
        
        Account natural = new Account(FirstName = 'Juan', LastName = 'Perez', Identificacion__c = '12345',
                                      RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Natural'].id);
        insert natural;
        
        RecordType tiposR = [Select Name From RecordType Where sObjectType = 'Case' AND DeveloperName = 'Estados_Cuenta'];
        
        Case casoEDC = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR.id,
                                estado_de_cuenta__C='[{"fecha":"22/05/2019","numeroCliente":"159438","nombreCliente":"TIRZA MARIBEL SOLORZANO NUÑEZ","emailCliente":"paola.cruz@ficohsa.com","rendimientoLempiras":"9.13%","rendimientoDolares":"5.37%","identificacion":"0709-1993-00155","correoElectronico":"paola.cruz@ficohsa.com","cuentas":[{"moneda":"LEMPIRAS","numeroCuenta":"33320","fechaIncorporacion":"05/06/2015","aportesEmpleado":"26,547.28","aportesExtraEmpleado":"22.00","aportesEmpleador":"26,547.28","aporteExtraEmpleador":"0.00","aporteSeguroVida":"0.00","intereses":"10,602.19","comisiones":"-4,874.21","retiros":"-39,422.51","totalMiFondo":"19,422.03","totalPersonal":"19,422.03","grafico":"<div style=\"margin: auto; width: 400px; height: 400px; position: relative; border-radius: 400px;\"><!-- Porción 1 --><div style=\"position: absolute; top: 0px; left: 0px; width: 400px; height: 400px; border-radius: 400px; clip: rect(0px 400px 400px 200px); transform: rotate(0deg);\"><div style=\"background-color: rgb(18, 159, 214); position: absolute; top: 0px; left: 0px; width: 400px; height: 400px; border-radius: 400px; clip: rect(0px 200px 400px 0px); transform: rotate(150.12deg);\"></div></div><!-- Porción 2 --><div style=\"position: absolute; top: 0px; left: 0px; width: 400px; height: 400px; border-radius: 400px; clip: rect(0px 400px 400px 200px); transform: rotate(150.12deg);\"><div style=\"background-color: rgb(22, 73, 169); position: absolute; top: 0px; left: 0px; width: 400px; height: 400px; border-radius: 400px; clip: rect(0px 200px 400px 0px); transform: rotate(149.98deg);\"></div></div><!-- Porción 3 --><div style=\"position: absolute; top: 0px; left: 0px; width: 400px; height: 400px; border-radius: 400px; clip: rect(0px 400px 400px 200px); transform: rotate(300.1deg);\"><div style=\"background-color: rgb(255, 128, 0); position: absolute; top: 0px; left: 0px; width: 400px; height: 400px; border-radius: 400px; clip: rect(0px 200px 400px 0px); transform: rotate(59.9deg);\"></div></div></div>","porcentajeMisAportes":"41.7% ","porcentajeEmpleadorAportes":"41.7% ","porcentajeFicohsaAportes":"16.6% "},{"moneda":"LEMPIRAS","numeroCuenta":"51563","fechaIncorporacion":"03/01/2017","aportesEmpleado":"12,550.00","aportesExtraEmpleado":"2,000.00","aportesEmpleador":"0.00","aporteExtraEmpleador":"0.00","aporteSeguroVida":"0.00","intereses":"799.69","comisiones":"-1,992.00","retiros":"-10,250.00","totalMiFondo":"3,107.69","totalPersonal":"3,107.69","grafico":"<div style=\"margin: auto; width: 400px; height: 400px; position: relative; border-radius: 400px;\"><!-- Porción 1 --><div style=\"position: absolute; top: 0px; left: 0px; width: 400px; height: 400px; border-radius: 400px; clip: rect(0px 400px 400px 200px); transform: rotate(0deg);\"><div style=\"background-color: rgb(18, 159, 214); position: absolute; top: 0px; left: 0px; width: 400px; height: 400px; border-radius: 400px; clip: rect(0px 200px 400px 0px); transform: rotate(180deg);\"></div></div><!-- Porción 1 --><div style=\"position: absolute; top: 0px; left: 0px; width: 400px; height: 400px; border-radius: 400px; clip: rect(0px 400px 400px 200px); transform: rotate(-180deg);\"><div style=\"background-color: rgb(18, 159, 214); position: absolute; top: 0px; left: 0px; width: 400px; height: 400px; border-radius: 400px; clip: rect(0px 200px 400px 0px); transform: rotate(161deg);\"></div></div><!-- Porción 3 --><div style=\"position: absolute; top: 0px; left: 0px; width: 400px; height: 400px; border-radius: 400px; clip: rect(0px 400px 400px 200px); transform: rotate(-18.76deg);\"><div style=\"background-color: rgb(255, 128, 0); position: absolute; top: 0px; left: 0px; width: 400px; height: 400px; border-radius: 400px; clip: rect(0px 200px 400px 0px); transform: rotate(18.76deg);\"></div></div></div>","porcentajeMisAportes":"94.8% ","porcentajeEmpleadorAportes":"0% ","porcentajeFicohsaAportes":"5.2% "}],"pension":"L 7,202.93","incrementoCincoMas":"L 12,202.93","aporteCincoMas":"L 106.40","incrementoDiezMas":"L 17,202.93","aporteDiezMas":"L 212.50","incrementoQuinceMas":"L 22,202.93","aporteQuinceMas":"L 318.50","mayor":false}]',
                                Fecha_desde__c = date.today() - 10, Fecha_hasta__c = date.today());
        insert casoEDC;
        
        test.startTest();
        extensionRedirigirEDC control4 = new extensionRedirigirEDC(new ApexPages.StandardController(casoEDC));
        control4.redirigir();
        ApexPages.currentPage().getParameters().put('id',casoEDC.id);
        control4 = new extensionRedirigirEDC(new ApexPages.StandardController(casoEDC));
        control4.redirigir();
        
        list<classClientesEC> claseEnvio = new list<classClientesEC>();
        classClientesEC nueva = new classClientesEC();
        nueva.idCliente = '12345';
        nueva.desde = system.now() - 100;
        nueva.hasta = system.now();
        claseEnvio.add(nueva);
        
        list<classECPortada> controlEDC1 = EstadosDeCuenta.estadoCuentaCorreo(claseEnvio);
        list<classECMensual> controlEDC2 = EstadosDeCuenta.estadoCuentaMensual(claseEnvio);
        list<classECTrimestral> controlEDC3 = EstadosDeCuenta.estadoCuentaTrimestral(claseEnvio);
        list<classECHistorico> controlEDC4 = EstadosDeCuenta.estadoCuentaHistorico(claseEnvio);
        list<classECMensual> controlEDC5 = EstadosDeCuenta.estadoCuentaMensual(claseEnvio);
        controllerEDChistorico control1 = new controllerEDChistorico();
        controllerEDCmensual control2 = new controllerEDCmensual();
        
        ApexPages.currentPage().getParameters().put('idCaso', casoEDC.id);
        controllerEstadoCuentaTrimestral control3 = new controllerEstadoCuentaTrimestral();
        
        
        String CRON_EXP = '20 30 8 10 2 ?';
        String jobId = System.schedule('testEDCmensual', CRON_EXP, new CorreoAutomaticoEDCmensual());
        //jobId = System.schedule('testEDCtrimestral', CRON_EXP, new CorreoAutomaticoEDCtrimestral());
        jobId = System.schedule('testEDCtrimestral', CRON_EXP, new CorreoAutomaticoEDCHastaDic());
        
        casoEDC.Status = 'Cerrado';
        casoEDC.Tipo_Estado_Cuenta__c = 'A1';
        update casoEDC;
        control4.redirigir();
        EstadosDeCuenta aa = new EstadosDeCuenta();
        EstadosDeCuenta.InsertarCorreos();
        //EstadosDeCuenta.ObtenerCorreos();
        //EstadosDeCuenta.CambiarEstadoCorreos();
        //EstadosDeCuenta.CambiarEstadoCorreos('A1');
        test.stopTest();
    }
    
    static testMethod void clasesSinc(){
        test.startTest();
        classECPortada control2 = new classECPortada();
        control2.fondosObligatorios = true;
        control2.coberturaLaboral = '';
        control2.totalPension = '';
        control2.fondosLempiras = '';
        control2.fondosDolares = '';
        control2.fondosDolares = '';
        control2.nombreCliente = '';
        control2.emailCliente = '';
        control2.fechaCierre = '';
        control2.identidad = '12345';
        
        classECMensual control3 = new classECMensual();           
        control3.fpcTrabajo = '';
        control3.misAportes = '';
        control3.miEmpleador = '';
        control3.fechaAcumulado = '';
        control3.saldoAcumulado = '';
        control3.urlPichingo = '';
        control3.nombreCliente = '';
        control3.emailCliente = '';
        control3.sexo = '';
        control3.grafico = '';
        
        classECTrimestral control4 = new classECTrimestral();           
        control4.fecha = '';
        control4.numeroCliente = '';
        control4.nombreCliente = '';
        control4.rendimientoLempiras = '';
        control4.rendimientoDolares = '';
        control4.identificacion = '';
        control4.correoElectronico= '';
        control4.pension= '';
        control4.incrementoCincoMas= '';
        control4.aporteCincoMas= '';
        control4.incrementoDiezMas= '';
        control4.aporteDiezMas= '';
        control4.incrementoQuinceMas= '';
        control4.aporteQuinceMas = '';
        
        classECTrimestral.classECCuenta control5 = new classECTrimestral.classECCuenta();
        control5.moneda= '';
        control5.numeroCuenta= '';
        control5.fechaIncorporacion= '';
        control5.aportesEmpleado= '';
        control5.aportesExtraEmpleado= '';
        control5.aportesEmpleador= '';
        control5.aporteExtraEmpleador= '';
        control5.aporteSeguroVida= '';
        control5.intereses= '';
        control5.comisiones= '';
        control5.totalMiFondo= '';
        control5.miEmpleador= '';
        control5.fpcTrabajo= '';
        
        classECHistorico control41 = new classECHistorico();           
        control41.fecha = '';
        control41.nombreCliente = '';
        control41.numeroCliente = '';
        control41.SaltoPagina = '';
        
        classECHistorico.classMovimientos control42 = new classECHistorico.classMovimientos();    
        control42.moneda = '';
        control42.cuenta = '';
        control42.totalPersonal = '';
        control42.totalPatronal= '';
        control42.granTotal= '';
        
        classECHistorico.classTransaccion control43 = new classECHistorico.classTransaccion();
        control43.fecha= '';
        control43.fechaSF= '';
        control43.descripcionTransaccion= '';
        control43.aportePersonal= '';
        control43.aportePatronal= '';
        control43.aporteTotal = '';
        
        list<classECHistorico.classTransaccion> control45 = new list<classECHistorico.classTransaccion> ();
        control45.add(control43);
        control42.transacciones = control45;
        list<classECHistorico.classMovimientos> control46 = new list<classECHistorico.classMovimientos>(); 
        control41.movimientos = control46;
        
        
        test.stopTest();
    }
}