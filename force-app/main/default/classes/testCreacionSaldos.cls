@isTest(seeAllData=true)
public class testCreacionSaldos{
    static testMethod void  CreacionSaldos() {
        Opportunity opo = [Select id, Name From Opportunity Limit 1];
        opo.Name += 'hola';
        
        test.startTest();
            update opo;    
        
        test.stopTest();
    }
}