public class controllerLoginComerio {
    public String Contrasena { get; set; }
    public String usuario { get; set; }
    
    public controllerLoginComerio(){
        usuario = '';
        contrasena = '';
    }    
    
    public pageReference sesionIniciada(){
        try{
            Usuario_de_Portal__c usuario = [Select Contrase_a__c, Comercio_Afiliado__c, Comercio_Afiliado__r.Logo__c,
                            Comercio_Afiliado__r.Name, Comercio_Afiliado__r.Activo__c, Activo__c
                            From Usuario_de_Portal__c
                            Where Usuario__c =: usuario Limit 1];
                
                if(usuario.Contrase_a__c == Contrasena){
                    if(usuario.Activo__c){
                        if(usuario.Comercio_Afiliado__r.Activo__c){
                            list<Descuento__c> descuento = [Select id From Descuento__c 
                                                            Where Comercio_Afiliado__c =: usuario.Comercio_Afiliado__c
                                                            And activo__c = true Limit 1];
                                                            
                            if(!descuento.isEmpty()){
                                return new pageReference('/vfMenuTransacciones?IdComercio=' + usuario.Comercio_Afiliado__c + '&idDescuento=' + descuento[0].id + '&idUsuario=' + usuario.id);
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
}