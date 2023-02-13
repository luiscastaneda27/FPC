public class ControllerBankManagement {
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
         String respuesta5 = '';
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
            //System.debug('parser: '+parser);
            while (parser.nextToken() != null) {
                
                //System.debug('parser.getCurrentName(): '+parser.getCurrentName());
                if(parser.getCurrentName() == 'CARD_HOLDER_LEGAL_ID') {
                    parser.nextValue();
                    System.debug('CARD_HOLDER_LEGAL_ID: ' +parser.getText());
                    respuesta = parser.getText(); fields.CARD_HOLDER_LEGAL_ID = respuesta;
                }
                if(parser.getCurrentName() == 'ACCOUNT_HOLDER_LEGAL_ID') {
                    parser.nextValue(); respuesta2 = parser.getText();
                    System.debug('ACCOUNT_HOLDER_LEGAL_ID: '+respuesta2);
                    fields.ACCOUNT_HOLDER_LEGAL_ID = respuesta2;
                }
                if(parser.getCurrentName() == 'ACCOUNT_NUMBER') {
                    parser.nextValue(); respuesta3 = parser.getText();
                    System.debug('ACCOUNT_NUMBER: '+respuesta3);
                    fields.ACCOUNT_NUMBER = respuesta3;                    
                }
                if(parser.getCurrentName() == 'ACCOUNT_STATUS') {
                    parser.nextValue(); respuesta4 = parser.getText();
                    System.debug('ACCOUNT_STATUS: '+respuesta4);
                    fields.CARD_STATUS = respuesta4;
                }
                if(parser.getCurrentName() == 'ACCOUNT_HOLDER_NAME') {
                    parser.nextValue(); respuesta5 = parser.getText();
                    System.debug('ACCOUNT_HOLDER_NAME: '+respuesta5);
                    fields.ACCOUNT_HOLDER_NAME = respuesta5;
                }
            }           
		} catch(System.CalloutException e){
			system.debug('Mensaje Conexión: '+e.getMessage());
            respuesta = e.getMessage();
        }
		return fields;     
    }    
}