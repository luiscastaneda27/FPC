public class ClassPantJuridicoProduc {

    public string pcEst_cuenta {get;set;}
    public string pcCod_Causa {get;set;}
    public string pc_codCuenta {get;set;}
    public string pcempresa /*PCEMPRESA*/{get;set;}
    public string pcagencia /*pc_Agencia*/{get;set;}
    public string pnnrocertificado /*IDFOrmulario*/{get;set;}
    public datetime pdfechasuscripcion /*FechaSuscripcion*/ {get;set;}
    public string pcPEP{get;set;}
    public string AML{get;set;} /*ESTE NO EN EL PROCEDIMIENTO*/
    public string pcFATCA{get;set;}
    public string pctipoid /*TipoID*/{get;set;}
    public string pcnroid /*NumeroID*/{get;set;}
    public dateTime pcFechaVencimientoCN /*FechaVencimiento*/{get;set;} /*Se envia nulo*/
  public string pcprimerapellido{get;set;} /*Se envia nulo*/
  public string pcsegundoapellido /*SegundoApellido*/ {get;set;} /*Se envia nulo*/
    public string pcprimernombre /*primerNombre*/ {get;set;} /*Se envia nulo*/
    public string pcsegundonombre /*SegundoNombre*/ {get;set;} /*Se envia nulo*/ 
    
    
    public string pcTelefonoCN {get;set;}
    public string pcCelularCN /*Celular*/ {get;set;} /*Se envia nulo*/
    public dateTime pdfechanacimiento /*FechaNacimiento*/ {get;set;} /*Se envia nulo*/
    public string pdLugarNacimientoCN /*LugarNacimiento*/ {get;set;} /*Se envia nulo*/
    public string pcsexo /*Genero*/ {get;set;} /*Se envia nulo*/
    public string pcestadocivil /*EstadoCivil*/ {get;set;} /*Se envia nulo*/
    public string pcNombreConyuge {get;set;} /*Se envia nulo*/
    public string pcProfesionOcupacion {get;set;}/*Se envia nulo*/ 
    public string pcmail /*Correo*/ {get;set;}
    public string pcAPNFD {get;set;}                        
    public string PCNumeroAPNFD {get;set;}  
    public string PC_DEBIDA_DELIGENCIA{get;set;}
    public string PC_NIVEL_RIESGO{get;set;}
   

    
    //Actua Tercera persona
    public string pc_ActuaSI /*SiActuaTerceraPersona*/ {get;set;}
    public string pcNumeroIDPV /*NumeroIDTerceraPersona*/ {get;set;}
    public string pcNombreCompletoPV /*NombreCompletoTerceraPersona*/ {get;set;}

    
    //CargoEjercido
    
    public string pcEjerce_Cargo_Publico {get;set;}
    public string Cargo_Pulbico {get;set;}
    
    //DependenciaEconomica
    public string pcDependeSI /*siDependencia*/ {get;set;}
    public string pcDependeNO /*NoDependencia*/ {get;set;} /*Se envia nulo*/
    public string pcTipoIDDependencia /*TipoID_DependenciaEconomica*/ {get;set;} /*Se envia nulo*/
    public string pcNumeroIDDependencia /*NumeroID_DependenciaEconomica */ {get;set;} /*Se envia nulo*/
    public string pcParentescoDependencia /*Parentesco_DependenciaEconomica*/ {get;set;} /*Se envia nulo*/
    public string pcNombreCompletoDependencia /*NombreCompleto_DependenciaEconomica*/ {get;set;}
    
    //InfoDireccion
    public string pccodpais /*Pais_Direccion*/ {get;set;}
    public string pcDeptoCN /*Depto_Direccion*/ {get;set;}
    public string pcMunicipioCN /*Municipio_Direccion*/ {get;set;}
    public string pcColoniaCN /*Colonia_Direccion*/{get;set;}
    public string pcCalleDetalleCN /*Calle_Direccion*/ {get;set;}
    public string pcnacionalidad /*Nacionalidad1_Direccion*/ {get;set;} /*Se envia nulo*/
    public string pcnacionalidad2 /*Nacionalidad2_Direccion*/ {get;set;} /*Se envia nulo*/
    public string pcnacionalidad3 /*Nacionalidad3_Direccion*/ {get;set;} /*Se envia nulo*/
    
    //referencias
    public string pcPrimerNombreReferi1 /*PrimerNombre_referencia*/ {get;set;} /*Se envia nulo*/
    public string pcSegundoNombreReferi1 /*SegundoNombre_referencia*/ {get;set;} /*Se envia nulo*/
    public string pcPrimerApellidoReferi1 /*PrimerApellido_referencia*/ {get;set;}/*Se envia nulo*/
    public string pcSegundoApellidoReferi1 /*SegundoApellido_referencia*/ {get;set;}/*Se envia nulo*/
    public string pcTelefono_Referido1Referi1 /*Telefono_referencia*/ {get;set;}/*Se envia nulo*/
    
    public string pcPrimerNombreReferi2 /*PrimerNombre_referencia*/ {get;set;}/*Se envia nulo*/
    public string pcSegundoNombreReferi2 /*SegundoNombre_referencia*/ {get;set;}/*Se envia nulo*/
    public string pcPrimerApellidoReferi2 /*PrimerApellido_referencia*/ {get;set;}/*Se envia nulo*/
    public string pcSegundoApellidoReferi2 /*SegundoApellido_referencia*/ {get;set;}/*Se envia nulo*/
    public string pcTelefono_ReferidoReferi2 /*Telefono_referencia*/ {get;set;}/*Se envia nulo*/
    
    //DatoEMpleador
    
    public string pccontratocolectivo{get;set;} /*contrato colectivo*/ /*Se envia nulo*/
    public string pcrncempl /*RTN*/ {get;set;}
    public string pcTipoEmpresaEmpCN /*TipoEmpresa*/ {get;set;} /*Se envia nulo*/
    public string pcNombreempl{get;set;}/*NombreEmpresaEmpleador*/
    public string pcrazonsocialempl /*RazonSocial*/ {get;set;}
    public string pcCargoEmpresaEmpCN /*CargoEmpresa*/ {get;set;}/*Se envia nulo*/
    public string pcGiroEmpresaEmpCN /*GiroEmpresa*/ {get;set;}/*Se envia nulo*/
    public string pctelempl{get;set;} /*telefonoEmpleador*//*Se envia nulo*/
    public string pcextempl{get;set;} /*ExtensionEmpleador*//*Se envia nulo*/
    public string pcmailempl{get;set;} /*MailEmpleador*//*Se envia nulo*/
    
    //EMpleadorDIreccion
    
    public string pcDeptoEmpleadorCN{get;set;}/*Se envia nulo*/
    public string pcMunicipioEmpleadorCN{get;set;}/*Se envia nulo*/
    public string pcColoniaEmpleadorCN{get;set;}/*Se envia nulo*/
    //Public string nacionalidadEmpleado{get;set;}
    Public string pcdirempl {get;set;}/*Se envia nulo*/
    
    
    //DatoEmpleado
    
    public string pcTIpoEmpleado /*TipoEmpleado*/ {get;set;} /*Se envia nulo*/
    public dateTime pdfechainiciolabor{get;set;}
    public string pcNivelIngreso /*NivelIngreso*/ {get;set;}
    //public string pcVolumenIngresoCN /*VolumenIngreso*/ {get;set;}
    
    
    //DatoEmpleado
    public string pcUsuarioCN /*pc_Empresa*/ {get;set;}
    public dateTime pcFechaValidacionCN /*FechaValidacion*/ {get;set;}
    
    //PantallaProducto
    
    public string pcproducto /*Producto*/ {get;set;}
    public string pcsubproducto /*Subproducto*/ {get;set;}
    public string pcTipoFondo /*TipoFondo*/ {get;set;}
    public string pcTipoMoneda /*TipoMoneda*/ {get;set;}
    public string pcperiodicidad /*Periodicidad*/ {get;set;}
    public string pcformapago /*FormaPago*/ {get;set;}
    public string pcDiaAportacion /*DiaAportacion*/ {get;set;} /*Se envia nulo*/
    //public Integer pnmontoaporte /*MontoAporte*/ {get;set;} //Campo Cambiado a entero
    //public Integer pnmontoaporte12 /*MontoAporte*/ {get;set;} 
    public string pnmontoaporte /*MontoAporte*/ {get;set;} //Campo Cambiado a entero
    //public Integer pnmontoaporte12 /*MontoAporte*/ {get;set;} 
    public string pccuentapago /*CuentaCTA*/ {get;set;} 
    public string pcSalarioP /*salario*/ {get;set;}/*Se envia nulo*/
    public string pcAportacionEmpleadoP /*AporEmpleado*/ {get;set;} 
    public string pcAportacionTrabajoP /*AporTrabajo*/ {get;set;}
    public string pcaplicaseguro /*AplicaSeguroSI*/ {get;set;} /*Se envia nulo*/
    public string pcPrimaAsegurada /*PrimaSeguro*/ {get;set;} /*Se envia nulo*/
    public string pcSumaAsegurada /*MontoSeguro*/ {get;set;}/*Se envia nulo*/
    public string pcNUMUSU /*Numusu*/ {get;set;}/*Se envia nulo*/
    public string pcenvio /*EnvioCorreo*/ {get;set;}
    public string pcTipoAporte /*TipoAporte*/ {get;set;} /*Se envia nulo*/
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
    //public date fechasuscripcion{get;set;}
    //public date fechaVencimiento{get;set;}
    //public date fechaNacimiento{get;set;}
    //public date fechaLabor{get;set;}
    //public date fechaValida{get;set;}
    
     //ampos agregados para la parte Juridico
                        public string COT_BOLSA {get;set;}
                        public string  TIC_SYMBOL  {get;set;}
                         public string OTROS_OBLIG {get;set;}
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
                          public datetime FECHA_CONSTITUCION {get;set;}
                          public string COD_REPRE_LEGAL {get;set;}
    	public string DIR_CORRESPONDENCIA {get;set;}
    					  public string GIIN {get;set;}
    					  public string ENTIDAD_FINANCIERA {get;set;}
    					  public string ACC_10DE_CONTROL {get;set;}
    					  public string INST_FINANCIERA {get;set;}
    					  public string TIP_ENTIDAD {get;set;}
    					  public string ACTIV_PASIVO {get;set;}
    
    
     
    
    					  public string NOM_REPRE_LEGAL {get;set;}
                          public string CARGO_REPRE_LEGAL {get;set;}
    						
    					  PUBLIC string NOM_FIRMAN1 {get;set;}
    				      PUBLIC string NOM_FIRMAN2 {get;set;}
                          PUBLIC string NOM_FIRMAN3 {get;set;}
                          PUBLIC string NUMID_FIRMAN1 {get;set;}
    				      PUBLIC string NUMID_FIRMAN2 {get;set;}
                          PUBLIC string NUMID_FIRMAN3 {get;set;}
    PUBLIC string pcnumeroidsoc {get;set;}
    PUBLIC string tipo_persona {get;set;}
    PUBLIC string nombresocio {get;set;}
    PUBLIC string nacionalidad {get;set;}
    
    
        				  
    
                           public string V_fo_cuenta /*Contener La Ijnformacion de cuentas*/ {get;set;}
    
    public List<socios> ListSocios {get;set;}
    public List<SociosTIN> ListSociosTIN {get;set;}
    
        //Agregado 10-04-2019
    
    public string ValorEmpresaMercaSI {get;set;}
    public string ValorPersonaUsaSI {get;set;}
    
	public List<DebidaDiliClienteONG> ListClienteONG {get;set;}
    public List<claseDebidaDilContratista> ListDebidaDil {get;set;}
    
    public ClassPantJuridicoProduc()
    {
        ListSocios =new List<socios>(); 
        ListSociosTIN =new List<SociosTIN>();
         ListClienteONG = new List<DebidaDiliClienteONG>(); //Agregado 10-04-2019 
        ListDebidaDil = new List<claseDebidaDilContratista>(); //Agregado 10-04-2019    
     }
    
    
    
  
    
    
    
}