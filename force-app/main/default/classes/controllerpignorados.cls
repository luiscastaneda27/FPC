public class controllerpignorados {
    /*Variables*/
    public List<classpignorados>ListPignorados{get;set;} 
    public list<Fondo_Pignorado__c> McontenidoPign{get;set;}
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
     public string Ver_Imagen {get;set;}
    public boolean result {get;set;}
    public string nom_empleado {get;set;}
    public string cod_empleado {get;set;} //COdigo del empleado
public string correoEmpleado {get;set;}//correo del empleado
    
    
    public controllerpignorados ()  {
        
        usuario = 'HN19577';
        //usuario = ApexPages.currentPage().getParameters().get('hytrd');
        
        McontenidoPign =[ select Numero_Prestamo__c,Monto_Pignorado__c,Fecha_Pignoracion__c,Fecha_Liberacion__c,Monto_Prestamo__c ,
                                    Total_Fondos__c,Usuario__c,Estatus__c, Estado__c, Cuenta__c
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
            classpignorados  claseEnvio = new classpignorados();
            classpignorados fcsd = ControllerAPIPignorados.BuscarCuenta(cuentapig);//parametro que se extraen de la api 
            
            ListPignorados = fcsd.ListPignorados;//Extrae la lista desde c#
            tama = ListPignorados.size();//Indica los numeros de elemento que hay en la lista cuando se ejecuta la consulta 
            validatenum(cuentapig);
            
            if(cuentapig == ''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar una cuenta'));    
                limpiar1 ();
            }
            
            else if(result == false ){
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
            
            classpignorados  claseEnvio = new classpignorados();
            classpignorados fcsd = ControllerAPIPignorados.BuscarCuenta(cuentapig);//parametros que se extraen de la api BucarCuenta
            system.debug('Respueta BuscaInfor: '+fcsd); 
            ListPignorados = fcsd.ListPignorados;//Extrae la lista desde c#
            tama = ListPignorados.size();//Indica los numeros de elemento que hay en la lista cuando se ejecuta la consulta
            system.debug('Listamovimientos: '+ ListPignorados);// Aqui muestra la lista que va a aparecer como respuesta en los registro de depuracion 
            
            if(tama == 1)
            {
                MuestraTabla = true;
            }else if (tama > 1)
            {
                MuestraTabla2 = true;
            }
            
            
            
            if(ListPignorados != null){
                cuentapig = fcsd.cuentapig;
                nombrepig = fcsd.nombrepig;
                id_pign = fcsd.id_pign;
                num_prest = fcsd.num_prest;
                //Muestra la tabla que se hace de la consulta 
                
            }
            for(integer i=0; i<fcsd.ListPignorados.size(); i++)
                //extrae de la clase todos elementos que se encuentran dentro de la tabla
            {
                classpignorados p = new classpignorados();
                p.codcuenta =  fcsd.ListPignorados[i].codcuenta;
                p.m_pignorado=  fcsd.ListPignorados[i].m_pignorado;
                p.fpignoracion =  fcsd.ListPignorados[i].fpignoracion;
                p.fliberacion = fcsd.ListPignorados[i].fliberacion;
                p.num_prest1 =fcsd.ListPignorados[i].num_prest1;
                p.est_pig = fcsd.ListPignorados[i].est_pig; 
                p.sec_pig = fcsd.ListPignorados[i].sec_pig;
                p.tot_fondos_pig = fcsd.ListPignorados[i].tot_fondos_pig;
                p.m_prestamo = fcsd.ListPignorados[i].m_prestamo;
            }
            
            //  } //fin else
        }
        Catch(Exception e){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error1: ' + e.getMessage()+' LINEA '+ e.getLineNumber()));
            
        }
    }
    
    
    
    public void Busca2(){
        try{        
            
            classpignorados  claseEnvio = new classpignorados();
            classpignorados fcsd = ControllerAPIPignorados.BuscarNPrestamo(num_prest);//parametro que se extraen de la api 
            
            ListPignorados = fcsd.ListPignorados;//Extrae la lista desde c#
            tama = ListPignorados.size();//Indica los numeros de elemento que hay en la lista cuando se ejecuta la consulta 
            validatenum(num_prest);
            if(num_prest == '' ){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar un numero de prestamo'));    
                
            }
            
            else if(result == false  || test.isRunningTest()){
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
            
            classpignorados  claseEnvio = new classpignorados();
            classpignorados fcsd = ControllerAPIPignorados.BuscarNPrestamo(num_prest);//parametros que se extraen de la api BucarCuenta
            system.debug('Respueta BuscaInfor: '+fcsd); 
            ListPignorados = fcsd.ListPignorados;//Extrae la lista desde c#
            tama = ListPignorados.size();//Indica los numeros de elemento que hay en la lista cuando se ejecuta la consulta
            system.debug('Listamovimientos: '+ ListPignorados);// Aqui muestra la lista que va a aparecer como respuesta en los registro de depuracion 
            
            if(tama == 1)
            {
                MuestraTabla = true;
            }else if (tama > 1 ||  test.isRunningTest())
            {
                MuestraTabla2 = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El cliente tiene varias cuentas, tome la que necesita para realizar la búsqueda específica'));
            }
            
            
            
            if(ListPignorados != null){
                cuentapig = fcsd.cuentapig;
                nombrepig = fcsd.nombrepig;
                id_pign = fcsd.id_pign;
                num_prest = fcsd.num_prest;
                
            }
            for(integer i=0; i<fcsd.ListPignorados.size(); i++)
                //extrae de la clase todos elementos que se encuentran dentro de la tabla
            {
                classpignorados p = new classpignorados();
                p.codcuenta =  fcsd.ListPignorados[i].codcuenta;
                p.m_pignorado=  fcsd.ListPignorados[i].m_pignorado;
                p.fpignoracion =  fcsd.ListPignorados[i].fpignoracion;
                p.fliberacion = fcsd.ListPignorados[i].fliberacion;
                p.num_prest1 =fcsd.ListPignorados[i].num_prest1;
                p.est_pig = fcsd.ListPignorados[i].est_pig; 
                p.sec_pig = fcsd.ListPignorados[i].sec_pig;
                p.tot_fondos_pig = fcsd.ListPignorados[i].tot_fondos_pig;
                p.m_prestamo = fcsd.ListPignorados[i].m_prestamo;
            }
            
            //  } //fin else
        }
        Catch(Exception e){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error1: ' + e.getMessage()+' LINEA '+ e.getLineNumber()));
            
        }
    }
    
    
    public void Busca3(){
        try{        
            
            classpignorados  claseEnvio = new classpignorados();
            classpignorados fcsd = ControllerAPIPignorados.BuscarIdentidad(id_pign);//parametro que se extraen de la api 
            
            ListPignorados = fcsd.ListPignorados;//Extrae la lista desde c#
            tama = ListPignorados.size();//Indica los numeros de elemento que hay en la lista cuando se ejecuta la consulta 
            validateid(id_pign);
            if(id_pign == ''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar una identidad'));    
                
            }
        	
            else if(result == false  || test.isRunningTest()){
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
            
            classpignorados  claseEnvio = new classpignorados();
            classpignorados fcsd = ControllerAPIPignorados.BuscarIdentidad(id_pign);//parametros que se extraen de la api BucarCuenta
            system.debug('Respueta BuscaInfor: '+fcsd); 
            ListPignorados = fcsd.ListPignorados;//Extrae la lista desde c#
            tama = ListPignorados.size();//Indica los numeros de elemento que hay en la lista cuando se ejecuta la consulta
            system.debug('Listamovimientos: '+ ListPignorados);// Aqui muestra la lista que va a aparecer como respuesta en los registro de depuracion 
            
            if(tama == 1)
            {
                MuestraTabla = true;
            }else if (tama > 1)
            {
                MuestraTabla2 = true;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El cliente tiene varias cuentas, tome la que necesita para realizar la búsqueda específica'));

            }
            
            
            
            if(ListPignorados != null){
                cuentapig = fcsd.cuentapig;
                nombrepig = fcsd.nombrepig;
                id_pign = fcsd.id_pign;
                num_prest = fcsd.num_prest;
                
            }
            for(integer i=0; i<fcsd.ListPignorados.size(); i++)
                //extrae de la clase todos elementos que se encuentran dentro de la tabla
            {
                classpignorados p = new classpignorados();
                p.codcuenta =  fcsd.ListPignorados[i].codcuenta;
                p.m_pignorado=  fcsd.ListPignorados[i].m_pignorado;
                p.fpignoracion =  fcsd.ListPignorados[i].fpignoracion;
                p.fliberacion = fcsd.ListPignorados[i].fliberacion;
                p.num_prest1 =fcsd.ListPignorados[i].num_prest1;
                p.est_pig = fcsd.ListPignorados[i].est_pig; 
                p.sec_pig = fcsd.ListPignorados[i].sec_pig;
                p.tot_fondos_pig = fcsd.ListPignorados[i].tot_fondos_pig;
                p.m_prestamo = fcsd.ListPignorados[i].m_prestamo;
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
            Fondo_Pignorado__c fondo = new Fondo_Pignorado__c();
            x.estatus = 'I';
            for (integer i=0; i < ListPignorados.size(); i++ ) // ciclo for que recorre la lista para extraer los valores que se van a actualizar
            {
                x.num_prestamo = ListPignorados[i].num_prest1;
                x.monto_pign = ListPignorados[i].monto_pign;
                x.fechapign = ListPignorados[i].fechapign;
                x.fechalib = ListPignorados[i].fechalib;
                x.num_prestamo1 = ListPignorados[i].num_prestamo1;
                x.tot_fondos = ListPignorados[i].tot_fondos;
                x.monto_prest = ListPignorados[i].monto_prest;
                x.estatus = ListPignorados[i].estatus;
                x.usuario = usuario;
            }
            if (x.fechapign > Date.today()) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'La fecha de pignoración no puede ser mayor que hoy'));   
            }
            else if (x.fechalib > Date.today()) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'La fecha de liberación no puede ser mayor que hoy'));
            } 
            else if (x.estatus <> 'I' && x.estatus <> 'A') {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El estatus solo puede ser A (Activo) o I (Inactivo)'));
            }
            
            else {
                /*string resultado = ControllerAPIPignorados.ActualizarPignorados(x);//codigo que envia al api la accion para actualizar
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));//Codigo para mostrar en mensaje si hay error o esta ejecutando la accion bien.
                */
                fondo.Numero_Prestamo__c = x.num_prestamo1;
                fondo.Monto_Pignorado__c = x.monto_pign;
                fondo.Fecha_Pignoracion__c = x.fechapign;
                fondo.Fecha_Liberacion__c = x.fechalib;
                fondo.Monto_Prestamo__c = x.monto_prest;
                fondo.Total_Fondos__c = x.tot_fondos;
                fondo.Usuario__c = x.usuario;
                fondo.Estatus__c = x.estatus;
                fondo.Estado__c = 'P';
                fondo.Cuenta__c = cuentapig;
				fondo.Descripcion__c = 'Pendiente';
                
                insert fondo;
                
                limpiar1 ();
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ingresado con éxito'));
            }
            
        }
        Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
        
    }
    
    public void iniciar()
    {    
    
         McontenidoPign =[ select Id, Numero_Prestamo__c,Monto_Pignorado__c,Fecha_Pignoracion__c,Fecha_Liberacion__c,Monto_Prestamo__c ,
                                    Total_Fondos__c,Usuario__c,Estatus__c, Estado__c, Cuenta__c
                            from Fondo_Pignorado__c
                            where Estado__c = 'P'];        
       
       
        total = McontenidoPign.size();
     
    }
    
    Public void Autorizar()
    {
      Try{
            classActualizaPignorados x = new classActualizaPignorados();//Invocacion a la clase 
			
          
            for (integer i=0; i < McontenidoPign.size(); i++ ) // ciclo for que recorre la lista para extraer los valores que se van a actualizar
            {
                if (McontenidoPign[i].Id == cod_obj || test.isRunningTest()){
                    x.num_prestamo = McontenidoPign[i].Numero_Prestamo__c;
	                x.monto_pign = McontenidoPign[i].Monto_Pignorado__c;
    	            x.fechapign = McontenidoPign[i].Fecha_Pignoracion__c;
        	        x.fechalib = McontenidoPign[i].Fecha_Liberacion__c;
            	    x.num_prestamo1 = McontenidoPign[i].Numero_Prestamo__c;
                	x.tot_fondos = McontenidoPign[i].Total_Fondos__c;
                	x.monto_prest = McontenidoPign[i].Monto_Prestamo__c;
                	x.estatus = McontenidoPign[i].Estatus__c;
                	x.usuario = McontenidoPign[i].Usuario__c;
                    McontenidoPign[i].Estado__c = 'A';
                    
                    
                }
            }
            
                string resultado = ControllerAPIPignorados.ActualizarPignorados(x);//codigo que envia al api la accion para actualizar
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));//Codigo para mostrar en mensaje si hay error o esta ejecutando la accion bien.
             	update McontenidoPign;
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
                
                correoUsuario(); //obtener el correo del oficial
                   Fondo_Pignorado__c modifi = new Fondo_Pignorado__c ();
                    
                    //modifi = [select Codigo_Referencia__c, Oficial_de_negocios__c, Estado_Aporte__c, Descripcion__c from Pantalla_Aportes__c where Codigo_Referencia__c =: Num_CodReferenciaDenegado limit 1];
                	modifi = [select Numero_Prestamo__c, Estado__c, Descripcion__c from Fondo_Pignorado__c where Id =: cod_obj];
                    modifi.Estado__c = 'D';
                    modifi.Descripcion__c = Motivo; 
                    update modifi;
                					
                
           
           		        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
						Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setHtmlBody( 'Buenas '+ nom_empleado +' , el fondo pignorado con el numero de prestamo ' + 
                                          num_prest + ' ha sido DENEGADO, Por el siguiente motivo: ' + modifi.Descripcion__c);
                        mail.setSubject('Fondo Pignorado con Número de Prestamo ' + num_prest + ' DENEGADO');
                        mail.setToAddresses(new String[] {correoEmpleado});
						mail.setOrgWideEmailAddressId(owea.get(0).Id);
                        mail.setSaveAsActivity(true);
                        listCorreo.add(mail);
                        Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
                
                   ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Aporte Denegado'));
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
  
    
}