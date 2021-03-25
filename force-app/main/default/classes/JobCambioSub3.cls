global class JobCambioSub3 implements Schedulable { 
    global void execute(SchedulableContext ctx) {
        ControllerSubEscalonado.cambioSubEsc3();
    }
}