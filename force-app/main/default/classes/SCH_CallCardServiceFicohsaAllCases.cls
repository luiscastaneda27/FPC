/**
*Class Name: SCH_CallCardServiceFicohsaAllCases
*Description: Clase Schedulable que llama al Batch BAT_CallCardServiceFicohsaAllCases
*Created Date: 6/01/2023 01:49 PM
*Created By: Cloud Code   
*Last Modified by: Cloud Code 30/01/2023 11:38 AM
*/
global class SCH_CallCardServiceFicohsaAllCases implements Schedulable {
    global void execute(SchedulableContext sc) {
        // Implement any logic to be scheduled

        // We now call the batch class to be scheduled
        BAT_CallCardServiceFicohsaAllCases b = new BAT_CallCardServiceFicohsaAllCases();
        
        //Parameters of ExecuteBatch(context,BatchSize)
        database.executebatch(b,50);
    }
}