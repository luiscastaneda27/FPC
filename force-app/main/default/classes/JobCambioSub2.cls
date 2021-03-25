global class JobCambioSub2 implements Schedulable { 
    global void execute(SchedulableContext ctx) {
        ControllerSubEscalonado.cambioSubEsc2();
    }
}