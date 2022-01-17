@isTest
public class PortalAutogestionE2C_Test {
    
    static testMethod void TestCasos(){

        Account cliente = new Account();
        cliente.Name='Luis Donaire';
        cliente.Identificacion__c='0709199300155';
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
        
        Agencia__C agencia = new agencia__C(name='Test', zona__C='2');
        insert agencia;
        
        Usuarios_para_asignacion_Casos_SAC__c f = new Usuarios_para_asignacion_Casos_SAC__c();
        f.Zona__c='2';
        f.Usuario__c = userinfo.getUserId();
        insert f;
        
        municipio__C municipio = new municipio__C();
        municipio.Codigo_Municipio__c='01';
        municipio.nombre_municipio__C='Test';
        municipio.codigo_departamento__c= '	120';
        insert municipio;       
        
        String RecordTypeId0 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Email to Case').getRecordTypeId();
        
        List<Case> caseListToInsert = new List<Case>();
        case c = new Case();
        c.AccountId = cliente.Id;
        //c.ContactId = con.Id;
        c.Status = 'Nuevo';
        c.SuppliedEmail = 'test@gmail.com';
        c.RecordTypeId = RecordTypeId0;
        c.Subject = 'Test';
        c.Identificacion__c = '0709199300157';
        //insert c;
        caseListToInsert.add(c);
        insert caseListToInsert;  
        
        List<Case> caseObj = [select id, casenumber,SuppliedEmail from case where id =: caseListToInsert[0].id];
        System.debug('case number' + caseObj[0].casenumber);
        
        ApexPages.currentPage().getParameters().put('idCaso',caseObj[0].Id);
        
        String idCaso = ApexPages.currentPage().getParameters().get('idCaso');
        
        ApexPages.currentPage().getParameters().put('idCliente',cliente.identificacion__C);
        
        ControladorCasosPortalAutogestionE2C controlCasos = new ControladorCasosPortalAutogestionE2C(); 
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Aumento_Disminucion_Aportes'];
        
        //Caso Aumento Disminución de Aporte
        controlCasos.caso = new case();
        controlCasos.idTipoRegistro = tiposR0[0].Id;
        controlCasos.cTipoCaso = new claseTipoCaso('Aumento_Disminucion_Aportes');
        controlCasos.Caso.Status = 'Nuevo';
        controlCasos.Caso.type = 'Solicitud de Gestión';
        controlCasos.Caso.Origin = 'Web';
        controlCasos.Caso.Priority = 'Media';
        //controlCasos.guardar();
        
        controlCasos.detalleCaso.Tipo_Operacion__c='A1';
        controlCasos.detallecaso.Nuevo_monto_aporte__c=500;
        controlCasos.caso.CurrencyIsoCode ='HNL';
        controlCasos.guardar();
        
        controlCasos.caso = new case();
        controlCasos.idTipoRegistro = tiposR0[0].Id;
        controlCasos.cTipoCaso = new claseTipoCaso('Aumento_Disminucion_Aportes');
        controlCasos.Caso.Status = 'Nuevo';
        controlCasos.Caso.type = 'Solicitud de Gestión';
        controlCasos.Caso.Origin = 'Web';
        controlCasos.Caso.Priority = 'Media';
        controlCasos.detalleCaso.Tipo_Operacion__c='A6';
        controlCasos.detallecaso.Nuevo_monto_aporte__c=000;
        controlCasos.caso.CurrencyIsoCode ='HNL';
        controlCasos.guardar();
                
        controlCasos.detalleCaso.Tipo_Operacion__c='A6';
        controlCasos.detallecaso.Banco__c = 'Otros Bancos';        
        controlCasos.detalleCaso.Tipo_Operacion__c='A6';
        controlCasos.detallecaso.Inicio_Fecha_Aporte__c = date.today();
        controlCasos.datetemp= date.today();
        controlCasos.guardar();
        
        //Caso Act de Info
        list<RecordType> tiposR1 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Actualizacion_informacion'];
        controlCasos.idTipoRegistro = tiposR1[0].Id;
        controlCasos.SelectTipoGestion();
        controlCasos.guardar();
        controlCasos.caso.Fecha_Nacimiento__c = date.today().addDays(3);
        controlCasos.guardar();
        controlCasos.caso.Fecha_Nacimiento__c = null;
        controlCasos.caso.Telefono_Trabajo__c = '21321';
        controlCasos.guardar();
        controlCasos.caso.Telefono_Trabajo__c = null;
        controlCasos.caso.Departamento_Trabajo2__c = '120';
        controlCasos.CiudadesTrabajo();
        controlCasos.caso.Departamento_Residencia2__c = '120';
        controlCasos.CiudadesResidencia();
        controlCasos.caso.Departamento_Residencia2__c = null;
        controlCasos.caso.Departamento_Trabajo2__c = null;
        controlCasos.AccionVacia();
        controlCasos.caso.correo_electronico__c ='ivorcast@gmai.com';
        controlCasos.guardar();
        controlCasos.verificarCodigo();
        controlCasos.reenviarCodigo();
        controlCasos.inputCodigoVeficacion = controlCasos.codigoVeficacion;
        controlCasos.verificarCodigo();
        controlCasos.cerrar();
               
        //Caso Constancia
        controlCasos.caso = new case();
        list<RecordType> tiposR2 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Constancia'];
        controlCasos.idTipoRegistro = tiposR2[0].Id;
        controlCasos.cTipoCaso = new claseTipoCaso('Constancia');
        controlCasos.Caso.Status = 'Nuevo';
        controlCasos.Caso.type = 'Solicitud de Gestión';
        controlCasos.Caso.Origin = 'Web';
        controlCasos.Caso.Priority = 'Media';
        controlCasos.Caso.constancia__C = 'A1';
        controlCasos.guardar();
        controlCasos.Caso.fecha_desde__C = date.today();
        controlCasos.Caso.fecha_hasta__C = date.today();
        controlCasos.guardar();
        controlCasos.Caso.fecha_hasta__C = date.today().addmonths(12);
        controlCasos.guardar();
        controlCasos.Caso.fecha_hasta__C = date.today().addmonths(4);
        controlCasos.guardar();
        
        //Caso Estado de Cuenta
        controlCasos.caso = new case();
        list<RecordType> tiposR3 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Estados_Cuenta'];
        controlCasos.idTipoRegistro = tiposR3[0].Id;
        controlCasos.cTipoCaso = new claseTipoCaso('Estados_Cuenta');
        controlCasos.Caso.Status = 'Nuevo';
        controlCasos.Caso.type = 'Solicitud de Gestión';
        controlCasos.Caso.Origin = 'Web';
        controlCasos.Caso.Priority = 'Media';
        controlCasos.caso.Tipo_Estado_Cuenta__c = 'A1';
        controlCasos.caso.Estado_Cuenta_Detallado__c = 'General';
        controlCasos.Caso.fecha_desde__C = date.today().addmonths(-12);
        controlCasos.Caso.fecha_hasta__C = date.today();
        controlCasos.guardar();
        controlCasos.VerEDCDetallado();
        controlCasos.VerEDCGeneral();
        
        
        //Caso Reposición de Carnet
        controlCasos.caso = new case();
        list<RecordType> tiposR4 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Reposicion_Carnet'];
        controlCasos.idTipoRegistro = tiposR4[0].Id;
        controlCasos.cTipoCaso = new claseTipoCaso('Reposicion_Carnet');
        controlCasos.Caso.Status = 'Nuevo';
        controlCasos.Caso.type = 'Solicitud de Gestión';
        controlCasos.Caso.Origin = 'Web';
        controlCasos.Caso.Priority = 'Media';
        controlCasos.guardar();
        controlCasos.ZonaSeleccionada = controlCasos.listaZonas[1].getValue();
        controlCasos.getListAgentsByZone();
        controlCasos.caso.Agencia__c =controlCasos.listAgencias[1].getvalue();
        controlCasos.guardar();
        controlCasos.loadAgencies();
        
        //Caso Otros
        controlCasos.caso = new case();
        list<RecordType> tiposR5 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Otros'];
        controlCasos.idTipoRegistro = tiposR5[0].Id;
        controlCasos.cTipoCaso = new claseTipoCaso('Otros');
        controlCasos.Caso.Status = 'Nuevo';
        controlCasos.Caso.type = 'Solicitud de Gestión';
        controlCasos.Caso.Origin = 'Web';
        controlCasos.Caso.Priority = 'Media';
        controlCasos.guardar();
        controlCasos.Caso.Description = 'Media';
        controlCasos.guardar();
        
        controlCasos.caso = new case();
        controlCasos.AccionVacia2();
        
    }
    
