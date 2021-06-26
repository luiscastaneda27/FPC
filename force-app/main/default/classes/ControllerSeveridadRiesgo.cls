public without sharing class ControllerSeveridadRiesgo {
    public string usuario {get;set;}  /*usuario*/
    public string NivelRiesgo {get;set;}  
    public Decimal CodRiesgo {get;set;}  
    public Decimal Porcentaje_Inicial {get;set;}  
    public Decimal Porcentaje_Final {get;set;} 
    public Decimal RiesgoPonderacion {get;set;} 
    public string usuarioM {get;set;}   
    
    public List<SelectOption> opcionNivelRiesgo {get;set;}
   // public List<SelectOption> opciones {get;set;}
    public Matriz_Riesgo__c TipNivel{get;set;} 
    public PreVenta__c Agencia{get;set;} 
    public Account Profesion{get;set;}   
    public List<SelectOption> opcionDepartamento {get;set;} 
    public List<SelectOption> opcionNacionalidad {get;set;} 
    
    //VARIABLES PARA EL PORCENTAJE DE RIESGO
    public String RiesgoTipoCliente {get;set;}
    public String RiesgoTipoPersona {get;set;}
    public String RiesgoTipoDocumento {get;set;}
    public String RiesgoFechaAfiliacion {get;set;}
    public String RiesgoFechaNacimiento {get;set;}
    public String RiesgoTrabaja {get;set;}
    public String RiesgoOcupacion {get;set;}
    public String RiesgoListaExcepciones {get;set;}
    public String RiesgoListaPep {get;set;}
    public String Riesgoproducto {get;set;}
    public String Riesgocanal {get;set;}
    public String RiesgoMunicipalidad {get;set;}
    public String RiesgoNacionalidad {get;set;}
    //JR
    public String RiesgoFechaConstitucion {get;set;}
    public String RiesgoGiroEmpresa {get;set;}
    public String RiesgoUbicacionEmpresa {get;set;}
    
    //Total
    public decimal TotalRiesgoCliente {get;set;}
    public decimal TotalRiesgoRamo {get;set;}
    public decimal TotalRiesgoCanal {get;set;}
    public decimal TotalRiesgoGeografico {get;set;}
    public decimal NivelRiesgoTotal {get;set;}
    
    //VARIABLES PARA EL PORCENTAJE DE RIESGO
    public String ValorRiesgoTipoCliente {get;set;}
    public String ValorRiesgoTipoPersona {get;set;}
    public String ValorRiesgoTipoDocumento {get;set;}
    public String ValorRiesgoFechaAfiliacion {get;set;}
    public String ValorRiesgoFechaNacimiento {get;set;}
    public String ValorRiesgoTrabaja {get;set;}
    public String ValorRiesgoOcupacion {get;set;}
    public String ValorRiesgoListaExcepciones {get;set;}
    public String ValorRiesgoListaPep {get;set;} 
    //public Integer RiesgocuentaCliente {get;set;}   
    public String ValorRiesgoproducto {get;set;}
    //public Integer Riesgocomercializacion {get;set;}
    public String ValorRiesgocanal {get;set;}
    public String ValorRiesgoMunicipalidad {get;set;}
    public String ValorRiesgoNacionalidad {get;set;}
    
    //JR
    public String ValorRiesgoFechaConstitucion {get;set;}
    public String ValorRiesgoGiroEmpresa {get;set;}
    public String ValorRiesgoUbicacionEmpresa {get;set;}
    
    //Tipo de cliente
    public String TipoClienteNJ {get;set;}
    
    //TIPO CLIENTE
    public string TipoCliente {get;set;} 
    public string NivelRiesgoCliente {get;set;} 
    public string Descripcion_TC { get; set; }
    
    //TIPO PERSONA
    public string TipoPersona {get;set;} 
    public string RiesgoPersona {get;set;}  
    public string Descripcion_TP { get; set; }
    
    //FECHA NACIMIENTO
    public string CodFechaNacimiento {get;set;} 
    public string RiesgoFechaNac {get;set;} 
    public string Descripcion_FN { get; set; }
    
    //FECHA AFILIA
    public string CodFechaAfilia {get;set;} 
    public string RiesgoFechaAfilia {get;set;} 
    public string Descripcion_FA { get; set; }
    
    //TIPO_DOC
    public string TipoDoc {get;set;} 
    public string Descripcion_TD { get; set; }
    public string RiesgoTD {get;set;}  
    
    //TRABAJA
    public string Trabaja {get;set;} 
    public string RiesgoTra {get;set;}  
    
    //PEP
    public string PEP {get;set;} 
    public string RiesgoPep {get;set;}        
    
    //EXCEP
    public string EsExcep {get;set;} 
    public string RiesgoExcep {get;set;}        
    
    //PRODUCTO
    public string TipoProducto {get;set;} 
    public string RieProducto {get;set;}     
    public string RieProducto1 {get;set;}     
    //public string DescripcionProducto {get;set;}     
  
    //CANAL
    public string TipoCanal {get;set;} 
    public string RieCanal {get;set;}   
    
    //PROFESION
    public string TipoProfesion {get;set;} 
    public string RieProfesion {get;set;}   
    
    //ACt
    public string TipoActividad {get;set;} 
    public string RieActividad {get;set;}  
    
    //Fecha Constitución
    public string CodFechaConstitu {get;set;} 
    public string RieConstitucion {get;set;}   
    
    //GEOGRAFICO
    public string CodDepto {get;set;} 
    public string codNacionalidad {get;set;}   
    public string RiesDepto {get;set;} 
    public string RiesNacionalidad {get;set;}   
    
    public string Cod_Riesgo { get; set; }
    public string Factor { get; set; }
    public string Descrip_Factor { get; set;}
    public string Pond_Nat { get; set; }
    public string Pond_Jur { get; set; }
    public string Val_Nat { get; set; }
    public string Val_Jur { get; set; }
    
    public ControllerSeveridadRiesgo() 
    {	
        TipNivel = new Matriz_Riesgo__c();
        opcionNivelRiesgo = new List<SelectOption>();  
        //usuario = ApexPages.currentPage().getParameters().get('hytrd'); 
        //usuarioM = ApexPages.currentPage().getParameters().get('hytrd'); 
        usuario = 'HN24633';
        usuarioM = usuario;       
        Profesion = new Account();
        Agencia = new PreVenta__c();
        
        opcionDepartamento = new list <selectOption>();
        opcionNacionalidad = new list <selectOption>();
        llenarDepartamento();
        llenarNacionalidad(); 
    
        
    }
    
    public void BuscaRiesgo()
    {
         
        try{	
             decimal prueba;
            ClaseNivelDeRiesgo NivelDeRiesgo= new ClaseNivelDeRiesgo();
            NivelDeRiesgo.CodRiesgo= Decimal.valueOf(TipNivel.NivelRiesgo__c);
            prueba= NivelDeRiesgo.CodRiesgo;
            ClaseNivelDeRiesgo fcsd = controllerApiMatrizdeRiesgo.ConsultaNivelDRiesgo(prueba);
            
            if( TipNivel.NivelRiesgo__c == null || test.isRunningTest())
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Nivel de Riesgo'));
                //return null;    
            }           
           
            system.debug('RespuestarNIVEL: '+fcsd +fcsd.NivelRiesgo );
                
            if (fcsd.NivelRiesgo != 'null') 
            {          
                if(fcsd.NivelRiesgo != 'null')
                {
                    NivelRiesgo = fcsd.NivelRiesgo;
                }
                
                if (fcsd.Porcentaje_Inicial != 0)
                {
                    Porcentaje_Inicial = fcsd.Porcentaje_Inicial;
                }
                if (fcsd.Porcentaje_Final != 0)
                {
                    Porcentaje_Final = fcsd.Porcentaje_Final;
                }
                if (fcsd.RiesgoPonderacion != 0)
                {
                    RiesgoPonderacion = fcsd.RiesgoPonderacion;
                }
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Riesgo No Encontrado'));	    
            }  
            limpiar1();
            system.debug('NIVEL: ' + prueba ); 
      
        }
        Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
       // return null;
    }    
    
     public void BuscaFactor()
    {
         
        try{	
            string prueba;
            FactorClase Factores= new FactorClase();
            Factores.Cod_Riesgo= TipNivel.Factor_Variables__c;
            prueba= Factores.Cod_Riesgo;
            FactorClase fcsd = controllerApiMatrizdeRiesgo.ConsultaFactor(prueba);
            
            if( TipNivel.Factor_Variables__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione Factor'));
                //return null;    
            }
            
            
            
            system.debug('RespuestarNIVEL: '+fcsd +fcsd.Factor );
                
            if (fcsd.Factor != 'null') 
            {          
                if(fcsd.Factor != 'null')
                {
                    Factor = fcsd.Factor;
                }
                if(fcsd.Descrip_Factor != 'null')
                {
                    Descrip_Factor = fcsd.Descrip_Factor;
                }                
                if (fcsd.Pond_Nat != 'null')
                {
                    Pond_Nat = fcsd.Pond_Nat;
                }
                if (fcsd.Pond_Jur != 'null')
                {
                    Pond_Jur = fcsd.Pond_Jur;
                }
                if (fcsd.Val_Nat != 'null')
                {
                    Val_Nat = fcsd.Val_Nat;
                }
                if (fcsd.Val_Jur != 'null')
                {
                    Val_Jur = fcsd.Val_Jur;
                }
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Riesgo No Encontrado'));	    
            }  
            limpiar1();
            system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
       // return null;
    }    
    
    //BUSCA TIPO DE CLIENTE 
    public void BuscaTipCl()
    {
        
        try{	     
            string prueba;
            ClaseTipoCliente TipoDeCliente= new ClaseTipoCliente();
            TipoDeCliente.TipoCliente= TipNivel.Tipo_Cliente__c;
            prueba= TipoDeCliente.TipoCliente;
            ClaseTipoCliente fcsd = controllerApiMatrizdeRiesgo.ConsultaTipoCliente(prueba);
            
            if( TipNivel.Tipo_Cliente__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Tipo Cliente'));
               // return null;    
            }
            
            
                         
            if (fcsd.TipoCliente != 'null')
            {          
                if(fcsd.TipoCliente != 'null')
                {
                    TipoCliente = fcsd.TipoCliente;
                }
                if(fcsd.NivelRiesgoCliente != 'null')
                {
                    NivelRiesgoCliente = fcsd.NivelRiesgoCliente;
                }
                if(fcsd.Descripcion_TC != 'null')
                {
                    Descripcion_TC = FCSD.Descripcion_TC;
                }
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tipo Cliente No Encontrado'));	    
            }  
            limpiar1();
            system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
       // return null;
    }    
    
     //BUSCA TIPO DE PERSONA
    public void BuscaTipPer()
    {
        
        try{	     
             string prueba;
            ClaseTipoPersona TipoDePersona= new ClaseTipoPersona();
            TipoDePersona.TipoPersona= TipNivel.Tipo_Persona__c;
            prueba= TipoDePersona.TipoPersona;
            ClaseTipoPersona fcsd = controllerApiMatrizdeRiesgo.ConsultaTipoPersona(prueba);
            
            if( TipNivel.Tipo_Persona__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Tipo Persona'));
                //return null;    
            }
            
           
                         
            if (fcsd.TipoPersona != 'null')
            {          
                if(fcsd.TipoPersona != 'null')
                {
                    TipoPersona = fcsd.TipoPersona;
                }
                if(fcsd.RiesgoPersona != 'null')
                {
                    RiesgoPersona = fcsd.RiesgoPersona;
                }
                if(fcsd.Descripcion_TP != 'null')
                {
                    Descripcion_TP = fcsd.Descripcion_TP;
                }
                
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tipo Persona No Encontrado'));	    
            }  
            limpiar1();
            system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
        //return null;
    }    
    
    //BUSCA FECHA NAC
    public void BuscaFecNac()
    {
        
        try{	
            string prueba;
            ClaseFechaNac FechaNac= new ClaseFechaNac();
            FechaNac.CodFechaNacimiento = TipNivel.Fecha_Nacimiento__c;
            prueba= FechaNac.CodFechaNacimiento;
            ClaseFechaNac fcsd = controllerApiMatrizdeRiesgo.ConsultaFechaNac(prueba);
            
            if( TipNivel.Fecha_Nacimiento__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione Fecha'));
                //return null;    
            }
            
          
                         
            if (fcsd.CodFechaNacimiento != 'null')
            {          
                if(fcsd.CodFechaNacimiento != 'null')
                {
                    CodFechaNacimiento = fcsd.CodFechaNacimiento;
                }
                if(fcsd.RiesgoFechaNac != 'null')
                {
                    RiesgoFechaNac = fcsd.RiesgoFechaNac;
                }
                if(fcsd.Descripcion_FN != 'null')
                {
                    Descripcion_FN = fcsd.Descripcion_FN;
                }
                
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Fecha No Encontrado'));	    
            }  
            limpiar1();
            system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
      //  return null;
    }    
    
    //BUSCA FECHA NAC
    public void BuscaFecAfilia()
    {
        
        try{	     
            string prueba;
            ClaseFechaAfilia FechaAfilia= new ClaseFechaAfilia();
            FechaAfilia.CodFechaAfilia = TipNivel.Fecha_Afilia__c;
            prueba= FechaAfilia.CodFechaAfilia;
            ClaseFechaAfilia fcsd = controllerApiMatrizdeRiesgo.ConsultaFechaAfilia(prueba);

            
            if( TipNivel.Fecha_Afilia__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione Fecha'));
                //return null;    
            }
            
                                     
            if (fcsd.CodFechaAfilia != 'null')
            {          
                if(fcsd.CodFechaAfilia != 'null')
                {
                    CodFechaAfilia = fcsd.CodFechaAfilia;
                }
                if(fcsd.RiesgoFechaAfilia != 'null')
                {
                    RiesgoFechaAfilia = fcsd.RiesgoFechaAfilia;
                }
                if(fcsd.Descripcion_FA != 'null')
                {
                    Descripcion_FA = fcsd.Descripcion_FA;
                }
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Fecha No Encontrado'));	    
            }  
            limpiar1();
            system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
      //  return null;
    }    
    
    //BUSCA TIPO DOC
    public void BuscaTipDoc()
    {
        
        try{	
            string prueba;
            ClaseTipDoc TipDocum= new ClaseTipDoc();
            TipDocum.TipoDoc = TipNivel.Tipo_Documento__c;
            prueba= TipDocum.TipoDoc;
            ClaseTipDoc fcsd = controllerApiMatrizdeRiesgo.ConsultaTipDoc(prueba);
            
            if( TipNivel.Tipo_Documento__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione Tipo Documento'));
               // return null;    
            }
            
           
                         
            if (fcsd.TipoDoc != 'null')
            {          
                if(fcsd.TipoDoc != 'null')
                {
                    TipoDoc = fcsd.TipoDoc;
                }
                if(fcsd.Descripcion_TD != 'null')
                {
                    Descripcion_TD = fcsd.Descripcion_TD;
                }
                if(fcsd.RiesgoTD != 'null')
                {
                    RiesgoTD = fcsd.RiesgoTD;
                }
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tipo Documento No Encontrado'));	    
            }  
            limpiar1();
            system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
        //return null;
    }    
    
    //BUSCA TIPO TRABAJA
    public void BuscaTrabaja()
    {
        
        try{	
            string prueba;
            ClaseTrabaja Trab= new ClaseTrabaja();
            Trab.Trabaja = TipNivel.Riesgo_Trabaja__c;
            prueba= Trab.Trabaja;
            ClaseTrabaja fcsd = controllerApiMatrizdeRiesgo.ConsultaTrabaja(prueba);
            
            if( TipNivel.Riesgo_Trabaja__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione Si trabaja o no'));
              //  return null;    
            }
            
                         
            if (fcsd.Trabaja != 'null')
            {          
                if(fcsd.Trabaja != 'null')
                {
                    Trabaja = fcsd.Trabaja;
                }
                if(fcsd.RiesgoTra != 'null')
                {
                    RiesgoTra = fcsd.RiesgoTra;
                }
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Dato no encontrado'));	    
            }  
            limpiar1();
            system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
        //return null;
    }    
    //BUSCA TIPO PEP
    public void BuscaPep()
    {
        
        try{
            string prueba;
            ClasePep esPep= new ClasePep();
            esPep.PEP = TipNivel.Riesgo_Pep__c;
            prueba= esPep.PEP;
            ClasePep fcsd = controllerApiMatrizdeRiesgo.ConsultaPep(prueba);
            
            if( TipNivel.Riesgo_Pep__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione Si es PEP o no'));
                //return null;    
            }
            
            
                         
            if (fcsd.PEP != 'null')
            {          
                if(fcsd.PEP != 'null')
                {
                    PEP = fcsd.PEP;
                }
                if(fcsd.RiesgoPep != 'null')
                {
                    RiesgoPep = fcsd.RiesgoPep;
                }
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Dato no encontrado'));	    
            }  
            limpiar1();
            system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
        //return null;
    }    
    //BUSCA EXCC
    public void BuscaExc()
    {
        
        try{	     
             string prueba;
            ClaseExcepciones ListaExc= new ClaseExcepciones();
            ListaExc.EsExcep = TipNivel.Riesgo_Exc__c;
            prueba= ListaExc.EsExcep;
            ClaseExcepciones fcsd = controllerApiMatrizdeRiesgo.ConsultaExcep(prueba);
            
            if( TipNivel.Riesgo_Exc__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione Si o No en Excepciones'));
               // return null;    
            }
            
                                    
            if (fcsd.EsExcep != 'null')
            {          
                if(fcsd.EsExcep != 'null')
                {
                    EsExcep = fcsd.EsExcep;
                }
                if(fcsd.RiesgoExcep != 'null')
                {
                    RiesgoExcep = fcsd.RiesgoExcep;
                }
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Dato no encontrado'));	    
            }  
            limpiar1();
            system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
        //return null;
    }    
    //PRODUCTO
    public void BuscaProdNat()
    {
        
        try{	
            string prueba;
            ClaseRiesgoProducto ListaProd= new ClaseRiesgoProducto();
            ListaProd.TipoProducto = TipNivel.Riesgo_ProductoNat__c;
            prueba= ListaProd.TipoProducto;
            ClaseRiesgoProducto fcsd = controllerApiMatrizdeRiesgo.ConsultaProducto(prueba);
            
            if( TipNivel.Riesgo_ProductoNat__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione Tipo de Producto'));
                //return null;    
            }
                        
            
                         
            if (fcsd.TipoProducto != 'null')
            {          
                if(fcsd.TipoProducto != 'null')
                {
                    TipoProducto = fcsd.TipoProducto;
                }
                if(fcsd.RieProducto != 'null')
                {
                    RieProducto = fcsd.RieProducto;
                }
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Dato no encontrado'));	    
            }  
            limpiar1();
            system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
        //return null;
    }    
    
    //PRODUCTO
    public void BuscaProdJur()
    {
        
        try{	
             string prueba;
            ClaseRiesgoProducto ListaProd= new ClaseRiesgoProducto();
            ListaProd.TipoProducto = TipNivel.Riesgo_ProdJur__c;
            prueba= ListaProd.TipoProducto;
            ClaseRiesgoProducto fcsd = controllerApiMatrizdeRiesgo.ConsultaProducto(prueba);
            
            if( TipNivel.Riesgo_ProdJur__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione Tipo de Producto'));
                //return null;    
            }
                        
           
                         
            if (fcsd.TipoProducto != 'null')
            {          
                if(fcsd.TipoProducto != 'null')
                {
                    TipoProducto = fcsd.TipoProducto;
                }
                if(fcsd.RieProducto != 'null')
                {
                    RieProducto1 = fcsd.RieProducto;
                }
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Dato no encontrado'));	    
            }  
            limpiar1();
            system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
        //return null;
    }    
    
    
    public void BuscaCanal()
    {
        
        try{	     
            string prueba;
            ClaseRiesgoCanal ListaCanal= new ClaseRiesgoCanal();
            ListaCanal.TipoCanal = Agencia.Agencia_Refiere__c;
            prueba= ListaCanal.TipoCanal;
            ClaseRiesgoCanal fcsd = controllerApiMatrizdeRiesgo.ConsultaCanal(prueba);
                         
            if( Agencia.Agencia_Refiere__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione Tipo de Canal'));
                //return null;    
            }
                       
            
            if (fcsd.TipoCanal != 'null')
            {          
                if(fcsd.TipoCanal != 'null')
                {
                    TipoCanal = fcsd.TipoCanal;
                }
                if(fcsd.RieCanal != 'null')
                {
                    RieCanal = fcsd.RieCanal;
                }
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Dato no encontrado'));	    
            }  
            limpiar1();
            system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
        //return null;
    }    
    
    public void BuscaProfesion()
    {
        
        try{	  
             string prueba;
            ClaseRiesgoProfesion ListaProfesion= new ClaseRiesgoProfesion();
            ListaProfesion.TipoProfesion = Profesion.Profesi_n_Ocupaci_n__c;
            prueba= ListaProfesion.TipoProfesion;
            ClaseRiesgoProfesion fcsd = controllerApiMatrizdeRiesgo.ConsultaProfesion(prueba);
            
            if( Profesion.Profesi_n_Ocupaci_n__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione Profesión'));
                //return null;    
            }
            
            
           
            
            if (fcsd.TipoProfesion != 'null')
            {          
                if(fcsd.TipoProfesion != 'null')
                {
                    TipoProfesion = fcsd.TipoProfesion;
                }
                if(fcsd.RieProfesion != 'null')
                {
                    RieProfesion = fcsd.RieProfesion;
                }
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Dato no encontrado'));	    
            }  
            limpiar1();
            system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
       // return null;
    }   
    
    public void BuscaActEco()
    {
        
        try{	
             string prueba;
            ClaseRiesgoActEcon ListaActividad= new ClaseRiesgoActEcon();
            ListaActividad.TipoActividad = Profesion.Sector__c;
            prueba= ListaActividad.TipoActividad;
            ClaseRiesgoActEcon fcsd = controllerApiMatrizdeRiesgo.ConsultaActEcono(prueba);
            
            if( Profesion.Sector__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione Actividad Econ.'));
               // return null;    
            }
            
            if (fcsd.TipoActividad != 'null')
            {          
                if(fcsd.TipoActividad != 'null')
                {
                    TipoActividad = fcsd.TipoActividad;
                }
                if(fcsd.RieActividad != 'null')
                {
                    RieActividad = fcsd.RieActividad;
                }
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Dato no encontrado'));	    
            }  
            limpiar1();
            system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
        //return null;
    }   
    
    public void BuscaFechConst()
    {
        
        try{	
            string prueba;
            ClaseFechaConsti ListaFechaConst= new ClaseFechaConsti();
            ListaFechaConst.CodFechaConstitu = TipNivel.Fecha_Constitucion__c;
           // prueba= ListaFechaConst.CodFechaConstitu;
            ClaseFechaConsti fcsd = controllerApiMatrizdeRiesgo.ConsultaFechaConst(ListaFechaConst.CodFechaConstitu);
            
            if( TipNivel.Fecha_Constitucion__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione Fecha de Constitución.'));
               // return null;    
            }
                        
            if (fcsd.CodFechaConstitu != 'null')
            {          
                if(fcsd.CodFechaConstitu != 'null')
                {
                    CodFechaConstitu = fcsd.CodFechaConstitu;
                }
                if(fcsd.RieConstitucion != 'null')
                {
                    RieConstitucion = fcsd.RieConstitucion;
                }
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Dato no encontrado'));	    
            }  
            limpiar1();
            system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
        //return null;
    }   
    
    public void llenarDepartamento()
    {
       
        try
        {           
            opcionDepartamento = new list <selectOption>();
            opcionDepartamento.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Departamentos__c item:[select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: '074'])
            {
                opcionDepartamento.add(new selectOption(item.codigo_departamento__c, item.Departamento__c));
                
            }
           
        }catch(exception e){
            
        }
    }
    
    public void llenarNacionalidad()
    {
        try
        {   
            opcionNacionalidad = new list <selectOption>();
            opcionNacionalidad.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Pais_R__c item:[select nacionalidad__c, codigo__c from Pais_R__c where nacionalidad__c != ''])
            {
                opcionNacionalidad.add(new selectOption(item.codigo__c, item.nacionalidad__c));                
            }
            
        }catch(exception e){
            
        }
    }
    
    public void BuscaGeograf()
    {
        
        try{	
            codNacionalidad = null;
            if( codDepto == ' --Ninguno-- ')
            {       
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione Departamento'));
              //  return null;  
                
            }
            else if( codDepto == ' --Ninguno-- ')
            {       
                 codDepto = null;
                
            }
            ClaseRiesgoGeografico ListaGeografica= new ClaseRiesgoGeografico();            
            ClaseRiesgoGeografico fcsd = controllerApiMatrizdeRiesgo.ConsultaRiesgoGeo(CodDepto, '0');
            
                    
            system.debug('Respuestaaaaaaa: '+fcsd);
            if (fcsd.CodDepto != 'null')
            {          
                
                if(fcsd.CodDepto != 'null')
                {
                    fcsd.CodDepto = fcsd.CodDepto;
                }
                if(fcsd.RiesDepto != 'null')
                {
                    RiesDepto = fcsd.RiesDepto;
                }
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Dato no encontrado'));	    
            }  
            limpiar1();
            //system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
        //return null;
    }   
    
     public void BuscaGeograNac()
    {
        
        try{	
            
            if(codNacionalidad == ' --Ninguno-- ')
            {       
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione Nacionalidad'));
                //return null;  
                
            }     
                           
            else if( codNacionalidad == ' --Ninguno-- ')
            {       
                 codNacionalidad = null;
                
            }
            codDepto = null;
            ClaseRiesgoGeografico ListaGeografica= new ClaseRiesgoGeografico();            
            ClaseRiesgoGeografico fcsd = controllerApiMatrizdeRiesgo.ConsultaRiesgoGeo('0', codNacionalidad);
            
                    
            system.debug('Respuestaaaaaaa: '+fcsd);
            if (fcsd.CodDepto != 'null')
            {          
                
             /*   if(fcsd.CodDepto != 'null')
                {
                    fcsd.CodDepto = fcsd.CodDepto;
                }
                if(fcsd.RiesDepto != 'null')
                {
                    RiesDepto = fcsd.RiesDepto;
                }*/
                if(fcsd.codNacionalidad != ' --Ninguno-- ' )
                {
                    fcsd.codNacionalidad = fcsd.codNacionalidad;
                }
                if(fcsd.RiesNacionalidad != 'null')
                {
                    RiesNacionalidad = fcsd.RiesNacionalidad; 
                }
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Dato no encontrado'));	    
            }  
            limpiar1();
            //system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
       // return null;
    }   
 /*   
    public pageReference BuscaVariablesFactor()
    {
        
        try{	     
            if( TipNivel.Factor_Variables__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione Tipo de Cliente'));
                return null;    
            }
                        
            string prueba;
            claseFactoresDeRiesgo ListaFactor = new claseFactoresDeRiesgo();
            ListaFactor.TipoCliente = TipNivel.Factor_Variables__c;
            prueba= ListaFactor.TipoCliente;
            claseFactoresDeRiesgo fcsd = controllerApiMatrizdeRiesgo.ConsultaVariablesFactor(prueba);
                         
                      
                if(fcsd.TipoCliente != 'null') 
                {
                    TipoCliente = fcsd.TipoCliente;
                    
                    if(fcsd.RiesgoTipoCliente != null ||fcsd.ValorRiesgoTipoCliente != null)
                    {
                        RiesgoTipoCliente = fcsd.RiesgoTipoCliente;
                        ValorRiesgoTipoCliente = fcsd.ValorRiesgoTipoCliente;
                    }
                    if(fcsd.RiesgoTipoPersona != null ||fcsd.ValorRiesgoTipoPersona != null)
                    {
                        RiesgoTipoPersona = fcsd.RiesgoTipoPersona;
                        ValorRiesgoTipoPersona = fcsd.ValorRiesgoTipoPersona;
                    }
                    if(fcsd.RiesgoTipoDocumento != null ||fcsd.ValorRiesgoTipoDocumento != null)
                    {
                        RiesgoTipoDocumento = fcsd.RiesgoTipoDocumento;
                        ValorRiesgoTipoDocumento = fcsd.ValorRiesgoTipoDocumento;
                    }
                    if(fcsd.RiesgoFechaAfiliacion != null ||fcsd.ValorRiesgoFechaAfiliacion != null)
                    {
                        RiesgoFechaAfiliacion = fcsd.RiesgoFechaAfiliacion;
                        ValorRiesgoFechaAfiliacion = fcsd.ValorRiesgoFechaAfiliacion;
                    }
                    if(fcsd.RiesgoFechaNacimiento != null ||fcsd.ValorRiesgoFechaNacimiento != null)
                    {
                        RiesgoFechaNacimiento = fcsd.RiesgoFechaNacimiento;
                        ValorRiesgoFechaNacimiento = fcsd.ValorRiesgoFechaNacimiento;
                    }
                    if(fcsd.RiesgoTrabaja != null ||fcsd.ValorRiesgoTrabaja != null)
                    {
                        RiesgoTrabaja = fcsd.RiesgoTrabaja;
                        ValorRiesgoTrabaja = fcsd.ValorRiesgoTrabaja;
                    }

                    if(fcsd.RiesgoOcupacion != null ||fcsd.ValorRiesgoOcupacion != null)
                    {
                        RiesgoOcupacion = fcsd.RiesgoOcupacion;
                        ValorRiesgoOcupacion = fcsd.ValorRiesgoOcupacion;
                    }

                    if(fcsd.RiesgoListaExcepciones != null ||fcsd.ValorRiesgoListaExcepciones != null)
                    {
                        RiesgoListaExcepciones = fcsd.RiesgoListaExcepciones;
                        ValorRiesgoListaExcepciones = fcsd.ValorRiesgoListaExcepciones;
                    }

                    if(fcsd.RiesgoListaPep != null ||fcsd.ValorRiesgoListaPep != null)
                    {
                        RiesgoListaPep = fcsd.RiesgoListaPep;
                        ValorRiesgoListaPep = fcsd.ValorRiesgoListaPep;
                    }
                    if(fcsd.Riesgoproducto != null ||fcsd.ValorRiesgoproducto != null)
                    {
                        Riesgoproducto = fcsd.Riesgoproducto;
                        ValorRiesgoproducto = fcsd.ValorRiesgoproducto;
                    }
                    if(fcsd.Riesgocanal != null ||fcsd.ValorRiesgocanal != null)
                    {
                        Riesgocanal = fcsd.Riesgocanal;
                        ValorRiesgocanal = fcsd.ValorRiesgocanal;
                    }
                    if(fcsd.RiesgoMunicipalidad != null ||fcsd.ValorRiesgoMunicipalidad != null)
                    {
                        RiesgoMunicipalidad = fcsd.RiesgoMunicipalidad;
                        ValorRiesgoMunicipalidad = fcsd.ValorRiesgoMunicipalidad;
                    }
                    
                    //JR
                    if(fcsd.RiesgoFechaConstitucion != null ||fcsd.ValorRiesgoFechaConstitucion != null)
                    {
                        RiesgoFechaConstitucion = fcsd.RiesgoFechaConstitucion;
                        ValorRiesgoFechaConstitucion = fcsd.ValorRiesgoFechaConstitucion;
                    }
                    
                    if(fcsd.RiesgoGiroEmpresa != null ||fcsd.ValorRiesgoGiroEmpresa != null)
                    {
                        RiesgoGiroEmpresa = fcsd.RiesgoGiroEmpresa;
                        ValorRiesgoGiroEmpresa = fcsd.ValorRiesgoGiroEmpresa;
                    }
                    
                    if(fcsd.RiesgoNacionalidad != null ||fcsd.ValorRiesgoNacionalidad != null)
                    {
                        RiesgoNacionalidad = fcsd.RiesgoNacionalidad;
                        ValorRiesgoNacionalidad = fcsd.ValorRiesgoNacionalidad;
                    }
                    
                    if(fcsd.RiesgoUbicacionEmpresa != null ||fcsd.ValorRiesgoUbicacionEmpresa != null)
                    {
                        RiesgoUbicacionEmpresa = fcsd.RiesgoUbicacionEmpresa;
                        ValorRiesgoUbicacionEmpresa = fcsd.ValorRiesgoUbicacionEmpresa;
                    }
                    

                    
                }   
            else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Dato no encontrado'));	    
            }  
            system.debug('NIVEL: ' + prueba ); 
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	              
        }
        return null;
    }           */ 
   
    public void actualizarRiesgo()
    {
        try{
            
            classActualizaNivelRiesgo naturalEnvio = new classActualizaNivelRiesgo();  
            
            string guarda;
            guarda = TipNivel.NivelRiesgo__c;
            naturalEnvio.CodRiesgo = decimal.valueof(guarda);
            naturalEnvio.NivelRiesgo = NivelRiesgo;
            naturalEnvio.Porcentaje_Inicial = Porcentaje_Inicial;
            naturalEnvio.Porcentaje_Final = Porcentaje_Final;
            naturalEnvio.RiesgoPonderacion = RiesgoPonderacion;
            naturalEnvio.usuarioM = usuarioM;
            
            system.debug('ELCODIGOACT: ' + guarda+ ' ' + NivelRiesgo +' ' + Porcentaje_Inicial +' ' + Porcentaje_Final +' ' + RiesgoPonderacion +' '+ usuarioM);
            
            if( NivelRiesgo == ''|| NivelRiesgo == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Nombre del Riesgo'));
                //return null;    
            }   
            if( Porcentaje_Inicial == 0 || Porcentaje_Inicial == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Porcentaje Inicial Vacío'));
               // return null;    
            }   
            if( Porcentaje_Final == 0 || Porcentaje_Final == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Porcentaje Final Vacío'));
               //return null;    
            }   
            if( RiesgoPonderacion == 0 || RiesgoPonderacion == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ponderación Riesgo Vacío'));
                //return null;    
            }    
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.ActualizaNivelDRiesgo(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        //return null;
    }
    
    public void actualizaFactor()
    {
        try{
            
            ClassActualizaFactor naturalEnvio = new ClassActualizaFactor();  
            
            string guarda;
            guarda = TipNivel.Factor_Variables__c;
            naturalEnvio.Cod_Riesgo = guarda;
            naturalEnvio.Factor = Factor;
            naturalEnvio.Descrip_Factor = Descrip_Factor;
            naturalEnvio.Pond_Nat = Pond_Nat;
            naturalEnvio.Pond_Jur = Pond_Jur;
            naturalEnvio.Val_Nat = Val_Nat;
            naturalEnvio.Val_Jur = Val_Jur;
            naturalEnvio.usuarioM = usuarioM;            
            
          /*  if( Cod_Riesgo == ''|| Cod_Riesgo == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Código Relacionado al Riesgo'));
                return null;    
            }   */
            if( Factor == '' || Factor == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Variable'));
                //return null;    
            }   
            if( Descrip_Factor == '' || Descrip_Factor == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Porcentaje Final Vacío'));
                //return null;    
            }   
            if( Pond_Nat == '' && Pond_Jur == '')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ponderación Natural/Juridica'));
                //return null;    
            }    
             
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.ActualizaFactor(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        //return null;
    }
    
    public void actualizarRiesgoCliente()
    {
        try{
            
            classActualizaTipoCliente naturalEnvio = new classActualizaTipoCliente();  
            
            string guarda;
            guarda = TipNivel.Tipo_Cliente__c;
            naturalEnvio.TipoCliente = guarda;
            naturalEnvio.NivelRiesgoCliente = NivelRiesgoCliente;
            naturalEnvio.usuarioM = usuarioM;
            
            if( NivelRiesgoCliente == '' || NivelRiesgoCliente == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Riesgo Cliente Vacío'));
               // return null;    
            }      
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.ActualizaTipoCliente(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                //limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        //return null;
    }
    
    public pageReference actualizarRiesgoPersona()
    {
        try{
            
            classActualizaTipoPersona EnvioPersona = new classActualizaTipoPersona();  
            
            //string guarda;
            //guarda = TipNivel.Tipo_Persona__c;
            EnvioPersona.TipoPersona = TipNivel.Tipo_Persona__c;
            EnvioPersona.RiesgoPersona = RiesgoPersona;
            EnvioPersona.usuarioM = usuarioM;
            
            if( RiesgoPersona == '' || RiesgoPersona == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Riesgo Persona Vacío'));
                return null;    
            }      
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.ActualizaTipoPersona(EnvioPersona);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                //limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        return null;
    }
    
    public void actualizarFechaNac()
    {
        try{
            
            classActualizaFechaNac EnvioPersona = new classActualizaFechaNac();  
            
            //string guarda;
            //guarda = TipNivel.Tipo_Persona__c;
            EnvioPersona.CodFechaNacimiento = TipNivel.Fecha_Nacimiento__c;
            EnvioPersona.RiesgoFechaNac = RiesgoFechaNac;
            EnvioPersona.usuarioM = usuarioM;
            
            if( RiesgoFechaNac == '' || RiesgoFechaNac == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Riesgo Fecha Nacimiento Vacío'));
                //return null;    
            }      
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.ActualizaFechaNac(EnvioPersona);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                //limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        //return null;
    }
    
    public void actualizarFechaAfilia()
    {
        try{
            
            classActualizaFechaAfilia EnvioPersona = new classActualizaFechaAfilia();              
            
            EnvioPersona.CodFechaAfilia = TipNivel.Fecha_Afilia__c;
            EnvioPersona.RiesgoFechaAfilia = RiesgoFechaAfilia;
            EnvioPersona.usuarioM = usuarioM;
            
            if( RiesgoFechaAfilia == '' || RiesgoFechaAfilia == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Riesgo Fecha Afilia Vacío'));
                //return null;    
            }      
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.ActualizaFechaAfilia(EnvioPersona);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                //limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        //return null;
    }

	public void actualizarTipDoc()
    {
        try{
            
            classActualizaTipDoc EnvioPersona = new classActualizaTipDoc();              
            
            EnvioPersona.TipoDoc = TipNivel.Tipo_Documento__c;
            EnvioPersona.RiesgoTD = RiesgoTD;
            EnvioPersona.usuarioM = usuarioM;
            
            if( RiesgoTD == '' || RiesgoTD == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Riesgo Fecha Afilia Vacío'));
                //return null;    
            }      
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.ActualizaTipoDoc(EnvioPersona);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                //limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        //return null;
    }
    
    public pageReference actualizarRiesgoTrabaja()
    {
        try{
            
            classActualizaTrabaja naturalEnvio = new classActualizaTrabaja();  
            
          	naturalEnvio.Trabaja = TipNivel.Riesgo_Trabaja__c;
            naturalEnvio.RiesgoTra = RiesgoTra;
            naturalEnvio.usuarioM = usuarioM;
            
            //system.debug('ELCODIGOACT: ' + guarda+ ' ' + NivelRiesgo +' ' + Porcentaje_Inicial +' ' + Porcentaje_Final +' ' + RiesgoPonderacion +' '+ usuarioM);
            
            if( RiesgoTra == ''|| RiesgoTra == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Riesgo Trabajo'));
                return null;    
            }       
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.ActualizaRiesTrabaja(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        return null;
    }
    
    public pageReference actualizarRiesgoPep()
    {
        try{
            
            classActualizaPep naturalEnvio = new classActualizaPep();  
            
          	naturalEnvio.PEP = TipNivel.Riesgo_Pep__c;
            naturalEnvio.RiesgoPep = RiesgoPep;
            naturalEnvio.usuarioM = usuarioM;
            
                        
            if( RiesgoPep == ''|| RiesgoPep == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Riesgo Pep'));
                return null;    
            }       
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.ActualizaRiesPep(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        return null;
    }
    
    public pageReference actualizarRiesgoExcep()
    {
        try{
            
            classActualizaExcep naturalEnvio = new classActualizaExcep();  
            
          	naturalEnvio.EsExcep = TipNivel.Riesgo_Exc__c;
            naturalEnvio.RiesgoExcep = RiesgoExcep;
            naturalEnvio.usuarioM = usuarioM;
            
                        
            if( RiesgoExcep == ''|| RiesgoExcep == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Riesgo Excepciones'));
                return null;    
            }       
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.actualizaExcep(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        return null;
    }
    
    public pageReference actualizarRiesgoProdN()
    {
        try{
            
            classActualizaProducto naturalEnvio = new classActualizaProducto();  
            
          	naturalEnvio.TipoProducto = TipNivel.Riesgo_ProductoNat__c;
            naturalEnvio.RieProducto = RieProducto;
            naturalEnvio.usuarioM = usuarioM;
            
                        
            if( RieProducto == ''|| RieProducto == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Riesgo Producto Natural'));
                return null;    
            }       
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.actualizaProducto(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        return null;
    }
    
    public pageReference actualizarRiesgoProdJ()
    {
        try{
            
            classActualizaProducto naturalEnvio = new classActualizaProducto();  
            
          	naturalEnvio.TipoProducto = TipNivel.Riesgo_ProdJur__c;
            naturalEnvio.RieProducto = RieProducto1;
            naturalEnvio.usuarioM = usuarioM;
            
                        
            if( RieProducto1 == ''|| RieProducto1 == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Riesgo Producto Juridico'));
                return null;    
            }       
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.actualizaProducto(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        return null;
    }
    
    public pageReference actualizarRiesgoCanal()
    {
        try{
            
            classActualizaCanal naturalEnvio = new classActualizaCanal();  
            
          	naturalEnvio.TipoCanal = Agencia.Agencia_Refiere__c;
            naturalEnvio.RieCanal = RieCanal;
            naturalEnvio.usuarioM = usuarioM;
            
                        
            if( RieCanal == ''|| RieCanal == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Riesgo Agencia'));
                return null;    
            }       
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.actualizaCanal(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        return null;
    }
    
    public pageReference actualizarRiesgoProfesion()
    {
        try{
            
            classActualizaProfesion naturalEnvio = new classActualizaProfesion();  
            
          	naturalEnvio.TipoProfesion = Profesion.Profesi_n_Ocupaci_n__c;
            naturalEnvio.RieProfesion = RieProfesion;
            naturalEnvio.usuarioM = usuarioM;
            
                        
            if( RieProfesion == ''|| RieProfesion == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Riesgo Profesion'));
                return null;    
            }       
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.actualizaProfesion(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        return null;
    }
    
    public pageReference actualizarRiesgoActEcon()
    {
        try{
            
            classActualizaActEcon naturalEnvio = new classActualizaActEcon();  
            
          	naturalEnvio.TipoActividad = Profesion.Profesi_n_Ocupaci_n__c;
            naturalEnvio.RieActividad = RieActividad;
            naturalEnvio.usuarioM = usuarioM;
            
                        
            if( RieActividad == ''|| RieActividad == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Riesgo Actividad'));
                return null;    
            }       
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.actualizaActEcon(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        return null;
    }
    
    public pageReference actualizarFechaCosnt()
    {
        try{
            
            classActualizaFechaConsti naturalEnvio = new classActualizaFechaConsti();  
            
          	naturalEnvio.CodFechaConstitu = TipNivel.Fecha_Constitucion__c;
            naturalEnvio.RieConstitucion = RieConstitucion;
            naturalEnvio.usuarioM = usuarioM;
            
                        
            if( RieConstitucion == ''|| RieConstitucion == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Riesgo Fecha'));
                return null;    
            }       
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.actualizaFechaCons(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        return null;
    }
    
    public pageReference actualizaRiesgoDepto()
    {
        try{
            
            if( codDepto == ' --Ninguno-- ')
            {       
                codDepto = null;
                
            }
            
            
            ClassActualizaRiesgoGeo naturalEnvio = new ClassActualizaRiesgoGeo();             
          	naturalEnvio.CodDepto = CodDepto;
            naturalEnvio.codNacionalidad = null;
            naturalEnvio.RiesDepto = RiesDepto;
            naturalEnvio.RiesNacionalidad = null;
            naturalEnvio.usuarioM = usuarioM;
                        
           //if(CodDepto != null ){                
                if( RiesDepto == ''|| RiesDepto == null )
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Riesgo Depto'));
                    return null;    
                }                 
         //  }   
           
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.actualizaGeogra(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        return null;
    }
    
    public void actualizaRiesgoNac()
    {
        try{
            
            if( codNacionalidad == ' --Ninguno-- ')
            {       
                codNacionalidad = null;
                
            }
            
            
            ClassActualizaRiesgoGeo naturalEnvio = new ClassActualizaRiesgoGeo();             
          	naturalEnvio.CodDepto = null;
            naturalEnvio.codNacionalidad = codNacionalidad;
            naturalEnvio.RiesDepto = null;
            naturalEnvio.RiesNacionalidad = RiesNacionalidad;
            naturalEnvio.usuarioM = usuarioM;                        
                     
                if( RiesNacionalidad == ''|| RiesNacionalidad == null )
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Riesgo Nacionalidad'));
                    //return null;    
                }    
           
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.actualizaGeogra(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        //return null;
    }
    
    public void actualizarFactorRiesgo()
    {
        try{
            
            classActualizaNivelRiesgo naturalEnvio = new classActualizaNivelRiesgo();  
            
            string guarda;
            guarda = TipNivel.NivelRiesgo__c;
            naturalEnvio.CodRiesgo = decimal.valueof(guarda);
            naturalEnvio.NivelRiesgo = NivelRiesgo;
            naturalEnvio.Porcentaje_Inicial = Porcentaje_Inicial;
            naturalEnvio.Porcentaje_Final = Porcentaje_Final;
            naturalEnvio.RiesgoPonderacion = RiesgoPonderacion;
            naturalEnvio.usuarioM = usuarioM;
            
            system.debug('ELCODIGOACT: ' + guarda+ ' ' + NivelRiesgo +' ' + Porcentaje_Inicial +' ' + Porcentaje_Final +' ' + RiesgoPonderacion +' '+ usuarioM);
            
            if( NivelRiesgo == ''|| NivelRiesgo == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Nivel de Riesgo'));
                //return null;    
            }   
            if( Porcentaje_Inicial == 0 || Porcentaje_Inicial == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Porcentaje Inicial Vacío'));
                //return null;    
            }   
            if( Porcentaje_Final == 0 || Porcentaje_Final == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Porcentaje Final Vacío'));
                //return null;    
            }   
            if( RiesgoPonderacion == 0 || RiesgoPonderacion == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Nivel de Riesgo Vacío'));
                //return null;    
            }    
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.ActualizaNivelDRiesgo(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                limpiar1();
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        //return null;
    }
    
    public pageReference actualizaVariablesFactor()
    {
        try{
            
            controllerActualizaVarFactor naturalEnvio = new controllerActualizaVarFactor();  
            
            //IF()
          	naturalEnvio.TipoCliente = TipNivel.Factor_Variables__c;
            naturalEnvio.RiesgoTipoCliente = RiesgoTipoCliente;
            naturalEnvio.RiesgoTipoPersona = RiesgoTipoPersona;
            naturalEnvio.RiesgoTipoDocumento = RiesgoTipoDocumento;
            naturalEnvio.RiesgoFechaAfiliacion = RiesgoFechaAfiliacion;
            naturalEnvio.RiesgoFechaNacimiento = RiesgoFechaNacimiento;
            naturalEnvio.RiesgoTrabaja = RiesgoTrabaja;
            naturalEnvio.RiesgoOcupacion = RiesgoOcupacion;
            naturalEnvio.RiesgoListaExcepciones = RiesgoListaExcepciones;
            naturalEnvio.RiesgoListaPep = RiesgoListaPep;
            naturalEnvio.Riesgoproducto = Riesgoproducto;
            naturalEnvio.Riesgocanal = Riesgocanal;
            naturalEnvio.RiesgoMunicipalidad = RiesgoMunicipalidad;
            naturalEnvio.RiesgoNacionalidad = RiesgoNacionalidad;
            naturalEnvio.RiesgoFechaConstitucion = RiesgoFechaConstitucion;
            naturalEnvio.RiesgoGiroEmpresa = RiesgoGiroEmpresa;
            naturalEnvio.RiesgoUbicacionEmpresa = RiesgoUbicacionEmpresa;
            naturalEnvio.ValorRiesgoTipoCliente = ValorRiesgoTipoCliente;
            naturalEnvio.ValorRiesgoTipoPersona = ValorRiesgoTipoPersona;            
            naturalEnvio.ValorRiesgoTipoDocumento = ValorRiesgoTipoDocumento;
            naturalEnvio.ValorRiesgoFechaAfiliacion = ValorRiesgoFechaAfiliacion;
            naturalEnvio.ValorRiesgoFechaNacimiento = ValorRiesgoFechaNacimiento;
            naturalEnvio.ValorRiesgoTrabaja = ValorRiesgoTrabaja;
            naturalEnvio.ValorRiesgoOcupacion = ValorRiesgoOcupacion;
            naturalEnvio.ValorRiesgoListaExcepciones = ValorRiesgoListaExcepciones;
            naturalEnvio.ValorRiesgoListaPep = ValorRiesgoListaPep;
            naturalEnvio.ValorRiesgoproducto = ValorRiesgoproducto;
            naturalEnvio.ValorRiesgocanal = ValorRiesgocanal;
            naturalEnvio.ValorRiesgoMunicipalidad = ValorRiesgoMunicipalidad;
            naturalEnvio.ValorRiesgoNacionalidad = ValorRiesgoNacionalidad;
            naturalEnvio.ValorRiesgoFechaConstitucion = ValorRiesgoFechaConstitucion;
            naturalEnvio.ValorRiesgoGiroEmpresa = ValorRiesgoGiroEmpresa;
            naturalEnvio.ValorRiesgoUbicacionEmpresa = ValorRiesgoUbicacionEmpresa;
            naturalEnvio.usuarioM = usuarioM;            
                        
           
                String resultado = controllerApiMatrizdeRiesgo.actualizaVariablesFactor(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                system.debug('estoes '+resultado);
                limpiar1();
           
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
        return null;
    }    
    
    public void EnviaMR(){
       try{
            
            ClassInsertaNivelDeRiesgo naturalEnvio = new ClassInsertaNivelDeRiesgo();  
            
            //string guarda;
            //guarda = TipNivel.NivelRiesgo__c;
            //naturalEnvio.CodRiesgo = decimal.valueof(guarda);
            naturalEnvio.NivelRiesgo = NivelRiesgo;
            naturalEnvio.Porcentaje_Inicial = Porcentaje_Inicial;
            naturalEnvio.Porcentaje_Final = Porcentaje_Final;
            naturalEnvio.RiesgoPonderacion = RiesgoPonderacion;
            naturalEnvio.usuario = usuario;
            
            system.debug('ELCODIGOACT: '  + NivelRiesgo +' ' + Porcentaje_Inicial +' ' + Porcentaje_Final +' ' + RiesgoPonderacion +' '+ usuario);
            
            if( NivelRiesgo == ''|| NivelRiesgo == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Nivel de Riesgo'));
               // return null;    
            }   
            if( Porcentaje_Inicial == 0 || Porcentaje_Inicial == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Porcentaje Inicial Vacío'));
                //return null;    
            }   
            if( Porcentaje_Final == 0 || Porcentaje_Final == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Porcentaje Final Vacío'));
               // return null;    
            }   
            if( RiesgoPonderacion == 0 || RiesgoPonderacion == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Nivel de Riesgo Vacío'));
                //return null;    
            }    
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.InsertaNivelDRiesgo(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                limpiar1();
                system.debug('estoes '+resultado);
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
       // return null;
           
    }    
    
    public void EnviaFactor(){
       try{
            
            FactorClase naturalEnvio = new FactorClase();  
            
            //string guarda;
            //guarda = TipNivel.NivelRiesgo__c;
            //naturalEnvio.CodRiesgo = decimal.valueof(guarda);
            naturalEnvio.Cod_Riesgo = Cod_Riesgo;
            naturalEnvio.Factor = Factor;
            naturalEnvio.Descrip_Factor = Descrip_Factor;
            naturalEnvio.Pond_Nat = Pond_Nat;
            naturalEnvio.Val_Nat = Val_Nat;
            naturalEnvio.Pond_Jur = Pond_Jur;
            naturalEnvio.Val_Jur = Val_Jur;
            naturalEnvio.usuario = usuario;            
           
            if( Cod_Riesgo == ''|| Cod_Riesgo == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ingresar Código Asignado'));
                //return null;    
            }   
            if( Factor == '' || Factor == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Factor de riesgo Vacío'));
                //return null;    
            }   
            if( Descrip_Factor == '' || Descrip_Factor == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Descripción Factor vacío'));
               // return null;    
            }   
           if( Pond_Nat == '' && Pond_Jur == '')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Favor Ingresar ponderación'));
                //return null;    
            }   
           if( Val_Nat == '' && Val_Jur == '')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Favor Ingresar Valor Máximo'));
               // return null;    
            }   
            else
            { 
                String resultado = controllerApiMatrizdeRiesgo.InsertaFactor(naturalEnvio);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                limpiar();
                limpiar1();
                system.debug('estoes '+resultado);
            }  
        } 
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));   
           
        }
      //  return null;
           
    }    
    
    
    public void limpiar()
    {
    TipNivel.NivelRiesgo__c = null;
    NivelRiesgo = null;
    Porcentaje_Inicial = null;
    Porcentaje_Final = null;
    RiesgoPonderacion = null; 
        limpiar1();
    }
    
     public void limpiar1()
    {
       
  //VARIABLES PARA EL PORCENTAJE DE RIESGO
     RiesgoTipoCliente = null;
     RiesgoTipoPersona = null;
     RiesgoTipoDocumento = null;
     RiesgoFechaAfiliacion = null;
     RiesgoFechaNacimiento = null;
     RiesgoTrabaja = null;
     RiesgoOcupacion = null;
     RiesgoListaExcepciones = null;
     RiesgoListaPep = null;
     Riesgoproducto = null;
     Riesgocanal = null;
     RiesgoMunicipalidad = null;
     RiesgoNacionalidad = null;
    
    //Total
     TotalRiesgoCliente = null;
     TotalRiesgoRamo = null;
     TotalRiesgoCanal = null;
     TotalRiesgoGeografico = null;
     NivelRiesgoTotal = null;
    
    //VARIABLES PARA EL PORCENTAJE DE RIESGO
     ValorRiesgoTipoCliente = null;
     ValorRiesgoTipoPersona = null;
     ValorRiesgoTipoDocumento = null;
     ValorRiesgoFechaAfiliacion = null;
     ValorRiesgoFechaNacimiento = null;
     ValorRiesgoTrabaja = null;
     ValorRiesgoOcupacion = null;
     ValorRiesgoListaExcepciones = null;
     ValorRiesgoListaPep = null; 
     ValorRiesgoproducto = null;
     ValorRiesgocanal = null;
     ValorRiesgoMunicipalidad = null;
     ValorRiesgoNacionalidad = null;   
    }
}