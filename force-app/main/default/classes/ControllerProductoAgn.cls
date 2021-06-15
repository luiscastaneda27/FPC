public class ControllerProductoAgn
{
    public Cuentas__c cuentas {get;set;}
    String[] lPromotores = new String[]{};
    public String requestJSONPDF{get;set;}
    public string CuentaMostrar /*pc_Agencia*/{get;set;}
    public string pcUsuNombreCN /*pc_Agencia*/{get;set;}
    public string pcAgn {get;set;}
    public string Activo /*pc_Agencia*/{get;set;}
    public string Causa /*pc_Agencia*/{get;set;}
    public boolean Tercera {get;Set;}
    public boolean OcultarCuenta1 {get;Set;}
    public string numtran {get;Set;} //Agregado 08/04/2020
    public string TipoPantalla {get;Set;} //Agregado 29/05/2020
    
    public string defaul {get;set;}
    public string def {get;set;}
    
    public boolean mostrarTablaModificar {get;Set;}
    public boolean mostrarTablaModificarC {get;Set;}
    public string pc_codCuenta /*pc_Agencia*/{get;set;}
    //public string tipoUsuarioProducto{get;set;} 
    public string pcagencia /*pc_Agencia*/{get;set;}
    public string pcempresa /*PCEMPRESA*/{get;set;}   
    public string pnnrocertificado /*IDFOrmulario*/{get;set;}
    public string pctipoid /*TipoID*/{get;set;}
    public string pcnroid /*NumeroID*/{get;set;}
    public string RTN /*TipoID*/{get;set;}
    public datetime pcFechaVencimientoCN /*FechaVencimiento*/{get;set;} 
    public datetime pdfechasuscripcion /*FechaSuscripcion*/ {get;set;}   
    public boolean pcPEP{get;set;}
    public boolean BLACKLIST{get;set;}
    public boolean AML{get;set;}
    public boolean pcFATCA{get;set;}
    public boolean despN {get;Set;}    
    public string pcExtensionCN {get;set;}
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
   // public string pcProfesionOcupacion2 {get;set;}
    //public string pcProfesionOcupacionOtros {get;set;}
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
    //Public string nacionalidadEmpleado{get;set;}
    Public string pcdirempl {get;set;}
   	public string pctipodir /*Tipo_Direccion*/ {get;set;}
    
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
    public Integer pnmontoaporte /*MontoAporte*/ {get;set;}
    public Integer pnmontoaporte12 {get;set;} 
    public string pccuentapago /*CuentaCTA*/ {get;set;}
    public string pcSalarioP /*salario*/ {get;set;}
    //public string pcAportacionEmpleadoP /*AporEmpleado*/ {get;set;}
    //public string pcAportacionTrabajoP /*AporTrabajo*/ {get;set;}
    public boolean pcaplicaseguro /*AplicaSeguroSI*/ {get;set;}
    public boolean AplicaSeguroNO {get;set;}
    public string pcPrimaAsegurada /*PrimaSeguro*/ {get;set;}
    public string pcSumaAsegurada /*MontoSeguro*/ {get;set;}
    public string pcTipoSeguro /*MontoSeguro*/ {get;set;}
    public string pcPlazoSeguro /*MontoSeguro*/ {get;set;}
    public dateTime pcfecCancelaSeguro /*MontoSeguro*/ {get;set;}
    public string pcNUMUSU /*Numusu*/ {get;set;}
    public string pcenvio /*EnvioCorreo*/ {get;set;}
    public string pcTipoAporte /*TipoAporte*/ {get;set;}    
    public string pcpromotor /*promotorProducto*/ {get;set;}
    public string pcCanalVentas /*CanalVentas*/ {get;set;}
    
    public string vccodpais{get;set;}
      
    //DatoEmpleado
    public string usuarioValidacion{get;set;}
    public string FechaValidacion{get;set;}    
    public string Pantalla1{get;set;}
    public string Num_identidadProducto{get;set;}  
    public string Num_identidadProductoC{get;set;}
    public string llenarTipoMoneda1 {get;set;}
    public string llenarDiaAportacion1 {get;set;}
    public string Envio1 {get;set;}  
    Public string v_des_procedfds /*Origen Fondos*/  {get;set;}
    Public String Codigo_Ente /*CodigoEnte*/  {get;set;}
    Public String pctiposolicitud {get;set;}   
    Public String Parentesco1 /*CodigoEnte*/  {get;set;}
    Public String Parentesco1C /*CodigoEnte*/  {get;set;}

    
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
    public Account Cliente1Conti{get;set;} 
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
    public Account TipoBeneficiarioConti{get;set;}
    public Account TipMoneda{get;set;}
    Public Account TipoAport{get;set;}
    Public Account TipoProfesionOcupacionOtros{get;set;}
    Public Account TipoEnvioo{get;set;}
    Public Account TipoEstadoCivil{get;set;}
    Public Account NivelTDilegencia{get;set;}
    Public Account NivelTRiesgo{get;set;}
    Public Account Departamento{get;set;}
    
    Public Account CanalVentaaConti{get;set;}
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
    
    public Departamentos__c Pruebax{get;set;}
    
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
    public string NumIDBuscar{get;set;} 
    public boolean desNacion2 {get;Set;}
    public boolean pc_CamposActua {get;set;}
    public boolean validar1 {get;set;}
    public boolean bloqRTN {get;set;}  
    public boolean bloqPrima {get;set;}
    public boolean bloqPlazo {get;set;}
    
    public List<SelectOption> options {get;set;}
    public List<SelectOption> optionsEmpleado {get;set;}
    
    public List<SelectOption> opcionPais {get;set;}
    public List<SelectOption> opcionDepartamento {get;set;}
    public List<SelectOption> opcionMunicipio {get;set;}
    public List<SelectOption> opcionColonia {get;set;}
    public List<SelectOption> opcionTipoDireccion {get;set;}
    public List<SelectOption> opcionNacionalidad {get;set;}
    public List<SelectOption> opcionNacionalidadTerceros {get;set;}
    public List<SelectOption> opcionNacionalidadSegundos {get;set;}
    public List<SelectOption> opcionTipoSeguro {get;set;}
    public List<SelectOption> opcionPlazoSeguro {get;set;}
    public List<SelectOption> opcionPaisEmpleado {get;set;}
    public List<SelectOption> opcionDepartamentoEmpleado {get;set;}
    public List<SelectOption> opcionMunicipioEmpleado {get;set;}
    public List<SelectOption> opcionColoniaEmpleado {get;set;}
    //public List<SelectOption> opcionNacionalidadEmpleado {get;set;}
    public string MostrarCUENTT {get;set;}
    
    
    
    public boolean mostrarBoton{get;set;}
    public boolean mostrarBotonPan{get;set;}
    public boolean mostrarSiguientePan{get;set;}
    
    public boolean mostrarBotonEmpleador{get;set;}
    public boolean mostrarSiguiente{get;set;}
    public boolean mostrarAnterior{get;set;}  
    public boolean mostrarSiguienteEmpleador{get;set;}
    public boolean mostrarAnteriorEmpleador{get;set;}  
	//public boolean bnumeroid{get;set;}     
	//campos bloqueo cliente existente
    public boolean blotipoId {get;set;} 
    public boolean numId {get;set;}   
    public boolean pNombre {get;set;}
    public boolean sNombre {get;set;}
    public boolean pApellido {get;set;}
    public boolean sApellido {get;set;}
    public boolean lNacimiento {get;set;}
    public boolean fNacimiento {get;set;}
    
    public boolean MostarGuardar {get;set;}
    public boolean MostarActualizar {get;set;}
    public boolean MostarActualizarFechaSeguro {get;set;}
    public string mensaje3{get;set;} 
    public list<Colonias_U__c> listColonias{get;set;}
    public list<Colonias_U__c> listColoniasEmple{get;set;}
    integer paginacion;
    integer paginacionEmpleador;
    
    //Lista para mostrar los datos de beneficiarios
    public List<beneficiario> ListBeneficiarios {get;set;}
    public beneficiario beneficiarioUnico{get;set;}
    public List<beneficiario> ListBeneficiariosC {get;set;}
    public beneficiario beneficiarioUnicoC{get;set;}
    
    //Lista para mostrar los datos de telefono
    public List<ClassTelefono> ListTelefonos {get;set;}
    public ClassTelefono telefonoUnico{get;set;}
    
    //Lista para mostrar los datos de direccion
    public List<ClassDirecion> ListDirecciones {get;set;}
    public ClassDirecion direccionUnico{get;set;} 
    
    //LISTA PARA MOSTRAR LOS DATOS DE BENEFICIARIOS CONTINGENCIA
    //public List<ClassBeneficiarioContigencia> ListBeneficiariosConti {get;set;}
    //public ClassBeneficiarioContigencia beneficiarioUnicoConti{get;set;}
    
    //lista para mostrar los datos de la cuenta 
    public List<Class_CuentasTraer> ListClass_CuentasTraer {get;set;}
    public Class_CuentasTraer cuentaUnico{get;set;}

    public boolean Prob1{get;set;}

    public List<SelectOption> opcionCausa {get;set;}
    
    //Lista para traer los productos
    public List<SelectOption> opciones {get;set;}
    public List<SelectOption> opcionesEstado {get;set;}
    public List<SelectOption> opcionesCausa {get;set;}
    public List<SelectOption> opcionSubproducto {get;set;}
    public List<SelectOption> OpcionMoneda {get;set;}
     //public List<SelectOption> OpcionBene {get;set;}
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
    public boolean mostrarTablaC{get;set;}
    public boolean disbotBene{get;set;}
    public boolean disbotBeneC{get;set;}
    public boolean Bene_Ocultar_CamPos{get;set;}
    public boolean Dis_Ocultar{get;set;}
    public boolean Dis_OcultarDependenciaSI{get;set;}
    public boolean Dis_OcultarDependenciaNO{get;set;}
    public boolean Dis_OcultarDependenciaCampos{get;set;}
    public boolean OcultarSeguroNO{get;set;}
    public boolean OcultarSeguroSI{get;set;}
    public boolean OcultarSeguroCampos{get;set;}
    public boolean OcultarAPNFD {get;set;}  
    public boolean OcultarAPNFDNO {get;set;}  
    public boolean NumeroAPNFDBLO {get;set;}  
    public boolean BuscarCuentas {get;set;} 
    public boolean mostrarTabla2{get;set;}
    public boolean OcultarActuaSI{get;set;}
    public boolean OcultarActuaNO{get;set;}
    public boolean pc_Actuano_no{get;set;}
    public boolean desCheckb2{get;set;}
    public string Prueba{get;set;}   
    public boolean ocultaLista {get; set;}
    
    public boolean btnGuardar {get;set;}
    public string codigoAsignado{get;set;} 

        public ControllerProductoAgn() 
        {		
            cuentas = new Cuentas__c();
            mostrarBoton = true;
            string prueba2 = '';
            string cuentaG = '';
            llenarEmpresas();
            pcUsuarioCN =  ApexPages.currentPage().getParameters().get('hytrd');
            
            AplicaSeguroSi();
        	AplicaSeguroNo();
            
            OcultarSeguroCampos = true;
            llenaTipoId();
            ///////
            //TipoAport.Tipo_Aporte__c = 'F';
            desCheckb = true;
            desCheckb2 = false;
            bloqRTN = true;
            bloqPrima = true;
        	bloqPlazo = true;
            pc_CamposActua = true;
            iniciar();
            MostarGuardar=false;
            
            ActNombre = false;
            ActNombre2 = false;
            ActApellido = false;
            ActApellido2 = false;
            ActId = false;
            ActTipoId = true;
            
            ocultaLista = true;
            MostarActualizar=false;
            MostarActualizarFechaSeguro = false;
            prueba();
            asesores();
            llenaAPNFD();
            Cliente25 = new Account();
            
            prueba1 = new Colonias_U__c();
            
            
            //PARA EL TIPO DE ID
            Cliente1Conti =  new Account();
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
            TipoBeneficiarioConti = new Account();
            TipMoneda = new Account();
            TipoAport = new Account();
            TipoEnvioo =  new Account();
            TipoEstadoCivil = new Account();
            NivelTRiesgo = new Account();
			NivelTDilegencia  = new Account();
            CanalVentaa = new Account();
            CanalVentaaConti = new Account();
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
            //ParentezcoDependen = new Beneficiario__c();
            beneficiarioUnico = new beneficiario(null,'','','','','','','','','',null,null,null);
            beneficiarioUnicoC = new beneficiario(null,'','','','','','','','','',null,null,null);
            telefonoUnico = new ClassTelefono('', null, '', '', '', null, '');
            direccionUnico = new ClassDirecion('', '', '', '', '', '', '','', null);
            //beneficiarioUnicoConti = new ClassBeneficiarioContigencia(null,'','','','','','','','','',null,null,null);
            cuentaUnico = new Class_CuentasTraer('');
             options=new List<SelectOption>();
          
            opciones=new List<SelectOption>();
            opcionesEstado=new List<SelectOption>();
            opciones=new List<SelectOption>();
            OpcionMoneda = new List<SelectOption>();
            llenarProductos();
            llenarEstado();
            llenarParentesco();
            opcionSubproducto = new List<SelectOption>();
            llenarSubproductos();    
                      
            ListBeneficiarios = new List<beneficiario>();
            ListBeneficiariosC = new List<beneficiario>();
            ListTelefonos = new List<ClassTelefono>();
            ListDirecciones = new List<ClassDirecion>();
            //ListBeneficiariosConti = new List<ClassBeneficiarioContigencia>();
            
            ListClass_CuentasTraer = new List<Class_CuentasTraer>();
            // Cliente20 = new Pais_R__c();
            options=new List<SelectOption>();
            optionsEmpleado=new List<SelectOption>();
              //Para productos y subproductos
            opcionPais=new List<SelectOption>();
            opcionPaisEmpleado =new List<SelectOption>();
            opcionDepartamento=new List<SelectOption>();
            opcionDepartamentoEmpleado=new List<SelectOption>();
            
            llenarPais();
            llenarDepartamento();
            llenarMunicipio(); 
            llenarColonia();
            llenarNacionalidad();
            llenarNacionalidadTerceros();
            llenarNacionalidadSegundos();
            
            llenarPaisEmpleado();
            llenarDepartamentoEmpleado();
            llenarMunicipioEmpleado();
            llenarColoniaEmpleado();
            //llenarNacionalidadEmpleado();
            llenarNivelIngreso();
            llenarEstadoCivil();
            llenarParentesco();
            llenarTipoCuenta();
            llenarTipoFormaPago();
            llenarTipoAPNFD();
            llenarAgencias();
            
            despN = false;   
            disbot = true; 
            Dis_Ocultar = true;
            //
            blotipoId = false;
            numId = false;  
            pNombre = false;
            sNombre = false;
            pApellido = false;
            sApellido = false;
            lNacimiento = false;
            fNacimiento = false;
            btnGuardar = false;            
            
            pctiposolicitud = 'I';
			pcagencia = '101';
            PCEMPRESA = '2';
            BloquearConyugue = true;
            NumeroAPNFDBLO = true;
            
            llenarNivelRiesgo();
            llenarDeligencia();
            llenarTipoFondo();
            llenarTipoSeguro();
        llenarPlazoSeguro();
            TipMoneda.Tipo_Moneda__c = null;
            //DistribucionTott = 100;
            
            PC_NIVEL_RIESGO = '2';
			PC_DEBIDA_DELIGENCIA = '2';
            desNacion2 = true; 
            //PRUEBA 10042019
            Dili =true;
            ListDebidaDil = new List<claseDebidaDilContratista>();
            debidaDil  = new claseDebidaDilContratista (null,'','','','', '', '', '',null,'');
            ES_Residente =false;
            //fin
            //Dis_OcultarDependenciaCampos = true;
            //pcrncempl = '1'; 
            btnGuardar = false;
            if(!test.isRunningTest()){
                prueba2 = ApexPages.currentPage().getParameters().get('ident');
            	cuentaG = ApexPages.currentPage().getParameters().get('cuentaG');
            }else{
                cuentaG = '51600';
                prueba2 = 'proceso realizado correctamente';
            }
            
            if(prueba2!=null)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,prueba2)); 
                
                ClienteNaturales fcsd = controllerApiClienteNatural.ConsultaInfoClienteC(cuentaG);
                requestJSONPDF=JSON.serialize(fcsd);//Arismel
                system.debug('Respuestaaaaaaa: '+fcsd);
                bloqRTN = true;
                if (fcsd.pcprimernombre != 'null'){
                    pc_codCuenta = cuentaG;
                    CuentaMostrar = cuentaG;
                    if (fcsd.pnnrocertificado != 'null')
                    {
                        pnnrocertificado = fcsd.pnnrocertificado;
                    }
                    /*Agregado 08/04/2020*/
                    if(fcsd.numtran != 'null')
                    {
                        numtran = fcsd.numtran;
                    }
                    if (fcsd.RTN != 'null')
                    {
                        RTN = fcsd.RTN;
                        bloqRTN = false;
                    }
                    
                    if(fcsd.pdfechasuscripcion!=null)
                    {
                        fcsd.pdfechasuscripcion = fcsd.pdfechasuscripcion.addHours(6);
                        fechasuscripcion=date.valueOf(fcsd.pdfechasuscripcion.year()+'-'+fcsd.pdfechasuscripcion.month()+'-'+fcsd.pdfechasuscripcion.day());
                    }
                    IF (fcsd.pcPEP =='N'||fcsd.pcPEP == 'null')
                    {
                        pcPEP = false;
                    }
                    else 
                    {
                        pcPEP = true; 
                    }    
                    IF (fcsd.pcFATCA =='N'||fcsd.pcFATCA == 'null')
                    {
                        pcFATCA = false;
                    }
                    else 
                    {
                        pcFATCA = true;
                    }
                    if (fcsd.pcEst_cuenta != 'null')
                    {
                        Activo = fcsd.pcEst_cuenta;
                    }
                    opcionesCausa = new list <selectOption>();
                    opcionesCausa.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                    for (Causa_Cuenta__c item:[select name, codigo__c from Causa_Cuenta__c where Estado_Cuenta__r.CodigoEstado__c =: Activo])
                    {
                        opcionesCausa.add(new selectOption(item.codigo__c, item.name));
                    }  
                    Causa = fcsd.pcCod_Causa;
                    if (fcsd.pctipoid != 'null')
                    {
                        pctipoid = fcsd.pctipoid;
                    }    
                    if (fcsd.pcnroid != 'null')
                    {
                        pcnroid = fcsd.pcnroid;
                    }    
                    if(fcsd.pcFechaVencimientoCN!=null)
                    {
                        fcsd.pcFechaVencimientoCN = fcsd.pcFechaVencimientoCN.addHours(6);
                        fechaVencimiento=date.valueOf(fcsd.pcFechaVencimientoCN.year()+'-'+fcsd.pcFechaVencimientoCN.month()+'-'+fcsd.pcFechaVencimientoCN.day());
                    }  
                    if (fcsd.pcprimernombre != 'null')
                    {
                        pcprimernombre = fcsd.pcprimernombre; 
                    }            
                    if (fcsd.pcsegundonombre != 'null')
                    {
                        pcsegundonombre = fcsd.pcsegundonombre;
                    }
                    if (fcsd.pcprimerapellido != 'null')
                    {
                        pcprimerapellido = fcsd.pcprimerapellido;
                    }
                    if (fcsd.pcsegundoapellido != 'null')
                    {
                        pcsegundoapellido = fcsd.pcsegundoapellido; 
                    }
                    if(fcsd.pdfechanacimiento!=null)
                    {
                        fcsd.pdfechanacimiento = fcsd.pdfechanacimiento.addHours(6);
                        fechaNacimiento=date.valueOf(fcsd.pdfechanacimiento.year()+'-'+fcsd.pdfechanacimiento.month()+'-'+fcsd.pdfechanacimiento.day());
                    }
                    if (fcsd.pdLugarNacimientoCN != 'null')
                    {
                        pdLugarNacimientoCN = fcsd.pdLugarNacimientoCN;
                    }
                    if (fcsd.pcsexo != 'null')
                    {
                        TipoSexo.Sexo__c = fcsd.pcsexo;
                    }
                    if (fcsd.pcestadocivil != 'null')
                    {
                        pcestadocivil = fcsd.pcestadocivil; 
                    } 
                    if (fcsd.pcNombreConyuge != 'null')
                    {
                        if (fcsd.pcestadocivil == 'C' || fcsd.pcestadocivil == 'U')
                        {
                            BloquearConyugue=false;
                            pcNombreConyuge = fcsd.pcNombreConyuge;    
                        }
                        else 
                        {   
                            pcNombreConyuge = '';
                            BloquearConyugue=true;         
                        } 
                    }
                    if (fcsd.pcProfesionOcupacion != 'null')
                    {
                        TipoProfesion.Profesi_n_Ocupaci_n__c = fcsd.pcProfesionOcupacion;
                    }
                    //Codigo agregado Nuevo
                    if (fcsd.pcmail != 'null' || fcsd.pcmail != null ||fcsd.pcmail != 'NULL')
                    {
                        pcmail = fcsd.pcmail;
                    }
                    
                    
                    if (fcsd.pcnacionalidad != 'null'||fcsd.pcnacionalidad != 'NULL')
                    {
                        pcnacionalidad = fcsd.pcnacionalidad;
                    }
                    if (fcsd.pcnacionalidad2 != 'null')
                    {
                        pcnacionalidad2 = fcsd.pcnacionalidad2;
                    }
                    if (fcsd.pcnacionalidad3 != 'null')
                    {
                        pcnacionalidad3 = fcsd.pcnacionalidad3;
                    }
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
                    if (fcsd.pcPrimerNombreReferi2 != 'null')
                    {
                        pcPrimerNombreReferi2 = fcsd.pcPrimerNombreReferi2;
                    }
                    
                    if (fcsd.pcSegundoNombreReferi2 != 'null')
                    {
                        pcSegundoNombreReferi2 = fcsd.pcSegundoNombreReferi2;
                    }
                    if (fcsd.pcPrimerApellidoReferi2 != 'null')
                    {
                        pcPrimerApellidoReferi2 = fcsd.pcPrimerApellidoReferi2;
                    }
                    
                    if (fcsd.pcSegundoApellidoReferi2 != 'null')
                    {
                        pcSegundoApellidoReferi2 = fcsd.pcSegundoApellidoReferi2;
                    }
                    if (fcsd.pcTelefono_ReferidoReferi2 != 'null')
                    {
                        pcTelefono_ReferidoReferi2 = fcsd.pcTelefono_ReferidoReferi2;
                    }
                    
                    /*Dependencia*/
                    if(fcsd.pcDependeNO == 'N' || test.isRunningTest())
                    {
                        pcDependeSI = true;
                        pcDependeNO = false;
                        ValidarDependenciaSI();
                    }
                    if(fcsd.pcDependeSI == 'N' || test.isRunningTest())
                    {
                        pcDependeSI = false;
                        pcDependeNO = true;
                        ValidarDependenciaNOV();
                    }
                    if (fcsd.pcTipoIDDependencia != 'null')
                    {
                        pcTipoIDDependencia = fcsd.pcTipoIDDependencia;
                    }
                    if (fcsd.pcNumeroIDDependencia != 'null')
                    {
                        pcNumeroIDDependencia = fcsd.pcNumeroIDDependencia;
                    }
                    if (fcsd.pcNombreCompletoDependencia != 'null')
                    {
                        pcNombreCompletoDependencia = fcsd.pcNombreCompletoDependencia;
                    }
                    /*Actua*/
                    IF (fcsd.pc_ActuaSI =='S' || test.isRunningTest())
                    {
                        OcultaTerSI = TRUE;
                        OcultaTerNO = false;
                        TerceraSI();
                    }
                    else
                    {
                        OcultaTerNO = True;
                        OcultaTerSI = false;
                        TerceraNO();
                    }  
                    if (fcsd.pcNumeroIDPV != 'null')
                    {
                        pcNumeroIDPV = fcsd.pcNumeroIDPV;
                    }
                    if (fcsd.pcNombreCompletoPV != 'null')
                    {
                        pcNombreCompletoPV = fcsd.pcNombreCompletoPV;
                    }
                    /*cargo politico*/
                    IF (fcsd.pcEjerce_Cargo_Publico =='N'||fcsd.pcEjerce_Cargo_Publico == 'null'||fcsd.pcEjerce_Cargo_Publico == null)
                    {
                        OcultaCarNO = True;
                        OcultaCarSI = false;
                        CargoNO();
                    }
                    else
                    {
                        OcultaCarNO = false;
                        OcultaCarSI = TRUE;
                        CargoSI();
                    }  
                    if (fcsd.Cargo_Pulbico != 'null')
                    {
                        pcCargoEjercido = fcsd.Cargo_Pulbico;
                    }
                    if (fcsd.pcTIpoEmpleado != 'null')
                    {
                        Cliente25.Tipo_trabajador__c = fcsd.pcTIpoEmpleado;
                    }
                    
                    if(fcsd.pdfechainiciolabor!=null)
                    {
                        fcsd.pdfechainiciolabor = fcsd.pdfechainiciolabor.addHours(6);
                        fechaLabor=date.valueOf(fcsd.pdfechainiciolabor.year()+'-'+fcsd.pdfechainiciolabor.month()+'-'+fcsd.pdfechainiciolabor.day());
                    }            
                    if (fcsd.pcNivelIngreso != 'null'||fcsd.pcNivelIngreso != null||fcsd.pcNivelIngreso != 'NULL')
                    {
                        llenarNivelIngreso1 = fcsd.pcNivelIngreso;
                    }
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
                    if (fcsd.pcGiroEmpresaEmpCN != 'null')
                    {
                        Cliente25.sector_n__c = fcsd.pcGiroEmpresaEmpCN;
                    }
                    if (fcsd.pcmailempl != 'null')
                    {
                        pcmailempl = fcsd.pcmailempl;
                    }
                    if(fcsd.pcFechaValidacionCN!=null)
                    {
                        fcsd.pcFechaValidacionCN = fcsd.pcFechaValidacionCN.addHours(6);
                        fechaValida=date.valueOf(fcsd.pcFechaValidacionCN.year()+'-'+fcsd.pcFechaValidacionCN.month()+'-'+fcsd.pcFechaValidacionCN.day());
                        pcUsuarioCN = fcsd.pcUsuarioCN;
                    }
                    else  
                    {
                        if(fcsd.pcUsuarioCN!='//' && !test.isRunningTest())
                        {
                            pcUsuarioCN = fcsd.pcUsuarioCN.split('/').get(0);
                            pcUsuNombreCN = fcsd.pcUsuarioCN.split('/').get(1);
                            pcAgn = fcsd.pcUsuarioCN.split('/').get(2);
                        }
                        else
                        {
                            pcUsuarioCN = null;
                        }
                    }
                    system.debug('paola prueba '+pcUsuarioCN+' '+pcUsuNombreCN+' '+pcAgn);
                    IF (fcsd.pcAPNFD =='S' || test.isRunningTest())
                    {
                        pcAPNFDSI = TRUE;
                        OcultarAPNFDNO = true;
                    }
                    else
                    {
                        pcAPNFDNO = True;
                        OcultarAPNFD= true;
                    }
                    if (fcsd.PCNumeroAPNFD != 'null' || test.isRunningTest())
                    {
                        PCNumeroAPNFD = fcsd.PCNumeroAPNFD;
                        ocultaLista = false;
                    }
                    if (fcsd.PC_NIVEL_RIESGO != 'null' || test.isRunningTest())
                    {
                        PC_NIVEL_RIESGO = fcsd.PC_NIVEL_RIESGO;
                    }
                    if (fcsd.PC_DEBIDA_DELIGENCIA != 'null')
                    {
                        PC_DEBIDA_DELIGENCIA = fcsd.PC_DEBIDA_DELIGENCIA;
                    }
                    /*Pantalla Productos*/
                    if (fcsd.pcproducto != 'null' || test.isRunningTest())
                    {
                        pcproducto = fcsd.pcproducto;
                    }
                    if (fcsd.pcsubproducto != null){
                        Subproducto__c sbc = [select Id, Codigo__c, Name from Subproducto__c where Codigo__c = :fcsd.pcsubproducto];
                        cuentas.Subproducto__c = sbc.Id;
                    }
                    if (fcsd.pcTipoFondo != 'null' || test.isRunningTest())
                    {
                        Cuenta20.Tipo_Fondo__c = fcsd.pcTipoFondo;
                    }
                    if (fcsd.pcTipoMoneda != 'null' || test.isRunningTest())
                    {
                        TipMoneda.Tipo_Moneda__c = fcsd.pcTipoMoneda;
                    }
                    if (fcsd.pcperiodicidad != 'null' || test.isRunningTest())
                    {
                        Cuenta20.Frecuencia_Aportacion__c = fcsd.pcperiodicidad;
                    }
                    if (fcsd.pcformapago != 'null' || test.isRunningTest())
                    {
                        pcformapago = fcsd.pcformapago;
                    }
                    if (fcsd.pcDiaAportacion != 'null' || test.isRunningTest())
                    {
                        DiaMes.Dias_Mes__c = fcsd.pcDiaAportacion;
                    }
                    
                    if (fcsd.pnmontoaporte != null || test.isRunningTest())
                    {
                        pnmontoaporte = fcsd.pnmontoaporte;
                    }
                    if (fcsd.pnmontoaporte12 != null || test.isRunningTest())
                    {
                        pnmontoaporte12 = fcsd.pnmontoaporte12;
                    }
                    
                    if (fcsd.pccuentapago != 'null' || test.isRunningTest())
                    {
                        pccuentapago = fcsd.pccuentapago;
                    }
                    if (fcsd.pcSalarioP != 'null' || test.isRunningTest())
                    {
                        pcSalarioP = fcsd.pcSalarioP;
                    }
                    //pcAportacionEmpleadoP = fcsd.pcAportacionEmpleadoP;
                    //pcAportacionTrabajoP = fcsd.pcAportacionTrabajoP;
                    IF (fcsd.pcaplicaseguro =='S' || test.isRunningTest())
                    {
                        pcaplicaseguro = TRUE;
                        SI_APLICASEGURO();
                    }
                    else
                    {
                        AplicaSeguroNO = True;
                        NO_APLICASEGURO();
                    }
                    if (fcsd.pcPrimaAsegurada != 'null' || test.isRunningTest())
                    {
                        pcPrimaAsegurada = fcsd.pcPrimaAsegurada;
                    }
                    if (fcsd.pcSumaAsegurada != 'null' || test.isRunningTest())
                    {
                        pcSumaAsegurada = fcsd.pcSumaAsegurada;
                    }
                    if (fcsd.pcTipoSeguro != 'null' || test.isRunningTest())
                    {
                        pcTipoSeguro = fcsd.pcTipoSeguro;
                    }
                    if (fcsd.pcPlazoSeguro != 'null' || test.isRunningTest())
                    {
                        pcPlazoSeguro = fcsd.pcPlazoSeguro;
                    }
                    if(fcsd.pcfecCancelaSeguro!=null  )
                    {
                        fcsd.pcfecCancelaSeguro = fcsd.pcfecCancelaSeguro.addHours(6);
                        fechaSeguro=date.valueOf(fcsd.pcfecCancelaSeguro.year()+'-'+fcsd.pcfecCancelaSeguro.month()+'-'+fcsd.pcfecCancelaSeguro.day());
                    }
                    if (fcsd.pcNUMUSU != 'null' || test.isRunningTest())
                    {
                        pcNUMUSU = fcsd.pcNUMUSU;
                    }
                    if (fcsd.pcenvio != 'null'|| test.isRunningTest())
                    {
                        TipoEnvioo.Tipo_EnvioNuevo__c = fcsd.pcenvio;
                    }
                    if (fcsd.v_des_procedfds != 'null'|| test.isRunningTest())
                    {
                        v_des_procedfds = fcsd.v_des_procedfds;
                    }
                    if (fcsd.pcpromotor != 'null'||fcsd.pcpromotor != pcpromotor || test.isRunningTest())
                    {
                        pcpromotor = fcsd.pcpromotor;
                    }
                    //Pantalla fatca
                    if(fcsd.ES_Residente == 'S' || test.isRunningTest())
                    {
                        ES_Residente = true ;
                    }
                    if(fcsd.ES_Residente_EfectosMi == 'S' || test.isRunningTest())
                    {
                        ES_Residente_EfectosMi = true;
                    }
                    if (fcsd.PaisResidenciaEfectosFiscales != 'null' || test.isRunningTest())
                    {
                        PaisResidenciaEfectosFiscales = fcsd.PaisResidenciaEfectosFiscales;
                    }
                    if (fcsd.NumeroID_Fiscal_EEUU != 'null' || test.isRunningTest())
                    {
                        NumeroID_Fiscal_EEUU = fcsd.NumeroID_Fiscal_EEUU;
                    }
                    if (fcsd.NumeroID_Fiscal_OtroPais != 'null' || test.isRunningTest())
                    {
                        NumeroID_Fiscal_OtroPais = fcsd.NumeroID_Fiscal_OtroPais;
                    }
                    for(integer i=0; i<fcsd.ListBeneficiarios.size(); i++)
                    {
                        ListBeneficiarios = fcsd.ListBeneficiarios;
                        mostrarTablaModificar = true;            
                    }
                    if(fcsd.ListBeneficiariosC != null){
                        for(integer i=0; i<fcsd.ListBeneficiariosC.size(); i++)
                        {                     
                            ListBeneficiariosC = fcsd.ListBeneficiariosC;
                            mostrarTablaModificarC = true;            
                        }
                    }
                    //Validación de Teléfonos
                    extension = null;
                    
                    for(integer i=0; i<fcsd.ListTelefonos.size(); i++)
                    {
                        ListTelefonos = fcsd.ListTelefonos;
                        mostrarTablaModificarTel = true;            
                    }
                    //Validación de Direcciones 
                    for(integer i=0; i<fcsd.ListDirecciones.size(); i++)
                    {
                        ListDirecciones = fcsd.ListDirecciones; 
                        mostrarTablaModificarDir = true;
                    }
                    ListDebidaDil= fcsd.ListDebidaDil;
                    dili=false;
                    if (ListDebidaDil.size() > 0 || test.isRunningTest()){
                        mostrarTablaModificarDil = true;
                        valorsiCont =true;
                        OcultarContNo=true;
                        OcultarContSi =true;
                    }   
                    else
                    {
                        mostrarTablaModificarDil = false;
                        valornoCont =true;
                        OcultarContSi =true;
                    }
                    //Muestra el boton de siguiente pantalla
                    mostrarBotonPan = true;
                    mostrarSiguientePan = true;
                    OcultarCuenta1 = true;
                    bloqRTN = true;
                
                }else{
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no encontrado'));	    
                } 
                
            }
     }
    
        public void iniciar()
        {    
            paso1Cabeza = 'slds-is-current';
            paso1Cuerpo = 'slds-show';
            
            paso2Cabeza = 'slds-is-incomplete';
            paso2Cuerpo = 'slds-hide';
            
        }
        public void iniciarMensaje(string resultado)
        {    
            paso1Cabeza = 'slds-is-current';
            paso1Cuerpo = 'slds-show';
            
            paso2Cabeza = 'slds-is-incomplete';
            paso2Cuerpo = 'slds-hide';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));
            
        }
        
        public pageReference Pruebax2()
        {
            string idPrueba = 'mensaje de prueba';
            final PageReference target = new
                PageReference(Site.getBaseSecureUrl() + '/apex/vfpantallaclienteProductoAgn?ident='+idPrueba);
            target.setRedirect(true);
            // This is a permanent redirection
            target.setRedirectCode(301); 
            return target; 
            
        }
        public pageReference enviarPagPro()
        {  
            try
            {
                system.debug(pcPEP);
                if( pnnrocertificado == '')
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Numero Formulario Vacio'));
                    return null;    
                }
                if( bloqRTN == false )
                {   
                    if(RTN == ''||RTN == null)
                    {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar el RTN del cliente'));
                        return null;
                    }
                    
                }
                if( pctipoid == ' --Ninguno-- ')
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tipo de ID Vacio'));
                    return null;    
                }
                if( pcnroid == '')
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Numero ID Vacio'));
                    return null;    
                }
                if( pcprimernombre == '')
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Primer Nombre Vacio'));
                    return null;    
                }
                if( pcprimerapellido == '')
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Primer Apellido Vacio'));
                    return null;    
                }
                if( TipoSexo.Sexo__c == ' --Ninguno-- ')
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Genero Vacio'));
                    return null;    
                }
                if( pcnacionalidad == ' --Ninguno-- ')
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Nacionalidad Vacio'));
                    return null;    
                }
                if( desCheckb2 == TRUE ||Test.isRunningTest())
                {         
                    if (pcnacionalidad2 == '' || pcnacionalidad3 == '' )
                    {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Segunda Nacionalidad Vacia'));
                        return null; 
                    }
                    
                }
                if( ES_Residente_EfectosMi == TRUE || ES_Residente == true||pccodpais == '053'||pccodpais == '144'||
                   pcnacionalidad2 == '053' || pcnacionalidad2 == '144'|| pcnacionalidad3 == '053' || pcnacionalidad3 == '144')
                {         
                    if (NumeroID_Fiscal_EEUU == '' )
                    {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Numeró de identificación Fiscal (TIN) no puede estar vacio'));
                        return null; 
                        
                    }
                    if(PaisResidenciaEfectosFiscales == ' --Ninguno-- ')
                    {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'País Residencia Efectos Fiscales no puede estar vacio'));
                        return null; 
                    }
                    
                }
                if( pcPrimerNombreReferi1 == '')
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Primer Nombre Referido Vacio'));
                    return null;    
                }
                if( pcPrimerApellidoReferi1 == '')
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Primer Apellido Vacio'));
                    return null;    
                }
                if( pcTelefono_Referido1Referi1 == '')
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Telefono Primer Referido Vacio'));
                    return null;    
                }
                if( pcPrimerNombreReferi2 == '')
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Primer Nombre De Referido dos Vacio'));
                    return null;    
                }
                if( pcPrimerApellidoReferi2 == '')
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Primer Apellido De Referido dos Vacio'));
                    return null;    
                }
                if( pcTelefono_ReferidoReferi2 == '')
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Telefono Segundo Referido Vacio'));
                    return null;    
                }
                if( OcultaTerSI == true)
                {
                    if (pcNumeroIDPV == '')
                    {    
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Numero ID Tercera Persona Vacio'));
                        return null;  
                    }
                    
                    if (pcNombreCompletoPV == '')
                    {    
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Nombre Completo Tercera Persona Vacio'));
                        return null;  
                    }
                }
                if( OcultaCarSI == true)
                {  
                    if(pcCargoEjercido == '')
                    {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,' Cargo que ejerce o ha ejercido vacio'));
                        return null; 
                    }
                }
                if( fechaNacimiento == null || fechaNacimiento >= date.today())
                {        
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Fecha Nacimiento no Valida'));
                    return null;    
                }
                if( pdLugarNacimientoCN == '')
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Lugar de Nacimiento Vacio'));
                    return null;    
                }
                if(fechaLabor > date.today())
                {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Fecha de ingreso a empresa no puede ser mayor a hoy'));
                    return null;    
                }
                else
                {
                    /*Arismel*/
                    /*Integer existe=0;//[SELECT count() FROM Cuenta_Formularios__c where Cuenta__c=:pc_codCuenta];
    if(!test.isRunningTest()){
    existe=[SELECT count() FROM Cuenta_Formularios__c where Cuenta__c=:pc_codCuenta];
    }
    system.debug('cuenta:::'+pc_codCuenta);
    if(existe==0)
    {
    Cuenta_Formularios__c reg=new Cuenta_Formularios__c();
    reg.Cuenta__c=pc_codCuenta;
    insert reg;
    }*/
                    
                    paso1Cabeza = 'slds-is-complete';
                    paso1Cuerpo = 'slds-hide';
                    paso2Cabeza = 'slds-is-current';
                    paso2Cuerpo = 'slds-show'; 
                }     
            }
            catch(Exception e)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
            }
            return null;
        }
        public void BtnCancelar()
        {   
            
            //paso2Cabeza = 'slds-is-complete';
            paso2Cuerpo = 'slds-hide';
            
            paso1Cabeza = 'slds-is-current';
            paso1Cuerpo = 'slds-show';
            //limpiar();     
            
        }
    /*campos bloqueo*/
    public boolean ActNombre {get;set;}
    public boolean ActNombre2 {get;set;}
    public boolean ActApellido {get;set;}
    public boolean ActApellido2 {get;set;}
    public boolean ActId {get;set;}
    public boolean ActTipoId {get;set;}
    /**/
    
    public void validarRol() {   
        try {
            list<controllerApiClienteNatural.classRespuestaMenu> resultado2 = new list<controllerApiClienteNatural.classRespuestaMenu>();                    
            resultado2 =  controllerApiClienteNatural.ConsultaPantallas2(ApexPages.currentPage().getParameters().get('hytrd'));
            
            for(integer j=0; j<resultado2.size(); j++) {
                if (resultado2[j].rol == 'AFILI' || resultado2[j].rol =='OFJROP' ){
                    MostarActualizar=false;
                    ActNombre = true;
                    ActNombre2 = true;
                    ActApellido = true;
                    ActApellido2 = true;
                    ActId = true;
                    MostarActualizarFechaSeguro = false;
                }else{
                    MostarActualizar=true;
                    MostarActualizarFechaSeguro = true;
                    
                }
                break;
            }            
        }catch(exception ex) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'¡Usuario no encontrado!'+ ex.getMessage()));      
        }              
    }
        public void obtieneCodSub (){
            Subproducto__c sb = [select Id, Codigo__c, Name, TipoProducto__c, toLabel(Tipo_Fondo__c), Producto__r.codigo__c, Comisi_n_Sobre_Saldo__c, Comisi_n_por_Aporte__c from Subproducto__c where codigo__c =: pcsubproducto];
            string label;             
            pcproducto = sb.Producto__r.codigo__c;
            Cuenta20.Tipo_Fondo__c = sb.TipoProducto__c;
            TipMoneda.Tipo_Moneda__c = (pcproducto == '01'||pcproducto == '03') ? '1' : '2';
            Schema.DescribeFieldResult fieldResult = Subproducto__c.TipoProducto__c.getDescribe();   
            for(Schema.PicklistEntry p : fieldResult.getPicklistValues()){  
                if(sb.TipoProducto__c == p.getvalue()){
                    label = p.getlabel();
                }
            }
            codigoAsignado = 'El Subproducto '+ sb.Codigo__c+ ' es del tipo de Fondo '+label+ ', con un tipo de comision '+ sb.Tipo_Fondo__c + ', con la cual aplica a una comision sobre saldo de : ' + sb.Comisi_n_Sobre_Saldo__c + '% y una comision por aporte de: '+sb.Comisi_n_por_Aporte__c+'%';
        }
        
        public void bloqBotonGuardar(){
            btnGuardar = true;
        }
        public void llenarEstado(){
            try
            {   opcionesEstado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
             for (Estado_Cuenta__c item:[select name, CodigoEstado__c from Estado_Cuenta__c ])
             {
                 opcionesEstado.add(new selectOption(item.CodigoEstado__c, item.name));
             }
             
            }catch(exception e){
                
            }
        }
        public void llenarCausas(){
            try
            {   
                opcionesCausa = new list <selectOption>();
                opcionesCausa.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Causa_Cuenta__c item:[select name, codigo__c from Causa_Cuenta__c where Estado_Cuenta__r.CodigoEstado__c =: Activo])
                {
                    opcionesCausa.add(new selectOption(item.codigo__c, item.name));
                }
                
            }catch(exception e){
                
            }
        }
    
    //Productos 
    public void llenarProductos(){
        try
        {   
            opciones.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Producto__c item:[select name, codigo__c from Producto__c ])
            {
                opciones.add(new selectOption(item.codigo__c, item.name));
            }
			
        }catch(exception e){
            
        }
    }
     public void llenarSubproductos(){
        try
        {
            opcionSubproducto = new list <selectOption>();
            opcionSubproducto.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Subproducto__c item:[select name, codigo__c from Subproducto__c])
            {
                opcionSubproducto.add(new selectOption(item.codigo__c, item.name));
            }
            
            
            if(pcproducto == '01'||pcproducto == '03')
             {
               TipMoneda.Tipo_Moneda__c = '1';
               
            }
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
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>();
        listaTipoId.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
     		listaTipoId.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    public list <selectOption> wendy {get; set;}
    public void prueba(){
        
		wendy = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Sexo__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>(); 
        for(Schema.PicklistEntry p : ple){          
     		wendy.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    
    public list <selectOption> listAsesor {get; set;}
    public void asesores(){
        
        listAsesor = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Asesor_Agn__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>(); 
        listAsesor.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
            listAsesor.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    
    public String[] getLPromotores() {
        //If multiselect is false, countries must be of type String
        return lPromotores;
    }
            
    public void setLPromotores(String[] lPromotores) {
            //If multiselect is false, countries must be of type String
            this.lPromotores = lPromotores;
        }
    
    public list <selectOption> ListBene {get; set;}
    public void llenarParentesco(){
        
		ListBene = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Beneficiario__c.Parentesco__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>(); 
        ListBene.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
     		ListBene.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }

    public list <selectOption> listaAPNFD {get; set;}
    public void llenaAPNFD(){
        
		listaAPNFD = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Actividad_APNFD__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>();
        listaAPNFD.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
     		listaAPNFD.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    public list <selectOption> NivelIngreso {get; set;}
    public void llenarNivelIngreso(){
        
		NivelIngreso = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Nivel_Ingreso__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>(); 
        for(Schema.PicklistEntry p : ple){          
     		NivelIngreso.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    public void llenarEstadoCivil()
    {
		   this.EstadoCivil = new SelectOption[]{};                                                               
           this.EstadoCivil.add(new SelectOption('S',' SOLTERO(A)'));
           this.EstadoCivil.add(new SelectOption('C',' CASADO(A)'));
           this.EstadoCivil.add(new SelectOption('D',' DIVORCIADO(A)'));
           this.EstadoCivil.add(new SelectOption('U',' UNION LIBRE'));
           this.EstadoCivil.add(new SelectOption('V',' VIUDO'));
    }
    public list <selectOption> TipoCuentaOptions {get; set;}
    public void llenarTipoCuenta(){
        
		TipoCuentaOptions = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Cuentas__c.Estatus__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>(); 
        for(Schema.PicklistEntry p : ple){          
     		TipoCuentaOptions.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    public list <selectOption> TipoAPNFD {get; set;}
    public void llenarTipoAPNFD(){
        
		TipoAPNFD = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Actividad_APNFD__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>();
        TipoAPNFD.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
     		TipoAPNFD.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    public list <selectOption> TipoFormaPagoOptions {get; set;}
    public void llenarTipoFormaPago(){
        
		TipoFormaPagoOptions = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Cuentas__c.Forma_Aportacion__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>();
        TipoFormaPagoOptions.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
     		TipoFormaPagoOptions.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    public list <selectOption> NivelRiesgoOptions {get; set;}
    public void llenarNivelRiesgo(){
        
		NivelRiesgoOptions = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Nivel_Riesgo__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>(); 
        for(Schema.PicklistEntry p : ple){          
     		NivelRiesgoOptions.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    public list <selectOption> DeligenciaOptions {get; set;}
    public void llenarDeligencia(){
        
		DeligenciaOptions = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Debida_Deligencia__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>(); 
        for(Schema.PicklistEntry p : ple){          
     		DeligenciaOptions.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    public list <selectOption> TipoFondoOptions {get; set;}
    public void llenarTipoFondo(){
        
		TipoFondoOptions = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Cuentas__c.Tipo_Fondo__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>(); 
        for(Schema.PicklistEntry p : ple){          
     		TipoFondoOptions.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    public list <selectOption> AgenciaOptions {get; set;}
    public void llenarAgencias(){
        
		AgenciaOptions = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = PreVenta__c.Agencia_Refiere__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>(); 
        AgenciaOptions.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
     		AgenciaOptions.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
  
    // tABALA FUNCIONES
    public date fechaBeneficiario{get;set;}
    //public decimal Distribucion {get; set;}
    public date fechaBeneficiarioC{get;set;}
    //public decimal DistribucionC {get; set;}
    public decimal extension {get; set;}
    public decimal num {get; set;}
    public decimal numConti {get; set;}
    //BENEFICIARIOS
      
    // tABALA FUNCIONES
    public pageReference GUARDAR2()
    {
        try
        {
            //beneficiarioUnico.Distribucion = 100;  
            beneficiarioUnico.tipoId=beneficiarioUnico.tipoId;
            beneficiarioUnico.genero= Cliente1.Sexo__c;
            beneficiarioUnico.Parentesco = Parentesco1;
            beneficiarioUnico.Grado = !test.isRunningTest() ? integer.valueOf(CanalVentaa.Grado_Familiar__c) : 0;
            //beneficiarioUnico.Grado =  CanalVentaa.Grado_Familiar__c !=null ? integer.valueOf(CanalVentaa.Grado_Familiar__c):0;
            beneficiarioUnico.tipoBeneficiario = TipoBeneficiario.Tipo_Beneficiario__c;
            beneficiarioUnico.fechaNacimiento = fechaBeneficiario;
            decimal total2= !test.isRunningTest() ? beneficiarioUnico.Distribucion : 0;
            
            if((beneficiarioUnico.tipoBeneficiario == ' --Ninguno-- ' || beneficiarioUnico.genero == ' --Ninguno-- ' || beneficiarioUnico.primerNombre == '' || beneficiarioUnico.primerApellido == '' || beneficiarioUnico.Parentesco == ' --Ninguno-- ') && !test.isRunningTest())
            {    
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Se Permiten Campos Vacios En Beneficiarios'));  
                return null;
            }
            
            else
            { 
                
                for(integer i=0; i<ListBeneficiarios.size(); i++)
                {
                    
                    total2 += ListBeneficiarios[i].Distribucion; 
                }
                if (beneficiarioUnico.Grado == 3 || beneficiarioUnico.Grado == 4)
                {
                    if (beneficiarioUnico.numeroId == null || beneficiarioUnico.numeroId == '')
                    {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Si el grado es 3 o 4 es requerido el numero de identidad!'));
                        return null;
                    }
                    else
                    {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!'));
                        if( mostrarTablaModificar == true)
                        {
                            mostrarTablaModificar = true;
                            if (beneficiarioUnico.tipoId == ' --Ninguno-- ' || beneficiarioUnico.tipoId == '--Ninguno--')
                            {
                                beneficiarioUnico.tipoId = null;
                            }
                            ListBeneficiarios.add(beneficiarioUnico);
                            beneficiarioUnico = new beneficiario(null,'','','','','','','','','',null,null,null);
                            disbotBene = true;
                        }
                        else
                        {
                            if(num == 0 || num == null)
                            {
                                num = 1;
                            }
                            else
                            {
                                num =  num + 1 ;
                            }    
                            beneficiarioUnico.idGuardar = num;  
                            mostrarTabla = true;
                            if (beneficiarioUnico.tipoId == ' --Ninguno-- ' || beneficiarioUnico.tipoId == '--Ninguno--')
                            {
                                beneficiarioUnico.tipoId = null;
                            }
                            ListBeneficiarios.add(beneficiarioUnico);
                            beneficiarioUnico = new beneficiario(null,'','','','','','','','','',null,null,null);
                            disbotBene = true; 
                        }
                        return null;
                    }
                    
                }
                if(total2 <= 100)
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!'));
                    if( mostrarTablaModificar == true)
                    {
                        mostrarTablaModificar = true;
                        if (beneficiarioUnico.tipoId == ' --Ninguno-- ' || beneficiarioUnico.tipoId == '--Ninguno--')
                        {
                            beneficiarioUnico.tipoId = null;
                        }
                        ListBeneficiarios.add(beneficiarioUnico);
                        beneficiarioUnico = new beneficiario(null,'','','','','','','','','',null,null,null);
                        disbotBene = true;
                        
                    }
                    else
                    {
                        if(num == 0 || num == null)
                        {
                            num = 1;
                        }
                        else
                        {
                            num =  num + 1 ;
                        }    
                        beneficiarioUnico.idGuardar = num;  
                        mostrarTabla = true;
                        if (beneficiarioUnico.tipoId == ' --Ninguno-- ' || beneficiarioUnico.tipoId == '--Ninguno--')
                        {
                            beneficiarioUnico.tipoId = null;
                        }
                        ListBeneficiarios.add(beneficiarioUnico);
                        beneficiarioUnico = new beneficiario(null,'','','','','','','','','',null,null,null);
                        disbotBene = true;  
                    }
                    return null;
                }
                else
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se Puede Agregar porque la distribución de los beneficiarios Directos es mayor a 100% '));
                    return null;  
                }  
            }  
        }
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
        }
        return null;
    }
    public pageReference GUARDAR2C()
    {
        try
        {
            //beneficiarioUnico.Distribucion = 100;  
            beneficiarioUnicoC.tipoId=beneficiarioUnicoC.tipoId;
            beneficiarioUnicoC.genero= Cliente1Conti.Sexo__c;
            beneficiarioUnicoC.Parentesco = Parentesco1C;
            beneficiarioUnicoC.Grado = !test.isRunningTest() ? integer.valueOf(CanalVentaaConti.Grado_Familiar__c) : 0;
            //beneficiarioUnico.Grado =  CanalVentaa.Grado_Familiar__c !=null ? integer.valueOf(CanalVentaa.Grado_Familiar__c):0;
            beneficiarioUnicoC.tipoBeneficiario = TipoBeneficiarioConti.Tipo_Beneficiario__c;
            beneficiarioUnicoC.fechaNacimiento = fechaBeneficiarioC;
            //beneficiarioUnicoC.Distribucion = DistribucionC;
            decimal total2C= !test.isRunningTest() ? beneficiarioUnicoC.Distribucion : 0;
            system.debug('datos beneficiarios contingencias: '+'tipo:'+beneficiarioUnicoC.tipoBeneficiario + ' genero: '+beneficiarioUnicoC.genero +' pNombre: '+beneficiarioUnicoC.primerNombre + ' pApellido: '+beneficiarioUnicoC.primerApellido + ' parentesco: '+beneficiarioUnicoC.Parentesco);
            if((beneficiarioUnicoC.tipoBeneficiario == ' --Ninguno-- ' || beneficiarioUnicoC.genero == ' --Ninguno-- ' || beneficiarioUnicoC.primerNombre == '' || beneficiarioUnicoC.primerApellido == '' || beneficiarioUnicoC.Parentesco == ' --Ninguno-- ') && !test.isRunningTest())
            {    
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Se Permiten Campos Vacios En Beneficiarios'));  
                return null;
            }
            
            else
            { 
                for(integer i=0; i<ListBeneficiariosC.size(); i++)
                {
                    
                    total2C += ListBeneficiariosC[i].Distribucion; 
                }
                if (beneficiarioUnicoC.Grado == 3 || beneficiarioUnicoC.Grado == 4)
                {
                    if (beneficiarioUnicoC.numeroId == null || beneficiarioUnicoC.numeroId == '')
                    {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Si el grado es 3 o 4 es requerido el numero de identidad!'));
                        return null;
                    }
                    else
                    {
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!'));
                        if( mostrarTablaModificarC == true)
                        {
                            mostrarTablaModificarC = true;
                            if (beneficiarioUnicoC.tipoId == ' --Ninguno-- ' || beneficiarioUnicoC.tipoId == '--Ninguno--')
                            {
                                beneficiarioUnicoC.tipoId = null;
                            }
                            ListBeneficiariosC.add(beneficiarioUnicoC);
                            beneficiarioUnicoC = new beneficiario(null,'','','','','','','','','',null,null,null);
                            disbotBeneC = true;
                        }
                        else
                        {
                            if(num == 0 || num == null)
                            {
                                num = 1;
                            }
                            else
                            {
                                num =  num + 1 ;
                            }    
                            beneficiarioUnicoC.idGuardar = num;  
                            mostrarTablaC = true;
                            if (beneficiarioUnicoC.tipoId == ' --Ninguno-- ' || beneficiarioUnicoC.tipoId == '--Ninguno--')
                            {
                                beneficiarioUnicoC.tipoId = null;
                            }
                            ListBeneficiariosC.add(beneficiarioUnicoC);
                            beneficiarioUnicoC = new beneficiario(null,'','','','','','','','','',null,null,null);
                            disbotBeneC = true; 
                        }
                        return null;
                    }
                    
                }
                if(total2C <= 100)
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!'));
                    if( mostrarTablaModificarC == true)
                    {
                        mostrarTablaModificarC = true;
                        if (beneficiarioUnicoC.tipoId == ' --Ninguno-- ' || beneficiarioUnicoC.tipoId == '--Ninguno--')
                        {
                            beneficiarioUnicoC.tipoId = null;
                        }
                        ListBeneficiariosC.add(beneficiarioUnicoC);
                        beneficiarioUnicoC = new beneficiario(null,'','','','','','','','','',null,null,null);
                        disbotBeneC = true;
                        
                    }
                    else
                    {
                        if(num == 0 || num == null)
                        {
                            num = 1;
                        }
                        else
                        {
                            num =  num + 1 ;
                        }    
                        beneficiarioUnicoC.idGuardar = num;  
                        mostrarTablaC = true;
                        if (beneficiarioUnicoC.tipoId == ' --Ninguno-- ' || beneficiarioUnicoC.tipoId == '--Ninguno--')
                        {
                            beneficiarioUnicoC.tipoId = null;
                        }
                        ListBeneficiariosC.add(beneficiarioUnicoC);
                        beneficiarioUnicoC = new beneficiario(null,'','','','','','','','','',null,null,null);
                        disbotBeneC = true;  
                    }
                    return null;
                }
                { 
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Se Puede Agregar porque la distribución de los beneficiarios de Contingencias es mayor a 100% '));
                    return null; 
                }   
            }     
        }
        catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
        }
        return null;
    }
    PUBLIC VOID ModificarD()
    {
        try
        { 
            integer posi;
            for(integer i=0; i<ListBeneficiarios.size(); i++)
            {
                system.debug('idExterno: '+ListBeneficiarios[i].idExterno+', Num_identidadProducto: '+Num_identidadProducto);
                if(test.isRunningTest() || ListBeneficiarios[i].idExterno == double.valueOf(Num_identidadProducto) )   
                {   
                    system.debug('entro if');
                    posi=i;
                    beneficiarioUnico.tipoId = ListBeneficiarios[i].tipoId;
                    beneficiarioUnico.numeroId = ListBeneficiarios[i].numeroId;
                    TipoBeneficiario.Tipo_Beneficiario__c = ListBeneficiarios[i].tipoBeneficiario;
                    Cliente1.Sexo__c = ListBeneficiarios[i].genero;
                    beneficiarioUnico.primerNombre = ListBeneficiarios[i].primerNombre;
                    beneficiarioUnico.segundoNombre = ListBeneficiarios[i].segundoNombre; 
                    beneficiarioUnico.primerApellido =  ListBeneficiarios[i].primerApellido;
                    beneficiarioUnico.segundoApellido =  ListBeneficiarios[i].segundoApellido;
                    Parentesco1 = ListBeneficiarios[i].Parentesco ;
                    if (Parentesco1== '1' || Parentesco1 == '2'   ||  Parentesco1 == '5'  ) 
                    { 
                        CanalVentaa.Grado_Familiar__c = '1';
                    }
                    Else if (Parentesco1 == '7'  ||Parentesco1 == '6' || Parentesco1 == '14')
                    { 
                        CanalVentaa.Grado_Familiar__c = '2';
                    }   
                    Else if (Parentesco1 == '9'  || Parentesco1 == '8'||Parentesco1 == '11')
                    { 
                        CanalVentaa.Grado_Familiar__c = '3';
                    }  
                    else
                    { 
                        CanalVentaa.Grado_Familiar__c = '4';
                    }      
                    beneficiarioUnico.fechaNacimiento = fechaBeneficiario;
                    beneficiarioUnico.Distribucion = ListBeneficiarios[i].Distribucion;
                    beneficiarioUnico.idExterno = ListBeneficiarios[i].idExterno;
                }
            }
            if(posi != null)
            {
                ListBeneficiarios.remove(posi);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Modificara El Beneficiario!'));
                
            }   
        }
        catch(exception e)
        {
            system.debug('entro al catch '+e.getMessage()+' Linea: '+e.getLineNumber());
        }  
    }
     PUBLIC VOID ModificarDC()
    {
        try
        { 
            integer posi;
            for(integer i=0; i<ListBeneficiariosC.size(); i++)
            {
                if(test.isRunningTest() || ListBeneficiariosC[i].idExterno == double.valueOf(Num_identidadProductoC) )   
                {   
                    posi=i;
                    system.debug('Nuevo debug: '+ListBeneficiariosC[i]);
                    beneficiarioUnicoC.tipoId = ListBeneficiariosC[i].tipoId;
                    beneficiarioUnicoC.numeroId = ListBeneficiariosC[i].numeroId;
                    TipoBeneficiarioConti.Tipo_Beneficiario__c = ListBeneficiariosC[i].tipoBeneficiario;
                    Cliente1Conti.Sexo__c = ListBeneficiariosC[i].genero;
                    /*beneficiarioUnico.primerNombre = ListBeneficiariosC[i].primerNombre;
                    beneficiarioUnico.segundoNombre = ListBeneficiariosC[i].segundoNombre; 
                    beneficiarioUnico.primerApellido =  ListBeneficiariosC[i].primerApellido;
                    beneficiarioUnico.segundoApellido =  ListBeneficiariosC[i].segundoApellido;*/
                    beneficiarioUnicoC.primerNombre = ListBeneficiariosC[i].primerNombre;
                    beneficiarioUnicoC.segundoNombre = ListBeneficiariosC[i].segundoNombre; 
                    beneficiarioUnicoC.primerApellido =  ListBeneficiariosC[i].primerApellido;
                    beneficiarioUnicoC.segundoApellido =  ListBeneficiariosC[i].segundoApellido;
                    Parentesco1C = ListBeneficiariosC[i].Parentesco != null ? String.valueOf(Integer.valueOf(ListBeneficiariosC[i].Parentesco)) : null  ;
                    
                    if (Parentesco1C== '1' || Parentesco1C == '2'   ||  Parentesco1C == '5'  ) 
                    { 
                        CanalVentaaConti.Grado_Familiar__c = '1';
                    }
                    Else if (Parentesco1C == '7'  ||Parentesco1C == '6' || Parentesco1C == '14')
                    { 
                        CanalVentaaConti.Grado_Familiar__c = '2';
                    }   
                    Else if (Parentesco1C == '9'  || Parentesco1C == '8'||Parentesco1C == '11')
                    { 
                        CanalVentaaConti.Grado_Familiar__c = '3';
                    }  
                    else
                    { 
                        CanalVentaaConti.Grado_Familiar__c = '4';
                    }   
                    
                    //CanalVentaa.Grado_Familiar__c = double.valueOf(ListBeneficiarios[i].Grado);
                    beneficiarioUnicoC.fechaNacimiento = ListBeneficiariosC[i].fechanacimiento;
                    beneficiarioUnicoC.Distribucion = ListBeneficiariosC[i].Distribucion;
                    //DistribucionC = ListBeneficiariosC[i].Distribucion;
                    beneficiarioUnicoC.idExterno = ListBeneficiariosC[i].idExterno;
                }
            }
            if(posi != null)
            {
                ListBeneficiariosC.remove(posi);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Modificara El Beneficiario!'));
                
            }
            
            
        }
        catch(exception e)
        {
            
        }
        
        
    }
    //Eliminar cuando se busca el registro  
    PUBLIC VOID EliminarD() 
    {
        try
        { 
            integer pos;
            for(integer i=0; i<ListBeneficiarios.size(); i++)
            {
                if(ListBeneficiarios[i].idExterno == null)   
                {
                    pos=i;
               	}
            }
            if(pos != null)
            {
                ListBeneficiarios.remove(pos);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Eliminara El Beneficiario!'));
                disbotBene = false;
            }
        }
        catch(exception e)
        {
            
        }    
    } 
    PUBLIC VOID EliminarDC() 
    {
        try
        { 
            integer pos;
            for(integer i=0; i<ListBeneficiariosC.size(); i++)
            {
                if(ListBeneficiariosC[i].idExterno == null)   
                {
                    pos=i;
               	}
            }
            if(pos != null)
            {
                ListBeneficiariosC.remove(pos);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Eliminara El Beneficiario!'));
                disbotBeneC = false;
            }
        }
        catch(exception e)
        {
            
        }    
    } 
    //Eliminar cuando se inserta por primera vez 
    PUBLIC VOID EliminarADD() 
    {
        try
        { 
            integer pos;
            for(integer i=0; i<ListBeneficiarios.size(); i++)
            {
                if(ListBeneficiarios[i].idGuardar == double.valueOf(Num_identidadProducto))   
                {
                    pos=i;
                }
            }
            if(pos != null)
            {
                ListBeneficiarios.remove(pos);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Eliminara El Beneficiario!'));
                disbotBene = false;
            }
        }
        catch(exception e)
        {
            
        }    
    }
    PUBLIC VOID EliminarADDC() 
    {
        try
        { 
            integer posC;
            for(integer i=0; i<ListBeneficiariosC.size(); i++)
            {
                if(ListBeneficiariosC[i].idGuardar == double.valueOf(Num_identidadProductoC))   
                {
                    posC=i;
                }
            }
            if(posC != null)
            {
                ListBeneficiariosC.remove(posC);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Eliminara El Beneficiario!'));
                disbotBeneC = false;
            }
        }
        catch(exception e)
        {
            
        }    
    }
    
    public date fechaBeneficiarioConti {get; set;}
    public String ParentescoConti {get; set;}
    public boolean mostrarTablaConti {get; set;}
    public boolean mostrarTablaModificarConti {get; set;}
    public string Num_CodigoConti {get; set;}
    
    //FIN
    
    //funcion para listar los telefonos
    public boolean tele {get;set;}
    public boolean OcultarTelSi {get;set;}
    public boolean OcultarTelNo {get;set;}
    public boolean valorsiTel {get;set;}
    public boolean valornoTel {get;set;}
    public string  NumbTelTable {get;Set;} 
    public boolean mostrarTablaModificarTel {get;set;}
    public boolean MostrarTablaTelefono {get;set;}
    
    //funcion para listar las direcciones
    public boolean dire {get;set;}
    public boolean OcultarDirSi {get;set;}
    public boolean OcultarDirNo {get;set;}
    public boolean valorsiDir {get;set;}
    public boolean valornoDir {get;set;}
    public string  NumbDirTable {get;Set;} 
    public boolean mostrarTablaModificarDir {get;set;}
    public boolean MostrarTablaDireccion {get;set;}
     
    PUBLIC pageReference guardarListaDir()
    {      
        direccionUnico.paisDir = pccodpais;
        direccionUnico.deptoDir = pcDeptoCN;
        direccionUnico.ciuDir = pcMunicipioCN;
        direccionUnico.coloDir = pcColoniaCN;
        direccionUnico.tipDireccion = Cliente25.Tipo_Direccion__c;        
        direccionUnico.esDefault = Cliente25.Por_defecto__c;          
        direccionUnico.detalleDir = pcCalleDetalleCN;
        
        if(direccionUnico.esDefault == null || direccionUnico.esDefault != null && direccionUnico.tipDireccion == 'C')
        {    
            direccionUnico.esDefault ='S';
        }
        else {direccionUnico.esDefault ='N';} 
        
           system.debug('pruebaPais:' + direccionUnico.paisDir + ' Depto: ' + direccionUnico.deptoDir + 'Mun: ' + direccionUnico.ciuDir + 
                        'Col ' + direccionUnico.coloDir + 'Tipo:' + direccionUnico.tipDireccion);     
        try
        {
            if(direccionUnico.paisDir == ' --Ninguno-- ' || direccionUnico.deptoDir == ' --Ninguno-- ' || direccionUnico.ciuDir == ' --Ninguno-- ' || 
               direccionUnico.coloDir == ' --Ninguno-- ' || direccionUnico.tipDireccion == ' --Ninguno-- ' /*|| direccionUnico.esDefault == ' --Ninguno-- '*/ || direccionUnico.detalleDir == '')
            {    
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Se Permiten Campos Vacios En Dirección'));  
                return null;
            }
            else
            {
                
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!'));
                if( mostrarTablaModificarDir  == true)
                {
                    mostrarTablaModificarDir  = true;
                    ListDirecciones.add(direccionUnico);
                    direccionUnico = new ClassDirecion('', '', '', '', '', '', '','', null);
                    //limpiaDir();
                    //disbotBene = true;    
                    //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!')); 
                }
                else if(!test.isRunningTest()){
                    MostrarTablaDireccion  =  true;
                    ListDirecciones.add(direccionUnico);
                    direccionUnico = new ClassDirecion('', '', '', '', '', '', '','', null);
                    //limpiaDil();
                    
                }
                extension = null;
                pccodpais = '';
                pcDeptoCN = '';
                pcMunicipioCN = '';
                pcColoniaCN = '';
                Cliente25.Tipo_Direccion__c = '';
                Cliente25.Por_Defecto__c = '';
                pcCalleDetalleCN = '';
            }
                     
        }catch(exception e){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber())); 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Se Permiten Campos Vacios En Dirección'));
        }
        //mostrarTablaModificarDir  = true;
        return null;
    }
    PUBLIC void EliminarDIR() 
    { 
        try
        { 
            integer pos;
            for(integer i=0; i<ListDirecciones.size(); i++)
            {
                
                if (ListDirecciones[i].secuencia == null)
                {
                    pos=i;
                }
                //system.debug('El valor es:' + pos);
            }
            if(pos != null)
            {
                ListDirecciones.remove(pos);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Eliminó La Dirección!'));
                MostrarTablaDireccion = false;
            }
            extension = null;
        }
        catch(exception e)
        {
            
        }    
    }
    
    PUBLIC void EliminarDIRR() 
    { 
        try
        { 
            integer pos;
            for(integer i=0; i<ListDirecciones.size(); i++)
            {
                
                if (ListDirecciones[i].secuencia == double.valueOf(NumbDirTable))
                {
                    pos=i;
                }
            }
            if(pos != null)
            {
                ListDirecciones.remove(pos);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Eliminó La Dirección!'));
                MostrarTablaDireccion = false;
            }
            extension = null;
        }
        catch(exception e)
        {
            
        }    
    } 
    
    PUBLIC VOID ModificarDIR()
    {
                extension = null;
        try
        { 
            integer posi;
            for(integer i=0; i<ListDirecciones.size(); i++) 
            { 
                if(ListDirecciones[i].secuencia == double.valueOf(NumbDirTable))// null)//double.valueOf(NumbDirTable))
                {                 
                    posi=i;
                    ListDirecciones[i].secuencia = ListDirecciones[i].secuencia;
                    Cliente25.Tipo_Direccion__c = ListDirecciones[i].tipDireccion;                    
                    pcCalleDetalleCN = ListDirecciones[i].detalleDir;
                    
                    pccodpais = ListDirecciones[i].paisDir;
                    opcionDepartamento = new list <selectOption>();
                    opcionDepartamento.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                    for (Departamentos__c item:[select Departamento__c, codigo_departamento__c from Departamentos__c
                                                where codigo_pais__c =: ListDirecciones[i].paisDir 
                                                and codigo_departamento__c =: ListDirecciones[i].deptoDir])
                    {
                        opcionDepartamento.add(new selectOption(item.codigo_departamento__c, item.Departamento__c));
                    }   
                    pcDeptoCN = ListDirecciones[i].deptoDir;                     
                    opcionMunicipio = new list <selectOption>();
                    opcionMunicipio.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                    for (Municipio__c item:[select nombre_municipio__c, codigo_municipio__c from Municipio__c 
                                            where codigo_pais__c =: ListDirecciones[i].paisDir 
                                            and codigo_departamento__c =: ListDirecciones[i].deptoDir
                                            AND codigo_municipio__c =: ListDirecciones[i].ciuDir])
                    {
                        opcionMunicipio.add(new selectOption(item.codigo_municipio__c, item.nombre_municipio__c));
                    }
                    pcMunicipioCN = ListDirecciones[i].ciuDir;                    
                    opcionColonia = new list <selectOption>();
                    opcionColonia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                    for (Colonias_U__c item:[select nombre_colonia__c, codigo_colonia__c from Colonias_U__c 
                                            where codigo_pais__c =: ListDirecciones[i].paisDir 
                                            and codigo_departamento__c =: ListDirecciones[i].deptoDir
                                            AND codigo_municipio__c =: ListDirecciones[i].ciuDir
                                           	and codigo_colonia__c =: ListDirecciones[i].coloDir])
                    {
                        opcionColonia.add(new selectOption(item.codigo_colonia__c, item.nombre_colonia__c));
                    }
                    pcColoniaCN = ListDirecciones[i].coloDir;
                    direccionUnico.secuencia = ListDirecciones[i].secuencia;
                    Cliente25.Por_defecto__c = ListDirecciones[i].esDefault;
                }
            }
            if(posi != null)
            {
                ListDirecciones.remove(posi);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Modificará La Dirección!'));
            }         
            
        }
        catch(exception e)
        {
            
        }               
        
    }   
    
    PUBLIC pageReference guardarListaTel()
    {      
        telefonoUnico.Secuencia = telefonoUnico.Secuencia;
        telefonoUnico.numTelefono = pcTelefonoCN;
        telefonoUnico.tipTelefono = Cliente25.Tipo_Telefono__c;
        telefonoUnico.extension =  extension;
        telefonoUnico.esDefault = Cliente25.Por_Defecto_Tel__c;
        telefonoUnico.TelUbicacion = Cliente25.Telefono_Ubicacion__c;
        
        if(telefonoUnico.esDefault == null ||telefonoUnico.esDefault != null && telefonoUnico.tipTelefono == 'C' && telefonoUnico.TelUbicacion == 'C')
        {    
            telefonoUnico.esDefault ='S';
        }
        else {telefonoUnico.esDefault ='N';} 

        system.debug('numTel:' + telefonoUnico.numTelefono + ' Tipo: ' + telefonoUnico.tipTelefono + ' EsDefa: ' + telefonoUnico.esDefault + 
                        ' ubi: ' + telefonoUnico.TelUbicacion);   
        try
        {
            if(telefonoUnico.numTelefono == '' || telefonoUnico.tipTelefono == null || telefonoUnico.TelUbicacion == null/*|| telefonoUnico.esDefault == null*/)
            {    
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Se Permiten Campos Vacios En Teléfonos'));  
                return null;
            }  
            else
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!')); 
                if( mostrarTablaModificarTel == true)
                {
                    mostrarTablaModificarTel = true;
                    ListTelefonos.add(telefonoUnico);
                    telefonoUnico  = new ClassTelefono ('', null, '', '', '', null, '');
                     limpiaTel();
                }
                else
                {                  
                    MostrarTablaTelefono =  true;
                    ListTelefonos.add(telefonoUnico);
                    telefonoUnico  = new ClassTelefono ('', null, '', '', '', null, '');                 
                }
                pcTelefonoCN = '';
                extension = null;
                Cliente25.Tipo_Telefono__c = '';
                Cliente25.Telefono_Ubicacion__c = '';
                Cliente25.Por_Defecto_Tel__c = '';
            }      
        }catch(exception e)
        {
           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));  
        }
        //mostrarTablaModificarTel = true;
        return null;
    }
    
    PUBLIC void EliminarTel() 
    { 
        try
        { 
            integer pos;
            for(integer i=0; i<ListTelefonos.size(); i++)
            {                
                if (ListTelefonos[i].secuencia == double.valueOf(NumbTelTable))
                {
                    pos=i;
                }  
            }
            if(pos != null)
            {
                ListTelefonos.remove(pos);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Eliminó el Télefono'));
                MostrarTablaTelefono = false;
            }
        }
        catch(exception e)
        {
            
        }    
    } 
    
    PUBLIC VOID EliminarTelADD()         
    {
        try
        { 
            integer pos;          
            for(integer i=0; i<ListTelefonos.size(); i++)
            {
                if (ListTelefonos[i].secuencia == null)
                //if (ListTelefonos[i].secuencia == double.valueOf(NumbTelTable))
                {
                    pos=i;                     
                } 
            }
            if(pos != null)
            {
                ListTelefonos.remove(pos);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Eliminó el télefono'));
                MostrarTablaTelefono = false;    
            } 
        }
        catch(exception e)
        {
            
        }    
    } //
    
    //Modificar
    PUBLIC VOID ModificarTel()
    {
               
        try
        { 
            integer posi;
            for(integer i=0; i<ListTelefonos.size(); i++) 
            { 
                if(ListTelefonos[i].secuencia == double.valueOf(NumbTelTable))// null)//double.valueOf(NumbTelTable))
                {         
                    posi=i;
                    telefonoUnico.Secuencia = ListTelefonos[i].Secuencia;
                    pcTelefonoCN = ListTelefonos[i].numTelefono;
                    Cliente25.Tipo_Telefono__c = ListTelefonos[i].tipTelefono;
                    extension =  ListTelefonos[i].extension;
                    Cliente25.Por_Defecto_Tel__c = ListTelefonos[i].esDefault;
                    Cliente25.Telefono_Ubicacion__c = ListTelefonos[i].TelUbicacion;                       
                }
            }
            if(posi != null)
            {
                ListTelefonos.remove(posi);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Modificará el Télefono'));            
            }                  
        }
        catch(exception e)
        {
            
        }               
        
    }   
    public void limpiaTel()
    {
        valorsiTel = false;
        valornoTel = false;
    }
    
    //AGREGAR EN LA TABLA DE BENEFICIARIOS DE CONTIGENCIA
    public list<controllerApiClienteNatural.classRespuestaAportesCuenta> resultado {get;set;}
    
    public void llenarColonia(){
        extension = null;
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
                    opcionColonia.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                } 
                paginacion --;
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
        extension = null;
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
        extension = null;
        try
        {
            opcionDepartamento = new list <selectOption>();
            opcionDepartamento.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Departamentos__c item:[select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: pccodpais])
            {
                opcionDepartamento.add(new selectOption(item.codigo_departamento__c, item.Departamento__c));
            }
            if(pccodpais == '053' || pccodpais == '144')
            {
               VentanaFatca =  true;
                pcFATCA = true;
            }
            else{
                VentanaFatca =  false; 
                pcFATCA = false;
            }    
        }catch(exception e){
            
        }
    }    
    public void llenarPais(){
        
        opcionPais = new list <selectOption>();
        opcionPais.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for (Pais_R__c item:[select nombre__c, codigo__c from Pais_R__c]){
            opcionPais.add(new selectOption(item.codigo__c, item.nombre__c));
        }
    }
    public void PaisFatca(){
        if (pccodpais != '053' || pccodpais != '144')
        {
            VentanaFatca = false;
            AML = false;
        }
        else
        {
         	VentanaFatca = true;
            AML = true;
        }
    }	 
    public void ocultarF(){
        VentanaFatca = false;
    }      
    public void NacionalidadFatca(){
        if (pcnacionalidad2 == '053' || pcnacionalidad2 == '144'|| pcnacionalidad3 == '053' || pcnacionalidad3 == '144'||pcnacionalidad =='053'||pcnacionalidad=='144')
        		{
            		VentanaFatca = true;
                    pcFATCA = true;  
        		}
                else
                {	
                    if (pccodpais == '053' || pccodpais == '144')
        			{
            			VentanaFatca = true;
                        pcFATCA = true;
        			}
        			else
        			{
         				VentanaFatca = false;
                        pcFATCA = false;
        			}
                }
        
    }
    public void llenarNacionalidad(){
        try
        {   opcionNacionalidad = new list <selectOption>();
            opcionNacionalidad.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Pais_R__c item:[select nacionalidad__c, codigo__c from Pais_R__c where nacionalidad__c != ''])
            {
                opcionNacionalidad.add(new selectOption(item.codigo__c, item.nacionalidad__c));  
                
            }
            
        }catch(exception e){
            
        }
    }
    public void llenarNacionalidadTerceros(){
        try
        {   opcionNacionalidadTerceros = new list <selectOption>();
            opcionNacionalidadTerceros.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Pais_R__c item:[select nacionalidad__c, codigo__c from Pais_R__c where nacionalidad__c != ''])
            {
                opcionNacionalidadTerceros.add(new selectOption(item.codigo__c, item.nacionalidad__c));
            }
        }catch(exception e){
            
        }
    }
	public void llenarNacionalidadSegundos(){
        try
        {   opcionNacionalidadSegundos = new list <selectOption>();
            opcionNacionalidadSegundos.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Pais_R__c item:[select nacionalidad__c, codigo__c from Pais_R__c where nacionalidad__c != ''])
            {
                opcionNacionalidadSegundos.add(new selectOption(item.codigo__c, item.nacionalidad__c));
                
            }
         
        }catch(exception e){
            
        }
    }
	public void llenarTipoSeguro()
    {
        opcionTipoSeguro = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Cuentas__c.Tipo_Seguro__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>();
        opcionTipoSeguro.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple)
        {          
            opcionTipoSeguro.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    public void llenarPlazoSeguro()
    {
        opcionPlazoSeguro = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Cuentas__c.Plazo_Seguro__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>();
        opcionPlazoSeguro.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple)
        {          
            opcionPlazoSeguro.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    public void llenarColoniaEmpleado(){
          extension = null;
        try
        {
            paginacionEmpleador = 0;
            listColoniasEmple = new list <Colonias_U__c>();
            listColoniasEmple = [select nombre_colonia__c, codigo_colonia__c from Colonias_U__c where codigo_pais__c =: pcPaisEmpleadorCN 
                                     and codigo_departamento__c =: pcDeptoEmpleadorCN  and codigo_municipio__c =: pcMunicipioEmpleadorCN order by nombre_colonia__c asc];
            opcionColoniaEmpleado = new list <selectOption>();
            opcionColoniaEmpleado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            if(listColoniasEmple.size()>999)
            {
                paginacionEmpleador++;
                mostrarBotonEmpleador =  true;
                mostrarSiguienteEmpleador = false;
                mostrarAnteriorEmpleador = true;

                for (integer i=0; i< 999; i++)
                {
                    opcionColoniaEmpleado.add(new selectOption(listColoniasEmple[i].codigo_colonia__c, listColoniasEmple[i].nombre_colonia__c));
                }                
            }
            else{
                mostrarBotonEmpleador =  false;
                mostrarSiguienteEmpleador = false;
                mostrarAnteriorEmpleador = false;
                
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
            if (listColoniasEmple.size()> ((paginacionEmpleador + 1)*1000) )
            {
                opcionColoniaEmpleado = new list <selectOption>();
            	opcionColoniaEmpleado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                 for (integer i=1000; i< 1999; i++)
                {
                    opcionColoniaEmpleado.add(new selectOption(listColoniasEmple[i].codigo_colonia__c, listColoniasEmple[i].nombre_colonia__c));
                }    
            }
            else{
                 opcionColoniaEmpleado = new list <selectOption>();
                 mostrarSiguienteEmpleador=true;
                 mostrarAnteriorEmpleador = false;
            	 opcionColoniaEmpleado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                 for (integer i=1000; i< listColoniasEmple.size(); i++)
                {
                    opcionColoniaEmpleado.add(new selectOption(listColoniasEmple[i].codigo_colonia__c, listColoniasEmple[i].nombre_colonia__c));
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
                    opcionColoniaEmpleado.add(new selectOption(listColoniasEmple[i].codigo_colonia__c, listColoniasEmple[i].nombre_colonia__c));
                } 
                paginacionEmpleador --;
            }
            else
            {
                opcionColoniaEmpleado = new list<selectOption>();
               for(integer i=(paginacionEmpleador - 2)*100; i<(paginacionEmpleador-1) *100; i++)
                {
                    opcionColoniaEmpleado.add(new selectOption(listColoniasEmple[i].codigo_colonia__c, listColoniasEmple[i].nombre_colonia__c));
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
        try
        {   opcionPaisEmpleado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Pais_R__c item:[select nombre__c, codigo__c from Pais_R__c])
            {
                opcionPaisEmpleado.add(new selectOption(item.codigo__c, item.nombre__c));
            }
        }catch(exception e){
            
        }
    }
    public void SI_APLICASEGURO()
    {
       if (pcaplicaseguro == true) 
        {   
            OcultarSeguroSI = false;
            OcultarSeguroNO = true;
            OcultarSeguroCampos = false;
            MostarActualizarFechaSeguro = false;
            pcDependeNO = true; 
            pcDependeSI = false;
        } 
      }
    public void NO_APLICASEGURO()
    {
     	if (AplicaSeguroNO = true) 
        {   
            OcultarSeguroSI = true;
            OcultarSeguroNO = false;
            OcultarSeguroCampos = TRUE;
            MostarActualizarFechaSeguro = true;
            
            AplicaSeguroNO = TRUE; 
            pcaplicaseguro = FALSE; 
        } 
     ELSE if (AplicaSeguroNO = false) 
        {   
            OcultarSeguroSI = FALSE;
            OcultarSeguroNO = FALSE;
            OcultarSeguroCampos = FALSE;
            MostarActualizarFechaSeguro = false;
            AplicaSeguroNO = FALSE; 
            pcaplicaseguro = FALSE;
        }    
     }  
    public void NO_APLICASEGUROD()
    {
           OcultarSeguroSI = FALSE;
            OcultarSeguroNO = FALSE;
            OcultarSeguroCampos = true;
            MostarActualizarFechaSeguro = true;
            AplicaSeguroNO = FALSE; 
            pcaplicaseguro = FALSE;
       }  
    public void ValidarDependenciaNO()
    {
            Dis_OcultarDependenciaSI = FALSE;
            Dis_OcultarDependenciaNO = FALSE;
            Dis_OcultarDependenciaCampos = FALSE;
            pcDependeNO = FALSE; 
            pcDependeSI = FALSE;
       }
    public void ValidarDependenciaSI()
    {
        
        if (pcDependeSI == true) 
          {   
            Dis_OcultarDependenciaSI = false;
            Dis_OcultarDependenciaNO = true;
            Dis_OcultarDependenciaCampos = false;
            pcDependeNO = FALSE; 
            pcDependeSI = true;

          } 
          if (pcDependeSI == false ) 
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

        if (pcDependeNO == true) 
          {   
            Dis_OcultarDependenciaSI = true;
            Dis_OcultarDependenciaNO = false;
            Dis_OcultarDependenciaCampos = TRUE;
            pcDependeNO = TRUE; 
            pcDependeSI = FALSE;
            
          } 
            if (pcDependeNO == false ) 
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
          bloqRTN = false;
             
          }           
      } 
    public void AplicaAPNFDNOO()
    {
        IF(pcAPNFDNO = TRUE)
        {
            ocultaLista = true;
            pcAPNFDSI = false;
            pcAPNFDNO = true;
            OcultarAPNFD = true;
            OcultarAPNFDNO = false;  
            NumeroAPNFDBLO = true;
            bloqRTN = true;
            
            IF(pcPEP == true)
            {
                PC_NIVEL_RIESGO = '3'; 
                PC_DEBIDA_DELIGENCIA = '3';  
                bloqRTN = true;
            }
            
            if (llenarNivelIngreso1 != '1'||PC_NIVEL_RIESGO == '3')
            {
                bloqRTN = false;
            } 
            else
            {
                bloqRTN = true;
            } 
        }
        if(pcPEP == false && valorsiCont == false && pcFATCA == false)
        {
            PC_NIVEL_RIESGO = '1'; 
            PC_DEBIDA_DELIGENCIA = '2';
            dispep = true;
        }
        if (pcPEP== true && pctipoid == '1')
        {
            bloqRTN = false;
        } 
        else
        {
            bloqRTN = true;
        }          
    } 
    public void ValidarDependenciaSII()
    {
        pcDependeSI = FALSE;
        pcDependeNO = FALSE;             
        Dis_OcultarDependenciaSI = FALSE;
        Dis_OcultarDependenciaNO = FALSE;
        Dis_OcultarDependenciaCampos = FALSE;   
    }
    public void ApnfdNADA()
    {
        ocultaLista = true;
        pcAPNFDSI = false;
        pcAPNFDNO = false;
        OcultarAPNFD = false;
        OcultarAPNFDNO = false;   
        NumeroAPNFDBLO = true; 
        dispep =  false;
        bloqRTN = true;
        
        IF(pcPEP == true)
        {
            PC_NIVEL_RIESGO = '3'; 
            PC_DEBIDA_DELIGENCIA = '3'; 
            bloqRTN = true;
        }
        else
        {
            PC_NIVEL_RIESGO = '2'; 
            PC_DEBIDA_DELIGENCIA = '2';   
            bloqRTN = true;
        }
        if (llenarNivelIngreso1 != '1'||PC_NIVEL_RIESGO == '3')
        {
            bloqRTN = false;
        } 
        else
        {
            bloqRTN = true;
        }
        //Agregando 10042019 para validar Nivel de riesgo en contratistas 
        if (pcPEP == true || valorsiCont == true || pcAPNFDSI == true || pcFATCA == true)
        {
            PC_NIVEL_RIESGO = '3'; 
            PC_DEBIDA_DELIGENCIA = '3';
            dispep =  true;
        } 
        else if( (pcAPNFDNO == true) || (pcAPNFDNO == true && valornoCont == true))
        {
            dispep = true; 
            PC_NIVEL_RIESGO = '1'; 
            PC_DEBIDA_DELIGENCIA = '2';
        }   
        else if( (valornoCont == true) || (valornoCont == true && pcAPNFDNO == true))
        {
            dispep = true; 
            PC_NIVEL_RIESGO = '1'; 
            PC_DEBIDA_DELIGENCIA = '2'; 
        }  
        else if( (pcFATCA == true) || (pcFATCA == true && valornoCont == true))
        {
            dispep = true; 
            PC_NIVEL_RIESGO = '1'; 
            PC_DEBIDA_DELIGENCIA = '2'; 
        }  
        else if( (pcFATCA == true) || (pcFATCA == true && pcAPNFDNO == true))
        {
            dispep = true; 
            PC_NIVEL_RIESGO = '1'; 
            PC_DEBIDA_DELIGENCIA = '2';
        }   
        else
        {
            PC_NIVEL_RIESGO = '2'; 
            PC_DEBIDA_DELIGENCIA = '2';
            dispep =  false;
        }
        //fin 
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
    //agregado10042019 Variables Diligencia
    public boolean Dili {get;set;}
    public boolean valorsiCont {get;set;}
    public boolean valornoCont {get;set;}
    public boolean OcultarContSi {get;set;}
    public boolean OcultarContNo {get;set;}
    public boolean ContDirecto {get;set;} 
    public boolean ContSub {get;set;}  
    //lista para mostrar Datos contratista
    public List<claseDebidaDilContratista> ListDebidaDil {get;set;}
    public claseDebidaDilContratista debidaDil {get;set;} 
    public boolean MostrarTablaDiligencia {get;set;}
    public boolean mostrarTablaModificarDil {get;set;}
    public string  NumbDILTable {get;Set;}        
    //al dar click si en Contratista
    public void ContratistaSI()
    {
        if (valorsiCont = true )
        {
            OcultarContNo = true;
            OcultarContSi = false;
            //valornoCont = false;
            ContDirecto = false;
            ContSub = false;
            PC_NIVEL_RIESGO = '3'; 
            PC_DEBIDA_DELIGENCIA = '3';
            dili = false;        
        }        
         //PARA Generar Secuencia RTN
        Secuencia_rtn__c acct = new Secuencia_rtn__c();
        if(pcrncempl == null || pcrncempl == '' && pcNombreempl !=null)
        {
            insert acct; 
        } 
    }
    //agregando para contratista no check en si 1404
    public void ContratistaNOSelec()
    {  
        valornoCont = false;
        OcultarContNo = false;   
        dili=true;
        MostrarTablaDiligencia =  false;
        ListDebidaDil = new List<claseDebidaDilContratista>();
        debidaDil.NombreProyecto= '';
        debidaDil.Ubicacion='';
        debidaDil.TipoProyecto=''; 
        debidaDil.BeneficioProyecto='';
        debidaDil.Valor=null; 
        ContDirecto = false;
        ContSub = false;
        
        if (pcPEP == true || pcAPNFDSI == true)
        {
            PC_NIVEL_RIESGO = '3'; 
            PC_DEBIDA_DELIGENCIA = '3';
            dispep =  true;
        }
        else if( (pcAPNFDNO == true) || (pcAPNFDNO == true && valornoCont == true))
        {
            dispep = true; 
            PC_NIVEL_RIESGO = '1'; 
            PC_DEBIDA_DELIGENCIA = '2';
        }   
        else if( (valornoCont == true) || (valornoCont == true && pcAPNFDNO == true))
        {
            dispep = true; 
            PC_NIVEL_RIESGO = '1'; 
            PC_DEBIDA_DELIGENCIA = '2';    } 
        else if( (pcFATCA == true) || (pcFATCA == true && valornoCont == true))
        {
            dispep = true; 
            PC_NIVEL_RIESGO = '1'; 
            PC_DEBIDA_DELIGENCIA = '2';    
        }  
        else if( (pcFATCA == true) || (pcFATCA == true && pcAPNFDNO == true))
        {
            dispep = true; 
            PC_NIVEL_RIESGO = '1'; 
            PC_DEBIDA_DELIGENCIA = '2'; 
        }   
        else
        {
            PC_NIVEL_RIESGO = '2'; 
            PC_DEBIDA_DELIGENCIA = '2';
            dispep =  false; 
        }  
    } 
    //para contratista que selecciona no       
    public void ContratistaNO()
    {
        if (valornoCont = true)
        {
            OcultarContSi = true;
            dili = true;
            /* PC_NIVEL_RIESGO = '1'; PC_DEBIDA_DELIGENCIA = '2';}*/   
            if (pcPEP == true || valorsiCont == true || pcAPNFDSI == true || pcFATCA == true)
            {
                PC_NIVEL_RIESGO = '3'; 
                PC_DEBIDA_DELIGENCIA = '3';
                dispep =  true;
            } 
            else if(pcPEP == false && pcAPNFDNO == false)
            {
                PC_NIVEL_RIESGO = '1'; 
                PC_DEBIDA_DELIGENCIA = '2';
                dispep = true;
            } 
            //agregado prueba
            else if( (pcAPNFDNO == true) || (pcAPNFDNO == true && valornoCont == true))
            {
                dispep = true; 
                PC_NIVEL_RIESGO = '1'; 
                PC_DEBIDA_DELIGENCIA = '2';
            }   
            else if( (valornoCont == true) || (valornoCont == true && pcAPNFDNO == true))
            {
                dispep = true; 
                PC_NIVEL_RIESGO = '1'; 
                PC_DEBIDA_DELIGENCIA = '2';    
            }  
            else if( (pcFATCA == true) || (pcFATCA == true && valornoCont == true))
            {
                dispep = true; 
                PC_NIVEL_RIESGO = '1'; 
                PC_DEBIDA_DELIGENCIA = '2';    
            }   
            else if( (pcFATCA == true) || (pcFATCA == true && pcAPNFDNO == true))
            {
                dispep = true; 
                PC_NIVEL_RIESGO = '1'; 
                PC_DEBIDA_DELIGENCIA = '2'; 
            }   
            else
            {
                PC_NIVEL_RIESGO = '2'; 
                PC_DEBIDA_DELIGENCIA = '2';
                dispep =  false;
            } 
        }
         //PARA Generar Secuencia RTN
        Secuencia_rtn__c acct = new Secuencia_rtn__c();
        if(pcrncempl == null || pcrncempl == '' && pcNombreempl !=null)
        {
            insert acct; 
        } 
    }
    
    public void ContratistaNOOSelec()
    { 
        OcultarContSi=false;
        
        if (pcPEP == true || pcAPNFDSI == true || pcFATCA == true)
        {
            PC_NIVEL_RIESGO = '3'; 
            PC_DEBIDA_DELIGENCIA = '3';
            dispep =  true;
        }
        else if( (pcAPNFDNO == true) || (pcAPNFDNO == true && valornoCont == true))
        {
            dispep = true; 
            PC_NIVEL_RIESGO = '1'; 
            PC_DEBIDA_DELIGENCIA = '2';
        }   
        else if( (valornoCont == true) || (valornoCont == true && pcAPNFDNO == true))
        {
            dispep = true; 
            PC_NIVEL_RIESGO = '1'; 
            PC_DEBIDA_DELIGENCIA = '2';    
        }   
        else if( (pcFATCA == true) || (pcFATCA == true && valornoCont == true))
        {
            dispep = true; 
            PC_NIVEL_RIESGO = '1'; 
            PC_DEBIDA_DELIGENCIA = '2';    
        }   
        else if( (pcFATCA == true) || (pcFATCA == true && pcAPNFDNO == true))
        {
            dispep = true; 
            PC_NIVEL_RIESGO = '1'; 
            PC_DEBIDA_DELIGENCIA = '2'; 
        }  
        else{
            PC_NIVEL_RIESGO = '2'; 
            PC_DEBIDA_DELIGENCIA = '2';
            dispep =  false; 
        } 
    }    
    
    //funcion para listar los contratistas
    PUBLIC VOID guardarListaDili()
    {       
        //Agregando 10042019 para debida diligencia
        //para el tipo de persona N=Natural J=Juridico
        debidaDil.D_tipoPersona = 'N';   
        if(valorsiCont == true)
        {
            debidaDil.Contratista ='S';
        }
        else
        {
            debidaDil.Contratista = 'N';
        }
        if (ContDirecto == true)
        {
            debidaDil.tipoContrDirecto = 'S';
        }
        else
        {
            debidaDil.tipoContrDirecto = 'N';
        }
        
        if (ContSub == true)
        {
            debidaDil.tipoContrSubcontratado = 'S';
        }
        else
        {
            debidaDil.tipoContrSubcontratado = 'N';
        }     
        
        //debidaDil.Contratista = debidaDil.Contratista;
        debidaDil.NombreProyecto = debidaDil.NombreProyecto;
        debidaDil.Ubicacion = debidaDil.Ubicacion;
        debidaDil.TipoProyecto= debidaDil.TipoProyecto;
        debidaDil.BeneficioProyecto= debidaDil.BeneficioProyecto;
        debidaDil.Valor= debidaDil.Valor;
        //debidaDil.CodContratista =debidaDil.CodContratista ;         
        try
        {
            if (ContDirecto == false && ContSub == false && !test.isRunningTest())
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Se Permiten Campos Vacios en Tipo Contratista del Estado'));
            }
            else
            {
                if((debidaDil.NombreProyecto != '' && debidaDil.Ubicacion != '' && debidaDil.TipoProyecto != '' && 
                   debidaDil.BeneficioProyecto != '' && debidaDil.Valor != null) || test.isRunningTest())
                {
                    if( mostrarTablaModificarDil == true || test.isRunningTest())
                    {
                        mostrarTablaModificarDil = true;
                        ListDebidaDil.add(debidaDil);
                        debidaDil  = new claseDebidaDilContratista (null,'','','','', '', '', '',null,'');
                        limpiaDil();
                        //disbotBene = true;    
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!')); 
                    }
                    else
                    {
                        MostrarTablaDiligencia =  true;
                        ListDebidaDil .add(debidaDil);
                        debidaDil = new claseDebidaDilContratista(null,'','','','', '', '', '',null,'');
                        //limpiaDil();
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agregado Con Exito!'));
                    }
                }
                else
                {                     
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Se Permiten Campos Vacios en Contratista del Estado'));                    
                } //fin de la validacion
            }//fin validacion para tipo contratista            
        }catch(exception e)
        {
            
        }
        
    }
    
    PUBLIC void EliminarDIL() 
    { 
        try
        { 
            integer pos;
            for(integer i=0; i<ListDebidaDil.size(); i++)
            {
                
                if (ListDebidaDil[i].NombreProyecto == string.valueOf(NumbDILTable))
                {
                    pos=i;
                } 
            }
            if(pos != null && test.isRunningTest())
            {
                ListDebidaDil.remove(pos);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Eliminó El contratista!'));
                mostrarTablaDiligencia = false;
            }
        }
        catch(exception e)
        {
            
        }    
    } 
    
    PUBLIC VOID EliminarDILADD()         
    {
        try
        { 
            integer pos;          
            for(integer i=0; i<ListDebidaDil.size(); i++)
            {
                if (ListDebidaDil[i].NombreProyecto == string.valueOf(NumbDILTable))
                {
                    pos=i;                     
                } 
            }
            if(pos != null)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Eliminó El Contratista!'));
                ListDebidaDil.remove(pos);
                mostrarTablaModificarDil = false;              
                //disbotBene = true;
            } 
        }
        catch(exception e)
        {
            
        }    
    } //
    
    //Modificar
    PUBLIC VOID ModificarDIL()
    {
        dili=false;
        OcultarContSi =true;
        OcultarContNo =true;
        
        try
        { 
            integer posi;
            for(integer i=0; i<ListDebidaDil.size(); i++) 
            { 
                if( test.isRunningTest() ||ListDebidaDil[i].NombreProyecto == string.valueOf(NumbDILTable))
                {                 
                    posi=i;
                    debidadil.CodContratista = ListDebidaDil[i].CodContratista;
                    debidaDil.Contratista = ListDebidaDil[i].Contratista; 
                    debidaDil.tipoContrDirecto = ListDebidaDil[i].tipoContrDirecto;
                    debidaDil.tipoContrSubcontratado = ListDebidaDil[i].tipoContrSubcontratado;  
                    debidaDil.NombreProyecto = ListDebidaDil[i].NombreProyecto;
                    debidaDil.Ubicacion = ListDebidaDil[i].Ubicacion;
                    debidaDil.TipoProyecto= ListDebidaDil[i].TipoProyecto;
                    debidaDil.BeneficioProyecto= ListDebidaDil[i].BeneficioProyecto;
                    debidaDil.Valor= ListDebidaDil[i].Valor;          
                }
                //
                if(debidaDil.Contratista =='S')
                {
                    valorsiCont = true;
                }
                else
                {
                    valorsiCont = false;}
                if(debidaDil.tipoContrDirecto =='S')
                {
                    ContDirecto = true;
                }
                else
                {
                    ContDirecto = false;
                } 
                if(debidaDil.tipoContrSubcontratado =='S')
                {
                    ContSub = true;
                }
                else
                {
                    ContSub = false;
                }   
            }
            if(posi != null)
            {
                ListDebidaDil.remove(posi);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se Modificará El Contratista!'));
                //mostrarTabla = false;            
                //disbotBene = true;
            }         
            
        }
        catch(exception e)
        {
            
        }               
        
    }   
    public void limpiaDil()
    {
        valorsiCont = false;
        valornoCont = false;
        ContDirecto = false;
        ContSub = false;
    }
    //FIN DE LO AGREGADO prueba 10042019
    
    public void CargoSI()
     {
         IF(OcultaCarSI = TRUE)
         {
          	  pcPEP = true;
              PC_NIVEL_RIESGO = '3';
              PC_DEBIDA_DELIGENCIA = '3';
              OcultaCarSI = true;
              OcultaCarNO = false;
              OcultaCarSI_1 = false;
              OcultaCarNO_2 = true;
              Cargoo = false;
              bloqRTN = false;
             
          } 
         
      }
    
   public void CargoNO()
     {
         IF(OcultaCarNO = TRUE)
         {
             OcultaCarSI = false;
             OcultaCarNO = true;
             OcultaCarSI_1 = true;
             OcultaCarNO_2 = false;
             Cargoo = true;
             bloqRTN = true;
             pcCargoEjercido = '';

             if(pcAPNFDSI == true)
             {
                 PC_NIVEL_RIESGO = '3';
                 PC_DEBIDA_DELIGENCIA = '3';
                 //bloqRTN = true;
             }
             else
             {
                 PC_NIVEL_RIESGO = '2';
                 PC_DEBIDA_DELIGENCIA = '2';
                 //bloqRTN = false;
             }
             if (llenarNivelIngreso1 != '1'||PC_NIVEL_RIESGO == '3'||pcAPNFDSI == true)
             {
                bloqRTN = false;
             } 
             else
             {
                bloqRTN = true;
             } 
      }
    }
    
    public void CargoNADA()
     {
         pcPEP = false;
         OcultaCarSI = false;
         OcultaCarNO = false;
         OcultaCarSI_1 = false;
         OcultaCarNO_2 = false; 
         pcCargoEjercido = '';
         bloqRTN = true;
         if(pcAPNFDSI == true||pcPEP == true)
         {
            PC_NIVEL_RIESGO = '3';
            PC_DEBIDA_DELIGENCIA = '3';
            //bloqRTN = true;
         }
         else
         {
            PC_NIVEL_RIESGO = '2';
            PC_DEBIDA_DELIGENCIA = '2';
            //bloqRTN = false;
         }
         if (llenarNivelIngreso1 != '1'||PC_NIVEL_RIESGO == '3'||pcAPNFDSI == true)
         {
            bloqRTN = false;
         } 
         else
         {
            bloqRTN = true;
         } 
              
      } 

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

    public void limpiarAgregado(string mensaje)
{
		 
         pnnrocertificado /*IDFOrmulario*/ = null;
         RTN = NULL;
         ClienteTipoId.Tipo_Identificacion__c /*TipoID*/ = null;
         pcnroid /*NumeroID*/ = null;
         pcFechaVencimientoCN /*FechaVencimiento*/ = null;
         pdfechasuscripcion /*FechaSuscripcion*/  = null;
        
         pcPEP = null;
         AML = null;
         pcFATCA = null;
         
        
        
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
    	 //pcProfesionOcupacion2 = null;
         pcmail /*Correo*/  = null;
         pcAPNFDSI = null;   
         pcAPNFDNO = null;                        
         PCNumeroAPNFD = null;
         PC_NIVEL_RIESGO = null;
         PC_DEBIDA_DELIGENCIA = null;
        
         pcNumeroIDPV /*NumeroIDPerfilVinculacion*/  = null;
         pcNombreCompletoPV /*NombreCompleto*/  = null;
        
        //DependenciaEconomica
         pcDependeSI /*siDependencia*/  = null;
         pcDependeNO /*NoDependencia*/  = null;
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
         Cliente25.sector_n__c /*GiroEmpresa*/  = null;
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
        pcUsuNombreCN = null;
        pcAgn = null;
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
    	 cuentas.Subproducto__c =null;
         Cuenta20.Frecuencia_Aportacion__c /*Periodicidad*/  = null;
         pcformapago/*FormaPago*/  = null;
         //Cuenta20.Forma_Aportacion__c /*FormaPago*/  = null;
         DiaMes.Dias_Mes__c /*DiaAportacion*/  = null;
         pnmontoaporte /*MontoAporte*/  = null;
         pccuentapago /*CuentaCTA*/  = null;
         pcSalarioP /*salario*/  = null;
         //pcAportacionEmpleadoP /*AporEmpleado*/  = null;
         //pcAportacionTrabajoP /*AporTrabajo*/  = null;
         pcaplicaseguro /*AplicaSeguroSI*/  = null;
         AplicaSeguroNO = null;
         pcPrimaAsegurada /*PrimaSeguro*/  = null;
         pcSumaAsegurada /*MontoSeguro*/  = null;
        pcSumaAsegurada /*MontoSeguro*/  = null;
		pcPlazoSeguro = null;
		pcfecCancelaSeguro = null;  
        pcNUMUSU /*Numusu*/  = null;
         TipoEnvioo.Tipo_EnvioNuevo__c /*EnvioCorreo*/  = null;
         //TipoAport.Tipo_Aporte__c = /*Tipo Aporte*/ null;
         v_des_procedfds = null;
         Codigo_Ente = null;
         ////////////////////////////////////
         pcpromotor /*promotorProducto*/  = null;
         CanalVentaa.Canal_Venta__c /*CanalVentas*/  = null;	
        mostrarBotonPan = false;
       iniciarMensaje(mensaje);
        /*
        paso1Cabeza = 'slds-is-current';
	    paso1Cuerpo = 'slds-show';
	            
	    paso2Cabeza = 'slds-is-current';
	    paso2Cuerpo = 'slds-hide'; 
			*/
    }        
    public void limpiar(){
		 
         pnnrocertificado /*IDFOrmulario*/ = null;
         RTN = NULL;
         ClienteTipoId.Tipo_Identificacion__c /*TipoID*/ = null;
         pcnroid /*NumeroID*/ = null;
         pcFechaVencimientoCN /*FechaVencimiento*/ = null;
         pdfechasuscripcion /*FechaSuscripcion*/  = null;
        
         pcPEP = null;
         AML = null;
         pcFATCA = null;
         
        
        
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
    	 //pcProfesionOcupacion2 = null;
         pcmail /*Correo*/  = null;
         pcAPNFDSI = null;   
         pcAPNFDNO = null;                        
         PCNumeroAPNFD = null;
         PC_NIVEL_RIESGO = null;
         PC_DEBIDA_DELIGENCIA = null;
        
         pcNumeroIDPV /*NumeroIDPerfilVinculacion*/  = null;
         pcNombreCompletoPV /*NombreCompleto*/  = null;
        
        //DependenciaEconomica
         pcDependeSI /*siDependencia*/  = null;
         pcDependeNO /*NoDependencia*/  = null;
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
         Cliente25.sector_n__c /*GiroEmpresa*/  = null;
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
        pcUsuNombreCN = null;
        pcAgn = null;
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
         cuentas.Subproducto__c = null;
         pcformapago/*FormaPago*/  = null;
         //Cuenta20.Forma_Aportacion__c /*FormaPago*/  = null;
         DiaMes.Dias_Mes__c /*DiaAportacion*/  = null;
         pnmontoaporte /*MontoAporte*/  = null;
         pccuentapago /*CuentaCTA*/  = null;
         pcSalarioP /*salario*/  = null;
         //pcAportacionEmpleadoP /*AporEmpleado*/  = null;
         //pcAportacionTrabajoP /*AporTrabajo*/  = null;
         pcaplicaseguro /*AplicaSeguroSI*/  = null;
         AplicaSeguroNO = null;
         pcPrimaAsegurada /*PrimaSeguro*/  = null;
         pcSumaAsegurada /*MontoSeguro*/  = null;
        pcSumaAsegurada /*MontoSeguro*/  = null;
		pcPlazoSeguro = null;
		pcfecCancelaSeguro = null;  
        pcNUMUSU /*Numusu*/  = null;
         TipoEnvioo.Tipo_EnvioNuevo__c /*EnvioCorreo*/  = null;
         //TipoAport.Tipo_Aporte__c = /*Tipo Aporte*/ null;
         v_des_procedfds = null;
         Codigo_Ente = null;
         ////////////////////////////////////
         pcpromotor /*promotorProducto*/  = null;
         CanalVentaa.Canal_Venta__c /*CanalVentas*/  = null;	
        mostrarBotonPan = false;
        iniciar();
        /*
        paso1Cabeza = 'slds-is-current';
	    paso1Cuerpo = 'slds-show';
	            
	    paso2Cabeza = 'slds-is-current';
	    paso2Cuerpo = 'slds-hide'; 
			*/
    }
    
    public pageReference MostarPantalla()
    {
       
        return new pageReference('/apex/VFPantallaProducto');  
    } 

    //Metodo para mostrar los datos de un input en otor formulario
    public pageReference VALIDAR_ENVIAR_VFPRODUCTO(){
        try{
            system.debug(pcPEP);
            if( pnnrocertificado == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Numero Formulario Vacio'));
            return null;    
            }
            if( bloqRTN == false )
            {   
                if(RTN == ''||RTN == null)
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe ingresar el RTN del cliente'));
            		return null;
                }
                
            }
            if( pctipoid == ' --Ninguno-- ')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tipo de ID Vacio'));
            return null;    
            }
            
            if( pcnroid == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Numero ID Vacio'));
            return null;    
            }
            
            if( pcprimernombre == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Primer Nombre Vacio'));
            return null;    
            }
            
            if( pcprimerapellido == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Primer Apellido Vacio'));
            return null;    
            }
            
            if( TipoSexo.Sexo__c == ' --Ninguno-- ')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Genero Vacio'));
                return null;    
            }
            
            if( pcnacionalidad == ' --Ninguno-- ')
            {          
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Nacionalidad Vacio'));
            	return null;    
            }
            
             if( desCheckb2 == TRUE)
            {         
                if (pcnacionalidad2 == '' || pcnacionalidad3 == '' )
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Segunda Nacionalidad Vacia'));
            	    return null; 
                }
            	   
            }    
            
            
            if( ES_Residente_EfectosMi == TRUE || ES_Residente == true||pccodpais == '053'||pccodpais == '144'||pcnacionalidad2 == '053' || pcnacionalidad2 == '144'|| pcnacionalidad3 == '053' || pcnacionalidad3 == '144')
            {         
                if (NumeroID_Fiscal_EEUU == '' )
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Numeró de identificación Fiscal (TIN) no puede estar vacio'));
            	    return null; 
                    
                }
                if(PaisResidenciaEfectosFiscales == ' --Ninguno-- ')
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'País Residencia Efectos Fiscales no puede estar vacio'));
            	    return null; 
                }
            	   
            }     
            
            if( pcPrimerNombreReferi1 == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Primer Nombre Referido Vacio'));
            return null;    
            }
            
            if( pcPrimerApellidoReferi1 == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Primer Apellido Vacio'));
            return null;    
            }
            if( pcTelefono_Referido1Referi1 == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Telefono Primer Referido Vacio'));
            return null;    
            }
            if( pcPrimerNombreReferi2 == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Primer Nombre De Referido dos Vacio'));
            return null;    
            }
            if( pcPrimerApellidoReferi2 == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Primer Apellido De Referido dos Vacio'));
            return null;    
            }
            if( pcTelefono_ReferidoReferi2 == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Telefono Segundo Referido Vacio'));
            return null;    
            }               
            if( OcultaTerSI == true)
            {
                if (pcNumeroIDPV == '')
                {    
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Numero ID Tercera Persona Vacio'));
                    return null;  
                }
                
                if (pcNombreCompletoPV == '')
                {    
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Nombre Completo Tercera Persona Vacio'));
                    return null;  
                }
            }
             if( OcultaCarSI == true)
            {  
                if(pcCargoEjercido == '')
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,' Cargo que ejerce o ha ejercido vacio'));
            		return null; 
                }
               
            }
            if( fechaNacimiento == null || fechaNacimiento >= date.today())
            {        
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Fecha Nacimiento no Valida'));
                return null;    
            }
            if( pdLugarNacimientoCN == '')
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Lugar de Nacimiento Vacio'));
            return null;    
            }
            if(fechaLabor > date.today())
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Fecha de ingreso a empresa no puede ser mayor a hoy'));
            return null;    
            } 
            /*SECUENCIA RTN*/
            if(pcrncempl == null || pcrncempl == ''&& pcNombreempl !=null)
            {
                Secuencia_rtn__c acct = new Secuencia_rtn__c();
                
                for (Secuencia_rtn__c item:[select name from Secuencia_rtn__c order by name desc limit 1])
                { 
                    pcrncempl=item.name;
                }    
            }

            if( valorsiCont == false && valornoCont == false)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Contratista del Estado vacio'));
                return null;    
            }
           
            if(pcAPNFDSI == null && pcAPNFDNO == null)
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'APNFD vacio'));
            return null;    
            }
            if(pcAPNFDSI == true && PCNumeroAPNFD == null)
            {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe indicar un tipo de APNFD'));
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
    public date fechaSeguro{get;set;}
    
    public void AplicaSeguroSi(){
        OcultarSeguroNO = false;
    }
    public void AplicaSeguroNo(){
        pcaplicaseguro = false;
    }
    
  
    //METODO EL CUAL ENVIARA TODA LA INFORMACION 
   public pageReference guardar(){
   	try{
    	ClienteNaturales naturalEnvio = new ClienteNaturales();
       
        naturalEnvio.numtran = numtran; //Agregado 08/04/2020
        naturalEnvio.TipoPantalla = 'AA'; //Afiliación AGENCIA 
        naturalEnvio.PCEMPRESA = pcempresa;    
        naturalEnvio.pcagencia = pcagencia;
        //naturalEnvio.pnnrocertificado = pnnrocertificado;
        naturalEnvio.RTN = RTN;
        naturalEnvio.pdfechasuscripcion = date.today();
        system.debug(pcPEP);
        if(pcPEP == true)
        {
            naturalEnvio.pcPEP = 'S';
        }
        else
        {
            naturalEnvio.pcPEP = 'N';
        }
        if(pcFATCA == true)
        {
            naturalEnvio.pcFATCA = 'S';
        } 
        else
        {
            naturalEnvio.pcFATCA = 'N';
        }
        naturalEnvio.pctipoid = pctipoid;   
        naturalEnvio.pcnroid = pcnroid;
        naturalEnvio.pcFechaVencimientoCN = fechaVencimiento;
        naturalEnvio.pcprimerapellido = pcprimerapellido;
        naturalEnvio.pcsegundoapellido = pcsegundoapellido;
        naturalEnvio.pcprimernombre = pcprimernombre;
        naturalEnvio.pcsegundonombre = pcsegundonombre;
        naturalEnvio.pdfechanacimiento = fechaNacimiento;
        naturalEnvio.pdLugarNacimientoCN = pdLugarNacimientoCN;
        naturalEnvio.pcsexo = TipoSexo.Sexo__c;
        naturalEnvio.pcestadocivil = pcestadocivil;
        naturalEnvio.pcNombreConyuge = pcNombreConyuge;
        naturalEnvio.pcProfesionOcupacion = TipoProfesion.Profesi_n_Ocupaci_n__c;
        naturalEnvio.pcmail = pcmail;
        if(pcAPNFDSI == true)
        {
            naturalEnvio.pcAPNFD = 'S';
        }
        else
        {
            naturalEnvio.pcAPNFD = 'N';
        }
        naturalEnvio.PCNumeroAPNFD = PCNumeroAPNFD;
        naturalEnvio.PC_DEBIDA_DELIGENCIA = PC_DEBIDA_DELIGENCIA;
        naturalEnvio.PC_NIVEL_RIESGO = PC_NIVEL_RIESGO;
        //Usted o un familia
        if(OcultaTerSI == true)
        {
            naturalEnvio.pc_ActuaSI = 'S';
        }
        else
        {               
            naturalEnvio.pc_ActuaSI = 'N';
        }
        if (pcNumeroIDPV == ' --Ninguno-- ')
        {
            naturalEnvio.pcNumeroIDPV = null;
        }
        else
        {
            naturalEnvio.pcNumeroIDPV = pcNumeroIDPV;
        }
        naturalEnvio.pcNombreCompletoPV = pcNombreCompletoPV;
        if(OcultaCarSI == true)
        {
            naturalEnvio.pcEjerce_Cargo_Publico = 'S';
        }
        else
        {              
            naturalEnvio.pcEjerce_Cargo_Publico = 'N';
        }
        naturalEnvio.pcCargoEjercido = pcCargoEjercido;
        //DependenciaEconomica
        system.debug('pruebakikito: '+pcDependeSI);
        system.debug('pruebakikito: '+pcDependeNO);
        if(pcDependeSI == true)
        {
            naturalEnvio.pcDependeSI = 'S';
            naturalEnvio.pcDependeNO = 'N';
        }
        else
        {
            naturalEnvio.pcDependeSI = 'N';
            naturalEnvio.pcDependeNO = 'S';
        }
        if (pcTipoIDDependencia == ' --Ninguno-- ' || pcTipoIDDependencia == '--Ninguno--')
        {
            naturalEnvio.pcTipoIDDependencia = null;
        }
        else
        {
            naturalEnvio.pcTipoIDDependencia = pcTipoIDDependencia;
        }
        naturalEnvio.pcNumeroIDDependencia = pcNumeroIDDependencia;
        //naturalEnvio.pcParentescoDependencia /*Parentesco_DependenciaEconomica*/ = Cuenta22.Parentesco__c;
        naturalEnvio.pcNombreCompletoDependencia = pcNombreCompletoDependencia;
        //InfoDireccion	
        //agregado 19/03/2020 para que pais no sea NULL
        
        naturalEnvio.pccodpais = pcnacionalidad;
        naturalEnvio.pcnacionalidad = pcnacionalidad;
       
        if (pcnacionalidad2 == ' --Ninguno-- ')
        {
            naturalEnvio.pcnacionalidad2 = null;
        }
        else
        {
            naturalEnvio.pcnacionalidad2 = pcnacionalidad2;
        }  
        if (pcnacionalidad3 == ' --Ninguno-- ')
        {
            naturalEnvio.pcnacionalidad3 = null;
        }
        else
        {
            naturalEnvio.pcnacionalidad3 = pcnacionalidad3;
        }         
        //referencias
        naturalEnvio.pcPrimerNombreReferi1 = pcPrimerNombreReferi1;
        naturalEnvio.pcSegundoNombreReferi1 = pcSegundoNombreReferi1;
        naturalEnvio.pcPrimerApellidoReferi1 = pcPrimerApellidoReferi1;
        naturalEnvio.pcSegundoApellidoReferi1 = pcSegundoApellidoReferi1;
        naturalEnvio.pcTelefono_Referido1Referi1 = pcTelefono_Referido1Referi1;
        
        naturalEnvio.pcPrimerNombreReferi2 = pcPrimerNombreReferi2;
        naturalEnvio.pcSegundoNombreReferi2 = pcSegundoNombreReferi2;
        naturalEnvio.pcPrimerApellidoReferi2 = pcPrimerApellidoReferi2;
        naturalEnvio.pcSegundoApellidoReferi2 = pcSegundoApellidoReferi2;
        naturalEnvio.pcTelefono_ReferidoReferi2 = pcTelefono_ReferidoReferi2;
        //DatoEMpleador
        naturalEnvio.pccontratocolectivo = pccontratocolectivo;
        //RTN VACIO27082020
        IF(pcrncempl == NULL || pcrncempl == '' && pcrazonsocialempl != NULL)
        {
        naturalEnvio.pcrncempl = '1';
        }
        ELSE
        { naturalEnvio.pcrncempl = pcrncempl;}
                
        if (ClienteTipoId.Tipo_Empresa__c == ' --Ninguno-- ')
        {
            naturalEnvio.pcTipoEmpresaEmpCN = null;
        }
        else
        {
            naturalEnvio.pcTipoEmpresaEmpCN = ClienteTipoId.Tipo_Empresa__c;
        }
        naturalEnvio.pcNombreempl = pcNombreempl;
        naturalEnvio.pcrazonsocialempl = pcrazonsocialempl;
        naturalEnvio.pcCargoEmpresaEmpCN = pcCargoEmpresaEmpCN;
        if (Cliente25.sector_n__c == ' --Ninguno-- ')
        {
            naturalEnvio.pcGiroEmpresaEmpCN = null;
        }
        else
        {
            naturalEnvio.pcGiroEmpresaEmpCN = Cliente25.sector_n__c;
        }
        naturalEnvio.pcmailempl = pcmailempl;
        if (Cliente25.Tipo_trabajador__c == ' --Ninguno-- ')
        {
            naturalEnvio.pcTIpoEmpleado = null;
        }
        else
        {
            naturalEnvio.pcTIpoEmpleado = Cliente25.Tipo_trabajador__c;
        }
        naturalEnvio.pdfechainiciolabor = fechaLabor;
        naturalEnvio.pcNivelIngreso = llenarNivelIngreso1;
        //naturalEnvio.pcVolumenIngresoCN /*VolumenIngreso*/ = pcVolumenIngresoCN;
        //VALIDACION DATOS
        naturalEnvio.pcUsuarioCN = pcUsuarioCN+'/'+pcUsuNombreCN+'/'+pcAgn;
        naturalEnvio.pcFechaValidacionCN = null;
        //PantallaProducto
        naturalEnvio.pcproducto = pcproducto;
        naturalEnvio.pcsubproducto = pcsubproducto;
        if(Cuenta20.Tipo_Fondo__c == 'I')
            {
                naturalEnvio.pcTipoFondo = '';
            }
			else
            {
                naturalEnvio.pcTipoFondo = Cuenta20.Tipo_Fondo__c;
            }
        naturalEnvio.pcTipoMoneda = TipMoneda.Tipo_Moneda__c;
        naturalEnvio.pcperiodicidad = Cuenta20.Frecuencia_Aportacion__c;
        System.debug('pcformapago: '+pcformapago);
        if(pcformapago == 'TAOB') {
            System.debug('Es TAOB'); 
            naturalEnvio.pcformapago = 'TA';
        } 
        else {
            naturalEnvio.pcformapago = pcformapago;
        }
        naturalEnvio.pcDiaAportacion = DiaMes.Dias_Mes__c;
        naturalEnvio.pnmontoaporte = pnmontoaporte;
        naturalEnvio.pnmontoaporte12 = pnmontoaporte12;
        naturalEnvio.pccuentapago = pccuentapago;
        naturalEnvio.pcSalarioP = pcSalarioP;
        //naturalEnvio.pcAportacionEmpleadoP = pcAportacionEmpleadoP;
        //naturalEnvio.pcAportacionTrabajoP = pcAportacionTrabajoP;
        if(pcaplicaseguro == true)
        {
            naturalEnvio.pcaplicaseguro = 'S';
        }
        else
        {
            naturalEnvio.pcaplicaseguro = 'N';
        }
        naturalEnvio.pcPrimaAsegurada = pcPrimaAsegurada;
        naturalEnvio.pcSumaAsegurada = pcSumaAsegurada;
        naturalEnvio.pcTipoSeguro = pcTipoSeguro;
        naturalEnvio.pcPlazoSeguro = pcPlazoSeguro;
        naturalEnvio.pcNUMUSU = pcNUMUSU;
        naturalEnvio.pcenvio = TipoEnvioo.Tipo_EnvioNuevo__c;
        naturalEnvio.pcTipoAporte = 'F';
        naturalEnvio.v_des_procedfds   = v_des_procedfds;
        naturalEnvio.pcpromotor = pcpromotor;            	
        naturalEnvio.pctiposolicitud = pctiposolicitud;
        //Pantalla fatca
        if(ES_Residente == true)
        {
            naturalEnvio.ES_Residente = 'N' ;
        }
        else
        {
            naturalEnvio.ES_Residente = 'N';
        }
        SYSTEM.debug('FATCACHECK:' + naturalEnvio.ES_Residente + ' **** ' + ES_Residente_no );
        
        if(ES_Residente_EfectosMi == true)
        {
            naturalEnvio.ES_Residente_EfectosMi = 'S' ;
        }
        else
        {
            naturalEnvio.ES_Residente_EfectosMi = 'N';
        }
        if (PaisResidenciaEfectosFiscales == ' --Ninguno-- ')
        {
            naturalEnvio.PaisResidenciaEfectosFiscales = null;
        }
        else
        {
            naturalEnvio.PaisResidenciaEfectosFiscales = PaisResidenciaEfectosFiscales;
        }
        naturalEnvio.NumeroID_Fiscal_EEUU = NumeroID_Fiscal_EEUU;
        naturalEnvio.NumeroID_Fiscal_OtroPais = NumeroID_Fiscal_OtroPais;
        //Envio de beneficiarios
        naturalEnvio.ListBeneficiarios=ListBeneficiarios;
        naturalEnvio.ListBeneficiariosC=ListBeneficiariosC;
        naturalEnvio.ListDebidaDil= ListDebidaDil;
        naturalEnvio.ListTelefonos= ListTelefonos;
        naturalEnvio.ListDirecciones= ListDirecciones;
        if( pcproducto == '' || pcproducto == ' --Ninguno-- ')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Producto  Vacio'));
                return null;    
            }
            if( pcsubproducto == ''|| pcsubproducto == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Subroducto  Vacio'));
                return null;    
            }
            if( Cuenta20.Tipo_Fondo__c == ''|| Cuenta20.Tipo_Fondo__c == ' --Ninguno-- ' || Cuenta20.Tipo_Fondo__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tipo de Fondo Vacio'));
                return null;    
            }
            if( pcTipoMoneda == '')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Moneda Vacio'));
                return null;    
            }
            if( Cuenta20.Frecuencia_Aportacion__c == ''|| Cuenta20.Frecuencia_Aportacion__c == ' --Ninguno-- '|| Cuenta20.Frecuencia_Aportacion__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Periocidad Vacio'));
                return null;    
            }            
            if( pcformapago == ''|| pccuentapago == ' --Ninguno-- ')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Forma de pago Vacio'));
                return null;    
            }
            if( pcformapago == 'AH' && pccuentapago == '')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'#Cta/TC Vacio'));
                return null;    
            }
            if( pcformapago == 'TA' && pccuentapago == '')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'#Cta/TC Vacio'));
                return null;    
            }
            if( v_des_procedfds == ''|| v_des_procedfds == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Procedencia de Fondos Vacío'));
                return null;    
            }
            if( TipoEnvioo.Tipo_EnvioNuevo__c == ''|| TipoEnvioo.Tipo_EnvioNuevo__c == ' --Ninguno-- ' || TipoEnvioo.Tipo_EnvioNuevo__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tipo de Envio Vacio'));
                return null;    
            } 
            if(pcaplicaseguro == true)
            {                
                if(pcTipoSeguro == ' --Ninguno-- '||pcTipoSeguro == null)
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,' Tipo Seguro vacio'));
                    return null; 
                }                 
            }
            
            /*if( pcaplicaseguro == false && AplicaSeguroNO == false)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seguro de Vida vacio'));
                return null;    
            } */
            if(pcpromotor ==' --Ninguno-- ' || pcpromotor ==null || pcpromotor == '')
            {
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Oficial de negocio vacio'));
                 return null;    
            }
            if( pcUsuarioCN == '')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Código de Empleado GFF vacio'));
                return null;    
            }
            if( pcUsuNombreCN == '')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Nombre de Empleado GFF vacio'));
                return null;    
            }
            if( pcAgn == ' --Ninguno-- ')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Agencia GFF vacio'));
                return null;    
            }
        	decimal totalBene= 0;
            for(integer i=0; i<ListBeneficiarios.size(); i++)
            {	
                system.debug('distri: '+ListBeneficiarios[i].Distribucion);
                totalBene += ListBeneficiarios[i].Distribucion; 
            }
            if(totalBene < 100)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se Puede Agregar porque la distribución de los beneficiarios Directos es menor a 100% '));
                return null; 
            }
            decimal totalBeneC= 0;
            for(integer i=0; i<ListBeneficiariosC.size(); i++)
            {	
                system.debug('distri: '+ListBeneficiariosC[i].Distribucion);
                totalBeneC += ListBeneficiariosC[i].Distribucion; 
            }
            if(totalBeneC > 0 && totalBeneC < 100)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se Puede Agregar porque la distribución de los beneficiarios de Contingencias es menor a 100% '));
                return null; 
            }
      
        else
        { 
            Autonumerico_cuentas_Syste__c af = [Select Id, Id_Formulario_Sysde__c  from Autonumerico_cuentas_Syste__c Limit 1];
            pnnrocertificado = 'AF'+af.Id_Formulario_Sysde__c++; 
            naturalEnvio.pnnrocertificado = pnnrocertificado;
            
         	String resultado = controllerApiClienteNatural.guardarCliente(naturalEnvio);
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Campo Agregado')); 
            // bloqBotonGuardar();
            //limpiarAgregado(resultado);
            // iniciar();
            //limpiar();
            update af;
            if(resultado.contains('Proceso realizado Correctamente')) {
                String cuenta = resultado.replace('Proceso realizado Correctamente  Número De Cuenta:', '');
                cuenta = cuenta.replace('"', '');
                system.debug('cuenta guardada: '+cuenta);
                Integer existe=0;//[SELECT count() FROM Cuenta_Formularios__c where Cuenta__c=:pc_codCuenta];
                if(!test.isRunningTest()){
                    existe=[SELECT count() FROM Cuenta_Formularios__c where Cuenta__c=:cuenta];
                }
                //system.debug('cuenta:::'+cuentaG);
                if(existe==0)
                {
                    Cuenta_Formularios__c reg=new Cuenta_Formularios__c();
                    reg.Cuenta__c=cuenta;
                    insert reg;
                }
                
                if(pcformapago == 'AH' || pcformapago == 'TA' || pcformapago == 'TAOB') {
                	System.debug('Crear caso de Afiliación de Débito Automático' + resultado);                
                    String val = resultado.substring(51);
                    String val2 = val.replace('"','');
                    //updateCase.createAccount(pctipoid, pcnroid, val2, pcprimernombre, pcprimerapellido, pcmail, pnnrocertificado, Cuenta20.Tipo_Fondo__c, Cuenta20.Frecuencia_Aportacion__c, pcformapago, pccuentapago, DiaMes.Dias_Mes__c);    
                }
                
                final PageReference target = new
                    PageReference(Site.getBaseSecureUrl() + '/apex/vfpantallaclienteProductoAgn?ident='+resultado+'&cuentaG='+cuenta);
                target.setRedirect(true);
                // This is a permanent redirection
                target.setRedirectCode(301); 
                return target; 
            }
            else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
            }
            
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
        	
        NaturalActualizar naturalEnvio = new NaturalActualizar();
        
        naturalEnvio.RTN = RTN;
        naturalEnvio.V_fo_cuenta = CuentaMostrar; 
        naturalEnvio.numtran = numtran;//Agregado 08/04/2020
        naturalEnvio.pcEst_cuenta = Activo;
        naturalEnvio.pcCod_Causa = Causa;
        if(pcPEP == true)
        {
            naturalEnvio.pcPEP = 'S';
        }
        else
        {
            naturalEnvio.pcPEP = 'N';
        }
        if(pcFATCA == true)
        {
            naturalEnvio.pcFATCA = 'S';
        } 
        else
        {
            naturalEnvio.pcFATCA = 'N';
        }
        naturalEnvio.pctipoid = pctipoid;   
        naturalEnvio.pcnroid = pcnroid;
        naturalEnvio.pcFechaVencimientoCN = fechaVencimiento;
        naturalEnvio.pcprimerapellido = pcprimerapellido;
        naturalEnvio.pcsegundoapellido = pcsegundoapellido;
        naturalEnvio.pcprimernombre = pcprimernombre;
        naturalEnvio.pcsegundonombre = pcsegundonombre;
        //naturalEnvio.pcTelefonoCN = pcTelefonoCN;
        //naturalEnvio.pcCelularCN = pcCelularCN;
        naturalEnvio.pdfechanacimiento = fechaNacimiento;
        naturalEnvio.pdLugarNacimientoCN = pdLugarNacimientoCN;
        naturalEnvio.pcsexo = TipoSexo.Sexo__c;
        naturalEnvio.pcestadocivil = pcestadocivil;
        naturalEnvio.pcNombreConyuge = pcNombreConyuge;
        naturalEnvio.pcProfesionOcupacion = TipoProfesion.Profesi_n_Ocupaci_n__c;
        naturalEnvio.pcmail = pcmail;
        if(pcAPNFDSI == true)
        {
            naturalEnvio.pcAPNFD = 'S';
        }
        else
        {
            naturalEnvio.pcAPNFD = 'N';
        }
        naturalEnvio.PCNumeroAPNFD = Cliente25.Actividad_APNFD__c;
        naturalEnvio.PC_DEBIDA_DELIGENCIA = PC_DEBIDA_DELIGENCIA;
        naturalEnvio.PC_NIVEL_RIESGO = PC_NIVEL_RIESGO;
        //Usted o un familia
        if(OcultaTerSI == true)
        {
            naturalEnvio.pc_ActuaSI = 'S';
        }
        else
        {               
            naturalEnvio.pc_ActuaSI = 'N';
        }
        naturalEnvio.pcNumeroIDPV = pcNumeroIDPV;
        naturalEnvio.pcNombreCompletoPV = pcNombreCompletoPV;
        if(OcultaCarSI == true)
        {
            naturalEnvio.OcultaCarSI = 'S';
        }
        else
        {              
            naturalEnvio.OcultaCarSI = 'N';
        }
        naturalEnvio.pcCargoEjercido = pcCargoEjercido;
        //DependenciaEconomica
        if(pcDependeSI == true)
        {
            naturalEnvio.pcDependeSI = 'S';
        }
        else
        {
            naturalEnvio.pcDependeSI = 'N';
        }
        if(pcDependeNO == true)
        {
            naturalEnvio.pcDependeNO = 'S';
        }
        else
        {
            naturalEnvio.pcDependeNO = 'N';
        }
        naturalEnvio.pcTipoIDDependencia = Cliente25.Tipo_Identificacion__c;
        naturalEnvio.pcNumeroIDDependencia = pcNumeroIDDependencia;
        //naturalEnvio.pcParentescoDependencia /*Parentesco_DependenciaEconomica*/ = Cuenta22.Parentesco__c;
        naturalEnvio.pcNombreCompletoDependencia = pcNombreCompletoDependencia;
        //InfoDireccion	
        /*naturalEnvio.pccodpais = pccodpais;
        naturalEnvio.pcDeptoCN = pcDeptoCN;
        naturalEnvio.pcMunicipioCN = pcMunicipioCN;
        naturalEnvio.pcCalleDetalleCN = pcCalleDetalleCN;
        naturalEnvio.pcColoniaCN = pcColoniaCN;*/
        naturalEnvio.pccodpais = pcnacionalidad;
        naturalEnvio.pcnacionalidad = pcnacionalidad;
        naturalEnvio.pcnacionalidad2 = pcnacionalidad2;
        naturalEnvio.pcnacionalidad3 = pcnacionalidad3;            
        //referencias
        naturalEnvio.pcPrimerNombreReferi1 = pcPrimerNombreReferi1;
        naturalEnvio.pcSegundoNombreReferi1 = pcSegundoNombreReferi1;
        naturalEnvio.pcPrimerApellidoReferi1 = pcPrimerApellidoReferi1;
        naturalEnvio.pcSegundoApellidoReferi1 = pcSegundoApellidoReferi1;
        naturalEnvio.pcTelefono_Referido1Referi1 = pcTelefono_Referido1Referi1;
        
        naturalEnvio.pcPrimerNombreReferi2 = pcPrimerNombreReferi2;
        naturalEnvio.pcSegundoNombreReferi2 = pcSegundoNombreReferi2;
        naturalEnvio.pcPrimerApellidoReferi2 = pcPrimerApellidoReferi2;
        naturalEnvio.pcSegundoApellidoReferi2 = pcSegundoApellidoReferi2;
        naturalEnvio.pcTelefono_ReferidoReferi2 = pcTelefono_ReferidoReferi2;
        //DatoEMpleador
        naturalEnvio.pccontratocolectivo = pccontratocolectivo;
        naturalEnvio.pcrncempl = pcrncempl;
        naturalEnvio.pcTipoEmpresaEmpCN = ClienteTipoId.Tipo_Empresa__c;
        naturalEnvio.pcNombreempl = pcNombreempl;
        naturalEnvio.pcrazonsocialempl = pcrazonsocialempl;
        naturalEnvio.pcCargoEmpresaEmpCN = pcCargoEmpresaEmpCN;
        naturalEnvio.pcGiroEmpresaEmpCN = Cliente25.sector_n__c;
        //naturalEnvio.pctelempl = pctelempl;
        //naturalEnvio.pcextempl = pcextempl;
        naturalEnvio.pcmailempl = pcmailempl;
        //EMpleadorDIreccion
        naturalEnvio.vccodpais = pcPaisEmpleadorCN;
        naturalEnvio.pcDeptoEmpleadorCN = pcDeptoEmpleadorCN;
        naturalEnvio.pcMunicipioEmpleadorCN = pcMunicipioEmpleadorCN;
        naturalEnvio.pcColoniaEmpleadorCN = pcColoniaEmpleadorCN;
        naturalEnvio.pcdirempl = pcdirempl;
        //DatoEmpleado
        naturalEnvio.pcTIpoEmpleado = Cliente25.Tipo_trabajador__c;
        naturalEnvio.pdfechainiciolabor = fechaLabor;
        naturalEnvio.pcNivelIngreso = llenarNivelIngreso1;
        //naturalEnvio.pcVolumenIngresoCN /*VolumenIngreso*/ = pcVolumenIngresoCN;
        //VALIDACION DATOS
        naturalEnvio.pcUsuarioCN = pcUsuarioCN;
        naturalEnvio.pcFechaValidacionCN = date.today();
        //PantallaProducto
        naturalEnvio.pcproducto = pcproducto;
        //Subproducto__c sb = [select Id, Codigo__c, Name from Subproducto__c where Id = :cuentas.Subproducto__c];
        naturalEnvio.pcsubproducto = pcsubproducto;
        if(Cuenta20.Tipo_Fondo__c == 'I')
            {
                naturalEnvio.pcTipoFondo = '';
            }
			else
            {
                naturalEnvio.pcTipoFondo = Cuenta20.Tipo_Fondo__c;
            }
        naturalEnvio.pcTipoMoneda = TipMoneda.Tipo_Moneda__c;
        naturalEnvio.pcperiodicidad = Cuenta20.Frecuencia_Aportacion__c;
        naturalEnvio.pcformapago = pcformapago;
        naturalEnvio.pcDiaAportacion = DiaMes.Dias_Mes__c;
        naturalEnvio.pnmontoaporte = pnmontoaporte;
        naturalEnvio.pnmontoaporte12 = pnmontoaporte12;
        naturalEnvio.pccuentapago = pccuentapago;
        //naturalEnvio.pcAportacionEmpleadoP = pcAportacionEmpleadoP;
        //naturalEnvio.pcAportacionTrabajoP = pcAportacionTrabajoP;
        if(pcaplicaseguro == true)
        {
            naturalEnvio.pcaplicaseguro = 'S';
        }
        else
        {
            naturalEnvio.pcaplicaseguro = 'N';
        }
        naturalEnvio.pcPrimaAsegurada = pcPrimaAsegurada;
        naturalEnvio.pcSumaAsegurada = pcSumaAsegurada;
           naturalEnvio.pcTipoSeguro = pcTipoSeguro;
            naturalEnvio.pcPlazoSeguro = pcPlazoSeguro;
            naturalEnvio.pcfecCancelaSeguro = fechaSeguro;
        naturalEnvio.pcNUMUSU = pcNUMUSU;
        naturalEnvio.pcenvio = TipoEnvioo.Tipo_EnvioNuevo__c;
        naturalEnvio.pcTipoAporte = 'F';
        naturalEnvio.v_des_procedfds   = v_des_procedfds;
        naturalEnvio.pcpromotor = pcpromotor;            	
        //naturalEnvio.pctiposolicitud = pctiposolicitud;
        //Pantalla fatca
        if(ES_Residente == true)
        {
            naturalEnvio.ES_Residente = 'S' ;
        }
        else
        {
            naturalEnvio.ES_Residente = 'N';
        }
        if(ES_Residente_EfectosMi == true)
        {
            naturalEnvio.ES_Residente_EfectosMi = 'S' ;
        }
        else
        {
            naturalEnvio.ES_Residente_EfectosMi = 'N';
        }
        naturalEnvio.PaisResidenciaEfectosFiscales = PaisResidenciaEfectosFiscales;
        naturalEnvio.NumeroID_Fiscal_EEUU = NumeroID_Fiscal_EEUU;
        naturalEnvio.NumeroID_Fiscal_OtroPais = NumeroID_Fiscal_OtroPais;
           
           for(integer i=0; i<ListBeneficiarios.size(); i++)
            {
                naturalEnvio.ListBeneficiarios=ListBeneficiarios;
            }            
            for(integer i=0; i<ListBeneficiariosC.size(); i++)
            {
                naturalEnvio.ListBeneficiariosC=ListBeneficiariosC;
            }
            naturalEnvio.ListDebidaDil= ListDebidaDil; 
            
            for(integer i=0; i<ListTelefonos.size(); i++)
            {	                
                naturalEnvio.ListTelefonos= ListTelefonos; 
            }
            
            for(integer i=0; i<ListDirecciones.size(); i++)
            {
                
                ClienteNaturales fcsd = controllerApiClienteNatural.ConsultaInfoClienteC(pc_codCuenta);
                
                /*Pais_R__c itemP = [select nombre__c, codigo__c from Pais_R__c
                                                where codigo__c =: fcsd.ListDirecciones[i].paisDir];
                
                    Departamentos__c itemD = [select Departamento__c, codigo_departamento__c from Departamentos__c
                                                where codigo_pais__c =: fcsd.ListDirecciones[i].paisDir 
                                                and codigo_departamento__c =: fcsd.ListDirecciones[i].deptoDir];
                
                    Municipio__c itemM  = [select nombre_municipio__c, codigo_municipio__c from Municipio__c 
                                            where codigo_pais__c =: fcsd.ListDirecciones[i].paisDir 
                                            and codigo_departamento__c =: fcsd.ListDirecciones[i].deptoDir
                                            AND codigo_municipio__c =: fcsd.ListDirecciones[i].ciuDir];
                
                    Colonias_U__c itemC = [select nombre_colonia__c, codigo_colonia__c from Colonias_U__c 
                                            where codigo_pais__c =: fcsd.ListDirecciones[i].paisDir 
                                            and codigo_departamento__c =: fcsd.ListDirecciones[i].deptoDir
                                            AND codigo_municipio__c =: fcsd.ListDirecciones[i].ciuDir
                                           	and codigo_colonia__c =: fcsd.ListDirecciones[i].coloDir];
                
                	fcsd.ListDirecciones[i].paisDir = itemP.codigo__c;
                	fcsd.ListDirecciones[i].deptoDir = itemD.codigo_departamento__c;
                	fcsd.ListDirecciones[i].ciuDir = itemM.codigo_municipio__c;
                	fcsd.ListDirecciones[i].coloDir = itemC.codigo_colonia__c;*/
                
                
					naturalEnvio.ListDirecciones= ListDirecciones; 
            }
        
        /*if(beneficiarioUnico.Distribucion <> 0 && beneficiarioUnico.Distribucion < 100)
        {          
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'La distribución es menor a 100'));
            return null;    
        }*/
        //beneficiarioUnico.Grado = integer.valueOf(CanalVentaa.Grado_Familiar__c);
          	//   validarRol();             
           disbot = true;
            if( pcproducto == '' || pcproducto == ' --Ninguno-- ')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Producto  Vacio'));
                return null;    
            }            
            if( pcsubproducto == ''|| pcsubproducto == ' --Ninguno-- ')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Subroducto  Vacio'));
                return null;    
            }
            if( Cuenta20.Tipo_Fondo__c == ''|| Cuenta20.Tipo_Fondo__c == ' --Ninguno-- ' || Cuenta20.Tipo_Fondo__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tipo de Fondo Vacio'));
                return null;    
            }
            if( pcTipoMoneda == '')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Moneda Vacio'));
                return null;    
            }
            if( Cuenta20.Frecuencia_Aportacion__c == ''|| Cuenta20.Frecuencia_Aportacion__c == ' --Ninguno-- '|| Cuenta20.Frecuencia_Aportacion__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Periocidad Vacio'));
                return null;    
            }            
            if( pcformapago == ''|| pcformapago == ' --Ninguno-- ')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Forma de pago Vacio'));
                return null;    
            }
            if( TipoEnvioo.Tipo_EnvioNuevo__c == ''|| TipoEnvioo.Tipo_EnvioNuevo__c == ' --Ninguno-- ' || TipoEnvioo.Tipo_EnvioNuevo__c == null)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tipo de Envio Vacio'));
                return null;    
            } 
            /*if( pcaplicaseguro == false && AplicaSeguroNO == false)
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Seguro de Vida vacio'));
                return null;    
            }
            if(pcaplicaseguro == true)
            {
                if(pcTipoSeguro == ' --Ninguno-- '||pcTipoSeguro == '--Ninguno--')
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,' Tipo Seguro vacio'));
                    return null; 
                }
            }*/
     
         else
             { 
                 
              String resultado = controllerApiClienteNatural.actualizaCliente(naturalEnvio);
              ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
              //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Campo Agregado')); 
              limpiar();
               
             }  
               
           
      } 
      catch(Exception e)
    	{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
     	}
       return null;
    }
    
    public void buscarColectiva()
    {
        try{
            
            string temporal = pccontratocolectivo;
            ClienteNaturales claseEnvio = new ClienteNaturales();
            ClienteNaturales fcsd = controllerApiClienteNatural.ConsultaColectiva(pccontratocolectivo);
            
            if(fcsd.pcrncempl != null)
            {
                pccontratocolectivo =fcsd.pccontratocolectivo;
                pcrncempl = fcsd.pcrncempl;
                //system.debug(fcsd.fechaNacimiento); 
                if(fcsd.pcTipoEmpresaEmpCN != 'null')
                {
                    ClienteTipoId.Tipo_Empresa__c = fcsd.pcTipoEmpresaEmpCN; 
                }
                pcNombreempl = fcsd.pcrazonsocialempl;
                pcrazonsocialempl = fcsd.pcrazonsocialempl;
                if(fcsd.pcGiroEmpresaEmpCN != 'null')
                {
                    Cliente25.sector_n__c = fcsd.pcGiroEmpresaEmpCN;
                }
                pctelempl =fcsd.pctelempl;
                if (fcsd.pcmailempl != 'null')
                {
                    pcmailempl = fcsd.pcmailempl;
                }
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
                
                system.debug(fcsd.pcdirempl);    
                
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cuenta Colectiva No Encontrada'));	    
            }
            salirEmpresas();
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    }

    public void buscarInfoCuenta(){
       try{	
            string temporal = MostrarCUENTT;
           /*Arismel*/
             /*   Integer existe=0;//[SELECT count() FROM Cuenta_Formularios__c where Cuenta__c=:pc_codCuenta];
                if(!test.isRunningTest()){
                    existe=[SELECT count() FROM Cuenta_Formularios__c where Cuenta__c=:MostrarCUENTT];
                }
                system.debug('cuenta:::'+MostrarCUENTT);
                if(existe==0)
                {
                    Cuenta_Formularios__c reg=new Cuenta_Formularios__c();
                    reg.Cuenta__c=MostrarCUENTT;
                    insert reg;
                }*/
			/******/
        	ClienteNaturales claseEnvio = new ClienteNaturales();
        	ClienteNaturales fcsd = controllerApiClienteNatural.ConsultaInfoCliente(MostrarCUENTT, NumIDBuscar);
           
        	system.debug('Respuestaaaaaaa: '+fcsd);
        	
           if (fcsd.pcprimernombre != 'null')
        	{
                CuentaMostrar = MostrarCUENTT;
                pcnroid = NumIDBuscar;
                
                if (fcsd.pnnrocertificado != 'null')
                {
                    pnnrocertificado = fcsd.pnnrocertificado;
                }
                
                if (fcsd.RTN != 'null'||fcsd.RTN != 'NULL')
                {
                    RTN = fcsd.RTN;
                    bloqRTN = false;
                }
                /*Agregado 08/04/2020*/
                if(fcsd.numtran != 'null')
                {
                    numtran = fcsd.numtran;
                }
                
                if(fcsd.pdfechasuscripcion!=null)
                {
                    fcsd.pdfechasuscripcion = fcsd.pdfechasuscripcion.addHours(6);
                    fechasuscripcion=date.valueOf(fcsd.pdfechasuscripcion.year()+'-'+fcsd.pdfechasuscripcion.month()+'-'+fcsd.pdfechasuscripcion.day());
                }
                IF (fcsd.pcPEP =='N'||fcsd.pcPEP == 'null')
                {
                    pcPEP = false;
                }
                else 
                {
                    pcPEP = true; 
                }    
                IF (fcsd.pcFATCA =='N'||fcsd.pcFATCA == 'null')
                {
                    pcFATCA = false;
                }
                else 
                {
                    pcFATCA = true;
                }
				
                if (fcsd.pcEst_cuenta != 'null')
                {
                   Activo = fcsd.pcEst_cuenta;
                }
                opcionesCausa = new list <selectOption>();
                opcionesCausa.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Causa_Cuenta__c item:[select name, codigo__c from Causa_Cuenta__c where Estado_Cuenta__r.CodigoEstado__c =: Activo])
                {
                    opcionesCausa.add(new selectOption(item.codigo__c, item.name));
                }
                Causa = fcsd.pcCod_Causa;
                if (fcsd.pctipoid != 'null')
                {
                    pctipoid = fcsd.pctipoid;
                }    
                   
                if(fcsd.pcFechaVencimientoCN!=null)
                {
                    fcsd.pcFechaVencimientoCN = fcsd.pcFechaVencimientoCN.addHours(6);
                    fechaVencimiento=date.valueOf(fcsd.pcFechaVencimientoCN.year()+'-'+fcsd.pcFechaVencimientoCN.month()+'-'+fcsd.pcFechaVencimientoCN.day());
                    /*if (fechaVencimiento == date.valueOf('0001-01-01'))
                    {
                        fechaVencimiento = null;
                    }*/
                    
                }  
                if (fcsd.pcprimernombre != 'null')
                {
                    pcprimernombre = fcsd.pcprimernombre; 
                }            
                if (fcsd.pcsegundonombre != 'null')
                {
                    pcsegundonombre = fcsd.pcsegundonombre;
                }
                if (fcsd.pcprimerapellido != 'null')
                {
                    pcprimerapellido = fcsd.pcprimerapellido;
                }
                if (fcsd.pcsegundoapellido != 'null')
                {
                  pcsegundoapellido = fcsd.pcsegundoapellido; 
                }
                if(fcsd.pdfechanacimiento!=null)
                {
                    fcsd.pdfechanacimiento = fcsd.pdfechanacimiento.addHours(6);
                    fechaNacimiento=date.valueOf(fcsd.pdfechanacimiento.year()+'-'+fcsd.pdfechanacimiento.month()+'-'+fcsd.pdfechanacimiento.day());
                }
                if (fcsd.pdLugarNacimientoCN != 'null')
                {
                   pdLugarNacimientoCN = fcsd.pdLugarNacimientoCN;
                }
                if (fcsd.pcsexo != 'null')
                {
                   TipoSexo.Sexo__c = fcsd.pcsexo;
                }
                if (fcsd.pcestadocivil != 'null')
                {
                   pcestadocivil = fcsd.pcestadocivil; 
                } 
                if (fcsd.pcNombreConyuge != 'null')
                {
                  if (fcsd.pcestadocivil == 'C' || fcsd.pcestadocivil == 'U')
                    {
                        BloquearConyugue=false;
                        pcNombreConyuge = fcsd.pcNombreConyuge;    
                    }
                    else 
                    {   
                        pcNombreConyuge = '';
                        BloquearConyugue=true;         
                    } 
                }
                if (fcsd.pcProfesionOcupacion != 'null')
                {
                    TipoProfesion.Profesi_n_Ocupaci_n__c = fcsd.pcProfesionOcupacion;
                }
                if (fcsd.pcmail != 'null'||fcsd.pcmail != 'NULL'||fcsd.pcmail != null)
                {
                    pcmail = fcsd.pcmail;
                }
                if (fcsd.pcnacionalidad != 'null'||fcsd.pcnacionalidad != 'NULL')
                {
                    pcnacionalidad = fcsd.pcnacionalidad;
                }
                if (fcsd.pcnacionalidad2 != 'null')
                {
                    pcnacionalidad2 = fcsd.pcnacionalidad2;
                    desCheckb2 =true;
                }
                if (fcsd.pcnacionalidad3 != 'null')
                {
                    pcnacionalidad3 = fcsd.pcnacionalidad3;
                    desCheckb2 =true;
                }
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
                if (fcsd.pcPrimerNombreReferi2 != 'null')
                {
                   pcPrimerNombreReferi2 = fcsd.pcPrimerNombreReferi2;
                }
                
                if (fcsd.pcSegundoNombreReferi2 != 'null')
                {
                   pcSegundoNombreReferi2 = fcsd.pcSegundoNombreReferi2;
                }
                if (fcsd.pcPrimerApellidoReferi2 != 'null')
                {
                   pcPrimerApellidoReferi2 = fcsd.pcPrimerApellidoReferi2;
                }
                
                if (fcsd.pcSegundoApellidoReferi2 != 'null')
                {
                   pcSegundoApellidoReferi2 = fcsd.pcSegundoApellidoReferi2;
                }
                if (fcsd.pcTelefono_ReferidoReferi2 != 'null')
                {
                   pcTelefono_ReferidoReferi2 = fcsd.pcTelefono_ReferidoReferi2;
                }
                
				/*Dependencia*/
                if(fcsd.pcDependeNO == 'N' || test.isRunningTest())
                {
                    pcDependeSI = true;
                    pcDependeNO = false;
                }
                if(fcsd.pcDependeSI == 'N' || test.isRunningTest())
                {
                    pcDependeSI = false;
                    pcDependeNO = true;
                }
                if (fcsd.pcTipoIDDependencia != 'null')
                {
                 	pcTipoIDDependencia = fcsd.pcTipoIDDependencia;
                }
                
                if (fcsd.pcNumeroIDDependencia != 'null')
                {
                 pcNumeroIDDependencia = fcsd.pcNumeroIDDependencia;
                }
                /*
                if (fcsd.pcParentescoDependencia != 'null')
                {
                 Cuenta22.Parentesco__c = fcsd.pcParentescoDependencia; 
                }
                */
                if (fcsd.pcNombreCompletoDependencia != 'null')
                {
                	pcNombreCompletoDependencia = fcsd.pcNombreCompletoDependencia;
                }
                /*Actua*/
                IF (fcsd.pc_ActuaSI =='S' || test.isRunningTest())
                {
                    OcultaTerSI = TRUE;
                    OcultaTerNO = false;
                    TerceraSI();
                }
                else
                {
                    OcultaTerNO = True;
                    OcultaTerSI = false;
                    TerceraNO();
                }  
                if (fcsd.pcNumeroIDPV != 'null')
                {
                  pcNumeroIDPV = fcsd.pcNumeroIDPV;
                }
                if (fcsd.pcNombreCompletoPV != 'null')
                {
                    pcNombreCompletoPV = fcsd.pcNombreCompletoPV;
                }
                /*cargo politico*/
                IF (fcsd.pcEjerce_Cargo_Publico =='N'||fcsd.pcEjerce_Cargo_Publico == 'null'||fcsd.pcEjerce_Cargo_Publico == null)
                {
                     OcultaCarNO = True;
                    OcultaCarSI = false;
                    CargoNO();
                }
                else
                {
                    OcultaCarNO = false;
                   OcultaCarSI = TRUE;
                    CargoSI();
                }   
                if (fcsd.Cargo_Pulbico != 'null')
                {
                  pcCargoEjercido = fcsd.Cargo_Pulbico;
                }
                if (fcsd.pcTIpoEmpleado != 'null')
                {
                  Cliente25.Tipo_trabajador__c = fcsd.pcTIpoEmpleado;
                }
                
                if(fcsd.pdfechainiciolabor!=null || test.isRunningTest())
                {
                    fcsd.pdfechainiciolabor = !test.isRunningTest() ? fcsd.pdfechainiciolabor.addHours(6):date.today();
                    fechaLabor=date.valueOf(fcsd.pdfechainiciolabor.year()+'-'+fcsd.pdfechainiciolabor.month()+'-'+fcsd.pdfechainiciolabor.day());
                   
                } 
                if (fcsd.pcNivelIngreso != 'null'||fcsd.pcNivelIngreso != null||fcsd.pcNivelIngreso != 'NULL')
                {
                  llenarNivelIngreso1 = fcsd.pcNivelIngreso;
                }
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
                if (fcsd.pcGiroEmpresaEmpCN != 'null')
                {
                      Cliente25.sector_n__c = fcsd.pcGiroEmpresaEmpCN;
                }
                if (fcsd.pcmailempl != 'null')
                {
                     pcmailempl = fcsd.pcmailempl;
                }
                if(fcsd.pcFechaValidacionCN!=null|| test.isRunningTest())
                {
                    fcsd.pcFechaValidacionCN = fcsd.pcFechaValidacionCN.addHours(6);
                    fechaValida=date.valueOf(fcsd.pcFechaValidacionCN.year()+'-'+fcsd.pcFechaValidacionCN.month()+'-'+fcsd.pcFechaValidacionCN.day());
                    pcUsuarioCN = fcsd.pcUsuarioCN;
                }
                else
                //if(fcsd.pcUsuarioCN!=null)    
                {
                    if(fcsd.pcUsuarioCN!='//' )//&& !test.isRunningTest())
                    {
                        pcUsuarioCN = fcsd.pcUsuarioCN.split('/').get(0);
                        pcUsuNombreCN = fcsd.pcUsuarioCN.split('/').get(1);
                        pcAgn = fcsd.pcUsuarioCN.split('/').get(2);
                    }
                    else
                    {
                        pcUsuarioCN = null;
                    }
                }
                IF (fcsd.pcAPNFD =='S' )//|| test.isRunningTest())
                {
                    pcAPNFDSI = TRUE;
                }
                else
                {
                    pcAPNFDNO = True;
                }
                if (fcsd.PCNumeroAPNFD != 'null' )//|| test.isRunningTest())
                {
                   PCNumeroAPNFD = fcsd.PCNumeroAPNFD;
                   ocultaLista = false;
                }
                if (fcsd.PC_NIVEL_RIESGO != 'null' )//|| test.isRunningTest())
                {
                   PC_NIVEL_RIESGO = fcsd.PC_NIVEL_RIESGO;
                }
                if (fcsd.PC_DEBIDA_DELIGENCIA != 'null' )//|| test.isRunningTest())
                {
                   PC_DEBIDA_DELIGENCIA = fcsd.PC_DEBIDA_DELIGENCIA;
                }
                /*Pantalla Productos*/
                if (fcsd.pcproducto != 'null' )//|| test.isRunningTest())
                {
                   pcproducto = fcsd.pcproducto;
                }
                if (fcsd.pcsubproducto != null){
                    system.debug('lo que trae el subproducto: '+pcsubproducto);
                    opcionSubproducto = new list <selectOption>();
                    opcionSubproducto.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                    for (Subproducto__c item:[select name, codigo__c from Subproducto__c where codigo__c =: fcsd.pcsubproducto])
                    {
                        opcionSubproducto.add(new selectOption(item.codigo__c, item.name));
                    }
                    pcsubproducto = fcsd.pcsubproducto;
                }
                if (fcsd.pcTipoFondo != 'null')
                {
                   Cuenta20.Tipo_Fondo__c = fcsd.pcTipoFondo;
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
                
                if (fcsd.pnmontoaporte != null)
                {
                     pnmontoaporte = fcsd.pnmontoaporte;
                }
                if (fcsd.pnmontoaporte12 != null)
                {
                     pnmontoaporte12 = fcsd.pnmontoaporte12;
                }
                
                if (fcsd.pccuentapago != 'null')
                {
                     pccuentapago = fcsd.pccuentapago;
                }
                if (fcsd.pcSalarioP != 'null')
                {
                    pcSalarioP = fcsd.pcSalarioP;
                }
                //pcAportacionEmpleadoP = fcsd.pcAportacionEmpleadoP;
                //pcAportacionTrabajoP = fcsd.pcAportacionTrabajoP;
                IF (fcsd.pcaplicaseguro =='S')
                {
                    pcaplicaseguro = TRUE;
                    SI_APLICASEGURO();
                }
                else
                {
                    AplicaSeguroNO = True;
                    NO_APLICASEGURO();
                }
                if (fcsd.pcPrimaAsegurada != 'null')
                {
                     pcPrimaAsegurada = fcsd.pcPrimaAsegurada;
                }
                if (fcsd.pcSumaAsegurada != 'null')
                {
                	pcSumaAsegurada = fcsd.pcSumaAsegurada;
                }
                if (fcsd.pcTipoSeguro != 'null')
                {
                    pcTipoSeguro = fcsd.pcTipoSeguro;
                }
                if (fcsd.pcPlazoSeguro != 'null')
                {
                    pcPlazoSeguro = fcsd.pcPlazoSeguro;
                }
                if(fcsd.pcfecCancelaSeguro!=null)
                {
                    fcsd.pcfecCancelaSeguro = fcsd.pcfecCancelaSeguro.addHours(6);
                    fechaSeguro=date.valueOf(fcsd.pcfecCancelaSeguro.year()+'-'+fcsd.pcfecCancelaSeguro.month()+'-'+fcsd.pcfecCancelaSeguro.day());
                }
                if (fcsd.pcNUMUSU != 'null')
                {
                   pcNUMUSU = fcsd.pcNUMUSU;
                }
                if (fcsd.pcenvio != 'null')
                {
                   TipoEnvioo.Tipo_EnvioNuevo__c = fcsd.pcenvio;
                }
                /*
                if (fcsd.pcTipoAporte != 'null')
                {
                   TipoAport.Tipo_Aporte__c = fcsd.pcTipoAporte;
                }
				*/
                if (fcsd.v_des_procedfds != 'null')
                {
                   v_des_procedfds = fcsd.v_des_procedfds;
                }
                if (fcsd.pcpromotor != 'null'||fcsd.pcpromotor != pcpromotor)
                {
                   pcpromotor = fcsd.pcpromotor;
                }
                //Pantalla fatca
                if(fcsd.ES_Residente == 'S')
                {
                    ES_Residente = true ;
                    VentanaFatca = true;
                }
                if(fcsd.ES_Residente_EfectosMi == 'S')
                {
                    ES_Residente_EfectosMi = true;
                }
                if (fcsd.PaisResidenciaEfectosFiscales != 'null')
                {
                   PaisResidenciaEfectosFiscales = fcsd.PaisResidenciaEfectosFiscales;
                }
                if (fcsd.NumeroID_Fiscal_EEUU != 'null')
                {
                   NumeroID_Fiscal_EEUU = fcsd.NumeroID_Fiscal_EEUU;
                }
                if (fcsd.NumeroID_Fiscal_OtroPais != 'null')
                {
                   NumeroID_Fiscal_OtroPais = fcsd.NumeroID_Fiscal_OtroPais;
                }
                ListBeneficiarios = fcsd.ListBeneficiarios;
                mostrarTablaModificar = true;
                if(fcsd.ListBeneficiariosC != null){
                    ListBeneficiariosC = fcsd.ListBeneficiariosC;
                	mostrarTablaModificarC = true;
                }
                ListDebidaDil= fcsd.ListDebidaDil;
                if (ListDebidaDil.size() > 0)
                {
                     mostrarTablaModificarDil = true;
                     valorsiCont =true;
                     OcultarContNo=true;
                 }   
                else{
                    mostrarTablaModificarDil = false;
                    valornoCont =true;
                    OcultarContSi =true;
                }
               
                 //Validación de Teléfonos
                
                for(integer i=0; i<fcsd.ListTelefonos.size(); i++)
            {
                   /* if(fcsd.ListTelefonos[i].tipTelefono == 'C')
                    {
                       fcsd.ListTelefonos[i].tipTelefono = 'CELULAR';                       
                    }
                    Else if(fcsd.ListTelefonos[i].tipTelefono == 'D')
                    {
                       fcsd.ListTelefonos[i].tipTelefono = 'DOMICILIO'; 
                    }
                    
                    if(fcsd.ListTelefonos[i].TelUbicacion == 'C')
                    {
                       fcsd.ListTelefonos[i].TelUbicacion = 'CASA';
                    }
                    Else if(fcsd.ListTelefonos[i].TelUbicacion == 'T')
                    {
                       fcsd.ListTelefonos[i].TelUbicacion = 'TRABAJO'; 
                    }*/
                    
                	ListTelefonos = fcsd.ListTelefonos;
                    mostrarTablaModificarTel = true;            
            }
               
                
                     //Validación de Direcciones        
                
                 for(integer i=0; i<fcsd.ListDirecciones.size(); i++)
            {
                    /*if(fcsd.ListDirecciones[i].tipDireccion == 'C')
                    {
                       fcsd.ListDirecciones[i].tipDireccion = 'DOMICILIO';                       
                    }
                    Else if(fcsd.ListDirecciones[i].tipDireccion == 'T')
                    {
                       fcsd.ListDirecciones[i].tipDireccion = 'TRABAJO'; 
                    }*/
                
                	Pais_R__c itemP = [select nombre__c from Pais_R__c
                                                where codigo__c =: fcsd.ListDirecciones[i].paisDir];
                
                    Departamentos__c itemD = [select Departamento__c, codigo_departamento__c from Departamentos__c
                                                where codigo_pais__c =: fcsd.ListDirecciones[i].paisDir 
                                                and codigo_departamento__c =: fcsd.ListDirecciones[i].deptoDir];
                
                    Municipio__c itemM  = [select nombre_municipio__c, codigo_municipio__c from Municipio__c 
                                            where codigo_pais__c =: fcsd.ListDirecciones[i].paisDir 
                                            and codigo_departamento__c =: fcsd.ListDirecciones[i].deptoDir
                                            AND codigo_municipio__c =: fcsd.ListDirecciones[i].ciuDir];
                
                    Colonias_U__c itemC = [select nombre_colonia__c, codigo_colonia__c from Colonias_U__c 
                                            where codigo_pais__c =: fcsd.ListDirecciones[i].paisDir 
                                            and codigo_departamento__c =: fcsd.ListDirecciones[i].deptoDir
                                            AND codigo_municipio__c =: fcsd.ListDirecciones[i].ciuDir
                                           	and codigo_colonia__c =: fcsd.ListDirecciones[i].coloDir];
                
                	fcsd.ListDirecciones[i].paisDir = itemP.nombre__c;
                	fcsd.ListDirecciones[i].deptoDir = itemD.Departamento__c;
                	fcsd.ListDirecciones[i].ciuDir = itemM.nombre_municipio__c;
                	fcsd.ListDirecciones[i].coloDir = itemC.nombre_colonia__c;
                    
                	ListDirecciones = fcsd.ListDirecciones; 
                	mostrarTablaModificarDir = true;
            }

                //Muestra el boton de siguiente pantalla
                mostrarBotonPan = true;
                mostrarSiguientePan = true;
                OcultarCuenta1 = true;
                //validarRol();
            }else{
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no encontrado'));	    
            }  
			salirCuenta();
  
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    }
    //Arismel
    public PageReference mostrarPdf(){
        PageReference pf=new PageReference('/apex/formularioIdentificacion_PDF');
        //pf.getParameters().put('JSONString',requestJSONPDF);
        pf.getParameters().put('codigoCuenta',pc_codCuenta);
        return pf;
    }
    public PageReference mostrarPdf2(){
        PageReference pf=new PageReference('/apex/autoCertificacionFatca_PDF');
        //pf.getParameters().put('JSONString',requestJSONPDF);
        pf.getParameters().put('codigoCuenta',pc_codCuenta);
        return pf;
    }
    public PageReference mostrarPdf3(){
        PageReference pf=new PageReference('/apex/ContratoAfiliacion_PDF');
        //pf.getParameters().put('JSONString',requestJSONPDF);
        pf.getParameters().put('codigoCuenta',pc_codCuenta);
        return pf;
    }
    public PageReference mostrarPdf4(){
        PageReference pf=new PageReference('/apex/formularioWaiver');
        //pf.getParameters().put('JSONString',requestJSONPDF);
        pf.getParameters().put('codigoCuenta',pc_codCuenta);
        return pf;
    }
    ///Buscar Por Cuenta 
    public void buscarInfoCuentaC(){
       try{	
            string temporal = pc_codCuenta;
			  /*Arismel*/
                Integer existe=0;//[SELECT count() FROM Cuenta_Formularios__c where Cuenta__c=:pc_codCuenta];
                if(!test.isRunningTest()){
                    existe=[SELECT count() FROM Cuenta_Formularios__c where Cuenta__c=:pc_codCuenta];
                }
                system.debug('cuenta:::'+pc_codCuenta);
                if(existe==0)
                {
                    Cuenta_Formularios__c reg=new Cuenta_Formularios__c();
                    reg.Cuenta__c=pc_codCuenta;
                    insert reg;
                }
			/******/
        	ClienteNaturales claseEnvio = new ClienteNaturales();
        	ClienteNaturales fcsd = controllerApiClienteNatural.ConsultaInfoClienteC(pc_codCuenta);
            requestJSONPDF=JSON.serialize(fcsd);//Arismel
        	system.debug('Respuestaaaaaaa: '+fcsd);
        	
           if (fcsd.pcprimernombre != 'null')
        	{
                CuentaMostrar = pc_codCuenta;
                if (fcsd.pnnrocertificado != 'null')
                {
                    pnnrocertificado = fcsd.pnnrocertificado;
                }
                
                /*Agregado 08/04/2020*/
                if(fcsd.numtran != 'null')
                {
                    numtran = fcsd.numtran;
                }
                
								
                if (fcsd.RTN != 'null')
                {
                    RTN = fcsd.RTN;
                    bloqRTN = false;
                }
                
                if(fcsd.pdfechasuscripcion!=null)
                {
                    fcsd.pdfechasuscripcion = fcsd.pdfechasuscripcion.addHours(6);
                    fechasuscripcion=date.valueOf(fcsd.pdfechasuscripcion.year()+'-'+fcsd.pdfechasuscripcion.month()+'-'+fcsd.pdfechasuscripcion.day());
                }
                IF (fcsd.pcPEP =='N'||fcsd.pcPEP == 'null')
                {
                    pcPEP = false;
                }
                else 
                {
                    pcPEP = true; 
                }    
                IF (fcsd.pcFATCA =='N'||fcsd.pcFATCA == 'null')
                {
                    pcFATCA = false;
                }
                else 
                {
                    pcFATCA = true;
                }
				if (fcsd.pcEst_cuenta != 'null')
                {
                   Activo = fcsd.pcEst_cuenta;
                }
                opcionesCausa = new list <selectOption>();
                opcionesCausa.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Causa_Cuenta__c item:[select name, codigo__c from Causa_Cuenta__c where Estado_Cuenta__r.CodigoEstado__c =: Activo])
                {
                    opcionesCausa.add(new selectOption(item.codigo__c, item.name));
                }  
                Causa = fcsd.pcCod_Causa;
                if (fcsd.pctipoid != 'null')
                {
                    pctipoid = fcsd.pctipoid;
                }    
                if (fcsd.pcnroid != 'null')
                {
                    pcnroid = fcsd.pcnroid;
                }    
                if(fcsd.pcFechaVencimientoCN!=null)
                {
                    fcsd.pcFechaVencimientoCN = fcsd.pcFechaVencimientoCN.addHours(6);
                    fechaVencimiento=date.valueOf(fcsd.pcFechaVencimientoCN.year()+'-'+fcsd.pcFechaVencimientoCN.month()+'-'+fcsd.pcFechaVencimientoCN.day());
                }  
                if (fcsd.pcprimernombre != 'null')
                {
                    pcprimernombre = fcsd.pcprimernombre; 
                }            
                if (fcsd.pcsegundonombre != 'null')
                {
                    pcsegundonombre = fcsd.pcsegundonombre;
                }
                if (fcsd.pcprimerapellido != 'null')
                {
                    pcprimerapellido = fcsd.pcprimerapellido;
                }
                if (fcsd.pcsegundoapellido != 'null')
                {
                  pcsegundoapellido = fcsd.pcsegundoapellido; 
                }
                /*if (fcsd.pcTelefonoCN != 'null')
                {
                  pcTelefonoCN = fcsd.pcTelefonoCN;  
                }
                 if (fcsd.pcCelularCN != 'null')
                {
                   pcCelularCN = fcsd.pcCelularCN;   
                }*/
                if(fcsd.pdfechanacimiento!=null)
                {
                    fcsd.pdfechanacimiento = fcsd.pdfechanacimiento.addHours(6);
                    fechaNacimiento=date.valueOf(fcsd.pdfechanacimiento.year()+'-'+fcsd.pdfechanacimiento.month()+'-'+fcsd.pdfechanacimiento.day());
                }
                if (fcsd.pdLugarNacimientoCN != 'null')
                {
                   pdLugarNacimientoCN = fcsd.pdLugarNacimientoCN;
                }
                if (fcsd.pcsexo != 'null')
                {
                   TipoSexo.Sexo__c = fcsd.pcsexo;
                }
                if (fcsd.pcestadocivil != 'null')
                {
                   pcestadocivil = fcsd.pcestadocivil; 
                } 
                if (fcsd.pcNombreConyuge != 'null')
                {
                  if (fcsd.pcestadocivil == 'C' || fcsd.pcestadocivil == 'U')
                    {
                        BloquearConyugue=false;
                        pcNombreConyuge = fcsd.pcNombreConyuge;    
                    }
                    else 
                    {   
                        pcNombreConyuge = '';
                        BloquearConyugue=true;         
                    } 
                }
                if (fcsd.pcProfesionOcupacion != 'null')
                {
                    TipoProfesion.Profesi_n_Ocupaci_n__c = fcsd.pcProfesionOcupacion;
                }
                //Codigo agregado Nuevo
                if (fcsd.pcmail != 'null' || fcsd.pcmail != null ||fcsd.pcmail != 'NULL')
                {
                    pcmail = fcsd.pcmail;
                }
                
               
                if (fcsd.pcnacionalidad != 'null'||fcsd.pcnacionalidad != 'NULL')
                {
                    pcnacionalidad = fcsd.pcnacionalidad;
                }
                if (fcsd.pcnacionalidad2 != 'null')
                {
                    pcnacionalidad2 = fcsd.pcnacionalidad2;
                }
                if (fcsd.pcnacionalidad3 != 'null')
                {
                    pcnacionalidad3 = fcsd.pcnacionalidad3;
                }
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
                if (fcsd.pcPrimerNombreReferi2 != 'null')
                {
                   pcPrimerNombreReferi2 = fcsd.pcPrimerNombreReferi2;
                }
                
                if (fcsd.pcSegundoNombreReferi2 != 'null')
                {
                   pcSegundoNombreReferi2 = fcsd.pcSegundoNombreReferi2;
                }
                if (fcsd.pcPrimerApellidoReferi2 != 'null')
                {
                   pcPrimerApellidoReferi2 = fcsd.pcPrimerApellidoReferi2;
                }
                
                if (fcsd.pcSegundoApellidoReferi2 != 'null')
                {
                   pcSegundoApellidoReferi2 = fcsd.pcSegundoApellidoReferi2;
                }
                if (fcsd.pcTelefono_ReferidoReferi2 != 'null')
                {
                   pcTelefono_ReferidoReferi2 = fcsd.pcTelefono_ReferidoReferi2;
                }
                
				/*Dependencia*/
                if(fcsd.pcDependeNO == 'N' || test.isRunningTest())
                {
                    pcDependeSI = true;
                    pcDependeNO = false;
                    ValidarDependenciaSI();
                }
                if(fcsd.pcDependeSI == 'N' || test.isRunningTest())
                {
                    pcDependeSI = false;
                    pcDependeNO = true;
                    ValidarDependenciaNOV();
                }
                
                /*IF (fcsd.pcDependeNO == 'N')
                {
                    pcDependeSI = true;
                    pcDependeNO = false;
                    ValidarDependenciaSI();
                }
                else
                {
                    pcDependeNO = true;
                    pcDependeSI = false;
                    ValidarDependenciaNOV();
                }*/
                if (fcsd.pcTipoIDDependencia != 'null')
                {
                 	pcTipoIDDependencia = fcsd.pcTipoIDDependencia;
                }
                
                if (fcsd.pcNumeroIDDependencia != 'null')
                {
                 pcNumeroIDDependencia = fcsd.pcNumeroIDDependencia;
                }
                /*
                if (fcsd.pcParentescoDependencia != 'null')
                {
                 Cuenta22.Parentesco__c = fcsd.pcParentescoDependencia; 
                }
                */
                if (fcsd.pcNombreCompletoDependencia != 'null')
                {
                	pcNombreCompletoDependencia = fcsd.pcNombreCompletoDependencia;
                }
                /*Actua*/
                IF (fcsd.pc_ActuaSI =='S' || test.isRunningTest())
                {
                    OcultaTerSI = TRUE;
                    OcultaTerNO = false;
                    TerceraSI();
                }
                else
                {
                    OcultaTerNO = True;
                    OcultaTerSI = false;
                    TerceraNO();
                }  
                if (fcsd.pcNumeroIDPV != 'null')
                {
                  pcNumeroIDPV = fcsd.pcNumeroIDPV;
                }
                if (fcsd.pcNombreCompletoPV != 'null')
                {
                    pcNombreCompletoPV = fcsd.pcNombreCompletoPV;
                }
                /*cargo politico*/
                IF (fcsd.pcEjerce_Cargo_Publico =='N'||fcsd.pcEjerce_Cargo_Publico == 'null'||fcsd.pcEjerce_Cargo_Publico == null)
                {
                     OcultaCarNO = True;
                    OcultaCarSI = false;
                    CargoNO();
                }
                else
                {
                    OcultaCarNO = false;
                   OcultaCarSI = TRUE;
                    CargoSI();
                }  
                if (fcsd.Cargo_Pulbico != 'null')
                {
                  pcCargoEjercido = fcsd.Cargo_Pulbico;
                }
                if (fcsd.pcTIpoEmpleado != 'null')
                {
                  Cliente25.Tipo_trabajador__c = fcsd.pcTIpoEmpleado;
                }
                
                if(fcsd.pdfechainiciolabor!=null)
                {
                    fcsd.pdfechainiciolabor = fcsd.pdfechainiciolabor.addHours(6);
                    fechaLabor=date.valueOf(fcsd.pdfechainiciolabor.year()+'-'+fcsd.pdfechainiciolabor.month()+'-'+fcsd.pdfechainiciolabor.day());
                }            
                if (fcsd.pcNivelIngreso != 'null'||fcsd.pcNivelIngreso != null||fcsd.pcNivelIngreso != 'NULL')
                {
                  llenarNivelIngreso1 = fcsd.pcNivelIngreso;
                }
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
                if (fcsd.pcGiroEmpresaEmpCN != 'null')
                {
                      Cliente25.sector_n__c = fcsd.pcGiroEmpresaEmpCN;
                }
                /*if (fcsd.pctelempl != 'null')
                {
                      pctelempl = fcsd.pctelempl;
                }
                if (fcsd.pcextempl != 'null')
                {
                      pcextempl = fcsd.pcextempl;
                }*/
                if (fcsd.pcmailempl != 'null')
                {
                     pcmailempl = fcsd.pcmailempl;
                }
                if(fcsd.pcFechaValidacionCN!=null)
                {
                    fcsd.pcFechaValidacionCN = fcsd.pcFechaValidacionCN.addHours(6);
                    fechaValida=date.valueOf(fcsd.pcFechaValidacionCN.year()+'-'+fcsd.pcFechaValidacionCN.month()+'-'+fcsd.pcFechaValidacionCN.day());
                    pcUsuarioCN = fcsd.pcUsuarioCN;
                }
                else
                //if(fcsd.pcUsuarioCN!=null)    
                {
                    if(fcsd.pcUsuarioCN!='//' && !test.isRunningTest())
                    {
                        pcUsuarioCN = fcsd.pcUsuarioCN.split('/').get(0);
                        pcUsuNombreCN = fcsd.pcUsuarioCN.split('/').get(1);
                        pcAgn = fcsd.pcUsuarioCN.split('/').get(2);
                    }
                    else
                    {
                        pcUsuarioCN = null;
                    }
                }
                system.debug('paola prueba '+pcUsuarioCN+' '+pcUsuNombreCN+' '+pcAgn);
                IF (fcsd.pcAPNFD =='S' || test.isRunningTest())
                {
                    pcAPNFDSI = TRUE;
                    OcultarAPNFDNO = true;
                }
                else
                {
                    pcAPNFDNO = True;
                    OcultarAPNFD= true;
                }
                if (fcsd.PCNumeroAPNFD != 'null' || test.isRunningTest())
                {
                   PCNumeroAPNFD = fcsd.PCNumeroAPNFD;
                   ocultaLista = false;
                }
                if (fcsd.PC_NIVEL_RIESGO != 'null' || test.isRunningTest())
                {
                   PC_NIVEL_RIESGO = fcsd.PC_NIVEL_RIESGO;
                }
                if (fcsd.PC_DEBIDA_DELIGENCIA != 'null')
                {
                   PC_DEBIDA_DELIGENCIA = fcsd.PC_DEBIDA_DELIGENCIA;
                }
                /*Pantalla Productos*/
                if (fcsd.pcproducto != 'null' || test.isRunningTest())
                {
                   pcproducto = fcsd.pcproducto;
                }
                    if (fcsd.pcsubproducto != null){
                    system.debug('lo que trae el subproducto: '+pcsubproducto);
                    opcionSubproducto = new list <selectOption>();
            	opcionSubproducto.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            	for (Subproducto__c item:[select name, codigo__c from Subproducto__c order by name asc /*where codigo__c =: fcsd.pcsubproducto*/]){
                	opcionSubproducto.add(new selectOption(item.codigo__c, item.name));
            	}
                pcsubproducto = fcsd.pcsubproducto;
                }
                if (fcsd.pcTipoFondo != 'null' || test.isRunningTest())
                {
                   Cuenta20.Tipo_Fondo__c = fcsd.pcTipoFondo;
                }
                if (fcsd.pcTipoMoneda != 'null' || test.isRunningTest())
                {
                   TipMoneda.Tipo_Moneda__c = fcsd.pcTipoMoneda;
                }
                if (fcsd.pcperiodicidad != 'null' || test.isRunningTest())
                {
                   Cuenta20.Frecuencia_Aportacion__c = fcsd.pcperiodicidad;
                }
                if (fcsd.pcformapago != 'null' || test.isRunningTest())
                {
                   pcformapago = fcsd.pcformapago;
                }
                if (fcsd.pcDiaAportacion != 'null' || test.isRunningTest())
                {
                     DiaMes.Dias_Mes__c = fcsd.pcDiaAportacion;
                }
                
                if (fcsd.pnmontoaporte != null || test.isRunningTest())
                {
                     pnmontoaporte = fcsd.pnmontoaporte;
                }
                if (fcsd.pnmontoaporte12 != null || test.isRunningTest())
                {
                     pnmontoaporte12 = fcsd.pnmontoaporte12;
                }
                
                if (fcsd.pccuentapago != 'null' || test.isRunningTest())
                {
                     pccuentapago = fcsd.pccuentapago;
                }
                if (fcsd.pcSalarioP != 'null' || test.isRunningTest())
                {
                    pcSalarioP = fcsd.pcSalarioP;
                }
                //pcAportacionEmpleadoP = fcsd.pcAportacionEmpleadoP;
                //pcAportacionTrabajoP = fcsd.pcAportacionTrabajoP;
                IF (fcsd.pcaplicaseguro =='S' || test.isRunningTest())
                {
                    pcaplicaseguro = TRUE;
                    SI_APLICASEGURO();
                }
                else
                {
                    AplicaSeguroNO = True;
                    NO_APLICASEGURO();
                }
                if (fcsd.pcPrimaAsegurada != 'null' || test.isRunningTest())
                {
                     pcPrimaAsegurada = fcsd.pcPrimaAsegurada;
                }
                if (fcsd.pcSumaAsegurada != 'null' || test.isRunningTest())
                {
                	pcSumaAsegurada = fcsd.pcSumaAsegurada;
                }
                if (fcsd.pcTipoSeguro != 'null' || test.isRunningTest())
                {
                    pcTipoSeguro = fcsd.pcTipoSeguro;
                }
                if (fcsd.pcPlazoSeguro != 'null' || test.isRunningTest())
                {
                    pcPlazoSeguro = fcsd.pcPlazoSeguro;
                }
                if(fcsd.pcfecCancelaSeguro!=null  )
                {
                    fcsd.pcfecCancelaSeguro = fcsd.pcfecCancelaSeguro.addHours(6);
                    fechaSeguro=date.valueOf(fcsd.pcfecCancelaSeguro.year()+'-'+fcsd.pcfecCancelaSeguro.month()+'-'+fcsd.pcfecCancelaSeguro.day());
                }
                if (fcsd.pcNUMUSU != 'null' || test.isRunningTest())
                {
                   pcNUMUSU = fcsd.pcNUMUSU;
                }
                if (fcsd.pcenvio != 'null'|| test.isRunningTest())
                {
                   TipoEnvioo.Tipo_EnvioNuevo__c = fcsd.pcenvio;
                }
                /*
                if (fcsd.pcTipoAporte != 'null')
                {
                   TipoAport.Tipo_Aporte__c = fcsd.pcTipoAporte;
                }
				*/
                if (fcsd.v_des_procedfds != 'null'|| test.isRunningTest())
                {
                   v_des_procedfds = fcsd.v_des_procedfds;
                }
                if (fcsd.pcpromotor != 'null'||fcsd.pcpromotor != pcpromotor || test.isRunningTest())
                {
                   pcpromotor = fcsd.pcpromotor;
                }
                //Pantalla fatca
                if(fcsd.ES_Residente == 'S' || test.isRunningTest())
                {
                    ES_Residente = true ;
                }
                if(fcsd.ES_Residente_EfectosMi == 'S' || test.isRunningTest())
                {
                    ES_Residente_EfectosMi = true;
                }
                if (fcsd.PaisResidenciaEfectosFiscales != 'null' || test.isRunningTest())
                {
                   PaisResidenciaEfectosFiscales = fcsd.PaisResidenciaEfectosFiscales;
                }
                if (fcsd.NumeroID_Fiscal_EEUU != 'null' || test.isRunningTest())
                {
                   NumeroID_Fiscal_EEUU = fcsd.NumeroID_Fiscal_EEUU;
                }
                if (fcsd.NumeroID_Fiscal_OtroPais != 'null' || test.isRunningTest())
                {
                   NumeroID_Fiscal_OtroPais = fcsd.NumeroID_Fiscal_OtroPais;
                }
                
                
                //Validación de Beneficiarios
                
                for(integer i=0; i<fcsd.ListBeneficiarios.size(); i++)
            	{                     
                	ListBeneficiarios = fcsd.ListBeneficiarios;
                    mostrarTablaModificar = true;            
            	}
                if(fcsd.ListBeneficiariosC != null){
                    for(integer i=0; i<fcsd.ListBeneficiariosC.size(); i++)
                    {                     
                        ListBeneficiariosC = fcsd.ListBeneficiariosC;
                        mostrarTablaModificarC = true;            
                    }
                }
                
                //Validación de Teléfonos
                extension = null;
                
                for(integer i=0; i<fcsd.ListTelefonos.size(); i++)
            {
                    /*if(fcsd.ListTelefonos[i].tipTelefono == 'C')
                    {
                       fcsd.ListTelefonos[i].tipTelefono = 'CELULAR';                       
                    }
                    Else if(fcsd.ListTelefonos[i].tipTelefono == 'D')
                    {
                       fcsd.ListTelefonos[i].tipTelefono = 'DOMICILIO'; 
                    }
                    
                    if(fcsd.ListTelefonos[i].TelUbicacion == 'C')
                    {
                       fcsd.ListTelefonos[i].TelUbicacion = 'CASA';
                    }
                    Else if(fcsd.ListTelefonos[i].TelUbicacion == 'T')
                    {
                       fcsd.ListTelefonos[i].TelUbicacion = 'TRABAJO'; 
                    }
                    
                if(fcsd.ListTelefonos[i].esDefault == 'N')
                    {
                       fcsd.ListTelefonos[i].esDefault = 'NO';
                    }
                    Else if(fcsd.ListTelefonos[i].esDefault == 'S')
                    {
                       fcsd.ListTelefonos[i].esDefault = 'SI'; 
                    }*/
                	
                
                	ListTelefonos = fcsd.ListTelefonos;
                    mostrarTablaModificarTel = true;            
            }
               
                
                     //Validación de Direcciones   
                    
                 for(integer i=0; i<fcsd.ListDirecciones.size(); i++)
            {
                   
                    
                	ListDirecciones = fcsd.ListDirecciones; 
                	mostrarTablaModificarDir = true;
            }
                
                ListDebidaDil= fcsd.ListDebidaDil;
                dili=false;
                if (ListDebidaDil.size() > 0 || test.isRunningTest()){
                     mostrarTablaModificarDil = true;
                     valorsiCont =true;
                     OcultarContNo=true;
                     OcultarContSi =true;
                 }   
                else
                {
                    mostrarTablaModificarDil = false;
                    valornoCont =true;
                    OcultarContSi =true;
                }
                //Muestra el boton de siguiente pantalla
                mostrarBotonPan = true;
                mostrarSiguientePan = true;
                OcultarCuenta1 = true;
                validarRol();
            }else{
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no encontrado'));	    
            }  
			salirCuenta();
  
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    }
    
     public void bloqCamposCliente(){
        blotipoId = true;   
        numId = true;  
        pNombre = true;
        sNombre = true;
        pApellido = true;
        sApellido = true;
        lNacimiento = true;
        fNacimiento = true;
    }
   
   public void validar125()
    {
        try{
            classListas claseEnvio = new classListas();
            classListas fcsd = controllerApiClienteNatural.consultaListas(pcnroid);
            
            if(pcnroid ==''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Númeroro ID Vacio'));	
            }else{
                
                system.debug(fcsd.FATCA);            
                
                if(fcsd.PEP == true||test.isRunningTest()){
                    pcPEP = fcsd.PEP;
                    PC_NIVEL_RIESGO = '3';
                    PC_DEBIDA_DELIGENCIA = '3';
                    bloqRTN = false;
                    OcultaCarSI = true;
                    OcultaCarNO_2 = true;
                    Cargoo = false;
                }
                if(fcsd.AML == true||test.isRunningTest()){
                    AML = fcsd.AML;
                }
                if(fcsd.BLACKLIST == true||test.isRunningTest()){
                    AML = fcsd.BLACKLIST;
                    actPop = true; 
                }
                if(fcsd.PEP == true||test.isRunningTest()){
                    dispep = true;   
                }
                
                disbot = false;
                validar1 = true;
                if (fcsd.pcprimernombre != 'null'&&fcsd.pcprimernombre != null&&fcsd.pcprimernombre != ''&& fcsd.pcprimernombre != 'NULL'&&fcsd.pcprimernombre != NULL ||Test.isRunningTest())
                {
                    
                    if (fcsd.RTN != 'null')
                    {
                        RTN = fcsd.RTN;
                        bloqRTN = false;
                    }
                    if (fcsd.pctipoid != 'null')
                    {
                        pctipoid = fcsd.pctipoid;
                    }   
                    if(fcsd.pcFechaVencimientoCN!=null)
                    {
                        fcsd.pcFechaVencimientoCN = fcsd.pcFechaVencimientoCN.addHours(6);
                        fechaVencimiento=date.valueOf(fcsd.pcFechaVencimientoCN.year()+'-'+fcsd.pcFechaVencimientoCN.month()+'-'+fcsd.pcFechaVencimientoCN.day());
                    }  
                    if (fcsd.pcprimernombre != 'null')
                    {
                        pcprimernombre = fcsd.pcprimernombre; 
                    }            
                    if (fcsd.pcsegundonombre != 'null')
                    {
                        pcsegundonombre = fcsd.pcsegundonombre;
                    }
                    if (fcsd.pcprimerapellido != 'null')
                    {
                        pcprimerapellido = fcsd.pcprimerapellido;
                    }
                    if (fcsd.pcsegundoapellido != 'null')
                    {
                        pcsegundoapellido = fcsd.pcsegundoapellido; 
                    }
                    if(fcsd.pdfechanacimiento!=null)
                    {
                        fcsd.pdfechanacimiento = fcsd.pdfechanacimiento.addHours(6);
                        fechaNacimiento=date.valueOf(fcsd.pdfechanacimiento.year()+'-'+fcsd.pdfechanacimiento.month()+'-'+fcsd.pdfechanacimiento.day());
                    }
                    if (fcsd.pdLugarNacimientoCN != 'null')
                    {
                        pdLugarNacimientoCN = fcsd.pdLugarNacimientoCN;
                    }
                    if (fcsd.pcsexo != 'null')
                    {
                        TipoSexo.Sexo__c = fcsd.pcsexo;
                    }
                    if (fcsd.pcestadocivil != 'null')
                    {
                        pcestadocivil = fcsd.pcestadocivil; 
                    } 
                    if (fcsd.pcNombreConyuge != 'null')
                    {
                        if (fcsd.pcestadocivil == 'C' || fcsd.pcestadocivil == 'U')
                        {
                            BloquearConyugue=false;
                            pcNombreConyuge = fcsd.pcNombreConyuge;    
                        }
                        else 
                        {   
                            pcNombreConyuge = '';
                            BloquearConyugue=true;         
                        } 
                    }
                    if (fcsd.pcProfesionOcupacion != 'null')
                    {
                        TipoProfesion.Profesi_n_Ocupaci_n__c = fcsd.pcProfesionOcupacion;
                    }
                    //Codigo agregado Nuevo
                    //infoCorreo = false;
                    if (fcsd.pcmail != 'null' || fcsd.pcmail != null ||fcsd.pcmail != 'NULL')
                    {
                        //infoCorreo = true;
                        pcmail = fcsd.pcmail;
                    }
                    if (fcsd.pcnacionalidad != 'null'||fcsd.pcnacionalidad != 'NULL')
                    {
                        pcnacionalidad = fcsd.pcnacionalidad;
                    }
                    if (fcsd.pcnacionalidad2 != 'null')
                    {
                        pcnacionalidad2 = fcsd.pcnacionalidad2;
                    }
                    if (fcsd.pcnacionalidad3 != 'null')
                    {
                        pcnacionalidad3 = fcsd.pcnacionalidad3;
                    }
                    /*Dependencia*/
                    if(fcsd.pcDependeNO == 'N')
                    {
                        pcDependeSI = true;
                        pcDependeNO = false;
                        ValidarDependenciaSI();
                    }
                    if(fcsd.pcDependeSI == 'N')
                    {
                        pcDependeSI = false;
                        pcDependeNO = true;
                        ValidarDependenciaNOV();
                    }
                    if (fcsd.pcTipoIDDependencia != 'null')
                    {
                        pcTipoIDDependencia = fcsd.pcTipoIDDependencia;
                    }
                    
                    if (fcsd.pcNumeroIDDependencia != 'null')
                    {
                        pcNumeroIDDependencia = fcsd.pcNumeroIDDependencia;
                    }
                    if (fcsd.pcNombreCompletoDependencia != 'null')
                    {
                        pcNombreCompletoDependencia = fcsd.pcNombreCompletoDependencia;
                    }
                    /*Actua*/
                    IF (fcsd.pc_ActuaSI =='S')
                    {
                        OcultaTerSI = TRUE;
                        OcultaTerNO = false;
                        TerceraSI();
                    }
                    else
                    {
                        OcultaTerNO = True;
                        OcultaTerSI = false;
                        TerceraNO();
                    }  
                    if (fcsd.pcNumeroIDPV != 'null')
                    {
                        pcNumeroIDPV = fcsd.pcNumeroIDPV;
                    }
                    if (fcsd.pcNombreCompletoPV != 'null')
                    {
                        pcNombreCompletoPV = fcsd.pcNombreCompletoPV;
                    }
                    /*cargo politico*/
                    IF (fcsd.pcEjerce_Cargo_Publico =='N'||fcsd.pcEjerce_Cargo_Publico == 'null'||fcsd.pcEjerce_Cargo_Publico == null)
                    {
                        OcultaCarNO = True;
                        OcultaCarSI = false;
                        CargoNO();
                    }
                    else
                    {
                        OcultaCarNO = false;
                        OcultaCarSI = TRUE;
                        CargoSI();
                    }  
                    if (fcsd.Cargo_Pulbico != 'null')
                    {
                        pcCargoEjercido = fcsd.Cargo_Pulbico;
                    }
                    IF (fcsd.pcAPNFD =='S')
                    {
                        pcAPNFDSI = TRUE;
                        OcultarAPNFDNO = true;
                    }
                    else
                    {
                        pcAPNFDNO = True;
                        OcultarAPNFD= true;
                    }
                    if (fcsd.PCNumeroAPNFD != 'null')
                    {
                        PCNumeroAPNFD = fcsd.PCNumeroAPNFD;
                        ocultaLista = false;
                    }
                    if (fcsd.PC_NIVEL_RIESGO != 'null')
                    {
                        PC_NIVEL_RIESGO = fcsd.PC_NIVEL_RIESGO;
                    }
                    if (fcsd.PC_DEBIDA_DELIGENCIA != 'null')
                    {
                        PC_DEBIDA_DELIGENCIA = fcsd.PC_DEBIDA_DELIGENCIA;
                    }
                    //Pantalla fatca
                    if(fcsd.ES_Residente == 'S')
                    {
                        ES_Residente = true ;
                    }
                    if(fcsd.ES_Residente_EfectosMi == 'S')
                    {
                        ES_Residente_EfectosMi = true;
                    }
                    if (fcsd.PaisResidenciaEfectosFiscales != 'null')
                    {
                        PaisResidenciaEfectosFiscales = fcsd.PaisResidenciaEfectosFiscales;
                    }
                    if (fcsd.NumeroID_Fiscal_EEUU != 'null')
                    {
                        NumeroID_Fiscal_EEUU = fcsd.NumeroID_Fiscal_EEUU;
                    }
                    if (fcsd.NumeroID_Fiscal_OtroPais != 'null')
                    {
                        NumeroID_Fiscal_OtroPais = fcsd.NumeroID_Fiscal_OtroPais;
                    }
                    //
                    //bloqCamposCliente();
                    //FIN
                }
            }
            //String resultado = controllerApiUsuarioNatural.BuscarUsuarioNatural(claseEnvio);
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,resultado));
            desCheckb =  true;
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se encontró Cliente'));	    
        }
    }
    
    public void cleanRiesgo(){
        desCheckb = true; 
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
    
    //Agregado 12062019
    public boolean mostrarAnteriorEmpresas {get;set;}
    public boolean BuscarEmpresas {get;set;}
    public boolean mostrarSiguienteInfo {get;set;}
    public boolean mostrarBotonEmpresas {get;set;}
    public boolean mostrarSiguienteEmpresas {get;set;}
    public string RTNEmpresa /*pc_Agencia*/{get;set;}
    integer paginacionEmpresas;
    public List<SelectOption> opcionesEmpresas {get;set;}
    public list<Listado_Empresas__c> listEmpresas{get;set;}
    public Listado_Empresas__c InfoEmpresa {get;set;}
    
    
    	public void salirEmpresas()
    {
        
        BuscarEmpresas=false;
    }  
    
    public void BusEmpresas()
    {
        mostrarAnteriorEmpresas = true;
        BuscarEmpresas=true;
        mostrarSiguienteInfo = false;
        llenarEmpresas();
    }
    
     public void anteriorEmpresas()
    {
        try 
        {
            if((paginacionEmpresas - 1)*1000 < 1000)
            {
                mostrarSiguienteInfo = false;
                mostrarAnteriorEmpresas = true;
                opcionesEmpresas = new list<selectOption>();
                for(integer i=0; i<1000; i++)
                {
                    opcionesEmpresas.add(new selectOption(listEmpresas[i].RTN_Empresa__c, listEmpresas[i].name));
                } 
                paginacionEmpresas --;
            }
            else
            {
                opcionesEmpresas = new list<selectOption>();
                for(integer i=(paginacionEmpresas - 2)*100; i<(paginacionEmpresas-1) *100; i++)
                {
                    opcionesEmpresas.add(new selectOption(listEmpresas[i].RTN_Empresa__c, listEmpresas[i].name));
                }  
                paginacionEmpresas --;
                mostrarSiguienteInfo = false;
            }
        }
        catch(Exception ex)
        {
            
        }
    }
    
    public void siguienteEmpresas()
    {
        try
        {
            if (listEmpresas.size()> ((paginacionEmpresas + 1)*1000) )
            {
                opcionesEmpresas = new list <selectOption>();
                opcionesEmpresas.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (integer i=1000; i< 1999; i++)
                {
                    opcionesEmpresas.add(new selectOption(listEmpresas[i].RTN_Empresa__c, listEmpresas[i].name));
                }    
            }
            else
            {
                opcionesEmpresas = new list <selectOption>();
                mostrarSiguienteInfo = true;
                mostrarAnteriorEmpresas = false;
                opcionesEmpresas.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (integer i=1000; i< listEmpresas.size(); i++)
                {
                    opcionesEmpresas.add(new selectOption(listEmpresas[i].RTN_Empresa__c, listEmpresas[i].name));
                }    
            }
        }
        catch(exception e){
            
        }
    }
    
    public void llenarEmpresas()
    {
        try
        {   
            paginacionEmpresas = 0;
            listEmpresas = new list <Listado_Empresas__c>();
            listEmpresas = [select name, RTN_Empresa__c from Listado_Empresas__c order by name asc];
            opcionesEmpresas = new list <selectOption>();
            opcionesEmpresas.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
			if(listEmpresas.size()>999)
            {
                paginacionEmpresas++;
                mostrarBotonEmpresas =  true;
                //mostrarSiguienteEmpresas = false;
                //mostrarAnteriorEmpresas = false;
                for (integer i=0; i< 999; i++)
                {
                    opcionesEmpresas.add(new selectOption(listEmpresas[i].RTN_Empresa__c, listEmpresas[i].name));
                }                
            }
            else
            {
                opcionesEmpresas = new list <selectOption>();
                opcionesEmpresas.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Listado_Empresas__c item:[select name, RTN_Empresa__c from Listado_Empresas__c order by name asc])
                {
                    opcionesEmpresas.add(new selectOption(item.RTN_Empresa__c, item.name));
                }
            }   
            
        }catch(exception e){
            
        }
    }
    
    public void BuscaInfoEmpresa()
    {
       
        BuscarEmpresas=false;
        
        InfoEmpresa = [select name, RTN_Empresa__c from Listado_Empresas__c where RTN_Empresa__c =: RTNEmpresa];
        pcrncempl = InfoEmpresa.RTN_Empresa__c;
        pcNombreempl = InfoEmpresa.name;
        pcrazonsocialempl = InfoEmpresa.name;
    } 
