global class verificarFechaCierreSysde implements Schedulable{
    global void execute(SchedulableContext SC){
        aSysdeCallouts.fechaCierreSysde(date.today());
    }
}