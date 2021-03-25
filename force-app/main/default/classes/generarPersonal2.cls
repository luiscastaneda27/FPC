public class generarPersonal2 {
    public Account empleado{get;set;}    
    public list<Empresa_x_Empleado__c> listEmpleados{get;set;}
    public list<Empresa_x_Empleado__c> MlistEmpleados{get;set;}
    public Empresa_x_Empleado__c empleadoEmpresa{get;set;}
    public Usuario_X_Empresa__c usuarioEmpresa{get;set;} 
    public boolean popAgregar{get;set;}
    public boolean popModificar{get;set;}
    public integer banderaTiempo{get;set;}
    public Empresa_x_Empleado__c ModificarEmpleado{get;set;}
    public boolean popquitar{get;set;}
    public string idEmpleado{get;set;}
    public string nombre{get;set;}
    public string apellido{get;set;}
    list<classAfiliacion> claseEnvio;
    public integer banderasysde;
    public integer totalempleados{get;set;}
    public boolean mostrarcolumnas {get;set;}
    public string TextoBoton{get;set;}
    public string Num_Identidad{get;set;} 
    // listas para la modificacion de empleados
    public list<SelectOption> listTipoIdentificacion{get;set;}
     public list<SelectOption> listgenero{get;set;}
     public list<SelectOption> listestadoCivil{get;set;}
    public list<SelectOption> listmoneda{get;set;}
    public boolean mostrarModificar{get;set;}
    public boolean mostrarBuscar{get;set;}
    public decimal total{get;set;}
    
    public string textoBusqueda{get;set;}
    public string textoboton2{get;set;}
    public list<Empresa_x_Empleado__c> listEmpleadosTemporales{get;set;}
    public list<Empresa_x_Empleado__c> listEmpleadosalmacenados{get;set;}
    public Empresa_x_Empleado__c empleadoE{get;set;}
    
    String Codigo_Unico_Banco;
    String Usuario;
    String tipoNatural = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
    public boolean esEdicion;
    
    
    public list<SelectOption> aportaciones{get;set;}
    public string tipoaportacion{get;set;}
    
    //PAGINACIÓN 
    public boolean mostrarSiguiente{get;set;}
    public boolean mostrarANterior{get;set;}
    public boolean mostrarBotonesP{get;set;}
    integer contadorpaginacion;
    
    
    
    
    public generarPersonal2(){
    		try{ 
	    		Codigo_Unico_Banco = ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
		    Usuario = ApexPages.currentPage().getParameters().get('loetdncdhjch'); 
		    
		    usuarioEmpresa = [select Empresa2__r.Name, Usuario__r.Name, Nuevo_Personal__c 
		    							From Usuario_X_Empresa__c 
									where Empresa2__c =: Codigo_Unico_Banco
									AND Usuario__c =: Usuario Limit 1];
		        banderasysde=0;
                banderatiempo=0;
	    		iniciar();
    		}Catch(Exception e){
    			ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Se ha producido un error, favor contacte a su administrador')); 	
    		}	
    }
    public void registrarTiempo()
    {
        try
        {
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
        }
        catch(Exception ex)
        {
            
        }
    }
    public void iniciar(){
    		try{
	    		empleado = new Account();
                mostrarcolumnas=true;
	    		empleado.recordTypeId = tipoNatural;
	    		esEdicion = False;
	    		popAgregar = False;
	    		nombre = '';
	    		apellido = '';
	    		mostrarBuscar= false;
	    		
                    listEmpleados = [Select Empleado2__r.Firstname, Empleado2__r.Lastname, Empleado2__c,
                                    Empleado2__r.Tipo_Identificacion__c, Empleado2__r.Identificacion__c, Empleado2__r.Estado_Civil__pc, 
                                    Empleado2__r.Sexo__c, Empleado2__r.PersonBirthDate, Motivo_Despido__c, Fecha_despido__c,
                                    Empleado2__r.isPersonAccount, Estado__c, Salario__c, CurrencyIsoCode
                                    From Empresa_x_Empleado__c
                                    Where Empresa2__c =: Codigo_Unico_Banco and estado__C !='Despedido' order by Empleado2__r.Firstname asc limit 2300];
                for(integer i=0; i<listEmpleados.size(); i++)
                {
                    string genero=listEmpleados[i].Empleado2__r.Sexo__c;
                    IF(genero !=null)
                    {
                        if(genero.toUpperCase()=='1' || genero.toUpperCase()=='M' || genero.toUpperCase()=='MASCULINO')
                        {
                           listEmpleados[i].Empleado2__r.Sexo__c= 'MASCULINO';
                        }
                        ELSE
                        {
                            listEmpleados[i].Empleado2__r.Sexo__c= 'FEMENINO';
                        }
                    }
                    string estadoCivil=listEmpleados[i].Empleado2__r.estado_civil__pC;
                    IF(estadoCivil !=null)
                    {
                        if(estadoCivil.toUpperCase()=='U')
                        {
                           listEmpleados[i].Empleado2__r.estado_civil__pC= 'UNIÓN LIBRE';
                        }
                        ELSE if (estadoCivil.toUpperCase()=='C')
                        {
                            listEmpleados[i].Empleado2__r.estado_civil__pC= 'CASADO';
                        }
                        ELSE if (estadoCivil.toUpperCase()=='S')
                        {
                            listEmpleados[i].Empleado2__r.estado_civil__pC= 'SOLTERO';
                        }
                        ELSE if (estadoCivil.toUpperCase()=='D')
                        {
                            listEmpleados[i].Empleado2__r.estado_civil__pC= 'DIVORCIADO';
                        }
                        ELSE if (estadoCivil.toUpperCase()=='V')
                        {
                            listEmpleados[i].Empleado2__r.estado_civil__pC= 'VIUDO';
                        }
                    }
                    
                }
                   totalempleados=[Select count() From Empresa_x_Empleado__c
                                    Where Empresa2__c =: Codigo_Unico_Banco and estado__C !='Despedido'];
                	total=0;
                    for(integer i=0; i<listempleados.size(); i++)
                    {
                        total +=listempleados[i].salario__c;
                    }
               list<cuentas_colectivas__C> gtt = new list<cuentas_colectivas__C>();
           gtt = [select tipo_cuenta__C from cuentas_colectivas__c where empresa__C=:Codigo_Unico_Banco];
           integer volun=0;
           integer obli=0;
           aportaciones = new  list<SelectOption>();
           for(integer i=0; i<gtt.size(); i++)
           {
               if(gtt[i].tipo_cuenta__C=='Voluntarias' && volun==0)
               {
                   volun =1;
                   aportaciones.add(new SelectOption('Voluntarias','Voluntarias'));
               }
               if(gtt[i].tipo_cuenta__C=='Pilar Complementario' && obli==0)
               {
                   obli =1;
                   aportaciones.add(new SelectOption('Obligatorios','Obligatorios'));
               }
               if(gtt[i].tipo_cuenta__C=='Censatías' && obli==0)
               {
                   obli =1;
                   aportaciones.add(new SelectOption('Obligatorios','Obligatorios'));
               }
               
               
           }
           if(obli==1 && volun ==1)
          {
                aportaciones.add(new SelectOption('Ambas','Ambas'));
          }
               TextoBoton='Reporte Ex-Empleados';
               Textoboton2='Buscar';
                
                
                //PAginaciones
             mostrarBotonesp=false;
             mostrarAnterior=true;
             mostrarSiguiente=true;
            MlistEmpleados = new list<Empresa_x_Empleado__c>();
            contadorpaginacion=0;
            if(listEmpleados.size()>100)
           {
                contadorpaginacion ++;
               	mostrarBotonesp=true;
                mostrarSiguiente=false;
                for(integer i=0; i<100; i++)
                {
                    
                    MlistEmpleados.add(listEmpleados[i]);
                }
           }
           else
           {
              for(integer i=0; i<listEmpleados.size(); i++)
                {
                    
                    MlistEmpleados.add(listEmpleados[i]);
                } 
           } 
           Enviarasysde(); 
                
               
    		}Catch(Exception e){
    			ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Se ha producido un error, favor contacte a su administrador'+E.getLineNumber())); 			
    		} 		
    }
    public void siguiente() 
    {
        try{
            if(banderaTiempo==0)
        	{
            	registrarTiempo();
        	}
            if((contadorpaginacion + 1)*100 > listEmpleados.size())
            {
                contadorpaginacion ++;
                MlistEmpleados = new list<Empresa_x_Empleado__c>();
                mostrarSiguiente=true;
                mostraranterior=false;
                 for(integer i=(contadorpaginacion - 1)*100; i<listEmpleados.size(); i++)
                {
                   
                    MlistEmpleados.add(listEmpleados[i]);
                } 
                
                
            }
            else
            {
                 mostraranterior=false;
                 contadorpaginacion ++;
                MlistEmpleados = new list<Empresa_x_Empleado__c>();
                 for(integer i=(contadorpaginacion - 1)*100; i<contadorpaginacion*100; i++)
                {
                   MlistEmpleados.add(listEmpleados[i]);
                } 
            }
            
        }
        catch(exception ex)
        {
            
        }
    }
    
    public void anterior()
    {
        try 
        {
            //usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
           if(banderaTiempo==0)
        	{
            	registrarTiempo();
        	}
            if((contadorpaginacion - 1)*100 < 101)
            {
                mostrarsiguiente=false;
                mostrarAnterior=true;
                MlistEmpleados = new list<Empresa_x_Empleado__c>();
                for(integer i=0; i<100; i++)
                {
                    MlistEmpleados.add(listEmpleados[i]);
                } 
                contadorpaginacion --;
            }
            else
            {
                MlistEmpleados = new list<Empresa_x_Empleado__c>();
               for(integer i=(contadorpaginacion - 2)*100; i<(contadorpaginacion-1) *100; i++)
                {
                    MlistEmpleados.add(listEmpleados[i]);
                }  
                contadorpaginacion --;
                 mostrarSiguiente=false;
            }
        }
        catch(Exception ex)
        {
            
        }
    }
    
    public void mostrarNuevo(){
        if(banderaTiempo==0)
        	{
            	registrarTiempo();
        	}
    		popAgregar = true;
        	empleadoEmpresa = new Empresa_x_Empleado__c(); 
    }
    
    
    private account emModi;
    
    public void editar(){
    		try{
               if(banderaTiempo==0)
        	{
            	registrarTiempo();
        	}
    			emModi = [Select Firstname, Lastname, Tipo_Identificacion__c, Identificacion__c,Estado_Civil__pc, Sexo__c,
    							isPersonAccount,PersonBirthdate, Estado__c
	    						From Account
	    						Where Id =: idEmpleado];
	    		
	    		
                    ModificarEmpleado = new Empresa_x_Empleado__c();
                    mostrarModificar=true;
                    modificarEmpleado =[Select Salario__c, id ,currencyIsoCode, Empleado2__r.Firstname, Empleado2__r.Lastname,
                                        Empleado2__r.Tipo_Identificacion__c, Empleado2__r.Identificacion__c,
                                        Empleado2__r.Estado_Civil__pc, Empleado2__r.Sexo__c,
    							Empleado2__r.isPersonAccount, Empleado2__r.PersonBirthdate, Empleado2__r.Estado__c
	    						From Empresa_x_Empleado__c
	    						Where Empleado2__c =: idEmpleado AND Empresa2__c =: Codigo_Unico_Banco];
                 listTipoIdentificacion = new list<SelectOption> ();
                 listTipoIdentificacion.add(new SelectOption(modificarEmpleado.Empleado2__r.Tipo_Identificacion__c, modificarEmpleado.Empleado2__r.Tipo_Identificacion__c));
                 listgenero =new list<SelectOption> ();
                 listmoneda =new list<SelectOption> ();
                 listmoneda.add(new SelectOption(modificarEmpleado.currencyIsoCode, modificarEmpleado.currencyIsoCode));
                 listgenero.add(new SelectOption(modificarEmpleado.Empleado2__r.Sexo__c, modificarEmpleado.Empleado2__r.Sexo__c));
                 listestadoCivil =new list<SelectOption> ();
                 //listestadoCivil.add(new SelectOption(modificarEmpleado.Empleado2__r.Estado__c, modificarEmpleado.Empleado2__r.Estado__c));
                 popmodificar=true;
	    			//ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'No puedes modificar datos de empleados afiliados'));	
	    			
    		}Catch(Exception e){
    			ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Ha ocurrido un error!'));	
    		}
    }
    
    public void EmpleadosDespedidos()
    {
        try
        {
            if(banderaTiempo==0)
        	{
            	registrarTiempo();
        	}
	    	if(TextoBoton=='Reporte Ex-Empleados')
            {
                list<empresa_x_empleado__c> tempo = new list<empresa_x_empleado__c>();
	    		tempo = [Select Empleado2__r.Firstname, Empleado2__r.Lastname, Empleado2__c,
	    						Empleado2__r.Tipo_Identificacion__c, Empleado2__r.Identificacion__c, Empleado2__r.Estado_Civil__pc, 
	    						Empleado2__r.Sexo__c, Empleado2__r.PersonBirthDate, Motivo_Despido__c, Fecha_despido__c,
    							Empleado2__r.isPersonAccount, Estado__c, Salario__c, CurrencyIsoCode
    							From Empresa_x_Empleado__c
    							Where Empresa2__c =: Codigo_Unico_Banco and estado__C='Despedido' order by Empleado2__r.Firstname asc];
                
                
                if(tempo.size() == 0)
                {
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'No se encontraron Empleados Despedidos'));
                    
                }
                else
                {
                    mostrarcolumnas =false;
                    TextoBoton='Ver Todos';
                    Mlistempleados = tempo;
                }
                
            }
            else
            {
                mostrarcolumnas =true;
                TextoBoton='Reporte Ex-Empleados';
                iniciar();
            }
        }
        catch(Exception ex)
        {
            
        }
    }
    
    
    
    
    
    public void cerrar(){
        if(banderaTiempo==0)
        	{
            	registrarTiempo();
        	}
    		popAgregar = false;
        	popModificar= false;
            popquitar=false;
    }
    
    
     public void buscarEmpleado(){
         try
         {
             if(banderaTiempo==0)
        	{
            	registrarTiempo();
        	}
             total=0;
             if(TextoBoton2=='Ver Todos')
             {
                 iniciar();
             }
             else
             {
             listEmpleadosTemporales = new list<Empresa_x_Empleado__c>();
             listEmpleadosALmacenados = new list<Empresa_x_Empleado__c>();
             list<string> CamposBusqueda= new list<string>();
             if(!textoBusqueda.trim().contains(' '))
             {
                 for(integer i=0; i<listEmpleados.size(); i++)
             	{
                    if(listEmpleados[i].Empleado2__r.lastname !=null && listEmpleados[i].Empleado2__r.firstname !=null)
                      {
                    // string Nombre =listEmpleados[i].Empleado2__r.Firstname;
                         if(listEmpleados[i].Empleado2__r.Firstname.toUpperCase().contains(textoBusqueda.trim().toUpperCase()) ||
                           listEmpleados[i].Empleado2__r.lastname.toUpperCase().contains(textoBusqueda.trim().toUpperCase()) ||
                           listEmpleados[i].Empleado2__r.Identificacion__C.toUpperCase().contains(textoBusqueda.Replace('-','').trim().toUpperCase()))
                         {
                             listEmpleadosTemporales.add(listEmpleados[i]);
                         }
                      }
             	}
             }
             else
             {
              CamposBusqueda = textoBusqueda.trim().split(' ');
              for(integer i=0; i<listEmpleados.size(); i++)
              {
                  for(integer j=0; j<CamposBusqueda.size(); j++)
                  {
                      if(listEmpleados[i].Empleado2__r.lastname !=null && listEmpleados[i].Empleado2__r.firstname !=null)
                      {
                           if(listEmpleados[i].Empleado2__r.Firstname.toUpperCase().contains(CamposBusqueda[j].trim().toUpperCase()) ||
                           listEmpleados[i].Empleado2__r.lastname.toUpperCase().contains(CamposBusqueda[j].trim().toUpperCase()) ||
                           listEmpleados[i].Empleado2__r.Identificacion__C.toUpperCase().contains(CamposBusqueda[j].Replace('-','').trim().toUpperCase()))
                           {
                                 listEmpleadosTemporales.add(listEmpleados[i]);
                           }
                  }
                  }
              }
                 
                 
                 
             }
          if(listEmpleadosTemporales.size() > 0)
          {
              
              listEmpleadosalmacenados = listEmpleados;
              MlistEmpleados = listEmpleadosTemporales;
              for(integer op=0; op<mlistempleados.size(); op++)
              {
                  total += mlistempleados[op].salario__C;
              }
              totalempleados=mlistempleados.size();
              ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Se encontraron '+listEmpleadosTemporales.size()+' coincidencias.'));
              TextoBoton2='Ver Todos';
          }
         else
         {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'No se encontraron coincidencias.'));
         }
            
         }
         }
         catch(Exception ex)
         {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ex.getLineNumber()+'No se encontraron coincidencias.'+ex.getMessage())); 
         }
     }
	 public Pagereference ExportExcel()
    {
        if(banderaTiempo==0)
        	{
            	registrarTiempo();
        	}
        return New pagereference ('/Apex/vfexportarExcelEmpleados');
    }
    public void ModificarEmpleado()
    {
        try{
            if(banderaTiempo==0)
        	{
            	registrarTiempo();
        	}
            update Modificarempleado;
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, 'Datos actualizados correctamente'));
            mostrarModificar=false;
            iniciar();
        }
        catch(Exception ex)
        {
            
        }
    }
    
    
    
    
    public void buscar(){
    		try{
               if(banderaTiempo==0)
        	{
            	registrarTiempo();
        	}
                if(num_identidad !=null && num_identidad.trim()!='')
                {
                    empleado.Identificacion__c =num_identidad.trim().Replace('-','');
    				empleado = [Select Firstname, Lastname, Tipo_Identificacion__c, Identificacion__c,Estado_Civil__pc, Sexo__c,
    							isPersonAccount,PersonBirthdate
	    						From Account
	    						Where Identificacion__c =: empleado.Identificacion__c AND isPersonAccount = true];
				nombre = empleado.FirstName;
				apellido = empleado.Lastname;
    			
                }
                else
                {
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Escriba Un valor en la Identidad.'));
                }    
    			
    		}Catch(Exception e){
    			list<String> listIdentidad = new list<String>();
    			listIdentidad.add(empleado.Identificacion__c);
    			mostrarBuscar=true;
    			list<Account> empleadoConsulta = aSysdePortalEmpresarial.agregarPersonaPlanilla(listIdentidad);
    			mostrarBuscar=false;
                if(empleadoConsulta.size()>0)
                {
                    if(empleadoConsulta[0].firstname !='null null' && empleadoConsulta[0].firstname !=null){
    				empleado.Tipo_Identificacion__c = empleadoConsulta[0].Tipo_Identificacion__c;
                    if(empleadoConsulta[0].sexo__c=='1' ||empleadoConsulta[0].sexo__c=='Masculino')
                    {
                        empleado.sexo__c='Masculino';
                    }
                    else
                    {
                        empleado.sexo__c='Femenino';
                    }
                    empleado.PersonBirthdate = empleadoConsulta[0].PersonBirthdate;		
    				nombre = empleadoConsulta[0].FirstName;
					apellido = empleadoConsulta[0].Lastname;
    			}
                }
    			else{
	    			ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'No se ha encontrado empleado.'));
	    			String iden = empleado.Identificacion__c;
	    			empleado = new Account();
	    			empleado.Identificacion__c = iden;
	    			empleado.recordTypeId = tipoNatural;
    			}
    		}
    }
    
    public void eliminar(){
    		try{
               if(banderaTiempo==0)
        	{
            	registrarTiempo();
        	}
    			 empleadoE = new Empresa_x_Empleado__c();
                 empleadoE = [Select Empleado2__r.Name,id ,Motivo_despido__c, Empleado2__r.isPersonAccount, Fecha_despido__c 
                                From Empresa_x_Empleado__c Where id =: idEmpleado ];
                popQuitar = true;
    		}Catch(Exception e){
    			ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'No se ha encontrado empleado.'));	
    		}
    }
    public void quitarEmpleado(){
		try{
           if(banderaTiempo==0)
        	{
            	registrarTiempo();
        	}
            if(empleadoE.Motivo_despido__c != null)
            {
               
                empleadoE.Estado__c = 'Despedido';
                empleadoE.Fecha_despido__c = empleadoE.Fecha_despido__c != null ? empleadoE.Fecha_despido__c : Date.today();
                update empleadoE;
                
                iniciar();
                popQuitar = False;
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, '¡Empleado(s) dado(s) de baja correctamente!'));		
            }
            else
            {
                 ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, 'Seleccione un motivo de despido.'));
            }
        }Catch(Exception e){
			system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
			ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, '¡Ha ocurrido un error!')); 
		}
	}
    
    public void guardar(){
    		try{
               if(banderaTiempo==0)
        	{
            	registrarTiempo();
        	}
                if(Num_Identidad !=null && nombre !=null && Apellido !=null && empleado.Tipo_Identificacion__c !=null
             && empleado.Sexo__c != null && empleado.Estado_Civil__pc!=null && empleadoEmpresa.Salario__c !=null)
           {
               empleado.Identificacion__c=Num_identidad.trim().Replace('-','');
               if(esEdicion){
    				emModi.put('Tipo_Identificacion__c', empleado.Tipo_Identificacion__c);
	    			emModi.put('Identificacion__c', empleado.Identificacion__c);
	    			emModi.put('Estado_Civil__pc', empleado.Estado_Civil__pc);
	    			emModi.put('Sexo__c', empleado.Sexo__c);
	    			emModi.put('PersonBirthdate', empleado.PersonBirthdate);
	    			
				emModi.FirstName = nombre;
				emModi.Lastname = apellido;
				update emModi;
				
				update empleadoEmpresa;
				ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, 'Datos actualizados correctamente'));
				
    				iniciar();	
    			}else{
	    			integer yaExisteEmpleado = [Select count() From Empresa_x_Empleado__c
	    										Where Empresa2__c = : Codigo_Unico_Banco
	    										AND Empleado2__r.Identificacion__c =: empleado.Identificacion__c];
	    			
	    			if(yaExisteEmpleado == 0){
	    				
	    				if(empleado.id == null){
	    					if(Nombre == null){
	    						ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Debes llenar el nombre'));
	    						
	    					}else if(apellido == null){
	    						ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Debes llenar el apellido'));
	    							
	    					}else{
	    						empleado.recordTypeId = tipoNatural;
	    						empleado.FirstName = nombre;
	    						empleado.LastName = apellido;                               
	    						insert empleado;
                                
                               
                                
                               
	    					}
	    				
	    				}
	    				if(empleado.id != null){
		    				empleadoEmpresa.Empleado2__c = empleado.id;
		    				empleadoEmpresa.Empresa2__c = Codigo_Unico_Banco;
		    				empleadoEmpresa.Estado__c = 'Activo';
                            if(empleadoEmpresa.Salario__c==null || empleadoEmpresa.Salario__c < 0.0)
                            {
                                empleadoEmpresa.Salario__c=0.0;
                            }
                            
		    				insert empleadoEmpresa;
                           	integer tiene_Segundo_Nombre=0;
                                integer tiene_Segundo_apellido=0;
                                list<string> separacionNombre =new list<string>(); 
                                claseEnvio = new list<classAfiliacion>();
                               classAfiliacion nueva = new classAfiliacion();
                                nueva.primernombre=nombre.trim();
                                nueva.primerapellido=apellido.trim();
                                if(nombre.trim().contains(' '))
                                {
                                    tiene_Segundo_Nombre=1;
                                    separacionNombre= nombre.trim().Split(' ');
                                    nueva.primernombre=separacionNombre[0];
                                    nueva.segundonombre=separacionNombre[1];
                                }
                                if(apellido.trim().contains(' '))
                                {
                                    separacionNombre =new list<string>();
                                    tiene_Segundo_Apellido=1;
                                    separacionNombre= apellido.trim().Split(' ');
                                     nueva.primerapellido=separacionNombre[0];
                                    nueva.segundoapellido=separacionNombre[1];
                                }
                               
                               nueva.identificacion=empleado.identificacion__C;
                               nueva.idTipoIdentificacion=empleado.Tipo_Identificacion__c;
                               //nueva.cuentaColectiva=[select  codigo__c from CUENTAS__C WHERE CLIENTE__C = :Codigo_Unico_Banco limit 1].codigo__c;
                               nueva.genero=empleado.Sexo__c;
                               if(empleado.Sexo__c=='Masculino' || empleado.Sexo__c=='1')
                               {
                                   nueva.genero='M';
                               }
                               else
                               {
                                   nueva.genero='F';
                               }
                               nueva.estadoCivil = empleado.Estado_Civil__pc;
                               if(empleado.Estado_Civil__pc=='Soltero')
                               {
                                   nueva.estadoCivil='S';
                               }
                               else if(empleado.Estado_Civil__pc=='Casado')
                               {
                                   nueva.estadoCivil='C';
                               }
                               else if(empleado.Estado_Civil__pc=='Viudo')
                               {
                                   nueva.estadoCivil='V';
                               }
                               else if(empleado.Estado_Civil__pc=='Divorciado')
                               {
                                   nueva.estadoCivil='D';
                               }
                               else if(empleado.Estado_Civil__pc=='Unión Libre')
                               {
                                   nueva.estadoCivil='U'; 
                               }
                               nueva.salario=empleadoEmpresa.Salario__c;
                               //nueva.idsalesforce = [select Id_Formulario__c from empresa_x_empleado__C where id=:empleadoEmpresa.Id].id_formulario__c;
                               claseenvio.add(nueva);
                               banderasysde=1;
		    				   ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, 'Empleado agregado correctamente.'));		    
		    				  
                            //Enviarasysde();
                            iniciar();
		    				
	    				}	
	    			}else{
	    				ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Empleado ya ha sido agregado'));
	    				empleado = new Account(); 	
	    			}
    			}
           }
           else
           {
               ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Faltan Datos Obligatorios'));
           }
    			
    		}Catch(Exception e){ 
    			system.debug('Error agregar empleado: ' + e.getmessage() + ' Linea: ' + e.getLineNumber());
    			ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, e.getLineNumber()+'Ha ocurrido un problema')); 	
    		}
    }
   
    public void Enviarasysde() 
    {
        
    	if(banderasysde==1)
        {
            banderasysde =0;
             string Voluntarias;
            string cesantias;
            string Pcomplemetario;
            String EnviarCuentas;
        	 Autonumerico_cuentas_Syste__c Numerosformularios=[select id, Id_Formulario_Sysde__c from Autonumerico_cuentas_Syste__c limit 1];
             decimal abc=Numerosformularios.Id_Formulario_Sysde__c;
        //classAfiliacion	nueva = new classAfiliacion();
            list<Cuentas_colectivas__C> fr = new list<Cuentas_colectivas__C>();
            fr = [Select  Codigo__C, tipo_cuenta__C from Cuentas_colectivas__C where empresa__C=:Codigo_Unico_Banco];
            for(integer i=0; i<fr.size(); i++)
            {
               if(fr[i].tipo_cuenta__C=='Voluntarias')
                {
                   voluntarias = fr[i].codigo__C;
                }
                else if(fr[i].tipo_cuenta__C=='Censatías')
                {
                     cesantias = fr[i].codigo__C;
                 }
                 else if(fr[i].tipo_cuenta__C=='Pilar Complementario')
                {
                    Pcomplemetario = fr[i].codigo__C;
                }
                  
                }
             list<string> listEnviarCuentas = new list<string>();   
            if(tipoaportacion=='Ambas')
            {
                claseenvio[0].cuentaUno=voluntarias;
                claseenvio[0].idSalesforceUno = 'SF'+string.valueOf(abc++);
                
                claseenvio[0].cuentados=cesantias;
                claseenvio[0].idSalesforcedos = 'SF'+string.valueOf(abc++);
                
                claseenvio[0].cuentaTres=Pcomplemetario;
                claseenvio[0].idSalesforceTres = 'SF'+string.valueOf(abc++);
                
            }
            else if(tipoaportacion=='Voluntarias')
            {
                 claseenvio[0].cuentaUno=voluntarias;
                 claseenvio[0].idSalesforceUno = 'SF'+string.valueOf(abc++);
            }
            else if(tipoaportacion=='Obligatorios')
            {
                claseenvio[0].cuentaUno=Pcomplemetario;
                claseenvio[0].idSalesforceUno = 'SF'+string.valueOf(abc++);
                
                claseenvio[0].cuentados=cesantias;
                claseenvio[0].idSalesforcedos = 'SF'+string.valueOf(abc++);
            }
        	Numerosformularios.Id_Formulario_Sysde__c=abc;
        	update Numerosformularios;
            aSysdePortalEmpresarial.Afiliacionsysde(claseenvio[0].idTipoIdentificacion, claseenvio[0].Identificacion, claseenvio[0].primernombre, claseenvio[0].segundonombre,
                                                    claseenvio[0].primerapellido, claseenvio[0].segundoapellido, claseenvio[0].genero, 
                                                    claseenvio[0].estadoCivil, claseenvio[0].salario, claseenvio[0].cuentaUno,
                                                    claseenvio[0].cuentados, claseenvio[0].cuentatres, claseenvio[0].idSalesforceUno,
                                                       claseenvio[0].idSalesforcedos, claseenvio[0].idSalesforcetres);
        }
       
       
    }
    
   public void metodoutil()
   {
       integer i=0;
       i=0;
       i=0;
       i=0;
       i=0;
       i=0;
       i=0;
       i=0;
       i=0;
       i=0;
       i=0;
       i=0;
       i=0;
       i=0;
       i=0;
   }
    public void guardarCambios(){
    		try{
               if(banderaTiempo==0)
        	{
            	registrarTiempo();
        	}
    			upsert listEmpleados;
    			ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, 'Cambios guardados correctamente'));
    			iniciar();	
    			
    		}Catch(Exception e){
    			ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un problema'));
    		}
    }
    
    
}