public class ControladorHome {

    
    public string NombreUsuario{get;set;}
    public string NombreEmpresa{get;set;}
    public string UltimoIngreso{get;set;}
    string usuario;
    string codigo_Unico_Banco;
   public string UltimoIngreso1{get;set;}
    public bitacora_Login__C prueba{get;set;}
   public string tipoletra{get;set;}
    public ControladorHome()
    {
        try{ 
        Codigo_Unico_Banco=ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
         Usuario=ApexPages.currentPage().getParameters().get('loetdncdhjch');
        DatosHome();
      	tipoletra='"Open Sans Light",Helvetica,Arial,sans-serif;';
        //tipoletra='arial';
       }
        catch(Exception ex)
        {
            
        }
    }
    
    
    
    
    
     public void DatosHome()
   {
       try{
       		Usuario_x_Empresa__c usuarioEmpresa = [Select Empresa2__r.Name, Usuario__r.Name, Usuario__r.Apellidos__c
       												from Usuario_x_Empresa__c 
	              									where empresa2__c =: Codigo_Unico_Banco 
	              									and Usuario__c =: Usuario];
       		
           
           NombreEmpresa = usuarioEmpresa.Empresa2__r.Name;
           NombreUsuario = usuarioEmpresa.Usuario__r.Name + ' ' + usuarioEmpresa.Usuario__r.Apellidos__c;
           
           list<bitacora_Login__C> listfechas = new  list<bitacora_Login__C>();
           listfechas =[select fecha__C 
           			from bitacora_Login__C 
           			where usuario__C=:usuario 
           			and Ingreso_Logrado__c=true 
           			order by fecha__C desc limit 2];
          
          Prueba = new bitacora_Login__C();
           if (listfechas.size()==2)
           {
               prueba=listfechas[1];
              UltimoIngreso=string.valueOf(listfechas[1].fecha__C);
           }
           else
           {
               UltimoIngreso='Hola '+Nombreusuario+' es tu primer ingreso.';
           }
          
       }
      Catch(Exception ex)
       {
            
           
       }
   }
      
    
}