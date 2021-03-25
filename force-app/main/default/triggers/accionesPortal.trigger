trigger accionesPortal on Fantasma_portal__c (after insert) {
    List<task> llamada = new list<task>();
    List<sObject> actualizar = new list<sObject>();
    
    For(Fantasma_portal__c item : trigger.new){
        task nuevallamada = new task();
        nuevaLlamada.Subject = 'Llamada';
        nuevaLlamada.ActivityDate = date.today() + 1;
        nuevaLlamada.Status = 'No Iniciado';
        nuevaLlamada.Description = item.Descripcion__c;
        nuevaLlamada.Motivo_Contacto__c = item.Motivo_Contacto2__c;
        nuevaLlamada.origen__c = item.origen__c;
        nuevaLlamada.usuario_referencia__c = item.usuario_referencia__c;
        nuevaLLamada.Tipo_Gestion__c = item.Tipo_Gestion__c;
        nuevaLlamada.OwnerId = item.Asignado_A__c;
        
        id idObjeto = item.id_actualizar__c;
        sObject nuevoObjeto = idObjeto.getSObjectType().newSObject(item.id_actualizar__c);
        
        if(item.Name == 'cliente'){
            NuevaLlamada.whatId = item.id_actualizar__c;
            nuevoObjeto.put('Correo_actual__c', item.Correo_electronico__c);
        }else{
            NuevaLlamada.Whoid = item.id_actualizar__c;
            nuevoObjeto.put('email', item.Correo_electronico__c);
            nuevoObjeto.put('Motivo_Contacto__c', item.Motivo_Contacto2__c);
        }
        nuevoObjeto.put('Telefono_actual__c', item.Telefono_actual__c);
        llamada.add(nuevaLlamada);  
        actualizar.add(nuevoObjeto);             
    }        
    insert llamada;
    update actualizar;
}