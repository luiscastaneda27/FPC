public class InteresesEspecificos {
    
    public Decimal MontoPago { get; set; }
    public string Tipo_de_Saldo { get; set; }
    public Decimal idGuardar { get; set; }
        /*
    public Date DiadePago { get; set; }
    public string Cuenta { get; set; }
    public string primerNombre { get; set; }
    public string segundoNombre { get; set; }
    public string primerApellido { get; set; }
    public string segundoApellido { get; set; }
    public string Identidad { get; set; }
    public string TipoInteres { get; set; }
    public string FormadePago { get; set; }
    public string Porcentajedelogro { get; set; }
    public string SI { get; set; }
    public string NO { get; set; }
    	*/

    public InteresesEspecificos(Decimal MontoPago,string Tipo_de_Saldo){
        this.MontoPago = MontoPago;
        this.Tipo_de_Saldo = Tipo_de_Saldo;
    }
    
    
}