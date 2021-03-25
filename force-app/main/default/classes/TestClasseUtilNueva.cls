@isTest
public class TestClasseUtilNueva {
    
    static testMethod void ClasseUtilNueva() {
        Account cliente = new Account();
        cliente.Name='Luis Donaire';
        cliente.Identificacion__c='0709199300155';
        insert cliente;
        ClasseUtilNueva.zonaPorDepto(cliente.Id);
        Usuarios_para_asignacion_Casos_SAC__c p =new Usuarios_para_asignacion_Casos_SAC__c ();
        insert p;
        ClasseUtilNueva.CasoDevuelto(p.id, '32232', 'c@ds.d');
   }

}