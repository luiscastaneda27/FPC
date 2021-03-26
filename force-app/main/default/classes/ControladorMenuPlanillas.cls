public without sharing class ControladorMenuPlanillas {
    
    
    public string Cargar_Planilla{get;set;}
    public string NUevos_Salarios{get;set;}
    public string Seguro_Social{get;set;}
    public string Reportes{get;set;}
    public string pagina{get;set;} 
    public string Pilares{get;set;}
    public string AceptarPlanilla{get;set;}
    public string Usuarios{get;set;}
    public integer Anio{get;set;}
    integer bandera;
    public boolean Pop_SesicionInativada{get;set;}
    public string MPlanilla{get;set;}
    public string MNuevos_Salarios{get;set;}
    public string MNuevos_Empleados{get;set;}
    public string MSeguro_Social{get;set;}
    public string MReportes{get;set;}
    public string MPilares{get;set;}
    public string MAceptarP{get;set;}
    public string MUsuarios{get;set;}
    public string MAprobacionUsuarios{get;set;}
    public string MSalariosNuevos{get;set;}
    public string MUsuariosNuevos{get;set;}
    public string MostrarUsarios{get;set;} 
    
    public string y2{get;set;}
    string usuario;
    public string Codigo_Unico_Banco {get; set;}
    public list <Usuario_X_Empresa__c> Empresas {get; set;}
    public List<SelectOption> options {get;set;}
    public boolean ActivarModal {get; set;}
    
    public ControladorMenuPlanillas(){
        try{
            Desactivartab(); 
            bandera=0;
            ActivarModal = false;
            Pop_SesicionInativada =false;
            Codigo_Unico_Banco='No';
            anio=date.today().year();
            Usuario = ApexPages.currentPage().getParameters().get('loetdncdhjch');
            list<Usuario_X_Empresa__c> u =[select Empresa2__c,Empresa2__r.name 
                                           from Usuario_X_Empresa__c 
                                           where Usuario__c=:usuario and activo__c=true order by Empresa2__r.name asc];
            if(u.size() == 1){
                Codigo_Unico_Banco = u[0].Empresa2__c;
                MostarPantallas();
                Home2();
            }
            else{ 
                options = new List<SelectOption>();
                for(Usuario_X_Empresa__c t: u){
                    options.add(new SelectOption(t.Empresa2__c,t.Empresa2__r.name));
                }
                ActivarModal=true;
            }
            y2='block';
        }
        catch(Exception ex){
            system.debug(ex.getMessage());
        }
        
    }
    public void Home2(){
        Desactivartab();
        system.debug('Home 2');
        pagina = 'vfhome?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        
        
    }
    
    public void Home(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(1) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
             pagina = 'vfhome?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        }else{
            Pop_SesicionInativada=true;
        }
        
    }
    
    public void llenarempleados(){
        if(bandera==0){
            string cuentas='';
            bandera=1;
            for(cuentas__C item:[select codigo__C from cuentas__C where cliente__C=:Codigo_Unico_Banco]){
                cuentas +=item.Codigo__c+',';
            }
            aSysdePortalEmpresarial.VerificacionEmpleados(cuentas, Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId());
        }
    }
    
    
    Public Void SeleccionarEmpresa()
    {
        ActivarModal = False;
        MostarPantallas();
        Home();
    } 
    
    public  void CargarSalarios(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            pagina = 'vfCargarSalarios?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        }else{
            Pop_SesicionInativada=true;
        }
        
       
    }
    
    public void GenerarPlanillaHNL(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            pagina = 'vfGenerarPlanilla?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario +'&Moneda=HNL';
        }else{
            Pop_SesicionInativada=true;
        }
    }
    
    public void GenerarPlanillaUSD(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            pagina = 'vfGenerarPlanilla?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario +'&Moneda=USD';
        }else{
            Pop_SesicionInativada=true;
        }
    }
    
    public void GenerarSalarios(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            pagina = 'vfGenerarSalarios?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        }else{
            Pop_SesicionInativada=true;
        }
        
    }
    
    public void CargarPlanillaUSD(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            pagina = 'vfCargarPlanilla?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario+ '&Moneda=USD';
        }else{
            Pop_SesicionInativada=true;
        }       
    }
    
    public void CargarPlanillaHNL(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            system.debug('pagina :' +pagina);
            pagina = 'vfCargarPlanilla?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario+ '&Moneda=HNL';
            system.debug('pagina :' +pagina);
        }else{
            Pop_SesicionInativada=true;
        }     
    }
    
    public void CargarPersonal(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            pagina = 'vfCargarPersonal?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        }else{
            Pop_SesicionInativada=true;
        }  
        
    }
    
    public void GenerarPersonal(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            pagina = 'vfGenerarPersonal?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        }else{
            Pop_SesicionInativada=true;
        }
    }
    
    public void AceptarPlanilla(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            pagina = 'vfAceptarPlanilla?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        }else{
            Pop_SesicionInativada=true;
        }
    }
    
    public void Reportes(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            pagina = 'vfReportes?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        }else{
            Pop_SesicionInativada=true;
        }
        
    }
    
    public void GenerarPlanillaSS(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            pagina = 'vfgenerarplanillaIHSS?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        }else{
            Pop_SesicionInativada=true;
        }
    }
    
    public void CargarPlanillaSS(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            pagina = 'vfcargarplanillass?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        }else{
            Pop_SesicionInativada=true;
        }
        
    }
    
    public void CalculoDePilares(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            pagina = 'vfcalculopilares?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        }else{
            Pop_SesicionInativada=true;
        }
    }
    
    public void CrearUsuarios(){ 
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            pagina = 'vfUsuarios?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario+ '&js='+MostrarUsarios+'&sj='+MAprobacionUsuarios;
        }else{
            Pop_SesicionInativada=true;
        }
    }
    //-----MARCO-----START-----//
    public void CargarRezagos(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            pagina = 'vfPantallaCargaRezagos?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        }else{
            Pop_SesicionInativada=true;
        }       
    }
    public void CargarRezagosHNL(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            pagina = 'vfPantallaCargaRezagosLPS?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        }else{
            Pop_SesicionInativada=true;
        }       
    }
    //-----MARCO-----END-----//
    
    
    
    
    public void Colaboradesvigentes(){
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > system.now()) {
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            pagina = 'vfcolaboradoresvigentes?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        }else{
            Pop_SesicionInativada=true;
        }
        
    }
    
    public void Desactivartab(){
        Cargar_Planilla='';
        NUevos_Salarios='';
        Seguro_Social='';
        Pilares='';
        Reportes='';
        AceptarPlanilla='';
        Usuarios='';
    }
    
    
    public void MostarPantallas(){
        try{
            MPlanilla='none';
            MNuevos_Salarios='none';
            MNuevos_Empleados='none';
            MSeguro_Social='none';
            MReportes='none';
            MUsuarios='none';
            MPilares='none';
            MAceptarP='none';
            MSalariosNuevos='none';
            MUsuariosNuevos='block';
            MAprobacionUsuarios='none';
            Usuario_x_Empresa__c yeah=[select Cargar_Generar_Planilla__c, Aceptar_Planilla__c,Calculo_De_Pilares__c,
                                       Crear_Usuarios__c, Nuevo_Personal__c, Nuevos_Salarios__c, Planilla_Seguro_Social__c, Aprobacion_Usuarios__c, 
                                       Reportes__c 
                                       from Usuario_x_Empresa__c 
                                       where empresa2__c =: Codigo_Unico_Banco and Usuario__c =: Usuario];
            
            if(yeah.Cargar_Generar_Planilla__c)
            {
                MPlanilla='block';
            }
            if(yeah.Calculo_De_Pilares__c)
            {
                MPilares='block';
            }
            if(yeah.Crear_Usuarios__c)
            {
                MUsuarios='block';
                MostrarUsarios='block';
            }
            if(yeah.Nuevo_Personal__c)
            {
                MNuevos_Empleados='block';
                MSalariosNuevos='block';
            }
            if(yeah.Nuevos_Salarios__c)
            {
                MNuevos_Salarios='block';
                MSalariosNuevos='block';
            }
            if(yeah.Planilla_Seguro_Social__c)
            {
                MSeguro_Social='block';
            }
            if(yeah.Reportes__c)
            {
                MReportes='block';
            }
            if(yeah.Aceptar_Planilla__c)
            {
                MAceptarP='block';
            }
            if(yeah.Aprobacion_Usuarios__c)
            {
                MAprobacionUsuarios='block';
                MUsuarios='block';
            }
        }Catch(Exception e){
            system.debug('Error menú: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
        }
    }
    public void metodoutil()
    {
    }
    public void metodoutil2()
    {
    }
    public pageReference cerrar(){
        return new pageReference('/Apex/vfLoginPortalEmpresarial');
    }
}