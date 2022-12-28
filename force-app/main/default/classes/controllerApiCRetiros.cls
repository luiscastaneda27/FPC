public class controllerApiCRetiros {
    public static classCRetiros conciliaRetiros(Date fecha_retiro) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
        
        string fecha = fecha_retiro.year()+'-'+fecha_retiro.month()+'-'+fecha_retiro.day();
        system.debug('Fecha' + fecha);
        
        request.setEndpoint(url + 'api/conciliaRetirosP/'+ fecha);
        
		classCRetiros fcsd= new classCRetiros();
        list<cuadreRetiros> bene = new list<cuadreRetiros>();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

			HttpResponse response;// = http.send(request);
            if(test.isRunningTest())
            {
                respuesta='{"fecha_retiro":null,"fechaSysdeRetiros":"2019-05-21T00:00:00","ListPagosI":[{"tsp":1.1,"tCuenta":"a","referencia":"a","numeroCaso":1.1,"nombreCliente":"a","monTotal":1.1,"montoPatronalCte":1.0,"monRetirar":1.1,"monMovimto":1.1,"moneda":"a","index":1,"idCliente":"a","fPago":"a","fecSYSDE":"2020-04-08T22:08:29.151Z","fecMovimto":"2020-04-08T22:08:29.151Z","cuentaDestino":"a","cuentaBancaria":"a","comparaFecha":1.1,"comparacion":1.0,"codCuenta":"a","ck":1.1,"bancoDestino":"a","ach":1.1}],"ListPagos":[{"referencia":"16374","codCuenta":"42329","nombreCliente":"ANA ELIZABETH OCHOA CALIX","numeroCaso":3176.0,"monMovimto":-1000.0,"monRetirar":-7780.05,"fecMovimto":"2019-05-21T00:00:00","fecSYSDE":"2019-05-21T00:00:00","comparacion":1.0,"fPago":"E","comparaFecha":0.0,"descripcion":null},{"referencia":"16369","codCuenta":"34037","nombreCliente":"CARLOS DAVID ESCOTO CANALES","numeroCaso":3152.0,"monMovimto":-20000.0,"monRetirar":-4970.51,"fecMovimto":"2019-05-21T00:00:00","fecSYSDE":"2019-05-21T00:00:00","comparacion":1.0,"fPago":"AH","comparaFecha":0.0,"descripcion":null},{"referencia":"16379","codCuenta":"42329","nombreCliente":"ANA ELIZABETH OCHOA CALIX","numeroCaso":3178.0,"monMovimto":-3000.0,"monRetirar":-6407.20,"fecMovimto":"2019-05-21T00:00:00","fecSYSDE":"2019-05-21T00:00:00","comparacion":1.0,"fPago":"E","comparaFecha":0.0,"descripcion":null},{"referencia":"16367","codCuenta":"51600","nombreCliente":"WENDY PAOLA ALVARADO AGUILAR","numeroCaso":3139.0,"monMovimto":-10000.0,"monRetirar":-14142.24,"fecMovimto":"2019-05-21T00:00:00","fecSYSDE":"2019-05-21T00:00:00","comparacion":1.0,"fPago":"AH","comparaFecha":0.0,"descripcion":null}],"ListPagosC":[{"referencia":"16390","codCuenta":"44260","nombreCliente":"LILIAM SARAHI RIVERA ALTAMIRANO","numeroCaso":3215.0,"fPago":"E","monMovimto":-5000.0,"monRetirar":5000.0,"montoPatronalCte":0.0,"tsp":10.0,"ach":0.0,"ck":0.0,"monTotal":1990.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16391","codCuenta":"44260","nombreCliente":"LILIAM SARAHI RIVERA ALTAMIRANO","numeroCaso":3217.0,"fPago":"E","monMovimto":-2000.0,"monRetirar":2000.0,"montoPatronalCte":0.0,"tsp":4.0,"ach":0.0,"ck":0.0,"monTotal":1996.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16373","codCuenta":"44260","nombreCliente":"LILIAM SARAHI RIVERA ALTAMIRANO","numeroCaso":3174.0,"fPago":"E","monMovimto":-4000.0,"monRetirar":4000.0,"montoPatronalCte":0.0,"tsp":8.0,"ach":0.0,"ck":0.0,"monTotal":992.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16370","codCuenta":"27280","nombreCliente":"LINA FAVIOLA LAGOS ","numeroCaso":3166.0,"fPago":"E","monMovimto":-50000.0,"monRetirar":50000.0,"montoPatronalCte":0.0,"tsp":100.0,"ach":0.0,"ck":0.0,"monTotal":49900.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16382","codCuenta":"44260","nombreCliente":"LILIAM SARAHI RIVERA ALTAMIRANO","numeroCaso":3194.0,"fPago":"E","monMovimto":-2000.0,"monRetirar":2000.0,"montoPatronalCte":0.0,"tsp":4.0,"ach":0.0,"ck":0.0,"monTotal":496.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16389","codCuenta":"53474","nombreCliente":"GLORIA ESPERANZA GOMEZ RODRIGUEZ","numeroCaso":3212.0,"fPago":"E","monMovimto":-665.0,"monRetirar":665.0,"montoPatronalCte":0.0,"tsp":2.0,"ach":0.0,"ck":0.0,"monTotal":663.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019538","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"USD"},{"referencia":"16371","codCuenta":"27280","nombreCliente":"LINA FAVIOLA LAGOS ","numeroCaso":3168.0,"fPago":"E","monMovimto":-38000.0,"monRetirar":38000.0,"montoPatronalCte":0.0,"tsp":76.0,"ach":0.0,"ck":0.0,"monTotal":37924.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16383","codCuenta":"44260","nombreCliente":"LILIAM SARAHI RIVERA ALTAMIRANO","numeroCaso":3201.0,"fPago":"E","monMovimto":-1000.0,"monRetirar":1000.0,"montoPatronalCte":0.0,"tsp":2.0,"ach":0.0,"ck":0.0,"monTotal":998.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16387","codCuenta":"53474","nombreCliente":"GLORIA ESPERANZA GOMEZ RODRIGUEZ","numeroCaso":3169.0,"fPago":"E","monMovimto":-1000.0,"monRetirar":1000.0,"montoPatronalCte":0.0,"tsp":2.0,"ach":0.0,"ck":0.0,"monTotal":998.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019538","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"USD"},{"referencia":"16386","codCuenta":"27280","nombreCliente":"LINA FAVIOLA LAGOS ","numeroCaso":3207.0,"fPago":"E","monMovimto":-23750.0,"monRetirar":23750.0,"montoPatronalCte":0.0,"tsp":48.0,"ach":0.0,"ck":0.0,"monTotal":23702.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16372","codCuenta":"53474","nombreCliente":"GLORIA ESPERANZA GOMEZ RODRIGUEZ","numeroCaso":3171.0,"fPago":"E","monMovimto":-3000.0,"monRetirar":3000.0,"montoPatronalCte":0.0,"tsp":6.0,"ach":0.0,"ck":0.0,"monTotal":2994.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019538","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"USD"},{"referencia":"16385","codCuenta":"27280","nombreCliente":"LINA FAVIOLA LAGOS ","numeroCaso":3206.0,"fPago":"E","monMovimto":-50000.0,"monRetirar":50000.0,"montoPatronalCte":0.0,"tsp":100.0,"ach":0.0,"ck":0.0,"monTotal":49900.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16384","codCuenta":"44260","nombreCliente":"LILIAM SARAHI RIVERA ALTAMIRANO","numeroCaso":3205.0,"fPago":"E","monMovimto":-3000.0,"monRetirar":3000.0,"montoPatronalCte":0.0,"tsp":6.0,"ach":0.0,"ck":0.0,"monTotal":1494.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16388","codCuenta":"53474","nombreCliente":"GLORIA ESPERANZA GOMEZ RODRIGUEZ","numeroCaso":3210.0,"fPago":"E","monMovimto":-500.0,"monRetirar":500.0,"montoPatronalCte":0.0,"tsp":2.0,"ach":0.0,"ck":0.0,"monTotal":498.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019538","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"USD"},{"referencia":"16369","codCuenta":"34037","nombreCliente":"CARLOS DAVID ESCOTO CANALES","numeroCaso":3152.0,"fPago":"AH","monMovimto":-41617.51,"monRetirar":41617.51,"montoPatronalCte":16647.0,"tsp":60.0,"ach":0.0,"ck":0.0,"monTotal":29940.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"8310138","cuentaDestino":"200007006569","bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16374","codCuenta":"42329","nombreCliente":"ANA ELIZABETH OCHOA CALIX","numeroCaso":3176.0,"fPago":"E","monMovimto":-12542.93,"monRetirar":12542.93,"montoPatronalCte":3762.88,"tsp":8.0,"ach":0.0,"ck":0.0,"monTotal":3992.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16380","codCuenta":"42339","nombreCliente":"IRWIN RICARDO PAVON MONCADA","numeroCaso":3179.0,"fPago":"E","monMovimto":-10379.28,"monRetirar":10379.28,"montoPatronalCte":2594.82,"tsp":0.0,"ach":0.0,"ck":0.0,"monTotal":2594.82,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16381","codCuenta":"42339","nombreCliente":"IRWIN RICARDO PAVON MONCADA","numeroCaso":3180.0,"fPago":"E","monMovimto":-10379.28,"monRetirar":10379.28,"montoPatronalCte":2594.82,"tsp":4.0,"ach":0.0,"ck":0.0,"monTotal":1496.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16379","codCuenta":"42329","nombreCliente":"ANA ELIZABETH OCHOA CALIX","numeroCaso":3178.0,"fPago":"E","monMovimto":-12542.93,"monRetirar":12542.93,"montoPatronalCte":3135.73,"tsp":14.0,"ach":0.0,"ck":0.0,"monTotal":6121.73,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"}],"ListPagosP":[{"referencia":"16380P","numeroCaso":3179.0,"nombreCliente":"BANCO LAFISE S.A.","codCuenta":"42339","fPago":"AH","monRetirar":7784.46,"tsp":16.0,"ach":0.0,"ck":0.0,"monTotal":7768.46,"fecSYSDE":"2019-05-21T00:00:00","moneda":"LPS","cuentaBancaria":"200008211317","cuentaDestino":"200007547667","bancoDestino":"28","tCuenta":null}]}}';
            	fcsd = (classCRetiros)System.JSON.deserialize(respuesta, classCRetiros.class);
            }
            
            else{
                response = http.send(request);
            }
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
           {
                
	            fcsd = (classCRetiros)System.JSON.deserialize(response.getBody(), classCRetiros.class);
               
           }
            
		}catch(System.CalloutException e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());
	
        }Catch(Exception e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());	
		} 
        
        system.debug('debuggAPI' +' '+ fcsd);
		return fcsd;   
    }	    
    
	public static classCRetiros guardarCliente(date fecha_retiro) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/conciliaRetiros/generaR');
		classCRetiros fcsd= new classCRetiros();
		String respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
						
			classJson envio = new classJson();
            classCRetiros claseEnvio = new classCRetiros();
            claseEnvio.fecha = fecha_retiro;
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
			//HttpResponse response = http.send(request);
	    	//respuesta = response.getBody();
            system.debug(respuesta); 
            HttpResponse response;// = http.send(request);
            if(test.isRunningTest())
            {
                respuesta='{"fecha_retiro":null,"fechaSysdeRetiros":"2019-05-21T00:00:00","ListPagosI":[{"tsp":1.1,"tCuenta":"a","referencia":"a","numeroCaso":1.1,"nombreCliente":"a","monTotal":1.1,"montoPatronalCte":1.0,"monRetirar":1.1,"monMovimto":1.1,"moneda":"a","index":1,"idCliente":"a","fPago":"a","fecSYSDE":"2020-04-08T22:08:29.151Z","fecMovimto":"2020-04-08T22:08:29.151Z","cuentaDestino":"a","cuentaBancaria":"a","comparaFecha":1.1,"comparacion":1.0,"codCuenta":"a","ck":1.1,"bancoDestino":"a","ach":1.1}],"ListPagos":[{"referencia":"16374","codCuenta":"42329","nombreCliente":"ANA ELIZABETH OCHOA CALIX","numeroCaso":3176.0,"monMovimto":-1000.0,"monRetirar":-7780.05,"fecMovimto":"2019-05-21T00:00:00","fecSYSDE":"2019-05-21T00:00:00","comparacion":1.0,"fPago":"E","comparaFecha":0.0,"descripcion":null},{"referencia":"16369","codCuenta":"34037","nombreCliente":"CARLOS DAVID ESCOTO CANALES","numeroCaso":3152.0,"monMovimto":-20000.0,"monRetirar":-4970.51,"fecMovimto":"2019-05-21T00:00:00","fecSYSDE":"2019-05-21T00:00:00","comparacion":1.0,"fPago":"AH","comparaFecha":0.0,"descripcion":null},{"referencia":"16379","codCuenta":"42329","nombreCliente":"ANA ELIZABETH OCHOA CALIX","numeroCaso":3178.0,"monMovimto":-3000.0,"monRetirar":-6407.20,"fecMovimto":"2019-05-21T00:00:00","fecSYSDE":"2019-05-21T00:00:00","comparacion":1.0,"fPago":"E","comparaFecha":0.0,"descripcion":null},{"referencia":"16367","codCuenta":"51600","nombreCliente":"WENDY PAOLA ALVARADO AGUILAR","numeroCaso":3139.0,"monMovimto":-10000.0,"monRetirar":-14142.24,"fecMovimto":"2019-05-21T00:00:00","fecSYSDE":"2019-05-21T00:00:00","comparacion":1.0,"fPago":"AH","comparaFecha":0.0,"descripcion":null}],"ListPagosC":[{"referencia":"16390","codCuenta":"44260","nombreCliente":"LILIAM SARAHI RIVERA ALTAMIRANO","numeroCaso":3215.0,"fPago":"E","monMovimto":-5000.0,"monRetirar":5000.0,"montoPatronalCte":0.0,"tsp":10.0,"ach":0.0,"ck":0.0,"monTotal":1990.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16391","codCuenta":"44260","nombreCliente":"LILIAM SARAHI RIVERA ALTAMIRANO","numeroCaso":3217.0,"fPago":"E","monMovimto":-2000.0,"monRetirar":2000.0,"montoPatronalCte":0.0,"tsp":4.0,"ach":0.0,"ck":0.0,"monTotal":1996.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16373","codCuenta":"44260","nombreCliente":"LILIAM SARAHI RIVERA ALTAMIRANO","numeroCaso":3174.0,"fPago":"E","monMovimto":-4000.0,"monRetirar":4000.0,"montoPatronalCte":0.0,"tsp":8.0,"ach":0.0,"ck":0.0,"monTotal":992.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16370","codCuenta":"27280","nombreCliente":"LINA FAVIOLA LAGOS ","numeroCaso":3166.0,"fPago":"E","monMovimto":-50000.0,"monRetirar":50000.0,"montoPatronalCte":0.0,"tsp":100.0,"ach":0.0,"ck":0.0,"monTotal":49900.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16382","codCuenta":"44260","nombreCliente":"LILIAM SARAHI RIVERA ALTAMIRANO","numeroCaso":3194.0,"fPago":"E","monMovimto":-2000.0,"monRetirar":2000.0,"montoPatronalCte":0.0,"tsp":4.0,"ach":0.0,"ck":0.0,"monTotal":496.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16389","codCuenta":"53474","nombreCliente":"GLORIA ESPERANZA GOMEZ RODRIGUEZ","numeroCaso":3212.0,"fPago":"E","monMovimto":-665.0,"monRetirar":665.0,"montoPatronalCte":0.0,"tsp":2.0,"ach":0.0,"ck":0.0,"monTotal":663.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019538","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"USD"},{"referencia":"16371","codCuenta":"27280","nombreCliente":"LINA FAVIOLA LAGOS ","numeroCaso":3168.0,"fPago":"E","monMovimto":-38000.0,"monRetirar":38000.0,"montoPatronalCte":0.0,"tsp":76.0,"ach":0.0,"ck":0.0,"monTotal":37924.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16383","codCuenta":"44260","nombreCliente":"LILIAM SARAHI RIVERA ALTAMIRANO","numeroCaso":3201.0,"fPago":"E","monMovimto":-1000.0,"monRetirar":1000.0,"montoPatronalCte":0.0,"tsp":2.0,"ach":0.0,"ck":0.0,"monTotal":998.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16387","codCuenta":"53474","nombreCliente":"GLORIA ESPERANZA GOMEZ RODRIGUEZ","numeroCaso":3169.0,"fPago":"E","monMovimto":-1000.0,"monRetirar":1000.0,"montoPatronalCte":0.0,"tsp":2.0,"ach":0.0,"ck":0.0,"monTotal":998.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019538","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"USD"},{"referencia":"16386","codCuenta":"27280","nombreCliente":"LINA FAVIOLA LAGOS ","numeroCaso":3207.0,"fPago":"E","monMovimto":-23750.0,"monRetirar":23750.0,"montoPatronalCte":0.0,"tsp":48.0,"ach":0.0,"ck":0.0,"monTotal":23702.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16372","codCuenta":"53474","nombreCliente":"GLORIA ESPERANZA GOMEZ RODRIGUEZ","numeroCaso":3171.0,"fPago":"E","monMovimto":-3000.0,"monRetirar":3000.0,"montoPatronalCte":0.0,"tsp":6.0,"ach":0.0,"ck":0.0,"monTotal":2994.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019538","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"USD"},{"referencia":"16385","codCuenta":"27280","nombreCliente":"LINA FAVIOLA LAGOS ","numeroCaso":3206.0,"fPago":"E","monMovimto":-50000.0,"monRetirar":50000.0,"montoPatronalCte":0.0,"tsp":100.0,"ach":0.0,"ck":0.0,"monTotal":49900.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16384","codCuenta":"44260","nombreCliente":"LILIAM SARAHI RIVERA ALTAMIRANO","numeroCaso":3205.0,"fPago":"E","monMovimto":-3000.0,"monRetirar":3000.0,"montoPatronalCte":0.0,"tsp":6.0,"ach":0.0,"ck":0.0,"monTotal":1494.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16388","codCuenta":"53474","nombreCliente":"GLORIA ESPERANZA GOMEZ RODRIGUEZ","numeroCaso":3210.0,"fPago":"E","monMovimto":-500.0,"monRetirar":500.0,"montoPatronalCte":0.0,"tsp":2.0,"ach":0.0,"ck":0.0,"monTotal":498.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019538","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"USD"},{"referencia":"16369","codCuenta":"34037","nombreCliente":"CARLOS DAVID ESCOTO CANALES","numeroCaso":3152.0,"fPago":"AH","monMovimto":-41617.51,"monRetirar":41617.51,"montoPatronalCte":16647.0,"tsp":60.0,"ach":0.0,"ck":0.0,"monTotal":29940.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"8310138","cuentaDestino":"200007006569","bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16374","codCuenta":"42329","nombreCliente":"ANA ELIZABETH OCHOA CALIX","numeroCaso":3176.0,"fPago":"E","monMovimto":-12542.93,"monRetirar":12542.93,"montoPatronalCte":3762.88,"tsp":8.0,"ach":0.0,"ck":0.0,"monTotal":3992.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16380","codCuenta":"42339","nombreCliente":"IRWIN RICARDO PAVON MONCADA","numeroCaso":3179.0,"fPago":"E","monMovimto":-10379.28,"monRetirar":10379.28,"montoPatronalCte":2594.82,"tsp":0.0,"ach":0.0,"ck":0.0,"monTotal":2594.82,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16381","codCuenta":"42339","nombreCliente":"IRWIN RICARDO PAVON MONCADA","numeroCaso":3180.0,"fPago":"E","monMovimto":-10379.28,"monRetirar":10379.28,"montoPatronalCte":2594.82,"tsp":4.0,"ach":0.0,"ck":0.0,"monTotal":1496.0,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"},{"referencia":"16379","codCuenta":"42329","nombreCliente":"ANA ELIZABETH OCHOA CALIX","numeroCaso":3178.0,"fPago":"E","monMovimto":-12542.93,"monRetirar":12542.93,"montoPatronalCte":3135.73,"tsp":14.0,"ach":0.0,"ck":0.0,"monTotal":6121.73,"fecSYSDE":"2019-05-21T00:00:00","fecMovimto":"2019-05-21T00:00:00","comparacion":0.0,"comparaFecha":0.0,"cuentaBancaria":"200002019441","cuentaDestino":null,"bancoDestino":null,"tCuenta":null,"moneda":"HNL"}],"ListPagosP":[{"referencia":"16380P","numeroCaso":3179.0,"nombreCliente":"BANCO LAFISE S.A.","codCuenta":"42339","fPago":"AH","monRetirar":7784.46,"tsp":16.0,"ach":0.0,"ck":0.0,"monTotal":7768.46,"fecSYSDE":"2019-05-21T00:00:00","moneda":"LPS","cuentaBancaria":"200008211317","cuentaDestino":"200007547667","bancoDestino":"28","tCuenta":null}]}}';
            	fcsd = (classCRetiros)System.JSON.deserialize(respuesta, classCRetiros.class);
            }
            
            else{
                response = http.send(request);
            }
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
           {
                
	            fcsd = (classCRetiros)System.JSON.deserialize(response.getBody(), classCRetiros.class);
               
           }
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return fcsd;   
    }    
    
    public static String pagaRetiros(cuadreRetirosC2 claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/aplicaRetiros');
		
        
		String respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
						
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
			HttpResponse response = http.send(request);
	    	respuesta = response.getBody();
            
            
            
            system.debug(respuesta);      
            system.debug('debuggRespuesta' +''+ respuesta); 
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return respuesta;   
    }
    ///LISTA 
    /*
      public static String pagaRetiros (cuadreRetirosC2 claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
        request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/aplicaRetiros');
        
	    list<classResPagoRetiros> resultado = new list<classResPagoRetiros>();
        
        string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{

            classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
            
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
            
            HttpResponse response = http.send(request);
            respuesta = response.getBody();
            system.debug('Respuesta Sysde '+response.getBody());
            
            if (response.getStatusCode() == 200) 
            {
             
              resultado = (list<classResPagoRetiros>)JSON.deserialize(response.getBody(), list<classResPagoRetiros>.class);
              
              system.debug('ConversionResultadoPrueba2' + resultado);
                
             
            for(integer i=0; i<resultado.size(); i++)
            {
				
           } //Fin del for principal
            
	        } //Fin del if
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
         
		return resultado;   
    }
    
    */   
     public class classResPagoRetiros
    {
        public string mensaje { get; set; }
        public string codReferencia { get; set; }
    }  
}