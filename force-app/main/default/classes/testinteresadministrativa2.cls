@isTest
public class testinteresadministrativa2 {
     static testMethod void ControllerAdministracionIntereses()
     {
         ControllerAdministracionIntereses g = new ControllerAdministracionIntereses();
         g.Tipo_Pago = '';
         g.tocar_capital = ''; 
    	 g.envioach = '';
         g.enviocheque = '';
         g.enviotsp = '';
         g.Monto = 0;
         g.ach = ''; 
    	 g.ck = '';
         g.Datos=null;
         g.hy = '';
         g.Respuesta = '';
         g.vc_CAPITALSI = '';
         g.vc_CobrarTSPsi = '';
         g.vc_CobrarTSPno = '';
         g.vc_CobrarACHsi = '';
         g.vc_CobrarACHno = '';
         g.vc_Cobrarchequesi = '';
         g.vc_Cobrarchequeno = '';
         g.ActivaAlertas = false;
    	 g.DenegarVentana = false;
         g.Motivo = '';
    	 g.Num_CodReferenciaDenegado = '';
    	 g.ID_Referencia = '';
    	 g.Fondo = 0;
    	 g.Ingresar_Fondo = 0;
         g.FechaActual = null;
    	 g.fecha ='';
    	 g.ListRegUsuario = null;
         g.MostrarVentanaDenegacion();
         g.DesactivaModificar();
         g.eleccionachno();
         g.eleccionachsi();
         g.EleccionCalculado();
         g.eleccionchequeno();
         g.eleccionchequenovacio();
         g.eleccionchequesi();
         g.eleccionchequesivacio();
         g.EleccionFijo();
         g.eleccionno();
         g.eleccionnovacio();
         g.eleccionsi();
         g.eleccionsivacio();
         g.elecciontspno();
         g.eleccionsivacio();
         g.EleccionFijo();
         g.elecciontspno();
         g.elecciontspsi();
         g.elecciontspvacio();
         g.eleccionvacioach();
         g.eleccionvacioachno();
         g.eleccionvaciono();
         g.FIJOVacio();
         g.CALCULADOVacio();
         g.llenaTipoId();
         classPagoInteresesFPC manda = new classPagoInteresesFPC();
         g.BitacoraRegistro(manda);
         g.BitacoraModificar(manda);
         g.mostrarTabla = false;
         g.mostPopTabla();
         g.MostrarT();
         g.ListMontosEspecificos = null;
         g.InteresesEspecificos = null;
   		 g.ListBeneficiarios = null;
    	 g.beneficiarioUnico = null;

         ControllerAdministracionIntereses gaa = new ControllerAdministracionIntereses();
		 gaa.FechInicioPago = date.valueof(Datetime.now()).addDays(1);
         gaa.Guardar(); 
         
         ControllerAdministracionIntereses gur = new ControllerAdministracionIntereses();
		 gur.Forma_Pago = 'AR';
         gur.MostrarCamposFormPago();
         
         ControllerAdministracionIntereses guru = new ControllerAdministracionIntereses();
		 guru.Forma_Pago = 'AH';
         guru.MostrarCamposFormPago();
         
         ControllerAdministracionIntereses guri = new ControllerAdministracionIntereses();
		 guri.Forma_Pago = 'ACH';
         guri.MostrarCamposFormPago();
         
         ControllerAdministracionIntereses gure = new ControllerAdministracionIntereses();
		 gure.Forma_Pago = 'ACR';
         gure.formapago();
         
         ControllerAdministracionIntereses gurer = new ControllerAdministracionIntereses();
         gurer.Forma_Pago = 'ACH';
         gurer.Nombre_Banco = '28';
         gurer.formapago();
         
         ControllerAdministracionIntereses busca1 = new ControllerAdministracionIntereses();
         busca1.BuscarInfor();
         
                  
         ControllerAdministracionIntereses modifica1 = new ControllerAdministracionIntereses();
         modifica1.Modificar();
         
         ControllerAdministracionIntereses modifica2 = new ControllerAdministracionIntereses();
         modifica2.DiadePagos = ' --Ninguno-- ';
         modifica2.Modificar();
         
         ControllerAdministracionIntereses modifica3 = new ControllerAdministracionIntereses();
         modifica3.Forma_Pago = ' --Ninguno-- ';
         modifica3.Modificar();
         
         ControllerAdministracionIntereses modifica4 = new ControllerAdministracionIntereses();
         modifica4.Forma_Pago = 'ACH';
         modifica4.Nombre_Banco = ' --Ninguno-- ';
         modifica4.Modificar();
         
         ControllerAdministracionIntereses modifica5 = new ControllerAdministracionIntereses();
         modifica5.Forma_Pago = 'AH';
         modifica5.Cuenta_Banco = '';
         modifica5.Modificar();
         
         ControllerAdministracionIntereses modifica6 = new ControllerAdministracionIntereses();
         modifica6.Forma_Pago = 'ACH';
         modifica6.Cuenta_Banco = '';
         modifica6.Modificar();
         
         classPagoInteresesFPC pagoFPC = new classPagoInteresesFPC();
         pagoFPC.Cuenta = '36253';
         pagoFPC.pagotsp = 267;
         pagoFPC.fechaHasta = Datetime.now();
            pagoFPC.idbitacora = 'hdjs';
            pagoFPC.actividades = 'Ninguna';
            pagoFPC.eventos = 'Pagina';
            pagoFPC.Fechapago = date.valueOf(Datetime.now());
            pagoFPC.accion = 'Insertar';
            pagoFPC.valor = 'Mucho';
            pagoFPC.codidocu = 'varios';
         
         classAdmInteres AdminI = new classAdmInteres();
         AdminI.fec_inclusion = Date.valueOf(Datetime.now());
         AdminI.v_dia = '13';
         
         classPagoInteresesReg PagoR = new classPagoInteresesReg();
         PagoR.Cuenta = '36327';
         PagoR.NombreCompleto = 'Cesar';
         PagoR.Identidad = '0293930293';
         PagoR.TipoFondo = 'Paso';
         PagoR.CausaDescripcion = 'Una';
         PagoR.EstadoCuenta = 'R';
         PagoR.Tipodepago = 'Casual';
         PagoR.Montodepago = '19209';
         PagoR.Ajuste = '2323';
         PagoR.Diadepago = '26';
         PagoR.Formadepago = 'AH';
         PagoR.Bancos = '23';
         PagoR.NoCuenta = '362';
         PagoR.TipodeCuenta = 'Normal';
         PagoR.EstadoAprobacion = 'A';
         PagoR.Id_pagointeres = 323;
         PagoR.TotalFondo = '10000';
         PagoR.CantidadPignorada = '2000';
         PagoR.Moneda = '03';
         PagoR.fechadeRegistro = datetime.now();
         PagoR.fechadeActivacion = datetime.now();
         PagoR.fechaHasta = datetime.now();
         PagoR.Variable = 'Nueva';
         PagoR.P_ERROR = 'Malo';
         PagoR.LEE_ERRORES = 'Malo';
         PagoR.Cod_Causa = '04';
         
        
         InteresesEspecificos Ints= new InteresesEspecificos(32,'nue');
          
         classPagoInteresesRegA pagorA = new classPagoInteresesRegA();
         pagorA.Cuenta = '36327';
         pagorA.NombreCompleto = 'Cesar';
         pagorA.Identidad = '0293930293';
         pagorA.TipoFondo = 'Paso';
         pagorA.CausaDescripcion = 'Una';
         pagorA.EstadoCuenta = 'R';
         pagorA.Tipodepago = 'Casual';
         pagorA.Montodepago = '19209';
         pagorA.Ajuste = '2323';
         pagorA.Diadepago = '26';
         pagorA.Formadepago = 'AH';
         pagorA.Bancos = '23';
         pagorA.NoCuenta = '362';
         pagorA.TipodeCuenta = 'Normal';
         pagorA.EstadoAprobacion = 'A';
         pagorA.Id_pagointeres = 323;
         pagorA.TotalFondo = '10000';
         pagorA.CantidadPignorada = '2000';
         pagorA.Moneda = '03';
         pagorA.fechadeRegistro = datetime.now();
         pagorA.fechadeActivacion = datetime.now();
         pagorA.fechaHasta = datetime.now();
         pagorA.LEE_ERRORES = 'Malo';
         pagorA.Cod_Causa = '04';
         pagorA.P_ERROR = 'Malo';
         
         //PARA API ControllerAPIPagoIntereses
    	classPagoInteresesFPC fcsds = ControllerAPIPagoIntereses.BuscarCuenta('72333');
        classPagoInteresesFPC fcsd = ControllerAPIPagoIntereses.BuscarCuenta2('27366');
        classBitacora bitacora = new classBitacora();
        String resultado2 = ControllerAPIPagoIntereses.INSERTA_BITACORA(bitacora);
        classPagoInteresesFPC ClassInteres = new classPagoInteresesFPC();
        String resultado1 = ControllerAPIPagoIntereses.INSERTAINFO(ClassInteres);
        
        ControllerAPIPagoIntereses.classImagenReferencia imagenComp = new ControllerAPIPagoIntereses.classImagenReferencia();
        ControllerAPIPagoIntereses.GuardarImagen(imagenComp);
        
		String resultado3 = ControllerAPIPagoIntereses.MODIFICARINFO(ClassInteres);
        ControllerAPIPagoIntereses.classRespuestaImagen    wer = ControllerAPIPagoIntereses.TraerImagenBD('7363');
        ControllerAPIPagoIntereses.classRespuestaImagen wer2 = new ControllerAPIPagoIntereses.classRespuestaImagen();
         wer2.codigo = 232;
         wer2.imagen = 'imagengg';
         wer2.mensaje = 'holaaa';
        ControllerAPIPagoIntereses.RespuestaImagen wer3 = new ControllerAPIPagoIntereses.RespuestaImagen();
         wer3.Cod_referencia = '3425';
         wer3.p_Error = 'Error1';
         wer3.pc_Imagen = 'ErrorImagen';
         
         //API InteresesAprobados
        // controllerAPIinteresAprobados pago = new controllerAPIinteresAprobados();
         classAdmInteres_2 n = new classAdmInteres_2();
         string resultado5 = controllerAPIinteresAprobados.pagaInteres(n);
         controllerAPIinteresAprobados.TraerRegistrados();
         controllerAPIinteresAprobados.TraerRegistrados2('diaSF');
         controllerAPIinteresAprobados.TraerRegistrados3();
         controllerAPIinteresAprobados.TraerImagenBD('CodReferencia');
         controllerAPIinteresAprobados.classRespuestaImagen img = new controllerAPIinteresAprobados.classRespuestaImagen();
         img.codigo = 32;
         img.imagen = 'sdas';
         img.mensaje = 'holaaaa';
     }


}