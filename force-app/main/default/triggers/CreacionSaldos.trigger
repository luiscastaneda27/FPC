trigger CreacionSaldos on Opportunity (After update, After insert) {

    list<Detalle_Oportunidad__c> DetOpp = new list<Detalle_Oportunidad__c>();
    list<Detalle_Oportunidad__c> DetBorrar = new list<Detalle_Oportunidad__c>();
    list<Id> Borrar = new list<Id>();
    Map<Id, List<Saldo__c>> MapaSaldo = new Map<Id, List<Saldo__c>>();
    
    for(Saldo__c Saldo : [Select Id, Name, Producto__c From Saldo__c])
    {
        if(MapaSaldo.ContainsKey(Saldo.Producto__c))
        {
            MapaSaldo.get(Saldo.Producto__c).add(Saldo);
        }else
        {
            List<Saldo__c> S = new List<Saldo__c>();
            S.add(Saldo);
            MapaSaldo.put(Saldo.Producto__c, S);
        }
    }
    
    for(Integer i = 0; i < Trigger.new.size(); i++){
        Opportunity newOpp = Trigger.new[i];
        Opportunity oldOpp = new Opportunity();
        if(Trigger.isUpdate){
            oldOpp = Trigger.old[i];
        }
        
        if((newOpp.Producto__c != null && Trigger.IsInsert) ||
           (newOpp.Producto__c != null && Trigger.isUpdate &&
            oldOpp.Producto__c != newOpp.Producto__c))
        {
            for(Saldo__c Saldo : MapaSaldo.get(newOpp.Producto__c)){
                Detalle_Oportunidad__c DetOppT = new Detalle_Oportunidad__c();
                   DetOppT.Oportunidad__c = newOpp.Id;
                   DetOppT.Saldo__c = Saldo.Id;
                   DetOppT.Tipo__c = 'Monto';
                   DetOppT.Valor__c = 0;
                   DetOppT.Name = Saldo.Name;
               DetOpp.add(DetOppt);
                
            }
        }
    }
    
    DetBorrar = [Select Id From Detalle_Oportunidad__c Where Oportunidad__c In :Borrar];
    database.delete(DetBorrar);
    database.insert(DetOpp);

}