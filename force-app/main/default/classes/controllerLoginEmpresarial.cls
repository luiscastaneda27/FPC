public class controllerLoginEmpresarial {
  public String Contrasena {get; set;}
    public String usuario {get; set;}
    public string Cambiousuario {get; set;}
    public boolean ActivarModal {get; set;}
     public String TextoBoton {get; set;}
    public integer anio{get; set;}

    public controllerLoginEmpresarial(){
        salir();
        anio=date.today().year();
    }    
    public void olvide()
    {
        ActivarModal=true;        
    }
    public void salir()
    {
        TextoBoton='CONTINUAR';
        ActivarModal=false;
    }
    
    Public void cambiarclave()
    {
        try {
           if(TextoBoton=='CONTINUAR')
           {
            Usuario_Portal_Empresarial__c user = [Select email__c,name,id 
    												From Usuario_Portal_Empresarial__c 
    												Where Nombre_usuario__c=:Cambiousuario];
        	            
                string contra = '';
                integer o;
            
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
                
             
               
               List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
    
      list<correos__c> correos = new list<Correos__C>();
       correos =[select correo__c,name from correos__C where cargo__c='Compra de Dolar'];
       String queryCorreo = 'Select Cuerpo__c From Correo_EDC__mdt Where DeveloperName = \'correoGeneral\'';
	   Correo_EDC__mdt cuerpoCorreo = dataBase.query(queryCorreo);
        String cuerpo = cuerpoCorreo.Cuerpo__c;
		OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];
		          cuerpo = cuerpoCorreo.Cuerpo__c;
          string asunto = 'Hemos recibido una solicitud para cambio de contraseña de tu Sucursal Electrónica de Ficohsa Pensiones y Cesantías. <br/><br/>' +
                    					'Tu nueva contraseña es: ' +contra + '<br/><br/> Si tú no solicitaste un cambio de contraseña, favor escríbenos a ficohsapensiones@ficohsa.com.<br/><br/>Saludos cordiales,';
               cuerpo = cuerpo.replace('[getAsunto]', asunto);
            	cuerpo = cuerpo.replace('[getName]', User.Name);
             
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {user.email__C});
                    mail.setSubject('Recuperación de Clave Portal Empresarial Ficohsa.');
                    mail.setHtmlBody(cuerpo);
                    mail.setOrgWideEmailAddressId(owea.get(0).Id);
            		MessageList.add(mail); 
           
          Messaging.sendEmail(MessageList);
                user.Contrasena2__c=contra;
                update user;               
                TextoBoton='Salir';
               Cambiousuario='';
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'¡Se ha enviado un correo electrónico al usuario!'));
           }
           else
           {
               ActivarModal=false;
           }
        }
        catch(exception ex)
        {
        		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'¡Usuario no encontrado!'+ ex.getMessage()));  	   
        }
    }
    
       
	public pageReference sesionIniciada(){
        try{
            if(usuario!=null && contrasena!=null)
            {
                Usuario_Portal_Empresarial__c usuario2 =[select Contrasena2__c, bloqueado__C from Usuario_Portal_Empresarial__c where Nombre_Usuario__c =:usuario];                
                       //vefificacion del usuario y conreasenia                       
               		if(usuario2.Contrasena2__c == contrasena)
                    {
                             //vefificacion del usuario activo
                        	integer u =[select count() from Usuario_X_Empresa__c where Usuario__c =: usuario2.id and activo__c=true];
                            if(u>0)
                        		{
                                    if(!usuario2.Bloqueado__c)
                                    {
                                     	 Bitacora_Login__c Intentos_Logrado = new Bitacora_Login__c ();
                                        Intentos_Logrado.Usuario__c=usuario2.id;
                                        Intentos_Logrado.Fecha__c= datetime.now();
                                        Intentos_Logrado.Ingreso_Logrado__c=true;
                                        insert Intentos_Logrado; 
                                        
                                        Tiempo_Inactividad__c h= new Tiempo_Inactividad__c();    
                                        u= [select count() from Tiempo_Inactividad__c where usuario__C=:usuario2.id];  
                                        if(u==0){
                                            h.Usuario__c=usuario2.id;
                                            h.Hora_ultima_consulta__c=datetime.now();
                                            insert h;
                                        }else {
                                            h=[select id, usuario__C from Tiempo_Inactividad__c where usuario__C=:usuario2.id];
                                            h.Hora_ultima_consulta__c=datetime.now();
                                            update h;
                                        }
                                        asysdeportalempresarial.traertasacambio();
                                        return new pageReference('/Apex/vfMenuPrincipalPlanillas?loetdncdhjch=' + usuario2.id +'&MPojknjsdj=0');   
                                        }
                                        else
                                        {
                                           ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Usuario Bloqueado.')); 
                                        }
                                                                   
                            }
                            else{
                                  ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Usuario Inactivo.'));
                            }                      
                        
                      }
                      else
                      {
                        Bitacora_Login__c Intentos_Fallidos = new Bitacora_Login__c ();
                        Intentos_Fallidos.Usuario__c = usuario2.id; //new Usuario_Portal_Empresarial__c(Nombre_Usuario__c=usuario);
                        Intentos_Fallidos.Fecha__c=date.today();
				        Intentos_Fallidos.Ingreso_Logrado__c=false;
                        insert Intentos_Fallidos;
                          integer yu=0;
                        for(Bitacora_Login__c item:[select Ingreso_Logrado__c from Bitacora_Login__c where Usuario__c =:usuario2.id   order by createddate desc limit 3])
                        {
                            if(!item.Ingreso_Logrado__c)
                            {
                              yu++;  
                            }
                        }
						
                        if(yu>2)
                        {
                            usuario2.bloqueado__C=true;
                            update usuario2;                                         
                        } 
                         // usuario2 = new Usuario_Portal_Empresarial__c();
                        // usuario2 =[select Contrasena2__c, bloqueado__C from Usuario_Portal_Empresarial__c where Nombre_Usuario__c =:usuario];
                        if(usuario2.Bloqueado__c)
                        {
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Usuario Bloqueado.'));
                        }
                          else
                          {
                             ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El usuario o contraseña ingresados no son correctos.')); 
                          }
                        
                       
                       }                  
            }else
              {
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Usuario o Contraseña Vacío.')); 
              }
                        
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Usuario o Contraseña no válidos.'));   
        }
        return null;
    }
    
    
   
}