@isTest
public class testASYSDECallouts {
    static testMethod void aSysdeCallouts(){
        
        User u = [select Id,Name  FROM user LIMIT 1];
        
        system.runAs(u) {
        
        classProcesarReversion reversion= new classProcesarReversion();
        reversion.cuenta='';
        reversion.accion='';
        reversion.bitacota=null;
        reversion.cobroComision=true;
        reversion.idSalesforce='';
        reversion.monto=12;
        reversion.montoPorAporte=12;
        reversion.montoPorSaldo=12;
        reversion.montoRendimiento=12;
        reversion.tipoSaldo='';
        reversion.rezago = '';        
        
        MultiStaticResourceCalloutMock mock = new MultiStaticResourceCalloutMock();
        mock.setStaticResource('http://190.5.68.11:9090/api/obtenerinfocuenta?IdCliente=12345','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/constancias','mockAportes');
        mock.setStaticResource('http://190.5.68.11:9090/api/subproducto','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/aumentodisminucion','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/info','mockCuentas'); 
        mock.setStaticResource('http://190.5.68.11:9090/api/ec/pdf','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/ec/historico/pdf','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/constancias','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/saldos/','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/retiros/','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/cierre','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/retiros/tasa','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/ec/portada?IdCliente=12345','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/ec/trimestral?IdCliente=12345','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/ec/mensual?IdCliente=12345&fechaDesde=2017-07-18&fechaHasta=2017-07-23','mockCuentas');
        mock.setStatusCode(200); 
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        /*aSysdeCallouts.montoCambioDolar(); 
        aSysdeCallouts paola = new aSysdeCallouts();
        aSysdeCallouts.retiros('');
        classConstancias envio2 = new classConstancias();
        classRespuestaConstancias pl = aSysdeCallouts.constancias(envio2);
        aSysdeCallouts.classRespuesta pp = new aSysdeCallouts.classRespuesta();
        pp.codigo = 0;
        pp.mensaje = '';
        
        aSysdeCallouts.VerPDF('', Datetime.now(), Datetime.now());
        aSysdeCallouts.PDFHistorico();
        aSysdeCallouts.reversar('');
        aSysdeCallouts.fechaCierreSysde(date.today()) ;*/
        aSysdeCallouts.MesLetras(12); 
            
           
        
        aSysdeCallouts.montoCambioDolar(); 
        aSysdeCallouts paola = new aSysdeCallouts();
        //aSysdeCallouts.retiros(objCaso.Id);
        //aSysdeCallouts.aumentoDisminucion(objCaso.Id);
        //aSysdeCallouts.Refinanciamiento('', '');
        classConstancias envio2 = new classConstancias();
        classRespuestaConstancias pl = aSysdeCallouts.constancias(envio2);
        aSysdeCallouts.classRespuesta pp = new aSysdeCallouts.classRespuesta();
        pp.codigo = 0;
        pp.mensaje = '';
        
        aSysdeCallouts.VerPDF('', Datetime.now(), Datetime.now());
        aSysdeCallouts.PDFHistorico();
        aSysdeCallouts.reversar('');
        aSysdeCallouts.fechaCierreSysde(date.today()) ;
        aSysdeCallouts.trarerCuentas('');
        aSysdeCallouts.traerSaldos('');
        aSysdeCallouts.verPropietarioCuenta('');
        
        /*MultiStaticResourceCalloutMock mock = new MultiStaticResourceCalloutMock();
        mock.setStaticResource('http://190.5.68.11:9090/api/subproducto','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/aumentodisminucion','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/info','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/ec/pdf','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/ec/historico/pdf','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/constancias','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/saldos/','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/retiros/','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/cierre','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/retiros/tasa','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/ec/portada?IdCliente=12345','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/ec/trimestral?IdCliente=12345','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/ec/mensual?IdCliente=12345&fechaDesde=2017-07-18&fechaHasta=2017-07-23','mockCuentas');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);*/
        
        //Inicio Pasar por el trigger: enviarASysde
        FechaDC_Sysde__c fdcSysde2 = new FechaDC_Sysde__c(Name = 'CierreAlDia', Fecha_cierre__c  = date.today());
        insert fdcSysde2;
        //Fin Pasar por el trigger: enviarASysde
        
        Producto__c producto2 = new Producto__c(Name = 'Producto1', Codigo__c = 'Pro1');
        insert producto2;
        
        Subproducto__c subproducto4 = new Subproducto__c(Name = 'SubProducto1', Codigo__c = 'SubPro1', Producto__c = producto2.id,
                currencyIsoCode = 'HNL');
        insert subproducto4;
        
        Subproducto__c subproducto3 = new Subproducto__c(Name = 'SubProducto2', Codigo__c = 'SubPro2', Producto__c = producto2.id,
                currencyIsoCode = 'HNL');
        insert subproducto3;    
            
        Account natural2 = new Account(Name = 'Juan Perez', Identificacion__c = '1234567890123', /*PersonEmail = 'as@csd.com',*/
                                    RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Juridico'].id);
        insert natural2;
        
        Date hoy2 = date.today();
        Cuentas__c cuentaIndi2 = new Cuentas__c(Name = 'Cuenta', Codigo__c = '1234', Cliente__c = natural2.id, Producto__c = producto2.id,
                                                Fecha_Apertura__c = date.today().addyears(-1),
                                                Subproducto__c = subproducto3.id, currencyIsoCode = 'HNL', /*Fecha_Apertura__c = hoy2,*/
                                                Monto_aporte__c = 5000, Forma_Aportacion__c = 'AH');
        insert cuentaIndi2;
        cuentaIndi2.Codigo__c = '123';
        cuentaIndi2.id = null;
        cuentaIndi2.Fecha_Apertura__c = hoy2;
        insert cuentaIndi2;
        
        Beneficiario__c bene3 = new Beneficiario__c(Cliente__c = natural2.id, Cuenta__c = cuentaIndi2.id, Primer_Apellido__c = 'system',
                                                    Id_Externo__c = 0801, Fecha_nacimiento__c = date.today());
        insert bene3;
        
        list<RecordType> tiposR2 = [Select Name From RecordType Where sObjectType = 'Case' Order by DeveloperName];
        system.debug(tiposR2);
        
        list<Case> casos2 = new list<Case>();
        list<Detalle_caso__c> detalle2 = new list<Detalle_caso__c>();
        
        Case casoActualizacion2 = new Case(AccountId = natural2.id, Nombre_Cliente__c = 'FPC',
                                Status = 'Nuevo', RecordTypeId = tiposR2[0].id, Telefono_Casa__c = '234524534',
                                Telefono_Movil__c = '2345345', Telefono_Trabajo__c = '2345234534',
                                          Tipo_Identificacion__c='4');
        casos2.add(casoActualizacion2);
        
        Case casoSubproducto2 = new Case(AccountId = natural2.id, Status = 'Nuevo', RecordTypeId = tiposR2[2].id);
        casos2.add(casoSubproducto2);     
        
        Case casoAumentoD2 = new Case(AccountId = natural2.id, Status = 'Nuevo', RecordTypeId = tiposR2[1].id);
        casos2.add(casoAumentoD2);
        
        Case casoConstancia2 = new Case(AccountId = natural2.id, Status = 'Nuevo', RecordTypeId = tiposR2[3].id);
        casos2.add(casoConstancia2);
        
        Case casoRetiro2 = new Case(AccountId = natural2.id, Status = 'Nuevo', RecordTypeId = tiposR2[6].id);
        casos2.add(casoRetiro2);
                
        insert Casos2;
        asysdeCallouts.ReposicionCarnet(Casos2[0].id);
        
        ContentVersion cv = new ContentVersion();
        cv.ContentLocation = 'S';
        //cv.ContentDocumentId = Casos2[0].id;
        cv.VersionData = EncodingUtil.base64Decode('hola');
        cv.Title = 'hola';
        cv.PathOnClient = 'hola';
        
        insert cv;
        
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id].ContentDocumentId;
        cdl.LinkedEntityId = Casos2[0].id;
        cdl.ShareType = 'V';
        insert cdl;  
        
        list<Detalle_caso__c> detalles2 = new list<Detalle_caso__c>();
        list<Beneficiario__c> identidades2=new list<Beneficiario__c>();
        
        identidades2= [select Identidad__c, Id_Externo__c from Beneficiario__c];
        
        Detalle_caso__c nuevoSP = new Detalle_Caso__c(Caso__c = Casos2[0].id,Cuenta__c = cuentaIndi2.id,
                Fecha_nacimiento__c = date.today());
        detalles2.add(nuevoSP);
        detalles2.add(new Detalle_Caso__c(Caso__c = Casos2[1].id,Nuevo_Subproducto__c = subproducto4.id, Cuenta__c = cuentaIndi2.id));
        detalles2.add(new Detalle_Caso__c(Caso__c = Casos2[2].id, Nuevo_monto_aporte__c = 7000, Cuenta__c = cuentaIndi2.id));
        detalles2.add(new Detalle_Caso__c(Caso__c = Casos2[4].id, Cuenta__c = cuentaIndi2.id));
        insert detalles2;
         
		Case caso = new case();
        Caso.Status='Nuevo';
        Caso.type='Solicitud de Gestión';
        Caso.Origin='Web';
        Caso.Priority= 'Media'; 
        Caso.RecordTypeId = [Select Name,id From RecordType Where sObjectType = 'Case' and name ='Constancia'].id;
        caso.AccountId =  natural2.id;
        caso.Constancia__c = 'P1';
        insert caso;
        Detalle_Caso__c detalle = new Detalle_Caso__c();
        detalle.cuenta__C=cuentaIndi2.id;
        detalle.monto_a_pignorar__C = 0;
        detalle.monto_pignorado__C =0;
        detalle.Total_Saldo_Patronal__c=0;
        detalle.total_saldo_personal__C=0;
        detalle.Numero_Prestamo__c ='sx';
        detalle.Prestamo_anterior__c ='ew';
        detalle.Es_Refinanciamiento__c =true;
        detalle.No_es_primer_prestamo__c=true;
        detalle.Accion__c = 'A2';
        //detalle.Detalle_subproducto__c = subproducto.id;
        detalle.Caso__c=caso.id;
        detalle.Monto_total_retirar__c = 0;
        detalle.Aplica_Cambio_Sub_Producto_desde_Retiros__c=true;
        insert detalle;
        
        //-----------------------------//
        List<RecordType> rtypes = [Select Id,Name,DeveloperName From RecordType where sObjectType='Case' and isActive=true and DeveloperName = 'Retiros'];
        
        caso.RecordTypeId = rtypes[0].Id;
        caso.Aprobado__c = false;
        caso.Requiere_aprobacion_exoneracion__c = false;
        Update caso;
        
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setObjectId(Caso.id);
        req1.setProcessDefinitionNameOrId('Retiros_sin_Exoneracion');
        Approval.ProcessResult result = Approval.process(req1);
            
        List<ProcessInstanceWorkitem> workItems = [SELECT Id, ProcessInstanceId FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId =: Caso.Id];
        List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
        for(ProcessInstanceWorkitem workItem : workItems){
        	Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
            req.setWorkitemId(workItem.Id);
            req.setAction('Approved');
            req.setComments('Monto erróneo.');
            requests.add(req);
        }
        //----------------------------//
        
        test.startTest();
        
            list<Case> casosF = [Select Status,Aprobado__c From Case Where Id In: casos2];
            system.debug(casosF);
            For(Case item : casosF){
                item.Status = 'Cerrado';
                item.Aprobado__c = true;
                item.Segunda_aprobacion__c = true;
            }
            update casosF;
        list<id> listcasosid = new list<id>();
        listcasosid.add(caso.id);
        aSysdeCallouts.ConstanciaPignoracion(listcasosid, 'Nuevo');
        aSysdeCallouts.retiros(caso.id);
        aSysdeCallouts.movimientosReversiones(null);
         aSysdeCallouts.movimientosReversionesRendimiento(null);
        Autonumerico_cuentas_Syste__c ds= new Autonumerico_cuentas_Syste__c(Id_Formulario_Sysde__c=12); 
        insert ds;
        aSysdeCallouts.reversar(caso.id);
            //Boolean fechaCierre = aSysdeCallouts.fechaCierreSysde(Date.today());
            
            
            ApexPages.currentPage().getParameters().put('id',Casos2[2].id);
            controllerAprobarCasos controlAprobar = new controllerAprobarCasos();
            controlAprobar.rechazar();
            controlAprobar.adjuntar();
            controlAprobar.cerrar();
            controlAprobar.aprobar();
            
            ApexPages.currentPage().getParameters().put('id',Casos2[2].id);
            controllerAdjuntarArchivo controlAdjuntar = new controllerAdjuntarArchivo();
            controlAdjuntar.UploadFile();
            controlAdjuntar.fileBody = blob.valueOf('Probando');  
            controlAdjuntar.fileName = 'Algo';
            controlAdjuntar.UploadFile();
            Attachment hola = new Attachment(ParentId = casos2[2].id, Body = blob.valueOf('Nada'), Name = 'Llui');
            insert hola;
            
            ApexPages.currentPage().getParameters().put('id',Casos2[2].id);
            controllerAdjuntarArchivo controlAdjuntar2 = new controllerAdjuntarArchivo();
            controlAdjuntar2.fileBody = blob.valueOf('Probando');  
            controlAdjuntar2.fileName = 'Algo';
            controlAdjuntar2.UploadFile();
        
            
        extensionCasoDetalle.metodoutil();
        Detalle_caso__c a =[select accion__C, id, caso__C from Detalle_caso__c limit 1];
        a.Accion__c='A1';
        update a;
        aSysdeCallouts.accionSubProducto(a.Caso__c);
        a.Accion__c='A3';
        update a;
        aSysdeCallouts.accionSubProducto(a.Caso__c);
        extensionCasoDetalle controlNormal = new extensionCasoDetalle();
        ////desde aqui original
        FechaDC_Sysde__c fdcSysde = new FechaDC_Sysde__c(Name = 'CierreAlDia', Fecha_cierre__c  = date.today());
        insert fdcSysde;
        
       Producto__c producto = new Producto__c(Name = 'Producto1', Codigo__c = 'Pro12');
        insert producto;
        
        Subproducto__c subproducto = new Subproducto__c(Name = 'SubProducto1', Codigo__c = 'SubPro12', Producto__c = producto.id);
        insert subproducto;
        
        Subproducto__c subproducto2 = new Subproducto__c(Name = 'SubProducto2', Codigo__c = 'SubPro22', Producto__c = producto.id);
        insert subproducto2;
        
        Account natural = new Account(FirstName = 'Juan', LastName = 'Perez', Identificacion__c = '123456',
                                    RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Natural'].id);
        insert natural;
        Date hoy = date.today();
        Cuentas__c cuentaIndi = new Cuentas__c(Name = 'Cuenta', Codigo__c = '12398', Cliente__c = natural.id, Producto__c = producto.id,
                                            Subproducto__c = subproducto.id, currencyIsoCode = 'USD', Fecha_Apertura__c = hoy,
                                            Monto_aporte__c = 5000);
        insert cuentaIndi;
        
        Beneficiario__c bene = new Beneficiario__c(Cliente__c = natural.id, Cuenta__c = cuentaIndi.id, Primer_Apellido__c = 'system',
                                                     Id_Externo__c = 0806, Fecha_nacimiento__c = date.today());
        insert bene;
                                    
        Account juridico = new Account(Name = 'Intellect', Identificacion__c = '54321',
                                    RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Juridico'].id);
        insert juridico;                            
        
        Cuentas__c cuentaColec = new Cuentas__c(Name = 'Cuenta2',Codigo__c = '789', Cliente__c = juridico.id, currencyIsoCode = 'HNL');
        insert cuentaColec;
        
        Cuentas__c cuentaIndiColec = new Cuentas__c(Name = 'Cuenta3', Codigo__c = '456', Cliente__c = natural.id, 
                        Cuenta_colectiva2__c = cuentaColec.id, currencyIsoCode = 'HNL', Fecha_Apertura__c = hoy);
        insert cuentaIndiColec;
        
        estadosDeCuenta.InsertarCorreos();
        //estadosDeCuenta.CambiarEstadoCorreos('A1');
        //FechaDC_Sysde__c fcsd = new FechaDC_Sysde__c (Fecha_cierre__c = date.today(),  Trimestre_Terminado__C = false, Total_Correos_Enviados__C=0,Name = 'CierreAlDia');
        //insert fcsd;
        asysdeCallouts.EjecutarJobEDCMasivo(date.valueOf(datetime.newInstance(2020, 1, 1)));
        asysdeCallouts.EjecutarJobEDCMasivo(date.valueOf(datetime.newInstance(2020, 4, 1)));
        asysdeCallouts.EjecutarJobEDCMasivo(date.valueOf(datetime.newInstance(2020, 7, 1)));
        asysdeCallouts.EjecutarJobEDCMasivo(date.valueOf(datetime.newInstance(2020, 10, 1)));
        asysdeCallouts.Empresas();
        asysdeCallouts.estadoCuentaHistoricoMasivo('sa');
        
        controladorEstadoCuentaMasivo c = new controladorEstadoCuentaMasivo(new ApexPages.StandardController(natural2));
        
            String recordType = Schema.SObjectType.Case.getRecordTypeInfosByDevelopername().get('Actualizacion_informacion').getRecordTypeId();
            Account cliente = new Account();
            cliente.Name='Luis Donaire';
            cliente.Identificacion__c='0709199300155';
            insert cliente;
            
            Case objCaso = new case();
            objCaso.AccountId = cliente.Id;
            objCaso.Identificacion__c='0709199300135';
            objCaso.RecordTypeId = recordType;
            objCaso.Status = 'Nuevo';
            objCaso.Telefono_Casa__c = '32323232';
            objCaso.Telefono_Movil__c= '32323232';
            objCaso.Telefono_Trabajo__c= '32323232';
            insert objCaso;
            
            Detalle_caso__c objDetalle = new Detalle_caso__c();
            objDetalle.Caso__c = objCaso.Id;
            objDetalle.Cuenta__c = cuentaIndiColec.Id;
            objDetalle.Nuevo_monto_aporte__c = 32.21;
            insert objDetalle;
            
            aSysdeCallouts.bloquerCasoConstancia(null);
            aSysdeCallouts.retiros(objCaso.Id);
            aSysdeCallouts.aumentoDisminucion(objCaso.Id);
            aSysdeCallouts.Refinanciamiento('', '');
            List<String> idCasos = new List<String>();
            idCasos.add(objCaso.Id);
            aSysdeCallouts.ConstanciaPignoracion(idCasos, 'Nuevo');
            aSysdeCallouts.ConstanciaPignoracion(idCasos, 'Cerrado');
            aSysdeCallouts.actualizacionInformacion(objCaso.Id);
            aSysdeCallouts.ConstanciaPignoracion(null);
            aSysdeCallouts.VarURL p = new aSysdeCallouts.VarURL();
            p.desde = null;
            p.hasta = null;
            p.idcli = null;
        test.stopTest();  
        }
    }

}