public class ClientesRez {
        
    public string idRezago{get;set;}
    public string montoRezago{get;set;}
    public string fondo{get;set;}
    public string codReferencia{get;set;}
    public string codCuenta{get;set;}
    public string codPlanilla{get;set;}
    public string valorCuotaEntrada{get;set;}
    public string valorCuotaSalida{get;set;}
    public string estado{get;set;}
	public string valAporteCalculado{get;set;}
    public string montoParcialAplicado{get;set;}
    public string montoPendienteAplicar{get;set;}
    public string modificadoPor{get;set;}
    
    public ClientesRez(string idRezago, string montoRezago, string fondo, string codReferencia, string codCuenta, string codPlanilla, string valorCuotaEntrada,
                   string valorCuotaSalida, string estado, String valAporteCalculado, string montoParcialAplicado, string montoPendienteAplicar, string modificadoPor){
                      
		this.idRezago = idRezago;
        this.montoRezago = montoRezago;
        this.fondo = fondo;
        this.codReferencia = codReferencia;    
        this.codCuenta = codCuenta;
        this.codPlanilla = codPlanilla;
        this.valorCuotaEntrada = valorCuotaEntrada;
		this.valorCuotaSalida = valorCuotaSalida;
        this.estado = estado;
		this.valAporteCalculado = valAporteCalculado;
        this.montoParcialAplicado = montoParcialAplicado;
		this.montoPendienteAplicar = montoPendienteAplicar;
		this.modificadoPor = modificadoPor;
    }
}