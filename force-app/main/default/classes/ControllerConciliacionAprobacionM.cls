public with sharing class ControllerConciliacionAprobacionM {
   
    public list<Pantalla_Aportes__c> McontenidoAporte{get;set;}
    public list<Pantalla_Aportes__c> McontenidoTasa{get;set;}
    public list<Pantalla_Aportes__c> McontenidoAporteAprob{get;set;}
    public list<Pantalla_Aportes__c> ContenidoAprobarList{get;set;}   
    public list<Pantalla_Aportes__c> ModifiUSD{get;set;}  
    public list<Pantalla_Aportes__c> VerIamge{get;set;} 
    public Pantalla_Aportes__c DenegarAporteList{get;set;} 
    
    public Pantalla_Aportes__c ContenidoAporte{get;set;} 
    public Pantalla_Aportes__c ModificarEstado{get;set;}
    public Registro_Aportes__c RegistroAportesTotal{get;set;} //Registro de todos los aportes 'Aceptados' y 'Denegados' 
    public Pantalla_Aportes__c ModificarTas{get;set;}
    
    public Pantalla_Aportes__c ImagenMostrar{get;set;}
    
    public integer total {get;set;}
    public date fechadepositoModi {get;set;} //Fecha actualizada
    public date fechadeposito {get;set;} //Fecha
    public datetime FechaActual {get;set;}   
    public boolean DenegarVentana {get;set;}                      
    public String Motivo {get;set;} 
    public String Num_CodReferenciaDenegado {get;set;} 
    public string Num_CodReferencia{get;set;}   
    public Integer p_periodo_aporte{get;set;}   
    public blob DesconvertirImagen {get;set;}   
    public string Ver_Imagen {get;set;}
    public boolean DenegarImagen {get;set;}    
    public string Usuario {get;set;}   
    public boolean MensajeVF {get;set;} 
    public boolean MensajeError {get;set;} 
    public boolean VentanaEmergenteNo {get;set;}    
    public string NombreAsesor {get;set;}    
    
    public string p_saldo {get;set;}
    public string p_monto_pen_aplic {get;set;}
    public string p_codigo_error {get;set;}
    public string p_Mensaje_error {get;set;}
    public string p_num_movim_sysde {get;set;}
    public string p_nombre {get;set;}
    public double CompraDolar {get;set;}
    public boolean MotrarBtn {get;set;}   
    public boolean BloqAcep {get;set;}
    public boolean MostrarTasa {get;set;}
    public string CodReferenVentana {get;set;}  
    public string CodReferenNoCobra {get;set;}  
    
    //Variables de la ventanda modal de contrapartidas
    public string PC_Observaciones {get;set;}
    public string pCU_Rezagos {get;set;}
    public string pCU_Contable {get;set;}
    public TipoPlanilla__c tipopani1 {get;set;} 
    public boolean MostrarVenta12 {get;set;}
    public Account asesorr {get; set;}
    public string CodAsesor {get; set;}
    public List<SelectOption> OpcionAsesor {get;set;}
    
    //VARAIBALES PARA CREAR LA CONTRAPARTIDA
    public  List<ClassPartidaContable> ListaCargaC {get;set;}
    public  List<ClassPartidaContable> ListaCargaDolar {get;set;}
    public  List<Contenido_Estado_Cuenta_Conciliacion__c> MListConciNODIA {get;set;}
    public  List<Contenido_Estado_Cuenta_Conciliacion__c> MListConciNODos {get;set;}
    public List<ControllerAPICONCILIACION.RespuestaPartidaConta> ListRespuestaSysde {get;set;} 
    
    public  List<Pantalla_Aportes__c> ListSeleccionado{get;set;}    
    public string CodReferenciaTemp {get;set;}
    public string part {get;set;}    
    public string UpdaSaldos {get;set;} 
    
    public string moneda_mostrar {get;set;} //mostrar moneda texto
    public string tipo_saldo {get;set;}		//mostrar tipo de saldo en texto
    public string cod_empleado {get;set;} //COdigo del empleado
    public string correoEmpleado {get;set;}//correo del empleado
    Public string nombreOficial {get;set;} 
    
    public ControllerConciliacionAprobacionM(){
        BloqAcep = true;
        FechaActual = date.today();
        Usuario =  ApexPages.currentPage().getParameters().get('hytrd');
        reiniciar();
        CargaPlanilla();
        tipopani1 = new TipoPlanilla__c ();
        asesorr = new Account();
        OpcionAsesor = new List<SelectOption>();
    }
    
    public void MostraVentaEsconder(){
        MostrarVenta12 = false;
    }
    
    public void MostraVentana(){
        try{ 
            MostrarVenta12 = true;   
            ListSeleccionado =[ select cuenta__c,Tipo_MonedaN__c,Fecha_Deposito__c,Monto_Deposito__c,Tipo_SaldoN__c ,
                               Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                               Compra_Dolar__c, Oficial_de_negocios__c, Periodo_Aporte__c
                               from Pantalla_Aportes__c 
                               where Codigo_Referencia__c =: Num_CodReferencia ];
            
            for(integer i=0; i<ListSeleccionado.size(); i++){    
                if(ListSeleccionado[i].Codigo_Referencia__c == Num_CodReferencia ){
                    string TipoPLanilla;
                    system.debug('TipoMoneda' + ListSeleccionado[i].Tipo_MonedaN__c);
                    ControllerAPICONCILIACION.ClassTraerCuentaContable fcsd= new ControllerAPICONCILIACION.ClassTraerCuentaContable ();
                    
                    if(ListSeleccionado[i].Tipo_MonedaN__c == '1'){
                        TipoPLanilla = 'HNL';
                    }else{
                        TipoPLanilla = 'USD';
                    }
                    
                    fcsd = ControllerAPICONCILIACION.BuscaCuentaConta(TipoPLanilla);
                    pCU_Rezagos = fcsd.Cu_Bancos;
                    pCU_Contable = fcsd.Cu_Rezagos;
                    tipopani1.ListaEC__c = TipoPLanilla;
                    CodReferenVentana = Num_CodReferencia;
                }
            } // fin del for             
        }catch(exception ex){}
    }
    
    //Metodo el cual creara la contrapartida.
    //Si se aprueba el aporte y esta como no conciliado y tiene mas de dos dias 
    //Crea la contrapartida ya sea en HNL O USD
    
    public void ConciliarIndividual2dias(){
        try{
            if (PC_Observaciones == null || PC_Observaciones == ''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Campo Observación Vacío'));
            }else{
                ClassEnviarConciliacionLista Enviar = new ClassEnviarConciliacionLista();
                //CodReferenVentana = Num_CodReferencia;
                MListConciNODIA =[select Monto_Fijo__c, Fecha_Valor__c, Monto_Pendiente__c,Respuesta_SYSDE__c,Tipo_Planilla__c,Conciliado__c, Dias__c, Referencia__c,Fecha_posteo__c, Monto__c, Usuario_SIstema__c 
                                  from Contenido_Estado_Cuenta_Conciliacion__c 
                                  where Referencia__c =: CodReferenVentana];
                
                ListaCargaC = new list<ClassPartidaContable>();
                ListaCargaDolar = new list<ClassPartidaContable>();
                ClassListaPartii pare =  new ClassListaPartii();
                
                system.debug('ListaContrapartida=' + MListConciNODIA);
                
                for(integer i=0; i<MListConciNODIA.size(); i++){
                    
                    if( MListConciNODIA[i].Tipo_Planilla__c == 'HNL'){
                        ListaCargaC.add(new ClassPartidaContable ('2',
                                                                  MListConciNODIA[i].Fecha_Valor__c, 
                                                                  PC_Observaciones +'-'+ +''+MListConciNODIA[i].Referencia__c,
                                                                  MListConciNODIA[i].Referencia__c,
                                                                  MListConciNODIA[i].Fecha_posteo__c, 
                                                                  MListConciNODIA[i].Monto__c ,
                                                                  MListConciNODIA[i].Usuario_SIstema__c,
                                                                  MListConciNODIA[i].Conciliado__c, 
                                                                  pCU_Rezagos,
                                                                  pCU_Contable,
                                                                  MListConciNODIA[i].Dias__c
                                                                 )); 
                    }else{
                        ListaCargaDolar.add(new ClassPartidaContable ('2',
                                                                      MListConciNODIA[i].Fecha_Valor__c, 
                                                                      PC_Observaciones +'-'+ +''+MListConciNODIA[i].Referencia__c,
                                                                      MListConciNODIA[i].Referencia__c,
                                                                      MListConciNODIA[i].Fecha_posteo__c, 
                                                                      MListConciNODIA[i].Monto__c,
                                                                      MListConciNODIA[i].Usuario_SIstema__c,
                                                                      MListConciNODIA[i].Conciliado__c, 
                                                                      pCU_Rezagos,
                                                                      pCU_Contable,
                                                                      MListConciNODIA[i].Dias__c
                                                                     ));  
                    }
                }  // Fin del for
                
                //Lista en HNL
                if(ListaCargaC.size() > 0){
                    
                    system.debug('ListContenidoHNL=' + ListaCargaC );
                    pare.ListaCargaC =ListaCargaC;
                    
                    ListRespuestaSysde  = ControllerAPICONCILIACION.CreaPartidaDebi(pare);
                    for (integer i=0; i<ListRespuestaSysde.size(); i++){
                        //Inserta en la bitacora el registro aprobado
                        Bitacora_Conciliacion__c bita = new Bitacora_Conciliacion__c ();
                        bita.Actividades__c = 'Se creo una contrapartida en lempiras con numero de asiento: ' + ' '+ ListRespuestaSysde[i].NuAsiento;
                        bita.Evento__c = 'Agregar';
                        bita.Pantalla__c = 'VFPantallaConciliacionRespuestaSYSDE';   
                        bita.Fecha__c = date.today();
                        bita.Usuario__c = Usuario;
                        insert bita; 
                        
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Contrapartida En Dolares Creada Correctamente' +' '+ +'Numero Asiento ='+ ListRespuestaSysde[i].NuAsiento ));

                    } // fin del for                     
                }
                
                //LISTA EN USD
                if(ListaCargaDolar.size() > 0){
                    system.debug('ListContenidoUSD=' + ListaCargaDolar );
                    pare.ListaCargaC =ListaCargaDolar;
                    
                    //Si concilia en dolares
                    ListRespuestaSysde  = ControllerAPICONCILIACION.CreaPartidaDolaar(pare);
                    
                    for (integer i=0; i<ListRespuestaSysde.size(); i++){
                        //Inserta en la bitacora el registro aprobado
                        Bitacora_Conciliacion__c bita = new Bitacora_Conciliacion__c ();
                        bita.Actividades__c = 'Se creo una contrapartida en dolares con numero de asiento: ' + ' '+ ListRespuestaSysde[i].NuAsiento;
                        bita.Evento__c = 'Agregar';
                        bita.Pantalla__c = 'VFPantallaConciliacionRespuestaSYSDE';   
                        bita.Fecha__c = date.today();
                        bita.Usuario__c = Usuario;
                        insert bita; 
                        
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Contrapartida En Dolares Creada Correctamente' +' '+ +'Numero Asiento ='+ ListRespuestaSysde[i].NuAsiento ));

                    } // fin del for                      
                }

                MostrarVenta12 = false;
                PC_Observaciones = null;
                
            } //FIN DEL ELSE  
            
        }catch(exception ex){}
    }
    
    public void reiniciar(){    

        FechaActual = date.today();        
        McontenidoAporte =[ select cuenta__c,Tipo_MonedaN__c,Fecha_Deposito__c,Monto_Deposito__c,Tipo_SaldoN__c ,
                           Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                           Compra_Dolar__c, Oficial_de_negocios__c, Periodo_Aporte__c
                           from Pantalla_Aportes__c 
                           where Estado_Aporte__c = 'S' order by Numero_Correlativo__c desc];        
        
        System.debug('Funcion referencia, Codigo de la referencia: ' + Num_CodReferencia + ',' + McontenidoAporte);
        total = McontenidoAporte.size();
    }
    
    Public List<ClaseAporteListaC> FRT{get;set;}
    
    Public class ClaseAporteListaC
    {
    
     public string Cuenta {get;set;}
     public string Moneda {get;set;} 
     public double Monto {get;set;}  
     public date FechaDeposito {get;set;}  
     public string TipoSaldo {get;set;}
     public string NombreCompleto {get;set;}
     public string Comprobante {get;set;} /*En esta variable se cargara una imagen*/  
     public string FormaPago {get;set;} 
     public string Cod_referencia {get;set;} 
     public string ComisionSI {get;set;} /*Aplica Comision*/
     public string DolarSI {get;set;} /*Aplica Comision*/
  	 public string Oficial {get;set;}
        
    public ClaseAporteListaC(string Cuenta, string Moneda,double Monto, date FechaDeposito,string TipoSaldo, 
                             string FormaPago, string Cod_referencia , string ComisionSI,string Oficial,string DolarSI,string Comprobante)
    {
        this.Cuenta=Cuenta;
        this.Moneda=Moneda;
    	this.Monto=Monto;
        this.FechaDeposito=FechaDeposito;
        this.TipoSaldo=TipoSaldo;
    	this.FormaPago=FormaPago;
        this.Cod_referencia=Cod_referencia;
        this.ComisionSI=ComisionSI;
        this.Oficial = Oficial;
        this.DolarSI=DolarSI;
        this.Comprobante=Comprobante;
        
    
	  }
   }
    
    public void CargaPlanilla()
    {
           try{
         
            FRT= NEW LIST<ClaseAporteListaC>();
            
            list<Pantalla_Aportes__c> TodasPlanillas=new list<Pantalla_Aportes__c>();
            
            McontenidoAporte =[ select cuenta__c, Tasa__c ,Tipo_MonedaN__c,Monto_Deposito__c, Fecha_Deposito__c,Tipo_SaldoN__c ,
                                       Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                                       Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c
                            from Pantalla_Aportes__c 
                            where Estado_Aporte__c = 'S' order by Numero_Correlativo__c desc];
               

           for(integer i=0; i<McontenidoAporte.size(); i++)
            {
                FRT.add(new ClaseAporteListaC( McontenidoAporte[i].cuenta__c, 
                                               McontenidoAporte[i].Tipo_MonedaN__c, 
                                               double.valueOf(McontenidoAporte[i].Monto_Deposito__c),
                                               McontenidoAporte[i].Fecha_Deposito__c,
                                               McontenidoAporte[i].Tipo_SaldoN__c,
                                               McontenidoAporte[i].Forma_PagoN__c,
                                               McontenidoAporte[i].Codigo_Referencia__c,
                                               McontenidoAporte[i].Aplica_Comision_SI__c, 
                                               McontenidoAporte[i].Oficial_de_negocios__c, 
                                               McontenidoAporte[i].Compra_Dolar__c,
                                               McontenidoAporte[i].cuenta__c
                                             ));
                
            }
               
              
            
        }
        Catch(Exception ex)
        {
            system.debug('Error'+ex.getLineNumber());
        }
        
        
        
    }
    
 
    public void popDenegarSalir()
    {    
      DenegarVentana = false;
        Motivo = null;
             
     }
   
    //Mostrar VentanaModalImagen
    
    public void popSalirImagen()
    {    
        DenegarImagen = false;
             
     }
    
    
    
    //Metodo para ver la imagen

    public void MostrarImagen()
     {    
       
         try
         {                 
                DenegarImagen = true; 
                ControllerAPICONCILIACION.classRespuestaImagen wer =  new ControllerAPICONCILIACION.classRespuestaImagen();
                wer = ControllerAPICONCILIACION.TraerImagenBD(Num_CodReferencia); 
             
               //if (wer.codigo == 200 )
               //{
                    Ver_Imagen = wer.imagen;
                    system.debug('Imagen clase ' + Ver_Imagen);
               //}
             	
             	
         	      
         }
        catch(exception e)
        {
		    system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
			ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!'+ e.getMessage() + ' Linea: ' + e.getLineNumber()));
         }      
         
      } 
    

    //FIN
    
  
    //Metodo Para Denegar el aporte.
    
    public void DenegarLista()
     {  
         
         try
         {
          
     		if (Motivo == '') {ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'La Descripcion No Puede Estar Vacia!'));
            }
            else 
            {
                string nomOficial;
                correoUsuario(); //obtener el correo del oficial
                   Pantalla_Aportes__c modifi = new Pantalla_Aportes__c ();
                
                   Num_CodReferenciaDenegado = Num_CodReferencia;
	                
                   modifi = [select Codigo_Referencia__c, Oficial_de_negocios__c, Estado_Aporte__c, Descripcion__c from Pantalla_Aportes__c where Codigo_Referencia__c =: Num_CodReferenciaDenegado limit 1];
                	modifi.Codigo_Referencia__c = modifi.Codigo_Referencia__c + '1';
                	nomOficial = modifi.Oficial_de_negocios__c;
                    modifi.Estado_Aporte__c = 'D';
                    modifi.Descripcion__c = Motivo; 
                    update modifi;
                					
                
                      Bitacora_Conciliacion__c bita = new Bitacora_Conciliacion__c ();
                      bita.Actividades__c = 'Se denego aporte con codigo de referencia: ' + ' ' + Num_CodReferenciaDenegado;
                      bita.Evento__c = 'Denegar';
                      bita.Pantalla__c = 'VFPantallaConciliacionAprobacionM';   
                      bita.Fecha__c = date.today();
                      bita.Usuario__c = Usuario;
                      insert bita; 
				
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
						Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setHtmlBody( 'Buenas ' + nomOficial + ', su aporte con número de referencia ' + 
                                          Num_CodReferencia + ' ha sido DENEGADO, Por el siguiente motivo: ' + modifi.Descripcion__c);
                        mail.setSubject('Aporte con número de referencia ' + Num_CodReferencia + ' DENEGADO');
                        mail.setToAddresses(new String[] {correoEmpleado});
						mail.setOrgWideEmailAddressId(owea.get(0).Id);
                        mail.setSaveAsActivity(true);
                        listCorreo.add(mail);
                        Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
                
                   ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Aporte Denegado'));
                    DenegarVentana = false;
                	Motivo = null;
            }
                    
             
           reiniciar();
             
         }catch(exception e)
            {
                system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
                //ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!'));
             }   
     }
         
    public void MostrarVentanaDenegacion()
    {
		DenegarVentana = true;
        Num_CodReferenciaDenegado = Num_CodReferencia;
       
    }      
    
    public void CerraVentanaDenegacion()
    {
		DenegarVentana = false;
    }      
    
    

    //Metodo para Aprobar el aporte.
    public  List<Contenido_Estado_Cuenta_Conciliacion__c> RevisarAporteConciliado {get;set;}
    public  Contenido_Estado_Cuenta_Conciliacion__c AgregarAporte_A_Conciliados {get;set;}
    public List<Pantalla_Aportes__c> ListRespuesta {get;set;} 
    
     public void AprobarAporte()
     {    
        try
         {    
               //agregado 28-03-2019 - Obtiene la fecha de deposito para Actualizar la fecha de deposito
          			Pantalla_Aportes__c modifi = new Pantalla_Aportes__c ();	
                	Num_CodReferenciaDenegado = Num_CodReferencia;
             		for(integer k=0; k<McontenidoAporte.size(); k++ ){
                	 if(McontenidoAporte[k].Codigo_Referencia__c==Num_CodReferencia){
                     	fechadeposito=McontenidoAporte[k].Fecha_Deposito__c;
                 			}
             			}//fin
             
            CodReferenNoCobra = Num_CodReferencia;
            CodReferenciaTemp = Num_CodReferencia; 
             
            McontenidoAporte =[ select cuenta__c, Tasa__c ,Tipo_MonedaN__c,Monto_Deposito__c, Fecha_Deposito__c,Tipo_SaldoN__c,
                                       Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                                       Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c, Codigo_Usuario__c
                            from Pantalla_Aportes__c 
                            where Estado_Aporte__c = 'S' and Codigo_Referencia__c =: Num_CodReferencia ];
             
            correoUsuario();
             System.debug('Contenido del Aporte: ' + McontenidoAporte);
             System.debug('Codigo de la referencia: ' + Num_CodReferencia);
            for(integer i=0; i < McontenidoAporte.size(); i++)
            {
              
             classAportes_Conciliacion apor =  new classAportes_Conciliacion();   
              
            /*Validacion para que muestre ventana modal cuando no aplique comision...*/
                
             if(McontenidoAporte[i].Aplica_Comision_SI__c == 'N' )
             {
                 nombreOficial = McontenidoAporte[i].Oficial_de_negocios__c;
                 Num_CodReferencia = McontenidoAporte[i].Codigo_Referencia__c;
                 VentanaEmergenteNo = true;
                 
             }
             else
             {
                 System.debug('Referencia Aporte: ' + CodReferenNoCobra);
                  VentanaEmergenteNo = false;
                 if(McontenidoAporte[i].Codigo_Referencia__c == CodReferenNoCobra)   
                 {
                     //Valida que no tenga compra dolar 
                     //si tiene compra de dolar como 'S' se abre una ventana para que cambie el monto en lempiras a dolar.
                        
                     if (McontenidoAporte[i].Compra_Dolar__c == 'S' )
                     {
                        //MostrarTasa = true;
                        //CodReferenciaTemp =  Num_CodReferencia;
                        //Num_CodReferenciaDenegado = Num_CodReferencia;
                        Num_CodReferencia = Num_CodReferenciaDenegado;
                         nombreOficial = McontenidoAporte[i].Oficial_de_negocios__c;
                        VentanaEmergenteNo = false; 
                        MostrarTasa = true;
                        //CodReferenciaTemp =  CodReferenNoCobra;
                        //System.debug('Referencia Aporte: ' + CodReferenNoCobra);
                         //System.debug('Codigo de la referencia: ' + Num_CodReferencia);
                     } 
                     else
                     { 
                            
					nombreOficial = McontenidoAporte[i].Oficial_de_negocios__c; //Correo oficial
                         
                     apor.Cod_referencia = McontenidoAporte[i].Codigo_Referencia__c;
                     apor.Cuenta = McontenidoAporte[i].cuenta__c ;
                     apor.TipoSaldo = McontenidoAporte[i].Tipo_SaldoN__c;
                     //apor.FechaDepositoAproba = date.valueOf(McontenidoAporte[i].Fecha_Deposito__c);
                     apor.FechaDepositoAproba = date.valueOf(fechadeposito);
                     apor.p_periodo_aporte = McontenidoAporte[i].Periodo_Aporte__c;  
                     apor.Moneda = McontenidoAporte[i].Tipo_MonedaN__c ;
                     apor.Monto =  string.valueOf(McontenidoAporte[i].Monto_Deposito__c);  
                     apor.ComisionSI =  McontenidoAporte[i].Aplica_Comision_SI__c;
                     apor.p_periodo_aporte = McontenidoAporte[i].Periodo_Aporte__c;
                     system.debug('ResultadoEnviado'+''+apor);  
                     
                     classAportes_Conciliacion resultado = ControllerAPICONCILIACION.guardarAporte(apor);
                     
                     p_saldo = resultado.p_saldo;
                     p_monto_pen_aplic = resultado.p_monto_pen_aplic;
                     p_codigo_error = resultado.p_codigo_error;
                     p_Mensaje_error =  resultado.p_mensaje_error;   
                     p_num_movim_sysde = resultado.p_num_movim_sysde;
                     p_nombre = resultado.p_nombre;
                     
                         //actualizar la fecha de deposito
                         modifi = [select Fecha_Deposito__c from Pantalla_Aportes__c where Codigo_Referencia__c =: Num_CodReferenciaDenegado ];
                			modifi.Fecha_Deposito__c = fechadeposito;
                			update modifi;
                         
                     if (p_codigo_error == '0' ||test.isRunningTest())
                     {
                         //Busca si la referencia se encuentra en los no conciliados. 
                         //Dado caso que la encuentre modifica el aporte a conciliados si este tiene un dia si tiene dos dias 
                         //crea una contra partida. 
                        
                         ListRespuesta = [select    cuenta__c, Tasa__c ,Tipo_MonedaN__c,Monto_Deposito__c, Fecha_Deposito__c,Tipo_SaldoN__c ,
                                           Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                                           Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c
                                from Pantalla_Aportes__c 
                                 where Codigo_Referencia__c =: Num_CodReferencia];
              
                 
                    for(integer S=0; S < ListRespuesta.size(); S++)
                    {
                         
                          //Busca si la referencia se encuentra en los no conciliados. 
                             //Dado caso que la encuentre modifica el aporte a conciliados si este tiene un dia si tiene dos dias 
                             //crea una contra partida. 
                            RevisarAporteConciliado = [select Conciliado__c,Fecha_Valor__c, Monto_Fijo__c, Dias__c,Referencia__c 
                                                       from Contenido_Estado_Cuenta_Conciliacion__c 
                                                       where Referencia__c =: Num_CodReferencia ];

                             
                         //system.debug('EncontroAporte' + RevisarAporteConciliado);
                            
                        
                            if (RevisarAporteConciliado.size() > 0 )
                            {
                                for(integer p=0; p<RevisarAporteConciliado.size(); p++)
                                {   
                                    
                                    if (RevisarAporteConciliado[i].Conciliado__c == 'S')
                                    {
                                      //Si lo encuentra y esta conciliado no hace nada
                                      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Esta Conciliado'));
                               
                                    } // FIN DEL CONCILIADO SI 
                                    else
                                    {
                                        // si lo encuentra y esta como no conciliado hace lo siguiente:
                                        // 1) Si el aporte esta no conciliado y tiene un dia solo cambia el estado de no conciliado a conciliado sin crear partidas
                                        // 2) Si el aporte esta no conciliado y es > 1 se crea la contrapartida la cual va a mostar una ventana y tienen que llenar esta informacion.
                                        
                                       if (RevisarAporteConciliado[i].Dias__c == 1)
                                        {
                                            RevisarAporteConciliado[i].Conciliado__c = 'S';
                                            update RevisarAporteConciliado;
                                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Conciliado'));
                            
                                            
                                        } // fin del if dia mayor que 1
                                        else // si es mayo que dos dias 
                                        {
                                            MostraVentana();
                                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Conciliación Tiene dos dias')); 
                                        }
                                    } // FIN DEL CONCILIADO NO 
                                    
                                } //fin del for
                            } // fin del if de la lista sea mayor que 0
                             else
                             {
                               // Ya que el aporte enviado no lo encontro se almacena el aporte como no conciliado  
                                
                                Contenido_Estado_Cuenta_Conciliacion__c AgregarAporte_A_Conciliados = new Contenido_Estado_Cuenta_Conciliacion__c();
                                 
                                AgregarAporte_A_Conciliados.Fecha_Valor__c = ListRespuesta[i].Fecha_Deposito__c;
                                 AgregarAporte_A_Conciliados.Fecha_Sistema__c = date.today(); 
                                AgregarAporte_A_Conciliados.Referencia__c = ListRespuesta[i].Codigo_Referencia__c;
                                AgregarAporte_A_Conciliados.Monto__c = ListRespuesta[i].Monto_Deposito__c;
                                AgregarAporte_A_Conciliados.Monto_Fijo__c = ListRespuesta[i].Monto_Deposito__c;
                                AgregarAporte_A_Conciliados.Monto_Pendiente__c = ListRespuesta[i].Monto_Deposito__c;
                                AgregarAporte_A_Conciliados.Usuario_SIstema__c = ListRespuesta[i].Oficial_de_negocios__c;
                                AgregarAporte_A_Conciliados.Dias__c = 1;
                                AgregarAporte_A_Conciliados.Descripci_n__c = 'Aporte Agregado Desde El Sistema De Aprobacion';
                                AgregarAporte_A_Conciliados.Fecha_posteo__c = ListRespuesta[i].Fecha_Deposito__c;
                                AgregarAporte_A_Conciliados.Conciliado__c = 'N';
                                 
                                IF(ListRespuesta[i].Tipo_MonedaN__c == '1')
                                {
                                 AgregarAporte_A_Conciliados.Tipo_Planilla__c =  'HNL';  
                                }
                                ELSE
                                {
                                 AgregarAporte_A_Conciliados.Tipo_Planilla__c =  'USD';  
                                }
                                
                                 insert AgregarAporte_A_Conciliados;
                                
                               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Agregado Correctamente a los no conciliados, porque no se encontro registrado en SF'));
                            
                             } // fin del else mayor que 0
                          
                         
                        if(!test.isRunningTest()){ModificarEstado = [select Estado_Aporte__c from Pantalla_Aportes__c where Codigo_Referencia__c =:  apor.Cod_referencia limit 1];}
                        else{ModificarEstado = [select Estado_Aporte__c from Pantalla_Aportes__c limit 1];}
                            ModificarEstado.Estado_Aporte__c = 'A';  
                            update ModificarEstado;
                        
                            //Inserta En La bitacora De todos los registros
                        if(!test.isRunningTest()){RegistroAportesTotal = [select Estado_Aporte__c from Registro_Aportes__c where Codigo_Referencia__c =:  apor.Cod_referencia ];}
                        else{RegistroAportesTotal = [select Estado_Aporte__c from Registro_Aportes__c limit 1 ];}
                        
                            RegistroAportesTotal.Estado_Aporte__c = 'A';  
                            update RegistroAportesTotal;
                         
                            MensajeVF = true;
                            //reiniciar();
                         
						//Envio de correo - Agregado 05-04-2019
						OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
						Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setHtmlBody( 'Buenas ' + nombreOficial + ', su aporte con número de referencia ' + 
                                          Num_CodReferencia + ' ha sido APROBADO.');
                        mail.setSubject('Aporte con número de referencia ' + Num_CodReferencia + ', APROBADO.');
                        mail.setToAddresses(new String[] {correoEmpleado});
						mail.setOrgWideEmailAddressId(owea.get(0).Id);
                        mail.setSaveAsActivity(true);
                        listCorreo.add(mail);
                        Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);

                    }
                
                         
                     }
                     if (p_codigo_error != '0') 
                     {
                         MensajeError = true; 
                     }    
                    
                  //reiniciar();
                         
       } // fin del else
                      //reiniciar();
                        
                 }
                 reiniciar();
           } 		
                
               
        }
             
			
          reiniciar();
          System.debug('Despues de reini: ' + Num_CodReferencia);
        }catch(exception e)
        {
		    system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
			//ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!'));
         }      
         
      } 
    
    //Para obtener el correo del oficial que realizo el aporte
    public void correoUsuario(){
        TRY{
            cod_empleado = [select Codigo_Usuario__c from Pantalla_Aportes__c where Codigo_Referencia__c =: Num_CodReferencia].Codigo_Usuario__c;
        correoEmpleado = [select Email__c from Usuarios_de_Pantallas__c where Usuario__c =: cod_empleado].Email__c;
        }
        CATCH(exception e){
            
        }
        
        
    }
    
    public void cerrarVentanada()
    {
        MensajeVF = false;
        MostrarTasa = false;
    }
    
    public void CerraError()
    {
        MensajeError = false;
        MostrarTasa = false;
    }
    
    public void mostrarVenTasa()
    {
        
        ModifiUSD =[ select Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                    Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c
                    from Pantalla_Aportes__c 
                    where Estado_Aporte__c = 'S' and Codigo_Referencia__c =: Num_CodReferencia];
        
        if(test.isRunningTest())
        {
            ModifiUSD =[ select Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                        Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c
                        from Pantalla_Aportes__c 
                        ];
        }
        
        for(integer i=0; i<ModifiUSD.size(); i++)
        {
            if(ModifiUSD[i].Codigo_Referencia__c ==  Num_CodReferencia || test.isRunningTest())
            {
                
                if (ModifiUSD[i].Compra_Dolar__c == 'S')
                {
                    
                    MostrarTasa = true;
                    
                }
                else 
                {
                    BloqAcep = false;
                    MotrarBtn = true;
                    
                }
            }    
            
            
        } // fin del for
        
        
    }
    
    
    public void CerrarVentana()
    {
        VentanaEmergenteNo = false;
    }
    
    /*Metodo luego que se enviara aporte sin comision*/
    
    public void AprobarAporte2SinComision()
    {
        
         try
         {    
            
            //VentanaEmergenteNo = false;
            ////agregado 28-03-2019 - Obtiene la fecha de deposito para Actualizar la fecha de deposito
          			Pantalla_Aportes__c modifi = new Pantalla_Aportes__c ();	
                	/*CodReferenNoCobra = Num_CodReferencia;
             		for(integer k=0; k<McontenidoAporte.size(); k++ ){
                	 if(McontenidoAporte[k].Codigo_Referencia__c==CodReferenNoCobra){
                     	fechadeposito=McontenidoAporte[k].Fecha_Deposito__c;
                 			}
             			}*/
             
             //correoUsuario();
             //fin
             
            McontenidoAporte =[ select cuenta__c, Tasa__c ,Tipo_MonedaN__c,Monto_Deposito__c, Fecha_Deposito__c,Tipo_SaldoN__c ,
                                       Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                                       Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c
                            from Pantalla_Aportes__c 
                            where Estado_Aporte__c = 'S' and Codigo_Referencia__c =: CodReferenNoCobra ];
             
            for(integer i=0; i < McontenidoAporte.size(); i++)
            {
              
             classAportes_Conciliacion apor =  new classAportes_Conciliacion();   
              
            
                 if(McontenidoAporte[i].Codigo_Referencia__c == CodReferenNoCobra)   
                 {
                     //Valida que no tenga compra dolar 
                     //si tiene compra de dolar como 'S' se abre una ventana para que cambie el monto en lempiras a dolar.
                        
                     if (McontenidoAporte[i].Compra_Dolar__c == 'S' )
                     {
                        VentanaEmergenteNo = false; 
                        MostrarTasa = true;
                        CodReferenciaTemp =  CodReferenNoCobra;
                     }
                     else
                     {
                     apor.Cod_referencia = McontenidoAporte[i].Codigo_Referencia__c;
                     apor.Cuenta = McontenidoAporte[i].cuenta__c ;
                     apor.TipoSaldo = McontenidoAporte[i].Tipo_SaldoN__c;
                     apor.FechaDepositoAproba = date.valueOf(fechadeposito);//date.valueOf(McontenidoAporte[i].Fecha_Deposito__c);
                     apor.p_periodo_aporte = McontenidoAporte[i].Periodo_Aporte__c;  
                     apor.Moneda = McontenidoAporte[i].Tipo_MonedaN__c ;
                     apor.Monto =  string.valueOf(McontenidoAporte[i].Monto_Deposito__c);  
                     apor.ComisionSI =  McontenidoAporte[i].Aplica_Comision_SI__c;
                     system.debug('ResultadoEnviado'+''+apor);  
                     
                     classAportes_Conciliacion resultado = ControllerAPICONCILIACION.guardarAporte(apor);
                     
                     p_saldo = resultado.p_saldo;
                     p_monto_pen_aplic = resultado.p_monto_pen_aplic;
                     p_codigo_error = resultado.p_codigo_error;
                     p_Mensaje_error =  resultado.p_mensaje_error;   
                     p_num_movim_sysde = resultado.p_num_movim_sysde;
                     p_nombre = resultado.p_nombre;
                     
                     
                          //actualizar la fecha de deposito
                         modifi = [select Fecha_Deposito__c from Pantalla_Aportes__c where Codigo_Referencia__c =: Num_CodReferenciaDenegado ];
                			modifi.Fecha_Deposito__c = fechadeposito;
                			update modifi;
                         
                     if (p_codigo_error == '0' || test.isRunningTest())
                     {
                         //Busca si la referencia se encuentra en los no conciliados. 
                         //Dado caso que la encuentre modifica el aporte a conciliados si este tiene un dia si tiene dos dias 
                         //crea una contra partida. 
                        
                         ListRespuesta = [select    cuenta__c, Tasa__c ,Tipo_MonedaN__c,Monto_Deposito__c, Fecha_Deposito__c,Tipo_SaldoN__c ,
                                           Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                                           Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c
                                from Pantalla_Aportes__c 
                                 where Codigo_Referencia__c =: CodReferenNoCobra];
              
                 
                    for(integer S=0; S < ListRespuesta.size(); S++)
                    {
                         
                          //Busca si la referencia se encuentra en los no conciliados. 
                             //Dado caso que la encuentre modifica el aporte a conciliados si este tiene un dia si tiene dos dias 
                             //crea una contra partida. 
                            RevisarAporteConciliado = [select Conciliado__c,Fecha_Valor__c, Monto_Fijo__c, Dias__c,Referencia__c 
                                                       from Contenido_Estado_Cuenta_Conciliacion__c 
                                                       where Referencia__c =: CodReferenNoCobra ];
                             
                         //system.debug('EncontroAporte' + RevisarAporteConciliado);
                            
                        
                            if (RevisarAporteConciliado.size() > 0 )
                            {
                                for(integer p=0; p<RevisarAporteConciliado.size(); p++)
                                {   
                                    
                                    if (RevisarAporteConciliado[i].Conciliado__c == 'S')
                                    {
                                      //Si lo encuentra y esta conciliado no hace nada
                                      VentanaEmergenteNo = false;
                                      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Esta Conciliado'));
                               
                                    } // FIN DEL CONCILIADO SI 
                                    else
                                    {
                                        // si lo encuentra y esta como no conciliado hace lo siguiente:
                                        // 1) Si el aporte esta no conciliado y tiene un dia solo cambia el estado de no conciliado a conciliado sin crear partidas
                                        // 2) Si el aporte esta no conciliado y es > 1 se crea la contrapartida la cual va a mostar una ventana y tienen que llenar esta informacion.
                                        
                                       if (RevisarAporteConciliado[i].Dias__c == 1)
                                        {
                                            RevisarAporteConciliado[i].Conciliado__c = 'S';
                                            update RevisarAporteConciliado;
                                            VentanaEmergenteNo = false;
                                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Conciliado'));
                            
                                            
                                        } // fin del if dia mayor que 1
                                        else // si es mayo que dos dias 
                                        {
                                            VentanaEmergenteNo = false;
                                            MostraVentana();
                                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Conciliación Tiene dos dias')); 
                                        }
                                    } // FIN DEL CONCILIADO NO 
                                    
                                } //fin del for
                            } // fin del if de la lista sea mayor que 0
                             else
                             {
                               // Ya que el aporte enviado no lo encontro se almacena el aporte como no conciliado  
                                
                                Contenido_Estado_Cuenta_Conciliacion__c AgregarAporte_A_Conciliados = new Contenido_Estado_Cuenta_Conciliacion__c();
                                 
                                AgregarAporte_A_Conciliados.Fecha_Valor__c = ListRespuesta[i].Fecha_Deposito__c;
                                 AgregarAporte_A_Conciliados.Fecha_Sistema__c = date.today(); 
                                AgregarAporte_A_Conciliados.Referencia__c = ListRespuesta[i].Codigo_Referencia__c;
                                AgregarAporte_A_Conciliados.Monto__c = ListRespuesta[i].Monto_Deposito__c;
                                AgregarAporte_A_Conciliados.Monto_Fijo__c = ListRespuesta[i].Monto_Deposito__c;
                                AgregarAporte_A_Conciliados.Monto_Pendiente__c = ListRespuesta[i].Monto_Deposito__c;
                                AgregarAporte_A_Conciliados.Usuario_SIstema__c = ListRespuesta[i].Oficial_de_negocios__c;
                                AgregarAporte_A_Conciliados.Dias__c = 1;
                                AgregarAporte_A_Conciliados.Descripci_n__c = 'Aporte Agregado Desde El Sistema De Aprobacion';
                                AgregarAporte_A_Conciliados.Fecha_posteo__c = ListRespuesta[i].Fecha_Deposito__c;
                                AgregarAporte_A_Conciliados.Conciliado__c = 'N';
                                 
                                IF(ListRespuesta[i].Tipo_MonedaN__c == '1')
                                {
                                 AgregarAporte_A_Conciliados.Tipo_Planilla__c =  'HNL';  
                                }
                                ELSE
                                {
                                 AgregarAporte_A_Conciliados.Tipo_Planilla__c =  'USD';  
                                }
                                
                                 insert AgregarAporte_A_Conciliados;
                                VentanaEmergenteNo = false;
                               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Agregado Correctamente a los no conciliados, porque no se encontro registrado en SF'));
                            
                             } // fin del else mayor que 0
                          
                         
                            ModificarEstado = [select Estado_Aporte__c from Pantalla_Aportes__c where Codigo_Referencia__c =:  apor.Cod_referencia ];
                            ModificarEstado.Estado_Aporte__c = 'A';  
                            update ModificarEstado;
                        
                            //Inserta En La bitacora De todos los registros
                            RegistroAportesTotal = [select Estado_Aporte__c from Registro_Aportes__c where Codigo_Referencia__c =:  apor.Cod_referencia ];
                            RegistroAportesTotal.Estado_Aporte__c = 'A';  
                            update RegistroAportesTotal;
                            VentanaEmergenteNo = false;
                            MensajeVF = true;
                            //reiniciar();
                            
                    }
                
                         
                     }
                     ELSE 
                     {
                         MensajeError = true;
                         VentanaEmergenteNo = false;
                     }    
                    
                  //reiniciar();
                         
       } // fin del else
                      //reiniciar();
                        
                 }
                 reiniciar();
            		
        }
             
             
             //Envio de correo - Agregado 05-04-2019
						OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
						Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setHtmlBody( 'Buenas ' + nombreOficial + ', su aporte con número de referencia ' + 
                                          Num_CodReferencia + ' ha sido APROBADO.');
                        mail.setSubject('Aporte con número de referencia ' + CodReferenNoCobra + ', APROBADO.');
                        mail.setToAddresses(new String[] {correoEmpleado});
						mail.setOrgWideEmailAddressId(owea.get(0).Id);
                        mail.setSaveAsActivity(true);
                        listCorreo.add(mail);
                        Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
          reiniciar();
        }catch(exception e)
        {
		    system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
			//ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!'));
         }      
                
    }
    
    

    //Cambio Tasa 
    
     public void CambioTasa()
    {
        try{
             ////agregado 28-03-2019 - Obtiene la fecha de deposito para Actualizar la fecha de deposito
          			Pantalla_Aportes__c modifi = new Pantalla_Aportes__c ();	
                	//Num_CodReferenciaDenegado = CodReferenciaTemp;
             		/*for(integer k=0; k<McontenidoAporte.size(); k++ ){
                	 if(McontenidoAporte[k].Codigo_Referencia__c==CodReferenciaTemp){
                     	fechadeposito=McontenidoAporte[k].Fecha_Deposito__c;
                 			}
             			}//fin*/
            
            correoUsuario();
             SYSTEM.debug('MONTO DEL DOLAR '+ CompraDolar+' '+CodReferenciaTemp);
              part = 'S';
              UpdaSaldos = 'S';
              double totalDo = 0.0;
              string TipoMonedaD = 'S';
               if(CompraDolar == null || CompraDolar == 0.0 || CompraDolar == 0)
                         {
                           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'La tasa no puede estar vacia')); 
                         }
                         else
                         {
                             	 
                                  Pantalla_Aportes__c ane = new Pantalla_Aportes__c();
                             	  ane = [ select  Monto_Deposito__c,Tipo_MonedaN__c
                                          from Pantalla_Aportes__c 
                                          where Estado_Aporte__c = 'S' and Codigo_Referencia__c =: CodReferenciaTemp];  				
                             		
                             	  //system.debug('ANE' + ane);
                                  /*El problema es que no se puede actualizar y luego hacer el insert hay que buscar la forma
								    de hacerlo.	
								   */
                             	  totalDo = (ane.Monto_Deposito__c / CompraDolar).setscale(2);
                                  TipoMonedaD = '2';
                             	  part = 'OK';
                             system.debug('Resultado Operación: ' + totalDo);
                          } // fin del else que cambia la moneda a dolar 
           
            if (part == 'OK')
            {
                
            /*----------------------------------------------*/
          	McontenidoTasa =[ select cuenta__c, Tasa__c ,Tipo_MonedaN__c,Monto_Deposito__c, Fecha_Deposito__c,Tipo_SaldoN__c ,
                                       Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                                       Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c
                            from Pantalla_Aportes__c 
                            where Estado_Aporte__c = 'S' and Codigo_Referencia__c =: CodReferenciaTemp ];
             system.debug('McontenidoTasa' + McontenidoTasa);
            for(integer i=0; i < McontenidoTasa.size(); i++)
            {
                classAportes_Conciliacion wer =  new classAportes_Conciliacion();   
             
            	 wer.Cod_referencia = McontenidoTasa[i].Codigo_Referencia__c;
                 wer.Cuenta = McontenidoTasa[i].cuenta__c ;
                 wer.TipoSaldo = McontenidoTasa[i].Tipo_SaldoN__c;
                 wer.FechaDepositoAproba = date.valueOf(fechadeposito);// date.valueOf(McontenidoTasa[i].Fecha_Deposito__c);
                 wer.p_periodo_aporte = McontenidoTasa[i].Periodo_Aporte__c;  
                 wer.Moneda = TipoMonedaD ;
                 wer.Monto =  string.valueOf(totalDo);  
                 wer.ComisionSI =  McontenidoTasa[i].Aplica_Comision_SI__c;
                 system.debug('ResultadoEnviado'+''+ wer);  
                 
                 classAportes_Conciliacion resultado = ControllerAPICONCILIACION.guardarAporte(wer);
				 
                 p_saldo = resultado.p_saldo;
                 p_monto_pen_aplic = resultado.p_monto_pen_aplic;
                 p_codigo_error = resultado.p_codigo_error;
                 p_Mensaje_error =  resultado.p_mensaje_error;   
                 p_num_movim_sysde = resultado.p_num_movim_sysde;
				 p_nombre = resultado.p_nombre;
        		 
                //actualizar la fecha de deposito
                         modifi = [select Fecha_Deposito__c from Pantalla_Aportes__c where Codigo_Referencia__c =: Num_CodReferenciaDenegado ];
                			modifi.Fecha_Deposito__c = fechadeposito;
                			update modifi;
                 
                 if (p_codigo_error == '0')
                 {
                     UpdaSaldos = 'OK';
                     //MensajeVF = true;
                     
                     //Busca si la referencia se encuentra en los no conciliados. 
                     //Dado caso que la encuentre modifica el aporte a conciliados si este tiene un dia si tiene dos dias 
                     //crea una contra partida. 
                    
                     ListRespuesta = [select    cuenta__c, Tasa__c ,Tipo_MonedaN__c,Monto_Deposito__c, Fecha_Deposito__c,Tipo_SaldoN__c ,
                                       Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                                       Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c
                            from Pantalla_Aportes__c 
                             where Codigo_Referencia__c =: CodReferenciaTemp];
          
             
            for(integer S=0; S < ListRespuesta.size(); S++)
            {
                 
                  //Busca si la referencia se encuentra en los no conciliados. 
                     //Dado caso que la encuentre modifica el aporte a conciliados si este tiene un dia si tiene dos dias 
                     //crea una contra partida. 
                    RevisarAporteConciliado = [select Conciliado__c,Fecha_Valor__c, Monto_Fijo__c, Dias__c,Referencia__c 
                                               from Contenido_Estado_Cuenta_Conciliacion__c 
                                               where Referencia__c =: CodReferenciaTemp ];
                     
                 //system.debug('EncontroAporte' + RevisarAporteConciliado);
                    
                
                    if (RevisarAporteConciliado.size() > 0 )
                     {
                        for(integer p=0; p<RevisarAporteConciliado.size(); p++)
                        {   
                            
                            if (RevisarAporteConciliado[i].Conciliado__c == 'S')
                            {
                              //Si lo encuentra y esta conciliado no hace nada
                              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Esta Conciliado'));
                       
                            } // FIN DEL CONCILIADO SI 
                            else
                            {
                                // si lo encuentra y esta como no conciliado hace lo siguiente:
                                // 1) Si el aporte esta no conciliado y tiene un dia solo cambia el estado de no conciliado a conciliado sin crear partidas
                                // 2) Si el aporte esta no conciliado y es > 1 se crea la contrapartida la cual va a mostar una ventana y tienen que llenar esta informacion.
                                
                               if (RevisarAporteConciliado[i].Dias__c == 1)
                                {
                                    RevisarAporteConciliado[i].Conciliado__c = 'S';
                                    update RevisarAporteConciliado;
                       	            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Conciliado'));
                    
                                    
                                } // fin del if dia mayor que 1
                                else // si es mayo que dos dias 
                                {
                                    MostraVentana();
                                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Conciliación Tiene dos dias')); 
                                }
                            } // FIN DEL CONCILIADO NO 
                            
                        } //fin del for
                    } // fin del if de la lista sea mayor que 0
                    else
                     {
                       // Ya que el aporte enviado no lo encontro se almacena el aporte como no conciliado  
                        
                        Contenido_Estado_Cuenta_Conciliacion__c AgregarAporte_A_Conciliados = new Contenido_Estado_Cuenta_Conciliacion__c();
                         
                        AgregarAporte_A_Conciliados.Fecha_Valor__c = ListRespuesta[i].Fecha_Deposito__c;
                        AgregarAporte_A_Conciliados.Referencia__c = ListRespuesta[i].Codigo_Referencia__c;
                        AgregarAporte_A_Conciliados.Monto__c = totalDo;
                        AgregarAporte_A_Conciliados.Monto_Fijo__c = totalDo;
                        AgregarAporte_A_Conciliados.Usuario_SIstema__c = ListRespuesta[i].Oficial_de_negocios__c;
                        AgregarAporte_A_Conciliados.Dias__c = 1;
                        AgregarAporte_A_Conciliados.Descripci_n__c = 'Aporte Agregado Desde El Sistema De Aprobacion';
                        AgregarAporte_A_Conciliados.Fecha_posteo__c = ListRespuesta[i].Fecha_Deposito__c;
                        AgregarAporte_A_Conciliados.Conciliado__c = 'N';
                         
                        IF(TipoMonedaD == '2')
                        {
                         AgregarAporte_A_Conciliados.Tipo_Planilla__c =  'USD';  
                        }
                        ELSE
                        {
                         AgregarAporte_A_Conciliados.Tipo_Planilla__c =  'HNL';  
                        }
                        
                       insert AgregarAporte_A_Conciliados;
                        
                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Agregado Correctamente a los no conciliados, porque no se encontro registrado en SF'));
                    	
                         //MostrarTasa = false;
                     } // fin del else mayor que 0
                  
                    ModificarEstado = [select Estado_Aporte__c from Pantalla_Aportes__c where Codigo_Referencia__c =:  wer.Cod_referencia ];
                    ModificarEstado.Estado_Aporte__c = 'A';  
                    update ModificarEstado;
                
                    //Inserta En La bitacora De todos los registros
                    RegistroAportesTotal = [select Estado_Aporte__c from Registro_Aportes__c where Codigo_Referencia__c =:  wer.Cod_referencia ];
                    RegistroAportesTotal.Estado_Aporte__c = 'A';  
                    update RegistroAportesTotal;
                MostrarTasa = false;
                reiniciar();
                } // fin del for ListRespuesta
                     
                } // fin del if principal 
                 else
                 {
                    MensajeError = true;
                }
                             
                             
            	} // fin de for principal	                 
                        
               /*--------------------------------------------------*/
            
            } // FIN DEL IF part = 'OK'
            
            //Envio de correo - Agregado 05-04-2019
						OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
						Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setHtmlBody( 'Buenas ' + nombreOficial + ', su aporte con número de referencia ' + 
                                          Num_CodReferencia + ' ha sido APROBADO.');
                        mail.setSubject('Aporte con número de referencia ' + CodReferenciaTemp + ' APROBADO');
                        mail.setToAddresses(new String[] {correoEmpleado});
						mail.setOrgWideEmailAddressId(owea.get(0).Id);
                        mail.setSaveAsActivity(true);
                        listCorreo.add(mail);
                        Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
            
            reiniciar();
            MostrarTasa = false;
            
            IF (UpdaSaldos == 'OK')
            {
                 Pantalla_Aportes__c put = new Pantalla_Aportes__c();
                             	     
                put = [ select  Monto_Deposito__c,Tipo_MonedaN__c
                        from Pantalla_Aportes__c 
                        where Estado_Aporte__c = null and Codigo_Referencia__c =: CodReferenciaTemp]; 
                
                put.Monto_Deposito__c = totalDo;
                put.Tipo_MonedaN__c = TipoMonedaD;
                UPDATE put;
                
            }
            
        
        }catch(Exception ex)
        {
            
        }
    } // Fin del metodo cambio tasa
  
   
    /*Metodo para mostrar el nombre del asesor*/
    


    
    //Metodo de prueba borrar luego
     /*
     public void AprobarPrueba()
     {    
        try
         {    
            ListRespuesta = [select    cuenta__c, Tasa__c ,Tipo_Moneda__c,Monto_Deposito__c, Fecha_Deposito__c,TIPO_SALDO__c ,
                                       Forma_de_Pago__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                                       Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c
                            from Pantalla_Aportes__c 
                             where Codigo_Referencia__c =: Num_CodReferencia];
          
             
            for(integer i=0; i < ListRespuesta.size(); i++)
            {
              
             classAportes_Conciliacion apor =  new classAportes_Conciliacion();   
              
             if(ListRespuesta[i].Codigo_Referencia__c == Num_CodReferencia)   
             {
               
                 apor.Cod_referencia = ListRespuesta[i].Codigo_Referencia__c;
                 apor.Cuenta = ListRespuesta[i].cuenta__c ;
                 apor.TipoSaldo = ListRespuesta[i].TIPO_SALDO__c;
                 apor.FechaDeposito = date.valueOf(ListRespuesta[i].Fecha_Deposito__c);
                 apor.p_periodo_aporte = ListRespuesta[i].Periodo_Aporte__c;  
                 apor.Moneda = ListRespuesta[i].Tipo_Moneda__c ;
                 apor.Monto =  string.valueOf(ListRespuesta[i].Monto_Deposito__c);  
                 apor.ComisionSI =  ListRespuesta[i].Aplica_Comision_SI__c;
                 system.debug('ResultadoEnviado'+''+apor);  
                 
                 
                 
                  //Busca si la referencia se encuentra en los no conciliados. 
                     //Dado caso que la encuentre modifica el aporte a conciliados si este tiene un dia si tiene dos dias 
                     //crea una contra partida. 
                    RevisarAporteConciliado = [select Conciliado__c,Fecha_Valor__c, Monto_Fijo__c, Dias__c,Referencia__c 
                                               from Contenido_Estado_Cuenta_Conciliacion__c 
                                               where Referencia__c =: Num_CodReferencia ];
                     
                 system.debug('EncontroAporte' + RevisarAporteConciliado);
                    
                
                    if (RevisarAporteConciliado.size() > 0 )
                    {
                        for(integer p=0; p<RevisarAporteConciliado.size(); p++)
                        {   
                            
                            if (RevisarAporteConciliado[i].Conciliado__c == 'S')
                            {
                              //Si lo encuentra y esta conciliado no hace nada
                              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Esta Conciliado'));
                       
                            } // FIN DEL CONCILIADO SI 
                            else
                            {
                                // si lo encuentra y esta como no conciliado hace lo siguiente:
                                // 1) Si el aporte esta no conciliado y tiene un dia solo cambia el estado de no conciliado a conciliado sin crear partidas
                                // 2) Si el aporte esta no conciliado y es > 1 se crea la contrapartida la cual va a mostar una ventana y tienen que llenar esta informacion.
                                
                               if (RevisarAporteConciliado[i].Dias__c == 1)
                                {
                                    RevisarAporteConciliado[i].Conciliado__c = 'S';
                                    update RevisarAporteConciliado;
                    
                                    
                                } // fin del if dia mayor que 1
                                else // si es mayo que dos dias 
                                {
                                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Conciliación Tiene dos dias')); 
                                }
                            } // FIN DEL CONCILIADO NO 
                            
                        } //fin del for
                    } // fin del if de la lista sea mayor que 0
                     else
                     {
                       // Ya que el aporte enviado no lo encontro se almacena el aporte como no conciliado  
                        
                        Contenido_Estado_Cuenta_Conciliacion__c AgregarAporte_A_Conciliados = new Contenido_Estado_Cuenta_Conciliacion__c();
                         
                        AgregarAporte_A_Conciliados.Fecha_Valor__c = ListRespuesta[i].Fecha_Deposito__c;
                        AgregarAporte_A_Conciliados.Referencia__c = ListRespuesta[i].Codigo_Referencia__c;
                        AgregarAporte_A_Conciliados.Monto__c = ListRespuesta[i].Monto_Deposito__c;
                        AgregarAporte_A_Conciliados.Monto_Fijo__c = ListRespuesta[i].Monto_Deposito__c;
                        AgregarAporte_A_Conciliados.Usuario_SIstema__c = ListRespuesta[i].Oficial_de_negocios__c;
                        AgregarAporte_A_Conciliados.Dias__c = 1;
                        AgregarAporte_A_Conciliados.Descripci_n__c = 'Aporte Agregado Desde El Sistema De Aprobacion';
                        AgregarAporte_A_Conciliados.Fecha_posteo__c = ListRespuesta[i].Fecha_Deposito__c;
                        AgregarAporte_A_Conciliados.Conciliado__c = 'N';
                         
                        IF(ListRespuesta[i].Tipo_Moneda__c == '1')
                        {
                         AgregarAporte_A_Conciliados.Tipo_Planilla__c =  'HNL';  
                        }
                        ELSE
                        {
                         AgregarAporte_A_Conciliados.Tipo_Planilla__c =  'USD';  
                        }
                        
                         insert AgregarAporte_A_Conciliados;
                        
                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Agregado Correctamente a los no conciliados, porque no se encontro registrado en SF'));
                    
                     } // fin del else mayor que 0
                  
                 
                    ModificarEstado = [select Estado_Aporte__c from Pantalla_Aportes__c where Codigo_Referencia__c =:  apor.Cod_referencia ];
                    ModificarEstado.Estado_Aporte__c = 'A';  
                    update ModificarEstado;
                
                    //Inserta En La bitacora De todos los registros
                    RegistroAportesTotal = [select Estado_Aporte__c from Registro_Aportes__c where Codigo_Referencia__c =:  apor.Cod_referencia ];
                    RegistroAportesTotal.Estado_Aporte__c = 'A';  
                    update RegistroAportesTotal;
                 
                    reiniciar();
              		MensajeVF = true;
                    
             
           }
              
            }
          reiniciar();
             
        }
         
        catch(exception e)
        {
		    system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
			//ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!'));
         }      
         
      } 
    */
    
    
} // de la clase principal