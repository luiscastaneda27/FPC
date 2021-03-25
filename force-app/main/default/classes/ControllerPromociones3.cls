public class ControllerPromociones3 {
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
    public string parapais {get; set;}
    public string paisRes {get; set;}
    //public string nombrePersonaRefiere {get; set;}
    private RecordType natural;
    private map<id, Lead> mapProspectos;
    // private map<id, Leads> mapProspectos;
    
    //public List<SelectOption> options {get;set;}
    private string usuario;
    private string  clientes;
    
    public string pcDeptoCN {get;set;}
    public list<SelectOption> opcionDepartamento {get;set;}
    
    public string pais {get; set;}
    public string depto {get; set;}
    
    public list<selectoption> getPaises() {
        list<selectoption> options= new list<selectoption>();
        list<Pais_R__c> pais= [select Id,Name,codigo__c,nombre__c from Pais_R__c];
        options.add(new selectoption('0', ' --Ninguno-- '));
        for(Pais_R__c c:pais){ options.add(new selectoption(c.codigo__c,c.nombre__c));
                             }
        return options;
    }
    
    public list<selectoption> getDepart(){ 
        list<selectoption> options= new list<selectoption>();
        list<Departamentos__c> depto= [select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: pais];
        options.add(new selectoption('0', ' --Ninguno-- '));   
        for( Departamentos__c c:depto){ options.add(new selectoption(c.Departamento__c,c.Departamento__c));
                                      }
        return options;   
    }
    
    //public Fantasma_portal__c fantasma{get;Set;}
    
    //Función llamar estado
    
    public void llamarEstado(){
        try
        {
            opcionDepartamento = new list <selectOption>();
            opcionDepartamento.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Departamentos__c item:[select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: '053'])
            { opcionDepartamento.add(new selectOption( item.Departamento__c ,item.Departamento__c)); }
            
        }catch(exception e){
            
        }
    }
    
    public ControllerPromociones3(){
        candidato = new Lead();
        //    Actividades = new Lead();
        usuario = Apexpages.currentPage().getParameters().get('usuario');
        natural = [Select id From RecordType Where sObjectType = 'Lead' AND DeveloperName = 'Natural' Limit 1];
        pop3=true;
        candidato.Motivo_Contacto__c = 'Hondureños en el Extranjero';
        
        //candidato.Identificacion__c = v1;
        //candidato.Motivo_Contacto__c = apexpages.;
        //[select Motivo_Contacto__c from Motivo_Contacto ];
        //opcionColonia = new list <selectOption>();
        llamarEstado();
    }
    
    public pageReference guardarPop(){
        
        try{
            
            if(identificacion != null) //|| test.isRunningTest()) 
            { 
                candidato.Identificacion__c = identificacion.replace('-', ''); 
            }
            if(pais == '0') 
            { 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe seleccionar un País ')); return null;    
            }
            
            if(depto == '0') 
            { 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe seleccionar un Estado/Departamento ')); return null;  
            }
            
            list<Pais_R__c> FpaisC= [select Id,Name,codigo__c,nombre__c from Pais_R__c where codigo__c =: '052'];
            string vPaisC = FpaisC[0].codigo__c;
            
            if(candidato.Phone.length() > 8 && pais == vPaisC) 
            { 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Teléfono Móvil excede la cantidad de 8 caracteres permitidos ')); return null;    
            }
            if(candidato.Telefono_Trabajo__c != null){
                if(candidato.Telefono_Trabajo__c.length() > 8 ){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Teléfono Trabajo excede la cantidad de 8 caracteres permitidos '));
                    return null;
                }
            }
            if(candidato.Departamento__c  == '--Ninguno--')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe Seleccionar un Departamento '));
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
                    activi.Subject= 'Hondureños en el Extranjero';
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
                                     var3 + ' desde el portal de Hondureños en el Extranjero.');
                    mail.setSubject('Se le a asignado una tarea desde el portal de Hondureños en el Extranjero');
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
                    Actividad.Subject= 'Hondureños en el Extranjero';
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
                    
                    /*list<Pais_R__c> Fpais= [select Id,Name,codigo__c,nombre__c from Pais_R__c where codigo__c =: pais];
					string vPais = Fpais[0].Id;*/
                    Pais_R__c itemP = [SELECT id, name, nombre__c, codigo__c from Pais_R__c where codigo__c =: pais];
                    parapais = itemP.id;
                    paisRes = itemP.name;
                    
                    /*list<Departamentos__c> Fdepto= [select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: pais];
					string vDepto = Fdepto[0].Id;*/
                    Departamentos__c itemD = [select id,Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: pais AND Departamento__c =: depto];
                    string vDepto = itemD.Id;
                    string paradepto = itemD.Departamento__c;
                    
                    candidato.RecordTypeId = natural.id;
                    candidato.status = 'En Proceso';
                    candidato.Usuario_Referencia__c = usuario;
                    candidato.LeadSource='Web';
                    candidato.F_Hon_USA_Link_Ref__c = true;
                    //agregado 
                    candidato.F_Pais__c = parapais; 
                    candidato.Departamento__c = paradepto; 
                    candidato.Pais_Residencia__c = paisRes;
                    //fin
                    candidato.F_Estado__c = vDepto;
                    insert candidato;  
                                       
                    candidato = new Lead();
                    pop3 = False;
                    
                    System.debug('CANDIDATO: '+ candidato);
                    system.debug('PAISDEPTO ' +  parapais + 'DEPTO: ' + depto );
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Datos guardados correctamente')); 
                    
                    /*
string v1 = identificacion.replace('-', '');
candidato.Identificacion__c = v1;
*/
                      
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
        candidato.Motivo_Contacto__c = 'Hondureños en el Extranjero';
        candidato.Departamento__c  = 'N/A';  
        
    }        
}