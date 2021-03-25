global class JobCambioSub4 implements Schedulable { 
    global void execute(SchedulableContext ctx) {
        ControllerSubEscalonado.cambioSubEsc4();
    }
}