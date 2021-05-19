public class ControllerPantJuridProduc {
    
    //Campos propiedad y control, Esteban Romero 04-05-201
    public string numControlante{get;set;}
    public string nombreControlante{get;set;} 
    public boolean cotizaControlanteSi{get;set;} 
    public boolean cotizaControlanteNo{get;set;}
    public string numControlanteAsignado{get;set;}
    public boolean mostrarTablaControlantes{get;set;}
    public boolean mostrarTablaModiControlantes{get;set;}
    public boolean disbotControlantes{get;set;}
    public boolean PEPControlante{get;set;}
    public boolean AMLControlante{get;set;}
    public boolean FATCAControlante{get;set;}
    public boolean FATCANCControlante{get;set;}
    public boolean TickerOculControlante /*Cotiza_NO*/ {get;set;}
    
    public boolean desCheckListas{get;set;}
    public List<propiedadControl> ListPropiedadControl {get;set;}
    public propiedadControl propiedadControlUnicoUnico{get;set;}
    public boolean muestraPopPEP{get;set;}
    public boolean muestraPopFATCA{get;set;}
    public boolean muestraPopFATCANC{get;set;}
    public boolean validadosControlantes{get;set;}
    
    //Variables nuevas socios 05/05/2021
    public boolean PEPSocio{get;set;}
    public boolean AMLSocio{get;set;}
    public boolean FATCASocio{get;set;}
    public boolean FATCANCSocio{get;set;}
    public boolean validadosSocios{get;set;}
    /////
    
    
    public string CuentaMostrar /*pc_Agencia*/{get;set;}
    public string Activo /*pc_Agencia*/{get;set;}

    public string Causa /*pc_Agencia*/{get;set;}
    
    public boolean Tercera {get;Set;}
    
    public string numtran {get;Set;} //Agregado 08/04/2020
       
    public string pc_codCuenta /*pc_Agencia*/{get;set;} 
    public string tipoUsuarioProducto{get;set;} 
    public string pcagencia /*pc_Agencia*/{get;set;}
    public string pcempresa /*PCEMPRESA*/{get;set;}   
    public string pnnrocertificado /*IDFOrmulario*/{get;set;}
    public string pctipoid /*TipoID*/{get;set;}
    public string pcnroid /*NumeroID*/{get;set;}
    public datetime pcFechaVencimientoCN /*FechaVencimiento*/{get;set;} 
    public datetime pdfechasuscripcion /*FechaSuscripcion*/ {get;set;}   
    public boolean pcPEP{get;set;}
    public boolean AML{get;set;}
    public boolean pcFATCA{get;set;}
    public boolean pcFATCANC{get;set;}
    //public string AMLControlante{get;set;}
    public string pcFATCAControlante{get;set;}
    public boolean bloqcuenta {get;set;}
    public boolean bloqestado {get;set;}
    public boolean bloqcausa {get;set;}
    public boolean bloqbtnpagina {get;set;}
    // no se que es 
    public boolean despN {get;Set;}    
    public string pcprimernombre /*primerNombre*/ {get;set;}
    public string pcsegundonombre /*SegundoNombre*/ {get;set;}
    public string pcsegundoapellido /*SegundoApellido*/ {get;set;}
    public string pcprimerapellido /*primerApellido*/ {get;set;}
    public string pcTelefonoCN {get;set;}
    public string pcCelularCN /*Celular*/ {get;set;}
    public datetime pdfechanacimiento /*FechaNacimiento*/ {get;set;}
    public string pdLugarNacimientoCN /*LugarNacimiento*/ {get;set;}
    public string pcsexo /*Genero*/ {get;set;}
    public string pcestadocivil /*EstadoCivil*/ {get;set;}
    public string pcNombreConyuge {get;set;}
    public string pcProfesionOcupacion {get;set;}
    public string pcProfesionOcupacion2 {get;set;}
    public string pcProfesionOcupacionOtros {get;set;}
    public string pcmail /*Correo*/ {get;set;}
    public boolean pcAPNFDSI {get;set;}  
    public boolean pcAPNFDNO {get;set;}   
    public string PCNumeroAPNFD {get;set;}
    public string PC_NIVEL_RIESGO{get;set;}
    public string PC_DEBIDA_DELIGENCIA{get;set;}
    public boolean pc_ActuaSI{get;set;}
    public boolean pc_ActuaNO{get;set;}
    public string pc_ActuaNombreCompleto{get;set;}
    public string pc_ActuaNumID{get;set;}    
    public string pcNumeroIDPV /*NumeroIDPerfilVinculacion*/ {get;set;}
    public string pcNombreCompletoPV /*NombreCompleto*/ {get;set;}
    
    //DependenciaEconomica
    public boolean pcDependeSI /*siDependencia*/ {get;set;}
    public boolean pcDependeNO /*NoDependencia*/ {get;set;}
    public string pcTipoIDDependencia /*TipoID_DependenciaEconomica*/ {get;set;}
    public string pcNumeroIDDependencia /*NumeroID_DependenciaEconomica */ {get;set;}
    //public string pcParentescoDependencia /*Parentesco_DependenciaEconomica*/ {get;set;}
    public string pcNombreCompletoDependencia /*NombreCompleto_DependenciaEconomica*/ {get;set;}
    
    //InfoDireccion
    public string pccodpais /*Pais_Direccion*/ {get;set;}
    public string pcDeptoCN /*Depto_Direccion*/ {get;set;}
    public string pcMunicipioCN /*Municipio_Direccion*/ {get;set;}
    public string pcColoniaCN /*Colonia_Direccion*/{get;set;}
    public string pcCalleDetalleCN /*Calle_Direccion*/ {get;set;}
    public string pcnacionalidad /*Nacionalidad1_Direccion*/ {get;set;}
    public string pcnacionalidad2 /*Nacionalidad2_Direccion*/ {get;set;}
    public string pcnacionalidad3 /*Nacionalidad3_Direccion*/ {get;set;}
    public string PcNacionalidadSocios /*NacionalidadSocios*/ {get;set;}
    public boolean pcCotizaSI /*Cotiza_SI*/ {get;set;}
    public boolean pcCotizaNO /*Cotiza_NO*/ {get;set;}
    public boolean pcCotizaoOcultarSI /*Cotiza_si*/ {get;set;}
    public boolean pcCotizaoOcultarNO /*Cotiza_NO*/ {get;set;}
    public boolean TickerOcul /*Cotiza_NO*/ {get;set;}
    
    //referencias
    public string pcPrimerNombreReferi1 /*PrimerNombre_referencia*/ {get;set;}
    public string pcSegundoNombreReferi1 /*SegundoNombre_referencia*/ {get;set;}
    public string pcPrimerApellidoReferi1 /*PrimerApellido_referencia*/ {get;set;}
    public string pcSegundoApellidoReferi1 /*SegundoApellido_referencia*/ {get;set;}
    public string pcTelefono_Referido1Referi1 /*Telefono_referencia*/ {get;set;}
    
    public string pcPrimerNombreReferi2 /*PrimerNombre_referencia*/ {get;set;}
    public string pcSegundoNombreReferi2 /*SegundoNombre_referencia*/ {get;set;}
    public string pcPrimerApellidoReferi2 /*PrimerApellido_referencia*/ {get;set;}
    public string pcSegundoApellidoReferi2 /*SegundoApellido_referencia*/ {get;set;}
    public string pcTelefono_ReferidoReferi2 /*Telefono_referencia*/ {get;set;}
    
    //DatoEMpleador
    public string pccontratocolectivo{get;set;} /*contrato colectivo*/
    public string pcrncempl /*RTN*/ {get;set;}
    public string pcTipoEmpresaEmpCN /*TipoEmpresa*/ {get;set;}
    public string pcNombreempl{get;set;}/*NombreEmpresaEmpleador*/
    public string pcrazonsocialempl /*RazonSocial*/ {get;set;}
    public string pcCargoEmpresaEmpCN /*CargoEmpresa*/ {get;set;}
    public string pcGiroEmpresaEmpCN /*GiroEmpresa*/ {get;set;}
    public string pctelempl{get;set;} /*telefonoEmpleador*/
    public string pcextempl{get;set;} /*ExtensionEmpleador*/
    public string pcmailempl{get;set;} /*MailEmpleador*/
    public string llenarTipoEmpresa1 {get;set;}   
    public string llenarNivelIngreso1 {get;set;}

    //EMpleadorDIreccion
    
    public string pcPaisEmpleadorCN{get;set;}
    public string pcDeptoEmpleadorCN{get;set;}
    public string pcMunicipioEmpleadorCN{get;set;}
    public string pcColoniaEmpleadorCN{get;set;}
    Public string nacionalidadEmpleado{get;set;}
    Public string pcdirempl {get;set;}
   
    //DatoEmpleado
    
    public string pcTIpoEmpleado /*TipoEmpleado*/ {get;set;}
    public datetime pdfechainiciolabor{get;set;}
    public string pcNivelIngreso /*NivelIngreso*/ {get;set;}
    //public string pcVolumenIngresoCN /*VolumenIngreso*/ {get;set;}
    
    //DatoEmpleado
    public string pcUsuarioCN /*usuarioValidacion*/ {get;set;}
    public datetime pcFechaValidacionCN /*FechaValidacion*/ {get;set;}
    
    //PantallaProducto    
    public string pcproducto /*Producto*/ {get;set;} 
    public string pcsubproducto /*Subproducto*/ {get;set;}
    public string pcTipoFondo /*TipoFondo*/ {get;set;}
    public string pcTipoMoneda /*TipoMoneda*/ {get;set;}
    public string pcperiodicidad /*Periodicidad*/ {get;set;}
    public string pcformapago /*FormaPago*/ {get;set;}
    public boolean BloqForma /*FormaPago*/ {get;set;}
    public string pcDiaAportacion /*DiaAportacion*/ {get;set;}
    public string pnmontoaporte /*MontoAporte*/ {get;set;}
    public Integer pnmontoaporte12 {get;set;} 
    public string pccuentapago /*CuentaCTA*/ {get;set;}
    public string pcSalarioP /*salario*/ {get;set;}
    public string pcAportacionEmpleadoP /*AporEmpleado*/ {get;set;}
    public string pcAportacionTrabajoP /*AporTrabajo*/ {get;set;}
    public boolean pcaplicaseguro /*AplicaSeguroSI*/ {get;set;}
    public boolean AplicaSeguroNO {get;set;}
    public string pcPrimaAsegurada /*PrimaSeguro*/ {get;set;}
    public string pcSumaAsegurada /*MontoSeguro*/ {get;set;}
    public string pcNUMUSU /*Numusu*/ {get;set;}
    public string pcenvio /*EnvioCorreo*/ {get;set;}
    public string pcTipoAporte /*TipoAporte*/ {get;set;}    
    public string pcpromotor /*promotorProducto*/ {get;set;}
    //public string pcCanalVentas /*CanalVentas*/ {get;set;}
    
    public string vccodpais{get;set;}
       
    //DatoEmpleado
    public string usuarioValidacion{get;set;}
    public string FechaValidacion{get;set;}    
    public string Pantalla1{get;set;}
    public string Num_identidadProducto{get;set;}   
    public string llenarTipoMoneda1 {get;set;}
    public string llenarDiaAportacion1 {get;set;}
    public string Envio1 {get;set;}  
    Public string v_des_procedfds /*Origen Fondos*/  {get;set;}
    Public String Codigo_Ente /*CodigoEnte*/  {get;set;}
    Public String pctiposolicitud /*TipoSolictud "I" O "C" */  {get;set;}   
    //Public String  Parentesco1/*CodigoEnte*/  {get;set;}
    
    //CAMPOS FATCA
    public boolean ES_Residente{get;set;}
    public boolean ES_Residente_no{get;set;}
    public boolean ES_Residente_EfectosMi{get;set;}
    public boolean ES_Residente_EfectosMiNO{get;set;}
    public string PaisResidenciaEfectosFiscales{get;set;}
    public string NumeroID_Fiscal_EEUU{get;set;}
    public string NumeroID_Fiscal_OtroPais{get;set;}
    public string Acepto_Terminos{get;set;}
    
    public boolean OcultarResidencia {get;set;}  
    public boolean OcultarResidenciaNO {get;set;}  
   
    public boolean OcultarES_Residente_EfectosMi {get;set;}  
    public boolean OcultarES_Residente_EfectosNO {get;set;} 
    public boolean BloquearBtnID {get;set;}
    public boolean BloquearBtnCu {get;set;}
    
    
    //campos agregados para la parte Juridico
                        public boolean COT_BOLSASI {get;set;}
    					public boolean COT_BOLSANO {get;set;}
                        public string  TIC_SYMBOL  {get;set;}
                         public boolean OTROS_OBLIGSI {get;set;}
    					 public boolean OTROS_OBLIGNO {get;set;}
                         public string PAIS1   {get;set;}
                         public string PAIS2  {get;set;}
                         public string PAIS3  {get;set;}
                         public string DEPTO1  {get;set;}
                         public string DEPTO2  {get;set;}
                         public string DEPTO3  {get;set;} 
                         public string COD_CTE_FIR1 {get;set;}
                         public string COD_CTE_FIR2 {get;set;}
                         public string COD_CTE_FIR3 {get;set;}
                         public string NUM_ID_CONTR_SOCI {get;set;}
                         public string NOMBRE_CONTR_SOC {get;set;} 
                         public string REF1_PROVE_NOMB   {get;set;}
                         public string REF1_PROVE_PRODUC {get;set;}
                         public string REF1_PROVE_TEL {get;set;}
                         public string REF2_PROVE_NOMB  {get;set;}
                         public string REF2_PROVE_PRODUC {get;set;}
                         public string REF2_PROVE_TEL {get;set;}
                         public string REF1_BANCA_NOMB  {get;set;}
                         public string REF1_BANCA_TEL {get;set;}
                         public string REF2_BANCA_NOMB  {get;set;}  
                         public string REF2_BANCA_TEL {get;set;}
                          
                          //--NOM_RAZON_SOCIAL IN VARCHAR,  
                       //--   NOM_COMERCIAL IN VARCHAR,
                          public string NUM_TOT_EMPLEADOS {get;set;}
                          public string PAIS_CONSEMP {get;set;}
                          public string FECINSCR_CONSEMP {get;set;}
                          public string NUM_ACCIONISTAS {get;set;}
                          public string AMPLIAR_ACT_ECONOMICA {get;set;}
                          public string MTO_APROX_ACTIVO {get;set;}
                          public string COD_ACTIVIDAD  {get;set;}
                          public date FECHA_CONSTITUCION {get;set;}
                          public string COD_REPRE_LEGAL {get;set;}
    					  public string DIR_CORRESPONDENCIA {get;set;}
    					  public string GIIN {get;set;}
    					  public string ENTIDAD_FINANCIERA {get;set;}
    					  public string ACC_10DE_CONTROL {get;set;}
    					  public string INST_FINANCIERA {get;set;}
    					  public string TIP_ENTIDAD {get;set;}
    					  public string ACTIV_PASIVO {get;set;}
    

    
    public boolean Indirectoo {get;set;}  
    public boolean ENTIDADSI {get;set;}  
    public boolean ENTIDADNO {get;set;}   
    public boolean SOCIOSI {get;set;}  
    public boolean SOCIONO {get;set;}  
    public boolean ACC_10DE_CONTROLSI {get;set;}  
    public boolean ACC_10DE_CONTROLNO {get;set;}  
    public boolean ACTIVA {get;set;}  
    public boolean PASIVA {get;set;} 
    public boolean Fatca1 {get;set;}  
    public boolean Fatca2 {get;set;} 
    public boolean Fatca3 {get;set;}  
    public boolean Fatca4 {get;set;} 
    public boolean Fatca5 {get;set;}  
    
    
    public boolean Fatca6 {get;set;} 
    public boolean Fatca7 {get;set;}  
    public boolean Fatca8 {get;set;} 
    public boolean Fatca9 {get;set;}  
    public boolean Fatca10 {get;set;} 
    public boolean Fatca11 {get;set;}  
    public boolean Fatca12 {get;set;} 
    public boolean Fatca13 {get;set;}  
    public boolean Fatca14 {get;set;} 
    public boolean Fatca15 {get;set;}  
    public boolean Fatca16 {get;set;} 
    public boolean Fatca17 {get;set;}  
    public boolean TINS {get;set;} 
    public boolean SOCIO {get;set;}
    public boolean GIINSI {get;set;}
    public boolean TIPO_ENTIDADSI {get;set;}
    public boolean Segun_pais {get;set;}
    public boolean Segun_depto {get;set;}
    public boolean Firmante_RL {get;set;}
    
    
    PUBLIC string NOM_FIRMAN1 {get;set;}
    
    PUBLIC string NombreRL {get;set;}
    PUBLIC string CargoRL {get;set;}
    				      PUBLIC string NOM_FIRMAN2 {get;set;}
                          PUBLIC string NOM_FIRMAN3 {get;set;}
                          PUBLIC string NUMID_FIRMAN1 {get;set;}
    				      PUBLIC string NUMID_FIRMAN2 {get;set;}
                          PUBLIC string NUMID_FIRMAN3 {get;set;}
    
    
    
    
    
    //Variables TerceraPersona
    
    public boolean OcultaTerSI {get;set;}  
    public boolean OcultaTerNO {get;set;}  
    public boolean OcultaTerSI_1 {get;set;}  
    public boolean OcultaTerNO_2 {get;set;} 
    
    //Variables Cargo publico
    public boolean OcultaCarSI  {get;set;}  
    public boolean OcultaCarNO  {get;set;}  
    public boolean OcultaCarSI_1  {get;set;}  
    public boolean OcultaCarNO_2 {get;set;} 
    public boolean Cargoo  {get;set;} 
    public string pcCargoEjercido /*Cargo Familiar*/ {get;set;}
    
    //TotalDistrbucion Beneficiarios
    public Integer TotalDistri{get;set;}
    
    //public date x_date{get;set;}
    public Account Cliente25{get;set;}
    
    public Colonias_U__c prueba1 {get;set;}
    public Cuentas__c Cuenta20 {get; set;}
    public Beneficiario__c Cuenta22 {get; set;}
    //public Beneficiario__c ParentezcoDependen {get; set;}
    
    //Para El TipoID 
    public Account Cliente1{get;set;}
    public Account Cliente2{get;set;}
    public Account Cliente3{get;set;}
    public Account Cliente4{get;set;}
    public Account Cliente5{get;set;}
    public Account Cliente6{get;set;}
    public Account Cliente7{get;set;}
    public Account ClienteTipoId {get;set;}
    public Account ClienteTipoIdDepende{get;set;}
    public Account TipoSexo{get;set;}
    public Account TipoEmpresa{get;set;}
    public Account TipoProfesion{get;set;}
    public Account TipoProfesion1{get;set;}
    public Account DiaMes{get;set;}
    public Account TipoBeneficiario{get;set;}
    public Account TipMoneda{get;set;}
    Public Account TipoAport{get;set;}
    Public Account TipoProfesionOcupacionOtros{get;set;}
    Public Account TipoEnvioo{get;set;}
    Public Account TipoEstadoCivil{get;set;}
    Public Account NivelTDilegencia{get;set;}
    Public Account NivelTRiesgo{get;set;}
    
    Public Account CanalVentaa{get;set;}
    Public Account Gradop2{get;set;}
    Public Account Gradop3{get;set;}
    Public Account Gradop4{get;set;}
    Public Account Gradop5{get;set;}
    Public Account Gradop6{get;set;}
    Public Account Gradop7{get;set;}
    
    public Beneficiario__c Cuenta2{get;set;}
    public Beneficiario__c Cuenta3{get;set;}
    public Beneficiario__c Cuenta4{get;set;}
    public Beneficiario__c Cuenta5{get;set;}
    public Beneficiario__c Cuenta6{get;set;}
    public Beneficiario__c Cuenta7{get;set;}
    
    //public Tipo_trabajador__c Cuenta22 {get; set;}
    
    
    //public Pais_O Cliente20{get;set;}   
    
    public boolean dispep{get;set;} 
    public boolean dispepEmple{get;set;} //Tipo empleado
    public boolean actPop{get;set;}
    public boolean actPopAgregarCliente{get;set;}
    public integer valor{get;set;}
    public boolean disbot{get;set;}
    public integer selectops{get;set;}
    public boolean desCheckb{get;set;}
    public boolean BloquearConyugue {get;Set;} //BLOQUEA EL NOMBRE DEL CONYUGUE 
    public boolean VentanaAyuda {get;Set;}
    public boolean VentanaFatca{get;Set;}
    public boolean BloqTiFondo {get;Set;}
    public string  NumbTINTable {get;Set;}
    public string  NumIDBuscar{get;set;} 
    public boolean desNacion2 {get;Set;}
    public boolean Paisopera1 {get;Set;}
    public boolean deptoopera1 {get;Set;}
    public boolean pc_CamposActua {get;set;}
    public boolean validar1 {get;set;}
    
    
    public List<SelectOption> options {get;set;}
    public List<SelectOption> optionsEmpleado {get;set;}
    
    public List<SelectOption> opcionPais {get;set;}
    public List<SelectOption> opcionDepartamento {get;set;}
    public List<SelectOption> opcionMunicipio {get;set;}
    public List<SelectOption> opcionColonia {get;set;}
    public List<SelectOption> opcionNacionalidad {get;set;}
    public List<SelectOption> opcionNacionalidadTerceros {get;set;}
    public List<SelectOption> opcionNacionalidadSegundos {get;set;}
    public List<SelectOption> opcionPaisEmpleado {get;set;}
    public List<SelectOption> opcionDepartamentoEmpleado {get;set;}
    public List<SelectOption> opcionMunicipioEmpleado {get;set;}
    public List<SelectOption> opcionColoniaEmpleado {get;set;}
    public List<SelectOption> opcionNacionalidadEmpleado {get;set;}
    public List<SelectOption> OpcionPAIS1 {get;set;}
    public List<SelectOption> OpcionPAIS2 {get;set;}
    public List<SelectOption> OpcionPAIS3 {get;set;}
    public List<SelectOption> OpcionDEPTO1 {get;set;}
    public List<SelectOption> OpcionDEPTO2 {get;set;}
    public List<SelectOption> OpcionDEPTO3 {get;set;}
    public List<SelectOption> opcionNacionalidadSocios {get;set;}
        
    public string MostrarCUENTT {get;set;}
    
    
    
    
    
    public boolean mostrarBoton{get;set;}
    public boolean mostrarBotonPan{get;set;}
    public boolean mostrarSiguientePan{get;set;}
    
    public boolean mostrarBotonEmpleador{get;set;}
    public boolean mostrarSiguiente{get;set;}
    public boolean mostrarAnterior{get;set;}  
    public boolean mostrarSiguienteEmpleador{get;set;}
    public boolean mostrarAnteriorEmpleador{get;set;}      
    
    public boolean MostarGuardar {get;set;}
    public boolean MostarActualizar {get;set;}
    public string mensaje3{get;set;} 
    public list<Colonias_U__c> listColonias{get;set;}
    integer paginacion;
    integer paginacionEmpleador;
    //Lista para mostrar los datos de beneficiarios
    //
    public List<socios> ListSocios {get;set;}
    public socios socioUnico{get;set;}
    
    public List<SociosTIN> ListSociosTIN {get;set;}
    public SociosTIN socioUnicoTIN {get;set;}
    
    
    
    //lista para mostrar los datos de la cuenta 
    public List<Class_CuentasTraer> ListClass_CuentasTraer {get;set;}
    public Class_CuentasTraer cuentaUnico{get;set;}

    public boolean Prob1{get;set;}

    public List<SelectOption> opcionCausa {get;set;}
    
    //Lista para traer los productos
    public List<SelectOption> opciones {get;set;}
    public List<SelectOption> opcionSubproducto {get;set;}
    public List<SelectOption> OpcionMoneda {get;set;}
    //Fin
    
    public string pagina{get;set;}
    public static string ClienteNatural {get;set;}
    public static string ProductoNatural {get;set;}
    public string paso1Cabeza{get;set;}
    public string paso1Cuerpo{get;set;}
    
    public string paso2Cabeza{get;set;}    
    public string paso2Cuerpo{get;set;}
    
    public boolean MostraVentana{get;set;}
	public boolean mostrarTabla{get;set;}
    public boolean disbotBene{get;set;}
    public boolean Bene_Ocultar_CamPos{get;set;}
    public boolean Dis_Ocultar{get;set;}
    public boolean Dis_OcultarDependenciaSI{get;set;}
    public boolean Dis_OcultarDependenciaNO{get;set;}
    public boolean Dis_OcultarDependenciaCampos{get;set;}
    public boolean OcultarSeguroNO{get;set;}
   // public boolean OcultarSeguroSI{get;set;}
   // public boolean OcultarSeguroCampos{get;set;}
    public boolean OcultarAPNFD {get;set;}  
    public boolean OcultarAPNFDNO {get;set;}  
    public boolean NumeroAPNFDBLO {get;set;}  
    public boolean BuscarCuentas {get;set;} 
    public boolean mostrarTabla2{get;set;}
    public boolean OcultarActuaSI{get;set;}
    public boolean OcultarActuaNO{get;set;}
    public boolean pc_Actuano_no{get;set;}
    
    public boolean OcultarEntidad{get;set;}
    public boolean OcultarEntidadNo{get;set;}
    public boolean NadaEntidad{get;set;}
    
    
    public string Prueba2{get;set;}  
    public string Prueba{get;set;}   
    public boolean OcultarCOT_BOLSASI {get;set;}
    public boolean OcultarCOT_BOLSANO {get;set;}
    public boolean OcultarOTROS_OBLIGSI {get;set;}
    public boolean OcultarOTROS_OBLIGNO {get;set;}
    public boolean OcultarACC_10DE_CONTROLSI  {get;set;}
    public boolean OcultarACC_10DE_CONTROLNO  {get;set;}
    public boolean OcultarACTIVA  {get;set;}
    public boolean OcultarPASIVA  {get;set;}
    
    public boolean OcultarFatca1 {get;set;}  
    public boolean OcultarFatca2 {get;set;} 
    public boolean OcultarFatca3 {get;set;}  
    public boolean OcultarFatca4 {get;set;} 
    public boolean OcultarFatca5 {get;set;}  
    public boolean OcultarFatca6 {get;set;} 
    public boolean OcultarFatca7 {get;set;}  
    public boolean OcultarFatca8 {get;set;} 
    public boolean OcultarFatca9 {get;set;}  
    public boolean OcultarFatca10 {get;set;} 
    public boolean OcultarFatca11 {get;set;}  
    public boolean OcultarFatca12 {get;set;} 
    public boolean OcultarFatca13 {get;set;}  
    public boolean OcultarFatca14 {get;set;} 
    public boolean OcultarFatca15 {get;set;}  
    public boolean OcultarFatca16 {get;set;} 
    public boolean OcultarFatca17 {get;set;}  
	public boolean btnagregar {get;set;}
    
    
    public void ClienteNatural()     
    {  
        pagina = 'VFPantallaClientesNaturales'; 
        ClienteNatural = 'slds-is-current';
        ProductoNatural  = 'slds-is-incomplete';
    }
    
    public void ProductoNatural()
    {  
        pagina = 'VFPantallaProducto';
        ProductoNatural = 'slds-is-current';
        ClienteNatural = 'slds-is-complete';

    }

        public ControllerPantJuridProduc() 
        {
            desCheckListas = true;
            activadesacContratista = true;
        	activadesacONG = true;
            validadosControlantes = true;
            validadosSocios = true;
        	ListClienteONG = new List<DebidaDiliClienteONG>();
        	ClienteONG = new DebidaDiliClienteONG(0,'','','','','','','',null);
        	ListDebidaDil = new List<claseDebidaDilContratista>();
        	debidaDil  = new claseDebidaDilContratista (null,'','','','','', '', '',null,'');
        	OcultarEmpresaSI = true;
	    	OcultarEmpresaNO = true;
        	OcultarAccionistaSI = true;
        	OcultarAccionistaNO = true;
        	OcultarPersonaUSASI = true;
        	OcultarPersonaUSANO = true;
            
            btnagregar=false;
            bloqcuenta=true;
            bloqestado=true;
            bloqcausa=true;
            bloqbtnpagina=false;
            Indirectoo = true;
            TickerOcul = true;
            TickerOculControlante = true;
            Paisopera1= true;
            deptoopera1=true;
            ///////
            //TipoAport.Tipo_Aporte__c = 'F';
            pc_CamposActua = true;
            iniciar();
            MostarGuardar=false;
            MostarActualizar=false;
            llenaTipoId();
            asesores();
            llenaAPNFD();
            ocultaLista = true;
            
            Cliente25 = new Account();
            
            prueba1 = new Colonias_U__c();
            ListaNivelSocio();
            
            //PARA EL TIPO DE ID
            Cliente1 = new Account();
            Cliente2 = new Account();
            Cliente3 = new Account();
            Cliente4 = new Account();
            Cliente5 = new Account();
            Cliente6 = new Account();
            Cliente7 = new Account();
            ClienteTipoId = new Account();
            ClienteTipoIdDepende = new Account();
            TipoSexo = new Account();
   			TipoEmpresa = new Account();
            TipoProfesion = new Account();
            TipoProfesion1 = new Account();
            TipoProfesionOcupacionOtros = new Account();
            DiaMes = new Account();
            TipoBeneficiario = new Account();
            TipMoneda = new Account();
            TipoAport = new Account();
            TipoEnvioo =  new Account();
            TipoEstadoCivil = new Account();
            NivelTRiesgo = new Account();
			NivelTDilegencia  = new Account();
            CanalVentaa = new Account();
             Gradop2 = new Account();
             Gradop3 = new Account();
             Gradop4 = new Account();
             Gradop5 = new Account();
             Gradop6 = new Account();
             Gradop7 = new Account();
            //PARA EL GENERO
            
            Cuenta2 = new Beneficiario__c();
            Cuenta3 = new Beneficiario__c();
            Cuenta4 = new Beneficiario__c();
            Cuenta5 = new Beneficiario__c();
            Cuenta6 = new Beneficiario__c();
            Cuenta7 = new Beneficiario__c();
            
            //FIN 
            Cuenta20 = new Cuentas__c();
            Cuenta22 = new Beneficiario__c();
            socioUnico = new socios(null,'', '', '', '', '', '', '', '', null, null,'','','');
            socioUnicoTIN = new SociosTIN(null,'', '', '', '');
            propiedadControlUnicoUnico = new propiedadControl(null,'', '', '', '', '', '', '', '', null, null,'','','','');
            
            cuentaUnico = new Class_CuentasTraer('');
             options=new List<SelectOption>();
           
            options=new List<SelectOption>();
            TipoFondoOptions= new List<SelectOption>();
            
            opcionCausa=new List<SelectOption>();
            TipoCausaOptions= new List<SelectOption>();
            
            options=new List<SelectOption>();
            TipoCuentaOptions= new List<SelectOption>();
            
            options=new List<SelectOption>();
            opciones=new List<SelectOption>();
            OpcionMoneda = new List<SelectOption>();
            llenarProductos();
            opcionSubproducto = new List<SelectOption>();
            llenarSubproductos();
    		
            ListSocios = new List<socios>();
            ListSociosTIN = new List<SociosTIN>();
            ListPropiedadControl = new List<propiedadControl>();
            ListClass_CuentasTraer = new List<Class_CuentasTraer>();
            options=new List<SelectOption>();
            optionsEmpleado=new List<SelectOption>();
              //Para productos y subproductos
            opcionPais=new List<SelectOption>();
            opcionPaisEmpleado =new List<SelectOption>();
            opcionDepartamento=new List<SelectOption>();
            opcionDepartamentoEmpleado=new List<SelectOption>();
            
            OpcionPAIS1= new list<SelectOption>();
            OpcionPAIS2= new list<SelectOption>();
            OpcionPAIS3= new list<SelectOption>();
            OpcionDEPTO1= new list<SelectOption>();
            OpcionDEPTO2= new list<SelectOption>();
            OpcionDEPTO3= new list<SelectOption>();
            TipoFondoOptions=new list<SelectOption>();
            
            llenarPais();
            llenarDepartamento();
            llenarMunicipio(); 
            llenarColonia();
            llenarNacionalidad();
            llenarNacionalidadTerceros();
            llenarNacionalidadSegundos();
            
            llenarPAIS1();
            llenarPAIS2();
            llenarPAIS3();
            llenarDEPTO1();
            llenarDEPTO2();
            llenarDEPTO3();           

			bloqeListEnti = true;            
            llenarPaisEmpleado();
            llenarDepartamentoEmpleado();
            llenarMunicipioEmpleado();
            llenarColoniaEmpleado();
            llenarNacionalidadEmpleado();
            llenarNivelIngreso();
            llenarTipoCuenta();
            llenarTipoCausa();
            llenarTipoFormaPago();
            llenarNacionalidadSocios();
            
            despN = false;   
            disbot = true; 
            Dis_Ocultar = true;
            
            
            pctiposolicitud = 'C';
			pcagencia = '101';
            PCEMPRESA = '2';
            BloquearConyugue = true;
            NumeroAPNFDBLO = true;
            OcultarACC_10DE_CONTROLSI= TRUE;
            OcultarACC_10DE_CONTROLNO= TRUE;
            OcultarACTIVA    = true;
            OcultarPASIVA    = true;
            OcultarFatca1 = TRUE;
     		OcultarFatca2 = TRUE; 
     		OcultarFatca3 = TRUE;
     		OcultarFatca4 = TRUE; 
     		OcultarFatca5 = TRUE;
     		OcultarFatca6  = TRUE;
     		OcultarFatca7 = TRUE;
     		OcultarFatca8  = TRUE;
     		OcultarFatca9 = TRUE;
     		OcultarFatca10  = TRUE;
     		OcultarFatca11 = TRUE;
     		OcultarFatca12  = TRUE;
     		OcultarFatca13 = TRUE;
     		OcultarFatca14  = TRUE;
     		OcultarFatca15 = TRUE;
     		OcultarFatca16  = TRUE;
     		OcultarFatca17 = TRUE;
            TINS =  false;
            SOCIO = TRUE;
            GIINSI = TRUE;
            TIPO_ENTIDADSI = TRUE;
            Firmante_RL = true;
            llenarNivelRiesgo();
            llenarDeligencia(); 
            llenarTipoFondo();
            TipMoneda.Tipo_Moneda__c = null;
            
            PC_NIVEL_RIESGO = '2';
			PC_DEBIDA_DELIGENCIA = '2';
            desNacion2 = true; 
            TipoEntidadLLenar();
            
             /*paso1Cabeza = 'slds-is-complete';
	            paso1Cuerpo = 'slds-hide';
	            
	            paso2Cabeza = 'slds-is-current';
	            paso2Cuerpo = 'slds-show'; */  
     }
    
   
    public void iniciar(){    
        paso1Cabeza = 'slds-is-current';
        paso1Cuerpo = 'slds-show';
        
        paso2Cabeza = 'slds-is-incomplete';
        paso2Cuerpo = 'slds-hide';
    }
    
    public void validarControlantes()
    {

        try{
            classListas claseEnvio = new classListas();
            classListas fcsd = controllerApiClienteNatural.consultaListas(numControlante);
            
            if(numControlante ==''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Número de identificación vacio'));	
            }else{
                
                system.debug(fcsd.FATCA);
                
                if(fcsd.PEP == true||test.isRunningTest()){
                    PEPControlante = fcsd.PEP;
                    PC_NIVEL_RIESGO = '3';
                    PC_DEBIDA_DELIGENCIA = '3';
                    //bloqRTN = false;
                    OcultaCarSI = true;
                    OcultaCarNO_2 = true;
                    Cargoo = false;
                    muestraPopPEP = true;
                }
                if(fcsd.FATCA == true||test.isRunningTest()){ 
                    muestraPopFATCA = true;
                    FATCAControlante = true;
                }
                if(fcsd.FATCANC == true||test.isRunningTest()){ 
                    muestraPopFATCANC = true;
                    FATCANCControlante = true;
                }
                
                if(fcsd.AML == true||test.isRunningTest()){
                    AML = fcsd.AML;
                }
                if(fcsd.BLACKLIST == true||test.isRunningTest()){
                    AML = fcsd.BLACKLIST;
                    actPop = true; 
                }
                /*if(fcsd.PEP == true||test.isRunningTest()){
                    dispep = true;   
                }*/
                
                validadosControlantes = false;
                validar1 = true;
                
            }
            //String resultado = controllerApiUsuarioNatural.BuscarUsuarioNatural(claseEnvio);
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,resultado));
            desCheckb =  true;
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se encontró Cliente'));	    
        }
    }
    
    public void enviarPagPro()
    {   
        paso1Cabeza = 'slds-is-complete';
        paso1Cuerpo = 'slds-hide';
        
        paso2Cabeza = 'slds-is-current';
        paso2Cuerpo = 'slds-show';           
    }
    
    
    public void BtnCancelar()
    {   
        disbot=false;
        paso2Cuerpo = 'slds-hide';
        
        paso1Cabeza = 'slds-is-current';
        paso1Cuerpo = 'slds-show';    
    }

    //Productos 
    public void llenarProductos(){
        try
        {   opciones.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Producto__c item:[select name, codigo__c from Producto__c ]) { opciones.add(new selectOption(item.codigo__c, item.name));
            }
        }catch(exception e){
            
        }
    }
    
     public void llenarSubproductos(){
        try
        {
            opcionSubproducto = new list <selectOption>();
            opcionSubproducto.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Subproducto__c item:[select name, codigo__c from Subproducto__c where producto__r.codigo__c =: pcproducto])
            {
                opcionSubproducto.add(new selectOption(item.codigo__c, item.name));
            }
            
            
            if(pcproducto == '01' ||pcproducto == '03') {TipMoneda.Tipo_Moneda__c = '1';}
            else
           {
               TipMoneda.Tipo_Moneda__c = '2';
               
            }
                
                
                
       
            
        }catch(exception e){
            
        }
    }
    
        public list <selectOption> listaTipoId {get; set;}
    public void llenaTipoId(){
        
		listaTipoId = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Tipo_Identificacion__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        map<string, string> mapisv= new map<string, string>();
        listaTipoId.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
     		listaTipoId.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    
    public boolean ocultaLista {get; set;}
    
     public list <selectOption> listaAPNFD {get; set;}
    public void llenaAPNFD(){
        
		listaAPNFD = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Actividad_APNFD__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        map<string, string> mapisv= new map<string, string>();
        listaAPNFD.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
     		listaAPNFD.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    
   public string pcListEntidad {get; set;}
   public list <selectOption> ListNivel {get; set;}
    public void ListaNivelSocio(){
        
		ListNivel = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Tipo_Nivel_Socios__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        map<string, string> mapisv= new map<string, string>(); 
        ListNivel.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
     		ListNivel.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    
   
    
    
    // tABALA FUNCIONES
    PUBLIC VOID GUARDAR2()
    {
        try
        {

            socioUnico.tipo_persona = Cliente1.Tipo_Persona__c;
            socioUnico.pcnumeroidsoc = pcnumeroidsocc;
            socioUnico.nombresocio = socioUnico.nombresocio;
            socioUnico.tipo_persona= socioUnico.tipo_persona; 
            socioUnico.nacionalidad=socioUnico.nacionalidad;
            socioUnico.POR_PART_INDIRECT=socioUnico.POR_PART_INDIRECT;
            decimal total2=decimal.valueOf(socioUnico.POR_PART_DIRECT); 
            
            if (pcCotizaSI == true )
            {
                 socioUnico.COT_BOLSA = 'S';
            }
            ELSE
            {
                socioUnico.COT_BOLSA = 'N'; 
            }
            if (PEPSocio== true )
            {
                 socioUnico.PEPSocio = 'S';
            }
            ELSE
            {
                socioUnico.PEPSocio = 'N'; 
            }
            if (FATCASocio == true )
            {
                 socioUnico.FATCASocio = 'S';
                if(socioUnico.POR_PART_DIRECT > 10){
                    pcFATCA = true;
                }
            }
            else{
                socioUnico.FATCASocio = 'N';
            }
            if (FATCANCSocio == true )
            {
                 socioUnico.FATCANCSocio = 'S';
            }
            else{
                socioUnico.FATCANCSocio = 'N';
            }
            
            if(socioUnico.pcnumeroidsoc != null || socioUnico.nombresocio != null || socioUnico.tipo_persona != null || 
               socioUnico.nacionalidad != null || socioUnico.POR_PART_DIRECT != null || socioUnico.POR_PART_INDIRECT != null )
            {    
           
             
 				if( socioUnico.NIVEL=='1')
                {
                    for(integer i=0; i<ListSocios.size(); i++)
                {
                    total2 +=decimal.valueOf(ListSocios[i].POR_PART_DIRECT);
                }
                }
              
            if (socioUnico.NIVEL=='2')
                {
                   for(integer j=0; j<ListSocios.size(); j++)
                       {
                           total2=0;
                          }               
                }
                
            if (socioUnico.NIVEL=='3' || socioUnico.NIVEL=='4' || socioUnico.NIVEL=='5' || socioUnico.NIVEL=='6' || socioUnico.NIVEL=='7' || socioUnico.NIVEL=='8'|| socioUnico.NIVEL=='9' || socioUnico.NIVEL=='10' || socioUnico.NIVEL=='11' || socioUnico.NIVEL=='12' || socioUnico.NIVEL=='13' || socioUnico.NIVEL=='14' || socioUnico.NIVEL=='15')
                {
                   for(integer i=0; i<ListSocios.size(); i++)
                       {
                           total2=0;}
                    }    
                             
            if( socioUnico.NIVEL=='1' && total2 >100 )
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Se Puede Agregar, El porcentaje directo es mayor que 100'));
            }
            else
            {
                if (mostrarTablaModifi2 == true)
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!'));
                    mostrarTabla = false;
                    socioUnico.AI_ID_EXTERNO= socioUnico.AI_ID_EXTERNO;
                    ListSocios.add(socioUnico);
                    socioUnico = new socios(null,'', '', '', '', '', '', '', '', null, null, '', '', '');
                    disbotBene = true;
                    limpiabenefici();
                } 
                else
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!'));
                    mostrarTabla = true;
                    mostrarTablaModifi2 = false;
                    ListSocios.add(socioUnico);
                    socioUnico = new socios(null,'', '', '', '', '', '', '', '', null, null, '', '', '');
                    disbotBene = true; 
                    limpiabenefici(); 
                } 
                
            }
                          
            }
            
            else
            { 
    
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Se Permiten Campos Vacios En Beneficiarios'));
                
              } //FIN DEL IF DE VALIDACION 
            
          
        }
        catch(exception e)
        {
            
        }
    }
	PUBLIC VOID guardarControlante()
    {
        try
        {

            propiedadControlUnicoUnico.tipoPersonaControlante = Cliente1.Tipo_Persona__c;
            propiedadControlUnicoUnico.numControlante = numControlante;
            propiedadControlUnicoUnico.nombreControlante = nombreControlante;
            propiedadControlUnicoUnico.tipoPersonaControlante = propiedadControlUnicoUnico.tipoPersonaControlante; 
            propiedadControlUnicoUnico.nacionalidadControlante = propiedadControlUnicoUnico.nacionalidadControlante;
            propiedadControlUnicoUnico.porcentajeInControlante = propiedadControlUnicoUnico.porcentajeInControlante;
            decimal total2=decimal.valueOf(propiedadControlUnicoUnico.porcentajeDiControlante);
            
            if (cotizaControlanteSi == true )
            {
                 propiedadControlUnicoUnico.cotBolsaControlante = 'S';
            }
            ELSE
            {
                propiedadControlUnicoUnico.cotBolsaControlante = 'N'; 
            }
            if (PEPControlante == true )
            {
                 propiedadControlUnicoUnico.PEPControlante = 'S';
            }
            ELSE
            {
                propiedadControlUnicoUnico.PEPControlante = 'N'; 
            }
            if (FATCAControlante == true )
            {
                 propiedadControlUnicoUnico.FATCAControlante = 'S';
                if(propiedadControlUnicoUnico.porcentajeDiControlante > 10){
                    pcFATCA = true;
                }
            }
            ELSE
            {
                propiedadControlUnicoUnico.FATCAControlante = 'N'; 
            }
            if (FATCANCControlante == true )
            {
                 propiedadControlUnicoUnico.FATCANCControlante = 'S';
            }
            ELSE
            {
                propiedadControlUnicoUnico.FATCANCControlante = 'N'; 
            }
            
            
            if(propiedadControlUnicoUnico.numControlante != null || propiedadControlUnicoUnico.nombreControlante != null || propiedadControlUnicoUnico.tipoPersonaControlante != null || 
               propiedadControlUnicoUnico.nacionalidadControlante != null || propiedadControlUnicoUnico.porcentajeDiControlante != null || propiedadControlUnicoUnico.porcentajeInControlante != null )
            {    
           
             
 				if( propiedadControlUnicoUnico.nivelControlante == '1')
                {
                    for(integer i=0; i<ListPropiedadControl.size(); i++)
                {
                    total2 +=decimal.valueOf(ListPropiedadControl[i].porcentajeDiControlante);
                }
                }
              
            if (propiedadControlUnicoUnico.nivelControlante == '2')
                {
                   for(integer j=0; j<ListPropiedadControl.size(); j++)
                       {
                           total2=0;
                          }               
                }
                
            if (propiedadControlUnicoUnico.nivelControlante > '2')
                {
                   for(integer i=0; i<ListPropiedadControl.size(); i++)
                       {
                           total2=0;}
                    }    
                             
            if( propiedadControlUnicoUnico.nivelControlante == '1' && total2 >100 )
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Se Puede Agregar, El porcentaje directo es mayor que 100'));
            }
            else
            {
                if (mostrarTablaModiControlantes == true)
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!'));
                    mostrarTablaControlantes = false;
                    propiedadControlUnicoUnico.AI_ID_EXTERNO= propiedadControlUnicoUnico.AI_ID_EXTERNO;
                    ListPropiedadControl.add(propiedadControlUnicoUnico);
                    propiedadControlUnicoUnico = new propiedadControl(null,'', '', '', '', '', '', '', '', null, null, '', '', '', '');
                    disbotControlantes = true;
                    limpiaControlantes();
                } 
                else
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!'));
                    mostrarTablaControlantes = true;
                    mostrarTablaModiControlantes = false;
                    ListPropiedadControl.add(propiedadControlUnicoUnico);
                    propiedadControlUnicoUnico = new propiedadControl(null,'', '', '', '', '', '', '', '', null, null, '', '', '', '');
                    disbotControlantes = true; 
                    limpiaControlantes(); 
                } 
                
            }
                          
            }
            
            else
            { 
    
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se permiten campos cacios En Propiedad y Control'));
                
              } //FIN DEL IF DE VALIDACION 
            
          
        }
        catch(exception e)
        {
            
        }
    }
    public void limpiaControlantes()
    {
        numControlante = null;
        propiedadControlUnicoUnico.nombreControlante = null;
        Cliente1.Tipo_Persona__c=null;
        propiedadControlUnicoUnico.nacionalidadControlante = null;
        propiedadControlUnicoUnico.nivelControlante = null;
        propiedadControlUnicoUnico.porcentajeDiControlante = null;
        propiedadControlUnicoUnico.porcentajeInControlante = null;
        propiedadControlUnicoUnico.numIdEmpresaControlante = null;
        propiedadControlUnicoUnico.cargoControlante = null;
        cotizaControlanteSi = false;
        cotizaControlanteNo = false;
        PEPControlante = false;
        FATCAControlante = false;
        FATCANCControlante = false;
        propiedadControlUnicoUnico.ticSymbolControlante = null;
        validadosControlantes = true;
        
    }
    PUBLIC VOID modificarControlantes()
    {	decimal total2=0;
     	if(propiedadControlUnicoUnico !=null){total2=propiedadControlUnicoUnico.porcentajeDiControlante!=null ?decimal.valueOf(propiedadControlUnicoUnico.porcentajeDiControlante):0;}
         try
         { integer posi;
         	for(integer i=0; i<ListPropiedadControl.size(); i++)
            {
            	if(ListPropiedadControl[i].numControlante == string.valueOf(numControlanteAsignado))   
                 {
                     posi=i;
                     numControlante=ListPropiedadControl[i].numControlante;
                     propiedadControlUnicoUnico.nombreControlante = ListPropiedadControl[i].nombreControlante;
                     Cliente1.Tipo_Persona__c=ListPropiedadControl[i].tipoPersonaControlante;
                     propiedadControlUnicoUnico.nacionalidadControlante=ListPropiedadControl[i].nacionalidadControlante;
                     propiedadControlUnicoUnico.nivelControlante=ListPropiedadControl[i].nivelControlante;
                     propiedadControlUnicoUnico.PEPControlante=ListPropiedadControl[i].PEPControlante;
                     propiedadControlUnicoUnico.FATCAControlante=ListPropiedadControl[i].FATCAControlante;
                     propiedadControlUnicoUnico.FATCANCControlante=ListPropiedadControl[i].FATCANCControlante;
                     propiedadControlUnicoUnico.porcentajeDiControlante=ListPropiedadControl[i].porcentajeDiControlante;
                     propiedadControlUnicoUnico.porcentajeInControlante=ListPropiedadControl[i].porcentajeInControlante;
                     propiedadControlUnicoUnico.numIdEmpresaControlante=ListPropiedadControl[i].numIdEmpresaControlante;
                     propiedadControlUnicoUnico.cargoControlante=ListPropiedadControl[i].cargoControlante;
                     propiedadControlUnicoUnico.cotBolsaControlante =ListPropiedadControl[i].cotBolsaControlante;
                     propiedadControlUnicoUnico.ticSymbolControlante=ListPropiedadControl[i].ticSymbolControlante;
                     propiedadControlUnicoUnico.AI_ID_EXTERNO=ListPropiedadControl[i].AI_ID_EXTERNO;
                     
                     if (propiedadControlUnicoUnico.cotBolsaControlante == 'S')
                     {
                         cotizaControlanteSi = true;
                     }
                     
                     if (propiedadControlUnicoUnico.cotBolsaControlante == 'N')
                     {
                         cotizaControlanteNo = true;
                     }
                     if (propiedadControlUnicoUnico.PEPControlante == 'S' )
                     {
                         PEPControlante = true;
                     }
                     ELSE
                     {
                         PEPControlante = false; 
                     }
                     if (propiedadControlUnicoUnico.FATCAControlante == 'S')
                     {
                         FATCAControlante = true;
                     }
                     ELSE
                     {
                         FATCAControlante = false; 
                     }
                     if (propiedadControlUnicoUnico.FATCANCControlante == 'S')
                     {
                         FATCANCControlante = true ;
                     }
                     ELSE
                     {
                         FATCANCControlante = false; 
                     }
                 }
            }
          
          if(posi != null)
          {
              ListPropiedadControl.remove(posi);
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Modificara El Socio!'));
              mostrarTablaControlantes = false;
              disbotControlantes = false;
          	  total2=0;
          }
             
           
         }
        
         catch(exception e)
         {
            
        }
                    
        
     }
    PUBLIC VOID eliminarControlantes() 
    {	
        decimal total2=0;
        if(propiedadControlUnicoUnico !=null){total2=propiedadControlUnicoUnico.porcentajeDiControlante!=null ?decimal.valueOf(propiedadControlUnicoUnico.porcentajeDiControlante):0;}
        try
         { integer pos;
          
          for(integer i=0; i<ListPropiedadControl.size(); i++)
          {
              if(ListPropiedadControl[i].numControlante == string.valueOf(numControlanteAsignado)) 
              {
                  pos=i;
              } 
              
          }
          if(pos != null)
          {
              ListPropiedadControl.remove(pos);
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se eliminó El Socio!'));
              mostrarTablaControlantes = false;
              disbotControlantes = false;
              total2=0;
          }
             
           
         }
         catch(exception e)
         {
            
        }    
     } 
    PUBLIC VOID eliminarControlantesOtro() 
    {
    	decimal total2=0;
        try
         { integer pos;
          	system.debug('ListPropiedadControl: '+ ListPropiedadControl.size());
         	for(integer i=0; i<ListPropiedadControl.size(); i++)
            {
                system.debug('ListPropiedadControl: '+ ListPropiedadControl[i].numControlante);
                system.debug('numControlanteAsignado: '+ numControlanteAsignado);
                if (ListPropiedadControl[i].numControlante == string.valueOf(numControlanteAsignado))
                 {
                        pos=i;
                  } 
              
            }
          if(pos != null)
          {
              ListPropiedadControl.remove(pos);
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se eliminó el Controlante.'));
              mostrarTablaControlantes = true;
              propiedadControlUnicoUnico.porcentajeDiControlante = 100;
              total2=0;
          }
             
           
         }
         catch(exception e)
         {
            
        }    
     } 
    
    public void limpiabenefici()
    {
        pcnumeroidsocc=null;
        socioUnico.nombresocio=null;
        Cliente1.Tipo_Persona__c=null;
        socioUnico.nacionalidad=null;
        socioUnico.NIVEL=null;
        socioUnico.POR_PART_DIRECT=null;
        socioUnico.POR_PART_INDIRECT=null;
        socioUnico.NUMERO_ID_EMPRESA=null;
        pcCotizaSI=false;
        pcCotizaNO=false;
        PEPSocio = false;
        FATCASocio = false;
        FATCANCSocio = false;
        socioUnico.TIC_SYMBOL=null;
        validadosSocios = true;
    }
    
    PUBLIC VOID ModificarD()
    {	decimal total2=0;
     	if(socioUnico !=null){total2=socioUnico.POR_PART_DIRECT!=null ?decimal.valueOf(socioUnico.POR_PART_DIRECT):0;}
         try
         { integer posi;
         	for(integer i=0; i<ListSocios.size(); i++)
            {
            	if(ListSocios[i].pcnumeroidsoc == string.valueOf(Num_identidadProducto))   
                 {
                     posi=i;
                     pcnumeroidsocc=ListSocios[i].pcnumeroidsoc;
                     socioUnico.nombresocio=ListSocios[i].nombresocio;
                     Cliente1.Tipo_Persona__c=ListSocios[i].tipo_persona;
                     socioUnico.nacionalidad=ListSocios[i].nacionalidad;
                     socioUnico.NIVEL=ListSocios[i].NIVEL;
                     socioUnico.PEPSocio=ListSocios[i].PEPSocio;
                     socioUnico.FATCASocio=ListSocios[i].FATCASocio;
                     socioUnico.FATCANCSocio=ListSocios[i].FATCANCSocio;
                     socioUnico.POR_PART_DIRECT=ListSocios[i].POR_PART_DIRECT;
                     socioUnico.POR_PART_INDIRECT=ListSocios[i].POR_PART_INDIRECT;
                     socioUnico.NUMERO_ID_EMPRESA=ListSocios[i].NUMERO_ID_EMPRESA;
                     socioUnico.COT_BOLSA =ListSocios[i].COT_BOLSA;
                     socioUnico.TIC_SYMBOL=ListSocios[i].TIC_SYMBOL;
                     socioUnico.AI_ID_EXTERNO=ListSocios[i].AI_ID_EXTERNO;
                     
                     if (socioUnico.COT_BOLSA=='S')
                     {
                         pcCotizaSI=true;
                     }
                     
                     if (socioUnico.COT_BOLSA=='N')
                     {
                         pcCotizaNO=TRUE;
                     }
                     if (socioUnico.PEPSocio == 'S' )
                     {
                         PEPSocio = true;
                     }
                     ELSE
                     {
                         PEPSocio = false; 
                     }
                     if (socioUnico.FATCASocio == 'S')
                     {
                         FATCASocio = true;
                     }
                     ELSE
                     {
                         FATCASocio = false; 
                     }
                     if (socioUnico.FATCANCSocio == 'S')
                     {
                         FATCANCSocio = true ;
                     }
                     ELSE
                     {
                         FATCANCSocio = false; 
                     }
                 }
            }
          
          if(posi != null)
          {
              ListSocios.remove(posi);
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Modificara El Socio!'));
              mostrarTabla = false;
              disbotBene = false;
          	  total2=0;
          }
             
           
         }
        
         catch(exception e)
         {
            
        }
                    
        
     }
        
    PUBLIC VOID EliminarD() 
    {	decimal total2=0;
        if(socioUnico !=null){total2=socioUnico.POR_PART_DIRECT!=null ?decimal.valueOf(socioUnico.POR_PART_DIRECT):0;}
        try
         { integer pos;
          
         	for(integer i=0; i<ListSocios.size(); i++)
            {
              if (ListSocios[i].pcnumeroidsoc == Num_identidadProducto)
                  {
                        pos=i;
                  } 
              
            }
          if(pos != null)
          {
              ListSocios.remove(pos);
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Eliminó El Socio!'));
              mostrarTabla = false;
              disbotBene = false;
              total2=0;
          }
             
           
         }
         catch(exception e)
         {
            
        }    
     } 
    
    
    
    PUBLIC VOID EliminarDADD() 
    {
    	decimal total2=0;
        try
         { integer pos;
          
         	for(integer i=0; i<ListSocios.size(); i++)
            {
                if (ListSocios[i].pcnumeroidsoc == string.valueOf(Num_identidadProducto))
                 {
                        pos=i;
                  } 
              
            }
          if(pos != null)
          {
              ListSocios.remove(pos);
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Eliminó El Socio!'));
              mostrarTabla = true;
              socioUnico.POR_PART_DIRECT = 100;
              total2=0;
          }
             
           
         }
         catch(exception e)
         {
            
        }    
     } 
        
    /*Metodo para almacenar la segunda lista */
    public boolean mostrarTablaModificar {get;set;}
    public boolean MostraTablaSociosTIN {get;set;}
    public decimal num {get; set;}
    
    // tABALA FUNCIONES
    PUBLIC VOID guardarListaSociosTIN()
    {
       socioUnicoTIN.PCNumeroID_TIN=socioUnicoTIN.PCNumeroID_TIN;
        socioUnicoTIN.pcNombreCompleto_TIN=socioUnicoTIN.pcNombreCompleto_TIN;
        socioUnicoTIN.pcDireccion_TIN=socioUnicoTIN.pcDireccion_TIN;
        socioUnicoTIN.PCTIN_TIN=socioUnicoTIN.PCTIN_TIN;
        try
        {

            if(socioUnicoTIN.PCNumeroID_TIN != null || socioUnicoTIN.pcNombreCompleto_TIN != null || socioUnicoTIN.pcDireccion_TIN != null ||  socioUnicoTIN.PCTIN_TIN != null )
            {
                
                if( mostrarTablaModificar == true) { mostrarTablaModificar = true; ListSociosTIN.add(socioUnicoTIN);
                	    socioUnicoTIN = new SociosTIN(null,'', '', '', '');
                        disbotBene = true;    
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!'));
                    
                }
                else
                {
                    MostraTablaSociosTIN =  true;
                	ListSociosTIN.add(socioUnicoTIN);
                	socioUnicoTIN = new SociosTIN(null,'', '', '', '');
                    disbotBene = true;   
                	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!'));
                }
                
                
            }    
            else
            { 
    
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Se Permiten Campos Vacios En Beneficiarios'));
                
             } //FIN DEL IF DE VALIDACION 
            
        }catch(exception e)
        {
            
        }
    }
    
     PUBLIC VOID EliminarTIN() 
    {
    
        try
         { integer pos;
          
         	for(integer i=0; i<ListSociosTIN.size(); i++)
            {
                 if (ListSociosTIN[i].PCNumeroID_TIN == string.valueOf(NumbTINTable))
                  {
                        pos=i;
                  } 
            }
          if(pos != null)
          {
              ListSociosTIN.remove(pos);
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Eliminó El Socio!'));
              mostrarTabla = false;
              disbotBene = false;
          }
             
           
         }
         catch(exception e)
         {
            
        }    
     } 
    
    PUBLIC VOID EliminarTINADD() 
        
    {
       try
         { integer pos;
          
         	for(integer i=0; i<ListSociosTIN.size(); i++)
            {
                if (ListSociosTIN[i].PCNumeroID_TIN == string.valueOf(NumbTINTable))
                  {
                       pos=i;
                  } 
            }
          if(pos != null)
          {
              
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Eliminó El Socio!'));
              ListSociosTIN.remove(pos);
              mostrarTabla = false;
              disbotBene = true;
          }
             
                    
         }
         catch(exception e)
         {
            
        }    
     } 
       PUBLIC VOID ModificarTIN()
    {
         try
         { integer posi;
         	for(integer i=0; i<ListSociosTIN.size(); i++) { if(ListSociosTIN[i].PCNumeroID_TIN == string.valueOf(NumbTINTable))
             {                 
                 posi=i;
             	socioUnicoTIN.PCNumeroID_TIN=ListSociosTIN[i].PCNumeroID_TIN;
                socioUnicoTIN.pcNombreCompleto_TIN =ListSociosTIN[i].pcNombreCompleto_TIN;
                 socioUnicoTIN.pcDireccion_TIN=ListSociosTIN[i].pcDireccion_TIN;
                 socioUnicoTIN.PCTIN_TIN=ListSociosTIN[i].PCTIN_TIN;
                 
				}
            }
          if(posi != null)
          {
               ListSociosTIN.remove(posi);
               ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Modificara El Socio!'));
               mostrarTabla = false;
               disbotBene = true;
          }
             
           
         }
         catch(exception e)
         {
            
        }
                    
        
     }
    
    
    public list<controllerApiClienteNatural.classRespuestaAportesCuenta> resultado {get;set;}
    
    public void llenarColonia(){
        try
        {
            paginacion = 0;
            listColonias = new list <Colonias_U__c>();
            listColonias = [select nombre_colonia__c, codigo_colonia__c from Colonias_U__c where codigo_pais__c =: pccodpais 
                                     and codigo_departamento__c =: pcDeptoCN and codigo_municipio__c =: pcMunicipioCN order by nombre_colonia__c asc];
            opcionColonia = new list <selectOption>();
            opcionColonia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            if(listColonias.size()>999)
            {
                paginacion++;
                mostrarBoton =  true;
                mostrarSiguiente = false;
                mostrarAnterior = true;
                
				 for (integer i=0; i< 999; i++)
                {
                    opcionColonia.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                }                
            }
            else{
                opcionColonia = new list <selectOption>();
                opcionColonia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Colonias_U__c item:[select nombre_colonia__c, codigo_colonia__c from Colonias_U__c where codigo_pais__c =: pccodpais 
                                     and codigo_departamento__c =: pcDeptoCN and codigo_municipio__c =: pcMunicipioCN order by nombre_colonia__c asc])
                {
                    opcionColonia.add(new selectOption(item.codigo_colonia__c, item.nombre_colonia__c));
                }
            }
            
           
        }catch(exception e){
            
        }
    }
    
 
    public void siguiente(){
        try{
            if (listColonias.size()> ((paginacion + 1)*1000) )
            {
                opcionColonia = new list <selectOption>();
            	opcionColonia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                 for (integer i=1000; i< 1999; i++)
                {
                    opcionColonia.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                }    
            }
            else{
                 opcionColonia = new list <selectOption>();
                mostrarSiguiente=true;
                mostrarAnterior = false;
            	opcionColonia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                 for (integer i=1000; i< listColonias.size(); i++)
                {
                    opcionColonia.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                }    
            }
            
        }
        catch(exception e){
            
        }
    }
    
    public void anterior()
    {
        try 
        {
            
            if((paginacion - 1)*1000 < 1000)
            {
                mostrarsiguiente=false;
                mostrarAnterior=true;
                opcionColonia = new list<selectOption>();
                
                for(integer i=0; i<1000; i++)
                {
                    opcionColonia.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));}  paginacion --;
            }
            else
            {
                opcionColonia = new list<selectOption>();
               for(integer i=(paginacion - 2)*100; i<(paginacion-1) *100; i++)
                {
                    opcionColonia.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                }  
                paginacion --;
                 mostrarSiguiente=false;
            }
        }
        catch(Exception ex)
        {
            
        }
    }
    
    public void llenarMunicipio(){
        try
        {
            opcionMunicipio = new list <selectOption>();
            opcionMunicipio.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Municipio__c item:[select nombre_municipio__c, codigo_municipio__c from Municipio__c where codigo_pais__c =: pccodpais and 	codigo_departamento__c =: pcDeptoCN])
            {
                opcionMunicipio.add(new selectOption(item.codigo_municipio__c, item.nombre_municipio__c));
            }
        }catch(exception e){
            
        }
    }
    
    public void llenarDepartamento(){
        try
        {
            opcionDepartamento = new list <selectOption>();
            opcionDepartamento.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Departamentos__c item:[select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: pccodpais])
            {
                opcionDepartamento.add(new selectOption(item.codigo_departamento__c, item.Departamento__c));
            }
            
            opcionNacionalidad = new list <selectOption>();
            opcionNacionalidad.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Pais_R__c item:[select nacionalidad__c, codigo__c from Pais_R__c where codigo__c =: pccodpais])
            {
                opcionNacionalidad.add(new selectOption(item.codigo__c, item.nacionalidad__c));
                
            }
            
            
        }catch(exception e){
            
        }
    }
        
    public void llenarPais(){
        try
        {   opcionPais.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            OpcionPAIS1.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            OpcionPAIS2.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            OpcionPAIS3 = new list <selectOption>();
            OpcionPAIS3.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            opcionPaisEmpleado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Pais_R__c item:[select nombre__c, codigo__c from Pais_R__c])
            {
                opcionPais.add(new selectOption(item.codigo__c, item.nombre__c));
                OpcionPAIS1.add(new selectOption(item.codigo__c, item.nombre__c));
                OpcionPAIS2.add(new selectOption(item.codigo__c, item.nombre__c));
                OpcionPAIS3.add(new selectOption(item.codigo__c, item.nombre__c));
                opcionPaisEmpleado.add(new selectOption(item.codigo__c, item.nombre__c));
            }
        }catch(exception e){
            
        }
    }
  
    
    //pais o departamento  donde opera
        public void llenarPAIS1(){
    }
    
      public void llenarDEPTO1(){
        try
        { 
            OpcionDEPTO1 = new list <selectOption>();
            OpcionDEPTO1.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            OpcionDEPTO2 = new list <selectOption>();
            OpcionDEPTO2.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            OpcionDEPTO3 = new list <selectOption>(); 
            OpcionDEPTO3.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Departamentos__c item:[select Departamento__c, codigo_departamento__c 
                                        from Departamentos__c where codigo_pais__c =: '074'])
            {
                OpcionDEPTO1.add(new selectOption(item.codigo_departamento__c, item.Departamento__c));
                OpcionDEPTO2.add(new selectOption(item.codigo_departamento__c, item.Departamento__c));
                OpcionDEPTO3.add(new selectOption(item.codigo_departamento__c, item.Departamento__c));
            }      
        }catch(exception e){
            
        }
    }
    
     public void llenarPAIS2(){
    }
    
    
     public void llenarDEPTO2(){
     
     }
    
    
     public void llenarPAIS3(){
    }
    
     public void llenarDEPTO3(){
    }
    
    //fin pais donde opera
    public void llenarNacionalidad(){
        try
        {   opcionNacionalidad = new list <selectOption>();
            opcionNacionalidad.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Pais_R__c item:[select nacionalidad__c, codigo__c from Pais_R__c where codigo__c =: pccodpais])
            {
                opcionNacionalidad.add(new selectOption(item.codigo__c, item.nacionalidad__c));  
            }
        }catch(exception e){
            
        }
    }
    

    public void llenarNacionalidadSocios(){ 
        try
        {   opcionNacionalidadSocios = new list <selectOption>();
            opcionNacionalidadSocios.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Pais_R__c item:[select nacionalidad__c, codigo__c from Pais_R__c where nacionalidad__c != ''])
            {
                opcionNacionalidadSocios.add(new selectOption(item.codigo__c, item.nacionalidad__c));  
            }
        }catch(exception e){
            
        }
    }
    
    
    //LLenar nacionalidad si tiene mas 
    
     public void llenarNacionalidadTerceros(){
        try
        {   opcionNacionalidadTerceros = new list <selectOption>();
            opcionNacionalidadTerceros.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            opcionNacionalidadSegundos = new list <selectOption>();
            opcionNacionalidadSegundos.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Pais_R__c item:[select nacionalidad__c, codigo__c from Pais_R__c ])
            {
                opcionNacionalidadTerceros.add(new selectOption(item.codigo__c, item.nacionalidad__c));
                opcionNacionalidadSegundos.add(new selectOption(item.codigo__c, item.nacionalidad__c));
            }
        }catch(exception e){
            
        }
    }
    
    //Llenar nacionalidad segundos
    
     public void llenarNacionalidadSegundos(){
    }
    
    
    //Pais--Departamento-- Nacionalidad Empleados
    
       //Llenar Colonia Empleado
   
    public void llenarColoniaEmpleado(){
        try
        {
            paginacionEmpleador = 0; 
            listColonias = new list <Colonias_U__c>();
            listColonias = [select nombre_colonia__c, codigo_colonia__c from Colonias_U__c where codigo_pais__c =: pcPaisEmpleadorCN 
                                     and codigo_departamento__c =: pcDeptoEmpleadorCN and codigo_municipio__c =: pcMunicipioCN order by nombre_colonia__c asc];
            opcionColoniaEmpleado = new list <selectOption>();
            opcionColoniaEmpleado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            if(listColonias.size()>999){ paginacionEmpleador++; mostrarBotonEmpleador =  true; mostrarSiguienteEmpleador = false;
                mostrarAnteriorEmpleador = true;
				 for (integer i=0; i< 999; i++)
                {
                    opcionColoniaEmpleado.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                }                
            }
            else{
                opcionColoniaEmpleado = new list <selectOption>();
                opcionColoniaEmpleado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Colonias_U__c item:[select nombre_colonia__c, codigo_colonia__c from Colonias_U__c where codigo_pais__c =: pcPaisEmpleadorCN 
                                     and codigo_departamento__c =: pcDeptoEmpleadorCN and codigo_municipio__c =: pcMunicipioEmpleadorCN order by nombre_colonia__c asc])
                {
                    opcionColoniaEmpleado.add(new selectOption(item.codigo_colonia__c, item.nombre_colonia__c));
                }
            }
            
           
        }catch(exception e){
            
        }
    }
    
      public void siguienteEmpleado(){
        try{
            if (listColonias.size()> ((paginacionEmpleador + 1)*1000) )
            {
                opcionColoniaEmpleado = new list <selectOption>();
            	opcionColoniaEmpleado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                 for (integer i=1000; i< 1999; i++)
                {
                    opcionColoniaEmpleado.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                }    
            }
            else{
                 opcionColoniaEmpleado = new list <selectOption>();
                 mostrarSiguienteEmpleador=true;
                 mostrarAnteriorEmpleador = false;
            	 opcionColoniaEmpleado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                 for (integer i=1000; i< listColonias.size(); i++)
                {
                    opcionColoniaEmpleado.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                }    
            }
            
        }
        catch(exception e){
            
        }
    }
    
    public void anteriorEmpleado()
    {
        try 
        {
            
            if((paginacionEmpleador - 1)*1000 < 1000)
            {
                mostrarSiguienteEmpleador=false;
                mostrarAnteriorEmpleador=true;
                opcionColoniaEmpleado = new list<selectOption>();
                for(integer i=0; i<1000; i++)
                {
                    opcionColoniaEmpleado.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                } 
                paginacionEmpleador --;
            }
            else
            {
                opcionColoniaEmpleado = new list<selectOption>();
               for(integer i=(paginacionEmpleador - 2)*100; i<(paginacionEmpleador-1) *100; i++)
                {
                    opcionColoniaEmpleado.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                }  
                paginacionEmpleador --;
                 mostrarSiguienteEmpleador=false;
            }
        }
        catch(Exception ex)
        {
            
        }
    }
    
 
    public void llenarMunicipioEmpleado(){
        try
        {
            opcionMunicipioEmpleado = new list <selectOption>();
            opcionMunicipioEmpleado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Municipio__c item:[select nombre_municipio__c, codigo_municipio__c from Municipio__c where codigo_pais__c =: pcPaisEmpleadorCN and codigo_departamento__c =: pcDeptoEmpleadorCN])
            {
                opcionMunicipioEmpleado.add(new selectOption(item.codigo_municipio__c, item.nombre_municipio__c));
            }
        }catch(exception e){
            
        }
    }
    
    public void llenarDepartamentoEmpleado(){
        try
        {
             
            opcionDepartamentoEmpleado = new list <selectOption>();
            opcionDepartamentoEmpleado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Departamentos__c item:[select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: pcPaisEmpleadorCN])
            {
                opcionDepartamentoEmpleado.add(new selectOption(item.codigo_departamento__c, item.Departamento__c));
            }
        }catch(exception e){
            
        }
    }
        
    public void llenarPaisEmpleado(){
    }
    
    
    
    
    public void llenarNacionalidadEmpleado(){
        try
        {   opcionNacionalidadEmpleado = new list <selectOption>();
            opcionNacionalidadEmpleado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Pais_R__c item:[select nacionalidad__c, codigo__c from Pais_R__c where codigo__c =: pcPaisEmpleadorCN])  { opcionNacionalidadEmpleado.add(new selectOption(item.codigo__c, item.nacionalidad__c));}
        }catch(exception e){
            
        }
    }
    
    
       public void ValidarDependenciaNO()
       {
            Dis_OcultarDependenciaSI = FALSE;
            Dis_OcultarDependenciaNO = FALSE;
            Dis_OcultarDependenciaCampos = FALSE;
            pcDependeNO = FALSE; 
            pcDependeSI = FALSE;
       }    
    
    //Valida Dependencia SI
    
     public void ValidarDependenciaSI()
     {
        
        if (pcDependeSI = true) 
          {   
            Dis_OcultarDependenciaSI = false;
            Dis_OcultarDependenciaNO = true;
            Dis_OcultarDependenciaCampos = false;
            pcDependeNO = FALSE; 
            pcDependeSI = true;
              
            
          } 
           ELSE if (pcDependeSI = false) 
          {   
            Dis_OcultarDependenciaSI = FALSE;
            Dis_OcultarDependenciaNO = FALSE;
            Dis_OcultarDependenciaCampos = FALSE;
            pcDependeNO = FALSE; 
            pcDependeSI = FALSE;
          }    
         
      }  
    
    
     public void ValidarDependenciaNOV()
     {

        if (AplicaSeguroNO = true) 
          {   
            Dis_OcultarDependenciaSI = true;
            Dis_OcultarDependenciaNO = false;
            Dis_OcultarDependenciaCampos = TRUE;
            pcDependeNO = TRUE; 
            pcDependeSI = FALSE;
            
          } 
           ELSE if (pcDependeNO = false) 
          {   
            Dis_OcultarDependenciaSI = FALSE;
            Dis_OcultarDependenciaNO = FALSE;
            Dis_OcultarDependenciaCampos = FALSE;
            pcDependeNO = FALSE; 
            pcDependeSI = FALSE;
          }    
         
      }  
    
    public void AplicaAPNFD()
     {
         IF(pcAPNFDSI = TRUE)
         {
          ocultaLista = false;
          pcAPNFDSI = TRUE;
          pcAPNFDNO = FALSE;
          OcultarAPNFD = false;
          OcultarAPNFDNO = true;
          NumeroAPNFDBLO = false;
          PC_NIVEL_RIESGO = '3'; 
          PC_DEBIDA_DELIGENCIA = '3';
          dispep =  true;
             
          }           
      } 
    
    //agregado el 10-04-2019
    public boolean valorsiONG {get;set;}
    public boolean OcultarONGNO {get;set;}
    public boolean activadesacONG {get;set;}
    public boolean valornoONG {get;set;}
    public boolean OcultarONGSI {get;set;}
    public boolean ValorContratistasi {get;set;}
    public boolean activadesacContratista {get;set;}
    public boolean OcultarNoContratista {get;set;}
    public boolean ValorContratistano {get;set;}
    public boolean OcultarSiContratista {get;set;}
    public boolean DonacionPrivada {get;set;}
    Public boolean DonacionLocalExtra {get; set;}
    public boolean ContratistaDirecto {get;set;}
    public boolean ContratistaSub {get;set;}
    //Para mostrar el cliente ONG de debida diligencia
    public List<DebidaDiliClienteONG> ListClienteONG {get;set;}
    public DebidaDiliClienteONG ClienteONG {get;set;}

    //cuando se le da click en el si ong
    public void ong_osSI(){
        if (valorsiONG = true){
            OcultarONGNO = true;
        	activadesacONG = false;
            PC_NIVEL_RIESGO = '3'; 
            PC_DEBIDA_DELIGENCIA = '3';
            dispep = true;
        }
        
    }
    
    public void ong_Noseleccionado(){
     
            OcultarONGNO = false;
        	activadesacONG = true;
        	DonacionPrivada = false;
        	DonacionLocalExtra = false;
        	MostrarTablaClienteONG = false;
        	ListClienteONG = new List<DebidaDiliClienteONG>();
        
        	ClienteONG.Nombre = '';
        	ClienteONG.MedioPago = '';
        	ClienteONG.Domicilio = '';
        	ClienteONG.Frecuencia = '';
        	ClienteONG.Monto = 0;
        
			if (pcPEP == true || pcAPNFDSI == true || ValorContratistasi == true){
            				PC_NIVEL_RIESGO = '3'; 
            				PC_DEBIDA_DELIGENCIA = '3';
                        	dispep = true;
							}
            else{
                     		PC_NIVEL_RIESGO = '2'; 
            				PC_DEBIDA_DELIGENCIA = '2';
                 			dispep = false;
                 		}
    }
    
    //cuando se le da click en el no ong
    public void ong_NO(){ 
		if (valornoONG = true){
			OcultarONGSI = true;
            if(pcPEP == false && pcAPNFDNO == true && ValorContratistano == true){
                            PC_NIVEL_RIESGO = '1'; 
          		 			PC_DEBIDA_DELIGENCIA = '2';
                 			dispep = true;
                        }
        }
    }
    
            public void ong_Noseleccion(){
     
            OcultarONGSI = false;
            if (pcPEP == true || ValorContratistasi == true || pcAPNFDSI == true){
          					PC_NIVEL_RIESGO = '3'; 
          					PC_DEBIDA_DELIGENCIA = '3';
             				dispep =  true;
         									}
        			 else{
            				PC_NIVEL_RIESGO = '2'; 
          					PC_DEBIDA_DELIGENCIA = '2';
             				dispep =  false;
         					}
        	//activadesacONG = true;
    			}
    //Cuando se le da click en el si contrastista
    		 public void contrastist_siSelec(){ 
					if (ValorContratistasi = true){
					activadesacContratista = false;
                    OcultarNoContratista = true;
                    PC_NIVEL_RIESGO = '3'; 
            		PC_DEBIDA_DELIGENCIA = '3';
            		dispep = true;
        					}
    				}
    

			public void contrastist_noSelec(){ 
					ContratistaDirecto = false;
                 	ContratistaSub = false;
					activadesacContratista = true;
                    OcultarNoContratista = false;
                 
                 	debidaDil.TipoProyecto = '';
                 	debidaDil.NombreProyecto = '';
                 	debidaDil.Ubicacion = '';
                 	debidaDil.BeneficioProyecto = '';
                 	debidaDil.Valor = null;
                 
                  MostrarTablaDiligencia =  false;
        	      ListDebidaDil = new List<claseDebidaDilContratista>();
                 
                 	if (pcPEP == true || pcAPNFDSI == true || valorsiONG == true){
            				PC_NIVEL_RIESGO = '3'; 
            				PC_DEBIDA_DELIGENCIA = '3';
                        	dispep = true;
							}
                 	else{
                     		PC_NIVEL_RIESGO = '2'; 
            				PC_DEBIDA_DELIGENCIA = '2';
                 			dispep = false;
                 		}
    				}    
    
    //Cuando se le da click al no de contratista
    		   public void contrastist_SelecNO(){ 
					if (ValorContratistano = true){
						OcultarSiContratista = true;
                        
                        if(pcPEP == false && pcAPNFDNO == true){
                            PC_NIVEL_RIESGO = '1'; 
          		 			PC_DEBIDA_DELIGENCIA = '2';
                 			dispep = true;
                        }
        					}
    				}
    
    public void contrastist_SelecNOno(){ 
						OcultarSiContratista = false;
                    	//PC_NIVEL_RIESGO = '2'; 
          		 		//PC_DEBIDA_DELIGENCIA = '2';
                 		//dispep = false;
                 		if (pcPEP == true || valorsiONG == true || pcAPNFDSI == true){
          					PC_NIVEL_RIESGO = '3'; 
          					PC_DEBIDA_DELIGENCIA = '3';
             				dispep =  true;
         									}
        			 else{
            				PC_NIVEL_RIESGO = '2'; 
          					PC_DEBIDA_DELIGENCIA = '2';
             				dispep =  false;
         					}
    				}
    
    //Para mostrar
    //public boolean MostrarTablaModiClienteONG {get;set;}
    public boolean MostrarTablaClienteONG {get;set;}
    public string ValorNombreTabla {get;set;}
    
    public void GuardarListaClienteONG(){
        
            if(valorsiONG == true){
             ClienteONG.ClienteONG = 'S';
            }
            else{
                ClienteONG.ClienteONG = 'N';
            }
            
        	if(DonacionPrivada == true){
                ClienteONG.TipoDonacionesPrivada = 'S';
            }
            else{
                ClienteONG.TipoDonacionesPrivada = 'N';
            }
        
            if(DonacionLocalExtra == true){
                ClienteONG.TipoDonacionesGobierno = 'S';
            }
            else{
                ClienteONG.TipoDonacionesGobierno = 'N';
            }
        ClienteONG.Nombre = ClienteONG.Nombre;
        ClienteONG.MedioPago = ClienteONG.MedioPago;
        ClienteONG.Domicilio = ClienteONG.Domicilio;
        ClienteONG.Frecuencia = ClienteONG.Frecuencia;
        ClienteONG.Monto = ClienteONG.Monto;
        //ClienteONG.CodClienteONG = null;
        try
        {
            if(ClienteONG.Nombre != '' && ClienteONG.MedioPago != '' && ClienteONG.Domicilio != 
              '' && ClienteONG.Frecuencia != ''){
                  
                  if(MostrarActuaONG == true){
                     
                      //MostrarTablaModiClienteONG = true;
                      ListClienteONG.add(ClienteONG);
                      ClienteONG = new DebidaDiliClienteONG(0,'','','','','','','',null);
                      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!'));
                  }
                  else
                  {
                      MostrarTablaClienteONG = true;
                      ListClienteONG.add(ClienteONG);
                      ClienteONG = new DebidaDiliClienteONG(0,'','','','','','','',null);
                      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!'));
                  }
                
            }
            else
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Se Permiten Campos Vacios En Cliente ONG-OSFL'));
            }
        }catch(exception e)
        {
            
        }
    }
    
    //Eliminar Cliente ONG de la lista
    public void EliminarClienteONG(){
		try
         { integer pos;
          
         	for(integer i=0; i<ListClienteONG.size(); i++)
            {
                 
                 if (ListClienteONG[i].Nombre == ValorNombreTabla)
                  {
                        pos=i;
                  } 
            }
          if(pos != null)
          {
              ListClienteONG.remove(pos);
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Elimino El contratista!'));
              mostrarTabla = false;
              disbotBene = false;
          }
             
           
         }
         catch(exception e)
         {
            
        }    
    }
    
    public boolean  MostrarActuaONG {get;set;}
    
    public void ActualizaListONG(){
        //OcultarONGNO = false;
        //OcultarONGSI = false;
        activadesacONG = false;
        try
        { integer posi;
         for(integer i=0; i<ListClienteONG.size(); i++) { if(ListClienteONG[i].Nombre == string.valueOf(ValorNombreTabla))
         {                 
          posi=i;
             ClienteONG.CodClienteONG = ListClienteONG[i].CodClienteONG;
             ClienteONG.Nombre = ListClienteONG[i].Nombre;
             ClienteONG.MedioPago =ListClienteONG[i].MedioPago;
             ClienteONG.Domicilio = ListClienteONG[i].Domicilio;
             ClienteONG.Frecuencia = ListClienteONG[i].Frecuencia;
             ClienteONG.Monto = ListClienteONG[i].Monto;               
         }
                                                       }
         if(posi != null)
         {
             ListClienteONG.remove(posi);
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Modificara El Socio!'));
             //mostrarTabla = false;            
             //disbotBene = true;
           
         }           
         
        }
        catch(exception e)
        {
            
        }               
    }
    //lista para mostrar Datos contratista
	public List<claseDebidaDilContratista> ListDebidaDil {get;set;}
	public claseDebidaDilContratista debidaDil {get;set;} 
    public boolean MostrarTablaDiligencia {get;set;}
    //public boolean mostrarTablaModificarDil {get;set;}
    public string  NumbDILTable {get;Set;}
    
    PUBLIC VOID guardarListaDili()
    {
         if(ValorContratistasi == true)
            {
             debidaDil.Contratista = 'S';   
            }
            else{
                debidaDil.Contratista = 'N';
            }            
            
            if(ContratistaDirecto == true){
                debidaDil.tipoContrDirecto = 'S';
            }
            else{
                debidaDil.tipoContrDirecto = 'N';
            }
            
            if(ContratistaSub == true){
                debidaDil.tipoContrSubcontratado = 'S';
            }
            else{
                debidaDil.tipoContrSubcontratado = 'N';
            }
        debidaDil.D_tipoPersona = 'J';
        debidaDil.NombreProyecto = debidaDil.NombreProyecto;
        debidaDil.Ubicacion = debidaDil.Ubicacion;
        debidaDil.TipoProyecto= debidaDil.TipoProyecto;
        debidaDil.BeneficioProyecto= debidaDil.BeneficioProyecto;
        debidaDil.Valor= debidaDil.Valor;
        
        try
        {

            if(debidaDil.NombreProyecto != '' && debidaDil.Ubicacion != '' && debidaDil.TipoProyecto != '' && 
               debidaDil.BeneficioProyecto != '' )
            {
                
                if( MostrarActDili == true)
                {
                        //mostrarTablaModificarDil = true;
                    	ListDebidaDil.add(debidaDil);
                	    debidaDil  = new claseDebidaDilContratista (null,'','','','', '', '','',null,'');
                        //disbotBene = true;    
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!'));
                    
                }
                else
                {
                    MostrarTablaDiligencia =  true;
                    ListDebidaDil .add(debidaDil);
                	debidaDil = new claseDebidaDilContratista(null,'','','','', '', '','',null,'');
                	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!'));
                }                
                
            }
            else
            { 
    
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Se Permiten Campos Vacios En Contratista'));
                
            } //fin de la validacion
            
        }catch(exception e)
        {
            
        }
      
    }
    
         PUBLIC void EliminarDIL() 
    {
    
        try
         { integer pos;
          
         	for(integer i=0; i<ListDebidaDil.size(); i++)
            {
                 
                 if (ListDebidaDil[i].NombreProyecto == NumbDILTable)
                  {
                        pos=i;
                  } 
            }
          if(pos != null)
          {
              ListDebidaDil.remove(pos);
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Elimino El contratista!'));
              mostrarTabla = false;
              disbotBene = false;
          }
             
           
         }
         catch(exception e)
         {
            
        }    
     }
    
    public boolean MostrarActDili {get;set;}
    
    
    public void ActualizaListDili(){
        //OcultarSiContratista = false;
        //OcultarNoContratista = false;
        activadesacContratista = false;
        
        try
        { integer posi;
         for(integer i=0; i<ListDebidaDil.size(); i++) { if(ListDebidaDil[i].NombreProyecto == string.valueOf(NumbTINTable))
         {                 
          posi=i;
             debidaDil.CodContratista = ListDebidaDil[i].CodContratista;
             debidaDil.NombreProyecto = ListDebidaDil[i].NombreProyecto;
             debidaDil.Ubicacion = ListDebidaDil[i].Ubicacion;
        	 debidaDil.TipoProyecto= ListDebidaDil[i].TipoProyecto;
             debidaDil.BeneficioProyecto= ListDebidaDil[i].BeneficioProyecto;
             debidaDil.Valor= ListDebidaDil[i].Valor;                
         }
                                                       }
         if(posi != null)
         {
             ListDebidaDil.remove(posi);
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Modificara El Socio!'));
             //mostrarTabla = false;            
             //disbotBene = true;
         }           
         
        }
        catch(exception e)
        {
            
        }               
    }
    
    public boolean ValorEmpresaMercaSI {get;set;}
    public boolean ValorEmpresaMercaNO {get;set;}
    public boolean OcultarEmpresaSI {get;set;}
    public boolean OcultarEmpresaNO {get;set;}
    public boolean OcultarPersonaUSASI {get;set;}
    public boolean OcultarPersonaUSANO {get;set;}
    public boolean ValorPersonaUsaNo {get;set;}
    public boolean ValorPersonaUsaSI {get;set;}
    
    //Si de empresa mercantil
   			    public void EmpresaMercaSIselec(){
                    
					if (ValorEmpresaMercaSI = true){
						OcultarEmpresaNO = true;
                        
                         if(ENTIDADSI == true && PASIVA == true && ValorEmpresaMercaSI == true){
                 OcultarAccionistaSI = false;
                 OcultarAccionistaNO = false;
             							}
        					}
    				}
    
    public void EmpresaMercaSInoselec(){
                    OcultarEmpresaNO = false;
							if(ENTIDADSI == false || PASIVA == false || ValorEmpresaMercaSI == false){
                 OcultarAccionistaSI = true;
                 OcultarAccionistaNO = true;
             							}
    				}
    
    //No de empresa mercantil
    		public void EmpresaMercaNOselec(){
                    
					if (ValorEmpresaMercaNO = true){
						OcultarEmpresaSI = true;
                        
                        if(ENTIDADSI == true && PASIVA == true && ValorEmpresaMercaNO == true){
                 OcultarPersonaUSASI = false;
                 OcultarPersonaUSANO = false;
             }
        					}
    				}
    
    public void EmpresaMercaNOnoselec(){
                    OcultarEmpresaSI = false;
                
					if(ENTIDADSI == true || PASIVA == true || ValorEmpresaMercaNO == true){
                 OcultarPersonaUSASI = true;
                 OcultarPersonaUSANO = true;
             }
    				}
    
        //Para FATCA
    public boolean OcultarAccionistaSI {get;set;}
    public boolean OcultarAccionistaNO {get;set;}
    
