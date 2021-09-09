public without sharing class controladorAceptarPlanilla {
    String Codigo_Unico_Banco;
    String Usuario;
    public Planilla__c planilla{get;set;}
    public list<Contenido_Planilla__c> contenidoPlanilla{get;set;}
    public list<Contenido_Planilla__c> McontenidoPlanilla{get;set;}
    public Contenido_Planilla__c contenidoTotal{get;set;}
    public Usuario_X_Empresa__c usuarioEmpresa{get;set;}
    public list<SelectOption> opcionesPlanillas{get;set;}
    public string mensaje{get;set;}
    public string moneda{get;set;}
    public string idPlanilla{get;set;}
    map<Id, Planilla__c> mapPlanillas;
    public string  url_pagina{get;set;}
    public boolean pop_exportar{get;set;}
    public boolean popDenegar{get;set;}
    public boolean mostrarBotones{get;set;}
    public integer totalempleados{get;set;}
    public date FechaP {get;set;}
    //Paginaciones
    public boolean mostrarSiguiente{get;set;}
    public boolean mostrarANterior{get;set;}
    public boolean mostrarBotonesP{get;set;}
    integer contadorpaginacion;
    
    
    
    
    public controladorAceptarPlanilla(){
        try{
            Codigo_Unico_Banco = ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
            Usuario = ApexPages.currentPage().getParameters().get('loetdncdhjch'); 
            usuarioEmpresa = [select Empresa2__r.Name, Empresa2__r.IsPersonAccount,
                              Empresa2__r.PAPCE__c, Empresa2__r.PAPCT__c,
                              Empresa2__r.Salario_Base_Pilar_Complementario__c,
                              Empresa2__r.Porcentaje_de_aportaciones_Reserva_Labor__c, 
                              Empresa2__r.Salario_Base_Reserva_Laboral__c,
                              Usuario__r.email__c, Usuario__r.Nombre_completo__c
                              from Usuario_X_Empresa__c 
                              where Empresa2__c =: Codigo_Unico_Banco
                              AND Usuario__c =: Usuario Limit 1];
            claseUtil.stopTrigger();
            reIniciar();
        }Catch(Exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Se ha producido un error, favor contacte a su administrador')); 	
        }	
        
    } 
    
    
    public void reIniciar(){
        try{
            opcionesPlanillas = new list<SelectOption>();
            idPlanilla = '';
            mapPlanillas = new map<Id, Planilla__c>();	    		 
            mostrarBotones = true;
            list<Planilla__c> listPlanillas = [Select Name, tasa_compra__C, createdDate, Ta_salarios__C ,currencyIsoCode, Fecha__c, lastModifiedDate, Estado2__c,
                                               Comentarios__c,Total_voluntarios__c,Total_obligatorios__c,Total__c,
                                               TA_Empleado_Obligatorio__c,TA_Empleado_Voluntario__c,Cantidad_empleados__c,
                                               TA_Patrono_obligatorio__c,TA_Patrono_Voluntario__c,
                                               //agregado wp 06-11-2019
                                               TA_Empleado_Extraordinario__c, TA_Patrono_Extraordinario__c, TA_Seguro_de_Vida__c,
                                               //
                                               Total_Reserva_Laboral2__c, mes_aporte__C, creado_por__C
                                               From Planilla__c 
                                               Where Empresa2__c =: Codigo_Unico_Banco 
                                               AND Estado2__c = 'Pendiente Aprobación Interna'
                                               Order by createdDate asc Limit 52];
            
            planilla = new Planilla__c();
            contenidoPlanilla = new list<Contenido_Planilla__c>();
            
            if(!listPlanillas.isEmpty()){
                For(Planilla__c item : listPlanillas){
                    opcionesPlanillas.add(new selectOption(item.id, item.Name));	
                    mapPlanillas.put(item.id, item);
                }
                idPlanilla = listPlanillas[0].id;
                planilla = listPlanillas[0];
                fechap = planilla.Fecha__c;
                moneda = Planilla.CurrencyIsoCode;
                mensaje = null;
                if(Planilla.tasa_compra__C==0){
                    moneda=planilla.CurrencyIsoCode;// 'HNL';
                    mensaje = moneda =='USD'? ' (Compra de Dólar)': ' (Venta de Dólar)';
                }
                traerContenido();
            }else{
                mostrarBotones = false;
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, ' No hay planillas pendientes por aprobar!')); 
            }
            
            //Paginaciones
            mostrarBotonesp=false;
            mostrarAnterior=true;
            mostrarSiguiente=true;
            Mcontenidoplanilla = new list<contenido_Planilla__C>();
            contadorpaginacion=0;
            if(contenidoplanilla.size()>100){
                contadorpaginacion ++;
                mostrarBotonesp=true;
                mostrarSiguiente=false;
                for(integer i=0; i<100; i++){
                    Mcontenidoplanilla.add(contenidoplanilla[i]);
                }
            }else{
                for(integer i=0; i<contenidoplanilla.size(); i++){
                    Mcontenidoplanilla.add(contenidoplanilla[i]);
                } 
            }		
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!')); 		
        }
    } 
    public pageReference exportarE(){
        claseUtilPlanillas.updateTime(usuario);
        if(contenidoplanilla.size()>1000){
            url_pagina='vfexportarexcelplanilla2?id_pla='+planilla.id;
            pop_exportar=true;
            return null;
        }
        return New PageReference ('/Apex/vfexportarExcelAcpetarP');
    }
    public void traerContenido(){
        try{
            Planilla = mapPlanillas.get(idPlanilla);
            moneda=Planilla.CurrencyIsoCode;
            mensaje=null;
            if(Planilla.tasa_compra__C==0){
                moneda='HNL';
                mensaje=' (Compra de Dólar)';
                
            }
            contenidoPlanilla = [Select Empleado2__c, Empleado2__r.Identificacion__c,
                                 Empleado2__r.Firstname, Empleado2__r.LastName, Salario__c,Aporte_Empleado_Obligatorio__c,
                                 Aporte_Empleado_Voluntario__c, Aporte_Patrono_obligatorio__c,Aporte_Patrono_Voluntario__c,
                                 /*agregado wp 06-11-2019*/ Aporte_Empleado_Extraordinario__c, Aporte_Patrono_Extraordinario__c, Aporte_Seguro_de_Vida__c, 
                                 Planilla__c, Reserva_Laboral__c
                                 From Contenido_Planilla__c Where Planilla__c =: Planilla.id
                                 Order by Empleado2__r.Firstname asc];
            totalempleados=contenidoPlanilla.size();
            contenidoTotal = new Contenido_Planilla__c(Aporte_Patrono_obligatorio__c = planilla.TA_Patrono_obligatorio__c,
                                                       Aporte_Empleado_Obligatorio__c = planilla.TA_Empleado_Obligatorio__c,
                                                       Reserva_Laboral__c = planilla.Total_Reserva_Laboral2__c,
                                                       Aporte_Patrono_Voluntario__c = planilla.TA_Patrono_Voluntario__c,
                                                       Aporte_Empleado_Voluntario__c = planilla.TA_Empleado_Voluntario__c,
                                                       //agregado wp 06-11-2019                       
                                                       Aporte_Empleado_Extraordinario__c = planilla.TA_Empleado_Extraordinario__c,
                                                       Aporte_Patrono_Extraordinario__c = planilla.TA_Patrono_Extraordinario__c,
                                                       Aporte_Seguro_de_Vida__c = planilla.TA_Seguro_de_Vida__c,
                                                       //
                                                       Salario__C =planilla.TA_Salarios__c);
            //Paginaciones
            mostrarBotonesp=false;
            mostrarAnterior=true;
            mostrarSiguiente=true;
            Mcontenidoplanilla = new list<contenido_Planilla__C>();
            contadorpaginacion=0;
            if(contenidoplanilla.size()>100){
                contadorpaginacion ++;
                mostrarBotonesp=true;
                mostrarSiguiente=false;
                for(integer i=0; i<100; i++){
                    Mcontenidoplanilla.add(contenidoplanilla[i]);
                }
            }else{
                for(integer i=0; i<contenidoplanilla.size(); i++) {
                    Mcontenidoplanilla.add(contenidoplanilla[i]);
                } 
            }	
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!')); 		
        }
    }
    
    
    public void siguiente() {
        try{
            claseUtilPlanillas.updateTime(usuario);
            if((contadorpaginacion + 1)*100 > contenidoPlanilla.size()){
                contadorpaginacion ++;
                McontenidoPlanilla = new list<contenido_planilla__C>();
                mostrarSiguiente=true;
                mostraranterior=false;
                for(integer i=(contadorpaginacion - 1)*100; i<contenidoPlanilla.size(); i++){
                    McontenidoPlanilla.add(contenidoPlanilla[i]);
                } 
            }else{
                mostraranterior=false;
                
                contadorpaginacion ++;
                McontenidoPlanilla = new list<contenido_planilla__C>();
                for(integer i=(contadorpaginacion - 1)*100; i<contadorpaginacion*100; i++){
                    McontenidoPlanilla.add(contenidoPlanilla[i]);
                } 
            }
            
        }catch(exception ex){
            
        }
    }
    
    public void anterior(){
        try {
            claseUtilPlanillas.updateTime(usuario);
            McontenidoPlanilla = new list<contenido_planilla__C>();
            if((contadorpaginacion - 1)*100 < 101){
                mostrarsiguiente=false;
                mostrarAnterior=true;
                McontenidoPlanilla = new list<contenido_planilla__C>();
                for(integer i=0; i<100; i++){
                    McontenidoPlanilla.add(contenidoPlanilla[i]);
                } 
                contadorpaginacion --;
            }else{
                McontenidoPlanilla = new list<contenido_planilla__C>();
                for(integer i=(contadorpaginacion - 2)*100; i<(contadorpaginacion-1) *100; i++){
                    McontenidoPlanilla.add(contenidoPlanilla[i]);
                }  
                contadorpaginacion --;
                mostrarSiguiente=false;
            }
        }catch(Exception ex){
            
        }
    }
    
    public void cerrar(){
        claseUtilPlanillas.updateTime(usuario);
        popDenegar = false;	
        pop_exportar=false;
    }
    
    public void aceptar(){
        try{
            claseUtilPlanillas.updateTime(usuario);
            Planilla.Estado2__c = 'Pendiente Aprobación Ficohsa';
            update Planilla;
            if(planilla.Tasa_compra__c==0)
            {
                claseUtilPlanillas.CompreDeDollar(planilla.id);
            }           
            //string nombrePlanilla=planilla.name;
            contenidoTotal = new contenido_Planilla__C();
            String queryCorreo = 'Select Cuerpo__c From Correo_EDC__mdt Where DeveloperName = \'correoGeneral\'';
            Correo_EDC__mdt cuerpoCorreo = dataBase.query(queryCorreo);
            String cuerpo = cuerpoCorreo.Cuerpo__c;
            cuerpo = cuerpo.replace('[getAsunto]','Te enviamos el recibo de la planilla '+planilla.Name+' que acabas de aprobar en tu Sucursal Electronica de Ficohsa Pensiones y Censatías.<br/><br/> Para observar el detalle de tu recibo descarga el archivo adjunto.');
            cuerpo = cuerpo.replace('[getName]', usuarioEmpresa.Usuario__r.Nombre_completo__c);
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];  
            
            PageReference pdf = Page.vfRecibo; 
            pdf.setRedirect(False);
            pdf.getParameters().put('id_Planilla',Planilla.id);
            
            List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new string[] {usuarioEmpresa.Usuario__r.email__c});
            mail.setSubject('Portal Empresarial Ficohsa');
            mail.setHtmlBody(cuerpo);
            mail.setOrgWideEmailAddressId(owea.get(0).Id);
            
            Blob b; 
            if(!test.isRunningTest())
                b = pdf.getContent();
            else
                b = blob.valueOF('Test');	
            
            
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            efa.setContentType('application/pdf');
            efa.setInline(False);
            efa.setFileName('attachment.pdf');
            efa.setBody(b);
            mail.setFileAttachments(new Messaging.EmailFileAttachment[] {efa});
            MessageList.add(mail);    
            
            Messaging.sendEmail(MessageList);
            integer u= [Select count() From Planilla__c Where Empresa2__c =: Codigo_Unico_Banco 
                        AND Estado2__c = 'Pendiente Aprobación Interna'];
            if(u>0)
            {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, '¡La Planilla '+planilla.Name+' ha sido aprobada, Tiene Planilla(s) pendientes por aprobar!'));  
            }
            else
            {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, '¡La Planilla '+planilla.Name+' ha sido aprobada'));
            }
            //ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, '¡La Planilla '+planilla.Name+' ha sido aprobada!')); 	
            system.debug('Correo enviado satisfactoriamente');
            reIniciar();	
        }Catch(Exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!')); 			
        }
    }  
    
    public void mostrarDenegar(){
        claseUtilPlanillas.updateTime(usuario);
        popDenegar = true;	
    }
    
    public void denegar(){
        try{
            claseUtilPlanillas.updateTime(usuario);
            if(Planilla.tasa_compra__c==0){
                Planilla.Estado2__c = 'Cancelado';
                planilla.CurrencyIsoCode='USD';
            }else{
                Planilla.Estado2__c = 'Nueva';  
            }
            update Planilla;
            popDenegar = false;
            
            string nombreempresa= [select empresa2__r.name from planilla__C where id=:planilla.id].empresa2__r.name;
            List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
            contenidoTotal = new contenido_planilla__C();
            usuario_portal_empresarial__C user= [select email__C,name from usuario_portal_empresarial__C where id=:planilla.Creado_por__c];
            String queryCorreo = 'Select Cuerpo__c From Correo_EDC__mdt Where DeveloperName = \'correoGeneral\'';
            Correo_EDC__mdt cuerpoCorreo = dataBase.query(queryCorreo);
            String cuerpo = cuerpoCorreo.Cuerpo__c;
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
            cuerpo = cuerpoCorreo.Cuerpo__c;
            string asunto = 'La planilla '+planilla.name+' ('+nombreempresa+') que creaste en el Portal Empresarial Ficohsa ha sido deneganda por el aprobador';
            cuerpo = cuerpo.replace('[getAsunto]', asunto);
            cuerpo = cuerpo.replace('[getName]', User.Name);
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(new String[] {user.email__C});
            mail.setSubject('Denegación de planilla Portal Empresarial Ficohsa.');
            mail.setHtmlBody(cuerpo);
            mail.setOrgWideEmailAddressId(owea.get(0).Id);
            MessageList.add(mail); 
            Messaging.sendEmail(MessageList);
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, '¡La Planilla '+planilla.Name+' ha sido denegada!'));
            reIniciar();	
        }Catch(Exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!')); 			
        }
        
    }
    
    public void metodoutil(){
       
    }
}