@isTest
public class CaseDetail_Test {
    public static testmethod void execute() {
    	if(!System.isFuture() && !System.isBatch()) {
    	
    	// GET USER FROM USER TABLE...
    	User u = [select name, Id  FROM user LIMIT 1];
    	
    	// RUN AS USER...
    	system.runAs(u) {  
            
            List<RecordType> r1 = [Select Id,Name,DeveloperName From RecordType where sObjectType='Account' and isActive=true and DeveloperName = 'Juridico'];
            
            // TEST ADDING A NEW ACCOUNT...                        
            Account acc = new Account(
               Name = 'temp validation account',
               RecordTypeId = r1[0].Id,
               Tipo_Identificacion__c = '1',
               Identificacion__c = '0801199411013',
               Pais_Trabajo__c = 'Honduras',
               Pais_Residencia__c = 'Honduras',
               Punto_Referencia_Trabajo__c = 'Prueba', 
               Punto_Referencia_Residencia__c = 'Prueba',
               Nombre1__c = 'Referencia 1', 
               Nombre2__c = 'Referencia 01',
               Telefono1__c	= '88612510', 
               Telefono2__c = '88612511'
            );
            insert acc; 
            system.debug('----->>> END ADDING ACCOUNT: ' + acc.name);
                
            // READ ACCOUNT...
            Account a = [select Id,Name FROM account WHERE name = 'temp validation account'];
            system.debug('----->>> END READING ACCOUNT: ' + a.name);
                
            Contact con = new Contact(FirstName='johnn', LastName='Doe', Email='john@doe.com', AccountId=a.Id);
            insert con;
                
            Asset ass = new Asset(AccountId=acc.Id,ContactId=con.Id, Name='testing');
            insert ass;
                
            Entitlement ent = new Entitlement(Name='Testing', AccountId=a.Id, StartDate=Date.valueof(System.now().addDays(-2)), EndDate=Date.valueof(System.now().addYears(2)), AssetId=ass.Id);
            insert ent;     
            
            FechaDC_Sysde__c fdcSysde = new FechaDC_Sysde__c(Name = 'CierreAlDia', Fecha_cierre__c  = date.today().addDays(-2));
            insert fdcSysde;
            
            List<RecordType> rtypes = [Select Id,Name,DeveloperName From RecordType where sObjectType='Case' and isActive=true and DeveloperName = 'Retiros'];           
            
            Case c = new Case();
            c.AccountId = a.Id;
            c.EntitlementId = ent.Id;
            c.Priority = 'Alta';
            c.OwnerId = u.Id;
            c.Reason = 'Otro';
            c.RecordTypeId = rtypes[0].Id;
            c.Aprobado__c = false;
            c.Requiere_aprobacion_exoneracion__c = false;
            Insert c;
                        
            Detalle_caso__c detail = new Detalle_caso__c();
            detail.Caso__c = c.Id;   
            detail.Tipo_retiro__c = '51';
            //detail.Cuenta__c = acc.Id;
            Insert detail;

            //-----------------------------//
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
            req1.setObjectId(c.id);
            req1.setProcessDefinitionNameOrId('Retiros_sin_Exoneracion');
            Approval.ProcessResult result = Approval.process(req1);
            
            List<ProcessInstanceWorkitem> workItems = [SELECT Id, ProcessInstanceId FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId =: c.Id];
            List<Approval.ProcessWorkitemRequest> requests = new List<Approval.ProcessWorkitemRequest>();
            for(ProcessInstanceWorkitem workItem : workItems){
              Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
              req.setWorkitemId(workItem.Id);
              req.setAction('Pending');
              req.setComments('Test.');
              requests.add(req);
            }
            //----------------------------//
            
            /*c.Status = 'Pendiente de aprobación';
            update c;
            
            for(ProcessInstanceWorkitem workItem : workItems){
              Approval.ProcessWorkitemRequest req = new Approval.ProcessWorkitemRequest();
              req.setWorkitemId(workItem.Id);
              req.setAction('Pending');
              req.setComments('Test.');
              requests.add(req);
            }*/

            Test.startTest();    
                detail.Cliente_sigue_Laborando__c = true;
                update detail;
            
            	/*c.Status = 'Pendiente segunda aprobación';
                update c;*/
            
            Test.stopTest();  
	    }
	    system.debug('----->>> RUNNING AS USER: ' + u.name);  
        }
    }
}