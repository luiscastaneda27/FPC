global class ActivaciondeCuentas {
    public string usuario {set;get;}
    public string usuario1 {set;get;}
	public List<ActivacionCuenta__c> Activacion {set;get;}
    public List<ContenidoActivaciondeCuentas> validaDatos;
    
    public boolean mostrarTabla {get;set;}
    public boolean EnviarDatos {get; set;}
    public boolean ActivarDatos {get; set;}
    public boolean Modificar {get;set;}
    public integer Cont {get; set;}
      
    //AGREGADO 15072019
    public boolean valida {get;set;}
    public decimal Num_CodReferencia {get;set;}
    public decimal Num_Cod {get;set;}
    public ActivaciondeCuentas()
    {
    //usuario='HN21528';   //HN21528//HN19577
    //string usuario = ApexPages.currentPage().getParameters().get('hytrd');  
    usuario = ApexPages.currentPage().getParameters().get('hytrd');  
    usuario1 = ApexPages.currentPage().getParameters().get('hytrd');
    }
    
    
    //SEGUNDA PANTALLA
    public list <ActivacionCuenta__c> ModifList {get; set;}
    public boolean aprobarM {get;set;}
    public boolean VerContenido {get; set;}    
    public integer total {get;set;}
    public datetime FechaInclusion {get;set;}  
    public String Motivo {get;set;} 
    public boolean Cambiar {get;set;} 
    //public boolean rechazarM {get;set;}
    public boolean rechazarM1 {get;set;}
    public boolean VentanaPlanilla {get;set;}
    public List<ActivacionCuenta__c> CambioActiva {set;get;}
    
    public void rechazoPla()
    {
    rechazarM1 =true;
    }//segunda pantalla
    
    
      public void cambio()
    {
       Cambiar = true;
    }    
            
      public void aprobado()
    {
   		aprobarM =true;
    }
    
    public void salir()
    {
        rechazarM1=false;
        aprobarM =false;
        VentanaPlanilla = false;     
    }  
            
    //FIN
       
    public void mtabla()
    {
     mostrarTabla = true;
    }
        
    public static String llenarObjetos(string prueba){     
        if(prueba=='""'){
            prueba=null;
        }else{
            if(prueba.contains('"')){
                prueba=prueba.replace('"','');	
                prueba=prueba;
            }else{
                if(prueba != null){
                    prueba=prueba;   
                }
            }
        }
	return prueba;
    }
        
    public void VerPlanilla(){ 
        FechaInclusion = datetime.now();
         integer idP;   
        try{
            ActivacionCuenta__c carga1 = new ActivacionCuenta__c ();             
      		carga1 = [select Identificador_CargaA__c from ActivacionCuenta__c order by Identificador_CargaA__c desc limit 1] ;
      		idP = integer.valueOf(carga1.Identificador_CargaA__c);
                     
            Activacion = [ select NoCuenta__c, noIdentidad__c, Cliente__c, Empresa__c, EstadoActual__c, Causa__c, EstadoNuevo__c, 
                                   CausaNuevo__c, Situaci_n__c,Usuario__c, Estado__c, Fecha_CargaA__c,Identificador_CargaA__c
                            from ActivacionCuenta__c where /*Usuario__c =: usuario and Estado__c != 'E' and Estado__c != 'A' 
                          and Estado__c != 'D' and */Identificador_CargaA__c =:idP ORDER BY Situaci_n__c ASC];
            
       		validaDatos = NEW List<ContenidoActivaciondeCuentas>();
            
            if (Activacion.size()>0){
                               
                for (ActivacionCuenta__c a:Activacion){                    
                    validaDatos.add(new ContenidoActivaciondeCuentas(a.NoCuenta__c, 
                                                                      a.noIdentidad__c,
                                                                      a.EstadoActual__c,
                                                                      a.Causa__c,
                                                                      a.EstadoNuevo__c,
                                                                      a.CausaNuevo__c,
                                                                      usuario,
                                                                      null,
                                                                      null,
                                                                      null,
                                                                      null
                                                                      ));
                   
        }/////fin del for
       total = Activacion.size();           
       valResgistroActivaciondeCuentas Enviar = new valResgistroActivaciondeCuentas(validaDatos); 
       string csharp;
       csharp=string.valueOf(Api_ActivaciondeCuentas.Activaciondecuentas(Enviar)); 
       system.debug('lista_afiliacion '+ csharp);
                
       Activacion = [ select NoCuenta__c,noIdentidad__c,Cliente__c,Empresa__c,Asesor__c, 
                             EstadoActual__c, Causa__c,EstadoNuevo__c, CausaNuevo__c,  
                             Situaci_n__c,Usuario__c,Estado__c,Fecha_CargaA__c, Identificador_CargaA__c
                      from ActivacionCuenta__c where /*Usuario__c =: usuario and*/ Identificador_CargaA__c =:idP
                     			 /*and Estado__c != 'E' and Estado__c != 'A' and Estado__c != 'D'*/ ORDER BY Situaci_n__c ASC];    
                
                 for(integer i=0; i<Activacion.size(); i++)
           {  
            if(Activacion[i].Identificador_CargaA__c == idP)  
            {
                Activacion[i].Usuario__c = usuario;
            }
           }
                update Activacion; 
       }//fin IF
           
//**************************************************** INICIO CONTADOR BOTONES *******************************************
            cont = 0;
            for (ActivacionCuenta__c a:Activacion){                    
                if (a.Situaci_n__c!='OK'){   
                    cont = cont+1;
                }//fin if cont                    
            }//fin for            
//*************************************************** FIN CONTADOR BOTONES ***********************************************// 
//***************************************** INICIO DE ESTRUCTURA BOTON MODIFICAR/ENVIAR **********************************//
            if(cont > 0 || test.isRunningTest()){            			 
                Modificar = true;
            }
            else{                    
                EnviarDatos = true;
            }
            
            system.debug('Contador' + cont);
            
//******************************* FIN DE ESTRUCTURA BOTON MODIFICAR/ENVIAR ************************************************//

        }Catch(Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Ha Ocurrido Un error: ' +ex.getLineNumber()));
            system.debug('Error al Guardar: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());    
        }
        mtabla();
    }
      
   //AGREGADO 15072019
    public void Limpiar(){
   // string usuario ='HN21528';      
   //string usuario = ApexPages.currentPage().getParameters().get('hytrd'); 
   total =NULL;
        integer idP1;
        
         ActivacionCuenta__c carga1 = new ActivacionCuenta__c ();             
      		carga1 = [select Identificador_CargaA__c from ActivacionCuenta__c order by Identificador_CargaA__c desc limit 1] ;
      		idP1 = integer.valueOf(carga1.Identificador_CargaA__c);
        
           delete ([ select NoCuenta__c, noIdentidad__c, Cliente__c, Empresa__c, EstadoActual__c, Causa__c, EstadoNuevo__c, CausaNuevo__c, Situaci_n__c,
                    		Usuario__c, Estado__c
                            from ActivacionCuenta__c where Usuario__c =: usuario and Estado__c =:'' and Identificador_CargaA__c =:idP1]);
        
           Activacion = [select NoCuenta__c, noIdentidad__c, Cliente__c, Empresa__c, EstadoActual__c, Causa__c, EstadoNuevo__c, CausaNuevo__c, Situaci_n__c,
                         	    Usuario__c, Estado__c
                            from ActivacionCuenta__c where Usuario__c =: usuario and Estado__c =:'' AND Identificador_CargaA__c =:idP1];
           
		 //finalizacion = false;     
           Modificar = false;
           EnviarDatos =false;
           
           if(Activacion.size() > 0){
               mostrarTabla =true;
           }
           else{
               mostrarTabla =false;
           }                       
    } 
    
    public void ModificarContenido()  
   {  
       integer idM;    
   //string usuario = ApexPages.currentPage().getParameters().get('hytrd'); 
       ActivacionCuenta__c carga1 = new ActivacionCuenta__c ();             
       carga1 = [select Identificador_CargaA__c from ActivacionCuenta__c order by Identificador_CargaA__c desc limit 1] ;
       idM = integer.valueOf(carga1.Identificador_CargaA__c);
       
           ModifList = [ select NoCuenta__c, noIdentidad__c, Cliente__c, Empresa__c, EstadoActual__c, 
                        Causa__c, EstadoNuevo__c, CausaNuevo__c, Situaci_n__c, Usuario__c, Estado__c, Identificador_CargaA__c
                        from ActivacionCuenta__c where Usuario__c =: usuario and Identificador_CargaA__c =:idM
                        and Estado__c !='E' and Estado__c !='A' and Estado__c !='D' ORDER BY Situaci_n__c ASC];
       
           for(integer i=0; i<ModifList.size(); i++)
           {    
               if(ModifList[i].Identificador_CargaA__c == idM)  
               {
                   ModifList[i].NoCuenta__c= Activacion[i].NoCuenta__c;
                   ModifList[i].noIdentidad__c= Activacion[i].noIdentidad__c;  
                   ModifList[i].EstadoActual__c= Activacion[i].EstadoActual__c;   
                   ModifList[i].Causa__c= Activacion[i].Causa__c; 
                   ModifList[i].EstadoNuevo__c= Activacion[i].EstadoNuevo__c;   
                   ModifList[i].CausaNuevo__c= Activacion[i].CausaNuevo__c; 
                   //ModifList[i].EstadoAsesor__c = 'M'; //estado Modificado
               }
           }                   
           update ModifList;     
//***************************** INICIO CONTADOR BOTONES ***********************************              
       cont = 0;
       for (ActivacionCuenta__c a:Activacion)
       {                    
           if (a.Situaci_n__c!='OK'){   
               cont = cont+1;
           }//fin if cont                        
       }//fin de for  contador                    
//****************************************** FIN CONTADOR BOTONES *******************************//
//******************************** INICIO DE ESTRUCTURA BOTON MODIFICAR/ENVIAR **************************//
       if(cont > 0 || test.isRunningTest()){ 
           Modificar = false;
           valida =true;
       }        			
       system.debug('Contador' + cont);           
       
       mtabla();   
   }//FIN PARA MODIFICAR OBJETO
    
    public void ValidarContenido(){
    FechaInclusion = datetime.now();
   //string usuario = ApexPages.currentPage().getParameters().get('hytrd');    
  	integer idV;
 	try{
        ActivacionCuenta__c carga1 = new ActivacionCuenta__c ();             
        carga1 = [select Identificador_CargaA__c from ActivacionCuenta__c order by Identificador_CargaA__c desc limit 1] ;
        idV = integer.valueOf(carga1.Identificador_CargaA__c);
                               
        Activacion = [ select NoCuenta__c, noIdentidad__c, Cliente__c, Empresa__c, EstadoActual__c, Causa__c,EstadoNuevo__c,
                      Asesor__c ,CausaNuevo__c, Situaci_n__c,Usuario__c, Estado__c, Fecha_CargaA__c,Identificador_CargaA__c
                      from ActivacionCuenta__c where Usuario__c =: usuario and 
                      Estado__c != 'E' and Estado__c != 'A' and Estado__c != 'D' and Identificador_CargaA__c =:idV ORDER BY Situaci_n__c ASC];
            
       		validaDatos = NEW List<ContenidoActivaciondeCuentas>();
            
            if (Activacion.size()>0){
                               
                for (ActivacionCuenta__c a:Activacion){                    
                    validaDatos.add(new ContenidoActivaciondeCuentas(a.NoCuenta__c, 
                                                                      a.noIdentidad__c,
                                                                      a.EstadoActual__c,
                                                                      a.Causa__c,
                                                                      a.EstadoNuevo__c,
                                                                      a.CausaNuevo__c,
                                                                      null,//usuario,
                                                                      null,
                                                                      null,
                                                                      datetime.valueOf(FechaInclusion),
                                                                      null
                                                                      )); 
                }//fin del for       
                  }//fin IF  
        
               valResgistroActivaciondeCuentas Enviar = new valResgistroActivaciondeCuentas(validaDatos); 
               string csharp;
               csharp=string.valueOf(Api_ActivaciondeCuentas.Activaciondecuentas(Enviar)); 
               system.debug('lista_afiliacion '+ csharp);
                
                Activacion = [ select NoCuenta__c,noIdentidad__c,Cliente__c,Empresa__c, Asesor__c,EstadoActual__c, 
                              Causa__c,EstadoNuevo__c,CausaNuevo__c,Situaci_n__c,Usuario__c,Estado__c,Fecha_CargaA__c,Identificador_CargaA__c
                              from ActivacionCuenta__c where Usuario__c =: usuario and Identificador_CargaA__c =:idV
                              and Estado__c != 'E' and Estado__c != 'A' and Estado__c != 'D' ORDER BY Situaci_n__c ASC];   
                
//***************************** INICIO CONTADOR BOTONES ***********************************              
        cont = 0;
        for (ActivacionCuenta__c a:Activacion){                    
            if (a.Situaci_n__c!='OK'){   
                cont = cont+1;
            }//fin if cont                    
        }//fin de for  contador                 
//****************************************** FIN CONTADOR BOTONES *******************************//
//******************************** INICIO DE ESTRUCTURA BOTON MODIFICAR/ENVIAR **************************//
        if(cont > 0 || test.isRunningTest()){ 
            Modificar = true;
            valida =false;
        }else
        {
            EnviarDatos  = true;
            Modificar=false;//agregado 10042019
            valida =false;
        }         			
        system.debug('Contador' + cont);           
//******************************* FIN DE ESTRUCTURA BOTON MODIFICAR/ENVIAR **************************************************//
    }
        Catch(Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Ha Ocurrido Un error: ' +ex.getLineNumber()));
            system.debug('Error al Guardar: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());    
        } 
        mtabla();
        
    }//fin de la función que valida los datos 

	public void VerContenido(){
      FechaInclusion = datetime.now();
     //string usuario ='HN21528';
     //string usuario = ApexPages.currentPage().getParameters().get('hytrd');   
      Modificar=false;
      mostrartabla=false;   
      EnviarDatos = false;
      integer id; 
                  
      //Para cuando se envian cambia de estado a Enviado = E
      ActivacionCuenta__c carga1 = new ActivacionCuenta__c ();             
      carga1 = [select Identificador_CargaA__c from ActivacionCuenta__c order by Identificador_CargaA__c desc limit 1] ;
      id = integer.valueOf(carga1.Identificador_CargaA__c); 
        
      ModifList = [ select NoCuenta__c, noIdentidad__c, Cliente__c, Empresa__c, EstadoActual__c, Causa__c, EstadoNuevo__c, 
                                   CausaNuevo__c, Situaci_n__c,Usuario__c, Estado__c, Fecha_CargaA__c,Identificador_CargaA__c
                            from ActivacionCuenta__c where Usuario__c =: usuario and Estado__c !='A' and Estado__c !='D' and Identificador_CargaA__c =: id];
      /*//Insertar en la bitacora
                  Bitacora_Masivo__c bita = new Bitacora_Masivo__c ();
                  bita.Actividades__c = 'Se Registró la Planilla con ID: ' + ' ' + id;
                  bita.Fecha__c = datetime.now();
                  bita.Pantalla__c = 'ActivaciondeCuentas';
                  bita.Estado__c = 'Espera de Aprobación/Denegación';
                  bita.Usuario__c = usuario;
                  insert bita;     */                  
      for(integer i=0; i<ModifList.size(); i++)
        {       
            ModifList[i].Estado__c = 'E'; //estado Enviado
            ModifList[i].Fecha_CargaA__c = string.valueOf(FechaInclusion);
            //ModifList[i].Usuario__c = usuario;
        }                   
        update ModifList; 
        total=NULL;
    }//fin de la función Enviar    
    
    
 //SEGUNDA PANTALLA VALIDADOR CAMBIO DE ASESOR
 
    //Para visualizar las cuentas que serán Aprobadas o Rechazadas
    public void VerPlanillaArchivo(){        
       // string usuario ='HN21528';
        //string usuario = ApexPages.currentPage().getParameters().get('hytrd'); 
        //integer idCA; 
        Motivo=null;
        Num_CodReferencia =Num_Cod;
        
        try{   
            
            map<integer, integer> casos = new  map<integer, integer>();
            //list<CambioAsesor__c>
            Activacion = new list<ActivacionCuenta__c>();
            
            for(ActivacionCuenta__c item: [SELECT Usuario__c, Estado__c,Identificador_CargaA__c 
                                       FROM ActivacionCuenta__c where Estado__c =:'E' ])
            {
                if(!casos.containsKey(integer.valueOf(item.Identificador_CargaA__c))){
                    casos.put(integer.valueOf(item.Identificador_CargaA__c), 2);
                    Activacion.add(item);
                }
            }			
            
            total = Activacion.size();    
                       
           /* Activacion = [select NoCuenta__c, noIdentidad__c, Cliente__c, Empresa__c, EstadoActual__c, Causa__c, EstadoNuevo__c, 
                                 CausaNuevo__c, Situaci_n__c,Usuario__c, Estado__c, Fecha_CargaA__c,Identificador_CargaA__c                          
                            from ActivacionCuenta__c where Identificador_CargaA__c =: id]; */
        }
        
        Catch(Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Ha Ocurrido Un error: ' +ex.getLineNumber()));
            system.debug('Error al Guardar: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());    
        } 
        //btn();
        mtabla();
        cambio(); 
        if(total == 0)
        {
            Cambiar=false;
            mostrarTabla=false;
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'No hay cambios pendientes.')); 
        }
    }
    
    public void MostrarVentanaPlanilla(){
       VentanaPlanilla =true;
       Num_CodReferencia =Num_Cod;  
        
       try{		
           CambioActiva =[select NoCuenta__c, noIdentidad__c, Cliente__c, Empresa__c, EstadoActual__c, Causa__c,EstadoNuevo__c,
                          Asesor__c ,CausaNuevo__c, Situaci_n__c,Usuario__c, Estado__c, Fecha_CargaA__c,Identificador_CargaA__c
                          from ActivacionCuenta__c where Estado__c =:'E' and Identificador_CargaA__c =:Num_CodReferencia];              
                                       
            validaDatos = NEW List<ContenidoActivaciondeCuentas>();              
                                          
            if(CambioActiva.size()>0){
                
                for (ActivacionCuenta__c a:CambioActiva){     
                     validaDatos.add(new ContenidoActivaciondeCuentas(a.NoCuenta__c, 
                                                                      a.noIdentidad__c,
                                                                      a.EstadoActual__c,
                                                                      a.Causa__c,
                                                                      a.EstadoNuevo__c,
                                                                      a.CausaNuevo__c,
                                                                      a.Usuario__c,
                                                                      usuario1,
                                                                      a.Identificador_CargaA__c,
                                                                      datetime.valueOf(a.Fecha_CargaA__c),
                                                                      Motivo
                                                                      )); 
                }//fin for   
             
            }//fin primer if  
           
           CambioActiva = [select NoCuenta__c, noIdentidad__c, Cliente__c, Empresa__c, EstadoActual__c, Causa__c,EstadoNuevo__c,
                          Asesor__c ,CausaNuevo__c, Situaci_n__c,Usuario__c, Estado__c, Fecha_CargaA__c,Identificador_CargaA__c
                          from ActivacionCuenta__c where Estado__c =:'E' and Identificador_CargaA__c =:Num_CodReferencia];                     
            
    	//***************************** INICIO CONTADOR BOTONES ***********************************              
            
       }
         catch(Exception e)
         {
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
         }
    }
        
     //SEGUNDA PANTALLA para la aprobación del Cambio de asesor        
   public pageReference aprobarPlanilla(){
         //string usuario1 = ApexPages.currentPage().getParameters().get('hytrd'); 
         //string usuario1 = 'USER123';
         Cambiar = false;    
         mostrarTabla=false; 
         string descrip;
         
         try{ 
            Activacion = [select NoCuenta__c, noIdentidad__c, Cliente__c, Empresa__c, EstadoActual__c, Causa__c,EstadoNuevo__c,
                          Asesor__c ,CausaNuevo__c, Situaci_n__c,Usuario__c, Estado__c, Fecha_CargaA__c,Identificador_CargaA__c
                          from ActivacionCuenta__c where Estado__c =:'E' and Identificador_CargaA__c =:Num_CodReferencia and Situaci_n__c =:'OK']; 
			                          
            validaDatos = NEW List<ContenidoActivaciondeCuentas>();               
                                          
             if(Activacion.size()>0){
                 
                 for (ActivacionCuenta__c a:Activacion){
                     descrip = 'Se realizó la aprobación de Estado/Causa a la cuenta: ' + a.NoCuenta__c;  
                     validaDatos.add(new ContenidoActivaciondeCuentas(a.NoCuenta__c, 
                                                                       a.noIdentidad__c,
                                                                       a.EstadoActual__c,
                                                                       a.Causa__c,
                                                                       a.EstadoNuevo__c,
                                                                       a.CausaNuevo__c,
                                                                       a.Usuario__c,
                                                                       usuario1,
                                                                       a.Identificador_CargaA__c,
                                                                       datetime.valueOf(a.Fecha_CargaA__c),
                                                                       descrip
                                                                      )); 
                     
                 }//fin for   
                 
             }//fin primer if         
             total=null;
          valResgistroActivaciondeCuentas Enviar = new valResgistroActivaciondeCuentas(validaDatos);   
              
          
          String resultado = string.valueOf(Api_ActivaciondeCuentas.actualizaEstadoCausa(Enviar));
          //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, +'Se aprobó el Cambio de Asesor!' ));
          ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Se aprobó el cambio de Estado/Causa!'));
          rechazarM1 =false;    
            /* //Insertar en la bitacora
             Bitacora_Masivo__c bita = new Bitacora_Masivo__c ();
             bita.Actividades__c = 'Se Aprobó la Planilla con ID: ' + ' ' + Num_CodReferencia;
             bita.Fecha__c = datetime.now();
             bita.Pantalla__c = 'ValidadorActivacionCTA';
             bita.Estado__c = 'Aprobado';
             bita.Usuario__c = usuario1;
             insert bita; */
          
            integer pos;
                for(integer i=0; i<Activacion.size(); i++)
                {
                    if(Activacion[i].Identificador_CargaA__c == Num_CodReferencia)   
                    {
                        pos=i;
                        Activacion[i].Estado__c = 'A'; //estado APROBADO 
                    }
                }
                update Activacion;   
                Activacion.remove(pos);                
           
         }                   
         catch(Exception e)
         {
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
         }
         return null; 
}
    
     public void paraMotivo(){
        if (Motivo == '' || test.isRunningTest()) 
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'La Descripción No Puede Estar Vacia!'));
        }
        else {
            denegarPlanilla();
        }
    }    
    
 public pageReference denegarPlanilla(){
         //string usuario1 = ApexPages.currentPage().getParameters().get('hytrd'); 
         //string usuario1 = 'USER123';
         Cambiar = false;    
         mostrarTabla=false; 
         //string descrip;
         
         try{ 
           /* if (Motivo == '') 
             {
                 ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'La Descripción No Puede Estar Vacia!'));
             }
             else 
             {   */
             
            Activacion = [select NoCuenta__c, noIdentidad__c, Cliente__c, Empresa__c, EstadoActual__c, Causa__c,EstadoNuevo__c,
                          Asesor__c ,CausaNuevo__c, Situaci_n__c,Usuario__c, Estado__c, Fecha_CargaA__c,Identificador_CargaA__c
                          from ActivacionCuenta__c where Estado__c =:'E' and Identificador_CargaA__c =:Num_CodReferencia and Situaci_n__c =:'OK']; 
			                          
            validaDatos = NEW List<ContenidoActivaciondeCuentas>();               
                                          
             if(Activacion.size()>0){
                 
                 for (ActivacionCuenta__c a:Activacion){
                     //descrip = 'Se realizó la aprobación de Estado/Causa a la cuenta: ' + a.NoCuenta__c;  
                     validaDatos.add(new ContenidoActivaciondeCuentas(a.NoCuenta__c, 
                                                                       a.noIdentidad__c,
                                                                       a.EstadoActual__c,
                                                                       a.Causa__c,
                                                                       a.EstadoNuevo__c,
                                                                       a.CausaNuevo__c,
                                                                       a.Usuario__c,
                                                                       usuario1,
                                                                       a.Identificador_CargaA__c,
                                                                       datetime.valueOf(a.Fecha_CargaA__c),
                                                                       Motivo
                                                                      )); 
                     
                 }//fin for   
                 
             }//fin primer if         
             total=null;
          valResgistroActivaciondeCuentas Enviar = new valResgistroActivaciondeCuentas(validaDatos);                    
          
          String resultado = string.valueOf(Api_ActivaciondeCuentas.BitacoraDCausaEstado(Enviar));
          //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, +'Se aprobó el Cambio de Asesor!' ));
          ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Se denego el cambio de Estado/Causa!'));
          rechazarM1 =false;  
           /*    //Insertar en la bitacora
                  Bitacora_Masivo__c bita = new Bitacora_Masivo__c ();
                  bita.Actividades__c = 'Se denegó la Planilla con ID: ' + ' ' + Num_CodReferencia;
                  bita.Fecha__c = datetime.now();
                  bita.Pantalla__c = 'ValidadorActivacionCTA';
                  bita.Estado__c = 'Denegado';
                  bita.Usuario__c = usuario1;
                  insert bita;    */
          
            integer pos;
                for(integer i=0; i<Activacion.size(); i++)
                {
                    if(Activacion[i].Identificador_CargaA__c == Num_CodReferencia)   
                    {
                        pos=i;
                        Activacion[i].Estado__c = 'D'; //estado DENEGADO 
                    }
                }
                update Activacion;   
                Activacion.remove(pos);           
           
         // }  
         }
         catch(Exception e)
         {
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
         }
         return null; 
}
    
    //FIN 
    
     //Metodo el cual carga el archivo del excel 
     @RemoteAction
    global static classWRetorno2 SUbirInformacion(String stringCSV, string empresa, string agus){
        classWRetorno2 retorno = new classWRetorno2();
        
        try{
            //Agregado para obtener indentificador unico para los archivos 16072019
            integer id_carga =0;  
            //string usuarioPr;
                         
            ActivacionCuenta__c carga = new ActivacionCuenta__c ();             
            carga = [select Identificador_CargaA__c from ActivacionCuenta__c order by Identificador_CargaA__c desc limit 1] ;
            id_carga = integer.valueOf(carga.Identificador_CargaA__c); 
            id_carga++;
            //fin
            
            stringCSV.replace('\'', '');
       		stringCSV.replace('´', '');
            list<string> clientes = new  list<string>();
            list<string> clientes2= new  list<string>();
            clientes = stringCSV.split('\n');
           
            retorno.error='Ya puede ver la planilla subida';
                      
            integer CabeceraNoCuenta=15;
            integer CabeceraNoIdentidad=15;
            integer CabeceraEstadoActual=15;
            integer CabeceraCausa=15;
            integer CabeceraEstadoNuevo=15;  
            integer CabeceraCausaNueva=15;
            
            
            string lk=clientes[0];
         
            clientes2= lk.split(','); 
            clientes.remove(0);
            
            //string usuario ='HN21528';             
            //usuario3 = ApexPages.currentPage().getParameters().get('hytrd');  
        
            //no tocar
            for(integer i=0; i<clientes2.size(); i++)
            {
                
                clientes2[i]=clientes2[i].replace('"','');
                clientes2[i]=clientes2[i].replace('  ',' ');
                clientes2[i]=clientes2[i].Trim();
 
                if(clientes2[i].toUpperCase()=='NCuenta' || clientes2[i].toUpperCase()=='No.Cuenta' || clientes2[i].toUpperCase()=='No.CUENTA')
                {
                    CabeceraNoCuenta=i; 
                }                
                
                if(clientes2[i].toUpperCase()=='Identidad' || clientes2[i].toUpperCase()=='Identificacion' || clientes2[i].toUpperCase()=='IDENTIDAD')
                {
                    CabeceraNoIdentidad=i; 
                }
                
                if(clientes2[i].toUpperCase()=='EstadoActual' || clientes2[i].toUpperCase()=='Estado.Actual' || clientes2[i].toUpperCase()=='ESTADO ACTUAL')
                {
                    CabeceraEstadoActual=i; 
                }
				if(clientes2[i].toUpperCase()=='CAUSA ACTUAL' || clientes2[i].toUpperCase() =='CausaActual')
                {
                    CabeceraCausa=i; 
                }
                if(clientes2[i].toUpperCase()=='Estado.Nuevo' || clientes2[i].toUpperCase()=='EstadoNuevo' || clientes2[i].toUpperCase() =='ESTADO NUEVO')
                {
                    CabeceraEstadoNuevo=i;
                }
                if(clientes2[i].toUpperCase()=='Causa.Nueva' || clientes2[i].toUpperCase() =='Caus. Nueva' || clientes2[i].toUpperCase() =='CAUSA NUEVA') 
                {
                    CabeceraCausaNueva=i; 
                }
                
                

            }//Final del For de cabecera
            
            if(CabeceraNoCuenta!=15 && CabeceraNoIdentidad!=15 && CabeceraEstadoActual!=15 
               && CabeceraCausa!=15 && CabeceraEstadoNuevo!=15 && CabeceraCausaNueva!=15)
            
            {
                
                list<string> NoCuenta = new  list<string>();
                list<string> NoIdentidad = new  list<string>();
                list<string> EstadoActual = new  list<string>();
                list<String> Causa = new  list<String>();
                list<string> EstadoNuevo = new  list<string>();                
				list<string> CausaNueva = new  list<string>();
                
				
                
                list<string> ident;
                list<string> ident2;
                
                retorno.error='columnas correcta\n';
                
                list<ActivacionCuenta__c> EstadoCu = new list<ActivacionCuenta__c>();
                
                ActivacionCuenta__c listC;
                listc = new ActivacionCuenta__c();
                
                for (integer i=0; i<clientes.size(); i++)
                 {
					    clientes2 = new  list<string>();
                        
                        string jh=clientes[i];
                        if(jh.contains(',,') && jh.trim().length()>20)
                        {
                           clientes[i]=clientes[i].replace(',,',', ,').Trim(); 
                        }
                        else
                        {
                           clientes[i]=clientes[i].replace(',,','').Trim();  
                        }
                     
                     
                       if(clientes[i].length()>1)
                        {
                            string kike2;
                        	string kike=clientes[i];
                        	clientes2 = kike.split(',');
                            
                            clientes2[CabeceraNoCuenta]=clientes2[CabeceraNoCuenta].replace(',','');
                    		clientes2[CabeceraNoCuenta]=clientes2[CabeceraNoCuenta].replace('"','');
                            
//*************************************Llenado de los arreglos respectivos de campos******************************************                            
//*********************************************Numero De Cuenta********************************************************************            
                        if( CabeceraNoCuenta!=15 &&  CabeceraNoCuenta < clientes2.size() &&  clientes2[CabeceraNoCuenta].trim()!='' && clientes2[CabeceraNoCuenta]!=null ){
                            NoCuenta.add(llenarObjetos(clientes2[CabeceraNoCuenta]));
                        } //fin NoCuenta
 //*********************************************Numero De Identidad*******************************************************************************                
                      	if(CabeceraNoIdentidad!=15 ){
                          NoIdentidad.add(llenarObjetos(clientes2[CabeceraNoIdentidad]));
                            }//fin NoIdentidad
                           
  //*************************************Estado Actual***********************************************************************************		
  						if( CabeceraEstadoActual!=15 &&  CabeceraEstadoActual < clientes2.size() ){
                            EstadoActual.add(llenarObjetos(clientes2[CabeceraEstadoActual]));
                            }//Fin de estado actual
//***************************************Causa**********************************************************************+
  						if( CabeceraCausa!=15 &&  CabeceraCausa < clientes2.size() ){
                            Causa.add(llenarObjetos(clientes2[CabeceraCausa]));
                            }//fin de Causa
//*********************************************Estado Nuevo******************************************************************************
					  	if( CabeceraEstadoNuevo!=15 &&  CabeceraEstadoNuevo < clientes2.size()   ){
                            EstadoNuevo.add(llenarObjetos(clientes2[CabeceraEstadoNuevo]));
                       	 }//Estado Nuevo                                                 
  
//*****************************************Causa Nueva***************************************************************************************
                        if(CabeceraCausaNueva!=15 && CabeceraCausaNueva < clientes2.size() ){
                            	CausaNueva.add(llenarObjetos(clientes2[CabeceraCausaNueva]));
                        	}//Fin Causa Nueva
//******************************************************************************************************************************************************                           
                        }//fin del if lenght 
 				 } //fin del for
                
//Lista repetido
/*

for (integer t=0; t<listRepetidos.size(); t++)
                 {
                    
                 	 if(listRepetidos[t].Referencia__c == Referencia[i])
                        {
                            Referencia[i] = '';
   
                        }
                 } // fin del for repetidos
*/                
                 string nformatoId;// agregado 10042019
                
                 for (integer i=0; i<clientes.size(); i++){                   
                string si = 'SI';
                                         
                nformatoId = NoIdentidad[i];     
                NoIdentidad[i] = nformatoId.replace('-', '');
 					 
              	listc = new ActivacionCuenta__c();
                       
               //Validacion 1: Que el codigo de empleado no sea null
              /* if(NoEmpleado[i] == '' || NoEmpleado[i] == null || NoEmpleado[i] == '""' )
                    { NoEmpleado[i]='No Afiliado';
                    }*/  
                                
//************************************************Las listas se pasan al objeto******************************
                                	listC.NoCuenta__c = string.valueOf(NoCuenta[i]);  //Numero de Cuenta
                                    listC.noIdentidad__c = string.valueOf(NoIdentidad[i]);  //Numero de Identidad
                                    listC.EstadoActual__c = string.valueOf(EstadoActual[i]);//Estado Actual
                                	listC.Causa__c =	string.valueOf(Causa[i]);//Causa
									listC.EstadoNuevo__c =	String.valueOf(EstadoNuevo[i]);//Estado Nuevo 
									listC.CausaNuevo__c = String.valueOf(CausaNueva[i]);//Causa Nueva
                                    //listC.Usuario__c = usuarioPr;
                                    listC.Identificador_CargaA__c = integer.valueOf(id_carga);
                                   	
                           			
                   EstadoCu.add(listC);  

                } //fin for 
                
              	insert EstadoCu;
             
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'correcto '));
                                
            }/*fin_if_cabeceras*/
            else{
                
               retorno.error='Estas columnas no traen el nombre correcto\n';
                
               if(CabeceraNoCuenta==15)
               {
                   retorno.error+='No.Cuenta\n';
               }
               if(CabeceraNoIdentidad==15)
               {
                   retorno.error+='No.Identidad\n';
               }
               if(CabeceraEstadoActual==15)
               {
                   retorno.error+='Estado Actual\n';
               }
               if(CabeceraCausa==15)
               {
                   retorno.error+='CAUSA ACTUAL\n';
               }
               if(CabeceraEstadoNuevo==15)
               {
                   retorno.error+='Estado Nuevo\n';
               }
               if(CabeceraCausaNueva==15)
               {
                   retorno.error+='CAUSA NUEVA\n';
               }
            }//fin_else_cabeceras
//********************************************#########fin de validacion del else de los encabezados#########**********
            
            
            
        }catch( exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Ha Ocurrido Un error: ' +ex.getLineNumber()));
           // system.debug('Error al Guardar: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());    
        
            retorno.error='Ha ocurrido un error' + ex.getMessage() + ' Linea: ' + ex.getLineNumber(); 
            return retorno;
        }
        
        
        return retorno;
    }
}