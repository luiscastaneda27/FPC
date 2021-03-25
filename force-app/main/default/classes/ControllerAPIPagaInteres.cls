public class ControllerAPIPagaInteres {

    public static ClassConsultaInteres BuscaPerIntereses(Date fecha_consulta) {
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
        
        string fecha = fecha_consulta.year()+'-'+fecha_consulta.month()+'-'+fecha_consulta.day();
        system.debug('Fecha' + fecha);
        
		request.setEndpoint(url + 'api/ConsultaInteresesP/'+ fecha);
        system.debug(fecha); 
		ClassConsultaInteres fcsd= new ClassConsultaInteres();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
			
			HttpResponse response =new HttpResponse();//
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setBody('{"Cuenta":"25573","NombreCompleto":"FATIN SIHAM GABRIE GABRIE","Identidad":"0501-1974-01724","TipoFondo":"101","CausaDescripcion":"AFILIACION POR SOLICITUD","CodigoCausa":"01","EstadoCuenta":"A","Tipodepago":"Fijo","Montodepago":"2000","Ajuste":null,"Diadepago":"13","Formadepago":"CK","Bancos":null,"Nocuenta":null,"Tipodecuenta":null,"EstadoAprobacion":"A","Fec_inclusion":null,"TotalFondo":null,"CantidadPignorada":null,"Moneda":"01","fechaHasta":null,"Imagen_respaldo":null,"pagoach":null,"pagocheque":null,"Tocarcapital":"Si","cheque":"Si","tsp":"No","ach":"No"}');
                response.setStatusCode(200);
            }
            
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug(respuesta); 
            if (response.getStatusCode() == 200) {
	            fcsd = (ClassConsultaInteres)System.JSON.deserialize(response.getBody(), ClassConsultaInteres.class);         
	        }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
        
		return fcsd;   
    }
    
    public static String guardarfecha(ClassPagarIntereses bitacora) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/PagoIntereses');
		
		String respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
						
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(bitacora);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            system.debug(respuesta);
            system.debug('Hola Api SalesForce');
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return respuesta;   
    }
}