@isTest
public class afiliacionElectronicaControllerTest {
    static testMethod void afiliacionElectronicaController(){
        test.startTest();
        afiliacionElectronicaController aaa = new afiliacionElectronicaController();
        aaa.tipoIdentificacion = '';
		aaa.idCliente = '';
    	aaa.primerNombre = '';
    	aaa.segundoNombre = '';
    	aaa.primerApellido = '';
    	aaa.segundoApellido = '';
    	aaa.correoCliente = '';
    	aaa.telefonoCelular = '';
    	aaa.token = '';
    	aaa.fechaGeneracion = date.today();
    	aaa.FechaHoy = date.today();
    	aaa.fechaCaduca = 0.0;
        aaa.Recaptcha = 'N';
        aaa.RecaptchaAceptar = 'N';
        aaa.validarToken();
        aaa.validar();
        
        controllerApiClienteNatural.consultaListas('0801199411013');// lista = new controllerApiClienteNatural.consultaListas('0801199411013');
        
        afiliacionElectronicaClass cl = new afiliacionElectronicaClass();
        cl.tipoIdentificacion = '1';
        cl.idCliente = '0801-1900-00000';
        cl.primerNombre = 'AAAA';
        cl.segundoNombre = 'BBBB';
        cl.primerApellido = 'DDDD';
    	cl.segundoApellido = 'CCCC';
    	cl.correoCliente = 'algo@gmail.com';
    	cl.telefonoCelular = null;
    	cl.token = '123456';
        cl.tipoValida = '';
        cl.existeCliente = 'S';
        aaa.validarDatos();
        
        
        afiliacionElectronicaController aaaa = new afiliacionElectronicaController();
        aaaa.tipoIdentificacion = '';
		aaaa.idCliente = '0801-1900-00000';
    	aaaa.primerNombre = '';
    	aaaa.segundoNombre = '';
    	aaaa.primerApellido = '';
    	aaaa.segundoApellido = '';
    	aaaa.correoCliente = '';
    	aaaa.telefonoCelular = null;
        aaaa.validar();
    	aaaa.token = '123456';
    	aaaa.fechaGeneracion = date.today();
    	aaaa.FechaHoy = date.today();
    	aaaa.fechaCaduca = 0.0;
        aaaa.validar();
        aaaa.RecaptchaAceptar = 'N';
        aaaa.validarToken();
        aaaa.RecaptchaAceptar = 'S';
        aaaa.validarToken();
        
        afiliacionElectronicaClass cll = new afiliacionElectronicaClass();
        cll.tipoIdentificacion = '1';
        cll.idCliente = '0801-1900-00000';
        cll.primerNombre = 'AAAA';
        cll.segundoNombre = 'BBBB';
        cll.primerApellido = 'DDDD';
    	cll.segundoApellido = 'CCCC';
    	cll.correoCliente = 'algo@gmail.com';
    	cll.telefonoCelular = null;
    	cll.token = '123456';
        cll.tipoValida = '';
        cll.existeCliente = 'S';
        aaaa.validarDatos();
        aaaa.validarToken();          
		aaa.clear();
        aaa.validar();
        aaa.validarDatos();
        aaa.validarToken();
        
        test.stopTest();
    }
}