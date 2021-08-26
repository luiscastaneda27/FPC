public without sharing class ControllerCambioAsesorBanco {
     public  List<ClassCambioAsesorBanco>listcambioasesorbanco{get;set;}
     public string codCuenta {get;set;}
     public string pccodCuenta {get;set;}
     public string nombreCliente {get;set;}
     public string pcnombreCliente {get;set;}
     public string codAsesor {get;set;}
     public string nombreAsesor {get;set;}
     public string agencia {get;set;}
     public string pccodAsesor {get;set;}
     public string pcnombreAsesor {get;set;}
     public string pcagencia {get;set;}
     public string pcsubproducto {get; set;}
     public string nuevoCodAsesor {get;set;}
     public string nuevoNombreAsesor {get;set;}
     public string nuevaAgencia {get;set;}
     public integer contador {get;set;}
     public boolean MuestraTabla {get;set;}
     public integer tama {get;set;}
     // public string Usuario {get;set;}
    
    
   // public classActualizarAsesorBanco claseEnvio{get; set;}
    
    public ControllerCambioAsesorBanco()
    {
             
    }
    
    public void Busca(){
     try{        
            
            ClassCambioAsesorBanco  claseEnvio = new ClassCambioAsesorBanco();
           
            ClassCambioAsesorBanco fcsd = ControllerApiCambioAsesorBanco.BuscarCuenta(codCuenta);//fechaporte,codCuenta parametros que se extraen de la api BucarCuenta
                        
            listcambioasesorbanco = fcsd.listcambioasesorbanco;//Extrae la lista desde c#
            actList();
            
            tama = (listcambioasesorbanco.size());//Indica los numeros de elemento que hay en la lista cuando se ejecuta la consulta 
           
            
            system.debug('Lista tamanio'+listcambioasesorbanco.size());
           
         	if(codCuenta == ''  /*|| test.isRunningTest()*/){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar una cuenta'));    
                
            }
            
            else if ( tama == 0){
                
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no encontrado por favor revise los datos ingresados'));
                limpiar1 ();
                 
            }
            else{
                BuscaInfor();   
            }
            
            system.debug('Esto Envia: ' + codCuenta );
        }
        Catch(Exception e){
             //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        	
        }
        
    }
    
    
    
     public void BuscaInfor(){ 
      try{    
            
            ClassCambioAsesorBanco  claseEnvio = new ClassCambioAsesorBanco();
            ClassCambioAsesorBanco fcsd = ControllerApiCambioAsesorBanco.BuscarCuenta(codCuenta);// parametros que se extraen de la api BucarCuenta
            system.debug('Respueta BuscaInfor: '+fcsd); 
            list<ClassCambioAsesorBanco> listcambioasesorbanco  = new List<ClassCambioAsesorBanco>();
            listcambioasesorbanco = fcsd.listcambioasesorbanco;//Extrae la lista desde c#
            
                        
            actList();
            
           tama =  listcambioasesorbanco.size();
            system.debug('Listasesorbanco: '+ listcambioasesorbanco);// Aqui muestra la lista que va a aparecer como respuesta en los registro de depuracion 
           
            if(listcambioasesorbanco != null){
                pccodCuenta = fcsd.codCuenta;
                pcnombreCliente = fcsd.nombreCliente;
                pcsubProducto = fcsd.subProducto;
                pccodAsesor = fcsd.codAsesor;
                pcnombreAsesor = fcsd.nombreAsesor;
                pcAgencia = fcsd.Agencia; 
                MuestraTabla = true;//Muestra la tabla que se hace de la consulta 
                
                            
             	/*for (Subproducto__c item:[select name, codigo__c from Subproducto__c where producto__r.codigo__c =: fcsd.producto])//Extrae el sub producto y lo valida con una consulta de objetos
                {
                    opcionSubproducto.add(new selectOption(item.codigo__c, item.name));
                }*/
                
            }
            for(integer i=0; i<fcsd.listcambioasesorbanco.size(); i++)
                //extrae de la clase todos elementos que se encuentran dentro de la tabla
            {	
                /*
                classconsulta1 p = new classconsulta1();
                p.idCliente = fcsd.listconsultacuota[i].idCliente; 
                p.nombreCliente =  fcsd.listconsulta[i].nombreCliente;
                p.producto=  fcsd.listconsulta[i].producto;
                p.subProducto =  fcsd.listconsulta[i].subProducto;
                p.codCuenta = fcsd.listconsulta[i].codCuenta;
                p.tipoSaldo =fcsd.listconsulta[i].tipoSaldo;
                p.inversion = fcsd.listconsulta[i].inversion; 
                p.montoPactado = fcsd.listconsulta[i].montoPactado;
                p.montoAportado = fcsd.listconsulta[i].montoAportado;
            */
			}
            
      
        }
        Catch(Exception e){
       
            
        }
    }
    
     public void actList() {
        List <Cambio_Asesor_Banco__c> tea = new List<Cambio_Asesor_Banco__c>();
       tea.addAll([Select Cuenta__c From Cambio_Asesor_Banco__c]);
        
        for(integer j=0; j<tea.size(); j++){
            for(integer i=0; i<listcambioasesorbanco.size(); i++){
               if(tea[j].Cuenta__c == listcambioasesorbanco[i].codCuenta){
                    listcambioasesorbanco.remove(i);
               }
            }
        }
    }
    
    
    
     Public void Actualizar(){
     Try{
            //declaracion 
            contador = 0;
            list<Cambio_Asesor_Banco__c> cambioasesor = new list<Cambio_Asesor_Banco__c>();
            Cambio_Asesor_Banco__c listC;
            listC = new Cambio_Asesor_Banco__c();
         
           for (integer i=0; i < listcambioasesorbanco.size(); i++ ) // ciclo for que recorre la lista para extraer los valores que se van a actualizar
            {
                if ( nuevoCodAsesor == '' || nuevoNombreAsesor== '' || nuevaAgencia== '' || codCuenta == '') {
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Los datos no fueron ingresados correctamente')); 
                 limpiar ();
                 
                    //2.0
                /* if ( nuevoCodAsesor == '' || nuevoNombreAsesor== '' || nuevaAgencia== '' || codCuenta == '') {
                 contador++; 
                    
                    limpiar ();*/
                    
                    
                    
             /* if ( listcambioasesorbanco[i].nuevoCodAsesor ==null ||listcambioasesorbanco[i].nuevoNombreAsesor==null ||listcambioasesorbanco[i].nuevaAgencia==null || codCuenta == '') {
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Los datos no fueron ingresados correctamente')); 
                 limpiar ();*/
              //  contador++;  
              }
                
                
                
               else {  
                   listC = new Cambio_Asesor_Banco__c();
					//almacena los objetos en la lista
                    listC.Cuenta__c= string.valueOf(listcambioasesorbanco[i].codCuenta);  // 
                	listC.Nombre_Cliente__c = string.valueOf(listcambioasesorbanco[i].nombreCliente);//
                	listC.Subproducto__c = string.valueOf(listcambioasesorbanco[i].subproducto);  //
                    listC.Codigo_Asesor__c = string.valueOf(listcambioasesorbanco[i].codAsesor);  //
         			listC.Nombre_Asesor__c = string.valueOf(listcambioasesorbanco[i].nombreAsesor);
                    listC.Agencia__c = string.valueOf(listcambioasesorbanco[i].agencia);//
                   	listC.Nuevo_Codigo_Asesor__c = string.valueOf(nuevoCodAsesor);
                	listC.Nuevo_Nombre_Asesor__c = string.valueOf(nuevoNombreAsesor);
                	listC.Nueva_Agencia__c = string.valueOf(nuevaAgencia);
                   
                   
                	/*listC.Nuevo_Codigo_Asesor__c = string.valueOf(listcambioasesorbanco[i].nuevoCodAsesor);
                	listC.Nuevo_Nombre_Asesor__c = string.valueOf(listcambioasesorbanco[i].nuevoNombreAsesor);
                	listC.Nueva_Agencia__c = string.valueOf(listcambioasesorbanco[i].nuevaAgencia);*/
                           
         //guardar_file(listcambioasesorbanco[i].num_doc);
         	cambioasesor.add(listC); 
             ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Correcto'));
           }  
                
           } 
          // inserta la lista de objetos 
          insert cambioasesor;
         
            //ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'correcto'));
        	if (tama == contador) {
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Los Datos no Fueron Ingresados Correctamente'));   
            }
            
        	 limpiar ();
         	}

          Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
         
    }
    
    //
       public void limpiar () {
		pcsubproducto = null;
       // listcambioasesorbanco = null;          
 		nuevoCodAsesor = null;
        nuevoNombreAsesor = null;
        nuevaAgencia = null;
        tama = null;
        codCuenta = null;
        //nombreCliente = null;
        MuestraTabla = false;
       
    }
    
    //
     public void limpiar1 () {
        pcsubproducto = null;
   		//listcambioasesorbanco = null;
        nuevoCodAsesor = null;
        nuevoNombreAsesor = null;
        nuevaAgencia = null;
        tama = null;        
        codCuenta = null;
       // nombreCliente = null;
        MuestraTabla = false;
    }
    
    //
     public void LimpiarTabla() {
        MuestraTabla = false;
    }
    
    //
    public void Cancelar () {
        limpiar ();
        LimpiarTabla();
    }
}