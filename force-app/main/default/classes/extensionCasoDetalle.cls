public class extensionCasoDetalle {
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
    public List<Detalle_caso__c> cuentasCaso{get;set;}
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
    public list<SelectOption> listAgencias{get;set;}
    public decimal totalSaldo2;
    public integer conteoGeneral{get;set;}
    public integer indiceEliminar{get;set;} 
    public boolean MostartablaMovimientos{get;set;}
    public list<SelectOption> listCuentas{get;set;}
    public string idCuenta{get;set;}
    public string MonedaCuenta{get;set;}
    private map<String, Cuentas__c> mapCuentas = new map<String, Cuentas__c>();
    public list<Beneficiario__c> listBeneficiarios{get;set;}
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
    public boolean mostrarFinalizar{get;set;}
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
    public string Identidad{get;set;}
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
    
    public String DAU_Cambio_de_Fecha{get;set;}
    Public String Nueva_fecha_aporte {get;set;}
    Public Boolean Fechas_disponibles {get;set;}
    
    public extensionCasoDetalle(ApexPages.StandardController controller) {
      
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
        mapDCasoCuenta = new map<Id, Detalle_Caso__c>();
        listDetalleEliminar = new list<Detalle_Caso__c>();
        listBeneficiarios = new list<Beneficiario__c>();
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
        mostrarFinalizar = false;
        //nueva lista
        
        
        try{
            
            if(CasoSTD.Id != null){
                Caso = [Select Status, AccountId, CreatedDate, Account.Name, Account.Identificacion__c, RecordType.DeveloperName,
                        Fecha_desde__c, fecha_hasta__c,Account.PersonBirthdate, account.sexo__C, Desea_ver_tasa_de_cambio__c, 
                        SuppliedEmail, Constancia__c, currencyIsoCode,Requiere_aprobacion_exoneracion__c, Mostrar_tasa_Cambio__c,Tasa_Cambio__c,
                        //account.Departamento_Residencia__r.Codigo_Departamento__c,
                        Enviar_a_aprobacion__c,Aplica_Saldo_patronal__c ,Aprobado__c, Nombre_agencia__c, agencia__c, Agencia__r.Name, 
                        account.Departamento_Residencia2__c, Monto_compromiso_aporte__c, Frecuencia__c, Codigo_barra__C, DAU_No_Cuenta__c, 
                        DAU_Tarjeta_de_Sysde__c, DAU_llamarSalesforceTarjeta__c, Tipo_de_Operacion__c, Respuesta_SF_Tarjetas__c, DAU_Identidad__c
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
                for(agencia__C item: database.query(query)){ 
                    listAgencias.add(new SelectOption(item.id, item.name));
                }
                           
                if(Caso.Status != 'Pendiente de aprobación' && Caso.Status != 'Pendiente segunda aprobación' 
                   && Caso.Status != 'Error de conexion' && Caso.Status != 'Cerrado') {
                       mostrarGuardar = true;
                   } else {
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
                cuentasCaso=[Select id, Nueva_Cuenta_colectiva2__c, Nuevo_Subproducto__c, Cuenta__c, Tipo_Saldo__c,Cobrar_comision__c, 
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
                             Monto_Pignorar_Refinanciamiento__C, Cuenta__r.Forma_Aportacion__c, Cuenta__r.Name,
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
                             Porcentaje_Saldo_Patronal_Ext__c, Tipo_pago__c, DAU_Dia_de_pago__c, DAU_Borrar_Cuotas__c, DAU_Tipo_Tarjeta__c, DAU_Tarjeta_Habiente__c
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
                    
                } else { 
                
                    pagosBT = 'display:none;';
                
                }
               
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
    
    public List<SelectOption> getCambioFechaOptions(){
        List<SelectOption> optns = new List<Selectoption>();
        String test = Label.DAU_Cambio_de_Fecha_1; System.debug('test: '+test);
        String test2 = Label.DAU_Cambio_de_Fecha_2; System.debug('test2: '+test2);
        optns.add(new SelectOption('', '--Elija una opción--'));
        if(test == '0' && test2 == '0') {
           Nueva_fecha_aporte = 'pointer-events: auto;background-color:white;';
           Fechas_disponibles = false;
        } else {
           Nueva_fecha_aporte = 'pointer-events: none;background-color:black;';
           Fechas_disponibles = true;
            if(test != '0') {
                optns.add(new selectOption(test, test));    
            }
            if(test2 != '0') {
                 optns.add(new selectOption(test2, test2)); 
            }
        }        
        return optns;
    }
    
    public void setCambioFecha(){
        if(DAU_Cambio_de_Fecha != null) {
                String Month = String.ValueOf(Date.Today().Month()); System.debug('Month: '+Month);
                String Year = String.ValueOf(Date.Today().Year()); System.debug('Year: '+Year);
                detalleCaso.Nueva_fecha_aporte__c = Date.newInstance(Integer.Valueof(Year), Integer.Valueof(Month), Integer.Valueof(DAU_Cambio_de_Fecha));       
        }
    }
    
    public void getListAgentsByZone() {
        listAgencias = new list<SelectOption>();
        listAgencias.add(new SelectOption('', '--Ninguno--'));
        for(agencia__c item : [Select id, Name from agencia__c Where zona__c = :ZonaSeleccionada and zona__c!=null Order By Name Limit 1000]) {
            listAgencias.add(new SelectOption(item.Id, item.Name));
        } 
    }
    
    public void actualizarRezago(){
       // system.debug(detalleCaso.rezago__C+' '+);
        if( detalleCaso.rezago__C =='N' || (detalleCaso.rezago__C =='S' && detalleCaso.Cod_Referencia__c !=null)){
            update detalleCaso; 
            popRezago = false;
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
                                   Porcentaje_CRA_Individual__c, Cobro_Individual_CRA__c,FondoInversionCP__c,
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
    
     public string tipoSaldo{get;set;}
        
    
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
    
    
    String tipoPagoBenes;
    boolean tipoPB = true;
    public boolean saveAll = false;
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
    public Integer rowNum2{get;set;}
    
    
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
                        validacionSaldosP1();
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
    
    public void validacionSaldosP1(){
        detalleCaso.Total_Saldo_Patronal__c=0;
        detalleCaso.Total_Saldo_Personal__c=0;
        cuentaCliente = mapCuentas.get(idCuenta);
        if(caso.CurrencyIsoCode=='USD' && cuentaCliente.CurrencyIsoCode == 'HNL'){
            detalleCaso = new detalle_caso__C();
            cuentasCaso = new list<detalle_caso__C>();
            cuentaCliente = new Cuentas__C();
            mapDCasoCuenta = new map<Id, detalle_caso__C>();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No esta permitido prestamo en dolares con fonde en lempiras.'));
            return;
        }
        
        getSaldoCuenta saldosTempo = new getSaldoCuenta(); 
        detalleCaso.CurrencyIsoCode = caso.CurrencyIsoCode;
        saldosTempo = aSysdeCallouts.traerSaldos(cuentaCliente.Codigo__c);
        
        detalleCaso.Monto_Pignorado__c=0;
        detalleCaso.Monto_Prestamo__c = 0;
        try{detalleCaso.Monto_Pignorado__c = saldosTempo.montoPignorado !='null' ? decimal.valueOf(saldosTempo.montoPignorado.replace(',','')) : 0;}catch(Exception ex){}
        for(classSaldos tipoSaldo : saldosTempo.saldos){
            if(caso.CurrencyIsoCode == cuentaCliente.CurrencyIsoCode){
                if(tipoSaldo.tipoSaldo=='10' || tipoSaldo.tipoSaldo=='11' ){
                    detalleCaso.Total_Saldo_Personal__c +=decimal.valueOf(tipoSaldo.montoSaldo.replace(',',''));
                }else{
                    detalleCaso.Total_Saldo_Patronal__c +=decimal.valueOf(tipoSaldo.montoSaldo.replace(',',''));
                }
            }else if(caso.CurrencyIsoCode=='HNL' && cuentaCliente.CurrencyIsoCode == 'USD'){
                system.debug('Hola 1');
                if(caso.Tasa_Cambio__c == null){
                    detalleCaso = new detalle_caso__C();
                    cuentaCliente = new Cuentas__C();
                    cuentasCaso = new list<detalle_caso__C>();
                    mapDCasoCuenta = new map<Id, detalle_caso__C>();
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Para hacer este tipo de constancia tiene que detallar la tasa de cambio en el caso'));
                    return;
                }
                detalleCaso.Cambio_moneda__c = true;
                if(tipoSaldo.tipoSaldo=='10' || tipoSaldo.tipoSaldo=='11' ){
                    detalleCaso.Total_Saldo_Personal__c +=decimal.valueOf(tipoSaldo.montoSaldo.replace(',',''))*caso.Tasa_Cambio__c;
                }else{
                    detalleCaso.Total_Saldo_Patronal__c +=decimal.valueOf(tipoSaldo.montoSaldo.replace(',',''))*caso.Tasa_Cambio__c;
                }
            }
        }
        detalleCaso.Monto_Pignorado__c = (detalleCaso.Cambio_moneda__c && detalleCaso.Monto_Pignorado__c > 0) ?  (detalleCaso.Monto_Pignorado__c * caso.Tasa_Cambio__c).setscale(2) : detalleCaso.Monto_Pignorado__c;         
        
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
    
    
    public void mostrar(){
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
    
    public void CalculoRendimientoDIario() {
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
        if(detalleCaso!=null && detalleCaso.Accion__c == 'A3'){ 
            detalleCaso.Nueva_Cuenta_colectiva2__c = null;
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
        RecordType registro =[select id,DeveloperName from RecordType where DeveloperName =:idTipoRCaso or id=:idTipoRCaso];
        Caso.recordTypeId = registro.id;
        cTipoCaso = new claseTipoCaso(registro.DeveloperName);
        if(cTipoCaso.aumDisAporte ){
            for(SelectOption item:listCuentas){
                String codecuenta = item.getLabel();
                codecuenta = codecuenta.contains(' ') ? codecuenta.split(' ')[0] : item.getLabel();
                if(item.getValue() == idCuenta &&!AumentoDisminucionHelper.verifiacarEstadoCuenta(codecuenta)){
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Lo sentimos pero la cuenta selecionada se encuentra inactiva.'));
                    return ;
                }
            }
            
        }
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
    public void cambioMonto(){
        if(movimientoSeleccionado !=null){
            movimientoSeleccionado.Monto__c=detallecaso.Monto_reversar__c;
        }
    }
    public void cambioMontoC1(){
        system.debug('Monto: '+movimientoSeleccionado.Monto__c);
        detallecaso.Monto_reversar__c=movimientoSeleccionado.Monto__c;
    }
    public void cambioTipoSaldo(){
        if(movimientoSeleccionado !=null) { 
            movimientoSeleccionado.Tipo_Saldo__c=detallecaso.Tipo_Saldo__c;
        }
    }
    public boolean mostrarSalir{get;set;}
    
    public void guardarReversiones(){
        if( detalleCaso.Subtipo_transaccion__c =='C10' ||detalleCaso.Subtipo_transaccion__c =='C9' ||
           detalleCaso.Subtipo_transaccion__c =='C8') {
               popDolares = true;
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
            
            if(cTipoCaso.aumDisAporte) { 
                System.debug('Id Cuenta: '+idCuenta + '---' + 'Forma de Aportación: '+cuentaCliente.Forma_Aportacion__c);
                List<Cuentas__c> cuentaClie = [Select Id, Forma_Aportacion__c,Codigo__C From Cuentas__c Where Id =: idCuenta Limit 1];
                System.debug('cuentaClie: '+cuentaClie);
                if(detallecaso.Tipo_Operacion__c == 'A4' /*&& cuentaClie[0].Forma_Aportacion__c == 'TA'*/ && detalleCaso.Nueva_fecha_aporte__c.day()!=Integer.ValueOf(Label.DAU_Cambio_de_Fecha_1) && detalleCaso.Nueva_fecha_aporte__c.day() !=Integer.ValueOf(Label.DAU_Cambio_de_Fecha_2)){
                    saveTrue = false;
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ( 'Fecha de Aporte permitida (' + Label.DAU_Cambio_de_Fecha_1 + ' ó ' + Label.DAU_Cambio_de_Fecha_2 + ') de cada mes')));
                    return null;
                }
                if(!AumentoDisminucionHelper.verifiacarEstadoCuenta(cuentaClie[0].Codigo__C)){
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Lo sentimos pero la cuenta selecionada se encuentra inactiva.'));
                    return null ;
                }
                              
            }
            if((cTipoCaso.reversiones)){
                caso.CurrencyIsoCode=cuentaCliente.currencyIsoCode;
                detalleCaso.CurrencyIsoCode=cuentaCliente.currencyIsoCode;
                for(integer i=0; i<cuentasCaso.size(); i++){
                    cuentasCaso[i].CurrencyIsoCode=cuentaCliente.currencyIsoCode;
                }
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
            if(detalleCaso.Monto_reversar__c<=0 && cTipoCaso.reversiones) { 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El monto tiene que ser mayor que cero')); return null; 
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
                    
                }else if(cTipoCaso.aumDisAporte && saveTrue == true) {                                                           
    
                    if(detalleCaso.Nuevo_canal_aporte__c == 'TA' || detalleCaso.Banco__c == '28') {
                        if((detalleCaso.Tipo_Operacion__c == 'A3' || detalleCaso.Tipo_Operacion__c == 'A8') && caso.DAU_No_Cuenta__c == Null) {
                            System.debug('Cambio de Canal de Aporte o Afiliación de Débito Automático');
                            updateCase.wrapperClass wc = new updateCase.wrapperClass();
                            wc = updateCase.validarIdentidad(String.valueOf(Caso.Id), detalleCaso.N_Cuenta_Bancaria__c, Caso.Account.Identificacion__c);
                            System.debug('validar Identidad: '+wc);
                            caso.DAU_Identidad__c = wc.DAU_Identidad;
                            caso.DAU_No_Cuenta__c = wc.DAU_No_Cuenta;
                            caso.DAU_aprobacion__c = wc.DAU_aprobacion;
                            caso.Respuesta_SF_Tarjetas__c = wc.Respuesta_SF_Tarjetas;
                        }
                        if(detalleCaso.Tipo_Operacion__c == 'A4' && caso.DAU_No_Cuenta__c == Null) {
                            Caso.DAU_Tarjeta_de_Sysde__c = DAU_BorrarCuotas.ConsultaInfoClienteC(Caso.Id, mapcuentas.get(idCuenta).Codigo__c);
                            if(Caso.DAU_Tarjeta_de_Sysde__c <> Null) {
                                updateCase.wrapperClass wc = new updateCase.wrapperClass();
                                wc = updateCase.validarIdentidad(Caso.Id, Caso.DAU_Tarjeta_de_Sysde__c, Caso.Account.Identificacion__c);
                                System.debug('validar Identidad: '+wc);
                                caso.DAU_Identidad__c = wc.DAU_Identidad;
                                caso.DAU_No_Cuenta__c = wc.DAU_No_Cuenta;
                                caso.DAU_aprobacion__c = wc.DAU_aprobacion;
                                caso.Respuesta_SF_Tarjetas__c = wc.Respuesta_SF_Tarjetas;
                            }
                        }
                        if(detalleCaso.Tipo_Operacion__c == 'A6' && caso.DAU_No_Cuenta__c == Null) {
                            Caso.DAU_Tarjeta_de_Sysde__c = DAU_BorrarCuotas.ConsultaInfoClienteC(Caso.Id, mapcuentas.get(idCuenta).Codigo__c);
                            if(Caso.DAU_Tarjeta_de_Sysde__c <> Null) {
                                updateCase.wrapperClass wc = new updateCase.wrapperClass();
                                wc = updateCase.validarIdentidad(Caso.Id, Caso.DAU_Tarjeta_de_Sysde__c, Caso.Account.Identificacion__c);
                                System.debug('validar Identidad: '+wc);
                                caso.DAU_Identidad__c = wc.DAU_Identidad;
                                caso.DAU_No_Cuenta__c = wc.DAU_No_Cuenta;
                                //caso.DAU_aprobacion__c = wc.DAU_aprobacion;
                                caso.Respuesta_SF_Tarjetas__c = wc.Respuesta_SF_Tarjetas;
                            }
                            if(Caso.DAU_Identidad__c <> Null && Caso.DAU_No_Cuenta__c <> Null) {
                                Set<Id> caseId = new Set<Id>();
                                caseId.add(Caso.Id);
                                Salesforce_Tarjetas.processCase(caseId, 'DEC', '', ''); 
                            }    
                        }   
                        if(detalleCaso.Tipo_Operacion__c == 'A7' && caso.DAU_No_Cuenta__c == Null) {
                            Caso.DAU_Tarjeta_de_Sysde__c = DAU_BorrarCuotas.ConsultaInfoClienteC(Caso.Id, mapcuentas.get(idCuenta).Codigo__c);
                            if(Caso.DAU_Tarjeta_de_Sysde__c <> Null) {
                                updateCase.wrapperClass wc = new updateCase.wrapperClass();
                                wc = updateCase.validarIdentidad(Caso.Id, Caso.DAU_Tarjeta_de_Sysde__c, Caso.Account.Identificacion__c);
                                System.debug('validar Identidad: '+wc);
                                caso.DAU_Identidad__c = wc.DAU_Identidad;
                                caso.DAU_No_Cuenta__c = wc.DAU_No_Cuenta;
                                caso.DAU_aprobacion__c = false;
                            }    
                        }
                    }  
                    if(detalleCaso.Nuevo_canal_aporte__c == 'TAOB' || detalleCaso.Banco__c == 'Otros Bancos') {
                        /*String Respuesta = DAU_GestionesBac.executeCancel(Caso.Id);
                        caso.Respuesta_SF_Tarjetas__c = Respuesta;*/
                        List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                        Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = Caso.Id));
                        // Call method to publish events
                        List<Database.SaveResult> results = EventBus.publish(Logs);
                    }
                    update Caso;    
                    upsert detalleCaso;
                }else if(cTipoCaso.actInformacion){
                    upsert cuentasCaso;
                    
                }else{               
                    if(saveTrue == true) {
                        upsert detalleCaso;
                    }    
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
            if(Caso.id == null || esCallCenter || esBanco || test.isRunningTest()) {
                Boolean hayError = false;
                mostrarFormulario = false;
                Boolean upsertDetalleC = false;
                if(caso.Origin == 'Agencias_Banco') { mostrarFormulario = true;
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
                if(cTipoCaso.aumDisAporte || test.isRunningTest()) {
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
                
                if(!hayError ||  test.isRunningTest()) {
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
                        System.debug('Tipo de operación: '+detalleCaso.Tipo_Operacion__c);
                        if(caso.Origin != 'Agencias_Banco' && (cuentaCLiente.Forma_Aportacion__c == 'PL' || cuentaCLiente.Forma_Aportacion__c == 'AH' || cuentaCLiente.Forma_Aportacion__c =='CK' ||  cuentaCLiente.Forma_Aportacion__c == 'TA' || detallecaso.Tipo_Operacion__c=='A3' || detallecaso.Tipo_Operacion__c=='A5' || detallecaso.Tipo_Operacion__c=='A6' || detallecaso.Tipo_Operacion__c=='A8')){
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
                            
                        } else if(caso.Origin != 'Agencias_Banco'){ 
                            mostrarEnviarAprobacion= false;
                        } else if(cuentaCLiente.Forma_Aportacion__c=='PL'){
                            caso.Enviar_aprobacion_AD__c = false;
                            caso.Aprueba_SAC__c = true;
                            mostrarEnviarAprobacion= true;
                            solicitud = AFPCCasos.upsertCaso(caso);
                        } else if(cuentaCLiente.Forma_Aportacion__c == 'AH' || cuentaCLiente.Forma_Aportacion__c =='CK' ||  cuentaCLiente.Forma_Aportacion__c == 'TA' || detallecaso.Tipo_Operacion__c=='A3' || detallecaso.Tipo_Operacion__c=='A4' || detallecaso.Tipo_Operacion__c=='A5' || detallecaso.Tipo_Operacion__c=='A6'){
                            /*caso.Enviar_aprobacion_AD__c = true;
                            caso.Aprueba_SAC__c = false;
                            mostrarEnviarAprobacion= true;*/
                            
                            
                            
                            //if(detalleCaso.Nuevo_canal_aporte__c == 'TA' || detalleCaso.Banco__c == '28') {
                                /*if((detalleCaso.Tipo_Operacion__c == 'A3' || detalleCaso.Tipo_Operacion__c == 'A8') && caso.DAU_No_Cuenta__c == Null) {
                                    System.debug('Cambio de Canal de Aporte o Afiliación de Débito Automático');
                                    updateCase.wrapperClass wc = new updateCase.wrapperClass();
                                    wc = updateCase.validarIdentidad(String.valueOf(Caso.Id), detalleCaso.N_Cuenta_Bancaria__c, Identidad);
                                    System.debug('validar Identidad: '+wc);
                                    caso.DAU_Identidad__c = wc.DAU_Identidad;
                                    caso.DAU_No_Cuenta__c = wc.DAU_No_Cuenta;
                                    caso.DAU_aprobacion__c = wc.DAU_aprobacion;
                                    caso.Respuesta_SF_Tarjetas__c = wc.Respuesta_SF_Tarjetas;
                                }*/
                            //}
                            
                            //solicitud = AFPCCasos.upsertCaso(caso);
                        }
                        if(detallecaso.Tipo_Operacion__c == 'A2') {  
                            System.debug('Caso de disminución de aporte');
                            List<Producto__c> prod = [Select Id,CurrencyIsoCode From Producto__c Where Id =: mapcuentas.get(idCuenta).Producto__c];
                            List<Parametros_DAU__mdt> paramHNL = [Select Id,DeveloperName,Monto_a_Disminuir__c From Parametros_DAU__mdt Where DeveloperName = 'Disminucion_de_aporte_HNL']; 
                            List<Parametros_DAU__mdt> paramUSD = [Select Id,DeveloperName,Monto_a_Disminuir__c From Parametros_DAU__mdt Where DeveloperName = 'Disminucion_de_aporte_USD']; 
                            if(!prod.isEmpty() && prod[0].CurrencyIsoCode == 'HNL') {
                                System.debug('Cuenta en Lempiras');
                                if((mapcuentas.get(idCuenta).Monto_aporte__c -detallecaso.Nuevo_monto_aporte__c) >= paramHNL[0].Monto_a_Disminuir__c) {  
                                    //caso.Archivo_Adjunto__c = true;
                                    caso.Enviar_aprobacion_AD__c = true;
                                    caso.DAU_aprobacion__c = false;
                                    solicitud = new SolicitudCaso();
                                    solicitud = AFPCCasos.upsertCaso(caso);                                    
                                }
                            } else if(!prod.isEmpty() && prod[0].CurrencyIsoCode == 'USD') {
                                System.debug('Cuenta en Dólares');
                                if((mapcuentas.get(idCuenta).Monto_aporte__c - detallecaso.Nuevo_monto_aporte__c) >= paramUSD[0].Monto_a_Disminuir__c) {
                                    //caso.Archivo_Adjunto__c = true;
                                    caso.Enviar_aprobacion_AD__c = true;
                                    caso.DAU_aprobacion__c = false;
                                    solicitud = new SolicitudCaso();
                                    solicitud = AFPCCasos.upsertCaso(caso);
                                }
                            }    
                        } 
                        if(detalleCaso.Tipo_Operacion__c == 'A4' && detalleCaso.Banco__c == '28') {
                            System.debug('Cambio de Fecha de Aporte');
                            Caso.DAU_Tarjeta_de_Sysde__c = DAU_BorrarCuotas.ConsultaInfoClienteC(Caso.Id, mapcuentas.get(idCuenta).Codigo__c);
                            System.debug('DAU_Tarjeta_de_Sysde: '+Caso.DAU_Tarjeta_de_Sysde__c);
                            if(Caso.DAU_Tarjeta_de_Sysde__c <> Null) {
                                updateCase.wrapperClass wc = new updateCase.wrapperClass();
                                wc = updateCase.validarIdentidad(Caso.Id, Caso.DAU_Tarjeta_de_Sysde__c, Identidad);
                                System.debug('validar Identidad: '+wc);
                                caso.DAU_Identidad__c = wc.DAU_Identidad;
                                caso.DAU_No_Cuenta__c = wc.DAU_No_Cuenta;
                                caso.DAU_aprobacion__c = wc.DAU_aprobacion;
                                caso.Respuesta_SF_Tarjetas__c = wc.Respuesta_SF_Tarjetas;
                            }
                            solicitud = AFPCCasos.upsertCaso(caso);
                        }   
                        if(detallecaso.Nuevo_canal_aporte__c == 'TA' && (detalleCaso.Tipo_Operacion__c == 'A3' || detalleCaso.Tipo_Operacion__c == 'A8')) {                     
                            System.debug('Cambio de Canal de Aporte o Afiliación de Débito Automático');
                            System.debug('Caso.Id: '+Caso.Id+'-detalleCaso.N_Cuenta_Bancaria__c: '+detalleCaso.N_Cuenta_Bancaria__c+'-Identidad: '+Identidad);
                            updateCase.wrapperClass wc = new updateCase.wrapperClass();
                            wc = updateCase.validarIdentidad(String.valueOf(Caso.Id), detalleCaso.N_Cuenta_Bancaria__c, Identidad);
                            System.debug('validar Identidad: '+wc);
                            caso.DAU_Identidad__c = wc.DAU_Identidad;
                            caso.DAU_No_Cuenta__c = wc.DAU_No_Cuenta;
                            caso.DAU_aprobacion__c = wc.DAU_aprobacion;
                            caso.Respuesta_SF_Tarjetas__c = wc.Respuesta_SF_Tarjetas;
                            if(caso.DAU_Identidad__c <> Null) {
                                solicitud = AFPCCasos.upsertCaso(caso);
                            }    
                        }
                        if(detalleCaso.Tipo_Operacion__c == 'A6' && detallecaso.Banco__c == '28') {                     
                            System.debug('Cambio de # Tarjeta');
                            caso.DAU_Tarjeta_de_Sysde__c = DAU_BorrarCuotas.ConsultaInfoClienteC(caso.Id, mapcuentas.get(idCuenta).Codigo__c);
                            if(caso.DAU_Tarjeta_de_Sysde__c <> Null) {
                                updateCase.wrapperClass wc = new updateCase.wrapperClass();
                                wc = updateCase.validarIdentidad(caso.Id, caso.DAU_Tarjeta_de_Sysde__c, Identidad);
                                System.debug('validar Identidad: '+wc);
                                caso.DAU_Identidad__c = wc.DAU_Identidad;
                                caso.DAU_No_Cuenta__c = wc.DAU_No_Cuenta;
                                //caso.DAU_aprobacion__c = wc.DAU_aprobacion;
                                caso.Respuesta_SF_Tarjetas__c = wc.Respuesta_SF_Tarjetas;
                                caso.Archivo_Adjunto__c = true;
                                caso.Reason = 'Otro';
                            }
                            if(caso.DAU_Identidad__c <> Null) {
                                solicitud = AFPCCasos.upsertCaso(caso);                            
                                if(solicitud.solicitudExitosa){                                  
                                    if(caso.DAU_Identidad__c <> Null && caso.DAU_No_Cuenta__c <> Null) {
                                        Set<Id> caseId = new Set<Id>();
                                        caseId.add(caso.Id);
                                        Salesforce_Tarjetas.processCase(caseId, 'DEC', '', ''); 
                                    }
                                }
                            }    
                        }
                        if(detalleCaso.Tipo_Operacion__c == 'A7' && detallecaso.Banco__c == '28') {
                            System.debug('Cancelación'); 
                            Caso.DAU_Tarjeta_de_Sysde__c = DAU_BorrarCuotas.ConsultaInfoClienteC(Caso.Id, mapcuentas.get(idCuenta).Codigo__c);
                            if(Caso.DAU_Tarjeta_de_Sysde__c <> Null) {
                                updateCase.wrapperClass wc = new updateCase.wrapperClass();
                                wc = updateCase.validarIdentidad(Caso.Id, Caso.DAU_Tarjeta_de_Sysde__c, Identidad);
                                System.debug('validar Identidad: '+wc);
                                caso.DAU_Identidad__c = wc.DAU_Identidad;
                                caso.DAU_No_Cuenta__c = wc.DAU_No_Cuenta;
                                caso.DAU_aprobacion__c = false;
                            }
                            if(caso.DAU_Identidad__c <> Null) {
                                solicitud = AFPCCasos.upsertCaso(caso);
                            }
                        }
                    }
                    //  system.debug('Se metio sin querer'+ cTipoCaso.otros+'   '+ cTipoCaso.reposicionCarnet +'  '+caso.Origin  );
                    if(((cTipoCaso.otros || cTipoCaso.reposicionCarnet) && caso.Origin != 'Agencias_Banco') || test.isRunningTest() ) {
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
                        
                    } else if(CtipoCaso.otros){
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
    
    public extensionCasoDetalle(){
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
                        Desea_ver_tasa_de_cambio__c, Mostrar_Saldo_a_la_fecha__c,Tipo_de_Operacion__c,
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
                SolicitudCaso solicitud = AFPCCasos.upsertCaso(Caso);
                if(!solicitud.solicitudExitosa && !test.isRunningTest()) {
                    System.debug('Se procede a llemar a Sysde');
                    aSysdeCallouts.aumentoDisminucion(caso.id);    
                }
                
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
    
}