public class controladoCrearEmpresa {

   
     public List<SelectOption> options {get;set;}
     public List<SelectOption> options2 {get;set;}
     public string id_Rubro{get;set;}
     public string id_Empresa{get;set;}   
     public Account empresa {get;set;}
     public Cuentas_Colectivas__c cuentas {get;set;}
     public List<SelectOption> cuentasEmpresa {get;set;}
     public string tipoceunta{get;set;}
     public boolean popcuentas{get;set;}
     public string id_cuenta{get;set;}
     public string nombre_empresa{get;set;}
     public string codigoCuenta{get;set;}
    
    public controladoCrearEmpresa() {
		
           empresa = new Account();
           options=new List<SelectOption>();
           options2=new List<SelectOption>();
           llenarRubros(); 
           cuentas = new Cuentas_Colectivas__c();
           popcuentas=false;
           llenarEmpresa();                 
     }
    
    public void cerrar()
    {
        popcuentas=false;
    }
    public void ActPop()
    {
        nombre_Empresa = [Select name from Account where id=:id_Empresa].name;
        popcuentas=true;
        LLenarCuentas();
    }
    public void LLenarDatosRubros()
    {
        try{
            Rubro__c rubro=new Rubro__c();
            empresa = new Account();
            if(id_rubro!='--Ninguno--'){
                
                rubro =[select name,PAPCE__c,PAPCT__c,Porc_Apor_SSoc_Empleado_IVM__c,Porc_Apor_SSoc_Empleado_Mate__c,
                        Salario_Base_Seguro_Social_Mater__c,Salario_Base_Seguro_Social_RP__c,
                        Porc_Apor_SSoc_Empleador_IVM__c,Porc_Apor_SSoc_Empleador_Mater__c,
                        Porcentaje_de_aportaciones_Reserva_Labor__c, Riesgo_Profecional_Patronal__c,Salario_Base_Pilar_Complementario__c,
                        Salario_Base_Reserva_Laboral__c,Salario_Base_Seguro_Social__c
                        from rubro__c where id=:id_rubro];
                empresa.PAPCE__c=rubro.PAPCE__c;
                empresa.PAPCT__c=rubro.PAPCT__c;
                empresa.Porc_Apor_SSoc_Empleado_IVM__c=rubro.Porc_Apor_SSoc_Empleado_IVM__c;
                empresa.Porc_Apor_SSoc_Empleado_Mater__c=rubro.Porc_Apor_SSoc_Empleado_Mate__c;
                empresa.Porc_Apor_SSoc_Empleador_Mater__c=rubro.Porc_Apor_SSoc_Empleador_Mater__c;
                empresa.Salario_Base_Seguro_Social_Mater__c=rubro.Salario_Base_Seguro_Social_Mater__c;
                empresa.Salario_Base_Seguro_Social_RP__c=rubro.Salario_Base_Seguro_Social_RP__c;
                empresa.Porcentaje_de_aportaciones_Reserva_Labor__c=rubro.Porcentaje_de_aportaciones_Reserva_Labor__c;
                empresa.Porc_Apor_SSoc_Empleador_IVM__c= rubro.Porc_Apor_SSoc_Empleador_IVM__c;
                empresa.Porcentaje_de_aportaciones_Reserva_Labor__c=rubro.Porcentaje_de_aportaciones_Reserva_Labor__c;
                empresa.Riesgo_Profecional_Patronal__c=rubro.Riesgo_Profecional_Patronal__c;
                empresa.Salario_Base_Pilar_Complementario__c=rubro.Salario_Base_Pilar_Complementario__c;
                empresa.Salario_Base_Reserva_Laboral__c=rubro.Salario_Base_Reserva_Laboral__c;
                empresa.Salario_Base_Seguro_Social__c=rubro.Salario_Base_Seguro_Social__c;
                empresa.Salario_Base_Seguro_Social_mater__c=rubro.Salario_Base_Seguro_Social_mater__c;
                empresa.Salario_Base_Seguro_Social_rp__c=rubro.Salario_Base_Seguro_Social_rp__c;
                
            }
            
        }Catch(Exception ex){
            
        }
    }
    
    
    
