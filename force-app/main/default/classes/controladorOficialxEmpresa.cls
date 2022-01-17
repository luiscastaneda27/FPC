public class controladorOficialxEmpresa {

    public list<Oficiales_X_Empresa__c > listAsesoresxOficiales {get;set;}
    public Oficiales_X_Empresa__c  AsesorxOficial {get;set;}
    //public list<user> listAsesores {get;set;}
    //public list<user> listOfiaales {get;set;}
    public string idAsesor {get;set;}
    public list<selectOption> listAsesores{get;set;}
    public list<selectOption> listEmpresas{get;set;}
    public list<selectOption> listOficiales{get;set;}
    public map<string, string> mapAsesores {get;set;}
    public map<string, string> mapCodigos {get;set;}

    
    public controladorOficialxEmpresa (){
        listAsesores = new list<selectOption>();
        listOficiales = new list<selectOption>();
        listEmpresas = new list<selectOption>();
        mapCodigos = new map<string, string>();
        listAsesores.add(new selectOption('', '--Ninguno--'));
        listOficiales.add(new selectOption('', '--Ninguno--'));
        for(user item :[select name, id ,codigo__C, profile.name from user where profile.name ='Asesores Financieros' OR profile.name ='Asesores Financieros Plataforma' OR profile.name = 'Servicio Cliente']){
            mapCodigos.put(item.id, item.codigo__C);
            if(item.profile.name =='Asesores Financieros' || item.profile.name =='Asesores Financieros Plataforma'){
                listAsesores.add(new selectOption(item.id, item.name));
                
            }else{
                listOficiales.add(new selectOption(item.id, item.name));
            }
        }
        for(Account item: [select id, name from Account  where recordtype.developername='Juridico' order by name asc]){
            listEmpresas.add(new selectOption(item.id, item.name));
        }
        inicio();
    }
    
    public void inicio(){
        try{
            AsesorxOficial = new Oficiales_X_Empresa__c ();
            listAsesoresxOficiales = new list<Oficiales_X_Empresa__c >();
            listAsesoresxOficiales = [select Oficial_SAC__c,asesor__C,Oficial_SAC__r.name, Asesor__r.name,id, Codigo_Oficial_SAC__C,
                           Codigo_Asesor__C, empresa__r.name from Oficiales_X_Empresa__c  where Oficial_SAC__c !=null and Asesor__c !=null  order by Oficial_SAC__r.name asc];
        }catch(exception ex){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,' Ha ocurrido un error, por favor contacte a sus administrador.'+ex.getLineNumber()));
        }
    }
    
    public void editar(){
        AsesorxOficial = new Oficiales_X_Empresa__c ();
        for(Oficiales_X_Empresa__c  item: listAsesoresxOficiales ){
            if(item.id == idAsesor){
                AsesorxOficial = item;
            }
        }
    }
    
    public void Guardar(){
        try{
            upsert AsesorxOficial;
            inicio();
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,' Datos Guardados Exitosamente.'));
        }catch(exception ex){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,' Ha ocurrido un error, por favor contacte a sus administrador.'+ex.getLineNumber()));
        }
    }
    
    public void selectAsesor(){
        AsesorxOficial.Codigo_Asesor__c = mapCodigos.containsKey(AsesorxOficial.Asesor__c) ? mapCodigos.get(AsesorxOficial.Asesor__c) : '';
    }
   
    public void selectOficial(){
        AsesorxOficial.Codigo_Oficial_SAC__c = mapCodigos.containsKey(AsesorxOficial.Oficial_SAC__c) ? mapCodigos.get(AsesorxOficial.Oficial_SAC__c) : '';
    }
    
    
    
}