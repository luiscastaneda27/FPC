/*public class controladorCambioUsuarios {

    public string contrasenia{Get;set;}
    public string Usuario{Get;set;}
    public string reconfirmarcontrasenia{Get;set;}
    public string reconfirmarUsuario{Get;set;}
    public string Respuesta{Get;set;}
    public Usuario_Portal_Empresarial__c UsuarioNuevo {get;set;}
   public boolean MostrarModal{get;set;}
    public string Mensaje{Get;set;}
    public boolean controlador{Get;set;}
    public string id_Pregunta{Get;set;}
    public List<SelectOption> options {get;set;}
    string idNuevoUsuario;
    string idotros;
    public boolean desbloquearOtroPregunta{Get;set;}
    Public list<Pregunta_seguridad__C> listpreguntas{Get;set;}
    
    public controladorCambioUsuarios()
    {
        idNuevoUsuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
        if([select count() from Usuario_Portal_Empresarial__c where id=:idNuevoUsuario and respuesta__C!=null] >0)
        {
            MostrarModal=true;
            mensaje='El usuario ya existe.';
        }
        UsuarioNuevo = new Usuario_Portal_Empresarial__c(); 
         
        controlador=true;
        options = new List<SelectOption>(); 
        CargarPreguntas();
        desbloquearOtroPregunta=true;
    }
    public void CargarPreguntas()
    {
        listpreguntas = new list<Pregunta_seguridad__C>();
        listpreguntas=[select id, name from Pregunta_seguridad__C];
        for(integer i=0; i<listpreguntas.size(); i++)
        {
           options.add(new SelectOption(listpreguntas[i].id,listpreguntas[i].name));
           if(listpreguntas[i].name=='Otros')
           {
               idotros=listpreguntas[i].id;
           }
        }
    }
    public void Guardar()
    {
        try {
           
           // reconfirmarcontrasenia
           integer u=[select count() from Usuario_Portal_Empresarial__C where Nombre_Usuario__C=:UsuarioNuevo.Nombre_usuario__C];
            if(u==0 && reconfirmarUsuario.length()>5)
            {
                if(reconfirmarcontrasenia==UsuarioNuevo.Contrasena2__c && UsuarioNuevo.Nombre_Usuario__c==reconfirmarUsuario)
                {
                    if(UsuarioNuevo.Respuesta__c !=null)
                    {
                        if(validarContrasenias())
                        {
                   		if([select count() from Usuario_Portal_Empresarial__c where id=:idNuevoUsuario and respuesta__C!=null] >0)
                            {
                                MostrarModal=true;
                                mensaje='El usuario ya existe.';
                            }
                            else
                            {
                                UsuarioNuevo.Id=idNuevoUsuario;
                                UsuarioNuevo.Pregunta__c=id_pregunta;
                                update UsuarioNuevo;
                                
                                controlador=false;
                                bitacora_contrasenas__c yeah3 = new bitacora_contrasenas__c();
                                yeah3.usuario__c=idNuevoUsuario;
                                yeah3.Fecha__c=date.today();
                                yeah3.Contrasenia__c=UsuarioNuevo.Contrasena2__c;
                                insert yeah3;
                                mensaje='Usuario creado correctamente';
                                MostrarModal=true;
                            }
                       
                        
                    }
                    }
                    else
                         ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Todavía hay campos obligatorios Vacíos.')); 
                }
                else
                {
                     ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'El nombre de usuario o contraseña no coinciden')); 
                }
            }
            else
            {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Lo sentimos no puedes utilizar este nombre de usuario')); 
                
            }
        }
        catch (Exception ex)
        {
             ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Lo sentimos, hubo un error intentelo nuevamente')); 
        }
    }
    public void Desbloqueo()
    {
        desbloquearOtroPregunta=true;
        UsuarioNuevo.Otra_pregunta__c='';
       if(id_pregunta==idotros)
        {
           desbloquearOtroPregunta=false; 
        }
    }
     public boolean validarContrasenias(){
        
        //Verificar que la contraseña tiene al menos un dígito, una mayúscula una minúscula y un carácter especial
        contrasenia=usuarionuevo.Contrasena2__c;
        if(contrasenia.length() >= 8){
            Integer num = contrasenia.length();        
            if(!pattern.matches('((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{'+ num +'})', contrasenia) || !pattern.matches('((?=.*[@#$%])(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{' + num + '})', contrasenia)
                || !pattern.matches('((?=.*\\d)(?=.*[a-z])(?=.*[@#$%])(?=.*[A-Z]).{' + num + '})', contrasenia) ){
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
    public PageReference Salir()
    {
        MostrarModal=false; 
         return new PageReference (claseutil.urlSysde('Empresarial'));
    }
    
         
    
}*/



public class controladorCambioUsuarios {

