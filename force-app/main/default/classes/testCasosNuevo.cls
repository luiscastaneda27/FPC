@isTest
public class testCasosNuevo {
    static testMethod void casosSAC(){ 
        try{
            MultiStaticResourceCalloutMock mock = new MultiStaticResourceCalloutMock();
            mock.setStaticResource('http://190.5.68.11:9090/api/obtenerinfocuenta?IdCliente=12345','mockCuentas');
            mock.setStaticResource('http://190.5.68.11:9090/api/constancias','mockAportes');
            mock.setStatusCode(200); 
            mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
            Test.setMock(HttpCalloutMock.class, mock);
            Usuarios_para_asignacion_Casos_SAC__c f = new Usuarios_para_asignacion_Casos_SAC__c();
            //f.Zona__c='2';
            f.Usuario__c = userinfo.getUserId();
            insert f;
            f = new Usuarios_para_asignacion_Casos_SAC__c();
            f.Zona__c='2';
            f.Usuario__c = userinfo.getUserId();
            insert f;
            
            
            FechaDC_Sysde__c fdcSysde = new FechaDC_Sysde__c(Name = 'CierreAlDia', Fecha_cierre__c  = date.today());
            insert fdcSysde;
            
            Producto__c producto = new Producto__c(Name = 'Producto1', Codigo__c = 'Pro1');
            insert producto;
            
            Subproducto__c subproducto = new Subproducto__c(Name = 'SubProducto1', Codigo__c = 'SubPro1', Producto__c = producto.id);
            insert subproducto;
            
            Subproducto__c subproducto2 = new Subproducto__c(Name = 'SubProducto2', Codigo__c = 'SubPro2', Producto__c = producto.id);
            insert subproducto2;
            list<Subproducto__c> listSubrProducto = new list<Subproducto__c>();
            Account natural = new Account(FirstName = 'Juan', LastName = 'Perez', Identificacion__c = '12345', PersonBirthdate = date.valueOf('1990-10-11'),
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
            
            map<String, String> mapTipoR = new map<String, String>();
            for(RecordType item: [Select Name, DeveloperName, id From RecordType Where sObjectType = 'Case' and name !='Retiros20' Order by DeveloperName ]){
                mapTipoR.put(item.DeveloperName, item.id);
            }
            //list<RecordType> tiposR = [Select Name From RecordType Where sObjectType = 'Case' and name !='Retiros20' Order by DeveloperName ];
            //system.debug(tiposR);
            
            Asset ass = new Asset(AccountId=juridico.Id,Name='testing');   
            insert ass;
            
            Entitlement ent = new Entitlement(Name='Testing', AccountId=juridico.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
            insert ent;
            
            list<Case> casos = new list<Case>();
            
            Case casoActualizacion = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Actualizacion_informacion'));
            casos.add(casoActualizacion);
            
            Case casoSubproducto = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Cambio_Subproducto'));
            casos.add(casoSubproducto);
            
            Case casoConstancia = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Constancia'));
            casos.add(casoConstancia);
            
            Case casoRetiros = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Retiros'));
            casos.add(casoRetiros);
            
            Case casoAumentoD2 = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Aumento_Disminucion_Aportes'));
            casos.add(casoAumentoD2);
            
            Case casoRetiros2 = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Retiros'));
            casos.add(casoRetiros2);
            
            Case casoReversiones = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Reversiones'));
            casos.add(casoReversiones);
            
            insert Casos;
            
            Case casoAumentoD = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Aumento_Disminucion_Aportes'));
            
            list<Detalle_caso__c> detalleCasos = new list<Detalle_caso__c>();
            Detalle_caso__c detalle = new Detalle_Caso__c(Caso__c = Casos[0].id, Cuenta__c = cuentaIndi.id);
            detalleCasos.add(detalle);
            
            Detalle_caso__c detalle1 = new Detalle_Caso__c(Caso__c = Casos[5].id, Cuenta__c = cuentaIndi.id,Cabeza_retiro__c = true,Monto_Saldo_Patronal__c = 100,
                                                           Forma_Retiro__c = 'CK', Porcentaje_Saldo_Patronal__c=12,Porcentaje_CRA_Individual__c=12);
            detalleCasos.add(detalle1);
            
            Detalle_caso__c detalle2 = new Detalle_Caso__c(Caso__c = Casos[5].id, Cuenta__c = cuentaIndi.id,Monto_Saldo_Patronal__c = 100,
                                                           Saldo_retirar__c = '10', Monto_Saldo__c = 100, Monto_retirar__c = 50);
            detalleCasos.add(detalle2);
            
            insert detalleCasos;
            
            test.startTest();
            extensionCasoDetalle controlActinfo = new extensionCasoDetalle(new ApexPages.StandardController(Casos[0]));
            controlActinfo.selecCuenta();
            controlActinfo.llenarCuentasDesdeSysde();
            controlActinfo.verBeneficiarios();
            if(controlActinfo.listBeneficiarios.size()>0){
                controlActinfo.listBeneficiarios[0].Casilla__c = true;
            }
            controlActinfo.agregarBeneficiarios();
            controlActinfo.agregarCuenta();
            controlActinfo.eliminarCuenta();
            controlActinfo.idDetalleEliminar = cuentaIndi.id;       
            controlActinfo.verAportes();
            controlActinfo.selecAporte();
            controlActinfo.guardar();
            //controlActinfo.updateCasoRetiros();
            //controlActinfo.addPagoBene2(); 
            
            extensionCasoDetalle controlSubproducto = new extensionCasoDetalle(new ApexPages.StandardController(casos[1]));
            controlSubproducto.accionSubproducto();
            controlSubproducto.buscarCuentaC();
            controlSubproducto.buscarSubPro();
            controlSubproducto.guardar();
            //controlSubproducto.updateCasoRetiros();
            
            extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casos[2]));                                  
            controlConsta.agregarCuenta();
            controlConsta.agregarCuenta();
            controlConsta.idDetalleEliminar = cuentaIndi.id;        
            controlConsta.eliminarCuenta();             
            controlConsta.guardar();
            //controlConsta.updateCasoRetiros();
            /*
extensionCasoDetalle controlRetiro = new extensionCasoDetalle(new ApexPages.StandardController(casos[3]));
controlRetiro.verPropietarioCuenta();            
controlRetiro.detalleCaso.Cliente_quiere_capital_semilla__c = false;
controlRetiro.detalleCaso.Tipo_retiro__c = '52';
controlRetiro.selecTipoRetiro();
controlRetiro.detalleCaso.Cliente_quiere_capital_semilla__c = true;
controlRetiro.selecTipoRetiro();
controlRetiro.verMovimientos();
controlRetiro.selecMovimiento(); 
//controlRetiro.detalleCaso.Fecha_Despido_Empresa__c=date.today();
//  controlRetiro.detalleCaso.Fecha_Ingreso_Empresa__c=date.today().addyears(-1);
controlRetiro.calculoSaldoPatronales();
controlRetiro.calculoSaldoPatronales2();
controlRetiro.detalleCaso.Fecha_Despido_Empresa__c=date.today();
controlRetiro.detalleCaso.Fecha_Ingreso_Empresa__c=date.today().addyears(-1);
controlRetiro.calculoSaldoPatronales(); 
controlRetiro.calculoSaldoPatronales2();
controlRetiro.cuentasCaso.add(new Detalle_Caso__c(Cuenta__c = natural.id, Caso__c = casos[3].id, Saldo_retirar__c = '10',
Monto_Saldo__c = 100, Monto_retirar__c = -2, CurrencyIsoCode='HNL')); 

controlRetiro.ValidacionSaldoPatronales();
controlretiro.caso.Aplica_Saldo_patronal__c=true;
controlRetiro.detalleCaso.Total_Saldo_Personal__c =30;
controlRetiro.detalleCaso.Total_Saldo_Patronal__c =30;
controlretiro.caso.CurrencyIsoCode='HNL';
controlRetiro.detalleCaso.Prestamo_anterior__c = 'csac';
controlRetiro.VerificacionPreatamoRefinanciar();
controlRetiro.VerificacionMontoPrestamo();

controlRetiro.detallecaso.Es_Primer_Prestamo__c=true;
controlRetiro.detallecaso.No_es_primer_prestamo__c=true;
controlRetiro.VerificacionCheckPrestamos();
controlRetiro.detallecaso.Es_Refinanciamiento__c=true;
controlRetiro.VerificacionCheckPrestamos();
controlRetiro.detallecaso.Es_Refinanciamiento__c=false;
controlRetiro.detallecaso.No_es_primer_prestamo__c=true;
controlRetiro.VerificacionCheckPrestamos();
controlRetiro.detallecaso.No_es_primer_prestamo__c=false;
controlRetiro.detallecaso.Es_Primer_Prestamo__c=true;
controlRetiro.detalleCaso.Monto_Pignorado__c =12;
controlRetiro.VerificacionCheckPrestamos();

controlRetiro.guardar();
controlRetiro.cuentasCaso[0].Monto_retirar__c = 200;
controlRetiro.guardar();
controlRetiro.cuentasCaso[0].Monto_retirar__c = 50;
controlRetiro.guardar();

controlRetiro.Caso.id=null;
controlRetiro.guardar();*/
            
            //controllerEDChistoricoPDFCaso PDFCaso = new controllerEDChistoricoPDFCaso(new ApexPages.StandardController(casos[5]));
            
            
            
            cuentaIndiColec.fecha_apertura__c = date.today() - 950;
            update cuentaIndiColec;
            extensionCasoDetalle controlRetiro2 = new extensionCasoDetalle(new ApexPages.StandardController(casos[5]));
            //controlRetiro2.selecCuentaRetiros();
            controlRetiro2.detalleCaso.Tipo_retiro__c = '52';
            //controlRetiro2.selecTipoRetiro();
            controlRetiro2.guardar();
            // controlRetiro2.actualizarSaldoPatronalCons();
            controlRetiro2.detalleCaso.Fecha_Despido_Empresa__c = date.today();
            controlRetiro2.detalleCaso.Fecha_Ingreso_Empresa__c = date.today().AddMonths(-21);
            //controlRetiro2.calculoSaldoPatronales();
            controlRetiro2.detalleCaso.Prestamo_anterior__c = '12321';
            controlRetiro2.VerificacionPreatamoRefinanciar();
            // controlRetiro2.updateCasoRetiros();
            
            controlRetiro2.detallecaso.No_es_primer_prestamo__c=true;
            controlRetiro2.detallecaso.Es_Refinanciamiento__c=true;
            controlRetiro2.VerificacionCheckPrestamos();
            
            controlRetiro2.detallecaso.Es_Primer_Prestamo__c=true;
            controlRetiro2.detallecaso.Monto_Pignorado__c=200;
            controlRetiro2.VerificacionCheckPrestamos();
            
            controlRetiro2.traerSaldos2();
            controlRetiro2.detallecaso.N_Cuenta_Bancaria__c = '21';
            controlRetiro2.verPropietarioCuenta();
            
            //  controlRetiro2.calculoSaldoPatronales2();
            
            Pago_Beneficiario__c p = new Pago_Beneficiario__c(Caso__c = controlRetiro2.Caso.id);
            insert p;
            // controlRetiro2.verBeneficiarios2();
            //controlRetiro2.upsertPagosBeneficiarios();
            //controlRetiro2.upsertBeneficiarios();
            //controlRetiro2.upsertBeneficiarios();
            
            controlRetiro2.verMovimientos();
            
            extensionCasoDetalle controlADA2 = new extensionCasoDetalle(new ApexPages.StandardController(casos[4]));
            controlADA2.detalleCaso.Nuevo_monto_aporte__c = 7000;            
            controlADA2.guardar();
            //controlADA2.updateCasoRetiros();
            controlADA2.continuarAlPaso2();
            
            //ApexPages.currentPage().getParameters().put('idCliente',natural.id);
            extensionCasoDetalle controlADA = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD));
            controlADA.accionVacia();
            controlADA.accionVacia2();
            controlADA.continuarAlPaso2();
            controlADA.idTipoRCaso = mapTipoR.get('Aumento_Disminucion_Aportes');
            //controlADA.Origin = 'tiposR[1].id';
            controlADA.continuarAlPaso2();
            controlADA.formularioCliente();
            controlADA.adjuntarArchivo();
            controlADA.Caso.Origin = 'Call center';
            controlADA.esCallcenter = true;
            controlADA.detalleCaso.Nuevo_monto_aporte__c = 7000;
            controlADA.guardar();
            //controlADA.updateCasoRetiros();
            
