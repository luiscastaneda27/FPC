@isTest //(seeAllData=true)
public class TestConciliacion {

    
    
     static testMethod void ControllerConciliacionAprobacionM()
     {
         
        Pantalla_Aportes__c a = new Pantalla_Aportes__c(Estado_Aporte__c = 'S', Tipo_Moneda__c = '1', Codigo_Referencia__c='FPC123',Monto_Deposito__c = 55.98, Aplica_Comision_SI__c = 'N', Codigo_Usuario__c = 'HN19577');
        insert a;
        /*
		Pantalla_Aportes__c panta = new Pantalla_Aportes__c(cuenta__c='98657', Tasa__c=1.0 ,Tipo_Moneda__c= '1',Monto_Deposito__c= 65.98, Fecha_Deposito__c=date.today(),TIPO_SALDO__c='18' ,
                                           Forma_de_Pago__c='PL',Codigo_Referencia__c='FPC123',Aplica_Comision_SI__c='N',Compra_Dolar__c= NULL, Periodo_Aporte__c='M',Oficial_de_negocios__c='HN12528');   
            insert panta;                    
		*/
         
        Pantalla_Aportes__c aa = new Pantalla_Aportes__c(Compra_Dolar__c = 'N', Estado_Aporte__c = 'S', Tipo_Moneda__c = '1', Codigo_Referencia__c='FPC222',Monto_Deposito__c = 55.98);
        insert aa;
         
         Contenido_Estado_Cuenta_Conciliacion__c p = new Contenido_Estado_Cuenta_Conciliacion__c(Monto_Fijo__c = 58.23, Monto_Pendiente__c = 58.23, Tipo_Planilla__c='HNL',Referencia__c = 'FPC123');
        insert p;
        
        Contenido_Estado_Cuenta_Conciliacion__c pT = new Contenido_Estado_Cuenta_Conciliacion__c(Monto_Fijo__c = 58.23, Monto_Pendiente__c = 58.23, Tipo_Planilla__c='USD',Referencia__c = 'FPC1234');
        insert pT;  
        
		Registro_Aportes__c hy = new Registro_Aportes__c(name='csdcsd'); 
         insert hy;
        Pantalla_Aportes__c WW = new Pantalla_Aportes__c(Estado_Aporte__c = 'S', Codigo_Referencia__c = 'JKL', Tasa__c = 24.5, Tipo_Moneda__c = '1', Monto_Deposito__c = 345,Compra_Dolar__c = 'S');
        insert WW;  
         
        Pantalla_Aportes__c XX = new Pantalla_Aportes__c(Estado_Aporte__c = 'S', Codigo_Referencia__c = 'QWER', Tasa__c = 24.5, Tipo_Moneda__c = '1', Monto_Deposito__c = 345, Compra_Dolar__c = 'N');
        insert XX;  
         
        Pantalla_Aportes__c gdfd = new  Pantalla_Aportes__c();
         insert gdfd;
        test.startTest();        
        ControllerConciliacionAprobacionM mm = new ControllerConciliacionAprobacionM();         
         
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
         mm.cerrarVentanada();
         mm.CerraError();
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
         
         mm.CerrarVentana();
         
         mm.CompraDolar = 55;
         mm.part = 'OK';
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
         test.stopTest(); 
     }
        
/*
    static testMethod void ControllerConciliacionAportesssss(){
		Bitacora_Conciliacion__c a = new Bitacora_Conciliacion__c(Actividades__c = 'En', Usuario__c = 'HN22902' , Fecha__c = DATE.today());
        insert a;        
 
        test.startTest();
        
        ControllerConciliacionAportes aport = new ControllerConciliacionAportes();
        //Public Account TipoMoneda{get;set;}
        aport.CompraDolarSI = true;
        APORT.Comprobante = BLOB.valueOf('ASKHDSABJHSADBSAJHDBSAASDAS');
        aport.Cuenta = null;
        aport.NombreCompleto = null;
        aport.Moneda = null;
        aport.FechaDeposito = null;
        aport.Monto = null;
        //aport.TipoSaldo = Account;
        //aport.FormaPago = 'TL';
        aport.Cod_referencia = null;
        aport.p_periodo_aporte = null;
        aport.BloqueaSI = true;
        aport.BloqueaNO = false;
        aport.ComisionSI = true;
        aport.ComisionNO = true;
        //aport.ListAportes
        aport.Usuario = 'jn12';
        aport.AplicaComision();
        aport.BuscarInfor();
        aport.BuscarPeriodo();
        aport.cancelar();
        aport.ComisionVaciasNO();
        APORT.ComisionVaciasSI();
        aport.NADADOLAR();
        aport.NOAplicaComision();
        aport.CompraDNO();
        aport.CompraDSI();
        //aport.ListAportes
        
        
        
        aport.hy = 'HDSABHSDABDSJH';
        aport.TiSaldo = '';
        aport.FoPago = 'CK';
        aport.TraerAportee();
        Pantalla_Aportes__c Ba = new Pantalla_Aportes__c(cuenta__c='812456',Nombre_Completo__c='acaaa',Tipo_Moneda__c='1', Fecha_Deposito__c = date.today(),
                                                        Monto_Deposito__c = 25, TIPO_SALDO__c = '10', Forma_de_Pago__c ='TL',  Codigo_Referencia__c= 'AKJ', Periodo_Aporte__c= '20180101',Fecha_Ingreso_Sistema__c = DATE.today(),Oficial_de_negocios__c = 'hn2234' );
        insert Ba;
        
        classAportes_Conciliacion NU = NEW classAportes_Conciliacion();
        NU.Cod_referencia ='';
        NU.ComisionSI = '';
        NU.Cuenta='';
        NU.FechaDeposito = DATE.today();
        NU.FechaDepositoAproba = DATE.today();
        NU.FormaPago='';
        NU.Moneda = '';
        NU.Monto = NULL;
        NU.NombreCompleto = '';
        NU.p_codigo_error = '';
        nu.p_mensaje_error = '';
        nu.p_monto_pen_aplic = '';
        nu.p_nombre = '';
        nu.p_saldo = '';
        nu.pc_DESCRIPCION = '';
        nu.pc_ESTADO_APORTE = '';
        nu.PC_FECHA_INGRESO_SISTEMA = date.today();
        nu.pc_Imagen = '';
        nu.pc_OFICIAL_DE_NEGOCIOS = '';
        nu.pc_pc_AplicaDolar = '';
        nu.TipoSaldo = '';
        
  //FIN TEST 
       
       
      classAportes_Conciliacion fcsd = ControllerAPICONCILIACION.BuscarCuenta('58602');
      
       Registro_Aportes__c hapt = new   Registro_Aportes__c();
       hapt.cuenta__c = '58602';
       hapt.Nombre_Completo__c =  'acerrato';
       hapt.Tipo_Moneda__c =  '1';
       hapt.Fecha_Deposito__c =  date.today();
       hapt.Monto__c =  double.valueOf('10.2');
       hapt.TIPO_SALDO__c = '10';
       hapt.Forma_de_Pago__c = 'TL';
       hapt.Codigo_Referencia__c =  'ASYADSH';
       hapt.Periodo_Aporte__c =    '2018063';
       hapt.Fecha_Ingreso_Sistema__c = datetime.now();   
        
		insert hapt;
        aport.Guardar(); 
        aport.cancelar();
        test.stopTest();
     }

    
    static testMethod void ControllerConciliacionAportesCase2(){
        
        test.startTest();
        ControllerConciliacionAportes pp = new ControllerConciliacionAportes();  
       
         pp.Cuenta = '';
         pp.NombreCompleto = null;
         pp.FechaDeposito = null;
         pp.TiSaldo = '--Ninguno--';
         pp.FoPago = '--Ninguno--';
         pp.Cod_referencia = '' ;
         pp.Monto = null;
         pp.Monto = 0.0;      
         
         pp.Guardar();
         
         pp.Cuenta = '12312321';
         pp.NombreCompleto = 'akkaka';
         pp.FechaDeposito = date.today();
         pp.TiSaldo = '10';
         pp.FoPago = 'TL';
         pp.Cod_referencia = '132132';
         pp.Monto = 55;      
         
         pp.Guardar();
         
         
        test.stopTest();
     }*/
    
