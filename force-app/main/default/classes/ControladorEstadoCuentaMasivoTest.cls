@istest
public class ControladorEstadoCuentaMasivoTest {
    
    public static testMethod void ControladorEstadoCuentaMasivo(){
        Account cliente = new Account(FirstName = 'ACADEMIA', LastName = 'LOS PINARES', Identificacion__c = '1234567890123', PersonEmail = 'as@csd.com',
                                    RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Natural'].id);
        insert cliente;
        ApexPages.currentPage().getParameters().put('idCliente', 'ACADEMIA LOS PINARES');
        controladorEstadoCuentaMasivo c = new controladorEstadoCuentaMasivo(new ApexPages.StandardController(cliente));
        
    } 

}