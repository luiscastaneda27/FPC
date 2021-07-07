public class GetNameFile {
    
    @AuraEnabled
    public static String getResultWrapper(String recordId){
        try{
            List<File> listFiles = new List<File>();
            list<String> listIdAcc = new list<String>();
            listIdAcc.add(recordId);
            List<ContentDocumentLink> listDocument =  [Select ContentDocumentId,ContentDocument.Title 
                                                       from ContentDocumentLink
                                                       where LinkedEntityId in :listIdAcc 
                                                       Order By ContentDocument.CreateDdate desc];
            for(integer i = 0; i < listDocument.size(); i++){
                File archivo = new File();
                archivo.nameFile = listDocument[i].ContentDocument.Title;
                archivo.idFile = listDocument[i].ContentDocumentId;
                i++;
                if(i < listDocument.size()){
                    archivo.nameFile2 = listDocument[i].ContentDocument.Title;
                    archivo.idFile2 = listDocument[i].ContentDocumentId;
                }
                listFiles.add(archivo);
            }
            
            return Json.serialize(listFiles);
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            return null;
        }
    }
    
    public class File{
        public String nameFile{get;set;}
        public String idFile{get;set;}
        public String nameFile2{get;set;}
        public String idFile2{get;set;}
        
    }
    
    
}