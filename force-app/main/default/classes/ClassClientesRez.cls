public class ClassClientesRez {
    
    public string Tipo {get;set;}
    public List<ClientesRez> clientes { get; set; }
    
    public ClassClientesRez(){
        clientes = new List<ClientesRez>();
     }
}