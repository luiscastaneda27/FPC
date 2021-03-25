public class classReversiones {
    public class classConsultaReversion
    {
       public String cuenta {get; set;}
       public Date fechaDesde {get; set;}
       public Date fechaHasta {get; set;}
       public string accion{get; set;}
    }
 
    public class classRespuestaReversion
    {
        public DateTime fecha { get; set; }
        public String descripcion { get; set; }
        public Decimal monto { get; set; }
        public Decimal saldoInicial { get; set; }
        public Decimal saldoFinal { get; set; }
        public Decimal prcComisionAporte { get; set; }
        public Decimal prcComisionSaldo { get; set; } 
        public Decimal rendimientoDiario { get; set; } 
        public Decimal valorCuota { get; set; }
        public Decimal crecimientoDiarioValorCuota { get; set; }
        public integer indice {get;set;}
        public string tipoSaldo {get;set;}
    }
 
    public class classProcesarReversion
    {
        public String cuenta { get; set; }
        public String tipoReversion { get; set; } 
        public String subTipoReversion { get; set; }
        public Date fechaAporte { get; set; }
        public Decimal montoRetiro { get; set; }
        public Decimal montoTSP { get; set; }
        public Decimal montoACH { get; set; }
        public Decimal montoCheque { get; set; }
        public Decimal montoComisionAporte { get; set;}
        public Decimal montoComisionSaldo { get; set;}
        public Decimal rendimiento { get; set;}
        public List<classBitacora> bitacora { get; set; }
    }
    
    // CLASES NUEVAS
     public class classRendimiento
    {
        public string cuenta { get; set; }
        public DateTime fechaDesde { get; set; }
        public DateTime fechaHasta { get; set; }
        public string monto { get; set; }
        public string tipoSaldo { get; set; }
    }

    public class classRespuestaRendimiento
    {
        public decimal valor { get; set; }
        public decimal comisionAporte { get; set; }
        public decimal comisionSaldo { get; set; }
    } 
}