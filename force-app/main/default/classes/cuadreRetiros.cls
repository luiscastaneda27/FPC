public class cuadreRetiros {
	public string referencia { get; set; }
   	public string codCuenta { get; set; }
    public string nombreCliente { get; set; }
    public Decimal numeroCaso { get; set; }
    public Decimal monMovimto { get; set; }
    public Decimal monRetirar { get; set; }
    public string fecMovimto { get; set; }
    public string fecSYSDE { get; set; }
    public string comparacion { get; set; }
    public Decimal montoNetoSysde { get; set; }
    public Decimal montoNetoSF { get; set; }
    public string comparaNeto { get; set; }
    public string fPago { get; set; }
    public Decimal comparaFecha { get; set; }
    public string descripcion { get; set; }
    public Decimal montoPignorado { get; set; }
    public Decimal porcentaje { get; set; }
    public Integer index { get; set; }

    public cuadreRetiros(string referencia, string codCuenta, string nombreCliente, Decimal numeroCaso, Decimal monMovimto, Decimal monRetirar, string fecMovimto, string fecSYSDE,
    					string comparacion, Decimal montoNetoSysde, Decimal montoNetoSF, string comparaNeto, string fPago, Decimal comparaFecha, string descripcion, Decimal montoPignorado, Decimal porcentaje, Integer index)
    {
    	this.referencia = referencia;
        this.codCuenta = codCuenta;
        this.nombreCliente = nombreCliente;
        this.numeroCaso = numeroCaso;
        this.monMovimto = monMovimto;
        this.monRetirar = monRetirar;
        this.fecMovimto = fecMovimto;
        this.fecSYSDE = fecSYSDE;
        this.comparacion = comparacion;
        this.montoNetoSysde = montoNetoSysde;
        this.montoNetoSF = montoNetoSF;
        this.comparaNeto = comparaNeto;
        this.fPago = fPago;
        this.comparaFecha = comparaFecha;
        this.descripcion = descripcion;
        this.montoPignorado = montoPignorado;
        this.porcentaje = porcentaje;
        this.index = index;
    }
    
    public cuadreRetiros(){}
}