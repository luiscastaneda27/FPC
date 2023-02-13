@istest
public class testcontroladorReporteCalidad_C_NC_PL {
    
     static testMethod void controladorReporteCalidad_C_NC_PL(){
        Usuarios_de_Pantallas__c usuario = new Usuarios_de_Pantallas__c ();
        usuario.Activo__c = true;
        usuario.Usuario__c = 'juan123';
        usuario.Contrase_a__c = 'juan123';
        usuario.name = 'Juan';
        usuario.Apellido__c='Perez';
        usuario.Email__c = 'juanperez@test.com';
        insert usuario; 
         
         
         oficial_X_asesor__C usu = new oficial_X_asesor__C();
         usu.Codigo_Oficial_SAC__c = usuario.Usuario__c;
         usu.Oficial_SAC__c = UserInfo.getUserId();
         insert usu;
        
		Producto__C producto=New Producto__C();
        producto.Codigo__c='01';
        producto.CurrencyIsoCode='HNL';
        insert producto;
        
         SubProducto__C subP = new SubProducto__C ();
         subP.Producto__c = producto.id;
         subP.Codigo__c = 'FI010';
         subP.Name = 'Sub 1';
         subP.Tipo_Fondo__c = 'L';
         insert subP;
         
         subP = new SubProducto__C ();
         subP.Producto__c = producto.id;
         subP.Codigo__c = 'USD';
         subP.Name = 'Sub 2';
         subP.Tipo_Fondo__c = 'L';
        insert subP;
        
        
        Account empresa= new Account();
        empresa.Name='Empresa Prueba 1';
        empresa.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Juridico').getRecordTypeId();
        empresa.Identificacion__c='012j0000';
        insert empresa;
        
        cuentas__C cuenta = new cuentas__C ();
        cuenta.Cliente__c = empresa.id;
        cuenta.Activo__c = true;
        cuenta.Producto__c = producto.Id;
        cuenta.Subproducto__c = subP.Id;
        cuenta.Codigo__c = '12345';
        insert cuenta;
         
         Reporte_calidad__C afiliacion = new Reporte_calidad__C();
         Afiliacion.name = 'PN';
         Afiliacion.primer_apellido__C = 'PA';
         Afiliacion.Tipo_Identificacion__c='1';
         Afiliacion.Identificacion__c = '12345445';
         afiliacion.empresa__c = empresa.id;
         Afiliacion.Tiene_Id__c = 'S';
         Afiliacion.RTN__c = 'N';
         afiliacion.Subproducto__c  = subP.Id;
         Afiliacion.FATCA__c = 'N';
         Afiliacion.WAIVER__c = 'N';
         Afiliacion.PEP__c = 'N';
         afiliacion.Reporte_Calidad__c = 'C';
         afiliacion.Enviar_Sac__c = true;
         Afiliacion.Procedencia__c = 'N';
         Afiliacion.Addendum__c = 'N';
         Afiliacion.Tipo_Fondo__c = 'M';
         Afiliacion.Formulario_Completo__c = 'S';
         //Afiliacion.espediente_completo__C = 'S';
         afiliacion.Tipo_Afiliacion__c = 'YC';
         afiliacion.Codigo_Oficial_SAC__c = usuario.Usuario__c;
         afiliacion.Codigo_Asesor_Comercial__c = usuario.Usuario__c;
         afiliacion.Oficial_SAC__c = 'Maria Perez';
         insert afiliacion;
         
         
        
        ApexPages.currentPage().getParameters().put('usuario',usuario.Usuario__c);
        ApexPages.currentPage().getParameters().put('idPantalla','C'); 
        controladorReporteCalidad_C_NC_PL controlador= new controladorReporteCalidad_C_NC_PL();
        
         controlador.idAfiliacion = controlador.listAfiliaciones[0].id;
         controlador.editar();
         controlador.Afiliacion.espediente_completo__C = 'N';
          controlador.guardar();
         afiliacion.Enviar_Sac__c = true;
         update afiliacion;
         controlador.reinicar();
         
         controlador.idAfiliacion = controlador.listAfiliaciones[0].id;
         controlador.editar();
         controlador.Afiliacion.espediente_completo__C = 'S';
         controlador.SelectSubProducto();
         controlador.guardar();
         controlador.GuardarPop();
         
         
         afiliacion.Estado__c = 'V';
         afiliacion.Enviar_Sac__c = true;
         afiliacion.Tipo_Afiliacion__c = 'C';
         afiliacion.Espediente_Completo__c = null;
         update afiliacion;
         controlador.reinicar();
         
         controlador.idAfiliacion = controlador.listAfiliaciones[0].id;
         controlador.editar();
         controlador.Afiliacion.espediente_completo__C = 'S';
         controlador.SelectSubProducto();
         controlador.ValidacionIdentidad();
         controlador.guardar();
         controlador.GuardarPop();
         
         
         controlador.listAfiliaciones[0].enviar_afiliacion__C = true;
         
         
         controlador.enviar();
         controlador.accionVacia();
        
        
    }
    

}