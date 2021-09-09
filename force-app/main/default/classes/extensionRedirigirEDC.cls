public with sharing class extensionRedirigirEDC {
	
    public extensionRedirigirEDC(ApexPages.StandardController Controller){}
    
    public pageReference redirigir(){
        try{
            String idCaso = ApexPages.currentPage().getParameters().get('id');
            Case caso = [Select Estado_Cuenta_Detallado__c,Account.Identificacion__c,Tipo_Estado_Cuenta__c,
            				Fecha_desde__c, Fecha_hasta__c 
            				From Case Where Id =: idCaso];
            
            String fDesde = String.valueOF(caso.Fecha_desde__c);
            String fHasta = String.valueOF(caso.Fecha_hasta__c);
            EstadosDeCuenta.varurl url= new EstadosDeCuenta.varurl();
            url.idcli=caso.Account.Identificacion__c;
            url.desde=fDesde;
            url.hasta=fHasta;
            string contenido =JSON.serialize(url);
            string hy = EncodingUtil.base64Encode(Blob.valueof(contenido));
            if(caso.Tipo_Estado_Cuenta__c == 'A2'){
            		return new pageReference('/apex/vfEDCmensual?zyx=' + caso.Account.Identificacion__c + '&fHasta=' + fHasta + '&fDesde='+fDesde);     
            }else if(caso.Estado_Cuenta_Detallado__c == 'General'){
                return new pageReference('/apex/vfEstadoDeCuenta?zyx='+ hy) ;    
            }else{
                return new pageReference('/apex/vfEstadoCuentaDetalleMovimientos?zyx='+ hy);  
            }           
        }Catch(Exception e){
            return null;    
        }
    }
}