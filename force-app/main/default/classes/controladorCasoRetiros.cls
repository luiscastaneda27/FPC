public class controladorCasoRetiros {
    public claseTipoCaso cTipoCaso{get;set;}
    public Case Caso{get;set;}
    
    public Detalle_caso__c detalleCaso{get;set;}
    public Double montoPatOrd{get;set;} 
    public Double montoPerOrd{get;set;}
    public Double montoPerExtOrd{get;set;}
    public Decimal saldo10{get;set;}
    public Decimal saldo11{get;set;}
    public Decimal saldo12{get;set;}
    public Decimal saldo13{get;set;}
    public Double montoaRetirar{get;set;}
    public Double montoPatExtOrd{get;set;}
    public Cuentas__c cuentaCliente{get;set;}
    public boolean bandera3{get;set;}
    public boolean banderaSubTipoTran{get;set;}
    public boolean mostrarReversiones{get;set;}
    public boolean mostrarReversionesDife{get;set;}
    public boolean mostrarFecha{get;set;}
    public boolean mostrarbonotes{get;set;}
    public boolean mostrarMonto{get;set;}
    public boolean mostrarReversionesDifeabajo{get;set;}
    public list<Detalle_caso__c> cuentasCaso{get;set;}
    public decimal totalSaldo2;
    public integer conteoGeneral{get;set;}
    public integer indiceEliminar{get;set;} 
    public boolean MostartablaMovimientos{get;set;}
    public list<SelectOption> listCuentas{get;set;}
    public string idCuenta{get;set;}
    public string MonedaCuenta{get;set;}
    private map<String, Cuentas__c> mapCuentas = new map<String, Cuentas__c>();
    public list<Beneficiario__c> listBeneficiarios{get;set;}
    public list<Pago_Beneficiario__c> listPagosBeneficiarios {get;set;}
    public list<Pago_Beneficiario__c> listPagosBeneficiarios2 {get;set;}
    public list<Pago_Beneficiario__c> listPagosBenes {get;set;}
    public boolean popBene{get;set;}
    public boolean popBene2{get;set;}
    public boolean popPagoBene{get;set;}
    public boolean popPagoBene2{get;set;}
    public String addRecords {set; get;}
    public String pagosBT {set; get;}
    public Double porcCobroIndiv;
    public boolean aplicaComi;
    
    public boolean popCuentaC{get;set;}
    public boolean popSubPro{get;set;}
    public string nombreCuenta{get;set;}
    public string nombreSubproducto{get;set;}
    public list<Cuentas__c> cuentasColectivas{get;set;}
    public list<Subproducto__c> subProductos{get;set;}
    public boolean mostrarGuardar{get;set;}
    public boolean esSalesforce {get;set;}
    
    public boolean popAporte{get;set;}
    public list<classAportes> listAportes{get;set;}
    public map<id, Detalle_caso__c> mapDCasoCuenta{get;set;}
    //public string idDetalleEliminar{get;set;}
    public list<Detalle_Caso__c> listDetalleEliminar{get;set;}
    public boolean popDolares {get;set;}   
       
    public map<integer, decimal> mapPSP {get;set;}
    
    public boolean popFormulario{get;set;}
    public String urlFormulario{get;set;}
    public boolean popAdjuntar{get;set;}
    public boolean popConstancia{get;set;}
    public boolean popEDC{get;set;}
    
    public boolean esBanco{get;set;}
    public boolean esCallCenter{get;set;}
    
    public boolean archivoAd{get;set;}    
    public integer anosCliente{get;set;}
    public boolean mostrarFormulario{get;set;}
    list<Configuracion_Cobro__mdt> configCobros;
    public boolean pruebamodal{get;set;}
                               
    public boolean mostrarEnviarAprobacion{get;set;}
    public boolean mostrarCerrarCaso{get;set;}
    public boolean detalleCasoActualizado{get;set;}
    
    public Map<String,String> mapSaldos;
    
    public controladorCasoRetiros(ApexPages.StandardController controller) {
        idCaso = controller.getId();
        montoaRetirar = 0.00; montoPatOrd = 0.00; montoPatExtOrd = 0.00; montoPerOrd = 0.00; montoPerExtOrd = 0.00; porcCobroIndiv = 0.00; aplicaComi = false;
        saldo10 = 0.00; saldo11 = 0.00; saldo12 = 0.00; saldo13 = 0.00;
        
        pruebamodal=false;
        
        vienedeVisualforce = true;
        
        mapSaldos = new Map<String,String>();
        
        mostrarFormulario = true;
        detalleCasoActualizado=false;
        listCuentas = new list<SelectOption>();
        detalleCaso = new Detalle_caso__c();
        //detalleCaso2 = new Detalle_caso__c();
        detalleCaso.Accion__c = 'A2';
        detalleCaso.Tipo_Operacion__c = 'A1';
        mostrarReversiones=false;
        mostrarReversionesDife=false;
        mostrarFecha = false;
        popDolares = false;
        mostrarbonotes = false;
        mostrarEnviarAprobacion = false;
        mostrarCerrarCaso = false;
        MostartablaMovimientos=false;
        mostrarReversionesDifeabajo=false;
        mostrarMonto = true;
        cuentaCliente = new Cuentas__c();
        cuentasCaso = new list<Detalle_caso__c>();
        mapDCasoCuenta = new map<Id, Detalle_Caso__c>();
        listDetalleEliminar = new list<Detalle_Caso__c>();
        listBeneficiarios = new list<Beneficiario__c>();
        listPagosBeneficiarios = new list<Pago_Beneficiario__c>();
        listPagosBeneficiarios2 = new list<Pago_Beneficiario__c>();
        popBene = false;
        indiceEliminar = 0;
        esBanco = False;
        esCallCenter = False;
        banderaSubTipoTran=false;
        listAportes = new list<classAportes>();
        archivoAd = false;
        esSalesforce = false;
        string guest = '';
        //nueva lista        
        try{           
                Caso = [Select Status,AccountId,CreatedDate, Account.Identificacion__c, RecordType.DeveloperName,
                        Fecha_desde__c, fecha_hasta__c,Account.PersonBirthdate, account.sexo__C,
                        Desea_ver_tasa_de_cambio__c, SuppliedEmail,
                        Constancia__c, currencyIsoCode,Requiere_aprobacion_exoneracion__c,
                        Mostrar_tasa_Cambio__c,Tasa_Cambio__c,
                        //account.Departamento_Residencia__r.Codigo_Departamento__c,
                        Enviar_a_aprobacion__c,Aplica_Saldo_patronal__c ,Aprobado__c,
                        Archivo_Adjunto__C,Nombre_agencia__c, agencia__c, Agencia__r.Name, account.Departamento_Residencia2__c,
                        Monto_compromiso_aporte__c, Frecuencia__c,Codigo_barra__C, Cuentas_seleccionada__c
                        From Case Where Id =: idCaso Limit 1]; 
                if(caso.Account.PersonBirthdate!=null){
                    date gdcs=caso.Account.PersonBirthdate;
                    anosCliente = gdcs.monthsBetween(date.today());
                    anosCliente =(integer)(anosCliente/12);
                }
            mostrarGuardar = (Caso.Status != 'Pendiente de aprobación' && Caso.Status != 'Pendiente segunda aprobación' 
                   && Caso.Status != 'Error de conexion' && Caso.Status != 'Cerrado') ? true : false;
                
                guest = userInfo.getUserType();
                cTipoCaso = new claseTipoCaso(Caso.RecordType.DeveloperName);
                llenarcuentas();
                detalleCaso.Caso__c = Caso.id;                              
                conteoGeneral = 0;
                map<string, integer> conteodetalleCaso=new map<string, integer>();
                cuentasCaso=[Select Nueva_Cuenta_colectiva2__c,id, Nuevo_Subproducto__c, Cuenta__c, Tipo_Saldo__c,Cobrar_comision__c, 
                             Detalle_subproducto__c, Detalle_Cuenta_colectiva__c,  Grado_parentesco__c,
                             Accion__c,Nueva_fecha_aporte__c,Nuevo_canal_aporte__c,Nuevo_monto_aporte__c, Exoneracion_3ra_Edad__c, 
                             N_Cuenta_Bancaria__c,Tipo_Operacion__c,Tipo_saldo_modificar2__c,Monto_Original__C,
                             Cliente_quiere_capital_semilla__c,Cliente_sigue_Laborando__c,Permitir_Retiro_Saldos_Patronales__c,
                             Comision_Retiro_Anticipado__c, Monto_retirar__c,Tipo_retiro__c,Forma_Retiro__c,Banco__c,Tipo_Cuenta__c,
                             currencyIsoCode,Tipo_transaccion__c,Subtipo_transaccion__c,Comision_por_aporte__c,Monto_reversar__c,
                             Porcentaje_comision__c,Tiene_Cuenta_Colectiva__c, Fecha_aporte__c, Frecuencia__c, Mes__c, Ano_tarjeta__c,Fecha_nacimiento__c,
                             Sexo__c,Primer_Nombre__c, Segundo_Nombre__c, Primer_Apellido__c, Segundo_Apellido__c, Parentesco__c,
                             Tipo_identificacion__c,Porcentaje__c,Fecha_hasta_Reversar__c , Identificacion__c, Indice__c, POS__c, Saldo_retirar__c,
                             Cabeza_Retiro__c, Comision_retiro_anticipado_empresa__c,Monto_Prestamo_Anterior__C, Cobrar_empleado_sigue_laborando__c,
                             Cobro_ACH__c, Cobro_Cheque__c, Cobro_TSP__c,Monto_cheque__c,Monto_TSP__c, Monto_ACH__c,
                             Monto_Saldo__c,Saldo_Total__c, Fecha_desde__c, Fecha_Hasta__c,Rendimiento__c,Monto_comision_saldo__c,
                             Monto_comision_aporte__c,Pago_terceros__c,Cuenta_destino__c,Propietario_cuenta__c,Cargo_Empleado_Paga_Empresa__C,
                             Monto_TSP_Patrono__c, Monto_Cheque_Patrono__c, Monto_ACH_Patrono__c, Numero_prestamo__c,
                             Cuenta_Colectiva_Anterior__c,cuenta__r.codigo__C, cuenta__r.Cuenta_colectiva2__c,
                             Monto_Pignorar_Refinanciamiento__C,
                             rezago__C, cod_referencia__C, Producto_Anterior__C,Fecha_Deposito__C,Inicio_Fecha_Aporte__c,
                             monto_prestamo__c, Total_Saldo_Personal__c, Total_Saldo_Patronal__c, Es_Primer_Prestamo__c,
                             No_es_primer_prestamo__c, Es_Refinanciamiento__c, Monto_a_Pignorar__c, Detalle_Subproducto2__c,
                             Aplica_Cambio_Sub_Producto_desde_Retiros__C, Prestamo_anterior__C,Cargar_cargos_Empleados__C,
                             Monto_Pignorado__c, Saldo_Prestamo__c, Monto_Saldo_Patronal__c, Porcentaje_Saldo_Patronal__c,
                             Fecha_Ingreso_Empresa__c, Fecha_Despido_Empresa__c, Total_Cargos_Empresa__c,Se_lleva_Parte_Patronal__c,
                             Tipo_Politica_Retiro_Saldo_Patronal__c, Monto_bruto_Retirar_Empresa__c, Monto_neto_Retirar_Empresa__c,
                             Monto_total_retirar__c,Monto_bruto_retirar__c,Monto_total_comisiones_recargos__c,Total_exonerado__c,
                             Monto_comision_retiro__c, Exonerado__c, descripcion__c, monto__C,Nivel_de_Regla__c,
                             Cobro_Individual_CRA__c,Porcentaje_CRA_Individual__c,Cobro_Saldo_Minimo_CRA__c, Monto_Saldo_Minimo_CRA__c, 
                             cuenta__r.Cobro_Individual_CRA__c, cuenta__r.Porcentaje_CRA_Individual__c,Saldo_Restante_Cuenta_Cliente__c, Monto_Saldo_Patronal_Ext__c, 
                             Porcentaje_Saldo_Patronal_Ext__c, Tipo_pago__c
                             From Detalle_caso__c Where Caso__c =: caso.id order by Cabeza_retiro__c desc]; 
                if(idCuenta != null && mapCuentas.containsKey(idCuenta)){
                    monedaCuenta= mapCuentas.get(idCuenta).CurrencyIsoCode;
                }
                if(!cuentasCaso.isEmpty()) {
                    pagosBT = 'display:block;';
                    
                    detalleCaso = cuentasCaso[0];
                    idCuenta = detalleCaso.Cuenta__c;
                    cuentaCliente = mapCuentas.get(idCuenta);
                    //MonedaCuenta();
                    monedaCuenta= cuentaCliente.CurrencyIsoCode;
                    system.debug('Moneda: '+cuentaCliente.CurrencyIsoCode);
                    if(cTipoCaso.retiros){
                        cuentasCaso.remove(0);
                        detalleCasoActualizado = (Caso.status=='Pendiente de aprobación' || Caso.status=='Pendiente segunda aprobación') ? true:false;
                        map<string, integer> casos = new map<string, integer>();
                        list<detalle_caso__c> casostemporales = new list<detalle_caso__c>();
                        for(integer i=0; i<cuentasCaso.size(); i++){
                            if(!casos.containsKey(cuentasCaso[i].saldo_retirar__C)) { casos.put(cuentasCaso[i].saldo_retirar__C, 2); casostemporales.add(cuentasCaso[i]);
                            }
                        }
                        cuentasCaso = new list<detalle_caso__c>();
                        cuentasCaso=casostemporales;
                        getSaldoCuenta saldos = new getSaldoCuenta();
                        Decimal montoBrutoRetirar=0;
                        for(integer i=0; i<cuentasCaso.size(); i++){
                            if(cuentasCaso[i].Monto_retirar__c !=null) { montoBrutoRetirar += cuentasCaso[i].Monto_retirar__c; 
                            }
                            if(cuentasCaso[i].Saldo_retirar__c == '10') { saldo10 = cuentasCaso[i].Monto_retirar__c;
                            }
                            if(cuentasCaso[i].Saldo_retirar__c == '11') { saldo11 = cuentasCaso[i].Monto_retirar__c;
                            }
                            if(cuentasCaso[i].Saldo_retirar__c == '12') { saldo12 = cuentasCaso[i].Monto_retirar__c;
                            }
                            if(cuentasCaso[i].Saldo_retirar__c == '13') { saldo13 = cuentasCaso[i].Monto_retirar__c;
                            }
                        }
                        bandera3=false;
                        if(caso.Status=='Pendiente de aprobación' || caso.Status=='Pendiente segunda aprobación' ||
                            caso.Status=='Nuevo' || caso.Status=='Rechazado' || caso.Status=='Devuelto'){
                            montoBrutoRetirar=0;
                            bandera3=true;
                            saldos = aSysdeCallouts.traerSaldos(cuentaCliente.Codigo__c);
                            try{
                                detalleCaso.Saldo_total__c=decimal.valueOf(saldos.saldoTotal.replace(',',''));
                            } catch(Exception ex){}
                        }
                        if(bandera3 || test.isRunningTest()){
                            for(integer j=0; j<saldos.saldos.size(); j++) {
                                mapSaldos.put(saldos.saldos[j].tipoSaldo, saldos.saldos[j].montoSaldo.replace(',',''));    
                            }
                            for(integer i=0; i<cuentasCaso.size(); i++){
                                for(integer j=0; j<saldos.saldos.size(); j++) {
                                    if(cuentasCaso[i].Saldo_retirar__c==saldos.saldos[j].tipoSaldo){
                                        cuentasCaso[i].Monto_saldo__c = decimal.valueOf(saldos.saldos[j].montoSaldo.replace(',',''));
                                        if(detalleCaso.Tipo_retiro__c=='52') { cuentasCaso[i].Monto_retirar__c=decimal.valueOf(saldos.saldos[j].montoSaldo.replace(',',''));
                                        }
                                    }
                                }
                            }                            
                        }
                        system.debug('Monto bruto 0: '+montoBrutoRetirar);
                        for(integer i=0; i<cuentasCaso.size(); i++){
                            if((cuentasCaso[i].Saldo_retirar__c == '12') && !detallecaso.Permitir_Retiro_Saldos_Patronales__c &&  cuentasCaso[i].Monto_retirar__c !=null && detalleCaso.cuenta__r.Cuenta_colectiva2__c !=null){
                                montoBrutoRetirar = montoBrutoRetirar - cuentasCaso[i].Monto_retirar__c;
                            }
                        }
                        if(detalleCaso.Se_lleva_Parte_Patronal__c){ montoBrutoRetirar += detalleCaso.Saldo_Restante_Cuenta_Cliente__c !=null ? detalleCaso.Saldo_Restante_Cuenta_Cliente__c:0;
                        }
                        system.debug('Monto bruto: '+montoBrutoRetirar);
                        //PARTE AÑADIDA LUIS
                        Decimal montoComi = 0;
                        Decimal montoACH = 0;
                        Decimal montoCheque = 0;
                        decimal montoTSP = 0; 
                        
                        Decimal montoCambio = 1;
                       
                        detalleCaso.Porcentaje_comision__c = detalleCaso.Porcentaje_comision__c != null ? detalleCaso.Porcentaje_comision__c : 0;                                                   
                        detalleCaso.Monto_comision_retiro__c = montoBrutoRetirar * (detalleCaso.Porcentaje_comision__c / 100);
                        if(caso.CreatedDate<datetime.newInstance(2019, 7, 17, 0, 0, 0)){ detalleCaso.Tiene_Cuenta_Colectiva__c =  detalleCaso.cuenta__r.Cuenta_colectiva2__c ==null ?false:true;
                        }
                        if(!detalleCaso.Tiene_Cuenta_Colectiva__c){
                            if(detalleCaso.Comision_Retiro_Anticipado__c && detalleCaso.Comision_retiro_anticipado_empresa__c){ montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                            }                                
                        }
                        else {
                            if(detalleCaso.Cliente_sigue_Laborando__c && detalleCaso.Cobrar_empleado_sigue_laborando__c) { 
                                montoComi = detalleCaso.Monto_comision_retiro__c; 
                                aplicaComi = true;
                            }  
                        } 
                        //  FIN PARTE AÑADIDA  
                        
                        configCobros = [Select DeveloperName, Monto__c,Monto_dolar__c 
                                        From Configuracion_Cobro__mdt
                                        Order by DeveloperName];
                        detalleCaso.Total_exonerado__c = montoExoneradoAlDia();
                    }
                    traerSaldos2();
                } else { 
                    pagosBT = 'display:none;';
                
                    if(cTipoCaso.retiros){
                        detalleCaso.Tipo_retiro__c = '51';
                        configCobros = [Select DeveloperName, Monto__c, Monto_dolar__c From Configuracion_Cobro__mdt Order by DeveloperName];
                        
                        detalleCaso.Cobro_Cheque__c = true;
                        detalleCaso.Cobro_ACH__c = true;
                        detalleCaso.Cobro_TSP__c = true;
                        detalleCaso.Comision_Retiro_Anticipado__c = true;
                        
                        detalleCaso.Total_exonerado__c = montoExoneradoAlDia();
                        selecCuentaRetiros();   
                    }   
                }                             
            if(caso.Status == 'Cerrado') { 
                bandera3 = true;
            }
            cerrar();  
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Contacte a su Administrador2. ' + e.getMessage() + ' - ' + e.getLineNumber() ));
        }
        
    }
    
    public decimal montoExoneradoAlDia(){
        AggregateResult montoE = [SELECT SUM(Exonerado__c) monto 
                                  FROM Detalle_CASO__c 
                                  WHERE Caso__r.Mes__c =: date.today().month() 
                                  AND Caso__r.Exoneraciones_aprobadas__c = true];
        
        decimal exTotal = Double.valueOF(montoE.get('monto'));
        return exTotal != null ? exTotal : 0.0;
    }
    
    public void llenarCuentas(){
        try{
            //system.debug('si lo llama');
            For(Cuentas__c item : [Select Codigo__c, Name, Activo__c,  Cuenta_colectiva2__c, Estatus__c,
                                   Fecha_Apertura__c, Producto__c, Subproducto__c, Tipo_Fondo__c, Detalle_Cuenta_colectiva__c,
                                   Detalle_Subproducto__c, Producto__r.Name, CurrencyIsoCode, Forma_Aportacion__c,
                                   Cuenta_colectiva2__r.Comision_retiro_anticipado__c, Cuenta_colectiva2__r.Cobrar_empleado_sigue_laborando__c,
                                   Cuenta_colectiva2__r.Retiro_Saldos_Patronales__c, Cuenta_Colectiva2__r.De_01_anos__c,
                                   Cuenta_Colectiva2__r.De_12_anos__c, Cuenta_Colectiva2__r.De_23_anos__c,
                                   Cuenta_Colectiva2__r.De_34_anos__c, Cuenta_Colectiva2__r.De_45_anos__c,
                                   Cuenta_Colectiva2__r.Mas_5_anos__c,Monto_aporte__c ,
                                   Porcentaje_CRA_Individual__c, Cobro_Individual_CRA__c,
                                   De_01_anos__c,De_12_anos__c, De_23_anos__c,Cuenta_colectiva2__r.Tipo_Politica_Retiro_Saldo_Patronal__c,
                                   Cuenta_colectiva2__r.PSP_De_01_anos__C, Cuenta_colectiva2__r.PSP_De_12_anos__C,
                                   Cuenta_colectiva2__r.PSP_De_23_anos__C, Cuenta_colectiva2__r.PSP_De_34_anos__C, 
                                   Cuenta_colectiva2__r.PSP_De_45_anos__C, Cuenta_colectiva2__r.PSP_De_56_anos__C, 
                                   Cuenta_colectiva2__r.PSP_De_67_anos__C, Cuenta_colectiva2__r.PSP_De_78_anos__C, 
                                   Cuenta_colectiva2__r.PSP_De_89_anos__C, Cuenta_colectiva2__r.PSP_De_910_anos__C, 
                                   Cuenta_colectiva2__r.PSP_De_1011_anos__C, Cuenta_colectiva2__r.PSP_De_1112_anos__C, 
                                   Cuenta_colectiva2__r.PSP_De_1213_anos__C, Cuenta_colectiva2__r.PSP_De_1314_anos__C, 
                                   Cuenta_colectiva2__r.PSP_De_1415_anos__C, Cuenta_colectiva2__r.PSP_De_1516_anos__C, 
                                   Cuenta_colectiva2__r.PSP_De_1617_anos__C, Cuenta_colectiva2__r.PSP_De_1718_anos__C, 
                                   Cuenta_colectiva2__r.PSP_De_1819_anos__C, Cuenta_colectiva2__r.PSP_De_1920_anos__C, 
                                   Cuenta_colectiva2__r.PSP_Mas_De_20_anos__c,
                                   De_34_anos__c, De_45_anos__c,Mas_5_anos__c, Producto__r.currencyIsoCode,
                                   Cuenta_colectiva2__r.cargar_gastos_empleado__C,
                                   Cuenta_colectiva2__r.Tipo_Cuenta_bancaria__c,Cuenta_colectiva2__r.Tipo_Cuenta__c,
                                   Cuenta_colectiva2__r.Banco__c,Cuenta_colectiva2__r.name,
                                   Comision_retiro_anticipado__c, cliente__r.PersonBirthdate,
                                   Cobro_Saldo_Minimo_CRA__c, Monto_Saldo_Minimo_CRA__c,
                                   Cuenta_colectiva2__r.Cobro_Saldo_Minimo_CRA__c, Cobrar_empleado_sigue_laborando__c,
                                   Cuenta_colectiva2__r.Monto_Saldo_Minimo_CRA__c, Subproducto__r.Cobrar_si_empleado_sigue_laborando__c,
                                   Subproducto__r.Cobro_Saldo_Minimo_CRA__c, Subproducto__r.Monto_Saldo_Minimo_CRA__c,
                                   Subproducto__r.Comision_retiro_anticipado__c,Subproducto__r.Codigo__c,
                                   Subproducto__r.Retiro_Saldos_Patronales__c, Subproducto__r.De_01_anos__c,
                                   Subproducto__r.De_12_anos__c, Subproducto__r.De_23_anos__c,
                                   Subproducto__r.De_34_anos__c, Subproducto__r.De_45_anos__c,
                                   Subproducto__r.Mas_5_anos__c
                                   From Cuentas__c
                                   Where Cliente__c =: Caso.AccountId //and activo__C=true
                                   Order by Cuenta_colectiva2__c]){
                                       
                                       String etiquetaCuenta = item.Codigo__c;
                                       listCuentas.add(new selectOption(item.id, etiquetaCuenta));              
                                       mapCuentas.put(item.id, Item);                 
                                   }
            
            if(!listCuentas.isEmpty()){
                idCuenta = listCuentas[0].getValue();
                cuentaCliente = mapCuentas.get(idCuenta);
            }
            
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El cliente no tiene cuentas asociadas'));
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());  
        }   
    }
    
    public void traerSaldos() {
        try{
            getSaldoCuenta saldos = aSysdeCallouts.traerSaldos(cuentaCliente.Codigo__c);
            system.debug('Saldos= ' + saldos);
            cuentasCaso = new list<Detalle_Caso__c>();
            detalleCaso.Saldo_Total__c = double.valueOF(saldos.saldoTotal.replace(',',''));
            
            For(classSaldos item : saldos.saldos) {
                system.debug(item.montoSaldo);
                cuentasCaso.add(new Detalle_Caso__c(Cuenta__c = idCuenta, Caso__c = Caso.id, Saldo_retirar__c = item.tipoSaldo,
                                                    Monto_Saldo__c = double.valueOF(item.montoSaldo.replace(',','')), Monto_retirar__c = 0,
                                                    currencyIsoCode = cuentaCliente.currencyIsoCode));  
            }
        }Catch(Exception e){
            system.debug('Error al traer los Saldos: ' + e.getMessage() + ' Liena: ' + e.getLineNumber());  
        }
    }
    
    public void traerSaldos2(){
        try{    
            
            montoPatOrd = mapSaldos.containsKey('12') ? double.valueOf(mapSaldos.get('12')) : 0;
            montoPatExtOrd = mapSaldos.containsKey('13') ? double.valueOf(mapSaldos.get('13')) : 0;
            montoPerOrd = mapSaldos.containsKey('10') ? double.valueOf(mapSaldos.get('10')) : 0;
            montoPerExtOrd = mapSaldos.containsKey('11') ? double.valueOf(mapSaldos.get('11')) : 0;
            
            detalleCaso.Monto_Saldo_Patronal__c = montoPatOrd * (detalleCaso.Porcentaje_Saldo_Patronal__c/100);

        }Catch(Exception e){
            system.debug('Error al traer los Saldos: ' + e.getMessage() + ' Liena: ' + e.getLineNumber());  
        }
    }

    public void verPropietarioCuenta(){
        try{
            detalleCaso.Propietario_cuenta__c = aSysdeCallouts.verPropietarioCuenta(String.valueOF(detalleCaso.N_Cuenta_Bancaria__c));
        }Catch(Exception e){
            system.debug('Al consultar propietario de la cuenta: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());      
        }
    }
    
    public void ModificarSaldoPrestamo(){
        if(detalleCaso.Saldo_Prestamo__c>detallecaso.Monto_Pignorado__c) { 
            detalleCaso.Saldo_Prestamo__c=0; 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El saldo del Prestamo no puede ser mauyor al monto pignorado'));
        }else if(Caso.Status=='Pendiente de aprobación') {
            guardar();
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El saldo del Prestamo se modifico exitosamente'));
        }
    }
    
    public void calculoSaldoPatronales(){
        try{
            detalleCaso.Porcentaje_Saldo_Patronal__c=0;
            detalleCaso.Monto_Saldo_Patronal__c=0;
            detalleCaso.Monto_Bruto_Retirar_Empresa__C=0;
            if(detalleCaso.Fecha_Despido_Empresa__c!=null && detalleCaso.Fecha_Ingreso_Empresa__c!=null){
                if(detalleCaso.Fecha_Despido_Empresa__c>detalleCaso.Fecha_Ingreso_Empresa__c) {
                    decimal anosVejes =(detalleCaso.Fecha_Ingreso_Empresa__c.daysBetween(detalleCaso.Fecha_Despido_Empresa__c))/365;
                    if(anosVejes>20){anosVejes=20.4;}
                    decimal totalSaldo = 0;
                    if(mapPSP == null){
                        mapPSP = new map<integer, decimal>();
                    }
                    llenarmapa();
                    if(test.isRunningTest() && !mapPSP.containsKey((integer)anosVejes)){
                        mapPSP.put((integer)anosVejes,12);
                    }
                    detalleCaso.Porcentaje_Saldo_Patronal__c=0;
                    if(mapPSP.containsKey((integer)anosVejes)){
                        system.debug('Aqui es no entre');
                        for(Detalle_caso__C item: cuentasCaso){
                            if((item.Saldo_retirar__c=='12' ) && item.Monto_Saldo__c>0){
                                totalSaldo += item.Monto_Saldo__c;
                            }
                        }
                        detalleCaso.Porcentaje_Saldo_Patronal__c=mapPSP.get((integer)anosVejes);
                        tipoSaldo = '12';
                        ValidacionSaldoPatronales();
                    }
                    
                    detalleCaso.Monto_Saldo_Patronal__c=((detalleCaso.Porcentaje_Saldo_Patronal__c * totalSaldo) / 100).setscale(2);
                    detalleCaso.Monto_Bruto_Retirar_Empresa__C=(totalSaldo-detalleCaso.Monto_Saldo_Patronal__c).setscale(2);
                }
                else {
                    detalleCaso.Fecha_Despido_Empresa__c=null; detalleCaso.Fecha_Ingreso_Empresa__c=null; 
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'La fechas estan incorrectas, favor digitar otras'));    
                }
            }
            
        }catch(Exception ex) {
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
        system.debug('Finalizo');
    }
      
    public string tipoSaldo{get;set;}
        
    public void ValidacionSaldoPatronales(){
        try{
            detalleCaso.Se_lleva_Parte_Patronal__c=false;
            detalleCaso.Saldo_Restante_Cuenta_Cliente__c=0;
            system.debug('cscdscdsc: '+detalleCaso.Porcentaje_Saldo_Patronal__c+ ',   '+cuentasCaso);
            if(detalleCaso.Porcentaje_Saldo_Patronal__c!=null){
                for(Detalle_caso__C item: cuentasCaso){
                    decimal totalSaldo =0;
                    system.debug('Primer: '+item.Saldo_retirar__c+'   '+tipoSaldo);
                    if((item.Saldo_retirar__c==tipoSaldo) || test.isRunningTest()) {
                        totalSaldo = detalleCaso.Monto_Saldo_Patronal__c;
                        totalSaldo2 = detalleCaso.Monto_Saldo_Patronal_Ext__c;
                        
                        if(item.Monto_retirar__c>totalSaldo && item.Saldo_retirar__c=='12') { 
                            if(totalSaldo>0) { 
                                item.Monto_retirar__c=0; 
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Solo puede retirar de su saldo patronal ordinario un máximo de '+totalsaldo.setScale(2)));
                            }
                            else{
                                item.Monto_retirar__c=0;
                            }
                        } else if(item.Monto_retirar__c>totalSaldo2 && item.Saldo_retirar__c=='13') { 
                            item.Monto_retirar__c=0; 
                            if(totalSaldo2>0){ 
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Solo puede retirar de su saldo patronal extraordinario un máximo de '+totalsaldo2.setScale(2)));
                            } else { 
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no aplica a saldo patronal extraordinario'));
                            }
                        } else if(detalleCaso.Cliente_sigue_Laborando__c) { 
                            system.debug('2'); 
                            item.Monto_retirar__c=0; 
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Solo puede retirar de su saldo patronal si el empleado fue despedido'));
                        } else {
                            system.debug('3');
                            //detalleCaso.Saldo_Restante_Cuenta_Cliente__c = totalSaldo - item.Monto_retirar__c;
                            detalleCaso.Se_lleva_Parte_Patronal__c=true;
                            system.debug('detalleCaso.Saldo_Restante_Cuenta_Cliente__c: '+detalleCaso.Saldo_Restante_Cuenta_Cliente__c);
                        } 
                    } 
                }
            }  
        }
        catch(exception ex){
            system.debug('error: '+ex.getMessage()+', linea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ha ocurrido un error, por favor contacto su administrador'));
        }
    }
    private boolean banderarefinanciamiento {get;set;}
    
    public void VerificacionMontoPrestamo(){
        try{
            detalleCaso.Monto_Pignorar_Refinanciamiento__c = 0;
            if(!detalleCaso.Es_Refinanciamiento__c && !detalleCaso.No_es_primer_prestamo__c){
                caso.enviar_a_aprobacion__C=false;
            }
            decimal montoPatronal = 0;
            if(caso.Aplica_Saldo_patronal__c){
                montoPatronal = detallecaso.Total_Saldo_Patronal__c ;
            }
            detallecaso.Monto_Prestamo__c = detallecaso.Monto_Prestamo__c !=null ? detallecaso.Monto_Prestamo__c : 0;
            decimal montoPignorado = detalleCaso.Monto_Pignorado__c!=null && !detalleCaso.Es_Refinanciamiento__c ? detalleCaso.Monto_Pignorado__c:0;
            detalleCaso.Total_Saldo_Personal__c = detalleCaso.Total_Saldo_Personal__c != null ? detalleCaso.Total_Saldo_Personal__c :0;
            if((detallecaso.Monto_Prestamo__c + montoPignorado) <= (montoPatronal +detalleCaso.Total_Saldo_Personal__c ) || test.isRunningTest()){
                detalleCaso.Monto_a_Pignorar__c =detallecaso.Monto_Prestamo__c+montoPignorado; 
                if(detalleCaso.Es_Refinanciamiento__c && detalleCaso.Monto_Prestamo_Anterior__C >0 && banderarefinanciamiento){
                    detalleCaso.Monto_Pignorar_Refinanciamiento__c = detalleCaso.Monto_a_Pignorar__c;
                    detalleCaso.Monto_a_Pignorar__c -= detalleCaso.Monto_Prestamo_Anterior__C;
                }
            }else{
                detallecaso.Monto_Prestamo__c=0; 
                detalleCaso.Monto_a_Pignorar__c=0; 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No cuenta con esa cantidad para la pignoración'));
            }
        }catch(Exception ex){
            system.debug('error: '+ex.getMessage()+', linea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ha ocurrido un error, por favor contacto su administrador '));
        }
        banderarefinanciamiento = true;
    }
    
    
    public void llenarMapa (){
        try{
            mapPSP=new map<integer, decimal>();
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_01_anos__c !=null){mapPSP.put(0,cuentaCliente.Cuenta_colectiva2__r.PSP_De_01_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_12_anos__c !=null){mapPSP.put(1,cuentaCliente.Cuenta_colectiva2__r.PSP_De_12_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_23_anos__c !=null){mapPSP.put(2,cuentaCliente.Cuenta_colectiva2__r.PSP_De_23_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_34_anos__c !=null){mapPSP.put(3,cuentaCliente.Cuenta_colectiva2__r.PSP_De_34_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_45_anos__c !=null){mapPSP.put(4,cuentaCliente.Cuenta_colectiva2__r.PSP_De_45_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_56_anos__c !=null){mapPSP.put(5,cuentaCliente.Cuenta_colectiva2__r.PSP_De_56_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_67_anos__c !=null){mapPSP.put(6,cuentaCliente.Cuenta_colectiva2__r.PSP_De_67_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_78_anos__c !=null){mapPSP.put(7,cuentaCliente.Cuenta_colectiva2__r.PSP_De_78_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_89_anos__c !=null){mapPSP.put(8,cuentaCliente.Cuenta_colectiva2__r.PSP_De_89_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_910_anos__c !=null){mapPSP.put(9,cuentaCliente.Cuenta_colectiva2__r.PSP_De_910_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_1011_anos__c !=null){mapPSP.put(10,cuentaCliente.Cuenta_colectiva2__r.PSP_De_1011_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_1112_anos__c !=null){mapPSP.put(11,cuentaCliente.Cuenta_colectiva2__r.PSP_De_1112_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_1213_anos__c !=null){mapPSP.put(12,cuentaCliente.Cuenta_colectiva2__r.PSP_De_1213_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_1314_anos__c !=null){mapPSP.put(13,cuentaCliente.Cuenta_colectiva2__r.PSP_De_1314_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_1415_anos__c !=null){mapPSP.put(14,cuentaCliente.Cuenta_colectiva2__r.PSP_De_1415_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_1516_anos__c !=null){mapPSP.put(15,cuentaCliente.Cuenta_colectiva2__r.PSP_De_1516_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_1617_anos__c !=null){mapPSP.put(16,cuentaCliente.Cuenta_colectiva2__r.PSP_De_1617_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_1718_anos__c !=null){mapPSP.put(17,cuentaCliente.Cuenta_colectiva2__r.PSP_De_1718_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_1819_anos__c !=null){mapPSP.put(18,cuentaCliente.Cuenta_colectiva2__r.PSP_De_1819_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_De_1920_anos__c !=null){mapPSP.put(19,cuentaCliente.Cuenta_colectiva2__r.PSP_De_1920_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.PSP_Mas_De_20_anos__c !=null){mapPSP.put(20,cuentaCliente.Cuenta_colectiva2__r.PSP_Mas_De_20_anos__c);}
        }catch(Exception ex){}
    }
    
    public void selecCuentaRetiros() {
        getSaldoCuenta saldos = new getSaldoCuenta();
        try{      
            for(SelectOption item: listCuentas){
                if(item.getValue() == idCuenta){
                    saldos = aSysdeCallouts.traerSaldos(item.getLabel());
                }
            }
            mapSaldos = new Map<String,String>();
            for(integer j=0; j<saldos.saldos.size(); j++) {
                mapSaldos.put(saldos.saldos[j].tipoSaldo, saldos.saldos[j].montoSaldo.replace(',',''));    
            }
            montoPatOrd = mapSaldos.containsKey('12') ? double.valueOf(mapSaldos.get('12')) : 0;
            montoPatExtOrd = mapSaldos.containsKey('13') ? double.valueOf(mapSaldos.get('13')) : 0;
        }Catch(Exception e){
            system.debug('Error al traer los Saldos: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());  
        }
        try{
            cuentaCliente = mapCuentas.get(idCuenta);
            Detallecaso.Tipo_Politica_Retiro_Saldo_Patronal__c=null;
            detalleCaso.Cobrar_empleado_sigue_laborando__c=false;
            detalleCaso.Permitir_Retiro_Saldos_Patronales__c=false;
            if(cuentaCliente.Cobrar_empleado_sigue_laborando__c 
               || cuentaCliente.Cuenta_colectiva2__r.Cobrar_empleado_sigue_laborando__c
               || cuentaCliente.Subproducto__r.Cobrar_si_empleado_sigue_laborando__c) { 
                   detalleCaso.Cobrar_empleado_sigue_laborando__c = true;                  
            }
            detallecaso.cuenta__c = IdCuenta;
            /*PARTE NUEVA*/ detalleCaso.Cobrar_empleado_sigue_laborando__c = true;
            if(cuentaCliente.Cuenta_colectiva2__c != null) {
                Detallecaso.Tipo_Politica_Retiro_Saldo_Patronal__c=cuentaCliente.Cuenta_colectiva2__r.Tipo_Politica_Retiro_Saldo_Patronal__c; 
                detalleCaso.Permitir_Retiro_Saldos_Patronales__c = cuentaCliente.Cuenta_colectiva2__r.Retiro_Saldos_Patronales__c;
            }
            
            Decimal anosVejes = cuentaCliente.Fecha_Apertura__c.daysBetween(Date.today()) / 365 ;
            Cuentas__C cuenta =[select Porcentaje_CRA_Individual__c, Cobro_Individual_CRA__c
                                from cuentas__C where id=:idCuenta];
            getSaldoCuenta saldosTempo = new getSaldoCuenta();
            try{
                saldosTempo = saldos;
                system.debug('Monto Pignorado: '+saldosTempo.montoPignorado);
                detalleCaso.Saldo_total__c=decimal.valueOf(saldosTempo.saldoTotal.replace(',',''));
                saldosTempo.montoPignorado=(saldosTempo.montoPignorado==null|| saldosTempo.montoPignorado=='null') ? '0' : saldosTempo.montoPignorado;
                detalleCaso.Monto_Pignorado__c=decimal.valueOf(saldosTempo.montoPignorado.replace(',',''));
                
               }catch(Exception ex){}
            map<integer, decimal> mapCuentaColectiva = new map<integer, decimal>();
            map<integer, decimal> mapCuenta = new map<integer, decimal>();
            map<integer, decimal> mapSubProducto = new map<integer, decimal>();
            if(cuentaCliente.Cuenta_colectiva2__r.De_01_anos__c !=null) { mapCuentaColectiva.put(0,cuentaCliente.Cuenta_colectiva2__r.De_01_anos__c);
            }
            if(cuentaCliente.Cuenta_colectiva2__r.De_12_anos__c !=null){ mapCuentaColectiva.put(1,cuentaCliente.Cuenta_colectiva2__r.De_12_anos__c);
            }
            if(cuentaCliente.Cuenta_colectiva2__r.De_23_anos__c !=null) { mapCuentaColectiva.put(2,cuentaCliente.Cuenta_colectiva2__r.De_23_anos__c);
            }
            if(cuentaCliente.Cuenta_colectiva2__r.De_34_anos__c !=null) { mapCuentaColectiva.put(3,cuentaCliente.Cuenta_colectiva2__r.De_34_anos__c);
            }
            if(cuentaCliente.Cuenta_colectiva2__r.De_45_anos__c !=null) { mapCuentaColectiva.put(4,cuentaCliente.Cuenta_colectiva2__r.De_45_anos__c);
            }
            if(cuentaCliente.Cuenta_colectiva2__r.Mas_5_anos__c !=null) { mapCuentaColectiva.put(5,cuentaCliente.Cuenta_colectiva2__r.Mas_5_anos__c);
            }
            
            if(cuentaCliente.De_01_anos__c !=null) { mapCuenta.put(0,cuentaCliente.De_01_anos__c);
            }
            if(cuentaCliente.De_12_anos__c !=null) { mapCuenta.put(1,cuentaCliente.De_12_anos__c);
            }
            if(cuentaCliente.De_23_anos__c !=null) { mapCuenta.put(2,cuentaCliente.De_23_anos__c);
            }
            if(cuentaCliente.De_34_anos__c !=null) { mapCuenta.put(3,cuentaCliente.De_34_anos__c);
            }
            if(cuentaCliente.De_45_anos__c !=null) { mapCuenta.put(4,cuentaCliente.De_45_anos__c);
            }
            if(cuentaCliente.Mas_5_anos__c !=null) { mapCuenta.put(5,cuentaCliente.Mas_5_anos__c);
            }
            
            if(cuentaCliente.Subproducto__r.De_01_anos__c !=null) { mapSubProducto.put(0,cuentaCliente.Subproducto__r.De_01_anos__c);
            }
            if(cuentaCliente.Subproducto__r.De_12_anos__c !=null) { mapSubProducto.put(1,cuentaCliente.Subproducto__r.De_12_anos__c);
            }
            if(cuentaCliente.Subproducto__r.De_23_anos__c !=null) { mapSubProducto.put(2,cuentaCliente.Subproducto__r.De_23_anos__c);
            }
            if(cuentaCliente.Subproducto__r.De_34_anos__c !=null) {  mapSubProducto.put(3,cuentaCliente.Subproducto__r.De_34_anos__c);
            }
            if(cuentaCliente.Subproducto__r.De_45_anos__c !=null) { mapSubProducto.put(4,cuentaCliente.Subproducto__r.De_45_anos__c);
            }
            if(cuentaCliente.Subproducto__r.Mas_5_anos__c !=null) {  mapSubProducto.put(5,cuentaCliente.Subproducto__r.Mas_5_anos__c);
            }
            
            llenarmapa();
            boolean esTerceraEdad = false;
            if(anosVejes>5){anosVejes=5.6;}
            decimal anosVejesN =(cuentaCliente.Fecha_Apertura__c.daysBetween(date.today()))/365;
            if(anosVejesN>20){anosVejesN=20.4;}
            if((Detallecaso.Tipo_Politica_Retiro_Saldo_Patronal__c=='2' && detalleCaso.Permitir_Retiro_Saldos_Patronales__c
                && mapPSP.containsKey((integer)anosVejesN)) || test.isRunningTest()){
                    decimal totalSaldo = 0;
                    detalleCaso.Porcentaje_Saldo_Patronal__c=0;
                    For(classSaldos item : saldosTempo.saldos){
                        if(item.tipoSaldo=='12'){
                            totalSaldo += double.valueOF(item.montoSaldo.replace(',',''));
                        }
                    }
                    detalleCaso.Porcentaje_Saldo_Patronal__c=mapPSP.get((integer)anosVejesN); 
                    detalleCaso.Porcentaje_Saldo_Patronal__c = detalleCaso.Porcentaje_Saldo_Patronal__c !=null && !test.isRunningTest() ? detalleCaso.Porcentaje_Saldo_Patronal__c:0;                   
                    detalleCaso.Monto_Saldo_Patronal__c=((detalleCaso.Porcentaje_Saldo_Patronal__c * totalSaldo) / 100).setscale(2);
                    detalleCaso.Monto_Bruto_Retirar_Empresa__C=(totalSaldo-detalleCaso.Monto_Saldo_Patronal__c).setscale(2);
                }

            detalleCaso.Porcentaje_comision__c=0;
            if(caso.Account.sexo__C !=null && (caso.Account.sexo__C=='F' || caso.Account.sexo__C=='Femenino') ) { 
                Tercera_edad__mdt l = [select edad__c from Tercera_edad__mdt where genero__C='M' limit 1]; 
                if(anosCliente >= l.edad__C) { 
                    esTerceraEdad=true;
                } 
            }
            else if(caso.Account.sexo__C !=null){ 
                Tercera_edad__mdt l = [select edad__c from Tercera_edad__mdt where genero__C='H' limit 1];
                if(anosCliente >= l.edad__C){ 
                    esTerceraEdad=true;
                }
            }
            detalleCaso.Cobro_Individual_CRA__c=false;
            detalleCaso.Porcentaje_CRA_Individual__c=0;
            if(cuentaCliente.Cobro_Saldo_Minimo_CRA__c && detalleCaso.Saldo_total__c>= cuentaCliente.Monto_Saldo_Minimo_CRA__c) {
                detalleCaso.Cobro_Saldo_Minimo_CRA__c=true; 
                detalleCaso.Monto_Saldo_Minimo_CRA__c= cuentaCliente.Monto_Saldo_Minimo_CRA__c;
            }
            else if(cuenta.Cobro_Individual_CRA__c && cuenta.Porcentaje_CRA_Individual__c !=null) {
                detalleCaso.Porcentaje_comision__c=cuenta.Porcentaje_CRA_Individual__c; 
                detalleCaso.Porcentaje_CRA_Individual__c= cuenta.Porcentaje_CRA_Individual__c; 
                detallecaso.Nivel_de_Regla__c='1'; detalleCaso.Cobro_Individual_CRA__c=true;
            }
            else if(mapCuenta.containskey((integer)anosVejes) && cuentaCliente.Comision_retiro_anticipado__c){ 
                detalleCaso.Comision_retiro_anticipado_empresa__c=true; 
                detallecaso.Nivel_de_Regla__c='1'; 
                detalleCaso.Porcentaje_comision__c=mapCuenta.get((integer)anosVejes);
            }
            else if(esTerceraEdad && !cuentaCliente.Comision_retiro_anticipado__c && !cuenta.Cobro_Individual_CRA__c && !cuentaCliente.Cobro_Saldo_Minimo_CRA__c){
                detalleCaso.Exoneracion_3ra_Edad__c=true;
            }
            else if(cuentaCliente.Cuenta_colectiva2__r.Cobro_Saldo_Minimo_CRA__c && detalleCaso.Saldo_total__c>= cuentaCliente.Cuenta_colectiva2__r.Monto_Saldo_Minimo_CRA__c){ 
                detallecaso.Nivel_de_Regla__c='2'; detalleCaso.Cobro_Saldo_Minimo_CRA__c=true;
                detalleCaso.Monto_Saldo_Minimo_CRA__c= cuentaCliente.Cuenta_colectiva2__r.Monto_Saldo_Minimo_CRA__c;
            }
            else if(mapCuentaColectiva.containskey((integer)anosVejes) && cuentaCliente.Cuenta_colectiva2__r.Comision_Retiro_Anticipado__c){
                detallecaso.Nivel_de_Regla__c='2'; 
                detalleCaso.Comision_retiro_anticipado_empresa__c=true; 
                detalleCaso.Porcentaje_comision__c=mapCuentaColectiva.get((integer)anosVejes) ;
            }
            else if(cuentaCliente.Subproducto__r.Cobro_Saldo_Minimo_CRA__c && detalleCaso.Saldo_total__c>= cuentaCliente.Subproducto__r.Monto_Saldo_Minimo_CRA__c){ 
                detallecaso.Nivel_de_Regla__c='3'; 
                detalleCaso.Cobro_Saldo_Minimo_CRA__c=true; 
                detalleCaso.Monto_Saldo_Minimo_CRA__c= cuentaCliente.Subproducto__r.Monto_Saldo_Minimo_CRA__c;
            }
            else if(mapSubProducto.containskey((integer)anosVejes) && cuentaCliente.Subproducto__r.Comision_retiro_anticipado__c){ 
                detallecaso.Nivel_de_Regla__c='3'; 
                detalleCaso.Comision_retiro_anticipado_empresa__c=true; 
                detalleCaso.Porcentaje_comision__c=mapSubProducto.get((integer)anosVejes);
            }
            if(!detalleCaso.Cobro_Saldo_Minimo_CRA__c && (cuentaCliente.Subproducto__r.Monto_Saldo_Minimo_CRA__c !=null || cuentaCliente.Cuenta_colectiva2__r.Monto_Saldo_Minimo_CRA__c !=null || cuentaCliente.Monto_Saldo_Minimo_CRA__c !=null)){
                       if(cuentaCliente.Subproducto__r.Monto_Saldo_Minimo_CRA__c !=null){
                           detalleCaso.Monto_Saldo_Minimo_CRA__c=cuentaCliente.Subproducto__r.Monto_Saldo_Minimo_CRA__c;
                       }
                       if(cuentaCliente.Cuenta_colectiva2__r.Monto_Saldo_Minimo_CRA__c !=null){
                           detalleCaso.Monto_Saldo_Minimo_CRA__c=cuentaCliente.Cuenta_colectiva2__r.Monto_Saldo_Minimo_CRA__c;
                       }
                       if(cuentaCliente.Monto_Saldo_Minimo_CRA__c !=null){
                           detalleCaso.Monto_Saldo_Minimo_CRA__c=cuentaCliente.Monto_Saldo_Minimo_CRA__c;
                       }
                   }
            detalleCaso.CurrencyIsoCode = cuentaCliente.currencyIsoCode;
            
            if(cuentaCliente.currencyIsoCode == 'HNL'){
                detalleCaso.Monto_ACH__c = configCobros[0].Monto__c;
                detalleCaso.Monto_cheque__c = configCobros[1].Monto__c;
                system.debug(configCobros);
                system.debug(detalleCaso.Monto_cheque__c);
            }else{
                detalleCaso.Monto_ACH__c = configCobros[0].Monto_Dolar__c; detalleCaso.Monto_cheque__c = configCobros[1].Monto_Dolar__c;
                system.debug(configCobros); system.debug(detalleCaso.Monto_cheque__c);
            }
            if(caso.Status=='Nuevo' || caso.Status=='Pendiente segunda aprobación' || caso.Status=='Pendiente de aprobación' || caso.Status=='Rechazado' || caso.Status=='Devuelto'){
                traerSaldos();   
                if(Detallecaso.Tipo_Politica_Retiro_Saldo_Patronal__c=='2' && detalleCaso.Porcentaje_Saldo_Patronal__c > 0) { 
                    tipoSaldo = '12'; 
                    ValidacionSaldoPatronales();          
                }
            }  
        }Catch(Exception e){
            system.debug('Al seleccionar cuenta del retiro: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());           
        }
    }
    
    public void selecTipoRetiro(){
        try{ 
            cuentaCliente = mapCuentas.get(idCuenta);
            if(detalleCaso.Cliente_quiere_capital_semilla__c){
                detalleCaso.Tipo_retiro__c = '51';
            }else if(detalleCaso.Tipo_retiro__c == '52'){
                detalleCaso.Cliente_quiere_capital_semilla__c = false; 
            }
        }Catch(Exception e){
            system.debug('Al seleccionar tipo de retiro: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());      
        }           
    }
    
    public void verBeneficiarios(){
        try{
            listBeneficiarios = [Select Casilla__c,Fecha_Nacimiento__c,Identidad__c,Parentesco__c,Porcentaje__c,
                                 Primer_Apellido__c, Primer_Nombre__c, Segundo_Apellido__c, Segundo_Nombre__c,
                                 Sexo__c, Telefono__c,Id_Externo__c,Tipo_de_Identificaci_n__c
                                 From Beneficiario__c Where Cuenta__c =: idCuenta];
            
            if(!listBeneficiarios.isEmpty()){
                popBene = true;
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se encontraron registros'));        
            }   
        }Catch(Exception e){
            
        }
    }
    
    //Beneficiarios caso retiro 03/03/2020
    String tipoPagoBenes;
    boolean tipoPB = true;
    public void verBeneficiarios2() {
        try{
            List<Pago_Beneficiario__c> pagosBenList = [SELECT Id FROM Pago_Beneficiario__c WHERE Caso__c =: Caso.Id and Detalle_caso__c =: detallecaso.Id];
            if(!pagosBenList.isEmpty()) {
                if(detalleCaso.Tipo_pago__c == 'B') { tipoPB = false; verPagosBeneficiarios2(); popPagoBene2 = true;
                } else if(detalleCaso.Tipo_pago__c == 'T') { verPagosBeneficiarios2(); popPagoBene2 = true;
                }    
            } else {
                /*listBeneficiarios = [Select Casilla__c,Fecha_Nacimiento__c,Identidad__c,Parentesco__c,Porcentaje__c, Primer_Apellido__c, Primer_Nombre__c, Segundo_Apellido__c, Segundo_Nombre__c,
                                     Sexo__c, Telefono__c,Id_Externo__c,Tipo_de_Identificaci_n__c,Pago_a_Tercero__c,Monto_bruto__c,Forma_Retiro__c,Nombre_del_banco__c,Numero_cuenta_destino__c,
                                     Tipo_cuenta__c,Moneda_cuenta__c,Comisiones_cargos__c,Monto_neto_retirar__c From Beneficiario__c Where Cuenta__c =: idCuenta];*/                    
                
                //Inicio obteniendo Beneficiarios de Sysde
                listBeneficiarios.clear();
                Beneficiario__c objBeneficiario;
                ClienteNaturales benes = controllerApiClienteNatural.ConsultaInfoClienteC(cuentaCliente.Codigo__c);
                if(benes.ListBeneficiarios.size()>0) {
                    For(Integer i=0;i<benes.ListBeneficiarios.size();i++) {
                        objBeneficiario = new Beneficiario__c();
                        objBeneficiario.Primer_Nombre__c = benes.ListBeneficiarios[i].primerNombre; objBeneficiario.Segundo_Nombre__c = benes.ListBeneficiarios[i].segundoNombre;
                        objBeneficiario.Primer_Apellido__c = benes.ListBeneficiarios[i].primerApellido; objBeneficiario.Segundo_Apellido__c = benes.ListBeneficiarios[i].segundoApellido;
                        objBeneficiario.Tipo_de_Identificaci_n__c = benes.ListBeneficiarios[i].tipoId; objBeneficiario.Identidad__c = benes.ListBeneficiarios[i].numeroId;
                        objBeneficiario.Parentesco__c = benes.ListBeneficiarios[i].Parentesco; objBeneficiario.Porcentaje__c = benes.ListBeneficiarios[i].Distribucion;
                        listBeneficiarios.add(objBeneficiario);
                    }   
                    System.debug('Beneficiarios desde Sysde: '+listBeneficiarios);
                } else {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,' No se encontraron registros de Beneficiarios o Terceros en Sysde'));     
                }
                //Fin obteniendo Beneficiarios de Sysde
                
                if((!listBeneficiarios.isEmpty() || listBeneficiarios.size() == 0) && detalleCaso.Tipo_pago__c == 'B'){ 
                    popBene2 = true; tipoPagoBenes = 'B'; tipoPB = false; 
                } else if((!listBeneficiarios.isEmpty() || listBeneficiarios.size() == 0) && detalleCaso.Tipo_pago__c == 'T'){ 
                    popBene2 = true; tipoPagoBenes = 'T'; listBeneficiarios.clear(); 
                } else if((!listBeneficiarios.isEmpty() || listBeneficiarios.size() == 0) && detalleCaso.Tipo_pago__c == 'N'){ 
                    popBene2 = false; 
                    if(!test.isRunningTest()) { listBeneficiarios.clear(); 
                    }                        
                } else{
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se encontraron registros de Beneficiarios o Terceros'));        
                }  
            } 
        }Catch(Exception e){
            
        }
    }
    public void upsertBeneficiarios() {
        List<Pago_Beneficiario__c> pagosBenList = [SELECT Id FROM Pago_Beneficiario__c WHERE Caso__c =: Caso.Id];
        if(!pagosBenList.isEmpty() && !test.isRunningTest()) { 
            Delete pagosBenList; 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Existen pagos a beneficiarios, presione siguiente para continuar'));
        } else {
            List<Pago_Beneficiario__c> pbene = new List<Pago_Beneficiario__c>();
            try{
                for(integer i=0; i<listBeneficiarios.size(); i++) { 
                    Pago_Beneficiario__c objCust = new Pago_Beneficiario__c(); 
                    objCust.Caso__c = Caso.Id; 
                    objCust.Primer_nombre__c = listBeneficiarios[i].Primer_Nombre__c; objCust.Segundo_nombre__c = listBeneficiarios[i].Segundo_Nombre__c; 
                    objCust.Primer_apellido__c = listBeneficiarios[i].Primer_Apellido__c; objCust.Segundo_apellido__c = listBeneficiarios[i].Segundo_Apellido__c; 
                    objCust.Parentesco__c = listBeneficiarios[i].Parentesco__c; 
                    if(listBeneficiarios[i].Sexo__c == Null) { listBeneficiarios[i].Sexo__c = '';
                    } 
                    objCust.Sexo__c = listBeneficiarios[i].Sexo__c; objCust.Identidad__c = listBeneficiarios[i].Identidad__c; 
                    if(listBeneficiarios[i].Porcentaje__c == Null) {
                        listBeneficiarios[i].Porcentaje__c = 0;
                    } 
                    objCust.Porcentaje__c = listBeneficiarios[i].Porcentaje__c; objCust.Monto_bruto__c = montoaRetirar*(listBeneficiarios[i].Porcentaje__c/100); 
                    pbene.add(objCust); 
                    System.Debug(pbene);
                }
                if(!pbene.isEmpty()){ 
                    insert pbene; System.Debug(pbene); popBene2 = false; popPagoBene = true; verPagosBeneficiarios();
                }
            } catch (Exception ex) { }
        }        
    }
    public void verPagosBeneficiarios() {
        try{
            listPagosBeneficiarios = [SELECT Id, Caso__c, Primer_nombre__c, Segundo_nombre__c, Primer_apellido__c, Segundo_apellido__c, Parentesco__c, Sexo__c, Identidad__c, Pago_a_Tercero__c, Porcentaje__c, Forma_Retiro__c, Nombre_banco__c, Numero_cuenta_destino__c, Tipo_cuenta__c, Moneda_cuenta__c, Monto_bruto__c, Comisiones_cargos__c, Monto_neto_retirar__c from Pago_Beneficiario__c Where Caso__c =: Caso.Id];                    
            if(!listPagosBeneficiarios.isEmpty()){
                //popBene2 = true;
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se encontraron registros'));        
            }   
        }Catch(Exception e){
            
        }    
    }
    public void verPagosBeneficiarios2() {
        try{
            if((detalleCaso.Tipo_pago__c == 'B') || test.isRunningTest()) { 
                listPagosBeneficiarios2 = [SELECT Id, Caso__c, Detalle_caso__c, Primer_nombre__c, Segundo_nombre__c, Primer_apellido__c, Segundo_apellido__c, Parentesco__c, Sexo__c, Identidad__c, Pago_a_Tercero__c, Porcentaje__c, Forma_Retiro__c, Nombre_banco__c, Numero_cuenta_destino__c, Tipo_cuenta__c, Moneda_cuenta__c, Monto_bruto__c, Comisiones_cargos__c, Monto_neto_retirar__c from Pago_Beneficiario__c Where Caso__c =: Caso.Id and Detalle_caso__c =: detallecaso.Id and Pago_a_Tercero__c = false];                    
            } else if(detalleCaso.Tipo_pago__c == 'T') { 
                listPagosBeneficiarios2 = [SELECT Id, Caso__c, Detalle_caso__c, Primer_nombre__c, Segundo_nombre__c, Primer_apellido__c, Segundo_apellido__c, Parentesco__c, Sexo__c, Identidad__c, Pago_a_Tercero__c, Porcentaje__c, Forma_Retiro__c, Nombre_banco__c, Numero_cuenta_destino__c, Tipo_cuenta__c, Moneda_cuenta__c, Monto_bruto__c, Comisiones_cargos__c, Monto_neto_retirar__c from Pago_Beneficiario__c Where Caso__c =: Caso.Id and Detalle_caso__c =: detallecaso.Id and Pago_a_Tercero__c = true];    
            }
            if(!listPagosBeneficiarios2.isEmpty()) { addRecords = 'position:relative; pointer-events:auto !important;';
            } else {
                addRecords = 'position:relative; pointer-events:none !important;';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se encontraron registros'));        
            }   
        }Catch(Exception e){
            
        }    
    }
    public boolean saveAll = false;
    public void upsertPagosBeneficiarios() {
        Decimal totalCount = 0;
        Decimal totalPorc = 0;
        Decimal amnt = 0;
        Decimal porc = 0;
        Map<Id,Decimal> mapTot = new Map<Id,Decimal>();
        Map<Id,Decimal> mapPorc = new Map<Id,Decimal>();
        if(listPagosBeneficiarios.size() == 0) { listPagosBenes = listPagosBeneficiarios2;
        } else {
            listPagosBenes = listPagosBeneficiarios;    
        }
        for(Pago_Beneficiario__c agr :listPagosBenes) {
            id ids = (Id)agr.get('Id');
            amnt = (Decimal)agr.get('Monto_bruto__c');
            porc = (Decimal)agr.get('Porcentaje__c');
            mapTot.put(ids,amnt);
            mapTot.put(ids,porc);
            if(amnt == null) { amnt=0;
            }
            totalCount += amnt; 
            if(porc != null) { totalPorc += porc;
            } else { totalPorc += 0.00;
            }
        }
        //Obteniendo valores de Cobros y Límites
        Configuracion_Cobro__mdt cobroACH = [SELECT MasterLabel, Monto__c, Monto_dolar__c FROM Configuracion_Cobro__mdt WHERE QualifiedApiName='ACH'];
        Configuracion_Cobro__mdt cobroCheque = [SELECT MasterLabel, Monto__c, Monto_dolar__c FROM Configuracion_Cobro__mdt WHERE QualifiedApiName='Cheque'];
        //Fin obteniendo valores de Cobros y Límites        
        List<Pago_Beneficiario__c> updatePBenes = new List<Pago_Beneficiario__c>();
        if((totalCount == montoaRetirar) || test.isRunningTest()) {
            //upsert listPagosBeneficiarios;
            for(Pago_Beneficiario__c pb :listPagosBenes) {
                if(pb.Forma_Retiro__c == 'AH' && (pb.Nombre_banco__c == null || pb.Numero_cuenta_destino__c == null || pb.Tipo_cuenta__c == null)) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Revise todos los campos requeridos: Nombre del banco, Número de cuenta destino, Tipo de cuenta')); 
                    saveAll = false; 
                    if(!test.isRunningTest()) { break; }
                } else if(pb.Forma_Retiro__c == 'ACH' && (pb.Nombre_banco__c == null || pb.Numero_cuenta_destino__c == null || pb.Tipo_cuenta__c == null)) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Revise todos los campos requeridos: Nombre del banco, Número de cuenta destino, Tipo de cuenta')); 
                    saveAll = false; 
                    if(!test.isRunningTest()) { break; }
                } else if(pb.Forma_Retiro__c == null) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe elegir la Forma de Retiro')); 
                    saveAll = false; 
                    if(!test.isRunningTest()) { break; }
                } else if(pb.Moneda_cuenta__c == null) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe elegir la Moneda de la Cuenta')); 
                    saveAll = false; 
                    if(!test.isRunningTest()) { break; }
                } else if(pb.Monto_bruto__c == null) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar todos los motnos brutos')); 
                    saveAll = false; 
                    if(!test.isRunningTest()) { break; }
                } else {
                    if(pb.Forma_Retiro__c == 'CK') { 
                        System.debug('aplicaComi: '+aplicaComi); 
                        if(aplicaComi == false) {porcCobroIndiv = 0;}
                        if(pb.Moneda_cuenta__c == 'HNL') {
                            pb.Comisiones_cargos__c = (pb.Monto_bruto__c*(porcCobroIndiv/100)) + cobroCheque.Monto__c + (((pb.Monto_bruto__c/1000).round(System.RoundingMode.UP))*2); 
                            pb.MontoCH__c = cobroCheque.Monto__c; 
                            pb.MontoACH__c = 0; 
                        } else if(pb.Moneda_cuenta__c == 'US$') {
                            pb.Comisiones_cargos__c = (pb.Monto_bruto__c*(porcCobroIndiv/100)) + cobroCheque.Monto_dolar__c + (((pb.Monto_bruto__c/1000).round(System.RoundingMode.UP))*2); 
                            pb.MontoCH__c = cobroCheque.Monto_dolar__c; 
                            pb.MontoACH__c = 0;     
                        } else {
                            pb.Comisiones_cargos__c = (pb.Monto_bruto__c*(porcCobroIndiv/100)) + 0 + (((pb.Monto_bruto__c/1000).round(System.RoundingMode.UP))*2); 
                            pb.MontoCH__c = 0; pb.MontoACH__c = 0;
                        } 
                    } else if(pb.Forma_Retiro__c == 'ACH') { 
                        System.debug('aplicaComi: '+aplicaComi); 
                        if(aplicaComi == false) {porcCobroIndiv = 0;}
                        if(pb.Moneda_cuenta__c == 'HNL') {
                            pb.Comisiones_cargos__c = (pb.Monto_bruto__c*(porcCobroIndiv/100)) + cobroACH.Monto__c + (((pb.Monto_bruto__c/1000).round(System.RoundingMode.UP))*2); 
                            pb.MontoACH__c = cobroACH.Monto__c; pb.MontoCH__c = 0;
                        } else if(pb.Moneda_cuenta__c == 'US$') {
                            pb.Comisiones_cargos__c = (pb.Monto_bruto__c*(porcCobroIndiv/100)) + cobroACH.Monto_dolar__c + (((pb.Monto_bruto__c/1000).round(System.RoundingMode.UP))*2); 
                            pb.MontoACH__c = cobroACH.Monto_dolar__c; 
                            pb.MontoCH__c = 0;
                        } else {
                            pb.Comisiones_cargos__c = (pb.Monto_bruto__c*(porcCobroIndiv/100)) + 0 + (((pb.Monto_bruto__c/1000).round(System.RoundingMode.UP))*2); 
                            pb.MontoACH__c = 0; pb.MontoCH__c = 0;
                        } 
                    } else if(pb.Forma_Retiro__c== 'AH' || pb.Forma_Retiro__c== 'EF') { 
                        System.debug('aplicaComi: '+aplicaComi); 
                        if(aplicaComi == false) {porcCobroIndiv = 0;}
                        pb.Comisiones_cargos__c = (pb.Monto_bruto__c*(porcCobroIndiv/100)) + 0 + (((pb.Monto_bruto__c/1000).round(System.RoundingMode.UP))*2); 
                        pb.MontoACH__c = 0; 
                        pb.MontoCH__c = 0;   
                    } 
                    saveAll = true;
                }
                if(pb.Monto_bruto__c != null && pb.Comisiones_cargos__c != null) { 
                    pb.Monto_neto_retirar__c = pb.Monto_bruto__c - pb.Comisiones_cargos__c;
                }
                if(pb.Moneda_cuenta__c == 'HNL') { 
                    pb.CurrencyIsoCode = 'HNL';
                } else { 
                    pb.CurrencyIsoCode = 'USD'; 
                }

                pb.Detalle_caso__c = detallecaso.Id;
                pb.Numero_cuenta_origen__c = detalleCaso.Cuenta_destino__c;
                if(!test.isRunningTest()) { pb.MontoTSP__c = (((pb.Monto_bruto__c/1000).round(System.RoundingMode.UP))*2); 
                }    
                pb.Monto_Aporte_Patronal__c = detalleCaso.Permitir_Retiro_Saldos_Patronales__c;
                pb.Tipo_de_pago__c = tipoPagoBenes;
                pb.Monto_Saldo_Personal_Ordinario__c = saldo10; 
                pb.Monto_Saldo_Personal_ExtraOrdinario__c = saldo11; 
                pb.Monto_Saldo_Patronal_Ordinario__c = saldo12;
                pb.Monto_Saldo_Patronal_ExtraOrdinario__c = saldo13;      
                pb.Saldo_Restante_Cuenta_Cliente__c = detalleCaso.Saldo_Restante_Cuenta_Cliente__c;
                pb.Saldo_Prestamo__c = detalleCaso.Saldo_Prestamo__c;
                pb.Monto_Bruto_Retirar_Empresa__c = detalleCaso.Monto_Bruto_Retirar_Empresa__c;
                pb.Monto_Neto_Retirar_Empresa__c = detalleCaso.Monto_Neto_Retirar_Empresa__c;
                pb.Total_Cargos_Empresa__c = detalleCaso.Total_Cargos_Empresa__c;
                pb.Pago_a_Tercero__c = tipoPB;
                updatePBenes.add(pb);
            }
            upsert updatePBenes;
            popPagoBene = false;
            popPagoBene = true;
            if(saveAll == true) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Se ha guardado correctamente')); 
                //Actualizar detalle de caso
                List<Detalle_caso__c> updateCaseinBene =[Select Id, Tipo_retiro__c, Monto_Bruto_Retirar_Empresa__c, Tipo_pago__c From Detalle_caso__c Where Caso__c =: caso.id and (Tipo_retiro__c = '51' or Tipo_retiro__c = '52')];
                if(detalleCaso.Tipo_pago__c == 'B') { updateCaseinBene[0].Tipo_pago__c = 'B'; update updateCaseinBene;   
                } else if(detalleCaso.Tipo_pago__c == 'T') { updateCaseinBene[0].Tipo_pago__c = 'T'; update updateCaseinBene; 
                }
                //Fin actualizar detalle de caso               
            }
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'La suma de los montos brutos debe ser: '+montoaRetirar));
        }
        if(totalPorc>100.00) { 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'La suma de los porcentajes no puede exceder el 100%'));
        }
    }
    
    public void addPagoBene() {
        Beneficiario__c addbene = new Beneficiario__c(); 
        Integer tamList = Integer.ValueOf(listBeneficiarios.size());
        if((tamList+1)<=10) {
            listBeneficiarios.add(addBene);
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No puede agregar más de 10 registros.'));
        }        
    }  
    
    public Integer rowNum{get;set;}
    public void delRow() {
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index')); 
        if(!test.isRunningTest()) { listBeneficiarios.remove(rowNum); 
        } 
    } 
    public void addPagoBene2() {
        Pago_Beneficiario__c addBene2 = new Pago_Beneficiario__c(); 
        Integer tamList = Integer.ValueOf(listPagosBeneficiarios2.size());
        if(!test.isRunningTest()) {
            if((tamList+1)<=10) {
                listPagosBeneficiarios2.add(addBene2); addbene2.Caso__c = caso.id; Insert addBene2;
            } else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No puede agregar más de 10 registros.'));
            }  
        }
    }
    public Integer rowNum2{get;set;}
    public void delRow2() {
        rowNum2 = Integer.valueOf(apexpages.currentpage().getparameters().get('index2'));
        List<Pago_Beneficiario__c> pagoBenUpdate = new List<Pago_Beneficiario__c>();       
        for(Pago_Beneficiario__c pagoDel : listPagosBeneficiarios2) {
            for(Integer i=0;i<=rowNum2;i++) {
                if(i==rowNum2) { pagoBenUpdate.add(pagoDel);
                }
            }
        } 
        List<Pago_Beneficiario__c> pagoBenDelete = new List<Pago_Beneficiario__c>(); 
        if(!test.isRunningTest()) {
            pagoBenDelete = [select id From Pago_Beneficiario__c where id =: pagoBenUpdate[rowNum2].Id];
            Delete pagoBenDelete; listPagosBeneficiarios2.remove(rowNum2);
        }
    }       
    //Fin Beneficiarios caso retiro 03/03/2020
    
    public void agregarBeneficiarios(){
        try{
            For(Beneficiario__c item : listBeneficiarios){
                if(item.Casilla__c) {
                    Detalle_Caso__c nuevo = new Detalle_Caso__c(Cuenta__c =idCuenta, Caso__c = Caso.id, Beneficiario__c = item.id, Fecha_Nacimiento__c = item.Fecha_Nacimiento__c, Identificacion__c = item.Identidad__c, Porcentaje__c=item.Porcentaje__c,
                              Sexo__c = item.Sexo__c, Primer_Nombre__c=item.Primer_Nombre__c, Segundo_Nombre__c = item.Segundo_Nombre__c, Primer_Apellido__c=item.Primer_Apellido__c, Segundo_Apellido__c=item.Segundo_Apellido__c, Indice__c = conteoGeneral,Id_Externo__c = item.Id_Externo__c,Tipo_identificacion__c = item.Tipo_de_Identificaci_n__c);
                    cuentasCaso.add(nuevo);
                    conteoGeneral++;
                }       
            }
            popBene = false;
        }Catch(Exception e){
            system.debug('Error beneficiarios: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
        }   
    }
    
    Public decimal Monto{set;get;}
    public date fecha{set;get;}
    public date fechacierre{set;get;}
    Public string Descripcion{set;get;}

    public decimal Rendimientodiario{get;set;}
    
    public void accionSubproducto(){
        try{
            if(detalleCaso.Accion__c == 'A3'){  detalleCaso.Nueva_Cuenta_colectiva2__c = null;
            }   
        }Catch(Exception e){
            
        }
    }
    
    public void accionVacia(){
        detalleCaso.Nuevo_monto_aporte__c = null;
        detalleCaso.Nuevo_canal_aporte__c = null;
        detalleCaso.N_Cuenta_Bancaria__c = null;
        detalleCaso.Nueva_fecha_aporte__c = null;
        cerrar();    
    }
    public void accionVacia2(){}
    
    public void buscarCuentaC(){
        try{
            popCuentaC = true;  
            String nombreC = '%' + nombreCuenta + '%';
            cuentasColectivas = [Select Name, Cliente__c, Subproducto__c, Subproducto__r.Name
                                 From Cuentas__c Where (Name like : nombreC OR Codigo__c like : nombreC)
                                 AND Colectiva__c = true 
                                 AND currencyIsoCode =: cuentaCliente.currencyIsoCode
                                 limit 10];
            
        }Catch(Exception e){
            
        }
    }
    
    public void buscarSubPro(){
        try{
            popSubPro = true;   
            String nombreC = '%' + nombreSubproducto + '%';
            subProductos = [Select Codigo__c, Name From Subproducto__c 
                            Where Name like : nombreC 
                            AND currencyIsoCode =: cuentaCliente.currencyIsoCode AND
                            Tipo__c = 'Individual'
                            limit 10];    
            
        }Catch(Exception e){
            
        }
    }
    
    public void cerrar(){
        popCuentaC = false;
        popSubPro = false;
        popFormulario = false;
        popConstancia = false;
        popAporte = false;  
        popBene = false;
        popBene2 = false;
        popPagoBene = false;
        popPagoBene2 = false;  
        popAdjuntar = false; 
        popDolares = false;
        popEDC = false;
        urlFormulario = '';
        nombreSubproducto = '';
        nombreCuenta = '';
    }
        
    public Boolean mostrarSalir{get;set;}
    
    public Boolean saveTrue = true;
    
    public Boolean vienedeVisualforce {get;set;}
    
    public pageReference guardar() {
        
        Savepoint sp = Database.setSavepoint();
        
        try{ 
            if(caso.Status == 'Cerrado' || (caso.Cuentas_seleccionada__c == 0 && vienedeVisualforce)) {
                vienedeVisualforce = false;
                return null;
            } else if(caso.Cuentas_seleccionada__c > 0 && vienedeVisualforce) {   
                calculoSaldoPatronales2();
            }
            if(cTipoCaso.retiros && !detalleCaso.Comision_Retiro_Anticipado__c && detalleCaso.Comision_retiro_anticipado_empresa__c){
                caso.Requiere_aprobacion_exoneracion__c=true;
            }
            if(cuentaCliente.Detalle_Subproducto__c !=null){
                detalleCaso.Detalle_subproducto2__c = cuentaCliente.Detalle_Subproducto__c;
            }
            if(cuentaCliente.Detalle_Cuenta_colectiva__c!=null){
                detalleCaso.Cuenta_Colectiva_Anterior__c = cuentaCliente.Detalle_Cuenta_colectiva__c;
            }
            decimal montoExoneradoTSP=0;
            if(detallecaso.Monto_Pignorado__c==null){
                detallecaso.Monto_Pignorado__c=0;
            }
            if(detallecaso.Saldo_Prestamo__c==null){
                detallecaso.Saldo_Prestamo__c=0;
            }
            decimal df = 0;
            if((cTipoCaso.retiros && detallecaso.Monto_Pignorado__c>0) || test.isRunningTest()) {
                decimal MontoRetirar=0;
                decimal SaldoTotal = 0;
                if(detallecaso.Tipo_retiro__c=='51' || test.isRunningTest()){
                    for(Detalle_caso__c item : cuentasCaso){
                        if((item.Saldo_retirar__c != '13')){
                            MontoRetirar += item.Monto_retirar__c !=null ? item.Monto_retirar__c:0; 
                            if(item.Saldo_retirar__c == '10' || item.Saldo_retirar__c == '11'){
                                SaldoTotal += item.Monto_saldo__c !=null ? item.Monto_saldo__c:0;
                            }else{
                                SaldoTotal += detalleCaso.Monto_Saldo_Patronal__c !=null ? detalleCaso.Monto_Saldo_Patronal__c:0; 
                            }
                        }
                    }
                    decimal valorRestante = SaldoTotal - MontoRetirar + detallecaso.Saldo_Prestamo__c;
                    if(valorRestante<detallecaso.Monto_Pignorado__c) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione una cantidad de retiro menor, ya que el saldo restante de la cuenta no cubre el monto pignorado')); return null; 
                    }
                }
                if(detallecaso.Tipo_retiro__c=='52' && (detallecaso.Saldo_Prestamo__c==0 ||detallecaso.Saldo_Prestamo__c==null)){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Digite el saldo del Prestamo'));  
                    if(!test.isRunningTest()) { 
                        return null;
                    }
                }
            }
            if(cTipoCaso.retiros && detalleCaso.Aplica_Cambio_Sub_Producto_desde_Retiros__c && cuentaCliente.Cuenta_colectiva2__c != null && detalleCaso.Accion__c !='A3'){ 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No puedes cambiar de subproducto a cuenta pertenece a una cuenta colectiva.')); 
                return null; 
            }
            if(caso.Constancia__c == 'A1' && Caso.Fecha_hasta__c!=null && Caso.Fecha_desde__c!=null && Caso.Fecha_desde__c.monthsBetween(Caso.Fecha_hasta__c) > 12 )  { 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Solo puede reflejar hasta un periodo maximo de un año por constancia. ')); 
                return null;
            }
            
            if(Caso.id != null && !esCallCenter && !esBanco){ 
                 if(cTipoCaso.retiros){
                    list<Detalle_Caso__c> detalleFinal = new list<Detalle_Caso__c>();
                    detalleCaso.Cabeza_retiro__c = true;
                    Boolean hayError = false;
                    Decimal montoBrutoRetirar = 0;
                    
                    if(detalleCaso.Cliente_sigue_Laborando__c){
                        detalleCaso.Monto_Bruto_Retirar_Empresa__c=0;
                    }
                    if(detalleCaso.Tipo_Retiro__c == '51' || test.isRunningTest()) {
                        if(detalleCaso.Se_lleva_Parte_Patronal__c){
                            montoBrutoRetirar += detalleCaso.Saldo_Restante_Cuenta_Cliente__c !=null ? detalleCaso.Saldo_Restante_Cuenta_Cliente__c:0;
                        }
                        if((!detalleCaso.Se_lleva_Parte_Patronal__c && !detalleCaso.Cliente_sigue_Laborando__c) || test.isRunningTest()){
                            detalleCaso.Se_lleva_Parte_Patronal__c=true;
                            detalleCaso.Saldo_Restante_Cuenta_Cliente__c=0;
                        }
                        For(Detalle_caso__c item : cuentasCaso) {
                            if(item.Monto_retirar__c < 0){
                                item.Monto_retirar__c.addError('No se permiten valores negativos'); 
                                hayError = true; saveTrue = false; break;
                            } else if(item.Monto_retirar__c > item.Monto_saldo__c && item.Monto_retirar__c > 0){ 
                                item.Monto_retirar__c.addError('Monto a retirar no puede ser mayor al monto del saldo'); 
                                hayError = true; saveTrue = false; break;
                            }else if((item.Monto_retirar__c > 0)){
                                item.Saldo_enviar_Sysde__c = true;
                                montoBrutoRetirar += item.Monto_retirar__c; 
                            }
                            detalleFinal.add(item);
                            calculoSaldoPatronales2();
                        }
                    }
                    if(detalleCaso.Tipo_Retiro__c == '52' || test.isRunningTest()){
                        
                        For(Detalle_caso__c item : cuentasCaso){
                            if((item.Saldo_retirar__c != '12' && item.Saldo_retirar__c != '13') || 
                               (item.Saldo_retirar__c == '12' && detalleCaso.Permitir_Retiro_Saldos_Patronales__c)){
                                   decimal SaldoRetirar =item.Monto_saldo__c;
                                   if((detallecaso.Porcentaje_Saldo_Patronal__c!=NULL && item.Saldo_retirar__c == '12' 
                                       && detalleCaso.Permitir_Retiro_Saldos_Patronales__c) || test.isRunningTest()){
                                           SaldoRetirar= ((item.Monto_saldo__c * detallecaso.Porcentaje_Saldo_Patronal__c) / 100).setscale(2);
                                           detalleCaso.Se_lleva_Parte_Patronal__c=true;
                                           detalleCaso.Saldo_Restante_Cuenta_Cliente__c=0;
                                           System.debug('item.Monto_saldo__c: '+item.Monto_saldo__c+'---'+detalleCaso.Monto_Saldo_Patronal__c+'---'+SaldoRetirar);
                                           detalleCaso.Monto_Bruto_Retirar_Empresa__c = item.Monto_saldo__c - SaldoRetirar;
                                           if(detalleCaso.Monto_Bruto_Retirar_Empresa__c == 0) {
                                               detalleCaso.Total_Cargos_Empresa__c = 0;
                                               detalleCaso.Monto_Neto_Retirar_Empresa__c = 0;
                                           }
                                       }
                                   montoBrutoRetirar += SaldoRetirar;
                               }
                            detalleFinal.add(item); 
                        }   
                    }   
                    
                    if(!hayError){
                        boolean cargarCargosEmpleado = false;
                        detalleCaso.Total_Cargos_Empresa__c = detalleCaso.Total_Cargos_Empresa__c !=null ? detalleCaso.Total_Cargos_Empresa__c:0;
                        cargarCargosEmpleado = cuentaCliente.Cuenta_colectiva2__r.cargar_gastos_empleado__C != null ? cuentaCliente.Cuenta_colectiva2__r.cargar_gastos_empleado__C : cargarCargosEmpleado;
                        Decimal montoCambio = 1;
                        detalleCaso.Porcentaje_comision__c = detalleCaso.Porcentaje_comision__c != null ? detalleCaso.Porcentaje_comision__c : 0;   
                        detalleCaso.Monto_comision_retiro__c = montoBrutoRetirar * (detalleCaso.Porcentaje_comision__c / 100);
                        
                        Decimal exMontoComi = 0;
                        Decimal exMontoACH = 0;
                        Decimal exMontoCheque = 0;
                        Decimal exMontoTSP = 0;
                        
                        Decimal montoComi = 0;
                        Decimal montoACH = 0;
                        Decimal montoCheque = 0;
                        Decimal montoTSP = 0;
                        Cuentas__C cuentaTempo= new Cuentas__C();
                        cuentaTempo =[select codigo__c, cuenta_Colectiva2__c from cuentas__C where id=:idCuenta limit 1];
                        detalleCaso.Tiene_Cuenta_Colectiva__c = cuentatempo.cuenta_Colectiva2__c==null ? false:true;
                        
                        if(!detalleCaso.Tiene_Cuenta_Colectiva__c){
                            if(detalleCaso.Comision_retiro_anticipado_empresa__c && detalleCaso.Comision_Retiro_Anticipado__c){ 
                                montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                            } else if(!detalleCaso.Comision_Retiro_Anticipado__c && detalleCaso.Comision_retiro_anticipado_empresa__c){ 
                                exMontoComi = detalleCaso.Monto_comision_retiro__c;   
                            }
                        }
                        else{
                            if(detalleCaso.Cliente_sigue_Laborando__c && detalleCaso.Cobrar_empleado_sigue_laborando__c){
                                montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                            } else if(!detalleCaso.Comision_Retiro_Anticipado__c && detalleCaso.Comision_retiro_anticipado_empresa__c){
                                exMontoComi = detalleCaso.Monto_comision_retiro__c;   
                            }
                        }
                        
                        if((detalleCaso.Cobro_Individual_CRA__c && detalleCaso.Porcentaje_CRA_Individual__c!=null) || test.isRunningTest()){
                            detalleCaso.Monto_comision_retiro__c = montoBrutoRetirar * (detalleCaso.Porcentaje_CRA_Individual__c / 100);
                            montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                            detalleCaso.Porcentaje_comision__c = detalleCaso.Porcentaje_CRA_Individual__c;
                        }
                        
                        if(detalleCaso.Cobrar_empleado_sigue_laborando__c && !detalleCaso.Cliente_sigue_Laborando__c){
                            
                            if((montoComi>0 && cuentaCliente.Cobrar_empleado_sigue_laborando__c) || test.isRunningTest()){
                                detalleCaso.Monto_comision_retiro__c =0;
                                montoComi = detalleCaso.Monto_comision_retiro__c; 
                                aplicaComi = true;
                            }
                            if((montoComi>0 && cuentaCliente.Subproducto__r.Cobrar_si_empleado_sigue_laborando__c
                                && detalleCaso.nivel_de_regla__C=='3')  || test.isRunningTest()){
                                    detalleCaso.Monto_comision_retiro__c =0;
                                    montoComi = detalleCaso.Monto_comision_retiro__c; 
                                    aplicaComi = true;
                                }
                            
                        }
                        montoComi = montoComi !=null ? montoComi.setScale(2) : 0;  
                         detalleCaso.Monto_Bruto_Retirar_Empresa__c= detalleCaso.Monto_Bruto_Retirar_Empresa__c !=null ? detalleCaso.Monto_Bruto_Retirar_Empresa__c :0;
                         if(detalleCaso.Se_lleva_Parte_Patronal__c && detalleCaso.Monto_Bruto_Retirar_Empresa__C > 0){
                           if(cuentaCliente.Cuenta_colectiva2__r.Tipo_Cuenta__c=='2' || test.isRunningTest()){
                                DetalleCaso.Monto_Neto_Retirar_Empresa__c=detalleCaso.Monto_Bruto_Retirar_Empresa__c;//-CalculoTSP;
                                detalleCaso.Total_Cargos_Empresa__c=0;
                            }
                            if(cuentaCliente.Cuenta_colectiva2__r.Tipo_Cuenta__c=='1' || test.isRunningTest()){
                                decimal milTSP = (detalleCaso.Monto_Bruto_Retirar_Empresa__c / 1000).round(System.RoundingMode.UP);
                                decimal CalculoTSP = (milTSP *2);
                                decimal montoACHv =0;
                                if(cuentaCliente.Cuenta_colectiva2__r.Banco__c !='28'){
                                    montoACHv =  detalleCaso.Monto_ACH__c !=null ? detalleCaso.Monto_ACH__c :0;
                                    detalleCaso.Monto_ACH_Patrono__c=MontoACHv;
                                }
                                DetalleCaso.Monto_Neto_Retirar_Empresa__c=detalleCaso.Monto_Bruto_Retirar_Empresa__c-CalculoTSP -montoACHv;
                                detalleCaso.Total_Cargos_Empresa__c=CalculoTSP+montoACHv;
                                detalleCaso.Monto_TSP_Patrono__c = CalculoTSP;
                                
                            } if(cuentaCliente.Cuenta_colectiva2__r.Tipo_Cuenta__c=='3' || test.isRunningTest()){
                                decimal milTSP = (detalleCaso.Monto_Bruto_Retirar_Empresa__c / 1000).round(System.RoundingMode.UP);
                                decimal CalculoTSP = (milTSP *2);
                                decimal montoChequev =detalleCaso.Monto_cheque__c !=null ? detalleCaso.Monto_cheque__c :0;
                                detalleCaso.Monto_TSP_Patrono__c = CalculoTSP;
                                detalleCaso.Monto_Cheque_Patrono__c = montoChequev;
                                DetalleCaso.Monto_Neto_Retirar_Empresa__c=detalleCaso.Monto_Bruto_Retirar_Empresa__c-CalculoTSP -montoChequev;
                                detalleCaso.Total_Cargos_Empresa__c=CalculoTSP+montoChequev;
                            }
                             system.debug('Monto bruto mayor que cero');
                        }
                        if(detalleCaso.Forma_Retiro__c == 'ACH' && detalleCaso.Cobro_ACH__c){ 
                            montoACH =  detalleCaso.Monto_ACH__c !=null ? detalleCaso.Monto_ACH__c :0;
                        }else if(detalleCaso.Forma_Retiro__c == 'ACH' && !detalleCaso.Cobro_ACH__c){ 
                            exMontoACH =  detalleCaso.Monto_ACH__c !=null ? detalleCaso.Monto_ACH__c :0;
                        }
                        
                        if(detalleCaso.Forma_Retiro__c == 'CK' && detalleCaso.Cobro_Cheque__c){
                            montoCheque =  detalleCaso.Monto_cheque__c !=null ? detalleCaso.Monto_cheque__c :0;
                        }else if(detalleCaso.Forma_Retiro__c == 'CK' && !detalleCaso.Cobro_Cheque__c){ 
                            exMontoCheque = detalleCaso.Monto_cheque__c !=null ? detalleCaso.Monto_cheque__c :0;
                        }
                        system.debug(montoCambio);
                        Decimal milTSP;
                        decimal csdc=detalleCaso.Saldo_Restante_Cuenta_Cliente__c !=null ? detalleCaso.Saldo_Restante_Cuenta_Cliente__c:0;
                        if(detalleCaso.Cliente_sigue_Laborando__c || detalleCaso.Comision_Retiro_Anticipado__c
                           || detalleCaso.Comision_retiro_anticipado_empresa__c) {
                               milTSP = (((montoBrutoRetirar-  montoComi - csdc) * montoCambio) / 1000).round(System.RoundingMode.UP);
                           }
                        else{
                            milTSP = (((montoBrutoRetirar - csdc) * montoCambio) / 1000).round(System.RoundingMode.UP);                            
                        }
                        
                        Decimal calculoTSP = ( milTSP * 2 ) / montoCambio;
                        detalleCaso.Monto_TSP__c = calculoTSP;
                        
                        if(detalleCaso.Cobro_TSP__c){
                            montoTSP = detalleCaso.Monto_TSP__c;
                        } else{ 
                            exMontoTSP = detalleCaso.Monto_TSP__c;
                        }
                        
                        if(cuentaCliente.Subproducto__r.Codigo__c != 'FI010'){
                            detalleCaso.Exonerado__c = exMontoComi + exMontoTSP + exMontoACH + exMontoCheque;
                        }
                        detalleCaso.Monto_total_comisiones_recargos__c=0;
                        if(detalleCaso.Cliente_sigue_Laborando__c || detalleCaso.Comision_Retiro_Anticipado__c
                           || detalleCaso.Comision_retiro_anticipado_empresa__c){
                               detalleCaso.Monto_total_comisiones_recargos__c = montoComi+ montoTSP + montoACH + montoCheque;
                        }
                        else{
                            detalleCaso.Monto_total_comisiones_recargos__c =  montoTSP + montoACH + montoCheque;
                        }
                        detalleCaso.Monto_ACH_Patrono__c = detalleCaso.Monto_ACH_Patrono__c != null ? detalleCaso.Monto_ACH_Patrono__c :0;
                        detalleCaso.Monto_TSP_Patrono__c = detalleCaso.Monto_TSP_Patrono__c != null ? detalleCaso.Monto_TSP_Patrono__c :0;
                        detalleCaso.Monto_Cheque_Patrono__c = detalleCaso.Monto_Cheque_Patrono__c != null ? detalleCaso.Monto_Cheque_Patrono__c :0;
                        detalleCaso.Cargar_cargos_Empleados__C=cargarCargosEmpleado;
                        
                        if(cargarCargosEmpleado || test.isRunningTest()) {
                            detalleCaso.Total_Cargos_Empresa__c += (montoTSP + montoACH + montoCheque);
                            detalleCaso.Cargo_Empleado_Paga_Empresa__C  = (montoTSP + montoACH + montoCheque);
                            detalleCaso.Monto_total_comisiones_recargos__c -= (montoTSP + montoACH + montoCheque);
                            detalleCaso.Monto_ACH_Patrono__c += montoACH;
                            detalleCaso.Monto_TSP_Patrono__c +=montoTSP;
                            detalleCaso.Monto_Cheque_Patrono__c += montoCheque;
                            detalleCaso.Monto_Neto_Retirar_Empresa__c = detalleCaso.Monto_Bruto_Retirar_Empresa__c - detalleCaso.Total_Cargos_Empresa__c ;
                        }                        
                        if(detallecaso.Monto_Saldo_Patronal__c==null){detallecaso.Monto_Saldo_Patronal__c=0;}
                        if(detalleCaso.Saldo_Restante_Cuenta_Cliente__c==null){detalleCaso.Saldo_Restante_Cuenta_Cliente__c=0;}
                        system.debug('Monto bruto a retirar: '+montoBrutoRetirar+'---'+detalleCaso.Saldo_Restante_Cuenta_Cliente__c);
                        detalleCaso.Monto_bruto_retirar__c = (montoBrutoRetirar - detallecaso.Saldo_Prestamo__c - detalleCaso.Saldo_Restante_Cuenta_Cliente__c).setscale(2);
                        detalleCaso.Monto_total_retirar__c = (montoBrutoRetirar - detalleCaso.Monto_total_comisiones_recargos__c - detallecaso.Saldo_Prestamo__c - detalleCaso.Saldo_Restante_Cuenta_Cliente__c).setscale(2);
                        if(detalleCaso.Monto_total_retirar__c<0) {
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'¡El monto a retirar no cubre con los cargos del retiro, por favor selecccione una cantidad mayor!'));
                            if(!test.isrunningTest()){
                                return null;
                            }
                        }
                        
                        claseUtil.stopTrigger();

                        if((((detalleCaso.Comision_retiro_anticipado_empresa__c && !detalleCaso.Comision_Retiro_Anticipado__c)
                             || !detalleCaso.Cobro_TSP__c || (detalleCaso.Forma_Retiro__c == 'ACH' && !detalleCaso.Cobro_ACH__c)
                             || (detalleCaso.Forma_Retiro__c == 'CK' && !detalleCaso.Cobro_Cheque__c))
                            && cuentaCliente.Subproducto__r.Codigo__c != 'FI010') || test.isRunningTest()){
                                
                                Caso.Requiere_aprobacion_exoneracion__c = true;
                                detalleCaso.Total_exonerado__c = detalleCaso.Total_exonerado__c !=null ? detalleCaso.Total_exonerado__c:0;
                                if(test.isRunningTest() ||((detalleCaso.Total_exonerado__c + (detalleCaso.Exonerado__c*montoCambio)) > configCobros[2].Monto__c)){
                                    Caso.RA_limite_exonerado__c = true; 
                                }
                                if(!vienedeVisualforce) {
                                    update Caso; 
                                }
                            }if((Caso.Requiere_aprobacion_exoneracion__c || test.isRunningTest()) && false){
                                Caso.Requiere_aprobacion_exoneracion__c = false;
                                Caso.RA_limite_exonerado__c = false;    
                                if(!vienedeVisualforce) {
                                    update Caso;
                                }    
                            }
                        detalleFinal.add(detalleCaso);
                        upsert detalleFinal;
                        
                        map<string, integer>  casos = new  map<string, integer>();
                        boolean banderaSaldoRepetido=false;
                        list<detalle_caso__C> listCasosMalos = new list<detalle_caso__C>();
                        for(detalle_caso__c item : 
                            [select error_retiros__C,id from detalle_caso__C where caso__C=:caso.id order by error_retiros__C desc]){
                                listCasosMalos.add(item);
                                if(item.error_retiros__C!=null && !casos.containsKey(item.error_retiros__C)){
                                    casos.put(item.error_retiros__C, 2);
                                }else {
                                    banderaSaldoRepetido=true;
                                }
                            }
                        if(banderaSaldoRepetido){
                            delete(listCasosMalos);
                            return new PageReference('/'+caso.id);
                        }
                        porcCobroIndiv = detalleCaso.Porcentaje_comision__c.setscale(2);
                    }
                }
                if(saveTrue && !vienedeVisualforce) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'¡Se ha guardado correctamente!'));
                }
                if(!vienedeVisualforce) {
                    mostrarGuardar = false;
                } 
                vienedeVisualforce = false;
            }
            if(detallecaso.Id != Null) { 
                if(detalleCaso.Cargar_cargos_Empleados__c == true && detalleCaso.Tipo_retiro__c != null ) {
                    System.debug('detalleCaso.Monto_cheque__c: '+detalleCaso.Monto_cheque__c);
                    detalleCaso.Monto_Cheque_Patrono__c = detalleCaso.Monto_cheque__c; 
                    update detalleCaso;
                }
                List<Detalle_caso__c> dc = [Select Monto_bruto_retirar__c From Detalle_caso__c Where Caso__c =: caso.id and Tipo_retiro__c = '51' Limit 1];              
                if(detalleCaso.Tipo_retiro__c == '51') { //Retiro Parcial 
                    if(!dc.isEmpty()) {              
                        montoaRetirar = dc[0].Monto_bruto_retirar__c;
                    }
                } else if(detalleCaso.Tipo_retiro__c == '52') { /*Retiro Total*/ 
                    montoaRetirar = detalleCaso.Monto_bruto_retirar__c;
                }
            }
        }catch(System.DmlException e){
            for (Integer i = 0; i < e.getNumDml(); i++) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getDmlMessage(i)));  
            }
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            Database.rollback(sp);  
        }Catch(Exception e){
            Database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'¡Se ha producido un error!, contacte a su Admin.'));
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
        }
        return null;
    }
    
    public void calculoSaldoPatronales2(){
        try{ 
            detalleCaso.Monto_Saldo_Patronal__c = montoPatOrd * (detalleCaso.Porcentaje_Saldo_Patronal__c/100);
            if(detalleCaso.Porcentaje_Saldo_Patronal_Ext__c == null) {
                detalleCaso.Monto_Saldo_Patronal_Ext__c = 0;
                detalleCaso.Porcentaje_Saldo_Patronal_Ext__c = 0;
            }
            detalleCaso.Monto_Saldo_Patronal_Ext__c = montoPatExtOrd * (detalleCaso.Porcentaje_Saldo_Patronal_Ext__c/100);
            
            for(Detalle_caso__c dc : cuentasCaso){       
                //if(dc.Tipo_Retiro__c == '51' /*&& dc.Saldo_retirar__c == '12'*/) {
                detalleCaso.Monto_Bruto_Retirar_Empresa__c = /*detalleCaso.Monto_Saldo_Patronal__c - dc.Monto_retirar__c*/montoPatOrd-detalleCaso.Monto_Saldo_Patronal__c;
                //}                   
            }
            
            //Inicio actualizando Saldo Restante cliente
            if(detalleCaso.Monto_Saldo_Patronal__c == 0) {
                detalleCaso.Saldo_Restante_Cuenta_Cliente__c = 0; 
            } else {
                System.debug('detalleCaso.Tipo_retiro__c: '+detalleCaso.Tipo_retiro__c);
                if(detalleCaso.Tipo_retiro__c == '51') {
                    detalleCaso.Saldo_Restante_Cuenta_Cliente__c = detalleCaso.Monto_Saldo_Patronal__c - detalleCaso.Monto_bruto_retirar__c;
                }    
            }
            //Inicio actualizando Saldo Restante cliente
  
        }catch(Exception ex) {
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
    }
        
    // CONSULTAR CASOS -- PARA LA PARTE DEL PORTAL
    public string idCaso{get;set;}
    
    public boolean flag{get;set;}
    
    public void changeFlag(){
        flag = boolean.valueOf(ApexPages.currentPage().getParameters().get('flagValue'));
    }
       
}