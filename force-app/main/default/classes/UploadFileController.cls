public without sharing class UploadFileController {
    public class objectWP{
        @auraenabled public string principal{get;set;}
        @auraenabled public string error{get;set;}
        @auraenabled public string errorMsj{get;set;}
    }
    @auraenabled
    public static objectWP saveChunk(String parentId, String fileName, String base64Data, String contentType, String fileId) {
        System.debug(':::INICIOSAVECHUNK:::'+parentId);
        objectWP awp=new objectWP();
        try{
            Cuenta_Formularios__c ac=[select name, id, numformulario__c from Cuenta_Formularios__c order by name desc limit 1];
            parentId=ac.Id;
        }catch(Exception e){
            System.debug('Error:'+e.getMessage()+',Linea:'+e.getLineNumber());
            awp.error='fail';
            awp.errorMsj='No existe ninguna cuenta con el código: '+parentId;
            return awp;
        }        
        try{
            if (fileId == '') {
                fileId = saveTheFile( parentId, fileName, base64Data, contentType);
            } else {
                appendToFile(fileId, base64Data);
            }
            awp.principal=Id.valueOf(fileId);
            awp.error='correcto';
            return awp;
        }catch(Exception e){
            system.debug('error?'+e.getMessage()+'--'+e.getLineNumber());
            awp.error='fail';
            awp.errorMsj='Error al guardar';
            return awp;
        }
    }
    @auraenabled
    public static Id saveTheFile(Id parentId, String fileName, String base64Data, String contentType) {
        System.debug('base64Data: '+base64Data);    
        try{
            base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');        
            Attachment oAttachment;
            integer i=[Select count() from Attachment where Name=:fileName and parentId=:parentId] ;
            if(i>0){
                System.debug('existe');
                oAttachment = [Select Id from Attachment where Name=:fileName and parentId=:parentId];
                /*oAttachment.Body = EncodingUtil.base64Decode(base64Data);
oAttachment.ContentType = contentType;
update oAttachment;*/
                delete oAttachment;
                
            }/*else{*/
            System.debug('NO existe');
            oAttachment = new Attachment();
            oAttachment.parentId = parentId;
            
            oAttachment.Body = EncodingUtil.base64Decode(base64Data);
            oAttachment.Name = fileName;
            oAttachment.ContentType = contentType;
            
            insert oAttachment;
            //}
            
            return oAttachment.Id;
        }catch(Exception e){
            System.debug('Error:'+e.getMessage()+',Linea:'+e.getLineNumber());
            return null;
        }
    }
    
    
    private static void appendToFile(Id fileId, String base64Data) {
        try{
            base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
            
            Attachment a = [
                SELECT Id, Body
                FROM Attachment
                WHERE Id =: fileId
            ];
            
            String existingBody = EncodingUtil.base64Encode(a.Body);
            
            a.Body = EncodingUtil.base64Decode(existingBody + base64Data);
            
            update a;
            System.debug('archivo: '+a);
            System.debug('archivo: '+a.Id);
        }catch(Exception e){
            System.debug('Error:'+e.getMessage()+',Linea:'+e.getLineNumber());
        }
    }
    @auraenabled
    public static String initCuenta(String cuenta) {
        try{
            Cuenta_Formularios__c ac=[select name, id, numformulario__c from Cuenta_Formularios__c order by name desc limit 1];
            return 'correcto';
        }catch(Exception e){
            System.debug('Error:'+e.getMessage()+',Linea:'+e.getLineNumber());
            return 'sinCuenta';
        }
    }
    @auraenabled
    public static String init(String nombre,String cuenta) {
        System.debug('Inicio:'+nombre+','+cuenta);
        try{
            Cuenta_Formularios__c ac=[select name, id, numformulario__c from Cuenta_Formularios__c order by name desc limit 1];
            cuenta=ac.Id;
        }catch(Exception e){
            System.debug('Error:'+e.getMessage()+',Linea:'+e.getLineNumber());
            return 'sinCuenta'; 
        }
        try{
            Attachment att=[Select Id,Name from Attachment where Name=:nombre and parentId=:cuenta];
            return URL.getSalesforceBaseUrl().ToExternalForm()+'/servlet/servlet.FileDownload?file='+att.Id;
            //return URL.getSalesforceBaseUrl().ToExternalForm()+'/PantallasAfiliacion/servlet/servlet.FileDownload?file='+att.Id;
        }catch(Exception e){
            System.debug('Error:'+e.getMessage()+',Linea:'+e.getLineNumber());
            return 'fail';
        }
    }
}