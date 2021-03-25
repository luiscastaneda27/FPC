public class classProcesarReversion {
	public String cuenta { get; set; } 
    public String accion { get; set; }  
    public String rezago { get; set; }
    public String idSalesforce { get; set; }
    public String tipoSaldo { get; set; }
    public Boolean cobroComision { get; set; }
    public Decimal monto { get; set; }
    public Decimal montoPorAporte { get; set; }
    public Decimal montoPorSaldo { get; set; }
    public Decimal montoRendimiento { get; set; }
    public List<classBitacora> bitacota { get; set; } 
}