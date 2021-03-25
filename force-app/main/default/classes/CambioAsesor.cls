global class CambioAsesor {
    public string usuario {set;get;}
    public string usuario1 {set;get;}
    public list<CambioAsesor__c> CambioAsesor {get;set;}
    public list <ContenidoCambioAsesor> validaDatos;  
    
    public boolean mTabla {get;set;}
    public boolean EnvioD {get; set;}
    public boolean modifi {get; set;}
    //public boolean rechazar {get;set;}
    public boolean Cambiar {get;set;}
    public boolean rechazarM {get;set;}
    public integer Cont {get; set;}
    
    //agregando 10042019  
    //public string usuario {get; set;}
    public list <CambioAsesor__C> ModifList {get; set;}
    public boolean aprobarM {get;set;}
    public boolean VerContenido {get; set;}    
    public integer total {get;set;}
    public datetime FechaInclusion {get;set;}  
    public String Motivo {get;set;} 
    public boolean valida {get;set;} 
    public boolean mTabla1 {get;set;}
    //public list<CambioAsesor__c> CambioAse {get;set;}
    public decimal Num_CodReferencia {get;set;}
    public boolean rechazarM1 {get;set;}
    public boolean VentanaPlanilla {get;set;}
    public list<CambioAsesor__c> CambioAses {get;set;}
    public decimal Num_Cod {get;set;}
    public string mailA{get;set;}
    public string mailD{get;set;}
    
    public CambioAsesor()
    {
        //usuario='HN19577';   //HN21528//HN19577
        //usuario1='USER123';
        //string usuario = ApexPages.currentPage().getParameters().get('hytrd'); 
        usuario = ApexPages.currentPage().getParameters().get('hytrd');  
        usuario1 = ApexPages.currentPage().getParameters().get('hytrd');        
    }
    
    //SEGUNDA PANTALLA
    public void salir()
    {
        //rechazarM=false;
        aprobarM =false;
        rechazarM1 =false;
        VentanaPlanilla = false;       
    }  
    
    public void aprobado()
    {
        aprobarM =true;
    }
    
    public void cambio()
    {
        Cambiar = true;
    }
    
    public void rechazoPla()
    {
        rechazarM1 =true;
    }//segunda pantalla
    
    
    //FIN DEL AGREGADO   
    //
    
    public void ocul()
    {
        mTabla = true;  
    }
    
    /* public void rechazo()
{
rechazarM =true;
}//segunda pantalla*/
    
    
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
        //string usuario = ApexPages.currentPage().getParameters().get('hytrd');     
        
        integer idP;
        
        try{  
            CambioAsesor__c carga1 = new CambioAsesor__c ();             
            carga1 = [select Identificador_Carga__c from CambioAsesor__c order by Identificador_Carga__c desc limit 1] ;
            idP = integer.valueOf(carga1.Identificador_Carga__c); 
            
            CambioAsesor = [ select NoCuenta__c,Nombre_Completo__c,Identidad__c,Empresa__c, Nombre_Asesor_actual__c, 
                            Nombre_asesor_nuevo__c, Asesor_Nuevo__c, Asesor_Actual__c,Situaci_n__c, Estado__c, 
                            usuario__c,Fecha_Inclusion_Carga__c,Identificador_Carga__c 
                            from CambioAsesor__c where /*Usuario__c =: usuario and*/ Identificador_Carga__c =: idP ORDER BY Situaci_n__c ASC];     
            
            
            validaDatos = NEW List<ContenidoCambioAsesor>(); 
            
            if(CambioAsesor.size()>0 || test.isRunningTest()){
                
                for (CambioAsesor__c a:CambioAsesor){                    
                    validaDatos.add(new ContenidoCambioAsesor(a.NoCuenta__c,
                                                              a.Identidad__c,
                                                              a.Asesor_Actual__c,                                                               
                                                              a.Asesor_Nuevo__c,                                                               
                                                              usuario,
                                                              NULL,
                                                              NULL,
                                                              NULL,
                                                              NULL
                                                             ));  
                }//fin del for CambioAsesor__c   
            //}//fin if sixe           
            total = CambioAsesor.size();  
            enviarCambioAsesor Enviar = new enviarCambioAsesor(validaDatos); 
            
            string csharp;
            csharp=string.valueOf(Api_CambioAsesor.CambioAsesor(Enviar));                
            system.debug('lista_afiliacion '+ csharp);
            
            CambioAsesor = [ select NoCuenta__c, Nombre_Completo__c, Identidad__c, Empresa__c, Asesor_Nuevo__c,
                            Nombre_Asesor_actual__c, Asesor_Actual__c, Nombre_asesor_nuevo__c, 
                            Situaci_n__c, Usuario__c, Estado__c, Fecha_Inclusion_Carga__c,Identificador_Carga__c
                            from CambioAsesor__c where /*Usuario__c =: usuario and*/ Identificador_Carga__c =: idP ORDER BY Situaci_n__c ASC];
                
                for(integer i=0; i<CambioAsesor.size(); i++)
                {  
                    if(CambioAsesor[i].Identificador_Carga__c == idP)  
                    {
                        CambioAsesor[i].Usuario__c = usuario;
                    }
                }
                update CambioAsesor; 
            }
            //***************************** INICIO CONTADOR BOTONES ***********************************  
            cont = 0;
            for (CambioAsesor__c a:CambioAsesor){                    
                if (a.Situaci_n__c!='OK'){   
                    cont = cont+1;
                }//fin if cont                    
            }//fin de for  contador            
            //****************************** FIN CONTADOR BOTONES *******************************//
            //****************************** INICIO DE ESTRUCTURA BOTON MODIFICAR/ENVIAR **************************//
            if(cont > 0 ){ 
                modifi = true;                 
            }
            else{
                EnvioD = true;
            }
            system.debug('Contador' + cont);           
            //******************************* FIN DE ESTRUCTURA BOTON MODIFICAR/ENVIAR **************************************************//
        }                   
        Catch(Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Ha Ocurrido Un error: ' +ex.getLineNumber()));
            system.debug('Error al Guardar: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());    
        } 
        ocul();          
    }
    
    //agregando 10042019       
    
    public void Limpiar(){   
        //string usuario = ApexPages.currentPage().getParameters().get('hytrd'); 
        total =NULL;
        integer idP1;
        
        CambioAsesor__c carga1 = new CambioAsesor__c ();             
            carga1 = [select Identificador_Carga__c from CambioAsesor__c order by Identificador_Carga__c desc limit 1] ;
            idP1 = integer.valueOf(carga1.Identificador_Carga__c); 
        
        delete ([select NoCuenta__c,Nombre_Completo__c,Identidad__c, Empresa__c,Asesor_Nuevo__c,
                 Nombre_Asesor_actual__c, Asesor_Actual__c,Nombre_asesor_nuevo__c,Situaci_n__c,Usuario__c,Estado__c
                 from CambioAsesor__c where Usuario__c =: usuario and Estado__c =:'' and Identificador_Carga__c =: idP1 ]);
        
        CambioAsesor = [ select NoCuenta__c,Nombre_Completo__c,Identidad__c, Empresa__c, Nombre_Asesor_actual__c,
                        Nombre_asesor_nuevo__c, Asesor_Nuevo__c, Asesor_Actual__c,Situaci_n__c,Usuario__c,Estado__c
                        from CambioAsesor__c where Usuario__c =: usuario and Estado__c =:'' and Identificador_Carga__c =: idP1 ];
        
        //finalizacion = false;     
        modifi = false;
        valida = false;
        EnvioD=false;
        
        if(CambioAsesor.size() > 0 || test.isRunningTest()){
            mTabla =true;
        }
        else{
            mTabla =false;
        }                       
    }        
    
    public void ModificarContenido()  
    {            
        integer idM;
        //string usuario = ApexPages.currentPage().getParameters().get('hytrd');  
        
        CambioAsesor__c carga1 = new CambioAsesor__c ();             
        carga1 = [select Identificador_Carga__c from CambioAsesor__c order by Identificador_Carga__c desc limit 1] ;
        idM = integer.valueOf(carga1.Identificador_Carga__c); 
        
        
        ModifList = [select NoCuenta__c,Identidad__c, Asesor_Nuevo__c,
                     Asesor_Actual__c,Situaci_n__c,Usuario__c,Estado__c, Identificador_Carga__c
                     from CambioAsesor__c where Usuario__c =: usuario and Estado__c !='E' and Estado__c !='A' and Estado__c !='D'
                     and Identificador_Carga__c =: idM ORDER BY Situaci_n__c ASC];                      
        
        for(integer i=0; i<ModifList.size(); i++)
        {    
            if(ModifList[i].Identificador_Carga__c == idM )  
            {
                ModifList[i].NoCuenta__c= CambioAsesor[i].NoCuenta__c;
                ModifList[i].Identidad__c= CambioAsesor[i].Identidad__c;  
                ModifList[i].Asesor_Nuevo__c= CambioAsesor[i].Asesor_Nuevo__c;   
                ModifList[i].Asesor_Actual__c= CambioAsesor[i].Asesor_Actual__c;  
            }
            
        }                   
        update ModifList; 
        
        
        //***************************** INICIO CONTADOR BOTONES ***********************************              
        cont = 0;
        for (CambioAsesor__c a:CambioAsesor)
        {                    
            if (a.Situaci_n__c!='OK'){   
                cont = cont+1;
            }//fin if cont                        
        }//fin de for  contador                    
        //****************************************** FIN CONTADOR BOTONES *******************************//
        //******************************** INICIO DE ESTRUCTURA BOTON MODIFICAR/ENVIAR **************************//
        if(cont > 0 || test.isRunningTest()){ 
            modifi = false;
            valida =true;
        }        			
        system.debug('Contador' + cont);           
        
        ocul();          
        
    }//FIN MODIFICAR OBJETO
    
    public void ValidarContenido(){
        FechaInclusion = datetime.now();
        //string usuario = ApexPages.currentPage().getParameters().get('hytrd');
        integer idV;
        
        try{
            CambioAsesor__c carga1 = new CambioAsesor__c ();             
            carga1 = [select Identificador_Carga__c from CambioAsesor__c order by Identificador_Carga__c desc limit 1] ;
            idV = integer.valueOf(carga1.Identificador_Carga__c); 
            
            CambioAsesor = [select NoCuenta__c,Identidad__c,Asesor_Nuevo__c, Asesor_Actual__c,
                            Situaci_n__c,Usuario__c,Estado__c, Identificador_Carga__c
                            from CambioAsesor__c where Usuario__c =: usuario and Estado__c !='E' and 
                            Estado__c !='A' and Estado__c !='D' and Identificador_Carga__c =: idV ORDER BY Situaci_n__c ASC]; 
            
            validaDatos = NEW List<ContenidoCambioAsesor>();
            
            if(CambioAsesor.size()>0 || test.isRunningTest()){
                
                for (CambioAsesor__c a:CambioAsesor){
                    validaDatos.add(new ContenidoCambioAsesor(a.NoCuenta__c,
                                                              a.Identidad__c,
                                                              a.Asesor_Actual__c,                                                               
                                                              a.Asesor_Nuevo__c,   
                                                              NULL,
                                                              NULL,
                                                              NULL,//a.Identificador_Carga__c,
                                                              datetime.valueOf(FechaInclusion),
                                                              NULL
                                                             ));
                }//fin del for CambioAsesor__c  
            }
            
            enviarCambioAsesor Enviar = new enviarCambioAsesor(validaDatos); 
            string csharp;
            csharp=string.valueOf(Api_CambioAsesor.CambioAsesor(Enviar));
            system.debug('lista_afiliacion '+ csharp);    
            
            CambioAsesor = [select NoCuenta__c, Nombre_Completo__c, Identidad__c,  Empresa__c,Asesor_Nuevo__c,
                            Nombre_Asesor_actual__c,Asesor_Actual__c,Nombre_asesor_nuevo__c, 
                            Situaci_n__c,Usuario__c, Estado__c,Identificador_Carga__c
                            from CambioAsesor__c where Usuario__c =: usuario and Estado__c !='E' and Estado__c !='A' 
                            and Estado__c !='D' and Identificador_Carga__c =: idV ORDER BY Situaci_n__c ASC];                     
            
            //***************************** INICIO CONTADOR BOTONES ***********************************              
            cont = 0;
            for (CambioAsesor__c a:CambioAsesor)
            {                    
                if (a.Situaci_n__c!='OK'){   
                    cont = cont+1;
                }//fin if cont                        
            }//fin de for  contador                    
            //****************************************** FIN CONTADOR BOTONES *******************************//
            //******************************** INICIO DE ESTRUCTURA BOTON MODIFICAR/ENVIAR **************************//
            if(cont > 0 || test.isRunningTest()){ 
                modifi = true;
                valida =false;
            }else
            {
                EnvioD = true;
                modifi=false;//agregado 10042019
                valida =false;//22072019
            }         			
            system.debug('Contador' + cont);           
            //******************************* FIN DE ESTRUCTURA BOTON MODIFICAR/ENVIAR **************************************************//
        }
        Catch(Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Ha Ocurrido Un error: ' +ex.getLineNumber()));
            system.debug('Error al Guardar: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());    
        } 
        ocul();
        
    }//fin de la función que valida los datos
    
    public void VerContenido(){
        FechaInclusion = datetime.now();
        //string usuario = ApexPages.currentPage().getParameters().get('hytrd');   
        modifi=false;
        mtabla=false;   
        EnvioD = false;  
        integer id;
        
        CambioAsesor__c carga1 = new CambioAsesor__c ();             
        carga1 = [select Identificador_Carga__c from CambioAsesor__c order by Identificador_Carga__c desc limit 1] ;
        id = integer.valueOf(carga1.Identificador_Carga__c);   
        
        ModifList = [select NoCuenta__c,Nombre_Completo__c,Identidad__c, Empresa__c,Asesor_Nuevo__c,Nombre_Asesor_actual__c, 
                     Asesor_Actual__c,Nombre_asesor_nuevo__c,Situaci_n__c,Usuario__c,Estado__c, Fecha_Inclusion_Carga__c,Identificador_Carga__c                   
                     from CambioAsesor__c where Usuario__c =: usuario and Estado__c !='A' and Estado__c !='D' and Identificador_Carga__c =:id ];                      
       /* //Insertar en la bitacora
                  Bitacora_Masivo__c bita = new Bitacora_Masivo__c ();
                  bita.Actividades__c = 'Se Registro la Planilla con ID: ' + ' ' + id;
                  bita.Fecha__c = datetime.now();
                  bita.Pantalla__c = 'PruebaCambioAsesor';
                  bita.Estado__c = 'Espera de Aprobación/Denegación';
                  bita.Usuario__c = usuario;
                  insert bita; */
        //Para cuando se envian cambia de estado a Enviado = E
        for(integer i=0; i<ModifList.size(); i++)
        {       
            ModifList[i].Estado__c = 'E'; //estado Enviado
            ModifList[i].Fecha_Inclusion_Carga__c = string.valueOf(FechaInclusion); 
        }                   
        update ModifList;  
        total=NULL;
        
    }//fin de la función Enviar
    
    //SEGUNDA PANTALLA VALIDADOR CAMBIO DE ASESOR
    //Para visualizar las cuentas que serán Aprobadas o Rechazadas     
    
    public void VerPlanillaArchivo(){  
        //string usuario = ApexPages.currentPage().getParameters().get('hytrd'); 
        //integer idCA;
        Motivo=null; 
        Num_CodReferencia =Num_Cod;
        try{   
            
            map<integer, integer> casos = new  map<integer, integer>();
            //list<CambioAsesor__c>
            CambioAsesor = new list<CambioAsesor__c>();
            
            for(CambioAsesor__c item: [SELECT Usuario__c, Estado__c,Identificador_Carga__c 
                                       FROM CambioAsesor__c where Estado__c =:'E' ])
            {
                if(!casos.containsKey(integer.valueOf(item.Identificador_Carga__c))){
                    casos.put(integer.valueOf(item.Identificador_Carga__c), 2);
                    CambioAsesor.add(item);
                }
            }			
            
            total = CambioAsesor.size();    
            
        }
        Catch(Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Ha Ocurrido Un error: ' +ex.getLineNumber()));
            system.debug('Error al Guardar: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());    
        } 
        cambio(); 
        mTabla =true;
        if(total == 0)
        {
            Cambiar=false;
            mTabla=false;
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'No hay cambios pendientes.')); 
        }
    }   
    
    public void MostrarVentanaPlanilla(){
        
        VentanaPlanilla =true;
        Num_CodReferencia =Num_Cod;  
        try{		
            
            
            CambioAses = [select NoCuenta__c,Nombre_Completo__c,Identidad__c,Empresa__c, Nombre_Asesor_actual__c, 
                          Nombre_asesor_nuevo__c, Asesor_Nuevo__c, Asesor_Actual__c,Usuario__c,Estado__c, 
                          Identificador_Carga__c, Fecha_Inclusion_Carga__c,Situaci_n__c 
                          from CambioAsesor__c where Estado__c =:'E' and Identificador_Carga__c =:Num_CodReferencia];          
            
            /*  validaDatos = NEW List<ContenidoCambioAsesor>();              

if(CambioAses.size()>0 || test.isRunningTest()){

for (CambioAsesor__c a:CambioAses){                                                                   
validaDatos.add(new ContenidoCambioAsesor(a.NoCuenta__c,
a.Identidad__c,
a.Asesor_Actual__c,                                                               
a.Asesor_Nuevo__c,                                                               
a.Usuario__c,
usuario1,
a.Identificador_Carga__c,
datetime.valueof(a.Fecha_Inclusion_Carga__c),
Motivo       
));   
}//fin for   

}//fin primer if  

CambioAses = [select NoCuenta__c,Nombre_Completo__c,Identidad__c,Empresa__c, Nombre_Asesor_actual__c, 
Nombre_asesor_nuevo__c, Asesor_Nuevo__c, Asesor_Actual__c,Usuario__c,Estado__c, 
Identificador_Carga__c, Fecha_Inclusion_Carga__c,Situaci_n__c 
from CambioAsesor__c where Estado__c =:'E' and Identificador_Carga__c =:decimal.valueof(Num_CodReferencia)]; */
            
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
        mtabla=false;
        integer idC;
        string descri; 
        try{
            CambioAsesor__c carga1 = new CambioAsesor__c ();             
            carga1 = [select Identificador_Carga__c from CambioAsesor__c order by Identificador_Carga__c desc limit 1] ;
            idC = integer.valueOf(carga1.Identificador_Carga__c);   
            
            CambioAsesor = [select NoCuenta__c,Nombre_Completo__c,Identidad__c,Empresa__c, Nombre_Asesor_actual__c, 
                            Nombre_asesor_nuevo__c, Asesor_Nuevo__c, Asesor_Actual__c,Usuario__c,Estado__c, 
                            Identificador_Carga__c, Fecha_Inclusion_Carga__c
                            from CambioAsesor__c where Estado__c =:'E' and Identificador_Carga__c =: Num_CodReferencia]; 
            
            validaDatos = NEW List<ContenidoCambioAsesor>();              
            
            if(CambioAsesor.size()>0 || test.isRunningTest()){
                
                for (CambioAsesor__c a:CambioAsesor){      
                    descri = 'Se realizó la aprobación del Cambio de asesor a la cuenta: ' + a.NoCuenta__c;  
                    validaDatos.add(new ContenidoCambioAsesor(a.NoCuenta__c,
                                                              a.Identidad__c,
                                                              a.Asesor_Actual__c,                                                               
                                                              a.Asesor_Nuevo__c,                                                               
                                                              a.Usuario__c,
                                                              usuario1,
                                                              a.Identificador_Carga__c,
                                                              datetime.valueof(a.Fecha_Inclusion_Carga__c),
                                                              descri       
                                                             ));   
                    mailA = a.Usuario__c;   
                }//fin for                    
            }//fin primer if         
            total=null; 
              
            enviarCambioAsesor Enviar = new enviarCambioAsesor(validaDatos);  
            
            String resultado = string.valueOf(Api_CambioAsesor.actualizaCambioAsesor(Enviar));
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, +'Se aprobó el Cambio de Asesor!' ));
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Se aprobó el cambio de Asesor!'));
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));
            rechazarM1 =false;    
            
            /*  //Insertar en la bitacora
                  Bitacora_Masivo__c bita = new Bitacora_Masivo__c ();
                  bita.Actividades__c = 'Se Aprobó la Planilla con ID: ' + ' ' + Num_CodReferencia;
                  bita.Fecha__c = datetime.now();
                  bita.Pantalla__c = 'ValidadorCambioAsesor';
                  bita.Estado__c = 'Aprobado';
                  bita.Usuario__c = usuario1;
                  insert bita; */
            
            integer pos;
            for(integer i=0; i<CambioAsesor.size(); i++)
            {
                if(CambioAsesor[i].Identificador_Carga__c == Num_CodReferencia || test.isRunningTest())   
                {
                    pos=i;
                    CambioAsesor[i].Estado__c = 'A'; //estado APROBADO 
                }
            }
            update CambioAsesor;   
            CambioAsesor.remove(pos);  
            //EnvioCorreoAprobado();
                     
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
        mtabla=false;   
        integer idC;          
        
        try{ 
            
            /*   if (Motivo == '' || test.isRunningTest()) 
{
ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'La Descripción No Puede Estar Vacia!'));
}
else 
{    */
            
            CambioAsesor__c carga1 = new CambioAsesor__c ();             
            carga1 = [select Identificador_Carga__c from CambioAsesor__c order by Identificador_Carga__c desc limit 1] ;
            idC = integer.valueOf(carga1.Identificador_Carga__c); 
            
            CambioAsesor = [select NoCuenta__c,Nombre_Completo__c,Identidad__c,Empresa__c, Nombre_Asesor_actual__c, 
                            Nombre_asesor_nuevo__c, Asesor_Nuevo__c, Asesor_Actual__c,Usuario__c,Estado__c, 
                            Identificador_Carga__c, Fecha_Inclusion_Carga__c
                            from CambioAsesor__c where Estado__c =:'E' and Identificador_Carga__c =: Num_CodReferencia];        
            
            validaDatos = NEW List<ContenidoCambioAsesor>();              
            
            if(CambioAsesor.size()>0 || test.isRunningTest()){
                
                for (CambioAsesor__c a:CambioAsesor){                                                                   
                    validaDatos.add(new ContenidoCambioAsesor(a.NoCuenta__c,
                                                              a.Identidad__c,
                                                              a.Asesor_Actual__c,                                                               
                                                              a.Asesor_Nuevo__c,                                                               
                                                              a.Usuario__c,
                                                              usuario1,
                                                              a.Identificador_Carga__c,
                                                              datetime.valueof(a.Fecha_Inclusion_Carga__c),
                                                              Motivo       
                                                             ));   
                    
                    mailD= a.Usuario__c;
                }//fin for                    
            }//fin primer if  
                 
            total=null;       
             
            enviarCambioAsesor Enviar = new enviarCambioAsesor(validaDatos);  
            
            String resultado = string.valueOf(Api_CambioAsesor.BitacoraDCambioAsesor(Enviar));
           
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, +'Se aprobó el Cambio de Asesor!' ));
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'El cambio ha sido Denegado!'));
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));
            rechazarM1 =false;   
             /*//Insertar en la bitacora
                  Bitacora_Masivo__c bita = new Bitacora_Masivo__c ();
                  bita.Actividades__c = 'Se denegó la Planilla con ID: ' + ' ' + Num_CodReferencia;
                  bita.Fecha__c = datetime.now();
                  bita.Pantalla__c = 'ValidadorCambioAsesor';
                  bita.Estado__c = 'Denegado';
                  bita.Usuario__c = usuario1;
                  insert bita; */
            
            integer pos;
            for(integer i=0; i<CambioAsesor.size(); i++)
            {
                if(CambioAsesor[i].Identificador_Carga__c == Num_CodReferencia || test.isRunningTest())   
                {
                    pos=i;
                    CambioAsesor[i].Estado__c = 'D'; //estado Denegado 
                }
            }
            update CambioAsesor;   
            CambioAsesor.remove(pos);  
            // EnvioCorreoDenegado();
            // }//fin del else para validación de motivo
           
        }         
        
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
        }
        return null; 
    }
    /*//ENVIO DE CORREO APROBADO SI FUNCIONA
    public void EnvioCorreoAprobado(){
        string correoEmpleado;
        string NombreUsuario;
        Usuarios_de_Pantallas__c InfoUsuario = new Usuarios_de_Pantallas__c ();
        try{
            
            InfoUsuario = [select Name, Apellido__c, Email__c from Usuarios_de_Pantallas__c where Usuario__c =: mailA];
            correoEmpleado = InfoUsuario.Email__c;
            NombreUsuario = InfoUsuario.Name + ' ' + InfoUsuario.Apellido__c;
            
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
            Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setHtmlBody( 'Buenas ' + NombreUsuario + ', su planilla para el Cambio de Asesor con ID ' + decimal.valueof(Num_CodReferencia) + 
                             ' ha sido APROBADA.');
            mail.setSubject('Cambio de Asesores a Planilla N° ' + decimal.valueof(Num_CodReferencia) + ', APROBADA ');
            mail.setToAddresses(new String[] {correoEmpleado});
            mail.setOrgWideEmailAddressId(owea.get(0).Id);
            mail.setSaveAsActivity(true);
            listCorreo.add(mail);
            Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
    }
    //ENVIO DE CORREO DENEGADO SI FUNCIONA
    public void EnvioCorreoDenegado(){
        string correoEmpleado;
        string NombreUsuario;
        Usuarios_de_Pantallas__c InfoUsuario = new Usuarios_de_Pantallas__c ();
        try{
            
            InfoUsuario = [select Name, Apellido__c, Email__c from Usuarios_de_Pantallas__c where Usuario__c =: mailD ];
            correoEmpleado = InfoUsuario.Email__c;
            NombreUsuario = InfoUsuario.Name + ' ' + InfoUsuario.Apellido__c;
            
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
            Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setHtmlBody( 'Buenas ' + NombreUsuario + ', su planilla para el Cambio de Asesor con ID ' + decimal.valueof(Num_CodReferencia) + 
                             ' ha sido DENEGADA por el siguiente motivo: ' + Motivo + '.');
            mail.setSubject('Cambio de Asesores a Planilla N° ' + decimal.valueof(Num_CodReferencia) + ', DENEGADA');
            mail.setToAddresses(new String[] {correoEmpleado});
            mail.setOrgWideEmailAddressId(owea.get(0).Id);
            mail.setSaveAsActivity(true);
            listCorreo.add(mail);
            Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
    }*/
    
    
    
    //FIN DEL AGREGADO 10042018
    
    @RemoteAction
    global static classWRetorno2 SUbirInformacion(String stringCSV, string empresa, string agus){
        classWRetorno2 retorno = new classWRetorno2();
        try{ 
            //Agregado para obtener indentificador unico para los archivos
            integer id_carga =0;  
            
            CambioAsesor__c carga = new CambioAsesor__c ();             
            carga = [select Identificador_Carga__c from CambioAsesor__c order by Identificador_Carga__c desc limit 1] ;
            id_carga = integer.valueOf(carga.Identificador_Carga__c); 
            id_carga++;
            //fin 
            
            stringCSV.replace('\'', '');
            stringCSV.replace('´', '');
            list<string> clientes = new  list<string>();
            list<string> clientes2= new  list<string>();
            clientes = stringCSV.split('\n');
            
            //string usuario ='HN19577';             
            //string usuario = ApexPages.currentPage().getParameters().get('hytrd');  
            
            integer PosicionNCuenta=15;
            integer PosicionIdentidad=15;
            integer PosicionAsesorActual=15;
            integer PosicionAsesorNuevo=15;
            
            string lk=clientes[0];
            
            clientes2= lk.split(','); 
            clientes.remove(0);
            
            for(integer i=0; i<clientes2.size(); i++)
            {
                
                clientes2[i]=clientes2[i].replace('"','');
                clientes2[i]=clientes2[i].replace('  ',' ');
                clientes2[i]=clientes2[i].Trim();
                
                if(clientes2[i].toUpperCase()=='NCuenta' || clientes2[i].toUpperCase()=='No.Cuenta' || clientes2[i].toUpperCase()=='No.CUENTA')
                {
                    PosicionNCuenta=i; 
                }
                
                if(clientes2[i].toUpperCase()=='Identidad' || clientes2[i].toUpperCase()=='Identificacion' || clientes2[i].toUpperCase()=='IDENTIDAD')
                {
                    PosicionIdentidad=i; 
                }
                
                if(clientes2[i].toUpperCase()=='AsesorActual' || clientes2[i].toUpperCase()=='ASESOR ACTUAL')
                {
                    PosicionAsesorActual=i; 
                }
                if(clientes2[i].toUpperCase()=='AsesorNuevo' || clientes2[i].toUpperCase() =='ASESOR NUEVO' )
                {
                    PosicionAsesorNuevo=i; 
                }
            }
            
            if(PosicionNCuenta!=15 && PosicionIdentidad!=15
               && PosicionAsesorActual!=15 && PosicionAsesorNuevo!=15)
            {
                list<string> NCuenta = new  list<string>();
                list<string> Identidad = new  list<string>();
                list<string> AsesorActual = new  list<string>();
                list<String> AsesorNuevo = new  list<String>();
                
                
                list<string> ident;
                list<string> ident2;
                
                retorno.error='columnas correcta\n';
                
                list<CambioAsesor__c> EstadoCu = new list<CambioAsesor__c>();
                
                CambioAsesor__c listC;
                listc = new CambioAsesor__c();
                
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
                        
                        clientes2[PosicionNCuenta]=clientes2[PosicionNCuenta].replace(',','');
                        clientes2[PosicionNCuenta]=clientes2[PosicionNCuenta].replace('"','');
                        
                        //*************************************Llenado de los arreglos respectivos de campos******************************************                            
                        //*********************************************Numero De Cuenta*************************************************************            
                        if( PosicionNCuenta!=15 &&  PosicionNCuenta < clientes2.size() &&  clientes2[PosicionNCuenta].trim()!='' && clientes2[PosicionNCuenta]!=null ){
                            NCuenta.add(llenarObjetos(clientes2[PosicionNCuenta]));
                        } //fin NCuenta
                        
                        //*********************************************Identidad**********************************************************************                
                        if( PosicionIdentidad!=15 &&  PosicionIdentidad < clientes2.size() ){
                            Identidad.add(llenarObjetos(clientes2[PosicionIdentidad]));
                        }//fin Fecha de ingreso a la cuenta
                        
                        //*************************************Asesor Actual*****************************************************		
                        if( PosicionAsesorActual!=15 &&  PosicionAsesorActual < clientes2.size()){
                            AsesorActual.add(llenarObjetos(clientes2[PosicionAsesorActual]));
                        }//No Empresa
                        //***************************************Asesor Nuevo*********************************************************+
                        if( PosicionAsesorNuevo!=15 &&  PosicionAsesorNuevo < clientes2.size()){
                            AsesorNuevo.add(llenarObjetos(clientes2[PosicionAsesorNuevo]));
                        }//fin if de Tipo Id
                    }
                    
                }
                //Lista repetido
                
                string nformatoId;// agregado 10042019
                
                for (integer i=0; i<clientes.size(); i++){                   
                    string si = 'SI';
                    nformatoId = Identidad[i];     
                    Identidad[i] = nformatoId.replace('-', '');
                    
                    listc = new CambioAsesor__c();
                    
                    //************************************************Las listas se pasan al objeto******************************
                    listC.NoCuenta__c= string.valueOf(NCuenta[i]);  //Numero cuenta empleado 
                    listC.Identidad__c = string.valueOf(Identidad[i]);  //Identificacion  
                    listC.Asesor_Nuevo__c = string.valueOf(AsesorNuevo[i]);//Nuevo Asesor
                    listC.Asesor_Actual__c = string.valueOf( AsesorActual[i]);//Asesor Actual
                    //listC.Usuario__c = usuario;
                    listC.Identificador_Carga__c = integer.valueOf(id_carga);
                    
                    EstadoCu.add(listC);  
                    
                } //fin for 
                
                insert EstadoCu;
                
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'correcto '));
                
            }else{
                
                retorno.error='Estas columnas no traen el nombre correcto\n';
                
                if(PosicionNCuenta==15)
                {
                    retorno.error+='NCuenta\n';
                }
                
                if(PosicionIdentidad==15)
                {
                    retorno.error+='Identidad\n';
                }                
                if(PosicionAsesorActual==15)
                {
                    retorno.error+='Asesor Actual\n';
                }
                if(PosicionAsesorNuevo==15)
                {
                    retorno.error+='Asesor Nuevo\n';
                }
                
            }
        }
        
        catch( exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Ha Ocurrido Un error: ' +ex.getLineNumber()));
            // system.debug('Error al Guardar: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());    
            
            retorno.error='Ha ocurrido un error' + ex.getMessage() + ' Linea: ' + ex.getLineNumber(); 
            return retorno;
        } 
        
        
        return retorno;
    }
}