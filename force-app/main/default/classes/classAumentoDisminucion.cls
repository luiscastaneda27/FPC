public with sharing class classAumentoDisminucion {
	public String cuenta { get; set; }
    public String tipoSaldoMod { get; set; }
    public String nuevoCanalAporte { get; set; }
    public Decimal montoOperacion { get; set; }
    public DateTime fecha { get; set; }
    public String cuentaTarjeta { get; set; }
    public String accion { get; set; }
    public String periodicidad { get; set; }
    public List<classBitacora> bitacora { get; set; }    
}