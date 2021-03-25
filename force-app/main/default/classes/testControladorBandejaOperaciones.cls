@istest
public class testControladorBandejaOperaciones {
    
     static testMethod void ControladorReporteSeguienteSac (){
        Usuarios_de_Pantallas__c usuario = new Usuarios_de_Pantallas__c ();
        usuario.Activo__c = true;
        usuario.Usuario__c = 'juan123';
        usuario.Contrase_a__c = 'juan123';
        usuario.name = 'Juan';
        usuario.Apellido__c='Perez';
        usuario.Email__c = 'juanperez@test.com';
        insert usuario; 
        
        Producto__C producto=New Producto__C();
        producto.Codigo__c='01';
        producto.CurrencyIsoCode='HNL';
        insert producto;
        
        SubProducto__C subP = new SubProducto__C ();
        subP.Producto__c = producto.id;
        subP.Codigo__c = 'FI010';
        subP.Name = 'Sub 1';
        insert subP;
        
        subP = new SubProducto__C ();
        subP.Producto__c = producto.id;
        subP.Codigo__c = 'USD';
        subP.Name = 'Sub 2';
        insert subP;
        
        
        Account empresa= new Account();
        empresa.Name='Empresa Prueba 1';
        empresa.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Juridico').getRecordTypeId();
        empresa.Identificacion__c='012j0000';
        empresa.Cliente_Unico_Banco__c = '123';
        insert empresa;
        
        cuentas__C cuenta = new cuentas__C ();
        cuenta.Cliente__c = empresa.id;
        cuenta.Activo__c = true;
        cuenta.Producto__c = producto.Id;
        cuenta.Subproducto__c = subP.Id;
        cuenta.Codigo__c = '12345';
        insert cuenta;
        
         
        
        Oficiales_X_Empresa__c oficial = new Oficiales_X_Empresa__c();
        oficial.Empresa__c = empresa.id;
        oficial.Asesor__c = userinfo.getUserId();
        oficial.Codigo_Asesor__c = usuario.Usuario__c;
        oficial.Oficial_SAC__c = userinfo.getUserId();
        oficial.Codigo_Oficial_SAC__c = usuario.Usuario__c;
        insert oficial;
        
        Oficial_X_Asesor__c oficial2 = new Oficial_X_Asesor__c();
        oficial2.Codigo_Oficial_SAC__c = usuario.Usuario__c;
        oficial2.Oficial_SAC__c = userinfo.getUserId();
        oficial2.Codigo_Asesor__c = usuario.Usuario__c;
        oficial2.Asesor__c = userinfo.getUserId();
        insert oficial2;
        
         List<Reporte_calidad__C> vv = new List<Reporte_calidad__C>();
         for(Integer i=0; i<2058; i++){
             Reporte_calidad__C afiliacion = new Reporte_calidad__C();
             afiliacion.Identificacion__c = '123'+'B'+i;
             afiliacion.Espediente_Completo__c = 'S';
             afiliacion.Name = 'Test';
             afiliacion.Estado__c = 'A';
             afiliacion.tipo_afiliacion__C ='C';
             afiliacion.Aplica_CS__c = 'S';
             afiliacion.tipo_fondo__C = 'M';
             afiliacion.Empresa__c = empresa.id;
             afiliacion.Codigo_Oficial_SAC__c = usuario.Usuario__c;
             vv.add(afiliacion);
         }
         insert vv;
        
        
         ApexPages.currentPage().getParameters().put('hytrd',usuario.Usuario__c);
         controladorBandejaOperaciones controlador= new controladorBandejaOperaciones();
         controlador.filtros();
         controlador.siguiente();
         controlador.anterior();
         controlador.listReporte[0].aprobado__C = true;
         controlador.idAfiliacion = controlador.listReporte[0].id;
         controlador.selectAprobar();
         
         controlador.popGuardar();
         controlador.guardar();
         
         //controlador.listReporte[0].Numero_Cuenta__c = '323223';
         //controlador.guardar();
         
         
         Reporte_calidad__C afiliacion = new Reporte_calidad__C();
         afiliacion.Identificacion__c = '123232';
         afiliacion.Espediente_Completo__c = 'S';
         afiliacion.Name = 'Test';
         afiliacion.Estado__c = 'A'; 
         afiliacion.tipo_afiliacion__C ='M';
         afiliacion.Codigo_Oficial_SAC__c = usuario.Usuario__c;
         insert afiliacion;
         controlador.filtroAfilicion = 'M';
         controlador.filtros();
         
         controlador.listReporte = new List<Reporte_Calidad__c>();
         controlador.listReporte.add(afiliacion);
             
             
         controlador.listReporte[0].rechazado__C = true;
         controlador.idAfiliacion = controlador.listReporte[0].id;
         controlador.selectRechazar();
         //controlador.guardar();
         controlador.popGuardar();
         
         controlador.descargarArchivo();
         controlador.afiliar();
         controlador.exportarExcel();
         controlador.filtroZona='';
         controlador.filtroTipoCarga = '';
         controlador.perfil = 'cds';
        
        
    }
    
    

}