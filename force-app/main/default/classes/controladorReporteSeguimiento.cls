public without sharing class controladorReporteSeguimiento {
    
    Public list<Reporte_Calidad__c> listReporte {get;set;} 
    Public list<selectOption> listEmpresas {get;set;} 
    public string filtroTipoCarga {get;set;}
    public string filtroEmpresa {get;set;}
    public date filtroFechaEntrega{get;set;}
    public date filtroFechaHasta{get;set;}
    public string filtroReporte{get;set;}
    public string NombreExcel{get;set;}
    //public string UrlPagina {get;set;}
    Public list<selectOption> listAsesores {get;set;} 
    public string perfil {get;set;}
    public string filtroAsesor {set;get;}
    public string filtroReporteCalidad {set;get;}
    string usuario;
    list<string> listAsesoresZonas {get;set;}
    public Usuarios_de_Pantallas__c usuarioPantalla {get;set;}
    
    public list<filtro> listReporteCaliad {get;set;}
    public list<filtro> listTipoCarga {get;set;}
    public list<filtro> listEmpresasN{get;set;}
    public list<filtro> listAsesoresN {get;set;}
    public boolean popEmpresas {get;set;}
    
    public Integer pagActual {get;set;}
    public Integer totalPag {get;set;}
    
    Public Boolean disabledSig {get;set;}
    Public Boolean disabledAnt {get;set;}
    
    public String whereQuery;
    
    
    public controladorReporteSeguimiento(){
        try{
            usuario = ApexPages.currentPage().getParameters().get('usuario');
            //usuario = 'HN52892';
            usuarioPantalla = new Usuarios_de_Pantallas__c();
            usuarioPantalla = [select perfil__C, zona__C from Usuarios_de_Pantallas__c where Usuario__c =:usuario];
            perfil = usuarioPantalla.perfil__C;
            listEmpresas = new list<selectOption>();
            listEmpresas.add(new selectOption('', '--Ninguno--'));
            listAsesores = new list<selectOption>();
            listAsesores.add(new selectOption('', '--Ninguno--'));
            
            listReporteCaliad = new list<filtro>();
            listTipoCarga = new list<filtro>();
            listEmpresasN = new list<filtro>();
            listAsesoresN = new list<filtro>();
            
            ListReporteCaliad.add(new filtro('C', 'Contributivo'));
            ListReporteCaliad.add(new filtro('N', 'No Contributivo'));
            ListReporteCaliad.add(new filtro('P', 'Planilla'));
            
            listTipoCarga.add(new filtro('I', 'Cliente Individual'));
            listTipoCarga.add(new filtro('C', 'Cliente por Carga'));
            listTipoCarga.add(new filtro('YC', 'Clientes Cargados'));
            listTipoCarga.add(new filtro('M', 'Afiliación Masiva'));
            listTipoCarga.add(new filtro('FCS', 'FIcopen - Agencia'));
            listTipoCarga.add(new filtro('FCA', 'FIcopen - SAC'));
            listTipoCarga.add(new filtro('BFK', 'Agencias BFH'));
            listTipoCarga.add(new filtro('PM', 'Premier'));
            Map<String, Integer> verificacion =new Map<String, Integer>();
            
            for(Oficiales_X_Empresa__c  item:
                [select empresa__r.name, empresa__C,codigo_asesor__C from Oficiales_X_Empresa__c order by empresa__r.name asc]){
                    if(!verificacion.containsKey(item.empresa__C)){
                        verificacion.put(item.empresa__C, 0);
                        listEmpresas.add(new selectOption(item.empresa__C, item.empresa__r.name));
                        listEmpresasN.add(new filtro(item.empresa__C, item.empresa__r.name));
                    }
                }
            for(oficial_x_asesor__C item: [select Asesor__r.name, Codigo_Asesor__c  from oficial_x_asesor__C
                                           where Codigo_Asesor__c!=null order by Asesor__r.name asc]){
                                               listAsesores.add(new selectOption(item.Codigo_Asesor__c , item.Asesor__r.name));
                                               if(perfil =='JC' || item.Codigo_Asesor__c == usuario  ){
                                                   listAsesoresN.add(new filtro(item.Codigo_Asesor__c , item.Asesor__r.name));
                                               }
                                           }
            listAsesoresZonas = new list<string>();
            if(perfil !='JC'){
                filtroAsesor = usuario;
                for(filtro item : listAsesoresN){
                    if(item.id == usuario){
                        item.seleccionado =true;
                    }
                }
            }else{
                for(Oficial_X_Asesor__c item: [select Codigo_Asesor__c from Oficial_X_Asesor__c where zona__C =:usuarioPantalla.Zona__c == 'Tegucigalpa' ? 'CS': 'NO'] ){
                    listAsesoresZonas.add(item.Codigo_Asesor__c);
                }
            }
            filtroReporte ='1';
            //filtros ();
        }catch(exception ex){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,' Ha ocurrido un error, por favor contacte a sus administrador.'+ex.getLineNumber()));
        }
    }
    
    public void cerrar(){
        //UrlPagina = null;
        popEmpresas = false;
        filtros();
    }
    
    public void popEmpresas(){
        filtroEmpresa ='';
        popEmpresas = true;
    }
    
    
    
    public void filtros (){
        try{
            NombreExcel = null;
            system.debug('tipo de Filtro: '+filtroReporte);
            pagActual = 1;
            database.delete([select id from ConsultasRC__c where usuario__c = :usuario limit 9999], false);
            listReporte = new list<Reporte_Calidad__c>();
            string query = selectCapos();
            filtroEmpresa = '';
            for(filtro item : listEmpresasN){
                if(item.seleccionado){
                    filtroEmpresa += ' \''+item.id+'\',';
                }
            }
            filtroReporteCalidad = '';
            for(filtro item : ListReporteCaliad){
                if(item.seleccionado){
                    filtroReporteCalidad += ' \''+item.id+'\',';
                }
            }
            filtroAsesor = '';
            for(filtro item : listAsesoresN){
                if(item.seleccionado){
                    filtroAsesor += ' \''+item.id+'\',';
                }
            }
            system.debug('filtro '+filtroAsesor);
            filtroTipoCarga = '';
            for(filtro item : listTipoCarga){
                if(item.seleccionado){
                    filtroTipoCarga += ' \''+item.id+'\',';
                }
            }
            
            if(filtroReporte =='1'){
                query += ' Where  Codigo_Asesor_Comercial__c  !=null and estado__C in (\'N\',\'V\',\'D\') ';
                if(filtroAsesor != null && filtroAsesor.trim() != ''){query +=' and Codigo_Asesor_Comercial__c in ('+filtroAsesor.substring(0, filtroAsesor.length()-1 )+')';}
                if(filtroTipoCarga !=null && filtroTipoCarga.trim() !=''){query +=' and Tipo_Afiliacion__c in ('+filtroTipoCarga.substring(0, filtroTipoCarga.length()-1 )+')';}
                if(filtroEmpresa !=null && filtroEmpresa.trim() !=''){query +=' and empresa__C in ('+filtroEmpresa.substring(0, filtroEmpresa.length()-1 )+')';}
                if(filtroFechaEntrega !=null ){query +=' and fecha_envio_memo__c ='+string.valueOf(filtroFechaEntrega).split(' ')[0];}
                if(filtroReporteCalidad != null && filtroReporteCalidad.trim() != ''){query +=' and reporte_calidad__c in ('+filtroReporteCalidad.substring(0, filtroReporteCalidad.length()-1 )+')';}
                system.debug('Query: '+query);
                cargarMapa(query);
            }else if(filtroReporte =='2'){
                filtroFechaEntrega = date.today().adddays(-date.today().day()+1);
                query += ' Where Codigo_Asesor_Comercial__c  !=null  and estado__c = \'C\' and fecha_validacion__c >='+string.valueOf(filtroFechaEntrega).split(' ')[0]+' and fecha_validacion__c <='+string.valueOf(date.today()).split(' ')[0];
                if(filtroAsesor != null && filtroAsesor.trim() != ''){query +=' and Codigo_Asesor_Comercial__c in ('+filtroAsesor.substring(0, filtroAsesor.length()-1 )+')';}
                if(filtroReporteCalidad != null && filtroReporteCalidad.trim() != ''){query +=' and reporte_calidad__c in ('+filtroReporteCalidad.substring(0, filtroReporteCalidad.length()-1 )+')';}
                if(filtroTipoCarga !=null && filtroTipoCarga.trim() !=''){query +=' and Tipo_Afiliacion__c in ('+filtroTipoCarga.substring(0, filtroTipoCarga.length()-1 )+')';}
                if(filtroEmpresa !=null && filtroEmpresa.trim() !=''){query +=' and empresa__C in ('+filtroEmpresa.substring(0, filtroEmpresa.length()-1 )+')';}
                filtroFechaEntrega = null;
                cargarMapa(query);
            }
            else if(filtroReporte =='3'){
                query +=' Where estado__C = \'C\''; 
                if((filtroAsesor == null || filtroAsesor.trim() == '')){
                    query += ' and Codigo_Asesor_Comercial__c in (';
                    for(string item: listAsesoresZonas){
                        query += ' \''+item+'\',';
                    }
                    query = query.substring(0, query.length()-1)+')';
                }else{
                    if(filtroAsesor != null && filtroAsesor.trim() != ''){query +=' and Codigo_Asesor_Comercial__c in ('+filtroAsesor.substring(0, filtroAsesor.length()-1 )+')';}
                }
                if(filtroReporteCalidad != null && filtroReporteCalidad.trim() != ''){query +=' and reporte_calidad__c in ('+filtroReporteCalidad.substring(0, filtroReporteCalidad.length()-1 )+')';}
                if(filtroFechaEntrega != null){query += ' and fecha_validacion__c >='+string.valueOf(filtroFechaEntrega).split(' ')[0];}
                if(filtroFechaHasta != null){query += ' and fecha_validacion__c <='+string.valueOf(filtroFechaHasta).split(' ')[0];}
                if(filtroTipoCarga !=null && filtroTipoCarga.trim() !=''){query +=' and Tipo_Afiliacion__c in ('+filtroTipoCarga.substring(0, filtroTipoCarga.length()-1 )+')';}
                if(filtroEmpresa !=null && filtroEmpresa.trim() !=''){query +=' and empresa__C in ('+filtroEmpresa.substring(0, filtroEmpresa.length()-1 )+')';}
                system.debug('Query: '+query);
                cargarMapa(query);
            }
            else if(filtroReporte =='4'){
                query += ' Where estado__C = \'D\'';
                if(filtroAsesor == null || filtroAsesor.trim() != ''){
                    query += ' and Codigo_Asesor_Comercial__c in (';
                    for(string item: listAsesoresZonas){
                        query += ' \''+item+'\',';
                    }
                    query = query.substring(0, query.length()-1)+')';
                }else{
                    if(filtroAsesor != null && filtroAsesor.trim() != ''){query +=' and Codigo_Asesor_Comercial__c in ('+filtroAsesor.substring(0, filtroAsesor.length()-1 )+')';}
                }
                if(filtroReporteCalidad != null && filtroReporteCalidad.trim() != ''){query +=' and reporte_calidad__c in ('+filtroReporteCalidad.substring(0, filtroReporteCalidad.length()-1 )+')';}
                if(filtroFechaEntrega != null){query += ' and Fecha_Devolucion__C  >='+string.valueOf(filtroFechaEntrega).split(' ')[0];}
                if(filtroFechaHasta != null){query += ' and Fecha_Devolucion__C <='+string.valueOf(filtroFechaHasta).split(' ')[0];}
                if(filtroTipoCarga !=null && filtroTipoCarga.trim() !=''){query +=' and Tipo_Afiliacion__c in ('+filtroTipoCarga.substring(0, filtroTipoCarga.length()-1 )+')';}
                if(filtroEmpresa !=null && filtroEmpresa.trim() !=''){query +=' and empresa__C in ('+filtroEmpresa.substring(0, filtroEmpresa.length()-1 )+')';}
                system.debug('Query: '+query);
                cargarMapa(query);
            }
            popEmpresas = false;
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
            'Estado__c, fecha_devolucion__C,Enviar_Afiliacion__C,'+
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
            String queryPag ='Select Id from Reporte_Calidad__c Where '+whereQuery+' order by name asc';
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
        insert listIdsConsulta; 
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
        //ApexPages.currentPage().getParameters().put('where', whereQuery);
        //ApexPages.currentPage().getParameters().put('usuario', usuario);
        //ApexPages.currentPage().getParameters().put('pagActual', String.valueOf(pagActual));
        //system.debug('pagActual: '+pagActual+'  usuario: '+usuario);
        NombreExcel = 'application/vnd.ms-excel#';
        
        Usuarios_de_Pantallas__c a =new Usuarios_de_Pantallas__c ();
        a = [select name, Apellido__c  from Usuarios_de_Pantallas__c   where Usuario__c  =:usuario limit 1];
        date fecha= date.today();
        NombreExcel +=(a.name !=null && a.Apellido__c  !=null ? a.name +' '+a.Apellido__c  : '')+ ' '+fecha.format()+'.xls';
        //return new PageReference ('/Apex/vfexportarexcelreporteCalidad?pagActual='+pagActual+'&usuario='+usuario);
        return new PageReference ('/Apex/vfexportarexcelreporteCalidad');
    }
    
    public void buscarEmpresa(){
        try{
            for(filtro item : listEmpresasN){
                item.mostrar = true;
            }
            if(filtroEmpresa !=null && filtroEmpresa.trim() !=''){
                for(filtro item : listEmpresasN){
                    item.mostrar = false;
                    if(item.nombre.toUpperCase().contains(filtroEmpresa.toUpperCase())){
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