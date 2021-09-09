public class prueba {

    public Account cc{get;set;}
    
    public String base {get;set;}
    
    public Blob file {get;set;}
    public String fileName {get;set;}
    
    public prueba(){
        
        ControllerAPIPagoIntereses.classRespuestaImagen wer =  new ControllerAPIPagoIntereses.classRespuestaImagen();
        wer = ControllerAPIPagoIntereses.TraerImagenBD('107036'); 
        base = wer.imagen;
        system.debug('base: '+base);
    }
    
    public void test(){
        String hy = EncodingUtil.base64Encode(file);  
        system.debug(fileName+ '  hy: '+hy.length());
        system.debug('hy: '+hy);
        
        
        String recordId = 'a1g54000001AajYAAS';
        Blob fileBody = EncodingUtil.base64Decode(hy);
        String fileName = 'Perfil.jpg';


        try{
            System.debug('fileName: '+fileName +' ------ recordId: '+recordId);
            ContentVersion cv = new ContentVersion();
            cv.ContentLocation = 'S';
            cv.ContentDocumentId = null;
            cv.VersionData = fileBody; 
            cv.Title = fileName; 
            cv.PathOnClient = fileName; 
            insert cv;
            ContentDocumentLink cdl = new ContentDocumentLink();
            cdl.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id].ContentDocumentId;
            cdl.LinkedEntityId = recordId; 
            cdl.ShareType = 'V';
            insert cdl;
            system.debug('Éxitoso');
        }catch(Exception ex){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, 'Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber()));
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
        ControllerAPIPagoIntereses.classImagenReferencia imagenComp = new ControllerAPIPagoIntereses.classImagenReferencia(); 
                      
        imagenComp.Referencia = '51600';
        imagenComp.Imagen = hy;
        
        //system.debug('Imagen_a_Enviar_fabrisio--'+' ' + imagenComp); 
        ControllerAPIPagoIntereses.GuardarImagen(imagenComp);
                      
    }
    
    
    
    
}