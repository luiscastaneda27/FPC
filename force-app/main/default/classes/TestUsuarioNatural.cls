@isTest
public class TestUsuarioNatural 
{
 static testMethod void ControllerUsuarioNatural(){
    test.startTest();
 	ControllerUsuarioNatural natural = new ControllerUsuarioNatural();
    natural.tipoUsuarioNatural = 'N';
    natural.PEP = false;
    natural.AML = false;
    natural.FATCA = false;
    natural.tipoId = '1';
    natural.numeroId = '0801-1993-15869';
    natural.primerNombre = 'MARIA';
    natural.segundoNombre = 'JOSEFA';
    natural.primerApellido = 'MARTINEZ';
    natural.segundoApellido = 'MEJIA';
    natural.fechaNacimiento = null;
    natural.nacionalidad = 'HONDUREÑA';
    natural.telefono = '99456986';
    natural.pais = '074';
    natural.colonia = '000';
    natural.departamento = '000';
    natural.municipio = '000';
    natural.calleDetalle = 'PAYAQUI';
    natural.procedenciaFondos = 'null';
    natural.nivelRiesgo = '2';
    natural.debidaDiligencviaAplicada = '1';
    natural.numeroIdentificacion = '0801-1994-11013';
    natural.numeroCuenta = '51600';
    natural.nombreCompleto = 'null';
     
     
     natural.bloqPep();
     natural.guardar();
     natural.buscar();
     natural.validar();
     natural.limpiar();
     natural.cancelar();
     //natural.mostrarBoton = true;
     //natural.mostrarSiguiente = true;
     //natural.mostrarAnterior = true;
     //natural.siguiente();
     //natural.anterior();
     natural.unblock();
     natural.desUn();
     natural.contrUn();
     natural.mostPop();
     natural.desBtn();
     natural.hidePop();
    // natural.opcionColonia = '';
     
     classUsuarioNatural j =new classUsuarioNatural();
     
     controllerApiUsuarioNatural api = new controllerApiUsuarioNatural();
     
     ControllerLoginAfiliados login = new ControllerLoginAfiliados();
     Usuarios_de_Pantallas__c user = new Usuarios_de_Pantallas__c();
     user.Activo__c = true;
     user.Apellido__c = 'castaneda';
     user.Contrase_a__c = '123';
     user.Email__c = 'luis.castaneda@intellectsystem.net';
     user.Usuario__c = 'kike';
     user.Zona__c = 'Tegucigalpa';
     insert user;
     
     login.Cambiousuario = 'kike'; 
     login.cambiarclave();
     login.usuario = 'walvarado';
     login.Contrasena = '';     
     login.cerrar();
     login.crearUsuarioNat();
     login.olvide();
     login.salir();
     login.sesionIniciada();
     login.UsuarioJuridico();
     login.EnvioSaldo();
     login.ListaVF();
     login.ClienteNatural();
     login.bitaco(); 
     login.Mostra();
     login.llenarPantallasDesdeSysde();
     login.llenarCuentasDesdeSysde();
     login.ACI();
     login.ACC();
     login.ACYC();
     login.AME();
     login.EKC();
     login.RSC();
     login.RCI();
     login.RCC();
     login.RCNC();
     login.RCP();
     login.RCBFH();
     login.RCPM();
     login.RCFIC();
     login.EKS();
     login.RSS();
     login.AFC();
     login.ABFK();
     login.APM();
     login.OxA();
     login.OxE();
     
     controllerLink home = new controllerLink();
     home.UsuarioJuridico();
     home.crearUsuarioNat();     
     
     classListas lista = new classListas();
     lista.numeroId = '0801-1972-05033';
     
     test.stopTest();
 }
}