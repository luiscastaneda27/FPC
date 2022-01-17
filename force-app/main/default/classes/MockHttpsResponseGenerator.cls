@isTest
global class MockHttpsResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('http://190.5.68.11:9090/api/aumentodisminucion', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"tipoSaldoMod":"10","periodicidad":null,"nuevoCanalAporte":null,"montoOperacion":0,"fecha":"2021-11-13T00:00:00.000Z","cuentaTarjeta":null,"cuenta":"87675","bitacora":[],"accion":"A7"}');
        res.setStatusCode(200);
        return res;
    }
}