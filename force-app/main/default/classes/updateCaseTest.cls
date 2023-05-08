@isTest
public class updateCaseTest {
    
  @isTest
  public static void execute() {
        
      if(!System.isFuture() && !System.isBatch()) {
          //crear cuenta
          Account acc = new Account(); 
          acc.Identificacion__c = '0801399412010';    
          acc.Name = 'Test Account';
          insert acc;
          
          Contact con = new Contact(FirstName='john', LastName='doe', Email='john@doe.com', AccountId=acc.Id);
          insert con;
          
          Asset ass = new Asset(AccountId=acc.Id,ContactId=con.Id, Name='testing');   
          insert ass;
          
          Entitlement ent = new Entitlement(Name='Testing', AccountId=acc.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
          insert ent;
          
          FechaDC_Sysde__c fdcSysde2 = new FechaDC_Sysde__c(Name = 'CierreAlDia2', Fecha_cierre__c  = date.today());
          insert fdcSysde2;
          
          Profile prof = [select id from profile where Name='Administrador del Sistema'];
          User user = new User();
          user.firstName = 'test1';
          user.lastName = 'test2';
          user.profileId = prof.id;
          user.username = 'standarduser2020@testorg.com';
          user.email = 'standarduser2020@testorg.com';
          user.Alias = 'standar';
          user.LocaleSidKey='en_US';
          user.TimeZoneSidKey='America/Los_Angeles';
          user.EmailEncodingKey='UTF-8';
          user.LanguageLocaleKey='en_US';        
          insert user;
          
          String RecordTypeId = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Email to Case'].Id;    
          Case c0 = new Case();
          c0.AccountId = acc.Id;
          c0.ContactId = con.Id;    
          c0.EntitlementId = ent.Id;
          c0.Priority = 'Alta';
          c0.OwnerId = user.Id;
          c0.RecordTypeId = RecordTypeId; 
          c0.SuppliedEmail = 'test@gmail.com';
          c0.Caso_Ingresado__c = false;
          c0.Status = 'Nuevo';
          c0.Origin = 'Agencias FPC';
          c0.Type = 'Solicitud';                  
          Insert c0;       
          
          String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Reposición de Carnet'].Id;        
          Case c = new Case();
          c.AccountId = acc.Id;
          c.ContactId = con.Id;    
          c.EntitlementId = ent.Id;
          c.Priority = 'Alta';
          c.OwnerId = user.Id;
          c.Reason = 'Otro';
          c.RecordTypeId = RecordTypeId2; 
          c.SuppliedEmail = 'test@gmail.com';
          c.Caso_Ingresado__c = false;        
          c.Status = 'Nuevo';
          c.Origin = 'Agencias FPC';
          c.Type = 'Solicitud';                
          Insert c;     
          
          Case c1 = new Case();
          c1.Priority = 'Alta';
          c1.OwnerId = user.Id;
          c1.EntitlementId = ent.Id;
          c1.RecordTypeId = RecordTypeId; 
          c1.SuppliedEmail = 'test@gmail.com';
          c1.Caso_Ingresado__c = false;
          c1.Status = 'Nuevo'; 
          c1.Origin = 'Agencias FPC';  
          c1.DAU_Tarjeta_de_Sysde__c = '456787654';  
          c1.DAU_No_Cuenta__c = '545678';    
          Insert c1;    
          
          List<Id> setCaseId = new List<Id>();
          setCaseId.add(c.id);
          
          set<Id> setCaseIds = new set<Id>();
          setCaseIds.add(c.id);
          
          set<Id> casoOrigen = new set<Id>();
          casoOrigen.add(c.Id);    
          
          Producto__c prod = new Producto__c();
          prod.Name = 'PENSIONES LEMPIRAS';
          prod.Codigo__c = '01';
          Insert prod;
          
          Subproducto__c subProd = new Subproducto__c();
          subProd.Producto__c = prod.Id;
          subProd.Codigo__c = 'FI010';
          Insert subProd;
          
          Cuentas__c cuenta = new Cuentas__c();
          cuenta.Name = '87675';
          cuenta.Codigo__c = '87675';
          cuenta.Cliente__c = acc.Id;
          cuenta.CurrencyIsoCode = 'HNL';
          cuenta.Producto__c = prod.Id;
          cuenta.Subproducto__c = subProd.Id;
          cuenta.Forma_Aportacion__c = 'TA';
          cuenta.Fondo_Inversion__c = '113';
          Insert Cuenta;
          
          Detalle_caso__c detC = new Detalle_caso__c();
          detC.Caso__c = c.Id;
          detC.Cuenta__c = cuenta.Id;
          detC.Tipo_Operacion__c = 'A6';
          detC.N_Cuenta_Bancaria__c = '456788765';
          detC.Banco__c = '28';    
          Insert detC;    
          
          Test.startTest();
          String body = '[{"CARD_NUMBER":"5184002009194856","ACCOUNT_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_TYPE":"1","CUSTOMER_ID":"30825397.3333333","CARD_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_NUMBER":"50009531998656","PRODUCT":"TRC","AFINITY_GROUP":"500","ACCOUNT_STATUS":"10 - Cuenta Normal","CARD_STATUS":"20 - Tarjeta Normal","CARD_EXPIRATION_DATE":"2026-11-30T00:00:00.000-06:00"}]';
    	  Integer code = 200;
          Test.setMock(HttpCalloutMock.class, new UT_SeviceMockRest(body, code));
          updateCase.processCase(setCaseId);
          updateCase.processCasePortalAuto(setCaseIds);
          updateCase.createDetail(setCaseId, casoOrigen);
          Test.stopTest();
      }
  }
    
  @isTest
  public static void execute2() {
        
      if(!System.isFuture() && !System.isBatch()) {
          //crear cuenta
          Account acc = new Account(); 
          acc.Identificacion__c = '0801399412010';    
          acc.Name = 'Test Account';
          insert acc;
          
          Contact con = new Contact(FirstName='john', LastName='doe', Email='john@doe.com', AccountId=acc.Id);
          insert con;
          
          Asset ass = new Asset(AccountId=acc.Id,ContactId=con.Id, Name='testing');   
          insert ass;
          
          Entitlement ent = new Entitlement(Name='Testing', AccountId=acc.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
          insert ent;
          
          FechaDC_Sysde__c fdcSysde2 = new FechaDC_Sysde__c(Name = 'CierreAlDia2', Fecha_cierre__c  = date.today());
          insert fdcSysde2;
          
          Profile prof = [select id from profile where Name='Administrador del Sistema'];
          User user = new User();
          user.firstName = 'test1';
          user.lastName = 'test2';
          user.profileId = prof.id;
          user.username = 'standarduser2020@testorg.com';
          user.email = 'standarduser2020@testorg.com';
          user.Alias = 'standar';
          user.LocaleSidKey='en_US';
          user.TimeZoneSidKey='America/Los_Angeles';
          user.EmailEncodingKey='UTF-8';
          user.LanguageLocaleKey='en_US';        
          insert user;
          
          String RecordTypeId = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Email to Case'].Id;    
          Case c0 = new Case();
          c0.AccountId = acc.Id;
          c0.ContactId = con.Id;    
          c0.EntitlementId = ent.Id;
          c0.Priority = 'Alta';
          c0.OwnerId = user.Id;
          c0.RecordTypeId = RecordTypeId; 
          c0.SuppliedEmail = 'test@gmail.com';
          c0.Caso_Ingresado__c = false;
          c0.Status = 'Nuevo';
          c0.Origin = 'Agencias FPC';
          c0.Type = 'Solicitud';                  
          Insert c0;       
          
          String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Reposición de Carnet'].Id;        
          Case c = new Case();
          c.AccountId = acc.Id;
          c.ContactId = con.Id;    
          c.EntitlementId = ent.Id;
          c.Priority = 'Alta';
          c.OwnerId = user.Id;
          c.Reason = 'Otro';
          c.RecordTypeId = RecordTypeId2; 
          c.SuppliedEmail = 'test@gmail.com';
          c.Caso_Ingresado__c = false;        
          c.Status = 'Nuevo';
          c.Origin = 'Agencias FPC';
          c.Type = 'Solicitud';                
          Insert c;     
          
          Case c1 = new Case();
          c1.Priority = 'Alta';
          c1.OwnerId = user.Id;
          c1.RecordTypeId = RecordTypeId; 
          c1.EntitlementId = ent.Id;
          c1.SuppliedEmail = 'test@gmail.com';
          c1.Caso_Ingresado__c = false;
          c1.Status = 'Nuevo'; 
          c1.Origin = 'Agencias FPC';  
          c1.DAU_Tarjeta_de_Sysde__c = '456787654';  
          c1.DAU_No_Cuenta__c = '545678';    
          Insert c1;    
          
          List<Id> setCaseId = new List<Id>();
          setCaseId.add(c.id);
          
          set<Id> setCaseIds = new set<Id>();
          setCaseIds.add(c.id);
          
          set<Id> casoOrigen = new set<Id>();
          casoOrigen.add(c.Id);    
          
          Producto__c prod = new Producto__c();
          prod.Name = 'PENSIONES LEMPIRAS';
          prod.Codigo__c = '01';
          Insert prod;
          
          Subproducto__c subProd = new Subproducto__c();
          subProd.Producto__c = prod.Id;
          subProd.Codigo__c = 'FI010';
          Insert subProd;
          
          Cuentas__c cuenta = new Cuentas__c();
          cuenta.Name = '87675';
          cuenta.Codigo__c = '87675';
          cuenta.Cliente__c = acc.Id;
          cuenta.CurrencyIsoCode = 'HNL';
          cuenta.Producto__c = prod.Id;
          cuenta.Subproducto__c = subProd.Id;
          cuenta.Forma_Aportacion__c = 'TA';
          cuenta.Fondo_Inversion__c = '113';
          Insert Cuenta;
          
          Detalle_caso__c detC = new Detalle_caso__c();
          detC.Caso__c = c.Id;
          detC.Cuenta__c = cuenta.Id;
          detC.Tipo_Operacion__c = 'A6';
          detC.N_Cuenta_Bancaria__c = '456788765';
          detC.Banco__c = 'Otros Bancos';    
          Insert detC;    
          
          Test.startTest();
          String body = '[{"CARD_NUMBER":"5184002009194856","ACCOUNT_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_TYPE":"1","CUSTOMER_ID":"30825397.3333333","CARD_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_NUMBER":"50009531998656","PRODUCT":"TRC","AFINITY_GROUP":"500","ACCOUNT_STATUS":"10 - Cuenta Normal","CARD_STATUS":"20 - Tarjeta Normal","CARD_EXPIRATION_DATE":"2026-11-30T00:00:00.000-06:00"}]';
    	  Integer code = 200;
          Test.setMock(HttpCalloutMock.class, new UT_SeviceMockRest(body, code));
          updateCase.processCase(setCaseId);
          updateCase.processCasePortalAuto(setCaseIds);
          updateCase.createDetail(setCaseId, casoOrigen);
          Test.stopTest();
      }
  }  
    
  @isTest
  public static void execute3() {
      try{
          if(!System.isFuture() && !System.isBatch()) {
              //crear cuenta
              Account acc = new Account(); 
              acc.Identificacion__c = '0801399412010';    
              acc.Name = 'Test Account';
              insert acc;
              
              Contact con = new Contact(FirstName='john', LastName='doe', Email='john@doe.com', AccountId=acc.Id);
              insert con;
              
              Asset ass = new Asset(AccountId=acc.Id,ContactId=con.Id, Name='testing');   
              insert ass;
              
              Entitlement ent = new Entitlement(Name='Testing', AccountId=acc.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
              insert ent;
              
              FechaDC_Sysde__c fdcSysde2 = new FechaDC_Sysde__c(Name = 'CierreAlDia2', Fecha_cierre__c  = date.today());
              insert fdcSysde2;
              
              Profile prof = [select id from profile where Name='Administrador del Sistema'];
              User user = new User();
              user.firstName = 'test1';
              user.lastName = 'test2';
              user.profileId = prof.id;
              user.username = 'standarduser2020@testorg.com';
              user.email = 'standarduser2020@testorg.com';
              user.Alias = 'standar';
              user.LocaleSidKey='en_US';
              user.TimeZoneSidKey='America/Los_Angeles';
              user.EmailEncodingKey='UTF-8';
              user.LanguageLocaleKey='en_US';        
              insert user;
              
              String RecordTypeId = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Email to Case'].Id;    
              Case c0 = new Case();
              c0.AccountId = acc.Id;
              c0.ContactId = con.Id;    
              c0.EntitlementId = ent.Id;
              c0.Priority = 'Alta';
              c0.OwnerId = user.Id;
              c0.RecordTypeId = RecordTypeId; 
              c0.SuppliedEmail = 'test@gmail.com';
              c0.Caso_Ingresado__c = false;
              c0.Status = 'Nuevo';
              c0.Origin = 'Agencias FPC';
              c0.Type = 'Solicitud';                  
              Insert c0;       
              
              String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Reposición de Carnet'].Id;        
              Case c = new Case();
              c.AccountId = acc.Id;
              c.ContactId = con.Id;    
              c.EntitlementId = ent.Id;
              c.Priority = 'Alta';
              c.OwnerId = user.Id;
              c.Reason = 'Otro';
              c.RecordTypeId = RecordTypeId2; 
              c.SuppliedEmail = 'test@gmail.com';
              c.Caso_Ingresado__c = false;        
              c.Status = 'Nuevo';
              c.Origin = 'Agencias FPC';
              c.Type = 'Solicitud';                
              Insert c;     
              
              Case c1 = new Case();
              c1.Priority = 'Alta';
              c1.OwnerId = user.Id;
              c1.EntitlementId = ent.Id;
              c1.RecordTypeId = RecordTypeId; 
              c1.SuppliedEmail = 'test@gmail.com';
              c1.Caso_Ingresado__c = false;
              c1.Status = 'Nuevo'; 
              c1.Origin = 'Agencias FPC';  
              c1.DAU_Tarjeta_de_Sysde__c = '456787654';  
              c1.DAU_No_Cuenta__c = '545678';    
              Insert c1;    
              
              List<Id> setCaseId = new List<Id>();
              setCaseId.add(c.id);
              
              set<Id> setCaseIds = new set<Id>();
              setCaseIds.add(c.id);
              
              set<Id> casoOrigen = new set<Id>();
              casoOrigen.add(c.Id);    
              
              Producto__c prod = new Producto__c();
              prod.Name = 'PENSIONES LEMPIRAS';
              prod.Codigo__c = '01';
              Insert prod;
              
              Subproducto__c subProd = new Subproducto__c();
              subProd.Producto__c = prod.Id;
              subProd.Codigo__c = 'FI010';
              Insert subProd;
              
              Cuentas__c cuenta = new Cuentas__c();
              cuenta.Name = '87675';
              cuenta.Codigo__c = '87675';
              cuenta.Cliente__c = acc.Id;
              cuenta.CurrencyIsoCode = 'HNL';
              cuenta.Producto__c = prod.Id;
              cuenta.Subproducto__c = subProd.Id;
              cuenta.Forma_Aportacion__c = 'AH';
              cuenta.Fondo_Inversion__c = '113';
              Insert Cuenta;
              
              Detalle_caso__c detC = new Detalle_caso__c();
              detC.Caso__c = c.Id;
              detC.Cuenta__c = cuenta.Id;
              detC.Tipo_Operacion__c = 'A6';
              detC.N_Cuenta_Bancaria__c = '456788765';
              detC.Banco__c = '';    
              Insert detC;    
              
              Test.startTest();
              String body = '[{"CARD_NUMBER":"5184002009194856","ACCOUNT_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_TYPE":"1","CUSTOMER_ID":"30825397.3333333","CARD_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_NUMBER":"50009531998656","PRODUCT":"TRC","AFINITY_GROUP":"500","ACCOUNT_STATUS":"10 - Cuenta Normal","CARD_STATUS":"20 - Tarjeta Normal","CARD_EXPIRATION_DATE":"2026-11-30T00:00:00.000-06:00"}]';
              Integer code = 200;
              Test.setMock(HttpCalloutMock.class, new UT_SeviceMockRest(body, code));
              updateCase.processCase(setCaseId);
              updateCase.processCasePortalAuto(setCaseIds);
              updateCase.createDetail(setCaseId, casoOrigen);
              
              FieldsBankManagement fields = new FieldsBankManagement();
              fields.tipoGestion = 'afiliaDebito';
              fields.identificacion = '0801198801164';
              fields.moneda = 'HNL';
              fields.fechaInicio = '2021-01-01';
              fields.periodicidad = 'S';
              fields.cuentaBancaria = '456789876';
              fields.diaCobro = '14';
              fields.montoDebito = '3000'; 
              
              fields.pctipoid = '1';
              fields.pcnroid = '865656790';
              fields.cuenta = '45678';
              fields.pcprimernombre = 'Juan';
              fields.pcprimerapellido = 'Pérez';
              fields.pcmail = 'test@gmail.com';
              fields.pnnrocertificado = '34343535636';
              fields.tipoFondo = 'P';
              fields.frecuencia = 'M';
              fields.EntitlementValue = ent.Id;
              
              List<FieldsBankManagement> values = new List<FieldsBankManagement>();
              values.add(fields);
              
              updateCase.createRecord(values);         
              System.debug('El caso que se envía: '+c1.Id+'---'+acc.Identificacion__c);
              updateCase.validarIdentidad(c1.Id, '4746361087608896', acc.Identificacion__c);
              updateCase.validarIdentidad2(c1.Id, '4746361087608896', acc.Identificacion__c);
              updateCase.validarIdentidad3(c1.Id, '4746361087608896', acc.Identificacion__c, 'Test');
              Test.stopTest();
          }
      } catch(System.NullPointerException ex) {
          System.debug('El error en el test updateCaseTest es: '+ex.getMessage()+'---'+ex.getLineNumber());
      }   
  }
    
  @isTest
  public static void execute03() {
      try{
          if(!System.isFuture() && !System.isBatch()) {
              //crear cuenta
              Account acc = new Account(); 
              acc.Identificacion__c = '0801399412010';    
              acc.Name = 'Test Account';
              insert acc;
              
              Contact con = new Contact(FirstName='john', LastName='doe', Email='john@doe.com', AccountId=acc.Id);
              insert con;
              
              Asset ass = new Asset(AccountId=acc.Id,ContactId=con.Id, Name='testing');   
              insert ass;
              
              Entitlement ent = new Entitlement(Name='Testing', AccountId=acc.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
              insert ent;
              
              FechaDC_Sysde__c fdcSysde2 = new FechaDC_Sysde__c(Name = 'CierreAlDia2', Fecha_cierre__c  = date.today());
              insert fdcSysde2;
              
              Profile prof = [select id from profile where Name='Administrador del Sistema'];
              User user = new User();
              user.firstName = 'test1';
              user.lastName = 'test2';
              user.profileId = prof.id;
              user.username = 'standarduser2020@testorg.com';
              user.email = 'standarduser2020@testorg.com';
              user.Alias = 'standar';
              user.LocaleSidKey='en_US';
              user.TimeZoneSidKey='America/Los_Angeles';
              user.EmailEncodingKey='UTF-8';
              user.LanguageLocaleKey='en_US';        
              insert user;
              
              String RecordTypeId = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Email to Case'].Id;    
              Case c0 = new Case();
              c0.AccountId = acc.Id;
              c0.ContactId = con.Id;    
              c0.EntitlementId = ent.Id;
              c0.Priority = 'Alta';
              c0.OwnerId = user.Id;
              c0.RecordTypeId = RecordTypeId; 
              c0.SuppliedEmail = 'test@gmail.com';
              c0.Caso_Ingresado__c = false;
              c0.Status = 'Nuevo';
              c0.Origin = 'Agencias FPC';
              c0.Type = 'Solicitud';                  
              Insert c0;       
              
              String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Reposición de Carnet'].Id;        
              Case c = new Case();
              c.AccountId = acc.Id;
              c.ContactId = con.Id;    
              c.EntitlementId = ent.Id;
              c.Priority = 'Alta';
              c.OwnerId = user.Id;
              c.Reason = 'Otro';
              c.RecordTypeId = RecordTypeId2; 
              c.SuppliedEmail = 'test@gmail.com';
              c.Caso_Ingresado__c = false;        
              c.Status = 'Nuevo';
              c.Origin = 'Agencias FPC';
              c.Type = 'Solicitud';                
              Insert c;     
              
              Case c1 = new Case();
              c1.Priority = 'Alta';
              c1.OwnerId = user.Id;
              c1.EntitlementId = ent.Id;
              c1.RecordTypeId = RecordTypeId; 
              c1.SuppliedEmail = 'test@gmail.com';
              c1.Caso_Ingresado__c = false;
              c1.Status = 'Nuevo'; 
              c1.Origin = 'Agencias FPC';  
              c1.DAU_Tarjeta_de_Sysde__c = '456787654';  
              c1.DAU_No_Cuenta__c = '545678';    
              Insert c1;    
              
              List<Id> setCaseId = new List<Id>();
              setCaseId.add(c.id);
              
              set<Id> setCaseIds = new set<Id>();
              setCaseIds.add(c.id);
              
              set<Id> casoOrigen = new set<Id>();
              casoOrigen.add(c.Id);    
              
              Producto__c prod = new Producto__c();
              prod.Name = 'PENSIONES LEMPIRAS';
              prod.Codigo__c = '01';
              Insert prod;
              
              Subproducto__c subProd = new Subproducto__c();
              subProd.Producto__c = prod.Id;
              subProd.Codigo__c = 'FI010';
              Insert subProd;
              
              Cuentas__c cuenta = new Cuentas__c();
              cuenta.Name = '87675';
              cuenta.Codigo__c = '87675';
              cuenta.Cliente__c = acc.Id;
              cuenta.CurrencyIsoCode = 'HNL';
              cuenta.Producto__c = prod.Id;
              cuenta.Subproducto__c = subProd.Id;
              cuenta.Forma_Aportacion__c = 'AH';
              cuenta.Fondo_Inversion__c = '113';
              Insert Cuenta;
              
              Detalle_caso__c detC = new Detalle_caso__c();
              detC.Caso__c = c.Id;
              detC.Cuenta__c = cuenta.Id;
              detC.Tipo_Operacion__c = 'A6';
              detC.N_Cuenta_Bancaria__c = '456788765';
              detC.Banco__c = '';    
              Insert detC;    
              
              Test.startTest();
              String body = '[{"CARD_NUMBER":"5184002009194856","ACCOUNT_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_TYPE":"1","CUSTOMER_ID":"30825397.3333333","CARD_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_NUMBER":"50009531998656","PRODUCT":"TRC","AFINITY_GROUP":"500","ACCOUNT_STATUS":"10 - Cuenta Normal","CARD_STATUS":"20 - Tarjeta Normal","CARD_EXPIRATION_DATE":"2026-11-30T00:00:00.000-06:00"}]';
              Integer code = 200;
              Test.setMock(HttpCalloutMock.class, new UT_SeviceMockRest(body, code));
              updateCase.processCase(setCaseId);
              updateCase.processCasePortalAuto(setCaseIds);
              updateCase.createDetail(setCaseId, casoOrigen);
              
              FieldsBankManagement fields = new FieldsBankManagement();
              fields.tipoGestion = 'afiliaDebito';
              fields.identificacion = '0801198801164';
              fields.moneda = 'HNL';
              fields.fechaInicio = '2021-01-01';
              fields.periodicidad = 'S';
              fields.cuentaBancaria = '456789876';
              fields.diaCobro = '14';
              fields.montoDebito = '3000'; 
              
              fields.pctipoid = '1';
              fields.pcnroid = '865656790';
              fields.cuenta = '45678';
              fields.pcprimernombre = 'Juan';
              fields.pcprimerapellido = 'Pérez';
              fields.pcmail = 'test@gmail.com';
              fields.pnnrocertificado = '34343535636';
              fields.tipoFondo = 'P';
              fields.frecuencia = 'M';
              fields.EntitlementValue = ent.Id;
              
              List<FieldsBankManagement> values = new List<FieldsBankManagement>();
              values.add(fields);
              
              updateCase.createRecord(values);         
              System.debug('El caso que se envía: '+c1.Id+'---'+acc.Identificacion__c);
              updateCase.validarIdentidadFormulario(c1.Id, '4746361087608896', acc.Identificacion__c);
              Test.stopTest();
          }
      } catch(System.NullPointerException ex) {
          System.debug('El error en el test updateCaseTest es: '+ex.getMessage()+'---'+ex.getLineNumber());
      }   
  }   
    
  @isTest
  public static void execute4() {
      try {  
          if(!System.isFuture() && !System.isBatch()) {
              //crear cuenta
              Account acc = new Account(); 
              acc.Identificacion__c = '0801399412010';    
              acc.Name = 'Test Account';
              insert acc;
              
              Contact con = new Contact(FirstName='john', LastName='doe', Email='john@doe.com', AccountId=acc.Id);
              insert con;
              
              Asset ass = new Asset(AccountId=acc.Id,ContactId=con.Id, Name='testing');   
              insert ass;
              
              Entitlement ent = new Entitlement(Name='Testing', AccountId=acc.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
              insert ent;
              
              FechaDC_Sysde__c fdcSysde2 = new FechaDC_Sysde__c(Name = 'CierreAlDia2', Fecha_cierre__c  = date.today());
              insert fdcSysde2;
              
              Profile prof = [select id from profile where Name='Administrador del Sistema'];
              User user = new User();
              user.firstName = 'test1';
              user.lastName = 'test2';
              user.profileId = prof.id;
              user.username = 'standarduser2020@testorg.com';
              user.email = 'standarduser2020@testorg.com';
              user.Alias = 'standar';
              user.LocaleSidKey='en_US';
              user.TimeZoneSidKey='America/Los_Angeles';
              user.EmailEncodingKey='UTF-8';
              user.LanguageLocaleKey='en_US';        
              insert user;
              
              String RecordTypeId = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Email to Case'].Id;    
              Case c0 = new Case();
              c0.AccountId = acc.Id;
              c0.ContactId = con.Id;    
              c0.EntitlementId = ent.Id;
              c0.Priority = 'Alta';
              c0.OwnerId = user.Id;
              c0.RecordTypeId = RecordTypeId; 
              c0.SuppliedEmail = 'test@gmail.com';
              c0.Caso_Ingresado__c = false;
              c0.Status = 'Nuevo';
              c0.Origin = 'Agencias FPC';
              c0.Type = 'Solicitud';                  
              Insert c0;       
              
              String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Reposición de Carnet'].Id;        
              Case c = new Case();
              c.AccountId = acc.Id;
              c.ContactId = con.Id;    
              c.EntitlementId = ent.Id;
              c.Priority = 'Alta';
              c.OwnerId = user.Id;
              c.Reason = 'Otro';
              c.RecordTypeId = RecordTypeId2; 
              c.SuppliedEmail = 'test@gmail.com';
              c.Caso_Ingresado__c = false;        
              c.Status = 'Nuevo';
              c.Origin = 'Agencias FPC';
              c.Type = 'Solicitud';                
              Insert c;     
              
              Case c1 = new Case();
              c1.Priority = 'Alta';
              c1.OwnerId = user.Id;
              c1.EntitlementId = ent.Id;
              c1.RecordTypeId = RecordTypeId; 
              c1.SuppliedEmail = 'test@gmail.com';
              c1.Caso_Ingresado__c = false;
              c1.Status = 'Nuevo'; 
              c1.Origin = 'Agencias FPC';  
              c1.DAU_Tarjeta_de_Sysde__c = '456787654';  
              c1.DAU_No_Cuenta__c = '545678';    
              Insert c1;    
              
              List<Id> setCaseId = new List<Id>();
              setCaseId.add(c.id);
              
              set<Id> setCaseIds = new set<Id>();
              setCaseIds.add(c.id);
              
              set<Id> casoOrigen = new set<Id>();
              casoOrigen.add(c.Id);    
              
              Producto__c prod = new Producto__c();
              prod.Name = 'PENSIONES LEMPIRAS';
              prod.Codigo__c = '01';
              Insert prod;
              
              Subproducto__c subProd = new Subproducto__c();
              subProd.Producto__c = prod.Id;
              subProd.Codigo__c = 'FI010';
              Insert subProd;
              
              Cuentas__c cuenta = new Cuentas__c();
              cuenta.Name = '87675';
              cuenta.Codigo__c = '87675';
              cuenta.Cliente__c = acc.Id;
              cuenta.CurrencyIsoCode = 'HNL';
              cuenta.Producto__c = prod.Id;
              cuenta.Subproducto__c = subProd.Id;
              cuenta.Forma_Aportacion__c = 'AH';
              cuenta.Fondo_Inversion__c = '113';
              Insert Cuenta;
              
              Detalle_caso__c detC = new Detalle_caso__c();
              detC.Caso__c = c.Id;
              detC.Cuenta__c = cuenta.Id;
              detC.Tipo_Operacion__c = 'A6';
              detC.N_Cuenta_Bancaria__c = '456788765';
              detC.Banco__c = '';    
              Insert detC;    
              
              Test.startTest();
              String body = '[{"CARD_NUMBER":"5184002009194856","ACCOUNT_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_TYPE":"1","CUSTOMER_ID":"30825397.3333333","CARD_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_NUMBER":"50009531998656","PRODUCT":"TRC","AFINITY_GROUP":"500","ACCOUNT_STATUS":"10 - Cuenta Normal","CARD_STATUS":"20 - Tarjeta Normal","CARD_EXPIRATION_DATE":"2026-11-30T00:00:00.000-06:00"}]';
              Integer code = 200;
              Test.setMock(HttpCalloutMock.class, new UT_SeviceMockRest(body, code));
              updateCase.processCase(setCaseId);
              updateCase.processCasePortalAuto(setCaseIds);
              updateCase.createDetail(setCaseId, casoOrigen);
              
              List<Account> accList = [Select Id,Identificacion__c From Account Where Id =: acc.Id];
              
              FieldsBankManagement fields = new FieldsBankManagement();
              fields.tipoGestion = 'afiliaDebito';
              fields.identificacion = accList[0].Identificacion__c;
              fields.moneda = 'HNL';
              fields.fechaInicio = '2021-01-01';
              fields.periodicidad = 'S';
              fields.cuentaBancaria = '456789876';
              fields.diaCobro = '14';
              fields.montoDebito = '3000'; 
              
              fields.pctipoid = '1';
              fields.pcnroid = '865656790';
              fields.cuenta = '45678';
              fields.pcprimernombre = 'Juan';
              fields.pcprimerapellido = 'Pérez';
              fields.pcmail = 'test@gmail.com';
              fields.pnnrocertificado = '34343535636';
              fields.tipoFondo = 'P';
              fields.frecuencia = 'M';
              fields.EntitlementValue = ent.Id;
              
              fields.pcformapago = 'AH';
              
              List<FieldsBankManagement> values = new List<FieldsBankManagement>();
              values.add(fields);
              
              updateCase.createRecord(values);         
                        
              updateCase.validarIdentidad(c.Id, '456789067', '867656790');
              updateCase.validarIdentidad2(c.Id, '456789067', '867656790');
              updateCase.validarIdentidad3(c.Id, '456789067', '867656790', 'Test');
              Test.stopTest();
          }
      } catch(System.NullPointerException ex) {
          System.debug('El error en el test updateCaseTest es: '+ex.getMessage()+'---'+ex.getLineNumber());
      }        
  }  
}