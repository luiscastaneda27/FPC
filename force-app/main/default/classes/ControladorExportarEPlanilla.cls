public class ControladorExportarEPlanilla {
    
    public list<Contenido_Planilla__c> contenidoPlanilla{get;set;}
    public planilla__C planilla {get;set;}
    string idPlanilla;
   public  ControladorExportarEPlanilla()
    {
       contenidoPlanilla= new list<Contenido_Planilla__c> ();
        planilla= new planilla__C();
        idPlanilla=ApexPages.currentPage().getParameters().get('id_pla');
        
    }
    
    public PAgeReference CArgarPlanilla()
    {
        try{   
            
            planilla=[select name, TA_Salarios__c, TA_Empleado_Obligatorio__c,
                      TA_Empleado_Voluntario__c, TA_Patrono_obligatorio__c,
                      TA_Patrono_Voluntario__c, Total_Reserva_Laboral2__c, 
                      /*AGREGADO WP 06-12-2019*/
                      TA_Empleado_Extraordinario__c, TA_Patrono_Extraordinario__c, TA_Seguro_de_Vida__c
                      From planilla__C Where id =:idPlanilla];
            contenidoPlanilla = [Select Empleado2__c, Empleado2__r.Identificacion__c,
                        Empleado2__r.Firstname, Empleado2__r.LastName, Salario__c,Aporte_Empleado_Obligatorio__c,
                        Aporte_Empleado_Voluntario__c, Aporte_Patrono_obligatorio__c,Aporte_Patrono_Voluntario__c,
                        Planilla__c, Reserva_Laboral__c,Empleado2__r.IsPersonAccount,
                        /*AGREGADO WP 06-12-2019*/
                        Aporte_Empleado_Extraordinario__c, Aporte_Patrono_Extraordinario__c, Aporte_Seguro_de_Vida__c
                        From Contenido_Planilla__c Where Planilla__c =:idPlanilla
                        Order by Empleado2__r.Firstname
                    ];
           /* planilla.Salario__c=0;
            uncontenido.Reserva_Laboral__c=0;
            uncontenido.Aporte_Empleado_Obligatorio__c=0;
            uncontenido.Aporte_Empleado_Voluntario__c=0;
            uncontenido.Aporte_Patrono_obligatorio__c=0;
            uncontenido.Aporte_Patrono_Voluntario__c=0;
            for(integer i=0; i<contenidoPlanilla.size(); i++)
            {
                uncontenido.Salario__c +=contenidoPlanilla[i].salario__C;
            uncontenido.Reserva_Laboral__c +=contenidoPlanilla[i].Reserva_Laboral__c;
            uncontenido.Aporte_Empleado_Obligatorio__c +=contenidoPlanilla[i].Aporte_Empleado_Obligatorio__c;
            uncontenido.Aporte_Empleado_Voluntario__c +=contenidoPlanilla[i].Aporte_Empleado_Voluntario__c;
            uncontenido.Aporte_Patrono_obligatorio__c +=contenidoPlanilla[i].Aporte_Patrono_obligatorio__c;
            uncontenido.Aporte_Patrono_Voluntario__c +=contenidoPlanilla[i].Aporte_Patrono_Voluntario__c;
            }
            system.debug(uncontenido);*/
        }
        catch(Exception ex)
        {
            
        }
        return null;
        //return new PageReference ('/Apex/vfGenerarPlanilla?Eldudhdhyudb=0011100001NsuTM&loetdncdhjch=a0S11000005FKgl&Moneda=HNL');
    }
	
}