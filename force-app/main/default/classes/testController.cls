public class testController {
    
    @AuraEnabled
    public static TestLWC getRecords() {
        try{
            TestLWC objTestLWC = new TestLWC();
            objTestLWC.listClassRecord = new List<ClassRecord>();
            objTestLWC.listPicklist = new List<Picklist>();
            for(TestLWC__C item: [Select Id, Name, Apellidos__c, FechaNacimiento__c, Sexo__C from TestLWC__C]){
                ClassRecord testL = new ClassRecord();
                testL.id = item.Id;
                testL.nombre = item.Name;
                testL.apellidos = item.Apellidos__c;
                testL.fechaNacimiento = item.FechaNacimiento__c;
                testL.sexo = item.Sexo__C;
                objTestLWC.listClassRecord.add(testL);
            }
            Schema.DescribeFieldResult fieldResult = TestLWC__C.Sexo__C.getDescribe(); 
            for(Schema.PicklistEntry p : fieldResult.getPicklistValues()){ 
                Picklist l = new Picklist();
                l.label = p.getlabel();
                l.value = p.getvalue();
                objTestLWC.listPicklist.add(l);
            }
            system.debug('llego');
           return objTestLWC;
        }catch (Exception e){
            return null;
        }
        
    }
    
    
    @AuraEnabled
    public static String upserRecord(String id, String name, String apellido, String sexo, Date fechaN) {
        try{
            system.debug('LLego: '+id);
            TestLWC__C item = new TestLWC__C();
            item.Id = id;
            system.debug('Exito: '+item);
            item.Name = name;
            system.debug('Exito: '+item);
            item.Apellidos__c = apellido;
            system.debug('Exito: '+item);
            item.Sexo__c = sexo;
            system.debug('Exito: '+item);
            item.fechaNacimiento__c = fechaN;
            system.debug('Exito: '+item);
            upsert item;
            system.debug('Exito');
            return item.Id;
        }catch (Exception e){
            system.debug('Error: '+e.getMessage());
            return null;
        }
        
    }
    
     public class TestLWC{
         @AuraEnabled public List<ClassRecord> listClassRecord {get;set;}
         @AuraEnabled public List<Picklist> listPicklist {get;set;}
     }
    
    public class ClassRecord{
        @AuraEnabled public String id{get;set;}
        @AuraEnabled public String nombre{get;set;}
        @AuraEnabled public String apellidos{get;set;}
        @AuraEnabled public Date fechaNacimiento{get;set;}
        @AuraEnabled public String sexo{get;set;}
        
    }
    
    public class Picklist{
        @AuraEnabled public String label{get;set;}
        @AuraEnabled public String value{get;set;}
    }


}