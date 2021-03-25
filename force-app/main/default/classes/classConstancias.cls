public with sharing class classConstancias {
    public list<classCuentas> cuentas{get;set;}
	public string accion{get;set;}
	public date fechaAporteDesde{get;set;}
	public date fechaAporteHasta{get;set;}
	public string codigoMoneda{get;set;}
	
	public classConstancias(){
		cuentas = new list<classCuentas>();	
	}
	
	public class classCuentas
    {
        public String cuenta { get; set; }
    }
}