public class ControllerConciliacionAportes {

    
    /*Variables*/
     public string Cuenta {get;set;}
     public string Moneda {get;set;} 
     public double Monto {get;set;}  
     public date FechaDeposito {get;set;}  
     public string NombreCompleto {get;set;}
     public blob Comprobante {get;set;} /*En esta variable se cargara una imagen*/
     public string Cod_referencia {get;set;} /*Codigo de refferencia*/
     public boolean ComisionSI {get;set;} /*Aplica Comision*/
     public boolean ComisionNO {get;set;} /*No Aplica Comision*/
     public String p_periodo_aporte {get;set;} /*Periodo Aporte*/ /*Periodo del aporte, si la frecuencia de pago es quincenal o semanal u otro el formato es YYYYMMDD, si es quincenal se verifica que exista 2 pagos por mes el día 1 y 15, si semanal se verifica que exista un pago por semana cada lunes, si la frecuencia es otro se acepta aportes en cualquier día, cualquier otra frecuencia el formato es YYYYMM00 y corresponde al mes en el que se realiza el aporte, ejemplo si el primer aporte es el 20150100 corresponde a un aporte del mes de enero del 2015, si la frecuencia es semestral el próximo aporte sería 20150600.'*/
     public string Usuario {get;set;}
     public boolean CompraDolarSI {get;set;}
     public boolean CompraDolarNO {get;set;}
     public boolean DolarSI {get;set;}
     public boolean DolarNO {get;set;}
    
    
     //public date fecha {get;set;} 
    
    
     public boolean BloqueaSI {get;set;}  
     public boolean BloqueaNO {get;set;} 
     
     public Account FormaPagoN{get;set;}   /*Forma De Pago*/
     public Account TipoSaldoN{get;set;} /*Tipo de saldo*/ 
     Public Account TipoMonedaN{get;set;} /*Tipo Moneda*/
    //Lista para insertar los objetos de la lista en 
    //public List<Pantalla_Aportes__c> PantallaAporteInsert {get;set;}
    
	//Lista para mostrar los datos de beneficiarios
    //public List<ClassConciliacionAportes> ListAportes {get;set;}
    //public ClassConciliacionAportes AportesUnicos{get;set;}
    public Pantalla_Aportes__c Apor{get;set;}
    
    public ControllerConciliacionAportes() 
    {
      FormaPagoN = new Account();
      TipoSaldoN  = new Account();
      TipoMonedaN =  new Account();
	  //ListAportes = new List<ClassConciliacionAportes>();
      //AportesUnicos = new ClassConciliacionAportes('','',0,null,'','','','',null,null,'');
      Usuario = ApexPages.currentPage().getParameters().get('hytrd');  
      //Usuario = 'HN19577';
      prueba();
      FormPagoList();
        
	}

   public void AplicaComision()
	{
    
        if(ComisionSI = true)
        {    
           
		   BloqueaSI = false;
           BloqueaNO = true;
           ComisionSI = true;
         }  
      
     } 
    
    
   public void NOAplicaComision()
	{
    
        if(ComisionNO = true)
        {    
           
		   BloqueaSI = true;
           BloqueaNO = false;
            ComisionNO = true;
         }  
      
     }  
    
   public void ComisionVaciasNO()
     {
               
		   BloqueaSI = false;
           BloqueaNO = false;
           ComisionSI = false;
           ComisionNO = false;
      
     } 
   public void ComisionVaciasSI()
	{
      
           
		   BloqueaSI = false;
           BloqueaNO = false;
           ComisionSI = false;
           ComisionNO = false;
      
     } 


    public void CompraDSI() 
	{
    
        if(CompraDolarSI = true)
        {    
           
		   CompraDolarSI = TRUE;
           CompraDolarNO = false;
           DolarSI = false;
           DolarNO = TRUE;
         }  
      
     } 
    
    
    public void CompraDNO()
	{
    
        if(CompraDolarNO = true)
        {    
           
		   CompraDolarSI = false;
           CompraDolarNO = TRUE;
           DolarSI = TRUE;
           DolarNO = false;
         }  
      }
    
    public void NADADOLAR()
	{
           CompraDolarSI = false;
           CompraDolarNO = false;
           DolarSI = false;
           DolarNO = false;
          
      }
    
    
    public void cancelar()
	{
    
        Cuenta = null;
        Moneda = null;
        Monto = null;
        FechaDeposito = null;
        NombreCompleto = null;
        Comprobante = null;
        TipoSaldoN.Tipo_SaldoN__c ='';
        FormaPagoN.Forma_PagoN__c = '';
        p_periodo_aporte = null;
        BloqueaSI = false;
        BloqueaNO = false;
        ComisionSI = false;
        ComisionNO = false;
        Cod_referencia = null;
        NADADOLAR();
        TipoMonedaN.Tipo_MonedaN__c = '';
      
    }    

