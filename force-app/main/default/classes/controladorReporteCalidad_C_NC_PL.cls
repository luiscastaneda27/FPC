public class controladorReporteCalidad_C_NC_PL {
 
    public list<Reporte_calidad__C> listAfiliaciones{get;set;}
    public Reporte_calidad__C Afiliacion {get;set;}
    string usuario;
    string tipoPantalla;
    public producto__C producto {get;set;}
    public boolean popAfiliacion{get;set;}
    public string URLPagina {get;set;}
    public string nombreTipoPantalla {get;set;}
    public string idAfiliacion{get;set;}
    
    
    public controladorReporteCalidad_C_NC_PL(){
        try{
            usuario = ApexPages.currentPage().getParameters().get('usuario');
            tipoPantalla = ApexPages.currentPage().getParameters().get('idPantalla');
            system.debug('Paramtros: '+usuario +'    '+tipoPantalla);
            nombreTipoPantalla =   tipoPantalla == 'C' ? 'Contributivos' : tipoPantalla == 'N' ? 'No Contributivos': 'Planilla';
            reinicar();
        }catch(exception ex){
              ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Ha ocurrido un error, por favor contacte a su administrador.'));
        }
         
    }
    
    public void cerrar(){
        popAfiliacion = false;
        cambioCampos = false;
        URLPagina = null;
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
                            Estado__c, fecha_devolucion__C,Enviar_Afiliacion__C,aporte_patrono__C,ExpedienteFisicoRecibido__C,
                            CurrencyIsoCode,Nacionalidad__c, sexo__C,fecha_nacimiento__C,Fecha_ingreso_empresa__C,
                            profesion__C,estado_civil__C, lugar_nacimiento__C,nombre_conyuge__C,cargo__C,
                            Primer_Apellido__c,Enviar_Sac__C,Tipo_Afiliacion__c,Aprueba_SAC__c ,
                            Subproducto__r.name,Empresa__r.name, Subproducto__r.producto__r.name,Subproducto__r.Tipo_Fondo__c,
                            Espediente_Completo__C,
                            Segundo_Apellido__c ,Segundo_Nombre__c , Seguro_HNL__c , Seguro_USD__c ,Subproducto__c ,
                            Tiene_Id__c , Tipo_Fondo__c , Tipo_Identificacion__c ,WAIVER__c from Reporte_calidad__C
                            where Codigo_Oficial_SAC__c =:Usuario and Enviar_Sac__C =true 
                            and (Espediente_Completo__c != 'S' OR(estado__C = 'A' AND Enviar_Afiliacion__C = false))
                            and Reporte_Calidad__c   =:tipoPantalla order by LastModifiedDate desc limit 950];
        
       // agregarAfiliacion();
    }
    
    
    public void editar(){
         producto =new producto__C();
         afiliacion = new Reporte_calidad__C();
        for(Reporte_calidad__C item:listAfiliaciones ){
            if(idAfiliacion == item.Id){
                afiliacion = item;
                producto.name = item.Subproducto__r.producto__r.name;
            }
        }
    }
    
    public void enviar(){
        try{
            String asesor;
            String oficial;
            Integer contador = 0;
            for(Reporte_calidad__C item:listAfiliaciones ){
                if(item.enviar_afiliacion__C){
                    contador ++;
                    asesor = item.Asesor_Comercial__c;
                    oficial = item.Oficial_SAC__c;
                    if(item.Tipo_Fondo__c == null){
                       item.Tipo_Fondo__c = item.subProducto__r.Tipo_Fondo__c;
                    }
                     
                }
            }
            oficial_X_asesor__C asesorCo = [select codigo_asesor__C, Codigo_Oficial_SAC__c , oficial_sac__r.name,
                                            oficial_sac__r.email,
                                            asesor__r.name, asesor__r.email from oficial_X_asesor__C where Codigo_Oficial_SAC__c =:usuario limit 1];
            URL_conexion_Sysde__mdt URL = [select dirigido_a__C, Correo_electronico__c  from URL_conexion_Sysde__mdt where DeveloperName = 'Reporte_Calidad'];
            string cuerpo = 'Buen día <br/><br/>';
            cuerpo += URL.Dirigido_a__c + '<br/>';
            cuerpo += '<p>';
            cuerpo += 'Por medio del presente le informamos que el Asesor '+asesor+' ha agregado '+contador+' afiliaciones nuevas  que han sido validada por Oficial Sac '+Oficial;
            cuerpo +='</p><br/> <br/>';
            cuerpo +='<br/><br/>Muchas Gracias.';
            //URL.Correo_electronico__c = 'paola.cruz@ficohsa.com';
            system.debug(cuerpo);
            // url.Correo_electronico__c = 'luis.castaneda@intellectsystem.net';
            Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
            email.setSubject(' Nueva Carga de Afiliaciones - '+date.today().format()); 
            email.setToAddresses(new string[] {url.Correo_electronico__c});
            email.setCcAddresses(new string[] {asesorCo.Oficial_SAC__r.email});
            email.setHtmlBody(cuerpo);
            List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
            email.setOrgWideEmailAddressId(owea.get(0).Id);
            Messaging.SingleEmailMessage[] listEmail = new List<Messaging.SingleEmailMessage>(); 
            listEmail.add(email); 
            system.debug('Tamano de lista: '+listEmail.size());
            Messaging.SendEmailResult[] results = Messaging.sendEmail(listEmail); 
            update listAfiliaciones;
            reinicar();
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
    }
    
    public void ValidacionIdentidad(){
        if(afiliacion.Identificacion__c !=null){
            list<Cuentas__C> listCuentas = [select id, cliente__r.name, codigo__C from Cuentas__C where cliente__r.identificacion__C = :afiliacion.Identificacion__c limit 1];
            if(listCuentas.size() > 0){
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.WARNING, ' Esta persona ya esta afiliado, con este nuemero de cuenta '+listCuentas[0].codigo__C));
            }
        }
    }
    
    
    
    public void guardar(){
        try{
        if(Afiliacion.Espediente_Completo__c == 'N'){
            Afiliacion.Enviar_Sac__c = false;
            afiliacion.Formulario_Completo__c = 'N';
            afiliacion.Estado__c = 'D'; 
            afiliacion.fecha_devolucion__C = date.today();
            update afiliacion;
            string cuerpo = 'Buen día <br/><br/>';
            cuerpo += afiliacion.Asesor_Comercial__c + '<br/>';
            cuerpo += '<p>';
            cuerpo += 'Por medio del presente le informamos que el Oficial Sac '+afiliacion.Oficial_SAC__c+' le ha devuelto una afiliación del reporte de calidad <br/><br/> Favor dar seguimiento ';
            cuerpo +='</p><br/> <br/>';
            cuerpo +='<br/><br/>Muchas Gracias.';
            string correo = [select email__C from Usuarios_de_Pantallas__c where usuario__C =:afiliacion.Codigo_Asesor_Comercial__c  limit 1].email__C;
            system.debug(cuerpo);
            // url.Correo_electronico__c = 'luis.castaneda@intellectsystem.net';
            Messaging.singleEmailMessage email = new Messaging.singleEmailMessage();
            email.setSubject(' Devolución de afiliacion - '+date.today().format()); 
            email.setToAddresses(new string[] {correo});
            email.setHtmlBody(cuerpo);
            List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
            email.setOrgWideEmailAddressId(owea.get(0).Id);
            Messaging.SingleEmailMessage[] listEmail = new List<Messaging.SingleEmailMessage>(); 
            listEmail.add(email); 
            system.debug('Tamano de lista: '+listEmail.size());
            Messaging.SendEmailResult[] results = Messaging.sendEmail(listEmail); 
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Datos Guardados Exitosamente.'));
            reinicar();
        }else if( afiliacion.name == null  ||afiliacion.Primer_Apellido__c == null ||
            afiliacion.Tipo_Identificacion__c == null ||afiliacion.Identificacion__c == null ||
            afiliacion.Tiene_Id__c == null ||afiliacion.RTN__c == null ||afiliacion.FATCA__c == null ||
            afiliacion.WAIVER__c == null ||afiliacion.PEP__c == null ||afiliacion.Procedencia__c == null ||
            afiliacion.Addendum__c == null ){
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'Por favor Completar todos los campos.'));
            }else if(afiliacion.Espediente_Completo__c == 'S'){ 
                afiliacion.Fecha_Validacion__c  = date.today();
                if(afiliacion.Tipo_Afiliacion__c =='YC' ){
                    if(afiliacion.Numero_Cuenta__c == null || afiliacion.Numero_Cuenta__c.trim() == ''){
                        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Por favor digitar num de cuenta.'));
                        return;
                    }else{
                        afiliacion.Estado__c = 'C';
                        popAfiliacion = true;
                    }
                }else if(afiliacion.Tipo_Afiliacion__c =='C'){
                    afiliacion.Estado__c = 'A';
                    popAfiliacion = true;   
                }
               update afiliacion;
            }
        }catch(exception ex){
             ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Ha ocurrido un error, por favor contacte su admin.'));
        }
       
    }
    
    
    
    public void accionVacia(){
        
    }
    public boolean cambioCampos {get;set;}
    
    public void GuardarPop(){
        try{
            if((afiliacion.Estado_CIvil__c == 'U' || afiliacion.Estado_CIvil__c =='C')
               && afiliacion.Nombre_Conyuge__c == null && cambioCampos){
                  ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Escriba el nombre del conyuge.')); 
                   return;
               }
            
            if(afiliacion.Tipo_Afiliacion__c =='YC' || cambioCampos){
                system.debug('Tipo de Fondo: '+afiliacion.Subproducto__r.Tipo_Fondo__c);
                Compra_Venta_Dolares__mdt  dato = [select Cuenta_Destino__c ,Cuenta_Origen__c ,
                                                   Nivel_Cinco__c , Nivel_Cuatro__c , Nivel_Dos__c ,
                                                   Nivel_Tres__c , Nivel_Uno__c 
                                                   from Compra_Venta_Dolares__mdt where DeveloperName =:afiliacion.Subproducto__r.Tipo_Fondo__c];
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Datos guardados exitosamente.'));
                aSysdeReporteCalidad.classEstadoCapital claseenvio = new aSysdeReporteCalidad.classEstadoCapital();
                claseEnvio.cuenta = afiliacion.Numero_Cuenta__c;
                claseEnvio.cambioEstado = true;
                claseEnvio.capitalSemilla = afiliacion.Aplica_CS__c =='S' ? true : false;
                //string idS =afiliacion.Id;
                claseEnvio.codigoReferencia = afiliacion.Numero_de_Cliente__c+'SF'+afiliacion.Numero_Cuenta__c;
                //claseEnvio.formaPago ='';
                claseEnvio.moneda = afiliacion.CurrencyIsoCode =='HNL' ? '1' : '2';
                Monto_Capital_Semilla__mdt monto = [select monto_pago__C from Monto_Capital_Semilla__mdt where DeveloperName =:afiliacion.CurrencyIsoCode];
                claseEnvio.monto = string.valueOf(monto.monto_pago__C);
                claseEnvio.nombre = afiliacion.Name +' '+afiliacion.Primer_Apellido__c;
                date fecha = date.today();
                claseEnvio.ctaDestino = dato.Cuenta_Destino__c;
                claseEnvio.ctaOrigen = dato.Cuenta_Origen__c;
                claseEnvio.periodoAporte = ''+fecha.year()+(fecha.month() < 10 ? '0'+fecha.month() : ''+fecha.month()) + (fecha.day() < 10 ? '0'+fecha.day() : ''+fecha.day());  
                if(afiliacion.Tipo_Afiliacion__c =='YC' ){
                    String v = aSysdeReporteCalidad.CambioEstado(claseEnvio);
                    if(!v.contains('Proceso capital semilla procesado correctamente') && claseEnvio.capitalSemilla){
                        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, v));
                        return;
                    }
                }
                if(afiliacion.Reporte_Calidad__c == 'C'){
                    afiliacion.Enviar_Afiliacion__C = false;
                }
                update afiliacion;
                reinicar();
            }else{
                cambioCampos = true;
            }
            
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+ ', Linea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Ha ocurrido un error, por favor contacte su admin.'));
        }
    }
    
    
    public void SelectSubProducto(){
        producto =new producto__C();//null;
        if(afiliacion.Subproducto__c !=null){
            for(subProducto__C item:[select producto__r.name from subProducto__C where id =:afiliacion.Subproducto__c]){
                producto =new producto__C(name= item.producto__r.name);
            }
        }
    }

}