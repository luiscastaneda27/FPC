@isTest
public class ControladorBeneficiariosTest {

     @testSetup 
    static void setupMethod() {
        Account cliente = new Account();
        cliente.Name='Luis Donaire';
        cliente.Identificacion__c='0709199300155';
        cliente.UltimoCasoObligatorio__c = date.today();
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
        
        Beneficiario__c b = new Beneficiario__c();
        b.Cuenta__c = cuenta.Id;
        b.Id_Externo__c = 12321;
        b.Primer_Nombre__c = 'PN';
        b.Primer_Apellido__c = 'PA';
        b.TipoBeneficiario__c = 'Directo';
        insert b;
        
        b = new Beneficiario__c();
        b.Cuenta__c = cuenta.Id;
        b.Id_Externo__c = 123221;
        b.Primer_Nombre__c = 'PN';
        b.Primer_Apellido__c = 'PA';
        b.TipoBeneficiario__c = 'Contingencia';
        insert b;
        
	}
    
     static testMethod void ControladorBeneficiarios(){
        
        Account acc = [Select Id from Account];
         
         Case caso = new Case();
         caso.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Actualizacion_informacion').getRecordTypeId();
         caso.Status = 'Nuevo';
         caso.type = 'Solicitud de Gestión';
         caso.Origin = 'Web';
         caso.Priority = 'Media';
         caso.AccountId = acc.Id;
         insert caso;
         
         ControladorBeneficiarios.ResultWrapper controlador = ControladorBeneficiarios.getBeneficiarios(caso.Id, true);
         ControladorBeneficiarios.insertarBeneficiarios(caso.Id, JSON.serialize(controlador));
         ControladorBeneficiarios.getBeneficiarios(acc.Id, false);
         ControladorBeneficiarios.validacionCamposBeneficiario(controlador.listBeneficiarios);
        
    }
   
   
}