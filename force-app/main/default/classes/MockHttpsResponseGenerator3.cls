@isTest
global class MockHttpsResponseGenerator3 implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('http://190.5.68.11:9090/api/gestionesBac', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"tipoTarjeta":"","tipoGestion":"modificaDebito","sexo":"","servicio":"","numeroTarjeta":"","nombreTarjetaHabiente":"","nombreCliente":"","montoDebito":"0","identificacion":"0801399412010","fechaExpiracion":"","estadoDebito":"C","email":"","diaCobro":"26","cuentaPensiones":"87675","celular":"","bancoTarjeta":""}');
        res.setStatusCode(200);
        return res;
    }
}