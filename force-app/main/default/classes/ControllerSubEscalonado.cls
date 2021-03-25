public class ControllerSubEscalonado {
    public List<cuentasSubp>Listcuentas{get; set;}
    
    public ControllerSubEscalonado()
    {
        Listcuentas = new List<cuentasSubp>();
    }
    
    @future(callout=true)
    public static void cambioSubEsc1(){
        try{
            String querySub = 'Select Sub_Producto_Origen__c from SubPr_Escalonado__mdt Where DeveloperName = ';
            querySub += '\'Cambio1\'';
            SubPr_Escalonado__mdt cuerpoSubpr = dataBase.query(querySub);
            String sub = cuerpoSubpr.Sub_Producto_Origen__c;
            
            String querySubDestino = 'Select Sub_Producto_Destino__c from SubPr_Escalonado__mdt Where DeveloperName = ';
            querySubDestino += '\'Cambio1\'';
            SubPr_Escalonado__mdt cuerpoSubprDestino = dataBase.query(querySubDestino);
            String subDestino = cuerpoSubprDestino.Sub_Producto_Destino__c;
            
            classSubprEscal claseEnvio = new classSubprEscal();
            
            classSubprEscal catb = controllerApiSubEscalonado.consultaSub(sub);
            system.debug('respuesta2: '+catb);         
            
            classCambioSubproducto naturalEnvio = new classCambioSubproducto();
            naturalEnvio.subproducto = subDestino;
            naturalEnvio.accion = 'A2';
            
            if(catb.Listcuentas != null)
            {
                system.debug('Tamano de la lista:' + catb.Listcuentas.size()); 
                for (cuentasSubp item:catb.Listcuentas)
                {
                    naturalEnvio.cuenta = item.cuenta;                    
                    String resultado = controllerApiSubEscalonado.CambioSub(naturalEnvio);                    
                }
                
            } 
            
        }Catch(Exception e)
        {
            system.debug('Error al mostrar subproducto de EDC: ' + e.getMessage() + ' Linea: ' + e.getLineNumber() + ' Mensaje ' + e.getMessage());	
        }
    }
    
    @future(callout=true)
    public static void cambioSubEsc2(){
        try{
            String querySub = 'Select Sub_Producto_Origen__c from SubPr_Escalonado__mdt Where DeveloperName = ';
            querySub += '\'Cambio2\'';
            SubPr_Escalonado__mdt cuerpoSubpr = dataBase.query(querySub);
            String sub = cuerpoSubpr.Sub_Producto_Origen__c;
            
            String querySubDestino = 'Select Sub_Producto_Destino__c from SubPr_Escalonado__mdt Where DeveloperName = ';
            querySubDestino += '\'Cambio2\'';
            SubPr_Escalonado__mdt cuerpoSubprDestino = dataBase.query(querySubDestino);
            String subDestino = cuerpoSubprDestino.Sub_Producto_Destino__c;
            
            classSubprEscal claseEnvio = new classSubprEscal();
            
            classSubprEscal catb = controllerApiSubEscalonado.consultaSub(sub);
            system.debug('respuesta2: '+catb);         
            
            classCambioSubproducto naturalEnvio = new classCambioSubproducto();
            naturalEnvio.subproducto = subDestino;
            naturalEnvio.accion = 'A2';
            
            if(catb.Listcuentas != null)
            {
                
                system.debug('Tamano de la lista:' + catb.Listcuentas.size()); 
                for (cuentasSubp item:catb.Listcuentas)
                {
                    naturalEnvio.cuenta = item.cuenta;                    
                    String resultado = controllerApiSubEscalonado.CambioSub(naturalEnvio);
                    
                	//ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                }
            } 
            
        }Catch(Exception e)
        {
            system.debug('Error al mostrar subproducto de EDC: ' + e.getMessage() + ' Linea: ' + e.getLineNumber() + ' Mensaje ' + e.getMessage());	
        }
    }
    
    @future(callout=true)
    public static void cambioSubEsc3(){
        try{
            String querySub = 'Select Sub_Producto_Origen__c from SubPr_Escalonado__mdt Where DeveloperName = ';
            querySub += '\'Cambio3\'';
            SubPr_Escalonado__mdt cuerpoSubpr = dataBase.query(querySub);
            String sub = cuerpoSubpr.Sub_Producto_Origen__c;
            
            String querySubDestino = 'Select Sub_Producto_Destino__c from SubPr_Escalonado__mdt Where DeveloperName = ';
            querySubDestino += '\'Cambio3\'';
            SubPr_Escalonado__mdt cuerpoSubprDestino = dataBase.query(querySubDestino);
            String subDestino = cuerpoSubprDestino.Sub_Producto_Destino__c;
            
            classSubprEscal claseEnvio = new classSubprEscal();
            
            classSubprEscal catb = controllerApiSubEscalonado.consultaSub(sub);
            system.debug('respuesta2: '+catb);      
            
            classCambioSubproducto naturalEnvio = new classCambioSubproducto();
            naturalEnvio.subproducto = subDestino;
            naturalEnvio.accion = 'A2';
            
            if(catb.Listcuentas != null)
            {
                
                system.debug('Tamano de la lista:' + catb.Listcuentas.size()); 
                for (cuentasSubp item:catb.Listcuentas)
                {
                    naturalEnvio.cuenta = item.cuenta;
                    
                    String resultado = controllerApiSubEscalonado.CambioSub(naturalEnvio);
                    
                	//ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                }
            } 
            
        }Catch(Exception e)
        {
            system.debug('Error al mostrar subproducto de EDC: ' + e.getMessage() + ' Linea: ' + e.getLineNumber() + ' Mensaje ' + e.getMessage());	
        }
    }
    
    @future(callout=true)
    public static void cambioSubEsc4(){
        try{
            String querySub = 'Select Sub_Producto_Origen__c from SubPr_Escalonado__mdt Where DeveloperName = ';
            querySub += '\'Cambio4\'';
            SubPr_Escalonado__mdt cuerpoSubpr = dataBase.query(querySub);
            String sub = cuerpoSubpr.Sub_Producto_Origen__c;
            
            String querySubDestino = 'Select Sub_Producto_Destino__c from SubPr_Escalonado__mdt Where DeveloperName = ';
            querySubDestino += '\'Cambio4\'';
            SubPr_Escalonado__mdt cuerpoSubprDestino = dataBase.query(querySubDestino);
            String subDestino = cuerpoSubprDestino.Sub_Producto_Destino__c;
            
            classSubprEscal claseEnvio = new classSubprEscal();
            
            classSubprEscal catb = controllerApiSubEscalonado.consultaSub(sub);
            system.debug('respuesta2: '+catb);     
            
            classCambioSubproducto naturalEnvio = new classCambioSubproducto();
            naturalEnvio.subproducto = subDestino;
            naturalEnvio.accion = 'A2';
            
            if(catb.Listcuentas != null)
            {
                
                system.debug('Tamano de la lista:' + catb.Listcuentas.size()); 
                for (cuentasSubp item:catb.Listcuentas)
                {
                    naturalEnvio.cuenta = item.cuenta;                    
                    String resultado = controllerApiSubEscalonado.CambioSub(naturalEnvio);
                    
                	//ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
                }
                
            } 
            
        }Catch(Exception e)
        {
            system.debug('Error al mostrar subproducto de EDC: ' + e.getMessage() + ' Linea: ' + e.getLineNumber() + ' Mensaje ' + e.getMessage());	
        }
    }
     
}