    static testMethod void TestCasos2(){

        Account cliente = new Account();
        cliente.Name='Luis Donaire';
        cliente.Identificacion__c='0709199300155';
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
        
        Agencia__C agencia = new agencia__C(name='Test', zona__C='2');
        insert agencia;
        
        Usuarios_para_asignacion_Casos_SAC__c f = new Usuarios_para_asignacion_Casos_SAC__c();
        f.Zona__c='2';
        f.Usuario__c = userinfo.getUserId();
        insert f;
        
        municipio__C municipio = new municipio__C();
        municipio.Codigo_Municipio__c='01';
        municipio.nombre_municipio__C='Test';
        municipio.codigo_departamento__c= '	120';
        insert municipio;       
        
        String RecordTypeId0 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Email to Case').getRecordTypeId();
        
        List<Case> caseListToInsert = new List<Case>();
        case c = new Case();
        c.AccountId = cliente.Id;
        //c.ContactId = con.Id;
        c.Status = 'Nuevo';
        c.SuppliedEmail = 'test@gmail.com';
        c.RecordTypeId = RecordTypeId0;
        c.Subject = 'Test';
        c.Identificacion__c = '0709199300157';
        //insert c;
        caseListToInsert.add(c);
        insert caseListToInsert;  
        
        List<Case> caseObj = [select id, casenumber,SuppliedEmail from case where id =: caseListToInsert[0].id];
        System.debug('case number' + caseObj[0].casenumber);
        
        ApexPages.currentPage().getParameters().put('idCaso',caseObj[0].Id);
        
        String idCaso = ApexPages.currentPage().getParameters().get('idCaso');
        
        ApexPages.currentPage().getParameters().put('idCliente',cliente.identificacion__C);
        
        ControladorCasosPortalAutogestionE2C controlCasos = new ControladorCasosPortalAutogestionE2C(); 
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Aumento_Disminucion_Aportes'];
        
        //Caso Aumento Disminución de Aporte
        controlCasos.caso = new case();
        controlCasos.idTipoRegistro = tiposR0[0].Id;
        controlCasos.cTipoCaso = new claseTipoCaso('Aumento_Disminucion_Aportes');
        controlCasos.Caso.Status = 'Nuevo';
        controlCasos.Caso.type = 'Solicitud de Gestión';
        controlCasos.Caso.Origin = 'Web';
        controlCasos.Caso.Priority = 'Media';
        
        controlCasos.detalleCaso.Tipo_Operacion__c='A6';
        controlCasos.detallecaso.Nuevo_monto_aporte__c=500;
        controlCasos.detallecaso.Nuevo_canal_aporte__c = 'TAOB';
        controlCasos.caso.CurrencyIsoCode ='HNL';
        controlCasos.guardar();
        
        controlCasos.login();
        
        controlCasos.GenerarToken();
        
        controlCasos.validarToken();
        
        controlCasos.UpdateTypeCase();
        
        controlCasos.aceptarTerminos();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(cliente);
        
        ControladorCasosPortalAutogestionE2C ctrl = new  ControladorCasosPortalAutogestionE2C(sc);
        
    }
    
