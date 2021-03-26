public class controllerAPIinteresAprobados {
    //ESTA PARTE TRAERA LA INFORMACION REGISTRADA DE PAGO DE APORTES
    public static String pagaInteres(classAdmInteres_2 claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/pagaInteres');
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
            system.debug('debuggRespuesta' +''+ respuesta); 
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return respuesta;   
    }
    
    public static classAdmInteres TraerRegistrados3() {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/TraerRegistrados');
        //system.debug(Cuenta); 
		classAdmInteres fcsd= new classAdmInteres();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            system.debug('Entro al try del EDC'+respuesta);
            //fcsd = respuesta.split(',');
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsd = (classAdmInteres)System.JSON.deserialize(response.getBody(), classAdmInteres.class);         
	        }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsd;   
    }//Registrados y aprobados
    public static classAdmInteres TraerRegistrados2(string diaSF) {        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/TraerRegistrados2/'+ diaSF);
        
		classAdmInteres jfsf= new classAdmInteres();
		string respuesta = '';
		system.debug('Entro al REST del EDC'+jfsf);
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            jfsf = (classAdmInteres)System.JSON.deserialize(response.getBody(), classAdmInteres.class);         
	        }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return jfsf;    
    }//Registrados por dias de pago
    public static classAdmInteres TraerRegistrados() {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/TraerRegistrados');
        //system.debug(Cuenta); 
		classAdmInteres fcsd= new classAdmInteres();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            system.debug('Entro al try del EDC'+respuesta);
            //fcsd = respuesta.split(',');
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsd = (classAdmInteres)System.JSON.deserialize(response.getBody(), classAdmInteres.class);         
	        }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsd;   
    }//Normal Registrados Con estado/sin estado
    //METODO POR FECHA DE REGISTRO
    public static classAdmInteres TRAE_DENEGADOS() {        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/TraerDenegados');
        
		classAdmInteres jfsf= new classAdmInteres();
		string respuesta = '';
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            jfsf = (classAdmInteres)System.JSON.deserialize(response.getBody(), classAdmInteres.class);         
	        }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return jfsf;    
    }//Registrados por dias de pago
    
         public static classRespuestaImagen TraerImagenBD(string CodReferencia) {   
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/conciliacionObtener/'+ CodReferencia);
		classRespuestaImagen fcsd= new classRespuestaImagen();
		//string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	//respuesta = response.getBody();
          //  system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsd = (classRespuestaImagen)System.JSON.deserialize(response.getBody(), classRespuestaImagen.class);         
	        }
		}/*catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }*/Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsd;   
    }
    
    public class classRespuestaImagen{
        public integer codigo { get; set; }
        public string mensaje { get; set; }
        public string imagen { get; set; }
    }



}