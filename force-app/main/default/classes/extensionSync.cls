public class extensionSync {
    
   // private apexPages.StandardController x;
    public string codigo {get;set;}
    
    public extensionSync(apexPages.StandardController c){
       // x = c;
        codigo = [select Cliente_Unico_Banco__c from account where id =: c.getId()].Cliente_Unico_Banco__c;
    }
    
    public void sync(){
        aSysdeSincronizador.ActializarClientes(codigo);
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.confirm,'Espere un momento para ver la información.'));
    }

}