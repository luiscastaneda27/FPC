public class controllerApiUsuarioJuridico {
    
	public static String insertaUsuarioJuridico(classUsuarioJuridico claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/insertaJuridico');
		
		String respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
						
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            system.debug(respuesta);      
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return respuesta;   
    }
    
    public static classUsuarioJuridico BuscarUsuarioJuridicoC(string pc_codCuenta) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/usuariojuridicoC/'+ pc_codCuenta);
		classUsuarioJuridico fcsd= new classUsuarioJuridico();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsd = (classUsuarioJuridico)System.JSON.deserialize(response.getBody(), classUsuarioJuridico.class);         
	        }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsd;   
    }
    
    public static String actualizaJuridico(classUsuarioJuridico claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/actualizaJuridico');
		
		String respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
						
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            system.debug(respuesta);      
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return respuesta;   
    }
    
    public static classListas consultaListas(string IdRepresentanteLegal) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/validar/'+ IdRepresentanteLegal);
		classListas fcsde= new classListas();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsde = (classListas)System.JSON.deserialize(response.getBody(), classListas.class);         
	        }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsde;   
    }
    
}