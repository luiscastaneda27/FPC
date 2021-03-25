public class ContenidoCambioAsesor {

    public string NCuenta;
    public string Identidad;
    public string AsesorActual;
    public string AsesorNuevo;
    public string Registrador;
    public string Autorizador; 
    public decimal id;
    public datetime FechaCarga;   
    public string Descripcion;
    
    public ContenidoCambioAsesor(string NCuenta,string Identidad,string AsesorActual,string Asesornuevo,
                                  string Registrador,string Autorizador, decimal id, datetime FechaCarga,string Descripcion){
        
            this.NCuenta=NCuenta;
            this.Identidad=Identidad;
            this.AsesorActual=AsesorActual;
            this.AsesorNuevo=AsesorNuevo;
            this.Registrador=Registrador;
            this.Autorizador=Autorizador;   
            this.id=id;                             
            this.FechaCarga= FechaCarga; 
            this.Descripcion= Descripcion;  
	}   

      
}