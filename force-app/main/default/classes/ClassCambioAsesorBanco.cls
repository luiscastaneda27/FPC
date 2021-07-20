public with sharing class ClassCambioAsesorBanco {
	public string codCuenta {get;set;}
    public string nombreCliente {get;set;}
    public string subProducto {get;set;}
    public string producto {get;set;}  
    public string codAsesor {get;set;}
    public string nombreAsesor {get;set;}
    public string agencia {get;set;}
    public string nuevoCodAsesor {get;set;}
    public string nuevoNombreAsesor {get;set;}
    public string nuevaAgencia {get;set;}
    public string estado {get;set;}
    public date fechaModificacion {get;set;}
    //public string num_doc {get; set;}
    public  List<ClassCambioAsesorBanco> listcambioasesorbanco {get;set;}
   
    public ClassCambioAsesorBanco ()  {
        
        listcambioasesorbanco  = new List <ClassCambioAsesorBanco> ();         
    }  
    

    
    
    
}