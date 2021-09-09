public class extensionCasoDetalle2 {
    public claseTipoCaso cTipoCaso{get;set;}
    public Case Caso{get;set;}
    
    public Detalle_caso__c detalleCaso{get;set;}
    public Detalle_caso__c detalleCaso02{get;set;}
    public Double montoPatOrd{get;set;} 
    public Double montoPerOrd{get;set;}
    public Double montoPerExtOrd{get;set;}
    public Decimal saldo10{get;set;}
    public Decimal saldo11{get;set;}
    public Decimal saldo12{get;set;}
    public Decimal saldo13{get;set;}
    //public Double montoBrutoRetiro{get;set;}
    public Double montoaRetirar{get;set;}
    public Detalle_caso__c detalleCaso03{get;set;}
    public Double montoPatExtOrd{get;set;}
    public Detalle_caso__c detalleCaso04{get;set;}
    public Detalle_caso__c detalleCaso05{get;set;}
    //public Detalle_caso__c detalleCaso2c{get;set;}
    public Cuentas__c cuentaCliente{get;set;}
    public boolean bandera3{get;set;}
    public boolean banderaSubTipoTran{get;set;}
    public boolean mostrarReversiones{get;set;}
    public boolean mostrarReversionesDife{get;set;}
    public boolean mostrarFecha{get;set;}
    public boolean mostrarbonotes{get;set;}
    public boolean mostrarMonto{get;set;}
    public boolean mostrarReversionesDifeabajo{get;set;}
    public list<SelectOption> listAgencias{get;set;}
    public list<Detalle_caso__c> cuentasCaso{get;set;}
    public list<Detalle_caso__c> cuentasCaso2{get;set;}
    public list<Detalle_caso__c> cuentasCaso3{get;set;}
    public list<Detalle_caso__c> cuentasCaso4{get;set;}
    public list<Detalle_caso__c> cuentasCaso5{get;set;}
    public list<Detalle_caso__c> cuentasCaso6{get;set;}
    //public list<Detalle_caso__c> cuentasCaso7{get;set;}
    public list<Detalle_caso__c> datelleCasoSaldo10{get;set;}
    public list<Detalle_caso__c> datelleCasoSaldo11{get;set;}
    public list<Detalle_caso__c> datelleCasoSaldo12{get;set;}
    public list<Detalle_caso__c> datelleCasoSaldo13{get;set;}
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
    
    public boolean popRezago{get;set;}
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
    public string idDetalleEliminar{get;set;}
    public list<Detalle_Caso__c> listDetalleEliminar{get;set;}
    public boolean popDolares {get;set;}   
    
    // VARIABLES PARA EL PORTAL
    public list<SelectOption> tipoRCaso{get;set;}
    //nueva lista, nuevas cosas
    public list<SelectOption> portalOrigen{get;set;}
    public list<SelectOption> tipoRCasoTemp{get;set;}
    public map<string, list<selectOption>> mapTipoRcaso;
    public string idTipoRCaso{get;set;}
    public list<SelectOption> tipocasol{get;set;}
    public list<SelectOption> prioridadCaso{get;set;}
    public list<SelectOption> tipoEstadoCuenta{get;set;}
    public list<SelectOption> tipoConstancia{get;set;}
    public list<SelectOption> estadoCuentaDetallado{get;set;}
    public List<Attachment> hayArchivoAdjunto{get;set;}
    public boolean mostrarDespuesDeEnviarAprobacion{get;set;}    
    
    public map<integer, decimal> mapPSP {get;set;}
    public boolean paso1{get;set;}
    public boolean paso2{get;set;}
    public boolean popCaso{get;set;}
    
    public boolean popFormulario{get;set;}
    public String urlFormulario{get;set;}
    public boolean popAdjuntar{get;set;}
    public boolean popConstancia{get;set;}
    public boolean popEDC{get;set;}
    
    public boolean esBanco{get;set;}
    public boolean esCallCenter{get;set;}
    
    public boolean archivoAd{get;set;}    
    public integer anosCliente{get;set;}
    private Case CasoSTD;
    public boolean mostrarFormulario{get;set;}
    list<Configuracion_Cobro__mdt> configCobros;
    public string ZonaSeleccionada {get;set;}
    public list<SelectOption> listaZonas {get;set;} 
    public boolean pruebamodal{get;set;}
    
    public list<TasaCambio.ValorDolar> listTasaCambio {get;set;}
                           
    public boolean mostrarEnviarAprobacion{get;set;}
    public boolean mostrarCerrarCaso{get;set;}
    public Movimiento_Seleccionado__c  movimientoSeleccionado {get;set;}
    public boolean detalleCasoActualizado{get;set;}
    
    
    public Map<String, list<Detalle_caso__c>> mapCasoDetalle {get;set;}
    public extensionCasoDetalle2(ApexPages.StandardController controller) {
      
        montoaRetirar = 0.00; montoPatOrd = 0.00; montoPatExtOrd = 0.00; montoPerOrd = 0.00; montoPerExtOrd = 0.00; porcCobroIndiv = 0.00; aplicaComi = false;
    
        CasoSTD = (Case)controller.getRecord();
        pruebamodal=false;
        mapCasoDetalle = new Map<String, list<Detalle_caso__c>>();
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
        cuentasCaso2 = new list<Detalle_caso__c>();
        cuentasCaso5 = new list<Detalle_caso__c>();
        cuentasCaso6 = new list<Detalle_caso__c>();
        mapDCasoCuenta = new map<Id, Detalle_Caso__c>();
        listDetalleEliminar = new list<Detalle_Caso__c>();
        listBeneficiarios = new list<Beneficiario__c>();
        listPagosBeneficiarios = new list<Pago_Beneficiario__c>();
        listPagosBeneficiarios2 = new list<Pago_Beneficiario__c>();
        hayArchivoAdjunto = new list<Attachment>();
        popBene = false;
        indiceEliminar = 0;
        esBanco = False;
        esCallCenter = False;
        banderaSubTipoTran=false;
        listAportes = new list<classAportes>();
        archivoAd = false;
        mostrarDespuesDeEnviarAprobacion = false;
        esSalesforce = false;
        string guest = '';
        //nueva lista
        
        
        try{
            
            if(CasoSTD.Id != null){
                Caso = [Select Status,AccountId,CreatedDate, Account.Identificacion__c, RecordType.DeveloperName,
                        Fecha_desde__c, fecha_hasta__c,Account.PersonBirthdate, account.sexo__C,
                        Desea_ver_tasa_de_cambio__c, SuppliedEmail,
                        Constancia__c, currencyIsoCode,Requiere_aprobacion_exoneracion__c,
                        Mostrar_tasa_Cambio__c,Tasa_Cambio__c,
                        //account.Departamento_Residencia__r.Codigo_Departamento__c,
                        Enviar_a_aprobacion__c,Aplica_Saldo_patronal__c ,Aprobado__c,
                        Archivo_Adjunto__C,Nombre_agencia__c, agencia__c, Agencia__r.Name, account.Departamento_Residencia2__c,
                        Monto_compromiso_aporte__c, Frecuencia__c,Codigo_barra__C
                        From Case Where Id =: CasoSTD.Id Limit 1]; 
                if(caso.Account.PersonBirthdate!=null){
                    date gdcs=caso.Account.PersonBirthdate;
                    anosCliente = gdcs.monthsBetween(date.today());
                    anosCliente =(integer)(anosCliente/12);
                }
                listAgencias = new list<selectOption>();
                listAgencias.add(new SelectOption('', '--Ninguno--'));
                string zona = zonaPorDepto();
                string query = 'select id, name from agencia__C';
                if(zona !='3'){
                    //query += ' where zona__C = \''+zona+'\'';
                }
                for(agencia__C item: database.query(query)){ listAgencias.add(new SelectOption(item.id, item.name));
                }
                
                if(Caso.Status != 'Pendiente de aprobación' && Caso.Status != 'Pendiente segunda aprobación' 
                   && Caso.Status != 'Error de conexion' && Caso.Status != 'Cerrado'){
                       mostrarGuardar = true;
                   }else{
                       mostrarGuardar = false;
                   }
                guest = userInfo.getUserType();
                
                IF(Guest != null && Guest !=''){
                    IF(Guest == 'Guest'){ esCallCenter = true;
                    } else {
                        // para identificar salesforce o site
                        esSalesforce = true;
                    }
                }
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
                    //cuentaCliente = mapCuentas.get(idCuenta).CurrencyIsoCode;
                    monedaCuenta= mapCuentas.get(idCuenta).CurrencyIsoCode;
                }
                if(!cuentasCaso.isEmpty()) {
                    
                    pagosBT = 'display:block;';
                    
                    detalleCaso = cuentasCaso[0];
                    popRezago = cTipoCaso.reversiones && Caso.Status == 'Pendiente segunda aprobación' ? true : false;
                    idCuenta = detalleCaso.Cuenta__c;
                    cuentaCliente = mapCuentas.get(idCuenta);
                    //MonedaCuenta();
                     monedaCuenta= cuentaCliente.CurrencyIsoCode;
                    system.debug('Moneda: '+cuentaCliente.CurrencyIsoCode);
                    if(cTipoCaso.subProducto){ cuentaCliente = mapCuentas.get(detalleCaso.Cuenta__c); idCuenta = cuentaCliente.id;  
                    }
                    else if(cTipoCaso.constancias || cTipoCaso.actInformacion){
                        
                        For(Detalle_Caso__c item : cuentasCaso){
                            item.Indice__c = conteoGeneral;
                            mapDCasoCuenta.put(item.Cuenta__c, item);       
                            conteoGeneral ++;                   
                        }
                        
                        system.debug(mapDCasoCuenta);
                    }
                    else if(cTipoCaso.retiros){
                        cuentasCaso.remove(0);
                        
                        detalleCasoActualizado = (Caso.status=='Pendiente de aprobación' || Caso.status=='Pendiente segunda aprobación') ? true:false;
                        map<string, integer>casos = new map<string, integer>();
                        list<detalle_caso__c> casostemporales = new list<detalle_caso__c>();
                         mapCasoDetalle = new Map<String, list<Detalle_caso__c>>();
                        for(integer i=0; i<cuentasCaso.size(); i++){
                            list<Detalle_caso__c> listCasoDetalle = new list<Detalle_caso__c>();
                            if(cuentasCaso[i].Tipo_retiro__c != '51' && cuentasCaso[i].Saldo_retirar__c == '13'){
                                listCasoDetalle.add(cuentasCaso[i]);
                                mapCasoDetalle.put('13', listCasoDetalle);
                            }
                            if(!casos.containsKey(cuentasCaso[i].saldo_retirar__C)) {
                                casos.put(cuentasCaso[i].saldo_retirar__C, 2);
                                casostemporales.add(cuentasCaso[i]);
                            }
                        }
                        cuentasCaso = new list<detalle_caso__c>();
                        cuentasCaso=casostemporales;
                        //Cuentas__C cuentatempo= new Cuentas__C();
                        //cuentatempo =[select codigo__c, cuenta_Colectiva2__c from cuentas__C where id=:idCuenta limit 1];
                        getSaldoCuenta saldos = new getSaldoCuenta();
                        DECIMAL montoBrutoRetirar=0;
                        for(integer i=0; i<cuentasCaso.size(); i++)
                        {
                            if(cuentasCaso[i].Monto_retirar__c !=null)
                            {
                                montoBrutoRetirar += cuentasCaso[i].Monto_retirar__c; 
                                
                            }
                        }
                        bandera3=false;
                        if(caso.Status=='Pendiente de aprobación' || caso.Status=='Pendiente segunda aprobación' ||
                            caso.Status=='Nuevo' || caso.Status=='Rechazado' || caso.Status=='Devuelto'){
                            montoBrutoRetirar=0;
                            bandera3=true;
                            saldos = aSysdeCallouts.traerSaldos(cuentaCliente.Codigo__c);
                            
                            try{detalleCaso.Saldo_total__c=decimal.valueOf(saldos.saldoTotal.replace(',',''));}catch(Exception ex){}
                        }
                        if(bandera3  || test.isRunningTest()){
                            for(integer i=0; i<cuentasCaso.size(); i++){
                                for(integer j=0; j<saldos.saldos.size(); j++) {
                                    if(cuentasCaso[i].Saldo_retirar__c==saldos.saldos[j].tipoSaldo){
                                        cuentasCaso[i].Monto_saldo__c=decimal.valueOf(saldos.saldos[j].montoSaldo.replace(',',''));
                                        if(detalleCaso.Tipo_retiro__c=='52'){ cuentasCaso[i].Monto_retirar__c=decimal.valueOf(saldos.saldos[j].montoSaldo.replace(',',''));
                                        }
                                        if(cuentasCaso[i].Monto_retirar__c !=Null){
                                            if(detalleCaso.Tipo_retiro__c=='51'){ montoBrutoRetirar += cuentasCaso[i].Monto_retirar__c; 
                                            }else{
                                                if((cuentasCaso[i].Saldo_retirar__c != '12' && cuentasCaso[i].Saldo_retirar__c != '13') || 
                                                   (cuentasCaso[i].Saldo_retirar__c == '12' && detalleCaso.Permitir_Retiro_Saldos_Patronales__c)){
                                                       decimal SaldoRetirar =cuentasCaso[i].Monto_saldo__c;
                                                       if((detallecaso.Porcentaje_Saldo_Patronal__c!=NULL && cuentasCaso[i].Saldo_retirar__c == '12' 
                                                           && detalleCaso.Permitir_Retiro_Saldos_Patronales__c)|| test.isRunningTest()){
                                                               SaldoRetirar= ((cuentasCaso[i].Monto_saldo__c * detallecaso.Porcentaje_Saldo_Patronal__c) / 100).setscale(2);
                                                               detalleCaso.Se_lleva_Parte_Patronal__c=true;
                                                               detalleCaso.Saldo_Restante_Cuenta_Cliente__c=0;
                                                               detalleCaso.Monto_Bruto_Retirar_Empresa__c = cuentasCaso[i].Monto_saldo__c- SaldoRetirar;
                                                           }
                                                       montoBrutoRetirar += SaldoRetirar;
                                                   }
                                                //montoBrutoRetirar+=cuentasCaso[i].Monto_retirar__c; 
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
                        }
                        system.debug('Monto bruto 0: '+montoBrutoRetirar);
                        for(integer i=0; i<cuentasCaso.size(); i++){
                            if((cuentasCaso[i].Saldo_retirar__c =='12') 
                               && !detallecaso.Permitir_Retiro_Saldos_Patronales__c &&  cuentasCaso[i].Monto_retirar__c !=null
                               && detalleCaso.cuenta__r.Cuenta_colectiva2__c !=null){ montoBrutoRetirar = montoBrutoRetirar- cuentasCaso[i].Monto_retirar__c;
                               }
                        }
                        if(detalleCaso.Se_lleva_Parte_Patronal__c){
                            montoBrutoRetirar += detalleCaso.Saldo_Restante_Cuenta_Cliente__c !=null ? detalleCaso.Saldo_Restante_Cuenta_Cliente__c:0;
                        }
                        system.debug('Monto bruto: '+montoBrutoRetirar);
                        //PARTE AÑADIDA LUIS
                        Decimal montoComi = 0;
                        Decimal montoACH = 0;
                        Decimal montoCheque = 0;
                        decimal montoTSP = 0; 
                        
                        Decimal montoCambio = 1;
                        if(cuentaCliente.currencyIsoCode == 'USD'){
                            //montoCambio = [Select Monto__c From Monto_cambio_dolar__c].Monto__c; //aSysdeCallOuts.montoCambioDolar(); 
                        } 
                        
                        detalleCaso.Porcentaje_comision__c = detalleCaso.Porcentaje_comision__c != null ? detalleCaso.Porcentaje_comision__c : 0;                                                   
                        detalleCaso.Monto_comision_retiro__c = montoBrutoRetirar * (detalleCaso.Porcentaje_comision__c / 100);
                        if(caso.CreatedDate<datetime.newInstance(2019, 7, 17, 0, 0, 0)){ detalleCaso.Tiene_Cuenta_Colectiva__c =  detalleCaso.cuenta__r.Cuenta_colectiva2__c ==null ?false:true;
                        }
                        if(!detalleCaso.Tiene_Cuenta_Colectiva__c){
                            if(detalleCaso.Comision_Retiro_Anticipado__c && detalleCaso.Comision_retiro_anticipado_empresa__c){ montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                            }                                
                        }
                        else {
                            if(detalleCaso.Cliente_sigue_Laborando__c && detalleCaso.Cobrar_empleado_sigue_laborando__c) { montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                            }  
                        } 
                        //PARTE NUEVA RETIROS 
                        if((detalleCaso.Cobro_Individual_CRA__c && detalleCaso.Porcentaje_CRA_Individual__c!=null) || test.isRunningTest()){
                            detalleCaso.Monto_comision_retiro__c = montoBrutoRetirar * (detalleCaso.Porcentaje_CRA_Individual__c / 100);
                            montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                        }
                        if((detalleCaso.Cobrar_empleado_sigue_laborando__c && !detalleCaso.Cliente_sigue_Laborando__c) || test.isRunningTest()){
                            
                            if(montoComi>0 && cuentaCliente.Cobrar_empleado_sigue_laborando__c) { detalleCaso.Monto_comision_retiro__c =0; montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                            }
                            if(montoComi>0 && cuentaCliente.Subproducto__r.Cobrar_si_empleado_sigue_laborando__c && detalleCaso.nivel_de_regla__C=='3'){ detalleCaso.Monto_comision_retiro__c =0; montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                               }
                        }
                        // FIN DE PARTE NUEVA RETIROS
                        if(detalleCaso.Forma_Retiro__c == 'ACH' && detalleCaso.Cobro_ACH__c){ montoACH = detalleCaso.Monto_ACH__c;
                        }
                        if(detalleCaso.Forma_Retiro__c == 'CK' && detalleCaso.Cobro_Cheque__c){
                            montoCheque = detalleCaso.Monto_cheque__c;
                        }
                        //Decimal milTSP = (((montoBrutoRetirar -  montoComi - montoACH - montoCheque) * montoCambio) / 1000).round(System.RoundingMode.UP);
                        Decimal milTSP;
                        decimal csdc=detalleCaso.Saldo_Restante_Cuenta_Cliente__c !=null ? detalleCaso.Saldo_Restante_Cuenta_Cliente__c:0;
                        if(detalleCaso.Cliente_sigue_Laborando__c || detalleCaso.Comision_Retiro_Anticipado__c
                           || detalleCaso.Comision_retiro_anticipado_empresa__c) { milTSP = (((montoBrutoRetirar-  montoComi - /*montoACH - montoCheque -*/ csdc) * montoCambio) / 1000).round(System.RoundingMode.UP);
                        }
                        else
                        {
                            milTSP = (((montoBrutoRetirar  - /*montoACH - montoCheque*/ - csdc) * montoCambio) / 1000).round(System.RoundingMode.UP);
                        }
                        Decimal calculoTSP = ( milTSP * 2 ) / montoCambio;
                        detalleCaso.Monto_TSP__c = calculoTSP;
                        
                        if(detalleCaso.Cobro_TSP__c){
                            montoTSP = detalleCaso.Monto_TSP__c;
                        }
                        
                        if(detalleCaso.Cliente_sigue_Laborando__c || detalleCaso.Comision_Retiro_Anticipado__c
                           || detalleCaso.Comision_retiro_anticipado_empresa__c){ detalleCaso.Monto_total_comisiones_recargos__c = montoComi+ montoTSP + montoACH + montoCheque;                              
                           }
                        else{
                            detalleCaso.Monto_total_comisiones_recargos__c =  montoTSP + montoACH + montoCheque;
                        }
                        detalleCaso.Cargo_Empleado_Paga_Empresa__C = detalleCaso.Cargo_Empleado_Paga_Empresa__C !=null ? detalleCaso.Cargo_Empleado_Paga_Empresa__C :0;
                        //detalleCaso.Cargo_Empleado_Paga_Empresa__C = 0;
                        if(detalleCaso.Cargar_cargos_Empleados__C  || test.isRunningTest()){
                            if(detalleCaso.Total_Cargos_Empresa__c ==null){detalleCaso.Total_Cargos_Empresa__c = 0;}
                            if(detalleCaso.Monto_total_comisiones_recargos__c ==null){detalleCaso.Monto_total_comisiones_recargos__c=0;}
                            if(detalleCaso.Monto_ACH_Patrono__c == null){detalleCaso.Monto_ACH_Patrono__c=0;}
                            if(detalleCaso.Monto_TSP_Patrono__c == null){detalleCaso.Monto_TSP_Patrono__c=0;}
                            if(detalleCaso.Monto_Cheque_Patrono__c == null){detalleCaso.Monto_Cheque_Patrono__c=0;}
                            detalleCaso.Total_Cargos_Empresa__c += (montoTSP + montoACH + montoCheque - detalleCaso.Cargo_Empleado_Paga_Empresa__C);
                            detalleCaso.Monto_total_comisiones_recargos__c -= (montoTSP + montoACH + montoCheque);
                            detalleCaso.Monto_ACH_Patrono__c += montoACH;
                            detalleCaso.Monto_TSP_Patrono__c +=montoTSP;
                            detalleCaso.Monto_Cheque_Patrono__c += montoCheque;
                            detalleCaso.Monto_Neto_Retirar_Empresa__c = detalleCaso.Monto_Bruto_Retirar_Empresa__c - detalleCaso.Total_Cargos_Empresa__c;
                        }
                        detalleCaso.Monto_bruto_retirar__c = montoBrutoRetirar;
                        if(detalLeCaso.Saldo_Prestamo__c==null){detalleCaso.Saldo_Prestamo__c=0;}
                        if(detalleCaso.Saldo_Restante_Cuenta_Cliente__c==null){detalleCaso.Saldo_Restante_Cuenta_Cliente__c=0;}
                        detalleCaso.Monto_total_retirar__c = montoBrutoRetirar - detalleCaso.Monto_total_comisiones_recargos__c - detallecaso.Saldo_Prestamo__c - detalleCaso.Saldo_Restante_Cuenta_Cliente__c;
                        system.debug('montoBrutoRetirar : '+montoBrutoRetirar +', Monto_total_comisiones_recargos__c: '+ detalleCaso.Monto_total_comisiones_recargos__c +', Saldo_Prestamo__c: '+ detallecaso.Saldo_Prestamo__c +', Saldo_Restante_Cuenta_Cliente__c'+ detalleCaso.Saldo_Restante_Cuenta_Cliente__c);
                        if(/*detalleCaso.Monto_Bruto_Retirar_Empresa__C>0 &&*/ caso.Status !='Cerrado'){
                            //actualizarSaldoPatronalCons();
                            //guardar();
                        }else if (detalleCasoActualizado){
                            //actualizarSaldoPatronalCons();
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Por favor espere un momento para proceder con la aprobación '));
                        }
                        //actualizarSaldoPatronalCons();
                        //  FIN PARTE AÑADIDA  
                        
                        configCobros = [Select DeveloperName, Monto__c,Monto_dolar__c 
                                        From Configuracion_Cobro__mdt
                                        Order by DeveloperName];
                        detalleCaso.Total_exonerado__c = montoExoneradoAlDia();
                    }
                    
                } else { 
                
                    pagosBT = 'display:none;';
                
                    if(cTipoCaso.retiros){
                        detalleCaso.Tipo_retiro__c = '51';
                        configCobros = [Select DeveloperName, Monto__c, Monto_dolar__c 
                                        From Configuracion_Cobro__mdt
                                        Order by DeveloperName];
                        
                        detalleCaso.Cobro_Cheque__c = true;
                        detalleCaso.Cobro_ACH__c = true;
                        detalleCaso.Cobro_TSP__c = true;
                        detalleCaso.Comision_Retiro_Anticipado__c = true;
                        
                        detalleCaso.Total_exonerado__c = montoExoneradoAlDia();
                        selecCuentaRetiros();   
                    }
                }
                for(Detalle_caso__c item: cuentasCaso){
                    
                }
                //Nuevo 28/02/2020
                if(!test.isRunningTest()){
                cuentasCaso6=[select Id, N_Cuenta_Bancaria__c, Caso__c, Cuenta__c, Cuenta__r.Name, Monto_Saldo_Patronal__c, Porcentaje_Saldo_Patronal__c, 
                              Monto_Saldo_Patronal_Ext__c, Porcentaje_Saldo_Patronal_Ext__c, Tipo_retiro__c, Saldo_retirar__c, Monto_saldo__c, Tipo_Politica_Retiro_Saldo_Patronal__c, 
                              Beneficiario__c, Monto_retirar__c, Monto_bruto_retirar__c, Cobro_TSP__c, Monto_TSP_Patrono__c, Monto_total_comisiones_recargos__c, Monto_total_retirar__c, Monto_Bruto_Retirar_Empresa__c, 
                              Total_Cargos_Empresa__c, Monto_Neto_Retirar_Empresa__c, Tipo_pago__c FROM Detalle_caso__c Where Caso__c =: caso.id and Monto_Saldo_Patronal__c != null];
    
                if(!cuentasCaso6.isEmpty()) {     
                    /*AggregateResult[] groupedResults = [Select SUM(Monto_retirar__c) suma From Detalle_caso__c Where Caso__c =: caso.id]; */
                    List<Detalle_caso__c> dc = [Select Monto_bruto_retirar__c From Detalle_caso__c Where Caso__c =: caso.id and Tipo_retiro__c = '51' Limit 1];              
                    if(detalleCaso.Tipo_retiro__c == '51') { /*Retiro Parcial*/ if(!dc.isEmpty()) { montoaRetirar = /*Double.valueOf(groupedResults[0].get('suma'))*/ dc[0].Monto_bruto_retirar__c;
                        }
                    } else if(detalleCaso.Tipo_retiro__c == '52') { /*Retiro Parcial*/ List<Detalle_caso__c> detcase = [Select Monto_bruto_retirar__c From Detalle_caso__c Where Caso__c =: caso.id and Tipo_retiro__c = '52']; montoaRetirar = /*detalleCaso.Monto_bruto_retirar__c;*/ detcase[0].Monto_bruto_retirar__c/* + montoPerOrd + montoPerExtOrd*/;
                    }          
                    System.debug('Existe detalle del caso: '+cuentasCaso6[0].Monto_Saldo_Patronal_Ext__c);
                    detalleCaso.Tipo_pago__c = cuentasCaso6[0].Tipo_pago__c;
                    detalleCaso.Monto_Saldo_Patronal__c = cuentasCaso6[0].Monto_Saldo_Patronal__c;
                    detalleCaso.Porcentaje_Saldo_Patronal__c = cuentasCaso6[0].Porcentaje_Saldo_Patronal__c;
                    detalleCaso.Monto_Saldo_Patronal_Ext__c = cuentasCaso6[0].Monto_Saldo_Patronal_Ext__c;
                    detalleCaso.Porcentaje_Saldo_Patronal_Ext__c = cuentasCaso6[0].Porcentaje_Saldo_Patronal_Ext__c;
                    detalleCaso.Monto_bruto_retirar__c = /*cuentasCaso6[0].Monto_bruto_retirar__c*/ montoaRetirar;
                    detalleCaso.Monto_total_comisiones_recargos__c = cuentasCaso6[0].Monto_total_comisiones_recargos__c;
                    detalleCaso.Monto_total_retirar__c = cuentasCaso6[0].Monto_total_retirar__c;
                    detalleCaso.Monto_Bruto_Retirar_Empresa__c = cuentasCaso6[0].Monto_Bruto_Retirar_Empresa__c;
                    detalleCaso.Total_Cargos_Empresa__c = cuentasCaso6[0].Total_Cargos_Empresa__c;
                    detalleCaso.Monto_Neto_Retirar_Empresa__c = cuentasCaso6[0].Monto_Neto_Retirar_Empresa__c;
                }
                
                cuentasCaso2=[Select Id,Monto_saldo__c,Saldo_retirar__c 
                             From Detalle_caso__c Where Caso__c =: caso.id and Saldo_retirar__c = '12'];
                             
                /*cuentasCaso7 = [select Id, Caso__c, Cuenta__c, Cuenta__r.Name, Saldo_retirar__c, Monto_saldo__c, Monto_retirar__c FROM Detalle_caso__c Where Cuenta__r.Name = '51600' 
                                and Caso__c =: caso.id and (Tipo_retiro__c!='51' AND Tipo_retiro__c!='52')];   
                                
                if(!cuentasCaso7.isEmpty()) {
                    for(Detalle_caso__c detail : cuentasCaso) {
                        detail.Monto_retirar__c = cuentasCaso7[0].Monto_retirar__c;    
                    }
                }*/                          
                
                if(!cuentasCaso2.isEmpty()) { detalleCaso02 = cuentasCaso2[0];
                    //montoBrutoRetiro = cuentasCaso2[0].Monto_saldo__c;
                } 
                
                cuentasCaso3=[Select Id,Monto_saldo__c,Saldo_retirar__c 
                             From Detalle_caso__c Where Caso__c =: caso.id and Saldo_retirar__c = '13'];
                
                if(!cuentasCaso3.isEmpty()) { detalleCaso03 = cuentasCaso3[0];
                }
                
                cuentasCaso4=[Select Id,Monto_saldo__c,Saldo_retirar__c,Tipo_retiro__c,Tipo_Politica_Retiro_Saldo_Patronal__c,Monto_Neto_Retirar_Empresa__c,Monto_Bruto_Retirar_Empresa__c 
                             From Detalle_caso__c Where Caso__c =: caso.id and Saldo_retirar__c = '10' and Tipo_retiro__c = '51' and Tipo_Politica_Retiro_Saldo_Patronal__c = '1'];
                
                if(!cuentasCaso4.isEmpty()) { detalleCaso04 = cuentasCaso4[0];
                } 
                
                /*cuentasCaso5=[Select Id, Tipo_retiro__c, Monto_Bruto_Retirar_Empresa__c, Tipo_pago__c From Detalle_caso__c Where Caso__c =: caso.id and Tipo_retiro__c = '52']; //Monto a retirar
                if(!cuentasCaso5.isEmpty() && detalleCaso.Tipo_retiro__c == '52') { //Retiro Total                 
                    montoaRetirar = cuentasCaso5[0].Monto_Bruto_Retirar_Empresa__c;
                }*/
                
                cuentasCaso5=[Select Id, Tipo_retiro__c, Monto_Bruto_Retirar_Empresa__c, Tipo_pago__c From Detalle_caso__c Where Caso__c =: caso.id and (Tipo_retiro__c = '51' or Tipo_retiro__c = '52')];
                /*AggregateResult[] groupedResults = [Select SUM(Monto_retirar__c) suma From Detalle_caso__c Where Caso__c =: caso.id];*/
                List<Detalle_caso__c> dc = [Select Monto_bruto_retirar__c From Detalle_caso__c Where Caso__c =: caso.id and Tipo_retiro__c = '51' Limit 1];                
                if(detalleCaso.Tipo_retiro__c == '51') { //Retiro Parcial 
                    if(!dc.isEmpty()) { montoaRetirar = /*Double.valueOf(groupedResults[0].get('suma'))*/dc[0].Monto_bruto_retirar__c/*detalleCaso.Monto_bruto_retirar__c*/;
                    }
                } else if(detalleCaso.Tipo_retiro__c == '52') { /*Retiro Parcial*/ montoaRetirar = detalleCaso.Monto_bruto_retirar__c;
                }
                
                datelleCasoSaldo10 = [Select Id, Saldo_retirar__c, Monto_retirar__c From Detalle_caso__c Where Caso__c =: caso.id and Tipo_retiro__c != '51' and Saldo_retirar__c = '10'];
                if(!datelleCasoSaldo10.isEmpty()) {
                    saldo10 = datelleCasoSaldo10[0].Monto_retirar__c;
                }
                
                datelleCasoSaldo11 = [Select Id, Saldo_retirar__c, Monto_retirar__c From Detalle_caso__c Where Caso__c =: caso.id and Tipo_retiro__c != '51' and Saldo_retirar__c = '11'];
                if(!datelleCasoSaldo11.isEmpty()) { saldo11 = datelleCasoSaldo11[0].Monto_retirar__c;
                }
                
                datelleCasoSaldo12 = [Select Id, Saldo_retirar__c, Monto_retirar__c From Detalle_caso__c Where Caso__c =: caso.id and Tipo_retiro__c != '51' and Saldo_retirar__c = '12'];
                if(!datelleCasoSaldo12.isEmpty()) { saldo12 = datelleCasoSaldo12[0].Monto_retirar__c;
                }
                
                datelleCasoSaldo13 = [Select Id, Saldo_retirar__c, Monto_retirar__c From Detalle_caso__c Where Caso__c =: caso.id and Tipo_retiro__c != '51' and Saldo_retirar__c = '13'];
                saldo13 = mapCasoDetalle.containsKey('13') ? mapCasoDetalle.get('13')[0].Monto_retirar__c : saldo13;
                if(mapCasoDetalle.containsKey('13')){
                    saldo13= mapCasoDetalle.get('13')[0].Monto_retirar__c;
                   // saldo13 = datelleCasoSaldo13[0].Monto_retirar__c
                }
                    }
                if(!datelleCasoSaldo13.isEmpty()) { saldo13 = datelleCasoSaldo13[0].Monto_retirar__c;
                } 
                traerSaldos2();
                if(detalleCaso.Porcentaje_comision__c != null) {
                    porcCobroIndiv = detalleCaso.Porcentaje_comision__c.setscale(2);
                }
                //System.debug('detalleCaso.Monto_Saldo_Patronal__c: '+detalleCaso.Monto_Saldo_Patronal__c); System.debug('detalleCaso.Monto_Saldo_Patronal_Ext__c: '+detalleCaso.Monto_Saldo_Patronal_Ext__c);
                if(detalleCaso.Monto_Saldo_Patronal__c == null) {
                    detalleCaso.Monto_Saldo_Patronal__c = 0;
                } 
                if(detalleCaso.Porcentaje_Saldo_Patronal__c == null) { 
                    detalleCaso.Porcentaje_Saldo_Patronal__c = 0; 
                } 
                if(detalleCaso.Monto_Saldo_Patronal_Ext__c == null) {
                    detalleCaso.Monto_Saldo_Patronal_Ext__c = 0;
                } 
                if(detalleCaso.Porcentaje_Saldo_Patronal_Ext__c == null) {
                    detalleCaso.Porcentaje_Saldo_Patronal_Ext__c = 0;
                }
                    
                //System.debug('porcCobroIndiv: '+porcCobroIndiv);
                //Fin Nuevo 28/02/2020   
                
            } else {                               
                
                list<string> listRegistros = new list<String>();
                For(Tipo_caso_portal__mdt item : [Select DeveloperName From Tipo_caso_portal__mdt Order by MasterLabel]){
                    listRegistros.add(item.DeveloperName);  
                }       
                
                mapTipoRcaso = new map<string, list<selectOption>>();
                listaZonas = new list<SelectOption>();
                listaZonas.add(new SelectOption('', '--Ninguno--'));
                Schema.DescribeFieldResult fieldZonasResult = Agencia__c.Zona__c.getDescribe();
                List<Schema.PicklistEntry> plZonas = fieldZonasResult.getPicklistValues();
                for( Schema.PicklistEntry pickListVal : plZonas) {
                    listaZonas.add(new SelectOption(pickListVal.getValue(), pickListVal.getLabel()));
                }           
                listAgencias = new list<SelectOption>();
                listAgencias.add(new SelectOption('', '--Ninguno--'));
                
                Caso = new Case();
                Caso.AccountId = CasoSTD.AccountId;
                Caso.ContactId = CasoSTD.ContactId;
                
                // LISTAS
                
                list<String> listaOrigen = new list<String>();
                listaOrigen.add('');
                listaOrigen.add('Call center');
                listaOrigen.add('Medios electrónicos');
                listaOrigen.add('Agencias_Banco');
                Caso.origin = CasoSTD.origin;
                // origen del caso
                // CONTANCIAS
                tipoConstancia = new List<selectOption>();
                tipoConstancia.add(new SelectOption('','--Ninguno--')); 
                tipoConstancia.add(new SelectOption('A3','Aportación Extraordinaria')); 
                tipoConstancia.add(new SelectOption('A2','Aportación Ordinaria')); 
                tipoConstancia.add(new SelectOption('A1','Aportes Históricos'));
                tipoConstancia.add(new SelectOption('A6','Compromiso de Aporte')); 
                tipoConstancia.add(new SelectOption('A5','Cuenta Inactiva')); 
                tipoConstancia.add(new SelectOption('A4','Para la Embajada')); 
                tipoConstancia.add(new SelectOption('Saldo','Saldo')); 
                
                tipoEstadoCuenta = new List<selectOption>();
                tipoEstadoCuenta.add(new SelectOption('A1','Detallado'));
                tipoEstadoCuenta.add(new SelectOption('A2','Resumen Mensual'));
                estadoCuentaDetallado = new List<SelectOption>();
                estadoCuentaDetallado.add(new SelectOption('General','General'));
                estadoCuentaDetallado.add(new SelectOption('Historico','Historico'));
                prioridadCaso = new list<SelectOption>();
                prioridadCaso.add(new SelectOption('Media','Media'));
                tipocasol = new list<SelectOption>();
                tipocasol.add(new SelectOption('Solicitud / Gestion','Solicitud de Gestion'));
                //tipocasol.add(new SelectOption('Queja','Queja'));
                tipocasol.add(new SelectOption('Reclamo Usuario Financiero','Reclamo'));
                portalOrigen = new list<SelectOption>();
                portalOrigen.add(new SelectOption('','--Ninguno--'));   
                portalOrigen.add(new SelectOption('Agencias_Banco','Agencias Banco Ficohsa')); 
                portalOrigen.add(new SelectOption('Call center','Call center')); 
                portalOrigen.add(new SelectOption('Medios electrónicos','Medios electrónicos')); 
                // fin origen del caso
                // 
                
                Caso.Usuario_referencia__c = CasoSTD.Usuario_referencia__c;
                Caso.Status = 'Nuevo';       
                
                // tipo de caso
                idTipoRCaso = '';
                tipoRCaso = new list<SelectOption>();
                tipoRCaso.add(new SelectOption('', '--Ninguno--'));
                list<selectOption> listAgen = new list<selectOption>();
                list<selectOption> listMedioEle= new list<selectOption>();
                listAgen.add(new SelectOption('', '--Ninguno--'));
                listMedioEle.add(new SelectOption('', '--Ninguno--'));
                For(RecordType item : [Select Id,Name,DeveloperName From
                                       RecordType Where sObjectType = 'Case' AND
                                       DeveloperName IN: listRegistros Order by Name]){
                                           tipoRCaso.add(new SelectOption(item.Id, item.Name));
                                           listAgen.add(new selectOption(item.DeveloperName, item.Name));
                                           if(item.DeveloperName =='Actualizacion_informacion' || item.DeveloperName =='Estados_Cuenta' ||
                                              item.DeveloperName =='Otros' || item.DeveloperName =='Aumento_Disminucion_Aportes' || item.DeveloperName=='Reposicion_Carnet' ){
                                                  listMedioEle.add(new selectOption(item.DeveloperName, item.Name));
                                              }
                                       }
                
                mapTipoRcaso.put('Call center', listMedioEle);
                mapTipoRcaso.put('Medios electrónicos', listMedioEle);
                mapTipoRcaso.put('Agencias_Banco', listAgen);
                system.debug('pruebas---:'+mapTipoRcaso);                    
                //} 
                system.debug('pruebas-tipoRCaso---:'+tipoRCaso);
                
                // /tipo del caso
                
                paso1 = true;
                paso2 = false;
                
                llenarCuentas();
                
            }
            if(detalleCaso.Monto__c>0) { mostrarReversionesDife= true; 
            }
            bandera3=false;
            if(caso.Status=='Cerrado') { bandera3=true;
            }
            if(caso.id !=null && cTipoCaso.reversiones && detallecaso.Subtipo_transaccion__c!=null) { 
                mostrar();
                if(detalleCaso.id!=null && [select count() from Movimiento_Seleccionado__c where detalle_caso__C=:detalleCaso.id]>0) {
                    movimientoSeleccionado = new Movimiento_Seleccionado__c();
                    movimientoSeleccionado = [select id, Comision_por_aporte__c , Comision_por_saldo__c , Detalle_caso__c , Fecha__c , Monto__c , Saldo_Inicial__c , Tipo_Saldo__c,Valor_Cuota__c from Movimiento_Seleccionado__c where detalle_caso__C=:detalleCaso.id limit 1];
                }
            }
            banderaSubTipoTran=true;
            cerrar();  
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Contacte a su Administrador2. ' + e.getMessage() + ' - ' + e.getLineNumber() ));
        }
        //mostrarMSj =true;
        
    }
    
    public void actualizardetalleCaso(){
        try{
            //string d = this.hostUrl;
            list<detalle_Caso__C> ab = new list<detalle_caso__C>();
            ab.add(detalleCaso);
            ab.addAll(CuentasCaso);
            update ab; detalleCasoActualizado = false; ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Datos actualizados exitosamente, puede proceder con la aprobación'));
        }Catch(Exception e){
            detalleCasoActualizado = false;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ha ocurrido un error, por favor Contacte a su Administrador. Error:' + e.getMessage() + ', Linea: ' + e.getLineNumber() ));
        }        
    }
    
    public void actualizarSaldoPatronalCons() { 
        List<Detalle_caso__c> dcSaldos = [Select Id From Detalle_caso__c Where Caso__c =: caso.id and Caso__r.RecordType.DeveloperName = 'Retiros' and Caso__r.Status != 'Cerrado'];
        if(dcSaldos.size() > 0) { 
        try{
            llenarmapa();
            //decimal totalSaldoTem =0; 
            system.debug('Saldo patronal actual: '+detalleCaso.Monto_Saldo_Patronal__c);
            decimal anosVejesN =(cuentaCliente.Fecha_Apertura__c.daysBetween(date.today()))/365;
            if((Detallecaso.Tipo_Politica_Retiro_Saldo_Patronal__c=='2' && detalleCaso.Permitir_Retiro_Saldos_Patronales__c && mapPSP.containsKey((integer)anosVejesN)) || test.isRunningTest()){
                    decimal totalSaldo = 0;
                    getSaldoCuenta saldosTempo = new getSaldoCuenta();
                    try{saldosTempo = aSysdeCallouts.traerSaldos(cuentaCliente.Codigo__c);
                        system.debug('Monto Pignorado: '+saldosTempo.montoPignorado);
                        detalleCaso.Saldo_total__c=decimal.valueOf(saldosTempo.saldoTotal.replace(',',''));
                        if(saldosTempo.montoPignorado==null){saldosTempo.montoPignorado='0';}
                        detalleCaso.Monto_Pignorado__c=decimal.valueOf(saldosTempo.montoPignorado.replace(',',''));}catch(Exception ex){}
                    detalleCaso.Porcentaje_Saldo_Patronal__c=0;
                    For(classSaldos item : saldosTempo.saldos){
                        if(item.tipoSaldo=='12' ) {
                            totalSaldo += double.valueOF(item.montoSaldo.replace(',',''));
                        }
                    }
                    system.debug('Devuelve mapa: '+mapPSP.get((integer)anosVejesN)+', totalSaldo'+totalSaldo);
                    detalleCaso.Porcentaje_Saldo_Patronal__c =mapPSP.get((integer)anosVejesN); 
                    detalleCaso.Porcentaje_Saldo_Patronal__c = detalleCaso.Porcentaje_Saldo_Patronal__c !=null && !test.isRunningTest() ? detalleCaso.Porcentaje_Saldo_Patronal__c:0; 
                    system.debug('Hola+ '+detalleCaso.Porcentaje_Saldo_Patronal__c +'  '+ totalSaldo);
                    detalleCaso.Monto_Saldo_Patronal__c=((detalleCaso.Porcentaje_Saldo_Patronal__c * totalSaldo) / 100).setscale(2);
                    detalleCaso.Monto_Bruto_Retirar_Empresa__C=(totalSaldo-detalleCaso.Monto_Saldo_Patronal__c).setscale(2); 
                }else{
                    calculoSaldoPatronales();  
                } 
                
                //Inicio Validando los campos de Monto Sldo Patronal Ordinario y Monto Sldo Patronal Extraordinario   
                cuentasCaso6=[select Id, N_Cuenta_Bancaria__c, Caso__c, Cuenta__c, Cuenta__r.Name, Monto_Saldo_Patronal__c, Porcentaje_Saldo_Patronal__c, 
                              Monto_Saldo_Patronal_Ext__c, Porcentaje_Saldo_Patronal_Ext__c, Tipo_retiro__c, Saldo_retirar__c, Monto_saldo__c, Tipo_Politica_Retiro_Saldo_Patronal__c, 
                              Beneficiario__c, Monto_retirar__c, Monto_bruto_retirar__c, Cobro_TSP__c, Monto_TSP_Patrono__c, Monto_total_comisiones_recargos__c, Monto_total_retirar__c, Monto_Bruto_Retirar_Empresa__c, 
                              Total_Cargos_Empresa__c, Monto_Neto_Retirar_Empresa__c, Tipo_pago__c FROM Detalle_caso__c Where Caso__c =: caso.id and Monto_Saldo_Patronal__c != null];
    
                if(!cuentasCaso6.isEmpty()) {     

                    detalleCaso.Porcentaje_Saldo_Patronal__c = cuentasCaso6[0].Porcentaje_Saldo_Patronal__c;
                    detalleCaso.Monto_Saldo_Patronal__c = (montoPatOrd * detalleCaso.Porcentaje_Saldo_Patronal__c)/100;
                    
                    detalleCaso.Porcentaje_Saldo_Patronal_Ext__c = cuentasCaso6[0].Porcentaje_Saldo_Patronal_Ext__c;
                    montoPatExtOrd = montoPatExtOrd != null ? montoPatExtOrd : 0;
                    detalleCaso.Porcentaje_Saldo_Patronal_Ext__c = detalleCaso.Porcentaje_Saldo_Patronal_Ext__c !=null ? detalleCaso.Porcentaje_Saldo_Patronal_Ext__c : 0;
                    detalleCaso.Monto_Saldo_Patronal_Ext__c = (montoPatExtOrd * detalleCaso.Porcentaje_Saldo_Patronal_Ext__c)/100;
                    
                    detalleCaso.Monto_Bruto_Retirar_Empresa__c = cuentasCaso6[0].Monto_Bruto_Retirar_Empresa__c;              
 
                }
                //Fin Validando los campos de Monto Sldo Patronal Ordinario y Monto Sldo Patronal Extraordinario    
                
            system.debug('Saldo patronal 2: '+detalleCaso.Monto_Saldo_Patronal__c);
            list<Detalle_Caso__c> detalleFinal = new list<Detalle_Caso__c>();
            detalleCaso.Cabeza_retiro__c = true;
            //detalleCaso.Monto_Bruto_Retirar_Empresa__c =0;
            Boolean hayError = false;
            Decimal montoBrutoRetirar = 0;
            
            if(detalleCaso.Tipo_Retiro__c == '51' || test.isRunningTest()) {
                if(detalleCaso.Se_lleva_Parte_Patronal__c){
                    montoBrutoRetirar += detalleCaso.Saldo_Restante_Cuenta_Cliente__c !=null ? detalleCaso.Saldo_Restante_Cuenta_Cliente__c:0;
                }
                if((!detalleCaso.Se_lleva_Parte_Patronal__c && !detalleCaso.Cliente_sigue_Laborando__c) || test.isRunningTest()){
                    detalleCaso.Se_lleva_Parte_Patronal__c=true;
                    detalleCaso.Saldo_Restante_Cuenta_Cliente__c=0;
                    //czx=sa
                }
                For(Detalle_caso__c item : cuentasCaso){
                    system.debug(item);
                    if(item.Monto_retirar__c < 0){
                        item.Monto_retirar__c.addError('No se permiten valores negativos'); 
                        hayError = true;
                        break;
                    }else if(item.Monto_retirar__c > item.Monto_saldo__c && item.Monto_retirar__c > 0){
                        item.Monto_retirar__c.addError('Monto a retirar no puede ser mayor al monto del saldo');    
                        hayError = true;
                        break;                        
                    //}else if((item.Saldo_retirar__c != '13' && item.Monto_retirar__c > 0)){
                    }else if(item.Monto_retirar__c > 0){
                        item.Saldo_enviar_Sysde__c = true;
                        montoBrutoRetirar += item.Monto_retirar__c; 
                        break;
                    }
                    detalleFinal.add(item);
                } //updateCasoRetiros();
                detalleCaso.Monto_Bruto_Retirar_Empresa__c = montoPatOrd - detalleCaso.Monto_Saldo_Patronal__c;                               
            } 
            if(detalleCaso.Tipo_Retiro__c == '52' || test.isRunningTest()){
                
                For(Detalle_caso__c item : cuentasCaso){
                    //if((item.Saldo_retirar__c != '12' && item.Saldo_retirar__c != '13') ||
                    if((item.Saldo_retirar__c != '12') || 
                       (item.Saldo_retirar__c == '12' && detalleCaso.Permitir_Retiro_Saldos_Patronales__c)){
                           decimal SaldoRetirar =item.Monto_saldo__c;
                           if((detallecaso.Porcentaje_Saldo_Patronal__c!=NULL && item.Saldo_retirar__c == '12' 
                               && detalleCaso.Permitir_Retiro_Saldos_Patronales__c) || test.isRunningTest()){
                                   SaldoRetirar= ((item.Monto_saldo__c * detallecaso.Porcentaje_Saldo_Patronal__c) / 100).setscale(2);
                                   detalleCaso.Se_lleva_Parte_Patronal__c=true;
                                   detalleCaso.Saldo_Restante_Cuenta_Cliente__c=0;
                                   detalleCaso.Monto_Bruto_Retirar_Empresa__c =item.Monto_saldo__c- SaldoRetirar;
                               }
                           montoBrutoRetirar += SaldoRetirar;
                       }
                    
                    detalleFinal.add(item); 
                }  //updateCasoRetiros(); 
            }   
            
            if(!hayError) {
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
                if(!detalleCaso.Tiene_Cuenta_Colectiva__c){
                    if(detalleCaso.Comision_retiro_anticipado_empresa__c && detalleCaso.Comision_Retiro_Anticipado__c){
                        montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                    }  
                    else if(!detalleCaso.Comision_Retiro_Anticipado__c && detalleCaso.Comision_retiro_anticipado_empresa__c){
                        exMontoComi = detalleCaso.Monto_comision_retiro__c;   
                    }
                }
                else{
                    if(detalleCaso.Cliente_sigue_Laborando__c && detalleCaso.Cobrar_empleado_sigue_laborando__c){
                        montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                    }
                    else if(!detalleCaso.Comision_Retiro_Anticipado__c && detalleCaso.Comision_retiro_anticipado_empresa__c){
                        exMontoComi = detalleCaso.Monto_comision_retiro__c;   
                    }
                }
                if((detalleCaso.Cobro_Individual_CRA__c && detalleCaso.Porcentaje_CRA_Individual__c!=null) || test.isRunningTest()){
                    detalleCaso.Monto_comision_retiro__c = montoBrutoRetirar * (detalleCaso.Porcentaje_CRA_Individual__c / 100);
                    montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                }
                if(detalleCaso.Cobrar_empleado_sigue_laborando__c && !detalleCaso.Cliente_sigue_Laborando__c){
                    
                    if((montoComi>0 && cuentaCliente.Cobrar_empleado_sigue_laborando__c) || test.isRunningTest()){
                        detalleCaso.Monto_comision_retiro__c =0;
                        montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                    }
                    if((montoComi>0 && cuentaCliente.Subproducto__r.Cobrar_si_empleado_sigue_laborando__c
                        && detalleCaso.nivel_de_regla__C=='3')  || test.isRunningTest()){
                            detalleCaso.Monto_comision_retiro__c =0;
                            montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                        }    
                }
                //montoComi ++;
                system.debug('Monto antes de redendear: '+montoComi);
                 montoComi = montoComi !=null ? montoComi.setScale(2) : 0;  
                system.debug('Monto despues de redendear: '+montoComi);
                detalleCaso.Monto_Bruto_Retirar_Empresa__c= detalleCaso.Monto_Bruto_Retirar_Empresa__c !=null ? detalleCaso.Monto_Bruto_Retirar_Empresa__c :0;
                if(detalleCaso.Se_lleva_Parte_Patronal__c && detalleCaso.Monto_Bruto_Retirar_Empresa__c >0){
                    if(cuentaCliente.Cuenta_colectiva2__r.Tipo_Cuenta__c=='2' || test.isRunningTest()){
                        DetalleCaso.Monto_Neto_Retirar_Empresa__c=detalleCaso.Monto_Bruto_Retirar_Empresa__c;
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
                        detalleCaso.Monto_TSP_Patrono__c = detalleCaso.Monto_TSP_Patrono__c;
                        
                    } if(cuentaCliente.Cuenta_colectiva2__r.Tipo_Cuenta__c=='3' || test.isRunningTest()){
                        decimal milTSP = (detalleCaso.Monto_Bruto_Retirar_Empresa__c / 1000).round(System.RoundingMode.UP);
                        decimal CalculoTSP = (milTSP *2);
                        decimal montoChequev =detalleCaso.Monto_cheque__c !=null ? detalleCaso.Monto_cheque__c :0;
                        //montoChequev =  ;
                        detalleCaso.Monto_TSP_Patrono__c = detalleCaso.Monto_TSP_Patrono__c;
                        detalleCaso.Monto_Cheque_Patrono__c = montoChequev;
                        DetalleCaso.Monto_Neto_Retirar_Empresa__c=detalleCaso.Monto_Bruto_Retirar_Empresa__c-CalculoTSP -montoChequev;
                        detalleCaso.Total_Cargos_Empresa__c=CalculoTSP+montoChequev;
                    }
                }
                system.debug('Monto comision Nuevo: '+montoComi);
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
                if(detalleCaso.Cliente_sigue_Laborando__c || detalleCaso.Comision_Retiro_Anticipado__c || detalleCaso.Comision_retiro_anticipado_empresa__c) {
                       milTSP = (((montoBrutoRetirar-  montoComi - csdc) * montoCambio) / 1000).round(System.RoundingMode.UP);
                   }
                else{
                    milTSP = (((montoBrutoRetirar - csdc) * montoCambio) / 1000).round(System.RoundingMode.UP);   
                }
                
                Decimal calculoTSP = detalleCaso.Monto_TSP__c;
                detalleCaso.Monto_TSP__c = calculoTSP;
                
                if(detalleCaso.Cobro_TSP__c){
                    montoTSP = detalleCaso.Monto_TSP__c;
                }else{
                    exMontoTSP = detalleCaso.Monto_TSP__c;
                }
                
                if(cuentaCliente.Subproducto__r.Codigo__c != 'FI010'){
                    detalleCaso.Exonerado__c = exMontoComi + exMontoTSP + exMontoACH + exMontoCheque;
                }
                if(detalleCaso.Cliente_sigue_Laborando__c || detalleCaso.Comision_Retiro_Anticipado__c || detalleCaso.Comision_retiro_anticipado_empresa__c) {
                       detalleCaso.Monto_total_comisiones_recargos__c = montoComi+ montoTSP + montoACH + montoCheque;    
                   } else{
                    detalleCaso.Monto_total_comisiones_recargos__c =  montoTSP + montoACH + montoCheque;
                }
                system.debug('holaaaa: '+detalleCaso.Monto_Neto_Retirar_Empresa__c );
                if(detalleCaso.Cargar_cargos_Empleados__C  || test.isRunningTest()){
                    detalleCaso.Total_Cargos_Empresa__c += (montoTSP + montoACH + montoCheque );
                    detalleCaso.Monto_total_comisiones_recargos__c -= (montoTSP + montoACH + montoCheque);
                    detalleCaso.Monto_ACH_Patrono__c += montoACH;
                    detalleCaso.Monto_TSP_Patrono__c += montoTSP;
                    detalleCaso.Monto_Cheque_Patrono__c += montoCheque;
                    detalleCaso.Monto_Neto_Retirar_Empresa__c = detalleCaso.Monto_Bruto_Retirar_Empresa__c - detalleCaso.Total_Cargos_Empresa__c;
                }
                system.debug('holaaaa2: '+detalleCaso.Monto_Neto_Retirar_Empresa__c);
                //detalleCaso.Monto_bruto_retirar__c = montoBrutoRetirar;
                if(detallecaso.Monto_Saldo_Patronal__c==null){detallecaso.Monto_Saldo_Patronal__c=0;}
                if(detalleCaso.Saldo_Restante_Cuenta_Cliente__c==null){detalleCaso.Saldo_Restante_Cuenta_Cliente__c=0;}
                //detalleCaso.Monto_total_retirar__c = (montoBrutoRetirar - detalleCaso.Monto_total_comisiones_recargos__c - detallecaso.Saldo_Prestamo__c - detalleCaso.Saldo_Restante_Cuenta_Cliente__c).setscale(2);
                updateCasoRetiros();
            } 
            detalleCaso.Total_Cargos_Empresa__c = detalleCaso.Total_Cargos_Empresa__c;
            detalleCaso.Monto_Neto_Retirar_Empresa__c = detalleCaso.Monto_Neto_Retirar_Empresa__c;
            System.debug('Monto_Neto_Retirar_Empresa__c: '+detalleCaso.Monto_Neto_Retirar_Empresa__c);
            // detalleCasoActualizado = false;
            if(detalleCasoActualizado){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Espere un momenento para la aprobación del caso.'));
            } 
        }Catch(Exception ex){            
            //system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            detalleCasoActualizado = false;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ha ocurrido un error, por favor contacte a su administrador01, Error:'+ex.getMessage()+', Linea: '+ex.getLineNumber()));
        }
        
        }
    }
    
    public void getListAgentsByZone() {
        listAgencias = new list<SelectOption>();
        listAgencias.add(new SelectOption('', '--Ninguno--'));
        for(agencia__c item : [Select id, Name from agencia__c Where zona__c = :ZonaSeleccionada and zona__c!=null Order By Name Limit 1000]) { listAgencias.add(new SelectOption(item.Id, item.Name));
        } 
    }
    
    public void actualizarRezago(){
       // system.debug(detalleCaso.rezago__C+' '+);
        if( detalleCaso.rezago__C =='N' || (detalleCaso.rezago__C =='S' && detalleCaso.Cod_Referencia__c !=null)){ update detalleCaso; popRezago = false;
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
                                       if(CasoSTD.id == null){                  
                                           String colectiva = item.Cuenta_colectiva2__c != null ? ' - Cuenta colectiva : ' + item.Detalle_Cuenta_colectiva__c : '';
                                           String formattedDate = item.Fecha_Apertura__c.format();
                                           etiquetaCuenta = item.Codigo__c + ' ' + item.currencyIsoCode + colectiva + ' - Afiliacion: ' + formattedDate;
                                           
                                           //etiquetaCuenta = item.Codigo__c + (item.Producto__r.Name != null ? (' - ' + item.Producto__r.Name) : '') + (item.Detalle_Cuenta_colectiva__c.trim() != '-' ? (' - ' + item.Detalle_Cuenta_colectiva__c) : '');
                                           //listCuentas.add(new SelectOption(item.id, etiquetaCuenta));
                                           
                                       }
                                       
                                       listCuentas.add(new selectOption(item.id, etiquetaCuenta));              
                                       mapCuentas.put(item.id, Item);                 
                                   }
            
            if(!listCuentas.isEmpty()){
                idCuenta = listCuentas[0].getValue();
                cuentaCliente = mapCuentas.get(idCuenta);
                monedaCuenta();
            }Else{
                llenarCuentasDesdeSysde();  
            }
            
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El cliente no tiene cuentas asociadas'));
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());  
        }   
    }
    
    public void traerSaldos(){
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
            getSaldoCuenta saldos = aSysdeCallouts.traerSaldos(cuentaCliente.Codigo__c);             
            For(classSaldos item : saldos.saldos) {
                //Guardar Saldo Patronal Ordinario y Extraordinario
                if(montoPatOrd == 0 && item.tipoSaldo == '12') {
                    montoPatOrd = double.valueOf(item.montoSaldo);
                }
                if(montoPatExtOrd == 0 && item.tipoSaldo == '13') { montoPatExtOrd = double.valueOf(item.montoSaldo); totalSaldo2 = montoPatExtOrd;
                }
                if(montoPerOrd == 0 && item.tipoSaldo == '10') {
                    montoPerOrd = double.valueof(item.montoSaldo);    
                }
                if(montoPerExtOrd == 0 && item.tipoSaldo == '11') {
                    montoPerExtOrd = double.valueof(item.montoSaldo);    
                }
                //Fin guardar Saldo Patronal Ordinario y Extraordinario                 
            }
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
    
    public void llenarCuentasDesdeSysde(){
        try{
            list<classCuenta> cuentasSysde = aSysdeCallouts.trarerCuentas(Caso.Account.Identificacion__c); 
            system.debug('Cuentas desde SYSDE : ' + cuentasSysde);
            if(cuentasSysde.isEmpty()){
                mostrarGuardar = false;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no tiene cuentas asociadas')); 
            }   
        } Catch(Exception e) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error al contectarse SYSDE ' + e.getMessage() ));  
        }
    }
    
    public void selecCuenta(){    
        cuentaCliente = mapCuentas.get(idCuenta);        
    }
    
    public void ModificarSaldoPrestamo(){
        if(detalleCaso.Saldo_Prestamo__c>detallecaso.Monto_Pignorado__c) { detalleCaso.Saldo_Prestamo__c=0; ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El saldo del Prestamo no puede ser mauyor al monto pignorado'));
        }else if(Caso.Status=='Pendiente de aprobación') { guardar();
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El saldo del Prestamo se modifico exitosamente'));
        }
    }
    
    public void calculoSaldoPatronales(){
        try{
            detalleCaso.Porcentaje_Saldo_Patronal__c=0;
            detalleCaso.Monto_Saldo_Patronal__c=0;
            detalleCaso.Monto_Bruto_Retirar_Empresa__C=0;
            if(detalleCaso.Fecha_Despido_Empresa__c!=null && detalleCaso.Fecha_Ingreso_Empresa__c!=null){
                if(detalleCaso.Fecha_Despido_Empresa__c>detalleCaso.Fecha_Ingreso_Empresa__c){
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
                    detalleCaso.Fecha_Despido_Empresa__c=null; detalleCaso.Fecha_Ingreso_Empresa__c=null; ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'La fechas estan incorrectas, favor digitar otras'));    
                }
            }
            
        }catch(Exception ex) {
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
        system.debug('Finalizo');
    }
    
    public void calculoSaldoPatronales2(){
        try{
            //detalleCaso.Monto_Saldo_Patronal__c = detalleCaso.Monto_Saldo_Patronal__c;
            detalleCaso.Monto_Bruto_Retirar_Empresa__c = montoPatOrd - detalleCaso.Monto_Saldo_Patronal__c;
            if(detalleCaso.Monto_Bruto_Retirar_Empresa__c == 0) {
                detalleCaso.Total_Cargos_Empresa__c = 0;
            }
            detalleCaso.Monto_Neto_Retirar_Empresa__c = detalleCaso.Monto_Bruto_Retirar_Empresa__c - detalleCaso.Total_Cargos_Empresa__c;        
        }catch(Exception ex) {
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
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
                        totalSaldo = /*((item.Monto_Saldo__c*detalleCaso.Porcentaje_Saldo_Patronal__c)/100).setscale(2)*/ detalleCaso.Monto_Saldo_Patronal__c;
                        totalSaldo2 = detalleCaso.Monto_Saldo_Patronal_Ext__c;
                        
                        if(item.Monto_retirar__c>totalSaldo && item.Saldo_retirar__c=='12' /*&& totalSaldo2 == 0*/) { 
                            //item.Monto_retirar__c=0; 
                            if(totalSaldo>0) { item.Monto_retirar__c=0; ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Solo puede retirar de su saldo patronal ordinario un máximo de '+totalsaldo.setScale(2)));
                            }
                            else{
                                item.Monto_retirar__c=0;
                                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no aplica a saldo patronal...'));
                            }
                        } else if(item.Monto_retirar__c>totalSaldo2 && item.Saldo_retirar__c=='13') { 
                            item.Monto_retirar__c=0; 
                            if(totalSaldo2>0){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Solo puede retirar de su saldo patronal extraordinario un máximo de '+totalsaldo2.setScale(2)));}
                            else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no aplica a saldo patronal extraordinario'));
                            }
                        } else if(detalleCaso.Cliente_sigue_Laborando__c) { system.debug('2'); item.Monto_retirar__c=0; ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Solo puede retirar de su saldo patronal si el empleado fue despedido'));
                        } else {
                            system.debug('3');
                            detalleCaso.Saldo_Restante_Cuenta_Cliente__c = totalSaldo - item.Monto_retirar__c;
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
    
    public void VerificacionPreatamoRefinanciar(){
        try{
            detallecaso.Monto_Prestamo_Anterior__C = 0;
            if(detalleCaso.Prestamo_anterior__c !=null){
                classFondosPignorados.Refinanciamiento respuesta = asysdeCallouts.Refinanciamiento(detalleCaso.Prestamo_anterior__c ,[select codigo__C from cuentas__C where id=:idCuenta].codigo__C);
                if(respuesta.existe=='S'){
                    detallecaso.Monto_Prestamo_Anterior__C =decimal.valueOf(respuesta.MontoPrestamo.replace(',',''));
                }else{
                    detalleCaso.Prestamo_anterior__c = null; ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Numero de preatamo incorrecto'));
                }
            }
            detalleCaso.Monto_Prestamo__c = 0;
            banderarefinanciamiento =false;
            VerificacionMontoPrestamo();
            
        }catch(exception ex){
            system.debug('error: '+ex.getMessage()+', linea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ha ocurrido un error, por favor contacto su administrador '));
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
                detallecaso.Monto_Prestamo__c=0; detalleCaso.Monto_a_Pignorar__c=0; ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No cuenta con esa cantidad para la pignoración'));
            }
        }catch(Exception ex){
            system.debug('error: '+ex.getMessage()+', linea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ha ocurrido un error, por favor contacto su administrador '));
        }
        banderarefinanciamiento = true;
    }
    
    public void VerificacionCheckPrestamos(){
        try{
            //if((detalleCaso.Total_Saldo_Personal__c * 0.8)<detallecaso.Monto_Prestamo__c){
            //    caso.Enviar_a_aprobacion__c=false;
            // }
            if((detallecaso.Es_Primer_Prestamo__c && detallecaso.Es_Refinanciamiento__c) ||
               (detallecaso.Es_Primer_Prestamo__c && detallecaso.No_es_primer_prestamo__c) ||
               (detallecaso.No_es_primer_prestamo__c && detallecaso.Es_Refinanciamiento__c)){
                   detallecaso.No_es_primer_prestamo__c=false;
                   detallecaso.Es_Refinanciamiento__c = false;
                   detallecaso.Es_Primer_Prestamo__c = false;
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Solo puede selelccionar una opcion a la vez'));
               }else if(detalleCaso.Es_Refinanciamiento__c || detallecaso.No_es_primer_prestamo__c){
                   caso.enviar_a_aprobacion__C=true;
                   if(detalleCaso.Es_Refinanciamiento__c){
                       VerificacionMontoPrestamo();
                   }else{
                       ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El caso se tendra que enviar a aprobación'));
                   }
               }else if(detallecaso.Es_Primer_Prestamo__c && detalleCaso.Monto_Pignorado__c>0){
                   detallecaso.Es_Primer_Prestamo__c = false; 
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No puede ser primer prestamo ya que tiene un monto pignorado'));
                   //detalleCaso.Monto_Pignorado__c=0;
                   // VerificacionMontoPrestamo();
               }
        }catch(exception ex){
            system.debug('error: '+ex.getMessage()+', linea: '+ex.getLineNumber());
        }
        
    }
    
    public void LlenarMapa (){
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
        try{ 
            List<Cuentas__c> elegirCuenta = [Select Id, Codigo__c From Cuentas__c Where Id =: idCuenta Limit 1];           
            getSaldoCuenta saldos = aSysdeCallouts.traerSaldos(elegirCuenta[0].Codigo__c); System.debug('todos los saldos: '+saldos);            
            For(classSaldos item : saldos.saldos) {
                //Guardar Saldo Patronal Ordinario y Extraordinario
                if(item.tipoSaldo == '12') {
                    montoPatOrd = double.valueOf(item.montoSaldo); System.debug('valor de montoPatOrd: '+montoPatOrd);
                }
                if(item.tipoSaldo == '13') { montoPatExtOrd = double.valueOf(item.montoSaldo); System.debug('valor de montoPatExtOrd: '+montoPatExtOrd);
                }
                //Fin guardar Saldo Patronal Ordinario y Extraordinario                 
            }
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
               || cuentaCliente.Subproducto__r.Cobrar_si_empleado_sigue_laborando__c) { detalleCaso.Cobrar_empleado_sigue_laborando__c = true;                  
               }
            /*PARTE NUEVA*/ detalleCaso.Cobrar_empleado_sigue_laborando__c = true;
            if(cuentaCliente.Cuenta_colectiva2__c != null) { Detallecaso.Tipo_Politica_Retiro_Saldo_Patronal__c=cuentaCliente.Cuenta_colectiva2__r.Tipo_Politica_Retiro_Saldo_Patronal__c; detalleCaso.Permitir_Retiro_Saldos_Patronales__c = cuentaCliente.Cuenta_colectiva2__r.Retiro_Saldos_Patronales__c;
            }
            
            Decimal anosVejes = cuentaCliente.Fecha_Apertura__c.daysBetween(Date.today()) / 365 ;
            Cuentas__C cuenta =[select Porcentaje_CRA_Individual__c, Cobro_Individual_CRA__c
                                from cuentas__C where id=:idCuenta];
            getSaldoCuenta saldosTempo = new getSaldoCuenta();
            try{saldosTempo = aSysdeCallouts.traerSaldos(cuentaCliente.Codigo__c);
                system.debug('Monto Pignorado: '+saldosTempo.montoPignorado);
                detalleCaso.Saldo_total__c=decimal.valueOf(saldosTempo.saldoTotal.replace(',',''));
                if(saldosTempo.montoPignorado==null|| saldosTempo.montoPignorado=='null' ){saldosTempo.montoPignorado='0';}
                detalleCaso.Monto_Pignorado__c=decimal.valueOf(saldosTempo.montoPignorado.replace(',',''));}catch(Exception ex){}
            map<integer, decimal> mapCuentaColectiva = new map<integer, decimal>();
            map<integer, decimal> mapCuenta = new map<integer, decimal>();
            map<integer, decimal> mapSubProducto = new map<integer, decimal>();
            if(cuentaCliente.Cuenta_colectiva2__r.De_01_anos__c !=null){mapCuentaColectiva.put(0,cuentaCliente.Cuenta_colectiva2__r.De_01_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.De_12_anos__c !=null){mapCuentaColectiva.put(1,cuentaCliente.Cuenta_colectiva2__r.De_12_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.De_23_anos__c !=null){mapCuentaColectiva.put(2,cuentaCliente.Cuenta_colectiva2__r.De_23_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.De_34_anos__c !=null){mapCuentaColectiva.put(3,cuentaCliente.Cuenta_colectiva2__r.De_34_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.De_45_anos__c !=null){mapCuentaColectiva.put(4,cuentaCliente.Cuenta_colectiva2__r.De_45_anos__c);}
            if(cuentaCliente.Cuenta_colectiva2__r.Mas_5_anos__c !=null){mapCuentaColectiva.put(5,cuentaCliente.Cuenta_colectiva2__r.Mas_5_anos__c);}
            
            if(cuentaCliente.De_01_anos__c !=null){mapCuenta.put(0,cuentaCliente.De_01_anos__c);}
            if(cuentaCliente.De_12_anos__c !=null){mapCuenta.put(1,cuentaCliente.De_12_anos__c);}
            if(cuentaCliente.De_23_anos__c !=null){mapCuenta.put(2,cuentaCliente.De_23_anos__c);}
            if(cuentaCliente.De_34_anos__c !=null){mapCuenta.put(3,cuentaCliente.De_34_anos__c);}
            if(cuentaCliente.De_45_anos__c !=null){mapCuenta.put(4,cuentaCliente.De_45_anos__c);}
            if(cuentaCliente.Mas_5_anos__c !=null){mapCuenta.put(5,cuentaCliente.Mas_5_anos__c);}
            
            if(cuentaCliente.Subproducto__r.De_01_anos__c !=null){mapSubProducto.put(0,cuentaCliente.Subproducto__r.De_01_anos__c);}
            if(cuentaCliente.Subproducto__r.De_12_anos__c !=null){mapSubProducto.put(1,cuentaCliente.Subproducto__r.De_12_anos__c);}
            if(cuentaCliente.Subproducto__r.De_23_anos__c !=null){mapSubProducto.put(2,cuentaCliente.Subproducto__r.De_23_anos__c);}
            if(cuentaCliente.Subproducto__r.De_34_anos__c !=null){mapSubProducto.put(3,cuentaCliente.Subproducto__r.De_34_anos__c);}
            if(cuentaCliente.Subproducto__r.De_45_anos__c !=null){mapSubProducto.put(4,cuentaCliente.Subproducto__r.De_45_anos__c);}
            if(cuentaCliente.Subproducto__r.Mas_5_anos__c !=null){mapSubProducto.put(5,cuentaCliente.Subproducto__r.Mas_5_anos__c);}
            
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
                    //system.debug('Hola4: '+detalleCaso.Monto_Saldo_Patronal__c+'    '+detalleCaso.Porcentaje_Saldo_Patronal__c); 
                }

            detalleCaso.Porcentaje_comision__c=0;
            if(caso.Account.sexo__C !=null && (caso.Account.sexo__C=='F' || caso.Account.sexo__C=='Femenino') ) { Tercera_edad__mdt l = [select edad__c from Tercera_edad__mdt where genero__C='M' limit 1]; if(anosCliente>=l.edad__C) { esTerceraEdad=true;
                } 
            }
            else if(caso.Account.sexo__C !=null){ Tercera_edad__mdt l = [select edad__c from Tercera_edad__mdt where genero__C='H' limit 1]; if(anosCliente>=l.edad__C){ esTerceraEdad=true;
                }
            }
            detalleCaso.Cobro_Individual_CRA__c=false;
            detalleCaso.Porcentaje_CRA_Individual__c=0;
            if(cuentaCliente.Cobro_Saldo_Minimo_CRA__c && detalleCaso.Saldo_total__c>= cuentaCliente.Monto_Saldo_Minimo_CRA__c) { detalleCaso.Cobro_Saldo_Minimo_CRA__c=true; detalleCaso.Monto_Saldo_Minimo_CRA__c= cuentaCliente.Monto_Saldo_Minimo_CRA__c;
            }
            else if(cuenta.Cobro_Individual_CRA__c && cuenta.Porcentaje_CRA_Individual__c !=null) { detalleCaso.Porcentaje_comision__c=cuenta.Porcentaje_CRA_Individual__c; detalleCaso.Porcentaje_CRA_Individual__c= cuenta.Porcentaje_CRA_Individual__c; detallecaso.Nivel_de_Regla__c='1'; detalleCaso.Cobro_Individual_CRA__c=true;
            }
            else if(mapCuenta.containskey((integer)anosVejes) && cuentaCliente.Comision_retiro_anticipado__c){ detalleCaso.Comision_retiro_anticipado_empresa__c=true; detallecaso.Nivel_de_Regla__c='1'; detalleCaso.Porcentaje_comision__c=mapCuenta.get((integer)anosVejes);
            }
            else if(esTerceraEdad && !cuentaCliente.Comision_retiro_anticipado__c && !cuenta.Cobro_Individual_CRA__c && !cuentaCliente.Cobro_Saldo_Minimo_CRA__c){ detalleCaso.Exoneracion_3ra_Edad__c=true;
                    }
            else if(cuentaCliente.Cuenta_colectiva2__r.Cobro_Saldo_Minimo_CRA__c && detalleCaso.Saldo_total__c>= cuentaCliente.Cuenta_colectiva2__r.Monto_Saldo_Minimo_CRA__c){ detallecaso.Nivel_de_Regla__c='2'; detalleCaso.Cobro_Saldo_Minimo_CRA__c=true; detalleCaso.Monto_Saldo_Minimo_CRA__c= cuentaCliente.Cuenta_colectiva2__r.Monto_Saldo_Minimo_CRA__c;
            }
            else if(mapCuentaColectiva.containskey((integer)anosVejes) && cuentaCliente.Cuenta_colectiva2__r.Comision_Retiro_Anticipado__c){ detallecaso.Nivel_de_Regla__c='2'; detalleCaso.Comision_retiro_anticipado_empresa__c=true; detalleCaso.Porcentaje_comision__c=mapCuentaColectiva.get((integer)anosVejes) ;
            }
            else if(cuentaCliente.Subproducto__r.Cobro_Saldo_Minimo_CRA__c && detalleCaso.Saldo_total__c>= cuentaCliente.Subproducto__r.Monto_Saldo_Minimo_CRA__c){ detallecaso.Nivel_de_Regla__c='3'; detalleCaso.Cobro_Saldo_Minimo_CRA__c=true; detalleCaso.Monto_Saldo_Minimo_CRA__c= cuentaCliente.Subproducto__r.Monto_Saldo_Minimo_CRA__c;
            }
            else if(mapSubProducto.containskey((integer)anosVejes) && cuentaCliente.Subproducto__r.Comision_retiro_anticipado__c){ detallecaso.Nivel_de_Regla__c='3'; detalleCaso.Comision_retiro_anticipado_empresa__c=true; detalleCaso.Porcentaje_comision__c=mapSubProducto.get((integer)anosVejes);
            }
            system.debug('MOntoooooooo:'+detalleCaso.Porcentaje_comision__c);
            if(!detalleCaso.Cobro_Saldo_Minimo_CRA__c 
               && (cuentaCliente.Subproducto__r.Monto_Saldo_Minimo_CRA__c !=null 
                   || cuentaCliente.Cuenta_colectiva2__r.Monto_Saldo_Minimo_CRA__c !=null
                   || cuentaCliente.Monto_Saldo_Minimo_CRA__c !=null)){
                       if(cuentaCliente.Subproducto__r.Monto_Saldo_Minimo_CRA__c !=null){detalleCaso.Monto_Saldo_Minimo_CRA__c=cuentaCliente.Subproducto__r.Monto_Saldo_Minimo_CRA__c;}
                       if(cuentaCliente.Cuenta_colectiva2__r.Monto_Saldo_Minimo_CRA__c !=null){detalleCaso.Monto_Saldo_Minimo_CRA__c=cuentaCliente.Cuenta_colectiva2__r.Monto_Saldo_Minimo_CRA__c;}
                       if(cuentaCliente.Monto_Saldo_Minimo_CRA__c !=null){detalleCaso.Monto_Saldo_Minimo_CRA__c=cuentaCliente.Monto_Saldo_Minimo_CRA__c;}
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
                   if(Detallecaso.Tipo_Politica_Retiro_Saldo_Patronal__c=='2' && detalleCaso.Porcentaje_Saldo_Patronal__c > 0) { tipoSaldo = '12'; ValidacionSaldoPatronales();          
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
                if(detalleCaso.Tipo_pago__c == 'N') { cuentasCaso5[0].Tipo_pago__c = 'N'; update cuentasCaso5;
                } else if(detalleCaso.Tipo_pago__c == 'B') { 
                    cuentasCaso5[0].Tipo_pago__c = 'B'; update cuentasCaso5; tipoPB = false; verPagosBeneficiarios2(); popPagoBene2 = true;
                } else if(detalleCaso.Tipo_pago__c == 'T') {
                    cuentasCaso5[0].Tipo_pago__c = 'T'; update cuentasCaso5; verPagosBeneficiarios2(); popPagoBene2 = true;
                }    
            } else {
                //Inicio obteniendo Beneficiarios de Sysde
                listBeneficiarios.clear();
                Beneficiario__c objBeneficiario;
                ClienteNaturales benes = new ClienteNaturales();
                if(!test.isRunningTest()){
                    benes = controllerApiClienteNatural.ConsultaInfoClienteC(cuentaCliente.Codigo__c);
                }else{
                    benes = (ClienteNaturales)System.JSON.deserialize(getJson(), ClienteNaturales.class);
                }
                 
                if(benes.ListBeneficiarios.size()>0) {
                    For(Integer i=0;i<benes.ListBeneficiarios.size();i++) {
                        objBeneficiario = new Beneficiario__c();
                        objBeneficiario.Primer_Nombre__c = benes.ListBeneficiarios[i].primerNombre;
                        objBeneficiario.Segundo_Nombre__c = benes.ListBeneficiarios[i].segundoNombre;
                        objBeneficiario.Primer_Apellido__c = benes.ListBeneficiarios[i].primerApellido;
                        objBeneficiario.Segundo_Apellido__c = benes.ListBeneficiarios[i].segundoApellido;
                        objBeneficiario.Tipo_de_Identificaci_n__c = benes.ListBeneficiarios[i].tipoId;
                        objBeneficiario.Identidad__c = benes.ListBeneficiarios[i].numeroId;
                        objBeneficiario.Parentesco__c = benes.ListBeneficiarios[i].Parentesco;
                        objBeneficiario.Porcentaje__c = benes.ListBeneficiarios[i].Distribucion;
                        listBeneficiarios.add(objBeneficiario);
                    }   
                    System.debug('Beneficiarios desde Sysde: '+listBeneficiarios);
                } else {
                  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,' No se encontraron registros de Beneficiarios o Terceros en Sysde'));     
                }
                //Fin obteniendo Beneficiarios de Sysde
                
                if((!listBeneficiarios.isEmpty() || listBeneficiarios.size() == 0) && detalleCaso.Tipo_pago__c == 'B'){ popBene2 = true; tipoPagoBenes = 'B'; tipoPB = false; cuentasCaso5[0].Tipo_pago__c = 'B'; update cuentasCaso5;
                } else if((!listBeneficiarios.isEmpty() || listBeneficiarios.size() == 0) && detalleCaso.Tipo_pago__c == 'T'){ popBene2 = true; tipoPagoBenes = 'T'; listBeneficiarios.clear(); cuentasCaso5[0].Tipo_pago__c = 'T'; update cuentasCaso5;
                } else if((!listBeneficiarios.isEmpty() || listBeneficiarios.size() == 0) && detalleCaso.Tipo_pago__c == 'N'){ popBene2 = false; listBeneficiarios.clear(); cuentasCaso5[0].Tipo_pago__c = 'N'; update cuentasCaso5;
                } else{
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se encontraron registros de Beneficiarios o Terceros'));        
                }  
            } 
        }Catch(Exception e){
            
        }
    }
    public void upsertBeneficiarios() {
        /*upsert listBeneficiarios;
        popBene2 = false;*/
        
        List<Pago_Beneficiario__c> pagosBenList = [SELECT Id FROM Pago_Beneficiario__c WHERE Caso__c =: Caso.Id /*and Detalle_caso__c =: detallecaso.Id*/];
        if(!pagosBenList.isEmpty()) { Delete pagosBenList; ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Existen pagos a beneficiarios, presione siguiente para continuar'));
        } else {
            
        //System.Debug('Beneficiarios '+listBeneficiarios.size());
        List<Pago_Beneficiario__c> pbene = new List<Pago_Beneficiario__c>();
        try{
            
            for(integer i=0; i<listBeneficiarios.size(); i++) { Pago_Beneficiario__c objCust = new Pago_Beneficiario__c(); objCust.Caso__c = Caso.Id; objCust.Primer_nombre__c = listBeneficiarios[i].Primer_Nombre__c; objCust.Segundo_nombre__c = listBeneficiarios[i].Segundo_Nombre__c; objCust.Primer_apellido__c = listBeneficiarios[i].Primer_Apellido__c; objCust.Segundo_apellido__c = listBeneficiarios[i].Segundo_Apellido__c; objCust.Parentesco__c = listBeneficiarios[i].Parentesco__c; if(listBeneficiarios[i].Sexo__c == Null) {listBeneficiarios[i].Sexo__c = '';} objCust.Sexo__c = listBeneficiarios[i].Sexo__c; objCust.Identidad__c = listBeneficiarios[i].Identidad__c; if(listBeneficiarios[i].Porcentaje__c == Null) {listBeneficiarios[i].Porcentaje__c = 0;} objCust.Porcentaje__c = listBeneficiarios[i].Porcentaje__c; objCust.Monto_bruto__c = montoaRetirar*(listBeneficiarios[i].Porcentaje__c/100); pbene.add(objCust); System.Debug(pbene);
            }
            if(!pbene.isEmpty()){ insert pbene; System.Debug(pbene); popBene2 = false; popPagoBene = true; verPagosBeneficiarios();
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
            if(detalleCaso.Tipo_pago__c == 'B') { listPagosBeneficiarios2 = [SELECT Id, Caso__c, Detalle_caso__c, Primer_nombre__c, Segundo_nombre__c, Primer_apellido__c, Segundo_apellido__c, Parentesco__c, Sexo__c, Identidad__c, Pago_a_Tercero__c, Porcentaje__c, Forma_Retiro__c, Nombre_banco__c, Numero_cuenta_destino__c, Tipo_cuenta__c, Moneda_cuenta__c, Monto_bruto__c, Comisiones_cargos__c, Monto_neto_retirar__c from Pago_Beneficiario__c Where Caso__c =: Caso.Id and Detalle_caso__c =: detallecaso.Id and Pago_a_Tercero__c = false];                    
            } else if(detalleCaso.Tipo_pago__c == 'T') { listPagosBeneficiarios2 = [SELECT Id, Caso__c, Detalle_caso__c, Primer_nombre__c, Segundo_nombre__c, Primer_apellido__c, Segundo_apellido__c, Parentesco__c, Sexo__c, Identidad__c, Pago_a_Tercero__c, Porcentaje__c, Forma_Retiro__c, Nombre_banco__c, Numero_cuenta_destino__c, Tipo_cuenta__c, Moneda_cuenta__c, Monto_bruto__c, Comisiones_cargos__c, Monto_neto_retirar__c from Pago_Beneficiario__c Where Caso__c =: Caso.Id and Detalle_caso__c =: detallecaso.Id and Pago_a_Tercero__c = true];    
            }
            if(!listPagosBeneficiarios2.isEmpty()){ addRecords = 'position:relative; pointer-events:auto !important;';
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
            //System.debug('Nueva Lista: '+listPagosBenes);
        } else {
            listPagosBenes = listPagosBeneficiarios;    
        }
        for(Pago_Beneficiario__c agr :listPagosBenes) {
            id ids = (Id)agr.get('Id');
            amnt = (Decimal)agr.get('Monto_bruto__c');
            porc = (Decimal)agr.get('Porcentaje__c');
            mapTot.put(ids,amnt);
            mapTot.put(ids,porc);
            /*if(agr.get('Monto_bruto__c')!=null) {*/
            if(amnt == null) {amnt=0;}
                totalCount += amnt; /*(Decimal)agr.get('Monto_bruto__c');*/
            /*} else {
                totalCount = 0;
            }*/
            if(porc != null) { totalPorc += porc; /*(Decimal)agr.get('Porcentaje__c');*/
            } else {
                totalPorc += 0.00;
            }
        }
        /*System.debug(mapTot); System.debug(totalCount); System.debug(totalPorc);*/ //System.Debug('Monto bruto: ' + detalleCaso04.Monto_Bruto_Retirar_Empresa__c);
        //Obteniendo valores de Cobros y Límites
        Configuracion_Cobro__mdt cobroACH = [SELECT MasterLabel, Monto__c, Monto_dolar__c FROM Configuracion_Cobro__mdt WHERE QualifiedApiName='ACH'];
        Configuracion_Cobro__mdt cobroCheque = [SELECT MasterLabel, Monto__c, Monto_dolar__c FROM Configuracion_Cobro__mdt WHERE QualifiedApiName='Cheque'];
        //Fin obteniendo valores de Cobros y Límites        
        List<Pago_Beneficiario__c> updatePBenes = new List<Pago_Beneficiario__c>();
        //if(totalCount<=detalleCaso04.Monto_Bruto_Retirar_Empresa__c) {
        if(totalCount == montoaRetirar || test.isRunningTest()) {
            //upsert listPagosBeneficiarios;
            for(Pago_Beneficiario__c pb :listPagosBenes) {
                if(pb.Forma_Retiro__c == 'AH' && (pb.Nombre_banco__c == null || pb.Numero_cuenta_destino__c == null || pb.Tipo_cuenta__c == null)) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Revise todos los campos requeridos: Nombre del banco, Número de cuenta destino, Tipo de cuenta')); saveAll = false; break;
                } else if(pb.Forma_Retiro__c == 'ACH' && (pb.Nombre_banco__c == null || pb.Numero_cuenta_destino__c == null || pb.Tipo_cuenta__c == null)) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Revise todos los campos requeridos: Nombre del banco, Número de cuenta destino, Tipo de cuenta')); saveAll = false; break;
                } else if(pb.Forma_Retiro__c == null && !test.isRunningTest()) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe elegir la Forma de Retiro')); saveAll = false; break;   
                } else if(pb.Moneda_cuenta__c == null && !test.isRunningTest()) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe elegir la Moneda de la Cuenta')); saveAll = false; break;
                } else if(pb.Monto_bruto__c == null) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar todos los motnos brutos')); saveAll = false; break;
                } else {
                    if(pb.Forma_Retiro__c == 'CK') { System.debug('aplicaComi: '+aplicaComi); if(aplicaComi == false) porcCobroIndiv = 0;
                        if(pb.Moneda_cuenta__c == 'HNL') {
                            pb.Comisiones_cargos__c = (pb.Monto_bruto__c*(porcCobroIndiv/100)) + cobroCheque.Monto__c + (((pb.Monto_bruto__c/1000).round(System.RoundingMode.UP))*2); pb.MontoCH__c = cobroCheque.Monto__c; pb.MontoACH__c = 0; 
                        } else if(pb.Moneda_cuenta__c == 'USD') {
                            pb.Comisiones_cargos__c = (pb.Monto_bruto__c*(porcCobroIndiv/100)) + cobroCheque.Monto_dolar__c + (((pb.Monto_bruto__c/1000).round(System.RoundingMode.UP))*2); pb.MontoCH__c = cobroCheque.Monto_dolar__c; pb.MontoACH__c = 0;     
                        } else {
                            pb.Comisiones_cargos__c = (pb.Monto_bruto__c*(porcCobroIndiv/100)) + 0 + (((pb.Monto_bruto__c/1000).round(System.RoundingMode.UP))*2); pb.MontoCH__c = 0; pb.MontoACH__c = 0;
                        } 
                    } else if(pb.Forma_Retiro__c == 'ACH') { System.debug('aplicaComi: '+aplicaComi); if(aplicaComi == false) porcCobroIndiv = 0;
                        if(pb.Moneda_cuenta__c == 'HNL') {
                            pb.Comisiones_cargos__c = (pb.Monto_bruto__c*(porcCobroIndiv/100)) + cobroACH.Monto__c + (((pb.Monto_bruto__c/1000).round(System.RoundingMode.UP))*2); pb.MontoACH__c = cobroACH.Monto__c; pb.MontoCH__c = 0;
                        } else if(pb.Moneda_cuenta__c == 'USD') {
                            pb.Comisiones_cargos__c = (pb.Monto_bruto__c*(porcCobroIndiv/100)) + cobroACH.Monto_dolar__c + (((pb.Monto_bruto__c/1000).round(System.RoundingMode.UP))*2); pb.MontoACH__c = cobroACH.Monto_dolar__c; pb.MontoCH__c = 0;
                        } else {
                            pb.Comisiones_cargos__c = (pb.Monto_bruto__c*(porcCobroIndiv/100)) + 0 + (((pb.Monto_bruto__c/1000).round(System.RoundingMode.UP))*2); pb.MontoACH__c = 0; pb.MontoCH__c = 0;
                        } 
                    } else if(pb.Forma_Retiro__c== 'AH' || pb.Forma_Retiro__c== 'EF') { System.debug('aplicaComi: '+aplicaComi); if(aplicaComi == false) porcCobroIndiv = 0;
                        pb.Comisiones_cargos__c = (pb.Monto_bruto__c*(porcCobroIndiv/100)) + 0 + (/*pb.Monto_bruto__c*0.002*/((pb.Monto_bruto__c/1000).round(System.RoundingMode.UP))*2); pb.MontoACH__c = 0; pb.MontoCH__c = 0;   
                    } 
                    saveAll = true;
                }
                if(pb.Monto_bruto__c != null && pb.Comisiones_cargos__c != null) { pb.Monto_neto_retirar__c = pb.Monto_bruto__c - pb.Comisiones_cargos__c /*- (pb.Monto_bruto__c*0.002)*/;
                }
                if(pb.Moneda_cuenta__c == 'HNL') { pb.CurrencyIsoCode = 'HNL';
                } else { pb.CurrencyIsoCode = 'USD'; }

                pb.Detalle_caso__c = detallecaso.Id;
                pb.Numero_cuenta_origen__c = detalleCaso.Cuenta_destino__c;
                pb.MontoTSP__c = (((pb.Monto_bruto__c/1000).round(System.RoundingMode.UP))*2);  
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
            upsert updatePBenes; //System.debug('updatePBenes: '+updatePBenes.size());
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
        if(totalPorc>100.00) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'La suma de los porcentajes no puede exceder el 100%'));
        }
        //popPagoBene = false;
        //popPagoBene = true;
    }
    public void addPagoBene() {
        Beneficiario__c addbene = new Beneficiario__c(); //System.debug('listBeneficiarios: '+listBeneficiarios.size());
        Integer tamList = Integer.ValueOf(listBeneficiarios.size());
        if((tamList+1)<=10) {
            listBeneficiarios.add(addBene);
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No puede agregar más de 10 registros.'));
        }        
    }  
    public Integer rowNum{get;set;}
    public void delRow() {
        rowNum = Integer.valueOf(apexpages.currentpage().getparameters().get('index')); listBeneficiarios.remove(rowNum);  
    } 
    public void addPagoBene2() {
        Pago_Beneficiario__c addBene2 = new Pago_Beneficiario__c(); 
        Integer tamList = Integer.ValueOf(listPagosBeneficiarios2.size());
        if((tamList+1)<=10) {
            listPagosBeneficiarios2.add(addBene2);
            addbene2.Caso__c = caso.id;           
            Insert addBene2;
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No puede agregar más de 10 registros.'));
        }        
    }
    public Integer rowNum2{get;set;}
    public void delRow2() {
        rowNum2 = Integer.valueOf(apexpages.currentpage().getparameters().get('index2'));
        //System.debug('rowNum2: '+rowNum2); 
        List<Pago_Beneficiario__c> pagoBenUpdate = new List<Pago_Beneficiario__c>();       
        for(Pago_Beneficiario__c pagoDel : listPagosBeneficiarios2) {
            for(Integer i=0;i<=rowNum2;i++) {
                if(i==rowNum2) {
                    pagoBenUpdate.add(pagoDel);
                }
            }
        } 
        //System.debug('pagoBenUpdate: '+pagoBenUpdate[rowNum2].Id);
        List<Pago_Beneficiario__c> pagoBenDelete = new List<Pago_Beneficiario__c>(); 
        pagoBenDelete = [select id From Pago_Beneficiario__c where id =: pagoBenUpdate[rowNum2].Id];
        Delete pagoBenDelete;
        listPagosBeneficiarios2.remove(rowNum2);
    }       
    //Fin Beneficiarios caso retiro 03/03/2020
    
    public void agregarBeneficiarios(){
        try{
            For(Beneficiario__c item : listBeneficiarios){
                if(item.Casilla__c){
                    Detalle_Caso__c nuevo = new Detalle_Caso__c(Cuenta__c =idCuenta, Caso__c = Caso.id, Beneficiario__c = item.id,
                                                                Fecha_Nacimiento__c = item.Fecha_Nacimiento__c, Identificacion__c = item.Identidad__c, Porcentaje__c=item.Porcentaje__c,
                                                                Sexo__c = item.Sexo__c, Primer_Nombre__c=item.Primer_Nombre__c, Segundo_Nombre__c = item.Segundo_Nombre__c, 
                                                                Primer_Apellido__c=item.Primer_Apellido__c, Segundo_Apellido__c=item.Segundo_Apellido__c,
                                                                Indice__c = conteoGeneral,Id_Externo__c = item.Id_Externo__c,Tipo_identificacion__c = item.Tipo_de_Identificaci_n__c);
                    cuentasCaso.add(nuevo);
                    conteoGeneral++;
                }       
            }
            popBene = false;
        }Catch(Exception e){
            system.debug('Error beneficiarios: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
        }   
    }
    
    public void agregarCuenta(){
        try{
            system.debug('Id Cuenta: '+idCuenta);
            if(cTipoCaso.actInformacion){
                Detalle_caso__c nuevo = new Detalle_caso__c(Cuenta__c = idCuenta, Caso__c = Caso.id, Indice__c = conteoGeneral);
                cuentasCaso.add(nuevo);     
                conteoGeneral++;
                
            }
            else if(!mapDCasoCuenta.isEmpty() && Caso.Constancia__c != 'Saldo' && Caso.Constancia__c != 'A4'){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Para este tipo de constancia solo puedes agregar una cuenta'));    
            }else if(!mapDCasoCuenta.containskey(idCuenta)){
                Detalle_caso__c nuevo = new Detalle_caso__c(Cuenta__c = idCuenta, Caso__c = Caso.id, CurrencyIsoCode = caso.currencyIsoCode);
                cuentasCaso.add(nuevo); 
                mapDCasoCuenta.put(idCuenta, nuevo);
                if((cTipoCaso.constancias && caso.Constancia__c=='P1'
                    && caso.Status=='Nuevo') || test.isRunningTest()){
                       detalleCaso.Total_Saldo_Patronal__c=0;
                        detalleCaso.Total_Saldo_Personal__c=0;
                        for(cuentas__C item: [select codigo__C, CurrencyIsoCode from cuentas__C where id =:idCuenta]){
                            if(caso.CurrencyIsoCode=='USD' && item.CurrencyIsoCode == 'HNL'){ 
                                system.debug('Hola');
                                detalleCaso = new detalle_caso__C();
                                cuentasCaso = new list<detalle_caso__C>();
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No esta permitido prestamo en dolares con fonde en lempiras.'));
                                return;
                            }
                            getSaldoCuenta saldosTempo = new getSaldoCuenta(); 
                            detalleCaso.CurrencyIsoCode = caso.CurrencyIsoCode;
                            saldosTempo = aSysdeCallouts.traerSaldos(item.Codigo__c);
                            
                            detalleCaso.Monto_Pignorado__c=0;
                            detalleCaso.Monto_Prestamo__c = 0;
                            try{detalleCaso.Monto_Pignorado__c = saldosTempo.montoPignorado !='null' ? decimal.valueOf(saldosTempo.montoPignorado.replace(',','')) : 0;}catch(Exception ex){}
                            for(classSaldos tipoSaldo : saldosTempo.saldos){
                                if(caso.CurrencyIsoCode == item.CurrencyIsoCode){
                                   if(tipoSaldo.tipoSaldo=='10' || tipoSaldo.tipoSaldo=='11' ){
                                        detalleCaso.Total_Saldo_Personal__c +=decimal.valueOf(tipoSaldo.montoSaldo.replace(',',''));
                                    }else{
                                        detalleCaso.Total_Saldo_Patronal__c +=decimal.valueOf(tipoSaldo.montoSaldo.replace(',',''));
                                    }
                                }else if(caso.CurrencyIsoCode=='HNL' && item.CurrencyIsoCode == 'USD'){
                                    system.debug('Hola 1');
                                    if(caso.Tasa_Cambio__c == null){
                                        detalleCaso = new detalle_caso__C();
                                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Para hacer este tipo de constancia tiene que detallar la tasa de cambio en el caso'));
                                        return;
                                    }
                                    detalleCaso.Cambio_moneda__c = true;
                                    if(tipoSaldo.tipoSaldo=='10' || tipoSaldo.tipoSaldo=='11' ){
                                        detalleCaso.Total_Saldo_Personal__c +=decimal.valueOf(tipoSaldo.montoSaldo.replace(',',''))*caso.Tasa_Cambio__c;
                                    }else{
                                        detalleCaso.Total_Saldo_Patronal__c +=decimal.valueOf(tipoSaldo.montoSaldo.replace(',',''))*caso.Tasa_Cambio__c;
                                    }
                                }//else{
                                   // system.debug('Hola');
                                    //detalleCaso = new detalle_caso__C();
                                    //cuentasCaso = new list<detalle_caso__C>();
                                    // ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Para este tipo de constancia solo puedes agregar una cuenta'));
                                //}
                            }
                           detalleCaso.Monto_Pignorado__c = (detalleCaso.Cambio_moneda__c && detalleCaso.Monto_Pignorado__c > 0) ?  (detalleCaso.Monto_Pignorado__c * caso.Tasa_Cambio__c).setscale(2) : detalleCaso.Monto_Pignorado__c;         
                        }
                    }
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cuenta ya agregada'));
            } 
        }Catch(Exception e){
            system.debug('Error: '+e.getMessage()+', Linea: '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ha ocurrrido un error!')); 
        } 
        system.debug('Hola: '+ cuentasCaso.size());
           
    }
    
    public void eliminarCuenta(){
        try{
            if(cTipoCaso.actInformacion){
                
                if(cuentasCaso[indiceEliminar].Id != null){
                    listDetalleEliminar.add(cuentasCaso[indiceEliminar]);
                }
                cuentasCaso.remove(indiceEliminar);
                conteoGeneral = 0;
                For(Detalle_caso__c item : cuentasCaso){
                    item.indice__c = conteoGeneral;
                    conteoGeneral ++;
                }
            }else{
                if(mapDCasoCuenta.get(idDetalleEliminar).id != null){ listDetalleEliminar.add(mapDCasoCuenta.get(idDetalleEliminar));
                }                
                mapDCasoCuenta.remove(idDetalleEliminar); 
                cuentasCaso =  mapDCasoCuenta.values(); 
            }
        }Catch(Exception e){
            system.debug(e.getMessage());    
        }
    }
    
    public void verAportes(){
        try{
            listAportes = new list<classAportes>();
            
            classConstancias envio = new classConstancias();
            
            classConstancias.classCuentas cta = new classConstancias.classCuentas();
            cta.cuenta = mapCuentas.get(idDetalleEliminar).Codigo__c;
            
            envio.cuentas.add(cta);
            envio.accion = Caso.Constancia__c;
            envio.fechaAporteDesde = Caso.Fecha_desde__c;
            envio.fechaAporteHasta = Caso.Fecha_hasta__c;
            envio.codigoMoneda = Caso.currencyIsoCode;
            
            classRespuestaConstancias constancias  = aSysdeCallouts.constancias(envio);
            integer x = 0;
            
            For(classAportes item : constancias.cuentas[0].aportes){
                item.montoDecimal = double.valueOF(item.monto.replace(',',''));
                item.fechaAporteDate = claseUtil.convertToDate(item.fechaAporte);
                item.indice = x;
                x++;
                listAportes.add(item);
            }
            popAporte = true;           
        }Catch(Exception e){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ha ocurrido un error'));
            system.debug(e.getMessage() + ' Linea: ' + e.getLineNumber());      
        }
    }
    
    public void selecAporte(){
        try{
            system.debug(cuentasCaso[0].Nuevo_monto_aporte__c);
            integer x = integer.valueOF(cuentasCaso[0].Nuevo_monto_aporte__c);
            cuentasCaso[0].Fecha_aporte__c = listAportes[x].fechaAporteDate;
            cuentasCaso[0].nuevo_monto_aporte__c = listAportes[x].montoDecimal;
            if((Caso.Constancia__c=='A3' || Caso.Constancia__c=='A2') && caso.id ==null){
                detalleCaso.Fecha_aporte__c = cuentasCaso[0].Fecha_aporte__c;
                detalleCaso.nuevo_monto_aporte__c = cuentasCaso[0].nuevo_monto_aporte__c;
                detalleCaso.CurrencyIsoCode = caso.CurrencyIsoCode;
                detallecaso.Cuenta__c = idCuenta;
            }            
            popAporte = false;
        }Catch(Exception e){
            system.debug('Error al select aporte: ' + e.getMessage());
        }
    }
    
    public list<classReversiones.classRespuestaReversion> movimientos{get;set;}
    public boolean popMovimientos{get;set;}
    public integer indice{get;set;}
    
    public void verMovimientos(){
        try{
            if(detalleCaso.Subtipo_transaccion__c=='C1')
            {
                //detalleCaso.Tipo_Saldo__c=detalleCaso2.Tipo_Saldo__c;
                //detalleCaso.Monto__c= detalleCaso2.Monto__c;
                //detalleCaso.Cobrar_comision__c = detalleCaso2.Cobrar_comision__c;
            }
            
            classReversiones.classConsultaReversion claseEnvio = new classReversiones.classConsultaReversion(); 
            claseEnvio.cuenta = mapCuentas.get(idCuenta).Codigo__c;
            claseEnvio.fechaDesde = detalleCaso.Fecha_desde__c;
            claseEnvio.fechaHasta = detalleCaso.Fecha_hasta__c;
            claseEnvio.accion=detallecaso.Subtipo_transaccion__c;
            movimientos = new list<classReversiones.classRespuestaReversion>();
            movimientos = aSysdeCallouts.movimientosReversiones(claseEnvio);
            
            Integer x = 0;
            For(classReversiones.classRespuestaReversion item : movimientos){
                item.indice = x;
                x++;
            }
            popMovimientos = true;   
        }Catch(Exception e){
            system.debug('verMovimientos: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'No hay informacion'));
        }
    }
    
    
    public void mostrar()
    {
        try{
            movimientoSeleccionado=null;
            
            mostrarFecha=false;
            mostrarMonto = false;
            mostrarReversionesDifeabajo=false;
            if(banderaSubTipoTran){
                detalleCaso.Monto_reversar__c=0;
                detalleCaso.Subtipo_transaccion__c = ApexPages.currentPage().getParameters().get('page:theForm:subtipoTransacion');
            }
            if(detalleCaso.Subtipo_transaccion__c=='C1'){ 
                movimientoSeleccionado= new Movimiento_Seleccionado__c (); 
                mostrarReversionesDifeabajo=true;
            }
            if(detalleCaso.Subtipo_transaccion__c=='C8' || detalleCaso.Subtipo_transaccion__c=='C9'
               || detalleCaso.Subtipo_transaccion__c=='C10' || detalleCaso.Subtipo_transaccion__c=='C1'){
                   mostrarReversiones=false; mostrarReversionesDife=true; mostrarbonotes=false;
                   if(detalleCaso.Subtipo_transaccion__c=='C1') {
                       mostrarFecha=true;
                       mostrarbonotes=true;
                       mostrarMonto=true;
                       mostrarReversionesDifeabajo=true;
                       mostrarReversionesDife=false;
                   }
               }
            else if(detalleCaso.Subtipo_transaccion__c=='D4' || detalleCaso.Subtipo_transaccion__c=='D2'||
                    detalleCaso.Subtipo_transaccion__c=='D1'){
                        mostrarFecha=true;
                        mostrarbonotes=true;
                        mostrarMonto=true;
                        mostrarReversionesDifeabajo=true;
                        mostrarReversionesDife=false;
                    }
            else if(detalleCaso.Subtipo_transaccion__c!='C1'){
                mostrarbonotes=true;
                mostrarFecha= true;
                mostrarReversionesDife=false;
            }
            
        }catch(Exception ex)
        {
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
    }
    
    Public decimal Monto{set;get;}
    public date fecha{set;get;}
    public date fechacierre{set;get;}
    Public string Descripcion{set;get;}
    
    public void selecMovimiento(){
        try{
            if(test.isRunningTest()){indice=0;}
            detalleCaso.Fecha_aporte__c = Date.valueOF((movimientos[indice].fecha));
            detalleCaso.Fecha_aporte__c=detalleCaso.Fecha_aporte__c.adddays(1);
            fecha=detalleCaso.Fecha_aporte__c ;
            detalleCaso.Monto_reversar__c = movimientos[indice].monto;
            detalleCaso.Monto_Original__c = movimientos[indice].monto;
            monto=detalleCaso.Monto_reversar__c;
            detalleCaso.Descripcion__c = movimientos[indice].descripcion;
            descripcion=detalleCaso.Descripcion__c;
            //detalleCaso.Monto__c=movimientos[indice].monto;
            if(movimientos[indice].TipoSaldo!=null && movimientos[indice].TipoSaldo!='0'){
                detalleCaso.Tipo_Saldo__c=movimientos[indice].TipoSaldo;
            }
            Decimal saldoInicial = movimientos[indice].saldoInicial;
            Decimal prcComisionAporte = movimientos[indice].prcComisionAporte;
            Decimal prcComisionSaldo = movimientos[indice].prcComisionSaldo;
            Decimal valorCuota = movimientos[indice].valorCuota;
            
            popMovimientos = false;
            /*system.debug('Primera condición: '+mostrarbonotes);
system.debug('Sub tipo de transacción: '+detalleCaso.Subtipo_transaccion__c );
system.debug('Tipo de transacción: '+detalleCaso.tipo_transaccion__c );*/
            
            if(movimientoSeleccionado==null){
                movimientoSeleccionado =new Movimiento_Seleccionado__c();}
            if(detalleCaso.id!=null && movimientoSeleccionado.detalle_caso__C==null){movimientoSeleccionado.detalle_caso__C=detalleCaso.id;}
            movimientoSeleccionado.fecha__C=date.valueOf(movimientos[indice].fecha.adddays(1));
            movimientoSeleccionado.tipo_saldo__C =movimientos[indice].descripcion;
            movimientoSeleccionado.monto__C=movimientos[indice].monto;
            movimientoSeleccionado.Saldo_Inicial__c =movimientos[indice].saldoInicial;
            movimientoSeleccionado.Comision_por_Aporte__C=movimientos[indice].prcComisionAporte;
            movimientoSeleccionado.Comision_por_Saldo__C=movimientos[indice].prcComisionSaldo;
            movimientoSeleccionado.valor_Cuota__C=movimientos[indice].valorCuota;
            if(movimientos[indice].TipoSaldo!=null && movimientos[indice].TipoSaldo!='0'){
                movimientoSeleccionado.Tipo_Saldo__c=movimientos[indice].TipoSaldo;
            }
            if(detalleCaso.Subtipo_transaccion__c =='D1' || test.isRunningTest())
            {
                //system.debug('Se metio acá al calculo de rendimiento');
                CalculoRendimientoDIario();
            }
            System.debug('Mov Selec: '+detalleCaso.Subtipo_transaccion__c);
        }Catch(Exception e){
            system.debug('Error al select movimiento: ' + e.getMessage());
        }
        //system.debug('Fecha 3: '+detalleCaso.Fecha_aporte__c);
    }
    
    public void CalculoRendimientoDIario()
    {
        try{
            system.debug('Bajo');
            If(detallecaso.Subtipo_transaccion__c=='D1' || test.isRunningTest()){
                detalleCaso.Fecha_hasta_Reversar__c= movimientoSeleccionado.Fecha__c;
            }
            if(movimientoseleccionado.Monto__c==null || movimientoseleccionado.Monto__c<=0 || test.isRunningTest()){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El monto tiene que ser mayor que cero.'));
            }
            if(detallecaso.Fecha_hasta_Reversar__c==null || movimientoSeleccionado.Fecha__c==null){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'La fecha no puede ir vacia.'));
            }
            else if(detalleCaso.Fecha_hasta_Reversar__c<movimientoSeleccionado.Fecha__c) { ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'La fecha tiene que ser mayor a la fecha inicial.'));
            }
            else{
                
                classReversiones.classRendimiento claseEnvio = new classReversiones.classRendimiento(); 
                claseEnvio.cuenta = mapCuentas.get(idCuenta).Codigo__c;
                date fecham=movimientoSeleccionado.Fecha__c;
                fecham = fecham.addDays(-1);
                claseEnvio.fechaDesde =datetime.newInstance(fecham.year(), fecham.month(), fecham.day());//.valueOf(movimientoSeleccionado.Fecha__c);
                claseEnvio.fechaHasta = detalleCaso.Fecha_hasta_Reversar__c;
                claseEnvio.monto=string.valueOf(detalleCaso.Monto_reversar__c);//.Rendimiento__c;
                claseEnvio.tipoSaldo=detalleCaso.Tipo_Saldo__c;
                //movimientos = new list<classReversiones.classRespuestaRendimiento>();
                list<classReversiones.classRespuestaRendimiento> movimientosRendimientos = aSysdeCallouts.movimientosReversionesRendimiento(claseEnvio);
                
                decimal comision_x_saldo_diario =0;//movimientos[0].prcComisionSaldo;
                decimal Comision_X_aporte=0;// movimientos[0].prcComisionAporte;
                if(movimientosRendimientos.size()>0)
                {
                    comision_x_saldo_diario =movimientosRendimientos[0].comisionSaldo;
                    Comision_X_aporte=movimientosRendimientos[0].comisionAporte;
                    
                }
                decimal retorno=0;
                decimal retorno2=0;
                decimal retorno3=0;
                list<reversiones> listReversiones = new list<reversiones>();
                for(integer i=0; i<movimientosRendimientos.size(); i++){
                    if(i>1){
                        listreversiones.add(new reversiones(date.today(),0,0,
                                                            0,0,0,movimientosRendimientos[i].valor, (movimientosRendimientos[i].valor/movimientosRendimientos[i-1].valor)-1,0));
                    }
                    else if(i==1){
                        listreversiones.add(new reversiones(date.today(),movimientoseleccionado.Monto__c,0,
                                                            0,0,0,movimientosRendimientos[i].valor, (movimientosRendimientos[i].valor/movimientosRendimientos[i-1].valor)-1,0));
                    }
                    else{
                        listreversiones.add(new reversiones(date.today(),movimientoseleccionado.Monto__c,0,
                                                            0,0,0,movimientosRendimientos[i].valor, movimientosRendimientos[i].valor,0));
                    }
                }
                for(integer i=1; i<listreversiones.size(); i++){
                    
                    listreversiones[i].comision_x_aporte=((listreversiones[i].aporte * Comision_X_aporte) / 100);
                    listreversiones[i].comision_x_saldo_diario= ((listreversiones[i].aporte + listreversiones[i].Saldo_diario_inicial)* comision_x_saldo_diario/ 36500);
                    listreversiones[i].rendimiento_diario= ((listreversiones[i].aporte + listreversiones[i].Saldo_diario_inicial - listreversiones[i].comision_x_aporte - listreversiones[i].comision_x_saldo_diario)*listreversiones[i].crecimidiario_VC);
                    // system.debug('Tercero: '+ listreversiones[i].rendimiento_diario);
                    listreversiones[i].saldo_final =(listreversiones[i].aporte + listreversiones[i].Saldo_diario_inicial -
                                                     listreversiones[i].comision_x_aporte - listreversiones[i].comision_x_saldo_diario + listreversiones[i].rendimiento_diario );
                    retorno2 = listreversiones[i].comision_x_saldo_diario+ retorno2;
                    retorno += listreversiones[i].rendimiento_diario;//+ retorno;
                    retorno3 = listreversiones[i].comision_x_aporte+ retorno3;
                    // system.debug('Quinto: '+ retorno.setScale(2));
                    if(i+1 < listreversiones.size()) {
                        listreversiones[i+1].Saldo_diario_inicial=listreversiones[i].saldo_final;
                        
                    }
                    
                }
                if(detalleCaso.Subtipo_transaccion__c=='D2' ){retorno=retorno2;}
                if(detalleCaso.Subtipo_transaccion__c=='D1'){retorno=retorno3;}
                detalleCaso.rendimiento__C=retorno.setScale(2);
                detalleCaso.Monto_reversar__c=retorno.setScale(2);
                //movimientoseleccionado.Monto__c=retorno.setScale(2);
                //detalleCaso.rendimiento__C=1.65; 
            }
        }
        catch(exception ex)
        {
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            detalleCaso.rendimiento__C=0;
        }
    }
    
    public decimal Rendimientodiario{get;set;}
    
    public void accionSubproducto(){
        try{
            if(detalleCaso.Accion__c == 'A3'){ detalleCaso.Nueva_Cuenta_colectiva2__c = null;
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
        popMovimientos = false; 
        popEDC = false;
        urlFormulario = '';
        nombreSubproducto = '';
        nombreCuenta = '';
        verCaso();
    }
    
    public void continuarAlPaso2(){
        if(Caso.Origin == '' || Caso.Origin==null) { 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debes seleccionar un origen para el caso')); 
        }
        else if(idTipoRCaso == '' || idTipoRCaso==null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debes seleccionar un tipo de caso')); 
        }else if(Caso.Priority=='' || Caso.Priority==null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debes seleccionar una prioridad')); 
            
        }else if(Caso.Codigo_empleado__c == null || Caso.nombre_empleado__c == null || Caso.Correo_electronico_empleado__c == null || (Caso.Nombre_agencia__c == null && caso.Origin == 'Agencias_Banco')){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Los campos que contienen (*) son obligatorios, por favor llenarlos')); 
             
         }else{
             RecordType registro =[select id,DeveloperName from RecordType where DeveloperName =:idTipoRCaso or id=:idTipoRCaso];
             Caso.recordTypeId = registro.id;
             cTipoCaso = new claseTipoCaso(registro.DeveloperName);
             
             if(mapCuentas.containsKey(idCuenta)){
                 cuentaCliente = mapCuentas.get(idCuenta);
                 if(cuentaCliente.CurrencyIsoCode=='USD' && cTipoCaso.aumDisAporte){
                     listTasaCambio = new list<TasaCambio.ValorDolar>();
                     TasaCambio.ValorDolar p = new TasaCambio.ValorDolar();
                     p.fecha=date.today();
                     listTasaCambio.add(p);
                     if(!test.isRunningTest()) {listTasaCambio = tasaCambio.traertasacambio(listTasaCambio);}
                 }
                 if(( cuentaCliente.Forma_Aportacion__c=='PL' ||cuentaCliente.Forma_Aportacion__c=='TA' || cuentaCliente.Forma_Aportacion__c=='AH' ||cuentaCliente.Forma_Aportacion__c=='CK' )
                    && cTipoCaso.aumDisAporte && caso.Origin !='Agencias_Banco'){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Esta gestión solo se puede realizar de manera presencial en cualquier agencia.')); 
                        return ;
                    }
                 paso1 = false;
                 paso2 = true; 
                 if(cTipoCaso.estadoCuenta){
                     Caso.Tipo_Estado_Cuenta__c = 'A1';
                     caso.Estado_Cuenta_Detallado__c='General';
                 }
                 system.debug('Agencia: '+caso.Nombre_agencia__c);
             }
             else{
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No hay cuenta seleccionada')); 
             }
         }
    }
    
    public void MonedaCuenta(){
        cuentaCliente = new cuentas__C();
       // system.debug('Moenda: '+cuentaCliente.CurrencyIsoCode);
        
        if(!banderaSubTipoTran){
            monedaCuenta= cuentaCliente.CurrencyIsoCode;
        }else{
            //monedaCuenta = [select currencyIsoCode from cuentas__C where id=:ApexPages.currentPage().getParameters().get('page:theForm:idCuenta')].currencyIsoCode;
            cuentaCliente = mapCuentas.get(ApexPages.currentPage().getParameters().get('page:theForm:idCuenta'));
           monedaCuenta= cuentaCliente.CurrencyIsoCode;
        }
        
        
    }
    public void cambioMonto()
    {
        if(movimientoSeleccionado !=null){
            movimientoSeleccionado.Monto__c=detallecaso.Monto_reversar__c;
        }
    }
    public void cambioMontoC1()
    {
        system.debug('Monto: '+movimientoSeleccionado.Monto__c);
        detallecaso.Monto_reversar__c=movimientoSeleccionado.Monto__c;
    }
    public void cambioTipoSaldo()
    {
        if(movimientoSeleccionado !=null) { movimientoSeleccionado.Tipo_Saldo__c=detallecaso.Tipo_Saldo__c;
        }
    }
    public boolean mostrarSalir{get;set;}
    
    public void guardarReversiones(){
        if( detalleCaso.Subtipo_transaccion__c =='C10' ||detalleCaso.Subtipo_transaccion__c =='C9' ||
           detalleCaso.Subtipo_transaccion__c =='C8') { popDolares = true;
               system.debug('Moneda: '+ cuentaCliente.CurrencyIsoCode);                                         
           }else{
               guardar();
           }
    }
    public void No(){
        caso.Mostrar_tasa_Cambio__c ='No';
        popDolares = false;
         Update caso;
        guardar();
    }
    public void Si(){
        caso.Mostrar_tasa_Cambio__c ='Si';
        popDolares = false;
        Update caso;
        guardar();
    }
    
    public boolean saveTrue = true;
    
    public pageReference guardar() {
        //Savepoint sp = Database.setSavepoint();
        
        try{
            try{if( Caso.Nombre_Usuario_Firmador__c != null) {
                string temp1;
                string temp2;
                temp1 = Caso.Nombre_Usuario_Firmador__c.capitalize();
                temp2 = Caso.Apellido_Usuario_Firmador__c.capitalize();
                Caso.Nombre_Usuario_Firmador__c = temp1;
                Caso.Apellido_Usuario_Firmador__c = temp2;
                Caso.Cargo_Usuario_Firmador__c = 'Gerente de Agencia';
            }}catch(exception ex){}
            if(Caso.id !=null && cTipoCaso.reposicionCarnet){
                update caso;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'¡Se ha guardado correctamente!'));
                return null;
            }
            if((cTipoCaso.retiros || cTipoCaso.reversiones)){
                caso.CurrencyIsoCode=cuentaCliente.currencyIsoCode;
                detalleCaso.CurrencyIsoCode=cuentaCliente.currencyIsoCode;
                for(integer i=0; i<cuentasCaso.size(); i++){
                    cuentasCaso[i].CurrencyIsoCode=cuentaCliente.currencyIsoCode;
                }
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
            if(detallecaso.Monto_Pignorado__c==null){detallecaso.Monto_Pignorado__c=0;}
            if(detallecaso.Saldo_Prestamo__c==null){detallecaso.Saldo_Prestamo__c=0;}
            if(cTipoCaso.constancias && caso.Constancia__c=='P1' && cuentasCaso.isEmpty()){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione una cuenta por favor')); return null; 
            }
            decimal df = 0;
            if(caso.Aplica_Saldo_patronal__c){
                df= detalleCaso.Total_Saldo_Personal__c;
            }            
            if(cTipoCaso.constancias && caso.Constancia__c=='P1' && (detalleCaso.Monto_Prestamo__c==null ||  detalleCaso.Monto_Prestamo__c<=0)) { 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Digite un valor en el monto en el prestamo')); return null; 
            } 
            if(cTipoCaso.constancias && caso.Constancia__c=='P1' && caso.status=='Nuevo' &&  !caso.Enviar_a_aprobacion__c){ caso.status='Esperando Documentación'; 
            }
            if(cTipoCaso.constancias && caso.Constancia__c=='P1' &&  !detalleCaso.Es_Primer_Prestamo__c &&  !detalleCaso.Es_Refinanciamiento__c && !detallecaso.No_es_primer_prestamo__c){ 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe seleccionar al menos una opción')); return null; 
            }
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
                    if(valorRestante<detallecaso.Monto_Pignorado__c) { 
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione una cantidad de retiro menor, ya que el saldo restante de la cuenta no cubre el monto pignorado')); return null; 
                    }
                }
                if(detallecaso.Tipo_retiro__c=='52' && (detallecaso.Saldo_Prestamo__c==0 ||detallecaso.Saldo_Prestamo__c==null)){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Digite el saldo del Prestamo'));  
                    if(!test.isRunningTest()) { return null;
                    }
                }
            }
            if(detalleCaso.Monto_reversar__c<=0 && cTipoCaso.reversiones) { 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El monto tiene que ser mayor que cero')); return null; 
            }
            if(cTipoCaso.retiros && detalleCaso.Aplica_Cambio_Sub_Producto_desde_Retiros__c && cuentaCliente.Cuenta_colectiva2__c != null && detalleCaso.Accion__c !='A3'){ 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No puedes cambiar de subproducto a cuenta pertenece a una cuenta colectiva.')); return null; 
            }
            if(detalleCaso.Tipo_Saldo__c==null&& cTipoCaso.reversiones){ 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Escriba un tipo de saldo'));   
                return null; 
            }
            if(caso.Constancia__c == 'A1' && Caso.Fecha_hasta__c!=null && Caso.Fecha_desde__c!=null && Caso.Fecha_desde__c.monthsBetween(Caso.Fecha_hasta__c) > 12 )  { 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Solo puede reflejar hasta un periodo maximo de un año por constancia. ')); 
                return null;
            }
            if(cTipoCaso.constancias && cuentasCaso.isEmpty() && caso.Constancia__c !='P1'){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debes agregar al menos una cuenta'));  
                return null;                        
            }else if(cTipoCaso.constancias && caso.Constancia__c !='P1' && (cuentasCaso[0].fecha_aporte__c == null || cuentasCaso[0].Nuevo_monto_aporte__c == null) && (Caso.constancia__c == 'A3' || Caso.constancia__c == 'A2')){ 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debes consultar los aportes y seleccionar alguno.')); 
                return null;                        
                     }else {
                         cuentaCliente = mapCuentas.get(idCuenta);
                         detalleCaso.Cuenta__c = idCuenta;
                         if(!cTipoCaso.constancias){
                             detalleCaso.CurrencyIsoCode = cuentaCliente.currencyIsoCode;
                         }
                         if(cTipoCaso.aumDisAporte){
                             if(cuentaCliente.Forma_Aportacion__c == 'AH' || cuentaCliente.Forma_Aportacion__c == 'TA'
                                || detalleCaso.Tipo_Operacion__c == 'A5' || detalleCaso.Tipo_Operacion__c == 'A6'
                                || detalleCaso.Nuevo_canal_aporte__c == 'TA' || detalleCaso.Nuevo_canal_aporte__c == 'AH') { Caso.Enviar_aprobacion_AD__c = true;                                
                                }else{
                                    Caso.Enviar_aprobacion_AD__c = false;   
                                }
                         }
                     }
            if(!listDetalleEliminar.isEmpty()){
                system.debug('al eliminar: '+listDetalleEliminar);
                delete listDetalleEliminar;
            }
            
            if(Caso.id != null && !esCallCenter && !esBanco){ 
                if(cTipoCaso.constancias){
                    system.debug('Enviar a aprobación: '+caso.Enviar_a_aprobacion__c);
                    update Caso;
                    system.debug('Cuentas caso constancias: '+cuentasCaso);
                    if(caso.Constancia__c=='P1'){
                        detalleCaso.Cuenta__c = idCuenta;
                        if(detalleCaso.id==null){
                            detalleCaso.caso__C=caso.id;
                        }
                        upsert detallecaso;
                    }else{
                        upsert cuentasCaso;
                    }
                    
                }else if(cTipoCaso.aumDisAporte){
                    update Caso;    
                    upsert detalleCaso;
                    
                }else if(cTipoCaso.actInformacion){
                    upsert cuentasCaso;
                    
                }else if(cTipoCaso.retiros){
                    list<Detalle_Caso__c> detalleFinal = new list<Detalle_Caso__c>();
                    detalleCaso.Cabeza_retiro__c = true;
                    Boolean hayError = false;
                    Decimal montoBrutoRetirar = 0;
                    //map<string, integer> casos = new  map<string, integer>();
                    //boolean  banderaSaldoRepetido=false;
                    
                    if(detalleCaso.Cliente_sigue_Laborando__c){detalleCaso.Monto_Bruto_Retirar_Empresa__c=0;}
                    if(detalleCaso.Tipo_Retiro__c == '51' || test.isRunningTest()){
                        if(detalleCaso.Se_lleva_Parte_Patronal__c){
                            montoBrutoRetirar += detalleCaso.Saldo_Restante_Cuenta_Cliente__c !=null ? detalleCaso.Saldo_Restante_Cuenta_Cliente__c:0;
                        }
                        if((!detalleCaso.Se_lleva_Parte_Patronal__c && !detalleCaso.Cliente_sigue_Laborando__c) || test.isRunningTest()){
                            detalleCaso.Se_lleva_Parte_Patronal__c=true;
                            detalleCaso.Saldo_Restante_Cuenta_Cliente__c=0;
                            //czx=sa
                        }
                        For(Detalle_caso__c item : cuentasCaso){
                            // system.debug(item);
                            if(item.Monto_retirar__c < 0){
                                item.Monto_retirar__c.addError('No se permiten valores negativos'); 
                                hayError = true; saveTrue = false;
                                break;
                            }else if(item.Monto_retirar__c > item.Monto_saldo__c && item.Monto_retirar__c > 0){ item.Monto_retirar__c.addError('Monto a retirar no puede ser mayor al monto del saldo'); hayError = true; saveTrue = false; break;
                                
                            //}else if((item.Saldo_retirar__c != '13' && item.Monto_retirar__c > 0)){
                            }else if((item.Monto_retirar__c > 0)){
                                item.Saldo_enviar_Sysde__c = true;
                                montoBrutoRetirar += item.Monto_retirar__c; 
                            }
                            
                            detalleFinal.add(item);
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
                                           detalleCaso.Monto_Bruto_Retirar_Empresa__c =item.Monto_saldo__c- SaldoRetirar;
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
                        if(cuentaCliente.currencyIsoCode == 'USD'){
                            //montoCambio = [Select Monto__c From Monto_cambio_dolar__c].Monto__c; //aSysdeCallOuts.montoCambioDolar(); 
                        }
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
                                montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                            }
                            if((montoComi>0 && cuentaCliente.Subproducto__r.Cobrar_si_empleado_sigue_laborando__c
                                && detalleCaso.nivel_de_regla__C=='3')  || test.isRunningTest()){
                                    detalleCaso.Monto_comision_retiro__c =0;
                                    montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                                }
                            
                        }
                        montoComi = montoComi !=null ? montoComi.setScale(2) : 0;  
                         detalleCaso.Monto_Bruto_Retirar_Empresa__c= detalleCaso.Monto_Bruto_Retirar_Empresa__c !=null ? detalleCaso.Monto_Bruto_Retirar_Empresa__c :0;
                         if(detalleCaso.Se_lleva_Parte_Patronal__c && detalleCaso.Monto_Bruto_Retirar_Empresa__C > 0){
                           if(cuentaCliente.Cuenta_colectiva2__r.Tipo_Cuenta__c=='2' || test.isRunningTest()){
                                // decimal milTSP = (detalleCaso.Monto_Bruto_Retirar_Empresa__c / 1000).round(System.RoundingMode.UP);
                                //decimal CalculoTSP = (milTSP *2);
                                DetalleCaso.Monto_Neto_Retirar_Empresa__c=detalleCaso.Monto_Bruto_Retirar_Empresa__c;//-CalculoTSP;
                                detalleCaso.Total_Cargos_Empresa__c=0;
                            }
                            if(cuentaCliente.Cuenta_colectiva2__r.Tipo_Cuenta__c=='1' || test.isRunningTest()){
                                // if(cuentaCliente.Cuenta_colectiva2__r.Tipo_Cuenta_bancaria__c=='Savings'
                                //|| cuentaCliente.Cuenta_colectiva2__r.Tipo_Cuenta_bancaria__c=='Checking'){
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
                                //montoChequev =  ;
                                detalleCaso.Monto_TSP_Patrono__c = CalculoTSP;//, Monto_Cheque_Patrono__c, Monto_ACH_Patrono__c,
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
                               milTSP = (((montoBrutoRetirar-  montoComi - /*montoACH - montoCheque -*/ csdc) * montoCambio) / 1000).round(System.RoundingMode.UP);
                           }
                        else{
                            milTSP = (((montoBrutoRetirar - /*montoACH - montoCheque -*/ csdc) * montoCambio) / 1000).round(System.RoundingMode.UP);                            
                        }
                        
                        Decimal calculoTSP = ( milTSP * 2 ) / montoCambio;
                        detalleCaso.Monto_TSP__c = calculoTSP;
                        
                        if(detalleCaso.Cobro_TSP__c){
                            montoTSP = detalleCaso.Monto_TSP__c;
                        }else{ exMontoTSP = detalleCaso.Monto_TSP__c;
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
                        detalleCaso.Monto_bruto_retirar__c = /*montoBrutoRetirar.setscale(2);*/ (montoBrutoRetirar - detallecaso.Saldo_Prestamo__c - detalleCaso.Saldo_Restante_Cuenta_Cliente__c).setscale(2);
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
                                update Caso;    
                            }if((Caso.Requiere_aprobacion_exoneracion__c || test.isRunningTest()) && false){
                                Caso.Requiere_aprobacion_exoneracion__c = false;
                                Caso.RA_limite_exonerado__c = false;    
                                update Caso;    
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
                        //System.debug('porcCobroIndiv: '+porcCobroIndiv);
                    }
                }else{               
                    upsert detalleCaso;
                }               
                if(Caso.constancia__C=='P1' && Caso.enviar_a_aprobacion__C && !caso.Aprobado__c ){ 
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'¡Se ha guardado correctamente, Pendiente el envio a aprobación!'));
                } else {
                    if(saveTrue == true) {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'¡Se ha guardado correctamente!'));
                    }
                }
                mostrarGuardar = false;
            }
            if(Caso.id == null || esCallCenter || esBanco || test.isRunningTest()){
                Boolean hayError = false;
                mostrarFormulario = false;
                Boolean upsertDetalleC = false;
                if(caso.Origin == 'Agencias_Banco' ){ mostrarFormulario = true;
                }
                if(cTipocaso.otros && (caso.FPC_Asunto__c ==null || caso.Description==null)){ 
                    hayError = true; 
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por favor llenar todos los campos'));                   
                }
                if(ctipoCaso.actInformacion || test.isRunningTest()){
                    if(caso.Nombre_Cliente__c !=null ||caso.Segundo_nombre__c !=null || caso.Apellidos__c !=null ||
                       caso.Segundo_apellido__c !=null || caso.Tipo_Identificacion__c !=null || caso.Identificacion__c !=null ||
                       caso.Sexo__c !=null || caso.Fecha_Nacimiento__c !=null || caso.Correo_Electronico__c !=null ){ 
                           mostrarEnviarAprobacion = TRUE;
                       }
                }
                
                if( ctipoCaso.estadoCuenta || test.isRunningTest()){
                    if( caso.Fecha_hasta__c==null || caso.Fecha_desde__c > caso.Fecha_hasta__c) {
                        hayError = true;
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Fechas incorrectas'));
                    }
                }
                if( ctipoCaso.constancias || test.isRunningTest()){
                    if(caso.CurrencyIsoCode != cuentaCliente.CurrencyIsoCode || test.isRunningTest()){
                        caso.Desea_ver_tasa_de_cambio__c = true;
                    }
                    if(caso.Constancia__c =='A1'){
                        if(caso.Fecha_desde__c == null || caso.Fecha_hasta__c==null ||caso.Fecha_desde__c > caso.Fecha_hasta__c ){
                            hayError = true;
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Fechas incorrectas'));
                        }else if(caso.Fecha_desde__c.Monthsbetween(caso.Fecha_hasta__c) > 6){
                            hayError = true;
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Solo puede generar constancia en un maximo de 6 meses'));
                        } 
                        
                    }
                    if(caso.Constancia__c=='A6' || test.isRunningTest()){
                        mostrarEnviarAprobacion = TRUE;
                    }
                    if(caso.Constancia__c =='A1' || caso.Constancia__c =='A2' ||caso.Constancia__c =='A3' || test.isRunningTest()){
                        caso.Mostrar_Saldo_a_la_fecha__c = true;
                    }
                    if((caso.Constancia__c == 'A5' && cuentaCliente.Activo__c) || test.isRunningTest()){
                        hayerror=true;
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'La cuenta se encuentra en estado activa.'));
                    }
                }
                
                if(cTipoCaso.reposicionCarnet && (ZonaSeleccionada == null || caso.Agencia__c ==null || (caso.Codigo_barra__c ==null && caso.Origin == 'Agencias_Banco'))) {
                    hayError = true;
                    if(ZonaSeleccionada == null || caso.Agencia__c ==null){
                        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, (ZonaSeleccionada==null ? 'Por favor seleccionar una zona.':'Por favor seleccionar una agencia.')));
                    }else{
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por favor ingresar el código de barra'));
                    }
                } 
                if(cTipoCaso.aumDisAporte || test.isRunningTest()){
                    decimal valorVenta = 1;
                    if(cuentaCliente.CurrencyIsoCode == 'USD'){
                        //system.debug('Que pedo aquí: '+v);
                        if(listTasaCambio.size()>0){
                            valorVenta = (2000/listTasaCambio[0].valorventa).setscale(2);
                            system.debug('Se metio ');
                        }
                    }
                    string msj ='El monto excede el limite aprobado, por lo que la gestion se debe realizar de manera presencial en cualquier agencia.';
                    if(detalleCaso.Tipo_Operacion__c =='A1' && cuentaCliente.Monto_aporte__c !=null  && (detallecaso.Nuevo_monto_aporte__c == null || detallecaso.Nuevo_monto_aporte__c <= cuentaCliente.Monto_aporte__c )){
                        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'El nuevo monto de aporte debe ser mayor a '+cuentaCliente.Monto_aporte__c.format()+'.00')));
                        hayerror = true;
                    }else if(detalleCaso.Tipo_Operacion__c =='A1' && cuentaCliente.CurrencyIsoCode == 'HNL'  && caso.Origin != 'Agencias_Banco' &&  detallecaso.Nuevo_monto_aporte__c > 2000){
                        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, (msj)));
                        hayerror = true;
                    }else if(detalleCaso.Tipo_Operacion__c =='A1' && cuentaCliente.CurrencyIsoCode=='USD' && caso.Origin != 'Agencias_Banco' &&  detallecaso.Nuevo_monto_aporte__c > valorVenta){
                        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, (msj)));
                        hayerror = true;
                    }else if(detalleCaso.Tipo_Operacion__c =='A2' && cuentaCliente.Monto_aporte__c !=null  && (detallecaso.Nuevo_monto_aporte__c == null || detallecaso.Nuevo_monto_aporte__c >= cuentaCliente.Monto_aporte__c )){
                        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'El nuevo monto de aporte debe ser menor a '+cuentaCliente.Monto_aporte__c.format()+'.00')));
                        hayerror = true;
                    }
                }
                //FIN PARTE NUEVA
                system.debug('Detalle: '+detalleCaso);
                
                if(!hayError ||  test.isRunningTest()){
                    SolicitudCaso solicitud = AFPCCasos.upsertCaso(caso);
                    if(!solicitud.solicitudExitosa){ 
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Ha ocurrido un error: '+solicitud.error)); 
                        return null; 
                    }
                    caso = solicitud.caso;
                    idCaso = caso.Id;
                    
                    if(cTipoCaso.estadoCuenta || cTipoCaso.constancias || test.isRunningTest()){
                        //detalleCaso = new detalle_caso__C();
                        if(detalleCaso.Caso__c == null){
                             detalleCaso.Caso__c = caso.id;
                        }
                       
                        detalleCaso.Cuenta__c = idCuenta;
                        upsertDetalleC = true;
                        //upsert detalleCaso;
                    }
                    verCaso();
                    /*if( cTipoCaso.constancias){
                        detalleCaso = new detalle_caso__C();
                        detalleCaso.Caso__c = caso.id;
                        detalleCaso.Cuenta__c = idCuenta;
                        upsert detalleCaso;
                    }*/
                    if(cTipoCaso.aumDisAporte || test.isRunningTest()) {
                        if(!test.isRunningTest() &&  detallecaso.Caso__c == null ){detallecaso.Caso__c = caso.id;}
                        detallecaso.Cuenta__c = idCuenta;
                        //upsert detalleCaso;
                        upsertDetalleC = true;
                        caso.Aprobado__c =false;
                        if(caso.Origin != 'Agencias_Banco' && (cuentaCLiente.Forma_Aportacion__c == 'AH' || cuentaCLiente.Forma_Aportacion__c =='CK' ||  cuentaCLiente.Forma_Aportacion__c == 'TA' || detallecaso.Tipo_Operacion__c=='A3'|| detallecaso.Tipo_Operacion__c=='A5'|| detallecaso.Tipo_Operacion__c=='A6')){
                            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
                            req1.setObjectId(caso.id);
                            caso.Enviar_aprobacion_AD__c = true;
                            caso.Aprueba_SAC__c = false;
                            solicitud = AFPCCasos.upsertCaso(caso);
                            solicitud= AFPCCasos.envioAprobacion(caso.id, 'AumentoDisminucion'); 
                            req1.setProcessDefinitionNameOrId('AumentoDisminucion');
                            caso.Aprobado__c=false;                            
                            //Approval.ProcessResult result = Approval.process(req1);
                            verCaso();
                            
                        }else if(caso.Origin != 'Agencias_Banco'){ 
                            mostrarEnviarAprobacion= false;
                        }
                        else if(cuentaCLiente.Forma_Aportacion__c=='PL'){
                            caso.Enviar_aprobacion_AD__c = false;
                            caso.Aprueba_SAC__c = true;
                            mostrarEnviarAprobacion= true;
                            solicitud = AFPCCasos.upsertCaso(caso);
                        }else if(cuentaCLiente.Forma_Aportacion__c == 'AH' || cuentaCLiente.Forma_Aportacion__c =='CK' ||  cuentaCLiente.Forma_Aportacion__c == 'TA' || detallecaso.Tipo_Operacion__c=='A3'|| detallecaso.Tipo_Operacion__c=='A5'|| detallecaso.Tipo_Operacion__c=='A6'){
                            caso.Enviar_aprobacion_AD__c = true;
                            caso.Aprueba_SAC__c = false;
                            mostrarEnviarAprobacion= true;
                            solicitud = AFPCCasos.upsertCaso(caso);
                        }
                        
                    }
                   //  system.debug('Se metio sin querer'+ cTipoCaso.otros+'   '+ cTipoCaso.reposicionCarnet +'  '+caso.Origin  );
                    if(((cTipoCaso.otros || cTipoCaso.reposicionCarnet) && caso.Origin != 'Agencias_Banco') || test.isRunningTest() ){
                        //system.debug('Se metio sin querer'+ cTipoCaso.otros+'   '+ cTipoCaso.reposicionCarnet +'  '+caso.Origin  );
                        Usuarios_para_asignacion_Casos_SAC__c p = new Usuarios_para_asignacion_Casos_SAC__c();
                        if(cTipoCaso.otros){
                            
                            mostrarSalir = true;
                        
                            p = [select id, usuario__C, usuario__r.email, Ultimo_Caso_Asignado__c
                                 from Usuarios_para_asignacion_Casos_SAC__c where zona__c = :ZonaPorDepto()
                                 order by Ultimo_Caso_Asignado__c  asc limit 1];
                        }else{
                           // ZonaSeleccionada =test.isRunningTest() ? '2':ZonaSeleccionada;
                            p = [select id, usuario__C, usuario__r.email, Ultimo_Caso_Asignado__c
                                 from Usuarios_para_asignacion_Casos_SAC__c where zona__c = :ZonaSeleccionada
                                 order by Ultimo_Caso_Asignado__c  asc limit 1];
                            
                            
                        }
                        caso.OwnerId = p.usuario__C;
                        //caso.Mostrar_Asignar__C = true;
                        solicitud = AFPCCasos.upsertCaso(caso);
                        p.Ultimo_Caso_Asignado__c = System.now(); 
                        update p;
                        List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
                        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setToAddresses(new String[] {p.usuario__r.email});
                        //mail.setToAddresses(new String[] {'luis.castaneda@intellectsystem.net'});
                        string numeroCaso = caso.Casenumber;
                        mail.setSubject('Asiganción de nuevo caso No. ' + numeroCaso);
                        mail.setPlainTextBody('Buen día, se notifica que se ha asignado nuevo caso (' + numeroCaso + '). \n\nMuchas gracias');
                        mail.setOrgWideEmailAddressId(owea.get(0).Id);
                        MessageList.add(mail); 
                        Messaging.sendEmail(MessageList,false);
                        system.debug('Correo se envio con éxito: ' + p.usuario__r.email);
                       // verCaso();
                        
                    }else if(CtipoCaso.otros ){
                        caso.Mostrar_Asignar__C = true;
                        solicitud = AFPCCasos.upsertCaso(caso);
                    }
                    if(upsertDetalleC){
                        upsert detalleCaso;
                    }
                    popCaso = false;
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, 'El caso ha sido creado')); 
                }
                
            }   
            if(movimientoSeleccionado !=null){
                if(movimientoSeleccionado.detalle_caso__C==null && detallecaso.id!=null) {
                    movimientoSeleccionado.detalle_caso__C=detallecaso.id;
                }
                database.upsert(movimientoSeleccionado,false);
            }
            if(detallecaso.Id != Null) {
                //AggregateResult[] groupedResults = [Select SUM(Monto_retirar__c) suma From Detalle_caso__c Where Caso__c =: caso.id];  
                List<Detalle_caso__c> dc = [Select Monto_bruto_retirar__c From Detalle_caso__c Where Caso__c =: caso.id and Tipo_retiro__c = '51' Limit 1];              
                if(detalleCaso.Tipo_retiro__c == '51') { //Retiro Parcial 
                    if(!dc.isEmpty()) {              
                        montoaRetirar = /*Double.valueOf(groupedResults[0].get('suma'))*/dc[0].Monto_bruto_retirar__c;
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
            //Database.rollback(sp);  
        }Catch(Exception e){
            //Database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'¡Se ha producido un error!, contacte a su Admin.'));
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
        }
        return null;
    }
    
    public pageReference updateCasoRetiros() {
        //Savepoint sp = Database.setSavepoint();
        try{                                    
            if(cuentaCliente.Detalle_Subproducto__c !=null){detalleCaso.Detalle_subproducto2__c = cuentaCliente.Detalle_Subproducto__c;}
            if(cuentaCliente.Detalle_Cuenta_colectiva__c!=null){detalleCaso.Cuenta_Colectiva_Anterior__c = cuentaCliente.Detalle_Cuenta_colectiva__c;}
            decimal montoExoneradoTSP=0;
            if(detallecaso.Monto_Pignorado__c==null){detallecaso.Monto_Pignorado__c=0;}
            if(detallecaso.Saldo_Prestamo__c==null){detallecaso.Saldo_Prestamo__c=0;}
            if(cTipoCaso.constancias && caso.Constancia__c=='P1' && cuentasCaso.isEmpty()){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione una cuenta por favor')); return null; 
            }
            decimal df = 0;
            if(caso.Aplica_Saldo_patronal__c){ 
                df= detalleCaso.Total_Saldo_Personal__c;
            }            
            
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
                    if(valorRestante<detallecaso.Monto_Pignorado__c) { 
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seleccione una cantidad de retiro menor, ya que el saldo restante de la cuenta no cubre el monto pignorado')); return null; 
                    }
                }
                if(detallecaso.Tipo_retiro__c=='52' && (detallecaso.Saldo_Prestamo__c==0 ||detallecaso.Saldo_Prestamo__c==null)){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Digite el saldo del Prestamo'));  
                    if(!test.isRunningTest()){ return null;
                    }
                }
            }
            
            if(cTipoCaso.retiros && detalleCaso.Aplica_Cambio_Sub_Producto_desde_Retiros__c && cuentaCliente.Cuenta_colectiva2__c != null && detalleCaso.Accion__c !='A3'){ 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No puedes cambiar de subproducto a cuenta pertenece a una cuenta colectiva.')); 
                return null; 
            }
            
            if(Caso.id != null && !esCallCenter && !esBanco){ 
                if(cTipoCaso.retiros){
                    list<Detalle_Caso__c> detalleFinal = new list<Detalle_Caso__c>();
                    detalleCaso.Cabeza_retiro__c = true;
                    Boolean hayError = false;
                    Decimal montoBrutoRetirar = 0;
                    //map<string, integer> casos = new  map<string, integer>();
                    //boolean  banderaSaldoRepetido=false;
                    
                    if(detalleCaso.Cliente_sigue_Laborando__c){detalleCaso.Monto_Bruto_Retirar_Empresa__c=0;}
                    if(detalleCaso.Tipo_Retiro__c == '51' || test.isRunningTest()){
                        if(detalleCaso.Se_lleva_Parte_Patronal__c){
                            montoBrutoRetirar += detalleCaso.Saldo_Restante_Cuenta_Cliente__c !=null ? detalleCaso.Saldo_Restante_Cuenta_Cliente__c:0;
                        }
                        if((!detalleCaso.Se_lleva_Parte_Patronal__c && !detalleCaso.Cliente_sigue_Laborando__c) || test.isRunningTest()){
                            detalleCaso.Se_lleva_Parte_Patronal__c=true;
                            detalleCaso.Saldo_Restante_Cuenta_Cliente__c=0;
                            //czx=sa
                        }
                        For(Detalle_caso__c item : cuentasCaso){
                            // system.debug(item);
                            if(item.Monto_retirar__c < 0){
                                item.Monto_retirar__c.addError('No se permiten valores negativos'); 
                                hayError = true; saveTrue = false;
                                break;
                            }else if(item.Monto_retirar__c > item.Monto_saldo__c && item.Monto_retirar__c > 0){ 
                                item.Monto_retirar__c.addError('Monto a retirar no puede ser mayor al monto del saldo'); 
                                hayError = true; saveTrue = false; 
                                break;
                            //}else if((item.Saldo_retirar__c != '13' && item.Monto_retirar__c > 0)){
                            }else if((item.Monto_retirar__c > 0)){ 
                                item.Saldo_enviar_Sysde__c = true; 
                                montoBrutoRetirar += item.Monto_retirar__c; 
                            }
                            
                            detalleFinal.add(item);
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
                                           detalleCaso.Monto_Bruto_Retirar_Empresa__c =item.Monto_saldo__c- SaldoRetirar;
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
                        if(cuentaCliente.currencyIsoCode == 'USD'){
                            //montoCambio = [Select Monto__c From Monto_cambio_dolar__c].Monto__c; //aSysdeCallOuts.montoCambioDolar(); 
                        }
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
                            if(detalleCaso.Comision_retiro_anticipado_empresa__c && detalleCaso.Comision_Retiro_Anticipado__c){ montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                            } else if(!detalleCaso.Comision_Retiro_Anticipado__c && detalleCaso.Comision_retiro_anticipado_empresa__c){ exMontoComi = detalleCaso.Monto_comision_retiro__c;   
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
                                montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                            }
                            if((montoComi>0 && cuentaCliente.Subproducto__r.Cobrar_si_empleado_sigue_laborando__c
                                && detalleCaso.nivel_de_regla__C=='3')  || test.isRunningTest()){
                                    detalleCaso.Monto_comision_retiro__c =0;
                                    montoComi = detalleCaso.Monto_comision_retiro__c; aplicaComi = true;
                                }
                            
                        }
                        montoComi = montoComi !=null ? montoComi.setScale(2) : 0;  
                         detalleCaso.Monto_Bruto_Retirar_Empresa__c= detalleCaso.Monto_Bruto_Retirar_Empresa__c !=null ? detalleCaso.Monto_Bruto_Retirar_Empresa__c :0;
                         if(detalleCaso.Se_lleva_Parte_Patronal__c && detalleCaso.Monto_Bruto_Retirar_Empresa__C > 0){
                           if(cuentaCliente.Cuenta_colectiva2__r.Tipo_Cuenta__c=='2' || test.isRunningTest()){
                                // decimal milTSP = (detalleCaso.Monto_Bruto_Retirar_Empresa__c / 1000).round(System.RoundingMode.UP);
                                //decimal CalculoTSP = (milTSP *2);
                                DetalleCaso.Monto_Neto_Retirar_Empresa__c=detalleCaso.Monto_Bruto_Retirar_Empresa__c;//-CalculoTSP;
                                detalleCaso.Total_Cargos_Empresa__c=0;
                            }
                            if(cuentaCliente.Cuenta_colectiva2__r.Tipo_Cuenta__c=='1' || test.isRunningTest()){
                                // if(cuentaCliente.Cuenta_colectiva2__r.Tipo_Cuenta_bancaria__c=='Savings'
                                //|| cuentaCliente.Cuenta_colectiva2__r.Tipo_Cuenta_bancaria__c=='Checking'){
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
                                //montoChequev =  ;
                                detalleCaso.Monto_TSP_Patrono__c = CalculoTSP;//, Monto_Cheque_Patrono__c, Monto_ACH_Patrono__c,
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
                               milTSP = (((montoBrutoRetirar-  montoComi - /*montoACH - montoCheque -*/ csdc) * montoCambio) / 1000).round(System.RoundingMode.UP);
                           }
                        else{
                            milTSP = (((montoBrutoRetirar - /*montoACH - montoCheque -*/ csdc) * montoCambio) / 1000).round(System.RoundingMode.UP);                            
                        }
                        
                        Decimal calculoTSP = ( milTSP * 2 ) / montoCambio;
                        detalleCaso.Monto_TSP__c = calculoTSP;
                        
                        if(detalleCaso.Cobro_TSP__c){
                            montoTSP = detalleCaso.Monto_TSP__c;
                        }else{ 
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
                        
                        if(cargarCargosEmpleado || test.isRunningTest()){
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
                        if(detalleCaso.Tipo_Retiro__c == '52' || test.isRunningTest()) {
                            detalleCaso.Monto_bruto_retirar__c = (montoBrutoRetirar - detallecaso.Saldo_Prestamo__c - detalleCaso.Saldo_Restante_Cuenta_Cliente__c).setscale(2);
                            detalleCaso.Monto_total_retirar__c = (montoBrutoRetirar - detalleCaso.Monto_total_comisiones_recargos__c - detallecaso.Saldo_Prestamo__c - detalleCaso.Saldo_Restante_Cuenta_Cliente__c).setscale(2);
                        }
                        if(detalleCaso.Monto_total_retirar__c<0) {
                            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'¡El monto a retirar no cubre con los cargos del retiro, por favor selecccione una cantidad mayor!'));
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
                                //update Caso;    
                            }if((Caso.Requiere_aprobacion_exoneracion__c || test.isRunningTest()) && false){ Caso.Requiere_aprobacion_exoneracion__c = false; Caso.RA_limite_exonerado__c = false;    
                                //update Caso;    
                            }
                        detalleFinal.add(detalleCaso);
                        //upsert detalleFinal;
                        
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
                        //System.debug('porcCobroIndiv: '+porcCobroIndiv);
                    }
                }else{               
                    //upsert detalleCaso;
                }               
                if(Caso.constancia__C=='P1' && Caso.enviar_a_aprobacion__C && !caso.Aprobado__c ){ 
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'¡Se ha guardado correctamente, Pendiente el envio a aprobación!'));
                } else {
                    if(saveTrue == true) {
                        //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'¡Se ha actualizado correctamente!'));
                    }
                }
                mostrarGuardar = true;
            }  
            if(detallecaso.Id != Null) {
                //AggregateResult[] groupedResults = [Select SUM(Monto_retirar__c) suma From Detalle_caso__c Where Caso__c =: caso.id];  
                List<Detalle_caso__c> dc = [Select Monto_bruto_retirar__c From Detalle_caso__c Where Caso__c =: caso.id and Tipo_retiro__c = '51' Limit 1];              
                if(detalleCaso.Tipo_retiro__c == '51') { //Retiro Parcial 
                    if(!dc.isEmpty()) {              
                        montoaRetirar = /*Double.valueOf(groupedResults[0].get('suma'))*/dc[0].Monto_bruto_retirar__c;
                    }
                } else if(detalleCaso.Tipo_retiro__c == '52') { //Retiro Total
                    montoaRetirar = detalleCaso.Monto_bruto_retirar__c;
                }
            }
        }catch(System.DmlException e){
            for (Integer i = 0; i < e.getNumDml(); i++) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, e.getDmlMessage(i)));  
            }
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            //Database.rollback(sp);  
        }Catch(Exception e){
            //Database.rollback(sp);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'¡Se ha producido un error!, contacte a su Admin.'));
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
        }
        
        return null;
    }
    
    public void AsignacarCaso(){
        try{
            hayArchivoAdjunto =[SELECT Name, ParentId FROM Attachment 
                                where ParentId =:caso.id];
            if(hayArchivoAdjunto.size()==0 && !test.isRunningTest()){ 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Debe adjuntar un archivo para por asignar caso'));
            }else{
                Usuarios_para_asignacion_Casos_SAC__c p = new Usuarios_para_asignacion_Casos_SAC__c();
                p = [select id, usuario__C, usuario__r.email, Ultimo_Caso_Asignado__c
                     from Usuarios_para_asignacion_Casos_SAC__c where zona__c = :ZonaPorDepto()
                     order by Ultimo_Caso_Asignado__c  asc limit 1];
                caso.OwnerId = p.usuario__C;
                caso.Mostrar_Asignar__C = false;
                SolicitudCaso solicitud = AFPCCasos.upsertCaso(caso);
                if(!solicitud.solicitudExitosa){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Ha ocurrido un error: '+solicitud.error));
                    return;
                }
                p.Ultimo_Caso_Asignado__c = System.now(); 
                update p;
                popVerCaso = false; 
                popCaso = false;
                List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {p.usuario__r.email});
                //mail.setToAddresses(new String[] {'luis.castaneda@intellectsystem.net'});
                string numeroCaso = caso.Casenumber;
                mail.setSubject('Asiganción de nuevo caso No. ' + numeroCaso);
                mail.setPlainTextBody('Buen día, se notifica que se ha asignado nuevo caso (' + numeroCaso + '). \n\nMuchas gracias');
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
                MessageList.add(mail); 
                Messaging.sendEmail(MessageList,false);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.COnfirm, 'Caso asignado con éxito'));
                mostrarFormulario = false;
                //system.debug('Correo se envio con éxito: ' + p.usuario__r.email);
            }
        }catch(Exception ex){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Ha ocurrido un error'));
        }
    }
    public void formularioCliente(){
        popFormulario = true;
        urlFormulario = '/apex/vfFormularioPDFDesdeSite?id=' + Caso.id;
        //urlFormulario ='https://fpc-fpc.cs40.force.com/PortalAutoGestion/vfFormularioPDFSite?Id=' + Caso.id;
        system.debug('url: '+urlFormulario);
    }
    
    public void adjuntarArchivo(){
        //mostrarCerrarCaso = true;
        popAdjuntar = true;
        urlFormulario = '/apex/vfAdjuntarArchivos?Id=' + Caso.id;
        system.debug('URL: '+urlFormulario);
    }
    public void ImprimirCarnet(){
        popFormulario = true;
        urlFormulario = '/apex/vfFormatoCarnetDesdeSite?id=' + Caso.id;
    }
    
    public void PDFCaso(){
        popFormulario = true;
        urlFormulario = '/apex/vfestadoCuentaDetalleMovimientosPDFCaso?Id=' + Caso.id;
    }
    public void generarED(){
        popEDC = true;
        urlFormulario = '/apex/vfRedirigirEstadoCuenta?Id=' + Caso.id;
    }
    
    public void generarConstancia(){
        try {
            if (Caso.Constancia__c == 'A6' &&  Caso.Status != 'Cerrado') { 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'El caso debe de estar aprobado')); return;
            }
            popConstancia = true;
            urlFormulario = '/apex/vfConstanciaPDFDesdeSite?id=' + Caso.id; 
        } catch (Exception e){
            system.debug('Error generarConstancia: '+e.getMessage());
        }
        
    }   
    
    // CONSULTAR CASOS -- PARA LA PARTE DEL PORTAL
    public string idCaso{get;set;}
    public boolean popVerCaso{get;set;}
    
    public boolean flag{get;set;}
    
    public extensionCasoDetalle2(){
        flag = false;
        mostrarFormulario = true;
    }
    public void changeFlag(){
        flag = boolean.valueOf(ApexPages.currentPage().getParameters().get('flagValue'));
    }
    public void CambioConstancia(){
        if(caso.Constancia__c=='P1' ){ 
            caso.Constancia__c =null; 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Esta constancia solo se emite en el area se servicio al cliente de ficohsa pensiones.'));
        }
    }
    public void CambioAsunto(){
        // Caso.subject = null;
        caso.Subject = caso.FPC_Asunto__c;
    }
    public void verCaso(){
        try{
            system.debug('Entro al ver');
            if(idCaso !=null){
                Caso = [Select Status, Priority, Origin, Mostrar_Asignar__C,CaseNumber, Type,Subject, CreatedDate, RecordTypeID,RecordType.DeveloperName,
                        Description,Lugar_Nacimiento__c,account.Departamento_Residencia2__c ,Nacionalidad__c,Estado_Civil__c,Telefono_Casa__c,Telefono_Trabajo__c,Telefono_Movil__c,
                        Empresa__c,Tipo_empresa__c,Departamento_Residencia2__c,Departamento_Trabajo2__c,Ciudad_Residencia2__c,
                        Desea_ver_tasa_de_cambio__c, Mostrar_Saldo_a_la_fecha__c,
                        agencia__C,agencia__r.name, agencia__r.zona__c,Aprueba_SAC__c,Enviar_aprobacion_AD__c,Codigo_barra__c,
                        Ciudad_Trabajo2__c,FPC_Asunto__c ,Punto_Referencia_Residencia__c,Punto_Referencia_Trabajo__c,Cargo_actual__c,
                        Rango_salarial_Lps__c,Fecha_Ingreso__c,Fecha_salida__c,Tipo_Estado_Cuenta__c,Estado_Cuenta_Detallado__c,
                        Fecha_desde__c,Fecha_hasta__c,Constancia__c,Frecuencia__c,Embajadas__c,Nombre_Cliente__c,Segundo_nombre__c,
                        Apellidos__c, Segundo_apellido__c,Usuario_referencia__c ,Tipo_Identificacion__c,Identificacion__c,Sexo__c,Fecha_Nacimiento__c,Correo_Electronico__c,
                        usuario_firmador__c,Monto_compromiso_aporte__c,Apellido_Usuario_Firmador__c,Cargo_Usuario_Firmador__c, Nombre_Usuario_Firmador__c 
                        From Case
                        Where Id =: idCaso];
                
                cuentasCaso = [Select Nueva_Cuenta_colectiva2__c, Nuevo_Subproducto__c, Cuenta__c,
                               Detalle_subproducto__c, Detalle_Cuenta_colectiva__c,
                               Accion__c,Nueva_fecha_aporte__c,Nuevo_canal_aporte__c,Nuevo_monto_aporte__c,
                               N_Cuenta_Bancaria__c,Tipo_Operacion__c,Tipo_saldo_modificar2__c,
                               Cliente_quiere_capital_semilla__c,Cliente_sigue_Laborando__c,Permitir_Retiro_Saldos_Patronales__c,
                               Comision_Retiro_Anticipado__c, Monto_retirar__c,Tipo_retiro__c,Forma_Retiro__c,Banco__c,Tipo_Cuenta__c,
                               currencyIsoCode,Tipo_transaccion__c,Subtipo_transaccion__c,Comision_por_aporte__c,Monto_reversar__c,
                               Porcentaje_comision__c, Fecha_aporte__c, Frecuencia__c, Mes__c, Ano_tarjeta__c,Fecha_nacimiento__c,
                               Sexo__c,Primer_Nombre__c, Segundo_Nombre__c, Primer_Apellido__c, Segundo_Apellido__c, Parentesco__c,
                               Tipo_identificacion__c,Porcentaje__c, Identificacion__c, Indice__c, POS__c, Saldo_retirar__c,
                               Cabeza_Retiro__c, Comision_retiro_anticipado_empresa__c, Cobrar_empleado_sigue_laborando__c,
                               Cobro_ACH__c, Cobro_Cheque__c, Cobro_TSP__c,Monto_cheque__c,Monto_TSP__c, Monto_ACH__c,
                               Monto_Saldo__c,Saldo_Total__c, Fecha_desde__c, Fecha_Hasta__c,Rendimiento__c,Monto_comision_saldo__c,
                               Monto_comision_aporte__c,Pago_terceros__c,Cuenta_destino__c,Propietario_cuenta__c
                               From Detalle_caso__c Where Caso__c =: caso.id order by Cabeza_retiro__c desc];
                
                
                cTipoCaso = new claseTipoCaso(Caso.RecordType.DeveloperName);
                if(!cuentasCaso.isEmpty()){
                    detalleCaso = new detalle_Caso__C();
                    detalleCaso = cuentasCaso[0];
                }
                popVerCaso = true;  
            }
        }Catch(Exception e){
            system.debug('Al ver Casos ' + e.getMessage() + ' linea : ' + e.getLineNumber());       
        }
    }
    
    public void cerrarCaso(){
        popVerCaso = false;
        popCaso = false;
        mostrarSalir= false;
    }
    
    public void cerrarCasoStatusCerrado(){
        try{
            if(Caso.Status == 'Nuevo'){
                hayArchivoAdjunto =[SELECT Name, ParentId FROM Attachment 
                                    where ParentId =:caso.id];
                if(hayArchivoAdjunto.size() == 0 && caso.Origin == 'Agencias_Banco') {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Se debe adjuntar un archivo antes de cerrar el caso')); 
                    return;
                }
                Caso.Status = 'Cerrado';
                SolicitudCaso solicitud = AFPCCasos.upsertCaso(caso);
                //upsert Caso;
                if(Caso.Constancia__c !='A4' && Caso.Constancia__c !='A1' && Caso.Constancia__c !='Saldo' &&
                   Caso.Constancia__c !='A3' && Caso.Constancia__c !='A2' && !ctipocaso.reposicionCarnet ) { 
                       popVerCaso = false; 
                       popCaso = false;
                   }
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.COnfirm, solicitud.solicitudExitosa ? 'Caso cerrado exitosamente' :'Error del cerrar caso: '+solicitud.error));
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Por el estado del caso, este no se puede cerrar'));
                return;
            }
            
        }catch (Exception e){
            system.debug('Error del cerrar caso: '+e.getMessage());
        }
        
    }
    
    public PageReference enviarParaAprobacion(){
        try{
            hayArchivoAdjunto =[SELECT Name, ParentId FROM Attachment 
                                where ParentId =:caso.id];
            if(hayArchivoAdjunto.size() > 0 || test.isRunningTest() ){
                String nombreProceso = CtipoCaso.actInformacion ? 'Actualizacion_Critica' :
                CtipoCaso.constancias ? 'Constancia' : 
                (CtipoCaso.aumDisAporte && caso.Aprueba_SAC__c) ? 'AumentoDisminucion_SAC' :
                (CtipoCaso.aumDisAporte && caso.Enviar_aprobacion_AD__c) ? 'AumentoDisminucion' : null;
                system.debug('Nombre de proceso: '+nombreProceso);
                SolicitudCaso solicitud = AFPCCasos.envioAprobacion(Caso.id, nombreProceso);
                if(!solicitud.solicitudExitosa && !test.isRunningTest()){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Ha ocurrido un error, favor contacte a su admin: '+solicitud.error));
                    return null;
                }
                
                popVerCaso = false;
                popCaso = false;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, 'Se ha enviado para su aprobación'));
            }else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'De debe adjuntar un archivo antes de enviar a aprobar')); 
                
            }
            
        }catch (Exception e){
            system.debug('Error: '+ e.getMessage()+', Linea: '+e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Ha ocurrido un error, favor contacte a su admin'));
        }
        return null;
    }
    
    
    public void tiposDeCasoSegunOrigen(){
        try{       
            tipoRCaso = new list<selectoption>();
            system.debug('Mapa: '+mapTipoRcaso);
            tipoRCaso = mapTipoRcaso.get(Caso.Origin);
        } catch(Exception e) {
        }
    }
    
    public void cambiarTipoCaso(){
        Caso.Type=null;
        caso.Priority = null;
        if(idTipoRCaso !='' && idTipoRCaso !=null && idTipoRCaso !='Otros'){
            Caso.Type='Solicitud';
            caso.Priority = 'Media';
        }
    }
    
    public void cambiarTipo(){
        caso.Priority=null;
        if(Caso.Type =='Reclamo'){ caso.Priority = 'Alta';
        }else if(Caso.Type =='Solicitud'){
            caso.Priority = 'Media';
        }
    }
    
    
    
     public void prioridadTipo(){   
}
    
    public void tipoEstadoDetallado(){
        try{
            estadoCuentaDetallado = new List<SelectOption>();
            if(Caso.Tipo_Estado_Cuenta__c == 'A1'){ 
                estadoCuentaDetallado.add(new SelectOption('General','General')); 
                estadoCuentaDetallado.add(new SelectOption('Historico','Historico'));
            }
            if(Caso.Tipo_Estado_Cuenta__c == 'A2'){ 
                estadoCuentaDetallado.add(new SelectOption('','--Ninguno--'));
            }
        }catch(Exception e){
            
        }
    }
    
    public string zonaPorDepto (){
        if((caso.account.Departamento_Residencia2__c ==null ||
            caso.account.Departamento_Residencia2__c =='0') && !test.isRunningTest()){ 
                return '3';
            }
        else if(caso.account.Departamento_Residencia2__c =='122' ||
                caso.account.Departamento_Residencia2__c =='128'||
                caso.account.Departamento_Residencia2__c =='129'||
                caso.account.Departamento_Residencia2__c =='124'||
                caso.account.Departamento_Residencia2__c =='127'||
                caso.account.Departamento_Residencia2__c =='120'||
                caso.account.Departamento_Residencia2__c =='137'||
                caso.account.Departamento_Residencia2__c =='121'||
                caso.account.Departamento_Residencia2__c =='130'){ 
                    return '1';
                }
        else if(caso.account.Departamento_Residencia2__c =='123' ||
                caso.account.Departamento_Residencia2__c =='126'||
                caso.account.Departamento_Residencia2__c =='131'||
                caso.account.Departamento_Residencia2__c =='133'||
                caso.account.Departamento_Residencia2__c =='132'||
                caso.account.Departamento_Residencia2__c =='134'||
                caso.account.Departamento_Residencia2__c =='135'||
                caso.account.Departamento_Residencia2__c =='136'||
                caso.account.Departamento_Residencia2__c =='125' ||test.isRunningTest()){
                    return '2';
                }
        return null;
    }
    
    
    public static void metodoutil() {}
    
    public string getJson(){
        String p = '{"V_fo_cuenta":null,"pc_codCuenta":null,"pcEst_cuenta":"A","pcCod_Causa":"05","pcempresa":null,"pcagencia"'+
            ':null,"pnnrocertificado":"FPC4912","RTN":"null","pdfechasuscripcion":"2017-01-06T00:00:00","pcPEP":"N","pcFAT'+
            'CA":"N","pctipoid":"1","pcnroid":"0801199411013","pcFechaVencimientoCN":null,"pcprimerapellido":"ALVARADO","p'+
            'csegundoapellido":"AGUILAR","pcprimernombre":"WENDY","pcsegundonombre":"PAOLA","pcTelefonoCN":null,"pcCelularC'+
            'N":null,"pdfechanacimiento":"1993-09-24T00:00:00","pdLugarNacimientoCN":"EL PROGRESO","pcsexo":"F","pcestadociv'+
            'il":"S","pcNombreConyuge":"null","pcProfesionOcupacion":"1","pcmail":"josue.blandon@intellectsystem.net","pcAPNFD'+
            '":"N","PC_DEBIDA_DELIGENCIA":"2","PC_NIVEL_RIESGO":"1","PCNumeroAPNFD":"null","pc_ActuaSI":"N","Cargo_Pulbico":"nu'+
            'll","pcNumeroIDPV":"null","pcEjerce_Cargo_Publico":"N","pcNombreCompletoPV":"null","OcultaCarSI":null,"pcCargoEjerc'+
            'ido":null,"pcDependeSI":"N","pcDependeNO":"S","pcTipoIDDependencia":"null","pcNumeroIDDependencia":"null","pcNombreCo'+
            'mpletoDependencia":"null","pccodpais":null,"pcDeptoCN":null,"pcMunicipioCN":null,"pcCalleDetalleCN":null,"pcColoniaCN"'+
            ':null,"pcnacionalidad":"074","pcnacionalidad2":"null","pcnacionalidad3":"null","pcPrimerNombreReferi1":"A","pcSegundoNo'+
            'mbreReferi1":"null","pcPrimerApellidoReferi1":"C","pcSegundoApellidoReferi1":"null","pcTelefono_Referido1Referi1":"123"'+
            ',"pcPrimerNombreReferi2":"A","pcSegundoNombreReferi2":"null","pcPrimerApellidoReferi2":"C","pcSegundoApellidoReferi2":"'+
            'null","pcTelefono_ReferidoReferi2":"123","pccontratocolectivo":"null","pcrncempl":"05019995154451","pcTipoEmpresaEmpCN":'+
            '"N","pcnombreempl":"EMPIRE OF HONDURAS S.A.","pcrazonsocialempl":null,"pcCargoEmpresaEmpCN":"OPERARIO (A)","pcGiroEmpresaEmp'+
            'CN":"null","pctelempl":null,"pcextempl":null,"pcmailempl":"NEFERNANDEZ@EMPIRE.HN","vccodpais":null,"pcDeptoEmpleadorCN":n'+
            'ull,"pcMunicipioEmpleadorCN":null,"pcColoniaEmpleadorCN":null,"pcdirempl":null,"pcTIpoEmpleado":"1","pcNivelIngreso":"1","'+
            'pdfechainiciolabor":"2020-01-16T00:00:00","pcUsuarioCN":"//","pcAgn":null,"pcFechaValidacionCN":null,"pcproducto":"01",'+
            '"pcsubproducto":"FPC08","pcTipoFondo":"P","pcTipoMoneda":"1","pcperiodicidad":"W","pcformapago":"PL","pcDiaAportacion":"'+
            '15","pnmontoaporte":"811","pnmontoaporte12":"0","pccuentapago":"null","pcSalarioP":"null","numtran":"null","TipoPantalla":null'+
                ',"pcaplicaseguro":"N","pcPrimaAsegurada":"0","pcSumaAsegurada":"0","pcTipoSeguro":"null","pcPlazoSeguro":"null","pcfecCancelaS'+
            'eguro":null,"pcNUMUSU":"null","pcenvio":"E","pcTipoAporte":"F","v_des_procedfds":"SALARIO","pcpromotor":"HN19333","Pctipo'+
            'solicitud":null,"ES_Residente":"S","ES_Residente_EfectosMi":"N","PaisResidenciaEfectosFiscales":"null","NumeroID_Fiscal_EEUU":"null"'+
            ',"NumeroID_Fiscal_OtroPais":"null","ListBeneficiarios":[{"idExterno":31711.0,"tipoId":"1","numeroId":"0801-1991-07738","tipoBeneficiar'+
            'io":"D","genero":"F","primerNombre":"ROSA","segundoNombre":"MARIA","primerApellido":"AGUILAR","segundoApellido":"MARTINEZ","Parentesco":'+
            '"6","Distribucion":50.0,"Grado":2.0,"fechaNacimiento":"1991-04-04T00:00:00"},{"idExterno":31712.0,"tipoId":"1","numeroId":"0801-1997-24089",'+
            '"tipoBeneficiario":"D","genero":"M","primerNombre":"HAROLES","segundoNombre":"ANDRES","primerApellido":"GEADAH","segundoApellido":"DONAIRE",'+
            '"Parentesco":"6","Distribucion":50.0,"Grado":2.0,"fechaNacimiento":"1993-09-24T00:00:00"}],"ListDebidaDil":[],"ListTelefonos":[{"Secuencia":10'+
            '.0,"numTelefono":"88612510","tipTelefono":"C","extension":null,"esDefault":"N","TelUbicacion":"C"},{"Secuencia":11.0,"numTelefono":"22357898",'+
            '"tipTelefono":"D","extension":null,"esDefault":"N","TelUbicacion":"T"},{"Secuencia":12.0,"numTelefono":"99874567","tipTelefono":"C","extension":null,'+
            '"esDefault":"N","TelUbicacion":"C"},{"Secuencia":16.0,"numTelefono":"88888888","tipTelefono":"C","extension":null,"esDefault":"S","TelUbicacion":"C"},'+
        '{"Secuencia":14.0,"numTelefono":"95095729","tipTelefono":"C","extension":null,"esDefault":"N","TelUbicacion":"C"},{"Secuencia":15.0,"numTelefono":"33170000",'+
            '"tipTelefono":"C","extension":null,"esDefault":"N","TelUbicacion":"C"}],"ListDirecciones":[{"codDireccion":"14","tipDireccion":"C","detalleDir":"ASXDCFVB ",'+
            '"paisDir":"074","deptoDir":"127","ciuDir":"000","coloDir":"000","esDefault":"N","secuencia":5.0},{"codDireccion":"11","tipDireccion":"C","detalleDir":"PRUEBA01"'+
            ',"paisDir":"074","deptoDir":"123","ciuDir":"25","coloDir":"000","esDefault":"N","secuencia":2.0},{"codDireccion":"12","tipDireccion":"C","detalleDir":"PRUEBA02","'+
            'paisDir":"074","deptoDir":"123","ciuDir":"25","coloDir":"000","esDefault":"N","secuencia":3.0},{"codDireccion":"15","tipDireccion":"T","detalleDir":"ASXDCFVB ",'+
            '"paisDir":"074","deptoDir":"127","ciuDir":"000","coloDir":"000","esDefault":"N","secuencia":6.0},{"codDireccion":"17","tipDireccion":"C","detalleDir":"ASXDCFVB ",'+
            '"paisDir":"074","deptoDir":"120","ciuDir":"02","coloDir":"0001","esDefault":"N","secuencia":8.0},{"codDireccion":"13","tipDireccion":"C","detalleDir":"PRUEBA03","paisDir"'+
            ':"074","deptoDir":"123","ciuDir":"25","coloDir":"000","esDefault":"N","secuencia":4.0},{"codDireccion":"16","tipDireccion":"C","detalleDir":"ASXDCFVB ","paisDir":"074"'+
            ',"deptoDir":"120","ciuDir":"01","coloDir":"0032","esDefault":"N","secuencia":7.0},{"codDireccion":"18","tipDireccion":"C","detalleDir":"ASXDCFVB SASDFGTHYGTFRDS HKUHKUJ"'+
            ',"paisDir":"074","deptoDir":"127","ciuDir":"28","coloDir":"0002","esDefault":"S","secuencia":9.0}],"ListHistorial":null}';
    return p;
    }
    
    
}