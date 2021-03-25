@isTest(SeeAllData=True)
public class testclaseUtil2 {
 static testMethod void clasesAyuda2() {
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
        claseutil.stopTrigger();
        claseUtil.canIRun();
        claseUtil.urlSysde('Test');
        claseUtil.enviarCorreoCasoAD([select id from case limit 1].id, 'CasoAyD');
        
        
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