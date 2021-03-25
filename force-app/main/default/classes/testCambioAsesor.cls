@isTest 
public class testCambioAsesor {
    static testMethod void CambioAsesor()
    {
        test.startTest();        
        CambioAsesor__c archivo = new CambioAsesor__c  (NoCuenta__c= '24280',Nombre_Completo__c= 'MEJIA LOPEZ FRANCISCO JOSE',
                                                        Identidad__c= '0801198601371',Empresa__c='BANCO FINANCIERA COMERCIAL HONDUREÑA, S.A.', 
                                                        Nombre_Asesor_actual__c='URRUTIA BAIRES ALEYDA SABRINA', Nombre_asesor_nuevo__c='RUBIO NIETO WENDY GERALDINA', 
                                                        Asesor_Nuevo__c='HN19964', Asesor_Actual__c='HN22258',Situaci_n__c='', Estado__c='', 
                                                        usuario__c='HN19577',Fecha_Inclusion_Carga__c= string.valueOf(date.today()),Identificador_Carga__c= 3); 
        insert archivo;
        
        /*Bitacora_Masivo__c bita = new Bitacora_Masivo__c (Actividades__c ='prueba', Estado__c ='aprob', 
                                                          Fecha__c = date.today(), Pantalla__c ='prueba1', Usuario__c = 'hn1263');      
        
        insert bita;*/
              
        String objeto;       
        objeto=CambioAsesor.llenarObjetos('"prueba"');
        objeto=CambioAsesor.llenarObjetos('""');
        objeto=CambioAsesor.llenarObjetos('prueba');
        
        string ags=''; 
	    string encabezado='"NCuenta","Identidad","Asesor Actual","Asesor Nuevo"';
        string cuerpo='"21528", "08011922073","N21529","N19778"';
        string stringCSV= encabezado+'\n'+ cuerpo;
        classWRetorno2 error = new classWRetorno2();
        error = CambioAsesor.SUbirInformacion(stringCSV, 'UserPru', ags); 
        
        String prueba;
        String prueba2;
        String pruebaCSV;
        prueba='"NCuenta","Identidad","Asesor Actual","Asesor Nuevo"';
        prueba2='"21528", "08011922073","N21529","N19778"';
        pruebaCSV=prueba+prueba2;
        error = CambioAsesor.SUbirInformacion(pruebaCSV, 'UserPru' ,ags);
        
        String prueba3;
        String prueba4;
        String pruebaCSV1;
        prueba='"NCuenta","Identidad","Asesor Actual","Asesor Nuevo"';
        prueba2='"21528", "08011922073","N21529","N19778"';
        pruebaCSV1=prueba3+prueba4;
        error = CambioAsesor.SUbirInformacion(pruebaCSV1, 'UserPru' ,ags);       
       
               
        CambioAsesor p = new CambioAsesor();
        
        p.EnvioD=false;
        p.modifi=false;
        p.rechazarM =false;
        p.Cont = 0;
        p.total = 0;
        p.Motivo= ''; 
        p.valida = false;
        p.mTabla1 =false;
        p.Num_CodReferencia =3;
        p.Num_Cod =4;
        p.VerContenido =false;
       
        p.usuario = 'usuario';
        p.usuario1 = 'usuario1';
        p.mailA='mailA';
        p.mailD='mailD';
                
        p.salir();
        p.aprobarM =false;
        p.rechazarM1 =false;
        p.VentanaPlanilla = false; 
        p.aprobado();
        p.cambio();
        p.Cambiar = true;
        p.rechazoPla();
        p.ocul();       
        
                
        list<CambioAsesor__c> CambioAsesor = new list<CambioAsesor__c>();
        list<CambioAsesor__c> CambioAses = new list<CambioAsesor__c>();
        p.VerPlanilla();                        
        list<ContenidoCambioAsesor> validaDatos= new list<ContenidoCambioAsesor>();
        //list<ContenidoCambioAsesor> validaDatos1= new list<ContenidoCambioAsesor>();
        list<CambioAsesor__c> ModifList = new list<CambioAsesor__c>(); 
        Usuarios_de_Pantallas__c InfoUsuario = new Usuarios_de_Pantallas__c ();
               
       
        //list<CambioAsesor__c> CambioAsesor1 = CambioAsesor;        
        /*integer idP;
        CambioAsesor__c carga1 = new CambioAsesor__c (Identificador_Carga__c= 3) ;
        idP = integer.valueOf(carga1.Identificador_Carga__c);                
        insert carga1;    */                 
                
        p.Limpiar();
               
        p.ModificarContenido(); 
        
       	p.ValidarContenido();
       
        p.VerContenido();
                
        p.VerPlanillaArchivo();
        
        p.MostrarVentanaPlanilla();
        //list<CambioAsesor__c> CambioAses = new list<CambioAsesor__c>(); 
       
		p.paraMotivo();
                
        p.aprobarPlanilla();
        //p.total =null;
        //update CambioAsesor;        
        
        ContenidoCambioAsesor ClaseDatos = new ContenidoCambioAsesor('NCuenta','Identidad','AsesorActual','Asesornuevo',
                                                                     'Registrador','Autorizador',1, date.today(),'Descripcion');      
              
        Api_CambioAsesor apii = new Api_CambioAsesor();  
       //api_CambioAsesor.actualizaCambioAsesor
        
        p.denegarPlanilla();  
        /*p.EnvioCorreoAprobado();
        p.EnvioCorreoDenegado();*/
        
        /*Bitacora_Masivo__c bita = new Bitacora_Masivo__c ();
        bita.Actividades__c = ''; 
        bita.Estado__c='denegar';
        bita.Fecha__c = date.today() ;
        bita.Pantalla__c ='prueba';
        bita.Usuario__c='1234';*/
        
        //EL API
			
        Api_CambioAsesor.classRespuestaCambioAsesor A= new Api_CambioAsesor.classRespuestaCambioAsesor();
        A.Certificado='325';
        A.Mensaje='325';   
        A.nEmpresa ='prueba';
        A.nombreCliente ='Maria';
        A.nombreAsesoractual= 'Carla Hernandez';
        A.nombreAsesornuevo = 'Jorge Barahona';         
        
        CambioAsesor__c carga = new CambioAsesor__c (Identificador_Carga__c = 1);  
        insert carga;
        
        A.ModificarEstado = [select Situaci_n__c, NoCuenta__c,Empresa__c , Nombre_Completo__c,Nombre_Asesor_actual__c,Nombre_asesor_nuevo__c, Identificador_Carga__c                              
                             from CambioAsesor__c where Identificador_Carga__c =: 1];
 
        
        A.sizeResu = 5;
        A.sizeModi = 5;     
        A.IdCarga = 2;  
        
        enviarCambioAsesor env = new enviarCambioAsesor(validaDatos); 
        Api_CambioAsesor.actualizaCambioAsesor(env);
        Api_CambioAsesor.BitacoraDCambioAsesor(env);      
		                
        test.stopTest();
    }
}