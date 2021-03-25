public with sharing class classCRetiros {
	public date fecha_retiro {get;set;}
    public datetime fechaSysdeRetiros {get;set;}
    public List<cuadreRetiros> ListPagos {get;set;}
    public List<cuadreRetirosC> ListPagosC {get;set;}
    public List<cuadreRetirosP> ListPagosP {get;set;}
    public List<cuadreRetirosI> ListPagosI {get;set;}
    
    public classCRetiros()
    {
    	ListPagos =new List<cuadreRetiros>(); 
        ListPagosC =new List<cuadreRetirosC>(); 
        ListPagosP =new List<cuadreRetirosP>(); 
        ListPagosI =new List<cuadreRetirosI>();
    }
}