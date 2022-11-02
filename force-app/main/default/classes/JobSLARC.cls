global without sharing class JobSLARC implements Schedulable { 
    
    global void execute(SchedulableContext ctx) {
        EnvioCorreoSLA.envioCorreoSLA();
    }

}