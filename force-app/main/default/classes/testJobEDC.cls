@istest
public class testJobEDC {
    
    static testmethod void JobEDC (){
        Account cuenta = new Account();
        cuenta.LastName = 'Test';
        cuenta.Identificacion__c = '0303030303033';
        cuenta.PersonEmail = 'email@test.com';
        insert cuenta;
        
        Producto__C producto=New Producto__C();
        producto.Codigo__c='01';
        producto.CurrencyIsoCode='HNL';
        insert producto;
        
        
        Cuentas__C cuentacolectiva= new Cuentas__C();
        cuentacolectiva.CurrencyIsoCode='HNL';
        cuentacolectiva.Codigo__c='32546';
        cuentacolectiva.Cliente__c=cuenta.id;
        cuentacolectiva.Producto__c=producto.id;
        cuentacolectiva.Fecha_Apertura__c = date.today().AddDays(-50); 
        insert cuentacolectiva;
        
        
        Correo_estado_cuenta__c a = new Correo_estado_cuenta__c(enviado__C = false, cliente__c = cuenta.Id, Grupo__c = 1);
        insert a;
        
        Autonumerico_cuentas_Syste__c c = new Autonumerico_cuentas_Syste__c (Contador_EDC__c = 1);
        insert c;
        
        JobEDC b = new JobEDC();
        b.execute(null);
    }

}