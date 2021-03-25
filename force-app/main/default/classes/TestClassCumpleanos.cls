@istest
class TestClassCumpleanos {

   static testmethod void test() {
       Test.startTest();
    
          Account a = new Account();
          a.lastName = 'testScheduledApexFromTestMethod';
          a.Receive_Birthday_Emails__pc = true;
          a.PersonBirthdate = date.today();
          a.Correo_actual__c = 'francis.oseguera@intellectsystem.net';
          a.RecordTypeId = [Select id From recordType Where sObjectType = 'Account' AND DeveloperName = 'Natural'].Id;
          insert a;
    
          // Schedule the test job
          String CRON_EXP = '20 30 8 10 2 ?';
 
          String jobId = System.schedule('testBasicScheduledApex', CRON_EXP, new correoCumpleanos());
    
       Test.stopTest();
    
       }
}