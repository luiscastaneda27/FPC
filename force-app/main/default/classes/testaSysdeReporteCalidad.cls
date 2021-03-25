@istest
public class testaSysdeReporteCalidad {
    
    static testMethod void aSysdeReporteCalidad(){
        aSysdeReporteCalidad.infoCliente('0801199411013');
        aSysdeReporteCalidad.infoClientes('0801199411013');
        aSysdeReporteCalidad.classEstadoCapital claseEnvio = new aSysdeReporteCalidad.classEstadoCapital();
        claseEnvio.cuenta  = '';
        claseEnvio.cambioEstado =true;
        claseEnvio.capitalSemilla = false;
        claseEnvio.nombre = '';
        claseEnvio.moneda = '';
        claseEnvio.monto = '';
        claseEnvio.formaPago = '';
        claseEnvio.codigoReferencia= ''; 
        claseEnvio.periodoAporte = '';
        claseEnvio.ctaDestino = '';
        claseEnvio.ctaOrigen = '';
        claseEnvio.observacion = '';
        aSysdeReporteCalidad.CambioEstado(claseEnvio);
        
        aSysdeReporteCalidad.ConsultaCliente a = new aSysdeReporteCalidad.ConsultaCliente();
        
        a.tipoIdentificacion = '';
        a.identificacion = '';
        a.RTN = '';
        a.clienteUnicoBanco = '';
        a.numContrato = '';
        a.numCuenta = '';
        a.primerNombre = '';
        a.segundoNombre = '';
        a.primerApellido = '';
        a.segundoApellido = '';
        a.codEmpresa  = '';
        a.fatca = '';
        a.waiver = '';
        a.pep  = '';
        a.procedencia = '';
        a.addendum = '';
        a.codSubProducto = '';
        a.tipoFondo = '';
        a.asesor  = '';
         a.EMP_AGN  = '';
         a.COD_AGN  = '';
         a.AGN  = '';
         a.FECHA_INGRESO  = '';
         a.tipoCliente  = '';
         a.TIPO_CLIENTE  = '';
        
        
        aSysdeReporteCalidad.ClassReporteCalidad b = new aSysdeReporteCalidad.ClassReporteCalidad();
        b.clienteUnicoBanco = '';
        b.numContrato = '';
        b.numCuenta = '';
        
        aSysdeReporteCalidad.ConsultaClienteCuenta c = new aSysdeReporteCalidad.ConsultaClienteCuenta();
        c.tipoIdentificacion= '';
        c.identificacion= '';
        c.numCuenta= '';
        c.primerNombre= '';
        c.segundoNombre= '';
        c.primerApellido= '';
        c.segundoApellido= '';
        c.codSubProducto= '';
        c.codEmpresa= '';
        c.codSubProducto= '';
        c.tipoFondo= '';
        c.asesor= '';
        
        
        aSysdeReporteCalidad.infoClienteCuenta('');
        
    }
    
}