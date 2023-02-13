public class ControladorReporteCalidadSLA {
    
    public List<EnvioCorreoSLA.afilaicionSLA> listAfiliacionesSLA{get;set;}
    
    public List<SelectOption> listOficialSac{get;set;}
    public String sacSeleccionado{get;set;}
    public String sacSeleccionadoOP{get;set;}
    public Boolean filtroSac{get;set;}
    
    public List<SelectOption> listAsesorComercial{get;set;}
    public String asesorSeleccionado{get;set;}
    public Boolean filtroComercial{get;set;}
    
    public List<SelectOption> listReporteCalidad{get;set;}
    public String reporteSeleccionado{get;set;}
    public Boolean filtroReporteCalid{get;set;}
    
    public List<SelectOption> listEstados{get;set;}
    public String estadoSeleccionado{get;set;}
    public Boolean filtroEstado{get;set;}
    
    public List<SelectOption> listTipoAfiliacion{get;set;}
    public String tipoAfilSeleccionado{get;set;}
    public Boolean filtroAfiliacion{get;set;}
    
    String perfil;
    String usuario;
    public ControladorReporteCalidadSLA(){
        usuario = ApexPages.currentPage().getParameters().get('usuario');
        perfil = ApexPages.currentPage().getParameters().get('perfil');
        listAfiliacionesSLA = new List<EnvioCorreoSLA.afilaicionSLA>();
        
        Usuarios_de_Pantallas__c usuarioObj = [Select Perfil__c, Zona__c from Usuarios_de_Pantallas__c Where Usuario__c =:usuario];
        perfil = usuarioObj.Perfil__c;
        
        filtroSac = perfil == 'SGS' || perfil == 'OSP' || perfil == 'SS';
        filtroAfiliacion = true;
        filtroEstado = perfil == 'SGS' || perfil == 'OSP';
        filtroReporteCalid = true;
        filtroComercial = perfil == 'SGS' || perfil == 'OSP' || perfil == 'JC';
        
        sacSeleccionadoOP = '(';
        if(perfil == 'JC'){
            for(Usuarios_de_Pantallas__c item: [Select Usuario__c from Usuarios_de_Pantallas__c where perfil__c = 'AC' and Zona__c= :usuarioObj.Zona__c]){
                sacSeleccionadoOP += '\'' + item.Usuario__c + '\',';
            }
            sacSeleccionadoOP = sacSeleccionadoOP.substring(0, sacSeleccionadoOP.length() - 1);
        }
		sacSeleccionadoOP += ')';
        
        listOficialSac = new List<SelectOption>();
        listAsesorComercial = new List<SelectOption>();
        listOficialSac.add(new SelectOption('', ' -- Ninguno -- '));
        listAsesorComercial.add(new SelectOption('', ' -- Ninguno -- '));
        
        asesorSeleccionado = perfil == 'AC' ? usuario : '';
        sacSeleccionado = perfil == 'OS' ? usuario : '';
        
        List<String> listControl = new List<String>();
        
        for(oficial_x_asesor__C item: [select Oficial_SAC__r.name, Codigo_Oficial_SAC__c from oficial_x_asesor__C where Codigo_Oficial_SAC__c != null order by Oficial_SAC__r.name asc]){
            if(!listControl.contains(item.Codigo_Oficial_SAC__c)){
                listControl.add(item.Codigo_Oficial_SAC__c);
                listOficialSac.add(new selectOption(item.Codigo_Oficial_SAC__c, item.Oficial_SAC__r.name));
                
            }
        }
        listControl = new List<String>();
        String query = 'select Asesor__r.Name, Codigo_Asesor__c  from oficial_x_asesor__C Where Codigo_Asesor__c !=null';
        query += perfil == 'JC' ? ' and Codigo_Asesor__c in ' + sacSeleccionadoOP + '' : '';
        query += ' order by  Asesor__r.Name asc ';
        for(oficial_x_asesor__C item:DataBase.query(query) ){
            if(!listControl.contains(item.Codigo_Asesor__c)){
                listControl.add(item.Codigo_Asesor__c);
                listAsesorComercial.add(new selectOption(item.Codigo_Asesor__c, item.Asesor__r.Name));
                
            }
        }
        
        listTipoAfiliacion = getValoresPicklist('Reporte_Calidad__c', 'Tipo_Afiliacion__c');
        listEstados = getValoresPicklist('FPC_TiemposSLARC__c', 'FPC_EstadoSLA__c');
        listReporteCalidad = getValoresPicklist('Reporte_Calidad__c', 'Reporte_Calidad__c');
        //inicar();
    }
    
    public void iniciar(){
        try{
            String condicion = '';
            if(String.isNotBlank(sacSeleccionado)){
                condicion += ' and FPC_ReporteCalidad__r.Codigo_Oficial_SAC__c = \'' + sacSeleccionado + '\'';
            }/*else if(perfil == 'JO'){
                 condicion += ' and FPC_ReporteCalidad__r.Codigo_Oficial_SAC__c in ' + sacSeleccionadoOP + '';
                
            }*/
            if(String.isNotBlank(asesorSeleccionado)){
                condicion += ' and FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c = \'' + asesorSeleccionado + '\'';
            }
            if(String.isNotBlank(reporteSeleccionado)){
                condicion += ' and FPC_ReporteCalidad__r.Reporte_Calidad__c = \'' + reporteSeleccionado + '\'';
            }
            
            if(String.isNotBlank(estadoSeleccionado)){
                condicion += ' and FPC_ReporteCalidad__r.Estado__c = \'' + estadoSeleccionado + '\'';
            }else if(perfil == 'JC' || perfil == 'AC' ){
                 condicion += ' and FPC_ReporteCalidad__r.Estado__c in (\'N\',\'D\') ';
            }else if(perfil == 'JO' || perfil == 'OO'){
                 condicion += ' and FPC_ReporteCalidad__r.Estado__c in ( \'F\',\'A\') ';
            }else if(perfil == 'OS' ||  perfil == 'SS'){
                 condicion += ' and FPC_ReporteCalidad__r.Estado__c = \'V\'';
            }
            
            if(String.isNotBlank(tipoAfilSeleccionado)){
                condicion += ' and FPC_ReporteCalidad__r.Tipo_Afiliacion__c = \'' + tipoAfilSeleccionado + '\'';
            }
            BusinessDays SAC = new BusinessDays('Horario Oficiales SAC');
            BusinessDays comercial = new BusinessDays();
            System.debug('condicion: '+condicion);
            Boolean esSabado = System.now().format('EEEE') == 'Saturday'; //Saturday
            //condicion = ' and Id = \'a1q63000001HoflAAC\'';
            List<FPC_InicioFinSubEstadosSLARC__c> listTiemposSLA = EnvioCorreoSLA.getRecords(condicion);
            Map<String, List<EnvioCorreoSLA.afilaicionSLA>> mapCorreo = EnvioCorreoSLA.getMapaUsuario(listTiemposSLA);
            Map<String, String> mapEstados = EnvioCorreoSLA.getEstados('FPC_TiemposSLARC__c', 'FPC_EstadoSLA__c');
            Map<String, String> mapTipoAfiliacion = EnvioCorreoSLA.getEstados('Reporte_Calidad__c', 'Tipo_Afiliacion__c');
            System.debug('listTiemposSLA: '+listTiemposSLA.size());
            for(FPC_InicioFinSubEstadosSLARC__c tiempo: listTiemposSLA){
                Boolean flagSla = true;
                Boolean aplicaAgen = ReporteCalidadTriggerHelper.getTipoAfiliacion(tiempo.FPC_ReporteCalidad__r.Tipo_Afiliacion__c);
                if(aplicaAgen &&(tiempo.FPC_EstadoSLA__c == 'NS' || tiempo.FPC_EstadoSLA__c == 'VS' || tiempo.FPC_EstadoSLA__c == 'VF' || tiempo.FPC_EstadoSLA__c == 'PF')){
                    //DateTime horaActual = tiempo.FPC_FechaInicio__c;
                    DateTime fechaInicio = DateTime.newInstanceGmt(tiempo.FPC_FechaInicio__c.year(), tiempo.FPC_FechaInicio__c.month(), tiempo.FPC_FechaInicio__c.day()).addHours(14);
                    Integer horasTransc = calcularMinutos(tiempo.FPC_FechaInicio__c, SAC);
                    fechaInicio = fechaInicio.addDays(1);
                    while(fechaInicio < System.now()){
                        horasTransc += calcularMinutos(fechaInicio, SAC);
                        fechaInicio = fechaInicio.addDays(1);
                    }
                    
                    List<EnvioCorreoSLA.afilaicionSLA> listAfilaicion = EnvioCorreoSLA.getTiempoSLA(tiempo, mapCorreo.get(tiempo.FPC_ReporteCalidad__r.codigo_oficial_sac__c), horasTransc);
                    mapCorreo.put(tiempo.FPC_ReporteCalidad__r.codigo_oficial_sac__c, listAfilaicion);
                    flagSla = false;
                }else if(aplicaAgen &&(tiempo.FPC_EstadoSLA__c == 'NC' || tiempo.FPC_EstadoSLA__c == 'DC' || tiempo.FPC_EstadoSLA__c == 'DA'|| tiempo.FPC_EstadoSLA__c == 'PS' || tiempo.FPC_EstadoSLA__c == 'PF')){
                    DateTime fechaInicio = DateTime.newInstanceGmt(tiempo.FPC_FechaInicio__c.year(), tiempo.FPC_FechaInicio__c.month(), tiempo.FPC_FechaInicio__c.day()).addHours(14);
                    Integer horasTransc = calcularMinutos(tiempo.FPC_FechaInicio__c, comercial);
                    fechaInicio = fechaInicio.addDays(1);
                    while(fechaInicio < System.now()){
                        horasTransc += calcularMinutos(fechaInicio, comercial);
                        fechaInicio = fechaInicio.addDays(1);
                    }
                    List<EnvioCorreoSLA.afilaicionSLA> listAfilaicion = EnvioCorreoSLA.getTiempoSLA(tiempo, mapCorreo.get(tiempo.FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c), horasTransc);
                    mapCorreo.put(tiempo.FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c, listAfilaicion);
                    flagSla = false;
                    
                }
                System.debug('aplicaAgen: '+aplicaAgen);
                System.debug('flagSla: '+flagSla);
                System.debug('tiempo.FPC_EstadoSLA__c : '+tiempo.FPC_EstadoSLA__c );
                if(!aplicaAgen && flagSla && (tiempo.FPC_EstadoSLA__c == 'N' || tiempo.FPC_EstadoSLA__c == 'V' || tiempo.FPC_EstadoSLA__c == 'D'|| tiempo.FPC_EstadoSLA__c == 'A')){
                    DateTime fechaInicio = DateTime.newInstanceGmt(tiempo.FPC_FechaInicio__c.year(), tiempo.FPC_FechaInicio__c.month(), tiempo.FPC_FechaInicio__c.day()).addHours(14);
                    BusinessDays calendario = tiempo.FPC_EstadoSLA__c == 'N' || tiempo.FPC_EstadoSLA__c == 'V' ? SAC : comercial;
                    Integer horasTransc = calcularMinutos(tiempo.FPC_FechaInicio__c, calendario);
                    fechaInicio = fechaInicio.addDays(1);
                    while(fechaInicio < System.now()){
                        horasTransc += calcularMinutos(fechaInicio, calendario);
                        fechaInicio = fechaInicio.addDays(1);
                    }
                    if(tiempo.FPC_EstadoSLA__c == 'N' || tiempo.FPC_EstadoSLA__c == 'V'){
                        List<EnvioCorreoSLA.afilaicionSLA> listAfilaicion = EnvioCorreoSLA.getTiempoSLA(tiempo, mapCorreo.get(tiempo.FPC_ReporteCalidad__r.codigo_oficial_sac__c), horasTransc);
                        mapCorreo.put(tiempo.FPC_ReporteCalidad__r.codigo_oficial_sac__c, listAfilaicion);
                    }else{
                        List<EnvioCorreoSLA.afilaicionSLA>listAfilaicion = EnvioCorreoSLA.getTiempoSLA(tiempo, mapCorreo.get(tiempo.FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c), horasTransc);
                        mapCorreo.put(tiempo.FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c, listAfilaicion);
                    }
                }
                
            }
            listAfiliacionesSLA = new List<EnvioCorreoSLA.afilaicionSLA>();
            for(String user1 : mapCorreo.keySet()){
                for(EnvioCorreoSLA.afilaicionSLA item: mapCorreo.get(user1)){
                    item.estado =  mapEstados.get(item.estado);
                    item.afiliacion =  mapTipoAfiliacion.get(item.afiliacion);
                    listAfiliacionesSLA.add(item);
                }
            }
            System.debug('listAfiliacionesSLA '+json.serialize(listAfiliacionesSLA));
            if(listAfiliacionesSLA.isEmpty()){
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'No se han encontrado registros para mostrar.'));
            }
        }catch(Exception ex){
            System.debug('Error: '+ex.getMessage()+', Línea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Ha ocurrido un error, por favor contacte a su administrador.'));
        }
    }
    
    public static Integer calcularMinutos(DateTime fechaInicio, BusinessDays calendario){
        Integer horasTransc = 0;
        fechaInicio = fechaInicio.hour() < 8 ? DateTime.newInstanceGmt(fechaInicio.year(), fechaInicio.month(), fechaInicio.day()).addHours(14) : fechaInicio;
        DateTime horaHasta;
        String diaLetras = fechaInicio.format('EEEE');// == 'Saturday';
        Integer horasMas = diaLetras == 'Saturday' ? 12 : 17;
        if(System.now().day() != fechaInicio.day() || System.now().year() != fechaInicio.year() || System.now().month() != fechaInicio.month()){
            horaHasta = DateTime.newInstanceGmt(fechaInicio.year(), fechaInicio.month(), fechaInicio.day(), horasMas + 6, 0, 0);
        }else{
            horaHasta = System.now().hour() > horasMas ? 
                DateTime.newInstanceGmt(fechaInicio.year(), fechaInicio.month(), fechaInicio.day(), horasMas + 6, 0, 0) :
            system.now();
        }
        DateTime horaActual = fechaInicio;
        if(calendario.isWorkingDay(DateTime.newInstanceGmt(fechaInicio.year(), fechaInicio.month(), fechaInicio.day(), 16,0,0))){
            while(horaActual.addHours(1) <= horaHasta){
                horaActual = horaActual.addHours(1);
                horasTransc += 60;
            } 
            while(horaActual.addMinutes(1) <= horaHasta){
                horaActual = horaActual.addMinutes(1);
                horasTransc ++;
            } 
        }
        System.debug('fechaInicio '+fechaInicio +' ---  hour '+fechaInicio.hour()+' ----- horasTransc '+horasTransc);
        return horasTransc;
    }
    
    public  List<SelectOption> getValoresPicklist(String objApiName, String fieldApiName){
        List<SelectOption> listOptiones = new List<SelectOption>();
        listOptiones.add(new SelectOption('', ' -- Ninguno -- '));
        SObjectType objectType = Schema.getGlobalDescribe().get(objApiName);
        List<Schema.PicklistEntry> ple = objectType.getDescribe()
            .fields.getMap()
            .get(fieldApiName)
            .getDescribe().getPickListValues();
        for(Schema.PicklistEntry entry : ple)  {
            listOptiones.add(new SelectOption(entry.getValue(), entry.getLabel()));
        }
        return listOptiones;
    }
    
    
}