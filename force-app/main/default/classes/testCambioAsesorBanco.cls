@isTest
public class testCambioAsesorBanco {
    
    static testMethod void ControllerCambioAsesorBanco()
    {
        ControllerCambioAsesorBanco p = new ControllerCambioAsesorBanco();
        ClassCambioAsesorBanco pp = new ClassCambioAsesorBanco();

        
        //declaracion de variables
        p.codCuenta ='104684';
        p.pccodCuenta = '1024684';
        p.nombreCliente = 'Ingris';
        p.pcsubproducto = '001';
        p.tama = 1;
        p.MuestraTabla = true;
        p.contador= 1;
        p.codAsesor = '8014'; 
     	p.nombreAsesor = 'Rodolfo';
     	p.agencia = 'Miraflores';
   
       
       // p.opcionSubproducto = NULL;
        
         // declaracion de metodos  
        p.Busca();
        p.BuscaInfor();
        p.Actualizar();
        p.limpiar();
        p.limpiar1();
        p.LimpiarTabla();
        p.Cancelar();
		
      	p.listcambioasesorbanco = new list <ClassCambioAsesorBanco> ();
        
        ControllerCambioAsesorBanco p2 = new ControllerCambioAsesorBanco();
        p2.codCuenta = '33999';
        p2.Busca();
        p2.BuscaInfor();
        p2.Actualizar();
        p2.Cancelar();
        
        ControllerCambioAsesorBanco p3 = new ControllerCambioAsesorBanco();
        p3.nuevaAgencia = 'Lomas';
        p3.nuevoCodAsesor = '345';
        p3.nuevoNombreAsesor = 'Peter';
        p3.Busca();
        p3.BuscaInfor();
        p3.Cancelar();
        p3.listcambioasesorbanco = new list <ClassCambioAsesorBanco>();
        
        ClassCambioAsesorBanco asesor = new ClassCambioAsesorBanco();
        asesor.agencia = '';
        asesor.codAsesor = '';
        asesor.codCuenta = '';
        asesor.estado = '';
        asesor.producto = '';
        asesor.fechaModificacion = null;
        
        
        
        //declaracion classcambioasesorbanco
        pp.nuevoCodAsesor = '154213';
    	pp.nuevoNombreAsesor = 'aaaaaa';
    	pp.nuevaAgencia = 'Mmmmmmm';
        
       classActualizarAsesorBanco env = new classActualizarAsesorBanco();
       ControllerApiCambioAsesorBanco.ActualizarCambioAsesor(env);
        
        
        
        
    }

}