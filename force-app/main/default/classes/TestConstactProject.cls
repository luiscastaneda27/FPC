@isTest(SeeAllData=true)
public with sharing class TestConstactProject {
    static testMethod void runCC(){
        ControllerConstactProject p =  new ControllerConstactProject();
        P.fechaIn = '';
        P.FechaDia = '';
        P.hoy = DATE.today();
        P.FechaInclusion = DATE.today();
        
        ControllerConstactProject.EnvioCorreoMujeresAniversario();
        ControllerConstactProject.EnvioCorreoHombresAniversario();
        ControllerConstactProject.EnvioCorreoBienvenida();
        
        String ctx = '20 30 8 10 2 ?';
        String jobId = System.schedule('testEDCmensual', ctx, new JobConstactAniverHombres());
        String jobId2 = System.schedule('testEDCmensual2', ctx, new JobConstactAniverMujeres());
        String jobId3 = System.schedule('testEDCmensual3', ctx, new JobConstanCorreoBienvenida());
        
        ControllerAPIConstanct a = new ControllerAPIConstanct();
        ControllerAPIConstanct.GetCorreosAniversarioF();
        ControllerAPIConstanct.classCorreosAniversario al = new ControllerAPIConstanct.classCorreosAniversario();
        //list<classCorreosAniversario> v =  new list<classCorreosAniversario>();
       
    }    
}