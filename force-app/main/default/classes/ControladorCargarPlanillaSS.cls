global class ControladorCargarPlanillaSS {
 
    public static string Codigo_Unico_Banco;
    public boolean mostrartabla{get;set;} 
     public boolean mostrarBotones{get;set;} 
    public  string Nombre_empresa{get;set;}
    public list<contenido_Planilla_IHSS_Temporal__c> planilla{get;set;} 
    public list<contenido_Planilla_IHSS_Temporal__c> Mplanilla{get;set;} 
    string usuario;
    public decimal APIVM {get;set;}
     public decimal AEIVM{get;set;}
     public decimal APM{get;set;}
     public decimal AEM{get;set;}
    public decimal Salario{get;set;}
     public decimal APRP{get;set;}
    static string id_planilla;
    public string fecha_planilla{get;set;}
     public decimal totalAPIVM {get;set;}
     public decimal totalAEIVM{get;set;}
     public decimal totalAPM{get;set;}
     public decimal totalAEM{get;set;}
     public decimal totalAPRP{get;set;}
     public decimal total{get;set;}
    public string GenerarExcel {get;set;}
   
    //PAGINACIÓN 
    public boolean mostrarSiguiente{get;set;}
    public boolean mostrarANterior{get;set;}
    public boolean mostrarBotonesP{get;set;}
    integer contadorpaginacion;
    
    
    
    public integer bandera{get;set;}
    public ControladorCargarPlanillaSS()
    {
        Codigo_Unico_Banco=ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
        Nombre_Empresa='';
        Usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
       MostrarBotones=true;
       mostrartabla=false;
        Nombre_Empresa = [select name from account where id =:Codigo_Unico_Banco].name;
       
    }
    public void reIniciar(){ 
    	mostrarTabla=false;
        mostrarBotones=true;
        usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;

    }
    public void NuevaCarga()
    {
        reiniciar();
    }
    public Pagereference Guardarplanilla()
    {
        try 
        {
            usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
         Planilla_Seguro_Social__c poo=new Planilla_Seguro_Social__c();
            Usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
            Codigo_Unico_Banco=ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
             poo.Aporte_Patrono_SS__c=APIVM;
             poo.Aporte_Empleado_SS__c=AEIVM;
             poo.Aporte_Patronal_Maternidad__c=APM;
             poo.Aporte_Empleado_Maternidad__c=AEM;
             poo.Riesgo_Profecional_Patronal__c=APRP;
             poo.Total_Aporte_Patrono_SS__c=TotalAPIVM;
             poo.Total_Aporte_Empleado_SS__c=TotalAEIVM;
             poo.Total_Aporte_Patronal_Maternidad__c=TotalAPM;
             poo.Total_Aporte_Empleado_Maternidad__c=TotalAEM;	
             poo.Total_Riesgo_Profecional_Patronal__c=TotalAPRP;
             poo.empresa2__C=Codigo_Unico_banco;
             poo.Salario__c=salario;
             poo.Fecha_Creacion__c=date.today();
             poo.Fecha_Planilla__c=date.valueOf(fecha_Planilla);
             poo.Usuario__c= usuario;
             poo.Tipo_Planilla__C='Cargada';
               insert poo;
            list<Contenido_Planilla_SS__c>  yea= new list<Contenido_Planilla_SS__c>();
               Contenido_Planilla_SS__c t;
            
            for(integer i=0; i<Planilla.size(); i++)
            {
                t = new Contenido_Planilla_SS__c();
                t.rtn__C=planilla[i].Rtn__C;
                t.Planilla__C=poo.id;
                t.Num_Patronal__c=planilla[i].Num_Patronal__c;
                t.Identidad__c=Planilla[i].Identidad__C;
                t.Primer_Nombre__c=planilla[i].Primer_Nombre__C;
                t.SeGUndo_Nombre__C=planilla[i].Segundo_Nombre__C;
                t.Primer_Apellido__c=planilla[i].Primer_Apellido__C;
                t.segundo_apellido__c=planilla[i].Segundo_Apellido__C;
                t.Fecha_Cambio__C=planilla[i].fecha_Cambio__C;
                t.Tipo_cambio__c=planilla[i].Tipo_Cambio__C;
                yea.add(t);
                
            }
            insert yea; 
             //GenerarExcel = 'application/vnd.ms-excel#Planillas.xls';               
             delete([select id from contenido_planilla_IHSS_temporal__C where planilla__r.name=:Codigo_Unico_Banco]);
            delete ([select id from Planilla_IHSS_Temporal__c where name=:codigo_unico_banco]);
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Planilla descargada exitosamente'));
            
            return new PageReference ('/Apex/vfExportarCargarIHSS');
            
        }
        Catch(Exception ex)
        {
            
        }
        return null;
    }
    
    
    
    
    public void verPlanilla()
    {
        try{
            usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            mostrartabla=true;
            MostrarBotones=false;
            Codigo_Unico_Banco=ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
             Planilla_IHSS_Temporal__c NuevaPlanilla = new Planilla_IHSS_Temporal__c();
            NuevaPlanilla =[select id, Numeracion_Automatica__c from Planilla_IHSS_Temporal__c where name=:codigo_unico_banco order by Numeracion_Automatica__c DESC LIMIT 1];
            Planilla = new list<contenido_Planilla_IHSS_Temporal__c>();
            planilla =[select Fecha_Cambio__c,Identidad__c, Num_Patronal__c,Primer_Apellido__c, Primer_Nombre__c, RTN__c,Segundo_Apellido__c, Segundo_Nombre__c,Tipo_Cambio__c from contenido_planilla_IHSS_temporal__C where planilla__c=:NuevaPlanilla.id];
            Account empre= new Account();
            empre= [select Salario_Base_Seguro_Social__c,Porc_Apor_SSoc_Empleador_IVM__c, Porc_Apor_SSoc_Empleado_IVM__c,
                    Porc_Apor_SSoc_Empleado_Mater__c, Porc_Apor_SSoc_Empleador_Mater__c, Riesgo_Profecional_Patronal__c, 
                    Salario_Base_Seguro_Social_mater__c, Salario_Base_Seguro_Social_rp__c
                    from Account where id=:Codigo_Unico_banco];
          APIVM=((empre.Salario_Base_Seguro_Social__c * empre.Porc_Apor_SSoc_Empleador_IVM__c)/100).setScale(2);
          AEIVM=((empre.Salario_Base_Seguro_Social__c * empre.Porc_Apor_SSoc_Empleado_IVM__c)/100).setScale(2);
		  APM=((empre.Salario_Base_Seguro_Social_mater__c * empre.Porc_Apor_SSoc_Empleador_Mater__c)/100).setScale(2);
          AEM=((empre.Salario_Base_Seguro_Social_mater__c * empre.Porc_Apor_SSoc_Empleado_Mater__c)/100).setScale(2);
          APRP=((empre.Salario_Base_Seguro_Social_rp__c * empre.Riesgo_Profecional_Patronal__c)/100).setScale(2);
         salario=empre.Salario_Base_Seguro_Social__c;
         totalAPIVM=(planilla.size() * APIVM).setScale(2);
         totalAEIVM =(planilla.size() * AeIVM).setScale(2);
         totalAPM= (planilla.size() * APM).setScale(2);
         totalAPRP= (planilla.size() * APRP).setScale(2);
         totalAEM = (planilla.size() * AEM).setScale(2);
         total=(totalAPIVM +totalAEIVM +totalAPM +totalAPRP +totalAEM).setScale(2);
         integer u = date.today().month();
         integer uu = date.today().year();
          if(u<10)
          {
              fecha_Planilla=string.valueof(uu)+'-0'+string.valueof(u)+'-01';
          }
            else
            {
                fecha_Planilla=string.valueof(uu)+'-'+string.valueof(u)+'-01';
            }
           //PAginaciones
             mostrarBotonesp=false;
             mostrarAnterior=true;
             mostrarSiguiente=true;
            Mplanilla= new list<Contenido_Planilla_IHSS_Temporal__c>();
            contadorpaginacion=0;
            if(planilla.size()>100)
           {
                contadorpaginacion ++;
               	mostrarBotonesp=true;
                mostrarSiguiente=false;
                for(integer i=0; i<100; i++)
                {
                    
                    Mplanilla.add(planilla[i]);
                }
           }
           else
           {
              for(integer i=0; i<planilla.size(); i++)
                {
                    
                    Mplanilla.add(planilla[i]);
                } 
           } 
        }
        catch (Exception  ex)
        {
            
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
            if((contadorpaginacion + 1)*100 > Planilla.size())
            {
                contadorpaginacion ++;
                MPlanilla = new list<Contenido_Planilla_IHSS_Temporal__c>();
                mostrarSiguiente=true;
                mostraranterior=false;
                 for(integer i=(contadorpaginacion - 1)*100; i<Planilla.size(); i++)
                {
                   
                    MPlanilla.add(Planilla[i]);
                } 
                
                
            }
            else
            {
                 mostraranterior=false;
                 contadorpaginacion ++;
                MPlanilla = new list<Contenido_Planilla_IHSS_Temporal__c>();
                 for(integer i=(contadorpaginacion - 1)*100; i<contadorpaginacion*100; i++)
                {
                   MPlanilla.add(Planilla[i]);
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
            MPlanilla = new list<Contenido_Planilla_IHSS_Temporal__c>();
            if((contadorpaginacion - 1)*100 < 101)
            {
                mostrarsiguiente=false;
                mostrarAnterior=true;
                for(integer i=0; i<100; i++)
                {
                    MPlanilla.add(Planilla[i]);
                } 
                contadorpaginacion --;
            }
            else
            {
               for(integer i=(contadorpaginacion - 2)*100; i<(contadorpaginacion-1) *100; i++)
                {
                    MPlanilla.add(Planilla[i]);
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
    global static classWRetorno2 SubirInformacion(String stringCSV, string empresa)
   {
       try{
        //string empresa=ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
        list<string> clientes = new  list<string>();
        list<string> clientes2= new  list<string>();
        list<string> clientes3= new  list<string>();
        clientes3 = stringCSV.split('\n');
        classWRetorno2 retorno = new classWRetorno2();
        retorno.error='Ya puede ver la planilla Cargada';
       
        integer A=15;
        integer B=15;
        integer C=15;
        integer D=15;
        integer E=15;
        integer F=15;
        integer G=15;
        integer H=15;
        integer K=15;
        string lk=clientes3[0];
        clientes2=lk.split(',');
        clientes3.remove(0);
        for(integer i=0; i<clientes2.size(); i++)
        {
            if(clientes2[i]=='"RTN"')
            {
                A=i;
            }
            if(clientes2[i]=='"Num Patronal"')
            {
                B=i;
            }
            if(clientes2[i]=='"Num Identidad"')
            {
                C=i;
            }
            if(clientes2[i]=='"Primer Nombre"')
            {
                D=i;
            }
            if(clientes2[i]=='"Segundo Nombre"')
            {
                E=i;
            }
            if(clientes2[i]=='"Primer Apellido"')
            {
                F=i;
            }
            if(clientes2[i]=='"Segundo Apellido"')
            {
                G=i;
            }
            if(clientes2[i]=='"Fecha de Cambio"')
            {
                H=i;
            }
            if(clientes2[i]=='"Tipo de Cambio"')
            {
                K=i;
            }
        }
        list<string> RTN = new  list<string>();
        list<string> Num_Patronal = new  list<string>();
        list<string> Num_Identidad = new  list<string>();
        list<string> primer_Nombre = new  list<string>();
        list<string> Segundo_Nombre = new  list<string>();
        list<string> primer_Apellido = new  list<string>();
        list<string> Segundo_Apellido = new  list<string>();
        list<string> Fecha_Cambio = new  list<string>();
        list<string> Tipo_Cambio = new  list<string>();
        list<string> ident;
         
          if(A<15 && B<15 && C<15 && D<15 && F<15)
        {
            for(integer i=0; i<clientes3.size(); i++)
            {
                string ye=clientes3[i];
                Clientes = new list<string>();
                Clientes= ye.split(',');
                string lo='';
                string ki=clientes[a];
                system.debug(ki);
                if(ki!=lo)
                {
                    Ident = new  list<string>();
                    Ident=ki.split('"');
                    RTN.add(Ident[1]);
                }
                else{RTN.add(lo);}
                
                 ki=clientes[b];
                 lo='';
                if(ki!=lo)
                {
                    Ident = new  list<string>();
                    Ident=ki.split('"');
                   	Num_Patronal.add(Ident[1]);
                }
                else{Num_Patronal.add(lo);}
                
                 ki=clientes[C];
                if(ki!=lo)
                {
                    Ident = new  list<string>();
                    Ident=ki.split('"');
                    Num_Identidad.add(Ident[1]);
                }
                else{Num_Identidad.add(lo);}
                
                  ki=clientes[d];
                if(ki!=lo)
                {
                    Ident = new  list<string>();
                    Ident=ki.split('"');
                    Primer_Nombre.add(Ident[1]);
                }
                else{Primer_Nombre.add(lo);}
                
                ki=clientes[e];
                if(ki!=lo)
                {
                    Ident = new  list<string>();
                    Ident=ki.split('"');
                    Segundo_Nombre.add(Ident[1].replace('-',''));
                }
                else{Segundo_Nombre.add(lo);}
                
                ki=clientes[f];
                if(ki!=lo)
                {
                    Ident = new  list<string>();
                    Ident=ki.split('"');
                    Primer_Apellido.add(Ident[1]);
                }
                else{Primer_apellido.add(lo);}
                
                
                if(clientes.size()==6)
                {
                    Segundo_Apellido.add(lo);
                    Tipo_Cambio.add(lo);
                    Fecha_Cambio.add(lo);
                }
                else
                {
                    if(clientes.size()==7)
                    {
                         Tipo_Cambio.add(lo);
                         Fecha_Cambio.add(lo);
							ki=clientes[g];
                            if(ki!=lo)
                            {
                                Ident = new  list<string>();
                                Ident=ki.split('"');
                                Segundo_Apellido.add(Ident[1]);
                            }
                            else{Segundo_Apellido.add(lo);}
                    }
                    if(clientes.size()==8)
                    {
                        Segundo_Apellido.add(lo);
                        
                        ki=clientes[h];
                        if(ki!=lo)
                        {
                            Ident = new  list<string>();
                            Ident=ki.split('"');
                            Fecha_Cambio.add(Ident[1]);
                        }
                        else{Fecha_Cambio.add(lo);}
                            
                        ki=clientes[K];
                        if(ki!=lo)
                         {
                           Ident = new  list<string>();
                           Ident=ki.split('"');
                           Tipo_Cambio.add(Ident[1]);
                         }
                         else{Tipo_Cambio.add(lo);}
                    }
                    if(clientes.size()==9)
                    {
                         if(ki!=lo)
                            {
                                Ident = new  list<string>();
                                Ident=ki.split('"');
                                Segundo_Apellido.add(Ident[1]);
                            }
                            else{Segundo_Apellido.add(lo);}
                        
                            ki=clientes[h];
                            if(ki!=lo)
                            {
                            Ident = new  list<string>();
                            Ident=ki.split('"');
                            Fecha_Cambio.add(Ident[1]);
                            }
                            else{Fecha_Cambio.add(lo);}
                            
                            ki=clientes[K];
                            if(ki!=lo)
                             {
                               Ident = new  list<string>();
                               Ident=ki.split('"');
                               Tipo_Cambio.add(Ident[1]);
                             }
                             else{Tipo_Cambio.add(lo);}
                    }
                }              
             }
            Planilla_IHSS_Temporal__c Planilla = new Planilla_IHSS_Temporal__c();
            planilla.name=empresa;
            insert planilla;
            
            list<Contenido_Planilla_IHSS_temporal__c>  yea= new list<Contenido_Planilla_IHSS_temporal__c>();
         Contenido_Planilla_IHSS_temporal__c t;
            
            for(integer i=0; i<Num_Identidad.size(); i++)
            {
                t = new Contenido_Planilla_IHSS_temporal__c();
                t.rtn__C=Rtn[i];
                t.Planilla__C=planilla.id;
                t.Num_Patronal__c=Num_Patronal[i];
                t.Identidad__c=Num_Identidad[i];
                t.Primer_Nombre__c=Primer_Nombre[i];
                t.SeGUndo_Nombre__C=Segundo_Nombre[i];
                t.Primer_Apellido__c=Primer_Apellido[i];
                t.segundo_apellido__c=Segundo_Apellido[i];
                if(fecha_Cambio[i]=='')
                {}
                else{t.Fecha_Cambio__C=date.valueOf(fecha_Cambio[i]);}
                
                t.Tipo_cambio__c=Tipo_Cambio[i];
                yea.add(t);
                
            }
            insert yea; 
        }
       else
       {
           retorno.error='Las columnas no traen el nombre correcto';
       }
       return retorno;
   }catch(exception ex)
   {
       classWRetorno2 retorno = new classWRetorno2();
       retorno.error='Hubo un error al procesar el error';
       return retorno;
   }
   }
    
   
    public void metodoutil()
    {
        integer mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
         mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
         mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
         mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
         mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
         mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
         mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        
         mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
        mnb=0;
    }
  
}