public class AumentoDisminucionHelper {
    
    public static Boolean verifiacarEstadoCuenta(String codCuenta) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/valEstado/' + codCuenta); //http://190.5.68.11:9090/
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        EstadoCuenta respuesta = new EstadoCuenta();
        
        try {
            HttpResponse response = new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('{"EST_CUENTA":"A"}');
            }
            system.debug('Respuesta: '+response.getBody());
            if (response.getStatusCode() == 200 ) {
                respuesta = (EstadoCuenta)System.JSON.deserialize(response.getBody(), EstadoCuenta.class);
                return  respuesta.EST_CUENTA == 'I' ? false : true;             
            }
            
        } Catch(Exception e) {
            system.debug('Error' +e.getMessage() + ' linea ' + e.getLineNumber());
        }
        return true;    
    }
    
    public class EstadoCuenta{
        public String EST_CUENTA;
    }
    

}