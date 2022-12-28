global class SCH_CallCardServiceFicohsa implements Schedulable {
    global void execute(SchedulableContext sc) {
        // Implement any logic to be scheduled

        // We now call the batch class to be scheduled
        BAT_CallCardServiceFicohsa b = new BAT_CallCardServiceFicohsa();
        
        //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(b,50);
    }
}