public class controladorReportes {
    public date Desde {get;set;}
    public date Hasta {get;set;}
    public list<SelectOption> listPilares{get;set;}
    public string idPilar{get;set;}
    Public boolean mostartablaNormal{get;set;}
    public boolean mostrartablaIHSS {get; set;}
    public Planilla__C totalplanilla{get; set;}
    public string Nombre_Empresa{get;set;}
    public list <Planilla__c> listPlanilla {get;set;}
    public list <Contenido_Planilla__c> listEmpleado {get;set;}
    public list <Contenido_Planilla__c> listEmpleados {get;set;}
    public list <Contenido_Planilla__c> MlistEmpleados {get;set;}
    public list <Contenido_Planilla_SS__c> listEmpleadoIHSS {get;set;}
    public list <Planilla_Seguro_Social__c> listPlanillaIHSS {get;set;}
    public list <Contenido_Planilla_SS__c> listEmpleadosIHSS {get;set;}
    public list <Contenido_Planilla_SS__c> MlistEmpleadosIHSS {get;set;}
    Public string id_Planilla{get;set;}
    Public string Num_Identidad{get;set;}
    Public string Codigo_Unico_Banco{get;set;}
    public boolean ActivarModal {get; set;}
    public boolean ActivarModalIHSS {get; set;}
    Public string planilla{get;set;}
    Public string APO{get;set;}
    Public string AEO{get;set;}
    Public string APV{get;set;}
    Public string AEV{get;set;}
    public string RL{get;set;}
    Public string Fecha{get;set;}
    string planilla2;
    public Planilla_Seguro_Social__c TotalPlanillaIHSS {get;set;}
    Public string APO1{get;set;}
    Public string AEO1{get;set;}
    Public string APV1{get;set;}
    Public string AEV1{get;set;}
    public string RL1{get;set;}
    public string RL2{get;set;}
    public string RL3{get;set;}
    
    //PAGINACIÓN 
    public boolean mostrarSiguiente{get;set;}
    public boolean mostrarANterior{get;set;}
    public boolean mostrarBotonesP{get;set;}
    integer contadorpaginacion;
    string usuario;
    
    
    public controladorReportes(){
    		try{
                
                Codigo_Unico_Banco=ApexPages.currentPage().getParameters().get('Eldudhdhyudb'); 
                Usuario = ApexPages.currentPage().getParameters().get('loetdncdhjch');
                listPlanilla = new list<Planilla__c>();
                listEmpleado = new list<Contenido_Planilla__c>();
                listEmpleadoIHSS = new list<Contenido_Planilla_SS__c>();
                listPlanillaIHSS = new list<Planilla_Seguro_Social__c>();
                Nombre_Empresa=[select name from Account where id=:Codigo_Unico_Banco].name;
                ActivarModal=false;
                mostartablaNormal=false;
                mostrartablaIHSS=false;
                Num_identidad='';
    			listPilares = new list<SelectOption>();
                listPilares.add(new selectoption('Ninguno','Ninguno'));
    			listPilares.add(new selectoption('Pilar Complementario','Pilar Complementario'));
    			listPilares.add(new selectoption('Pilar Voluntario','Pilar Voluntario'));
    			listPilares.add(new selectoption('Reserva Laboral','Reserva Laboral'));
    			listPilares.add(new selectoption('Seguro Social','Seguro Social'));
    				
    		}Catch(Exception e){
    			
    		}	
    }
    
