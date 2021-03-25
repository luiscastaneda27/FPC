@isTest(SeeAllData=true)
public class testComercioAfiliadoSitio3{
    
    static testMethod void clasesPortal(){
        Comercio_Afiliado__c comercio = new Comercio_Afiliado__c(Name = 'ComercioTest', Activo__c = false);
        insert comercio;
        
        Usuario_de_Portal__c usuario = new Usuario_de_Portal__c(Usuario__c = 'jhernandez',
                    Name = 'Juan', Contrase_a__c = 'Nada123', Comercio_Afiliado__c = comercio.id,
                    Apellido__c = 'Hernandez');
        insert usuario;
               
        Descuento__c descuento = new Descuento__c(Activo__c = true, Comercio_Afiliado__c = comercio.id,
                                    Porcentaje_descuento__c = 5);
               
        Account cliente = new Account(lastName = 'Cliente-1', Identificacion__c = '03030101',
                        recordTypeId = [Select id From recordType Where sObjectType = 'Account' AND DeveloperName = 'Natural'].Id);
                               
        string csvTest = ''; 
                    
        test.startTest();        	
            insert descuento;
            insert cliente;
            
            controllerLoginComerio2 control = new controllerLoginComerio2();
            control.sesionIniciada();
            control.usuario = 'jhernandez';
            control.sesionIniciada();
            control.Contrasena = 'Nada123';
            control.sesionIniciada();
            
            comercio.Activo__c = true;
            update comercio;
            control.sesionIniciada();
            
            control.transaccion();
            control.transaccionMasiva();
            control.tabActiva();
            control.cerrar();
            
            DateTime xResul = claseUtil.convertToDateTime('14/10/2011-11:46');
        test.stopTest();
    }
}