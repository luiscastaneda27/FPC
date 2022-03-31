public class CrearUsuarioPortalAutogestion {


    @auraEnabled
    public static String crearUsuario(String recordId){
        Cuentas__c cuenta = [Select Codigo__c, Cliente__r.Tipo_Identificacion__c, Cliente__r.Identificacion__c, Cliente__r.Cliente_Unico_Banco__c from Cuentas__c Where cliente__c =: recordId limit 1];
        Cliente acc = new Cliente();
        acc.Cuenta = cuenta.Codigo__c;
        acc.ID = cuenta.Cliente__r.Tipo_Identificacion__c;
        acc.NroId = cuenta.Cliente__r.Identificacion__c;
        String body = JSON.serialize(acc);
        System.debug('Mandamos: '+body);
        Http http = new Http();
        String url = claseUtil.urlSysde('Api451');
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url+'api/RegistroSF');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody(body);
        try{
            HttpResponse response = http.send(request);
            if(response.getStatusCode() != 200 || response.getStatusCode() != 201) {
                BitacoraCreacionUsuario__c bit = new BitacoraCreacionUsuario__c ();
                bit.Codigo__c = response.getStatusCode();
                bit.Response__c = response.getBody();
                bit.Request__c = body;
                bit.Cliente__c = recordId;
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
        @auraEnabled public String Cuenta {get;set;}
        @auraEnabled public String ID {get;set;}
        @auraEnabled public String NroId {get;set;}
    }
}