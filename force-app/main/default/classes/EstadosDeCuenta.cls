public class EstadosDeCuenta {
	
    @future(callout=true)
    public static void enviarCorreos(list<String> idCaso, String tipoEDC){
    		try{
                system.debug('Entró en método enviarCorreos');
               
                String urlSite = claseUtilPlanillas.urlSysde('EstadosCuenta');
                
                StaticResource staticResource = [SELECT Id, SystemModStamp, Name
                                                 FROM StaticResource 
                                                 WHERE Name = 'CintilloPortadaEDC'
                                                 LIMIT 1];
                String urlResource = 'resource/' + String.valueOf(staticResource.SystemModStamp.getTime())+ '/' + staticResource.Name;

                
                Date fechaHoy = Date.Today();
    			String queryCorreo = 'Select Cuerpo__c,DeveloperName From Correo_EDC__mdt Where DeveloperName in ';                
    			list<classECMensual> respuesta = new list<classECMensual>();
    			list<classECPortada> respuestaDetallado = new list<classECPortada>();
    			list<classClientesEC> claseEnvio = new list<classClientesEC>();
    			map<String, String> mapClientes = new map<String, String>();
            	map<String, String> mapCorreos = new map<String, String>();
    			map<String, String> mapFDesde = new map<String, String>();
    			map<String, String> mapFHasta = new map<String, String>();
                map<String, String> mapContacto = new map<String, String>();
                map<String, String> mapNombre = new map<String, String>();
                map<String, String> mapTypeCliente = new map<String, String>();
                String recordTypeIdNatural = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
                list<string> idClientes= new list<string>();
                Date desde;
                Date hasta;
                if(idCaso != null){
                    system.debug('Entró en True casos');
                    For(Case item :
                        [Select Fecha_Desde__c,Account.Identificacion__c, Account.PersonContactId ,
                         Account.Name,Account.PersonEmail, Fecha_Hasta__c,
                         Contact.Email,ContactId, Account.RecordTypeId 
                         From Case Where Id In: idCaso and EnviarEDCPorCorreo__c = true]){
                             
                             classClientesEC nueva = new classClientesEC();
                             nueva.idCliente = item.Account.Identificacion__c;
                             nueva.desde = item.Fecha_Desde__c;
                             nueva.hasta = item.Fecha_Hasta__c;
                             claseEnvio.add(nueva);
                             
                             mapClientes.put(item.Account.Identificacion__c, item.Account.Identificacion__c);
                             mapNombre.put(item.Account.Identificacion__c, item.Account.Name);
                             if(item.Account.RecordTypeId  == recordTypeIdNatural){
                                 mapCorreos.put(item.Account.Identificacion__c, item.Account.PersonEmail);
                                 mapContacto.put(item.Account.Identificacion__c, item.Account.PersonContactId);
                                 mapTypeCliente.put(item.Account.Identificacion__c, 'EDC_Portada');
                             }else{
                                 mapCorreos.put(item.Account.Identificacion__c, item.Contact.Email);
                                 mapContacto.put(item.Account.Identificacion__c, item.ContactId);
                                 mapTypeCliente.put(item.Account.Identificacion__c, 'EDC_Portada_Juridicos');
                             }
                             
                             String fDesde = item.Fecha_Desde__c != null ? string.valueOF(item.Fecha_Desde__c) : 'null';
                             String fHasta = item.Fecha_Hasta__c != null ? string.valueOF(item.Fecha_Hasta__c) : 'null';
                             mapFDesde.put(item.Account.Identificacion__c, fDesde);
                             mapFHasta.put(item.Account.Identificacion__c, fHasta);
                             fechaHoy = item.Fecha_Hasta__c;
                             desde = item.Fecha_Desde__c;
                             hasta = item.Fecha_Hasta__c; 
                                         
                    }
                }
    			Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
    			OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];   	
    			map<string, integer> mapClientestrimestral = new map<string, integer>();
    			if(tipoEDC == 'A1'){
					queryCorreo += '(\'EDC_Portada\',\'EDC_Portada_Juridicos\')';
                    respuestaDetallado = EstadosDeCuenta.estadoCuentaCorreo(claseEnvio).respuesta;
                    for(integer i=0; i<respuestaDetallado.size(); i++) {
                        respuestaDetallado[i].nombrecliente = mapNombre.get(respuestaDetallado[i].identidad);
                        respuestaDetallado[i].emailCliente = mapCorreos.get(respuestaDetallado[i].identidad);
                        
                    }
				}else{
					queryCorreo += '(\'EDC_Mensual2\')';
                    respuestaDetallado = EstadosDeCuenta.estadoCuentaCorreo(claseEnvio).respuesta;
                   for(classECPortada item : respuestaDetallado){
                       if(!mapClientestrimestral.containsKey(item.identidad)){
                           mapClientestrimestral.put(item.identidad,6);
                       }
                   }
				}
                System.debug(urlSite+'---'+urlResource);
                Map<String, String> mapBodyEmail = new Map<String, String>();
                for(Correo_EDC__mdt item : dataBase.query(queryCorreo)){
                    item.Cuerpo__c = item.Cuerpo__c.replace('[getSite]', urlSite);
                    item.Cuerpo__c = item.Cuerpo__c.replace('[getCintillo]', urlResource);
                    mapBodyEmail.put(item.DeveloperName, item.Cuerpo__C);
                }
			
			if(tipoEDC == 'A1'){
				For(classECPortada item : respuestaDetallado){
                    Messaging.SingleEmailMessage correo = new Messaging.SingleEmailMessage(); 
                    String cuerpo = mapBodyEmail.get(mapTypeCliente.get(item.identidad));
                    if(desde != null && hasta != null){
                        cuerpo = cuerpo.replace('A la Fecha:', 'Período del');
                        cuerpo = cuerpo.replace('[getAlaFecha]', desde.day()+'-'+(desde.month()<10 ? '0'+desde.month() : ''+desde.month())+'-'+desde.year()+' al '+ item.fechaCierre);
                    }
					cuerpo = cuerpo.replace('[getAlaFecha]', item.fechaCierre);
					String lps = item.fondosLempiras != null ? '<br/> &nbsp; &nbsp; &nbsp; Total Fondos en Lempiras: ' + item.fondosLempiras : '';
					cuerpo = cuerpo.replace('[getFondosLempira]', lps);
					
					String dolar = item.fondosDolares != null ? '<br/> &nbsp; &nbsp; &nbsp; Total Fondos en Dólares: ' + item.fondosDolares : '';
					cuerpo = cuerpo.replace('[getFondosDolar]', dolar);
					varurl url= new varurl();
                    url.idcli=mapClientes.get(item.identidad);
                    url.desde=mapFDesde.get(item.identidad);
                    url.hasta=mapFHasta.get(item.identidad);
                    string contenido =JSON.serialize(url);
                    string hy = EncodingUtil.base64Encode(Blob.valueof(contenido));
                    //string hy = EncodingUtil.urlEncode(contenido, 'UTF-8');

                    cuerpo = cuerpo.replace('[getFPC]', hy);
                    //system.debug('variable base64 '+ hy);
					cuerpo = cuerpo.replace('[getDirigidoA]', item.nombreCliente);
					/*cuerpo = cuerpo.replace('[getIdCliente]', mapClientes.get(item.identidad));
					cuerpo = cuerpo.replace('[getFDesde]', mapFDesde.get(item.identidad));
					cuerpo = cuerpo.replace('[getFHasta]', mapFHasta.get(item.identidad));*/
					
					correo.setHtmlBody(cuerpo);
					correo.setSubject('Estado de cuenta');
                    //String[] toAddresses = new String[] {'luis.castaneda@intellectsystem.net'};
		            String[] toAddresses = new String[] {item.emailCliente};
		            correo.setToAddresses(toAddresses);  
		            correo.setOrgWideEmailAddressId(owea.get(0).Id);
                    correo.setTargetObjectId(mapContacto.get(item.identidad));
                    correo.setSaveAsActivity(true);
		            listCorreo.add(correo);    
	           }
			}else{
                
                For(String item : mapClientes.keySet()){
                   if(mapClientestrimestral.containsKey(item))
                   {
                       Messaging.SingleEmailMessage correo = new Messaging.SingleEmailMessage(); 
                    	String cuerpo = mapBodyEmail.get('EDC_Mensual2');  
                         varurl url= new varurl();
                         url.idcli=mapNombre.get(item);
                         url.desde=mapFDesde.get(item);
                         url.hasta=mapFHasta.get(item);
                        string contenido =JSON.serialize(url);
                      //  string hy=EncodingUtil.base64Encode(contenido);
                       	string hy = EncodingUtil.base64Encode(Blob.valueof(contenido));
                       	//string hy = EncodingUtil.urlEncode(contenido, 'UTF-8');
                        //String encoded = EncodingUtil.urlEncode(url, 'UTF-8');
                        system.debug(hy);
                       	cuerpo = cuerpo.replace('[getFPC]', hy);
                        cuerpo = cuerpo.replace('[getDirigidoA]', mapNombre.get(item));
                        //cuerpo = cuerpo.replace('[getIdCliente]', mapClientes.get(item));
                        //cuerpo = cuerpo.replace('[getFDesde]', mapFDesde.get(item));
                        //cuerpo = cuerpo.replace('[getFHasta]', mapFHasta.get(item));
                        
                        correo.setHtmlBody(cuerpo);
                        correo.setSubject('Resumen mensual de tus cuentas.');
                        //String[] toAddresses = new String[] {'wendy.paola@ficohsa.com'};
                        String[] toAddresses = new String[] {mapCorreos.get(item)}; //{'wendy.paola@ficohsa.com'};
                        correo.setToAddresses(toAddresses); 
                        //correo.setToAddresses(new String[] {'wendy.paola@ficohsa.com','luis.castaneda@intellectsystem.net',
                          //  'wendyalvarado02@gmail.com'});
                        correo.setOrgWideEmailAddressId(owea.get(0).Id);
                        correo.setTargetObjectId(mapContacto.get(item));
                        correo.setSaveAsActivity(true);
                        listCorreo.add(correo);
                       system.debug('dirección de correo linea 142: '+correo.getToAddresses());
                   }
                	    
                }
				
		   }
           Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
           system.debug('Correos enviados correctamente: '+results.size());
           
        }Catch(Exception e){
            system.debug('Error al enviar correo de EDC: ' + e.getMessage() + ' Linea: ' + e.getLineNumber() + ' Mensaje ' + e.getMessage());	
        }
    }  
   
    
    public static PortadaEDC estadoCuentaCorreo(list<classClientesEC> claseEnvio) {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/ec/portada');
		PortadaEDC portada = new PortadaEDC();
		//list<classECPortada> respuesta = new list<classECPortada>();
        portada.respuesta = new list<classECPortada>();
		system.debug('Entro al REST del EDC');
		try{
						
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug('El contenido recibido es ' + cons);		
            request.setBody(cons);	
            
            HttpResponse response = http.send(request);
            System.debug('Respuesta de Sysde: '+response.getBody());
            portada.respuestaSysde = response.getBody();
            if (response.getStatusCode() == 200) {
               portada.respuesta = (list<classECPortada>)System.JSON.deserialize(response.getBody(), list<classECPortada>.class);
            }       	
                       
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return portada;   
    }
    
    public static PortadaEDC estadoCuentaCorreoMasivo(list<classClientesEC> claseEnvio) {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');	
		//String url = 'https://api-fpc.herokuapp.com/';	
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/ec/portada');
		
        PortadaEDC portada = new PortadaEDC();
        portada.respuesta = new list<classECPortada>();
        system.debug('Entro al REST del EDC');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            
            HttpResponse response = http.send(request);
            System.debug('Respuesta de Sysde: '+response.getBody());
            portada.respuestaSysde = response.getBody();
            if (response.getStatusCode() == 200) {
                portada.respuesta = (list<classECPortada>)System.JSON.deserialize(response.getBody(), list<classECPortada>.class);
            }       	
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return portada;   
    }
    
    public static list<classECMensual> estadoCuentaMensual(list<classClientesEC> claseEnvio) {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/ec/mensual');
		
		Case caso = new Case();
		list<classECMensual> respuesta = new list<classECMensual>();

		try{
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug('Contenido enviado: ' + cons);		
            request.setBody(cons);
            HttpResponse response = http.send(request);
            System.debug('Respuesta desde SYSDE: ' + response.getBody());
            if (response.getStatusCode() == 200) {
                respuesta = (list<classECMensual>)System.JSON.deserialize(response.getBody(), list<classECMensual>.class);
            }       	
                       
		}Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return respuesta;   
    }
    
    public static list<classECTrimestral> estadoCuentaTrimestral(list<classClientesEC> claseEnvio) {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setEndpoint(url + 'api/ec/trimestral' );
		request.setTimeout(120000);
		
		list<classECTrimestral> respuesta = new list<classECTrimestral>();

		try{
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);
		
			HttpResponse response = http.send(request);
			System.debug('Respuesta: '+response.getBody());
            if (response.getStatusCode() == 200) {
                respuesta = (list<classECTrimestral>)System.JSON.deserialize(response.getBody(), list<classECTrimestral>.class);
            }       	
                       
		}Catch(Exception e){
			system.debug('EDC Trimestral: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
		} 
		return respuesta;   
    }
    
    public static list<classECTrimestral> estadoCuentaTrimestralMasivo(list<classClientesEC> claseEnvio) {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');	
		//String url = 'https://api-fpc.herokuapp.com/';		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setEndpoint(url + 'api/ec/trimestral' );
		request.setTimeout(120000);
		
		list<classECTrimestral> respuesta = new list<classECTrimestral>();

		try{
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);
		
			HttpResponse response = http.send(request);
			System.debug('Respuesta: '+response.getBody());
            if (response.getStatusCode() == 200) {
                respuesta = (list<classECTrimestral>)System.JSON.deserialize(response.getBody(), list<classECTrimestral>.class);
            }       	
                       
		}Catch(Exception e){
			system.debug('EDC Trimestral: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
        } 
        return respuesta;   
    }
    
    public static list<classECHistorico> estadoCuentaHistorico(list<classClientesEC> claseEnvio) {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
        //URL = 'http://190.5.68.49:9090/';
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setEndpoint(url + 'api/ec/historico');
		request.setTimeout(120000);

		list<classECHistorico> respuesta = new list<classECHistorico>();

		try{

			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);
            
            HttpResponse response = http.send(request);
            System.debug('Respuesta: '+response.getBody());
            if (response.getStatusCode() == 200) {
                respuesta = (list<classECHistorico>)System.JSON.deserialize(response.getBody(), list<classECHistorico>.class);
            }       	
                       
		}Catch(Exception e){
			system.debug('EDC Historico: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
		} 
		return respuesta;   
    }
    
    public static list<classECHistorico> estadoCuentaHistoricoMasivo(list<classClientesEC> claseEnvio) {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');	
		//String url = 'https://api-fpc.herokuapp.com/';		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setEndpoint(url + 'api/ec/historico');
		request.setTimeout(120000);

		list<classECHistorico> respuesta = new list<classECHistorico>();

		try{

			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
            system.debug(request.getEndpoint()+' --- '+cons);		
            request.setBody(cons);
            
            HttpResponse response = http.send(request);
            System.debug('Respuesta: '+response.getBody());
            if (response.getStatusCode() == 200) {
                respuesta = (list<classECHistorico>)System.JSON.deserialize(response.getBody(), list<classECHistorico>.class);
            }       	
                       
		}Catch(Exception e){
			system.debug('EDC Historico: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
		} 
        return respuesta;   
    }
    
    

    public static void InsertarCorreos(){
        try{
            
            list<account> todosclientes = new list<account>();
            list<account> clientes = new list<account>();
            list<Correo_estado_cuenta__c> todoscorreos = new list<Correo_estado_cuenta__c>();
            list<string> idclientes= new list<string>();
            
            Decimal contador = 0;
            Integer numeroclientesGrupo = 0;
            Integer tamanioGrupo = Integer.valueOf(Label.TamanioGrupoEDCMasivo);
            
            for(Correo_estado_cuenta__c item :[select Cliente__C, Grupo__c from Correo_estado_cuenta__c order by grupo__C desc]){
                idclientes.add(item.cliente__C);
                if(contador == 0) contador = item.Grupo__C;
                if(contador == item.Grupo__c) numeroclientesGrupo++;
            }
            
            todosClientes = [Select Id From Account 
                             Where PersonEmail not in ('notiene@ejemplo.hn', 'notiene@example.com', null) 
							 and Id not in :idclientes
                             and identificacion__C !=null limit 10000];
           
            for(integer i=0; i<todosClientes.size(); i++) {
                clientes.add(todosclientes[i]); 
                if(clientes.size() == tamanioGrupo || i == todosclientes.size()-1){
                    
                    if(clientes.size() + numeroclientesGrupo >= tamanioGrupo){
                       contador++; 
                    }
                   
                  for(integer j=0; j<clientes.size(); j++) {
                     todoscorreos.add(
                         new Correo_estado_cuenta__c(
                             cliente__C = clientes[j].id, 
                             grupo__C = contador,
                             enviado__C = true,
                             enviado_mensual__C = true)); 
                  }
                
                    clientes = new List<Account>();
                }
            }
            database.insert(todoscorreos, false);
        }catch(Exception ex) {
           system.debug(ex.getLineNumber()+'    '+ex.getMessage());
            
        }
    }  

    public static list<string> ObtenerCorreos(string tipoEstadoCuenta)
    {
        list<string> idclientes= new list<string>();
        try{
           
           decimal u;
           string query; 
            if(tipoEstadoCuenta=='A1'){
                u=[select grupo__C from Correo_estado_cuenta__c where enviado__C = false order by grupo__C asc limit 1].grupo__C;
                query='select cliente__C  from Correo_estado_cuenta__c where grupo__C=:u and enviado__C = false';
            }else {
                u=[select grupo__C from Correo_estado_cuenta__c where enviado_mensual__C=false order by grupo__C asc limit 1].grupo__C;
                query='select cliente__C  from Correo_estado_cuenta__c where grupo__C=:u and enviado_mensual__C=false';
            }
            
            query=query.replace(':u', string.valueOf(u));
            
            for(Correo_estado_cuenta__c item : database.query(query)){
                idclientes.add(item.cliente__C);
            }
            system.debug('Grupo:'+U+' Cantidad de Correos enviados: '+idclientes.size());
        }catch(exception ex) {
            system.debug('Error: '+ex.getLineNumber() +', Linea: '+ ex.getLineNumber());
        }
        
        return idClientes;
    } 
    
    
    public class VarURL
    {
        public string idcli{get;set;}
        public string desde{get;set;}
        public string hasta{get;set;}
        
    }
    
    public class PortadaEDC {
        public list<classECPortada> respuesta = new list<classECPortada>();
        public String respuestaSysde{get;set;}
        
    }
    
    
}