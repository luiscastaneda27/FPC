@isTest
global class MockHttpsResponseGenerator2 implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('http://190.5.68.11:9090/api/ConsultaInfoClienteC/45677876554', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"pc_codCuenta":"45677876554"}');
        res.setStatusCode(200);
        return res;
    }
}