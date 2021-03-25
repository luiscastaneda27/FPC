public class cuadreRetiros {
	public string referencia { get; set; }
   	public string codCuenta { get; set; }
    public string nombreCliente { get; set; }
    public Decimal numeroCaso { get; set; }
    public Decimal monMovimto { get; set; }
    public Decimal monRetirar { get; set; }
    public DateTime fecMovimto { get; set; }
    public DateTime fecSYSDE { get; set; }
    public Decimal comparacion { get; set; }
    public string fPago { get; set; }
    public Decimal comparaFecha { get; set; }
    public string descripcion { get; set; }
    public Integer index { get; set; }

    public cuadreRetiros(string referencia, string codCuenta, string nombreCliente, Decimal numeroCaso, Decimal monMovimto, Decimal monRetirar, DateTime fecMovimto, DateTime fecSYSDE,
    					Decimal comparacion, string fPago, Decimal comparaFecha, string descripcion, Integer index)
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
        this.fPago = fPago;
        this.comparaFecha = comparaFecha;
        this.descripcion = descripcion;
        this.index = index;
    }
}