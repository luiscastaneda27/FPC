global class verificarTipoCambioMoneda implements Schedulable{
    global void execute(SchedulableContext SC){
    	aSysdeCallouts.montoCambioDolar();
        /*try{
    		Decimal monto = aSysdeCallouts.montoCambioDolar();
    		Monto_cambio_dolar__c  tipoC = [Select Monto__c 
                                            From Monto_cambio_dolar__c 
                                            Where Name = 'MontoAlDia' Limit 1];
            tipoC.Monto__c = monto;
    		update tipoC;
    	}Catch(Exception e){
    		System.debug('Error en la clase de verificarTipoCambioMoneda');
    	}*/
    }

}