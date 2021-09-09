public class controllerApiClienteNatural {
    public static String guardarCliente(ClienteNaturales claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/insertaClienteNatural');
		
		String respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
						
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);
            HttpResponse response = new HttpResponse();
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setBody('Proceso realizado Correctamente');
            }
	    	respuesta = response.getBody();
            system.debug(respuesta);      
		}Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return respuesta;   
    }
   
    public static String actualizaCliente(NaturalActualizar claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/actualizaClienteNatural');
		
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
    
    public static String urlSysde(String ambiente){
        try{
            return [Select URL__c From URL_conexion_Sysde__mdt Where DeveloperName =: ambiente].URL__c;
            
        }Catch(Exception e){
            return null;
        }
    }
    
    public class classPersona{
        	public String id{ get; set; }
    }
    
    public class Prueba {
        public List<classRespuestaAportesCuenta> aportes {get; set;}
       
    }
    
    public static list<classRespuestaAportesCuenta> ConsultalAportesPatronales(string identificacionPersona) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = controllerApiClienteNatural.urlSysde('Test');
        request.setEndpoint(url + 'api/planillas/cuentas');
        request.setMethod('POST');
		request.setTimeout(120000);
		list<classRespuestaAportesCuenta> resultado = new list<classRespuestaAportesCuenta>();
		list<claseaportaciones> clientes = new list<claseaportaciones>();
		
		try{
            
            list<ClassPersona> claseEnvio = new list<ClassPersona>();
				ClassPersona nueva = new ClassPersona();
				nueva.id = identificacionPersona;
				claseEnvio.add(nueva);	
			
			 list<string> Cuentas = new list<string>();
             list<Cuentas__C> listClientes2 = new list<Cuentas__C>();
                
                classJson envio = new classJson();
                envio.contenido = JSON.serialize(claseEnvio);
                String cons = 'contenido=' + envio.contenido;
                system.debug(cons);
                request.setBody(cons);
                HttpResponse response = http.send(request);
                system.debug('Respuesta Sysde '+response.getBody());
                
            if (response.getStatusCode() == 200) 
            {
                prueba prueba2= new prueba();
                //system.debug('Sysde'+response.getBody());
                prueba2 = (prueba) JSON.deserialize(response.getBody(), prueba.class);
               	resultado = prueba2.aportes;
              
	        }
	     
            list<Account> idsalesforce = new list<Account> ();
         
	    }catch(System.CalloutException e){
	    		system.debug('Error al hacer la consulta: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());   
        }Catch(Exception e){
        		system.debug('Error al traer persona: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
        }
         return resultado;
        //return null;
    }
    
	public static classListas consultaListas(string pcnroid) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/validar/'+ pcnroid);
		classListas fcsd= new classListas();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            system.debug('Resultado: '+respuesta); 
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
    
    public static ClienteNaturales ConsultaColectiva(string pccontratocolectivo) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/consultaColectiva/'+ pccontratocolectivo);
		ClienteNaturales fcsd= new ClienteNaturales();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsd = (ClienteNaturales)System.JSON.deserialize(response.getBody(), ClienteNaturales.class);         
	        }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         system.debug('debuggAPICO' +' '+ fcsd);
		 return fcsd;   
    }
    
    public static ClienteNaturales ConsultaInfoCliente(String pccontratocolectivo, String pcnroid) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaInfoCliente/'+ pccontratocolectivo + '/' + pcnroid);
		ClienteNaturales fcsd= new ClienteNaturales();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            respuesta = respuesta.replace('"[', '[');
            respuesta = respuesta.replace(']"', ']');
            respuesta = respuesta.replace('\\"','"');
            
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
           {
                
	            fcsd = (ClienteNaturales)System.JSON.deserialize(respuesta, ClienteNaturales.class);
               
           }
            
		}catch(System.CalloutException e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());
	
        }Catch(Exception e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());	
		} 
        
        system.debug('debuggAPI' +' '+ fcsd);
		return fcsd;   
    }
    
    public static ClienteNaturales ConsultaInfoClienteC(String pc_codCuenta) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaInfoClienteC/'+ pc_codCuenta);
		ClienteNaturales fcsd= new ClienteNaturales();
        list<beneficiario> bene = new list<beneficiario>();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            respuesta = respuesta.replace('"[', '[');
            respuesta = respuesta.replace(']"', ']');
            respuesta = respuesta.replace('\\"','"');
            respuesta = respuesta.replace('\"','"');
            respuesta = respuesta.replace(':"T00:00:00"',':null');
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta: ' + respuesta); 
            
            if (response.getStatusCode() == 200) 
           {
                
	            fcsd = (ClienteNaturales)System.JSON.deserialize(respuesta, ClienteNaturales.class);
               
           }
            
		}catch(System.CalloutException e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());
	
        }Catch(Exception e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());	
		} 
        
        
        system.debug('debuggAPI' +' '+ fcsd);
		return fcsd;   
    }
    
    public static String ConsultaInfoClientePDF(String pc_codCuenta) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaInfoClienteC/'+ pc_codCuenta);
		ClienteNaturales fcsd= new ClienteNaturales();
        list<beneficiario> bene = new list<beneficiario>();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            respuesta = respuesta.replace('"[', '[');
            respuesta = respuesta.replace(']"', ']');
            respuesta = respuesta.replace('\"','"');
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
           {
                
	            fcsd = (ClienteNaturales)System.JSON.deserialize(respuesta, ClienteNaturales.class);
               
           }
            
		}catch(System.CalloutException e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());
	
        }Catch(Exception e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());	
		} 
        
        system.debug('debuggAPI' +' '+ fcsd);
		return respuesta;   
    }
    
    public class classRespuestaAportesCuenta{
            public String identificacion { get; set; }
            public List<classAportesCuenta> cuentas { get; set; }
        }

    public class classAportesCuenta{
    	public String cuenta { get; set; }
        public Decimal aportePersonal { get; set; }
        public Decimal aportePatronal { get; set; }
    } 
    
    public class classPersonas{
		public String identidad { get; set; }
        public String tipoIdentificacion { get; set; }
        public String idCliente { get; set; }
        public String primerNombre { get; set; }
        public String segundoNombre { get; set; }
        public String primerApellido { get; set; }
        public String segundoApellido { get; set; }
        public DateTime fechaNacimiento { get; set; }
        public String sexo { get; set; }
        public String correo { get; set; }
        public String estadoCivil { get; set; }
        public List<classCuenta> cuentas { get; set; }
  }
    
    //API LOGIN MENU 
    public class classMenu{
       public string nombreVisible { get; set; }
       public string nombreMetodo { get; set; }
       public string rol { get; set; }
       public Boolean permiteInsertar { get; set; }
       public Boolean permiteActualiar { get; set; }
       public Boolean permiteConsultar { get; set; }
   }  
        
    public class classRespuestaMenu{
        public string nombreVisible { get; set; }
        public string nombreMetodo { get; set; }
        public string rol { get; set; }
        public Boolean permiteInsertar { get; set; }
        public Boolean permiteActualiar { get; set; }
        public Boolean permiteConsultar { get; set; } 
        //public List<classMenu> Pantallas { get; set; }
    }

    public class PruebaMenu {
        public List<classRespuestaMenu> PantallasList {get; set;}      
    }    

    //Metodo 2 para recibir las pantallas
	public static list<classRespuestaMenu> ConsultaPantallas2(string usuario) {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/menu/'+ usuario);
	    list<classRespuestaMenu> resultado = new list<classRespuestaMenu>();
         
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) 
            {
                
               // PruebaMenu prueba23= new PruebaMenu();
                resultado = (list<classRespuestaMenu>)JSON.deserialize(response.getBody(), list<classRespuestaMenu>.class);
                system.debug('ConversionResultadoPrueba2' + resultado);
             
	        }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         
		return resultado;   
    }
    
      public static ClienteNaturales codClienteConsulta(string codCuenta) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/muestraCodCliente/'+ codCuenta);
		ClienteNaturales fcsd= new ClienteNaturales();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsd = (ClienteNaturales)System.JSON.deserialize(response.getBody(), ClienteNaturales.class);         
	        }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         system.debug('debuggAPICO' +' '+ fcsd);
		 return fcsd;   
    }
    
    
    
}