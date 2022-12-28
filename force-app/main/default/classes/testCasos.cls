@isTest
public class testCasos {
    
    static testMethod void casosSAC(){ 
        MultiStaticResourceCalloutMock mock = new MultiStaticResourceCalloutMock();
        mock.setStaticResource('http://190.5.68.11:9090/api/obtenerinfocuenta?IdCliente=12345','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/constancias','mockAportes');
        mock.setStatusCode(200); 
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        FechaDC_Sysde__c fdcSysde = new FechaDC_Sysde__c(Name = 'CierreAlDia', Fecha_cierre__c  = date.today());
        insert fdcSysde;
        
        Producto__c producto = new Producto__c(Name = 'Producto1', Codigo__c = 'Pro1');
        insert producto;
        
        Subproducto__c subproducto = new Subproducto__c(Name = 'SubProducto1', Codigo__c = 'SubPro1', Producto__c = producto.id);
        insert subproducto;
        
        Subproducto__c subproducto2 = new Subproducto__c(Name = 'SubProducto2', Codigo__c = 'SubPro2', Producto__c = producto.id);
        insert subproducto2;
        
        Account natural = new Account(FirstName = 'Juan', LastName = 'Perez', Identificacion__c = '12345',
                                      RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Natural'].id);
        insert natural;
        Date hoy = date.today();
        Cuentas__c cuentaIndi = new Cuentas__c(Name = 'Cuenta', Codigo__c = '123', Cliente__c = natural.id, Producto__c = producto.id,
                                               Subproducto__c = subproducto.id, currencyIsoCode = 'HNL', Fecha_Apertura__c = hoy,
                                               Monto_aporte__c = 5000);
        insert cuentaIndi;
        
        Beneficiario__c bene = new Beneficiario__c(Cliente__c = natural.id, Cuenta__c = cuentaIndi.id, Primer_Apellido__c = 'system',
                                                   Id_Externo__c = 0801, Fecha_nacimiento__c = date.today());
        insert bene;
        
        Account juridico = new Account(Name = 'Intellect', Identificacion__c = '54321',
                                       RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Juridico'].id);
        insert juridico;                            
        
        Cuentas__c cuentaColec = new Cuentas__c(Name = 'Cuenta2',Codigo__c = '789', Cliente__c = juridico.id, currencyIsoCode = 'HNL');
        insert cuentaColec;
        
        Cuentas__c cuentaIndiColec = new Cuentas__c(Name = 'Cuenta3', Codigo__c = '456', Cliente__c = natural.id, 
                                                    Cuenta_colectiva2__c = cuentaColec.id, currencyIsoCode = 'HNL', Fecha_Apertura__c = hoy);
        insert cuentaIndiColec;
        
        list<RecordType> tiposR = [Select Name From RecordType Where sObjectType = 'Case' Order by DeveloperName];
        system.debug(tiposR);
        Map<String, String> mapTipoR = new Map<String, String>();
        for(RecordType item: [Select Name, DeveloperName,Id From RecordType Where sObjectType = 'Case' Order by DeveloperName]){
            mapTipoR.put(item.DeveloperName, item.Id);
        }
        
        list<Case> casos = new list<Case>();
        
        Case casoActualizacion = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[0].id);
        casos.add(casoActualizacion);
        
        Case casoSubproducto = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[2].id);
        casos.add(casoSubproducto);
        
        Case casoConstancia = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[3].id);
        casos.add(casoConstancia);
        
