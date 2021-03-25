public class cuadreRetirosC2 {
 
    
    public DateTime fecha_retiro { get; set; }
    public DateTime fechaSysdeRetiros { get; set; }
    public List<pagoRetirosC> ListPagos { get; set; }
    public List<pagoRetirosC> ListPagosC {get;set;}
    public cuadreRetirosC2()
     {
        ListPagosC =new List<pagoRetirosC>(); 
      
     }

}