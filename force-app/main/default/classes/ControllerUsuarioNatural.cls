public class ControllerUsuarioNatural {
    public string tipoUsuarioNatural{get;set;}
    public boolean PEP{get;set;}
    public boolean AML{get;set;}
    public boolean FATCA{get;set;}
    public boolean despN {get;Set;}
    public string tipoId{get;set;}
    public string numeroId{get;set;}
    public string primerNombre{get;set;}
    public string segundoNombre{get;set;}
    public string primerApellido{get;set;}
    public string segundoApellido{get;set;}
    public date fechaNacimiento2{get;set;}
    public datetime fechaNacimiento{get;set;}
    public string nacionalidad{get;set;}
    public string telefono{get;set;}
    public string pais{get;set;}
    public string colonia{get;set;}
    public string departamento{get;set;}
    public string municipio{get;set;}
    public string noDomicilio{get;set;}
    public string calleDetalle{get;set;}
    public string procedenciaFondos{get;set;}
    public string nivelRiesgo{get;set;}
    public string debidaDiligencviaAplicada{get;set;}
    public string numeroIdentificacion{get;set;}
    public string numeroCuenta{get;set;}
    public string nombreCompleto{get;set;}
    //public date x_date{get;set;}
    public string usuarioIndividualSelec{get;set;}
    public Account Cliente25{get;set;}
    
    //public Pais_O Cliente20{get;set;}   
    
    public boolean dispep{get;set;}
    public boolean actPop{get;set;}
    public integer valor{get;set;}
    public boolean disbot{get;set;}
    public integer selectops{get;set;}
    public boolean desCheckb{get;set;}
    
    public List<SelectOption> options {get;set;}
    
    public List<SelectOption> opcionPais {get;set;}
    public List<SelectOption> opcionDepartamento {get;set;}
    public List<SelectOption> opcionMunicipio {get;set;}
    public List<SelectOption> opcionColonia {get;set;}
    public List<SelectOption> opcionNacionalidad {get;set;}
    
    public boolean mostrarBoton{get;set;}
    public boolean mostrarSiguiente{get;set;}
    public boolean mostrarAnterior{get;set;}  
        
    public boolean MostarGuardar {get;set;}
    public boolean MostarActualizar {get;set;}
    public string mensaje3{get;set;} 
    public list<Colonias_U__c> listColonias{get;set;}
    integer paginacion;
    
   
    public string pcproducto{get;set;}
    
    
    ////*Variables Pantalla Modal  Datos Persona  Juridica*// 
   //public string  Cod_cliente {get;set;} 
   //public string  Razon_Social_1 {get;set;} 
   //public string  Domicilio_Entidad {get;set;} 
   //public string  Direc_Corres {get;set;} 
   //public string  No_Tel {get;set;} 
   //public string  Nombre_Repre {get;set;} 
   ////*Variables Pantalla Modal  Datos de Contribuyente Fiscal*//  
    //public string Id_fiscal {get;set;}
    //public string Id_fiscal_EUA {get;set;}
    //public string Num_Id_GIIN {get;set;}
    //public string Num_Id_FIPA {get;set;}
    //public string Pais_Recidencia_fiscal {get;set;}
    
   ////*Variables Pantalla Modal  Datos de Cumplimiento- CNBS.*// 
   //public string  Tip_inst {get;set;} 
   //public string  Financiera {get;set;} 
   //public string  Entidad {get;set;} 
   //public string  Pais_Fiscal{get;set;} 
   ////*Variables Pantalla Modal  Accionistas de EE.UU Mencionados*// 
   //public string  Nombre_1 {get;set;} 
   //public string  Direc_1{get;set;} 
   //public string  Tin1 {get;set;} 
   //public string  Nombre_2 {get;set;} 
   //public string  Direc_2{get;set;} 
   //public string  Tin2 {get;set;}
   //public string  Nombre_3 {get;set;} 
   //public string  Direc_3 {get;set;} 
   //public string  Tin3 {get;set;}
    
    		
        public ControllerUsuarioNatural() {
            
            //opciones=new List<SelectOption>();
            
			MostarGuardar=false;
            MostarActualizar=false;
          mensaje3='none';
           Cliente25 = new Account();
           // Cliente20 = new Pais_R__c();
          options=new List<SelectOption>();
          
              //Para productos y subproductos
            opcionPais=new List<SelectOption>();
            opcionDepartamento=new List<SelectOption>();
            llenarPais();
            llenarDepartamento();
            llenarMunicipio();
            llenarColonia();
            llenarNacionalidad();
            
			llenaTipoId();
           llenarDeligencia(); 
           llenaro();
           llenarNivelRiesgo();
           llenarInstitucionFinanciera();
            
            
            nivelRiesgo = '1'; 
            debidaDiligencviaAplicada = '3';
  			
		   despN = false;   
            disbot = true; 
           // llenarInfo();
     }
    /*
   public List<SelectOption> opciones {get;set;}
    
    public void llenarInfo()
    {try
        {  
            
            for (Tipo_listas__c item:[select Codigo__c, Nombre__c from Tipo_listas__c  where Codigo__c != null])
            {
                opciones.add(new selectOption(item.Codigo__c, item.Nombre__c));
            }
            //system.debug('ListaOpciones' + opciones);
		
        }catch(exception e){
            
        }
     }
    */
    public void llenarColonia(){
        try
        {
            paginacion = 0;
            listColonias = new list <Colonias_U__c>();
            listColonias = [select nombre_colonia__c, codigo_colonia__c from Colonias_U__c where codigo_pais__c =: pais 
                                     and codigo_departamento__c =: departamento and codigo_municipio__c =: municipio order by nombre_colonia__c asc];
            opcionColonia = new list <selectOption>();
            opcionColonia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            if(listColonias.size()>999)
            {
                paginacion++;
                mostrarBoton =  true;
                mostrarSiguiente = false;
                mostrarAnterior = true;
				 for (integer i=0; i< 999; i++)
                {
                    opcionColonia.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                }                
            }
            else{
                opcionColonia = new list <selectOption>();
                opcionColonia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Colonias_U__c item:[select nombre_colonia__c, codigo_colonia__c from Colonias_U__c where codigo_pais__c =: pais 
                                     and codigo_departamento__c =: departamento and codigo_municipio__c =: municipio order by nombre_colonia__c asc])
                {
                    opcionColonia.add(new selectOption(item.codigo_colonia__c, item.nombre_colonia__c));
                }
            }
            
           
        }catch(exception e){
            
        }
    }
    
    public void siguiente(){
        try{
            if (listColonias.size()> ((paginacion + 1)*1000) )
            {
                opcionColonia = new list <selectOption>();
            	opcionColonia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                 for (integer i=1000; i< 1999; i++)
                {
                    opcionColonia.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                }    
            }
            else{
                 opcionColonia = new list <selectOption>();
                mostrarSiguiente=true;
                mostrarAnterior = false;
            	opcionColonia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                 for (integer i=1000; i< listColonias.size(); i++)
                {
                    opcionColonia.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                }    
            }
            
        }
        catch(exception e){
            
        }
    }
    
    public void anterior()
    {
        try 
        {
            
            if((paginacion - 1)*1000 < 1000)
            {
                mostrarsiguiente=false;
                mostrarAnterior=true;
                opcionColonia = new list<selectOption>();
                for(integer i=0; i<1000; i++)
                {
                    opcionColonia.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                } 
                paginacion --;
            }
            else
            {
                opcionColonia = new list<selectOption>();
               for(integer i=(paginacion - 2)*100; i<(paginacion-1) *100; i++)
                {
                    opcionColonia.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                }  
                paginacion --;
                 mostrarSiguiente=false;
            }
        }
        catch(Exception ex)
        {
            
        }
    }
    
    public void llenarMunicipio(){
        try
        {
            opcionMunicipio = new list <selectOption>();
            opcionMunicipio.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Municipio__c item:[select nombre_municipio__c, codigo_municipio__c from Municipio__c where codigo_pais__c =: pais and 	codigo_departamento__c =: departamento])
            {
                opcionMunicipio.add(new selectOption(item.codigo_municipio__c, item.nombre_municipio__c));
            }
        }catch(exception e){
            
        }
    }
    
    public void llenarDepartamento(){
        try
        {
            opcionDepartamento = new list <selectOption>();
            opcionDepartamento.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Departamentos__c item:[select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: pais])
            {
                opcionDepartamento.add(new selectOption(item.codigo_departamento__c, item.Departamento__c));
            }
        }catch(exception e){
            
        }
    }
        
    public void llenarPais(){
        try
        {   opcionPais.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Pais_R__c item:[select nombre__c, codigo__c from Pais_R__c])
            {
                opcionPais.add(new selectOption(item.codigo__c, item.nombre__c));
            }
        }catch(exception e){
            
        }
    }
    
    public void llenarNacionalidad(){
        try
        {   opcionNacionalidad = new list <selectOption>();
            opcionNacionalidad.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Pais_R__c item:[select nacionalidad__c, codigo__c from Pais_R__c where codigo__c =: pais])
            {
                opcionNacionalidad.add(new selectOption(item.codigo__c, item.nacionalidad__c));
            }
        }catch(exception e){
            
        }
    }
    
       public void desUn()
      {
                despN = true;
      }
       public void contrUn()
      {
                despN = false;
      }

    public void mostPop(){
        actPop = true; 
    }
