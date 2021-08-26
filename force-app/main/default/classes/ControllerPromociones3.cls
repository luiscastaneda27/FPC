public without sharing class ControllerPromociones3 {
    public Lead candidato {get;Set;}
    private String usuario;
    public String pais {get; set;}
    public String depto {get; set;}
    public Boolean existente {get; set;}
    
    //varibales Nuevas
    public List<selectoption> listPaises {get;set;}
    public List<selectoption> listDepartamento {get;set;}
    
    public ControllerPromociones3(){
        usuario = Apexpages.currentPage().getParameters().get('usuario');
        reiniciar();
        getPaises();
    }
    
    public void getPaises() {
        listPaises= new list<selectoption>();
        listPaises.add(new selectoption('', ' --Ninguno-- '));
        for(Pais_R__c c:[Select Id,Name,codigo__c,nombre__c From Pais_R__c order by name asc]){
            listPaises.add(new selectoption(c.codigo__c,c.nombre__c));
        }
    }
    
    public void getDepartamento(){ 
        pais = Apexpages.currentPage().getParameters().get('idPage:theForm:Fpais') ;
        system.debug('pais: '+pais);
        listDepartamento= new list<selectoption>();
        listDepartamento.add(new selectoption('0', ' --Ninguno-- '));   
        for( Departamentos__c c:[select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: pais And codigo_departamento__c not in('0000','000') order by Departamento__c asc]){
            listDepartamento.add(new selectoption(c.codigo_departamento__c,formatName(c.Departamento__c)));
        }   
    }
    
    public void guardar(){
        
        try{
            if(pais == '0' || depto == '0') { 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,pais == '0' ? 'Debe seleccionar un País ' : 'Debe seleccionar un Estado/Departamento '));
                return;    
            }            
           /* if(candidato.Phone.length() > 8 && pais == '052') { 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Teléfono Móvil excede la cantidad de 8 caracteres permitidos ')); 
                return;    
            }*/
            /*if(candidato.Telefono_Trabajo__c != null && candidato.Telefono_Trabajo__c.length() > 8){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Teléfono Trabajo excede la cantidad de 8 caracteres permitidos '));
                return ;
            }
            candidato.Identificacion__c = candidato.Identificacion__c.replace('-', ''); 
            
            list<Account > preven = [select Id,OwnerId,Name,Owner.Name,Owner.Email
                                     from Account
                                     where Identificacion__c =: candidato.Identificacion__c ];
            
            system.debug('Repetido' + preven);
            
            list<PreVenta__c > prev = [Select Id,OwnerId From PreVenta__c 
                                       Where Identificacion__c =: candidato.Identificacion__c ];
            
            Task actividad = new Task();
            if (preven.size() > 0){
                actividad.OwnerId = preven[0].OwnerId;
                actividad.Subject= 'Hondureños en el Extranjero';
                actividad.Status= 'No Iniciado';
                actividad.Priority='Normal';
                actividad.WhatId = preven[0].Id;
                insert actividad;
                
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
                Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setHtmlBody( 'Buenas ' + preven[0].Owner.Name + ', Se le a asignado una tarea para el cliente ' + 
                                 preven[0].Name + ' desde el portal de Hondureños en el Extranjero.');
                mail.setSubject('Se le a asignado una tarea desde el portal de Hondureños en el Extranjero');
                mail.setToAddresses(new String[] {preven[0].Owner.Email});
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
                mail.setSaveAsActivity(true);
                listCorreo.add(mail);
                Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
                
            } else if(prev.size() > 0) {
                actividad.OwnerId = prev[0].OwnerId;
                actividad.Subject= 'Hondureños en el Extranjero';
                actividad.Status= 'No Iniciado';
                actividad.Priority='Normal';
                actividad.WhatId = prev[0].Id;
                insert actividad;
            }else{
                Pais_R__c itemP = [SELECT id, name, nombre__c, codigo__c from Pais_R__c where codigo__c =: pais];
                
                Departamentos__c itemD = [select id,Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: pais AND Departamento__c =: depto];
                
                candidato.RecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
                candidato.status = 'En Proceso';
                candidato.Usuario_Referencia__c = usuario;
                candidato.LeadSource='Web';
                candidato.F_Hon_USA_Link_Ref__c = true;
                //agregado 
                candidato.F_Pais__c = itemP.Id; 
                candidato.Departamento__c = itemD.Departamento__c; 
                candidato.Pais_Residencia__c = itemP.Name;
                //fin
                candidato.F_Estado__c = itemD.Id;
                insert candidato;  
            }*/
            Usuarios_para_asignacion_Casos_SAC__c usuarioAsig = [Select Id, usuario__C, Ultimo_Caso_Asignado__c
                                                             from Usuarios_para_asignacion_Casos_SAC__c where Objeto__c = 'Lead' And Usuario__r.IsActive = true
                                                             order by Ultimo_Caso_Asignado__c  asc limit 1];
            Pais_R__c itemP = [SELECT id, name, nombre__c, codigo__c from Pais_R__c where codigo__c =: pais];
            
            Departamentos__c itemD = [select id,Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: pais AND codigo_departamento__c =: depto];
            
            candidato.RecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
            candidato.status = 'En Proceso';
            candidato.Usuario_Referencia__c = usuario;
            candidato.LeadSource='Web';
            candidato.F_Hon_USA_Link_Ref__c = true;
            //agregado 
            candidato.F_Pais__c = itemP.Id; 
            candidato.Departamento__c = formatName(itemD.Departamento__c); 
            candidato.Pais_Residencia__c = formatName(itemP.Name);
            //fin
            candidato.F_Estado__c = itemD.Id;
            candidato.OwnerId = usuarioAsig.usuario__C;
            existente = validarPreventaExistente(candidato.FirstName, candidato.LastName, candidato.Phone);
            if(!existente){
                insert candidato; 
                usuarioAsig.Ultimo_Caso_Asignado__c = system.now();
                update usuarioAsig;
            }
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Su solicitud ha sido enviada. Pronto lo estaremos contactando.')); 
            //reiniciar(); 
        }catch (exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ha ocurrido un error.')); 
            system.debug(e.getLineNumber()+e.getMessage());
        }
    }
    
    public String formatName(String nombre){
        String respuesta = '';
        nombre =  nombre.toLowerCase();
        if(nombre.contains(' ')){
            for(String p : nombre.split(' ')){
                respuesta += p.toUpperCase().substring(0,1) + p.substring(1,p.length()) + ' ';
            }
        }else{
            respuesta = nombre.toUpperCase().substring(0,1) + nombre.substring(1,nombre.length()) + ' ';
        }
        return respuesta.trim();
    }
    
    public static Boolean validarPreventaExistente(String nombre, String apellido, String telefono){
        Map<String, Preventa__c> mapPreventas = new Map<String, Preventa__c>();
        for(Preventa__c item: 
            [Select Owner.Name,Owner.Email, Id, Name from Preventa__c
             Where FirstName__c = :nombre AND LastName__c =:apellido
             AND Phone__c = :telefono limit 1]){
                 String textoEmail = 'Estimado Asesor, '+item.Owner.Name+'.\n\n';
                 textoEmail += 'Te informamos que el cliente '+ item.Name + ' que tienes asignado como preventa en salesforce nuevamente ha solicitado información.';
                 textoEMail += '\n\nPor favor ponte en contacto para brindarle la información solicitada.';
                 textoEMail += '\n\nLink de la preventa: '+claseUtil.urlSysde('Salesforce') + item.Id;
                 Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
                 email.setSubject('Seguimiento a Preventa en Salesforce - '+item.Name); 
                 email.setToAddresses(new string[] {item.Owner.Email});
                 email.setPlainTextBody(textoEMail);
                 List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
                 OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
                 email.setOrgWideEmailAddressId(owea.get(0).Id);
                 Messaging.SingleEmailMessage[] listEmail = new List<Messaging.SingleEmailMessage>(); 
                 listEmail.add(email); 
                 system.debug('Tamano de lista: '+listEmail.size());
                 Messaging.SendEmailResult[] results = Messaging.sendEmail(listEmail, false);
                 return true;
             }
        return false;
    }
    
    public void reiniciar(){      
        candidato = new Lead();
        listDepartamento= new list<selectoption>();
        listDepartamento.add(new selectoption('0', ' --Ninguno-- '));  
        listPaises= new list<selectoption>();
        listPaises.add(new selectoption('0', ' --Ninguno-- '));
        candidato.Motivo_Contacto__c = 'Hondureños en el Extranjero';
        candidato.Departamento__c  = 'N/A'; 
        pais = '0';
        depto = '0';
        existente = false;
        
    }        
}