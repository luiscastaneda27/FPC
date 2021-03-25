public with sharing class ClassConsultaInteres {
    public string Nombre {get;set;}
    public string Cuenta {get;set;} 
    public string Identidad {get;set;}
    public string Diapago {get;set;}
    public string TipoPago {get;set;}
    public List<ClassConsultaInteres> ListPagosIntereses {get;set;}
    
    public ClassConsultaInteres()
    {
    	ListPagosIntereses =new List<ClassConsultaInteres>();
    }
}