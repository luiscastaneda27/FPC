@isTest(SeeAllData=true)
private class testComercioAfiliadoSitio2 {
    @isTest static void testMet(){
                         	
    	test.startTest();
	    	
	        Comercio_Afiliado__c comercio = new Comercio_Afiliado__c(Name = 'ComercioTest', Activo__c = false);
        	insert comercio;
        
	        Usuario_de_Portal__c usuario = new Usuario_de_Portal__c(
	                    Name = 'Test', Contrase_a__c = 'Nada1234', Comercio_Afiliado__c = comercio.id,
	                    Apellido__c = 'Prueba');
	        insert usuario;
	        
	        Usuario_de_Portal__c usuario2 = new Usuario_de_Portal__c(
	                    Name = 'Test2', Contrase_a__c = 'Nada12343', Comercio_Afiliado__c = comercio.id,
	                    Apellido__c = 'Prueba2');
	        insert usuario2;
	               
	        Descuento__c descuento = new Descuento__c(Activo__c = true, Comercio_Afiliado__c = comercio.id,
	                                    Porcentaje_descuento__c = 5);
	        insert descuento;               	        
            
            Descuento__c descuento2 = new Descuento__c(Activo__c = False, Comercio_Afiliado__c = comercio.id,
	                                    Porcentaje_descuento__c = 5);
	        insert descuento2; 
	        
            descuento.Porcentaje_descuento__c = 5;
            UPDATE descuento;
            
            usuario.Apellido__c = 'lopez';
            update usuario;
            
    	test.stopTest();	
    }
    
}