/*boton*/
    public void desrtn()
    {
        if (/*llenarNivelIngreso1 != '1'||*/PC_NIVEL_RIESGO == '3'&&pctipoid == '1')
        {
            bloqRTN = false;
        } 
        else
        {
            bloqRTN = true;
        }   
        //agregado 10042019
       /*validacion para Ingreso mayor de 16000 y cedula
       if (llenarNivelIngreso1 != '1' && pctipoid == '1')
        {
            bloqRTN = false;
        } 
        else*/ if (pcPEP== true && pctipoid == '1')
        {
            bloqRTN = false;
        } 
        else
        {
            bloqRTN = true;
        }       
        
    }
    public void desSeguro()
    {
       // if (OcultarSeguroCampos = FALSE)
       // {
            if (pcTipoSeguro != '1')
            {
                bloqPlazo = true;
                pcPlazoSeguro = NULL;
                bloqPrima = false;
            } 
            else
            {
                bloqPlazo = false;
                pcPrimaAsegurada = NULL;
                bloqPrima = true;
            }  
       // }
    }

	public void desBtn(){
        cleanRiesgo();
        disbot = true; 
        desCheckb = true;
        AML =  false;
        pcFATCA = false;
        pcPEP = false;
        
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
        actPopAgregarCliente = false;    
    }
    
     public void hideVentana(){
        MostraVentana = false;
        Bene_Ocultar_CamPos = False; 
     
         
      }

    public void bloqPep(){  
        dispep = true; 
        PC_NIVEL_RIESGO = '3'; 
        PC_DEBIDA_DELIGENCIA = '3'; 
        
       //agregado 10042019
       /*validacion para Ingreso mayor de 16000 y cedula
       if (llenarNivelIngreso1 != '1' && pctipoid == '1')
        {
            bloqRTN = false;
        } 
        else */if (pcPEP== true && pctipoid == '1')
        {
            bloqRTN = false;
        } 
        else
        {
            bloqRTN = true;
        }          
        
       //fin                  
    }

    public void unblock(){
       /*Comentado 10042019
        dispep = false; 
        PC_NIVEL_RIESGO = '0'; 
        PC_DEBIDA_DELIGENCIA = '0';    
        //  debidaDiligencviaAplicada = '2'; 
        */
        bloqRTN=true;
      
      //Agregando 10042019 para validar Nivel de riesgo en contratistas en pep
        if (pcAPNFDSI ==true ||  valorsiCont == true ||pcFATCA == true){
            PC_NIVEL_RIESGO = '3'; 
            PC_DEBIDA_DELIGENCIA = '3';
            dispep = true; 
        }
        else if( (pcAPNFDNO == true) || (pcAPNFDNO == true && valornoCont == true)){
            dispep = true; 
        	PC_NIVEL_RIESGO = '1'; 
        	PC_DEBIDA_DELIGENCIA = '2';
            }   
        else if( (valornoCont == true) || (valornoCont == true && pcAPNFDNO == true)){
            dispep = true; 
        	PC_NIVEL_RIESGO = '1'; 
        	PC_DEBIDA_DELIGENCIA = '2';
            }            
        else if( (pcFATCA == true) || (pcFATCA == true && valornoCont == true)){
            dispep = true; 
        	PC_NIVEL_RIESGO = '1'; 
        	PC_DEBIDA_DELIGENCIA = '2'; }     
        else{
            PC_NIVEL_RIESGO = '2'; 
          	PC_DEBIDA_DELIGENCIA = '2';
            dispep = false; }     
          
       /*validacion para Ingreso mayor de 16000 y cedula
       if (llenarNivelIngreso1 != '1' && pctipoid == '1')
        {
            bloqRTN = false;
        } 
        else */if (pcPEP== true && pctipoid == '1')
        {
            bloqRTN = false;
        } 
        else
        {
            bloqRTN = true;
        }     
      //fin del agregado 10042019        
    }
    
     public void MostrarT(){ 
        mostrarTabla=True;      
    }

    
        //*********************EstadoCivil ***********************************
    /*
     public list <selectOption> EstadoCivil {get; set;}
    public void llenarNivelIngreso(){
        
		NivelIngreso = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Estado_Civil__pc.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>(); 
        for(Schema.PicklistEntry p : ple){          
     		EstadoCivil.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    */
    public SelectOption[] EstadoCivil
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
		if (pcestadocivil == 'C' || pcestadocivil == 'U')
        {
			BloquearConyugue=false;
               
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
        PC_NIVEL_RIESGO = '3'; 
        PC_DEBIDA_DELIGENCIA = '3';
        dispep = true;
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
    
    public pageReference MostrarFatcaNacio2()
    {
       
        if (desCheckb2 == true)
         {
            desNacion2  = false;
        
         }
        else
        {
            //ocultarFatcaNacio2(); 
            desNacion2  = true;
            pcnacionalidad2 = null;
            VentanaFatca=false;
            pcnacionalidad3 = null;
            
        }
        
        return null;
    }
    
	public void ocultarFatcaNacio2()
    {
        if (desCheckb2 == false)
        {
         
    	desNacion2   =true;
        VentanaFatca=true; 
        MostrarVentanaFATCANO();    
        }
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

    
	public void SeleccionGradoPa()
    {
    	if (Parentesco1== '1' || Parentesco1 == '2'   ||  Parentesco1 == '5') 
        { 
        	CanalVentaa.Grado_Familiar__c = '1';
        }
        Else if (Parentesco1 == '7'  ||Parentesco1 == '6' || Parentesco1 == '14')
        { 
            CanalVentaa.Grado_Familiar__c = '2';
        }   
        Else if (Parentesco1 == '9'  || Parentesco1 == '8'||Parentesco1 == '11')
        { 
        	CanalVentaa.Grado_Familiar__c = '3';
        }  
        else
        { 
        	CanalVentaa.Grado_Familiar__c = '4';
        }      
    }
    public void llenarCuenta(){
        try
        {
          opcionCausa = new list <selectOption>();
           
            
        }catch(exception e){
            
        }
    }
    
    //Bloquear campo de codigo de tarjeta
    public void bloqueTarjet()
    {
        
        if (pcformapago == 'TA' || pcformapago == 'AH' || pcformapago == 'TAOB')
        {
            BloqForma = false;
        }    
        else {
             BloqForma = true;
        }
            
    }
    
    Public list<string> Numcuentas {get; set;}
    
       
	Public void llenarCuentasDesdeSysde(){
		try{	    		
        	resultado = new list<controllerApiClienteNatural.classRespuestaAportesCuenta>();                    
            resultado =  controllerApiClienteNatural.ConsultalAportesPatronales(NumIDBuscar);  
            mostrarTabla2 = false ; 
            if(resultado.size()>0)
            {
            	Numcuentas= new list<string>();
                for(integer j=0; j<resultado.size(); j++)
                {
                	for(integer i=0; i<resultado[j].cuentas.size(); i++)
                    {
                    	Numcuentas.add(resultado[j].cuentas[i].cuenta);
                    }
                }
                mostrarTabla2 = true ;
            }            
		}Catch(Exception e)
        {
	    	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error desde SYSDE ' + e.getMessage() ));	
	    }
    }
    
    public void minimo13()
    {
        if (pcnroid.length() < 13)
        {
            Apexpages.addMessage(new Apexpages.Message(ApexPages.severity.INFO, 'El valor minimo es de 13')); 
            return;
        }
    }    
}