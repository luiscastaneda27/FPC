public class controladorGenerarPersonal {

    public Account empleado{get;set;}    
    public boolean popAgregar{get;set;}
    integer banderaguardar;
    public decimal total{get;set;}
    public string idEmpleado{get;set;}
    public string Url_pagina{get;set;}
    public boolean pop_exportar{get;set;}
    public string nombre{get;set;}
    public string apellido{get;set;}
    public string Num_Identidad{get;set;}
   public integer TotalEMpleados{get;set;}
   public List<claseColaboradores> listClientes{get;set;}
   public List<claseColaboradores> listClientes2{get;set;}
    public List<claseColaboradores> listClientes3{get;set;}
    integer contadorpaginacion;
    public boolean mostrarSiguiente{get;set;}
    public boolean mostrarANterior{get;set;}
    public boolean mostrarBotones{get;set;}
    integer  contadorBuscar;
    public boolean mostrarVerTodos{get;set;}
    list<classAfiliacion> claseEnvio;
    public string TextoBoton{get;set;}
    // listas para la modificacion de empleados
    
    public boolean mostrarBuscar{get;set;}
    
    public list<SelectOption> aportaciones{get;set;}
    public string tipoaportacion{get;set;}
    classAfiliacion nueva;
    
    public integer Inicio;
    public integer fin;
    integer banderamensajes;
     public decimal salario{get;set;}
    
    
    
    public string textoBusqueda{get;set;}
    public list<clasecolaboradores> listEmpleadosTemporales{get;set;}
    public list<clasecolaboradores> listEmpleadosalmacenados{get;set;}
    
    
    String Codigo_Unico_Banco;
    String Usuario;
    String tipoNatural = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
    private boolean esEdicion;
    public string nombre_empresa {get;set;}
    public controladorGenerarPersonal(){
    		try{
	    		Codigo_Unico_Banco = ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
		    Usuario = ApexPages.currentPage().getParameters().get('loetdncdhjch'); 
		   //codigo_unico_banco='0011100001NsuTM';
		  nombre_empresa=[select name from account where id=:Codigo_Unico_Banco].name;
		   banderamensajes=0;
                banderaguardar=0;
	    		iniciar();
    		}Catch(Exception e){
    			ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Se ha producido un error, favor contacte a su administrador')); 	
    		}	
    }
    
    public void iniciar(){
    		try{
                
                contadorpaginacion=0;
                contadorbuscar=0;
                mostrarBotones=false;
                mostrarANterior=true;
                mostrarVerTodos=false;
                mostrarSiguiente=true;
                list<string> Cuentas = new list<string>();
                list<string> Cuentas1 = new list<string>();
                list<string> Cuentas2 = new list<string>();
                
                for(Cuentas_Colectivas__c item:[select codigo__C, tipo_cuenta__C from Cuentas_Colectivas__c where empresa__C=:Codigo_Unico_Banco ])
                {
                    if(item.tipo_cuenta__C=='Voluntarias')
                    {
                        cuentas.add(item.codigo__C); 
                    }
                    if(item.tipo_cuenta__C=='Censatías')
                    {
                        cuentas1.add(item.codigo__C); 
                    }
                    if(item.tipo_cuenta__C=='Pilar Complementario')
                    {
                       cuentas2.add(item.codigo__C);  
                    }
                    
                }
                list<string> identidadesbuenas = new list<string>();
                list<string> todaside = new list<string>();
                list<string> identidadesbuenasCS = new list<string>();
                map<string, integer> identidadespl=new map<string, integer>();
                map<string, integer> identidadescd=new map<string, integer>();
                for(cuentas__C item: [select cliente__C from cuentas__C where cuenta_colectiva2__r.codigo__C in:(cuentas)])
                {
                   identidadesbuenas.add(item.cliente__C); 
                }
                for(cuentas__C item: [select cliente__C from cuentas__C where cuenta_colectiva2__r.codigo__C in:(cuentas2)])
                {
                   if(!identidadespl.containsKey(item.cliente__C))
                   {
                       identidadespl.put(item.cliente__C,9);
                   }
                   todaside.add(item.cliente__C); 
                }
                for(cuentas__C item: [select cliente__C from cuentas__C where cuenta_colectiva2__r.codigo__C in:(cuentas1)])
                {
                    if(!identidadescd.containsKey(item.cliente__C))
                   {
                       identidadescd.put(item.cliente__C,9);
                   }
                   todaside.add(item.cliente__C); 
                }
                for(integer i=0; i<todaside.size(); i++)
                {
                    if(identidadescd.containsKey(todaside[i]) && identidadespl.containsKey(todaside[i]))
                    {
                      identidadesbuenas.add(todaside[i]);  
                    }
                }
                todaside.clear();
                identidadescd.clear();
                identidadespl.clear();
                listClientes = new list<claseColaboradores>();
                listClientes2 = new list<claseColaboradores>();
                listClientes3 = new list<claseColaboradores>();
                nombre_empresa=[select name from account where id=:Codigo_Unico_Banco].name;
                map<string, integer> frv= new map<string, integer>();
                integer controla=0;
                //list<string> identidadesregistradas= new list<string>();
              	 for( Account item :[select id,Estado_Civil__pc,salario__c, PersonBirthdate ,tipo_Identificacion__C,
                              Identificacion__C ,firstname, lastname
                              from Account where id  in :identidadesbuenas and 
                                        id not in (select empleado2__c from empresa_x_Empleado__C where empresa2__C=:codigo_unico_banco and estado__c='Despedido' ) 
                                        order by firstname asc limit 1800])
                {
                 
                     if(!frv.containsKey(item.id))
                     {
                         controla++;
                         listClientes2.add(new claseColaboradores(string.valueOf(controla), item.tipo_identificacion__c, item.identificacion__C,
                                                                item.firstname, item.lastname, item.PersonBirthdate, 
                                                                item.estado_civil__pc, item.salario__C, item.id));
                        
                         frv.put(item.id, 3);
                        // identidadesregistradas.add(item.cliente__C);
                         
                         
                     }
                }
                frv.clear();
                totalempleados=0;
                for(string item:identidadesbuenas)
                {
                    if(!frv.containsKey(item))
                     {
                         frv.put(item, 3);
                         totalempleados++;
                     }
                   
                }
                frv.clear();
               identidadesbuenas.clear();  
             //identidadesregistradas.clear();   
            //list<empresa_x_empleado__C> cargaSalarios=new list<empresa_x_empleado__C>();
            map<string, decimal> cargaSalarios= new map<string, decimal>();
            for(empresa_x_Empleado__C item: [select empleado2__c, salario__C from empresa_x_Empleado__C where empresa2__C=:codigo_unico_banco and estado__C='Activo'])
            {
                if(!cargaSalarios.containsKey(item.empleado2__C))
                {
                   cargaSalarios.put(item.empleado2__C,item.salario__C); 
                }
            }
            //cargaSalarios = [select empleado2__c, salario__C from empresa_x_Empleado__C where empresa2__C=:codigo_unico_banco and estado__C='Activo'];
            for(integer j=0; j<listclientes2.size(); j++)
                {
                    
                    if(cargaSalarios.containsKey(listclientes2[j].idcliente))
                    {
                        listclientes2[j].salario =cargaSalarios.get(listclientes2[j].idcliente);
                        
                    }
                }
            cargaSalarios.clear();
                Total=0;
             //TotalEMpleados=listClientes2.size()+listClientes3.size()+ggg;
             for(integer i=0; i<listclientes2.size(); i++)
             {
                 if(listClientes2[i].salario ==null || listClientes2[i].salario < 0)
                    {
                        listClientes2[i].salario =0;
                    }
                 total +=listClientes2[i].salario;
             }
                
           if(listClientes2.size()>100)
           {
                contadorpaginacion ++;
               	mostrarBotones=true;
                mostrarSiguiente=false;
               inicio=0;
               fin=99;
                for(integer i=0; i<100; i++)
                {
                    listClientes.add(listClientes2[i]);
                }
           }
           else
           {
              for(integer i=0; i<listClientes2.size(); i++)
                {
                    
                    listClientes.add(listClientes2[i]);
                } 
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

    		}Catch(Exception e){
    			ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Se ha producido un error, favor contacte a su administrador')); 			
    		} 		
    }
    
    
    public void siguiente() 
    {
        try{
            // usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            system.debug('Inicio '+listClientes2.size());
            if((contadorpaginacion + 1)*100 > listClientes2.size())
            {
                
                 integer j=0;
                for(integer i=inicio; i<=fin; i++)
                {
                   listClientes2[i] = listClientes[j];
                    j++;
                } 
               
                contadorpaginacion ++;
                listclientes = new list<claseColaboradores>();
                mostrarSiguiente=true;
                mostraranterior=false;
                integer fin2;
                inicio=(contadorpaginacion - 1)*100;
                 for(integer i=(contadorpaginacion - 1)*100; i<listClientes2.size(); i++)
                {
                   
                    listClientes.add(listClientes2[i]);
                   fin=i;
                } 
                
               // fin = listClientes2.size() -1;
                
            }
            else
            {
                 mostraranterior=false;
                
                 contadorpaginacion ++;
                 integer j=0;
                for(integer i=inicio; i<=fin; i++)
                {
                   listClientes2[i] = listClientes[j];
                    j++;
                } 
                listclientes = new list<claseColaboradores>();
                inicio = (contadorpaginacion - 1)*100;
                 for(integer i=(contadorpaginacion - 1)*100; i<contadorpaginacion*100; i++)
                {
                   
                    listClientes.add(listClientes2[i]);
                    fin =i;
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
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            if((contadorpaginacion - 1)*100 < 101)
            {
                mostrarsiguiente=false;
                mostrarAnterior=true;
                 integer j=0;
                for(integer i=inicio; i<=fin; i++)
                {
                    listClientes2[i] = listClientes[j];
                    j++;
                } 
                listClientes = new list<claseColaboradores>();
                inicio=0;
                fin=99;
                
                for(integer i=0; i<100; i++)
                {
                    listClientes.add(listClientes2[i]);
                } 
                contadorpaginacion --;
            }
            else
            {
               
                integer j=0;
                for(integer i=inicio; i<=fin; i++)
                {
                   listClientes2[i] = listClientes[j];
                    j++;
                } 
                listClientes = new list<claseColaboradores>();
                inicio=(contadorpaginacion - 2)*100;
               for(integer i=(contadorpaginacion - 2)*100; i<(contadorpaginacion-1) *100; i++)
                {
                    listClientes.add(listClientes2[i]);
                    fin=i;
                }  
                contadorpaginacion --;
                 mostrarSiguiente=false;
            }
        }
        catch(Exception ex)
        {
            system.debug('Error '+ex.getLineNumber() + ex.getMessage());
        }
    }
    
     public void eliminar()
    {
        try{
            string clien;
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            for(integer i=0; i<listclientes.size(); i++)
            {
                if(idEmpleado==listclientes[i].id)
                {
                    listclientes.remove(i);
                    i=listclientes.size();
                }
            } 
            
            for(integer i=0; i<listclientes2.size(); i++)
            {
                if(idEmpleado==listclientes2[i].id)
                {
                    clien= listclientes2[i].idcliente;
                    listclientes2.remove(i);
                    i=listclientes2.size();
                }
            }
            TotalEMpleados=listClientes2.size();
         	integer u=[select count() from empresa_x_empleado__C where empleado2__C=:clien and empresa2__c=:Codigo_Unico_Banco];
         	if(u==1)
            {
                empresa_x_empleado__C hy= new empresa_x_empleado__C();
                hy=[select id, Activo_Nueva_Planilla__c from empresa_x_empleado__C where empleado2__C=:clien and empresa2__c=:Codigo_Unico_Banco];
                hy.Activo_Nueva_Planilla__c=false;
                update hy;
            }
        }catch(Exception ex)
        {
            
        }
    }
    
    public void vertodos()
    {
        try{
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            if(contadorbuscar > 0)
             {
                 for(integer i=0; i<listclientes.size(); i++)
                 {
                     for(integer j=0; j<listclientes2.size(); j++)
                     {
                         if(listclientes2[j].id == listclientes[i].id)
                         {
                             listclientes2[j]=listclientes[i];
                             j=listclientes2.size();
                         }
                     }
                 }
             }
             contadorpaginacion=0;
             contadorbuscar=0;
             mostrarBotones=false;
             mostrarANterior=true;
             mostrarSiguiente=true;
             listClientes = new list<clasecolaboradores>();
            mostrarVerTodos=false;
           if(listClientes2.size()>100)
           {
                contadorpaginacion ++;
               	mostrarBotones=true;
               mostrarSiguiente=false;
                for(integer i=0; i<100; i++)
                {
                   
                    listClientes.add(listClientes2[i]);
                }
           }
           else
           {
               
               
              for(integer i=0; i<listClientes2.size(); i++)
                {
                   
                    listClientes.add(listClientes2[i]);
                } 
           }
        }
        catch(exception ex)
        {
            
        }
    }
    
    public void buscarEmpleado(){
         try
         {
             Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
             if(textoBusqueda !=null && TextoBusqueda !='')
             {
                 if(contadorbuscar > 0)
                 {
                     for(integer i=0; i<listclientes.size(); i++)
                     {
                         for(integer j=0; j<listclientes2.size(); j++)
                         {
                             if(listclientes2[j].id == listclientes[i].id)
                             {
                                 listclientes2[j]=listclientes[i];
                                 j=listclientes2.size();
                             }
                         }
                     }
                 }
                 listEmpleadosTemporales = new list<clasecolaboradores>();
                 listEmpleadosALmacenados = new list<clasecolaboradores>();
                 list<string> CamposBusqueda= new list<string>();
                 contadorbuscar=0;
                 if(textoBusqueda.trim().contains(' '))
                 {
                     for(integer i=0; i<listclientes2.size(); i++)
                    {
                           if(listClientes2[i].Firstname.toUpperCase().contains(textoBusqueda.trim().toUpperCase()) ||
                              listClientes2[i].lastname.toUpperCase().contains(textoBusqueda.trim().toUpperCase()) ||
                              listClientes2[i].Identificacion.toUpperCase().contains(textoBusqueda.Replace('-','').trim().toUpperCase()))
                             {
                                listEmpleadosTemporales.add(listclientes2[i]);
                             }
                    }
                 }
                 else
                 {
                  CamposBusqueda = textoBusqueda.trim().split(' ');
                  for(integer i=0; i<listclientes2.size(); i++)
                  {
                      for(integer j=0; j<CamposBusqueda.size(); j++)
                      {
                           if(listClientes2[i].Firstname.toUpperCase().contains(CamposBusqueda[j].trim().toUpperCase()) ||
                           listClientes2[i].lastname.toUpperCase().contains(CamposBusqueda[j].trim().toUpperCase()) ||
                           listClientes2[i].Identificacion.toUpperCase().contains(CamposBusqueda[j].Replace('-','').trim().toUpperCase()))
                           {
                                 listEmpleadosTemporales.add(listClientes2[i]);
                           }
                      }
                  }
                     
                     
                     
                 }
              if(listEmpleadosTemporales.size() > 0)
              {
                  listEmpleadosalmacenados = listClientes2;
                  listClientes = listEmpleadosTemporales;
                  contadorbuscar=10;
                  mostrarVerTodos=true;
                  mostrarANterior=true;
                 mostrarSiguiente=true;
                  ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Se encontraron '+listEmpleadosTemporales.size()+' coincidencia(s).'));
              }
             else
             {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'No se encontraron coincidencias.'));
             }
         }   
         }
         catch(Exception ex)
         {
             
         }
     }

     public void mostrarNuevo(){
         Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
         	empleado= new Account();
         	nombre='';
        	 apellido='';
         	empleado.CurrencyIsoCode='HNL';
         	salario=0.0;
    		popAgregar = true;
    }
    
   
    public void buscar(){
    		try{
                Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
                if(Num_identidad.trim()!='' && Num_identidad !=null)
                {    empleado.Identificacion__c=Num_Identidad;
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
                try{
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
    			}else{
	    			ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'No se ha encontrado empleado.'));
	    			String iden = empleado.Identificacion__c;
	    			empleado = new Account();
	    			empleado.Identificacion__c = iden;
	    			empleado.recordTypeId = tipoNatural;
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
                catch(Exception ex)
                {
                   ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Ha Ocurrido Un Error')); 
                }
                
    		}
    }
    
    public Pagereference ExportExcel()
    {
        try
        {
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            banderaguardar=1;
            AgregarEMpleados();
            if(listclientes2.size()>995)
            {
                system.debug('1');
                url_pagina='vfexportarcolaboradoresvigentes2?empresa='+codigo_unico_banco;
                pop_exportar=true;
                return null;
            }
            else
            {
                system.debug('2');
              return New pagereference ('/Apex/vfexportarColaboradoresvigentes');  
            }
             
        }
        catch(Exception ex)
        {
            
        }
        
       return null;
    }
        
    
    
    
    //Prueba
    public void AgregarEMpleados()
    {
        try
        {
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            integer jj=0;
             for(integer i=inicio; i<=fin; i++)
                {
                   listClientes2[i] = listClientes[jj];
                    jj++;
                }
           list<empresa_X_empleado__C> empleados = new  list<empresa_X_empleado__C>();
            list<empresa_X_empleado__C> empleadosupsert = new  list<empresa_X_empleado__C>();
             //list<empresa_X_empleado__C> empleadosexistentes = new  list<empresa_X_empleado__C>();
            map<string, string> empleadosexistentes= new map<string, string>();
            for(empresa_X_empleado__C item: [select empleado2__C,id, salario__C from empresa_X_empleado__C where empresa2__C=:Codigo_Unico_Banco])
            {
                if(!empleadosexistentes.containsKey(item.empleado2__C))
                {
                    empleadosexistentes.put(item.empleado2__C, item.id);
                }
            }
          // empleadosexistentes = [select empleado2__C,id, salario__C from empresa_X_empleado__C where empresa2__C=:Codigo_Unico_Banco]; 
           empresa_X_empleado__C emplead;
          for(integer i=0; i<listclientes2.size(); i++)
          {
             boolean existe = true;
             emplead =  new  empresa_X_empleado__C(); 
             
                 if(empleadosexistentes.containsKey(listclientes2[i].idcliente))
                 {
                     
                     emplead.id=empleadosexistentes.get(listclientes2[i].idcliente);
                     emplead.Salario__c=listclientes2[i].salario;
                     emplead.Activo_Nueva_Planilla__c= true;
                     existe= false;
                     empleadosupsert.add(emplead); 
                     //j=empleadosexistentes.size();
                 }
             
            if(existe)
            {
               emplead.Empleado2__c = listclientes2[i].idcliente;
             emplead.Empresa2__c=codigo_unico_banco;
             emplead.Estado__c='Activo';
             emplead.salario__c=listclientes2[i].salario;
             emplead.Ultima_modificacion__c=usuario;
             emplead.Activo_Nueva_Planilla__c= true;
             empleados.add(emplead); 
            }
             
          }
          
        update empleadosupsert;
		insert empleados;
       	if(banderaguardar==0)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, '¡Empleados Guardados con Exito!'));
            if(totalempleados>1800)
            {
               claseutilPlanillas.ColavoradoresVigentes(Codigo_unico_banco, usuario); 
            }
            
        }
        else
        {
            banderaguardar=0;    
        }
        
       
        }
        catch(Exception ex)
        {
             ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ex.getLineNumber()+'   '+ex.getMessage()));
        }
    }
        
    
    
     public void cerrar()
    {
        popagregar=false;
        pop_exportar=false;
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
    }
   
    public void AgregarPersonal()
    {
        try{
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            empleado.id=null;
           if(Num_Identidad !=null && nombre !=null && Apellido !=null && empleado.Tipo_Identificacion__c !=null
             && empleado.Sexo__c != null && empleado.Estado_Civil__pc!=null && salario !=null)
           {
               Empresa_x_empleado__C empleado_nuevo= new Empresa_x_empleado__C();
            Empleado.Identificacion__c=Num_Identidad;
            integer u= [select count() from account where Identificacion__c=:Empleado.Identificacion__c];
            if(u==0)
            {
             
                empleado.firstname=nombre;
                empleado.lastname=apellido;
                empleado.recordtypeid=tipoNatural;
                insert empleado;
                empleado_nuevo.empleado2__C=empleado.id;
                empleado_nuevo.empresa2__C = codigo_unico_banco;
                empleado_nuevo.Salario__c=salario;
                empleado_nuevo.Estado__c='Activo';
                empleado_nuevo.Ultima_modificacion__c=usuario;
                empleado_nuevo.CurrencyIsoCode=empleado.CurrencyIsoCode;
                insert empleado_nuevo;
                popagregar=false;
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Empleado guardado con exito'));
                
               system.debug('Empezamos');
                list<string> separacionNombre =new list<string>(); 
                claseEnvio = new list<classAfiliacion>();
                Enviarcuentas();
                nueva.primernombre=nombre.trim();
                nueva.primerapellido=apellido.trim();
               
                if(nombre.trim().contains(' '))
                {
                    
                    separacionNombre= nombre.trim().Split(' ');
                    nueva.primernombre=separacionNombre[0];
                    nueva.segundonombre=separacionNombre[1];
                }
                if(apellido.trim().contains(' '))
                {
                      separacionNombre =new list<string>();
                      separacionNombre= apellido.trim().Split(' ');
                      nueva.primerapellido=separacionNombre[0];
                      nueva.segundoapellido=separacionNombre[1];
                }
                               
                nueva.identificacion=empleado.identificacion__C;
                if(empleado.identificacion__C ==null)
                {
                    nueva.identificacion='1';
                }
                nueva.idTipoIdentificacion=empleado.Tipo_Identificacion__c;
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
                if(empleado.Estado_Civil__pc ==null)
                 {
                     nueva.estadoCivil='S';
                 }
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
                
                nueva.salario=Salario;
                //nueva.idSalesforceUno = 'SF'+string.valueOf(abc++);
                
                claseenvio.add(nueva);
                system.debug('terminamos'+ nueva);
                aSysdePortalEmpresarial.Afiliacionsysde(claseenvio[0].idTipoIdentificacion, claseenvio[0].Identificacion, claseenvio[0].primernombre, claseenvio[0].segundonombre,
                                                    claseenvio[0].primerapellido, claseenvio[0].segundoapellido, claseenvio[0].genero, 
                                                    claseenvio[0].estadoCivil, claseenvio[0].salario, claseenvio[0].cuentaUno,
                                                    claseenvio[0].cuentados, claseenvio[0].cuentatres, claseenvio[0].idSalesforceUno,
                                                       claseenvio[0].idSalesforcedos, claseenvio[0].idSalesforcetres);
            }
            else
            {
                u=[select count() from empresa_X_empleado__C where empleado2__r.Identificacion__c=:Empleado.Identificacion__c and empresa2__C=:codigo_unico_banco];
                if(u==0)
                {
                    Account empleadonuevo= new Account();
                    empleadonuevo=[select id, firstname, lastname, Tipo_Identificacion__c,
                                      sexo__C, estado_civil__pc from Account where Identificacion__c=:Empleado.Identificacion__c];
                   empleado_nuevo.empleado2__C=empleadonuevo.id;
                   empleado_nuevo.empresa2__C = codigo_unico_banco;
                   empleado_nuevo.Salario__c=salario;
                 empleado_nuevo.Estado__c='Activo';
                 empleado_nuevo.CurrencyIsoCode=empleado.CurrencyIsoCode;
                empleado_nuevo.Ultima_modificacion__c=usuario;
                insert empleado_nuevo;
                popagregar=false;
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Empleador agregado con exito'));
                list<string> separacionNombre =new list<string>(); 
                claseEnvio = new list<classAfiliacion>();
               enviarcuentas();
                nueva.primernombre=empleadonuevo.FirstName.trim();
                nueva.primerapellido=empleadonuevo.LastName.trim();
                if(empleadonuevo.FirstName.trim().contains(' '))
                {
                    separacionNombre= empleadonuevo.FirstName.trim().Split(' ');
                    nueva.primernombre=separacionNombre[0];
                    nueva.segundonombre=separacionNombre[1];
                }
                if(empleadonuevo.lastName.trim().contains(' '))
                {
                      separacionNombre =new list<string>();
                      separacionNombre= empleadonuevo.lastName.trim().Split(' ');
                      nueva.primerapellido=separacionNombre[0];
                      nueva.segundoapellido=separacionNombre[1];
                }
                               
                nueva.identificacion=empleado.identificacion__C;
                 nueva.idTipoIdentificacion=empleado.Tipo_Identificacion__c;
                if(empleado.Tipo_Identificacion__C ==null)
                {
                    nueva.idTipoIdentificacion='1';
                }
               
               // nueva.cuentaColectiva=[select  codigo__c from CUENTAS__C WHERE CLIENTE__C = :Codigo_Unico_Banco limit 1].codigo__c;
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
                 if(empleado.Estado_Civil__pc ==null)
                 {
                     nueva.estadoCivil='S';
                 }
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
                nueva.salario=Salario;                
                //nueva.idsalesforce = [select Id_Formulario__c from empresa_x_empleado__C where id=:empleado_nuevo.Id].id_formulario__c;
                claseenvio.add(nueva);
                 list<string> Cuentas = new list<string>();
                for(cuentas__c t:[select  CODIGO__C,id from CUENTAS__C WHERE CLIENTE__C = :Codigo_Unico_Banco])
                {
                    cuentas.add(t.id); 
                }
	    		
              	u=[select count() from cuentas__C where cliente__c not in (select empleado2__c from empresa_x_Empleado__C where empresa2__C=:codigo_unico_banco)
                               and Cuenta_colectiva2__c  in :cuentas and cliente__c=: empleadonuevo.id];
                if(u==0)
                {
                	aSysdePortalEmpresarial.Afiliacionsysde(claseenvio[0].idTipoIdentificacion, claseenvio[0].Identificacion, claseenvio[0].primernombre, claseenvio[0].segundonombre,
                                                    claseenvio[0].primerapellido, claseenvio[0].segundoapellido, claseenvio[0].genero, 
                                                    claseenvio[0].estadoCivil, claseenvio[0].salario, claseenvio[0].cuentaUno,
                                                    claseenvio[0].cuentados, claseenvio[0].cuentatres, claseenvio[0].idSalesforceUno,
                                                       claseenvio[0].idSalesforcedos, claseenvio[0].idSalesforcetres);    
                }
            }
           else
           {
               ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Esta Persona ya existe entre sus empleados')); 
           }
            }
           }
            else
            {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Faltan campos obligatorio')); 
            }
           
            
        }
        catch(Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Hubo un Error '));
        }
    }
   
    public void Enviarcuentas()
    {
        string Voluntarias;
            string cesantias;
            string Pcomplemetario;
            String EnviarCuentas;
        	 Autonumerico_cuentas_Syste__c Numerosformularios=[select id, Id_Formulario_Sysde__c from Autonumerico_cuentas_Syste__c limit 1];
             decimal abc=Numerosformularios.Id_Formulario_Sysde__c;
        	nueva = new classAfiliacion();
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
            if(tipoaportacion=='Ambas')
            {

                nueva.cuentaUno=voluntarias;
                nueva.idSalesforceUno = 'SF'+string.valueOf(abc++);
                
                nueva.cuentados=cesantias;
                nueva.idSalesforcedos = 'SF'+string.valueOf(abc++);
                
                nueva.cuentaTres=Pcomplemetario;
                nueva.idSalesforceTres = 'SF'+string.valueOf(abc++);
            }
            else if(tipoaportacion=='Voluntarias')
            {
                 nueva.cuentaUno=voluntarias;
                 nueva.idSalesforceUno = 'SF'+string.valueOf(abc++);
            }
            else if(tipoaportacion=='Obligatorios')
            {
               
                nueva.cuentaUno=Pcomplemetario;
                nueva.idSalesforceUno = 'SF'+string.valueOf(abc++);
                
                nueva.cuentados=cesantias;
                nueva.idSalesforcedos = 'SF'+string.valueOf(abc++);
            }
        	Numerosformularios.Id_Formulario_Sysde__c=abc;
        	update Numerosformularios;
        //return listEnviarCuentas;
    }
    public void metodoutil()
    {}
}