            controlADA.detalleCaso.Subtipo_transaccion__c='C1';
            controlADA.mostrar();
            controlada.banderaSubTipoTran = false;
            controlADA.detalleCaso.Subtipo_transaccion__c='D4';
            controlADA.mostrar();
            controlADA.detalleCaso.Subtipo_transaccion__c='d3';
            controlADA.mostrar();
            controlADA.cTipoCaso = new claseTipoCaso('Aumento_Disminucion_Aportes');
            controlADA.enviarParaAprobacion();
            controlada.generarConstancia();
            //controlada.cerrarCasoStatusCerrado();
            //controlada.cerrarCaso();
            controlada.tipoEstadoDetallado();
            //controlada.prioridadTipo();
            controlada.tiposDeCasoSegunOrigen();
            controlada.AsignacarCaso();
            controlada.ImprimirCarnet();
            controlada.generarED();
            controlada.PDFCaso();
            ApexPages.currentPage().getParameters().put('flagValue', '12');
            controlada.changeFlag();
            
            controlada.Caso.constancia__c = 'P1';
            controlada.CambioConstancia();
            controlada.cerrarCaso();
            controlada.cerrarCasoStatusCerrado();
            controlada.selecMovimiento();
            controlada.prioridadTipo();
            extensionCasoDetalle.metodoutil();
            //controlada.addPagoBene();
            
            
            // extensionCasoDetalle plo = new extensionCasoDetalle();
            // controlada.extensionCasoDetalle();
            
            controlada.CambioConstancia();
            controlada.CambioAsunto();
            controlada.cambiarTipoCaso();
            controlada.cambiarTipo();
            controlada.cambioTipoSaldo();
            controlada.guardarReversiones();
            controlada.No();
            controlada.Si();
            controlada.movimientoSeleccionado = new Movimiento_Seleccionado__c (Monto__c =12);
            //controlada.movimientoSeleccionado.;
            controlada.cambioMontoC1();
            controlada.cambioMonto();
            //controlada.actualizardetalleCaso();
            //controlada.actualizarSaldoPatronalCons();
            controlada.getListAgentsByZone();
            controlada.actualizarRezago();
            //controlada.montoExoneradoAlDia();
            // controlada.ModificarSaldoPrestamo();
            
            extensionCasoDetalle re= new extensionCasoDetalle();
            extensionCasoDetalle.metodoutil();
            
            /*Integer rowNum = 1;
re.delRow();
Integer rowNum2 = 1;
re.delRow2();*/
            
