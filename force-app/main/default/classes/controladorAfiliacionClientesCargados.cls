//public class controladorAfiliacionClientesCargados {

public class controladorAfiliacionClientesCargados {
    
    public list<Reporte_calidad__C> listAfiliaciones{get;set;}
    public list<selectOption> listSubProductos{get;set;}
    public list<selectOption> listEmpresas{get;set;}
    public Reporte_calidad__C Afiliacion {get;set;}
    string Usuario;
    public producto__C producto {get;set;}
    public oficial_X_asesor__C asesor{get;set;}
    public string NombreProducto{get;set;}
    public string idAfiliacion{get;set;}
    public string buscarSubProducto{get;set;}
    public string buscarEmpresa{get;set;}
    public list<classPoPup> listPopup {get;set;}
    public boolean popSubProducto{get;set;}
    public boolean popEmpresas{get;set;}
    
    
    public controladorAfiliacionClientesCargados(){
        try{
            usuario = ApexPages.currentPage().getParameters().get('usuario');
            //Usuario = 'HN52892';
            asesor = new oficial_X_asesor__C();
            asesor = [select codigo_asesor__C, Codigo_Oficial_SAC__c , oficial_sac__r.name,
                      oficial_sac__r.email,
                      asesor__r.name, asesor__r.email from oficial_X_asesor__C where codigo_asesor__C =:usuario limit 1];
            reinicar();
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
        }catch(exception ex){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Usted no tiene oficiales Sac asignados, por favor contacto su admin.'));
        }
    }
    
    
    public void reinicar(){
        listAfiliaciones = new list<Reporte_calidad__C>();
        buscarSubProducto = '';
        buscarEmpresa = '';
        listAfiliaciones = [select Addendum__c, Aplica_CS__c , Aportacion_HNL__c ,Aportacion_USD__c ,
                            Cuentas_Colectivas__c,
                            Asesor_Comercial__c, Comentarios__c, Codigo_Asesor_Comercial__c,Codigo_Oficial_SAC__c ,
                            Empresa__c , Expediente_Completo__c , FATCA__c , Fecha_Envio_Memo__c, Fecha_Validacion__c ,
                            Fecha_Inicio_Aporte__c , Forma_Pago__c, Formulario_Completo__c, Identificacion__c ,
                            Numero_de_Cliente__c , Numero_de_Contrato__c ,Numero_Cuenta__c ,Oficial_SAC__c ,PEP__c ,
                            Periodicidad__c , name , Procedencia__c , Reporte_Calidad__c,RTN__c ,id,
                            DebidaDiligencia__c,
                            Primer_Apellido__c,Enviar_Sac__C,Tipo_Afiliacion__c,CurrencyIsoCode,estado__c,
                            Subproducto__r.name,Empresa__r.name, Subproducto__r.producto__r.name,
                            Segundo_Apellido__c ,Segundo_Nombre__c , Seguro_HNL__c , Seguro_USD__c ,Subproducto__c ,
                            Tiene_Id__c , Tipo_Fondo__c , Tipo_Identificacion__c ,WAIVER__c from Reporte_calidad__C
                            where Codigo_Asesor_Comercial__c =:Usuario and Enviar_Sac__C =false
                            and Tipo_Afiliacion__c  ='YC' 
                            order by LastModifiedDate desc limit 950];
        agregarAfiliacion();
    }
    
