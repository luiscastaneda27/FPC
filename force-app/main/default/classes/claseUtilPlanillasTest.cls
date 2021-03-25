@istest
public class claseUtilPlanillasTest {
    
    static testmethod void claseUtilPlanillas(){
        Planilla__c planilla = new Planilla__C();
        planilla.Tasa_compra__c = 0;
        insert planilla;
        
        Correos__C correo = new correos__C();
        correo.cargo__c='Compra de Dolar';
        correo.Correo__c = 'test@test.com';
        insert correo;
        
        
        Account empresa= new Account();
        empresa.Name='Empresa Prueba';
        empresa.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Juridico').getRecordTypeId();
        empresa.Identificacion__c='012j0000';
        insert empresa;
        
         Account persona= new Account();
		persona.lastname='Casteda DOna';
		persona.firstname='Idania Casta'; 
		persona.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
		persona.Identificacion__c='00000000000002';
		insert persona;
        
        Producto__C producto=New Producto__C();
        producto.Codigo__c='01';
        producto.CurrencyIsoCode='HNL';
        insert producto;
        
        
        Cuentas__C cuentaColectiva= new Cuentas__C();
        cuentaColectiva.CurrencyIsoCode='HNL';
        cuentaColectiva.Codigo__c='32546';
        cuentaColectiva.Cliente__c=empresa.id;
        cuentaColectiva.Producto__c=producto.id;
        insert cuentaColectiva;
        
        cuentas__C cuenta =new cuentas__C();
        cuenta.CurrencyIsoCode='HNL';
        cuenta.Codigo__c='32543';
        cuenta.Cliente__c=empresa.id;
        cuenta.Producto__c=producto.id;
        cuenta.Cuenta_colectiva2__c = cuentaColectiva.id;
        insert cuenta;
        
        cuentaColectiva= new Cuentas__C();
        cuentaColectiva.CurrencyIsoCode='HNL';
        cuentaColectiva.Codigo__c='32547';
        cuentaColectiva.Cliente__c=empresa.id;
        cuentaColectiva.Producto__c=producto.id;
        insert cuentaColectiva;
        
        cuenta =new cuentas__C();
        cuenta.CurrencyIsoCode='HNL';
        cuenta.Codigo__c='32545';
        cuenta.Cliente__c=empresa.id;
        cuenta.Producto__c=producto.id;
        cuenta.Cuenta_colectiva2__c = cuentaColectiva.id;
        insert cuenta;
        
        cuentaColectiva= new Cuentas__C();
        cuentaColectiva.CurrencyIsoCode='HNL';
        cuentaColectiva.Codigo__c='32548';
        cuentaColectiva.Cliente__c=empresa.id;
        cuentaColectiva.Producto__c=producto.id;
        insert cuentaColectiva;
        
        cuenta =new cuentas__C();
        cuenta.CurrencyIsoCode='HNL';
        cuenta.Codigo__c='32544';
        cuenta.Cliente__c=empresa.id;
        cuenta.Producto__c=producto.id;
        cuenta.Cuenta_colectiva2__c = cuentaColectiva.id;
        insert cuenta;
        
        Cuentas_Colectivas__c Colectiva= new Cuentas_Colectivas__c();
        colectiva.Tipo_Cuenta__c='Voluntarias';
        colectiva.Codigo__c='32546';
        colectiva.Empresa__c=empresa.id;
        insert colectiva;
        
        Colectiva= new Cuentas_Colectivas__c();
        colectiva.Tipo_Cuenta__c='Pilar Complementario';
        colectiva.Codigo__c='32547';
        colectiva.Empresa__c=empresa.id;
        insert colectiva;
        
        Colectiva= new Cuentas_Colectivas__c();
        colectiva.Tipo_Cuenta__c='Censatías';
        colectiva.Codigo__c='32548';
        colectiva.Empresa__c=empresa.id;
        insert colectiva;
        
        empresa_x_Empleado__C empleado = new empresa_x_Empleado__C();
        empleado.Empleado2__c = persona.id;
        empleado.Empresa2__c = empresa.id;
        insert empleado;
        
        Usuario_X_Empresa__c usuario = new Usuario_X_Empresa__c();
        usuario.empresa2__C = empresa.Id;
        usuario.Aceptar_Planilla__c=true;
        insert usuario;
        
        planilla.Empresa2__c = empresa.Id;
        update planilla;
        
        
        claseUtilPlanillas.urlSysde('Test');
        claseUtilPlanillas.urlSysde('Testfrs');
        claseUtilPlanillas.CompreDeDollar(planilla.Id);
        claseUtilPlanillas.CompreDeDollar(planilla.Id+'s');
        claseUtilPlanillas.correoEnvioPlanilla(null);
        claseUtilPlanillas.ColavoradoresVigentes(empresa.id,null);
        claseUtilPlanillas.ColavoradoresVigentes(null,null);
        claseUtilPlanillas.correoEnvioPlanilla2(planilla.id);
        claseUtilPlanillas.validarContrasena('nada');
        claseUtilPlanillas.validarContrasena('Lemrincs@cs32');
        
        
    }

}