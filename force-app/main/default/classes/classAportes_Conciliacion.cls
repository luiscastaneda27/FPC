public class classAportes_Conciliacion {  
    
    public string ComisionSI { get; set; } /*Aplica Comision*/
    public string Cod_referencia { get; set; }
    public string pc_pc_AplicaDolar { get; set; }
    public string Cuenta { get; set; }
    public string pc_DESCRIPCION { get; set; }
    public string pc_ESTADO_APORTE { get; set; }
    public Date FechaDepositoAproba { get; set; }
    public Date PC_FECHA_INGRESO_SISTEMA { get; set; }
    public string FormaPago { get; set; }
    public string Monto { get; set; } /*Cambiar a float*/
    public string NombreCompleto { get; set; }
    public string pc_OFICIAL_DE_NEGOCIOS { get; set; }
    public string p_periodo_aporte { get; set; }
    public string Moneda { get; set; }
    public string TipoSaldo { get; set; }
    public string pc_Imagen { get; set; }
    public string rezago { get; set; }
    
    public Date FechaDeposito { get; set; }
    
    //Variables de salida
    
    public string p_saldo { get; set; }
    public string p_monto_pen_aplic { get; set; }
    public string p_num_movim_sysde { get; set; }
    public string p_nombre { get; set; }
    public string p_codigo_error { get; set; }
    public string p_mensaje_error { get; set; }
    
    
}