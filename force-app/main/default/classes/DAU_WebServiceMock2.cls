@isTest
global class DAU_WebServiceMock2 implements WebServiceMock {
   global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) 
   {        
       partnerSoapSforceCom.GetUserInfoResult getUser = new partnerSoapSforceCom.GetUserInfoResult();
       getUser.accessibilityMode = true;
       getUser.chatterExternal = true;
       getUser.currencySymbol = 'USD';
       getUser.orgAttachmentFileSizeLimit = 5;
       getUser.orgDefaultCurrencyIsoCode = 'USD';
       getUser.orgDefaultCurrencyLocale = 'USD';
       getUser.orgDisallowHtmlAttachments = true;
       getUser.orgHasPersonAccounts = true;
       getUser.organizationId = '123456';
       getUser.organizationMultiCurrency = true;
       getUser.organizationName = 'test';
       getUser.profileId = '2345666';
       getUser.roleId = '45678888';
       getUser.sessionSecondsValid = 30;
       getUser.userDefaultCurrencyIsoCode = 'USD';
       getUser.userEmail = 'test@gmail.com';
       getUser.userFullName = 'test@gmail.com';
       getUser.userId = '123456666';
       getUser.userLanguage = 'Español';
       getUser.userLocale = '';
       getUser.userName = 'test@gmail.com2';
       getUser.userTimeZone = '';    
       getUser.userType = '';
       getUser.userUiSkin = '';
              
       WsGestiones.WS_GestionesDAU ws = new WsGestiones.WS_GestionesDAU();
       ws.crearGestion('ADI', '0801199411013', '104932', '4054129000026637', 'Pensiones y Cesantías –Seguro de Vida L', '1234', 'Debito automático Pensiones', 'Otros', 'Juan Pérez', '14', 'Ficohsa Pensiones', null, null, null, null, null, null); 
   }
        
}