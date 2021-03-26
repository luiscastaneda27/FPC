public class EnvioCorreosEDC {
    
     public static boolean enviarCorreos(){
        try{
            system.debug('Entró en método enviarCorreos');
            
            Date fechaHoy = Date.Today();
            String queryCorreo = 'Select Cuerpo__c From Correo_EDC__mdt Where DeveloperName = ';                
            list<classECMensual> respuesta = new list<classECMensual>();
            list<classECPortada> respuestaDetallado = new list<classECPortada>();
            list<classClientesEC> claseEnvio = new list<classClientesEC>();
            map<String, String> mapClientes = new map<String, String>();
            map<String, String> mapFDesde = new map<String, String>();
            map<String, String> mapFHasta = new map<String, String>();
            map<String, String> mapContacto = new map<String, String>();
            map<String, String> mapNombre = new map<String, String>();
            list<string> idClientes= new list<string>();
            List<Account> clientes = new List<Account>();
            idClientes = estadosDeCuenta.ObtenerCorreos('A1');
            fechaHoy = fechaHoy.addDays(-fechaHoy.Day());
            date fecha =fechaHoy;  
            list<string> codigosclientes = new list<string>(); 
            
            for(Cuentas__C item: [select cliente__C from cuentas__C where Fecha_Apertura__c <: fecha and cliente__C in :idClientes]) { 
                codigosclientes.add(item.cliente__C);
            }
            clientes = [Select Name, PersonEmail, Identificacion__c, PersonContactId 
                        From Account Where id in :codigosclientes];
            
            For(Account item : clientes){
                classClientesEC nueva = new classClientesEC();
                nueva.idCliente = item.Identificacion__c;
                nueva.hasta = fechaHoy;
                claseEnvio.add(nueva);
                
                mapClientes.put(item.Identificacion__c, item.Identificacion__c);
                mapContacto.put(item.Identificacion__c, item.PersonContactId);
                mapNombre.put(item.Identificacion__c, item.Name); 
                mapFDesde.put(item.Identificacion__c, 'null');
                mapFHasta.put(item.Identificacion__c, string.valueOf(fechaHoy));
            }                   
            
            
            Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];       
            map<string, integer> mapClientestrimestral = new map<string, integer>();
            
            queryCorreo += '\'EDC_Portada\'';
            
            respuestaDetallado = !test.isRunningTest() ? EstadosDeCuenta.estadoCuentaCorreo(claseEnvio) :  (list<classECPortada>)System.JSON.deserialize('[{"nombreCliente":"","identidad":"1234567890123","emailCliente":"","fondosObligatorios":false,"totalPension":"0.00","coberturaLaboral":"0.00","fondosLempiras":"8,122.75","fondosDolares":null,"fechaCierre":"27-01-2020"}]', list<classECPortada>.class);
            for(account item : clientes) {
                for(integer i=0; i<respuestaDetallado.size(); i++) {
                    if(item.Identificacion__c==respuestaDetallado[i].identidad){
                        respuestaDetallado[i].nombrecliente=item.name;
                        respuestaDetallado[i].emailCliente=item.PersonEmail;
                    }
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
                aSysdeCallouts.varurl url= new aSysdeCallouts.varurl();
                url.idcli=mapClientes.get(item.identidad);
                url.desde=mapFDesde.get(item.identidad);
                url.hasta=mapFHasta.get(item.identidad);
                string contenido =JSON.serialize(url);
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
            system.debug('Correos enviados correctamente: '+results);
            FechaDC_Sysde__c fcsd = new FechaDC_Sysde__c();
            if(!test.isRunningTest()){ fcsd = [Select  id, Total_Correos_Enviados__C From FechaDC_Sysde__c Where Name = 'CierreAlDia'];
            }else{
                fcsd.Total_Correos_Enviados__C = 0;
            }
             for(Messaging.SendEmailResult item : results){
                if(item.isSuccess()){ fcsd.Total_Correos_Enviados__C++;
                }
            }
            list<Correo_estado_cuenta__c> todosCorreos = new list<Correo_estado_cuenta__c>();
            decimal grupo = 0;
            todosCorreos = [select cliente__C, enviado__C, id, grupo__C, enviado_mensual__C from Correo_estado_cuenta__c where cliente__C in :idClientes];
            if( listCorreo.size()>0 ){
                for(integer i=0; i<todosCorreos.size(); i++){
                    todosCorreos[i].enviado__C=true;
                    if(todosCorreos[i].grupo__C > grupo){
                        grupo = todosCorreos[i].grupo__C;
                    }
                    
                }
            }
            if(!test.isRunningTest()){
                update fcsd;
            }
            update todosCorreos;
            
            decimal mayorGrupo = [select  grupo__C from Correo_estado_cuenta__c order by grupo__C desc limit 1].grupo__C;
            if(grupo >= mayorGrupo){
                Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
                email.setSubject('Finalizado proceso de envio de Estado de Cuenta '+date.today().format()); 
                email.setToAddresses(new string[] {'paola.cruz@ficohsa.com'/*, 'luis.castaneda@intellectsystem.net'*/});
                email.setPlainTextBody('Buen día, \n\n Se notifica que se ha terminado el proceso de envio de estados de cuenta de este trimestre, con un total de correos exitosos de: '+fcsd.Total_Correos_Enviados__C.format());
                //List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
                //OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
                email.setOrgWideEmailAddressId(owea.get(0).Id);
                Messaging.SingleEmailMessage[] listEmail = new List<Messaging.SingleEmailMessage>(); 
                listEmail.add(email); 
                system.debug('Tamano de lista: '+listEmail.size());
                results = Messaging.sendEmail(listEmail, false); 
            }
        }Catch(Exception e){
            system.debug('Error al enviar correo de EDC: ' + e.getMessage() + ' Linea: ' + e.getLineNumber() + ' Mensaje ' + e.getMessage());   
        }
        return true;
    }  
   

}