public class aElectronicaController {
    public String securityToken {get;set;}
    public String ident {get;set;}
    public String securityT {get;set;}
    public String idClie {get;set;}
    public DateTime fechaGeneracion {get;set;}
    public Double fechaAbre {get;set;}
    public Boolean validado {get;set;}
    
    public aElectronicaController(){
        Blob key = Blob.valueOf('aAk!h@37WQ9bsAfk');
        if(!test.isRunningTest()){
            idClie = ApexPages.currentPage().getParameters().get('ident');
            securityT =  ApexPages.currentPage().getParameters().get('securityToken');
        }else{
            idClie = 'nxogjfXYPQDZzUVUGfewqzUSdKgQDgO0qHn4N77/gTw=';
            securityT = 'LkGWttfk+IIi2PT109vRE0hrq6zqEbNftgsrqLNSN1M=';
        }
        System.debug('idClie: '+idClie+' Token: '+securityT);
        if(idClie != '') {
            Blob blobData = EncodingUtil.base64Decode(idClie);    
            Blob decryptedBlob = Crypto.decryptWithManagedIV('AES128', key, blobData);    
            ident = decryptedBlob.toString();
        } else {
            ident = '';
        }
        if(securityT != '') {
            Blob blobData = EncodingUtil.base64Decode(securityT);    
            Blob decryptedBlob = Crypto.decryptWithManagedIV('AES128', key, blobData);    
            securityToken = decryptedBlob.toString();
        } else {
            securityToken = '';
        }
        
        System.debug('Identificación desencriptada: ' + ident+' Token: '+securityToken);    
    }
    
    public PageReference validar(){        
        List<Afiliacion_Electronica__c> AE = [Select Fecha_Generacion_Token__c, Afiliado__c From Afiliacion_Electronica__c Where Identificacion__c =: ident and Token__c =:securityToken];
        system.debug('AE: '+AE);
        fechaGeneracion = AE[0].Fecha_Generacion_Token__c;
        validado = AE[0].Afiliado__c;
        
        fechaAbre = (( DateTime.now().getTime()-fechaGeneracion.getTime()) / 3600000);
                system.debug('Cantidad horas: ' + fechaAbre+' esta validado: '+validado);
        
        
        if(validado == false){
            if(fechaAbre <= 24){
                //Start encrypting parameters
                    Blob key = Blob.valueOf('aAk!h@37WQ9bsAfk');
                
                    String encodedCipherText = EncodingUtil.base64Encode(Crypto.encryptWithManagedIV('AES128', key, Blob.valueOf(ident)));
                    String idClienteEncriptado = encodingUtil.URLEncode(encodedCipherText,'UTF-8');
                    
                    String encodedCipherText2 = EncodingUtil.base64Encode(Crypto.encryptWithManagedIV('AES128', key, Blob.valueOf(securityToken)));
                    String resultadoEncriptado = encodingUtil.URLEncode(encodedCipherText2,'UTF-8');
                    //End encrypting parameters
                    
                final PageReference target = new
                    PageReference(Site.getBaseSecureUrl() + '/apex/vfPantallaAfiliacionElectronica?ident='+idClienteEncriptado+'&securityToken='+resultadoEncriptado);
                target.setRedirect(true);
                // This is a permanent redirection
                target.setRedirectCode(301); 
                return target; 
            }else{           
                final PageReference target = new
                    PageReference(Site.getBaseSecureUrl() + '/apex/aElectronicaVencido');
                target.setRedirect(true);
                // This is a permanent redirection
                target.setRedirectCode(301); 
                return target; 
            }
        }else{
            final PageReference target = new
                    PageReference(Site.getBaseSecureUrl() + '/apex/aElectronicaVencido');
                target.setRedirect(true);
                // This is a permanent redirection
                target.setRedirectCode(301); 
                return target;
        }   
    }

}