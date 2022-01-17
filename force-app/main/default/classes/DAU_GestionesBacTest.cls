@isTest
public class DAU_GestionesBacTest {
    @isTest static void execute() {
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
        cuenta.Fondo_Inversion__c = '113';
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A7';
        detC.Nuevo_canal_aporte__c = '';
        detC.DAU_Borrar_Cuotas__c = '3';
        Insert detC;
        
        test.startTest();    
            // Set mock callout class 
            Test.setMock(HttpCalloutMock.class, new MockHttpsResponseGenerator3());
            
            // Call method to test.
            // This causes a fake response to be sent
            // from the class that implements HttpCalloutMock. 
            HttpResponse res = HttpsCalloutClass3.getInfoFromExternalService();
        
            // Verify response received contains fake values
            String contentType = res.getHeader('Content-Type');
            String actualValue = res.getBody(); 
            String expectedValue = '{"example":"test"}';
        
        	DAU_GestionesBac.execute(c.Id);
        test.stopTest();
    }
    
    @isTest static void execute2() {
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
        cuenta.Fondo_Inversion__c = '113';
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A3';
        detC.Nuevo_canal_aporte__c = 'TA';
        detC.DAU_Borrar_Cuotas__c = '3';
        detC.Mes__c = '1';
        detC.Ano_tarjeta__c = '2025';
        Insert detC;
        
        test.startTest();
        	DAU_GestionesBac.execute(c.Id);
        test.stopTest();
    }
    
    @isTest static void execute3() {
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
        c.Tipo_de_Operacion__c = 'A1';
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
        cuenta.Fondo_Inversion__c = '113';
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A1';
        detC.Nuevo_monto_aporte__c = 5000;
        Insert detC;
        
        test.startTest();
        	DAU_GestionesBac.execute(c.Id);
        test.stopTest();
    }
    
    @isTest static void execute4() {
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
        cuenta.Fondo_Inversion__c = '113';
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A4';
        detC.Nueva_fecha_aporte__c = System.today();
        Insert detC;
        
        test.startTest();
        	DAU_GestionesBac.execute(c.Id);
        test.stopTest();
    }
    
    @isTest static void execute5() {
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
        c.Tipo_de_Operacion__c = 'A6'; 
        c.Respuesta_SF_Tarjetas__c = Null;
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
        cuenta.Fondo_Inversion__c = '113';
        Insert Cuenta;
        
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Caso__c = c.Id;
        detC.Cuenta__c = cuenta.Id;
        detC.Tipo_Operacion__c = 'A6';
        detC.N_Cuenta_Bancaria__c = '456788765';
        Insert detC;
        
        test.startTest();        
        	DAU_GestionesBac.execute(c.Id);
        test.stopTest();
    }
}