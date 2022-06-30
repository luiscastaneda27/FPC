public class CrearUsuarioPortalAutogestion {


    @auraEnabled
    public static String crearUsuario(String recordId){
        Cuentas__c cuenta = [Select Codigo__c, Cliente__r.FirstName,Cliente__r.LastName, Cliente__r.PersonEmail, Cliente__r.Tipo_Identificacion__c, Cliente__r.Identificacion__c, Cliente__r.Cliente_Unico_Banco__c from Cuentas__c Where cliente__c =: recordId limit 1];
        return crearUsuarioWS(cuenta.Cliente__r.FirstName, cuenta.Cliente__r.LastName, cuenta.Cliente__r.PersonEmail, cuenta.Cliente__r.Identificacion__c, cuenta.Codigo__c, cuenta.Cliente__r.Tipo_Identificacion__c);
    }
    
    public static String crearUsuarioWS(String nombre, String apellido, String correo ,String identificacion, String cuenta, String tipoIdentificacion){
        Cliente acc = new Cliente();
       	acc.Cuenta = Integer.valueOf(cuenta);
        acc.tipoId = Integer.valueOf(tipoIdentificacion);
        acc.id = identificacion;
        acc.nombre = nombre;
        acc.apellido = apellido;
        acc.correo = correo;
        String body = JSON.serialize(acc);
        System.debug('Mandamos: '+body);
        Http http = new Http();
        String url;
        url = claseUtil.urlSysde('Test');
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url+'api/usuario/portal');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(body);
        try{
            HttpResponse response = http.send(request);
            System.debug('Respuesta: '+response.getBody());
            if((response.getStatusCode() != 200 && response.getStatusCode() != 201) || response.getBody().contains('{"ok":false,"')) {
                BitacoraCreacionUsuario__c bit = new BitacoraCreacionUsuario__c ();
                bit.Codigo__c = response.getStatusCode();
                bit.Response__c = response.getBody();
                bit.Request__c = body;
                bit.Cliente__r = new Account(Identificacion__c = identificacion);
                insert bit;
                return 'Ha ocurrido un error en el registro del usuario de portal, por favor contacte al administrador del sistema.';
            } else {
                return 'Usuario de portal registrado correctamente.';
            }
        }catch(Exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            return ex.getMessage();
        }
    }
    
    
    public class Cliente{
        public String nombre { get; set; }
        public String apellido { get; set; }
        public String correo { get; set; }
        public Integer tipoId { get; set; }
        public String id { get; set; }
        public Integer cuenta { get; set; }
    }
}