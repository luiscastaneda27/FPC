public class controladorRecibo {

    public Planilla__c planilla {get;set;}  
    public String Cuenta{get;set;}
    public string moneda{get;set;}
    public string mensaje{get;set;}
    String id_Planilla;
    
    public controladorRecibo()
    {
        id_Planilla = ApexPages.currentPage().getParameters().get('id_Planilla');

      try{
	       planilla =[select Empresa2__r.name,name ,mes_aporte__C,empresa2__r.RTN_Empresa__c, fecha__c, CurrencyIsoCode, TA_Patrono_obligatorio__c,
	                  TA_Empleado_Obligatorio__c,TA_Empleado_Voluntario__c,Cantidad_empleados__c,
	                  TA_Patrono_Voluntario__c, Total_Reserva_Laboral2__c, Total_voluntarios__c, Total_obligatorios__c,
	                  Total__c, empresa2__r.Identificacion__c, tasa_compra__C 
	                  From planilla__c 
	                  Where id=:id_Planilla];
          moneda=planilla.CurrencyIsoCode;
       		if(planilla.Tasa_compra__c==0)
            {
                moneda='HNL ';
                 mensaje=' (Compra de Dólar)';
            }
			 	        
	       if(Planilla.CurrencyIsoCode=='HNL')
	       {
	           Cuenta='Lempiras 0-0-8493502';
	       }
	       else
	       {
	            Cuenta='USD 0-0-8500991';
	       }
	       
      }Catch(Exception e){
      		system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
      }
   }
    
   
}