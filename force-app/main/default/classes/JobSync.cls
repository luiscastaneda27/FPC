global with sharing class JobSync implements Schedulable { 
   global void execute(SchedulableContext ctx) {
        aSysdeSincronizador.ACtializarClientes(null);
       //aSysdeSincronizador2.ACtializarClientes2(null);
    }
}