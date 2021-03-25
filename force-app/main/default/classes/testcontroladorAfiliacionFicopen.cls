@istest
public class testcontroladorAfiliacionFicopen {

    static testMethod void controladorAfiliacionFicopen(){
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
        insert empresa;
        
        cuentas__C cuenta = new cuentas__C ();
        cuenta.Cliente__c = empresa.id;
        cuenta.Activo__c = true;
        cuenta.Producto__c = producto.Id;
        cuenta.Subproducto__c = subP.Id;
        cuenta.Codigo__c = '12345';
        insert cuenta;
        
        ApexPages.currentPage().getParameters().put('usuario',usuario.Usuario__c);
        controladorAfiliacionFicopen controlador= new controladorAfiliacionFicopen();
        
        controlador.guardar();
        
        controlador.buscarEmpresa = 'Em54presa';
        controlador.BuscarEmpresa();
        controlador.buscarEmpresa = 'Empresa';
        controlador.BuscarEmpresa();
        
        controlador.Afiliacion.name = 'PN';
        controlador.Afiliacion.primer_apellido__C = 'PA';
        controlador.Afiliacion.Tipo_Identificacion__c='1';
        controlador.Afiliacion.Identificacion__c = '12345445';
        controlador.ValidacionIdentidad();
        controlador.afiliacion.empresa__c = empresa.id;
        controlador.selectEmpresa();
        controlador.Afiliacion.Tiene_Id__c = 'S';
        controlador.Afiliacion.RTN__c = 'N';
        controlador.Afiliacion.FATCA__c = 'N';
        controlador.Afiliacion.WAIVER__c = 'N';
        controlador.Afiliacion.PEP__c = 'N';
        controlador.Afiliacion.Procedencia__c = 'N';
        controlador.Afiliacion.Addendum__c = 'N';
        controlador.Afiliacion.Tipo_Fondo__c = 'M';
        //controlador.Afiliacion.Formulario_Completo__c = 'S';
        controlador.Afiliacion.espediente_completo__C = 'S';
        controlador.guardar();
        controlador.Afiliacion.Formulario_Completo__c = 'S';
        controlador.guardar();
        controlador.idAfiliacion = controlador.listAfiliaciones[0].id;
        controlador.editar();
        controlador.cerrar();
        controlador.idAfiliacion = controlador.listAfiliaciones[0].id;
        controlador.SelectPopEliminar();
        controlador.EliminarAfiliacion();
        
        
        controlador.buscarEmpresa = 'Empresa';
        controlador.BuscarEmpresa();
        
        controlador.Afiliacion.name = 'PN';
        controlador.Afiliacion.primer_apellido__C = 'PA';
        controlador.Afiliacion.Tipo_Identificacion__c='1';
        controlador.Afiliacion.Identificacion__c = '12345445';
        controlador.ValidacionIdentidad();
        controlador.afiliacion.empresa__c = empresa.id;
        controlador.selectEmpresa();
        controlador.Afiliacion.Tiene_Id__c = 'S';
        controlador.Afiliacion.RTN__c = 'N';
        controlador.Afiliacion.FATCA__c = 'N';
        controlador.Afiliacion.WAIVER__c = 'N';
        controlador.Afiliacion.PEP__c = 'N';
        controlador.Afiliacion.Procedencia__c = 'N';
        controlador.Afiliacion.Addendum__c = 'N';
        controlador.Afiliacion.Tipo_Fondo__c = 'M';
        controlador.Afiliacion.Formulario_Completo__c = 'S';
        controlador.Afiliacion.espediente_completo__C = 'S';
        controlador.guardar();
        
        controlador.listAfiliaciones[0].enviar_sac__c = true;
        controlador.haySeleccionado();
        controlador.Enviar();
        controlador.accionVacia();
       
        
            
        
        
        
        
    }
    
    
}