trigger UsuarioPortalEmpresrial on Usuario_Portal_Empresarial__c (AFTER insert) {
    
    List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
    OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
    String queryCorreo = 'Select Cuerpo__c From Correo_EDC__mdt Where DeveloperName = \'correoGeneral\'';
    Correo_EDC__mdt cuerpoCorreo = dataBase.query(queryCorreo);
    String cuerpo = cuerpoCorreo.Cuerpo__c;
    String urlPortal = claseUtil.urlSysde('Empresarial') + 'vfCreacionUsuario2?loetdncdhjch=';
            
    for(Usuario_Portal_Empresarial__c item : trigger.new){
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {item.Email__c});
        mail.setOrgWideEmailAddressId(owea.get(0).Id);
        mail.setSubject('Nuevo Usuario Portal Empresarial Ficohsa');
        
        String cuerpo = cuerpoCorreo.Cuerpo__c;
        cuerpo = cuerpo.replace('[getName]', item.Nombre_completo__c);
       // String asunto ='Tu usuario ha sido creado al portal web Ficohsa <br/><br/>' +
          String asunto = '<strong style="color:#0f4f9e; font-family:Segoe UI; font-size:16px;">¡Te damos la bienvenida a Tu Sucursal Electrónica!</strong><br/><br/> ' +
                '<font style="color:#0f4f9e; font-family:Segoe UI; font-size:16px;">Tu usuario temporal ha sido creado, para acceder al portal da clic al siguiente link y personaliza tu usuario y contraseña:<br/><br/> ' +
                  ' <a  href="'+urlPortal + item.id + '" target="_blank">'+urlPortal + item.id+'</a><br/><br/> ';
           
        cuerpo = cuerpo.replace('[getAsunto]', asunto);
                      
        mail.setHtmlBody(cuerpo);
        MessageList.add(mail);   
    }
    Messaging.sendEmail(MessageList);
    
}