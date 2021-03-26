@isTest
public class testClassCRetiros {
    static testMethod void controllerCRetiros()
    {
       test.startTest();
        Retiro_Aprobacion__c w = new Retiro_Aprobacion__c();
        w.Aprobacion_Final__c = '';
        w.AprobacionM__c = '';
        w.banco_destino__c = '';
        w.cheque__c = null;
        w.compara_monto__c = '';
        w.Cuenta__c = '';
        w.cuenta_bancaria__c = '';
		w.cuenta_Destino__c = '';
        w.CurrencyIsoCode = 'HNL';
        w.Descripcion__c = '';
        w.Fecha_SalesForce__c = DATE.valueOf('2019-05-21');
        w.Fecha_Sysde__c = DATE.valueOf('2019-05-21');
        w.Forma_Pago__c = '';
        w.moneda__c = '';
        w.Monto_Salesforce__c = '1';
        w.Monto_Sysde__c = null;
        w.monto_total__c = '1';
        w.Numero_Referencia__c = '1234567';
        w.tasa_seguridad_poblacional__c = '1';
        w.tipo_cuenta__c = '';
        w.transferencia_ACH__c = '1';
        w.AprobacionM__c = 'S';
        w.Nombre_Cliente__c = 'Paola';
        w.Numero_Caso__c = '1';
        w.Nombre_Propietario__c = 'Esteban';
        insert w;
        
        controllerCRetiros ra = new controllerCRetiros();
        
        list<cuadreRetiros> laa = new list<cuadreRetiros>();
        list<cuadreRetirosC> lee = new list<cuadreRetirosC>();
        list<cuadreRetirosP> llll = new list<cuadreRetirosP>();
        list<cuadreRetirosB> lllll = new list<cuadreRetirosB>();
        list<cuadreRetirosI> llllll = new list<cuadreRetirosI>();
        
        ra.conciliaRetiros();
        ra.mostrarTablaRetirosP = true;
        ra.mostrarTablaRetiros = true;
        ra.mostrarTablaRetirosC = true;
        ra.mostrarTablaRetirosB = true;
        ra.mostrarTablaRetirosI = true;
        ra.Num_CodReferencia = '1234567';
        ra.envioAprobacion();
        ra.envioAprobacionP();
        ra.envioAprobacionB();
        ra.envioAprobacionI();
        ra.Num_CodReferencia = '';
        ra.envioAprobacion();
        ra.envioAprobacionP();
        ra.envioAprobacionB();
        ra.envioAprobacionI();
        ra.enviarListaTotal();
        ra.enviarListaTotalP();
        ra.enviarListaTotalB();
        ra.enviarListaTotalI();
        test.stopTest();
    }

}