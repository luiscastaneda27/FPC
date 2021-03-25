public class ActualizarSaldosCuentas {
	
    //@future(callout=true)
    public static void ActualizarSaldos(string idCaso, string cuenta, string estadocaso)
    {
        /*system.debug(idcaso);
        system.debug(cuenta);
        system.debug(estadocaso);
        if(estadocaso=='Nuevo' || estadocaso=='Pendiente segunda aprobación' ||
            estadocaso=='Pendiente de aprobación' || estadocaso=='Rechazado' ||
           estadocaso=='Devuelto')
          {
             Http http = new Http();
            HttpRequest request = new HttpRequest();
            String url = claseUtil.urlSysde('Test');
            request.setEndpoint(url + 'api/saldos/' + cuenta);
            request.setMethod('GET');
            request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            request.setTimeout(120000);
            getSaldoCuenta saldos = new getSaldoCuenta();
            try{
                HttpResponse response = http.send(request);
                if (true) {
                    System.debug(response.getBody());
                    saldos = (getSaldoCuenta)System.JSON.deserialize(response.getBody(), getSaldoCuenta.class);
                    list<Detalle_caso__c> cuentasCaso=new list<Detalle_caso__c>();
                    Detalle_caso__c detallecaso = new Detalle_caso__c();
                    cuentasCaso = [Select id,  Cuenta__c, Tipo_Saldo__c,Cobrar_comision__c, 
                                     Detalle_Cuenta_colectiva__c, Cliente_sigue_Laborando__c,Permitir_Retiro_Saldos_Patronales__c,
                                    Comision_Retiro_Anticipado__c, Monto_retirar__c,Tipo_retiro__c,Forma_Retiro__c,Tipo_Cuenta__c,
                                    currencyIsoCode,Tipo_transaccion__c,Subtipo_transaccion__c,Comision_por_aporte__c,Monto_reversar__c,
                                    Porcentaje_comision__c,Saldo_retirar__c,
                                    Cabeza_Retiro__c, Comision_retiro_anticipado_empresa__c, Cobrar_empleado_sigue_laborando__c,
                                    Cobro_ACH__c, Cobro_Cheque__c, Cobro_TSP__c,Monto_cheque__c,Monto_TSP__c, Monto_ACH__c,
                                    Monto_Saldo__c,Saldo_Total__c, Monto_comision_saldo__c,
                                    Monto_comision_aporte__c,Pago_terceros__c,Cuenta_destino__c,Propietario_cuenta__c,
                                    Monto_total_retirar__c,Monto_bruto_retirar__c,Monto_total_comisiones_recargos__c,Total_exonerado__c,
                                    Monto_comision_retiro__c, Exonerado__c, descripcion__c, monto__C
                                 From Detalle_caso__c Where Caso__c =: idcaso order by Cabeza_retiro__c desc];
                    detalleCaso = cuentasCaso[0];
                    cuentasCaso.remove(0);
                            Cuentas__C cuentatempo= new Cuentas__C();
                            cuentatempo =[select codigo__c, cuenta_Colectiva2__c from cuentas__C where id=:detallecaso.Cuenta__c limit 1];
                            //getSaldoCuenta saldos = new getSaldoCuenta();
                            DECIMAL montoBrutoRetirar=0;
                            detalleCaso.Saldo_total__c=decimal.valueOf(saldos.saldoTotal.replace(',',''));
                            
                              
                                   for(integer i=0; i<cuentasCaso.size(); i++)
                                    {
                                        for(integer j=0; j<saldos.saldos.size(); j++)
                                        {
                                            if(cuentasCaso[i].Saldo_retirar__c==saldos.saldos[j].tipoSaldo)
                                            {
                                                cuentasCaso[i].Monto_saldo__c=decimal.valueOf(saldos.saldos[j].montoSaldo.replace(',',''));
                                                
                                                if(detalleCaso.Tipo_retiro__c=='52')
                                                {
                                                    cuentasCaso[i].Monto_retirar__c=decimal.valueOf(saldos.saldos[j].montoSaldo.replace(',','')); 
                                                }
                                                if(cuentasCaso[i].Monto_retirar__c !=null)
                                                {
                                                    montoBrutoRetirar+=cuentasCaso[i].Monto_retirar__c;
                                                }
                                                
                                            }
                                        }
                                    }
                               if(detalleCaso.Tipo_retiro__c=='52')
                               {
                                   
                               
                                for(integer i=0; i<cuentasCaso.size(); i++)
                                {
                                    if(cuentasCaso[i].Saldo_retirar__c =='12' && !detallecaso.Permitir_Retiro_Saldos_Patronales__c &&  cuentasCaso[i].Monto_retirar__c !=null
                                              ||cuentasCaso[i].Saldo_retirar__c=='13' && !detallecaso.Permitir_Retiro_Saldos_Patronales__c && cuentasCaso[i].Monto_retirar__c !=null )
                                            {
                                               montoBrutoRetirar=montoBrutoRetirar- cuentasCaso[i].Monto_retirar__c;
                                            }
                                }
                                //PARTE AÑADIDA LUIS
                                Decimal montoComi = 0;
                                Decimal montoACH = 0;
                                Decimal montoCheque = 0;
                                decimal montoTSP = 0; 
                                
                                Decimal montoCambio = 1;
                                
                                
                                detalleCaso.Porcentaje_comision__c = detalleCaso.Porcentaje_comision__c != null ? detalleCaso.Porcentaje_comision__c : 0;													
                                detalleCaso.Monto_comision_retiro__c = montoBrutoRetirar * (detalleCaso.Porcentaje_comision__c / 100);
                                if(cuentatempo.cuenta_colectiva2__C ==null)
                                {
                                     if(detalleCaso.Comision_Retiro_Anticipado__c && detalleCaso.Comision_retiro_anticipado_empresa__c){
                                
                                        montoComi = detalleCaso.Monto_comision_retiro__c;
                                        }                                
                                }
                            else
                            {
                              if(detalleCaso.Cliente_sigue_Laborando__c && detalleCaso.Cobrar_empleado_sigue_laborando__c){
                                
                                    montoComi = detalleCaso.Monto_comision_retiro__c;
                                }  
                            }
                                
                               
                                
                                if(detalleCaso.Forma_Retiro__c == 'ACH' && detalleCaso.Cobro_ACH__c){
                                montoACH = detalleCaso.Monto_ACH__c;
                                }
                                if(detalleCaso.Forma_Retiro__c == 'CK' && detalleCaso.Cobro_Cheque__c){
                                montoCheque = detalleCaso.Monto_cheque__c;
                                }
                                //Decimal milTSP = (((montoBrutoRetirar -  montoComi - montoACH - montoCheque) * montoCambio) / 1000).round(System.RoundingMode.UP);
                                 Decimal milTSP;
                                 if(detalleCaso.Cliente_sigue_Laborando__c || detalleCaso.Comision_Retiro_Anticipado__c
                                || detalleCaso.Comision_retiro_anticipado_empresa__c)
                                {
                                     milTSP = (((montoBrutoRetirar-  montoComi - montoACH - montoCheque) * montoCambio) / 1000).round(System.RoundingMode.UP);
                                }
                                else
                                {
                                    milTSP = (((montoBrutoRetirar  - montoACH - montoCheque) * montoCambio) / 1000).round(System.RoundingMode.UP);
                                }
                                Decimal calculoTSP = ( milTSP * 2 ) / montoCambio;
                                detalleCaso.Monto_TSP__c = calculoTSP;
                                                        
                                if(detalleCaso.Cobro_TSP__c){
                                    montoTSP = detalleCaso.Monto_TSP__c;
                                }
                                
                                if(detalleCaso.Cliente_sigue_Laborando__c || detalleCaso.Comision_Retiro_Anticipado__c
                                || detalleCaso.Comision_retiro_anticipado_empresa__c)
                                {
                                    detalleCaso.Monto_total_comisiones_recargos__c = montoComi+ montoTSP + montoACH + montoCheque;
                                     
                                }
                            else
                            {
                                detalleCaso.Monto_total_comisiones_recargos__c =  montoTSP + montoACH + montoCheque;
                            }
                            detalleCaso.Monto_bruto_retirar__c = montoBrutoRetirar;
                            detalleCaso.Monto_total_retirar__c = montoBrutoRetirar - detalleCaso.Monto_total_comisiones_recargos__c;
                       }
                            update cuentascaso;
                            update detallecaso;
                    system.debug('Exito');
                    if(estadocaso=='Pendiente segunda aprobación' || estadocaso=='Nuevo')
                    {
                        //claseUtilPlanillas.CorreoRetiros(idCaso,estadocaso);
                    }
                          
                }       	
            }catch(System.CalloutException e){
                system.debug(e.getMessage());	
            }Catch(Exception e){
                system.debug('Clase Futura' +e.getMessage() + ' linea ' + e.getLineNumber());	
            }
        }*/
       
    }
    
    public static void Metodoutil()
    {
        
    }
    
    
}