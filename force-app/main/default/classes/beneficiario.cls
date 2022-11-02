public class beneficiario {

   	public decimal idExterno{get;set;} 
    public string tipoId{get;set;} 
    public string numeroId{get;set;}
    public string PEPbeneficiario{get;set;}
    public string FATCAbeneficiario{get;set;}
    public string FATCANCbeneficiario{get;set;}
    public string tipoBeneficiario{get;set;} 
    public string genero{get;set;}
    public string primerNombre{get;set;}
    public string segundoNombre{get;set;}
    public string primerApellido{get;set;}
    public string segundoApellido{get;set;}
    public string Parentesco{get;set;}
    public double Distribucion{get;set;}
    public double Grado{get;set;} 
    public datetime fechaNacimiento{get;set;}
    public date fechaBeneficiario{get;set;}
    public decimal idGuardar{get;set;} 
    
    
    //Variables neuvas
    public string estado { get; set; }
    public string incluidoPor { get; set; }
    public DateTime fechaInclusion { get; set; }
    public string autorizadoPor { get; set; }
    public string modificadoPor { get; set; }
    public DateTime fechaModificacion { get; set; }
    public String accion { get; set; }
    public String cuenta { get; set; }
    
    public beneficiario( decimal idGuardar, string tipoId, string numeroId, string PEPbeneficiario, string FATCAbeneficiario, 
                         string FATCANCbeneficiario, string tipoBeneficiario, string genero, string primerNombre, 
                         string segundoNombre, string primerApellido, string segundoApellido, string Parentesco,
                         double Distribucion,double Grado,date fechaNacimiento)
    {
        this.idGuardar=idGuardar;
        this.tipoId=tipoId;
        this.numeroId=numeroId;
        this.PEPbeneficiario=PEPbeneficiario;
        this.FATCAbeneficiario=FATCAbeneficiario;
        this.FATCANCbeneficiario=FATCANCbeneficiario;
        this.tipoBeneficiario=tipoBeneficiario;
        this.genero=genero;     
        this.primerNombre=primerNombre;
        this.segundoNombre=segundoNombre;
        this.primerApellido=primerApellido;
        this.segundoApellido=segundoApellido;       
        this.Parentesco=Parentesco;
        this.Distribucion=Distribucion;
        this.Grado=Grado;
        this.fechaNacimiento=fechaNacimiento;
        
       
    }
    
}