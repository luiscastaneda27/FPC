@isTest
public class testPromociones3 
{
   static testMethod void ControllerPromociones3()
   {
      Account aa = new Account(Identificacion__c='0122199012345',Name='carlo');
        insert aa;
        
        Account ba = new Account(Identificacion__c='123',Name='adasd', Cliente_Unico_Banco__C='1896'  );
        insert ba;        
      
        test.startTest();
        ControllerPromociones3 pro =  new ControllerPromociones3();
        
        pro.candidato = new Lead();
        
		//pro.candidato = new task();
        pro.pcDeptoCN = 'depto';
        pro.candidato.FirstName = 'carlo';
        pro.candidato.LastName = 'escoto';
        pro.candidato.Identificacion__c='0801185687456';
        pro.guardarPop();
       
        pro.candidato.FirstName = 'carlos';
        pro.candidato.LastName = 'escotos';
        pro.candidato.Identificacion__c=null;
        pro.guardarPop();
        
        pro.candidato.Phone = '886125101465';
        pro.candidato.Telefono_Trabajo__c = '227524005454';
        pro.candidato.Departamento__c = '--Ninguno--';
		pro.guardarPop();
       //pro.preven = [select id from Account where Identificacion__c ='0122199012345'];
       
        pro.candidato.Phone = '88612510';
        pro.candidato.Telefono_Trabajo__c = '2275240044644';
        pro.candidato.Identificacion__c = null;
        pro.guardarPop();

        pro.candidato.Phone = '88612510';
        pro.candidato.Telefono_Trabajo__c = '22752400';
        pro.candidato.Identificacion__c = null;
        pro.guardarPop();
        pro.candidato.Identificacion__c = '0801199411013';
        pro.candidato.Identificacion__c = '';
        pro.candidato.Motivo_Contacto__c = 'BONO SEPT GFF';
        //prospecto.RecordTypeId = '';
        pro.candidato.Status = 'En Proceso';
        pro.candidato.LeadSource = 'Web';
        pro.candidato.RecordTypeid = [Select id From RecordType Where DeveloperName ='Natural' and SObjectType = 'Lead'].id; 
        pro.guardarPop();
        
       
        pro.candidato.Departamento__c = 'Francisco Morazan';
        
      
        
        pro.candidato.Identificacion__c = '0122199012345';
        pro.Activi=new task();  
       // pro.preven='1';
        pro.activi.OwnerId = '005j000000BiDwQ';
        pro.activi.Subject= 'PROMOCIONES';
        pro.activi.Status= 'No Iniciado';
        pro.activi.Priority='Normal';
          insert pro.Activi;
        pro.guardarPop();
         
        pro.candidato.Identificacion__c = '0501199012478';
        
       
        pro.Actividad=new task();
        //pro.prev=select id from PreVenta__c where Identificacion__c = '0501199012478' ];
        pro.Actividad.OwnerId = '005j000000BiDwQ';
        pro.Actividad.Subject= 'PROMOCIONES';
        pro.Actividad.Status= 'No Iniciado';
        pro.Actividad.Priority='Normal'; 
        insert pro.Actividad;
        //pro.Actividad.WhatId = '0501199012478';
        
   		pro.candidato.Telefono_Trabajo__c = '227524005454';   
        pro.guardarPop();
        
        pro.pop3= true;
        list<Lead> lista = new list<Lead>();

        //pro.guardarPop();
        pro.reiniciar();
        pro.guardarPop();
        
        test.stopTest();
        
   
    }
   
   static testMethod void ControllerPromociones33()
   {
        PreVenta__c aa = new PreVenta__c(Identificacion__c='0122199012345',Name='carlo');
        insert aa;
        
        PreVenta__c ba = new PreVenta__c(Identificacion__c='123',Name='adasd', Cliente_Unico_Banco__C='1896'  );
        insert ba;        
      
        test.startTest();
        ControllerPromociones3 pro =  new ControllerPromociones3();
        
        pro.candidato = new Lead();
        
		//pro.candidato = new task();
        
        pro.candidato.FirstName = 'carlo';
        pro.candidato.LastName = 'escoto';
        pro.candidato.Identificacion__c='0801185687456';
      
        pro.guardarPop();
        
        pro.candidato.Phone = '886125101465';
        pro.candidato.Telefono_Trabajo__c = '227524005454';
        pro.candidato.Departamento__c = 'N/A';
		
       //pro.preven = [select id from Account where Identificacion__c ='0122199012345'];
       
        

        pro.candidato.Phone = '88612510';
        pro.candidato.Telefono_Trabajo__c = '22752400';
        pro.candidato.Identificacion__c = null;
        pro.guardarPop();
        pro.candidato.Identificacion__c = '0801199411013';
        pro.candidato.Identificacion__c = '';
        pro.candidato.Motivo_Contacto__c = 'BONO SEPT GFF';
        //prospecto.RecordTypeId = '';
        pro.candidato.Status = 'En Proceso';
        pro.candidato.LeadSource = 'Web';
        pro.candidato.RecordTypeid = [Select id From RecordType Where DeveloperName ='Natural' and SObjectType = 'Lead'].id; 
        pro.guardarPop();
        
       
        pro.candidato.Departamento__c = 'Francisco Morazan';
        
      
        
        pro.candidato.Identificacion__c = '0122199012345';
        pro.Activi=new task();
       // pro.preven='1';
        pro.activi.OwnerId = '005j000000BiDwQ';
        pro.activi.Subject= 'PROMOCIONES';
        pro.activi.Status= 'No Iniciado';
        pro.activi.Priority='Normal';
          insert pro.Activi;
        pro.guardarPop();
         
        pro.candidato.Identificacion__c = '0501199012478';
        
       
        pro.Actividad=new task();
        //pro.prev=select id from PreVenta__c where Identificacion__c = '0501199012478' ];
        pro.Actividad.OwnerId = '005j000000BiDwQ';
        pro.Actividad.Subject= 'PROMOCIONES';
        pro.Actividad.Status= 'No Iniciado';
        pro.Actividad.Priority='Normal'; 
        insert pro.Actividad;
        //pro.Actividad.WhatId = '0501199012478';
        
   		pro.candidato.Telefono_Trabajo__c = '227524005454';   
        pro.guardarPop();
        
        pro.pop3= true;
        list<Lead> lista = new list<Lead>();

        //pro.guardarPop();
        pro.reiniciar();
        pro.guardarPop();
        
        test.stopTest();
        
   
    }
   
    
}