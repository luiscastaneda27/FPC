public class EstadosDeCuentaPrueba {
	
    @future(callout=true)
    public static void enviarCorreos(list<String> idCaso, String tipoEDC){
    		try{
                system.debug('Entró en método enviarCorreos');
                list<string> idClientes = ObtenerCorreos(tipoEDC);
                Date fechaHoy = Date.Today();
    			String queryCorreo = 'Select Cuerpo__c From Correo_EDC__mdt Where DeveloperName = ';                
    			list<classECMensual> respuesta = new list<classECMensual>();
    			list<classECPortada> respuestaDetallado = new list<classECPortada>();
    			list<classClientesEC> claseEnvio = new list<classClientesEC>();
    			map<String, String> mapClientes = new map<String, String>();
            	map<String, String> mapCorreos = new map<String, String>();
    			map<String, String> mapFDesde = new map<String, String>();
    			map<String, String> mapFHasta = new map<String, String>();
                map<String, String> mapContacto = new map<String, String>();
    			map<String, String> mapNombre = new map<String, String>();
    			
    			if(idCaso != null){
                    system.debug('Entró en True casos');
    				For(Case item : [Select Fecha_Desde__c,Account.Identificacion__c, Account.PersonContactId ,
                                     Account.Name,Account.PersonEmail, Fecha_Hasta__c 
    								From Case Where Id In: idCaso]){
    									
    					classClientesEC nueva = new classClientesEC();
    					nueva.idCliente = item.Account.Identificacion__c;
    					nueva.desde = item.Fecha_Desde__c;
    					nueva.hasta = item.Fecha_Hasta__c;
    					claseEnvio.add(nueva);
                                        
    					mapClientes.put(item.Account.Identificacion__c, item.Account.Identificacion__c);
                    	mapCorreos.put(item.Account.Identificacion__c, item.Account.PersonEmail);
                        mapContacto.put(item.Account.Identificacion__c, item.Account.PersonContactId);
                        mapNombre.put(item.Account.Identificacion__c, item.Account.Name);                
    					String fDesde = item.Fecha_Desde__c != null ? string.valueOF(item.Fecha_Desde__c) : 'null';
    					String fHasta = item.Fecha_Hasta__c != null ? string.valueOF(item.Fecha_Hasta__c) : 'null';
    					mapFDesde.put(item.Account.Identificacion__c, fDesde);
    					mapFHasta.put(item.Account.Identificacion__c, fHasta);
                        fechaHoy = item.Fecha_Hasta__c;
    					
    				}
    			}else{
                    
                    fechaHoy = fechaHoy.addDays(-fechaHoy.Day());
                    system.debug('Entró False caso con fecha  ' + fechaHoy);
                     date fechafebrero =DATE.valueOf('2017-02-28');  
                    list<string> codigosclientes = new list<string>();
                    for(Cuentas__C item: [select cliente__C from cuentas__C where cliente__r.Identificacion__c in('0801197812591') and Fecha_Apertura__c <: fechafebrero])
                    {
                        codigosclientes.add(item.cliente__C);
                    }
                    List<Account> clientes = [Select Name, PersonEmail, Identificacion__c, PersonContactId 
                                              From Account Where id in :codigosclientes];
                    //List<Account> clientes = [Select Name,PersonEmail,Identificacion__c,PersonContactId
                      //                         From Account Where identificacion__C ='0104197200523'];
                    
                    system.debug('Clientes queryCli ' + clientes);
    				For(Account item : clientes){
    					classClientesEC nueva = new classClientesEC();
    					nueva.idCliente = item.Identificacion__c;
                        nueva.hasta = fechaHoy;
    					claseEnvio.add(nueva);
    					
    					mapClientes.put(item.Identificacion__c, item.Identificacion__c);
                        mapContacto.put(item.Identificacion__c, item.PersonContactId);
                    	mapCorreos.put(item.Identificacion__c, item.PersonEmail);
                        mapNombre.put(item.Identificacion__c, item.Name); 
    					mapFDesde.put(item.Identificacion__c, 'null');
    					mapFHasta.put(item.Identificacion__c, string.valueOf(fechaHoy));
    				}    				
    			}
    			
    			Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
    			OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];   	
    			map<string, integer> mapClientestrimestral = new map<string, integer>();
    			if(tipoEDC == 'A1'){
					queryCorreo += '\'EDC_Portada\'';
					respuestaDetallado = EstadosDeCuenta.estadoCuentaCorreo(claseEnvio);
				}else{
					queryCorreo += '\'EDC_Mensual2\'';
                    respuestaDetallado = EstadosDeCuenta.estadoCuentaCorreo(claseEnvio);
                   for(classECPortada item : respuestaDetallado)
                   {
                       if(!mapClientestrimestral.containsKey(item.identidad))
                       {
                           mapClientestrimestral.put(item.identidad,6);
                       }
                   }
				}
                //system.debug('respuesta: '+ respuestaDetallado);
    			Correo_EDC__mdt cuerpoCorreo = dataBase.query(queryCorreo);
			
			if(tipoEDC == 'A1'){
				For(classECPortada item : respuestaDetallado){
                    Messaging.SingleEmailMessage correo = new Messaging.SingleEmailMessage(); 
                    String cuerpo = cuerpoCorreo.Cuerpo__c;
					cuerpo = cuerpo.replace('[getAlaFecha]', item.fechaCierre);
					String lps = item.fondosLempiras != null ? '<br/> &nbsp; &nbsp; &nbsp; Total Fondos en Lempiras: ' + item.fondosLempiras : '';
					cuerpo = cuerpo.replace('[getFondosLempira]', lps);
					
					String dolar = item.fondosDolares != null ? '<br/> &nbsp; &nbsp; &nbsp; Total Fondos en Dólares: ' + item.fondosDolares : '';
					cuerpo = cuerpo.replace('[getFondosDolar]', dolar);
					
					cuerpo = cuerpo.replace('[getDirigidoA]', item.nombreCliente);
					cuerpo = cuerpo.replace('[getIdCliente]', mapClientes.get(item.identidad));
					cuerpo = cuerpo.replace('[getFDesde]', mapFDesde.get(item.identidad));
					cuerpo = cuerpo.replace('[getFHasta]', mapFHasta.get(item.identidad));
					
					correo.setHtmlBody(cuerpo);
					correo.setSubject('Estado de cuenta');
                    String[] toAddresses = new String[] {'luis.castaneda@intellectsystem.net'};
		            //String[] toAddresses = new String[] {item.emailCliente};
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
                    	String cuerpo = cuerpoCorreo.Cuerpo__c;  
                        cuerpo = cuerpo.replace('[getDirigidoA]', mapNombre.get(item));
                        cuerpo = cuerpo.replace('[getIdCliente]', mapClientes.get(item));
                        cuerpo = cuerpo.replace('[getFDesde]', mapFDesde.get(item));
                        cuerpo = cuerpo.replace('[getFHasta]', mapFHasta.get(item));
                        
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
           //system.debug('Variable correos: ' + listCorreo);
           Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
           system.debug('Correos enviados correctamente');
           list<Correo_estado_cuenta__c> todosCorreos = new list<Correo_estado_cuenta__c>();
           todosCorreos = [select cliente__C, enviado__C, id, enviado_mensual__C from Correo_estado_cuenta__c where cliente__C in :idClientes];
           if(TipoEDC=='A1')
           {
                for(integer i=0; i<todosCorreos.size(); i++)
               {
                   todosCorreos[i].enviado__C=true;
                   
               }
           }
           else
           {
                for(integer i=0; i<todosCorreos.size(); i++)
               {
                   todosCorreos[i].enviado_mensual__C=true;
                   
               }
           }
          
           update todosCorreos;
        }Catch(Exception e){
            system.debug('Error al enviar correo de EDC: ' + e.getMessage() + ' Linea: ' + e.getLineNumber() + ' Mensaje ' + e.getMessage());	
        }
    }  
   
    public static list<classECPortada> estadoCuentaCorreo(list<classClientesEC> claseEnvio) {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/ec/portada');
		
		list<classECPortada> respuesta = new list<classECPortada>();
		system.debug('Entro al REST del EDC...');
		try{
						
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug('Enviamos: '+cons);		
			request.setBody(cons);	
			HttpResponse response = http.send(request);
            System.debug('Respuesta Sysde: '+response.getBody());
	    	if (response.getStatusCode() == 200) {
           		
           		respuesta = (list<classECPortada>)System.JSON.deserialize(response.getBody(), list<classECPortada>.class);
	     }       	
                       
		}catch(System.CalloutException e){
			system.debug('Error: '+e.getMessage()+' Linea:'+e.getLineNumber());
	
        }Catch(Exception e){
			system.debug('Error: '+e.getMessage()+' Linea:'+e.getLineNumber());	
		} 
		return respuesta;   
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
	    		
	        	if (response.getStatusCode() == 200) {
           		System.debug('Respuesta desde SYSDE: ' + response.getBody());
           		respuesta = (list<classECMensual>)System.JSON.deserialize(response.getBody(), list<classECMensual>.class);
	        	}       	
                       
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
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
			
	    		if (response.getStatusCode() == 200) {
	   			System.debug(response.getBody());
	   			respuesta = (list<classECTrimestral>)System.JSON.deserialize(response.getBody(), list<classECTrimestral>.class);
	    		}       	
                       
		}catch(System.CalloutException e){
			system.debug('EDC Trimestral: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
	
        }Catch(Exception e){
			system.debug('EDC Trimestral: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
		} 
		return respuesta;   
    }
    
    public static list<classECHistorico> estadoCuentaHistorico(list<classClientesEC> claseEnvio) {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
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
    		
	        	if (response.getStatusCode() == 200) {
	       		System.debug(response.getBody());
	       		respuesta = (list<classECHistorico>)System.JSON.deserialize(response.getBody(), list<classECHistorico>.class);
	        	}       	
                       
		}catch(System.CalloutException e){
			system.debug('EDC Historico: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
	
        }Catch(Exception e){
			system.debug('EDC Historico: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
		} 
		return respuesta;   
    }
    
    

    public static void InsertarCorreos()
    {
        try
        {
            list<account> todosclientes = new list<account>();
            list<account> clientes = new list<account>();
            list<string> idclientes= new list<string>();
            for(Correo_estado_cuenta__c item :[select cliente__C from Correo_estado_cuenta__c])
            {
                idclientes.add(item.cliente__C);
            }
            list<Correo_estado_cuenta__c> todoscorreos = new list<Correo_estado_cuenta__c>();
            //map<integer, list<account>> correosOrdenados = new map<integer, list<account>>();
            string correo1='notiene@ejemplo.hn';
            string correo2='notiene@example.com';
            decimal contador=0;
            if([select count() from Correo_estado_cuenta__c]>0)
            {
               contador = [select grupo__C from Correo_estado_cuenta__c order by grupo__C desc limit 1].grupo__C;
            }
            
            todosclientes = [Select id From Account Where PersonEmail != null 
                             and PersonEmail !=:correo1 and PersonEmail != :correo2 and id not in :idclientes
                             and identificacion__C in('0801199411013','0801199209376', '0801197812591', '0801198000054')limit 9600];
           
            integer numeroclientesGrupo=[select count() from Correo_estado_cuenta__c where grupo__C=:contador];
            for(integer i=0; i<todosclientes.size(); i++)
            {
                clientes.add(todosclientes[i]);
                if(clientes.size()==800 || i ==todosclientes.size()-1)
                {
                    if(clientes.size()+numeroclientesGrupo >= 800)
                    {
                       contador++; 
                    }
                   
                  for(integer j=0; j<clientes.size(); j++)
                  {
                     todoscorreos.add(new Correo_estado_cuenta__c(cliente__C=clientes[j].id, grupo__C=contador, enviado__C=true,enviado_mensual__C=true)); 
                  }
                
                    clientes.Clear();
                }
            }
            //Database.BatchableContext BC; 
            insert todoscorreos;
            
            
        }
        catch(Exception ex)
        {
           system.debug(ex.getLineNumber()+'    '+ex.getMessage());
            
        }
    }  

    public static list<string> ObtenerCorreos(string tipoEstadoCuenta)
    {
        list<string> idclientes= new list<string>();
        try
        {
           
           //list<Correo_estado_cuenta__c> todoscorreos = new list<Correo_estado_cuenta__c>();
           decimal u;
           if(tipoEstadoCuenta=='A1')
           {
               u=[select grupo__C from Correo_estado_cuenta__c where enviado__C=false order by grupo__C asc limit 1].grupo__C;
           }
            else
            {
               u=[select grupo__C from Correo_estado_cuenta__c where enviado_mensual__C=false order by grupo__C asc limit 1].grupo__C;
            }
            
            
            //todoscorreos = [select cliente__C, enviado__C, id from Correo_estado_cuenta__c where grupo__C=:u];
            
            for(Correo_estado_cuenta__c item : [select cliente__C from Correo_estado_cuenta__c where grupo__C=:u ])
            {
                //todoscorreos[i].enviado__C=true;
                idclientes.add(item.cliente__C);
            }
            system.debug('Grupo:'+U+' Cantidad de Correos enviados: '+idclientes.size());
           // update todoscorreos;
        }
        catch(exception ex)
        {
            
        }
        
        return idClientes;
    }
      
    
    public static void CambiarEstadoCorreos(string tipoEstadoCuenta)
    {
        try
        {
            list<Correo_estado_cuenta__c> todoscorreos = new list<Correo_estado_cuenta__c>();
            if(tipoEstadoCuenta=='A1')
            {
               todoscorreos = [select cliente__C, enviado__C, id from Correo_estado_cuenta__c where enviado__C=true limit 10000 ];
                for(integer i=0; i<todoscorreos.size(); i++)
                {
                    todoscorreos[i].enviado__C=false;
                }
            }
            else
            {
                todoscorreos = [select cliente__C, enviado_mensual__C, id from Correo_estado_cuenta__c where enviado_mensual__C=true limit 10000 ];
                for(integer i=0; i<todoscorreos.size(); i++)
                {
                    todoscorreos[i].enviado_mensual__C=false;
                }
                
            }
            update todoscorreos;
        }
        catch(exception ex)
        {
            
        }
    }
    
    
    
    
}