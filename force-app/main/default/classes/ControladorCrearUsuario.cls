public class ControladorCrearUsuario {
	
       
    public string NombreUsuario{get;set;}
    public string NombreEmpresa{get;set;}
    public string UltimoIngreso{get;set;}
   
   public string UltimoIngreso1{get;set;}
    public bitacora_Login__C prueba{get;set;}
    public string Mensaje{get;set;}
    public Usuario_Portal_Empresarial__c Usua{get;set;}
    public string Num_Identidad{get;set;}
  
    public string Nombre{get;set;}
    public string Correo{get;set;}
    public string Codigo_Unico_Banco{get; Set;}
    public string Apellido{get;set;}
    public boolean MostrarModal {get;set;}
    public boolean Planillas {get;set;}
    public boolean NuevoPersonal {get;set;}
    public boolean AprobacionUsuario {get;set;}
    public boolean NuevosSalarios {get;set;}
    public boolean PlanillaSS {get;set;}
    public boolean Pilares {get;set;}
    public boolean Reportes {get;set;}
    public boolean Usuarios {get;set;}
    public boolean AprobacionPlanilla {get;set;}
    public boolean Activo{get;set;}
    public List<SelectOption> options {get;set;}
    
    private ApexPages.StandardController stdController;
     
    public ControladorCrearUsuario (ApexPages.StandardController controller){
        stdController = controller;
        try{
             usua = (Usuario_Portal_Empresarial__c)controller.getRecord();
        }
        catch(Exception ex)
        {
            
        }
       
        options = new List<SelectOption>();
        llenarEmpresas();        
		LimpiarPantalla();
    }
    
    public void crearUsuario()
    {
        try{
            if(correo !=null && correo.Trim() !='' && nombre !=null && nombre.Trim() !=''  &&
                Num_identidad !=null && Num_identidad.Trim() !='' && Apellido !=null && Apellido.Trim() !='')
            {
           // usua = (Usuario_Portal_Empresarial__c)stdController.getRecord();  
           usua= new  Usuario_Portal_Empresarial__c();
           Num_Identidad=Num_Identidad.trim();
            integer bandera=1;
            string Nombre_usuario;
            string IdUser;
            integer u=[select count()  from Usuario_Portal_Empresarial__c where Identidad__c=:Num_Identidad];            
            if(u==0)
            {
                if(Num_Identidad.length()==13)
                {
                     while(bandera==1)
                     {
                        Nombre_usuario='';
                        for(integer i=0; i<19; i++)
                        {
                           Nombre_usuario +=string.valueOf(Math.round(Math.random() * 10));
                        }
                        bandera=[select count() from Usuario_Portal_Empresarial__c where Nombre_usuario__c=:Nombre_usuario];
                     }
                    usua.Nombre_Usuario__c=Nombre_usuario;
                    usua.Identidad__c = Num_Identidad;
                    usua.name=nombre;
                    usua.Apellidos__C=apellido;
                    usua.email__C=correo;
                    usua.id=null;
                    usua.Bloqueado__c=false;
                    insert usua;
                    IdUser=usua.id;
               }
                else
                {
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Numero de identidad invalido'));
                    
                }
                
                
            }
            
            else
            {
                    IdUser=[select id  from Usuario_Portal_Empresarial__c where Identidad__c=:Num_Identidad].id;
                    
            }
            
           u=[select count()  from Usuario_X_Empresa__c where Usuario__r.Identidad__c=:Num_Identidad and empresa2__c=:Codigo_Unico_Banco];
            if(u==0)
            {
                if(Num_identidad.length()==13)
                {
				  Usuario_X_Empresa__c UserEmpre = new Usuario_X_Empresa__c();
                   UserEmpre.Aceptar_Planilla__c=AprobacionPlanilla;
                   UserEmpre.Calculo_De_Pilares__c=pilares;
                   UserEmpre.Cargar_Generar_Planilla__c=Planillas;
                   userEmpre.Crear_Usuarios__c=Usuarios;
                   UserEmpre.Empresa2__c=Codigo_Unico_banco;
                   UserEmpre.Nuevo_Personal__c=NuevoPersonal;
                   UserEmpre.Nuevos_Salarios__c=nuevosSalarios;
                   UserEmpre.Planilla_Seguro_Social__c=PlanillaSS;
                   UserEmpre.Reportes__c=Reportes;
                   UserEmpre.Usuario__c=IdUser;
                   UserEmpre.Activo__c=Activo;
                  userempre.Aprobacion_Usuarios__c=AprobacionUsuario;
                   insert UserEmpre; 
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Usuario Creado Exitosamente'));
                   		 LimpiarPantalla();
                }
                else
                {
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Numero de identidad invalido'));
                 
                }
            }
            else
            {
                 ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Este Numero de Identidad ya existe en los Usuarios de esta empresa'));
            }
                
            }
            else
            {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Faltan Campos Obligatorios'));
            }
           
        }
        catch(Exception ex) 
        {
             ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Numero de identidad invalido'+ex.getMessage()));
        }
        
        
    }    
   public Pagereference regresar()
    {
        return new PageReference('/apex/vfConfigPortalPlanillas');
    }
    public void Buscarusuario()
    {
        try{
            usua = [select name, apellidos__C, email__C from usuario_portal_empresarial__C where identidad__C=:Num_Identidad limit 1];
            nombre=usua.name;
            apellido=usua.Apellidos__c;
            correo=usua.Email__c;
        }
        catch(Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Usuario no exite'));
        }
    }
        
    public void LimpiarPantalla()
    {
        try{
        Num_Identidad='';
        Nombre='';
        Apellido='';
       	correo='';
        mostrarModal=false;
        usuarios=false;
        Planillas=false;
        NuevoPersonal=false;
        NuevosSalarios=false;
        PlanillaSS =false;
        Pilares=false;
        Reportes =false;
        activo=false;
        Usuarios=false;
        AprobacionPlanilla =false;
        Usua.Email__c=null;  
        AprobacionUsuario=false;
        }
        catch(Exception ex)
        {
           
        }
    }
    
    
    public void llenarEmpresas()
    {
        try{
            list<Account> Empresas=new list<Account>();
            empresas=[select  id,name from Account where recordtype.developername='Juridico' order by Name asc];
           	options = new List<SelectOption>();
            for(integer i=0; i<Empresas.size(); i++)
            {
               options.add(new SelectOption(Empresas[i].id , Empresas[i].name));
            }
        }
        catch (Exception ex)
        {
            
        }
    }
    
}