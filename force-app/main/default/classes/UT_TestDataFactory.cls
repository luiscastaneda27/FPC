/**
*Class Name: UT_TestDataFactory
*Description: Clase utilitaria para crear registros de prueba.
*Created Date: 10/01/2023 12:05 PM
*Created By: Cloud Code   
*Last Modified by: Cloud Code 13/02/2023 15:44 PM
*/
public class UT_TestDataFactory {
       
    public static String tipOper = 'A1';
    public static String tipCase = 'Otros';
    public static String canalAporte;
    public static String formaAporte;
    
    public static Account acc = UT_TestDataFactory.createAccount();
    public static Producto__c prod = UT_TestDataFactory.createProduct();
    public static Subproducto__c subProd = UT_TestDataFactory.createSubProduct();
    public static Case cs = UT_TestDataFactory.createCase(tipOper, tipCase);
    public static Case csParent = UT_TestDataFactory.createCaseParent();
    
    public static Account createAccount() {
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Identificacion__c = '1457857896587';
        acc.RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Juridico'].id;
        insert acc;
        return acc;
    }
    
    public static Producto__c createProduct() {
    	Producto__c prod = new Producto__c();
        prod.Name = 'Producto1'; 
        prod.Codigo__c = 'Pro1';
        insert prod;
        return prod;
    }

	public static Subproducto__c createSubProduct() {
    	Subproducto__c subProd = new Subproducto__c();        
        subProd.Name = 'SubProducto1'; 
        subProd.Codigo__c = 'SubPro1'; 
        subProd.Producto__c = prod.id;
        subProd.currencyIsoCode = 'HNL';
        insert subProd;
        return subProd;
    }    
     
    public static Cuentas__c createCuenta(String formaAporte) {
    	Cuentas__c cta = new Cuentas__c();
        cta.Name = 'Cuenta'; 
        cta.Codigo__c = '1234'; 
        cta.Cliente__c = acc.id; 
        cta.Producto__c = prod.id;
        cta.Subproducto__c = subProd.id;
        cta.Fecha_Apertura__c = date.today().addyears(-1); 
        cta.currencyIsoCode = 'HNL'; 
        cta.Monto_aporte__c = 5000; 
        cta.Forma_Aportacion__c = formaAporte;
        cta.Fecha_Aporte__c = System.today();
        insert cta;
        return cta;
    }    
    
    public static Entitlement createEnt() {
        Asset ass = new Asset(AccountId=acc.Id,Name='testing');   
        insert ass;
        Entitlement ent = new Entitlement();
        ent.Name='Testing'; 
        ent.AccountId=acc.Id; 
        ent.StartDate=Date.valueof(System.now().addDays(-2)); 
        ent.EndDate=Date.valueof(System.now().addYears(2)); 
        ent.AssetId=ass.Id;
        insert ent;
        return ent;
    }
    
    public static Id consultRecordTypeCase(String recordTypeDevName) {
        Id recordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get(recordTypeDevName).getRecordTypeId();
        return recordTypeId;
    }
    
    public static FechaDC_Sysde__c createFechaCierre() {
    	FechaDC_Sysde__c fc = new FechaDC_Sysde__c();
        fc.Name = 'CierreAlDia';
        fc.Fecha_cierre__c = System.today();
        insert fc;
        return fc;
    }
    
    public static case createCaseParent() {
        FechaDC_Sysde__c fc = UT_TestDataFactory.createFechaCierre();
        Entitlement ent = UT_TestDataFactory.createEnt();
        Case cs = new Case();
        cs.AccountId = acc.id;
        cs.Status = 'Nuevo';
        cs.RecordTypeId = UT_TestDataFactory.consultRecordTypeCase('Retiros'); 
        cs.EntitlementId = ent.id;
        cs.Tipo_de_Operacion__c = '';
        cs.DAU_aprobacion__c = false;
        cs.Constancia__c = 'A4';
        cs.SuppliedEmail = 'admin@fichohsa.org.com';
        cs.Caso_Ingresado__c = false;
        cs.Origin = 'Agencias FPC';
        cs.Reason = 'Otro';
        cs.Type = 'Solicitud';
        cs.Priority = 'Alta';
        cs.Respuesta_desde_Sysde__c = Null;
        insert cs;
        return cs;
    }
    
