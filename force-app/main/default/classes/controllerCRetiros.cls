public class controllerCRetiros {
    public date fecha_retiro {get;set;}
    public datetime fechaSysdeRetiros {get;set;}
    public boolean mostrarTablaRetiros {get;Set;}
    public boolean mostrarTablaRetirosC {get;Set;}
    public boolean mostrarTablaRetirosP {get;Set;}
    public boolean mostrarTablaRetirosI {get;Set;}
    public List<cuadreRetiros> ListPagos {get;set;}
    public List<cuadreRetirosC> ListPagosC {get;set;}
    public List<cuadreRetirosP> ListPagosP {get;set;}
    public List<cuadreRetirosI> ListPagosI {get;set;}
    public string fecha {get;set;}
    public string Num_CodReferencia {get;set;}
    public string Id {get;set;}
    public List<Retiro_Aprobacion__c> ListPagosConciliados {get;set;}
    public List<Retiro_Aprobacion__c> ListPagosConciliadosP {get;set;}
    public List<Retiro_Aprobacion__c> ListPagosConciliadosI {get;set;}
    public List<Retiro_Aprobacion__c> ListEnvioTotal {get;set;}
    public List<Retiro_Aprobacion__c> ListEnvioRepetidos {get;set;}
    public List<Retiro_Aprobacion__c> ListEnvioRepetidosP {get;set;}
    public List<Retiro_Aprobacion__c> ListEnvioRepetidosI {get;set;}
    public List<string> ListaEnvioRefere {get;set;}
    
    public date fecha2{get;set;} 
    public date fecha3{get;set;} 
    public void conciliaRetiros()
    {
        try{	
            classCRetiros claseEnvio = new classCRetiros();
            classCRetiros fcsd = controllerApiCRetiros.conciliaRetiros(fecha_retiro);
            ListPagosConciliados = new List<Retiro_Aprobacion__c>();
            ListPagosConciliadosP = new List<Retiro_Aprobacion__c>();
            ListPagosConciliadosI = new List<Retiro_Aprobacion__c>();
            
            system.debug('ListaConciliados: '+ ListPagosConciliados);
            system.debug('Respuestaaaaaaa: '+fcsd);
            
            if (fcsd.fechaSysdeRetiros != null)
            {
                fecha2=date.valueOf(fcsd.fechaSysdeRetiros.year()+'-'+fcsd.fechaSysdeRetiros.month()+'-'+fcsd.fechaSysdeRetiros.day());
                //fecha3=date.valueOf(fcsd.fechaSysdeRetiros.day()+'/'+fcsd.fechaSysdeRetiros.month()+'/'+fcsd.fechaSysdeRetiros.year());
                delete ([select Numero_Referencia__c, AprobacionM__c, Cuenta__c,Fecha_Sysde__c 
                  from Retiro_Aprobacion__c  
                  where AprobacionM__c = null]);
                
                if (fcsd.ListPagos != null) 
                {
                    mostrarTablaRetiros = true;
                }
                ListPagos = fcsd.ListPagos;
                Integer y = 1;
                for(Integer i = 0; i < ListPagos.size(); i++)
                {
                    ListPagos[i].index = y;
                    y++;
                }
                
                //patronales
                if (fcsd.ListPagosP != null) 
                {
                    mostrarTablaRetirosP = true;
                }
                
                ListPagosP = fcsd.ListPagosP;
                Integer z = 1;
                for(Integer i = 0; i < ListPagosP.size(); i++)
                {
                    ListPagosP[i].index = z;
                    z++;
                }
                
                
                ListEnvioRepetidosP = [select Numero_Referencia__c
                                      from Retiro_Aprobacion__c  where AprobacionM__c != 'Y' ];
                
                
                for(integer w=0; w<ListEnvioRepetidosP.size(); w++)
                {
                    integer pas=null;
                    for(integer i=0; i<ListPagosP.size(); i++)
                    {
                        
                        
                        if(ListPagosP[i].referencia == ListEnvioRepetidosP[w].Numero_Referencia__c)   
                        {
                            pas=i;
                        }
                        
                    }
                    
                    if(pas!=null){ListPagosP.remove(pas);}
                }   
                
                for(integer i=0; i<fcsd.ListPagosP.size(); i++)
                {
                    Retiro_Aprobacion__c p = new Retiro_Aprobacion__c();
                    p.Numero_Caso__c = string.valueOf(fcsd.ListPagosP[i].numeroCaso);
                    p.Numero_Referencia__c = fcsd.ListPagosP[i].referencia;
                    p.Cuenta__c =  fcsd.ListPagosP[i].codCuenta;
                    p.Nombre_Cliente__c = string.valueOf(fcsd.ListPagosP[i].nombreCliente);
                    p.moneda__c = fcsd.ListPagosP[i].moneda;
                    if (fcsd.ListPagosP[i].moneda == 'HNL')
                    {
                        p.Monto_HNL__c = string.valueOf(fcsd.ListPagosP[i].monTotal);
                        fcsd.ListPagosP[i].monHNL = fcsd.ListPagosP[i].monTotal;
                    }
                    else
                    {
                        p.Monto_USD__c = string.valueOf(fcsd.ListPagosP[i].monTotal);
                        fcsd.ListPagosP[i].monUSD = fcsd.ListPagosP[i].monTotal;
                    }
                    p.Monto_Salesforce__c =  string.valueOf(fcsd.ListPagosP[i].monRetirar);
                    p.Fecha_SalesForce__c =  date.valueOf(fcsd.ListPagosC[i].fecSYSDE.addHours(6));
                    p.Fecha_Sysde__c = date.valueOf(fcsd.ListPagosP[i].fecSYSDE.addHours(6)); 
                    p.tasa_seguridad_poblacional__c = string.valueOf(fcsd.ListPagosP[i].tsp);
                    p.transferencia_ACH__c = string.valueOf(fcsd.ListPagosP[i].ach);
                    p.cheque__c = string.valueOf(fcsd.ListPagosP[i].ck);
                    p.monto_total__c = string.valueOf(fcsd.ListPagosP[i].monTotal);
                    p.Forma_Pago__c = fcsd.ListPagosP[i].fPago;
                    p.cuenta_bancaria__c = fcsd.ListPagosP[i].cuentaBancaria;
                    p.cuenta_Destino__c = fcsd.ListPagosP[i].cuentaDestino;
                    p.banco_destino__c = fcsd.ListPagosP[i].bancoDestino;
                    p.tipo_cuenta__c = fcsd.ListPagosP[i].tCuenta;
                    p.Tipo_Pago__c = 'P';
                    
                    ListPagosConciliadosP.add(p);
                }     
                
                if (ListPagosConciliadosP.size() > 0)
                {
                    insert ListPagosConciliadosP;
                }
                //
                if (fcsd.ListPagosC != null) 
                {
                    mostrarTablaRetirosC = true;
                }
                ListPagosC = fcsd.ListPagosC;
                Integer x = 1;
                for(Integer i = 0; i < ListPagosC.size(); i++)
                {
                    ListPagosC[i].index = x;
                    x++;
                }
                ListEnvioRepetidos = [select Numero_Referencia__c
                                      from Retiro_Aprobacion__c where AprobacionM__c != 'Y' ];
                
                system.debug('Lista 1: '+ListEnvioRepetidos.size());
                system.debug('Lista 2: '+ListPagosC.size());
                for(integer w=0; w<ListEnvioRepetidos.size(); w++)
                {
                    integer pos=null;
                    for(integer i=0; i<ListPagosC.size(); i++)
                    {
                        if(ListPagosC[i].referencia == ListEnvioRepetidos[w].Numero_Referencia__c)   
                        {
                            pos=i;
                        }
                    }
                    
                    if(pos!=null){ListPagosC.remove(pos);}
                }   
                
                for(integer i=0; i<fcsd.ListPagosC.size(); i++)
                {
                    Retiro_Aprobacion__c p = new Retiro_Aprobacion__c();
                    p.Cuenta__c =  fcsd.ListPagosC[i].codCuenta;
                    p.Forma_Pago__c = fcsd.ListPagosC[i].fPago;
                    p.Fecha_SalesForce__c =  date.valueOf(fcsd.ListPagosC[i].fecSYSDE.addHours(6));
                    p.Fecha_Sysde__c = date.valueOf(fcsd.ListPagosC[i].fecMovimto.addHours(6)); 
                    p.Monto_Sysde__c = string.valueOf(fcsd.ListPagosC[i].monMovimto);
                    p.Monto_Salesforce__c =  string.valueOf(fcsd.ListPagosC[i].monRetirar);
                    p.Numero_Referencia__c = fcsd.ListPagosC[i].referencia;
                    p.Numero_Referencia__c = fcsd.ListPagosC[i].referencia;
                    p.cuenta_bancaria__c = fcsd.ListPagosC[i].cuentaBancaria;
                    p.cuenta_Destino__c = fcsd.ListPagosC[i].cuentaDestino;
                    p.monto_total__c = string.valueOf(fcsd.ListPagosC[i].monTotal);
                    p.banco_destino__c = fcsd.ListPagosC[i].bancoDestino;
                    p.tipo_cuenta__c = fcsd.ListPagosC[i].tCuenta;
                    p.moneda__c = fcsd.ListPagosC[i].moneda;
                    if (fcsd.ListPagosC[i].moneda == 'HNL')
                    {
                        p.Monto_HNL__c = string.valueOf(fcsd.ListPagosC[i].monTotal);
                        fcsd.ListPagosC[i].monHNL = fcsd.ListPagosC[i].monTotal;
                    }
                    else
                    {
                        p.Monto_USD__c = string.valueOf(fcsd.ListPagosC[i].monTotal);
                        fcsd.ListPagosC[i].monUSD = fcsd.ListPagosC[i].monTotal;
                    }
                    p.tasa_seguridad_poblacional__c = string.valueOf(fcsd.ListPagosC[i].tsp);
                    p.transferencia_ACH__c = string.valueOf(fcsd.ListPagosC[i].ach);
                    p.cheque__c = string.valueOf(fcsd.ListPagosC[i].ck);
                    p.Nombre_Cliente__c = string.valueOf(fcsd.ListPagosC[i].nombreCliente);
                    p.Numero_Caso__c = string.valueOf(fcsd.ListPagosC[i].numeroCaso);
                    p.Monto_Patronal_Cliente__c = string.valueOf(fcsd.ListPagosC[i].montoPatronalCte);
                    p.Tipo_Pago__c = 'R';
                    
                    ListPagosConciliados.add(p);
                }     
                
                if (ListPagosConciliados.size() > 0)
                {
                    insert ListPagosConciliados;
                }
                
                //Intereses
                if (fcsd.ListPagosI != null ) 
                {
                    mostrarTablaRetirosI = true;
                }
                ListPagosI = fcsd.ListPagosI;
                Integer ww = 1;
                for(Integer i = 0; i < ListPagosI.size(); i++)
                {
                    ListPagosI[i].index = ww;
                    ww++;
                }
                ListEnvioRepetidosI = [select Numero_Referencia__c
                                      from Retiro_Aprobacion__c where AprobacionM__c != 'Y' ];
                
                system.debug('Lista 1: '+ListEnvioRepetidosI.size());
                system.debug('Lista 2: '+ListPagosI.size());
                for(integer w=0; w<ListEnvioRepetidosI.size(); w++)
                {
                    integer pos=null;
                    for(integer i=0; i<ListPagosI.size(); i++)
                    {
                        if(ListPagosI[i].referencia == ListEnvioRepetidosI[w].Numero_Referencia__c)   
                        {
                            pos=i;
                        }
                    }
                    
                    if(pos!=null){ListPagosI.remove(pos);}
                }   
                
                for(integer i=0; i<fcsd.ListPagosI.size(); i++)
                {
                    Retiro_Aprobacion__c p = new Retiro_Aprobacion__c();
                    p.Cuenta__c =  fcsd.ListPagosI[i].codCuenta;
                    p.Forma_Pago__c = fcsd.ListPagosI[i].fPago;
                    p.Fecha_SalesForce__c =  date.valueOf(fcsd.ListPagosI[i].fecSYSDE.addHours(6));
                    p.Fecha_Sysde__c = date.valueOf(fcsd.ListPagosI[i].fecMovimto.addHours(6)); 
                    p.Monto_Sysde__c = string.valueOf(fcsd.ListPagosI[i].monMovimto);
                    p.Monto_Salesforce__c =  string.valueOf(fcsd.ListPagosI[i].monRetirar);
                    p.Numero_Referencia__c = fcsd.ListPagosI[i].referencia;
                    p.Numero_Referencia__c = fcsd.ListPagosI[i].referencia;
                    p.cuenta_bancaria__c = fcsd.ListPagosI[i].cuentaBancaria;
                    p.cuenta_Destino__c = fcsd.ListPagosI[i].cuentaDestino;
                    p.monto_total__c = string.valueOf(fcsd.ListPagosI[i].monTotal);
                    p.banco_destino__c = fcsd.ListPagosI[i].bancoDestino;
                    p.tipo_cuenta__c = fcsd.ListPagosI[i].tCuenta;
                    p.moneda__c = fcsd.ListPagosI[i].moneda;
                    if (fcsd.ListPagosI[i].moneda == 'HNL')
                    {
                        p.Monto_HNL__c = string.valueOf(fcsd.ListPagosI[i].monTotal);
                    }
                    else
                    {
                        p.Monto_USD__c = string.valueOf(fcsd.ListPagosI[i].monTotal);
                    }
                    p.tasa_seguridad_poblacional__c = string.valueOf(fcsd.ListPagosI[i].tsp);
                    p.transferencia_ACH__c = string.valueOf(fcsd.ListPagosI[i].ach);
                    p.cheque__c = string.valueOf(fcsd.ListPagosI[i].ck);
                    p.Nombre_Cliente__c = string.valueOf(fcsd.ListPagosI[i].nombreCliente);
                    p.Numero_Caso__c = string.valueOf(fcsd.ListPagosI[i].numeroCaso);
                    p.Monto_Patronal_Cliente__c = string.valueOf(fcsd.ListPagosI[i].montoPatronalCte);
                    p.Tipo_Pago__c = 'I';
                    
                    ListPagosConciliadosI.add(p);
                }     
                
                if (ListPagosConciliadosI.size() > 0)
                {
                    insert ListPagosConciliadosI;
                }
                
            }
            else
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Retiros no Encontrados'));	    
            }  
            //salirCuenta();
            
        }
        Catch(Exception e){
            system.debug('error: '+ e.getMessage()+', linea: '+ e.getLineNumber());
        }
    }
    
    ///Envio aprobacion 
    public void envioAprobacion()
    {
        try{
            //SYSTEM.debug('KIKITO: '+ Num_CodReferencia);
            Retiro_Aprobacion__c ne = [select Numero_Referencia__c, Nombre_Cliente__c
                                       from Retiro_Aprobacion__c limit 1];
            
            if (ne.Numero_Referencia__c == Num_CodReferencia )
            {
                integer pos;
                for(integer i=0; i<ListPagosC.size(); i++)
                {
                    
                    if(ListPagosC[i].referencia == Num_CodReferencia)   
                    {
                        pos=i;
                    }
                    
                }
                ListPagosC.remove(pos);
            }
            else
            {
                list<Retiro_Aprobacion__c> modifi = new list<Retiro_Aprobacion__c> ();
                modifi = [select Numero_Referencia__c, Nombre_Cliente__c, AprobacionM__c,id from Retiro_Aprobacion__c where Numero_Referencia__c =: Num_CodReferencia];
                
                if(modifi.size()>0){modifi[0].AprobacionM__c = 'S';}
                update modifi;
                
                integer pos;
                for(integer i=0; i<ListPagosC.size(); i++)
                {
                    
                    if(ListPagosC[i].referencia == Num_CodReferencia)   
                    {
                        pos=i;
                    }
                    
                }
                
                ListPagosC.remove(pos);                
            }
            
        }catch(Exception ex){
            
        }        
    }
    
    public void envioAprobacionP()
    {
        try{
            //SYSTEM.debug('KIKITO: '+ Num_CodReferencia);
            Retiro_Aprobacion__c ne = [select Numero_Referencia__c, Nombre_Cliente__c
                                       from Retiro_Aprobacion__c limit 1];
            
            if (ne.Numero_Referencia__c == Num_CodReferencia)
            {
                
                integer pas;
                for(integer i=0; i<ListPagosP.size(); i++)
                {
                    
                    if(ListPagosP[i].referencia == Num_CodReferencia)   
                    {
                        pas=i;
                    }
                    
                }
                ListPagosP.remove(pas);
            }
            else
            {
                list<Retiro_Aprobacion__c> modifi = new list<Retiro_Aprobacion__c> ();
                modifi = [select Numero_Referencia__c, Nombre_Cliente__c, AprobacionM__c,id from Retiro_Aprobacion__c where Numero_Referencia__c =: Num_CodReferencia];
                
                if(modifi.size()>0){modifi[0].AprobacionM__c = 'S';}
                update modifi;
                
                integer pas;
                for(integer i=0; i<ListPagosP.size(); i++)
                {
                    
                    if(ListPagosP[i].referencia == Num_CodReferencia)   
                    {
                        pas=i;
                    }
                    
                }
                
                ListPagosP.remove(pas);
            }
            
        }catch(Exception ex){
            
        } 
    }
    
    public void envioAprobacionI()
    {
        try{
            //SYSTEM.debug('KIKITO: '+ Num_CodReferencia);
            Retiro_Aprobacion__c ne = [select Numero_Referencia__c, Nombre_Cliente__c
                                       from Retiro_Aprobacion__c limit 1];
            
            if (ne.Numero_Referencia__c == Num_CodReferencia)
            {
                
                integer pas;
                for(integer i=0; i<ListPagosI.size(); i++)
                {
                    
                    if(ListPagosI[i].referencia == Num_CodReferencia)   
                    {
                        pas=i;
                    }
                    
                }
                ListPagosI.remove(pas);
            }
            else
            {
                list<Retiro_Aprobacion__c> modifi = new list<Retiro_Aprobacion__c> ();
                modifi = [select Numero_Referencia__c, Nombre_Cliente__c, AprobacionM__c,id from Retiro_Aprobacion__c where Numero_Referencia__c =: Num_CodReferencia];
                
                if(modifi.size()>0){modifi[0].AprobacionM__c = 'S';}
                update modifi;
                
                integer pas;
                for(integer i=0; i<ListPagosI.size(); i++)
                {
                    
                    if(ListPagosI[i].referencia == Num_CodReferencia)   
                    {
                        pas=i;
                    }
                    
                }
                
                ListPagosI.remove(pas);
            }
            
        }catch(Exception ex){
            
        } 
    }
    
    //Borrar Registros 
    public void Eliminar()
    {
        delete ([select id, Numero_Referencia__c, AprobacionM__c, Cuenta__c,Fecha_Sysde__c 
                 from Retiro_Aprobacion__c ]);
    }
    
    //Enviar toda la lista
    public void enviarListaTotal()
    {
        try{
            ListEnvioRepetidos = [select Numero_Referencia__c
                                  from Retiro_Aprobacion__c where AprobacionM__c = null and Tipo_Pago__c = 'R'];
            list<Retiro_Aprobacion__c> pa = new list<Retiro_Aprobacion__c>();
            list<string> listNumeroReferencia = new list<string>();
            
            for(integer k=0; k<ListPagosC.size(); k++)
            {
                listNumeroReferencia.add(ListPagosC[k].referencia );
            }
            pa = [select Numero_Referencia__c, AprobacionM__c,id 
                  from Retiro_Aprobacion__c where Numero_Referencia__c in: listNumeroReferencia ];
            for(integer k=0; k<ListPagosC.size(); k++)
            {
                for(integer a=0; a<pa.size(); a++)
                {
                    if(pa[a].Numero_Referencia__c == ListPagosC[k].referencia)
                    {
                        pa[a].AprobacionM__c = 'S';
                    }
                }
            }
            update pa;
            ListPagosC.clear();
        }catch(Exception ex){
            system.debug('error: '+ ex.getMessage()+', linea: '+ ex.getLineNumber());
        }     
    }
    //Enviar toda la lista
    public void enviarListaTotalP()
    {
        try{
            ListEnvioRepetidosP = [select Numero_Referencia__c
                                  from Retiro_Aprobacion__c where AprobacionM__c = null and Tipo_Pago__c = 'P' ];
            list<Retiro_Aprobacion__c> pao = new list<Retiro_Aprobacion__c>();
            list<string> listNumeroReferencia = new list<string>();
            
            for(integer k=0; k<ListPagosP.size(); k++)
            {
                listNumeroReferencia.add(ListPagosP[k].referencia);
            }
            pao = [select Numero_Referencia__c, AprobacionM__c,id 
                  from Retiro_Aprobacion__c where Numero_Referencia__c in: listNumeroReferencia ];
            for(integer k=0; k<ListPagosP.size(); k++)
            {
                for(integer w=0; w<ListEnvioRepetidosP.size(); w++)
                {
                    if(pao[w].Numero_Referencia__c == ListPagosP[k].referencia)
                    {
                        pao[w].AprobacionM__c = 'S';
                    }
                }  
            }
            update pao;
            ListPagosP.clear();
        }catch(Exception ex){
            system.debug('error: '+ ex.getMessage()+', linea: '+ ex.getLineNumber());
        }     
    }
    
    public void enviarListaTotalI()
    {
        try{
            ListEnvioRepetidosI = [select Numero_Referencia__c
                                  from Retiro_Aprobacion__c where AprobacionM__c = null and Tipo_Pago__c = 'I'];
            
            list<Retiro_Aprobacion__c> pao = new list<Retiro_Aprobacion__c>();
            list<string> listNumeroReferencia = new list<string>();
            
            
            for(integer k=0; k<ListPagosI.size(); k++)
            {
                listNumeroReferencia.add(ListPagosI[k].referencia);
            }
            pao = [select Numero_Referencia__c, AprobacionM__c,id 
                  from Retiro_Aprobacion__c where Numero_Referencia__c in: listNumeroReferencia ];
            
            for(integer k=0; k<ListPagosI.size(); k++)
            {
                for(integer w=0; w<ListEnvioRepetidosI.size(); w++)
                {
                    if(pao[w].Numero_Referencia__c == ListPagosI[k].referencia)
                    {
                        pao[w].AprobacionM__c = 'S';
                    }
                } 
            }
            update pao;
            ListPagosI.clear();
        }
    	catch(Exception e)
        {
            system.debug('error: '+ e.getMessage()+', linea: '+ e.getLineNumber());
        }     
    }
}