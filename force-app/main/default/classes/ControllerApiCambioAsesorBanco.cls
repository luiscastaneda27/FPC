public class ControllerApiCambioAsesorBanco {
public static ClassCambioAsesorBanco BuscarCuenta(string codCuenta) {
          
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
               
        request.setEndpoint(url + 'api/CambioAsesorBanco/' +  codCuenta ); 
        ClassCambioAsesorBanco fcsd = new ClassCambioAsesorBanco();
        string respuesta = '';
        system.debug('Entro al REST del EDC1');
        try{           
            system.debug('Estoy dentro de EDC1');
            system.debug('Y mi request es '+request);
            HttpResponse response = http.send(request);
            system.debug('Cargue la respuesa en el response');
            respuesta = response.getBody();
            system.debug('Respuesta: desde sysde: '+respuesta); 
            if (response.getStatusCode() == 200) {
                fcsd = (ClassCambioAsesorBanco)System.JSON.deserialize(response.getBody(), ClassCambioAsesorBanco.class);         
            }
		}Catch(Exception e){
			system.debug('Error: '+e.getMessage()+', Linea: '+e.getLineNumber());	
		} 
        
        system.debug('debuggAPI' +' '+ fcsd);
		return fcsd;   
    }
    	
    
       public static string ActualizarCambioAsesor(classActualizarAsesorBanco claseEnvio){
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);   
        request.setEndpoint(url + 'api/actualizaasesor');
		
		String respuesta = '';
		system.debug('Entro al REST del EDC2');
		try{
						
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);
            system.debug('Estoy dentro de EDC2');
            system.debug('Y mi request es '+request);
			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            system.debug('Respuesta desde sysde: '+ respuesta);      
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return respuesta; 
        
   }
}