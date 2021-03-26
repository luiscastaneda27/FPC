global class ControladorCargaMasivaCarnet {
    
    public list<Carnet_masivo__c> listEmpleadosSF {get;set;}
    public list<Carnet_masivo__c> listEmpleadosNOSF {get;set;}
    public boolean mostrarEmpledosSF{get;set;}
    public boolean mostrarEmpledosNOSF{get;set;}
    public boolean CasosCreados{get;set;}
    map<string,string> mapIdentidades;
    public string urlPagina{get;set;}
    list<string> listcontac {get;set;}// = list<string>();
    public ControladorCargaMasivaCarnet(){
        urlPagina= null;
        Cerrar();
        //VerEmpleados();
    }
    
    public void Cerrar(){
        mostrarEmpledosNOSF = false;
        mostrarEmpledosSF = false;
        CasosCreados=false;
        if(urlPagina!=null){
            delete([select id from Carnet_masivo__c]);
        }
        urlPagina= null;
    }
    
    
    public void VerEmpleados(){
        try{
            mostrarEmpledosNOSF = false;
            mostrarEmpledosSF = false;
            listEmpleadosSF = new list<Carnet_masivo__c>();
            listEmpleadosNOSF = new list<Carnet_masivo__c>();
            list<string> listIdentidades = new list<string>();
            mapIdentidades= new map<string,string>();
            listcontac  =new list<string>();
            for(Carnet_masivo__c item : [select id, identificacion__C from Carnet_masivo__c]){
                listIdentidades.add(item.identificacion__C);
            }
            for(Account item : [select id, identificacion__C from account where identificacion__C in :listIdentidades]){
                if(!mapIdentidades.containsKey(item.identificacion__C)){
                    mapIdentidades.put(item.identificacion__C,item.id);
                    listcontac.add(item.id);
                }
            }
            for(Carnet_masivo__c item : [select cuenta__C, identificacion__C, name, apellido__C, cod_barra__c from Carnet_masivo__c]){
                if(mapIdentidades.containsKey(item.identificacion__C)){
                    listEmpleadosSF.add(item);
                    mostrarEmpledosSF=true;
                }else{
                    listEmpleadosNOSF.add(item);
                    mostrarEmpledosNOSF = true;
                }
                
            }
            if(mostrarEmpledosNOSF){
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Hemos encontrados empleados que no se encuentran en Salesforce, por favor verifique su identidad o de lo contrario no se imprimira el carnet'));
            }
        }catch(Exception ex){
            
        }
    }
    public void crearCasos(){
        try{
            id idTipoRegistro = [select id from RecordType where DeveloperName = 'Reposicion_Carnet' limit 1].id;
            list<case> listCasos = new list<case>();
            list<RepoCarnet> claseEnvio =new list<RepoCarnet>();
            map<string, string> mapContactos = new map<string, string>();
            for(contact item:[select id, account.identificacion__C from contact where accountId in :listcontac]){
                mapContactos.put(item.account.identificacion__C, item.id);
            }
            map<string, string> empleadosIngresados = new map<string, string>();
            for(integer i=0; i<listEmpleadosSF.size(); i++){
                if(!empleadosIngresados.containskey(listEmpleadosSF[i].identificacion__c)){
                    RepoCarnet c =new RepoCarnet();
                    c.identificacion = listEmpleadosSF[i].identificacion__c;
                    c.codigoBarra = listEmpleadosSF[i].cod_barra__c;
                    claseEnvio.add(c);
                    listCasos.add(new case(accountId = mapIdentidades.get(listEmpleadosSF[i].identificacion__c), RecordTypeID = idTipoRegistro,
                                           status = 'Cerrado', subject='Reposición Carnet', codigo_barra__C = listEmpleadosSF[i].cod_barra__c,  type='Solicitud de Gestión',
                                           Origin='Web', Priority= 'Media', ContactId = mapContactos.get(listEmpleadosSF[i].identificacion__c)));
                    empleadosIngresados.put(listEmpleadosSF[i].identificacion__c,'Hola');
                }
               
            }
           // boolean v =ReposicionCarnet(claseEnvio);
            insert listCasos;
            CasosCreados=true;
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Casos creados exitosamente, ya puede ver los carnet'));
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Lo sentimos pero ha ocurrido un error'));
        }
        
    }
    public void Imprimir(){
        urlPagina = 'vfFormatoCarnet';
    }
    @RemoteAction
    global static classWRetorno2 SUbirInformacion(String stringCSV, string empresa){
        classWRetorno2 retorno = new classWRetorno2();
        try{
            delete([select id from Carnet_masivo__c]);
            stringCSV = stringCSV.replace('\'', '');
            stringCSV = stringCSV.replace('´', '');
            list<string> clientes = new  list<string>();
            clientes = stringCSV.split('\n');
            retorno.error='Ya puede ver los empleados';
            integer nombre=15;
            integer apellido=15;
            integer cuenta=15;
            integer codigoBarra=15;
            integer identificacion=15;
            string encabezado=clientes[0];
            list<string> OrdenColumnas=encabezado.split(',');
            clientes.remove(0);
            
            for(integer i=0; i<OrdenColumnas.size(); i++){
                string ccs;
                //ccs.contains(str)
                if(OrdenColumnas[i]!=null && OrdenColumnas[i].trim()!='' && !OrdenColumnas[i].trim().contains('""')){
                    system.debug('Ordenar: '+OrdenColumnas[i].split('"')[1].Trim());
                    OrdenColumnas[i]=OrdenColumnas[i].split('"')[1].Trim();
                    if(OrdenColumnas[i].toUpperCase()=='NOMBRE' || OrdenColumnas[i].toUpperCase()=='NOMBRES'){
                        nombre=i;
                    }
                    if(OrdenColumnas[i].toUpperCase()=='NUM IDENTIDAD' || OrdenColumnas[i].toUpperCase()=='IDENTIFICACION'
                       || OrdenColumnas[i].toUpperCase()=='IDENTIDAD'
                       || OrdenColumnas[i].toUpperCase()=='IDENTIFICACIÓN' || OrdenColumnas[i].toUpperCase()=='NUMERO IDENTIDAD'
                       || OrdenColumnas[i].toUpperCase()=='NUM IDENTIFICACIÓN' || OrdenColumnas[i].toUpperCase()=='NUMERO IDENTIFICACIÓN'
                       || OrdenColumnas[i].toUpperCase()=='NUM IDENTIFICACION' || OrdenColumnas[i].toUpperCase()=='NUMERO IDENTIFICACION'){
                           identificacion=i;
                       }
                    if(OrdenColumnas[i].toUpperCase()=='APELLIDO' || OrdenColumnas[i].toUpperCase()=='APELLIDOS'){
                        apellido=i;
                    }
                    if(OrdenColumnas[i].toUpperCase()=='CUENTA' || OrdenColumnas[i].toUpperCase()=='CUENTAS'){
                        cuenta=i;
                    }
                    if(OrdenColumnas[i].toUpperCase()=='NUM_FORMULARIO' ){
                        codigoBarra=i;
                    }
                }
                
            }
            list<Carnet_masivo__c> listEmpleados = new list<Carnet_masivo__c >();
            if(codigoBarra != 15 && nombre != 15 && apellido != 15 && identificacion !=15 && cuenta !=15){
                for(integer i=0; i<clientes.size(); i++){
                    string columna = clientes[i].replace('"','');
                    list<string> listColumnas = columna.split(',');
                    listEmpleados.add(new Carnet_masivo__c(name = listColumnas[nombre], apellido__C = listColumnas[apellido],
                                                          cuenta__C = listColumnas[cuenta], cod_barra__c = listColumnas[codigoBarra],
                                                          identificacion__c = listColumnas[identificacion].replace('-','')));
                    
                }
                insert listEmpleados;
            }else{
                retorno.error='Estas columnas no traen el nombre correcto\n';
                if(Nombre==15){
                    retorno.error+='NOMBRE\n';
                }
                if(apellido==15){
                    retorno.error+='APELLIDO\n';
                }
                if(identificacion==15){
                    retorno.error+='IDENTIFICACION\n';
                }
                if(codigoBarra==15){
                    retorno.error+='NUM_FORMULARIO\n';
                }
                if(cuenta==15){
                    retorno.error+='CUENTA';
                }
            }
            return retorno;
        }catch(exception ex){
             retorno.error='Ha ocurrido un error inesperado, por favor revise el archivo e intente subirlo de nuevo '+ex.getMessage()+', Linea: '+ex.getLineNumber();
            
        }
        return retorno;
    }
    
    
    public class RepoCarnet{
        public string identificacion {get;set;}
        public string codigoBarra{get;set;}
    }
    
   /* public static boolean ReposicionCarnet(list<RepoCarnet> claseEnvio) {
  		Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtilPlanillas.urlSysde('Test'); 
        request.setEndpoint(url + 'api/reposicionCarnet');
        request.setMethod('POST');
        request.setTimeout(120000);
        try{
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido={"carnet":' + envio.contenido+'}';
            system.debug('Mandamos: '+cons);
            request.setBody(cons);
            HttpResponse response =new HttpResponse();
            if(!test.isRunningTest()){
               response = http.send(request); 
                system.debug('Respuesta: '+ response.getBody());
            }
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
        return true;
    }*/
    
    
    
}