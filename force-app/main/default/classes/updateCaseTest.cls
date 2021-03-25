@isTest
public class updateCaseTest {
  public static testmethod void execute() {
        
        if(!System.isFuture() && !System.isBatch()) {
        //crear cuenta
        Account acc = new Account(); 
        acc.Identificacion__c = '0801399412010';    
        acc.Name = 'Test Account';
        insert acc;
          
        Contact con = new Contact(FirstName='john', LastName='doe', Email='john@doe.com', AccountId=acc.Id);
    insert con;
        
        Asset ass = new Asset(AccountId=acc.Id,ContactId=con.Id, Name='testing');   
    insert ass;
        
        Entitlement ent = new Entitlement(Name='Testing', AccountId=acc.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
    insert ent;
        
        FechaDC_Sysde__c fdcSysde2 = new FechaDC_Sysde__c(Name = 'CierreAlDia2', Fecha_cierre__c  = date.today());
        insert fdcSysde2;
                     
        Profile prof = [select id from profile where Name='Administrador del Sistema'];
        User user = new User();
        user.firstName = 'test1';
        user.lastName = 'test2';
        user.profileId = prof.id;
        user.username = 'standarduser2020@testorg.com';
        user.email = 'standarduser2020@testorg.com';
        user.Alias = 'standar';
        user.LocaleSidKey='en_US';
        user.TimeZoneSidKey='America/Los_Angeles';
        user.EmailEncodingKey='UTF-8';
        user.LanguageLocaleKey='en_US';        
        insert user;
 
        String RecordTypeId = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Email to Case'].Id;    
        Case c0 = new Case();
        c0.AccountId = acc.Id;
        c0.ContactId = con.Id;    
        //c0.EntitlementId = ent.Id;
        c0.Priority = 'Alta';
        c0.OwnerId = user.Id;
        c0.RecordTypeId = RecordTypeId; 
        c0.SuppliedEmail = 'test@gmail.com';
        c0.Caso_Ingresado__c = false;
        c0.Status = 'Nuevo';
        c0.Origin = 'Correo electrónico FPC';
        c0.Type = 'Solicitud';                  
        Insert c0;       
            
        String RecordTypeId2 = [Select Id From RecordType Where SobjectType = 'Case' and Name = 'Reposición de Carnet'].Id;        
        Case c = new Case();
        c.AccountId = acc.Id;
        c.ContactId = con.Id;    
        c.EntitlementId = ent.Id;
        c.Priority = 'Alta';
        c.OwnerId = user.Id;
        c.Reason = 'Otro';
        c.RecordTypeId = RecordTypeId2; 
        c.SuppliedEmail = 'test@gmail.com';
        c.Caso_Ingresado__c = false;        
        c.Status = 'Nuevo';
        c.Origin = 'Correo electrónico FPC';
        c.Type = 'Solicitud';                
        Insert c;     
        
        Case c1 = new Case();
        c1.Priority = 'Alta';
        c1.OwnerId = user.Id;
        c1.RecordTypeId = RecordTypeId; 
        c1.SuppliedEmail = 'test@gmail.com';
        c1.Caso_Ingresado__c = false;
        c1.Status = 'Nuevo';    
        Insert c1;    
            
        List<Id> setCaseId = new List<Id>();
        setCaseId.add(c.id);
        
        set<Id> setCaseIds = new set<Id>();
        setCaseIds.add(c.id);
 
        Test.startTest();
            updateCase.processCase(setCaseId);
            updateCase.processCasePortalAuto(setCaseIds);
        Test.stopTest();
        }
  }
}