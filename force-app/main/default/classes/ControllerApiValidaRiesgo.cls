public class ControllerApiValidaRiesgo {
   
    public class classRespuestaRiesgo
    {
        public string PC_NIVEL_RIESGO{get;set;}
        public string PC_MEDIDA_APLICADA{get;set;}

    }
    public static list<classRespuestaRiesgo> NivelRiesgo(enviarValidarNivel claseEnvio)
    {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/ValidaNivel');
        
        classRespuestaRiesgo fcsd= new classRespuestaRiesgo(); 
        list<classRespuestaRiesgo> resultado = new list<classRespuestaRiesgo>();        
		
		String respuesta = '';
		system.debug('Entro al REST del EDC');
		try{       
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
			HttpResponse response;
            if(test.isRunningTest())
            { 
               respuesta='{"classRespuestaRiesgo":[{"Certificado":null,"Mensaje":"A"}]}';
            	fcsd = (classRespuestaRiesgo)System.JSON.deserialize(respuesta, classRespuestaRiesgo.class);
            }
            
            else{
                response = http.send(request);
                respuesta = response.getBody();
                respuesta = respuesta.replace('"[', '[');
                respuesta = respuesta.replace(']"', ']');
                respuesta = respuesta.replace('\\"','"');        
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta:' +''+ respuesta);
            }            
            
            resultado = (list<classRespuestaRiesgo>)JSON.deserialize(response.getBody(), list<classRespuestaRiesgo>.class);
          	
		}
        
        Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return resultado;
        
    } 
    public static list<classRespuestaRiesgo> NivelRiesgoJ(enviarValidarNivelJ claseEnvio)
    {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/ValidaNivelJ');
        
        classRespuestaRiesgo fcsd= new classRespuestaRiesgo(); 
        list<classRespuestaRiesgo> resultado = new list<classRespuestaRiesgo>();        
		
		String respuesta = '';
		system.debug('Entro al REST del EDC');
		try{       
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
			HttpResponse response;
            if(test.isRunningTest())
            { 
               respuesta='{"classRespuestaRiesgo":[{"Certificado":null,"Mensaje":"A"}]}';
            	fcsd = (classRespuestaRiesgo)System.JSON.deserialize(respuesta, classRespuestaRiesgo.class);
            }
            
            else{
                response = http.send(request);
                respuesta = response.getBody();
                respuesta = respuesta.replace('"[', '[');
                respuesta = respuesta.replace(']"', ']');
                respuesta = respuesta.replace('\\"','"');        
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta:' +''+ respuesta);
            }            
            
            resultado = (list<classRespuestaRiesgo>)JSON.deserialize(response.getBody(), list<classRespuestaRiesgo>.class);
          	
		}
        
        Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return resultado;
        
    } 


}