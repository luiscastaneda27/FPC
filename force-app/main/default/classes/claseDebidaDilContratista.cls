public class claseDebidaDilContratista {
    public decimal CodContratista {get;set;}
    public string Contratista {get;set;}
    public string tipoContrDirecto {get;set;}
    public string tipoContrSubcontratado {get;set;}
    public string NombreProyecto {get;set;}
    public string Ubicacion {get;set;}
    public string TipoProyecto {get;set;}
    public string BeneficioProyecto {get;set;}
    public Decimal Valor {get;set;}
    public string D_tipoPersona {get;set;}
    
    public claseDebidaDilContratista(decimal CodContratista,string Contratista, string tipoContrDirecto, string tipoContrSubcontratado, string NombreProyecto, string Ubicacion, 
                                     string TipoProyecto, string BeneficioProyecto, Decimal Valor, string D_tipoPersona)
        
    {
        this.CodContratista=CodContratista;
        this.Contratista = Contratista;
        this.tipoContrDirecto = tipoContrDirecto;
        this.tipoContrSubcontratado = tipoContrSubcontratado;
        this.NombreProyecto = NombreProyecto;
        this.Ubicacion = Ubicacion;
        this.TipoProyecto = TipoProyecto;
        this.BeneficioProyecto = BeneficioProyecto;  
        this.Valor = Valor;
        this.D_tipoPersona = D_tipoPersona;
    }    
    
}