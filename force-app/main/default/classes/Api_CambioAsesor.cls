public class Api_CambioAsesor {

    public class classRespuestaCambioAsesor
    {
        public string Certificado { get; set; }
        public string Mensaje { get; set; }
        public string nEmpresa { get; set; }
        public string nombreCliente { get; set; }
        public string nombreAsesoractual { get; set; }
        public string nombreAsesornuevo { get; set; }
        
        //agregado 
        public list<CambioAsesor__c> ModificarEstado {get;set;}
        public integer sizeModi {get;set;}
        public integer sizeResu {get;set;}
       // public list<CambioAsesor__c> Carga {get;set;}
        public integer idCarga {get;set;}

    }
    
 /*      public class Prueba
    {
        public List<classRespuestaCambioAsesor> PruebaAse {get; set;}      
    } */
        
    public static list<classRespuestaCambioAsesor> CambioAsesor(enviarCambioAsesor claseEnvio)
    {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/CambioAsesor');
        
        classRespuestaCambioAsesor fcsd= new classRespuestaCambioAsesor(); //agregado 10042019
        list<classRespuestaCambioAsesor> resultado = new list<classRespuestaCambioAsesor>();
		
		String respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
			 			
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
			HttpResponse response/*= http.send(request)*/;
	    	//respuesta = response.getBody();
            if(test.isRunningTest())
            { 
                respuesta='{"classRespuestaCambioAsesor":[{"Certificado":null,"Mensaje":"A"}]}';
            	fcsd = (classRespuestaCambioAsesor)System.JSON.deserialize(respuesta, classRespuestaCambioAsesor.class);
            }
            
            else{
                response = http.send(request); 
               
            }
             
            resultado = (list<classRespuestaCambioAsesor>)JSON.deserialize(response.getBody(), list<classRespuestaCambioAsesor>.class);
            
           //respuesta = String.valueOf(resultado);
           //system.debug('Respuesta'+ resultado);
           //system.debug('Respuesta_texto '+ respuesta); 
                      
            fcsd.sizeResu = resultado.size();
            
            CambioAsesor__c carga = new CambioAsesor__c ();             
            carga = [select Identificador_Carga__c from CambioAsesor__c order by Identificador_Carga__c desc limit 1] ;
            fcsd.idCarga = integer.valueOf(carga.Identificador_Carga__c);   
                       
            fcsd.ModificarEstado  = [select Situaci_n__c, NoCuenta__c,Empresa__c , Nombre_Completo__c,Nombre_Asesor_actual__c,Nombre_asesor_nuevo__c, Identificador_Carga__c                              
                                   from CambioAsesor__c where Identificador_Carga__c =: fcsd.idCarga];
            
            fcsd.sizeModi = fcsd.ModificarEstado.size();
              for(integer i=0; i<fcsd.sizeModi; i++)
              {
                for(integer k=0; k<fcsd.sizeResu; k++)
                {
                	if(fcsd.ModificarEstado[i].NoCuenta__c == resultado[k].Certificado)
                	{
                        fcsd.ModificarEstado[i].Situaci_n__c = resultado[k].Mensaje;
                        fcsd.ModificarEstado[i].Empresa__c = resultado[k].nEmpresa;
                        fcsd.ModificarEstado[i].Nombre_Completo__c = resultado[k].nombreCliente;
                        fcsd.ModificarEstado[i].Nombre_Asesor_actual__c = resultado[k].nombreAsesoractual;
                        fcsd.ModificarEstado[i].Nombre_asesor_nuevo__c = resultado[k].nombreAsesornuevo;	
                    }
                }
            }            
             update fcsd.ModificarEstado;
			/*	for(integer i=0; i<resultado.size(); i++)
            {
				CambioAsesor__c ModificarEstado = new CambioAsesor__c();
                
                ModificarEstado  = [select Situaci_n__c, Empresa__c , Nombre_Completo__c,Nombre_Asesor_actual__c,Nombre_asesor_nuevo__c                                  
                                   from CambioAsesor__c 
                                    where NoCuenta__c =: resultado[i].Certificado ];
                	
                ModificarEstado.Situaci_n__c = resultado[i].Mensaje;
                ModificarEstado.Empresa__c = resultado[i].nEmpresa;
                ModificarEstado.Nombre_Completo__c = resultado[i].nombreCliente;
         		ModificarEstado.Nombre_Asesor_actual__c= resultado[i].nombreAsesoractual;
                ModificarEstado.Nombre_asesor_nuevo__c=  resultado[i].nombreAsesornuevo;
                
            //   update ModificarEstado;     
           }Fin del for principal*/	            
            
		}/*catch(System.CalloutException e){
			system.debug(e.getMessage());	
        }*/
        
        Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return resultado;   
    }    
    
         
 	//PARA ACTUALIZAR CAMBIO DE ASESOR 02072019 
 	public static list<classRespuestaCambioAsesor> actualizaCambioAsesor(enviarCambioAsesor claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/ActualizarCambioAsesor');
		
		String respuesta = '';
		system.debug('Entro al REST del EDC');
        	//classRespuestaCambioAsesor fcsd= new classRespuestaCambioAsesor(); 
        	list<classRespuestaCambioAsesor> resultado = new list<classRespuestaCambioAsesor>();
		try{
						
                        
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
		    HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
          
            system.debug(respuesta);  
            
            //resultado = (List<classRespuestaCambioAsesor>)JSON.deserialize(RestContext.request.requestBody.toString(), List<classRespuestaCambioAsesor>.class);
            
            
            
            respuesta = String.valueOf(resultado);
            
		}/*catch(System.CalloutException e){
			system.debug(e.getMessage()+ ' LINEA ' + E.getLineNumber());
	
        }*/Catch(Exception e){
			system.debug(e.getMessage()+ ' LINEA ' + E.getLineNumber());	
		} 
		return resultado;   
    }	
    //public static list<classRespuestaCambioAsesor> CambioAsesor(enviar_CambioAsesor claseEnvio){
	/*public static list<classRespuestaCambioAsesor> actualizaCambioAsesor(enviarCambioAsesor claseEnvio)
     {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
        request.setEndpoint(url + 'api/ActualizarCambioAsesor');
		
		String respuesta = '';
         
        classRespuestaCambioAsesor fcsd= new classRespuestaCambioAsesor(); 
        list<classRespuestaCambioAsesor> resultado = new list<classRespuestaCambioAsesor>();
         
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
            
            resultado = (list<classRespuestaCambioAsesor>)JSON.deserialize(response.getBody(), list<classRespuestaCambioAsesor>.class);
            
            respuesta = String.valueOf(resultado);
            system.debug('Respuesta'+ resultado);
            system.debug('Respuesta_texto '+ respuesta); 
           
            fcsd.sizeResu = resultado.size();
            
            
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return resultado;   
     }*/
    
    //DENEGAR
    public static list<classRespuestaCambioAsesor> BitacoraDCambioAsesor(enviarCambioAsesor claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/BitacoraCambioAsesor');
		
		String respuesta = '';
		system.debug('Entro al REST del EDC');
        	classRespuestaCambioAsesor fcsd= new classRespuestaCambioAsesor(); 
        	list<classRespuestaCambioAsesor> resultado = new list<classRespuestaCambioAsesor>();
		try{
						
                        
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
			/*HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            system.debug(respuesta);  
            
            //resultado = (List<classRespuestaCambioAsesor>)JSON.deserialize(RestContext.request.requestBody.toString(), List<classRespuestaCambioAsesor>.class);
            */
            //aqui
            HttpResponse response/*= http.send(request)*/;
	    	//respuesta = response.getBody();
            if(test.isRunningTest())
            { 
                respuesta='{"classRespuestaCambioAsesor":[{"Certificado":null,"Mensaje":"A"}]}';
            	fcsd = (classRespuestaCambioAsesor)System.JSON.deserialize(respuesta, classRespuestaCambioAsesor.class);
            }
            
            else{
                response = http.send(request); 
               
            }
             
            resultado = (list<classRespuestaCambioAsesor>)JSON.deserialize(response.getBody(), list<classRespuestaCambioAsesor>.class);
            //fin
                
            
            respuesta = String.valueOf(resultado);
            
		}/*catch(System.CalloutException e){
			system.debug(e.getMessage()+ ' LINEA ' + E.getLineNumber());
	
        }*/Catch(Exception e){
			system.debug(e.getMessage()+ ' LINEA ' + E.getLineNumber());	
		} 
		return resultado;   
    }
    
    /*public static list<classRespuestaCambioAsesor> BitacoraDCambioAsesor(enviarCambioAsesor claseEnvio)
     {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
        request.setEndpoint(url + 'api/BitacoraCambioAsesor');
		
		String respuesta = '';
         
        classRespuestaCambioAsesor fcsd= new classRespuestaCambioAsesor(); 
        list<classRespuestaCambioAsesor> resultado = new list<classRespuestaCambioAsesor>();
         
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
            
            resultado = (list<classRespuestaCambioAsesor>)JSON.deserialize(response.getBody(), list<classRespuestaCambioAsesor>.class);
              
            //List<classRespuestaCambioAsesor> delegationMap = (List<classRespuestaCambioAsesor>)JSON.deserialize(RestContext.request.requestBody.toString(), List<classRespuestaCambioAsesor>.class); 
			//resultado = (List<classRespuestaCambioAsesor>)JSON.deserialize(RestContext.request.requestBody.toString(), List<classRespuestaCambioAsesor>.class); 
         	
            /*if (response.getStatusCode() == 200) 
            {
                prueba prueba2= new prueba();
                //system.debug('Sysde'+response.getBody());
                prueba2 = (prueba) JSON.deserialize(response.getBody(), prueba.class);
               	resultado = prueba2.PruebaAse;
                system.debug('ResultadoPrueba2' + resultado);
              
	        }*/
    /*        respuesta = String.valueOf(resultado);
            system.debug('Respuesta'+ resultado);
            system.debug('Respuesta_texto '+ respuesta); 
           
            fcsd.sizeResu = resultado.size();
            
            
		}catch(System.CalloutException e){
			system.debug(e.getMessage() + ' LINEA ' + E.getLineNumber());
	
        }Catch(Exception e){
			system.debug(e.getMessage() + ' LINEA ' +E.getLineNumber());	
		} 
		return resultado;   
     }   */      	   
    
    
   
}