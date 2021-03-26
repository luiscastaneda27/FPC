public class aSysdeReporteCalidad {
    
    public static ConsultaClienteCuenta infoClienteCuenta(String cuenta){
        ConsultaClienteCuenta  respuesta = new ConsultaClienteCuenta ();
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String url = claseUtilPlanillas.urlSysde('Test'); 
            request.setEndpoint(url + 'api/consultaInfoClienteCalidad/'+cuenta.replace('-', ''));
            request.setMethod('GET');
            request.setTimeout(120000);
            HttpResponse response = new HttpResponse();
            if(!test.isRunningTest()){
                response = http.send(request); 
            }else{
                response.setBody('{"clienteUnicoBanco":"179363","numContrato":"108662","numCuenta":"104526"}');
                response.setStatusCode(200);
            }
            system.debug('Respuesta desde sysde: '+response.getBody());
            if(response.getStatusCode() == 200){
                respuesta = (ConsultaClienteCuenta)System.JSON.deserialize(response.getBody(), ConsultaClienteCuenta.class); 
            }
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber()); 
        }
        return respuesta;
    }
    
    public static ClassReporteCalidad infoCliente(string identidad){
         ClassReporteCalidad  respuesta = new ClassReporteCalidad ();
        try{
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String url = claseUtilPlanillas.urlSysde('Test'); 
            request.setEndpoint(url + 'api/consultaInfoClienteCalidad/'+identidad.replace('-', ''));
            request.setMethod('GET');
           // request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            request.setTimeout(120000);
            HttpResponse response = new HttpResponse();
            if(!test.isRunningTest()){
                response = http.send(request); 
            }else{
                response.setBody('{"clienteUnicoBanco":"179363","numContrato":"108662","numCuenta":"104526"}');
                response.setStatusCode(200);
            }
            system.debug('Respuesta desde sysde: '+response.getBody());
            if(response.getStatusCode() == 200){
                respuesta = (ClassReporteCalidad)System.JSON.deserialize(response.getBody(), ClassReporteCalidad.class); 
            }
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber()); 
        }
        return respuesta;
    }
    
    public static list<ConsultaCliente> infoClientes(string accion){
         list<ConsultaCliente>  respuesta = new list<ConsultaCliente> ();
        try{
            Http http = new Http();
            list<Beneficiario__c> listBeneficiarios = new list<Beneficiario__c>();
            list<account> listClientes = new list<account>();
            list<cuentas__C> listCuentas = new list<cuentas__C>();
            
            InformeReporteCalidad a = new InformeReporteCalidad();
            a.accion=accion;
            a.desde = date.today().addMonths(-2);
            //a.desde = date.valueOf(datetime.newInstance(2018, 1, 1));
            a.hasta = date.today();
            /*a.hasta = date.valueOf(datetime.newInstance(2019, 5, 20));
            if(accion=='FC'){
                a.desde = date.valueOf(datetime.newInstance(2019, 1, 1));
                a.hasta = date.valueOf(datetime.newInstance(2019, 2, 17));
            }else if(accion == 'BFK'){
                a.desde = date.valueOf(datetime.newInstance(2019, 1, 1));
                a.hasta = date.valueOf(datetime.newInstance(2019, 2, 20));
            }*/
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(a);
            String cons = 'contenido=' + envio.contenido;
           
            HttpRequest request = new HttpRequest();
            String url = claseUtilPlanillas.urlSysde('Test'); 
            url='http://190.5.68.49:9090/';
            request.setEndpoint(url + 'api/clientes/reportes');
            request.setMethod('POST');
            request.setBody(cons);
            request.setTimeout(120000);
            HttpResponse response = new HttpResponse();
            system.debug('Mandamos: '+cons);
            if(!test.isRunningTest()){
                response = http.send(request); 
            }else{
                response.setBody('[ { "FECHA_INGRESO": "14-FEB-19", "NUM_FORMULARIO": "2500116310201", "numContrato": "98098", "COD_CLIENTE": "258585", "numCuenta": "95803", "primerNombre": "MARIA ", "segundoNombre": "OLIMPIA ", "primerApellido": "VIJIL ", "segundoApellido": "CONTRERAS ", "tipoIdentificacion": "1", "identificacion": "1707-1984-00037", "RTN": "", "NOMBRE_AGENCIA": "", "AGN": "110000000000", "COD_AGN": "14440", "EMP_AGN": "ROBERTO ISAAC BORJAS FLORES ", "MONEDA": "HNL", "CANAL_APORTE": "TL", "TIPO_CLIENTE": "AFILIACION POR SOLICITUD", "asesor": "HN22258", "codSubProducto": "FPC1O", "waiver": "", "addendum": "", "fatca": "N", "pep": "N", "procedencia": "PAGO DE SEGURO DE VIDA POR FALLECIMIENTO DE HIJO QUE PROVIENE DE INJUPEMP", "tipoFondo": "101", "codEmpresa": "" } ]');
                response.setStatusCode(200);
            }
            system.debug('Respuesta desde sysde: '+response.getBody());
            system.debug('Código: '+response.getStatusCode());
            string contenido = response.getBody();
            String replace = 'P';
            contenido = contenido.replace(': "', ':"');
            system.debug('contenido: '+contenido);
            contenido = contenido.replace('	', ' ');
            if(response.getStatusCode() == 200){
                respuesta = (list<ConsultaCliente>)System.JSON.deserialize(contenido, list<ConsultaCliente>.class); 
            }
            
            system.debug('Tamano de la lista: '+respuesta.size());
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
        return respuesta;
    }
    
    
     public static string CambioEstado(classEstadoCapital claseEnvio){
        string respuesta;
         try{ 
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String url = claseUtilPlanillas.urlSysde('Test'); 
            request.setEndpoint(url + 'api/estadocapital/');
            request.setMethod('POST');
            claseEnvio.observacion = claseEnvio.codigoReferencia +'-Capital Semilla';
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug('Mandamos Cambio Estado: '+cons);
            request.setBody(cons);
            request.setTimeout(120000);
            HttpResponse response = new HttpResponse();
            if(!test.isRunningTest()){
                response = http.send(request); 
            }else{
                response.setBody('Proceso capital semilla procesado correctamente');
                response.setStatusCode(200);
            }
            respuesta = response.getBody();
            system.debug('Respuesta desde sysde: '+response.getBody());
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+ ', Linea: '+ex.getLineNumber());
        }
        return respuesta;
    }
    
    
    public class InformeReporteCalidad{
        public string accion {get;set;}
        public date desde {get;set;}
        public date hasta {get;set;}
    }
    
    
    public class ClassReporteCalidad {
        public string clienteUnicoBanco{get;set;}
        public string numContrato{get;set;}
        public string numCuenta{get;set;}
    }
    
    
    public class ConsultaCliente {
        
        public String tipoIdentificacion{get;set;}// pa.id_Personas
        public String identificacion{get;set;}// pa.id_Personas
        public String RTN{get;set;} //pa.peersona_fisicas
        public String clienteUnicoBanco{get;set;}//fo.fo_cuenta
        public String numContrato{get;set;}//fo.fo_cuenta
        public String numCuenta{get;set;}//fo.fo_cuenta
        public String primerNombre{get;set;}// pa.id_Personas
        public String segundoNombre{get;set;}// pa.id_Personas
        public String primerApellido{get;set;}// pa.id_Personas
        public String segundoApellido{get;set;}// pa.id_Personas
        public String codEmpresa {get;set;} //pa.info_laboral
        public String fatca{get;set;}//pa.id_Personas
        public String waiver{get;set;} //pa_personas_fisicas
        public String pep {get;set;}//pa_personas_fisicas
        public String procedencia{get;set;}//fo.fo_cuenta
        public String addendum{get;set;} //pa_personas_fisicas
        public String codSubProducto{get;set;}//fo.fo_cuenta
        public String tipoFondo{get;set;} //fo.fo_cuenta
        public String asesor {get;set;}
        
        public String EMP_AGN{get;set;} 
        public String COD_AGN  {get;set;}
        public String AGN {get;set;}
        public String FECHA_INGRESO {get;set;}
        public String tipoCliente {get;set;}
        public String TIPO_CLIENTE {get;set;}
        
        
        
    }
    public class ConsultaClienteCuenta {
        
        public string tipoIdentificacion{get;set;}
        public string identificacion{get;set;}
        //public string clienteUnicoBanco{get;set;}//fo.fo_cuenta
        //public string numContrato{get;set;}//fo.fo_cuenta
        public string numCuenta{get;set;}//fo.fo_cuenta
        public string primerNombre{get;set;}// pa.id_Personas
        public string segundoNombre{get;set;}// pa.id_Personas
        public string primerApellido{get;set;}// pa.id_Personas
        public string segundoApellido{get;set;}// pa.id_Personas
        public string codEmpresa {get;set;} //pa.info_laboral
        //public string fatca{get;set;}//pa.id_Personas
        //public string waiver{get;set;} //pa_personas_fisicas
        //public string pep {get;set;}//pa_personas_fisicas
        //public string procedencia{get;set;}//fo.fo_cuenta
        //public string addendum{get;set;} //pa_personas_fisicas
        public string codSubProducto{get;set;}//fo.fo_cuenta
        public string tipoFondo{get;set;} //fo.fo_cuenta
        public string asesor {get;set;}
        
        
    }
    
    public class classEstadoCapital{
        public string cuenta { get; set; }
        public boolean cambioEstado { get; set; }
        public boolean capitalSemilla { get; set; }
        public string nombre { get; set; }
        public string moneda { get; set; }
        public string monto { get; set; }
        public string formaPago { get; set; }
        public string codigoReferencia { get; set; }
        public string periodoAporte { get; set; }
        public string ctaDestino { get; set; }
        public string ctaOrigen { get; set; }
        public string observacion {get;set;}
        
        
    }

}