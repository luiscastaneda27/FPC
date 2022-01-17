public class ControllerPromociones2 {
      public list <Account> preven {get; set;}
     //public list <task> ko {get; set;}
     public list<Lead> prospectos {get;set;}
    public list<PreVenta__c > prev {get;set;}
     //public PreVenta__c preventa {get;Set;}
     public Lead candidato {get;Set;}
     public task Activi {get;Set;}
     public task Actividad {get;Set;}
   
    public boolean pop3 {get;Set;}
    public string identificacion {get; set;}
 //public string nombrePersonaRefiere {get; set;}
    private RecordType natural;
    private map<id, Lead> mapProspectos;
   // private map<id, Leads> mapProspectos;
    
    //public List<SelectOption> options {get;set;}
    private string usuario;
    private string  clientes;

 //public Fantasma_portal__c fantasma{get;Set;}
    
    public ControllerPromociones2(){
        candidato = new Lead();
    //    Actividades = new Lead();
        usuario = Apexpages.currentPage().getParameters().get('usuario');
        natural = [Select id From RecordType Where sObjectType = 'Lead' AND DeveloperName = 'Natural' Limit 1];
        pop3=true;
        candidato.Motivo_Contacto__c = 'PROTECCIÓN INTEGRAL REDES';
         
        //candidato.Identificacion__c = v1;
        //candidato.Motivo_Contacto__c = apexpages.;
        //[select Motivo_Contacto__c from Motivo_Contacto ];
            //opcionColonia = new list <selectOption>();
    }
     
    public pageReference guardarPop(){
        
        try{
            
            /*if(identificacion == null )
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe escribir el numero de ID'));
            return null;    
            }*/
		
            if(identificacion != null)
            {
                candidato.Identificacion__c = identificacion.replace('-', '');
            }
            
           /* if(identificacion == null)
            {
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Identidad campo obligatorio'));
            }*/
            if(candidato.Phone.length() > 8 ){          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Teléfono Movil excede la cantidad de 8 caracteres permitidos'));
            return null;    
        }
        if(candidato.Telefono_Trabajo__c != null){
            if(candidato.Telefono_Trabajo__c.length() > 8 ){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Teléfono Trabajo excede la cantidad de 8 caracteres permitidos'));
                return null;
            }
        }
            if(candidato.Departamento__c  == 'N/A')
        {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe Seleccionar un Departamento'));
            return null;
        }
        else   
        { 
         
          preven = [select id
                              from Account
                              where Identificacion__c =: candidato.Identificacion__c ];
            
         system.debug('Repetido' + preven);
             
            //string var2;
            prev = [select id
                              from PreVenta__c 
                              where Identificacion__c =: candidato.Identificacion__c ];
            
         system.debug('Repetidos_candidatos' + prospectos);
            
           // clientes = (select id from Account where Identificacion__c =: candidato.Identificacion__c);
		if (preven.size() > 0)
        {
            Activi = new task();
            string var1;
            string var2;
            string var3;
            string var4;
            string var5;
        
            var1= [select id
                   from Account
                   where Identificacion__c =: candidato.Identificacion__c ].id;
            
            var2= [select owner.id
                   from Account
                   where Identificacion__c =: candidato.Identificacion__c ].owner.id;
            
            var3= [select name
                   from Account
                   where Identificacion__c =: candidato.Identificacion__c ].name;
            
            var4= [select owner.name
                   from Account
                   where Identificacion__c =: candidato.Identificacion__c ].owner.name;
            
            var5= [select owner.email
                   from Account
                   where Identificacion__c =: candidato.Identificacion__c ].owner.email;
            
             system.debug('var1iii' + var1);
             system.debug('var2iii' + var2);
      
                activi.OwnerId = var2;
                activi.Subject= 'PROMOCIONES';
                activi.Status= 'No Iniciado';
                activi.Priority='Normal';
                activi.WhatId = var1;
            
                               
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Datos guardados correctamente' )); 
                         
            system.debug('INFORMACION' + activi);
            insert activi;
            
            
            reiniciar(); 
            //Envio de correo - Agregado 05-04-2019
						OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
						Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setHtmlBody( 'Buenas ' + var4 + ', Se le a asignado una tarea para el cliente ' + 
                                          var3 + ' desde el portal de PROMOCIONES.');
                        mail.setSubject('Se le a asignado una tarea desde el portal de PROMOCIONES');
                        mail.setToAddresses(new String[] {var5});
						mail.setOrgWideEmailAddressId(owea.get(0).Id);
                        mail.setSaveAsActivity(true);
                        listCorreo.add(mail);
                        Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
                        
        }
        else if  (prev.size() > 0)
        {
             Actividad = new task();
            string var2;
              var2= [select id
                              from PreVenta__c 
                              where Identificacion__c =: candidato.Identificacion__c ].id;
            
             system.debug('var2iii' + var2);
            
                Actividad.OwnerId = '005j000000BiDwQ';
                Actividad.Subject= 'PROMOCIONES';
                Actividad.Status= 'No Iniciado';
                Actividad.Priority='Normal';
            Actividad.WhatId = var2;
                  
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Datos guardados correctamente' )); 
             
            system.debug('INFORMACION' + Actividad);
            insert Actividad;
                        
            reiniciar();      
                       
             }
         else {
            
                
            //candidato.Motivo_Contacto__c = 'Referido';
            //nombrePersonaRefiere +=' '+candidato.Description; 
            //candidato.Description = nombrePersonaRefiere;
           
            candidato.RecordTypeId = natural.id;
            candidato.status = 'En Proceso';
            candidato.Usuario_Referencia__c = usuario;
            candidato.LeadSource='Web';
            insert candidato;
            candidato = new Lead();
            pop3 = False;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Datos guardados correctamente')); 
            
            
              
            /*
             string v1 = identificacion.replace('-', '');
             candidato.Identificacion__c = v1;
             */
            
            system.debug(candidato);  
             //identificacion
             //string v1 = candidato.Identificacion__c.replace('-', ''); 
             //candidato.Identificacion__c = v1;
             //candidato.Identificacion__c.replace('-', ''); 
             //system.debug('IdenForm' +  candidato.Identificacion__c); 
         
            reiniciar();      
         }
        
        }
        return null;//new pagereference('/apex/vfReferidos');
           //nombrePersonaRefiere = null; 
            //candidato.Description = null;
        }catch (exception e){
            system.debug(e.getLineNumber()+e.getMessage());
        }
        return null;
        
    }
    
    public void reiniciar()
    {      
        candidato.FirstName = NULL;
        candidato.LastName = NULL;
        identificacion = NULL;
        candidato.Email = NULL;
        candidato.Telefono_Trabajo__c = NULL;
        candidato.Phone = NULL;
        candidato.Motivo_Contacto__c = 'PROTECCIÓN INTEGRAL REDES';
        candidato.Departamento__c  = 'N/A';    
        
    }
    
    

}