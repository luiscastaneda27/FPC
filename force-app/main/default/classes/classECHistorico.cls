public with sharing class classECHistorico {
    public String fecha { get; set; }
    public String nombreCliente { get; set; }
    public String numeroCliente { get; set; }
    public String SaltoPagina { get; set; }
    public String rendimientoLempiras { get; set; }
    public String rendimientoDolares { get; set; }
    
    public List<classMovimientos> movimientos { get; set; }
 
    public class classMovimientos{
        public String moneda {get;set;}
        public String cuenta {get; set;}
        public String totalPersonal {get; set; }
        public String totalPatronal { get; set; }
        public String granTotal { get; set; }
        public List<classTransaccion> transacciones { get; set; }
    }
 
    public class classTransaccion{
        public String fecha { get; set; }
        public string fechaSF {get;set;}
        public String descripcionTransaccion { get; set; }
        public String aportePersonal { get; set; }
        public String aportePatronal { get; set; }
        public String aporteTotal { get; set; }
    }
}