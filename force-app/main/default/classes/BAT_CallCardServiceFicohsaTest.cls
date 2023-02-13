/**
*Class Name: BAT_CallCardServiceFicohsaTest
*Description: Clase test del batch BAT_CallCardServiceFicohsa
*Created Date: 19/01/2023 09:38 AM
*Created By: Cloud Code   
*Last Modified by: Cloud Code 30/01/2023 11:40 AM
*/
@isTest
private class BAT_CallCardServiceFicohsaTest {
    
    public static User createUser() {
        Profile profile1 = [Select Id from Profile where name = 'Administrador del Sistema' or name = 'Admin User'];
        System.debug('What is the profile id ' + profile1);
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        User tuser = new User(  firstname = 'Test',
                              lastName = 'Test',
                              email = uniqueName + '@test' + orgId + '.org',
                              Username = uniqueName + '@test' + orgId + '.org',
                              EmailEncodingKey = 'ISO-8859-1',
                              Alias = uniqueName.substring(18, 23),
                              TimeZoneSidKey = 'America/Los_Angeles',
                              LocaleSidKey = 'en_US',
                              LanguageLocaleKey = 'en_US',
                              UserRoleId = portalRole.Id,
                              ProfileId = profile1.Id);
        
        insert tuser;
        
        User u1 = [SELECT id from User WHERE Id=: tuser.Id LIMIT 1];
        system.debug('MC Users ='+ ' ' + u1);
        return u1;
    }
    
    @isTest
    static void executeSuccessALTA() {
        String body = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><loginResponse><result><metadataServerUrl>https://gff--nqafull.sandbox.my.salesforce.com/services/Soap/m/56.0/00D8I0000004f53</metadataServerUrl><passwordExpired>false</passwordExpired><sandbox>true</sandbox><serverUrl>https://gff--nqafull.sandbox.my.salesforce.com/services/Soap/u/56.0/00D8I0000004f53</serverUrl><sessionId>SESSION_ID_REMOVED</sessionId><userId>0058I000000gbx7QAA</userId><userInfo><accessibilityMode>false</accessibilityMode><chatterExternal>false</chatterExternal><currencySymbol>Q</currencySymbol><orgAttachmentFileSizeLimit>5242880</orgAttachmentFileSizeLimit><orgDefaultCurrencyIsoCode>GTQ</orgDefaultCurrencyIsoCode><orgDefaultCurrencyLocale>es_GT</orgDefaultCurrencyLocale><orgDisallowHtmlAttachments>false</orgDisallowHtmlAttachments><orgHasPersonAccounts>false</orgHasPersonAccounts><organizationId>00D8I0000004f53UAA</organizationId><organizationMultiCurrency>false</organizationMultiCurrency><organizationName>Grupo Financiero Ficohsa</organizationName><profileId>00e5c000001R5J9AAK</profileId><roleId>00E5c000001EPOqEAO</roleId><sessionSecondsValid>7200</sessionSecondsValid><userDefaultCurrencyIsoCode xsi:nil="true"/><userEmail>daniel.valenzuela@ficohsa.com</userEmail><userFullName>Juan Jose Vasquez jjvasquez</userFullName><userId>0058I000000gbx7QAA</userId><userLanguage>es</userLanguage><userLocale>es_GT</userLocale><userName>juan.vasquez@ficohsa.com.nqanull</userName><userTimeZone>America/El_Salvador</userTimeZone><userType>Standard</userType><userUiSkin>Theme3</userUiSkin></userInfo></result></loginResponse></soapenv:Body></soapenv:Envelope>';
    	Integer code = 200;
        Test.setMock(HttpCalloutMock.class, new UT_SeviceMockRest(body, code));
        
        String body2 = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="http://soap.sforce.com/schemas/class/WS_DAU_Pensiones"><soapenv:Body><GestionDAUResponse><result><Afiliacion>AFILIACION-14330376</Afiliacion><CodigoError>SUCCESS</CodigoError><estadoGestion>APROBADO</estadoGestion><Gestion>11726142</Gestion></result></GestionDAUResponse></soapenv:Body></soapenv:Envelope>';
    	Integer code2 = 200;
        Test.setMock(HttpCalloutMock.class, new UT_SeviceMockRest(body2, code2));
        
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String tipOper = UT_TestDataFactory.tipOper = 'A3';
                String tipCase = UT_TestDataFactory.tipOper = 'Aumento_Disminucion_Aportes';
                String canalAporte = 'TA';
                String formaAporte = 'TA';
                Case newcs = UT_TestDataFactory.createCase(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCase(newcs);
                list<Detalle_caso__c> lstDetCase = new list<Detalle_caso__c>(); 
                lstDetCase.add(detC);
                Database.executeBatch(new BAT_CallCardServiceFicohsa(lstDetCase, 'ALTA'));
            }   
        Test.stopTest();  
    }
    
