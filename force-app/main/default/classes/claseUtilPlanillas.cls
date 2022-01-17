public without sharing class claseUtilPlanillas {
    
    public static String urlSysde(String ambiente){
        try{
            return [Select URL__c From URL_conexion_Sysde__mdt Where DeveloperName =: ambiente].URL__c;
            
        }Catch(Exception e){
            return null;
        }
    }
    
    
    
    
    public static void CompreDeDollar (string idplanilla) {
        try{
            List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
            planilla__C planilla=new planilla__C();
            planilla=[select Estado2__c,name, CurrencyIsoCode,fecha__C, Total__c, Tasa_compra__c, Empresa2__r.name from planilla__C where id=:idplanilla];
            string nombreEmpresa =planilla.Empresa2__r.name;
            list<correos__c> correos = new list<Correos__C>();
            correos =[select correo__c,name from correos__C where cargo__c='Compra de Dolar'];
            String queryCorreo = 'Select Cuerpo__c From Correo_EDC__mdt Where DeveloperName = \'correoGeneral\'';
            Correo_EDC__mdt cuerpoCorreo = dataBase.query(queryCorreo);
            String cuerpo = cuerpoCorreo.Cuerpo__c;
            String urlPortal = claseUtil.urlSysde('Empresarial');
            String moneda = planilla.CurrencyIsoCode == 'HNL' ? 'L.' : '$.';
            String accion = planilla.CurrencyIsoCode == 'HNL' ? 'compren' : 'vendan';
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
            for(integer i=0; i<correos.size(); i++){ 
                cuerpo = cuerpoCorreo.Cuerpo__c;
                String asunto = 'La empresa ' +nombreEmpresa +
                    ', ha registrado la planilla '+planilla.name+' y requiere que se '+accion +' los dolares con un valor de '+moneda+planilla.Total__c+' <br/><br/> Muchas Gracias.';	
                cuerpo = cuerpo.replace('[getAsunto]', asunto);
                cuerpo = cuerpo.replace('[getName]', correos[i].Name);
                
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {correos[i].Correo__C});
                mail.setSubject((planilla.CurrencyIsoCode == 'USD' ? 'Venta' : 'Compra')+' de Dólar Portal Empresarial Ficohsa');
                mail.setHtmlBody(cuerpo);
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
                MessageList.add(mail); 
            }
            Messaging.sendEmail(MessageList);
            
        }catch(Exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
        
    }    
    
    public static void correoEnvioPlanilla(Usuario_X_Empresa__c idPlanilla){
    }
    
    public static void ColavoradoresVigentes(string codigo_Unico_Banco, string usuario) {
        try{
            list<string> Cuentas = new list<string>();
            list<string> Cuentas1 = new list<string>();
            list<string> Cuentas2 = new list<string>();
            for(Cuentas_Colectivas__c item:[select codigo__C, tipo_cuenta__C from Cuentas_Colectivas__c where empresa__C=:Codigo_Unico_Banco ]) {
                if(item.tipo_cuenta__C=='Voluntarias'){
                    cuentas.add(item.codigo__C); 
                }
                if(item.tipo_cuenta__C=='Censatías'){
                    cuentas1.add(item.codigo__C); 
                }
                if(item.tipo_cuenta__C=='Pilar Complementario'){
                    cuentas2.add(item.codigo__C);  
                }
                
            }
            list<String> identidadesbuenas = new list<String>();
            list<String> todaside = new list<String>();
            list<String> identidadesbuenasCS = new list<String>();
            map<String, Integer> identidadespl=new map<String, Integer>();
            map<String, Integer> identidadescd=new map<String, Integer>();
            for(cuentas__C item: [select cliente__C from cuentas__C where cuenta_colectiva2__r.codigo__C in:(cuentas)]){
                identidadesbuenas.add(item.cliente__C); 
            }
            for(cuentas__C item: [select cliente__C from cuentas__C where cuenta_colectiva2__r.codigo__C in:(cuentas2)]){
                if(!identidadespl.containsKey(item.cliente__C)){
                    identidadespl.put(item.cliente__C,9);
                }
                todaside.add(item.cliente__C); 
            }
            for(cuentas__C item: [select cliente__C from cuentas__C where cuenta_colectiva2__r.codigo__C in:(cuentas1)]) {
                if(!identidadescd.containsKey(item.cliente__C)) {
                    identidadescd.put(item.cliente__C,9);
                }
                todaside.add(item.cliente__C); 
            }
            for(integer i=0; i<todaside.size(); i++){
                if(identidadescd.containsKey(todaside[i]) && identidadespl.containsKey(todaside[i])){
                    identidadesbuenas.add(todaside[i]);  
                }
            }
            todaside.clear();
            identidadescd.clear();
            identidadespl.clear();
            List<claseColaboradores> listClientes2 = new List<claseColaboradores>();
            Map<string, integer> frv= new map<String, Integer>();
            integer controla=0;
            for( Account item :[select Estado_Civil__pc ,salario__c, PersonBirthdate ,tipo_Identificacion__C,
                                Identificacion__C ,firstname, lastname,id
                                from Account where id  in :identidadesbuenas and 
                                id not in (select empleado2__c from empresa_x_Empleado__C where empresa2__C=:codigo_unico_banco ) 
                                order by firstname asc ])
            {
                
                if(!frv.containsKey(item.id))
                {
                    controla++;
                    listClientes2.add(new claseColaboradores(string.valueOf(controla), item.tipo_identificacion__c, item.identificacion__C,
                                                             item.firstname, item.lastname, item.PersonBirthdate, 
                                                             item.estado_civil__pc, item.salario__C, item.id));
                    
                    frv.put(item.id, 3);
                    // identidadesregistradas.add(item.cliente__C);
                    
                    
                }
            }
            identidadesbuenas.clear(); 
            list<empresa_x_empleado__C> empleadosEmpresa= new list<empresa_x_empleado__C>();
            empresa_x_empleado__C empleado;
            for(integer i=0; i<listclientes2.size(); i++)
            {
                empleado = new empresa_x_empleado__C();
                empleado.Empleado2__c = listclientes2[i].idcliente;
                empleado.Empresa2__c=codigo_unico_banco;
                empleado.Estado__c='Activo';
                empleado.salario__c=0;
                empleado.Ultima_modificacion__c=usuario;
                empleado.Activo_Nueva_Planilla__c= true;
                empleadosEmpresa.add(empleado); 
            }
            insert  empleadosEmpresa;
            
        }catch(Exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
    }
    
    
    
    
    public static void correoEnvioPlanilla2(string idPlanilla){
        try{
            planilla__C planilla =new planilla__C();
            planilla=[select empresa2__C, name, empresa2__r.name from planilla__C where id =:idplanilla];
            list<Usuario_X_Empresa__c> enviarcorreos = new list<Usuario_X_Empresa__c>();
            enviarcorreos = [select usuario__r.nombre_completo__C, usuario__r.email__C from Usuario_X_Empresa__c
                             where empresa2__C=:planilla.empresa2__C and Aceptar_Planilla__c=true];
            
            String queryCorreo = 'Select Cuerpo__c From Correo_EDC__mdt Where DeveloperName = \'correoGeneral\'';
            Correo_EDC__mdt cuerpoCorreo = dataBase.query(queryCorreo);
            String cuerpo = cuerpoCorreo.Cuerpo__c;
            String urlPortal = claseUtil.urlSysde('Empresarial');
            String asunto = 'Se le ha enviado la planilla '+planilla.name+' ('+planilla.Empresa2__r.name+') para su aprobación. <br/> Favor ingresar al portal '
                + ' para continuar con el debido proceso: ' + urlPortal;	
            cuerpo = cuerpo.replace('[getAsunto]', asunto);
            //cuerpo = cuerpo.replace('[getName]', '');
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
            
            
            List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail; 
            for(integer i=0; i<enviarcorreos.size(); i++)
            {
                mail = new Messaging.SingleEmailMessage();
                if(i==0)
                {
                    cuerpo = cuerpo.replace('[getName]', enviarcorreos[i].usuario__r.nombre_completo__C);  
                }
                else
                {
                    cuerpo = cuerpo.replace(enviarcorreos[i-1].usuario__r.nombre_completo__C, enviarcorreos[i].usuario__r.nombre_completo__C);
                }
                
                mail.setToAddresses(new String[] {enviarcorreos[i].usuario__r.email__C});
                mail.setSubject('Planilla para aprobación Portal Empresarial Ficohsa');
                mail.setHtmlBody(cuerpo);
                mail.setOrgWideEmailAddressId(owea.get(0).Id);
                MessageList.add(mail);  
            }
            
            
            Messaging.sendEmail(MessageList);
            
            system.debug('Correo enviado satisfactoriamente');
        }Catch(Exception e){
            system.debug('Error al enviar correo: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
        }
    }
    
    public static boolean validarContrasena(String contrasena){
        
        //Verificar que la contraseña tiene al menos un dígito, una mayúscula una minúscula y un carácter especial
        if(contrasena.length() >= 8){
            Integer num = contrasena.length();        
            if(!pattern.matches('((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{'+ num +'})', contrasena) || !pattern.matches('((?=.*[@#$%])(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{' + num + '})', contrasena)
               || !pattern.matches('((?=.*\\d)(?=.*[a-z])(?=.*[@#$%])(?=.*[A-Z]).{' + num + '})', contrasena) ){
                   ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR,                         
                                                              'La contraseña debe tener al menos una letra mayúscula, una letra minúscula, un número y cualquiera de los simbolos [@#$%].')); 
                   return false;
               }
        }else{
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                                                       'La contraseña debe de tener al menos 8 caracteres'));       
            return false;             
        }            
        return true;
    }
    
    public static void metodoutil(){
    }
}