global with sharing class CorreoAutomaticoEDCmensual implements Schedulable{
    global void execute(SchedulableContext SC){
        
            EstadosDeCuenta.enviarCorreos(Null, 'A2');   
    }  
    
}