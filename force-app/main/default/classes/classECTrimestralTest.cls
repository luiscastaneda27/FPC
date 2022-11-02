@istest
public class classECTrimestralTest {
    
    static testMethod void classECTrimestral(){
        classECTrimestral controller = new classECTrimestral();
        controller.fecha = '';
        controller.numeroCliente = '';
        controller.nombreCliente = '';
        controller.emailCliente = '';
        controller.rendimientoLempiras = '';
        controller.rendimientoDolares = '';
        controller.identificacion = '';
        controller.correoElectronico = '';
        
        controller.cuentas = null;
        controller.fondoLempiras = null;
        controller.fondoDolares = null;
        controller.pension = '';
        controller.incrementoCincoMas = '';
        controller.aporteCincoMas = '';
        
        controller.incrementoDiezMas = '';
        controller.aporteDiezMas = '';
        controller.incrementoQuinceMas = '';
        controller.aporteQuinceMas = '';
        controller.mayor = true;
        
        
        classECTrimestral.classECCuenta controllerCuenta = new classECTrimestral.classECCuenta();
        controllerCuenta.moneda = '';
        controllerCuenta.numeroCuenta = '';
        controllerCuenta.fechaIncorporacion = '';
        controllerCuenta.aportesEmpleado = '';
        controllerCuenta.aportesExtraEmpleado = '';
        controllerCuenta.totalAportesEmpleado = '';
        controllerCuenta.aportesEmpleador = '';
        controllerCuenta.aporteExtraEmpleador = '';
        controllerCuenta.totalAportesEmpleador = '';
        controllerCuenta.aporteSeguroVida = '';
        controllerCuenta.intereses = '';
        controllerCuenta.comisiones = '';
        controllerCuenta.retiros = '';
        controllerCuenta.totalMiFondo = '';
        controllerCuenta.miEmpleador = '';
        controllerCuenta.fpcTrabajo = '';
        controllerCuenta.grafico = '';
        controllerCuenta.porcentajeMisAportes = '';
        controllerCuenta.porcentajeEmpleadorAportes = '';
        controllerCuenta.porcentajeFicohsaAportes = '';
        controllerCuenta.moneda = '';
    }
}