    public string contrasenia{Get;set;}
    public string Usuario{Get;set;}
    public string reconfirmarcontrasenia{Get;set;}
    public string reconfirmarcontrasenia2{Get;set;}
    public string reconfirmarUsuario{Get;set;}
    public string Respuesta{Get;set;}
    public Usuario_Portal_Empresarial__c UsuarioNuevo {get;set;}
   public boolean MostrarModal{get;set;}
    public string Mensaje{Get;set;}
    public boolean controlador{Get;set;}
    public string id_Pregunta{Get;set;}
    public List<SelectOption> options {get;set;}
    string idNuevoUsuario;
    string idotros;
    public boolean desbloquearOtroPregunta{Get;set;}
    Public list<Pregunta_seguridad__C> listpreguntas{Get;set;}
    
    public controladorCambioUsuarios()
    {
        idNuevoUsuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
        if([select count() from Usuario_Portal_Empresarial__c where id=:idNuevoUsuario and respuesta__C!=null] >0)
        {
            MostrarModal=true;
            mensaje='El usuario ya existe.';
        }
        UsuarioNuevo = new Usuario_Portal_Empresarial__c(); 
         
        controlador=true;
        options = new List<SelectOption>(); 
        CargarPreguntas();
        //desbloquearOtroPregunta=true;
        Desbloqueo();
    }
    public void CargarPreguntas()
    {
        listpreguntas = new list<Pregunta_seguridad__C>();
        listpreguntas=[select id, name from Pregunta_seguridad__C];
        id_pregunta=listpreguntas[0].id;
        for(integer i=0; i<listpreguntas.size(); i++)
        {
           options.add(new SelectOption(listpreguntas[i].id,listpreguntas[i].name));
           if(listpreguntas[i].name=='Otros')
           {
               idotros=listpreguntas[i].id;
           }
        }
    }
    public void Guardar()
    {
        try {
           
           integer u=[select count() from Usuario_Portal_Empresarial__C where Nombre_Usuario__C=:UsuarioNuevo.Nombre_usuario__C];
            system.debug(reconfirmarUsuario+'  '+UsuarioNuevo.Nombre_Usuario__c+'   '+reconfirmarcontrasenia+'  '+reconfirmarcontrasenia2);
            if(u==0 && reconfirmarUsuario.length()>5)
            {
                if((reconfirmarcontrasenia==reconfirmarcontrasenia2) && (UsuarioNuevo.Nombre_Usuario__c==reconfirmarUsuario))
                {
                    if(UsuarioNuevo.Respuesta__c !=null)
                    {
                        if(validarContrasenias())
                        {
                        UsuarioNuevo.Contrasena2__c =reconfirmarcontrasenia2;
                   		if([select count() from Usuario_Portal_Empresarial__c where id=:idNuevoUsuario and respuesta__C!=null] >0)
                            {
                                MostrarModal=true;
                                mensaje='El usuario ya existe.';
                            }
                            else
                            {
                                UsuarioNuevo.Id=idNuevoUsuario;
                                UsuarioNuevo.Pregunta__c=id_pregunta;
                                update UsuarioNuevo;
                                
                                controlador=false;
                                bitacora_contrasenas__c yeah3 = new bitacora_contrasenas__c();
                                yeah3.usuario__c=idNuevoUsuario;
                                yeah3.Fecha__c=date.today();
                                yeah3.Contrasenia__c=UsuarioNuevo.Contrasena2__c;
                                insert yeah3;
                                mensaje='Usuario creado correctamente';
                                MostrarModal=true;
                            }
                       
                        
                    }
                    }
                    else
                         ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Todavía hay campos obligatorios Vacíos.')); 
                }
                else
                {
                     ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'El nombre de usuario o contraseña no coinciden')); 
                }
            }
            else
            {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Lo sentimos no puedes utilizar este nombre de usuario')); 
                
                
            }
        }
        catch (Exception ex)
        {
             ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 
                        'Lo sentimos, hubo un error intentelo nuevamente')); 
            system.debug(ex.getLineNumber()+'  '+ex.getMessage());
        }
    }
    public void Desbloqueo()
    {
        desbloquearOtroPregunta=true;
        UsuarioNuevo.Otra_pregunta__c='';
       if(id_pregunta==idotros)
        {
           desbloquearOtroPregunta=false; 
        }
    }
     public boolean validarContrasenias(){
        
        //Verificar que la contraseña tiene al menos un dígito, una mayúscula una minúscula y un carácter especial
        contrasenia=reconfirmarcontrasenia2;
        if(contrasenia.length() >= 8){
            Integer num = contrasenia.length();        
            if(!pattern.matches('((?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{'+ num +'})', contrasenia) || !pattern.matches('((?=.*[@#$%])(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{' + num + '})', contrasenia)
                || !pattern.matches('((?=.*\\d)(?=.*[a-z])(?=.*[@#$%])(?=.*[A-Z]).{' + num + '})', contrasenia) ){
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
    public PageReference Salir()
    {
        MostrarModal=false; 
         return new PageReference (claseutil.urlSysde('Empresarial'));
    }
    
         
    
}