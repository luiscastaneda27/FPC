public class partnerSoapSforceComConnect {

    public static void login() {
        try{ 
            
            //Creando caso en Salesforce Tarjetas
            partnerSoapSforceCom.Soap con = new partnerSoapSforceCom.Soap();
            partnerSoapSforceCom.LoginResult loginResult = con.login('pensiones.ficohsa@ficohsa.com.ficohsa', 'Pensiones2020' + '7dOJQar50mg3RDNP8XNvH63PS');
                                 
        } catch(Exception ex) {
        	System.debug('Error: '+ex.getLineNumber()+'---'+ex.getMessage());    
        } 
    }	
}