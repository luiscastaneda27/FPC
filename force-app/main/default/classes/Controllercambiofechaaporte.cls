public class Controllercambiofechaaporte {
 /*Variables*/
    public List<classfechacambioaporte>ListFechaAct{get;set;} 
    public string codCuenta {get;set;}
    public string Usuario {get;set;}
    public date fechaporte {get;set;}
    public string nombre {get;set;}
    public string pcproducto {get;set;}
    public string pcsubproducto {get; set;}
    public integer tama {get;set;}
    public date nuevafecha1 {get; set;}
    public date nuevafecha {get; set;}
    public string referencia {get;set;}
    public string observaciones {get; set;}
    public Account TipMoneda{get;set;}
    public string num_doc {get; set;}
    public List<SelectOption> opcionSubproducto {get;set;}
    public List<SelectOption> opciones {get;set;}
	public integer contador {get;set;}
 	public date FCsysde {get; set;}
    public string NombreUsuario {get;set;}
    public string correoEmpleado {get;set;}
    public string correoEmpleado1 {get;set;}
     public string correoEmpleado2 {get;set;}
    public OrgWideEmailAddress[] owea {get;set;}
    public string idEmail {get;set;}
    public Blob referenciaImg {get;set;}
    
    //AGREGADO 22082019
    public boolean MuestraTabla {get;set;}
  	//variables del boton eliminar
    public string obsEliminar{get;set;}
   
    
    /* public void MuestraTabla(){ 
        Buscar=True;
    }    
    //FIN*/
	  
    public Controllercambiofechaaporte()//Inicializacion de las variables que utilizan objetos
    {
        TipMoneda = new Account();
        TipMoneda.Tipo_Moneda__c = null;  
        opciones=new List<SelectOption>();
        opcionSubproducto = new List<SelectOption>();  
        obsEliminar = '';
    }
    
    public void Busca(){
        try{        
            
            classfechacambioaporte  claseEnvio = new classfechacambioaporte();
            classfechacambioaporte fcsd = ControllerAPIFechCambioAporte.BuscarCuenta(fechaporte, codCuenta);//fechaporte,codCuenta parametros que se extraen de la api BucarCuenta
            
            //instrucciones para mostrar solo elementos que no estan pendientes de aprobacion
            
            ListFechaAct = fcsd.ListFechaAct;//Extrae la lista desde c#
            actList();
            
            tama = ListFechaAct.size();//Indica los numeros de elemento que hay en la lista cuando se ejecuta la consulta 
            
            /*if (fechaporte == null ){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar Fecha'));             
            }    
            else */if(codCuenta == ''/* || test.isRunningTest()*/ ){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar una cuenta'));    
                
            }
            
            else if ( tama == 0){
                
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no encontrado por favor revise los datos ingresados'));
                limpiar1 ();
                 
            }
            else{
                BuscaInfor();   
            }
        }
        Catch(Exception e){
             //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        	
        }
        
    }

    //Codigo de consulta por medio de la fecha de aporte y el codigo de la cuenta
    public void BuscaInfor(){        
        try{    
            
            classfechacambioaporte  claseEnvio = new classfechacambioaporte();
            classfechacambioaporte fcsd = ControllerAPIFechCambioAporte.BuscarCuenta(fechaporte, codCuenta);//fechaporte,codCuenta parametros que se extraen de la api BucarCuenta
            system.debug('Respueta BuscaInfor: '+fcsd); 
            //list<classfechacambioaporte>ListFechaAct  = new List<classfechacambioaporte>();
            //ListFechaAct.clear();
            
            //instrucciones para mostrar solo elementos que no estan pendientes de aprobacion
            ListFechaAct = fcsd.ListFechaAct;//Extrae la lista desde c#
            actList();
            
            tama = ListFechaAct.size();//Indica los numeros de elemento que hay en la lista cuando se ejecuta la consulta
            system.debug('Listamovimientos: '+ ListFechaAct);// Aqui muestra la lista que va a aparecer como respuesta en los registro de depuracion 
            
            //Aqui Inicia 22082019
            //Validación que se usa para que el usuario no deje vacio las cajas de texto de fecha aporte y cuenta
            /*if (fechaporte == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar una fecha para realizar la respectiva busqueda'));             
            }
            else if(codCuenta == ''){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar una cuenta'));   
            }             
            //Validacion para demostrar al usuario que no existe el cliente con los datos que ingreso
            else if ( tama == 0){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no encontrado por favor revise los datos que ingreso'));
            }
				            
            else {*/
            if(ListFechaAct != null){
                nombre = fcsd.nombre;//extrae el nombre de la clase classfechacambioaporte que esta en la base de datos
                //monedaC = fcsd.codProd;
                pcproducto = fcsd.codProd; //extrae el cod de producto que esta en la classfechacambioaporte en sales force que dicha clase viene de C#
                pcsubproducto = fcsd.SubProducto;//extrae el Sub producto que esta en la classfechacambioaporte en sales force que dicha clase viene de C#
                MuestraTabla = true;//Muestra la tabla que se hace de la consulta 
                
                opciones.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Producto__c item:[select name, codigo__c from Producto__c ])
                {
                    opciones.add(new selectOption(item.codigo__c, item.name));//Extrae el codigo del producto que está alojado en objetos
                }                
                
                opcionSubproducto.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Subproducto__c item:[select name, codigo__c from Subproducto__c where producto__r.codigo__c =: fcsd.codProd])//Extrae el sub producto y lo valida con una consulta de objetos
                {
                    opcionSubproducto.add(new selectOption(item.codigo__c, item.name));
                }
                //Valida el codigio del producto en lo que corresponde a la moneda si es 1 o 3 es lempiras y si es 2 o 4 es dolares 
                if( fcsd.codProd == '01'||fcsd.codProd == '03')
                {
                    TipMoneda.Tipo_Moneda__c = '1';
                    
                }
                else if ( fcsd.codProd == '02'||fcsd.codProd == '04' ) 
                {
                    TipMoneda.Tipo_Moneda__c = '2';
                }else 
                    TipMoneda.Tipo_Moneda__c = '';
                
                // ListFechaAct = fcsd.ListFechaAct; 
            }
            for(integer i=0; i<fcsd.ListFechaAct.size(); i++)
                //extrae de la clase todos elementos que se encuentran dentro de la tabla
            {
                /*
                classfechacambioaporte p = new classfechacambioaporte();
                p.nummov =  fcsd.ListFechaAct[i].nummov;
                p.tSaldo=  fcsd.ListFechaAct[i].tSaldo;
                p.montoPago =  fcsd.ListFechaAct[i].montoPago;
                p.descrip = fcsd.ListFechaAct[i].descrip;
                p.nuevafecha =fcsd.ListFechaAct[i].nuevafecha;
                p.num_doc = fcsd.ListFechaAct[i].num_doc;
                */
            }
            
          //  } //fin else
        }
        Catch(Exception e){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error1: ' + e.getMessage()+' LINEA '+ e.getLineNumber()));
            
        }
    }
    
    Public void Actualizar(){ 
        Try{
            //declaracion 
            contador = 0;
            list<Cambio_de_Fecha__c> cambiofecha = new list<Cambio_de_Fecha__c>();
            Cambio_de_Fecha__c listC;
            listC = new Cambio_de_Fecha__c();
            
            for (integer i=0; i < ListFechaAct.size(); i++ ) // ciclo for que recorre la lista para extraer los valores que se van a actualizar
            {
                
                //modificacion  fechaporte aSysdeCallouts.fechaCierreSysde(date.today())
                //Comentado por test
                if(FCsysde==null){
                	FCsysde = [Select Fecha_cierre__c From FechaDC_Sysde__c Where Name = 'CierreAlDia' Limit 1].Fecha_cierre__c;
                }
                
                if (listFechaAct[i].nuevafecha < FCsysde || listFechaAct[i].nuevafecha==null || codCuenta == '') {
                    contador++;
                    }
                
                else {
                    listC = new Cambio_de_Fecha__c();
                    //almacena los objetos en la lista
                    listC.Cuenta__c= string.valueOf(codCuenta);  // 
                    listC.Producto__c = string.valueOf(pcproducto);  // 
                    listC.Fechadeaporte__c = date.valueOf(fechaporte);//
                    listC.Descripcion__c = string.valueOf(ListFechaAct[i].descrip);//
                    listC.Accion__c= string.valueOf('Actualizar');  //
                    listC.Moneda__c= string.valueOf(TipMoneda.Tipo_Moneda__c);  //
                    listC.Montopago__c = string.valueOf(ListFechaAct[i].montoPago);  //
                    listC.Nombrecliente__c = string.valueOf(nombre);//
                    listC.NoMovimiento__c = string.valueOf(ListFechaAct[i].nummov);//
                    listC.Nuevafecha__c = date.valueOf(ListFechaAct[i].nuevafecha);// 
                    listC.Obsevaciones__c= string.valueOf(ListFechaAct[i].observaciones);  //
                    listC.Subproducto__c = string.valueOf(pcsubproducto);  //
                    listC.Tiposaldo__c = string.valueOf(ListFechaAct[i].tSaldo);//
                    listC.num_doc__c = string.valueOf(ListFechaAct[i].num_doc);
                   // if(ListFechaAct[i].referenciaImg != null){
                     //   ControllerAPIPagoIntereses.classImagenReferencia wer =  new ControllerAPIPagoIntereses.classImagenReferencia();
                       // wer.Referencia = ListFechaAct[i].num_doc;
                        //wer.Imagen = EncodingUtil.base64Encode(ListFechaAct[i].referenciaImg);
                       //wer = ControllerAPIPagoIntereses.GuardarImagen(wer);
                        guardar_file(ListFechaAct[i].num_doc,ListFechaAct[i].referenciaImg);
            		//}
                    //listC.Usuario__c = usuario;
                    //listC.Usuario__c = usuario;
                    ////listC.Usuario__c = usuario;
                    //listC.Identificador_Carga__c = integer.valueOf(id_carga);
					            
                                      
                    cambiofecha.add(listC); 
                    
                    
               // string resultado = ControllerAPIFechCambioAporte.Actualizarfecha(afa);//codigo que envia al api la accion para actualizar
    			//ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));//Codigo para mostrar en mensaje si hay error o esta ejecutando la accion bien.
                
            }
            }
            // inserta la lista de objetos 
            insert cambiofecha;

            EnvioCorreo();
            
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'correcto '));
            if (tama==contador) {
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Los datos no fueron ingresados correctamente'));   
            }
            limpiar ();
            /*
            else if (afa.nuevafecha==null || test.isRunningTest()){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar una fecha para realizar la respectiva actualización'));
            }
            
            else if(codCuenta == ''|| test.isRunningTest()){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar una cuenta'));   
        	}
            
            */ 
            /*else {
                string resultado = ControllerAPIFechCambioAporte.Actualizarfecha(afa);//codigo que envia al api la accion para actualizar
    			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));//Codigo para mostrar en mensaje si hay error o esta ejecutando la accion bien.
                limpiar ();
            }*/
            
        }
       Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
      
    }
    
     Public void Eliminar(){
        Try{
            //declaracion            
            Cambio_de_Fecha__c listC;
            listC = new Cambio_de_Fecha__c();
			
            /*almacena el objeto*/
			system.debug(obsEliminar);
            
            listC.Subproducto__c = string.valueOf(pcsubproducto); 
            listC.Accion__c= string.valueOf('Eliminar');  //
            listC.Moneda__c= string.valueOf(TipMoneda.Tipo_Moneda__c);
            listC.Producto__c = string.valueOf(pcproducto);  // 
            listC.Fechadeaporte__c = date.valueOf(fechaporte);
            listC.Cuenta__c= string.valueOf(codCuenta);
            listC.Nombrecliente__c = string.valueOf(nombre);
            listC.num_doc__c = string.valueOf(obsEliminar);
           
            for(integer i=0; i<ListFechaAct.size(); i++){
                if(ListFechaAct[i].num_doc == obsEliminar){
                    listC.NoMovimiento__c = string.valueOf(ListFechaAct[i].nummov);
                	listC.Tiposaldo__c = string.valueOf(ListFechaAct[i].tSaldo);
                	listC.Montopago__c = string.valueOf(ListFechaAct[i].montoPago);
                	listC.Descripcion__c = string.valueOf(ListFechaAct[i].descrip);
                    listC.Obsevaciones__c= string.valueOf(ListFechaAct[i].observaciones);
                    //if(ListFechaAct[i].referenciaImg != null){
                       /*ControllerAPIPagoIntereses.classImagenReferencia wer =  new ControllerAPIPagoIntereses.classImagenReferencia();
                       wer.Referencia = ListFechaAct[i].num_doc;
                       wer.Imagen = EncodingUtil.base64Encode(ListFechaAct[i].referenciaImg);
                       wer = ControllerAPIPagoIntereses.GuardarImagen(wer);*/
                       guardar_file(ListFechaAct[i].num_doc,ListFechaAct[i].referenciaImg);
                    
                    insert listC;
                    EnvioCorreo();
                    ListFechaAct.remove(i);
                    tama = ListFechaAct.size();
                }
                
            }
            
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'correcto '));
            if (tama==contador) {
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Los datos no fueron ingresados correctamente'));   
            }
            
        }
       Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
      
    }
    
    //Codigo que limpia la pantalla 
    public void limpiar () {
        pcsubproducto = null;
        ListFechaAct = null;
        nuevafecha1 = null;
        tama = null;        
        fechaporte = null;
        codCuenta = null;
        pcproducto = null;
        nombre = null;
        observaciones = null;
        MuestraTabla = false;
        //TipMoneda.Tipo_Moneda__c = null; // se comento por pruebas de test
       
    }
    
    public void limpiar1 () {
        pcsubproducto = null;
        ListFechaAct = null;
        nuevafecha1 = null;
        tama = null; 
        codCuenta = null;
        pcproducto = null;
        nombre = null;
        MuestraTabla = false;
        observaciones = null;
        //TipMoneda.Tipo_Moneda__c = null; // se comento por pruebas de test
       
    }
    
    
    public void LimpiarTabla() {
        MuestraTabla = false;
    }
    
    public void Cancelar () {
        limpiar ();
        LimpiarTabla();
    }
    
    public void actList() {
  			List <Cambio_de_Fecha__c> tea = new List<Cambio_de_Fecha__c>();
            tea.addAll([Select num_doc__c From Cambio_de_Fecha__c]);
            
            for(integer j=0; j<tea.size(); j++){
                for(integer i=0; i<ListFechaAct.size(); i++){
                    if(tea[j].num_doc__c == ListFechaAct[i].num_doc){
                        ListFechaAct.remove(i);
                    }
            	}
            }
     }

    public void guardar_file(string filename, blob file){
    ContentVersion f = new ContentVersion();
    list <ContentVersion> flist = 
        [select VersionData from ContentVersion
        where title = : filename
        and isMajorVersion = false 

        limit 1
        ];
        
    if(file == null){
            file = blob.valueOf('No hay Referencia');
        }
    if ( flist.size() > 0 ){
        f = flist[0];
        f.VersionData = file;
        update f;
        system.debug('Se actualizo la Imagen');
   	}else{
        f.title = filename;
        f.PathOnClient = filename;
        f.VersionData = file;
        f.IsMajorVersion = false;
    	insert f;
        system.debug('Se guardo la Imagen');
    	}    
    } 
        
  public void EnvioCorreo(){
        try{
        
			correoEmpleado1 = 'cintya.alcantara@ficohsa.com';
            correoEmpleado2 = 'astrid.rivera@ficohsa.com';
            NombreUsuario = '';
            
            owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
            IdEmail = owea.get(0).Id;
			enviar();			
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
    }
    public void enviar(){
        try{
            Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
           	mail.setHtmlBody( 'Buenas, se ha enviado registro(s) de Cambio Fecha de Aportación, solicitando aprobación, para la cuenta: ' + codCuenta + '.'); 
            mail.setSubject('Pantalla de Aprobación de Fecha de Aportaciones.');
            mail.setToAddresses(new String[] {correoEmpleado1, correoEmpleado2});
            mail.setOrgWideEmailAddressId(idEmail);
            mail.setSaveAsActivity(true);
            listCorreo.add(mail);
            Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
        }
         catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
        
        
    }  
   
}