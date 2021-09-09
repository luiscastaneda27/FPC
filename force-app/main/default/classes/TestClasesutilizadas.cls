@isTest
public class TestClasesutilizadas {
    
    static testMethod void Clasesutilizadas(){ 
        
         classReversiones.classConsultaReversion reversion1= new classReversiones.classConsultaReversion();
        reversion1.cuenta ='';
        reversion1.fechaDesde =date.today();
        reversion1.fechaHasta=date.today();
        reversion1.accion='';
        
        classReversiones.classRespuestaReversion reversion2= new classReversiones.classRespuestaReversion();
        reversion2.fecha=datetime.now();
        reversion2.crecimientoDiarioValorCuota=0;
        reversion2.descripcion='';
        reversion2.rendimientoDiario =12;
        reversion2.indice=1;
        reversion2.monto=12;
        reversion2.prcComisionAporte=12;
        reversion2.prcComisionSaldo=12;
        reversion2.saldoFinal=12;
        reversion2.saldoInicial=12;
        
        classReversiones.classProcesarReversion reversion3= new classReversiones.classProcesarReversion();
        reversion3.cuenta='';
        reversion3.tipoReversion='';
        reversion3.subTipoReversion='';
        reversion3.fechaAporte=date.today();
        reversion3.montoRetiro=1;
        reversion3.montoTSP=12;
        reversion3.montoACH=12;
        reversion3.montoCheque=12;
        reversion3.montoComisionAporte=12;
        reversion3.montoComisionSaldo=12;
        reversion3.rendimiento = 32;
        reversion3.bitacora =null;
        
        reversion3.bitacora =null;
        
        classReversiones.classRendimiento reversion4= new classReversiones.classRendimiento();
        reversion4.cuenta ='';
        reversion4.fechaDesde = datetime.now();
        reversion4.fechaHasta = datetime.now();
        reversion4.tipoSaldo='';
        
        classReversiones.classRespuestaRendimiento reversion5= new classReversiones.classRespuestaRendimiento();
        reversion5.comisionAporte=21;
        reversion5.comisionSaldo=21;
        reversion5.valor=21;
        
        reversiones reversion6 = new reversiones (null, null,null,null,null,null,null,null,null);
        
        classFondosPignorados  ds = new classFondosPignorados();
        ds.accion='';
        ds.codCuenta='';
        ds.montoPignorado=32;
        ds.montoPrestamo=32;
        ds.numeroPrestamo='';
        ds.prestamoAterior='';
        ds.totalFondos=32;
        
         classFondosPignorados.Refinanciamiento  dss = new classFondosPignorados.Refinanciamiento();
        dss.existe='';
        dss.MontoPrestamo='';
        dss.cuenta='';
        dss.NumeroPrestamo='';
        
        claseTipoCaso fd = new claseTipoCaso('Estados_Cuenta');
        fd = new claseTipoCaso('Cambio_Subproducto');
        fd = new claseTipoCaso('Retiros');
        fd = new claseTipoCaso('Actualizacion_informacion');
        fd = new claseTipoCaso('Aumento_Disminucion_Aportes');
        fd = new claseTipoCaso('Reversiones');
        fd = new claseTipoCaso('Constancia');
        fd = new claseTipoCaso('Reposicion_Carnet');
        fd = new claseTipoCaso('Otros');
        
        classRetiros ju = new classRetiros();
        ju.aportePatronal =true;
        ju.BancoCuentaBancaria='';
        ju.bancoCuentaDestino = '';
        ju.bitacora = null;
        ju.cuenta = '';
        ju.cuentaDestino='';
        ju.cuentaOrigen='';
        ju.cuentaPatronal='';
        ju.formaPago = '';
        ju.monedaCuentaDestino = '';
        ju.montoACH=12;
        ju.montoACHPatrono = 12;
        ju.montoBrutoPatronal=12;
        ju.montocargosPatronal = 12;
        ju.montoCheque=12;
        ju.montoChequePatrono=12;
        ju.montoComisionPorRetiro=12;
        ju.montoNetoPatronal =12;
        ju.montoRestanteCliente=12;
        ju.montoRetiro = 12;
        ju.MontoSaldoPatronal = 12;
        ju.montoTSP=12;
        ju.montoTSPPatrono=12;
        ju.saldoPrestamo=12;
        ju.saldos=null;
        ju.tipoCuenta='';
        ju.tipoCuentaBancaria='';
        ju.tipoCuentaDestino='';
        ju.tipoRetiro='';
        ju.transferencia=false;
        
        classProcesarReversion reversion8= new classProcesarReversion();
        reversion8.cuenta='';
        reversion8.accion='';
        reversion8.bitacota=null;
        reversion8.cobroComision=true;
        reversion8.idSalesforce='';
        reversion8.monto=12;
        reversion8.montoPorAporte=12;
        reversion8.montoPorSaldo=12;
        reversion8.montoRendimiento=12;
        reversion8.tipoSaldo='';
        reversion8.rezago = '';
        
        TasaCambio.traertasacambio(null);
        
        getSaldoCuenta po = new getSaldoCuenta();
        po.cuenta='';
        po.montoPignorado='';
        po.saldos=null;
        po.saldoTotal='';
        
        
    }

}