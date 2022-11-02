public class ControladorReporteCalidadSLA {
    
    public List<EnvioCorreoSLA.afilaicionSLA> listAfiliacionesSLA{get;set;}
    String perfil;
    String usuario;
    public ControladorReporteCalidadSLA(){
        usuario = ApexPages.currentPage().getParameters().get('usuario');
        perfil = ApexPages.currentPage().getParameters().get('perfil');
        inicar();
    }
    
    public void inicar(){
        try{
            String condicion = perfil == 'SAC' ? ' and FPC_ReporteCalidad__r.Codigo_Oficial_SAC__c = \'' + usuario + '\' ' : ' and FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c = \'' + usuario + '\' ';
            BusinessDays SAC = new BusinessDays('Horario Oficiales SAC');
            BusinessDays comercial = new BusinessDays();
            List<FPC_InicioFinSubEstadosSLARC__c> listTiemposSLA = EnvioCorreoSLA.getRecords(condicion);
            Map<String, List<EnvioCorreoSLA.afilaicionSLA>> mapCorreo = EnvioCorreoSLA.getMapaUsuario(listTiemposSLA);
            Map<String, String> mapEstados = EnvioCorreoSLA.getEstados('Reporte_Calidad__c', 'SubEstadoRCSF__c');
            Map<String, String> mapTipoAfiliacion = EnvioCorreoSLA.getEstados('Reporte_Calidad__c', 'Tipo_Afiliacion__c');
            System.debug('listTiemposSLA: '+listTiemposSLA);
            for(FPC_InicioFinSubEstadosSLARC__c tiempo: listTiemposSLA){
                if(perfil == 'SAC' &&
                   (tiempo.FPC_SubEstadoRCSF__c == 'NS' || tiempo.FPC_SubEstadoRCSF__c == 'VS' || tiempo.FPC_SubEstadoRCSF__c == 'VF'
                    || tiempo.FPC_SubEstadoRCSF__c == 'PS' || tiempo.FPC_SubEstadoRCSF__c == 'PF')){
                        Integer horasTransc = SAC.getNoOfBusinessDaysBetweenDates(tiempo.FPC_FechaInicio__c, System.now()) * 8;
                        horasTransc -= horasTransc > 0 ? 8 : 0;
                        Integer horasDiaActual = 18 - tiempo.FPC_FechaInicio__c.hour();
                        horasTransc += horasDiaActual > 8 ? 8 : horasDiaActual;
                        System.debug(tiempo.FPC_FechaInicio__c.hour()+' horasTransc2: '+horasTransc);
                        List<EnvioCorreoSLA.afilaicionSLA> listAfilaicion = EnvioCorreoSLA.getTiempoSLA(tiempo, mapCorreo.get(tiempo.FPC_ReporteCalidad__r.codigo_oficial_sac__c), horasTransc);
                        mapCorreo.put(tiempo.FPC_ReporteCalidad__r.codigo_oficial_sac__c, listAfilaicion);
                        
                    }
                if(perfil != 'SAC' &&
                   (tiempo.FPC_SubEstadoRCSF__c == 'NC' || tiempo.FPC_SubEstadoRCSF__c == 'DC' || tiempo.FPC_SubEstadoRCSF__c == 'DA'
                    || tiempo.FPC_SubEstadoRCSF__c == 'PS' || tiempo.FPC_SubEstadoRCSF__c == 'PF')){
                        Integer horasTransc = comercial.getNoOfBusinessDaysBetweenDates(tiempo.FPC_FechaInicio__c, System.now()) * 8;
                        horasTransc -= horasTransc > 0 ? 8 : 0;
                        Integer horasDiaActual = 18 - tiempo.FPC_FechaInicio__c.hour();
                        horasTransc += horasDiaActual > 8 ? 8 : horasDiaActual;
                        List<EnvioCorreoSLA.afilaicionSLA> listAfilaicion = EnvioCorreoSLA.getTiempoSLA(tiempo, mapCorreo.get(tiempo.FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c), horasTransc);
                        mapCorreo.put(tiempo.FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c, listAfilaicion);
                        
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