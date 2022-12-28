@isTest
public class CrearUsuarioPortalAutogestionTest {
    
    static testMethod void crearUsuario(){
        
        Account cliente = new Account();
        cliente.FirstName = 'Test Test';
        cliente.LastName = 'Test Test';
        cliente.Identificacion__c = '0709199300155';
        cliente.PersonEmail = 'test@test.com';
        cliente.Tipo_Identificacion__c = '1';
        insert cliente;
        
        Producto__C producto = new Producto__C();
        producto.Codigo__c='qwqw';
        producto.name='Prueba';
        insert producto;
        
        Subproducto__c  subProducto = new Subproducto__c ();
        subProducto.Name='Test';
        subProducto.Codigo__c='3434';
        subProducto.Producto__c = producto.id;
        insert subProducto;
        
        Cuentas__C cuenta = new cuentas__C();
        cuenta.codigo__C='0000';
        cuenta.Cliente__c = cliente.id;
        cuenta.Subproducto__c = subProducto.id;
        cuenta.name='test';
        cuenta.Monto_aporte__c = 100;
        cuenta.Forma_Aportacion__c='TA';
        insert cuenta;
        Test.startTest();
        CrearUsuarioPortalAutogestion.crearUsuario(cliente.Id);
        Test.stopTest();
        
    }
}