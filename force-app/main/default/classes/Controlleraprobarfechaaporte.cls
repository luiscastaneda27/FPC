public class Controlleraprobarfechaaporte {
 /*Variables*/
    public List<Cambio_de_Fecha__c>ListData{get;set;} 
    public string codCuenta {get;set;}
    public string Usuario {get;set;}
    public string tipomoneda {get;set;}
    public date fechaporte {get;set;}
    public string nombre {get;set;}
    public string pcproducto {get;set;}
    public string buscacuenta {get;set;}
    public string pcsubproducto {get; set;}
    public integer tama {get;set;}
    public Account TipMoneda{get;set;}
    public string num_doc {get; set;}
    public List<SelectOption> opcionSubproducto {get;set;}
    public List<SelectOption> opciones {get;set;}
    public List<SelectOption> opcionesCuentas{get;set;}
	public integer contador {get;set;}
 	public date FCsysde {get; set;}
    public boolean DenegarImagen {get; set;}   
    public string ID_Referencia {get; set;}
    public Transient string Ver_Imagen {get;set;}
    public boolean DenegarVentana  {get;set;}
    public string Motivo {get;set;}
    public string NombreUsuario {get;set;}
    public string correoEmpleado {get;set;}
    public OrgWideEmailAddress[] owea {get;set;}
    public string idEmail {get;set;}
    public string estadEmail {get;set;}
    
    //AGREGADO 22082019
    public boolean MuestraTabla {get;set;}
	
    //variables de aprobar
    public string accion {get;set;}
    
    /* public void MuestraTabla(){ 
        Buscar=True;
    }    
    //FIN*/
	  
    public Controlleraprobarfechaaporte()//Inicializacion de las variables que utilizan objetos
    {
        
        TipMoneda = new Account();
        TipMoneda.Tipo_Moneda__c = null;
        opciones=new List<SelectOption>();
        opcionSubproducto = new List<SelectOption>();
        opcionesCuentas = new List<SelectOption>();
        ListData = new List<Cambio_de_Fecha__c>();
        BuscaCuentas(); 
       
    }
       
    public void BuscaCuentas() {
        buscacuenta = '';
        opcionesCuentas.clear();
        opcionesCuentas.add(new selectOption('--Ninguno--','--Ninguno--'));
        List<Cambio_de_Fecha__c> cuentas = [Select Cuenta__c From Cambio_de_Fecha__c];
        Set<String> cuentas2 = new Set<String>();
        
        for(Cambio_de_Fecha__c acc: cuentas){
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
                ListData.addAll([Select Cuenta__c,Fechadeaporte__c,Nombrecliente__c,
                                            Moneda__c,Producto__c,Subproducto__c,NoMovimiento__c,Tiposaldo__c,Montopago__c,
                                 Descripcion__c,Accion__c,Obsevaciones__c,Nuevafecha__c,Referencia__c,num_doc__c
                                 From Cambio_de_Fecha__c where Cuenta__c =: buscacuenta]);
                tama = ListData.size();
                fechaporte = date.valueOf(ListData[0].Fechadeaporte__c);
                nombre = ListData[0].Nombrecliente__c;
                TipMoneda.Tipo_Moneda__c  = ListData[0].Moneda__c;
    			
                opciones.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Producto__c item:[select name, codigo__c from Producto__c ])
                    {
                        opciones.add(new selectOption(item.codigo__c, item.name));//Extrae el codigo del producto que está alojado en objetos
                    }                
                    
                    opcionSubproducto.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                    for (Subproducto__c item:[select name, codigo__c from Subproducto__c where producto__r.codigo__c =: ListData[0].Producto__c])//Extrae el sub producto y lo valida con una consulta de objetos
                    {
                        opcionSubproducto.add(new selectOption(item.codigo__c, item.name));
                    }
                pcproducto = ListData[0].Producto__c;
                pcsubproducto = ListData[0].Subproducto__c;
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
           classAcualizaFechaAporte afa = new classAcualizaFechaAporte();//Invocacion a la clase 
            //afa.codCuenta = codCuenta;
            //afa.nuevafecha = nuevafecha; 
            for(integer i=0; i<ListData.size(); i++){
                if(ListData[i].num_doc__c == num_doc){
                    afa.nuevafecha = ListData[i].Nuevafecha__c;
                    afa.numDocumento = (num_doc+ '/' +accion);
                    system.debug(num_doc+ '/' +accion);
                    //afa.Accion = accion;
                    //modificacion  fechaporte aSysdeCallouts.fechaCierreSysde(date.today()) afa.nuevafecha==null ||
                    if(FCsysde==null){
                	FCsysde = [Select Fecha_cierre__c From FechaDC_Sysde__c Where Name = 'CierreAlDia' Limit 1].Fecha_cierre__c;
                }
                    if (afa.nuevafecha < FCsysde ||  codCuenta == '') {
                        contador++;
                        }
                    else {
                    string resultado = ControllerAPIFechCambioAporte.Actualizarfecha(afa);//codigo que envia al api la accion para actualizar
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));//Codigo para mostrar en mensaje si hay error o esta ejecutando la accion bien.
                
           			}
                	ListData.remove(i);
                    tama = ListData.size();
                    Cambio_de_Fecha__c record = [SELECT Id FROM Cambio_de_Fecha__c where num_doc__c =: num_doc]; 
					delete record;
                }
            }
            //limpiar ();
           
        }
       Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
      
    }
    
    //Codigo que limpia la pantalla 
    public void limpiar () {
        pcsubproducto = null;
        tama = null;        
        fechaporte = null;
        codCuenta = null;
        pcproducto = null;
        nombre = null;
        ListData.clear();
       	BuscaCuentas();
        
        //TipMoneda.Tipo_Moneda__c = null; // se comento por pruebas de test
       
    }
   
    public void LimpiarTabla() {
        MuestraTabla = false;
        ListData.clear();
    }
    
    public void Cancelar () {
        limpiar ();
        LimpiarTabla();
        
    }
    
   
    
    public void MostrarImagen(){
                
        try
            {
                /*ControllerAPIPagoIntereses.classRespuestaImagen wer =  new ControllerAPIPagoIntereses.classRespuestaImagen();
            	wer = ControllerAPIPagoIntereses.TraerImagenBD(ID_Referencia);*/
                 ContentVersion flist = Database.query('select VersionData from ContentVersion where title = : ID_Referencia and isMajorVersion = false limit 1');
                if(flist != null){
                    Ver_Imagen = EncodingUtil.base64Encode(flist.VersionData);
                    if(Ver_Imagen!='Tm8gaGF5IFJlZmVyZW5jaWE='){
                        DenegarImagen = true;
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
    public void popSalirImagen(){DenegarImagen = false;}  

    public void popDenegarSalir(){    
        DenegarVentana = false;
        Motivo = null;
        
    }
    public void Denegar(){
       	estadEmail = 'DENEGADO';
        EnvioCorreo();
        Cancelar();
        BuscaCuentas();
        popDenegarSalir();
         if(!Test.isRunningTest()){
           Cambio_de_Fecha__c record = [SELECT Id FROM Cambio_de_Fecha__c where num_doc__c =: num_doc];
             delete record;
        }
      
		
        
       
    }
    public void Aprobar(){
        if(accion == 'Actualizar'){
            accion = 'A';
        	Actualizar(); 
            estadEmail = 'APROBADO';
            EnvioCorreo();
        }else{
           accion = 'E';
           Actualizar(); 
            estadEmail = 'APROBADO';
            EnvioCorreo();
        }       
       // BuscaCuentas();
    }
    public void mostrarDenegar(){
        DenegarVentana = true;
        
    }
    public void EnvioCorreo(){
        try{
        	correoEmpleado = 'mariell.sierra@ficohsa.com' ;
            NombreUsuario = 'Mariell'+ ' ' + 'Sierra';
            
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
            if (estadEmail == 'DENEGADO') {
           		 mail.setHtmlBody( 'Buenas ' + NombreUsuario + ', la modificacion del aporte a la cuenta ' + buscacuenta + 
                           		  ' ha sido DENEGADO por el siguiente motivo; ' + Motivo + '.'); 
                        }
            else if (estadEmail == 'APROBADO') {
                    mail.setHtmlBody( 'Buenas ' + NombreUsuario + ', la modificacion del aporte a la cuenta  ' + buscacuenta + 
                           		  ' ha sido APROBADO. '); 
           			}
           
            mail.setSubject('La Modificacion de la cuenta ' + buscacuenta + ', fue: ' + estadEmail + '.');
            mail.setToAddresses(new String[] {correoEmpleado});
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