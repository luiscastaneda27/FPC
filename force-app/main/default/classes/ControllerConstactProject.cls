public class ControllerConstactProject {
    
    //public  List<Correo_Personas_Sin_Aportar__c> listRepetidos {get;set;}
    //public  List<Correo_Personas_Sin_Aportar_Temp__c> ListaTempRetiros  {get;set;}
    public static List<Correo_Personas_Sin_Aportar_Temp__c> ListaFinalCorreo {get;set;}
    public  List<Correo_Personas_Sin_Aportar_Temp__c> ListaFinalRepetido {get;set;}
    public list<string> Cod_ClienteTemp = new  list<string>();
    //public list<string> TempA = new  list<string>();
    public list<ControllerAPIConstanct.classCorreosAniversario> resultado = new list<ControllerAPIConstanct.classCorreosAniversario>();
    public string fechaIn {get; set;}  
    public string FechaDia {get; set;}  
    public date hoy {get; set;}  
    public date FechaInclusion {get; set;}  
    public list<Cuentas__C> ListAniver = new  list<Cuentas__C>();
    
  	@future(callout=true)
    public static void EnvioCorreoMujeresAniversario()
    {			
        try{
            list<ControllerAPIConstanct.classCorreosAniversario> resultado = new list<ControllerAPIConstanct.classCorreosAniversario>();
       		resultado = ControllerAPIConstanct.GetCorreosAniversarioF();
            system.debug('listado de correos: '+resultado);
        	OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];  
        	Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
        	if (resultado.size() > 0)
            {
            	for(integer i=0; i<resultado.size(); i++)
                {
                	if((resultado[i].V_FO_Correo != '@' || resultado[i].V_FO_Correo != 'NOTIENE@.HN'))
                    {
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setHtmlBody( 
                                           '<img src="https://ficohsafpc--pensiones--c.cs77.content.force.com/servlet/servlet.ImageServer?id=0150t0000009TTD&oid=00D0t000000Cogc&lastMod=1531428570000" WIDTH=700 HEIGHT=900/>'
                                        );
                        mail.setSubject('Te felicitamos por pensar en tu futuro Estimad@ '+  resultado[i].V_NOMBRE + ' ' + resultado[i].V_APELLIDO);
                        //String[] toAddresses = new String[] {'wendy.alvarado@ficohsa.com'};
                		//mail.setToAddresses(toAddresses);
                		//resultado[i].V_FO_Correo='wendy.alvarado@ficohsa.com';
                        mail.setToAddresses(new String[] {resultado[i].V_FO_Correo});
                        mail.setOrgWideEmailAddressId(owea.get(0).Id);
                        mail.setSaveAsActivity(true);
                        listCorreo.add(mail);
                    }
               	}
                Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
                system.debug('Correos enviados correctamente: '+results);
                system.debug('ListaCorreoAenviar' + listCorreo);
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Envio de correo automatico'));
           }
        }
        catch(exception ex)
        {
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
    }
    
    @future(callout=true)
    public static void EnvioCorreoHombresAniversario()
    {
        try{
            //1) API 
            //Si la API no retorna correos que no envie el email
            list<ControllerAPIConstanct.classCorreosAniversario> resultado = new list<ControllerAPIConstanct.classCorreosAniversario>();
            resultado = ControllerAPIConstanct.GetCorreosAniversarioM();
            system.debug('listado de correos: '+resultado);
            
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];  
            Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
            if (resultado.size() > 0)
            {
                for(integer i=0; i<resultado.size(); i++)
                {
                    if((resultado[i].V_FO_Correo != '@' || resultado[i].V_FO_Correo != 'NOTIENE@.HN'))
                    {
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
                        mail.setHtmlBody( 
                            '<img src="https://ficohsafpc--pensiones--c.cs77.content.force.com/servlet/servlet.ImageServer?id=0150t0000009TTD&oid=00D0t000000Cogc&lastMod=1531428570000" WIDTH=700 HEIGHT=900/>'
                        );
                        mail.setSubject('Te felicitamos por pensar en tu futuro Estimad@ '+  resultado[i].V_NOMBRE + ' ' + resultado[i].V_APELLIDO);
                        //resultado[i].V_FO_Correo='wendy.alvarado@ficohsa.com';
                        mail.setToAddresses(new String[] {resultado[i].V_FO_Correo});
                        mail.setOrgWideEmailAddressId(owea.get(0).Id);
                        mail.setSaveAsActivity(true);
                        listCorreo.add(mail);
                     }
                }
              	Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
              	system.debug('Correos enviados correctamente: '+results);
              	system.debug('ListaCorreoAenviar' + listCorreo);
              	//ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Envio de correo automatico'));
         	}
        }
        catch(exception ex)
        {
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
	}
    
    /*Envio de correos a las personas que hacen su primer aporte*/
    @future (callout = true)
    public static void EnvioCorreoBienvenida()
    {
        try{
            String queryCorreo = 'Select Cuerpo__c From ConstanContact__mdt Where DeveloperName = '; 
                queryCorreo += '\'CartaBienvenida\'';
                ConstanContact__mdt cuerpoCorreo = dataBase.query(queryCorreo);
                String cuerpo = cuerpoCorreo.Cuerpo__c;
            
            list<ControllerAPIConstanct.classCorreosAniversario> resultado = new list<ControllerAPIConstanct.classCorreosAniversario>();
       		resultado = ControllerAPIConstanct.GetCorreosKitBienvenida();
            system.debug('listado de correos: '+resultado);
        	OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];  
        	Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
            for(integer i=0; i<resultado.size(); i++){
                String nombre = resultado[i].V_NOMBRE + ' ' + resultado[i].V_APELLIDO;
                String correo = resultado[i].V_FO_Correo;
                if((correo != '@' || correo != 'NOTIENE@.HN'))  {
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    String body = cuerpo.replace('[getDestinatario]', nombre);
                    mail.setHtmlBody(body);
                    mail.setSubject('Te felicitamos por pensar en tu futuro '+ nombre);
                    //resultado[i].V_FO_Correo='wendy.alvarado@ficohsa.com';
                    mail.setToAddresses(new String[] {correo});
                    mail.setOrgWideEmailAddressId(owea[0].Id);
                    mail.setSaveAsActivity(true);
                    listCorreo.add(mail);
                }
            }
            Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
            system.debug('Correos enviados correctamente: '+results);
            system.debug('ListaCorreoAenviar' + listCorreo);
        }
        catch(exception ex)
        {
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
    }
    
    /*Metodos para enviar correos a persona que tienen mas de 6 meses sin aportar
      - Swe dividen en tres procesos el cual estan numerados en 1 ,2 , 3 y en ese orden se tiene que ejecutar los JOBS
    
    public void llamarmetodoHombres()
    {
         ControllerAPIConstanct.GetCorreoSinAportarMesesHombres();
     }
    
    public void EnvioCorreosSinAportHombresProceso2()
    {
         
         Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
  	   
         /*
		    1) Esta parte se hara manual y sera con envios de 500 correos 
			2) LIMIT 100 = Limit es para decir a la lista que traiga solo 100 datos del total 
		    3) OFFSET 100 = Es para decirle que se salte las primeras 100 del objeto y empiece en un numero dado
			4) Se haran envio de 500 hasta llegar al total que contenga el objeto en el primer envio
			5) No se verifican los repetidos en el primer envio masivo ya a que ningun cliente se le han mandado los correos 
		 
         ListaFinalCorreo = [select Codigo_Cliente__c, Correo_Temp__c,Nombre__c
                             from Correo_Personas_Sin_Aportar_Temp__c ORDER BY Codigo_Cliente__c LIMIT 500 OFFSET 1 ];
         
       if (ListaFinalCorreo.size() > 0)
       {	
                   
                    
            	  	for(integer aa=0; aa<ListaFinalCorreo.size(); aa++)
                	{
                              Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();              
                              mail.setToAddresses(new String[] {ListaFinalCorreo[aa].Correo_Temp__c});
                              mail.setSenderDisplayName('FICOHSA PENSIONES Y CESANTIAS');
                              mail.setSubject('Logra tu pensión soñada aportando hoy' + '' + +' Estimad@'+  ListaFinalCorreo[aa].Nombre__c );    
                              mail.setHtmlBody( 
                                                 '<img src="https://c.cs77.content.force.com/servlet/servlet.ImageServer?id=0150t0000009TTD&oid=00D0t000000Cogc&lastMod=1531428570000" WIDTH=700 HEIGHT=900/>'
                                              );
                              
                              listCorreo.add(mail);    
            		    }
                    
                   //system.debug('ListaCorreos' + listCorreo);
                    
                    
         } //Lista Final Correo  
 
        //Messaging.sendEmail(listCorreo);
     }
    
    public void EnvioCorreosSinAportHombresProceso3()
    {
          ListaFinalCorreo = [select Codigo_Cliente__c, Correo_Temp__c,Nombre__c
                                    from Correo_Personas_Sin_Aportar_Temp__c ];
         if(ListaFinalCorreo.size() > 0 )
         {
               list<Correo_Personas_Sin_Aportar__c> EstadoCu = new list<Correo_Personas_Sin_Aportar__c>();
               Correo_Personas_Sin_Aportar__c listC;
                    
                    for(integer aa=0; aa<ListaFinalCorreo.size(); aa++)
                    {   		
                                  listc = new Correo_Personas_Sin_Aportar__c();    
                                  listc.Codigo_Cliente__c = ListaFinalCorreo[aa].Codigo_Cliente__c;
                                  listc.Correo__c = ListaFinalCorreo[aa].Correo_Temp__c;
                                  listc.Nombre__c = ListaFinalCorreo[aa].Nombre__c;
                        		  listc.Fecha_Inclusion__c = date.today();
                                  EstadoCu.add(listc);
                                               
                    } //Fin del for principal 
             
                    insert EstadoCu;
             
              
         }
         
     }
    
    /*Metodos para enviar correos a persona que tienen mas de 6 meses sin aportar
      - Swe dividen en tres procesos el cual estan numerados en 1 ,2 , 3 y en ese orden se tiene que ejecutar los JOBS
    
    public static void llamarmetodoMujeres()
    {
         ControllerAPIConstanct.GetCorreoSinAportarMesesMujeres();
     }
    
    /*
    public void EliminarRepetidos()
     {
         ListaFinalCorreo = [select Codigo_Cliente__c
                                    from Correo_Personas_Sin_Aportar_Temp__c LIMIT 50 OFFSET 1];
         
         ListaFinalRepetido = [select Codigo_Cliente__c
                                    from Correo_Personas_Sin_Aportar_Temp__c LIMIT 50 OFFSET 1];

          for(integer i=0;i<ListaFinalCorreo.size();i++) 
          {
             
              Correo_Personas_Sin_Aportar_Temp__c Princi = ListaFinalCorreo.get(i);

              
             for(integer j=(i+1);j<ListaFinalRepetido.size();j++)
             {
    			 Correo_Personas_Sin_Aportar_Temp__c Repe = ListaFinalRepetido.get(j);
                 
                 if( Princi.Codigo_Cliente__c == Repe.Codigo_Cliente__c && i!=j) 
                 {
                     ListaFinalRepetido.remove(j); 
                     //system.debug('REMOVED::'+j);  
                 }
             }
         }
     }
    
    public static void EnvioCorreosSinAportMujeresProceso2()
    {
         
         Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
  	   
         /*
		    1) Esta parte se hara manual y sera con envios de 500 correos 
			2) LIMIT 100 = Limit es para decir a la lista que traiga solo 100 datos del total 
		    3) OFFSET 100 = Es para decirle que se salte las primeras 100 del objeto y empiece en un numero dado
			4) Se haran envio de 500 hasta llegar al total que contenga el objeto en el primer envio
			5) No se verifican los repetidos en el primer envio masivo ya a que ningun cliente se le han mandado los correos 
		  
         ListaFinalCorreo = [select Codigo_Cliente__c, Correo_Temp__c,Nombre__c
                             from Correo_Personas_Sin_Aportar_Temp__c ORDER BY Codigo_Cliente__c LIMIT 1 OFFSET 1 ];
         
        if (ListaFinalCorreo.size() > 0)
        {
                   
                    
            	  	for(integer aa=0; aa<ListaFinalCorreo.size(); aa++)
                	{
                              Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
                              //String[] toAddresses = new String[] {pcmail};              
                			  String[] toAddresses = new String[] {'wendy.alvarado@ficohsa.com'};
                              mail.setToAddresses(toAddresses);
                              //mail.setToAddresses(new String[] {ListaFinalCorreo[aa].Correo_Temp__c});
                              mail.setSenderDisplayName('FICOHSA PENSIONES Y CESANTIAS');
                              mail.setSubject('Comienza hoy a construir tu futuro' + '' + +' Estimad@ '+  ListaFinalCorreo[aa].Nombre__c );    
                              mail.setHtmlBody( 
                                                 //'<img src="https://c.cs77.content.force.com/servlet/servlet.ImageServer?id=0150t0000009TTD&oid=00D0t000000Cogc&lastMod=1531428570000" WIDTH=700 HEIGHT=900/>'
                                              '<img src="https://ficohsafpc--pensiones--c.cs77.visual.force.com/resource/1547767201000/arteAportes" WIDTH=700 HEIGHT=1000/>'
                              );
                        
                        
                mail.setSaveAsActivity(true);
                listCorreo.add(mail);
                Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
           		system.debug('Correos enviados correctamente: '+results);
        		system.debug('Email:'+' EnvioCorreo:'+listCorreo);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Envio de correo automatico'));
                              
                              //listCorreo.add(mail);    
            		    }
                    
                   //system.debug('ListaCorreos' + listCorreo);
                    
                    
         } //Lista Final Correo  
 
        //Messaging.sendEmail(listCorreo);
     }
    
    public void EnvioCorreosSinAportMujeresProceso3()
    {
          ListaFinalCorreo = [select Codigo_Cliente__c, Correo_Temp__c,Nombre__c
                                    from Correo_Personas_Sin_Aportar_Temp__c ORDER BY Codigo_Cliente__c LIMIT 1 OFFSET 1];
         if(ListaFinalCorreo.size() > 0 )
         {
               list<Correo_Personas_Sin_Aportar__c> EstadoCu = new list<Correo_Personas_Sin_Aportar__c>();
               Correo_Personas_Sin_Aportar__c listC;
                    
                    for(integer aa=0; aa<ListaFinalCorreo.size(); aa++)
                    {   		
                                  listc = new Correo_Personas_Sin_Aportar__c();    
                                  listc.Codigo_Cliente__c = ListaFinalCorreo[aa].Codigo_Cliente__c;
                                  listc.Correo__c = ListaFinalCorreo[aa].Correo_Temp__c;
                                  listc.Nombre__c = ListaFinalCorreo[aa].Nombre__c;
                        		  listc.Fecha_Inclusion__c = date.today();
                                  EstadoCu.add(listc);
                                               
                    } //Fin del for principal 
             
                    insert EstadoCu;
             
              
         }
         
     }
    
    /*ENVIO DE CORREO A TODAS LAS PERSONAS CON TOTALES  
    public void EnvioCorreoRetiroTotal()
    {			
             
                //1) API 
        		//Si la API no retorna correos que no envie el email
        		 list<ControllerAPIConstanct.classCorreosAniversario> resultado = new list<ControllerAPIConstanct.classCorreosAniversario>();
        		 Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
     
                 resultado = ControllerAPIConstanct.GetCorreosRetirosTotales();
        		
        		if (resultado.size() > 0)
                {
                   for(integer i=0; i<resultado.size(); i++)
                   {
                    if(resultado[i].V_FO_Correo != '@' || resultado[i].V_FO_Correo != 'NOTIENE@.HN')
                    {
						
                        
						      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
                              //Linea 56 es la lista donde se agrega todos los correos
                              
                              mail.setToAddresses(new String[] {resultado[i].V_FO_Correo});
                              mail.setSenderDisplayName('FICOHSA PENSIONES Y CESANTIAS');
                              mail.setSubject('Bienvenido a Ficohsa Pensiones' + '' + +' Estimad@'+  resultado[i].V_NOMBRE + ' ' + resultado[i].V_APELLIDO);    
                              mail.setHtmlBody( 
                                                 '<img src="https://c.cs77.content.force.com/servlet/servlet.ImageServer?id=0150t0000009TTD&oid=00D0t000000Cogc&lastMod=1531428570000" WIDTH=700 HEIGHT=900/>'
                                              );
                              //Lista para almacenar toda la informacion.
                              listCorreo.add(mail);    
                    
                       
                      
                    }
                    
                }
                    system.debug('ListaCorreoAenviar' + listCorreo);
                    /*
                    try {
                          Messaging.reserveSingleEmailCapacity(listCorreo.size());
                          Messaging.sendEmail(listCorreo); 
                        }
                        catch(Exception ex) {
                          // handle exception
                        }
                    
              	   //system.debug('ListaCorreoAenviar' + listCorreo);
                   //Envio de todos los mensajes 
		      	   //Messaging.sendEmail(listCorreo);  
                }
                             
        	
    }
    
    public void eliminarCorreoTemp()
    {
           delete  ([select id 
                     from Correo_Personas_Sin_Aportar_Temp__c]);
    }
  
    public void eliminarCorreoPrincipal()
    {
           delete  ([select id 
                     from Correo_Personas_Sin_Aportar__c]);
    }
     
    /*Prueba de envio despues de pasar 6 meses despues del primer envio*/
    /*
    public void envioDespues6Meses()
    {
        listRepetidos = [select Codigo_Cliente__c, Fecha_Inclusion__c
                             from Correo_Personas_Sin_Aportar__c ];
   
		list<string> CodCliente = new  list<string>(); 
        Date hoy = date.today();  
        
        integer dias;
        for(integer i=0; i<listRepetidos.size(); i++)
        {
              dias = hoy.daysBetween(listRepetidos[i].Fecha_Inclusion__c);
              if (dias == -180 || dias == -540 || dias == -720 || dias == -900 || dias == -1080
                 || dias == -1260 || dias == -1440 || dias == -1620 || dias == -1800 || dias == -1980 
                 || dias == -2160 || dias == -2340 || dias == -2520 || dias == -2700 || dias == -2880 )
              {
                 CodCliente.add(listRepetidos[i].Codigo_Cliente__c); 
              }
              
        }
        
        system.debug('DiasFecha' + CodCliente);
        
        
    }
    
    
    //Envio de correo individual para pruebas nada mas 
    public void EnvioCorreoAniversario()
    {
        hoy = date.today();
        
         Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
       
            map<string, integer> Bandera= new map<string, integer>();
            list<Account> clientes = new list<Account>();
            for(ACCOUNT item:[SELECT Fecha_de_Ingreso_FPC__c, Name, Correo_actual__c, Identificacion__c, PersonContactId
                                  FROM ACCOUNT
                                  WHERE Fecha_de_Ingreso_FPC__c	 =: HOY and
                                        Activo__c = true and  
                                        Correo_actual__c != null])
            {
                if(!Bandera.containsKey(item.Identificacion__c))
                {
                    clientes.add(new Account(name = item.Name, Correo_actual__c = item.Correo_actual__c));
                    bandera.put(item.identificacion__c, 3);
                }
            }
        
        
          SYSTEM.debug('ListaAniversarioClientes' + clientes);
        
          if(!clientes.isEmpty())
          {
                EmailTemplate Emailtemplate=[SELECT ID FROM EmailTemplate where DeveloperName =:'Aniversario_HTMLN'];
                OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@grupoficohsa.hn'];

                for(Account item : clientes)
                {
                   String[] toAddresses = new String[] {item.Correo_actual__c};
                   
                   Messaging.singleEmailMessage correo = new Messaging.singleEmailMessage();            
                   correo.setTemplateId(Emailtemplate.id);  
                   correo.saveAsActivity = false;    
                   correo.setTreatTargetObjectAsRecipient(false); 
                   correo.setToAddresses(toAddresses);
                   correo.setSubject('Te felicitamos por pensar en tu futuro' + '' + +' Estimad@ '+  item.Name );            
                   correo.setTargetObjectId(item.PersonContactId);
                   correo.setOrgWideEmailAddressId(owea.get(0).Id);
                   listCorreo.add(correo);              
                }
                 
					SYSTEM.debug('clientes' + listCorreo);
                    
                 //Estas lineas comentadas son para que se envie el correo
                 //Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo);
        
 	     }		    
    }*/
}