@isTest
public class testPromociones3x {
	static testMethod void ControllerPromociones3()
    {
        Account aa = new Account(Identificacion__c='0801199717795',Name='carlo');
        insert aa;
        
        Account ba = new Account(Identificacion__c='123',Name='adasd', Cliente_Unico_Banco__C='1896'  ); 
        insert ba;  
                
        Pais_R__c archivo = new Pais_R__c  (Name = 'ESPAÑA', codigo__c = '052', nombre__c = 'ESPAÑA'); 
        insert archivo;
        
        /*Departamentos__c archivoD = new Departamentos__c  (codigo_departamento__c = '052', Departamento__c = 'ESPAÑA'); 
        insert archivoD;*/
       
        ControllerPromociones3 p = new ControllerPromociones3();
       	List<SelectOption> selOpts = p.getPaises();
        List<SelectOption> selOpts2 = p.getDepart(); 
        p.opcionDepartamento = new List <SelectOption>();
        p.llamarEstado();
        p.candidato = new Lead();
        p.pop3=true;
        p.candidato.Motivo_Contacto__c = 'Hondureños en el Extranjero';
        p.llamarEstado();
        p.identificacion = '0801199717795';
        p.candidato.Identificacion__c = '0801199717795';
        p.pais = '0';
        p.guardarPop();
        p.reiniciar(); 
        p.parapais='054';
        p.paisRes = '054';
                        
        ControllerPromociones3 x = new ControllerPromociones3();
        List<SelectOption> selOpts1 = x.getPaises();
        List<SelectOption> selOpts3 = x.getDepart(); 
        x.opcionDepartamento = new List <SelectOption>();
        x.llamarEstado();
        x.pcDeptoCN = '0';
        x.candidato = new Lead();
        x.pop3=true;
        x.candidato.Motivo_Contacto__c = 'Hondureños en el Extranjero';
        x.llamarEstado();
        x.identificacion = '0801199717795';
        x.candidato.Identificacion__c = '0801199717795';
        x.pais = '052';
        x.depto = '0';
        x.guardarPop();
        x.reiniciar();
                
        ControllerPromociones3 s = new ControllerPromociones3();
        List<SelectOption> selOpts4 = s.getPaises();
        List<SelectOption> selOpts5 = s.getDepart(); 
        s.opcionDepartamento = new List <SelectOption>();
		list<Pais_R__c> FpaisC = new List <Pais_R__c>();
        s.llamarEstado();
        s.pcDeptoCN = 'Francisco Morazán';
        s.candidato = new Lead();
        s.pop3=true;
        s.candidato.Motivo_Contacto__c = 'Hondureños en el Extranjero';
        s.llamarEstado();
        s.identificacion = '0801199717795';
        s.candidato.Identificacion__c = '0801199717795';
        s.pais = '052';
        s.depto = 'Francisco Morazán';
        s.candidato.Phone = '9803233333877887866';
        s.guardarPop();
        s.reiniciar();
        
        
        ControllerPromociones3 m = new ControllerPromociones3();
        m.opcionDepartamento = new List <SelectOption>();
        m.pcDeptoCN = 'Francisco Morazán';
        m.llamarEstado();
        m.candidato = new Lead();
        m.pop3=true;
        m.candidato.Motivo_Contacto__c = 'Hondureños en el Extranjero';
        m.llamarEstado();
        m.identificacion = '0801199717795';
        m.candidato.Identificacion__c = '0801199717795';
        m.pais = 'Honduras';
        m.depto = 'Francisco Morazán';
        m.candidato.Phone = '98032333';
        m.candidato.Telefono_Trabajo__c  = '2234567898';
        m.guardarPop();
        m.reiniciar();
        
        
        
        ControllerPromociones3 g = new ControllerPromociones3();
        g.opcionDepartamento = new List <SelectOption>();
        g.llamarEstado();
        g.candidato = new Lead();
        g.pcDeptoCN = 'Francisco Morazán';
        g.pop3=true;
        g.candidato.Motivo_Contacto__c = 'Hondureños en el Extranjero';
        g.llamarEstado();
        g.identificacion = '0801199717795';
        g.candidato.Identificacion__c = '0801199717795';
        g.pais = 'Honduras';
        g.depto = 'Francisco Morazán';
        g.candidato.Phone = '98032333';
        g.candidato.Telefono_Trabajo__c  = '22345678';
        g.candidato.Departamento__c  = '--Ninguno--';
        g.guardarPop();
        g.reiniciar();
        
        
        
        ControllerPromociones3 q = new ControllerPromociones3();
        q.opcionDepartamento = new List <SelectOption>();
        q.llamarEstado();
        q.pcDeptoCN = 'Francisco Morazán';
        q.candidato = new Lead();
        q.pop3=true;
        q.candidato.Motivo_Contacto__c = 'Hondureños en el Extranjero';
        q.llamarEstado();
        q.identificacion = '0801199717795';
        q.candidato.Identificacion__c = '0801199717795';
        q.pais = 'Honduras';
        q.depto = 'Francisco Morazán';
        q.candidato.Phone = '98032333';
        q.candidato.Telefono_Trabajo__c  = '22345678';
        q.candidato.Departamento__c  = 'Francisco Morazán';
        q.preven = new List <Account>();
        q.prospectos = new List <Lead>();
        q.prev = new List <PreVenta__c>();
        q.Activi = new task();
        q.Actividad = new task();
        /*q.activi.OwnerId = '005j000000BiDwQ';
        q.activi.Subject= 'PROMOCIONES';
        q.activi.Status= 'No Iniciado';
        q.activi.Priority='Normal';
        //q.activi.WhatId = '0501199012478';
        insert q.activi;
        q.Actividad.OwnerId = '005j000000BiDwQ';
        q.Actividad.Subject= 'PROMOCIONES';
        q.Actividad.Status= 'No Iniciado';
        q.Actividad.Priority='Normal';
        //q.Actividad.WhatId = '0501199012478';
        insert q.Actividad;
        q.candidato.RecordTypeId = '005j000000BiDwQ';
        q.candidato.status = 'En Proceso';
        q.candidato.Usuario_Referencia__c = 'hn1212';
        q.candidato.LeadSource='Web';
        q.candidato.F_Hon_USA_Link_Ref__c = true;
        q.candidato.F_Pais__c = '052';
        q.candidato.F_Estado__c = 'Francisco Morazán';
        insert q.candidato;
        */
        q.pop3 = False;
        q.guardarPop();
        q.reiniciar(); 
        
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
                
    }
    
}