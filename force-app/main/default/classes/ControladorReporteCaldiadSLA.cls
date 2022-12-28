public class ControladorReporteCaldiadSLA {
    
    public List<EnvioCorreoSLA.afilaicionSLA> listAfiliacionesSLA{get;set;}
    
    public List<SelectOption> listOficialSac{get;set;}
    public String sacSeleccionado{get;set;}
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
    public ControladorReporteCaldiadSLA(){
        usuario = ApexPages.currentPage().getParameters().get('usuario');
        perfil = ApexPages.currentPage().getParameters().get('perfil');
        
        filtroSac = true;
        filtroAfiliacion = true;
        filtroEstado = true;
        filtroReporteCalid = true;
        filtroComercial = true;
        
        listOficialSac = new List<SelectOption>();
        listAsesorComercial = new List<SelectOption>();
        
        List<String> listControl = new List<String>();
        
        for(oficial_x_asesor__C item: [select Oficial_SAC__r.name, Codigo_Oficial_SAC__c from oficial_x_asesor__C where Codigo_Oficial_SAC__c != null order by Oficial_SAC__r.name asc]){
            if(!listControl.contains(item.Codigo_Oficial_SAC__c)){
                listControl.add(item.Codigo_Oficial_SAC__c);
                listOficialSac.add(new selectOption(item.Codigo_Oficial_SAC__c, item.Oficial_SAC__r.name));
                
            }
        }
        listControl = new List<String>();
        for(oficial_x_asesor__C item: [select Asesor__r.Name, Codigo_Asesor__c  from oficial_x_asesor__C Where Codigo_Asesor__c !=null order by  Asesor__r.Name asc]){
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
    
    public static  List<SelectOption> getValoresPicklist(String objApiName, String fieldApiName){
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
    
    public void inicar(){
        try{
            String condicion = perfil == 'SAC' ? ' and FPC_ReporteCalidad__r.Codigo_Oficial_SAC__c = \'' + usuario + '\' ' : ' and FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c = \'' + usuario + '\' ';
            BusinessDays SAC = new BusinessDays('Horario Oficiales SAC');
            BusinessDays comercial = new BusinessDays();
            List<FPC_InicioFinSubEstadosSLARC__c> listTiemposSLA = EnvioCorreoSLA.getRecords(condicion);
            Map<String, List<EnvioCorreoSLA.afilaicionSLA>> mapCorreo = EnvioCorreoSLA.getMapaUsuario(listTiemposSLA);
            Map<String, String> mapEstados = EnvioCorreoSLA.getEstados('FPC_TiemposSLARC__c', 'FPC_EstadoSLA__c');
            Map<String, String> mapTipoAfiliacion = EnvioCorreoSLA.getEstados('Reporte_Calidad__c', 'Tipo_Afiliacion__c');
            System.debug('listTiemposSLA: '+listTiemposSLA);
            for(FPC_InicioFinSubEstadosSLARC__c tiempo: listTiemposSLA){
                Boolean flagSla = true;
                if(perfil == 'SAC' &&
                  ReporteCalidadTriggerHelper.getTipoAfiliacion(tiempo.FPC_ReporteCalidad__r.Tipo_Afiliacion__c) && (tiempo.FPC_EstadoSLA__c == 'NS' || tiempo.FPC_EstadoSLA__c == 'VS' || tiempo.FPC_EstadoSLA__c == 'VF'
                   || tiempo.FPC_EstadoSLA__c == 'PS' || tiempo.FPC_EstadoSLA__c == 'PF')){
                        Integer horasTransc = SAC.getNoOfBusinessDaysBetweenDates(tiempo.FPC_FechaInicio__c, System.now()) * 8;
                        horasTransc -= horasTransc > 0 ? 8 : 0;
                        Integer horasDiaActual = 18 - tiempo.FPC_FechaInicio__c.hour();
                        horasTransc += horasDiaActual > 8 ? 8 : horasDiaActual;
                        System.debug(tiempo.FPC_FechaInicio__c.hour()+' horasTransc2: '+horasTransc);
                        List<EnvioCorreoSLA.afilaicionSLA> listAfilaicion = EnvioCorreoSLA.getTiempoSLA(tiempo, mapCorreo.get(tiempo.FPC_ReporteCalidad__r.codigo_oficial_sac__c), horasTransc);
                        mapCorreo.put(tiempo.FPC_ReporteCalidad__r.codigo_oficial_sac__c, listAfilaicion);
                        flagSla = false;
                        
                    }
                if(perfil != 'SAC' &&
                   ReporteCalidadTriggerHelper.getTipoAfiliacion(tiempo.FPC_ReporteCalidad__r.Tipo_Afiliacion__c) 
                   &&(tiempo.FPC_EstadoSLA__c == 'NC' || tiempo.FPC_EstadoSLA__c == 'DC' || tiempo.FPC_EstadoSLA__c == 'DA'
                   || tiempo.FPC_EstadoSLA__c == 'PS' || tiempo.FPC_EstadoSLA__c == 'PF')){
                        Integer horasTransc = comercial.getNoOfBusinessDaysBetweenDates(tiempo.FPC_FechaInicio__c, System.now()) * 8;
                        horasTransc -= horasTransc > 0 ? 8 : 0;
                        Integer horasDiaActual = 18 - tiempo.FPC_FechaInicio__c.hour();
                        horasTransc += horasDiaActual > 8 ? 8 : horasDiaActual;
                        List<EnvioCorreoSLA.afilaicionSLA> listAfilaicion = EnvioCorreoSLA.getTiempoSLA(tiempo, mapCorreo.get(tiempo.FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c), horasTransc);
                        mapCorreo.put(tiempo.FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c, listAfilaicion);
                       flagSla = false;
                        
                    }
                if(!ReporteCalidadTriggerHelper.getTipoAfiliacion(tiempo.FPC_ReporteCalidad__r.Tipo_Afiliacion__c) && flagSla &&
                   (tiempo.FPC_EstadoSLA__c == 'N' || tiempo.FPC_EstadoSLA__c == 'V' || tiempo.FPC_EstadoSLA__c == 'D'
                    || tiempo.FPC_EstadoSLA__c == 'A')){
                        Integer horasTransc = comercial.getNoOfBusinessDaysBetweenDates(tiempo.FPC_FechaInicio__c, System.now()) * 8;
                        if(tiempo.FPC_EstadoSLA__c == 'N' || tiempo.FPC_EstadoSLA__c == 'V'){
                            horasTransc = SAC.getNoOfBusinessDaysBetweenDates(tiempo.FPC_FechaInicio__c, System.now()) * 8;
                        }
                        horasTransc -= horasTransc > 0 ? 8 : 0;
                        Integer horasDiaActual = 18 - tiempo.FPC_FechaInicio__c.hour();
                        horasTransc += horasDiaActual > 8 ? 8 : horasDiaActual;
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
            for(EnvioCorreoSLA.afilaicionSLA item: mapCorreo.get(usuario)){
                item.estado =  mapEstados.get(item.estado);
                item.afiliacion =  mapTipoAfiliacion.get(item.afiliacion);
                listAfiliacionesSLA.add(item);
            }
        }catch(Exception ex){
            System.debug('Error: '+ex.getMessage()+', Línea: '+ex.getLineNumber());
        }
    }
}