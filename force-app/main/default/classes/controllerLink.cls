public class controllerLink {

    public string pagina{get;set;}
	public static string UsuarioJuridico {get;set;}
    public static string UsuarioNatural {get;set;}
    
    
    public controllerLink()
    {
         Desactivartab();  
    }
  
    public void UsuarioJuridico()
    {
       Desactivartab();
        pagina = 'VFPantallaJuridicos';
        UsuarioJuridico = 'slds-is-active';         
    }
    
    public void crearUsuarioNat()
      {
        Desactivartab();
        pagina = 'VfPantallaNaturales';
        UsuarioNatural = 'slds-is-active';     
    }
    
    public static void Desactivartab()
    {
        UsuarioJuridico='';
        UsuarioNatural='';
    }
    public pageReference cerrar(){
        return new pageReference('/PantallasAfiliacion');
    }
    
    
}