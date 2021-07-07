@isTest
public class GetNameFileTest {
    
    static testMethod void GetNameFile(){
        ObjectoReferenciaArchivos__c a = new ObjectoReferenciaArchivos__c (Name = '12345', Cuenta__c = '12345');
        upsert a Cuenta__c;
        
        ControllerAdministracionIntereses gaa = new ControllerAdministracionIntereses();
        gaa.insertFIle(Blob.valueOf('test'), 'test', a.Id);
        gaa.insertFIle(Blob.valueOf('test2'), 'test2', a.Id);
        
        GetNameFile.getResultWrapper(a.Id);
        GetNameFile.getResultWrapper(null);
    }

}