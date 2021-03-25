public class controllerPortalFPC {
    public string identidad {get;set;}
    public list<Account> cuentas {get;set;}
    public Account cliente {get;Set;}
    public list<Lead> prospectos {get;set;}
    public Lead candidato {get;Set;}
    public boolean mostrarCliente {get;Set;}
    public boolean mostrarCandida {get;Set;}
    public list<SelectOption> objetos {get;set;}
    public list<ActivityHistory> actividades {get;set;}
    public list<Task> tareas {get;set;}
    public List<Document> documentos {get;set;}
    public string idObjeto {get;set;}
    public boolean pop1 {get;Set;}
    public boolean pop3 {get;Set;}
    public boolean pop4 {get;Set;}
    public boolean verDoc {get;set;}
    public boolean verImprimir {get;set;}
    public string idDoc {get;Set;}
    public task llamada {get;Set;}
    private RecordType natural;
    private map<id,Account> mapCuentas;
    private map<id, Lead> mapProspectos;
    public boolean registrar{get;Set;}
    public boolean registrar2{get;Set;}
    private string origen;
    private string usuario;
    
    public boolean esBanco{get;set;}
    public boolean esCallCenter{get;set;}
    
    public list<Case> listCasos{get;set;}
    public string nCasoBuscar{get;Set;}
    
    public Fantasma_portal__c fantasma{get;Set;}
    
    public string pccodpais /*Pais_Direccion*/ {get;set;}
    public string pcDeptoCN /*Depto_Direccion*/ {get;set;}
    public List<SelectOption> opcionPais {get;set;}
    public List<SelectOption> opcionDepartamento {get;set;}
    
    public string pais {get; set;}
    public string depto {get; set;}
    
    public list<selectoption> getPaises() {
       list<selectoption> options= new list<selectoption>();
       list<Pais_R__c> pais= [select Id,Name,codigo__c,nombre__c from Pais_R__c];
       options.add(new selectoption('0', ' --Ninguno-- '));
       for(Pais_R__c c:pais){
           options.add(new selectoption(c.codigo__c,c.nombre__c));
       }
       return options;
   }
   
   public list<selectoption> getDepart(){ 
       list<selectoption> options= new list<selectoption>();
       list<Departamentos__c> depto= [select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: pais];
       options.add(new selectoption('0', ' --Ninguno-- '));   
       for( Departamentos__c c:depto){ options.add(new selectoption(c.Departamento__c,c.Departamento__c));
       }
       return options;   
   }
    
    public controllerPortalFPC(){
        cuentas = new list<Account>();
        prospectos = new list<Lead>();
        cliente = new Account();
        Candidato = new Lead();
        llamada = new task();
        actividades = new list<ActivityHistory>();
        tareas = new list<Task>();
        documentos = new List<Document>();
        identidad = '';
        mostrarCliente = false;
        mostrarCandida = false;
        objetos = new list<SelectOption>();
        objetos.add(new selectOption ( 'Prospecto', 'Prospecto' ));
        idObjeto = 'Prospecto';
        pop1 = false;
        pop3 = false;
        pop4 = false;
        verDoc = false;
        verImprimir = false;
        registrar = false;
        registrar2 = false;
        idDoc = '';
        
        origen = '';
        usuario = '';
        nCasoBuscar = '';
        
        fantasma = new Fantasma_portal__c();
        
        usuario = Apexpages.currentPage().getParameters().get('usuario');
        
        esBanco = False;
        esCallCenter = False;
        origen = Apexpages.currentPage().getParameters().get('origen');
        if(origen != null && origen != ''){
            if(origen == 'Agencias_Banco'){
                esBanco = true;
            }
            else if (origen == 'Centro_Llamadas'){
                esCallCenter = true;    
            }
        }
        mapCuentas = new map<id,Account>();
        natural = [Select id From RecordType Where sObjectType = 'Lead' AND DeveloperName = 'Natural' Limit 1];
        
        documentos = [Select name, Type, Description From Document Where FolderId = '00lj00000017bHo' Limit 50 ];
        //idDoc = documentos[0].id;

    }
    
    public void llenarDepartamento()
    {
        try
        {
            opcionDepartamento = new list <selectOption>();
            opcionDepartamento.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Departamentos__c item:[select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: pccodpais])
            { opcionDepartamento.add(new selectOption(item.codigo_departamento__c, item.Departamento__c)); }
        }catch(exception e){
            
        }
    }
    
    public void llenarPais()
    {
        try
        {   opcionPais.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
         for (Pais_R__c item:[select nombre__c, codigo__c from Pais_R__c])
         { opcionPais.add(new selectOption(item.codigo__c, item.nombre__c)); }
         
        }catch(exception e){
            
        }
    }
    
    public pageReference buscar(){
        cliente = new Account();
        candidato = new Lead();
        cuentas = new list<Account>();
        prospectos = new list<Lead>();
        registrar = false;
        registrar2 = false;
        fantasma = new fantasma_portal__c();
        
        if(identidad.length() > 20){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Número de identidad muy largo.')); return null;
        }
        
        String query = 'Select Id,Name, Identificacion__c,PersonContactId,Tipo_Identificacion__c,Cliente_Unico_Banco__c,IsPersonAccount,Correo_Electronico_Oficina__c,Telefono_actual__c,Correo_actual__c';
        query += ',Phone,OwnerId From Account Where ';
        
        if(identidad != '')
            query += ' Identificacion__c = \'' + identidad + '\'';
        else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No has seleccionado ningún filtro'));
            return null;
        }    
        
        cuentas = dataBase.query(query);
        mapCuentas = new map<id,Account>(cuentas);
        
        if(cuentas.size() == 0 ){
            mostrarCliente = False;
            String queryP = 'Select Id,Name,Cliente_Unico_Banco__c,Identificacion__c,Tipo_Identificacion__c,email,Telefono_actual__c, OwnerId  From Lead Where ';
            if(identidad != '')
                queryP += ' Identificacion__c = \'' + identidad + '\'';            
                
            prospectos = dataBase.query(queryP);
            mapProspectos = new map<id, Lead>(prospectos);
            
            if(prospectos.size() == 0){    
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se encontraron coincidencias'));
                mostrarCandida = False;
                candidato.Identificacion__c = identidad;
                
                pop1 = true;
                return null;
            }else{
                mostrarCandida = True;
                return null;
            }
        }
        mostrarCandida = False;
        mostrarCliente = True;
        
            
        return null;
    }
    
    public pageReference verimprimir2(){
        verImprimir = false;
        if(candidato.Motivo_Contacto__c == 'Asesoría Producto Individual' || candidato.Motivo_Contacto__c == 'Asesoría Producto Empresarial')
            verImprimir = true;
            
        return null;
    }
    
    public pageReference imprimir(){
        if(candidato.Motivo_Contacto__c == 'Asesoría Producto Individual'){
            return new pageReference ('/apex/vfPDFProductoIndividual');
            
        }else if(candidato.Motivo_Contacto__c == 'Asesoría Producto Empresarial'){
            return new pageReference ('/apex/vfPDFProductoEmpresarial');  
        }      
        return null;
    }
    
    public pageReference documentos(){
        if(!verDoc)
            verDoc = true;
        else
            verDoc = false;    
        return null;
    }
    
    public pageReference ver(){
        actividades = new list<ActivityHistory>();
        tareas = new list<Task>();
        listCasos = new list<Case>();
        
        if(cliente.id != null){
            buscarCasos();
            
            for( Account a : [Select a.name, (Select subject,WhoId,ActivityDate,Status,description from activityHistories ORDER BY ActivityDate ) From account a Where id =: cliente.id]) {
                   for(activityHistory AH : a.activityHistories) {
                       actividades.add(AH);
                   }
            }
            for( Account a : [Select a.name, (Select subject,WhatId,ActivityDate,Status,description,ownerId from Tasks ORDER BY ActivityDate ) From account a Where id =: cliente.id]) {
                   for(Task AH : a.Tasks) {
                       tareas.add(AH);
                   }
            }
            registrar = true;    
        }else{
            for( Lead a : [Select a.name, (Select subject,WhoId,ActivityDate,Status,description from activityHistories ORDER BY ActivityDate ) From Lead a Where id =: candidato.id]) {
                   for(activityHistory AH : a.activityHistories) {
                       actividades.add(AH);
                   }
            }
            for( Lead a : [Select a.name, (Select subject,WhoId,ActivityDate,Status,description,ownerId from Tasks ORDER BY ActivityDate ) From Lead a Where id =: candidato.id]) {
                   for(Task AH : a.Tasks) {
                       tareas.add(AH);
                   }
            }
            registrar2 = true; 
        }      
        
        return null;
    }
    
                                                        // CREACIÓN DE CASOS
    public void buscarCasos(){
        try{
            String queryC = 'Select CaseNumber, Subject, Status, CreatedDate, RecordTypeID';
            queryC += ' From Case';
            queryC += ' Where AccountId = \'' + cliente.id + '\'';
            if(nCasoBuscar != null && nCasoBuscar != ''){
                queryC += ' AND CaseNumber Like \'%' + nCasoBuscar + '%\'';
            }
            queryC += ' Order by createdDate desc Limit 15';
            
            listCasos = dataBase.query(queryC); 
        }Catch(Exception e){}
    }
    
    public extensionCasoDetalle claseCasoD{get;set;}   
    
    public void nuevoCaso(){
        Case nuevoCaso = new Case();
        nuevoCaso.Accountid = cliente.id;
        nuevoCaso.ContactId = mapCuentas.get(cliente.id).PersonContactId;
        nuevoCaso.origin = origen;
        nuevoCaso.Usuario_referencia__c = usuario;
        
        try{
            claseCasoD = new extensionCasoDetalle(new ApexPages.StandardController(nuevoCaso));
            claseCasoD.popCaso = true;
            claseCasoD.esBanco = esBanco;
            claseCasoD.esCallCenter = esCallCenter;
        }Catch(Exception e){
            system.debug('Casos ' + e.getMessage() + ' linea : ' + e.getLineNumber());
        }
    }
    
    public string idCaso{get;set;}
    
    public void verCaso(){
            claseCasoD = new extensionCasoDetalle();
            claseCasoD.idCaso = idCaso;
            claseCasoD.verCaso();
            
    }
    
    public pageReference crear(){
        pop3 = true;
        pop1 = False;
        return null;
    }
    
    public pageReference cerrar(){
        pop1 = False;
        pop3 = False;
        pop4 = False;
        return null;
    }
    
    public pageReference guardarPop(){
    
        if(pais == '0') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe seleccionar un País ')); return null;    
        }
            
        if(depto == '0') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe seleccionar un Estado/Departamento ')); return null;  
        }
           
        list<Pais_R__c> FpaisC= [select Id,Name,codigo__c,nombre__c from Pais_R__c where codigo__c =: '074'];
        string vPaisC = FpaisC[0].codigo__c;
        
        if(candidato.Phone.length() > 8 && pais == vPaisC){       
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Teléfono Movil excede la cantidad de 8 caracteres permitidos'));
            return null;    
        }
        if(candidato.Telefono_Trabajo__c != null){
            if(candidato.Telefono_Trabajo__c.length() > 8 ){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Teléfono Trabajo excede la cantidad de 8 caracteres permitidos'));
                return null;
            }
        }
            
        candidato.RecordTypeId = natural.id;
        candidato.status = 'En Proceso';
        candidato.LeadSource = 'Agencias Banco';
        
        try{
        
            list<Pais_R__c> Fpais= [select Id,Name,codigo__c,nombre__c from Pais_R__c where codigo__c =: pais];
            string vPais = Fpais[0].Id;
            
            list<Departamentos__c> Fdepto= [select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: pais];
            string vDepto = Fdepto[0].Id;
        
            candidato.LeadSource = origen;
            candidato.Usuario_Referencia__c = usuario;
            candidato.F_Hon_USA_PCCA__c = true;
            candidato.F_Pais__c = vPais;
            candidato.F_Estado__c = vDepto;
            insert candidato;
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Número de identidad ya asignado.'));    
            return null;
        }    
        if(candidato.Motivo_Contacto__c == 'Asesoría Producto Individual'){
            return new pageReference ('/apex/vfPDFProductoIndividual');
            
        }else if(candidato.Motivo_Contacto__c == 'Asesoría Producto Empresarial'){
            return new pageReference ('/apex/vfPDFProductoEmpresarial');  
        }   
        pop3 = False;
                
        return null;
    }
    
    public pageReference registrarLlamada(){
        pop4 = True; 
        
        return null;
    }
    
    public pageReference guardarLlamada(){
        if(fantasma.Telefono_actual__c.length() > 8){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Teléfono excede la cantidad de 8 caracteres permitidos'));
            return null;    
        }
        
        if(cliente.id != null){
            system.debug(cliente);
            fantasma.Name = 'cliente';    
            fantasma.id_Actualizar__c = cliente.id;
            fantasma.Asignado_A__c = mapCuentas.get(cliente.Id).ownerId;        
        }else if(candidato.id != null){
            fantasma.Name = 'candidato';
            fantasma.id_Actualizar__c = candidato.id;     
            fantasma.Asignado_A__c = mapProspectos.get(candidato.Id).OwnerId;    
        }
            fantasma.origen__c = origen;
            fantasma.usuario_referencia__c = usuario; 
        
        try{
            system.debug(fantasma);
            insert fantasma;
        
        }catch(Exception e)
        {
            system.debug(e.getMessage());    
        }
        
        pop4 = False;
        ver();
        return null;
    }
  
}