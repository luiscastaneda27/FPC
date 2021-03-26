@isTest
public class testIntereses {
	static testMethod void Controller_AprobacionPagoInteres()
     {
         //test.startTest();
         ObjectoReferenciaArchivos__c a = new ObjectoReferenciaArchivos__c (Name = '12345', Cuenta__c = '12345');
         upsert a Cuenta__c;
         
         ControllerAdministracionIntereses gaa = new ControllerAdministracionIntereses();
         gaa.insertFIle(Blob.valueOf('test'), 'test', a.Id);
         gaa.insertFIle(Blob.valueOf('test2'), 'test2', a.Id);
         
         
         Controller_AprobacionPagoInteres p = new Controller_AprobacionPagoInteres();
         p.mostrarRegistrados=true;
         p.mostrarBtnAPROBAR=true;
         p.Cuentaun='';
         p.Identidad='';
         p.NombreCompleto='';
         p.TipoFondo='';
         p.CausaDescripcion='';
         p.EstadoCuenta='';
         p.Codigocausa='';
         p.Moneda='';
         p.Mostrar_Moneda='';
         p.Tipo_Pago='';
         p.Monto=0;
         p.Ajuste='';
         p.Cuenta_Banco='';
         p.Forma_Pago='';
         p.TipSaldo='';
         p.Nombre_Banco='';
         p.Tipo_Cuenta='';
         p.DiadePagos='';
         p.Total_Fondo='';
         p.Fondo_pignorado='';
         p.tocarcapital='';
         p.cobrarach='';
         p.cobrartsp='';
         p.cobrarcheque='';
         p.FIJO_SI=true;
         p.CALCULADO_SI=true;
         p.BloqueaFIJO=true;
         p.BloqueaCALCULADO=true;
         p.ActivaGuardar=true;
         p.ActivaModificar=true;
         p.ActivarMonto=true;
         p.ActivaAjuste=true;
         p.ActivaDiadePago=true;
         p.ActivaDiaMes=true;
         p.ActivaTipoSaldo=true;
         p.ActivarDenegados=true;
         p.ActivaCalculoSobre=true;
         p.Ingresar_Fondo=0;
         p.Monto_pago=0;
         p.Fondo=0;
         p.ActivaFormadePago=true;
         p.ActivaBanco=true;
         p.ActivaCuentaBanco=true;
         p.ActivaTipoCuenta=true;
         p.ActivaAlertas=true;
         p.ActivarRegistro=true;
         p.NombreCompl='';
         p.CalculoSobre='';
         p.ID_Referencia='';
         p.Cuentas='';
         p.Identid='';
         p.Num_CodReferenciaDenegado='';
         p.codcliente='';
         p.Motivo='';
         p.fecha='';
         p.ListDiaMes=null;
         p.ListFormPag=null;
         p.DenegarImagen=true;
         p.DenegarVentana=true;
         p.denegarventanauno=false;
         p.popDenegarSalir=true;
         p.DesconvertirImagen=null;
         p.Ver_Imagen='';
         p.pagina='';
         p.Mostrar_Moneda='';
         p.EstadoAprobacion = '';
         p.pagopension = '';
         p.FechaActual = null;
         p.ListaAprobados=null;
         p.ListaRegistrados = null;
         p.ListRegRepetidos = null;
         p.ListDenegados = null;
         p.FechInicioPago = null;
         p.listS = null;
         p.ListIntRegistrados = null;
         p.CuentaAprobadoD = '';
         String body = '[ { "Cuenta": "12345", "NombreCompleto": "NICOLE  ZAPATA AGUILAR", "Identidad": "0801-1992-20733", "TipoFondo": "101", "CausaDescripcion": "AFILIACION POR SOLICITUD", "Cod_Causa": null, "EstadoCuenta": "A", "Tipodepago": "Fijo", "Montodepago": "200", "Ajuste": null, "Diadepago": "12", "Formadepago": "CK", "Bancos": null, "NoCuenta": null, "TipodeCuenta": null, "EstadoAprobacion": "R", "Id_pagointeres": 4546, "TotalFondo": null, "CantidadPignorada": null, "Moneda": null, "fechadeRegistro": "2021-03-11T10:53:20", "fechadeActivacion": null, "LEE_ERRORES": null, "P_ERROR": null } ]';
         p.ListIntRegistrados = (List<classPagoInteresesReg>)System.JSON.deserialize(body, List<classPagoInteresesReg>.class);  
         p.MuestraRegistrados();
         
         p.MostrarVentanaDenegacionu();
         p.MostrarVentanaDenegacion();
         p.Aprobar();
         p.EnvioCorreoAprobado();
         /*Usuarios_de_Pantallas__c InfoUsuario = new Usuarios_de_Pantallas__c (Usuario__c = 'Mar', Contrase_a__c = 'Mosca',  Name = 'Oscar', Apellido__c = 'Alba', Email__c = 'Oscar@yahoo.com');
         insert InfoUsuario;
         InfoUsuario = [select Name, Apellido__c, Email__c from Usuarios_de_Pantallas__c];
         p.correoEmpleado = InfoUsuario.Email__c;
         p.NombreUsuario = InfoUsuario.Name + InfoUsuario.Apellido__c;*/
         p.EnvioCorreoDenegado();
         p.popDenegarSalir();
         p.popsalir();
         p.AprobarPago();
         classPagoInteresesRegA Interes = new classPagoInteresesRegA();
         p.Bitacora(Interes);
         p.MostrarImagen();
         p.popSalirImagen();
         classPagoInteresesReg ListIntRegistrado = new classPagoInteresesReg();
         p.Cambio_de_clase(ListIntRegistrado);
         p.Cambio_de_clase_Objeto(ListIntRegistrado);
         p.Denegar();
         

     }
}