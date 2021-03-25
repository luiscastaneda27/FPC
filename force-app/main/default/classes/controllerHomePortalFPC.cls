public class controllerHomePortalFPC {
    public string pagina{get;set;}
	public static string Gestiones {get;set;}
    public static string Afiliaciones {get;set;}
    public integer anio{ get; set; }
    
    public controllerHomePortalFPC()
    {
        Desactivartab();  
        anio = date.today().year();
    }
  
    public void Gestiones()
    {
       Desactivartab();
        pagina = 'VFPortalFPC';
        Gestiones = 'slds-is-active';         
    }
    
    public void Afiliaciones()
      {
        Desactivartab();
        pagina = 'VfPantallaClienteProductoAgn';
        Afiliaciones = 'slds-is-active';     
    }
    
    public static void Desactivartab()
    {
        Gestiones='';
        Afiliaciones='';
    }

}