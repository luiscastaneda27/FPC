/**
*Class Name: TG_CaseTest
*Description: Clase test para el trigger TG_Case y las clases de apex: TG_CaseHandler, TG_CaseHelper.
*Created Date: 10/01/2023 12:00 PM
*Created By: Cloud Code   
*Last Modified by: Cloud Code 14/02/2023 09:59 AM
*/
@isTest
public class TG_CaseTest {
    
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
    
    public static User createUserPortal() {
        Profile profile1 = [Select Id from Profile where name = 'PortalAutoGestion Perfil'];
        System.debug('What is the profile id ' + profile1);
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        User tuserPortal = new User(  firstname = 'Test',
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
        
        insert tuserPortal;
        
        User u2 = [SELECT id from User WHERE Id=: tuserPortal.Id LIMIT 1];
        system.debug('MC Users ='+ ' ' + u2);
        return u2;
    }
    
    @isTest
    static void executeAfiliacion() {
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String tipOper = UT_TestDataFactory.tipOper = 'A3';
                String tipCase = UT_TestDataFactory.tipOper = 'Aumento_Disminucion_Aportes';
                String canalAporte = 'TA';
                String formaAporte = 'TA';
                Case newcs = UT_TestDataFactory.createCase(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCaseNoExito(newcs);
            }   
        Test.stopTest();
    }
    
    @isTest
    static void executeCambiodeFecha() {
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String tipOper = UT_TestDataFactory.tipOper = 'A4';
                String tipCase = UT_TestDataFactory.tipOper = 'Aumento_Disminucion_Aportes';
                String canalAporte = 'TA';
                String formaAporte = 'TA';
                Case newcs = UT_TestDataFactory.createCase(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCaseNoExito(newcs);
            }   
        Test.stopTest();
    }
    
    @isTest
    static void executeCambioCanal() {
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String body = '[{"CARD_NUMBER":"5184002009194856","ACCOUNT_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_TYPE":"1","CUSTOMER_ID":"30825397.3333333","CARD_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_NUMBER":"50009531998656","PRODUCT":"TRC","AFINITY_GROUP":"500","ACCOUNT_STATUS":"10 - Cuenta Normal","CARD_STATUS":"20 - Tarjeta Normal","CARD_EXPIRATION_DATE":"2026-11-30T00:00:00.000-06:00"}]';
    			Integer code = 200;
        		Test.setMock(HttpCalloutMock.class, new UT_SeviceMockRest(body, code));
                String tipOper = UT_TestDataFactory.tipOper = 'A6';
                String tipCase = UT_TestDataFactory.tipOper = 'Aumento_Disminucion_Aportes';
                String canalAporte = 'TA';
                String formaAporte = 'TA';
                Case newcs = UT_TestDataFactory.createCase(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCaseNoExito(newcs);
            }   
        Test.stopTest();
    }
    
    @isTest
    static void executeCancelacion() {
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String tipOper = UT_TestDataFactory.tipOper = 'A7';
                String tipCase = UT_TestDataFactory.tipOper = 'Aumento_Disminucion_Aportes';
                String canalAporte = 'TA';
                String formaAporte = 'TA';
                Case newcs = UT_TestDataFactory.createCase(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCaseNoExito(newcs);
            }   
        Test.stopTest();
    }
    
    @isTest
    static void executeOtros() {
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String tipOper = UT_TestDataFactory.tipOper = '';
                String tipCase = UT_TestDataFactory.tipOper = 'Otros';
                String canalAporte = '';
                String formaAporte = 'TA';
                Case newcs = UT_TestDataFactory.createCase(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCase(newcs);
            }   
        Test.stopTest();
    }
    
    @isTest
    static void executeRetiro() {
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String tipOper = UT_TestDataFactory.tipOper = '';
                String tipCase = UT_TestDataFactory.tipOper = 'Retiros';
                String canalAporte = 'TA';
                String formaAporte = 'AH';
                Case newcs = UT_TestDataFactory.createCase(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCase(newcs);
            }   
        Test.stopTest();
    }
    
    @isTest
    static void executeEmail2Case() {
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String tipOper = UT_TestDataFactory.tipOper = '';
                String tipCase = UT_TestDataFactory.tipOper = 'Email_to_Case';
                String canalAporte = '';
                String formaAporte = 'TA';
                Case newcs = UT_TestDataFactory.createCase(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
            }   
        Test.stopTest();
    }
    
    @isTest
    static void executeAfiliacionTAOB() {
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String tipOper = UT_TestDataFactory.tipOper = 'A3';
                String tipCase = UT_TestDataFactory.tipOper = 'Aumento_Disminucion_Aportes';
                String canalAporte = 'TAOB';
                String formaAporte = 'TA';
                Case newcs = UT_TestDataFactory.createCase(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCaseNoExito(newcs);
            }   
        Test.stopTest();
    }
    
    @isTest
    static void executeCambioCanalTAOB() {
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String body = '[{"CARD_NUMBER":"5184002009194856","ACCOUNT_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_TYPE":"1","CUSTOMER_ID":"30825397.3333333","CARD_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_NUMBER":"50009531998656","PRODUCT":"TRC","AFINITY_GROUP":"500","ACCOUNT_STATUS":"10 - Cuenta Normal","CARD_STATUS":"20 - Tarjeta Normal","CARD_EXPIRATION_DATE":"2026-11-30T00:00:00.000-06:00"}]';
    			Integer code = 200;
        		Test.setMock(HttpCalloutMock.class, new UT_SeviceMockRest(body, code));
                String tipOper = UT_TestDataFactory.tipOper = 'A6';
                String tipCase = UT_TestDataFactory.tipOper = 'Aumento_Disminucion_Aportes';
                String canalAporte = 'TAOB';
                String formaAporte = 'TA';
                Case newcs = UT_TestDataFactory.createCase(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCaseNoExito(newcs);
            }   
        Test.stopTest();
    }
      
    @isTest
    static void executeAumentoAH() {
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String tipOper = UT_TestDataFactory.tipOper = 'A1';
                String tipCase = UT_TestDataFactory.tipOper = 'Aumento_Disminucion_Aportes';
                String canalAporte = 'AH';
                String formaAporte = 'AH';
                Case newcs = UT_TestDataFactory.createCase(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCase(newcs);
            }   
        Test.stopTest();
    }
    
    @isTest
    static void executeCambioCanalAporteAH() {
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String body = '[{"CARD_NUMBER":"5184002009194856","ACCOUNT_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_TYPE":"1","CUSTOMER_ID":"30825397.3333333","CARD_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_NUMBER":"50009531998656","PRODUCT":"TRC","AFINITY_GROUP":"500","ACCOUNT_STATUS":"10 - Cuenta Normal","CARD_STATUS":"20 - Tarjeta Normal","CARD_EXPIRATION_DATE":"2026-11-30T00:00:00.000-06:00"}]';
    			Integer code = 200;
        		Test.setMock(HttpCalloutMock.class, new UT_SeviceMockRest(body, code));
                String tipOper = UT_TestDataFactory.tipOper = 'A3';
                String tipCase = UT_TestDataFactory.tipOper = 'Aumento_Disminucion_Aportes';
                String canalAporte = 'AH';
                String formaAporte = 'AH';
                Case newcs = UT_TestDataFactory.createCase(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCase(newcs);
                
                List<Case> cs = new List<Case>();
                cs.add(closecs);
                TG_CaseHelper.sendEmailAssignedCase(cs);
            }   
        Test.stopTest();
    }
    
    @isTest
    static void executeCambioCACCAH() {
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String body = '[{"CARD_NUMBER":"5184002009194856","ACCOUNT_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_HOLDER_NAME":"CARLOS ENRIQUE PINEDA LOPEZ","CARD_TYPE":"1","CUSTOMER_ID":"30825397.3333333","CARD_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_HOLDER_LEGAL_ID":"1621199800245","ACCOUNT_NUMBER":"50009531998656","PRODUCT":"TRC","AFINITY_GROUP":"500","ACCOUNT_STATUS":"10 - Cuenta Normal","CARD_STATUS":"20 - Tarjeta Normal","CARD_EXPIRATION_DATE":"2026-11-30T00:00:00.000-06:00"}]';
    			Integer code = 200;
        		Test.setMock(HttpCalloutMock.class, new UT_SeviceMockRest(body, code));
                String tipOper = UT_TestDataFactory.tipOper = 'A5';
                String tipCase = UT_TestDataFactory.tipOper = 'Aumento_Disminucion_Aportes';
                String canalAporte = 'AH';
                String formaAporte = 'AH';
                Case newcs = UT_TestDataFactory.createCase(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCaseNoExito(newcs);
            }   
        Test.stopTest();
    }
    
    @isTest
    static void executeCasoEnAprobacion() {
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String tipOper = UT_TestDataFactory.tipOper = 'A3';
                String tipCase = UT_TestDataFactory.tipOper = 'Aumento_Disminucion_Aportes';
                String canalAporte = 'TA';
                String formaAporte = 'TA';
                Case newcs = UT_TestDataFactory.createCaseInApproval(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                
                Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
            	req1.setComments('Aprobación automática por caso desde el portal de afiliación.');
            	req1.setObjectId(newcs.id);
                
            	req1.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            
            	//Submit on behalf of a specific submitter
            	req1.setSubmitterId(us.Id); 
            
            	//Submit the record to specific process and skip the criteria evaluation
            	req1.setProcessDefinitionNameOrId('AumentoDisminucion');
            
            	//Submit the approval request for the account
            	Approval.ProcessResult result = Approval.process(req1);
                //Case closecs = UT_TestDataFactory.closeCaseNoExito(newcs);
                
            }   
        Test.stopTest();
    }
    
    @isTest
    static void executeCasoReposicionCarnet() {
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String tipOper = UT_TestDataFactory.tipOper = 'A3';
                String tipCase = UT_TestDataFactory.tipOper = 'Reposicion_Carnet';
                String canalAporte = 'TA';
                String formaAporte = 'TA';
                Case newcs = UT_TestDataFactory.createCaseInApproval(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCaseNoExito(newcs);
            }   
        Test.stopTest();
    }
    
    @isTest
    static void executeCasoConstancia() {
        Test.startTest();
            User us = TG_CaseTest.createUser();
            System.runas(us) {
                String tipOper = UT_TestDataFactory.tipOper = 'A3';
                String tipCase = UT_TestDataFactory.tipOper = 'Constancia';
                String canalAporte = 'TA';
                String formaAporte = 'TA';
                Case newcs = UT_TestDataFactory.createCaseInApproval(tipOper, tipCase);
            	Detalle_caso__c detC = UT_TestDataFactory.createDetailCase(newcs, canalAporte, formaAporte);
                Case closecs = UT_TestDataFactory.closeCaseNoExito(newcs);
            }   
        Test.stopTest();
    }
}