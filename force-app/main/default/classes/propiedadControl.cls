public class propiedadControl {
	public decimal idGuardar {get;set;}
    public string AI_ID_EXTERNO {get;set;}
    public string numControlante{get;set;}
    public string nombreControlante{get;set;}
    public string PEPControlante{get;set;}
    public string FATCAControlante{get;set;}
    public string FATCANCControlante{get;set;}
    public string tipoPersonaControlante{get;set;}
    public string nacionalidadControlante{get;set;}
    public string nivelControlante{get;set;}
    public string porcentajeDiControlante{get;set;}
    public string porcentajeInControlante{get;set;}
    public string numIdEmpresaControlante{get;set;}
    public string cargoControlante{get;set;}
    public string cotBolsaControlante{get;set;}
    public string ticSymbolControlante{get;set;}
   
    public propiedadControl(decimal idGuardar, string numControlante, string nombreControlante, string PEPControlante,
                            string FATCAControlante, string FATCANCControlante, string tipoPersonaControlante, 
                            string nacionalidadControlante, string nivelControlante, string porcentajeDiControlante, 
                            string porcentajeInControlante, string numIdEmpresaControlante, string cargoControlante, 
                            string cotBolsaControlante, string ticSymbolControlante)
    {
        this.idGuardar = idGuardar;
        this.numControlante = numControlante;
        this.nombreControlante = nombreControlante;
        this.PEPControlante = PEPControlante;
        this.FATCAControlante = FATCAControlante;
        this.FATCANCControlante = FATCANCControlante;
        this.tipoPersonaControlante = tipoPersonaControlante;
        this.nacionalidadControlante = nacionalidadControlante;
        this.nivelControlante = nivelControlante;
        this.porcentajeDiControlante = porcentajeDiControlante;
        this.porcentajeInControlante = porcentajeInControlante;
        this.numIdEmpresaControlante = numIdEmpresaControlante;
        this.cargoControlante = cargoControlante;
        this.cotBolsaControlante = cotBolsaControlante;
        this.ticSymbolControlante = ticSymbolControlante;
    }
}