@isTest(seeAllData=true)
public class extensionSplitdeNombreTest{
    public static testmethod void SplitNombre(){
        Account cuenta = new Account();
        Opportunity opor = [SELECT Account.FirstName, Account.LastName FROM Opportunity limit 1];
        
        extensionSplitdeNombre sNombre = new extensionSplitdeNombre(new ApexPages.StandardController(opor ));
    }
}