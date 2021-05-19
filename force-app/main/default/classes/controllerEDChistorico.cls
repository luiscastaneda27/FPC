public class controllerEDChistorico {
    public classECHistorico cuentas{get;set;}
    public Boolean rendimientoHNL {get;set;}
    public Boolean rendimientoUSD {get;set;}
    
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
            
            string idCliente=urlDecode.idcli;
            system.debug(urlDecode);
            list<classClientesEC> claseEnvio = new list<classClientesEC>();
            idCliente=urlDecode.idcli;
            string fDesde=urlDecode.desde;
            string fHasta=urlDecode.hasta;
            classClientesEC nueva = new classClientesEC();
            nueva.idCliente = idCliente;
            
            if(fDesde != null && fDesde != 'null'){
                nueva.Desde = date.valueOF(fDesde);
            }
            if(fHasta != null && fHasta != 'null'){
                nueva.hasta = date.valueOF(fHasta);
            }
            
            claseEnvio.add(nueva);
            string contenido;
            if(idCaso !=null){
                case caso = [select Estado_de_Cuenta_Historico__c from case where id=:idCaso];
                contenido = caso.Estado_de_Cuenta_Historico__c;
            }
            cuentas = contenido ==null ? (EstadosDeCuenta.estadoCuentaHistorico(claseEnvio))[0] : ((list<classECHistorico>)System.JSON.deserialize(contenido, list<classECHistorico>.class))[0];
                for(classECHistorico.classMovimientos item : cuentas.movimientos){
                    if(!rendimientoHNL && item.moneda.trim() == 'Lempiras' && cuentas.rendimientoLempiras != null
                       && !cuentas.rendimientoLempiras.contains('null') ){
                        rendimientoHNL = true;
                    }else if(!rendimientoUSD && item.moneda.trim() == 'Dólares' && cuentas.rendimientoDolares != null 
                       && !cuentas.rendimientoDolares.contains('null')){
                        rendimientoUSD = true;
                    }
                   
                }
                }Catch(Exception e){
                    
                }
    }
    public class VarURL
    {
        public string idcli{get;set;}
        public string desde{get;set;}
        public string hasta{get;set;}
        
    }
}