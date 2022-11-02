global class controladorAfiliacionCarga {
    
    public list<Reporte_calidad__C> listAfiliaciones{get;set;}
    public list<selectOption> listSubProductos{get;set;}
    public list<selectOption> listEmpresas{get;set;}
    public Reporte_calidad__C Afiliacion {get;set;}
    Public String Usuario {get;set;}
    public producto__C producto {get;set;}
    public oficial_X_asesor__C asesor{get;set;}
    public string NombreProducto{get;set;}
    public string idAfiliacion{get;set;}
    public string buscarSubProducto{get;set;}
    public string buscarEmpresa{get;set;}
    public list<classPoPup> listPopup {get;set;}
    public boolean popSubProducto{get;set;}
    public boolean popEmpresas{get;set;}
    string correoOficial;
    public String tipoAfiliacion{get;set;}
    
    //public static final String usuario2 = ApexPages.currentPage().getParameters().get('usuario');
    
    public String linkPortal {get;set;}
    public controladorAfiliacionCarga(){
        try{
            usuario = ApexPages.currentPage().getParameters().get('usuario');
            //Usuario = 'HN19962';
            //usuario2 = usuario;
            system.debug('controladorAfiliacionCarga: '+usuario);
            linkPortal = claseUtil.urlSysde('Site_pantallas');
            asesor = new oficial_X_asesor__C();
            asesor = [select codigo_asesor__C, Codigo_Oficial_SAC__c , oficial_sac__r.name,
                      Oficial_SAC__r.email,
                     asesor__r.name, asesor__r.email from oficial_X_asesor__C where codigo_asesor__C =:Usuario limit 1];
            reiniciar();
            listSubProductos = new list<selectOption>();
            listEmpresas = new list<selectOption>();
            listSubProductos.add(new selectOption('', '--Ninguno--'));
            listEmpresas.add(new selectOption('', '--Ninguno--'));
            for(subProducto__C item: [select id, name from subProducto__C order by name asc]){
                listSubProductos.add(new selectOption(item.id, item.name));
            }
            for(Account item: [select id, name from Account  where recordtype.developername='Juridico' and isPersonAccount =false order by name asc]){
                listEmpresas.add(new selectOption(item.id, item.name));
            }
        }catch(exception ex) { ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Usted no tiene oficiales Sac asignados, por favor contacto su admin.'));
        }
    }
    
    
    public void reiniciar(){
        system.debug('Reiniciar');
        buscarSubProducto = '';
        buscarEmpresa = '';
        tipoAfiliacion = 'I';
        listAfiliaciones = new list<Reporte_calidad__C>();
        listAfiliaciones = [select Addendum__c, Aplica_CS__c , Aportacion_HNL__c ,Aportacion_USD__c ,
                            Cuentas_Colectivas__c,
                            Asesor_Comercial__c, Comentarios__c, Codigo_Asesor_Comercial__c,Codigo_Oficial_SAC__c ,
                            Empresa__c , Expediente_Completo__c , FATCA__c , Fecha_Envio_Memo__c, Fecha_Validacion__c ,
                            Fecha_Inicio_Aporte__c , Forma_Pago__c, Formulario_Completo__c, Identificacion__c ,
                            Numero_de_Cliente__c , Numero_de_Contrato__c ,Numero_Cuenta__c ,Oficial_SAC__c ,PEP__c ,
                            Periodicidad__c , name , Procedencia__c , Reporte_Calidad__c,RTN__c ,id,
                            DebidaDiligencia__c,
                            Primer_Apellido__c,Enviar_Sac__C,Tipo_Afiliacion__c,CurrencyIsoCode, estado__C,
                            Subproducto__r.name,Empresa__r.name, Subproducto__r.producto__r.name,
                            Segundo_Apellido__c ,Segundo_Nombre__c , Seguro_HNL__c , Seguro_USD__c ,Subproducto__c ,
                            Tiene_Id__c , Tipo_Fondo__c , Tipo_Identificacion__c ,WAIVER__c from Reporte_calidad__C
                            where Codigo_Asesor_Comercial__c =:usuario and Enviar_Sac__C =false
                            and Tipo_Afiliacion__c  ='C' 
                            order by LastModifiedDate desc limit 950];
        agregarAfiliacion();
        system.debug('Lista: '+listAfiliaciones.size());
    }
    
    
    public void BuscarEmpresa(){
        try{
            String recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Juridico').getRecordTypeId();
            afiliacion.Empresa__c = null;
            List<Cuentas__c> listCuentas = [Select Id, Cliente__c, Cliente__r.Name, Cliente__r.Cliente_unico_banco__c, Codigo__c from Cuentas__c
                                            Where Cliente__r.Name like : '%'+buscarEmpresa+'%' and  Cliente__r.RecordTypeId =:recordTypeId];
            if(listCuentas.size()==0) {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'No se han encontrado coincidencias.'));
            }else{
                listPopup = new list<classPoPup> ();
                for(Cuentas__c item: listCuentas){
                    classPoPup a = new classPoPup ();
                    a.seleccionado = false;
                    a.name = item.Cliente__r.Name;
                    a.id = item.Cliente__c;
                    a.codigo = item.Cliente__r.Cliente_unico_banco__C;
                    a.cuenta = item.Codigo__c;
                    listPopup.add(a);
                }
                popEmpresas = true;
            }
        }catch(Exception ex){
             system.debug('Error: '+ex.getMessage()+',  Linea: '+ex.getLineNumber());
             ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'Error: '+ex.getMessage()+',  Linea: '+ex.getLineNumber()));
        }
        
    }
    
    
    
    public void agregarAfiliacion(){
        Afiliacion = new Reporte_calidad__C(Asesor_Comercial__c= asesor.asesor__r.name, Codigo_Asesor_Comercial__c =asesor.codigo_asesor__C,
                                          Tipo_Afiliacion__c ='C', estado__C='N');
    }
    
    
    public void editar(){
         producto =new producto__C();
         afiliacion = new Reporte_calidad__C();
        for(Reporte_calidad__C item:listAfiliaciones ){
            if(idAfiliacion == item.Id){
                item.enviar_sac__C =false;
                afiliacion = item;
                producto.name = item.Subproducto__r.producto__r.name;
            }
        }
    }
    
    public void Enviar(){
        try{
            integer contador = 0;
            String codigo;
            for(Reporte_calidad__C item:listAfiliaciones ){
                if(item.enviar_sac__c){
                    item.Fecha_Envio_Memo__c =date.today();
                    item.estado__C = 'V';
                    codigo = codigo == null ? item.Codigo_Oficial_SAC__c : codigo;
                    contador ++;
                }
            }
            if(contador> 0){
                oficial_X_asesor__C oficial = [select Oficial_SAC__r.email,Oficial_SAC__r.name from oficial_X_asesor__C where Codigo_Oficial_SAC__c =:codigo limit 1];
                Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
                email.setSubject(' Nueva Afiliaciones por Carga  - '+ date.today().format()); 
                email.setToAddresses(new string[] {oficial.Oficial_SAC__r.email});
                email.setCcAddresses(new string[] {asesor.asesor__r.email});
                email.setPlainTextBody('Buen día '+oficial.Oficial_SAC__r.name+'.\n\n Por medio del presente le notificamos que el asesor '+asesor.Asesor__r.name +' agrego '+contador+' afiliaciones por carga.\n\n Favor dar Seguimiento, Muchas gracias.');
                List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
                email.setOrgWideEmailAddressId(owea.get(0).Id);
                Messaging.SingleEmailMessage[] listEmail = new List<Messaging.SingleEmailMessage>(); 
                listEmail.add(email); 
                system.debug('Tamano de lista: '+listEmail.size());
                update listAfiliaciones;
                reiniciar();
                Messaging.SendEmailResult[] results = Messaging.sendEmail(listEmail, false);
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Datos guardados exitosamente.'));
            }
            //update listAfiliaciones;
            //reinicar();
            //ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Datos guardados exitosamente.'));
        }catch(exception ex){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'Ha ocurrido un error. '+ex.getMessage()+ ', Linea: '+ex.getLineNumber()));
        }
        
    }
    
    public boolean popEliminar{get;set;}
    public string nombreAfiiacion{get;set;}
    
    public void cerrar(){
        popEliminar = false; 
        if(tipoAfiliacion == 'M'){
            popEmpresas = false;
            buscarEmpresa = '';
        }
    }
    
    public void EliminarAfiliacion(){
        for(Reporte_calidad__C item:listAfiliaciones ){
            if(idAfiliacion == item.Id) { delete(item);
            }
        }
        reiniciar();
        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Datos guardados exitosamente.'));
        popEliminar = false;   
    }
    
    public void SelectPopEliminar(){
        for(Reporte_calidad__C item:listAfiliaciones ) { if(idAfiliacion == item.Id) { nombreAfiiacion =item.name +' '+item.primer_apellido__C;
            }
        }
        popEliminar = true; 
    }
    
    
    public void ValidacionIdentidad(){
        if(afiliacion.Identificacion__c !=null){
            list<Cuentas__C> listCuentas = [select id, cliente__r.name, codigo__C from Cuentas__C where cliente__r.identificacion__C = :afiliacion.Identificacion__c limit 1];
            if(listCuentas.size() > 0){ ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.WARNING, ' Esta persona ya esta afiliado, con este nuemero de cuenta '+listCuentas[0].codigo__C));
            }
        }
    }
    
    public void selectCuenta(){
        try{
            Afiliacion.Codigo_Oficial_SAC__c = null;
            Afiliacion.Oficial_SAC__c = null;
            //afiliacion.Cuentas_Colectivas__c = '';
            for(classPoPup a : listPopup ){
                if(a.cuenta == afiliacion.Cuentas_Colectivas__c){
                    afiliacion.Empresa__c = a.id;
                    Oficiales_X_Empresa__c item = [select codigo_oficial_sac__C, oficial_sac__r.name
                                                   from Oficiales_X_Empresa__c 
                                                   where empresa__C=:afiliacion.Empresa__c 
                                                   and Codigo_Asesor__c=:asesor.Codigo_Asesor__c
                                                   limit 1];
                    Afiliacion.Codigo_Oficial_SAC__c =item.codigo_oficial_sac__C;
                    Afiliacion.Oficial_SAC__c =item.oficial_sac__r.name;
                }
            }
            popEmpresas = false;
        }catch(exception ex){
            popEmpresas = false;
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ' La empresa seleccionada no tiene oficial Asignado '));
        }
    }
    
    
    public void guardar(){
        try{
            if((afiliacion.name == null  ||afiliacion.Primer_Apellido__c == null || afiliacion.Aplica_CS__c == null || afiliacion.Tipo_Identificacion__c == null ||afiliacion.Identificacion__c == null || afiliacion.Tiene_Id__c == null ||afiliacion.RTN__c == null ||afiliacion.FATCA__c == null || afiliacion.WAIVER__c == null ||afiliacion.PEP__c == null ||afiliacion.Procedencia__c == null || afiliacion.Addendum__c == null ||afiliacion.Tipo_Fondo__c == null ||afiliacion.Subproducto__c == null || afiliacion.Empresa__c == null ||afiliacion.Reporte_Calidad__c == null || afiliacion.Formulario_Completo__c == null  ) && Afiliacion.Formulario_Completo__c == 'S' ){ ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'Por favor Completar todos los campos.'));
               }else if(afiliacion.name == null || afiliacion.Primer_Apellido__c == null  ||afiliacion.Tipo_Identificacion__c == null ||afiliacion.Identificacion__c == null){ ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'Por favor completar el nombre e identificación.'));
               }else{
                   upsert Afiliacion;
                   reiniciar();
                   ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Datos guardados exitosamente.'));
               }
            buscarempresa = null;
            buscarSubProducto = null;
        }catch(exception ex){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ' La empresa seleccionada no tiene oficial Asignado '));
        }
    }
    
    public void accionVacia(){
    }
    public void SelectSubProducto(){
        try{
            producto =new producto__C();
            afiliacion.Subproducto__c =null;
            afiliacion.Tipo_Fondo__c = null;
            if(buscarSubProducto != null){
               // buscarSubProducto = '%'+buscarSubProducto+'%';
                list<subProducto__C> listSP = [select id, name, producto__r.name, producto__r.CurrencyIsoCode, tipo_fondo__C  
                                               from subProducto__C where codigo__C like : '%'+buscarSubProducto+'%' or name like : '%'+buscarSubProducto+'%' ];
                if(listSP.size()==0){ ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'No se han encontrado coincidencias.'));
                }else if(listSP.size() ==1){
                    afiliacion.CurrencyIsoCode = listSP[0].producto__r.CurrencyIsoCode;
                    afiliacion.Tipo_Fondo__c = listSP[0].tipo_fondo__C;
                    afiliacion.Subproducto__c = listSP[0].id;
                    producto =new producto__C(name= listSP[0].producto__r.name);
                }else if(listSP.size() >1){
                    listPopup = new list<classPoPup> ();
                    for(subProducto__C item: listSP){
                        classPoPup a = new classPoPup ();
                        a.seleccionado = false;
                        a.name = item.name;
                        a.id= item.id;
                        listPopup.add(a);
                    }
                    popSubProducto = true;
                }
            }
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+',  Linea: '+ex.getLineNumber());
             ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'Error: '+ex.getMessage()+',  Linea: '+ex.getLineNumber()));
        }
        
    }
    
    public void SelectSubProductoPop(){
        try{
            for(subProducto__C item:
                [select id, name, producto__r.name, producto__r.CurrencyIsoCode, tipo_fondo__C  
                 from subProducto__C where id=:afiliacion.Subproducto__c]){
                     afiliacion.CurrencyIsoCode = item.producto__r.CurrencyIsoCode;
                     afiliacion.Tipo_Fondo__c = item.tipo_fondo__C;
                     producto =new producto__C(name= item.producto__r.name);
                     
                 }
            popSubProducto = false;
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+',  Linea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'Error: '+ex.getMessage()+',  Linea: '+ex.getLineNumber())); 
        }
    }
    
    @RemoteAction
    global static classWRetorno subirInformacion(String stringCSV, String usuario){
        classWRetorno retorno = new classWRetorno();
        system.debug('Usuario: '+usuario);
        system.debug('String '+stringCSV);
        try{
            list<String> allData = new list<String>();
            allData = stringCSV.split('\n');
            
            list<String> header = new list<String>();
            header = allData[0].split(',');
            
            integer pocisionPN = -1;
            integer pocisionSN = -1;
            integer pocisionPA = -1;
            integer pocisionSA = -1;
            integer pocisionTipoIdentificacion = -1;
            integer pocisionIdentificacion = -1;
            integer pocisionTieneId = -1;
            integer pocisionRTN = -1;
            integer pocisionFATCA = -1;
            integer pocisionWAIVER = -1;
            integer pocisionPEP = -1;
            integer pocisionProcedencia = -1;
            integer pocisionAdendum = -1;
            integer pocisionSubproducto = -1;
            integer pocisionCuentaCltv = -1;
            integer pocisionReporteCalidad = -1;
            //integer pocisionOficialSac = -1;
            integer pocisionFormularioCompleto = -1;
            integer pocisionAplicaCS = -1;
            integer pocisionComentarios = -1;
            retorno.error='exitoso';
            list<Reporte_Calidad__C> listAfiliaciones = new list<Reporte_Calidad__C>();
            system.debug('Header: '+header);
            for(Integer i=0; i<header.size(); i++){
                String item = header[i].replace('"','');
                
                if(item == 'Primer Nombre'){
                    pocisionPN = i;
                }
                if(item == 'Segundo Nombre'){
                    pocisionSN = i;
                }
                if(item == 'Primer Apellido'){
                    pocisionPA = i;
                }
                if(item == 'Segundo Apellido'){
                    pocisionSA = i;
                }
                if(item == 'Tipo Identificación'){
                    pocisionTipoIdentificacion = i;
                }
                if(item == 'Identificación'){
                    pocisionIdentificacion = i;
                }
                if(item == 'Tiene Id'){
                    pocisionTieneId = i;
                }
                if(item == 'RTN'){
                    pocisionRTN = i;
                }
                if(item == 'FATCA'){
                    pocisionFATCA = i;
                }
                if(item == 'WAIVER'){
                    pocisionWAIVER = i;
                }
                if(item == 'PEP'){
                    pocisionPEP = i;
                }
                if(item == 'Procedencia'){
                    pocisionProcedencia = i;
                }
                if(item == 'Addendum'){
                    pocisionAdendum = i;
                }
                if(item == 'Subproducto'){
                    pocisionSubproducto= i;
                }
                if(item == 'Cuenta Colectiva'){
                    pocisionCuentaCltv = i;
                }
                if(item == 'Reporte de Calidad'){
                    pocisionReporteCalidad = i;
                }
                //if(item == 'Oficial SAC'){
                //  pocisionOficialSAC = i;
                //}
                if(item == 'Formulario Completo'){
                    pocisionFormularioCompleto = i;
                }
                if(item == 'Aplica CS'){
                    pocisionAplicaCS = i;
                }
                if(item == 'Comentarios'){
                    pocisionComentarios = i;
                }
            }
            /*system.debug(pocisionComentarios);
            system.debug(pocisionAplicaCS);
            system.debug(pocisionFormularioCompleto);
            system.debug(pocisionOficialSAC);
            system.debug(pocisionReporteCalidad);
            system.debug(pocisionSubproducto);
            system.debug(pocisionAdendum);
            system.debug(pocisionProcedencia);
            system.debug(pocisionPEP);
            system.debug(pocisionWAIVER);
            system.debug(pocisionFATCA);
            system.debug(pocisionRTN);
            system.debug(pocisionTieneId);
            system.debug(pocisionIdentificacion);
            system.debug(pocisionTipoIdentificacion);
            system.debug(pocisionPN);*/
           
            if(pocisionPN == -1 ||pocisionSN == -1 ||pocisionPA == -1 || pocisionSA == -1 ||pocisionTipoIdentificacion == -1 ||
               pocisionIdentificacion == -1 || pocisionTieneId == -1 ||pocisionRTN == -1 || pocisionFATCA == -1 ||
               pocisionWAIVER == -1 ||pocisionPEP == -1 ||pocisionProcedencia == -1 || pocisionAdendum == -1 ||
               pocisionSubproducto == -1 ||pocisionCuentaCltv == -1 || pocisionReporteCalidad == -1  ||
               pocisionFormularioCompleto == -1 || pocisionAplicaCS == -1 ||pocisionComentarios == -1){
                   retorno.error='Faltan algunos campos en la plantilla, por favor digitarlos todos';
               }else{
                   allData.remove(0);
                   Schema.DescribeFieldResult fieldResult = Reporte_calidad__C.Tipo_Identificacion__c.getDescribe();   
                   map<string, string> mapTipoIdentificacion= new map<string, string>(); 
                   for(Schema.PicklistEntry p : fieldResult.getPicklistValues()){          
                       mapTipoIdentificacion.put(p.getlabel(), p.getValue());  
                   }
                   fieldResult = Reporte_calidad__C.Reporte_Calidad__C.getDescribe();   
                   map<string, string> mapReporteCalidad= new map<string, string>(); 
                   for(Schema.PicklistEntry p : fieldResult.getPicklistValues()){          
                       mapReporteCalidad.put(p.getlabel(), p.getValue());  
                   }
                   map<String, String> mapSiNo =new map<String, String>();
                   mapSiNo.put('Si', 'S');
                   mapSiNo.put('No', 'N');
                   mapSiNo.put('N / A', 'N / A');
                   
                   map<String, Subproducto__c> mapSubProducto = new  map<String, Subproducto__c>();
                   for(Subproducto__c item: [select codigo__C, tipo_fondo__C,producto__r.CurrencyIsoCode from Subproducto__c]){
                       mapSubProducto.put(item.Codigo__c, item);
                   }
                   
                   map<String, String> mapCuentas = new  map<String, String>();
                   for(Account item: [select id, Cliente_Unico_Banco__c from Account where RecordTypeId = :Schema.SObjectType.Account.getRecordTypeInfosByName().get('Juridico').getRecordTypeId()]){
                       mapCuentas.put(item.Cliente_Unico_Banco__c, item.id);
                   }
                   
                   Map<String, Oficiales_X_Empresa__c> mapOficialSac =new map<String, Oficiales_X_Empresa__c>();
                   Map<String, Cuentas__c> mapCuentasColec =new map<String, Cuentas__c>();
                   List<String> listCuentas = new List<String>();
                   for(Oficiales_X_Empresa__c item: 
                       [select codigo_oficial_sac__C, Empresa__c,oficial_sac__r.name, empresa__r.cliente_Unico_banco__c
                        from Oficiales_X_Empresa__c where Codigo_asesor__c =:usuario]){
                            listCuentas.add(item.Empresa__c);
                            if(!mapOficialSac.containsKey(item.empresa__r.cliente_Unico_banco__c+usuario)){
                                mapOficialSac.put(item.empresa__r.cliente_Unico_banco__c+usuario, item);
                            }                         
                        }
                   for(Cuentas__c item: [Select Codigo__c, Cliente__c, Cliente__r.cliente_Unico_banco__c from cuentas__c Where Cliente__c in :listCuentas ]){
                       mapCuentasColec.put(item.Codigo__C, item);
                   }
                   //system.debug(ApexPages.currentPage().getParameters().get('page:theForm:idPageBlock:idUsuario'));
                   //String usuario = ApexPages.currentPage().getParameters().get('page:theForm:idPageBlock:idUsuario');
                   //String usuario = 'HN19962';
                   system.debug('Usuario: '+Usuario);
                   oficial_X_asesor__C asesor = [select codigo_asesor__C, Codigo_Oficial_SAC__c , oficial_sac__r.name,
                                                 Oficial_SAC__r.email,
                                                 asesor__r.name from oficial_X_asesor__C where codigo_asesor__C =:usuario limit 1];
                   for(String item : allData){
                       
                       
                       Reporte_Calidad__C afiliacion = new Reporte_Calidad__C();
                       item = item.replace('"', '');
                       item = item.replace(',,', ', ,');
                       if(item.length() < 60){
                           continue;
                       }
                       if(item.subString((item.length() - 1), item.length()) == ','){
                           item += ' ';
                       }
                       list<String> data = item.split(',');
                       for(Integer i=0; i<data.size(); i++ ){
                           data[i] = data[i].trim();
                       }
                       if(!mapTipoIdentificacion.containsKey(data[pocisionTipoIdentificacion])){
                           retorno.error='Tipo de Identificacion '+data[pocisionTipoIdentificacion] +' no existe';
                           return retorno;
                       }
                       if(!mapSubProducto.containsKey(data[pocisionSubproducto])){
                           retorno.error='El SubProducto '+data[pocisionSubproducto] +' no existe';
                           return retorno;
                       }
                       if(!mapReporteCalidad.containsKey(data[pocisionReporteCalidad])){
                           retorno.error='El Reporte de Calidad '+data[pocisionReporteCalidad] +' no existe';
                           return retorno;
                       }
                       String codigo = mapCuentasColec.containsKey(data[pocisionCuentaCltv]) ? mapCuentasColec.get(data[pocisionCuentaCltv]).Cliente__r.cliente_Unico_banco__c : null;
                       if(String.isBlank(codigo) || !mapOficialSac.containsKey(codigo+usuario)){
                           retorno.error='La cuenta colectiva '+data[pocisionCuentaCltv] +' no existe';
                           return retorno;
                       }
                       if(!mapSiNo.containsKey(data[pocisionTieneId])){
                          retorno.error = data[pocisionTieneId] +' Valor Inapropiado para la lista valores';
                           return retorno;
                       }
                       if(!mapSiNo.containsKey(data[pocisionRTN])){
                           retorno.error = data[pocisionRTN] +' Valor Inapropiado para la lista valores';
                           return retorno;
                       }
                       if(!mapSiNo.containsKey(data[pocisionFATCA])){
                           retorno.error = data[pocisionFATCA] +' Valor Inapropiado para la lista valores';
                           return retorno;
                       }
                       if(!mapSiNo.containsKey(data[pocisionWAIVER])){
                           retorno.error = data[pocisionWAIVER] +' Valor Inapropiado para la lista valores';
                           return retorno;
                       }
                       if(!mapSiNo.containsKey(data[pocisionPEP])){
                           retorno.error = data[pocisionPEP] +' Valor Inapropiado para la lista valores';
                           return retorno;
                       }
                       if(!mapSiNo.containsKey(data[pocisionProcedencia])){
                           retorno.error = data[pocisionProcedencia] +' Valor Inapropiado para la lista valores';
                           return retorno;
                       }
                       if(!mapSiNo.containsKey(data[pocisionAdendum])){
                           retorno.error = data[pocisionAdendum] +' Valor Inapropiado para la lista valores';
                           return retorno;
                       }
                       if(!mapSiNo.containsKey(data[pocisionFormularioCompleto])){
                           retorno.error = data[pocisionFormularioCompleto] +' Valor Inapropiado para la lista valores';
                           return retorno;
                       }
                       if(!mapSiNo.containsKey(data[pocisionAplicaCS])){
                           retorno.error = data[pocisionAplicaCS] +' Valor Inapropiado para la lista valores';
                           return retorno;
                       }
                       Cuentas__c cta = mapCuentasColec.get(data[pocisionCuentaCltv]);
                       afiliacion.name = data[pocisionPN];
                       afiliacion.Segundo_Nombre__c = data[pocisionSN];
                       afiliacion.Primer_Apellido__c = data[pocisionPA];
                       afiliacion.Segundo_Apellido__c = data[pocisionSA];
                       afiliacion.Identificacion__c = data[pocisionIdentificacion].replace('-','');
                       afiliacion.Tipo_Identificacion__c = mapTipoIdentificacion.get(data[pocisionTipoIdentificacion]);
                       afiliacion.RTN__c = mapSiNo.get(data[pocisionRTN]);
                       afiliacion.FATCA__c = mapSiNo.get(data[pocisionFATCA]);
                       afiliacion.WAIVER__c = mapSiNo.get(data[pocisionWAIVER]);
                       afiliacion.PEP__c = mapSiNo.get(data[pocisionPEP]);
                       afiliacion.Procedencia__c = mapSiNo.get(data[pocisionProcedencia]);
                       afiliacion.Subproducto__r = new Subproducto__c  (Codigo__c = data[pocisionSubproducto]);
                       afiliacion.Empresa__c = cta.Cliente__c;// new Account(Cliente_Unico_Banco__c = data[pocisionEmpresa]);
                       afiliacion.Reporte_Calidad__c = mapReporteCalidad.get(data[pocisionReporteCalidad]);
                       afiliacion.Addendum__c = mapSiNo.get(data[pocisionAdendum]);
                       afiliacion.Tiene_Id__c = mapSiNo.get(data[pocisionTieneId]);
                       afiliacion.Codigo_Oficial_SAC__c = mapOficialSac.get(cta.Cliente__r.cliente_Unico_banco__c + usuario).codigo_oficial_sac__C;
                       afiliacion.Oficial_SAC__c = mapOficialSac.get(cta.Cliente__r.cliente_Unico_banco__c + usuario).oficial_sac__r.name;
                       afiliacion.Formulario_Completo__c = mapSiNo.get(data[pocisionFormularioCompleto]); 
                       afiliacion.Aplica_CS__c = mapSiNo.get(data[pocisionAplicaCS]);
                       afiliacion.Comentarios__c = data[pocisionComentarios];
                       afiliacion.Asesor_Comercial__c = asesor.asesor__r.name;
                       afiliacion.Codigo_Asesor_Comercial__c =asesor.codigo_asesor__C;
                       afiliacion.Tipo_Fondo__c = mapSubProducto.get(data[pocisionSubproducto]).tipo_fondo__C;
                       afiliacion.Tipo_Afiliacion__c = 'C';
                       afiliacion.CurrencyIsoCode = mapSubProducto.get(data[pocisionSubproducto]).producto__r.CurrencyIsoCode;
                       listAfiliaciones.add(afiliacion);
                   }
                   insert listAfiliaciones;
                   ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'Datos insertados con exito'));
                   //reinicar();
               }
            
        
        }catch (exception ex){
            retorno.error='Ha ocurrido un error.\n Error: '+ex.getMessage()+'\n Linea: '+ex.getLineNumber();
        }
        return retorno;
    }
    
    
    public class classPoPup{
        public boolean seleccionado {get;set;}
        public string id {get;set;}
        public string name {get;set;}
        public String codigo {get;set;}
        public String cuenta {get;set;}
    }

}