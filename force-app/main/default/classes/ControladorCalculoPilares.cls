public class ControladorCalculoPilares {
    public string Nombre_Empresa{get;set;}
    public list<Planilla> listClientes {get;set;}
    public list<clasePilares> listDatos {get;set;}
    public list<clasePilares> MlistDatos {get;set;}
     public integer totalempleados{get;set;}
    public decimal totalAPO{get;set;}
    public decimal totalAEO{get;set;}
    public decimal totalREserva{get;set;}
    public decimal yeah1{get;set;}
    public decimal yeah2{get;set;}
    public decimal yeah3{get;set;}
    public decimal yeah4{get;set;}
    public decimal yeah5{get;set;}
    public decimal totalsueldos{get;set;}
    String Codigo_Unico_Banco;
    String usuario;
    
      //PAGINACIÓN 
    public boolean mostrarSiguiente{get;set;}
    public boolean mostrarANterior{get;set;}
    public boolean mostrarBotonesP{get;set;}
    integer contadorpaginacion;
    
    
    public ControladorCalculoPilares(){
    		try{
    		 Codigo_Unico_Banco = ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
		     Usuario = ApexPages.currentPage().getParameters().get('loetdncdhjch');
               
		    listClientes = new list<Planilla>();
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
                                        empresa2__r.Salario_Base_Seguro_Social_Mater__c,
                                        empresa2__r.Salario_Base_Seguro_Social_RP__c
		    							from Usuario_X_Empresa__c 
									where Empresa2__c =: Codigo_Unico_Banco
									AND Usuario__c =: Usuario Limit 1];
			
			Nombre_Empresa = usuarioEmpresa.Empresa2__r.Name;
			Decimal salarioBaseEmpresa = usuarioEmpresa.Empresa2__r.Salario_Base_Pilar_Complementario__c;
			Decimal salarioBaseReservaL = usuarioEmpresa.Empresa2__r.Salario_Base_Reserva_Laboral__c;
			Decimal PAPCE = usuarioEmpresa.Empresa2__r.PAPCE__c;
			Decimal PAPCT = usuarioEmpresa.Empresa2__r.PAPCT__c;
			Decimal porReservaL = usuarioEmpresa.Empresa2__r.Porcentaje_de_Aportaciones_Reserva_Labor__c;
			
			Decimal salarioSS = usuarioEmpresa.Empresa2__r.Salario_Base_Seguro_Social__c;
			decimal salarioRP = usuarioEmpresa.empresa2__r.Salario_Base_Seguro_Social_RP__c;
           	decimal salarioMater=usuarioEmpresa.empresa2__r.Salario_Base_Seguro_Social_Mater__c;
                
			decimal yeah1 = (( salarioSS * usuarioEmpresa.Empresa2__r.Porc_Apor_SSoc_Empleador_IVM__c)/100).setScale(2);
	        decimal yeah2 = ((salarioSS * usuarioEmpresa.Empresa2__r.Porc_Apor_SSoc_Empleado_IVM__c)/100).setScale(2);
			decimal yeah3 = ((salarioMater * usuarioEmpresa.Empresa2__r.Porc_Apor_SSoc_Empleador_Mater__c)/100).setScale(2);
	        decimal yeah4 = ((salarioMater * usuarioEmpresa.Empresa2__r.Porc_Apor_SSoc_Empleado_Mater__c)/100).setScale(2);
	        decimal yeah5 = ((salariorp * usuarioEmpresa.Empresa2__r.Riesgo_Profecional_Patronal__c)/100).setScale(2);
         	list<string> cuentas = new list<string> ();
            
            for(cuentas_colectivas__C item:[select codigo__C from cuentas_colectivas__C where tipo_cuenta__C!='Voluntarias' and empresa__c=:Codigo_Unico_Banco])
            {
                cuentas.add(item.Codigo__c);
            }
             
            
            list<string> identificaciones = new list<string> ();
            for(cuentas__c item: [select cliente__C from Cuentas__c where Cuenta_colectiva2__r.codigo__C  in :(cuentas)])
            {
                identificaciones.add(item.cliente__C);
            }
                
            decimal tasa = [select tasa__C from Tasa_De_Cambio__c limit 1].tasa__C;   
			For(Empresa_x_Empleado__c item : [Select Empleado2__c, Empleado2__r.FirstName, Empleado2__r.LastName,CurrencyIsoCode,
											Empleado2__r.Identificacion__c, Salario__c
											From Empresa_x_Empleado__c
											Where Empleado2__c in :(identificaciones)
											AND Estado__c = 'Activo' order by Empleado2__r.Firstname asc]){
				
		 		Decimal APO = 0;
		 		Decimal AEO = 0;
		 		Decimal laboral = 0;
		 		if(item.CurrencyIsoCode=='USD')
                {
                    item.Salario__c=item.Salario__c*tasa;
                }
                                                
                
                	if(item.Salario__c != null){
                    if((((Item.Salario__c - salarioBaseEmpresa) * PAPCE)/100) > 0)
                    {
                        APO = (((item.Salario__c - salarioBaseEmpresa) * PAPCE)/100).setScale(2);
                    }
                    if((((item.Salario__c - salarioBaseEmpresa) * PAPCT)/100) > 0)
                    {
                        AEO = (((item.Salario__c - salarioBaseEmpresa) * PAPCT)/100).setScale(2);
                    }
                    
                    
                    if(item.Salario__c > salarioBaseReservaL)
                    {
                    		Decimal resevaL = (( salarioBaseReservaL * porReservaL ) / 100).setScale(2);
                    		
                        if(resevaL > 0)
                        {
                             laboral = resevaL;
                        }
                       
                    }
                    else
                    {
                    		Decimal resevaL = (( item.Salario__c * porReservaL ) / 100).setScale(2);
                        if(resevaL > 0)
                        {
                            laboral = resevaL;
                        }
                        
                    }
                }
                
                listDatos.add(new clasePilares(item.Empleado2__r.Identificacion__c,
								item.Empleado2__r.FirstName, item.Empleado2__r.LastName, 
								item.Salario__c,APO,AEO,laboral,
        					        yeah1,yeah2,yeah3,yeah4,yeah5));
            }
            totalempleados = listdatos.size();
            if(listdatos.size() > 0)
            {
                sumas();
            }
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
    		}Catch(Exception e){
    			system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
			ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, '¡Ha ocurrido un error, favor contacte a su administrador!'));	
    		}
    }
    
    public pagereference Descargar()
    {
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        	hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
         return new pagereference ('/apex/vfExportarExcelcalculopilares?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario);
       
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
    
    public void sumas()
    {
        try
        {
            yeah1=0;
            yeah2=0;
            yeah3=0;
            yeah4=0;
            yeah5=0;
            totalAPO=0;
            totalsueldos=0;
            totalAEO=0;
            totalreserva=0;
            for(integer i=0; i<listDatos.size(); i++)
            {
                yeah1 +=listDatos[i].yeah1;
                yeah2 +=listDatos[i].yeah2;
                yeah3 +=listDatos[i].yeah3;
                yeah4 +=listDatos[i].yeah4;
                yeah5 +=listDatos[i].yeah5;
                totalAPO +=listDatos[i].apo;
                totalAEO +=listDatos[i].aeo;
                totalsueldos +=listDatos[i].Salario;
                totalreserva +=listDatos[i].laboral;
            }
        }
        catch(exception ex)
        {
            
        }
    }
    
    
    
    public class clasePilares{
    		Public string identidad{get;set;}
    		Public string Nombres{get;set;}
    		Public string Apellidos{get;set;}
    		Public Decimal Salario{get;set;}
    		Public Decimal APO{get;set;}
    		Public Decimal AEO{get;set;}
    		Public Decimal Laboral{get;set;}
    		Public Decimal yeah1{get;set;}
    		Public Decimal yeah2{get;set;}
    		Public Decimal yeah3{get;set;}
    		Public Decimal yeah4{get;set;}
    		Public Decimal yeah5{get;set;}
    		 
    		public clasePilares(String identidad, String Nombres, String Apellidos, Decimal Salario,
    							Decimal APO, Decimal AEO, Decimal Laboral, Decimal yeah1, Decimal yeah2, Decimal yeah3,
    							Decimal yeah4, Decimal yeah5){
    								
    			this.identidad = identidad;
    			this.Nombres = Nombres;
    			this.Apellidos = Apellidos;
    			this.Salario = Salario;
    			this.APO = APO;
    			this.AEO = AEO;
    			this.Laboral = Laboral;
    			this.yeah1 = yeah1;
    			this.yeah2 = yeah2;
    			this.yeah3 = yeah3;
    			this.yeah4 = yeah4;
    			this.yeah5 = yeah5;
    			
    		}
    }
}