@istest
public class test_TR_Actualiza_Propietario {
    static testMethod void test_TR_Actualiza_Propietario() {
        test.startTest();
    	Preventa__c tr = new Preventa__c();
        tr.Asesor__c = '005j000000CRZJe';
        tr.FirstName__c = 'wendy';
        tr.LastName__c = 'alvarado';
        
        insert tr;
        test.stopTest();
    }

}