public class ControllerServiciosCuentaAhorro {
	public static FieldsBankManagement Execute(FieldsBankManagement envioDatos) {
    	Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/gestionesBanco');
        
        FieldsBankManagement fields = new FieldsBankManagement();
		String respuesta = '';
        String respuesta2 = '';
        String respuesta3 = '';
        String respuesta4 = '';
		system.debug('Entro al metodo API');
		try{		
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(envioDatos);
            String cons = 'contenido=' + envio.contenido;
			system.debug('cons: '+cons);		
			request.setBody(cons);	
			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            //system.debug('respuesta: '+respuesta);
            
            //Get Identity of Response
            JSONParser parser = JSON.createParser(respuesta);
            System.debug('respuesta: '+respuesta);
                     
		} catch(System.CalloutException e){
			system.debug('Mensaje Conexión: '+e.getMessage());
            respuesta = e.getMessage();
        }
		return fields;     
    }    
}