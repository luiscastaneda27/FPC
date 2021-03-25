@istest
public class testControladorReporteSeguienteSac {
    
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
       
        List<Reporte_calidad__C>  Listreporte = new List<Reporte_calidad__C>();
        for(Integer i = 0; i< 1903; i++){
            Reporte_calidad__C afiliacion = new Reporte_calidad__C();
            afiliacion.Identificacion__c = '123'+i;
            afiliacion.Espediente_Completo__c = 'S';
            afiliacion.Name = 'Test';
            afiliacion.Estado__c = 'C';
            afiliacion.Codigo_Oficial_SAC__c = usuario.Usuario__c;
            Listreporte.add(afiliacion);
        }
        insert Listreporte;
        
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
        
        
        
        ApexPages.currentPage().getParameters().put('usuario',usuario.Usuario__c);
        controladorReporteSeguienteSac controlador= new controladorReporteSeguienteSac();
        controlador.filtros();
        controlador.siguiente();
        controlador.anterior();
        controlador.popEmpresas();
        controlador.cerrar();
        controlador.filtroZona = 'S';
        
        controlador.listTipoCarga[0].seleccionado = true;
        controlador.listOficialSac[0].seleccionado = true;
        controlador.listEmpresasN[0].seleccionado = true;
        controlador.listAsesoresN[0].seleccionado = true;
        controlador.filtroReporte = '3';
        controlador.filtros();
        controlador.filtroReporte = '4';
        controlador.filtros();
        
        controlador.exportarExcel();
        controlador.filtroEmpresa = 'Prueba';
        controlador.buscarEmpresa();
        controlador.filtroTipoCarga = 'ew';
        controlador.filtroAsesor = '21';
        controlador.filtroOficial = 'q';
        
        ApexPages.currentPage().getParameters().put('where', ' Estado__c = null');
        ApexPages.currentPage().getParameters().put('usuario', usuario.Usuario__c);
        ApexPages.currentPage().getParameters().put('pagActual', '1');
        new  ControladorExportarExcelReporCAlidSAC();
        
        ApexPages.currentPage().getParameters().put('where', null);
        ApexPages.currentPage().getParameters().put('usuario', usuario.Usuario__c);
        ApexPages.currentPage().getParameters().put('pagActual', '1');
        new  ControladorExportarExcelReporCAlidSAC();
        
        
        
        
        
        
    }
    
    
    
    
    
}