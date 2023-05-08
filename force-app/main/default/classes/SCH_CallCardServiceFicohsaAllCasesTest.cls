/**
*Class Name: SCH_CallCardServiceFicohsaAllCasesTest
*Description: Clase test de la clase Schedulable SCH_CallCardServiceFicohsaAllCases
*Created Date: 30/01/2023 11:22 AM
*Created By: Cloud Code   
*Last Modified by: Cloud Code 13/02/2023 14:48 PM
*/
@istest
public class SCH_CallCardServiceFicohsaAllCasesTest {
    
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
    
    static testMethod void execute() { 
        
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
                
                SCH_CallCardServiceFicohsaAllCases sch = new SCH_CallCardServiceFicohsaAllCases();   
                String chron = '0 0 23 * * ?';        
                String jobId = system.schedule('Test SCH_CallCardServiceFicohsaAllCases', chron, sch);
                
                // Get the information from the CronTrigger API object
                CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
                
                // Verify the expressions are the same
                System.assertEquals(chron, ct.CronExpression);
            }   
        Test.stopTest();
	}
    
}