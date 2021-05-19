public class classAprobarClientesPEP {
    public string numIdentidad{get;set;} 
    public string nombreCompleto{get;set;} 
    public string fechaCreacion{get;set;} 
    public string lista{get;set;}
    public string cargo{get;set;}
    public string fechaInclusionLista{get;set;} 
	public string usuario{get;set;}
    
    public classAprobarClientesPEP (string numIdentidad, string nombreCompleto, string fechaCreacion, string lista, string cargo,
                                    string fechaInclusionLista, string usuario){
    	this.numIdentidad = numIdentidad;
        this.nombreCompleto = nombreCompleto;
        this.fechaCreacion = fechaCreacion;
        this.lista = lista;
        this.cargo = cargo;
        this.fechaInclusionLista = fechaInclusionLista;
        this.usuario = usuario;
    }
}