    @isTest
    static void executeYaEstaAfiliado() {
        String body = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Body><soapenv:Fault><faultcode>soapenv:Client</faultcode><faultstring>System.ListException: List index out of bounds: 0 Class.WS_DAU_Pensiones.respuestaGS_DAU.ObtenerRespuesta: line 167, column 1 Class.WS_DAU_Pensiones.GestionDAU: line 55, column 1</faultstring></soapenv:Fault></soapenv:Body></soapenv:Envelope>';
    	Integer code = 200;
        Test.setMock(HttpCalloutMock.class, new UT_SeviceMockRest(body, code));
        
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String tipOper = UT_TestDataFactory.tipOper = 'A3';
                String tipCase = UT_TestDataFactory.tipOper = 'Aumento_Disminucion_Aportes';
                String canalAporte = 'TA';
                String formaAporte = '';
                Case newcs = UT_TestDataFactory.createCase(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCase(newcs);
                list<Detalle_caso__c> lstDetCase = new list<Detalle_caso__c>(); 
                lstDetCase.add(detC);
                Database.executeBatch(new BAT_CallCardServiceFicohsa(lstDetCase, 'ALTA'));
            }   
        Test.stopTest();
    }
    
    @isTest
    static void executeSuccessMOD() {
        String body = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><loginResponse><result><metadataServerUrl>https://gff--nqafull.sandbox.my.salesforce.com/services/Soap/m/56.0/00D8I0000004f53</metadataServerUrl><passwordExpired>false</passwordExpired><sandbox>true</sandbox><serverUrl>https://gff--nqafull.sandbox.my.salesforce.com/services/Soap/u/56.0/00D8I0000004f53</serverUrl><sessionId>SESSION_ID_REMOVED</sessionId><userId>0058I000000gbx7QAA</userId><userInfo><accessibilityMode>false</accessibilityMode><chatterExternal>false</chatterExternal><currencySymbol>Q</currencySymbol><orgAttachmentFileSizeLimit>5242880</orgAttachmentFileSizeLimit><orgDefaultCurrencyIsoCode>GTQ</orgDefaultCurrencyIsoCode><orgDefaultCurrencyLocale>es_GT</orgDefaultCurrencyLocale><orgDisallowHtmlAttachments>false</orgDisallowHtmlAttachments><orgHasPersonAccounts>false</orgHasPersonAccounts><organizationId>00D8I0000004f53UAA</organizationId><organizationMultiCurrency>false</organizationMultiCurrency><organizationName>Grupo Financiero Ficohsa</organizationName><profileId>00e5c000001R5J9AAK</profileId><roleId>00E5c000001EPOqEAO</roleId><sessionSecondsValid>7200</sessionSecondsValid><userDefaultCurrencyIsoCode xsi:nil="true"/><userEmail>daniel.valenzuela@ficohsa.com</userEmail><userFullName>Juan Jose Vasquez jjvasquez</userFullName><userId>0058I000000gbx7QAA</userId><userLanguage>es</userLanguage><userLocale>es_GT</userLocale><userName>juan.vasquez@ficohsa.com.nqanull</userName><userTimeZone>America/El_Salvador</userTimeZone><userType>Standard</userType><userUiSkin>Theme3</userUiSkin></userInfo></result></loginResponse></soapenv:Body></soapenv:Envelope>';
    	Integer code = 200;
        Test.setMock(HttpCalloutMock.class, new UT_SeviceMockRest(body, code));
        
        String body2 = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="http://soap.sforce.com/schemas/class/WS_DAU_Pensiones"><soapenv:Body><GestionDAUResponse><result><Afiliacion>AFILIACION-14330376</Afiliacion><CodigoError>SUCCESS</CodigoError><estadoGestion>APROBADO</estadoGestion><Gestion>11726142</Gestion></result></GestionDAUResponse></soapenv:Body></soapenv:Envelope>';
    	Integer code2 = 200;
        Test.setMock(HttpCalloutMock.class, new UT_SeviceMockRest(body2, code2));
        
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String tipOper = UT_TestDataFactory.tipOper = 'A4';
                String tipCase = UT_TestDataFactory.tipOper = 'Aumento_Disminucion_Aportes';
                String canalAporte = 'TA';
                String formaAporte = 'TA';
                Case newcs = UT_TestDataFactory.createCase(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCase(newcs);
                list<Detalle_caso__c> lstDetCase = new list<Detalle_caso__c>(); 
                lstDetCase.add(detC);
                Database.executeBatch(new BAT_CallCardServiceFicohsa(lstDetCase, 'MOD'));
            }   
        Test.stopTest();
    }
    
