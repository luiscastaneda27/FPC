@isTest
public class controladorCasoRetirosTest {
	static testMethod void execute() { 
    	//try{
            
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
            
            Subproducto__c subproducto = new Subproducto__c(Name = 'SubProducto1', Codigo__c = 'SubPro1', Producto__c = producto.id, Monto_Saldo_Minimo_CRA__c = 500);
            insert subproducto;
            
            Subproducto__c subproducto2 = new Subproducto__c(Name = 'SubProducto2', Codigo__c = 'SubPro2', Producto__c = producto.id, Monto_Saldo_Minimo_CRA__c = 500);
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
                                                       Id_Externo__c = 0801, Fecha_nacimiento__c = date.today(),  
                                                       Primer_Nombre__c = 'Test', Segundo_Apellido__c = 'Test', Segundo_Nombre__c = 'Test',
                                                       Sexo__c = 'M', Telefono__c = '84578587', Tipo_de_Identificaci_n__c = '1', Casilla__c = true);
        	
            insert bene;
                  
            System.debug('bene: '+bene);
            
            Account juridico = new Account(Name = 'Intellect', Identificacion__c = '54321',
                                           RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Juridico'].id);
            insert juridico;                            
            
            Cuentas__c cuentaColec = new Cuentas__c(Name = 'Cuenta2', Codigo__c = '789', Cliente__c = juridico.id, currencyIsoCode = 'HNL', Monto_Saldo_Minimo_CRA__c = 500);
            insert cuentaColec;
            
            Cuentas__c cuentaIndiColec = new Cuentas__c(Name = 'Cuenta3', Codigo__c = '456', Cliente__c = natural.id, 
                                                        Cuenta_colectiva2__c = cuentaColec.id, currencyIsoCode = 'HNL', Fecha_Apertura__c = hoy);
            insert cuentaIndiColec;
        
            ClienteNaturales benes = controllerApiClienteNatural.ConsultaInfoClienteC('51600');
            
            map<String, String> mapTipoR = new map<String, String>();
            for(RecordType item: [Select Name, DeveloperName, id From RecordType Where sObjectType = 'Case' and name !='Retiros20' Order by DeveloperName ]){
                mapTipoR.put(item.DeveloperName, item.id);
            }
            //list<RecordType> tiposR = [Select Name From RecordType Where sObjectType = 'Case' and name !='Retiros20' Order by DeveloperName ];
            //system.debug(tiposR);
            
            list<Case> casos = new list<Case>();

            Case casoRetiros = new Case(AccountId = natural.id, Status = 'Nuevo', Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Retiros'));
            casos.add(casoRetiros);
      
            Case casoRetiros2 = new Case(AccountId = natural.id, Status = 'Nuevo', Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Retiros'));
            casos.add(casoRetiros2);
            
            insert Casos;
            
            Case casoAumentoD = new Case(AccountId = natural.id, Status = 'Nuevo',Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Aumento_Disminucion_Aportes'));
            
            list<Detalle_caso__c> detalleCasos = new list<Detalle_caso__c>();
            Detalle_caso__c detalle = new Detalle_Caso__c(Caso__c = Casos[0].id, Cuenta__c = cuentaIndi.id, Fecha_Ingreso_Empresa__c = System.today().addDays(-50), Fecha_Despido_Empresa__c = System.today(), Monto_comision_retiro__c = 50, Cliente_sigue_Laborando__c = true, Cobrar_empleado_sigue_laborando__c = true, Monto_Saldo_Patronal__c = 100, Monto_retirar__c = 1000, Total_Saldo_Patronal__c = 1500, Tipo_pago__c = 'N', Tipo_retiro__c = '51');
            detalleCasos.add(detalle);
            
            Detalle_caso__c detalle1 = new Detalle_Caso__c(Caso__c = Casos[1].id, Cuenta__c = cuentaIndi.id,Cabeza_retiro__c = true,Monto_Saldo_Patronal__c = 100, 
                                                           Forma_Retiro__c = 'CK', Porcentaje_Saldo_Patronal__c=12,Porcentaje_CRA_Individual__c=12, Saldo_retirar__c = '10', Monto_retirar__c = 1000, Tipo_retiro__c = '51');
            detalleCasos.add(detalle1);
            
            Detalle_caso__c detalle2 = new Detalle_Caso__c(Caso__c = Casos[1].id, Cuenta__c = cuentaIndi.id,Monto_Saldo_Patronal__c = 100,
                                                           Monto_Saldo__c = 100, Saldo_retirar__c = '11', Monto_retirar__c = 1000, Tipo_retiro__c = '51');
            detalleCasos.add(detalle2);
        
            Detalle_caso__c detalle3 = new Detalle_Caso__c(Caso__c = Casos[1].id, Cuenta__c = cuentaIndi.id,Monto_Saldo_Patronal__c = 100, Permitir_Retiro_Saldos_Patronales__c = false,
                                                           Monto_Saldo__c = 100, Saldo_retirar__c = '12', Monto_retirar__c = 1000, Tipo_retiro__c = '51');
            detalleCasos.add(detalle3);
                        
            insert detalleCasos;
                        
            list<Pago_Beneficiario__c> listPagosBenes = new list<Pago_Beneficiario__c>();
            
            Pago_Beneficiario__c pagobene = new Pago_Beneficiario__c(Caso__c = casoRetiros.Id, Detalle_caso__c = detalle.Id, Primer_nombre__c = 'Test', Segundo_nombre__c = 'Test', Primer_apellido__c = 'Test', Segundo_apellido__c = 'Test', Parentesco__c = '7', Sexo__c = 'Masculino', Identidad__c = '0801199411013', Pago_a_Tercero__c = false, Porcentaje__c = 50, Forma_Retiro__c = 'AH', Nombre_banco__c = '', Numero_cuenta_destino__c = '123456789', Tipo_cuenta__c = 'Ahorro', Moneda_cuenta__c = 'HNL', Monto_bruto__c = 5000, Comisiones_cargos__c = 1000, Monto_neto_retirar__c = 4000);
            listPagosBenes.add(pagobene);
        
            Pago_Beneficiario__c pagobene2 = new Pago_Beneficiario__c(Caso__c = casoRetiros.Id, Detalle_caso__c = detalle.Id, Primer_nombre__c = 'Test', Segundo_nombre__c = 'Test', Primer_apellido__c = 'Test', Segundo_apellido__c = 'Test', Parentesco__c = '7', Sexo__c = 'Masculino', Identidad__c = '0801199411012', Pago_a_Tercero__c = false, Porcentaje__c = 50, Forma_Retiro__c = 'ACH', Nombre_banco__c = '', Numero_cuenta_destino__c = '123456789', Tipo_cuenta__c = 'Ahorro', Moneda_cuenta__c = 'HNL', Monto_bruto__c = 5000, Comisiones_cargos__c = 1000, Monto_neto_retirar__c = 4000);
            listPagosBenes.add(pagobene2);
        
            Pago_Beneficiario__c pagobene3 = new Pago_Beneficiario__c(Caso__c = casoRetiros.Id, Detalle_caso__c = detalle.Id, Primer_nombre__c = 'Test', Segundo_nombre__c = 'Test', Primer_apellido__c = 'Test', Segundo_apellido__c = 'Test', Parentesco__c = '7', Sexo__c = 'Masculino', Identidad__c = '0801199411011', Pago_a_Tercero__c = false, Porcentaje__c = 50, Forma_Retiro__c = '', Nombre_banco__c = '', Numero_cuenta_destino__c = '123456789', Tipo_cuenta__c = 'Ahorro', Moneda_cuenta__c = 'HNL', Monto_bruto__c = 5000, Comisiones_cargos__c = 1000, Monto_neto_retirar__c = 4000);
            listPagosBenes.add(pagobene3);
        
            Pago_Beneficiario__c pagobene4 = new Pago_Beneficiario__c(Caso__c = casoRetiros.Id, Detalle_caso__c = detalle.Id, Primer_nombre__c = 'Test', Segundo_nombre__c = 'Test', Primer_apellido__c = 'Test', Segundo_apellido__c = 'Test', Parentesco__c = '7', Sexo__c = 'Masculino', Identidad__c = '0801199411011', Pago_a_Tercero__c = false, Porcentaje__c = 50, Forma_Retiro__c = 'CK', Nombre_banco__c = '', Numero_cuenta_destino__c = '123456789', Tipo_cuenta__c = 'Ahorro', Moneda_cuenta__c = '', Monto_bruto__c = 5000, Comisiones_cargos__c = 1000, Monto_neto_retirar__c = 4000);
            listPagosBenes.add(pagobene4);
        
            Pago_Beneficiario__c pagobene5 = new Pago_Beneficiario__c(Caso__c = casoRetiros.Id, Detalle_caso__c = detalle.Id, Primer_nombre__c = 'Test', Segundo_nombre__c = 'Test', Primer_apellido__c = 'Test', Segundo_apellido__c = 'Test', Parentesco__c = '7', Sexo__c = 'Masculino', Identidad__c = '0801199411011', Pago_a_Tercero__c = false, Porcentaje__c = 50, Forma_Retiro__c = 'CK', Nombre_banco__c = '', Numero_cuenta_destino__c = '123456789', Tipo_cuenta__c = 'Ahorro', Moneda_cuenta__c = 'HNL', Monto_bruto__c = Null, Comisiones_cargos__c = 1000, Monto_neto_retirar__c = 4000);
            listPagosBenes.add(pagobene5);
        
            Pago_Beneficiario__c pagobene6 = new Pago_Beneficiario__c(Caso__c = casoRetiros.Id, Detalle_caso__c = detalle.Id, Primer_nombre__c = 'Test', Segundo_nombre__c = 'Test', Primer_apellido__c = 'Test', Segundo_apellido__c = 'Test', Parentesco__c = '7', Sexo__c = 'Masculino', Identidad__c = '0801199411011', Pago_a_Tercero__c = false, Porcentaje__c = 50, Forma_Retiro__c = 'CK', Nombre_banco__c = '', Numero_cuenta_destino__c = '123456789', Tipo_cuenta__c = 'Ahorro', Moneda_cuenta__c = 'HNL', Monto_bruto__c = 5000, Comisiones_cargos__c = 1000, Monto_neto_retirar__c = 4000);
            listPagosBenes.add(pagobene6);
        
            Pago_Beneficiario__c pagobene7 = new Pago_Beneficiario__c(Caso__c = casoRetiros.Id, Detalle_caso__c = detalle.Id, Primer_nombre__c = 'Test', Segundo_nombre__c = 'Test', Primer_apellido__c = 'Test', Segundo_apellido__c = 'Test', Parentesco__c = '7', Sexo__c = 'Masculino', Identidad__c = '0801199411011', Pago_a_Tercero__c = false, Porcentaje__c = 50, Forma_Retiro__c = 'CK', Nombre_banco__c = '', Numero_cuenta_destino__c = '123456789', Tipo_cuenta__c = 'Ahorro', Moneda_cuenta__c = 'US$', Monto_bruto__c = 5000, Comisiones_cargos__c = 1000, Monto_neto_retirar__c = 4000);
            listPagosBenes.add(pagobene7);
        
            Pago_Beneficiario__c pagobene8 = new Pago_Beneficiario__c(Caso__c = casoRetiros.Id, Detalle_caso__c = detalle.Id, Primer_nombre__c = 'Test', Segundo_nombre__c = 'Test', Primer_apellido__c = 'Test', Segundo_apellido__c = 'Test', Parentesco__c = '7', Sexo__c = 'Masculino', Identidad__c = '0801199411011', Pago_a_Tercero__c = false, Porcentaje__c = 50, Forma_Retiro__c = 'ACH', Nombre_banco__c = '24', Numero_cuenta_destino__c = '123456789', Tipo_cuenta__c = 'Ahorro', Moneda_cuenta__c = 'US$', Monto_bruto__c = 5000, Comisiones_cargos__c = 1000, Monto_neto_retirar__c = 4000);
            listPagosBenes.add(pagobene8);
        
            Pago_Beneficiario__c pagobene9 = new Pago_Beneficiario__c(Caso__c = casoRetiros.Id, Detalle_caso__c = detalle.Id, Primer_nombre__c = 'Test', Segundo_nombre__c = 'Test', Primer_apellido__c = 'Test', Segundo_apellido__c = 'Test', Parentesco__c = '7', Sexo__c = 'Masculino', Identidad__c = '0801199411011', Pago_a_Tercero__c = false, Porcentaje__c = 50, Forma_Retiro__c = 'AH', Nombre_banco__c = '24', Numero_cuenta_destino__c = '123456789', Tipo_cuenta__c = 'Ahorro', Moneda_cuenta__c = 'US$', Monto_bruto__c = 5000, Comisiones_cargos__c = 1000, Monto_neto_retirar__c = 4000);
            listPagosBenes.add(pagobene9);
            
            insert listPagosBenes;
                                                        
            test.startTest();
        
            ApexPages.currentPage().getParameters().put('index','0');
            ApexPages.currentPage().getParameters().put('index2','0');
            ApexPages.currentPage().getParameters().put('flagValue','true');
            
            controladorCasoRetiros controlActinfo = new controladorCasoRetiros(new ApexPages.StandardController(Casos[0]));
                        
            controlActinfo.saveAll = true; 
            
            controlActinfo.traerSaldos();
            controlActinfo.verPropietarioCuenta();
            controlActinfo.ModificarSaldoPrestamo();
            controlActinfo.guardar();
            controlActinfo.calculoSaldoPatronales();
            controlActinfo.ValidacionSaldoPatronales();
            controlActinfo.VerificacionMontoPrestamo();
            controlActinfo.llenarMapa();
            controlActinfo.selecCuentaRetiros();
            controlActinfo.selecTipoRetiro();
            controlActinfo.verBeneficiarios();
            controlActinfo.verBeneficiarios2();
            controlActinfo.upsertBeneficiarios();
            controlActinfo.verPagosBeneficiarios();
            controlActinfo.verPagosBeneficiarios2();
            controlActinfo.upsertPagosBeneficiarios();
            
            controlActinfo.guardar();
            
            controlActinfo.addPagoBene();
            //controlActinfo.delRow();
            
            controlActinfo.accionSubproducto();
                                  
            controlActinfo.guardar();
            /*controlActinfo.addPagoBene2();  
            controlActinfo.delRow2();
            controlActinfo.agregarBeneficiarios();*/
            
            /*controlActinfo.agregarBeneficiarios();
            
            controlActinfo.accionVacia();*/
            
            controladorCasoRetiros controlADA = new controladorCasoRetiros(new ApexPages.StandardController(casoAumentoD));
            controlADA.accionVacia();
            controlADA.accionVacia2();
            controlADA.buscarCuentaC();
            controlADA.buscarSubPro();
                        
            controlADA.delRow();
            //controlADA.guardar();
            controlADA.addPagoBene2();
            controlADA.delRow2();
            controlADA.agregarBeneficiarios();
            //controlADA.guardar();
            
            /*controlADA.agregarBeneficiarios();
            controlActinfo.guardar();*/
        
            controlADA.changeFlag();       
        
            test.stopTest();  
        
        /*}catch(exception ex){
            
        }*/
    }
    
}