//Para persona USA si
    public void PersonaUSASIselect(){
                 IF(ValorPersonaUsaSI    = TRUE)
                 {
         			 OcultarPersonaUSANO   = true;
          			 SOCIO = FALSE;
          } 
    }
    
    public void PersonaUSASInoselect(){
        OcultarPersonaUSANO   = false;
          			 SOCIO = true;
        MostraTablaSociosTIN = false;
		ListSociosTIN = new List<SociosTIN>();
        
        //Agregado 10-04-2019
        socioUnicoTIN.PCNumeroID_TIN = '';
		 socioUnicoTIN.pcNombreCompleto_TIN = '';
 		 socioUnicoTIN.pcDireccion_TIN = '';    	 
         socioUnicoTIN.PCTIN_TIN = '';
        //fin
    }
    
    //Para el no de persona USA Junta
    public void PersonaUSANOselect(){
                 IF(ValorPersonaUsaNo    = TRUE)
                 {
         			 OcultarPersonaUSASI   = true;
          } 
    }
    
        public void PersonaUSANOnoselect(){
        OcultarPersonaUSASI   = false;
    }
    //fin
    
      public void AplicaAPNFDNOO()
     {
         IF(pcAPNFDNO == TRUE)
         {
          
          ocultaLista = false;
            pcAPNFDSI = false;
            pcAPNFDNO = true;
            OcultarAPNFD = true;
            OcultarAPNFDNO = false;  
            NumeroAPNFDBLO = true;
          //PC_NIVEL_RIESGO = '2'; 
          //PC_DEBIDA_DELIGENCIA = '2';
          IF(pcPEP == false)
            {
                PC_NIVEL_RIESGO = '1'; 
                PC_DEBIDA_DELIGENCIA = '2';
                dispep = true;
            }
          }           
      } 
    
      public void ApnfdNADA()
     {
          ocultaLista = true;
          pcAPNFDSI = false;
          pcAPNFDNO = false;
          OcultarAPNFD = false;
          OcultarAPNFDNO = false;   
          NumeroAPNFDBLO = true; 
          //dispep =  false;
          //PC_NIVEL_RIESGO = '2'; 
         // PC_DEBIDA_DELIGENCIA = '2'; 
         
         IF(pcPEP == true || valorsiONG == true || ValorContratistasi == true)
        {
            PC_NIVEL_RIESGO = '3'; 
            PC_DEBIDA_DELIGENCIA = '3';
            dispep =  true;
        }
        else
        {
            PC_NIVEL_RIESGO = '2'; 
            PC_DEBIDA_DELIGENCIA = '2';   
            dispep =  false;
        }       
         
      } 
    
    
       public void AplicaResidencia()
     {
         IF(ES_Residente = TRUE)
         {
          OcultarResidencia = false;
          OcultarResidenciaNO = true;
          ES_Residente = TRUE;
          ES_Residente_no = false;
          } 
      } 
    
      public void AplicaResidenciaNO()
     {
         IF(ES_Residente_no = TRUE)
         {
          OcultarResidencia = true;
          OcultarResidenciaNO = false;
          ES_Residente = false;
          ES_Residente_no = true;
          } 
      } 
    
      public void ResidenteNADA()
     {
        
          OcultarResidencia = false;
          OcultarResidenciaNO = false;
          ES_Residente = false;
          ES_Residente_no = false;   
              
      } 
    
    public void TerceraNO()
     {
         IF(OcultaTerNO = TRUE)
         {
          OcultaTerSI = false;
          OcultaTerNO = true;
          OcultaTerSI_1 = true;
          OcultaTerNO_2 = false;
          Tercera = true;
          } 
      } 
    
     public void TerceraSI()
     {
         IF(OcultaTerSI = TRUE)
         {
          OcultaTerSI = true;
          OcultaTerNO = false;
          OcultaTerSI_1 = false;
          OcultaTerNO_2 = true;
          Tercera = false;
          } 
      }
    
    public void TerceNADA()
     {
        
          OcultaTerSI = false;
          OcultaTerNO = false;
          OcultaTerSI_1 = false;
          OcultaTerNO_2 = false;   
              
      } 
   
    public void COT_BOLSA ()
     {
         IF(COT_BOLSASI  = TRUE)
         {
          COT_BOLSASI  = TRUE;
          
          COT_BOLSANO  = false;
          OcultarCOT_BOLSANO = true;
             
          }           
      } 
    
       public void OTROS_OBLIG ()
     {
         IF(OTROS_OBLIGSI  = TRUE)
         {
          OTROS_OBLIGSI  = TRUE;
          OTROS_OBLIGNO = FALSE;
          OcultarOTROS_OBLIGNO = true;
          OcultarOTROS_OBLIGSI = false;

             
             
          }           
      } 
    
           public void OTROS_OBLIGNO ()
     {
         IF(OTROS_OBLIGNO  = TRUE)
         {
          OTROS_OBLIGNO  = TRUE;
          OTROS_OBLIGSI = FALSE;
          OcultarOTROS_OBLIGSI = true;
          OcultarOTROS_OBLIGNO = false;

             
                    
             
          }           
      } 
    
    
    
      public void OTROS_OBLIGNADA()
     {
        
          OTROS_OBLIGSI = false;
          OTROS_OBLIGNO = false;
          OcultarOTROS_OBLIGSI = false;
           OcultarOTROS_OBLIGNO = false; 
        
      } 
    
    
       public void ENTIDADSI ()
     {
         IF(ENTIDADSI   = TRUE)
         {
          ENTIDADSI   = TRUE;
          ENTIDADNO  = FALSE;
          OcultarEmpresaSI = false;//Agregado 10-04-2019
		  OcultarEmpresaNO = false;//Agregado 10-04-2019
          OcultarEntidadNo = true;
          OcultarEntidad = false;
          SOCIOSI  = true;
          SOCIONO  = TRUE;
          OcultarACC_10DE_CONTROLSI  = FALSE;
          OcultarACC_10DE_CONTROLNO  = FALSE;
          OcultarACTIVA    = FALSE;
          OcultarPASIVA    = FALSE;
          OcultarFatca1 = TRUE;
     	  OcultarFatca2 = TRUE; 
     	  OcultarFatca3 = TRUE;
     	  OcultarFatca4 = TRUE; 
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = TRUE;
     	  OcultarFatca7 = TRUE;
     	  OcultarFatca8  = TRUE;
     	  OcultarFatca9 = TRUE;
     	  OcultarFatca10  = TRUE;
     	  OcultarFatca11 = TRUE;
     	  OcultarFatca12  = TRUE;
     	  OcultarFatca13 = TRUE;
     	  OcultarFatca14  = TRUE;
     	  OcultarFatca15 = TRUE;
     	  OcultarFatca16  = TRUE;
     	  OcultarFatca17 = TRUE;
     	 
             
             
          }           
      } 
    
           public void ENTIDADNOO ()
     {
         IF(ENTIDADNO   = TRUE)
         {
          ENTIDADNO   = TRUE;
          ENTIDADSI  = FALSE;
          OcultarEntidad = true;
          OcultarEntidadNo = false;
          SOCIOSI  = false;
          SOCIONO  = false;   
          OcultarACC_10DE_CONTROLSI  = TRUE;
          OcultarACC_10DE_CONTROLNO  = TRUE;   
             ACC_10DE_CONTROLSI= null;
             ACC_10DE_CONTROLNO= null;
          OcultarACTIVA    = true;
          OcultarPASIVA    = true;
          OcultarFatca1 = FALSE;
     	  OcultarFatca2 = FALSE; 
     	  OcultarFatca3 = FALSE;
     	  OcultarFatca4 = FALSE; 
     	  OcultarFatca5 = FALSE;
     	  OcultarFatca6  = FALSE;
     	  OcultarFatca7 = FALSE;
     	  OcultarFatca8  = FALSE;
     	  OcultarFatca9 = FALSE;
     	  OcultarFatca10  = FALSE;
     	  OcultarFatca11 = FALSE;
     	  OcultarFatca12  = FALSE;
     	  OcultarFatca13 = FALSE;
     	  OcultarFatca14  = FALSE;
     	  OcultarFatca15 = FALSE;
     	  OcultarFatca16  = FALSE;
     	  OcultarFatca17 = FALSE;
         }           
      } 
    
      public void ENTIDAD_NADA()
     {
        
          ENTIDADSI  = false;
          ENTIDADNO  = false;
          OcultarEntidad = false;
          OcultarEntidadNo = FALSE; 
         
          OcultarEmpresaSI = true;//Agregado 10-04-2019
		 OcultarEmpresaNO = true;//Agregado 10-042019
         GIINSI = true;//Agregado 10-042019
        MostraTablaSociosTIN = false;
         ListSociosTIN = new List<SociosTIN>();
         socioUnicoTIN.PCNumeroID_TIN = '';
		 socioUnicoTIN.pcNombreCompleto_TIN = '';
 		 socioUnicoTIN.pcDireccion_TIN = '';    	 
         socioUnicoTIN.PCTIN_TIN = '';
          bloqeListEnti = true;//fin
	
         ACTIVA = false;
         PASIVA = false;
         OcultarEmpresaSI = true;
         ValorEmpresaMercaSI = false;
         OcultarEmpresaNO = true;
         ValorEmpresaMercaNO = false;
         OcultarAccionistaSI = true;
         ACC_10DE_CONTROLSI = false;
         OcultarAccionistaNO = true;
         ACC_10DE_CONTROLNO = false;
         OcultarPersonaUSASI = true;
         ValorPersonaUsaSI = false;
         OcultarPersonaUSANO = true;
         ValorPersonaUsaNo = false;
         SOCIO = true;
         
          SOCIOSI  = false;
          SOCIONO  = false;  
          OcultarACC_10DE_CONTROLSI  = TRUE;
          OcultarACC_10DE_CONTROLNO  = TRUE;
          OcultarACTIVA    = true;
          OcultarPASIVA    = true;
          OcultarFatca1 = TRUE;
     	  OcultarFatca2 = TRUE; 
     	  OcultarFatca3 = TRUE;
     	  OcultarFatca4 = TRUE; 
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = TRUE;
     	  OcultarFatca7 = TRUE;
     	  OcultarFatca8  = TRUE;
     	  OcultarFatca9 = TRUE;
     	  OcultarFatca10  = TRUE;
     	  OcultarFatca11 = TRUE;
     	  OcultarFatca12  = TRUE;
     	  OcultarFatca13 = TRUE;
     	  OcultarFatca14  = TRUE;
     	  OcultarFatca15 = TRUE;
     	  OcultarFatca16  = TRUE;
     	  OcultarFatca17 = TRUE;
         Fatca1 = FALSE;
    	  Fatca2= FALSE;  
    	  Fatca3 = FALSE;
    	  Fatca4  = FALSE;
    	  Fatca5 = FALSE;
    	  Fatca6  = FALSE;
    	  Fatca7 = FALSE;
    	  Fatca8  = FALSE;
    	  Fatca9 = FALSE;
    	  Fatca10  = FALSE;
    	  Fatca11 = FALSE;
    	  Fatca12  = FALSE;
    	  Fatca13 = FALSE;
    	  Fatca14  = FALSE;
    	  Fatca15 = FALSE;
    	  Fatca16  = FALSE;
    	  Fatca17    = FALSE;
         } 
    
    public void CONTROL_ACCISI ()
     {
         IF(ACC_10DE_CONTROLSI    = TRUE)
         {
          ACC_10DE_CONTROLSI    = TRUE;
          ACC_10DE_CONTROLNO   = FALSE;
          OcultarACC_10DE_CONTROLNO  = true;
          OcultarACC_10DE_CONTROLSI  = false;
          SOCIO = FALSE;
          OcultarAccionistaNO = true; //Agregado 10-04-2019

          }           
      } 
    
           public void CONTROL_ACCINO ()
     {
         IF(ACC_10DE_CONTROLNO    = TRUE)
         {
          ACC_10DE_CONTROLNO    = TRUE;
          ACC_10DE_CONTROLSI   = FALSE;
          OcultarACC_10DE_CONTROLSI  = true;
          OcultarACC_10DE_CONTROLNO  = false;
          SOCIO = TRUE;   
             
          }           
      } 

    public void CONTROL_ACCINADA()
     {
        MostraTablaSociosTIN = false; //Agregado 10-04-2019
	    ListSociosTIN = new List<SociosTIN>(); //Agregado 10-04-2019
          ACC_10DE_CONTROLSI   = false;
          ACC_10DE_CONTROLNO   = false;
          OcultarACC_10DE_CONTROLSI  = false;
           OcultarACC_10DE_CONTROLNO  = false; 
         SOCIO = TRUE;	
		 OcultarAccionistaNO = false; //Agregado 10-04-2019
         socioUnicoTIN.PCNumeroID_TIN = '';
		 socioUnicoTIN.pcNombreCompleto_TIN = '';
 		 socioUnicoTIN.pcDireccion_TIN = '';    	 
         socioUnicoTIN.PCTIN_TIN = ''; //fin
        
      } 
 
    public void ACTIVASI ()
     {
         IF(ACTIVA     == TRUE)
         {
          ACTIVA     = TRUE;
          PASIVA    = FALSE;
          OcultarPASIVA    = true;
          OcultarACTIVA    = false;
 		 bloqeListEnti= true;
     	 }
        
      } 
              
    public void PASIVANO ()
     {
         IF(PASIVA  == TRUE )
        {
            PASIVA     = TRUE;
            //ACTIVA    = FALSE;
            OcultarACTIVA    = true;
            if(ENTIDADSI == true && PASIVA == true && ValorEmpresaMercaSI == true){
                 OcultarAccionistaSI = false;
                 OcultarAccionistaNO = false;
             }
             
             if(ENTIDADSI == true && PASIVA == true && ValorEmpresaMercaNO == true){
                 OcultarPersonaUSASI = false;
                 OcultarPersonaUSANO = false;
             }
            //OcultarPASIVA    = false;
            bloqeListEnti= false;
        }
         
      } 
    
    
      public void ACTI_PASI_NADA()
     {
          bloqeListEnti= true;
          ACTIVA    = false;
          PASIVA    = false;
          OcultarACTIVA    = false;
           OcultarPASIVA    = false; 
         
         //Para mercantil si
		if(ENTIDADSI == false || PASIVA == false || ValorEmpresaMercaSI == false){
                 OcultarAccionistaSI = true;
                 OcultarAccionistaNO = true;
             							}
         
           //Para mercantil no
        if(ENTIDADSI == true || PASIVA == true || ValorEmpresaMercaNO == true){
                 OcultarPersonaUSASI = true;
                 OcultarPersonaUSANO = true;
             }
	} 

    public void FATCA1SI ()
     {
         IF(Fatca1   = TRUE)
         {
          Fatca1 = TRUE;
    	  Fatca2= FALSE;  
    	  Fatca3 = FALSE;
    	  Fatca4  = FALSE;
    	  Fatca5 = FALSE;
    	  Fatca6  = FALSE;
    	  Fatca7 = FALSE;
    	  Fatca8  = FALSE;
    	  Fatca9 = FALSE;
    	  Fatca10  = FALSE;
    	  Fatca11 = FALSE;
    	  Fatca12  = FALSE;
    	  Fatca13 = FALSE;
    	  Fatca14  = FALSE;
    	  Fatca15 = FALSE;
    	  Fatca16  = FALSE;
    	  Fatca17    = FALSE;
          OcultarFatca1 = FALSE;
     	  OcultarFatca2 = TRUE;
     	  OcultarFatca3 = TRUE;
    	  OcultarFatca4 = TRUE;
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = TRUE;
     	  OcultarFatca7 = TRUE;
     	  OcultarFatca8  = TRUE;
     	  OcultarFatca9 = TRUE;
     	  OcultarFatca10 = TRUE;
     	  OcultarFatca11 = TRUE;
     	  OcultarFatca12  = TRUE;
     	  OcultarFatca13 = TRUE;
     	  OcultarFatca14  = TRUE;
     	  OcultarFatca15 = TRUE;
     	  OcultarFatca16  = TRUE;
     	  OcultarFatca17 = TRUE;
          GIINSI =  false;
                    
             
          }           
      } 
    
              
    public void FATCA2SI ()
     {
         IF(Fatca2     = TRUE)
         {
          Fatca1 = FALSE;
    	  Fatca2= TRUE;  
    	  Fatca3 = FALSE;
    	  Fatca4  = FALSE;
    	  Fatca5 = FALSE;
    	  Fatca6  = FALSE;
    	  Fatca7 = FALSE;
    	  Fatca8  = FALSE;
    	  Fatca9 = FALSE;
    	  Fatca10  = FALSE;
    	  Fatca11 = FALSE;
    	  Fatca12  = FALSE;
    	  Fatca13 = FALSE;
    	  Fatca14  = FALSE;
    	  Fatca15 = FALSE;
    	  Fatca16  = FALSE;
    	  Fatca17    = FALSE;
          OcultarFatca1 = TRUE;
     	  OcultarFatca2 = FALSE;
     	  OcultarFatca3 = TRUE;
    	  OcultarFatca4 = TRUE;
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = TRUE;
     	  OcultarFatca7 = TRUE;
     	  OcultarFatca8  = TRUE;
     	  OcultarFatca9 = TRUE;
     	  OcultarFatca10 = TRUE;
     	  OcultarFatca11 = TRUE;
     	  OcultarFatca12  = TRUE;
     	  OcultarFatca13 = TRUE;
     	  OcultarFatca14  = TRUE;
     	  OcultarFatca15 = TRUE;
     	  OcultarFatca16  = TRUE;
     	  OcultarFatca17 = TRUE;
          GIINSI =  false;
             

             
                    
             
          }           
      } 
    
          public void FATCA3SI ()
     {
         IF(Fatca3     = TRUE)
         {
          Fatca1 = FALSE;
    	  Fatca2= FALSE;  
    	  Fatca3 = TRUE;
    	  Fatca4  = FALSE;
    	  Fatca5 = FALSE;
    	  Fatca6  = FALSE;
    	  Fatca7 = FALSE;
    	  Fatca8  = FALSE;
    	  Fatca9 = FALSE;
    	  Fatca10  = FALSE;
    	  Fatca11 = FALSE;
    	  Fatca12  = FALSE;
    	  Fatca13 = FALSE;
    	  Fatca14  = FALSE;
    	  Fatca15 = FALSE;
    	  Fatca16  = FALSE;
    	  Fatca17    = FALSE;
          OcultarFatca1 = TRUE;
     	  OcultarFatca2 = TRUE;
     	  OcultarFatca3 = FALSE;
    	  OcultarFatca4 = TRUE;
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = TRUE;
     	  OcultarFatca7 = TRUE;
     	  OcultarFatca8  = TRUE;
     	  OcultarFatca9 = TRUE;
     	  OcultarFatca10 = TRUE;
     	  OcultarFatca11 = TRUE;
     	  OcultarFatca12  = TRUE;
     	  OcultarFatca13 = TRUE;
     	  OcultarFatca14  = TRUE;
     	  OcultarFatca15 = TRUE;
     	  OcultarFatca16  = TRUE;
     	  OcultarFatca17 = TRUE; 
           GIINSI =  false;
    
          }           
      } 
              
    public void FATCA4SI ()
     {
         IF(Fatca4     = TRUE)
         {
          Fatca1 = FALSE;
    	  Fatca2= FALSE;  
    	  Fatca3 = FALSE;
    	  Fatca4  = TRUE;
    	  Fatca5 = FALSE;
    	  Fatca6  = FALSE;
    	  Fatca7 = FALSE;
    	  Fatca8  = FALSE;
    	  Fatca9 = FALSE;
    	  Fatca10  = FALSE;
    	  Fatca11 = FALSE;
    	  Fatca12  = FALSE;
    	  Fatca13 = FALSE;
    	  Fatca14  = FALSE;
    	  Fatca15 = FALSE;
    	  Fatca16  = FALSE;
    	  Fatca17    = FALSE;
          OcultarFatca1 = TRUE;
     	  OcultarFatca2 = TRUE;
     	  OcultarFatca3 = TRUE;
    	  OcultarFatca4 = FALSE;
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = TRUE;
     	  OcultarFatca7 = TRUE;
     	  OcultarFatca8  = TRUE;
     	  OcultarFatca9 = TRUE;
     	  OcultarFatca10 = TRUE;
     	  OcultarFatca11 = TRUE;
     	  OcultarFatca12  = TRUE;
     	  OcultarFatca13 = TRUE;
     	  OcultarFatca14  = TRUE;
     	  OcultarFatca15 = TRUE;
     	  OcultarFatca16  = TRUE;
     	  OcultarFatca17 = TRUE;   
           GIINSI =  TRUE;
 	}           
      } 

    
           public void FATCA6SI ()
     {
         IF(Fatca6     = TRUE)
         {
          Fatca1 = FALSE;
    	  Fatca2= FALSE;  
    	  Fatca3 = FALSE;
    	  Fatca4  = FALSE;
    	  Fatca5 = FALSE;
    	  Fatca6  = TRUE;
    	  Fatca7 = FALSE;
    	  Fatca8  = FALSE;
    	  Fatca9 = FALSE;
    	  Fatca10  = FALSE;
    	  Fatca11 = FALSE;
    	  Fatca12  = FALSE;
    	  Fatca13 = FALSE;
    	  Fatca14  = FALSE;
    	  Fatca15 = FALSE;
    	  Fatca16  = FALSE;
    	  Fatca17    = FALSE;
          OcultarFatca1 = TRUE;
     	  OcultarFatca2 = TRUE;
     	  OcultarFatca3 = TRUE;
    	  OcultarFatca4 = TRUE;
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = FALSE;
     	  OcultarFatca7 = TRUE;
     	  OcultarFatca8  = TRUE;
     	  OcultarFatca9 = TRUE;
     	  OcultarFatca10 = TRUE;
     	  OcultarFatca11 = TRUE;
     	  OcultarFatca12  = TRUE;
     	  OcultarFatca13 = TRUE;
     	  OcultarFatca14  = TRUE;
     	  OcultarFatca15 = TRUE;
     	  OcultarFatca16  = TRUE;
     	  OcultarFatca17 = TRUE;  
          GIINSI =  TRUE;
          }           
      } 
              
    public void FATCA7SI ()
     {
         IF(Fatca7     = TRUE)
         {
          Fatca1 = FALSE;
    	  Fatca2= FALSE;  
    	  Fatca3 = FALSE;
    	  Fatca4  = FALSE;
    	  Fatca5 = FALSE;
    	  Fatca6  = FALSE;
    	  Fatca7 = TRUE;
    	  Fatca8  = FALSE;
    	  Fatca9 = FALSE;
    	  Fatca10  = FALSE;
    	  Fatca11 = FALSE;
    	  Fatca12  = FALSE;
    	  Fatca13 = FALSE;
    	  Fatca14  = FALSE;
    	  Fatca15 = FALSE;
    	  Fatca16  = FALSE;
    	  Fatca17    = FALSE;
          OcultarFatca1 = TRUE;
     	  OcultarFatca2 = TRUE;
     	  OcultarFatca3 = TRUE;
    	  OcultarFatca4 = TRUE;
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = TRUE;
     	  OcultarFatca7 = FALSE;
     	  OcultarFatca8  = TRUE;
     	  OcultarFatca9 = TRUE;
     	  OcultarFatca10 = TRUE;
     	  OcultarFatca11 = TRUE;
     	  OcultarFatca12  = TRUE;
     	  OcultarFatca13 = TRUE;
     	  OcultarFatca14  = TRUE;
     	  OcultarFatca15 = TRUE;
     	  OcultarFatca16  = TRUE;
     	  OcultarFatca17 = TRUE; 
          GIINSI =  TRUE;
       }           
      } 
    
    public void FATCA8SI ()
     {
         IF(Fatca8     = TRUE)
         {
          Fatca1 = FALSE;
    	  Fatca2= FALSE;  
    	  Fatca3 = FALSE;
    	  Fatca4  = FALSE;
    	  Fatca5 = FALSE;
    	  Fatca6  = FALSE;
    	  Fatca7 = FALSE;
    	  Fatca8  = TRUE;
    	  Fatca9 = FALSE;
    	  Fatca10  = FALSE;
    	  Fatca11 = FALSE;
    	  Fatca12  = FALSE;
    	  Fatca13 = FALSE;
    	  Fatca14  = FALSE;
    	  Fatca15 = FALSE;
    	  Fatca16  = FALSE;
    	  Fatca17    = FALSE;
          OcultarFatca1 = TRUE;
     	  OcultarFatca2 = TRUE;
     	  OcultarFatca3 = TRUE;
    	  OcultarFatca4 = TRUE;
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = TRUE;
     	  OcultarFatca7 = TRUE;
     	  OcultarFatca8  = FALSE;
     	  OcultarFatca9 = TRUE;
     	  OcultarFatca10 = TRUE;
     	  OcultarFatca11 = TRUE;
     	  OcultarFatca12  = TRUE;
     	  OcultarFatca13 = TRUE;
     	  OcultarFatca14  = TRUE;
     	  OcultarFatca15 = TRUE;
     	  OcultarFatca16  = TRUE;
     	  OcultarFatca17 = TRUE;   
          GIINSI =  TRUE;
         }           
      } 
          
    
    public void FATCA9SI ()
     {
         IF(Fatca9     = TRUE)
         {
          Fatca1 = FALSE;
    	  Fatca2= FALSE;  
    	  Fatca3 = FALSE;
    	  Fatca4  = FALSE;
    	  Fatca5 = FALSE;
    	  Fatca6  = FALSE;
    	  Fatca7 = FALSE;
    	  Fatca8  = FALSE;
    	  Fatca9 = TRUE;
    	  Fatca10  = FALSE;
    	  Fatca11 = FALSE;
    	  Fatca12  = FALSE;
    	  Fatca13 = FALSE;
    	  Fatca14  = FALSE;
    	  Fatca15 = FALSE;
    	  Fatca16  = FALSE;
    	  Fatca17    = FALSE;
          OcultarFatca1 = TRUE;
     	  OcultarFatca2 = TRUE;
     	  OcultarFatca3 = TRUE;
    	  OcultarFatca4 = TRUE;
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = TRUE;
     	  OcultarFatca7 = TRUE;
     	  OcultarFatca8  = TRUE;
     	  OcultarFatca9 = FALSE;
     	  OcultarFatca10 = TRUE;
     	  OcultarFatca11 = TRUE;
     	  OcultarFatca12  = TRUE;
     	  OcultarFatca13 = TRUE;
     	  OcultarFatca14  = TRUE;
     	  OcultarFatca15 = TRUE;
     	  OcultarFatca16  = TRUE;
     	  OcultarFatca17 = TRUE;  
          GIINSI =  TRUE;
          }           
      } 
          
    
    public void FATCA11SI ()
     {
         IF(Fatca11     = TRUE)
         {
          Fatca1 = FALSE;
    	  Fatca2= FALSE;  
    	  Fatca3 = FALSE;
    	  Fatca4  = FALSE;
    	  Fatca5 = FALSE;
    	  Fatca6  = FALSE;
    	  Fatca7 = FALSE;
    	  Fatca8  = FALSE;
    	  Fatca9 = FALSE;
    	  Fatca10  = FALSE;
    	  Fatca11 = TRUE;
    	  Fatca12  = FALSE;
    	  Fatca13 = FALSE;
    	  Fatca14  = FALSE;
    	  Fatca15 = FALSE;
    	  Fatca16  = FALSE;
    	  Fatca17    = FALSE;
          OcultarFatca1 = TRUE;
     	  OcultarFatca2 = TRUE;
     	  OcultarFatca3 = TRUE;
    	  OcultarFatca4 = TRUE;
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = TRUE;
     	  OcultarFatca7 = TRUE;
     	  OcultarFatca8  = TRUE;
     	  OcultarFatca9 = TRUE;
     	  OcultarFatca10 = TRUE;
     	  OcultarFatca11 = FALSE;
     	  OcultarFatca12  = TRUE;
     	  OcultarFatca13 = TRUE;
     	  OcultarFatca14  = TRUE;
     	  OcultarFatca15 = TRUE;
     	  OcultarFatca16  = TRUE;
     	  OcultarFatca17 = TRUE;  
          GIINSI =  TRUE;
      	  }           
      } 
          
    
    public void FATCA12SI ()
     {
         IF(Fatca12     = TRUE)
         {
          Fatca1 = FALSE;
    	  Fatca2= FALSE;  
    	  Fatca3 = FALSE;
    	  Fatca4  = FALSE;
    	  Fatca5 = FALSE;
    	  Fatca6  = FALSE;
    	  Fatca7 = FALSE;
    	  Fatca8  = FALSE;
    	  Fatca9 = FALSE;
    	  Fatca10  = FALSE;
    	  Fatca11 = FALSE;
    	  Fatca12  = TRUE;
    	  Fatca13 = FALSE;
    	  Fatca14  = FALSE;
    	  Fatca15 = FALSE;
    	  Fatca16  = FALSE;
    	  Fatca17    = FALSE;
          OcultarFatca1 = TRUE;
     	  OcultarFatca2 = TRUE;
     	  OcultarFatca3 = TRUE;
    	  OcultarFatca4 = TRUE;
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = TRUE;
     	  OcultarFatca7 = TRUE;
     	  OcultarFatca8  = TRUE;
     	  OcultarFatca9 = TRUE;
     	  OcultarFatca10 = TRUE;
     	  OcultarFatca11 = TRUE;
     	  OcultarFatca12  = FALSE;
     	  OcultarFatca13 = TRUE;
     	  OcultarFatca14  = TRUE;
     	  OcultarFatca15 = TRUE;
     	  OcultarFatca16  = TRUE;
     	  OcultarFatca17 = TRUE; 
          GIINSI =  TRUE;
          }           
      } 
    
    public void FATCA13SI ()
     {
         IF(Fatca13     = TRUE)
         {
          Fatca1 = FALSE;
    	  Fatca2= FALSE;  
    	  Fatca3 = FALSE;
    	  Fatca4  = FALSE;
    	  Fatca5 = FALSE;
    	  Fatca6  = FALSE;
    	  Fatca7 = FALSE;
    	  Fatca8  = FALSE;
    	  Fatca9 = FALSE;
    	  Fatca10  = FALSE;
    	  Fatca11 = FALSE;
    	  Fatca12  = FALSE;
    	  Fatca13 = TRUE;
    	  Fatca14  = FALSE;
    	  Fatca15 = FALSE;
    	  Fatca16  = FALSE;
    	  Fatca17    = FALSE;
          OcultarFatca1 = TRUE;
     	  OcultarFatca2 = TRUE;
     	  OcultarFatca3 = TRUE;
    	  OcultarFatca4 = TRUE;
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = TRUE;
     	  OcultarFatca7 = TRUE;
     	  OcultarFatca8  = TRUE;
     	  OcultarFatca9 = TRUE;
     	  OcultarFatca10 = TRUE;
     	  OcultarFatca11 = TRUE;
     	  OcultarFatca12  = TRUE;
     	  OcultarFatca13 = FALSE;
     	  OcultarFatca14  = TRUE;
     	  OcultarFatca15 = TRUE;
     	  OcultarFatca16  = TRUE;
     	  OcultarFatca17 = TRUE;   
          GIINSI =  TRUE;
      	  }           
      } 
    
    
     public void FATCA14SI ()
     {
         IF(Fatca14     = TRUE)
         {
          Fatca1 = FALSE;
    	  Fatca2= FALSE;  
    	  Fatca3 = FALSE;
    	  Fatca4  = FALSE;
    	  Fatca5 = FALSE;
    	  Fatca6  = FALSE;
    	  Fatca7 = FALSE;
    	  Fatca8  = FALSE;
    	  Fatca9 = FALSE;
    	  Fatca10  = FALSE;
    	  Fatca11 = FALSE;
    	  Fatca12  = FALSE;
    	  Fatca13 = FALSE;
    	  Fatca14  = TRUE;
    	  Fatca15 = FALSE;
    	  Fatca16  = FALSE;
    	  Fatca17    = FALSE;
          OcultarFatca1 = TRUE;
     	  OcultarFatca2 = TRUE;
     	  OcultarFatca3 = TRUE;
    	  OcultarFatca4 = TRUE;
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = TRUE;
     	  OcultarFatca7 = TRUE;
     	  OcultarFatca8  = TRUE;
     	  OcultarFatca9 = TRUE;
     	  OcultarFatca10 = TRUE;
     	  OcultarFatca11 = TRUE;
     	  OcultarFatca12  = TRUE;
     	  OcultarFatca13 = TRUE;
     	  OcultarFatca14  = FALSE;
     	  OcultarFatca15 = TRUE;
     	  OcultarFatca16  = TRUE;
     	  OcultarFatca17 = TRUE;   
          GIINSI =  TRUE;
      
          }           
      } 
    
    public void FATCA15SI ()
     {
         IF(Fatca15     = TRUE)
         {
          Fatca1 = FALSE;
    	  Fatca2= FALSE;  
    	  Fatca3 = FALSE;
    	  Fatca4  = FALSE;
    	  Fatca5 = FALSE;
    	  Fatca6  = FALSE;
    	  Fatca7 = FALSE;
    	  Fatca8  = FALSE;
    	  Fatca9 = FALSE;
    	  Fatca10  = FALSE;
    	  Fatca11 = FALSE;
    	  Fatca12  = FALSE;
    	  Fatca13 = FALSE;
    	  Fatca14  = FALSE;
    	  Fatca15 = TRUE;
    	  Fatca16  = FALSE;
    	  Fatca17    = FALSE;
          OcultarFatca1 = TRUE;
     	  OcultarFatca2 = TRUE;
     	  OcultarFatca3 = TRUE;
    	  OcultarFatca4 = TRUE;
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = TRUE;
     	  OcultarFatca7 = TRUE;
     	  OcultarFatca8  = TRUE;
     	  OcultarFatca9 = TRUE;
     	  OcultarFatca10 = TRUE;
     	  OcultarFatca11 = TRUE;
     	  OcultarFatca12  = TRUE;
     	  OcultarFatca13 = TRUE;
     	  OcultarFatca14  = TRUE;
     	  OcultarFatca15 = FALSE;
     	  OcultarFatca16  = TRUE;
     	  OcultarFatca17 = TRUE;   
          GIINSI =  TRUE;
      	  }           
      } 
    
    public void FATCA16SI ()
     {
         IF(Fatca16     = TRUE)
         {
          Fatca1 = FALSE;
    	  Fatca2= FALSE;  
    	  Fatca3 = FALSE;
    	  Fatca4  = FALSE;
    	  Fatca5 = FALSE;
    	  Fatca6  = FALSE;
    	  Fatca7 = FALSE;
    	  Fatca8  = FALSE;
    	  Fatca9 = FALSE;
    	  Fatca10  = FALSE;
    	  Fatca11 = FALSE;
    	  Fatca12  = FALSE;
    	  Fatca13 = FALSE;
    	  Fatca14  = FALSE;
    	  Fatca15 = FALSE;
    	  Fatca16  = TRUE;
    	  Fatca17    = FALSE;
          OcultarFatca1 = TRUE;
     	  OcultarFatca2 = TRUE;
     	  OcultarFatca3 = TRUE;
    	  OcultarFatca4 = TRUE;
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = TRUE;
     	  OcultarFatca7 = TRUE;
     	  OcultarFatca8  = TRUE;
     	  OcultarFatca9 = TRUE;
     	  OcultarFatca10 = TRUE;
     	  OcultarFatca11 = TRUE;
     	  OcultarFatca12  = TRUE;
     	  OcultarFatca13 = TRUE;
     	  OcultarFatca14  = TRUE;
     	  OcultarFatca15 = TRUE;
     	  OcultarFatca16  = FALSE;
     	  OcultarFatca17 = TRUE;   
          GIINSI =  TRUE;
      
          }           
      } 
    
    public void FATCA17SI ()
     {
         IF(Fatca16     = TRUE)
         {
          Fatca1 = FALSE;
    	  Fatca2= FALSE;  
    	  Fatca3 = FALSE;
    	  Fatca4  = FALSE;
    	  Fatca5 = FALSE;
    	  Fatca6  = FALSE;
    	  Fatca7 = FALSE;
    	  Fatca8  = FALSE;
    	  Fatca9 = FALSE;
    	  Fatca10  = FALSE;
    	  Fatca11 = FALSE;
    	  Fatca12  = FALSE;
    	  Fatca13 = FALSE;
    	  Fatca14  = FALSE;
    	  Fatca15 = FALSE;
    	  Fatca16  = FALSE;
    	  Fatca17    = TRUE;
          OcultarFatca1 = TRUE;
     	  OcultarFatca2 = TRUE;
     	  OcultarFatca3 = TRUE;
    	  OcultarFatca4 = TRUE;
     	  OcultarFatca5 = TRUE;
     	  OcultarFatca6  = TRUE;
     	  OcultarFatca7 = TRUE;
     	  OcultarFatca8  = TRUE;
     	  OcultarFatca9 = TRUE;
     	  OcultarFatca10 = TRUE;
     	  OcultarFatca11 = TRUE;
     	  OcultarFatca12  = TRUE;
     	  OcultarFatca13 = TRUE;
     	  OcultarFatca14  = TRUE;
     	  OcultarFatca15 = TRUE;
     	  OcultarFatca16  = TRUE;
     	  OcultarFatca17 = FALSE;  
          GIINSI =  TRUE;
      
          }           
      } 
    
    
    
    public void FATCANADA ()
     {
          Fatca1 = FALSE;
    	  Fatca2= FALSE;  
    	  Fatca3 = FALSE;
    	  Fatca4  = FALSE;
    	  Fatca5 = FALSE;
    	  Fatca6  = FALSE;
    	  Fatca7 = FALSE;
    	  Fatca8  = FALSE;
    	  Fatca9 = FALSE;
    	  Fatca10  = FALSE;
    	  Fatca11 = FALSE;
    	  Fatca12  = FALSE;
    	  Fatca13 = FALSE;
    	  Fatca14  = FALSE;
    	  Fatca15 = FALSE;
    	  Fatca16  = FALSE;
    	  Fatca17    = FALSE;
          OcultarFatca1 = FALSE;
     	  OcultarFatca2 = FALSE; 
     	  OcultarFatca3 = FALSE;
     	  OcultarFatca4 = FALSE; 
     	  OcultarFatca5 = FALSE;
     	  OcultarFatca6  = FALSE;
     	  OcultarFatca7 = FALSE;
     	  OcultarFatca8  = FALSE;
     	  OcultarFatca9 = FALSE;
     	  OcultarFatca10  = FALSE;
     	  OcultarFatca11 = FALSE;
     	  OcultarFatca12  = FALSE;
     	  OcultarFatca13 = FALSE;
     	  OcultarFatca14  = FALSE;
     	  OcultarFatca15 = FALSE;
     	  OcultarFatca16  = FALSE;
     	  OcultarFatca17 = FALSE;
         GIINSI =  TRUE;
      
          }        
    
    public boolean bloqeListEnti {get; set;}
    
         PUBLIC VOID HABILITARTIN(){
         if(pcListEntidad !='4' && (PAIS_CONSEMP == '053' || PAIS_CONSEMP == '144') ){ TINS =  TRUE;
             }else{
                 TINS =  FALSE;
             }
    }
    
   PUBLIC VOID Validacionsocial(){
       if( Fatca1 == TRUE || Fatca2== TRUE || Fatca3==TRUE ){ GIINSI =  false;
                                                             }else{
                                                                 GIINSI =  TRUE;
                                                             }
   }
    
    
   
 PUBLIC VOID GIINHABILITAR(){
         if( Fatca1 == TRUE || Fatca2== TRUE || Fatca3==TRUE ){ GIINSI =  false;
             }else{
                 GIINSI =  TRUE;
             }
    }    
         
    
        public void minimo13()
    {
        if (NumeroID_Fiscal_EEUU.length() < 10 || NumeroID_Fiscal_EEUU.length() > 8)
        {
            Apexpages.addMessage(new Apexpages.Message(ApexPages.severity.INFO, 'El debe campo de contener 9 digitos')); 
            return ;
        }
    }    
    
    
     public void validatipo_id()
    {
        if (pctipoid !='5')
        {
            pctipoid='';
            Apexpages.addMessage(new Apexpages.Message(ApexPages.severity.INFO, 'Tipo de Id Incorrecto')); 
            return ;
        }
    }    
    
       
    public list <selectOption> entidadList {get; set;}
    public void TipoEntidadLLenar(){
        
		entidadList = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.TIPO_ENTIDAD_FATCA__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();
        map<string, string> mapisv= new map<string, string>();
        entidadList.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
     		entidadList.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
         
     
    public list <selectOption> listAsesor {get; set;}
    public void asesores(){
        
		listAsesor = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Asesor__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();
        map<string, string> mapisv= new map<string, string>(); 
        listAsesor.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
     		listAsesor.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    
    
    public void validatipo_prod()
    {
        if (pcTipoFondo == 'N') { pcTipoFondo='';
            Apexpages.addMessage(new Apexpages.Message(ApexPages.severity.INFO, 'Tipo de Fondo Incorrecto')); 
            return ;
        }
    }    
    
    
    public void tipoentidadhabilitar(){
        if (ENTIDADSI== true && PASIVA== true){
        } 
        
    }
    

    //////////
    
      public void AplicaResidenciaEfectos()
     {
         IF(ES_Residente_EfectosMi = TRUE)
         {
          OcultarES_Residente_EfectosMi = false;
          OcultarES_Residente_EfectosNO = true;
          ES_Residente_EfectosMi = TRUE;
          ES_Residente_EfectosMiNO = false;
          } 
      } 
    
      public void AplicaResidenciaEfectosNO()
     {
         IF(ES_Residente_EfectosMiNO = TRUE)
         {
          OcultarES_Residente_EfectosMi = true;
          OcultarES_Residente_EfectosNO = false;
          ES_Residente_EfectosMi = false;
          ES_Residente_EfectosMiNO = true;
          } 
      } 
    
      public void ResidenteEfectosNADA()
     {
        
          OcultarES_Residente_EfectosMi = false;
          OcultarES_Residente_EfectosNO = false;
          ES_Residente_EfectosMi = false;
          ES_Residente_EfectosMiNO = false; 
              
      } 
    
    
    
    public void limpiar(){
        
        VentanaFatca=false;
         bloqbtnpagina=true;
           bloqcausa=true;
           bloqestado=true;
           bloqcuenta=true;
         pnnrocertificado /*IDFOrmulario*/ = null;
         pctipoid /*TipoID*/ = null;
         pcnroid /*NumeroID*/ = null;
         pcFechaVencimientoCN /*FechaVencimiento*/ = null;
         pdfechasuscripcion /*FechaSuscripcion*/  = null;
         CuentaMostrar=null;
         pcPEP = null;
         AML = null;
         pcFATCA = null;
        pcFATCANC = null;
         MTO_APROX_ACTIVO=null;
         PAIS1=null;
        DEPTO1=null;
        REF1_PROVE_NOMB=null;
        REF1_PROVE_PRODUC=null;
        REF1_PROVE_TEL=null;
        REF2_PROVE_NOMB=null;
        REF2_PROVE_PRODUC=null;
        REF2_PROVE_TEL=null;
        REF1_BANCA_NOMB=null;
        REF1_BANCA_TEL=null;
        REF2_BANCA_NOMB=null;
        REF2_BANCA_TEL=null;
        PAIS_CONSEMP=null;
        FECHA_CONSTITUCION=null;
        NUM_ACCIONISTAS=null;
        AMPLIAR_ACT_ECONOMICA=null;
        fechaValida=null;
        TipoAport.Tipo_Aporte__c=null;
        fechasuscripcion=null;
        NUM_TOT_EMPLEADOS=null;
        OTROS_OBLIGSI=false;
        OTROS_OBLIGNO=false;
        PaisResidenciaEfectosFiscales=null;
        NumeroID_Fiscal_OtroPais=null;
        DIR_CORRESPONDENCIA=null;
        ENTIDADSI=false;
        ENTIDADNO=false;
        mostrarTablaModificar = false;
        mostrarTablaModifi2 = false;
		mostrarTabla = false;
        ListSociosTIN=null;
        ListSocios=null;
        ListPropiedadControl = null;
        NombreRL=null;
        
        ListDebidaDil  = null;
        ListClienteONG = null;
        ValorContratistasi = false;
		ValorContratistano = false;
        valorsiONG = false;
		valornoONG = false;
        ValorEmpresaMercaSI = false;
        ValorPersonaUsaSI  = false;
        activadesacContratista = true;
		activadesacONG = true;
        OcultarSiContratista = false;
        OcultarNoContratista = false;
        OcultarONGSI = false;
        OcultarONGNO = false;
        MostrarTablaDiligencia = false;
        MostrarActDili = false;
        MostrarTablaClienteONG = false;
        MostrarActuaONG = false;
        ListClienteONG = new List<DebidaDiliClienteONG>();
        ClienteONG = new DebidaDiliClienteONG(0,'','','','','','','',null);
        ListDebidaDil = new List<claseDebidaDilContratista>();
        debidaDil  = new claseDebidaDilContratista (null,'','','','','', '', '',null,'');
        OcultarAccionistaSI = true;
        ACC_10DE_CONTROLSI = false;
        OcultarAccionistaNO = true;
        ACC_10DE_CONTROLNO = false;
        OcultarPersonaUSASI = true;
        ValorPersonaUsaSI = false;
        OcultarPersonaUSANO = true;
        ValorPersonaUsaNo = false;
        OcultarEmpresaSI = true;
        ValorEmpresaMercaSI = false;
        OcultarEmpresaNO = true;
        ValorEmpresaMercaNO = false;
        SOCIO = true;
        OcultarPASIVA = true;
        PASIVA = false;
        ContratistaDirecto = false;
		ContratistaSub = false;
		DonacionPrivada = false;
		DonacionLocalExtra = false;
        
        Segun_depto = false; //agregado 28052019
         pcprimernombre /*primerNombre*/  = null;
         pcsegundonombre /*SegundoNombre*/  = null;
         pcsegundoapellido /*SegundoApellido*/  = null;
         pcprimerapellido /*primerApellido*/  = null;
         pcTelefonoCN = null;
         pcCelularCN /*Celular*/  = null;
         pdfechanacimiento /*FechaNacimiento*/  = null;
         pdLugarNacimientoCN /*LugarNacimiento*/  = null;
         TipoSexo.Sexo__c /*Genero*/  = null;
         pcestadocivil /*EstadoCivil*/  = null;
         pcNombreConyuge = null;
         TipoProfesion.Profesi_n_Ocupaci_n__c = null;
    	 pcProfesionOcupacion2 = null;
         pcmail /*Correo*/  = null;
         pcAPNFDSI = null;   
         pcAPNFDNO = null;                        
         PCNumeroAPNFD = null;
         PC_NIVEL_RIESGO = null;
         PC_DEBIDA_DELIGENCIA = null;
        
         NUMID_FIRMAN1=null;
         COD_CTE_FIR1=null;
         NOM_FIRMAN1=null;
         NUMID_FIRMAN2=null;
         COD_CTE_FIR2=null;
         NOM_FIRMAN2=null;
         NUMID_FIRMAN3=null;
         COD_CTE_FIR3=null;
         NOM_FIRMAN3=null;
         NUM_ID_CONTR_SOCI=null;
         NOMBRE_CONTR_SOC=null;
         pnmontoaporte=null;
        
        pcnumeroidsocc=null;
        socioUnico.nombresocio=null;
        Cliente1.Tipo_Persona__c=null;
        socioUnico.nacionalidad=null;
        socioUnico.NIVEL=null;
        socioUnico.POR_PART_DIRECT=null;
        socioUnico.POR_PART_INDIRECT=null;
        socioUnico.NUMERO_ID_EMPRESA=null;
        pcCotizaSI=false;
        pcCotizaNO=false;            
        socioUnico.TIC_SYMBOL=null;
        pcFATCA = NULL;
        AML = NULL;
        pcPEP = NULL;
        OTROS_OBLIGSI = NULL;
        OTROS_OBLIGNO =NULL;
        OcultarOTROS_OBLIGSI=false;
        OcultarOTROS_OBLIGNO=false;
                
        ACC_10DE_CONTROLSI = NULL;
        ACC_10DE_CONTROLNO = NULL;
        OcultarACC_10DE_CONTROLSI=false;
        OcultarACC_10DE_CONTROLNO=false;
        
        PAIS3=null;
        PAIS2=null;
        DEPTO2=null;
        DEPTO3=null;
        pcAPNFDSI = NULL;
        pcAPNFDNO = NULL;
        OcultarAPNFD=false;
        OcultarAPNFDNO=false;
        
         pcNumeroIDPV /*NumeroIDPerfilVinculacion*/  = null;
         pcNombreCompletoPV /*NombreCompleto*/  = null;
        
        //DependenciaEconomica
         pcDependeSI /*siDependencia*/  = null;
         pcDependeNO /*NoDependencia*/  = null;
         Dis_OcultarDependenciaSI=false;
         Dis_OcultarDependenciaNO=false;
         pcTipoIDDependencia /*TipoID_DependenciaEconomica*/  = null;
         pcNumeroIDDependencia /*NumeroID_DependenciaEconomica */  = null;
         //pcParentescoDependencia /*Parentesco_DependenciaEconomica*/  = null;
         pcNombreCompletoDependencia /*NombreCompleto_DependenciaEconomica*/  = null;
        
        //InfoDireccion
         pccodpais /*Pais_Direccion*/  = null;
         pcDeptoCN /*Depto_Direccion*/  = null;
         pcMunicipioCN /*Municipio_Direccion*/  = null;
         pcColoniaCN /*Colonia_Direccion*/ = null;
         pcCalleDetalleCN /*Calle_Direccion*/  = null;
         pcnacionalidad /*Nacionalidad1_Direccion*/  = null;
         pcnacionalidad2 /*Nacionalidad2_Direccion*/  = null;
         pcnacionalidad3 /*Nacionalidad3_Direccion*/  = null;
        
        //referencias
         pcPrimerNombreReferi1 /*PrimerNombre_referencia*/  = null;
         pcSegundoNombreReferi1 /*SegundoNombre_referencia*/  = null;
         pcPrimerApellidoReferi1 /*PrimerApellido_referencia*/  = null;
         pcSegundoApellidoReferi1 /*SegundoApellido_referencia*/  = null;
         pcTelefono_Referido1Referi1 /*Telefono_referencia*/  = null;
        
         pcPrimerNombreReferi2 /*PrimerNombre_referencia*/  = null;
         pcSegundoNombreReferi2 /*SegundoNombre_referencia*/  = null;
         pcPrimerApellidoReferi2 /*PrimerApellido_referencia*/  = null;
         pcSegundoApellidoReferi2 /*SegundoApellido_referencia*/  = null;
         pcTelefono_ReferidoReferi2 /*Telefono_referencia*/  = null;
        
        //DatoEMpleador
         pccontratocolectivo = null;
         pcrncempl /*RTN*/  = null; 
         ClienteTipoId.Tipo_Empresa__c /*TipoEmpresa*/  = null;
         pcNombreempl = null; 
         pcrazonsocialempl /*RazonSocial*/  = null;
         pcCargoEmpresaEmpCN /*CargoEmpresa*/  = null;
         Cliente25.Sector__c /*GiroEmpresa*/  = null;
         pctelempl = null;
         pcextempl = null;
         pcmailempl = null;
        
        //EMpleadorDIreccion
         pcPaisEmpleadorCN = null;
         pcDeptoEmpleadorCN = null;
         pcMunicipioEmpleadorCN = null;
         pcColoniaEmpleadorCN = null;
         //nacionalidadEmpleado = null;
         pcdirempl = null;
        
        //DatoEmpleado
         pcTIpoEmpleado /*TipoEmpleado*/  = null;
         pdfechainiciolabor = null;
         pcNivelIngreso /*NivelIngreso*/  = null;
         //pcVolumenIngresoCN /*VolumenIngreso*/  = null;
        
        //DatoEmpleado
         pcUsuarioCN /*usuarioValidacion*/  = null;
         pcFechaValidacionCN /*FechaValidacion*/  = null;
        
        //PantallaProducto
         pcproducto /*Producto*/  = null;
         pcsubproducto /*Subproducto*/  = null;
         pcTipoFondo /*TipoFondo*/  = null;
         TipMoneda.Tipo_Moneda__c /*TipoMoneda*/  = null;
         Cuenta20.Frecuencia_Aportacion__c /*Periodicidad*/  = null;
         pcformapago/*FormaPago*/  = null;
         //Cuenta20.Forma_Aportacion__c /*FormaPago*/  = null;
         DiaMes.Dias_Mes__c /*DiaAportacion*/  = null;
         pnmontoaporte /*MontoAporte*/  = null;
         pccuentapago /*CuentaCTA*/  = null;
         pcSalarioP /*salario*/  = null;
         pcAportacionEmpleadoP /*AporEmpleado*/  = null;
         pcAportacionTrabajoP /*AporTrabajo*/  = null;
         //pcaplicaseguro /*AplicaSeguroSI*/  = null;
         //AplicaSeguroNO = null;
         pcPrimaAsegurada /*PrimaSeguro*/  = null;
         pcSumaAsegurada /*MontoSeguro*/  = null;
         pcNUMUSU /*Numusu*/  = null;
         TipoEnvioo.Tipo_EnvioNuevo__c /*EnvioCorreo*/  = null;
         //TipoAport.Tipo_Aporte__c = /*Tipo Aporte*/ null;
         v_des_procedfds = null;
         Codigo_Ente = null;
         ////////////////////////////////////
         pcpromotor /*promotorProducto*/  = null;
         CanalVentaa.Canal_Venta__c /*CanalVentas*/  = null;

          	 Fatca1 = NULL;  
             Fatca2 = NULL; 
             Fatca3 = NULL;  
             Fatca4 = NULL; 
             Fatca5 = NULL;  
             Fatca6 = NULL; 
             Fatca7 = NULL;  
             Fatca8 = NULL; 
             Fatca9 = NULL;  
             Fatca10 = NULL; 
             Fatca11 = NULL;  
             Fatca12 = NULL; 
             Fatca13 = NULL;  
             Fatca14 = NULL; 
             Fatca15 = NULL;  
             Fatca16 = NULL; 
             Fatca17 = NULL;  
         ENTIDADSI = NULL;  
     ENTIDADNO = NULL;   
     SOCIOSI = NULL;  
     SOCIONO = NULL;  
     ACC_10DE_CONTROLSI = NULL;  
     ACC_10DE_CONTROLNO = NULL;  
     ACTIVA = NULL;  
     PASIVA = NULL;
        mostrarBotonPan = false;
        deptoopera1 = true;
        ListSocios = new List<socios>();
        ListSociosTIN = new List<SociosTIN>();
        iniciar();
    }
         
    
    public pageReference MostarPantalla()
    {
       
        return new pageReference('/apex/VFPantallaProducto');  
    } 

    //Metodo para mostrar los datos de un input en otor formulario
     

    public pageReference VALIDAR_ENVIAR_VFPRODUCTO(){
        try{
             
            if( pnnrocertificado == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Número Formulario Vacio'));
            return null;    
            }
            
            if( pctipoid != '5')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tipo ID Vacio o Incorrecto '));
            return null;    
            }
            
            if (ListSociosTIN == null){
                
            }
            
            
            if( pcnroid == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Numero ID Vacio'));
            return null;    
            }
            
            if( pcrazonsocialempl == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Razón o Donominación Social Vacio'));
            return null;    
            }
            
            if( pcNombreempl == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Nombre Comercial Vacio'));
            return null;    
            }
            
            if( OcultarAPNFD == null && OcultarAPNFDNO == null )
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'APNFD Vacio'));
            return null;    
            }
            
            if( pcAPNFDSI == TRUE )
            {         
                if (PCNumeroAPNFD == null )
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tipo APNFD Vacio'));
            	    return null; 
                }
            	   
            }
            
            
            if( NUM_TOT_EMPLEADOS == '' )
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'# Total Empleado Vacio'));
            return null;    
            }
            
            if( MTO_APROX_ACTIVO == '' )
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Monto Aprox. Activo Vacio'));
            return null;    
            }
                        
            if( OcultarOTROS_OBLIGSI == null && OcultarOTROS_OBLIGNO == null )
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Otros Obligados Vacio'));
            return null;    
            }
            
            //Agregado 10-04-2019
            if( ValorContratistasi == false && ValorContratistano == false)
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No selecciono, Contratista del Estado'));
            return null;    
            }
            
            if( valorsiONG == false && valornoONG == false)
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No selecciono, Cliente ONG-OSFL'));
            return null;    
            }
            
            //fin
            
            
            if( pcFATCA == TRUE )
            {         
            
                if( PaisResidenciaEfectosFiscales == ' --Ninguno-- ' )
                {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'País Residencia Efectos Fiscales Vacio'));
                return null;    
                }
            
            if( TINS == true   )
            {   
                if (NumeroID_Fiscal_EEUU == '')
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'TIN/EIN Vacio'));
                    return null;    
                }
                 if  (NumeroID_Fiscal_EEUU.length() < 8 )
                {
                        Apexpages.addMessage(new Apexpages.Message(ApexPages.severity.INFO, 'El campo TIN/EIN  de contener 8-9 digitos')); 
                        return NULL;
                }   
              }
            
            
            
           /* if (TINS == TRUE && (NumeroID_Fiscal_EEUU.length() 9 10 && NumeroID_Fiscal_EEUU.length() > 7))
        {
            Apexpages.addMessage(new Apexpages.Message(ApexPages.severity.INFO, 'El campo de contener 8-9 digitos')); 
            return NULL;
        }*/                                            

            
            if( NumeroID_Fiscal_EEUU == '' && TINS == true   )
                {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'País Residencia Efectos Fiscales Vacio'));
                    
                return null;    
                }
                
            if (ENTIDADSI == false && ENTIDADNO == false)
                {
                    Apexpages.addMessage(new Apexpages.Message(ApexPages.severity.INFO, '¿ Es una Entidad o una Institución Finanaciera? Vacio')); 
                    return NULL;
                }    
            
             if( ENTIDADSI == true &&  PASIVA == true)
            {          
                
                if(pcListEntidad== ' --Ninguno-- ')
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tipo de Entidad Vacio'));
                    return null;    
                 }
               
            }      
   
            if (ENTIDADSI == true)
            { 
            	if (ACC_10DE_CONTROLSI == false && ACC_10DE_CONTROLNO == false)
                {
                    Apexpages.addMessage(new Apexpages.Message(ApexPages.severity.INFO, '¿ Tiene accionista en EE.UU. con 10% o más de control? Vacio')); 
                    return NULL;
                }    
                    
                        if (ACTIVA == false && PASIVA == false)
                {
                    Apexpages.addMessage(new Apexpages.Message(ApexPages.severity.INFO, 'Indique si la entidad es Activa o Pasiva para efecto Fatca Vacio')); 
                    return NULL;
                }
                
                //Agregado 10-04-2019
                if (ValorEmpresaMercaSI == false && ValorEmpresaMercaNO== false)
                {
                    Apexpages.addMessage(new Apexpages.Message(ApexPages.severity.INFO, '¿ Es Empresa Mercantil? Vacio')); 
                    return NULL;
                }
                
                if(PASIVA == true  && ValorEmpresaMercaSI == true){
                    
                    if (ACC_10DE_CONTROLSI == false && ACC_10DE_CONTROLNO == false)
                	{
                    	Apexpages.addMessage(new Apexpages.Message(ApexPages.severity.INFO, '¿ Tiene accionista en EE.UU. con 10% o mas de control? Vacio')); 
                    	return NULL;
                	}
                }
                
                if(PASIVA == true && ValorEmpresaMercaNO == true){
                    
                    if(ValorPersonaUsaSI == false && ValorPersonaUsaNo == false){
                        Apexpages.addMessage(new Apexpages.Message(ApexPages.severity.INFO, '¿ Tiene Persona USA en Junta Directiva? Vacio')); 
                    	return NULL;
                    }
                }//fin
             }  
          
            if (ENTIDADNO == true )   
            {
                if(Fatca1 == false && Fatca2 == false && Fatca3 == false && Fatca4 == false && Fatca6 == false &&
                          Fatca7 == false && Fatca8 == false  && Fatca9 == false && Fatca11 == false && Fatca12 == false &&
                          Fatca13 == false && Fatca14 == false && Fatca15 == false && Fatca16 == false && Fatca17 == false)
                {
                    Apexpages.addMessage(new Apexpages.Message(ApexPages.severity.INFO, 'No ha seleccionado una institución Financiera')); 
                    return null;
                }

                
           }
                
                            if (GIINSI == false )
            { if (GIIN == '' ){
            Apexpages.addMessage(new Apexpages.Message(ApexPages.severity.INFO, 'GIIN Vacio')); 
            return NULL;
                }
        }
                
                if (GIINSI == false ){
                     if(GIIN.length() < 20 && GIIN.length() > 18){
            Integer num = GIIN.length();        
            if(!pattern.matches('((?=.*\\d)+(?=.*[A-Z])+(?=.*[.])+(?=.*\\d)+(?=.*[.])+(?=.*[A-Z])+(?=.*[.])+(?=.*\\d).{'+ num +'})', GIIN)) {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR,                         
                        'Campo GIIN debe de contener letras números y el símbolo punto [.]')); 
                return null;
            }
        }else{
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'El campo GIIN debe de contener 19 caracteres'));       
                return null;             
        }  
                }
                
               // 1LLZDC.99999.SL.340

            
             if (ACC_10DE_CONTROLSI == true) {
                        if (ListSociosTIN.size()<=0 ){
                          Apexpages.addMessage(new Apexpages.Message(ApexPages.severity.INFO, 'Socio Vacio')); 
            				return NULL;   
                            
                        }
                    }
                
                
             
            			
              }
           /* 
        
*/
               if (pcListEntidad == '3'){
                    if((PAIS_CONSEMP!='053' ) && (PaisResidenciaEfectosFiscales!= '053')){
                        
                          Apexpages.addMessage(new Apexpages.Message(ApexPages.severity.INFO, 'País de Constitución y País Residencia para Efectos Fiscales debe de Ser EEUU/ Puerto Rico')); 
                    }
                    
                }
     
            if( pccodpais == ' --Ninguno-- ')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'País '));
            return null;    
            }
            
            if( pcDeptoCN == ' --Ninguno-- ')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Departamento Vacio'));
            return null;    
            }
            
            if( pcMunicipioCN == ' --Ninguno-- ')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Municipio Vacio'));
            return null;    
            }
            
            if( pcColoniaCN == ' --Ninguno-- ')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Colonia Vacio'));
            return null;    
            }
            
            if( pcCalleDetalleCN == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Calle/Detalle Vacio'));
            return null;    
            }
            
            if( PAIS1 == ' --Ninguno-- ')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'País 1 Donde Opera Vacio'));
            return null;    
            }
             if( Segun_pais == TRUE )
            {         
                if (PAIS2 == ' --Ninguno-- ' )
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'País 2 Donde Opera Vacio'));
            	    return null; 
                }
            	   
            }
            
            if( DEPTO1 == ' --Ninguno-- ')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Depto 1 Donde Opera Vacio'));
            return null;    
            }
            
             if( Segun_depto == TRUE )
            {         
                if (DEPTO2 == ' --Ninguno-- ' )
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'País 2 Donde Opera Vacio'));
            	    return null; 
                }
            	   
            }

             if( pcTelefonoCN == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Teléfono Vacio'));
            return null;    
            }

            if( pcNombreCompletoPV == ''  )
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cod. Cte y Nombre del Firmante 1 Vacio'));
            return null;    
            }
            
            if( COD_CTE_FIR1 == '' && NOM_FIRMAN1 == '' )
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cod. Cte y Nombre del Firmante 1 Vacio'));
            return null;    
            }
            
            if( COD_CTE_FIR2 == '' && NOM_FIRMAN2 == '' )
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cod. Cte y Nombre del Firmante 2 Vacio'));
            return null;    
            }
            
            if( COD_CTE_FIR3 == '' && NOM_FIRMAN3 == '' )
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cod. Cte y Nombre del Firmante 3 Vacio'));
            return null;    
            }
            
            if( pcDependeSI == false && pcDependeNO == false )
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Pertenece a un Grupo Econom. Vacio'));
            return null;    
            }
            
            if( pcDependeSI == TRUE )
            {         
                if (pcNombreCompletoDependencia == '' )
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'A Cual Grupo Econom. Pertenece Vacio'));
            	    return null; 
                }
            	   
            }  
            
            if(REF1_PROVE_NOMB!='null' && REF1_PROVE_PRODUC!='null' && REF1_PROVE_TEL!='null' && REF1_BANCA_NOMB!='null' && REF1_BANCA_TEL!='null' )
            {          
              } else if (REF1_PROVE_NOMB!='null' && REF1_PROVE_PRODUC!='null' && REF1_PROVE_TEL!='null' && REF1_BANCA_NOMB!='null' && REF2_BANCA_NOMB!='null' && REF2_BANCA_TEL!='null' )
            {          
              } else if (REF1_PROVE_NOMB!='null' && REF1_PROVE_PRODUC!='null' && REF1_PROVE_TEL!='null' && REF2_PROVE_NOMB!='null' && REF2_PROVE_PRODUC!='null' &&  REF2_PROVE_TEL!='null')
                 {
                   }else if (REF2_PROVE_NOMB!='null' && REF2_PROVE_PRODUC !='null' &&  REF2_PROVE_TEL !='null' && REF1_BANCA_NOMB!='null' && REF1_BANCA_TEL!='null')
                    {
                      }else if(REF2_PROVE_NOMB!='null' && REF2_PROVE_PRODUC!='null' &&  REF2_PROVE_TEL!='null' && REF2_BANCA_NOMB!='null' && REF2_BANCA_TEL!='null')
                        {
                          }else if (REF1_BANCA_NOMB!='null' && REF1_BANCA_TEL!='null'  && REF2_BANCA_NOMB!='null' && REF2_BANCA_TEL!='null')
                           {
                             }else 
                             {
                                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Referencias Vacias, Ingrese por los Menos DOS Referencias'));
                                 return null;   
                             }
                            
                                                  
            if( PAIS_CONSEMP == ' --Ninguno-- ')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'País de Constitucion Vacio'));
            return null;    
            }
            
             if( FECHA_CONSTITUCION == null)
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Fecha Constitucion Vacio'));
            return null;    
            }
            
            if( NUM_ACCIONISTAS == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'# de Accionistas Vacio'));
            return null;    
            }
            
            if( Cliente25.Sector__c == ' --Ninguno-- ')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Obj. Social/Act. Económica Vacio'));
            return null;    
            }
            
            if (FECHA_CONSTITUCION>date.today())
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'En el Campo Fecha de Constitución No se Permiten Fechas Mayores a la Actual'));
                    return null;
                }
            
             if (pcrazonsocialempl.length()>=65)
             {
               ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'El campo Razon Social Debe de Contener Menos de 65 Caracteres')); 
               return null;   
                 } 
            
            if (pcNombreempl.length()>=65)
            {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'El campo Nombre Comercial Debe de Contener Menos de 65 Caracteres'));   
                return null; 
            }                                    
            
            if( NumeroID_Fiscal_OtroPais == 'N/A')
            {   
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'En Numero Fiscal de Otro Pais No Se Permite Este Formato N/A'));
                return null;    
            }
            
            if (AMPLIAR_ACT_ECONOMICA.length()>=150)
             {
               ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'El campo Ampliar Debe de Contener Menos de 150 Caracteres')); 
               return null;   
                 }
            
          else
           {   
             
               	paso1Cabeza = 'slds-is-complete';
	            paso1Cuerpo = 'slds-hide';
	            
	            paso2Cabeza = 'slds-is-current';
	            paso2Cuerpo = 'slds-show';
                return null;
        
             }     
      } 
      
      catch(Exception e)
    	{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
     	}
         return null;
        
     }
     
    public date fechasuscripcion{get;set;}
    public date fechaVencimiento{get;set;}
    public date fechaNacimiento{get;set;}
    public date fechaLabor{get;set;}
    public date fechaValida{get;set;} 
    public date fechaBeneficiario{get;set;}
    
    //METODO EL CUAL ENVIARA TODA LA INFORMACION 
    
      public pageReference guardar(){
        try{
                ClassPantJuridicoProduc juridicoEnvio = new ClassPantJuridicoProduc();
                juridicoEnvio.numtran = numtran; //Agregado 08/04/2020
                juridicoEnvio.pcagencia /*Cod_Agencia*/ = pcagencia;
                juridicoEnvio.pcempresa /*Cod_Agencia*/ = pcempresa;
                juridicoEnvio.pcEst_Cuenta=Activo;
                juridicoEnvio.pnnrocertificado /*IDFOrmulario*/= pnnrocertificado;
                juridicoEnvio.pctipoid /*TipoID*/= pctipoid;   
                juridicoEnvio.pcnroid /*NumeroID*/= pcnroid;
                juridicoEnvio.pcFechaVencimientoCN /*FechaVencimiento*/= fechaVencimiento;
                juridicoEnvio.pdfechasuscripcion /*FechaSuscripcion*/ = date.today();

                if(pcPEP == true)
                 {
                     juridicoEnvio.pcPEP = 'S';
                 }
                else
                {
                    juridicoEnvio.pcPEP = 'N';
                }
                
                if(pcFATCA == true)
                 {
                     juridicoEnvio.pcFATCA = 'S';
                 }
                else
                {
                    juridicoEnvio.pcFATCA = 'N';
                }
            	if(pcFATCANC == true)
                 {
                     juridicoEnvio.pcFATCANC = 'S';
                 }
                else
                {
                    juridicoEnvio.pcFATCANC = 'N';
                }
                juridicoEnvio.pcprimernombre /*primerNombre*/ = pcprimernombre;
                juridicoEnvio.pcsegundonombre /*SegundoNombre*/ = pcsegundonombre;
                juridicoEnvio.pcsegundoapellido /*SegundoApellido*/ = pcsegundoapellido;
                juridicoEnvio.pcprimerapellido /*primerApellido*/ = pcprimerapellido;
                juridicoEnvio.pcTelefonoCN = pcTelefonoCN;
                juridicoEnvio.pcCelularCN /*Celular*/ = pcCelularCN;
                juridicoEnvio.pdfechanacimiento /*FechaNacimiento*/ = fechaNacimiento;
                juridicoEnvio.pdLugarNacimientoCN /*LugarNacimiento*/ = pdLugarNacimientoCN;
                juridicoEnvio.pcsexo /*Genero*/ = TipoSexo.Sexo__c;
                juridicoEnvio.pcestadocivil /*EstadoCivil*/ = pcestadocivil;
            	juridicoEnvio.pcNombreConyuge = pcNombreConyuge;
                juridicoEnvio.pcProfesionOcupacion = TipoProfesion.Profesi_n_Ocupaci_n__c;
    	        juridicoEnvio.pcmail /*Correo*/ = pcmail;
                juridicoEnvio.COD_REPRE_LEGAL=pcNumeroIDPV;
                if(pcAPNFDSI == true)
                 {
                     juridicoEnvio.pcAPNFD = 'S';
                 }
                else
                {
                    juridicoEnvio.pcAPNFD = 'N';
                }
            
                juridicoEnvio.PCNumeroAPNFD = PCNumeroAPNFD;
                juridicoEnvio.PC_NIVEL_RIESGO = PC_NIVEL_RIESGO;
                juridicoEnvio.PC_DEBIDA_DELIGENCIA = PC_DEBIDA_DELIGENCIA;
             
                    
                //Usted o un familia
                if(OcultaTerSI == true) {juridicoEnvio.pc_ActuaSI = 'S';
                }
                else
                {
                                  
                juridicoEnvio.pc_ActuaSI = 'N';
                
                }
            
                juridicoEnvio.pcNumeroIDPV=pcNumeroIDPV;
                juridicoEnvio.pcNombreCompletoPV=NombreRL;    
                
                if(pcDependeSI == true)
                 {
                     juridicoEnvio.pcDependeSI = 'S';
                 }
                else
                {
                    juridicoEnvio.pcDependeSI = 'N';
                }
            
               
                juridicoEnvio.pcTipoIDDependencia /*TipoID_DependenciaEconomica*/ = Cliente25.Tipo_Identificacion__c;
                juridicoEnvio.pcNumeroIDDependencia /*NumeroID_DependenciaEconomica */ = pcNumeroIDDependencia;
                //naturalEnvio.pcParentescoDependencia /*Parentesco_DependenciaEconomica*/ = Cuenta22.Parentesco__c;
                juridicoEnvio.pcNombreCompletoDependencia /*NombreCompleto_DependenciaEconomica*/ = pcNombreCompletoDependencia;
                
                //InfoDireccion
                juridicoEnvio.pccodpais /*Pais_Direccion*/ = pccodpais;
                juridicoEnvio.pcDeptoCN /*Depto_Direccion*/ = pcDeptoCN;
                juridicoEnvio.pcMunicipioCN /*Municipio_Direccion*/ = pcMunicipioCN;
                juridicoEnvio.pcColoniaCN /*Colonia_Direccion*/= pcColoniaCN;
                juridicoEnvio.pcCalleDetalleCN /*Calle_Direccion*/ = pcCalleDetalleCN;
                juridicoEnvio.pcnacionalidad /*Nacionalidad1_Direccion*/ = pcnacionalidad;
                juridicoEnvio.pcnacionalidad2 /*Nacionalidad2_Direccion*/ = pcnacionalidad2;
                juridicoEnvio.pcnacionalidad3 /*Nacionalidad3_Direccion*/ = pcnacionalidad3;
                
                //referencias
                juridicoEnvio.pcPrimerNombreReferi1 /*PrimerNombre_referencia*/ = pcPrimerNombreReferi1;
                juridicoEnvio.pcSegundoNombreReferi1 /*SegundoNombre_referencia*/ = pcSegundoNombreReferi1;
                juridicoEnvio.pcPrimerApellidoReferi1 /*PrimerApellido_referencia*/ = pcPrimerApellidoReferi1;
                juridicoEnvio.pcSegundoApellidoReferi1 /*SegundoApellido_referencia*/ = pcSegundoApellidoReferi1;
                juridicoEnvio.pcTelefono_Referido1Referi1 /*Telefono_referencia*/ = pcTelefono_Referido1Referi1;
                
                juridicoEnvio.pcPrimerNombreReferi2 /*PrimerNombre_referencia*/ = pcPrimerNombreReferi2;
                juridicoEnvio.pcSegundoNombreReferi2 /*SegundoNombre_referencia*/ = pcSegundoNombreReferi2;
                juridicoEnvio.pcPrimerApellidoReferi2 /*PrimerApellido_referencia*/ = pcPrimerApellidoReferi2;
                juridicoEnvio.pcSegundoApellidoReferi2 /*SegundoApellido_referencia*/ = pcSegundoApellidoReferi2;
                juridicoEnvio.pcTelefono_ReferidoReferi2 /*Telefono_referencia*/ = pcTelefono_ReferidoReferi2;
                
                //DatoEMpleador
                
                juridicoEnvio.pccontratocolectivo = pccontratocolectivo;
                juridicoEnvio.pcrncempl /*RTN*/ = pcrncempl;
                juridicoEnvio.pcTipoEmpresaEmpCN /*TipoEmpresa*/ = ClienteTipoId.Tipo_Empresa__c;
                juridicoEnvio.pcNombreempl = pcNombreempl;
                juridicoEnvio.pcrazonsocialempl /*RazonSocial*/ = pcrazonsocialempl;
                juridicoEnvio.pcCargoEmpresaEmpCN /*CargoEmpresa*/ = pcCargoEmpresaEmpCN;
                juridicoEnvio.pcGiroEmpresaEmpCN /*GiroEmpresa*/ = Cliente25.Sector__c;
                juridicoEnvio.pctelempl = pctelempl;
                juridicoEnvio.pcextempl = pcextempl;
                juridicoEnvio.pcmailempl = pcmailempl;
                
                //EMpleadorDIreccion
                
                //naturalEnvio.pcPaisEmpleadorCN = pcPaisEmpleadorCN;
                juridicoEnvio.pcDeptoEmpleadorCN = pcDeptoEmpleadorCN;
                juridicoEnvio.pcMunicipioEmpleadorCN = pcMunicipioEmpleadorCN;
                juridicoEnvio.pcColoniaEmpleadorCN = pcColoniaEmpleadorCN;
                juridicoEnvio.pcdirempl = pcdirempl;
                
                
                //DatoEmpleado
                
                juridicoEnvio.pcTIpoEmpleado /*TipoEmpleado*/ = Cliente25.Tipo_trabajador__c;
                juridicoEnvio.pdfechainiciolabor = fechaLabor;
                juridicoEnvio.pcNivelIngreso /*NivelIngreso*/ = llenarNivelIngreso1;
                
            	//DatoEmpleado
                juridicoEnvio.pcUsuarioCN /*usuarioValidacion*/ = pcUsuarioCN;
                juridicoEnvio.pcFechaValidacionCN /*FechaValidacion*/ = date.today();
                
                //PantallaProducto
                
                juridicoEnvio.pcproducto /*Producto*/ = pcproducto;
                juridicoEnvio.pcsubproducto /*Subproducto*/ = pcsubproducto;
                 
                juridicoEnvio.pcTipoFondo /*TipoFondo*/ = pcTipoFondo; //cambio aqui
                juridicoEnvio.pcTipoMoneda /*TipoMoneda*/ = TipMoneda.Tipo_Moneda__c;
                juridicoEnvio.pcperiodicidad /*Periodicidad*/ = Cuenta20.Frecuencia_Aportacion__c;
                juridicoEnvio.pcformapago /*FormaPago*/ = pcformapago;
                juridicoEnvio.pcDiaAportacion /*DiaAportacion*/ = DiaMes.Dias_Mes__c;
                juridicoEnvio.pnmontoaporte /*MontoAporte*/ = pnmontoaporte;
                juridicoEnvio.pccuentapago /*CuentaCTA*/ = pccuentapago;
                juridicoEnvio.pcSalarioP /*salario*/ = pcSalarioP;
                juridicoEnvio.pcAportacionEmpleadoP /*AporEmpleado*/ = pcAportacionEmpleadoP;
                juridicoEnvio.pcAportacionTrabajoP /*AporTrabajo*/ = pcAportacionTrabajoP;
				juridicoEnvio.pcPrimaAsegurada /*PrimaSeguro*/ = pcPrimaAsegurada;
                juridicoEnvio.pcSumaAsegurada /*MontoSeguro*/ = pcSumaAsegurada;
                juridicoEnvio.pcNUMUSU /*Numusu*/ = pcNUMUSU;
                juridicoEnvio.pcenvio /*EnvioCorreo*/ = TipoEnvioo.Tipo_EnvioNuevo__c;
                juridicoEnvio.pcTipoAporte /*TipoAporte*/ = 'F';
                juridicoEnvio.v_des_procedfds/*OrigenFondos*/   = v_des_procedfds;

            	/////////////////////////////////////
                juridicoEnvio.pcpromotor /*promotorProducto*/ = pcpromotor; //Cliente25.Asesor__c;            	
                juridicoEnvio.pctiposolicitud = pctiposolicitud;
            
                if(OTROS_OBLIGSI == true)
                 {
                     juridicoEnvio.OTROS_OBLIG = 'S';
                 }
                else
                {
                    juridicoEnvio.OTROS_OBLIG = 'N';
                }
            
            
                         juridicoenvio.PAIS1= PAIS1;
            			 juridicoenvio.PAIS2=PAIS2;
                         juridicoenvio.PAIS3= PAIS3;
            			 juridicoenvio.DEPTO1= DEPTO1;
            			 juridicoenvio.DEPTO2= DEPTO2;
            			 juridicoenvio.DEPTO3= DEPTO3;
            			 juridicoenvio.COD_CTE_FIR1= COD_CTE_FIR1;
            			 juridicoenvio.COD_CTE_FIR2= COD_CTE_FIR2;
            			 juridicoenvio.COD_CTE_FIR3= COD_CTE_FIR3;
            			 juridicoenvio.NUM_ID_CONTR_SOCI= NUM_ID_CONTR_SOCI;
            			 juridicoenvio.NOMBRE_CONTR_SOC= NOMBRE_CONTR_SOC;
            			 juridicoenvio.REF1_PROVE_NOMB= REF1_PROVE_NOMB;
            			 juridicoenvio.REF1_PROVE_PRODUC= REF1_PROVE_PRODUC;
            			 juridicoenvio.REF1_PROVE_TEL= REF1_PROVE_TEL;
            			 juridicoenvio.REF2_PROVE_NOMB= REF2_PROVE_NOMB;
            			 juridicoenvio.REF2_PROVE_PRODUC= REF2_PROVE_PRODUC;
            			 juridicoenvio.REF2_PROVE_TEL= REF2_PROVE_TEL;
            			 juridicoenvio.REF1_BANCA_NOMB= REF1_BANCA_NOMB;
            			 juridicoenvio.REF1_BANCA_TEL= REF1_BANCA_TEL;
            			 juridicoenvio.REF2_BANCA_NOMB= REF2_BANCA_NOMB;
            			 juridicoenvio.REF2_BANCA_TEL= REF2_BANCA_TEL;
                         juridicoenvio.NUM_TOT_EMPLEADOS= NUM_TOT_EMPLEADOS;
            			 juridicoenvio.PAIS_CONSEMP= PAIS_CONSEMP;
            			 juridicoenvio.FECINSCR_CONSEMP= FECINSCR_CONSEMP;
            			 juridicoenvio.NUM_ACCIONISTAS= NUM_ACCIONISTAS;
            			 juridicoenvio.AMPLIAR_ACT_ECONOMICA= AMPLIAR_ACT_ECONOMICA;
            			 juridicoenvio.MTO_APROX_ACTIVO= MTO_APROX_ACTIVO;
            			 juridicoenvio.COD_ACTIVIDAD= COD_ACTIVIDAD;
            			 juridicoenvio.FECHA_CONSTITUCION= FECHA_CONSTITUCION;
            			 juridicoenvio.COD_REPRE_LEGAL= COD_REPRE_LEGAL;
            			 juridicoenvio.DIR_CORRESPONDENCIA= DIR_CORRESPONDENCIA;
            			 juridicoenvio.GIIN= GIIN;
            			 if(ENTIDADSI == true)
                         {
                             juridicoEnvio.ENTIDAD_FINANCIERA = 'EN';
                         }
                        else IF (ENTIDADNO == true) 
                        {
                            juridicoEnvio.ENTIDAD_FINANCIERA = 'IF';
                            }ELSE{
                            juridicoEnvio.ENTIDAD_FINANCIERA = NULL;    
                        }
          				if(ACC_10DE_CONTROLSI == true)
                         {
                             juridicoEnvio.ACC_10DE_CONTROL = 'S';
                         }
                        else IF (OcultarACC_10DE_CONTROLNO == true) {
                            juridicoEnvio.ACC_10DE_CONTROL = 'N';
                            }ELSE{
                            juridicoEnvio.ACC_10DE_CONTROL = NULL;    
                        }
            
            			if(Fatca1 == true)
                         {
                             juridicoEnvio.INST_FINANCIERA = '1';
                         }
                        else IF (Fatca2 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '2';
                            }
                        else IF (Fatca3 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '3';
                            }
                        else IF (Fatca4 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '4';
                            }
                        else IF (Fatca6 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '6';
                            }
                        else IF (Fatca7 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '7';
                            }
                        else IF (Fatca8 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '8';
                            }
                        else IF (Fatca9 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '9';
                            }
                        else IF (Fatca11 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '11';
                            }
                        else IF (Fatca12 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '12';
                            }
                        else IF (Fatca13 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '13';
                            }
                        else IF (Fatca14 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '14';
                            }
                        else IF (Fatca15 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '15';
                            }
                        else IF (Fatca16 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '16';
                            }
                        else IF (Fatca17 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '17';
                            }ELSE {
                            
                            juridicoEnvio.INST_FINANCIERA = NULL;
                        }
            			 juridicoenvio.INST_FINANCIERA= INST_FINANCIERA;
                          juridicoenvio.TIP_ENTIDAD= pcListEntidad;
            			if(ACTIVA == true) { 
                            juridicoEnvio.ACTIV_PASIVO = 'A';
                         }
                        else IF (PASIVA == true)
                        {
                            juridicoEnvio.ACTIV_PASIVO = 'P';
                            }ELSE{
                            juridicoEnvio.ACTIV_PASIVO = NULL;    
                        }
            			 

                if(ES_Residente == true)
                 {
                    juridicoEnvio.ES_Residente = 'S' ;
                 }
                else
                {
                    juridicoEnvio.ES_Residente = 'N';
                }
            
                 if(ES_Residente_EfectosMi == true)
                 {
                    juridicoEnvio.ES_Residente_EfectosMi = 'S' ;
                 }
                else
                {
                    juridicoEnvio.ES_Residente_EfectosMi = 'N';
                }
            
               if (ListSociosTIN == null){
                juridicoEnvio.ListSociosTIN = null;
            }
            
             if (ListSocios == null){
                juridicoEnvio.ListSocios = null;
            }
            
            if (PaisResidenciaEfectosFiscales == '--Ninguno--'){juridicoEnvio.PaisResidenciaEfectosFiscales = 'null';
            }else{
                 juridicoEnvio.PaisResidenciaEfectosFiscales = PaisResidenciaEfectosFiscales;
            }
            
            juridicoEnvio.NumeroID_Fiscal_EEUU = NumeroID_Fiscal_EEUU;
             juridicoEnvio.NumeroID_Fiscal_OtroPais = NumeroID_Fiscal_OtroPais;
             juridicoEnvio.ListSocios = ListSocios;
             juridicoEnvio.ListSociosTIN = ListSociosTIN;
             juridicoEnvio.ListPropiedadControl = ListPropiedadControl;
                //Agregado 10-04-2019
             juridicoEnvio.ListClienteONG = ListClienteONG;
             juridicoEnvio.ListDebidaDil = ListDebidaDil;
            
            if(ValorEmpresaMercaSI == true){
                juridicoEnvio.ValorEmpresaMercaSI = 'S';
            }
            else{
                juridicoEnvio.ValorEmpresaMercaSI = 'N';
            }
            
            if(ValorPersonaUsaSI == true){
                juridicoEnvio.ValorPersonaUsaSI = 'S';
            }
            else{
                juridicoEnvio.ValorPersonaUsaSI = 'N';
            }
            //fin
            
           if (PCNumeroAPNFD == '--Ninguno--'){
                juridicoEnvio.PCNumeroAPNFD = 'null';
            }else{
                 juridicoEnvio.PCNumeroAPNFD = PCNumeroAPNFD;
            }
            
             if (socioUnico.NIVEL == '--Ninguno--'){ socioUnico.NIVEL= 'null';
            } 
            
            if (socioUnico.nacionalidad == '--Ninguno--')
            { 
                socioUnico.nacionalidad = 'null';       } 
                
             if( TipoEnvioo.Tipo_EnvioNuevo__c == '' ||  TipoEnvioo.Tipo_EnvioNuevo__c == ' --Ninguno-- ' || TipoEnvioo.Tipo_EnvioNuevo__c == null )
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Envío Vacio'));
            return null;    
            }else{
                juridicoEnvio.pcenvio = TipoEnvioo.Tipo_EnvioNuevo__c;
            }
            juridicoEnvio.pcenvio = TipoEnvioo.Tipo_EnvioNuevo__c;
            if (TipoAport.Tipo_Aporte__c == '--Ninguno--')
            { juridicoEnvio.pcTipoAporte= 'null';
            } else{
                juridicoEnvio.pcTipoAporte=TipoAport.Tipo_Aporte__c;
            }
                
             if (DiaMes.Dias_Mes__c == '--Ninguno--')
             { juridicoEnvio.pcDiaAportacion= 'null';
              } else{
                  juridicoEnvio.pcDiaAportacion=DiaMes.Dias_Mes__c;
              }
                  
                            
            if (Cliente25.Sector__c == '--Ninguno--')
            { juridicoEnvio.pcGiroEmpresaEmpCN = 'null';
            } 

                
             if (PAIS_CONSEMP == '--Ninguno--'){ juridicoenvio.PAIS_CONSEMP= 'null';
            }  

            if (DEPTO1 == '--Ninguno--'){ juridicoenvio.DEPTO1= 'null';
             }else{
                   juridicoEnvio.DEPTO1=DEPTO1;
             }  
            
            if (DEPTO2 == '--Ninguno--'){ juridicoenvio.DEPTO2= 'null';
             }else{
                   juridicoEnvio.DEPTO2=DEPTO2;
             }
            
            if (PAIS1 == '--Ninguno--'){ juridicoenvio.PAIS1= 'null';
            }else{
                juridicoEnvio.PAIS1=PAIS1;
            }   
            
            if (pcColoniaCN == '--Ninguno--'){
                juridicoEnvio.pcColoniaCN= 'null';
            }else{
               juridicoEnvio.pcColoniaCN=pcColoniaCN;  
            }
                
            if (pcMunicipioCN == '--Ninguno--')
            { juridicoEnvio.pcMunicipioCN= 'null';
            }
                
            if (pcDeptoCN == '--Ninguno--'){ juridicoEnvio.pcDeptoCN = 'null';
            }
                
             if (pccodpais == '--Ninguno--'){  juridicoEnvio.pccodpais = 'null';
            }
            
            if (pcListEntidad == ' --Ninguno-- '){ juridicoenvio.TIP_ENTIDAD= 'null';
            }else{
              juridicoEnvio.TIP_ENTIDAD= pcListEntidad;  
            }
                
            if (TIP_ENTIDAD == ' --Ninguno-- '){ juridicoEnvio.TIP_ENTIDAD= 'null'; 
            }else{
                juridicoEnvio.TIP_ENTIDAD=Cliente25.TIPO_ENTIDAD_FATCA__c;
            }
            
            if (PaisResidenciaEfectosFiscales == ' --Ninguno-- '){
                juridicoEnvio.PaisResidenciaEfectosFiscales = 'null';
            }else{
                juridicoEnvio.PaisResidenciaEfectosFiscales = PaisResidenciaEfectosFiscales;
            }
            
            if (Activo == '--Ninguno--'){ juridicoEnvio.pcEst_Cuenta = 'null';}else{ juridicoEnvio.pcEst_Cuenta = Activo;
            }
            
            if (Causa == '--Ninguno--'){ juridicoEnvio.pcCod_Causa = 'null';}else{juridicoEnvio.pcCod_Causa = Causa;
            }
            
            if( PAIS3 == ''||PAIS3 ==' --Ninguno-- ' ){ juridicoEnvio.PAIS3= 'null';  
            }else{
                juridicoEnvio.PAIS3=PAIS3;
            }
            

            if( DEPTO3 == ''||DEPTO3 ==' --Ninguno-- '){juridicoEnvio.DEPTO3= 'null';  
            }
            
            if( pcproducto == '' || pcproducto =='--Ninguno--') {  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Producto  Vacio'));  return null;    
            }
            
            if( MTO_APROX_ACTIVO == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Monto Aprox. Activo Vacio'));
            return null;    
            }
            
            
               if( pcsubproducto == '' || pcsubproducto =='--Ninguno--')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Subproducto  Vacio'));
            return null;    
            }
            
             if( pcTipoMoneda == '' || pcTipoMoneda =='--Ninguno--'  )
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Moneda Vacio'));
            return null;    
            }
            
             if( Cuenta20.Frecuencia_Aportacion__c == '' ||  Cuenta20.Frecuencia_Aportacion__c == ' --Ninguno-- ')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Periodicidad Vacio'));
            return null;    
            }
            
            if( pcpromotor == '' ||  pcpromotor == '--Ninguno--')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Oficial de Negocio Vacio'));
            return null;    
            }
            
             if( pcTipoFondo == '' ||  pcTipoFondo == '--Ninguno--')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tipo de Fondo Vacio'));
            return null;    
            }
            
            if( pcformapago == '' ||  pcformapago == ' --Ninguno-- ')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Forma de Pago Vacio'));
            return null;    
            }
            
            if( v_des_procedfds == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Procedencia de Fondos Vacio'));
            return null;    
            }
			else
             { 
               
              String resultado = APIClienteJuridico.guardarCliJuridico(juridicoEnvio);
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));
              disbot = false;
               
             }  
               
           
      } 
      catch(Exception e)
    	{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
     	}
       return null;   
     } 
    
    
    public pageReference actualizar(){
        try{
              ClassPantJuridicoProduc juridicoEnvio = new ClassPantJuridicoProduc();
                JuridicoEnvio.V_fo_cuenta = CuentaMostrar; 
            	JuridicoEnvio.numtran = numtran;//Agregado 11/05/2020
            	
            	if(pcPEP == true)
                     {
                         juridicoEnvio.pcPEP = 'S';
                     }
                    else
                    {
                        juridicoEnvio.pcPEP = 'N';
                    }
                    
                    if(pcFATCA == true)
                     {
                         juridicoEnvio.pcFATCA = 'S';
                     }
                    else
                    {
                        juridicoEnvio.pcFATCA = 'N';
                    } 
            	if(pcFATCANC == true)
                 {
                     juridicoEnvio.pcFATCANC = 'S';
                 }
                else
                {
                    juridicoEnvio.pcFATCANC = 'N';
                }
            	JuridicoEnvio.pcrazonsocialempl /*Cod_Agencia*/ = pcrazonsocialempl;
                juridicoEnvio.pcNombreempl /*Cod_Agencia*/ = pcNombreempl;
            
                juridicoEnvio.pctipoid /*TipoID*/= pctipoid;   
                juridicoEnvio.pcnroid /*NumeroID*/= pcnroid;
                juridicoEnvio.pcNombreCompletoPV=NombreRL;
                          
               if(pcAPNFDSI == true)
                 {
                     juridicoEnvio.pcAPNFD = 'S';
                 }
                else
                {
                    juridicoEnvio.pcAPNFD = 'N';
                }
                 if(pcDependeSI == true)
                     {
                         juridicoEnvio.pcDependeSI = 'S';
                     }
                    else
                    {
                        juridicoEnvio.pcDependeSI = 'N';
                    }
             
            if(ENTIDADSI == true)
                 {
                     juridicoEnvio.ENTIDAD_FINANCIERA = 'EN';
                 }
                else
                {
                    juridicoEnvio.ENTIDAD_FINANCIERA = 'IF';
                }
            
                if(ACC_10DE_CONTROLSI == true)
                         {
                             juridicoEnvio.ACC_10DE_CONTROL = 'S';
                         }
                        else IF (OcultarACC_10DE_CONTROLNO == true)
                        {
                            juridicoEnvio.ACC_10DE_CONTROL = 'N';
                            }ELSE{
                            juridicoEnvio.ACC_10DE_CONTROL = NULL;    
                        }
                juridicoEnvio.pcNombreCompletoDependencia /*NombreCompleto_DependenciaEconomica*/ = pcNombreCompletoDependencia;
            
                juridicoEnvio.PCNumeroAPNFD = PCNumeroAPNFD;
                juridicoEnvio.PC_NIVEL_RIESGO = PC_NIVEL_RIESGO;
                juridicoEnvio.PC_DEBIDA_DELIGENCIA = PC_DEBIDA_DELIGENCIA;
            	juridicoEnvio.NUM_TOT_EMPLEADOS = NUM_TOT_EMPLEADOS;
            	juridicoEnvio.MTO_APROX_ACTIVO = MTO_APROX_ACTIVO;
            juridicoEnvio.v_des_procedfds=v_des_procedfds;
            
            juridicoEnvio.pccodpais=pccodpais;
            juridicoEnvio.pcDeptoCN=pcDeptoCN;
            juridicoEnvio.pcMunicipioCN=pcMunicipioCN;
            juridicoEnvio.pcColoniaCN=pcColoniaCN;
            juridicoEnvio.pcCalleDetalleCN=pcCalleDetalleCN;
            juridicoEnvio.pccuentapago=pccuentapago;
                juridicoEnvio.pcmail /*Correo*/ = pcmail;
				juridicoEnvio.pcTelefonoCN = pcTelefonoCN;
            	 if(OTROS_OBLIGSI == true)
                 {
                     juridicoEnvio.OTROS_OBLIG = 'S';
                 }
                else
                {
                    juridicoEnvio.OTROS_OBLIG = 'N';
                }
           
            juridicoEnvio.PAIS1=PAIS1;
            juridicoEnvio.PAIS2=PAIS2;
            juridicoEnvio.DEPTO1=DEPTO1;
            juridicoEnvio.DEPTO2=DEPTO2;
            juridicoEnvio.DEPTO3=DEPTO3;
            juridicoEnvio.COD_CTE_FIR1=COD_CTE_FIR1;
            juridicoEnvio.COD_CTE_FIR2=COD_CTE_FIR2;
            juridicoEnvio.COD_CTE_FIR3=COD_CTE_FIR3;
            juridicoEnvio.NUM_ID_CONTR_SOCI= NUM_ID_CONTR_SOCI;
            juridicoEnvio.NOMBRE_CONTR_SOC=NOMBRE_CONTR_SOC;
            juridicoEnvio.REF1_PROVE_NOMB=REF1_PROVE_NOMB;
            juridicoEnvio.REF1_PROVE_PRODUC=REF1_PROVE_PRODUC;
            juridicoEnvio.REF1_PROVE_TEL=REF1_PROVE_TEL;
            juridicoEnvio.REF2_PROVE_NOMB=REF2_PROVE_NOMB;
            juridicoEnvio.REF2_PROVE_PRODUC=REF2_PROVE_PRODUC;
            juridicoEnvio.REF2_PROVE_TEL=REF2_PROVE_TEL;
            juridicoEnvio.REF1_BANCA_NOMB=REF1_BANCA_NOMB;
            juridicoEnvio.REF1_BANCA_TEL=REF1_BANCA_TEL;
            juridicoEnvio.REF2_BANCA_NOMB=REF2_BANCA_NOMB;
            juridicoEnvio.REF2_BANCA_TEL=REF2_BANCA_TEL;
            juridicoEnvio.pcNivelIngreso=llenarNivelIngreso1;
            
                       juridicoEnvio.PAIS_CONSEMP= PAIS_CONSEMP;
                       juridicoEnvio.FECHA_CONSTITUCION=FECHA_CONSTITUCION;
                       juridicoEnvio.NUM_ACCIONISTAS=NUM_ACCIONISTAS;
                       juridicoEnvio.AMPLIAR_ACT_ECONOMICA=AMPLIAR_ACT_ECONOMICA;
                       juridicoEnvio.NumeroID_Fiscal_OtroPais= NumeroID_Fiscal_OtroPais;
                       juridicoEnvio.DIR_CORRESPONDENCIA=DIR_CORRESPONDENCIA;
                       juridicoEnvio.pcNumeroIDPV=pcNumeroIDPV;
                       juridicoEnvio.pcNombreCompletoPV=pcNombreCompletoPV;
                       
            			//Agregado 10-04-2019*********************************
            
            if(ListDebidaDil.size() > 0){
                juridicoEnvio.ListDebidaDil = ListDebidaDil;
            }
            
            if(ListClienteONG.size() > 0){
                juridicoEnvio.ListClienteONG = ListClienteONG;
            }
            
            if(ValorEmpresaMercaSI == true){
                juridicoEnvio.ValorEmpresaMercaSI = 'S';
            }
            else{
                juridicoEnvio.ValorEmpresaMercaSI = 'N';
            }
            
            if(ValorPersonaUsaSI == true){
                juridicoEnvio.ValorPersonaUsaSI = 'S';
            }
            else{
                juridicoEnvio.ValorPersonaUsaSI = 'N';
            }
            //fin
            			if (ListSocios.size() > 0)
                        {
                            juridicoEnvio.ListSocios = ListSocios;
                        }
            
            			if (ListSociosTIN.size() > 0)
                        {
                            juridicoEnvio.ListSociosTIN = ListSociosTIN;
                        }
            			if (ListPropiedadControl.size() > 0)
                        {
                            juridicoEnvio.ListPropiedadControl = ListPropiedadControl;
                        }
                        juridicoEnvio.GIIN= GIIN;
                         if(ENTIDADSI == true)
                         {
                             juridicoEnvio.ENTIDAD_FINANCIERA = 'EN';
                         }
                        else IF (ENTIDADNO == true)
                        {
                            juridicoEnvio.ENTIDAD_FINANCIERA = 'IF';
                            }ELSE{
                            juridicoEnvio.ENTIDAD_FINANCIERA = NULL;    
                        }
          				if(ACC_10DE_CONTROLSI == true)
                         {
                             juridicoEnvio.ACC_10DE_CONTROL = 'S';
                         }
                        else IF (OcultarACC_10DE_CONTROLNO == true)
                        {
                            juridicoEnvio.ACC_10DE_CONTROL = 'N';
                            }ELSE{
                            juridicoEnvio.ACC_10DE_CONTROL = NULL;    
                        }
            
            			if(Fatca1 == true)
                         {
                             juridicoEnvio.INST_FINANCIERA = '1';
                         }
                        else IF (Fatca2 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '2';
                            }
                        else IF (Fatca3 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '3';
                            }
                        else IF (Fatca4 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '4';
                            }
                        else IF (Fatca6 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '6';
                            }
                        else IF (Fatca7 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '7';
                            }
                        else IF (Fatca8 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '8';
                            }
                        else IF (Fatca9 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '9';
                            }
                        else IF (Fatca11 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '11';
                            }
                        else IF (Fatca12 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '12';
                            }
                        else IF (Fatca13 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '13';
                            }
                        else IF (Fatca14 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '14';
                            }
                        else IF (Fatca15 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '15';
                            }
                        else IF (Fatca16 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '16';
                            }
                        else IF (Fatca17 == true)
                        {
                            juridicoEnvio.INST_FINANCIERA = '17';
                            }ELSE {
                            
                            juridicoEnvio.INST_FINANCIERA = NULL;
                        }
            
                         juridicoEnvio.INST_FINANCIERA=INST_FINANCIERA;
                         juridicoEnvio.TIP_ENTIDAD=Cliente25.TIPO_ENTIDAD_FATCA__c;
            			 if(ACTIVA == true)
                         {
                             juridicoEnvio.ACTIV_PASIVO = 'A';
                         }
                        else IF (PASIVA == true)
                        {
                            juridicoEnvio.ACTIV_PASIVO = 'P';
                            }ELSE{
                            juridicoEnvio.ACTIV_PASIVO = NULL;    
                        }
           
            juridicoEnvio.COD_REPRE_LEGAL=pcNumeroIDPV;
            juridicoEnvio.COD_ACTIVIDAD=Cliente25.Sector__c;
            juridicoEnvio.pcproducto = pcproducto;
        juridicoEnvio.pcsubproducto = pcsubproducto;
        juridicoEnvio.pcTipoFondo = pcTipoFondo;
        juridicoEnvio.pcTipoMoneda = TipMoneda.Tipo_Moneda__c;
        juridicoEnvio.pcperiodicidad = Cuenta20.Frecuencia_Aportacion__c;
        juridicoEnvio.pcformapago = pcformapago;
        juridicoEnvio.pnmontoaporte = pnmontoaporte;
        juridicoEnvio.pcpromotor=pcpromotor;
            juridicoEnvio.pcUsuarioCN=pcUsuarioCN;
            juridicoEnvio.pcAportacionTrabajoP=pcAportacionTrabajoP;
            juridicoEnvio.pcAportacionEmpleadoP=pcAportacionEmpleadoP;
            juridicoEnvio.pcFechaValidacionCN = fechaValida;
        juridicoEnvio.pc_codCuenta = MostrarCUENTT;
           disbot = true;
             if( pcproducto == '' || pcproducto == ' --Ninguno-- ')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Producto  Vacio'));
            return null;    
            }
            
            if( pcsubproducto == '' || pcsubproducto == ' --Ninguno-- ')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Subproducto  Vacio'));
            return null;    
            }
            
             if( pcTipoMoneda == '' || pcTipoMoneda =='--Ninguno--'  )
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Moneda Vacio'));
            return null;    
            }
            
            if( Cuenta20.Frecuencia_Aportacion__c == '' ||  Cuenta20.Frecuencia_Aportacion__c == ' --Ninguno-- ' || Cuenta20.Frecuencia_Aportacion__c == null )
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Periodicidad Vacio'));
            return null;    
            }

            if(  pcpromotor == ''||  pcpromotor == ' --Ninguno-- ')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Oficial de Negocio Vacio'));
            return null;    
            }
            
             if( pcTipoFondo == '' ||  pcTipoFondo == '--Ninguno--' || pcTipoFondo == null )
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tipo de Fondo Vacio'));
            return null;    
            }
            
            if( pcformapago == '' ||  pcformapago == '  --Ninguno--  ' || pcformapago == null )
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Forma de Pago Vacio'));
            return null;    
            }
            
            if( v_des_procedfds == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Procedencia de Fondos Vacio'));
            return null;    
            }  
          	
            if (TipoEnvioo.Tipo_EnvioNuevo__c == '--Ninguno--'){
                juridicoEnvio.pcenvio= 'null';
            }else{
                juridicoEnvio.pcenvio = TipoEnvioo.Tipo_EnvioNuevo__c;
            } 
             
              
            if (TipoAport.Tipo_Aporte__c == '--Ninguno--'){
               juridicoEnvio.pcTipoAporte= 'null';
            } else{
                juridicoEnvio.pcTipoAporte=TipoAport.Tipo_Aporte__c;
            }
                
              if (DiaMes.Dias_Mes__c == '--Ninguno--'){
               juridicoEnvio.pcDiaAportacion= 'null';
              } else{
                  juridicoEnvio.pcDiaAportacion=DiaMes.Dias_Mes__c;
              }
            
            if (PCNumeroAPNFD == ' --Ninguno-- '){
                juridicoEnvio.PCNumeroAPNFD = 'null';
            }else{
                 juridicoEnvio.PCNumeroAPNFD = PCNumeroAPNFD;
            }         
            
            if (pcListEntidad == ' --Ninguno-- '){
                juridicoenvio.TIP_ENTIDAD= 'null';
            }else{
              juridicoEnvio.TIP_ENTIDAD= pcListEntidad;  
            }
            
            if (PaisResidenciaEfectosFiscales == ' --Ninguno-- '){
                juridicoEnvio.PaisResidenciaEfectosFiscales = 'null';
            }else{
                juridicoEnvio.PaisResidenciaEfectosFiscales = PaisResidenciaEfectosFiscales;
            }
            
             if (Activo == ' --Ninguno-- '){
                juridicoEnvio.pcEst_Cuenta = null;
            }else{
                juridicoEnvio.pcEst_Cuenta = Activo;
            }
            
            if (Causa == ' --Ninguno-- '){
                juridicoEnvio.pcCod_Causa = null;
            }else{
                juridicoEnvio.pcCod_Causa = Causa;
            }
            
            if( PAIS3 == ''||PAIS3 ==' --Ninguno-- ' )
            {          
                 juridicoEnvio.PAIS3= 'null';  
            }else{
                juridicoEnvio.PAIS3=PAIS3;
            }
            
            if(DEPTO2 ==' --Ninguno-- ' )
            {          
                juridicoEnvio.DEPTO2= 'null';  
            }
            
            if( DEPTO3 == ''||DEPTO3 ==' --Ninguno-- ')
            {          
                 juridicoEnvio.DEPTO3= 'null';  
            }
         else
             { 
              String resultado = APIClienteJuridico.actualizaCliente(juridicoEnvio);
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado )); 
              system.debug('holaaaaaaaaa');

             }  
          
      } 
      catch(Exception e)
    	{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
     	}
       return null;
    }

    
    public void buscarColectiva(){
       try{
            
            string temporal = pccontratocolectivo;
            ClienteNaturales claseEnvio = new ClienteNaturales();
            ClienteNaturales fcsd = controllerApiClienteNatural.ConsultaColectiva(pccontratocolectivo);
         
           if(fcsd.pcrncempl != null)     {
            pccontratocolectivo =fcsd.pccontratocolectivo;
            pcrncempl = fcsd.pcrncempl;
            ClienteTipoId.Tipo_Empresa__c = fcsd.pcTipoEmpresaEmpCN; 
            pcNombreempl = fcsd.pcrazonsocialempl;
            pcrazonsocialempl = fcsd.pcrazonsocialempl;
            Cliente25.Sector__c = fcsd.pcGiroEmpresaEmpCN;   
            pctelempl =fcsd.pctelempl;
            pcmailempl = fcsd.pcmailempl;
            pcPaisEmpleadorCN = fcsd.pcPaisEmpleadorCN;
            pcDeptoEmpleadorCN = fcsd.pcDeptoEmpleadorCN;
            
            //TipoFondo    
           if (fcsd.pcTipoFondo != null)
             {
                pcTipoFondo = fcsd.pcTipoFondo;               
                BloqTiFondo = true ;
             }
            else 
              {
                 BloqTiFondo = false ; 
              }
          
                
            opcionDepartamentoEmpleado = new list <selectOption>();
            opcionDepartamentoEmpleado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Departamentos__c item:[select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: pcPaisEmpleadorCN and codigo_departamento__c =: fcsd.pcDeptoEmpleadorCN])
            {
                opcionDepartamentoEmpleado.add(new selectOption(item.codigo_departamento__c, item.Departamento__c));
            }   
                
            opcionMunicipioEmpleado = new list <selectOption>();
            opcionMunicipioEmpleado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Municipio__c item:[select nombre_municipio__c, codigo_municipio__c from Municipio__c where codigo_pais__c =: pcPaisEmpleadorCN 
                                    and codigo_departamento__c =: fcsd.pcDeptoEmpleadorCN and codigo_municipio__c =: fcsd.pcMunicipioEmpleadorCN])
            {
                opcionMunicipioEmpleado.add(new selectOption(item.codigo_municipio__c, item.nombre_municipio__c));
            }
            
        
           //pcDeptoEmpleadorCN = fcsd.pcDeptoEmpleadorCN;
            pcMunicipioEmpleadorCN = fcsd.pcMunicipioEmpleadorCN;
            opcionColoniaEmpleado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Colonias_U__c item:[select nombre_colonia__c, codigo_colonia__c from Colonias_U__c where codigo_pais__c =: pcPaisEmpleadorCN 
                                    and codigo_departamento__c =: fcsd.pcDeptoEmpleadorCN and codigo_municipio__c =: fcsd.pcMunicipioEmpleadorCN
                                    and codigo_colonia__c =: fcsd.pcColoniaEmpleadorCN])
            {
                opcionColoniaEmpleado.add(new selectOption(item.codigo_colonia__c, item.nombre_colonia__c));
            }
            pcColoniaEmpleadorCN =fcsd.pcColoniaEmpleadorCN;
            pcdirempl = fcsd.pcdirempl;

          	pccontratocolectivo = temporal;	
                
           }else{
           		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cuenta Colectiva No Encontrada'));	    
           }	
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    } 
    
 
     public string pcnumeroidsocc {get;set;}  
    
    
    public void buscarSocio(){
        try{
            classListas claseEnvio = new classListas();
            classListas fcsdListas = controllerApiClienteNatural.consultaListas(pcnumeroidsocc);
            
            if(pcnumeroidsocc ==''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Nro ID Vacio'));}
            else{
                system.debug(fcsdListas.FATCA);
                
                if(fcsdListas.PEP == true){
                    PEPSocio = fcsdListas.PEP;
                    PC_NIVEL_RIESGO = '3';
                    PC_DEBIDA_DELIGENCIA = '3';
                    muestraPopPEP = true;
                }
                if(fcsdListas.FATCA == true ){
                    FATCASocio = true;
                    muestraPopFATCA = true;
                }
                if(fcsdListas.FATCANC == true){
                    FATCANCSocio = true;   
                    muestraPopFATCANC = true;
                }
                if(fcsdListas.AML == true){
                    AMLSocio = true; 
                    actPop = true;
                }
                validadosSocios = false;
            }
            
            APIClienteJuridico.classBeneficiariosJuri fcsd = new APIClienteJuridico.classBeneficiariosJuri();
            fcsd = APIClienteJuridico.Consulta_Socio(pcnumeroidsocc);   
            system.debug('respuesta fcsd'+ fcsd);
            if(pcnumeroidsocc!= null)
            {
                socioUnico.nombresocio = fcsd.nombresocio;
                socioUnico.nacionalidad = fcsd.nacionalidad;
            }  
            else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'ID No Encontrada'));	    
            }
            if (socioUnicoTIN.PCNumeroID_TIN!= null)
            {
                socioUnicoTIN.pcNombreCompleto_TIN=socioUnicoTIN.pcNombreCompleto_TIN;
                socioUnicoTIN.PCNumeroID_TIN=socioUnicoTIN.PCTIN_TIN;
                socioUnicoTIN.pcDireccion_TIN=socioUnicoTIN.pcDireccion_TIN;
            }
            else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'ID No Encontrada'));
            }
            
            
            
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se encontró Cliente'));	   
        }
    } 
    
    
    public void buscarSociotn(){
       try{
           
           pcnumeroidsocc=socioUnicoTIN.PCNumeroID_TIN;
           APIClienteJuridico.classBeneficiariosJuri fcsd = new APIClienteJuridico.classBeneficiariosJuri();
           
           fcsd = APIClienteJuridico.Consulta_Socio(pcnumeroidsocc);   
           system.debug('respuesta fcsd'+ fcsd);
           
           if(pcnumeroidsocc!= null)
            {
                 socioUnicoTIN.pcNombreCompleto_TIN=socioUnicoTIN.pcNombreCompleto_TIN;
                 socioUnicoTIN.pcDireccion_TIN=socioUnicoTIN.pcDireccion_TIN;
                
           }else{
           		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'ID No Encontrada'));	    
           }	
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    }
    
    
     public void buscarFirmante(){
       try{
            APIClienteJuridico.firmantesJuri hhuj = new APIClienteJuridico.firmantesJuri();
           
           hhuj = APIClienteJuridico.Consulta_Firmante(NUMID_FIRMAN1);   
           system.debug('respuesta hhuj'+ hhuj);
           NOM_FIRMAN1= NULL;
           COD_CTE_FIR1= NULL;
           if(hhuj.NOMBRE != null)
            {
             if(hhuj.NOMBRE != 'null'){
            NOM_FIRMAN1=hhuj.NOMBRE;
            }
                
                if(hhuj.COD_PERSONA != 'null'){
           COD_CTE_FIR1= hhuj.COD_PERSONA;
            }
     
           }
           else{
           		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'ID No Encontrada'));	    
           }	
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    } 
    
    public void buscarFirmante2(){
       try{
            APIClienteJuridico.firmantesJuri hhuj = new APIClienteJuridico.firmantesJuri();
           
           hhuj = APIClienteJuridico.Consulta_Firmante(NUMID_FIRMAN2);   
           system.debug('respuesta hhuj'+ hhuj);
           
           NOM_FIRMAN2= NULL;
           COD_CTE_FIR2= NULL;
            if(hhuj.NOMBRE != null)
            {
             if(hhuj.NOMBRE != 'null'){
             NOM_FIRMAN2=hhuj.NOMBRE;
            }
                
                if(hhuj.COD_PERSONA != 'null'){
           COD_CTE_FIR2= hhuj.COD_PERSONA;
            }
           }
           else{
           		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'ID No Encontrada'));	    
           }	
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    } 
    
    
    public void buscarFirmante3(){
       try{
            APIClienteJuridico.firmantesJuri hhuj = new APIClienteJuridico.firmantesJuri();
           
           hhuj = APIClienteJuridico.Consulta_Firmante(NUMID_FIRMAN3);   
           system.debug('respuesta hhuj'+ hhuj);
           
           NOM_FIRMAN3= NULL;
           COD_CTE_FIR3= NULL;
           if(hhuj.NOMBRE != null)
            {
             if(hhuj.NOMBRE != 'null'){
             NOM_FIRMAN3=hhuj.NOMBRE;
            }
                
                if(hhuj.COD_PERSONA != 'null'){
           COD_CTE_FIR3= hhuj.COD_PERSONA;
            }
           }
           else{
           		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'ID No Encontrada'));	    
           }	
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    } 
    
    
    public void buscarRL(){
       try{
            APIClienteJuridico.firmantesJuri hhuj = new APIClienteJuridico.firmantesJuri();
           
           hhuj = APIClienteJuridico.Consulta_Firmante(pcNumeroIDPV);   
           system.debug('respuesta hhuj'+ hhuj);
           
           NombreRL= NULL;
           CargoRL= NULL;
           
           if(hhuj.NOMBRE != null)     {
             if(hhuj.NOMBRE != 'null'){
            NombreRL=hhuj.NOMBRE;      }
                
                if(hhuj.Cargo != 'null'){
            CargoRL= hhuj.Cargo ;
            }
                
           }
           else{
           		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'ID No Encontrada'));    
           }	
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    } 
    
    
    public boolean mostrarTablaModifi2 {get; set;}

    public void buscarInfoCuenta(){
       try{	
           limpiar();
            string temporal = pc_codCuenta;
        	ClassPantJuridicoProduc claseEnvio = new ClassPantJuridicoProduc();
        	ClassPantJuridicoProduc fcsd = APIClienteJuridico.ConsultaInfoCliente(MostrarCUENTT);

           btnagregar = true;
           bloqbtnpagina=true;
           bloqcausa=false;
           bloqestado=false;
           bloqcuenta=false;
           if (fcsd.pcrazonsocialempl != 'null' || fcsd.pcrazonsocialempl != null)
        	{
                CuentaMostrar = pc_codCuenta;
                if (fcsd.pnnrocertificado != 'null'){
                    pnnrocertificado = fcsd.pnnrocertificado;
                }
                
                if(fcsd.pdfechasuscripcion!=null) {
                    fcsd.pdfechasuscripcion = fcsd.pdfechasuscripcion.addHours(6);
                    fechasuscripcion=date.valueOf(fcsd.pdfechasuscripcion.year()+'-'+fcsd.pdfechasuscripcion.month()+'-'+fcsd.pdfechasuscripcion.day());
                }
                
                
                IF (fcsd.ACTIV_PASIVO =='A')
                {
                    ACTIVA = TRUE;
                    PASIVA    = FALSE;
                    OcultarPASIVA    = true;
                    OcultarACTIVA    = false;
 		            bloqeListEnti= true;
                }
               
                
                 IF (fcsd.ACTIV_PASIVO =='P')
                {
                    PASIVA = TRUE;
                    ACTIVA    = FALSE;
                    OcultarACTIVA    = true;
                    OcultarPASIVA    = false;
                    bloqeListEnti= false;
                }
                               
                
                 IF (fcsd.ACC_10DE_CONTROL =='S')
                {
                    ACC_10DE_CONTROLSI = TRUE;
                     ACC_10DE_CONTROLNO   = FALSE;
                     OcultarACC_10DE_CONTROLNO  = true;
                     OcultarACC_10DE_CONTROLSI  = false;
                        }
                               
                                
                
                 IF (fcsd.ENTIDAD_FINANCIERA =='EN') { ENTIDADSI = TRUE;
                }
                               
                   IF (fcsd.ENTIDAD_FINANCIERA =='IF')
                
                   {
                    ENTIDADNO = TRUE;
                }
               
                
                
                IF (fcsd.pcPEP =='S') { pcPEP = TRUE;
                }
                else 
                {
                    pcPEP = false;                     
                }  
                
                IF (fcsd.pcFATCA =='S'){ 
                    pcFATCA = TRUE;
                }
                else 
                {
                    pcFATCA = false;
                }    
                IF (fcsd.pcFATCANC =='S'){ 
                    pcFATCANC = TRUE;
                }
                else 
                {
                    pcFATCANC = false;
                }  
                 IF (fcsd.ACC_10DE_CONTROL =='N' && fcsd.pcFATCA =='S')
                {
                    ACC_10DE_CONTROLNO = TRUE;
                    ACC_10DE_CONTROLSI   = FALSE;
                    OcultarACC_10DE_CONTROLSI  = true;
                    OcultarACC_10DE_CONTROLNO  = false;
                      }
                
                if (fcsd.pcEst_cuenta!= 'null'){
                    if (fcsd.pcEst_cuenta == 'I' ){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente Inactivo'));
                        Activo = fcsd.pcEst_cuenta;
                    }
                    
                    Activo = fcsd.pcEst_cuenta;
                }
                
                /*Agregado 11/05/2020*/
                if(fcsd.numtran != 'null')
                {
                    numtran = fcsd.numtran;
                }
                
                TipoCausaOptions = new list <selectOption>();
                TipoCausaOptions.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                 for (Causa_Cuenta__c item:[select name, codigo__c from Causa_Cuenta__c where Estado_Cuenta__r.CodigoEstado__c =: Activo])
                  {
                     TipoCausaOptions.add(new selectOption(item.codigo__c, item.name));
                      }
                Causa = fcsd.pcCod_Causa;
                
                if (fcsd.PaisResidenciaEfectosFiscales != 'null'){
                   PaisResidenciaEfectosFiscales = fcsd.PaisResidenciaEfectosFiscales;  
                }
                
                if (fcsd.NumeroID_Fiscal_OtroPais != 'null'){
                   NumeroID_Fiscal_OtroPais = fcsd.NumeroID_Fiscal_OtroPais;  
                }
                
                 if (fcsd.DIR_CORRESPONDENCIA != 'null'){
                   DIR_CORRESPONDENCIA = fcsd.DIR_CORRESPONDENCIA;  
                }
                
                 if (fcsd.ENTIDAD_FINANCIERA != 'null'){
                   ENTIDAD_FINANCIERA = fcsd.ENTIDAD_FINANCIERA;  
                }
                
                if (fcsd.pctipoid != 'null'){
                   pctipoid = fcsd.pctipoid;  
                }
                if (fcsd.pcnroid != 'null'){
                   pcnroid = fcsd.pcnroid;  
                }
                       
                 if (fcsd.TIP_ENTIDAD != 'null'){
                  pcListEntidad= fcsd.TIP_ENTIDAD;  
                }
                
                if (fcsd.pcrazonsocialempl != 'null'){
                   pcrazonsocialempl = fcsd.pcrazonsocialempl;
                }
                
                if (fcsd.pcNombreempl != 'null'){
                   pcNombreempl = fcsd.pcNombreempl;
                }
                
                 IF (fcsd.pcAPNFD =='S') { pcAPNFDSI = TRUE;
                }
                else
                {
                    pcAPNFDNO = TRUE;
                    OcultarAPNFD = true;
                    pcAPNFDSI = false;
                    OcultarAPNFDNO = false;
                    PC_NIVEL_RIESGO = '2'; 
                    PC_DEBIDA_DELIGENCIA = '2'; 
                }
                
                if (fcsd.PCNumeroAPNFD != 'null')
                {
                  PCNumeroAPNFD = fcsd.PCNumeroAPNFD;
                }
                if (fcsd.PC_NIVEL_RIESGO != 'null')
                {
                    PC_NIVEL_RIESGO = fcsd.PC_NIVEL_RIESGO;
                       }
                
                if (fcsd.PC_DEBIDA_DELIGENCIA != 'null')
                {
                  PC_DEBIDA_DELIGENCIA = fcsd.PC_DEBIDA_DELIGENCIA;
                  
                }
                
                if (fcsd.NUM_TOT_EMPLEADOS != 'null')
                {
                  NUM_TOT_EMPLEADOS = fcsd.NUM_TOT_EMPLEADOS;
                }
                
                if (fcsd.MTO_APROX_ACTIVO != 'null')
                {
                  MTO_APROX_ACTIVO = fcsd.MTO_APROX_ACTIVO;
                }
                
                
                if (fcsd.pcNivelIngreso != 'null')
                {
                  pcNivelIngreso = fcsd.pcNivelIngreso;
                }
                
                
                /*nivel de ingreso*/
                IF (fcsd.OTROS_OBLIG =='S')
                {
                    OTROS_OBLIGSI = TRUE;
                     OTROS_OBLIGSI  = TRUE;
                     OTROS_OBLIGNO = FALSE;
                     OcultarOTROS_OBLIGNO = true;
                     OcultarOTROS_OBLIGSI = false;
                }
                else
                {
                    OTROS_OBLIGNO = True;
                    OTROS_OBLIGNO  = TRUE;
                    OTROS_OBLIGSI = FALSE;
                    OcultarOTROS_OBLIGSI = true;
                    OcultarOTROS_OBLIGNO = false;
                }
                
                if (fcsd.pccodpais != 'null')
                {
                  pccodpais = fcsd.pccodpais;
                }
                
                if (fcsd.pcTipoFondo != 'null')
                {
                  pcTipoFondo = fcsd.pcTipoFondo;
                }
                
                 if (fcsd.pcpromotor != 'null')
                {
                  pcpromotor = fcsd.pcpromotor;
                }
                
                opcionDepartamento = new list <selectOption>();
                opcionDepartamento.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Departamentos__c item:[select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: fcsd.pccodpais
                                           and codigo_departamento__c =: fcsd.pcDeptoCN])     {
                    opcionDepartamento.add(new selectOption(item.codigo_departamento__c, item.Departamento__c));
                }
                pcDeptoCN = fcsd.pcDeptoCN;
                opcionMunicipio = new list <selectOption>();
                opcionMunicipio.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Municipio__c item:[select nombre_municipio__c, codigo_municipio__c from Municipio__c where codigo_pais__c =: fcsd.pccodpais and codigo_departamento__c =: fcsd.pcDeptoCN
                                       AND codigo_municipio__c =: fcsd.pcMunicipioCN ])
                {
                    opcionMunicipio.add(new selectOption(item.codigo_municipio__c, item.nombre_municipio__c));
                }
                pcMunicipioCN = fcsd.pcMunicipioCN;
                opcionColonia = new list <selectOption>();
                opcionColonia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                if (fcsd.pcColoniaCN != null){
                    for (Colonias_U__c item:[select nombre_colonia__c, codigo_colonia__c from Colonias_U__c where codigo_pais__c =: fcsd.pccodpais and codigo_departamento__c =: fcsd.pcDeptoCN
                                       AND codigo_municipio__c =: fcsd.pcMunicipioCN and codigo_colonia__c =: fcsd.pcColoniaCN]) 
                    {
                        opcionColonia.add(new selectOption(item.codigo_colonia__c, item.nombre_colonia__c));
                    } 
                }
                if (fcsd.pcColoniaCN != 'null')
                {
                  pcColoniaCN = fcsd.pcColoniaCN;
                }
                if (fcsd.pcCalleDetalleCN != 'null')
                {
                  pcCalleDetalleCN = fcsd.pcCalleDetalleCN;
                }
                if (fcsd.PAIS1 != 'null')
                {
                  PAIS1 = fcsd.PAIS1;
                }
                if (fcsd.PAIS2 != 'null')
                {
                 PAIS2 = fcsd.PAIS2; Segun_pais = true; }else{ Segun_pais = false;         }
                
                if (fcsd.PAIS3 != null)
                {
                 PAIS3 = fcsd.PAIS3;
                }
                if (fcsd.DEPTO1 != 'null')
                {
                 DEPTO1 = fcsd.DEPTO1;
                }
                if (fcsd.DEPTO2 != 'null')
                {
                 DEPTO2 = fcsd.DEPTO2;
                    Segun_depto=true;}else{ Segun_depto=false;  }
                
                if (fcsd.DEPTO3 != null)
                {
                 DEPTO3 = fcsd.DEPTO3;
                }
                
                if (fcsd.NOM_REPRE_LEGAL != 'null'){
                    NombreRL=fcsd.NOM_REPRE_LEGAL;           
                }
                
                if (fcsd.pcmail != 'null')
                {
                    pcmail = fcsd.pcmail;
                }
                if (fcsd.pcTelefonoCN != 'null')
                {
                  pcTelefonoCN = fcsd.pcTelefonoCN;  
                }
                
                if (fcsd.COD_REPRE_LEGAL != 'null')
                {
                 pcNumeroIDPV = fcsd.COD_REPRE_LEGAL;
                }
                if (fcsd.NOM_REPRE_LEGAL != 'null')
                {
                 NombreRL = fcsd.NOM_REPRE_LEGAL;
                }
                if (fcsd.CARGO_REPRE_LEGAL != 'null')
                {
                 CargoRL = fcsd.CARGO_REPRE_LEGAL;
                }
                if (fcsd.NUMID_FIRMAN1 != 'null')
                {
                 NUMID_FIRMAN1 = fcsd.NUMID_FIRMAN1;
                }
                if (fcsd.COD_CTE_FIR1 != 'null')
                {
                 COD_CTE_FIR1 = fcsd.COD_CTE_FIR1;
                }
                if (fcsd.NOM_FIRMAN1 != 'null')
                {
                 NOM_FIRMAN1 = fcsd.NOM_FIRMAN1;
                }
                if (fcsd.NUMID_FIRMAN2 != 'null')
                {
                 NUMID_FIRMAN2 = fcsd.NUMID_FIRMAN2;
                }
                if (fcsd.COD_CTE_FIR2 != 'null')
                {
                 COD_CTE_FIR2 = fcsd.COD_CTE_FIR2;
                }
                if (fcsd.NOM_FIRMAN2 != 'null')
                {
                 NOM_FIRMAN2 = fcsd.NOM_FIRMAN2;
                }
                if (fcsd.NUMID_FIRMAN3 != 'null')
                {
                 NUMID_FIRMAN3 = fcsd.NUMID_FIRMAN3;
                }
                if (fcsd.COD_CTE_FIR3 != 'null')
                {
                 COD_CTE_FIR3 = fcsd.COD_CTE_FIR3;
                }
                if (fcsd.NOM_FIRMAN3 != 'null')
                {
                 NOM_FIRMAN3 = fcsd.NOM_FIRMAN3;
                }
                if (fcsd.NUM_ID_CONTR_SOCI != 'null')
                {
                 NUM_ID_CONTR_SOCI = fcsd.NUM_ID_CONTR_SOCI;
                }
                if (fcsd.NOMBRE_CONTR_SOC != 'null')
                {
                 NOMBRE_CONTR_SOC = fcsd.NOMBRE_CONTR_SOC;
                }
                
                
                
                IF (fcsd.pcDependeSI =='S')
                {
                    pcDependeSI = TRUE;
                    Dis_OcultarDependenciaSI = false;
                    Dis_OcultarDependenciaNO = true;
                    Dis_OcultarDependenciaCampos = false;
                    pcDependeNO = FALSE;
                }
                else
                {
                    pcDependeNO = true;
                    Dis_OcultarDependenciaSI = true;
                    Dis_OcultarDependenciaNO = false;
                    Dis_OcultarDependenciaCampos = false;
                    pcDependeSI = false;
                }
                
                if (fcsd.pcNombreCompletoDependencia != 'null')
                {
                 pcNombreCompletoDependencia = fcsd.pcNombreCompletoDependencia;
                }
                
                if (fcsd.REF1_PROVE_NOMB != 'null')
                {
                 REF1_PROVE_NOMB = fcsd.REF1_PROVE_NOMB;
                }
                if (fcsd.REF1_PROVE_PRODUC != 'null')
                {
                 REF1_PROVE_PRODUC = fcsd.REF1_PROVE_PRODUC;
                }
                if (fcsd.REF1_PROVE_TEL != 'null')
                {
                 REF1_PROVE_TEL = fcsd.REF1_PROVE_TEL;
                }
                if (fcsd.REF2_PROVE_NOMB != 'null')
                {
                 REF2_PROVE_NOMB = fcsd.REF2_PROVE_NOMB;
                }
                 
                if (fcsd.REF2_PROVE_PRODUC != 'null')
                {
                 REF2_PROVE_PRODUC = fcsd.REF2_PROVE_PRODUC;
                }
                if (fcsd.REF2_PROVE_TEL != 'null')
                {
                 REF2_PROVE_TEL = fcsd.REF2_PROVE_TEL;
                }
                if (fcsd.REF1_BANCA_NOMB != 'null')
                {
                 REF1_BANCA_NOMB = fcsd.REF1_BANCA_NOMB;
                }
                if (fcsd.REF1_BANCA_TEL != 'null')
                {
                 REF1_BANCA_TEL = fcsd.REF1_BANCA_TEL;
                }
                
                
                if (fcsd.REF2_BANCA_NOMB != 'null')
                {
                 REF2_BANCA_NOMB = fcsd.REF2_BANCA_NOMB;
                }
                
                if (fcsd.REF2_BANCA_TEL != 'null')
                {
                 REF2_BANCA_TEL = fcsd.REF2_BANCA_TEL;
                }
                
                if (fcsd.PAIS_CONSEMP != 'null')
                {
                 PAIS_CONSEMP = fcsd.PAIS_CONSEMP;
                }
                
                
                
                 if(fcsd.FECHA_CONSTITUCION!=null){ 
                     fcsd.FECHA_CONSTITUCION = fcsd.FECHA_CONSTITUCION.addHours(6);
                     FECHA_CONSTITUCION=date.valueOf(fcsd.FECHA_CONSTITUCION.year()+'-'+fcsd.FECHA_CONSTITUCION.month()+'-'+fcsd.FECHA_CONSTITUCION.day());
                }

                if (fcsd.NUM_ACCIONISTAS != 'null')
                {
                 NUM_ACCIONISTAS = fcsd.NUM_ACCIONISTAS;
                }
                if (fcsd.COD_ACTIVIDAD != 'null')
                {
                 Cliente25.Sector__c = fcsd.COD_ACTIVIDAD;
                }
                if (fcsd.AMPLIAR_ACT_ECONOMICA != 'null')
                {
                 AMPLIAR_ACT_ECONOMICA = fcsd.AMPLIAR_ACT_ECONOMICA;
                }
                
                
                if (fcsd.pcTipoAporte != 'null')
                {
                   TipoAport.Tipo_Aporte__c = fcsd.pcTipoAporte;
                }
                
                
                /*Pantalla Productos*/
                if (fcsd.pcproducto != 'null')
                {
                 pcproducto = fcsd.pcproducto;
                }
                
                opcionSubproducto = new list <selectOption>();
            	opcionSubproducto.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            	for (Subproducto__c item:[select name, codigo__c from Subproducto__c where producto__r.codigo__c =: fcsd.pcproducto])
            	{
                	opcionSubproducto.add(new selectOption(item.codigo__c, item.name));
            	}
                pcsubproducto = fcsd.pcsubproducto;
                
                if (fcsd.pcTipoFondo != 'null')
                {
                Cuenta20.Tipo_Fondo__c =pcTipoFondo; //fcsd.pcTipoFondo;
                }
                
                if (fcsd.pcTipoMoneda != 'null')
                {
                TipMoneda.Tipo_Moneda__c = fcsd.pcTipoMoneda;
                }
                if (fcsd.pcperiodicidad != 'null')
                {
                Cuenta20.Frecuencia_Aportacion__c = fcsd.pcperiodicidad;
                }
                if (fcsd.pcformapago != 'null')
                {
                   pcformapago = fcsd.pcformapago;
                }
                
                if (fcsd.pcDiaAportacion != 'null')
                {
                DiaMes.Dias_Mes__c = fcsd.pcDiaAportacion;
                }
                
                if (DiaMes.Dias_Mes__c=='null')
                {
                    
                }
                
                if (fcsd.pnmontoaporte != 'null'){pnmontoaporte = fcsd.pnmontoaporte;        }
               
                if (fcsd.pccuentapago != 'null')
                {
                     pccuentapago = fcsd.pccuentapago;
                }
               
                 if (fcsd.pcAportacionTrabajoP != 'null')
                {
                     pcAportacionTrabajoP = fcsd.pcAportacionTrabajoP;
                }
                
                if (fcsd.pcenvio != 'null')
                {
                TipoEnvioo.Tipo_EnvioNuevo__c = fcsd.pcenvio;
                }
                
                if (fcsd.pcAportacionEmpleadoP != 'null')
                {
                    pcAportacionEmpleadoP = fcsd.pcAportacionEmpleadoP;
                }
				
                if (fcsd.v_des_procedfds != 'null')
                {
                v_des_procedfds = fcsd.v_des_procedfds;
                }
                
                IF(fcsd.pcpromotor != Cliente25.Asesor__c){ Cliente25.Asesor__c = NULL;
                }
                
                if (fcsd.pcUsuarioCN != 'null')
                {
                     pcUsuarioCN = fcsd.pcUsuarioCN;
                }
                if(fcsd.pcFechaValidacionCN!=null) { 
                    fcsd.pcFechaValidacionCN = fcsd.pcFechaValidacionCN.addHours(6);
                    fechaValida=date.valueOf(fcsd.pcFechaValidacionCN.year()+'-'+fcsd.pcFechaValidacionCN.month()+'-'+fcsd.pcFechaValidacionCN.day());
                }
                //Agregado100042019
                ListDebidaDil = fcsd.ListDebidaDil;
                //MostrarActDili = true;
                ListClienteONG = fcsd.ListClienteONG;
               	activadesacContratista = true;
				activadesacONG = true;
                
                if (ListDebidaDil.size() == 0)
                {MostrarActDili = false;
                ValorContratistano = true;
                 OcultarSiContratista = true;
                
                }
                else{
                    MostrarActDili = true;
                    ValorContratistasi = true;
                    OcultarNoContratista = true;
                    OcultarSiContratista = true;
                    activadesacContratista = false;
                }
                
 				if (ListClienteONG.size() == 0)
                {MostrarActuaONG = false;
                	valornoONG = true;
                 OcultarONGSI = true;
                }else{
                     MostrarActuaONG = true;
                    valorsiONG = true;
                    OcultarONGSI = true;
                    OcultarONGNO = true;
                    activadesacONG = false;
                } 
				                
                if (fcsd.ValorEmpresaMercaSI == 'S'){
                    ValorEmpresaMercaSI = true;
                }
                if (fcsd.ValorPersonaUsaSI == 'S'){
                    ValorPersonaUsaSI = true;
                }
                //fin
                ListSocios = fcsd.ListSocios;
                ListSociosTIN=fcsd.ListSociosTIN; 
                ListPropiedadControl = fcsd.ListPropiedadControl;
                
                system.debug('Nuevo: '+fcsd.ListSocios);
                if (fcsd.ListSocios == null )
                { 
                    mostrarTabla = true;
                }else{
                    mostrarTablaModifi2 = true;
                }
                system.debug('mostrarTablaModifi2: '+mostrarTablaModifi2+'   mostrarTabla: '+mostrarTabla);
                SOCIO=FALSE;
                
                system.debug('Nuevo: '+fcsd.ListSociosTIN);
                if (fcsd.ListSociosTIN == null )
                { 
                    MostraTablaSociosTIN = true;
                }else{
                    mostrarTablaModificar = true;
                } 
                
                if (fcsd.ListPropiedadControl == null )
                { 
                    mostrarTablaControlantes = true;
                }else{
                    mostrarTablaModiControlantes = true;
                }
                system.debug('MostraTablaSociosTIN: '+MostraTablaSociosTIN+'   mostrarTablaModificar: '+mostrarTablaModificar);
                
                MostrarVentanaFATCA(); 
                bloqeListEnti= false;
                
               //pnmontoaporte = fcsd.pnmontoaporte;
                //pnmontoaporte12 = fcsd.pnmontoaporte12;
                //Muestra el boton de siguiente pantalla
                //mostrarBotonPan = true;
                mostrarSiguientePan = true;
                CuentaMostrar = MostrarCUENTT;
                
            }else{
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente No Encontrado'));	    
            }  
			salirCuenta(); }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage() + 'Linea: ' + e.getLineNumber());
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    }
    
    public void buscarInfoCuentaC(){
       try{	
           limpiar(); 
           string temporal = MostrarCUENTT;
            ClassPantJuridicoProduc claseEnvio = new ClassPantJuridicoProduc();
        	ClassPantJuridicoProduc fcsd = APIClienteJuridico.ConsultaInfoClienteC(MostrarCUENTT,NumIDBuscar);
          
        	system.debug('Respuestaaaaaaa: '+fcsd);
           mostrarBotonPan=false;
           bloqcausa=false;
           bloqestado=false;
           bloqcuenta=false;
           if (fcsd.pcrazonsocialempl != 'null')
        	{
                CuentaMostrar = MostrarCUENTT;
                pcnroid=NumIDBuscar;
                
                if (fcsd.pnnrocertificado != 'null'){
                    pnnrocertificado = fcsd.pnnrocertificado;
                }
                
                if(fcsd.pdfechasuscripcion!=null){ 
                    fcsd.pdfechasuscripcion = fcsd.pdfechasuscripcion.addHours(6);
                    fechasuscripcion=date.valueOf(fcsd.pdfechasuscripcion.year()+'-'+fcsd.pdfechasuscripcion.month()+'-'+fcsd.pdfechasuscripcion.day());
                }
                IF (fcsd.pcPEP =='S') { pcPEP = TRUE;
                }
                else 
                {
                    pcPEP = false; 
                }    
                IF (fcsd.pcFATCA =='S'){ pcFATCA = TRUE;
                }
                else 
                {
                    pcFATCA = false;
                }                
                IF (fcsd.pcFATCANC =='S'){ 
                    pcFATCANC = TRUE;
                }
                else 
                {
                    pcFATCANC = false;
                }                 
                IF (fcsd.ACTIV_PASIVO =='A')
                {
                    ACTIVA = TRUE;
                    PASIVA    = FALSE;
                    OcultarPASIVA    = true;
                    OcultarACTIVA    = false;
 		            bloqeListEnti= true;
                }
               
                
                 IF (fcsd.ACTIV_PASIVO =='P')
                {
                    PASIVA = TRUE;
                    ACTIVA    = FALSE;
                    OcultarACTIVA    = true;
                    OcultarPASIVA    = false;
                    bloqeListEnti= false;
                }
                               
                
                 IF (fcsd.ACC_10DE_CONTROL =='S')
                {
                    ACC_10DE_CONTROLSI = TRUE;
                     ACC_10DE_CONTROLNO   = FALSE;
                     OcultarACC_10DE_CONTROLNO  = true;
                     OcultarACC_10DE_CONTROLSI  = false;                  
                }
                               
                 IF (fcsd.ACC_10DE_CONTROL =='N')
                {
                    ACC_10DE_CONTROLNO = TRUE;
                    ACC_10DE_CONTROLSI   = FALSE;
                    OcultarACC_10DE_CONTROLSI  = true;
                    OcultarACC_10DE_CONTROLNO  = false;
                      }

                
                 IF (fcsd.ENTIDAD_FINANCIERA =='EN') { ENTIDADSI = TRUE;    }
                               
                   IF (fcsd.ENTIDAD_FINANCIERA =='IF'){ ENTIDADNO = TRUE;   }
                
                if (fcsd.NUM_TOT_EMPLEADOS != 'null')
                {
                  NUM_TOT_EMPLEADOS = NUM_TOT_EMPLEADOS;
                }
                
                if (fcsd.MTO_APROX_ACTIVO != 'null')
                {
                  MTO_APROX_ACTIVO = fcsd.MTO_APROX_ACTIVO;
                }
                
                if (fcsd.pcEst_cuenta!= 'null'){
                    if (fcsd.pcEst_cuenta == 'I' ){
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente Inactivo'));
                        Activo = fcsd.pcEst_cuenta;
                    }
                    
                    Activo = fcsd.pcEst_cuenta;
                }
               
                TipoCausaOptions = new list <selectOption>();
                TipoCausaOptions.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Causa_Cuenta__c item:[select name, codigo__c from Causa_Cuenta__c where Estado_Cuenta__r.CodigoEstado__c =: Activo])
                {
                    TipoCausaOptions.add(new selectOption(item.codigo__c, item.name));
                }
                 Causa = fcsd.pcCod_Causa;

               IF (fcsd.pcAPNFD =='S') { pcAPNFDSI = TRUE;}
                else
                {
                    pcAPNFDNO = TRUE;
                    OcultarAPNFD = true;
                    pcAPNFDSI = false;
                    OcultarAPNFDNO = false;
                    PC_NIVEL_RIESGO = '2'; 
                    PC_DEBIDA_DELIGENCIA = '2'; 
                }

               IF (fcsd.OTROS_OBLIG =='S')  {
                    OTROS_OBLIGSI = TRUE;
                     OTROS_OBLIGSI  = TRUE;
                     OTROS_OBLIGNO = FALSE;
                     OcultarOTROS_OBLIGNO = true;
                     OcultarOTROS_OBLIGSI = false;
                }
                else
                {
                    OTROS_OBLIGNO = True;
                    OTROS_OBLIGNO  = TRUE;
                    OTROS_OBLIGSI = FALSE;
                    OcultarOTROS_OBLIGSI = true;
                    OcultarOTROS_OBLIGNO = false;
                }
                
                if (fcsd.PaisResidenciaEfectosFiscales != 'null'){
                   PaisResidenciaEfectosFiscales = fcsd.PaisResidenciaEfectosFiscales;  
                }
                
                if (fcsd.NumeroID_Fiscal_OtroPais != 'null'){
                   NumeroID_Fiscal_OtroPais = fcsd.NumeroID_Fiscal_OtroPais;  
                }
                
                 if (fcsd.DIR_CORRESPONDENCIA != 'null'){
                   DIR_CORRESPONDENCIA = fcsd.DIR_CORRESPONDENCIA;  
                }
                
                 if (fcsd.ENTIDAD_FINANCIERA != 'null'){
                   ENTIDAD_FINANCIERA = fcsd.ENTIDAD_FINANCIERA;  
                }
                
                if (fcsd.TIP_ENTIDAD != 'null'){
                  pcListEntidad= fcsd.TIP_ENTIDAD;  
                }
               
                if (fcsd.PCNumeroAPNFD != 'null')
                {
                  PCNumeroAPNFD = fcsd.PCNumeroAPNFD;
                }
                if (fcsd.PC_NIVEL_RIESGO != 'null')
                {
                  PC_NIVEL_RIESGO = fcsd.PC_NIVEL_RIESGO;
                }
                
                 if (fcsd.pcNivelIngreso != 'null')
                {
                  pcNivelIngreso = fcsd.pcNivelIngreso;
                }
                
                if (fcsd.PC_DEBIDA_DELIGENCIA != 'null')
                {
                  PC_DEBIDA_DELIGENCIA = fcsd.PC_DEBIDA_DELIGENCIA;
                }
                
                if (fcsd.REF1_PROVE_NOMB != 'null')
                {
                 REF1_PROVE_NOMB = fcsd.REF1_PROVE_NOMB;
                }
                if (fcsd.REF1_PROVE_PRODUC != 'null')
                {
                 REF1_PROVE_PRODUC = fcsd.REF1_PROVE_PRODUC;
                }
                if (fcsd.REF1_PROVE_TEL != 'null')
                {
                 REF1_PROVE_TEL = fcsd.REF1_PROVE_TEL;
                }
                if (fcsd.REF2_PROVE_NOMB != 'null')
                {
                 REF2_PROVE_NOMB = fcsd.REF2_PROVE_NOMB;
                }
                 
                if (fcsd.REF2_PROVE_PRODUC != 'null')
                {
                 REF2_PROVE_PRODUC = fcsd.REF2_PROVE_PRODUC;
                }
                
                 if (fcsd.REF2_PROVE_TEL != 'null')
                {
                 REF2_PROVE_TEL = fcsd.REF2_PROVE_TEL;
                }
                if (fcsd.REF1_BANCA_NOMB != 'null')
                {
                 REF1_BANCA_NOMB = fcsd.REF1_BANCA_NOMB;
                }
                if (fcsd.REF1_BANCA_TEL != 'null')
                {
                 REF1_BANCA_TEL = fcsd.REF1_BANCA_TEL;
                }
                
                
                if (fcsd.REF2_BANCA_NOMB != 'null')
                {
                 REF2_BANCA_NOMB = fcsd.REF2_BANCA_NOMB;
                }
                
                if (fcsd.REF2_BANCA_TEL != 'null')
                {
                 REF2_BANCA_TEL = fcsd.REF2_BANCA_TEL;
                }
                
                if (fcsd.PAIS_CONSEMP != 'null')
                {
                 PAIS_CONSEMP = fcsd.PAIS_CONSEMP;
                }
                
                 if (fcsd.NUM_ACCIONISTAS != 'null')
                {
                 NUM_ACCIONISTAS = fcsd.NUM_ACCIONISTAS;
                }
                if (fcsd.COD_ACTIVIDAD != 'null')
                {
                 Cliente25.Sector__c = fcsd.COD_ACTIVIDAD;
                }
                if (fcsd.AMPLIAR_ACT_ECONOMICA != 'null')
                {
                 AMPLIAR_ACT_ECONOMICA = fcsd.AMPLIAR_ACT_ECONOMICA;
                }
                
                 if (fcsd.pcTipoFondo != 'null')
                {
                  pcTipoFondo = fcsd.pcTipoFondo;
                }
                
                  if (fcsd.pcpromotor != 'null')
                {
                  pcpromotor = fcsd.pcpromotor;
                }
                
                if (fcsd.pcnroid != 'null'){
                   pcnroid = fcsd.pcnroid;  
                }
                
                 if (fcsd.pcformapago != 'null')
                {
                   pcformapago = fcsd.pcformapago;
                }
                if (fcsd.pccuentapago != 'null')
                {
                     pccuentapago = fcsd.pccuentapago;
                }
                if (fcsd.pcTipoAporte != 'null')
                {
                   pcTipoAporte = pcTipoAporte;
                }

                
               if (fcsd.PAIS1 != 'null')
                {
                  PAIS1 = fcsd.PAIS1;
                }
                if (fcsd.PAIS2 != 'null')
                {
                 PAIS2 = fcsd.PAIS2;
                    Segun_pais = true; }else{Segun_pais = false; }
                
                if (fcsd.PAIS3 != null)
                {
                 PAIS3 = fcsd.PAIS3;
                }
                if (fcsd.DEPTO1 != null)
                {
                 DEPTO1 = fcsd.DEPTO1;
                }
                if (fcsd.DEPTO2 != 'null')
               {
                 DEPTO2 = fcsd.DEPTO2;
                    Segun_depto=true;}else{Segun_depto=false; }
                
                if (fcsd.DEPTO3 != null)
                {
                 DEPTO3 = fcsd.DEPTO3;
                }
                
                
                if (fcsd.NUM_ID_CONTR_SOCI != 'null')
                {
                 NUM_ID_CONTR_SOCI = fcsd.NUM_ID_CONTR_SOCI;
                }
                if (fcsd.NOMBRE_CONTR_SOC != 'null')
                {
                 NOMBRE_CONTR_SOC = fcsd.NOMBRE_CONTR_SOC;
                }
               
                if(fcsd.FECHA_CONSTITUCION!=null){
                    fcsd.FECHA_CONSTITUCION = fcsd.FECHA_CONSTITUCION.addHours(6);
                    FECHA_CONSTITUCION=date.valueOf(fcsd.FECHA_CONSTITUCION.year()+'-'+fcsd.FECHA_CONSTITUCION.month()+'-'+fcsd.FECHA_CONSTITUCION.day());
                }
                
                if (fcsd.NUM_ACCIONISTAS != 'null')
                {
                 NUM_ACCIONISTAS = fcsd.NUM_ACCIONISTAS;
                }
                if (fcsd.COD_ACTIVIDAD != 'null')
                {
                 Cliente25.Sector__c = fcsd.COD_ACTIVIDAD;
                }
                
                if (fcsd.pcAportacionTrabajoP != 'null')
                {
                     pcAportacionTrabajoP = fcsd.pcAportacionTrabajoP;
                }

                
                if (fcsd.NOM_REPRE_LEGAL != 'null')
                {
                 NombreRL = fcsd.NOM_REPRE_LEGAL;
                }
                if (fcsd.CARGO_REPRE_LEGAL != 'null')
                {
                 CargoRL = fcsd.CARGO_REPRE_LEGAL;
                }
                if (fcsd.NUMID_FIRMAN1 != 'null')
                {
                 NUMID_FIRMAN1 = fcsd.NUMID_FIRMAN1;
                }
                if (fcsd.COD_CTE_FIR1 != 'null')
                {
                 COD_CTE_FIR1 = fcsd.COD_CTE_FIR1;
                }
                if (fcsd.NOM_FIRMAN1 != 'null')
                {
                 NOM_FIRMAN1 = fcsd.NOM_FIRMAN1;
                }
                if (fcsd.NUMID_FIRMAN2 != 'null')
                {
                 NUMID_FIRMAN2 = fcsd.NUMID_FIRMAN2;
                }
                if (fcsd.COD_CTE_FIR2 != 'null')
                {
                 COD_CTE_FIR2 = fcsd.COD_CTE_FIR2;
                }
                if (fcsd.NOM_FIRMAN2 != 'null')
                {
                 NOM_FIRMAN2 = fcsd.NOM_FIRMAN2;
                }
                if (fcsd.NUMID_FIRMAN3 != 'null')
                {
                 NUMID_FIRMAN3 = fcsd.NUMID_FIRMAN3;
                }
                if (fcsd.COD_CTE_FIR3 != 'null')
                {
                 COD_CTE_FIR3 = fcsd.COD_CTE_FIR3;
                }
                if (fcsd.NOM_FIRMAN3 != 'null')
                {
                 NOM_FIRMAN3 = fcsd.NOM_FIRMAN3;
                }
                if (fcsd.NUM_ID_CONTR_SOCI != 'null')
                {
                 NUM_ID_CONTR_SOCI = fcsd.NUM_ID_CONTR_SOCI;
                }
                if (fcsd.NOMBRE_CONTR_SOC != 'null')
                {
                 NOMBRE_CONTR_SOC = fcsd.NOMBRE_CONTR_SOC;
                }
                
                if (fcsd.COD_ACTIVIDAD != 'null')
                {
                 Cliente25.Sector__c = fcsd.COD_ACTIVIDAD;
                }
                
                if (fcsd.pcTipoAporte != 'null')
                {
                   TipoAport.Tipo_Aporte__c = fcsd.pcTipoAporte;
                }
                
                 if (fcsd.pcformapago != 'null')
                {
                   pcformapago = fcsd.pcformapago;
                }
                
                 if (fcsd.pccuentapago != 'null')
                {
                     pccuentapago = fcsd.pccuentapago;
                }
                
                 if (fcsd.pcenvio != 'null')
                {
                TipoEnvioo.Tipo_EnvioNuevo__c = fcsd.pcenvio;
                }
                
                 IF(fcsd.pcpromotor != Cliente25.Asesor__c) { Cliente25.Asesor__c = NULL;
                }
                
                if (fcsd.pcUsuarioCN != 'null')
                {
                     pcUsuarioCN = fcsd.pcUsuarioCN;
                }
                
                if (fcsd.pcNombreCompletoDependencia != 'null')
                {
                 pcNombreCompletoDependencia = fcsd.pcNombreCompletoDependencia;
                }
                
                if (fcsd.pcDiaAportacion != 'null')
                {
                DiaMes.Dias_Mes__c = fcsd.pcDiaAportacion;
                }
                
                if (DiaMes.Dias_Mes__c=='null')
                {
                    
                }
                
               ListSocios = fcsd.ListSocios;
                ListSociosTIN=fcsd.ListSociosTIN; 
                ListPropiedadControl = fcsd.ListPropiedadControl;
               // system.debug('Nuevo: '+fcsd.ListSocios);
                if (fcsd.ListSocios == null ){mostrarTabla = true;
                }else{
                    mostrarTablaModifi2 = true;
                }
                 //system.debug('mostrarTablaModifi2: '+mostrarTablaModifi2+'   mostrarTabla: '+mostrarTabla);
                SOCIO=FALSE;
                
               // system.debug('Nuevo: '+fcsd.ListSociosTIN);
                if (fcsd.ListSociosTIN == null ){ MostraTablaSociosTIN = true;
                }else{
                    mostrarTablaModificar = true;
                } 
                //system.debug('MostraTablaSociosTIN: '+MostraTablaSociosTIN+'   mostrarTablaModificar: '+mostrarTablaModificar);
                if (fcsd.ListPropiedadControl == null )
                { 
                    mostrarTablaControlantes = true;
                }else{
                    mostrarTablaModiControlantes = true;
                } 
                MostrarVentanaFATCA(); 
                bloqeListEnti= false;
                
                ListDebidaDil = fcsd.ListDebidaDil;
                //MostrarActDili = true;
                ListClienteONG = fcsd.ListClienteONG;
               	activadesacContratista = true;
				activadesacONG = true;
                
                if (ListDebidaDil.size() == 0)
                {MostrarActDili = false;
                ValorContratistano = true;
                 OcultarSiContratista = true;
                
                }
                else{
                    MostrarActDili = true;
                    ValorContratistasi = true;
                    OcultarNoContratista = true;
                    OcultarSiContratista = true;
                    activadesacContratista = false;
                }
                
 				if (ListClienteONG.size() == 0)
                {MostrarActuaONG = false;
                	valornoONG = true;
                 OcultarONGSI = true;
                }else{
                     MostrarActuaONG = true;
                    valorsiONG = true;
                    OcultarONGSI = true;
                    OcultarONGNO = true;
                    activadesacONG = false;
                } 
				                
                if (fcsd.ValorEmpresaMercaSI == 'S'){
                    ValorEmpresaMercaSI = true;
                }
                if (fcsd.ValorPersonaUsaSI == 'S'){
                    ValorPersonaUsaSI = true;
                }//fin
                
                /*Agregado 11/05/2020*/
                if(fcsd.numtran != 'null')
                {
                    numtran = fcsd.numtran;
                }
                
                Activo = fcsd.pcEst_cuenta;
                TipoCausaOptions = new list <selectOption>();
                TipoCausaOptions.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                 for (Causa_Cuenta__c item:[select name, codigo__c from Causa_Cuenta__c where Estado_Cuenta__r.CodigoEstado__c =: Activo])   {  TipoCausaOptions.add(new selectOption(item.codigo__c, item.name));
                      }
                Causa = fcsd.pcCod_Causa;
                
                pctipoid = fcsd.pctipoid;   
                //pcnroid = fcsd.pcnroid;
                //pcTipoFondo=fcsd.pcTipoFondo;
                                
                if(fcsd.pcFechaVencimientoCN!=null) {
                    fcsd.pcFechaVencimientoCN = fcsd.pcFechaVencimientoCN.addHours(6);
                    fechaVencimiento=date.valueOf(fcsd.pcFechaVencimientoCN.year()+'-'+fcsd.pcFechaVencimientoCN.month()+'-'+fcsd.pcFechaVencimientoCN.day());
                }  
                pcprimernombre = fcsd.pcprimernombre;               
                if (fcsd.pcsegundonombre != 'null')
                {
                    pcsegundonombre = fcsd.pcsegundonombre;
                }
                pcprimerapellido = fcsd.pcprimerapellido;
                if (fcsd.pcsegundoapellido != 'null')
                {
                  pcsegundoapellido = fcsd.pcsegundoapellido; 
                }
                if (fcsd.pcTelefonoCN != 'null')
                {
                  pcTelefonoCN = fcsd.pcTelefonoCN;  
                }
                 if (fcsd.pcCelularCN != 'null')
                {
                   pcCelularCN = fcsd.pcCelularCN;   
                }
                if(fcsd.pdfechanacimiento!=null) {
                    fcsd.pdfechanacimiento = fcsd.pdfechanacimiento.addHours(6);
                    fechaNacimiento=date.valueOf(fcsd.pdfechanacimiento.year()+'-'+fcsd.pdfechanacimiento.month()+'-'+fcsd.pdfechanacimiento.day());
                }
                if (fcsd.pdLugarNacimientoCN != 'null')
                {
                   pdLugarNacimientoCN = fcsd.pdLugarNacimientoCN;
                }
                TipoSexo.Sexo__c = fcsd.pcsexo;
                pcestadocivil = fcsd.pcestadocivil;   
                if (fcsd.pcNombreConyuge != 'null')
                {
                  if (fcsd.pcestadocivil == 'C' || fcsd.pcestadocivil == 'U') { BloquearConyugue=false; pcNombreConyuge = fcsd.pcNombreConyuge;    
                    }
                    else 
                    {   
                        pcNombreConyuge = '';
                        BloquearConyugue=true;         
                    } 
                }
                TipoProfesion.Profesi_n_Ocupaci_n__c = fcsd.pcProfesionOcupacion;
                pcmail = fcsd.pcmail;
                pccodpais = fcsd.pccodpais;
                opcionDepartamento = new list <selectOption>();
                opcionDepartamento.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Departamentos__c item:[select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: fcsd.pccodpais
                                           and codigo_departamento__c =: fcsd.pcDeptoCN])
                {
                    opcionDepartamento.add(new selectOption(item.codigo_departamento__c, item.Departamento__c));
                }
                pcDeptoCN = fcsd.pcDeptoCN;
                opcionMunicipio = new list <selectOption>();
                opcionMunicipio.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Municipio__c item:[select nombre_municipio__c, codigo_municipio__c from Municipio__c where codigo_pais__c =: fcsd.pccodpais and codigo_departamento__c =: fcsd.pcDeptoCN
                                       AND codigo_municipio__c =: fcsd.pcMunicipioCN ])
                {
                    opcionMunicipio.add(new selectOption(item.codigo_municipio__c, item.nombre_municipio__c));
                }
                pcMunicipioCN = fcsd.pcMunicipioCN;
                opcionColonia = new list <selectOption>();
                opcionColonia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Colonias_U__c item:[select nombre_colonia__c, codigo_colonia__c from Colonias_U__c where codigo_pais__c =: fcsd.pccodpais and codigo_departamento__c =: fcsd.pcDeptoCN
                                       AND codigo_municipio__c =: fcsd.pcMunicipioCN and codigo_colonia__c =: fcsd.pcColoniaCN]) 
                {
                    opcionColonia.add(new selectOption(item.codigo_colonia__c, item.nombre_colonia__c));
                }                
                pcColoniaCN = fcsd.pcColoniaCN;
                pcCalleDetalleCN = fcsd.pcCalleDetalleCN;
                opcionNacionalidad = new list <selectOption>();
                opcionNacionalidad.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Pais_R__c item:[select nacionalidad__c, codigo__c from Pais_R__c where codigo__c =: fcsd.pccodpais])
                {
                    opcionNacionalidad.add(new selectOption(item.codigo__c, item.nacionalidad__c));  
                }
                pcnacionalidad = fcsd.pcnacionalidad;
                pcnacionalidad2 = fcsd.pcnacionalidad2;
                pcnacionalidad3 = fcsd.pcnacionalidad3;
                if (fcsd.pcPrimerNombreReferi1 != 'null')
                {
                 pcPrimerNombreReferi1 = fcsd.pcPrimerNombreReferi1;
                }
                if (fcsd.pcSegundoNombreReferi1 != 'null')
                {
                 pcSegundoNombreReferi1 = fcsd.pcSegundoNombreReferi1;
                }
                if (fcsd.pcPrimerApellidoReferi1 != 'null')
                {
                  pcPrimerApellidoReferi1 = fcsd.pcPrimerApellidoReferi1; 
                }
                if (fcsd.pcSegundoApellidoReferi1 != 'null')
                {
                 pcSegundoApellidoReferi1 = fcsd.pcSegundoApellidoReferi1;
                
                }
                if (fcsd.pcTelefono_Referido1Referi1 != 'null')
                {
                  pcTelefono_Referido1Referi1 = fcsd.pcTelefono_Referido1Referi1;
                }
                pcPrimerNombreReferi2 = fcsd.pcPrimerNombreReferi2;
                if (fcsd.pcSegundoNombreReferi2 != 'null')
                {
                   pcSegundoNombreReferi2 = fcsd.pcSegundoNombreReferi2;
                }
                pcPrimerApellidoReferi2 = fcsd.pcPrimerApellidoReferi2;
                if (fcsd.pcSegundoNombreReferi2 != 'null')
                {
                   pcSegundoApellidoReferi2 = fcsd.pcSegundoApellidoReferi2;
                }
                pcTelefono_ReferidoReferi2 = fcsd.pcTelefono_ReferidoReferi2;
				/*Dependencia*/
                IF (fcsd.pcDependeSI =='S') { pcDependeSI = TRUE; Dis_OcultarDependenciaSI = false; Dis_OcultarDependenciaNO = true; Dis_OcultarDependenciaCampos = false; pcDependeNO = FALSE; 
                    //pcDependeSI = true;
                }
                else
                {
                    pcDependeNO = true;
                    Dis_OcultarDependenciaSI = true;
                    Dis_OcultarDependenciaNO = false;
                    Dis_OcultarDependenciaCampos = false;
                    //pcDependeNO = true; 
                    pcDependeSI = false;
                }
                /*IF (fcsd.pcDependeSI =='S')
                {
                    pcDependeSI = TRUE;
                    ValidarDependenciaSI();
                }
                else
                {
                    pcDependeNO = TRUE;
                    ValidarDependenciaNOV();
                }
*/

                Cliente25.Tipo_Identificacion__c = fcsd.pcTipoIDDependencia;
                if (fcsd.pcNumeroIDDependencia != 'null')
                {
                 pcNumeroIDDependencia = fcsd.pcNumeroIDDependencia;
                }
                
                if (fcsd.pcParentescoDependencia != 'null')
                {
                 Cuenta22.Parentesco__c = fcsd.pcParentescoDependencia; 
                }
                
                if (fcsd.pcNombreCompletoDependencia != 'null')
                {
                	pcNombreCompletoDependencia = fcsd.pcNombreCompletoDependencia;
                }
                /*Actua*/
                IF (fcsd.pc_ActuaSI =='S') {OcultaTerSI = TRUE;
                }
                else
                {
                    OcultaTerNO = True;
                }  
                //if (fcsd.pcNumeroIDPV != 'null')
                //{
                  pcNumeroIDPV = fcsd.pcNumeroIDPV;
                //}
                //if (fcsd.pcNombreCompletoPV != 'null')
                //{
                    pcNombreCompletoPV = fcsd.pcNombreCompletoPV;
                //}
                /*cargo politico*/
                IF (fcsd.pcEjerce_Cargo_Publico =='S')   { OcultaCarSI_1 = TRUE;
                }
                else
                {
                    OcultaCarNO_2 = True;
                }  
                if (fcsd.Cargo_Pulbico != 'null')
                {
                  pcCargoEjercido = fcsd.Cargo_Pulbico;
                }
                Cliente25.Tipo_trabajador__c = fcsd.pcTIpoEmpleado;
                if(fcsd.pdfechainiciolabor!=null) { fechaLabor=date.valueOf(fcsd.pdfechainiciolabor.year()+'-'+fcsd.pdfechainiciolabor.month()+'-'+fcsd.pdfechainiciolabor.day());
                }            
                pcNivelIngreso = fcsd.pcNivelIngreso;
				if (fcsd.pcrncempl != 'null')
                {
                  pcrncempl = fcsd.pcrncempl;
                }
				if (fcsd.pccontratocolectivo != 'null')
                {
                  pccontratocolectivo =fcsd.pccontratocolectivo;
                }
                
                
                if (fcsd.pcTipoEmpresaEmpCN != 'null')
                {
                   ClienteTipoId.Tipo_Empresa__c = fcsd.pcTipoEmpresaEmpCN;
                }
                if (fcsd.pcNombreempl != 'null')
                {
                    pcNombreempl = fcsd.pcnombreempl;
                    pcrazonsocialempl = fcsd.pcnombreempl;
                }
                if (fcsd.pcCargoEmpresaEmpCN != 'null')
                {
                     pcCargoEmpresaEmpCN = fcsd.pcCargoEmpresaEmpCN;
                }
               
                if (Cliente25.Sector__c != 'null')
                {
                      Cliente25.Sector__c = fcsd.pcGiroEmpresaEmpCN;
                }
                
                if (fcsd.pcGiroEmpresaEmpCN != 'null')
                {
                      Cliente25.Sector__c = fcsd.pcGiroEmpresaEmpCN;
                }
                if (fcsd.pctelempl != 'null')
                {
                      pctelempl = fcsd.pctelempl;
                }
                if (fcsd.pcextempl != 'null')
                {
                      pcextempl = fcsd.pcextempl;
                }
                if (fcsd.pcmailempl != 'null')
                {
                     pcmailempl = fcsd.pcmailempl;
                }
                
                pcUsuarioCN = fcsd.pcUsuarioCN;
                if(fcsd.pcFechaValidacionCN!=null){ 
                    fcsd.pcFechaValidacionCN = fcsd.pcFechaValidacionCN.addHours(6);
                    fechaValida=date.valueOf(fcsd.pcFechaValidacionCN.year()+'-'+fcsd.pcFechaValidacionCN.month()+'-'+fcsd.pcFechaValidacionCN.day());
                }
                IF (fcsd.pcAPNFD =='S') { pcAPNFDSI = TRUE;
                }
                else
                {
                    pcAPNFDNO = True;
                }
                if (fcsd.PCNumeroAPNFD != 'null')
                {
                  PCNumeroAPNFD = fcsd.PCNumeroAPNFD;
                }
                PC_NIVEL_RIESGO = fcsd.PC_NIVEL_RIESGO;
                PC_DEBIDA_DELIGENCIA = fcsd.PC_DEBIDA_DELIGENCIA;
                /*Pantalla Productos*/
                pcproducto = fcsd.pcproducto;
                opcionSubproducto = new list <selectOption>();
            	opcionSubproducto.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            	for (Subproducto__c item:[select name, codigo__c from Subproducto__c where producto__r.codigo__c =: fcsd.pcproducto])    	{ 	opcionSubproducto.add(new selectOption(item.codigo__c, item.name));
            	}
                pcsubproducto = fcsd.pcsubproducto;
                Cuenta20.Tipo_Fondo__c = fcsd.pcTipoFondo;
                TipMoneda.Tipo_Moneda__c = fcsd.pcTipoMoneda;
                Cuenta20.Frecuencia_Aportacion__c = fcsd.pcperiodicidad;
                pcformapago = fcsd.pcformapago;
                //DiaMes.Dias_Mes__c = fcsd.pcDiaAportacion;
                pnmontoaporte = fcsd.pnmontoaporte;
                //pnmontoaporte12 = fcsd.pnmontoaporte12;*/
                if (fcsd.pccuentapago != 'null')
                {
                     pccuentapago = fcsd.pccuentapago;
                }
                if (fcsd.pcSalarioP != 'null')
                {
                    pcSalarioP = fcsd.pcSalarioP;
                }
                
                if (fcsd.pcAportacionTrabajoP != 'null')
                {
                    pcAportacionTrabajoP = fcsd.pcAportacionTrabajoP;
                }
                pcAportacionEmpleadoP = fcsd.pcAportacionEmpleadoP;
                //AportacionTrabajoP = fcsd.pcAportacionTrabajoP;
                //IF (fcsd.pcaplicaseguro =='S')
                //{
                  //  pcaplicaseguro = TRUE;
                    //SI_APLICASEGURO();
                //}
                //else
                //{
                  //  AplicaSeguroNO = True;
                   // NO_APLICASEGURO();
                //}
                if (fcsd.pcPrimaAsegurada != 'null')
                {
                     pcPrimaAsegurada = fcsd.pcPrimaAsegurada;
                }
                if (fcsd.pcSumaAsegurada != 'null')
                {
                	pcSumaAsegurada = fcsd.pcSumaAsegurada;
                }
                if (fcsd.pcNUMUSU != 'null')
                {
                   pcNUMUSU = fcsd.pcNUMUSU;
                }
                TipoEnvioo.Tipo_EnvioNuevo__c = fcsd.pcenvio;
                
                if (fcsd.pcTipoAporte != 'null')
                {
                   TipoAport.Tipo_Aporte__c = fcsd.pcTipoAporte;
                }
                
                if (fcsd.pcTipoAporte != 'null')
                {
                   TipoAport.Tipo_Aporte__c = fcsd.pcTipoAporte;
                }
				
                v_des_procedfds = fcsd.v_des_procedfds;
                IF(fcsd.pcpromotor != Cliente25.Asesor__c) { Cliente25.Asesor__c = NULL;
                }
                
                //fcsd.ListSocios = ListSocios;
                //Muestra el boton de siguiente pantalla
                //mostrarBotonPan = true;
                mostrarSiguientePan = true;}else{ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente No Encontrado'));	    
            }  
			salirCuenta(); }Catch(Exception e){ system.debug('Error al buscar: ' + e.getMessage());
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    }
   
    public void validar125(){
        try{
            
            classListas claseEnvio = new classListas();
            classListas fcsd = controllerApiClienteNatural.consultaListas(pcnroid);
            
            if(pcnroid ==''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Nro ID Vacio'));}else{//stem.debug(fcsd.FATCA);
                    system.debug(fcsd.FATCA);
                    
                    if(fcsd.PEP == true){
                        pcPEP = fcsd.PEP;
                        PC_NIVEL_RIESGO = '3';
                        PC_DEBIDA_DELIGENCIA = '3';
                        muestraPopPEP = true;
                    }
                    if(fcsd.AML == true){
                        AML = fcsd.AML;
                    }
                    if(fcsd.FATCA == true ){
                        pcFATCA = fcsd.FATCA;
                        muestraPopFATCA = true;
                    }
                    if(fcsd.FATCANC == true ){
                        pcFATCANC = fcsd.FATCANC;
                        muestraPopFATCANC = true;
                    }
                    if(fcsd.PEP == true || fcsd.AML == true || fcsd.FATCA == true){
                        desCheckb = true; 
                    }
                    
                    if(fcsd.PEP == true){
                        dispep = true;   
                        
                    }
                    if(fcsd.AML == true){
                        actPop = true; 
                    }
                    disbot = false;
                    validar1 = true;
                }
            
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se encontró Cliente'));	    
        }
    }
    
    public void cleanRiesgo(){
        desCheckb = null; 
        validar1 = null;
    }

    
    public void cancelar(){
       limpiar();
       	
    }
    //FIN------------------------------    
       public void desUn()
      {
                despN = true;
      }
       public void contrUn()
      {
                despN = false;
      }

    public void mostPop()
    {
        actPop = true; 
    }
    public void mostPopPEP()
    {
        muestraPopPEP = true;
    }
    public void mostPopFATCA()
    {
        muestraPopFATCA = true;
    }
    public void mostPopFATCANC()
    {
        muestraPopFATCANC = true;
    }
    public void mostPopVentana()
    {
        MostraVentana = true; 
    }   
     public void mostPopTabla()
    {
        mostrarTabla = true; 
    }
    
    public void mostPopCliente()
    {
            actPopAgregarCliente = true; 
    }
    
