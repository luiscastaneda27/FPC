public class controllerCRetiros {
    public date fecha_retiro {get;set;}
    public datetime fechaSysdeRetiros {get;set;}
    public datetime fechaMostrar {get;set;}
    public boolean mostrarTablaRetiros {get;Set;}
    public boolean mostrarTablaRetirosC {get;Set;}
    public boolean mostrarTablaRetirosP {get;Set;}
    public boolean mostrarTablaRetirosI {get;Set;}
    public boolean mostrarTablaRetirosB {get;Set;}
    public cuadreRetiros retirosSf{get;set;}
    public List<cuadreRetiros> ListPagos {get;set;}
    public List<cuadreRetirosC> ListPagosC {get;set;}
    public List<cuadreRetirosP> ListPagosP {get;set;}
    public List<cuadreRetirosI> ListPagosI {get;set;}
    public List<cuadreRetirosB> ListPagosB {get;set;}
    public string fecha {get;set;}
    public string Num_CodReferencia {get;set;}
    public string Id {get;set;}
    public List<Retiro_Aprobacion__c> ListPagosConciliados {get;set;}
    public List<Retiro_Aprobacion__c> ListPagosConciliadosP {get;set;}
    public List<Retiro_Aprobacion__c> ListPagosConciliadosI {get;set;}
    public List<Retiro_Aprobacion__c> ListPagosConciliadosB {get;set;}
    public List<Retiro_Aprobacion__c> ListEnvioTotal {get;set;}
    public List<Retiro_Aprobacion__c> ListEnvioRepetidos {get;set;}
    public List<Retiro_Aprobacion__c> ListEnvioRepetidosP {get;set;}
    public List<Retiro_Aprobacion__c> ListEnvioRepetidosI {get;set;}
    public List<Retiro_Aprobacion__c> ListEnvioRepetidosB {get;set;}
    public List<string> ListaEnvioRefere {get;set;}
    
    public date fecha2{get;set;} 
    public date fecha3{get;set;} 
    public void conciliaRetiros()
    {
        try{	
            classCRetiros claseEnvio = new classCRetiros();
            claseEnvio.fecha = fecha_retiro;
            classCRetiros fcsd = controllerApiCRetiros.guardarCliente(fecha_retiro);
            //classCRetiros fcsd = controllerApiCRetiros.conciliaRetiros(fecha_retiro);
            ListPagosConciliados = new List<Retiro_Aprobacion__c>();
            ListPagosConciliadosP = new List<Retiro_Aprobacion__c>();
            ListPagosConciliadosI = new List<Retiro_Aprobacion__c>();
            ListPagosConciliadosB = new List<Retiro_Aprobacion__c>();        
                
            list<Case> varCaso = [Select id, Fecha_Sysde__c, CaseNumber, Account.name From Case where Fecha_Sysde__c =:fecha_retiro];

            if (fcsd.ListPagos.size() != 0 || fcsd.ListPagosC.size() != 0  || fcsd.ListPagosB.size() != 0  || fcsd.ListPagosI.size() != 0  || fcsd.ListPagosP.size() != 0  || varCaso.size() != 0 )
            {
               delete ([select Numero_Referencia__c, AprobacionM__c, Cuenta__c,Fecha_Sysde__c 
                  from Retiro_Aprobacion__c  
                  where AprobacionM__c = null]);
                
                String varCasoSysde; 
                map<String, Detalle_caso__c>  mapCase = new map<String, Detalle_caso__c>();
                list<String> listCasos = new list<String>();
                for(Integer i = 0; i < fcsd.ListPagos.size(); i++)
                {
                    if(fcsd.ListPagos[i].numeroCaso <= 999999)
                    {
                        varCasoSysde = '00'+ string.valueOf(fcsd.ListPagos[i].numeroCaso);
                        
                    }else if(fcsd.ListPagos[i].numeroCaso >= 1000000 || fcsd.ListPagos[i].numeroCaso <= 9999999 )
                    {
                        varCasoSysde = '0'+ string.valueOf(fcsd.ListPagos[i].numeroCaso);
                        
                    }else{
                        varCasoSysde = string.valueOf(fcsd.ListPagos[i].numeroCaso);
                        
                    }
                    System.debug('varCasoSysde. ' + varCasoSysde);
                    listCasos.add(varCasoSysde);
                }
                
                list<Detalle_caso__c> recListC =[select id, Saldo_retirar__c, Porcentaje_Saldo_Patronal__c, Porcentaje_Saldo_Patronal_Ext__c, Cabeza_retiro__c, caso__r.CaseNumber from Detalle_caso__c where Cabeza_retiro__c = true and caso__r.CaseNumber in :listCasos];        
                for (Detalle_caso__c item:recListC){
                    System.debug('item sera ' + item.caso__r.CaseNumber);
                    mapCase.put(item.caso__r.CaseNumber,item); 
                } 
                
                if (fcsd.ListPagos != null) 
                {
                    mostrarTablaRetiros = true;
                }
                
                ListPagos = fcsd.ListPagos;
               
                system.debug('lo que esta en la lista: '+varCaso);
                if (varCaso != null){
                    for(integer i=0; i<varCaso.size(); i++)
                    { 
                        retirosSf = new cuadreRetiros();
                        retirosSf.referencia = 'No registrado en SYSDE';
                        retirosSf.nombreCliente = varCaso[i].Account.name;
                        retirosSf.numeroCaso = decimal.valueOf(varCaso[i].CaseNumber);
                        retirosSf.codCuenta = '-';
                        retirosSf.monMovimto = 0;
                        retirosSf.monRetirar = 0;
                        retirosSf.fPago = '-';
                        retirosSf.fecSYSDE = '-';
                        retirosSf.comparacion = '-';
                        retirosSf.comparaNeto = '-';
                        retirosSf.comparaFecha = 0;
                        
                        ListPagos.add(retirosSf);
                    }
                }
                
                Integer y = 1;
               // String varCasoSysde; 
                for(Integer i = 0; i < ListPagos.size(); i++)
                {
                    ListPagos[i].index = y;
                    y++;
                    System.debug('numeroCasoListaSysde :' +  String.valueOf(ListPagos[i].numeroCaso));
                    if(fcsd.ListPagos[i].numeroCaso <= 999999)
                    {
                        varCasoSysde = '00'+ string.valueOf(fcsd.ListPagos[i].numeroCaso);
                        
                    }else if(fcsd.ListPagos[i].numeroCaso >= 1000000 || fcsd.ListPagos[i].numeroCaso <= 9999999 )
                    {
                        varCasoSysde = '0'+ string.valueOf(fcsd.ListPagos[i].numeroCaso);
                        
                    }else{
                        varCasoSysde = string.valueOf(fcsd.ListPagos[i].numeroCaso);
                        
                    }
                    Detalle_caso__c saldoPatronal = mapCase.get(String.valueOf(varCasoSysde));
                 
                    if(saldoPatronal!= null)
                    {
                    ListPagos[i].porcentaje = saldoPatronal.Porcentaje_Saldo_Patronal__c != null ?  saldoPatronal.Porcentaje_Saldo_Patronal__c : 0;
                    }else{
                         ListPagos[i].porcentaje = 0;
                    }
                    
                    if (fcsd.ListPagos[i].comparacion != '0'){
                        fcsd.ListPagos[i].comparacion = 'No';
                    }
                    else{
                        fcsd.ListPagos[i].comparacion = 'Si';
                    }
                    if (fcsd.ListPagos[i].comparaNeto != '0'){
                        fcsd.ListPagos[i].comparaNeto = 'No';
                    }
                    else{
                        fcsd.ListPagos[i].comparaNeto = 'Si';
                    }
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
                    //"30-JAN-20"
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
                    p.Fecha_SalesForce__c = convertStringDate(fcsd.ListPagosP[i].fecSYSDE);
                    system.debug('como viene la fecha: '+(fcsd.ListPagosP[i].fecSYSDE));
                    system.debug('como convierte la fecha: '+convertStringDate(string.valueOf(fcsd.ListPagosP[i].fecSYSDE)));
                    fechaMostrar = date.valueOf(convertStringDate(fcsd.ListPagosP[i].fecSYSDE));
                    p.Fecha_SalesForce__c =  date.valueOf(convertStringDate(fcsd.ListPagosP[i].fecSYSDE));
                    p.Fecha_Sysde__c = date.valueOf(convertStringDate(fcsd.ListPagosP[i].fecSYSDE)); 
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
                //Conciliados
                String varCasoSysdeC; 
                map<String, Detalle_caso__c>  mapCaseC = new map<String, Detalle_caso__c>();
                list<String> listCasosC = new list<String>();
                for(Integer i = 0; i < fcsd.ListPagosC.size(); i++)
                {
                    if(fcsd.ListPagosC[i].numeroCaso <= 999999)
                    {
                        varCasoSysdeC = '00'+ string.valueOf(fcsd.ListPagosC[i].numeroCaso);
                        
                    }else if(fcsd.ListPagosC[i].numeroCaso >= 1000000 || fcsd.ListPagosC[i].numeroCaso <= 9999999 )
                    {
                        varCasoSysdeC = '0'+ string.valueOf(fcsd.ListPagosC[i].numeroCaso);
      
                    }else{
                        varCasoSysdeC = string.valueOf(fcsd.ListPagosC[i].numeroCaso);
        
                    }
                    System.debug('varCasoSysdeC. ' + varCasoSysdeC);
                    listCasosC.add(varCasoSysdeC);
                }
                
                list<Detalle_caso__c> recListCC =[select id, Saldo_retirar__c, Porcentaje_Saldo_Patronal__c, Porcentaje_Saldo_Patronal_Ext__c, Cabeza_retiro__c, caso__r.CaseNumber from Detalle_caso__c where Cabeza_retiro__c = true and caso__r.CaseNumber in :listCasosC];        
                for (Detalle_caso__c item:recListCC){
                    System.debug('item sera ' + item.caso__r.CaseNumber);
                    mapCaseC.put(item.caso__r.CaseNumber,item); 
                } 
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
                    System.debug('numeroCasoListaSysde :' +  String.valueOf(ListPagosC[i].numeroCaso));
                    if(fcsd.ListPagosC[i].numeroCaso <= 999999)
                    {
                        varCasoSysdeC = '00'+ string.valueOf(fcsd.ListPagosC[i].numeroCaso);
                        
                    }else if(fcsd.ListPagos[i].numeroCaso >= 1000000 || fcsd.ListPagosC[i].numeroCaso <= 9999999 )
                    {
                        varCasoSysdeC = '0'+ string.valueOf(fcsd.ListPagosC[i].numeroCaso);
                        
                    }else{
                        varCasoSysdeC = string.valueOf(fcsd.ListPagosC[i].numeroCaso);
                        
                    }
                    Detalle_caso__c saldoPatronalC = mapCaseC.get(String.valueOf(varCasoSysdeC));
                 
                    if(saldoPatronalC!= null)
                    {
                    ListPagosC[i].porcentaje = saldoPatronalC.Porcentaje_Saldo_Patronal__c != null ?  saldoPatronalC.Porcentaje_Saldo_Patronal__c : 0;
                    }else{
                         ListPagosC[i].porcentaje = 0;
                    }
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
                    p.Fecha_SalesForce__c =  date.valueOf(convertStringDate(fcsd.ListPagosC[i].fecMovimto));
                    p.Fecha_Sysde__c = date.valueOf(convertStringDate(fcsd.ListPagosC[i].fecSYSDE));
                    fechaMostrar = date.valueOf(convertStringDate(fcsd.ListPagosC[i].fecSYSDE));
                    //p.Fecha_SalesForce__c =  date.valueOf(fcsd.ListPagosC[i].fecSYSDE.addHours(6));
                    //p.Fecha_Sysde__c = date.valueOf(fcsd.ListPagosC[i].fecMovimto.addHours(6)); 
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
                //Beneficiarios y Terceros
                String varCasoSysdeB; 
                map<String, Detalle_caso__c>  mapCaseB = new map<String, Detalle_caso__c>();
                list<String> listCasosB = new list<String>();
                for(Integer i = 0; i < fcsd.ListPagosB.size(); i++)
                {
                    if(fcsd.ListPagosB[i].numeroCaso <= 999999)
                    {
                        varCasoSysdeB = '00'+ string.valueOf(fcsd.ListPagosB[i].numeroCaso);
                        
                    }else if(fcsd.ListPagosB[i].numeroCaso >= 1000000 || fcsd.ListPagosB[i].numeroCaso <= 9999999 )
                    {
                        varCasoSysdeB = '0'+ string.valueOf(fcsd.ListPagosB[i].numeroCaso);
      
                    }else{
                        varCasoSysdeB = string.valueOf(fcsd.ListPagosB[i].numeroCaso);
        
                    }
                    System.debug('varCasoSysdeB. ' + varCasoSysdeB);
                    listCasosB.add(varCasoSysdeB);
                }
                
                list<Detalle_caso__c> recListCB =[select id, Saldo_retirar__c, Porcentaje_Saldo_Patronal__c, Porcentaje_Saldo_Patronal_Ext__c, Cabeza_retiro__c, caso__r.CaseNumber from Detalle_caso__c where Cabeza_retiro__c = true and caso__r.CaseNumber in :listCasosB];        
                for (Detalle_caso__c item:recListCB){
                    System.debug('item sera ' + item.caso__r.CaseNumber);
                    mapCaseB.put(item.caso__r.CaseNumber,item); 
                } 
                if (fcsd.ListPagosB != null) 
                {
                    mostrarTablaRetirosB = true;
                }
                ListPagosB = fcsd.ListPagosB;
                Integer xb = 1;
                for(Integer i = 0; i < ListPagosB.size(); i++)
                {
                    ListPagosB[i].index = xb;
                    xb++;
                    System.debug('numeroCasoListaSysde :' +  String.valueOf(ListPagosB[i].numeroCaso));
                    if(fcsd.ListPagosB[i].numeroCaso <= 999999)
                    {
                        varCasoSysdeB = '00'+ string.valueOf(fcsd.ListPagosB[i].numeroCaso);
                        
                    }else if(fcsd.ListPagosB[i].numeroCaso >= 1000000 || fcsd.ListPagosB[i].numeroCaso <= 9999999 )
                    {
                        varCasoSysdeB = '0'+ string.valueOf(fcsd.ListPagosB[i].numeroCaso);
                        
                    }else{
                        varCasoSysdeB = string.valueOf(fcsd.ListPagosB[i].numeroCaso);
                        
                    }
                    Detalle_caso__c saldoPatronalB = mapCaseB.get(String.valueOf(varCasoSysdeC));
                 
                    if(saldoPatronalB!= null)
                    {
                    ListPagosB[i].porcentaje = saldoPatronalB.Porcentaje_Saldo_Patronal__c != null ?  saldoPatronalB.Porcentaje_Saldo_Patronal__c : 0;
                    }else{
                         ListPagosB[i].porcentaje = 0;
                    }
                }
                ListEnvioRepetidosB = [select Numero_Referencia__c
                                      from Retiro_Aprobacion__c where AprobacionM__c != 'Y' ];
                
                system.debug('Lista 1: '+ListEnvioRepetidosB.size());
                system.debug('Lista 2: '+ListPagosB.size());
                for(integer w=0; w<ListEnvioRepetidosB.size(); w++)
                {
                    integer pos=null;
                    for(integer i=0; i<ListPagosB.size(); i++)
                    {
                        if(ListPagosB[i].referencia == ListEnvioRepetidosB[w].Numero_Referencia__c)   
                        {
                            pos=i;
                        }
                    }
                    
                    if(pos!=null){ListPagosB.remove(pos);}
                }   
                
                for(integer i=0; i<fcsd.ListPagosB.size(); i++)
                {
                    Retiro_Aprobacion__c p = new Retiro_Aprobacion__c();
                    p.Cuenta__c =  fcsd.ListPagosB[i].codCuenta;
                    p.Forma_Pago__c = fcsd.ListPagosB[i].fPago;
                    p.Fecha_SalesForce__c =  date.valueOf(convertStringDate(fcsd.ListPagosB[i].fecMovimto));
                    p.Fecha_Sysde__c = date.valueOf(convertStringDate(fcsd.ListPagosB[i].fecSYSDE));
                    fechaMostrar = date.valueOf(convertStringDate(fcsd.ListPagosB[i].fecSYSDE));
                    //p.Fecha_SalesForce__c =  date.valueOf(fcsd.ListPagosC[i].fecSYSDE.addHours(6));
                    //p.Fecha_Sysde__c = date.valueOf(fcsd.ListPagosC[i].fecMovimto.addHours(6)); 
                    p.Monto_Sysde__c = string.valueOf(fcsd.ListPagosB[i].monMovimto);
                    p.Monto_Salesforce__c =  string.valueOf(fcsd.ListPagosB[i].monRetirar);
                    p.Numero_Referencia__c = fcsd.ListPagosB[i].referencia;
                    p.Numero_Referencia__c = fcsd.ListPagosB[i].referencia;
                    p.cuenta_bancaria__c = fcsd.ListPagosB[i].cuentaBancaria;
                    p.cuenta_Destino__c = fcsd.ListPagosB[i].cuentaDestino;
                    p.monto_total__c = string.valueOf(fcsd.ListPagosB[i].monTotal);
                    p.banco_destino__c = fcsd.ListPagosB[i].bancoDestino;
                    p.tipo_cuenta__c = fcsd.ListPagosB[i].tCuenta;
                    p.moneda__c = fcsd.ListPagosB[i].moneda;
                    if (fcsd.ListPagosB[i].moneda == 'HNL')
                    {
                        p.Monto_HNL__c = string.valueOf(fcsd.ListPagosB[i].monTotal);
                        fcsd.ListPagosB[i].monHNL = fcsd.ListPagosB[i].monTotal;
                    }
                    else
                    {
                        p.Monto_USD__c = string.valueOf(fcsd.ListPagosB[i].monTotal);
                        fcsd.ListPagosB[i].monUSD = fcsd.ListPagosB[i].monTotal;
                    }
                    p.tasa_seguridad_poblacional__c = string.valueOf(fcsd.ListPagosB[i].tsp);
                    p.transferencia_ACH__c = string.valueOf(fcsd.ListPagosB[i].ach);
                    p.cheque__c = string.valueOf(fcsd.ListPagosB[i].ck);
                    p.Nombre_Cliente__c = string.valueOf(fcsd.ListPagosB[i].nombreCliente);
                    p.Nombre_Propietario__c = string.valueOf(fcsd.ListPagosB[i].nombrePropietario);
                    p.Numero_Caso__c = string.valueOf(fcsd.ListPagosB[i].numeroCaso);
                    p.Monto_Patronal_Cliente__c = string.valueOf(fcsd.ListPagosB[i].montoPatronalCte);
                    p.Tipo_Pago__c = 'B';
                    
                    ListPagosConciliadosB.add(p);
                }     
                
                if (ListPagosConciliadosB.size() > 0)
                {
                    insert ListPagosConciliadosB;
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
                    p.Fecha_SalesForce__c =  date.valueOf(convertStringDate(fcsd.ListPagosI[i].fecMovimto));
                    p.Fecha_Sysde__c = date.valueOf(convertStringDate(fcsd.ListPagosI[i].fecSYSDE));
                    fechaMostrar = date.valueOf(convertStringDate(fcsd.ListPagosI[i].fecSYSDE));
                    //p.Fecha_SalesForce__c =  date.valueOf(fcsd.ListPagosI[i].fecSYSDE.addHours(6));
                    //p.Fecha_Sysde__c = date.valueOf(fcsd.ListPagosI[i].fecMovimto.addHours(6)); 
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
    
    public static Date convertStringDate(String stringDate){
        try{
            list<String> separador = stringDate.split('-');
            Date fecha = date.valueOf(dateTime.newInstance(integer.valueOf(separador[2])+ (integer.valueOf(separador[2]) > (date.today().year() - 2000) ? 1900 :2000), MesLetras(separador[1]), integer.valueOf(separador[0])));
            return fecha;
        }catch(Exception ex){
            return convertStringDateOther(stringDate);
        }
        
    }
    public static Date convertStringDateOther(String stringDate){
        try{
            list<String> separador = stringDate.split('/');
            Date fecha = date.valueOf(dateTime.newInstance(integer.valueOf(separador[2])+ (integer.valueOf(separador[2]) > (date.today().year() - 2000) ? 1900 :2000),integer.valueOf(separador[1]) , integer.valueOf(separador[0])));
            return fecha;
        }catch(Exception ex){
            return null;
        }
        
    }
    public static integer MesLetras (string mes){
        integer respuesta ;
        try{
            if(mes=='JAN' || mes=='ENE'){respuesta = 1;}
            if(mes=='FEB'){respuesta = 2;}
            if(mes=='MAR'){respuesta = 3;}
            if(mes=='APR' || mes=='ABR'){respuesta = 4;}
            if(mes=='MAY' ){respuesta = 5;}
            if(mes=='JUN' ){respuesta = 6;}
            if(mes=='JUL' ){respuesta = 7;}
            if(mes=='AUG' || mes=='AGO'){respuesta = 8;}
            if(mes=='SEP' ){respuesta = 9;}
            if(mes=='OCT' ){respuesta = 10;}
            if(mes=='NOV' ){respuesta = 11;}
            if(mes=='DEC' || mes=='DIC'){respuesta = 12;}
            
        }catch(exception ex){
            system.debug('error: '+ex.getMessage()+ 'Error: '+ex.getLineNumber()+', parametro: '+mes);
        }
        return respuesta;
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
    
    public void envioAprobacionB()
    {
        try{
            Retiro_Aprobacion__c ne = [select Numero_Referencia__c, Nombre_Cliente__c
                                       from Retiro_Aprobacion__c limit 1];
            
            if (ne.Numero_Referencia__c == Num_CodReferencia)
            {
                
                integer pas;
                for(integer i=0; i<ListPagosB.size(); i++)
                {
                    
                    if(ListPagosB[i].referencia == Num_CodReferencia)   
                    {
                        pas=i;
                    }
                    
                }
                ListPagosB.remove(pas);
            }
            else
            {
                list<Retiro_Aprobacion__c> modifi = new list<Retiro_Aprobacion__c> ();
                modifi = [select Numero_Referencia__c, Nombre_Cliente__c, AprobacionM__c,id from Retiro_Aprobacion__c where Numero_Referencia__c =: Num_CodReferencia];
                
                if(modifi.size()>0){modifi[0].AprobacionM__c = 'S';}
                update modifi;
                
                integer pas;
                for(integer i=0; i<ListPagosB.size(); i++)
                {
                    
                    if(ListPagosB[i].referencia == Num_CodReferencia)   
                    {
                        pas=i;
                    }
                    
                }
                
                ListPagosB.remove(pas);
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
    
    public void enviarListaTotalB()
    {
        try{
            ListEnvioRepetidosB = [select Numero_Referencia__c
                                  from Retiro_Aprobacion__c where AprobacionM__c = null and Tipo_Pago__c = 'B'];
            
            list<Retiro_Aprobacion__c> pao = new list<Retiro_Aprobacion__c>();
            list<string> listNumeroReferencia = new list<string>();
            
            
            for(integer k=0; k<ListPagosB.size(); k++)
            {
                listNumeroReferencia.add(ListPagosB[k].referencia);
            }
            pao = [select Numero_Referencia__c, AprobacionM__c,id 
                  from Retiro_Aprobacion__c where Numero_Referencia__c in: listNumeroReferencia ];
            
            for(integer k=0; k<ListPagosB.size(); k++)
            {
                for(integer w=0; w<ListEnvioRepetidosB.size(); w++)
                {
                    if(pao[w].Numero_Referencia__c == ListPagosB[k].referencia)
                    {
                        pao[w].AprobacionM__c = 'S';
                    }
                } 
            }
            update pao;
            ListPagosB.clear();
        }
    	catch(Exception e)
        {
            system.debug('error: '+ e.getMessage()+', linea: '+ e.getLineNumber());
        }     
    }
}