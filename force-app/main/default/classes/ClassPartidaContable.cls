public class ClassPartidaContable {
    
   		public string TipoFondo { get; set; }
        public Date FechaPosteo { get; set; }
        public Date FechaValor { get; set; }
        public Decimal Monto { get; set; }
        public string Referencia { get; set; }
        public string Conciliado { get; set; }
        public Decimal Pc_Dia { get; set; }
        public string pCU_Contable { get; set; }
        public string pCU_Rezagos { get; set; }
        public string PC_Observaciones { get; set; }
        public string pc_Usuario { get; set; }
	
       
    
   public ClassPartidaContable(string TipoFondo, date FechaValor, string PC_Observaciones, string Referencia, 
                               date FechaPosteo, Decimal Monto,string pc_Usuario, string Conciliado,
                               string pCU_Rezagos,string pCU_Contable,decimal Pc_Dia)
    {
        this.TipoFondo = TipoFondo;
        this.FechaValor= FechaValor;
        this.PC_Observaciones=PC_Observaciones;
        this.Referencia=Referencia;
        this.FechaPosteo=FechaPosteo;
        this.Monto=Monto;
        this.pc_Usuario=pc_Usuario;
        this.Conciliado=Conciliado;
        this.pCU_Rezagos=pCU_Rezagos;
		this.pCU_Contable=pCU_Contable;
        this.Pc_Dia=Pc_Dia;
    }
  
}