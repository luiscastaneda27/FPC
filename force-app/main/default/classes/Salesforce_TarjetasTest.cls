@isTest
public class Salesforce_TarjetasTest {
    
    public static void test() {
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('mockResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
    }
    
    @isTest static void testCallout() { 
        
        //Create case       
        Id IdRecordTypeAcc = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
        Account acc = new Account(RecordtypeId = IdRecordTypeAcc, LastName = 'TestAccount', Tipo_Identificacion__c = '4', Identificacion__c = '123456');
        Insert acc;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=acc.Id, 
        StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)));
        insert ent;
        
        Id IdRecordTypeCase = Schema.SObjectType.case.getRecordTypeInfosByName().get('Modificación de aportes').getRecordTypeId();
		Case c = new Case(AccountId = acc.Id, EntitlementId = ent.Id, status = 'Nuevo', Origin = 'Agencias FPC', Reason = 'Otro', Type = 'Solicitud', DAU_Identidad__c = '234567876', Tipo_de_Operacion__c = 'A6', Respuesta_SF_Tarjetas__c = Null);
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
        Insert detC;
        
        // This causes a fake response to be generated
        //Test.setMock(WebServiceMock.class, new DAU_WebServiceMock());
        
        Set<Id> caseIds = new Set<Id>();
        caseIds.add(c.Id);
        
        //WsGestiones.WS_GestionesDAU ws = new WsGestiones.WS_GestionesDAU();
        //ws.crearGestion('ADI', '0801199411013', '104932', '4054129000026637', 'Pensiones y Cesantías –Seguro de Vida L', '1234', 'Debito automático Pensiones', 'Otros', 'Juan Pérez', '14', 'Ficohsa Pensiones', null, null, null, null, null, null);
        
        Salesforce_Tarjetas.processCase(caseIds, 'ADI', acc.Name, '14');
        
        /*StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('mockResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');*/
    }
    
    @isTest static void testCallout2() { 
        
        //Create case       
        Id IdRecordTypeAcc = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
        Account acc = new Account(RecordtypeId = IdRecordTypeAcc, LastName = 'TestAccount', Tipo_Identificacion__c = '4', Identificacion__c = '123456');
        Insert acc;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=acc.Id, 
        StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)));
        insert ent;
        
        Id IdRecordTypeCase = Schema.SObjectType.case.getRecordTypeInfosByName().get('Modificación de aportes').getRecordTypeId();
		Case c = new Case(AccountId = acc.Id, EntitlementId = ent.Id, status = 'Nuevo', Origin = 'Agencias FPC', Reason = 'Otro', Type = 'Solicitud', DAU_Identidad__c = '234567876', Tipo_de_Operacion__c = 'A4');
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
        detC.Nueva_fecha_aporte__c = System.today();
        Insert detC;

        Set<Id> caseIds = new Set<Id>();
        caseIds.add(c.Id);
        
        Salesforce_Tarjetas.processCase(caseIds, 'ADI', acc.Name, '14');
    }
    
    @isTest static void testCallout3() { 
        
        //Create case       
        Id IdRecordTypeAcc = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
        Account acc = new Account(RecordtypeId = IdRecordTypeAcc, LastName = 'TestAccount', Tipo_Identificacion__c = '4', Identificacion__c = '123456');
        Insert acc;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=acc.Id, 
        StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)));
        insert ent;
        
        Id IdRecordTypeCase = Schema.SObjectType.case.getRecordTypeInfosByName().get('Modificación de aportes').getRecordTypeId();
		Case c = new Case(AccountId = acc.Id, EntitlementId = ent.Id, status = 'Nuevo', Origin = 'Agencias FPC', Reason = 'Otro', Type = 'Solicitud', DAU_Identidad__c = '234567876', Tipo_de_Operacion__c = 'A3');
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
        detC.Nueva_fecha_aporte__c = System.today();
        detC.Nuevo_canal_aporte__c = 'TA';
        Insert detC;

        Set<Id> caseIds = new Set<Id>();
        caseIds.add(c.Id);
        
        Salesforce_Tarjetas.processCase(caseIds, 'ADI', acc.Name, '14');
    }
    
    @isTest static void testCallout4() { 
        
        //Create case       
        Id IdRecordTypeAcc = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
        Account acc = new Account(RecordtypeId = IdRecordTypeAcc, LastName = 'TestAccount', Tipo_Identificacion__c = '4', Identificacion__c = '123456');
        Insert acc;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=acc.Id, 
        StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)));
        insert ent;
        
        Id IdRecordTypeCase = Schema.SObjectType.case.getRecordTypeInfosByName().get('Modificación de aportes').getRecordTypeId();
		Case c = new Case(AccountId = acc.Id, EntitlementId = ent.Id, status = 'Nuevo', Origin = 'Agencias FPC', Reason = 'Otro', Type = 'Solicitud', DAU_Identidad__c = '234567876', Tipo_de_Operacion__c = 'A6', Respuesta_SF_Tarjetas__c = Null);
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
        detC.DAU_Borrar_Cuotas__c = '2';
        Insert detC;
        
        Set<Id> caseIds = new Set<Id>();
        caseIds.add(c.Id);
        
        Salesforce_Tarjetas.processCase(caseIds, 'ADI', acc.Name, '14');
    }
    
    @isTest static void testCallout5() { 
        
        //Create case       
        Id IdRecordTypeAcc = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
        Account acc = new Account(RecordtypeId = IdRecordTypeAcc, LastName = 'TestAccount', Tipo_Identificacion__c = '4', Identificacion__c = '123456');
        Insert acc;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=acc.Id, 
        StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)));
        insert ent;
        
        Id IdRecordTypeCase = Schema.SObjectType.case.getRecordTypeInfosByName().get('Modificación de aportes').getRecordTypeId();
		Case c = new Case(AccountId = acc.Id, EntitlementId = ent.Id, status = 'Nuevo', Origin = 'Agencias FPC', Reason = 'Otro', Type = 'Solicitud', DAU_Identidad__c = '234567876', Tipo_de_Operacion__c = 'A3');
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
        detC.Nueva_fecha_aporte__c = System.today();
        detC.Nuevo_canal_aporte__c = 'TA';
        detC.DAU_Borrar_Cuotas__c = '3';
        Insert detC;

        Set<Id> caseIds = new Set<Id>();
        caseIds.add(c.Id);
        
        Salesforce_Tarjetas.processCase(caseIds, 'ADI', acc.Name, '14');
    }
}