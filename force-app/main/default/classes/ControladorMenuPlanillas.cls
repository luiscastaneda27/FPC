public class ControladorMenuPlanillas {
    
    
    public string Cargar_Planilla{get;set;}
    public string NUevos_Salarios{get;set;}
    public string Seguro_Social{get;set;}
    public string Reportes{get;set;}
    public string pagina{get;set;} 
    public string Pilares{get;set;}
    public string AceptarPlanilla{get;set;}
    public String estadoCuenta {get;set;}
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
    public string MEDC{get;set;}
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
            }else{ 
                options = new List<SelectOption>();
                for(Usuario_X_Empresa__c t: u){
                    options.add(new SelectOption(t.Empresa2__c,t.Empresa2__r.name));
                }
                ActivarModal=true;
            }
            y2='block';
        } catch(Exception ex) {
            system.debug(ex.getMessage());
        }
    }
    public void Home2(){
       Desactivartab();
        pagina = 'vfhome?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        
          
    }
    
    public void Home(){
        if(tiempoUsuario()){
            Desactivartab();
            pagina = 'vfHome?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        }
    }
   
    public void llenarempleados() {
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
        if(tiempoUsuario()){
            pagina = 'vfCargarSalarios?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
        }
    }
    
    public void GenerarPlanillaHNL(){
        if(tiempoUsuario()){
            pagina = 'vfGenerarPlanilla?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario +'&Moneda=HNL';
            Cargar_Planilla = 'slds-is-active';  
        }
    }
    
     public void GenerarPlanillaUSD(){
         if(tiempoUsuario()){
             pagina = 'vfGenerarPlanilla?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario +'&Moneda=USD';
             Cargar_Planilla = 'slds-is-active';  
         }
    }
         
    public void GenerarSalarios(){
        if(tiempoUsuario()){
            pagina = 'vfGenerarSalarios?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
            Nuevos_Salarios = 'slds-is-active';
        }
    }
    
      public void CargarPlanillaUSD(){
          if(tiempoUsuario()){
              pagina = 'vfCargarPlanilla?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario+ '&Moneda=USD';
              Cargar_Planilla = 'slds-is-active';  
          }
    }
    
     public void CargarPlanillaHNL(){
         if(tiempoUsuario()){
             pagina = 'vfCargarPlanilla?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario +'&Moneda=HNL';
             Cargar_Planilla = 'slds-is-active';  
         }
    }
    
     public void CargarPersonal(){
         if(tiempoUsuario()){
             llenarempleados();
             pagina = 'vfCargarPersonal?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
             Nuevos_Salarios = 'slds-is-active';  
         }
    }
    
     public void GenerarPersonal(){
         if(tiempoUsuario()){
             pagina = 'vfGenerarPersonal?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
             Nuevos_Salarios = 'slds-is-active';  
         }
    }
    
     public void AceptarPlanilla(){
         if(tiempoUsuario()){
             pagina = 'vfAceptarPlanilla?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
             AceptarPlanilla = 'slds-is-active';  
         }
    }
    
    public void Reportes(){
        if(tiempoUsuario()){
            pagina = 'vfReportes?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
            Reportes = 'slds-is-active';  
        }
    }
    
    public void GenerarPlanillaSS(){
        if(tiempoUsuario()){
            pagina = 'vfgenerarplanillaIHSS?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
            Seguro_Social = 'slds-is-active'; 
        }
    }
        
    public void CargarPlanillaSS(){
        if(tiempoUsuario()){
            pagina = 'vfcargarplanillass?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
            Seguro_Social = 'slds-is-active'; 
        } 
    }
    
    public void CalculoDePilares(){
        if(tiempoUsuario()){
            pagina = 'vfcalculopilares?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
            Pilares = 'slds-is-active'; 
        } 
    }
    public void estadoCuenta(){
        if(tiempoUsuario()){
            pagina = 'vfEstadoDeCuentaPlanilla?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
            estadoCuenta = 'slds-is-active'; 
        }
    }
    
     public void CrearUsuarios(){ 
         if(tiempoUsuario()){
             pagina = 'vfUsuarios?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario+ '&js='+MostrarUsarios+'&sj='+MAprobacionUsuarios;
             Usuarios = 'slds-is-active';
         }
    }  
   
  
    
    
    public void colaboradesVigentes(){
        if(tiempoUsuario()){
            llenarempleados();
            pagina = 'vfcolaboradoresvigentes?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario;
            Usuarios = 'slds-is-active'; 
        }
    }
    
    public Boolean tiempoUsuario(){
        Tiempo_Inactividad__c hora = [select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        if(hora.Hora_ultima_consulta__c.addMinutes(10) > System.now()){
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Desactivartab();
            return true;
        }else{
            Pop_SesicionInativada=true;
            return false;
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
        estadoCuenta = '';
    }
  
   
    public void MostarPantallas(){
        try{
            MNuevos_Salarios='none';
            MNuevos_Empleados='none';
            MUsuarios='none';
            MSalariosNuevos='none';
            MUsuariosNuevos='block';
            MAprobacionUsuarios='none';
            Usuario_x_Empresa__c yeah=[select Cargar_Generar_Planilla__c, Aceptar_Planilla__c,Calculo_De_Pilares__c,
                                       Crear_Usuarios__c, Nuevo_Personal__c, Nuevos_Salarios__c, Planilla_Seguro_Social__c, Aprobacion_Usuarios__c, 
                                       Reportes__c ,EstadoDeCuenta__c
                                       from Usuario_x_Empresa__c 
                                       where empresa2__c =: Codigo_Unico_Banco and Usuario__c =: Usuario];
            MEDC = yeah.EstadoDeCuenta__c ? 'block' : 'none';
            MPlanilla = yeah.Cargar_Generar_Planilla__c ? 'block' : 'none';
            MPilares = yeah.Calculo_De_Pilares__c ? 'block' : 'none';
            MSeguro_Social = yeah.Planilla_Seguro_Social__c ? 'block' : 'none';
            MReportes = yeah.Reportes__c ? 'block' : 'none';
            MAceptarP = yeah.Aceptar_Planilla__c ? 'block' : 'none';
            
            if(yeah.Crear_Usuarios__c) {
                MUsuarios='block';
                MostrarUsarios='block';
            }
            if(yeah.Nuevo_Personal__c){
                MNuevos_Empleados='block';
                MSalariosNuevos='block';
            }
            if(yeah.Nuevos_Salarios__c){
                MNuevos_Salarios='block';
                MSalariosNuevos='block';
            }
            
            if(yeah.Aprobacion_Usuarios__c){
                MAprobacionUsuarios='block';
                MUsuarios='block';
            }
        }Catch(Exception e){
            system.debug('Error menú: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
        }
    }
    public pageReference cerrar(){
        return new pageReference('/Apex/vfLoginPortalEmpresarial');
    }
}