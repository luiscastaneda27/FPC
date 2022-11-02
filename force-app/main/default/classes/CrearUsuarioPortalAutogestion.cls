public class CrearUsuarioPortalAutogestion {


    @auraEnabled
    public static String crearUsuario(String recordId){
        Cuentas__c cuenta = [Select Codigo__c, Cliente__r.FirstName,Cliente__r.LastName, Cliente__r.PersonEmail, Cliente__r.Tipo_Identificacion__c, Cliente__r.Identificacion__c, Cliente__r.Cliente_Unico_Banco__c from Cuentas__c Where cliente__c =: recordId limit 1];
        return crearUsuarioWS(cuenta.Cliente__r.FirstName, cuenta.Cliente__r.LastName, cuenta.Cliente__r.PersonEmail, cuenta.Cliente__r.Identificacion__c, cuenta.Codigo__c, cuenta.Cliente__r.Tipo_Identificacion__c);
    }
    
    public static String crearUsuarioWS(String nombre, String apellido, String correo ,String identificacion, String cuenta, String tipoIdentificacion){
        Http http = new Http();
        String url;
        url = claseUtil.urlSysde('Test');
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url+'api/usuario/portal');
        request.setMethod('POST');
        String body = 'nombre='+ nombre +'&apellido=' + apellido + '&correo=' + correo + '&tipoId=' + Integer.valueOf(tipoIdentificacion) + '&id=' + identificacion + '&cuenta=' + Integer.valueOf(cuenta);
        System.debug('Mandamos: '+body);
        request.setBody(body);
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        try{
            HttpResponse response = new HttpResponse();
            if(!Test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setBody('{"ok":true}');
            }
             
            System.debug('Respuesta: '+response.getBody());
            RespuestaUsuarioPortal rup = (RespuestaUsuarioPortal)JSON.deserialize(response.getBody(), RespuestaUsuarioPortal.class);
			
            BitacoraCreacionUsuario__c bit = new BitacoraCreacionUsuario__c ();
            bit.Codigo__c = response.getStatusCode();
            bit.Response__c = response.getBody();
            bit.Request__c = body;
            bit.Cliente__r = new Account(Identificacion__c = identificacion);
            insert bit;
            
            if(rup.ok) {
                return 'Usuario de portal registrado correctamente.';
            } else {
                return 'Ha ocurrido un error en el registro del usuario de portal, por favor contacte al administrador del sistema.';
            }
        }catch(Exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            return ex.getMessage();
        }
    }
    
    
    public class RespuestaUsuarioPortal{
        public Boolean ok { get; set; }
        public String descripcion { get; set; }
    }
}