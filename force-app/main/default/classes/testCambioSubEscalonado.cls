@isTest (SeeAllData = true)
public class testCambioSubEscalonado {
    static testMethod void ControllerSubEscalonado()
    {
        //test.startTest();
        classSubprEscal naturalEnvio3 = new classSubprEscal();        
        cuentasSubp naturalEnvio2 = new cuentasSubp();       
        naturalEnvio2.cuenta = '33959';
        classCambioSubproducto naturalEnvio = new classCambioSubproducto(); 
        ControllerSubEscalonado c = new ControllerSubEscalonado();        
        c.Listcuentas = new List <cuentasSubp> ();
        
        
        
        string sub = 'FPC01';
        
        naturalEnvio3 = controllerApiSubEscalonado.consultaSub(sub);
        
        ControllerSubEscalonado.cambioSubEsc1();
        ControllerSubEscalonado.cambioSubEsc2();
        ControllerSubEscalonado.cambioSubEsc3();
        ControllerSubEscalonado.cambioSubEsc4();
        
        //c.Listcuentas = naturalEnvio2;
        
        //for (cuentasSubp item:c.Listcuentas){
            
            naturalEnvio.accion = 'A2';
            naturalEnvio.cuenta = null;
            naturalEnvio.cuentaColectiva = null;
            naturalEnvio.subproducto = 'FPC01';
            naturalEnvio.usuario = null; 
            
            controllerApiSubEscalonado apii = new controllerApiSubEscalonado(); 
            controllerApiSubEscalonado.CambioSub(naturalEnvio); 
        //}
        
        //update c.Listcuentas.va ;
        
        
    }
}