public class ControladorGraficoProyecciones {
    
    @auraEnabled
    public static DatoGrafico calculoGrafico(String recordId){
        try{
            ControladorProyeccionConsolidado proy = new ControladorProyeccionConsolidado(new ApexPages.StandardController(new Proyeccion__c(Id = recordId)));
            List<String> anios = new List<String>();
            List<String> aniosPuntoEqui = new List<String>();
            List<Decimal> aportes = new List<Decimal>();
            List<Decimal> intereses = new List<Decimal>();
            List<Decimal> interesesPuntoEqui = new List<Decimal>();
            List<Decimal> comisiones = new List<Decimal>();
            
            aniosPuntoEqui.add('0');
            comisiones.add(0);
            interesesPuntoEqui.add(0);
            
            for(Integer i=4; i<proy.listProyeccionCons.size(); i= i+ 5){
                aportes.add(proy.listProyeccionCons[i].aporte);
                intereses.add(proy.listProyeccionCons[i].interes);
                anios.add((i + 1)+' años');
            }
            
            for(Integer i=0; i<36; i++){
                interesesPuntoEqui.add(proy.listProyeccionDetall[i].interesAcumulado.setsCale(2));
                comisiones.add(proy.listProyeccionDetall[i].comisionAcumulada.setsCale(2));
                aniosPuntoEqui.add(String.valueOf(i + 1));
            }
            
            DatoGrafico datos = new DatoGrafico();
            datos.anios = anios;
            datos.aniosPuntoEqui = aniosPuntoEqui;
            datos.aportes = aportes;
            datos.intereses = intereses;
            datos.interesesPuntoEqui = interesesPuntoEqui;
            datos.comisiones = comisiones;
            return datos;
        }catch(Exception ex){
            System.debug('----Error:'+ex.getMessage()+ ', Linea: '+ex.getLineNumber());
        }
        return new DatoGrafico(); 
        
    }
    
    @auraEnabled
    public static String envioCorreo(String recordId, String correo, String tipoProyeccion){
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        PageReference pdf;
        User usuario = [Select Name, Email, Phone, MobilePhone  from User where Id = :UserInfo.getUserId()];
        if(usuario.Phone == null || usuario.MobilePhone == null){
            return 'Datos imcompletos para enviar el correo, teléfono y móvil.';
        }
        List<Messaging.EmailFileAttachment> listArchivos = new List<Messaging.EmailFileAttachment>();
        Proyeccion__c proy = [Select Cliente__r.PersonContactId,NombreCliente__c,PersonContact__c,Preventa__c from Proyeccion__c Where Id=:recordId ];
        if(tipoProyeccion == 'Ambas' || tipoProyeccion == 'Consolidado'){
            pdf = Page.vfProyeccionConsolidado; 
            pdf.setRedirect(False);
            pdf.getParameters().put('Id',recordId);
            Blob b; 
            if(!test.isRunningTest())
                b = pdf.getContent();
            else
                b = blob.valueOF('Test');
            efa.setContentType('application/pdf');
            efa.setInline(False);
            efa.setFileName('Proyección Consolidada.pdf');
            efa.setBody(b);
            listArchivos.add(efa);
        } 
        if(tipoProyeccion == 'Ambas' || tipoProyeccion == 'Detallado'){
            pdf = Page.vfProyeccionDetallado; 
            pdf.setRedirect(False);
            pdf.getParameters().put('Id',recordId);
            Blob b; 
            if(!test.isRunningTest())
                b = pdf.getContent();
            else
                b = blob.valueOF('Test');
            efa = new Messaging.EmailFileAttachment();
            efa.setContentType('application/pdf');
            efa.setInline(False);
            efa.setFileName('Proyección Detallada.pdf');
            efa.setBody(b);
            listArchivos.add(efa);
        } 
        String queryCorreo = 'Select Cuerpo__c From Correo_EDC__mdt Where DeveloperName = \'CorreoProyeccion\'';
	    Correo_EDC__mdt cuerpoCorreo = dataBase.query(queryCorreo);
        String cuerpo = cuerpoCorreo.Cuerpo__c;
        cuerpo = cuerpo.replace('[getName]', proy.NombreCliente__c);
        cuerpo = cuerpo.replace('[getNombreAsesor]', usuario.Name);
        cuerpo = cuerpo.replace('[getEmail]', usuario.Email);
        cuerpo = cuerpo.replace('[getTelefonoOficina]', usuario.Phone);
         cuerpo = cuerpo.replace('[getTelefonoCelular]', usuario.MobilePhone);
        //OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];  
			
        
        List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
        mail.setToAddresses(new string[] {correo});
        mail.setSubject('Proyecciones Ficohsa Pensiones y Cesantías '+tipoProyeccion);
        mail.setHtmlBody(cuerpo);
        mail.setFileAttachments(listArchivos);
        if(Proy.PersonContact__c != null){
            mail.setTargetObjectId(Proy.PersonContact__c);
            mail.setSaveAsActivity(true);
        }
        MessageList.add(mail);    
        Task tarea = new Task();
        Messaging.sendEmail(MessageList);
        if(Proy.PersonContact__c != null){
            tarea = [Select Id, Proyeccion__c, TipoProyeccion__c  from Task Where WhoId =:Proy.PersonContact__c Order by CreatedDate Desc limit 1];
            tarea.TipoProyeccion__c = tipoProyeccion;
            tarea.Proyeccion__c = recordId;
            update tarea;
        }else{
            tarea.WhatId = Proy.Preventa__c;
            tarea.TipoProyeccion__c = tipoProyeccion;
            tarea.Proyeccion__c = recordId;
            tarea.Subject = 'Correo electrónico: '+mail.getSubject();
            tarea.Status = 'Completado';
            tarea.ActivityDate = Date.today();
            insert tarea;
        }
        return 'Exitoso';
    }
    
    @auraEnabled
    public static void getProyeccion(String recordId){
        
    }
    public class DatoGrafico{
        @auraEnabled public List<String> anios {get;set;}
        @auraEnabled public List<String> aniosPuntoEqui {get;set;}
        @auraEnabled public List<Decimal> aportes {get;set;}
        @auraEnabled public List<Decimal> intereses {get;set;}
        @auraEnabled public List<Decimal> interesesPuntoEqui {get;set;}
        @auraEnabled public List<Decimal> comisiones {get;set;}
    }
}