@isTest
public class EstadosDeCuentaTest {
    
    static testMethod void TestCasos(){
        
        Test.setMock(HttpCalloutMock.class, new testMocks());
        
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
        insert caso;
        
        test.startTest();
        
        list<String> idCaso = new list<String>();
        idCaso.add(caso.Id);
        
        EstadosDeCuenta.enviarCorreos(idCaso, 'A1');
        EstadosDeCuenta.enviarCorreos(idCaso, 'A2');
        EstadosDeCuenta.InsertarCorreos();
        EstadosDeCuenta.InsertarCorreos();
        
        Correo_estado_cuenta__c a = [select Id,enviado__C,enviado_mensual__C from Correo_estado_cuenta__c ];
        a.Enviado__c = false;
        a.Enviado_Mensual__c = false;
        update a;
        
        EstadosDeCuenta.enviarCorreos(null, 'A1');
        EstadosDeCuenta.enviarCorreos(null, 'A2');
        
		EstadosDeCuenta.estadoCuentaMensual(new list<classClientesEC>());
        EstadosDeCuenta.estadoCuentaTrimestral(new list<classClientesEC>());
        EstadosDeCuenta.estadoCuentaHistorico(new list<classClientesEC>());
    }
    

}