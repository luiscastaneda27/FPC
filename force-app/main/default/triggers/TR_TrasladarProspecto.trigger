//Creado por: David Luarca
//Fecha: 18/04/2018
//Descripcion: Traslada hacia el objeto Preventa todos los registros ingresados en Prospectos

trigger TR_TrasladarProspecto on Lead (after insert) {
    String idRecordType = Schema.SObjectType.PreVenta__c.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
    List<PreVenta__c> listPV = new list<PreVenta__c>();
    for (Lead sc: System.Trigger.new) {
        if(ControllerPromociones3.validarPreventaExistente(sc.FirstName, sc.LastName, sc.Phone)){
            continue;
        }
        listPV.add(new PreVenta__c (
            OwnerId =  sc.OwnerId,
            Referido_por__c = sc.Referido_por__c,
            Description__c = sc.Description,
            Correo_de_Empleado_Ficohsa__c = sc.Correo_Empleado_Ficohsa__c,
            Canal_que_Refiere__c = sc.Canal_que_Refiere__c,
            Cliente_Localizable__c = sc.Cliente_Localizable__c,
            CurrencyIsoCode = sc.CurrencyIsoCode,
            Departamento__c = sc.Departamento__c,
            Pais_Residencia__c = sc.Pais_Residencia__c,
            Identificacion__c = sc.Identificacion__c,                               
            Email__c = sc.Email,
            LeadSource__c = sc.LeadSource,
            Name = sc.Name,
            Motivo_Contacto__c = sc.Motivo_Contacto__c,
            Nombre_Empresa__c = sc.Nombre_Empresa__c,
            Phone__c = sc.Phone,
            Status__c = sc.Status,
            Trabaja__c = sc.Trabaja__c,
            FirstName__c = sc.FirstName,
            LastName__c = sc.LastName,
            Agencia_Refiere__c = sc.Agencia_Refiere__c,
            RecordTypeid = idRecordType //Verificar el tipo ************
        ));  
    }
    insert listPV;
}