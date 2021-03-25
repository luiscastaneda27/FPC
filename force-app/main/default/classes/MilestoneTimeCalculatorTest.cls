@isTest 
private class MilestoneTimeCalculatorTest {
    static testMethod void testMilestoneTimeCalculator() {        
      
        // Select an existing milestone type to test with
        MilestoneType[] mtLst = [SELECT Id, Name FROM MilestoneType LIMIT 1];      
        if(mtLst.size() == 0) { return; }
        MilestoneType mt = mtLst[0]; 
        
        //RecordType
        Id RecordTypeIdCase = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Retiros').getRecordTypeId();
        
        //Account
        Account acc = new Account(name='Test Account');
        insert acc;
        
        //Contact
        Contact con = new Contact(FirstName='john', LastName='doe', Email='john@doe.com', AccountId=acc.Id);
	    insert con;
        
        //Asset
        Asset ass = new Asset(AccountId=acc.Id,ContactId=con.Id, Name='testing');
        insert ass;
        
        //Entitlement
        Entitlement ent = new Entitlement(Name='Testing', AccountId=acc.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
        insert ent;
        
        FechaDC_Sysde__c fdcSysde2 = new FechaDC_Sysde__c(Name = 'CierreAlDia', Fecha_cierre__c  = date.today());
        insert fdcSysde2;
        
        // Create case data.
        // Typically, the milestone type is related to the case, 
        // but for simplicity, the case is created separately for this test.
        Case c = new Case(priority = 'Alta', RecordTypeId = RecordTypeIdCase, AccountId = acc.Id);
        insert c;
        
        /*EntitlementAccount ec = new EntitlementAccount(EntitlementId=ent.Id, AccountId=acc.Id);
	    insert ec;*/
        
        myMilestoneTimeCalculator calculator = new myMilestoneTimeCalculator();
        Integer actualTriggerTime = calculator.calculateMilestoneTriggerTime(c.Id, mt.Id);
        
        myMilestoneTimeCalculator2 calculator2 = new myMilestoneTimeCalculator2();
        Integer actualTriggerTime2 = calculator2.calculateMilestoneTriggerTime(c.Id, mt.Id);
        
    }
}