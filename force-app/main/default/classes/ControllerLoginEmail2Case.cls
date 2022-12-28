public class ControllerLoginEmail2Case {

    public String Contrasena { get; set; }
    public String usuario { get; set; }
    public boolean ActivarModal { get; set; }
    public string Cambiousuario {get; set;}
    public Usuarios_de_Pantallas__c Cambiopass {get; set;}
    public string pagina{get;set;}
    public static string UsuarioJuridico {get;set;}
    public static string UsuarioNatural {get;set;}
    public boolean mostrarlogin { get; set; }
    public boolean Mostrarhome { get; set; }
    public static string SMS{get;set;}
    public static string ClienteN {get;set;}
    public String usuarioPrueba{ get; set; }
    public static string EnvioUser {get;set;}
    public integer anio{ get; set; }
    public list<controllerApiClienteNatural.classRespuestaMenu> resultado2 {get;set;}
     public list<controllerApiClienteNatural.classRespuestaAportesCuenta> resultado {get;set;}
    Public list<string> Numcuentas {get; set;}
    public string CuentaPrueba {get; set;}
    public list<Pantalla_Aportes__c> McontenidoAporte{get;set;}
    
    //13/05/2020
    public string casoCliente {get;set;}
    public string emailCliente {get;set;}
    public string idCliente {get;set;}
    public string recordType {get;set;}
    //13/05/2020
         
    public ControllerLoginEmail2Case (){        
        Mostrarlogin = true;
        pagina= null;
        casoCliente =  ApexPages.currentPage().getParameters().get('caso');
        emailCliente =  ApexPages.currentPage().getParameters().get('email');  
        recordType = ApexPages.currentPage().getParameters().get('recordType');      
    } 
    
    public pageReference login() { 
        System.debug('casoCliente: '+casoCliente); System.debug('emailCliente: '+emailCliente); System.debug('idCliente: '+idCliente);
        List<RecordType> rt = [Select Id, Name, DeveloperName From RecordType Where DeveloperName =: recordType]; System.debug(rt[0].Name);
        List<Case> caso = [Select id,CaseNumber,RecordTypeId,RecordType.Name,Correo_Electronico__c,Type,Subject From Case Where CaseNumber =: casoCliente]; //System.debug(caso[0].RecordType.Name);        
        List<Account> cuenta = [Select Id,Name,Identificacion__c,PersonEmail From Account where Identificacion__c =: idCliente /*and PersonEmail =: emailCliente*/]; //System.debug(cuenta);
        if(!cuenta.isEmpty() && cuenta[0].PersonEmail == emailCliente) {
            PageReference vfPage1 = new PageReference('/apex/vfCasosPortalAutogestionE2C?idCliente='+idCliente);
            vfPage1.setRedirect(true);
            return vfPage1;
        } else if(!cuenta.isEmpty() && cuenta[0].PersonEmail != emailCliente) {
            caso[0].Correo_Electronico__c = emailCliente;
            caso[0].RecordTypeId = rt[0].Id;
            caso[0].Type = 'Solicitud';
            caso[0].Subject = rt[0].Name;
            update caso;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Se creó un caso de actualización de correo electrónico.'));
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Lo sentimos, no existe cuenta en nuestro portal con el correo electrónico e identificación digitada.'));
        }
        return null;
    }
     
    public void crearUsuarioNat(){
        Desactivartab();
        pagina = 'VFPantallaConciliacion_Aportes?hytrd='+usuario;
        UsuarioNatural = 'slds-is-active';     
    }
    
    public void ListaVF(){
        Desactivartab();
        pagina = 'VFPantallaConciliacion_Aportes?hytrd='+usuario;
     }
    
    public static void Desactivartab(){
        UsuarioJuridico='';
        UsuarioNatural='';
        ClienteN = '';
    }
    
    public void cerrar(){
        mostrarlogin=true;
        mostrarhome=false;
        pagina= null;
    }
    
    public void ClienteNatural()
    {
        Desactivartab();
        usuario =  ApexPages.currentPage().getParameters().get('usuario');
        pagina = 'VFPantallaClienteProducto?hytrd='+usuario;
        ClienteN = 'slds-is-active';     
    }
    
    Public void cambiarclave(){
        try{
            
            Usuarios_de_Pantallas__c user = [Select Email__c,name,id 
                                             From Usuarios_de_Pantallas__c 
                                             Where Usuario__c=:Cambiousuario];
            string contra = '';
            integer o;
            List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
            for(integer i=0; i<15; i++){
                o=Math.round(Math.random() * 15);
                if(o==0){contra+='w';}
                if(o==4){contra+='A';}
                if(o==11){contra+='d';}
                if(o==12){contra+='H';}
                if(o==8){contra+='m';}
                if(o==2){contra+='B';}
                if(o==10){contra+='L';}
                if(o==1 || o==3 || o==5 || o==6 || o==7 || 0==9 ||o==13 || o==14 || 0==15){contra+=string.valueOf(o);}
            }
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            mail.setToAddresses(new String[] {User.Email__c});
            system.debug('Correo: '+User.Email__c);
            mail.setSenderDisplayName('FICOHSA PENSIONES Y CESANTIAS');
            mail.setSubject('Pantallas Afiliados');
            mail.setPlainTextBody('Estimad@ ' + User.Name +'.\n\n Hemos recibido una solicitud para el cambio de tu contraseña del Pantallas de Afiliados. \n' +
                                  +'\n Puedes ingresar al siguiente link para cambiar tu contraseña. link: https://fpc.secure.force.com/UsuariosFPC/vfCambioPasswordPantallasAfi \n'+
                                  'favor escríbenos a ficohsapensiones@ficohsa.com.\n\nFicohsa Pensiones y Cesantías\n www.ficohsa.com. \n2275-2424');
            MessageList.add(mail);  
            system.debug(mail);
            Messaging.sendEmail(MessageList); 
            user.Contrase_a__c=contra;
            update user;               
            
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'¡Se ha enviado un correo electrónico al usuario!'));
            
        }catch(exception ex){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'¡Usuario no encontrado!'+ ex.getMessage()));        
        }
    }
    
    
    
    
    public pageReference sesionIniciada(){
        try{
            Usuarios_de_Pantallas__c usuario = [Select Contrase_a__c, Usuarios_de_Pantallas__c.Name, Activo__c
                            From Usuarios_de_Pantallas__c
                            Where Usuario__c =: usuario Limit 1];
                
                if(usuario.Contrase_a__c == Contrasena){
                    if(usuario.Activo__c){
                       
                        
                        mostrarlogin=false;
                                        mostrarhome=true;
                        llenarCuentasDesdeSysde();
                        llenarPantallasDesdeSysde();
                        bitaco();
                           
                    }else{
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Usuario no activo.'));    
                    }
                }else{
                   ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Usuario o Contraseña no válidos.')); 
                }
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Usuario o Contraseña no válidos.'));   
        }
        return null;
    }
    
    //Traer Lista
    
    Public void llenarCuentasDesdeSysde(){
        try{
            McontenidoAporte =[ select cuenta__c,Nombre_Completo__c,Tipo_Moneda__c,Fecha_Deposito__c,Monto_Deposito__c,TIPO_SALDO__c ,
                               Forma_de_Pago__c,Codigo_Referencia__c,Aplica_Comision_SI__c, Descripcion__c,
                               No_Aplica_Comision__c,Comprobante_imagen__c, Numero_Correlativo__c, Estado_Aporte__c
                               from Pantalla_Aportes__c order where Estado_Aporte__c = ''];
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error desde SYSDE ' + e.getMessage() ));       
        }
    }
    
    public void bitaco(){
        Bitacora_Conciliacion__c bita1 = new Bitacora_Conciliacion__c ();
        bita1.Actividades__c = 'Inició Sesión en el Sistema';
        bita1.Fecha__c = datetime.now();
        bita1.Pantalla__c = 'VfLoginPantallas';
        bita1.Evento__c = 'Consulta';
        bita1.Usuario__c = string.valueOf(usuario);
        insert bita1;
    }
    
    //Metodos Nuevos Agregados Luis 01/12/2019
    public void ACI(){
        Desactivartab();
        pagina = 'vfafiliacionclienteindividual?usuario='+usuario;
    }
    public void ACC(){
        Desactivartab();
        pagina = 'vfafiliacionescarga?usuario='+usuario;
    }
    public void ACYC(){
        Desactivartab();
        pagina = 'vfafiliacionclientescargados?usuario='+usuario;
    }
    public void AME(){
        Desactivartab();
        pagina = 'vfafiliacionmasivaEmpresa?usuario='+usuario;
    }
    public void EKC(){
        Desactivartab();
        pagina = 'vfentregakitCom?usuario='+usuario;
    }
    public void RSC(){
        Desactivartab();
        pagina = 'vfreporteseguimento?usuario='+usuario;
    }
    
    
    public void RCI(){
        Desactivartab();
        pagina = 'vfreporteCalidadIndividuales?usuario='+usuario;
    }
    
    public void RCC(){
        Desactivartab();
        pagina = 'vfreportecalidad_C_NC_PL?usuario='+usuario+'&idPantalla=C';
    }
    
    public void RCNC(){
        Desactivartab();
        pagina = 'vfreportecalidad_C_NC_PL?usuario='+usuario+'&idPantalla=N';
    }
    
    public void RCP(){
        Desactivartab();
        pagina = 'vfreportecalidad_C_NC_PL?usuario='+usuario+'&idPantalla=P';
    }
    
    public void RCBFH(){
        Desactivartab();
        pagina = 'vfreporteCalidad_bfh_pm_fic?usuario='+usuario+'&idPantalla=BFK';
    }
    
    public void RCPM(){
        Desactivartab();
        pagina = 'vfreporteCalidad_bfh_pm_fic?usuario='+usuario+'&idPantalla=PM';
    }
   
    
     public void EKS(){
        Desactivartab();
        pagina = 'vfentregakitSac?usuario='+usuario;
    }
    
    public void RSS(){
        Desactivartab();
        pagina ='vfreporteseguienteSac?usuario='+usuario;
    }
    
     public void AFC(){
        Desactivartab();
        pagina ='vfafiliacionficopen?usuario='+usuario;
    }
    
    public void ABFK(){
        Desactivartab();
            pagina ='vfafiliacionBFH?usuario='+usuario+'&pantalla=BFK';
    }
    
    public void APM(){
        Desactivartab();
        pagina ='vfafiliacionBFH?usuario='+usuario+'&pantalla=PM';
    }
    public void OxA(){
        Desactivartab();
        pagina ='vfoficialxAsesor?usuario='+usuario; 
    }
    public void OxE(){
        Desactivartab();
        pagina ='vfoficialesXEmpresa?usuario='+usuario;
    }
    
    
    // FIN METODOS NUEVOS
    
    public  void Mostra() {
        resultado2 = new list<controllerApiClienteNatural.classRespuestaMenu>();                    
        resultado2 =  controllerApiClienteNatural.ConsultaPantallas2(usuario);
        
        for(integer j=0; j<resultado2.size(); j++){
            if (resultado2[j].nombreMetodo == ClienteN){
                pagina = resultado2[j].nombreMetodo + '?hytrd=' + usuario;
                Desactivartab(); 
                Bitacora_Conciliacion__c bita = new Bitacora_Conciliacion__c ();
                bita.Actividades__c = 'Se ingreso a la pantalla' +':'+ resultado2[j].nombreMetodo ;
                bita.Fecha__c = date.today();
                bita.Pantalla__c = resultado2[j].nombreMetodo;
                bita.Evento__c = 'Consulta';
                bita.Usuario__c = Usuario;
                //database.insert(bita, false); 
            }    
            
            
        }
        
    }
    
    
    //Metodo que trae las pantallas 
    
    
    //Public list<string> Numcuentas {get; set;}
    
    Public void llenarPantallasDesdeSysde() {
        try{
            
            resultado2 = new list<controllerApiClienteNatural.classRespuestaMenu>();                    
            resultado2 =  controllerApiClienteNatural.ConsultaPantallas2(usuario);  
            
            system.debug('Resultado2'+ resultado2  );
            
            if(resultado2.size()>0){
                Numcuentas= new list<string>();
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Usuario Correctooo.')); 
            }else{ 
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Datos menor que 0.')); 
            }
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error desde SYSDE ' + e.getMessage() ));       
        }
    }
    
    
}