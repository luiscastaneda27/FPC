@isTest
public class JobCasosTest {
    
    static testMethod void JobCasos(){ 
        map<String, String> mapTipoR = new map<String, String>();
        for(RecordType item: [Select Name, DeveloperName, id From RecordType Where sObjectType = 'Case' and name !='Retiros20' Order by DeveloperName ]){
            mapTipoR.put(item.DeveloperName, item.id);
        }
        
        Account natural = new Account(FirstName = 'Juan', LastName = 'Perez', Identificacion__c = '12345', PersonBirthdate = date.valueOf('1990-10-11'),
                                      RecordTypeId = [Select id From RecordType Where sObjectType = 'Account' AND DeveloperName = 'Natural'].id);
        
        Case caso = new Case(AccountId = natural.id, Status = 'Nuevo', Origin = 'Agencias_Banco', Nombre_Usuario_Firmador__c = 'aa', RecordTypeId = mapTipoR.get('Actualizacion_informacion'));
        insert caso;
        
        JobCasos ew = new JobCasos();
        ew.execute(null);
        
    }

}