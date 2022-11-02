public class EnvioCorreosEDC {
    
     public static boolean enviarCorreos(){
         FPC_Log__c log = new FPC_Log__c();
         log.FPC_Servicio__c = 'EDC Masivo';
         try{
             system.debug('Entró en método enviarCorreos');
             FechaDC_Sysde__c fdcs = [Select Fecha_cierre__c From FechaDC_Sysde__c Where Name = 'CierreAlDia' Limit 1];
             Date fechaHoy = Date.Today();
            fechaHoy = fdcs.Fecha_cierre__c;
            Boolean esTrimestral = (fechaHoy.month() == 1 || fechaHoy.month() == 4 || fechaHoy.month() == 7 || fechaHoy.month() == 10);
            String queryCorreo = 'Select Cuerpo__c From Correo_EDC__mdt Where DeveloperName = ';                
            list<classECMensual> respuesta = new list<classECMensual>();
            list<classECPortada> respuestaDetallado = new list<classECPortada>();
            list<classClientesEC> claseEnvioTrim = new list<classClientesEC>();
            list<classClientesEC> claseEnvioMens = new list<classClientesEC>();
            map<String, String> mapClientes = new map<String, String>();
            map<String, String> mapFDesde = new map<String, String>();
            map<String, String> mapFHasta = new map<String, String>();
            map<String, String> mapContacto = new map<String, String>();
            map<String, String> mapNombre = new map<String, String>();
            map<String, Boolean> mapEsTrimestral = new map<String, Boolean>();
            list<string> idClientes= new list<string>();
            List<Account> clientes = new List<Account>();
            List<FPC_ErroresEstadosDeCuenta__c> listErrores = new List<FPC_ErroresEstadosDeCuenta__c>();
            list<Correo_estado_cuenta__c> todosCorreos = new list<Correo_estado_cuenta__c>();
            
            idClientes = estadosDeCuenta.ObtenerCorreos('A1');
            map<Id, Contact> mapContactosReenvio = new map<Id, Contact>([Select Id, EmailBouncedReason from Contact 
                                                                 Where IsEmailBounced = true And AccountId in :idClientes]);
            fechaHoy = fechaHoy.addDays(-fechaHoy.Day());
            Date desdeT = fechaHoy.addDays(1).addMonths(-fechaHoy.month());
            Date desdeM = fechaHoy.addDays(1).addMonths(-1);
            list<string> codigosclientes = new list<string>(); 
            
            for(Cuentas__C item: [select cliente__C from cuentas__C where Fecha_Apertura__c <: fechaHoy and cliente__C in :idClientes]) { 
                codigosclientes.add(item.cliente__C);
            }
            clientes = [Select Name, PersonEmail, Identificacion__c, PersonContactId, FrecuenciaEnvioEDC__c  
                        From Account Where id in :codigosclientes];
            System.debug('Cliente: '+JSON.serialize(clientes));
            For(Account item : clientes){
                Date fechaDesde = item.FrecuenciaEnvioEDC__c  == 'Mensual' ? desdeM : desdeT;
                classClientesEC nueva = new classClientesEC();
                nueva.idCliente = item.Identificacion__c;
                nueva.desde = fechaDesde;
                nueva.hasta = fechaHoy;
                System.debug('item.FrecuenciaEnvioEDC__c: '+item.FrecuenciaEnvioEDC__c);
                if(item.FrecuenciaEnvioEDC__c  == 'Mensual'){
                    claseEnvioMens.add(nueva);
                }else{
                    claseEnvioTrim.add(nueva);
                }
                
                mapClientes.put(item.Identificacion__c, item.Identificacion__c);
                mapContacto.put(item.Identificacion__c, item.PersonContactId);
                mapNombre.put(item.Identificacion__c, item.Name); 
                mapFDesde.put(item.Identificacion__c, string.valueOf(nueva.desde));
                mapFHasta.put(item.Identificacion__c, string.valueOf(nueva.hasta));
                mapEsTrimestral.put(item.Identificacion__c, item.FrecuenciaEnvioEDC__c  != 'Mensual');
            }                   
            System.debug(claseEnvioTrim.size() +' -- '+claseEnvioMens.size() );
            
            Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];       
            map<string, integer> mapClientestrimestral = new map<string, integer>();
            
             queryCorreo += '\'EDC_Portada\'';
             Integer enviado = 0;
             EstadosDeCuenta.PortadaEDC portada = new EstadosDeCuenta.PortadaEDC();
             if(claseEnvioTrim.size() > 0){
                 log.FPC_Request__c = Json.serialize(claseEnvioTrim);    
                 enviado = claseEnvioTrim.size();
                 portada = !test.isRunningTest() ? EstadosDeCuenta.estadoCuentaCorreoMasivo(claseEnvioTrim) : getListTest();
                 for(classECPortada item: portada.respuesta){
                     respuestaDetallado.add(item);
                 }
             }
             if(claseEnvioMens.size() > 0){
                 log.FPC_Request__c = Json.serialize(claseEnvioMens); 
                 portada = !test.isRunningTest() ? EstadosDeCuenta.estadoCuentaCorreo(claseEnvioMens) : getListTest();
                 enviado = claseEnvioMens.size();
                 for(classECPortada item: portada.respuesta){
                     respuestaDetallado.add(item);
                 }
             }
             log.FPC_Response__c = portada.respuestaSysde;
             log.FPC_Resultado__c = 'Respuesta de Sysde ' + respuestaDetallado.size() +' de '+enviado;
            //respuestaDetallado = !test.isRunningTest() ? esTrimestral ? EstadosDeCuenta.estadoCuentaCorreoMasivo(claseEnvio) : EstadosDeCuenta.estadoCuentaCorreo(claseEnvio)  :  (list<classECPortada>)System.JSON.deserialize('[{"nombreCliente":"","identidad":"1234567890123","emailCliente":"","fondosObligatorios":false,"totalPension":"0.00","coberturaLaboral":"0.00","fondosLempiras":"8,122.75","fondosDolares":null,"fechaCierre":"27-01-2020"}]', list<classECPortada>.class);
            for(account item : clientes) {
                for(integer i=0; i<respuestaDetallado.size(); i++) {
                    if(item.Identificacion__c==respuestaDetallado[i].identidad){
                        respuestaDetallado[i].nombrecliente=item.name;
                        respuestaDetallado[i].emailCliente=item.PersonEmail;
                    }
                }
                if(mapContactosReenvio.containsKey(item.PersonContactId)){
                    listErrores.add(new FPC_ErroresEstadosDeCuenta__c(
                    FPC_Contacto__c = item.PersonContactId,
                    FPC_Error__c = mapContactosReenvio.get(item.PersonContactId).EmailBouncedReason));
                }
            }
            if(respuestaDetallado.size() > 0){
                for(Correo_estado_cuenta__c item: [select cliente__C, enviado__C, id, grupo__C, enviado_mensual__C from Correo_estado_cuenta__c where cliente__C in :idClientes]){
                    item.enviado__C = true;
                    todosCorreos.add(item);
                }
            }
            
            Correo_EDC__mdt cuerpoCorreo = dataBase.query(queryCorreo);
            
            For(classECPortada item : respuestaDetallado){
                Messaging.SingleEmailMessage correo = new Messaging.SingleEmailMessage(); 
                String cuerpo = cuerpoCorreo.Cuerpo__c;
                cuerpo = cuerpo.replace('[getAlaFecha]', item.fechaCierre);
                String lps = item.fondosLempiras != null ? '<br/> &nbsp; &nbsp; &nbsp; Total Fondos en Lempiras: ' + item.fondosLempiras : '';
                cuerpo = cuerpo.replace('[getFondosLempira]', lps);
                
                String dolar = item.fondosDolares != null ? '<br/> &nbsp; &nbsp; &nbsp; Total Fondos en Dólares: ' + item.fondosDolares : '';
                cuerpo = cuerpo.replace('[getFondosDolar]', dolar);
                VarURL url= new VarURL();
                url.idcli=mapClientes.get(item.identidad);
                url.desde=mapFDesde.get(item.identidad);
                url.hasta=mapFHasta.get(item.identidad);
                url.esMasivo = mapEsTrimestral.get(item.identidad);// esTrimestral;
                string contenido =JSON.serialize(url);
                system.debug('contenido en enviarCorreos ' + contenido);
                string hy = EncodingUtil.base64Encode(Blob.valueof(contenido));
                cuerpo = cuerpo.replace('[getFPC]', hy);
                cuerpo = cuerpo.replace('[getDirigidoA]', item.nombreCliente);
                
                correo.setHtmlBody(cuerpo);
                correo.setSubject('Estado de cuenta.');
                String[] toAddresses = new String[] {item.emailCliente};
                    system.debug('Correo: '+item.emailCliente);
                correo.setToAddresses(toAddresses);  
                correo.setOrgWideEmailAddressId(owea.get(0).Id);
                correo.setTargetObjectId(mapContacto.get(item.identidad));
                correo.setSaveAsActivity(true);
                listCorreo.add(correo);    
            }
            
            //system.debug('Variable correos: ' + listCorreo);
            Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
            system.debug('Correos enviados correctamente: '+results.size());
            FechaDC_Sysde__c fcsd = new FechaDC_Sysde__c();
            if(!test.isRunningTest()){ fcsd = [Select  Id, Total_Correos_Enviados__C From FechaDC_Sysde__c Where Name = 'CierreAlDia'];
            }else{
                fcsd.Total_Correos_Enviados__C = 0;
            }
             for(Messaging.SendEmailResult item : results){
                 if(item.isSuccess()){
                     fcsd.Total_Correos_Enviados__C++;
                 }else{
                     System.debug('Error: '+item.getErrors());
                 }
            }
                        
            if(!test.isRunningTest()){
                update fcsd;
            }
            System.debug('todosCorreos: '+JSOn.serialize(todosCorreos));
            update todosCorreos;
            insert listErrores;
            
            String query = 'select  grupo__C from Correo_estado_cuenta__c ';
            query += !esTrimestral ? 'Where Cliente__r.FrecuenciaEnvioEDC__c = \'Mensual\'' : '';
            query += ' Order by grupo__C desc limit 1';
            Correo_estado_cuenta__c CorreosEDC = Database.query(query);
            decimal mayorGrupo = CorreosEDC.grupo__C;
            decimal grupo = todosCorreos.size() > 0 ? todosCorreos[0].Grupo__c : 0;
            log.FPC_Grupo__c = [select Grupo__C from Correo_estado_cuenta__c where cliente__C in :idClientes limit 1].grupo__C;
            if(grupo >= mayorGrupo){
                FPC_ClaseUtilEDC.notificacionFinEnvioEDC(fcsd.Total_Correos_Enviados__c);
            }
        }Catch(Exception e){
            log.FPC_Error__c = 'Error al enviar correo de EDC: ' + e.getMessage() + ', Linea del error: ' + e.getLineNumber();
            system.debug('Error al enviar correo de EDC: ' + e.getMessage() + ' Linea: ' + e.getLineNumber() + ' Mensaje ' + e.getMessage());   
        }
         insert log;
        return true;
    }
    
    public static EstadosDeCuenta.PortadaEDC getListTest(){
        EstadosDeCuenta.PortadaEDC portada = (EstadosDeCuenta.PortadaEDC)System.JSON.deserialize('[{"nombreCliente":"","identidad":"1234567890123","emailCliente":"","fondosObligatorios":false,"totalPension":"0.00","coberturaLaboral":"0.00","fondosLempiras":"8,122.75","fondosDolares":null,"fechaCierre":"27-01-2020"}]', EstadosDeCuenta.PortadaEDC.class);
        return portada;
    }
    
    public class VarURL{
        public string idcli{get;set;}
        public string desde{get;set;}
        public string hasta{get;set;}
        public Boolean esMasivo{get;set;}
        
        public VarURL(){
            this.esMasivo = true;
        }
        
    }
   

}