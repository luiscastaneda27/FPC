public class ContenidoValidaNivel {
    //CLIENTE
    public string pctipoid /*Tipo DOCUMENTO*/{get;set;}
    public dateTime pdfechanacimiento /*FechaNacimiento*/ {get;set;}
    //public string pcTrabaja /*TipoFondo*/ {get;set;}  
    public string pcrazonsocialempl /*RazonSocial*/ {get;set;}
    public string pcNombreempl /*CargoEmpresa*/ {get;set;}
    public string pcProfesionOcupacion {get;set;}  
    //public string pcExcepciones {get;set;}   
    public string pcAPNFD {get;set;}  
    public string pcFATCA{get;set;}
    public string pcPEP{get;set;}
    public string pccodpais /*Pais_Direccion*/ {get;set;}
    //PRODUCTO
    public string pcTipoFondo /*TipoFondo*/ {get;set;}
    //CANAL
    public string pcagencia /*pc_Agencia*/{get;set;}
    //GEOGRAFICO    
    public string pcMunicipioCN /*Municipio_Direccion*/ {get;set;}
    public string pcnacionalidad /*Nacionalidad1_Direccion*/ {get;set;}
    
    public ContenidoValidaNivel(string pctipoid,dateTime pdfechanacimiento,string pcrazonsocialempl,string pcNombreempl,string pcProfesionOcupacion,
                                string pcAPNFD,string pcFATCA,string pcPEP, string pccodpais, string pcTipoFondo,string pcagencia, string pcMunicipioCN, string pcnacionalidad){
                                    
                                    this.pctipoid=pctipoid;
                                    this.pdfechanacimiento=pdfechanacimiento;
                                    this.pcrazonsocialempl=pcrazonsocialempl;
                                    this.pcNombreempl=pcNombreempl;
                                    this.pcProfesionOcupacion =pcProfesionOcupacion;
                                    this.pcAPNFD=pcAPNFD;
                                    this.pcFATCA=pcFATCA;                      
                                    this.pcPEP= pcPEP; 
                                    this.pccodpais= pccodpais;  
                                    this.pcTipoFondo =pcTipoFondo;
                                    this.pcagencia = pcagencia;
                                    this.pcMunicipioCN = pcMunicipioCN;
                                    this.pcnacionalidad= pcnacionalidad;
                                    
                                }   
    
}