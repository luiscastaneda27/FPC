public class classAportes {
	 public string Cuenta {get;set;}
     public string NombreCompleto {get;set;}
     public string Moneda {get;set;} 
     public date FechaDeposito {get;set;}  
     public string Monto {get;set;}  
     public string FormaPago {get;set;}
     public string TipoSaldo {get;set;}
     public string Cod_referencia {get;set;} /*En esta variable se cargara una imagen*/
     public string ComisionSI {get;set;} /*Aplica Comision*/
     public string ComisionNO {get;set;} /*No Aplica Comision*/
     public string Comprobante {get;set;} /*En esta variable se cargara una imagen*/
   
    
    //Variables nuevas
    public double montoDecimal {get;set;} 
    public date fechaAporteDate {get;set;}
    public string fechaAporte {get;set;}
    public integer indice {get;set;}
   
     /*
     public classAportes(string Cuenta, string NombreCompleto, string Moneda, date FechaDeposito, integer Monto, 
                         string FormaPago, string TipoSaldo, string Cod_referencia, string ComisionSI,string Comprobante)
    {
        this.Cuenta=Cuenta;
        this.NombreCompleto=NombreCompleto;
        this.Moneda=Moneda;
        this.FechaDeposito=FechaDeposito;
        this.Monto=Monto;
        this.FormaPago=FormaPago;
        this.TipoSaldo=TipoSaldo;
        this.Cod_referencia=Cod_referencia;
        this.ComisionSI=ComisionSI;
        this.Comprobante=Comprobante;
   }
   */
    
}