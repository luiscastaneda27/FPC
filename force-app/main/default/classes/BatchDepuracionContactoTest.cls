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
        
        Account acc = [Select PersonContactId, Name from Account Where Id = :cliente.Id];
        
         Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
         Messaging.SingleEmailMessage correo = new Messaging.SingleEmailMessage(); 
                 
        correo.setHtmlBody('<b>Test</b>');
        correo.setSubject('Estado de cuenta.');
        String[] toAddresses = new String[] {'test@test.test'};
            correo.setToAddresses(toAddresses);  
        correo.setTargetObjectId(acc.PersonContactId);
        correo.setSaveAsActivity(true);
        listCorreo.add(correo);  
        Messaging.sendEmail(listCorreo, false);
        
        FPC_ErroresEstadosDeCuenta__c Error = new FPC_ErroresEstadosDeCuenta__c(
                    FPC_Contacto__c = acc.PersonContactId,
                    FPC_Error__c = '500test');
        insert Error;
        
        ControllerReportEmailStatuses email = new ControllerReportEmailStatuses();
        email.dateStart = date.today().addYears(-10);
        email.dateEnd = date.today();
        email.GenerarReporte();
        
    }
    
}