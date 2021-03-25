public with sharing class classEnvioEcSMS {
    public String cuentaColectiva { get; set; }
    public String cuentaIndividual { get; set; }
    public String subProducto { get; set; }
    public String identidad { get; set; }
    public Date fechaHasta { get; set; }
    public Date fechaHastaId { get; set; }
    public Date fechaHastaCo { get; set; }
    public Date fechaHastaSp { get; set; }
    public String mensaje { get; set; }
    public String celular { get; set; }
    public String nombre  { get; set; }
    public Double saldo  { get; set; }
    public list<classCelulares> listTelefonos { get; set; }
    
    
    public class classCelulares {
        public string mobile {get;set;} 
        
     }
}