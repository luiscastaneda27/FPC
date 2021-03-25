public class classFondosPignorados
{
    public string codCuenta { get; set; }
    public Decimal montoPignorado { get; set; }
     public string numeroPrestamoId { get; set; }
    public string numeroPrestamo { get; set; }
    public string accion { get; set; }
    public string prestamoAterior { get; set; }
    public Decimal montoPrestamo { get; set; }
    public Decimal totalFondos { get; set; }
    
    
    public class Refinanciamiento{
        public string NumeroPrestamo { get; set; }
        public string cuenta { get; set; }
        public string existe { get; set; }
        public string MontoPrestamo { get; set; }
    }
   
}