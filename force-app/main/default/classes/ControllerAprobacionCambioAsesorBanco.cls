public class ControllerAprobacionCambioAsesorBanco {
    /*variables*/
    public List <Cambio_Asesor_Banco__c>Listdata{get;set;} 
    public string codCuenta {get;set;}
    public string nombreCliente {get;set;}
    public string buscacuenta {get;set;}
	//public Pantalla_Cambio_Asesor_Banco__c ase{get;set;}
  
    //public List<SelectOption> opciones {get;set;} // agrege variable opcion
    public List<SelectOption> opcionesCuentas{get;set;}
  
    public boolean DenegarVentana  {get;set;}
    public boolean DenegarImagen {get; set;} 
    public integer contador {get;set;}
    public integer tama {get;set;}
    public boolean MuestraTabla {get;set;}
    public date FCsysde {get; set;}
    public string Usuario {get;set;}
    //public string NombreUsuario {get;set;}
    public string estado {get;set;}
    public string nuevoCodAsesor {get;set;}
    public string nuevoNombreAsesor {get;set;}
    public string nuevaAgencia{get;set;}

    
   public ControllerAprobacionCambioAsesorBanco()
    {
        Usuario ='HN23187';//ApexPages.currentPage().getParameters().get('hytrd'); 
        //opciones=new List<SelectOption>(); // agrege opciones
        opcionesCuentas = new List<SelectOption>();
        ListData = new List<Cambio_Asesor_Banco__c>();
       	BuscaCuentas(); 
    }
    
      public void BuscaCuentas() {
        buscacuenta = '';
        opcionesCuentas.clear();
        opcionesCuentas.add(new selectOption('--Ninguno--','--Ninguno--'));
        List<Cambio_Asesor_Banco__c> cuentas = [Select Cuenta__c From Cambio_Asesor_Banco__c];
        Set<String> cuentas2 = new Set<String>();
        	
        for(Cambio_Asesor_Banco__c acc: cuentas){
            if (acc.Cuenta__c != NULL	)				
			cuentas2.add(acc.Cuenta__c);
        }
        
        for(String acc: cuentas2){
            opcionesCuentas.add(new selectOption(acc,acc));
        }
    }
    
    	Public void mostrarTabla(){
        	if(!Test.isRunningTest()){
           		ListData.clear();
       		 }
         	Try{
            	if(buscacuenta != '--Ninguno--'){
                	ListData.addAll([Select Cuenta__c, Nombre_Cliente__c,Codigo_Asesor__c, Nombre_Asesor__c, Agencia__c,Nuevo_Codigo_Asesor__c, Nuevo_Nombre_Asesor__c, Nueva_Agencia__c
                                 
                                 From Cambio_Asesor_Banco__c where Cuenta__c =: buscacuenta]);
                tama = ListData.size();
                nombreCliente = ListData[0].Nombre_Cliente__c;
                
           
                MuestraTabla = true;
            }else{
            	MuestraTabla = false;
                limpiar();
            }
             }
      	 Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
    } 
    
     Public void Actualizar(){
        Try{
           classActualizarAsesorBanco afa = new classActualizarAsesorBanco();//Invocacion a la clase 
            //afa.codCuenta = codCuenta;
            //afa.nuevafecha = nuevafecha; 
            for(integer i=0; i<ListData.size(); i++){
                system.debug('Holaaaa');
                if(ListData[i].Cuenta__c == codCuenta){
                    system.debug('Holaaaa23222');
                    afa.codCuenta = ListData[i].Cuenta__c;
                    afa.nuevoCodAsesor = ListData[i].Nuevo_Codigo_Asesor__c;
                    afa.nuevoNombreAsesor = ListData[i].Nuevo_Nombre_Asesor__c;
                    afa.nuevaAgencia = ListData[i].Nueva_Agencia__c;
                    afa.estado = estado;
                    afa.Usuario = Usuario;
                     
                    //afa.numDocumento = (num_doc+ '/' +accion);
                    system.debug(codCuenta+'el usuarioooooooo'+Usuario);
                    //afa.Accion = accion;
                    //modificacion  fechaporte aSysdeCallouts.fechaCierreSysde(date.today()) afa.nuevafecha==null ||

                    if (afa.nuevoCodAsesor == '' || afa.nuevoNombreAsesor== '' || afa.nuevaAgencia== '' || codCuenta == '') {
                        contador++;
                        }
                    else {
                       /* Usuario='HN19577';
                        system.debug(Usuario);
                        Pantalla_Cambio_Asesor_Banco__c pase = new   Pantalla_Cambio_Asesor_Banco__c();  
            			pase.Codigo_Usuario__c = Usuario; 
                        string nu;
                        if(!test.isRunningTest()){nu= [select Name from Usuarios_de_Pantallas__c where Usuario__c =: Usuario].Name;}
                        else{nu= [select Name from Usuarios_de_Pantallas__c limit 1].Name;}
                        
                        pase.Oficial_de_negocios__c = nu;
                        insert pase;*/
                       
                        //Insertar en la bitacora
                        //Bitacora_Cambio_Asesor_Banco__c bita = new Bitacora_Cambio_Asesor_Banco__c ();
                        //bita.Pantalla__c = 'vfAprobacionCambioAsesorBanco';
                        //bita.Estado__c = estado ;
                        //bita.Usuario__c = Usuario;
                        //insert bita;      
                           
                    string resultado = ControllerApiCambioAsesorBanco.ActualizarCambioAsesor(afa);//codigo que envia al api la accion para actualizar
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));//Codigo para mostrar en mensaje si hay error o esta ejecutando la accion bien.
                
           			}
                	ListData.remove(i);
                    tama = ListData.size();
                    Cambio_Asesor_Banco__c record = [SELECT Id FROM Cambio_Asesor_Banco__c where Cuenta__c =: codCuenta]; 
					delete record;
                }
            }
            //limpiar ();
           
        }
       Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        } 
    }
    
    public void limpiar () {     
        tama = null;         
        codCuenta = null;
        nombreCliente = null;
        ListData.clear();
       	BuscaCuentas();	
    }
    
    public void LimpiarTabla() {
        MuestraTabla = false;
        ListData.clear();
    }
    
    public void Cancelar() {
        limpiar ();
        LimpiarTabla();
    }
    
  public void popSalirImagen() {
       DenegarImagen = false;
   }  
    
   public void popDenegarSalir(){    
        DenegarVentana = false;
         
    }
    public void Denegar(){
      	estado = 'DENEGADO';
       
        // llama a los métodos 
        Actualizar();
        Cancelar();
        BuscaCuentas();
        popDenegarSalir(); 
        
        /* if(!Test.isRunningTest()){
         Cambio_Asesor_Banco__c record = [SELECT Id FROM Cambio_Asesor_Banco__c where Cuenta__c =: codCuenta]; 
	     delete record;
          }*/
        }
           
      
    public void Aprobar(){
       	estado = 'APROBADO';
       Actualizar();
        //limpiar ();
        //LimpiarTabla();
        //fechaModificacion =  ;
        }      
      
    public void mostrarDenegar(){
        DenegarVentana = true;  
    }
    
    }