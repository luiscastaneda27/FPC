public class ControladorEstadoDeCuentaPlanilla {

    public Date desde {set;get;}
    public Date hasta {set;get;}
    public String empresa{get;set;}
    public String usuario{get;set;}
    public Usuario_X_Empresa__c usuarioEmpresa{get;set;}
    public EstadosDeCuenta.VarURL datosEDC{get;set;}
    public String urlPagina{get;set;}
    Tiempo_Inactividad__c hora {get;set;}
    
    public ControladorEstadoDeCuentaPlanilla(){
        empresa = ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
        Usuario = ApexPages.currentPage().getParameters().get('loetdncdhjch'); 
        usuarioEmpresa = [Select Empresa2__r.Name, empresa2__C, Usuario__r.Name,
                          Empresa2__r.Identificacion__c
                          from Usuario_X_Empresa__c 
                          where Empresa2__c =: empresa
                          AND Usuario__c =: Usuario Limit 1];
        hora = [select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
    }
    public void generarEDC(){
        datosEDC = new EstadosDeCuenta.VarURL();
        datosEDC.idcli = usuarioEmpresa.Empresa2__r.Identificacion__c;
        //datosEDC.idcli ='08019014681811';
        datosEDC.desde = String.valueOf(desde);
        datosEDC.hasta = String.valueOf(hasta);
        string contenido =JSON.serialize(datosEDC);
        string varBase64 = EncodingUtil.base64Encode(Blob.valueof(contenido));
        urlPagina  = ClaseUtil.urlSysde('Empresarial')+'vfEstadoCuentaDetalleMovimientosPDF?zyx='+varBase64;
    }
    
    public void cerrar(){
        urlPagina = null;
        hora.Hora_ultima_consulta__c = System.now();
        update hora;
    }
}