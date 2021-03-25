@isTest(SeeAllData = true)
public with sharing class TestJobCambioEscalonado {
    static testMethod void runCC(){
        ControllerSubEscalonado p = new ControllerSubEscalonado();
        
        ControllerSubEscalonado.cambioSubEsc1();
        ControllerSubEscalonado.cambioSubEsc2();
        ControllerSubEscalonado.cambioSubEsc3();
        ControllerSubEscalonado.cambioSubEsc4();
                    
        String ctx = '20 30 8 10 2 ?';
        String job1 = System.schedule('PruebaJob', ctx, new JobCambioSub1());       
        String job2 = System.schedule('PruebaJob2', ctx, new JobCambioSub2());
        String job3 = System.schedule('PruebaJob3', ctx, new JobCambioSub3());
        String job4 = System.schedule('PruebaJob4', ctx, new JobCambioSub4());
        
    }
}