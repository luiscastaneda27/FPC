@isTest
public class pruebaPageReferenceTest {
    static testMethod void pruebaPageReferenceController(){
        Encryption__c privateKeyCustomSetting = new Encryption__c();
        privateKeyCustomSetting.Name = 'App1';
        privateKeyCustomSetting.Key__c = '1234567891123456';
        insert privateKeyCustomSetting;
        // Use generateAesKey to generate the private key
         Blob initializationVector = Blob.valueOf('SixtenDigitlen16');
        Blob key = Crypto.generateAesKey(128);
        // Generate the data to be encrypted.
        Blob data = Blob.valueOf('Test data');
        // Generate an encrypted form of the data using base64 encoding
        String b64Data = EncodingUtil.base64Encode(data);
        // Encrypt and decrypt the data
        Blob encryptedData = Crypto.encryptWithManagedIV('AES128', key, data);
        //Blob decryptedData = Crypto.decryptWithManagedIV('AES128', key, data);
        //String b64Decrypted = EncodingUtil.base64Encode(decryptedData);
        // Verify that the strings still match
        //System.assertEquals(b64Data, b64Decrypted);
        
     
        pruebaPageReferenceController Encrypt = new pruebaPageReferenceController();
        Encrypt.idClie = 'nxogjfXYPQDZzUVUGfewqzUSdKgQDgO0qHn4N77/gTw=';
        Encrypt.securityT = 'LkGWttfk+IIi2PT109vRE0hrq6zqEbNftgsrqLNSN1M=';
        Encrypt.ident = '0801199411011';
        Encrypt.securityToken = '1616298';
        Afiliacion_Electronica__c acc = new Afiliacion_Electronica__c(Name='Test',Fecha_Generacion_Token__c=date.today(), Afiliado__c=false,Identificacion__c='0801199411011',Token__c='1616298');
        insert acc;
        Encrypt.validar();
        Encrypt.ident = '0801199411012';
        Encrypt.securityToken = '1616299';
        Afiliacion_Electronica__c accc = new Afiliacion_Electronica__c(Name='Test',Fecha_Generacion_Token__c=date.today().adddays(2), Afiliado__c=false,Identificacion__c='0801199411012',Token__c='1616299');
        insert accc;
        Encrypt.validar();
        Encrypt.ident = '0801199411013';
        Encrypt.securityToken = '1616290';
        Afiliacion_Electronica__c acccc = new Afiliacion_Electronica__c(Name='Test',Fecha_Generacion_Token__c=date.today(), Afiliado__c=true,Identificacion__c='0801199411013',Token__c='1616290');
        insert acccc;
        Encrypt.validar();
    

    }
}