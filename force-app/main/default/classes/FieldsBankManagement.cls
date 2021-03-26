public class FieldsBankManagement {
	public String tipoGestion;
    public String identificacion;
    public String moneda;
    public String fechaInicio;
    public String periodicidad;
    public String cuentaBancaria;
    public String diaCobro;
    public String montoDebito;
    
    public String pctipoid { get; Set; }
    public String pcnroid { get; Set; }
    public String cuenta { get; Set; }
    public String pcprimernombre { get; Set; } 
    public String pcprimerapellido { get; Set; }
    public String pcmail { get; Set; }
    public String pnnrocertificado { get; Set; }
    public String tipoFondo { get; Set; }
    public String frecuencia { get; Set; }
    public String pcformapago { get; Set; }
    public String pccuentapago { get; Set; }
    public String diaPago { get; Set; }
    public List<FieldsBankManagement> fieldsList { get; set; }
    
    public String CARD_HOLDER_LEGAL_ID;
    public String ACCOUNT_HOLDER_LEGAL_ID;
    public String ACCOUNT_NUMBER;
    public String CARD_STATUS;
}