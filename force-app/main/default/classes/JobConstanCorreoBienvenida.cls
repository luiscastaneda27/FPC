global with sharing class JobConstanCorreoBienvenida implements Schedulable {
   global void execute(SchedulableContext ctx) {
        //Job para que se ejecute a las 9:00 AM todos los dias, para enviar el correo de bienvenida a los nuevos afiliados
        ControllerConstactProject.EnvioCorreoBienvenida();
    }
}