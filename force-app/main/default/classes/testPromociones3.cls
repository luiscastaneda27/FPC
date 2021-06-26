@isTest
public class testPromociones3 {
    static testMethod void ControllerPromociones3(){
        Account cuenta = new Account();
        cuenta.lastname='Doanire';
        cuenta.firstname='Luis';
        cuenta.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
        cuenta.Identificacion__c='00000000000000';
        cuenta.Tipo_Identificacion__c='Cedula de identidad';
        cuenta.Sexo__c='Masculino';
        cuenta.CurrencyIsoCode = 'HNL';
        cuenta.Estado_Civil__pc='Soltero';
        insert cuenta;
        
        PreVenta__c  PV = new PreVenta__c ();
        PV.FirstName__c = 'test';
        PV.LastName__c = 'Test';
        PV.Identificacion__c = '00000000000001';
        insert PV;
        
        Pais_R__c pais = new Pais_R__c();
        pais.codigo__c = '052';
        pais.nombre__c = 'Pais Name';
        insert pais;
        
        pais = new Pais_R__c();
        pais.codigo__c = '123';
        pais.nombre__c = 'Pais Name';
        //pais.ActivoAfiliacionExtranjero__C = true;
        insert pais;
        
        Departamentos__c dep =new Departamentos__c();
        dep.codigo_departamento__c = '123';
        dep.codigo_pais__c = '123';
        dep.Name = 'Nombre D';
        dep.Departamento__c = '123';
        insert dep;
        
        Usuarios_para_asignacion_Casos_SAC__c usuarioAS = new Usuarios_para_asignacion_Casos_SAC__c();
        usuarioAS.Usuario__c = userInfo.getUserId();
        usuarioAS.Objeto__c = 'Lead';
        insert usuarioAS;
        
        ApexPages.currentPage().getParameters().put('idPage:theForm:Fpais','123');
        ControllerPromociones3 controlador = new ControllerPromociones3();
        controlador.candidato.Identificacion__c = '123';
        controlador.depto = '0';
        controlador.guardar();
        
        controlador.getDepartamento();
        controlador.depto = '123';
        controlador.pais = '052';
        controlador.candidato.Phone = '123456789';
        controlador.guardar();
        
        controlador.pais = '052';
        controlador.candidato.Phone = '12345678';
        controlador.candidato.Telefono_Trabajo__c = '123456789';
        controlador.guardar();
        
        controlador.candidato.Telefono_Trabajo__c = '12345678';
        controlador.pais = '123';
        controlador.candidato.FirstName = 'Test';
        controlador.candidato.LastName = 'Test';
        controlador.guardar();
        
        controlador.candidato.Telefono_Trabajo__c = '12345678';
        controlador.pais = '123';
        controlador.candidato.Identificacion__c = '00000000000000';
        controlador.candidato.FirstName = 'Test';
        controlador.candidato.LastName = 'Test';
        controlador.candidato.Phone = '1232321';
        controlador.guardar();
        
        controlador.candidato.Telefono_Trabajo__c = '12345678';
        controlador.pais = '123';
        controlador.candidato.Identificacion__c = '00000000000001';
        controlador.candidato.FirstName = 'Test';
        controlador.candidato.LastName = 'Test';
        controlador.candidato.Phone = '1232321';
        controlador.guardar();
        
        controlador.guardar();
         
    }
    
    
}