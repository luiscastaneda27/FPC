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
    public static void envioCorreo(String recordId, String correo, String tipoProyeccion){
        Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        PageReference pdf;
        List<Messaging.EmailFileAttachment> listArchivos = new List<Messaging.EmailFileAttachment>();
        Proyeccion__c proy = [Select Cliente__r.PersonContactId,Cliente__r.Name,PersonContact__c,Prospecto__r.Name from Proyeccion__c Where Id=:recordId ];
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
        String queryCorreo = 'Select Cuerpo__c From Correo_EDC__mdt Where DeveloperName = \'correoGeneral\'';
	    Correo_EDC__mdt cuerpoCorreo = dataBase.query(queryCorreo);
        
        String cuerpo = cuerpoCorreo.Cuerpo__c;
        cuerpo = cuerpo.replace('[getAsunto]','Te adjuntamos proyecciones de Ficohsa Pensiones y cesatías');
        cuerpo = cuerpo.replace('[getName]', proy.Cliente__r.Name != null ? proy.Cliente__r.Name : proy.Prospecto__r.Name);
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];  
			
        
        List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
        mail.setToAddresses(new string[] {correo});
        mail.setSubject('Proyecciones Ficohsa Pensiones y Cesantías '+tipoProyeccion);
        mail.setHtmlBody(cuerpo);
        mail.setFileAttachments(listArchivos);
        mail.setTargetObjectId(Proy.PersonContact__c);
        mail.setSaveAsActivity(true);
        MessageList.add(mail);    
        
        Messaging.sendEmail(MessageList);
        Task tarea = [Select Id, Proyeccion__c, TipoProyeccion__c  from Task Where WhoId =:Proy.PersonContact__c Order by CreatedDate Desc limit 1];
        tarea.TipoProyeccion__c = tipoProyeccion;
        tarea.Proyeccion__c = recordId;
        update tarea;
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