    public void llenarRubros(){
        try{
            list<Rubro__c> rubros = new list<Rubro__C>();
            rubros=[select id, name from rubro__c order by name desc];
            options=new List<SelectOption>();
            options.add(new SelectOption('--Ninguno--','--Ninguno--'));
            for(integer i=0; i<rubros.size(); i++) {
                options.add(new SelectOption(rubros[i].id,rubros[i].name));
                
            }
            
        }Catch(Exception ex){
            
        }
    }
    
    
    public void llenarEmpresa()
    {
        try{
            list<Account> Empresas = new list<Account>();
            Empresas=[select id, name,isPersonAccount   from Account where recordtype.developername='Juridico' and isPersonAccount =false order by name asc];
            options2=new List<SelectOption>();
            for(integer i=0; i<Empresas.size(); i++) {
                options2.add(new SelectOption(Empresas[i].id,Empresas[i].name));
            }

            empresa =[select  Rubro__c ,name,PAPCE__c,PAPCT__c,Porc_Apor_SSoc_Empleado_IVM__c,
                      Porc_Apor_SSoc_Empleado_Mater__c, Porc_Apor_SSoc_Empleador_IVM__c, Porc_Apor_SSoc_Empleador_Mater__c,
                      Porcentaje_de_aportaciones_Reserva_Labor__c, Salario_Base_Seguro_Social_Mater__c, 
                      Salario_Base_Seguro_Social_RP__c, Riesgo_Profecional_Patronal__c,
                      Salario_Base_Pilar_Complementario__c,Salario_Base_Reserva_Laboral__c,Salario_Base_Seguro_Social__c
                   		from Account where id=:Empresas[0].id];             	 
                    id_Rubro=empresa.rubro__C;
        }
        catch(Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Se ha producido un error'));  
        }
    }
    
    public void Modificar() {
        try{
            if([select count() from cuentas_colectivas__C where empresa__C=:id_empresa]>0)
            {
                if(id_rubro!='--Ninguno--')
                {
                   empresa.id=id_empresa;
                    empresa.Rubro__c=id_rubro;
                    update empresa;
                    llenarEmpresa();
                    //empresa= new Account();
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Datos Guardados Exitosamente')); 
                    LLenarRubros(); 
                }
                else
                {
                   ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Seleccione un rubro'));  
                }
            }
            else
            {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Esta Empresa no tiene cuentas vinculadas, favor agregar')); 
            }
            
            
           }
        Catch(Exception ex)
        {
          ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Se ha producido un error'));   
        }
        
        
   }
   
    public Pagereference regresar() 
    {
        return new PageReference('/apex/vfConfigPortalPlanillas');
    }
    public void GuardarCuentas()
    {
        try
        {
           if(codigoCuenta != null && cuentas.Tipo_Cuenta__c != null && codigoCuenta != '' )
           {
               if([select count() from cuentas__C where cliente__C=:id_empresa and codigo__C=:codigoCuenta]==1)
               {
                   cuentas.empresa__C=id_empresa;
                   cuentas.Codigo__c=codigoCuenta;
                   insert cuentas;
                   codigoCuenta =''; 
                   cuentas = new cuentas_colectivas__C();
                   ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Datos Guardados Correctamente'));
                   LLenarCuentas();
               }
               else
               {
                 ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'La cuenta no pertenece a esta empresa'));  
               }
               
           }
           else
           {
              ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Faltas campos obligatorios'));  
           }
        }
        catch(Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Esta Cuenta ya existe, favor ingresar otra')); 	

        }
    }
    public void ELiminarCuentas()
    {
        try
        {
           if(id_cuenta != null)
           {
               cuentas_colectivas__C cuen = new cuentas_colectivas__C(); 
               cuen.Id= id_cuenta;
               delete cuen;
               ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Cuenta eliminada correctamente'));
               LLenarCuentas();
           }
            else
            {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Seleccione una cuenta'));
            }
        }
        catch(Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, '¡Ha ocurrido un error!')); 	

        }
    }
    
    public void LLenarCuentas()
    {
        try
        {
            integer t=0;
            cuentasEmpresa = new List<SelectOption>();
            for(cuentas_colectivas__C item: [select codigo__c, id from cuentas_colectivas__C where empresa__C=:id_empresa])
                
            {
               cuentasEmpresa.add(new SelectOption(item.id, item.Codigo__c));
               if(t==0)
               {
                   t=1;
                   id_cuenta=item.id;
               }
            }
        }
        catch(Exception ex)
        {
            
        }
    }
    
    
    
	public void LLenardatosEmpresa()
        {
            try{
            empresa =[select Identificacion__C, Rubro__c ,name,PAPCE__c,PAPCT__c,Porc_Apor_SSoc_Empleado_IVM__c,
                      Porc_Apor_SSoc_Empleado_Mater__c, Porc_Apor_SSoc_Empleador_IVM__c,Porc_Apor_SSoc_Empleador_Mater__c,
                      Porcentaje_de_aportaciones_Reserva_Labor__c, Riesgo_Profecional_Patronal__c,
                      Salario_Base_Pilar_Complementario__c,Salario_Base_Reserva_Laboral__c,Salario_Base_Seguro_Social__c,
                      Salario_Base_Seguro_Social_mater__c, Salario_Base_Seguro_Social_rp__c
                   from Account where id=:id_Empresa];
                   id_Rubro=empresa.rubro__C;
                 
            }
            Catch(Exception ex)
            {
                system.debug(ex.getMessage()+ex.getLineNumber());
            }
        }    
    
    
}