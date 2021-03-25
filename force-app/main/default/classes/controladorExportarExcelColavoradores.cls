public class controladorExportarExcelColavoradores {
	
   public List<claseColaboradores> listClientes2{get;set;}
    
    public controladorExportarExcelColavoradores()
    {
        try
        {
          string Codigo_Unico_Banco=ApexPages.currentPage().getParameters().get('empresa');  
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
               // listClientes = new list<claseColaboradores>();
                listClientes2 = new list<claseColaboradores>();
                //listClientes3 = new list<claseColaboradores>();
               //  nombre_empresa=[select name from account where id=:Codigo_Unico_Banco].name;
                map<string, integer> frv= new map<string, integer>();
                list<string> identidadesregistradas= new list<string>();
              	 for( cuentas__C item :[select cliente__r.Estado_Civil__pc,cliente__c , cliente__r.PersonBirthdate ,cliente__r.tipo_Identificacion__C,
                              cliente__r.Identificacion__C ,cliente__r.firstname, cliente__r.lastname
                              from cuentas__C where cliente__C  in :identidadesbuenas and 
                                        cliente__c not in (select empleado2__c from empresa_x_Empleado__C where empresa2__C=:codigo_unico_banco and estado__c='Despedido' ) 
                                        order by cliente__r.firstname asc limit 1800])
                {
                 
                     if(!frv.containsKey(item.cliente__C))
                     {
                         listClientes2.add(new claseColaboradores(null, item.cliente__r.tipo_identificacion__c, item.cliente__r.identificacion__C,
                                                                item.cliente__r.firstname, item.cliente__r.lastname, item.cliente__r.PersonBirthdate, 
                                                                item.cliente__r.estado_civil__pc, 0.0, null));
                        
                         frv.put(item.cliente__C, 3);
                         identidadesregistradas.add(item.cliente__C);
                         
                         
                     }
                }
            frv.clear();
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
        }
        catch(Exception ex)
        {
            
        }
    }
    
    
    
}