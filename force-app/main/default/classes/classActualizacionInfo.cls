public class classActualizacionInfo
    {
	public String codigoCliente { get; set; }
    public String primerNombre { get; set; }
    public String segundoNombre { get; set; }
    public String primerApellido { get; set; }
    public String segundoApellido { get; set; }
    public String tipoIdentificacion { get; set; }
    public String identificacion { get; set; }
    public String fechaNacimiento { get; set; }
    public String sexo { get; set; }
    public String lugarNacimiento { get; set; }
    public String nacionalidad { get; set; }
    public String estadoCivil { get; set; }
    public String correo { get; set; }
    public String VE_USUARIO_ACTUALIZA { get; set; }
    public String VE_USUARIO_APRUEBA { get; set; }
    public List<classTelefonos> telefonos { get; set; }
    public List<classDirecciones> direcciones { get; set; }
    public List<classBeneficiarios> beneficiarios { get; set; }
    public List<classBitacora> bitacora { get; set; }    
 
     public class classTelefonos
    {
        public String tipo { get; set; }
        public String numero { get; set; }
        public String ubicacion { get; set; }
    }
 
    public class classDirecciones
    {
        public String codigoPais { get; set; }
        public String codigoDepartamento { get; set; }
        public String codigoCiudad { get; set; }
        public String codigoColonia { get; set; }
        public String puntoReferencia { get; set; }
        public String tipo { get; set; }
    }
 
    public class classBeneficiarios{
        public String cuenta { get; set; }
        public String idExterno { get; set; }
        public String tipoBeneficiario { get; set; }
        public String primerNombre { get; set; }
        public String segundoNombre { get; set; }
        public String primerApellido { get; set; }
        public String segundoApellido { get; set; }
        public String codigoParentesco { get; set; }
        public String gradoParentesco { get; set; }
        public String porcentaje { get; set; }
        public DateTime fechaNacimiento { get; set; }
        public String sexo { get; set; }
        public String identidad { get; set; }
        public String tipoId { get; set; }
        public String accion { get; set; }
        //public String usuarioAprueba { get; set; }
        //public String usuarioActualiza { get; set; }
        
        //Variables neuvas
        public string estado { get; set; }
        public string incluidoPor { get; set; }
        public DateTime fechaInclusion { get; set; }
        public string autorizadoPor { get; set; }
        public string modificadoPor { get; set; }
        public DateTime fechaModificacion { get; set; }
    }
}