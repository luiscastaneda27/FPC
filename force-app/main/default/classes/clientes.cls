public class clientes {
    
    public string idRezago{get;set;}
    public string usuIngresaRezago{get;set;}
    public string montoRezago{get;set;} 
    public string fondo{get;set;}
    public string codReferencia{get;set;}
    public datetime fechaDeposito{get;set;}
    public string codigoMoneda{get;set;}
    public string descripcion{get;set;}
    public string descripcionNota{get;set;}
    public string codBanco{get;set;}
    public string agnBanco{get;set;}
    public string rezagoSINO{get;set;}
    public string asesor{get;set;}
    public string estado{get;set;}
    public string valorCuotaEntrada{get;set;}
    public datetime fecInclusion{get;set;}
    public string incluidoPor{get;set;}
    public datetime fecModificacion{get;set;}
    public string modificadoPor{get;set;}
    
    public clientes(string idRezago, string montoRezago, string fondo, string codReferencia, datetime fechaDeposito, string codigoMoneda, string descripcion, string descripcionNota,
                   string usuIngresaRezago, string codBanco, string agnBanco, string rezagoSINO, string asesor, string estado, String valorCuotaEntrada, datetime fecInclusion, 
                    string incluidoPor, datetime fecModificacion, string modificadoPor){
                      
		this.idRezago = idRezago;
        this.montoRezago = montoRezago;
        this.fondo = fondo;
        this.codReferencia = codReferencia;
        this.fechaDeposito = fechaDeposito;     
        this.codigoMoneda = codigoMoneda;
        this.descripcion = descripcion;
        this.descripcionNota = descripcionNota;
		this.usuIngresaRezago = usuIngresaRezago;
        this.codBanco = codBanco;       
        this.agnBanco = agnBanco;
        this.rezagoSINO = rezagoSINO;
        this.asesor = asesor;
        this.estado = estado;
        this.valorCuotaEntrada = valorCuotaEntrada;
		this.fecInclusion = fecInclusion;
        this.incluidoPor = incluidoPor;
		this.fecModificacion = fecModificacion;
		this.modificadoPor = modificadoPor;
    }
}