public class updateCase {
        
    public class wrapperClass {
       public String DAU_Identidad {get;set;}
       public String DAU_No_Cuenta {get;set;}
       public Boolean DAU_aprobacion {get;set;} 
       public String Respuesta_SF_Tarjetas {get;set;}
       public String Description {get;set;}
    }
    
    public static boolean IsAfilationAGN {get;set;}
    
	@future
    public static void processCase(List<Id> caseIds) {
    	List<Case> lstCase = [Select Id, Milestone_operaciones__c, Status, Paso_por_devolucion__c From Case Where Id in :caseIds Limit 1];
        for(Case c : lstCase) {
            if(c.Status == 'Pendiente de aprobación') { c.Milestone_operaciones__c = true;
            } else if(c.Status == 'Devuelto' && c.Paso_por_devolucion__c == False) { c.Paso_por_devolucion__c = True; 
            }    
        }
        update lstCase;
    }
    @future
    public static void processCasePortalAuto(set<Id> caseId) {
        List<Case> lstCase = [SELECT Id,Reason,Owner.Profile.Name,EntitlementId FROM Case where Id IN :caseId and Owner.Profile.Name = 'PortalAutoGestion Perfil' and EntitlementId = null];
        for(Case c : lstCase) { c.Reason = 'Otro';
        }
        update lstCase;        
    }
    //Inicio Creando caso de Cancelación de aporte por retiro total 
    @future(callout=true)
    public static void createDetail(List<Id> detail, set<Id> casoOrigen) {
        try {
            List<Case> caso = [Select Id,Status,DAU_Tarjeta_de_Sysde__c,Account.Identificacion__c,DAU_Identidad__c,DAU_No_Cuenta__c,
                               DAU_aprobacion__c From Case Where Id In: detail Limit 1];
            
            List<Detalle_caso__c> detcaso = [Select Id,Caso__c,Cuenta__c,Cuenta__r.Codigo__c,banco__c,Cuenta__r.Forma_Aportacion__c 
                                             From Detalle_caso__c Where Caso__c In: casoOrigen Limit 1]; 
            
            List<Detalle_caso__c> dcase = new List<Detalle_caso__c>();
            String banco;
            if(detcaso[0].Cuenta__r.Forma_Aportacion__c == 'TA') {
                if(detcaso[0].banco__c == '28') {
                    banco = '28';    
                } else { 
                    banco = 'Otros Bancos';
                } 
            }
            dcase.add(new Detalle_caso__c(Caso__c = caso[0].Id,Cuenta__c = detcaso[0].Cuenta__c,Accion__c = 'A2',Tipo_Operacion__c = 'A7',Tipo_saldo_modificar2__c = '10',Banco__c=banco));
            
            System.debug('Se actualiza el caso automático de Cancelación');
            if(banco == '28') { // Banco Ficohsa
                caso[0].DAU_Tarjeta_de_Sysde__c = DAU_BorrarCuotas.ConsultaInfoClienteC(caso[0].Id, detcaso[0].Cuenta__r.Codigo__c);
                caso[0].DAU_aprobacion__c = true;
                System.debug('caso[0].Id: '+caso[0].Id); 
                System.debug('DAU_Tarjeta_de_Sysde: '+caso[0].DAU_Tarjeta_de_Sysde__c);
                System.debug('caso[0].Account.Identificacion: '+caso[0].Account.Identificacion__c);     
                if(caso[0].DAU_Tarjeta_de_Sysde__c <> Null || test.isRunningTest()) {
                    FieldsBankManagement fields = new FieldsBankManagement();
                    fields.tipoGestion = 'valTC'; 
                    fields.identificacion = '';
                    fields.moneda = '';
                    fields.fechaInicio = '';
                    fields.periodicidad = '';
                    fields.cuentaBancaria = caso[0].DAU_Tarjeta_de_Sysde__c;
                    fields.diaCobro = '';
                    fields.montoDebito = '';            
                    FieldsBankManagement resultJson = ControllerBankManagement.Execute(fields); 
                    caso[0].DAU_Identidad__c = resultJson.CARD_HOLDER_LEGAL_ID;
                    caso[0].DAU_No_Cuenta__c = resultJson.ACCOUNT_NUMBER;
                }     
                if(caso[0].DAU_Identidad__c <> Null && caso[0].DAU_No_Cuenta__c <> Null) {
                    System.debug('Llamar a Salesforce Tarjeta');
                    List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                    Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = caso[0].Id, DAU_PrimerServicio__c = true));
                    // Call method to publish events
                    List<Database.SaveResult> results = EventBus.publish(Logs);
                }      
            } else if(banco == 'Otros Bancos'){
                caso[0].DAU_aprobacion__c = true;
                List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = caso[0].Id, DAU_PrimerServicio__c = true));
                // Call method to publish events
                List<Database.SaveResult> results = EventBus.publish(Logs);
                //DAU_GestionesBac.execute(caso[0].Id, '');
            }   
            if(detcaso[0].Cuenta__r.Forma_Aportacion__c == 'AH') {
                System.debug('Forma de aportación de la cuenta a la cual se le hace el retiro total es AH');  
                caso[0].DAU_aprobacion__c = true;
                List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = caso[0].Id, DAU_PrimerServicio__c = true));
                // Call method to publish events
                List<Database.SaveResult> results = EventBus.publish(Logs);
            }
            insert dcase;        
            update caso;
        } catch(Exception ex) {
            System.debug('Error: '+ex.getLineNumber()+'---'+ex.getMessage());
        }    
    }  
    //Fin Creando caso de Cancelación de aporte por retiro total 
    
    //Inicio Crear cliente, cuenta y gestión desde afiliación electrónica
    public static void createRecord(List<FieldsBankManagement> values) {
    	System.debug('values: '+values);   
        String pctipoid, pcnroid, cuenta, pcprimernombre, pcprimerapellido, pcmail, pnnrocertificado, tipoFondo, frecuencia, pcformapago, pccuentapago, diaPago, pcMes, pcAnio, pcPOS, pcTarjetaHabiente, pcTipoTarjeta, pcBanco, pcpromotor, EntitlementValue;
        Double pcMonto;
        Date pcNuevaFecha;
        for(FieldsBankManagement f : values) {
        	pctipoid = f.pctipoid;
            pcnroid = f.pcnroid;
            cuenta = f.cuenta;
            pcprimernombre = f.pcprimernombre;
            pcprimerapellido = f.pcprimerapellido;
            pcmail = f.pcmail;
            pnnrocertificado = f.pnnrocertificado;
            tipoFondo = f.tipoFondo;
            frecuencia = f.frecuencia;
            pcformapago = f.pcformapago;
            pccuentapago = f.pccuentapago;
            diaPago = f.diaPago;
            pcMes = f.pcMes;
            pcAnio = f.pcAnio;
            pcMonto = f.pcMonto;
            pcPOS = f.pcPOS;
            pcTarjetaHabiente = f.pcTarjetaHabiente; 
            pcTipoTarjeta = f.pcTipoTarjeta; 
            pcBanco = f.pcBanco;
            pcNuevaFecha = f.pcNuevaFecha;
            pcpromotor = f.pcpromotor;
            EntitlementValue = f.EntitlementValue;
        }
        System.debug('pctipoid: '+pctipoid+'--- pcnroid: '+pcnroid+'--- cuenta: '+cuenta+'--- pcprimernombre: '+pcprimernombre+'--- pcprimerapellido: '+pcprimerapellido+'--- pcmail: '+pcmail+'--- pnnrocertificado: '+pnnrocertificado+'--- tipoFondo: '+tipoFondo+'--- frecuencia: '+frecuencia+'--- pcformapago: '+pcformapago+'--- pccuentapago: '+pccuentapago+'--- diaPago: '+diaPago);
        List<Account> cuentaExiste = [Select Id,Identificacion__c From Account Where Identificacion__c =: pcnroid Limit 1];
        if(!cuentaExiste.isEmpty()) {
        	System.debug('Cuenta Existente: '+cuentaExiste[0].Id);
            Cuentas__c cuentac = new Cuentas__c(); cuentac.Name = cuenta; cuentac.Codigo__c = cuenta; cuentac.Codigo_Barra__c = pnnrocertificado; cuentac.Cliente__c = cuentaExiste[0].Id; cuentac.Activo__c = true;
            cuentac.Tipo_Fondo__c = tipoFondo; cuentac.Frecuencia_Aportacion__c = frecuencia; cuentac.Forma_Aportacion__c = pcformapago;
            //cuentac.Producto__c = pcproducto;
            //cuentac.Subproducto__c = pcsubproducto;
            insert cuentac;
            System.debug('cuentac: '+cuentac);
            updateCase.createManagementAfiliation(pcnroid, String.valueOf(cuentac.Cliente__c), String.valueOf(cuentac.Id), frecuencia, pcformapago, pccuentapago, diaPago, pcMes, pcAnio, pcMonto, pcPOS, pcTarjetaHabiente, pcTipoTarjeta, pcBanco, pcNuevaFecha, pcpromotor, EntitlementValue);   
        } else {
            System.debug('Cliente no existe');
        	Account cta = new Account();
            cta.FirstName = pcprimernombre;            
            cta.LastName = pcprimerapellido;
            cta.Tipo_Identificacion__c = pctipoid;
            cta.Identificacion__c = pcnroid;
            cta.PersonEmail = pcmail;
            cta.RecordTypeId = '012j0000000i3wAAAQ';
            //cta.OwnerId = pcpromotor;
            insert cta;
            System.debug('cta: '+cta);
            updateCase.createCuentaC(pcnroid, cta.Id, cuenta, pnnrocertificado, tipoFondo, frecuencia, pcformapago, pccuentapago, diaPago, pcMes, pcAnio, pcMonto, pcPOS, pcTarjetaHabiente, pcTipoTarjeta, pcBanco, pcNuevaFecha, pcpromotor, EntitlementValue);
        }
    }
    public static void createCuentaC(String pcnroid, String cliente, String cuenta, String pnnrocertificado, String tipoFondo, String frecuencia, String pcformapago, String pccuentapago, String diaPago, String pcMes, String pcAnio, Double pcMonto, String pcPOS, String pcTarjetaHabiente, String pcTipoTarjeta, String pcBanco, Date pcNuevaFecha, String pcpromotor, String EntitlementValue) {
    	System.debug('Nueva Cuenta: '+cuenta);
        System.debug('Nuevo cliente: '+cliente);
        Cuentas__c cuentac = new Cuentas__c();
        cuentac.Name = cuenta;
        cuentac.Codigo__c = cuenta;
        cuentac.Codigo_Barra__c = pnnrocertificado;
        cuentac.Cliente__c = cliente;
        cuentac.Activo__c = true;
        //cuentac.Producto__c = pcproducto;
        //cuentac.Subproducto__c = pcsubproducto;
        cuentac.Tipo_Fondo__c = tipoFondo;
        cuentac.Frecuencia_Aportacion__c = frecuencia;
        cuentac.Forma_Aportacion__c = pcformapago;
        insert cuentac;
        system.debug('cuentac: '+cuentac);
        updateCase.createManagementAfiliation(pcnroid, String.valueOf(cuentac.Cliente__c), String.valueOf(cuentac.Id), frecuencia, pcformapago, pccuentapago, diaPago, pcMes, pcAnio, pcMonto, pcPOS, pcTarjetaHabiente, pcTipoTarjeta, pcBanco, pcNuevaFecha, pcpromotor, EntitlementValue);    
    }
    public static void createManagementAfiliation(String pcnroid, String cliente, String cuenta, String frecuencia, String pcformapago, String pccuentapago, String diaPago, String pcMes, String pcAnio, Double pcMonto, String pcPOS, String pcTarjetaHabiente, String pcTipoTarjeta, String pcBanco, Date pcNuevaFecha, String pcpromotor, String EntitlementValue) {
    	//Crear caso de Afiliación de Débito Automático
        String RecordTypeId = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;          
        Case c = new Case();
        c.AccountId = cliente;
        c.RecordTypeId = RecordTypeId;
        c.Status = 'Nuevo'; 
        c.Type = 'Solicitud';
        c.Origin = 'Web';
        c.Priority = 'Media';
        c.Subject = 'Afiliación de Débito Automático';
        c.Reason = 'Otro';
        c.Enviar_aprobacion_AD__c = true;
        c.Aprobado__c = false;
        if(pcformapago == 'TAOB') { 
            c.Archivo_Adjunto__c = true;	    
        } else { 
        	c.Archivo_Adjunto__c = false;
        }    
        c.Viene_Portal_Autogestion__c = false;
        c.DAU_aprobacion__c = false;
        c.EntitlementId = EntitlementValue;
        Insert c;
        System.debug('Caso guardado: '+c);  
        updateCase.createDetailAfiliation(c, pcnroid, cuenta, frecuencia, pcformapago, pccuentapago, diaPago, pcMes, pcAnio, pcMonto, pcPOS, pcTarjetaHabiente, pcTipoTarjeta, pcBanco, pcNuevaFecha, pcpromotor);    
	}
    public static void createDetailAfiliation(Case caso, String pcnroid, String cuentac, String frecuencia, String pcformapago, String pccuentapago, String diaPago, String pcMes, String pcAnio, Double pcMonto, String pcPOS, String pcTarjetaHabiente, String pcTipoTarjeta, String pcBanco, Date pcNuevaFecha, String pcpromotor) {
    	SolicitudCaso solicitud = new SolicitudCaso();
        //Crear detalle de caso de Afiliación de Débito Automático
    	Detalle_caso__c detcaso = new Detalle_caso__c();
        detcaso.Caso__c = caso.Id;
        detcaso.Cuenta__c = cuentac;
        detcaso.Frecuencia__c = frecuencia;    
        detcaso.Tipo_Operacion__c = 'A8';
        detcaso.Nuevo_canal_aporte__c = pcformapago;
        detcaso.N_Cuenta_Bancaria__c = pccuentapago;
        detcaso.DAU_Dia_de_pago__c = diaPago;
        detcaso.Mes__c = pcMes;
        detcaso.Ano_tarjeta__c = pcAnio;
        detcaso.Nuevo_monto_aporte__c = pcMonto;
        detcaso.POS__c = pcPOS;
        detcaso.DAU_Tarjeta_Habiente__c = pcTarjetaHabiente;
        detcaso.DAU_Tipo_Tarjeta__c = pcTipoTarjeta;
        detcaso.Banco__c = pcBanco;
        detCaso.Nueva_fecha_aporte__c = pcNuevaFecha;
        insert detcaso;
        System.debug('detcaso: '+detcaso);
        if(pcformapago == 'TA') { 
            IsAfilationAGN = true;
            validarIdentidad2(String.valueOf(caso.Id), pccuentapago, pcnroid); 
        }    
        if(pcformapago == 'TAOB') { 
        	/*solicitud = AFPCCasos.upsertCaso(caso);
            if(solicitud.solicitudExitosa){
                solicitud = AFPCCasos.envioAprobacion(caso.id, 'AumentoDisminucion');
            }*/
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
            req1.setComments('Aprobación automática por caso desde el portal de afiliación.');
            req1.setObjectId(caso.id);
            
            // Submit on behalf of a specific submitter
            //req1.setSubmitterId(user1.Id); 
            
            // Submit the record to specific process and skip the criteria evaluation
            req1.setProcessDefinitionNameOrId('AumentoDisminucion');
            //req1.setSkipEntryCriteria(true);
            
            // Submit the approval request for the account
            Approval.ProcessResult result = Approval.process(req1);
            } 
        if(pcformapago == 'AH') {
			validarIdentidad3(String.valueOf(caso.Id), pccuentapago, pcnroid, pcpromotor); 
        }    
    }
    
    public static wrapperClass validarIdentidad(String casoId, String pccuentapago, String pcnroid) {
        
        System.debug('Se ejecuta el servicio para validar la identidad');
        wrapperClass wc = new wrapperClass();
        
        List<Case> caso = new List<Case>();
        caso = [Select Id, Status, DAU_aprobacion__c, DAU_Identidad__c, DAU_No_Cuenta__c From case where Id =: casoId /*and Status <> 'Cerrado and DAU_Identidad__c = null'*/];
        
        if(!caso.isEmpty()) {
       
            FieldsBankManagement fields = new FieldsBankManagement();
            fields.tipoGestion = 'valTC';
            fields.identificacion = '';
            fields.moneda = '';
            fields.fechaInicio = '';
            fields.periodicidad = '';
            fields.cuentaBancaria = pccuentapago;
            fields.diaCobro = '';
            fields.montoDebito = '';
            
            FieldsBankManagement resultJson = ControllerBankManagement.Execute(fields);  
            System.debug('val: '+resultJson.CARD_HOLDER_LEGAL_ID);
            System.debug('val2: '+resultJson.ACCOUNT_HOLDER_LEGAL_ID);
            System.debug('val3: '+resultJson.ACCOUNT_NUMBER);
            System.debug('val4: '+resultJson.CARD_STATUS);
                     
            if(caso[0].Status <> 'Cerrado') {
                if(resultJson.CARD_HOLDER_LEGAL_ID == Null) { 
                    System.debug('Error: No se obtuvo la identidad');
                    wc.DAU_Identidad = 'Error: No se obtuvo la identidad';
                    wc.DAU_aprobacion = false;
                } else if(resultJson.CARD_HOLDER_LEGAL_ID != resultJson.ACCOUNT_HOLDER_LEGAL_ID) {
                    System.debug('Error: CARD_HOLDER_LEGAL_ID diferente a ACCOUNT_HOLDER_LEGAL_ID');
                    wc.DAU_Identidad = resultJson.CARD_HOLDER_LEGAL_ID; 
                    wc.DAU_No_Cuenta = resultJson.ACCOUNT_NUMBER; 
                    wc.Description = 'Error: CARD_HOLDER_LEGAL_ID diferente a ACCOUNT_HOLDER_LEGAL_ID';
                    wc.DAU_aprobacion = true;  
                } else {
                    if(resultJson.CARD_STATUS == '20 - TARJETA NORMAL') {
                        if(resultJson.CARD_HOLDER_LEGAL_ID == pcnroid) {
                            System.debug('Tarjeta Normal');
                            wc.DAU_Identidad = resultJson.CARD_HOLDER_LEGAL_ID; 
                            wc.DAU_No_Cuenta = resultJson.ACCOUNT_NUMBER; 
                            wc.DAU_aprobacion = true;
                        } else {
                            System.debug('Tarjeta dada de baja');
                            wc.DAU_Identidad = resultJson.CARD_HOLDER_LEGAL_ID;  
                            wc.Description = 'Tarjeta dada de baja';
                            wc.DAU_No_Cuenta = resultJson.ACCOUNT_NUMBER;
                            wc.DAU_aprobacion = true;
                        }  
                    }    
                }    
            }
        }   
        return wc;
    } 
    //Fin Crear cliente, cuenta y gestión desde afiliación electrónica
    
    @Future(callout=true)
    public static void validarIdentidad2(String casoId, String pccuentapago, String pcnroid) {
                
        Case caso = new Case();
        caso = [Select Id, Status, Description, DAU_aprobacion__c, DAU_Identidad__c, DAU_No_Cuenta__c, 
                Respuesta_SF_Tarjetas__c, DAU_Tarjeta_de_Sysde__c From case where Id =: casoId];
        
        if(caso.Id != Null) {
            
            SolicitudCaso solicitud = new SolicitudCaso();
            
            FieldsBankManagement fields = new FieldsBankManagement();
            fields.tipoGestion = 'valTC';
            fields.identificacion = '';
            fields.moneda = '';
            fields.fechaInicio = '';
            fields.periodicidad = '';
            fields.cuentaBancaria = pccuentapago;
            fields.diaCobro = '';
            fields.montoDebito = '';
            
            FieldsBankManagement resultJson = ControllerBankManagement.Execute(fields); 
            System.debug('val: '+resultJson.CARD_HOLDER_LEGAL_ID);
            System.debug('val2: '+resultJson.ACCOUNT_HOLDER_LEGAL_ID);
            System.debug('val3: '+resultJson.ACCOUNT_NUMBER);
            System.debug('val4: '+resultJson.CARD_STATUS);
           
            if(resultJson.CARD_HOLDER_LEGAL_ID == Null) { 
                if(caso.DAU_Identidad__c == Null) {
                	caso.DAU_Identidad__c = 'Error: No se obtuvo la identidad';
                }    
                caso.DAU_aprobacion__c = false;  
                solicitud = AFPCCasos.upsertCaso(caso);
            } else if(resultJson.CARD_HOLDER_LEGAL_ID != resultJson.ACCOUNT_HOLDER_LEGAL_ID) {
                System.debug('CARD_HOLDER_LEGAL_ID diferente a ACCOUNT_HOLDER_LEGAL_ID');
                caso.DAU_Identidad__c = resultJson.CARD_HOLDER_LEGAL_ID;
                caso.DAU_No_Cuenta__c = resultJson.ACCOUNT_NUMBER;
                caso.DAU_aprobacion__c = true;  
                caso.Description = 'Error: CARD_HOLDER_LEGAL_ID diferente a ACCOUNT_HOLDER_LEGAL_ID';
                solicitud = AFPCCasos.upsertCaso(caso);               
            } else {
                if(resultJson.CARD_STATUS == '20 - TARJETA NORMAL') {
                    //if(resultJson.CARD_HOLDER_LEGAL_ID == pcnroid) {
                    System.debug('Tarjeta Normal');
                    caso.DAU_Identidad__c = resultJson.CARD_HOLDER_LEGAL_ID;
                    caso.DAU_No_Cuenta__c = resultJson.ACCOUNT_NUMBER;
                    caso.DAU_aprobacion__c = true; caso.Archivo_Adjunto__c = true; caso.Reason = 'Otro';
                    if(IsAfilationAGN == true) {
                        caso.Status = 'Cerrado';
                    }    
                    update Caso;
                    //solicitud = AFPCCasos.upsertCaso(caso);
                    if(caso.Respuesta_SF_Tarjetas__c == Null && IsAfilationAGN != true){
                        List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                        Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = caso.Id, DAU_SegundoServicio__c = True));
                        // Call method to publish events
                        List<Database.SaveResult> results = EventBus.publish(Logs);
                    }                      
                    if(caso.Respuesta_SF_Tarjetas__c != Null && IsAfilationAGN != true && caso.Respuesta_SF_Tarjetas__c.contains('éxito')) {
                        List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                        Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = caso.Id, DAU_CuartoServicio__c = True));
                        // Call method to publish events
                        List<Database.SaveResult> results = EventBus.publish(Logs);    
                    }
                    /*} else {
                        System.debug('Las identidades son distintas');
                        caso.DAU_Identidad__c = 'Error: Las identidades son distintas: '+resultJson.CARD_HOLDER_LEGAL_ID;
                        caso.DAU_aprobacion__c = true; caso.DAU_No_Cuenta__c = resultJson.ACCOUNT_NUMBER; solicitud = AFPCCasos.upsertCaso(caso);
                        //if(solicitud.solicitudExitosa){
                        //    solicitud = AFPCCasos.envioAprobacion(caso.id, 'AumentoDisminucion');
                        //}                     
                    }*/  
                } else {
                	System.debug('Tarjeta dada de baja');
                    caso.Description = 'Tarjeta dada de baja'; 
                    Update Caso;
                }  
            }    
        }   
    }
    
    @Future(callout=true)
    public static void validarIdentidad3(String casoId, String pccuentapago, String pcnroid, String pcpromotor) {
        Case caso = new Case();
        caso = [Select Id, Status, DAU_aprobacion__c, DAU_Identidad__c, DAU_No_Cuenta__c, Respuesta_SF_Tarjetas__c 
                   From case where Id =: casoId];
        
        FieldsAHManagement fields = new FieldsAHManagement();
        fields = ControllerValidateIdentityAH.execute(pccuentapago);
        caso.DAU_Identidad__c = fields.LEGAL_ID;
        System.debug('Identidades: '+fields.LEGAL_ID+'---'+pcnroid);
        SolicitudCaso solicitud = new SolicitudCaso();
        if(fields.LEGAL_ID != Null || fields.LEGAL_ID != '') {
            if(fields.LEGAL_ID != pcnroid) {
                caso.Archivo_Adjunto__c = true;
                caso.DAU_aprobacion__c = false;
                caso.Enviar_aprobacion_AD__c = true;
                solicitud = AFPCCasos.upsertCaso(caso);
                if(solicitud.solicitudExitosa){
                    solicitud = AFPCCasos.envioAprobacion(caso.id, 'AumentoDisminucion');
                }
            } else {
                caso.Archivo_Adjunto__c = true; caso.Status = 'Cerrado'; caso.Aprobado__c = True; solicitud = AFPCCasos.upsertCaso(caso);
            }
        } else {
            User us = [Select Id,Name,Zona__c From User Where Id =: pcpromotor];
            if(us.Id != null) {
                Usuarios_para_asignacion_Casos_SAC__c p = new Usuarios_para_asignacion_Casos_SAC__c();
                p = [select id, usuario__C, usuario__r.email, Ultimo_Caso_Asignado__c from Usuarios_para_asignacion_Casos_SAC__c where zona__c = : us.Zona__c
                     And Objeto__c = 'Case' And Usuario__r.IsActive = true
                     order by Ultimo_Caso_Asignado__c asc limit 1];
                caso.OwnerId = p.usuario__C; caso.Description = 'La moneda del fondo de pensión no es igual a la moneda de la cuenta de ahorro/cheque';
            	solicitud = AFPCCasos.upsertCaso(caso);
            }    
        }
    }
    
}