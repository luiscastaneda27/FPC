public class controladorMasivaEmpresa {
    
    public list<Reporte_calidad__C> listAfiliaciones{get;set;}
    public list<selectOption> listSubProductos{get;set;}
    public list<selectOption> listEmpresas{get;set;}
    public Reporte_calidad__C Afiliacion {get;set;}
    string Usuario;
    public producto__C producto {get;set;}
    public oficial_X_asesor__C asesor{get;set;}
    public string NombreProducto{get;set;}
    public string idAfiliacion{get;set;}
    public string tipoAfiliacion{get;set;}
    public blob file {get;set;}
    public string fileName {get;set;}
    public boolean popArchivo {get;set;}
    public string nombreEmpresa {get;set;}
    public string nombreSubProducto {get;set;}
    
    public string buscarSubProducto{get;set;}
    public string buscarEmpresa{get;set;}
    public list<classPoPup> listPopup {get;set;}
    public boolean popSubProducto{get;set;}
    public boolean popEmpresas{get;set;}
    
     public string linkPortal{get;set;}
    
    public controladorMasivaEmpresa(){
        try{
            usuario = ApexPages.currentPage().getParameters().get('usuario');
            //Usuario = 'HN52892';
            linkPortal = claseUtil.urlSysde('Site_pantallas');
            asesor = new oficial_X_asesor__C();
            asesor = [select codigo_asesor__C, Codigo_Oficial_SAC__c , oficial_sac__r.name,
                      asesor__r.name, asesor__r.email from oficial_X_asesor__C where codigo_asesor__C =:Usuario limit 1];
            reiniciar();
            cerrar();
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
    
    public void reiniciar(){
        listAfiliaciones = new list<Reporte_calidad__C>();
        listAfiliaciones = [select Addendum__c, Aplica_CS__c , Aportacion_HNL__c ,Aportacion_USD__c ,
                            Asesor_Comercial__c, Comentarios__c, Codigo_Asesor_Comercial__c,Codigo_Oficial_SAC__c ,
                            Empresa__c , Expediente_Completo__c , FATCA__c , Fecha_Envio_Memo__c, Fecha_Validacion__c ,
                            Fecha_Inicio_Aporte__c , Forma_Pago__c, Formulario_Completo__c, Identificacion__c ,
                            Numero_de_Cliente__c , Numero_de_Contrato__c ,Numero_Cuenta__c ,Oficial_SAC__c ,PEP__c ,
                            Periodicidad__c , name , Procedencia__c , Reporte_Calidad__c,RTN__c ,
                            Cantidad_Afiliaciones__C,id, Cuentas_Colectivas__c,
                            Primer_Apellido__c,Enviar_Sac__C,Tipo_Afiliacion__c,Codigo_T24__c ,
                            Subproducto__r.name,Empresa__r.name, Subproducto__r.producto__r.name,
                            Segundo_Apellido__c ,Segundo_Nombre__c , Seguro_HNL__c , Seguro_USD__c ,Subproducto__c ,
                            Tiene_Id__c , Tipo_Fondo__c , Tipo_Identificacion__c ,WAIVER__c from Reporte_calidad__C
                            where Codigo_Asesor_Comercial__c =:Usuario and Enviar_Sac__C =false
                            and Tipo_Afiliacion__c  ='M'];
        agregarAfiliacion();
    }
    public void agregarAfiliacion(){
        Afiliacion = new Reporte_calidad__C(Asesor_Comercial__c= asesor.asesor__r.name, Codigo_Asesor_Comercial__c =asesor.codigo_asesor__C,
                                           Codigo_Oficial_SAC__c =asesor.codigo_oficial_sac__C, Oficial_SAC__c =asesor.oficial_sac__r.name,
                                           Tipo_Afiliacion__c  ='M');
    }
    /*public void editar(){
         producto =new producto__C();
         afiliacion = new Reporte_calidad__C();
        for(Reporte_calidad__C item:listAfiliaciones ){
            if(idAfiliacion == item.Id){
                item.enviar_sac__C =false;
                afiliacion = item;
                producto.name = item.Subproducto__r.producto__r.name;
            }
        }
    }*/
    
    
    
    public void Enviar(){
        try{
           // system.debug(fileName + file + popArchivo);
            boolean haySeleccionado = false;
            if(Afiliacion.Empresa__c == null ||
               Afiliacion.Subproducto__c == null ||
               Afiliacion.Cantidad_Afiliaciones__c == null ||
               Afiliacion.Aplica_CS__c == null ){
                   ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, ' Por favor llenar todos los campos.'));
                   return ;
               }
            if(!popArchivo){
               popArchivo = true;
            }else if(fileName == null && file == null && popArchivo && Afiliacion.Codigo_T24__c == null){
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, ' Por favor Selecccione un archivo.'));
            }else{
                //afiliacion.enviar_sac__c = true;
                afiliacion.Fecha_Envio_Memo__c =date.today();
                afiliacion.Tipo_Afiliacion_Masiva__c = tipoAfiliacion;
                afiliacion.Name = 'Afiliación Masiva de Empresas';
                afiliacion.Estado__c = 'A';
                afiliacion.Enviar_Sac__c = true;
                upsert afiliacion;
                
                URL_conexion_Sysde__mdt URL = [select dirigido_a__C, Correo_electronico__c  from URL_conexion_Sysde__mdt where DeveloperName = 'Reporte_Calidad'];
                nombreEMpresa = [select name from account where id=:afiliacion.Empresa__c].name;
                nombreSubProducto = [select name from subProducto__C where id= :afiliacion.Subproducto__c].name;
                string cuerpo = 'Buen día <br/><br/>';
                cuerpo += URL.Dirigido_a__c + '<br/>';
                cuerpo += '<p>';
                cuerpo += 'Por medio del presente le enviamos para su afiliación una nueva carga de empresa masiva hecha por '+afiliacion.Asesor_Comercial__c;
                cuerpo +='</p><br/> <br/>';
                cuerpo += '<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-color:#044487;" >';
                cuerpo += '<tr ><td style="width:15%;">Empresa </td><td style="width:85%;">'+nombreEmpresa +'</td></tr>';
                cuerpo += '<tr ><td >Moneda </td><td >'+afiliacion.CurrencyIsoCode +'</td></tr>';
                cuerpo += '<tr ><td >Sub Producto </td><td >'+nombreSubProducto +'</td></tr>';
                cuerpo += '<tr ><td >Aplica Capital Semilla </td><td >'+(afiliacion.Aplica_CS__c == 'S' ? 'Si' : 'No') +'</td></tr>';
                cuerpo += '<tr ><td >Cantidad de Afiliaciones </td><td >'+afiliacion.Cantidad_Afiliaciones__c+'</td></tr>';
                cuerpo += afiliacion.Codigo_T24__c != null ? '<tr ><td >Código T24 </td><td >'+afiliacion.Codigo_T24__c+'</td></tr>' : '';
                cuerpo +='</table>';
                cuerpo +='<br/><br/>Muchas Gracias.';
                
                system.debug(cuerpo);
               // url.Correo_electronico__c = 'darlene.hernandez@ficohsa.com';
                Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
                email.setSubject(' Nueva carga masiva de Empresa - '+nombreEmpresa); 
                email.setToAddresses(new string[] {url.Correo_electronico__c/*,'silvia.ayestas@ficohsa.com'*/});
                email.setCcAddresses(new string[] {asesor.asesor__r.email});
                email.setHtmlBody(cuerpo);
                List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
                if(file !=null){
                    Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
                    efa.setFileName(fileName);
                    efa.setBody(file);
                    fileAttachments.add(efa);	
                    email.setFileAttachments(fileAttachments);
                }
                email.setOrgWideEmailAddressId(owea.get(0).Id);
                Messaging.SingleEmailMessage[] listEmail = new List<Messaging.SingleEmailMessage>(); 
                listEmail.add(email); 
                system.debug('Tamano de lista: '+listEmail.size());
                Messaging.sendEmail(listEmail, false);
               // Messaging.SendEmailResult[] results = Messaging.sendEmail(listEmail); 
                
                
                
                if(popArchivo && file !=null){
                    ContentVersion cv = new ContentVersion();
                    cv.ContentLocation = 'S';
                    cv.ContentDocumentId = null;
                    cv.VersionData = file; // Variable del archivo tipo Blob
                    cv.Title = fileName; // variable nombre del archivo tipo string
                    cv.PathOnClient = fileName; // variable nombre del archivo tipo string
                    insert cv;
                    ContentDocumentLink cdl = new ContentDocumentLink();
                    cdl.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: cv.Id].ContentDocumentId;
                    cdl.LinkedEntityId = afiliacion.id; 
                    cdl.ShareType = 'V';
                    insert cdl;
                    file = null;
                }
                reiniciar();
                popArchivo = false;
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, ' Datos guardados exitosamente.'));
            }
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, ' Ha ocurrido un error.'));
        }
        
    }
    
    public boolean popEliminar{get;set;}
    public string nombreAfiiacion{get;set;}
    
    public void cerrar(){
        popEliminar = false; 
        popArchivo = false;
    }
    
    public PageReference descargarArchivo(){
        return new PageReference (claseUtil.urlSysde('Archivo_de_Carga_Reporte_de_Calidad'));
    }
    
    public void selectCuenta(){
        try{
            afiliacion.Cuentas_Colectivas__c = ' ';
            if(afiliacion.Empresa__c !=null){
                for(cuentas__C item: [select codigo__C from cuentas__C where cliente__C =: afiliacion.Empresa__c]){
                    afiliacion.Cuentas_Colectivas__c += item.codigo__C = ' ';
                }
                Oficiales_X_Empresa__c item = [select codigo_oficial_sac__C, oficial_sac__r.name
                                               from Oficiales_X_Empresa__c where empresa__C=:afiliacion.Empresa__c limit 1];
                Afiliacion.Codigo_Oficial_SAC__c =item.codigo_oficial_sac__C;
                Afiliacion.Oficial_SAC__c =item.oficial_sac__r.name;
            }
        }catch(exception ex){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ' La empresa seleccionada no tiene oficial Asignado '));
        }
        popEmpresas = false;
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
    
    
    
    public class classPoPup{
        public boolean seleccionado {get;set;}
        public string id {get;set;}
        public string name {get;set;}
    }

}