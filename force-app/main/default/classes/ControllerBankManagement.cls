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
		system.debug('Entro al metodo API');
		try{		
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(envioDatos);
            
            JSONParser parser;
            
            if(!test.isRunningTest()) { String cons = 'contenido=' + envio.contenido; request.setBody(cons); HttpResponse response = http.send(request); respuesta = response.getBody(); parser = JSON.createParser(respuesta);
                
            }
            
            if(!test.isRunningTest()) {
            
            while (parser.nextToken() != null) {
                
                if(parser.getCurrentName() == 'CARD_HOLDER_LEGAL_ID') { parser.nextValue(); respuesta = parser.getText(); fields.CARD_HOLDER_LEGAL_ID = respuesta;
                }
                if(parser.getCurrentName() == 'ACCOUNT_HOLDER_LEGAL_ID') { parser.nextValue(); respuesta2 = parser.getText(); fields.ACCOUNT_HOLDER_LEGAL_ID = respuesta2;
                }
                if(parser.getCurrentName() == 'ACCOUNT_NUMBER') { parser.nextValue(); respuesta3 = parser.getText();  fields.ACCOUNT_NUMBER = respuesta3;                    
                }
                if(parser.getCurrentName() == 'CARD_STATUS') { parser.nextValue(); respuesta4 = parser.getText(); fields.CARD_STATUS = respuesta4;
                }
            }    
            }    
		} catch(System.CalloutException e){ respuesta = e.getMessage();
        }
		return fields;     
    }    
}