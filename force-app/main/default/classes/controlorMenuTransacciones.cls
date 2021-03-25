public class controlorMenuTransacciones {
    public string tActTab{get;set;}
    public string tmActTab{get;set;}
    public string pagina{get;set;}
    string idComercio;
    string idDescuento;
    string usuario;
    
    public controlorMenuTransacciones(){
        try{
            idComercio = ApexPages.currentPage().getParameters().get('IdComercio');
            idDescuento = ApexPages.currentPage().getParameters().get('idDescuento');
            usuario = ApexPages.currentPage().getParameters().get('idUsuario');
            transaccion(); 
        }Catch(Exception e){
        
        }           
    }
    
    public void transaccion(){
        tabActiva();
        pagina = 'vfTransaccionesPortal?idComercio=' + idComercio + '&idDescuento=' + idDescuento + '&idUsuario=' + usuario;
        tActTab = 'slds-is-active'; 
    }
    
    public void transaccionMasiva(){
        tabActiva();
        pagina = 'vfTransaccionesMasivas?idComercio=' + idComercio + '&idDescuento=' + idDescuento + '&idUsuario=' + usuario;
        tmActTab = 'slds-is-active';     
    }
    
    public void tabActiva(){
        tActTab = '';
        tmActTab = '';
    }
    
    public pageReference cerrar(){
        return new pageReference('/vfIniciarSesion');
    }
}