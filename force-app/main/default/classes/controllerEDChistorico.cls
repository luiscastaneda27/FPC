public class controllerEDChistorico {
    public classECHistorico cuentas{get;set;}
    public Boolean rendimientoHNL {get;set;}
    public Boolean rendimientoUSD {get;set;}
    
    public String textoFecha {get;set;}
    public String textoRendimientoHNL {get;set;}
    public String textoRendimientoUSD {get;set;}
    
    public controllerEDChistorico() {
        try{
            rendimientoHNL = false;
            rendimientoUSD = false;
            string url =ApexPages.currentPage().getParameters().get('zyx');
            string idCaso = ApexPages.currentPage().getParameters().get('idCaso');
            varurl urlDecode= new varurl();
            if(url!=null && url!='') {
                Blob d = EncodingUtil.base64Decode(url);
                urlDecode= (varurl)System.JSON.deserialize(d.tostring(), varurl.class);   
            }
            System.debug('urlDecode: '+urlDecode);
            string idCliente=urlDecode.idcli;
            system.debug(urlDecode);
            list<classClientesEC> claseEnvio = new list<classClientesEC>();
            idCliente=urlDecode.idcli;
            String fDesde;
            String fHasta;
            for(Cuentas__c item: [Select Fecha_Apertura__c from Cuentas__C where Fecha_Apertura__c != null And Cliente__r.Identificacion__c = :idCliente.replace('-', '') order by Fecha_Apertura__c asc limit 1]){
                fDesde = String.valueOf(item.Fecha_Apertura__c);
            }
            for(FechaDC_Sysde__c item: [Select Fecha_cierre__c From FechaDC_Sysde__c Where Name = 'CierreAlDia' Limit 1]){
                fHasta = String.valueOf(item.Fecha_cierre__c);
            }
            
            System.debug(urlDecode.desde+' Desde '+fDesde);
            System.debug(urlDecode.hasta+' Hasta '+fHasta);
            Integer diferencia = urlDecode.desde != null && urlDecode.desde.contains('18:00') ? 1 : 0;
            
            fDesde = urlDecode.desde != null && urlDecode.desde != 'null' ? urlDecode.desde : fDesde;
            fHasta = urlDecode.hasta != null && urlDecode.hasta != 'null' ? urlDecode.hasta : fHasta;
            
            classClientesEC nueva = new classClientesEC();
            nueva.idCliente = idCliente;
            
            if(fDesde != null && fDesde != 'null'){
                nueva.Desde = date.valueOF(fDesde).addDays(diferencia);
            }
            if(fHasta != null && fHasta != 'null'){
                nueva.hasta = date.valueOF(fHasta).addDays(diferencia);
            }
            claseEnvio.add(nueva);
            string contenido;
            if(idCaso !=null){
                case caso = [select Estado_de_Cuenta_Historico__c from case where id=:idCaso];
                contenido = caso.Estado_de_Cuenta_Historico__c;
            }
            if(contenido == null){
                if(urlDecode.esMasivo != null && urlDecode.esMasivo){
                    cuentas =  EstadosDeCuenta.estadoCuentaHistoricoMasivo(claseEnvio)[0];             
                }else{
                    cuentas =  EstadosDeCuenta.estadoCuentaHistorico(claseEnvio)[0];  
                }
            }else{
                cuentas = ((list<classECHistorico>)System.JSON.deserialize(contenido, list<classECHistorico>.class))[0];
            }
            system.debug('rendimientoDolares: '+cuentas.rendimientoDolares);
            system.debug('rendimientoLempiras: '+cuentas.rendimientoLempiras);
            //system.debug(cuentas.movimientos[0].moneda.trim() == 'Lempiras'+' -- '+cuentas.movimientos[0].moneda.trim() == 'Dólares');
            for(classECHistorico.classMovimientos item : cuentas.movimientos){
                if(!rendimientoHNL && item.moneda.trim() == 'Lempiras' && cuentas.rendimientoLempiras != null
                   && !cuentas.rendimientoLempiras.contains('null') ){
                       rendimientoHNL = true;
                   }else if(!rendimientoUSD && item.moneda.trim() == 'Dólares' && cuentas.rendimientoDolares != null 
                            && !cuentas.rendimientoDolares.contains('null')){
                                rendimientoUSD = true;
                            }
                
            }
            textoRendimientoHNL = urlDecode.esMasivo == null ? 'Rendimiento del período seleccionado' : urlDecode.esMasivo ? 'Rendimiento generado del año actual' : 'Rendimiento generado del mes';
            textoRendimientoUSD = textoRendimientoHNL;
            textoRendimientoHNL += ' (HNL): ';
            textoRendimientoUSD += ' (USD): ';
            if(nueva.desde != null && nueva.hasta != null){
                textoFecha = 'Período del';
                System.debug('Hora: '+datetime.now().hour());
                diferencia =  (datetime.now().hourGMT() - datetime.now().hour()) > 0 ? 1 : 0;
                nueva.desde = nueva.desde.addDays(diferencia);
                cuentas.fecha = nueva.desde.day()+'/'+(nueva.desde.month()<10 ? '0'+nueva.desde.month() : ''+nueva.desde.month())+'/'+nueva.desde.year()+' al '+cuentas.fecha;
                //cuentas.fecha = fechas[2]+'/'+fechas[1]+'/'+fechas[0]+' al '+cuentas.fecha;
                //textoRendimientoHNL = 'Rendimiento del período seleccionado (HNL):';
                //textoRendimientoUSD = 'Rendimiento del período seleccionado (USD):';
            }/*else{
                textoFecha = 'A la Fecha: ';
                textoRendimientoHNL = 'Rendimiento (HNL):';
                textoRendimientoUSD = 'Rendimiento (USD):';
            }*/
            
        }Catch(Exception e){
            system.debug(e.getLineNumber()+e.getMessage()); 
        }
    }
    public class VarURL {
        public string idcli{get;set;}
        public string desde{get;set;}
        public string hasta{get;set;}
        public Boolean esMasivo{get;set;}
    }
    
    
}