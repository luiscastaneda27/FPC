@isTest
global class MockHttpsResponseGenerator6 implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('http://190.5.68.11:9090/api/valCuentaAh/1234', req.getEndpoint());
        System.assertEquals('GET', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"ACCOUNT_NUMBER":"200005453304","CUSTOMER_ID":"2262605","ACCOUNT_NAME":"LURVIN GERALDINA ACOSTA BANEGAS / PULPERIA MARY","CATEGORY":"6000","CURRENCY":"HNL","LIMIT_REF":"","RESTRICTIONS":"","ALT_ACCOUNT":"","OPENING_DATE":"20170622","OPERATION_TYPE":"Individual","ACCOUNT_OFFICER":"102901021464","BRANCH_CODE":"133500000000","LEGAL_ID":"0703198300026","REQUIRED_SIGNATURES":"1","SIGNATURE_DESC":"FIRMA UNICA","INACTIVE_MARKER":""}');
        res.setStatusCode(200);
        return res;
    }
}