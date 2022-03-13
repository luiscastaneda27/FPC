public class ContraladorCrearusuario2 {

    public list<Usuario_X_Empresa__c> listUsuarios{get;set;}
    public string Num_identidad{get;set;}
    public string Codigo_unico_banco{get;set;}
    public boolean popModificar{get;set;}
    public string URL_Pagina{get;set;}
    public string usuario{get;set;}
    public boolean Autorizacionusuario{get;set;}
    public boolean MostrarNuevousuario{get;set;}
    public integer banderaTiempo{get;set;}
    Public list<Usuario_Empresa_Temporal__c>  listAprobacionesPendientes{get;set;}
    
    Usuario_x_Empresa__c Permisos;
    public boolean popCambioContrasena{get;set;}
    public string contrasenaActual{get;set;}
    public string contrasenaNueva{get;set;}
    public string contrasenaRepetida{get;set;}
    public string Nombre_Empresa{get;set;}
    public Tiempo_Inactividad__c hora{get;set;}
    
    public ContraladorCrearusuario2(){
        try {
            Codigo_Unico_Banco=ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
            Usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
            popModificar=false;
            banderaTiempo=0;
            Nombre_Empresa=[select name from Account where id=:Codigo_unico_banco].name;
            Permisos = [Select Aceptar_Planilla__c, Crear_Usuarios__c, Aprobacion_Usuarios__c,Cargar_Generar_Planilla__c,
                        Usuario__c, Usuario__r.Contrasena2__c 
                        From Usuario_x_Empresa__c 
                        Where empresa2__c =: Codigo_Unico_Banco 
                        And Usuario__c =: Usuario];
            
            //MostrarNuevousuario=Permisos.Crear_Usuarios__c;
            //Autorizacionusuario=Permisos.Aprobacion_Usuarios__c; 
            
            Cargarusuarios();
            popModificar=false;
            popCambioContrasena = False;
            contrasenaActual = '';
            contrasenaNueva = '';
            contrasenaRepetida = '';
            hora = [select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        }catch(exception ex){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                                                       'Lo sentimos, hubo un error intentelo nuevamente')); 
        }
    }
    public void registrarTiempo(){
        try{
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
        }catch(Exception ex){
            System.debug('Error actualizar hora');
        }
    }
    public void Cargarusuarios()
    {
        try{
             
            listUsuarios = new list<Usuario_X_Empresa__c> ();
            listAprobacionesPendientes= new list<Usuario_Empresa_Temporal__c> ();
            listUsuarios=[select id,Usuario__r.name, Usuario__r.Identidad__c, Usuario__r.Apellidos__C, Aceptar_Planilla__c, Activo__c,
                          Aprobacion_Usuarios__c, Calculo_De_Pilares__c, Cargar_Generar_Planilla__c, Crear_Usuarios__c, Nuevo_Personal__c,
                          Nuevos_Salarios__c, Planilla_Seguro_Social__c, Reportes__c, EstadoDeCuenta__c
                          from Usuario_X_Empresa__c where empresa2__c=:codigo_Unico_banco];
            
            listAprobacionesPendientes = [select  id,Usuario__r.name, Usuario__r.Apellidos__C, Usuario__r.Identidad__c, Aprobacion_Usuarios__c ,activo__c,Usuario__r.Email__c ,Cargar_Generar_Planilla__c, Aceptar_Planilla__c,Calculo_De_Pilares__c,
                                          Crear_Usuarios__c, Nuevo_Personal__c, Nuevos_Salarios__c, Planilla_Seguro_Social__c, EstadoDeCuenta__c,
                                          Reportes__c from Usuario_Empresa_Temporal__c where Estado__c=0 and empresa2__c=:codigo_Unico_banco];
            MostrarNuevousuario = (listUsuarios.size()>0 && Permisos.Crear_Usuarios__c);
            Autorizacionusuario = (listAprobacionesPendientes.size()>0 && Permisos.Aprobacion_Usuarios__c);
            
        }catch(exception ex)
        {
              ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Lo sentimos, hubo un error intentelo nuevamente'));
        }
    }
	
    public void Cancelar(){
        registrarTiempo();
        popModificar=false;
        popCambioContrasena = False;
        contrasenaActual = '';
        contrasenaNueva = '';
        contrasenaRepetida = '';
        Cargarusuarios();
    }
    
    public void verCambioContrasena(){
        registrarTiempo();
        popCambioContrasena = true;
    }
    
    public void cambiarContrasena(){
        try{
            registrarTiempo();
            if(contrasenaActual != null && contrasenaActual != ''){
            		if(contrasenaActual == Permisos.Usuario__r.Contrasena2__c){ 
            			if(claseUtilPlanillas.validarContrasena(contrasenaNueva)){
            				if(contrasenaNueva == contrasenaRepetida){
            					Usuario_Portal_Empresarial__c usuarioCambioC = [Select id 
            													From Usuario_Portal_Empresarial__c 
            													Where id =: Permisos.Usuario__c];
            				 									
            					usuarioCambioC.Contrasena2__c = contrasenaNueva;
            					update usuarioCambioC;
            					
            					Cancelar();
            					ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, 'Se ha actualizado su contrasena'));    	
            				}else{
            					ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Las Contraseñas Nuevas no coinciden')); 	
            				}
            			}
            		}else{
            			ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Contraseña Actual no coincide'));   
            		}	
            }else{
            		ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Debes llenar tu contraseña actual'));   
            }
            
        }Catch(Exception e){
        		ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Ha ocurrido un error'));    
        }
    }
    
    public void ActivarModalModificarusuario(){
        registrarTiempo();
        Url_pagina='/apex/vfNuevousuario?Eldudhdhyudb=' + Codigo_Unico_Banco + '&jsdhvfuyssdfyuv=1&iden='+Num_identidad;
        popModificar=true;   
    }
    
    public void ActivarModalCrearusuario() {
        registrarTiempo();
        Url_pagina='/apex/vfNuevousuario?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario+ '&jsdhvfuyssdfyuv=0';
        popModificar=true;  
    }
    
	public void Denegar()
    {
        try{
            registrarTiempo();
            boolean Modificado = [select Modificado__c from Usuario_Empresa_Temporal__c where Usuario__r.Identidad__c=:Num_Identidad and empresa2__c=:Codigo_Unico_banco ].Modificado__C;
            if(!Modificado){
                 integer contador =[select count() from Usuario_Empresa_Temporal__c where usuario__r.identidad__C=:Num_Identidad];
                 if(contador==1){
                     delete ([select id from Usuario_Empresa_Temporal__c where usuario__r.identidad__C=:Num_Identidad]);
                     delete ([select id from Usuario_Temporal__c where identidad__C=:Num_Identidad]);
                 }else{
                     delete ([select id from Usuario_Empresa_Temporal__c where usuario__r.identidad__C=:Num_Identidad and empresa2__c=:Codigo_Unico_Banco]);
                 }
             }else{
                 Usuario_Empresa_Temporal__c yeah= new Usuario_Empresa_Temporal__c();
                 string idN=[select id from Usuario_Empresa_Temporal__c where usuario__r.identidad__C=:Num_Identidad and empresa2__c=:Codigo_Unico_Banco].id; 
                 yeah.id=idn;
                 yeah.Estado__c=1;
                 update yeah;
                 ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Cambios guardados exitosamente'));
             }
             Cargarusuarios();
         }Catch(Exception ex){
            
        }
    
    }    
    
    public void Aprobar(){
        try{
            registrarTiempo();
            boolean Modificado = [select Modificado__c from Usuario_Empresa_Temporal__c where Usuario__r.Identidad__c=:Num_Identidad and empresa2__c=:Codigo_Unico_banco ].Modificado__C;
            Usuario_Empresa_Temporal__C Usuariotemporal=new Usuario_Empresa_Temporal__C();
            Usuariotemporal = [select  id,Usuario__r.name, Usuario__r.Apellidos__C, Usuario__r.Identidad__c, Aprobacion_Usuarios__c ,activo__c,Usuario__r.Email__c ,Cargar_Generar_Planilla__c, Aceptar_Planilla__c,Calculo_De_Pilares__c,
                               Crear_Usuarios__c, Usuario__r.bloqueado__C, Nuevo_Personal__c, Nuevos_Salarios__c, Planilla_Seguro_Social__c, EstadoDeCuenta__c,
                               Reportes__c, Modificado__c from Usuario_Empresa_Temporal__c where Usuario__r.Identidad__c=:Num_identidad];
            if(!Modificado){
                integer bandera=1;
                string Nombre_usuario;
                string IdUser;
                integer u=[select count()  from Usuario_Portal_Empresarial__c where Identidad__c=:Num_Identidad];
                if(u==0){
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
                    User.Name=Usuariotemporal.Usuario__r.name;
                    user.Apellidos__c=Usuariotemporal.Usuario__r.Apellidos__c;
                    user.Email__c=Usuariotemporal.Usuario__r.Email__c;
                    user.Identidad__c=Num_Identidad;
                    user.Nombre_Usuario__c=Nombre_usuario;
                    user.Bloqueado__c=false;
                    insert user;  
                    IdUser=user.id;
                } else{
                    IdUser=[select id  from Usuario_Portal_Empresarial__c where Identidad__c=:Num_Identidad].id;
                }
                
                u=[select count()  from Usuario_X_Empresa__c where Usuario__r.Identidad__c=:Num_Identidad and empresa2__c=:Codigo_Unico_Banco];
                if(u==0) {
                    Usuario_X_Empresa__c UserEmpre = new Usuario_X_Empresa__c();
                    UserEmpre.Aceptar_Planilla__c=Usuariotemporal.Aceptar_Planilla__c;
                    UserEmpre.Calculo_De_Pilares__c=Usuariotemporal.Calculo_De_Pilares__c;
                    UserEmpre.Cargar_Generar_Planilla__c=Usuariotemporal.Cargar_Generar_Planilla__c;
                    userEmpre.Crear_Usuarios__c=Usuariotemporal.Crear_Usuarios__c;
                    UserEmpre.Empresa2__c=Codigo_Unico_banco;
                    UserEmpre.Nuevo_Personal__c=Usuariotemporal.Nuevo_Personal__c;
                    UserEmpre.Nuevos_Salarios__c=Usuariotemporal.Nuevos_Salarios__c;
                    UserEmpre.Planilla_Seguro_Social__c=Usuariotemporal.Planilla_Seguro_Social__c;
                    UserEmpre.Reportes__c=Usuariotemporal.Reportes__c;
                    UserEmpre.Usuario__c=IdUser;
                    UserEmpre.Activo__c=Usuariotemporal.Activo__c;
                    userEmpre.Aprobacion_Usuarios__c=Usuariotemporal.Aprobacion_Usuarios__c;
                    userEmpre.EstadoDeCuenta__c = Usuariotemporal.EstadoDeCuenta__c;
                    insert UserEmpre; 
                    
                    Usuario_Empresa_Temporal__c yeah6= new Usuario_Empresa_Temporal__c();
                    string hy= [select id from Usuario_Empresa_Temporal__c where usuario__r.identidad__C=:Num_Identidad and empresa2__c=:Codigo_Unico_Banco].id; 
                    yeah6.id=hy;
                    yeah6.Estado__c=2;
                    update yeah6;
                }
            }else{
                string hola =[select id  from Usuario_X_Empresa__c where Usuario__r.Identidad__c=:Num_Identidad and empresa2__c=:Codigo_Unico_Banco].id;
                usuario_Portal_Empresarial__c yeah1=[select id, bloqueado__C  from usuario_Portal_Empresarial__c where Identidad__c=:Num_Identidad];
                
                Usuario_X_Empresa__c UserEmpre = new Usuario_X_Empresa__c();
                usuario_Portal_Empresarial__c User = new usuario_Portal_Empresarial__c();
                user.name=Usuariotemporal.Usuario__r.name;
                user.Apellidos__c=Usuariotemporal.Usuario__r.Apellidos__c;
                user.Email__c=Usuariotemporal.Usuario__r.Email__c;
                user.Id=yeah1.id;
                if(yeah1.Bloqueado__c)
                {
                    user.bloqueado__C = Usuariotemporal.Usuario__r.bloqueado__C; 
                }
                update user;		
                
                UserEmpre.Aceptar_Planilla__c=Usuariotemporal.Aceptar_Planilla__c;
                UserEmpre.Calculo_De_Pilares__c=Usuariotemporal.Calculo_De_Pilares__c;
                UserEmpre.Cargar_Generar_Planilla__c=Usuariotemporal.Cargar_Generar_Planilla__c;
                userEmpre.Crear_Usuarios__c=Usuariotemporal.Crear_Usuarios__c;
                userEmpre.Aprobacion_Usuarios__c=Usuariotemporal.Aprobacion_Usuarios__c;
                UserEmpre.empresa2__c=Codigo_Unico_banco;
                UserEmpre.Nuevo_Personal__c=Usuariotemporal.Nuevo_Personal__c;
                UserEmpre.Nuevos_Salarios__c=Usuariotemporal.Nuevos_Salarios__c;
                UserEmpre.Planilla_Seguro_Social__c=Usuariotemporal.Planilla_Seguro_Social__c;
                UserEmpre.Activo__c=Usuariotemporal.Activo__c;
                UserEmpre.Reportes__c=Usuariotemporal.Reportes__c;
                UserEmpre.EstadoDeCuenta__c=Usuariotemporal.EstadoDeCuenta__c;
                UserEmpre.id=hola; 
                update UserEmpre; 
                
                Usuario_Empresa_Temporal__c yeah6= new Usuario_Empresa_Temporal__c();
                string hy= [select id from Usuario_Empresa_Temporal__c where usuario__r.identidad__C=:Num_Identidad and empresa2__c=:Codigo_Unico_Banco].id; 
                yeah6.id=hy;
                yeah6.Estado__c=2;
                update yeah6;
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                                                           'Cambios guardados exitosamente'));
                
            }
            Cargarusuarios();
        }Catch(Exception ex){}
    }
}