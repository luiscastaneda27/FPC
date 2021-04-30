public class DAU_BorrarCuotas {
	@future(callout=true)
    public static void aumentoDisminucion(String idCaso, String tipoSaldo) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/aumentodisminucion');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        Case caso = new Case();
        Detalle_Caso__c detalle = new Detalle_Caso__c();
        classAumentoDisminucion claseEnvio = new classAumentoDisminucion();
        
        try{
            caso = [Select AccountId,Account.Name,CaseNumber,RecordType.Name,CreatedDate,Owner.Name, lastModifiedDate,Respuesta_desde_Sysde__c 
                    From Case Where Id =: idCaso];
            
            detalle = [Select Tipo_Operacion__c, Nuevo_monto_aporte__c, Cuenta__r.Codigo__c, CreatedBy.Codigo__c, Cuenta__c,
                       Nuevo_canal_aporte__c, Nueva_fecha_aporte__c, N_Cuenta_Bancaria__c, DAU_Dia_de_pago__c, DAU_Borrar_Cuotas__c,
                       Cuenta__r.Monto_aporte__c, Cuenta__r.Forma_Aportacion__c, Cuenta__r.Fecha_Aporte__c,Frecuencia__c
                       From Detalle_caso__c Where Caso__c =: Caso.id Limit 1];
            
            system.debug(detalle); 
                        
            list<classBitacora> bitacoras = new list<classBitacora>();

            claseEnvio.cuenta = detalle.Cuenta__r.Codigo__c;
            claseEnvio.tipoSaldoMod = tipoSaldo;
            claseEnvio.nuevoCanalAporte =  Null;
            claseEnvio.montoOperacion = 0;
            claseEnvio.fecha =  date.today();
            claseEnvio.cuentaTarjeta =  Null;
            claseEnvio.accion =  'A7';
            claseEnvio.periodicidad = Null;
            claseEnvio.bitacora = bitacoras;
                       
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);
            
            request.setBody(cons);
            request.setTimeout(120000);
            
            HttpResponse response = http.send(request);
            
            if (response.getStatusCode() == 200) {
                System.debug(response.getBody());               
                Caso.Respuesta_desde_Sysde__c = Caso.Respuesta_desde_Sysde__c + ', Cuotas Borradas del Saldo: '+tipoSaldo;
                update Caso;
                if(detalle.DAU_Borrar_Cuotas__c == '3') {
                	List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                    Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = caso.Id, DAU_Borrar_Cuotas_S18__c = true));
                    // Call method to publish events
                    List<Database.SaveResult> results = EventBus.publish(Logs); 	    
                } 
            }
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            Caso.Respuesta_desde_Sysde__c = e.getMessage() + 'Línea: ' + e.getLineNumber();
            Caso.Status = 'Error de conexion';
            claseUtil.stopTrigger();     
            update caso; 
        }Catch(Exception e){
            system.debug('Clase Futura' +e.getMessage() + ' linea ' + e.getLineNumber());   
        }    
    }
    
    @future(callout=true)
    public static void aumentoDisminucion2(String idCaso, String tipoSaldo) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/aumentodisminucion');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        Case caso = new Case();
        Detalle_Caso__c detalle = new Detalle_Caso__c();
        classAumentoDisminucion claseEnvio = new classAumentoDisminucion();
        
        try{
            caso = [Select AccountId,Account.Name,CaseNumber,RecordType.Name,CreatedDate,Owner.Name, lastModifiedDate,Respuesta_desde_Sysde__c 
                    From Case Where Id =: idCaso];
            
            detalle = [Select Tipo_Operacion__c, Nuevo_monto_aporte__c, Cuenta__r.Codigo__c, CreatedBy.Codigo__c, Cuenta__c,
                       Nuevo_canal_aporte__c, Nueva_fecha_aporte__c, N_Cuenta_Bancaria__c, DAU_Dia_de_pago__c, DAU_Borrar_Cuotas__c,
                       Cuenta__r.Monto_aporte__c, Cuenta__r.Forma_Aportacion__c, Cuenta__r.Fecha_Aporte__c,Frecuencia__c
                       From Detalle_caso__c Where Caso__c =: Caso.id Limit 1];
            
            system.debug(detalle); 
                        
            list<classBitacora> bitacoras = new list<classBitacora>();

            claseEnvio.cuenta = detalle.Cuenta__r.Codigo__c;
            claseEnvio.tipoSaldoMod = tipoSaldo;
            claseEnvio.nuevoCanalAporte =  Null;
            claseEnvio.montoOperacion = 0;
            claseEnvio.fecha =  date.today();
            claseEnvio.cuentaTarjeta =  Null;
            claseEnvio.accion =  'A7';
            claseEnvio.periodicidad = Null;
            claseEnvio.bitacora = bitacoras;
                       
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);
            
            request.setBody(cons);
            request.setTimeout(120000);
            
            HttpResponse response = http.send(request);
            
            if (response.getStatusCode() == 200) {
                System.debug(response.getBody());               
                Caso.Respuesta_desde_Sysde__c = Caso.Respuesta_desde_Sysde__c + ', Cuotas Borradas del Saldo: '+tipoSaldo;
                update Caso;
            }
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            Caso.Respuesta_desde_Sysde__c = e.getMessage() + 'Línea: ' + e.getLineNumber();
            Caso.Status = 'Error de conexion';
            claseUtil.stopTrigger();     
            update caso; 
        }Catch(Exception e){
            system.debug('Clase Futura' +e.getMessage() + ' linea ' + e.getLineNumber());   
        }    
    }
    
    //@future(callout=true)
    public static string ConsultaInfoClienteC(String idCaso, String pc_codCuenta) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaInfoClienteC/'+ pc_codCuenta);
		ClienteNaturales fcsd= new ClienteNaturales();
        list<beneficiario> bene = new list<beneficiario>();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
        
        Case caso = new Case();
        
        caso = [Select Id, Status, DAU_Tarjeta_de_Sysde__c, Tipo_de_Operacion__c From Case Where Id =: idCaso];
        
		try{
            
			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta: ' + respuesta); 
            
            System.debug('response.getStatusCode: '+response.getStatusCode());
            if (response.getStatusCode() == 200) {  
	            fcsd = (ClienteNaturales)System.JSON.deserialize(response.getBody(), ClienteNaturales.class);
                System.debug('fcsd: '+fcsd);

                //caso.DAU_Tarjeta_de_Sysde__c = fcsd.pccuentapago/*4809939250096876*/;
                //update caso;
                    
                System.debug('fcsd.pccuentapago: '+fcsd.pccuentapago);
                  
                /*List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = caso.Id, DAU_NumeroCuenta__c = fcsd.pccuentapago));
                // Call method to publish events
                List<Database.SaveResult> results = EventBus.publish(Logs); */  
        	}
            
		}catch(System.CalloutException e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());
        }Catch(Exception e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());
            if(e.getMessage().contains('For input string')) {
            	caso.Status = 'No Aplica'; 
            	update caso;
            } 
		} 
        
        system.debug('debuggAPI' +' '+ fcsd);
		return fcsd.pccuentapago;   
    }
   
}