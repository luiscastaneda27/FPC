public with sharing class classECTrimestral {
	public String fecha { get; set; }
    public String numeroCliente { get; set; }
    public String nombreCliente { get; set; }
    public String emailCliente { get; set; }    
	public String rendimientoLempiras { get; set; }
    public String rendimientoDolares { get; set; }
    
    public String identificacion { get; set; }
    public String correoElectronico { get; set; }
        
    //public String promedioAportes { get; set; }
    //public String termometro { get; set; }
    public List<classECCuenta> cuentas { get; set; }
    public List<classECCuenta> fondoLempiras { get; set; }
    public List<classECCuenta> fondoDolares { get; set; }
        
    public String pension { get; set; }
    public String incrementoCincoMas { get; set; }
    public String aporteCincoMas { get; set; }
    public String incrementoDiezMas { get; set; }
    public String aporteDiezMas { get; set; }
    public String incrementoQuinceMas { get; set; }
    public String aporteQuinceMas { get; set; }
    public Boolean mayor { get; set; }
        
    public class classECCuenta
    {
		public String moneda { get; set; }
        public String numeroCuenta { get; set; }
        public String fechaIncorporacion { get; set; }
        public String aportesEmpleado { get; set; }
        public String aportesExtraEmpleado { get; set; }
        public String totalAportesEmpleado { get; set; }
        public String aportesEmpleador { get; set; }
        public String aporteExtraEmpleador { get; set; }
        public String totalAportesEmpleador { get; set; }
        public String aporteSeguroVida { get; set; }
        public String intereses { get; set; }
        public String comisiones { get; set; }
        public String retiros { get; set; }
        public String totalMiFondo { get; set; }
        public String miEmpleador { get; set; }
        public String fpcTrabajo { get; set; }
        public string grafico { get; set; }
        public String porcentajeMisAportes { get; set; }
        public String porcentajeEmpleadorAportes { get; set; }
        public String porcentajeFicohsaAportes { get; set; }
    }
            
}