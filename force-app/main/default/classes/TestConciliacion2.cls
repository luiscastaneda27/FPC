@isTest //(seeAllData=true)
public class TestConciliacion2 {
    
	static testMethod void ControllerConciliacionAportes(){
		Bitacora_Conciliacion__c a = new Bitacora_Conciliacion__c(Actividades__c = 'En', Usuario__c = 'HN22902' , Fecha__c = DATE.today());
        insert a;        
        
        Usuarios_de_Pantallas__c up= new Usuarios_de_Pantallas__c(Usuario__c='HN21582',Name='xc', Apellido__c='Varys', Contrase_a__c='lkfdg');
         insert up;  
            
        test.startTest();
        
        ControllerConciliacionAportes aport = new ControllerConciliacionAportes();
       
        aport.CompraDolarSI = true;
        APORT.Comprobante = BLOB.valueOf('ASKHDSABJHSADBSAJHDBSAASDAS');
        aport.Cuenta = null;
        aport.NombreCompleto = null;
        aport.Moneda = null;
        aport.FechaDeposito = null;
        aport.Monto = null;
        aport.Cod_referencia = null;
        aport.p_periodo_aporte = null;
        aport.BloqueaSI = true;
        aport.BloqueaNO = false;
        aport.ComisionSI = true;
        aport.ComisionNO = true;
        aport.Usuario = 'HN21528';
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
        
        aport.Guardar(); 
        
        
        aport.hy = '';
        aport.TiSaldo = '';
        aport.FoPago = 'TL';
        aport.Cuenta = '812456';
        aport.TraerAportee();
        Pantalla_Aportes__c Ba = new Pantalla_Aportes__c(cuenta__c='812456',Nombre_Completo__c='acaaa',Tipo_Moneda__c='1', Fecha_Deposito__c = date.today(),
                                                        Monto_Deposito__c = 25, TIPO_SALDO__c = '10', Forma_de_Pago__c ='TL',  Codigo_Referencia__c= 'AKJ', Periodo_Aporte__c= '20180101',Fecha_Ingreso_Sistema__c = DATE.today(),Oficial_de_negocios__c = 'hn2234' );
        insert Ba;
        
        aport.Cuenta = '12312321';
        aport.NombreCompleto = 'akkaka';
        aport.FechaDeposito = date.today();
        aport.TiSaldo = '10';
        aport.FoPago = 'TL';
        aport.Cod_referencia = '132132';
        aport.Monto = 55;  
        aport.Guardar(); 
        
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
       ClassListaPartii listP= new ClassListaPartii();
       ClassEnviarConciliacionLista EnvConcilia=new ClassEnviarConciliacionLista();
       EnvConcilia.FechaValor= date.today();
       EnvConcilia.Descripcion='f';
       EnvConcilia.Referencia='g';
       EnvConcilia.FechaPosteo= date.today();
       EnvConcilia.Monto=1.0;
       EnvConcilia.Narrativa='p';
      classAportes_Conciliacion fcsd = ControllerAPICONCILIACION.BuscarCuenta('58602');
      ControllerAPICONCILIACION.classAportesCuenta AC = new ControllerAPICONCILIACION.classAportesCuenta(); 
        List<classCuenta> ct= new List<classCuenta>();
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
      AC.cuenta='98536';
      List<ControllerAPICONCILIACION.classAportesCuenta> LAC = new List<ControllerAPICONCILIACION.classAportesCuenta>();
      ControllerAPICONCILIACION.classRespuestaAportesCuenta rp = new ControllerAPICONCILIACION.classRespuestaAportesCuenta();
      rp.identificacion='158';
      rp.cuentas= LAC;
        List<ControllerAPICONCILIACION.classRespuestaAportesCuenta> Lrp = new List<ControllerAPICONCILIACION.classRespuestaAportesCuenta>();
      ControllerAPICONCILIACION.Prueba p = new ControllerAPICONCILIACION.Prueba();
      p.aportes=Lrp;
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
        ControllerAPICONCILIACION.classPersonas persona = new ControllerAPICONCILIACION.classPersonas(); 
        persona.identidad='15';
        persona.cuentas=ct;
        ControllerAPICONCILIACION.ClassListaAporte Lap = new ControllerAPICONCILIACION.ClassListaAporte(); 
        Lap.Error='564';
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
      ControllerAPICONCILIACION.guardarAporte(fcsd);
      ControllerAPICONCILIACION.BuscarAporte(fcsd);
      ControllerAPICONCILIACION.ConsultalAportesPatronales('98564'); 
      ControllerAPICONCILIACION.ConsultaCEConciliados(EnvConcilia);
      ControllerAPICONCILIACION.CreaPartidaDolaar(listP);
      ControllerAPICONCILIACION.CreaPartidaDolaarNoConcilia(listP);
      ControllerAPICONCILIACION.TraerImagenBD('listP');
      ControllerAPICONCILIACION.CreaPartidaDebiNoConcilia(listP);
      ControllerAPICONCILIACION.CreaPartidaDebi(listP);  
      ControllerBitacoraConciliacion bitaCon = new ControllerBitacoraConciliacion(); 
      bitaCon.bitacora(); 
      bitaCon.Generar();
      bitaCon.EnviarListasysde();
      
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
        classConciliacionEstadoCuenta pao = new classConciliacionEstadoCuenta(DATE.today(), '', '', DATE.today(), 1,'', '', '');
        ClassListaPartii ax = new ClassListaPartii();
        ClassPartidaContable ha = new ClassPartidaContable ('', DATE.today(), '', '', DATE.today(), 1, '', '', '', '', 1);
        test.stopTest();
     }
}