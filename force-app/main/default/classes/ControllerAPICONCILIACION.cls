public class ControllerAPICONCILIACION {
    
     public static classAportes_Conciliacion BuscarCuenta(string Cuenta) {
        
        Http http = new Http();     
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/BuscarCuentas/'+ Cuenta);
		classAportes_Conciliacion fcsd= new classAportes_Conciliacion();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            //system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsd = (classAportes_Conciliacion)System.JSON.deserialize(response.getBody(), classAportes_Conciliacion.class);         
	        }
		}Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsd;   
    }
		
    /*API para traer la fecha desde SYSDE*/
    public class FechaClass
    {
         public date fechaVa{get;set;}
    }
 
    public static void fechaCierreSysdeTraer()   
    {
         Http http = new Http();  
         HttpRequest request = new HttpRequest();  
         String url = claseUtil.urlSysde('Test');   
         request.setEndpoint(url + 'api/cierre'); 
         request.setMethod('GET');  
         request.setHeader('Content-Type', 'application/x-www-form-urlencoded'); 
         request.setTimeout(120000); 
        list<string> fechaC = new list<string>();
         try{   
             HttpResponse response = http.send(request);   
             //System.debug('Respuesta '+response.getBody()); 
             
             string resp = string.valueOf(response.getBody());
             
             system.debug('Respuesta: '+resp);
             
             fechaC=resp.split('T');
             resp=fechaC[0];
             fechaC=resp.split('-');
			 date fechacierre;
             
             if(integer.valueOf(fechaC[1])<10)
             {
                 fechacierre = date.valueOf(fechaC[0].replace('"','')+'-0'+fechaC[1]+'-'+fechaC[2]) - 1 ;
             }
             else
             {
                 fechacierre = date.valueOf(fechaC[0].replace('"','')+'-'+fechaC[1]+'-'+fechaC[2]) - 1 ;
             }
			            
             Fecha_SYSDE__c sds = new Fecha_SYSDE__c ();
             sds.Fecha_Cierre__c = fechacierre;
             insert sds;
             
            system.debug('FECHACIERRA:-- ' + fechacierre );
         }catch(Exception e)
         { 
             system.debug('Error: '+e.getMessage());  
         }    
        
        //return fechacierre;          
    }
	
    //Metodo dos para seleccionar fecha 
    
    public static void fechaCierreSysdeComparar() 
    {
         Http http = new Http();  
         HttpRequest request = new HttpRequest();  
         String url = claseUtil.urlSysde('Test');   
         request.setEndpoint(url + 'api/cierre'); 
         request.setMethod('GET');  
         request.setHeader('Content-Type', 'application/x-www-form-urlencoded'); 
         request.setTimeout(120000); 
        list<string> fechaC = new list<string>();
         try{   
             HttpResponse response = http.send(request);   
             //System.debug('Respuesta '+response.getBody()); 
             
             string resp = string.valueOf(response.getBody());
             
             system.debug('Respuesta: '+resp);
             
             fechaC=resp.split('T');
             resp=fechaC[0];
             fechaC=resp.split('-');
			 date fechacierre;
             date fechaSysdeUltim;
             
             if(integer.valueOf(fechaC[1])<10)
             {
                 fechacierre = date.valueOf(fechaC[0].replace('"','')+'-0'+fechaC[1]+'-'+fechaC[2]) -1 ;
             }
             else
             {
                 fechacierre = date.valueOf(fechaC[0].replace('"','')+'-'+fechaC[1]+'-'+fechaC[2]) -1;
             }
			            
             fechaSysdeUltim = [select Fecha_Cierre__c from Fecha_SYSDE__c order by Numeracion_Automatica__c desc limit 1].Fecha_Cierre__c ;
             
             system.debug('FechaUltimo' + fechaSysdeUltim);
             system.debug('FechaComparar' + fechacierre);
             
             
             Fecha_SYSDE__c sds = new Fecha_SYSDE__c ();
             sds.FechaComparar__c = fechacierre;
             sds.Fecha_Cierre__c = fechaSysdeUltim;
             insert sds;
             
            system.debug('FECHACIERRA:-- ' + fechacierre );
         }catch(Exception e)
         { 
             system.debug('Error: '+e.getMessage());  
         }    
        
        //return fechacierre;          
    }


    /*Trae la informacion de las cuentas contables*/
    public static ClassTraerCuentaContable BuscaCuentaConta(string Cuenta) { 
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/BuscarCuentaCTA/'+ Cuenta);
		ClassTraerCuentaContable fcsd= new ClassTraerCuentaContable();
		system.debug('Conten='+ Cuenta);
        string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsd = (ClassTraerCuentaContable)System.JSON.deserialize(response.getBody(), ClassTraerCuentaContable.class);         
	        }
		}Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsd;   
    }

    
    /*Guardar la informacion de los aportes en la BD*/
     public static classAportes_Conciliacion guardarAporte (classAportes_Conciliacion claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type','application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/APLICA_REG_RECAUDO');
		
        classAportes_Conciliacion fcsd= new classAportes_Conciliacion();
		string respuesta = '';
         
		system.debug('Entro al REST del EDC');
		try{
		   if(!test.isRunningTest()) 
           {   
               
                classJson envio = new classJson();
                envio.contenido = JSON.serialize(claseEnvio);
                
                String cons = 'contenido=' + envio.contenido;
                system.debug(cons);		
                request.setBody(cons);	
                HttpResponse response = http.send(request);
                
                respuesta = response.getBody();
                fcsd = (classAportes_Conciliacion)System.JSON.deserialize(response.getBody(), classAportes_Conciliacion.class);   
                
                system.debug(respuesta);      
           }	
            else{
                
                classAportes_Conciliacion cl = new classAportes_Conciliacion();
                cl.Cod_referencia = 'FPC123';
                cl.p_codigo_error = '0';
               }
			
		}Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsd;   
    }
    

      /*Traer periodo Aporte*/
     public static String BuscarAporte(classAportes_Conciliacion claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/BuscarAporte');
		
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
		}/*catch(System.CalloutException e){ 
			system.debug(e.getMessage());
	
        }*/Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return respuesta;   
    }
    
    /*Metodo para login*/
    
    public class classPersona
    {
        	public String id{ get; set; }
     	}
    
    public class Prueba  
    {
        public List<classRespuestaAportesCuenta> aportes {get; set;}
       
    }
    
     public static list<classRespuestaAportesCuenta> ConsultalAportesPatronales(string usuario) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = controllerApiClienteNatural.urlSysde('Test');
        request.setEndpoint(url + 'api/menu');
        request.setMethod('GET');
		request.setTimeout(120000);
		list<classRespuestaAportesCuenta> resultado = new list<classRespuestaAportesCuenta>();
		list<claseaportaciones> clientes = new list<claseaportaciones>();
		
		try{
            
			list<ClassPersona> claseEnvio = new list<ClassPersona>();
			
				ClassPersona nueva = new ClassPersona();
                 nueva.id = usuario;
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
            if (response.getStatusCode() == 200) {
                prueba prueba2= new prueba();
                //system.debug('Sysde'+response.getBody());
                prueba2 = (prueba) JSON.deserialize(response.getBody(), prueba.class);
                //system.debug('Cantidad de afiliados que vienen'+prueba2.aportes.size());
               	resultado = prueba2.aportes;
               
	        }
	     list<Account> idsalesforce = new list<Account> ();
         
	    }/*catch(System.CalloutException e){
	    		system.debug('Error al hacer la consulta: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());   
        }*/Catch(Exception e){
        		system.debug('Error al traer persona: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
        }
         return resultado;
        //return null;
    }
    
    public class classRespuestaAportesCuenta
    	{
            public String identificacion { get; set; } 
            public List<classAportesCuenta> cuentas { get; set; }
        }
        
        public class classAportesCuenta
        {
            public String cuenta { get; set; }
           
        } 
        
    	public class classPersonas
        {
            public String identidad { get; set; }
            public List<classCuenta> cuentas { get; set; }
    
        }

    ///Metodo para conciliar las cuentas
    
    public class classRespuestaConciliacion
    {
        public string Conciliado { get; set; }
        public string Referencia { get; set; }
        public string Error { get; set; }
        //public List<classMenu> Pantallas { get; set; }
    }
    
     public class classCargaEC_Respuesta_Conciliacion
    {

        public string Conciliado { get; set; }
        public string Referencia { get; set; }
        public string Mensaje { get; set; }

    }
    
    //PruebaConciliacion2018W classEnvio
    public static list<classCargaEC_Respuesta_Conciliacion> ConsultaCEConciliados (ClassEnviarConciliacionLista classEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
        request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/CargaECConciliacion');
        
	    list<classCargaEC_Respuesta_Conciliacion> resultado = new list<classCargaEC_Respuesta_Conciliacion>();
        
        string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

            classJson envio = new classJson();
			envio.contenido = JSON.serialize(classEnvio.ListEC);
            
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
            
            HttpResponse response = http.send(request);
            respuesta = response.getBody();
            system.debug('Respuesta Sysde '+response.getBody());
            
            if (response.getStatusCode() == 200) 
            {
             
              resultado = (list<classCargaEC_Respuesta_Conciliacion>)JSON.deserialize(response.getBody(), list<classCargaEC_Respuesta_Conciliacion>.class);
              
              system.debug('ConversionResultadoPrueba2' + resultado);
                
             
            for(integer i=0; i<resultado.size(); i++)
            {
				Contenido_Estado_Cuenta_Conciliacion__c ModificarEstado = new Contenido_Estado_Cuenta_Conciliacion__c();
                
                ModificarEstado  = [select Conciliado__c                                  
                                   from Contenido_Estado_Cuenta_Conciliacion__c 
                                    where Referencia__c =: resultado[i].Referencia ];
                
                ModificarEstado.Conciliado__c =  resultado[i].Conciliado;
                update ModificarEstado;
                    
           } //Fin del for principal
            
	        } //Fin del if
		}/*catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }*/Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         
		return resultado;   
    }
    
    /*Creacion de la partida de debito el cual concilia*/ 
    public static list<RespuestaPartidaConta> CreaPartidaDebi (ClassListaPartii  part) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
        request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/CreaPartidaDebito');
        
	    list<RespuestaPartidaConta> resultado = new list<RespuestaPartidaConta>();
        
        string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
			if(!test.isRunningTest()) 
            {
                 classJson envio = new classJson();
                    envio.contenido = JSON.serialize(part.ListaCargaC);
                    
                    String cons = 'contenido=' + envio.contenido;
                    system.debug(cons);		

                    
                    HttpResponse response = http.send(request);
                    respuesta = response.getBody();
                    system.debug('Respuesta Sysde '+response.getBody());
                    
                 if (response.getStatusCode() == 200) 
                    {
                     
                      resultado = (list<RespuestaPartidaConta>)JSON.deserialize(response.getBody(), list<RespuestaPartidaConta>.class);
                        
                        system.debug('ConversionResultadoPrueba2' + resultado);
                        
                                
                         for(integer i=0; i<resultado.size(); i++)
                            {
                                   Contenido_Estado_Cuenta_Conciliacion__c ModificarEstado = new Contenido_Estado_Cuenta_Conciliacion__c();
                                    
                                      ModificarEstado  = [select Conciliado__c, Check__c, Respuesta_SYSDE__c                                
                                                          from Contenido_Estado_Cuenta_Conciliacion__c 
                                                          where Referencia__c =: resultado[i].Referencia ];
                                      
                                      ModificarEstado.Respuesta_SYSDE__c = resultado[i].P_ERROR;
                                      ModificarEstado.Conciliado__c = resultado[i].RespuestaConciliado;
                                      update ModificarEstado;  
                                        
                                
                           } //Fin del for principal
                           
                    } //Fin del if
                
            }
            else
            {
                
                List<RespuestaPartidaConta> ListRespuestaSysde = NEW List<RespuestaPartidaConta>();
                
                RespuestaPartidaConta ko = new RespuestaPartidaConta();
                ko.NuAsiento = '123';
                ko.P_ERROR = 'OK';
                KO.Referencia = 'HN22902';
                KO.RespuestaConciliado = 'S';
                resultado.add(KO);
                
            }
           
		      
                	
			
		}Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         
		return resultado;     
    }
    
    /*Creacion de la partida de debito el cual crea la contrapartida pero no concilia*/ 
    public static list<RespuestaPartidaConta> CreaPartidaDebiNoConcilia (ClassListaPartii  part) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
        request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/CreaPartidaDebito');
        
	    list<RespuestaPartidaConta> resultado = new list<RespuestaPartidaConta>();
        
        string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

            classJson envio = new classJson();
			envio.contenido = JSON.serialize(part.ListaCargaC);
            
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
            
            HttpResponse response = http.send(request);
            respuesta = response.getBody();
            system.debug('Respuesta Sysde '+response.getBody());
            
            if (response.getStatusCode() == 200) 
            {
             
              resultado = (list<RespuestaPartidaConta>)JSON.deserialize(response.getBody(), list<RespuestaPartidaConta>.class);
                
				system.debug('ConversionResultadoPrueba2' + resultado);
                
                   		
                  for(integer i=0; i<resultado.size(); i++)
                    {
                             Contenido_Estado_Cuenta_Conciliacion__c ModificarEstado = new Contenido_Estado_Cuenta_Conciliacion__c();
                            
                              ModificarEstado  = [select Conciliado__c, Check__c, Respuesta_SYSDE__c                                
                                                  from Contenido_Estado_Cuenta_Conciliacion__c 
                                                  where Referencia__c =: resultado[i].Referencia ];
                              
                              ModificarEstado.Respuesta_SYSDE__c = resultado[i].P_ERROR;
                              update ModificarEstado;

                        
                   } //Fin del for principal
                
            } //Fin del if
		}/*catch(System.CalloutException e){ 
			system.debug(e.getMessage());
	
        }*/Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         
		return resultado;   
    }
    
    /*Partida cuando la moneda esta en dolares si concilia */
   
    public static list<RespuestaPartidaConta> CreaPartidaDolaar (ClassListaPartii  part) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
        request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/CrearPartDolares');
        
	    list<RespuestaPartidaConta> resultado = new list<RespuestaPartidaConta>();
        
        string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

            classJson envio = new classJson();
			envio.contenido = JSON.serialize(part.ListaCargaC);
            
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
            
            if(!test.isRunningTest())
            {
            HttpResponse response = http.send(request);
            respuesta = response.getBody();
            system.debug('Respuesta Sysde '+response.getBody());
            
            if (response.getStatusCode() == 200) 
            {
             
              resultado = (list<RespuestaPartidaConta>)JSON.deserialize(response.getBody(), list<RespuestaPartidaConta>.class);
                
				system.debug('ConversionResultadoPrueba2' + resultado);
                
                   		
                 for(integer i=0; i<resultado.size(); i++)
                    {
                           Contenido_Estado_Cuenta_Conciliacion__c ModificarEstado = new Contenido_Estado_Cuenta_Conciliacion__c();
                            
                              ModificarEstado  = [select Conciliado__c, Check__c, Respuesta_SYSDE__c                                
                                                  from Contenido_Estado_Cuenta_Conciliacion__c 
                                                  where Referencia__c =: resultado[i].Referencia ];
                              
                              ModificarEstado.Respuesta_SYSDE__c = resultado[i].P_ERROR;
                              ModificarEstado.Conciliado__c = resultado[i].RespuestaConciliado;
                              update ModificarEstado;  
                        		
                        
                   } //Fin del for principal
                   
	        } //Fin del if
           }
            ELSE{
                
                  RespuestaPartidaConta mo =  new RespuestaPartidaConta();
            	  mo.NuAsiento = '1245';
                  mo.P_ERROR  = 'OK';
                  mo.Referencia = 'FPC123';
                  mo.RespuestaConciliado = 'S'; 
                resultado.add(mo);
            }
                
                
		}Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         
		return resultado;   
    }
    
    ///////////////////////////////////////////////////////
    

   
    public static list<RespuestaPartidaConta> CreaPartidaDolaarNoConcilia (ClassListaPartii  part) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
        request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/CrearPartDolares');
        
	    list<RespuestaPartidaConta> resultado = new list<RespuestaPartidaConta>();
        
        string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

            classJson envio = new classJson();
			envio.contenido = JSON.serialize(part.ListaCargaC);
            
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
            
            if(!test.isRunningTest())
            {
                  HttpResponse response = http.send(request);
            respuesta = response.getBody();
            system.debug('Respuesta Sysde '+response.getBody());
            
            if (response.getStatusCode() == 200) 
            {
             
              resultado = (list<RespuestaPartidaConta>)JSON.deserialize(response.getBody(), list<RespuestaPartidaConta>.class);
                
				system.debug('ConversionResultadoPrueba2' + resultado);
                
                   		
                  for(integer i=0; i<resultado.size(); i++)
                    {
                             Contenido_Estado_Cuenta_Conciliacion__c ModificarEstado = new Contenido_Estado_Cuenta_Conciliacion__c();
                            
                              ModificarEstado  = [select Conciliado__c, Check__c, Respuesta_SYSDE__c                                
                                                  from Contenido_Estado_Cuenta_Conciliacion__c 
                                                  where Referencia__c =: resultado[i].Referencia ];
                              
                              ModificarEstado.Check__c = ''; 
                              ModificarEstado.Respuesta_SYSDE__c = resultado[i].P_ERROR;
                              update ModificarEstado;

                        
                   } //Fin del for principal
                   
	        } //Fin del if
            }
            else
            {
                  RespuestaPartidaConta mo =  new RespuestaPartidaConta();
            	  mo.NuAsiento = '1245';
                  mo.P_ERROR  = 'OK';
                  mo.Referencia = 'FPC123';
                  mo.RespuestaConciliado = 'S';

            }
            
          
		}Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         
		return resultado;   
    }
    
    //Metodo para insertar en la BD
    
     public static void InsertaBitacoraConci(ListaBitaaa los)  
    {
         Http http = new Http();  
         HttpRequest request = new HttpRequest();  
         String url = claseUtil.urlSysde('Test');   
         request.setEndpoint(url + 'api/InsertaBitacora'); 
         request.setMethod('POST');  
         request.setHeader('Content-Type', 'application/x-www-form-urlencoded'); 
         request.setTimeout(120000); 
        
         try{   
             HttpResponse response = http.send(request);   
             //System.debug('Respuesta '+response.getBody()); 
             
             response.getBody();
            
         }catch(Exception e)
         { 
             system.debug('Error: '+e.getMessage());  
         }    
        
        //return fechacierre;          
    }
    
    ///////////////////
   
    public static void GuardarEnBitacoraSYSDE (ListaBitaaa lol) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
        request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/InsertaBitacora');

        string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

            classJson envio = new classJson();
			envio.contenido = JSON.serialize(lol.ListaCargaC1);
            
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
            
            HttpResponse response = http.send(request);
            respuesta = response.getBody();
            system.debug('Respuesta Sysde '+response.getBody());
            
            if (response.getStatusCode() == 200)  
            {
              SYSTEM.debug('CORRECTO EL INSERT'); 
	        } //Fin del if
		}Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         
		//return resultado;   
    }
    
   
    public class ListaBitaaa
    {
      //Lista para mostrar los datos de beneficiarios
      public List<ControllerBitacoraConciliacion.BitacoraConciliacion> ListaCargaC1 {get;set;}

        public ListaBitaaa()
         {
            ListaCargaC1 =new List<ControllerBitacoraConciliacion.BitacoraConciliacion>(); 
          
         }
    }
    
    
    
    /////////////////////////////////////////////////////////////

    public class RespuestaAporte
    {
        //Variables de salida
        public string NuAsiento { get; set; }
        public string P_ERROR { get; set; }
        public string Referencia { get; set; }
        public string RespuestaConciliado { get; set; }
    }
    
     public class RespuestaPartidaConta
    {
        public string NuAsiento { get; set; }
        public string P_ERROR { get; set; }
        public string Referencia { get; set; }
        public string RespuestaConciliado { get; set; }

    }
    
    
    /*Clase que trae las cuentas*/
    public class ClassTraerCuentaContable
    {

        public string Cu_Rezagos { get; set; }
        public string Cu_Bancos { get; set; }
    
    }
    
    /*Clase Prueba Enviar*/
    public class ClassContableTemp
    {

       	public string TipoFondo { get; set; }
        public Date FechaPosteo { get; set; }
        public Date FechaValor { get; set; }
        public Decimal Monto { get; set; }
        public string Referencia { get; set; }
        public string Conciliado { get; set; }
        public Decimal Pc_Dia { get; set; }
        public string pCU_Contable { get; set; }
        public string pCU_Rezagos { get; set; }
        public string PC_Observaciones { get; set; }
        public string pc_Usuario { get; set; }
    
    }
    
     public class AporteBD_Agregar
    {
        public string ComisionSI { get; set; } /*Aplica Comision*/
        public string Cod_referencia { get; set; }
        public string pc_pc_AplicaDolar { get; set; }
        public string Cuenta { get; set; }
        public string pc_DESCRIPCION { get; set; }
        public string pc_ESTADO_APORTE { get; set; }
        public DateTime FechaDepositoAproba { get; set; }
        public DateTime PC_FECHA_INGRESO_SISTEMA { get; set; }
        public string FormaPago { get; set; }
        public string Monto { get; set; } /*Cambiar a float*/
        public string NombreCompleto { get; set; }
        public string pc_OFICIAL_DE_NEGOCIOS { get; set; }
        public string p_periodo_aporte { get; set; }
        public string Moneda { get; set; }
        public string TipoSaldo { get; set; }
        public string pc_Imagen { get; set; }

        public DateTime FechaDeposito { get; set; }

        //Variables de salida

        public string p_saldo { get; set; }
        public string p_monto_pen_aplic { get; set; }
        public string p_num_movim_sysde { get; set; }
        public string p_nombre { get; set; }
        public string p_codigo_error { get; set; }
        public string p_Error { get; set; }
        
    }
    
    public class ClassListaAporte
    {
        //Variables de salida
        public string Aporte { get; set; }
        public string Error { get; set; }
        public string p_periodo_aporte { get; set; }
    }
    
     public class RespuestaImagen
    {
        public string pc_Imagen { get; set; }
        public string Cod_referencia { get; set; }
        public string p_Error { get; set; }
    }
    
     public class classImagenReferencia
    {
        public string Referencia { get; set; }
        public string Imagen { get; set; }
    }

   
    /*Traer el Aporte*/
    public static ClassListaAporte TraerAporte(string Cuenta, string TipoMoneda) {   
        
        Http http = new Http(); 
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/TraerPeriodo/'+ Cuenta + '/' + TipoMoneda);
		ClassListaAporte fcsd= new ClassListaAporte();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsd = (ClassListaAporte)System.JSON.deserialize(response.getBody(), ClassListaAporte.class);   
                
                
	        }
		}Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsd;   
    }
		
    
   /*GUARDA LA IMAGEN EN LA BD*/
   
     public static classImagenReferencia GuardarImagen (classImagenReferencia claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type','application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/conciliacion/');
		
        classImagenReferencia fcsd= new classImagenReferencia();
		//string respuesta = '';
         
		system.debug('Entro al REST del EDC');
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
    
    /*Consulta la BD y trae la cadena base64 de la imagen*/
    
    public static classRespuestaImagen TraerImagenBD(string CodReferencia) {   
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/conciliacion/'+ CodReferencia);
		classRespuestaImagen fcsd= new classRespuestaImagen();
		//string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response = http.send(request);
	    	//respuesta = response.getBody();
          //  system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsd = (classRespuestaImagen)System.JSON.deserialize(response.getBody(), classRespuestaImagen.class);     
                system.debug('Lista Paola '+ fcsd);
                //fcsd.codigo = response.getStatusCode();
	        }
		}/*catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }*/Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsd;   
    }
    
    public class classRespuestaImagen
    {
        public integer codigo { get; set; }
        public string mensaje { get; set; }
        public string imagen { get; set; }
    }
    
    /*Enviar los aportes aprobados a la BD cada sabado*/
    /*Se comenta esto porque no se puede agregar en la BD 
      public class AgregarAporteAenBD
    {
        public string pcCODIGOREFERENCIA { get; set; } 
        public string pcAPLICA_COMISION { get; set; }
        public string pcAPLICA_DOLAR { get; set; }
        public string pcCUENTA { get; set; }
        public string pcDESCRIPCION { get; set; }
        public string pcESTADO_APORTE { get; set; }
        public DateTime pcFECHA_DEPOSITO { get; set; }
        public DateTime pcFECHA_INGRESO_SISTEMA { get; set; }
        public string pcFORMA_DE_PAGO { get; set; }
        public string pcMONTO_DEPOSITO { get; set; } 
        public string pcNOMBRE_COMPLETO { get; set; }
        public string pcOFICIAL_DE_NEGOCIOS { get; set; }
        public string pcTIPO_MONEDAC { get; set; }
        public string pcTIPO_SALDO { get; set; }
   }

    public class RespuestaAgregarAporteAenBD
    {
        public string pcCODIGO_REFERENCIA { get; set; }
        public string pcError { get; set; }
    }
    
     public static void GuardarAporteAenBaseDatos (ListaBitaaa lol) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
        request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/ActualizarSF');

        string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

            classJson envio = new classJson();
			envio.contenido = JSON.serialize(lol.ListaCargaC1);
            
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
            
            HttpResponse response = http.send(request);
            respuesta = response.getBody();
            system.debug('Respuesta Sysde '+response.getBody());
            
            if (response.getStatusCode() == 200) 
            {
              
                
                
	        } //Fin del if
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         
		//return resultado;   
    }
    
    */
    

} //fin clase