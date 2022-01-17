@isTest
global class MockHttpsResponseGenerator4 implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('http://190.5.68.11:9090/api/gestionesBanco', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"tipoGestion":"afiliaDebito","identificacion":"103436","moneda":"LPS","fechaInicio":"2020-03-15","periodicidad":"M","cuentaBancaria":"200009330053","diaCobro":"D","montoDebito":"100"}');
        res.setStatusCode(200);
        return res;
    }
}