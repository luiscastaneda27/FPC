public class EnvioCorreoSLA {
    
    @future(callout=true)
    public static void envioCorreoSLA(){
        try{
            Boolean esSabado = System.now().format('EEEE') == 'Saturday'; //Saturday
            BusinessDays SAC = new BusinessDays('Horario Oficiales SAC');
            BusinessDays comercial = new BusinessDays();
            List<FPC_InicioFinSubEstadosSLARC__c> listTiemposSLA = getRecords('');
            Map<String, List<afilaicionSLA>> mapCorreo = getMapaUsuario(listTiemposSLA);
            Map<String, User> mapUsuarios = getUsuario(mapCorreo);
            Map<String, String> mapEstados = getEstados('Reporte_Calidad__c', 'SubEstadoRCSF__c');
            Map<String, String> mapTipoAfiliacion = getEstados('Reporte_Calidad__c', 'Tipo_Afiliacion__c');
            
            for(FPC_InicioFinSubEstadosSLARC__c tiempo: listTiemposSLA){
                if(tiempo.FPC_SubEstadoRCSF__c == 'NS' || tiempo.FPC_SubEstadoRCSF__c == 'VS' || tiempo.FPC_SubEstadoRCSF__c == 'VF'
                   || tiempo.FPC_SubEstadoRCSF__c == 'PS' || tiempo.FPC_SubEstadoRCSF__c == 'PF'){
                       Integer horasTransc = SAC.getNoOfBusinessDaysBetweenDates(tiempo.FPC_FechaInicio__c, System.now()) * 8;
                       horasTransc -= horasTransc > 0 ? 8 : 0;
                       Integer horasDiaActual = 18 - tiempo.FPC_FechaInicio__c.hour();
                       horasTransc += horasDiaActual > 8 ? 8 : horasDiaActual;
                       List<afilaicionSLA> listAfilaicion = getTiempoSLA(tiempo, mapCorreo.get(tiempo.FPC_ReporteCalidad__r.codigo_oficial_sac__c), horasTransc);
                       mapCorreo.put(tiempo.FPC_ReporteCalidad__r.codigo_oficial_sac__c, listAfilaicion);
                       
                   }
                if(!esSabado && (tiempo.FPC_SubEstadoRCSF__c == 'NC' || tiempo.FPC_SubEstadoRCSF__c == 'DC' || tiempo.FPC_SubEstadoRCSF__c == 'DA'
                   || tiempo.FPC_SubEstadoRCSF__c == 'PS' || tiempo.FPC_SubEstadoRCSF__c == 'PF')){
                       Integer horasTransc = comercial.getNoOfBusinessDaysBetweenDates(tiempo.FPC_FechaInicio__c, System.now()) * 8;
                       horasTransc -= horasTransc > 0 ? 8 : 0;
                       Integer horasDiaActual = 18 - tiempo.FPC_FechaInicio__c.hour();
                       horasTransc += horasDiaActual > 8 ? 8 : horasDiaActual;
                       List<afilaicionSLA> listAfilaicion = getTiempoSLA(tiempo, mapCorreo.get(tiempo.FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c), horasTransc);
                       mapCorreo.put(tiempo.FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c, listAfilaicion);
                       
                   }
            }
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
            List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
            
            for(String item: mapCorreo.keySet() ){
                List<afilaicionSLA> listAfilaicion = mapCorreo.get(item);
                if(listAfilaicion.size() > 0){
                    String cuerpoCorreo = 'Buen día, <br><br> Le compartimos el estado de las afiliaciones reporte de calidad ';
                    String body = '';
                    for(afilaicionSLA a : listAfilaicion){
                        if(a.estaVencida){
                            body += getHtmlCorreo(a, mapEstados, mapTipoAfiliacion);
                        }
                    }
                    cuerpoCorreo += getHtmlCorreogGeneral(body, 'Afiliaciones vencidas');// '<br><br> <h2> Afiliaciones vencidas</h2> <table> <tr> <td>Identificación</td> <td>Nombre</td> <td>Cuenta</td> <td>Estado</td> </tr>';
                    body = '';
                    for(afilaicionSLA a : listAfilaicion){
                        if(a.esta80){
                            body += getHtmlCorreo(a, mapEstados, mapTipoAfiliacion);
                        }
                    }
                    cuerpoCorreo += getHtmlCorreogGeneral(body, 'Afiliaciones que estan al 80% para vencer');
                    body = '';
                    for(afilaicionSLA a : listAfilaicion){
                        if(a.esta50){
                            body += getHtmlCorreo(a, mapEstados, mapTipoAfiliacion);
                        }
                    }
                    cuerpoCorreo += getHtmlCorreogGeneral(body, 'Afiliaciones que estan al 50% para vencer');
                    
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setToAddresses(new String[] {mapUsuarios.get(item).Email});
                    //mail.setToAddresses(new String[] {'ivorcast@gmail.com'});
                    mail.setSubject('Estado de Afiliaciones SLA '+Date.today().format());
                    mail.setHtmlBody(cuerpoCorreo);
                    mail.setOrgWideEmailAddressId(owea.get(0).Id);
                    MessageList.add(mail); 
                }
            }
            Messaging.sendEmail(MessageList, false);
        }catch(Exception ex){
            System.debug('Error: '+ex.getMessage()+', Línea: '+ex.getLineNumber());
        }
        
    }
    public static String getHtmlCorreogGeneral(String body, String tipo){
        if(String.isBlank(body)){
            return '';
        }
        String encabezado = '<br><br> <h2> '+ tipo +'</h2> <table width="100%"> <tr> <td style="width: 20%;" >Identificación</td> <td style="width: 20%;" >Nombre</td> <td style="width: 20%;" >Cuenta</td> <td style="width: 20%;" >Estado</td><td style="width: 20%;" >Afiliación</td> </tr>';
        encabezado += body + '</table>';
        return encabezado;
    }
    public static String getHtmlCorreo(afilaicionSLA a, Map<String, String> mapEstados,  Map<String, String> mapTipoAfiliacion){
        String body = '';
        body += ' <tr> <td> '+a.identidad +'</td>';
        body += ' <td> '+a.nombre +'</td>';
        body += ' <td> '+a.cuenta +'</td>';
        body += ' <td> '+ mapEstados.get(a.estado) +'</td>';
        body += ' <td> '+ mapTipoAfiliacion.get(a.afiliacion) +'</td></tr>';
        return body; 
    }
    public static List<afilaicionSLA> getTiempoSLA(FPC_InicioFinSubEstadosSLARC__c tiempo, List<afilaicionSLA> listAfilaicion, Integer horasTransc){
        afilaicionSLA a = new afilaicionSLA();
        a.estado = tiempo.FPC_SubEstadoRCSF__c;
        a.nombre = tiempo.FPC_ReporteCalidad__r.Name + ' ' +tiempo.FPC_ReporteCalidad__r.Primer_Apellido__c;
        a.identidad = tiempo.FPC_ReporteCalidad__r.Identificacion__c;
        a.cuenta = tiempo.FPC_ReporteCalidad__r.Numero_Cuenta__c;
        a.afiliacion = tiempo.FPC_ReporteCalidad__r.Tipo_Afiliacion__c;
        if(horasTransc >= tiempo.FPC_TiempoConfigurado__c){
            a.estaVencida = true;
        }else if(horasTransc >= tiempo.FPC_TiempoConfigurado__c * 0.8){
            a.esta80 = true;
        }else if( horasTransc >=tiempo.FPC_TiempoConfigurado__c * 0.5){
            a.esta50 = true;
        }
        System.debug('a: '+a);
        if(a.estaVencida || a.esta80 || a.esta50){
            listAfilaicion.add(a);
        }
        return listAfilaicion;
    } 
  
    public static Map<String, List<afilaicionSLA>> getMapaUsuario(List<FPC_InicioFinSubEstadosSLARC__c> listTiemposSLA){
        Map<String, List<afilaicionSLA>> mapCorreo = new Map<String, List<afilaicionSLA>>();
        for(FPC_InicioFinSubEstadosSLARC__c tiempo: listTiemposSLA){
            if(tiempo.FPC_ReporteCalidad__r.codigo_oficial_sac__c != null && !mapCorreo.containsKey(tiempo.FPC_ReporteCalidad__r.codigo_oficial_sac__c) ){
                mapCorreo.put(tiempo.FPC_ReporteCalidad__r.codigo_oficial_sac__c, new List<afilaicionSLA>());
            }
            if(tiempo.FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c != null && !mapCorreo.containsKey(tiempo.FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c) ){
                mapCorreo.put(tiempo.FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c, new List<afilaicionSLA>());
            }
        }
        return mapCorreo;
    }
    
    public static List<FPC_InicioFinSubEstadosSLARC__c> getRecords(String condicion){
        String query = 'Select Id, FPC_SubEstadoRCSF__c, FPC_TiempoConfigurado__c, FPC_FechaInicio__c , FPC_FechaFin__c,'+
            'FPC_ReporteCalidad__c, FPC_ReporteCalidad__r.Estado__c,'+
            'FPC_ReporteCalidad__r.Codigo_Asesor_Comercial__c, FPC_ReporteCalidad__r.codigo_oficial_sac__c,'+
            'FPC_ReporteCalidad__r.Name, FPC_ReporteCalidad__r.Primer_Apellido__c,'+
            'FPC_ReporteCalidad__r.Tipo_Afiliacion__c,'+
            'FPC_ReporteCalidad__r.Identificacion__c, FPC_ReporteCalidad__r.Numero_Cuenta__c '+
            'From FPC_InicioFinSubEstadosSLARC__c Where FPC_FechaFin__c = null '+condicion+
            'order by FPC_SubEstadoRCSF__c';
        System.debug('Query: '+query);
        return  DataBase.query(query);
    }
    
    public static Map<String, User> getUsuario(Map<String, List<afilaicionSLA>> mapCorreo){
        Map<String, User> mapUsuarios = new Map<String, User>();
        for(User item: [Select Codigo__c, Name, Email from User Where Codigo__c = :mapCorreo.keySet() ]){
            mapUsuarios.put(item.Codigo__c, item);
        }
        return mapUsuarios;
    }
    
     public static  Map<String, String> getEstados(String objApiName, String fieldApiName){
         Map<String, String> mapEstados = new Map<String, String>();
        SObjectType objectType = Schema.getGlobalDescribe().get(objApiName);
        List<Schema.PicklistEntry> ple = objectType.getDescribe()
            .fields.getMap()
            .get(fieldApiName)
            .getDescribe().getPickListValues();
        for(Schema.PicklistEntry entry : ple)  {
            mapEstados.put( entry.getValue(), entry.getLabel());
        }
        return mapEstados;
    }
    
    public class afilaicionSLA{
        public String nombre {get;set;}
        public String identidad {get;set;}
        public String cuenta {get;set;}
        public String estado {get;set;}
        public String afiliacion {get;set;}
        public Boolean estaVencida {get;set;}
        public Boolean esta80 {get;set;}
        public Boolean esta50 {get;set;}
        
        public afilaicionSLA(){
            this.estaVencida = false;
            this.esta80 = false;
            this.esta50 = false;
        }
    }

}