global with sharing class InsertarTablaCorreos implements Schedulable{
    global void execute(SchedulableContext SC){
    	
    		EstadosDeCuenta.InsertarCorreos();	
    }    

}