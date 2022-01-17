@isTest
public class changeOwnerSACAndSendMessageTest {
    @isTest public static void execute() {
        
        Profile profile1 = [Select Id from Profile where name = 'Administrador del sistema'];
        System.debug('What is the profile id ' + profile1);
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueof(Datetime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.rint(math.random()*1000000));
        String uniqueName = orgId + dateString + randomInt;
        User tuser = new User(  firstname = 'Test',
                              lastName = 'Test',
                              email = uniqueName + '@test' + orgId + '.org',
                              Username = uniqueName + '@test' + orgId + '.org',
                              EmailEncodingKey = 'ISO-8859-1',
                              Alias = uniqueName.substring(18, 23),
                              TimeZoneSidKey = 'America/Los_Angeles',
                              LocaleSidKey = 'en_US',
                              LanguageLocaleKey = 'en_US',
                              UserRoleId = portalRole.Id,
                              ProfileId = profile1.Id);
        
        insert tuser;
        
        System.runAs(tuser) {
        
        Account cliente = new Account();
        cliente.Name='Luis Donaire';
        cliente.Identificacion__c='0709199300155';
        insert cliente;
        
        Producto__C producto = new Producto__C();
        producto.Codigo__c='qwqw';
        producto.name='Prueba';
        insert producto;
        
        Subproducto__c  subProducto = new Subproducto__c ();
        subProducto.Name='Test';
        subProducto.Codigo__c='3434';
        subProducto.Producto__c = producto.id;
        insert subProducto;
        
        Cuentas__C cuenta = new cuentas__C();
        cuenta.codigo__C='0000';
        cuenta.Cliente__c = cliente.id;
        cuenta.Subproducto__c = subProducto.id;
        cuenta.name='test';
        cuenta.Monto_aporte__c = 100;
        cuenta.Forma_Aportacion__c='TA';
        insert cuenta;
        
        Agencia__C agencia = new agencia__C(name='Test', zona__C='2');
        insert agencia;
        
        Usuarios_para_asignacion_Casos_SAC__c f = new Usuarios_para_asignacion_Casos_SAC__c();
        f.Zona__c='2';
        f.Usuario__c = userinfo.getUserId();
        insert f;
        
        municipio__C municipio = new municipio__C();
        municipio.Codigo_Municipio__c='01';
        municipio.nombre_municipio__C='Test';
        municipio.codigo_departamento__c= '	120';
        insert municipio;       
        
        String RecordTypeId0 = Schema.SObjectType.Case.getRecordTypeInfosByName().get('Email to Case').getRecordTypeId();
        
        List<Case> caseListToInsert = new List<Case>();
        case c = new Case();
        c.AccountId = cliente.Id;
        c.Status = 'Nuevo';
        c.SuppliedEmail = 'test@gmail.com';
        c.RecordTypeId = RecordTypeId0;
        c.Subject = 'Test';
        c.Identificacion__c = '0709199300157';
        insert c;
        
        test.startTest();
        	changeOwnerSACAndSendMessage.processCase(c.Id, tuser.Id);
        test.stopTest();
        
        }    
    }
}