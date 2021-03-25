@isTest
public class PortalAutogestionE2C_Test {
    
    static testMethod void TestCasos(){
        Account cliente = new Account();
        cliente.Name='Luis Donaire';
        cliente.Identificacion__c='0709199300157';
        cliente.Departamento_Residencia2__c = '122';
        insert cliente;
        
        Contact con = new Contact();
        con.AccountId = cliente.Id;
        con.FirstName = 'Test';
        con.LastName = 'Test';
        insert con;
        
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
        
        f = new Usuarios_para_asignacion_Casos_SAC__c();
        f.Zona__c='3';
        f.Usuario__c = userinfo.getUserId();
        insert f;
        
        f = new Usuarios_para_asignacion_Casos_SAC__c();
        f.Zona__c='1';
        f.Usuario__c = userinfo.getUserId();
        insert f;
        f = new Usuarios_para_asignacion_Casos_SAC__c();
        
        f.Usuario__c = userinfo.getUserId();
        insert f;
        
        municipio__C municipio = new municipio__C();
        municipio.Codigo_Municipio__c='01';
        municipio.nombre_municipio__C='Test';
        municipio.codigo_departamento__c= ' 120';
        insert municipio;
        
        String RecordTypeId0 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Email to Case').getRecordTypeId();
        
        List<Case> caseListToInsert = new List<Case>();
        case c = new Case();
        c.AccountId = cliente.Id;
        c.ContactId = con.Id;
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
        
        Test.startTest();
        
        /*ApexPages.currentPage().getParameters().put('clie',cliente.identificacion__C);
ApexPages.currentPage().getParameters().put('caseNumber',caseObj[0].casenumber);
ApexPages.currentPage().getParameters().put('email',caseObj[0].SuppliedEmail); */
        ApexPages.currentPage().getParameters().put('idCaso',caseObj[0].Id);
        ApexPages.currentPage().getParameters().put('recordType', 'Otros');
        ControladorCasosPortalAutogestionE2C controlCasos= new ControladorCasosPortalAutogestionE2C();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(cliente);
        ControladorCasosPortalAutogestionE2C testController = new ControladorCasosPortalAutogestionE2C(sc);    
        
        //controlCasos.UrlHost = null;
        
        controlCasos.idCliente2 = '0709199300157';
        controlCasos.login();
        controlCasos.GenerarToken();
        controlCasos.validarToken();
        controlCasos.inicio();
        controlCasos.aceptarTerminos();
        controlCasos.asuntoOtro();
        controlCasos.guardar();
        controlCasos.ciudadesTrabajo();
        controlCasos.ciudadesResidencia();
        controlCasos.getCurrencySelected();
        controlCasos.updateConstanciaView();
        controlCasos.verEDCDetallado();
        controlCasos.verEDCGeneral();
        controlCasos.accionVacia();
        controlCasos.accionVacia2(); 
        controlCasos.UpdateCaseToOtros();
        
        //controlCasos.estadoCuentaHistorico(claseEnvio, idCaso);
        //controlCasos.estadoCuentaTrimestral(claseEnvio, idCaso);
        
        //Caso Email2Case
        //Id RecordTypeId0 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Email to Case').getRecordTypeId();
        
        System.debug('RecordTypeId0: '+RecordTypeId0);
        controlCasos.noRecibeToken = True; 
        controlCasos.numCel = '88458785';
        controlCasos.idCliente2 = '0801199411013';
        controlCasos.emailCliente = 'emailcliente@gmail.com';
        controlCasos.casoCliente = '500125';
        controlCasos.FechaHoy = System.now();               
        
        //controlCasos.recordType = 'Reposicion_Carnet';
        
        controlCasos.idTipoRegistro = RecordTypeId0;
        controlCasos.Caso.SuppliedEmail = 'testEmail@gmail.com';
        controlCasos.Caso.Correo_Electronico__c = 'test2Email2@gmail.com';
        controlCasos.Caso.Subject = 'Email to Case';
        controlCasos.Caso.Telefono_Movil__c = '87457858';
        controlCasos.Caso.Type = 'Solicitud';
        controlCasos.caso.OwnerId = f.Usuario__c;
        System.debug('controlCasos: '+controlCasos);
        controlCasos.guardar();
        
        //controlCasos.UpdateCaseToOtros();
        
        controlCasos.guardar();
        
        //Caso Act de Info
        //Id RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Actualización de Información').getRecordTypeId();
        String RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Actualizacion_informacion').getRecordTypeId(); 
        controlCasos.idTipoRegistro = RecordTypeId;
        controlCasos.caso.Status = 'Nuevo';
        controlCasos.caso.Origin = 'Correo electrónico FPC';
        controlCasos.caso.Type = 'Solicitud';
        controlCasos.caso.ContactId = cliente.Id;
        
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
        
        /*
controlCasos.SelectTipoGestion();
controlCasos.guardar();
controlCasos.caso.correo_electronico__c ='ivorcast@gmai.com';
controlCasos.caso.Departamento_Trabajo2__c = '120';
controlCasos.CiudadesTrabajo();
controlCasos.caso.Departamento_Residencia2__c = '120';
controlCasos.CiudadesResidencia();
controlCasos.caso.Departamento_Residencia2__c = null;
controlCasos.caso.Departamento_Trabajo2__c = null;
controlCasos.AccionVacia();
controlCasos.guardar();*/
        
        //Caso Constancia
        String RecordTypeId6 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Constancia'].Id;        
        controlCasos.idTipoRegistro = RecordTypeId6;
        controlCasos.caso.Status = 'Nuevo';
        controlCasos.caso.Origin = 'Correo electrónico FPC';
        controlCasos.caso.Type = 'Solicitud';
        controlCasos.caso.Constancia__c = 'A4';
        controlCasos.caso.ContactId = cliente.Id;
        controlCasos.SelectTipoGestion();
        controlCasos.guardar();
        controlCasos.caso.correo_electronico__c ='ivorcast@gmai.com';
        controlCasos.caso.Departamento_Trabajo2__c = '120';
        controlCasos.CiudadesTrabajo();
        controlCasos.caso.Departamento_Residencia2__c = '120';
        controlCasos.CiudadesResidencia();
        controlCasos.caso.Departamento_Residencia2__c = null;
        controlCasos.caso.Departamento_Trabajo2__c = null;
        controlCasos.AccionVacia();
        controlCasos.guardar();
        
        //Caso Estado de Cuenta
        //Id RecordTypeId2 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Estados de Cuenta').getRecordTypeId();
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Estados de Cuenta'].Id;
        controlCasos.caso = new case();
        controlCasos.idTipoRegistro = RecordTypeId2;
        controlCasos.caso.Status = 'Nuevo';
        controlCasos.caso.Origin = 'Correo electrónico FPC';
        controlCasos.caso.Type = 'Solicitud';
        controlCasos.caso.ContactId = cliente.Id;
        controlCasos.cTipoCaso = new claseTipoCaso('Estados_Cuenta');
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
        //Id RecordTypeId3 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Reposición de Carnet').getRecordTypeId();
        String RecordTypeId3 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Reposición de Carnet'].Id;
        controlCasos.caso = new case();
        controlCasos.idTipoRegistro = RecordTypeId3;
        controlCasos.caso.Status = 'Nuevo';
        controlCasos.caso.Origin = 'Correo electrónico FPC';
        controlCasos.caso.Type = 'Solicitud';
        controlCasos.caso.ContactId = cliente.Id;
        controlCasos.cTipoCaso = new claseTipoCaso('Reposicion_Carnet');
        controlCasos.Caso.Priority = 'Media';
        controlCasos.guardar();
        controlCasos.ZonaSeleccionada = controlCasos.listaZonas[1].getValue();
        controlCasos.getListAgentsByZone();
        controlCasos.caso.Agencia__c =controlCasos.listAgencias[1].getvalue();
        controlCasos.guardar();
        //controlCasos.loadAgencies();
        
        //Caso Otros
        //Id RecordTypeId4 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Otros').getRecordTypeId();
        String RecordTypeId4 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Otros'].Id;
        controlCasos.caso = new case();
        controlCasos.idTipoRegistro = RecordTypeId4;
        controlCasos.caso.Status = 'Nuevo';
        controlCasos.caso.Origin = 'Correo electrónico FPC';
        controlCasos.caso.Type = 'Solicitud';
        controlCasos.caso.ContactId = cliente.Id;
        controlCasos.cTipoCaso = new claseTipoCaso('Otros');
        controlCasos.Caso.Priority = 'Media';
        controlCasos.guardar();
        controlCasos.Caso.Description = 'Media';
        controlCasos.UpdateCaseToOtros();
        controlCasos.guardar();
        
        //Caso Aumento Disminución de Aporte
        //Id RecordTypeId5 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Modificación de aportes').getRecordTypeId();
        String RecordTypeId5 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Modificación de aportes'].Id;
        controlCasos.caso = new case();
        controlCasos.idTipoRegistro = RecordTypeId5;
        controlCasos.caso.Status = 'Nuevo';
        controlCasos.caso.Origin = 'Correo electrónico FPC';
        controlCasos.caso.Type = 'Solicitud';
        controlCasos.caso.ContactId = cliente.Id;
        controlCasos.cTipoCaso = new claseTipoCaso('Aumento_Disminucion_Aportes');
        controlCasos.Caso.Priority = 'Media';
        
        controlCasos.detalleCaso.Tipo_Operacion__c='A1';
        controlCasos.detallecaso.Nuevo_monto_aporte__c=500;
        controlCasos.caso.CurrencyIsoCode ='HNL';
        controlCasos.guardar();
        
        //controlCasos.UpdateTypeCase();
        //controlCasos.loadAgencies();
        //controlCasos.cerrar();
        
        SolicitudCaso solicitud = AFPCCasos.upsertCaso(controlCasos.caso);
        
        //controlCasos.UpdateCaseToOtros();
        controlCasos.cliente.Departamento_Residencia2__c = null;
        controlCasos.zonaPorDepto();
        controlCasos.cliente.Departamento_Residencia2__c = '123';
        controlCasos.zonaPorDepto();
        controlCasos.UpdateTypeCase();
        controlCasos.loadAgencies();
        
        Test.stopTest();
        
    }
    
}