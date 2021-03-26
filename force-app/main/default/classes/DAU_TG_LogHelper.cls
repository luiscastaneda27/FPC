public class DAU_TG_LogHelper {
	public static void ProcessLog(List<DAU_Salesforce_Tarjetas__e> st) {
    	Case c = new Case();
        List<Case> caso = new List<Case>();
        try {
        	c = [Select Id,Account.Name,Account.Identificacion__c,DAU_Identidad__c,DAU_aprobacion__c,Status,Tipo_de_Operacion__c,
                 Respuesta_desde_Sysde__c, Respuesta_SF_Tarjetas__c, DAU_llamarSalesforceTarjeta__c, DAU_Tarjeta_de_Sysde__c
                 From case Where Id =: st[0].DAU_IdCaso__c];
            
            List<Detalle_caso__c> detailCase = [Select Id,Caso__c,N_Cuenta_Bancaria__c,DAU_Dia_de_pago__c, DAU_Borrar_Cuotas__c, Cuenta__r.Name, 
                                                Cuenta__r.Forma_Aportacion__c From Detalle_caso__c where Caso__c =: c.Id Limit 1];
            
            if(!detailCase.isEmpty()) {
                //Lllamar al servico de *Salesforce Tarjetas* cuando la forma de aportación de la cuenta es: Tarjeta de Crédito/Debito
                if(detailCase[0].Cuenta__r.Forma_Aportacion__c == 'TA') {
                    if(c.Tipo_de_Operacion__c == 'A4') {
                        if(c.DAU_Tarjeta_de_Sysde__c == Null && c.DAU_Identidad__c == Null) {
                            DAU_BorrarCuotas.ConsultaInfoClienteC(c.Id,detailCase[0].Cuenta__r.Name);
                        } 
                        if(c.DAU_Tarjeta_de_Sysde__c <> Null && c.DAU_Identidad__c == Null) {
                            updateCase.validarIdentidad(c.Id, c.DAU_Tarjeta_de_Sysde__c, c.Account.Identificacion__c);    
                        }
                        if(c.DAU_llamarSalesforceTarjeta__c == false && c.DAU_Identidad__c <> Null) {
                            c.DAU_llamarSalesforceTarjeta__c = true;
                            update c;
                        }
                        //LLamar al servicio que procesa el caso en Sysde 
                        if(st[0].DAU_EjecutarSYSDE__c == true && c.Respuesta_SF_Tarjetas__c <> Null) {
                            aSysdeCallouts.aumentoDisminucion(c.id); 
                        }
                    }
                    
                    if(c.Tipo_de_Operacion__c == 'A6') { 
                        if(c.DAU_Tarjeta_de_Sysde__c == Null && c.DAU_Identidad__c == Null) {
                            DAU_BorrarCuotas.ConsultaInfoClienteC(c.Id,detailCase[0].Cuenta__r.Name);
                        } 
                        if(c.DAU_Tarjeta_de_Sysde__c <> Null && c.DAU_Identidad__c == Null) {
                            updateCase.validarIdentidad(c.Id, c.DAU_Tarjeta_de_Sysde__c, c.Account.Identificacion__c);    
                        }
                        //LLamar al servicio que procesa el caso en Sysde cuando es débito a titular
                        if(st[0].DAU_EjecutarSYSDE__c == true) {
                            System.debug('Entra a cerrar el caso');
                            c.DAU_aprobacion__c = true;
                            c.Status = 'Cerrado';
                            update c;
                        }
                        //Bandera para que el trigger de caso llama al Servio de Salesforce Tarjetas
                        if(c.DAU_llamarSalesforceTarjeta__c == false && c.DAU_Identidad__c <> '') {
                            c.DAU_llamarSalesforceTarjeta__c = true;
                            update c;
                        }
                    }
                    
                    if(c.Tipo_de_Operacion__c == 'A7') {
                        if(c.DAU_Tarjeta_de_Sysde__c == Null && c.DAU_Identidad__c == Null) {
                            DAU_BorrarCuotas.ConsultaInfoClienteC(c.Id,detailCase[0].Cuenta__r.Name);
                        } 
                        if(c.DAU_Tarjeta_de_Sysde__c <> Null && c.DAU_Identidad__c == Null) {
                            updateCase.validarIdentidad(c.Id, c.DAU_Tarjeta_de_Sysde__c, c.Account.Identificacion__c);    
                        }
                        if(c.DAU_llamarSalesforceTarjeta__c == false && c.DAU_Identidad__c <> Null) {
                            c.DAU_llamarSalesforceTarjeta__c = true;
                            update c;
                        }
                        //LLamar al servicio que procesa el caso en Sysde 
                        if(st[0].DAU_EjecutarSYSDE__c == true && c.Respuesta_SF_Tarjetas__c <> Null) {
                            aSysdeCallouts.aumentoDisminucion(c.id); 
                        }
                    }
                    
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
                //Lllamar al servico de *BAC* cuando la forma de aportación de la cuenta es: Tarjeta de Crédito/Debito otros Bancos	    
                } else if(detailCase[0].Cuenta__r.Forma_Aportacion__c == 'TAOB') {
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
                }
            }
        } catch(Exception ex) {
        	System.debug('Error: '+ex.getMessage()+'--'+ex.getLineNumber());      
        }
    }
}