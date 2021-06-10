public class updateCase {
        
    public class wrapperClass {
       public String DAU_Identidad {get;set;}
       public String DAU_No_Cuenta {get;set;}
       public Boolean DAU_aprobacion {get;set;} 
       public String Respuesta_SF_Tarjetas {get;set;}
    }
    
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
            
            List<Detalle_caso__c> detcaso = [Select Id,Caso__c,Cuenta__c,Cuenta__r.Codigo__c From Detalle_caso__c 
                                             Where Caso__c In: casoOrigen Limit 1]; 
            
            List<Detalle_caso__c> dcase = new List<Detalle_caso__c>();
            dcase.add(new Detalle_caso__c(Caso__c = caso[0].Id,Cuenta__c = detcaso[0].Cuenta__c,Accion__c = 'A2',Tipo_Operacion__c = 'A7',Tipo_saldo_modificar2__c = '10',Banco__c='28'));
            
            System.debug('Se actualiza el caso automático de Cancelación');
            caso[0].DAU_Tarjeta_de_Sysde__c = DAU_BorrarCuotas.ConsultaInfoClienteC(caso[0].Id, detcaso[0].Cuenta__r.Codigo__c);
            caso[0].DAU_aprobacion__c = true;
            System.debug('caso[0].Id: '+caso[0].Id);
            System.debug('DAU_Tarjeta_de_Sysde: '+caso[0].DAU_Tarjeta_de_Sysde__c);
            System.debug('caso[0].Account.Identificacion: '+caso[0].Account.Identificacion__c);     
            if(caso[0].DAU_Tarjeta_de_Sysde__c <> Null) {
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
                Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = caso[0].Id));
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
        String pctipoid, pcnroid, cuenta, pcprimernombre, pcprimerapellido, pcmail, pnnrocertificado, tipoFondo, frecuencia, pcformapago, pccuentapago, diaPago, pcMes, pcAnio, pcPOS, pcTarjetaHabiente, pcTipoTarjeta, pcBanco;
        Double pcMonto;
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
        }
        System.debug('pctipoid: '+pctipoid+'--- pcnroid: '+pcnroid+'--- cuenta: '+cuenta+'--- pcprimernombre: '+pcprimernombre+'--- pcprimerapellido: '+pcprimerapellido+'--- pcmail: '+pcmail+'--- pnnrocertificado: '+pnnrocertificado+'--- tipoFondo: '+tipoFondo+'--- frecuencia: '+frecuencia+'--- pcformapago: '+pcformapago+'--- pccuentapago: '+pccuentapago+'--- diaPago: '+diaPago);
        List<Account> cuentaExiste = [Select Id,Identificacion__c From Account Where Identificacion__c =: pcnroid Limit 1];
        if(!cuentaExiste.isEmpty()) {
        	System.debug('Cuenta Existente: '+cuentaExiste[0].Id);
            Cuentas__c cuentac = new Cuentas__c();
            cuentac.Name = cuenta;
            cuentac.Codigo__c = cuenta;
            cuentac.Codigo_Barra__c = pnnrocertificado;
            cuentac.Cliente__c = cuentaExiste[0].Id;
            cuentac.Activo__c = true;
            //cuentac.Producto__c = pcproducto;
            //cuentac.Subproducto__c = pcsubproducto;
            cuentac.Tipo_Fondo__c = tipoFondo;
            cuentac.Frecuencia_Aportacion__c = frecuencia;
            cuentac.Forma_Aportacion__c = pcformapago;
            insert cuentac;
            System.debug('cuentac: '+cuentac);
            updateCase.createManagementAfiliation(pcnroid, String.valueOf(cuentac.Cliente__c), String.valueOf(cuentac.Id), frecuencia, pcformapago, pccuentapago, diaPago, pcMes, pcAnio, pcMonto, pcPOS, pcTarjetaHabiente, pcTipoTarjeta, pcBanco);   
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
            updateCase.createCuentaC(pcnroid, cta.Id, cuenta, pnnrocertificado, tipoFondo, frecuencia, pcformapago, pccuentapago, diaPago, pcMes, pcAnio, pcMonto, pcPOS, pcTarjetaHabiente, pcTipoTarjeta, pcBanco);
        }
    }
    public static void createCuentaC(String pcnroid, String cliente, String cuenta, String pnnrocertificado, String tipoFondo, String frecuencia, String pcformapago, String pccuentapago, String diaPago, String pcMes, String pcAnio, Double pcMonto, String pcPOS, String pcTarjetaHabiente, String pcTipoTarjeta, String pcBanco) {
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
        updateCase.createManagementAfiliation(pcnroid, String.valueOf(cuentac.Cliente__c), String.valueOf(cuentac.Id), frecuencia, pcformapago, pccuentapago, diaPago, pcMes, pcAnio, pcMonto, pcPOS, pcTarjetaHabiente, pcTipoTarjeta, pcBanco);    
    }
    public static void createManagementAfiliation(String pcnroid, String cliente, String cuenta, String frecuencia, String pcformapago, String pccuentapago, String diaPago, String pcMes, String pcAnio, Double pcMonto, String pcPOS, String pcTarjetaHabiente, String pcTipoTarjeta, String pcBanco) {
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
        c.Archivo_Adjunto__c = false;
        c.Viene_Portal_Autogestion__c = false;
        c.DAU_aprobacion__c = false;
        Insert c;
        System.debug('Caso guardado: '+c);  
        updateCase.createDetailAfiliation(c, pcnroid, cuenta, frecuencia, pcformapago, pccuentapago, diaPago, pcMes, pcAnio, pcMonto, pcPOS, pcTarjetaHabiente, pcTipoTarjeta, pcBanco);    
    }
    public static void createDetailAfiliation(Case caso, String pcnroid, String cuentac, String frecuencia, String pcformapago, String pccuentapago, String diaPago, String pcMes, String pcAnio, Double pcMonto, String pcPOS, String pcTarjetaHabiente, String pcTipoTarjeta, String pcBanco) {
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
        insert detcaso;
        System.debug('detcaso: '+detcaso);
        if(pcformapago == 'TA') {
			validarIdentidad2(String.valueOf(caso.Id), pccuentapago, pcnroid);  
        }    
    }
    
    //@Future(callout=true)
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
                    System.debug('Entra 1');
                    /*caso[0].DAU_Identidad__c*/ wc.DAU_Identidad = 'No se obtuvo la identidad';
                    wc.DAU_aprobacion = true;
                    //update caso;
                } else if(resultJson.CARD_HOLDER_LEGAL_ID != resultJson.ACCOUNT_HOLDER_LEGAL_ID) {
                    System.debug('Entra 2');
                    /*caso[0].DAU_Identidad__c*/ wc.DAU_Identidad = resultJson.CARD_HOLDER_LEGAL_ID;
                    /*caso[0].DAU_No_Cuenta__c*/ wc.DAU_No_Cuenta = resultJson.ACCOUNT_NUMBER;
                    /*caso[0].DAU_aprobacion__c*/ wc.DAU_aprobacion = false;  
                    //update caso;
                } else {
                    if(resultJson.CARD_STATUS == '20 - TARJETA NORMAL') {
                        if(resultJson.CARD_HOLDER_LEGAL_ID == pcnroid) {
                            System.debug('Entra 3');
                            /*caso[0].DAU_Identidad__c*/ wc.DAU_Identidad = resultJson.CARD_HOLDER_LEGAL_ID;
                            /*caso[0].DAU_No_Cuenta__c*/ wc.DAU_No_Cuenta = resultJson.ACCOUNT_NUMBER;
                            wc.DAU_aprobacion = true;
                            //update caso;
                            /*List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                            Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = caso[0].Id, DAU_EjecutarSYSDE__c = true, DAU_NumeroCuenta__c = resultJson.ACCOUNT_NUMBER));
                            // Call method to publish events
                            List<Database.SaveResult> results = EventBus.publish(Logs);*/
                        } else {
                            System.debug('Entra 4');
                            /*caso[0].DAU_Identidad__c*/ wc.DAU_Identidad = resultJson.CARD_HOLDER_LEGAL_ID;
                            /*caso[0].DAU_aprobacion__c*/ wc.DAU_aprobacion = false;
                            /*caso[0].DAU_No_Cuenta__c*/ wc.DAU_No_Cuenta = resultJson.ACCOUNT_NUMBER;
                            //update caso;
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
                
        List<Case> caso = new List<Case>();
        caso = [Select Id, Status, DAU_aprobacion__c, DAU_Identidad__c, DAU_No_Cuenta__c From case where Id =: casoId];
        
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
           
            if(resultJson.CARD_HOLDER_LEGAL_ID == Null) { 
                caso[0].DAU_Identidad__c = 'No se obtuvo la identidad';
                caso[0].DAU_aprobacion__c = true;  
                update caso;
            } else if(resultJson.CARD_HOLDER_LEGAL_ID != resultJson.ACCOUNT_HOLDER_LEGAL_ID) {
                caso[0].DAU_Identidad__c = resultJson.CARD_HOLDER_LEGAL_ID;
                caso[0].DAU_No_Cuenta__c = resultJson.ACCOUNT_NUMBER;
                caso[0].DAU_aprobacion__c = false;  
                update caso;
            } else {
                if(resultJson.CARD_STATUS == '20 - TARJETA NORMAL') {
                    if(resultJson.CARD_HOLDER_LEGAL_ID == pcnroid) {
                        caso[0].DAU_Identidad__c = resultJson.CARD_HOLDER_LEGAL_ID;
                        caso[0].DAU_No_Cuenta__c = resultJson.ACCOUNT_NUMBER;
                        caso[0].DAU_aprobacion__c = true;
                        update caso;
                    } else {
                        caso[0].DAU_Identidad__c = resultJson.CARD_HOLDER_LEGAL_ID;
                        caso[0].DAU_aprobacion__c = false;
                        caso[0].DAU_No_Cuenta__c = resultJson.ACCOUNT_NUMBER;
                        update caso;
                    }  
                }    
            }    

        }   
    } 
    
}