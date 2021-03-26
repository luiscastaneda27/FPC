public class cuadreRetirosB {
	public string referencia { get; set; }
   	public string codCuenta { get; set; }
    public string nombreCliente { get; set; }
    public string nombrePropietario { get; set; }
    public string idCliente { get; set; }
    public Decimal numeroCaso { get; set; }
    public string fPago { get; set; }
    public Decimal monMovimto { get; set; }
    public Decimal monRetirar { get; set; }
    public Decimal montoPatronalCte { get; set; }
    public Decimal tsp { get; set; }
    public Decimal ach { get; set; }
    public Decimal ck { get; set; }
    public Decimal monTotal { get; set; }
    public Decimal monHNL { get; set; }
    public Decimal monUSD { get; set; }
    public string fecSYSDE { get; set; }
    public string fecMovimto { get; set; }
    public Decimal comparacion { get; set; }
    public Decimal comparaFecha { get; set; }
    public string cuentaBancaria { get; set; }
    public string cuentaDestino { get; set; }
    public string bancoDestino { get; set; }
    public string tCuenta { get; set; }
    public string moneda { get; set; }
    public Decimal montoPignorado { get; set; }
    public Decimal porcentaje { get; set; }
    public Integer index { get; set; }
    

    public cuadreRetirosB(string referencia, string codCuenta, string nombreCliente, string nombrePropietario, string idCliente,Decimal numeroCaso, string fPago, 
                          Decimal monMovimto, Decimal monRetirar, Decimal montoPatronalCte, Decimal tsp, Decimal ach, Decimal ck, Decimal monTotal, Decimal monHNL,
                          Decimal monUSD, string fecSYSDE, string fecMovimto, Decimal comparacion,  Decimal comparaFecha,string cuentaBancaria, string cuentaDestino, 
                          string bancoDestino, string tCuenta, string moneda, Decimal montoPignorado, Decimal porcentaje, Integer index)
    {
        //ListPagosC =new List<ListPagosC>();
        
            this.referencia = referencia;
            this.codCuenta = codCuenta;
            this.nombreCliente = nombreCliente;
        	this.nombrePropietario = nombrePropietario;
        	this.idCliente = idCliente;
            this.numeroCaso = numeroCaso;
            this.fPago = fPago;
            this.monMovimto = monMovimto;
            this.monRetirar = monRetirar;
            this.montoPatronalCte = montoPatronalCte;
            this.tsp = tsp;
            this.ach = ach;
            this.ck = ck;
        	this.monTotal = monTotal;
        	this.fecSYSDE = fecSYSDE;
            this.fecMovimto = fecMovimto;
            this.comparacion = comparacion;
            this.comparaFecha = comparaFecha;
            this.cuentaBancaria = cuentaBancaria;
            this.cuentaDestino = cuentaDestino;
            this.bancoDestino = bancoDestino;
            this.tCuenta = tCuenta;
            this.moneda = moneda;
        	this.montoPignorado = montoPignorado;
        	this.porcentaje = porcentaje;
        	this.index = index;
    }
}