    public string hy{get;set;}
	public string TiSaldo{get;set;}
	public string FoPago{get;set;}
	    
    
    public list <selectOption> ListTipoSaldo {get; set;}
    public void prueba(){
        
		ListTipoSaldo = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Tipo_SaldoN__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        map<string, string> mapisv= new map<string, string>(); 
        ListTipoSaldo.add(new selectOption('--Ninguno--', '--Ninguno--'));
        for(Schema.PicklistEntry p : ple){          
     		ListTipoSaldo.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    
    
    public list <selectOption> ListFormPag {get; set;}
    public void FormPagoList(){
        
		ListFormPag = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Forma_PagoN__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        map<string, string> mapisv= new map<string, string>(); 
        ListFormPag.add(new selectOption('--Ninguno--', '--Ninguno--'));
        for(Schema.PicklistEntry p : ple){          
     	ListFormPag.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    
   public void TraerAportee ()
   {
       /*string temporal = pccontratocolectivo;
            classAportes_Conciliacion claseEnvio = new classAportes_Conciliacion();
            classAportes_Conciliacion fcsd = ControllerAPICONCILIACION.TraerAporte(Cuenta ,TiSaldo);*/
       
		TiSaldo = TipoSaldoN.Tipo_SaldoN__c;
       system.debug('tipo de saldo'+ TiSaldo);
       ControllerAPICONCILIACION.ClassListaAporte kl = new ControllerAPICONCILIACION.ClassListaAporte();
       kl = ControllerAPICONCILIACION.TraerAporte(Cuenta ,TiSaldo);
       system.debug('respues perido'+' '+kl.Aporte);
       if (kl.p_periodo_aporte != 'null')
       {
           p_periodo_aporte = kl.p_periodo_aporte;
           
       }
   }
    	
    /*Guardar Imagen Metodo Prueba*/
    /*
    public void guardarImg()
    {
       ControllerAPICONCILIACION.classImagenReferencia apo =  new ControllerAPICONCILIACION.classImagenReferencia();
       apo.referencia =  Cod_referencia;
	   if (Comprobante != null)
       { 
           hy = EncodingUtil.base64Encode(Comprobante);  
           apo.imagen = hy;
       }
	    //system.debug('Class' + apo);  
         
       //GuardaImagen   
       ControllerAPICONCILIACION.GuardarImagen(apo); 
    }
    
    */
    public void Guardar()
    {
        
     if (((Cuenta == '' || NombreCompleto == null ||FechaDeposito == null 
         ||TipoSaldoN.Tipo_SaldoN__c == '--Ninguno--' || FoPago == '--Ninguno--' 
           || Cod_referencia == '' ||  Monto == null ||  Monto == 0.0 || p_periodo_aporte == '0') || (comisionSI == false && comisionNO == false)
        	|| (compraDolarSI == false && compraDolarNO == false) || comprobante == null) && !test.isRunningTest())
     {    
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No Pueden Quedar Campos Vacios.'));
      }
        else 
      {     
       
       
        Pantalla_Aportes__c pata = new   Pantalla_Aportes__c();
       
       /*ENVIO IMAGEN*/
       classAportes_Conciliacion  ClassConc = new classAportes_Conciliacion(); 
       
       ControllerAPICONCILIACION.classImagenReferencia apo =  new ControllerAPICONCILIACION.classImagenReferencia();
       apo.referencia =  Cod_referencia;
	   if (Comprobante != null)
       { 
           hy = EncodingUtil.base64Encode(Comprobante);  
           apo.imagen = hy;
       }
	    //system.debug('Class' + apo);  
         
       //GuardaImagen   
       ControllerAPICONCILIACION.GuardarImagen(apo); 
          
       //Envio a SF 
       pata.cuenta__c = Cuenta;
       pata.Nombre_Completo__c =  NombreCompleto;
       pata.Tipo_MonedaN__c =  TipoMonedaN.Tipo_MonedaN__c;
       pata.Fecha_Deposito__c =  FechaDeposito;
       pata.Monto_Deposito__c =  Monto;  
       //pata.Tipo_SaldoN__c = TiSaldo;
       pata.Tipo_SaldoN__c = TipoSaldoN.Tipo_SaldoN__c;
       pata.Forma_PagoN__c = FoPago;
       pata.Estado_Aporte__c = 'S';
       pata.Codigo_Referencia__c =  Cod_referencia;
       //pata.Comprobante_imagen__c = hy;
       pata.Periodo_Aporte__c =    p_periodo_aporte;
       pata.Fecha_Ingreso_Sistema__c = date.today();  
       pata.Codigo_Usuario__c = Usuario; //Agregado el 05-04-2019. Almacena el codigo del usuario 
       /*Traer Nombre del usuario*/
          
      
       
       //system.debug('NombreAsesor' + nu);  
          
       IF (FoPago == 'TL' )
       {
           pata.Etiqueta_Forma_Pago__c = 'Talonario';
       }
       else if (FoPago == 'CK')
       {
            pata.Etiqueta_Forma_Pago__c = 'Cheque';
       }
       else if (FoPago == 'PL')
       {
            pata.Etiqueta_Forma_Pago__c = 'Planilla';
       }
        else if (FoPago == 'IT')
       {
            pata.Etiqueta_Forma_Pago__c = 'Interbanca';
       }
        else if (FoPago == 'MV')
       {
            pata.Etiqueta_Forma_Pago__c = 'Movil';
       } 
       else if (FoPago == 'AH')
       {
            pata.Etiqueta_Forma_Pago__c = 'Cuenta Ahorro';
       }
       else if(FoPago == 'TA')
       {
            pata.Etiqueta_Forma_Pago__c = 'Tarjeta';
       }   
      
       if (Comprobante != null)
       { 
          
       hy = EncodingUtil.base64Encode(Comprobante);  
       //pata.pc_Imagen = hy;
       system.debug('ImagenConvertida'+' --- '+ hy);
       }
  
      
        if(ComisionSI == true)
        {    
           
		 pata.Aplica_Comision_SI__c = 'S';  
        }
        
        IF (ComisionSI == FALSE)   
        {    
       		 pata.Aplica_Comision_SI__c = 'N';  
        }
          
          
        if(CompraDolarSI == true)
        {    
           
		 pata.Compra_Dolar__c = 'S';  
        }
        else 
        {    
           
		  pata.Compra_Dolar__c = 'N';    
        }      
       
         string nu;
          /*if(!test.isRunningTest()){nu= [select Name from Usuarios_de_Pantallas__c where Usuario__c =: Usuario].Name;}
          else{nu= [select Name from Usuarios_de_Pantallas__c limit 1].Name;}*/
          
       pata.Oficial_de_negocios__c = nu;  
         
       //Inserta el aporte en SF   
          
        insert pata;
          
       //Insertar Todos los registros en una bitacora de aportes
       Registro_Aportes__c hapt = new   Registro_Aportes__c();
       hapt.cuenta__c = Cuenta;
       hapt.Nombre_Completo__c =  NombreCompleto;
       //hapt.Tipo_MonedaN__c =  TipoMonedaN.Tipo_MonedaN__c;
       hapt.Fecha_Deposito__c =  FechaDeposito;
       hapt.Monto__c =  double.valueOf(Monto);
       //hapt.Tipo_SaldoN__c = TiSaldo;
       //hapt.Forma_PagoN__c = FoPago;
       hapt.Codigo_Referencia__c =  Cod_referencia;
       hapt.Periodo_Aporte__c =    p_periodo_aporte;
       hapt.Fecha_Ingreso_Sistema__c = datetime.now();   
       //Falta traer el usuario desde el login del programa, 
       //pat.Oficial_de_negocios__c =  ; 
           
        if(ComisionSI)
        {    
           
		 hapt.Aplica_Comision__c = 'S';  
        }
        else  
        {    
       		 hapt.Aplica_Comision__c = 'N';  
        }
        insert hapt;
          
        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'APORTE AGREGADO CORRECTAMENTE'));
          
          //Insertar en la bitacora
          Bitacora_Conciliacion__c bita = new Bitacora_Conciliacion__c ();
          bita.Actividades__c = 'Envio de aporte con referencia: ' + ' ' + Cod_referencia;
          bita.Fecha__c = date.today();
          bita.Pantalla__c = 'VFPantallaConciliacion_Aportes';
          bita.Evento__c = 'Insertar';
          bita.Usuario__c = Usuario;
          insert bita;      
          
          cancelar();
      
      }       
 
    }   //fin del procedimiento guardar   
    
    
     /*Procedimiento que trae el nombre completo y la moneda*/
    
     public void BuscarInfor(){
       try{
            
           string temporal = Cuenta;
           classAportes_Conciliacion claseEnvio = new classAportes_Conciliacion();
           classAportes_Conciliacion fcsd = ControllerAPICONCILIACION.BuscarCuenta(Cuenta);
         
           if(fcsd.NombreCompleto != null)
            {
           
           NombreCompleto = fcsd.NombreCompleto;
           TipoMonedaN.Tipo_MonedaN__c = fcsd.Moneda;  
   
          	Cuenta = temporal;	
           } //fin del if secundario
           else
           {
           		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cuenta no encontrada'));	    
           }
          
 
           
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    } 
   
    
    /*Procedimiento que trae el periodo de aporte*/
     public void BuscarPeriodo(){
       try{
            
           //string temporal = Cuenta;
           classAportes_Conciliacion claseEnvio = new classAportes_Conciliacion();
           classAportes_Conciliacion fcsd = ControllerAPICONCILIACION.BuscarCuenta(Cuenta);
         
           if(fcsd.p_periodo_aporte != null)
           {
           
           //p_periodo_aporte = fcsd.p_periodo_aporte;
          
           }
           else
           {
             p_periodo_aporte = null;   
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cuenta no encontrada'));	    
           }
 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    } 
    
}