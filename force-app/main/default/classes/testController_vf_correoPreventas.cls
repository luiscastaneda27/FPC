@isTest
public class testController_vf_correoPreventas 
{
    static testMethod void controller_vf_correoPreVentas(){
        test.startTest();
        PreVenta__c p= new PreVenta__c();
        p.email__C='wendy.alvarado@ficohsa.com';
        insert p;
        
        ApexPages.currentPage().getParameters().put('id',p.id);
        controller_vf_correoPreVentas al =  new controller_vf_correoPreVentas();
        al.tarea.subject = '';
        al.tarea.Cuerpo__c = '';
        al.guardar();
        Task T = new Task();
        T.Para1__c = 'wendy.alvarado@ficohsa.com';
        T.De__c = 'wendy.alvarado@ficohsa.com';
        //T.Subject = 'Subject';
        //T.ActivityDate =  date.today();   
        //T.Description = 'Prueba';
        //T.Status = 'Completado';
        insert T;
        //al.guardar();
        test.stopTest();
    }

}