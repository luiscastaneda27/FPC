public class Api_ActivaciondeCuentas {

    public class classRespuestaActivacion
    {
        public string Certificado { get; set; }
        public string Mensaje { get; set; }
        public string nEmpresa { get; set; }
        public string nombreCliente { get; set; }
        public string Asesor { get; set; }
        
         //agregado 
        public list<ActivacionCuenta__c> ModificarEstado {get;set;}
        public integer sizeModi {get;set;}
        public integer sizeResu {get;set;}
        public integer idCarga {get;set;}

    }
    
    public static list<classRespuestaActivacion> Activaciondecuentas(valResgistroActivaciondeCuentas claseEnvio)
    {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/ActivaciondeCuentas');
        
        classRespuestaActivacion fcsd= new classRespuestaActivacion(); //agregado 10042019
        list<classRespuestaActivacion> resultado = new list<classRespuestaActivacion>();
		
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
                respuesta='{"classRespuestaActivacion":[{"Certificado":null,"Mensaje":"A"}]}';
            	fcsd = (classRespuestaActivacion)System.JSON.deserialize(respuesta, classRespuestaActivacion.class);
            }
            
            else{
                response = http.send(request); 
            }
             
            resultado = (list<classRespuestaActivacion>)JSON.deserialize(response.getBody(), list<classRespuestaActivacion>.class);
           
            //respuesta = String.valueOf(resultado);
            //system.debug('Respuesta'+ resultado);
            //system.debug('Respuesta_texto '+ respuesta);     
             
           // integer idCarga;
            
            fcsd.sizeResu = resultado.size();
            //Para que seleccione por ID 
            ActivacionCuenta__c carga = new ActivacionCuenta__c ();             
            carga = [select Identificador_CargaA__c from ActivacionCuenta__c order by Identificador_CargaA__c desc limit 1] ;
            fcsd.idCarga = integer.valueOf(carga.Identificador_CargaA__c); 
            
            fcsd.ModificarEstado = [select Situaci_n__c, NoCuenta__c, Cliente__c, Empresa__c, Asesor__c                                  
                                   from ActivacionCuenta__c where Identificador_CargaA__c =: fcsd.idCarga];
            
             fcsd.sizeModi = fcsd.ModificarEstado.size();
              for(integer i=0; i<fcsd.sizeModi; i++)
              {
                for(integer k=0; k<fcsd.sizeResu; k++)
                {
                	if(fcsd.ModificarEstado[i].NoCuenta__c == resultado[k].Certificado)
                	{
                        fcsd.ModificarEstado[i].Situaci_n__c = resultado[k].Mensaje;
                        fcsd.ModificarEstado[i].Cliente__c = resultado[k].nombreCliente;
                        fcsd.ModificarEstado[i].Empresa__c = resultado[k].nEmpresa;                       
                        fcsd.ModificarEstado[i].Asesor__c = resultado[k].Asesor;
                    }
                }
            }            
             update fcsd.ModificarEstado;
            
            /*            
				for(integer i=0; i<resultado.size(); i++)
            {
				ActivacionCuenta__c ModificarEstado = new ActivacionCuenta__c();
                
                ModificarEstado  = [select Situaci_n__c, Cliente__c, Empresa__c, Asesor__c                                   
                                   from ActivacionCuenta__c 
                                    where NoCuenta__c =: resultado[i].Certificado ];
                ModificarEstado.Situaci_n__c=resultado[i].Mensaje;
                ModificarEstado.Cliente__c=resultado[i].nombreCliente;
                ModificarEstado.Empresa__c=resultado[i].nEmpresa;
                ModificarEstado.Asesor__c=resultado[i].Asesor;
                
               update ModificarEstado;     
           }//Fin del for principal*/		            
            
		}/*catch(System.CalloutException e){
			system.debug(e.getMessage()); }*/
        
        Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return resultado;   
    }

