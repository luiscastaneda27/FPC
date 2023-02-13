@isTest (SeeAllData = FALSE)
public class testpignorados {
    
    static testMethod void controllerpignorados()
    { 
       
        controllerpignorados p = new controllerpignorados();
		p.validatenum('32434343');
    	p.id_pign = '';
    	p.usuario = 'HN17795';
   		p.nombrepig = 'Prueba';
    	p.num_prest = '';
    	p.tama = 1;
    	p.cod_obj = 'a1A0t00000B54hdEAB';
    	p.total = 1;
    	p.MuestraTabla = true; 
        p.Motivo = '';
    	p.DenegarVentana = true;
   		p.DenegarImagen = true;
     	p.Ver_Imagen = 'prueba';
    	p.result = true;
    	p.nom_empleado = 'Prueba';
    	p.cod_empleado = 'HN1235';
		p.correoEmpleado = 'prueba@hotmail.com';
        p.correoEmpleado2 = 'prueba@hotmail.com';

        list<Fondo_Pignorado__c> McontenidoPign = new list<Fondo_Pignorado__c>();
        
          classcambiopignorados fe = new classcambiopignorados();
        fe.codcuenta = '43434';
    	fe.id_pign = '0801199717795';
        fe.num_prest = '321322311';
		fe.nombrepig = 'nombre';
		fe.fliberacion = date.today();
        fe.fpignoracion = date.today();
        fe.num_prest1 = '23433424';
        fe.est_pig = 'A';
        fe.sec_pig = 3213;
		fe.tot_fondos_pig = 321332;
		fe.m_prestamo = 3424324;
        fe.m_pignorado = 231223;
        
        /*ListaPignorados*/
        p.ListPignorados = new List <classcambiopignorados>();
        fe.ListPignorados = new List <classcambiopignorados>();
        p.ListPignorados.add(fe);
        
        /**/
        p.cuentapig = '43434';
        p.Busca1();
        
        p.cuentapig = '';
        p.Busca1();
        
        p.popDenegarSalir();
        p.MostrarVentanaDenegacion();
        p.popSalirImagen();
        p.actList();
        p.Busca1();
        p.BuscaInfor1();
        p.Busca2();
        p.BuscaInfor2();
        p.Busca3();
        p.BuscaInfor3();
        p.Enviar();
        p.iniciar();
        p.Autorizar();
        p.correoUsuario();
        
        /*DENEGARLISTA*/
        
        p.DenegarLista();
        
        /**/
        p.limpiar1();
        p.LimpiarTabla();
        p.Cancelar();
        //p.validateid(null);
       
       
        
        Usuarios_de_Pantallas__c u = new Usuarios_de_Pantallas__c ();
        u.Activo__c = true;
        u.Apellido__c ='prueba';
        u.Contrase_a__c = '*****';
        u.Contrasena2__c = '****';
        u.Email__c = 'prueba@hotmail.com';
       //- u.Rol_Sysde__c = 'prueba';
        u.Usuario__c = 'hn19777';
		insert u;
        
        OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
						Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
               
        
        controllerpignorados p1 = new controllerpignorados(); 
        p1.cuentapig = '12345';
    	p1.id_pign = '0801199717795';
    	p1.usuario = 'HN17795';
   		p1.nombrepig = 'Prueba';
    	p1.num_prest = '0002333450';
    	p1.tama = 1;
    	p1.cod_obj = 'a1A0t00000B54hdEAB';
    	p1.total = 1;
    	p1.MuestraTabla = false; 
        p1.Motivo = '';
    	p1.DenegarVentana = false;
   		p1.DenegarImagen = false;
     	p1.Ver_Imagen = 'prueba';
    	p1.result = false;
    	p1.nom_empleado = 'Prueba';
    	p1.cod_empleado = 'HN1235';
		p1.correoEmpleado = 'prueba@hotmail.com';
        p1.correoEmpleado2 = 'prueba@hotmail.com';
        p1.ct = 'prueba';
        p1.popDenegarSalir();
        p1.MostrarVentanaDenegacion();
        p1.popSalirImagen();
        p1.validatenum(p1.cuentapig);
        p1.Busca1();
        p1.BuscaInfor1();
        
        p1.Enviar();
        p1.iniciar();
        p1.Autorizar();
        p1.correoUsuario();
        p1.DenegarLista();
        p1.limpiar1();
        p1.LimpiarTabla();
        p1.Cancelar();
        p1.ListPignorados = new List <classcambiopignorados>();
        p1.McontenidoPign =[ select Id, Numero_Prestamo__c,Monto_Pignorado__c,Fecha_Pignoracion__c,Fecha_Liberacion__c,Monto_Prestamo__c ,
                                    Total_Fondos__c,Usuario__c,Estatus__c, Estado__c, Cuenta__c
                            from Fondo_Pignorado__c
                            where Estado__c = 'P'];     
        p1.MostrarImagen();
        
        controllerpignorados p2 = new controllerpignorados(); 
       	p2.cuentapig = '12345';
    	p2.id_pign = '0801199717795';
    	p2.usuario = 'HN17795';
   		p2.nombrepig = 'Prueba';
    	p2.num_prest = '';
    	p2.tama = 1;
    	p2.cod_obj = 'a1A0t00000B54hdEAB';
    	p2.total = 1;
    	p2.MuestraTabla = false; 
        p2.Motivo = 'Prueba';
    	p2.DenegarVentana = false;
   		p2.DenegarImagen = false;
     	p2.Ver_Imagen = 'prueba';
    	p2.result = false;
    	p2.nom_empleado = 'Prueba';
    	p2.cod_empleado = 'HN1235';
		p2.correoEmpleado = 'prueba@hotmail.com';
        p2.correoEmpleado2 = 'prueba@hotmail.com';
        p2.Busca2();
        p2.BuscaInfor2();
        p2.validatenum('prueba');
        
        controllerpignorados p3 = new controllerpignorados(); 
       	p3.cuentapig = '12345';
    	p3.id_pign = '0801199717795';
    	p3.usuario = 'HN17795';
   		p3.nombrepig = 'Prueba';
    	p3.num_prest = '432895958';
    	p3.tama = 1;
    	p3.cod_obj = 'a1A0t00000B54hdEAB';
    	p3.total = 1;
    	p3.MuestraTabla = false; 
        p3.Motivo = 'Prueba';
    	p3.DenegarVentana = false;
   		p3.DenegarImagen = false;
     	p3.Ver_Imagen = 'prueba';
    	p3.result = false;
    	p3.nom_empleado = 'Prueba';
    	p3.cod_empleado = 'HN1235';
		p3.correoEmpleado = 'prueba@hotmail.com';
        p3.correoEmpleado2 = 'prueba@hotmail.com';
        p3.Busca2();
        p3.BuscaInfor2();
        p3.validatenum('354646');
        
        controllerpignorados p4 = new controllerpignorados(); 
       	p4.cuentapig = '12345';
    	p4.id_pign = '';
    	p4.usuario = 'HN17795';
   		p4.nombrepig = 'Prueba';
    	p4.num_prest = '34224423';
    	p4.tama = 1;
    	p4.cod_obj = 'a1A0t00000B54hdEAB';
    	p4.total = 1;
    	p4.MuestraTabla = false; 
        p4.Motivo = 'Prueba';
    	p4.DenegarVentana = false;
   		p4.DenegarImagen = false;
     	p4.Ver_Imagen = 'prueba';
    	p4.result = false;
    	p4.nom_empleado = 'Prueba';
    	p4.cod_empleado = 'HN1235';
		p4.correoEmpleado = 'prueba@hotmail.com';
        p4.correoEmpleado2 = 'prueba@hotmail.com';
        p4.Busca3();
        p4.BuscaInfor3();
        p4.validateid('prueba');
        
        controllerpignorados p5 = new controllerpignorados(); 
       	p5.cuentapig = '12345';
    	p5.id_pign = '0801199717795';
    	p5.usuario = 'HN17795';
   		p5.nombrepig = 'Prueba';
    	p5.num_prest = '432895958';
    	p5.tama = 1;
    	p5.cod_obj = 'a1A0t00000B54hdEABgffgfdg45454';
    	p5.total = 1;
    	p5.MuestraTabla = false; 
        p5.Motivo = 'Prueba';
    	p5.DenegarVentana = false;
   		p5.DenegarImagen = false;
     	p5.Ver_Imagen = 'prueba';
    	p5.result = false;
    	p5.nom_empleado = 'Prueba';
    	p5.cod_empleado = 'HN1235';
		p5.correoEmpleado = 'prueba@hotmail.com';
        p5.correoEmpleado2 = 'prueba@hotmail.com';
        p5.Busca3();
        p5.BuscaInfor3();
        p5.validateid('354646');
       
        
        controllerpignorados p6 = new controllerpignorados(); 
       	p6.cuentapig = '12345';
    	p6.id_pign = '0801199717795';
    	p6.usuario = 'HN17795';
   		p6.nombrepig = 'Prueba';
    	p6.num_prest = '432895958';
    	p6.tama = 1;
    	p6.cod_obj = 'a1A0t00000B54hdEAB';
    	p6.total = 1;
    	p6.MuestraTabla = false; 
        p6.Motivo = 'Prueba';
    	p6.DenegarVentana = false;
   		p6.DenegarImagen = false;
     	p6.Ver_Imagen = 'prueba';
    	p6.result = false;
    	p6.nom_empleado = 'Prueba';
    	p6.cod_empleado = 'HN1235';
		p6.correoEmpleado = 'prueba@hotmail.com';
        p6.correoEmpleado2 = 'prueba@hotmail.com';
        
        classActualizaPignorados s = new classActualizaPignorados();
        s.numero_prestamo='32321321';
        s.monto_pignorado = 23131;
        s.fechapignoracion = date.today()+3;
        s.fechaliberacion = date.today()+3;
        s.numero_prestamo1 = '231312';
        s.total_fondos = 23423;
        s.monto_prestamo = 233231;
        s.estatus = 'x';
        s.usuario = 'hn123141';
        s.secuencia = 235;
        s.codcuenta = '111111';
        s.referencia = 'prueba';
        p6.Enviar();
        
        
        
        
        p6.validateid('354646');
        
        
		
     	
        classActualizaPignorados env = new classActualizaPignorados();
       	ControllerAPIPignorados.ActualizarPignorados(env); 
       	
        
        Fondo_Pignorado__c archivo = new Fondo_Pignorado__c  ();
        archivo.Numero_Prestamo__c = '08234344';
        archivo.Num_Prestamo__c = '08234344';
        archivo.Monto_Pignorado__c = 3234335;
        archivo.Fecha_Pignoracion__c = date.today();
        archivo.Fecha_Liberacion__c = date.today();
        archivo.Monto_Prestamo__c = 12435435;
        archivo.Total_Fondos__c = 34545666;
        archivo.Usuario__c = 'HN19577';
        archivo.Estatus__c = 'A';
        archivo.Estado__c = 'P';
        archivo.Cuenta__c = '33999';    
        archivo.Descripcion__c = 'sdasadda';    
        insert archivo;
        
        Fondo_Pignorado__c xx = new Fondo_Pignorado__c (Id = 'a1A0t00000B54hdEAB', Numero_Prestamo__c = '08234344', Monto_Pignorado__c = 3234335, Fecha_Pignoracion__c = date.today(),
                                                             Fecha_Liberacion__c = date.today(), Monto_Prestamo__c = 12435435, Total_Fondos__c = 34545666,
                                                             Usuario__c = 'HN19577', Estatus__c = 'A', Estado__c = 'P', Cuenta__c = '33999');
       
        
        
        
    }
   
}