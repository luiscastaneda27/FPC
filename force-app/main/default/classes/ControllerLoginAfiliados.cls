public class ControllerLoginAfiliados {
    
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
    
    public ControllerLoginAfiliados (){
        //usuario = '';
        //contrasena = '';
        salir();
        Desactivartab();
        mostrarlogin=true;
        mostrarhome=false;
        anio = date.today().year();
        
    } 
    
    //activar modal
    public void olvide()
    {
        ActivarModal=true;        
    }
    public void salir()
    {
        ActivarModal=false;
    }
    
    public void EnvioSaldo()
    {
        Desactivartab();
        pagina = 'vfEnvioEstadosCuenta?hytrd='+usuario;
        SMS = 'slds-is-active';     
    }
    public void UsuarioJuridico()
    {
        Desactivartab();
        pagina = 'VFPantallaJuridicos';
        UsuarioJuridico = 'slds-is-active';         
    }
    
    public void crearUsuarioNat()
    {
        Desactivartab();
        pagina = 'VFPantallaConciliacion_Aportes?hytrd='+usuario;
        UsuarioNatural = 'slds-is-active';     
    }
    
    public void ListaVF()
    {
        Desactivartab();
        pagina = 'VFPantallaConciliacion_Aportes?hytrd='+usuario;
        
    }
    
    public static void Desactivartab()
    {
        
        UsuarioJuridico='';
        UsuarioNatural='';
        ClienteN = '';
    }
    public void cerrar(){
        mostrarlogin=true;
        mostrarhome=false;
        pagina = '';
    }
    
    public void ClienteNatural()
    {
        Desactivartab();
        usuario =  ApexPages.currentPage().getParameters().get('usuario');
        pagina = 'VFPantallaClienteProducto?hytrd='+usuario;
        ClienteN = 'slds-is-active';     
    }
    
    Public void cambiarclave()
    {
        try {
            
            Usuarios_de_Pantallas__c user = [Select Email__c,name,id 
                                             From Usuarios_de_Pantallas__c 
                                             Where Usuario__c=:Cambiousuario];
            
            string contra = '';
            integer o;
            List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
            for(integer i=0; i<15; i++)
            {
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
                                  +'\n Puedes ingresar al siguiente link para cambiar tu contraseña. link: '+ claseUtil.urlSysde('Site_pantallas')+'vfCambioPasswordPantallasAfi \n'+
                                  'favor escríbenos a ficohsapensiones@ficohsa.com.\n\nFicohsa Pensiones y Cesantías\n www.ficohsa.com. \n2275-2424');
            MessageList.add(mail);  
            system.debug(mail);
            Messaging.sendEmail(MessageList); 
            user.Contrase_a__c=contra;
            update user;               
            
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'¡Se ha enviado un correo electrónico al usuario!'));
            
        }
        catch(exception ex)
        {
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
    
    public list<controllerApiClienteNatural.classRespuestaAportesCuenta> resultado {get;set;}
    Public list<string> Numcuentas {get; set;}
    public string CuentaPrueba {get; set;}
    
    public list<Pantalla_Aportes__c> McontenidoAporte{get;set;}
    
    
    Public void llenarCuentasDesdeSysde(){
        try{
            /*
CuentaPrueba = '58623';
resultado = new list<controllerApiClienteNatural.classRespuestaAportesCuenta>();                    
resultado =  controllerApiClienteNatural.ConsultalAportesPatronales(CuentaPrueba);  
if(resultado.size()>0)
{
Numcuentas= new list<string>();
for(integer j=0; j<resultado.size(); j++)
{
for(integer i=0; i<resultado[j].cuentas.size(); i++)
{
Numcuentas.add(resultado[j].cuentas[i].cuenta);
}
}

}
*/
            
            McontenidoAporte =[ select cuenta__c,Nombre_Completo__c,Tipo_Moneda__c,Fecha_Deposito__c,Monto_Deposito__c,TIPO_SALDO__c ,
                               Forma_de_Pago__c,Codigo_Referencia__c,Aplica_Comision_SI__c, Descripcion__c,
                               No_Aplica_Comision__c,Comprobante_imagen__c, Numero_Correlativo__c, Estado_Aporte__c
                               from Pantalla_Aportes__c order where Estado_Aporte__c = ''];
            
            
            
        }Catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error desde SYSDE ' + e.getMessage() ));  
        }
    }
    
    public void bitaco()
    {
        //Insertar en la bitacora 
        
        Bitacora_Conciliacion__c bita1 = new Bitacora_Conciliacion__c ();
        bita1.Actividades__c = 'Inició Sesión en el Sistema';
        bita1.Fecha__c = datetime.now();
        bita1.Pantalla__c = 'VfLoginPantallas';
        bita1.Evento__c = 'Consulta';
        bita1.Usuario__c = string.valueOf(usuario);
        insert bita1;
    }
    
    public  void Mostra()
    {
        resultado2 = new list<controllerApiClienteNatural.classRespuestaMenu>();                    
        resultado2 =  controllerApiClienteNatural.ConsultaPantallas2(usuario);
        
        for(integer j=0; j<resultado2.size(); j++)
        {
            if ( resultado2[j].nombreMetodo == ClienteN)
            {
                pagina = resultado2[j].nombreMetodo + '?hytrd=' + usuario + '&rol='+resultado2[j].rol;
                Desactivartab(); 
                
                //Insertar en la bitacora 
                
                Bitacora_Conciliacion__c bita = new Bitacora_Conciliacion__c ();
                bita.Actividades__c = 'Se ingreso a la pantalla' +':'+ resultado2[j].nombreMetodo ;
                bita.Fecha__c = date.today();
                bita.Pantalla__c = resultado2[j].nombreMetodo;
                bita.Evento__c = 'Consulta';
                bita.Usuario__c = Usuario;
                insert bita;
                
                
            }    
            
            
        }
        
    }
    
    
    //Metodo que trae las pantallas 
    
    public list<controllerApiClienteNatural.classRespuestaMenu> resultado2 {get;set;}
    //Public list<string> Numcuentas {get; set;}
    
    Public void llenarPantallasDesdeSysde()
    {
        try{
            
            resultado2 = new list<controllerApiClienteNatural.classRespuestaMenu>();                    
            resultado2 =  controllerApiClienteNatural.ConsultaPantallas2(usuario);  
            
            system.debug('Resultado2'+ resultado2  );
            system.debug('resultado del rol desde login: '+resultado2[0].rol );
            ApexPages.currentPage().getParameters().put('rol',resultado2[0].rol);
            if(resultado2.size()>0)
            {
                Numcuentas= new list<string>();
                
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Usuario Correctooo.')); 
            }
            else
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Datos menor que 0.')); 
                
            }
        }Catch(Exception e)
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error desde SYSDE ' + e.getMessage() ));  
        }
    }
    
    
    //Metodos Nuevos Agregados Luis 01/12/2019
    public void ACI(){
        Desactivartab();
        pagina = 'vfAfiliacionclienteindividual?usuario='+usuario;
    }
    public void ACC(){
        Desactivartab();
        pagina = 'vfAfiliacionescarga?usuario='+usuario;
    }
    public void ACYC(){
        Desactivartab();
        pagina = 'vfAfiliacionclientescargados?usuario='+usuario;
    }
    public void AME(){
        Desactivartab();
        pagina = 'vfAfiliacionmasivaEmpresa?usuario='+usuario;
    }
    public void EKC(){
        Desactivartab();
        pagina = 'vfEntregakitCom?usuario='+usuario;
    }
    public void RSC(){
        Desactivartab();
        pagina = 'vfReporteseguimento?usuario='+usuario;
    }
    
    
    public void RCI(){
        Desactivartab();
        pagina = 'vfReporteCalidadIndividuales?usuario='+usuario;
    }
    
    public void RCC(){
        Desactivartab();
        pagina = 'vfReportecalidad_C_NC_PL?usuario='+usuario+'&idPantalla=C';
    }
    
    public void RCNC(){
        Desactivartab();
        pagina = 'vfReportecalidad_C_NC_PL?usuario='+usuario+'&idPantalla=N';
    }
    
    public void RCP(){
        Desactivartab();
        pagina = 'vfReportecalidad_C_NC_PL?usuario='+usuario+'&idPantalla=P';
    }
    
    public void RCBFH(){
        Desactivartab();
        pagina = 'vfReporteCalidad_bfh_pm_fic?usuario='+usuario+'&idPantalla=BFK';
    }
    
    public void RCPM(){
        Desactivartab();
        pagina = 'vfReporteCalidad_bfh_pm_fic?usuario='+usuario+'&idPantalla=PM';
    }
    
    public void RCFIC(){
        Desactivartab();
        pagina = 'vfReporteCalidad_bfh_pm_fic?usuario='+usuario+'&idPantalla=FC';
    }
    
    public void EKS(){
        Desactivartab();
        pagina = 'vfEntregakitSac?usuario='+usuario;
    }
    
    public void RSS(){
        Desactivartab();
        pagina ='vfReporteseguienteSac?usuario='+usuario;
    }
    
    public void AFC(){
        Desactivartab();
        pagina ='vfAfiliacionficopen?usuario='+usuario;
    }
    
    public void ABFK(){
        Desactivartab();
        pagina ='vfAfiliacionBFH?usuario='+usuario+'&pantalla=BFK';
    }
    
    public void APM(){
        Desactivartab();
        pagina ='vfAfiliacionBFH?usuario='+usuario+'&pantalla=PM';
    }
    public void OxA(){
        Desactivartab();
        pagina ='vfOficialxAsesor?usuario='+usuario; 
    }
    public void OxE(){
        Desactivartab();
        pagina ='vfOficialesXEmpresa?usuario='+usuario;
    }
    
    
    // FIN METODOS NUEVOS
    
    
}