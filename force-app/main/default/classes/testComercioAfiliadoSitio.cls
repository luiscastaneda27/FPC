@isTest(SeeAllData=true)
public class testComercioAfiliadoSitio{
    
    static testMethod void clasesPortal(){
        Comercio_Afiliado__c comercio = new Comercio_Afiliado__c(Name = 'ComercioTest', Activo__c = false);
        insert comercio;
        
        Usuario_de_Portal__c usuario = new Usuario_de_Portal__c(
                    Name = 'Juan', Contrase_a__c = 'Nada123', Comercio_Afiliado__c = comercio.id,
                    Apellido__c = 'Hernandez');
        insert usuario;
               
        Descuento__c descuento = new Descuento__c(Activo__c = true, Comercio_Afiliado__c = comercio.id,
                                    Porcentaje_descuento__c = 5);
               
        Account cliente = new Account(lastName = 'Cliente-1', Identificacion__c = '03030101',
                        recordTypeId = [Select id From recordType Where sObjectType = 'Account' AND DeveloperName = 'Natural'].Id);
                      
        
        /*list<configTransacciones__c> listConfig = new list<configTransacciones__c>(); 
        listConfig.add(new configTransacciones__c(Name = 'Cliente', Nombre_API_Campo__c = 'Cliente__c',
                        Orden__c = 1, Es_Obligatorio__c = true, Es_texto__c = true));
        
        listConfig.add(new configTransacciones__c(Name = 'Monto', Nombre_API_Campo__c = 'Monto__c',
                        Orden__c = 2, Es_Obligatorio__c = true, Es_Numerico__c = true));
                                        
        listConfig.add(new configTransacciones__c(Name = 'Fecha y hora de la Transacción', Nombre_API_Campo__c = 'Fecha_hora_Transaccion__c',
                        Orden__c = 3, Es_Obligatorio__c = true, Es_Fecha_Hora__c = true));
        insert listConfig;*/
                               
        string csvTest = ''; 
                    
        test.startTest();        	
            insert descuento;
            insert cliente;
            
            controllerLoginComerio control = new controllerLoginComerio();
            control.sesionIniciada();
            control.usuario = 'jhernandez';
            control.sesionIniciada();
            control.Contrasena = 'Nada123';
            control.sesionIniciada();
            
            comercio.Activo__c = true;
            update comercio;
            control.sesionIniciada();
            
            ApexPages.currentPage().getParameters().put('IdComercio', comercio.id);
            controlTransacciones control2 = new controlTransacciones();
            control2.buscarAfiliado();
            control2.numeroAfiliado = '03030101';
            control2.buscarAfiliado();
            control2.cerrar();
            control2.guardar();
            
            controlTransaccionesMasivas.classWRetorno respuesta = controlTransaccionesMasivas.processFile(csvTest, comercio.id, descuento.id, usuario.id);
            
            
            csvTest = '"Cliente","Monto de Venta Lps","Fecha y hora de la Transacción"\n'; 
            respuesta = controlTransaccionesMasivas.processFile(csvTest, comercio.id, descuento.id, usuario.id);
            
            csvTest = '"Cliente","Monto de Venta Lps","Fecha y hora de la Transacción","Nada"\n'; 
            respuesta = controlTransaccionesMasivas.processFile(csvTest, comercio.id, descuento.id, usuario.id);
            
            csvTest = '"Cliente","Monto de Venta Lps","Fecha y hora de la Transacción"\n"03030101",500,"14/10/2011-11:46"'; 
            respuesta = controlTransaccionesMasivas.processFile(csvTest, comercio.id, descuento.id, usuario.id);
            
            csvTest = '"Cliente","Monto de Venta Lps","Fecha y hora de la Transacción"\n"00000050",500,"14/10/2011-11:46"'; 
            respuesta = controlTransaccionesMasivas.processFile(csvTest, comercio.id, descuento.id, usuario.id);
            
            csvTest = '"Cliente","Monto de Venta Lps","Fecha y hora de la Transacción"\n"03030101",500,"14/10/2011-11:46"'; 
            respuesta = controlTransaccionesMasivas.processFile(csvTest, null, null, null);
            
            controlorMenuTransacciones control3 = new controlorMenuTransacciones();
            control3.transaccion();
            control3.transaccionMasiva();
            control3.tabActiva();
            control3.cerrar();
            
            DateTime xResul = claseUtil.convertToDateTime('14/10/2011-11:46');
        test.stopTest();
    }
}