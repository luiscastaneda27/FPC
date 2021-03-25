global with sharing class CorreoAutomaticoEDCtrimestralPrueba implements Schedulable{
    global void execute(SchedulableContext SC){
    	
    		EstadosDeCuentaPrueba.enviarCorreos(Null, 'A1');	
    }    

}