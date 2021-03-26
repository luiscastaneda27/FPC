public without sharing class controladorEstadoCuentaMasivo {
    public list<classECHistorico> cuentas{get;set;}
    list<empresas> listEmpresas {get;set;}
    public boolean nombreCorrecto {get;set;}
    map<string, integer> mapMeses = new map<string, integer>();
    
    public controladorEstadoCuentaMasivo(ApexPages.StandardController c) {
        try{
            listEmpresas = new list<empresas>();
            string nombreEmpresa =  ApexPages.currentPage().getParameters().get('idCliente').replace('+',' ');
            system.debug('Parametro: '+nombreEmpresa);
            nombreCorrecto = false;
            //nombreEmpresa = 'INVERSIONES ARABE S.A. DE C.V.';
            string contenido = 'contenido={"nEmpresa":"'+nombreEmpresa+'","accion":"OPDF"}';
            listEmpresas = asysdecallouts.Empresas();
            system.debug('Tamano de EMpresas: '+listEmpresas.size());
            for(empresas item : listEmpresas){
                if(item.nombreEmpresa == nombreEmpresa){
                    nombreCorrecto = true;
                }
            }
            
            
            mapMeses.put('JAN', 1);
            mapMeses.put('ENE', 1);
            mapMeses.put('FEB', 2);
            mapMeses.put('MAR', 3);
            mapMeses.put('APR', 4);
            mapMeses.put('ABR', 4);
            mapMeses.put('MAY', 5);
            mapMeses.put('JUN', 6);
            mapMeses.put('JUL', 7);
            mapMeses.put('AUG', 8);
            mapMeses.put('AGO', 8);
            mapMeses.put('SEP', 9);
            mapMeses.put('OCT', 10);
            mapMeses.put('NOV', 11);
            mapMeses.put('DEC', 12);
            mapMeses.put('DIC', 12);
            map<string, classECHistorico> mapEDC = new map<string, classECHistorico>();
            if(nombreCorrecto){
                cuentas = estadoCuentaHistoricoMasivo(contenido);
                system.debug('Tamano: '+cuentas.size());
                list<string> nombrePersonas =new list<string>();
                for(integer i=0; i<cuentas.size(); i++){
                    nombrePersonas.add(cuentas[i].nombreCliente);
                    mapEDC.put(cuentas[i].nombreCliente, cuentas[i]);
                    if(cuentas[i].fecha != null){
                        cuentas[i].fecha = converitFecha(cuentas[i].fecha); 
                    }
                    cuentas[i].SaltoPagina =  'page-break-after: always';
                    system.debug('Movimientos: '+cuentas[i].movimientos);
                    for(classECHistorico.classMovimientos item : cuentas[i].movimientos){
                        item.totalPersonal = item.totalPersonal != null && item.totalPersonal.trim() !='' ? formatoNumero(decimal.valueOf(item.totalPersonal.replace(',','.'))) : '0.0';
                        item.totalPatronal = item.totalPatronal != null && item.totalPatronal.trim() != '' ? formatoNumero(decimal.valueOf(item.totalPatronal.replace(',','.'))) : '0.0';
                        item.granTotal = item.granTotal != null && item.granTotal.trim() != '' ? formatoNumero(decimal.valueOf(item.granTotal.replace(',','.'))) : '0.0';
                        
                        for(classECHistorico.classTransaccion itemTra: item.transacciones){
                            itemTra.aportePersonal = itemTra.aportePersonal != null ? itemTra.aportePersonal : '0.0';
                            itemTra.aportePatronal = itemTra.aportePatronal != null ?itemTra.aportePatronal : '0.0';
                            itemTra.aporteTotal = itemTra.aporteTotal != null ? itemTra.aporteTotal : '0.0';
                            
                            itemTra.aportePersonal = itemTra.aportePersonal.substring(0, 1) == ',' ? '0.'+itemTra.aportePersonal.substring(1, itemTra.aportePersonal.length()) : itemTra.aportePersonal;
                            itemTra.aportePatronal = itemTra.aportePatronal.substring(0, 1) == ',' ? '0.'+itemTra.aportePatronal.substring(1, itemTra.aportePatronal.length()) : itemTra.aportePatronal;
                            itemTra.aporteTotal = itemTra.aporteTotal.substring(0, 1) == ',' ? '0.'+itemTra.aporteTotal.substring(1, itemTra.aporteTotal.length()) : itemTra.aporteTotal;
                            
                            
                            itemTra.aportePersonal = itemTra.aportePersonal != null ? formatoNumero(decimal.valueOf(itemTra.aportePersonal.replace(',','.'))) : '0.0';
                            itemTra.aportePatronal = itemTra.aportePatronal != null ? formatoNumero(decimal.valueOf(itemTra.aportePatronal.replace(',','.'))) : '0.0';
                            itemTra.aporteTotal = itemTra.aporteTotal != null ? formatoNumero(decimal.valueOf(itemTra.aporteTotal.replace(',','.'))) : '0.0';
                            if(itemTra.fecha !=null){
                                itemTra.fecha = converitFecha(itemTra.fecha);
                            }
                        }
                        integer posicion = 0;
                        list<Integer> listPosiciones = new list<Integer>();                        
                        for(classECHistorico.classTransaccion itemTra: item.transacciones){
                            if(decimal.valueOf(itemTra.aporteTotal.replace(',','')) ==0 ){
                                listPosiciones.add(posicion);
                            }
                            posicion++;
                        }
                        Integer numBorrados = 0;
                        for(Integer numero: listPosiciones){
                            item.transacciones.remove((numero - numBorrados));
                            numBorrados++;
                        }
                           
                    }
                }
                nombrePersonas.sort();
                //cuentas.sort();
                system.debug('Personas: '+nombrePersonas.size());
                cuentas = new list<classECHistorico>();
                for(string item : nombrePersonas){
                   cuentas.add(mapEDC.get(item));
                }
                mapEDC = new map<string, classECHistorico>();
                cuentas[cuentas.size() -1].SaltoPagina =  '';
            }
        }Catch(Exception e){
            system.debug('Error: '+e.getMessage()+', Error: '+e.getLineNumber());
        }
    }
    
    
    public string converitFecha (string fecha){
        list<string> separador = new list<string>();
        separador = fecha.split('-');
        if(separador.size() > 2){
            integer respuesta = 0 ;
            string mes = separador[1];
            integer anio = integer.valueOf(separador[2])+ 2000;
            fecha =  separador[0]+'/'+mapMeses.get(mes)+'/'+anio;
            return fecha;
        }
        return fecha;
    }
    
    
    public class empresas {
        public string nombreEmpresa {get;set;}
    }
    
    
    public string formatonumero (decimal numero) {
        numero = numero !=null ? numero :0;
        string respuesta='0';
        string numerodecimal='.00';
        try {
            numero = numero.setScale(2);
            respuesta='';
            integer numeroentero = (integer) numero;
            respuesta = numeroentero.format();
            if(numeroentero < numero){
                decimal a = (integer)((numero - numeroentero)*100);
                if(a<10){
                    numerodecimal = '.0'+string.valueOf(integer.valueOf(a));
                }else{
                    numerodecimal = '.'+string.valueOf(integer.valueOf(a));
                }
            }
        }catch(exception ex) {
            return '0.00';
        }
        return respuesta+numerodecimal;
        
        //return '0.00';
    }
    
    public static list<classECHistorico> estadoCuentaHistoricoMasivo(string cons) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
		url='http://190.5.68.49:9090/';        
        request.setMethod('POST');
        //request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setEndpoint(url + 'api/ec/generaPDF');
        request.setTimeout(120000);
        list<classECHistorico> respuesta = new list<classECHistorico>();
        
        try{
            
            system.debug('Mandamos: '+cons);        
            request.setBody(cons);
            HttpResponse response =new HttpResponse();
            if(!test.isRunningTest()){
                response = http.send(request); 
            }else{
                response.setStatusCode(200);
                response.setBody('[{"fecha":"27/01/2020","nombreCliente":"WENDY PAOLINA AGUILAR ALVARADO","emailCliente":"wendyalvarez@gmail.com","numeroCliente":"179363","movimientos":[{"moneda":" Lempiras","cuenta":"51600","totalPersonal":"24554","totalPatronal":"24528.24","granTotal":"49086.18","transacciones":[{"fecha":"04/11/2019","descripcionTransaccion":"Saldo Acumulado al 4-DEC-19","aportePersonal":"131.07","aportePatronal":"130.90","aporteTotal":"0"},{"fecha":"12/12/20","descripcionTransaccion":"Aportes Ordinarios","aportePersonal":"811.30","aportePatronal":"811.30","aporteTotal":"1622.60"},{"fecha":"12/12/12","descripcionTransaccion":"Aportes Ordinarios","aportePersonal":"811.30","aportePatronal":"811.30","aporteTotal":"1622.60"},{"fecha":"15/01/2020","descripcionTransaccion":"Aportes Ordinarios","aportePersonal":"811.30","aportePatronal":"811.30","aporteTotal":"122.60"},{"fecha":"27/01/2020","descripcionTransaccion":"Intereses","aportePersonal":"22223.14","aportePatronal":"293.58","aporteTotal":"4416.72"},{"fecha":"27/01/2020","descripcionTransaccion":"Comisiones","aportePersonal":"-230.17","aportePatronal":"-230.14","aporteTotal":"-460.31"}]}]}]');
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
    
    
   
}