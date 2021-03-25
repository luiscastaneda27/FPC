public class ControlerPIntereses {
  /*Variables*/ 
    public string error {get;set;}
    public string Usuario  {get;set;}
    public string enviado {get;set;}
    public date Fechapintereses {get;set;}
   	public boolean mostrarTablaIntereses {get;set;} 
    public List<ClassConsultaInteres> ListPagosIntereses {get;set;}
    public integer tama {get;set;}
    
    public void BuscarIntereses(){
        try{
        ClassConsultaInteres claseEnvio = new ClassConsultaInteres();
        ClassConsultaInteres fcsd = ControllerAPIPagaInteres.BuscaPerIntereses(Fechapintereses);
        system.debug('Respuestaaaaaaaa: '+fcsd);
         ListPagosIntereses = fcsd.ListPagosIntereses;
         tama = ListPagosIntereses.size();
        system.debug('ListaConciliados: '+ ListPagosIntereses);
        
        if(ListPagosIntereses != null){
            mostrarTablaIntereses = true;
            //ListPagosIntereses = fcsd.ListPagosIntereses; 
            
        }else{
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Clientes no Encontrados'));

        }
        }
			catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
    }
    
    public void Guardar()
    {        
        try{
          
        error='EL CAMPO FECHA ESTÁ VACÍO';
        enviado='ENVIADO CORRECTAMENTE';
        if(Fechapintereses==null)
        {
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, error)); 
      
        }
       
        else{
            
            ClassPagarIntereses PI = new ClassPagarIntereses();
            
            String queryACH = 'Select Monto__c, Monto_dolar__c From Configuracion_Cobro__mdt Where DeveloperName = '; 
                queryACH += '\'ACH\'';
                Configuracion_Cobro__mdt ACH = dataBase.query(queryACH);
                PI.MontoACH = ACH.Monto__c;
            	PI.MontoACHD = ACH.Monto_dolar__c;
            
            String queryCheque = 'Select Monto__c, Monto_dolar__c From Configuracion_Cobro__mdt Where DeveloperName = '; 
                queryCheque += '\'Cheque\'';
                Configuracion_Cobro__mdt Cheque = dataBase.query(queryCheque);
                PI.MontoCheque = Cheque.Monto__c;
            	PI.MontoChequeD = Cheque.Monto_dolar__c;
                PI.Fechapintereses = Fechapintereses;
            
            string resultado = ControllerAPIPagaInteres.guardarfecha(PI);
    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));
            
            //Fechapintereses=null;
            system.debug('Hola controlador');
        }
       
    }catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }

    }
    
}