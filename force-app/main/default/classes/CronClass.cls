public class CronClass {
    
    Public static void deleteCron(String acronName){
        for(CronTrigger item : [SELECT id FROM CronTrigger where CronJobDetail.Name = :acronName]){
            System.abortJob(item.id);
        }
    }

}