/*boton*/
    public void desBtn(){
        disbot = true; 
        limpiar(); 
    }    
        public void hidePop(){
        limpiar(); 
        actPop = false; 
    }
    
            //*********************¿Es una Entidad o Institución Financiera?***********************************
    		public void llenarInstitucionFinanciera(){
      String[] InstitucionFinanciera = new String[]{'NINGUNO','SI','NO'};
			this.InstitucionFinancieraOptions = new SelectOption[]{};
			for (String c: InstitucionFinanciera) {
			this.InstitucionFinancieraOptions.add(new SelectOption(c,c));
										}     
    }
    
    public void bloqPep(){
        dispep = true; 
        nivelRiesgo = '3'; 
        debidaDiligencviaAplicada = '3'; 
    }
        public void unblock(){
        dispep = false; 
        nivelRiesgo = '1'; 
        debidaDiligencviaAplicada = '2'; 
    }
    
    public SelectOption[] InstitucionFinancieraOptions
    { 
		public get;
		private set;
	}
    
    //*********************Deligencia ***********************************
    public void llenarDeligencia(){
		   this.DeligenciaOptions = new SelectOption[]{};
           this.DeligenciaOptions.add(new SelectOption('0','NINGUNA'));                                                                       
           this.DeligenciaOptions.add(new SelectOption('1','SIMPLIFICADA'));
           this.DeligenciaOptions.add(new SelectOption('2','NORMAL'));
           this.DeligenciaOptions.add(new SelectOption('3','INCREMENTADA'));
    }
    
    public SelectOption[] DeligenciaOptions
    { 
		public get;
		private set;
	}
    

    public void mostrarModal()
    {
        despN=true;
    }
	public void limpiar(){
	    	tipoUsuarioNatural = null;
            PEP = null;
            AML = null;
            FATCA = null;
            despN = null;
            tipoId = null; 
            numeroId = null;
            primerNombre = null;
            segundoNombre = null;
            primerApellido = null;
            segundoApellido = null;
            fechaNacimiento = null; 
        fechaNacimiento2 = null;
            nacionalidad = null;
            telefono = null;
            pais = null;
            colonia = null;
            departamento = null;
            municipio = null;
            noDomicilio = null;
            calleDetalle = null;
            procedenciaFondos = null;
            nivelRiesgo = null;
            debidaDiligencviaAplicada = null;
            numeroIdentificacion = null;
            numeroCuenta = null;
            nombreCompleto = null;
            usuarioIndividualSelec = null;
        	desCheckb = null; 
        	dispep = null; 
    }
	
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
    
    public void guardar(){
        try{
            
            classUsuarioNatural claseEnvio = new classUsuarioNatural();
           
           
             if(AML == true)
             {
                 claseEnvio.AML = 'S';
             }
            else
            {
                claseEnvio.AML = 'N';
            }

            if(PEP == true)
             {
                 claseEnvio.PEP = 'S';
             }
            else
            {
                claseEnvio.PEP = 'N';
            }
            
            if(FATCA == true)
             {
                 claseEnvio.FATCA = 'S';
             }
            else
            {
                claseEnvio.FATCA = 'N';
            }
             
            claseEnvio.tipoUsuarioNatural = tipoUsuarioNatural;
            claseEnvio.nivelRiesgo = nivelRiesgo;
            claseEnvio.tipoId = tipoId;
            claseEnvio.numeroId = numeroId;       
            claseEnvio.primerNombre = primerNombre.toUpperCase();
            claseEnvio.segundoNombre = segundoNombre.toUpperCase();
            claseEnvio.primerApellido = primerApellido.toUpperCase();
            claseEnvio.segundoApellido = segundoApellido.toUpperCase();
            claseEnvio.nacionalidad = nacionalidad.toUpperCase();
        	claseEnvio.telefono = telefono;
            claseEnvio.pais = pais.toUpperCase();
            claseEnvio.colonia = colonia.toUpperCase();
            claseEnvio.debidaDiligencviaAplicada = debidaDiligencviaAplicada;
            claseEnvio.departamento = departamento.toUpperCase();
            claseEnvio.municipio = municipio.toUpperCase();
            claseEnvio.noDomicilio = noDomicilio;
            claseEnvio.procedenciaFondos = procedenciaFondos.toUpperCase();
            claseEnvio.numeroIdentificacion = numeroIdentificacion;
            claseEnvio.numeroCuenta = numeroCuenta;
            claseEnvio.nombreCompleto = nombreCompleto.toUpperCase();  
            claseEnvio.calleDetalle=calleDetalle.toUpperCase();
			claseEnvio.fechaNacimiento=fechaNacimiento2;            
          
			String resultado = controllerApiUsuarioNatural.estadoCuentaCorreo(claseEnvio);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'USUARIO NATURAL AGREGADO'/*+ resultado*/));	
            limpiar();
        }Catch(Exception e){
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));	    
        }
    }
    
    
    public void buscar(){
       try{
            string temporal = numeroId;
            classUsuarioNatural claseEnvio = new classUsuarioNatural();
            classUsuarioNatural fcsd = controllerApiUsuarioNatural.BuscarUsuarioNatural(numeroId);
           
            if(fcsd.primerNombre != 'null')
           {
               
			tipoUsuarioNatural = fcsd.tipoUsuarioNatural;
            tipoId = fcsd.tipoId;
            primerNombre =fcsd.primerNombre;
            if(fcsd.segundoNombre != 'null')
			{
            	segundoNombre = fcsd.segundoNombre;    
            }
            primerApellido = fcsd.primerApellido;
            if(fcsd.segundoApellido != 'null')
            {
              segundoApellido = fcsd.segundoApellido;  
            }
            
            system.debug(fcsd.fechaNacimiento);
           // fechaNacimiento = fcsd.fechaNacimiento;
       
               
               
            nacionalidad = fcsd.nacionalidad;
           	IF (fcsd.PEP =='S')
            {
                PEP = TRUE;
            }

            numeroId = fcsd.numeroId;
               
            if(fcsd.fechaNacimiento!=null)
                {
                    fechaNacimiento2=date.valueOf(fcsd.fechaNacimiento.year()+'-'+fcsd.fechaNacimiento.month()+'-'+fcsd.fechaNacimiento.day());
                }   
            telefono = fcsd.telefono;
            pais =fcsd.pais ;
            colonia = fcsd.colonia;
            departamento = fcsd.departamento;
            municipio = fcsd.municipio;
            noDomicilio = fcsd.noDomicilio;
            calleDetalle =fcsd.calleDetalle;
            procedenciaFondos = fcsd.procedenciaFondos;
            nivelRiesgo = fcsd.nivelRiesgo;
            debidaDiligencviaAplicada = fcsd.debidaDiligencviaAplicada; 
            if(fcsd.numeroIdentificacion != 'null')
            {
              numeroIdentificacion = fcsd.numeroIdentificacion;  
            }
            if(fcsd.numeroCuenta != 'null')
            {
              numeroCuenta = fcsd.numeroCuenta;  
            }
            if(fcsd.nombreCompleto != 'null')
            {
              nombreCompleto = fcsd.nombreCompleto;  
            }
          	numeroId = temporal;	
           }else{
           		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no encontrado'));	    
           }	
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    } 
    public void validar(){
       try{
            
            classListas claseEnvio = new classListas();
            classListas fcsd = controllerApiUsuarioNatural.consultaListas(numeroId);
           if(numeroId==''){
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Nro ID Vacio'));	
           }else{
           
               system.debug(fcsd.FATCA);
            
               if(fcsd.PEP == true){
           	PEP = fcsd.PEP;
                   nivelRiesgo = '3';
                   }
               if(fcsd.AML == true){
            AML = fcsd.AML;
               }
               if(fcsd.BLACKLIST == true){
               AML = fcsd.BLACKLIST;
              actPop = true; 
               }
               if(fcsd.FATCA == true ){
            FATCA = fcsd.FATCA;
               }
               
            if(fcsd.PEP == true || fcsd.AML == true || fcsd.FATCA == true){
                    desCheckb = true; 
            }
           
           /*if(fcsd.FATCA == true){
               despN = true;   
           }*/
           if(fcsd.PEP == true){
               dispep = true;   
           }
           if(fcsd.AML == true){
              actPop = true; 
           }
           disbot = false; 
               }
			//String resultado = controllerApiUsuarioNatural.BuscarUsuarioNatural(claseEnvio);
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,resultado));
	
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se encontró Cliente'));	    
        }
    }
    
    public void cancelar(){
       limpiar();
    }

    //*********************Llenar Nivel de Riesgo ***********************************
    public void llenarNivelRiesgo(){

                this.NivelRiesgoOptions = new SelectOption[]{};
        	    //this.NivelRiesgoOptions.add(new SelectOption('','NINGUNO'));
                this.NivelRiesgoOptions.add(new SelectOption('1','BAJO'));
        		this.NivelRiesgoOptions.add(new SelectOption('4','MODERADO'));
                this.NivelRiesgoOptions.add(new SelectOption('2','MEDIO'));
                this.NivelRiesgoOptions.add(new SelectOption('3','ALTO'));
    }
    
    public SelectOption[] NivelRiesgoOptions
    { 
		public get;
		private set;
	}
   	    
    //*********************Llenar Nivel de Riesgo***********************************
    		public void llenaro(){

                this.NiveloOptions = new SelectOption[]{};
        	    this.NiveloOptions.add(new SelectOption('','NINGUNO'));
                this.NiveloOptions.add(new SelectOption('1','SOCIO'));
                this.NiveloOptions.add(new SelectOption('2','BENEFICIARIO'));             
    }
    
    public SelectOption[] NiveloOptions
    {
		public get;
		private set;
	}
}