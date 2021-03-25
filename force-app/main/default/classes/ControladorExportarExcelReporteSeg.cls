public without sharing class ControladorExportarExcelReporteSeg {
    
    public String NombreExcel{get;set;}
    Public List<Reporte_Calidad__c> listReporte {get;set;} 
    
    public ControladorExportarExcelReporteSeg(){
        try{
            String query = selectCapos();
            String usuario =  ApexPages.currentPage().getParameters().get('usuario');
            String pagActual = apexpages.currentpage().getparameters().get('pagActual');
            System.debug('pagActual: '+pagActual+'  usuario: '+usuario);
            
            NombreExcel = 'application/vnd.ms-excel#';
            
            Usuarios_de_Pantallas__c a =new Usuarios_de_Pantallas__c ();
            a = [select name, Apellido__c  from Usuarios_de_Pantallas__c   where Usuario__c  =:usuario limit 1];
            date fecha= date.today();
            NombreExcel +=(a.name !=null && a.Apellido__c  !=null ? a.name +' '+a.Apellido__c  : '')+ ' '+fecha.format()+'.xls';
            listReporte = new List<Reporte_Calidad__c>();
            
            String consulta = [select IdsConsulta__c from ConsultasRC__c where usuario__c= :usuario and NumPagina__c = :Integer.valueOf(pagActual)].IdsConsulta__c;
            System.debug('consulta: '+consulta); 
            List<String> idRC = (List<String>) System.JSON.deserialize(consulta, List<String>.class);
            System.debug('idRC: '+idRC);
            query += ' Id in (';
            for(String item : idRC){
                query +='\''+item + '\',';
            }
            query = query.substring(0, query.length()-1) +' )'; 
            system.debug('querys2: '+query);
            listReporte = database.query(query);  
            system.debug('Lista size: '+listReporte.size());
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
            'Tiene_Id__c , Tipo_Fondo__c , Tipo_Identificacion__c ,WAIVER__c from Reporte_Calidad__c where ';
    }

}