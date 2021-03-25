@isTest(seeAllData=true)
public class testextensionSolicitudInfo{
    static testMethod void  extensionSolicitudInfo() {
        Opportunity opo = [Select id From Opportunity limit 1];
        
        test.startTest();
            extensionSolicitudInfo control = new extensionSolicitudInfo(new ApexPages.StandardController (opo));
        test.stopTest();
    }
}