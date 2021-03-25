@isTest
public class testExtensionProspecto{

    static testMethod void metodo1(){
        Lead prospecto = new Lead();
        prospecto.recordTypeId = [Select Id From RecordType 
                                Where developerName = 'Natural' AND sObjectType = 'lead'].id;
        
        test.startTest();
            extensionProspecto nuevo = new extensionProspecto(new ApexPages.StandardController(prospecto));
        
        test.stopTest();
    }
}