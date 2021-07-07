public class ControllerAPIPagoIntereses {

    
    public static String INSERTA_BITACORA(classBitacora bitacora) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/Insertar_bitacora');
		
		String respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
						
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(bitacora);
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
    
    public static classPagoInteresesFPC BuscarCuenta(string Cuenta) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/TraerInfo/'+ Cuenta);
        system.debug(Cuenta); 
		classPagoInteresesFPC fcsds= new classPagoInteresesFPC();
		string respuesta = '';
		system.debug('Entro al REST del BuscarCuenta');
		try{

			HttpResponse response =new HttpResponse();//
	    	if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setBody('{"Cuenta":"25573","NombreCompleto":"FATIN SIHAM GABRIE GABRIE","Identidad":"0501-1974-01724","TipoFondo":"101","CausaDescripcion":"AFILIACION POR SOLICITUD","CodigoCausa":"01","EstadoCuenta":"A","Tipodepago":"Fijo","Montodepago":"2000","Ajuste":null,"Diadepago":"13","Formadepago":"CK","Bancos":null,"Nocuenta":null,"Tipodecuenta":null,"EstadoAprobacion":"A","Fec_inclusion":null,"TotalFondo":null,"CantidadPignorada":null,"Moneda":"01","fechaHasta":null,"Imagen_respaldo":null,"pagoach":null,"pagocheque":null,"Tocarcapital":"Si","cheque":"Si","tsp":"No","ach":"No"}');
                response.setStatusCode(200);
            }
            respuesta = response.getBody();
            //fcsd = respuesta.split(',');
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsds = (classPagoInteresesFPC)System.JSON.deserialize(response.getBody(), classPagoInteresesFPC.class);         
	        }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsds;   
    }
    
    public static classPagoInteresesFPC BuscarCuenta2(string Cuenta) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/TraerInfo2/'+ Cuenta);
        system.debug(Cuenta); 
		classPagoInteresesFPC fcsd= new classPagoInteresesFPC();
		string respuesta = '';
		system.debug('Entro al REST del BuscarCuenta2 ');
		try{
			
			HttpResponse response =new HttpResponse();//
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setBody('{"Cuenta":"25573","NombreCompleto":"FATIN SIHAM GABRIE GABRIE","Identidad":"0501-1974-01724","TipoFondo":"101","CausaDescripcion":"AFILIACION POR SOLICITUD","CodigoCausa":"01","EstadoCuenta":"A","Tipodepago":"Fijo","Montodepago":"2000","Ajuste":null,"Diadepago":"13","Formadepago":"CK","Bancos":null,"Nocuenta":null,"Tipodecuenta":null,"EstadoAprobacion":"A","Fec_inclusion":null,"TotalFondo":null,"CantidadPignorada":null,"Moneda":"01","fechaHasta":null,"Imagen_respaldo":null,"pagoach":null,"pagocheque":null,"Tocarcapital":"Si","cheque":"Si","tsp":"No","ach":"No"}');
                response.setStatusCode(200);
            }
            
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsd = (classPagoInteresesFPC)System.JSON.deserialize(response.getBody(), classPagoInteresesFPC.class);         
	        }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsd;   
    }

    public static String INSERTAINFO(classPagoInteresesFPC claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/InsertarPago');
		
		String respuesta = '';
		system.debug('Entro al REST del INSERTAINFO');
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
    
    public static String MODIFICARINFO(classPagoInteresesFPC claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/ModificarPago');
		
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
    /*
     public static classPagoInteresesFPC AlertaDenegados(string Cuenta) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/TraerInfo/'+ Cuenta);
        system.debug(Cuenta); 
		classPagoInteresesFPC fcsdss= new classPagoInteresesFPC();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsdss = (classPagoInteresesFPC)System.JSON.deserialize(response.getBody(), classPagoInteresesFPC.class);         
	        }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsdss;   
    }*/
    
    public class RespuestaImagen{
        public string pc_Imagen { get; set; }
        public string Cod_referencia { get; set; }
        public string p_Error { get; set; }
    }
    
    public class classImagenReferencia{
        public string Referencia { get; set; }
        public string Imagen { get; set; }
    }
    
    public static classImagenReferencia GuardarImagen (classImagenReferencia claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type','application/x-www-form-urlencoded');
		request.setTimeout(120000);
		//request.setEndpoint(url + 'api/GuardarImagen/');
		//request.setEndpoint(url + 'api/RegistrarImagen/');
		request.setEndpoint(url + 'api/conciliacion/');
		
        classImagenReferencia fcsd= new classImagenReferencia();
		//string respuesta = '';
         
		system.debug('Entro al REST del EDC '+claseEnvio.Imagen.length());
		try{
						
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
            
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
			HttpResponse response = http.send(request);
	    	
           // respuesta = response.getBody();
            fcsd = (classImagenReferencia)System.JSON.deserialize(response.getBody(), classImagenReferencia.class);   
            
           // system.debug(respuesta);      
		}/*catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }*/Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsd;   
    }
    
     public static classRespuestaImagen TraerImagenBD(string CodReferencia) {   
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		//request.setEndpoint(url + 'api/conciliacionObtener/'+ CodReferencia);
		request.setEndpoint(url + 'api/conciliacion/'+ CodReferencia);
		classRespuestaImagen fcsd= new classRespuestaImagen();
		//string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	//respuesta = response.getBody();
            //system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsd = (classRespuestaImagen)System.JSON.deserialize(response.getBody(), classRespuestaImagen.class); 
                system.debug('Lista Paola '+ fcsd);
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