@isTest
public class testaprobarCambioFechaAporte {

    static testMethod void Controlleraprobarfechaaporte()
        {
            Controlleraprobarfechaaporte p = new Controlleraprobarfechaaporte();
            Cambio_de_Fecha__c pp = new Cambio_de_Fecha__c();
            Usuarios_de_Pantallas__c ppp = new Usuarios_de_Pantallas__c();
            
            p.codCuenta ='104684';
            p.Usuario = 'hn1234';
            p.fechaporte = date.newInstance(2020, 03, 13);
            p.nombre = 'Prueba132';
            p.pcproducto = '01';
            p.pcsubproducto = '001';
            p.tama = 1;
            p.TipMoneda = null;
            p.tipomoneda = null;
            p.opciones = null;
            p.num_doc = '1';
            p.MuestraTabla = true;
            p.contador= 1;
            p.FCsysde = date.newInstance(2020, 03, 13);
            p.accion = 'Actualizar';
            p.DenegarVentana = true;
            p.Motivo = null;
            p.opcionSubproducto = null;
            p.FCsysde = date.newInstance(2020, 03, 13);
            p.ListData.add(pp);
            p.ListData[0].Nombrecliente__c = p.nombre;
            p.ListData[0].Moneda__c = '1';
            p.ListData[0].num_doc__c = p.num_doc;
            p.correoEmpleado = null;
            p.NombreUsuario = null; 
            p.idEmail = '5654';
        	p.estadEmail = null;
            
            p.BuscaCuentas();
            p.mostrarTabla();
            p.Actualizar();
            p.MostrarImagen();
            p.popSalirImagen();
            p.popDenegarSalir();
            p.Aprobar();
            p.mostrarDenegar();
            p.limpiar();
            p.LimpiarTabla();
            p.Cancelar();
            p.enviar();
            p.Denegar();
            p.EnvioCorreo(); 
            
            
            classfechacambioaporte t = new classfechacambioaporte();
          
            classAcualizaFechaAporte s = new classAcualizaFechaAporte();
             s.numDocumento = 'sdda';
        s.nuevafecha = date.valueOf(dateTime.now());
           
        }
}