@isTest
public class testReposicionCarnet {
    
   static testmethod void ReposicionCarnet() {
       
       Account ClientePrueba= new Account();
       ClientePrueba.lastname='Doanire';
       ClientePrueba.firstname='Luis';
       ClientePrueba.RecordTypeId = '012j0000000i3wAAAQ';
       ClientePrueba.Identificacion__c='00000000000000';
       ClientePrueba.Tipo_Identificacion__c='Cedula de identidad';
       ClientePrueba.Sexo__c='Masculino';
       ClientePrueba.CurrencyIsoCode = 'HNL';
       ClientePrueba.Estado_Civil__pc='Soltero';
       insert ClientePrueba;
       
       FechaDC_Sysde__c p = new FechaDC_Sysde__c(Name = 'CierreAlDia', Fecha_cierre__c =date.today());
       insert p;
       
       Producto__C producto=New Producto__C();
       producto.Codigo__c='01';
       producto.CurrencyIsoCode='HNL';
       insert producto;
       
       agencia__C agencia =new agencia__C(name='Prueba', zona__C='2');
       insert agencia;
       
       Cuentas__C cuentaNormal= new Cuentas__C();
       cuentaNormal.CurrencyIsoCode='HNL';
       cuentaNormal.Codigo__c='11';
       cuentaNormal.Cliente__c=ClientePrueba.id;
       cuentaNormal.Producto__c=producto.id;
       insert cuentaNormal;
       
       cuentaNormal= new Cuentas__C();
       cuentaNormal.CurrencyIsoCode='HNL';
       cuentaNormal.Codigo__c='12';
       cuentaNormal.Cliente__c=ClientePrueba.id;
       cuentaNormal.Producto__c=producto.id;
       insert cuentaNormal;
       
       cuentaNormal= new Cuentas__C();
       cuentaNormal.CurrencyIsoCode='HNL';
       cuentaNormal.Codigo__c='13';
       cuentaNormal.Cliente__c=ClientePrueba.id;
       cuentaNormal.Producto__c=producto.id;
       insert cuentaNormal;
       
       cuentaNormal= new Cuentas__C();
       cuentaNormal.CurrencyIsoCode='HNL';
       cuentaNormal.Codigo__c='14';
       cuentaNormal.Cliente__c=ClientePrueba.id;
       cuentaNormal.Producto__c=producto.id;
       insert cuentaNormal;
       
       cuentaNormal= new Cuentas__C();
       cuentaNormal.CurrencyIsoCode='HNL';
       cuentaNormal.Codigo__c='15';
       cuentaNormal.Cliente__c=ClientePrueba.id;
       cuentaNormal.Producto__c=producto.id;
       insert cuentaNormal;
       
       cuentaNormal= new Cuentas__C();
       cuentaNormal.CurrencyIsoCode='HNL';
       cuentaNormal.Codigo__c='16';
       cuentaNormal.Cliente__c=ClientePrueba.id;
       cuentaNormal.Producto__c=producto.id;
       insert cuentaNormal;
       
       cuentaNormal= new Cuentas__C();
       cuentaNormal.CurrencyIsoCode='HNL';
       cuentaNormal.Codigo__c='17';
       cuentaNormal.Cliente__c=ClientePrueba.id;
       cuentaNormal.Producto__c=producto.id;
       insert cuentaNormal;
       
       cuentaNormal= new Cuentas__C();
       cuentaNormal.CurrencyIsoCode='HNL';
       cuentaNormal.Codigo__c='18';
       cuentaNormal.Cliente__c=ClientePrueba.id;
       cuentaNormal.Producto__c=producto.id;
       insert cuentaNormal;
       
       cuentaNormal= new Cuentas__C();
       cuentaNormal.CurrencyIsoCode='HNL';
       cuentaNormal.Codigo__c='19';
       cuentaNormal.Cliente__c=ClientePrueba.id;
       cuentaNormal.Producto__c=producto.id;
       insert cuentaNormal;
       
       case caso = new case();
       caso.AccountId = ClientePrueba.id;
       Caso.Status='Nuevo';
       Caso.type='Solicitud de Gestión';
       Caso.Origin='Web';
       Caso.Priority= 'Media'; 
       caso.Status = 'Cerrado';
       caso.RecordTypeId = [select Developername,id from RecordType where sObjecttype = 'Case' limit 1].id;
       insert caso;
       
       ApexPages.StandardController d =new ApexPages.StandardController(caso);
       extensionImpresonCarnet v = new extensionImpresonCarnet(d);
       
       ControladorCargaMasivaCarnet.SUbirInformacion('"hola","hola","hola","hola","hola"\n"hola","hola","hola","hola","hola"', null);
       ControladorCargaMasivaCarnet.SUbirInformacion('"NUMERO IDENTIFICACION","APELLIDOS","CUENTAS","NUM_FORMULARIO","NOMBRES"\n"00000000000000","hola","hola","hola","hola"', null);
       ControladorCargaMasivaCarnet mk =new ControladorCargaMasivaCarnet();
       mk.VerEmpleados();
       mk.crearCasos();
       mk.Imprimir();
       mk.Cerrar();
       
       ApexPages.currentPage().getParameters().put('id', caso.Id);
       v = new extensionImpresonCarnet();
    }

}