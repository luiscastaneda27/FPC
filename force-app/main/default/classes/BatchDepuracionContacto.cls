global without sharing class BatchDepuracionContacto implements Database.Batchable<sObject>, Database.AllowsCallouts{
    
    public DateTime desde;
    public DateTime hasta;
    
    global BatchDepuracionContacto(Integer countEjecuciones, DateTime desde, DateTime hasta){
        this.desde = desde;
        this.hasta = hasta;
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('Select  Id,Estado__c, '+
                                        '(Select Id, CreatedDate '+
                                        ' From EmailStatuses '+
                                        'where Task.Subject = \'Correo electrónico: Estado de cuenta\')'+ 
                                        ' From Contact ');
    }
    
    global void execute(Database.BatchableContext bc, List<sObject> scope) {
        List<Contact> listContactos = new List<Contact>();
        for(Sobject s : scope){
            Contact c = (Contact)s;
            c.Estado__c = c.EmailStatuses.size() > 0 ? 'Listo Para Informe' : 'No Aplica';
            listCOntactos.add(c);
        }
        Database.Update(listContactos, false);
    } 
    
    global void finish(Database.BatchableContext bc) {
        BatchDatosInformeEDC l = new BatchDatosInformeEDC(desde, hasta);
        Id batchprocessid = Database.executeBatch(l, Integer.valueOf(Label.BatchSize));
        
        
    }
}