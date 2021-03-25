@isTest
public class testCambioFechaAporte {
    
    static testMethod void Controllercambiofechaaporte()
    {
        Controllercambiofechaaporte p = new Controllercambiofechaaporte();
        classfechacambioaporte pp = new classfechacambioaporte();
          
       
        p.codCuenta ='104684';
        p.Usuario = 'hn1234';
        p.fechaporte = date.newInstance(2020, 03, 13);
        p.nombre = 'Prueba132';
        p.pcproducto = '01';
        p.pcsubproducto = '001';
        p.tama = 1;
        p.nuevafecha1 = date.today();
        p.nuevafecha = date.today();
		p.TipMoneda = null;
        p.opciones = null;
        p.num_doc = '1';
        p.MuestraTabla = true;
        p.contador= 1;
        p.FCsysde = date.newInstance(2020, 03, 13);
        p.referencia = null;
        p.observaciones = null;
        p.opcionSubproducto = null;
        p.correoEmpleado1 = null;
        p.correoEmpleado2 = null; 
        p.NombreUsuario = null;
        p.idEmail = '5654';
        p.referenciaImg = null;
            
        p.Busca();
        p.BuscaInfor();
        
        p.Actualizar();
        p.limpiar();
        p.limpiar1();
        p.LimpiarTabla();
        p.Cancelar();
        p.EnvioCorreo(); 
        p.enviar();
      
        
        Controllercambiofechaaporte p2 = new Controllercambiofechaaporte();
        p2.fechaporte = date.valueOf(dateTime.now());
        p2.codCuenta = '33999';
        p2.Busca();
        p2.BuscaInfor();
        //p2.Actualizar2();
		//p2.Actualizar1();
        p2.Actualizar();
        p2.Cancelar();
       
        Controllercambiofechaaporte p3 = new Controllercambiofechaaporte();
        p3.num_doc = '25323';
        p3.nuevafecha = date.valueOf(dateTime.now());
        p3.Busca();
        p3.BuscaInfor();
        //p3.Actualizar2();
        //p3.Actualizar1();
        //p3.Actualizar();
        p3.Cancelar();
        
        p3.ListFechaAct = new List <classfechacambioaporte> ();
        
        //Agregado 14/02
        classfechacambioaporte fe = new classfechacambioaporte();
        classfechacambioaporte fa = new classfechacambioaporte();
        fe.codCuenta = '3434';
        fe.nummov = 323;
        fe.tSaldo = 'sd';
        fe.montoPago = 34432;
    	fe.SubProducto = 'sds';
    	fe.descrip = 'dfsfs';
    	fe.nuevafecha = date.valueOf(dateTime.now());
    	fe.nombre = 'dfds';
     	fe.codProd = 'ddf';
    	fe.num_doc = 'dfsd';
        //nueva modificacion
        
        p3.FCsysde = date.newInstance(2020, 03, 13);
        p3.ListFechaAct.add(fe);
        p3.Actualizar();
        p3.Eliminar();
        
        classAcualizaFechaAporte s = new classAcualizaFechaAporte();
        s.numDocumento = 'sdda';
        s.nuevafecha = date.valueOf(dateTime.now());
       
        
        
        classAcualizaFechaAporte env = new classAcualizaFechaAporte();
        
        //classfechacambioaporte fcsdd = ControllerAPIFechCambioAporte.BuscarCuenta(p2.fechaporte, p2.codCuenta);
        ControllerAPIFechCambioAporte.Actualizarfecha(env);
        
        
       
    }
}