/*boton*/
    public void desBtn(){
        cleanRiesgo();
        disbot = true;
    }  
    
    public void desBtnControlantes(){
        validadosControlantes = true;
    } 
    public void desBtnSocios(){
        validadosSocios = true;
    } 
    
     
    public void BloqBotonCU(){
        
        BloquearBtnCu = true;
        BloquearBtnID = false; 
        MostrarCUENTT = '';
        
        
    }    
    
    public void BloqBotonID(){
        
        BloquearBtnID = true; 
        BloquearBtnCu = false;
        NumIDBuscar = '';
    }    
    
    
        public void hidePop(){
        limpiar(); 
        actPop = false;
        muestraPopPEP = false;   
    }
    public void hidePopOtros(){
        muestraPopPEP = false;
        muestraPopFATCA = false;
        muestraPopFATCANC = false;
    }
    
     public void hideVentana(){
        MostraVentana = false;
        Bene_Ocultar_CamPos = False; 
        //beneficiarios campos 
     /*    tipoId2  = null;
         numeroId2 = null;
         tipoBeneficiario2  = null;
         genero2 = null;
         primerNombre2 = null;
         segundoNombre2 = null;
         primerApellido2 = null;
         segundoApellido2 = null;
         Parentesco2 = null;
         Distribucion2 = null;
         Grado2 = null;
         fechaNacimiento2 = null;
        
         //beneficiarios campos 
         tipoId3  = null;
         numeroId3 = null;
         tipoBeneficiario3  = null;
         genero3 = null;
         primerNombre3 = null;
         segundoNombre3 = null;
         primerApellido3 = null;
         segundoApellido3 = null;
         Parentesco3 = null;
         Distribucion3 = null;
         Grado3 = null;
         fechaNacimiento3 = null;
        
         //beneficiarios campos 
         tipoId4  = null;
         numeroId4 = null;
         tipoBeneficiario4  = null;
         genero4 = null;
         primerNombre4 = null;
         segundoNombre4 = null;
         primerApellido4 = null;
         segundoApellido4 = null;
         Parentesco4 = null;
         Distribucion4 = null;
         Grado4 = null;
         fechaNacimiento4 = null;
        
        
         //beneficiarios campos 
         tipoId5  = null;
         numeroId5 = null;
         tipoBeneficiario5  = null;
         genero5 = null;
         primerNombre5 = null;
         segundoNombre5 = null;
         primerApellido5 = null;
         segundoApellido5 = null;
         Parentesco5 = null;
         Distribucion5 = null;
         Grado5 = null;
         fechaNacimiento5 = null;
        
        
          //beneficiarios campos 
         tipoId6  = null;
         numeroId6 = null;
         tipoBeneficiario6  = null;
         genero6 = null;
         primerNombre6 = null;
         segundoNombre6 = null;
         primerApellido6 = null;
         segundoApellido6 = null;
         Parentesco6 = null;
         Distribucion6 = null;
         Grado6 = null;
         fechaNacimiento6 = null;
        
            //beneficiarios campos 
         tipoId7  = null;
         numeroId7 = null;
         tipoBeneficiario7  = null;
         genero7 = null;
         primerNombre7 = null;
         segundoNombre7 = null;
         primerApellido7 = null;
         segundoApellido7 = null;
         Parentesco7 = null;
         Distribucion7 = null;
         Grado7 = null;
         fechaNacimiento7 = null;*/
         
      }

    public void bloqPep(){
        dispep = true; 
        PC_NIVEL_RIESGO = '3'; 
        PC_DEBIDA_DELIGENCIA = '3'; 

    }
        public void unblock(){
        dispep = false; 
        PC_NIVEL_RIESGO = '0'; 
        PC_DEBIDA_DELIGENCIA = '0';    
      //  debidaDiligencviaAplicada = '2'; 
    }
    
     public void MostrarT(){ 
        mostrarTabla=True;      
    }

    
     //*********************Nivel Ingreso***********************************
    
    public void llenarNivelIngreso()
    {
		   this.NivelIngreso = new SelectOption[]{};
           this.NivelIngreso.add(new SelectOption('1','L. 0.00 - L2,000,000.00'));                                                                       
           this.NivelIngreso.add(new SelectOption('2','L2,000,000.01 - L50,000,000.00'));
           this.NivelIngreso.add(new SelectOption('3','L50,000,000.01 - L230,000,000.00'));
           this.NivelIngreso.add(new SelectOption('4','Mayor a L230,000,000.01'));
    }

        public SelectOption[] NivelIngreso
    { 
		public get;
		private set;
	}

    public void mostrarModal()
    {
        despN=true;
    }
 
    public void BusCuentas()
    {
        BuscarCuentas=true;
    }
   
   public void salirCuenta()
    {
        BuscarCuentas=false;
    }    
	
    public void DesbConyugue()
    {
        BloquearConyugue=false;
        
    }
 
	public void BloqConyugue()
    {
		if (pcestadocivil == 'C' || pcestadocivil == 'U'){BloquearConyugue=false;               
        }
        else 
        {   
        	BloquearConyugue=true;
             pcNombreConyuge = ''; 
        }    
	}
    
    
    public void MostrarVentana()
    {
        VentanaAyuda=true;
    }
    
    public void DesbMostrarVentana()
    {
        VentanaAyuda=false;
    }
    
    public void MostrarTablaC()
    {
        mostrarTabla2=true;
    }
    
    public void MostrarVentanaFATCA()
    {
        VentanaFatca=true;
        //PC_NIVEL_RIESGO = '3'; 
        //PC_DEBIDA_DELIGENCIA = '3';
        dispep = true;
        if (pcFATCA == true){ PC_NIVEL_RIESGO = '3'; PC_DEBIDA_DELIGENCIA = '3';            
        }
    }
    
    public void MostrarVentanaFATCANO()
    {
        VentanaFatca=false;
        PC_NIVEL_RIESGO = '0'; 
        PC_DEBIDA_DELIGENCIA = '0';
        dispep = false;
    }

    public void DesMostrarTablaC()
    {
    	mostrarTabla2=false;
    }
    
    public void DesbMostrarVentanaFatca()
    {
    	VentanaFatca=false;
    }
    
    public void MostrarFatcaNacio2()
    {
        desNacion2   =false;
        VentanaFatca=false; 
    }
    
	public void ocultarFatcaNacio2()
    {
    	desNacion2   =false;
        VentanaFatca=true;
    }
    
    public void ocultarpaisopera()
    {
    	Paisopera1   =true;
       
    }

      public void Mostrarpaisopera()
    {
        Paisopera1   =false;
        
    }
    
    public void ocultardeptoopera()
    {
    	deptoopera1   =true;
       
    }

      public void Mostrardeptoopera()
    {
        deptoopera1   =false;
        
    }
    
    public void Actua_SI3()
    {
    	IF(pc_ActuaSI = true)
        {
         	pc_ActuaSI = TRUE;
            pc_ActuaNO = FALSE;
            OcultarActuaSI = false;
            OcultarActuaNO = true; 
            pc_CamposActua =  false;   
        }           
	} 
    
	public void Actua_NO3()
    {
		IF(pc_ActuaNO = true)
        {
        	pc_ActuaSI = false;
            pc_ActuaNO = true;
            OcultarActuaSI = true;
            OcultarActuaNO = false; 
            pc_CamposActua =  true;
		}           
	} 
    
	public void ActuaNada()
    {
		pc_ActuaSI = false;
        pc_ActuaNO = false;
        OcultarActuaSI = false;
        OcultarActuaNO = false;     
    } 

	public void TraerDatos()
    {
    	for(integer i=0; i<NumCuentas.size(); i++)
        {     
        	Prueba = MostrarCUENTT;             
        }
    } 
    
    public void TraerDatos1()
    {
    	for(integer i=0; i<ListSociosTIN.size(); i++)
        {     
        	Prueba2 = MostrarCUENTT;             
        }
    } 
    
     //*********************Llenar Nivel de Riesgo ***********************************
    public void llenarNivelRiesgo()
    {
		this.NivelRiesgoOptions = new SelectOption[]{};
        this.NivelRiesgoOptions.add(new SelectOption('0','NINGUNO'));
        this.NivelRiesgoOptions.add(new SelectOption('1','BAJO'));
        this.NivelRiesgoOptions.add(new SelectOption('2','MEDIO'));
        this.NivelRiesgoOptions.add(new SelectOption('3','ALTO'));
    }
    
    public SelectOption[] NivelRiesgoOptions
    { 
		public get;
		private set;
	}
    
     //*********************Deligencia ***********************************
    public void llenarDeligencia(){
		this.DeligenciaOptions = new SelectOption[]{};
        this.DeligenciaOptions.add(new SelectOption('0','NINGUNA'));                                                                       
        this.DeligenciaOptions.add(new SelectOption('1','SIMPLIFICADA'));
        this.DeligenciaOptions.add(new SelectOption('2','NORMAL'));
        this.DeligenciaOptions.add(new SelectOption('3','INCREMENTADA'));
    }
    
    public SelectOption[] DeligenciaOptions
    { 
		public get;
		private set;
	}
    
     
     //*********************TIPOFONDO ***********************************
     
    Public void llenarTipoFondo()
    {
        this.TipoFondoOptions = new SelectOption[]{};
        this.TipoFondoOptions.add(new SelectOption('','--Ninguno--'));                                                                       
        this.TipoFondoOptions.add(new SelectOption('P','Contributivo'));
        this.TipoFondoOptions.add(new SelectOption('N','No Contributivo'));
        this.TipoFondoOptions.add(new SelectOption('C','Cesantia'));
    }
    
    
    
    Public SelectOption[] TipoFondoOptions
    { 
		Public get;
		Private set;
	}
    
    //*********************TipoCuenta ***********************************
    public list <selectOption> TipoCuentaOptions {get; set;}
    public void llenarTipoCuenta(){
        try
        {   TipoCuentaOptions.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Estado_Cuenta__c item:[select name, CodigoEstado__c from Estado_Cuenta__c ]){ TipoCuentaOptions.add(new selectOption(item.CodigoEstado__c, item.name));} }catch(exception e){
            
        }
    }
    
        //*********************TipoCausa ***********************************
    public list <selectOption> TipoCausaOptions {get; set;}
     public void llenarTipoCausa(){
        try
        {   
            TipoCausaOptions = new list <selectOption>();
            TipoCausaOptions.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Causa_Cuenta__c item:[select name, codigo__c from Causa_Cuenta__c where Estado_Cuenta__r.CodigoEstado__c =: Activo])
            {
                TipoCausaOptions.add(new selectOption(item.codigo__c, item.name));
            }
			
        }catch(exception e){
            
        }
    }
    
   
    
    Public void llenarTipoFormaPago()
    {
            this.TipoFormaPagoOptions = new SelectOption[]{};
            this.TipoFormaPagoOptions.add(new SelectOption('','--Ninguno--')); 
            this.TipoFormaPagoOptions.add(new SelectOption('TL','Talonario'));
            this.TipoFormaPagoOptions.add(new SelectOption('CK','Cheque'));
            this.TipoFormaPagoOptions.add(new SelectOption('PL','Planilla'));
        	this.TipoFormaPagoOptions.add(new SelectOption('IT','Interbanca')); 
            this.TipoFormaPagoOptions.add(new SelectOption('MV','Movil'));
            this.TipoFormaPagoOptions.add(new SelectOption('AH','Cuenta Ahorro'));
            this.TipoFormaPagoOptions.add(new SelectOption('TA','Tarjeta'));
                    
    }
    
    Public SelectOption[] TipoFormaPagoOptions
    { 
		Public get;
		Private set;
	}    
    
    
    
    public void llenarCuenta(){
        try
        {
          opcionCausa = new list <selectOption>();}catch(exception e){ 
        }
    }
    
    
    //Bloquear campo de codigo de tarjeta
    public void bloqueTarjet()
    {
        
        if (pcformapago == 'TA' || pcformapago == 'AH' )
        { 
            BloqForma = false;
        }    
        else {
             BloqForma = true;
        }
            
    }
    
    
    
    public void desbb()
    {
        TIPO_ENTIDADSI = false;
    }
    

    
   
    
    Public list<string> Numcuentas {get; set;}
    
	Public void llenarCuentasDesdeSysde(){
		try{	
            
            resultado = new list<controllerApiClienteNatural.classRespuestaAportesCuenta>();                    
            resultado =  controllerApiClienteNatural.ConsultalAportesPatronales(NumIDBuscar);  
            mostrarTabla2 = false ; 
            //resultado = new list<APIClienteJuridico.ClassPantJuridicoProduc>();                    
            //resultado =  APIClienteJuridico.ConsultaInfoClienteC(NumIDBuscar);
            //ClassPantJuridicoProduc claseEnvio = new ClassPantJuridicoProduc();
        	//ClassPantJuridicoProduc fcsd = APIClienteJuridico.ConsultaInfoClienteC(MostrarCUENTT, NumIDBuscar);
           
            //resultado = new list<controllerApiClienteNatural.classRespuestaAportesCuenta>();                    
            //esultado =  controllerApiClienteNatural.ConsultalAportesPatronales(NumIDBuscar);  
            mostrarTabla2 = false ; 
            if(resultado.size()>0)   { Numcuentas= new list<string>();
                for(integer j=0; j<resultado.size(); j++)
                {
                	for(integer i=0; i<resultado[j].cuentas.size(); i++)
                    {
                    	Numcuentas.add(resultado[j].cuentas[i].cuenta);
                    }
                }
                mostrarTabla2 = true ;
            }  
            bloqcausa=false;
            bloqestado=false;
            bloqcuenta=false;}Catch(Exception e) {ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error desde SYSDE ' + e.getMessage() ));	
	    }
    }
    
   
    
   
   //Oculta los check de cotizaciones
   
    public void ocultarCotiza()
    {
       if (pcCotizaSI == true )
       { 
           pcCotizaoOcultarNO =  true; 
           pcCotizaNO =  false; 
           TickerOcul = false;
           }
      else
           {
               pcCotizaoOcultarSI = false;
               pcCotizaoOcultarNO = false;
               TickerOcul = true;
           }
    }
    
     public void ocultarCotizaNO()
    {
       if (pcCotizaNO == true ) 
       { 
           pcCotizaoOcultarSI =  true; 
           pcCotizaSI = false; 
           TickerOcul = true;
           }
      else
           {
               TickerOcul = false;
               pcCotizaoOcultarSI = false;
               pcCotizaoOcultarNO = false;
           }
    }
    
   
    
     public void ocultarCotizaControlante()
    {
       if (cotizaControlanteSi == true ) 
       { 
           //pcCotizaoOcultarNo =  true; 
           //pcCotizaSI = false; 
           TickerOculControlante = false;
           }
      if (cotizaControlanteNo == true ) 
           {
               TickerOculControlante = true;
               //pcCotizaoOcultar = true;
           }
    }


    public void OcultarPorcentajeIndi()
    {
       if (socioUnico.NIVEL == '1' )
       { 
           Indirectoo =  true; 
           socioUnico.POR_PART_INDIRECT = null;               //Bene_Ocultar_CamPos=true;     
           }
      else
           {
               Indirectoo = false;
           }
    }
    
    
    
    
}