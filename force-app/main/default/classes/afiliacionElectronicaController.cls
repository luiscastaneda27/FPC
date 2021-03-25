public class afiliacionElectronicaController {
    public String Recaptcha {get;set;}
    public String RecaptchaAceptar {get;set;}
    public String tipoIdentificacion {get;set;}
	public String idCliente {get;set;}
    public String primerNombre {get;set;}
    public String segundoNombre {get;set;}
    public String primerApellido {get;set;}
    public String segundoApellido {get;set;}
    public String correoCliente {get;set;}
    public String telefonoCelular {get;set;}
    public String token {get;set;}
    public DateTime fechaGeneracion {get;set;}
    
    Public Datetime FechaHoy {get;set;}
    Public Double fechaCaduca {get;set;} 
    
    public boolean botonEnviarSolicitud {get;set;}
    public boolean botonValidarToken {get;set;}
    public boolean botonValidarDatos {get;set;}
    public boolean mostrarCampos {get;set;}
    public boolean mostrarToken {get;set;}
    
    public afiliacionElectronicaController(){
        botonEnviarSolicitud = true;
        mostrarCampos = false;
        mostrarToken = false;
        botonValidarToken = false;
        botonValidarDatos = false;
        string prueba2 = '';
        string prueba3 = '';
        string pruebaa = '';
		prueba2 = ApexPages.currentPage().getParameters().get('ident');
        if (prueba2 != null){
            idCliente = ApexPages.currentPage().getParameters().get('ident2');
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,prueba2)); 
        }
        pruebaa = ApexPages.currentPage().getParameters().get('identD');
        if (pruebaa != null){
            idCliente = ApexPages.currentPage().getParameters().get('identD');
            correoCliente = ApexPages.currentPage().getParameters().get('ident3');
            telefonoCelular = ApexPages.currentPage().getParameters().get('ident4');
            mostrarToken = true;
            botonValidarToken = true;
            botonValidarDatos = false;
            botonEnviarSolicitud = false;
            mostrarCampos = true; 
        }
        prueba3 = ApexPages.currentPage().getParameters().get('identC');
        if (prueba3 != null){
            idCliente = ApexPages.currentPage().getParameters().get('identidad');
            correoCliente = ApexPages.currentPage().getParameters().get('ident3');
            telefonoCelular = ApexPages.currentPage().getParameters().get('ident4');
            token = ApexPages.currentPage().getParameters().get('ident5');
            mostrarToken = true;
            botonValidarToken = true;
            botonValidarDatos = false;
            botonEnviarSolicitud = false;
            mostrarCampos = true;
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,prueba3)); 
        }
    }
    public void clear(){
        tipoIdentificacion = null;
		idCliente = null;
    	primerNombre = null;
    	segundoNombre = null;
    	primerApellido = null;
    	segundoApellido = null;
    	correoCliente = null;
    	telefonoCelular = null;
    	token = null;
    }
    public PageReference validar(){
        string resultado1 = 'Favor Validar el reCAPTCHA.';
        string resutado2 = idCliente;
        try{
            
            if(idCliente ==''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Número de Identificacion Vacio'));  
                return null;
            }
            if(Recaptcha == 'N'){
                final PageReference target = new
                    PageReference(Site.getBaseSecureUrl() + '/apex/vfAfiliacionElectronica?ident='+resultado1+'&ident2='+resutado2);
                target.setRedirect(true);
                target.setRedirectCode(301); 
                return target; 
            }else{
                classListas claseEnvio = new classListas();
            	classListas fcsd = controllerApiClienteNatural.consultaListas(idCliente);
                if (fcsd.pcprimernombre != 'null'&&fcsd.pcprimernombre != null&&fcsd.pcprimernombre != ''&& fcsd.pcprimernombre != 'NULL'&&fcsd.pcprimernombre != NULL||test.isRunningTest())
                {    
                    afiliacionElectronicaClass envioDatos = new afiliacionElectronicaClass();
                    envioDatos.idCliente = idCliente.replace('-', '');
                    envioDatos.existeCliente = 'S';
                    system.debug('envioDatos: '+envioDatos);
                    String resultado = controllerApiAfiliacionElectronica.generaTokenClienteNoAfiliado(envioDatos);
                    system.debug('resultado token: '+resultado);
                    if(resultado.contains('Error')){
                        mostrarToken = false;
                        botonValidarToken = false;
                        botonEnviarSolicitud = true;
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tus datos no están actualizados en nuestro sistema. Favor llamar al 2275-2424 o escríbenos al correo electrónico ficohsapensiones@ficohsa.com')); 
                   		
                    }
                    else{
                        mostrarToken = true;
                        botonValidarToken = true;
                        botonValidarDatos = false;
                        botonEnviarSolicitud = false;
                    }
                    if (fcsd.pctipoid != 'null'||fcsd.pctipoid != null||fcsd.pctipoid != '')
                    {
                        tipoIdentificacion = fcsd.pctipoid;
                    }
                    if (fcsd.pcprimernombre != 'null')
                    {
                        primerNombre = fcsd.pcprimernombre; 
                    }
                    if (fcsd.pcsegundonombre != 'null')
                    {
                        segundoNombre = fcsd.pcsegundonombre;
                    }
                    if (fcsd.pcprimerapellido != 'null')
                    {
                        primerApellido = fcsd.pcprimerapellido;
                    }
                    if (fcsd.pcsegundoapellido != 'null')
                    {
                        segundoApellido = fcsd.pcsegundoapellido; 
                    }
                    if (fcsd.pcmail != 'null' || fcsd.pcmail != null ||fcsd.pcmail != 'NULL')
                    {
                        correoCliente = fcsd.pcmail;
                    }
                    mostrarCampos = false;
                }
                else{
                    mostrarCampos = true;
                    botonValidarDatos = true;
                    mostrarToken = false;
                    botonValidarToken = false;
                    botonEnviarSolicitud = false;
                }
                
            }
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se encontró Cliente'));      
        }
        return null;
    }
    
    public pageReference validarDatos(){
        
        try{
            afiliacionElectronicaClass envioDatos = new afiliacionElectronicaClass();
            
            envioDatos.idCliente = idCliente.replace('-', '');
            envioDatos.telefonoCelular = telefonoCelular;
            envioDatos.existeCliente = 'N';
            
            if(!Pattern.matches('[a-zA-Z0-9._-]+@[a-zA-Z]+.[a-zA-Z]{2,4}[.]([a-zA-Z0-9]{2,4})', correoCliente))
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Por favor, introduce una dirección de correo electrónico válida.'));
                return null; 
            }
            
            if( telefonoCelular == '' || telefonoCelular == null )
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Telefono Celular no valido.'));
                return null;    
            }
            else
            {
                String resultado = controllerApiAfiliacionElectronica.generaTokenClienteNoAfiliado(envioDatos);
                system.debug('resultado: '+resultado);
                if(resultado != null){
                    mostrarToken = true;
                    botonValidarToken = true;
                    botonValidarDatos = false;
                	string resultado1 = 'Favor Validar el reCAPTCHA.';
                    string resutado2 = idCliente;
                    string resutado3 = correoCliente;
                    string resutado4 = telefonoCelular;
                final PageReference target = new
                    PageReference(Site.getBaseSecureUrl() + '/apex/vfAfiliacionElectronica?identD='+resutado2+'&ident3='+resutado3+'&ident4='+resutado4);
                target.setRedirect(true);
                target.setRedirectCode(301); 
                return target; 
                }
                else{
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));
                }
            }
            
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage()+' LINEA '+E.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Fallo en el sistema, vuelve a Intentarlo.'));      
        }
        return null; 
    }
    
    public pageReference validarToken(){
        string resultado1 = 'Favor Validar el reCAPTCHA.';
        string resutado2 = idCliente;
        string resutado3 = correoCliente;
    	string resutado4 = telefonoCelular;
        string resutado5 = token;
        try{
            afiliacionElectronicaClass envioDatos = new afiliacionElectronicaClass();
            
            envioDatos.idCliente = idCliente.replace('-', '');
            envioDatos.token = token;
            envioDatos.tipoValida = 'sms';
            
            if( token == '' || token == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar Token de Seguridad.'));
                return null;    
            }
            if(RecaptchaAceptar == 'N'){
                final PageReference target = new
                    PageReference(Site.getBaseSecureUrl() + '/apex/vfAfiliacionElectronica?identC='+resultado1+'&identidad='+resutado2+'&ident3='+resutado3+'&ident4='+resutado4+'&ident5='+resutado5);
                target.setRedirect(true);
                target.setRedirectCode(301); 
                return target; 
            }
            else
            {
                String resultado = controllerApiAfiliacionElectronica.validarToken(envioDatos);
                system.debug('resultado: '+resultado+' correo: '+correoCliente);
                if( (!resultado.contains('INVALID'))){
                    fechaGeneracion = Date.Today();
                    FechaHoy = Date.Today();
                    DateTime FechaOrigen = Date.today();
                    
                    fechaCaduca = ((FechaOrigen.getTime() - FechaHoy.getTime()) / 3600000);
                        system.debug('Cantidad horas: ' + fechacaduca);
                    
                    system.debug(FechaHoy.getTime()/ 1800000);
					
					Afiliacion_Electronica__c AEInsert = new Afiliacion_Electronica__c ();
                    AEInsert.Identificacion__c = idCliente;
                    AEInsert.Token__c = resultado;
                    AEInsert.Fecha_Generacion_Token__c = datetime.now();
                    insert AEInsert;
                    
                    //Start encrypting parameters
                    Blob key = Blob.valueOf('aAk!h@37WQ9bsAfk');
                
                    String encodedCipherText = EncodingUtil.base64Encode(Crypto.encryptWithManagedIV('AES128', key, Blob.valueOf(idCliente)));
                    String idClienteEncriptado = encodingUtil.URLEncode(encodedCipherText,'UTF-8');
                    
                    String encodedCipherText2 = EncodingUtil.base64Encode(Crypto.encryptWithManagedIV('AES128', key, Blob.valueOf(resultado)));
                    String resultadoEncriptado = encodingUtil.URLEncode(encodedCipherText2,'UTF-8');
                    //End encrypting parameters
					
                    EmailTemplate emailTemplate = [select Id, Subject, HtmlValue, Body from EmailTemplate where name ='Link Afiliacion']; // or use email template name instead                    
                    String subject = emailTemplate.Subject;        
                    String htmlBody = emailTemplate.HtmlValue;
                    String queryCorreo = 'Select URL__c From URL_conexion_Sysde__mdt Where DeveloperName = \'Afiliacion_Electronica\'';
                    URL_conexion_Sysde__mdt cuerpoCorreo = dataBase.query(queryCorreo);
                    String cuerpo = cuerpoCorreo.URL__c;
                    htmlBody = htmlBody.replace('Afiliate', '<a href="'+cuerpo+'aElectronicaPageReference?ident='+idClienteEncriptado+'&securityToken='+resultadoEncriptado+'">Afiliate</a>');

                    Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
                    OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];  
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();                 
                    mail.setHtmlBody(htmlBody);
                    mail.setSubject(subject);
                    String[] toAddresses = new String[] {correoCliente};              
                    //String[] toAddresses = new String[] {'carlos.escoto@ficohsa.com'};
                    mail.setToAddresses(toAddresses);
                    mail.setOrgWideEmailAddressId(owea.get(0).Id);
                    mail.setSaveAsActivity(true);
                    listCorreo.add(mail);
                    Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
                    system.debug('Correos enviados correctamente: '+results);
                    system.debug('Email:' + correoCliente+' EnvioCorreo:'+listCorreo);
                    clear();
                    mostrarToken = false;
                    botonValidarToken = false;
                    botonEnviarSolicitud = true;
                    mostrarCampos = false;
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Hemos enviado el Link de Afiliación a tu correo.'));
                }
                else{
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Pin no válido o vencido.'));
                }
            }
            
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage()+' LINEA '+E.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Fallo en el sistema, vuelve a Intentarlo.'));      
        }
        return null; 
    }
}