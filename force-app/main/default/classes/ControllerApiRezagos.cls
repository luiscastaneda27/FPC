public class ControllerApiRezagos {
    
    public static String guardarRezago(Rezagos RezList) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/insertaRezagos');
		
		String respuesta = '';
		try{
						
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(RezList);
			String cons = 'contenido=' + envio.contenido;
			system.debug('Enviamos: '+cons);		
			request.setBody(cons);	
            system.debug('request: '+request.getBody());
			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            system.debug(respuesta);      
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return respuesta;   
    }
    
    public static List<InfoRezagos.clientes> ConsultaRezagos() {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        //String url = 'http://190.5.68.49:9090/';
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/consultaRezagos');
        String respuesta = '';
        system.debug('Entro al REST del EDC');
        List<InfoRezagos.clientes> respuest = new List<InfoRezagos.clientes>();
        try{
            
            /*classJson envio = new classJson();
            envio.contenido = '{"numTransaccion":'+JSON.serialize('')+'}';
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);	*/	
            request.setBody('contenido={"numTransaccion":""}');	
            
            HttpResponse response = new HttpResponse();
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
            	response.setBody('{"clientes":[{"idRezago":"SF-135","montoRezago":"40000","fondo":"106","codReferencia":"FT20prueba4","fechaDeposito":"27-SEP-20","codigoMoneda":"USD","descripcion":"Transferencia entre Cuentas","descripcionNota":"Transferencia de la cuenta XX4156 de CRISTINA BANEGAS ZEITUN    100110 VENTA $","usuIngresaRezago":"HN02913","codBanco":"28","agnBanco":"AGN PRINCIPAL TGU","rezagoSINO":"SI","asesor":"HN23213","estado":"Pendiente","valorCuotaEntrada":"127.52636724","fecInclusion":"01-OCT-20","incluidoPor":"System","fecModificacion":"08-OCT-20","modificadoPor":"HN02913","montoPendienteAplicar":""},{"idRezago":"SF-135","montoRezago":"40000","fondo":"106","codReferencia":"FT20prueba5","fechaDeposito":"01-sep-20","codigoMoneda":"USD","descripcion":"Transferencia entre Cuentas","descripcionNota":"Transferencia de la cuenta XX4156 de CRISTINA BANEGAS ZEITUN    100110 VENTA $","usuIngresaRezago":"HN02913","codBanco":"28","agnBanco":"AGN PRINCIPAL TGU","rezagoSINO":"NO","asesor":"HN23213","estado":"Pendiente","valorCuotaEntrada":"127.52636724","fecInclusion":"01-OCT-20","incluidoPor":"System","fecModificacion":"08-OCT-20","modificadoPor":"HN02913","montoPendienteAplicar":""}]}');
            }    

            respuesta = response.getBody();
            system.debug('Respuesta Search: '+respuesta);
            
            InfoRezagos test = (InfoRezagos)System.JSON.deserialize(respuesta,InfoRezagos.class);
            respuest = test.clientes;
            
            //respuest = (List<InfoRezagos>)System.JSON.deserialize(respuesta, List<InfoRezagos>.class);
            System.debug('Exito');
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuest;    
    }
    
    public static ResponseRezago eliminarRezago(List<ResquestRezago> listRezago) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('DELETE');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/rezagos');
        request.setBody('contenido='+Json.serialize(listRezago));
        ResponseRezago respuesta = new ResponseRezago();
        try{
            System.debug('Enviamos : '+Json.serialize(listRezago));
            HttpResponse response = http.send(request);
            system.debug(response.getStatusCode() + ' -- Respuesta-- '+ response.getBody()); 
            if(response.getStatusCode() == 200){
                respuesta = (ResponseRezago) Json.deserialize(response.getBody(), ResponseRezago.class);
            }    
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }
    
    public static String AplicaRezagosDia(ClassClientesRez Rez) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/aplicaRezagos');
		
		String respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
						
			classJson envio = new classJson();
            envio.contenido = JSON.serialize(Rez);
			String cons = 'contenido=' + envio.contenido;
			system.debug('AplicaRezagosDia '+cons);		
			request.setBody(cons);	
            system.debug('request: '+request.getBody());
			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            system.debug('Aplica Rezagos: '+respuesta);      
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return respuesta;   
    }
    
    public static String ConsultaCuotaSal() {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/obtieneValCuota');
        String respuesta = '';
        system.debug('Entro al REST del EDC');
        try{	
            HttpResponse response = http.send(request);
            respuesta = response.getBody();
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;    
    }
    
    public static String AplicaRetiro(String COrigen, String Moneda, String MRetiro) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/retiros');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        String respuesta = '';
        List<classSaldos> saldos = new list<classSaldos>();
        classSaldos dato = new classSaldos();
        dato.tipoSaldo = '13';
        dato.montoSaldo = MRetiro;
        saldos.add(dato);
        classRetiros claseEnvio = new classRetiros();
        
        try{  
            System.Debug('Antes de Realizar el retiro.-');
            claseEnvio.tipoPago = 'N';//OK
            claseEnvio.cuenta = COrigen;//Si utilizo la Cuenta (FPC Rezagos) USER_DEBUG [188]|DEBUG|Respuesta: Error-no existe cliente 104896 Error 100 ORA-01403: no data found
            claseEnvio.cuentaOrigen = null;//Si utilizo la Cuenta (FPC Rezagos) USER_DEBUG [188]|DEBUG|Respuesta: Error-no existe cliente  Error 100 ORA-01403: no data found
            claseEnvio.cuentaDestino = null;//OK
            claseEnvio.transferencia = false;//Ok
            claseEnvio.tipoCuentaDestino = null;//OK
            claseEnvio.bancoCuentaDestino = null;//OK
            
            claseEnvio.tipoCuentaBancaria = null;//OK
            claseEnvio.cuentaPatronal = null;//OK
            claseEnvio.BancoCuentaBancaria = null;//OK
            ClaseEnvio.tipoCuenta = null;//OK
            claseEnvio.montoBrutoPatronal = 0.00;//OK
            claseEnvio.montoNetoPatronal = 0;//OK
            claseEnvio.montocargosPatronal = 0.00;//OK
            claseEnvio.saldoPrestamo = 0.00;//OK
            claseEnvio.montoRestanteCliente = 0;//OK
            claseEnvio.MontoSaldoPatronal = 0.00;//OK
            claseEnvio.montoChequePatrono = 0.00;//OK
            claseEnvio.montoACHPatrono = 0.00;//OK
            claseEnvio.montoTSPPatrono = 0.00;//OK
            
            if(Moneda=='1'){
                claseEnvio.monedaCuentaDestino ='HNL';
            }else{
                claseEnvio.monedaCuentaDestino ='USD';
            }
            
            claseEnvio.montoRetiro = Decimal.valueOf(MRetiro);//OK
            claseEnvio.tipoRetiro = '51';//OK
            claseEnvio.montoComisionPorRetiro = 0;//OK             
            claseEnvio.montoACH = 0;//OK
            claseEnvio.montoCheque = 0;//OK
            claseEnvio.montoTSP = 0;//OK
            claseEnvio.formaPago = 'EF/9000';//OK
            claseEnvio.aportePatronal = false;//OK
            claseEnvio.montoComisionPorRetiro = 0;//OK
            claseEnvio.saldos = saldos;//OK
            claseEnvio.bitacora = null;//OK
            claseEnvio.listBeneficiarios = null;//OK
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug('Mandamos: '+cons);
            request.setBody(cons);
            request.setTimeout(120000);
            HttpResponse response = new HttpResponse();
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('OK');
            }
            
            respuesta = response.getBody();
            System.debug('Respuesta: '+response.getBody());
            
        }catch(System.CalloutException e){
            system.debug('Error de conexion: '+e.getMessage());
        }Catch(Exception e){
            system.debug('Clase Futura' +e.getMessage() + ' linea ' + e.getLineNumber());   
        }
        return respuesta;
    }
    public static String AplicaRetiroRezagos(String COrigen, String Moneda, String MRetiro) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/retiros');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        String respuesta = '';
        List<classSaldos> saldos = new list<classSaldos>();
        classSaldos dato = new classSaldos();
        dato.tipoSaldo = '13';
        dato.montoSaldo = MRetiro;
        saldos.add(dato);
        classRetiros claseEnvio = new classRetiros();
        
        try{  
            System.Debug('Antes de Realizar el retiro.-');
            claseEnvio.tipoPago = 'N';//OK
            claseEnvio.cuenta = COrigen;//Si utilizo la Cuenta (FPC Rezagos) USER_DEBUG [188]|DEBUG|Respuesta: Error-no existe cliente 104896 Error 100 ORA-01403: no data found
            claseEnvio.cuentaOrigen = null;//Si utilizo la Cuenta (FPC Rezagos) USER_DEBUG [188]|DEBUG|Respuesta: Error-no existe cliente  Error 100 ORA-01403: no data found
            claseEnvio.cuentaDestino = null;//OK
            claseEnvio.transferencia = false;//Ok
            claseEnvio.tipoCuentaDestino = null;//OK
            claseEnvio.bancoCuentaDestino = null;//OK
            
            claseEnvio.tipoCuentaBancaria = null;//OK
            claseEnvio.cuentaPatronal = null;//OK
            claseEnvio.BancoCuentaBancaria = null;//OK
            ClaseEnvio.tipoCuenta = null;//OK
            claseEnvio.montoBrutoPatronal = 0.00;//OK
            claseEnvio.montoNetoPatronal = 0;//OK
            claseEnvio.montocargosPatronal = 0.00;//OK
            claseEnvio.saldoPrestamo = 0.00;//OK
            claseEnvio.montoRestanteCliente = 0;//OK
            claseEnvio.MontoSaldoPatronal = 0.00;//OK
            claseEnvio.montoChequePatrono = 0.00;//OK
            claseEnvio.montoACHPatrono = 0.00;//OK
            claseEnvio.montoTSPPatrono = 0.00;//OK
            
            if(Moneda=='1'){
                claseEnvio.monedaCuentaDestino ='HNL';
            }else{
                claseEnvio.monedaCuentaDestino ='USD';
            }
            
            claseEnvio.montoRetiro = Decimal.valueOf(MRetiro);//OK
            claseEnvio.tipoRetiro = '51';//OK
            claseEnvio.montoComisionPorRetiro = 0;//OK             
            claseEnvio.montoACH = 0;//OK
            claseEnvio.montoCheque = 0;//OK
            claseEnvio.montoTSP = 0;//OK
            claseEnvio.formaPago = 'EF/9000';//OK
            claseEnvio.aportePatronal = false;//OK
            claseEnvio.montoComisionPorRetiro = 0;//OK
            claseEnvio.saldos = saldos;//OK
            claseEnvio.bitacora = null;//OK
            claseEnvio.listBeneficiarios = null;//OK
            claseEnvio.clienteSigueLaborando = true;
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug('Mandamos: '+cons);
            request.setBody(cons);
            request.setTimeout(120000);
            HttpResponse response = new HttpResponse();
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('OK');
            }
            
            respuesta = response.getBody();
            System.debug('Respuesta: '+response.getBody());
            
        }catch(System.CalloutException e){
            system.debug('Error de conexion: '+e.getMessage());
            respuesta = 'Error de conexion: '+e.getMessage();
        }Catch(Exception e){
            system.debug('Clase Futura' +e.getMessage() + ' linea ' + e.getLineNumber());
        }
        return respuesta;
    }
    
    public class ResquestRezago{
        public String codigoRezago { get; set; }
    }
    public class ResponseRezago{
        public Boolean ok { get; set; }
        public String descripcion { get; set; }
    }
}