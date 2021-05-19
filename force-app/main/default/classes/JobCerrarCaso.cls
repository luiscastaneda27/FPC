global without sharing class JobCerrarCaso implements Schedulable { 
    global void execute(SchedulableContext ctx) {
        try{
            List<Case> listCasos = new List<Case>();
            for(Case item: [Select Id, Status, CerrarCasoJob__c From Case Where CerrarCasoJob__c = true] ){
                item.CerrarCasoJob__c = false;
                item.Status = 'Cerrado';
                listCasos.add(item);
            }
            Database.update(listCasos, true);
            CronClass.deleteCron('CerrarCasos');
            system.debug('Exitoso: '+listCasos);
        }catch(Exception ex){
            system.debug('Error: '+ex.getMessage());
        }
    }
}