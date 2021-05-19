public class controllerAprobarClientesPEP {
	Public list<classAprobarClientesPEP> ListAprobacionPEP{get;set;}
    //public classAprobarPEP AprobarPEPUnico{get;set;}
    public string usuario {get;set;}
    public string identificador {get;set;}
    
    public controllerAprobarClientesPEP()
    {
        mostrarLista();
        //ListAprobacionPEP = new List<classAprobarClientesPEP>();
    }
    
    public void mostrarLista()
    {
        classAprobarPEP fcsd = APIClienteJuridico.ConsultaInfoAproPEP();
        if(fcsd.ListAprobacionPEP != null){
			system.debug('lista: '+fcsd.ListAprobacionPEP);
            ListAprobacionPEP = fcsd.ListAprobacionPEP;
            system.debug('lista asignada: '+ListAprobacionPEP);
        }
    }
    
    public void AprobarPEP()
    {
        try{
            system.debug('identificador: '+identificador);
            string accion = 'A';
            string resultado = APIClienteJuridico.aprobDenePEP(identificador, accion);
          	if(resultado.contains('"OK"'))
            {
           		 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, 'La Aprobación del cliente con identificación : ' + identificador + ' se realizó con éxito.'));     
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, 'Hubo un error al realizar la aprobación del cliente con identificación : ' + identificador + '.'));
            }
            mostrarLista();
 
        }
        
       catch(Exception e)
    	{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
     	}
       //return null;
    }
    
    public void DenegarPEP()
    {
        try{
            system.debug('identificador: '+identificador);
            string accion = 'D';
            string resultado = APIClienteJuridico.aprobDenePEP(identificador, accion);
            if(resultado.contains('"OK"'))
            {
           		 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, 'La Denegación del cliente con identificación : ' + identificador + ' se realizó con éxito.'));     
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, 'Hubo un error al realizar la denegación del cliente con identificación : ' + identificador+ '.' ));
            }
 			mostrarLista();
           
        }
        
       catch(Exception e)
    	{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
     	}
       //return null;
    }
}