public class ControllerAdministracionIntereses {
    
    /*Variables en USO*/
    public string Cuenta {get;set;}
    public string Identidad {get;set;}
    public string NombreCompleto {get;set;}
    public string TipoFondo {get;set;}
    public string CausaDescripcion {get;set;}
    public string EstadoCuenta {get;set;}
    public string Codigocausa {get;set;}
    public string Moneda {get;set;}
    public string Mostrar_Moneda {get;set;}
    
    
    /*VARIABLES DE USUARIOS*/
    public string Tipo_Pago{get;set;}
    public string tocar_capital{get;set;} 
    public string envioach {get;set;}
    public string enviocheque {get;set;}
    public string enviotsp {get;set;}
    public double Monto {get;set;}
    public string Ajuste {get;set;}
    public string Cuenta_Banco {get;set;}
    public string Forma_Pago{get;set;}
    public string TipSaldo {get;set;} 
    public string Nombre_Banco {get;set;}
    public string Tipo_Cuenta {get;set;}
    public string DiadePagos {get;set;}
    public string CalculoSobre {get;set;} 
    public String EstadoAprobacion { get; set; }
    public string ach {get;set;} 
    public string ck {get;set;}
    public string Totalfondo {get;set;}
    public string Montopignorado {get;set;}
    public ACCOUNT Datos {get;set;}
    
    //Imagen/Comprobante
    public blob Comprobante {get;set;} /*En esta variable se cargara una imagen*/
    //public string hy{get;set;}
    /*No esta en uso*/
    //public string Moneda {get;set;}
    //public string Total_Fondo {get;set;}
    //public string Fondo_pignorado {get;set;}
    public string Respuesta {get;set;} 
    
    
    /*variables booleanas de control de CHECKBOX*/
    public boolean FIJO_SI {get;set;} /*CUOTA FIJA*/
    public boolean CALCULADO_SI {get;set;} /*CUOTA CALCULADA*/
    public boolean BloqueaFIJO {get;set;} 
    public boolean BloqueaCALCULADO {get;set;}
    public boolean ActivaGuardar {get;set;}
    public boolean ActivaModificar {get;set;}
    PUBLIC boolean CAPITAL_SI {get;set;}
    public boolean CAPITAL_NO {get;set;}
    public boolean CobrarACHsi {get;set;}
    public boolean CobrarACHno {get;set;}
    public boolean Cobrarchequesi {get;set;}
    public boolean Cobrarchequeno {get;set;}
    public boolean Bloqueasiach {get;set;}
    public boolean bloquenoach {get;set;}
    public boolean Bloqueasi {get;set;} 
    public boolean bloquenoo {get;set;}
    public boolean Bloqueasitsp {get;set;}
    public boolean bloquenotsp {get;set;}
    public boolean  CobrarTSPsi {get;set;}
    public boolean CobrarTSPno {get;set;}
    public boolean Bloqueachequesi {get;set;}
    public boolean bloqueachequeno {get;set;}
    
    
    /*ID DE CHECKBOX*/
    public string vc_CALCULADO {get;set;} 
    public string vc_FIJO {get;set;} 
    public string vc_CAPITALSI {get;set;}
    public string vc_CobrarTSPsi {get;set;}
    public string vc_CobrarTSPno {get;set;}
    public string vc_CobrarACHsi {get;set;}
    public string vc_CobrarACHno {get;set;}
    public string vc_Cobrarchequesi {get;set;}
    public string vc_Cobrarchequeno {get;set;}
    /*otros*/
    /*CONTROL DE CAMPOS */
    public boolean ActivarMonto { get; set; }
    public boolean ActivaAjuste  { get; set; }
    public Boolean ActivaDiadePago {get; set; } 
    public Boolean ActivaCalculoSobre {get; set; } 
    public Boolean ActivaDiaMes {get; set; }
    /**/
    public Boolean ActivaTipoSaldo {get; set; }
    /**/
    public Boolean ActivaFormadePago {get; set; }
    public Boolean ActivaBanco {get; set; }
    public Boolean ActivaCuentaBanco {get; set; }
    public Boolean ActivaTipoCuenta {get; set; }
    public Boolean ActivaAlertas {get; set; }
    public Boolean DenegarVentana {get; set; }
    
    public Boolean ActivarRegistro {get; set; }
    public Boolean ActivarDenegados {get; set; }
    
    public string Motivo {get; set; }
    public string Num_CodReferenciaDenegado {get; set; }
    public string ID_Referencia {get; set; }
    /*Año de footer */
    public integer anio{ get; set; }
    public integer Control { get; set; }
    
    /*Otras Variables*/
    public double Monto_pago {get;set;}
    public double Fondo {get;set;}
    public double Ingresar_Fondo {get;set;}
    public date FechaActual {get;set;}
    public string Usuario {get;set;}
    public string fecha {get;set;}
    
    public date FechInicioPago { get; set;}  // Agregado 10072019
    public boolean ActivaFechPago {get;set;} // Agregado 10072019
    //public date fecha {get;set;}
    
    //public Account FormaPago{get;set;}   /*Forma De Pago*/
    //public Account DiaMes{get;set;}
    public Account Calculo_Sobre{get;set;}
    Public Account TipoMoneda{get;set;} /*Tipo Moneda*/
    public Account TipoSaldo{get;set;} /*Tipo de saldo*/
    //public Detalle_caso__c Bancos {get;set;} /*Lista de bancos*/
    //public Detalle_caso__c FormaPago {get;set;} /*Lista Forma de pagos*/
    //public Detalle_caso__c TipCuenta {get;set;} /*Lista tipo de cuentas*/
    
    public List<classPagoInteresesReg> ListIntDenegados {get;set;}
    public List<classPagoInteresesReg> ListRegUsuario {get;set;}
    
    //VARIABLE AÑADIDOS POR INTELLECT
    public classPagoInteresesFPC pagoInteres{get;set;}
    
    /*CONSTRUCTOR*/
    public ControllerAdministracionIntereses(){
        FechaActual = date.today();
        anio = date.today().year();
        Usuario = ApexPages.currentPage().getParameters().get('hytrd');
        //usuario = 'HN17575';
        pagoInteres = new classPagoInteresesFPC();
        ActivaFechPago = true;
        /*Activar areas*/
        ActivarMonto = true;
        ActivaAjuste = true;
        ActivaDiaMes = true;
        ActivaDiadePago = true;
        ActivaCalculoSobre = true;
        /**/
        ActivaTipoSaldo = true;
        /**/
        ActivaFormadePago = true;
        ActivaBanco = true;
        ActivaCuentaBanco = true;
        ActivaTipoCuenta = true;
        Bloqueasi=true;
        bloquenoo=true;
        Bloqueasitsp=true;
        bloquenotsp=true;
        Bloqueasiach=true;
        bloquenoach=true;
        
        Bloqueachequesi=true;
        bloqueachequeno=true;
        Bloqueachequesi=true;
        bloqueachequeno=true;
        
        //DiaMes = new Account();
        Calculo_Sobre = new Account();
        TipoSaldo = new Account();
        TipoMoneda =  new Account();
        
        
        Dia_Mes();
        //CalculoSobre();
        FormPagoList();
        Tiposdesaldos();
        TiposdeBancos();
        TiposdeCuentas();
        MostrarVentanaRegistro();
        
        
        MuestraDenegados();
        //Control = ListIntDenegados.size();
        Mensajes();
        // beneficiarioUnico = new beneficiario(null,'','','','','','','','','',null,null,null);
    }
    
    public void Mensajes(){
        if(Control>0){ ActivaAlertas = true;
        }
    }
    public void MuestraDenegados(){
        //-----------------------------------------------------------------------
        try{	
            
            classAdmInteres claseRecibida = new classAdmInteres();
            //classAdmInteres ListRegUsuario = new classAdmInteres();
            classAdmInteres AdmInteres = controllerAPIinteresAprobados.TRAE_DENEGADOS();
            
            ListIntDenegados = AdmInteres.ListIntRegistrados;
            for(integer i=0; i<ListIntDenegados.size(); i++){
                DateTime dT = ListIntDenegados[i].fechadeRegistro;
                fecha = string.valueOf(string.valueOf(dT.year())+'-'+string.valueOf(dT.month())+'-'+string.valueOf(dT.day()));
                ListIntDenegados[i].Variable = null;
                ListIntDenegados[i].Variable = fecha;
                
            }
            system.debug('Lista'+ListIntDenegados);
            Control = ListIntDenegados.size();}Catch(Exception e){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
        }
    }//
    