        Case casoRetiros = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[6].id);
        casos.add(casoRetiros);
        
        Case casoAumentoD2 = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[1].id);
        casos.add(casoAumentoD2);
        
        Case casoRetiros2 = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[6].id);
        casos.add(casoRetiros2);
        
        insert Casos;
        
        Case casoAumentoD = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[1].id);
        
        list<Detalle_caso__c> detalleCasos = new list<Detalle_caso__c>();
        Detalle_caso__c detalle = new Detalle_Caso__c(Caso__c = Casos[0].id, Cuenta__c = cuentaIndi.id);
        detalleCasos.add(detalle);
        
        Detalle_caso__c detalle1 = new Detalle_Caso__c(Caso__c = Casos[5].id, Cuenta__c = cuentaIndi.id,Cabeza_retiro__c = true,
                                                       Forma_Retiro__c = 'ACH');
        detalleCasos.add(detalle1);
        
        Detalle_caso__c detalle2 = new Detalle_Caso__c(Caso__c = Casos[5].id, Cuenta__c = cuentaIndi.id,
                                                       Saldo_retirar__c = '10', Monto_Saldo__c = 100, Monto_retirar__c = 50);
        detalleCasos.add(detalle2);
        
        insert detalleCasos;
        
        test.startTest();
        extensionCasoDetalle controlActinfo = new extensionCasoDetalle(new ApexPages.StandardController(Casos[0]));
        controlActinfo.selecCuenta();
        controlActinfo.llenarCuentasDesdeSysde();
        controlActinfo.verBeneficiarios();
        controlActinfo.listBeneficiarios[0].Casilla__c = true;
        controlActinfo.agregarBeneficiarios();
        controlActinfo.agregarCuenta();
        controlActinfo.eliminarCuenta();
        controlActinfo.idDetalleEliminar = cuentaIndi.id;       
        controlActinfo.verAportes();
        controlActinfo.selecAporte();
        controlActinfo.guardar();
        
        extensionCasoDetalle controlSubproducto = new extensionCasoDetalle(new ApexPages.StandardController(casos[1]));
        controlSubproducto.accionSubproducto();
        controlSubproducto.buscarCuentaC();
        controlSubproducto.buscarSubPro();
        controlSubproducto.guardar();
        
        extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casos[2]));                                  
        controlConsta.agregarCuenta();
        controlConsta.agregarCuenta();
        controlConsta.idDetalleEliminar = cuentaIndi.id;        
        controlConsta.eliminarCuenta();             
        controlConsta.guardar();
        
        extensionCasoDetalle controlRetiro = new extensionCasoDetalle(new ApexPages.StandardController(casos[3]));
        controlRetiro.verPropietarioCuenta();            
        controlRetiro.detalleCaso.Cliente_quiere_capital_semilla__c = false;
        controlRetiro.detalleCaso.Tipo_retiro__c = '52';
        //controlRetiro.selecTipoRetiro();
        controlRetiro.detalleCaso.Cliente_quiere_capital_semilla__c = true;
        //controlRetiro.selecTipoRetiro();
        controlRetiro.verMovimientos();
        controlRetiro.selecMovimiento(); 
        controlRetiro.cuentasCaso.add(new Detalle_Caso__c(Cuenta__c = natural.id, Caso__c = casos[3].id, Saldo_retirar__c = '10',
                                                          Monto_Saldo__c = 100, Monto_retirar__c = -2));  
        
        controlRetiro.guardar();
        controlRetiro.cuentasCaso[0].Monto_retirar__c = 200;
        controlRetiro.guardar();
        controlRetiro.cuentasCaso[0].Monto_retirar__c = 50;
        controlRetiro.guardar();
        
        cuentaIndiColec.fecha_apertura__c = date.today() - 950;
        update cuentaIndiColec;
        
        test.stopTest();                                        
    }
    
    static testMethod void casosSAC2(){ 
        MultiStaticResourceCalloutMock mock = new MultiStaticResourceCalloutMock();
        mock.setStaticResource('http://190.5.68.11:9090/api/obtenerinfocuenta?IdCliente=12345','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/constancias','mockAportes');
        mock.setStatusCode(200); 
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        FechaDC_Sysde__c fdcSysde = new FechaDC_Sysde__c(Name = 'CierreAlDia', Fecha_cierre__c  = date.today());
        insert fdcSysde;
        
        Producto__c producto = new Producto__c(Name = 'Producto1', Codigo__c = 'Pro1');
        insert producto;
        
        Subproducto__c subproducto = new Subproducto__c(Name = 'SubProducto1', Codigo__c = 'SubPro1', Producto__c = producto.id);
        insert subproducto;
        
        Subproducto__c subproducto2 = new Subproducto__c(Name = 'SubProducto2', Codigo__c = 'SubPro2', Producto__c = producto.id);
        insert subproducto2;
        
        Account natural = new Account(FirstName = 'Juan', LastName = 'Perez', Identificacion__c = '12345',
                                      RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Natural'].id);
        insert natural;
        Date hoy = date.today();
        Cuentas__c cuentaIndi = new Cuentas__c(Name = 'Cuenta', Codigo__c = '123', Cliente__c = natural.id, Producto__c = producto.id,
                                               Subproducto__c = subproducto.id, currencyIsoCode = 'HNL', Fecha_Apertura__c = hoy,
                                               Monto_aporte__c = 5000);
        insert cuentaIndi;
        
        Beneficiario__c bene = new Beneficiario__c(Cliente__c = natural.id, Cuenta__c = cuentaIndi.id, Primer_Apellido__c = 'system',
                                                   Id_Externo__c = 0801, Fecha_nacimiento__c = date.today());
        insert bene;
        
        Account juridico = new Account(Name = 'Intellect', Identificacion__c = '54321',
                                       RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Juridico'].id);
        insert juridico;                            
        
        Cuentas__c cuentaColec = new Cuentas__c(Name = 'Cuenta2',Codigo__c = '789', Cliente__c = juridico.id, currencyIsoCode = 'HNL');
        insert cuentaColec;
        
        Cuentas__c cuentaIndiColec = new Cuentas__c(Name = 'Cuenta3', Codigo__c = '456', Cliente__c = natural.id, 
                                                    Cuenta_colectiva2__c = cuentaColec.id, currencyIsoCode = 'HNL', Fecha_Apertura__c = hoy);
        insert cuentaIndiColec;
        
        list<RecordType> tiposR = [Select Name From RecordType Where sObjectType = 'Case' Order by DeveloperName];
        system.debug(tiposR);
        
        list<Case> casos = new list<Case>();
        
        Case casoActualizacion = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[0].id);
        casos.add(casoActualizacion);
        
        Case casoSubproducto = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[2].id);
        casos.add(casoSubproducto);
        
        Case casoConstancia = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[3].id);
        casos.add(casoConstancia);
        
        Case casoRetiros = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[6].id);
        casos.add(casoRetiros);
        
        Case casoAumentoD2 = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[1].id);
        casos.add(casoAumentoD2);
        
        Case casoRetiros2 = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[6].id);
        casos.add(casoRetiros2);
        
        insert Casos;
        
        Case casoAumentoD = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[1].id);
        
        list<Detalle_caso__c> detalleCasos = new list<Detalle_caso__c>();
        Detalle_caso__c detalle = new Detalle_Caso__c(Caso__c = Casos[0].id, Cuenta__c = cuentaIndi.id);
        detalleCasos.add(detalle);
        
        Detalle_caso__c detalle1 = new Detalle_Caso__c(Caso__c = Casos[5].id, Cuenta__c = cuentaIndi.id,Cabeza_retiro__c = true,
                                                       Forma_Retiro__c = 'ACH');
        detalleCasos.add(detalle1);
        
        Detalle_caso__c detalle2 = new Detalle_Caso__c(Caso__c = Casos[5].id, Cuenta__c = cuentaIndi.id,
                                                       Saldo_retirar__c = '10', Monto_Saldo__c = 100, Monto_retirar__c = 50);
        detalleCasos.add(detalle2);
        
        insert detalleCasos;
        
        test.startTest();
        
        extensionCasoDetalle controlRetiro2 = new extensionCasoDetalle(new ApexPages.StandardController(casos[5]));
        //controlRetiro2.selecCuentaRetiros();
        controlRetiro2.detalleCaso.Tipo_retiro__c = '52';
        // controlRetiro2.selecTipoRetiro();
        controlRetiro2.guardar();
        
        extensionCasoDetalle controlADA2 = new extensionCasoDetalle(new ApexPages.StandardController(casos[4]));
        controlADA2.detalleCaso.Nuevo_monto_aporte__c = 7000;            
        controlADA2.guardar();
        
        //ApexPages.currentPage().getParameters().put('idCliente',natural.id);
        extensionCasoDetalle controlADA = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD));
        controlADA.accionVacia();
        controlADA.accionVacia2();
        controlADA.idTipoRCaso = tiposR[1].id;
        controlADA.Caso.Origin = 'Call center';
        controlADA.continuarAlPaso2();
        controlADA.idTipoRCaso = tiposR[1].id;
        controlADA.continuarAlPaso2();
        controlADA.formularioCliente();
        controlADA.adjuntarArchivo();
        controlADA.esCallcenter = true;
        controlADA.detalleCaso.Nuevo_monto_aporte__c = 7000;
        controlADA.guardar();
        
        extensionCasoDetalle controlADA3 = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD));
        controlADA3.idTipoRCaso = tiposR[1].id;
        controlADA3.continuarAlPaso2();
        controlADA3.esCallcenter = true;
        controlADA3.detalleCaso.Tipo_Operacion__c = 'A3';
        controlADA3.guardar();
        
        extensionCasoDetalle controlADA4 = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD));
        controlADA4.idTipoRCaso = tiposR[1].id;
        controlADA4.continuarAlPaso2();
        controlADA4.esCallcenter = true;
        controlADA4.detalleCaso.Tipo_Operacion__c = 'A4';
        controlADA4.guardar();
        
        extensionCasoDetalle controlADA5 = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD));
        controlADA5.idTipoRCaso = tiposR[1].id;
        controlADA5.continuarAlPaso2();
        controlADA5.esBanco = true;
        controlADA5.detalleCaso.Tipo_Operacion__c = 'A1';
        controlADA5.detalleCaso.Nuevo_monto_aporte__c = 7000;
        controlADA5.guardar();
        extensionCasoDetalle.metodoutil();
        extensionCasoDetalle controlNormal = new extensionCasoDetalle();
        
        controlNormal.idCaso = casos[3].id;
        controlNormal.verCaso();
        controlNormal.cerrarCaso();
        controlNormal.generarConstancia();
        controlNormal.generarED();
        test.stopTest();                                        
    }
    
    static testMethod void llamadasREST(){ 
        MultiStaticResourceCalloutMock mock = new MultiStaticResourceCalloutMock();
        mock.setStaticResource('http://190.5.68.11:9090/api/subproducto','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/aumentodisminucion','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/info','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/ec/portada?IdCliente=12345','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/ec/trimestral?IdCliente=12345','mockCuentas');
        mock.setStaticResource('http://190.5.68.11:9090/api/ec/mensual?IdCliente=12345&fechaDesde=2017-07-18&fechaHasta=2017-07-23','mockCuentas');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        FechaDC_Sysde__c fdcSysde = new FechaDC_Sysde__c(Name = 'CierreAlDia', Fecha_cierre__c  = date.today());
        insert fdcSysde;
        
        Producto__c producto = new Producto__c(Name = 'Producto1', Codigo__c = 'Pro1');
        insert producto;
        
        Subproducto__c subproducto = new Subproducto__c(Name = 'SubProducto1', Codigo__c = 'SubPro1', Producto__c = producto.id,
                                                        currencyIsoCode = 'HNL');
        insert subproducto;
        
        Subproducto__c subproducto2 = new Subproducto__c(Name = 'SubProducto2', Codigo__c = 'SubPro2', Producto__c = producto.id,
                                                         currencyIsoCode = 'HNL');
        insert subproducto2;
        
        Account natural = new Account(FirstName = 'Juan', LastName = 'Perez', Identificacion__c = '12345',
                                      RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Natural'].id);
        insert natural;
        
        Date hoy = date.today();
        Cuentas__c cuentaIndi = new Cuentas__c(Name = 'Cuenta', Codigo__c = '123', Cliente__c = natural.id, Producto__c = producto.id,
                                               Subproducto__c = subproducto.id, currencyIsoCode = 'HNL', Fecha_Apertura__c = hoy,
                                               Monto_aporte__c = 5000, Forma_Aportacion__c = 'AH');
        insert cuentaIndi;
        
        list<RecordType> tiposR = [Select Name From RecordType Where sObjectType = 'Case' Order by DeveloperName];
        system.debug(tiposR);
        
        list<Case> casos = new list<Case>();
        
        Case casoActualizacion = new Case(AccountId = natural.id, Nombre_Cliente__c = 'FPC',
                                          Status = 'Nuevo', RecordTypeId = tiposR[0].id, Telefono_Casa__c = '234524534',
                                          Telefono_Movil__c = '2345345', Telefono_Trabajo__c = '2345234534');
        casos.add(casoActualizacion);
        
        Case casoSubproducto = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[2].id);
        casos.add(casoSubproducto);     
        
        Case casoAumentoD = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[1].id);
        casos.add(casoAumentoD);
        
        Case casoConstancia = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[3].id);
        casos.add(casoConstancia);
        
        Case casoRetiro = new Case(AccountId = natural.id, Status = 'Nuevo', RecordTypeId = tiposR[6].id);
        casos.add(casoRetiro);
        
        insert Casos;
        
        list<Detalle_caso__c> detalles = new list<Detalle_caso__c>();
        
        Detalle_caso__c nuevoSP = new Detalle_Caso__c(Caso__c = Casos[0].id,Cuenta__c = cuentaIndi.id,
                                                      Fecha_nacimiento__c = date.today());
        detalles.add(nuevoSP);
        detalles.add(new Detalle_Caso__c(Caso__c = Casos[1].id,Nuevo_Subproducto__c = subproducto2.id, Cuenta__c = cuentaIndi.id));
        detalles.add(new Detalle_Caso__c(Caso__c = Casos[2].id, Nuevo_monto_aporte__c = 7000, Cuenta__c = cuentaIndi.id));
        detalles.add(new Detalle_Caso__c(Caso__c = Casos[4].id, Cuenta__c = cuentaIndi.id));
        insert detalles;
        
        test.startTest();
        list<Case> casosF = [Select Status,Aprobado__c From Case Where Id In: casos];
        system.debug(casosF);
        For(Case item : casosF){
            item.Status = 'Cerrado';
            item.Archivo_Adjunto__c = true;
            item.Aprobado__c = true;
            item.Segunda_aprobacion__c = true;
        }
        update casosF;
        
        //Boolean fechaCierre = aSysdeCallouts.fechaCierreSysde(Date.today());
        //Decimal montoCambio = aSysdeCallouts.montoCambioDolar();           
        
        ApexPages.currentPage().getParameters().put('id',Casos[2].id);
        controllerAprobarCasos controlAprobar = new controllerAprobarCasos();
        controlAprobar.rechazar();
        controlAprobar.adjuntar();
        controlAprobar.cerrar();
        controlAprobar.aprobar();
        
        ApexPages.currentPage().getParameters().put('id',Casos[2].id);
        controllerAdjuntarArchivo controlAdjuntar = new controllerAdjuntarArchivo();
        controlAdjuntar.UploadFile();
        controlAdjuntar.fileBody = blob.valueOf('Probando');  
        controlAdjuntar.fileName = 'Algo';
        controlAdjuntar.UploadFile();
        Attachment hola = new Attachment(ParentId = casos[2].id, Body = blob.valueOf('Nada'), Name = 'Llui');
        insert hola;
        
        ApexPages.currentPage().getParameters().put('id',Casos[2].id);
        controllerAdjuntarArchivo controlAdjuntar2 = new controllerAdjuntarArchivo();
        controlAdjuntar2.fileBody = blob.valueOf('Probando');  
        controlAdjuntar2.fileName = 'Algo';
        controlAdjuntar2.UploadFile();
        
        test.stopTest();
    }
}