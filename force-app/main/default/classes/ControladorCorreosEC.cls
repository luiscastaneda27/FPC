public class ControladorCorreosEC {

    public list<Correo_estado_cuenta__c> listClientes{get;set;}
    
    public ControladorCorreosEC()
    {
        listClientes = new list<Correo_estado_cuenta__c>();
        listClientes=[select Cliente__r.name, cliente__r.identificacion__C, cliente__r.PersonEmail
                     from Correo_estado_cuenta__c where enviado__C=true and grupo__C<7 order by Cliente__r.name asc];
    }
    
}