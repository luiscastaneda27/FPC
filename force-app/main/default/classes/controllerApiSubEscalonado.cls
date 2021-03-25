public class controllerApiSubEscalonado 
{
    public static classSubprEscal consultaSub(string SubProducto) 
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/CambioSubPrEscal/'+ SubProducto);
        classSubprEscal catb = new classSubprEscal();
        list<cuentasSubp> cuentas = new list<cuentasSubp>();
        string respuesta = '';
        system.debug('Entro al REST del EDC');
        try
        {
            HttpResponse response = new HttpResponse();
            
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) 
            {
                catb = (classSubprEscal)System.JSON.deserialize(response.getBody(), classSubprEscal.class);         
            }
        }catch(System.CalloutException e)
        {
            system.debug(e.getMessage());
            
        }Catch(Exception e)
        {
            system.debug(e.getMessage());	
        } 
        return catb;   
    }
    
    public static String CambioSub(classCambioSubproducto claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/subproducto');
		
		String respuesta = '';
		system.debug('Entro al REST del EDC ClienteNaturales2');
		try{
						
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
			HttpResponse response =new HttpResponse();
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
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