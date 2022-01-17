public class apiReporteT24 {
	
    
    public class classRespuestaT24
    {
        public string Certificado { get; set; }
        public string Mensaje { get; set; }
        public list<reporteT24__c> ModificarEstado {get;set;}
        public integer sizeModi {get;set;}
        public integer sizeResu {get;set;}

    }
    
    public static list<classRespuestaT24> guardarT24(ClassEnviarT24lista claseEnvio)
    {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/afiliaReporteT24');
        
        
        classRespuestaT24 fcsd= new classRespuestaT24();
        list<classRespuestaT24> resultado = new list<classRespuestaT24>();
		
		String respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
			 			
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
            
		HttpResponse response;/* = http.send(request);*/
             if(test.isRunningTest())
            { 
                respuesta='{"classRespuestaT24":[{"Certificado":null,"Mensaje":"A"}]}';
            	fcsd = (classRespuestaT24)System.JSON.deserialize(respuesta, classRespuestaT24.class);
            }
            
            else{
                response = http.send(request); 
            }
	    //	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
                        
          /*  if (response.getStatusCode() == 200) 
           {
                
	            fcsd = (classRespuestaT24)System.JSON.deserialize(response.getBody(), classRespuestaT24.class);
               
           }*/
	    	//respuesta = response.getBody();

			
            resultado = (list<classRespuestaT24>)JSON.deserialize(response.getBody(), list<classRespuestaT24>.class);
            //respuesta = String.valueOf(resultado);
       
  			fcsd.sizeResu = resultado.size();
           
            fcsd.ModificarEstado  = [select respuesta__c,  noEmpleado__c                                
                                   from reporteT24__c ];
            
            fcsd.sizeModi = fcsd.ModificarEstado.size();
            
            for(integer i=0; i<fcsd.sizeModi; i++){
                for(integer k=0; k<fcsd.sizeResu; k++){
                if(fcsd.ModificarEstado[i].noEmpleado__c == resultado[k].Certificado){
                    fcsd.ModificarEstado[i].respuesta__c = i + 1 + '- ' + resultado[k].Mensaje ;
                    
                }}
            }
            
            update fcsd.ModificarEstado;	
			
            
            
		}/*catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }*/Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return resultado;   
    }

       
}