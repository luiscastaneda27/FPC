@isTest
public class testRefeXCanal {
    
    static testMethod void controllerRefeXCanal(){
        
        test.startTest();
        controllerRefeXCanal pro =  new controllerRefeXCanal();
        pro.candidato = new Lead();
        pro.candidato.FirstName = 'carlo';
        pro.candidato.LastName = 'escoto';
        pro.guardarPop();
        
        pro.candidato.Phone = '886125101465';
        pro.candidato.Telefono_Trabajo__c = '227524005454';
        pro.candidato.Departamento__c = 'N/A';
        pro.guardarPop();
        pro.candidato.Phone = '88612510';
        pro.candidato.Telefono_Trabajo__c = '22752400';
        pro.guardarPop();
        pro.candidato.Identificacion__c = '0801199411013';
        pro.candidato.Identificacion__c = '';
        pro.candidato.Motivo_Contacto__c = 'Campaña HTML';
        pro.candidato.Referido_por__c = 'paola';
        pro.candidato.Correo_Empleado_Ficohsa__c = 'wendy.alvarado@ficohsa.com';
        pro.guardarPop();
        //prospecto.RecordTypeId = '';
        pro.candidato.Status = 'En Proceso';
        pro.candidato.LeadSource = 'Web';
        pro.candidato.RecordTypeid = [Select id From RecordType Where DeveloperName ='Natural' and SObjectType = 'Lead'].id; 
        pro.guardarPop();
        pro.candidato.Departamento__c = 'Francisco Morazan';
        
        pro.guardarPop();
        pro.pop3= true;
        pro.bloq2 = true;

        list<Lead> lista = new list<Lead>();


        pro.DesbAgen();
        pro.BloqAgen();
        
        pro.canalr = 'Agencias';
        pro.agenciar = ' --Ninguno-- ';
        pro.BloqAgen();
        pro.guardarPop();
        //insert pro.candidato;
        //pro.guardarPop();
        pro.reiniciar();
        
        controllerRefeXCanal pre =  new controllerRefeXCanal();
        pre.candidato = new Lead();
        
        pre.candidato.FirstName = '';
        pre.candidato.LastName = '';
        pre.guardarPop();
        pre.candidato.FirstName = 'pao';
        pre.candidato.LastName = '';
        pre.guardarPop();
        pre.candidato.FirstName = 'w';
        pre.candidato.LastName = 'p';
        pre.candidato.Phone = '8861251';
        pre.guardarPop();
        pre.candidato.FirstName = 'w';
        pre.candidato.LastName = 'p';
        pre.candidato.Phone = '88612510';
        pre.candidato.Telefono_Trabajo__c = '2275240000';
        pre.guardarPop();
        pre.candidato.FirstName = 'w';
        pre.candidato.LastName = 'p';
        pre.candidato.Phone = '88612510';
        pre.candidato.Telefono_Trabajo__c = '2275';
        pre.canalr = ' --Ninguno-- ';
        pre.guardarPop();
        pre.candidato.FirstName = 'w';
        pre.candidato.LastName = 'p';
        pre.candidato.Phone = '88612510';
        pre.candidato.Telefono_Trabajo__c = '22752400';
        pre.canalr = 'A';
        pre.candidato.Description = 'test';
        pre.candidato.Referido_por__c = '';
        pre.guardarPop();
        pre.candidato.FirstName = 'w';
        pre.candidato.LastName = 'p';
        pre.candidato.Phone = '88612510';
        pre.candidato.Telefono_Trabajo__c = '22752400';
        pre.canalr = 'A';
        pre.candidato.Description = 'test';
        pre.candidato.Referido_por__c = 'pao';
        pre.candidato.Correo_Empleado_Ficohsa__c = '';
        pre.guardarPop();
        
        pre.candidato.FirstName = 'w';
        pre.candidato.LastName = 'p';
        pre.candidato.Phone = '88612510';
        pre.candidato.Telefono_Trabajo__c = '22752400';
        pre.canalr = 'A';
        pre.candidato.Description = 'test';
        pre.candidato.Referido_por__c = 'pao';
        pre.candidato.Correo_Empleado_Ficohsa__c = 'wendy.alvarado@ficohsa.com';
        pre.guardarPop();
        
        test.stopTest();
        
    

	}

}