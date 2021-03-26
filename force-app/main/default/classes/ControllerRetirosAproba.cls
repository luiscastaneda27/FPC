public class ControllerRetirosAproba {
    
    public integer total {get;set;}
    public string usuario {get;set;}
    public string Num_CodReferencia {get;set;}
    public  List<Retiro_Aprobacion__c> ListSeleccionado{get;set;}
    public  List<pagoRetirosC> listt {get;set;}
    
     public ControllerRetirosAproba()
     {
         mostrarLista();
     }
    
    public void mostrarLista()
    {
        
        ListSeleccionado =[ select Numero_Referencia__c, Cuenta__c, Monto_Sysde__c, Monto_Salesforce__c, Fecha_Sysde__c, Fecha_SalesForce__c,
           						compara_monto__c, Forma_Pago__c, Descripcion__c, cuenta_bancaria__c, cuenta_Destino__c, monto_total__c, banco_destino__c,
            					tipo_cuenta__c, moneda__c, tasa_seguridad_poblacional__c, transferencia_ACH__c, cheque__c,Nombre_Cliente__c,Numero_Caso__c
                            from Retiro_Aprobacion__c 
                            where AprobacionM__c = 'S' ]; 
        Integer y = 1;
        for(Integer i = 0; i < ListSeleccionado.size(); i++)
        {
            ListSeleccionado[i].No__c = y;
            y++;
        }
    }

    public void AprobarRetiro()
    {
        //Lista la cual enviara toda la informacion es  --- ListSeleccionado se enviaran todos los que esten aprobacion 'S'
        //Dentro del for se agregar el metodo que hace falta de wendy
                
        
        		/*for(integer i=0; i<ListSeleccionado.size(); i++)
                {

                }*/
         
      	try{
    	cuadreRetirosC2 naturalEnvio = new cuadreRetirosC2();
       
         ListSeleccionado =[ select Numero_Referencia__c, Cuenta__c, Monto_Sysde__c, Monto_Salesforce__c, Fecha_Sysde__c, Fecha_SalesForce__c,
           						compara_monto__c, Forma_Pago__c, Descripcion__c, cuenta_bancaria__c, cuenta_Destino__c, monto_total__c, banco_destino__c,
            					tipo_cuenta__c, moneda__c, tasa_seguridad_poblacional__c, transferencia_ACH__c, cheque__c,Nombre_Cliente__c,Numero_Caso__c
                            from Retiro_Aprobacion__c 
                            where AprobacionM__c = 'S'];
            

        
        system.debug('debugkkkkk'+ ListSeleccionado);
  
        //decimal totalDistribucion;
        //totalDistribucion = 0;
       listt = new List<pagoRetirosC>(); 
       for(integer i=0; i<ListSeleccionado.size(); i++)
        {
            pagoRetirosC p = new pagoRetirosC();
            p.referencia = ListSeleccionado[i].Numero_Referencia__c;
            p.codCuenta = ListSeleccionado[i].Cuenta__c;
            if(ListSeleccionado[i].Monto_Sysde__c != null){p.monMovimto = decimal.valueOf(ListSeleccionado[i].Monto_Sysde__c);}
            if(ListSeleccionado[i].Monto_Salesforce__c != null&&ListSeleccionado[i].Monto_Salesforce__c.trim() != ''){p.monRetirar = decimal.valueOf(ListSeleccionado[i].Monto_Salesforce__c);}
            p.fecMovimto = ListSeleccionado[i].Fecha_Sysde__c;
            p.fecSYSDE = ListSeleccionado[i].Fecha_SalesForce__c;
            //p.comparacion = decimal.valueOf(ListSeleccionado[i].compara_monto__c);
            p.fPago = ListSeleccionado[i].Forma_Pago__c;
            p.descripcion = ListSeleccionado[i].Descripcion__c;
            p.cuentaBancaria = ListSeleccionado[i].cuenta_bancaria__c;
            p.cuentaDestino = ListSeleccionado[i].cuenta_Destino__c;
            if(ListSeleccionado[i].monto_total__c != null){p.monTotal = decimal.valueOf(ListSeleccionado[i].monto_total__c);}
            p.bancoDestino = ListSeleccionado[i].banco_destino__c;
            p.tCuenta = ListSeleccionado[i].tipo_cuenta__c;
            p.moneda = ListSeleccionado[i].moneda__c;   
            if(ListSeleccionado[i].tasa_seguridad_poblacional__c != null){p.tsp = decimal.valueOf(ListSeleccionado[i].tasa_seguridad_poblacional__c);}
            if(ListSeleccionado[i].transferencia_ACH__c != null){p.ach = decimal.valueOf(ListSeleccionado[i].transferencia_ACH__c);}
            if(ListSeleccionado[i].cheque__c != null){p.ck = decimal.valueOf(ListSeleccionado[i].cheque__c);}
            p.nombreCliente = ListSeleccionado[i].Nombre_Cliente__c;   
            if(ListSeleccionado[i].Numero_Caso__c != null){p.numeroCaso = decimal.valueOf(ListSeleccionado[i].Numero_Caso__c);}
            
            
            listt.add(p);
            
        }

            
		  naturalEnvio.ListPagosC = listt;
         system.debug('debug de pruebaaaaa'+ naturalEnvio);
         String resultado = controllerApiCRetiros.pagaRetiros(naturalEnvio);
            
          List<Retiro_Aprobacion__c> acctList = [select Numero_Referencia__c, Cuenta__c, Monto_Sysde__c, Monto_Salesforce__c, Fecha_Sysde__c, Fecha_SalesForce__c,
           						compara_monto__c, Forma_Pago__c, Descripcion__c, cuenta_bancaria__c, cuenta_Destino__c, monto_total__c, banco_destino__c,
            					tipo_cuenta__c, moneda__c, tasa_seguridad_poblacional__c, transferencia_ACH__c, cheque__c,Nombre_Cliente__c,Numero_Caso__c
                            from Retiro_Aprobacion__c where AprobacionM__c = 'S' ];

            for(Retiro_Aprobacion__c acct :acctList){
                acct.AprobacionM__c = 'Y';
            
                }
            
            update acctList;

            mostrarLista();
          
          //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Campo Agregado')); 
        
      } 
      catch(Exception e)
    	{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
     	}
     //  return null; 
        
    }
    
    public void Eliminar()
    {
         /*delete ([select Numero_Referencia__c, AprobacionM__c, Cuenta__c,Fecha_Sysde__c 
                  from Retiro_Aprobacion__c 
                  where Numero_Referencia__c =: Num_CodReferencia]);*/
        try{
            Retiro_Aprobacion__c na = [select Numero_Referencia__c
                                       from Retiro_Aprobacion__c limit 1];
            
            system.debug('na: '+na);
            
            if (na.Numero_Referencia__c == Num_CodReferencia)
            {
                system.debug('entro a if: '+Num_CodReferencia);
                integer pos;
                for(integer i=0; i<ListSeleccionado.size(); i++)
                {
                    system.debug('seleccionado: '+ListSeleccionado[i].Numero_Referencia__c);
                    if(ListSeleccionado[i].Numero_Referencia__c == Num_CodReferencia)   
                    {
                        pos=i;
                        system.debug('pos: '+pos);
                        ListSeleccionado[i].AprobacionM__c = '';
                    }
                   /* for(Retiro_Aprobacion__c acct :acctList){
                acct.AprobacionM__c = 'Y';
            
                }
            
            update acctList;*/
                }
                update ListSeleccionado;
                ListSeleccionado.remove(pos);
            }
            else
            {
                system.debug('entro a else');
                list<Retiro_Aprobacion__c> modifi = new list<Retiro_Aprobacion__c> ();
                modifi = [select Numero_Referencia__c, AprobacionM__c,id from Retiro_Aprobacion__c where Numero_Referencia__c =: Num_CodReferencia ];
                
                
                if(modifi.size()>0){modifi[0].AprobacionM__c = 'S';}
                delete modifi;
                
                integer pos;
                
                for(integer i=0; i<ListSeleccionado.size(); i++)
                {
                    
                    if(ListSeleccionado[i].Numero_Referencia__c == Num_CodReferencia)   
                    {
                        pos=i;
                    }
                    
                }
                
                ListSeleccionado.remove(pos);
            }
            
        }catch(Exception e){}

        //aSysdeCallouts.PDFHistorico();
    }
    

}