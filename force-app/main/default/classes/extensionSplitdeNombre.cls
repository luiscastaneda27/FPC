public class extensionSplitdeNombre {
    public List<string> splitString {get;set;}
    public List<string> splitApellido {get;set;}
    
    public extensionSplitdeNombre (ApexPages.StandardController controller) {
        /*----Nombre----*/
        if(!test.isRunningTest()){
            controller.addFields(new List<string>{'Account.FirstName'});
            controller.addFields(new List<string>{'Account.LastName'});
        }
        
        
        
        Opportunity record = (Opportunity)controller.getRecord();

        splitString = new List<string>();

        if(!String.IsBlank(record.Account.FirstName))
            splitString = record.Account.FirstName.split(' ');
            
                        
        /*----Apellido----*/
        /*--Opportunity record2 = (Opportunity)controller.getRecord();--*/

        splitApellido = new List<string>();

        if(!String.IsBlank(record.Account.LastName))
            splitApellido = record.Account.LastName.split(' ');

    }
}