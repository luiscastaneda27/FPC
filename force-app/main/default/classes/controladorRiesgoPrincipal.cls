public without sharing class controladorRiesgoPrincipal {
    
   
    public String usuario { get; set; }
    
    
    //Variable de la pantalla HOME
    public static string Matriz{get;set;}
    //public static string Grafico{get;set;}
    public static string Var{get;set;}
  //  public static string Var1{get;set;}
    /*public static string Var2{get;set;}
    public static string Var3{get;set;}
    public static string Var4{get;set;}
    public static string Var5{get;set;}*/
    
    public string pagina{get;set;}
    
    public boolean Mostrarhome { get; set; }
    
    public controladorRiesgoPrincipal()
    {
        //usuario = '';
        //contrasena = '';     
       mostrarhome=true;  
        
    }
    
    public void ReporteFechaConsti(){
        pagina = 'vfRiesgoFechaConsti?hytrd='+usuario;
        Var = 'slds-is-active';                
    }
    
    public void VariablesRiesgo(){
        pagina = 'vfVariableRiesgo1?hytrd='+usuario;
        Var = 'slds-is-active';   
    }
    public void TipoPersona(){
        pagina = 'vfVariablePersonaRiesgo?hytrd='+usuario;
        Var = 'slds-is-active';   
    }
    public void RiesgoTPE(){
        pagina = 'vfRiesgoTPE?hytrd='+usuario;
        Var = 'slds-is-active';   
    }
    
    public void RiesgoCliente(){
        pagina = 'vfVariableClienteRiesgo?hytrd='+usuario;
        Var = 'slds-is-active';   
    }
    
    public void Riesgodocumento(){
        pagina = 'vfTipDocumento?hytrd='+usuario;
        Var = 'slds-is-active';   
    }
    
    public void RiesgoFechaAfilia(){
        pagina = 'vfRiesgoFechaAfilia?hytrd='+usuario;
        Var = 'slds-is-active';   
    }
    public void RiesgoFechaConsti(){
        pagina = 'vfRiesgoFechaConsti?hytrd='+usuario;
        Var = 'slds-is-active';   
    }
    public void RiesgoFechaNacimiento(){
        pagina = 'vfRiesgoFechaNacimiento?hytrd='+usuario;
        Var = 'slds-is-active';   
    }
    public void RiesgoAPA(){
        pagina = 'vfRiesgoCanales?hytrd='+usuario;
        Var = 'slds-is-active';   
    }
    public void RiesgoProducto(){
        pagina = 'vfRiesgoProductos?hytrd='+usuario;
        Var = 'slds-is-active';   
    }
     public void RiesgoGeografico(){
        pagina = 'vfRiesgoNacionalidad?hytrd='+usuario;
        Var = 'slds-is-active';   
    }
     public void RiesgoVar(){
        pagina = 'vfFactorRM?hytrd='+usuario;
        Var = 'slds-is-active';   
    }
    
    
    
}