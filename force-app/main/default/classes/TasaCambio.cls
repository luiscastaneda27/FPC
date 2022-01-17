public class TasaCambio {
    
    public static list<ValorDolar> traertasacambio(list<ValorDolar> resultado)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/retiros/tasaLista');
        request.setMethod('POST');
        request.setTimeout(120000);
        //list<ValorDolar> resultado = new list<ValorDolar>();
        try{
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(resultado);
            resultado = new list<ValorDolar>();
            String cons = 'contenido={"listValorDolar":'+envio.contenido+'}';
             //String cons = 'contenido='+envio.contenido;
            system.debug('Mandamos api/retiros/tasaLista: '+cons);
            request.setBody(cons);
            HttpResponse response =new HttpResponse();// http.send(request);  
            system.debug('Mandamos: '+request.getBody());
            if(!test.isRunningTest()){
                response = http.send(request); 
            }else{
                response.setBody('[{"fecha":"2019-05-23T00:00:00","ValorVenta":24.6357,"valorCompra":24.4644}]');
                response.setStatusCode(200);
            }
            system.debug('Respuesta: '+response.getBody());
            if (response.getStatusCode() == 200) {
                
                resultado = (list<ValorDolar>)System.JSON.deserialize(response.getBody().replace('T00:00:00',''), list<ValorDolar>.class);
                return resultado;
            }
        }Catch(Exception e){
            system.debug('Error: '+e.getMessage()+', Linea: '+e.getLineNumber());	
        }
        return resultado;
    }
	
    public class ValorDolar{
        public date fecha{get;set;}
        public decimal ValorVenta{get;set;}
        public decimal valorCompra{get;set;}
    }
}