public class extensionSolicitudInfo {
    public list<Beneficiario__c> hijos {get;Set;}
    public Beneficiario__c padre{get;set;}
    public Beneficiario__c madre{get;set;}
    
    public extensionSolicitudInfo(ApexPages.StandardController controller) {
        Opportunity opo = (Opportunity)controller.getRecord();
        hijos = new list<Beneficiario__c>();
        padre = new Beneficiario__c();
        madre = new Beneficiario__c();
        
        list<Beneficiario__c> benes = [Select Identidad__c,Parentesco__c, Primer_Apellido__c, Primer_Nombre__c,Segundo_Apellido__c, Segundo_Nombre__c
                                        ,Fecha_Nacimiento__c,Cliente__c,Telefono__c, direccion__c,edad__c
                                         From Beneficiario__c Where Oportunidad__c =: opo.id];
                                        
        For(Beneficiario__c b : benes){
            if(b.Parentesco__c == 'Padre')
                padre = b;
            else if( b.Parentesco__c == 'Madre')
                madre = b;
            else if( b.Parentesco__c == 'Hijo(a)')
                hijos.add(b);        
        }
                                                
    }

}