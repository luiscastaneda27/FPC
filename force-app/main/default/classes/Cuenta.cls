public class Cuenta {

    public string num_cuenta{get;set;}
    public decimal aportacion{get;set;}
    
    public Cuenta(string cuenta, decimal aporte)
    {
        this.num_cuenta =cuenta;
        this.aportacion=aporte;
    }
    

    
}