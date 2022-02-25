@isTest
public class TestCasosPortalAutoGestion {   
    
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
	}
    
    static testMethod void TestCasos(){
        
        Account cliente = [Select Name,identificacion__C from Account limit 1];
        
        ApexPages.currentPage().getParameters().put('idCliente',cliente.identificacion__C);
        controladorCasosPortalAutogestion controlCasos= new controladorCasosPortalAutogestion();
        controlCasos.contrato.Acepto_Condiciones_de_Portal_Autogestion__c = true;
        controlCasos.AceptarTerminos();
        controlCasos.actualizaCliente();
        
        
        //Caso Aumento Disminución de Aporte
        controlCasos.caso = new case();
        controlCasos.idTipoRegistro = controlCasos.idTipoRegistro = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Aumento_Disminucion_Aportes').getRecordTypeId();
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
        controlCasos.idTipoRegistro = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Aumento_Disminucion_Aportes').getRecordTypeId();
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
        controlCasos.idTipoRegistro = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Actualizacion_informacion').getRecordTypeId();
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
               
        /*//Caso Constancia
        controlCasos.caso = new case();
        controlCasos.idTipoRegistro = controlCasos.listTipoCaso[2].getValue();
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
        controlCasos.idTipoRegistro = controlCasos.listTipoCaso[3].getValue();
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
        controlCasos.idTipoRegistro = controlCasos.listTipoCaso[9].getValue();
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
        controlCasos.idTipoRegistro = controlCasos.listTipoCaso[10].getValue();
        controlCasos.cTipoCaso = new claseTipoCaso('Otros');
        controlCasos.Caso.Status = 'Nuevo';
        controlCasos.Caso.type = 'Solicitud de Gestión';
        controlCasos.Caso.Origin = 'Web';
        controlCasos.Caso.Priority = 'Media';
        controlCasos.guardar();
        controlCasos.Caso.Description = 'Media';
        controlCasos.guardar();*/
        
        controlCasos.caso = new case();
        controlCasos.AccionVacia2();
        
    }
    
    static testMethod void execute(){
        
        Account cliente = [Select Name,identificacion__C from Account limit 1];
        
        ApexPages.currentPage().getParameters().put('idCliente',cliente.identificacion__C);
        controladorCasosPortalAutogestion controlCasos= new controladorCasosPortalAutogestion();
        controlCasos.contrato.Acepto_Condiciones_de_Portal_Autogestion__c = true;
        controlCasos.AceptarTerminos();
        
        
        //Caso Aumento Disminución de Aporte
        controlCasos.caso = new case();
        controlCasos.idTipoRegistro = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Aumento_Disminucion_Aportes').getRecordTypeId();
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
        
        classClientesEC cc = new classClientesEC();
        cc.idCliente = cliente.Id;
        cc.desde = System.now();
        cc.hasta = System.now() + 30;
        
        list<classClientesEC> claseEnvio = new list<classClientesEC>();
        claseEnvio.add(cc);
        
        controladorCasosPortalAutogestion.estadoCuentaHistorico(claseEnvio, controlCasos.caso.Id);  
        controladorCasosPortalAutogestion.estadoCuentaTrimestral(claseEnvio, controlCasos.caso.Id);
    }
    
    static testMethod void TestCasoConstancias(){
        Account cliente = [Select Name,identificacion__C from Account limit 1];
        
        ApexPages.currentPage().getParameters().put('idCliente',cliente.identificacion__C);
        controladorCasosPortalAutogestion controlCasos= new controladorCasosPortalAutogestion();
        
        //Caso Constancia
        controlCasos.caso = new case();
        controlCasos.idTipoRegistro = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Constancia').getRecordTypeId();
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
    }
    
    
    static testMethod void TestCasoEDC(){
        Account cliente = [Select Name,identificacion__C from Account limit 1];
        
        ApexPages.currentPage().getParameters().put('idCliente',cliente.identificacion__C);
        controladorCasosPortalAutogestion controlCasos= new controladorCasosPortalAutogestion();
        
        //Caso EDC
        controlCasos.caso = new case();
        controlCasos.idTipoRegistro = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Estados_Cuenta').getRecordTypeId();
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
    }
    
    static testMethod void TestCasoRepoCarnet(){
        Account cliente = [Select Name,identificacion__C from Account limit 1];
        
        ApexPages.currentPage().getParameters().put('idCliente',cliente.identificacion__C);
        controladorCasosPortalAutogestion controlCasos= new controladorCasosPortalAutogestion();
        
        //Caso Reposición de Carnet
        controlCasos.caso = new case();
        controlCasos.idTipoRegistro = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Reposicion_Carnet').getRecordTypeId();
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
    }
    
    
    
    static testMethod void TestCasoOtros(){
        Account cliente = [Select Name,identificacion__C from Account limit 1];
        
        ApexPages.currentPage().getParameters().put('idCliente',cliente.identificacion__C);
        controladorCasosPortalAutogestion controlCasos= new controladorCasosPortalAutogestion();
        
        //Caso Otros
        controlCasos.caso = new case();
        controlCasos.idTipoRegistro = Schema.SObjectType.Case.getRecordTypeInfosByDeveloperName().get('Otros').getRecordTypeId();
        controlCasos.cTipoCaso = new claseTipoCaso('Otros');
        controlCasos.Caso.Status = 'Nuevo';
        controlCasos.Caso.type = 'Solicitud de Gestión';
        controlCasos.Caso.Origin = 'Web';
        controlCasos.Caso.Priority = 'Media';
        controlCasos.guardar();
        controlCasos.Caso.Description = 'Media';
        controlCasos.asuntoOtro();
        controlCasos.guardar();
    }
       
}