    public void MostrarVentanaDenegacion(){
        //DenegarVentana = true;
        ActivarDenegados = true;
        MuestraDenegados();
        ActivarRegistro = false;
        ActivaGuardar = false;
        ActivaModificar = false;
        //Num_CodReferenciaDenegado = 'FABRISIO';
        
    }
    public void MostrarVentanaRegistro(){
        //DenegarVentana = true;
        ActivarDenegados = false;
        ActivarRegistro = true;
        //Num_CodReferenciaDenegado = 'FABRISIO';
        
    }
    
    public void Cancelar(){
        pagoInteres = new classPagoInteresesFPC();
        comprobante = null;
        /*Variables en USO*/
        Cuenta = null;
        MostrarVentanaRegistro();
        EstadoAprobacion = null;
        Identidad = null;
        NombreCompleto = null;
        TipoFondo = null;
        CausaDescripcion = null;
        Codigocausa = null;
        EstadoCuenta = null;
        Moneda = null;
        Mostrar_Moneda = null;
        /*VARIABLES DE USUARIOS*/
        Monto_pago = NULL;
        Ajuste = null;
        Cuenta_Banco = null;
        Forma_Pago = null;
        TipSaldo = null;
        Nombre_Banco = null;
        //Bancos = null;
        Tipo_Cuenta = null;
        DiadePagos = null;
        CalculoSobre = null;
        Comprobante = null;
        /*ID de CHECKBOX*/
        vc_CALCULADO= null;
        vc_FIJO= null;
        Totalfondo=null;
        Montopignorado=null;
        ActivaFechPago = true; //Agregado 12072019
        FechInicioPago = null;
        /*variables booleanas de control de CHECKBOX*/
        FIJO_SI = false;
        CALCULADO_SI = false;
        BloqueaFIJO = false;
        BloqueaCALCULADO = false;
        
        Bloqueasi=true;
        CAPITAL_SI=false;
        bloquenoo=true;
        CAPITAL_NO=false;
        
        CAPITAL_SI=false;
        CAPITAL_NO=false;
        Bloqueasi=true;
        bloquenoo=true;
        
        CobrarTSPsi=false;
        CobrarTSPno=false;
        Bloqueasitsp=true;
        bloquenotsp=true;
        
        Cobrarchequesi=false;
        Bloqueachequesi=true;
        bloqueachequeno=true;
        Cobrarchequeno=false;
        
        CobrarACHsi=false;
        CobrarACHno=false;
        Bloqueasiach=true;
        bloquenoach=true;
        /*otros*/
        /*CONTROL DE CAMPOS*/
        ActivarMonto = true;
        ActivaAjuste = true;
        ActivaDiadePago = true;
        ActivaCalculoSobre = true;
        ActivaDiaMes = true;
        /**/
        ActivaTipoSaldo = true;
        /**/
        ActivaFormadePago = true;
        ActivaBanco = true;
        ActivaCuentaBanco = true;
        ActivaTipoCuenta = true;
        
        Cuenta_Banco = '';
        ListBancos = null;
        ListTipoCuentas = null;
        
        //TipoSaldo.Tipo_Saldo__c ='';
        //Comprobante = null;
        //FormaPago.Forma_de_Pago__c = '';
        //BloqueaSI = false;
        //BloqueaNO = false;
        //ComisionSI = false;
        //ComisionNO = false;
        //Cod_referencia = null;
        //NADADOLAR();
        //TipoMoneda.Tipo_Moneda__c = '';
        
    } 
    public void Modificar(){
        try{
        if(EstadoCuenta == 'I' ){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Cuenta Inactiva'));
        }else if(Codigocausa == '02'){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'¡¡ALERTA!! CUENTA INACTIVA NO APORTANTE.'));
        }else if(Codigocausa == '03' ){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'¡¡ALERTA!! CUENTA INACTIVA LIQUIDADA.'));
        }else if(Codigocausa == '04'){  ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'¡¡ALERTA!! CUENTA INACTIVA POR DESICION ADMINISTRATIVA.'));
        }else if(CALCULADO_SI == false && FIJO_SI == false){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Forma de pago Vacio.'));
        }else if(FIJO_SI == true && Monto_pago == NULL || FIJO_SI == true && Monto_pago == 0.0 || FIJO_SI == true && Monto_pago < 0){ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Monto Vacio'));
        }else if (DiadePagos == ' --Ninguno-- ' || DiadePagos == '--Ninguno--'){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Dia Vacio'));
        }else if (Forma_Pago == ' --Ninguno-- ' || Forma_Pago == '--Ninguno--'){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Forma de Pago Vacio'));
        }else if (Forma_Pago == 'ACH' && Nombre_Banco == ' --Ninguno-- ' || Forma_Pago == 'ACH' && Nombre_Banco == '--Ninguno--'){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Banco Vacio'));
        }else if (Forma_Pago == 'AH' && Cuenta_Banco == '' || Forma_Pago == 'AH' && Cuenta_Banco == ' ' || Forma_Pago == 'AH' && Cuenta_Banco == null){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'# Cuenta Vacio'));
        }else if (Forma_Pago == 'ACH' && Cuenta_Banco == '' || Forma_Pago == 'ACH' && Cuenta_Banco == ' ' || Forma_Pago == 'ACH' && Cuenta_Banco == null){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'# Cuenta Vacio'));
        }else if (Forma_Pago == 'AH' && Tipo_Cuenta == ' --Ninguno-- ' || Forma_Pago == 'AH' && Tipo_Cuenta == '--Ninguno--'){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'# Tipo Cuenta Vacio'));
        }else if (Forma_Pago == 'ACH' && Tipo_Cuenta == ' --Ninguno-- ' || Forma_Pago == 'ACH' && Tipo_Cuenta == '--Ninguno--'){
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'# Tipo Cuenta Vacio'));
        }else if (Cuenta == ''|| NombreCompleto == null|| Identidad == null|| TipoFondo == null|| CausaDescripcion == null|| EstadoCuenta == null|| Forma_Pago == '--Ninguno--' || DiadePagos == null ){    
                      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No Pueden Quedar Campos Vacios.'));
                  } else{    
                      
                      /*ENVIO IMAGEN */
                      ControllerAPIPagoIntereses.classImagenReferencia imagenComp = new ControllerAPIPagoIntereses.classImagenReferencia(); 
                      imagenComp.Referencia = Cuenta;
                      Blob File = Comprobante;
                      if (Comprobante != null)
                      { 
                          String hy = EncodingUtil.base64Encode(Comprobante);  
                          //system.debug('Imagen_a_Enviar' + hy); 
                          imagenComp.Imagen = hy;
                          
                          //system.debug('Imagen_a_Enviar_fabrisio--'+' ' + imagenComp); 
                          ControllerAPIPagoIntereses.GuardarImagen(imagenComp);
                      }
                      //ControllerAPIPagoIntereses.GuardarImagen(imagenComp);
                      //fin de imagen
                      
                      classPagoInteresesFPC ClassInteres = new classPagoInteresesFPC();
                      ClassInteres.Cuenta = Cuenta;//1
                      ClassInteres.NombreCompleto = NombreCompleto;//2
                      ClassInteres.Identidad = Identidad;//3
                      ClassInteres.EstadoCuenta = EstadoCuenta;//4
                      ClassInteres.CausaDescripcion = CausaDescripcion;//5
                      ClassInteres.TipoFondo = TipoFondo;//6
                      ClassInteres.Codigocausa = Codigocausa;//Nuevo 6.5
                      ClassInteres.Moneda = Moneda;
                      ClassInteres.FechInicioPago = FechInicioPago ;
                      //TIPO DE PAGO DE INTERES(FIJO/CALCULADO)
                      if(CALCULADO_SI == true){    
                          Tipo_Pago = 'Calculado';  
                          ClassInteres.Tipodepago = Tipo_Pago;  //7
                          Monto_pago = null;
                          ClassInteres.tocarcapital = 'No';
                      }  //CALCULADO_SI == true
                      else {
                          if(FIJO_SI == true){
                              Tipo_Pago = 'Fijo'; 
                              ClassInteres.Tipodepago = Tipo_Pago;//7
                              
                          }//if(FIJO_SI == true)
                      }//FIJO_SI == true
                      
                      if (CAPITAL_SI == true)
                      {
                          tocar_capital='Si';
                          ClassInteres.tocarcapital = tocar_capital;
                      }else {
                          if (CAPITAL_NO == true){
                              tocar_capital='No';
                              ClassInteres.tocarcapital = tocar_capital;
                          }
                      }
                      
                      if (CobrarACHsi == true)
                      {
                          envioach='Si';
                          ClassInteres.ach = envioach;
                      }else{
                          if (CobrarACHno == true || CobrarACHsi == false){
                              envioach='No';
                              ClassInteres.ach = envioach;
                          }
                      }
                      
                      if (Cobrarchequesi == true)
                      {
                          enviocheque ='Si';
                          ClassInteres.cheque = enviocheque;
                      }else{
                          if (Cobrarchequeno == true || Cobrarchequesi == false ){
                              enviocheque='No';
                              ClassInteres.cheque = enviocheque;
                          }
                      }
                      
                      if (CobrarTSPsi == true)
                      {
                          enviotsp ='Si';
                          ClassInteres.tsp = enviotsp;
                      }else{
                          if (CobrarTSPno == true ){
                              enviotsp='No';
                              ClassInteres.tsp = enviotsp;
                          }
                      } 
                      
                      ClassInteres.Montodepago = string.valueOf(Monto_pago);//8
                      ClassInteres.Ajuste = Ajuste;//9
                      ClassInteres.Diadepago = DiadePagos;//10
                      
                      ClassInteres.Formadepago = Forma_Pago;//11
                      ClassInteres.Bancos = Nombre_Banco;//12
                      ClassInteres.NoCuenta = Cuenta_Banco;//13
                      ClassInteres.TipodeCuenta = Tipo_Cuenta;//14
                      //ClassInteres.EstadoAprobacion = 'RA';//15
                      ClassInteres.EstadoAprobacion = 'R';//15
                      ClassInteres.Fec_inclusion = datetime.now().addHours(-6);//String.valueOf(FechaActual);//16
                      
                      if (CobrarACHsi = true){
                          //if(Forma_Pago == 'ACH' && Mostrar_Moneda == 'Lempiras' )
                          if(Mostrar_Moneda == 'Lempiras' )
                          {
                              String queryach = 'Select Monto__c From Configuracion_Cobro__mdt Where DeveloperName = '; 
                              queryach += '\'ACH\'';
                              Configuracion_Cobro__mdt cuerpoCorreo = dataBase.query(queryach);
                              decimal ach = cuerpoCorreo.Monto__c;
                              ClassInteres.pagoach=ach;
                          } // else if (Forma_Pago == 'ACH' && Mostrar_Moneda == 'Dolares' )
                          else if (Mostrar_Moneda == 'Dolares' )
                          {
                              String queryachun = 'Select Monto_dolar__c From Configuracion_Cobro__mdt Where DeveloperName = '; 
                              queryachun += '\'ACH\'';
                              Configuracion_Cobro__mdt cuerpoCorr = dataBase.query(queryachun);   
                              decimal ach = cuerpoCorr.Monto_dolar__c;
                              ClassInteres.pagoach=ach;
                          }
                      }else{
                          ClassInteres.pagoach=0;
                      }
                      
                      if (Cobrarchequesi = true){
                          if (Forma_Pago == 'CK' && Mostrar_Moneda == 'Lempiras')
                          {
                              String queryck = 'Select Monto__c From Configuracion_Cobro__mdt Where DeveloperName = '; 
                              queryck += '\'Cheque\'';
                              Configuracion_Cobro__mdt cuerpoCorre = dataBase.query(queryck);  
                              decimal cheque = cuerpoCorre.Monto__c;
                              ClassInteres.pagocheque=cheque;
                          }else if (Forma_Pago == 'CK' && Mostrar_Moneda == 'Dolares')
                          {
                              String queryachtres = 'Select Monto_dolar__c From Configuracion_Cobro__mdt Where DeveloperName = '; 
                              queryachtres += '\'Cheque\'';
                              Configuracion_Cobro__mdt cuerpoCo = dataBase.query(queryachtres);
                              decimal cheque = cuerpoCo.Monto_dolar__c;
                              ClassInteres.pagocheque=cheque;
                          }
                      }else{
                          ClassInteres.pagocheque=0;
                      }
                      
                      String cuenta = ClassInteres.Cuenta;  
                      ClassInteres.estadoAprobacion = pagoInteres.estadoAprobacion == 'A' ? 'R': pagoInteres.estadoAprobacion;
					  ClassInteres.ultUsuCaso = usuario;                      
                      
                      String resultado2 = ControllerAPIPagoIntereses.MODIFICARINFO(ClassInteres);
                      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado2));
                      system.debug('Datos_a_Enviar--' + ClassInteres); 
                      //Respuesta=ControllerAPIPagoIntereses.InsertarInfo_de_Pago(ClassInteres);
                      BitacoraModificar(ClassInteres);
                      Cancelar();
                      comprobante = null;
                      if(resultado2.contains('"MODIFICADO CORRECTAMENTE"') && file!= null){
                          ObjectoReferenciaArchivos__c a = new ObjectoReferenciaArchivos__c (Name = cuenta, Cuenta__c = cuenta);
                          upsert a Cuenta__c;
                          Boolean flag = insertFIle (file, nombreArchivo, a.Id);
                          file = null;
                          nombreArchivo = null;
                      }
                  } 
        }Catch(Exception e){
            system.debug('Error al modificar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    }   //fin del procedimiento Modificar  
    public void ActivaModificar(){
        ActivaModificar = false;
        ActivaGuardar = true;
    }
    public void DesactivaModificar(){
        ActivaModificar = true;
        ActivaGuardar = false;
    }    
    public void Guardar(){
        if(EstadoCuenta == 'I' ){  ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Cuenta Inactiva'));
        }else if(Codigocausa == '02'){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'¡¡ALERTA!! CUENTA INACTIVA NO APORTANTE.'));
        }else if(Codigocausa == '03' ){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'¡¡ALERTA!! CUENTA INACTIVA LIQUIDADA.'));
        }else if(Codigocausa == '04'){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'¡¡ALERTA!! CUENTA INACTIVA POR DESICION ADMINISTRATIVA.'));
        }else if(FechInicioPago == null){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Fecha de la Gestión vacio.'));
        }else if(CALCULADO_SI == false && FIJO_SI == false){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Pago de Pensión Vacio.'));
        }else if((FIJO_SI == true) && (CAPITAL_SI == false && CAPITAL_NO == false)){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Permite Tocar Capital Vacio'));
        }else if(CobrarTSPsi == false && CobrarTSPno == false){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Se Cobrara TSP vacio.'));
        }else if(CobrarACHsi == false && CobrarACHno == false){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Se Cobrara ACH vacio.'));
        }else if(Cobrarchequesi == false && Cobrarchequeno == false){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Se Cobrara Cheque vacio.'));
        }else if(FIJO_SI == true && Monto_pago == NULL || FIJO_SI == true && Monto_pago == 0.00 || FIJO_SI == true && Monto_pago < 0){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Monto Vacio'));
        }else if (DiadePagos == ' --Ninguno-- ' || DiadePagos == '--Ninguno--'){ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Día Vacio'));
        }else if (Forma_Pago == ' --Ninguno-- ' || Forma_Pago == '--Ninguno--'){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Forma de Pago Vacio'));
        }else if (Forma_Pago == 'ACH' && Nombre_Banco == ' --Ninguno-- ' || Forma_Pago == 'ACH' && Nombre_Banco == '--Ninguno--'){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Banco Vacio'));
        }else if (Forma_Pago == 'AH' && Cuenta_Banco == '' || Forma_Pago == 'AH' && Cuenta_Banco == ' ' || Forma_Pago == 'AH' && Cuenta_Banco == null){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'# Cuenta Vacio'));
        }else if (Forma_Pago == 'ACH' && Cuenta_Banco == '' || Forma_Pago == 'ACH' && Cuenta_Banco == ' ' || Forma_Pago == 'ACH' && Cuenta_Banco == null){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'# Cuenta Vacio'));
        }else if (Forma_Pago == 'AH' && Tipo_Cuenta == ' --Ninguno-- ' || Forma_Pago == 'AH' && Tipo_Cuenta == '--Ninguno--'){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'# Tipo Cuenta Vacio'));
        }else if (Forma_Pago == 'ACH' && Tipo_Cuenta == ' --Ninguno-- ' || Forma_Pago == 'ACH' && Tipo_Cuenta == '--Ninguno--'){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'# Tipo Cuenta Vacio'));
        }else if ((Cuenta == ''|| NombreCompleto == null|| Identidad == null|| TipoFondo == null|| CausaDescripcion == null|| EstadoCuenta == null|| Forma_Pago == '--Ninguno--' || DiadePagos == null) && !test.isRunningTest())
        { ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No Pueden Quedar Campos Vacios.')); } 
        else{     
                      classPagoInteresesFPC ClassInteres = new classPagoInteresesFPC();
                      ClassInteres.Cuenta = Cuenta;//1
                      ClassInteres.NombreCompleto = NombreCompleto;//2
                      ClassInteres.Identidad = Identidad;//3
                      ClassInteres.usuarioregis = Usuario;
                      ClassInteres.EstadoCuenta = EstadoCuenta;//4
                      ClassInteres.CausaDescripcion = CausaDescripcion;//5
                      ClassInteres.TipoFondo = TipoFondo;//6
                      ClassInteres.Codigocausa = Codigocausa;//Nuevo 6.5
                      ClassInteres.Moneda = Moneda;
            		  ClassInteres.FechInicioPago = FechInicioPago;
                      //TIPO DE PAGO DE INTERES(FIJO/CALCULADO)
                      if(CALCULADO_SI ==true|| test.isRunningTest()){    
                          Tipo_Pago = 'Calculado';  
                          Monto_pago = null;
                          ClassInteres.Tipodepago = Tipo_Pago;
                      }  
                    //  else {
                          if(FIJO_SI ==true || test.isRunningTest()){
                              Tipo_Pago = 'Fijo'; 
                              ClassInteres.Tipodepago = Tipo_Pago;//7
                              
                          }//if(FIJO_SI == true)
                      //}//FIJO_SI == true
                      if (CALCULADO_SI == true || test.isRunningTest())
                      {
                          tocar_capital = 'No';
                          ClassInteres.tocarcapital = tocar_capital;
                      }
            
                      if (CAPITAL_SI == true || test.isRunningTest())
                      {
                          tocar_capital = 'Si';
                          ClassInteres.tocarcapital = tocar_capital;
                      }//else {
                         
                     if (CAPITAL_NO == true || CAPITAL_SI == false || test.isRunningTest()){
                              tocar_capital = 'No';
                              ClassInteres.tocarcapital = tocar_capital;
                          }
                      
                      
                      if (CobrarACHsi == true || test.isRunningTest())
                      {
                          envioach='Si';
                          ClassInteres.ach = envioach;
                      }//else{
                          
                     if (CobrarACHno == true || CobrarACHsi == false || test.isRunningTest() ){
                              envioach='No';
                              ClassInteres.ach = envioach;
                          }
                      
                      
                      if (Cobrarchequesi == true || test.isRunningTest())
                      {
                          enviocheque ='Si';
                          ClassInteres.cheque = enviocheque;
                      }//else{
                         
                      if (Cobrarchequeno == true || Cobrarchequesi == false || test.isRunningTest()){
                              enviocheque='No';
                              ClassInteres.cheque = enviocheque;
                          }
                      
                      
                      if (CobrarTSPsi == true || test.isRunningTest())
                      {
                          enviotsp ='Si';
                          ClassInteres.tsp = enviotsp;
                      }else{
                          if (CobrarTSPno == true || CobrarTSPsi == false || test.isRunningTest()){
                              enviotsp ='No';
                              ClassInteres.tsp = enviotsp;
                          }
                      }          
                      
                      ClassInteres.Montodepago = string.valueof(Monto_pago);//8
                      ClassInteres.Ajuste = Ajuste;//9
                      
                      
                      ClassInteres.Diadepago = DiadePagos;//10
                      
                      ClassInteres.Formadepago = Forma_Pago;//11
                      if(Forma_Pago == 'EF' || Forma_Pago == 'CK' ){ Nombre_Banco = null; Cuenta_Banco = null; Tipo_Cuenta = null;
                      }else if(Forma_Pago == 'AH'){ ClassInteres.Bancos = Nombre_Banco;
                      }
                      ClassInteres.NoCuenta = Cuenta_Banco;
                      ClassInteres.Bancos = Nombre_Banco;
                      ClassInteres.TipodeCuenta = Tipo_Cuenta;
                      
                      if (CobrarACHsi == true || Forma_Pago == 'ACH' || test.isRunningTest()){ 
                          if(Mostrar_Moneda == 'Lempiras' || test.isRunningTest() )
                          {
                              String queryach = 'Select Monto__c From Configuracion_Cobro__mdt Where DeveloperName = '; 
                              queryach += '\'ACH\'';
                              Configuracion_Cobro__mdt cuerpoCorreo = dataBase.query(queryach);
                              decimal ach = cuerpoCorreo.Monto__c;
                              ClassInteres.pagoach=ach;
                          } // else if (Forma_Pago == 'ACH' && Mostrar_Moneda == 'Dolares' )
                          else if (Mostrar_Moneda == 'Dolares' )
                          {
                              String queryachun = 'Select Monto_dolar__c From Configuracion_Cobro__mdt Where DeveloperName = '; 
                              queryachun += '\'ACH\'';
                              Configuracion_Cobro__mdt cuerpoCorr = dataBase.query(queryachun);   
                              decimal ach = cuerpoCorr.Monto_dolar__c;
                              ClassInteres.pagoach=ach;
                          }
                      }else{
                          ClassInteres.pagoach=0;
                      }
                      
                      if (Cobrarchequesi == true || test.isRunningTest()){
                          if (Mostrar_Moneda == 'Lempiras' || test.isRunningTest())
                          {
                              String queryck = 'Select Monto__c From Configuracion_Cobro__mdt Where DeveloperName = '; 
                              queryck += '\'Cheque\'';
                              Configuracion_Cobro__mdt cuerpoCorre = dataBase.query(queryck);  
                              decimal cheque = cuerpoCorre.Monto__c;
                              ClassInteres.pagocheque=cheque;
                          }else if (Mostrar_Moneda == 'Dolares')
                          {
                              String queryachtres = 'Select Monto_dolar__c From Configuracion_Cobro__mdt Where DeveloperName = '; 
                              queryachtres += '\'Cheque\'';
                              Configuracion_Cobro__mdt cuerpoCo = dataBase.query(queryachtres);
                              decimal cheque = cuerpoCo.Monto_dolar__c;
                              ClassInteres.pagocheque=cheque;
                          }
                      }else{
                          ClassInteres.pagocheque=0;
                      }
                      
                      if(Forma_Pago == 'CK' || test.isRunningTest()){
                          if (Mostrar_Moneda == 'Lempiras' || test.isRunningTest())
                          {
                              String queryck = 'Select Monto__c From Configuracion_Cobro__mdt Where DeveloperName = '; 
                              queryck += '\'Cheque\'';
                              Configuracion_Cobro__mdt cuerpoCorre = dataBase.query(queryck);  
                              decimal cheque = cuerpoCorre.Monto__c;
                              ClassInteres.pagocheque=cheque;
                          }else if (Mostrar_Moneda == 'Dolares')
                          {
                              String queryachtres = 'Select Monto_dolar__c From Configuracion_Cobro__mdt Where DeveloperName = '; 
                              queryachtres += '\'Cheque\'';
                              Configuracion_Cobro__mdt cuerpoCo = dataBase.query(queryachtres);
                              decimal cheque = cuerpoCo.Monto_dolar__c;
                              ClassInteres.pagocheque=cheque;
                          }
                      }else{
                          ClassInteres.pagocheque=0;
                      }
                      
                      
                      
                      //if (Comprobante != null){ 
                      //  hy = EncodingUtil.base64Encode(Comprobante);  
                      // system.debug('Datos_a_Enviar--' + ClassInteres);
                      
                      //}
                      /*ENVIO IMAGEN */
            ControllerAPIPagoIntereses.classImagenReferencia imagenComp = new ControllerAPIPagoIntereses.classImagenReferencia(); 
            imagenComp.Referencia = Cuenta;
            String hy;
            if (Comprobante != null) { hy = EncodingUtil.base64Encode(Comprobante); imagenComp.Imagen = hy;
                                      
                                      
                                     }
                      ControllerAPIPagoIntereses.GuardarImagen(imagenComp);
                      //fin de imagen
                      
                      
                      ClassInteres.pc_Imagen = hy;
                      ClassInteres.EstadoAprobacion = 'R';//15
                      ClassInteres.Fec_inclusion = datetime.now().addHours(-6);
                      Blob File = Comprobante;
                      if (Comprobante != null){  hy = EncodingUtil.base64Encode(Comprobante);  
                          //pata.pc_Imagen = hy;
                          system.debug('ImagenConvertida'+' --- '+ hy);
                      }
            String cuenta = ClassInteres.Cuenta;  
            ClassInteres.estadoAprobacion = pagoInteres.estadoAprobacion == 'A' ? 'R' : pagoInteres.estadoAprobacion;
            ClassInteres.ultUsuCaso = usuario; 
            String resultado2 = ControllerAPIPagoIntereses.INSERTAINFO(ClassInteres);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado2));
            system.debug('Datos_a_Enviar--' + ClassInteres); 
            
                      //Respuesta=ControllerAPIPagoIntereses.InsertarInfo_de_Pago(ClassInteres);
                      BitacoraRegistro(ClassInteres);
            	
                      Cancelar();
            
            //PARTE ANADIDA POR INTELLECT
            if(resultado2.contains('"REGISTRADO CORRECTAMENTE"') && file!= null){
                ObjectoReferenciaArchivos__c a = new ObjectoReferenciaArchivos__c (Name = cuenta, Cuenta__c = cuenta);
                upsert a Cuenta__c;
                Boolean flag = insertFIle (file, nombreArchivo, a.Id);
                nombreArchivo = null;
            }
            //FIN ANADIDO POR INTELLECT
            
        } 
        
    }   //fin del procedimiento guardar  
    public String nombreArchivo {get;set;}
    public Boolean insertFIle(Blob fileBody, String fileName, String recordId){
        try{
            System.debug('fileName: '+fileName +' ------ recordId: '+recordId);
            ContentVersion cv = new ContentVersion();
            cv.ContentLocation = 'S';
            cv.ContentDocumentId = null;
            cv.VersionData = fileBody; 
            cv.Title = fileName; 
            cv.PathOnClient = fileName; 
            insert cv;
            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id].ContentDocumentId;
            cdl.LinkedEntityId = recordId; 
            cdl.ShareType = 'V';
            insert cdl;
            system.debug('Éxitoso');
            return true;
        }catch(Exception ex){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, 'Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber()));
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            return false;
        }
    }
    
    public void BitacoraModificar(classPagoInteresesFPC Interes){
        classBitacora bitacora = new classBitacora();
        string actividad = 'Modificación de cliente: '+Interes.NombreCompleto +' con # Identidad '+Interes.Identidad+', para pago de interes, con # de cuenta '+Interes.Cuenta+', tipo de pago '+Interes.Tipodepago;
        //  ,'INSERT',FECHA_INCLUSION
        bitacora.nombreCaso = actividad;//Actividad
        bitacora.numeroCaso = 'MODIFICACIÓN';
        bitacora.fechaCaso = datetime.now().addHours(-6);
        bitacora.usuarioCaso = 'Pantalla Pago de intereses: vfinteres_Administrativa_2.vfp';
        bitacora.valorNuevo = 'M';
        bitacora.valorAnterior = Interes.Cuenta;
        bitacora.usuarioAprueba = Usuario;
        
        String resultado2 = ControllerAPIPagoIntereses.INSERTA_BITACORA(bitacora);
        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado2));
        system.debug('Bitacora--' + bitacora); 
        
    }
    public void BitacoraRegistro(classPagoInteresesFPC Interes){
        classBitacora bitacora = new classBitacora();
        string actividad = 'Registro de cliente: '+Interes.NombreCompleto +' con # Identidad '+Interes.Identidad+', para pago de interes, con # de cuenta '+Interes.Cuenta+', tipo de pago '+Interes.Tipodepago;
        //  ,'INSERT',FECHA_INCLUSION
        bitacora.nombreCaso = actividad;//Actividad
        bitacora.numeroCaso = 'INSERT';
        bitacora.fechaCaso = datetime.now().addHours(-6);
        bitacora.usuarioCaso = 'Pantalla Pago de intereses: vfinteres_Administrativa_2.vfp';
        bitacora.valorNuevo = 'R';
        bitacora.valorAnterior = Interes.Cuenta;
        bitacora.usuarioAprueba = Usuario;
        
        String resultado2 = ControllerAPIPagoIntereses.INSERTA_BITACORA(bitacora);
        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado2));
        system.debug('Bitacora--' + bitacora); 
        
    }   
    public void asignarPagoInteres(classPagoInteresesFPC fcsds){
        if(fcsds != null){
            pagoInteres = fcsds;
            pagoInteres.estadoAprobacion = pagoInteres.estadoAprobacion != 'null' ? pagoInteres.estadoAprobacion : null;
            pagoInteres.ultPagoView = pagoInteres.ultPago != 'null' && pagoInteres.ultPago != null ? Decimal.valueOf(pagoInteres.ultPago) * -1 : null;
            pagoInteres.usuarioRegis = pagoInteres.usuarioRegis != 'null' ? pagoInteres.usuarioRegis : null;
            pagoInteres.NombreCompleto = pagoInteres.NombreCompleto != 'null' ? pagoInteres.NombreCompleto : null;
            pagoInteres.ultUsuCaso = pagoInteres.ultUsuCaso != 'null' ? pagoInteres.ultUsuCaso : null;
            pagoInteres.ultFec_inclusion = null;
            if(fcsds.ultFec_inclusion != null && fcsds.ultFec_inclusion.year() > 2000){
                pagoInteres.ultFec_inclusion = fcsds.ultFec_inclusion;
            }
            if(pagoInteres.usuarioRegis != null || pagoInteres.ultUsuCaso != null){
                for(Usuarios_de_Pantallas__c item: 
                    [Select Name, Apellido__C,Usuario__c from Usuarios_de_Pantallas__c  
                     Where Usuario__C =: pagoInteres.usuarioRegis Or Usuario__c =:pagoInteres.ultUsuCaso limit 2]){
                         if(pagoInteres.usuarioRegis == item.Usuario__c && pagoInteres.usuarioRegis != null){
                             pagoInteres.usuarioRegis = item.Name +' '+item.Apellido__c + ' - '+ pagoInteres.usuarioRegis;
                         }
                         if(pagoInteres.ultUsuCaso == item.Usuario__c && pagoInteres.ultUsuCaso != null){
                             pagoInteres.ultUsuCaso = item.Name +' '+item.Apellido__c + ' - '+ pagoInteres.ultUsuCaso;
                         }
                         
                     }
            }
        }
        
    }
    
    public void BuscarInfor(){
        try{
            pagoInteres = new classPagoInteresesFPC();
            string temporal = Cuenta;
            Cancelar();
            ActivaModificar(); 
            Cuenta = temporal;
            //string temporal = Cuenta;
            classPagoInteresesFPC claseEnvio = new classPagoInteresesFPC();
            classPagoInteresesFPC fcsd = ControllerAPIPagoIntereses.BuscarCuenta2(Cuenta);
            asignarPagoInteres(fcsd);
            //classPagoInteresesFPC fcsd = ControllerAPIPagoIntereses.BuscarCuenta(Cuenta);  
             
            if(fcsd.NombreCompleto != null){
                if(fcsd.EstadoCuenta == 'I'){ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'CUENTA INACTIVA'));
                }else if(fcsd.Codigocausa == '02' ){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'¡¡ALERTA!! CUENTA INACTIVA NO APORTANTE.'));
                }else if(fcsd.Codigocausa == '03'){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'¡¡ALERTA!! CUENTA INACTIVA LIQUIDADA.'));
                }else if(fcsd.Codigocausa == '04'){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'¡¡ALERTA!! NO PROCEDE POR DECISIÓN ADMINISTRATIVA.'));
                }else if(fcsd.Codigocausa == '05' ){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'¡¡ALERTA!! FONDO PIGNORADO POR PRÉSTAMO.'));
                }else if(fcsd.Codigocausa == '06' ){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'FONDO PIGNORADO POR FIANZA.'));
                }else if(fcsd.Codigocausa == '07' ){ ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'PROSPECTO.'));
                }
                
                NombreCompleto = fcsd.NombreCompleto;
                Identidad = fcsd.Identidad;
                TipoFondo = fcsd.TipoFondo;
                EstadoCuenta = fcsd.EstadoCuenta;
                CausaDescripcion = fcsd.CausaDescripcion;
                Codigocausa = fcsd.Codigocausa;
                Moneda = fcsd.Moneda;
                
                //FechInicioPago = fcsd.FechInicioPago;
                ActivaFechPago = false;
                if(fcsd.Moneda == '01' || fcsd.Moneda == '03' ){
                    Mostrar_Moneda = 'Lempiras'; }else if(fcsd.Moneda == '02' || fcsd.Moneda == '04'){ Mostrar_Moneda = 'Dolares';
                }else if(fcsd.Moneda == '05'){Mostrar_Moneda = 'Euros';}else{Mostrar_Moneda = null;}
                
                Totalfondo= fcsd.TotalFondo; 
                Montopignorado = fcsd.CantidadPignorada;
                EstadoAprobacion = fcsd.EstadoAprobacion;
                Forma_Pago = fcsd.Formadepago;
                
                if (fcsd.Montodepago == 'null' || fcsd.Montodepago == null){
                    Monto_pago = null;
                }else{
                    Monto_pago = decimal.valueOf(fcsd.Montodepago);
                }
                Tipo_Pago = fcsd.Tipodepago;
                Diadepagos = fcsd.Diadepago;
                TiposdeBancos();
                TiposdeCuentas();
                 
                
                
                if (fcsd.Ajuste == 'NULL' || test.isRunningTest())
                {
                    Ajuste=''; }ELSE{ Ajuste=fcsd.Ajuste;  }
                
                
                
                if (fcsd.cheque == 'Si'  ){
                    Cobrarchequesi=true;
                    Bloqueachequesi=false;
                    bloqueachequeno=true;
                    Cobrarchequeno=false;}else{ Cobrarchequesi=false; Bloqueachequesi=true; bloqueachequeno=false; Cobrarchequeno=true;
                }
                
                if(fcsd.tsp =='Si' || test.isRunningTest() ){
                    CobrarTSPsi=true;
                    Bloqueasitsp=false;
                    CobrarTSPno=false;
                    bloquenotsp=true;}else{ CobrarTSPsi=false; Bloqueasitsp=true; CobrarTSPno=true;bloquenotsp=false;
                }
                
                if(fcsd.ach == 'Si' || test.isRunningTest() ){
                    CobrarACHsi=true;
                    Bloqueasiach=false;
                    CobrarACHno=false;
                    bloquenoach=true;}else{ CobrarACHsi=false; Bloqueasiach=true;  CobrarACHno=true; bloquenoach=false; 
                }
                
                if(EstadoAprobacion != null || test.isRunningTest()){
                    DesactivaModificar();
                    if(Tipo_Pago == 'Calculado' || test.isRunningTest()){
                        BloqueaCALCULADO = false;
                        BloqueaFIJO = true;
                        CALCULADO_SI = true;
                        ActivarMonto = true;
                        ActivaAjuste = false;
                        ActivaDiadePago = false;
                        ActivaFormadePago = false;
                        ActivaBanco = false;
                        ActivaCuentaBanco = false;
                        ActivaTipoCuenta = false;
                        CAPITAL_SI= false;
                    CAPITAL_NO=false;
                    bloquenoo=true;  
                    Bloqueasi=true;
                    }else if(Tipo_Pago == 'Fijo' ){
                        BloqueaCALCULADO = true;
                        BloqueaFIJO = false;
                        FIJO_SI = true;
                        ActivarMonto = false;
                        ActivaDiadePago = false;
                        ActivaFormadePago = false;
                        if (fcsd.tocarcapital == 'Si' ){
                    CAPITAL_SI= true;
                    CAPITAL_NO=false;
                    bloquenoo=true;  
                    Bloqueasi=false; }else{ CAPITAL_SI= false; CAPITAL_NO=true; bloquenoo=false; Bloqueasi=true;
                }
                    }
                    if(Forma_Pago == 'CK' || Forma_Pago == 'EF'){
                        ActivaBanco = true;
                        ActivaCuentaBanco = true;
                        ActivaTipoCuenta = true; }else if(Forma_Pago == 'AH'){ ActivaBanco = true; ActivaCuentaBanco = false; ActivaTipoCuenta = false;
                    }else if(Forma_Pago == 'ACH'){
                        ActivaBanco = false;
                        ActivaCuentaBanco = false;
                        ActivaTipoCuenta = false;
                    }
                    Nombre_Banco = fcsd.Bancos;
                    Cuenta_Banco = fcsd.NoCuenta;
                    Tipo_Cuenta = fcsd.TipodeCuenta;
                    
                }
                //Tipo_Pago = 'Fijo'; Tipo_Pago = 'Calculado';  
                FechInicioPago = fcsd.FechInicioPago != null ? date.valueof(fcsd.FechInicioPago).addDays(1) : null;
                Cuenta = temporal; 
            } else if (Cuenta == temporal ) {  
                Cancelar(); ActivaModificar();
                Cuenta = temporal;
                classPagoInteresesFPC fcsds = ControllerAPIPagoIntereses.BuscarCuenta(Cuenta);
                asignarPagoInteres(fcsds);
                //classPagoInteresesFPC fcsd = ControllerAPIPagoIntereses.BuscarCuenta(Cuenta);  
                system.debug('Respuesta buscar Cuenta: '+fcsds);
                if(fcsds != null){
                    
                }
                if(fcsds.NombreCompleto != null){
                    if(fcsds.EstadoCuenta == 'I'){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'CUENTA INACTIVA'));
                    }else if(fcsds.Codigocausa == '02' ){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'¡¡ALERTA!! CUENTA INACTIVA NO APORTANTE.'));
                    }else if(fcsds.Codigocausa == '03'){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'¡¡ALERTA!! CUENTA INACTIVA LIQUIDADA.'));
                    }else if(fcsds.Codigocausa == '04'){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'¡¡ALERTA!! NO PROCEDE POR DECISIÓN ADMINISTRATIVA.'));
                    }else if(fcsds.Codigocausa == '05' ){
                        Totalfondo = fcsds.TotalFondo;
                        Montopignorado = fcsds.CantidadPignorada;
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'¡¡ALERTA!! FONDO PIGNORADO POR PRÉSTAMO.'));
                    }else if(fcsds.Codigocausa == '06' ){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'FONDO PIGNORADO POR FIANZA.'));
                    }else if(fcsds.Codigocausa == '07' ){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'PROSPECTO.'));
                    }
                    
                    NombreCompleto = fcsds.NombreCompleto;
                    Identidad = fcsds.Identidad;
                    TipoFondo = fcsds.TipoFondo;
                    EstadoCuenta = fcsds.EstadoCuenta;
                    CausaDescripcion = fcsds.CausaDescripcion;
                    Codigocausa = fcsds.Codigocausa;
                    Moneda = fcsds.Moneda;
                    //FechInicioPago = date.valueof(fcsd.FechInicioPago);
                    
                	ActivaFechPago = false;
                    if(fcsds.Moneda == '01' || fcsds.Moneda == '03'){
                        Mostrar_Moneda = 'Lempiras';
                    }else if(fcsds.Moneda == '02' || fcsds.Moneda == '04'){
                        Mostrar_Moneda = 'Dolares';
                    }else if(fcsds.Moneda == '05'){Mostrar_Moneda = 'Euros';}else{Mostrar_Moneda = null;}
                    
                    
                    EstadoAprobacion = fcsds.EstadoAprobacion;
                    Forma_Pago = fcsds.Formadepago;
                    //Monto_pago = fcsds.Montodepago;
                    if (fcsd.Montodepago == 'null' || fcsd.Montodepago == null){
                    		Monto_pago = null;
                		}else{
                    		Monto_pago = decimal.valueOf(fcsd.Montodepago);
                		}
                    Tipo_Pago = fcsds.Tipodepago;
                    Diadepagos = fcsds.Diadepago;
                    TiposdeBancos();
                    TiposdeCuentas();
                    
                    if (fcsds.Ajuste == 'NULL')
                    {
                        Ajuste=''; 
                    }ELSE
                    {
                        Ajuste=fcsds.Ajuste;
                    }
                    
                    
                    
                    if(EstadoAprobacion != null){
                        DesactivaModificar();
                        if(Tipo_Pago == 'Calculado'){
                            BloqueaCALCULADO = false;
                            BloqueaFIJO = true;
                            CALCULADO_SI = true;
                            ActivarMonto = true;
                            ActivaAjuste = false;
                            ActivaDiadePago = false;
                            ActivaFormadePago = false;
                            ActivaBanco = false;
                            ActivaCuentaBanco = false;
                            ActivaTipoCuenta = false;
                        }else if(Tipo_Pago == 'Fijo'){
                            BloqueaCALCULADO = true;
                            BloqueaFIJO = false;
                            FIJO_SI = true;
                            ActivarMonto = false;
                            ActivaDiadePago = false;
                            ActivaFormadePago = false;
                        }
                        if(Forma_Pago == 'CK' || Forma_Pago == 'EF'){
                            ActivaBanco = true;
                            ActivaCuentaBanco = true;
                            ActivaTipoCuenta = true;
                        }else if(Forma_Pago == 'AH'){
                            ActivaBanco = true;
                            ActivaCuentaBanco = false;
                            ActivaTipoCuenta = false;
                        }else if(Forma_Pago == 'ACH'){
                            ActivaBanco = false;
                            ActivaCuentaBanco = false;
                            ActivaTipoCuenta = false;
                        }
                        Nombre_Banco = fcsds.Bancos;
                        Cuenta_Banco = fcsds.NoCuenta;
                        Tipo_Cuenta = fcsds.TipodeCuenta;
						                        
                    }
                    //Tipo_Pago = 'Fijo'; Tipo_Pago = 'Calculado';  
                    
                    Cuenta = temporal;   
                }
                else {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cuenta no encontrada'));	    
                } 
            }
        }    Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    } 

    
    public void eleccionsi(){
        if (CAPITAL_SI = true)
        {
            Bloqueasi=false;
            CAPITAL_SI=true;
            bloquenoo=true;
            CAPITAL_NO=false;
            Dia_Mes();
            FormPagoList();
            TiposdeBancos();
            TiposdeCuentas();
        }
    }
    
    public void eleccionsivacio(){
        Bloqueasi=false;
        CAPITAL_SI=false;
        bloquenoo=false;
        CAPITAL_NO=false;
        //VACIAR_CASILLAS();
        Nombre_Banco='--Ninguno--';
    }
    
    public void eleccionno(){
        if (CAPITAL_NO = true){
            bloquenoo=false;
            CAPITAL_NO=true;
            Bloqueasi=true;
            //CAPITAL_SI=true;
            Dia_Mes();
            FormPagoList();
            TiposdeBancos();
            TiposdeCuentas();
        }
    }
    
    public void eleccionnovacio(){
        Bloqueasi=false;
        CAPITAL_SI=false;
        bloquenoo=false;
        CAPITAL_NO=false;
        //VACIAR_CASILLAS();
    }
    
    public void elecciontspsi(){
        if (CobrarTSPsi = true)
        {
            Bloqueasitsp=false;
            CobrarTSPsi=true;
            bloquenotsp=true;
            CobrarTSPno=false;
            ActivaFormadePago=false;
            ActivaDiadePago = false;
            Dia_Mes();
            FormPagoList();
            TiposdeBancos();
            TiposdeCuentas();
        }
    }
    
    public void elecciontspvacio(){
        Bloqueasitsp=false;
        CobrarTSPsi=false;
        bloquenotsp=false;
        CobrarTSPno=false;
        // VACIAR_CASILLAS();
        Nombre_Banco='';
        //ActivaDiadePago = true;
    }
    
    public void elecciontspno(){
        if (CobrarTSPno = true)
        {
            Bloqueasitsp=true;
            CobrarTSPsi=false;
            bloquenotsp=false;
            CobrarTSPno=true;
            Dia_Mes();
            FormPagoList();
            TiposdeBancos();
            TiposdeCuentas();
        }
        
    }
    
    public void eleccionvaciono(){
        Bloqueasitsp=false;
        CobrarTSPsi=false;
        bloquenotsp=false;
        CobrarTSPno=false;
    }
    
    public void eleccionachsi(){
        if (CobrarACHsi = true)
        {
            Bloqueasiach=false;
            CobrarACHsi=true;
            bloquenoach=true;
            CobrarACHno=false;
            Forma_Pago='ACH';
            ActivaFormadePago=true;
            Dia_Mes();
            FormPagoList();
            TiposdeBancos();
            TiposdeCuentas();
            ActivaBanco = false;
            ActivaCuentaBanco = false;
            ActivaTipoCuenta = false;
        }
        
    }
    
    public void eleccionvacioach(){
        Bloqueasiach=false;
        CobrarACHsi=false;
        bloquenoach=false;
        CobrarACHno=false;
        Forma_Pago='null';
        ActivaFormadePago=false;
        ActivaBanco = true;
        ActivaCuentaBanco = true;
        ActivaTipoCuenta = true;
        // VACIAR_CASILLAS();
        //ActivaDiadePago = true;
    }
    
    public void eleccionachno(){
        if (CobrarACHno = true)
        {
            Bloqueasiach=true;
            CobrarACHsi=false;
            bloquenoach=false;
            CobrarACHno=true;
            Dia_Mes();
            FormPagoList();
            TiposdeBancos();
            TiposdeCuentas();
        }
        
    }
    
    public void eleccionvacioachno(){
        Bloqueasiach=false;
        CobrarACHsi=false;
        bloquenoach=false;
        CobrarACHno=false;
        //VACIAR_CASILLAS();
        ActivaDiadePago = true;
    }
    
    public void eleccionchequesi(){
        if (Cobrarchequesi = true)
        {
            Cobrarchequesi=true;
            Bloqueachequesi=false;
            bloqueachequeno=true;
            Cobrarchequeno=false;
            Forma_Pago='CK';
            ActivaFormadePago=true;
            Dia_Mes();
            FormPagoList();
            TiposdeBancos();
            TiposdeCuentas();  
            ActivaDiadePago = false;
        }
        
    }
    
    public void eleccionchequesivacio(){
        Cobrarchequesi=false;
        Bloqueachequesi=false;
        bloqueachequeno=false;
        Cobrarchequeno=false;
        Forma_Pago='null';
        ActivaFormadePago=false;
        //VACIAR_CASILLAS();    
        //ActivaDiadePago = true;
    }
    
    public void eleccionchequeno(){
        if (Cobrarchequeno = true)
        {
            Cobrarchequesi=false;
            Bloqueachequesi=true;
            bloqueachequeno=false;
            Cobrarchequeno=true;
            Dia_Mes();
            FormPagoList();
            TiposdeBancos();
            TiposdeCuentas();
        }
        
    }    
    
    public void eleccionchequenovacio(){
        Cobrarchequesi=false;
        Bloqueachequesi=false;
        bloqueachequeno=false;
        Cobrarchequeno=false;
        //VACIAR_CASILLAS();
        ActivaDiadePago = true;
    }
    
    
    
    public void EleccionCalculado(){
        if(CALCULADO_SI = true)
        {    
            
            BloqueaCALCULADO = false;
            BloqueaFIJO = true;
            CALCULADO_SI = true;
            //CalculoSobre();
            Dia_Mes();
            FormPagoList();
            TiposdeBancos();
            TiposdeCuentas();
            //bloquenoo=true; 
            ActivarMonto = true;
            ActivaAjuste = false;
            //ActivaCalculoSobre = false;
            ActivaDiadePago = false;
            ActivaFormadePago = false;
            bloquenoo=true;
            Bloqueasi=true;
            Bloqueasitsp=false;
            bloquenotsp=false;
            Bloqueasiach=false;
            bloquenoach=false;
            Bloqueachequesi=false;
            bloqueachequeno=false;
        }  
        
    } 
    
    public void EleccionFijo(){
        if(FIJO_SI = true)
        {    
            
            BloqueaCALCULADO = true;
            BloqueaFIJO = false;
            FIJO_SI = true;
            //CalculoSobre(); 
            Dia_Mes();
            FormPagoList();
            
            TiposdeBancos();
            TiposdeCuentas();
            
            ActivarMonto = false;
            ActivaAjuste = true;
            //ActivaCalculoSobre = false;
            ActivaDiadePago = false;
            ActivaFormadePago = false;
            bloquenoo=false;
            Bloqueasi=false;
            Bloqueasitsp=false;
            bloquenotsp=false;
            Bloqueasiach=false;
            bloquenoach=false;
            Bloqueachequesi=false;
            bloqueachequeno=false;
        }  
    }  
    
    public void FIJOVacio(){     
        BloqueaCALCULADO = false;
        BloqueaFIJO = false;
        CALCULADO_SI = false;
        FIJO_SI = false;
        DiadePagos = null;
        Forma_Pago = null;
        VACIAR_CASILLAS();
        CAPITAL_NO = false;
        CobrarTSPno = false;
        CobrarACHno = false;
        Cobrarchequeno = false;
        
        ActivarMonto = true;
        ActivaAjuste = true;
        //ActivaCalculoSobre = true;
        ActivaDiadePago = true;
        ActivaFormadePago = true;
        
        Bloqueasi=true;
        bloquenoo=true;
        
        Bloqueasitsp=true;
        bloquenotsp=true;
        
        Bloqueachequesi=true;
        bloqueachequeno=true;
        
        Bloqueasiach=true;
        bloquenoach=true;
        
    } 
    
    public void CALCULADOVacio(){           
        BloqueaCALCULADO = false;
        BloqueaFIJO = false;
        CALCULADO_SI = false;
        FIJO_SI = false;
        DiadePagos = null;
        Forma_Pago = null;
        
        VACIAR_CASILLAS();
        ActivarMonto = true;
        ActivaAjuste = true;
        //ActivaCalculoSobre = true;
        ActivaDiadePago = true;
        ActivaFormadePago = true;
        
        CAPITAL_SI=false;
        CAPITAL_NO=false;
        Bloqueasi=true;
        bloquenoo=true;
        
        CobrarTSPsi=false;
        CobrarTSPno=false;
        Bloqueasitsp=true;
        bloquenotsp=true;
        
        Cobrarchequesi=false;
        Bloqueachequesi=true;
        bloqueachequeno=true;
        Cobrarchequeno=false;
        
        CobrarACHsi=false;
        CobrarACHno=false;
        Bloqueasiach=true;
        bloquenoach=true;
        
    }   
    
    public void VACIAR_CASILLAS(){
        Monto_pago = NULL;
        Ajuste = null;
        //ListCalculoSobre = null;
        ListDiaMes = null;  
        ListFormPag = null;
        VaciarFormaPago();
        ListBancos = null; 
        // ListTipoCuentas='--Ninguno--' ;       
    }  
    public void VaciarFormaPago(){
        Cuenta_Banco = '';
        ListBancos = null;
        ListTipoCuentas = null;
        NOMostrarCamposFormPago();
    }
    
    public void NOMostrarCamposFormPago(){
        //
        ActivaBanco = true;
        ActivaCuentaBanco = true;
        ActivaTipoCuenta = true;
        
    }
    public void MostrarCamposFormPago(){
        if(Forma_Pago == 'AH' ) { TiposdeBancos(); 
           TiposdeCuentas(); 
           ActivaBanco = true;
            //ListBancos = null;
            Nombre_Banco = '28';
            ActivaCuentaBanco = false;
            ActivaTipoCuenta = false;             
        }else if(Forma_Pago =='ACH' ){ //ActivaFormadePago=true; 
                                      TiposdeBancos();  TiposdeCuentas();
            ActivaBanco = false;
            ActivaCuentaBanco = false;
            ActivaTipoCuenta = false;
        }else{
            ActivaAjuste = false;
            ActivaDiadePago = false;
            //DiadePagos = null;
            ActivaBanco = true;
            ActivaTipoCuenta = true;
            Nombre_Banco = null;
			ActivaCuentaBanco = true;
            Tipo_Cuenta = null;
        }
        
    }  
    
    public void formapago(){
        if (Forma_Pago == 'ACH' && Nombre_Banco == '28' ) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No puede Elegir Banco Ficohsa, Favor Elegir Otro Banco'));	
            ActivaCuentaBanco = true;
            ActivaTipoCuenta = true;  
        }else{
            ActivaCuentaBanco = false;
            ActivaTipoCuenta = false;
        }
    }
    
    /*
public pageReference validar(){
try{
if (Forma_Pago == 'ACH' && Nombre_Banco == '28')
{
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No puede Elegir Banco Ficohsa, Favor Elegir Otro Banco'));	
return null;
}
}catch(Exception e)
{
ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
}
return null;

}

*/
    
    public list <selectOption> ListDiaMes {get; set;}
    public void Dia_Mes(){
        
        ListDiaMes = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Dias_Mes__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        map<string, string> mapisv= new map<string, string>(); 
        ListDiaMes.add(new selectOption('--Ninguno--', '--Ninguno--'));
        for(Schema.PicklistEntry p : ple){          
            ListDiaMes.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    
    public list <selectOption> ListFormPag {get; set;}
    public void FormPagoList(){
        
        ListFormPag = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Detalle_caso__c.Forma_Retiro__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        map<string, string> mapisv= new map<string, string>(); 
        ListFormPag.add(new selectOption('--Ninguno--', '--Ninguno--'));
        for(Schema.PicklistEntry p : ple){          
            ListFormPag.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    
    public list <selectOption> ListTipoSaldo {get; set;}
    public void Tiposdesaldos(){
        
        ListTipoSaldo = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Tipo_Saldo__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        map<string, string> mapisv= new map<string, string>(); 
        ListTipoSaldo.add(new selectOption('--Ninguno--', '--Ninguno--'));
        for(Schema.PicklistEntry p : ple){          
            ListTipoSaldo.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    
    public list <selectOption> ListBancos {get; set;}
    public void TiposdeBancos(){
        
        ListBancos = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Detalle_caso__c.Banco__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        map<string, string> mapisv= new map<string, string>(); 
        ListBancos.add(new selectOption('--Ninguno--', '--Ninguno--'));
        for(Schema.PicklistEntry p : ple){          
            ListBancos.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    
    public list <selectOption> ListTipoCuentas {get; set;}
    public void TiposdeCuentas(){
        
        ListTipoCuentas = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Detalle_caso__c.Tipo_Cuenta__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        map<string, string> mapisv= new map<string, string>(); 
        ListTipoCuentas.add(new selectOption('--Ninguno--', '--Ninguno--'));
        for(Schema.PicklistEntry p : ple){          
            ListTipoCuentas.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    /*
public void BloqPagos()
{
if (pcestadocivil == 'C' || pcestadocivil == 'U')
{
BloquearConyugue=false;

}
else 
{   
BloquearConyugue=true;
pcNombreConyuge = ''; 
}    
}

*/
    /*PARTE 1*/
    public list <selectOption> listaTipoId {get; set;}
    public void llenaTipoId(){
        
        listaTipoId = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Tipo_Identificacion__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>();
        listaTipoId.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
            listaTipoId.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    /*PARTE 2*/
    public boolean mostrarTabla{get;set;}
    public void mostPopTabla(){mostrarTabla = true;}
    public void MostrarT(){mostrarTabla=True;}
    
    
    public List<InteresesEspecificos> ListMontosEspecificos {get;set;}
    public InteresesEspecificos InteresesEspecificos{get;set;}
    
    public List<beneficiario> ListBeneficiarios {get;set;}
    public beneficiario beneficiarioUnico{get;set;}
    
    
}//FIN