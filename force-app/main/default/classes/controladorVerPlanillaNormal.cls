public class controladorVerPlanillaNormal {
    
    public list <Contenido_Planilla__c> listEmpleados {get;set;}
    public list <Contenido_Planilla__c> listEmpleados2 {get;set;}
    public boolean activarmodal{get;set;}
    public planilla__C totalPlanilla{get;set;}
    
    public controladorVerPlanillaNormal()
    {
        activarmodal=true;
        listEmpleados = new list<Contenido_Planilla__c>();
        listEmpleados2 = new list<Contenido_Planilla__c>();
        string idPlanilla=ApexPages.currentPage().getParameters().get('idPlanilla');
        totalplanilla=[select TA_Empleado_Obligatorio__c, name,TA_Empleado_Voluntario__c, TA_Patrono_obligatorio__c, 
                       Cantidad_empleados__c, total__C,Total_obligatorios__c ,Total_voluntarios__c,
                       TA_Patrono_Voluntario__c, Total_Reserva_Laboral2__c
                       from planilla__C where id=:idPlanilla];
        string query ='select empleado2__r.Identificacion__c, empleado2__r.name, Planilla__r.Fecha__c,   ';
        query +=  'Aporte_Patrono_obligatorio__c, Aporte_Empleado_Obligatorio__c, Aporte_Patrono_Voluntario__c, ';
        query +=  ' Aporte_Empleado_Voluntario__c, Reserva_Laboral__c  from Contenido_Planilla__c ';
        query +=   ' where planilla__c=\''+IdPlanilla + '\' order by empleado2__r.name asc limit 2200';
        listEmpleados=database.query(query);
        
    }
    
    
}