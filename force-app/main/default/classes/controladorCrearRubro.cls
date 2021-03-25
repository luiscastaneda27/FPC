public class controladorCrearRubro {

   
  
    public List<SelectOption> options {get;set;}
    string nombrerubro;
    public string Nombre_Boton{get;set;}
    public string id_Rubro{get;set;}
    public boolean MostarGuardar {get;set;}
    public boolean MostarActualizar {get;set;}
    public Rubro__c rubro {get;set;}
    
    
    
    public controladorCrearRubro() {
			MostarGuardar=false;
            MostarActualizar=true;
        	Nombre_Boton='Nuevo Rubro';
           rubro=new Rubro__c();
          options=new List<SelectOption>();
        	llenarRubros();
          
     }
    public void llenarRubros()
    {
         list<Rubro__c> rubros = new list<Rubro__C>();
        rubros=[select id, name from rubro__c order by name asc];
        options=new List<SelectOption>();
        for(integer i=0; i<rubros.size(); i++)
        {
            options.add(new SelectOption(rubros[i].id,rubros[i].name));
        }
        if(rubros.size() > 0)
        {
         rubro =[select name,PAPCE__c,PAPCT__c,Porc_Apor_SSoc_Empleado_IVM__c,Porc_Apor_SSoc_Empleado_Mate__c,
                 Salario_Base_Seguro_Social_Mater__c, Salario_Base_Seguro_Social_RP__c,
                   Porc_Apor_SSoc_Empleador_IVM__c,Porc_Apor_SSoc_Empleador_Mater__c,Porcentaje_de_aportaciones_Reserva_Labor__c,
                   Riesgo_Profecional_Patronal__c,Salario_Base_Pilar_Complementario__c,Salario_Base_Reserva_Laboral__c,Salario_Base_Seguro_Social__c
                   from rubro__c where id=:rubros[0].id ];
            nombrerubro=rubro.name;
        }
    }
    
  
    
    public void Guardar() {
        try{
            integer u =[select count() from rubro__c where name=:rubro.name];
            if(u==0 && rubro.name !=null)
            {   
                if(rubro.Salario_Base_Pilar_Complementario__c!=null && rubro.Salario_Base_Reserva_Laboral__c!=null &&
                  rubro.PAPCE__c!=null && rubro.PAPCT__c!=null &&
                  rubro.Porcentaje_de_aportaciones_Reserva_Labor__c!=null && rubro.Salario_Base_Seguro_Social__c!=null &&
                  rubro.Porc_Apor_SSoc_Empleador_IVM__c!=null && rubro.Porc_Apor_SSoc_Empleado_IVM__c!=null &&
                  rubro.Salario_Base_Seguro_Social_Mater__c!=null && rubro.Porc_Apor_SSoc_Empleador_Mater__c!=null &&
                  rubro.Porc_Apor_SSoc_Empleado_Mate__c!=null && rubro.Salario_Base_Seguro_Social_RP__c!=null &&
                  rubro.Riesgo_Profecional_Patronal__c!=null)
                {
                    insert rubro;
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'El Rubro se guado exitosamente'));
                 Nombre_Boton='Nuevo Rubro';
                Rubro = new Rubro__c();
                llenarRubros();
                MostarActualizar=true;
                MostarGuardar=false;
                
                }
                else
                {
                     ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Faltan campos obligatorios')); 
                    
                }
                
                
            }
            else
            {
                 ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Ya existe un rubro con este nombre')); 
                
            }
           }
        Catch(Exception ex)
        {
            
        }
   }
    public Pagereference regresar()
    {
        return new PageReference('/apex/vfConfigPortalPlanillas');
    }
    public VOid crearRubro()
    {
        rubro = new Rubro__c();
        if(Nombre_Boton=='Cancelar')
        {
            Nombre_Boton='Nuevo Rubro';
            llenarRubros();
            MostarActualizar=true;
            MostarGuardar=false;
        }
        else
        {
            MostarActualizar=false;
            MostarGuardar=true;
            options=new List<SelectOption>();
            options.add(new SelectOption('sqw','--Ninguno--'));
            Nombre_Boton='Cancelar';
        }
    }
    
    
    
    public void Modificar() {
        try{
             
            
                if(rubro.Salario_Base_Pilar_Complementario__c!=null && rubro.Salario_Base_Reserva_Laboral__c!=null &&
                  rubro.PAPCE__c!=null && rubro.PAPCT__c!=null &&
                  rubro.Porcentaje_de_aportaciones_Reserva_Labor__c!=null && rubro.Salario_Base_Seguro_Social__c!=null &&
                  rubro.Porc_Apor_SSoc_Empleador_IVM__c!=null && rubro.Porc_Apor_SSoc_Empleado_IVM__c!=null &&
                  rubro.Salario_Base_Seguro_Social_Mater__c!=null && rubro.Porc_Apor_SSoc_Empleador_Mater__c!=null &&
                  rubro.Porc_Apor_SSoc_Empleado_Mate__c!=null && rubro.Salario_Base_Seguro_Social_RP__c!=null &&
                  rubro.Riesgo_Profecional_Patronal__c!=null)
                {
               		 if(nombrerubro == rubro.name )
            {
                Rubro__c rubroviejo=new Rubro__c();            
				rubroviejo=[select PAPCE__c, PAPCT__c, Porc_Apor_SSoc_Empleado_IVM__c, Porc_Apor_SSoc_Empleado_Mate__c, 
                            Porc_Apor_SSoc_Empleador_Mater__c, Porcentaje_de_aportaciones_Reserva_Labor__c, 
                            Porc_Apor_SSoc_Empleador_IVM__C, Riesgo_Profecional_Patronal__c, 
                            Salario_Base_Pilar_Complementario__c, Salario_Base_Reserva_Laboral__c, 
                            Salario_Base_Seguro_Social__c, Salario_Base_Seguro_Social_Mater__c,
                            Salario_Base_Seguro_Social_RP__c 
                            from rubro__C where id=:id_rubro];          
            	rubro.id=id_rubro;
                update rubro;
            list<Account> Empresas =new List<Account>();
            empresas=[select id, PAPCE__c, PAPCT__c, Porc_Apor_SSoc_Empleado_IVM__c, Porc_Apor_SSoc_Empleado_Mater__c, 
                      Porc_Apor_SSoc_Empleador_Mater__c, Porcentaje_de_aportaciones_Reserva_Labor__c, 
                      Porc_Apor_SSoc_Empleador_IVM__C, Riesgo_Profecional_Patronal__c, 
                      Salario_Base_Pilar_Complementario__c, Salario_Base_Reserva_Laboral__c, 
                      Salario_Base_Seguro_Social__c,Salario_Base_Seguro_Social_Mater__c,
                      Salario_Base_Seguro_Social_RP__c 
                      from Account where rubro__C=:id_rubro];
            for(Integer i=0; i<empresas.size(); i++)
            {
                if(empresas[i].PAPCE__c==rubroviejo.PAPCE__c)
                {
                    empresas[i].PAPCE__c=rubro.PAPCE__c;
                }
                if(empresas[i].PAPCT__c==rubroviejo.PAPCT__c)
                {
                    empresas[i].PAPCT__c=rubro.PAPCT__c;
                }
                if(empresas[i].Porc_Apor_SSoc_Empleado_IVM__c==rubroviejo.Porc_Apor_SSoc_Empleado_IVM__c)
                {
                    empresas[i].Porc_Apor_SSoc_Empleado_IVM__c=rubro.Porc_Apor_SSoc_Empleado_IVM__c;
                }
                 if(empresas[i].Porc_Apor_SSoc_Empleado_Mater__c==rubroviejo.Porc_Apor_SSoc_Empleado_Mate__C)
                {
                    empresas[i].Porc_Apor_SSoc_Empleado_Mater__c=rubro.Porc_Apor_SSoc_Empleado_Mate__c;
                }
                 if(empresas[i].Porc_Apor_SSoc_Empleador_Mater__c==rubroviejo.Porc_Apor_SSoc_Empleador_Mater__C)
                {
                    empresas[i].Porc_Apor_SSoc_Empleador_Mater__c=rubro.Porc_Apor_SSoc_Empleador_Mater__c;
                }
                if(empresas[i].Porcentaje_de_aportaciones_Reserva_Labor__c==rubroviejo.Porcentaje_de_aportaciones_Reserva_Labor__C)
                {
                  empresas[i].Porcentaje_de_aportaciones_Reserva_Labor__c=rubro.Porcentaje_de_aportaciones_Reserva_Labor__c;  
                }
                 if(empresas[i].Porc_Apor_SSoc_Empleador_IVM__C==rubroviejo.Porc_Apor_SSoc_Empleador_IVM__C)
                {
                  empresas[i].Porc_Apor_SSoc_Empleador_IVM__C=rubro.Porc_Apor_SSoc_Empleador_IVM__c;
                }
                 if(empresas[i].Porcentaje_de_aportaciones_Reserva_Labor__c==rubroviejo.Porcentaje_de_aportaciones_Reserva_Labor__c)
                {
                    empresas[i].Porcentaje_de_aportaciones_Reserva_Labor__c=rubro.Porcentaje_de_aportaciones_Reserva_Labor__c;
                }
                 if(empresas[i].Riesgo_Profecional_Patronal__c==rubroviejo.Riesgo_Profecional_Patronal__C)
                {
                   empresas[i].Riesgo_Profecional_Patronal__c=rubro.Riesgo_Profecional_Patronal__c; 
                }
                if(empresas[i].Salario_Base_Pilar_Complementario__c==rubroviejo.Salario_Base_Pilar_Complementario__C)
                {
                    empresas[i].Salario_Base_Pilar_Complementario__c=rubro.Salario_Base_Pilar_Complementario__c;
                }
                if( empresas[i].Salario_Base_Reserva_Laboral__c==rubroviejo.Salario_Base_Reserva_Laboral__C)
                { 
                	empresas[i].Salario_Base_Reserva_Laboral__c=rubro.Salario_Base_Reserva_Laboral__c;
                }
                if(empresas[i].Salario_Base_Seguro_Social__c==rubroviejo.Salario_Base_Seguro_Social__C)
                {
                    empresas[i].Salario_Base_Seguro_Social__c=rubro.Salario_Base_Seguro_Social__c;
                }
                if(empresas[i].Salario_Base_Seguro_Social_Mater__c==rubroviejo.Salario_Base_Seguro_Social_Mater__c)
                {
                      empresas[i].Salario_Base_Seguro_Social_Mater__c=rubro.Salario_Base_Seguro_Social_Mater__c;
               }
               if(empresas[i].Salario_Base_Seguro_Social_RP__c==rubroviejo.Salario_Base_Seguro_Social_RP__c)
               {
                    empresas[i].Salario_Base_Seguro_Social_RP__c=rubro.Salario_Base_Seguro_Social_RP__c;
               }
                
            }
           
                update empresas;
                 ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'El Rubro se actualizo exitosamente')); 
               //Rubro = new Rubro__C(); 
				//llenarRubros();            
            }
           	else
            {
             	 integer u = [select count() from rubro__C where name =:rubro.name and name !=null];
                if(u==0)
                {
                    Rubro__c rubroviejo=new Rubro__c();            
                        rubroviejo=[select PAPCE__c, PAPCT__c, Porc_Apor_SSoc_Empleado_IVM__c, Porc_Apor_SSoc_Empleado_Mate__c, 
                                    Porc_Apor_SSoc_Empleador_Mater__c, Porcentaje_de_aportaciones_Reserva_Labor__c,
                                    Porc_Apor_SSoc_Empleador_IVM__C, Riesgo_Profecional_Patronal__c, 
                                    Salario_Base_Pilar_Complementario__c, Salario_Base_Reserva_Laboral__c,
                                    Salario_Base_Seguro_Social__c,Salario_Base_Seguro_Social_Mater__c,
                      				Salario_Base_Seguro_Social_RP__c  from rubro__C where id=:id_rubro];          
                        rubro.id=id_rubro;
                        update rubro;
                        list<Account> Empresas =new List<Account>();
                        empresas=[select id, PAPCE__c, PAPCT__c, Porc_Apor_SSoc_Empleado_IVM__c, Porc_Apor_SSoc_Empleado_Mater__c, 
                                  Porc_Apor_SSoc_Empleador_Mater__c, Porcentaje_de_aportaciones_Reserva_Labor__c, 
                                  Porc_Apor_SSoc_Empleador_IVM__C, Riesgo_Profecional_Patronal__c, 
                                  Salario_Base_Pilar_Complementario__c, Salario_Base_Reserva_Laboral__c, 
                                  Salario_Base_Seguro_Social__c,Salario_Base_Seguro_Social_Mater__c,
                      			Salario_Base_Seguro_Social_RP__c  from Account where rubro__C=:id_rubro];
                    for(Integer i=0; i<empresas.size(); i++)
                    {
                        if(empresas[i].PAPCE__c==rubroviejo.PAPCE__c)
                        {
                            empresas[i].PAPCE__c=rubro.PAPCE__c;
                        }
                        if(empresas[i].PAPCT__c==rubroviejo.PAPCT__c)
                        {
                            empresas[i].PAPCT__c=rubro.PAPCT__c;
                        }
                        if(empresas[i].Porc_Apor_SSoc_Empleado_IVM__c==rubroviejo.Porc_Apor_SSoc_Empleado_IVM__c)
                        {
                            empresas[i].Porc_Apor_SSoc_Empleado_IVM__c=rubro.Porc_Apor_SSoc_Empleado_IVM__c;
                        }
                         if(empresas[i].Porc_Apor_SSoc_Empleado_Mater__c==rubroviejo.Porc_Apor_SSoc_Empleado_Mate__C)
                        {
                            empresas[i].Porc_Apor_SSoc_Empleado_Mater__c=rubro.Porc_Apor_SSoc_Empleado_Mate__c;
                        }
                         if(empresas[i].Porc_Apor_SSoc_Empleador_Mater__c==rubroviejo.Porc_Apor_SSoc_Empleador_Mater__C)
                        {
                            empresas[i].Porc_Apor_SSoc_Empleador_Mater__c=rubro.Porc_Apor_SSoc_Empleador_Mater__c;
                        }
                        if(empresas[i].Porcentaje_de_aportaciones_Reserva_Labor__c==rubroviejo.Porcentaje_de_aportaciones_Reserva_Labor__C)
                        {
                          empresas[i].Porcentaje_de_aportaciones_Reserva_Labor__c=rubro.Porcentaje_de_aportaciones_Reserva_Labor__c;  
                        }
                         if(empresas[i].Porc_Apor_SSoc_Empleador_IVM__C==rubroviejo.Porc_Apor_SSoc_Empleador_IVM__C)
                        {
                          empresas[i].Porc_Apor_SSoc_Empleador_IVM__C=rubro.Porc_Apor_SSoc_Empleador_IVM__c;
                        }
                         if(empresas[i].Porcentaje_de_aportaciones_Reserva_Labor__c==rubroviejo.Porcentaje_de_aportaciones_Reserva_Labor__c)
                        {
                            empresas[i].Porcentaje_de_aportaciones_Reserva_Labor__c=rubro.Porcentaje_de_aportaciones_Reserva_Labor__c;
                        }
                         if(empresas[i].Riesgo_Profecional_Patronal__c==rubroviejo.Riesgo_Profecional_Patronal__C)
                        {
                           empresas[i].Riesgo_Profecional_Patronal__c=rubro.Riesgo_Profecional_Patronal__c; 
                        }
                        if(empresas[i].Salario_Base_Pilar_Complementario__c==rubroviejo.Salario_Base_Pilar_Complementario__C)
                        {
                            empresas[i].Salario_Base_Pilar_Complementario__c=rubro.Salario_Base_Pilar_Complementario__c;
                        }
                        if( empresas[i].Salario_Base_Reserva_Laboral__c==rubroviejo.Salario_Base_Reserva_Laboral__C)
                        { 
                            empresas[i].Salario_Base_Reserva_Laboral__c=rubro.Salario_Base_Reserva_Laboral__c;
                        }
                        if(empresas[i].Salario_Base_Seguro_Social__c==rubroviejo.Salario_Base_Seguro_Social__C)
                        {
                            empresas[i].Salario_Base_Seguro_Social__c=rubro.Salario_Base_Seguro_Social__c;
                        }
                         if(empresas[i].Salario_Base_Seguro_Social_Mater__c==rubroviejo.Salario_Base_Seguro_Social_Mater__c)
                        {
                            empresas[i].Salario_Base_Seguro_Social_Mater__c=rubro.Salario_Base_Seguro_Social_Mater__c;
                        }
                        if(empresas[i].Salario_Base_Seguro_Social_RP__c==rubroviejo.Salario_Base_Seguro_Social_RP__c)
                        {
                            empresas[i].Salario_Base_Seguro_Social_RP__c=rubro.Salario_Base_Seguro_Social_RP__c;
                        }
                       
                        
                    }
                   
                        update empresas;
                         ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'El Rubro se actualizo exitosamente')); 
                   // Rubro = new Rubro__C(); 
				//llenarRubros();  
                }
                else
                {
                     ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Ya existe un Rubro con este Nombre')); 
                    
                }
            }     
                }
                else
                {
                   ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Faltan campos obligatorios'));  
                }
                
               
            
            	
           }
        Catch(Exception ex)
        {
            
        }
        
        
   }
   
    
	public void LLenardatos()
        {
            try{
            rubro = new Rubro__C();
            rubro =[select name,PAPCE__c,PAPCT__c,Porc_Apor_SSoc_Empleado_IVM__c,Porc_Apor_SSoc_Empleado_Mate__c,
                   Porc_Apor_SSoc_Empleador_IVM__c,Porc_Apor_SSoc_Empleador_Mater__c,Porcentaje_de_aportaciones_Reserva_Labor__c,
                   Riesgo_Profecional_Patronal__c,Salario_Base_Pilar_Complementario__c,Salario_Base_Reserva_Laboral__c,Salario_Base_Seguro_Social__c,
                    Salario_Base_Seguro_Social_MAter__c,Salario_Base_Seguro_Social_RP__c
                   from rubro__c where id=:id_rubro];
             	nombrerubro=rubro.name;
            }
            Catch(Exception ex)
            {
                
            }
        }    
    
    
    
    
    
    
    
}