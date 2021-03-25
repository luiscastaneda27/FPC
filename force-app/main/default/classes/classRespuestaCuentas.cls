public with sharing class classRespuestaCuentas {
    
 	public String cuenta { get; set; }
    public String saldo { get; set; }    
    public String fechaInclusion { get; set; }
    public String fechaExclusion { get; set; }
    public Boolean cuentaActiva { get; set; }
	public String montoPactado { get; set; }
	public List<classAportes> aportes { get; set; }
}