    public void agregarAfiliacion(){
        Afiliacion = new Reporte_calidad__C(Asesor_Comercial__c= asesor.asesor__r.name, Codigo_Asesor_Comercial__c =asesor.codigo_asesor__C,
                                            Tipo_Afiliacion__c ='YC', estado__C='N');
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
            String Codigo;
            List<Reporte_calidad__C> listUpsert = new List<Reporte_calidad__C>();
            for(Reporte_calidad__C item:listAfiliaciones ){
                if(item.enviar_sac__c){
                    item.Fecha_Envio_Memo__c =date.today();
                    item.estado__C = 'V';
                    codigo = item.Codigo_Oficial_SAC__c;
                    contador ++;
                    listUpsert.add(item);
                }
            }
            if(contador> 0){
                oficial_X_asesor__C oficial = [select Oficial_SAC__r.email,Oficial_SAC__r.name from oficial_X_asesor__C where Codigo_Oficial_SAC__c =:codigo limit 1];
                Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
                email.setSubject(' Nueva Afiliaciones de Clientes ya Cargados  - '+ date.today().format()); 
                email.setToAddresses(new string[] {oficial.Oficial_SAC__r.email});
                email.setCcAddresses(new string[] {asesor.asesor__r.email});
                email.setPlainTextBody('Buen día '+oficial.Oficial_SAC__r.name+'.\n\n Por medio del presente le notificamos que el asesor '+asesor.Asesor__r.name +' agrego '+contador+' afiliaciones de clientes ya cargados.\n\n Favor dar Seguimiento, Muchas gracias.');
                List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
                email.setOrgWideEmailAddressId(owea.get(0).Id);
                Messaging.SingleEmailMessage[] listEmail = new List<Messaging.SingleEmailMessage>(); 
                listEmail.add(email); 
                system.debug('Tamano de lista: '+JSON.serialize(listAfiliaciones));
                update listUpsert;
                reinicar();
                Messaging.SendEmailResult[] results = Messaging.sendEmail(listEmail, false);
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Datos guardados exitosamente.'));
            }
        }catch(exception ex){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'Ha ocurrido un error. '+ex.getMessage()+ ', Linea: '+ex.getLineNumber()));
        }
        
    }
    
    public boolean popEliminar{get;set;}
    public string nombreAfiiacion{get;set;}
    
    public void cerrar(){
        popEliminar = false; 
    }
    
    public void EliminarAfiliacion(){
        for(Reporte_calidad__C item:listAfiliaciones ){
            if(idAfiliacion == item.Id){
                delete(item);
            }
        }
        reinicar();
        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Datos guardados exitosamente.'));
        popEliminar = false;   
    }
    
    public void SelectPopEliminar(){
        for(Reporte_calidad__C item:listAfiliaciones ){
            if(idAfiliacion == item.Id){
                nombreAfiiacion =item.name +' '+item.primer_apellido__C;
            }
        }
        popEliminar = true; 
    }
    
    
    public void ValidacionIdentidad(){
        if(afiliacion.Identificacion__c !=null){
            afiliacion.Identificacion__c = afiliacion.Identificacion__c.replace('-','');
            list<Cuentas__C> listCuentas = [select id, cliente__r.name, codigo__C from Cuentas__C where cliente__r.identificacion__C = :afiliacion.Identificacion__c limit 1];
            if(listCuentas.size() > 0 ){
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.WARNING, ' Esta persona ya esta afiliado, con este nuemero de cuenta '+listCuentas[0].codigo__C));
            }
        }
    }
    
    public void selectCuenta(){
        try{
            Afiliacion.Codigo_Oficial_SAC__c = null;
            Afiliacion.Oficial_SAC__c = null;
            afiliacion.Cuentas_Colectivas__c = '';
            if(afiliacion.Empresa__c !=null){
                for(cuentas__C item: [select codigo__C from cuentas__C where cliente__C =: afiliacion.Empresa__c and CurrencyIsoCode =:afiliacion.CurrencyIsoCode]){
                    afiliacion.Cuentas_Colectivas__c += item.codigo__C + ' ';
                }
                Oficiales_X_Empresa__c item = [select codigo_oficial_sac__C, oficial_sac__r.name
                                               from Oficiales_X_Empresa__c 
                                               where empresa__C=:afiliacion.Empresa__c 
                                               and Codigo_Asesor__c=:asesor.Codigo_Asesor__c limit 1];
                Afiliacion.Codigo_Oficial_SAC__c =item.codigo_oficial_sac__C;
                Afiliacion.Oficial_SAC__c =item.oficial_sac__r.name;
            }
            popEmpresas = false;
        }catch(exception ex){
            popEmpresas = false;
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ' La empresa seleccionada no tiene oficial Asignado '));
        }
    }
    
    
    public void guardar(){
        if((afiliacion.name == null  ||afiliacion.Primer_Apellido__c == null  || afiliacion.Aplica_CS__c == null ||
            afiliacion.Tipo_Identificacion__c == null ||afiliacion.Identificacion__c == null ||
            afiliacion.Tiene_Id__c == null ||afiliacion.RTN__c == null ||afiliacion.FATCA__c == null ||
            afiliacion.WAIVER__c == null ||afiliacion.PEP__c == null ||afiliacion.Procedencia__c == null ||
            afiliacion.Addendum__c == null ||afiliacion.Tipo_Fondo__c == null ||afiliacion.Subproducto__c == null ||
            afiliacion.Reporte_Calidad__c == null || afiliacion.Empresa__c == null ) && Afiliacion.Formulario_Completo__c == 'S' ){
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'Por favor Completar todos los campos.'));
            }else if(afiliacion.name == null || afiliacion.Primer_Apellido__c == null  
                     ||afiliacion.Tipo_Identificacion__c == null ||afiliacion.Identificacion__c == null){
                         ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'Por favor completar el nombre e identificación.'));
                     }else{
                         aSysdeReporteCalidad.ClassReporteCalidad   respuesta= aSysdeReporteCalidad.infoCliente(afiliacion.Identificacion__c); 
                         //afiliacion.Numero_Cuenta__c = respuesta.numCuenta;
                         afiliacion.Numero_de_Cliente__c = respuesta.clienteUnicoBanco;
                         afiliacion.Numero_de_Contrato__c = respuesta.numContrato;
                         if(respuesta.numCuenta ==null || respuesta.numCuenta.trim() ==''  ){
                             ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'No procede ya que el cliente no existe en Sysde.'));
                             return;
                         }
                         upsert Afiliacion;
                         reinicar();
                         ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Datos guardados exitosamente.'));
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
                list<subProducto__C> listSP = [select id, name, producto__r.name, producto__r.CurrencyIsoCode, tipo_fondo__C  
                                               from subProducto__C where codigo__C like : '%'+buscarSubProducto+'%' or name like : '%'+buscarSubProducto+'%' ];
                if(listSP.size()==0){
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'No se han encontrado coincidencias.'));
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
    
    public void BuscarEmpresa(){
        try{
            afiliacion.Empresa__c = null;
            list<account> listCuentas = [select id, name from account where name like : '%'+buscarEmpresa+'%' and 
                                         RecordTypeId =:Schema.SObjectType.Account.getRecordTypeInfosByName().get('Juridico').getRecordTypeId() ];
            if(listCuentas.size()==0){
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'No se han encontrado coincidencias.'));
            }else if(listCuentas.size() >0){
                listPopup = new list<classPoPup> ();
                for(account item: listCuentas){
                    classPoPup a = new classPoPup ();
                    a.seleccionado = false;
                    a.name = item.name;
                    a.id= item.id;
                    listPopup.add(a);
                }
                popEmpresas = true;
            }
        }catch(Exception ex){
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
    
    @future(callout=true)
    public static void crearAfilaicionT24(String dataJson){
        try{
            List<reporteT24__c> listT24 = (List<reporteT24__c>) JSON.deserialize(dataJson, List<reporteT24__c>.class);
            System.debug('listT24: '+dataJson);
            List<Reporte_Calidad__c> listRC = new  List<Reporte_Calidad__c>();
            Map<string, Oficiales_X_Empresa__c> mapAsesoresOficiales = new Map<string, Oficiales_X_Empresa__c>();
            Map<string, String> mapTipoFondo = new Map<string, String>();
            for(Oficiales_X_Empresa__c item: [select Id, Asesor__r.Name, Codigo_Asesor__c, Oficial_SAC__r.Name , Codigo_Oficial_SAC__c, Empresa__c, Empresa__r.Identificacion__c from Oficiales_X_Empresa__c where Codigo_Asesor__c != null and  Empresa__r.Identificacion__c != null order by Codigo_Asesor__c]){
                mapAsesoresOficiales.put(item.Codigo_Asesor__c+item.Empresa__r.Identificacion__c, item);
            }
            for(SubProducto__c item: [select Codigo__c,  Tipo_Fondo__c from SubProducto__c]){
                mapTipoFondo.put(item.Codigo__c, item.Tipo_Fondo__c);
            }
            for(reporteT24__c t24: listT24){
                Reporte_Calidad__c RC = new Reporte_Calidad__c();
                t24.identificacion__c = t24.identificacion__c.replace('-','');
                String keyMap = t24.promotor__c + t24.rtnEmpleador__c;
                Oficiales_X_Empresa__c asesor = mapAsesoresOficiales.containsKey(keyMap) ? mapAsesoresOficiales.get(keyMap) : new Oficiales_X_Empresa__c();
                aSysdeReporteCalidad.ClassReporteCalidad respuesta = aSysdeReporteCalidad.infoCliente(t24.identificacion__c.replace('-',''));
                if(respuesta.numCuenta != null){
                    RC.Name = t24.pNombreEmpleado__c;
                    RC.Segundo_Nombre__c = t24.sNombreEmpleado__c;
                    RC.Primer_Apellido__c = t24.pApellidoEmpleado__c;
                    RC.Segundo_Apellido__c = t24.sApellidoEmpleado__c;
                    RC.Tiene_Id__c = 'S';
                    RC.Tipo_Identificacion__c = t24.TipoId__c;
                    RC.Identificacion__c = t24.identificacion__c.replace('-','');
                    RC.FATCA__c = 'S';
                    RC.PEP__c = 'S';
                    RC.Addendum__c = 'S';
                    RC.RTN__c = 'S';
                    RC.WAIVER__c = 'S';
                    RC.Procedencia__c = 'S';
                    RC.Numero_Cuenta__c = respuesta.numCuenta;
                    RC.Subproducto__r = new SubProducto__c(Codigo__c = t24.subProducto__c);
                    RC.Empresa__r = new Account(Identificacion__c = t24.rtnEmpleador__c);
                    RC.Reporte_Calidad__c = 'P';
                    RC.Aplica_CS__c = 'N';
                    RC.Codigo_Asesor_Comercial__c = asesor.Codigo_Asesor__c;
                    RC.Asesor_Comercial__c = asesor.Asesor__r.Name;
                    RC.Codigo_Oficial_SAC__c = asesor.Codigo_Oficial_SAC__c;
                    RC.Oficial_SAC__c = asesor.Oficial_SAC__r.Name;
                    RC.Estado__c = 'N';
                    RC.Tipo_Afiliacion__c  ='YC';
                    RC.Formulario_Completo__c = 'S';
                    RC.Tipo_Fondo__c = String.isNotBlank(t24.subProducto__c) ? mapTipoFondo.get(t24.subProducto__c) : null;
                    RC.Cuentas_Colectivas__c = t24.noEmpresa__c;
                    RC.CurrencyIsoCode = t24.CurrencyIsoCode;
                    listRC.add(RC);
                }
            }
            System.debug('listRC: '+JSON.serialize(listRC));
            DataBase.insert(listRC, false);
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+',  Linea: '+ex.getLineNumber()); 
        }
    }
    
    public void buscarCuenta(){
        try{
            if(afiliacion.Numero_Cuenta__c !=null && afiliacion.Numero_Cuenta__c !=''){
                for(Reporte_calidad__c item : [select Asesor_Comercial__c, toLabel(Estado__c) from Reporte_calidad__c where Numero_Cuenta__c =:afiliacion.Numero_Cuenta__c]){
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'La cuenta consultada se encuentra en estado '+item.Estado__c+' y le pertenece al asesor '+item.Asesor_Comercial__c)); 
                    return;
                }
                ClienteNaturales consulta = controllerApiClienteNatural.ConsultaInfoClienteC(afiliacion.Numero_Cuenta__c);
                if((consulta.pcnroid !=null && consulta.pcnroid != '' && consulta.pcnroid != 'null') || test.isRunningTest()){
                    afiliacion.Tipo_Identificacion__c = consulta.pctipoid;
                    afiliacion.Identificacion__c = consulta.pcnroid;
                    afiliacion.Name = consulta.pcprimernombre;
                    afiliacion.Segundo_Nombre__c = consulta.pcsegundonombre != 'null' ? consulta.pcsegundonombre : '' ;
                    afiliacion.Primer_Apellido__c = consulta.pcprimerapellido;
                    afiliacion.Segundo_Apellido__c = consulta.pcsegundoapellido !='null' ? consulta.pcsegundoapellido : '' ;
                    
                    for(Cuentas__c item : [select id, cliente__C from cuentas__C where codigo__C =: consulta.pccontratocolectivo]){
                        afiliacion.Empresa__c = item.cliente__C;
                    }
                    
                    for(subProducto__C item:
                        [select id, name, producto__r.name, producto__r.CurrencyIsoCode, tipo_fondo__C  
                         from subProducto__C where codigo__C=:consulta.pcsubproducto]){
                             afiliacion.Subproducto__c = item.id; 
                             afiliacion.CurrencyIsoCode = item.producto__r.CurrencyIsoCode;
                             afiliacion.Tipo_Fondo__c = item.tipo_fondo__C;
                             producto =new producto__C(name= item.producto__r.name);
                             
                         }
                    
                    list<Oficiales_X_Empresa__c> item = [select codigo_oficial_sac__C, oficial_sac__r.name
                                                         from Oficiales_X_Empresa__c where empresa__c=:afiliacion.Empresa__c limit 1];
                    if(item.size() > 0){
                        Afiliacion.Codigo_Oficial_SAC__c =item[0].codigo_oficial_sac__C;
                        Afiliacion.Oficial_SAC__c =item[0].oficial_sac__r.name;
                    }
                }else{
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'El numero de cuenta '+afiliacion.Numero_Cuenta__c+' no existe'));
                    afiliacion.Numero_Cuenta__c = null;
                }
            }else{
                //ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'Por favor digite un numero de cuenta'));
            }
        }catch(exception ex){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'Error: '+ex.getMessage()+',  Linea: '+ex.getLineNumber()));
        }
    }
    
     
    public class classPoPup{
        public boolean seleccionado {get;set;}
        public string id {get;set;}
        public string name {get;set;}
    }
    
}