            test.stopTest();   
        }catch(exception ex){
            
        }
    }
    
    static testMethod void execute(){
        extensionCasoDetalle re= new extensionCasoDetalle();
        
        re.getCambioFechaOptions();
        re.setCambioFecha();
        re.getListAgentsByZone();
    }
    
    static testMethod void execute2() {
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
        
        Asset ass = new Asset(AccountId=natural2.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=natural2.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        Case casoAumentoD2 = new Case(AccountId = natural2.id, Origin = Null, Tipo_de_Operacion__c = 'A5', EntitlementId = ent.Id, Status = 'Nuevo', RecordTypeId = tiposR2[1].id);
        Insert casoAumentoD2;
        
        Detalle_caso__c nuevoSP = new Detalle_Caso__c(Caso__c = casoAumentoD2.id, rezago__C = 'N', Cuenta__c = cuentaIndi2.id, Nuevo_Subproducto__c = subproducto4.id, Nuevo_monto_aporte__c = 10000,
                                                      Fecha_nacimiento__c = date.today(), N_Cuenta_Bancaria__c = '456765678', Tipo_Operacion__c = 'A5');
        
        Insert nuevoSP;
        
        extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD2));
        
        controlConsta.guardar();
        
        controlConsta.actualizarRezago();
        
        controlConsta.montoExoneradoAlDia();
        
        controlConsta.traerSaldos();
        
        controlConsta.mostrar();
        
        controlConsta.accionVacia();
        
        controlConsta.accionVacia2();
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Aumento_Disminucion_Aportes'];
        
        controlConsta.idTipoRCaso = tiposR0[0].Id;
        
        controlConsta.continuarAlPaso2();
    }
    
    static testMethod void execute3() {
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
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Aumento_Disminucion_Aportes'];
        
        Asset ass = new Asset(AccountId=natural2.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=natural2.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        Case casoAumentoD2 = new Case(AccountId = natural2.id, Priority = '', Tipo_de_Operacion__c = 'A5', EntitlementId = ent.Id, Status = 'Nuevo', RecordTypeId = tiposR0[0].id);
        Insert casoAumentoD2;
        
        Detalle_caso__c nuevoSP = new Detalle_Caso__c(Caso__c = casoAumentoD2.id, Cuenta__c = cuentaIndi2.id, Nuevo_Subproducto__c = subproducto4.id, Nuevo_monto_aporte__c = 10000,
                                                      Fecha_nacimiento__c = date.today(), N_Cuenta_Bancaria__c = '456765678', Tipo_Operacion__c = 'A5');
        
        Insert nuevoSP;
        
        extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD2));
        
        controlConsta.guardar();
        
        controlConsta.movimientoSeleccionado = Null;
        
        controlConsta.cambioMonto();
    }
    
    static testMethod void execute4() {
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
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Aumento_Disminucion_Aportes'];
        
        Asset ass = new Asset(AccountId=natural2.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=natural2.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        Case casoAumentoD2 = new Case(AccountId = natural2.id, Priority = '', Tipo_de_Operacion__c = 'A5', EntitlementId = ent.Id, Status = 'Nuevo', RecordTypeId = tiposR0[0].id);
        
        extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD2));
    }
    
    static testMethod void execute5() {
        Producto__c producto2 = new Producto__c(Name = 'Producto1', Codigo__c = 'Pro1');
        insert producto2;
        
        Subproducto__c subproducto4 = new Subproducto__c(Name = 'SubProducto1', Codigo__c = 'SubPro1', Producto__c = producto2.id,
                                                         currencyIsoCode = 'USD');
        insert subproducto4;
        
        Subproducto__c subproducto3 = new Subproducto__c(Name = 'SubProducto2', Codigo__c = 'SubPro2', Producto__c = producto2.id,
                                                         currencyIsoCode = 'USD');
        insert subproducto3; 
        
        Account natural2 = new Account(Name = 'Juan Perez', Identificacion__c = '1234567890123', /*PersonEmail = 'as@csd.com',*/
                                       RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Juridico'].id);
        insert natural2;
        
        Date hoy2 = date.today();
        
        Cuentas__c cuentaIndi3 = new Cuentas__c(Name = 'Cuenta2', Codigo__c = '12344', Cliente__c = natural2.id, Producto__c = producto2.id,
                                                Fecha_Apertura__c = date.today().addyears(-1),
                                                Subproducto__c = subproducto3.id, currencyIsoCode = 'USD', 
                                                Monto_aporte__c = 5000, Forma_Aportacion__c = 'AH');
        insert cuentaIndi3;
        
        Beneficiario__c bene3 = new Beneficiario__c(Cliente__c = natural2.id, Cuenta__c = cuentaIndi3.id, Primer_Apellido__c = 'system',
                                                    Id_Externo__c = 0801, Fecha_nacimiento__c = date.today());
        insert bene3;
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Reversiones'];
        
        Asset ass = new Asset(AccountId=natural2.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=natural2.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        Case casoAumentoD2 = new Case(AccountId = natural2.id, Priority = '', CurrencyIsoCode = 'USD', Tipo_de_Operacion__c = 'A5', EntitlementId = ent.Id, Status = 'Nuevo', RecordTypeId = tiposR0[0].id);
        Insert casoAumentoD2;
        
        Detalle_caso__c nuevoSP = new Detalle_Caso__c(Caso__c = casoAumentoD2.id, Tipo_transaccion__c = 'Crédito', Subtipo_transaccion__c = 'C10', Cuenta__c = cuentaIndi3.id, Nuevo_Subproducto__c = subproducto3.id, Nuevo_monto_aporte__c = 10000,
                                                      Fecha_nacimiento__c = date.today(), N_Cuenta_Bancaria__c = '456765678', Tipo_Operacion__c = 'A5');
        
        Insert nuevoSP;
        
        Movimiento_Seleccionado__c mov = new Movimiento_Seleccionado__c(Name = 'Test', Comision_por_aporte__c = 5.00, Comision_por_saldo__c = 5.00, Detalle_caso__c = nuevoSP.Id, Fecha__c = System.today(), Monto__c = 3000, Saldo_Inicial__c = 100, Tipo_Saldo__c = '12', Valor_Cuota__c = 300);
        Insert mov;
        
        extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD2));
        
        controlConsta.guardar();
        
        controlConsta.DAU_Cambio_de_Fecha = String.valueOf(12);
        
        controlConsta.setCambioFecha();
        
        Agencia__c agn = new Agencia__c(Name = 'Test', Zona__c = '1');
        Insert agn;
        
        controlConsta.ZonaSeleccionada = '1';
        
        controlConsta.getListAgentsByZone();
        
        controlConsta.validacionSaldosP1(); 
    }
    
    static testMethod void execute6() {
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
        
        Beneficiario__c bene3 = new Beneficiario__c(Cliente__c = natural2.id, Primer_Apellido__c = 'system',
                                                    Id_Externo__c = 0801, Fecha_nacimiento__c = date.today());
        insert bene3;
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Aumento_Disminucion_Aportes'];
        
        Asset ass = new Asset(AccountId=natural2.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=natural2.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        Case casoAumentoD2 = new Case(AccountId = natural2.id, Priority = '', Tipo_de_Operacion__c = 'A5', EntitlementId = ent.Id, Status = 'Nuevo', RecordTypeId = tiposR0[0].id);
        Insert casoAumentoD2;
        
        Detalle_caso__c nuevoSP = new Detalle_Caso__c(Caso__c = casoAumentoD2.id, Tipo_transaccion__c = 'Crédito', Subtipo_transaccion__c = 'C10', Nuevo_Subproducto__c = subproducto4.id, Nuevo_monto_aporte__c = 10000,
                                                      Fecha_nacimiento__c = date.today(), N_Cuenta_Bancaria__c = '456765678', Tipo_Operacion__c = 'A5');
        
        Insert nuevoSP;
        
        Movimiento_Seleccionado__c mov = new Movimiento_Seleccionado__c(Name = 'Test', Comision_por_aporte__c = 5.00, Comision_por_saldo__c = 5.00, Detalle_caso__c = nuevoSP.Id, Fecha__c = System.today(), Monto__c = 3000, Saldo_Inicial__c = 100, Tipo_Saldo__c = '12', Valor_Cuota__c = 300);
        Insert mov;
        
        extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD2));
        
        controlConsta.guardar();       
    }
    
    static testMethod void execute7() {
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
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Reversiones'];
        
        Asset ass = new Asset(AccountId=natural2.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=natural2.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        Case casoAumentoD2 = new Case(AccountId = natural2.id, Priority = '', Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'Test', Apellido_Usuario_Firmador__c = 'Test', CurrencyIsoCode = 'HNL', Tipo_de_Operacion__c = 'A5', EntitlementId = ent.Id, Status = 'Nuevo', RecordTypeId = tiposR0[0].id);
        Insert casoAumentoD2;
        
        Detalle_caso__c nuevoSP = new Detalle_Caso__c(Caso__c = casoAumentoD2.id, Tipo_transaccion__c = 'Crédito', Subtipo_transaccion__c = 'C10', Cuenta__c = cuentaIndi2.id, Nuevo_Subproducto__c = subproducto4.id, Nuevo_monto_aporte__c = 10000,
                                                      Fecha_nacimiento__c = date.today(), N_Cuenta_Bancaria__c = '456765678', Tipo_Operacion__c = 'A5');
        
        Insert nuevoSP;
        
        Movimiento_Seleccionado__c mov = new Movimiento_Seleccionado__c(Name = 'Test', Comision_por_aporte__c = 5.00, Comision_por_saldo__c = 5.00, Detalle_caso__c = nuevoSP.Id, Fecha__c = System.today(), Monto__c = 3000, Saldo_Inicial__c = 100, Tipo_Saldo__c = '12', Valor_Cuota__c = 300);
        Insert mov;
        
        extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD2));
        
        controlConsta.guardar();
        
        controlConsta.DAU_Cambio_de_Fecha = String.valueOf(12);
        
        controlConsta.setCambioFecha();
        
        Agencia__c agn = new Agencia__c(Name = 'Test', Zona__c = '1');
        Insert agn;
        
        controlConsta.ZonaSeleccionada = '1';
        
        controlConsta.getListAgentsByZone();
        
        controlConsta.validacionSaldosP1();
        
        controlConsta.cambioMontoC1();
        
        controlConsta.cambioTipoSaldo();
        
        controlConsta.guardarReversiones();
        
        controlConsta.No();
        
        controlConsta.Si();
    }
    
    static testMethod void execute8() {
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
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Constancia'];
        
        Asset ass = new Asset(AccountId=natural2.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=natural2.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        Case casoAumentoD2 = new Case(AccountId = natural2.id, Priority = '', Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'Test', Apellido_Usuario_Firmador__c = 'Test', CurrencyIsoCode = 'HNL', Tipo_de_Operacion__c = 'A5', EntitlementId = ent.Id, Status = 'Nuevo', RecordTypeId = tiposR0[0].id);
        Insert casoAumentoD2;
        
        Detalle_caso__c nuevoSP = new Detalle_Caso__c(Caso__c = casoAumentoD2.id, Tipo_transaccion__c = 'Crédito', Subtipo_transaccion__c = 'C10', Cuenta__c = cuentaIndi2.id, Nuevo_Subproducto__c = subproducto4.id, Nuevo_monto_aporte__c = 10000,
                                                      Fecha_nacimiento__c = date.today(), N_Cuenta_Bancaria__c = '456765678', Tipo_Operacion__c = 'A5');
        
        Insert nuevoSP;
        
        Movimiento_Seleccionado__c mov = new Movimiento_Seleccionado__c(Name = 'Test', Comision_por_aporte__c = 5.00, Comision_por_saldo__c = 5.00, Detalle_caso__c = nuevoSP.Id, Fecha__c = System.today(), Monto__c = 3000, Saldo_Inicial__c = 100, Tipo_Saldo__c = '12', Valor_Cuota__c = 300);
        Insert mov;
        
        extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD2));
        
        controlConsta.guardar();
    }
    
    static testMethod void execute9() {
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
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Reposicion_Carnet'];
        
        Asset ass = new Asset(AccountId=natural2.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=natural2.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        Case casoAumentoD2 = new Case(AccountId = natural2.id, Priority = '', Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'Test', Apellido_Usuario_Firmador__c = 'Test', CurrencyIsoCode = 'HNL', Tipo_de_Operacion__c = 'A5', EntitlementId = ent.Id, Status = 'Nuevo', RecordTypeId = tiposR0[0].id);
        Insert casoAumentoD2;
        
        Detalle_caso__c nuevoSP = new Detalle_Caso__c(Caso__c = casoAumentoD2.id, Tipo_transaccion__c = 'Crédito', Subtipo_transaccion__c = 'C10', Cuenta__c = cuentaIndi2.id, Nuevo_Subproducto__c = subproducto4.id, Nuevo_monto_aporte__c = 10000,
                                                      Fecha_nacimiento__c = date.today(), N_Cuenta_Bancaria__c = '456765678', Tipo_Operacion__c = 'A5');
        
        Insert nuevoSP;
        
        Movimiento_Seleccionado__c mov = new Movimiento_Seleccionado__c(Name = 'Test', Comision_por_aporte__c = 5.00, Comision_por_saldo__c = 5.00, Detalle_caso__c = nuevoSP.Id, Fecha__c = System.today(), Monto__c = 3000, Saldo_Inicial__c = 100, Tipo_Saldo__c = '12', Valor_Cuota__c = 300);
        Insert mov;
        
        extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD2));
        
        controlConsta.guardar();
    }
    
    static testMethod void execute10() {
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
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Aumento_Disminucion_Aportes'];
        
        Asset ass = new Asset(AccountId=natural2.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=natural2.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        Case casoAumentoD2 = new Case(AccountId = natural2.id, Priority = '', Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'Test', Apellido_Usuario_Firmador__c = 'Test', CurrencyIsoCode = 'HNL', Tipo_de_Operacion__c = 'A3', EntitlementId = ent.Id, Status = 'Nuevo', RecordTypeId = tiposR0[0].id);
        Insert casoAumentoD2;
        
        Detalle_caso__c nuevoSP = new Detalle_Caso__c(Caso__c = casoAumentoD2.id, Tipo_transaccion__c = 'Crédito', Subtipo_transaccion__c = 'C10', Cuenta__c = cuentaIndi2.id, Nuevo_Subproducto__c = subproducto4.id, Nuevo_monto_aporte__c = 10000,
                                                      Fecha_nacimiento__c = date.today(), N_Cuenta_Bancaria__c = '456765678', Nuevo_canal_aporte__c = 'TA', Tipo_Operacion__c = 'A3');
        
        Insert nuevoSP;
        
        MultiStaticResourceCalloutMock mock = new MultiStaticResourceCalloutMock();
        mock.setStaticResource('http://190.5.68.11:9090/api/gestionesBanco','mockCuentas');
        mock.setStatusCode(200); 
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        updateCase.validarIdentidad(casoAumentoD2.Id, '456789067', '867656790');
        
        extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD2));
        
        controlConsta.guardar();
    }
    
    static testMethod void execute11() {
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
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Aumento_Disminucion_Aportes'];
        
        Asset ass = new Asset(AccountId=natural2.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=natural2.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        Case casoAumentoD2 = new Case(AccountId = natural2.id, Priority = '', Origin = 'Agencias_Banco', DAU_No_Cuenta__c = Null, Nombre_Usuario_Firmador__c = 'Test', Apellido_Usuario_Firmador__c = 'Test', CurrencyIsoCode = 'HNL', Tipo_de_Operacion__c = 'A4', EntitlementId = ent.Id, Status = 'Nuevo', RecordTypeId = tiposR0[0].id);
        Insert casoAumentoD2;
        
        Detalle_caso__c nuevoSP = new Detalle_Caso__c(Caso__c = casoAumentoD2.id, Tipo_transaccion__c = 'Crédito', Subtipo_transaccion__c = 'C10', Cuenta__c = cuentaIndi2.id, Nuevo_Subproducto__c = subproducto4.id, Nuevo_monto_aporte__c = 10000,
                                                      Fecha_nacimiento__c = date.today(), N_Cuenta_Bancaria__c = '456765678', Banco__c = '28', Tipo_Operacion__c = 'A4', Nueva_fecha_aporte__c = System.today());
        
        Insert nuevoSP;
        
        MultiStaticResourceCalloutMock mock = new MultiStaticResourceCalloutMock();
        mock.setStaticResource('http://190.5.68.11:9090/api/gestionesBanco','mockCuentas');
        mock.setStatusCode(200); 
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        updateCase.validarIdentidad(casoAumentoD2.Id, '456789067', '867656790');
        
        extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD2));
        
        controlConsta.guardar();
    }
    
    static testMethod void execute12() {
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
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Aumento_Disminucion_Aportes'];
        
        Asset ass = new Asset(AccountId=natural2.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=natural2.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        Case casoAumentoD2 = new Case(AccountId = natural2.id, Priority = '', Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'Test', Apellido_Usuario_Firmador__c = 'Test', CurrencyIsoCode = 'HNL', Tipo_de_Operacion__c = 'A6', EntitlementId = ent.Id, Status = 'Nuevo', RecordTypeId = tiposR0[0].id);
        Insert casoAumentoD2;
        
        Detalle_caso__c nuevoSP = new Detalle_Caso__c(Caso__c = casoAumentoD2.id, Tipo_transaccion__c = 'Crédito', Subtipo_transaccion__c = 'C10', Cuenta__c = cuentaIndi2.id, Nuevo_Subproducto__c = subproducto4.id, Nuevo_monto_aporte__c = 10000,
                                                      Fecha_nacimiento__c = date.today(), N_Cuenta_Bancaria__c = '456765678', Banco__c = '28', Tipo_Operacion__c = 'A6', Nueva_fecha_aporte__c = System.today());
        
        Insert nuevoSP;
        
        MultiStaticResourceCalloutMock mock = new MultiStaticResourceCalloutMock();
        mock.setStaticResource('http://190.5.68.11:9090/api/gestionesBanco','mockCuentas');
        mock.setStatusCode(200); 
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        updateCase.validarIdentidad(casoAumentoD2.Id, '456789067', '867656790');
        
        extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD2));
        
        controlConsta.guardar();
    }
    
    static testMethod void execute13() {
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
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Aumento_Disminucion_Aportes'];
        
        Asset ass = new Asset(AccountId=natural2.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=natural2.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        Case casoAumentoD2 = new Case(AccountId = natural2.id, Priority = '', Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'Test', Apellido_Usuario_Firmador__c = 'Test', CurrencyIsoCode = 'HNL', Tipo_de_Operacion__c = 'A6', EntitlementId = ent.Id, Status = 'Nuevo', RecordTypeId = tiposR0[0].id);
        Insert casoAumentoD2;
        
        Detalle_caso__c nuevoSP = new Detalle_Caso__c(Caso__c = casoAumentoD2.id, Tipo_transaccion__c = 'Crédito', Subtipo_transaccion__c = 'C10', Cuenta__c = cuentaIndi2.id, Nuevo_Subproducto__c = subproducto4.id, Nuevo_monto_aporte__c = 10000,
                                                      Fecha_nacimiento__c = date.today(), N_Cuenta_Bancaria__c = '456765678', Banco__c = '28', Tipo_Operacion__c = 'A7', Nueva_fecha_aporte__c = System.today());
        
        Insert nuevoSP;
        
        MultiStaticResourceCalloutMock mock = new MultiStaticResourceCalloutMock();
        mock.setStaticResource('http://190.5.68.11:9090/api/gestionesBanco','mockCuentas');
        mock.setStatusCode(200); 
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        updateCase.validarIdentidad(casoAumentoD2.Id, '456789067', '867656790');
        
        extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD2));
        
        controlConsta.guardar();
    }
    
    //TAOB
    static testMethod void execute14() {
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
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Aumento_Disminucion_Aportes'];
        
        Asset ass = new Asset(AccountId=natural2.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=natural2.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        Case casoAumentoD2 = new Case(AccountId = natural2.id, Priority = '', Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'Test', Apellido_Usuario_Firmador__c = 'Test', CurrencyIsoCode = 'HNL', Tipo_de_Operacion__c = 'A6', EntitlementId = ent.Id, Status = 'Nuevo', RecordTypeId = tiposR0[0].id);
        Insert casoAumentoD2;
        
        Detalle_caso__c nuevoSP = new Detalle_Caso__c(Caso__c = casoAumentoD2.id, Tipo_transaccion__c = 'Crédito', Subtipo_transaccion__c = 'C10', Cuenta__c = cuentaIndi2.id, Nuevo_Subproducto__c = subproducto4.id, Nuevo_monto_aporte__c = 10000,
                                                      Fecha_nacimiento__c = date.today(), N_Cuenta_Bancaria__c = '456765678', Banco__c = 'Otros Bancos', Tipo_Operacion__c = 'A6', Nueva_fecha_aporte__c = System.today());
        
        Insert nuevoSP;
        
        extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD2));
        
        controlConsta.guardar();
    }
    
    static testMethod void execute15() {
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
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Aumento_Disminucion_Aportes'];
        
        Asset ass = new Asset(AccountId=natural2.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=natural2.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        Case casoAumentoD2 = new Case(AccountId = natural2.id, Priority = '', Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'Test', Apellido_Usuario_Firmador__c = 'Test', CurrencyIsoCode = 'HNL', Tipo_de_Operacion__c = 'A3', EntitlementId = ent.Id, Status = 'Nuevo', RecordTypeId = tiposR0[0].id);
        Insert casoAumentoD2;
        
        Detalle_caso__c nuevoSP = new Detalle_Caso__c(Caso__c = casoAumentoD2.id, Tipo_transaccion__c = 'Crédito', Subtipo_transaccion__c = 'C10', Cuenta__c = cuentaIndi2.id, Nuevo_Subproducto__c = subproducto4.id, Nuevo_monto_aporte__c = 10000,
                                                      Fecha_nacimiento__c = date.today(), N_Cuenta_Bancaria__c = '456765678', Nuevo_canal_aporte__c = 'AH', Tipo_Operacion__c = 'A3');
        
        Insert nuevoSP;
        
        MultiStaticResourceCalloutMock mock = new MultiStaticResourceCalloutMock();
        mock.setStaticResource('http://190.5.68.11:9090/api/gestionesBanco','mockCuentas');
        mock.setStatusCode(200); 
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        
        updateCase.validarIdentidad(casoAumentoD2.Id, '456789067', '867656790');
        
        extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD2));
        
        controlConsta.guardar();
    }
    
    static testMethod void execute16() {
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
        Cuentas__c cuentaIndi2 = new Cuentas__c(Name = 'Cuenta', Codigo__c = '12345', Cliente__c = natural2.id, Producto__c = producto2.id,
                                                Fecha_Apertura__c = date.today().addyears(-1),
                                                Subproducto__c = subproducto3.id, currencyIsoCode = 'HNL', /*Fecha_Apertura__c = hoy2,*/
                                                Monto_aporte__c = 5000, Forma_Aportacion__c = 'AH');
        
        cuentaIndi2 = new Cuentas__c(Name = 'Cuenta', Codigo__c = '1234', Cliente__c = natural2.id, Producto__c = producto2.id,
                                     Fecha_Apertura__c = date.today().addyears(-1),
                                     Subproducto__c = subproducto3.id, currencyIsoCode = 'HNL', /*Fecha_Apertura__c = hoy2,*/
                                     Monto_aporte__c = 5000, Forma_Aportacion__c = 'AH');
        insert cuentaIndi2;
        cuentaIndi2.Codigo__c = '123';
        cuentaIndi2.id = null;
        cuentaIndi2.Fecha_Apertura__c = hoy2;
        insert cuentaIndi2;
        
        Beneficiario__c bene3 = new Beneficiario__c(Cliente__c = natural2.id, Cuenta__c = cuentaIndi2.id, Primer_Apellido__c = 'system',TipoBeneficiario__c ='Directo',
                                                    Id_Externo__c = 0801, Fecha_nacimiento__c = date.today());
        insert bene3;
        
        bene3 = new Beneficiario__c(Cliente__c = natural2.id, Cuenta__c = cuentaIndi2.id, Primer_Apellido__c = 'system', TipoBeneficiario__c ='Contingencia',
                                    Id_Externo__c = 08011, Fecha_nacimiento__c = date.today());
        
        insert bene3;
        
        list<RecordType> tiposR0 = [Select Name From RecordType Where sObjectType = 'Case' and DeveloperName = 'Actualizacion_informacion'];
        
        Asset ass = new Asset(AccountId=natural2.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=natural2.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        Case casoAumentoD2 = new Case(AccountId = natural2.id, Subject = '', FPC_Asunto__c = 'Actualización Información', Nombre_Cliente__c = 'Test', Priority = 'Media', Origin = 'Agencias FPC', Nombre_Usuario_Firmador__c = 'Test', Apellido_Usuario_Firmador__c = 'Test', CurrencyIsoCode = 'HNL', Tipo_de_Operacion__c = 'A4', EntitlementId = ent.Id, Status = 'Nuevo', RecordTypeId = tiposR0[0].id);
        Insert casoAumentoD2;
        
        Detalle_caso__c nuevoSP = new Detalle_Caso__c(Caso__c = casoAumentoD2.id, Tipo_transaccion__c = 'Crédito', Subtipo_transaccion__c = 'C10', Cuenta__c = cuentaIndi2.id, Nuevo_Subproducto__c = subproducto4.id, Nuevo_monto_aporte__c = 10000,
                                                      Fecha_nacimiento__c = date.today(), N_Cuenta_Bancaria__c = '456765678', Banco__c = '28', Tipo_Operacion__c = 'A4');
        
        Insert nuevoSP;
        
        extensionCasoDetalle controlConsta = new extensionCasoDetalle(new ApexPages.StandardController(casoAumentoD2));
        
        controlConsta.getBeneficiario();
        controlConsta.desbloquearBeneficiario();
        controlConsta.agregarBeneficiario();
        controlConsta.agregarBeneficiarioCont();
        
        
        
        
        controlConsta.validacionCamposBeneficiario(controlConsta.beneficiario.listBeneficiariosDirec);
        for(Integer i =0; i<controlConsta.beneficiario.listBeneficiariosDirec.size(); i++){
            
            controlConsta.beneficiario.listBeneficiariosDirec[i].tipoBeneficiario = 'Directo';
            controlConsta.beneficiario.listBeneficiariosDirec[i].primerApellido = 'PN';
            controlConsta.beneficiario.listBeneficiariosDirec[i].cuentaId = controlConsta.beneficiario.cuentaSelecionada;
            controlConsta.beneficiario.listBeneficiariosDirec[i].tipoIdentificacion = '1';
            controlConsta.beneficiario.listBeneficiariosDirec[i].primerNombre = '1';
            controlConsta.beneficiario.listBeneficiariosDirec[i].identificacion = '1';
            controlConsta.beneficiario.listBeneficiariosDirec[i].sexo = 'Masculino';
            controlConsta.beneficiario.listBeneficiariosDirec[i].parentesco = '1';
            controlConsta.beneficiario.listBeneficiariosDirec[i].porcentaje = 90;
            controlConsta.beneficiario.listBeneficiariosDirec[i].fechaNacimiento = Date.today().AddDays(100);
        }
        controlConsta.validacionCamposBeneficiario(controlConsta.beneficiario.listBeneficiariosDirec);
        
        for(Integer i =0; i<controlConsta.beneficiario.listBeneficiariosDirec.size(); i++){
            controlConsta.beneficiario.listBeneficiariosDirec[i].fechaNacimiento = Date.today().AddDays(-100);
        }
        controlConsta.validacionCamposBeneficiario(controlConsta.beneficiario.listBeneficiariosDirec);
        controlConsta.beneficiario.beneficiarioSelec = controlConsta.beneficiario.listBeneficiariosCont[controlConsta.beneficiario.listBeneficiariosCont.size() -1].index;
        controlConsta.eliminarBeneficiarioCont();
        
        controlConsta.validacionCamposBeneficiario(controlConsta.beneficiario.listBeneficiariosDirec);
        for(Integer i =0; i<controlConsta.beneficiario.listBeneficiariosDirec.size(); i++){
            controlConsta.beneficiario.listBeneficiariosDirec[i].porcentaje = 50;
        }
        controlConsta.validacionCamposBeneficiario(controlConsta.beneficiario.listBeneficiariosDirec);
        controlConsta.getGrado();
        controlConsta.validacionBeneficiario(controlConsta.beneficiario.listBeneficiariosDirec, controlConsta.beneficiario.listBeneficiariosDirec);
        
        
        
        
        controlConsta.beneficiario.beneficiarioSelec = controlConsta.beneficiario.listBeneficiariosDirec[controlConsta.beneficiario.listBeneficiariosDirec.size() -1].index;
        controlConsta.eliminarBeneficiario();
        
        controlConsta.beneficiario.beneficiarioSelec = controlConsta.beneficiario.listBeneficiariosCont[controlConsta.beneficiario.listBeneficiariosCont.size() -1].index;
        controlConsta.eliminarBeneficiarioCont();
        
        controlConsta.cambiarCuenta();
        
        
        controlConsta.guardar();
        
        controlConsta.AsignacarCaso();
        
        controlConsta.formularioCliente();
        
        controlConsta.adjuntarArchivo();
        
        controlConsta.ImprimirCarnet();
        
        controlConsta.PDFCaso();
        
        controlConsta.generarED();
        
        controlConsta.generarConstancia();
        
        //controlConsta.changeFlag();
        
        controlConsta.CambioConstancia();
        
        //controlConsta.CambioAsunto();
        
        controlConsta.cerrarCaso();
        
        controlConsta.cerrarCasoStatusCerrado();
        
        controlConsta.enviarParaAprobacion();
        
        controlConsta.tiposDeCasoSegunOrigen();
        
        controlConsta.cambiarTipoCaso();
        
        controlConsta.cambiarTipo();
        
        controlConsta.prioridadTipo();
        
        controlConsta.tipoEstadoDetallado();
    }    
    
    /*static testMethod void llamadasREST(){ 
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
        
        Usuarios_para_asignacion_Casos_SAC__c f = new Usuarios_para_asignacion_Casos_SAC__c();
        //f.Zona__c='2';
        f.Usuario__c = userinfo.getUserId();
        insert f;
        
        f = new Usuarios_para_asignacion_Casos_SAC__c();
        f.Zona__c='2';
        f.Usuario__c = userinfo.getUserId();
        insert f;
        
        
        FechaDC_Sysde__c fdcSysde = new FechaDC_Sysde__c(Name = 'CierreAlDia', Fecha_cierre__c  = date.today());
        insert fdcSysde;
        
        Producto__c producto = new Producto__c(Name = 'Producto1', Codigo__c = 'Pro1');
        insert producto;
        
        Subproducto__c subproducto = new Subproducto__c(Name = 'SubProducto1', Codigo__c = 'SubPro1', Producto__c = producto.id);
        insert subproducto;
        
        Subproducto__c subproducto2 = new Subproducto__c(Name = 'SubProducto2', Codigo__c = 'SubPro2', Producto__c = producto.id);
        insert subproducto2;
        list<Subproducto__c> listSubrProducto = new list<Subproducto__c>();
        Account natural = new Account(FirstName = 'Juan', LastName = 'Perez', Identificacion__c = '12345', PersonBirthdate = date.valueOf('1990-10-11'),
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
        
        map<String, String> mapTipoR = new map<String, String>();
        for(RecordType item: [Select Name, DeveloperName, id From RecordType Where sObjectType = 'Case' and name !='Retiros20' Order by DeveloperName ]){
            mapTipoR.put(item.DeveloperName, item.id);
        }
        
        Asset ass = new Asset(AccountId=juridico.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=juridico.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        list<Case> casos = new list<Case>();
        
        Case casoActualizacion = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Actualizacion_informacion'));
        casos.add(casoActualizacion);
        
        Case casoSubproducto = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Cambio_Subproducto'));
        casos.add(casoSubproducto);
        
        Case casoConstancia = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Constancia'));
        casos.add(casoConstancia);
        
        Case casoRetiros = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Retiros'));
        casos.add(casoRetiros);
        
        Case casoAumentoD2 = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Aumento_Disminucion_Aportes'));
        casos.add(casoAumentoD2);
        
        Case casoRetiros2 = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Retiros'));
        casos.add(casoRetiros2);
        
        Case casoReversiones = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Reversiones'));
        casos.add(casoReversiones);
        
        insert Casos;
        
        Case casoAumentoD = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Aumento_Disminucion_Aportes'));
        
        list<Detalle_caso__c> detalleCasos = new list<Detalle_caso__c>();
        Detalle_caso__c detalle = new Detalle_Caso__c(Caso__c = Casos[0].id, Cuenta__c = cuentaIndi.id);
        detalleCasos.add(detalle);
        
        Detalle_caso__c detalle1 = new Detalle_Caso__c(Caso__c = Casos[3].id, Cuenta__c = cuentaIndi.id,Cabeza_retiro__c = true, Monto_Saldo_Patronal__c = 100,
                                                       Forma_Retiro__c = 'CK', Porcentaje_Saldo_Patronal__c=12,Porcentaje_CRA_Individual__c=12);
        detalleCasos.add(detalle1);
        
        Detalle_caso__c detalle2 = new Detalle_Caso__c(Caso__c = Casos[3].id, Cuenta__c = cuentaIndi.id, Monto_Saldo_Patronal__c = 100,
                                                       Saldo_retirar__c = '12', Monto_Saldo__c = 100, Monto_retirar__c = 50);
        detalleCasos.add(detalle2);
        
        insert detalleCasos;
        
        test.startTest();
        extensionCasoDetalle controlActinfo = new extensionCasoDetalle(new ApexPages.StandardController(Casos[0]));
        controlActinfo.selecCuenta();
        controlActinfo.llenarCuentasDesdeSysde();
        // controlActinfo.verBeneficiarios2();
        if(controlActinfo.listBeneficiarios.size()>0){
            controlActinfo.listBeneficiarios[0].Casilla__c = true;
        }
        controlActinfo.agregarBeneficiarios();
        // controlActinfo.upsertBeneficiarios();
        // controlActinfo.verPagosBeneficiarios2();
        //controlActinfo.upsertPagosBeneficiarios();
        //controlActinfo.addPagoBene();         
        
        extensionCasoDetalle controlRetiro = new extensionCasoDetalle(new ApexPages.StandardController(casos[3]));
        controlRetiro.verPropietarioCuenta();            
        controlRetiro.detalleCaso.Cliente_quiere_capital_semilla__c = false;
        controlRetiro.detalleCaso.Tipo_retiro__c = '52';
        // controlRetiro.selecTipoRetiro();
        controlRetiro.detalleCaso.Cliente_quiere_capital_semilla__c = true;
        // controlRetiro.selecTipoRetiro();
        controlRetiro.verMovimientos();
        controlRetiro.selecMovimiento(); 
        //controlRetiro.detalleCaso.Fecha_Despido_Empresa__c=date.today();
        //  controlRetiro.detalleCaso.Fecha_Ingreso_Empresa__c=date.today().addyears(-1);
        // controlRetiro.calculoSaldoPatronales();
        //controlRetiro.calculoSaldoPatronales2();
        controlRetiro.detalleCaso.Fecha_Despido_Empresa__c=date.today();
        controlRetiro.detalleCaso.Fecha_Ingreso_Empresa__c=date.today().addyears(-1);
        //controlRetiro.calculoSaldoPatronales(); 
        //controlRetiro.calculoSaldoPatronales2();
        controlRetiro.cuentasCaso.add(new Detalle_Caso__c(Cuenta__c = natural.id, Caso__c = casos[3].id, Saldo_retirar__c = '12',Tipo_retiro__c = '51',
                                                          Monto_Saldo__c = 100, Monto_retirar__c = -2, CurrencyIsoCode='HNL')); 
        
        //controlRetiro.ValidacionSaldoPatronales();
        controlretiro.caso.Aplica_Saldo_patronal__c=true;
        controlRetiro.detalleCaso.Total_Saldo_Personal__c =30;
        controlRetiro.detalleCaso.Total_Saldo_Patronal__c =30;
        controlretiro.caso.CurrencyIsoCode='HNL';
        controlRetiro.detalleCaso.Prestamo_anterior__c = 'csac';
        controlRetiro.VerificacionPreatamoRefinanciar();
        controlRetiro.VerificacionMontoPrestamo();
        
        controlRetiro.detallecaso.Es_Primer_Prestamo__c=true;
        controlRetiro.detallecaso.No_es_primer_prestamo__c=true;
        controlRetiro.VerificacionCheckPrestamos();
        controlRetiro.detallecaso.Es_Refinanciamiento__c=true;
        controlRetiro.VerificacionCheckPrestamos();
        controlRetiro.detallecaso.Es_Refinanciamiento__c=false;
        controlRetiro.detallecaso.No_es_primer_prestamo__c=true;
        controlRetiro.VerificacionCheckPrestamos();
        controlRetiro.detallecaso.No_es_primer_prestamo__c=false;
        controlRetiro.detallecaso.Es_Primer_Prestamo__c=true;
        controlRetiro.detalleCaso.Monto_Pignorado__c =12;
        controlRetiro.VerificacionCheckPrestamos();
        
        controlRetiro.guardar();
        controlRetiro.cuentasCaso[0].Monto_retirar__c = 200;
        controlRetiro.guardar();
        controlRetiro.cuentasCaso[0].Monto_retirar__c = 50;
        controlRetiro.guardar();
        
        controlRetiro.Caso.id=null;
        controlRetiro.guardar();
        
        //controllerEDChistoricoPDFCaso PDFCaso = new controllerEDChistoricoPDFCaso(new ApexPages.StandardController(casos[5]));
        
        cuentaIndiColec.fecha_apertura__c = date.today() - 950;
        update cuentaIndiColec;
        extensionCasoDetalle controlRetiro2 = new extensionCasoDetalle(new ApexPages.StandardController(casos[5]));
        // controlRetiro2.selecCuentaRetiros();
        controlRetiro2.detalleCaso.Tipo_retiro__c = '52';
        //controlRetiro2.selecTipoRetiro();
        controlRetiro2.guardar();
        
        extensionCasoDetalle controlADA2 = new extensionCasoDetalle(new ApexPages.StandardController(casos[4]));
        controlADA2.detalleCaso.Nuevo_monto_aporte__c = 7000; 
        controlADA2.guardar();
        
        //controlADA2.idTipoRCaso = mapTipoR.get('tiposR[4].id');
        //controlADA2.continuarAlPaso2();
        
        extensionCasoDetalle re= new extensionCasoDetalle();
        extensionCasoDetalle.metodoutil();
        test.stopTest();   
        
    }*/
    
     static testMethod void llamadasREST1(){ 
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
        
        Usuarios_para_asignacion_Casos_SAC__c f = new Usuarios_para_asignacion_Casos_SAC__c();
        //f.Zona__c='2';
        f.Usuario__c = userinfo.getUserId();
        insert f;
        
        f = new Usuarios_para_asignacion_Casos_SAC__c();
        f.Zona__c='2';
        f.Usuario__c = userinfo.getUserId();
        insert f;
        
        
        FechaDC_Sysde__c fdcSysde = new FechaDC_Sysde__c(Name = 'CierreAlDia', Fecha_cierre__c  = date.today());
        insert fdcSysde;
        
        Producto__c producto = new Producto__c(Name = 'Producto1', Codigo__c = 'Pro1');
        insert producto;
        
        Subproducto__c subproducto = new Subproducto__c(Name = 'SubProducto1', Codigo__c = 'SubPro1', Producto__c = producto.id);
        insert subproducto;
        
        Subproducto__c subproducto2 = new Subproducto__c(Name = 'SubProducto2', Codigo__c = 'SubPro2', Producto__c = producto.id);
        insert subproducto2;
        list<Subproducto__c> listSubrProducto = new list<Subproducto__c>();
        Account natural = new Account(FirstName = 'Juan', LastName = 'Perez', Identificacion__c = '12345', PersonBirthdate = date.valueOf('1990-10-11'),
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
        
        map<String, String> mapTipoR = new map<String, String>();
        for(RecordType item: [Select Name, DeveloperName, id From RecordType Where sObjectType = 'Case' and name !='Retiros20' Order by DeveloperName ]){
            mapTipoR.put(item.DeveloperName, item.id);
        }
        
        Asset ass = new Asset(AccountId=juridico.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=juridico.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        list<Case> casos = new list<Case>();
        
        Case casoActualizacion = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Actualizacion_informacion'));
        casos.add(casoActualizacion);
        
        Case casoSubproducto = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Cambio_Subproducto'));
        casos.add(casoSubproducto);
        
        Case casoConstancia = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Constancia'));
        casos.add(casoConstancia);
        
        Case casoRetiros = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Retiros'));
        casos.add(casoRetiros);
        
        Case casoAumentoD2 = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Aumento_Disminucion_Aportes'));
        casos.add(casoAumentoD2);
        
        Case casoRetiros2 = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Retiros'));
        casos.add(casoRetiros2);
        
        Case casoReversiones = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Reversiones'));
        casos.add(casoReversiones);
        
        insert Casos;
        
        Case casoAumentoD = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Aumento_Disminucion_Aportes'));
        
        list<Detalle_caso__c> detalleCasos = new list<Detalle_caso__c>();
        Detalle_caso__c detalle = new Detalle_Caso__c(Caso__c = Casos[0].id, Cuenta__c = cuentaIndi.id);
        detalleCasos.add(detalle);
        
        Detalle_caso__c detalle1 = new Detalle_Caso__c(Caso__c = Casos[3].id, Cuenta__c = cuentaIndi.id,Cabeza_retiro__c = true, Monto_Saldo_Patronal__c = 100,
                                                       Forma_Retiro__c = 'CK', Porcentaje_Saldo_Patronal__c=12,Porcentaje_CRA_Individual__c=12);
        detalleCasos.add(detalle1);
        
        Detalle_caso__c detalle2 = new Detalle_Caso__c(Caso__c = Casos[3].id, Cuenta__c = cuentaIndi.id, Monto_Saldo_Patronal__c = 100,
                                                       Saldo_retirar__c = '12', Monto_Saldo__c = 100, Monto_retirar__c = 50);
        detalleCasos.add(detalle2);
        
        insert detalleCasos;
        
        test.startTest();
        extensionCasoDetalle controlActinfo = new extensionCasoDetalle(new ApexPages.StandardController(Casos[0]));
        controlActinfo.selecCuenta();
        controlActinfo.llenarCuentasDesdeSysde();
        // controlActinfo.verBeneficiarios2();
        if(controlActinfo.listBeneficiarios.size()>0){
            controlActinfo.listBeneficiarios[0].Casilla__c = true;
        }
        controlActinfo.agregarBeneficiarios();
        // controlActinfo.upsertBeneficiarios();
        // controlActinfo.verPagosBeneficiarios2();
        //controlActinfo.upsertPagosBeneficiarios();
        //controlActinfo.addPagoBene();     
        
        extensionCasoDetalle re= new extensionCasoDetalle();
        extensionCasoDetalle.metodoutil();
        test.stopTest();   
        
    }
    
     static testMethod void llamadasREST2(){ 
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
        
        Usuarios_para_asignacion_Casos_SAC__c f = new Usuarios_para_asignacion_Casos_SAC__c();
        //f.Zona__c='2';
        f.Usuario__c = userinfo.getUserId();
        insert f;
        
        f = new Usuarios_para_asignacion_Casos_SAC__c();
        f.Zona__c='2';
        f.Usuario__c = userinfo.getUserId();
        insert f;
        
        
        FechaDC_Sysde__c fdcSysde = new FechaDC_Sysde__c(Name = 'CierreAlDia', Fecha_cierre__c  = date.today());
        insert fdcSysde;
        
        Producto__c producto = new Producto__c(Name = 'Producto1', Codigo__c = 'Pro1');
        insert producto;
        
        Subproducto__c subproducto = new Subproducto__c(Name = 'SubProducto1', Codigo__c = 'SubPro1', Producto__c = producto.id);
        insert subproducto;
        
        Subproducto__c subproducto2 = new Subproducto__c(Name = 'SubProducto2', Codigo__c = 'SubPro2', Producto__c = producto.id);
        insert subproducto2;
        list<Subproducto__c> listSubrProducto = new list<Subproducto__c>();
        Account natural = new Account(FirstName = 'Juan', LastName = 'Perez', Identificacion__c = '12345', PersonBirthdate = date.valueOf('1990-10-11'),
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
        
        map<String, String> mapTipoR = new map<String, String>();
        for(RecordType item: [Select Name, DeveloperName, id From RecordType Where sObjectType = 'Case' and name !='Retiros20' Order by DeveloperName ]){
            mapTipoR.put(item.DeveloperName, item.id);
        }
        
        Asset ass = new Asset(AccountId=juridico.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=juridico.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        list<Case> casos = new list<Case>();
        Case casoRetiros = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Retiros'));
        casos.add(casoRetiros);
        
        insert Casos;
        
        Case casoAumentoD = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Aumento_Disminucion_Aportes'));
        
        list<Detalle_caso__c> detalleCasos = new list<Detalle_caso__c>();
        Detalle_caso__c detalle1 = new Detalle_Caso__c(Caso__c = Casos[0].id, Cuenta__c = cuentaIndi.id,Cabeza_retiro__c = true, Monto_Saldo_Patronal__c = 100,
                                                       Forma_Retiro__c = 'CK', Porcentaje_Saldo_Patronal__c=12,Porcentaje_CRA_Individual__c=12);
        detalleCasos.add(detalle1);
        
        Detalle_caso__c detalle2 = new Detalle_Caso__c(Caso__c = Casos[0].id, Cuenta__c = cuentaIndi.id, Monto_Saldo_Patronal__c = 100,
                                                       Saldo_retirar__c = '12', Monto_Saldo__c = 100, Monto_retirar__c = 50);
        detalleCasos.add(detalle2);
        
        insert detalleCasos;
        
        test.startTest();
         extensionCasoDetalle controlRetiro = new extensionCasoDetalle(new ApexPages.StandardController(casos[0]));
        controlRetiro.verPropietarioCuenta();            
        controlRetiro.detalleCaso.Cliente_quiere_capital_semilla__c = false;
        controlRetiro.detalleCaso.Tipo_retiro__c = '52';
        controlRetiro.detalleCaso.Cliente_quiere_capital_semilla__c = true;
        controlRetiro.verMovimientos();
        controlRetiro.selecMovimiento(); 
        controlRetiro.detalleCaso.Fecha_Despido_Empresa__c=date.today();
        controlRetiro.detalleCaso.Fecha_Ingreso_Empresa__c=date.today().addyears(-1);
        controlRetiro.cuentasCaso.add(new Detalle_Caso__c(Cuenta__c = natural.id, Caso__c = casos[0].id, Saldo_retirar__c = '12',Tipo_retiro__c = '51',
                                                          Monto_Saldo__c = 100, Monto_retirar__c = -2, CurrencyIsoCode='HNL')); 
        
        controlretiro.caso.Aplica_Saldo_patronal__c=true;
        controlRetiro.detalleCaso.Total_Saldo_Personal__c =30;
        controlRetiro.detalleCaso.Total_Saldo_Patronal__c =30;
        controlretiro.caso.CurrencyIsoCode='HNL';
        controlRetiro.detalleCaso.Prestamo_anterior__c = 'csac';
        controlRetiro.VerificacionPreatamoRefinanciar();
        controlRetiro.VerificacionMontoPrestamo();
        
        controlRetiro.detallecaso.Es_Primer_Prestamo__c=true;
        controlRetiro.detallecaso.No_es_primer_prestamo__c=true;
        controlRetiro.VerificacionCheckPrestamos();
        controlRetiro.detallecaso.Es_Refinanciamiento__c=true;
        controlRetiro.VerificacionCheckPrestamos();
        controlRetiro.detallecaso.Es_Refinanciamiento__c=false;
        controlRetiro.detallecaso.No_es_primer_prestamo__c=true;
        controlRetiro.VerificacionCheckPrestamos();
        controlRetiro.detallecaso.No_es_primer_prestamo__c=false;
        controlRetiro.detallecaso.Es_Primer_Prestamo__c=true;
        controlRetiro.detalleCaso.Monto_Pignorado__c =12;
        controlRetiro.VerificacionCheckPrestamos();
        
        controlRetiro.guardar();
        controlRetiro.cuentasCaso[0].Monto_retirar__c = 200;
        controlRetiro.guardar();
        controlRetiro.cuentasCaso[0].Monto_retirar__c = 50;
        controlRetiro.guardar();
        
        controlRetiro.Caso.id=null;
        controlRetiro.guardar();
        
        
        
        extensionCasoDetalle re= new extensionCasoDetalle();
        extensionCasoDetalle.metodoutil();
        test.stopTest();   
        
    }
   
    
     static testMethod void llamadasREST3(){ 
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
        
        Usuarios_para_asignacion_Casos_SAC__c f = new Usuarios_para_asignacion_Casos_SAC__c();
        f.Usuario__c = userinfo.getUserId();
        insert f;
        
        f = new Usuarios_para_asignacion_Casos_SAC__c();
        f.Zona__c='2';
        f.Usuario__c = userinfo.getUserId();
        insert f;
        
        
        FechaDC_Sysde__c fdcSysde = new FechaDC_Sysde__c(Name = 'CierreAlDia', Fecha_cierre__c  = date.today());
        insert fdcSysde;
        
        Producto__c producto = new Producto__c(Name = 'Producto1', Codigo__c = 'Pro1');
        insert producto;
        
        Subproducto__c subproducto = new Subproducto__c(Name = 'SubProducto1', Codigo__c = 'SubPro1', Producto__c = producto.id);
        insert subproducto;
        
        Subproducto__c subproducto2 = new Subproducto__c(Name = 'SubProducto2', Codigo__c = 'SubPro2', Producto__c = producto.id);
        insert subproducto2;
        list<Subproducto__c> listSubrProducto = new list<Subproducto__c>();
        Account natural = new Account(FirstName = 'Juan', LastName = 'Perez', Identificacion__c = '12345', PersonBirthdate = date.valueOf('1990-10-11'),
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
        
        map<String, String> mapTipoR = new map<String, String>();
        for(RecordType item: [Select Name, DeveloperName, id From RecordType Where sObjectType = 'Case' and name !='Retiros20' Order by DeveloperName ]){
            mapTipoR.put(item.DeveloperName, item.id);
        }
        
        Asset ass = new Asset(AccountId=juridico.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=juridico.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        list<Case> casos = new list<Case>();
        
        Case casoActualizacion = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Actualizacion_informacion'));
        casos.add(casoActualizacion);
        
        Case casoSubproducto = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Cambio_Subproducto'));
        casos.add(casoSubproducto);
        
        Case casoConstancia = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Constancia'));
        casos.add(casoConstancia);
        
        Case casoRetiros = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Retiros'));
        casos.add(casoRetiros);
        
        Case casoAumentoD2 = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Aumento_Disminucion_Aportes'));
        casos.add(casoAumentoD2);
        
        Case casoRetiros2 = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Retiros'));
        casos.add(casoRetiros2);
        
        Case casoReversiones = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Reversiones'));
        casos.add(casoReversiones);
        
        insert Casos;
        
        Case casoAumentoD = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Aumento_Disminucion_Aportes'));
        
        list<Detalle_caso__c> detalleCasos = new list<Detalle_caso__c>();
        Detalle_caso__c detalle = new Detalle_Caso__c(Caso__c = Casos[0].id, Cuenta__c = cuentaIndi.id);
        detalleCasos.add(detalle);
        
        Detalle_caso__c detalle1 = new Detalle_Caso__c(Caso__c = Casos[3].id, Cuenta__c = cuentaIndi.id,Cabeza_retiro__c = true, Monto_Saldo_Patronal__c = 100,
                                                       Forma_Retiro__c = 'CK', Porcentaje_Saldo_Patronal__c=12,Porcentaje_CRA_Individual__c=12);
        detalleCasos.add(detalle1);
        
        Detalle_caso__c detalle2 = new Detalle_Caso__c(Caso__c = Casos[3].id, Cuenta__c = cuentaIndi.id, Monto_Saldo_Patronal__c = 100,
                                                       Saldo_retirar__c = '12', Monto_Saldo__c = 100, Monto_retirar__c = 50);
        detalleCasos.add(detalle2);
        
        insert detalleCasos;
        
        test.startTest();
        
        
        cuentaIndiColec.fecha_apertura__c = date.today() - 950;
        update cuentaIndiColec;
        extensionCasoDetalle controlRetiro2 = new extensionCasoDetalle(new ApexPages.StandardController(casos[5]));
        controlRetiro2.detalleCaso.Tipo_retiro__c = '52';
        controlRetiro2.guardar();
        
        extensionCasoDetalle re= new extensionCasoDetalle();
        extensionCasoDetalle.metodoutil();
        test.stopTest();   
        
    }
   
    
     static testMethod void llamadasREST4(){ 
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
        
        Usuarios_para_asignacion_Casos_SAC__c f = new Usuarios_para_asignacion_Casos_SAC__c();
        f.Usuario__c = userinfo.getUserId();
        insert f;
        
        f = new Usuarios_para_asignacion_Casos_SAC__c();
        f.Zona__c='2';
        f.Usuario__c = userinfo.getUserId();
        insert f;
        
        
        FechaDC_Sysde__c fdcSysde = new FechaDC_Sysde__c(Name = 'CierreAlDia', Fecha_cierre__c  = date.today());
        insert fdcSysde;
        
        Producto__c producto = new Producto__c(Name = 'Producto1', Codigo__c = 'Pro1');
        insert producto;
        
        Subproducto__c subproducto = new Subproducto__c(Name = 'SubProducto1', Codigo__c = 'SubPro1', Producto__c = producto.id);
        insert subproducto;
        
        Subproducto__c subproducto2 = new Subproducto__c(Name = 'SubProducto2', Codigo__c = 'SubPro2', Producto__c = producto.id);
        insert subproducto2;
        list<Subproducto__c> listSubrProducto = new list<Subproducto__c>();
        Account natural = new Account(FirstName = 'Juan', LastName = 'Perez', Identificacion__c = '12345', PersonBirthdate = date.valueOf('1990-10-11'),
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
        
        map<String, String> mapTipoR = new map<String, String>();
        for(RecordType item: [Select Name, DeveloperName, id From RecordType Where sObjectType = 'Case' and name !='Retiros20' Order by DeveloperName ]){
            mapTipoR.put(item.DeveloperName, item.id);
        }
        
        Asset ass = new Asset(AccountId=juridico.Id,Name='testing');   
        insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=juridico.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        list<Case> casos = new list<Case>();
        
        Case casoActualizacion = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Actualizacion_informacion'));
        casos.add(casoActualizacion);
        
        Case casoSubproducto = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Cambio_Subproducto'));
        casos.add(casoSubproducto);
        
        Case casoConstancia = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Constancia'));
        casos.add(casoConstancia);
        
        Case casoRetiros = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Retiros'));
        casos.add(casoRetiros);
        
        Case casoAumentoD2 = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Aumento_Disminucion_Aportes'));
        casos.add(casoAumentoD2);
        
        Case casoRetiros2 = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Retiros'));
        casos.add(casoRetiros2);
        
        Case casoReversiones = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Reversiones'));
        casos.add(casoReversiones);
        
        insert Casos;
        
        Case casoAumentoD = new Case(AccountId = natural.id, Status = 'Nuevo', EntitlementId = ent.Id, Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Aumento_Disminucion_Aportes'));
        
        list<Detalle_caso__c> detalleCasos = new list<Detalle_caso__c>();
        Detalle_caso__c detalle = new Detalle_Caso__c(Caso__c = Casos[0].id, Cuenta__c = cuentaIndi.id);
        detalleCasos.add(detalle);
        
        Detalle_caso__c detalle1 = new Detalle_Caso__c(Caso__c = Casos[3].id, Cuenta__c = cuentaIndi.id,Cabeza_retiro__c = true, Monto_Saldo_Patronal__c = 100,
                                                       Forma_Retiro__c = 'CK', Porcentaje_Saldo_Patronal__c=12,Porcentaje_CRA_Individual__c=12);
        detalleCasos.add(detalle1);
        
        Detalle_caso__c detalle2 = new Detalle_Caso__c(Caso__c = Casos[3].id, Cuenta__c = cuentaIndi.id, Monto_Saldo_Patronal__c = 100,
                                                       Saldo_retirar__c = '12', Monto_Saldo__c = 100, Monto_retirar__c = 50);
        detalleCasos.add(detalle2);
        
        insert detalleCasos;
        
        test.startTest();
        extensionCasoDetalle controlADA2 = new extensionCasoDetalle(new ApexPages.StandardController(casos[4]));
        controlADA2.detalleCaso.Nuevo_monto_aporte__c = 7000; 
        controlADA2.guardar();
        
        extensionCasoDetalle re= new extensionCasoDetalle();
        extensionCasoDetalle.metodoutil();
        test.stopTest();   
        
    }
   
    
    
}