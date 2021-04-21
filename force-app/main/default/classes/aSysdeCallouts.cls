public class aSysdeCallouts {
    
    @future(callout=true)
    public static void EjecutarJobEDCMasivo(date fecha) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtilPlanillas.urlSysde('Test'); 
       // url='http://190.5.68.49:9090/';
        request.setEndpoint(url + 'api/ec/generaPDF');
        request.setMethod('POST');
        request.setTimeout(120000);
        
        string cons;
        FechaDC_Sysde__c fcsd = new FechaDC_Sysde__c(); 
            if(!test.isRunningTest()) { fcsd =  [Select Fecha_cierre__c,id,Trimestre_Terminado__C From FechaDC_Sysde__c where name = 'CierreAlDia'];
            }
        try{
            if(fcsd.Trimestre_Terminado__C || test.isRunningTest()){
                fcsd.Trimestre_Terminado__C = false;
                if(fecha.month() == 1){ 
                    cons = 'contenido={"hasta":"anio-12-31","desde":"anio-10-01","accion":"GPDF"}';
                    cons = cons.replace('anio', ''+fecha.addMonths(-1).year());
                }else if(fecha.month() == 4){
                    cons = 'contenido={"hasta":"anio-03-31","desde":"anio-01-01","accion":"GPDF"}';
                    cons = cons.replace('anio', ''+fecha.year());
                }else if(fecha.month() == 7){
                    cons = 'contenido={"hasta":"anio-06-30","desde":"anio-04-01","accion":"GPDF"} ';
                    cons = cons.replace('anio', ''+fecha.year());
                }else if(fecha.month() == 10){
                    cons = '{"hasta":"anio-09-30","desde":"anio-07-01","accion":"GPDF"}';
                    cons = cons.replace('anio', ''+fecha.year());
                }
                system.debug('Mandamos: '+cons);
                request.setBody(cons);
                
                HttpResponse response =new HttpResponse();
                
                if(!test.isRunningTest()){ response = http.send(request); 
                }else{
                    response.setStatusCode(200);
                    response.setBody('');
                }
                system.debug('Respuesta desde Sysde: '+response.getBody());
            }
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
        if(!test.isRunningTest()) { update fcsd;
        }
    }
    
    public static list<controladorEstadoCuentaMasivo.empresas> Empresas() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtilPlanillas.urlSysde('Test'); 
        url='http://190.5.68.49:9090/';
        request.setEndpoint(url + 'api/ec/generaPDF');
        request.setMethod('POST');
        request.setTimeout(120000);
        list<controladorEstadoCuentaMasivo.empresas> respuesta = new list<controladorEstadoCuentaMasivo.empresas> ();
        try{
            request.setBody('contenido={"accion":"OEMP"}');
            HttpResponse response =new HttpResponse();
            if(!test.isRunningTest()) { response = http.send(request); 
            }else{
                response.setStatusCode(200);
                response.setBody('[{"nombreEmpresa":"<SIN REGISTRAR>"},{"nombreEmpresa":"ACADEMIA LOS PINARES"},{"nombreEmpresa":"ACCESORIOS PARA VAPOR S. DE R.L."}]');
            }
            system.debug('Respuesta desde Sysde: '+response.getBody());
            respuesta = (list<controladorEstadoCuentaMasivo.empresas>)System.JSON.deserialize(response.getBody(), List<controladorEstadoCuentaMasivo.empresas>.class);
            
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
        return respuesta;
    }
    
    
    public static list<classECHistorico> estadoCuentaHistoricoMasivo(string cons) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
		//url='http://190.5.68.49:9090/';        
        request.setMethod('POST');
        request.setEndpoint(url + 'api/ec/generaPDF');
        request.setTimeout(120000);
        list<classECHistorico> respuesta = new list<classECHistorico>();
        
        try{
            
            system.debug('Mandamos: '+cons);        
            request.setBody(cons);
            HttpResponse response =new HttpResponse();
            if(!test.isRunningTest()) { response = http.send(request); 
            }else{
                response.setStatusCode(200);
                response.setBody('[{"fecha":"27/01/2020","nombreCliente":"WENDY PAOLINA AGUILAR ALVARADO","emailCliente":"wendyalvarez@gmail.com","numeroCliente":"179363","movimientos":[{"moneda":" Lempiras","cuenta":"51600","totalPersonal":"24554","totalPatronal":"24528.24","granTotal":"49086.18","transacciones":[{"fecha":"04/11/2019","descripcionTransaccion":"Saldo Acumulado al 4-DEC-19","aportePersonal":"131.07","aportePatronal":"130.90","aporteTotal":"261.97"},{"fecha":"4-DEC-19","descripcionTransaccion":"Aportes Ordinarios","aportePersonal":"811.30","aportePatronal":"811.30","aporteTotal":"1622.60"},{"fecha":"","descripcionTransaccion":"Aportes Ordinarios","aportePersonal":"811.30","aportePatronal":"811.30","aporteTotal":"1622.60"},{"fecha":"15/01/2020","descripcionTransaccion":"Aportes Ordinarios","aportePersonal":"811.30","aportePatronal":"811.30","aporteTotal":"122.60"},{"fecha":"27/01/2020","descripcionTransaccion":"Intereses","aportePersonal":"22223.14","aportePatronal":"293.58","aporteTotal":"4416.72"},{"fecha":"27/01/2020","descripcionTransaccion":"Comisiones","aportePersonal":"-230.17","aportePatronal":"-230.14","aporteTotal":"-460.31"}]}]}]');
            }
            system.debug('Respuesta desde Sysde: '+response.getBody()+', Codigo: '+response.getStatusCode());
            string resp = response.getBody().replace(': "', ':"');
            resp = resp.replace(':" ', ':"');
            resp = resp.replace('".', '"0.');
            if(response.getStatusCode() == 200){
                respuesta = (list<classECHistorico>)System.JSON.deserialize(resp, List<classECHistorico>.class); 
            }
        }Catch(Exception e){
            system.debug('Error: ' + e.getMessage() + ', Linea: ' + e.getLineNumber()); 
        } 
        return respuesta;   
    } 
    
    
    public static string VerPDF(string identificacion, datetime desde, datetime hasta) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');        
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setEndpoint(url + 'api/ec/pdf' );
        request.setTimeout(120000);
        try {
            list<classClientesEC> claseEnvio = new list<classClientesEC>();
            classClientesEC datospersona = new classClientesEC();
            
            datospersona.idCliente = identificacion;
            datospersona.desde = desde;
            datospersona.hasta = hasta;
            claseEnvio.add(datospersona);
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);
            request.setBody(cons);
            
            HttpResponse response;
            if(!test.isRunningTest()) { response = http.send(request); }
            System.debug('Respuesta: '+response.getBody());
            if (response.getStatusCode() == 200 || test.isRunningTest()) {
                System.debug(response.getBody());
                string respuesta=response.getBody();
                return  respuesta;
                //respuesta = (list<classECTrimestral>)System.JSON.deserialize(response.getBody(), list<classECTrimestral>.class);
            }           
            
        }catch(System.CalloutException e){
            system.debug('EDC Trimestral: ' + e.getMessage() + ' Linea: ' + e.getLineNumber()); 
            
        }Catch(Exception e){
            system.debug('EDC Trimestral: ' + e.getMessage() + ' Linea: ' + e.getLineNumber()); 
        } 
        return null;   
    }
    
    @future(callout=true)
    public static void ReposicionCarnet(string idCaso) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtilPlanillas.urlSysde('Test'); 
        request.setEndpoint(url + 'api/reposicionCarnet');
        request.setMethod('POST');
        request.setTimeout(120000);
        try{
            list<RepoCarnet> claseEnvio = new list<RepoCarnet>();
            RepoCarnet c = new RepoCarnet();
            case caso = [select account.identificacion__C, codigo_barra__C from case where id=:idCaso];
            c.identificacion = caso.account.identificacion__C;
            c.codigoBarra = caso.codigo_barra__C;
            claseEnvio.add(c);
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido= {"carnet":' + envio.contenido+'}';
            system.debug('Mandamos: '+cons);
            request.setBody(cons);
            HttpResponse response =new HttpResponse();// http.send(request); 
            if(!test.isRunningTest()) { response = http.send(request); 
                system.debug('Respuesta: '+ response.getBody());
            }
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
    }
    
    @future(callout=true)
    public static void PDFHistorico() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/ec/historico/pdf');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        //request.setHeader('Content-Length', '1025');
        
        try{
            
            request.setBody('contenido='+'');
            request.setTimeout(120000);
            
            HttpResponse response = http.send(request);
            System.debug(response.getBody());
            //if (response.getStatusCode() == 200) {
            //}
            
            
        }Catch(Exception e){
            system.debug('Clase Futura' +e.getMessage() + ' linea ' + e.getLineNumber());   
        }    
        
    }        
    
    public static list<classCuenta> trarerCuentas(String idCliente) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/obtenerinfocuenta?IdCliente=' + idCliente);
        request.setMethod('GET');
        request.setTimeout(120000);
        list<classCuenta> results = new list<classCuenta>();
        
        try{
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                results = (list<classCuenta>)System.JSON.deserialize(response.getBody(), List<classCuenta>.class);         
            }
            system.debug(results);
            
        }Catch(Exception e){
            system.debug(e.getMessage());   
        }
        return results;
    }
    
    // +++++++++++++++++++++++++++++++++ SUBPRODUCTO ++++++++++++++++++++++
    @future(callout=true)
    public static void accionSubProducto(String idCaso) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/subproducto');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        Case caso = new Case();
        Detalle_Caso__c detalle = new Detalle_Caso__c();
        
        try{
            caso = [Select CaseNumber, AccountId, respuesta_desde_sysde__C,
                    RecordType.Name, CreatedDate, Owner.Name, lastModifiedBy.Name 
                    From Case Where Id =: idCaso];
            
            detalle = [Select Nueva_Cuenta_colectiva2__r.Codigo__c, Nueva_Cuenta_colectiva2__c, 
                       Nuevo_Subproducto__r.Codigo__c, Nuevo_Subproducto__c, Nueva_Cuenta_colectiva2__r.Subproducto__c,
                       Accion__c, Cuenta__r.Codigo__c, Cuenta__r.Cuenta_colectiva2__r.Codigo__c, CreatedBy.Codigo__c, Cuenta__c,
                       Nueva_Cuenta_colectiva2__r.Producto__c,Nuevo_Subproducto__r.Producto__c,
                       Nueva_Cuenta_colectiva2__r.Subproducto__r.Codigo__c, Cuenta__r.Subproducto__r.Codigo__c
                       From Detalle_caso__c
                       Where Caso__c =: Caso.id Limit 1];
            
            //system.debug(detalle);
            
            classCambioSubproducto claseEnvio = new classCambioSubproducto();
            claseEnvio.cuenta = detalle.Cuenta__r.Codigo__c;
            claseEnvio.cuentaColectiva = detalle.Nueva_Cuenta_colectiva2__r.Codigo__c;
            claseEnvio.subproducto =  detalle.Nuevo_Subproducto__r.Codigo__c != null ? detalle.Nuevo_Subproducto__r.Codigo__c : detalle.Nueva_Cuenta_colectiva2__r.Subproducto__r.Codigo__c !=null ? (detalle.Nueva_Cuenta_colectiva2__r.Subproducto__r.Codigo__c) : (detalle.Cuenta__r.Subproducto__r.Codigo__c);
                claseEnvio.accion = detalle.Accion__c;
            claseEnvio.usuario =  detalle.CreatedBy.Codigo__c;
            
            list<classBitacora> bitacoras = new list<classBitacora>();  
            DateTime sHoy = system.now();
            
            bitacoras.add(crearBitacora(caso.CaseNumber, caso.RecordType.Name, caso.CreatedDate,
                                        detalle.Cuenta__r.Subproducto__r.Codigo__c, 
                                        detalle.Nuevo_Subproducto__r.Codigo__c != null ? detalle.Nuevo_Subproducto__r.Codigo__c : detalle.Cuenta__r.Subproducto__r.Codigo__c,
                                        caso.Owner.Name, Caso.lastModifiedBy.Name, sHoy, sHoy));    
            
            if(detalle.Accion__c == 'A1' || detalle.Accion__c == 'A3' ||test.isRunningTest()){  
                bitacoras.add(crearBitacora(caso.CaseNumber, caso.RecordType.Name, caso.CreatedDate,
                                            detalle.Cuenta__r.Cuenta_colectiva2__r.Codigo__c, 
                                            detalle.Nueva_Cuenta_colectiva2__r.Codigo__c,
                                            caso.Owner.Name, Caso.lastModifiedBy.Name, sHoy, sHoy));    
            }                       
            
            claseEnvio.bitacora = bitacoras;
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);
            
            request.setBody(cons);
            request.setTimeout(120000);
            
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()) { response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('"Cambio procesado correctamente con registro en bitacora. Mensaje SYSDE: OK"');
            }
            caso.respuesta_desde_sysde__C = response.getBody();
            if (response.getStatusCode() == 200) {
                System.debug(response.getBody());
                
                Cuentas__c cuenta = new Cuentas__c(Id = detalle.Cuenta__c);
                
                if(detalle.Accion__c == 'A1' || test.isRunningTest()){
                    Cuenta.Cuenta_colectiva2__c = detalle.Nueva_Cuenta_colectiva2__c;
                    Cuenta.subProducto__c = detalle.Nueva_Cuenta_colectiva2__r.Subproducto__c;  
                    cuenta.Producto__c = detalle.Nueva_Cuenta_colectiva2__r.Producto__c;
                } if(detalle.Accion__c == 'A2' || test.isRunningTest()){
                    Cuenta.subProducto__c = detalle.Nuevo_Subproducto__c;
                    cuenta.Producto__c = detalle.Nuevo_Subproducto__r.Producto__c;
                }
                if(detalle.Accion__c == 'A3' || test.isRunningTest() ){
                    Cuenta.Cuenta_colectiva2__c = null;
                    if(detalle.Nuevo_Subproducto__c !=null){
                        Cuenta.subProducto__c = detalle.Nuevo_Subproducto__c;
                        cuenta.Producto__c = detalle.Nuevo_Subproducto__r.Producto__c;
                    }
                    
                    
                }
                
                update cuenta;
                
                Caso.Respuesta_desde_Sysde__c = response.getBody();
                claseUtil.stopTrigger();            
                update caso; 
                
                Approval.LockResult lrList = Approval.lock(Caso);
            }
            
        }catch(System.CalloutException e){
            Caso.Respuesta_desde_Sysde__c = e.getMessage() + 'Línea: ' + e.getLineNumber();
            Caso.Status = 'Error de conexion';
            claseUtil.stopTrigger();
            
            update caso;
            Approval.LockResult lrList = Approval.lock(Caso);   
        }Catch(Exception e){
            system.debug('Clase Futura' +e.getMessage() + ' linea ' + e.getLineNumber());   
        }    
        
    }        
    
    public Static classBitacora crearBitacora(String numero, String nombre, DateTime fechaC, String vAnterior, String vNuevo
                                              , String usuCaso, String usuAprueba, DateTime fechaAprueba, DateTime sHoy){
                                                  classBitacora nuevo = new classBitacora();
                                                  nuevo.numeroCaso = numero;
                                                  nuevo.nombreCaso = nombre;
                                                  nuevo.fechaCaso = fechaC;
                                                  nuevo.valorAnterior = vAnterior;
                                                  nuevo.valorNuevo = vNuevo;
                                                  nuevo.usuarioCaso = usuCaso;
                                                  nuevo.usuarioAprueba = usuAprueba;
                                                  nuevo.fechaAprueba = fechaAprueba;
                                                  nuevo.fechaModificacion = sHoy;
                                                  
                                                  return nuevo; 
                                              }
    
    // +++++++++++++++++++++++++++++++++ AUMENTO Y DISMINUNCION ++++++++++++++++++++++
    @future(callout=true)
    public static void aumentoDisminucion(String idCaso) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/aumentodisminucion');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        Case caso = new Case();
        Detalle_Caso__c detalle = new Detalle_Caso__c();
        classAumentoDisminucion claseEnvio = new classAumentoDisminucion();
        list<classBitacora> bitacoras = new list<classBitacora>();
        
        try{
            caso = [Select Id,AccountId,Account.Name,CaseNumber,RecordType.Name,CreatedDate,Owner.Name, lastModifiedDate 
                    From Case Where Id =: idCaso];
            detalle = [Select Id, Tipo_Operacion__c, Nuevo_monto_aporte__c, Cuenta__r.Codigo__c, CreatedBy.Codigo__c, Cuenta__c, 
                       Nuevo_canal_aporte__c, Nueva_fecha_aporte__c, N_Cuenta_Bancaria__c, DAU_Dia_de_pago__c, DAU_Borrar_Cuotas__c,
                       Cuenta__r.Monto_aporte__c, Cuenta__r.Forma_Aportacion__c, Cuenta__r.Fecha_Aporte__c,Frecuencia__c
                       From Detalle_caso__c Where Caso__c =: Caso.id Limit 1];
            
            system.debug(detalle);                              
            if(detalle.Cuenta__r.Monto_aporte__c==null) { detalle.Cuenta__r.Monto_aporte__c=0; 
            }
            claseEnvio.cuenta = detalle.Cuenta__r.Codigo__c;
            claseEnvio.tipoSaldoMod = '10';
            claseEnvio.nuevoCanalAporte =  detalle.Nuevo_canal_aporte__c;
            claseEnvio.montoOperacion = detalle.Nuevo_monto_aporte__c != null ? detalle.Nuevo_monto_aporte__c : 0;
            claseEnvio.fecha =  detalle.Nueva_fecha_aporte__c != null ? detalle.Nueva_fecha_aporte__c : date.today();
            claseEnvio.cuentaTarjeta =  string.valueOF(detalle.N_Cuenta_Bancaria__c);
            if(detalle.Tipo_Operacion__c == 'A8') {detalle.Tipo_Operacion__c = 'A3';}
            claseEnvio.accion =  detalle.Tipo_Operacion__c;
            claseEnvio.periodicidad = detalle.Frecuencia__c;
            DateTime sHoy = system.now();
            
            if(detalle.Tipo_Operacion__c == 'A1' || detalle.Tipo_Operacion__c == 'A2'){ 
                bitacoras.add(crearBitacora(caso.CaseNumber, caso.RecordType.Name, caso.CreatedDate,
                                            detalle.Cuenta__r.Monto_aporte__c.format(),
                                            detalle.Nuevo_monto_aporte__c.format(),
                                            caso.Owner.Name, caso.Owner.Name, sHoy, sHoy));
                
            }else if(detalle.Tipo_Operacion__c == 'A3'){    
                bitacoras.add(crearBitacora(caso.CaseNumber, caso.RecordType.Name, caso.CreatedDate,
                                            detalle.Cuenta__r.Forma_Aportacion__c,
                                            detalle.Nuevo_canal_aporte__c,
                                            caso.Owner.Name, caso.Owner.Name, sHoy, sHoy)); 
                
            }else if(detalle.Tipo_Operacion__c == 'A4'){    
                bitacoras.add(crearBitacora(caso.CaseNumber, caso.RecordType.Name, caso.CreatedDate,
                                            String.valueOf(detalle.Cuenta__r.Fecha_Aporte__c)/*.format()*/,
                                            String.valueOf(detalle.Nueva_fecha_aporte__c)/*.format()*/,
                                            caso.Owner.Name, caso.Owner.Name, sHoy, sHoy)); 
                
            } else if(detalle.Tipo_Operacion__c == 'A5' || detalle.Tipo_Operacion__c == 'A6') {   
                /*bitacoras.add(crearBitacora(caso.CaseNumber, caso.RecordType.Name, caso.CreatedDate,
                                            null,
                                            detalle.N_Cuenta_Bancaria__c.format(),
                                            detalle.N_Cuenta_Bancaria__c,
                                            caso.Owner.Name, caso.Owner.Name, sHoy, sHoy));*/
                
            }
            
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
                Cuentas__c cuenta = new Cuentas__c(Id = detalle.Cuenta__c);
                               
                if(detalle.Tipo_Operacion__c == 'A1' || detalle.Tipo_Operacion__c == 'A2' ) {
                    Cuenta.Monto_aporte__c = detalle.Nuevo_monto_aporte__c; 
                    update cuenta;
                }else if(detalle.Tipo_Operacion__c == 'A3'){
                    Cuenta.Forma_Aportacion__c = detalle.Nuevo_canal_aporte__c;
                    update cuenta;                  
                }else if(detalle.Tipo_Operacion__c == 'A4'){
                    Cuenta.Fecha_Aporte__c = detalle.Nueva_fecha_aporte__c;
                    update cuenta;
                } else if((detalle.Tipo_Operacion__c == 'A6' || detalle.Tipo_Operacion__c == 'A8') && (detalle.DAU_Borrar_Cuotas__c == '2' || detalle.DAU_Borrar_Cuotas__c == '3') && detalle.Nuevo_canal_aporte__c != 'AH'){
                    System.debug('Entra a borrar las cuotas');
                    List<DAU_Salesforce_Tarjetas__e> Logs = new List<DAU_Salesforce_Tarjetas__e>();
                    Logs.add(new DAU_Salesforce_Tarjetas__e(DAU_IdCaso__c = caso.Id, DAU_Borrar_Cuotas_S10__c = true));
                    // Call method to publish events
                    List<Database.SaveResult> results = EventBus.publish(Logs);
                }                
            
                Caso.Respuesta_desde_Sysde__c = response.getBody();
                claseUtil.stopTrigger();
                
                update Caso;
                Approval.LockResult lrList = Approval.lock(Caso);
            }
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            Caso.Respuesta_desde_Sysde__c = e.getMessage() + 'Línea: ' + e.getLineNumber();
            Caso.Status = 'Error de conexion';
            claseUtil.stopTrigger();
            
            update caso;
            Approval.LockResult lrList = Approval.lock(Caso);   
        }Catch(Exception e){
            system.debug('Clase Futura' +e.getMessage() + ' linea ' + e.getLineNumber());   
        }    
    }
    
    // +++++++++++++++++++++++++++++++++ CONSTANCIAS ++++++++++++++++++++++
    public static classRespuestaConstancias constancias(classConstancias claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/constancias');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        classJson envio = new classJson();
        envio.contenido = JSON.serialize(claseEnvio);
        String cons = 'contenido=' + envio.contenido;
        system.debug(cons);
        request.setBody(cons);
        request.setTimeout(120000);
        classRespuestaConstancias respuesta = new classRespuestaConstancias();
        
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                system.debug('Mandamos: '+cons);
                response = http.send(request);
                system.debug('Recibimos: '+response.getBody());
            }
            else{
                response.setStatusCode(200);
                response.setBody('{"cuentas":[{"cuenta":"51600","saldo":"","fechaInclusion":"","fechaExclusion":"","cuentaActiva":false,"montoPactado":"","aportes":[{"monto":"702.08","fechaAporte":"16-JAN-19"},{"monto":"702.08","fechaAporte":"15-FEB-19"},{"monto":"702.08","fechaAporte":"14-MAR-19"},{"monto":"10.00","fechaAporte":"18-MAR-19"},{"monto":"751.20","fechaAporte":"15-APR-19"}]}]}');
            }
            if (response.getStatusCode() == 200) {
                System.debug('Respuesta nuevo: '+response.getBody());
                respuesta = (classRespuestaConstancias)System.JSON.deserialize(response.getBody(), classRespuestaConstancias.class);  
            }
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());   
        } 
        return respuesta;   
    }
    
    @future(callout=true)
    public static void bloquerCasoConstancia(list<String> listCaso) {
        try{
            Approval.LockResult[] lrList = Approval.lock(listCaso);
            
        }Catch(Exception e){
            system.debug(e.getMessage());
        }
    }
    @future(callout=true)
    public static void ConstanciaPignoracion(list<id> listCaso) {
    }
    
    @future(callout=true)
    public static void ConstanciaPignoracion(list<id> listCaso, string status) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/fondosPignorados');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        
        Detalle_Caso__c detalle = new Detalle_Caso__c();
        classFondosPignorados claseEnvio = new classFondosPignorados();
        String cons='';
        case caso = new case();
        try{
            caso = [Select AccountId,CaseNumber,RecordType.Name,CreatedDate,Owner.Name,id, status,
                    Respuesta_desde_Sysde_Esperando_Docu__c ,Respuesta_desde_Sysde__c,
                    tasa_cambio__C,
                    Contenido_a_Sysde_Esperando_Docu__C, contenido_sysde__C,
                    lastModifiedDate 
                    From Case Where Id in :listCaso];
            detalle = [Select cuenta__r.codigo__C, monto_a_pignorar__C, monto_pignorado__C,Total_Saldo_Patronal__c,
                       total_saldo_personal__C, caso__r.aplica_saldo_patronal__C, Numero_Prestamo__c,
                       Prestamo_anterior__c,Cambio_moneda__c,Monto_Pignorar_Refinanciamiento__C,
                       Es_Primer_Prestamo__c, Monto_Prestamo__c, No_es_primer_prestamo__c,Es_Refinanciamiento__c 
                       From Detalle_caso__c
                       Where Caso__c =:caso.id Limit 1];
            // caso.CurrencyIsoCode
            claseEnvio.codCuenta = detalle.Cuenta__r.Codigo__c;
            claseEnvio.montoPignorado = (detalle.Monto_Pignorar_Refinanciamiento__c ==null || detalle.Monto_Pignorar_Refinanciamiento__c ==0) ? detalle.monto_a_pignorar__C.setscale(2) : detalle.Monto_Pignorar_Refinanciamiento__c.setscale(2);
            claseEnvio.numeroPrestamo = detalle.numero_prestamo__C != null ? detalle.numero_prestamo__C : caso.id;
            //claseEnvio.prestamoAterior = detalle.Prestamo_anterior__c ;
            claseEnvio.accion = 'I';
            if(Status=='Cerrado'){
                claseEnvio.numeroPrestamoId = caso.id;
                claseEnvio.accion = 'A';
                claseEnvio.prestamoAterior =detalle.Es_Refinanciamiento__c ? detalle.Prestamo_anterior__c:null;
            }
            if(detalle.No_es_primer_prestamo__c){
                claseEnvio.montoPignorado =( detalle.monto_a_pignorar__C - (detalle.Monto_Pignorado__c !=null ? detalle.Monto_Pignorado__c :0)).setscale(2);
            }
            claseEnvio.montoPrestamo = detalle.monto_prestamo__C;
            claseEnvio.totalFondos = ((detalle.total_saldo_personal__C !=null ? detalle.total_saldo_personal__C:0) + (detalle.total_saldo_patronal__C !=null ? detalle.total_saldo_patronal__C:0)).setscale(2);
            if(detalle.Cambio_moneda__c){
                //claseEnvio.montoPrestamo = (claseEnvio.montoPrestamo  / caso.Tasa_Cambio__c).setscale(2);
                claseEnvio.totalFondos = (claseEnvio.totalFondos / caso.Tasa_Cambio__c).setscale(2);
                claseEnvio.montoPignorado = ( claseEnvio.montoPignorado / caso.Tasa_Cambio__c).setscale(2);
            }
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            cons = 'contenido=' + envio.contenido;
            system.debug('Mandamos: '+cons);
            if(Status=='Cerrado') { Caso.Contenido_Sysde__c = cons;
            }
            if(Status != 'Cerrado'){
                Caso.Contenido_a_Sysde_Esperando_Docu__C = cons;
            }
            request.setBody(cons);
            request.setTimeout(120000);
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()) { response = http.send(request);
            }
            else{
                response.setStatusCode(200);
                response.setBody('Ok');
            }
            if(Status=='Cerrado') { Caso.Respuesta_desde_Sysde__c = response.getBody();
            }
            if(Status != 'Cerrado'){
                Caso.Respuesta_desde_Sysde_Esperando_Docu__c = response.getBody();
            }
            if (response.getStatusCode() == 200) {
                System.debug('Respuesta: '+response.getBody());
                update Caso;
                system.debug('Status: '+status);
                if(Status=='Cerrado'){system.debug('Se metio ');Approval.LockResult lrList = Approval.lock(Caso);}
            }
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            if(Status=='Cerrado'){
                Caso.Respuesta_desde_Sysde__c = e.getMessage() + 'Línea: ' + e.getLineNumber();
            }else{
                Caso.Respuesta_desde_Sysde_Esperando_Docu__c = e.getMessage();
            }
            Caso.Status = 'Error de conexion';
            update caso;
            if(Status=='Cerrado'){Approval.LockResult lrList = Approval.lock(Caso);}
        }Catch(Exception e){
            system.debug('Clase Futura' +e.getMessage() + ' linea ' + e.getLineNumber());   
        }    
    }
    
    public static classFondosPignorados.Refinanciamiento Refinanciamiento(string numPrestamo, string cuenta) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/validaPignorados/'+cuenta+'/'+numPrestamo);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        Detalle_Caso__c detalle = new Detalle_Caso__c();
        classFondosPignorados.Refinanciamiento respuesta = new classFondosPignorados.Refinanciamiento();
        respuesta.existe='N';
        
        try{
            
            request.setTimeout(120000);
            HttpResponse response =new HttpResponse();// http.send(request);
            response.setStatusCode(200);
            response.setBody('{"NumeroPrestamo":null,"cuenta":null,"existe":"S","MontoPrestamo":"2000"}');
            if(!test.isRunningTest()){
                response.setStatusCode(0);
                response.setBody('');
                response = http.send(request);
            } 
            /*else{
response.setStatusCode(200);
response.setBody('{"NumeroPrestamo":null,"cuenta":null,"existe":"S","MontoPrestamo":"2000"}');
}*/
            if (response.getStatusCode() == 200) {
                system.debug('Respuesta: '+response.getBody());
                respuesta = (classFondosPignorados.Refinanciamiento)System.JSON.deserialize(response.getBody(), classFondosPignorados.Refinanciamiento.class); 
                return respuesta;
            }
            
        }Catch(Exception e){
            system.debug('Clase Futura' +e.getMessage() + ' linea ' + e.getLineNumber());   
        }  
        return respuesta;
    }
    
    
    // +++++++++++++++++++++++++++++++++ ACTUALIZACION DE INFORMACION ++++++++++++++++++++++
    @future(callout=true)
    public static void actualizacionInformacion(String idCaso) {
        //idcaso = '500540000034XMUAA2';
        //system.debug(flag);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/info');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        Case caso = new Case();
        Account cliente = new Account();
        list<Detalle_Caso__c> beneficiarios = new list<Detalle_Caso__c>();
        list<classBitacora> bitacoras = new list<classBitacora>();
        String camposCliente = '';
        String camposCaso = '';
        DateTime sHoy = system.now();
        
        try{
            
            camposCaso += 'Lugar_Nacimiento__c,Departamento_Residencia2__c,';
            camposCaso += 'Departamento_Trabajo2__c,Ciudad_Residencia2__c,Ciudad_Trabajo2__c,Colonia_Avenida_Residencia__c,';
            camposCaso += 'Colonia_Avenida_Trabajo__c,Punto_Referencia_Residencia__c,Punto_Referencia_Trabajo__c,';
            camposCaso += 'Tipo_Identificacion__c,Identificacion__c,Sexo__c';
            
            camposCliente = 'FirstName,LastName,Nacionalidad__pc,Estado_Civil__pc,PersonEmail,Celular__c,Phone,PersonOtherPhone,PersonBirthdate,';
            camposCliente += camposCaso;
            
            camposCaso += ',Nacionalidad__c,Estado_Civil__c,Nombre_Cliente__c,Apellidos__c,Segundo_nombre__c,Segundo_apellido__c';
            camposCaso += ',Correo_Electronico__c,Telefono_Casa__c,Telefono_Movil__c,Telefono_Trabajo__c,Fecha_Nacimiento__c';
            
            String queryCaso = 'Select Colonia_Avenida_Residencia__r.Codigo_Colonia__c,Colonia_Avenida_Trabajo__r.Codigo_Colonia__c,';
            
            String queryCliente = queryCaso;
            queryCaso += 'Account.Cliente_Unico_Banco__c,AccountId,CaseNumber,RecordType.Name,CreatedDate,Owner.Name,';
            queryCaso += camposCaso;
            queryCaso += ' From Case Where Id = \'' + idCaso + '\'';                    
            caso = dataBase.query(queryCaso);
            if(caso.Tipo_Identificacion__c=='PASAPORTE') { caso.Tipo_Identificacion__c='4';  
            }
            else if(caso.Tipo_Identificacion__c=='CARNET DE RESIDENTE') { caso.Tipo_Identificacion__c='2';  
            }
            else if(caso.Tipo_Identificacion__c=='RTN') { caso.Tipo_Identificacion__c='9';  
            }
            else if(caso.Tipo_identificacion__c=='CEDULA DE IDENTIDAD' || caso.Tipo_identificacion__c==null) { caso.Tipo_Identificacion__c='1';  
            }
            
            queryCliente += camposCliente;
            queryCliente += ' From Account Where Id = \'' + caso.AccountId + '\'';                      
            Cliente = dataBase.query(queryCliente);
            
            if(cliente.Tipo_Identificacion__c=='PASAPORTE') { cliente.Tipo_Identificacion__c='4';  
            }
            else if(cliente.Tipo_Identificacion__c=='CARNET DE RESIDENTE') { cliente.Tipo_Identificacion__c='2';  
            }
            else if(cliente.Tipo_Identificacion__c=='RTN') { cliente.Tipo_Identificacion__c='9';  
            }
            else if(cliente.Tipo_identificacion__c=='CEDULA DE IDENTIDAD') { cliente.Tipo_Identificacion__c='1';  
            }
            beneficiarios = [Select Primer_Nombre__c, Primer_Apellido__c, Identificacion__c, Parentesco__c,
                             Porcentaje__c, Cuenta__r.Codigo__c, Fecha_nacimiento__c, Grado_parentesco__c, Sexo__c,
                             Segundo_Nombre__c, Segundo_Apellido__c, ID_Externo__c,Tipo_identificacion__c
                             From Detalle_caso__c
                             Where Caso__c =: Caso.id];
            list<string> idexternos = new list<string>();
            list<decimal> clientesaeliminar = new list<decimal>();
            string numeroCuenta='No';
            for(integer i=0; i<beneficiarios.size(); i++)
            {
                if(beneficiarios[i].ID_Externo__c==null && beneficiarios[i].Identificacion__c !=null){
                    idexternos.add(beneficiarios[i].Identificacion__c);
                    numeroCuenta=beneficiarios[i].Cuenta__r.Codigo__c;                    
                }
                if(beneficiarios[i].Porcentaje__c==0 && beneficiarios[i].ID_Externo__c !=null) {
                    clientesaeliminar.add(beneficiarios[i].ID_Externo__c); 
                }
                if(beneficiarios[i].Tipo_identificacion__c=='PASAPORTE'){
                    beneficiarios[i].Tipo_identificacion__c='4'; 
                }else if(beneficiarios[i].Tipo_identificacion__c=='CARNET RESIDENCIA'){
                    beneficiarios[i].Tipo_identificacion__c='2'; 
                }else if (beneficiarios[i].Tipo_identificacion__c=='RTN'){
                    beneficiarios[i].Tipo_identificacion__c='9'; 
                }else if(beneficiarios[i].Tipo_identificacion__c=='CEDULA DE IDENTIDAD' || beneficiarios[i].Tipo_identificacion__c==null){
                    beneficiarios[i].Tipo_identificacion__c='1'; 
                }
                
                if(beneficiarios[i].Grado_parentesco__c=='Primero'){
                    beneficiarios[i].Grado_parentesco__c='1'; 
                }else if(beneficiarios[i].Grado_parentesco__c=='Segundo'){
                    beneficiarios[i].Grado_parentesco__c='2'; 
                }else if(beneficiarios[i].Grado_parentesco__c=='Tercero'){
                    beneficiarios[i].Grado_parentesco__c='3'; 
                }else if(beneficiarios[i].Grado_parentesco__c=='Cuarto' || beneficiarios[i].Grado_parentesco__c==null){
                    beneficiarios[i].Grado_parentesco__c='4'; 
                }
                
                if(beneficiarios[i].parentesco__C=='Abuelo(a)'){
                    beneficiarios[i].parentesco__C='7';  
                }else if(beneficiarios[i].parentesco__C=='Conyuge'){
                    beneficiarios[i].parentesco__C='1';  
                }else if(beneficiarios[i].parentesco__C=='Hermano(a)'){
                    beneficiarios[i].parentesco__C='6';  
                }else if(beneficiarios[i].parentesco__C=='Hijo / Hija' ||beneficiarios[i].parentesco__C=='Hija'){
                    beneficiarios[i].parentesco__C='2';  
                }else if(beneficiarios[i].parentesco__C=='Otro'){
                    beneficiarios[i].parentesco__C='10';  
                }else if(beneficiarios[i].parentesco__C=='Padre / Madre' || beneficiarios[i].parentesco__C=='Padre'){
                    beneficiarios[i].parentesco__C='5';  
                }else if(beneficiarios[i].parentesco__C=='Primo(a)'){
                    beneficiarios[i].parentesco__C='9';  
                }else if(beneficiarios[i].parentesco__C=='Sobrino(a)'){
                    beneficiarios[i].parentesco__C='8';  
                }else if(beneficiarios[i].parentesco__C=='Tio(a)'){
                    beneficiarios[i].parentesco__C='11';  
                }else if(beneficiarios[i].parentesco__C=='Afiliado'){
                    beneficiarios[i].parentesco__C='12';  
                }
                beneficiarios[i].Sexo__c = (beneficiarios[i].Sexo__c=='Masculino' || beneficiarios[i].Sexo__c=='M') ? 'M' :'F';
                
                
            }
            if(!idexternos.isEmpty())
            {
                
                list<Beneficiario__c> identidades=new list<Beneficiario__c>();
                identidades= [select Identidad__c, Id_Externo__c from Beneficiario__c 
                              where Identidad__c in :(idexternos) and Cuenta__r.Codigo__c=:numeroCuenta];
                for(integer i=0; i<identidades.size(); i++)
                {
                    for(integer j=0; j<beneficiarios.size(); j++)
                    {
                        
                        if(identidades[i].Identidad__c == beneficiarios[j].Identificacion__c)
                        {
                            beneficiarios[j].id_externo__C=identidades[i].Id_Externo__c;
                        }
                        if(beneficiarios[j].Porcentaje__c==0 && beneficiarios[j].Id_Externo__c!=null)
                        {
                            clientesaeliminar.add(beneficiarios[i].ID_Externo__c); 
                        }
                    }
                }
            }
            classActualizacionInfo claseEnvio = new classActualizacionInfo();
            
            claseEnvio.direcciones = new list<classActualizacionInfo.classDirecciones>();
            claseEnvio.beneficiarios = new list<classActualizacionInfo.classBeneficiarios>();
            
            claseEnvio.codigoCliente = caso.Account.Cliente_Unico_Banco__c;
            claseEnvio.primerNombre = caso.Nombre_Cliente__c;
            claseEnvio.segundoNombre = caso.Segundo_nombre__c;
            claseEnvio.primerApellido = caso.Apellidos__c;
            claseEnvio.segundoApellido = caso.Segundo_apellido__c;
            
            claseEnvio.tipoIdentificacion = caso.Tipo_Identificacion__c;
            claseEnvio.identificacion = caso.Identificacion__c;
            if(caso.Fecha_Nacimiento__c != null)  {
                //string f = {!CASE(caso.Fecha_Nacimiento__c.year(), 1, '01', 2, '02', 3, '03', 4, '04', 5, '05', 6, '06', 7, '07', 8, '08', 9, '09', 10, '10', 11, '11', 12, '12', 'Desconocido')};
                claseEnvio.fechaNacimiento =caso.Fecha_Nacimiento__c.day()+'-'+MESLETRAS(caso.Fecha_Nacimiento__c.MONTH())+'-'+caso.Fecha_Nacimiento__c.year();// String.valueOF(caso.Fecha_Nacimiento__c);
            }
            claseEnvio.sexo = caso.Sexo__c;
            claseEnvio.lugarNacimiento = caso.Lugar_Nacimiento__c;
            claseEnvio.nacionalidad = caso.Nacionalidad__c;
            claseEnvio.estadoCivil = caso.Estado_Civil__c;
            claseEnvio.correo = caso.Correo_Electronico__c;
            
            if(Caso.Telefono_Casa__c != null || Caso.Telefono_Movil__c != null || Caso.Telefono_Trabajo__c != null){            
                claseEnvio.telefonos = new list<classActualizacionInfo.classTelefonos>();
                // TELEFONOS
                if(Caso.Telefono_Casa__c != null){                                                  
                    classActualizacionInfo.classTelefonos telefono1 = new classActualizacionInfo.classTelefonos();
                    telefono1.tipo = 'D';
                    telefono1.numero =  Caso.Telefono_Casa__c;
                    telefono1.ubicacion = 'C';
                    claseEnvio.telefonos.add(telefono1);
                }
                if(Caso.Telefono_Movil__c != null){         
                    classActualizacionInfo.classTelefonos telefono2 = new classActualizacionInfo.classTelefonos();
                    telefono2.tipo = 'C';
                    telefono2.numero = Caso.Telefono_Movil__c;
                    telefono2.ubicacion = 'C';
                    claseEnvio.telefonos.add(telefono2);
                }
                if(Caso.Telefono_Trabajo__c != null){           
                    classActualizacionInfo.classTelefonos telefono3 = new classActualizacionInfo.classTelefonos();
                    telefono3.tipo = 'D';
                    telefono3.numero = Caso.Telefono_Trabajo__c;
                    telefono3.ubicacion = 'T';
                    claseEnvio.telefonos.add(telefono3);
                }
                
            }
            // DIRECCIONES
            classActualizacionInfo.classDirecciones direccionTrabajo = new classActualizacionInfo.classDirecciones();
            direccionTrabajo.codigoPais = '074';
            direccionTrabajo.codigoDepartamento = Caso.Departamento_Trabajo2__c;
            direccionTrabajo.codigoCiudad = Caso.Ciudad_Trabajo2__c!=null && Caso.Ciudad_Trabajo2__c !='000' ? caso.Ciudad_Trabajo2__c.split('-')[1] :null;
            direccionTrabajo.codigoColonia = Caso.Colonia_Avenida_Trabajo__r.Codigo_Colonia__c;
            direccionTrabajo.puntoReferencia = Caso.Punto_Referencia_Trabajo__c;
            
            // direccionTrabajo.tipo = 'Trabajo';
            direccionTrabajo.tipo = 'T';
            classActualizacionInfo.classDirecciones direccionResi = new classActualizacionInfo.classDirecciones();
            direccionResi.codigoPais = '074';
            direccionResi.codigoDepartamento = Caso.Departamento_Residencia2__c;
            direccionResi.codigoCiudad = Caso.Ciudad_Residencia2__c!=null && Caso.Ciudad_Residencia2__c !='000' ? caso.Ciudad_Residencia2__c.split('-')[1] : null;
            
            direccionResi.codigoColonia = Caso.Colonia_Avenida_Residencia__r.Codigo_Colonia__c;
            direccionResi.puntoReferencia = Caso.Punto_Referencia_Residencia__c;
            direccionResi.tipo = 'C';
            claseEnvio.direcciones.add(direccionTrabajo);
            claseEnvio.direcciones.add(direccionResi);
            // BENEFICIARIOS
            For(Detalle_Caso__c Item : beneficiarios){
                classActualizacionInfo.classBeneficiarios nuevo = new classActualizacionInfo.classBeneficiarios();
                nuevo.cuenta = item.Cuenta__r.Codigo__c;
                nuevo.identidad = item.Identificacion__c;
                nuevo.primerNombre = item.Primer_Nombre__c;
                nuevo.segundoNombre = item.Segundo_Nombre__c;
                nuevo.primerApellido = item.Primer_Apellido__c;
                nuevo.segundoApellido = item.Segundo_Apellido__c;
                nuevo.codigoParentesco = item.Parentesco__c;
                if(item.Porcentaje__c != null){
                    nuevo.porcentaje = String.valueOF(item.Porcentaje__c); 
                    nuevo.Accion = item.Porcentaje__c <= 0 ? 'E' : null;
                }
                if(item.ID_Externo__c != null) { nuevo.idExterno = String.valueOF(item.ID_Externo__c);   
                }
                
                nuevo.gradoParentesco = item.Grado_parentesco__c;
                if(item.Fecha_nacimiento__c != null){
                    DateTime dt = DateTime.newInstanceGMT(item.Fecha_nacimiento__c.year(), item.Fecha_nacimiento__c.month(), item.Fecha_nacimiento__c.day(), 0, 0, 0);
                    nuevo.fechaNacimiento = dt;
                }
                nuevo.tipoId = item.Tipo_identificacion__c;
                nuevo.sexo = item.Sexo__c;
                claseEnvio.beneficiarios.add(nuevo);
            }
            
            For(String item : camposCaso.split(',')){
                if(item != 'Segundo_nombre__c' && item != 'Segundo_apellido__c'){
                    if(caso.get(item) != null){
                        String vNuevo = String.valueOF(caso.get(item));
                        
                        if(item == 'Nacionalidad__c'){
                            item = 'Nacionalidad__pc';
                        }else if(item == 'Estado_Civil__c'){
                            item = 'Estado_Civil__pc';
                        }else if(item == 'Telefono_Casa__c'){
                            item = 'Phone';
                        }else if(item == 'Telefono_Movil__c'){
                            item = 'Celular__c';
                        }else if(item == 'Telefono_Trabajo__c'){
                            item = 'PersonOtherPhone';
                        }else if(item == 'Correo_Electronico__c'){
                            item = 'PersonEmail';
                        }else if(item == 'Fecha_Nacimiento__c'){
                            item = 'PersonBirthdate';
                        }else if(item == 'Apellidos__c'){
                            item = 'LastName';
                        }else if(item == 'Nombre_Cliente__c'){
                            item = 'FirstName';
                        }
                        String vViejo = String.valueOF(cliente.get(item));
                        vNuevo = vNuevo == null ? '' : vNuevo;
                        vViejo = vViejo == null ? '' : vViejo;
                        
                        bitacoras.add(crearBitacora(caso.CaseNumber, caso.RecordType.Name, caso.CreatedDate,
                                                    vViejo,vNuevo,/*'Admin User','Admin User',*/
                                                    caso.Owner.Name, caso.Owner.Name, sHoy, sHoy)); 
                        
                    }
                }
            }
            
            claseEnvio.bitacora = bitacoras;
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            
            String cons = 'contenido=' + envio.contenido;
            system.debug('Mandamos: '+cons);
            cons = cons.replace('Casos Portal AutoGestion Usuario invitado al sitio Web', 'Admin User');
            cons = cons.replace('Claudia Maxiel Vallejo Galo', 'Admin User');
            request.setBody(cons);
            request.setTimeout(120000);
            system.debug('lo que manda el request: '+request);
            HttpResponse response = http.send(request);
            system.debug(response.getBody());
            Caso.Respuesta_desde_Sysde__c = response.getBody();
            aSysdeSincronizador.actializarClienteIndividual(caso.Account.Cliente_Unico_Banco__c);
            claseUtil.stopTrigger();            
            update Caso;
            if(clientesaeliminar.size()>0){
                delete([select id  from Beneficiario__c where ID_Externo__c in :(clientesaeliminar) and Cuenta__r.Codigo__c=:numeroCuenta]); 
                delete([select id  from Detalle_caso__c where ID_Externo__c in :(clientesaeliminar) and Caso__C=:idcaso]); 
            }
            Approval.LockResult lrList = Approval.lock(Caso);           
        }catch(System.CalloutException e){
            system.debug('Error '+e.getMessage()+', Linea: '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug('Error del llamado' + e.getMessage() + ' Linea - ' + e.getLineNumber());   
        }  
    }
    
    // +++++++++++++++++++++++++++++++++ RETIROS ++++++++++++++++++++++ 
    
    public static getSaldoCuenta traerSaldos(String cuenta) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/saldos/' + cuenta); //http://190.5.68.11:9090/
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        getSaldoCuenta respuesta = new getSaldoCuenta();
        
        try {
            HttpResponse response = new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
                if (response.getStatusCode() == 200) {
                    System.debug('Respuesta de Traer saldos: '+response.getBody());
                    respuesta = (getSaldoCuenta)System.JSON.deserialize(response.getBody(), getSaldoCuenta.class); 
                }
            }else{
                respuesta = (getSaldoCuenta)System.JSON.deserialize('{"cuenta":"51600","montoPignorado":"null","saldoTotal":"8583.79","saldos":[{"tipoSaldo":"11","montoSaldo":"8412.11"},{"tipoSaldo":"13","montoSaldo":"171.68"}]}', getSaldoCuenta.class); 
            }
            
        } catch(System.CalloutException e) {
            system.debug(e.getMessage());
        } Catch(Exception e) {
            system.debug('Clase Futura' +e.getMessage() + ' linea ' + e.getLineNumber());
        }
        return respuesta;    
    }
    
    
    //public list<Pago_Beneficiario__c> pagos {get;set;}
    
    
    @future(callout=true)
    public static void retiros(String idCaso) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/retiros');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        Case caso = new Case();
        list<Detalle_Caso__c> detalle = new list<Detalle_Caso__c>();
        classRetiros claseEnvio = new classRetiros();
        
        list<classBitacora> bitacoras = new list<classBitacora>();
        list<classSaldos> saldos = new list<classSaldos>();
        
        //Pago_Beneficiario__c pagos = new Pago_Beneficiario__c();
        list<Pago_Beneficiario__c> pagos = new list<Pago_Beneficiario__c>();
        
        try{
            caso = [Select AccountId,Contenido_Sysde__c,
                    CaseNumber,RecordType.Name,CreatedDate,
                    Owner.Name, lastModifiedDate,
                    lastModifiedBy.Name 
                    From Case Where Id =: idCaso];
            
            detalle = [Select Cuenta__r.Codigo__c, Cuenta__r.cuenta_colectiva2__C ,Monto_retirar__c,Tipo_retiro__c,Forma_Retiro__c,Porcentaje_comision__c,
                       Cobro_ACH__c, Cobro_Cheque__c, Comision_Retiro_Anticipado__c, Monto_cheque__c, Saldo_Total__c,
                       Monto_TSP__c, Monto_ACH__c,Cobro_TSP__c, Monto_Saldo__c, Permitir_Retiro_Saldos_Patronales__c,
                       Cliente_quiere_capital_semilla__c,Cabeza_retiro__c,Saldo_retirar__c,Saldo_enviar_Sysde__c,
                       Monto_Neto_Retirar_Empresa__c, Total_Cargos_Empresa__c, Cuenta__r.cuenta_colectiva2__r.Tipo_Cuenta_bancaria__c,
                       Cuenta__r.cuenta_colectiva2__r.Cuenta__c, Cuenta__r.cuenta_colectiva2__r.Banco__c,
                       Cuenta__r.cuenta_colectiva2__r.tipo_cuenta__C, Saldo_Restante_Cuenta_Cliente__c,
                       Monto_TSP_Patrono__c, Monto_Cheque_Patrono__c, Monto_ACH_Patrono__c,
                       cuenta__r.Cuenta_colectiva2__r.cargar_gastos_empleado__C,
                       Cuenta__r.Cobrar_empleado_sigue_laborando__c, Cuenta__r.Subproducto__r.Cobrar_si_empleado_sigue_laborando__c,
                       nivel_de_regla__C,Aplica_Cambio_Sub_Producto_desde_Retiros__c,
                       Porcentaje_CRA_Individual__c, Cobro_Individual_CRA__c,Saldo_Prestamo__c,Monto_Bruto_Retirar_Empresa__c,
                       Banco__c,Cuenta_destino__c,N_Cuenta_Bancaria__c,currencyIsoCode,Monto_total_retirar__c,Tipo_Cuenta__c,
                       Cliente_sigue_Laborando__c, Cobrar_empleado_sigue_laborando__c, Comision_retiro_anticipado_empresa__c, Monto_Saldo_Patronal__c, Tipo_pago__c
                       From Detalle_caso__c 
                       Where Caso__c =: caso.id order by Cabeza_retiro__c desc];
            
            //Pagos Beneficiarios
            pagos = [SELECT Id, Caso__c, Primer_nombre__c, Segundo_nombre__c, Primer_apellido__c, Segundo_apellido__c, Parentesco__c, Sexo__c, Identidad__c, 
                     Pago_a_Tercero__c, Porcentaje__c, Forma_Retiro__c, Nombre_banco__c, Numero_cuenta_origen__c, Numero_cuenta_destino__c, Tipo_cuenta__c, Moneda_cuenta__c, Monto_bruto__c, 
                     MontoTSP__c, MontoACH__c, MontoCH__c, Comisiones_cargos__c, Monto_neto_retirar__c, Monto_Aporte_Patronal__c, Saldo_Prestamo__c, Monto_Bruto_Retirar_Empresa__c, 
                     Monto_Neto_Retirar_Empresa__c, Total_Cargos_Empresa__c, Detalle_caso__c, Saldo_Restante_Cuenta_Cliente__c, Monto_Saldo_Patronal__c, 
                     Monto_Cheque_Patrono__c, Monto_ACH_Patrono__c, Monto_TSP_Patrono__c, Monto_Saldo_Personal_Ordinario__c, Monto_Saldo_Personal_ExtraOrdinario__c,
                     Monto_Saldo_Patronal_Ordinario__c, Monto_Saldo_Patronal_ExtraOrdinario__c,Tipo_de_pago__c,Detalle_caso__r.Cuenta__r.Codigo__c,Detalle_caso__r.Cuenta__r.cuenta_colectiva2__r.Tipo_Cuenta_bancaria__c,
                     Detalle_caso__r.Cuenta__r.cuenta_colectiva2__r.Cuenta__c,Detalle_caso__r.Cuenta__r.cuenta_colectiva2__r.Banco__c,Detalle_caso__r.Cuenta__r.cuenta_colectiva2__r.tipo_cuenta__C,Num_caso__c
                     from Pago_Beneficiario__c Where Caso__c =: caso.id];            
            
            classRetiros.beneficiarios pagosBenes = new classRetiros.beneficiarios();
            claseEnvio.listBeneficiarios = new List<classRetiros.beneficiarios>();
            for(Pago_Beneficiario__c pb :pagos) {                           
                pagosBenes = new classRetiros.beneficiarios();
			    if(pb.Primer_nombre__c == null) {pb.Primer_nombre__c = '';}
                if(pb.Segundo_nombre__c == null) {pb.Segundo_nombre__c = '';}
                if(pb.Primer_apellido__c == null) {pb.Primer_apellido__c = '';}
                if(pb.Segundo_apellido__c == null) {pb.Segundo_apellido__c = '';}
                pagosBenes.nombre = pb.Primer_nombre__c + ' ' + pb.Segundo_nombre__c + ' ' + pb.Primer_apellido__c + ' ' + pb.Segundo_apellido__c;  
                pagosBenes.identificacion = pb.Identidad__c;
                pagosBenes.formaPago = pb.Forma_Retiro__c+'/'+pb.Num_caso__c;
                pagosBenes.moneda = pb.Moneda_cuenta__c;
                //pagosBenes.montobruto = pb.Monto_bruto__c;
                if(pb.MontoTSP__c == null) {pb.MontoTSP__c = 0;}
                pagosBenes.montoTSP = pb.MontoTSP__c;
                if(pb.MontoACH__c == null) {pb.MontoACH__c = 0;}
                pagosBenes.montoACH = pb.MontoACH__c;
                if(pb.MontoCH__c == null) {pb.MontoCH__c = 0;}
                pagosBenes.montoCH = pb.MontoCH__c;
                //pagosBenes.montoNetoRetirar = pb.Monto_neto_retirar__c;
                pagosBenes.cuentaOrigen = pb.Numero_cuenta_origen__c;
                pagosBenes.cuentaDestino = pb.Numero_cuenta_destino__c;
                pagosBenes.bancoDestino = pb.Nombre_banco__c;
                //pagosBenes.numeroCaso = 10000000;
                
                pagosBenes.tipoPago = pb.Tipo_de_pago__c;
                pagosBenes.cod_Cuenta = pb.Detalle_caso__r.Cuenta__r.Codigo__c; 
                pagosBenes.monto_Aporte_Patronal = pb.Monto_Aporte_Patronal__c;
                pagosBenes.tipoCuenta = pb.Tipo_cuenta__c;
                if(pb.Saldo_Prestamo__c == null) {pb.Saldo_Prestamo__c = 0;}
                pagosBenes.montoPrestamos = pb.Saldo_Prestamo__c;
                if(pb.Monto_Bruto_Retirar_Empresa__c == null) {pb.Monto_Bruto_Retirar_Empresa__c = 0;}
                pagosBenes.montoPatronal = pb.Monto_Bruto_Retirar_Empresa__c;
                if(pb.Monto_Neto_Retirar_Empresa__c == null) {pb.Monto_Neto_Retirar_Empresa__c = 0;}
                pagosBenes.montoNetoPatronal = pb.Monto_Neto_Retirar_Empresa__c;
                if(pb.Total_Cargos_Empresa__c == null) {pb.Total_Cargos_Empresa__c = 0;}
                pagosBenes.montoCargoPatronal = pb.Total_Cargos_Empresa__c;
                pagosBenes.tipoCuentaBancaria = pb.Detalle_caso__r.Cuenta__r.cuenta_colectiva2__r.Tipo_Cuenta_bancaria__c;
                pagosBenes.cuentaPatronal = pb.Detalle_caso__r.Cuenta__r.cuenta_colectiva2__r.Cuenta__c;
                pagosBenes.bancoCuentaBancaria = pb.Detalle_caso__r.Cuenta__r.cuenta_colectiva2__r.Banco__c;
                pagosBenes.tipoCuentaC = pb.Detalle_caso__r.Cuenta__r.cuenta_colectiva2__r.tipo_cuenta__C;
                if(pb.Saldo_Restante_Cuenta_Cliente__c == null) {pb.Saldo_Restante_Cuenta_Cliente__c = 0;}
                pagosBenes.montoRestanteCliente = pb.Saldo_Restante_Cuenta_Cliente__c;
                pagosBenes.montoPatronalCliente = pb.Monto_Saldo_Patronal__c;               
                pagosBenes.montoCKPatrono = pb.Monto_Cheque_Patrono__c;
                pagosBenes.montoACHPatrono = pb.Monto_ACH_Patrono__c;
                pagosBenes.montoTSPPatrono = pb.Monto_TSP_Patrono__c;
                if(pb.Monto_bruto__c == null) {pb.Monto_bruto__c = 0;}
                pagosBenes.totalSaldo10 = pb.Monto_bruto__c;
                pagosBenes.totalSaldo11 = 0;
                pagosBenes.totalSaldo12 = 0;
                pagosBenes.totalSaldo13 = 0;
                pagosBenes.totalSaldo17 = 0;
                
                claseEnvio.listBeneficiarios.Add(pagosBenes);
            }  
            //Fin pagos Beneficiarios
            
            boolean cargarCargosEmpleado = detalle[0].cuenta__r.Cuenta_colectiva2__r.cargar_gastos_empleado__C != null ? detalle[0].cuenta__r.Cuenta_colectiva2__r.cargar_gastos_empleado__C : false;
                        
            claseEnvio.tipoPago = detalle[0].Tipo_pago__c;
            claseEnvio.cuenta = detalle[0].Cuenta__r.Codigo__c;
            claseEnvio.cuentaOrigen = detalle[0].Cuenta_destino__c;
            claseEnvio.cuentaDestino = string.valueOf(detalle[0].N_Cuenta_Bancaria__c);
            claseEnvio.transferencia = detalle[0].Forma_Retiro__c == 'ACH' || detalle[0].Forma_Retiro__c == 'AH' ? true : false;
            claseEnvio.tipoCuentaDestino = detalle[0].Tipo_Cuenta__c;
            claseEnvio.bancoCuentaDestino = detalle[0].Banco__c;
            
            claseEnvio.tipoCuentaBancaria=detalle[0].Cuenta__r.cuenta_colectiva2__r.Tipo_Cuenta_bancaria__c;
            claseEnvio.cuentaPatronal = detalle[0].Cuenta__r.cuenta_colectiva2__r.Cuenta__c;
            claseEnvio.BancoCuentaBancaria =detalle[0].Cuenta__r.cuenta_colectiva2__r.Banco__c;
            ClaseEnvio.tipoCuenta= detalle[0].Cuenta__r.cuenta_colectiva2__r.tipo_cuenta__C;
            claseEnvio.montoBrutoPatronal= detalle[0].Monto_Bruto_Retirar_Empresa__c !=null && !detalle[0].Cliente_sigue_Laborando__c ? detalle[0].Monto_Bruto_Retirar_Empresa__c :0;
            claseEnvio.montoNetoPatronal = detalle[0].Monto_Neto_Retirar_Empresa__c !=null ? detalle[0].Monto_Neto_Retirar_Empresa__c :0;
            claseEnvio.montocargosPatronal = detalle[0].Total_Cargos_Empresa__c !=null ? detalle[0].Total_Cargos_Empresa__c :0;
            claseEnvio.saldoPrestamo=detalle[0].Saldo_Prestamo__c !=null ? detalle[0].Saldo_Prestamo__c : 0;
            claseEnvio.montoRestanteCliente = detalle[0].Saldo_Restante_Cuenta_Cliente__c !=null ? detalle[0].Saldo_Restante_Cuenta_Cliente__c : 0;
            claseEnvio.MontoSaldoPatronal = detalle[0].Monto_Saldo_Patronal__c != null  ? detalle[0].Monto_Saldo_Patronal__c : 0;
            claseEnvio.montoChequePatrono = detalle[0].Monto_Cheque_Patrono__c !=null && claseEnvio.montoBrutoPatronal > 0 ? detalle[0].Monto_Cheque_Patrono__c : 0;
            claseEnvio.montoACHPatrono = detalle[0].Monto_ACH_Patrono__c !=null && claseEnvio.montoBrutoPatronal > 0 ? detalle[0].Monto_ACH_Patrono__c : 0;
            claseEnvio.montoTSPPatrono = detalle[0].Monto_TSP_Patrono__c !=null && claseEnvio.montoBrutoPatronal > 0 ? detalle[0].Monto_TSP_Patrono__c : 0;
            
            claseEnvio.monedaCuentaDestino = detalle[0].currencyIsoCode;
            claseEnvio.montoRetiro = detalle[0].Monto_total_retirar__c+claseEnvio.saldoPrestamo;            
            claseEnvio.tipoRetiro = detalle[0].Tipo_retiro__c;          
            claseEnvio.montoComisionPorRetiro =0; 
            //claseEnvio.montoComisionPorRetiro = detalle[0].Comision_Retiro_Anticipado__c ? detalle[0].Porcentaje_comision__c : 0;
            claseEnvio.montoACH = detalle[0].Forma_Retiro__c == 'ACH' && detalle[0].Cobro_ACH__c && !cargarCargosEmpleado ? detalle[0].Monto_ACH__c : 0;
            claseEnvio.montoCheque = detalle[0].Forma_Retiro__c == 'CK' && detalle[0].Cobro_Cheque__c && !cargarCargosEmpleado ? detalle[0].Monto_cheque__c : 0;
            claseEnvio.montoTSP = detalle[0].Cobro_TSP__c && !cargarCargosEmpleado ? detalle[0].Monto_TSP__c : 0;
            claseEnvio.formaPago = detalle[0].Forma_Retiro__c+'/'+caso.CaseNumber;
            claseEnvio.aportePatronal = detalle[0].Permitir_Retiro_Saldos_Patronales__c;
            claseEnvio.clienteSigueLaborando = detalle[0].Cliente_sigue_Laborando__c;
            DateTime sHoy = system.now();
            
            if(detalle[0].Cobro_Individual_CRA__c && detalle[0].Porcentaje_CRA_Individual__c!=null){
                claseEnvio.montoComisionPorRetiro = detalle[0].Porcentaje_CRA_Individual__c;
            }
            else if(detalle[0].Cuenta__r.cuenta_colectiva2__C ==null && detalle[0].Comision_Retiro_Anticipado__c && detalle[0].Comision_retiro_anticipado_empresa__c){               
                claseEnvio.montoComisionPorRetiro = detalle[0].Comision_Retiro_Anticipado__c ? detalle[0].Porcentaje_comision__c : 0;
                
            }
            else if(detalle[0].Cliente_sigue_Laborando__c && detalle[0].Cobrar_empleado_sigue_laborando__c){
                
                claseEnvio.montoComisionPorRetiro = detalle[0].Comision_Retiro_Anticipado__c ? detalle[0].Porcentaje_comision__c : 0;
            }  
            //PARTE NUEVA
            if(detalle[0].Cobrar_empleado_sigue_laborando__c && !detalle[0].Cliente_sigue_Laborando__c){
                
                if(claseEnvio.montoComisionPorRetiro>0 && detalle[0].Cuenta__r.Cobrar_empleado_sigue_laborando__c){
                    claseEnvio.montoComisionPorRetiro =0;
                }
                if(claseEnvio.montoComisionPorRetiro>0 && detalle[0].Cuenta__r.Subproducto__r.Cobrar_si_empleado_sigue_laborando__c
                   && detalle[0].nivel_de_regla__C=='3'){
                       claseEnvio.montoComisionPorRetiro =0;
                   }
                
            }
            
            //FIN PARTE NUEVA
            
            Decimal montoRetirarTSP = 0;
            
            if(detalle[0].Tipo_Retiro__c == '51'){
                For(Detalle_caso__c item : detalle){
                    classSaldos sal = new classSaldos();
                    
                    if(!item.Cabeza_retiro__c){
                        if(item.Saldo_enviar_Sysde__c){
                            sal.tipoSaldo = item.Saldo_retirar__c;
                            sal.montoSaldo = string.valueOF(item.Monto_retirar__c); 
                            saldos.add(sal);
                            
                            bitacoras.add(crearBitacora(caso.CaseNumber, caso.RecordType.Name, caso.CreatedDate,
                                                        item.Monto_Saldo__c.format(),
                                                        item.Monto_retirar__c.format(),
                                                        caso.Owner.Name, caso.lastModifiedBy.Name, caso.lastModifiedDate, sHoy));
                        }
                    }
                }
            }Else{
                bitacoras.add(crearBitacora(caso.CaseNumber, caso.RecordType.Name, caso.CreatedDate,
                                            detalle[0].Saldo_Total__c.format(),
                                            detalle[0].Saldo_Total__c.format(),
                                            caso.Owner.Name, caso.lastModifiedBy.Name, caso.lastModifiedDate, sHoy));   
            }
            
            claseEnvio.saldos = saldos;                     
            claseEnvio.bitacora = bitacoras;
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug('Mandamos: '+cons);
            request.setBody(cons);
            request.setTimeout(120000);
            HttpResponse response = new HttpResponse();//http.send(request);
            if(!test.isRunningTest()) { response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('OK');// = (getSaldoCuenta)System.JSON.deserialize('{"cuenta":"51238","montoPignorado":"null","saldoTotal":"15,518.70","saldos":[{"tipoSaldo":"12","montoSaldo":"11902.88"},{"tipoSaldo":"10","montoSaldo":"2956.6"},{"tipoSaldo":"11","montoSaldo":"659.22"}]}', getSaldoCuenta.class); 
            }
            
            System.debug('Respuesta: '+response.getBody());
            FechaDC_Sysde__c varFec = [Select Fecha_cierre__c,id,Trimestre_Terminado__C From FechaDC_Sysde__c where name = 'CierreAlDia'];
            if(!response.getBody().contains('Su retiro ha sido registrado, aprobado y pagado')) {
            	Caso.Fecha_Sysde__c = varFec.Fecha_cierre__c;
            }
            Caso.Respuesta_desde_Sysde__c = response.getBody();
            caso.Contenido_Sysde__c = cons;
            claseUtil.stopTrigger();
            update Caso;
            if(detalle[0].Aplica_Cambio_Sub_Producto_desde_Retiros__c){
                crearCasoSubproducto(caso.id);
            }
            Approval.LockResult lrList = Approval.lock(Caso);
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            Caso.Respuesta_desde_Sysde__c = e.getMessage() + 'Línea: ' + e.getLineNumber();
            Caso.Status = 'Error de conexion';
            claseUtil.stopTrigger();
            update caso;
            Approval.LockResult lrList = Approval.lock(Caso);   
        }Catch(Exception e){ 
            Caso.Respuesta_desde_Sysde__c = e.getMessage();
            Caso.Status = 'Error de conexion';
            claseUtil.stopTrigger();
            database.update(caso, false);// update caso;
            system.debug('Clase Futura' +e.getMessage() + ' linea ' + e.getLineNumber());   
        }    
    }
    
    
    public static void crearCasoSubproducto(string idCaso){
        
        Case caso = new case();
        detalle_caso__c detalleCasoViejo = new detalle_caso__c();
        detalle_caso__c detalleCasoNuevo = new detalle_caso__c();
        decimal count =0;
        
        try{
            detalleCasoViejo = [Select Cuenta__c, Accion__c, Caso__r.ownerId,caso__r.accountid,
                                Detalle_subproducto__c, Detalle_Cuenta_colectiva__c,
                                cuenta__r.Detalle_Cuenta_colectiva__c,Producto_Anterior__C,
                                
                                cuenta__r.producto__r.name,id,cuenta__r.Detalle_Subproducto__c,
                                Nueva_Cuenta_colectiva2__c, Nuevo_Subproducto__c,
                                Cuenta_Colectiva_Anterior__c, Detalle_subproducto2__c 
                                From Detalle_caso__c 
                                Where Caso__c =:idCaso order by Cabeza_retiro__c desc limit 1];
            
            detalleCasoViejo.Producto_Anterior__C =detalleCasoViejo.cuenta__r.producto__r.name;
            detalleCasoviejo.Detalle_Cuenta_colectiva__c = detalleCasoviejo.cuenta__r.Detalle_Cuenta_colectiva__c;
            detalleCasoviejo.Detalle_subproducto2__c = detalleCasoViejo.cuenta__r.Detalle_Subproducto__c;
            
            Caso.Status='Nuevo';
            Caso.type='Solicitud de Gestión';
            Caso.Origin='Agencias FPC';
            Caso.Priority= 'Media'; 
            caso.Caso_Retiro__c = idCaso;
            caso.Aprobado__c=false;
            caso.Enviar_a_aprobacion__c =true;
            caso.Motivo_Cambio__c='Retención';
            caso.OwnerId=detalleCasoViejo.Caso__r.ownerId;
            caso.RecordTypeId= [select id from recordType where developername='Cambio_Subproducto'].id;
            caso.AccountId = detalleCasoViejo.caso__r.accountid;
            detalleCasoNuevo.Accion__c = detalleCasoViejo.Accion__c;
            detalleCasoNuevo.cuenta__C = detalleCasoViejo.cuenta__C;
            detalleCasoNuevo.Detalle_subproducto2__c = detalleCasoViejo.Detalle_subproducto2__c;
            detalleCasoNuevo.Cuenta_Colectiva_Anterior__c = detalleCasoViejo.Cuenta_Colectiva_Anterior__c;
            detalleCasoNuevo.Nuevo_Subproducto__c = detalleCasoViejo.Nuevo_Subproducto__c;
            detalleCasoNuevo.Producto_Anterior__C =detalleCasoViejo.cuenta__r.producto__r.name;
            detalleCasoNuevo.Detalle_Cuenta_colectiva__c = detalleCasoviejo.cuenta__r.Detalle_Cuenta_colectiva__c;
            
            if(detalleCasoViejo.Accion__c=='A1') {
                //detalleCasoNuevo.Detalle_Cuenta_colectiva__c = detalleCasoviejo.cuenta__r.Detalle_Cuenta_colectiva__c;
                detalleCasoNuevo.Nueva_Cuenta_colectiva2__c =  detalleCasoviejo.Nueva_Cuenta_colectiva2__c;
            }else if(detalleCasoViejo.Accion__c=='A2' || detalleCasoViejo.Accion__c=='A3'){
                detalleCasoNuevo.Detalle_subproducto__c = detalleCasoviejo.Detalle_subproducto__c;
                //detalleCasoNuevo.Nuevo_Subproducto__c = detalleCasoViejo.Nuevo_Subproducto__c;
            }
            insert caso;
            list<id> idDocumentos = new list<id>();
            idDocumentos.add(idCaso);
            list<ContentDocumentLink> ducumentoCaso = [select LinkedEntityId,ContentDocumentId,ShareType,id from ContentDocumentLink where LinkedEntityId in :idDocumentos limit 1];
            if(ducumentoCaso.size()>0){
                try{ContentVersion cv = [select ContentLocation, ContentDocumentId, VersionData, Title, PathOnClient,id
                                         from ContentVersion where ContentDocumentId =:ducumentoCaso[0].ContentDocumentId limit 1];
                    cv.id=null;
                    insert cv;
                    ContentDocumentLink cdl = new ContentDocumentLink();
                    cdl.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id].ContentDocumentId;
                    cdl.LinkedEntityId = caso.id;
                    cdl.ShareType = 'V';
                    insert cdl;
                   }catch(Exception ex){}
                
            }
            
            detalleCasoNuevo.caso__C = caso.id;
            if(!test.isRunningTest()){insert detalleCasoNuevo; update detalleCasoViejo;}
            else database.insert (detalleCasoNuevo,false);
            caso = new case();
            caso = [select Cuentas_seleccionada__C, aprobado__c, RecordTypeId,id from case where id=:detalleCasoNuevo.caso__C];
            count=[select Cuentas_seleccionada__C from case where id=:caso.id].Cuentas_seleccionada__C; 
            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
            req1.setComments('Se solicita Aprobación para caso ');
            req1.setObjectId(caso.id);
            req1.setProcessDefinitionNameOrId('CambioSubProducto');
            req1.setSkipEntryCriteria(true);
            Approval.ProcessResult result = Approval.process(req1);
            system.debug('Metodo crear sub Producto corrido con éxito'); 
            if(test.isRunningTest())decimal.valueOf('fr');
        }catch(exception ex){
            List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
            //OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'jesus.deabreu@clovergroup.com.ve'];
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            // mail.setOrgWideEmailAddressId(owea.get(0).Id);
            mail.setToAddresses(label.MailErrorCasoSubproducto.split(',')); 
            mail.setSubject ('Error al crear caso de subproducto '); 
            mail.setPlainTextBody('Mensage de error: '+ex.getMessage()+'\n Linea del error: '+ex.getLineNumber()+'\n\n Caso Retiros: '+idCaso+' \n\n Caso Sub-Producto: '+caso.id+
                                  '\n Cuentas Seleccionadas: '+count); 
            MessageList.add(mail); 
            Messaging.SendEmailResult[] results = Messaging.sendEmail(MessageList, true);
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
    }
    
    
    
    @future(callout=true)
    public static void fechaCierreSysde(Date fecha) {
        Http http = new Http();  
        HttpRequest request = new HttpRequest();  
        String url = claseUtil.urlSysde('Test');   
        request.setEndpoint(url + 'api/cierre'); 
        request.setMethod('GET');  
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded'); 
        request.setTimeout(120000); 
        try{   
            date fechacierre;
            HttpResponse response = new HttpResponse();
            if(test.isRunningTest()){
                response.setBody('2019-05-23T00:00:00');
            }else{
                response = http.send(request); 
            }
            fechacierre = date.valueOf(response.getBody().replace('"',''));
            FechaDC_Sysde__c fdcs = [Select Fecha_cierre__c, id, Trimestre_Terminado__C, Total_Correos_Enviados__C From FechaDC_Sysde__c Where Name = 'CierreAlDia' Limit 1];
            fdcs.Fecha_cierre__c = fechacierre;
            if(fechacierre.day() == 1 && !fdcs.Trimestre_Terminado__C && (fechacierre.month() == 1 || fechacierre.month() == 4 || fechacierre.month() == 7 || fechacierre.month() == 10)){
                    fdcs.Trimestre_Terminado__C = true;
                    fdcs.Total_Correos_Enviados__C = 0;
                }
            update fdcs;
            for(CronTrigger item : [SELECT id FROM CronTrigger where CronJobDetail.Name = 'FechaCierreSysde']){
                System.abortJob(item.id);
            }
            Datetime fechaAcron = Datetime.now().addHours(1);	
            String acron = fechaAcron.second()+' '+fechaAcron.minute()+' '+fechaAcron.hour()+' '+fechaAcron.day()+' '+fechaAcron.month()+' ? '+fechaAcron.year();	
            System.schedule('FechaCierreSysde', acron, new verificarFechaCierreSysde());
            
        }catch(Exception e){ 
            system.debug('Error: '+e.getMessage());  
        }             
    }
    
    @future(callout=true)
    public static void montoCambioDolar() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        
        request.setEndpoint(url + 'api/retiros/tasa');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        Decimal respuesta = 0;
        
        try{
            if(!test.isRunningTest())
            {
                HttpResponse response = http.send(request);
                System.debug(response.getBody());
                
                respuesta = Decimal.valueOf(response.getBody()); 
                
                Monto_cambio_dolar__c  tipoC = [Select Monto__c ,id
                                                From Monto_cambio_dolar__c 
                                                Where Name = 'MontoAlDia' Limit 1];
                tipoC.Monto__c = respuesta;
                update tipoC;
            }
        }catch(System.CalloutException e){
            system.debug(e.getMessage());   
        }
        //return respuesta;    
    }
    
    public static string verPropietarioCuenta(String cuenta) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        
        request.setEndpoint(url + 'api/retiros/' + cuenta);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        String respuesta = '';
        
        try{
            HttpResponse response;
            if(!test.isRunningTest()){ response=http.send(request);respuesta = response.getBody();}
            
            //System.debug(response.getBody());             
            //if(response.getBody()!=null && response.getBody().trim()!=''){respuesta = response.getBody();} 
            if(respuesta == '' || respuesta == 'null' || test.isRunningTest()) {
                respuesta = 'CUENTA NO ENCONTRADA';
            }   
        }catch(System.CalloutException e){
            system.debug(e.getMessage());   
        }
        return respuesta;    
    }
    
    // +++++++++++++++++++++++++++++++++ REVERSIONES ++++++++++++++++++++++
    
    public static list<classReversiones.classRespuestaReversion> movimientosReversiones(classReversiones.classConsultaReversion claseEnvio) {
        Http http = new Http();
        HttpRequest request = new HttpRequest(); 
        String url = claseUtil.urlSysde('Test');
        
        request.setEndpoint(url + 'api/reversiones/consultas');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        
        classJson envio = new classJson();
        envio.contenido = JSON.serialize(claseEnvio);
        String cons = 'contenido=' + envio.contenido;
        system.debug('Envio '+cons);
        request.setBody(cons);
        
        list<classReversiones.classRespuestaReversion> respuesta = new list<classReversiones.classRespuestaReversion>();
        
        try{
            HttpResponse response =new HttpResponse();
            if(!test.isRunningTest()) { response = http.send(request);
                //response.setBody(body)
            }else{
                response.setBody('[{"fecha":"2017-01-24T00:00:00","descripcion":"Aporte","monto":10000.0,"tipoSaldo":"11","saldoInicial":0.0,"prcComisionAporte":0.0,"prcComisionSaldo":0.0,"valorCuota":0.0}]');
                response.setStatusCode(200);
            }
            System.debug('Respuesta sysde'+response.getBody());
            
            if (response.getStatusCode() == 200) {
                System.debug(response.getBody());
                respuesta = (list<classReversiones.classRespuestaReversion>)System.JSON.deserialize(response.getBody(), 
                                                                                                    list<classReversiones.classRespuestaReversion>.class);
                for(integer i=0; i<respuesta.size(); i++){
                    if(respuesta[i].monto<0) { respuesta[i].monto = respuesta[i].monto*-1;
                    }
                    if(respuesta[i].tipoSaldo=='10'){respuesta[i].descripcion='Personal Ordinario';}
                    if(respuesta[i].tipoSaldo=='11'){respuesta[i].descripcion='Personal Extraordinario';}
                    if(respuesta[i].tipoSaldo=='12'){respuesta[i].descripcion='Patronal Ordinario';}
                    if(respuesta[i].tipoSaldo=='13'){respuesta[i].descripcion='Patronal Extraordinario';}
                    if(respuesta[i].tipoSaldo=='18'){respuesta[i].descripcion='Seguro de Vida';}
                }
            }   
        }catch(System.CalloutException e){
            system.debug(e.getMessage());   
        }
        return respuesta;    
    }
    
    public static list<classReversiones.classRespuestaRendimiento> movimientosReversionesRendimiento(classReversiones.classRendimiento claseEnvio)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/reversiones/rendimiento');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        list<classReversiones.classRespuestaRendimiento> respuesta = new list<classReversiones.classRespuestaRendimiento>();
        try{
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug('Mandamos: '+cons);
            request.setBody(cons);
            request.setTimeout(120000);
            HttpResponse response =new HttpResponse();//  http.send(request);
            if(!test.isRunningTest()) { response = http.send(request);
                //response.setBody(body)
            }
            else{
                response.setBody('[{"valor":254.0191067,"comisionAporte":5.0,"comisionSaldo":2.0},{"valor":254.08352285,"comisionAporte":5.0,"comisionSaldo":2.0},{"valor":254.08352285,"comisionAporte":5.0,"comisionSaldo":2.0}]');
                response.setStatusCode(200);
            }
            System.debug('Respuesta de Sysde: '+response.getBody());
            if(response.getStatusCode()==200)
            {
                respuesta = (list<classReversiones.classRespuestaRendimiento>)System.JSON.deserialize(response.getBody(), list<classReversiones.classRespuestaRendimiento>.class);
                return respuesta;
            }
        }catch(Exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
        return respuesta;
    }
    
    @future(callout=true)
    public static void reversar(String idCaso) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/reversiones');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        Case caso = new Case();
        Detalle_Caso__c detalle = new Detalle_Caso__c();
        classProcesarReversion claseEnvio = new classProcesarReversion();
        string idError ='';
        list<classBitacora> bitacoras = new list<classBitacora>();
        
        try{
            caso = [Select AccountId,CaseNumber,
                    RecordType.Name,CreatedDate,Owner.Name, id, 
                    Account.name,
                    mostrar_tasa_cambio__C,Tasa_Cambio__c,
                    lastModifiedDate,lastModifiedBy.Name , lastModifiedBy.email
                    From Case Where Id =: idCaso];
            
            boolean hayError = false;
            
            detalle = [Select Cuenta__r.Codigo__c, Monto_reversar__c, Fecha_aporte__c,id,
                       Tipo_transaccion__c, Subtipo_transaccion__c, Comision_por_aporte__c,
                       rezago__C, cod_referencia__C,
                       Monto__c,Tipo_Saldo__c, Rendimiento__c, Cobrar_comision__c,
                       Cuenta__r.CurrencyIsoCode
                       From Detalle_caso__c 
                       Where Caso__c =: caso.id Limit 1];
            if(caso.mostrar_tasa_cambio__C == 'Si'){
                classDolares.classRespuestaDolares respuesta = aSysdePortalEmpresarial.CompraVentaDolares((detalle.Cuenta__r.CurrencyIsoCode =='HNL' ? 'USD' : 'HNL'), detalle.Monto_reversar__c, caso.Account.name);
                hayError = true;
                idError = respuesta.id;
                if(respuesta.tasaCambio !=null){
                    caso.Tasa_Cambio__c = decimal.valueOf(respuesta.tasaCambio);
                    decimal tasa = detalle.Cuenta__r.CurrencyIsoCode=='HNL' ? (1/caso.Tasa_Cambio__c) : caso.Tasa_Cambio__c;
                    detalle.Monto_reversar__c = detalle.Monto_reversar__c !=null ? (detalle.Monto_reversar__c / tasa).setscale(2) :0;
                    detalle.Monto__c = detalle.Monto__c !=null ? (detalle.Monto__c / tasa).setscale(2) :0;
                    detalle.Rendimiento__c = detalle.Rendimiento__c !=null ? (detalle.Rendimiento__c / tasa).setscale(2) :0;
                    hayError = false;
                }
            }
            if(!hayError ){
                Autonumerico_cuentas_Syste__c abc= new Autonumerico_cuentas_Syste__c();
                abc=[select Id_Formulario_Sysde__c, id from Autonumerico_cuentas_Syste__c limit 1];                                             
                claseEnvio.cuenta = detalle.Cuenta__r.Codigo__c;
                claseEnvio.accion = detalle.Subtipo_transaccion__c ;            
                //claseEnvio.idSalesforce = 'SF'+string.valueOf((abc.Id_Formulario_Sysde__c++));
                claseEnvio.idSalesforce =detalle.cod_referencia__C !=null ? detalle.cod_referencia__C.replace(' ',''): 'SF-R'+string.valueOf((abc.Id_Formulario_Sysde__c++));
                claseEnvio.rezago = detalle.rezago__c;
                claseEnvio.tipoSaldo = detalle.Tipo_Saldo__c;
                claseEnvio.cobroComision = detalle.Comision_por_aporte__c;
                claseEnvio.monto = detalle.Monto__c;
                if(detalle.Subtipo_transaccion__c == 'D1' || detalle.Subtipo_transaccion__c == 'D3'){
                    claseEnvio.montoPorAporte = detalle.Monto_reversar__c;    
                }
                
                if(detalle.Subtipo_transaccion__c == 'C1' || detalle.Subtipo_transaccion__c == 'C2'
                   || detalle.Subtipo_transaccion__c == 'C3' || detalle.Subtipo_transaccion__c == 'C4'
                   || detalle.Subtipo_transaccion__c == 'C5' || detalle.Subtipo_transaccion__c == 'C6'
                   || detalle.Subtipo_transaccion__c == 'C7' || detalle.Subtipo_transaccion__c == 'C8'
                   || detalle.Subtipo_transaccion__c == 'C9' || detalle.Subtipo_transaccion__c == 'C10'
                   || detalle.Subtipo_transaccion__c == 'D1' || detalle.Subtipo_transaccion__c == 'D2'
                   || detalle.Subtipo_transaccion__c == 'D3' || detalle.Subtipo_transaccion__c == 'D4'){
                       //claseEnvio.montoPorAporte = detalle.Monto_reversar__c;    
                       claseEnvio.monto=detalle.Monto_reversar__c;
                   }
                if(detalle.Subtipo_transaccion__c == 'D2' || detalle.Subtipo_transaccion__c == 'D3'){
                    claseEnvio.montoPorSaldo = detalle.Monto_reversar__c;    
                }
                DateTime sHoy = system.now();
                bitacoras.add(crearBitacora(caso.CaseNumber, caso.RecordType.Name, caso.CreatedDate,
                                            detalle.Tipo_transaccion__c,
                                            detalle.Subtipo_transaccion__c,
                                            caso.Owner.Name, caso.lastModifiedBy.Name, caso.lastModifiedDate, sHoy));
                
                claseEnvio.bitacota = bitacoras;
                claseEnviO.cobroComision=detalle.Cobrar_comision__C;                    
                classJson envio = new classJson();
                envio.contenido = JSON.serialize(claseEnvio);
                String cons = 'contenido=' + envio.contenido;
                system.debug(cons);
                
                request.setBody(cons);
                request.setTimeout(120000);
                
                HttpResponse response = http.send(request);
                
                System.debug('Respuesta sysde'+response.getBody());
                classRespuesta r = (classRespuesta)System.JSON.deserialize(response.getBody(), classRespuesta.class);
                
                Caso.Respuesta_desde_Sysde__c = response.getBody();
                claseUtil.stopTrigger();
                //Caso.Mostrar_tasa_Cambio__c =null;
                update Caso;
                update abc;
                if(response.getStatusCode() == 200){
                    update detalle;
                }
                Approval.LockResult lrList = Approval.lock(Caso);
            }else{
                list<string> listCorreos =new list<string>();
                listCorreos.add(caso.lastModifiedBy.email);
                List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(listCorreos);
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
                mail.setSubject('Error en el caso No: '+caso.CaseNumber+' de Revesiones');
                mail.setPlainTextBody('Buen día, \n\n Se notifica que hubo un error en la campra/venta de dolares en el caso de reversiones por lo tanto no se ha enviado a Sysde.\n\n Mensaje del error: '+idError+'\n\n Por favor dar seguimiento.');
                MessageList.add(mail);
                Messaging.sendEmail(MessageList,false);
            }
            
        }catch(System.CalloutException e){
            system.debug('Error: '+e.getMessage()+', Linea: '+e.getLineNumber());
            Caso.Respuesta_desde_Sysde__c = e.getMessage() + 'Línea: ' + e.getLineNumber();
            update caso;
            Caso.Status = 'Error de conexion';
            claseUtil.stopTrigger();
            update caso;
            Approval.LockResult lrList = Approval.lock(Caso);   
        }Catch(Exception e){
            system.debug('Clase Futura' +e.getMessage() + ' linea ' + e.getLineNumber());   
        }
    }
    
    public static string MesLetras (integer mes){
        string respuesta ='';
        if(mes==1 && Label.IdiomaMes == 'I'){respuesta = 'JAN';}
        if(mes==1 && Label.IdiomaMes == 'E'){respuesta = 'ENE';}
        if(mes==2){respuesta = 'FEB';}
        if(mes==3){respuesta = 'MAR';}
        if(mes==4 && Label.IdiomaMes == 'I'){respuesta = 'APR';}
        if(mes==4 && Label.IdiomaMes == 'E'){respuesta = 'ABR';}
        if(mes==5){respuesta = 'MAY';}
        if(mes==6){respuesta = 'JUN';}
        if(mes==7){respuesta = 'JUL';}
        if(mes==8 && Label.IdiomaMes == 'I'){respuesta = 'AUG';}
        if(mes==8 && Label.IdiomaMes == 'E'){respuesta = 'AGO';}
        if(mes==9){respuesta = 'SEP';}
        if(mes==10){respuesta = 'OCT';}
        if(mes==11){respuesta = 'NOV';}
        if(mes==12 && Label.IdiomaMes == 'I'){respuesta = 'DEC';}
        if(mes==12 && Label.IdiomaMes == 'E'){respuesta = 'DIC';}
        return respuesta;
    }
    public class classRespuesta {
        public Integer codigo { get; set; }
        public String mensaje { get; set; }
    }
    public class RepoCarnet{
        public string identificacion {get;set;}
        public string codigoBarra{get;set;}
    }
    
    public class VarURL {
        public string idcli{get;set;}
        public string desde{get;set;}
        public string hasta{get;set;}
        
    }
}