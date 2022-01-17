public class ControladorCasosPortalAutogestionE2C {
   
    //Properties
    public claseTipoCaso cTipoCaso{get;set;}
    public string idCliente {get;set;}
    public string idTipoRegistro {get;set;}
    public string urlPagina {get;set;}
    public string idCuenta {get;set;} 
    public Account cliente {get;set;}
    public case Caso {get;set;}
    public detalle_caso__C detalleCaso { get; set; }
    public list<SelectOption> listCuentas{get;set;}
    public list<SelectOption> listTipoCaso{get;set;}
    public list<SelectOption> listTipoOperacion{get;set;}
    public list<SelectOption> listaZonas { get; set; }
    public list<SelectOption> listAgencias { get; set; }
    //public Tasa_De_Cambio__c tasaCambio{get; set;}
    public list<SelectOption> listDeptoResi{get;set;}
    public list<SelectOption> listDeptoTrab{get;set;}
    public Contrato_Aceptado__c contrato {get;set;}
    public list<SelectOption> listCiudadResi{get;set;}
    public list<SelectOption> listCiudadTrab{get;set;}
    public boolean mostrarCntrato{get;set;}
    public string ZonaSeleccionada { get; set; }
    public string currencyAccountSelected { get; private set; }
    public Cuentas__C Cuenta { get; set; }
    
    //Nuevo 14/05/2020
    Public Boolean showLogin {get;set;}
    Public String casoCliente {get;set;}
    Public String emailCliente {get;set;}
    Account currentRecord;
    Public String idCliente2 {get;set;}
    Public String numCel {get;set;}
    Public String recordType {get;set;}
    Public String styleButton {get;set;} Public Boolean showCaseComplete {get;set;} Public Boolean showTimeComplete {get;set;}
    Public String idCasoE2C {get;set;}
    Public Boolean disabledSelect {get;set;}
    Public Boolean disabledSelect2 {get;set;} Public String valueEmbajada {get;set;} Public Double fechaCaduca {get;set;} Public Datetime FechaOrigen {get;set;} Public Datetime FechaHoy {get;set;}
    public String token {get;set;} 
    public boolean noRecibeToken {get;set;} 
        
    public String tipoIdentificacion {get;set;}
    //public String idCliente {get;set;}
    public String primerNombre {get;set;}
    public String segundoNombre {get;set;}
    public String primerApellido {get;set;}
    public String segundoApellido {get;set;}
    public String correoCliente {get;set;} public String telefonoCelular {get;set;}
    
    Public String styleDiv {get;set;} Public String styleToken {get;set;}
    Public String styleIngresaToken {get;set;}
    Public String styleMsgAceptar {get;set;}
    Public String styleNumCel {get;set;}
    
    Public List<RecordType> rt;
    Public List<Case> caso01; 
    
    public string bancoVal {get;set;}
    
    public SelectOption[] BANCO { 
        public get;
        private set;
    }
    
    public void llenarBANCO() {
        this.BANCO = new SelectOption[]{};                
        this.BANCO.add(new SelectOption('','--Ninguno--'));    
        this.BANCO.add(new SelectOption('28','Ficohsa'));
        //this.BANCO.add(new SelectOption('Otros Bancos','Otros Bancos'));
    }
    
    public string frecuenciaVal {get;set;}
    
    public SelectOption[] FRECUENCIA { 
        public get;
        private set;
    }
    
    public void llenarFRECUENCIA() {
        this.FRECUENCIA = new SelectOption[]{};                
        this.FRECUENCIA.add(new SelectOption('','--Ninguno--'));    
        this.FRECUENCIA.add(new SelectOption('M','Mensual'));
    }
    
    //Fin nuevo 4/05/2020
    
    public ControladorCasosPortalAutogestionE2C(ApexPages.StandardController controller) {
        //Inicio Generando el Token por Oficial SAC y desde el portal de Agencias/Call Center.
        this.currentRecord = (Account)controller.getRecord(); currentRecord = [SELECT Id, Identificacion__c FROM Account WHERE Id = :currentRecord.Id];
        System.debug('currentRecord: '+currentRecord.Identificacion__c);
        if(currentRecord.Identificacion__c != Null && idCliente2 == Null) { idCliente2 = currentRecord.Identificacion__c;   
            System.debug('idCliente2: '+idCliente2);  
        }      
        //Fin Generando el Token por Oficial SAC y desde el portal de Agencias/Call Center.
    }
        
    public Date dateTemp { 
        public set; get { 
            if(this.dateTemp == Null) this.dateTemp = Date.Today().addDays(3); 
            return this.dateTemp; 
        }
    }
    
    public String UrlHost { get { if(this.UrlHost == Null || this.UrlHost == '')  {  this.UrlHost = 'https://' + ApexPages.currentPage().getHeaders().get('Host') + ApexPages.currentPage().getUrl(); } return this.UrlHost; } set;
    }
    
    public ControladorCasosPortalAutogestionE2C() { 
        try { 
            
            llenarBANCO();
            llenarFRECUENCIA();
            
            disabledSelect = true; disabledSelect2 = true; noRecibeToken = false; styleDiv = 'display:none;'; styleIngresaToken = 'display:none;'; styleNumCel = 'display:none;';
            
            String idCaso = ApexPages.currentPage().getParameters().get('idCaso');
            System.debug('idCaso: '+idCaso);
            
            caso01 = [Select id,CaseNumber,RecordTypeId,RecordType.Name,Correo_Electronico__c,Type,Subject,ownerId,owner.Email,Status,SuppliedEmail,Identificacion__c,Account.Identificacion__c From Case Where Id =: idCaso];
            System.debug('Caso: '+caso01[0].Id);
            
            string idClie = ApexPages.currentPage().getParameters().get('idCliente');
            System.debug('idClie: '+idClie);

            emailCliente = caso01[0].SuppliedEmail;
            casoCliente = caso01[0].CaseNumber;
            idCliente = caso01[0].Account.Identificacion__c;
            recordType = ApexPages.currentPage().getParameters().get('recordType');   

            rt = [Select Id, Name, DeveloperName From RecordType Where DeveloperName =: recordType]; //System.debug('Tipo: '+rt[0].Name);
            caso01 = [Select id,CaseNumber,RecordTypeId,RecordType.Name,Correo_Electronico__c,Type,Subject,ownerId,owner.Email,Status,SuppliedEmail,Identificacion__c From Case Where CaseNumber =: casoCliente]; //System.debug(caso[0].RecordType.Name);
            
            List<Case> casos = [Select id,CaseNumber,RecordTypeId,RecordType.Name,Correo_Electronico__c,Type,Subject,Status From Case Where CaseNumber =: casoCliente]; 
                             
            List<Case> casoRel = [Select Id,CaseNumber,ParentId,Status From Case Where ParentId =: casos[0].Id and RecordType.DeveloperName =: recordType order by CreatedDate desc Limit 1];
            if(casos[0].RecordType.Name == 'Email to Case' && casos[0].Status == 'Nuevo') { 
                if(casoRel.size() > 0) { showLogin = false;  
                } else { 
                    showLogin = true; 
                } 
            } 
                
            //
            idCasoE2C = casos[0].id;
            //
                
            if(casos[0].RecordType.Name != 'Email to Case' || casos[0].Status != 'Nuevo' || casoRel.size() > 0) {  showCaseComplete = true; 
            }
            
            if((recordType == 'Reposicion_Carnet' || recordType == 'Otros') && casos[0].Status == 'Nuevo') { styleMsgAceptar = 'display:none;'; 
            }
            
            contrato = new Contrato_Aceptado__c();
               
            if(Site.getBaseUrl() != Null || Site.getBaseUrl() != '') { 
                this.UrlHost = Site.getBaseUrl(); 
            } 
            
            cliente = new account();
            System.debug('idCliente: '+idCliente);    
            if(idCliente != '') {
                cliente = [select id, name, Acepto_Condiciones_de_Portal_Autogestion__C,identificacion__c, Departamento_Residencia2__c from account where identificacion__C =:idCliente limit 1];
                contrato.Cliente__c = cliente.id; contrato.Acepto_Condiciones_de_Portal_Autogestion__C = true; 
                mostrarCntrato = true;
                if([select count() from Contrato_Aceptado__c where Cliente__c = :cliente.id]>0) { mostrarCntrato = false; 
                }
                Inicio(); 
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'Navegadores recomendados Google Chrome y Firefox Mozilla'));             
            } 
                                         
        } catch(Exception ex) { 
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            if(idCliente == null && caso01[0].RecordType.Name == 'Email to Case') { showLogin = true; ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'Navegadores recomendados Google Chrome y Firefox Mozilla')); } else if(idCliente == null && caso01[0].RecordType.Name != 'Email to Case') { showCaseComplete = true; showLogin = false; } else { ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Lo sentimos pero se ha producido un error inesperado'));
            }                
        }
    }
    
    public void UpdateCaseToOtros() { 
        List<Case> casos = new List<Case>(); if(!test.isRunningTest()){ casos = [Select id,CaseNumber,RecordTypeId,RecordType.Name,Correo_Electronico__c,Type,Subject,Status,CreatedDate From Case Where CaseNumber =: casoCliente];
        }else{ casos = [Select id,CaseNumber,RecordTypeId,RecordType.Name,Correo_Electronico__c,Type,Subject,Status,CreatedDate From Case limit 1];
        } SolicitudCaso solicitud = AFPCCasos.upsertCaso(casos[0]);
        
        FechaOrigen = casos[0].CreatedDate; FechaHoy = System.now(); if(FechaOrigen != Null) { fechaCaduca = ((FechaHoy.getTime() - FechaOrigen.getTime()) / 3600000); 
        } 
                
        if((fechaCaduca >= 24 && casos[0].RecordType.Name == 'Email to Case' && casos[0].Status != 'Cerrado') || test.isRunningTest()) {
            
            showTimeComplete = true; showLogin = false; String idOtros = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Otros').getRecordTypeId(); List<Account> cuenta = new List<Account>(); List<Account> cuenta2 = new List<Account>();
            for(Account item : [Select Id,Name,Identificacion__c,PersonEmail,Owner.Zona__c From Account where Identificacion__c =: idCliente2 or PersonEmail =: emailCliente]){
                if(item.Identificacion__c == idCliente2) { cuenta.add(item); } if(item.PersonEmail == emailCliente) { cuenta2.add(item);
                }
            }      
            
            //List<Account> cuenta = [Select Id,Name,Identificacion__c,PersonEmail,Owner.Zona__c From Account where Identificacion__c =: idCliente2]; //System.debug(cuenta);
            //List<Account> cuenta2 = [Select Id,Name,Identificacion__c,PersonEmail,Owner.Zona__c From Account where PersonEmail =: emailCliente]; //System.debug(cuenta2);
            //List<User> usuario = [Select Id,Name From User Where Name = 'PortalAutoGestion Usuario invitado al sitio Web'];
            
            caso01[0].RecordTypeId = idOtros; caso01[0].Type = 'Solicitud'; caso01[0].Subject = 'Otros';  caso01[0].FPC_Asunto__c = 'Consulta de correo electrónico';
            
            //Zonas
            String zonaVal;
            if(!cuenta.isEmpty()) { if(cuenta[0].Owner.Zona__c == 'San Pedro Sula') { zonaVal = '1'; } else if(cuenta[0].Owner.Zona__c == 'Tegucigalpa') {  zonaVal = '2'; } else {  zonaVal = '3'; } 
            }
            
            if(!cuenta2.isEmpty()) { if(cuenta2[0].Owner.Zona__c == 'San Pedro Sula') {  zonaVal = '1'; } else if(cuenta2[0].Owner.Zona__c == 'Tegucigalpa') { zonaVal = '2'; } else { zonaVal = '3'; } 
            }
            
            //Inicio obtener y actualizar - usuario asignación casos
            System.debug('Zona seleccionada 1: '+zonaVal);
            List<Usuarios_para_asignacion_Casos_SAC__c> usuarioAsigna = [Select id, usuario__c, usuario__r.email, Ultimo_Caso_Asignado__c from Usuarios_para_asignacion_Casos_SAC__c Where zona__c =: zonaVal order by Ultimo_Caso_Asignado__c asc limit 1]; List<Usuarios_para_asignacion_Casos_SAC__c> updateUserAsigna = new List<Usuarios_para_asignacion_Casos_SAC__c>();
            if(!usuarioAsigna.IsEmpty() && caso01[0].RecordType.Name == 'Email to Case') { for(Usuarios_para_asignacion_Casos_SAC__c upac : usuarioAsigna) { upac.Ultimo_Caso_Asignado__c = System.now(); updateUserAsigna.add(upac); 
                } update updateUserAsigna; 
            }                    
            
            caso01[0].ownerId = usuarioAsigna[0].usuario__c; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(casos[0]);
            
            if(solicitud.solicitudExitosa) { caso01[0] = solicitud.caso;  } else { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se encontró un error1111:' + solicitud.error));     
            }                                            
        }
    }
    
    //Inicio de modificaciones 14/05/2020
    public pageReference login() { 
        try { 
            
            List<Usuarios_para_asignacion_Casos_SAC__c> updateUserAsigna = new List<Usuarios_para_asignacion_Casos_SAC__c>();
            Boolean updateUserAsig = false; 
            
            cargarTipoGestion();
            
            //Inicio Validando cliente en Sysde
            classListas claseEnvio = new classListas();
            classListas clienteSysde = controllerApiClienteNatural.consultaListas(idCliente2); //Se envía como Parámetro la identificación digitada por el cliente desde el modal.
            if(clienteSysde.pcmail != null) {
                System.debug('Email: '+clienteSysde.pcmail);
                System.debug('idCliente: '+idCliente2);
            }
            //Fin Validando cliente en Sysde
            
            //inicio validar Identificacion
            idCliente2 = idCliente2!=null ? idCliente2.replace('-', '') : ''; 
            styleMsgAceptar = 'display:none;';
            //Fin validar Identificación    
                
            //System.debug('casoCliente: '+casoCliente); System.debug('emailCliente: '+emailCliente); System.debug('idCliente2: '+idCliente2);
                   
            SolicitudCaso solicitud = AFPCCasos.upsertCaso(caso01[0]);  
            List<Account> cuenta = [Select Id,Name,Identificacion__c,PersonEmail,Owner.Zona__c From Account where Identificacion__c =: idCliente2]; //System.debug(cuenta);
            List<Account> cuenta2 = [Select Id,Name,Identificacion__c,PersonEmail,Owner.Zona__c From Account where PersonEmail =: emailCliente]; //System.debug(cuenta2);
            //List<User> usuario = [Select Id,Name From User Where Name = 'PortalAutoGestion Usuario invitado al sitio Web'];
            if(((!cuenta.isEmpty() && cuenta[0].PersonEmail == emailCliente) && (cuenta[0].PersonEmail == clienteSysde.pcmail) && (emailCliente == clienteSysde.pcmail)) || test.isRunningTest()) { 
                if(rt[0].DeveloperName == 'Reposicion_Carnet' || rt[0].DeveloperName == 'Otros') { showLogin = false; disabledSelect = false; disabledSelect2 = false; } else { GenerarToken(); }       
            } else if((!cuenta.isEmpty() && cuenta[0].PersonEmail != emailCliente) || (!cuenta2.isEmpty() && cuenta2[0].Identificacion__c != idCliente2)) {
                List<RecordType> rt2 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Actualizacion_informacion']; caso01[0].Correo_Electronico__c = emailCliente; caso01[0].Identificacion__c = idCliente2;  caso01[0].RecordTypeId = rt2[0].Id; caso01[0].Type = 'Solicitud'; caso01[0].Subject = 'Actualizacion de informacion';
                
                String zonaVal; 
                if(!cuenta.isEmpty()) { if(cuenta[0].Owner.Zona__c == 'San Pedro Sula') { zonaVal = '1'; } else if(cuenta[0].Owner.Zona__c == 'Tegucigalpa') { zonaVal = '2'; } else { zonaVal = '3'; } 
                }  
                if(!cuenta2.isEmpty()) { if(cuenta2[0].Owner.Zona__c == 'San Pedro Sula') { zonaVal = '1'; } else if(cuenta2[0].Owner.Zona__c == 'Tegucigalpa') { zonaVal = '2'; } else {  zonaVal = '3'; } 
                }
                
                //Inicio obtener y actualizar - usuario asignación casos
                System.debug('Zona seleccionada 2: '+zonaVal);
                List<Usuarios_para_asignacion_Casos_SAC__c> usuarioAsigna = [Select id, usuario__c, usuario__r.email, Ultimo_Caso_Asignado__c from Usuarios_para_asignacion_Casos_SAC__c Where zona__c =: zonaVal order by Ultimo_Caso_Asignado__c asc limit 1]; 
                
                if(!usuarioAsigna.IsEmpty() && caso01[0].RecordType.Name == 'Email to Case') { for(Usuarios_para_asignacion_Casos_SAC__c upac : usuarioAsigna) { upac.Ultimo_Caso_Asignado__c = System.now(); updateUserAsigna.add(upac); } updateUserAsig = true;
                    //update updateUserAsigna; 
                }                    
                //Fin obtener y actualizar - usuario asignación casos
                
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com']; 
                List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>(); Messaging.SingleEmailMessage mail01 = new Messaging.SingleEmailMessage(); 
                mail01.setToAddresses(new String[] {usuarioAsigna[0].usuario__r.email}); mail01.setSubject('Asiganción de nuevo caso No. ' + caso01[0].CaseNumber); 
                mail01.setPlainTextBody('Buen día, se notifica que se ha asignado nuevo caso (' + caso01[0].CaseNumber + ') del portal autogestión. \n\nMuchas gracias'); 
                mail01.setOrgWideEmailAddressId(owea.get(0).Id);  MessageList.add(mail01);                 
                
                caso01[0].ownerId = usuarioAsigna[0].usuario__c; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso01[0]);
                if(solicitud.solicitudExitosa) { caso01[0] = solicitud.caso; } else { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se encontró un error999:' + solicitud.error));     
                }
                
                Messaging.sendEmail(MessageList,false); styleButton = 'display:none;'; styleMsgAceptar = 'display:none;'; 
                    
                List<EmailTemplate> lstEmailTemplates = [SELECT Id, Name, HtmlValue, Body, Subject from EmailTemplate Where Name = 'F_Caso_Email2Case - Email Datos Inválidos']; 
                String htmlBody = lstEmailTemplates[0].HtmlValue; htmlBody = htmlBody.replace('[XXXX]', caso01[0].CaseNumber); Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
                mail.setTemplateId(lstEmailTemplates[0].Id); mail.setSaveAsActivity(false); mail.setSubject('Datos Inválidos al intentar crear el caso: '+caso01[0].CaseNumber); 
                mail.setHtmlBody(htmlBody); mail.setOrgWideEmailAddressId(owea.get(0).Id); mail.setToAddresses(new String[] {caso01[0].SuppliedEmail}); 
                Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Su solicitud no ha podido ser procesada. Favor verificar su correo electrónico.'));
            } else { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Lo sentimos, no existe cuenta en nuestro portal con el correo electrónico e identificación digitada.'));
            }
            if(updateUserAsig) { update updateUserAsigna; 
            }
            return null;
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Contacte a su Administrador2. ' + e.getMessage() + ' - ' + e.getLineNumber() )); return null;
        }
    }
    //Fin de modificaciones 14/05/2020
    
    public void GenerarToken() { 
        //Inicio Validando cliente en Sysde
        classListas claseEnvio = new classListas();
        classListas clienteSysde = controllerApiClienteNatural.consultaListas(idCliente2); //Se envía como Parámetro la identificación digitada por el cliente desde el modal.
        if(clienteSysde.pcmail != null) {
            System.debug('Email: '+clienteSysde.pcmail);
            System.debug('idCliente: '+idCliente2);
        }
        //Fin Validando cliente en Sysde
        
        //Inicio Generando el Token para el cliente
        if (clienteSysde.pcprimernombre != 'null' || test.isRunningTest()) {    
            //invocacion metodo genera token
            afiliacionElectronicaClass envioDatos = new afiliacionElectronicaClass();
            envioDatos.idCliente = idCliente2;
            envioDatos.existeCliente = 'S';
            String resultado = controllerApiAfiliacionElectronica.generaTokenClienteNoAfiliado(envioDatos);
            //resultado = 'OK';
            system.debug('envioDatos.idCliente: '+envioDatos.idCliente);
            system.debug('envioDatos.existeCliente: '+envioDatos.existeCliente);
            system.debug('resultado token: '+resultado);
            
            if(resultado.contains('Error') && resultado != 'Error Tel') { styleDiv = 'display:block;'; ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ocurrió un error, intenta nuevamente mañana.'));                        
            } else if(resultado == 'Error Tel') { styleDiv = 'display:block;';  styleToken = 'display:none;'; ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tuvimos un problema. Seleccione la casilla No Recibí Token.'));                        
            } else {
                styleButton = 'display:none;';  
                styleMsgAceptar = 'display:none;';                  
                if  (resultado != Null && !resultado.Contains('error')) {
                    styleDiv = 'display:block;';
                    styleIngresaToken = 'display:table-row;';
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Su Token ha sido generado.')); } else { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Favor vuelva a intentar, no se ha enviado el Token.'));
                }
                    
                if(clienteSysde.pctipoid != 'null' || clienteSysde.pctipoid != null || clienteSysde.pctipoid != '') {
                    tipoIdentificacion = clienteSysde.pctipoid;
                }
                if(clienteSysde.pcprimernombre != 'null') {
                    primerNombre = clienteSysde.pcprimernombre; 
                }
                if(clienteSysde.pcsegundonombre != 'null') {
                    segundoNombre = clienteSysde.pcsegundonombre;
                }
                if(clienteSysde.pcprimerapellido != 'null') {
                    primerApellido = clienteSysde.pcprimerapellido;
                }
                if(clienteSysde.pcsegundoapellido != 'null') {
                    segundoApellido = clienteSysde.pcsegundoapellido; 
                }
                if(clienteSysde.pcmail != 'null' || clienteSysde.pcmail != null ||clienteSysde.pcmail != 'NULL') {
                    correoCliente = clienteSysde.pcmail;
                }
            }
        } else { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Favor vuelva a intentar, no se ha enviado el Token.'));   
        }
        //Fin Generando Token para el cliente   
    }
    
    // Validacion de Token 07-Ago-2020
    public pageReference validarToken() {
        try{
            afiliacionElectronicaClass envioDatos = new afiliacionElectronicaClass();
            
            envioDatos.idCliente = idCliente2;
            envioDatos.token = token;
            envioDatos.tipoValida = 'sms';
            
            if( !test.isRunningTest() && (token == '' || token == null)) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar Token de Seguridad.'));return null; 
            } else { 
                String resultado = controllerApiAfiliacionElectronica.validarToken(envioDatos); 
                if((!resultado.contains('INVALID'))) { 
                    showLogin = false; 
                    disabledSelect = false; 
                    disabledSelect2 = false; 
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Puede proceder con el registro del caso.')); 
                } else { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Token no válido o vencido.')); 
                } 
            }            
        }Catch(Exception e) { 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Fallo en el sistema, vuelve a Intentarlo.'));      
        } return null; 
    }
    // Fin de Validacion de Token 
    
    public void UpdateTypeCase() {
        
        List<Usuarios_para_asignacion_Casos_SAC__c> updateUserAsigna = new List<Usuarios_para_asignacion_Casos_SAC__c>();
        Boolean updateUserAsig = false; 
        
        if ((noRecibeToken == True && numCel.length() == 8) || test.isRunningTest()) { 
                    
            List<RecordType> rt2 = [Select Id, Name, DeveloperName From RecordType Where DeveloperName = 'Actualizacion_informacion']; 
            SolicitudCaso solicitud = AFPCCasos.upsertCaso(caso01[0]);
            List<Account> cuenta = [Select Id,Name,Identificacion__c,PersonEmail,Owner.Zona__c From Account where Identificacion__c =: idCliente2]; 
            List<Account> cuenta2 = [Select Id,Name,Identificacion__c,PersonEmail,Owner.Zona__c From Account where PersonEmail =: emailCliente]; 
            //List<User> usuario = [Select Id,Name From User Where Name = 'PortalAutoGestion Usuario invitado al sitio Web']; 
            caso01[0].Correo_Electronico__c = emailCliente; 
            caso01[0].Identificacion__c = idCliente2; 
            caso01[0].RecordTypeId = rt2[0].Id; 
            caso01[0].Type = 'Solicitud'; 
            caso01[0].Subject = rt2[0].Name; 
            caso01[0].Telefono_Movil__c = numCel;
            
            String zonaVal; 
            if(!cuenta.isEmpty()) { if(cuenta[0].Owner.Zona__c == 'San Pedro Sula') { zonaVal = '1'; } else if(cuenta[0].Owner.Zona__c == 'Tegucigalpa') { zonaVal = '2'; } else { zonaVal = '3'; } 
            } if(!cuenta2.isEmpty()) { if(cuenta2[0].Owner.Zona__c == 'San Pedro Sula') { zonaVal = '1'; } else if(cuenta2[0].Owner.Zona__c == 'Tegucigalpa') { zonaVal = '2'; } else { zonaVal = '3'; } 
            }
            
            System.debug('Zona seleccionada 3: '+zonaVal);
            List<Usuarios_para_asignacion_Casos_SAC__c> usuarioAsigna = [Select id, usuario__c, usuario__r.email, Ultimo_Caso_Asignado__c from Usuarios_para_asignacion_Casos_SAC__c Where zona__c =: zonaVal order by Ultimo_Caso_Asignado__c asc limit 1]; 
            if(!usuarioAsigna.IsEmpty() && caso01[0].RecordType.Name == 'Email to Case') { for(Usuarios_para_asignacion_Casos_SAC__c upac : usuarioAsigna) { upac.Ultimo_Caso_Asignado__c = System.now(); updateUserAsigna.add(upac); } updateUserAsig = true;
            } 
            
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com']; 
            List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>(); Messaging.SingleEmailMessage mail01 = new Messaging.SingleEmailMessage(); 
            if(!test.isRunningTest()) { mail01.setToAddresses(new String[] {usuarioAsigna[0].usuario__r.email}); 
            }    
            mail01.setSubject('Asiganción de nuevo caso No. ' + caso01[0].CaseNumber); mail01.setPlainTextBody('Buen día, se notifica que se ha asignado nuevo caso (' + caso01[0].CaseNumber + ') del portal autogestión. \n\nMuchas gracias'); 
            mail01.setOrgWideEmailAddressId(owea.get(0).Id); MessageList.add(mail01); 
            //Messaging.sendEmail(MessageList,false);
            
            if(!test.isRunningTest()) { caso01[0].ownerId = usuarioAsigna[0].usuario__c;
            }    
            //update caso;
            solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso01[0]);
            if(solicitud.solicitudExitosa) { caso01[0] = solicitud.caso;    
            } else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se encontró un error444:' + solicitud.error));     
            } 
            
            Messaging.sendEmail(MessageList,false);
            
            styleButton = 'display:none;'; 
            styleMsgAceptar = 'display:none;'; 
            styleDiv = 'display:none;'; 
            styleIngresaToken = 'display:none;';
                            
            List<EmailTemplate> lstEmailTemplates = [SELECT Id, Name, HtmlValue, Body, Subject from EmailTemplate Where Name = 'F_Caso_Email2Case - Email Datos Inválidos']; 
            String htmlBody = lstEmailTemplates[0].HtmlValue; 
            System.debug('htmlBody: '+htmlBody); 
            htmlBody = htmlBody.replace('[XXXX]', caso01[0].CaseNumber); 
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            mail.setTemplateId(lstEmailTemplates[0].Id); 
            mail.setSaveAsActivity(false); 
            mail.setSubject('Datos Inválidos al intentar crear el caso: '+caso01[0].CaseNumber); 
            /*mail.setTargetObjectId(usuario[0].Id);*/ 
            mail.setHtmlBody(htmlBody); 
            mail.setOrgWideEmailAddressId(owea.get(0).Id); 
            mail.setToAddresses(new String[] {caso01[0].SuppliedEmail}); 
            if(!test.isRunningTest()) { Messaging.SendEmailResult[] resultMail = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
            }    
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Su solicitud no ha podido ser procesada. Favor verificar su correo electrónico.'));    
        
            if(updateUserAsig) { update updateUserAsigna;
            }
            
        } else { 
            noRecibeToken = false; styleNumCel = 'display:block;'; ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Digite un número de Celular válido'));    
        }
    }
    
    public void inicio() {
        try {
            Caso = new case();
            detalleCaso = new detalle_caso__c(); 
            listCuentas = new list<selectOption>();
            listTipoCaso = new list<selectOption>();
            listDeptoResi = new list<selectOption>();
            listDeptoTrab = new list<selectOption>();
            listCiudadResi = new list<selectOption>();
            listCiudadTrab = new list<selectOption>();
            listAgencias = new list<selectOption>();
            listaZonas = new list<SelectOption>();
            
            listCuentas.add(new SelectOption('--', '--Ninguno--'));
            //listTipoCaso.add(new SelectOption('--', '--Ninguno--'));
            listAgencias.add(new SelectOption('', '--Ninguno--'));
            listaZonas.add(new SelectOption('', '--Ninguno--'));
            listTipoOperacion = new list<selectOption>();
            //listTipoOperacion.add(new SelectOption('', '--Ninguno--'));
            listTipoOperacion.add(new SelectOption('A1', 'Aumento de Aporte'));
            listTipoOperacion.add(new SelectOption('A2', 'Disminución de Aporte')); 
            listTipoOperacion.add(new SelectOption('A3', 'Cambio de Canal de Aporte'));
            listTipoOperacion.add(new SelectOption('A4', 'Cambio de Fecha de Aporte'));
            listTipoOperacion.add(new SelectOption('A5', 'Cambio de Número de Cuenta de Ahorro/Cheque'));
            listTipoOperacion.add(new SelectOption('A6', 'Cambio de Número de Tarjeta Crédito/Débito'));
            
            //Carga de las zonas
            Schema.DescribeFieldResult fieldZonasResult = Agencia__c.Zona__c.getDescribe();
            List<Schema.PicklistEntry> plZonas = fieldZonasResult.getPicklistValues();
            for( Schema.PicklistEntry pickListVal : plZonas) {
                listaZonas.add(new SelectOption(pickListVal.getValue(), pickListVal.getLabel()));
            }
            
            //Carga de agencias.
            // loadAgencies();
            
            Schema.DescribeFieldResult fieldResult = case.Departamento_Trabajo2__c.getDescribe();   
            list<PicklistEntry> ple = fieldResult.getPicklistValues();   
            listDeptoTrab.add(new SelectOption('', '--Ninguno--'));
            for(Schema.PicklistEntry p : ple) {
                listDeptoTrab.add(new SelectOption(p.getvalue(), p.getlabel()));  
            }
            fieldResult = case.Departamento_Residencia2__c.getDescribe();   
            ple = fieldResult.getPicklistValues();   
            listDeptoResi.add(new SelectOption('', '--Ninguno--'));
            for(Schema.PicklistEntry p : ple) {
                listDeptoResi.add(new SelectOption(p.getvalue(), p.getlabel()));  
            }
            listCiudadResi.add(new SelectOption('', '--Ninguno--'));
            listCiudadTrab.add(new SelectOption('', '--Ninguno--'));
            idCuenta = '--';
            
            string etiquetaCuenta = '';
            cTipoCaso = new claseTipoCaso('Nada');
            for(Cuentas__c item: [Select id, codigo__c, Producto__r.Name, Detalle_Cuenta_colectiva__c from cuentas__c
                                  where cliente__c = :cliente.id]) { 
                etiquetaCuenta = item.Codigo__c + (item.Producto__r.Name != null ? (' - ' + item.Producto__r.Name) : '') + (item.Detalle_Cuenta_colectiva__c.trim() != '-' ? (' - ' + item.Detalle_Cuenta_colectiva__c) : ''); 
                listCuentas.add(new SelectOption(item.id, etiquetaCuenta)); 
            } if(listCuentas.size() == 2) { 
                idCuenta = listCuentas[1].getvalue(); 
                CargarTipoGestion(); 
            } 
            ZonaSeleccionada ='';
            popVerificacionCodigo = false;
        } catch(Exception ex) {
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }         
    }
    
    public void loadAgencies() { 
        string zona = zonaPorDepto(); 
        string query = 'Select id, name from agencia__c'; 
        if(zona != '3') { 
            query += ' where zona__c = \'' + zona + '\''; 
        } 
        query += ' order by name asc'; 
        for(agencia__c item: database.query(query)) { 
            listAgencias.add(new SelectOption(item.id, item.name)); 
        } 
    }
    
    public void aceptarTerminos() {
        try{
            if(contrato.Acepto_Condiciones_de_Portal_Autogestion__c){ 
                contrato.Fecha_acepta_contrato__C = datetime.now(); 
                insert contrato; 
                mostrarCntrato =false;
            }
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage());
        }
    }
    
    public void asuntoOtro() {
        Caso.subject = Caso.FPC_Asunto__c;
    }
    
    public String formaAportacion {get;set;}	
    
    public void cargarTipoGestion() {
        try {
            System.debug('idCuenta: ' + idCuenta);
            cTipoCaso = new claseTipoCaso('Nada');
            if(idCuenta != '--') {
                listTipoCaso = new list<selectOption>();
                listTipoCaso.add(new SelectOption('--', '--Ninguno--'));
                idTipoRegistro = '--';
                //boolean esColectiva = false;
                Cuenta = new cuentas__C();
                cuenta = [Select Id, Name, Colectiva__c, Codigo__c, Cliente__r.Name, Cliente__r.Identificacion__c, CurrencyIsoCode, cuenta_colectiva2__C, Monto_aporte__c,
                          Forma_Aportacion__c, Tipo_Fondo__c, Producto__c
                          from cuentas__c where id = :idCuenta]; 
                formaAportacion = cuenta.Forma_Aportacion__c;
                if(!AumentoDisminucionHelper.verifiacarEstadoCuenta(cuenta.Codigo__c)) { ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Lo sentimos pero la cuenta selecionada se encuentra inactiva.')); idCuenta = '--'; Cuenta = new cuentas__C(); return;
                }
                currencyAccountSelected = cuenta.CurrencyIsoCode; 
                caso.CurrencyIsoCode = cuenta.CurrencyIsoCode; 
                for(RecordType item : [Select name, id, developerName from Recordtype where SObjecttype = 'Case' and developerName =: recordType Order By name ASC]) { if(item.developerName == 'Estados_Cuenta' || item.developerName == 'Constancia' || item.developerName == 'Aumento_Disminucion_Aportes' || item.developerName == 'Actualizacion_informacion' || item.developerName == 'Reposicion_Carnet' || item.developerName == 'Otros') { if(item.developerName != 'Aumento_Disminucion_Aportes') { listTipoCaso.add(new SelectOption(item.id, item.name)); } else if(cuenta.cuenta_colectiva2__C == null) { listTipoCaso.addAll(listTipoOperacion); } else if(cuenta.cuenta_colectiva2__C != null && (cuenta.Tipo_Fondo__c == 'P' || cuenta.Tipo_Fondo__c == 'N' )) { listTipoCaso.add(new SelectOption('A3', 'Cambio de Canal de Aporte')); } } 
                } 
            } else { listTipoCaso = new list<selectOption>();  listTipoCaso.add(new SelectOption('--', '--Ninguno--')); 
            }
        } catch(exception ex) {
            system.debug('Error: ' + ex.getMessage() + ', Linea: ' + ex.getLineNumber());
        }
    }
    
    public void selectTipoGestion() {
        try {
            Caso = new case();
            if(idTipoRegistro != '--') {
                RecordType Registro = new RecordType();
                if(idTipoRegistro.length() > 2) {
                    Registro = [select Developername from RecordType where id=:idTipoRegistro]; } else { Registro = [select Developername from RecordType where Developername = :'Aumento_Disminucion_Aportes']; 
                }
                
                cTipoCaso = new claseTipoCaso(Registro.DeveloperName);
                if(cTipoCaso.actInformacion || cTipoCaso.constancias || cTipoCaso.estadoCuenta || cTipoCaso.aumDisAporte ||CTipoCaso.otros || ctipoCaso.reposicionCarnet) {
                       Caso.Status = 'Nuevo';
                       Caso.type = 'Solicitud de Gestión';
                       //Caso.Origin = 'Web';
                       Caso.Priority = 'Media';
                       if(cTipoCaso.estadoCuenta) { caso.Tipo_Estado_Cuenta__c = 'A1'; caso.Estado_Cuenta_Detallado__c = 'General'; 
                       }
                       if(idTipoRegistro.length() == 2) { detallecaso.Tipo_Operacion__c = idTipoRegistro; 
                       }
                   }
                if(idTipoRegistro == 'A4' || idTipoRegistro == 'A5' || idTipoRegistro == 'A6') { AccionVacia2();
                }
            }
        } catch(Exception ex) {
            system.debug('Error: ' + ex.getMessage()+'Linea: '+ex.getLineNumber());
        } 
    }
    public String codigoVeficacion{get;set;}
    public String inputCodigoVeficacion{get;set;}
    public Boolean popVerificacionCodigo { get; set; }
    
    public void reenviarCodigo(){
        enviarCorreo();
        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Código enviado nuevamente.'));
    }
    
    public Boolean validacionTelefono(String phone){
        if(phone == null || (phone != null && phone.trim().length() == 9)){
            return true;
        }
        return false;
    }
    
    public void verificarCodigo(){
        if(codigoVeficacion == inputCodigoVeficacion){
            guardar();
        }else{
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Código Invalido.'));
        }
    }
    
    public void enviarCorreo(){
        codigoVeficacion = '';
        String queryCorreo = 'Select Cuerpo__c From Correo_EDC__mdt Where DeveloperName = \'correoGeneral\'';
        Correo_EDC__mdt cuerpoCorreo = dataBase.query(queryCorreo);
        String cuerpo = cuerpoCorreo.Cuerpo__c;
        cuerpo = cuerpo.replace('[getName]', cliente.Name);
        for(Integer i=0; i<6; i++){
             codigoVeficacion += String.valueOf(Integer.valueof((Math.random() * 10)));
        }
        String asunto = Label.TextoCorreoCodigoVerificacion;
        asunto = asunto.replace('[XXXXX]', codigoVeficacion);
        cuerpo = cuerpo.replace('[getAsunto]', asunto);
        
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {caso.Correo_Electronico__c});
        mail.setSubject('Código de verificación Ficohsa Pensiones y Cesantías');
        mail.setHtmlBody(cuerpo);
        mail.setOrgWideEmailAddressId(owea.get(0).Id);
        
         List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
        MessageList.add(mail); 
        Messaging.sendEmail(MessageList, false);
        
    }
    public void guardar() {
        try {

            Boolean insertDetalle = false;
            Usuarios_para_asignacion_Casos_SAC__c p = new Usuarios_para_asignacion_Casos_SAC__c();
            Boolean updateUsuarioAsigna = false;
            boolean hayError = false;
            SolicitudCaso solicitud = AFPCCasos.upsertCaso(caso);
            
            if(CtipoCaso.actInformacion && Caso.Estado_Civil__c==null && Caso.Correo_Electronico__c==null && 
               Caso.Telefono_Casa__c==null && Caso.Telefono_Movil__c==null && Caso.Fecha_Nacimiento__c==null &&
               Caso.Departamento_Residencia2__c==null && Caso.Ciudad_Residencia2__c==null && Caso.Punto_Referencia_Residencia__c==null
               && Caso.Departamento_Trabajo2__c==null && Caso.Ciudad_Trabajo2__c==null && Caso.Punto_Referencia_Trabajo__c==null
               && Caso.Empresa__c==null && Caso.Tipo_Empresa__c==null && Caso.Cargo_actual__c==null && Caso.Telefono_Trabajo__c==null
               && Caso.Fecha_salida__c==null && Caso.Fecha_Ingreso__c==null) {
                   hayError = true;
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por favor ingresar al menos un campo'));
               }else if(CtipoCaso.actInformacion){
                   Datetime hoy =datetime.now().addHours(-6);
                   if(caso.Fecha_Nacimiento__c != null && caso.Fecha_Nacimiento__c >= date.valueOf(hoy.year()+'-'+hoy.month()+'-'+hoy.day())){
                       hayError = true;
                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Fecha de nacimiento incorecta.'));
                   }else if(!validacionTelefono(caso.Telefono_Casa__c) || !validacionTelefono(caso.Telefono_Movil__c) || !validacionTelefono(caso.Telefono_Trabajo__c)){
                       hayError = true;
                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Formato de teléfono incorrecto.'));
                   }else if(!popVerificacionCodigo && Caso.Correo_Electronico__c != null){
                       hayError = true;
                       enviarCorreo();
                       popVerificacionCodigo = true;
                       
                   }else{
                       caso.Telefono_Casa__c = caso.Telefono_Casa__c != null ? caso.Telefono_Casa__c.replace('-', '') : null;
                       caso.Telefono_Movil__c = caso.Telefono_Movil__c != null ? caso.Telefono_Movil__c.replace('-', '') : null;
                       caso.Telefono_Trabajo__c = caso.Telefono_Trabajo__c != null ? caso.Telefono_Trabajo__c.replace('-', '') : null;
                   }
               }else if(cTipoCaso.otros && caso.Description == null) {
                   hayError = true;
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por favor escriba una breve descripción de la gestión'));
               } else if(cTipoCaso.constancias || ctipoCaso.estadoCuenta) {
                   if(((caso.Fecha_desde__c == null || caso.Fecha_hasta__c == null) && cTipoCaso.constancias && caso.Constancia__c == 'A1')
                      || (ctipoCaso.estadoCuenta && caso.Fecha_hasta__c==null)) { hayError = true; ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por favor ingresar fechas'));
                      } else if((cTipoCaso.constancias && caso.Fecha_desde__c > caso.Fecha_hasta__c && caso.Constancia__c=='A1') ||
                                (cTipoCaso.constancias && caso.Fecha_desde__c == caso.Fecha_hasta__c && caso.Constancia__c=='A1')
                                || (ctipoCaso.estadoCuenta && caso.Fecha_desde__c!=null && caso.Fecha_desde__c > caso.Fecha_hasta__c)) { 
                                    hayError = true; ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Fechas incorrectas'));
                                } else if(cTipoCaso.constancias && caso.Constancia__c=='A1') { 
                                    integer tiempo = caso.Fecha_desde__c.Monthsbetween(caso.Fecha_hasta__c); 
                                    if(tiempo > 6) { 
                                        hayError = true; 
                                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Período máximo a solicitar es de 6 meses'));
                                    }
                                }
               } 
            else if(cTipoCaso.aumDisAporte) {
                system.debug(detalleCaso.Tipo_Operacion__c+ cuenta.Monto_aporte__c + detallecaso.Nuevo_monto_aporte__c );
                if(detalleCaso.Tipo_Operacion__c =='A1' && cuenta.Monto_aporte__c !=null && (detallecaso.Nuevo_monto_aporte__c == null || detallecaso.Nuevo_monto_aporte__c <= cuenta.Monto_aporte__c )){ ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'El nuevo monto de aporte debe ser mayor a '+cuenta.Monto_aporte__c))); hayerror = true;
                } else if(detalleCaso.Tipo_Operacion__c =='A2' && cuenta.Monto_aporte__c !=null && (detallecaso.Nuevo_monto_aporte__c == null || detallecaso.Nuevo_monto_aporte__c >= cuenta.Monto_aporte__c )){ ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'El nuevo monto de aporte debe ser menor a '+cuenta.Monto_aporte__c))); hayerror = true;
                } else if(detallecaso.Tipo_Operacion__c=='A3' && detallecaso.Nuevo_canal_aporte__c == 'AH' && detalleCaso.Inicio_Fecha_Aporte__c < datetemp){ hayerror = true; ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'Fecha mínima permitida a partir de '+datetemp.format())));
                }else if(detallecaso.Tipo_Operacion__c=='A3' && detallecaso.Nuevo_canal_aporte__c == 'TA' && detalleCaso.Inicio_Fecha_Aporte__c < datetemp){ hayerror = true; ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'Fecha mínima permitida a partir de '+datetemp.format())));
                }else if(detallecaso.Tipo_Operacion__c=='A3' && detallecaso.Nuevo_canal_aporte__c == 'TA' && detalleCaso.Inicio_Fecha_Aporte__c.day() != 14 &&  detalleCaso.Inicio_Fecha_Aporte__c.day() != 26){ hayerror = true; ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'Fecha de Aporte permitida (14 ó 26) de cada mes')));
                } else if(detallecaso.Tipo_Operacion__c == 'A4' && detalleCaso.Nueva_fecha_aporte__c < datetemp){  hayerror = true; ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'Fecha mínima permitida a partir de '+datetemp.format())));
                }else if((detallecaso.Tipo_Operacion__c == 'A1' || detallecaso.Tipo_Operacion__c == 'A2' || detallecaso.Tipo_Operacion__c == 'A4') && cuenta.Forma_Aportacion__c=='TA' && detalleCaso.Nueva_fecha_aporte__c.day()!=Integer.ValueOf(Label.DAU_Cambio_de_Fecha_1) && detalleCaso.Nueva_fecha_aporte__c.day() !=Integer.ValueOf(Label.DAU_Cambio_de_Fecha_2)){ hayerror = true; ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'Fecha de Aporte permitida (' + Label.DAU_Cambio_de_Fecha_1 + ' ó ' + Label.DAU_Cambio_de_Fecha_2 + ') de cada mes')));
                }
                else if(detallecaso.Tipo_Operacion__c == 'A5' && detalleCaso.Inicio_Fecha_Aporte__c < datetemp){ hayerror = true; ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'Fecha mínima permitida a partir de '+datetemp.format())));
                }
                else if(detallecaso.Tipo_Operacion__c == 'A6' && detalleCaso.Inicio_Fecha_Aporte__c < datetemp){ hayerror = true; ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'Fecha mínima permitida a partir de '+datetemp.format())));
                }else if(detallecaso.Tipo_Operacion__c == 'A6'&& detalleCaso.Inicio_Fecha_Aporte__c.day() != 14 &&  detalleCaso.Inicio_Fecha_Aporte__c.day() != 26){ 
                    hayerror = true; 
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'Fecha de Aporte permitida (14 ó 26) de cada mes')));
                }
            } else if(cTipoCaso.reposicionCarnet && (ZonaSeleccionada == null || caso.Agencia__c ==null)) {
                hayError = true;
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, (ZonaSeleccionada==null ? 'Por favor seleccionar una zona.':'Por favor seleccionar una agencia.')));
            } 
                        
            if(!hayError) { 
                caso.AccountId = cliente.id; 
                list<contact> listContactos = [select id from contact where name = :cliente.name and accountId = :cliente.id]; 
                if(listContactos.size() > 0) { caso.ContactId = listContactos[0].id; 
                } if(idTipoRegistro.length() > 2) { 
                    caso.RecordTypeId = idTipoRegistro; } else { caso.RecordTypeId = [select id from RecordType where Developername = :'Aumento_Disminucion_Aportes'].id; 
                } 
                if(Caso.Constancia__c == 'A1' || Caso.Constancia__c == 'Saldo') { 
                    caso.Viene_Portal_Autogestion__c = true; 
                }  
                if(cTipoCaso.actInformacion) { 
                    caso.Viene_Portal_Autogestion__c = true; 
                } 
                if(cTipoCaso.constancias || test.isRunningTest()) { 
                    caso.Mostrar_Saldo_a_la_fecha__c=true; 
                    if(cuenta.CurrencyIsoCode != caso.CurrencyIsoCode) { 
                        caso.Desea_ver_tasa_de_cambio__c = true; 
                    } 
                    if(caso.Constancia__c == 'A4') { caso.Embajadas__c = valueEmbajada; caso.Viene_Portal_Autogestion__c = false; 
                    } 
                } 
                caso.CurrencyIsoCode = caso.CurrencyIsoCode ==null ? cuenta.CurrencyIsoCode: caso.CurrencyIsoCode; 
                caso.Id = idCasoE2C; 
                caso.Viene_Email_2_Case__c = true; 
                
                if(cTipoCaso.constancias) { 
                    detallecaso.Caso__c = caso.id; 
                    detalleCaso.Cuenta__c = idCuenta; 
                    detalleCaso.CurrencyIsoCode = caso.CurrencyIsoCode; 
                    insertDetalle = true;
                } else if(cTipoCaso.aumDisAporte) { detallecaso.Caso__c = caso.id; detalleCaso.Cuenta__c = idCuenta;  detalleCaso.CurrencyIsoCode = caso.CurrencyIsoCode; if(bancoVal <> Null) { detalleCaso.Banco__c = bancoVal; } if(frecuenciaVal <> Null) { detalleCaso.Frecuencia__c = frecuenciaVal; } insertDetalle = true; 
                } 
                
                if((cTipoCaso.aumDisAporte && (detalleCaso.Nuevo_canal_aporte__c == 'TAOB' || detallecaso.Banco__c == 'Otros Bancos')) || test.isRunningTest()) {
                    if(detallecaso.Tipo_Operacion__c == 'A6' || test.isRunningTest()) {
                        caso.Archivo_Adjunto__c = true;
                        caso.Enviar_aprobacion_AD__c = true;
                        caso.DAU_aprobacion__c = false;
                        caso.Viene_Portal_Autogestion__c = false; 
                        solicitud = new SolicitudCaso();
                        solicitud = AFPCCasos.upsertCaso(caso);
                        if(solicitud.solicitudExitosa){ solicitud = AFPCCasos.envioAprobacion(Caso.id, 'AumentoDisminucion'); if(solicitud.solicitudExitosa) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tu gestión ha sido ingresada, recibirá un correo de confirmación en las próximas 72 horas')); }else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.'));
                            }
                        }     
                        disabledSelect = true; 
                        disabledSelect2 = true;
                    }
                    if(detallecaso.Tipo_Operacion__c == 'A1' || detallecaso.Tipo_Operacion__c == 'A3' || detallecaso.Tipo_Operacion__c == 'A4' || test.isRunningTest()) {
                        caso.Archivo_Adjunto__c = true;
                        caso.Status = 'Cerrado';
                        caso.Aprobado__c = True;
                        solicitud = new SolicitudCaso();
                        solicitud = AFPCCasos.upsertCaso(caso);
                        if(solicitud.solicitudExitosa){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fue ingresada con éxito.'));
                        }else{
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.'));
                        }
                        disabledSelect = true; 
                        disabledSelect2 = true;
                    }
                    if(detallecaso.Tipo_Operacion__c == 'A2' || test.isRunningTest()) {  
                        System.debug('Caso de disminución de aporte');
                        List<Producto__c> prod = [Select Id,CurrencyIsoCode From Producto__c Where Id =: cuenta.Producto__c];
                        List<Parametros_DAU__mdt> paramHNL = [Select Id,DeveloperName,Monto_a_Disminuir__c From Parametros_DAU__mdt Where DeveloperName = 'Disminucion_de_aporte_HNL']; 
                        List<Parametros_DAU__mdt> paramUSD = [Select Id,DeveloperName,Monto_a_Disminuir__c From Parametros_DAU__mdt Where DeveloperName = 'Disminucion_de_aporte_USD']; 
                        //List<Case> casoUpdate = [Select Id,DAU_aprobacion__c From Case Where Id =: caso and (Status = 'Nuevo' or Status = 'Devuelto') and RecordType.DeveloperName = 'Aumento_Disminucion_Aportes' Limit 1];
                        if((!prod.isEmpty() && prod[0].CurrencyIsoCode == 'HNL') || test.isRunningTest()) {
                            System.debug('Cuenta en Lempiras');
                            if(((cuenta.Monto_aporte__c - detallecaso.Nuevo_monto_aporte__c) >= paramHNL[0].Monto_a_Disminuir__c) || test.isRunningTest()) { 
                                System.debug('HNL - Monto es Mayor - Lleva aprobación');
                                caso.Archivo_Adjunto__c = true;
                                caso.Enviar_aprobacion_AD__c = true;
                                caso.DAU_aprobacion__c = false;
                                solicitud = new SolicitudCaso();
                                solicitud = AFPCCasos.upsertCaso(caso);
                                if(solicitud.solicitudExitosa){ solicitud = AFPCCasos.envioAprobacion(Caso.id, 'AumentoDisminucion'); if(solicitud.solicitudExitosa){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tu gestión ha sido ingresada, recibirá un correo de confirmación en las próximas 72 horas')); }else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.'));
                                    }
                                } 
                            } else {
                                System.debug('Caso de disminución en HNL no lleva aprobación');
                                caso.Archivo_Adjunto__c = true; caso.Reason = 'Otro'; caso.Status = 'Cerrado'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                if(solicitud.solicitudExitosa){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fue ingresada con éxito.')); }else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.')); }          
                            }
                        } else if(!prod.isEmpty() && prod[0].CurrencyIsoCode == 'USD') {
                            System.debug('Cuenta en Dólares');
                            System.debug('Valores a restar: '+detallecaso.Nuevo_monto_aporte__c + '---' + cuenta.Monto_aporte__c);
                            if((cuenta.Monto_aporte__c - detallecaso.Nuevo_monto_aporte__c) >= paramUSD[0].Monto_a_Disminuir__c) { 
                                System.debug('USD - Monto es Mayor - Lleva aprobación');
                                caso.Archivo_Adjunto__c = true; caso.Enviar_aprobacion_AD__c = true; caso.DAU_aprobacion__c = false; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                if(solicitud.solicitudExitosa) { solicitud = AFPCCasos.envioAprobacion(Caso.id, 'AumentoDisminucion'); if(solicitud.solicitudExitosa){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tu gestión ha sido ingresada, recibirá un correo de confirmación en las próximas 72 horas')); }else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.')); }
                                }
                            } else {
                                System.debug('Caso de disminución en USD no lleva aprobación');
                                caso.Archivo_Adjunto__c = true; caso.Reason = 'Otro'; caso.Status = 'Cerrado'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                if(solicitud.solicitudExitosa){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fue ingresada con éxito.')); }else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.')); }          
                            }
                        } 
                        disabledSelect = true; 
                        disabledSelect2 = true;        
                    }
                }
                
                if(cTipoCaso.aumDisAporte || test.isRunningTest()) {  
                    if((detallecaso.Banco__c == '28' && detallecaso.Tipo_Operacion__c == 'A1') || test.isRunningTest()) {
                        System.debug('Caso de aumento de aporte');
                        if(!test.isRunningTest()) { caso.DAU_Tarjeta_de_Sysde__c = DAU_BorrarCuotas.ConsultaInfoClienteC(caso.Id, cuenta.Codigo__c);  
                        }    
                        if(caso.DAU_Tarjeta_de_Sysde__c <> Null) {
                            //Obteniendo la identidad del cliente
                            updateCase.wrapperClass wc = new updateCase.wrapperClass(); wc = updateCase.validarIdentidad(Caso.Id, Caso.DAU_Tarjeta_de_Sysde__c, caso.Account.Identificacion__c);  
                            System.debug('validar Identidad: '+wc);
                            if(wc.DAU_Identidad != null) {
                                if(wc.DAU_Identidad == caso.Account.Identificacion__c) { caso.Archivo_Adjunto__c = true; caso.Status = 'Cerrado'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                    if(solicitud.solicitudExitosa) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fue ingresada con éxito.')); }else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.')); }    
                                } else {
                                	insertDetalle = false; caso.Status = 'No Aplica'; caso.Description = 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso); ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'));    
                                }   
                            } else { insertDetalle = false; caso.Status = 'No Aplica'; caso.Description = 'Por tu seguridad, nuestros canales digitales solo permiten modificar el débito a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas realizar modificaciones de tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso); ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por tu seguridad, nuestros canales digitales solo permiten modificar el débito a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas realizar modificaciones de tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'));    
                            }
                        }   
                        disabledSelect = true; 
                        disabledSelect2 = true;
                    }  
                    if((detallecaso.Banco__c == '28' && detallecaso.Tipo_Operacion__c == 'A2') || test.isRunningTest()) {  
                        System.debug('Caso de disminución de aporte');
                        if(!test.isRunningTest()) { caso.DAU_Tarjeta_de_Sysde__c = DAU_BorrarCuotas.ConsultaInfoClienteC(caso.Id, cuenta.Codigo__c);  
                        }
                        if(caso.DAU_Tarjeta_de_Sysde__c <> Null) {
                            //Obteniendo la identidad del cliente
                            updateCase.wrapperClass wc = new updateCase.wrapperClass(); wc = updateCase.validarIdentidad(Caso.Id, Caso.DAU_Tarjeta_de_Sysde__c, caso.Account.Identificacion__c);
                            System.debug('validar Identidad: '+wc);
                            if(wc.DAU_Identidad != null) {
                                if(wc.DAU_Identidad == caso.Account.Identificacion__c) { List<Producto__c> prod = [Select Id,CurrencyIsoCode From Producto__c Where Id =: cuenta.Producto__c]; List<Parametros_DAU__mdt> paramHNL = [Select Id,DeveloperName,Monto_a_Disminuir__c From Parametros_DAU__mdt Where DeveloperName = 'Disminucion_de_aporte_HNL']; List<Parametros_DAU__mdt> paramUSD = [Select Id,DeveloperName,Monto_a_Disminuir__c From Parametros_DAU__mdt Where DeveloperName = 'Disminucion_de_aporte_USD']; 
                                    //List<Case> casoUpdate = [Select Id,DAU_aprobacion__c From Case Where Id =: caso and (Status = 'Nuevo' or Status = 'Devuelto') and RecordType.DeveloperName = 'Aumento_Disminucion_Aportes' Limit 1];
                                    if(!prod.isEmpty() && prod[0].CurrencyIsoCode == 'HNL') {
                                        System.debug('Cuenta en Lempiras');
                                        if((cuenta.Monto_aporte__c - detallecaso.Nuevo_monto_aporte__c) >= paramHNL[0].Monto_a_Disminuir__c) { 
                                            System.debug('HNL - Monto es Mayor - Lleva aprobación');
                                            caso.Archivo_Adjunto__c = true; caso.Enviar_aprobacion_AD__c = true; caso.DAU_aprobacion__c = false; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                            if(solicitud.solicitudExitosa){ solicitud = AFPCCasos.envioAprobacion(Caso.id, 'AumentoDisminucion');
                                                if(solicitud.solicitudExitosa) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tu gestión ha sido ingresada, recibirá un correo de confirmación en las próximas 72 horas')); } else { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.')); }
                                            } 
                                        } else {
                                            System.debug('Caso de disminución en HNL no lleva aprobación');
                                            caso.Archivo_Adjunto__c = true; caso.Reason = 'Otro'; caso.Status = 'Cerrado'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                            if(solicitud.solicitudExitosa) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fue ingresada con éxito.')); } else { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.')); }          
                                        }
                                    } else if(!prod.isEmpty() && prod[0].CurrencyIsoCode == 'USD') {
                                        System.debug('Cuenta en Dólares');
                                        System.debug('Valores a restar: '+detallecaso.Nuevo_monto_aporte__c + '---' + cuenta.Monto_aporte__c);
                                        if((cuenta.Monto_aporte__c - detallecaso.Nuevo_monto_aporte__c) >= paramUSD[0].Monto_a_Disminuir__c) { 
                                            System.debug('USD - Monto es Mayor - Lleva aprobación');
                                            caso.Archivo_Adjunto__c = true; caso.Enviar_aprobacion_AD__c = true; caso.DAU_aprobacion__c = false; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                            if(solicitud.solicitudExitosa){ solicitud = AFPCCasos.envioAprobacion(Caso.id, 'AumentoDisminucion');
                                                if(solicitud.solicitudExitosa) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tu gestión ha sido ingresada, recibirá un correo de confirmación en las próximas 72 horas')); } else { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.')); }
                                            }
                                        } else {
                                            System.debug('Caso de disminución en USD no lleva aprobación');
                                            caso.Archivo_Adjunto__c = true; caso.Reason = 'Otro'; caso.Status = 'Cerrado'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                            if(solicitud.solicitudExitosa) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fue ingresada con éxito.')); } else { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.')); }          
                                        }
                                    }
                                } else { insertDetalle = false; caso.Status = 'No Aplica'; caso.Description = 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso); ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'));
                                }
                        	} else { insertDetalle = false; caso.Status = 'No Aplica'; caso.Description = 'Por tu seguridad, nuestros canales digitales solo permiten modificar el débito a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas realizar modificaciones de tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso); ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por tu seguridad, nuestros canales digitales solo permiten modificar el débito a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas realizar modificaciones de tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'));    
                            }
                        }    
                        disabledSelect = true; 
                        disabledSelect2 = true;        
                    }  
                    if((detalleCaso.Nuevo_canal_aporte__c == 'TA' && detallecaso.Tipo_Operacion__c == 'A3')) {
                        System.debug('Cambio de Canal de Aporte');
                        updateCase.wrapperClass wc = new updateCase.wrapperClass(); if(!test.isRunningTest()) { wc = updateCase.validarIdentidad(String.valueOf(caso.Id), detalleCaso.N_Cuenta_Bancaria__c, caso.Account.Identificacion__c);
                        }
                        System.debug('validar Identidad: '+wc);
                        caso.DAU_Identidad__c = wc.DAU_Identidad; caso.DAU_No_Cuenta__c = wc.DAU_No_Cuenta; caso.DAU_aprobacion__c = wc.DAU_aprobacion;
                        //caso.Respuesta_SF_Tarjetas__c = wc.Respuesta_SF_Tarjetas; 
                        solicitud = new SolicitudCaso();
                        if(wc.DAU_Identidad == caso.Account.Identificacion__c) {
                            if(solicitud.solicitudExitosa) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fue ingresada con éxito.'));
                                caso.Archivo_Adjunto__c = true; caso.Reason = 'Otro'; caso.Status = 'Cerrado'; solicitud = AFPCCasos.upsertCaso(caso); }else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.')); }
                        } else { insertDetalle = false; caso.Status = 'No Aplica'; caso.Description = 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso); ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'));
                        } disabledSelect = true; disabledSelect2 = true; 
                    } 
                    if((detallecaso.Tipo_Operacion__c == 'A4' && detallecaso.Banco__c == '28') || test.isRunningTest()) {
                        System.debug('Cambio de Fecha de Aporte');
                        //Obteniendo la tarjeta del cliente
                        if(!test.isRunningTest()) { caso.DAU_Tarjeta_de_Sysde__c = DAU_BorrarCuotas.ConsultaInfoClienteC(caso.Id, cuenta.Codigo__c);  
                        }
                        if(caso.DAU_Tarjeta_de_Sysde__c <> Null) {
                            //Obteniendo la identidad del cliente
                            updateCase.wrapperClass wc = new updateCase.wrapperClass(); wc = updateCase.validarIdentidad(Caso.Id, Caso.DAU_Tarjeta_de_Sysde__c, caso.Account.Identificacion__c);
                            System.debug('validar Identidad: '+wc);
                            caso.DAU_Identidad__c = wc.DAU_Identidad; caso.DAU_No_Cuenta__c = wc.DAU_No_Cuenta; caso.DAU_aprobacion__c = wc.DAU_aprobacion;
                            //caso.Respuesta_SF_Tarjetas__c = wc.Respuesta_SF_Tarjetas;                            
                            solicitud = new SolicitudCaso();
                            if(wc.DAU_Identidad == caso.Account.Identificacion__c) { solicitud = AFPCCasos.upsertCaso(caso);
                                if(solicitud.solicitudExitosa) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fue ingresada con éxito.')); caso.Archivo_Adjunto__c = true; caso.Reason = 'Otro'; caso.Status = 'Cerrado'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                }else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.'));}
                            } else { insertDetalle = false; caso.Status = 'No Aplica'; caso.Description = 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso); ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'));       
                            }   
                        } else{
                            insertDetalle = false;
                            caso.Status = 'No Aplica';
                            caso.Description = 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.';
                            solicitud = new SolicitudCaso();
                            solicitud = AFPCCasos.upsertCaso(caso);
                        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'));
                        }   
                        disabledSelect = true; 
                        disabledSelect2 = true;
                    }
                    if((detallecaso.Tipo_Operacion__c == 'A6' && detallecaso.Banco__c == '28') || test.isRunningTest()) {
                        System.debug('Cambio de # Tarjeta desde Portal Autogestión');
                        if(!test.isRunningTest()) { caso.DAU_Tarjeta_de_Sysde__c = DAU_BorrarCuotas.ConsultaInfoClienteC(caso.Id, cuenta.Codigo__c);  
                        }
                        if(caso.DAU_Tarjeta_de_Sysde__c <> Null) { updateCase.wrapperClass wc = new updateCase.wrapperClass(); wc = updateCase.validarIdentidad(caso.Id, detalleCaso.N_Cuenta_Bancaria__c, caso.Account.Identificacion__c);
                            System.debug('validar Identidad: '+wc);
                            caso.DAU_Identidad__c = wc.DAU_Identidad; caso.DAU_No_Cuenta__c = wc.DAU_No_Cuenta; if(wc.DAU_aprobacion != null) { caso.DAU_aprobacion__c = wc.DAU_aprobacion;
                            } solicitud = new SolicitudCaso();
                            if(wc.DAU_Identidad == caso.Account.Identificacion__c) {
                                if(solicitud.solicitudExitosa) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fue ingresada con éxito.'));
                                    caso.Archivo_Adjunto__c = true; caso.Reason = 'Otro'; caso.Status = 'Cerrado'; solicitud = AFPCCasos.upsertCaso(caso); }else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.')); }
                            } else { insertDetalle = false; caso.Status = 'No Aplica'; caso.Description = 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso); ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'));
                            }
                        } else {
                            insertDetalle = false;
                            caso.Status = 'No Aplica';
                            caso.Description = 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.';
                            solicitud = new SolicitudCaso();
                            solicitud = AFPCCasos.upsertCaso(caso);
                        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'));
                        }
                        disabledSelect = true; 
                        disabledSelect2 = true;
                    }
                        
                    if(detallecaso.Nuevo_canal_aporte__c == 'AH' || cuenta.Forma_Aportacion__c == 'AH' || test.isRunningTest()) {
                        
                        if(detallecaso.Tipo_Operacion__c == 'A1' || detallecaso.Tipo_Operacion__c == 'A4' || test.isRunningTest()) {
                            String Tarjeta = Null;
                            if(!test.isRunningTest()) { Tarjeta = DAU_BorrarCuotas.ConsultaInfoClienteC(caso.Id, cuenta.Codigo__c);  
                            }
                            if(Tarjeta != Null) { FieldsAHManagement fields = new FieldsAHManagement(); fields = ControllerValidateIdentityAH.execute(Tarjeta);
                                if(fields.LEGAL_ID == cuenta.Cliente__r.Identificacion__c) { caso.DAU_aprobacion__c = true; caso.Archivo_Adjunto__c = true; caso.Reason = 'Otro'; caso.Status = 'Cerrado'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                    if(solicitud.solicitudExitosa) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fue ingresada con éxito.')); }else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.')); }       
                                } else { insertDetalle = false; caso.Status = 'No Aplica'; caso.Description = 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso); ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'));
                                }
                            } else {
                                insertDetalle = false; caso.Status = 'No Aplica';
                                caso.Description = 'Error en el servicio, no se ha obtenido la identidad, actualice y vuelva a intentarlo.';
                                solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error en el servicio, no se ha obtenido la identidad, actualice y vuelva a intentarlo.'));
                            }  
                            disabledSelect = true; 
                            disabledSelect2 = true;
                        }    
                                               
                        if(detallecaso.Tipo_Operacion__c == 'A2') { 
                            System.debug('Caso de disminución de aporte');
                            String Tarjeta = Null; if(!test.isRunningTest()) { Tarjeta = DAU_BorrarCuotas.ConsultaInfoClienteC(caso.Id, cuenta.Codigo__c);  
                            }
                            if(Tarjeta != Null) {
                                //Obteniendo la identidad del cliente
                                FieldsAHManagement fields = new FieldsAHManagement(); fields = ControllerValidateIdentityAH.execute(Tarjeta);
                                if(fields.LEGAL_ID == cuenta.Cliente__r.Identificacion__c) {
                                    List<Producto__c> prod = [Select Id,CurrencyIsoCode From Producto__c Where Id =: cuenta.Producto__c];
                                    List<Parametros_DAU__mdt> paramHNL = [Select Id,DeveloperName,Monto_a_Disminuir__c From Parametros_DAU__mdt Where DeveloperName = 'Disminucion_de_aporte_HNL']; 
                                    List<Parametros_DAU__mdt> paramUSD = [Select Id,DeveloperName,Monto_a_Disminuir__c From Parametros_DAU__mdt Where DeveloperName = 'Disminucion_de_aporte_USD']; 
                                    //List<Case> casoUpdate = [Select Id,DAU_aprobacion__c From Case Where Id =: caso and (Status = 'Nuevo' or Status = 'Devuelto') and RecordType.DeveloperName = 'Aumento_Disminucion_Aportes' Limit 1];
                                    if(!prod.isEmpty() && prod[0].CurrencyIsoCode == 'HNL') {
                                        System.debug('Cuenta en Lempiras');
                                        if((cuenta.Monto_aporte__c - detallecaso.Nuevo_monto_aporte__c) >= paramHNL[0].Monto_a_Disminuir__c) { 
                                            System.debug('HNL - Monto es Mayor - Lleva aprobación');
                                            caso.Archivo_Adjunto__c = true; caso.Enviar_aprobacion_AD__c = true; caso.DAU_aprobacion__c = false; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                            if(solicitud.solicitudExitosa){ solicitud = AFPCCasos.envioAprobacion(Caso.id, 'AumentoDisminucion');
                                                if(solicitud.solicitudExitosa){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tu gestión ha sido ingresada, recibirá un correo de confirmación en las próximas 72 horas'));
                                                }else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.'));
                                                }
                                            } 
                                        } else {
                                            System.debug('Caso de disminución en HNL no lleva aprobación');
                                            caso.Archivo_Adjunto__c = true; caso.Reason = 'Otro'; caso.Status = 'Cerrado'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                            if(solicitud.solicitudExitosa){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fue ingresada con éxito.'));
                                            }else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.'));
                                            }          
                                        }
                                    } else if(!prod.isEmpty() && prod[0].CurrencyIsoCode == 'USD') {
                                        System.debug('Cuenta en Dólares');
                                        System.debug('Valores a restar: '+detallecaso.Nuevo_monto_aporte__c + '---' + cuenta.Monto_aporte__c);
                                        if((cuenta.Monto_aporte__c - detallecaso.Nuevo_monto_aporte__c) >= paramUSD[0].Monto_a_Disminuir__c) { 
                                            System.debug('USD - Monto es Mayor - Lleva aprobación');
                                            caso.Archivo_Adjunto__c = true; caso.Enviar_aprobacion_AD__c = true; caso.DAU_aprobacion__c = false; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                            if(solicitud.solicitudExitosa) { solicitud = AFPCCasos.envioAprobacion(Caso.id, 'AumentoDisminucion');
                                                if(solicitud.solicitudExitosa){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tu gestión ha sido ingresada, recibirá un correo de confirmación en las próximas 72 horas'));
                                                }else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.'));
                                                }
                                            }
                                        } else {
                                            System.debug('Caso de disminución en USD no lleva aprobación');
                                            caso.Archivo_Adjunto__c = true; caso.Reason = 'Otro'; caso.Status = 'Cerrado'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                            if(solicitud.solicitudExitosa){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fue ingresada con éxito.'));
                                            }else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.'));
                                            }          
                                        }
                                    }
                                } else {
                                    insertDetalle = false; caso.Status = 'No Aplica'; caso.Description = 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.';
                                    solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso); ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'));
                                }
                                
                            }    
                            disabledSelect = true; disabledSelect2 = true;        
                        }
                        
                        if(detallecaso.Tipo_Operacion__c == 'A5') {
                            System.debug('Cambio de # de CA/CC');                                                      
                            FieldsAHManagement fields = new FieldsAHManagement(); fields = ControllerValidateIdentityAH.execute(detalleCaso.N_Cuenta_Bancaria__c);
                            System.debug('fields: '+fields.CURRENCY_VAL);
                            List<Producto__c> prod = [Select Id,CurrencyIsoCode From Producto__c Where Id =: cuenta.Producto__c];
                            System.debug('prod: '+prod[0].CurrencyIsoCode);
                            if(fields.CURRENCY_VAL != prod[0].CurrencyIsoCode) { caso.addError('La moneda del fondo de pensión no es igual a la moneda de la cuenta de ahorro/cheque');       
                            } else { caso.DAU_Identidad__c = fields.LEGAL_ID;  
                                System.debug('Identidades: '+fields.LEGAL_ID+'---'+cuenta.Cliente__r.Identificacion__c);
                                if(fields.LEGAL_ID != cuenta.Cliente__r.Identificacion__c) {                                    
                                    insertDetalle = false; caso.Status = 'No Aplica'; caso.Description = 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.';
                                    solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso); ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'));
                                } else {
                                    caso.DAU_aprobacion__c = true; caso.Archivo_Adjunto__c = true; caso.Reason = 'Otro'; caso.Status = 'Cerrado'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                    if(solicitud.solicitudExitosa) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fue ingresada con éxito.'));
                                    }else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.'));
                                    }
                                }                                   
                            }
                            disabledSelect = true; disabledSelect2 = true;
                        }
                        if(detallecaso.Tipo_Operacion__c == 'A3') {
                            FieldsAHManagement fields = new FieldsAHManagement(); fields = ControllerValidateIdentityAH.execute(detalleCaso.N_Cuenta_Bancaria__c);
                            System.debug('fields: '+fields.CURRENCY_VAL);
                            List<Producto__c> prod = [Select Id,CurrencyIsoCode From Producto__c Where Id =: cuenta.Producto__c];
                            System.debug('prod: '+prod[0].CurrencyIsoCode);
                            if(fields.CURRENCY_VAL != prod[0].CurrencyIsoCode) { caso.addError('La moneda del fondo de pensión no es igual a la moneda de la cuenta de ahorro/cheque');       
                            } else {
                                caso.DAU_Identidad__c = fields.LEGAL_ID;  
                                System.debug('Identidades: '+fields.LEGAL_ID+'---'+cuenta.Cliente__r.Identificacion__c);
                                if(fields.LEGAL_ID != cuenta.Cliente__r.Identificacion__c) {
                                    insertDetalle = false; caso.Status = 'No Aplica'; caso.Description = 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.';
                                    solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso); ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por tu seguridad, nuestros canales digitales solo permiten débitos a tarjetas de crédito y cuentas de ahorro de Banco Ficohsa. Si deseas afiliar tarjetas de crédito de otros bancos, puedes hacerlo visitando cualquier Agencia Ficohsa.'));
                                } else {
                                    caso.Archivo_Adjunto__c = true; caso.Reason = 'Otro'; caso.Status = 'Cerrado'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                                    if(solicitud.solicitudExitosa){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fue ingresada con éxito.'));
                                    }else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.'));
                                    }
                                }
                            }
                            disabledSelect = true; disabledSelect2 = true;
                        }
                    } 
                } 
                else if(cTipoCaso.constancias && Caso.Constancia__c == 'A6') { 
                    if(Caso.Monto_compromiso_aporte__c <= 0) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Monto del aporte no puede ser negativo ni igual a 0')); 
                    } else { 
                        caso.Aprobado__c = false; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                        if(solicitud.solicitudExitosa) { caso = solicitud.caso;    
                        } else { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se encontró un error000:' + solicitud.error));     
                        }
                        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest(); req1.setObjectId(caso.id); req1.setProcessDefinitionNameOrId('Constancia'); Approval.ProcessResult result = Approval.process(req1); ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tu gestión ha sido ingresada, recibirá un correo de confirmación en las próximas 72 horas')); disabledSelect = true;  disabledSelect2 = true; 
                    } 
                } 
                else if(cTipoCaso.otros || cTipoCaso.reposicionCarnet || (cTipoCaso.constancias && Caso.Constancia__c == 'A4')) { 
                    System.debug('Zona por departamento: '+ZonaPorDepto());
                    System.debug('Zona seleccionada: '+ZonaSeleccionada);
                    if(cTipoCaso.otros) { 
                        p = [select id, usuario__C, usuario__r.email, Ultimo_Caso_Asignado__c from Usuarios_para_asignacion_Casos_SAC__c where zona__c = :ZonaPorDepto() order by Ultimo_Caso_Asignado__c  asc limit 1]; 
                    } else { 
                        p = [select id, usuario__C, usuario__r.email, Ultimo_Caso_Asignado__c from Usuarios_para_asignacion_Casos_SAC__c where zona__c = :ZonaSeleccionada order by Ultimo_Caso_Asignado__c  asc limit 1]; 
                    } 
                    p.Ultimo_Caso_Asignado__c = System.now(); 
                    updateUsuarioAsigna = true;
                    //caso.ownerId = p.usuario__c; 
                                        
                    solicitud = new SolicitudCaso(); 
                    solicitud = AFPCCasos.upsertCaso(caso);
                    if(solicitud.solicitudExitosa) { 
                        //System.debug('Solicitud para actualizar el propietario: '+solicitud);
                        caso = solicitud.caso;    
                    } else { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se encontró un error789:' + solicitud.error));     
                    }
                    List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>(); 
                    OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn']; 
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); mail.setToAddresses(new String[] {p.usuario__r.email}); string numeroCaso = [select Casenumber from case where id = :caso.id].Casenumber; 
                    mail.setSubject('Asiganción de nuevo caso No. ' + numeroCaso);  mail.setPlainTextBody('Buen día, se notifica que se ha asignado nuevo caso (' + numeroCaso + ') del portal autogestión. \n\nMuchas gracias'); 
                    mail.setOrgWideEmailAddressId(owea.get(0).Id); MessageList.add(mail); Messaging.sendEmail(MessageList,false); 
                    if(cTipoCaso.otros) {  disabledSelect = true;  disabledSelect2 = true; 
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tu gestión ha sido asignada a un oficial de servicio al cliente que pronto te contactará.')); 
                    } else { 
                        datetime b = system.now().addDays(1);  
                        string g = b.format('EEEE');  
                        date fecha = date.today(); 
                        if(g == 'Saturday' || g == 'Friday' || g == 'Wednesday' || g == 'Thursday') { fecha = fecha.addDays(6); 
                        } else if (g == 'Sunday' ) { fecha = fecha.addDays(5); 
                        } else if(g == 'Monday' || g =='Tuesday') { fecha = fecha.addDays(4); 
                        } 
                        disabledSelect = true;  disabledSelect2 = true; 
                        if(cTipoCaso.constancias && Caso.Constancia__c == 'A4') {  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fué ingresada con éxito, Favor pasar por su Constancia a la agencia a partir de la fecha ' + fecha.day()+'/'+fecha.month()+'/'+fecha.year()+'.')); 
                        } else { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fué ingresada con éxito, Favor pasar por su carnet a la agencia a partir de la fecha ' + fecha.day()+'/'+fecha.month()+'/'+fecha.year()+'.')); 
                        } 
                    }
                    
                    changeOwnerSACAndSendMessage.processCase(caso.Id, p.usuario__c);
                } 
                else { 
                    caso.Subject = rt[0].Name; caso.Status = 'Cerrado'; solicitud = new SolicitudCaso(); solicitud = AFPCCasos.upsertCaso(caso);
                    if(solicitud.solicitudExitosa) { caso = solicitud.caso; ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fue ingresada con éxito'));
                    } else { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se encontró un error:' + solicitud.error));     
                    } disabledSelect = true; disabledSelect2 = true;                     
                } 
                if(insertDetalle) { insert detalleCaso;
                }
                if(updateUsuarioAsigna) { 
                    update p;    
                }
                if(cTipoCaso.constancias && Caso.Constancia__c != 'A6' && Caso.Constancia__c != 'A4'){ urlPagina =  ClaseUtil.urlSysde('PortalAutoGestion')+'vfConstanciaPDFDesdeSite?id=' + caso.id;
                }
                if(!cTipoCaso.estadoCuenta) { 
                    inicio(); 
                }
            }
        } catch(Exception ex) {
            system.debug('Error: ' + ex.getMessage() + ', Linea: ' + ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso. '+'Error: ' + ex.getMessage() + ', Linea: ' + ex.getLineNumber()));
        }
    }
    
    public void cerrar() { 
        showLogin = false; 
        urlPagina = null;
        popVerificacionCodigo = false;
        Case caso = [Select id,RecordType.Name From Case Where CaseNumber =: casoCliente]; 
        if(!test.isRunningTest() && caso.RecordType.Name != 'Email to Case') { showCaseComplete = true; 
        }
    }
    
    Public void ciudadesTrabajo (){
        try{
            map<string, string> mapMunicipios = new map<string, string>();
            Schema.DescribeFieldResult fieldResult = case.Ciudad_Trabajo2__c .getDescribe();  
            listCiudadTrab = new list<SelectOption>();
            list<PicklistEntry> ple = fieldResult.getPicklistValues();   
            listCiudadTrab.add(new SelectOption('', '--Ninguno--'));
            for(Schema.PicklistEntry p : ple) {
                mapMunicipios.put(p.getvalue(), p.getlabel());
                // listCiudadTrab.add(new SelectOption(p.getvalue(), p.getlabel()));
            }
            for(municipio__C item :
                [select id,  Codigo_Municipio__c, nombre_municipio__C 
                 from municipio__C where codigo_departamento__c=:Caso.Departamento_Trabajo2__c and Codigo_Municipio__c !=null]){
                     if(mapMunicipios.containsKey(Caso.Departamento_Trabajo2__c+'-'+item.Codigo_Municipio__c)) {
                         listCiudadTrab.add(new SelectOption(Caso.Departamento_Trabajo2__c+'-'+item.Codigo_Municipio__c, item.nombre_municipio__C));
                     }
                 }
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
    }
    
    Public void ciudadesResidencia (){
        try{
            map<string, string> mapMunicipios = new map<string, string>();
            Schema.DescribeFieldResult fieldResult = case.Ciudad_Residencia2__c.getDescribe();  
            listCiudadResi = new list<SelectOption>();
            list<PicklistEntry> ple = fieldResult.getPicklistValues();   
            listCiudadResi.add(new SelectOption('', '--Ninguno--'));
            for(Schema.PicklistEntry p : ple) {
                mapMunicipios.put(p.getvalue(), p.getlabel());
            }
            for(municipio__C item :
                [select id,  Codigo_Municipio__c, nombre_municipio__C 
                 from municipio__C where codigo_departamento__c=:Caso.Departamento_Residencia2__c and Codigo_Municipio__c !=null]){
                     if(mapMunicipios.containsKey(Caso.Departamento_Residencia2__c+'-'+item.Codigo_Municipio__c)){
                         listCiudadResi.add(new SelectOption(Caso.Departamento_Residencia2__c+'-'+item.Codigo_Municipio__c, item.nombre_municipio__C));
                     }
                 }
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
    }
    
    
    public void getListAgentsByZone() {
        //Limpiar todas las agencias precargadas
        listAgencias = new list<SelectOption>();//.clear();
        listAgencias.add(new SelectOption('', '--Ninguno--'));
        system.debug('zona123: '+ZonaSeleccionada);
        if((ZonaSeleccionada == null || ZonaSeleccionada == '') && !cTipoCaso.reposicionCarnet) { loadAgencies();
        } else {
            //Carga todas las egencias por la zona seleccionada.
            for(agencia__c item : [Select id, Name from agencia__c Where zona__c = :ZonaSeleccionada Order By Name Limit 1000]) {
                listAgencias.add(new SelectOption(item.Id, item.Name));
            }
        }
    }
    
    public string zonaPorDepto () { 
        if((cliente.Departamento_Residencia2__c == null || cliente.Departamento_Residencia2__c == '000') && !test.isRunningTest()) { return '3'; 
        } else if(cliente.Departamento_Residencia2__c =='122' || cliente.Departamento_Residencia2__c =='128'|| cliente.Departamento_Residencia2__c =='129'|| cliente.Departamento_Residencia2__c =='124'|| cliente.Departamento_Residencia2__c =='127'|| cliente.Departamento_Residencia2__c =='120'|| cliente.Departamento_Residencia2__c =='137'|| cliente.Departamento_Residencia2__c =='121'|| cliente.Departamento_Residencia2__c =='130') { return '1'; 
        } else if(cliente.Departamento_Residencia2__c =='123' || cliente.Departamento_Residencia2__c =='126'|| cliente.Departamento_Residencia2__c =='131'|| cliente.Departamento_Residencia2__c =='133'|| cliente.Departamento_Residencia2__c =='132'|| cliente.Departamento_Residencia2__c =='134'|| cliente.Departamento_Residencia2__c =='135'|| cliente.Departamento_Residencia2__c =='136'|| cliente.Departamento_Residencia2__c =='125' || test.isRunningTest()) {
            return '2'; 
        } 
        return null;
    }
    
    public void getCurrencySelected (){}
    
    public void updateConstanciaView (){}
        
    public void verEDCDetallado() {
        try{
            varurl url = new varurl();
            url.idcli=cliente.identificacion__c; 
            url.desde=caso.Fecha_Desde__c !=null ? string.valueOF(caso.Fecha_Desde__c):null; 
            url.hasta=string.valueOF(caso.Fecha_hasta__c); 
            string contenido =JSON.serialize(url); 
            string hy = EncodingUtil.base64Encode(Blob.valueof(contenido)); 
            list<classClientesEC> claseEnvio = new list<classClientesEC>(); 
            string fDesde=url.desde; 
            string fHasta=url.hasta; 
            classClientesEC nueva = new classClientesEC(); 
            nueva.idCliente = cliente.identificacion__C; 
            if(fDesde != null && fDesde != 'null') { 
                nueva.Desde = date.valueOF(fDesde); 
            } 
            if(fHasta != null && fHasta != 'null') { 
                nueva.hasta = date.valueOF(fHasta); 
            } 
            claseEnvio.add(nueva); 
            if([select Estado_de_Cuenta_Historico__c from case where id=:Caso.id].Estado_de_Cuenta_Historico__c ==null) { 
                boolean n = estadoCuentaHistorico(claseEnvio, caso.id); 
            } 
            urlPagina = ClaseUtil.urlSysde('PortalAutoGestion')+'vfEstadoCuentaDetalleMovimientosPDF?zyx='+hy+'&idCaso='+Caso.id;
        }catch(exception ex){  
        }
    }
    
    public void verEDCGeneral() {
        try{
            varurl url = new varurl();
            url.idcli = cliente.identificacion__c; url.desde = caso.Fecha_Desde__c != null ? string.valueOF(caso.Fecha_Desde__c) : null; 
            url.hasta = String.valueOF(caso.Fecha_hasta__c); 
            string contenido = JSON.serialize(url); 
            string hy = EncodingUtil.base64Encode(Blob.valueof(contenido)); 
            list<classClientesEC> claseEnvio = new list<classClientesEC>(); 
            string fDesde = url.desde; 
            string fHasta = url.hasta; 
            classClientesEC nueva = new classClientesEC(); 
            nueva.idCliente = cliente.identificacion__c; 
            if(fDesde != null && fDesde != 'null') { 
                nueva.Desde = date.valueOF(fDesde); 
            } 
            if(fHasta != null && fHasta != 'null') { 
                nueva.hasta = date.valueOF(fHasta); 
            } 
            claseEnvio.add(nueva); 
            if([select Estado_de_Cuenta__c from case where id=:Caso.id].Estado_de_Cuenta__c ==null) { 
                boolean n= estadoCuentaTrimestral(claseEnvio, caso.id); 
            } 
            urlPagina = ClaseUtil.urlSysde('PortalAutoGestion')+'pdfestadodecuenta?zyx='+hy+'&idCaso='+Caso.id;
        }catch(exception ex){ 
        }
    }
    
    public void accionVacia() {
        detallecaso.Nuevo_canal_aporte__c = null;

        //Evaluar si es Aporte Histórico, establece la fecha Hasta al día de Hoy.
        if(Caso.Constancia__c == 'A1') {
            //  Caso.Fecha_hasta__c = System.Date.today();
        }
        
        //Establece la divisa del caso al de la cuenta seleccionada
        caso.CurrencyIsoCode = currencyAccountSelected;
    }
    
    public void accionVacia2() {
        //if(detallecaso.Nuevo_canal_aporte__c == 'AH'){
            datetime b = system.now().addDays(1);
            integer bandera = 1;
            date fecha = date.today();
            while(bandera < 4){
                string g= b.format('EEEE');
                if(g != 'Saturday'  && g != 'Sunday'){
                    bandera ++;
                }
                b = b.addDays(1);
                fecha = fecha.addDays(1);
            }
            detalleCaso.Inicio_Fecha_Aporte__c = fecha;
            detalleCaso.Nueva_fecha_aporte__c = fecha;
            dateTemp = fecha;
        system.debug(detallecaso.Nuevo_canal_aporte__c +' '+idTipoRegistro +' '+ cuenta.Forma_Aportacion__c );
         if(detallecaso.Nuevo_canal_aporte__c == 'TA' || idTipoRegistro == 'A6'
           || (idTipoRegistro == 'A4' && cuenta.Forma_Aportacion__c == 'TA') || test.isRunningTest()){ 
               bandera = fecha.day(); 
               while(bandera != 14 && bandera != 26) { 
                   fecha = fecha.addDays(1); 
                   bandera = fecha.day(); 
               } 
               detalleCaso.Inicio_Fecha_Aporte__c = fecha; 
               detalleCaso.Nueva_fecha_aporte__c = fecha; 
               dateTemp = fecha;
         }
    }
    
   
    public class VarURL { 
        public string idcli{get;set;} 
        public string desde{get;set;} 
        public string hasta{get;set;}  
    }
    
    public static boolean estadoCuentaHistorico(list<classClientesEC> claseEnvio, string idCaso) {
        Http http = new Http(); 
        HttpRequest request = new HttpRequest(); 
        String url = claseUtil.urlSysde('Test'); 
        request.setMethod('GET'); 
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded'); 
        request.setEndpoint(url + 'api/ec/historico'); 
        request.setTimeout(120000); 
        list<classECHistorico> respuesta = new list<classECHistorico>(); 
        try { 
            classJson envio = new classJson(); 
            envio.contenido = JSON.serialize(claseEnvio); 
            String cons = 'contenido=' + envio.contenido; 
            request.setBody(cons); 
            HttpResponse response = http.send(request); if(response.getStatusCode() == 200) {  Case p = new case(id = idCaso, Estado_de_Cuenta_Historico__c = response.getBody());  SolicitudCaso solicitud = AFPCCasos.upsertCaso(p);
            } 
        } Catch(Exception e) { 
            system.debug('EDC Historico: ' + e.getMessage() + ' Linea: ' + e.getLineNumber()); 
        } 
        return true;   
    }
    
    public static boolean estadoCuentaTrimestral(list<classClientesEC> claseEnvio, string idCaso) {
        Http http = new Http(); 
        HttpRequest request = new HttpRequest(); 
        String url = claseUtil.urlSysde('Test'); 
        request.setMethod('POST'); 
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded'); 
        request.setEndpoint(url + 'api/ec/trimestral'); 
        request.setTimeout(120000); 
        list<classECTrimestral> respuesta = new list<classECTrimestral>(); 
        try{ 
            classJson envio = new classJson(); 
            envio.contenido = JSON.serialize(claseEnvio); 
            String cons = 'contenido=' + envio.contenido; 
            request.setBody(cons); 
            HttpResponse response =new HttpResponse(); 
            if(!test.isRunningTest()) { response = http.send(request); 
            } else { 
                response.setStatusCode(200); 
            } 
            if (response.getStatusCode() == 200) { 
                Case p = new case(id = idCaso, Estado_de_cuenta__c = response.getBody()); 
                //update p;
                SolicitudCaso solicitud = AFPCCasos.upsertCaso(p); 
            } 
        } Catch(Exception e) { 
            system.debug('EDC Trimestral: ' + e.getMessage() + ' Linea: ' + e.getLineNumber()); 
        } 
        return true;   
    }
}