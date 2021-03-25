global with sharing class CorreoAutomaticoEDCtrimestral implements Schedulable{
	global void execute(SchedulableContext SC){
    	
    		EstadosDeCuenta.enviarCorreos(Null, 'A1');	
    }      
}