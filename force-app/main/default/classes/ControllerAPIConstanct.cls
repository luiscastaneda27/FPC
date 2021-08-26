public class ControllerAPIConstanct {

    public static list<classCorreosAniversario> GetCorreosAniversarioM ( ) 
    {
    	Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
        request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/GetCorreosAniverHombres');
        
	    list<classCorreosAniversario> resultado = new list<classCorreosAniversario>();
        
        string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
			if(!test.isRunningTest())
            {
                HttpResponse response = http.send(request);
                respuesta = response.getBody();
                system.debug('Respuesta Sysde '+response.getBody());
                
                if (response.getStatusCode() == 200) 
                {
                     resultado = (list<classCorreosAniversario>)JSON.deserialize(response.getBody(), list<classCorreosAniversario>.class);
                }
            }
            else
            {
                classCorreosAniversario mo = new classCorreosAniversario();
                mo.P_ERROR = 'qw';
                mo.P_FechaInclusion = date.today();
                mo.V_APELLIDO = 'sadsad';
                mo.V_FO_Correo = 'asdsad';
                mo.V_FO_Servidor = 'asdasd';
                mo.V_FOCuenta = 'asdsad';
                mo.V_FoDias = 12;
                mo.V_FOVacio = 'asdasdsa';
                mo.V_NOMBRE = 'asdsad';
                resultado.add(mo);
                
                Correo_Personas_Sin_Aportar_Temp__c nu = new Correo_Personas_Sin_Aportar_Temp__c();
                nu.Codigo_Cliente__c = '125478';
                nu.Correo_Temp__c= 'acerrato@hotmail.com';
                nu.Nombre__c = 'acerrato';          
                insert nu;  
            }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         
		return resultado;   
    }
    
      /*1.2) Envío de correo de aniversario cada vez que la persona cumpla un año más en el fondo de pensión.*/

     /*
          Muestra todos los correos validos Donde el SEXO = f 
     */
    public static list<classCorreosAniversario> GetCorreosAniversarioF ( ) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
        request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/GetCorreosAniverMujeres');
        
	    list<classCorreosAniversario> resultado = new list<classCorreosAniversario>();
        
        string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
			if(!test.isRunningTest())
            {
                HttpResponse response = http.send(request);
                respuesta = response.getBody();
                system.debug('Respuesta Sysde '+response.getBody());
                
                if (!test.isRunningTest()) 
                {
                 
                     resultado = (list<classCorreosAniversario>)JSON.deserialize(response.getBody(), list<classCorreosAniversario>.class);
                    
                     //system.debug('ConversionResultadoPrueba2' + resultado);
      
                } //Fin del if
           }    
            else
            {
                 classCorreosAniversario mo = new classCorreosAniversario();
                    mo.P_ERROR = 'qw';
                    mo.P_FechaInclusion = date.today();
                    mo.V_APELLIDO = 'sadsad';
                    mo.V_FO_Correo = 'asdsad';
                    mo.V_FO_Servidor = 'asdasd';
                    mo.V_FOCuenta = 'asdsad';
                    mo.V_FoDias = 12;
                    mo.V_FOVacio = 'asdasdsa';
                    mo.V_NOMBRE = 'asdsad';
                    resultado.add(mo); 
            }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         
		return resultado;   
    }
    
   
    /*2) ENVIO DE CORREO A LAS PERSONAS CUANDO REALIZAN SU PRIMER APORTE.*/

    /*
          Muestra todos los correos validos
    */
    public static list<classCorreosAniversario> GetCorreosKitBienvenida ( ) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
        request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/CorreoBienvenida');
        
	    list<classCorreosAniversario> resultado = new list<classCorreosAniversario>();
        
        string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
			if(!test.isRunningTest())
            {
                HttpResponse response = http.send(request);
                respuesta = response.getBody();
                system.debug('Respuesta Sysde '+response.getBody());
                if (response.getStatusCode() == 200) {
                    resultado = (list<classCorreosAniversario>)JSON.deserialize(response.getBody(), list<classCorreosAniversario>.class);
                } 
            }else{
                classCorreosAniversario mo = new classCorreosAniversario();
                mo.P_ERROR = 'qw';
                mo.P_FechaInclusion = date.today();
                mo.V_APELLIDO = 'sadsad';
                mo.V_FO_Correo = 'asdsad';
                mo.V_FO_Servidor = 'asdasd';
                mo.V_FOCuenta = 'asdsad';
                mo.V_FoDias = 12;
                mo.V_FOVacio = 'asdasdsa';
                mo.V_NOMBRE = 'asdsad';
                resultado.add(mo);
            }
            
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         
		return resultado;   
    }
  
    
    /* 3.1) -ENVIO DE CORREO A TODAS LAS PERSONAS AFILIADAS Y QUE TIENEN SIN APORTAR MAS DE 6 MESES.
          -Muestra todos los correos validos
		  -Donde sean Hombres
     

   
     public static list<classCorreosAniversario> GetCorreoSinAportarMesesMujeres ( ) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
        request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/GetCorreosSinAportarMujeres');
        
	    list<classCorreosAniversario> resultado = new list<classCorreosAniversario>();
        list<classCorreosAniversario> resultadoEnviar = new list<classCorreosAniversario>(); 
        
        string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
			if(!test.isRunningTest())
            {
               HttpResponse response = http.send(request);
            respuesta = response.getBody();
            system.debug('Respuesta Sysde '+response.getBody());
            
            if (response.getStatusCode() == 200) 
            {
             
                 resultado = (list<classCorreosAniversario>)JSON.deserialize(response.getBody(), list<classCorreosAniversario>.class);
                
				 //system.debug('ConversionResultadoPrueba2' + resultado);
  
	        } //Fin del if
            
             list<Correo_Personas_Sin_Aportar_Temp__c> EstadoCu = new list<Correo_Personas_Sin_Aportar_Temp__c>();
            
            Correo_Personas_Sin_Aportar_Temp__c listC;
            map<string, integer> Bandera= new map<string, integer>();
            
                 
            for(integer i=0; i<resultado.size(); i++)
            {   		
               
                if(!Bandera.containsKey(resultado[i].V_FOCuenta))
                {
 					 listc = new Correo_Personas_Sin_Aportar_Temp__c();    
                     listc.Codigo_Cliente__c = resultado[i].V_FOCuenta.Trim();
                     listc.Correo_Temp__c = resultado[i].V_FO_Correo;
                     listc.Nombre__c = resultado[i].V_NOMBRE + ' '+ resultado[i].V_APELLIDO;
                     EstadoCu.add(listc);                   
                    bandera.put(resultado[i].V_FOCuenta, 3);
                }    
                                       
            } //Fin del for principal                              
             
            
            insert EstadoCu;                           
            }
            else
            {
                classCorreosAniversario mo = new classCorreosAniversario();
                mo.P_ERROR = 'qw';
                mo.P_FechaInclusion = date.today();
                mo.V_APELLIDO = 'sadsad';
                mo.V_FO_Correo = 'asdsad';
                mo.V_FO_Servidor = 'asdasd';
                mo.V_FOCuenta = 'asdsad';
                mo.V_FoDias = 12;
                mo.V_FOVacio = 'asdasdsa';
                mo.V_NOMBRE = 'asdsad';
                resultado.add(mo); 
            }
            
            
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         
		return resultado;   
    }
   
  
     /* 3.2) -ENVIO DE CORREO A TODAS LAS PERSONAS AFILIADAS Y QUE TIENEN SIN APORTAR MAS DE 6 MESES.
          -Muestra todos los correos validos
		  -Donde sean Hombres
     

    public static list<classCorreosAniversario> GetCorreoSinAportarMesesHombres ( ) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
        request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/GetCorreosSinAportarHombres');
        
	    list<classCorreosAniversario> resultado = new list<classCorreosAniversario>();
        
        string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

           if(!test.isRunningTest())
            {
               HttpResponse response = http.send(request);
            respuesta = response.getBody();
            system.debug('Respuesta Sysde '+response.getBody());
            
            if (response.getStatusCode() == 200) 
            {
             
                 resultado = (list<classCorreosAniversario>)JSON.deserialize(response.getBody(), list<classCorreosAniversario>.class);
                
				 //system.debug('ConversionResultadoPrueba2' + resultado);
  
	        } //Fin del if
            
             list<Correo_Personas_Sin_Aportar_Temp__c> EstadoCu = new list<Correo_Personas_Sin_Aportar_Temp__c>();
            
            Correo_Personas_Sin_Aportar_Temp__c listC;
            
                 
            for(integer i=0; i<resultado.size(); i++)
            {   		
                		  listc = new Correo_Personas_Sin_Aportar_Temp__c();    
                          listc.Codigo_Cliente__c = resultado[i].V_FOCuenta.Trim();
                          listc.Correo_Temp__c = resultado[i].V_FO_Correo;
                          listc.Nombre__c = resultado[i].V_NOMBRE + ' '+ resultado[i].V_APELLIDO;
                          EstadoCu.add(listc);
                                       
            } //Fin del for principal                              
             
            insert EstadoCu;                           
            }
            else
            {
                classCorreosAniversario mo = new classCorreosAniversario();
                mo.P_ERROR = 'qw';
                mo.P_FechaInclusion = date.today();
                mo.V_APELLIDO = 'sadsad';
                mo.V_FO_Correo = 'asdsad';
                mo.V_FO_Servidor = 'asdasd';
                mo.V_FOCuenta = 'asdsad';
                mo.V_FoDias = 12;
                mo.V_FOVacio = 'asdasdsa';
                mo.V_NOMBRE = 'asdsad';
                resultado.add(mo); 
            }
            
            
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         
		return resultado;   
    }
   
    /*4) ENVIO DE CORREO A TODAS LAS PERSONAS CON RETIROS TOTALES .*/
    /*
          Muestra todos los correos validos
    
    
    public static list<classCorreosAniversario> GetCorreosRetirosTotales ( ) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
        request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/CorreoRetiroTotal');
        
	    list<classCorreosAniversario> resultado = new list<classCorreosAniversario>();
        
        string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
			if(!test.isRunningTest())
            {
                
          
            HttpResponse response = http.send(request);
            respuesta = response.getBody();
            system.debug('Respuesta Sysde '+response.getBody());
            
            if (response.getStatusCode() == 200) 
            {
             
                 resultado = (list<classCorreosAniversario>)JSON.deserialize(response.getBody(), list<classCorreosAniversario>.class);
	        } //Fin del if
                
           }else
           {
                classCorreosAniversario mo = new classCorreosAniversario();
                mo.P_ERROR = 'qw';
                mo.P_FechaInclusion = date.today();
                mo.V_APELLIDO = 'sadsad';
                mo.V_FO_Correo = 'asdsad';
                mo.V_FO_Servidor = 'asdasd';
                mo.V_FOCuenta = 'asdsad';
                mo.V_FoDias = 12;
                mo.V_FOVacio = 'asdasdsa';
                mo.V_NOMBRE = 'asdsad';
                resultado.add(mo);
           }
                
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         
		return resultado;   
    }
  
    
    /*Envio de correos prueba
    public static list<classCorreosAniversario> GetCorreosPruebas ( ) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
        request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/CorreoPRuebaEnviar');
        
	    list<classCorreosAniversario> resultado = new list<classCorreosAniversario>();
        
        string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

            HttpResponse response = http.send(request);
            respuesta = response.getBody();
            system.debug('Respuesta Sysde '+response.getBody());
            
            if (response.getStatusCode() == 200) 
            {
             
                 resultado = (list<classCorreosAniversario>)JSON.deserialize(response.getBody(), list<classCorreosAniversario>.class);
                
				 //system.debug('ConversionResultadoPrueba2' + resultado);
  
	        } //Fin del if
            
            for(integer i=0; i<resultado.size(); i++)
            {   		
                          Correo_Personas_Sin_Aportar_Temp__c InsertCod = new Correo_Personas_Sin_Aportar_Temp__c();      
                          InsertCod.Codigo_Cliente__c = resultado[i].V_FOCuenta.Trim();
                          InsertCod.Correo_Temp__c = resultado[i].V_FO_Correo;
                          InsertCod.Nombre__c = resultado[i].V_NOMBRE + ' '+ resultado[i].V_APELLIDO;
                          insert InsertCod; 
                                       
            } //Fin del for principal                              
            
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         
		return resultado;   
    }
    
    
    /*CLASES*/
    
    public class classCorreosAniversario
    {
        public String V_FO_Correo { get; set; }
        public String V_FO_Servidor { get; set; }
        public decimal V_FoDias { get; set; }
        public DateTime P_FechaInclusion { get; set; }
        public String V_FOCuenta { get; set; }
        public String V_NOMBRE { get; set; }
        public String V_APELLIDO { get; set; }
        public String V_FOVacio { get; set; }
        public String P_ERROR { get; set; }
    }
    
    
}