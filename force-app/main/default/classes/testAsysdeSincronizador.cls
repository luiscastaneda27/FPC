@istest
public class testAsysdeSincronizador {
    
    static testMethod void aSysdeSincronizador() {
        SchedulableContext ctx; 
        JobSync d=new JobSync();
        d.execute(ctx);
        Account  f = new Account();
        f.FirstName = 's';
        f.LastName = 'S';
        f.Cliente_Unico_Banco__c = '12';
        insert f;
        extensionSync v = new extensionSync(new ApexPages.StandardController(f));
        v.codigo = '1234';
        v.sync();
        aSysdeSincronizador.actializarClienteIndividual('1234');
     }

}