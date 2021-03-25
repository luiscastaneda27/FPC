public class ClassTelefono {
    public string numTelefono {get;set;}
	public decimal extension {get;set;}
    public string usuario {get; set;}
    public string tipTelefono{get; set;}
    public string esDefault {get;set;}
    public decimal Secuencia {get;set;}
    public string TelUbicacion {get;set;}
    
    public ClassTelefono(string numTelefono, decimal extension, string usuario, string tipTelefono
                         , string esDefault, decimal Secuencia, string TelUbicacion){
        this.numTelefono =numTelefono;
        this.extension=extension;
        this.usuario=usuario;
        this.tipTelefono=tipTelefono;
        this.esDefault=esDefault;
        this.Secuencia=Secuencia; 
        this.TelUbicacion=TelUbicacion;
                             
    }
}