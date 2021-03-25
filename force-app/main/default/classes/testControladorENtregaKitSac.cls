@istest
public class testControladorENtregaKitSac {
    
      static testMethod void controladorReporteCalidad_BFH_PM_FIC(){
        Usuarios_de_Pantallas__c usuario = new Usuarios_de_Pantallas__c ();
        usuario.Activo__c = true;
        usuario.Usuario__c = 'juan123';
        usuario.Contrase_a__c = 'juan123';
        usuario.name = 'Juan';
        usuario.Apellido__c='Perez';
        usuario.Email__c = 'juanperez@test.com';
        insert usuario; 
        
		
        
        
          Reporte_calidad__C afiliacion = new Reporte_calidad__C();
          afiliacion.Identificacion__c = '123';
          afiliacion.Espediente_Completo__c = 'S';
          afiliacion.Name = 'Test';
          afiliacion.Codigo_Oficial_SAC__c = usuario.Usuario__c;
          insert afiliacion;
          
          
          
         
         
         
        
          ApexPages.currentPage().getParameters().put('usuario',usuario.Usuario__c);
          controladorENtregaKitSac controlador= new controladorENtregaKitSac();
          
          controlador.idAfiliacion = controlador.listAfiliaciones[0].id;
          controlador.editar();
          controlador.ValidacionIdentidad();
          controlador.guardar();
       
        
            
        
        
        
        
    }
    

}