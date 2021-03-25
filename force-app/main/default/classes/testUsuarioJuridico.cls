@isTest
public class testUsuarioJuridico {
	static testMethod void ControllerUsuarioJuridico(){
    test.startTest();
 	ControllerUsuarioJuridico juridico = new ControllerUsuarioJuridico();
        juridico.calificacionRiesgo = '1';
        juridico.calle = '';
        juridico.claseSociedad = '19';
        juridico.codProducto = '01';
        juridico.codSubproducto = 'FPC01';
        juridico.codPromotor = 'HN19967';
        juridico.colonia = '';
        juridico.departamento = '';
        juridico.diligenciaAplicada = '1';
        juridico.formaPago = 'AH';
        juridico.tipoUsuarioJuridico = '1';
        juridico.tipoId = '5';
        juridico.telefono ='22373447';
        juridico.segundoNombreR = 'paola';
        juridico.segundoApellidoR = 'aguilar';
        juridico.sector = '';
        //juridico.rubro = '';
        juridico.procedenciaFondo = 'ahorros';
        juridico.primerNombreR = 'wendy';
        juridico.primerApellidoR = 'alvarado';
        juridico.periodicidad = 'M';
        juridico.PEP = true;
        juridico.pais = '074';
        juridico.numeroId = '08011994110135';
        juridico.nombreRazon = 'paolas preubas';
        juridico.municipio = '';
        juridico.lugarConstitucion = '';
        juridico.lucrativa = 's';
        juridico.IdRepresentanteLegal = '0801199411013';
        juridico.idFormulario = 'fpce2344';
        juridico.guardar();
        juridico.validar();
        juridico.cancelar();
        juridico.buscarInfoCuentaC();
        juridico.actualizar();
        juridico.actPop = true;
        juridico.bloqPep();
        juridico.cleanRiesgo();
        juridico.desCheckb = true;
        juridico.validarRepLegal();
        juridico.desBtn();
        juridico.disbot = true;
        juridico.dispep = true;
        juridico.unblock();
        juridico.mostrarModal();
        juridico.hidePop();
        juridico.cerModal();
        juridico.mostrarBoton = true;
        juridico.mostrarSiguiente = true;
        juridico.siguiente() ;
        juridico.anterior();
         classUsuarioJuridico h = new classUsuarioJuridico();
        
        
        controllerApiUsuarioJuridico apij = new controllerApiUsuarioJuridico();
    
     
     test.stopTest();
 }
}