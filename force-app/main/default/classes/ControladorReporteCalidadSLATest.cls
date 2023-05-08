@isTest
public class ControladorReporteCalidadSLATest {
    
    @testSetup 
    static void setupMethod() {
        Usuarios_de_Pantallas__c usuario = new Usuarios_de_Pantallas__c ();
        usuario.Activo__c = true;
        usuario.Usuario__c = 'HN123';
        usuario.Contrase_a__c = 'juan123';
        usuario.name = 'Juan';
        usuario.Apellido__c='Perez';
        usuario.Email__c = 'juanperez@test.com';
        usuario.Perfil__c = 'SGS';
        insert usuario;
        
        List<FPC_TiemposSLARC__c> listTiempos = new List<FPC_TiemposSLARC__c>();
        FPC_TiemposSLARC__c  tiempo = new FPC_TiemposSLARC__c ();
        tiempo.FPC_Codigo__c = 'N';
        tiempo.FPC_PantallaRC__c = 'I';
        tiempo.FPC_Tiempo__c = 1;
        listTiempos.add(tiempo);
        
        tiempo = new FPC_TiemposSLARC__c ();
        tiempo.FPC_Codigo__c = 'NS';
        tiempo.FPC_PantallaRC__c = 'TV';
        tiempo.FPC_Tiempo__c = 1;
        listTiempos.add(tiempo);
        
        tiempo = new FPC_TiemposSLARC__c ();
        tiempo.FPC_Codigo__c = 'NC';
        tiempo.FPC_PantallaRC__c = 'TV';
        tiempo.FPC_Tiempo__c = 1;
        listTiempos.add(tiempo);
        
        insert listTiempos;
        
        User user1 = new User(Id = UserInfo.getUserId(), Codigo__c = 'HN123'); 
        update user1; 
        
        List<Reporte_calidad__c> listAfiliacion = new List<Reporte_calidad__c>();
        Reporte_calidad__C afiliacion = new Reporte_calidad__C();
        afiliacion.Identificacion__c = '123';
        afiliacion.Tipo_Afiliacion__c = 'I';
        afiliacion.Estado__c = 'N';
        afiliacion.Name = 'Test';
        afiliacion.Codigo_Asesor_Comercial__c = user1.Codigo__c;
        afiliacion.Codigo_Oficial_SAC__c = user1.Codigo__c;
        listAfiliacion.add(afiliacion);
        
        afiliacion = new Reporte_calidad__C();
        afiliacion.Identificacion__c = '123';
        afiliacion.Tipo_Afiliacion__c = 'TV';
        afiliacion.Estado__c = 'N';
        afiliacion.SubEstadoRCSF__c = 'NS';
        afiliacion.Name = 'Test';
        afiliacion.Codigo_Asesor_Comercial__c = user1.Codigo__c;
        afiliacion.Codigo_Oficial_SAC__c = user1.Codigo__c;
        listAfiliacion.add(afiliacion);
        
        afiliacion = new Reporte_calidad__C();
        afiliacion.Identificacion__c = '123';
        afiliacion.Tipo_Afiliacion__c = 'TV';
        afiliacion.SubEstadoRCSF__c = 'NC';
        afiliacion.Estado__c = 'N';
        afiliacion.Name = 'Test';
        afiliacion.Codigo_Asesor_Comercial__c = user1.Codigo__c;
        afiliacion.Codigo_Oficial_SAC__c = user1.Codigo__c;
        listAfiliacion.add(afiliacion);
        insert listAfiliacion;
        
        
    }
    
    static testMethod void ControladorReporteCalidadSLAExecute(){
        Test.startTest();
        List<FPC_InicioFinSubEstadosSLARC__c> listTiemposSLA = EnvioCorreoSLA.getRecords('');
        for(FPC_InicioFinSubEstadosSLARC__c item: listTiemposSLA){
            item.FPC_FechaInicio__c = system.now().addMinutes(-32);
        }
        update listTiemposSLA;
        
        User user1 = [Select Codigo__c from user where Id =:UserInfo.getUserId()]; 
        
        ApexPages.currentPage().getParameters().put('usuario',user1.Codigo__c);
        ControladorReporteCalidadSLA controller= new ControladorReporteCalidadSLA();
        
        controller.iniciar();
        for(FPC_InicioFinSubEstadosSLARC__c item: listTiemposSLA){
            item.FPC_FechaInicio__c = system.now().addDays(-2);
        }
        update listTiemposSLA;
        controller.iniciar();
        Test.stopTest();
    }
    
}