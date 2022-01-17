public class controllerAdjuntarArchivo {

    public Attachment archivoAdjunto{get;set;}
    private id Padre;
    public boolean guardado{get;set;}  
    public string fileName{get;set;}
    public Blob fileBody{get;set;}
    
    
    
    public controllerAdjuntarArchivo(){
        guardado= false;
        if (ApexPages.currentPage().getParameters().get('id') != null){
            Padre = ApexPages.currentPage().getParameters().get('id');           
            List<Attachment> lista= new List<Attachment>();
            
            lista = [SELECT Id, Name, ParentId FROM Attachment 
                WHERE ParentId = : padre LIMIT 1];
            //i= lista.size();
            
            if( lista.size()>0){
                archivoAdjunto = lista[0];
                if(archivoAdjunto!=null){
                    fileName = archivoAdjunto.Name;                 
                }
            }           
        }
        if(ApexPages.currentPage().getParameters().get('var') != null){
            guardado = true;
        }
    }   
    
    public PageReference UploadFile()  
    {
        PageReference pr;  
        if(fileBody != null && fileName != null)  
        {
            if(archivoAdjunto==null){
                  Attachment myAttachment  = new Attachment();  
                  myAttachment.Body = fileBody;
                  myAttachment.Name = fileName;
                  myAttachment.ParentId = padre;
                  archivoAdjunto= myAttachment;
                  try{
                      
                      ContentVersion cv = new ContentVersion();
                      cv.ContentLocation = 'S';
                      cv.ContentDocumentId = null;
                      cv.VersionData = fileBody; // Variable del archivo tipo Blob
                      cv.Title = fileName; // variable nombre del archivo tipo string
                      cv.PathOnClient = fileName; // variable nombre del archivo tipo string
                      insert cv;
                      ContentDocumentLink cdl = new ContentDocumentLink();
                      cdl.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id].ContentDocumentId;
                      cdl.LinkedEntityId = Padre; // id del caso
                      cdl.ShareType = 'V';
                      insert cdl;
                      
                      
                      
                    guardado=true;
                      
                    insert myAttachment;
                    myAttachment.Body=null;
                    archivoAdjunto.Body=null;
                    fileBody=null;
                    pr = null;
                    //pr.setRedirect(true); 
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Archivo Adjuntado Correctamente'));
                    return pr;
                  }catch (DMLException e){
                    
                    guardado=false;
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'si desea subir un archivo, por favor, seleccione uno de sus computadora utilizando el boton examinar'));
                  }
            }else{
                archivoAdjunto.Body = fileBody;  
                archivoAdjunto.Name = fileName;
                try{
                    guardado=true;
                    
                    update archivoAdjunto;
                    fileBody= null;
                    archivoAdjunto.Body = null;
                    pr = null;
                    //pr.setRedirect(true); 
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Archivo adjuntado correctamente'));
                    return pr;
                  }catch (DMLException e){
                                        
                    guardado=false;
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'No se logró adjuntar el archivo, recuerde que el tamaño debe ser menor a 130kb'));
                  }
            }
        }else{
            guardado=false;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Si desea subir un archivo, por favor, seleccione uno de sus computadora utilizando el boton examinar'));
        }
        return null; 
    }
}