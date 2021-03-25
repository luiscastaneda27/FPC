public with sharing class cuadreRetirosP {
    public string referencia { get; set; }
    public Decimal numeroCaso { get; set; }
    public string nombreCliente { get; set; }
    public string codCuenta { get; set; }
    public string fPago { get; set; }
    public Decimal monRetirar { get; set; }
    public Decimal tsp { get; set; }
    public Decimal ach { get; set; }
    public Decimal ck { get; set; }
    public Decimal monTotal { get; set; }
    public Decimal monHNL { get; set; }
    public Decimal monUSD { get; set; }
    public DateTime fecSYSDE { get; set; }
    public string moneda { get; set; }
    public string cuentaBancaria { get; set; }
    public string cuentaDestino { get; set; }
    public string bancoDestino { get; set; }
    public string tCuenta { get; set; }
    public Integer index { get; set; }
    
    public cuadreRetirosP (string referencia, Decimal numeroCaso, string nombreCliente, string codCuenta, string fPago, Decimal monRetirar, 
                           Decimal tsp, Decimal ach, Decimal ck, Decimal monTotal, Decimal monHNL, Decimal monUSD,
                           DateTime fecSYSDE, string moneda, string cuentaBancaria, 
                           string cuentaDestino, string bancoDestino, string tCuenta, Integer index)
    {
        this.referencia = referencia;
        this.numeroCaso = numeroCaso;
        this.nombreCliente = nombreCliente;
        this.codCuenta = codCuenta;
        this.fPago = fPago;
        this.monRetirar = monRetirar;
        this.tsp = tsp;
        this.ach = ach;
        this.ck = ck;
        this.monTotal = monTotal;
        this.fecSYSDE = fecSYSDE;
        this.moneda = moneda;
        this.cuentaBancaria = cuentaBancaria;
        this.cuentaDestino = cuentaDestino;
        this.bancoDestino = bancoDestino;
        this.tCuenta = tCuenta;
        this.index = index;
    }
}