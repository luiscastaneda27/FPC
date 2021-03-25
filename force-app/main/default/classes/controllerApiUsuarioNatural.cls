public class controllerApiUsuarioNatural {

    public static String estadoCuentaCorreo(classUsuarioNatural claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/usuarionatural');
		
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
    
    /*public static list<String> ConsultaListas(string identidad) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/validar/'+ identidad);
		list<string> fcsd= new list<string>();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            fcsd = respuesta.split(',');
            system.debug(respuesta);      
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsd;   
    }*/
    
    public static classUsuarioNatural BuscarUsuarioNatural(string identidad) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/usuarionatural/'+ identidad);
		classUsuarioNatural fcsd= new classUsuarioNatural();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsd = (classUsuarioNatural)System.JSON.deserialize(response.getBody(), classUsuarioNatural.class);         
	        }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsd;   
    }
    
    public static classListas consultaListas(string identidad) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/validar/'+ identidad);
		classListas fcsd= new classListas();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsd = (classListas)System.JSON.deserialize(response.getBody(), classListas.class);         
	        }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsd;   
    }
}