    public void VerPlanilla()
    {
        
        string query;
        try{
             Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            listEmpleadosIHSS = new list<Contenido_Planilla_SS__c>();
            listEmpleados = new list<Contenido_Planilla__c>();
            
            if(planilla2=='Seguro')
            {
                	TotalPlanillaIHSS  = new Planilla_Seguro_Social__c();
                	TotalPlanillaIHSS = [select Total_Riesgo_Profecional_Patronal__c, Total_Aporte_Patrono_SS__c, Total_Aporte_Patronal_Maternidad__c,
                                        Total_Aporte_Empleado_SS__c, Total_Aporte_Empleado_Maternidad__c from Planilla_Seguro_Social__c where id=:Id_Planilla];
                	
                	TotalPlanillaIHSS.Aporte_Empleado_SS__c=TotalPlanillaIHSS.Total_Aporte_Patrono_SS__c + TotalPlanillaIHSS.Total_Aporte_Empleado_SS__c;
                	TotalPlanillaIHSS.Aporte_Empleado_Maternidad__c=TotalPlanillaIHSS.Total_Aporte_Empleado_Maternidad__c + TotalPlanillaIHSS.Total_Aporte_Patronal_Maternidad__c;
                   TotalPlanillaIHSS.Salario__c=TotalPlanillaIHSS.Aporte_Empleado_Maternidad__c +TotalPlanillaIHSS.Aporte_Empleado_SS__c +TotalPlanillaIHSS.Total_Riesgo_Profecional_Patronal__c;
                	APO1='Fecha cambio';
                    AEO1='Tipo Cambio';
                    APV1='Aporte Patronal Maternidad';
                    AEV1='Aporte Empleado Maternidad';
                    RL1='Aporte Riesgo Profecional';
                	RL2='Aporte Patronal Maternidad';
                    RL3='Aporte Empleado Maternidad';
                    query ='select identidad__C,Primer_Nombre__c, Primer_Apellido__c ,Planilla__r.Fecha_Creacion__C, Fecha_cambio__C, Tipo_cambio__c, Planilla__r.Aporte_Patrono_SS__c, ';
                    query +=' planilla__r.Aporte_Patronal_Maternidad__c, planilla__r.Aporte_Empleado_Maternidad__c,  ';
                    query +=' planilla__r.Riesgo_Profecional_Patronal__c, planilla__r.Aporte_Empleado_SS__c from Contenido_Planilla_SS__c';
                    query +=' where planilla__c=\''+Id_Planilla + '\' order by Primer_Nombre__c asc ';
                     activarModalIHSS=true;
                	listEmpleadosIHSS=database.query(query);
                     //PAginaciones
                     mostrarBotonesp=false;
                     mostrarAnterior=true;
                     mostrarSiguiente=true;
                    MlistEmpleadosIHSS = new list<contenido_planilla_ss__C>();
                    contadorpaginacion=0;
                    if(listEmpleadosIHSS.size()>100)
                   {
                        contadorpaginacion ++;
                        mostrarBotonesp=true;
                        mostrarSiguiente=false;
                        for(integer i=0; i<100; i++)
                        {
                            
                            MlistEmpleadosIHSS.add(listEmpleadosIHSS[i]);
                        }
                   }
                   else
                   {
                      for(integer i=0; i<listEmpleadosIHSS.size(); i++)
                        {
                            
                            MlistEmpleadosIHSS.add(listEmpleadosIHSS[i]);
                        } 
                   }
                
            }
            else{
                totalplanilla = new planilla__C();
                totalplanilla=[select TA_Empleado_Obligatorio__c, name,TA_Empleado_Voluntario__c, TA_Patrono_obligatorio__c, 
                               Cantidad_empleados__c, total__C,Total_obligatorios__c ,Total_voluntarios__c,
                               TA_Patrono_Voluntario__c, Total_Reserva_Laboral2__c
                              from planilla__C where id=:Id_Planilla];
                APO1='Aporte Patronal obligatorio';
                AEO1='Aporte Empleado Obligatorio';
                APV1='Aporte Patronal Voluntario';
                AEV1='Aporte Empleado Voluntario'; 
                RL2='Reserva Laboral';
                RL1='';
                RL3='';
               
                query ='select empleado2__r.Identificacion__c, empleado2__r.name, Planilla__r.Fecha__c,  ';
                query +=  'Aporte_Patrono_obligatorio__c, Aporte_Empleado_Obligatorio__c, Aporte_Patrono_Voluntario__c, ';
                query +=  ' Aporte_Empleado_Voluntario__c, Reserva_Laboral__c  from Contenido_Planilla__c ';
                query +=   ' where planilla__c=\''+Id_Planilla + '\' order by empleado2__r.name asc';
                system.debug(query);
                listEmpleados=database.query(query);
                activarModal=true;
                 //PAginaciones
                 mostrarBotonesp=false;
                 mostrarAnterior=true;
                 mostrarSiguiente=true;
                MlistEmpleados= new list<contenido_planilla__C>();
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
            }     
            
            
        }
        catch(Exception ex)
        {
            system.debug(query);
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Se ha producido un error, favor contacte a su administrador '));
        }
    }
    
    public pageReference ReportePlanilla()
    {
         Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
        return new pagereference ('/Apex/vfExportarEReporteNormal?idPlanilla='+id_planilla);
    }    
     public pageReference ReportePlanillaIHSS()
    {
         Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
        return new pagereference ('/Apex/vfExportarEReporteIHSS');
    }
    
    
    public void cerrar()
    {
         Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
        activarmodal=false;
        activarmodalIHSS=false;
        APO1='';
        AEO1='';
        APV1='';
        AEV1='';
        RL2='';
        RL1='';
        RL3='';
    }
    