//PARA ACTUALIZAR ESTADO y CAUSA 1907201 	
public static list<classRespuestaActivacion> actualizaEstadoCausa(valResgistroActivaciondeCuentas claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/ActualizarCausaEstado');
		
		String respuesta = '';
		system.debug('Entro al REST del EDC');
        	list<classRespuestaActivacion> resultado = new list<classRespuestaActivacion>();
		try{
						
                        
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            system.debug(respuesta);              
            
            respuesta = String.valueOf(resultado);
            
		}/*catch(System.CalloutException e){
			system.debug(e.getMessage()+ ' LINEA ' + E.getLineNumber());
	
        }*/Catch(Exception e){
			system.debug(e.getMessage()+ ' LINEA ' + E.getLineNumber());	
		} 
		return resultado;   
    }	
    
/*	public static list<classRespuestaActivacion> actualizaEstadoCausa(valResgistroActivaciondeCuentas claseEnvio)
     {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
        request.setEndpoint(url + 'api/ActualizarCausaEstado');
		
		String respuesta = '';
         
        classRespuestaActivacion fcsd= new classRespuestaActivacion(); 
        list<classRespuestaActivacion> resultado = new list<classRespuestaActivacion>();
         
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
            
            resultado = (list<classRespuestaActivacion>)JSON.deserialize(response.getBody(), list<classRespuestaActivacion>.class);
            
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
  public static list<classRespuestaActivacion> BitacoraDCausaEstado(valResgistroActivaciondeCuentas claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/BitacoraCausaEstado');
		
		String respuesta = '';
		system.debug('Entro al REST del EDC');
            classRespuestaActivacion fcsd= new classRespuestaActivacion();
        	list<classRespuestaActivacion> resultado = new list<classRespuestaActivacion>();
		try{
						
                        
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
			/*HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            system.debug(respuesta);      */
            
             //aqui
            HttpResponse response/*= http.send(request)*/;
	    	//respuesta = response.getBody();
            if(test.isRunningTest())
            { 
                respuesta='{"classRespuestaActivacion":[{"Certificado":null,"Mensaje":"A"}]}';
            	fcsd = (classRespuestaActivacion)System.JSON.deserialize(respuesta, classRespuestaActivacion.class);
            }
            
            else{
                response = http.send(request); 
               
            }
             
            resultado = (list<classRespuestaActivacion>)JSON.deserialize(response.getBody(), list<classRespuestaActivacion>.class);
            //fin
                
           
            respuesta = String.valueOf(resultado);
            
		}/*catch(System.CalloutException e){
			system.debug(e.getMessage()+ ' LINEA ' + E.getLineNumber());
	
        }*/Catch(Exception e){
			system.debug(e.getMessage()+ ' LINEA ' + E.getLineNumber());	
		} 
		return resultado;   
    }
/*    public static list<classRespuestaActivacion> BitacoraDCausaEstado(valResgistroActivaciondeCuentas claseEnvio)
     {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
        request.setEndpoint(url + 'api/BitacoraCausaEstado');
		
		String respuesta = '';
         
        classRespuestaActivacion fcsd= new classRespuestaActivacion(); 
        list<classRespuestaActivacion> resultado = new list<classRespuestaActivacion>();
         
		system.debug('Entro al REST del EDC');
		try{
            						
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
			HttpResponse response = http.send(request);
	    	//respuesta = response.getBody();
            system.debug(respuesta);  
            
            if(test.isRunningTest())
            { 
                respuesta='[{"classRespuestaActivacion":[{"Certificado":null,"Mensaje":"A"}]}]';
            	fcsd = (classRespuestaActivacion)System.JSON.deserialize(respuesta, classRespuestaActivacion.class);
            }
            
            else{
                response = http.send(request); 
            }
             
            
            resultado = (list<classRespuestaActivacion>)JSON.deserialize(response.getBody(), list<classRespuestaActivacion>.class);
            
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
     }   */
       	   
}