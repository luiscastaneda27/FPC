public class ControllerAPIPignorados {
    
	public static classpignorados BuscarCuenta(string cuentapig ) {
       if (cuentapig==null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe Ingresar un codigo de cuenta para realizar la respectiva busqueda'));   
        }  
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/CuentaPign/'+ cuentapig);
        classpignorados fcsd = new classpignorados();
        string respuesta = '';
        system.debug('Entro al REST del EDC');
        try{           
            system.debug('Estoy dentro de EDC');
            system.debug('Y mi request es '+request);
            HttpResponse response = http.send(request);
            system.debug('Cargue la respuesa en el response');
            respuesta = response.getBody();
            system.debug('Respuesta: desde sysde: '+respuesta); 
            
            if (response.getStatusCode() == 200) {
                fcsd = (classpignorados)System.JSON.deserialize(response.getBody(), classpignorados.class);         
            }
            
		}Catch(Exception e){
			system.debug('Error: '+e.getMessage()+', Linea: '+e.getLineNumber());	
		} 
        
        system.debug('debuggAPI' +' '+ fcsd);
		return fcsd;   
    }
    	
    public static classpignorados BuscarNPrestamo(string num_prest) {
       if (num_prest==null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe Ingresar un numero de prestamo para realizar la respectiva busqueda'));   
        }  
        
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);           
        request.setEndpoint(url + 'api/NumPrestPign/'+ num_prest);
        classpignorados fcsd = new classpignorados();
        string respuesta = '';
        system.debug('Entro al REST del EDC');
        try{           
            system.debug('Estoy dentro de EDC');
            system.debug('Y mi request es '+request);
            HttpResponse response = http.send(request);
            system.debug('Cargue la respuesa en el response');
            respuesta = response.getBody();
            system.debug('Respuesta: desde sysde: '+respuesta); 
            if (response.getStatusCode() == 200) {
                fcsd = (classpignorados)System.JSON.deserialize(response.getBody(), classpignorados.class);         
            }
		}Catch(Exception e){
			system.debug('Error: '+e.getMessage()+', Linea: '+e.getLineNumber());	
		} 
        
        system.debug('debuggAPI' +' '+ fcsd);
		return fcsd;   
    }
    
    public static classpignorados BuscarIdentidad(string id_pign) {
       if (id_pign==null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe Ingresar una identidad para realizar la respectiva busqueda'));   
        }  
        
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);           
        request.setEndpoint(url + 'api/IdentidadPign/'+ id_pign);
        classpignorados fcsd = new classpignorados();
        string respuesta = '';
        system.debug('Entro al REST del EDC');
        try{           
            system.debug('Estoy dentro de EDC');
            system.debug('Y mi request es '+request);
            HttpResponse response = http.send(request);
            system.debug('Cargue la respuesa en el response');
            respuesta = response.getBody();
            system.debug('Respuesta: desde sysde: '+respuesta); 
            if (response.getStatusCode() == 200) {
                fcsd = (classpignorados)System.JSON.deserialize(response.getBody(), classpignorados.class);         
            }
		}Catch(Exception e){
			system.debug('Error: '+e.getMessage()+', Linea: '+e.getLineNumber());	
		} 
        
        system.debug('debuggAPI' +' '+ fcsd);
		return fcsd;   
    }
    
    
   public static string ActualizarPignorados(classActualizaPignorados claseEnvio){
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);   
        request.setEndpoint(url + 'api/actualizapignorados');
		
		String respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
						
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);
            system.debug('Estoy dentro de EDC');
            system.debug('Y mi request es '+request);
			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            system.debug('Respuesta desde sysde: '+ respuesta);      
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return respuesta; 
        
   }
	
}