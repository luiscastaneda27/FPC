@isTest
public class controllerEDChistoricoPDFCasoTest {
    
    static testMethod void TestCasos(){
        Test.setMock(HttpCalloutMock.class, new testMocks());
        
        Account cliente = new Account();
        cliente.Name='Luis Donaire';
        cliente.Identificacion__c='0123456789123';
        insert cliente;
        
        Case caso = new case();
        caso.AccountId = cliente.Id;
        caso.Fecha_Desde__c = date.today();
        caso.Fecha_hasta__c = date.today();
        insert caso;
        test.startTest();
        controllerEDChistoricoPDFCaso controller = new  controllerEDChistoricoPDFCaso(new ApexPages.StandardController(Caso));
        caso.Id = null;
        controller = new  controllerEDChistoricoPDFCaso(new ApexPages.StandardController(caso));
        test.stopTest();
    }

}