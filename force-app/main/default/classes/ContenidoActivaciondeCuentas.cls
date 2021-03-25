public class ContenidoActivaciondeCuentas {

    public string NoCuenta;
    public string NoIdentidad;
    public string EstadoActual;
    public string Causa;
    public string EstadoNuevo;  
    public string CausaNueva;
    //public string Situacion;
    public string Registrador;
    public string Autorizador;
    // 
    public decimal id;
    public datetime FechaCarga;   
    public string Descripcion;
     
    public ContenidoActivaciondeCuentas(string NoCuenta, string NoIdentidad, string EstadoActual, string Causa,
                                         string EstadoNuevo, string CausaNueva, /*string Situacion,*/ string Registrador, 
                                         string Autorizador, decimal id, datetime FechaCarga,string Descripcion){
                                       
                                 this.NoCuenta= NoCuenta;
                                 this.NoIdentidad= NoIdentidad;
                                 this.EstadoActual= EstadoActual;
                                 this.Causa= Causa;
                                 this.EstadoNuevo= EstadoNuevo;
                                 this.CausaNueva= CausaNueva;
                                // this.Situacion= Situacion; no va esta variable
                                 this.Registrador= Registrador;
                                 this.Autorizador= Autorizador;
                                 this.id=id;
                                 this.FechaCarga =FechaCarga;
                                 this.Descripcion = Descripcion;
        }
}