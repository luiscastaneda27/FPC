@istest
public class ControladorProyeccionConsolidado_Test {
    
    static testMethod void aSysdeSincronizador() {
        Account  acc = new Account();
        acc.FirstName = 's';
        acc.LastName = 'S';
        acc.Cliente_Unico_Banco__c = '12';
        acc.PersonEmail = 'test@test.com';
        insert acc;
        Proyeccion__c proy = new proyeccion__c();
        proy.Anios__c = '10';
        proy.AporteInicial__c = 500;
        proy.AporteMensual__c = 10;
        proy.Cliente__c = acc.Id;
        proy.ComisionAporte__c = 5;
        insert proy;
        
        User u = new User(Id = UserInfo.getUserId(), MobilePhone = '123456', Phone = '12345');
        update u;
        
        Test.startTest();
        ControladorGraficoProyecciones.calculoGrafico(proy.id);
        ControladorGraficoProyecciones.envioCorreo(proy.id,'test@test.com', 'Ambas');
        Test.stopTest();
       
     }

}