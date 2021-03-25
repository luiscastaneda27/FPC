public class controllerLoginComerio2 {
    public String Contrasena { get; set; }
    public String usuario { get; set; }
    public string tActTab{get;set;}
    public string tmActTab{get;set;}
    public string pagina{get;set;}
    string idComercio;
    string idDescuento;
    public integer anio {get;set;}
    public boolean isLogin{get;set;}
    string usuario2;
    
    public controllerLoginComerio2(){
        usuario = '';
        contrasena = '';
        isLogin=true;
        anio=date.today().year();
    }    
    
    public pageReference sesionIniciada(){
        try{
            Usuario_de_Portal__c usuario = [Select Contrase_a__c, Comercio_Afiliado__c, Comercio_Afiliado__r.Logo__c,
                            Comercio_Afiliado__r.Name, Comercio_Afiliado__r.Activo__c, Activo__c
                            From Usuario_de_Portal__c
                            Where Usuario__c =: usuario Limit 1];
                
                if(usuario.Contrase_a__c == contrasena){
                    if(usuario.Activo__c){
                        if(usuario.Comercio_Afiliado__r.Activo__c){
                            list<Descuento__c> descuento = [Select id From Descuento__c 
                                                            Where Comercio_Afiliado__c =: usuario.Comercio_Afiliado__c
                                                            And activo__c = true Limit 1];
                                                            
                            if(!descuento.isEmpty()){
                                //return new pageReference('/vfMenuTransacciones?IdComercio=' + usuario.Comercio_Afiliado__c + '&idDescuento=' + descuento[0].id + '&idUsuario=' + usuario.id);
                                idComercio=usuario.Comercio_Afiliado__c;
                                 idDescuento = descuento[0].id;
                                 usuario2 = usuario.id;
                                 isLogin=false;
                                 transaccion(); 
                            }Else{
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tu comercio no tiene un descuento activo a aplicarse.'));    
                            }
                        }else{
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Comercio no activo.'));    
                        }
                    }else{
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Usuario no activo.'));    
                    }
                }else{
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Usuario o Contraseña no válidos.')); 
                }
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Usuario o Contraseña no válidos.'));   
        }
        return null;
    }
    
    
     public void transaccion(){
        tabActiva();
        pagina = 'vfTransaccionesPortal?idComercio=' + idComercio + '&idDescuento=' + idDescuento + '&idUsuario=' + usuario2;
        tActTab = 'slds-is-active'; 
    }
    
    public void transaccionMasiva(){
        tabActiva();
        pagina = 'vfTransaccionesMasivas?idComercio=' + idComercio + '&idDescuento=' + idDescuento + '&idUsuario=' + usuario2;
        tmActTab = 'slds-is-active';     
    }
    
    public void tabActiva(){
        tActTab = '';
        tmActTab = '';
    }
    
    public void cerrar(){
        idComercio='';
        idDescuento='';
        usuario2='';
        usuario='';
        contrasena='';
        isLogin=true;
    }
}