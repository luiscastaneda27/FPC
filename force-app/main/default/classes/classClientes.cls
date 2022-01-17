public class classClientes {
    public String tipoRegistro { get; set; }
    public Boolean activo { get; set; }
    // PERSONAL

    public String nombreCliente { get; set; }
    public String apellidoCliente { get; set; }
    public String tipoIdentidad { get; set; }
    public String identificacion { get; set; }
    public String sexo { get; set; }
    public String estadoCivil { get; set; }
    public String nombreConyugue { get; set; }
    public String telefonoDomicilio { get; set; }
    public String telefonoCelular { get; set; }
    public String correoElectronico { get; set; }
    public String nacionalidad { get; set; }
    public String lugarNacimiento { get; set; }
    public Decimal numeroDependientes { get; set; }
    public String profesionOcupacionOficio { get; set; }
    public String fechaNacimiento { get; set; }
    public Boolean notificarCorreo { get; set; }
    public String numeroCliente { get; set; }
    public String asesorCliente { get; set; }
    public String antiguedad { get; set; }
    public String coloniaBarrioResidencia { get; set; }
    public String calleAvenidaResidencia { get; set; }
    public String numeroCasaResidencia { get; set; }
    public String puntoReferenciaResidencia { get; set; }
    public String ciudadResidencia { get; set; }
    public String paisResidencia { get; set; }
    public String coloniaBarrioTrabajo { get; set; }
    public String calleAvenidaTrabajo { get; set; }
    public String numeroCasaTrabajo { get; set; }
    public String puntoReferenciaTrabajo { get; set; }
    public String ciudadTrabajo { get; set; }
    public String paisTrabajo { get; set; }
    public String tipoTrabajador { get; set; }
    public String tipoEmpresa { get; set; }
    public String giroEmpresa { get; set; }
    public String cargoActual { get; set; }
    public String fechaIngresoEmpresa { get; set; }
    public String rangoSalarial { get; set; }
    public String telefonoOficina { get; set; }
    public Decimal extensionOficina { get; set; }
    public String correoElectronicoOficina { get; set; }
    public String r1NombreCompleto { get; set; }
    public String r1Telefono { get; set; }
    public String r2NombreCompleto { get; set; }
    public String r2Telefono { get; set; }
    public Boolean pep { get; set; }
    public Boolean fatca { get; set; }
    public String campana { get; set; }
    public Boolean carnet { get; set; }
    public String promocional1 { get; set; }
    public String promocional2 { get; set; }
    public String promocional3 { get; set; }
    public String descripcion { get; set; }

    // EMPRESARIAL
    public String nombreComercial { get; set; }
    public String rtn { get; set; }
    public String razonSocial { get; set; }
    public String telefono { get; set; }
    public String giroNegocio { get; set; }
    public Integer numeroEmpleados { get; set; }
    public String estatusCuentaEmpresarial { get; set; }
    public Decimal primerAporte { get; set; }
    public String nombreRepresentanteLegal { get; set; }
    public String cargoEmpresa { get; set; }
    public String poderEmpresa { get; set; }
    public String rlFechaNacimiento { get; set; }
    public String rlCorreoElectronico { get; set; }
    public String rlTelefono { get; set; }
    public String c1NombreCompleto { get; set; }
    public String c1CargoEmpresa { get; set; }
    public String c1FechaNacimiento { get; set; }
    public String c1CorreoElectronico { get; set; }
    public String c1Telefono { get; set; }
    public String c2NombreCompleto { get; set; }
    public String c2CargoEmpresa { get; set; }
    public String c2FechaNacimiento { get; set; }
    public String c2CorreoElectronico { get; set; }
    public String c2Telefono { get; set; }
    public String c3NombreCompleto { get; set; }
    public String c3CargoEmpresa { get; set; }
    public String c3FechaNacimiento { get; set; }
    public String c3CorreoElectronico { get; set; }
    public String c3Telefono { get; set; }
    public Integer numeroCharlasBrindadas { get; set; }
    public Integer cantidadPersonasAsistieron { get; set; }
    public Integer totalAfiliados { get; set; }
    public Integer totalAfiliadosAportan { get; set; }
    public Decimal totalMontoAporteL { get; set; }
    public Decimal totalMontoAporteD { get; set; }
    public List<classCuentas> cuentas { get; set; }

 
    public class classCuentas
    {
        public String cliente { get; set; }
        public String cuenta { get; set; }
        public String producto { get; set; }
        public String subProducto { get; set; }
        public String cuentaColectiva { get; set; }
        public Boolean cuentaActiva { get; set; }
        public String fondo { get; set; }
        public String fondoInversion { get; set; }
        public DateTime fechaApertura { get; set; }
        public String fechaAporte { get; set; }
        public String frecuenciaAporte { get; set; }
        public String formaAporte { get; set; }
        public Boolean seguroVida { get; set; }
        public String codigoBarra { get; set; }
        public String tipoComision { get; set; }
        public String matrizComision { get; set; }
        public List<classBeneficiarios> beneficiarios { get; set; }
    }

 
    public class classBeneficiarios
    {
        public String cuenta { get; set; }
        public String idExterno { get; set; }
        public String primerNombre { get; set; }
        public String segundoNombre { get; set; }
        public String primerApellido { get; set; }
        public String segundoApellido { get; set; }
        public DateTime fechaNacimiento { get; set; }
        public String codigoParentesco { get; set; }
        public String gradoParentesco { get; set; }
        public Decimal porcentaje { get; set; }
        public String sexo { get; set; }
        public String identidad { get; set; }
        public String tipoId { get; set; }
        public String telefono { get; set; }
        public String direccion { get; set; }        
    }
}