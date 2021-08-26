public with sharing class classpignorados {
	
    public string cuentapig {get;set;}
    public string codcuenta {get;set;}
    public string id_pign {get;set;}
    public string num_prest {get;set;}
    public string nombrepig {get;set;}
    public datetime fpignoracion {get;set;}
    public datetime fliberacion {get; set;}
    public string num_prest1 {get;set;}
    public string est_pig {get;set;}
    public double sec_pig {get;set;}
    public double tot_fondos_pig {get;set;}
    public double m_prestamo {get;set;}
    public double m_pignorado {get;set;}
     public List<classpignorados>ListPignorados{get;set;} 
    public string usuario {get;set;}
    //Actualiza
    	public string num_prestamo {get;set;}
    public double monto_pign {get;set;}
    public datetime fechapign {get;set;}
    public datetime fechalib {get;set;}
    public string num_prestamo1 {get;set;}
    public double tot_fondos {get;set;}
    public double monto_prest {get;set;}
    public string estatus {get;set;}
   
    
    
    public classpignorados ()  {
        
        ListPignorados  = new List <classpignorados> ();
        
    }  
    
}