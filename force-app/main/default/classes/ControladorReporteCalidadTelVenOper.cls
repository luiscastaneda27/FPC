public class ControladorReporteCalidadTelVenOper {
    
    
    public list<Reporte_calidad__C> listAfiliaciones{get;set;}
    public Reporte_calidad__C Afiliacion {get;set;}
    string usuario;
    string tipoPantalla = 'TV';
    public producto__C producto {get;set;} 
    public string idAfiliacion{get;set;}
    public map<string, String> mapClientes{get;set;}
    public Oficial_X_Asesor__c oficial;
    public Map<string, Oficial_X_Asesor__c> mapAsesoresOficiales{get;set;}
    public Map<string, String> mapAsesoresPremier{get;set;}
    public boolean cambioCampos {get;set;}
    
    public ControladorReporteCalidadTelVenOper(){
        usuario = ApexPages.currentPage().getParameters().get('usuario');
    }
    
   
    
    public void cerrar(){
        cambioCampos = false;
    }
    
    public void reinicar(){
        cerrar();
        listAfiliaciones = new list<Reporte_calidad__C>();
        Afiliacion = new Reporte_calidad__C();
        listAfiliaciones = [select Addendum__c, Aplica_CS__c , Aportacion_HNL__c ,Aportacion_USD__c ,
                            Asesor_Comercial__c, Comentarios__c, Codigo_Asesor_Comercial__c,Codigo_Oficial_SAC__c ,
                            Empresa__c , Expediente_Completo__c , FATCA__c , Fecha_Envio_Memo__c, Fecha_Validacion__c ,
                            Fecha_Inicio_Aporte__c , Forma_Pago__c, Formulario_Completo__c, Identificacion__c ,
                            Numero_de_Cliente__c , Numero_de_Contrato__c ,Numero_Cuenta__c ,Oficial_SAC__c ,PEP__c ,
                            Periodicidad__c , name , Procedencia__c , Reporte_Calidad__c,RTN__c ,
                            Documentacion_Recibida__c,Id,ExpedienteFisicoRecibido__c, Estado__c,
                            Fecha_Devolucion__c,DebidaDiligencia__c,SubEstadoRCSF__c,
                            NombreEmpleadoAGN__c,CodigoEmpleadoAGN__c, FechaIngreso__c, NombreAgencia__c,CodigoAGN__c,
                            CurrencyIsoCode,Nacionalidad__c, sexo__C,fecha_nacimiento__C,Fecha_ingreso_empresa__C,
                            profesion__C,estado_civil__C, lugar_nacimiento__C,nombre_conyuge__C,cargo__C,
                            Primer_Apellido__c,Enviar_Sac__C,Tipo_Afiliacion__c,Aprueba_SAC__c ,
                            Subproducto__r.name,Empresa__r.name, Subproducto__r.producto__r.name,Espediente_Completo__C,
                            Segundo_Apellido__c ,Segundo_Nombre__c , Seguro_HNL__c , Seguro_USD__c ,Subproducto__c ,
                            Tiene_Id__c , Tipo_Fondo__c , Tipo_Identificacion__c ,WAIVER__c from Reporte_calidad__C
                            where Tipo_Afiliacion__C =: tipoPantalla and (Estado__c = 'A' or Estado__c = 'F')
                            and SubEstadoRCSF__c != 'PF'
                            order by LastModifiedDate desc limit 950];
        if(listAfiliaciones.size() == 0){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'No se han encontrado clientes.'));
        }
        
    }
    
    
    public void editar(){
        for(Reporte_calidad__C item:listAfiliaciones ){
            if(idAfiliacion == item.Id){
                afiliacion = new Reporte_calidad__C ();
                producto = new Producto__c();
                afiliacion = item;
                producto.name = item.Subproducto__r.producto__r.name;
            }
        }
    }
    
    public void traerClientes(){
        try{
            Usuarios_de_Pantallas__c usuarioP = [Select Name, Apellido__c from Usuarios_de_Pantallas__c Where Usuario__c =:usuario limit 1];
            listAfiliaciones = new list<Reporte_calidad__C>();
            mapAsesoresOficiales = new map<string, Oficial_X_Asesor__c>();
            mapAsesoresPremier = new map<string, String>();
            for(Oficial_X_Asesor__c item: [select Codigo_Asesor__c ,Oficial_SAC__r.name, Codigo_Oficial_SAC__c,Asesor__r.name from Oficial_X_Asesor__c]){
                mapAsesoresOficiales.put(item.Codigo_Asesor__c, item);
            }
            for(AsesoresPremier__mdt item: [Select AsesorPremier__c, AsesorFPC__c from AsesoresPremier__mdt] ){
                mapAsesoresPremier.put(item.AsesorPremier__c, item.AsesorFPC__c);
            }
            list<aSysdeReporteCalidad.ConsultaCliente> listRespuesta = aSysdeReporteCalidad.infoClientes(tipoPantalla);
            Map<String, String> mapAGN = new Map<String, String>();
            for(Agencia__c item : [Select name, Codigo_T24__c from agencia__C]){
                mapAGN.put(item.Codigo_T24__c, item.name);
            }
            List<String> listIdentidades = new List<String>();
            for(aSysdeReporteCalidad.ConsultaCliente respuesta: listRespuesta){
                listIdentidades.add(respuesta.identificacion != null ? respuesta.Identificacion.replace('-','') : 'A');
            }
            mapClientes = new map<String, String>();
            for(Reporte_calidad__C item: [select identificacion__C,Numero_Cuenta__c  from Reporte_calidad__C where identificacion__C in :listIdentidades ]){
                mapClientes.put(item.Identificacion__c.replace('-','')+item.Numero_Cuenta__c, item.Numero_Cuenta__c );
            }
            Oficial_X_Asesor__c asesor;
            system.debug('listRespuesta: '+listRespuesta.size());
            for(aSysdeReporteCalidad.ConsultaCliente respuesta: listRespuesta){
                if(respuesta.identificacion != null && !mapClientes.containsKey(respuesta.Identificacion.replace('-','')+respuesta.numCuenta)){
                    //asesor = new Oficial_X_Asesor__c();
                    //respuesta.asesor = mapAsesoresPremier.get(respuesta.asesor);
                    System.debug('respuesta.asesor: '+respuesta.asesor);
                    asesor = mapAsesoresOficiales.containsKey(respuesta.asesor) ? mapAsesoresOficiales.get(respuesta.asesor) : new Oficial_X_Asesor__c();
                    
                    
                    Afiliacion = new Reporte_calidad__C ();
                    afiliacion.Documentacion_Recibida__c ='S';
                    Afiliacion.Tipo_Identificacion__c = respuesta.tipoIdentificacion;
                    afiliacion.Enviar_Sac__c = true;
                    afiliacion.Reporte_Calidad__c = 'I';
                    afiliacion.Formulario_Completo__c = 'S';
                    Afiliacion.Identificacion__c = respuesta.Identificacion.replace('-','');
                    Afiliacion.name = respuesta.primerNombre;
                    Afiliacion.Segundo_Nombre__c = respuesta.segundoNombre;
                    Afiliacion.Primer_Apellido__c = respuesta.primerApellido;
                    Afiliacion.Segundo_Apellido__c = respuesta.segundoApellido;
                    Afiliacion.Tiene_Id__c = 'S';
                    Afiliacion.RTN__C = (respuesta.RTN == null || respuesta.RTN == '') ? 'N' : 'S';
                    Afiliacion.Numero_de_Cliente__c = respuesta.clienteUnicoBanco;
                    Afiliacion.Numero_de_Contrato__c = respuesta.numContrato;
                    Afiliacion.Numero_Cuenta__c = respuesta.numCuenta;
                    if(respuesta.codEmpresa !=null && respuesta.codEmpresa !=''){
                        Afiliacion.Empresa__r = new account(cliente_unico_banco__C = respuesta.codEmpresa);
                    }
                    afiliacion.FATCA__c =(respuesta.fatca == 'N' || respuesta.fatca == null || respuesta.fatca == '') ? 'N' : 'S'; 
                    afiliacion.WAIVER__c = (respuesta.waiver == 'N' || respuesta.waiver == null || respuesta.waiver == '') ? 'N' : 'S';
                    
                    afiliacion.Codigo_Asesor_Comercial__c = respuesta.asesor;
                    afiliacion.Asesor_Comercial__c = asesor.Asesor__r.name;
                    Afiliacion.Codigo_Oficial_SAC__c = usuario;
                    afiliacion.Oficial_SAC__c =  usuarioP.Name + ' '+ usuarioP.Apellido__c;
                    afiliacion.Cuentas_Colectivas__c = respuesta.codColectiva;
                    afiliacion.Estado__c = 'A';
                    
                    
                    afiliacion.PEP__c = (respuesta.pep=='N' || respuesta.pep == null || respuesta.pep == '') ? 'N' : 'S'; 
                    afiliacion.Procedencia__c = (respuesta.procedencia=='N' || respuesta.procedencia == null || respuesta.procedencia == '') ? 'N' : 'S'; 
                    afiliacion.addendum__C = (respuesta.addendum == 'N' || respuesta.addendum == null || respuesta.addendum == '') ? 'N' : 'S'; 
                    afiliacion.Subproducto__r = new SubProducto__C(codigo__C = respuesta.codSubProducto );
                    afiliacion.Tipo_Fondo__c = respuesta.tipoFondo == '113' ? 'P' : respuesta.tipoFondo == '106' ? 'D' : 'M'; 
                    afiliacion.Tipo_Afiliacion__c = tipoPantalla;
                    
                    afiliacion.NombreEmpleadoAGN__c = respuesta.EMP_AGN;
                    afiliacion.CodigoEmpleadoAGN__c = respuesta.COD_AGN;
                    afiliacion.CodigoAGN__c = respuesta.AGN;
                    afiliacion.FechaIngreso__c  = convertDate(respuesta.FECHA_INGRESO);
                    afiliacion.NombreAgencia__c = mapAGN.get(respuesta.AGN);
                    afiliacion.TipoCliente__c = respuesta.TIPO_CLIENTE ;
                    listAfiliaciones.add(afiliacion);
                    mapClientes.put(respuesta.Identificacion.replace('-','')+respuesta.numCuenta, respuesta.numCuenta);
                    
                } 
            }
            mapClientes = new Map<String, String>();
            Database.upsert(listAfiliaciones, false);
            reinicar();
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Ha ocurrido un error, por favor contacte su admin.'));
        }
        
    }
    
    Public Date convertDate(String fecha){
        try{
            Date fechaRturn;
            List<String> listFechas = fecha.split('-');
            Integer respuesta;
            String mes = listFechas[1];
            if(mes=='JAN' || mes=='ENE'){respuesta = 1;}
            if(mes=='FEB'){respuesta = 2;}
            if(mes=='MAR'){respuesta = 3;}
            if(mes=='APR' || mes=='ABR'){respuesta = 4;}
            if(mes=='MAY' ){respuesta = 5;}
            if(mes=='JUN' ){respuesta = 6;}
            if(mes=='JUL' ){respuesta = 7;}
            if(mes=='AUG' || mes=='AGO'){respuesta = 8;}
            if(mes=='SEP' ){respuesta = 9;}
            if(mes=='OCT' ){respuesta = 10;}
            if(mes=='NOV' ){respuesta = 11;}
            if(mes=='DEC' || mes=='DIC'){respuesta = 12;}
            fechaRturn = date.valueOf(DateTime.newInstance((Integer.valueOf(listFechas[2]) + 2000), respuesta, Integer.valueOf(listFechas[0])));
            return fechaRturn;
        }catch(Exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            return null;
        }
    }
    
    public void guardar(){
        try{
            if(afiliacion.ExpedienteFisicoRecibido__c == 'N' && Afiliacion.Espediente_Completo__c == 'S' && afiliacion.Documentacion_Recibida__c == 'S' ){
                Afiliacion.Estado__c = 'F';
            }else if(afiliacion.ExpedienteFisicoRecibido__c == 'N' || Afiliacion.Espediente_Completo__c == 'N' || afiliacion.Documentacion_Recibida__c == 'N'){
                Afiliacion.Enviar_Sac__c = false;
                afiliacion.Espediente_Completo__c = null;
                afiliacion.Estado__c = afiliacion.Fecha_Devolucion__c != null ? 'D' : 'N';
                afiliacion.Fecha_Devolucion__c = date.today();
            } else {
                afiliacion.Fecha_Validacion__c  = date.today();
                afiliacion.Estado__c = 'C';
            }
            update afiliacion;
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Datos Guardados exitosamente.'));
            reinicar();
        }catch(exception ex){
            System.debug(ex.getMessage());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Ha ocurrido un error, por favor contacte su admin.'));
        }
        
    }
    
    
    
    public void accionVacia(){
        
    }
}