    static testMethod void TestCasos3(){

        Account cliente = new Account();
        cliente.Name='Luis Donaire';
        cliente.Identificacion__c='0709199300155';
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
        
        Agencia__C agencia = new agencia__C(name='Test', zona__C='2');
        insert agencia;
        
        Usuarios_para_asignacion_Casos_SAC__c f = new Usuarios_para_asignacion_Casos_SAC__c();
        f.Zona__c='2';
        f.Usuario__c = userinfo.getUserId();
        insert f;
        
        municipio__C municipio = new municipio__C();
        municipio.Codigo_Municipio__c='01';
        municipio.nombre_municipio__C='Test';
        municipio.codigo_departamento__c= '	120';
        insert municipio;       
        
        String RecordTypeId0 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Email to Case').getRecordTypeId();
        
        List<Case> caseListToInsert = new List<Case>();
        case c = new Case();
        c.AccountId = cliente.Id;
        //c.ContactId = con.Id;
        c.Status = 'Nuevo';
        c.SuppliedEmail = 'test@gmail.com';
        c.RecordTypeId = RecordTypeId0;
        c.Subject = 'Test';
        c.Identificacion__c = '0709199300157';
        //insert c;
        caseListToInsert.add(c);
        insert caseListToInsert;  
        
        List<Case> caseObj = [select id, casenumber,SuppliedEmail from case where id =: caseListToInsert[0].id];
        System.debug('case number' + caseObj[0].casenumber);
        
        ApexPages.currentPage().getParameters().put('idCaso',caseObj[0].Id);
        
        String idCaso = ApexPages.currentPage().getParameters().get('idCaso');
        
        ApexPages.currentPage().getParameters().put('idCliente',cliente.identificacion__C);
        
        ControladorCasosPortalAutogestionE2C controlCasos = new ControladorCasosPortalAutogestionE2C();
        
        controlCasos.idCliente2 = '0709199300155';
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Aumento_Disminucion_Aportes'];
        
        //Caso Aumento Disminución de Aporte
        controlCasos.caso = new case();
        controlCasos.idTipoRegistro = tiposR0[0].Id;
        controlCasos.cTipoCaso = new claseTipoCaso('Aumento_Disminucion_Aportes');
        controlCasos.Caso.Status = 'Nuevo';
        controlCasos.Caso.type = 'Solicitud de Gestión';
        controlCasos.Caso.Origin = 'Web';
        controlCasos.Caso.Priority = 'Media';
        
        controlCasos.detalleCaso.Tipo_Operacion__c='A6';
        controlCasos.detallecaso.Nuevo_monto_aporte__c=500;
        controlCasos.detallecaso.Nuevo_canal_aporte__c = 'TAOB';
        controlCasos.caso.CurrencyIsoCode ='HNL';
        controlCasos.guardar();
        
    }
    
}