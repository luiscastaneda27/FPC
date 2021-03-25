public class DebidaDiliClienteONG {
    public decimal CodClienteONG {get;set;}
    public string ClienteONG {get;set;}
    public string TipoDonacionesPrivada {get;set;}
    public string TipoDonacionesGobierno {get;set;}
    public string Nombre {get;set;}
    public string MedioPago {get;set;}
    public string Domicilio {get;set;}
    public string Frecuencia {get;set;}
    public decimal Monto {get;set;}
    
    public DebidaDiliClienteONG(decimal CodClienteONG, string ClienteONG, string TipoDonacionesPrivada, string TipoDonacionesGobierno, string Nombre,
                               string MedioPago, string Domicilio, string Frecuencia, decimal Monto){
        
        this.CodClienteONG = CodClienteONG;
        this.ClienteONG = ClienteONG;
        this.TipoDonacionesPrivada = TipoDonacionesPrivada;
        this.TipoDonacionesGobierno = TipoDonacionesGobierno;
        this.Nombre = Nombre;
        this.MedioPago = MedioPago;
        this.Domicilio = Domicilio;
        this.Frecuencia = Frecuencia;
        this.Monto = Monto;
    }

}