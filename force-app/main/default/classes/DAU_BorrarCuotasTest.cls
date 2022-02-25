@isTest
public class DAU_BorrarCuotasTest {
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
        detC.DAU_Borrar_Cuotas__c = '3';
        Insert detC;
        
    	Test.startTest();
        	DAU_BorrarCuotas.aumentoDisminucion(c.Id, '10');
            DAU_BorrarCuotas.aumentoDisminucion2(c.Id, '18');
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
        detC.DAU_Borrar_Cuotas__c = '1';
        Insert detC;
        
    	Test.startTest();        	
        	DAU_BorrarCuotas.aumentoDisminucion(c.Id, '10');
            DAU_BorrarCuotas.aumentoDisminucion2(c.Id, '18');
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
        detC.DAU_Borrar_Cuotas__c = '1';
        Insert detC;
        
    	Test.startTest();        
        	DAU_BorrarCuotas.ConsultaInfoClienteC(c.Id, '45677876554');
        Test.stopTest();
    }
}