@isTest
public class ContraladorCrearusuario2Test {
    @testSetup 
    static void setupMethod() {
        Account EmpresaPrueba= new Account();
        empresaprueba.Name='Empresa Prueba';
        EmpresaPrueba.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Juridico').getRecordTypeId();
        EmpresaPrueba.Identificacion__c='012j0000';
        EmpresaPrueba.Salario_Base_Pilar_Complementario__c=10000;
        EmpresaPrueba.Salario_Base_Reserva_Laboral__c=10000;
        EmpresaPrueba.PAPCT__c=3;
        EmpresaPrueba.PAPCE__c=3;
        EmpresaPrueba.Porcentaje_de_Aportaciones_Reserva_Labor__c=4;
        EmpresaPrueba.Salario_Base_Seguro_Social__c=432;
        EmpresaPrueba.Porc_Apor_SSoc_Empleador_IVM__c=3;
        EmpresaPrueba.Porc_Apor_SSoc_Empleado_IVM__c=3;
        EmpresaPrueba.Salario_Base_Seguro_Social_Mater__c=4;
        EmpresaPrueba.Porc_Apor_SSoc_Empleador_Mater__c=5;
        EmpresaPrueba.Porc_Apor_SSoc_Empleado_Mater__c=5;
        EmpresaPrueba.Salario_Base_Seguro_Social_RP__c=43433;
        EmpresaPrueba.Riesgo_Profecional_Patronal__c=6;
        insert EmpresaPrueba;
        
        Usuario_Portal_Empresarial__c usuario = new Usuario_Portal_Empresarial__c();
        usuario.Apellidos__c='Meraz';
        usuario.Contrasena2__c='Cualquiera';
        usuario.Email__c='marcela.meraz@gmail.com';
        usuario.Name='Yeny';
        usuario.Respuesta__c='Lunes';
        usuario.Identidad__c='0101010101011';
        usuario.Nombre_Usuario__c='chema';
        insert usuario;
        
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora.Usuario__c=usuario.id;
        hora.Hora_ultima_consulta__c=datetime.now();
        insert hora; 
        
        Usuario_X_Empresa__c a = new Usuario_X_Empresa__c();
        a.empresa2__C=empresaprueba.id;
        a.Usuario__c=usuario.id;
        a.Activo__c=true;
        a.Aprobacion_Usuarios__c=TRUE;
        a.Calculo_De_Pilares__c=true;
        a.Cargar_Generar_Planilla__c=true;
        a.Crear_Usuarios__c=true;
        a.Nuevo_Personal__c=true;
        a.Reportes__c=true;
        a.Planilla_Seguro_Social__c=true;
        a.Nuevos_Salarios__c = true;
        insert a;
        insertarUsuariosTem(empresaprueba, false);
        
        
    }
    
    public static void insertarUsuariosTem(Account empresaprueba, Boolean modificado){
        Usuario_Temporal__c usuTemp = new Usuario_Temporal__c();
        usuTemp.Apellidos__c = 'Test';
        usuTemp.Email__c = 'test@test.hn';
        usuTemp.Identidad__c = '0101010101011';
        usuTemp.Name = 'Test';
        insert usuTemp;
        
        Usuario_Empresa_Temporal__c usuEmpreTemp = new Usuario_Empresa_Temporal__c();
        usuEmpreTemp.Usuario__c = usuTemp.Id;
        usuEmpreTemp.Empresa2__c = empresaprueba.Id;
        usuEmpretemp.Modificado__c = modificado;
        insert usuEmpreTemp;
    }
    
    static testmethod void ContraladorCrearusuario2Test(){
        Account empresaprueba = [Select Id, Name from Account Where Identificacion__c = '012j0000'];
        Usuario_Portal_Empresarial__c usuario = [Select Id, Name from Usuario_Portal_Empresarial__c Where Email__c='marcela.meraz@gmail.com'];
        ApexPages.currentPage().getParameters().put('Eldudhdhyudb',empresaprueba.id);
        ApexPages.currentPage().getParameters().put('loetdncdhjch',usuario.id); 
        ContraladorCrearusuario2 controlador =new ContraladorCrearusuario2();
        controlador.registrarTiempo();
        controlador.Cancelar();
        
        //Test para método cambiar contrasenia
        controlador.cambiarContrasena();
        controlador.contrasenaActual = 'Cualquiera1';
        controlador.cambiarContrasena();
        controlador.contrasenaActual = 'Cualquiera';
        controlador.cambiarContrasena();
        controlador.contrasenaNueva = 'DiosEsAmor#7';
        controlador.cambiarContrasena();
        controlador.contrasenaRepetida = controlador.contrasenaNueva;
        controlador.cambiarContrasena();
        controlador.verCambioContrasena();
        
        //Test para Método activar Modal
        controlador.ActivarModalModificarusuario();
        controlador.ActivarModalCrearusuario();
        
        //Test para Método Denegar
        controlador.Num_Identidad = '0101010101011';
        Controlador.Denegar();
        Controlador.Denegar();
        insertarUsuariosTem(empresaprueba, true);
        controlador.Num_Identidad = '0101010101011';
        Controlador.Denegar();
        
        //Test para Método Aprobar
        controlador.Num_Identidad = '0101010101011';
        Controlador.Aprobar();
        Usuario_Empresa_Temporal__c usu = [select Modificado__c, Id from Usuario_Empresa_Temporal__c where Usuario__r.Identidad__c= '0101010101011' and empresa2__c=:empresaprueba.id ];
        usu.Modificado__c = false;
        update usu;
        Usuario_Temporal__c usuTemp = [select Identidad__c, Id from Usuario_Temporal__c where Identidad__c= '0101010101011' ];
        usuTemp.Identidad__c = '0101010101012';
        update usuTemp;
        controlador.Num_Identidad = '0101010101012';
        Controlador.Aprobar();
        controlador.Num_Identidad = null;
        Controlador.Aprobar();

    }

}