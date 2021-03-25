global with sharing class JobConstactAniverHombres implements Schedulable { 
    global void execute(SchedulableContext ctx) {
        //Job para que se ejecute a las 9:00 AM todos los dias, para enviar el correo de aniversario en el fondo 
        ControllerConstactProject.EnvioCorreoHombresAniversario();
    }
}