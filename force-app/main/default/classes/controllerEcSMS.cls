public class controllerEcSMS {
    public String cuentaColectiva { get; set; }
    public String cuentaIndividual { get; set; }
    public String subProducto { get; set; }
    public String identidad { get; set; }
    public Date fechaHasta { get; set; }
    public Date fechaHastaId { get; set; }
    public Date fechaHastaCo { get; set; }
    public Date fechaHastaSp { get; set; }
    public String mensaje { get; set; }
    public String celular { get; set; }
    public String nombre  { get; set; }
    public Double saldo  { get; set; }
    public List<CelularesSMS> listTelefonos {get;set;}
    
    public List<SelectOption> opcionSubproducto {get;set;}
    
    public controllerECSMS()
    {
        Iniciar();
        opcionSubproducto = new List<SelectOption>();
        llenarSubproductos();
    }
    
    public void Iniciar()
    {
        cuentaColectiva = '';
    	cuentaIndividual = '';
    	subProducto = '';
    	identidad = '';
    	fechaHastaId = null;
        fechaHastaCo = null;
        fechaHastaSp = null;
    	mensaje = '';
    	celular = '';
    	nombre = '';
    	saldo = 0;
    }
    
    public void enviaPINmas ()
    {
        try
        {
           string temporal;
            classEnvioEcSMS claseEnvio = new classEnvioEcSMS();
            temporal = controllerApiEcSMS.enviarPINmasivo();
				
			if(temporal != null)
            {
                system.debug('LISTA EN EN EL CONTROLADOR:' + temporal); 
                
                controllerApiEcSMS.enviarSMS(temporal);
            }  
        }Catch(Exception e)
        {
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    }
    
    public void enviaECmas ()
    {
        try
        {
            string temporal;
            classEnvioEcSMS claseEnvio = new classEnvioEcSMS();
            temporal = controllerApiEcSMS.enviarPINmasivo();
				
			if(temporal != null)
            {
                system.debug('LISTA EN EN EL CONTROLADOR:' + temporal); 
                
                controllerApiEcSMS.enviarSMSec(temporal);
            }    
        }Catch(Exception e)
        {
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    }
    
    public void enviaPINid ()
    {
        try
        {
           string temporal;
            classEnvioEcSMS claseEnvio = new classEnvioEcSMS();
            temporal = controllerApiEcSMS.enviarPINId(identidad);
				
			if(temporal != null)
            {
                system.debug('LISTA EN EN EL CONTROLADOR:' + temporal); 
                
                controllerApiEcSMS.enviarSMS(temporal);
            }  
        }Catch(Exception e)
        {
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    }
    
    public void enviaECid ()
    {
        try
        {
            string temporal;
            classEnvioEcSMS claseEnvio = new classEnvioEcSMS();
            temporal = controllerApiEcSMS.enviarPINId(identidad);
				
			if(temporal != null)
            {
                system.debug('LISTA EN EN EL CONTROLADOR:' + temporal); 
                
                controllerApiEcSMS.enviarSMSec(temporal);
            }    
        }Catch(Exception e)
        {
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    }
    
    public void enviaPINcolectiva ()
    {
        try
        {
            string temporal;
            classEnvioEcSMS claseEnvio = new classEnvioEcSMS();
            temporal = controllerApiEcSMS.enviarPINColectiva(cuentaColectiva);
				
			if(temporal != null)
            {
                system.debug('LISTA EN EN EL CONTROLADOR:' + temporal); 
                
                controllerApiEcSMS.enviarSMS(temporal);
            }            
        }Catch(Exception e) 
        {
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    }
    
    public void enviaECcolectiva ()
    {
        try
        {
            string temporal;
            classEnvioEcSMS claseEnvio = new classEnvioEcSMS();
            temporal = controllerApiEcSMS.enviarPINColectiva(cuentaColectiva);
				
			if(temporal != null)
            {
                system.debug('LISTA EN EN EL CONTROLADOR:' + temporal); 
                
                controllerApiEcSMS.enviarSMSec(temporal);
            }  
        }Catch(Exception e)
        {
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    }
    
    public void llenarSubproductos()
    {
        try
        {
            opcionSubproducto = new list <selectOption>();
            opcionSubproducto.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Subproducto__c item:[select name, codigo__c from Subproducto__c])
            {
                opcionSubproducto.add(new selectOption(item.codigo__c, item.name));
            }
        }catch(exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));
        }
    }
    
    public void enviaPINsubproducto ()
    {
        try
        {
            string temporal;
            classEnvioEcSMS claseEnvio = new classEnvioEcSMS();
            temporal = controllerApiEcSMS.enviarPINSubproducto(subProducto);
				
			if(temporal != null)
            {
                system.debug('LISTA EN EN EL CONTROLADOR:' + temporal); 
                
                controllerApiEcSMS.enviarSMS(temporal);
            }          
        }Catch(Exception e)
        {
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    }
    
    public void enviaECsubproducto ()
    {
        try
        {
            string temporal;
            classEnvioEcSMS claseEnvio = new classEnvioEcSMS();
            temporal = controllerApiEcSMS.enviarPINSubproducto(subProducto);
				
			if(temporal != null)
            {
                system.debug('LISTA EN EN EL CONTROLADOR:' + temporal); 
                
                controllerApiEcSMS.enviarSMSec(temporal);
            } 
        }Catch(Exception e)
        {
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    }
}