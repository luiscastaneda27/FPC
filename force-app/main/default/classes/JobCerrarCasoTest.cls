@isTest
public class JobCerrarCasoTest {
    
    static testMethod void JobCerrarCaso(){
        Datetime fecha = Datetime.now().addSeconds(15);
        String acron = fecha.second()+' '+fecha.minute()+' '+fecha.hour()+' '+fecha.day()+' '+fecha.month()+' ? '+fecha.year();
        System.schedule('CerrarCasos', acron, new JobCerrarCaso());
        
        Account cliente = new Account();
        cliente.FirstName = 'Luis';
        cliente.LastName='Donaire';
        cliente.Identificacion__c='12345';
        cliente.PersonEmail = 'test@test.com';
        cliente.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
        
        insert cliente;
        
        Case caso = new case();
        caso.AccountId = cliente.Id;
        caso.Fecha_Desde__c = date.today();
        caso.Fecha_hasta__c = date.today();
        Caso.CerrarCasoJob__c = true;
        insert caso;
        
        JobCerrarCaso a = new JobCerrarCaso();
        a.execute(null);
        
    }

}