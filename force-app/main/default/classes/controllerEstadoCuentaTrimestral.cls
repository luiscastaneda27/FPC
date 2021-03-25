public class controllerEstadoCuentaTrimestral {
    public classECTrimestral cuentas{get;set;}
    public List<wTrimestral> listCuentas{get;set;}
    public boolean mostrarHNL {get;set;}
    public boolean mostrarUSD {get;set;}
    public string grafico {get;set;}
    public boolean mostrarSigPagina {get;set;}
    
    public controllerEstadoCuentaTrimestral() {
        try{
            mostrarSigPagina =false;
            string url =ApexPages.currentPage().getParameters().get('zyx');
            string idCaso = ApexPages.currentPage().getParameters().get('idCaso');
            string nombreVF = ApexPages.currentPage().getURL();
            //string tipo = ApexPages.currentPage().getParameters().get('tipo');
            varurl urlDecode = new varurl();
            
            
            
            
            if (url !=null && url!=''){
                Blob d = EncodingUtil.base64Decode(url);
                urlDecode= (varurl)System.JSON.deserialize(d.tostring(), varurl.class);
            }
            
            string idCliente=urlDecode.idcli;
            
            listCuentas = new list<wTrimestral>();
            list<classClientesEC> claseEnvio = new list<classClientesEC>();
            
            classClientesEC nueva = new classClientesEC();
            nueva.idCliente = idCliente;
            String fDesde;// = ApexPages.currentPage().getParameters().get('fDesde');
            fDesde=urlDecode.desde;
            if(fDesde != null && fDesde != 'null')
                nueva.Desde = date.valueOF(fDesde);
            
            String fHasta;// = ApexPages.currentPage().getParameters().get('fHasta');
            fHasta=urlDecode.hasta;
            if(fHasta != null && fHasta != 'null')
                nueva.hasta = date.valueOF(fHasta);
            claseEnvio.add(nueva);
            mostrarHNL=false;
            mostrarUSD=false;
            
            integer indice = 0;
            integer y = 1;
            string contenido =null;
            if(idCaso != null ){
                Case caso =[select id, Estado_de_Cuenta__c from case where id=:idCaso];
                contenido = caso.Estado_de_Cuenta__c;
            }
            list<classECTrimestral.classECCuenta> detallesTmps = new list<classECTrimestral.classECCuenta>();
            cuentas = contenido == null ? (EstadosDeCuenta.estadoCuentaTrimestral(claseEnvio)[0]) : ((list<classECTrimestral>)System.JSON.deserialize(contenido, list<classECTrimestral>.class))[0];              
            nombreVF = nombreVF !=null ?nombreVF.toUpperCase():'Nada';
            mostrarSigPagina = cuentas.cuentas.size()> 2 ? true: false;
            for(integer i = 0; i < cuentas.cuentas.size(); i++){
                indice +=1;
                classECTrimestral.classECCuenta g = cuentas.cuentas.get(i);
                if(nombreVF.contains('PDFESTADODECUENTA') ){
                    g.porcentajeMisAportes = g.porcentajeMisAportes !=null ? g.porcentajeMisAportes.replace('% ','') : g.porcentajeMisAportes;
                    g.porcentajeEmpleadorAportes = g.porcentajeEmpleadorAportes !=null ? g.porcentajeEmpleadorAportes.replace('% ','') : g.porcentajeEmpleadorAportes;
                    g.porcentajeFicohsaAportes = g.porcentajeFicohsaAportes !=null ? g.porcentajeFicohsaAportes.replace('% ','') : g.porcentajeFicohsaAportes;
                    
                }
                g.grafico = g.grafico.replace('200px','100px');
                g.grafico = g.grafico.replace('400px','200px');
                detallesTmps.add(g); 
                
                if (indice == 2 || i == cuentas.cuentas.size()-1){
                    if(indice == 1 && i == cuentas.cuentas.size()-1){
                        detallesTmps.add(new classECTrimestral.classECCuenta()); 	    
                    }
                    listCuentas.add(new wTrimestral(y, detallesTmps));
                    detallesTmps = new list<classECTrimestral.classECCuenta>();
                    indice = 0; 
                    y++;
                }
                
            }
            for(integer j=0; j<listCuentas.size(); j++)
            {
                for(integer i=0; i<listCuentas[j].cuentas.size(); i++)
                {
                    if(listCuentas[j].cuentas[i].moneda=='LEMPIRAS')
                    {
                        mostrarHNL=true;
                    }
                    if(listCuentas[j].cuentas[i].moneda=='DOLARES')
                    {
                        mostrarUSD=true;
                    }
                }
            }
            
            system.debug(listCuentas);    
        }Catch(Exception e){
            system.debug(e.getMessage() + ' Linea ' + e.getLineNumber());
        }
    } 
    
    public class wTrimestral{
        public integer linea{get;set;}
        public List<classECTrimestral.classECCuenta> cuentas{get;set;}
        
        public wTrimestral(integer linea, List<classECTrimestral.classECCuenta> cuentas){
            this.linea = linea;
            this.cuentas = cuentas;
        }
        
    }
    public class VarURL
    {
        public string idcli{get;set;}
        public string desde{get;set;}
        public string hasta{get;set;}
        
    }
    
    
    public class ResumenDeAhorroCuenta{
        public string cuenta {get;set;}
        public decimal porcentajeMisAportes {get;set;}
        public decimal porcentajeEmpleadorAportes {get;set;}
        public decimal porcentajeFicohsaAportes {get;set;}
    }
    
    public class ImagenPorcentajesAhorro{
        public string cuenta {get;set;}
        public string graficoBase64 {get;set;}
        
        
    }
    
    
    
    
}