public without sharing class controladorReporteSeguienteSac {
    
    Public list<Reporte_Calidad__c> listReporte {get;set;} 
    Public list<selectOption> listEmpresas {get;set;} 
    Public list<selectOption> listOficiales {get;set;} 
    Public list<selectOption> listAsesores {get;set;} 
    public string filtroTipoCarga {get;set;}
    public string filtroEmpresa {get;set;}
    public string filtroAsesor {get;set;}
    public string filtroOficial{get;set;}
    public date filtroFechaDesde{get;set;}
    public date filtroFechaHasta{get;set;}
    public string filtroReporte{get;set;}
    public string filtroZona{get;set;}
    string usuario;
    //public string perfil {get;set;}
    public list<string> listAsesoresCS {get;set;}
    public list<string> listAsesoresNO {get;set;}
    public string nombreExcel {get;set;}
    
    public list<filtro> listOficialSac {get;set;}
    public list<filtro> listTipoCarga {get;set;}
    public list<filtro> listEmpresasN{get;set;}
    public list<filtro> listAsesoresN {get;set;}
    public boolean popEmpresas {get;set;}
    
    public Integer pagActual {get;set;}
    public Integer totalPag {get;set;}
    
    Public Boolean disabledSig {get;set;}
    Public Boolean disabledAnt {get;set;}
    
    public String whereQuery;
    
    
    public controladorReporteSeguienteSac(){
        try{
            usuario = ApexPages.currentPage().getParameters().get('usuario');
            //usuario = 'HN52892';
            popEmpresas = false;
            listAsesoresCS = new list<string>();
            listAsesoresNO = new list<string>();
            //perfil = [select perfil__C from Usuarios_de_Pantallas__c where Usuario__c =:usuario].perfil__C;
            listEmpresas = new list<selectOption>();
            listOficiales = new list<selectOption>();
            listAsesores = new list<selectOption>();
            
            listEmpresas.add(new selectOption('', '--Ninguno--'));
            listOficiales.add(new selectOption('', '--Ninguno--'));
            listAsesores.add(new selectOption('', '--Ninguno--'));
            
            listOficialSac = new list<filtro>();
            listTipoCarga = new list<filtro>();
            listEmpresasN = new list<filtro>();
            listAsesoresN = new list<filtro>();
            for(Oficiales_X_Empresa__c  item: 
                [select empresa__r.name, empresa__C, Codigo_Oficial_SAC__c from Oficiales_X_Empresa__c order by empresa__r.name asc]){
                    listEmpresas.add(new selectOption(item.empresa__C, item.empresa__r.name));
                    listEmpresasN.add(new filtro(item.empresa__C, item.empresa__r.name));                   
                    
                }
            map<string, integer> mapOficiales = new map<string, integer>();
            
            
            
            listTipoCarga.add(new filtro('I', 'Cliente Individual'));
            listTipoCarga.add(new filtro('C', 'Cliente por Carga'));
            listTipoCarga.add(new filtro('YC', 'Clientes Cargados'));
            listTipoCarga.add(new filtro('M', 'Afiliación Masiva'));
            listTipoCarga.add(new filtro('FC', 'FIcopen'));
            listTipoCarga.add(new filtro('BFK', 'Agencias BFH'));
            listTipoCarga.add(new filtro('PM', 'Premier'));
            
            for(oficial_x_asesor__C item: [select Oficial_SAC__r.name, Codigo_Oficial_SAC__c from oficial_x_asesor__C order by Oficial_SAC__r.name asc]){
                if(!mapOficiales.containsKey(item.Codigo_Oficial_SAC__c) && item.Codigo_Oficial_SAC__c !=null && item.Oficial_SAC__r.name !=null){
                    mapOficiales.put(item.Codigo_Oficial_SAC__c, 21);
                    listOficiales.add(new selectOption(item.Codigo_Oficial_SAC__c, item.Oficial_SAC__r.name));
                    listOficialSac.add(new filtro(item.Codigo_Oficial_SAC__c, item.Oficial_SAC__r.name));
                    
                }
            }
            for(Oficial_X_Asesor__c item: [select Codigo_Asesor__c, asesor__r.name, zona__C from Oficial_X_Asesor__c  
                                          where Codigo_Asesor__c != null order by asesor__r.name asc] ){
                //listAsesoresZonas.add(item.Codigo_Asesor__c);
                listAsesores.add(new selectOption(item.Codigo_Asesor__c, item.asesor__r.name));
                listAsesoresN.add(new filtro(item.Codigo_Asesor__c, item.asesor__r.name));
                if(item.zona__C == 'NO'){
                    listAsesoresNO.add(item.Codigo_Asesor__c);
                }else{
                     listAsesoresCS.add(item.Codigo_Asesor__c);
                }
                
            }
            filtroReporte ='3';
            //filtros ();
        }catch(exception ex){
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,' Ha ocurrido un error, por favor contacte a sus administrador.'+ex.getLineNumber()));
        }
    }
    
    public void popEmpresas(){
        filtroEmpresa ='';
        popEmpresas = true;
    }
     public void cerrar(){
        popEmpresas = false;
         filtros();
    }
    
    public void filtros (){
        try{
            string query = selectCapos();
            NombreExcel = null;
            disabledSig = true;
            disabledAnt = true;
            pagActual = 1;
            database.delete([select id from ConsultasRC__c where usuario__c = :usuario limit 9999], false);
            if(filtroReporte =='3'){
                 query += ' Where (estado__C != \'X\' ) ';   
                if(filtroZona != null ){
                    query += ' and Codigo_Asesor_Comercial__c in (';
                    for(string item: filtroZona == 'NO' ?  listAsesoresNO: listAsesoresCS){
                          query += ' \''+item+'\',';
                    }
                    query = query.substring(0, query.length()-1)+')';
                }
                
                //if(filtroAsesor != null){query += ' and Codigo_Asesor_Comercial__c = \''+filtroAsesor+'\'';}
                //if(filtroOficial != null){query += ' and Codigo_Oficial_SAC__c = \''+filtroOficial+'\'';}
                if(filtroFechadesde != null){query += ' and fecha_validacion__c >='+string.valueOf(filtroFechadesde).split(' ')[0];}
                if(filtroFechaHasta != null){query += ' and fecha_validacion__c <='+string.valueOf(filtroFechaHasta).split(' ')[0];}
                //if(filtroTipoCarga !=null && filtroTipoCarga.trim() !=''){query +=' and Tipo_Afiliacion__c =\''+filtroTipoCarga + '\'';}
                //if(filtroEmpresa !=null && filtroEmpresa.trim() !=''){query +=' and empresa__C =\''+filtroEmpresa + '\'';}
                string FN ='';
                for(filtro item : listEmpresasN){
                    if(item.seleccionado){
                        FN += ' \''+item.id+'\',';
                    }
                }
                if(FN !=''){
                    query += ' and empresa__C in ('+FN.substring(0, FN.length()-1 )+')';
                    FN = '';
                }
                for(filtro item : listOficialSac){
                    if(item.seleccionado){
                        FN += ' \''+item.id+'\',';
                    }
                }
                if(FN !=''){
                    query += ' and Codigo_Oficial_SAC__c in ('+FN.substring(0, FN.length()-1 )+')';
                    FN = '';
                }
                for(filtro item : listAsesoresN){
                    if(item.seleccionado){
                        FN += ' \''+item.id+'\',';
                    }
                }
                if(FN !=''){
                    query += ' and Codigo_Asesor_Comercial__c in ('+FN.substring(0, FN.length()-1 )+')';
                    FN = '';
                }
                for(filtro item : listTipoCarga){
                    if(item.seleccionado){
                        FN += ' \''+item.id+'\',';
                    }
                }
                if(FN !=''){
                    query += ' and Tipo_Afiliacion__c in ('+FN.substring(0, FN.length()-1 )+')';
                    FN = '';
                }        
            }else {
                query += ' Where (estado__C = \'D\' OR Fecha_Devolucion__c  !=null) ';
                if(filtroZona != null ){
                    query += ' and Codigo_Asesor_Comercial__c in (';
                    for(string item: filtroZona == 'NO' ?  listAsesoresNO: listAsesoresCS){
                        query += ' \''+item+'\',';
                    }
                    query = query.substring(0, query.length()-1)+')';
                }
                //if(filtroAsesor != null){query += ' and Codigo_Asesor_Comercial__c = \''+filtroAsesor+'\'';}
                //if(filtroOficial != null){query += ' and Codigo_Oficial_SAC__c = \''+filtroOficial+'\'';}
                if(filtroFechadesde != null){query += ' and Fecha_Devolucion__C  >='+string.valueOf(filtroFechadesde).split(' ')[0];}
                if(filtroFechaHasta != null){query += ' and Fecha_Devolucion__C <='+string.valueOf(filtroFechaHasta).split(' ')[0];}
                //if(filtroTipoCarga !=null && filtroTipoCarga.trim() !=''){query +=' and Tipo_Afiliacion__c =\''+filtroTipoCarga + '\'';}
                //if(filtroEmpresa !=null && filtroEmpresa.trim() !=''){query +=' and empresa__C =\''+filtroEmpresa + '\'';}
                
                string FN = '';
                for(filtro item : listEmpresasN){
                    if(item.seleccionado){
                        FN += ' \''+item.id+'\',';
                    }
                }
                if(FN !=''){
                    query += ' and empresa__C in ('+FN.substring(0, FN.length()-1 )+')';
                    FN = '';
                }
                for(filtro item : listOficialSac){
                    if(item.seleccionado){
                        FN += ' \''+item.id+'\',';
                    }
                }
                if(FN !=''){
                    query += ' and Codigo_Oficial_SAC__c in ('+FN.substring(0, FN.length()-1 )+')';
                    FN = '';
                }
                for(filtro item : listAsesoresN){
                    if(item.seleccionado){
                        FN += ' \''+item.id+'\',';
                    }
                }
                if(FN !=''){
                    query += ' and Codigo_Asesor_Comercial__c in ('+FN.substring(0, FN.length()-1 )+')';
                    FN = '';
                }
                for(filtro item : listTipoCarga){
                    if(item.seleccionado){
                        FN += ' \''+item.id+'\',';
                    }
                }
                if(FN !=''){
                    query += ' and Tipo_Afiliacion__c in ('+FN.substring(0, FN.length()-1 )+')';
                    FN = '';
                }
            }
            cargarMapa(query);
            popEMpresas = false;
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,' Ha ocurrido un error, por favor contacte a sus administrador.'));
        }
        
    }
    
    public string selectCapos(){
        return 'select Addendum__c, Aplica_CS__c , Aportacion_HNL__c ,Aportacion_USD__c ,'+
            'Asesor_Comercial__c, Comentarios__c, Codigo_Asesor_Comercial__c,Codigo_Oficial_SAC__c ,'+
            'Empresa__c , Expediente_Completo__c , FATCA__c , Fecha_Envio_Memo__c, Fecha_Validacion__c ,'+
            'Fecha_Inicio_Aporte__c , Forma_Pago__c, Formulario_Completo__c, Identificacion__c ,'+
            'Numero_de_Cliente__c , Numero_de_Contrato__c ,Numero_Cuenta__c ,Oficial_SAC__c ,PEP__c ,'+
            'Periodicidad__c , name , Procedencia__c , Reporte_Calidad__c,RTN__c ,'+
            'Estado__c, fecha_devolucion__C,Enviar_Afiliacion__C,ExpedienteFisicoRecibido__c,TipoCLiente__c,'+
            ' Entrega_KIT__c, Fecha_Entrega_Kit_SAC__c, Fecha_Entrega_Kit__c ,'+
            'NombreEmpleadoAGN__c,CodigoEmpleadoAGN__c, FechaIngreso__c, NombreAgencia__c,CodigoAGN__c,'+ 
            'CurrencyIsoCode,Nacionalidad__c, sexo__C,fecha_nacimiento__C,Fecha_ingreso_empresa__C,'+
            'profesion__C,estado_civil__C, lugar_nacimiento__C,nombre_conyuge__C,cargo__C,'+
            'Primer_Apellido__c,Enviar_Sac__C,Tipo_Afiliacion__c,Aprueba_SAC__c ,'+
            'Subproducto__r.name,Empresa__r.name, Subproducto__r.producto__r.name,Espediente_Completo__C,'+
            'Segundo_Apellido__c ,Segundo_Nombre__c , Seguro_HNL__c , Seguro_USD__c ,Subproducto__c ,'+
            'Tiene_Id__c , Tipo_Fondo__c , Tipo_Identificacion__c ,WAIVER__c from Reporte_Calidad__c ';
    }
    
    public void cargarMapa(String query){
        try{
            List<ConsultasRC__c> listIdsConsulta = new List<ConsultasRC__c>();
            whereQuery = query.split('Where')[1];
            String queryPag ='Select Id from Reporte_Calidad__c Where '+whereQuery+' order by name asc limit 47500';
            Decimal pag = 1;
            List<String> idRC = new List<String>();
            system.debug('query: '+queryPag);
            Boolean v = false;
            for(Reporte_Calidad__c item : database.query(queryPag)){
                v = true;
                idRC.add(item.Id);
                if(idRC.size() == Integer.valueOf(Label.LimitQueryRC)){
                    listIdsConsulta.add(new ConsultasRC__c(usuario__c = usuario, IdsConsulta__c	= Json.serialize(idRC), NumPagina__c = pag));
                    pag ++;
                    idRC = new List<String>();
                }
                if(listIdsConsulta.size() == 100){
                    listIdsConsulta = insertConsulta(listIdsConsulta);
                }
            }
            if(idRC.size() > 0){
                listIdsConsulta.add(new ConsultasRC__c(usuario__c = usuario, IdsConsulta__c	= Json.serialize(idRC), NumPagina__c = pag));
            }
            listIdsConsulta = insertConsulta(listIdsConsulta);
            totalPag = Integer.valueOf(pag);
            if(v){
                cargarRegistros(1);
                disabledSig = totalPag > 1 ? false : true;
            }else{
                listReporte = new List<Reporte_Calidad__c>();
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.warning,' No se han encontrado coincidencias.'));
            }
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,' Ha ocurrido un error, por favor contacte a sus administrador.'));
        }
    }
    
    public List<ConsultasRC__c> insertConsulta (List<ConsultasRC__c> listIdsConsulta){
        try{    
            insert listIdsConsulta;
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,' Ha ocurrido un error, por favor contacte a sus administrador.'));
        }
        return new List<ConsultasRC__c>();
    }
    public Void cargarRegistros (Integer pag){
        listReporte = new List<Reporte_Calidad__c>();
        String query = selectCapos();  
        String consulta = [select IdsConsulta__c from ConsultasRC__c where usuario__c= :usuario and NumPagina__c = :pag ].IdsConsulta__c;
        List<String> idRC = (List<String>) System.JSON.deserialize(consulta, List<String>.class);
        query += ' where Id in (';
        for(String item : idRC){
            query +='\''+item + '\',';
        }
        query = query.substring(0, query.length()-1) +' )'; 
        system.debug('querys: '+query);
        listReporte = database.query(query); 
    }
    
    public Void siguiente(){
        pagActual ++;
        cargarRegistros(pagActual);
        disabledSig = totalPag > pagActual ? false : true;
        disabledAnt = false;
    }
    public Void anterior(){
        pagActual --;
        cargarRegistros(pagActual);
        disabledSig =  false;
        disabledAnt = pagActual > 1 ? false : true;
    }
    
    
    public PageReference exportarExcel(){
        NombreExcel = 'application/vnd.ms-excel#';
        Usuarios_de_Pantallas__c a =new Usuarios_de_Pantallas__c ();
        a = [select name, Apellido__c  from Usuarios_de_Pantallas__c   where Usuario__c  =:usuario limit 1];
        date fecha= date.today();
        NombreExcel +=(a.name !=null && a.Apellido__c  !=null ? a.name +' '+a.Apellido__c  : '')+ ' '+fecha.format()+'.xls';
        return new PageReference ('/Apex/vfexportarexcelreporteCalidadSAC');
    }
    
    
    public void buscarEmpresa(){
        try{
            for(filtro item : listEmpresasN){
                item.mostrar = true;
            }
            if(filtroEmpresa !=null && filtroEmpresa.trim() !=''){
                for(filtro item : listEmpresasN){
                    item.mostrar = false;
                    if(item.nombre.contains(filtroEmpresa)){
                        item.mostrar = true;
                    }
                } 
            }
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
    }
    
    
    public class filtro{
        public boolean seleccionado {get;set;}
        public boolean mostrar {get;set;}
        public string nombre {get;set;}
        public string id {get;set;}
        
        public filtro(string id, string nombre){
            this.id= id;
            this.nombre = nombre;
            this.seleccionado = false;
            this.mostrar = true;
            
        }
    }

}