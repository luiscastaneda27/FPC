public class ControllerAPIFechCambioAporte {

   	public static classfechacambioaporte BuscarCuenta(date fechaporte, string codCuenta ) {
       /* if (fechaporte==null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe Ingresar una Fecha para realizar la respectiva busquedad'));   
        } */     
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
        string fecha = fechaporte.year()+'-'+fechaporte.month()+'-'+fechaporte.day();           
        request.setEndpoint(url + 'api/ConsultaFechaAporte/'+ fecha + '/' + codCuenta); 
        classfechacambioaporte fcsd = new classfechacambioaporte();
        string respuesta = '';
        system.debug('Entro al REST del EDC');
        try{           
            system.debug('Estoy dentro de EDC');
            system.debug('Y mi request es '+request);
            HttpResponse response = http.send(request);
            system.debug('Cargue la respuesa en el response');
            respuesta = response.getBody();
            system.debug('Respuesta: desde sysde: '+respuesta); 
            if (response.getStatusCode() == 200) {
                fcsd = (classfechacambioaporte)System.JSON.deserialize(response.getBody(), classfechacambioaporte.class);         
            }
		}Catch(Exception e){
			system.debug('Error: '+e.getMessage()+', Linea: '+e.getLineNumber());	
		} 
        
        system.debug('debuggAPI' +' '+ fcsd);
		return fcsd;   
    }
    	
    
       public static string Actualizarfecha(classAcualizaFechaAporte claseEnvio){
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);   
        request.setEndpoint(url + 'api/actualizafecha');
		
		String respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
						
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);
            system.debug('Estoy dentro de EDC');
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