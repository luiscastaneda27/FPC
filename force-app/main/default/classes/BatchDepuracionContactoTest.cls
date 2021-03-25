@isTest
public class BatchDepuracionContactoTest {
    
    static testmethod void BatchDepuracionContacto() {
        
        Account cliente = new Account();
        cliente.lastname='Doanire';
        cliente.firstname='Luis';
        cliente.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
        cliente.Identificacion__c='00000000000000';
        cliente.Tipo_Identificacion__c='Cedula de identidad';
        cliente.Sexo__c='Masculino';
        cliente.CurrencyIsoCode = 'HNL';
        cliente.Estado_Civil__pc='Soltero';
        cliente.PersonEmail = 'test@test.com';
        insert cliente;
        
        
        
        ControllerReportEmailStatuses email = new ControllerReportEmailStatuses();
        email.dateStart = date.today().addYears(-10);
        email.dateEnd = date.today();
        email.GenerarReporte();
        
        
       /* BatchDepuracionContacto a = new BatchDepuracionContacto(0, system.now().addYears(-10), system.now());
        Database.executeBatch(a);
        
        Contact contacto = new Contact();
        contacto.Id = [Select id from Contact limit 1].Id;
        contacto.Estado__c = 'Listo Para Informe';
        update contacto;
        
        BatchDatosInformeEDC b = new BatchDatosInformeEDC( system.now().addYears(-10), system.now());
        Database.executeBatch(b);*/
        
        
        
    }
    
    
    

}