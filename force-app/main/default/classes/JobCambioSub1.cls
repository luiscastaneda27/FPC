global class JobCambioSub1 implements Schedulable { 
    global void execute(SchedulableContext ctx) {       
        ControllerSubEscalonado.cambioSubEsc1();
    }
}