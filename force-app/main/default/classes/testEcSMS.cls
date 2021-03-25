@isTest 
public class testEcSMS {
    
    static testMethod void controllerEcSMS()
    {
        
        test.startTest();
        
        controllerEcSMS sm = new controllerEcSMS();
        
        sm.cuentaColectiva = '';
        sm.cuentaIndividual = '';
        sm.subProducto = '';
        sm.identidad = '';
        sm.fechaHasta = date.today();
        sm.fechaHastaId = date.today();
        sm.fechaHastaCo = date.today();
        sm.fechaHastaSp = date.today();
        sm.mensaje = '';
        sm.celular = '';
        sm.nombre = '';
        sm.saldo = 1.0;
        
        sm.Iniciar();
        sm.enviaPINmas();
        sm.enviaECmas();
        sm.enviaPINid();
        sm.enviaECid();
        sm.enviaPINcolectiva();
        sm.enviaECcolectiva();
        sm.llenarSubproductos();
        sm.enviaPINsubproducto();
        sm.enviaECsubproducto();
        
        classEnvioECSMSmetod smet = new classEnvioECSMSmetod();
        smet.cColectiva = '';
        smet.cSubproducto ='';
        smet.fechaHasta = date.today();
        smet.idCliente = '';
        smet.Message = '';
        smet.Mobile = '';
        
        /*classSMSNueva smsn = new classSMSNueva();
        smsn.country = '';
        smsn.message = '';*/
        
               
        CelularesSMS c = new CelularesSMS('');
        
        controllerApiEcSMS k = new controllerApiEcSMS();
        
        string pruebaSMS = controllerApiEcSMS.enviarECmasivo(date.today());
        
        string pruebaSMS1 = controllerApiEcSMS.enviarECID('hola');
        
        string pruebaSMS2 = controllerApiEcSMS.enviarPINColectiva('hola'); 
        
        string pruebaSMS3 = controllerApiEcSMS.enviarECColectiva('hola'); 
        
        string pruebaSMS4 = controllerApiEcSMS.enviarPINSubproducto('hola'); 
        
        string pruebaSMS5 = controllerApiEcSMS.enviarECSubproducto('hola',date.today());
        
        //string pruebaSMS6 = controllerApiEcSMS.enviarSMSid(celular);
        
        classEnvioEcSMS s = new classEnvioEcSMS();
        s.cuentaColectiva = '';
        s.cuentaIndividual= '';
        s.subProducto= '';
        s.identidad= '';
        s.fechaHasta = date.today();
        s.fechaHastaId = date.today();
        s.fechaHastaCo = date.today();
        s.fechaHastaSp = date.today();
        s.mensaje = '';
        s.celular = '';
        s.nombre = '';
        s.saldo = 1.0;   
                       
        test.stopTest(); 
        
    }

}