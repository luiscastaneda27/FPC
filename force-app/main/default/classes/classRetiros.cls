public with sharing class classRetiros {
    /*public String cuenta { get; set; }
    public String cuentaDestino { get; set; }
    public String tipoRetiro { get; set; }
    public List<classSaldos> saldos { get; set; }
    public Decimal montoComisionPorRetiro { get; set; }
    public Decimal montoTSP { get; set; }
    public Decimal montoACH { get; set; }
    public Decimal montoCheque { get; set; }
    public String formaPago { get; set; }
    public Boolean aportePatronal { get; set; }   
    public List<classBitacora> bitacora { get; set; }*/
    
    public String cuenta { get; set; }
    public String cuentaOrigen { get; set; }
    public String cuentaDestino { get; set; }
    public Boolean transferencia { get; set; }
    public String tipoCuentaDestino { get; set; }
    public String bancoCuentaDestino { get; set; }
    public String monedaCuentaDestino { get; set; }   
    public Decimal montoRetiro { get; set; }
    public String tipoRetiro { get; set; }
    public List<classSaldos> saldos { get; set; }    
    public Decimal montoComisionPorRetiro { get; set; }
    public Decimal montoTSP { get; set; }
    
    // VARIABLES NUEVAS
    public Decimal saldoPrestamo { get; set; }
    public Decimal montoBrutoPatronal{ get; set; }
    public Decimal montoNetoPatronal{ get; set; }
    public Decimal montocargosPatronal{ get; set; }
    public String tipoCuentaBancaria{ get; set; }
    public String cuentaPatronal{ get; set; }
    public String BancoCuentaBancaria{ get; set; }
    public String tipoCuenta{ get; set; }
    public Decimal montoRestanteCliente{ get; set; }
    public Decimal MontoSaldoPatronal { get; set; }
    public Decimal montoChequePatrono{ get; set; }
    public Decimal montoACHPatrono{ get; set; }
    public Decimal montoTSPPatrono{ get; set; }
    public String tipoPago {get;set;}
    public Boolean clienteSigueLaborando {get;set;}
    // FIN DE VARIABLES NUEVAS
    
    public Decimal montoACH { get; set; }
    public Decimal montoCheque { get; set; }
    public String formaPago { get; set; }
    public Boolean aportePatronal { get; set; }
    public List<classBitacora> bitacora { get; set; }
    
    // CAMPOS DEL OBJETO PAGO A BENEFICIARIOS 11/03/2020
    public List<beneficiarios> listBeneficiarios {get;set;} public class beneficiarios { public String nombre {get;set;}  public String identificacion {get;set;} public String formaPago {get;set;} public String moneda {get;set;} public Decimal montoTSP {get;set;} public Decimal montoACH {get;set;} public Decimal montoCH {get;set;} public String cuentaOrigen {get;set;} public String cuentaDestino {get;set;} public String bancoDestino {get;set;} public String tipoPago {get;set;} public String cod_Cuenta {get;set;} public boolean monto_Aporte_Patronal {get;set;}   public String tipoCuenta {get;set;} public Decimal montoPrestamos {get;set;} public Decimal montoPatronal {get;set;} public Decimal montoNetoPatronal {get;set;} public Decimal montoCargoPatronal {get;set;} public String tipoCuentaBancaria {get;set;} public String cuentaPatronal {get;set;} public String bancoCuentaBancaria {get;set;} public String tipoCuentaC {get;set;} public Decimal montoRestanteCliente {get;set;} public Decimal montoPatronalCliente {get;set;} public Decimal montoCKPatrono {get;set;} public Decimal montoACHPatrono {get;set;} public Decimal montoTSPPatrono {get;set;} public Decimal totalSaldo10 {get;set;} public Decimal totalSaldo11 {get;set;} public Decimal totalSaldo12 {get;set;} public Decimal totalSaldo13 {get;set;} public Decimal totalSaldo17 {get;set;}
    }
    // FIN CAMPOS DEL OBJETO PAGO A BENEFICIARIOS 11/03/2020
}