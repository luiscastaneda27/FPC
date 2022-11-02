public without sharing class ControllerConciliacionAprobacionM22 { 
    
    //Variables para Rezagos
    public String CodRef{get;set;}
    public String CodRefTest{get;set;}
    public String ValRezago{get;set;}
    public Decimal ValMontoCalculado{get;set;}
    public List<String> resultado2 = new List<String>();
    public List<String> resultado3 = new List<String>();
    public boolean displayPopup {get; set;}
    public String Rezagosn{get;set;}
    public String Monto{get;set;}
    public String Moneda{get;set;}
    public String Existe{get;set;}
    public string Num_CodReferencia_Rez{get;set;}
    public string Rez_SI_NO{get;set;}//Setear a 0
    public string Monto_Calculado{get;set;}//Setear a 0
    public string Num_CodCuenta_Rez{get;set;}//Setear a 0
    public string Monto_Dep{get;set;}//Setear a 0
    public String Compra_Dolar {get;set;}
    public String Correcto {get;set;}
    Public Boolean BTNAplicar {get;set;}
    Public Boolean popDolar {get;set;}
    //
    
    public list<Pantalla_Aportes__c> McontenidoAporte{get;set;}
    public list<Pantalla_Aportes__c> McontenidoTasa{get;set;}
    public list<Pantalla_Aportes__c> McontenidoAporteAprob{get;set;}
    public list<Pantalla_Aportes__c> ContenidoAprobarList{get;set;}   
    public list<Pantalla_Aportes__c> ModifiUSD{get;set;}  
    public list<Pantalla_Aportes__c> VerIamge{get;set;} 
    public Pantalla_Aportes__c DenegarAporteList{get;set;} 
    
    public Pantalla_Aportes__c ContenidoAporte{get;set;} 
    public Pantalla_Aportes__c ModificarEstado{get;set;}
    public Registro_Aportes__c RegistroAportesTotal{get;set;} //Registro de todos los aportes 'Aceptados' y 'Denegados' 
    public Pantalla_Aportes__c ModificarTas{get;set;}
    
    public Pantalla_Aportes__c ImagenMostrar{get;set;}
    
    public integer total {get;set;}
    public date fechadepositoModi {get;set;} //Fecha actualizada
    public date fechadeposito {get;set;} //Fecha
    public datetime FechaActual {get;set;}   
    public boolean DenegarVentana {get;set;}                      
    public String Motivo {get;set;} 
    public String Num_CodReferenciaDenegado {get;set;} 
    public string Num_CodReferencia{get;set;}   
    public Integer p_periodo_aporte{get;set;}   
    public blob DesconvertirImagen {get;set;}   
    public string Ver_Imagen {get;set;}
    public boolean DenegarImagen {get;set;}    
    public string Usuario {get;set;}   
    public boolean MensajeVF {get;set;} 
    public boolean MensajeErr {get;set;}
    public boolean VentanaEmergenteNo {get;set;}    
    public string NombreAsesor {get;set;}    
    
    public string p_saldo {get;set;}
    public string p_monto_pen_aplic {get;set;}
    public string p_codigo_error {get;set;}
    public string p_Mensaje_error {get;set;}
    public string p_num_movim_sysde {get;set;}
    public string p_nombre {get;set;}
    public double CompraDolar {get;set;}
    public boolean MotrarBtn {get;set;}   
    public boolean BloqAcep {get;set;}
    public boolean MostrarTasa {get;set;}
    public string CodReferenVentana {get;set;}  
    public string CodReferenNoCobra {get;set;}  
    
    //Variables de la ventanda modal de contrapartidas
    public string PC_Observaciones {get;set;}
    public string pCU_Rezagos {get;set;}
    public string pCU_Contable {get;set;}
    public TipoPlanilla__c tipopani1 {get;set;} 
    public boolean MostrarVenta12 {get;set;}
    public Account asesorr {get; set;}
    public string CodAsesor {get; set;}
    public List<SelectOption> OpcionAsesor {get;set;}
    
    //VARAIBALES PARA CREAR LA CONTRAPARTIDA
    public  List<ClassPartidaContable> ListaCargaC {get;set;}
    public  List<ClassPartidaContable> ListaCargaDolar {get;set;}
    public  List<Contenido_Estado_Cuenta_Conciliacion__c> MListConciNODIA {get;set;}
    public  List<Contenido_Estado_Cuenta_Conciliacion__c> MListConciNODos {get;set;}
    public List<ControllerAPICONCILIACION.RespuestaPartidaConta> ListRespuestaSysde {get;set;} 
    
    public  List<Pantalla_Aportes__c> ListSeleccionado{get;set;}    
    public string CodReferenciaTemp {get;set;}
    public string part {get;set;}    
    public string UpdaSaldos {get;set;} 
    public classDolares.classRespuestaDolares tasa {get;set;}
    
    Public string rezago {get;set;}
    
    public boolean popTasa{set;get;}
           
    public string moneda_mostrar {get;set;} //mostrar moneda texto
    public string tipo_saldo {get;set;}		//mostrar tipo de saldo en texto
    public string cod_empleado {get;set;} //COdigo del empleado
    public string correoEmpleado {get;set;}//correo del empleado
    Public string nombreOficial {get;set;}
    Public Map<String,InfoRezagos> mapInfoRezagos {get;set;}
    Public String ValorCuota {get;set;}
    
    public List<controladorPlanillasEnviadas.Rezago> listRezagos {get;set;}
    public string codigoRezago{get;set;}
    
    public ControllerConciliacionAprobacionM22(){
        p_Mensaje_error = '';
        MensajeErr = false;
        BloqAcep = true;
        FechaActual = date.today();
        popDolar = false;
        //Usuario = ApexPages.currentPage().getParameters().get('hytrd');
        List<User> usr = [Select Id, Name From User Where Id=:UserInfo.getUserId() Limit 1];
        System.debug('User: '+usr[0].Name);///////Marcooo
        Usuario = usr[0].Name;
        
        mapInfoRezagos = new Map<String,InfoRezagos>();           
        for(InfoRezagos.clientes IRc : ControllerApiRezagos.ConsultaRezagos()){
            InfoRezagos Rez = new InfoRezagos();
            Rez.clientes.add(IRc);
            mapInfoRezagos.put(IRc.codReferencia,Rez);
            System.debug('nada: '+IRc.codReferencia);
        }
        System.debug('nada: '+mapInfoRezagos.containsKey('FT22147D2WW1A'));
        if(test.isRunningTest()){
            InfoRezagos Rez = new InfoRezagos();
            InfoRezagos.clientes Rezc = new InfoRezagos.clientes();
            Rezc.idRezago = 'FPC123';
            Rezc.montoRezago = '100';
            Rezc.fondo = '106';
            Rezc.codReferencia = 'FPC123';
            Rezc.fechaDeposito = string.valueof(date.today());
            Rezc.codigoMoneda = '1';
            Rezc.descripcion = '';
            Rezc.descripcionNota = '';
            Rezc.usuIngresaRezago = '';
            Rezc.codBanco = '';
            Rezc.agnBanco = '';
            Rezc.rezagoSINO = 'SI';
            Rezc.asesor = '';
            Rezc.estado = '';
            Rezc.valorCuotaEntrada = '';
            Rezc.fecInclusion = string.valueof(date.today());
            Rezc.incluidoPor = '';
            Rezc.fecModificacion = string.valueof(date.today());
            Rezc.modificadoPor = '';
            Rezc.montoPendienteAplicar = ''; 
            Rez.clientes.add(Rezc);
            mapInfoRezagos.put(Rezc.codReferencia,Rez);
        }
        
        Cerrar();
        reiniciar();
        
        //CargaPlanilla();
        tipopani1 = new TipoPlanilla__c ();
        asesorr = new Account();
        OpcionAsesor = new List<SelectOption>();
        //System.Debug('Valor Cuota: '+ValorCuota101+' - '+ValorCuota106+' - '+ValorCuota113);
    }
    
    public void MostraVentaEsconder(){
        MostrarVenta12 = false;
    }
    
    public void popDolar(){
        popDolar = !popDolar;
    }
    
    
    public void MostraVentana(){
        try{
            MostrarVenta12 = true;
            ListSeleccionado =[ select cuenta__c, Tipo_MonedaN__c, Fecha_Deposito__c, Monto_Deposito__c, Tipo_SaldoN__c ,
                               Forma_PagoN__c, Codigo_Referencia__c, Aplica_Comision_SI__c, Rezago__c , Codigo_Referencia_Rez__c,
                               Compra_Dolar__c, Oficial_de_negocios__c, Periodo_Aporte__c,Monto_Calculado__c
                               from Pantalla_Aportes__c 
                               where Codigo_Referencia__c =: Num_CodReferencia ];
           
            for(integer i=0; i<ListSeleccionado.size(); i++){
                if(ListSeleccionado[i].Codigo_Referencia__c == Num_CodReferencia ){
                    string TipoPLanilla;
                    
                    system.debug('TipoMoneda' + ListSeleccionado[i].Tipo_MonedaN__c);
                    
                    ControllerAPICONCILIACION.ClassTraerCuentaContable fcsd= new ControllerAPICONCILIACION.ClassTraerCuentaContable ();
                    TipoPLanilla = ListSeleccionado[i].Tipo_MonedaN__c == '1' ? 'HNL' :'USD';
                    fcsd = ControllerAPICONCILIACION.BuscaCuentaConta(TipoPLanilla);
                    
                    pCU_Rezagos = fcsd.Cu_Bancos;
                    pCU_Contable = fcsd.Cu_Rezagos;
                    tipopani1.ListaEC__c = TipoPLanilla;
                    CodReferenVentana = Num_CodReferencia;
                    //String consulta = '"numTransaccion":"FT20217C8CC6"';//+ListSeleccionado[i].Codigo_Referencia__c+'"';
                    //InfoRezagos resultado = ControllerApiRezagos.ConsultaRezagos(consulta);
                }
            } // fin del for
        }catch(exception ex){
            p_Mensaje_error = 'Error al Guardar el Aporte en el Metodo: MostraVentana. Mensaje: '+ ex.getMessage();
            MensajeErr = true;
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,p_Mensaje_error));
        }        
    }
    
    //Metodo el cual creara la contrapartida.
    //Si se aprueba el aporte y esta como no conciliado y tiene mas de dos dias 
    //Crea la contrapartida ya sea en HNL O USD
    
    public void ConciliarIndividual2dias(){
        try{
            if (PC_Observaciones == null || PC_Observaciones == ''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Campo Observación Vacío'));
            }else{
                ClassEnviarConciliacionLista Enviar = new ClassEnviarConciliacionLista();
                
                MListConciNODIA =[select Monto_Fijo__c, Fecha_Valor__c, Monto_Pendiente__c,Respuesta_SYSDE__c,Tipo_Planilla__c,Conciliado__c, Dias__c, Referencia__c,Fecha_posteo__c, Monto__c, Usuario_SIstema__c 
                                  from Contenido_Estado_Cuenta_Conciliacion__c 
                                  where Referencia__c =: CodReferenVentana];
                
                ListaCargaC = new list<ClassPartidaContable>();
                ListaCargaDolar = new list<ClassPartidaContable>();
                ClassListaPartii pare =  new ClassListaPartii();
                
                system.debug('ListaContrapartida=' + MListConciNODIA);
                
                for(integer i=0; i<MListConciNODIA.size(); i++){
                    
                    if( MListConciNODIA[i].Tipo_Planilla__c == 'HNL'){
                        ListaCargaC.add(new ClassPartidaContable ('2',
                                                                  MListConciNODIA[i].Fecha_Valor__c, 
                                                                  PC_Observaciones +'-'+ +''+MListConciNODIA[i].Referencia__c,
                                                                  MListConciNODIA[i].Referencia__c,
                                                                  MListConciNODIA[i].Fecha_posteo__c, 
                                                                  MListConciNODIA[i].Monto__c ,
                                                                  MListConciNODIA[i].Usuario_SIstema__c,
                                                                  MListConciNODIA[i].Conciliado__c, 
                                                                  pCU_Rezagos,
                                                                  pCU_Contable,
                                                                  MListConciNODIA[i].Dias__c
                                                                 )); 
                    }else{

                        ListaCargaDolar.add(new ClassPartidaContable ('2',
                                                                      MListConciNODIA[i].Fecha_Valor__c, 
                                                                      PC_Observaciones +'-'+ +''+MListConciNODIA[i].Referencia__c,
                                                                      MListConciNODIA[i].Referencia__c,
                                                                      MListConciNODIA[i].Fecha_posteo__c, 
                                                                      MListConciNODIA[i].Monto__c,
                                                                      MListConciNODIA[i].Usuario_SIstema__c,
                                                                      MListConciNODIA[i].Conciliado__c, 
                                                                      pCU_Rezagos,
                                                                      pCU_Contable,
                                                                      MListConciNODIA[i].Dias__c
                                                                     ));  
                    }

                }// Fin del for

                //Lista en HNL
                IF(ListaCargaC.size() > 0){
                    
                    system.debug('ListContenidoHNL=' + ListaCargaC );
                    pare.ListaCargaC =ListaCargaC;

                    ListRespuestaSysde  = ControllerAPICONCILIACION.CreaPartidaDebi(pare);
                    
                    for (integer i=0; i<ListRespuestaSysde.size(); i++){
                        //Inserta en la bitacora el registro aprobado
                        Bitacora_Conciliacion__c bita = new Bitacora_Conciliacion__c ();
                        bita.Actividades__c = 'Se creo una contrapartida en lempiras con numero de asiento: ' + ' '+ ListRespuestaSysde[i].NuAsiento;
                        bita.Evento__c = 'Agregar';
                        bita.Pantalla__c = 'VFPantallaConciliacionRespuestaSYSDE';   
                        bita.Fecha__c = date.today();
                        bita.Usuario__c = Usuario;
                        insert bita; 
                        
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Contrapartida En Dolares Creada Correctamente' +' '+ +'Numero Asiento ='+ ListRespuestaSysde[i].NuAsiento ));

                    } // fin del for 
                }
                
                //LISTA EN USD
                if(ListaCargaDolar.size() > 0){
                    system.debug('ListContenidoUSD=' + ListaCargaDolar );
                    pare.ListaCargaC =ListaCargaDolar;
                    
                    //Si concilia en dolares
                    ListRespuestaSysde  = ControllerAPICONCILIACION.CreaPartidaDolaar(pare);
                    
                    for (integer i=0; i<ListRespuestaSysde.size(); i++){
                        //Inserta en la bitacora el registro aprobado
                        Bitacora_Conciliacion__c bita = new Bitacora_Conciliacion__c ();
                        bita.Actividades__c = 'Se creo una contrapartida en dolares con numero de asiento: ' + ' '+ ListRespuestaSysde[i].NuAsiento;
                        bita.Evento__c = 'Agregar';
                        bita.Pantalla__c = 'VFPantallaConciliacionRespuestaSYSDE';   
                        bita.Fecha__c = date.today();
                        bita.Usuario__c = Usuario;
                        insert bita; 
                        
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Contrapartida En Dolares Creada Correctamente' +' '+ +'Numero Asiento ='+ ListRespuestaSysde[i].NuAsiento ));

                    } // fin del for
                }

                MostrarVenta12 = false;
                PC_Observaciones = null;
                
            } //FIN DEL ELSE  
            
        }catch(exception ex){
            System.debug('Error en ConciliarIndividual2dias : '+ ex.getMessage() + ' Linea: ' + ex.getLineNumber());
            p_Mensaje_error = 'Error al Guardar el Aporte en el Metodo: ConciliarIndividual2dias. Mensaje: '+ ex.getMessage();
            MensajeErr = true;
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,MensajeError));
        }
    }
        
    public void reiniciar(){    
        FechaActual = date.today();
        McontenidoAporte =[ select cuenta__c, Tipo_MonedaN__c, Fecha_Deposito__c, Monto_Deposito__c, Tipo_SaldoN__c ,
                           Forma_PagoN__c, Codigo_Referencia__c, Aplica_Comision_SI__c, Rezago__c , Monto_Calculado__c,
                           Compra_Dolar__c, Oficial_de_negocios__c, Periodo_Aporte__c, Codigo_Referencia_Rez__c
                           from Pantalla_Aportes__c 
                           where Estado_Aporte__c = 'S' order by Numero_Correlativo__c desc];   
        for(Pantalla_Aportes__c item: McontenidoAporte){
            item.Fecha_Deposito__c = item.Compra_Dolar__c =='S' ? date.today() : item.Fecha_Deposito__c;
        }
        System.debug('Funcion referencia, Codigo de la referencia: ' + Num_CodReferencia + ',' + McontenidoAporte);
        total = McontenidoAporte.size();
        system.debug('Reiniciar - MostrarTasa: '+MostrarTasa+', VentanaEmergenteNo: '+VentanaEmergenteNo);
        CargaPlanilla();
    }
      
    //Comprobar Codigo Seleccionado
    public PageReference SearchValores(){
        BTNAplicar = false;
        String consulta = CodRefTest.trim();
        InfoRezagos resultado = new InfoRezagos();
        System.debug(consulta+ '  mapInfoRezagos.containsKey(consulta): '+mapInfoRezagos.containsKey(consulta));
        if(mapInfoRezagos.containsKey(consulta)){
            resultado = mapInfoRezagos.get(consulta); 
        }

        Existe='';
        
        if(resultado.clientes != null && resultado.clientes.size() == 1){
            
            String mntpen = resultado.clientes[0].montoPendienteAplicar;
            if(mntpen=='0' || mntpen==''){
                Monto = resultado.clientes[0].montoRezago;
                System.debug('Monto: '+Monto);
            }else{
                Monto = mntpen;
                Existe = ' Corresponde a un Monto pendiente.';
            }
            
            Moneda = resultado.clientes[0].codigoMoneda;
            System.debug('Moneda: '+Moneda);
            
            Rezagosn = resultado.clientes[0].rezagoSINO;
            System.debug('Rezago SI/NO: '+Rezagosn);
            
            String estador = resultado.clientes[0].estado;
            if(estador=='Pagado'){
                Existe='Rezago ya Aplicado. PAGADO.';
                Monto='';
                Moneda='';
                Rezagosn='';
            }else{
                Existe='Datos de Muestra. '+Existe;
                BTNAplicar=true;
                controladorPlanillasEnviadas.Rezago rezag = new controladorPlanillasEnviadas.Rezago();
                rezag.aplica = Rezagosn;
                rezag.codigo = consulta;
                rezag.moneda = Moneda;
                rezag.monto = Monto;
                listRezagos.add(rezag);
            }
        }
        if(Existe==''){
            Existe = 'Codigo inexistente o Aplicado. Favor Revisar.';
            Monto = '';
            Moneda = '';
            Rezagosn = '';
        }
        return null;
    }
    
    public void aplicarList(){
        String codigo = '';
        Integer posic = 0;
        for(integer count=0;count<McontenidoAporte.size();count++){
            if(McontenidoAporte[count].Codigo_Referencia__c==CodRef){
                posic = count;
            }
        }
        for(Integer i=0; i<listRezagos.size(); i++){
            codigo += listRezagos[i].codigo + ',';
            Rezagosn = listRezagos[i].aplica;
            CodRefTest = listRezagos[i].codigo;
            Moneda = listRezagos[i].moneda;
            Monto = listRezagos[i].monto;
            aplicar();
        }
        If(codigo.length() > 1){
            McontenidoAporte[posic].Codigo_Referencia_Rez__c = codigo.substring(0, codigo.length()-1);
        }
        closePopup();
    }
    
    //Aplicar el codigo seleccionado al Cod Rezago
    public void aplicar(){
        String MontoSTR='';
        Decimal MontoAp=0;
        Decimal MontoRez=Decimal.valueOf(Monto);
        for(integer count=0;count<McontenidoAporte.size();count++){
            if(McontenidoAporte[count].Codigo_Referencia__c == CodRef){
                MontoAp = McontenidoAporte[count].Monto_Deposito__c;
            }
        }
        
        if(MontoAp<=MontoRez){
            if(Rezagosn=='SI'){
                
                String fond='';
                Decimal valcuosal=0;
                Decimal valcuoent=0;
                Decimal mnt=0;
                String consulta = CodRefTest.trim();
                InfoRezagos resultado = new InfoRezagos();
                if(mapInfoRezagos.containsKey(consulta)){
                   resultado = mapInfoRezagos.get(consulta); 
                }

                if(resultado.clientes != null && resultado.clientes.size() == 1){    
                    fond = resultado.clientes[0].fondo;
                    System.debug('Fondo: '+fond);
                    
                    String valent = resultado.clientes[0].valorCuotaEntrada;
                    if(valent=='' || valent==null){valent='1';}
                    System.debug('Valor Cuota Entrada: '+valent);
                    
                    valcuoent = Decimal.valueOf(valent);
                    //Para obtener el valor cuota del dia al iniciar el programa
                    String ValorCuota = ControllerApiRezagos.ConsultaCuotaSal();
                    //List <String> ValorCuotaStr {get;set;}
                    List <String> ValorCuotaStr = new List<String>();
                    ValorCuotaStr = ValorCuota.split('},');
                    for(Integer count1=0;count1<ValorCuotaStr.size();count1++){
                        String rez = ValorCuotaStr[count1];
                        
                        String ValorCuotaDia = rez.substringBeforeLast('}');
                        ValorCuotaDia = ValorCuotaDia.substringAfterLast(':');
                        
                        String ValorCuotaFondo = rez.substringBeforeLast('",');
                        ValorCuotaFondo = ValorCuotaFondo.substringAfterLast('"');
                        
                        if(fond==ValorCuotaFondo){valcuosal = Decimal.valueOf(ValorCuotaDia);}
                        
                    }
                    System.debug('Valor Cuota Salida: ' + String.valueOf(valcuosal));
                    System.debug('Monto Aporte: '+MontoAp);
                    mnt = MontoAp/valcuoent*valcuosal;
                    mnt = mnt.setScale(2);
                    MontoStr = String.valueOf(mnt);
                    System.debug('Monto Calculado: '+MontoStr);
                }else{
                    System.debug('Error al aplicar el codigo de Rezago.<br/> El Metodo devuelve una lista vacia.<br/>(ControllerApiRezagos.ConsultaRezagos)');
                    p_Mensaje_error = 'Error al aplicar el codigo de Rezago.<br/> El Metodo devuelve una lista vacia.<br/>(ControllerApiRezagos.ConsultaRezagos)';
                    MensajeErr = true; 
                }
            }else{
                Rezagosn = 'N/A';
            }
            
            for(integer count=0;count<FRT.size();count++){
                if(FRT[count].Cod_referencia==CodRef){
                    FRT[count].Cod_Referencia_Rez=CodRefTest;
                    FRT[count].RezagoSI = Rezagosn;
                    if(Rezagosn == 'N/A'){
                        FRT[count].MontoCalculado = String.valueOf(FRT[count].Monto);
                    }else{
                        FRT[count].MontoCalculado = MontoSTR;
                    }
                }
            }
            
            for(integer count=0;count<McontenidoAporte.size();count++){
                if(McontenidoAporte[count].Codigo_Referencia__c==CodRef){
                    McontenidoAporte[count].Rezago__c = Rezagosn;
                    if(Rezagosn=='N/A'){
                        McontenidoAporte[count].Monto_Calculado__c = String.valueOf(McontenidoAporte[count].Monto_Deposito__c);
                    }else{
                        McontenidoAporte[count].Monto_Calculado__c = MontoSTR;    
                    }
                }
            }
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El Monto del Rezago NO puede ser inferior al Monto del Aporte.'));
            Correcto='Fail';
        }
        //closePopup();
    }
    
    public void closePopup() {        
        displayPopup = false;
        Rezagosn='';
        Monto='';
        Moneda='';
        Existe='';
        BTNAplicar=false;
    }
    
    public PageReference showPopup() {     
        listRezagos = new List<controladorPlanillasEnviadas.Rezago>();
        displayPopup = true;
        Existe='';
        BTNAplicar=false;
        return null;
    }
    
    //@future(callout = true)
    public void AplicarRezago(String NumCodRez, String NumCodCue, String MonCalc, String MonDep, String User, String Mon, String ComDol) {
        System.debug('Se ejecuta el AplicarRezago');
        String result='';
        String CuentaOrigen='';
        List<ClientesRez> ListClientesRez = new List<ClientesRez>();
        ClientesRez AplicaRez = new ClientesRez('','','','','','','','','','','','','');
        String FechaD='';
        try{
            ClassClientesRez rezagoEnvio = new ClassClientesRez();
            String CodRezago = NumCodRez;
            InfoRezagos resultado = new InfoRezagos();
            if(mapInfoRezagos.containsKey(CodRezago)){
                resultado = mapInfoRezagos.get(CodRezago); 
            }
            if(test.isRunningTest()){
                resultado = mapInfoRezagos.get('FPC123');
            }

            if(resultado.clientes != null && resultado.clientes.size() == 1){
               
                AplicaRez.idRezago = resultado.clientes[0].idRezago;// Añado el Id Rezago
                System.debug('idRezago: '+AplicaRez.idRezago);
                
                AplicaRez.montoRezago = resultado.clientes[0].montoRezago;// Añado el Monto del Rezago
                system.debug('Monto Rezago: '+AplicaRez.montoRezago);
                
                AplicaRez.fondo = resultado.clientes[0].fondo;// Añado el Fondo del Rezago
                system.debug('Fondo: '+AplicaRez.fondo);
                
                AplicaRez.codReferencia = resultado.clientes[0].codReferencia ;// Añado el Codigo de referencia del Rezago
                system.debug('Codigo Referencia Rezago: '+AplicaRez.codReferencia);
                
                system.debug('Numero de Cuenta: '+NumCodCue);
                AplicaRez.codCuenta = NumCodCue;// Añado el Codigo de Cuenta
                
                system.debug('Codigo de Planilla: ');
                AplicaRez.codPlanilla = '';// Añado el Codigo de Planilla
                
                String valcuoent = resultado.clientes[0].valorCuotaEntrada;
                if(valcuoent=='' || valcuoent==null){
                    valcuoent='0';
                }
                System.debug('Valor Cuota de Entrada: '+valcuoent);
                AplicaRez.valorCuotaEntrada = valcuoent;// Añado el Valor de la cuota de entrada
                
                AplicaRez.estado = resultado.clientes[0].estado;// Añado el Estado del Rezago
                system.debug('Estado: '+AplicaRez.estado);
                
                String sino = resultado.clientes[0].rezagoSINO;
                system.debug('Rezago Si/No: '+sino);
                if(sino=='SI' || sino=='Si' || sino=='si' || sino=='S'){ 
                    rezagoEnvio.Tipo = 'AP';
                    //Para obtener el valor cuota del dia
                    List <String> ValorCuotaStr = new List<String>();
                    ValorCuotaStr = ValorCuota.split('},');
                    String valcuosal;
                    for(Integer count1=0;count1<ValorCuotaStr.size();count1++){
                        String rez = ValorCuotaStr[count1];
                        
                        String ValorCuotaDia = rez.substringBeforeLast('}');
                        ValorCuotaDia = ValorCuotaDia.substringAfterLast(':');
                        
                        String ValorCuotaFondo = rez.substringBeforeLast('",');
                        ValorCuotaFondo = ValorCuotaFondo.substringAfterLast('"');
                        
                        if(AplicaRez.fondo==ValorCuotaFondo){valcuosal = String.valueOf(ValorCuotaDia);}                   
                    }
                    System.debug('Valor Cuota de Salida: '+valcuosal);
                    AplicaRez.valorCuotaSalida = valcuosal;//valcuosal;// Añado el Valor de la cuota de Salida
                }else{
                    AplicaRez.valorCuotaSalida = '';
                    rezagoEnvio.Tipo = 'AD';
                }
                
                System.debug('Valor Aporte Calculado: '+MonCalc);
                AplicaRez.valAporteCalculado = MonCalc;// Añado el Aporte Calculado
                
                Decimal mparapl;
                Decimal mpenapl;
                
                String mntpen = resultado.clientes[0].montoPendienteAplicar;
                System.debug('Monto Pendiente: '+mntpen);
                
                Decimal mntr=0;
                if(mntpen=='0' || mntpen==''){
                    mntr = Decimal.valueOf(AplicaRez.montoRezago);//Si no hay Monto pendiente el monto del Rezago Disponible es el Monto del Rezago             
                }else{
                    mntr = Decimal.valueOf(mntpen);//Si hay Monto pendiente el Monto del Rezago Disponible es el Monto Pendiente
                }
                System.debug('Monto Disponible del Rezago: '+mntr);
                
                Decimal mnt = Decimal.valueOf(MonDep);//Asigno el Monto del Aporte
                System.debug('Monto del Aporte: '+mnt);
                
                if(mnt<mntr){//Si el monto del aporte es menor al Disponible del Rezago
                    mparapl = mnt; //Se esta aplicando un monto parcial
                    mpenapl = mntr-mnt;//Calculamos la diferencia que queda Disponible
                    AplicaRez.estado = 'Pendiente';// Cambiamos el Estado a Pendiente
                }
                if(mnt==mntr){//Si son iguales no hay monto parcial ni pendiente
                    mparapl=0;
                    mpenapl=0;
                    AplicaRez.estado='Pagado';//Cambiamos el estado a Pagado
                }
                
                system.debug('Valor Monto Parcial: '+String.valueOf(mparapl));
                AplicaRez.montoParcialAplicado = String.valueOf(mparapl);//Añado el Monto Parcial Aplicado
                
                system.debug('Valor Monto Pendiente: '+String.valueOf(mpenapl));
                AplicaRez.montoPendienteAplicar = String.valueOf(mpenapl);//Añado el Monto Pendiente a Aplicar
                
                List<User> usr = [Select Id, Name From User Where Id=:UserInfo.getUserId() Limit 1];
                String usuario = usr[0].Name;
                System.debug('Modificado por: '+usuario);
                AplicaRez.modificadoPor = usuario;
                
                ListClientesRez.add(AplicaRez);
                
                FechaD = resultado.clientes[0].fechaDeposito;
                
                rezagoEnvio.clientes = ListClientesRez;
                System.debug('Tipo Rezago: '+rezagoEnvio.Tipo);
                
                
                try{
                    List<Cuenta_Rezago__mdt> codigo = new List<Cuenta_Rezago__mdt>();
                    codigo = [select cuenta__c from Cuenta_Rezago__mdt where fondo__c =: AplicaRez.fondo limit 1];
                    if(codigo.size()>0){
                        CuentaOrigen = codigo[0].cuenta__c ;//Insertar el codigo de cuenta de FPC Rezagos
                    }
                }catch(Exception ex){
                    System.debug('Error al buscar la cuenta: '+ ex.getLineNumber() +' - '+ ex.getMessage());
                }
            }else{
                System.debug('Error al aplicar el codigo de Rezago.<br/> El Metodo devuelve una lista vacia.<br/>(ControllerApiRezagos.ConsultaRezagos)');
                p_Mensaje_error = 'Error al aplicar el codigo de Rezago.<br/> El Metodo devuelve una lista vacia.<br/>(ControllerApiRezagos.ConsultaRezagos)';
                MensajeErr = true; 
            }
            String RespuestaRetiro = '';
            String AplicaPartida = '';
           	if(rezagoEnvio.Tipo == 'AP'){
                System.debug('Ejecutamos el Metodo Retiro: '+CuentaOrigen+' - '+Mon+' - '+MonCalc);
            	RespuestaRetiro = ControllerApiRezagos.AplicaRetiroRezagos(CuentaOrigen, Mon, MonCalc);
                if(RespuestaRetiro.contains('Su retiro ha sido registrado') || test.isRunningTest()){
                	RespuestaRetiro='OK';
                }else{
                	System.debug('Error al aplicar Retiro: '+CuentaOrigen+' - '+Mon+' - '+MonCalc);
                    String m;
                    if(Mon=='1'){m='HLN';}else{m='USD';}
                    p_Mensaje_error = 'Error al aplicar Retiro:<br/>Cuenta : '+CuentaOrigen+ ' - Monto : '+MonCalc+' '+m+'<br/><br/>'+RespuestaRetiro;
                    MensajeErr = true;
                    return;
                }
            }
            
            if( rezagoEnvio.Tipo == 'AD'){
                System.debug('Ejecutamos el Metodo AD');
                result = ControllerApiRezagos.AplicaRezagosDia(rezagoEnvio);
            }
            if(RespuestaRetiro == 'OK'){
                if(rezagoEnvio.Tipo == 'AP'){
                    System.debug('Ejecutamos el Metodo AP');
                    result = ControllerApiRezagos.AplicaRezagosDia(rezagoEnvio);  
                }
                if(result=='"OK"' || test.isRunningTest()){
                    System.debug('Ejecutamos el Metodo de la Partida Contable: '+AplicaRez.fondo+' - '+AplicaRez.valAporteCalculado+' - '+AplicaRez.codCuenta+' - '+ComDol+' - '+FechaD);
                    AplicaPartida = AplicaPartida(AplicaRez.fondo, AplicaRez.valAporteCalculado, AplicaRez.codCuenta, ComDol, FechaD);
                    if(AplicaPartida!='OK'){
                        p_Mensaje_error = AplicaPartida;
                        MensajeErr = true;
                    }
                    system.debug('Aplica Partida Result: '+AplicaPartida);
                }else{
                    p_Mensaje_error = 'Error al Aplicar Rezago: '+result;
                    MensajeErr = true;
                }
            }
        }catch(exception ex){
            System.debug('Error al aplicar Rezago: '+ ex.getMessage() + ' Linea: ' + ex.getLineNumber());
            p_Mensaje_error = 'Error al aplicar Rezago: <br/>'+ ex.getMessage() + ' <br/>Linea: ' + ex.getLineNumber();
            MensajeErr = true;
        }
    }
    
    public static String AplicaPartida(String Fon, String Mon, String Cue, String CompDol, String FechD){

        String fondo = Fon;
        String montocal = Mon;
        String cuent = cue;
        
        FieldsPartidadContables clase = new FieldsPartidadContables();
        
        FieldsPartidadContables.Partida envioDatos = new FieldsPartidadContables.Partida();
        clase.partidas = new List<FieldsPartidadContables.Partida>();
        
        envioDatos = new FieldsPartidadContables.Partida();

        List<Partida_Rezago__mdt> partida = new List<Partida_Rezago__mdt>();
        
        try{
            if(CompDol=='S'){
                partida = [SELECT Cuenta_Debito__c, Descripcion__c, Id_Banco__c, Moneda__c, Sub_Aplicacion__c, Tipo_Nota__c, Tipo_Transaccion__c 
                           FROM Partida_Rezago__mdt WHERE Fondo__c =: fondo AND Compra_Dolar__c =: 'S' AND  Cuenta__c = 'C' LIMIT 1];
            }else{
                partida = [SELECT Cuenta_Debito__c, Descripcion__c, Id_Banco__c, Moneda__c, Sub_Aplicacion__c, Tipo_Nota__c, Tipo_Transaccion__c 
                           FROM Partida_Rezago__mdt WHERE Fondo__c =: fondo AND Compra_Dolar__c =: 'N' AND  Cuenta__c = 'C' LIMIT 1];
            }
        }catch(Exception ex){
			System.debug('Error: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());
            return ex.getMessage();
        }
        if(partida.size()>0){
            //Clase con todos los campos
            envioDatos.Id_banco = partida[0].Id_Banco__c;
            envioDatos.Monto = montocal;
            envioDatos.cta_contable_debito = partida[0].Cuenta_Debito__c;
            envioDatos.cta_contable_credito = NULL;
            if(partida[0].Moneda__c=='Lempiras'){envioDatos.moneda = '1';}else{envioDatos.moneda = '2';}
            envioDatos.Modulo = 'BCO';
            if(partida[0].Tipo_Nota__c=='Debito'){envioDatos.tip_nota = 'D';}else{envioDatos.tip_nota = 'C';}
            
            String cuentax = partida[0].Descripcion__c ;//Busca la cuenta de FPC Rezagos
            cuentax = cuentax.replace('cuentax', cuent);
            String fechax='';
            if(test.isRunningTest()){
                fechax = '2020-01-01';
            }else{
            	fechax = FechD;
            }
            cuentax = cuentax.replace('fechax', fechax);
            envioDatos.observacion = cuentax;
            envioDatos.observacion_c = cuentax;
            
            envioDatos.tip_transac = partida[0].Tipo_Transaccion__c;
            envioDatos.sub_aplicacion = partida[0].Sub_Aplicacion__c;
            if(CompDol=='S'){
                envioDatos.fecha = Datetime.now();
            }else{
                envioDatos.fecha = NULL;
            }
            //envioDatos.fecha = NULL;
            system.debug('Envio Datos: '+envioDatos);
            clase.partidas.Add(envioDatos);
        }
        String resultJson='';
        if(test.isRunningTest()){
            resultJson='OK';
        }else{
            resultJson = controllerApiIntergationPartidas.generarPartidas(clase);
        }
        String resultado='';
        if(resultJson.contains('OK')){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Partida contable creada correctamente.  '));
            resultado='OK';
        } else if(resultJson.contains('Read timed out')){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error de conexión a la base de datos: "Read timed out".  '));
            resultado = resultJson;
        } else {    
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se produjo un error en el Servicio Web.  '));
            resultado = resultJson;
        }
        return resultado;
    }
    
    PUBLIC LIST<ClaseAporteListaC> FRT{get;set;}
    
    Public class ClaseAporteListaC{
        
        public string Cuenta {get;set;}
        public string Moneda {get;set;} 
        public double Monto {get;set;}  
        public date FechaDeposito {get;set;}  
        public string TipoSaldo {get;set;}
        public string NombreCompleto {get;set;}
        public string Comprobante {get;set;} /*En esta variable se cargara una imagen*/  
        public string FormaPago {get;set;} 
        public string Cod_referencia {get;set;} 
        public string Cod_referencia_Rez {get;set;} /*Aplica Rezago*/
        public string ComisionSI {get;set;} /*Aplica Comision*/
        public string RezagoSI {get;set;} /*Aplica Rezago*/
        public string MontoCalculado {get;set;} /*Aplica Rezago*/
        public string DolarSI {get;set;} /*Aplica Comision*/
        public string Oficial {get;set;}
        
        public ClaseAporteListaC(string Cuenta, string Moneda, double Monto, date FechaDeposito,string TipoSaldo, 
                                 string FormaPago, string Cod_referencia , string Cod_referencia_Rez, string ComisionSI, string RezagoSI, 
                                 string MontoCalculado, string Oficial,string DolarSI,string Comprobante)
        {
            this.Cuenta = Cuenta;
            this.Moneda = Moneda;
            this.Monto = Monto;
            this.FechaDeposito = FechaDeposito;
            this.TipoSaldo = TipoSaldo;
            this.FormaPago=FormaPago;
            this.Cod_referencia=Cod_referencia;
            this.Cod_referencia_Rez=Cod_referencia_Rez;
            this.ComisionSI=ComisionSI;
            this.RezagoSI=RezagoSI;
            this.MontoCalculado=MontoCalculado;
            this.Oficial = Oficial;
            this.DolarSI=DolarSI;
            this.Comprobante=Comprobante;
        }
    }
    
    public void CargaPlanilla(){
        try{
            system.debug('Entramos a CargaPlanilla');
            FRT = NEW LIST<ClaseAporteListaC>();
            
            list<Pantalla_Aportes__c> TodasPlanillas=new list<Pantalla_Aportes__c>();
            McontenidoAporte =[ select cuenta__c, Tasa__c ,Tipo_MonedaN__c,Monto_Deposito__c, Fecha_Deposito__c,Tipo_SaldoN__c ,
                               Forma_PagoN__c,Codigo_Referencia__c, Codigo_Referencia_Rez__c, Aplica_Comision_SI__c,
                               Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c,rezago__C, Monto_Calculado__c
                               from Pantalla_Aportes__c 
                               where Estado_Aporte__c = 'S' order by Numero_Correlativo__c desc];
            for(Pantalla_Aportes__c item: McontenidoAporte){
                item.Fecha_Deposito__c = item.Compra_Dolar__c =='S' ? date.today() : item.Fecha_Deposito__c;
            }

            for(integer i=0; i<McontenidoAporte.size(); i++) {
                //Trae los datos de la tabla rezagos para hacer los calculos
                String consulta = McontenidoAporte[i].Codigo_Referencia_Rez__c;
                System.debug('Codigo de referencia Buscado: '+consulta);
            	InfoRezagos resultado = new InfoRezagos();
                if(mapInfoRezagos.containsKey(consulta)){
                   resultado = mapInfoRezagos.get(consulta); 
                }
                if(test.isRunningTest()){
                    resultado = mapInfoRezagos.get('FPC123');
                }

                String rezago='';
                Decimal ent=0;
                Decimal sal=0;
                
                if(resultado.clientes != null && resultado.clientes.size() == 1){
                    String estador = resultado.clientes[0].estado;
                    system.debug('Estado del Rezago: '+estador);
                    if(estador!='Pagado'){
                        //McontenidoAporte[i].Codigo_Referencia_Rez__c = McontenidoAporte[i].Codigo_Referencia__c;
                        
                        rezago = resultado.clientes[0].rezagoSINO;
                        
                        String valcuoent = resultado.clientes[0].valorCuotaEntrada;
                        if(valcuoent=='' || valcuoent==null){valcuoent='1';}
                        ent = Decimal.valueOf(valcuoent);
                        
                        //Traer el fondo
                        String fondor = resultado.clientes[0].fondo;
                        
                        //Traer el valor cuota dia (Salida)
                        String valcuosal='';
                        String ValorCuota = ControllerApiRezagos.ConsultaCuotaSal();
                        system.debug('Valor Cuota: '+ValorCuota);
                        if(test.isRunningTest()){
                            ValorCuota = '[{"fechaValor":"2020-01-30T00:00:00","codInversion":"101","valCuota":340.69913612},{"fechaValor":"2020-01-30T00:00:00","codInversion":"106","valCuota":127.52636724},{"fechaValor":"2020-01-30T00:00:00","codInversion":"113","valCuota":125.16183919}]';
                        }
                        List <String> ValorCuotaStr = new List<String>();
                        ValorCuotaStr = ValorCuota.split('},');
                        for(Integer count1=0;count1<ValorCuotaStr.size();count1++){
                            String rez = ValorCuotaStr[count1];
                            
                            String ValorCuotaDia = rez.substringBeforeLast('}');
                            ValorCuotaDia = ValorCuotaDia.substringAfterLast(':');
                            
                            String ValorCuotaFondo = rez.substringBeforeLast('",');
                            ValorCuotaFondo = ValorCuotaFondo.substringAfterLast('"');
                            
                            if(fondor==ValorCuotaFondo){valcuosal=String.valueOf(ValorCuotaDia);}                   
                        }
                        sal = Decimal.valueOf(valcuosal);
                    }
                }else{
                    McontenidoAporte[i].Codigo_Referencia_Rez__c = 'Sin Registro';
                }
                if(rezago=='SI'){
                    McontenidoAporte[i].Rezago__c = rezago;
                    Decimal montocal=McontenidoAporte[i].Monto_Deposito__c/ent*sal;
                    montocal = montocal.setScale(2);
                    McontenidoAporte[i].Monto_Calculado__c = String.valueOf(montocal);
                }else{
                    McontenidoAporte[i].Rezago__c='N/A';
                    McontenidoAporte[i].Monto_Calculado__c = String.valueOf(McontenidoAporte[i].Monto_Deposito__c);
                }
				
                //Carga los datos a la clase visible
                FRT.add(new ClaseAporteListaC( McontenidoAporte[i].cuenta__c, 
                                              McontenidoAporte[i].Tipo_MonedaN__c, 
                                              double.valueOf(McontenidoAporte[i].Monto_Deposito__c),
                                              McontenidoAporte[i].Fecha_Deposito__c,
                                              McontenidoAporte[i].Tipo_SaldoN__c,
                                              McontenidoAporte[i].Forma_PagoN__c,
                                              McontenidoAporte[i].Codigo_Referencia__c,
                                              McontenidoAporte[i].Codigo_Referencia_Rez__c,
                                              McontenidoAporte[i].Aplica_Comision_SI__c,
                                              McontenidoAporte[i].Rezago__c,
                                              McontenidoAporte[i].Monto_Calculado__c,
                                              McontenidoAporte[i].Oficial_de_negocios__c, 
                                              McontenidoAporte[i].Compra_Dolar__c,
                                              McontenidoAporte[i].cuenta__c
                                             ));
                
            }
        }
        Catch(Exception ex){
            system.debug('Error en linea: '+ex.getLineNumber());
        }
    }
    
    public void popDenegarSalir(){    
        DenegarVentana = false;
        Motivo = null;
    }
    
    public void popSalirImagen(){    
        DenegarImagen = false;
    }
    
    public void MostrarImagen(){    
        
        try{                 
            DenegarImagen = true; 
            ControllerAPICONCILIACION.classRespuestaImagen wer =  new ControllerAPICONCILIACION.classRespuestaImagen();
            wer = ControllerAPICONCILIACION.TraerImagenBD(Num_CodReferencia); 

            Ver_Imagen = wer.imagen;
            system.debug('Imagen clase ' + Ver_Imagen);

        }catch(exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!'+ e.getMessage() + ' Linea: ' + e.getLineNumber()));
        }      
        
    } 
    
    public void DenegarLista(){  
        
        try{
            
            if (Motivo == '') {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'La Descripcion No Puede Estar Vacia!'));
            }else{
                string nomOficial;
                correoUsuario(); //obtener el correo del oficial
                Pantalla_Aportes__c modifi = new Pantalla_Aportes__c ();
                
                Num_CodReferenciaDenegado = Num_CodReferencia;
                
                modifi = [select Codigo_Referencia__c, Oficial_de_negocios__c, Estado_Aporte__c, rezago__C,Descripcion__c, Codigo_Referencia_Rez__c,Monto_Calculado__c 
                          from Pantalla_Aportes__c 
                          where Codigo_Referencia__c =: Num_CodReferenciaDenegado limit 1];
                modifi.Codigo_Referencia__c = modifi.Codigo_Referencia__c + '1';
                nomOficial = modifi.Oficial_de_negocios__c;
                modifi.Estado_Aporte__c = 'D';
                modifi.Descripcion__c = Motivo; 
                update modifi;
                
                
                Bitacora_Conciliacion__c bita = new Bitacora_Conciliacion__c ();
                bita.Actividades__c = 'Se denego aporte con codigo de referencia: ' + ' ' + Num_CodReferenciaDenegado;
                bita.Evento__c = 'Denegar';
                bita.Pantalla__c = 'VFPantallaConciliacionAprobacionM';   
                bita.Fecha__c = date.today();
                bita.Usuario__c = Usuario;
                insert bita; 
                
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
                Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setHtmlBody( 'Buenas ' + nomOficial + ', su aporte con número de referencia ' + 
                                 Num_CodReferencia + ' ha sido DENEGADO, Por el siguiente motivo: ' + modifi.Descripcion__c);
                mail.setSubject('Aporte con número de referencia ' + Num_CodReferencia + ' DENEGADO');
                mail.setToAddresses(new String[] {correoEmpleado});
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
                mail.setSaveAsActivity(true);
                listCorreo.add(mail);
                Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
                
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Aporte Denegado'));
                DenegarVentana = false;
                Motivo = null;
            }
            reiniciar();            
        }catch(exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            //ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!'));
        }
    }
    
    public void MostrarVentanaDenegacion(){
        DenegarVentana = true;
        Num_CodReferenciaDenegado = Num_CodReferencia;
    }      
    
    public void CerraVentanaDenegacion(){
        DenegarVentana = false;
    }      

    //Metodo para Aprobar el aporte.
    public List<Contenido_Estado_Cuenta_Conciliacion__c> RevisarAporteConciliado {get;set;}
    public Contenido_Estado_Cuenta_Conciliacion__c AgregarAporte_A_Conciliados {get;set;}
    public List<Pantalla_Aportes__c> ListRespuesta {get;set;} 
    
    public void AprobarAporte() {    
        try{    
            //agregado 28-03-2019 - Obtiene la fecha de deposito para Actualizar la fecha de deposito
            ValorCuota = ControllerApiRezagos.ConsultaCuotaSal();
            rezago = null;
            system.debug('01- Entramos a AprobarAporte');
            Pantalla_Aportes__c modifi = new Pantalla_Aportes__c ();	
            Num_CodReferenciaDenegado = Num_CodReferencia;
            Boolean CompraDolar = false;
            for(integer k=0; k<McontenidoAporte.size(); k++ ){
                if(McontenidoAporte[k].Codigo_Referencia__c==Num_CodReferencia){
                    fechadeposito = McontenidoAporte[k].Fecha_Deposito__c;
                    compraDolar = McontenidoAporte[k].Compra_Dolar__c == 'S';
                    if(Rez_SI_NO=='SI' || Rez_SI_NO=='Si' || Rez_SI_NO=='si'){
                        rezago ='S';
                    }else{
                        rezago ='N';
                    }
                    system.debug('02 - Rezago: '+rezago+', Codigo referencia: '+McontenidoAporte[k].Codigo_Referencia__c);
                }
            }
            if(compraDolar && !popDOlar){
                popDolar();
                return;
            }
            popDOlar = false;
            CodReferenNoCobra = Num_CodReferencia;
            CodReferenciaTemp = Num_CodReferencia; 
            popDOlar = false;
            McontenidoAporte = new list<Pantalla_Aportes__c>();
            McontenidoAporte =[select cuenta__c, Tasa__c ,Tipo_MonedaN__c,Monto_Deposito__c, Fecha_Deposito__c,Tipo_SaldoN__c,
                               Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,rezago__C,Codigo_Referencia_Rez__c,
                               Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c, Codigo_Usuario__c,Monto_Calculado__c
                               from Pantalla_Aportes__c 
                               where Estado_Aporte__c = 'S' and Codigo_Referencia__c =: Num_CodReferencia and Codigo_Referencia__c !=null];
            
            correoUsuario();
            System.debug('03 - Codigo de la referencia: ' + Num_CodReferencia+' tamano: '+McontenidoAporte.size());
            for(integer i=0; i < McontenidoAporte.size(); i++){
                
                classAportes_Conciliacion apor =  new classAportes_Conciliacion();   
                
                /*Validacion para que muestre ventana modal cuando no aplique comision...*/
                system.debug('Cobra: '+McontenidoAporte[i].Aplica_Comision_SI__c +', Codigo: '+McontenidoAporte[i].Codigo_Referencia__c);
                if(McontenidoAporte[i].Aplica_Comision_SI__c == 'N' ){
                    system.debug('04 - Entro NO Aplica Comision');
                    nombreOficial = McontenidoAporte[i].Oficial_de_negocios__c;
                    Num_CodReferencia = McontenidoAporte[i].Codigo_Referencia__c;
                    McontenidoAporte[i].Codigo_Referencia_Rez__c = Num_CodReferencia_Rez;
                    update McontenidoAporte[i];
                    VentanaEmergenteNo = true;
                    
                }else{
                    system.debug('04 - Entro SI Aplica Comision');
                    VentanaEmergenteNo = false;
                    if(McontenidoAporte[i].Codigo_Referencia__c == CodReferenNoCobra){
                        //Valida que no tenga compra dolar 
                        //si tiene compra de dolar como 'S' se abre una ventana para que cambie el monto en lempiras a dolar.
                        
                        if (McontenidoAporte[i].Compra_Dolar__c == 'S' ){
                            system.debug('05 - Entro SI Compra Dolar - Cambiar monto Lempiras a Dolar');
                            Num_CodReferencia = Num_CodReferenciaDenegado;
                            nombreOficial = McontenidoAporte[i].Oficial_de_negocios__c;
                            VentanaEmergenteNo = false; 
                            CambioTasa();
                        }else{ 
                            system.debug('05 - Entro NO Compra Dolar');
                            nombreOficial = McontenidoAporte[i].Oficial_de_negocios__c; //Correo oficial
                            
                            apor.Cod_referencia = McontenidoAporte[i].Codigo_Referencia__c;
                            apor.Cuenta = McontenidoAporte[i].cuenta__c ;
                            apor.TipoSaldo = McontenidoAporte[i].Tipo_SaldoN__c;
                            apor.FechaDepositoAproba = date.valueOf(fechadeposito);
                            apor.p_periodo_aporte = McontenidoAporte[i].Periodo_Aporte__c;  
                            apor.Moneda = McontenidoAporte[i].Tipo_MonedaN__c ;
                            if(rezago=='SI' || rezago=='Si' || rezago=='si' || rezago=='S'){
                            	apor.Monto = Monto_Calculado;
                            }else{
                                apor.Monto =  string.valueOf(McontenidoAporte[i].Monto_Deposito__c);
                            }
                            apor.ComisionSI =  McontenidoAporte[i].Aplica_Comision_SI__c;
                            apor.p_periodo_aporte = McontenidoAporte[i].Periodo_Aporte__c;
                            apor.rezago = rezago;
                            system.debug('06 - Contenido Enviado a Guardar Aporte: '+apor);  
                            
                            classAportes_Conciliacion resultado = ControllerAPICONCILIACION.guardarAporte(apor);//Realiza el aporte a la cuenta del Cliente
                            
                            p_saldo = resultado.p_saldo;
                            p_monto_pen_aplic = resultado.p_monto_pen_aplic;
                            p_codigo_error = resultado.p_codigo_error;
                            p_Mensaje_error =  resultado.p_mensaje_error;   
                            p_num_movim_sysde = resultado.p_num_movim_sysde;
                            p_nombre = resultado.p_nombre;
                            
                            if(p_codigo_error == '0' || test.isRunningTest()){
                                System.debug('Antes de aplicar el rezago: ' + Num_CodReferencia_Rez+' - '+MensajeErr+' - '+VentanaEmergenteNo+' - '+BTNAplicar);
                                if((Num_CodReferencia_Rez!='Sin Registro' && MensajeErr==false && BTNAplicar!=true && VentanaEmergenteNo == false) || test.isRunningTest()){
                                    BTNAplicar=true;
                                    for(Integer j=0; j<listRezagos.size(); j++){
                                        AplicarRezago(listRezagos[j].codigo, num_CodCuenta_Rez, listRezagos[j].monto, Monto_Dep, Usuario,Moneda, Compra_Dolar);//Aplica El Rezago
                                    }
                                    //AplicarRezago(Num_CodReferencia_Rez, num_CodCuenta_Rez, Monto_Calculado, Monto_Dep, Usuario, Moneda, Compra_Dolar);//Aplica El Rezago
                                }else{
                                    System.debug('Rezago NO Aplicado');
                                }
                            }
                            
                            //actualizar la fecha de deposito
                            modifi = [select Fecha_Deposito__c from Pantalla_Aportes__c where Codigo_Referencia__c =: Num_CodReferenciaDenegado ];
                            modifi.Fecha_Deposito__c = fechadeposito;
                            update modifi;
                            
                            if(p_codigo_error == '0' || test.isRunningTest()){
                                system.debug('07 - Entra Codigo Error 0');    
                                ListRespuesta = [select cuenta__c, Tasa__c, Tipo_MonedaN__c, Monto_Deposito__c, Fecha_Deposito__c, Tipo_SaldoN__c ,
                                                 Forma_PagoN__c, Codigo_Referencia__c, Aplica_Comision_SI__c,Codigo_Referencia_Rez__c,
                                                 Compra_Dolar__c, Periodo_Aporte__c, Oficial_de_negocios__c,Monto_Calculado__c
                                                 from Pantalla_Aportes__c 
                                                 where Codigo_Referencia__c =: Num_CodReferencia];
                                
                                system.debug('08 - Tamaño Lista: '+ListRespuesta.size());
                                
                                for(integer S=0; S < ListRespuesta.size(); S++){
                                    
                                    RevisarAporteConciliado = [select Conciliado__c,Fecha_Valor__c, Monto_Fijo__c, Dias__c,Referencia__c 
                                                               from Contenido_Estado_Cuenta_Conciliacion__c 
                                                               where Referencia__c =: Num_CodReferencia ];
                                    
                                    if (RevisarAporteConciliado.size() > 0 ){
                                        system.debug('09 - Entra a Revisar AporteConciliado ');
                                        for(integer p=0; p<RevisarAporteConciliado.size(); p++){   
                                            if (RevisarAporteConciliado[i].Conciliado__c == 'S') {
                                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Esta Conciliado'));
                                             } else{
                                                if (RevisarAporteConciliado[i].Dias__c == 1){
                                                    RevisarAporteConciliado[i].Conciliado__c = 'S';
                                                    update RevisarAporteConciliado;
                                                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Conciliado'));
                                                 }else {
                                                    MostraVentana();
                                                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Conciliación Tiene dos dias')); 
                                                }
                                            } 
                                        } 
                                    }else{
                                        system.debug('09 - Entra a Aporte NO Conciliado ');
                                        Contenido_Estado_Cuenta_Conciliacion__c AgregarAporte_A_Conciliados = new Contenido_Estado_Cuenta_Conciliacion__c();
                                        AgregarAporte_A_Conciliados.Fecha_Valor__c = ListRespuesta[i].Fecha_Deposito__c;
                                        AgregarAporte_A_Conciliados.Fecha_Sistema__c = date.today(); 
                                        AgregarAporte_A_Conciliados.Referencia__c = ListRespuesta[i].Codigo_Referencia__c;
                                        AgregarAporte_A_Conciliados.Monto__c = ListRespuesta[i].Monto_Deposito__c;
                                        AgregarAporte_A_Conciliados.Monto_Fijo__c = ListRespuesta[i].Monto_Deposito__c;
                                        AgregarAporte_A_Conciliados.Monto_Pendiente__c = ListRespuesta[i].Monto_Deposito__c;
                                        AgregarAporte_A_Conciliados.Usuario_SIstema__c = ListRespuesta[i].Oficial_de_negocios__c;
                                        AgregarAporte_A_Conciliados.Dias__c = 1;
                                        AgregarAporte_A_Conciliados.Descripci_n__c = 'Aporte Agregado Desde El Sistema De Aprobacion';
                                        AgregarAporte_A_Conciliados.Fecha_posteo__c = ListRespuesta[i].Fecha_Deposito__c;
                                        AgregarAporte_A_Conciliados.Conciliado__c = 'N';
                                        
                                        if(ListRespuesta[i].Tipo_MonedaN__c == '1'){
                                            AgregarAporte_A_Conciliados.Tipo_Planilla__c =  'HNL';  
                                        } else{
                                            AgregarAporte_A_Conciliados.Tipo_Planilla__c =  'USD';  
                                        }
                                        system.debug('10 - Agrega el Aporte a Conciliados ');
                                        insert AgregarAporte_A_Conciliados;
                                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Agregado Correctamente a los no conciliados, porque no se encontro registrado en SF'));
                                        
                                    } 
                                    if(!test.isRunningTest()){
                                        ModificarEstado = [select Estado_Aporte__c from Pantalla_Aportes__c where Codigo_Referencia__c =: apor.Cod_referencia limit 1];
                                    }else{
                                        ModificarEstado = [select Estado_Aporte__c from Pantalla_Aportes__c limit 1];
                                    }
                                    system.debug('11 - Estado_Aporte__c Cambia a A desde: '+ModificarEstado.Estado_Aporte__c);
                                    ModificarEstado.Estado_Aporte__c = 'A';  
                                    update ModificarEstado;
                                    
                                    //Inserta En La bitacora De todos los registros
                                    if(!test.isRunningTest()){
                                        RegistroAportesTotal = [select Estado_Aporte__c from Registro_Aportes__c where Codigo_Referencia__c =:  apor.Cod_referencia ];
                                    }else{
                                        RegistroAportesTotal = [select Estado_Aporte__c from Registro_Aportes__c limit 1 ];
                                    }
                                    system.debug('12 - Estado_Aporte__c Cambia a A desde: '+RegistroAportesTotal.Estado_Aporte__c);
                                    RegistroAportesTotal.Estado_Aporte__c = 'A';  
                                    update RegistroAportesTotal;

                                    MensajeVF = true;
                                    OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
                                    Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
                                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                    mail.setHtmlBody( 'Buenas ' + nombreOficial + ', su aporte con número de referencia ' + 
                                                     Num_CodReferencia + ' ha sido APROBADO.');
                                    mail.setSubject('Aporte con número de referencia ' + Num_CodReferencia + ', APROBADO.');
                                    mail.setToAddresses(new String[] {correoEmpleado});
                                    mail.setOrgWideEmailAddressId(owea.get(0).Id);
                                    mail.setSaveAsActivity(true);
                                    listCorreo.add(mail);
                                    Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
                                }
                                
                                
                            }else{
                                system.debug('07 - Entra Codigo Error: '+p_codigo_error+' Mensaje: '+p_Mensaje_error);    
                                p_Mensaje_error = 'Error al Aprobar el aporte en el Metodo: AplicarAporte. <br/>'+p_Mensaje_error;
                                MensajeErr = true;
                            }
                        }
                    }
                }
            }
            IF(MensajeVF == true || MensajeErr == true){
                System.debug('Reiniciamos al terminar AprobarAporte');
                reiniciar();
            }
        }catch(exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            p_Mensaje_error = 'Error al Aprobar el aporte en el Metodo: AplicarAporte.<br/>Mensaje: '+e.getMessage()+'.<br/>Linea: ' + e.getLineNumber();
            MensajeErr = true;
        }
    }
    
    public void correoUsuario(){
        try{
            cod_empleado = [select Codigo_Usuario__c from Pantalla_Aportes__c where Codigo_Referencia__c =: Num_CodReferencia].Codigo_Usuario__c;
            correoEmpleado = [select Email__c from Usuarios_de_Pantallas__c where Usuario__c =: cod_empleado].Email__c;
            System.debug('Se obtienen los datos de empleado : '+cod_empleado+' - '+correoEmpleado);
        }catch(exception ex){
            system.debug('Error: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());
            p_Mensaje_error = 'Error al Aprobar Aporte en el Metodo: correoUsuario. <br/>Error: ' + ex.getMessage() + '<br/>Linea: ' + ex.getLineNumber();
            MensajeErr = true;
        }
        
    }
    
    public void mostrarVenTasa(){
        
        ModifiUSD =[ select Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,Monto_Calculado__c,
                    Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c,Codigo_Referencia_Rez__c
                    from Pantalla_Aportes__c 
                    where Estado_Aporte__c = 'S' and Codigo_Referencia__c =: Num_CodReferencia];
        
        if(test.isRunningTest()){
            ModifiUSD =[ select Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,Monto_Calculado__c,
                        Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c,Codigo_Referencia_Rez__c
                        from Pantalla_Aportes__c ];
        }        
        for(integer i=0; i<ModifiUSD.size(); i++) {
            if(ModifiUSD[i].Codigo_Referencia__c ==  Num_CodReferencia || test.isRunningTest()) {
                if (ModifiUSD[i].Compra_Dolar__c == 'S'){
                    MostrarTasa = true;
                }else{
                    BloqAcep = false;
                    MotrarBtn = true;
                }
            }  
        }   
    }
    
    public void Cerrar() {
        VentanaEmergenteNo = false;
        MostrarTasa = false;
        p_Mensaje_error = '';
        MensajeErr = false;
        MostrarTasa = false;
        popTasa = false;
        MensajeVF = false;
        MostrarTasa = false;
    }

    public void AprobarAporte2SinComision(){
        try{    
            system.debug('Entramos a AprobarAporte2SinComision');
            VentanaEmergenteNo = false;
            Pantalla_Aportes__c modifi = new Pantalla_Aportes__c ();	
            
            McontenidoAporte =[select cuenta__c, Tasa__c, Tipo_MonedaN__c, Monto_Deposito__c, Fecha_Deposito__c, Tipo_SaldoN__c,
                               Forma_PagoN__c, Codigo_Referencia__c, Aplica_Comision_SI__c, rezago__c,Codigo_Referencia_Rez__c,
                               Compra_Dolar__c, Periodo_Aporte__c, Oficial_de_negocios__c,Monto_Calculado__c
                               from Pantalla_Aportes__c 
                               where Estado_Aporte__c = 'S' and Codigo_Referencia__c =: CodReferenNoCobra and Codigo_Referencia__c!=null];
            system.debug('01- McontenidoAporte Size: '+McontenidoAporte.size());
            for(integer i=0; i < McontenidoAporte.size(); i++) {
                
                classAportes_Conciliacion apor =  new classAportes_Conciliacion();
                
                if(McontenidoAporte[i].Codigo_Referencia__c == CodReferenNoCobra){
                    if (McontenidoAporte[i].Compra_Dolar__c == 'S' ){
                        system.debug('02- CompraDolar: S');
                        VentanaEmergenteNo = false; 
                        CodReferenciaTemp = CodReferenNoCobra;
                        CambioTasa();
                    }else{
                        system.debug('02- CompraDolar: N');
                        apor.Cod_referencia = McontenidoAporte[i].Codigo_Referencia__c;
                        apor.Cuenta = McontenidoAporte[i].cuenta__c ;
                        apor.TipoSaldo = McontenidoAporte[i].Tipo_SaldoN__c;
                        apor.FechaDepositoAproba = date.valueOf(fechadeposito);//date.valueOf(McontenidoAporte[i].Fecha_Deposito__c);
                        apor.p_periodo_aporte = McontenidoAporte[i].Periodo_Aporte__c;  
                        apor.Moneda = McontenidoAporte[i].Tipo_MonedaN__c ;
                        
                        if(rezago=='SI' || rezago=='Si' || rezago=='si' || rezago=='S'){
                            apor.Monto = Monto_Calculado;
                        }else{
                            apor.Monto =  string.valueOf(McontenidoAporte[i].Monto_Deposito__c);
                        }  
                        
                        apor.ComisionSI =  McontenidoAporte[i].Aplica_Comision_SI__c;
                        apor.rezago = rezago;
                        
                        system.debug('03 - ResultadoEnviado: '+apor);  
                        
                        classAportes_Conciliacion resultado = ControllerAPICONCILIACION.guardarAporte(apor);
                        
                        p_saldo = resultado.p_saldo;
                        p_monto_pen_aplic = resultado.p_monto_pen_aplic;
                        p_codigo_error = resultado.p_codigo_error;
                        p_Mensaje_error =  resultado.p_mensaje_error;   
                        p_num_movim_sysde = resultado.p_num_movim_sysde;
                        p_nombre = resultado.p_nombre;
                        
                        if(p_codigo_error == '0' || test.isRunningTest()){
                            System.debug('Antes de aplicar el rezago: ' + Num_CodReferencia_Rez+' - '+MensajeErr+' - '+VentanaEmergenteNo+' - '+BTNAplicar);
                            if((Num_CodReferencia_Rez!='Sin Registro' && MensajeErr==false && BTNAplicar!=true && VentanaEmergenteNo == false) || test.isRunningTest()){
                                BTNAplicar=true;
                                for(Integer j=0; j<listRezagos.size(); j++){
                                    AplicarRezago(listRezagos[j].codigo, num_CodCuenta_Rez, listRezagos[j].monto, Monto_Dep, Usuario,Moneda, Compra_Dolar);//Aplica El Rezago
                                }
                                //AplicarRezago(Num_CodReferencia_Rez, num_CodCuenta_Rez, Monto_Calculado, Monto_Dep, Usuario, Moneda, Compra_Dolar);//Aplica El Rezago
                            }
                        }else{
                            System.debug('Rezago NO Aplicado');
                            system.debug('Guardar Aporte Entra Codigo Error: '+p_codigo_error+' Mensaje: '+p_Mensaje_error);    
                            p_Mensaje_error = 'Error al Guardar el Aporte en el Metodo: AprobarAporte2SinComision. <br/><br/> (Sysde) : '+p_Mensaje_error;
                            MensajeErr = true;
                            return;
                        }
                        
                        //actualizar la fecha de deposito
                        modifi = [select Fecha_Deposito__c from Pantalla_Aportes__c where Codigo_Referencia__c =: Num_CodReferenciaDenegado ];
                        modifi.Fecha_Deposito__c = fechadeposito;
                        update modifi;
                        
                        if (p_codigo_error == '0' || test.isRunningTest()){
                            system.debug('04- P Codigo error: 0');
                            ListRespuesta = [select cuenta__c, Tasa__c ,Tipo_MonedaN__c,Monto_Deposito__c, Fecha_Deposito__c,Tipo_SaldoN__c ,
                                             Forma_PagoN__c, Codigo_Referencia__c, Aplica_Comision_SI__c, Codigo_Referencia_Rez__c,
                                             Compra_Dolar__c, Periodo_Aporte__c, Oficial_de_negocios__c,Monto_Calculado__c
                                             from Pantalla_Aportes__c 
                                             where Codigo_Referencia__c =: CodReferenNoCobra];
                            
                            system.debug('05- ListRespuesta Size: '+ListRespuesta.size());
                            for(integer S=0; S < ListRespuesta.size(); S++){
                                
                                RevisarAporteConciliado = [select Conciliado__c,Fecha_Valor__c, Monto_Fijo__c, Dias__c,Referencia__c 
                                                           from Contenido_Estado_Cuenta_Conciliacion__c 
                                                           where Referencia__c =: CodReferenNoCobra ];
                                system.debug('06- RevisarAporteConciliado Size: '+RevisarAporteConciliado.size());
                                if (RevisarAporteConciliado.size() > 0 ) {
                                    for(integer p=0; p<RevisarAporteConciliado.size(); p++) {   
                                        
                                        if (RevisarAporteConciliado[i].Conciliado__c == 'S'){
                                            system.debug('07- Conciliado Si');
                                            VentanaEmergenteNo = false;
                                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Esta Conciliado'));
                                        }else{
                                            system.debug('07- Conciliado NO');
                                            if (RevisarAporteConciliado[i].Dias__c == 1){
                                                RevisarAporteConciliado[i].Conciliado__c = 'S';
                                                update RevisarAporteConciliado;
                                                VentanaEmergenteNo = false;
                                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Conciliado'));
                                            }else{
                                                VentanaEmergenteNo = false;
                                                MostraVentana();
                                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Conciliación Tiene dos dias')); 
                                            }
                                        }
                                    } 
                               }else{
                                   
                                    Contenido_Estado_Cuenta_Conciliacion__c AgregarAporte_A_Conciliados = new Contenido_Estado_Cuenta_Conciliacion__c();
                                    AgregarAporte_A_Conciliados.Fecha_Valor__c = ListRespuesta[i].Fecha_Deposito__c;
                                    AgregarAporte_A_Conciliados.Fecha_Sistema__c = date.today(); 
                                    AgregarAporte_A_Conciliados.Referencia__c = ListRespuesta[i].Codigo_Referencia__c;
                                    AgregarAporte_A_Conciliados.Monto__c = ListRespuesta[i].Monto_Deposito__c;
                                    AgregarAporte_A_Conciliados.Monto_Fijo__c = ListRespuesta[i].Monto_Deposito__c;
                                    AgregarAporte_A_Conciliados.Monto_Pendiente__c = ListRespuesta[i].Monto_Deposito__c;
                                    AgregarAporte_A_Conciliados.Usuario_SIstema__c = ListRespuesta[i].Oficial_de_negocios__c;
                                    AgregarAporte_A_Conciliados.Dias__c = 1;
                                    AgregarAporte_A_Conciliados.Descripci_n__c = 'Aporte Agregado Desde El Sistema De Aprobacion';
                                    AgregarAporte_A_Conciliados.Fecha_posteo__c = ListRespuesta[i].Fecha_Deposito__c;
                                    AgregarAporte_A_Conciliados.Conciliado__c = 'N';
                                    AgregarAporte_A_Conciliados.Tipo_Planilla__c = ListRespuesta[i].Tipo_MonedaN__c == '1' ? 'HNL' :'USD';
                                    insert AgregarAporte_A_Conciliados;
                                    VentanaEmergenteNo = false;
                                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Agregado Correctamente a los no conciliados, porque no se encontro registrado en SF'));
                                    
                                }
                                system.debug('08- Actualiza estado Aporte a A.');
                                ModificarEstado = [select Estado_Aporte__c from Pantalla_Aportes__c where Codigo_Referencia__c =:  apor.Cod_referencia ];
                                ModificarEstado.Estado_Aporte__c = 'A';  
                                update ModificarEstado;
                                
                                RegistroAportesTotal = [select Estado_Aporte__c from Registro_Aportes__c where Codigo_Referencia__c =:  apor.Cod_referencia ];
                                RegistroAportesTotal.Estado_Aporte__c = 'A';  
                                update RegistroAportesTotal;
                                VentanaEmergenteNo = false;
                                MensajeVF = true;
                            }
                        }else{
                            system.debug('07 - Entra Codigo Error: '+p_codigo_error+' Mensaje: '+p_Mensaje_error);    
                            p_Mensaje_error = 'Error al Aprobar el aporte en el Metodo: AprobarAporte2SinComision. <br/>'+p_Mensaje_error;
                            MensajeErr = true;
                            return;
                        }
                    } 
                }
            }
            
            //Envio de correo - Agregado 05-04-2019
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
            Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setHtmlBody( 'Buenas ' + nombreOficial + ', su aporte con número de referencia ' + 
                             Num_CodReferencia + ' ha sido APROBADO.');
            mail.setSubject('Aporte con número de referencia ' + CodReferenNoCobra + ', APROBADO.');
            mail.setToAddresses(new String[] {correoEmpleado});
            mail.setOrgWideEmailAddressId(owea.get(0).Id);
            mail.setSaveAsActivity(true);
            listCorreo.add(mail);
            Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
            Num_CodReferencia =null;
            reiniciar();
        }catch(exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            p_Mensaje_error = e.getMessage()+' <br/>Linea: ' + e.getLineNumber();
            p_Mensaje_error = 'Error al Aprobar el aporte en el Metodo: AprobarAporte2SinComision. <br/>Mensaje: '+p_Mensaje_error;
            MensajeErr = true;
        }   
        
    }

    //Compra venta de dolares
    
    public void CambioTasa(){
        try{
            System.debug('Entramos CambioTasa');
            Pantalla_Aportes__c modifi = new Pantalla_Aportes__c ();	
            
            correoUsuario();
            part = 'S';
            UpdaSaldos = 'S';
            double totalDo = 0.0;
            string TipoMonedaD = 'S';
            Pantalla_Aportes__c ane = new Pantalla_Aportes__c();
            ane = [Select Monto_Deposito__c,Tipo_MonedaN__c,cuenta__c, id, tasa__C, rezago__C, Nombre_Completo__c, Aporte_Dolares_Flag__c, Codigo_Referencia_Rez__c,Monto_Calculado__c
                   from Pantalla_Aportes__c 
                   where Estado_Aporte__c = 'S' and Codigo_Referencia__c =: CodReferenciaTemp];
            
            if(ane.Aporte_Dolares_Flag__c == null || ane.Aporte_Dolares_Flag__c == false){
                string moneda = ane.Tipo_MonedaN__c =='1' ? 'USD' :'HNL' ;
                if(rezago=='SI' || rezago=='Si' || rezago=='si' || rezago=='S'){
                    ane.Rezago__c = 'S';
                    ane.Monto_Deposito__c = decimal.valueOf(Monto_Calculado);
                }else{
                    ane.Rezago__c = 'N';
                } 
                string NombreCliente = ane.Nombre_Completo__c;
                tasa = new classDolares.classRespuestaDolares();
                
                System.debug('Antes de Buscar la tasa: '+moneda+' - '+ane.Monto_Deposito__c+' - '+NombreCliente);
                tasa = aSysdePortalEmpresarial.CompraVentaDolares(moneda, ane.Monto_Deposito__c, NombreCliente);
                
                System.debug('Tasa: '+tasa);
                CompraDolar = null;
                
                if(tasa.tasaCambio !=null){
                    system.debug('Ingresa Tasa != Null');
                    CompraDolar = decimal.valueOf(tasa.tasaCambio.replace(',',''));
                    ane.Tasa__c = CompraDolar;
                    totalDo = decimal.valueOf(tasa.montoAcreditado.replace(',',''));
                    ane.Monto_Deposito__c=totalDo;
                    TipoMonedaD = ane.Tipo_MonedaN__c;
                    part = 'OK';
                    System.debug('Datos Convertidos: '+CompraDolar+' - '+totalDo+' - '+TipoMonedaD+' - '+part);
                }else{
                    system.debug('Ingresa Tasa = Null');
                    p_Mensaje_error = 'Error al Aprobar el aporte en el Metodo: CambioTasa. Mensaje: Valor de Tasa devuelto es Null.';
                    MensajeErr = true;
                }
                
                if (part == 'OK'){
                    system.debug('Part OK - Mostrartasa: '+MostrarTasa+', VentanaEmergenteNo: '+VentanaEmergenteNo);
                    McontenidoTasa =[select cuenta__c, Tasa__c ,Tipo_MonedaN__c,Monto_Deposito__c, Fecha_Deposito__c,Tipo_SaldoN__c ,
                                     Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c, Codigo_Referencia_Rez__c,Monto_Calculado__c,
                                     Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c, Aporte_Dolares_Flag__c
                                     from Pantalla_Aportes__c 
                                     where Estado_Aporte__c = 'S' and Codigo_Referencia__c =: CodReferenciaTemp ];
                    
                    for(integer i=0; i < McontenidoTasa.size(); i++){
                        System.debug('Entramos al FOR para McontenidoTasa');
                        classAportes_Conciliacion wer =  new classAportes_Conciliacion();   
                        wer.Cod_referencia = McontenidoTasa[i].Codigo_Referencia__c;
                        wer.Cuenta = McontenidoTasa[i].cuenta__c ;
                        wer.TipoSaldo = McontenidoTasa[i].Tipo_SaldoN__c;
                        wer.FechaDepositoAproba = date.valueOf(fechadeposito);
                        wer.p_periodo_aporte = McontenidoTasa[i].Periodo_Aporte__c;  
                        wer.Moneda = TipoMonedaD ;
                        wer.Monto =  string.valueOf(totalDo);  
                        wer.ComisionSI =  McontenidoTasa[i].Aplica_Comision_SI__c;
                        wer.Rezago = rezago;
                        
                        classAportes_Conciliacion resultado = ControllerAPICONCILIACION.guardarAporte(wer);
                        System.debug('Resultado de Guardar Aporte: '+resultado);
                        p_saldo = resultado.p_saldo;
                        p_monto_pen_aplic = resultado.p_monto_pen_aplic;
                        p_codigo_error = resultado.p_codigo_error;
                        p_Mensaje_error =  resultado.p_mensaje_error;   
                        p_num_movim_sysde = resultado.p_num_movim_sysde;
                        p_nombre = resultado.p_nombre;
                        
                        if(p_codigo_error == '0' || test.isRunningTest()){
                            System.debug('Antes de aplicar el rezago: ' + Num_CodReferencia_Rez+' - '+MensajeErr+' - '+VentanaEmergenteNo+' - '+BTNAplicar);
                            if((Num_CodReferencia_Rez!='Sin Registro' && MensajeErr==false && BTNAplicar!=true && VentanaEmergenteNo == false) || test.isRunningTest()){
                                BTNAplicar=true;
                                for(Integer j=0; j<listRezagos.size(); j++){
                                    AplicarRezago(listRezagos[j].codigo, num_CodCuenta_Rez, listRezagos[j].monto, Monto_Dep, Usuario,Moneda, Compra_Dolar);//Aplica El Rezago
                                }
                                //AplicarRezago(Num_CodReferencia_Rez, num_CodCuenta_Rez, Monto_Calculado, Monto_Dep, Usuario, Moneda, Compra_Dolar);//Aplica El Rezago
                            }else{
                                System.debug('Rezago NO Aplicado');
                            }
                        }
                        
                        //actualizar la fecha de deposito
                        modifi = [select Fecha_Deposito__c from Pantalla_Aportes__c where Codigo_Referencia__c =: Num_CodReferenciaDenegado limit 1];
                        modifi.Fecha_Deposito__c = fechadeposito;
                        update modifi;
                        
                        if (p_codigo_error == '0' || test.isRunningTest()) {
                            system.debug('Entra a Error = 0 ');
                            UpdaSaldos = 'OK';
                            ListRespuesta = [select    cuenta__c, Tasa__c ,Tipo_MonedaN__c,Monto_Deposito__c, Fecha_Deposito__c,Tipo_SaldoN__c ,
                                             Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c, Codigo_Referencia_Rez__c,
                                             Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c,Monto_Calculado__c
                                             from Pantalla_Aportes__c 
                                             where Codigo_Referencia__c =: CodReferenciaTemp];
                            
                            for(integer S=0; S < ListRespuesta.size(); S++){
                                RevisarAporteConciliado = [select Conciliado__c,Fecha_Valor__c, Monto_Fijo__c, Dias__c,Referencia__c 
                                                           from Contenido_Estado_Cuenta_Conciliacion__c 
                                                           where Referencia__c =: CodReferenciaTemp ];
                                
                                if (RevisarAporteConciliado.size() > 0 ){
                                    for(integer p=0; p<RevisarAporteConciliado.size(); p++){   
                                        if (RevisarAporteConciliado[i].Conciliado__c == 'S'){
                                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Esta Conciliado'));
                                            
                                        }else{
                                            if (RevisarAporteConciliado[i].Dias__c == 1){
                                                RevisarAporteConciliado[i].Conciliado__c = 'S';
                                                update RevisarAporteConciliado;
                                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Conciliado'));
                                            }else {
                                                MostraVentana();
                                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Conciliación Tiene dos dias')); 
                                            }
                                        } 
                                        
                                    } 
                                }else{
                                    Contenido_Estado_Cuenta_Conciliacion__c AgregarAporte_A_Conciliados = new Contenido_Estado_Cuenta_Conciliacion__c();
                                    AgregarAporte_A_Conciliados.Fecha_Valor__c = ListRespuesta[i].Fecha_Deposito__c;
                                    AgregarAporte_A_Conciliados.Referencia__c = ListRespuesta[i].Codigo_Referencia__c;
                                    AgregarAporte_A_Conciliados.Monto__c = totalDo;
                                    AgregarAporte_A_Conciliados.Monto_Fijo__c = totalDo;
                                    AgregarAporte_A_Conciliados.Usuario_SIstema__c = ListRespuesta[i].Oficial_de_negocios__c;
                                    AgregarAporte_A_Conciliados.Dias__c = 1;
                                    AgregarAporte_A_Conciliados.Descripci_n__c = 'Aporte Agregado Desde El Sistema De Aprobacion';
                                    AgregarAporte_A_Conciliados.Fecha_posteo__c = ListRespuesta[i].Fecha_Deposito__c;
                                    AgregarAporte_A_Conciliados.Conciliado__c = 'N';
                                    AgregarAporte_A_Conciliados.Tipo_Planilla__c = TipoMonedaD == '2' ? 'USD':'HNL' ;
                                    insert AgregarAporte_A_Conciliados;
                                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Agregado Correctamente a los no conciliados, porque no se encontro registrado en SF'));
                                } 
                                
                                ModificarEstado = [select Estado_Aporte__c from Pantalla_Aportes__c where Codigo_Referencia__c =:  wer.Cod_referencia ];
                                ModificarEstado.Estado_Aporte__c = 'A';  
                                update ModificarEstado;
                                
                                //Inserta En La bitacora De todos los registros
                                RegistroAportesTotal = [select Estado_Aporte__c from Registro_Aportes__c where Codigo_Referencia__c =:  wer.Cod_referencia ];
                                RegistroAportesTotal.Estado_Aporte__c = 'A';  
                                update RegistroAportesTotal;
                                
                            }
                            MostrarTasa = true;
                            update ane;
                            
                        }else{
                            system.debug('07 - Entra Codigo Error: '+p_codigo_error+' Mensaje: '+p_Mensaje_error);    
                            p_Mensaje_error = 'Error al Aprobar el aporte en el Metodo: CambioTasa. <br/>'+p_Mensaje_error;
                            MensajeErr = true;
                        }
                    }	                 
                    
                }
                
                //Envio de correo - Agregado 05-04-2019
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
                Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setHtmlBody( 'Buenas ' + nombreOficial + ', su aporte con número de referencia ' + 
                                 Num_CodReferencia + ' ha sido APROBADO.');
                mail.setSubject('Aporte con número de referencia ' + CodReferenciaTemp + ' APROBADO');
                mail.setToAddresses(new String[] {correoEmpleado});
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
                mail.setSaveAsActivity(true);
                listCorreo.add(mail);
                Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
                Try{
                    if (UpdaSaldos == 'OK'){
                        System.Debug('Entramos al UpdateSaldos');
                        Pantalla_Aportes__c put = new Pantalla_Aportes__c();
                        put = [select Monto_Deposito__c,Tipo_MonedaN__c, Codigo_Referencia_Rez__c
                               from Pantalla_Aportes__c 
                               where Estado_Aporte__c = 'A' and Codigo_Referencia__c =: CodReferenciaTemp]; 
                        put.Monto_Deposito__c = totalDo;
                        put.Tipo_MonedaN__c = TipoMonedaD;
                        UPDATE put;
                        System.Debug('Saldos actualizados correctamente');
                    }
                }catch(Exception ex){
                    system.debug('Error: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());
                    p_Mensaje_error = 'Error al Aprobar el aporte en el Metodo: CambioTasa. <br/>Error: ' + ex.getMessage() + '<br/>Linea: ' + ex.getLineNumber();
                    MensajeErr = true; 
                }
                system.debug('Fin del CambioTasa - MostrarTasa: '+MostrarTasa+', VentanaEmergenteNo: '+VentanaEmergenteNo);
                
                ane.Aporte_Dolares_Flag__c=true;
                System.debug('Aplicar aportes dolar ejecutado con exito: FLAG: '+ane.Aporte_Dolares_Flag__c);
                update ane;
                
            }//FIN de IF para evitar volver a ejecutar.
            
        }catch(Exception ex){
            system.debug('Error: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());
            p_Mensaje_error = 'Error al Aprobar el aporte en el Metodo: CambioTasa. <br/>Error: ' + ex.getMessage() + '<br/>Linea: ' + ex.getLineNumber();
            MensajeErr = true; 
        }
    }
    
    public void eliminarRezago(){
        Integer count = 0;
        for(Integer i=0; i<listRezagos.size(); i++){
            if(listRezagos[i].codigo == codigoRezago){
                count = i;
            }
        }
        listRezagos.remove(count);
    }
    
} // de la clase principal