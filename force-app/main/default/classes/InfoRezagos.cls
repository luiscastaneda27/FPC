public class InfoRezagos {
    
    public List<Clientes> clientes { get; set; }
    
    public InfoRezagos(){
        Clientes = New List<Clientes>();
    }
    
    public class Clientes {
        public String idRezago { get; set; }
        public String montoRezago { get; set; }
        public String fondo { get; set; }
        public String codReferencia { get; set; }
        public String fechaDeposito { get; set; }
        public String codigoMoneda { get; set; }
        public String descripcion { get; set; }
        public String descripcionNota { get; set; }
        public String usuIngresaRezago { get; set; }
        public String codBanco { get; set; }
        public String agnBanco { get; set; }
        public String rezagoSINO { get; set; }
        public String asesor { get; set; }
        public String estado { get; set; }
        public String valorCuotaEntrada { get; set; }
        public String fecInclusion { get; set; }
        public String incluidoPor { get; set; }
        public String fecModificacion { get; set; }
        public String modificadoPor { get; set; }
        public String montoPendienteAplicar { get; set; } 
    }
}