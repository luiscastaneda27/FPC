public class controllerpignorados {
    /*Variables*/
    public List<classcambiopignorados> ListPignorados{get;set;} 
    public list<Fondo_Pignorado__c> McontenidoPign{get;set;}
    public string ID_Referencia {get; set;}
    public string cuentapig {get;set;}
    public string id_pign {get;set;}
    public string usuario {get;set;}
    public string nombrepig {get;set;}
    public string num_prest {get;set;}
    public integer tama {get;set;}
    public string cod_obj {get;set;}
    public integer total {get;set;}
    public boolean MuestraTabla {get;set;}
    public boolean MuestraTabla2 {get;set;}
    public String Motivo {get;set;} 
    public boolean DenegarVentana {get;set;}
    public boolean DenegarImagen {get;set;}
     public Transient string Ver_Imagen {get;set;}
    public Transient Blob Ver_Pdf {get;set;}
    public  string ct {get;set;}
    public boolean result {get;set;}
    public boolean cargarFile {get;set;}
    public boolean isImage {get;set;}
    public boolean isPdf {get;set;}
    public string filename {get;set;}
    public string nom_empleado {get;set;}
    public string cod_empleado {get;set;} //COdigo del empleado
public string correoEmpleado {get;set;}//correo del empleado
    public string correoEmpleado2 {get;set;}
    
    
    public controllerpignorados ()  {
        
        //usuario = 'HN19577';
        try{
            //Usuario =  ApexPages.currentPage().getParameters().get('hytrd');
            
            //List<User> usr = [Select Id, Name From User Where Id=:UserInfo.getUserId() Limit 1];
            //System.debug('User: '+usr[0].Name);///////Marcooo
            //Usuario = usr[0].Name;
            
            string nu;
            Usuario = ApexPages.currentPage().getParameters().get('hytrd');
           nu= [select id, Name from Usuarios_de_Pantallas__c where Usuario__c =: Usuario].Usuario__c;
            //else{nu= [select Name from Usuarios_de_Pantallas__c limit 1].Name;}
            System.debug('User: '+nu);
            Usuario = nu;
          
        }Catch(Exception ex){
            system.debug('Error: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());
           
        }
        
        McontenidoPign =[ select Numero_Prestamo__c,Num_Prestamo__c,Monto_Pignorado__c,Fecha_Pignoracion__c,Fecha_Liberacion__c,Monto_Prestamo__c ,
                                    Total_Fondos__c,Usuario__c,Estatus__c, Estado__c, Cuenta__c,Secuencia__c,Referencia__c
                            from Fondo_Pignorado__c
                            where Estado__c = 'P'];        
       	
       
        total = McontenidoPign.size();
     
    }  
    
    public void popDenegarSalir()
    {    
      DenegarVentana = false;
        Motivo = null;
             
     }
    
    public void MostrarVentanaDenegacion()
    {
		DenegarVentana = true;
       
    } 
    
    public void popSalirImagen()
    {    
        DenegarImagen = false;
        cargarFile = false;
        isPdf = false;
        isImage = false;
             
     }
    
    public Boolean validatenum (string tovalidate)
    {
        
        
        string regex = '^(0*[1-9][0-9]*(.[0-9]*)?|0*.[0-9]*[1-9][0-9]*)$';
        Pattern MyPattern = Pattern.compile(regex);
        Matcher MyMatcher = MyPattern.matcher(tovalidate);
        result = MyMatcher.matches();
        /*
        string respuesta = string.valueOf(result);
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, respuesta));*/
        return result;
    }
	//^[0-9]{3,4}(-[0-9]{3,4})?$
	public Boolean validateid (string tovalidate)
    {
        
        
        string regex = '^(0*[-1-9][-0-9]*(.[-0-9]*)?|0*.[-0-9]*[-1-9][-0-9]*)$';
        Pattern MyPattern = Pattern.compile(regex);
        Matcher MyMatcher = MyPattern.matcher(tovalidate);
        result = MyMatcher.matches();
        /*
        string respuesta = string.valueOf(result);
         ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, respuesta));*/
        return result;
    }
    
    public void Busca1(){
        //MuestraTabla = true;
        try{        
            classcambiopignorados  claseEnvio = new classcambiopignorados();
            classcambiopignorados fcsd = ControllerAPIPignorados.BuscarCuenta(cuentapig);//parametro que se extraen de la api 
            
            if(!test.isRunningTest()){
                ListPignorados = fcsd.ListPignorados;
                }
            //ListPignorados = fcsd.ListPignorados;//Extrae la lista desde c#
            tama = ListPignorados.size();//Indica los numeros de elemento que hay en la lista cuando se ejecuta la consulta 
            validatenum(cuentapig);
            
            
            if(cuentapig == ''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar una cuenta'));    
                limpiar1 ();
            }
            
            else if(result == false){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'La cuenta debe ir con solo numeros'));    
                limpiar1 ();
            } 
            
            else if ( tama == 0 ){
                
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no encontrado por favor revise los datos que ingreso'));
                limpiar1 ();
                
            }
            else{
                BuscaInfor1();   
            }
        }
        Catch(Exception e){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
            
        }
        
    }
    
    
    public void BuscaInfor1(){        
        try{    
            
            classcambiopignorados  claseEnvio = new classcambiopignorados();
            classcambiopignorados fcsd = ControllerAPIPignorados.BuscarCuenta(cuentapig);//parametros que se extraen de la api BucarCuenta
            system.debug('Respueta BuscaInfor: '+fcsd); 
            
            if(!test.isRunningTest()){
                ListPignorados = fcsd.ListPignorados;
                }
            //ListPignorados = fcsd.ListPignorados;//Extrae la lista desde c#
            tama = ListPignorados.size();//Indica los numeros de elemento que hay en la lista cuando se ejecuta la consulta
            system.debug('Listamovimientos: '+ ListPignorados);// Aqui muestra la lista que va a aparecer como respuesta en los registro de depuracion 
            actList();
            
            if(tama == 1 )
            {
                MuestraTabla = true;
            }else if (tama > 1)
            {
                MuestraTabla = false;
                MuestraTabla2 = true;
            }
            
            
            
            if(ListPignorados != null){
                cuentapig = ListPignorados[0].codcuenta;
                nombrepig  = ListPignorados[0].nombrepig;
                id_pign = ListPignorados[0].id_pign;
                num_prest = ListPignorados[0].num_prest1;
                //Muestra la tabla que se hace de la consulta 
                
            }
            for(integer i=0; i<ListPignorados.size(); i++)
                //extrae de la clase todos elementos que se encuentran dentro de la tabla
            {
                classcambiopignorados p = new classcambiopignorados();
                
                p.codcuenta =  ListPignorados[i].codcuenta;
                p.m_pignorado=  ListPignorados[i].m_pignorado;
                p.fpignoracion =  ListPignorados[i].fpignoracion;
                p.fliberacion = ListPignorados[i].fliberacion;
                p.num_prest = ListPignorados[i].num_prest1;
                p.num_prest1 = ListPignorados[i].num_prest1;
                p.est_pig =  ListPignorados[i].est_pig; 
                p.sec_pig =  ListPignorados[i].sec_pig;
                p.tot_fondos_pig =  ListPignorados[i].tot_fondos_pig;
                p.m_prestamo =  ListPignorados[i].m_prestamo;
                system.debug('PRESTAMOOOOOOO '+ p.num_prest);
            }
            
            //  } //fin else
        }
        Catch(Exception e){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error1: ' + e.getMessage()+' LINEA '+ e.getLineNumber()));
            
        }
    }
    
    
    
    public void Busca2(){
        try{        
            
            classcambiopignorados  claseEnvio = new classcambiopignorados();
            classcambiopignorados fcsd = ControllerAPIPignorados.BuscarNPrestamo(num_prest);//parametro que se extraen de la api 
            
            if(!test.isRunningTest()){
                ListPignorados = fcsd.ListPignorados;
                }
            //ListPignorados = fcsd.ListPignorados;//Extrae la lista desde c#
            tama = ListPignorados.size();//Indica los numeros de elemento que hay en la lista cuando se ejecuta la consulta 
            validatenum(num_prest);
            if(num_prest == '' ){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar un numero de prestamo'));    
                
            }
            
            else if(result == false ){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El numero de prestamo debe ir con solo numeros'));    
                limpiar1 ();
            } 
            
            else if ( tama == 0){
                
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no encontrado por favor revise los datos que ingreso'));
                limpiar1 ();
                
            }
            else{
                BuscaInfor2();   
            }
        }
        Catch(Exception e){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
            
        }
        
    }
    
    
    public void BuscaInfor2(){        
        try{    
            
            classcambiopignorados  claseEnvio = new classcambiopignorados();
            classcambiopignorados fcsd = ControllerAPIPignorados.BuscarNPrestamo(num_prest);//parametros que se extraen de la api BucarCuenta
            system.debug('Respueta BuscaInfor: '+fcsd); 
            
            if(!test.isRunningTest()){
                ListPignorados = fcsd.ListPignorados;
                }
            //ListPignorados = fcsd.ListPignorados;//Extrae la lista desde c#
            tama = ListPignorados.size();//Indica los numeros de elemento que hay en la lista cuando se ejecuta la consulta
            system.debug('Listamovimientos: '+ ListPignorados);// Aqui muestra la lista que va a aparecer como respuesta en los registro de depuracion 
            actList();
            
            if(tama == 1)
            {
                MuestraTabla = true;
            }else if (tama > 1 )
            {
                MuestraTabla = false;
                MuestraTabla2 = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El cliente tiene varias cuentas, tome la que necesita para realizar la búsqueda específica'));
            }
            
            
            
            if(ListPignorados != null){
                cuentapig = ListPignorados[0].codcuenta;
                nombrepig = ListPignorados[0].nombrepig;
                id_pign = ListPignorados[0].id_pign;
                num_prest = ListPignorados[0].num_prest1;
                
                
            }
            for(integer i=0; i< ListPignorados.size(); i++)
                //extrae de la clase todos elementos que se encuentran dentro de la tabla
            {
                classcambiopignorados p = new classcambiopignorados();
                p.codcuenta =  ListPignorados[i].codcuenta;
                p.m_pignorado=  ListPignorados[i].m_pignorado;
                p.fpignoracion =  ListPignorados[i].fpignoracion;
                p.fliberacion = ListPignorados[i].fliberacion;
                p.num_prest = ListPignorados[i].num_prest1;
                p.num_prest1 = ListPignorados[i].num_prest1;
                p.est_pig =  ListPignorados[i].est_pig; 
                p.sec_pig = ListPignorados[i].sec_pig;
                p.tot_fondos_pig = ListPignorados[i].tot_fondos_pig;
                p.m_prestamo = ListPignorados[i].m_prestamo;
                system.debug('PRESTAMO '+ ListPignorados[i].num_prest1);
                
            }
            
            //  } //fin else
        }
        Catch(Exception e){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error1: ' + e.getMessage()+' LINEA '+ e.getLineNumber()));
            
        }
    }
    
    
    public void Busca3(){
        try{        
            
            classcambiopignorados  claseEnvio = new classcambiopignorados();
            classcambiopignorados fcsd = ControllerAPIPignorados.BuscarIdentidad(id_pign);//parametro que se extraen de la api 
            
            if(!test.isRunningTest()){
                ListPignorados = fcsd.ListPignorados;
                }
            //ListPignorados = fcsd.ListPignorados;//Extrae la lista desde c#
            tama = ListPignorados.size();//Indica los numeros de elemento que hay en la lista cuando se ejecuta la consulta 
            validateid(id_pign);
            if(id_pign == ''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar una identidad'));    
                
            }
        	
            else if(result == false){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'La identidad debe ir con solo numeros'));    
                limpiar1 ();
            } 
                
            else if ( tama == 0){
                
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no encontrado por favor revise los datos que ingreso'));
                limpiar1 ();
                
            }
            else{
                BuscaInfor3();   
            }
            //system.debug('LOQUEENVIA: '+identidad);
        }
        Catch(Exception e){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
            
        }
        
    }
    
    
    public void BuscaInfor3(){        
        try{    
            
            classcambiopignorados  claseEnvio = new classcambiopignorados();
            classcambiopignorados fcsd = ControllerAPIPignorados.BuscarIdentidad(id_pign);//parametros que se extraen de la api BucarCuenta
            system.debug('Respueta BuscaInfor: '+fcsd); 
            
            if(!test.isRunningTest()){
                ListPignorados = fcsd.ListPignorados;
                }
            //ListPignorados = fcsd.ListPignorados;//Extrae la lista desde c#
            tama = ListPignorados.size();//Indica los numeros de elemento que hay en la lista cuando se ejecuta la consulta
            system.debug('Listamovimientos: '+ ListPignorados);// Aqui muestra la lista que va a aparecer como respuesta en los registro de depuracion 
            actList();
            
            if(tama == 1)
            {
                MuestraTabla = true;
            }else if (tama > 1)
            {
                MuestraTabla = false;
                MuestraTabla2 = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El cliente tiene varias cuentas, tome la que necesita para realizar la búsqueda específica'));

            }
            
            
            
            if(ListPignorados != null){
                cuentapig = ListPignorados[0].codcuenta;
                nombrepig = ListPignorados[0].nombrepig;
                id_pign = ListPignorados[0].id_pign;
                num_prest = ListPignorados[0].num_prest1;
                
                
            }
            for(integer i=0; i< ListPignorados.size(); i++)
                //extrae de la clase todos elementos que se encuentran dentro de la tabla
            {
                classcambiopignorados p = new classcambiopignorados();
                p.codcuenta =  ListPignorados[i].codcuenta;
                p.m_pignorado=  ListPignorados[i].m_pignorado;
                p.fpignoracion =  ListPignorados[i].fpignoracion;
                p.fliberacion = ListPignorados[i].fliberacion;
                p.num_prest = ListPignorados[i].num_prest1;
                p.num_prest1 = ListPignorados[i].num_prest1;
                p.est_pig =  ListPignorados[i].est_pig; 
                p.sec_pig =  ListPignorados[i].sec_pig;
                p.tot_fondos_pig =  ListPignorados[i].tot_fondos_pig;
                p.m_prestamo = ListPignorados[i].m_prestamo;
                p.nombrepig = ListPignorados[i].nombrepig;
            }
            
            //  } //fin else
            //system.debug('LOQUEENVIA1: '+identidad);
        }
        Catch(Exception e){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error1: ' + e.getMessage()+' LINEA '+ e.getLineNumber()));
            
        }
    }
    
    
    Public void Enviar(){
        Try{
            
            classActualizaPignorados x = new classActualizaPignorados();//Invocacion a la clase 
            Fondo_Pignorado__c listC;
            listC = new Fondo_Pignorado__c();
            list<Fondo_Pignorado__c> fondo = new list<Fondo_Pignorado__c>();
            x.estatus = 'I';
            
            for (integer i=0; i < ListPignorados.size(); i++ ) // ciclo for que recorre la lista para extraer los valores que se van a actualizar
            {
                
                x.numero_prestamo = ListPignorados[i].num_prest1;
                x.codcuenta = ListPignorados[i].codcuenta;
                x.monto_pignorado = ListPignorados[i].m_pignorado;
                x.fechapignoracion = date.valueOf(ListPignorados[i].fpignoracion);
                x.fechaliberacion = ListPignorados[i].fliberacion;
                x.numero_prestamo1 = ListPignorados[i].num_prest1;
                x.total_fondos = ListPignorados[i].tot_fondos_pig;
                x.monto_prestamo = ListPignorados[i].m_prestamo;
                x.estatus = ListPignorados[i].est_pig;
                x.usuario = usuario;
                x.secuencia = ListPignorados[0].sec_pig;
                //x.referencia = EncodingUtil.base64Encode(ListPignorados[i].referenciaImg);
                
                guardar_file('file' +num_prest,ListPignorados[i].referenciaImg);
                system.debug('Listamovimientos: '+ ListPignorados[i].num_prest);
              
            }
            if (x.fechapignoracion > Date.today()) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'La fecha de pignoración no puede ser mayor que hoy'));   
            }
            else if (x.fechaliberacion > Date.today()) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'La fecha de liberación no puede ser mayor que hoy'));
            } 
            else if (x.estatus != 'I' && x.estatus !=  'A') {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El estatus solo puede ser A (Activo) o I (Inactivo)'));
            }
            
            else {
                /*string resultado = ControllerAPIPignorados.ActualizarPignorados(x);//codigo que envia al api la accion para actualizar
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));//Codigo para mostrar en mensaje si hay error o esta ejecutando la accion bien.
                */ 
                               
                listC.Numero_Prestamo__c = x.numero_prestamo1;
                listC.Num_Prestamo__c = num_prest;
                listC.Monto_Pignorado__c = x.monto_pignorado;
                listC.Fecha_Pignoracion__c = x.fechapignoracion;
                listC.Fecha_Liberacion__c = x.fechaliberacion;
                listC.Monto_Prestamo__c = x.monto_prestamo;
                listC.Total_Fondos__c = x.total_fondos;
                listC.Usuario__c = x.usuario;
                listC.Estatus__c = x.estatus;
                listC.Estado__c = 'P';
                listC.Cuenta__c = x.codcuenta;
				listC.Descripcion__c = 'Pendiente';
                listC.secuencia__c = x.secuencia;
                //listC.Referencia__c = x.referencia;
                fondo.add(listC);
                System.debug('Prestamo '+ num_prest);                
              ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ingresado con éxito'));              
            }
            insert fondo;
            
            limpiar1 ();
               
        }
        Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
        
    }
    
    public void iniciar()
    {    
   
         McontenidoPign =[ select Id, Numero_Prestamo__c,Num_Prestamo__c,Monto_Pignorado__c,Fecha_Pignoracion__c,Fecha_Liberacion__c,Monto_Prestamo__c ,
                                    Total_Fondos__c,Usuario__c,Estatus__c, Estado__c, Cuenta__c, secuencia__c, Referencia__c
                            from Fondo_Pignorado__c
                            where Estado__c = 'P'];        
       
       
        total = McontenidoPign.size();
        System.debug('McontenidoPign '+ McontenidoPign);
     
    }
    
    Public void Autorizar()
    {
      Try{
            classActualizaPignorados x = new classActualizaPignorados();//Invocacion a la clase 
			Integer indice = -1;
            for (integer i=0; i < McontenidoPign.size(); i++ ) // ciclo for que recorre la lista para extraer los valores que se van a actualizar
            {
                if (McontenidoPign[i].Id == cod_obj || test.isRunningTest()){
                    System.debug('Num ' + McontenidoPign[i]);
                    x.Numero_Prestamo = McontenidoPign[i].Num_Prestamo__c;
	                x.Monto_Pignorado = McontenidoPign[i].Monto_Pignorado__c;
    	            x.fechapignoracion = McontenidoPign[i].Fecha_Pignoracion__c;
        	        x.fechaliberacion = McontenidoPign[i].Fecha_Liberacion__c;
            	    x.numero_prestamo1 = McontenidoPign[i].Numero_Prestamo__c;
                	x.total_fondos = McontenidoPign[i].Total_Fondos__c;
                	x.monto_prestamo = McontenidoPign[i].Monto_Prestamo__c;
                	x.estatus = McontenidoPign[i].Estatus__c;
                	x.usuario = McontenidoPign[i].Usuario__c;
                    x.usuarioApro = Usuario;
                    //x.referencia = McontenidoPign[i].Referencia__c;
                    System.debug('SE ve la imagen ' + x.referencia);
                    McontenidoPign[i].Estado__c = 'A';
                    indice = i;
                    
                  
                }
            }
            
                string resultado = ControllerAPIPignorados.ActualizarPignorados(x);//codigo que envia al api la accion para actualizar
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));//Codigo para mostrar en mensaje si hay error o esta ejecutando la accion bien.
           if(indice != -1 ){
                    delete McontenidoPign[indice];
                } //elimina el contenido del objeto
      			iniciar(); 
          
        }
        Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }  
      
    }
    
    public void correoUsuario(){
        TRY{
            cod_empleado = [select Usuario__c from Fondo_Pignorado__c where Id =: cod_obj].Usuario__c;
        	correoEmpleado = [select Email__c from Usuarios_de_Pantallas__c where Usuario__c =: cod_empleado].Email__c;
            correoEmpleado2 = [select Email__c from Usuarios_de_Pantallas__c where Usuario__c =: Usuario].Email__c;
            nom_empleado = [select Name from Usuarios_de_Pantallas__c where Usuario__c =: cod_empleado].Name;
        }
        CATCH(exception e){
            
        }
        
        
    }
   
    public void DenegarLista()
     {  
         
         try
         {
          
     		if (Motivo == '') {ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'La Descripcion No Puede Estar Vacia!'));
            }
            else 
            {
                
                correoUsuario(); //obtener el correo del oficial que gestiona y el que aprueba
                Fondo_Pignorado__c modifi = new Fondo_Pignorado__c ();
                    
                    //modifi = [select Codigo_Referencia__c, Oficial_de_negocios__c, Estado_Aporte__c, Descripcion__c from Pantalla_Aportes__c where Codigo_Referencia__c =: Num_CodReferenciaDenegado limit 1];
                
                	modifi = [select Numero_Prestamo__c, Estado__c, Descripcion__c from Fondo_Pignorado__c where Id =: cod_obj];
                    modifi.Estado__c = 'D';
                    modifi.Descripcion__c = Motivo; 
                    delete modifi;
                			
                
           
           		        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
						Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setHtmlBody( 'Buen Dia '+ nom_empleado +' , el fondo pignorado con el numero de prestamo ' + 
                                          num_prest + ' ha sido DENEGADO, Por el siguiente motivo: ' + modifi.Descripcion__c);
                        mail.setSubject('Fondo Pignorado con Número de Prestamo ' + num_prest + ' DENEGADO');
                        mail.setToAddresses(new String[] {correoEmpleado, correoEmpleado2});
						mail.setOrgWideEmailAddressId(owea.get(0).Id);
                        mail.setSaveAsActivity(true);
                        listCorreo.add(mail);
                        Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
               
                   ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Registro Denegado'));
                    DenegarVentana = false;
                	Motivo = null;
            }
                    
             
           iniciar();
             
         }catch(exception e)
            {
                system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
                //ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!'));
             }   
     }
    
    
    
    
    public void limpiar1 () {
        cuentapig = null;
        num_prest = null;
        nombrepig = null;
        id_pign = null;
        tama = null;
        MuestraTabla = false;
        MuestraTabla2 = false;
    }
    
    
    public void LimpiarTabla() {
        MuestraTabla = false;
        MuestraTabla2 = false;
    }
    
    public void Cancelar () {
        limpiar1 ();
        LimpiarTabla();
    }
	
    public void actList() {
  			List <Fondo_Pignorado__c> tea = new List<Fondo_Pignorado__c>();
            tea.addAll([Select Id, Secuencia__c From Fondo_Pignorado__c]);
            
            for(integer j=0; j<tea.size(); j++){
                for(integer i=0; i<ListPignorados.size(); i++){
                    if(tea[j].secuencia__c == ListPignorados[0].sec_pig){
                        ListPignorados.remove(i);
                    }
            	}
            }
     } 
    
    public void guardar_file(string name, blob file){
    	list <ContentVersion> flist = [select VersionData, ContentDocumentId from ContentVersion where title = : name limit 1]; 
            
        if(file == null){
                file = blob.valueOf('No hay Referencia');
            }
        if ( flist.size() > 0 ){
            ContentDocument cd = [Select id from ContentDocument Where id =: flist[0].ContentDocumentId];
            delete cd;
        }
        
        transient Contentversion f = new ContentVersion(
            Title = name,
            PathOnClient = '/' + filename,
            VersionData = file);
       
        insert f;
        system.debug('Se guardo la Imagen');
    	  
    }
       public void MostrarImagen(){
           
           String nombre = 'file' + ID_Referencia;
               
           System.debug('secuencia ' + nombre);     
        try
            {
                /*ControllerAPIPagoIntereses.classRespuestaImagen wer =  new ControllerAPIPagoIntereses.classRespuestaImagen();
            	wer = ControllerAPIPagoIntereses.TraerImagenBD(ID_Referencia);*/
                ContentVersion flist = [select VersionData, FileExtension  from ContentVersion where title = :nombre limit 1];
                if(flist != null){
                     System.debug('ext '+ flist.FileExtension);
                    if(flist.FileExtension == 'pdf'){
                        ct = 'application/pdf';
                        isPdf = true;
                        isImage = false;
                     }else if(flist.FileExtension == 'png'){
                     	ct = 'image/png';
                         isPdf = false;
                        isImage = true;
                     }else{
                         ct = 'image/jpg';
                         isPdf = false;
                        isImage = true;
                     }
                    
                    Ver_Imagen = EncodingUtil.base64Encode(flist.VersionData);
                    
                    
                    if(Ver_Imagen!='Tm8gaGF5IFJlZmVyZW5jaWE='){
                        cargarFile = true;
                    }else{
                		ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'No hay referencia'));
            		}
                    
                }else{
                	ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'No hay referencia'));
            	}
            	
            
        }
        catch(exception e)
        {
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!'+ e.getMessage() + ' Linea: ' + e.getLineNumber()));
        }      
        
    }  
    
}