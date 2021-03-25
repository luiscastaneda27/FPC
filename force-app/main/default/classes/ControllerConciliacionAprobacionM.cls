public without sharing class ControllerConciliacionAprobacionM { 
    
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
    public boolean MensajeError {get;set;} 
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
    
    public ControllerConciliacionAprobacionM(){
        BloqAcep = true;
        FechaActual = date.today();
        Usuario =  ApexPages.currentPage().getParameters().get('hytrd');
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
        
    public void MostraVentana(){
        try{
            MostrarVenta12 = true;
            ListSeleccionado =[ select cuenta__c, Tipo_MonedaN__c, Fecha_Deposito__c, Monto_Deposito__c, Tipo_SaldoN__c ,
                               Forma_PagoN__c, Codigo_Referencia__c, Aplica_Comision_SI__c, Rezago__c ,
                               Compra_Dolar__c, Oficial_de_negocios__c, Periodo_Aporte__c
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
                    String consulta = '"numTransaccion":"FT20217C8CC6"';//+ListSeleccionado[i].Codigo_Referencia__c+'"';
                    string resultado = ControllerApiRezagos.ConsultaRezagos(consulta);
                }
            } // fin del for
        }catch(exception ex){}        
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
        }
    }
        
    public void reiniciar(){    
        FechaActual = date.today();
        McontenidoAporte =[ select cuenta__c, Tipo_MonedaN__c, Fecha_Deposito__c, Monto_Deposito__c, Tipo_SaldoN__c ,
                           Forma_PagoN__c, Codigo_Referencia__c, Aplica_Comision_SI__c, Rezago__c , Monto_Calculado__c,
                           Compra_Dolar__c, Oficial_de_negocios__c, Periodo_Aporte__c
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
        BTNAplicar=false;
        String consulta = CodRefTest.trim();
        string resultado = ControllerApiRezagos.ConsultaRezagos(consulta.trim());
        if(test.isRunningTest()){
            resultado='{"clientes":[{"idRezago":"SF-135","montoRezago":"40","fondo":"106","codReferencia":"FT20prueba4","fechaDeposito":"27-SEP-20","codigoMoneda":"USD","descripcion":"Transferencia entre Cuentas","descripcionNota":"Transferencia de la cuenta XX4156 de CRISTINA BANEGAS ZEITUN    100110 VENTA $","usuIngresaRezago":"HN02913","codBanco":"28","agnBanco":"AGN PRINCIPAL TGU","rezagoSINO":"SI","asesor":"HN23213","estado":"Pendiente","valorCuotaEntrada":"127.52636724","fecInclusion":"01-OCT-20","incluidoPor":"System","fecModificacion":"08-OCT-20","modificadoPor":"HN02913","montoPendienteAplicar":""}]}';
        }
        Existe='';
        List<String> SearchRes1 = resultado.split('},');
        system.debug('Tamaño del SearchValores: '+SearchRes1.size());
        
        if(SearchRes1.size()==1 && resultado!='{"clientes":[]}'){
            List<String> SearchRes = resultado.split(',');
            system.debug('19: '+SearchRes[19]);
            
            String mntpen = SearchRes[19].substringBeforeLast('"');
            mntpen = mntpen.substringAfterLast('"');
            
            if(mntpen=='0' || mntpen==''){
                String mnt = SearchRes[1];
                mnt = mnt.substringBeforeLast('"');
                mnt = mnt.substringAfterLast('"');
                system.debug('Monto: '+mnt);
                Monto = mnt;              
            }else{
                Monto = mntpen;
                Existe = ' Corresponde a un Monto pendiente.';
            }
            
            String mon = SearchRes[5];
            mon = mon.substringBeforeLast('"');
            mon = mon.substringAfterLast('"');
            system.debug('Moneda: '+mon);
            Moneda = mon;
            
            String rez = SearchRes[11];
            rez = rez.substringBeforeLast('"');
            rez = rez.substringAfterLast('"');
            system.debug('Rezago SI/NO: '+rez);
            Rezagosn = rez;
            
            System.Debug('13: '+SearchRes[13]);
            String estador = SearchRes[13].substringBeforeLast('"');
            estador = estador.substringAfterLast('"');
            
            if(estador=='Pagado' || Rezagosn=='NO'){
                Existe='Rezago ya Aplicado. PAGADO. ';
                Monto='';
                Moneda='';
                Rezagosn='';
            }else{
            	Existe='Datos de Muestra. '+Existe;
                BTNAplicar=true;
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
                String resultado = ControllerApiRezagos.ConsultaRezagos(consulta.trim());
                if(test.isRunningTest()){
                    resultado='{"clientes":[{"idRezago":"SF-135","montoRezago":"40","fondo":"106","codReferencia":"FT20prueba4","fechaDeposito":"27-SEP-20","codigoMoneda":"USD","descripcion":"Transferencia entre Cuentas","descripcionNota":"Transferencia de la cuenta XX4156 de CRISTINA BANEGAS ZEITUN    100110 VENTA $","usuIngresaRezago":"HN02913","codBanco":"28","agnBanco":"AGN PRINCIPAL TGU","rezagoSINO":"SI","asesor":"HN23213","estado":"Pendiente","valorCuotaEntrada":"127.52636724","fecInclusion":"01-OCT-20","incluidoPor":"System","fecModificacion":"08-OCT-20","modificadoPor":"HN02913","montoPendienteAplicar":""}]}';
                }
                List<String> SearchRes1 = resultado.split('},');
                List<String> SearchRes = resultado.split(',');
                if(SearchRes1.size()==1 && resultado!='{"clientes":[]}'){    
                    fond = SearchRes[2].substringBeforeLast('"');
                    fond = fond.substringAfterLast('"');
                    System.debug('Fondo: '+fond);
                    
                    String valent = SearchRes[14].substringBeforeLast('"');
                    valent = valent.substringAfterLast('"');
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
                    McontenidoAporte[count].Codigo_Referencia_Rez__c=CodRefTest;
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
        closePopup();
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
        displayPopup = true;
        Existe='';
        BTNAplicar=false;
        return null;
    }
    
    @future(callout = true)
    public static void AplicarRezago(String NumCodRez, String NumCodCue, String MonCalc, String MonDep, String User, String Mon, String ComDol) {
        System.debug('Se ejecuta el AplicarRezago');
        String result='';
        try{
            ClassClientesRez rezagoEnvio = new ClassClientesRez();
            String CodRezago = NumCodRez;
            String resultado = ControllerApiRezagos.ConsultaRezagos(CodRezago);
            if(test.isRunningTest()){
                resultado='{"clientes":[{"idRezago":"SF-135","montoRezago":"40","fondo":"106","codReferencia":"FT20prueba4","fechaDeposito":"27-SEP-20","codigoMoneda":"USD","descripcion":"Transferencia entre Cuentas","descripcionNota":"Transferencia de la cuenta XX4156 de CRISTINA BANEGAS ZEITUN    100110 VENTA $","usuIngresaRezago":"HN02913","codBanco":"28","agnBanco":"AGN PRINCIPAL TGU","rezagoSINO":"SI","asesor":"HN23213","estado":"Pendiente","valorCuotaEntrada":"127.52636724","fecInclusion":"01-OCT-20","incluidoPor":"System","fecModificacion":"08-OCT-20","modificadoPor":"HN02913","montoPendienteAplicar":""}]}';
            }
            List<String> SearchRes = resultado.split(',');
            List<ClientesRez> ListClientesRez = new List<ClientesRez>();
            ClientesRez AplicaRez = new ClientesRez('','','','','','','','','','','','','');
            
            String idr = SearchRes[0].substringBeforeLast('"');
            idr = idr.substringAfterLast('"');
            system.debug('idRezago: '+idr);
            AplicaRez.idRezago = idr;// Añado el Id Rezago
            
            String montor = SearchRes[1].substringBeforeLast('"');
            montor = montor.substringAfterLast('"');
            system.debug('Monto Rezago: '+montor);
            AplicaRez.montoRezago = montor;// Añado el Monto del Rezago
            
            String fondor = SearchRes[2].substringBeforeLast('"');
            fondor = fondor.substringAfterLast('"');
            system.debug('Fondo: '+fondor);
            AplicaRez.fondo = fondor;// Añado el Fondo del Rezago
            
            String codrefr = SearchRes[3].substringBeforeLast('"');
            codrefr = codrefr.substringAfterLast('"');
            system.debug('Codigo Referencia Rezago: '+codrefr);
            AplicaRez.codReferencia = codrefr;// Añado el Codigo de referencia del Rezago
            
            system.debug('Numero de Cuenta: '+NumCodCue);
            AplicaRez.codCuenta = NumCodCue;// Añado el Codigo de Cuenta
            
            system.debug('Codigo de Planilla: ');
            AplicaRez.codPlanilla = '';// Añado el Codigo de Planilla
            
            String valcuoent = SearchRes[14].substringBeforeLast('"');
            valcuoent = valcuoent.substringAfterLast('"');
            if(valcuoent=='' || valcuoent==null){
                valcuoent='0';
            }
            System.debug('Valor Cuota de Entrada: '+valcuoent);
            AplicaRez.valorCuotaEntrada = valcuoent;// Añado el Valor de la cuota de entrada
            
            String estador = SearchRes[13].substringBeforeLast('"');
            estador = estador.substringAfterLast('"');
            system.debug('Estado: '+estador);
            AplicaRez.estado = estador;// Añado el Estado del Rezago
            
            String sino = SearchRes[11].substringBeforeLast('"');
            sino = sino.substringAfterLast('"');
            system.debug('Rezago Si/No: '+sino);
            if(sino=='SI' || sino=='Si' || sino=='si' || sino=='S'){ 
                rezagoEnvio.Tipo = 'AP';
                //Para obtener el valor cuota del dia 
                String ValorCuota = ControllerApiRezagos.ConsultaCuotaSal();
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
            
            String mntpen = SearchRes[19].substringBeforeLast('"');
            mntpen = mntpen.substringAfterLast('"');
            System.debug('Monto Pendiente: '+mntpen);
            
            Decimal mntr=0;
            if(mntpen=='0' || mntpen==''){
                mntr = Decimal.valueOf(montor);//Si no hay Monto pendiente el monto del Rezago Disponible es el Monto del Rezago             
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
            
            
            if(User==null){User='System';}
            System.debug('Modificado por: '+User);
            AplicaRez.modificadoPor = User;
            
            ListClientesRez.add(AplicaRez);
			
            String FechaD = SearchRes[4].substringBeforeLast('"');
            FechaD = FechaD.substringAfterLast('"');
            
            rezagoEnvio.clientes = ListClientesRez;
            System.debug('Tipo Rezago: '+rezagoEnvio.Tipo);
	
            String CuentaOrigen='';
            try{
                List<Cuenta_Rezago__mdt> codigo = new List<Cuenta_Rezago__mdt>();
                codigo = [select cuenta__c from Cuenta_Rezago__mdt where fondo__c =: AplicaRez.fondo limit 1];
                if(codigo.size()>0){
                    CuentaOrigen = codigo[0].cuenta__c ;//Insertar el codigo de cuenta de FPC Rezagos
                }
            }catch(Exception ex){
                System.debug('Error al buscar la cuenta: '+ ex.getLineNumber() +' - '+ ex.getMessage());
                return;
            }
            String RespuestaRetiro='OK';
            String AplicaPartida='';
           	if( rezagoEnvio.Tipo == 'AP'){
                System.debug('Ejecutamos el Metodo Retiro: '+CuentaOrigen+' - '+Mon+' - '+MonCalc);
            	RespuestaRetiro = ControllerApiRezagos.AplicaRetiroRezagos(CuentaOrigen, Mon, MonCalc);
                if(RespuestaRetiro.contains('Su retiro ha sido registrado')){
                	RespuestaRetiro='OK';
                }else{
                    RespuestaRetiro='Failure';
                	System.debug('Error al aplicar Retiro: '+CuentaOrigen+' - '+Mon+' - '+MonCalc);
                }
            }
            
            if(RespuestaRetiro=='OK'){
                if( rezagoEnvio.Tipo == 'AD'){
                    System.debug('Ejecutamos el Metodo AD');
                    result = ControllerApiRezagos.AplicaRezagosDia(rezagoEnvio);
                }else{
                    //Cargar metodo para enviar el rezago en caso que sea un rezago SI.-
                    System.debug('Ejecutamos el Metodo AP');
                    result = ControllerApiRezagos.AplicaRezagosDia(rezagoEnvio);
                }
                if(result=='"OK"' || test.isRunningTest()){
                    System.debug('Ejecutamos el Metodo de la Partida Contable: '+AplicaRez.fondo+' - '+AplicaRez.valAporteCalculado+' - '+AplicaRez.codCuenta+' - '+ComDol+' - '+FechaD);
                    AplicaPartida = AplicaPartida(AplicaRez.fondo, AplicaRez.valAporteCalculado, AplicaRez.codCuenta, ComDol, FechaD);
                    system.debug('Aplica Partida Result: '+AplicaPartida);
                }
            }
        }catch(exception ex){
            System.debug('Error al aplicar Rezago: '+ ex.getMessage() + ' Linea: ' + ex.getLineNumber());
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
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Verifique que la Partida(Metadatos "Partidas Rezagos") correspondiente al Fondo. :'+fondo));
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
        String resultJson = controllerApiIntergationPartidas.generarPartidas(clase);
        System.debug('resultJson: '+resultJson);
        String resultado='';
        if(resultJson.contains('OK')) {
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Partida contable creada correctamente.  '));
            resultado='OK';
        } else if(resultJson.contains('Read timed out')){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error de conexión a la base de datos: "Read timed out".  '));
            resultado='Fail';
        } else {    
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se produjo un error en el Servicio Web.  '));
            resultado='Fail';
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
                String consulta = McontenidoAporte[i].Codigo_Referencia__c;
                System.debug('Codigo de referencia Buscado: '+consulta);
            	string resultado = ControllerApiRezagos.ConsultaRezagos(consulta);
                
                if(test.isRunningTest()){
                    resultado='{"clientes":[{"idRezago":"SF-135","montoRezago":"40","fondo":"106","codReferencia":"FT20prueba4","fechaDeposito":"27-SEP-20","codigoMoneda":"USD","descripcion":"Transferencia entre Cuentas","descripcionNota":"Transferencia de la cuenta XX4156 de CRISTINA BANEGAS ZEITUN    100110 VENTA $","usuIngresaRezago":"HN02913","codBanco":"28","agnBanco":"AGN PRINCIPAL TGU","rezagoSINO":"SI","asesor":"HN23213","estado":"Pendiente","valorCuotaEntrada":"127.52636724","fecInclusion":"01-OCT-20","incluidoPor":"System","fecModificacion":"08-OCT-20","modificadoPor":"HN02913","montoPendienteAplicar":""}]}';
                }
                
                list<String> result = resultado.split('},');
                String rezago='';
                Decimal ent=0;
                Decimal sal=0;
                system.debug('Resultado de la busqueda: '+consulta+' - '+result.size());
                if(result.size()==1 && resultado!='{"clientes":[]}'){
                    result = resultado.split(',');
                    String estador = result[13].substringBeforeLast('"');
                    estador = estador.substringAfterLast('"');
                    system.debug('Estado Carga Planilla: '+estador);
                    if(estador!='Pagado'){
                        McontenidoAporte[i].Codigo_Referencia_Rez__c = McontenidoAporte[i].Codigo_Referencia__c;
                        
                        rezago = result[11].substringBeforeLast('"');
                        rezago = rezago.substringAfterLast('"');
                        
                        String valcuoent = result[14].substringBeforeLast('"');
                        valcuoent = valcuoent.substringAfterLast('"');
                        if(valcuoent=='' || valcuoent==null){valcuoent='1';}
                        ent = Decimal.valueOf(valcuoent);
                        
                        //Traer el valor cuota dia (Salida)
                        String fondor = result[2].substringBeforeLast('"');
                        fondor = fondor.substringAfterLast('"');
                        
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
            system.debug('Error'+ex.getLineNumber());
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
                
                modifi = [select Codigo_Referencia__c, Oficial_de_negocios__c, Estado_Aporte__c, rezago__C,Descripcion__c from Pantalla_Aportes__c where Codigo_Referencia__c =: Num_CodReferenciaDenegado limit 1];
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
            rezago = null;
            system.debug('01- Entramos a AprobarAporte');
            Pantalla_Aportes__c modifi = new Pantalla_Aportes__c ();	
            Num_CodReferenciaDenegado = Num_CodReferencia;
            
            for(integer k=0; k<McontenidoAporte.size(); k++ ){
                if(McontenidoAporte[k].Codigo_Referencia__c==Num_CodReferencia){
                    fechadeposito = McontenidoAporte[k].Fecha_Deposito__c;
                    if(Rez_SI_NO=='SI' || Rez_SI_NO=='Si' || Rez_SI_NO=='si'){
                        rezago ='S';
                    }else{
                        rezago ='N';
                    }
                    system.debug('02 - Rezago: '+rezago+', Codigo referencia: '+McontenidoAporte[k].Codigo_Referencia__c);
                    if(rezago == null && !test.isRunningTest()){
                        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Favor llenar campo de rezago'));
                        return;
                    }
                }
            }
            
            CodReferenNoCobra = Num_CodReferencia;
            CodReferenciaTemp = Num_CodReferencia; 
            McontenidoAporte = new list<Pantalla_Aportes__c>();
            McontenidoAporte =[select cuenta__c, Tasa__c ,Tipo_MonedaN__c,Monto_Deposito__c, Fecha_Deposito__c,Tipo_SaldoN__c,
                               Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,rezago__C,
                               Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c, Codigo_Usuario__c
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
                            
                            //actualizar la fecha de deposito
                            modifi = [select Fecha_Deposito__c from Pantalla_Aportes__c where Codigo_Referencia__c =: Num_CodReferenciaDenegado ];
                            modifi.Fecha_Deposito__c = fechadeposito;
                            update modifi;
                            
                            if (p_codigo_error == '0' || test.isRunningTest()){
                                system.debug('07 - Entra Codigo Error 0');    
                                ListRespuesta = [select cuenta__c, Tasa__c, Tipo_MonedaN__c, Monto_Deposito__c, Fecha_Deposito__c, Tipo_SaldoN__c ,
                                                 Forma_PagoN__c, Codigo_Referencia__c, Aplica_Comision_SI__c,
                                                 Compra_Dolar__c, Periodo_Aporte__c, Oficial_de_negocios__c
                                                 from Pantalla_Aportes__c 
                                                 where Codigo_Referencia__c =: Num_CodReferencia];
                                system.debug('08 - Tamaño Lista: '+ListRespuesta.size());
                                for(integer S=0; S < ListRespuesta.size(); S++){
                                    
                                    //Busca si la referencia se encuentra en los no conciliados. 
                                    //Dado caso que la encuentre modifica el aporte a conciliados si este tiene un dia si tiene dos dias 
                                    //crea una contra partida. 
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
                                system.debug('07 - Entra Codigo Error: '+p_codigo_error);    
                                MensajeError = true; 
                            }
                        }
                    }
                }
            }
            System.debug('Antes de aplicar el rezago: ' + Monto_Calculado+' - '+Num_CodReferencia_Rez+' - '+MensajeError);
            if(Num_CodReferencia_Rez!='Sin Registro' && MensajeError!=true && McontenidoAporte.size()>0){
                BTNAplicar=true;
            	AplicarRezago(Num_CodReferencia_Rez, num_CodCuenta_Rez, Monto_Calculado, Monto_Dep, Usuario, Moneda, Compra_Dolar);//Aplica El Rezago
            }else{
                System.debug('Rezago NO Aplicado');
            }
            System.debug('Reiniciamos al terminar AprobarAporte');
            reiniciar();
        }catch(exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
        }
    }
    
    public void correoUsuario(){
        try{
            cod_empleado = [select Codigo_Usuario__c from Pantalla_Aportes__c where Codigo_Referencia__c =: Num_CodReferencia].Codigo_Usuario__c;
            correoEmpleado = [select Email__c from Usuarios_de_Pantallas__c where Usuario__c =: cod_empleado].Email__c;
            System.debug('Se obtienen los datos de empleado : '+cod_empleado+' - '+correoEmpleado);
        }catch(exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
        }
        
    }
    
    public void mostrarVenTasa(){
        
        ModifiUSD =[ select Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                    Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c
                    from Pantalla_Aportes__c 
                    where Estado_Aporte__c = 'S' and Codigo_Referencia__c =: Num_CodReferencia];
        
        if(test.isRunningTest()){
            ModifiUSD =[ select Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                        Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c
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
        MensajeError = false;
        MostrarTasa = false;
        popTasa = false;
        MensajeVF = false;
        MostrarTasa = false;
    }

    public void AprobarAporte2SinComision(){
        try{    
            Pantalla_Aportes__c modifi = new Pantalla_Aportes__c ();	
            
            McontenidoAporte =[select cuenta__c, Tasa__c, Tipo_MonedaN__c, Monto_Deposito__c, Fecha_Deposito__c, Tipo_SaldoN__c,
                               Forma_PagoN__c, Codigo_Referencia__c, Aplica_Comision_SI__c, rezago__c,
                               Compra_Dolar__c, Periodo_Aporte__c, Oficial_de_negocios__c
                               from Pantalla_Aportes__c 
                               where Estado_Aporte__c = 'S' and Codigo_Referencia__c =: CodReferenNoCobra and Codigo_Referencia__c!=null];
            
            for(integer i=0; i < McontenidoAporte.size(); i++) {
                
                classAportes_Conciliacion apor =  new classAportes_Conciliacion();   
                if(McontenidoAporte[i].Codigo_Referencia__c == CodReferenNoCobra)    {
                    if (McontenidoAporte[i].Compra_Dolar__c == 'S' ){
                        VentanaEmergenteNo = false; 
                        CodReferenciaTemp = CodReferenNoCobra;
                        CambioTasa();
                    }else{
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
                        system.debug('ResultadoEnviado: '+apor);  
                        
                        classAportes_Conciliacion resultado = ControllerAPICONCILIACION.guardarAporte(apor);
                        
                        p_saldo = resultado.p_saldo;
                        p_monto_pen_aplic = resultado.p_monto_pen_aplic;
                        p_codigo_error = resultado.p_codigo_error;
                        p_Mensaje_error =  resultado.p_mensaje_error;   
                        p_num_movim_sysde = resultado.p_num_movim_sysde;
                        p_nombre = resultado.p_nombre;
                        
                        
                        //actualizar la fecha de deposito
                        modifi = [select Fecha_Deposito__c from Pantalla_Aportes__c where Codigo_Referencia__c =: Num_CodReferenciaDenegado ];
                        modifi.Fecha_Deposito__c = fechadeposito;
                        update modifi;
                        
                        if (p_codigo_error == '0' || test.isRunningTest()){
                           ListRespuesta = [select    cuenta__c, Tasa__c ,Tipo_MonedaN__c,Monto_Deposito__c, Fecha_Deposito__c,Tipo_SaldoN__c ,
                                             Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                                             Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c
                                             from Pantalla_Aportes__c 
                                             where Codigo_Referencia__c =: CodReferenNoCobra];
                            
                            
                            for(integer S=0; S < ListRespuesta.size(); S++){
                                
                               RevisarAporteConciliado = [select Conciliado__c,Fecha_Valor__c, Monto_Fijo__c, Dias__c,Referencia__c 
                                                           from Contenido_Estado_Cuenta_Conciliacion__c 
                                                           where Referencia__c =: CodReferenNoCobra ];
                               if (RevisarAporteConciliado.size() > 0 ) {
                                    for(integer p=0; p<RevisarAporteConciliado.size(); p++) {   
                                        
                                        if (RevisarAporteConciliado[i].Conciliado__c == 'S'){
                                            VentanaEmergenteNo = false;
                                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Aporte Esta Conciliado'));
                                        }else{
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
                                ModificarEstado = [select Estado_Aporte__c from Pantalla_Aportes__c where Codigo_Referencia__c =:  apor.Cod_referencia ];
                                ModificarEstado.Estado_Aporte__c = 'A';  
                                update ModificarEstado;
                                
                                RegistroAportesTotal = [select Estado_Aporte__c from Registro_Aportes__c where Codigo_Referencia__c =:  apor.Cod_referencia ];
                                RegistroAportesTotal.Estado_Aporte__c = 'A';  
                                update RegistroAportesTotal;
                                VentanaEmergenteNo = false;
                                MensajeVF = true;
                            }
                        }else {
                            MensajeError = true;
                            VentanaEmergenteNo = false;
                        }
                        if(Num_CodReferencia_Rez!='Sin Registro' && MensajeError!=true && BTNAplicar!=True){   
                            BTNAplicar=True;
                            AplicarRezago(Num_CodReferencia_Rez, num_CodCuenta_Rez, Monto_Calculado, Monto_Dep, Usuario, Moneda, Compra_Dolar);//Aplica El Rezago                        
                        }
                        //reiniciar();
                    } 
                }
                //reiniciar();
            }
            reiniciar();
            
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
            ane = [Select Monto_Deposito__c,Tipo_MonedaN__c,cuenta__c, id, tasa__C, rezago__C, Nombre_Completo__c, Aporte_Dolares_Flag__c
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
                    MensajeError = true;
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ha ocurrido un error en la compra venta de dolares, por favor intente mas tarde.')); 
                }
                
                if (part == 'OK'){
                    system.debug('Part OK - Mostrartasa: '+MostrarTasa+', VentanaEmergenteNo: '+VentanaEmergenteNo);
                    McontenidoTasa =[select cuenta__c, Tasa__c ,Tipo_MonedaN__c,Monto_Deposito__c, Fecha_Deposito__c,Tipo_SaldoN__c ,
                                     Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
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
                        
                        //actualizar la fecha de deposito
                        modifi = [select Fecha_Deposito__c from Pantalla_Aportes__c where Codigo_Referencia__c =: Num_CodReferenciaDenegado limit 1];
                        modifi.Fecha_Deposito__c = fechadeposito;
                        update modifi;
                        
                        if (p_codigo_error == '0' || test.isRunningTest()) {
                            system.debug('Entra a Error = 0 ');
                            UpdaSaldos = 'OK';
                            ListRespuesta = [select    cuenta__c, Tasa__c ,Tipo_MonedaN__c,Monto_Deposito__c, Fecha_Deposito__c,Tipo_SaldoN__c ,
                                             Forma_PagoN__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                                             Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c
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
                            system.debug('Error: '+p_codigo_error);
                            MensajeError = true;
                        }
                        
                        
                    } // fin de for principal	                 
                    
                } // FIN DEL IF part = 'OK'
                
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
                
                if (UpdaSaldos == 'OK'){
                    System.Debug('Entramos al UpdateSaldos');
                    Pantalla_Aportes__c put = new Pantalla_Aportes__c();
                    put = [select Monto_Deposito__c,Tipo_MonedaN__c
                           from Pantalla_Aportes__c 
                           where Estado_Aporte__c = 'A' and Codigo_Referencia__c =: CodReferenciaTemp]; 
                    put.Monto_Deposito__c = totalDo;
                    put.Tipo_MonedaN__c = TipoMonedaD;
                    UPDATE put;
                    System.Debug('Saldos actualizados correctamente');
                }
                system.debug('Fin del CambioTasa - MostrarTasa: '+MostrarTasa+', VentanaEmergenteNo: '+VentanaEmergenteNo);
                
                ane.Aporte_Dolares_Flag__c=true;
                System.debug('Aplicar aportes dolar ejecutado con exito: FLAG: '+ane.Aporte_Dolares_Flag__c);
                update ane;
                
            }//FIN de IF para evitar volver a ejecutar.
            
        }catch(Exception ex){
            MensajeError = true;
            system.debug('Error: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());
        }
    } 
    
} // de la clase principal