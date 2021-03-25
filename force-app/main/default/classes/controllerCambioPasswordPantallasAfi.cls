public class controllerCambioPasswordPantallasAfi {
    
    public string usuario {get; set;}
    public string contrasenia {get; set;}
    public string pagina{get;set;}
    public Usuarios_de_Pantallas__c Cambiopass {get; set;}
    
    public controllerCambioPasswordPantallasAfi()
    {
        
         
    }
    
    public  pageReference CambioPass()
    {

        try{ 
            Cambiopass = new Usuarios_de_Pantallas__c();
            Cambiopass = [select id from Usuarios_de_Pantallas__c where Usuario__c=:usuario];
            Cambiopass.Contrase_a__c=contrasenia;
        
            if(validarContrasenias())
            {
                  update Cambiopass;
                  return new pageReference ('/Apex/vfLoginPantallas');
                  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'creación realizada con exito'));	
                
        }
            
        } 
        catch(exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se encontro usuario'));	
        }
        return null;
     
    }
    
     public boolean validarContrasenias(){
        
        //Verificar que la contraseña tiene al menos un dígito, una mayúscula una minúscula y un carácter especial
        contrasenia=Cambiopass.Contrase_a__c;
        if(contrasenia.length() >= 8){
            Integer num = contrasenia.length();        
            if(!pattern.matches('((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[*@#$%]).{'+ num +'})', contrasenia) || !pattern.matches('((?=.*[*@#$%])(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{' + num + '})', contrasenia)
                || !pattern.matches('((?=.*\\d)(?=.*[a-z])(?=.*[*@#$%])(?=.*[A-Z]).{' + num + '})', contrasenia) ){
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR,                         
                        'La contraseña debe tener al menos una letra mayúscula, una letra minúscula, un número y cualquiera de los simbolos [*@#$%].')); 
                return false;
            }
        }else{
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'La contraseña debe de tener al menos 8 caracteres'));       
                return false;             
        }            
        return true;
    }
    
   

}