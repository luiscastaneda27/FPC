@isTest
global class TestControllerPantJuridProduc {
    global class IT_ServicioConsultaPQR_Test_Mock implements HttpCalloutMock{   
        global HTTPResponse respond(HTTPRequest request) {
            HttpResponse response = new HttpResponse();
            response.setHeader('Content-Type', 'application/json');
            response.setBody( 
                '{'+
                '"operacion": "Consulta PQR",'+
                '"respuesta": {'+
                '"estado": "OK",'+
                '"mensaje": "",'+
                '"tipoExcepcion": 0'+
                '},'+
                '"pqrs": ['+
                '{'+
                '"fecha": "'+(System.now()).addDays(-25)+'",'+
                '"tipo": "Quejas",'+
                '"descripcion": "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Consequuntur est ullam facere commodi necessitatibus inventore excepturi, amet nobis ut, quas blanditiis minus ea nisi pariatur ipsam? Ex facilis quae ad!",'+
                '"estado": "Resuelta"'+
                '},'+
                '{'+
                '"fecha": "'+(System.now()).addDays(-20)+'",'+
                '"tipo": "Quejas",'+
                '"descripcion": "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Consequuntur est ullam facere commodi necessitatibus inventore excepturi, amet nobis ut, quas blanditiis minus ea nisi pariatur ipsam? Ex facilis quae ad!",'+
                '"estado": "Resuelta"'+
                '},'+
                '{'+
                '"fecha": "'+(System.now()).addDays(-15)+'",'+
                '"tipo": "Quejas",'+
                '"descripcion": "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Consequuntur est ullam facere commodi necessitatibus inventore excepturi, amet nobis ut, quas blanditiis minus ea nisi pariatur ipsam? Ex facilis quae ad!Lorem ipsum, dolor sit amet consectetur adipisicing elit. Consequuntur est ullam facere commodi necessitatibus inventore excepturi, amet nobis ut, quas blanditiis minus ea nisi pariatur ipsam? Ex facilis quae ad!",'+
                '"estado": "Resuelta"'+
                '},'+
                '{'+
                '"fecha": "'+(System.now()).addDays(-10)+'",'+
                '"tipo": "Quejas",'+
                '"descripcion": "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Consequuntur est ullam facere commodi necessitatibus inventore excepturi, amet nobis ut, quas blanditiis minus ea nisi pariatur ipsam? Ex facilis quae ad!",'+
                '"estado": "Resuelta"'+
                '},'+
                '{'+
                '"fecha": "'+(System.now()).addHours(-5)+'",'+
                '"tipo": "Quejas",'+
                '"descripcion": "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Consequuntur est ullam facere commodi necessitatibus inventore excepturi, amet nobis ut, quas blanditiis minus ea nisi pariatur ipsam? Ex facilis quae ad!",'+
                '"estado": "Resuelta"'+
                '}]}');
            response.setStatusCode(200);
            response.setStatus('OK');
            return response; 
        }
    }
    static testMethod void ControllerPantJuridProduc(){
        test.startTest();    
        
        ControllerPantJuridProduc Jur = new ControllerPantJuridProduc();
        jur.mostrarBoton=true;
        jur.OcultarSeguroNO=true;
        jur.pcFATCA=true;
        jur.pcAPNFDSI = true;
        jur.ACC_10DE_CONTROLSI = false;
        JUR.ACTIV_PASIVO='A';
        jur.pcformapago = '' ;
        jur.SOCIO=false;
        jur.AML = true;
        jur.fechaBeneficiario= date.today();
        jur.opciones = null;
        jur.llenarTipoMoneda1='null';
        jur.llenarDiaAportacion1=null;
        jur.tipoUsuarioProducto=null;
        jur.selectops=1;
        jur.mensaje3=null;
        jur.Prueba2=null;
        jur.Prueba=null;
        jur.pcProfesionOcupacionOtros=null;
        jur.PcNacionalidadSocios=null;
        jur.vccodpais='074';
        jur.usuarioValidacion='null';
        jur.Prob1=true;
        jur.FechaValidacion=null;
        jur.Pantalla1=null;
        jur.Envio1=null;
        
        jur.pcPEP = true;
        jur.pcFATCA = false;
        jur.pcprimernombre = 'paola';
        jur.pcsegundonombre = 'paola';
        jur.pcprimerapellido = 'alvarado';
        jur.pcsegundoapellido = 'alvarado';
        jur.pctipoid = '1';
        jur.pcnroid = '0801199411013';
        jur.pcagencia = '101';
        jur.pcempresa = '02';
        //jur.DiaMes = 2;
        jur.pnnrocertificado = 'FPC1q2345';
        //jur.pcFechaValidacionCN = '1/07/2018';
        //jur.pdfechasuscripcion = '1/07/2018';
        jur.despN = true;
        jur.pcTelefonoCN = '22373447';
        jur.pcCelularCN = '88612510';
        jur.pdLugarNacimientoCN = 'tegucigalpa';
        jur.pcsexo = 'F';
        jur.pcestadocivil = 'S';
        jur.pcNombreConyuge = null;
        jur.pcProfesionOcupacion = '16';
        jur.pcmail = 'wendy.alvarado@ficohsa.com';
        jur.PCNumeroAPNFD = '1';
        jur.PC_NIVEL_RIESGO ='2';
        jur.PC_DEBIDA_DELIGENCIA = '2';
        jur.pc_ActuaSI = true;
        jur.pc_ActuaNO = false;
        jur.pcNumeroIDPV = '00000000000';
        jur.pcNombreCompletoPV = 'wendy alvarado';
        jur.pcDependeSI = true;
        jur.pcDependeNO = false;
        jur.pcTipoIDDependencia = '1';
        jur.pcNumeroIDDependencia = '0000000000';
        jur.pcNombreCompletoDependencia = 'wendy alvarado';
        jur.pccodpais = '074';
        jur.pcDeptoCN = '123';
        jur.pcMunicipioCN = '000';
        jur.pcColoniaCN = '000';
        jur.pcCalleDetalleCN = 'frente a iglesia';
        jur.pcnacionalidad = 'hondurena';
        jur.pcnacionalidad2 = 'estado unidesence';
        jur.pcnacionalidad3 = null;
        jur.pcPrimerNombreReferi1 = 'paola';
        jur.pcSegundoNombreReferi1  = 'paola';
        jur.pcPrimerApellidoReferi1  = 'paola';
        jur.pcSegundoApellidoReferi1  = 'paola';
        jur.pcTelefono_Referido1Referi1 = '2222222';
        jur.pcPrimerNombreReferi2  = 'paola';
        jur.pcSegundoNombreReferi2  = 'paola';
        jur.pcPrimerApellidoReferi2  = 'paola';
        jur.pcSegundoApellidoReferi2  = 'paola';
        jur.pcTelefono_ReferidoReferi2 = '2222222';
        jur.pcrncempl = '123456789012345';
        jur.pcTipoEmpresaEmpCN = '1';
        jur.pcNombreempl = 'paola';
        jur.pcrazonsocialempl = 'paola';
        jur.pcCargoEmpresaEmpCN = 'paola';
        jur.pcGiroEmpresaEmpCN = 'paola';
        jur.pctelempl = '2222222';
        jur.pcextempl = '3037';
        jur.pcmailempl = 'paola';
        jur.llenarTipoEmpresa1 = 'paola';  
        jur.llenarNivelIngreso1 = 'paola';  
        jur.pcPaisEmpleadorCN = '074';
        jur.pcDeptoEmpleadorCN = '123';
        jur.pcMunicipioEmpleadorCN = '000';
        jur.pcColoniaEmpleadorCN = '000';
        jur.pcdirempl = 'col payaqui';
        jur.pcTIpoEmpleado = '1';
        jur.pcNivelIngreso = '1';
        jur.pcUsuarioCN = 'paola';
        jur.pdfechasuscripcion = date.today();
        jur.pdfechainiciolabor = date.today();
        jur.pcFechaValidacionCN = date.today();
        jur.pcproducto = '01';
        jur.pcsubproducto= 'FPC01';
        jur.pcTipoFondo = 'P';
        jur.pcTipoMoneda = '1';
        jur.pcperiodicidad = 'M';
        jur.pcformapago = 'CK';
        jur.BloqForma = true;
        jur.pcDiaAportacion = '02';
        jur.pnmontoaporte = '500';
        //jur.pnmontoaporte12 = 500;
        jur.pccuentapago = null;
        jur.pcSalarioP = 'paola';
        //jur.pcaplicaseguro = true;
        //jur.AplicaSeguroNO = false;
        //jur.pcPrimaAsegurada = '230';
        //jur.pcSumaAsegurada = '10000';
        jur.pcNUMUSU = '123456';
        jur.pcenvio = 'E';
        jur.pcTipoAporte = 'p';   
        jur.pcpromotor = 'FPC';
        //jur.pcCanalVentas = null;
        //jur.pc_ActuaNombreCompleto = 'paola alvarado';
        jur.pc_ActuaNumID = '0000000000000';
        jur.PAIS1='074';
        jur.PAIS2='075';
        jur.PAIS3='076';
        jur.DEPTO1='123'    ;
        jur.DEPTO2='124';
        jur.DEPTO3='125';
        jur.Fatca1=true;
        jur.INST_FINANCIERA ='1';
        jur.NUM_TOT_EMPLEADOS='2';
        jur.MTO_APROX_ACTIVO='23';
        jur.DIR_CORRESPONDENCIA='asdasd';
        jur.GIIN='1234567';
        jur.TipoCausaOptions=null;
        jur.pc_ActuaNombreCompleto='';
        jur.nacionalidadEmpleado=null;
        jur.Num_identidadProducto=null;
        jur.Acepto_Terminos='';
        jur.num=1;
        //jur.validarGIIN(ggfffh);    
        jur.TIP_ENTIDAD='1';
        jur.NumIDBuscar ='0601199210849';
        jur.buscarRL();
        jur.NUMID_FIRMAN1= '0601199210849';
        jur.buscarFirmante();
        jur.NUMID_FIRMAN2='0601199210849';
        jur.buscarFirmante2();
        jur.NUMID_FIRMAN3='0601199210849';
        jur.buscarFirmante3();
        jur.pcnumeroidsocc='0601199210849';
        jur.buscarSocio();
        JUR.socioUnicoTIN.PCNumeroID_TIN=  '0601199210849';  
        jur.ong_osSI();
        jur.ong_Noseleccionado();
        jur.ong_NO();
        jur.ong_Noseleccion();
        jur.contrastist_siSelec();
        jur.contrastist_noSelec();
        jur.contrastist_SelecNO();
        jur.contrastist_SelecNOno();  
        jur.ValorNombreTabla = '';
        jur.GuardarListaClienteONG();  
        jur.EliminarClienteONG();
        jur.ActualizaListONG();
        jur.NumbDILTable = ''; 
        jur.guardarListaDili();
        jur.EliminarDIL();
        jur.ActualizaListDili();
        jur.EmpresaMercaSIselec();
        jur.EmpresaMercaSInoselec();    
        jur.EmpresaMercaNOselec();
        jur.EmpresaMercaNOnoselec();
        jur.PersonaUSASIselect();
        jur.PersonaUSASInoselect();
        jur.PersonaUSANOselect();
        jur.PersonaUSANOnoselect();    
        
        jur.ENTIDADSI=true;
        jur.Fatca2=true;
        jur.Fatca3=true;
        jur.Fatca4=true;
        jur.Fatca5=true;
        jur.Fatca6=true;
        jur.Fatca7=true;
        jur.Fatca8=true;
        jur.Fatca9=true;
        jur.Fatca10=true;
        jur.Fatca11=true;
        jur.Fatca12=true;
        jur.Fatca13=true;
        jur.Fatca14=true;
        jur.Fatca15=true;
        jur.Fatca16=true;
        jur.Fatca17=true;
        jur.FATCA13SI();
        jur.mostrarBotonEmpleador=true;
        jur.mostrarBoton=true;
        jur.mostrarSiguiente=true;
        jur.enviarPagPro();
        jur.pcCotizaSI /*Cotiza_SI*/=true;
        jur.pcCotizaNO /*Cotiza_NO*/ =false;
        jur.pcCotizaoOcultarSI /*Cotiza_si*/=false;
        jur.pcCotizaoOcultarNO /*Cotiza_NO*/ =false;
        jur.TickerOcul /*Cotiza_NO*/ =false;
        jur.COT_BOLSASI =true;
        jur.COT_BOLSANO =false;
        jur.pcCotizaoOcultarSI=true;   
        jur.pcCotizaSI=true;
        jur.TickerOcul = true;
        jur.pcCotizaoOcultarNO =  true;
        jur.pcCotizaNO =  false;
        jur.TIC_SYMBOL  ='2223';
        jur.OTROS_OBLIGSI =true;
        jur.ENTIDAD_FINANCIERA ='true';
        jur.ACC_10DE_CONTROL ='N';
        jur.ACC_10DE_CONTROLSI =true;
        jur.TIP_ENTIDAD='1';
        jur.ACTIV_PASIVO='';
        jur.ACTIVA= true;
        jur.PASIVA= true;             
        jur.Segun_pais =true;
        jur.Segun_depto =true;
        jur.Firmante_RL =true;
        jur.Paisopera1= true;
        jur.deptoopera1= true;
        //jur.Paisopera3= true;
        
        jur.OcultaTerSI_1 =false;  
        jur.OcultaTerNO_2 =false; 
        // jur.valorsiONG =true;
        //Variables Cargo publico
        jur.OcultaCarSI  =false;  
        jur.OcultaCarNO  =false;  
        jur.OcultaCarSI_1  =false;  
        jur.OcultaCarNO_2 =false; 
        jur.Cargoo  =false; 
        jur.TotalDistri=100;
        jur.dispepEmple=true; //Tipo empleado
        jur.actPop=true;
        jur.actPopAgregarCliente=true;
        jur.valor=100;
        jur.disbot=true;
        //jur.selectops=true;
        jur.desCheckb=true;
        jur.BloquearConyugue =false;
        jur.VentanaAyuda =true;
        jur.VentanaFatca=true;
        jur.BloqTiFondo =true;
        jur.NumbTINTable ='';
        jur.NumIDBuscar=''; 
        jur.validar1 =true;
        jur.OcultarActuaSI=true;
        jur.OcultarActuaNO=true;
        jur.pc_Actuano_no=false;
        jur.PASIVA=true;
        jur.ACTIVA=false;
        jur.OcultarACTIVA=true;
        jur.OcultarPASIVA=false;
        jur.bloqeListEnti=false;
        jur.mostrarTabla=true;
        jur.MostraTablaSociosTIN = true;
        jur.BusCuentas();
        jur.TINS =  TRUE;
        jur.OcultarEntidad=true;
        jur.OcultarEntidadNo=true;
        jur.NadaEntidad=true;
        //jur.Prueba=false;   
        jur.OcultarCOT_BOLSASI =true;
        jur.OcultarCOT_BOLSANO =true;
        jur.OcultarOTROS_OBLIGSI =true;
        jur.OcultarOTROS_OBLIGNO =true;
        jur.MostraVentana=true;
        jur.mostrarTabla=true;
        jur.disbotBene=true;
        jur.Bene_Ocultar_CamPos=true;
        jur.pagina='';
        jur.INST_FINANCIERA='1';        
        jur.guardar();
        jur.cancelar();   
        jur.limpiar();
        JUR.limpiabenefici();
        //  jur.minimo13();
        //jur.llenaAPNFD();
        jur.llenarColonia();
        jur.llenarColoniaEmpleado();
        jur.llenarCuenta();
        jur.llenarDeligencia();
        jur.llenarDepartamento();
        jur.llenarDepartamentoEmpleado();
        // jur.llenarEstadoCivil();
        jur.llenarMunicipio();
        jur.llenarMunicipioEmpleado();
        jur.llenarNacionalidad();
        jur.llenarNacionalidadSegundos();
        jur.llenarNacionalidadTerceros();
        jur.llenarNivelIngreso();
        jur.llenarNivelRiesgo();
        jur.llenarPais();
        jur.llenarPaisEmpleado();
        jur.llenarProductos();
        jur.llenarSubproductos();
        jur.llenarNacionalidadSocios()  ;
        jur.llenarTipoCausa();
        jur.llenarTipoCuenta();    
        jur.llenarNacionalidadEmpleado();
        jur.llenarColoniaEmpleado();
        jur.llenarDEPTO3();
        jur.llenarDEPTO2();
        jur.llenarDEPTO1();
        jur.llenarPAIS3();
        jur.llenarPAIS2();
        jur.llenarPAIS1();
        
        
        
        jur.OcultarResidencia = true;
        jur.OcultarResidenciaNO = false; 
        // jur.llenarNacionalidadEmpleado();
        jur.OcultarES_Residente_EfectosMi = false;
        jur.OcultarES_Residente_EfectosNO = false; 
        jur.BloquearBtnID = false;
        jur.BloquearBtnCu = false;
        //jur.SI_APLICASEGURO();
        jur.ValidarDependenciaSI();
        jur.AplicaAPNFD();
        jur.pcnroid='';
        jur.VALIDAR_ENVIAR_VFPRODUCTO();
        jur.validar125();
        jur.MostrarVentanaFATCA();  
        jur.PC_NIVEL_RIESGO='3';    
        jur.PC_DEBIDA_DELIGENCIA = '3';
        jur.MostrarVentanaFATCA();
        jur.buscarInfoCuenta();
        jur.buscarInfoCuentaC();
        jur.Numcuentas=null;
        //  jur.SeleccionGradoPa();
        jur.mostrarSiguiente =true;
        jur.mostrarSiguienteEmpleador = true;
        jur.siguiente();
        jur.siguienteEmpleado();
        jur.VentanaFatca = true;
        jur.AplicaResidencia();
        jur.AplicaResidenciaEfectos();
        jur.Actua_SI3();
        jur.MostrarFatcaNacio2();
        //jur.desCheckb2 = true;
        jur.DesbMostrarVentana();
        jur.unblock();
        jur.bloqPep();
        jur.desBtn();
        jur.hideVentana();
        jur.BloqBotonID();
        jur.BloqBotonCU();
        jur.hidePop();
        jur.MostrarT();
        jur.mostPopCliente();
        jur.mostPopTabla();
        jur.mostPopVentana();
        jur.mostPop();
        jur.contrUn();
        jur.desUn();
        jur.ProductoNatural();
        jur.ApnfdNADA();
        jur.AplicaResidenciaNO();
        jur.ResidenteNADA();
        jur.COT_BOLSA();
        jur.OTROS_OBLIG();
        jur.OTROS_OBLIGNO();
        jur.OTROS_OBLIGNADA();
        jur.ENTIDADSI();
        jur.ENTIDADNOO();
        jur.ENTIDAD_NADA();
        jur.CONTROL_ACCISI();
        jur.CONTROL_ACCINO();
        jur.CONTROL_ACCINADA();
        jur.ACTIVASI();
        jur.validatipo_prod();
        jur.PASIVANO();
        jur.pcnroid = '';
        jur.VALIDAR_ENVIAR_VFPRODUCTO();
        
        jur.ACTI_PASI_NADA();
        jur.FATCA1SI();
        jur.FATCA2SI();
        jur.FATCA3SI();
        jur.FATCA4SI();
        jur.FATCA6SI();
        jur.FATCA7SI();
        jur.FATCA8SI();
        jur.FATCA9SI();
        jur.FATCA11SI();
        jur.FATCA12SI();
        jur.FATCA13SI();
        jur.FATCA14SI();
        jur.FATCA15SI();
        jur.FATCA16SI();
        jur.FATCA17SI();    
        jur.FATCANADA();
        jur.HABILITARTIN();
        jur.GIINHABILITAR();
        //jur.minimo13();
        jur.validatipo_id();
        jur.validatipo_prod();
        jur.tipoentidadhabilitar();
        jur.guardarListaSociosTIN();
        jur.EliminarTIN();    
        jur.EliminarDADD();
        jur.EliminarTINADD();  
        jur.ModificarTIN();
        jur.ValidarDependenciaNOV();  
        jur.TerceraNO();
        jur.TerceraSI();
        jur.TerceNADA();    
        jur.DesbConyugue();
        jur.BloqConyugue();
        jur.MostrarVentana();
        jur.MostrarTablaC();
        jur.DesMostrarTablaC();
        jur.DesbMostrarVentanaFatca();
        jur.ocultarpaisopera();
        jur.Mostrarpaisopera();
        jur.ocultardeptoopera();
        jur.Mostrardeptoopera();
        //jur.TraerDatos();
        jur.bloqueTarjet();
        jur.ocultarCotiza();
        jur.ocultarCotizaNO();
        jur.OcultarPorcentajeIndi();
        jur.desbb();    
        jur.mostrarModal();
        //jur.validarGIIN();
        
        
        //  jur.llenarNacionalidadSocios();
        //jur.llenarPAIS1();
        // jur.llenarPAIS2();
        //jur.llenarPAIS3();
        //jur.llenarDEPTO1();
        //jur.llenarDEPTO2();
        //jur.llenarDEPTO3();
        
        jur.VALIDAR_ENVIAR_VFPRODUCTO();
        jur.pccodpais = ' --Ninguno-- ';
        jur.pcDeptoCN = ' --Ninguno-- ';
        jur.pcMunicipioCN = ' --Ninguno-- ';
        jur.pcColoniaCN = ' --Ninguno-- ';
        jur.pcCalleDetalleCN = ' --Ninguno-- ';
        jur.pcnroid = '';
        jur.pcrazonsocialempl = '';
        jur.pcNombreempl='';
        jur.NUM_TOT_EMPLEADOS='';
        jur.disbotBene = true; 
        jur.ListSociosTIN=null;
        jur.socioUnico=null;    
        jur.VALIDAR_ENVIAR_VFPRODUCTO();
        jur.BtnCancelar();
        //jur.ListSocios = new list<ListSocios>();
        //public List<socios> ListSocios {get;set;}
        //public socios socioUnico{get;set;}
        
        //|public List<SociosTIN> ListSociosTIN {get;set;}
        //public SociosTIN socioUnicoTIN {get;set;}
        //jur.ClienteNatural ='';
        //jur.ProductoNatural ='';
        jur.pcproducto= '';
        jur.pcpromotor = '';
        jur.pcpromotor='';
        jur.guardar();
        jur.pcpromotor = ' --Ninguno-- ';
        jur.guardar();
        jur.PCNumeroAPNFD = '--Ninguno--';
        jur.pcCotizaSI = true;
        jur.mostrarTabla=true;
        jur.MostraTablaSociosTIN=true;
        jur.mostrarTabla2=true;
        jur.ListSocios = null;
        jur.ListSociosTIN = null;
        jur.disbotBene = true;
        jur.pcFATCA = true;
        jur.pc_ActuaSI = true;
        jur.ES_Residente=true;
        jur.pcenvio = 'null';
        jur.pcCotizaSI=true;
        
        jur.GUARDAR2();
        // jur.pcaplicaseguro = false;
        //jur.AplicaSeguroNO = true;
        JUR.anterior();
        jur.anteriorEmpleado();            
        jur.NombreRL='';
        jur.pc_ActuaSI=true;
        jur.ENTIDAD_FINANCIERA='S';
        JUR.INST_FINANCIERA='1';     
        // jur. == '--Ninguno--'
        jur.GUARDAR();
        jur.pcnroid='';
        jur.VALIDAR_ENVIAR_VFPRODUCTO();
        jur.pcrazonsocialempl='';
        jur.VALIDAR_ENVIAR_VFPRODUCTO();    
        jur.pcNombreempl='';
        jur.VALIDAR_ENVIAR_VFPRODUCTO();    
        jur.OcultarAPNFD=null;
        jur.VALIDAR_ENVIAR_VFPRODUCTO();    
        jur.OcultarAPNFDNO=null;
        jur.VALIDAR_ENVIAR_VFPRODUCTO();    
        jur.pcAPNFDSI=true;
        jur.VALIDAR_ENVIAR_VFPRODUCTO();    
        jur.PCNumeroAPNFD= null;
        jur.VALIDAR_ENVIAR_VFPRODUCTO();    
        jur.NUM_TOT_EMPLEADOS='';
        jur.VALIDAR_ENVIAR_VFPRODUCTO();    
        jur.MTO_APROX_ACTIVO='';
        jur.VALIDAR_ENVIAR_VFPRODUCTO();    
        jur.OcultarOTROS_OBLIGSI=null;
        jur.VALIDAR_ENVIAR_VFPRODUCTO();
        jur.OcultarOTROS_OBLIGNO=null;
        jur.VALIDAR_ENVIAR_VFPRODUCTO();
        jur.REF1_PROVE_PRODUC ='';
        jur.VALIDAR_ENVIAR_VFPRODUCTO(); 
        jur.NumeroID_Fiscal_EEUU = '';
        jur.VALIDAR_ENVIAR_VFPRODUCTO();     
        
        
        ControllerPantJuridProduc ju = new ControllerPantJuridProduc();
        //   ju.llenarProductos();
        ju.llenarProductos();
        ju.llenarNacionalidadSocios();
        ju.llenarTipoCausa();
        ju.llenarTipoCuenta();
        ju.llenarColoniaEmpleado();
        ju.llenarMunicipioEmpleado();
        ju.llenarDepartamentoEmpleado();
        ju.TipoCausaOptions=null;
        ju.TipoCuentaOptions=null;
        ju.llenarPaisEmpleado();
        ju.llenarDEPTO3();
        ju.llenarDEPTO2();
        ju.llenarDEPTO1();
        ju.llenarPAIS3();
        ju.llenarPAIS2();
        ju.llenarPAIS1();
        ju.llenarNacionalidadSegundos();
        ju.llenarNacionalidadTerceros();
        ju.llenarColonia();
        ju.llenarNacionalidad();
        ju.llenarMunicipio();
        ju.llenarDepartamento();
        ju.llenarPais();
        ju.llenarSubproductos();
        ju.llenarNacionalidadEmpleado();    
        ju.llenarCuentasDesdeSysde();
        ju.pcnroid='';
        ju.VALIDAR_ENVIAR_VFPRODUCTO();
        ju.pcrazonsocialempl='';
        ju.VALIDAR_ENVIAR_VFPRODUCTO();    
        ju.pcNombreempl='';
        ju.VALIDAR_ENVIAR_VFPRODUCTO();    
        ju.OcultarAPNFD=null;
        ju.VALIDAR_ENVIAR_VFPRODUCTO();    
        ju.OcultarAPNFDNO=null;
        ju.VALIDAR_ENVIAR_VFPRODUCTO();    
        ju.pcAPNFDSI=true;
        ju.VALIDAR_ENVIAR_VFPRODUCTO();    
        ju.PCNumeroAPNFD= null;
        ju.VALIDAR_ENVIAR_VFPRODUCTO();    
        ju.NUM_TOT_EMPLEADOS='';
        ju.VALIDAR_ENVIAR_VFPRODUCTO();    
        ju.MTO_APROX_ACTIVO='';
        ju.VALIDAR_ENVIAR_VFPRODUCTO();    
        ju.OcultarOTROS_OBLIGSI=null;
        ju.VALIDAR_ENVIAR_VFPRODUCTO();
        ju.OcultarOTROS_OBLIGNO=null;
        ju.VALIDAR_ENVIAR_VFPRODUCTO();
        ju.REF1_PROVE_PRODUC ='';
        ju.VALIDAR_ENVIAR_VFPRODUCTO(); 
        ju.Validacionsocial();
        ju.pcFATCA=true;
        ju.VALIDAR_ENVIAR_VFPRODUCTO();
        ju.ENTIDADSI=true;
        ju.VALIDAR_ENVIAR_VFPRODUCTO();
        ju.Segun_depto=false;  
        ju.FECHA_CONSTITUCION=date.today(); 
        ju.pcFATCA=false;
        ju.ACC_10DE_CONTROL='S';
        ju.ACTIV_PASIVO='N';
        ju.pcTipoFondo= ' --Ninguno-- ';
        ju.v_des_procedfds='';
        ju.OTROS_OBLIG();
        ju.pcpromotor = '';
        ju.pcpromotor = ' --Ninguno-- ';
        ju.pcTipoFondo = '';
        ju.pcTipoFondo = null;
        ju.pcTipoFondo = ' --Ninguno-- ';
        ju.actualizar();
        ju.AML = true;
        ju.pcPEP = true;
        ju.pcFATCA = true;
        ju.pcprimernombre = 'paola';
        ju.pcsegundonombre = 'paola';
        ju.pcprimerapellido = 'alvarado';
        ju.pcsegundoapellido = 'alvarado';
        ju.pctipoid = '2';
        ju.pcnroid = '0801199411013';
        ju.pcagencia = '101';
        ju.pcempresa = '02';
        //cliente.DiaMes = 2;
        ju.pnnrocertificado = 'FPC1q2345';
        ju.despN = true;
        ju.pcTelefonoCN = '22373447';
        ju.pcCelularCN = '88612510';
        ju.pdLugarNacimientoCN = 'tegucigalpa';
        ju.pcsexo = 'F';
        ju.pcestadocivil = 'S';
        ju.pcNombreConyuge = null;
        ju.pcProfesionOcupacion = '16';
        ju.pcmail = 'wendy.alvarado@ficohsa.com';
        ju.PCNumeroAPNFD = '1';
        ju.PC_NIVEL_RIESGO ='2';
        ju.PC_DEBIDA_DELIGENCIA = '2';
        ju.pc_ActuaSI = false;
        ju.pc_ActuaNO = true;
        ju.pcNumeroIDPV = '00000000000';
        ju.pcNombreCompletoPV = 'wendy alvarado';
        ju.pcDependeSI = false;
        ju.pcDependeNO = true;
        ju.pcTipoIDDependencia = '1';
        ju.pcNumeroIDDependencia = '0000000000';
        ju.pcNombreCompletoDependencia = 'wendy alvarado';
        ju.pccodpais = '074';
        ju.pcDeptoCN = '123';
        ju.pcMunicipioCN = '000';
        ju.pcColoniaCN = '000';
        ju.pcCalleDetalleCN = 'frente a iglesia';
        ju.pcnacionalidad = 'hondurena';
        ju.pcnacionalidad2 = 'estado unidesence';
        ju.pcnacionalidad3 = null;
        ju.pcPrimerNombreReferi1 = 'paola';
        ju.pcSegundoNombreReferi1  = 'paola';
        ju.pcPrimerApellidoReferi1  = 'paola';
        ju.pcSegundoApellidoReferi1  = 'paola';
        ju.pcTelefono_Referido1Referi1 = '2222222';
        ju.pcPrimerNombreReferi2  = 'paola';
        ju.pcSegundoNombreReferi2  = 'paola';
        ju.pcPrimerApellidoReferi2  = 'paola';
        ju.pcSegundoApellidoReferi2  = 'paola';
        ju.pcTelefono_ReferidoReferi2 = '2222222';
        ju.pcrncempl = '123456789012345';
        ju.pcTipoEmpresaEmpCN = '1';
        ju.pcNombreempl = 'paola';
        ju.pcrazonsocialempl = 'paola';
        ju.pcCargoEmpresaEmpCN = 'paola';
        ju.pcGiroEmpresaEmpCN = 'paola';
        ju.pctelempl = '2222222';
        ju.pcextempl = '3037';
        ju.pcmailempl = 'paola';
        ju.llenarTipoEmpresa1 = 'paola';  
        ju.llenarNivelIngreso1 = 'paola';  
        ju.pcPaisEmpleadorCN = '074';
        ju.pcDeptoEmpleadorCN = '123';
        ju.pcMunicipioEmpleadorCN = '000';
        ju.pcColoniaEmpleadorCN = '000';
        ju.pcdirempl = 'col payaqui';
        ju.pcTIpoEmpleado = '1';
        ju.pcNivelIngreso = '1';
        ju.pcUsuarioCN = 'paola';
        ju.pdfechasuscripcion = date.today();
        ju.pdfechainiciolabor = date.today();
        ju.pcFechaValidacionCN = date.today();
        ju.pcproducto = '01';
        ju.pcsubproducto= 'FPC01';
        ju.pcTipoFondo = 'P';
        ju.pcTipoMoneda = '1';
        ju.pcperiodicidad = 'M';
        ju.pcformapago = 'CK';
        ju.BloqForma = true;
        ju.pcDiaAportacion = '02';
        ju.pnmontoaporte = '500';
        ju.pnmontoaporte12 = 500;
        ju.pccuentapago = null;
        ju.pcSalarioP = 'paola';
        ju.pcaplicaseguro = true;
        ju.AplicaSeguroNO = true;
        ju.pcPrimaAsegurada = '230';
        ju.pcSumaAsegurada = '10000';
        ju.pcNUMUSU = '123456';
        ju.pcenvio = 'E';
        ju.pcTipoAporte = 'p';   
        ju.pcpromotor = 'FPC';
        ju.mostrarSiguiente =false;
        ju.mostrarSiguienteEmpleador = false;
        ju.socioUnico = null ;
        ju.ListSocios=null;
        ju.socioUnicoTIN.PCTIN_TIN='45244';
        ju.socioUnicoTIN=null;
        ju.GIINSI= false;
        ju.VALIDAR_ENVIAR_VFPRODUCTO();
        //ju.socioUnico    
        // ju.socioUniconombresocio = '';
        //        ju.socioUnico.genero = 'F';
        //ju.beneficiarioUnico.Parentesco = 1;
        //      ju.socioUnico.Grado = 2;
        //    ju.socioUnico.tipoBeneficiario ='D';
        //  ju.socioUnico.fechaNacimiento = date.today();
        //ju.socioUnico.Distribucion = 100;
        //ju.socioUnico.Distribucion.total2 = 100;
        ju.GUARDAR2();
        ju.ModificarD();
        ju.EliminarD();
        //ju.EliminarADD();
        
        ju.anterior();
        ju.anteriorEmpleado();
        //ju.PaisFatca();
        //ju.NacionalidadFatca();
        //  ju.NO_APLICASEGUROD();
        ju.AplicaSeguroNO = false;
        ju.ValidarDependenciaNO();
        ju.AplicaAPNFDNOO();
        ju.AplicaResidencia();
        ju.AplicaResidenciaEfectosNO();
        ju.ResidenteEfectosNADA();
        ju.MostarPantalla();
        ju.MostrarVentanaFATCANO();
        ju.ocultarFatcaNacio2();
        ju.ActuaNada();
        ju.Actua_NO3();
        ju.pccontratocolectivo = '33101';
        ju.pcrncempl = null;
        ju.buscarColectiva(); 
        ju.MostraTablaSociosTIN=true;
        ju.mostrarTabla=true;
        ju.OcultaCarSI=true;
        ju.actualizar();  
        ju.pcproducto = '';
        ju.actualizar();
        ju.pcsubproducto= '';
        jur.actualizar();
        ju.pcTipoFondo = '';
        ju.actualizar();
        ju.pcTipoMoneda = '';
        ju.actualizar();
        ju.pcperiodicidad = '';
        ju.actualizar();
        ju.ACTIV_PASIVO='P';
        ju.actualizar();
        ju.pcpromotor='';
        ju.actualizar();
        ju.pcpromotor = ' --Ninguno-- ';
        ju.actualizar();
        ju.PAIS1 = ' --Ninguno-- ';
        ju.actualizar();
        ju.PAIS1='074';
        ju.actualizar();
        ju.pcformapago = '';
        ju.v_des_procedfds='';
        ju.v_des_procedfds=null;
        ju.actualizar();            
        ju.pcformapago = '';
        ju.pcTipoFondo= '--Ninguno--';
        ju.actualizar();
        ju.actualizar();      
        ju.buscarSociotn();
        ju.ClienteNatural();
        ju.ProductoNatural();
        ju.ACTIVA =true;
        ju.PASIVA=false;
        ju.OcultarACTIVA=true;
        ju.buscarColectiva();
        ju.VALIDAR_ENVIAR_VFPRODUCTO();
        ju.pcaplicaseguro = false;
        ju.pcnroid='';
        ju.VALIDAR_ENVIAR_VFPRODUCTO();
        ju.AplicaSeguroNO = true;
        ju.actualizar();
        
        
        
        APIClienteJuridico.classBeneficiariosJuri gb = new APIClienteJuridico.classBeneficiariosJuri();
        
        gb.pnnrocertificado ='';
        gb.pcnumeroidsoc ='';
        gb.nombresocio ='';
        gb.tipo_persona ='';
        gb.nacionalidad ='';
        gb.POR_PART_DIRECT =1;
        gb.POR_PART_INDIRECT =1;
        gb.DIRECCION ='';
        gb.TIN ='';
        gb.NIVEL ='';
        gb.COT_BOLSA ='';
        gb.TIC_SYMBOL ='';
        gb.NUMERO_ID_EMPRESA ='';
        gb.POR_PART_INDIRECT =null;  
        gb.COT_BOLSA ='S';
        gb.COT_BOLSA ='N';
        gb.NIVEL ='1';
        gb.NIVEL ='2';
        gb.NIVEL ='3';
        //gb.GUARDAR2;
        
        
        
        
        //ControllerPantJuridProduc envio = new ControllerPantJuridProduc();
        
        // APIClienteJuridico.guardarCliJuridico(jur);
        //apii.classBeneficiariosJuri();  
        /*classBeneficiariosJuri lista = new classBeneficiariosJuri();
ClienteNaturales j = new ClienteNaturales();
list<beneficiario> li = new list<beneficiario>();
controllerApiClienteNatural.classPersonas gbb = new controllerApiClienteNatural.classPersonas();
test.stopTest();      */ 
        Test.stopTest();
    }   
        @isTest static void testServicioConsultaPQR(){
        Test.setMock(HttpCalloutMock.class, new IT_ServicioConsultaPQR_Test_Mock()); 
        APIClienteJuridico obj = new APIClienteJuridico();
        
        ClassPantJuridicoProduc claseEnvio = new ClassPantJuridicoProduc();
        claseEnvio.numtran = '050000';
          
        //List<String> lstValor = new List<String>();
         
        //lstValor.add(valor);
        Test.startTest();
        APIClienteJuridico.guardarCliJuridico(claseEnvio);
        Test.stopTest();
    }
            @isTest static void testServicioConsultaPep(){
        Test.setMock(HttpCalloutMock.class, new IT_ServicioConsultaPQR_Test_Mock()); 
        APIClienteJuridico obj = new APIClienteJuridico();
        
        ClassPantJuridicoProduc claseEnvio = new ClassPantJuridicoProduc();
        claseEnvio.numtran = '050000';
          
        //List<String> lstValor = new List<String>();
         
        //lstValor.add(valor);
        Test.startTest();
        APIClienteJuridico.ConsultaInfoAproPEP();
        Test.stopTest();
    }
                @isTest static void testServicioAprobarPep(){
        Test.setMock(HttpCalloutMock.class, new IT_ServicioConsultaPQR_Test_Mock()); 
        APIClienteJuridico obj = new APIClienteJuridico();
        
        ClassPantJuridicoProduc claseEnvio = new ClassPantJuridicoProduc();
        claseEnvio.numtran = '050000';
          
        //List<String> lstValor = new List<String>();
         
        //lstValor.add(valor);
        Test.startTest();
        APIClienteJuridico.aprobDenePEP('0801199415032','');
        Test.stopTest();
    }
                    @isTest static void testServicioActualizaCliente(){
        Test.setMock(HttpCalloutMock.class, new IT_ServicioConsultaPQR_Test_Mock()); 
        APIClienteJuridico obj = new APIClienteJuridico();
        
        ClassPantJuridicoProduc claseEnvio = new ClassPantJuridicoProduc();
        claseEnvio.numtran = '050000';
          
        //List<String> lstValor = new List<String>();
         
        //lstValor.add(valor);
        Test.startTest();
        APIClienteJuridico.actualizaCliente(claseEnvio);
        Test.stopTest();
    }
    

}