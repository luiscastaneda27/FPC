public class clientes {
    
	//public decimal idRezago{get;set;} 
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
    public string incluidoPor{get;set;} 
    
    public clientes(/*decimal idRezago, */string montoRezago, string fondo, string codReferencia, datetime fechaDeposito, string codigoMoneda, string descripcion, string descripcionNota, 
                  string codBanco, string agnBanco, string rezagoSINO, string asesor, string estado, string incluidoPor){
        //this.idRezago = idRezago;
        this.montoRezago = montoRezago;
        this.fondo = fondo;
        this.codReferencia = codReferencia;
        this.fechaDeposito=fechaDeposito;     
        this.codigoMoneda=codigoMoneda;
        this.descripcion=descripcion;
        this.descripcionNota=descripcionNota;
        this.codBanco=codBanco;       
        this.agnBanco=agnBanco;
        this.rezagoSINO=rezagoSINO;
        this.asesor=asesor;
        this.estado=estado;
        this.incluidoPor=incluidoPor;
    }
}