    public static case createCase(String tipOper, String tipCase) {
        //System.debug('Tipo Operación es: '+tipOper + '---' + 'Tipo de Caso: '+tipCase);
        FechaDC_Sysde__c fc = UT_TestDataFactory.createFechaCierre();
        Entitlement ent = UT_TestDataFactory.createEnt();
        Case cs = new Case();
        cs.AccountId = acc.id;
        cs.Status = 'Nuevo';
        if(tipCase != null) {
        	cs.RecordTypeId = UT_TestDataFactory.consultRecordTypeCase(tipCase);
        } else {
            cs.RecordTypeId = UT_TestDataFactory.consultRecordTypeCase('Otros');
        } 
        cs.EntitlementId = ent.id;
        cs.Tipo_de_Operacion__c = tipOper;
        cs.DAU_aprobacion__c = false;
        cs.Constancia__c = 'A4';
        cs.SuppliedEmail = 'admin@fichohsa.org.com';
        cs.Caso_Ingresado__c = false;
        cs.Origin = 'Agencias FPC';
        cs.Reason = 'Otro';
        cs.Type = 'Solicitud';
        cs.Priority = 'Alta';
        cs.Respuesta_desde_Sysde__c = Null;
        insert cs;
        return cs;
    }
    
    public static case createCaseInApproval(String tipOper, String tipCase) {
        //System.debug('Tipo Operación es: '+tipOper + '---' + 'Tipo de Caso: '+tipCase);
        FechaDC_Sysde__c fc = UT_TestDataFactory.createFechaCierre();
        Entitlement ent = UT_TestDataFactory.createEnt();
        Case cs = new Case();
        cs.AccountId = acc.id;
        cs.Status = 'Nuevo';
        cs.RecordTypeId = UT_TestDataFactory.consultRecordTypeCase(tipCase);
        cs.EntitlementId = ent.id;
        cs.Tipo_de_Operacion__c = tipOper;
        cs.DAU_aprobacion__c = false;
        cs.Constancia__c = 'A4';
        cs.SuppliedEmail = 'admin@fichohsa.org.com';
        cs.Caso_Ingresado__c = false;
        cs.Origin = 'Agencias FPC';
        cs.Reason = 'Otro';
        cs.Type = 'Solicitud';
        cs.Priority = 'Alta';
        cs.Respuesta_desde_Sysde__c = Null;
        cs.Enviar_aprobacion_AD__c =  true;
        cs.Aprobado__c = false;
        cs.Archivo_Adjunto__c = true;
        cs.Viene_Portal_Autogestion__c = false;
        insert cs;
        return cs;
    }
    
    public static Detalle_caso__c createDetailCase(Case cs, String canalAporte, String formaAporte) {
        Cuentas__c cta = UT_TestDataFactory.createCuenta(formaAporte);
        Detalle_caso__c detC = new Detalle_caso__c();
        detC.Cuenta__c = cta.id; 
        detC.Caso__c = cs.id; 
        detC.Nuevo_Subproducto__c = subProd.id; 
        detC.Nuevo_monto_aporte__c = 8000;
        detC.Fecha_nacimiento__c = date.today(); 
        //detC.Banco__c = '28'; 
        detC.Tipo_Operacion__c = cs.Tipo_de_Operacion__c;
        detC.Nuevo_canal_aporte__c = canalAporte;
        detC.Nueva_fecha_aporte__c = System.today();
        detC.N_Cuenta_Bancaria__c = '45785485980';
        detC.Tipo_retiro__c = '52';
        detC.DAU_Dia_de_pago__c = '14';
        insert detC;
        return detC;
    }
    
    public static case closeCase(Case cs) {
        cs.Status = 'Cerrado';
        cs.Archivo_Adjunto__c = true;
        cs.Aprobado__c = true;
        cs.Segunda_aprobacion__c = true;
        cs.DAU_aprobacion__c = true;
        cs.Respuesta_SF_Tarjetas__c = 'Éxito';
        cs.Respuesta_desde_Sysde__c = '"Cambio procesado correctamente con bitacora."';
        update cs;
        return cs;
    }

    public static case closeCaseNoExito(Case cs) {
        cs.Status = 'Cerrado';
        cs.Archivo_Adjunto__c = true;
        cs.Aprobado__c = true;
        cs.Segunda_aprobacion__c = true;
        cs.DAU_aprobacion__c = true;
        cs.Respuesta_SF_Tarjetas__c = '';
        cs.Respuesta_desde_Sysde__c = '';
        update cs;
        return cs;
    }     
   
}