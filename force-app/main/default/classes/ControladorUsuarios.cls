public class ControladorUsuarios {    
    public string NombreUsuario{get;set;}
    public string NombreEmpresa{get;set;}
    public string UltimoIngreso{get;set;}
   
    public string UltimoIngreso1{get;set;}
    public bitacora_Login__C prueba{get;set;}
	
    public boolean RNombre {get;set;}
    public boolean RApellido {get;set;}
    public boolean RIdentidad {get;set;}
    public boolean RCorreo {get;set;}
    integer j;
    public string Nombre_Empresa{get;set;}
    public string Mensaje{get;set;}
    public Usuario_Portal_Empresarial__c Usua{get;set;}
    public string Num_Identidad{get;set;}
     public string Correo{get;set;}
    public string Nombre{get;set;}
    string Codigo_Unico_Banco{get; Set;}
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
    public boolean Bloqueado {get;set;}
    public boolean mostrarbloqueado{get;set;}
    public boolean Activo{get;set;}
    string Usuario;
    string nuevo;
    public List<SelectOption> options {get;set;}
    public string MGuardar{get;set;}
    public string MActualizar{get;set;}
    public boolean MostrarPersonas {get;set;}
    public string NombreP{get;set;}
    public boolean MostrarIdent {get;set;}
    public string correovf{get;set;}
    
    public Boolean estadoCuenta{get;set;}
    
    public ControladorUsuarios (){
        try{
            Codigo_Unico_Banco=ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
            Usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
            nuevo=ApexPages.currentPage().getParameters().get('jsdhvfuyssdfyuv');
            Num_identidad =ApexPages.currentPage().getParameters().get('iden');
            options = new List<SelectOption>();
            MostrarPersonas=false;
            Nombre_EMpresa=[select name from Account where id=:Codigo_Unico_banco].name;
            Mguardar='false';
            MActualizar='false';
            RNombre =true;
            RApellido=true;
            RIdentidad =true;
            RCorreo =true;
            j=0;
            Bloqueado=false;
            mostrarbloqueado=false;
            Usua=new Usuario_Portal_Empresarial__c ();
            if(Nuevo=='1') {
                MActualizar='true';
                NombreP='Actualización de Usuario';
                
                MostrarIdent=true;
                RNombre =false;
                RApellido=false;
                RIdentidad =false;
                RCorreo =false;
                LLenarDatos();
                Activo=true;
            } else{
                Mguardar='true';
                NombreP='Nuevo Usuario';
                MostrarIdent=false;
                
            }
        }catch(exception ex){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                                                       'Ha ocurrido un error'));
        }		 
    }
    
    
    public void crearUsuariosinAutorizacion()
    {
        try{
             if(Num_Identidad!=null && nombre !=null && Apellido!=null && correovf!=null &&
             Num_Identidad.trim() !='' && nombre.trim() !='' && Apellido.trim() !='' && correovf.trim() !='')
           {
                integer bandera=1;
            string Nombre_usuario;
            string IdUser;
            long Identidad = long.valueOf(Num_Identidad);
            integer contador=[select count()  from Usuario_Portal_Empresarial__c where Identidad__c=:Num_Identidad];
            if(contador==0 && Num_Identidad.length()==13)
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
               Usuario_Portal_Empresarial__c User= new Usuario_Portal_Empresarial__c();
               User.Name=Nombre;
               user.Apellidos__c=Apellido;
               user.Email__c=correovf;
               user.Identidad__c=Num_Identidad;
               user.Nombre_Usuario__c=Nombre_usuario;
                insert user; 
                IdUser=user.id;
               
                
               
            }
            else
            {
                IdUser=[select id  from Usuario_Portal_Empresarial__c where Identidad__c=:Num_Identidad].id;
            }
            
           contador=[select count()  from Usuario_X_Empresa__c where Usuario__r.Identidad__c=:Num_Identidad and empresa2__c=:Codigo_Unico_Banco];
            if(contador==0 && num_identidad.length()==13)
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
                   UserEmpre.EstadoDeCuenta__c =estadoCuenta;
                   UserEmpre.Aprobacion_Usuarios__c=AprobacionUsuario;
                   insert UserEmpre; 
                LimpiarPantalla();
                 ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Usuario creado exitosamente'));
                   
            }
            else
            {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Este numero de identidad ya existe en sus suarios'));
               
            }      
           }
            else
            {
                 ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Faltan campos obligatorios'));
            }
                
        }
        catch(Exception ex) 
        {
          system.debug(ex.getLineNumber() + ex.getMessage());  
        }
        
        
    }
     
    
    public void autorizacionCrearusuario()
    {
    	try
        {
            integer contador =[select count() from Usuario_X_Empresa__c where empresa2__c=:Codigo_Unico_Banco and Aprobacion_Usuarios__c=true
                       and usuario__c !=:usuario];
            if(contador==0)
            {
                crearUsuariosinAutorizacion();
            }
            else
            {
                crearUsuario();
            }
           
        }
        catch(exception ex)
        {
            
        }
    }
    
     public void crearUsuario()
    {
        try{
           if(Num_Identidad.length()==13)
           {
               if(Num_Identidad!=null && nombre !=null && Apellido!=null && correovf!=null &&
             Num_Identidad.trim() !='' && nombre.trim() !='' && Apellido.trim() !='' && correovf.trim() !='')
           {
               string IdUser;
                integer u=[select count()  from Usuario_Portal_Empresarial__c where Identidad__c=:Num_Identidad];
                if(u==0)
                {
                   
                     Usuario_Temporal__c User= new Usuario_Temporal__c();
                   User.Name=Nombre;
                   user.Apellidos__c=Apellido;
                   user.Email__c=correovf;
                   user.Identidad__c=Num_Identidad;
                   insert user;  
                   IdUser=user.id;
                                      }
                else
                {
                    IdUser=[select id  from Usuario_Temporal__c where Identidad__c=:Num_Identidad].id;
                }
                
               u=[select count()  from Usuario_Empresa_Temporal__c where Usuario__r.Identidad__c=:Num_Identidad and empresa2__c=:Codigo_Unico_Banco];
                if(u==0)
                {
                        Usuario_Empresa_Temporal__c UserEmpre = new Usuario_Empresa_Temporal__c();
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
                       UserEmpre.Modificado__c=false;
                       UserEmpre.Estado__c=0;
                       UserEmpre.EstadoDeCuenta__c =estadoCuenta;
                       insert UserEmpre;  
                       LimpiarPantalla();
                       ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Usuario creado exitosamente'));
                }
                else
                {
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Este numero de identidad ya existe en sus usuarios'));
                    
                }
                    
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
                        'Faltan campos obligatorios'));
           }
                
           
        }
        catch(Exception ex) 
        {
            system.debug(ex.getLineNumber()+ ex.getMessage());
        }
        
        
    }
    
    
    
    
    public void LLenarDatos()
    {
        try{
            Usuario_X_Empresa__c  ki= new Usuario_X_Empresa__c ();
            ki=[select  Usuario__r.name, Usuario__r.Apellidos__C, Usuario__r.Identidad__c,activo__c,Usuario__r.Email__c ,Cargar_Generar_Planilla__c, Aceptar_Planilla__c,Calculo_De_Pilares__c,
                  Crear_Usuarios__c, Nuevo_Personal__c, Nuevos_Salarios__c, Planilla_Seguro_Social__c, EstadoDeCuenta__c,
                  Reportes__c, Aprobacion_Usuarios__c, usuario__r.bloqueado__C from Usuario_X_Empresa__c where Usuario__r.Identidad__c=:Num_identidad and empresa2__c=:Codigo_Unico_banco limit 1];
            
            Nombre=ki.Usuario__r.name;
            bloqueado=ki.usuario__r.bloqueado__C;
            mostrarbloqueado=ki.usuario__r.bloqueado__C;
            Apellido=ki.Usuario__r.Apellidos__C;
            correovf=ki.Usuario__r.Email__c; 
            Planillas=ki.Cargar_Generar_Planilla__c;
            NuevoPersonal=ki.Nuevo_Personal__c;
            NuevosSalarios=ki.Nuevos_Salarios__c;
            PlanillaSS =ki.Planilla_Seguro_Social__c;
            Pilares=ki.Calculo_De_Pilares__c;
            Reportes =ki.Reportes__c;
            Usuarios=ki.Crear_Usuarios__c;
            AprobacionPlanilla =ki.Aceptar_Planilla__c;
            activo=ki.Activo__c;
            AprobacionUsuario=ki.Aprobacion_Usuarios__c;
            estadoCuenta = ki.EstadoDeCuenta__c;
        }
        catch(Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        ex.getLineNumber()+ex.getMessage()));
        }
    }
    public void autorizacionActualizarusuario()
    {
    	try
        {
            integer contador =[select count() from Usuario_X_Empresa__c where empresa2__c=:Codigo_Unico_Banco and Aprobacion_Usuarios__c=true
                       and usuario__c !=:usuario];
            if(contador==0)
            {
                ActualizarsinAutorizacion();
            }
            else
            {
                actualizar();
            }
           
        }
        catch(exception ex)
        {
            
        }
    }
    Public void ActualizarsinAutorizacion()
    {
        try{
            if(Num_Identidad!=null && nombre !=null && Apellido!=null && correovf!=null &&
             Num_Identidad.trim() !='' && nombre.trim() !='' && Apellido.trim() !='' && correovf.trim() !='')
           {
        		 string yeah =[select id  from Usuario_X_Empresa__c where Usuario__r.Identidad__c=:Num_Identidad and empresa2__c=:Codigo_Unico_Banco].id;
            		string yeah1=[select id  from usuario_Portal_Empresarial__c where Identidad__c=:Num_Identidad].id;
            
                   Usuario_X_Empresa__c UserEmpre = new Usuario_X_Empresa__c();
                   usuario_Portal_Empresarial__c User = new usuario_Portal_Empresarial__c();
            		user.name=Nombre;
            		user.Apellidos__c=Apellido;
            		user.Email__c=correovf;
            		user.Id=yeah1;
            		if(mostrarbloqueado)
                    {
                      user.bloqueado__C=bloqueado;  
                    }
            		update user;		
            
                   UserEmpre.Aceptar_Planilla__c=AprobacionPlanilla;
                   UserEmpre.Calculo_De_Pilares__c=pilares;
                   UserEmpre.Cargar_Generar_Planilla__c=Planillas;
                   userEmpre.Crear_Usuarios__c=Usuarios;
                   UserEmpre.Empresa2__c=Codigo_Unico_banco;
                   UserEmpre.Nuevo_Personal__c=NuevoPersonal;
                   UserEmpre.Nuevos_Salarios__c=nuevosSalarios;
                   UserEmpre.Planilla_Seguro_Social__c=PlanillaSS;
           		   UserEmpre.Aprobacion_Usuarios__c=AprobacionUsuario;
                   UserEmpre.Activo__c=Activo;
                   UserEmpre.Reportes__c=Reportes;
                   UserEmpre.EstadoDeCuenta__c =estadoCuenta;
                   UserEmpre.id=yeah;
                    update UserEmpre; 
            		//LimpiarPantalla();
            		ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Usuario actualizado exitosamente'));
           }
            else
            {
               ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Faltan campos obligatorios'));   
            }
            		
        }
        CAtch(Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'EL correo no tiene el formato correcto')); 
        }
    }
    
    Public void Actualizar()
    {
        try{
           if(Num_Identidad!=null && nombre !=null && Apellido!=null && correovf!=null &&
             Num_Identidad.trim() !='' && nombre.trim() !='' && Apellido.trim() !='' && correovf.trim() !='')
           {
               if([select count()  from Usuario_Empresa_Temporal__c where Usuario__r.Identidad__c=:Num_Identidad and empresa2__c=:Codigo_Unico_Banco]==0)
            {
            	Usuario_Temporal__c usum= new Usuario_Temporal__c();
                usum.Identidad__c=Num_Identidad;
                insert usum;
                Usuario_Empresa_Temporal__c usun= new Usuario_Empresa_Temporal__c();
                usun.Empresa2__c=codigo_unico_banco;
                usun.Usuario__c=usum.id;
                insert usun;
                
            }
            		
            
            
               string yeah =[select id  from Usuario_Empresa_Temporal__c where Usuario__r.Identidad__c=:Num_Identidad and empresa2__c=:Codigo_Unico_Banco].id;
               string yeah1=[select id  from Usuario_Temporal__c where Identidad__c=:Num_Identidad].id;
            
                   Usuario_Empresa_Temporal__c UserEmpre = new Usuario_Empresa_Temporal__c();
                   Usuario_Temporal__c User = new Usuario_Temporal__c();
            		user.name=Nombre;
            		user.Apellidos__c=Apellido;
            		user.Email__c=correovf;
            		user.Id=yeah1;
            		if(mostrarbloqueado)
                    {
                      user.bloqueado__C=bloqueado;  
                    }
            		update user;		
            
                   UserEmpre.Aceptar_Planilla__c=AprobacionPlanilla;
                   UserEmpre.Calculo_De_Pilares__c=pilares;
                   UserEmpre.Cargar_Generar_Planilla__c=Planillas;
                   userEmpre.Crear_Usuarios__c=Usuarios;
                   UserEmpre.Empresa2__c=Codigo_Unico_banco;
                   UserEmpre.Nuevo_Personal__c=NuevoPersonal;
                   UserEmpre.Nuevos_Salarios__c=nuevosSalarios;
                   UserEmpre.Planilla_Seguro_Social__c=PlanillaSS;
                   UserEmpre.Activo__c=Activo;
                   UserEmpre.Reportes__c=Reportes;
                   UserEmpre.id=yeah;
            	   userEmpre.Aprobacion_Usuarios__c=AprobacionUsuario;
            	   UserEmpre.Estado__C=0;
                   UserEmpre.Modificado__c=true;
                   UserEmpre.EstadoDeCuenta__c = estadoCuenta;
                    update UserEmpre; 
            		//LimpiarPantalla();
            		ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                   'Usuario actualizado exitosamente'));
           }else{
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                   'Faltan campos obligatorios')); 
            }
            			
        } catch(Exception ex){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                   'El correo no tiene el formato correcto')); 
        }
    }
    
    
    public void LimpiarPantalla() {
        Num_Identidad='';
        Nombre='';
        Apellido='';
        correovf='';
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
    
    
 
    
}