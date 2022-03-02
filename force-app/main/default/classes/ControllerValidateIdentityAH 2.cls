public class ControllerValidateIdentityAH {
	public static FieldsAHManagement execute(string cuenta) {
        
        FieldsAHManagement fields = new FieldsAHManagement();
        
        try {
            //[{"ACCOUNT_NUMBER":"200005453304","CUSTOMER_ID":"2262605","ACCOUNT_NAME":"LURVIN GERALDINA ACOSTA BANEGAS / PULPERIA MARY","CATEGORY":"6000","CURRENCY":"HNL","LIMIT_REF":"","RESTRICTIONS":"","ALT_ACCOUNT":"","OPENING_DATE":"20170622","OPERATION_TYPE":"Individual","ACCOUNT_OFFICER":"102901021464","BRANCH_CODE":"133500000000","LEGAL_ID":"0703198300026","REQUIRED_SIGNATURES":"1","SIGNATURE_DESC":"FIRMA UNICA","INACTIVE_MARKER":""}]
            
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String url = claseUtil.urlSysde('Test');		
            request.setMethod('GET');
            request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            request.setTimeout(120000);
            request.setEndpoint(url + 'api/valCuentaAh/'+cuenta);
            
            string respuesta = '';
             
            HttpResponse response;
            
            if(!test.isRunningTest()) { response = http.send(request); respuesta = response.getBody();   
            
            }
            
            if(response.getStatusCode() == 200 || test.isRunningTest()) { 
                String res = respuesta.replace('[', ''); String res2 = res.replace(']', '');
                System.debug('res2: '+res2);
                fields = (FieldsAHManagement)System.JSON.deserialize(res2, FieldsAHManagement.class);
                System.debug('LEGAL_ID: '+fields.LEGAL_ID);
                System.debug('CURRENCY_VAL: '+fields.CURRENCY_VAL);
            }
        }catch(System.CalloutException e) {
			system.debug('Errro de servicio: '+e.getMessage());
        }Catch(Exception e){
            system.debug('Error: '+e.getLineNumber()+e.getMessage());	
		}     
        
        System.debug('fields: '+fields);
        return fields;
        
    }  
}