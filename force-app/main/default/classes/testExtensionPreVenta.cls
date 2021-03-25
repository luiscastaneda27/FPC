@isTest
public class testExtensionPreVenta{
    
    static testMethod void metodo1(){
        test.startTest();
        
        PreVenta__c preventa  = new PreVenta__c();
        preventa.recordTypeId = [Select Id From RecordType 
                                 Where developerName = 'Natural' AND sObjectType = 'PreVenta__c'].id;
        preventa.firstname__c = 'David 1';
        preventa.lastname__c = 'Luarca 1';
        preventa.Name = 'David Luarca 1';
        
        insert preventa;
        
        PreVenta__c preventa2  = new PreVenta__c();
        preventa2.recordTypeId = [Select Id From RecordType 
                                  Where developerName = 'Natural' AND sObjectType = 'PreVenta__c'].id;
        preventa2.firstname__c = 'David 2';
        preventa2.lastname__c = 'Luarca 2';
        preventa.Name = 'David Luarca 2';
        insert preventa2;
        
        PreVenta__c preventa3  = new PreVenta__c();
        preventa3.recordTypeId = [Select Id From RecordType 
                                  Where developerName = 'Juridico' AND sObjectType = 'PreVenta__c'].id;
        
        preventa3.Name = 'David Luarca 2';
        preventa3.Company__c = 'David Luarca 2';
        insert preventa3;
        
        Task T = new Task();
        T.Subject = 'Subject';
        T.ActivityDate =  date.today();            
        T.WhatId = preventa.id;
        T.Description = 'Prueba';
        T.Status = 'Completado';
        insert T;
        
        Task T2 = new Task();
        T2.Subject = 'Subject 2';
        T2.ActivityDate =  date.today();            
        T2.WhatId = preventa2.id;
        T2.Description = 'Prueba 2';
        T2.Status = 'Completado';
        insert T2;
        
        Event E = new Event();
        E.Subject = 'Subject';
        E.Asunto__c = 'Paola';
        E.Description = 'prueba Paola';
        E.Usuario_referencia__c = 'Paola';
        E.StartDateTime = date.today();  
		E.EndDateTime = date.today();  
        E.Location = 'FPC';
        E.WhatId = preventa.id;
        insert E;
        
        Event E2 = new Event();
        E2.Subject = 'Subject';
        E2.Asunto__c = 'Paola';
        E2.Description = 'prueba Paola';
        E2.Usuario_referencia__c = 'Paola';
        E2.StartDateTime = date.today();  
		E2.EndDateTime = date.today();  
        E2.Location = 'FPC';
        E2.WhatId = preventa2.id;
        insert E2;
        
        Account acc1  = new Account();
        acc1.Name = 'David Luarca';
        acc1.Nombre_Comercial__C = 'David Luarca';
        insert acc1;
        
        Account acc2  = new Account();
        acc2.Name = 'Prueba 2';
        acc2.Nombre_Comercial__C = 'Prueba 2';
        insert acc2;
        
        
        ApexPages.currentPage().getParameters().put('Id',preventa.id);
        extensionPreVenta nuevo = new extensionPreVenta(new ApexPages.StandardController(preventa)); 
        nuevo.setclientes(preventa.id);
        nuevo.convert();
        nuevo.getclientes();
        nuevo.getItems();
        //nuevo.getItemsDos();
        nuevo.natural = true;
        
        extensionPreVenta nuevo2 = new extensionPreVenta(new ApexPages.StandardController(preventa3)); 
        nuevo2.setclientes(preventa3.id);
        //nuevo2.convert();
        nuevo2.getclientes();
        nuevo2.getItemsDos();
        nuevo2.natural = false;
        
        list<preventa__c> gtb = new list<preventa__c>();
        
        list<SelectOption> gta = new list<SelectOption>();
        
        list<Account> gtc = new list<Account>();
        Account obj = new Account ();
        obj.Activo__c = true;
        obj.Cliente_Localizable__pc = true;
        obj.CurrencyIsoCode = '';
        obj.Departamento__c = '';
        obj.PersonEmail = '';
        obj.AccountSource = '';
        obj.Tipo_Identificacion__c = '';
        obj.Identificacion__c = '0801199411013';
        obj.Nombre_empresa__c = 'empresa 1';
        obj.Telefono_Empresa__c ='88612510';
        obj.Celular__c = '88612510';
        obj.FirstName = 'Paola';
        obj.LastName = 'Alvarado';

        test.stopTest();
    }
    
}