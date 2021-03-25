public class Direcciones {
    
		//public decimal CodPer { get; set; }
        public string Pais { get; set; }
        public string Departamento { get; set; }
        public string Municipio { get; set; }
        public string Colonia { get; set; }
    	public string Tipo { get; set; }
        public string Detalle { get; set; }
    
    public Direcciones(	/*decimal CodPer,*/ string Pais, string Departamento, string Municipio, string Colonia, string Tipo, string Detalle){
        //this.CodPer = CodPer;
        this.Pais = Pais;
        this.Departamento = Departamento;
        this.Municipio = Municipio;
        this.Colonia = Colonia;
        this.Tipo = Tipo;
        this.Detalle = Detalle;
    }
}