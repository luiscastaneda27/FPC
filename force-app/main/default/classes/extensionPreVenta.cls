public class extensionPreVenta {
    
    public PreVenta__c preventa{get;Set;}
    public list<Account> lstDetalle {get;set;}
    public boolean natural{get;set;}
    
    
    string clientes  = null;
    List<SelectOption> options = new List<SelectOption>(); 
    
    public String getclientes() {
        return clientes;
    }
    
    public void setclientes(String clientes ) { this.clientes = clientes; }
    
    public List<SelectOption> getItems() {
        
        List<sObject> cuentas = new List<sObject>();
        List<List<SObject>> lstCuentas = [FIND :preventa.Name IN ALL FIELDS RETURNING Account(ID,Name,FirstName,LastName,Nombre_Comercial__C)  ];
        
        
        if (lstCuentas.size() > 0) {
        	cuentas = ((List<Account>)lstCuentas[0]);
        }
        if (cuentas != null){    
            lstDetalle= [SELECT id,name from Account
                         where id in: cuentas 
                        ];
        }
        options.add(new SelectOption(preventa.id,'Crear Nuevo Cliente: ' + preventa.name)); 
        for (Account detConId: lstDetalle ){
            options.add(new SelectOption(detconId.id,'Adjuntar a existente: ' + detconId.Name)); 
        }
        
        return options; 
    }
    
    public List<SelectOption> getItemsDos() {
        
        List<sObject> cuentas;
        List<List<SObject>> lstCuentas;
        lstCuentas = [FIND :preventa.Company__C IN ALL FIELDS RETURNING Account(ID,Nombre_Comercial__C)  ];
        
        
        if (lstCuentas != null)
        {   
        cuentas = ((List<Account>)lstCuentas[0]);
        }
        
        
        if (cuentas != null)
        {    
            lstDetalle= [SELECT id,name,Nombre_Comercial__C from Account
                         where id in: cuentas
                        ];
        }
        options.add(new SelectOption(preventa.id,'Crear Nuevo Cliente: ' + preventa.Company__C)); 
        
        for (Account detConId: lstDetalle ){
            
            
            if (detconId.id != preventa.id)
            {     
                options.add(new SelectOption(detconId.id,'Adjuntar a existente: ' + detconId.Nombre_Comercial__C)); 
            }
            
        }
        
        return options; 
    }
    
    
    
    
    public extensionPreventa(ApexPages.StandardController controller) {
        preventa = (PreVenta__c)controller.getRecord();
        
        if(preventa.id == null){
            preventa.ownerId = userInfo.getUserId();
        }
        
        natural = false;
        
        if ( preventa.recordTypeId != null) {
            RecordType tipoR = [Select developerName From RecordType Where Id =: preventa.recordTypeId];
            if(tipoR.developerName == 'Natural'){
                natural = true;
            }
            
        }
        
    }
    
    
    public PageReference convert() {
        
        update preventa;
        
        string resp = '';
        
        if (preventa.id == clientes)
        {
            resp = 'Si';
        }    
        else
        {
            resp = 'No';
        }    
        
        
        
        List<preventa__c> acctList = [SELECT Id,RecordTypeID, FirstName__c,LastName__c,Cliente_Localizable__c,CurrencyIsoCode,Departamento__c,Email__c,LeadSource__c,Description__c
                                      ,Nombre_Empresa__c,Phone__c,Convertir_Tarea__c,Convertir_Fecha_Vencimiento__c,Convertir_Comentario__c,Nombre_Comercial__C,Company__C
                                      ,Tipo_Identificacion__c,identificacion__c,Telefono_Trabajo__c, Referido_por__c, Motivo_Contacto__c, Canal_que_Refiere__c, Agencia_Refiere__c
                                      FROM Preventa__c where id =: preventa.id ];
        system.debug('Natural: '+natural);
        for(PreVenta__c acct :acctList){
            
            
            id rctid;
            Account obj;
            
            if (natural)      
            {
                rctid = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
                obj = new Account (            
                    Cliente_Localizable__pc = acct.Cliente_Localizable__c,
                    FirstName = acct.FirstName__c,
                    LastName = acct.LastName__c,
                    PersonEmail = acct.Email__c,
                    PersonLeadSource = acct.LeadSource__c,
                    
                    //Name =  acct.Company__c,
                    
                    
                    CurrencyIsoCode = acct.CurrencyIsoCode,
                    Departamento__c = acct.Departamento__c,
                    
                    AccountSource = acct.LeadSource__c,
                    Tipo_Identificacion__c=  acct.Tipo_Identificacion__c ,
                    Identificacion__c= 	acct.Identificacion__c ,
                    Nombre_Empresa__c = acct.Nombre_Empresa__c,
                    Telefono_Empresa__c = acct.Telefono_Trabajo__c,
                    Celular__c = acct.Phone__c,
                    
                    Referido_por__c = acct.Referido_por__c,
                    Description__c = acct.Description__c,
                    Motivo_de_Contacto__c = acct.Motivo_Contacto__c,
                    Canal_que_Refiere__c = acct.Canal_que_Refiere__c,
                    Agencia_Refiere__c = acct.Agencia_Refiere__c,
                    Usuario_Convirtio__c = UserInfo.getUserId(),
                    Fecha_Convirtio__c = Datetime.now(),
                    recordTypeid = rctid //acct.RecordTypeId
                    //owner = acct.owner
                );  
            }
            else{
                rctid = [Select id,developerName From RecordType where   sObjectType = 'Account' and name = 'Juridico'].id;
                obj = new Account (            
                                        
                    Name =  acct.Company__c,
                    
                    
                    CurrencyIsoCode = acct.CurrencyIsoCode,
                    Departamento__c = acct.Departamento__c,
                    
                    AccountSource = acct.LeadSource__c,
                    Tipo_Identificacion__c=  acct.Tipo_Identificacion__c ,
                    Identificacion__c= 	acct.Identificacion__c ,
                    Nombre_Empresa__c = acct.Nombre_Empresa__c,
                    Nombre_Comercial__c = acct.Nombre_Comercial__c,
                    Telefono_Empresa__c = acct.Telefono_Trabajo__c,
                    Celular__c = acct.Phone__c,
                    
                    Usuario_Convirtio__c = UserInfo.getUserId(),
                    Fecha_Convirtio__c = Datetime.now(),
                    recordTypeid = rctid //acct.RecordTypeId
                );      
            }
            
            String personContactId;
            if (preventa.id == clientes)  //Escogio crear nuevo
            {
                insert obj;
            }  
            else
            {
                obj.Id = clientes;
                //Actualizamos el cliente
                List<Account> acctListCliente = [select id,Usuario_Convirtio__c,Fecha_Convirtio__c,Nombre_Comercial__C,Referido_por__c, Motivo_de_Contacto__c,
                                                 Canal_que_Refiere__c, Agencia_Refiere__c, PersonLeadSource, Description__c,PersonContactId
                                                 from Account where id =:  clientes];
                
                for(Account acctc :acctListCliente){
                    acctc.Referido_por__c = acct.Referido_por__c;
                    acctc.Description__c = acct.Description__c;
                    acctc.PersonLeadSource = acct.LeadSource__c;
                    acctc.Motivo_de_Contacto__c = acct.Motivo_Contacto__c;
                    acctc.Canal_que_Refiere__c = acct.Canal_que_Refiere__c;
                    acctc.Agencia_Refiere__c = acct.Agencia_Refiere__c;
                    acctc.Usuario_Convirtio__c = UserInfo.getUserId();
                    acctc.Fecha_Convirtio__c = Datetime.now();
                    personContactId = acctc.PersonContactId;
                }

                update acctListCliente;
                
                
            }
            
            
            
            //Ini            
            
            List<Task> acctListT = [select id,Type,AccountId,ActivityDate,CallDisposition,CallDurationInSeconds,CallObject,CallType,CreatedById,CreatedDate,
                                    CurrencyIsoCode,Description,IsArchived,IsClosed,IsDeleted,IsHighPriority,IsRecurrence,IsReminderSet,
                                    LastModifiedById,LastModifiedDate,Motivo_Contacto__c,Origen__c,OwnerId,Priority,RecordTypeId,
                                    RecurrenceActivityId,RecurrenceDayOfMonth,RecurrenceDayOfWeekMask,RecurrenceEndDateOnly,
                                    RecurrenceInstance,RecurrenceInterval,RecurrenceMonthOfYear,RecurrenceRegeneratedType,
                                    RecurrenceStartDateOnly,RecurrenceTimeZoneSidKey,RecurrenceType,ReminderDateTime,Status,
                                    Subject,SystemModstamp,TaskSubtype,Tipo_Gestion__c,Usuario_referencia__c,WhatId,WhoId
                                    FROM Task where WhatId =: preventa.id ];
            // FROM Task where WhatId =: pre ];
            
            for(Task acctT :acctListT){
                Task T = new Task();
                T.Type = acctT.Type;
                T.Subject = acctT.Subject ; //string
                T.ActivityDate = acctT.ActivityDate; //user id
                
                //T.WhatId = obj.id; //record id
                if (preventa.id == clientes)
                {
                    T.WhatId = obj.id;
                }    
                else
                {
                    T.WhatId = clientes;
                }
                
                
                T.Description = acctT.Description;
                T.Status = acctT.Status;
                T.Origen__c = acctT.Origen__c;
                T.Usuario_referencia__c = acctT.Usuario_referencia__c;
                T.Motivo_Contacto__c = acctT.Motivo_Contacto__c;
                T.Tipo_Gestion__c = acctT.Tipo_Gestion__c;
                //T.RecurrenceActivityId = acctT.RecurrenceActivityId;
                T.RecurrenceDayOfMonth  = acctT.RecurrenceDayOfMonth;
                T.RecurrenceDayOfWeekMask  = acctT.RecurrenceDayOfWeekMask;
                T.RecurrenceEndDateOnly = acctT.RecurrenceEndDateOnly;
                T.RecurrenceInstance = acctT.RecurrenceInstance;
                T.RecurrenceInterval = acctT.RecurrenceInterval;
                T.RecurrenceMonthOfYear = acctT.RecurrenceMonthOfYear;
                T.RecurrenceRegeneratedType = acctT.RecurrenceRegeneratedType;
                T.RecurrenceStartDateOnly = acctT.RecurrenceStartDateOnly;
                T.RecurrenceTimeZoneSidKey = acctT.RecurrenceTimeZoneSidKey;
                T.RecurrenceType = acctT.RecurrenceType;
                T.ReminderDateTime = acctT.ReminderDateTime;
                T.Priority = acctT.Priority;
                //T.IsArchived = acctT.IsArchived;
                //T.IsClosed = acctT.IsClosed;
                //T.IsDeleted = acctT.IsDeleted;
                //T.IsHighPriority = acctT.IsHighPriority;
                T.IsRecurrence= acctT.IsRecurrence;
                T.IsReminderSet= acctT.IsReminderSet;
                insert T;
            }
            
            //Fin
            //Insertamos la tarea
            
            Task T = new Task();
            //T.Type = 'Email';
            T.Subject = acct.Convertir_Tarea__c ; //string
            T.ActivityDate = acct.Convertir_Fecha_Vencimiento__c; //user id
            
            //T.WhatId = obj.id;
            
            if (preventa.id == clientes)
            {
                T.WhatId = obj.id;
            }    
            else
            {
                T.WhatId = clientes;
            }
            
            
            T.Description = acct.Convertir_Comentario__c;
            T.Status = 'Completado';
            insert T;

           
            List<Event> ListEvento = [select id,Type,Subject, Asunto__c, Cuerpo__c, Description, De__c,Usuario_referencia__c,
                                             StartDateTime,EndDateTime,WhatId,WhoId,IsAllDayEvent,Location
                                      FROM Event where WhatId =: preventa.id ];  
            
            List<Event> Listnu = new List<Event>();
            /*
            system.debug('ListaEvent' + ListEvento);
            system.debug('WhatId' + obj.id);
            system.debug('prevenID' + preventa.id);
            system.debug('Clientes' + clientes);
            */
            for(integer i=0; i<ListEvento.size(); i++){
                Event e = new Event();
                
                E.WhatId = obj.id;
                E.WhoId = personContactId;
                //E.Id = evento.Id;
                E.Subject = ListEvento[i].Subject;
                E.Asunto__c = ListEvento[i].Asunto__c;
                E.Description = ListEvento[i].Description;
                E.Usuario_referencia__c = ListEvento[i].Usuario_referencia__c;
                E.StartDateTime = ListEvento[i].StartDateTime;
                E.EndDateTime = ListEvento[i].EndDateTime;
                E.Location = ListEvento[i].Location;
                E.IsAllDayEvent = ListEvento[i].IsAllDayEvent;
                Listnu.add(E);
            }
            
            system.debug('ListNU' + Listnu);
            
            insert Listnu;
           
            
            /*FIN*/
             
            //Borramos la preventa
            List<PreVenta__c> acctListno = [SELECT Id, Name FROM PreVenta__c where id =: preventa.id  limit 1 ];	
            delete acctListno;
            
            
            system.debug('Id CLiente: '+obj.Id);
            if (preventa.id == clientes)
            {
                PageReference pg = new PageReference('/' + obj.id );
                pg.setRedirect(true);		
                return pg;
            } 
            else
            {
                PageReference pg = new PageReference('/' + clientes );
                pg.setRedirect(true);
                return pg;
            }
            
            
            
            
        }
        
        
        return null;
        
    }
}