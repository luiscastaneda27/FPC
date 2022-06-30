public  with sharing class ClienteNaturales { 
    
    public string numtran {get;set;}//Agregado 08/04/2020
    public string TipoPantalla {get;set;}//Agregado 08/04/2020
    
    public string pcEst_cuenta {get;set;}
    public string pcCod_Causa {get;set;}
    public string pc_codCuenta {get;set;}
    
    public string pcempresa /*PCEMPRESA*/{get;set;}
    public string pcagencia /*pc_Agencia*/{get;set;} 
    public string pnnrocertificado /*IDFOrmulario*/{get;set;}
    public string RTN /*TipoID*/{get;set;}
    public datetime pdfechasuscripcion /*FechaSuscripcion*/ {get;set;}
    public string pcPEP{get;set;}
    public string pcFATCA{get;set;}
    public string pcFATCANC{get;set;}
    public string AML{get;set;} /*ESTE NO EN EL PROCEDIMIENTO*/
    public string BLACKLIST{get;set;}
    
    public string pctipoid /*TipoID*/{get;set;}
    public string pcnroid /*NumeroID*/{get;set;}
    
    public dateTime pcFechaVencimientoCN /*FechaVencimiento*/{get;set;}
  
    public string pcprimernombre /*primerNombre*/ {get;set;}
    public string pcsegundonombre /*SegundoNombre*/ {get;set;}
    public string pcsegundoapellido /*SegundoApellido*/ {get;set;}
    public string pcprimerapellido /*primerApellido*/ {get;set;}
    public string pcTelefonoCN {get;set;}
    public string pcCelularCN /*Celular*/ {get;set;}
    public dateTime pdfechanacimiento /*FechaNacimiento*/ {get;set;}
    public string pdLugarNacimientoCN /*LugarNacimiento*/ {get;set;}
    public string pcsexo /*Genero*/ {get;set;}
    public string pcestadocivil /*EstadoCivil*/ {get;set;}
    public string pcNombreConyuge {get;set;}
    public string pcProfesionOcupacion {get;set;}
    //public string pcProfesionOcupacion2 {get;set;}
    //public string pcProfesionOcupacionOtros {get;set;} /*ESTE NO ESTA EN EL PROCEDIMIENTO*/
    public string pcmail /*Correo*/ {get;set;}
    public string pcAPNFD {get;set;}                        
    public string PCNumeroAPNFD {get;set;}  
    public string PC_NIVEL_RIESGO{get;set;}
    public string PC_DEBIDA_DELIGENCIA{get;set;}
    public string pc_ActuaSI{get;set;}
    public string pc_ActuaNombreCompleto{get;set;}
    public string pc_ActuaNumID{get;set;}
    
    //Actua Tercera persona
    public string pc_ActuaSItercera /*SiActuaTerceraPersona*/ {get;set;}
    public string pcNumeroIDPV /*NumeroIDTerceraPersona*/ {get;set;}
    public string FATCARepresentante{get;set;}
    public string FATCANCRepresentante{get;set;}
    //public boolean AMLRepresentante{get;set;}
    public string pcNombreCompletoPV /*NombreCompletoTerceraPersona*/ {get;set;}
    //public string ParentTerceraPer /*Paren Tercera Persona*/ {get;set;}
    
    //CargoEjercido
    
    public string OcultaCarSI /*Paren  Persona*/ {get;set;}
    public string pcCargoEjercido /*Paren  Persona*/ {get;set;}
    public string pcEjerce_Cargo_Publico {get;set;}
    public string Cargo_Pulbico {get;set;}
    public string periodoPep {get;set;}
    public string institucionPep {get;set;}
    
    //DependenciaEconomica
    public string pcDependeSI /*siDependencia*/ {get;set;}
    public string pcDependeNO /*NoDependencia*/ {get;set;}
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
    
    //EMpleadorDIreccion
    
    public string pcPaisEmpleadorCN{get;set;}
    public string vccodpais{get;set;}
    public string pcDeptoEmpleadorCN{get;set;}
    public string pcMunicipioEmpleadorCN{get;set;}
    public string pcColoniaEmpleadorCN{get;set;}
    //Public string nacionalidadEmpleado{get;set;}
    Public string pcdirempl {get;set;}
    
    
    //DatoEmpleado
    
    public string pcTIpoEmpleado /*TipoEmpleado*/ {get;set;}
    public dateTime pdfechainiciolabor{get;set;}
    public string pcNivelIngreso /*NivelIngreso*/ {get;set;}
    //public string pcVolumenIngresoCN /*VolumenIngreso*/ {get;set;}
    
    
    //DatoEmpleado
    public string pcUsuarioCN /*pc_Empresa*/ {get;set;}
    //public string pcAgn { get; set; }
    public dateTime pcFechaValidacionCN /*FechaValidacion*/ {get;set;}
    
    //PantallaProducto
    
    public string pcproducto /*Producto*/ {get;set;}
    public string pcsubproducto /*Subproducto*/ {get;set;}
    public string pcTipoFondo /*TipoFondo*/ {get;set;}
    public string pcTipoMoneda /*TipoMoneda*/ {get;set;}
    public string pcperiodicidad /*Periodicidad*/ {get;set;}
    public string pcformapago /*FormaPago*/ {get;set;}
    public string pcDiaAportacion /*DiaAportacion*/ {get;set;}
    public Integer pnmontoaporte /*MontoAporte*/ {get;set;} //Campo Cambiado a entero
    public Integer pnmontoaporte12 /*MontoAporte*/ {get;set;} 
    public string pccuentapago /*CuentaCTA*/ {get;set;}
    public string pcSalarioP /*salario*/ {get;set;}
    //public string pcAportacionEmpleadoP /*AporEmpleado*/ {get;set;}
    //public string pcAportacionTrabajoP /*AporTrabajo*/ {get;set;}
    public string pcaplicaseguro /*AplicaSeguroSI*/ {get;set;}
    public string AplicaSeguroNO{get;set;}
    public string pcPrimaAsegurada /*PrimaSeguro*/ {get;set;}
    public string pcSumaAsegurada /*MontoSeguro*/ {get;set;}
    public string pcTipoSeguro {get;set;}
    public string pcPlazoSeguro {get;set;}
    public dateTime pcfecCancelaSeguro {get;set;}
    public string pcNUMUSU /*Numusu*/ {get;set;}
    public string pcenvio /*EnvioCorreo*/ {get;set;}
    public string pcTipoAporte /*TipoAporte*/ {get;set;}
    Public String v_des_procedfds /*Origen Fondos*/  {get;set;}
    //Public String Codigo_Ente /*CodigoEnte*/  {get;set;}
    /////////////////////////////////////
    public string pcpromotor /*promotorProducto*/ {get;set;}
    //public string pcCanalVentas /*CanalVentas*/ {get;set;}
    Public String pctiposolicitud /*TipoSolictud "I" O "C" */  {get;set;}

    //Campos Fatca
    public string ES_Residente{get;set;}
    public string ES_Residente_EfectosMi{get;set;}
    
    public string PaisResidenciaEfectosFiscales{get;set;}
    public string NumeroID_Fiscal_EEUU{get;set;}
    public string NumeroID_Fiscal_OtroPais{get;set;}
    //
    public date fechasuscripcion{get;set;}
    public date fechaVencimiento{get;set;}
    public date fechaNacimiento{get;set;}
    public date fechaLabor{get;set;}
    public date fechaValida{get;set;}

    public String usuarioActualiza { get; set; }
    public String usuarioAprueba { get; set; }
    public String pcPaisNacimiento { get; set; }
    
    //Lista para mostrar los datos de beneficiarios
    public List<beneficiario> ListBeneficiarios {get;set;}
    public List<beneficiario> ListBeneficiariosC {get;set;}
    public string V_fo_cuenta /*Contener La Informacion de cuentas*/ {get;set;}
    public List<claseDebidaDilContratista> ListDebidaDil {get;set;}
    public List<ClassTelefono> ListTelefonos {get;set;}
    public List<ClassDirecion> ListDirecciones { get; set; }
    public ClienteNaturales()
     {
        ListBeneficiarios =new List<beneficiario>(); 
        ListBeneficiariosC =new List<beneficiario>(); 
        ListDebidaDil = new List<claseDebidaDilContratista>();
        ListTelefonos = new List<ClassTelefono>();
        ListDirecciones = new List<ClassDirecion>();
     }
    
}