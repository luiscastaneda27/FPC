@isTest
public class partnerSoapSforceComTest {
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
        Test.setMock(WebServiceMock.class, new DAU_WebServiceMock());
        
        partnerSoapSforceComConnect.login();   
    }
}