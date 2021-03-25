public class APIClienteJuridico {

    //METODO POR EL CUAL SE GUARDARA LA INFORMACION DEL CLIENTE JURIDICO
    
     public static String guardarCliJuridico(ClassPantJuridicoProduc claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/insertaClienteJuridico');
		
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
    
     public static ClassPantJuridicoProduc ConsultaInfoCliente(String pccuenta) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
        system.debug('ContenidoCuenta'+ pccuenta);
        request.setEndpoint(url + 'api/ConsultaInfoClienteJ/'+ pccuenta );
		ClassPantJuridicoProduc fcsd= new ClassPantJuridicoProduc();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
           {
                
	            fcsd = (ClassPantJuridicoProduc)System.JSON.deserialize(response.getBody(), ClassPantJuridicoProduc.class);
               
           }
            
		}catch(System.CalloutException e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());
	
        }Catch(Exception e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());	
		} 
        
        system.debug('debuggAPI' +' '+ fcsd);
		return fcsd;   
    }
     
    // Consulta El Socio Desde la BD atarvez del numero de ID 
    
    public static classBeneficiariosJuri Consulta_Socio(string pcnumeroidsocc) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaSocio/'+ pcnumeroidsocc  );
		classBeneficiariosJuri fcsd= new classBeneficiariosJuri();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
           {
                
	            fcsd = (classBeneficiariosJuri)System.JSON.deserialize(response.getBody(), classBeneficiariosJuri.class);
               
           }
            
		}catch(System.CalloutException e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());
	
        }Catch(Exception e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());	
		} 
        
        system.debug('debuggAPI' +' '+ fcsd);
		return fcsd;   
    }    
    
     public static ClassPantJuridicoProduc ConsultaInfoClienteC(String pccuenta, string idclienbuscar) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
        //system.debug('ContenidoCuenta'+ pccuenta+ idclienbuscar);
        //system.debug('ContenidoCuenta'+ idclienbuscar);
        //request.setEndpoint(url + 'api/ConsultaInfoClienteJ/'+ pccuenta + idclienbuscar);
        request.setEndpoint(url + 'api/ConsultaInfoClienteJu/'+ pccuenta + '/'+ idclienbuscar); 
		ClassPantJuridicoProduc fcsd= new ClassPantJuridicoProduc();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
           {
                
	            fcsd = (ClassPantJuridicoProduc)System.JSON.deserialize(response.getBody(), ClassPantJuridicoProduc.class);
               
           }
            
		}catch(System.CalloutException e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());
	
        }Catch(Exception e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());	
		} 
        
        system.debug('debuggAPI' +' '+ fcsd);
		return fcsd;   
    }
    
    ///Class
    public class classBeneficiariosJuri
    {
        public string pnnrocertificado { get; set; }
        public string pcnumeroidsoc { get; set; }
        public string nombresocio { get; set; }
        public string tipo_persona { get; set; }
        public string nacionalidad { get; set; }
        public Decimal POR_PART_DIRECT { get; set; }
        public Decimal POR_PART_INDIRECT { get; set; }
        public string DIRECCION { get; set; }
        public string TIN { get; set; }
        public string NIVEL { get; set; }
        public string COT_BOLSA { get; set; }
        public string TIC_SYMBOL { get; set; }
        public string NUMERO_ID_EMPRESA { get; set; }
           }

        ///firmantes
     public static firmantesJuri Consulta_Firmante(string IDENT) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaFirmante/'+ IDENT  );
		firmantesJuri fcsd= new firmantesJuri();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
           {
                
	            fcsd = (firmantesJuri)System.JSON.deserialize(response.getBody(), firmantesJuri.class);
               
           }
            
		}catch(System.CalloutException e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());
	
        }Catch(Exception e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());	
		} 
        
        system.debug('debuggAPI' +' '+ fcsd);
		return fcsd;   
    }    
    
    
    ///Class
   public class firmantesJuri
    {
        public string COD_PERSONA { get; set; }
        public string NOMBRE { get; set; }
        public string CARGO { get; set; }

    }
    // final firmantes
    
    
    public static String actualizaCliente(ClassPantJuridicoProduc claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/actualizaClienteJuridico');
		
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
   
    
    
    
    
}