global with sharing class CorreoAutomaticoEDCHastaDic implements Schedulable{
    global void execute(SchedulableContext SC){
    	
    		EstadosDeCuenta.enviarCorreos(Null, 'A1');	
    }    

}