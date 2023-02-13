public class controladorAfiliacionFicopen {
    
    public list<Reporte_calidad__C> listAfiliaciones{get;set;}
    public list<selectOption> listSubProductos{get;set;}
    public list<selectOption> listEmpresas{get;set;}
    public Reporte_calidad__C Afiliacion {get;set;}
    string Usuario;
    public producto__C producto {get;set;}
    public Usuarios_de_Pantallas__c  asesor{get;set;}
    public string buscarEmpresa{get;set;}
    public list<classPoPup> listPopup {get;set;}
    public boolean popSubProducto{get;set;}
    public boolean popEmpresas{get;set;}
    string correoOficial;
    public boolean haySeleccionado {get;set;}
    
    
    public controladorAfiliacionFicopen(){
        try{
            usuario = ApexPages.currentPage().getParameters().get('usuario');
            asesor = new Usuarios_de_Pantallas__c ();
            asesor = [select Apellido__c , name , usuario__C, email__C
                      from Usuarios_de_Pantallas__c  where usuario__C =:Usuario];
            reinicar();
            haySeleccionado();
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
    
    public void haySeleccionado(){
        haySeleccionado = false;
        for(Reporte_calidad__C item: listAfiliaciones){
            if(item.enviar_sac__C){
                haySeleccionado = true;
            }
        }
    }
    
    public void reinicar(){
        listAfiliaciones = new list<Reporte_calidad__C>();
        listAfiliaciones = [select Addendum__c, Aplica_CS__c , Aportacion_HNL__c ,Aportacion_USD__c ,
                            espediente_completo__C,
                            Asesor_Comercial__c, Comentarios__c, Codigo_Asesor_Comercial__c,Codigo_Oficial_SAC__c ,
                            Empresa__c , Expediente_Completo__c , FATCA__c , Fecha_Envio_Memo__c, Fecha_Validacion__c ,
                            Fecha_Inicio_Aporte__c , Forma_Pago__c,estado__C, Formulario_Completo__c, Identificacion__c ,
                            Numero_de_Cliente__c , Numero_de_Contrato__c ,Numero_Cuenta__c ,Oficial_SAC__c ,PEP__c ,
                            Periodicidad__c , name , Procedencia__c , Reporte_Calidad__c,RTN__c ,id,
                            DebidaDiligencia__c,FechaIngreso__c ,Fecha_Devolucion__c,
                            Primer_Apellido__c,Enviar_Sac__C,Tipo_Afiliacion__c,CurrencyIsoCode,Cuentas_Colectivas__c,
                            Subproducto__r.name,Empresa__r.name, Subproducto__r.producto__r.name,
                            Segundo_Apellido__c ,Segundo_Nombre__c , Seguro_HNL__c , Seguro_USD__c ,Subproducto__c ,
                            Tiene_Id__c , Tipo_Fondo__c , Tipo_Identificacion__c ,WAIVER__c from Reporte_calidad__C
                            where Codigo_Oficial_SAC__c =:Usuario and Tipo_Afiliacion__c='FCS' and estado__C ='V' ];
        agregarAfiliacion();
    }
    public void agregarAfiliacion(){
        Afiliacion = new Reporte_calidad__C(/*Asesor_Comercial__c= asesor.asesor__r.name, Codigo_Asesor_Comercial__c =asesor.codigo_asesor__C,*/
            Codigo_Oficial_SAC__c =usuario, Oficial_SAC__c =asesor.name +' '+asesor.apellido__C,
            Tipo_Afiliacion__c  ='FCS ', Reporte_calidad__C = 'F', estado__C='V');
        SelectSubProductoPop();
    }
    public string idAfiliacion{get;set;}
    
    public void editar(){
        producto =new producto__C();
        afiliacion = new Reporte_calidad__C();
        for(Reporte_calidad__C item:listAfiliaciones ){
            if(idAfiliacion == item.Id){
                item.enviar_sac__C =false;
                item.formulario_completo__C = null;
                afiliacion = item;
            }
            
        }
        
    }
    
    public void Enviar(){
        try{
            integer contador = 0;
            for(Reporte_calidad__C item:listAfiliaciones ){
                if(item.enviar_sac__c){
                    item.fecha_validacion__C =date.today();
                    item.estado__C = 'A';
                    contador ++;
                }
            }
            if(contador> 0){
                
                URL_conexion_Sysde__mdt URL = [select dirigido_a__C, Correo_electronico__c  from URL_conexion_Sysde__mdt where DeveloperName = 'Reporte_Calidad'];
                //url.Correo_electronico__c = 'ivotcast@gmail.com';
                Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
                email.setSubject(' Nueva Afiliaciones de FICOPEN  - '+ date.today().format()); 
                email.setToAddresses(new string[] {url.Correo_electronico__c});
                email.setPlainTextBody('Buen día '+URL.dirigido_a__C+'.\n\n Por medio del presente le notificamos que el oficial Sac '+asesor.name +' '+asesor.apellido__C +' agrego '+contador+' afiliaciones de Ficopen.\n\n Favor dar Seguimiento, Muchas gracias.');
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
                email.setOrgWideEmailAddressId(owea.get(0).Id);
                Messaging.SingleEmailMessage[] listEmail = new List<Messaging.SingleEmailMessage>(); 
                listEmail.add(email); 
                system.debug('Tamano de lista: '+listEmail.size());
                update listAfiliaciones;
                Messaging.SendEmailResult[] results = Messaging.sendEmail(listEmail, false);
                reinicar();
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
        popEmpresas = false;
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
    
    
    public void selectEmpresa(){
        afiliacion.Cuentas_Colectivas__c = '';
        for(cuentas__C item: [select codigo__C from cuentas__C where cliente__C =: afiliacion.Empresa__c and CurrencyIsoCode =:afiliacion.CurrencyIsoCode]){
            afiliacion.Cuentas_Colectivas__c += item.codigo__C = ' ';
        }
        
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
            if(listCuentas.size() > 0){
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.WARNING, ' Esta persona ya esta afiliado, con este nuemero de cuenta '+listCuentas[0].codigo__C));
            }
        }
    }
    public void guardar(){
        if((afiliacion.name == null || afiliacion.name.trim() ==''  ||afiliacion.Primer_Apellido__c == null ||
            afiliacion.Tipo_Identificacion__c == null ||afiliacion.Identificacion__c == null ||
            afiliacion.Tiene_Id__c == null ||afiliacion.RTN__c == null ||afiliacion.FATCA__c == null || afiliacion.Reporte_calidad__c == null ||
            afiliacion.WAIVER__c == null ||afiliacion.PEP__c == null ||afiliacion.Procedencia__c == null ||
            afiliacion.Addendum__c == null ||afiliacion.Tipo_Fondo__c == null ||afiliacion.Subproducto__c == null ||
            afiliacion.Empresa__c == null ||afiliacion.Reporte_Calidad__c == null  ||
            afiliacion.Formulario_Completo__c == null  ) && Afiliacion.espediente_completo__C == 'S' ){
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'Por favor Completar todos los campos.'));
            }else if(afiliacion.name == null || afiliacion.Primer_Apellido__c == null  ||afiliacion.Tipo_Identificacion__c == null ||afiliacion.Identificacion__c == null){
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, 'Por favor completar el nombre e identificación.'));
            }else{
                upsert Afiliacion;
                reinicar();
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Datos guardados exitosamente.'));
            }
        
    }
    
    public void accionVacia(){
        
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
                 from subProducto__C where codigo__C ='FI010' ]){
                     afiliacion.CurrencyIsoCode = item.producto__r.CurrencyIsoCode;
                     afiliacion.Tipo_Fondo__c = item.tipo_fondo__C;
                     afiliacion.Subproducto__c = item.id;
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