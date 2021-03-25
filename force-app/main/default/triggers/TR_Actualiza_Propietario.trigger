trigger TR_Actualiza_Propietario on PreVenta__c (before insert, before update) {
    for (Preventa__c sc: System.Trigger.new) {
        
        id strid;  // '005j000000CD3gM';
        
        if (sc.LeadSource__c != 'Web')
        { 

		    if (sc.Asesor__c != null && sc.Asesor__c != '')
            {    
                strid = sc.Asesor__c;
                sc.OwnerId = [select id from user where id =: strid ].id;
                sc.name = sc.LastName__c  + ', ' + sc.FirstName__c;
    		}
            
            if (sc.Asesor__c != null && sc.Asesor__c != '')
            {    
                strid = sc.Asesor__c;
                sc.Asesor__c = '';
    		}
        
        }    
        
    }
    
}