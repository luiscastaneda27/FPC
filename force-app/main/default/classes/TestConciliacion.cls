@isTest //(seeAllData=true)
public class TestConciliacion {

    static testMethod void ControllerConciliacionAprobacionM(){
        
        Pantalla_Aportes__c a = new Pantalla_Aportes__c(Estado_Aporte__c = 'S', Tipo_Moneda__c = '1', Codigo_Referencia__c='FPC123',Monto_Deposito__c = 55.98, Aplica_Comision_SI__c = 'N', Codigo_Usuario__c = 'HN19577');
        insert a;
        
        Pantalla_Aportes__c aa = new Pantalla_Aportes__c(Compra_Dolar__c = 'N', Estado_Aporte__c = 'S', Tipo_Moneda__c = '1', Codigo_Referencia__c='FPC222',Monto_Deposito__c = 55.98);
        insert aa;
        
        Contenido_Estado_Cuenta_Conciliacion__c p = new Contenido_Estado_Cuenta_Conciliacion__c(Monto_Fijo__c = 58.23, Monto_Pendiente__c = 58.23, Tipo_Planilla__c='HNL',Referencia__c = 'FPC123');
        insert p;
        
        Contenido_Estado_Cuenta_Conciliacion__c pT = new Contenido_Estado_Cuenta_Conciliacion__c(Monto_Fijo__c = 58.23, Monto_Pendiente__c = 58.23, Tipo_Planilla__c='USD',Referencia__c = 'FPC1234');
        insert pT;  
        
        Registro_Aportes__c hy = new Registro_Aportes__c(name='csdcsd', Codigo_Referencia__c ='QWER', Estado_Aporte__c='A'); 
        insert hy;
        Pantalla_Aportes__c WW = new Pantalla_Aportes__c(Estado_Aporte__c = 'S', Codigo_Referencia__c = 'JKL', Tasa__c = 24.5, Tipo_Moneda__c = '1', Monto_Deposito__c = 345,Compra_Dolar__c = 'S');
        insert WW;  
        
        Pantalla_Aportes__c XX = new Pantalla_Aportes__c(Estado_Aporte__c = 'S', Codigo_Referencia__c = 'QWER', Tasa__c = 24.5, Tipo_Moneda__c = '1', Monto_Deposito__c = 345, Compra_Dolar__c = 'N');
        insert XX;  
        
        Pantalla_Aportes__c gdfd = new  Pantalla_Aportes__c();
        insert gdfd;
        
        test.startTest();        
        ControllerConciliacionAprobacionM mm = new ControllerConciliacionAprobacionM();         
        
        //Rezagos
        mm.CodRef='FPC123';
        mm.CodRefTest='FPC123';
        mm.Monto_Dep='40';
        mm.Monto_Calculado='40';
        mm.Num_CodCuenta_Rez='100110';
        //
        
        Pantalla_Aportes__c nw = new Pantalla_Aportes__c();
        Contenido_Estado_Cuenta_Conciliacion__c BB =  NEW Contenido_Estado_Cuenta_Conciliacion__c();
        mm.ContenidoAporte = nw;
        mm.ModificarEstado = nw;
        
        mm.ModificarTas = nw;
        mm.ImagenMostrar = nw;
        MM.AgregarAporte_A_Conciliados = BB;
        mm.NombreAsesor = 'HN22902';
        mm.total = 18;
        mm.FechaActual = date.today();
        mm.DenegarVentana = true;
        mm.Motivo = '';
        mm.Num_CodReferenciaDenegado = '';
        mm.Num_CodReferencia = 'FPC123';
        mm.p_periodo_aporte = 20180101;
        mm.Ver_Imagen = '';
        mm.DenegarImagen = true;
        mm.Usuario = 'HN22902';
        MM.MensajeVF = TRUE;
        MM.MensajeError = FALSE;
        mm.p_saldo = '';
        mm.p_monto_pen_aplic = '';
        
        mm.p_Mensaje_error = '0';
        mm.p_num_movim_sysde = '';
        mm.p_nombre = '';
        mm.CompraDolar = 58.00;
        mm.MotrarBtn  =true;
        mm.BloqAcep = true;
        mm.MostrarTasa = true;
        mm.CodReferenVentana = 'FPC123';
        mm.PC_Observaciones = '';
        mm.pCU_Rezagos = '';
        mm.pCU_Contable= '';
        mm.MostrarVenta12 = true;
        mm.CodReferenciaTemp  ='JKL';
        mm.CodReferenNoCobra ='QWER';
        mm.UpdaSaldos = 'OK';
        mm.CodReferenciaTemp = 'QWER';
        mm.CodAsesor='';
        
        
        mm.AprobarAporte2SinComision();
        
        //Metodos
        mm.MostraVentaEsconder();
        mm.MostraVentana();
        mm.popDenegarSalir();
        mm.popSalirImagen();
        mm.DenegarLista();
        mm.MostrarVentanaDenegacion();
        mm.CerraVentanaDenegacion();
        // mm.cerrarVentanada();
        mm.Cerrar();
        mm.mostrarVenTasa();
        mm.MostrarImagen();
        //mm.AprobarAporte2SinComision();
        
        mm.PC_Observaciones = 'aporte malo';
        mm.CodReferenVentana = 'FPC123';
        mm.ConciliarIndividual2dias();
        mm.PC_Observaciones = 'aporte malo';
        mm.CodReferenVentana = 'FPC1234';
        mm.ConciliarIndividual2dias();         
        
        mm.Num_CodReferencia = 'FPC222';
        mm.AprobarAporte();
        
        mm.Cerrar();
        
        mm.CompraDolar = 55;
        mm.part = 'OK';
        mm.p_codigo_error = '0';
        mm.CambioTasa();
        
        
        mm.CompraDolar = 55;
        mm.part = 'S';
        mm.CambioTasa();
        
        //-------------------api
        List<ControllerAPICONCILIACION.classAportesCuenta> LAC = new List<ControllerAPICONCILIACION.classAportesCuenta>();
        ControllerAPICONCILIACION.classRespuestaAportesCuenta rp = new ControllerAPICONCILIACION.classRespuestaAportesCuenta();
        rp.identificacion='158';
        rp.cuentas= LAC;
        List<ControllerAPICONCILIACION.classRespuestaAportesCuenta> Lrp = new List<ControllerAPICONCILIACION.classRespuestaAportesCuenta>();
        ControllerAPICONCILIACION.Prueba prueba = new ControllerAPICONCILIACION.Prueba();
        prueba.aportes=Lrp;
        ControllerAPICONCILIACION.RespuestaPartidaConta rPartida = new ControllerAPICONCILIACION.RespuestaPartidaConta();  
        rPartida.NuAsiento='lk'; 
        rPartida.P_ERROR='lk';
        rPartida.Referencia='lk';
        rPartida.RespuestaConciliado='lk';
        ControllerAPICONCILIACION.RespuestaAporte rAporte = new ControllerAPICONCILIACION.RespuestaAporte();  
        rAporte.NuAsiento='lk'; 
        rAporte.P_ERROR='lk';
        rAporte.Referencia='lk';
        rAporte.RespuestaConciliado='lk';
        ControllerAPICONCILIACION.classRespuestaImagen RImagen = new ControllerAPICONCILIACION.classRespuestaImagen(); 
        RImagen.codigo=15;
        RImagen.mensaje='564';
        RImagen.imagen='jh';
        ControllerAPICONCILIACION.RespuestaImagen RImagen2 = new ControllerAPICONCILIACION.RespuestaImagen(); 
        RImagen2.pc_Imagen='15';
        RImagen2.Cod_referencia='564';
        RImagen2.p_Error='jh';
        ControllerAPICONCILIACION.classRespuestaConciliacion Rconci1 = new ControllerAPICONCILIACION.classRespuestaConciliacion(); 
        Rconci1.Conciliado='15';
        Rconci1.Referencia='564';
        Rconci1.Error='jh';
        ControllerAPICONCILIACION.classCargaEC_Respuesta_Conciliacion Rconci2 = new ControllerAPICONCILIACION.classCargaEC_Respuesta_Conciliacion(); 
        Rconci2.Conciliado='15';
        Rconci2.Referencia='564';
        Rconci2.Mensaje='jh';
        ControllerAPICONCILIACION.ClassTraerCuentaContable trae = new ControllerAPICONCILIACION.ClassTraerCuentaContable(); 
        trae.Cu_Rezagos='15';
        trae.Cu_Bancos='564';
        List<classCuenta> ct= new List<classCuenta>();
        ControllerAPICONCILIACION.classPersonas persona = new ControllerAPICONCILIACION.classPersonas(); 
        persona.identidad='15';
        persona.cuentas=ct;
        ControllerAPICONCILIACION.ClassListaAporte Lap = new ControllerAPICONCILIACION.ClassListaAporte(); 
        Lap.Error='564';
        // ControllerAPICONCILIACION.TraerAporte TLap = new ControllerAPICONCILIACION.TraerAporte('string' ,  'TipoMoneda'); 
        ControllerAPICONCILIACION.classImagenReferencia ImaR = new ControllerAPICONCILIACION.classImagenReferencia(); 
        ImaR.Imagen='564';
        ControllerAPICONCILIACION.FechaClass Fecha = new ControllerAPICONCILIACION.FechaClass(); 
        Fecha.FechaVa= date.today();
        ControllerAPICONCILIACION.ClassContableTemp conta = new ControllerAPICONCILIACION.ClassContableTemp(); 
        conta.Conciliado='15';
        conta.Referencia='564';
        conta.TipoFondo='jh';
        conta.FechaPosteo = date.today();
        conta.FechaValor = date.today();
        conta.Monto =1.0;
        conta.Pc_Dia =1.0;
        conta.pCU_Contable ='jh';
        conta.pCU_Rezagos ='jh';
        conta.PC_Observaciones ='jh';
        conta.pc_Usuario ='jh';
        
        ControllerAPICONCILIACION.AporteBD_Agregar ABD = new ControllerAPICONCILIACION.AporteBD_Agregar();
        ABD.ComisionSi='s';
        ABD.Cod_referencia='h';
        ABD.pc_pc_AplicaDolar='h';
        ABD.Cuenta='h';
        ABD.pc_DESCRIPCION='';
        ABD.pc_ESTADO_APORTE='l';
        ABD.FechaDepositoAproba = date.today();
        ABD.PC_FECHA_INGRESO_SISTEMA = date.today();
        ABD.FormaPago ='l';
        ABD.Monto ='l';
        ABD.NombreCompleto ='l';
        ABD.pc_OFICIAL_DE_NEGOCIOS ='l';
        ABD.p_periodo_aporte ='l';
        ABD.Moneda ='l';
        ABD.TipoSaldo ='l';
        ABD.pc_Imagen ='l';
        ABD.FechaDeposito= date.today();
        ABD.p_saldo='l';
        ABD.p_monto_pen_aplic='l';
        ABD.p_num_movim_sysde ='l';
        ABD.p_nombre ='l';
        ABD.p_codigo_error ='l';
        ABD.p_Error ='l';
        
        classAportes_Conciliacion aprobacion = new classAportes_Conciliacion();
        aprobacion.ComisionSI ='';
        aprobacion.Cod_referencia ='';
        aprobacion.pc_pc_AplicaDolar ='';
        aprobacion.Cuenta ='';
        aprobacion.pc_DESCRIPCION ='';
        aprobacion.pc_ESTADO_APORTE ='';
        aprobacion.FechaDepositoAproba =date.today();
        aprobacion.PC_FECHA_INGRESO_SISTEMA =date.today();
        aprobacion.FormaPago ='';
        aprobacion.Monto ='';
        aprobacion.NombreCompleto ='';
        aprobacion.pc_OFICIAL_DE_NEGOCIOS ='';
        aprobacion.p_periodo_aporte ='';
        aprobacion.Moneda ='';
        aprobacion.TipoSaldo ='';
        aprobacion.pc_Imagen ='';
        aprobacion.rezago ='';
        aprobacion.FechaDeposito =date.today();
        aprobacion.p_saldo ='';
        aprobacion.p_monto_pen_aplic ='';
        aprobacion.p_num_movim_sysde ='';
        aprobacion.p_nombre ='';
        aprobacion.p_codigo_error ='';
        aprobacion.p_mensaje_error ='';
        
        ControllerAPICONCILIACION.ListaBitaaa ListB = new ControllerAPICONCILIACION.ListaBitaaa();
        
        ControllerAPICONCILIACION.fechaCierreSysdeComparar(); 
        ControllerAPICONCILIACION.fechaCierreSysdeTraer();
        ControllerAPICONCILIACION.InsertaBitacoraConci(ListB); 
        ControllerAPICONCILIACION.GuardarEnBitacoraSYSDE(ListB);
        ControllerAPICONCILIACION.BuscaCuentaConta('98564');
        classAportes_Conciliacion fcsd = ControllerAPICONCILIACION.BuscarCuenta('58602');
        ControllerAPICONCILIACION.guardarAporte(fcsd);
        ControllerAPICONCILIACION.BuscarAporte(fcsd);
        ControllerAPICONCILIACION.ConsultalAportesPatronales('98564'); 
        ClassEnviarConciliacionLista EnvConcilia=new ClassEnviarConciliacionLista();
        ControllerAPICONCILIACION.ConsultaCEConciliados(EnvConcilia);
        ClassListaPartii listP= new ClassListaPartii();
        ControllerAPICONCILIACION.CreaPartidaDolaar(listP);
        ControllerAPICONCILIACION.CreaPartidaDolaarNoConcilia(listP);
        ControllerAPICONCILIACION.TraerImagenBD('listP');
        ControllerAPICONCILIACION.CreaPartidaDebiNoConcilia(listP);
        ControllerAPICONCILIACION.CreaPartidaDebi(listP);  
        classConciliacionEstadoCuenta pao = new classConciliacionEstadoCuenta(DATE.today(), '', '', DATE.today(), 1,'', '', '');
        ClassListaPartii ax = new ClassListaPartii();
        ClassPartidaContable ha = new ClassPartidaContable ('', DATE.today(), '', '', DATE.today(), 1, '', '', '', '', 1);
        
        //Rezagos
        mm.showPopup();
        mm.SearchValores();
        mm.aplicar();
        ControllerApiRezagos.AplicaRetiro('FPC222', '1', '400');
        
        test.stopTest(); 
    }
    
}