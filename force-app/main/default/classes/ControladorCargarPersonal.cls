global class ControladorCargarPersonal {
 
    private static string Codigo_Unico_Banco{get;set;}
    public  boolean ActivarModal{get;set;}
    public list<empleados_temporales__c> empleados_temporales_Nuevos {get;set;}
    public list<empleados_temporales__c> Mempleados_temporales_Nuevos {get;set;}
    public list<empleados_temporales__c> empleados_temporales_Repetidos {get;set;}
    public  string mensaje{get;set;}
    public BOOLEAN mostrarGuardar{get;set;}
    public boolean Mostrartabla{get;set;}
    public  boolean MostrarBotones{get;set;}
     list<Cuentas_colectivas__C> listcuentas;
    public string Nombre_Empresa{get;set;}
     public  decimal total{get;set;}
    integer banderamensaje;
    public string totalempleados{get;set;}
    string Voluntarias;
    string cesantias;
    string Pcomplemetario;
    string usuario;
    
     //PAGINACIÓN 
    public boolean mostrarSiguiente{get;set;}
    public boolean mostrarANterior{get;set;}
    public boolean mostrarBotonesP{get;set;}
    integer contadorpaginacion;
    
    
    
    public ControladorCargarPersonal()
    {
        
        ActivarModal=false;
        Mostrartabla=false;
        MostrarBotones=true;
        mostrarGuardar=FALSE;
        totalempleados='';
        banderamensaje=0;
        listcuentas = new list<Cuentas_colectivas__C>();
       Codigo_Unico_Banco = ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
        Nombre_Empresa = [select name from account where id =:Codigo_Unico_Banco].name;
       listcuentas = [Select  Codigo__C, tipo_cuenta__C from Cuentas_colectivas__C where empresa__C=:Codigo_Unico_Banco];
    }
    public void reIniciar(){ 
        totalempleados='';
        usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
    	mostrarTabla=false;
        mostrarBotones=true;
        ActivarModal=false;
        mostrarGuardar= False; 
        if(banderamensaje==0)
        {
       		ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, '¡Empleados guardados con exito!'));
        }
        banderamensaje=0;

    }
    
    public void NuevaCarga()
    {
        banderamensaje=1;
        reiniciar();
    }
    
    Public void GuardarEmpleados()
    {
       try{
           
            Codigo_Unico_Banco=ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
            //string usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
			String tipoNatural = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
           usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            list<string> identidades = new list<string>();
             for(integer i=0; i<empleados_temporales_Nuevos.size(); i++)
            {
                identidades.add(empleados_temporales_Nuevos[i].Identidad__c);
            }
            list<Account> empleados = new list<Account>();
            list<Account> empleadosNuevos = new list<Account>();
            list<Empresa_X_Empleado__c> empleadosEmpresa = new list<Empresa_X_Empleado__c>();
            Empresa_X_Empleado__c re;
            Account empleado;
            empleados =[select Identificacion__C from Account where Identificacion__C in :Identidades];
			for(integer i=0; i<empleados_temporales_Nuevos.size(); i++)
            {
                string si='Si';
                for(integer j=0; j<empleados.size(); j++)
                {
                    if(empleados_temporales_Nuevos[i].Identidad__C==empleados[j].Identificacion__C)
                    {
                        si='No';
                        j=empleados.size();
                    }
                    
                }
                if(si=='Si')
                {
                    empleado = new Account();
                    empleado.Identificacion__C= empleados_temporales_Nuevos[i].Identidad__c;
                    empleado.recordTypeId = tipoNatural;
                    empleado.firstname= empleados_temporales_Nuevos[i].Primer_Nombre__c ;
                    empleado.lastname= empleados_temporales_Nuevos[i].Primer_Apellido__c;
                    if(empleados_temporales_Nuevos[i].estado_Civil__c.toUpperCase()=='SOLTERO')
                    {
                        empleado.estado_civil__pc='Soltero';
                    }
                    else if(empleados_temporales_Nuevos[i].estado_Civil__c.toUpperCase()=='CASADO')
                    {
                        empleado.estado_civil__pc='Casado';
                    }
                    else if(empleados_temporales_Nuevos[i].estado_Civil__c.toUpperCase()=='DIVORSIADO')
                    {
                        empleado.estado_civil__pc='Divorciado';
                    }
                    else
                    {
                       empleado.estado_civil__pc='Unión libre'; 
                    }
                    if(empleados_temporales_Nuevos[i].tipo_identificacion__C.toUpperCase()=='PASAPORTE')
                    {
                       empleado.tipo_identificacion__C='4'; 
                    }
                    else if(empleados_temporales_Nuevos[i].tipo_identificacion__C.toUpperCase()=='CEDULA DE IDENTIDAD')
                    {
                       empleado.tipo_identificacion__C='1'; 
                    }
                    else
                    {
                        empleado.tipo_identificacion__C='2';
                    }
                    if(empleados_temporales_Nuevos[i].genero__c.toUpperCase()=='MASCULINO' || empleados_temporales_Nuevos[i].genero__c.toUpperCase()=='MASCULINO')
                    {
                        empleado.Sexo__c='M'; 
                    }
                    ELSE
                    {
                        empleado.Sexo__c='F'; 
                    }
                    empleadosNuevos.add(empleado);
                    re = new Empresa_X_Empleado__c();
                    re.empleado2__r=new Account(Identificacion__C = empleados_temporales_Nuevos[i].Identidad__C);
                    re.Empresa2__c=codigo_unico_banco;
                    re.Salario__c=empleados_temporales_Nuevos[i].salario__c;
                    re.Estado__c='Activo';
                    empleadosEmpresa.add(re);
                }
                else 
                {
                     re = new Empresa_X_Empleado__c();
                     re.empleado2__r=new Account(Identificacion__C = empleados_temporales_Nuevos[i].Identidad__C);
                     re.Empresa2__c=codigo_unico_banco;
                    re.Salario__c=empleados_temporales_Nuevos[i].salario__c;
                    re.estado__C='Activo';
                    empleadosEmpresa.add(re);
                }
            }
            insert empleadosNuevos;
            insert empleadosEmpresa;
           identidades = new list<string>();
           for(integer i=0; i<empleadosEmpresa.size(); i++)
            {
                identidades.add(empleadosEmpresa[i].empleado2__r.identificacion__C);
            } 
            empleadosEmpresa = new list<empresa_x_empleado__C>();
           	empleadosEmpresa =[select empleado2__r.Identificacion__C, id_formulario__c, salario__C, empleado2__r.tipo_identificacion__c,
                               empleado2__r.firstname, empleado2__r.lastname, empleado2__r.estado_civil__pc,
                               empleado2__r.sexo__C from empresa_x_empleado__C where  empleado2__r.Identificacion__C in :identidades and empresa2__c=:codigo_Unico_banco];
            Modificaciones_Empleados__c ju;
            list<Modificaciones_Empleados__c> juu =new list<Modificaciones_Empleados__c>();
            for(integer i=0; i<empleadosEmpresa.size(); i++)
            {
               ju=new Modificaciones_Empleados__c();
               ju.Empleado__c=empleadosEmpresa[i].id;
               ju.Fecha__c=date.today();
               ju.Tipo_Cambio__c='A';
               juu.add(ju);
            }
            insert juu;
            delete([select id from empleados_temporales__C where empleado__r.name=:Codigo_Unico_Banco]);
            delete ([select id from empleado_Temporal__c where name=:codigo_unico_banco]);
           //return new PageReference ('/Apex/vfHome?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario);
           
           string cuenta_colectiva=[select  codigo__c from CUENTAS__C WHERE CLIENTE__C = :Codigo_Unico_Banco limit 1].codigo__c;
           list<classAfiliacion> claseEnvio = new list<classAfiliacion>();
           classAfiliacion nueva;
           list<string> separacionNombre;
          list<cuentas__c> listcuentasEmpleados = new list<cuentas__c>();
           list<string> Cuentas = new list<string>();
           for(cuentas__c t:[select  CODIGO__C,id from CUENTAS__C WHERE CLIENTE__C = :Codigo_Unico_Banco])
           {
           		cuentas.add(t.id); 
           }
           listcuentasEmpleados = [select Cliente__r.Identificacion__C from cuentas__c where Cliente__r.Identificacion__C in :IDENTIDADES AND cuenta_colectiva2__C NOT IN:cuentas];
            Enviarcuentas();
           string todosempleados='';
           Autonumerico_cuentas_Syste__c Numerosformularios=[select id, Id_Formulario_Sysde__c from Autonumerico_cuentas_Syste__c limit 1];
           decimal abc=Numerosformularios.Id_Formulario_Sysde__c;
           for(integer j=0; j<empleadosEmpresa.size(); j++)
              {
                  integer io=0;
                for(integer i=0; i<listcuentasEmpleados.size(); i++)
                {
                    if(listcuentasEmpleados[i].Cliente__r.Identificacion__C==empleadosEmpresa[j].empleado2__r.identificacion__C)
                    {
                        io=3;
                    }
                }
               if(io==0)
               {
                  string tipocuenta='';
                  for(integer g=0; g<empleados_temporales_Nuevos.size(); g++)
                  {
                      if(empleados_temporales_Nuevos[g].identidad__C==empleadosEmpresa[j].empleado2__r.identificacion__C)
                      {
                          tipocuenta=empleados_temporales_Nuevos[g].tipo_cuenta__C;
                      }
                  }
                  nueva = new classAfiliacion();
                  separacionNombre =new list<string>();
                  nueva.primernombre=empleadosEmpresa[j].empleado2__r.firstname.trim();
                  nueva.primerapellido=empleadosEmpresa[j].empleado2__r.lastname.trim();
                  if(empleadosEmpresa[j].empleado2__r.firstname.trim().contains(' '))
                  {
                        separacionNombre= empleadosEmpresa[j].empleado2__r.firstname.trim().Split(' ');
                        nueva.primernombre=separacionNombre[0];
                        nueva.segundonombre=separacionNombre[1];
                    }
                  if(empleadosEmpresa[j].empleado2__r.lastname.trim().contains(' '))
                  {
                      separacionNombre =new list<string>();
                      separacionNombre= empleadosEmpresa[j].empleado2__r.lastname.trim().Split(' ');
                      nueva.primerapellido=separacionNombre[0];
                      nueva.segundoapellido=separacionNombre[1];
                   }          
                   nueva.identificacion=empleadosEmpresa[j].empleado2__r.identificacion__C;
                   nueva.idTipoIdentificacion=empleadosEmpresa[j].empleado2__r.Tipo_Identificacion__c;
                  
                   if(empleadosEmpresa[j].empleado2__r.Sexo__c=='Masculino' ||empleadosEmpresa[j].empleado2__r.Sexo__c=='M')
                   {
                       nueva.genero='M';
                   }
                  else{nueva.genero='F';}
                  if(empleadosEmpresa[j].empleado2__r.Estado_Civil__pc.toUpperCase()=='UNIÓN LIBRE')
                  {
                      nueva.estadoCivil = 'U';
                  }
                   ELSE if(empleadosEmpresa[j].empleado2__r.Estado_Civil__pc.toUpperCase()=='CASADO')
                  {
                      nueva.estadoCivil = 'C';
                  }
                   ELSE if(empleadosEmpresa[j].empleado2__r.Estado_Civil__pc.toUpperCase()=='DIVORSIADO')
                  {
                      nueva.estadoCivil = 'D';
                  }
                   ELSE 
                  {
                      nueva.estadoCivil = 'S';
                  }
                   
                   nueva.salario=empleadosEmpresa[j].Salario__c;
                  // nueva.idsalesforce = empleadosEmpresa[j].id_formulario__c;
                   
                   if(tipocuenta.toLowerCase() =='AMBAS' || tipocuenta.toLowerCase() =='AMBOS')
                   {
                        nueva.cuentaUno=voluntarias;
                        nueva.idSalesforceUno = 'SF'+string.valueOf(abc++);
                        
                        nueva.cuentados=cesantias;
                        nueva.idSalesforcedos = 'SF'+string.valueOf(abc++);
                        
                        nueva.cuentaTres=Pcomplemetario;
                        nueva.idSalesforceTres = 'SF'+string.valueOf(abc++);
                   }
                   if(tipocuenta.toLowerCase()=='VOLUNTARIAS' || tipocuenta.toLowerCase()=='VOLUNTARIOS')
                   {
                       nueva.cuentaUno=voluntarias;
                 	   nueva.idSalesforceUno = 'SF'+string.valueOf(abc++);
                       nueva.cuentados='NADANADA';
                	   nueva.idSalesforcedos = 'NADANADA';
                       
                       nueva.cuentaTres='NADANADA';
                       nueva.idSalesforceTres = 'NADANADA';
                   }
                   if(tipocuenta.toLowerCase()=='OBLIGATORIOS'  || tipocuenta.toLowerCase()=='OBLIGATORIAS')
                   {
                        nueva.cuentaUno=Pcomplemetario;
                		nueva.idSalesforceUno = 'SF'+string.valueOf(abc++);
                
                		nueva.cuentados=cesantias;
                		nueva.idSalesforcedos = 'SF'+string.valueOf(abc++);
                       
                        nueva.cuentaTres='NADANADA';
                        nueva.idSalesforceTres = 'NADANADA';
                   }
                   claseenvio.add(nueva);
                   todosempleados +=nueva.idTipoIdentificacion+',';
                   todosempleados +=nueva.identificacion+',';
                   todosempleados +=nueva.primerNombre+',';
                   todosempleados +=nueva.segundoNombre+',';
                   todosempleados +=nueva.primerApellido+',';
                   todosempleados +=nueva.segundoApellido+',';
                   todosempleados +=nueva.genero.toUpperCase()+',';
                   todosempleados +=nueva.estadoCivil.toUpperCase()+',';
                   todosempleados +=nueva.salario+',';
                   todosempleados +=nueva.cuentaunO+',';
                   todosempleados +=nueva.cuentados+',';
                   todosempleados +=nueva.cuentaTres+',';
                   todosempleados +=nueva.idSalesforceuno+',';
                   todosempleados +=nueva.idSalesforcedos+',';
                   todosempleados +=nueva.idSalesforceTres+'::::';  
                   
                  
               }
             
           }
           reiniciar();
           Numerosformularios.Id_Formulario_Sysde__c=abc;
           update Numerosformularios;
			if(todosempleados.length()>3)
            {
              system.debug(todosempleados); 
              aSysdePortalEmpresarial.Afiliacionsysdemasiva(todosempleados, Cuenta_colectiva,0,'fgd');  
            }
          
           
       }
       catch(Exception ex)
       {
           system.debug(ex.getLineNumber()+' '+ex.getMessage());
       }
       // return null;
    }
    
    public void Enviarcuentas()
    {
        list<Cuentas_colectivas__C> fr = new list<Cuentas_colectivas__C>();
        fr = [Select  Codigo__C, tipo_cuenta__C from Cuentas_colectivas__C where empresa__C=:Codigo_Unico_Banco];
        for(integer i=0; i<fr.size(); i++)
        {
            if(fr[i].tipo_cuenta__C=='Voluntarias')
             {
                   voluntarias = fr[i].codigo__C;
             }
             if(fr[i].tipo_cuenta__C=='Censatías')
             {
                 cesantias = fr[i].codigo__C;
             }
             if(fr[i].tipo_cuenta__C=='Pilar Complementario')
             {
                Pcomplemetario = fr[i].codigo__C;
             }
                  
        }
    }
    
    public void VerArchivo()
    {
        try
        {
            usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
           total =0;
            mostrarTabla=true;
            mostrarbotones=false;
            map<string, integer> bg = new map<string, integer>();
            Codigo_Unico_Banco=ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
            empleado_Temporal__c NuevaPlanilla = new empleado_Temporal__c();
            NuevaPlanilla =[select id, Numeracion_Automatica__c from empleado_Temporal__c where name=:codigo_unico_banco order by Numeracion_Automatica__c DESC LIMIT 1];
            list<Empleados_temporales__c> todos = new list<Empleados_temporales__c>();
            todos=[select Estado_Civil__c, Genero__c, Identidad__c, Tipo_Cuenta__c ,
                   Primer_Apellido__c, Primer_Nombre__c, SEGUNDO_Apellido__c, 
                   SEGUNDO_Nombre__c,Salario__c, Tipo_Identificacion__c
                   from empleados_temporales__c 
                   where empleado__c=:nuevaplanilla.id order by Primer_Nombre__c asc];
            
       		list<string> Identidades =new list<string>();
            for(integer i=0; i<todos.size(); i++)
            {
                identidades.add(todos[i].Identidad__c);
            }
            list<Empresa_X_Empleado__c> empleados = new list<Empresa_X_Empleado__c>();
            empleados =[select empleado2__r.Identificacion__C from Empresa_X_Empleado__c where empresa2__C=:codigo_Unico_banco and empleado2__r.Identificacion__C in :Identidades];
            empleados_temporales_Nuevos= new list<empleados_temporales__c>();
            empleados_temporales_Repetidos = new list<empleados_temporales__c>();
            for(integer i=0; i<todos.size(); i++)
            {
                if(!bg.containsKey(todos[i].Identidad__c))
                {
                    string si='Si';
                    for(integer j=0; j<empleados.size(); j++)
                    {
                        if(todos[i].Identidad__c==empleados[j].empleado2__r.identificacion__C)
                        {
                            si='No';
                        }
                    }
                    if(si=='Si')
                    {
                        empleados_temporales_Nuevos.add(todos[i]);
                        total +=todos[i].salario__C;
                        bg.put(todos[i].Identidad__c, 3);
                    }
                    else
                    {
                        empleados_temporales_Repetidos.add(todos[i]);
                        bg.put(todos[i].Identidad__c, 3);                    
                    }
                }
            }
            Mensaje='';
            if(empleados_temporales_Repetidos.size()>0)
            {
                Mensaje='En esta lista de Empleados vienen Identidades que ya estaban entre sus empleados, no seran guardados los repetidos.';
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, mensaje));
                
            }
            if(empleados_temporales_Nuevos.size()>0)
            {
                mostrarguardar=true;
            }
            
            totalempleados='Total de empleados: '+empleados_temporales_Nuevos.size();
            //PAginaciones
             mostrarBotonesp=false;
             mostrarAnterior=true;
             mostrarSiguiente=true;
            mempleados_temporales_Nuevos = new list<Empleados_Temporales__c>();
            contadorpaginacion=0;
            if(empleados_temporales_Nuevos.size()>100)
           {
                contadorpaginacion ++;
               	mostrarBotonesp=true;
                mostrarSiguiente=false;
                for(integer i=0; i<100; i++)
                {
                    
                    Mempleados_temporales_Nuevos.add(empleados_temporales_Nuevos[i]);
                }
           }
           else
           {
              for(integer i=0; i<empleados_temporales_Nuevos.size(); i++)
                {
                    
                    Mempleados_temporales_Nuevos.add(empleados_temporales_Nuevos[i]);
                } 
           }
          
            
        }
        catch(Exception ex)
        {
            system.debug(ex.getLineNumber()+'  '+ex.getMessage());
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
            if((contadorpaginacion + 1)*100 > empleados_temporales_Nuevos.size())
            {
                contadorpaginacion ++;
                Mempleados_temporales_Nuevos = new list<Empleados_Temporales__c>();
                mostrarSiguiente=true;
                mostraranterior=false;
                 for(integer i=(contadorpaginacion - 1)*100; i<empleados_temporales_Nuevos.size(); i++)
                {
                   
                    Mempleados_temporales_Nuevos.add(empleados_temporales_Nuevos[i]);
                } 
                
                
            }
            else
            {
                 mostraranterior=false;
                 contadorpaginacion ++;
                Mempleados_temporales_Nuevos = new list<Empleados_Temporales__c>();
                 for(integer i=(contadorpaginacion - 1)*100; i<contadorpaginacion*100; i++)
                {
                   Mempleados_temporales_Nuevos.add(empleados_temporales_Nuevos[i]);
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
                Mempleados_temporales_Nuevos = new list<Empleados_Temporales__c>();
                for(integer i=0; i<100; i++)
                {
                    Mempleados_temporales_Nuevos.add(empleados_temporales_Nuevos[i]);
                } 
                contadorpaginacion --;
            }
            else
            {
                Mempleados_temporales_Nuevos = new list<Empleados_Temporales__c>();
               for(integer i=(contadorpaginacion - 2)*100; i<(contadorpaginacion-1) *100; i++)
                {
                    Mempleados_temporales_Nuevos.add(empleados_temporales_Nuevos[i]);
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
        try{
            if(empresa=='No')
            {
                empresa=[select name from empleado_Temporal__c order by createddate DESC LIMIT 1].name;
            }
        stringCSV.replace('\'', '');
        stringCSV.replace('´', '');
        retorno.ERROR='Ya Puede ver los empleados nuevos';
        list<string> kike = new list<string> ();
        list<string> Tipo_Identidad = new list<string> ();
        list<string> Genero = new list<string> ();
        list<string> EstadoCivil= new list<string> ();
        list<string> Identidad = new list<string> ();
        list<string> PN = new list<string> ();
        list<string> SN = new list<string> ();
        list<string> PA = new list<string> ();
        list<string> SA = new list<string> ();
        list<string> TC = new list<string> ();
        list<string> salario = new list<string> ();
        integer A=15;
        integer B=15;
        integer C=15;
        //integer D=15;
        integer E=15;
        //integer F=15;
        integer G=15;
        integer H=15;
        integer Ka=15;
        integer vtc=15;
        kike=stringCSV.split('\n');
        string lk=kike[0];
        kike.remove(0);
        list<string> clientes2;
         list<string> ki;
         clientes2=new list<string>();
        clientes2=lk.split(',');
        for(integer i=0; i<clientes2.size(); i++)
        {
            ki = new  list<string>();
            ki=clientes2[i].Split('"');
            clientes2[i]= ki[1].Trim();
            if(clientes2[i].toUpperCase()=='TIPO IDENTIFICACION' || clientes2[i].toUpperCase()=='TIPO IDENTIFICACIÓN')
            {
                A=i;
            }
            if(clientes2[i].toUpperCase()=='NUM IDENTIDAD' || clientes2[i].toUpperCase()=='IDENTIFICACION'
              || clientes2[i].toUpperCase()=='IDENTIFICACIÓN' || clientes2[i].toUpperCase()=='NUMERO IDENTIDAD')
            {
                B=i;
            }
            if(clientes2[i].toUpperCase()=='NOMBRE' || clientes2[i].toUpperCase()=='NOMBRES')
            {
                C=i;
            }
            if(clientes2[i].toUpperCase()=='SEGUNDO NOMBRE')
            {
               // D=i;
            }
            if(clientes2[i].toUpperCase()=='APELLIDO' ||clientes2[i].toUpperCase()=='APELLIDOS')
            {
                E=i;
            }
            if(clientes2[i].toUpperCase()=='SEGUNDO APELLIDO')
            {
               // F=i;
            }
            if(clientes2[i].toUpperCase()=='GENERO' || clientes2[i].toUpperCase()=='SEXO' || clientes2[i].toUpperCase()=='GÉNERO')
            {
                G=i;
            }
            if(clientes2[i].trim().toUpperCase()=='ESTADO CIVIL' || clientes2[i].trim().toUpperCase()=='ESTADO CIVIL')
            {
                H=i;
            }
            if(clientes2[i].toUpperCase()=='SALARIO' || clientes2[i].toUpperCase()=='SUELDO' ||clientes2[i].toUpperCase()=='SALARIOS')
            {
                Ka=i;
            }
            if(clientes2[i].toUpperCase()=='TIPO DE CUENTA' ||clientes2[i].toUpperCase()=='TIPO CUENTA' )
            {
                VTC=i;
            }
        }
        if(a!=15 && b!=15 && c!=15 && e!=15 && g!=15 && h!=15 && ka!=15 && VTC !=15)
        {
                list<empleados_Temporales__c> verifiEmple= new list<empleados_Temporales__c>();
               	empleado_Temporal__c kk =new empleado_Temporal__c();
               	kk.name=empresa;
               	insert kk;
              	empleados_Temporales__c empleadoTem;
            for (integer i=0; i<kike.size(); i++)
                {
           
                     ki = new  list<string>();
                    string k;
                    kike[i]=kike[i].replace(',,','').Trim();
                    kike[i]=kike[i].replace('""','').Trim();
                    if(kike[i].length()>1)
                    {
                     ki=kike[i].split(',');
                    ki[b]=ki[b].replace(',','').trim();
                    ki[b]=ki[b].replace('"','').trim();
                    if(ki[b]!=''  && ki[b].length()>7)
                    {
                    string tipo_iden = ki[a];
                    string Ident = ki[b];
                    string pnp = ki[c];
                    string TCp=KI[VTC];
                    
                    //if(d!=15){snp = ki[d];}
                    string pap = ki[e];
                    string sap;
                    //if(f!=15){sap = ki[f];}
                    string Gene = ki[g];
                    string civil = ki[h];
                    string sala = ki[ka];
                   	string lo='';
                    empleadoTem = new empleados_Temporales__c();
               		empleadoTem.empleado__c=kk.id;
                    if(tipo_iden!=lo)
                    {
                    
                        tipo_iden=tipo_iden.replace('"','');
                        if(tipo_iden.Trim().toUpperCase()=='CEDULA DE IDENTIDAD' ||tipo_iden.Trim().toUpperCase()=='CARNET DE RESIDENTE' 
                           ||tipo_iden.Trim().toUpperCase()=='PASAPORTE')
                        {
                            Tipo_Identidad.add(tipo_iden.Trim());
                            empleadoTem.Tipo_Identificacion__c=tipo_iden.toUpperCase().Trim();
                        }
                        else
                        {
                            Tipo_Identidad.add('CEDULA DE IDENTIDAD');
                            empleadoTem.Tipo_Identificacion__c='CEDULA DE IDENTIDAD';
                        }
                       
                    }
                    
                    if(tcp != lo)
                    {
                        
						tcp=tcp.replace('"','');
                        tcp=tcp.Trim();
                         empleadoTem.Tipo_Cuenta__c='VOLUNTARIAS'; 
                        if(tcp.toUpperCase()=='VOLUNTARIAS' || tcp.toUpperCase()=='VOLUNTARIOS' ||
                          tcp.toUpperCase()=='VOLUNTARIA' || tcp.toUpperCase()=='VOLUNTARIO'||tcp.toUpperCase()=='V')
                        {
                           empleadoTem.Tipo_Cuenta__c='VOLUNTARIAS'; 
                        }
                       else if(tcp.toUpperCase()=='AMBAS' || tcp.toUpperCase()=='AMBOS' || tcp.toUpperCase()=='A')
                        {
                           empleadoTem.Tipo_Cuenta__c='AMBAS'; 
                        }
                        else if(tcp.toUpperCase()=='OBLIGATORIAS' || tcp.toUpperCase()=='OBLIGATORIOS' ||
                          tcp.toUpperCase()=='OBLIGATORIA' || tcp.toUpperCase()=='OBLIGATORIO'||tcp.toUpperCase()=='O')
                        {
                           empleadoTem.Tipo_Cuenta__c='OBLIGATORIAS'; 
                        }
						
                    }
                    
                     if(Ident!=lo)
                    {
                    
                        empleadoTem.Identidad__c=Ident.replace('-','');
                        
                       
                    }
                    
                     if(pnp !=lo)
                    {
                        empleadoTem.Primer_Nombre__c=pnp.replace('"','').toUpperCase().Trim();
                        
                    }
                   
                     if(pap !=lo)
                    {
                        empleadoTem.Primer_Apellido__c=pap.replace('"','').toUpperCase().Trim();
                    }
                    if(Gene !=lo)
                    {
                         gene = Gene.replace('"', '');
                         if(Gene.toUpperCase()=='MASCULINO' ||Gene.toUpperCase()=='FEMENINO')
                        {
                            
                            empleadoTem.Genero__c=gene.toUpperCase();
                        }
                        else 
                        {
                            
                            empleadoTem.Genero__c='MASCULINO';
                            if(Gene.toUpperCase().Trim()=='F')
                        {
                            empleadoTem.Genero__c='FEMENINO';
                        }
                        }
                       
                    }
                    
                     if(civil !=lo)
                    {
                        civil=civil.replace('"', '');
                        if(civil.toUpperCase()=='CASADO' ||civil.toUpperCase()=='DIVORSIADO' 
                           ||civil.toUpperCase()=='SOLTERO' ||civil.toUpperCase()=='UNIÓN LIBRE' ||civil.toUpperCase()=='VIUDO')
                        {
                            empleadoTem.Estado_Civil__c=civil.toUpperCase();
                        }
                        else
                        {
                            empleadoTem.Estado_Civil__c='SOLTERO';
                            if(civil.toUpperCase()=='C')
                            {
                                empleadoTem.Estado_Civil__c='CASADO';
                            }
                            else if(civil.toUpperCase()=='U')
                            {
                                empleadoTem.Estado_Civil__c='UNIÓN LIBRE';
                            }
                            else if(civil.toUpperCase()=='V')
                            {
                                empleadoTem.Estado_Civil__c='VIUDO';
                            }
                             else if(civil.toUpperCase()=='D')
                            {
                                empleadoTem.Estado_Civil__c='DIVORSIADO';
                            }
                        }
                    }
                    
                    try{
                        if(decimal.valueOf(sala)>0)
                        {
                            empleadoTem.Salario__c= decimal.valueOf(sala);
                        }
                        else
                        {
                            empleadoTem.Salario__c=0;
                        }
                  }
                    Catch(Exception ex)
                    {
                        try{
                            sala=sala.replace('"', '');
                            empleadoTem.Salario__c= decimal.valueOf(sala);
                        }
                        catch(exception hg)
                        {
                           empleadoTem.Salario__c=0;
                        }
                        
                    }
                        verifiEmple.add(empleadoTem);
                       
                       }
                    }
                    
                   
                    
                }
               if(verifiEmple.size()>0)
               {
                   insert verifiEmple;
               }
               
               
        }
            else{//retorno.error='Las columnas no traen el nombre correcto';}
        		//retorno.error='a'+a+' b'+ b+' c'+c+' e'+e+' g'+g+' h'+h+' ka'+ka+' vtc'+vtc;}
        		retorno.error='Estas Columnas no traen el nombre correcto\n';
                if(a==15)
                {
                   retorno.error +='Tipo Identificacion\n'; 
                }
                if(b==15)
                {
                   retorno.error +='Num Identidad\n'; 
                }
                if(c==15)
                {
                   retorno.error +='Nombres\n'; 
                }
                if(e==15)
                {
                   retorno.error +='Apellidos\n'; 
                }
                if(g==15)
                {
                   retorno.error +='Género\n'; 
                }
                if(h==15)
                {
                   retorno.error +='Estado Civil\n'; 
                }
                if(ka==15)
                {
                   retorno.error +='Salario\n'; 
                }
                if(vtc==15)
                {
                   retorno.error +='Tipo de Cuenta'; 
                }
            }
            
        }
        catch(exception fr)
        {
           // retorno.error='Hubo un error al subir los nuevos empleados';
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, '¡Hubo un error al subir los nuevos empleados!'));
           // return retorno;
        }
        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, '¡Ya Puede ver los empleados nuevos!'));
        return retorno;
        
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
       
    
     
    } 
    
}