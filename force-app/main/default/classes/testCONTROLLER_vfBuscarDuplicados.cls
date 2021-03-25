@isTest
public class testCONTROLLER_vfBuscarDuplicados {

    
     static testMethod void testCONTROLLER_vfBuscarDuplicados() {
        test.startTest();
        PreVenta__c preventa  = new PreVenta__c();
        preventa.recordTypeId = [Select Id From RecordType 
                                 Where developerName = 'Natural' AND sObjectType = 'PreVenta__c'].id;
        preventa.firstname__c = 'David 1';
        preventa.nombre_empresa__c = 'David 1'; 
        preventa.lastname__c = 'Luarca 1';
        preventa.Name = 'David Luarca 1';
        preventa.email__c = 'dluarca@sbfcorp.com'; 
        preventa.phone__c  = '50241415454';  
         
        
        insert preventa;
        
        PreVenta__c preventa2  = new PreVenta__c();
        preventa2.recordTypeId = [Select Id From RecordType 
                                  Where developerName = 'Natural' AND sObjectType = 'PreVenta__c'].id;
        preventa2.firstname__c = 'David 2';
        preventa2.nombre_empresa__c = 'David 2';
        preventa2.lastname__c = 'Luarca 2';
        preventa.Name = 'David Luarca 2';
        preventa.Nombre_Comercial__c = 'Paola Alvarado';
       
        insert preventa2; 
         
        CONTROLLER_vfBuscarDuplicados buscarduplicados = new  CONTROLLER_vfBuscarDuplicados(new ApexPages.StandardController(preventa)); 
        
        buscarduplicados.preventa =  preventa;
        
        buscarduplicados.strfirstname = 'DAVID'; 
        buscarduplicados.strlastname = 'LUARCA'; 
        buscarduplicados.strempresa = 'LUARCA'; 
        buscarduplicados.stremail =  'DAVID'; 
        buscarduplicados.strmovil  = 'DAVID'; 
        
        
        buscarduplicados.boolfirstname = true; 
        buscarduplicados.boollastname = true;
        buscarduplicados.boolempresa = true; 
        buscarduplicados.boolemail = true;
        buscarduplicados.boolmovil = true; 
        
        buscarduplicados.count= 0 ; 
        buscarduplicados.combinar =true;  
        
       
         
        buscarduplicados.setcparam0(''); 
        buscarduplicados.setcparam1('David'); 
        buscarduplicados.setcparam2('David ');
        buscarduplicados.setcparam3('Dluarca@sbfcorp.com');  
        buscarduplicados.setcparam4('PASAPORTE');
        buscarduplicados.setcparam5('David ');  
        buscarduplicados.setcparam6('David ');  
        //buscarduplicados.setcparam7('');  
        buscarduplicados.setcparam8('David ');  
        buscarduplicados.setcparam9('David ');
        buscarduplicados.setcparam10('David ');  
        buscarduplicados.setcparam11('David ');  
        buscarduplicados.setcparam12('David '); 
        buscarduplicados.setcparam13('David '); 
        buscarduplicados.setcparam14('David '); 
        buscarduplicados.setcparam15('2'); 
        buscarduplicados.setcparam16('David '); 
        buscarduplicados.setcparam17('David '); 
        buscarduplicados.setcparam18('David '); 
        buscarduplicados.setcparam19('Paola '); 
         
        //string strid =  buscarduplicados; 
        buscarduplicados.getitems1();
        buscarduplicados.getitems2();
        buscarduplicados.getitems3();
        buscarduplicados.getitems4();
        buscarduplicados.getitems5();
        buscarduplicados.getitems6();
        buscarduplicados.getitems7();
        buscarduplicados.getitems8();
        buscarduplicados.getitems9(); 
        buscarduplicados.getitems10();
        buscarduplicados.getitems12();
        buscarduplicados.getitems13();
        buscarduplicados.getitems14();
        buscarduplicados.getitems15();
        buscarduplicados.getitems16();
        buscarduplicados.getitems17();
        buscarduplicados.getitems18(); 
 
 		buscarduplicados.getCparam0();
        buscarduplicados.getCparam1();
        buscarduplicados.getCparam2();
        buscarduplicados.getCparam3();
        buscarduplicados.getCparam4();
        buscarduplicados.getCparam5();
        buscarduplicados.getCparam6(); 
        buscarduplicados.getCparam7();
        buscarduplicados.getCparam8();
        buscarduplicados.getCparam9();
        buscarduplicados.getCparam10();
        buscarduplicados.getCparam11(); 
        buscarduplicados.getCparam12();
        buscarduplicados.getCparam13(); 
        buscarduplicados.getCparam14();
        buscarduplicados.getCparam15();
        buscarduplicados.getCparam16(); 
        buscarduplicados.getCparam17();
        buscarduplicados.getCparam18(); 
        buscarduplicados.getCparam19(); 
         
        //buscarduplicados.combine(); 
        //buscarduplicados.buscar();  
         
        buscarduplicados.save();
        //buscarduplicados.Buscar();

        CONTROLLER_vfBuscarDuplicados bd = new  CONTROLLER_vfBuscarDuplicados(new ApexPages.StandardController(preventa)); 
        
         Task T = new Task();
                //T.Type = acctT.Type;
                T.Subject = 'prueba';
               // T.ActivityDate = today; 
                //T.WhatId = idcombsi;
                T.Description = 'acctT.Description';
                T.Status = 'acctT.Status';
                T.Origen__c = 'acctT.Origen__c';
                T.Usuario_referencia__c = 'acctT.Usuario_referencia__c';
                T.Motivo_Contacto__c = 'acctT.Motivo_Contacto__c';
                T.Tipo_Gestion__c =' acctT.Tipo_Gestion__c';
                //T.RecurrenceDayOfMonth  = 'acctT.RecurrenceDayOfMonth';
                //T.RecurrenceDayOfWeekMask  = 'acctT.RecurrenceDayOfWeekMask';
                //T.RecurrenceEndDateOnly = 'acctT.RecurrenceEndDateOnly';
              //  T.RecurrenceInstance = 'acctT.RecurrenceInstance';
               // T.RecurrenceInterval = 'acctT.RecurrenceInterval';
               // T.RecurrenceMonthOfYear = 'acctT.RecurrenceMonthOfYear';
               // T.RecurrenceRegeneratedType = 'acctT.RecurrenceRegeneratedType';
                //T.RecurrenceStartDateOnly = 'acctT.RecurrenceStartDateOnly';
               // T.RecurrenceTimeZoneSidKey = 'acctT.RecurrenceTimeZoneSidKey';
              //  T.RecurrenceType = 'acctT.RecurrenceType';
               // T.ReminderDateTime = 'acctT.ReminderDateTime';
                T.Priority = 'acctT.Priority';
               // T.IsRecurrence= 'acctT.IsRecurrence';
                //T.IsReminderSet= 'acctT.IsReminderSet';
         
         insert t;
         bd.combine();
         
       
         
        test.stopTest(); 
         
     }
    
    
}