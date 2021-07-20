@isTest
public class testAprobacionCambioAsesorBanco {
    
	static testMethod void ControllerAprobacionCambioAsesorBanco()
        {
           ControllerAprobacionCambioAsesorBanco a = new  ControllerAprobacionCambioAsesorBanco();
           Cambio_Asesor_Banco__c aa = new Cambio_Asesor_Banco__c();
           Pantalla_Cambio_Asesor_Banco__c aaa = new Pantalla_Cambio_Asesor_Banco__c();
          // Usuarios_de_Pantallas__c aaa = new Usuarios_de_Pantallas__c();
           //Oficial_de_negocios__c b  = new Oficial_de_negocios__c();
           //Bitacora_Cambio_Asesor_Banco__c aaaa = new Bitacora_Cambio_Asesor_Banco__c();
            
            //variables
            a.codCuenta = '1230';
            a.buscacuenta='1230';
            a.nombreCliente = 'Adolfito';
           // a.nuevoCodAsesor = '1803';
           // a.nuevoNombreAsesor = 'Daniel';
           // a.nuevaAgencia= '2120';
            a.DenegarVentana = True;
            a.DenegarImagen = False;
            a.contador = 1;
            a.tama = 1;
            a.MuestraTabla = True;
            a.FCsysde = date.newInstance(2020, 03, 13);
            //a.opciones = null;
            a.estado='APROBADO';
            a.Usuario='Erick';
            a.ListData.add(aa);
            a.ListData[0].Cuenta__c = a.codCuenta;
            a.ListData[0].Nombre_Cliente__c = a.nombreCliente;
            a.ListData[0].Nuevo_Codigo_Asesor__c = a.nuevoCodAsesor;
            a.ListData[0].Nuevo_Nombre_Asesor__c = a.nuevoNombreAsesor;
            a.ListData[0].Nueva_Agencia__c = a.nuevaAgencia;
                  
            
            //metodos
            a.BuscaCuentas();
            a.mostrarTabla();
            a.Actualizar();
            a.limpiar();
            a.LimpiarTabla();
            a.Cancelar();
            a.popSalirImagen();
            a.popDenegarSalir();
            a.Denegar();
            a.Aprobar();
            a.mostrarDenegar();
            //a.Listdata = new List <classActualizarAsesorBanco> ();
            
             ClassCambioAsesorBanco t = new  ClassCambioAsesorBanco();
            
             classActualizarAsesorBanco s = new  classActualizarAsesorBanco();
             s.codCuenta= '25286';
             s.nuevoCodAsesor = '1803';
             s.nuevoNombreAsesor = 'Daniel';
             s.nuevaAgencia= '2120';
             s.estado='APROBADO';
             s.Usuario='Erick';
           
            //classActualizarAsesorBanco env = new classActualizarAsesorBanco();
            //ControllerApiCambioAsesorBanco.ActualizarCambioAsesor(env);
            

        }
}