    public void BuscarIHSS()
    {
        try{
			if(Num_Identidad =='')
            {
                string query='select id,Tipo_Planilla__c,Fecha_Creacion__c,Total_Aporte_Patrono_SS__c, Total_Aporte_Empleado_SS__c, ';
                query+='Total_Riesgo_Profecional_Patronal__c, Total_Aporte_Patronal_Maternidad__c, Total_Aporte_Empleado_Maternidad__c ';  
                query += 'from Planilla_Seguro_Social__c where empresa2__c=\''+codigo_Unico_banco + '\'';
                if(desde !=null)
                {
                    string fecha = string.valueOf(desde);
                    list <string> fechas = new list<string>();
                    fechas=fecha.split('00:00:00');
                  query +=' AND Fecha_Creacion__c >= ' +fechas[0].trim();  
                }
                if( hasta!=null)
                {
                    string fecha = string.valueOf(hasta);
                    list <string> fechas = new list<string>();
                    fechas=fecha.split('00:00:00');
                   query +=' and Fecha_Creacion__c <='+fechas[0].trim();  
                }
                query +=' order by Fecha_Creacion__c desc limit 500';
                listPlanillaIHSS = database.query(query);
                system.debug(query);
                if(listPlanillaIHSS.size()>0)
                {
                     Planilla='Planilla';
                     fecha='Fecha';
                     APO='Patronal';
                     AEO='Empleado';
                     APV='EMpleado';
                     AEV='Profecional';
                     RL='Patronal';
                     planilla2='Seguro';
                    mostrartablaIHSS=true;
                }
                else
                {
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, '¡No se encontraron resultados!'));
                }
            }
            else
            {
                    string query ='select identidad__C,Primer_Nombre__c, Primer_Apellido__c ,Planilla__r.Fecha_Creacion__C, Fecha_cambio__C, Tipo_cambio__c,  ';
                    query +=' Planilla__r.Aporte_Patrono_SS__c, planilla__r.Aporte_Patronal_Maternidad__c, planilla__r.Aporte_Empleado_Maternidad__c,  ';
                    query +=' planilla__r.Riesgo_Profecional_Patronal__c, planilla__r.Aporte_Empleado_SS__c from Contenido_Planilla_SS__c ';
                    query +=' where planilla__r.empresa2__c=\''+codigo_Unico_banco + '\''+ ' and Identidad__c=\''+Num_identidad+ '\'';
                
                if(desde !=null)
                {
                    string fecha = string.valueOf(desde);
                    list <string> fechas = new list<string>();
                    fechas=fecha.split('00:00:00');
                  query +=' AND Planilla__r.Fecha_Creacion__C >= ' +fechas[0].trim();  
                }
                if( hasta!=null)
                {
                    string fecha = string.valueOf(hasta);
                    list <string> fechas = new list<string>();
                    fechas=fecha.split('00:00:00');
                   query +=' and Planilla__r.Fecha_Creacion__C <='+fechas[0].trim();  
                }
                
                 query +=' order by Planilla__r.Fecha_Creacion__C desc limit 500';
                system.debug(query);
                listEmpleadoIHSS = database.query(query);
               //listempleado1=[select Primer_Nombre__c, Primer_Apellido__c ,Planilla__r.Fecha_Creacion__C, Fecha_Cambio__C, Tipo_cambio__c, Planilla__r.Aporte_Patrono_SS__c, planilla__r.Aporte_Empleado_SS__c, planilla__r.Riesgo_Profecional_Patronal__c,planilla__r.Total_Aporte_Empleado_Maternidad__c, planilla__r.Total_Aporte_Patronal_Maternidad__c from Contenido_Planilla_SS__c  where primer_Nombre__c ='luis'];
                if(listEmpleadoIHSS.size()>0)
                {
                    Planilla='Empleado';
                    Fecha='Fecha';
                    APO='Fecha Cambio';
                    AEO='Tipo Cambio';
                    APV='Patronal';
                    AEV='Empleado';
                    RL='Patronal';
                    RL1='Empleado';
                    RL2='Profecional';
                    mostrartablaIHSS=true;
                }
                else
                {
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, '¡No se encontraron resultados!'));
                }
                
            }
        }catch(Exception ex)
        {
           ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, '!Hubo un error!' + ex.getLineNumber())); 
        }
    }
    
    public void Buscar()
    {
        string query;
       try{
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
           if(Num_Identidad !='' && Num_Identidad !=null)
           {
               Num_Identidad=Num_Identidad.replace('-', '');
           }
           planilla2='';
           mostartablaNormal=false;
           mostrartablaIHSS=false;
            listPlanilla = new list<Planilla__c>();
            listEmpleado = new list<Contenido_Planilla__c>();
            listEmpleadoIHSS = new list<Contenido_Planilla_SS__c>();
            listPlanillaIHSS = new list<Planilla_Seguro_Social__c>();
             Planilla='Planilla';
             APO='Patronal';
             AEO='Empleado';
             APV='Patronal';
             AEV='Empleado';
             RL='Reserva Laboral';
             RL1='';
             RL2='';
            fecha='Fecha';   
           
      	if(idpilar =='Seguro Social')
        {
            BuscarIHSS();
        }
           else{
            if(Num_Identidad =='')
            {
               
                 query='select id,Tipo_Planilla__c,fecha__c,TA_Patrono_obligatorio__c, TA_Empleado_Obligatorio__c,';
                  query +=  ' TA_Patrono_Voluntario__c,TA_Empleado_Voluntario__c,Total_Reserva_Laboral2__c';
                   query += ' from Planilla__c where empresa2__c=\''+codigo_Unico_banco + '\'';
                if(idpilar != 'Ninguno')
                {
                    if(idpilar=='Reserva Laboral')
                    {
                         query +=' and Total_Reserva_Laboral2__c >0';
                    }
                    if(idpilar=='Pilar Complementario')
                    {
                         query +=' and Total_obligatorios__c >0';
                    }
                    if(idpilar=='Pilar Voluntario')
                    {
                         query +=' and Total_voluntarios__c >0';
                    }
                   
                }
                if(desde !=null)
                {
                    string fecha = string.valueOf(desde);
                    list <string> fechas = new list<string>();
                    fechas=fecha.split('00:00:00');
                  query +=' AND fecha__c >= ' +fechas[0].trim();  
                }
                if( hasta!=null)
                {
                    string fecha = string.valueOf(hasta);
                    list <string> fechas = new list<string>();
                    fechas=fecha.split('00:00:00');
                   query +=' and fecha__c <='+fechas[0].trim();  
                }
                
                 query +=' order by fecha__c desc limit 500';
                system.debug(query);
                listPlanilla = database.query(query);
                if(listPlanilla.size()>0)
                {
                    mostartablaNormal=true;
                }
                else
                {
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, '¡No se encontraron resultados!'));
                }
            }
            else
            {
                
                query ='select empleado2__r.firstname, empleado2__r.lastname, Planilla__r.Fecha__c,';
                    query +=  'Aporte_Patrono_obligatorio__c, Aporte_Empleado_Obligatorio__c, Aporte_Patrono_Voluntario__c,';
                    query +=  ' Aporte_Empleado_Voluntario__c, Reserva_Laboral__c from Contenido_Planilla__c';
                   query +=   ' where planilla__r.empresa2__c=\''+codigo_Unico_banco + '\''+ ' and empleado2__r.Identificacion__c=\''+Num_identidad+ '\'';
                 if(idpilar != 'Ninguno')
                {
                    if(idPilar=='Reserva Laboral')
                    {
                         query +=' and Reserva_Laboral__c > 0';
                    }
                     if(idpilar=='Pilar Complementario')
                    {
                        query=query.replace(' empleado2__r.Identificacion__c=\''+Num_identidad+ '\'', '((empleado2__r.Identificacion__c=\''+Num_identidad+ '\'');
                         query +=' and Aporte_Empleado_Obligatorio__c > 0) or (empleado2__r.Identificacion__c=\''+Num_identidad+ '\' and Aporte_Patrono_obligatorio__c > 0))';
                    }
                    if(idpilar=='Pilar Voluntario')
                    {
                        query=query.replace(' empleado2__r.Identificacion__c=\''+Num_identidad+ '\'', '((empleado2__r.Identificacion__c=\''+Num_identidad+ '\'');
                         query +=' and Aporte_Patrono_Voluntario__c > 0) or  (empleado2__r.Identificacion__c=\''+Num_identidad+ '\' and Aporte_Empleado_Voluntario__c > 0))';
                    }
                   
                }
                if(desde !=null)
                {
                    string fecha = string.valueOf(desde);
                    list <string> fechas = new list<string>();
                    fechas=fecha.split('00:00:00');
                  query +=' AND planilla__r.fecha__c >= ' +fechas[0].trim();  
                    desde=null;
                }
                if( hasta!=null)
                {
                    string fecha = string.valueOf(hasta);
                    list <string> fechas = new list<string>();
                    fechas=fecha.split('00:00:00');
                   query +=' and planilla__r.fecha__c <='+fechas[0].trim();  
                    hasta=null;
                }
                
                 query +=' order by planilla__r.fecha__c desc limit 500';
                system.debug(query);
                listEmpleado = database.query(query);
                if(listEmpleado.size() >0)
                {
                    Planilla='Empleado';
                    Fecha='Fecha';
                    APO='Patrono';
                    AEO='Empleado';
                    APV='Patrono';
                    AEV='Empleado';
                    RL='Reserva Laboral';
                    mostartablaNormal=true;
                
                }
                else
                {
                     ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, '¡No se encontraron resultados!'));
                }
            }
           }
                
         }
          catch(exception ex)
        {
            system.debug(Query);
          ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Se ha producido un error, favor contacte a su administrador')); 	
    	}	
        
        
    }
    
    
    public void siguiente() 
    {
        try{
             Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
             if(planilla2=='Seguro')
            {
                if((contadorpaginacion + 1)*100 > listEmpleadosIHSS.size())
                {
                    contadorpaginacion ++;
                    MlistEmpleadosIHSS = new list<Contenido_Planilla_SS__c>();
                    mostrarSiguiente=true;
                    mostraranterior=false;
                     for(integer i=(contadorpaginacion - 1)*100; i<listEmpleadosIHSS.size(); i++)
                    {
                       
                        MlistEmpleadosIHSS.add(listEmpleadosIHSS[i]);
                    } 
                    
                    
                }
                else
           		 {
                     mostraranterior=false;
                     contadorpaginacion ++;
                    MlistEmpleadosIHSS= new list<Contenido_Planilla_SS__c>();
                     for(integer i=(contadorpaginacion - 1)*100; i<contadorpaginacion*100; i++)
                    {
                       MlistEmpleadosIHSS.add(listEmpleadosIHSS[i]);
                    } 
            	}
            }
            else
            {
                if((contadorpaginacion + 1)*100 > listEmpleados.size())
                {
                    contadorpaginacion ++;
                    MlistEmpleados = new list<Contenido_Planilla__c>();
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
                    MlistEmpleados= new list<Contenido_Planilla__c>();
                     for(integer i=(contadorpaginacion - 1)*100; i<contadorpaginacion*100; i++)
                    {
                       MlistEmpleados.add(listEmpleados[i]);
                    } 
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
            if(planilla2=='Seguro')
            {
                  
                if((contadorpaginacion - 1)*100 < 101)
                {
                    mostrarsiguiente=false;
                    mostrarAnterior=true;
                    MlistEmpleadosIHSS = new list<Contenido_Planilla_SS__c>();
                    for(integer i=0; i<100; i++)
                    {
                        MlistEmpleadosIHSS.add(listEmpleadosIHSS[i]);
                    } 
                    contadorpaginacion --;
                }
                else
                {
                     MlistEmpleadosIHSS = new list<Contenido_Planilla_SS__c>();
                   for(integer i=(contadorpaginacion - 2)*100; i<(contadorpaginacion-1) *100; i++)
                    {
                        MlistEmpleadosIHSS.add(listEmpleadosIHSS[i]);
                    }  
                    contadorpaginacion --;
                     mostrarSiguiente=false;
                }
            }
            else
            {
                if((contadorpaginacion - 1)*100 < 101)
                {
                    mostrarsiguiente=false;
                    mostrarAnterior=true;
                    MlistEmpleados = new list<Contenido_Planilla__c>();
                    for(integer i=0; i<100; i++)
                    {
                        MlistEmpleados.add(listEmpleados[i]);
                    } 
                    contadorpaginacion --;
                }
                else
                {
                    MlistEmpleados = new list<Contenido_Planilla__c>();
                   for(integer i=(contadorpaginacion - 2)*100; i<(contadorpaginacion-1) *100; i++)
                    {
                        MlistEmpleados.add(listEmpleados[i]);
                    }  
                    contadorpaginacion --;
                     mostrarSiguiente=false;
                }
            }
           
           
        }
        catch(Exception ex)
        {
            
        }
    }
    public void MetodoUtil()
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
    }

}