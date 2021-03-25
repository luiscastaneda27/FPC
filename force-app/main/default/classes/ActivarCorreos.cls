global with sharing class ActivarCorreos implements Schedulable{
    global void execute(SchedulableContext SC){
            EstadosDeCuenta.CambiarEstadoCorreos('A1');	
            
    }    

}