trigger verificarActivo on Descuento__c (before insert, before update) {
    
    try{
        Descuento__c descuento = trigger.new[0];
        
        Integer cantidadActivo = [Select count() 
                                    From Descuento__c 
                                    Where Comercio_Afiliado__c =: descuento.Comercio_Afiliado__c 
                                    AND Activo__c = true AND Id !=: descuento.id];
                                    
        if(cantidadActivo != 0 && descuento.Activo__c){
            descuento.addError('Ya existe un descuento activo para este comercio afiliado');
        }else{
            if(descuento.Activo__c){
                descuento.Activo__c = true;
            }else{
                descuento.Activo__c = false;
            }
        }
    }Catch(Exception e){
    	system.debug(e.getMessage());
    }
}