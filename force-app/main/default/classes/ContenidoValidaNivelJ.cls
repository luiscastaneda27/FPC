public class ContenidoValidaNivelJ {
    //CLIENTE
    public string pcTipoFondo { get; set; }
    public DateTime FECHA_CONSTITUCION { get; set; }
    public string pcGiroEmpresaEmpCN /*RazonSocial*/ { get; set; }
    public string pcAPNFD /*CargoEmpresa*/ { get; set; }
    public string pcFATCA { get; set; }
    public string pcPEP { get; set; }
    //PRODUCTO
    public string pcproducto /*TipoFondo*/ { get; set; }
    //CANAL
    public string pcagencia /*pc_Agencia*/{ get; set; }
    //GEOGRAFICO    
    public string pcDeptoCN /*Depto*/ { get; set; }
    
    public ContenidoValidaNivelJ(string pcTipoFondo,dateTime FECHA_CONSTITUCION,string pcGiroEmpresaEmpC,
                                 string pcAPNFD,string pcFATCA,string pcPEP,string pcproducto, string pcagencia, string pcDeptoCN){
                                     
                                     this.pcTipoFondo=pcTipoFondo;
                                     this.FECHA_CONSTITUCION=FECHA_CONSTITUCION;
                                     this.pcGiroEmpresaEmpCN=pcGiroEmpresaEmpCN; 
                                     this.pcAPNFD=pcAPNFD;
                                     this.pcFATCA=pcFATCA;                      
                                     this.pcPEP= pcPEP;    
                                     this.pcproducto = pcproducto;
                                     this.pcagencia = pcagencia;
                                     this.pcDeptoCN = pcDeptoCN;                                     
                                 }      
}