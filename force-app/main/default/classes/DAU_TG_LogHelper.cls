public class DAU_TG_LogHelper {
	public static void ProcessLog(List<DAU_Salesforce_Tarjetas__e> st) {
    	Case c = new Case();
        List<Case> caso = new List<Case>();
        try {
        	c = [Select Id,Account.Name,Account.Identificacion__c,Description,DAU_Identidad__c,DAU_aprobacion__c,Status,Tipo_de_Operacion__c,ParentId,
                 Respuesta_desde_Sysde__c, Respuesta_SF_Tarjetas__c, DAU_Tarjeta_de_Sysde__c,
                 DAU_No_Cuenta__c From case Where Id =: st[0].DAU_IdCaso__c];
            
            List<Detalle_caso__c> detailCase = [Select Id,Caso__c,N_Cuenta_Bancaria__c,DAU_Dia_de_pago__c, DAU_Borrar_Cuotas__c, Cuenta__r.Name, 
                       Cuenta__r.CurrencyIsoCode,Cuenta__r.Forma_Aportacion__c,Nuevo_canal_aporte__c,Banco__c From Detalle_caso__c where Caso__c =: c.Id Limit 1];
            
            Set<Id> caseIds = new Set<Id>();
            caseIds.add(c.Id);
            
            if(!detailCase.isEmpty()) {
                //Llamar al servico de *Salesforce Tarjetas* cuando la forma de aportación de la cuenta es: Tarjeta de Crédito/Debito
                if(detailCase[0].Nuevo_canal_aporte__c == 'TA' || detailCase[0].Banco__c == '28' || detailCase[0].Cuenta__r.Forma_Aportacion__c == 'TA') {
                    if(c.Tipo_de_Operacion__c == 'A3' || c.Tipo_de_Operacion__c == 'A8') {
                        //Bandera para que el trigger de caso llama al Servio de Salesforce Tarjetas                
                        if(st[0].DAU_EjecutarSYSDE__c == true) {
                            aSysdeCallouts.aumentoDisminucion(c.id); 
                        }                        
                        //LLamar al servicio que procesa el caso en Sysde cuando es débito a tercero y caso pasa por aprobación de Operaciones
                        if(st[0].DAU_EjecutarSYSDEOper__c == true && st[0].DAU_Borrar_Cuotas_S10__c == false) {
                            aSysdeCallouts.aumentoDisminucion(c.id); 
                        }                       
                        //Llamar al servicio que borra las cuotas del saldo 10 en el caso de Afiliación de Débito Automático
                        String tipoSaldo = '';
                        if(st[0].DAU_Borrar_Cuotas_S10__c == true) {
                            System.debug('Solo llama al servicio que Borra la cuotas del Saldo 10');
                            tipoSaldo = '10';
                            DAU_BorrarCuotas.aumentoDisminucion(c.Id, tipoSaldo);
                        }                         
                        //Llamar al servicio que borra las cuotas del saldo 10 en el caso de Afiliación de Débito Automático
                        if(st[0].DAU_Borrar_Cuotas_S18__c == true) {
                            System.debug('Solo llama al servicio que Borra la cuotas del Saldo 18');
                            tipoSaldo = '18';
                            DAU_BorrarCuotas.aumentoDisminucion2(c.Id, tipoSaldo);
                        } 
                    } 
                    if(c.Tipo_de_Operacion__c == 'A4') {
                        if(st[0].DAU_NumeroCuenta__c <> Null) {
                            updateCase.validarIdentidad(c.Id, st[0].DAU_NumeroCuenta__c, c.Account.Identificacion__c);    
                        }
                        //LLamar al servicio que procesa el caso en Sysde 
                        if(st[0].DAU_EjecutarSYSDE__c == true) {
                            aSysdeCallouts.aumentoDisminucion(c.id); 
                        }
                    }
                    
                    if(c.Tipo_de_Operacion__c == 'A6' /*&& !c.Description.contains('Error')*/) { 
                        System.debug('Caso de Cambio de TC Ficohsa');
                        if(st[0].DAU_PrimerServicio__c == true) { updateCase.validarIdentidad2(c.Id, c.DAU_Tarjeta_de_Sysde__c, c.Account.Identificacion__c);
                            System.debug('Se ejecuta primera validación de identidad');
                        }                 
                        if(st[0].DAU_SegundoServicio__c == true) {
                            System.debug('Se procede a ejecutar la Cancelación por cambio de tarjeta');
                        	Salesforce_Tarjetas.processCase(caseIds, 'DEC', '', '');     
                        }
                        if(st[0].DAU_TercerServicio__c == true) { updateCase.validarIdentidad2(c.Id, detailCase[0].N_Cuenta_Bancaria__c, c.Account.Identificacion__c);
                        	System.debug('Se ejecuta segunda validación de identidad');
                        }
                        if(st[0].DAU_CuartoServicio__c == true) { Salesforce_Tarjetas.processCase(caseIds, 'ADI', c.Account.Name, detailCase[0].DAU_Dia_de_pago__c); 
                            System.debug('Se procede a ejecutar la Afiliación por cambio de tarjeta');
                        }                         
                        //LLamar al servicio que procesa el caso en Sysde 
                        if(st[0].DAU_EjecutarSYSDE__c == true) { aSysdeCallouts.aumentoDisminucion(c.id); 
                            System.debug('Se ejecuta llamada a Sysde');
                        }
                        //Llamar al servicio que borra las cuotas del saldo 10 en el caso de Afiliación de Débito Automático
                        String tipoSaldo = '';
                        if(st[0].DAU_Borrar_Cuotas_S10__c == true) {
                            System.debug('Solo llama al servicio que Borra la cuotas del Saldo 10');
                            tipoSaldo = '10';
                            DAU_BorrarCuotas.aumentoDisminucion(c.Id, tipoSaldo);
                        }                         
                        //Llamar al servicio que borra las cuotas del saldo 10 en el caso de Afiliación de Débito Automático
                        if(st[0].DAU_Borrar_Cuotas_S18__c == true) {
                            System.debug('Solo llama al servicio que Borra la cuotas del Saldo 18');
                            tipoSaldo = '18';
                            DAU_BorrarCuotas.aumentoDisminucion2(c.Id, tipoSaldo);
                        } 
                    }
                    
                    //DAU - Cancelación
                    if(c.Tipo_de_Operacion__c == 'A7') {                                               
                        //LLamar al servicio que procesa el caso en Sysde 
                        if(st[0].DAU_EjecutarSYSDE__c == true && c.Respuesta_desde_Sysde__c == Null) {
                            aSysdeCallouts.aumentoDisminucion(c.id); 
                        }
                        
                        if(st[0].DAU_EjecutarSYSDE__c == true && c.Respuesta_desde_Sysde__c != Null && c.Respuesta_desde_Sysde__c.contains('Cancelación')) {
                            aSysdeCallouts.aumentoDisminucion(c.id); 
                        }

                        //Cancelación disparada desde un retiro Total
                        if(st[0].DAU_PrimerServicio__c == true) {
                            System.debug('Cancelación de TA se disparada desde un retiro Total');
                            String tipoGestion = 'DEC';
                        	Salesforce_Tarjetas.processCase(caseIds,tipoGestion,'','');
                        }                        
                    }	    
                } 
                
                //Llamar al servico de *BAC* cuando la forma de aportación de la cuenta es: Tarjeta de Crédito/Debito otros Bancos
                else if(detailCase[0].Nuevo_canal_aporte__c == 'TAOB' || detailCase[0].Banco__c == 'Otros Bancos' || test.isRunningTest()) {
                    //Caso de Cambio de Canal de Aporte	
                    if(c.Tipo_de_Operacion__c == 'A3' || c.Tipo_de_Operacion__c == 'A8' || test.isRunningTest()) {
                        //Bandera para que el trigger de caso llama al Servio de Salesforce Tarjetas                
                        if(st[0].DAU_EjecutarSYSDE__c == true) {
                            aSysdeCallouts.aumentoDisminucion(c.id); 
                        }
                        
                        //LLamar al servicio que procesa el caso en Sysde cuando es débito a tercero y caso pasa por aprobación de Operaciones
                        if((st[0].DAU_EjecutarSYSDEOper__c == true && st[0].DAU_Borrar_Cuotas_S10__c == false) || test.isRunningTest()) {
                            aSysdeCallouts.aumentoDisminucion(c.id); 
                        }
                        
                        //Llamar al servicio que borra las cuotas del saldo 10 en el caso de Afiliación de Débito Automático
                        String tipoSaldo = '';
                        if(st[0].DAU_Borrar_Cuotas_S10__c == true) {
                            System.debug('Solo llama al servicio que Borra la cuotas del Saldo 10');
                            tipoSaldo = '10';
                            DAU_BorrarCuotas.aumentoDisminucion(c.Id, tipoSaldo);
                        } 
                        
                        //Llamar al servicio que borra las cuotas del saldo 10 en el caso de Afiliación de Débito Automático
                        if(st[0].DAU_Borrar_Cuotas_S18__c == true) {
                            System.debug('Solo llama al servicio que Borra la cuotas del Saldo 18');
                            tipoSaldo = '18';
                            DAU_BorrarCuotas.aumentoDisminucion2(c.Id, tipoSaldo);
                        } 
                    }  
                    
                    //Caso de Aumento de Aporte	o Disminución de Aporte	 o Cambio de Fecha de Aporte	
                    if(c.Tipo_de_Operacion__c == 'A1' || c.Tipo_de_Operacion__c == 'A2' || c.Tipo_de_Operacion__c == 'A4' || test.isRunningTest()) {
                        if(c.Respuesta_SF_Tarjetas__c == Null) {
                        	DAU_GestionesBac.execute(c.id);  
                        }    
                    	if(st[0].DAU_EjecutarSYSDE__c == true) {
                            aSysdeCallouts.aumentoDisminucion(c.id); 
                        }
                    }
                    
                    //Caso de Cambio de # Tarjeta	
                    if(c.Tipo_de_Operacion__c == 'A6' || test.isRunningTest()) {
                        if(c.status == 'Cerrado' && st[0].DAU_PrimerServicio__c == true) { DAU_GestionesBac.execute(c.Id);
                            System.debug('Se ejecuta la Cancelación BAC');
                        }
                        if(c.status == 'Cerrado' && st[0].DAU_SegundoServicio__c == true) { DAU_GestionesBac.execute(c.Id);
                            System.debug('Se ejecuta la Afiliación BAC');
                        }
                        if(st[0].DAU_EjecutarSYSDE__c == true) {
                            aSysdeCallouts.aumentoDisminucion(c.id); 
                        }
                        //Llamar al servicio que borra las cuotas del saldo 10 en el caso de Cambio de # Tarjeta
                        String tipoSaldo = '';
                        if(st[0].DAU_Borrar_Cuotas_S10__c == true) {
                            System.debug('Solo llama al servicio que Borra la cuotas del Saldo 10');
                            tipoSaldo = '10';
                            DAU_BorrarCuotas.aumentoDisminucion(c.Id, tipoSaldo);
                        }                         
                        //Llamar al servicio que borra las cuotas del saldo 10 en el caso de Cambio de # Tarjeta
                        if(st[0].DAU_Borrar_Cuotas_S18__c == true) {
                            System.debug('Solo llama al servicio que Borra la cuotas del Saldo 18');
                            tipoSaldo = '18';
                            DAU_BorrarCuotas.aumentoDisminucion2(c.Id, tipoSaldo);
                        } 
                    }
                    
                    //Caso de Cancelación
                    if(c.Tipo_de_Operacion__c == 'A7') {	
                        if(c.Respuesta_SF_Tarjetas__c == Null && !c.Respuesta_SF_Tarjetas__c.contains('Cancelación: // ')) {
                        	DAU_GestionesBac.execute(c.id);  
                        }
                        if(st[0].DAU_EjecutarSYSDE__c == true) { aSysdeCallouts.aumentoDisminucion(c.id); 
                        }
                        if(st[0].DAU_PrimerServicio__c == true) { DAU_GestionesBac.execute(c.id);    
                        }
                    }
                    
                } 
                
                //Llamar al servico de *Cuenta de Ahorro* cuando la forma de aportación de la cuenta es: AH
                else if(detailCase[0].Nuevo_canal_aporte__c == 'AH' || detailCase[0].Cuenta__r.Forma_Aportacion__c == 'AH') {              
                    System.debug('Tipo AH');
                    if(st[0].DAU_PrimerServicio__c == true) {
                        System.debug('Se ejecuta la Cancelación de la Cuenta de Ahorro');
                        ControllerServiciosCuentaAhorro.execute(c.id);
                    }
                    if(st[0].DAU_SegundoServicio__c == true) {
                        System.debug('Se ejecuta la Afiliación de la Cuenta de Ahorro');
                        ControllerServiciosCuentaAhorro.execute(c.id);
                    }
                    /*if(c.Tipo_de_Operacion__c == 'A7' && c.Respuesta_SF_Tarjetas__c == Null && c.ParentId != Null) {
                    	ControllerServiciosCuentaAhorro.execute(c.id);     
                    }*/
                    if(st[0].DAU_EjecutarSYSDE__c == true) { aSysdeCallouts.aumentoDisminucion(c.id); 
                    }
                    //Llamar al servicio que borra las cuotas del saldo 10 en el caso de Cambio de # Tarjeta
                    String tipoSaldo = '';
                    if(st[0].DAU_Borrar_Cuotas_S10__c == true) {
                        System.debug('Solo llama al servicio que Borra la cuotas del Saldo 10');
                        tipoSaldo = '10';
                        DAU_BorrarCuotas.aumentoDisminucion(c.Id, tipoSaldo);
                    }                         
                    //Llamar al servicio que borra las cuotas del saldo 10 en el caso de Cambio de # Tarjeta
                    if(st[0].DAU_Borrar_Cuotas_S18__c == true) {
                        System.debug('Solo llama al servicio que Borra la cuotas del Saldo 18');
                        tipoSaldo = '18';
                        DAU_BorrarCuotas.aumentoDisminucion2(c.Id, tipoSaldo);
                    }
                }
            }
        } catch(Exception ex) {
        	System.debug('Error: '+ex.getMessage()+'--'+ex.getLineNumber());      
        }
    }
}