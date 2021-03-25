@isTest(SeeAllData=true)
public class testTR_TrasladarProspecto {
    
    static testMethod void testTR_TrasladarProspecto() {
        test.startTest();
        
          
        
        Lead obj = new Lead ();
            
            obj.Referido_por__c = 'Referido por';
            obj.Description = 'Description';
            obj.Cliente_Localizable__c = true;
            //CurrencyIsoCode = sc.CurrencyIsoCode,
            obj.Departamento__c = 'Gracias a Dios';
            obj.Email = 'dluarca@sbfcorp.com';
            obj.LeadSource = 'Web';
            obj.Nombre_Empresa__c = 'Empresa David Luarca';
            obj.Phone = '5024141414';
            obj.Status = 'En Proceso';
            //Trabaja__c = sc.Trabaja__c,
            obj.FirstName = 'David';
            obj.LastName = 'Luarca';
			obj.RecordTypeid = [Select id From RecordType Where DeveloperName ='Natural' and SObjectType = 'Lead'].id; 
         
        
       // try {
            insert obj;
        //} catch (exception ex){
            
      //  } 
        
        test.stopTest();
        
    }
}