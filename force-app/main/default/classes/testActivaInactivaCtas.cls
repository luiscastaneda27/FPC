@isTest 
public class testActivaInactivaCtas {
static testMethod void ActivaciondeCuentas()
    {
        test.startTest();        
        ActivacionCuenta__c archivo = new ActivacionCuenta__c  (NoCuenta__c='28459', noIdentidad__c='09887665544', Cliente__c='pruebaaa', 
                                                                Empresa__c='empresa prueba', EstadoActual__c='A', Causa__c='PruebaPens', 
                                                                EstadoNuevo__c='A',CausaNuevo__c='Prueba', Situaci_n__c='',
                                                                Usuario__c='hn3456', Estado__c='', Fecha_CargaA__c= string.valueOf(date.today()),Identificador_CargaA__c=4);
       
        insert archivo;
       
              
        String objeto;       
        objeto=ActivaciondeCuentas.llenarObjetos('"prueba"');
        objeto=ActivaciondeCuentas.llenarObjetos('""');
        objeto=ActivaciondeCuentas.llenarObjetos('prueba');
        
        string ags=''; 
	    string encabezado='"NCuenta","Identidad","EstadoActual","CAUSA ACTUAL","Estado.Nuevo","Causa.Nueva"';
        string cuerpo='"28387","08065478909","A","Pensiones","I","Pensiones2"';
        string stringCSV= encabezado +'\n'+ cuerpo;
        classWRetorno2 error = new classWRetorno2();
        error = ActivaciondeCuentas.SUbirInformacion(stringCSV, 'UserPru' ,ags);
        
        String prueba;
        String prueba2;
        String pruebaCSV;
        prueba='"NCuenta","Identidad","EstadoActual","CAUSA ACTUAL","Estado.Nuevo","Causa.Nueva"';//'"No.Cuenta","No.Identidad","Estado Actual","CAUSA ACTUAL","Estado Nuevo","CAUSA NUEVA"';
        prueba2='"28387","08065478909","A","Pensiones","I","Pensiones2"';
        pruebaCSV=prueba+prueba2;
        error = ActivaciondeCuentas.SUbirInformacion(pruebaCSV, 'UserPru', ags);
        
        String prueba3;
        String prueba4;
        String pruebaCSV1;
        prueba='"NCuenta","Identidad","EstadoActual","CAUSA ACTUAL","Estado.Nuevo","Causa.Nueva"';//'"No.Cuenta","No.Identidad","Estado Actual","CAUSA ACTUAL","Estado Nuevo","CAUSA NUEVA"';
        prueba2='"28387","08065478909","A","Pensiones","I","Pensiones2"';
        pruebaCSV1=prueba3+prueba4;
        error = ActivaciondeCuentas.SUbirInformacion(pruebaCSV1, 'UserPru' ,ags);  
                             
               
        ActivaciondeCuentas p = new ActivaciondeCuentas();
        
        p.usuario1= '';
        p.mostrarTabla = false;
        p.mostrarTabla = false;
        p.EnviarDatos =false;
        p.ActivarDatos = false;
        p.Modificar= false;
        p.Cont = 0;
		p.valida =false;
		p.Num_CodReferencia =1;
		p.Num_Cod = 2;    
        p.aprobarM =false;
        p.VerContenido =false;
        p.total =0;
        p.FechaInclusion =date.today();
        p.Motivo ='';
        p.Cambiar=false;
        p.rechazarM1 =false;
        p.VentanaPlanilla =false;
        
        p.rechazoPla();
        p.cambio();
        p.aprobado();
        p.salir();
        p.mtabla();
        
        list<ActivacionCuenta__c> Activacion = new list<ActivacionCuenta__c>();
        list<ActivacionCuenta__c> CambioActiva = new list<ActivacionCuenta__c>();
        p.VerPlanilla();                        
        list<ContenidoActivaciondeCuentas> validaDatos= new list<ContenidoActivaciondeCuentas>();
        list<ActivacionCuenta__c> ModifList = new list<ActivacionCuenta__c>(); 
        Usuarios_de_Pantallas__c InfoUsuario = new Usuarios_de_Pantallas__c ();
        
        p.Limpiar();
        p.ModificarContenido();
        p.ValidarContenido();
        p.VerContenido();
        p.VerPlanillaArchivo();
        p.MostrarVentanaPlanilla();
        p.aprobarPlanilla();
        
        ContenidoActivaciondeCuentas ClaseDatos = new ContenidoActivaciondeCuentas('NoCuenta','NoIdentidad','EstadoActual','Causa','EstadoNuevo','CausaNueva',
                                                                     'Registrador','Autorizador',1, date.today(),'Descripcion');  
        p.paraMotivo();
        
        Api_ActivaciondeCuentas apii = new Api_ActivaciondeCuentas();  
        p.denegarPlanilla();
        
        Api_ActivaciondeCuentas.classRespuestaActivacion A= new Api_ActivaciondeCuentas.classRespuestaActivacion();
        A.Certificado='325';
        A.Mensaje='325';   
        A.nEmpresa ='prueba';
        A.nombreCliente ='Maria';
        A.Asesor= 'Carla Hernandez';
        
        ActivacionCuenta__c carga = new ActivacionCuenta__c (Identificador_CargaA__c = 1);  
        insert carga;
        
        A.ModificarEstado = [select Situaci_n__c, NoCuenta__c, Cliente__c, Empresa__c, Asesor__c                              
                             from ActivacionCuenta__c where Identificador_CargaA__c =: 1]; 
        
        A.sizeResu = 5;
        A.sizeModi = 5;     
        A.IdCarga = 2;  
        
        valResgistroActivaciondeCuentas env = new valResgistroActivaciondeCuentas(validaDatos); 
        Api_ActivaciondeCuentas.actualizaEstadoCausa(env);
        Api_ActivaciondeCuentas.BitacoraDCausaEstado(env); 
		                
        test.stopTest();
    }

}