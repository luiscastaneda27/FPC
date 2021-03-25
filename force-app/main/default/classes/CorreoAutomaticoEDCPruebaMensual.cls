global with sharing class CorreoAutomaticoEDCPruebaMensual implements Schedulable{
    global void execute(SchedulableContext SC){ 
      EstadosDeCuentaPrueba.enviarCorreos(Null, 'A2');   
    }  
}