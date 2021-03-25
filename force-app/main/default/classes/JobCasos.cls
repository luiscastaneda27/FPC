global with sharing class JobCasos implements Schedulable { 
    global void execute(SchedulableContext ctx) {
        aFPCCasosCallouts.callSevicio();
    }
    
    
}