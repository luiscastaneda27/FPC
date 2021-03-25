global  class ControladorCargarSalarios {

    private static string Codigo_Unico_Banco{get;set;}
    public static boolean ActivarModal{get;set;}
    public  boolean Mostrartabla{get;set;}
    public  boolean MostrarBotones{get;set;}
     public  string mensaje{get;set;}
    public list<Planilla> NuevosSueldos{get;set;}
    public list<Planilla> MNuevosSueldos{get;set;}
    public list<Sueldos_Temporales__c> SueldosRepetidos{get;set;} 
    public string Nombre_Empresa{get;set;}
     public  decimal total{get;set;}
    
    //PAGINACIÓN 
    public boolean mostrarSiguiente{get;set;}
    public boolean mostrarANterior{get;set;}
    public boolean mostrarBotonesP{get;set;}
    integer contadorpaginacion;
    string usuario;
    
    
    public ControladorCargarSalarios()
    { 
       
       ActivarModal=false;
       Mostrartabla=false;
       Mostrarbotones=true;
       Codigo_Unico_Banco = ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
        Nombre_Empresa = [select name from account where id =:Codigo_Unico_Banco].name;
      usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
       
    }
    
    public void reIniciar(){ 
    	mostrarTabla=false;
        mostrarBotones=true;

    }
    public void NuevaCarga()
    {
        reiniciar();
    }
    
    
    public static string valorempresa()
    {
        return ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
    }
    
     public Pagereference guardarSalarios()
    {
        try{
		  Codigo_Unico_Banco=ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
             usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
           list<empresa_x_empleado__c> ki = new list<empresa_x_empleado__c> ();
           empresa_x_empleado__c k;
           // verarchivo();
            for(integer i=0; i<NuevosSueldos.size(); i++)
            {
                k = new empresa_x_empleado__c();
                k.id=nuevossueldos[i].id_cambiarSalario;
                k.Salario__c=nuevossueldos[i].Nuevo_Salario;
                ki.add(k);
            }
            update ki;
              Modificaciones_Empleados__c ju; 
            list <Modificaciones_Empleados__c> juu=new list <Modificaciones_Empleados__c>();
            for(integer i=0; i<ki.size(); i++)
            {
                ju=new Modificaciones_Empleados__c();
                ju.Empleado__c=ki[i].id;
               ju.Fecha__c=date.today();
               ju.Tipo_Cambio__c='C';
                juu.add(ju);
            }
           
           insert juu; 
           delete([select id from sueldos_temporales__C where Salario_temporal__r.name=:Codigo_Unico_Banco]);
           delete ([select id from sueldo_Temporal__c where name=:codigo_unico_banco]);
            return new PageReference ('/Apex/vfHome?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario);
            
        }catch(exception ex)
        {
            
        }
        return null;
    }
    
    public void VerArchivo()
    {
        try{
            total=0;
		  Codigo_Unico_Banco=ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
            usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            sueldo_Temporal__c NuevaPlanilla = new sueldo_Temporal__c();
            NuevaPlanilla =[select id, Numeracion_Automatica__c from sueldo_Temporal__c where name=:codigo_unico_banco order by Numeracion_Automatica__c DESC LIMIT 1];
            list<sueldos_temporales__c> todos = new list<sueldos_temporales__c>();
            todos=[select  Identidad__c, salario__c from sueldos_temporales__c where salario_Temporal__c=:nuevaplanilla.id];
       		list<string> Identidades =new list<string>();
            for(integer i=0; i<todos.size(); i++)
            {
                identidades.add(todos[i].Identidad__c);
            } 
             list<Empresa_X_Empleado__c> empleados = new list<Empresa_X_Empleado__c>();
             empleados =[select id, empleado2__r.identificacion__c, empleado2__r.firstname, empleado2__r.lastname,
                         salario__c from Empresa_X_Empleado__c where empresa2__C=:codigo_Unico_banco and empleado2__r.identificacion__c in :Identidades];
             NuevosSueldos= new list<planilla>();
             SueldosRepetidos = new list<Sueldos_Temporales__c>();
            Sueldos_Temporales__c g;
            for(integer i=0; i<todos.size(); i++)
            {
                string si='Si';
                for(integer j=0; j<empleados.size(); j++)
                {
                    if(todos[i].Identidad__C==empleados[j].empleado2__r.identificacion__c)
                    {
                        si='No';
                       NuevosSueldos.add(new planilla(empleados[j].id, empleados[j].empleado2__r.identificacion__c, empleados[j].empleado2__r.firstname,
                                                      '',empleados[j].empleado2__r.lastname, '', empleados[j].Salario__c, todos[i].salario__c));
                        j=empleados.size();
                        
                        total +=todos[i].salario__c;
                    }
                    
                }
                if(si=='Si')
                {
                    g = new Sueldos_Temporales__c();
                    g.Identidad__C=todos[i].identidad__c;
                    g.Salario__C=todos[i].salario__C;
                    sueldosrepetidos.add(g);
                }
            }
            Identidades =new list<string>();
            for(integer ii=0; ii<SueldosRepetidos.size(); ii++)
            {
                identidades.add(SueldosRepetidos[ii].Identidad__C);
            }
           if(SueldosRepetidos.size()>0)
           {
               Mensaje='En estos empleados se encuentran identidades que no pertenecen a sus empleados';
               ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, mensaje));
               list<Account> empleadoConsulta = aSysdePortalEmpresarial.agregarPersonaPlanilla(Identidades);
               for(integer i=0; i<empleadoConsulta.size(); i++)
                {
                        for(integer j=0; j<SueldosRepetidos.size(); j++)
                        {
                            if(empleadoConsulta[i].identificacion__C==SueldosRepetidos[j].identidad__C && empleadoConsulta[i].firstname != 'null null')
                            {
                                SueldosRepetidos[j].name= empleadoConsulta[i].firstname;
                                SueldosRepetidos[j].apellidos__c= empleadoConsulta[i].lastname;
                                j=SueldosRepetidos.size();
                            }
                        }
                    }
                
           }
            mostrarbotones=false;
           mostrartabla=true;
          //PAginaciones
             mostrarBotonesp=false;
             mostrarAnterior=true;
             mostrarSiguiente=true;
            MNuevosSueldos = new list<planilla>();
            contadorpaginacion=0;
            if(NuevosSueldos.size()>100)
           {
                contadorpaginacion ++;
               	mostrarBotonesp=true;
                mostrarSiguiente=false;
                for(integer i=0; i<100; i++)
                {
                    
                    MNuevosSueldos.add(NuevosSueldos[i]);
                }
           }
           else
           {
              for(integer i=0; i<NuevosSueldos.size(); i++)
                {
                    
                    MNuevosSueldos.add(NuevosSueldos[i]);
                } 
           }

        }catch(exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, ''+ex.getLineNumber()));
        }
    }
    
     public void siguiente() 
    {
        try{
             usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            if((contadorpaginacion + 1)*100 > NuevosSueldos.size())
            {
                contadorpaginacion ++;
                MNuevosSueldos = new list<planilla>();
                mostrarSiguiente=true;
                mostraranterior=false;
                 for(integer i=(contadorpaginacion - 1)*100; i<NuevosSueldos.size(); i++)
                {
                   
                    MNuevosSueldos.add(NuevosSueldos[i]);
                } 
                
                
            }
            else
            {
                 mostraranterior=false;
                 contadorpaginacion ++;
                MNuevosSueldos = new list<planilla>();
                 for(integer i=(contadorpaginacion - 1)*100; i<contadorpaginacion*100; i++)
                {
                   MNuevosSueldos.add(NuevosSueldos[i]);
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
             usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            if((contadorpaginacion - 1)*100 < 101)
            {
                mostrarsiguiente=false;
                mostrarAnterior=true;
                MNuevosSueldos = new list<planilla>();
                for(integer i=0; i<100; i++)
                {
                    MNuevosSueldos.add(NuevosSueldos[i]);
                } 
                contadorpaginacion --;
            }
            else
            {
                MNuevosSueldos = new list<planilla>();
               for(integer i=(contadorpaginacion - 2)*100; i<(contadorpaginacion-1) *100; i++)
                {
                    MNuevosSueldos.add(NuevosSueldos[i]);
                }  
                contadorpaginacion --;
                 mostrarSiguiente=false;
            }
        }
        catch(Exception ex)
        {
            
        }
    }
    
    
    
    
    @RemoteAction
   global static classWRetorno2 SubirInformacion(String stringCSV, string empresa){
           classWRetorno2 retorno = new classWRetorno2();
           
       try
       {
           //system.debug(empresa);
           if(empresa=='No')
           {
               empresa = [select name from sueldo_temporal__C order by createddate desc limit 1].name;
               //empresa='0011100001Nt8TT';
           }
            system.debug(empresa);
           retorno.ERROR='Ya puede ver su nuevo archivo';
             stringCSV.replace('\'', '');
             stringCSV.replace('´', '');
             list<string> clientes = new  list<string>();
             list<string> identidad = new  list<string>();
             list<string> salarios = new  list<string>();
             clientes = stringCSV.split('\n');
             integer a=15;
             integer b=15;
            list<string> yeah;
            list<string> control;
            list<Planilla> duplicado = new list<Planilla>();
            control= new  list<string>();
          string lo=clientes[0];
            clientes.remove(0);
          control =lo.split(',');
          for(integer i=0; i<control.size(); i++)
            {
                
                control[i]=control[i].replace('"','');
                control[i]=control[i].replace('  ',' ');
                control[i]=control[i].Trim();
                if(control[i].toUpperCase()=='NUM IDENTIDAD' || control[i].toUpperCase()=='IDENTIFICACION'
                   || control[i].toUpperCase()=='IDENTIFICACIÓN' || control[i].toUpperCase()=='NUMERO IDENTIDAD')
                {
                    a=i;
                }
                if(control[i].toUpperCase()=='SALARIO' || control[i].toUpperCase()=='SUELDO' ||control[i].toUpperCase()=='SALARIOS')
                {
                    b=i;
                }
                identidad = new list<string>();
                
            } 
        if(a !=15 && b!=15)
          {
              list<string> sala;
              Sueldo_Temporal__c poo=new Sueldo_Temporal__c();
              poo.name=empresa;
              insert poo;
              list<sueldos_Temporales__c> Nuevos= new list<sueldos_Temporales__c>();
              sueldos_Temporales__c l;
              for(integer i=0; i<clientes.size(); i++)
            	{
                	string h=clientes[i].replace(' ', '');
                	yeah= new  list<string>();
                	sala= new list<string>();
                	control= new  list<string>();
                	h=h.replace(',,','').Trim();
                	if(h.length()>1){
                    	yeah=h.split(',');
                    	yeah[a]=yeah[a].replace(',','');
                    	yeah[a]=yeah[a].replace('"','');
                    	if(yeah[a]!=''  && yeah[a].length()>7)
                    	{
                    		l = new sueldos_Temporales__c();
                     		l.Salario_temporal__c=poo.id;
                     		l.Identidad__c=yeah[a].replace('-','');
                    		duplicado.add(new Planilla(yeah[a].replace('-',''),0));
                    
                    		try{
                        			decimal he=decimal.valueOf(yeah[b]);
                        			l.Salario__c=decimal.valueOf(yeah[b]);
                        
                   				}
                    			catch(Exception ex)
                    			{
                        			try{
                             				l.Salario__c=decimal.valueOf(yeah[b].replace('"','').Trim());
                        				}
                        				catch(Exception exy)
                        				{
                            				l.Salario__c=0;
                        				}
                    			}
                   nuevos.add(l); 
                    
                }
                }
            }
            
              insert nuevos;
          }
       else
       {
           retorno.error='Las columnas no traen el nombre correcto';
       }
       }
       catch(exception ex)
       {
           //retorno.error='Hubo un error al subir los nuevos salarios';
           retorno.error=ex.getLineNumber()+'  '+ex.getMessage();
           return retorno;
       }
       return retorno;
       
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
        i=0;i=0;
        i=0;
        i=0;
        i=0;i=0;
        i=0;
        i=0;
        i=0;i=0;
        i=0;
        i=0;
        i=0;
    }
    
    
    
    
    
}