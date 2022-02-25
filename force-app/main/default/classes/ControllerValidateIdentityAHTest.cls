@isTest
public class ControllerValidateIdentityAHTest {
	static testMethod void execute(){
        
        Producto__c producto2 = new Producto__c(Name = 'Producto1', Codigo__c = 'Pro1');
        insert producto2;
        
        Subproducto__c subproducto4 = new Subproducto__c(Name = 'SubProducto1', Codigo__c = 'SubPro1', Producto__c = producto2.id,
                                                         currencyIsoCode = 'HNL');
        insert subproducto4;
        
        Subproducto__c subproducto3 = new Subproducto__c(Name = 'SubProducto2', Codigo__c = 'SubPro2', Producto__c = producto2.id,
                                                         currencyIsoCode = 'HNL');
        insert subproducto3;    
        
        Account natural2 = new Account(Name = 'Juan Perez', Identificacion__c = '1234567890123', 
                                       RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Juridico'].id);
        insert natural2;
        
        Date hoy2 = date.today();
        Cuentas__c cuentaIndi2 = new Cuentas__c(Name = 'Cuenta', Codigo__c = '1234', Cliente__c = natural2.id, Producto__c = producto2.id,
                                                Fecha_Apertura__c = date.today().addyears(-1),
                                                Subproducto__c = subproducto3.id, currencyIsoCode = 'HNL', 
                                                Monto_aporte__c = 5000, Forma_Aportacion__c = 'AH');
        insert cuentaIndi2;
        
        test.startTest();
      
        	ControllerValidateIdentityAH.execute(cuentaIndi2.Codigo__c);
        
        test.stopTest();
        
    }
}