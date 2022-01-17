public class WsGestionesConnect {
	public static void datos() {
        try{ 
            
        	WsGestiones.WS_GestionesDAU servDau = new WsGestiones.WS_GestionesDAU();
            
            String DAU_Usuario, DAU_Contrasenia, DAU_Token;
            Parametros_DAU__mdt[] mdt = [SELECT Id,DeveloperName,DAU_Usuario__c,DAU_Contrasenia__c,DAU_Token__c FROM Parametros_DAU__mdt Where DeveloperName = 'Salesforce_Tarjeta_Login'];
            If(!mdt.isEmpty()) {
                DAU_Usuario = mdt[0].DAU_Usuario__c; DAU_Contrasenia = mdt[0].DAU_Contrasenia__c; DAU_Token = mdt[0].DAU_Token__c;
            }
            
            partnerSoapSforceCom.Soap con = new partnerSoapSforceCom.Soap();
            partnerSoapSforceCom.LoginResult loginResult = con.login(DAU_Usuario, DAU_Contrasenia + DAU_Token);   
                
            WsGestiones.SessionHeader_element sessionHeader = new WsGestiones.SessionHeader_element();
            sessionHeader.sessionId = loginResult.sessionid; servDau.timeout_x = 120000; servDau.SessionHeader = sessionHeader;
            
        } catch(Exception ex) {
        	System.debug('Error: '+ex.getLineNumber()+'---'+ex.getMessage());    
        } 
    }
}