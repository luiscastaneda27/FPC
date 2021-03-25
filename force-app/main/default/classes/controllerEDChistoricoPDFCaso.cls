public class controllerEDChistoricoPDFCaso {
    
    public classECHistorico cuentas{get;set;}
    public Boolean rendimientoHNL {get;set;}
    public Boolean rendimientoUSD {get;set;}
    public controllerEDChistoricoPDFCaso(ApexPages.StandardController controller){
        
        try{
            rendimientoHNL = false;
            rendimientoUSD = false;
            string idCaso = controller.getId();
            case caso= [Select Fecha_Desde__c,Account.Identificacion__c, Account.PersonContactId ,
                        Account.Name,Account.PersonEmail, Fecha_Hasta__c,
                        Estado_de_Cuenta_Historico__c
                        From Case Where Id =: idCaso];
           // string contenido = caso.Estado_de_Cuenta_Historico__c;
            list<classClientesEC> claseEnvio = new list<classClientesEC>();
            classClientesEC nueva = new classClientesEC();
            nueva.idCliente = caso.Account.Identificacion__c;
            nueva.Desde = caso.Fecha_Desde__c;
            nueva.hasta = caso.Fecha_hasta__c;
            claseEnvio.add(nueva);
            cuentas = EstadosDeCuenta.estadoCuentaHistorico(claseEnvio)[0];
            for(classECHistorico.classMovimientos item : cuentas.movimientos){
                rendimientoHNL =  item.moneda.trim() == 'Lempiras' ? true : RendimientoHNL;
                rendimientoUSD =  item.moneda.trim()== 'Dólares' ? true : RendimientoUSD;
            }
            
        }Catch(Exception e){
            system.debug('Error: '+e.getMessage()+', Linea: '+e.getLineNumber());
        }
    }
    
    
}