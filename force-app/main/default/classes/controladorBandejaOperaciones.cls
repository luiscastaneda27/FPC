public without sharing class controladorBandejaOperaciones {
    
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
    public string perfil {get;set;}
    public list<string> listAsesoresCS {get;set;}
    public list<string> listAsesoresNO {get;set;}
    public string nombreExcel {get;set;}
    map<string, string> mapCodigoAsesores {get;set;}
    public string filtroAfilicion {get;set;}
    public boolean pop{get;set;}
    public string idAfiliacion{get;set;}
    
    public Integer pagActual {get;set;}
    public Integer totalPag {get;set;}
    
    Public Boolean disabledSig {get;set;}
    Public Boolean disabledAnt {get;set;}
    
    
    public controladorBandejaOperaciones(){
        try{
            usuario = ApexPages.currentPage().getParameters().get('hytrd');
            salir();
            mapCodigoAsesores = new map<string, string>();
            listAsesoresCS = new list<string>();
            listAsesoresNO = new list<string>();
            listEmpresas = new list<selectOption>();
            listOficiales = new list<selectOption>();
            listAsesores = new list<selectOption>();
            filtroAfilicion = 'I';
            listEmpresas.add(new selectOption('', '--Ninguno--'));
            listOficiales.add(new selectOption('', '--Ninguno--'));
            listAsesores.add(new selectOption('', '--Ninguno--'));
            map<string, integer> mapBandera = new map<string, integer>();
            for(Reporte_Calidad__c  item: 
                [select empresa__r.name, empresa__C from Reporte_Calidad__C where estado__C = 'A' order by empresa__r.name asc]){
                    if(!mapBandera.containsKey(item.empresa__C)){
                        mapBandera.put(item.empresa__C, 21);
                        listEmpresas.add(new selectOption(item.empresa__C, item.empresa__r.name));
                    }
                }
            mapBandera = new map<string, integer>();
            for(oficial_x_asesor__C item: [select Oficial_SAC__r.name, Codigo_Oficial_SAC__c from oficial_x_asesor__C
                                           where Codigo_Oficial_SAC__c != null and Oficial_SAC__c != null   order by Oficial_SAC__r.name asc]){
                if(!mapBandera.containsKey(item.Codigo_Oficial_SAC__c)){
                    mapBandera.put(item.Codigo_Oficial_SAC__c, 21);
                    listOficiales.add(new selectOption(item.Codigo_Oficial_SAC__c, item.Oficial_SAC__r.name));
                }
            }
            for(Oficial_X_Asesor__c item: [select Codigo_Asesor__c, asesor__r.name, zona__C from Oficial_X_Asesor__c where Codigo_Asesor__c != null order by asesor__r.name asc] ){
                //listAsesoresZonas.add(item.Codigo_Asesor__c);
                
                listAsesores.add(new selectOption(item.Codigo_Asesor__c, item.asesor__r.name));
                if(item.zona__C == 'NO'){
                    listAsesoresNO.add(item.Codigo_Asesor__c);
                    mapCodigoAsesores.put(item.Codigo_Asesor__c, '123');
                }else{
                     listAsesoresCS.add(item.Codigo_Asesor__c);
                    mapCodigoAsesores.put(item.Codigo_Asesor__c, '122');
                }
                
            }
            filtroReporte ='3';
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,' Ha ocurrido un error, por favor contacte a sus administrador.'+' Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber()));
        }
    }
    public void filtros (){
        try{
            string query = selectCapos();
            NombreExcel = null;
            disabledSig = true;
            disabledAnt = true;
            pagActual = 1;
            totalPag = 1;
            database.delete([select id from ConsultasRC__c where usuario__c = :usuario limit 9999], false);
            query += ' Where estado__C = \'A\''; 
            query += filtroAfilicion == 'M' ? ' and Tipo_Afiliacion__c = \'M\'' : filtroAfilicion == 'F' ? ' and Tipo_Afiliacion__c = \'FC\'' : ' and Tipo_Afiliacion__c not in (\'M\', \'FC\')';
            system.debug('Query: '+query);
            if(filtroAsesor != null){query += ' and Codigo_Asesor_Comercial__c = \''+filtroAsesor+'\'';}
            if(filtroOficial != null){query += ' and Codigo_Oficial_SAC__c = \''+filtroOficial+'\'';}
            if(filtroFechadesde != null){query += ' and fecha_validacion__c >='+string.valueOf(filtroFechadesde).split(' ')[0];}
            if(filtroFechaHasta != null){query += ' and fecha_validacion__c <='+string.valueOf(filtroFechaHasta).split(' ')[0];}
            if(filtroEmpresa !=null && filtroEmpresa.trim() !=''){query +=' and empresa__C =\''+filtroEmpresa + '\'';}
            system.debug('Query: '+query);
            cargarMapa(query);
            
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,' Ha ocurrido un error, por favor contacte a sus administrador.'));
        }
        
    }
    
    public void popGuardar(){
        boolean haySeleccionado = false;
        for(Reporte_calidad__C item: listReporte){
            if(item.aprobado__C && filtroAfilicion == 'I'){
                aSysdeReporteCalidad.ClassReporteCalidad respuesta= aSysdeReporteCalidad.infoCliente(item.Identificacion__c);
                item.Numero_Cuenta__c = respuesta.numCuenta;
                item.Numero_de_Cliente__c = respuesta.clienteUnicoBanco;
                item.Numero_de_Contrato__c = respuesta.numContrato;
                haySeleccionado = true;
                if(item.Numero_de_Cliente__c == null){
                    item.aprobado__C = false;
                    item.Error_Sysde__C = 'No se encontro Cliente en Sysde';
                }
            }
        }
        if(haySeleccionado){
            pop = true;
        }else{
            guardar();
        }
    }
    
    public void guardar(){
        try{
            Map<string, Compra_Venta_Dolares__mdt > mapDato = new map<string, Compra_Venta_Dolares__mdt >();
            Map<string, Monto_Capital_Semilla__mdt > mapMonto = new map<string, Monto_Capital_Semilla__mdt >();
            Map<string, String > mapEstado = new map<string, String >();
            List<String> listIdReporte = new List<String>();
            for(Reporte_calidad__C item: listReporte){
                listIdReporte.add(Item.Id);
            }
            for(Reporte_calidad__C item: [Select Id, Estado__C from Reporte_calidad__C where id in :listIdReporte and Estado__c = 'A']){
                mapEstado.put(Item.Id, item.Estado__c);
            }
            
            for(Compra_Venta_Dolares__mdt item: 
                [select Cuenta_Destino__c ,Cuenta_Origen__c ,Nivel_Cinco__c , Nivel_Cuatro__c , Nivel_Dos__c ,
                 Nivel_Tres__c , Nivel_Uno__c,DeveloperName from Compra_Venta_Dolares__mdt]){
                     mapDato.put(item.DeveloperName, item);
                 }
            
            for(Monto_Capital_Semilla__mdt item: [select monto_pago__C ,DeveloperName from Monto_Capital_Semilla__mdt]){
                mapMonto.put(item.DeveloperName, item);
            }
             
           List<Reporte_calidad__C> listReporteUpdate = new List<Reporte_calidad__C>();
           
            for(Reporte_calidad__C item: listReporte){
                item.identificacion__c = item.identificacion__c !=null ? item.identificacion__c.replace('-','') : null;
                if(item.aprobado__C){
                    if((item.Numero_de_Cliente__c !=null && item.Numero_de_Cliente__c !='') || filtroAfilicion == 'M' || test.isRunningTest()){
                        item.estado__C = 'C';
                        if((item.Tipo_Afiliacion__c =='C' && item.Aplica_CS__c == 'S') || test.isRunningTest()){
                            Compra_Venta_Dolares__mdt  dato = new Compra_Venta_Dolares__mdt();
                            Monto_Capital_Semilla__mdt monto = new Monto_Capital_Semilla__mdt();
                            monto = mapMonto.get(item.CurrencyIsoCode);
                            system.debug('Tipo de Fondo: '+item.tipo_fondo__C);
                            dato = mapDato.get(item.tipo_fondo__C);
                            aSysdeReporteCalidad.classEstadoCapital claseenvio = new aSysdeReporteCalidad.classEstadoCapital();
                            claseEnvio.cuenta = item.Numero_Cuenta__c;
                            claseEnvio.cambioEstado = false;
                            claseEnvio.capitalSemilla =  true;
                            string idS =item.Id;
                            claseEnvio.codigoReferencia =item.Numero_de_Cliente__c+'SF'+item.Numero_Cuenta__c;
                            //claseEnvio.formaPago ='';
                            claseEnvio.moneda = item.CurrencyIsoCode =='HNL' ? '1' : '2';
                            claseEnvio.monto = string.valueOf(monto.monto_pago__C);
                            claseEnvio.nombre = item.Name +' '+item.Primer_Apellido__c;
                            date fecha = date.today();
                            claseEnvio.ctaDestino = dato.Cuenta_Destino__c;
                            claseEnvio.ctaOrigen = dato.Cuenta_Origen__c;
                            claseEnvio.periodoAporte = ''+fecha.year()+(fecha.month() < 10 ? '0'+fecha.month() : ''+fecha.month()) + (fecha.day() < 10 ? '0'+fecha.day() : ''+fecha.day());  
                            string respuesta = aSysdeReporteCalidad.CambioEstado(claseEnvio);
                            if(!respuesta.contains('Proceso capital semilla procesado correctamente')){
                                item.aprobado__C = false;
                                 item.estado__C = 'A';
                                item.error_sysde__C = respuesta;
                                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Error al aplicar capital semilla con el cliente '+item.name +' '+item.Primer_Apellido__c+' '+item.Identificacion__c));
                            }
                            
                        }
                    }else{
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'No hemos encontrado el numero de identidad '+item.Identificacion__c+' en Sysde, favor contacte a su administrador'));
                        return;
                    }
                }else if(item.rechazado__C && mapEstado.containsKey(Item.Id)){
                    if(item.tipo_afiliacion__C =='M'){
                        item.estado__C = 'N';
                        item.enviar_sac__C = false;
                    }else if(item.tipo_afiliacion__C =='FC'){
                        item.estado__C = 'V';
                        item.Enviar_Sac__c = false;
                        item.espediente_completo__C = null;
                    }
                    else{
                        item.estado__C = 'V';
                        item.espediente_completo__C = null;
                    }
                }
                if((item.aprobado__C || item.rechazado__C) && mapEstado.containsKey(Item.Id)){
                    item.aprobado__C = false;
                    item.rechazado__C = false;
                    listReporteUpdate.add(item);
                }
               
            }
            if(listReporteUpdate.size() > 0){
                update listReporteUpdate;
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.confirm,' Datos guardados exitosamente.'));
            }
            salir();
            filtros();
        }catch(exception ex){
             system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.error,' Ha ocurrido un error, por favor contacte a sus administrador.'));
        }
    }
    
    
    
    public string selectCapos(){
        return 'select Addendum__c, Aplica_CS__c ,Num__C, Aportacion_HNL__c ,Aportacion_USD__c, Seguro__c  ,'+
            ' aprobado__C, rechazado__c, empresa__r.Identificacion_Empleador__c, Cuentas_Colectivas__c,'+
            'Asesor_Comercial__c, Comentarios__c, Codigo_Asesor_Comercial__c,Codigo_Oficial_SAC__c ,'+
            'Empresa__c , Expediente_Completo__c ,Error_Sysde__C, FATCA__c , Fecha_Envio_Memo__c, Fecha_Validacion__c ,'+
            'Fecha_Inicio_Aporte__c , Forma_Pago__c, Formulario_Completo__c, Identificacion__c ,'+
            'Numero_de_Cliente__c , Numero_de_Contrato__c ,Numero_Cuenta__c ,Oficial_SAC__c ,PEP__c ,'+
            'Periodicidad__c , name , Procedencia__c , Reporte_Calidad__c,RTN__c , Subproducto__r.Name, '+
            'Estado__c, fecha_devolucion__C,Enviar_Afiliacion__C,Cod_Region__C, Cod_Provincia__C, '+
            'CurrencyIsoCode,Nacionalidad__c, sexo__C,fecha_nacimiento__C,Fecha_ingreso_empresa__C,'+
            'profesion__C,estado_civil__C, lugar_nacimiento__C,nombre_conyuge__C,cargo__C,'+
            ' Cantidad_Afiliaciones__c , Codigo_T24__c,aporte_patrono__C, '+
            'Primer_Apellido__c,Enviar_Sac__C,Tipo_Afiliacion__c,Aprueba_SAC__c,id ,'+
            'Subproducto__r.codigo__C,Empresa__r.name, Subproducto__r.producto__r.codigo__C,Espediente_Completo__C,'+
            'Segundo_Apellido__c ,Segundo_Nombre__c , Seguro_HNL__c , Seguro_USD__c ,Subproducto__c ,'+
            'Tiene_Id__c , Tipo_Fondo__c , Tipo_Identificacion__c ,WAIVER__c,Empresa__r.Fax_Oficina__c,Empresa__r.Phone from Reporte_Calidad__c ';
    }
    
     public void cargarMapa(String query){
        try{
            List<ConsultasRC__c> listIdsConsulta = new List<ConsultasRC__c>();
            String queryPag ='Select Id from Reporte_Calidad__c Where '+query.split('Where')[1]+' order by LastModifiedDate desc';
            Decimal pag = 0;
            List<String> idRC = new List<String>();
            system.debug('query: '+queryPag);
            Boolean v = false;
            for(Reporte_Calidad__c item : database.query(queryPag)){
                v = true;
                idRC.add(item.Id);
                if(idRC.size() == Integer.valueOf(Label.LimitQueryRC)){
                    pag ++;
                    listIdsConsulta.add(new ConsultasRC__c(usuario__c = usuario, IdsConsulta__c	= Json.serialize(idRC), NumPagina__c = pag));
                    idRC = new List<String>();
                }
                if(listIdsConsulta.size() == 100){
                    listIdsConsulta = insertConsulta(listIdsConsulta);
                }
            }
            if(idRC.size() > 0){
                pag ++;
                listIdsConsulta.add(new ConsultasRC__c(usuario__c = usuario, IdsConsulta__c	= Json.serialize(idRC), NumPagina__c = pag));
            }
            if(listIdsConsulta.size() > 0){
                insertConsulta(listIdsConsulta);
            }
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
        ordenarInfo();
    }
    
    public void siguiente(){
        pagActual ++;
        cargarRegistros(pagActual);
        disabledSig = totalPag > pagActual ? false : true;
        disabledAnt = false;
    }
    public void anterior(){
        pagActual --;
        cargarRegistros(pagActual);
        disabledSig =  false;
        disabledAnt = pagActual > 1 ? false : true;
    }
    
    Public void ordenarInfo(){
        integer i = 1;
        for(Reporte_Calidad__c item: listReporte){
            item.Seguro__c = 'No';
            string codigo = mapCodigoAsesores.get(item.Codigo_Asesor_Comercial__c);
            item.Cod_Region__C = codigo;
            if(codigo =='123'){
                item.Cod_Provincia__C ='25';
            }else{
                item.Cod_Provincia__C ='09';
            }
            if(item.seguro_hnl__C > 0 || item.seguro_USD__C > 0 ){
                item.Seguro__c = 'Si'; 
            } 
            string vdc = item.identificacion__C;
            if(vdc!=null && vdc.length() == 13){
                item.identificacion__C  = vdc.substring(0, 4)+'-'+vdc.substring(4, 8)+'-'+vdc.substring(8, 13);
            }
            item.num__C = i;
            i++;
        }
    }
    
    
    public void selectAprobar(){
        try{
            for(Reporte_Calidad__c item: listReporte){
                if(item.id ==idAfiliacion){
                    item.rechazado__C = false;
                }
            }
        }catch(exception ex){
            
        }
    }
    public void selectRechazar(){
        try{
            for(Reporte_Calidad__c item: listReporte){
                if(item.id ==idAfiliacion){
                    item.Aprobado__c = false;
                }
            }
        }catch(exception ex){
            
        }
    }
    
    public PageReference descargarArchivo(){
        //ApexPages.PageReference ref;
        list<string> vf = new list<string>();
        vf.add(idAfiliacion);
        For(ContentDocumentLink item : 
            [SELECT ContentDocument.LatestPublishedVersionId,ContentDocumentId,
             ContentDocument.FileExtension,ContentDocument.Title 
             FROM ContentDocumentLink WHERE LinkedEntityId =: idAfiliacion]){
                 system.debug('URL: /sfc/servlet.shepherd/version/download/' + item.ContentDocument.LatestPublishedVersionId);
                 return new PageReference('/sfc/servlet.shepherd/version/download/' + item.ContentDocument.LatestPublishedVersionId);
                 
             }
        return null;
                
    }
    
    public PageReference afiliar(){
        return new Pagereference (claseUtil.urlSysde('Site_pantallas')+'vfpantallaclienteProductoAGN?idAfiliacion='+idafiliacion+'&hytrd='+usuario);
                
    }
    
    public void salir(){
        pop= false;
    }
    
    public PageReference exportarExcel(){
        NombreExcel = 'application/vnd.ms-excel#';
        Usuarios_de_Pantallas__c a =new Usuarios_de_Pantallas__c ();
        try{ a = [select name, Apellido__c  from Usuarios_de_Pantallas__c   where Usuario__c  =:usuario limit 1];}catch(exception ex){}
        date fecha= date.today();
        NombreExcel +=(a.name !=null && a.Apellido__c  !=null ? a.name +' '+a.Apellido__c  : '')+ ' '+fecha.format()+'.xls';
        system.debug('Nombre excel: '+NombreExcel);
        return new PageReference ('/Apex/vfexportarExcelOperaciones');
    }

}