    @isTest
    static void executeSuccessBAJA() {
        String body = '<?xml version="1.0" encoding="UTF-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><soapenv:Body><loginResponse><result><metadataServerUrl>https://gff--nqafull.sandbox.my.salesforce.com/services/Soap/m/56.0/00D8I0000004f53</metadataServerUrl><passwordExpired>false</passwordExpired><sandbox>true</sandbox><serverUrl>https://gff--nqafull.sandbox.my.salesforce.com/services/Soap/u/56.0/00D8I0000004f53</serverUrl><sessionId>SESSION_ID_REMOVED</sessionId><userId>0058I000000gbx7QAA</userId><userInfo><accessibilityMode>false</accessibilityMode><chatterExternal>false</chatterExternal><currencySymbol>Q</currencySymbol><orgAttachmentFileSizeLimit>5242880</orgAttachmentFileSizeLimit><orgDefaultCurrencyIsoCode>GTQ</orgDefaultCurrencyIsoCode><orgDefaultCurrencyLocale>es_GT</orgDefaultCurrencyLocale><orgDisallowHtmlAttachments>false</orgDisallowHtmlAttachments><orgHasPersonAccounts>false</orgHasPersonAccounts><organizationId>00D8I0000004f53UAA</organizationId><organizationMultiCurrency>false</organizationMultiCurrency><organizationName>Grupo Financiero Ficohsa</organizationName><profileId>00e5c000001R5J9AAK</profileId><roleId>00E5c000001EPOqEAO</roleId><sessionSecondsValid>7200</sessionSecondsValid><userDefaultCurrencyIsoCode xsi:nil="true"/><userEmail>daniel.valenzuela@ficohsa.com</userEmail><userFullName>Juan Jose Vasquez jjvasquez</userFullName><userId>0058I000000gbx7QAA</userId><userLanguage>es</userLanguage><userLocale>es_GT</userLocale><userName>juan.vasquez@ficohsa.com.nqanull</userName><userTimeZone>America/El_Salvador</userTimeZone><userType>Standard</userType><userUiSkin>Theme3</userUiSkin></userInfo></result></loginResponse></soapenv:Body></soapenv:Envelope>';
    	Integer code = 200;
        Test.setMock(HttpCalloutMock.class, new UT_SeviceMockRest(body, code));
        
        String body2 = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="http://soap.sforce.com/schemas/class/WS_DAU_Pensiones"><soapenv:Body><GestionDAUResponse><result><Afiliacion>AFILIACION-14330376</Afiliacion><CodigoError>SUCCESS</CodigoError><estadoGestion>APROBADO</estadoGestion><Gestion>11726142</Gestion></result></GestionDAUResponse></soapenv:Body></soapenv:Envelope>';
    	Integer code2 = 200;
        Test.setMock(HttpCalloutMock.class, new UT_SeviceMockRest(body2, code2));
        
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String tipOper = UT_TestDataFactory.tipOper = 'A7';
                String tipCase = UT_TestDataFactory.tipOper = 'Aumento_Disminucion_Aportes';
                String canalAporte = 'TA';
                String formaAporte = 'TA';
                Case newcs = UT_TestDataFactory.createCase(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCase(newcs);
                list<Detalle_caso__c> lstDetCase = new list<Detalle_caso__c>(); 
                lstDetCase.add(detC);
                Database.executeBatch(new BAT_CallCardServiceFicohsa(lstDetCase, 'BAJA'));
            }   
        Test.stopTest();
    }
    
}