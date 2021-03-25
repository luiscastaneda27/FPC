global with sharing class classCambioSubproducto {
    public string cuenta{get;set;}
	public string cuentaColectiva{get;set;}
	public string subproducto{get;set;}
	public string accion{get;set;}
	public string usuario{get;set;}
	public List<classBitacora> bitacora { get; set; }
}