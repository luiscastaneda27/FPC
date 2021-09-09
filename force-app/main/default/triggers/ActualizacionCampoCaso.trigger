trigger ActualizacionCampoCaso on ContentDocumentLink (after insert) {
    try{
        list<string> listId = new list<string>();
        for(ContentDocumentLink item : trigger.new){
            listId.add(item.LinkedEntityId);
        }
        list<case> listcasos = new list<case>();
        for(case item : [select Archivo_Adjunto__C,id from case where id in :listId /*and Archivo_Adjunto__C = false*/]){
            item.Archivo_Adjunto__C = true;
            listcasos.add(item);
        }
        update listcasos;
    }catch(Exception ex){
        
    }
}