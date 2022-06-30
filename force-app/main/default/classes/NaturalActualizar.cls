public with sharing class NaturalActualizar {
	public string V_fo_cuenta {get;set;}
    public string numtran {get;set;} //Agregado 08/04/2020
    public string pcEst_cuenta {get;set;}
    public string pcCod_Causa {get;set;}
    public string RTN {get;set;}
    public string pcPEP {get;set;}
    public string pcFATCA {get;set;}
    public string pcFATCANC {get;set;}
    public string pctipoid {get;set;}
    public string pcnroid {get;set;}
    public dateTime pcFechaVencimientoCN {get;set;}
    public string pcprimerapellido {get;set;}
    public string pcsegundoapellido {get;set;}
    public string pcprimernombre {get;set;}
    public string pcsegundonombre {get;set;}
    public string pcTelefonoCN {get;set;}
    public string pcCelularCN {get;set;}
    public dateTime pdfechanacimiento {get;set;}
    public string pdLugarNacimientoCN {get;set;}
    public string pcsexo {get;set;}
    public string pcestadocivil {get;set;}
    public string pcNombreConyuge {get;set;}
    public string pcProfesionOcupacion {get;set;}
    public string pcmail {get;set;}
    public string pcAPNFD {get;set;}                        
    public string PCNumeroAPNFD {get;set;}  
    public string PC_DEBIDA_DELIGENCIA {get;set;}
    public string PC_NIVEL_RIESGO {get;set;}
    public string pc_ActuaSI {get;set;}
    public string pcNumeroIDPV {get;set;}
    public string FATCARepresentante{get;set;}
    public string FATCANCRepresentante{get;set;}
    public string pcNombreCompletoPV {get;set;}
    public string OcultaCarSI {get;set;}
    public string pcEjerce_Cargo_Publico {get;set;}
    public string pcCargoEjercido {get;set;}
    public string periodoPep {get;set;}
    public string institucionPep {get;set;}
    public string pcDependeSI {get;set;}
    public string pcDependeNO {get;set;}
    public string pcTipoIDDependencia {get;set;}
    public string pcNumeroIDDependencia {get;set;}
    public string pcNombreCompletoDependencia {get;set;}
    public string pccodpais {get;set;}
    public string pcDeptoCN {get;set;}
    public string pcMunicipioCN {get;set;}
    public string pcCalleDetalleCN {get;set;}
    public string pcColoniaCN {get;set;}
    public string pcnacionalidad {get;set;}
    public string pcnacionalidad2 {get;set;}
    public string pcnacionalidad3 {get;set;}
    public string pcPrimerNombreReferi1 {get;set;}
    public string pcSegundoNombreReferi1 {get;set;}
    public string pcPrimerApellidoReferi1 {get;set;}
    public string pcSegundoApellidoReferi1 {get;set;}
    public string pcTelefono_Referido1Referi1 {get;set;}
    public string pcPrimerNombreReferi2 {get;set;}
    public string pcSegundoNombreReferi2 {get;set;}
    public string pcPrimerApellidoReferi2 {get;set;}
    public string pcSegundoApellidoReferi2 {get;set;}
    public string pcTelefono_ReferidoReferi2 {get;set;}
    public string pccontratocolectivo{get;set;}
    public string pcrncempl {get;set;}
    public string pcTipoEmpresaEmpCN {get;set;}
    public string pcNombreempl {get;set;}
    public string pcrazonsocialempl {get;set;}
    public string pcCargoEmpresaEmpCN {get;set;}
    public string pcGiroEmpresaEmpCN {get;set;}
    public string pctelempl {get;set;}
    public string pcextempl {get;set;}
    public string pcmailempl {get;set;}
    public string pcPaisEmpleadorCN{get;set;}
    public string vccodpais{get;set;}
    public string pcDeptoEmpleadorCN{get;set;}
    public string pcMunicipioEmpleadorCN{get;set;}
    public string pcColoniaEmpleadorCN{get;set;}
    Public string pcdirempl {get;set;}
    public string pcTIpoEmpleado {get;set;}
    public dateTime pdfechainiciolabor{get;set;}
    public string pcNivelIngreso {get;set;}
    public string pcUsuarioCN {get;set;}
    public dateTime pcFechaValidacionCN {get;set;}
    public string pcproducto {get;set;}
    public string pcsubproducto {get;set;}
    public string pcTipoFondo {get;set;}
    public string pcTipoMoneda {get;set;}
    public string pcperiodicidad {get;set;}
    public string pcformapago {get;set;}
    public string pcDiaAportacion {get;set;}
	public Integer pnmontoaporte {get;set;}
    public Integer pnmontoaporte12 {get;set;} 
    public string pccuentapago {get;set;}
    public string pcaplicaseguro {get;set;}
    public string pcPrimaAsegurada {get;set;}
    public string pcSumaAsegurada {get;set;}
    public string pcTipoSeguro {get;set;}
    public string pcPlazoSeguro {get;set;}
    public dateTime pcfecCancelaSeguro {get;set;}
    public string pcNUMUSU {get;set;}
    public string pcenvio {get;set;}
    public string pcTipoAporte {get;set;}
    Public String v_des_procedfds {get;set;}
    public string pcpromotor {get;set;}
    public string ES_Residente{get;set;}
    public string ES_Residente_EfectosMi{get;set;}
    public string PaisResidenciaEfectosFiscales{get;set;}
    public string NumeroID_Fiscal_EEUU{get;set;}
    public string NumeroID_Fiscal_OtroPais{get;set;}
    public String paisNacimiento { get; set; }
    public String pcPaisNacimiento { get; set; }

    
    public List<beneficiario> ListBeneficiarios {get;set;}
    public List<beneficiario> ListBeneficiariosC {get;set;}
    //lista debida diligencia
    public List<claseDebidaDilContratista> ListDebidaDil {get;set;}
     public List<ClassTelefono> ListTelefonos {get;set;}
    public List<ClassDirecion> ListDirecciones { get; set; }
    public NaturalActualizar()
    {
        ListBeneficiariosC =new List<beneficiario>();
    	ListBeneficiarios =new List<beneficiario>();
        ListDebidaDil = new List<claseDebidaDilContratista>();
        ListTelefonos = new List<ClassTelefono>();
        ListDirecciones = new List<ClassDirecion>();
    }
}