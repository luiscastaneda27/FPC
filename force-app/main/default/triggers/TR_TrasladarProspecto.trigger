//Creado por: David Luarca
//Fecha: 18/04/2018
//Descripcion: Traslada hacia el objeto Preventa todos los registros ingresados en Prospectos

trigger TR_TrasladarProspecto on Lead (after insert) {
    
    for (Lead sc: System.Trigger.new) {
        
        //if (sc.LeadSource == 'Web')
        //{
            
            Preventa__c obj = new PreVenta__c (
                
                Referido_por__c = sc.Referido_por__c,
                Description__c = sc.Description,
                Correo_de_Empleado_Ficohsa__c = sc.Correo_Empleado_Ficohsa__c,
                Canal_que_Refiere__c = sc.Canal_que_Refiere__c,
                Cliente_Localizable__c = sc.Cliente_Localizable__c,
                CurrencyIsoCode = sc.CurrencyIsoCode,
                Departamento__c = sc.Departamento__c,
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
                RecordTypeid = [Select id From RecordType Where DeveloperName ='Natural' and SObjectType = 'PreVenta__c'].id //Verificar el tipo ************
            );  
            
            insert obj;
            
     //   }   
        
    }
    
    
}