    /*TEST Aportes Denegados*/
  /*
    static testmethod void ControllerConciliacionAportesDenegados (){
        
        Pantalla_Aportes__c a = new Pantalla_Aportes__c(Codigo_Referencia__c = '12345', cuenta__c='58600',Tipo_Moneda__c='1',Monto_Deposito__c= 5846, Estado_Aporte__c = 'D');
        insert a;
        
        
        test.startTest(); 
        ControllerConciliacionAportesDenegados de = new ControllerConciliacionAportesDenegados();
      
        de.total = 500;
        de.FechaActual = date.today();
        de.ModificarVentana = true;
        de.Motivo = 'ty';
        de.Transaccion  ='asd';
        de.p_periodo_aporte = '20180115';
        de.AplicaComision = 'si';
        de.Ver_Imagen = 'asdasdsa';
        de.DenegarImagen = true;
        de.Usuario = '';
        de.Cuenta = '';
        de.Moneda = '1';
        de.Monto = 0.2;
        de.FechaDeposito  =date.today();
        de.NombreCompleto = 'asdasd';
        de.Cod_referencia  ='asdasd';
        de.ComisionSI = true;
        de.ComisionNO = false;
        de.BloqueaNO = true;
        de.BloqueaSI = false;
        de.Num_CodReferencia = '12345';
        
        de.popModificar();
        de.ModificarVentana = false;
        de.popModificarSalir();
        de.AplicaComision();
        
        de.NOAplicaComision();
        de.ComisionVaciasNO();
        de.ComisionVaciasSI();
        
        de.CompraDolarSI = TRUE;
        de.CompraDSI();

        DE.CompraDNO();

        de.NADADOLAR();
        
        
        de.popSalirImagen();
        
        de.ModificarLista();
        
        de.TraerInfo_Lista();
        
        de.hy = 'sss';
        
        de.ModificarEstado = [select Estado_Aporte__c, cuenta__c,Tipo_Moneda__c,
                                   Fecha_Deposito__c,Monto_Deposito__c, TIPO_SALDO__c, Forma_de_Pago__c,Periodo_Aporte__c, Compra_Dolar__c,
                                   Codigo_Referencia__c,Descripcion__c,Nombre_Completo__c                                     
                                   from Pantalla_Aportes__c where Codigo_Referencia__c ='12345' ];
        
        de.ModificarEstado.cuenta__c = '158600';
           
    
        update de.ModificarEstado;
        
        test.stopTest();
        
    }

    static testmethod void classAportes_Conciliacion (){
        classAportes_Conciliacion ne = new classAportes_Conciliacion();
         
        ne.Cod_referencia = '';
        ne.ComisionSI = '';
        ne.Cuenta = '';
        ne.FechaDeposito = date.today();
        ne.FechaDepositoAproba = date.today();
        ne.FormaPago = '';
        ne.Moneda = '';
        ne.NombreCompleto = '';
        ne.p_codigo_error = '';
        ne.p_mensaje_error = '';
        ne.p_monto_pen_aplic = '';
        ne.p_periodo_aporte = '';
        ne.p_saldo = '';
        ne.pc_DESCRIPCION = '';
        ne.pc_ESTADO_APORTE = '';
        ne.PC_FECHA_INGRESO_SISTEMA = date.today();
        ne.pc_Imagen = '';
        ne.pc_OFICIAL_DE_NEGOCIOS = '';
        ne.pc_pc_AplicaDolar = '';
        ne.TipoSaldo = '';
        ne.Monto = '';
        ne.p_nombre = '';
        ne.p_num_movim_sysde = '';
        
    }
    
    static testmethod void VFConciliacionHistoricoAportes (){
        VFConciliacionHistoricoAportes pt = new VFConciliacionHistoricoAportes ();
    
    	pt.DenegarVentana = true;
        pt.total = null;
        pt.FechaActual = date.today();
        pt.url_pagina = '';
        pt.Num_CodReferencia = '';
        pt.TipoEstadopc = '';
        pt.pop_exportar = true;
        
        pt.CargarEstado();
        pt.cerrar();
        pt.llenarTipoEstado();
    	pt.exportarE();
        
        //test.stopTest();
    
    }

    static testmethod void ControllerConciliacionSysdeRes (){
                
        Contenido_Estado_Cuenta_Conciliacion__c a = new Contenido_Estado_Cuenta_Conciliacion__c(Monto_Fijo__c = 150, Referencia__c='58600', Dias__c =2,Respuesta_SYSDE__c= 'S');
        insert a;
        
        test.startTest();        
        ControllerConciliacionSysdeRes po = new ControllerConciliacionSysdeRes();
        
        po.ActivarModal = true;
        po.anio = null;
        po.Num_CodReferencia = '';
        po.total = null;
        po.TipoEstadopc = '';
        po.Chek = true;
        po.pCU_Contable = '';
        po.pCU_Rezagos = '';
        po.Usuario = '';
        po.pCU_ContableRe = '';
        po.pCU_RezagosRe = '';
        po.pCU_TipoFondo = '';
        po.ReferencBloq = '';
        po.PC_Observaciones = '';
        po.PC_Observaciones1 = '';
        po.MostrarVenta = true;
        po.mostrarPan = true;
        po.mostrarPanNO = true;
        po.pCU_TipoFondoP = '';
        po.MontoRedu = null;
        po.Descripci = true;
        po.ObserBloq = true;
        po.MontoBloq = true;
        po.CheckDolar = true;
        po.pop_exportar = true;
        
		PO.CrearPartidaDiaUno();
        
        PO.PC_Observaciones = 'HPOLAAA';
        
        PO.CrearPartidaDiaUno();

        po.CargarEstado();
        po.cargaplanillaC();
        po.cargaplanillaNO();
        po.limpiar();
        po.CambiarEstadoConci();
        po.CambiarCheck();
        po.CompraDolarApl();
        po.CambiarCheckModal();
        po.MostraVenta();
        po.MostraVentaEsconder();
        po.llenarTipoMoneda();
        po.llenarTipoEstado();
        po.exportarE();
        po.cerrar();
        po.ConciliarIndividual2dias();
        
      
       
        
        
        
       
        
        
		//list<ControllerAPICONCILIACION.RespuestaPartidaConta> mn = ControllerAPICONCILIACION.RespuestaPartidaConta(pare.ListaCargaC);        
        //po.ListRespuestaSysde aa = new po.ListRespuestaSysde;
         test.stopTest();
        
    }

    static testMethod void ControllerCargaDiaConci()
    {
        Contenido_Estado_Cuenta_Conciliacion__c a = new Contenido_Estado_Cuenta_Conciliacion__c(Monto__c = 230, Fecha_Valor__c = date.today() ,Fecha_posteo__c = DATE.today(), Tipo_Planilla__c = 'HNL', Descripci_n__c = 'ASDSA',Referencia__c = 'ER1' );
        insert a;        
        
        test.startTest();   
        ControllerCargaDiaConci ko = new ControllerCargaDiaConci();
        ko.empresa = '';
        ko.usuario = 'HN22902';
        KO.Mostrartabla = TRUE;
        KO.ty = 1.1;
        KO.TotalDIa = 0.0;
        KO.fechaIn = '';
        KO.FechaDia = '';
        KO.FechaP = DATE.today();
        KO.CanalVentaa.ListaEC__c = 'HNL';
        //KO.MListClientesN;
        //KO.ListaEC();
        
        
        ko.verPlanilla();
        
        
        
        test.stopTest(); 
    }
    
    //APROBACION MARIEL
    static testMethod void ControllerConciliacionAprobacionM()
     {
         
        Pantalla_Aportes__c a = new Pantalla_Aportes__c(Estado_Aporte__c = null, Tipo_Moneda__c = '1', Codigo_Referencia__c='FPC123',Monto_Deposito__c = 55.98);
        insert a;
         
         
        Pantalla_Aportes__c aa = new Pantalla_Aportes__c(Compra_Dolar__c = 'N', Estado_Aporte__c = null, Tipo_Moneda__c = '1', Codigo_Referencia__c='FPC222',Monto_Deposito__c = 55.98);
        insert aa;
         
         Contenido_Estado_Cuenta_Conciliacion__c pw = new Contenido_Estado_Cuenta_Conciliacion__c(Monto_Fijo__c = 58.23, Monto_Pendiente__c = 58.23, Tipo_Planilla__c='HNL',Referencia__c = 'FPC222');
        insert pw; 
         
         Contenido_Estado_Cuenta_Conciliacion__c p = new Contenido_Estado_Cuenta_Conciliacion__c(Monto_Fijo__c = 58.23, Monto_Pendiente__c = 58.23, Tipo_Planilla__c='HNL',Referencia__c = 'FPC123');
        insert p;
        
        Contenido_Estado_Cuenta_Conciliacion__c pT = new Contenido_Estado_Cuenta_Conciliacion__c(Monto_Fijo__c = 58.23, Monto_Pendiente__c = 58.23, Tipo_Planilla__c='USD',Referencia__c = 'FPC1234');
        insert pT;  
         
        test.startTest();        
        ControllerConciliacionAprobacionM mm = new ControllerConciliacionAprobacionM();
         
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
         mm.p_codigo_error = '';
         mm.p_Mensaje_error = '';
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
         mm.CodReferenciaTemp  ='';
         
         //Metodos
         mm.MostraVentaEsconder();
         mm.MostraVentana();
         mm.popDenegarSalir();
         mm.popSalirImagen();
         mm.DenegarLista();
         mm.MostrarVentanaDenegacion();
         mm.CerraVentanaDenegacion();
         mm.AprobarAporte();
         mm.cerrarVentanada();
         mm.CerraError();
         mm.mostrarVenTasa();
         
         mm.CompraDolar = 55;
         mm.part = 'OK';
         
         mm.CambioTasa();
         mm.AprobarAporte2SinComision();
         
         mm.PC_Observaciones = 'aporte malo';
         mm.CodReferenVentana = 'FPC123';
         mm.ConciliarIndividual2dias();
         mm.PC_Observaciones = 'aporte malo';
         mm.CodReferenVentana = 'FPC1234';
		 mm.ConciliarIndividual2dias();         
         
         mm.Num_CodReferencia = 'FPC222';
         mm.p_codigo_error = '0';
         mm.AprobarAporte();
         
         mm.CerrarVentana();
         
         test.stopTest(); 
     }    
    
    static testMethod void ControllerConciliacionAprobacionM2()
     {
         
        Pantalla_Aportes__c a = new Pantalla_Aportes__c(Estado_Aporte__c = null, Tipo_Moneda__c = '1', Codigo_Referencia__c='FPC123',Monto_Deposito__c = 55.98);
        insert a;
         
         
        Pantalla_Aportes__c aa = new Pantalla_Aportes__c(Compra_Dolar__c = 'N', Estado_Aporte__c = null, Tipo_Moneda__c = '1', Codigo_Referencia__c='FPC222',Monto_Deposito__c = 55.98);
        insert aa;
         
         Contenido_Estado_Cuenta_Conciliacion__c p = new Contenido_Estado_Cuenta_Conciliacion__c(Monto_Fijo__c = 58.23, Monto_Pendiente__c = 58.23, Tipo_Planilla__c='HNL',Referencia__c = 'FPC123');
        insert p;
        
        Contenido_Estado_Cuenta_Conciliacion__c pT = new Contenido_Estado_Cuenta_Conciliacion__c(Monto_Fijo__c = 58.23, Monto_Pendiente__c = 58.23, Tipo_Planilla__c='USD',Referencia__c = 'FPC1234');
        insert pT;  
        
         
        Pantalla_Aportes__c WW = new Pantalla_Aportes__c(Estado_Aporte__c = NULL, Codigo_Referencia__c = 'JKL', Tasa__c = 24.5, Tipo_Moneda__c = '1', Monto_Deposito__c = 345);
        insert WW;  
         
        Pantalla_Aportes__c XX = new Pantalla_Aportes__c(Estado_Aporte__c = NULL, Codigo_Referencia__c = 'QWER', Tasa__c = 24.5, Tipo_Moneda__c = '1', Monto_Deposito__c = 345, Compra_Dolar__c = 'N');
        insert XX;  
         
         
        test.startTest();        
        ControllerConciliacionAprobacionM mm = new ControllerConciliacionAprobacionM();
         
        Pantalla_Aportes__c nw = new Pantalla_Aportes__c();
         Contenido_Estado_Cuenta_Conciliacion__c BB =  NEW Contenido_Estado_Cuenta_Conciliacion__c();
        mm.ContenidoAporte = nw;
        mm.ModificarEstado = nw;
        //mm.RegistroAportesTotal = nw;
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
         mm.p_codigo_error = '';
         mm.p_Mensaje_error = '';
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
         mm.p_codigo_error= '0';
         mm.UpdaSaldos = 'OK';
         mm.CodReferenciaTemp = 'QWER';
         mm.AprobarAporte2SinComision();
         
         
         
         //Metodos
         mm.MostraVentaEsconder();
         mm.MostraVentana();
         mm.popDenegarSalir();
         mm.popSalirImagen();
         mm.DenegarLista();
         mm.MostrarVentanaDenegacion();
         mm.CerraVentanaDenegacion();
         mm.AprobarAporte();
         mm.cerrarVentanada();
         mm.CerraError();
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
         mm.p_codigo_error = '0';
         mm.AprobarAporte();
         
         mm.CerrarVentana();
         
         mm.CompraDolar = 55;
         mm.part = 'OK';
         mm.CambioTasa();
         
         
         mm.CompraDolar = 55;
         mm.part = 'S';
         mm.CambioTasa();
         
         test.stopTest(); 
     }    
    
     static testMethod void ControllerConciliacionAprobacionM2222()
     {
         
        Pantalla_Aportes__c a = new Pantalla_Aportes__c(Estado_Aporte__c = null, Tipo_Moneda__c = '1', Codigo_Referencia__c='FPC123',Monto_Deposito__c = 55.98);
        insert a;
         
         
        Pantalla_Aportes__c aa = new Pantalla_Aportes__c(Compra_Dolar__c = 'N', Estado_Aporte__c = null, Tipo_Moneda__c = '1', Codigo_Referencia__c='FPC222',Monto_Deposito__c = 55.98);
        insert aa;
         
         Contenido_Estado_Cuenta_Conciliacion__c p = new Contenido_Estado_Cuenta_Conciliacion__c(Monto_Fijo__c = 58.23, Monto_Pendiente__c = 58.23, Tipo_Planilla__c='HNL',Referencia__c = 'FPC123');
        insert p;
        
        Contenido_Estado_Cuenta_Conciliacion__c pT = new Contenido_Estado_Cuenta_Conciliacion__c(Monto_Fijo__c = 58.23, Monto_Pendiente__c = 58.23, Tipo_Planilla__c='USD',Referencia__c = 'FPC1234');
        insert pT;  
        
         
        Pantalla_Aportes__c WW = new Pantalla_Aportes__c(Estado_Aporte__c = NULL, Codigo_Referencia__c = 'JKL', Tasa__c = 24.5, Tipo_Moneda__c = '1', Monto_Deposito__c = 345);
        insert WW;  
         
        Pantalla_Aportes__c XX = new Pantalla_Aportes__c(Estado_Aporte__c = NULL, Codigo_Referencia__c = 'QWER', Tasa__c = 24.5, Tipo_Moneda__c = '1', Monto_Deposito__c = 345, Compra_Dolar__c = 'N');
        insert XX;  
         
         
        test.startTest();        
        ControllerConciliacionAprobacionM mm = new ControllerConciliacionAprobacionM();
         
                 
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
         mm.p_codigo_error = '';
         mm.p_Mensaje_error = '';
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
         mm.p_codigo_error= '0';
         mm.UpdaSaldos = 'OK';
         mm.CodReferenciaTemp = 'FPC222';
         mm.AprobarAporte2SinComision();
         
         
       
         //mm.AprobarAporte2SinComision();
         
         mm.PC_Observaciones = 'aporte malo';
         mm.CodReferenVentana = 'FPC222';
         mm.ConciliarIndividual2dias();
         mm.PC_Observaciones = 'aporte malo';
         mm.CodReferenVentana = 'FPC222';
		 mm.ConciliarIndividual2dias();         
         
         mm.Num_CodReferencia = 'FPC222';
         mm.p_codigo_error = '0';
         mm.CodReferenciaTemp = 'FPC222';
         mm.ListRespuesta = [select    cuenta__c, Tasa__c ,Tipo_Moneda__c,Monto_Deposito__c, Fecha_Deposito__c,TIPO_SALDO__c ,
                                       Forma_de_Pago__c,Codigo_Referencia__c,Aplica_Comision_SI__c,
                                       Compra_Dolar__c, Periodo_Aporte__c,Oficial_de_negocios__c
                            from Pantalla_Aportes__c 
                             where Codigo_Referencia__c = 'FPC222'];
         
         
         mm.CerrarVentana();
         mm.CompraDolar = 55;
         mm.part = 'OK';
         mm.CambioTasa();
         mm.p_codigo_error = '0';
          mm.CambioTasa();
         test.stopTest(); 
     }  
    */
    //TEST API
    
    
    //API CONCILIACION 
    /*
    static testMethod void ControllerAPICONCILIACION()
    {
         test.startTest();
        
        ControllerAPICONCILIACION PE = NEW ControllerAPICONCILIACION();
        
        ControllerAPICONCILIACION.classAportesCuenta kk = new ControllerAPICONCILIACION.classAportesCuenta();
        
        kk.cuenta = '51600';
        
        ControllerAPICONCILIACION.classCargaEC_Respuesta_Conciliacion jj =  new ControllerAPICONCILIACION.classCargaEC_Respuesta_Conciliacion();
        
          jj.Conciliado = 's';
          jj.Mensaje = '';
          jj.Referencia = '51600';
        
        List<classCuenta> Licuentas = new List<classCuenta>();
        
        classCuenta c = new classCuenta();
        
        c.cliente ='';
        c.codigoBarra = '';
        c.cuenta ='';
        c.cuentaActiva = true;
        c.cuentaColectiva = '';
        c.fechaApertura =  date.today();
        c.fechaAporte =  date.today();
        c.fondo =  '';
        c.fondoInversion = '';
        c.formaAporte = '';
        c.frecuenciaAporte = '';
        c.matrizComision = '';
        c.producto = '';
        c.seguroVida = true;
        c.subProducto = '';
        c.tipoComision = '';
        
        ControllerAPICONCILIACION.classRespuestaAportesCuenta rp = new ControllerAPICONCILIACION.classRespuestaAportesCuenta();
        rp.identificacion = '0612199500049';
        
      
        test.stopTest(); 
    }*/
      
}