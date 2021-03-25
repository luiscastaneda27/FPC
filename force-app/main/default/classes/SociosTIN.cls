public class SociosTIN {
    
    public decimal idGuardar{get;set;}
    public string AI_ID_EXTERNO {get;set;}
    public string PCNumeroID_TIN{get;set;}
    public string pcNombreCompleto_TIN{get;set;} 
    public string pcDireccion_TIN{get;set;}
    public string PCTIN_TIN {get;set;}
    
   
    public SociosTIN(decimal idGuardar,string PCNumeroID_TIN, string pcNombreCompleto_TIN, string pcDireccion_TIN, string PCTIN_TIN )
    {
        this.idGuardar=idGuardar;
        this.PCNumeroID_TIN=PCNumeroID_TIN;
        this.pcNombreCompleto_TIN=pcNombreCompleto_TIN;
        this.pcDireccion_TIN=pcDireccion_TIN;
        this.PCTIN_TIN=PCTIN_TIN; 
    }

}