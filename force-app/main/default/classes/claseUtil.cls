global class claseUtil{
    
    public static RecordType getTipoRegistro(String objeto, String devepNombre){
        Try{
            RecordType tipoR = [Select Id, Name, DeveloperName 
                                From RecordType 
                                Where sObjectType =: objeto and DeveloperName =: devepNombre]; 
            return tipoR;
        }Catch(Exception e){
            return null;
        }    
    }
    
    public static DateTime convertToDateTime(String stringFecha){
        //14/10/2011-11:46
        Datetime dt = null;
        try{
            String[] dividir = stringFecha.split('-');
            
            String[] fecha = dividir[0].split('/');
            system.debug(fecha);
            integer day = Integer.valueOf(fecha[0]);        
            integer month = Integer.valueOf(fecha[1]);
            integer year = Integer.valueOf(fecha[2]); 
            
            String[] hora = dividir[1].split(':');
            system.debug(hora);
            integer h = Integer.valueOf(hora[0]);        
            integer m = Integer.valueOf(hora[1]);
            
            dt = DateTime.newInstance(year, month, day, h, m, 0);
        }Catch(Exception e){
            
        }
        return dt;
    }
    
    public static Date convertToDate(String stringFecha){
        //01-MAR-17
        Date dt = null;
        try{
            String[] fecha = stringFecha.split('-');
            system.debug(fecha);
            
            integer day = Integer.valueOf(fecha[0]);        
            integer month = convertMonth(fecha[1]);
            
            string completarAno = fecha[2];
            if(fecha[2].length() == 2){
                completarAno = '20' + completarAno;
            }
            integer year = Integer.valueOf(completarAno); 
            
            dt = Date.newInstance(year, month, day);
        }Catch(Exception e){
            
        }
        return dt;
    }
    
    public static integer convertMonth(String mes){
        if(mes == 'JAN'){
            return 1;
        }else if(mes == 'FEB'){
            return 2;
        }else if(mes == 'MAR'){
            return 3;
        }else if(mes == 'APR'){
            return 4;
        }else if(mes == 'MAY'){
            return 5;
        }else if(mes == 'JUN'){
            return 6;
        }else if(mes == 'JUL'){
            return 7;
        }else if(mes == 'AUG'){
            return 8;
        }else if(mes == 'SEP'){
            return 9;
        }else if(mes == 'OCT'){
            return 10;
        }else if(mes == 'NOV'){
            return 11;
        }
        return 12;
    }
    
    // PARA LOS METODOS LLAMADOS DESDE LAS CLASES FUTURAS
    Public Static boolean allow = true;
    public static void stopTrigger(){
        allow = false;
    }
    
    public static boolean canIRun(){
        return allow;
    }
    
    public static String urlSysde(String ambiente){
        try{
            return [Select URL__c From URL_conexion_Sysde__mdt Where DeveloperName =: ambiente].URL__c;
            
        }Catch(Exception e){
            return null;
        }
    }
    
    @future(callout=true)
    public static void enviarCorreoCasoAD(String idCaso, String tipoCaso){
        Messaging.SingleEmailMessage[] listEmail = new List<Messaging.SingleEmailMessage>(); 
        List<string> direcciones = new list<string>();
        String cuerpo = '';
        
        try{
            Case Caso = [Select id, CaseNumber, RecordType.DeveloperName, Owner.Name, Owner.email 
                         From Case Where id =: idCaso];
            
            URL_conexion_Sysde__mdt URL = [Select URL__c,Dirigido_a__c,Correo_electronico__c 
                                           From URL_conexion_Sysde__mdt Where DeveloperName =:tipoCaso Limit 1];
            
            direcciones.add(URL.Correo_electronico__c);
            //direcciones.add('luis.castaneda@intellectsystem.net');
            
            cuerpo = 'Buen día <br/><br/>';
            cuerpo += URL.Dirigido_a__c + '<br/>';
            cuerpo += '<p>';
            cuerpo += 'Por medio del presente le enviamos para su revisión y/o aprobación el siguiente caso';
            cuerpo +='</p>';
            cuerpo += '<br/><h3><a href="' + URL.URL__c + idCaso + '" target="_blank">';
            cuerpo += 'Ir a Caso';
            cuerpo += '</a><h3>';
            
            
            system.debug(cuerpo);
            
            Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
            email.setSubject(' Solicitud de Aprobación - ' + Caso.CaseNumber);                       
            
            email.setToAddresses(direcciones);
            email.setReplyTo(Caso.owner.email);
            email.setSenderDisplayName(Caso.Owner.Name);
            
            
            ApexPages.PageReference ref;
            Blob b = null;
            List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
            For(ContentDocumentLink item : 
                [SELECT ContentDocument.LatestPublishedVersionId,ContentDocumentId,
                 ContentDocument.FileExtension,ContentDocument.Title 
                 FROM ContentDocumentLink WHERE LinkedEntityId =: Caso.id]){
                     
                     ref = new ApexPages.PageReference('/sfc/servlet.shepherd/version/download/' + item.ContentDocument.LatestPublishedVersionId);
                     if(!test.isRunningTest()){
                         b = ref.getContent();
                     }else{
                         b = blob.valueOf('Probando');   
                     }
                     Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
                     string FileName = item.ContentDocument.Title.toUpperCase();
                     efa.setFileName(!filename.contains('PDF') ?( item.ContentDocument.Title+'.'+item.ContentDocument.FileExtension) : (item.ContentDocument.Title));
                     efa.setBody(b);
                     //efa.setContentType('.'+item.ContentDocument.FileExtension);
                     fileAttachments.add(efa);	
                 }
            email.setHtmlBody(cuerpo);
            email.setFileAttachments(fileAttachments);
            listEmail.add(email); 
            
            Messaging.SendEmailResult[] results = Messaging.sendEmail(listEmail); 
            system.debug('Exitoso');  
        }Catch(Exception e){
            system.debug(e.getMessage() + ' - ' + e.getLineNumber());
        }       
    }
    
    public static void metodoutil(){}
    
    
    
    
    
}