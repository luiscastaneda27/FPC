public class controllerEDChistoricoPDFCaso {
    
    public classECHistorico cuentas{get;set;}
    public Boolean rendimientoHNL {get;set;}
    public Boolean rendimientoUSD {get;set;}
    
    public String textoFecha {get;set;}
    public String textoRendimientoHNL {get;set;}
    public String textoRendimientoUSD {get;set;}
    
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
            classClientesEC nueva = new classClientesEC();
            for(Cuentas__c item: [Select Fecha_Apertura__c from Cuentas__C where Fecha_Apertura__c != null And Cliente__r.Identificacion__c = :caso.Account.Identificacion__c order by Fecha_Apertura__c asc limit 1]){
                nueva.desde = item.Fecha_Apertura__c;
            }
            for(FechaDC_Sysde__c item: [Select Fecha_cierre__c From FechaDC_Sysde__c Where Name = 'CierreAlDia' Limit 1]){
                nueva.hasta = item.Fecha_cierre__c;
            }
            list<classClientesEC> claseEnvio = new list<classClientesEC>();
            nueva.idCliente = caso.Account.Identificacion__c;
            nueva.Desde = caso.Fecha_Desde__c != null ? caso.Fecha_Desde__c : nueva.Desde;
            nueva.hasta = caso.Fecha_Hasta__c != null ? caso.Fecha_Hasta__c : nueva.hasta;
            claseEnvio.add(nueva);
            cuentas = EstadosDeCuenta.estadoCuentaHistorico(claseEnvio)[0];
            for(classECHistorico.classMovimientos item : cuentas.movimientos){
                if(!rendimientoHNL && item.moneda.trim() == 'Lempiras' && cuentas.rendimientoLempiras != null
                       && !cuentas.rendimientoLempiras.contains('null')){
                        rendimientoHNL = true;
                    }else if(!rendimientoUSD && item.moneda.trim() == 'Dólares' && cuentas.rendimientoDolares != null 
                       && !cuentas.rendimientoDolares.contains('null')){
                        rendimientoUSD = true;
                    }
            }
            textoRendimientoHNL = 'Rendimiento del período seleccionado (HNL):';
            textoRendimientoUSD = 'Rendimiento del período seleccionado (USD):';
            if(nueva.desde != null && nueva.hasta != null){
                textoFecha = 'Período del';
                Integer diferencia =  (datetime.now().hourGMT() - datetime.now().hour()) > 0 ? 1 : 0;
                nueva.desde = nueva.desde.addDays(diferencia);
                cuentas.fecha = nueva.desde.day()+'/'+(nueva.desde.month()<10 ? '0'+nueva.desde.month() : ''+nueva.desde.month())+'/'+nueva.desde.year()+' al '+cuentas.fecha;
            }else{
                textoFecha = 'A la Fecha: ';
                textoRendimientoHNL = 'Rendimiento (HNL):';
                textoRendimientoUSD = 'Rendimiento (USD):';
            }
            System.debug('textoRendimientoUSD: '+textoRendimientoUSD);
        }Catch(Exception e){
            system.debug('Error: '+e.getMessage()+', Linea: '+e.getLineNumber());
        }
    }
    
    
}