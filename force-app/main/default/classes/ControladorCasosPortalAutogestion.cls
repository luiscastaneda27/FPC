public without sharing class ControladorCasosPortalAutogestion{
    
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
    
    public Boolean popVerificacionCodigo { get; set; }
    
    SolicitudCaso solicitud;
    
    public Date dateTemp {
        public set;
        get {
            if(this.dateTemp == Null)
                this.dateTemp = Date.Today().addDays(3);
            
            return this.dateTemp;
        }
    }
    
    public String UrlHost {
        get {
            //Si esta vacío, es un entorno distinto a un site
            if(this.UrlHost == Null || this.UrlHost == '')  {
                this.UrlHost = 'https://' + ApexPages.currentPage().getHeaders().get('Host') + ApexPages.currentPage().getUrl();
            }
            
            return this.UrlHost;
        }
        set;
    }
    
    public controladorCasosPortalAutogestion() {
        try {
            idCliente =  ApexPages.currentPage().getParameters().get('idCliente');
            system.debug('Parametro Recibido: '+idCLiente);
            //idCliente = '0801198801163'; 
            idCliente='0709199300155';
            contrato = new Contrato_Aceptado__c();
            
            //Si el entorno actual es un site, se obtiene el url del site como tal.
            if(Site.getBaseUrl() != Null || Site.getBaseUrl() != '') {
                this.UrlHost = Site.getBaseUrl();
            }
            
            cliente = new account();
            cliente = [select id, Name, Acepto_Condiciones_de_Portal_Autogestion__C,identificacion__C,
                       Departamento_Residencia2__c,PersonContactId
                       from account where identificacion__C =:idCliente limit 1];
            
            contrato.Cliente__c = cliente.id;
            contrato.Acepto_Condiciones_de_Portal_Autogestion__C = true;
            mostrarCntrato = true;
            if([select count() from Contrato_Aceptado__c where Cliente__c = :cliente.id]>0){
                mostrarCntrato = false;
            }
            Inicio();
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'Navegadores recomendados Google Chrome y Firefox Mozilla'));
        } catch(Exception ex) {
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Lo sentimos pero se ha producido un error inesperado'));
            
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
            listTipoCaso.add(new SelectOption('--', '--Ninguno--'));
            listAgencias.add(new SelectOption('', '--Ninguno--'));
            listaZonas.add(new SelectOption('', '--Ninguno--'));
            listTipoOperacion = new list<selectOption>();
            //listTipoOperacion.add(new SelectOption('', '--Ninguno--'));
            listTipoOperacion.add(new SelectOption('A1', 'Aumento de Aporte')); 
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
                                  where cliente__c = :cliente.id ]) {
                                      etiquetaCuenta = item.Codigo__c + (item.Producto__r.Name != null ? (' - ' + item.Producto__r.Name) : '') + (item.Detalle_Cuenta_colectiva__c.trim() != '-' ? (' - ' + item.Detalle_Cuenta_colectiva__c) : '');
                                      listCuentas.add(new SelectOption(item.id, etiquetaCuenta));
                                  }
            if(listCuentas.size() == 2) {
                idCuenta = listCuentas[1].getvalue();
                CargarTipoGestion();
            }
            ZonaSeleccionada ='';
            popVerificacionCodigo = false;
            system.debug('Constructor corrio con exito');
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
    
    public void cargarTipoGestion() {
        try {
            //System.debug('bajo: ' + idCuenta);
            cTipoCaso = new claseTipoCaso('Nada');
            if(idCuenta != '--') {
                listTipoCaso = new list<selectOption>();
                listTipoCaso.add(new SelectOption('--', '--Ninguno--'));
                idTipoRegistro = '--';
                //boolean esColectiva = false;
                Cuenta = new cuentas__C();
                cuenta = [Select Colectiva__c, CurrencyIsoCode, cuenta_colectiva2__C, Monto_aporte__c,
                          Forma_Aportacion__c, Tipo_Fondo__c 
                          from cuentas__c where id = :idCuenta];
                //Obtener la moneda de configurada a la cuenta.
                currencyAccountSelected = cuenta.CurrencyIsoCode;
                
                //Establece la divisa del caso al de la cuenta seleccionada
                caso.CurrencyIsoCode = cuenta.CurrencyIsoCode;
                
                
                
                //boolean esColectiva = [Select Colectiva__c, CurrencyIsoCode from cuentas__c where id = :idCuenta].Colectiva__c;
                for(RecordType item : [Select name, id, developerName from Recordtype where SObjecttype = 'Case' Order By name ASC]) {
                    if(item.developerName == 'Estados_Cuenta' || item.developerName == 'Constancia' ||
                       item.developerName == 'Aumento_Disminucion_Aportes' 
                       || item.developerName == 'Actualizacion_informacion'
                       || item.developerName == 'Reposicion_Carnet') {
                           if(item.developerName != 'Aumento_Disminucion_Aportes') {
                               listTipoCaso.add(new SelectOption(item.id, item.name));
                           } else if(cuenta.cuenta_colectiva2__C == null) {
                               listTipoCaso.addAll(listTipoOperacion);
                           }else if(cuenta.cuenta_colectiva2__C != null && (cuenta.Tipo_Fondo__c == 'P' || cuenta.Tipo_Fondo__c == 'N' )) {
                               listTipoCaso.add(new SelectOption('A3', 'Cambio de Canal de Aporte'));
                           }
                       }
                }
                //Agrega el tipo d gestion al final de lista de seleccion.
                listTipoCaso.add(new SelectOption(Schema.SObjectType.Case.getRecordTypeInfosByName().get('Otros').getRecordTypeId(), 'Otros'));
            } else {
                listTipoCaso = new list<selectOption>();
                listTipoCaso.add(new SelectOption('--', '--Ninguno--'));
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
                    Registro = [select Developername from RecordType where id=:idTipoRegistro];
                } else {
                    Registro = [select Developername from RecordType where Developername = :'Aumento_Disminucion_Aportes'];
                }
                
                cTipoCaso = new claseTipoCaso(Registro.DeveloperName);
                if(cTipoCaso.actInformacion || cTipoCaso.constancias
                   || cTipoCaso.estadoCuenta || cTipoCaso.aumDisAporte
                   ||CTipoCaso.otros || ctipoCaso.reposicionCarnet) {
                       Caso.Status = 'Nuevo';
                       Caso.type = 'Solicitud de Gestión';
                       Caso.Origin = 'Web';
                       Caso.Priority = 'Media';
                       if(cTipoCaso.estadoCuenta) { caso.Tipo_Estado_Cuenta__c = 'A1'; caso.Estado_Cuenta_Detallado__c = 'General'; }
                       if(idTipoRegistro.length() == 2) { detallecaso.Tipo_Operacion__c = idTipoRegistro; }
                   }
                if(idTipoRegistro == 'A4' || idTipoRegistro == 'A5' || idTipoRegistro == 'A6'){
                    AccionVacia2();
                }
            }
        } catch(Exception ex) {
            system.debug('Error: ' + ex.getMessage()+'Linea: '+ex.getLineNumber());
        } 
    }
    public Boolean validacionTelefono(String phone){
        if(phone == null || (phone != null && phone.trim().length() == 9)){
            return true;
        }
        return false;
    }
    public String codigoVeficacion{get;set;}
    public String inputCodigoVeficacion{get;set;}
    
    public void reenviarCodigo(){
        enviarCorreo();
        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Código enviado nuevamente.'));
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
            //cuentas__C cuenta = new cuentas__C();
            Boolean insertDetalle = false;
            String Url;
            boolean hayError = false;
            
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
                      || (ctipoCaso.estadoCuenta && caso.Fecha_hasta__c==null)) {
                          hayError = true;
                          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por favor ingresar fechas'));
                      } else if((cTipoCaso.constancias && caso.Fecha_desde__c > caso.Fecha_hasta__c && caso.Constancia__c=='A1') ||
                                (cTipoCaso.constancias && caso.Fecha_desde__c == caso.Fecha_hasta__c && caso.Constancia__c=='A1')
                                || (ctipoCaso.estadoCuenta && caso.Fecha_desde__c!=null && caso.Fecha_desde__c > caso.Fecha_hasta__c)) {
                                    hayError = true;
                                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Fechas incorrectas'));
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
                if(detalleCaso.Tipo_Operacion__c =='A1' && cuenta.Monto_aporte__c !=null && (detallecaso.Nuevo_monto_aporte__c == null || detallecaso.Nuevo_monto_aporte__c <= cuenta.Monto_aporte__c )){
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'El nuevo monto de aporte debe ser mayor a '+cuenta.Monto_aporte__c)));
                    hayerror = true;
                    // system.debug('Entro maxiel');
                } else if(detallecaso.Tipo_Operacion__c=='A3' && detallecaso.Nuevo_canal_aporte__c == 'AH' && detalleCaso.Inicio_Fecha_Aporte__c < datetemp){
                    hayerror = true;
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'Fecha mínima permitida a partir de '+datetemp.format())));
                }else if(detallecaso.Tipo_Operacion__c=='A3' && detallecaso.Nuevo_canal_aporte__c == 'TA' && detalleCaso.Inicio_Fecha_Aporte__c < datetemp){
                    hayerror = true;
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'Fecha mínima permitida a partir de '+datetemp.format())));
                }else if(detallecaso.Tipo_Operacion__c=='A3' && detallecaso.Nuevo_canal_aporte__c == 'TA' && detalleCaso.Inicio_Fecha_Aporte__c.day() != 14 &&  detalleCaso.Inicio_Fecha_Aporte__c.day() != 26){
                    hayerror = true;
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'Fecha de Aporte permitida (14 ó 26) de cada mes')));
                } else if(detallecaso.Tipo_Operacion__c == 'A4' && detalleCaso.Nueva_fecha_aporte__c < datetemp){
                    hayerror = true;
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'Fecha mínima permitida a partir de '+datetemp.format())));
                }else if(detallecaso.Tipo_Operacion__c == 'A4' && cuenta.Forma_Aportacion__c=='TA' && detalleCaso.Nueva_fecha_aporte__c.day()!=Integer.ValueOf(Label.DAU_Cambio_de_Fecha_1) && detalleCaso.Nueva_fecha_aporte__c.day() !=Integer.ValueOf(Label.DAU_Cambio_de_Fecha_2)){
                    hayerror = true;
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'Fecha de Aporte permitida (' + Label.DAU_Cambio_de_Fecha_1 + ' ó ' + Label.DAU_Cambio_de_Fecha_2 + ') de cada mes')));
                }
                else if(detallecaso.Tipo_Operacion__c == 'A5' && detalleCaso.Inicio_Fecha_Aporte__c < datetemp){
                    hayerror = true;
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'Fecha mínima permitida a partir de '+datetemp.format())));
                }
                else if(detallecaso.Tipo_Operacion__c == 'A6' && detalleCaso.Inicio_Fecha_Aporte__c < datetemp){
                    hayerror = true;
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'Fecha mínima permitida a partir de '+datetemp.format())));
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
                caso.ContactId = Cliente.PersonContactId;
                
                if(idTipoRegistro.length() > 2) {
                    caso.RecordTypeId = idTipoRegistro;
                } else {
                    caso.RecordTypeId = [select id from RecordType where Developername = :'Aumento_Disminucion_Aportes'].Id;
                }
                caso.Viene_Portal_Autogestion__c = true; 
                if(cTipoCaso.constancias || test.isRunningTest()){
                    caso.Mostrar_Saldo_a_la_fecha__c=true;
                    if(cuenta.CurrencyIsoCode != caso.CurrencyIsoCode){
                        caso.Desea_ver_tasa_de_cambio__c = true;
                    }
                }
                caso.CurrencyIsoCode = caso.CurrencyIsoCode ==null ? cuenta.CurrencyIsoCode: caso.CurrencyIsoCode;
                if(!test.isRunningTest()){
                     caso.OwnerId =  Label.IdOwnerCase;
                }
                solicitud = new SolicitudCaso();
                solicitud = AFPCCasos.upsertCaso(caso);
                if(solicitud.solicitudExitosa){
                    caso = solicitud.caso;
                }else{
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso. '+solicitud.error));
                    return;
                }
                System.debug('Se ingreso el caso ' + caso.Id);
                
                if(cTipoCaso.constancias) {
                    detallecaso.Caso__c = caso.id;
                    detalleCaso.Cuenta__c = idCuenta;
                    detalleCaso.CurrencyIsoCode = caso.CurrencyIsoCode;
                    insertDetalle = true;
                    
                }
                else if(cTipoCaso.aumDisAporte) {
                    detallecaso.Caso__c = caso.id;
                    detalleCaso.Cuenta__c = idCuenta;
                    detalleCaso.CurrencyIsoCode = caso.CurrencyIsoCode;
                    insertDetalle = true;
                }
                // system.debug('Antes de meterse: '+ cuenta.Forma_Aportacion__c);
                if(cTipoCaso.aumDisAporte  && (cuenta.Forma_Aportacion__c == 'AH' || cuenta.Forma_Aportacion__c =='CK' ||
                                               cuenta.Forma_Aportacion__c == 'TA' || detallecaso.Tipo_Operacion__c=='A3') && detallecaso.Tipo_Operacion__c <> 'A1' && detallecaso.Tipo_Operacion__c <> 'A4' && detallecaso.Tipo_Operacion__c <> 'A6') {
                                                   caso.Aprobado__c = false;
                                                   caso.Enviar_aprobacion_AD__c = true;
                                                   solicitud = new SolicitudCaso();
                                                   solicitud = AFPCCasos.upsertCaso(caso);
                                                   if(solicitud.solicitudExitosa){
                                                       solicitud = AFPCCasos.envioAprobacion(Caso.id, 'AumentoDisminucion');
                                                       if(solicitud.solicitudExitosa){
                                                           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tu gestión ha sido ingresada, recibirá un correo de confirmación en las próximas 72 horas'));
                                                       }else{
                                                           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso.'));
                                                           inicio();
                                                           return;
                                                       }
                                                   }
                                                   /*Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                                                   req1.setObjectId(caso.id);
                                                   req1.setProcessDefinitionNameOrId('AumentoDisminucion');
                                                   Approval.ProcessResult result = Approval.process(req1);
                                                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tu gestión ha sido ingresada, recibirá un correo de confirmación en las próximas 72 horas'));
                                                   */
                                               } 
                else if(cTipoCaso.otros || cTipoCaso.reposicionCarnet) {
                    Usuarios_para_asignacion_Casos_SAC__c p = new Usuarios_para_asignacion_Casos_SAC__c();
                    if(cTipoCaso.otros){
                        p = [select id, usuario__C, usuario__r.email, Ultimo_Caso_Asignado__c
                             from Usuarios_para_asignacion_Casos_SAC__c where zona__c = :ZonaPorDepto()
                             order by Ultimo_Caso_Asignado__c  asc limit 1];
                    }else{
                        p = [select id, usuario__C, usuario__r.email, Ultimo_Caso_Asignado__c
                             from Usuarios_para_asignacion_Casos_SAC__c where zona__c = :ZonaSeleccionada
                             order by Ultimo_Caso_Asignado__c  asc limit 1];
                    }
                    p.Ultimo_Caso_Asignado__c = System.now(); 
                    
                    caso.ownerId = p.usuario__c;
                    system.debug('usuario clase: '+p.usuario__c);
                    //update caso;
                    solicitud = new SolicitudCaso();
                    solicitud = AFPCCasos.upsertCaso(caso);
                    update p;
                    List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
                    OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setToAddresses(new String[] {p.usuario__r.email});
                    //mail.setToAddresses(new String[] {'luis.castaneda@intellectsystem.net'});
                    string numeroCaso = [select Casenumber from case where id = :caso.id].Casenumber;
                    // if(ctipoCaso.otros){
                    mail.setSubject('Asiganción de nuevo caso No. ' + numeroCaso);
                    mail.setPlainTextBody('Buen día, se notifica que se ha asignado nuevo caso (' + numeroCaso + ') del portal autogestión. \n\nMuchas gracias');
                    mail.setOrgWideEmailAddressId(owea.get(0).Id);
                    MessageList.add(mail); 
                    Messaging.sendEmail(MessageList,false);
                    system.debug('Correo se envio con éxito: ' + p.usuario__r.email);
                    //}
                    
                    if(cTipoCaso.otros) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Tu Gestion fue ingresada con éxito'));
                    } else {
                        datetime b = system.now().addDays(1);
                        string g = b.format('EEEE');
                        date fecha = date.today();
                        if(g == 'Saturday' || g == 'Friday' || g == 'Wednesday' || g == 'Thursday') {
                            fecha = fecha.addDays(6);
                        }else if (g == 'Sunday' ) {
                            fecha = fecha.addDays(5);
                        } else if(g == 'Monday' || g =='Tuesday') {
                            fecha = fecha.addDays(4); 
                        }
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fué ingresada con éxito, Favor pasar por su carnet a la agencia a partir de la fecha ' + fecha.day()+'/'+fecha.month()+'/'+fecha.year()+'.'));
                    }
                }else{
                    caso.Status = 'Cerrado';
                    solicitud = new SolicitudCaso();
                    solicitud = AFPCCasos.upsertCaso(caso);
                    if(solicitud.solicitudExitosa){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Su gestion fue ingresada con éxito'));
                    }else{
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso. '));
                    }
                }
                if(insertDetalle){
                    insert detalleCaso;
                }
                if(cTipoCaso.constancias){
                    urlPagina =  ClaseUtil.urlSysde('PortalAutoGestion')+'vfConstanciaPDFDesdeSite?id=' + caso.id;
                }
                if(!cTipoCaso.estadoCuenta) {
                    inicio();
                }
                
            }
        } catch(Exception ex) {
            system.debug('Error: ' + ex.getMessage() + ', Linea: ' + ex.getLineNumber());
            if(caso.id != null) {
                database.delete(caso,false);
            }
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Se ha producido un error al guardar el caso. '+'Error: ' + ex.getMessage() + ', Linea: ' + ex.getLineNumber()));
        }
    }
    
    public void cerrar() {
        urlPagina = null;
        popVerificacionCodigo = false;
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
                     if(mapMunicipios.containsKey(Caso.Departamento_Trabajo2__c+'-'+item.Codigo_Municipio__c)){
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
        if((ZonaSeleccionada == null || ZonaSeleccionada == '') && !cTipoCaso.reposicionCarnet) {
            
            loadAgencies();
        } else {
            //Carga todas las egencias por la zona seleccionada.
            for(agencia__c item : [Select id, Name from agencia__c Where zona__c = :ZonaSeleccionada Order By Name Limit 1000]) {
                listAgencias.add(new SelectOption(item.Id, item.Name));
            }
        }
    }
    
    public string zonaPorDepto () {
        if((cliente.Departamento_Residencia2__c == null ||
            cliente.Departamento_Residencia2__c == '000') && !test.isRunningTest()) {
                return '3';
            } else if(cliente.Departamento_Residencia2__c =='122' ||
                      cliente.Departamento_Residencia2__c =='128'||
                      cliente.Departamento_Residencia2__c =='129'||
                      cliente.Departamento_Residencia2__c =='124'||
                      cliente.Departamento_Residencia2__c =='127'||
                      cliente.Departamento_Residencia2__c =='120'||
                      cliente.Departamento_Residencia2__c =='137'||
                      cliente.Departamento_Residencia2__c =='121'||
                      cliente.Departamento_Residencia2__c =='130') {
                          return '1';
                      } else if(cliente.Departamento_Residencia2__c =='123' ||
                                cliente.Departamento_Residencia2__c =='126'||
                                cliente.Departamento_Residencia2__c =='131'||
                                cliente.Departamento_Residencia2__c =='133'||
                                cliente.Departamento_Residencia2__c =='132'||
                                cliente.Departamento_Residencia2__c =='134'||
                                cliente.Departamento_Residencia2__c =='135'||
                                cliente.Departamento_Residencia2__c =='136'||
                                cliente.Departamento_Residencia2__c =='125'
                                || test.isRunningTest()) {
                                    return '2';
                                }
        return null;
    }
    
    public void getCurrencySelected (){}
    
    public void updateConstanciaView (){}
    
    public void verEDCDetallado() {
        try{
            varurl url = new varurl();
            url.idcli=cliente.identificacion__C;
            url.desde=caso.Fecha_Desde__c !=null ? string.valueOF(caso.Fecha_Desde__c):null;
            url.hasta=string.valueOF(caso.Fecha_hasta__c);
            string contenido =JSON.serialize(url);
            string hy = EncodingUtil.base64Encode(Blob.valueof(contenido));
            list<classClientesEC> claseEnvio = new list<classClientesEC>();
            string fDesde=url.desde;
            string fHasta=url.hasta;
            classClientesEC nueva = new classClientesEC();
            nueva.idCliente = cliente.identificacion__C;
            if(fDesde != null && fDesde != 'null'){
                nueva.Desde = date.valueOF(fDesde);
            }
            if(fHasta != null && fHasta != 'null'){
                nueva.hasta = date.valueOF(fHasta);
            }
            
            claseEnvio.add(nueva);
            if([select Estado_de_Cuenta_Historico__c from case where id=:Caso.id].Estado_de_Cuenta_Historico__c ==null) {
                boolean n = estadoCuentaHistorico(claseEnvio, caso.id);
            }
            // urlPagina  =  '/PortalAutoGestion/vfEstadoCuentaDetalleMovimientosPDF?zyx='+hy+'&idCaso='+Caso.id;
            urlPagina  = ClaseUtil.urlSysde('PortalAutoGestion')+'vfEstadoCuentaDetalleMovimientosPDF?zyx='+hy+'&idCaso='+Caso.id;
            system.debug('Url: '+urlPagina);
        }catch(exception ex){
            
        }
    }
    
    public void verEDCGeneral() {
        try{
            varurl url = new varurl();
            url.idcli = cliente.identificacion__c;
            url.desde = caso.Fecha_Desde__c != null ? string.valueOF(caso.Fecha_Desde__c) : null;
            url.hasta = String.valueOF(caso.Fecha_hasta__c);
            string contenido = JSON.serialize(url);
            string hy = EncodingUtil.base64Encode(Blob.valueof(contenido));
            system.debug('URL: zyx=' + hy);
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
            //urlPagina =  '/PortalAutoGestion/pdfestadodecuenta?zyx='+hy+'&idCaso='+Caso.id;
            urlPagina = ClaseUtil.urlSysde('PortalAutoGestion')+'pdfestadodecuenta?zyx='+hy+'&idCaso='+Caso.id;
            system.debug('Url Pagina: ' + urlPagina);
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
           || (idTipoRegistro == 'A4' && cuenta.Forma_Aportacion__c == 'TA')){
               bandera = fecha.day();
               //fecha = date.today();
               while(bandera != 14 && bandera != 26){
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
            system.debug(cons);
            request.setBody(cons);
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                System.debug(response.getBody());
                Case p =new case(id = idCaso, Estado_de_Cuenta_Historico__c = response.getBody());
                SolicitudCaso solicitud = AFPCCasos.upsertCaso(p);
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
            system.debug('Mandamos: '+cons);                
            request.setBody(cons);
            HttpResponse response =new HttpResponse();
            if(!test.isRunningTest()) {
                response = http.send(request);
            } else {
                response.setStatusCode(200);
            }
            if (response.getStatusCode() == 200) {
                Case p = new case(id = idCaso, Estado_de_cuenta__c = response.getBody());
                SolicitudCaso solicitud = AFPCCasos.upsertCaso(p);
            }
            
        } Catch(Exception e) {
            system.debug('EDC Trimestral: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());     
        } 
        return true;   
    }
}