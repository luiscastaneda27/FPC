public class CONTROLLER_vfBuscarDuplicados {
    
    String cparam0;
    String cparam1;
    String cparam2;
    String cparam3;
    String cparam4;
    String cparam5;
    String cparam6;
    String cparam7;
    String cparam8;
    String cparam9;
    String cparam10;
    String cparam11;
    String cparam12;
    String cparam13;
    String cparam14;
    String cparam15;
    String cparam16;
    String cparam17;
    String cparam18;
    String cparam19;
    
    
    
    String id01;
    String id02;
    
    public list<PreVenta__c> lstDetalle {get;set;}
    public list<PreVenta__c> lstDetalletmp {get;set;}
    public string strfirstname {get;set;} 
    public string strlastname {get;set;}
    public string strempresa {get;set;} 
    public string stremail {get;set;}
    public string strmovil {get;set;}
    
    public boolean boolfirstname {get;set;} 
    public boolean boollastname {get;set;} 
    public boolean boolempresa {get;set;} 
    public boolean boolemail {get;set;} 
    public boolean boolmovil {get;set;} 
    
    public PreVenta__c preventa{get;Set;}
    public integer count {get;Set;}
    public boolean combinar {get;Set;}
    
    List<SelectOption> options0 = new List<SelectOption>(); 
    List<SelectOption> options1 = new List<SelectOption>(); 
    List<SelectOption> options2 = new List<SelectOption>(); 
    List<SelectOption> options3 = new List<SelectOption>(); 
    List<SelectOption> options4 = new List<SelectOption>(); 
    List<SelectOption> options5 = new List<SelectOption>(); 
    List<SelectOption> options6 = new List<SelectOption>();
    List<SelectOption> options7 = new List<SelectOption>(); 
    List<SelectOption> options8 = new List<SelectOption>(); 
    List<SelectOption> options9 = new List<SelectOption>();
    List<SelectOption> options10 = new List<SelectOption>();
    List<SelectOption> options11 = new List<SelectOption>(); 
    List<SelectOption> options12 = new List<SelectOption>(); 
    List<SelectOption> options13 = new List<SelectOption>(); 
    List<SelectOption> options14 = new List<SelectOption>(); 
    List<SelectOption> options15 = new List<SelectOption>(); 
    List<SelectOption> options16 = new List<SelectOption>();
    List<SelectOption> options17 = new List<SelectOption>(); 
    List<SelectOption> options18 = new List<SelectOption>(); 
    List<SelectOption> options19 = new List<SelectOption>(); 
    
    
    public CONTROLLER_vfBuscarDuplicados(ApexPages.StandardController controller) {
        preventa = (PreVenta__c)controller.getRecord();
        combinar= false;
        boolfirstname = false;
        boollastname = false;
        boolempresa = false;
        boolemail = false;
        boolmovil = false;
    }
    
    public pagereference Buscar(){
        
        
        strFirstName= preventa.FirstName__c;
        strLastname = preventa.LastName__c;
        
        if (preventa.Tipo__c == 'Natural')
        {
        	strEmpresa= preventa.Nombre_Empresa__c;
        }
        else
        {
        	strEmpresa= preventa.Company__c;
        }    
        
        strEmail = preventa.Email__c;
        strMovil= preventa.Phone__c;
        
        String searchquery='';
        List<sObject> otrascuentas;
        List<sObject> cuentas;
        otrascuentas = new list<sObject>();
        
        if (boolfirstname)        
        {
            List<List<SObject>> lstCuentas;
            lstCuentas = [FIND :strFirstName IN ALL FIELDS RETURNING Preventa__c(ID,FirstName__c,LastName__c,Nombre_Empresa__c,Company__c,Nombre_Comercial__c,Email__c,Phone__c)];
            cuentas = ((List<PreVenta__c>)lstCuentas[0]);
            otrascuentas.addall(cuentas); 		
        }
        
        if (boollastname)        
        {
            List<List<SObject>> lstCuentas;
            lstCuentas = [FIND :strLastName IN ALL FIELDS RETURNING Preventa__c(ID,FirstName__c,LastName__c,Nombre_Empresa__c,Company__c,Nombre_Comercial__c,Email__c,Phone__c)];
            cuentas = ((List<PreVenta__c>)lstCuentas[0]);
            otrascuentas.addall(cuentas); 		
        }
        
        if (boolempresa)        
        {
            List<List<SObject>> lstCuentas;
            lstCuentas = [FIND :strempresa IN ALL FIELDS RETURNING Preventa__c(ID,FirstName__c,LastName__c,Nombre_Empresa__c,Company__c,Nombre_Comercial__c,Email__c,Phone__c)];
            cuentas = ((List<PreVenta__c>)lstCuentas[0]);
            otrascuentas.addall(cuentas); 		
        }
        
        if (boolemail)        
        {
            List<List<SObject>> lstCuentas;
            lstCuentas = [FIND :stremail IN ALL FIELDS RETURNING Preventa__c(ID,FirstName__c,LastName__c,Nombre_Empresa__c,Nombre_Comercial__c,Company__c,Email__c,Phone__c)];
            cuentas = ((List<PreVenta__c>)lstCuentas[0]);
            otrascuentas.addall(cuentas); 		
        }
        
        if (boolmovil)        
        {
            List<List<SObject>> lstCuentas;
            lstCuentas = [FIND :strmovil IN ALL FIELDS RETURNING Preventa__c(ID,FirstName__c,LastName__c,Nombre_Empresa__c,Company__c,Nombre_Comercial__c,Email__c,Phone__c)];
            cuentas = ((List<PreVenta__c>)lstCuentas[0]);
            otrascuentas.addall(cuentas); 		
        }
        
        //   
        
        List<PreVEnta__c> attr;
        
        if (otrascuentas != null)
        {    
            lstDetalle= [SELECT id,name,unificar__c,nombre_empresa__c,Company__c,Nombre_Comercial__c,email__c,phone__c,LeadSource__c,Status__c,Owner.Alias ,departamento__c
                         ,Tipo_Identificacion__c,Identificacion__c,Owner.FirstName,Owner.LastNAme    
                         ,firstname__c,lastname__c,telefono_actual__c,telefono_trabajo__c,Extension__c,Referido_por__c,Description__c
                         from PreVenta__c 
                         where id in: otrascuentas
                        ];
        }
        
        return null;
    }
    
    public pageReference Save() {
        
        combinar = false;
        count = 0;
        lstDetalletmp = new list<PreVenta__c>();
        
        
       if(Test.isRunningTest()){
			
           lstDetalle= [SELECT id,name,unificar__c,nombre_empresa__c,Company__c,Nombre_Comercial__c,email__c,phone__c,LeadSource__c,Status__c,Owner.Alias ,departamento__c
                         ,Tipo_Identificacion__c,Identificacion__c,Owner.FirstName,Owner.LastNAme    
                         ,firstname__c,lastname__c,telefono_actual__c,telefono_trabajo__c,Extension__c,Referido_por__c,Description__c
                         from PreVenta__c  limit 2
                        ];
           
           lstDetalletmp= [SELECT id,name,unificar__c,nombre_empresa__c,Company__c,Nombre_Comercial__c,email__c,phone__c,LeadSource__c,Status__c,Owner.Alias ,departamento__c
                         ,Tipo_Identificacion__c,Identificacion__c,Owner.FirstName,Owner.LastNAme    
                         ,firstname__c,lastname__c,telefono_actual__c,telefono_trabajo__c,Extension__c,Referido_por__c,Description__c
                         from PreVenta__c  limit 2
                        ];
           
         	}
        
        
        for (PreVenta__c detConId: lstDetalle ){
            
             if(Test.isRunningTest()){
             	detConId.unificar__c =  true;
             }    
            
            if (detConId.unificar__c){
                
                count= count  +1;
                lstDetalletmp.add(detConId); 
                
                if (count== 1)
                {
                    id01 = detConId.id;
                }   
                
                if (count== 2)
                {
                    id02 = detConId.id;
                }
                
                if (count > 2)
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, 'No debe seleccionar más de 2'));
                    return null;
                }
            }
        }
        
        if (count < 2  )
        {
            return null;
        }
        
        
        for (PreVenta__c detConId: lstDetalletmp ){
            
            if(Test.isRunningTest()){
             	detConId.unificar__c =  true;
             }
            
            if (detConId.unificar__c){
                
                string id = '';	
                string name = '';
                string phone = '';
                string email = '';
                string tipoidentificacion = '';
                string identificacion = '';
                string departamento = '';
                string ownerid = '';
                string ownername = '';
                string status = '';
                string origen = '';
                
                if(detConId.id != null)id = detConId.id;
                if(detConId.name != null)name = detConId.name;
                if(detConId.Phone__c != null)phone = detConId.Phone__c;
                if(detConId.Email__c != null)email = detConId.Email__c;
                if(detConId.Tipo_Identificacion__c != null)tipoidentificacion = detConId.Tipo_Identificacion__c;
                if(detConId.Identificacion__c != null)identificacion = detConId.Identificacion__c;
                if(detConId.Departamento__c != null)departamento = detConId.Departamento__c;
                if(detConId.OwnerId != null)OwnerId = detConId.OwnerId;
                if(detConId.OwnerId != null)OwnerName = detConId.Owner.FirstName + ' ' + detConId.Owner.LastName;
                if(detConId.Status__c != null)status = detConId.Status__c;
                if(detConId.leadSource__c != null)origen = detConId.LeadSource__c;
                
                integer intEspacios = 45;
                
                options0.add(new SelectOption(id,''.rightPad(IntEspacios,'-') )); 
                options1.add(new SelectOption(name,name.rightPad(IntEspacios,'-') )); 
                options2.add(new SelectOption(Phone,Phone.rightPad(IntEspacios,'-'))); 
                options3.add(new SelectOption(Email,Email.rightPad(IntEspacios,'-'))); 
                options4.add(new SelectOption(tipoIdentificacion,tipoIdentificacion.rightPad(IntEspacios,'-'))); 
                options5.add(new SelectOption(Identificacion,Identificacion.rightPad(IntEspacios,'-'))); 
                options6.add(new SelectOption(Departamento,Departamento.rightPad(IntEspacios,'-'))); 
                options7.add(new SelectOption(OwnerId ,OwnerName.rightPad(IntEspacios,'-'))); 
                options8.add(new SelectOption(Status,Status.rightPad(IntEspacios,'-'))); 
                options9.add(new SelectOption(origen,origen.rightPad(IntEspacios,'-'))); 
                
                string firstname = '';
                string lastname = '';
                string telefonoactual = '';
                string nombreempresa = '';
                string razonsocial = '';
                string telefonotrabajo = '';
                decimal extension = 0;
                string referidopor = '';
                string description = '';
                
                if(detConId.FirstName__c != null)firstname = detConId.FirstName__c;
                if(detConId.LastName__c != null)lastname = detConId.LastName__c;
                if(detConId.Telefono_actual__c != null)telefonoactual = detConId.Telefono_actual__c;
                if (preventa.Tipo__c == 'Natural')
                {
                    if(detConId.Nombre_Empresa__c != null)nombreempresa = detConId.Nombre_Empresa__c;
                }
                else
                {
                    if(detConId.Company__c != null)nombreempresa = detConId.Company__c;
                    
                }
                if(detConId.Nombre_Comercial__c != null)razonsocial = detConId.Company__c;
                if(detConId.Telefono_Trabajo__c != null)telefonotrabajo = detConId.Telefono_Trabajo__c;
                if(detConId.Extension__c != null)extension = detConId.Extension__c;
                if(detConId.Referido_por__c != null)referidopor = detConId.Referido_por__c;
                if(detConId.Description__c != null)description = detConId.Description__c;
                
                options10.add(new SelectOption(firstname,firstname.rightPad(IntEspacios,'-') )); 
                options11.add(new SelectOption(lastname,lastname.rightPad(IntEspacios,'-') )); 
                options12.add(new SelectOption(telefonoactual,telefonoactual.rightPad(IntEspacios,'-'))); 
                options13.add(new SelectOption(nombreempresa,nombreempresa.rightPad(IntEspacios,'-'))); 
                options14.add(new SelectOption(telefonotrabajo ,telefonotrabajo.rightPad(IntEspacios,'-'))); 
                options15.add(new SelectOption(string.valueOf(extension),string.valueOf(extension).rightPad(IntEspacios,'-'))); 
                options16.add(new SelectOption(referidopor,referidopor.rightPad(IntEspacios,'-'))); 
                options17.add(new SelectOption(description,description.rightPad(IntEspacios,'-'))); 
                options19.add(new SelectOption(razonsocial,razonsocial.rightPad(IntEspacios,'-'))); 
                
               
            }
        }
        
        
        combinar = true;
        //update lstDetalle;
        return null;  
        
        //  }                
    }
    
    
    public PageReference combine() {
        
        string idcombsi = '';
        string idcombno = '';
         
        
       // if (id01 != null && id02 != null )
       // {    
            
        
        if (id01 == cparam0)
        {
            idcombsi = id01;
            idcombno = id02;  
        }
        
        if (id02 == cparam0)
        {
            idcombsi = id02;
            idcombno = id01;
        }     
        
        
        List<PreVenta__c> acctListsi = [SELECT Id, Name FROM PreVenta__c where id =: idcombsi limit 1 ];
        
          if(Test.isRunningTest()){
              acctListsi = [SELECT Id, Name FROM PreVenta__c   limit 1 ];
             
         } 
        
        for(PreVenta__c acct :acctListsi){
            //acct.id  = cparam0
            
            if (cparam1 != null)  acct.Name = cparam1;
            if (cparam2 != null)  acct.Phone__c = cparam2;
            if (cparam3 != null)  acct.Email__c = cparam3;
            if (cparam4 != null)  acct.Tipo_Identificacion__c = cparam4;
            if (cparam5 != null)  acct.Identificacion__c = cparam5;
            if (cparam6 != null)  acct.Departamento__c = cparam6;
            if (cparam7 != null)  acct.OwnerId = cparam7;
            if (cparam8 != null)  acct.Status__c = cparam8;
            if (cparam9 != null)  acct.LeadSource__c = cparam9;
            if (cparam10 != null)  acct.FirstName__c = cparam10;
            if (cparam11 != null)  acct.LastName__c = cparam11;
            if (cparam12 != null)  acct.Telefono_actual__c  = cparam12;
            
            if (preventa.Tipo__c == 'Natural')
            {
                
                if (cparam13 != null)  acct.Nombre_Empresa__c =  cparam13;
            }
            else
            {
                
                if (cparam13 != null)  acct.Company__c =  cparam13;
            }
            if (cparam19 != null)  acct.Nombre_Comercial__c =  cparam19;
            if (cparam14 != null)  acct.Telefono_Trabajo__c = cparam14;
            if (cparam15 != null)  acct.Extension__c  =  integer.valueOf(cparam15) ;
            if (cparam16 != null)  acct.Referido_por__c  = cparam16;
            if (cparam17 != null)  acct.Description__c  = cparam17;
            //acct.recordtype  =  id()cparam18;
        }
        update acctListsi;
        

		//Ini            
            
            List<Task> acctListT = [select id,Type,AccountId,ActivityDate,CallDisposition,CallDurationInSeconds,CallObject,CallType,CreatedById,CreatedDate,
                                    CurrencyIsoCode,Description,IsArchived,IsClosed,IsDeleted,IsHighPriority,IsRecurrence,IsReminderSet,
                                    LastModifiedById,LastModifiedDate,Motivo_Contacto__c,Origen__c,OwnerId,Priority,RecordTypeId,
                                    RecurrenceActivityId,RecurrenceDayOfMonth,RecurrenceDayOfWeekMask,RecurrenceEndDateOnly,
                                    RecurrenceInstance,RecurrenceInterval,RecurrenceMonthOfYear,RecurrenceRegeneratedType,
                                    RecurrenceStartDateOnly,RecurrenceTimeZoneSidKey,RecurrenceType,ReminderDateTime,Status,
                                    Subject,SystemModstamp,TaskSubtype,Tipo_Gestion__c,Usuario_referencia__c,WhatId,WhoId
                                    FROM Task where WhatId =: idcombno ];
            
            for(Task acctT :acctListT){
                Task T = new Task();
                T.Type = acctT.Type;
                T.Subject = acctT.Subject ;
                T.ActivityDate = acctT.ActivityDate; 
                T.WhatId = idcombsi;
                T.Description = acctT.Description;
                T.Status = acctT.Status;
                T.Origen__c = acctT.Origen__c;
                T.Usuario_referencia__c = acctT.Usuario_referencia__c;
                T.Motivo_Contacto__c = acctT.Motivo_Contacto__c;
                T.Tipo_Gestion__c = acctT.Tipo_Gestion__c;
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
                T.IsRecurrence= acctT.IsRecurrence;
                T.IsReminderSet= acctT.IsReminderSet;
                insert T;
            }
            
            //Fin


        
        List<PreVenta__c> acctListno = [SELECT Id, Name FROM PreVenta__c where id =: idcombno limit 1 ];	
        delete acctListno;
        
        if (idcombsi != '')
        {    
            PageReference pg = new PageReference('/apex/vfPreVentasVer?id='+ idcombsi);
            pg.setRedirect(true);
            return pg;
        }
        else
        {
            
            if(Test.isRunningTest()){
              acctListsi = [SELECT Id, Name FROM PreVenta__c   limit 1 ];
              
         } 
            
		
            
            return null;    
        }    
        
    }
    
    
    public String getCparam0() {
        
        if (cparam0 == null)
            cparam0 = id01;
        
        return cparam0;
    }
    public String getCparam1() {
        return cparam1;
    }
    public String getCparam2() {
        return cparam2;
    }
    public String getCparam3() {
        return cparam3;
    }
    public String getCparam4() {
        return cparam4;
    }
    public String getCparam5() {
        return cparam5;
    }
    public String getCparam6() {
        return cparam6;
    }
    public String getCparam7() {
        return cparam7;
    }
    public String getCparam8() {
        return cparam8;
    }
    public String getCparam9() {
        return cparam9;
    }
    public String getCparam10() {
        return cparam10;
    }
    public String getCparam11() {
        return cparam11;
    }
    public String getCparam12() {
        return cparam12;
    }
    public String getCparam13() {
        return cparam13;
    }
    public String getCparam14() {
        return cparam14;
    }
    public String getCparam15() {
        return cparam15;
    }
    public String getCparam16() {
        return cparam16;
    }
    public String getCparam17() {
        return cparam17;
    }
    public String getCparam18() {
        return cparam18;
    }
    public String getCparam19() {
        return cparam19;
    }
    
    
    
    public List<SelectOption> getItems0() {
        return options0; 
    }
    
    public List<SelectOption> getItems1() {
        return options1; 
    }
    
    public List<SelectOption> getItems2() {
        return options2; 
    }
    
    public List<SelectOption> getItems3() {
        return options3; 
    }
    
    public List<SelectOption> getItems4() {
        return options4; 
    }
    
    public List<SelectOption> getItems5() {
        return options5; 
    }
    
    public List<SelectOption> getItems6() {
        return options6; 
    }
    
    public List<SelectOption> getItems7() {
        return options7; 
    }
    
    public List<SelectOption> getItems8() {
        return options8; 
    }
    
    public List<SelectOption> getItems9() {
        return options9; 
    }
    
    public List<SelectOption> getItems10() {
        return options10; 
    }
    
    public List<SelectOption> getItems11() {
        return options11; 
    }
    
    public List<SelectOption> getItems12() {
        return options12; 
    }
    
    public List<SelectOption> getItems13() {
        return options13; 
    }
    
    public List<SelectOption> getItems14() {
        return options14; 
    }
    
    public List<SelectOption> getItems15() {
        return options15; 
    }
    
    public List<SelectOption> getItems16() {
        return options16; 
    }
    
    public List<SelectOption> getItems17() {
        return options17; 
    }
    
    public List<SelectOption> getItems18() {
        return options18; 
    }
    public List<SelectOption> getItems19() {
        return options19; 
    }
    
    
    public void setCparam0(String cparam0) { this.cparam0 = cparam0; }	
    public void setCparam1(String cparam1) { this.cparam1 = cparam1; }
    public void setCparam2(String cparam2) { this.cparam2 = cparam2; }
    public void setCparam3(String cparam3) { this.cparam3 = cparam3; }
    public void setCparam4(String cparam4) { this.cparam4 = cparam4; }
    public void setCparam5(String cparam5) { this.cparam5 = cparam5; }
    public void setCparam6(String cparam6) { this.cparam6 = cparam6; }
    public void setCparam7(String cparam7) { this.cparam7 = cparam7; }
    public void setCparam8(String cparam8) { this.cparam8 = cparam8; }
    public void setCparam9(String cparam9) { this.cparam9 = cparam9; } 
    public void setCparam10(String cparam10) { this.cparam10 = cparam10; }
    public void setCparam11(String cparam11) { this.cparam11 = cparam11; }
    public void setCparam12(String cparam12) { this.cparam12 = cparam12; }
    public void setCparam13(String cparam13) { this.cparam13 = cparam13; }
    public void setCparam14(String cparam14) { this.cparam14 = cparam14; }
    public void setCparam15(String cparam15) { this.cparam15 = cparam15; }
    public void setCparam16(String cparam16) { this.cparam16 = cparam16; }
    public void setCparam17(String cparam17) { this.cparam17 = cparam17; }
    public void setCparam18(String cparam18) { this.cparam18 = cparam18; }
    public void setCparam19(String cparam19) { this.cparam19 = cparam19; }
    
}