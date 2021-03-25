public class ExtensionEmpresasEDC {
    
    public string nombreEmpresa{get;set;}
    list<controladorEstadoCuentaMasivo.empresas> listEmpresas {get;set;}
    public list<selectOption> Empresas{get;set;}
    string idCliente;
    
    
    public ExtensionEmpresasEDC (ApexPages.StandardController c){
        idCliente = c.getId();
        listEmpresas = new list<controladorEstadoCuentaMasivo.empresas>();
        listEmpresas = asysdecallouts.Empresas();
        Empresas = new list<selectOption>();
        for(controladorEstadoCuentaMasivo.empresas item: listEmpresas){
            Empresas.add(new SelectOption(item.nombreEmpresa, item.nombreEmpresa));
        }
        Empresas.sort();
    }
    
    public PageReference ImprimirEDC(){
        //EncodingUtil.base64Encode(Blob.valueof(nombreEmpresa))
        return new PageReference('/apex/vfEstadoCuentaMasivo?id='+idCliente+'&idCliente='+nombreEmpresa);
    }

}