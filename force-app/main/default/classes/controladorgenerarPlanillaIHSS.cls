public class controladorgenerarPlanillaIHSS {
    public list<clasePilares> listDatos{get;set;}
     public list<clasePilares> MlistDatos{get;set;}
    public clasePilares totales{get;set;}
    public clasePilares totales2{get;set;}
    public string GenerarExcel {get;set;}
    public string nombre_Empresa{get;set;}
    public integer totalempleados{get;set;}
    String Codigo_Unico_Banco;
    String Usuario;
    string rtn;
    integer bandera;
    
    //PAGINACIÓN 
    public boolean mostrarSiguiente{get;set;}
    public boolean mostrarANterior{get;set;}
    public boolean mostrarBotonesP{get;set;}
    integer contadorpaginacion;
    
    
    
    
    
    public controladorgenerarPlanillaIHSS(){
    		try{
	        Codigo_Unico_Banco = ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
		     Usuario = ApexPages.currentPage().getParameters().get('loetdncdhjch');
		    bandera=0;
		    listDatos = new list<clasePilares>();
		    
		     
    			Usuario_X_Empresa__c usuarioEmpresa = [select Empresa2__r.Name, Empresa2__r.IsPersonAccount, Usuario__r.Name,
		    							Empresa2__r.PAPCE__c, Empresa2__r.PAPCT__c,
		    							Empresa2__r.Salario_Base_Pilar_Complementario__c,
		    							Empresa2__r.Porcentaje_de_aportaciones_Reserva_Labor__c, 
		    							Empresa2__r.Salario_Base_Reserva_Laboral__c,
		    							Empresa2__r.Salario_Base_Seguro_Social__c,
		    							Empresa2__r.Porc_Apor_SSoc_Empleador_IVM__c,
		    							Empresa2__r.Porc_Apor_SSoc_Empleado_IVM__c,
		    							Empresa2__r.Porc_Apor_SSoc_Empleador_Mater__c,
		    							Empresa2__r.Porc_Apor_SSoc_Empleado_Mater__c,
		    							Empresa2__r.Riesgo_Profecional_Patronal__c,
                                        empresa2__r.Identificacion__c,
                                        empresa2__r.Salario_Base_Seguro_Social_Mater__c,
                                        empresa2__r.Salario_Base_Seguro_Social_RP__c
		    							from Usuario_X_Empresa__c 
									where Empresa2__c =: Codigo_Unico_Banco
									AND Usuario__c =: Usuario Limit 1];
			
			nombre_Empresa = usuarioEmpresa.Empresa2__r.Name;
			rtn=usuarioEmpresa.empresa2__r.Identificacion__c;
			Decimal salarioSS = usuarioEmpresa.Empresa2__r.Salario_Base_Seguro_Social__c;
			decimal salarioRP = usuarioEmpresa.empresa2__r.Salario_Base_Seguro_Social_RP__c;
           	decimal salarioMater=usuarioEmpresa.empresa2__r.Salario_Base_Seguro_Social_Mater__c;
                
			decimal yeah3 = (( salarioSS * usuarioEmpresa.Empresa2__r.Porc_Apor_SSoc_Empleador_IVM__c)/100).setScale(2);
	        decimal yeah4 = ((salarioSS * usuarioEmpresa.Empresa2__r.Porc_Apor_SSoc_Empleado_IVM__c)/100).setScale(2);
			decimal yeah1 = ((salarioMater * usuarioEmpresa.Empresa2__r.Porc_Apor_SSoc_Empleador_Mater__c)/100).setScale(2);
	        decimal yeah2 = ((salarioMater * usuarioEmpresa.Empresa2__r.Porc_Apor_SSoc_Empleado_Mater__c)/100).setScale(2);
	        decimal yeah5 = ((salarioRP * usuarioEmpresa.Empresa2__r.Riesgo_Profecional_Patronal__c)/100).setScale(2);
	        	
	        decimal totalYeah1 = 0;
	        decimal totalYeah2 = 0;
        	decimal totalYeah3 = 0;
    	    decimal totalYeah4 = 0;
			decimal totalYeah5 = 0;
            /*list<string> cuentas = new list<string> ();
			for(cuentas_colectivas__C item:[select codigo__C from cuentas_colectivas__C where  empresa__c=:Codigo_Unico_Banco])
            {
                cuentas.add(item.Codigo__c);
            }
                
            list<string> identificaciones = new list<string> ();
            for(cuentas__c item: [select cliente__C from Cuentas__c where producto__r.CurrencyIsoCode='HNL' and cuenta_colectiva2__r.codigo__C in :(cuentas)])
            {
                identificaciones.add(item.cliente__C);
            }*/
                
                
                
	        	For(Empresa_x_Empleado__c item : [Select Empleado2__c, Empleado2__r.FirstName, Empleado2__r.LastName,
											Empleado2__r.Identificacion__c, Salario__c
											From Empresa_x_Empleado__c
											Where Empresa2__c =: Codigo_Unico_Banco
                                            //and empleado2__C in :(identificaciones)
											AND Estado__c = 'Activo' order by Empleado2__r.Firstname asc]){
												
											
	        		listDatos.add(new clasePilares(rtn, item.Empleado2__r.Identificacion__c,
	        						Date.today().format(),item.Empleado2__r.Identificacion__c,
								item.Empleado2__r.FirstName, item.Empleado2__r.LastName, Date.today().format(), 'A',
								salarioSS,yeah1,yeah2,yeah3,yeah4,yeah5));
								
				totalYeah1 += yeah1;
				totalYeah2 += yeah2;
				totalYeah3 += yeah3;
				totalYeah4 += yeah4;
				totalYeah5 += yeah5;
    			}
                totalempleados=listdatos.size();
    			totales = new clasePilares('','','','','','','','',0.0,totalYeah1,totalYeah2,totalYeah3,totalYeah4,totalYeah5);	
    			
    			decimal totalFinal = 0;
    			totalFinal = (totalYeah1 + totalYeah2 + totalYeah3 + totalYeah4 + totalYeah5);
    			totales2 = new clasePilares('','','','','','','','',0.0,0.0,0.0,0.0,0.0, totalFinal);	
                 //PAginaciones
             mostrarBotonesp=false;
             mostrarAnterior=true;
             mostrarSiguiente=true;
            MListDatos = new list<clasePilares>();
            contadorpaginacion=0;
            if(ListDatos.size()>100)
           {
                contadorpaginacion ++;
               	mostrarBotonesp=true;
                mostrarSiguiente=false;
                for(integer i=0; i<100; i++)
                {
                    
                    MListDatos.add(ListDatos[i]);
                }
           }
           else
           {
              for(integer i=0; i<ListDatos.size(); i++)
                {
                    
                    MListDatos.add(ListDatos[i]);
                } 
           }
    		}Catch(Exception ex){
    			ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, 'Ha ocurrido un error, favor contacte a su administrador'));
    		}
       
    }
    public void siguiente() 
    {
        try{
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            if((contadorpaginacion + 1)*100 > Listdatos.size())
            {
                contadorpaginacion ++;
                MListdatos = new list<clasepilares>();
                mostrarSiguiente=true;
                mostraranterior=false;
                 for(integer i=(contadorpaginacion - 1)*100; i<Listdatos.size(); i++)
                {
                   
                    MListdatos.add(Listdatos[i]);
                } 
                
                
            }
            else
            {
                 mostraranterior=false;
                 contadorpaginacion ++;
                MListdatos = new list<clasepilares>();
                 for(integer i=(contadorpaginacion - 1)*100; i<contadorpaginacion*100; i++)
                {
                   MListdatos.add(Listdatos[i]);
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
            MListdatos = new list<clasepilares>();
            if((contadorpaginacion - 1)*100 < 101)
            {
                mostrarsiguiente=false;
                mostrarAnterior=true;
                for(integer i=0; i<100; i++)
                {
                    MListdatos.add(Listdatos[i]);
                } 
                contadorpaginacion --;
            }
            else
            {
               // MListCLientesN = new list<planilla>();
               for(integer i=(contadorpaginacion - 2)*100; i<(contadorpaginacion-1) *100; i++)
                {
                    MListdatos.add(Listdatos[i]);
                }  
                contadorpaginacion --;
                 mostrarSiguiente=false;
            }
        }
        catch(Exception ex)
        {
            
        }
    }
    public Planilla_Seguro_Social__c poo;
    public pagereference descargar(){
        try{
            if(bandera==0)
            {
                Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
        	poo=new Planilla_Seguro_Social__c();
            poo.Aporte_Empleado_SS__c=listDatos[0].yeah4;
            poo.Salario__c=listDatos[0].Salario;
            poo.Aporte_Patrono_SS__c=listDatos[0].yeah5;
            poo.Aporte_Patronal_Maternidad__c=listDatos[0].yeah1;
            poo.Aporte_Empleado_Maternidad__c=listDatos[0].yeah2;
            poo.Riesgo_Profecional_Patronal__c=listDatos[0].yeah5;
            poo.Total_Aporte_Empleado_SS__c=totales.yeah4;
            poo.Total_Aporte_Patrono_SS__c=totales.yeah3;
            poo.Total_Aporte_Patronal_Maternidad__c=totales.yeah1;
            poo.Total_Aporte_Empleado_Maternidad__c =totales.yeah2;
            poo.Total_Riesgo_Profecional_Patronal__c=totales.yeah5;
            poo.Fecha_Creacion__c=date.today();
            //poo.Fecha_Planilla__c=date.valueOf(listClientes[0].Fecha_Planilla);
            poo.Usuario__c=usuario;
            poo.Tipo_Planilla__C='Generada';
            poo.Empresa2__C=Codigo_Unico_Banco;
            insert poo;
        
         list<Contenido_Planilla_SS__c>  yea= new list<Contenido_Planilla_SS__c>();
            Contenido_Planilla_SS__c t;
            
            for(integer i=0; i<listdatos.size(); i++)
            {
                t = new Contenido_Planilla_SS__c();
                t.rtn__C=listdatos[i].identidad2;
                t.Planilla__C=poo.id;
                //t.Num_Patronal__c=listdatos[i].Num_Patronal;
                t.Identidad__c=listdatos[i].identidad;
                t.Primer_Nombre__c=listdatos[i].nombres;
                t.SeGUndo_Nombre__C=listdatos[i].sengundoNombre;
                t.Primer_Apellido__c=listdatos[i].Apellidos;
                t.segundo_apellido__c=listdatos[i].sengundoApellido;
                if(listdatos[i].fechaCambio!=null)
                {t.Fecha_Cambio__C=date.valueOf(listdatos[i].fechacambio2);}
                t.Tipo_cambio__c=listdatos[i].tipoCambio;
                yea.add(t);
                
            }
            insert yea;
           	ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, 'Planilla Creada Exitosamente'));
            bandera =1;
        }
         return new Pagereference('/apex/vfExportarEGenrerarIHSS');
        
        }
        catch(Exception ex)
        {
           ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, ex.getLineNumber() + ex.getMessage())); 
        }
        return null;
    }
   
    public class clasePilares{
    		Public string identidad{get;set;}
    		Public string Fecha_Planilla{get;set;}
    		Public string identidad2{get;set;}
    		Public string Nombres{get;set;}
    		Public string Apellidos{get;set;}
    		Public string fechaCambio{get;set;}
    		public string tipoCambio{get;set;}
    		Public Decimal Salario{get;set;}
    		Public Decimal yeah1{get;set;}
    		Public Decimal yeah2{get;set;}
    		Public Decimal yeah3{get;set;}
    		Public Decimal yeah4{get;set;}
    		Public Decimal yeah5{get;set;}
        	public string fechacambio2{get;set;}
        	public string sengundoNombre{get;set;}
    		public string sengundoApellido{get;set;}	
        
    		public clasePilares(String rtn, String Num_Patronal, String Fecha_Planilla, String identidad2, String Nombres, 
    							String Apellidos, String fechaCambio, String tipoCambio, Decimal Salario,
    							Decimal yeah1, Decimal yeah2, Decimal yeah3, Decimal yeah4, Decimal yeah5){
    								
    			this.sengundoApellido='';
                this.sengundoNombre='';
                this.identidad = rtn;
    			this.Fecha_Planilla =Fecha_Planilla;
    			this.identidad2 = identidad2;
    			this.Nombres = Nombres;
    			this.Apellidos = Apellidos;
    			this.fechaCambio = fechaCambio;
    			this.tipoCambio = tipoCambio;
    			this.Salario = Salario;
    			this.yeah1 = yeah1;
    			this.yeah2 = yeah2;
    			this.yeah3 = yeah3;
    			this.yeah4 = yeah4;
    			this.yeah5 = yeah5;
                list<string> fechas;
                if(fechaCambio.trim() !='' )
            	{
                 fechas = new list<string>();
                fechas = fechacambio.split('/');
                fechacambio2=fechas[2]+'-'+fechas[1]+'-'+fechas[0];
            	}
                if(this.Nombres !=null && this.Nombres.trim()!='')
                {
                    if(this.Nombres.trim().contains(' '))
                {
                   fechas = new list<string>();
                   fechas=this.Nombres.trim().split(' ');
                   this.nombres=fechas[0];
                   this.sengundoNombre=fechas[1];
                }
                }
                if(this.APellidos !=null && this.APellidos.trim()!='')
                {
                    if(this.APellidos.trim().contains(' '))
                {
                   fechas = new list<string>();
                   fechas=this.APellidos.trim().split(' ');
                   this.APellidos=fechas[0];
                   this.sengundoApellido=fechas[1];
                }
                }
                
    			
    		}
    }
    
}