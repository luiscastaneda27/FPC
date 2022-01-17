@isTest
public class DAU_TG_LogHelperTest {
    
	@IsTest static void execute() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
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
        c.Origin = 'Correo electrónico FPC';
        c.Type = 'Solicitud';                
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A3';
        detC.Nuevo_canal_aporte__c = 'TA';
        Insert detC;
        
        Test.startTest();
        DAU_Salesforce_Tarjetas__e event = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_EjecutarSYSDE__c=true);
        Database.SaveResult sr = EventBus.publish(event);
        Test.stopTest();
    }
    
    @IsTest static void execute2() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
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
        c.Origin = 'Correo electrónico FPC';
        c.Type = 'Solicitud';                
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A3';
        detC.Nuevo_canal_aporte__c = 'TA';
        Insert detC;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_EjecutarSYSDEOper__c=true,DAU_Borrar_Cuotas_S10__c=false);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute3() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
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
        c.Origin = 'Correo electrónico FPC';
        c.Type = 'Solicitud';                
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A3';
        detC.Nuevo_canal_aporte__c = 'TA';
        Insert detC;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_Borrar_Cuotas_S10__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute4() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
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
        c.Origin = 'Correo electrónico FPC';
        c.Type = 'Solicitud';                
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A3';
        detC.Nuevo_canal_aporte__c = 'TA';
        Insert detC;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_Borrar_Cuotas_S18__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute5() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A4';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A4';
        detC.Nuevo_canal_aporte__c = '';
        detC.Nueva_fecha_aporte__c = System.today();
        detC.Banco__c = '28';
        Insert detC;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_NumeroCuenta__c='353535353536');
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute6() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A4';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A4';
        detC.Nuevo_canal_aporte__c = '';
        detC.Nueva_fecha_aporte__c = System.today();
        detC.Banco__c = '28';
        Insert detC;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_EjecutarSYSDE__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute7() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Description = 'Test';
        c.Tipo_de_Operacion__c = 'A6';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A6';
        detC.Nuevo_canal_aporte__c = '';
        detc.N_Cuenta_Bancaria__c = '353535353535';
        detC.Banco__c = '28';
        Insert detC;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_SegundoServicio__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute8() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A6';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A6';
        detC.Nuevo_canal_aporte__c = '';
        detc.N_Cuenta_Bancaria__c = '353535353535';
        detC.Banco__c = '28';
        Insert detC;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_CuartoServicio__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute9() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A6';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A6';
        detC.Nuevo_canal_aporte__c = '';
        detc.N_Cuenta_Bancaria__c = '353535353535';
        detC.Banco__c = '28';
        Insert detC;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_EjecutarSYSDE__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute10() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A6';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A6';
        detC.Nuevo_canal_aporte__c = '';
        detc.N_Cuenta_Bancaria__c = '353535353535';
        detC.Banco__c = '28';
        Insert detC;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_Borrar_Cuotas_S10__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute11() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A6';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A6';
        detC.Nuevo_canal_aporte__c = '';
        detc.N_Cuenta_Bancaria__c = '353535353535';
        detC.Banco__c = '28';
        Insert detC;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_Borrar_Cuotas_S18__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute12() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A7';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A7';
        detC.Nuevo_canal_aporte__c = '';
        detc.N_Cuenta_Bancaria__c = '';
        detC.Banco__c = '28';
        Insert detC;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_EjecutarSYSDE__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute13() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A3';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A3';
        detC.Nuevo_canal_aporte__c = 'TAOB';
        detc.N_Cuenta_Bancaria__c = '4565678998';
        detC.Banco__c = 'Otros Bancos';
        Insert detC;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_EjecutarSYSDE__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute14() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A3';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A3';
        detC.Nuevo_canal_aporte__c = 'TAOB';
        detc.N_Cuenta_Bancaria__c = '4565678998';
        detC.Banco__c = 'Otros Bancos';
        Insert detC;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_EjecutarSYSDEOper__c=true,DAU_Borrar_Cuotas_S10__c=false);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute15() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A3';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A3';
        detC.Nuevo_canal_aporte__c = 'TAOB';
        detc.N_Cuenta_Bancaria__c = '4565678998';
        detC.Banco__c = 'Otros Bancos';
        Insert detC;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_Borrar_Cuotas_S10__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute16() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A3';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A3';
        detC.Nuevo_canal_aporte__c = 'TAOB';
        detc.N_Cuenta_Bancaria__c = '4565678998';
        detC.Banco__c = 'Otros Bancos';
        Insert detC;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_Borrar_Cuotas_S18__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute17() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A1';
        c.Respuesta_SF_Tarjetas__c = '';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A1';
        detC.Nuevo_canal_aporte__c = '';
        detc.N_Cuenta_Bancaria__c = '';
        detC.Nuevo_monto_aporte__c = 5000;
        detC.Banco__c = 'Otros Bancos';
        Insert detC;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_EjecutarSYSDE__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    /*@IsTest static void execute18() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A6';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A6';
        detC.Nuevo_canal_aporte__c = '';
        detc.N_Cuenta_Bancaria__c = '4565678998';
        detC.Banco__c = 'Otros Bancos';
        Insert detC;
        
        c.Status = 'Cerrado';
        c.Archivo_Adjunto__c = true;
        update c;
                
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_PrimerServicio__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }*/
    
    @IsTest static void execute19() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A6';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A6';
        detC.Nuevo_canal_aporte__c = '';
        detc.N_Cuenta_Bancaria__c = '4565678998';
        detC.Banco__c = 'Otros Bancos';
        Insert detC;
                      
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_EjecutarSYSDE__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute20() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A6';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A6';
        detC.Nuevo_canal_aporte__c = '';
        detc.N_Cuenta_Bancaria__c = '4565678998';
        detC.Banco__c = 'Otros Bancos';
        Insert detC;
                      
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_Borrar_Cuotas_S10__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute21() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A6';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A6';
        detC.Nuevo_canal_aporte__c = '';
        detc.N_Cuenta_Bancaria__c = '4565678998';
        detC.Banco__c = 'Otros Bancos';
        Insert detC;
                      
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_Borrar_Cuotas_S18__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute22() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A7';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A7';
        detC.Nuevo_canal_aporte__c = '';
        detc.N_Cuenta_Bancaria__c = '';
        Insert detC;
                      
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_PrimerServicio__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute23() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A7';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A7';
        detC.Nuevo_canal_aporte__c = '';
        detc.N_Cuenta_Bancaria__c = '';
        Insert detC;
                      
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_SegundoServicio__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute24() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A7';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A7';
        detC.Nuevo_canal_aporte__c = '';
        detc.N_Cuenta_Bancaria__c = '';
        Insert detC;
                      
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_EjecutarSYSDE__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute25() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A7';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A7';
        detC.Nuevo_canal_aporte__c = '';
        detc.N_Cuenta_Bancaria__c = '';
        Insert detC;
                      
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_Borrar_Cuotas_S10__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
    
    @IsTest static void execute26() {
        
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
        
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Agencias_Banco';
        c.Type = 'Solicitud';  
        c.Tipo_de_Operacion__c = 'A7';
        Insert c;
        
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
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A7';
        detC.Nuevo_canal_aporte__c = '';
        detc.N_Cuenta_Bancaria__c = '';
        Insert detC;
                      
        Test.startTest();        
        DAU_Salesforce_Tarjetas__e event2 = new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c=c.Id,DAU_Borrar_Cuotas_S18__c=true);
        Database.SaveResult sr2 = EventBus.publish(event2);
        Test.stopTest();
    }
}