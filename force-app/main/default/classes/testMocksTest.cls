@isTest
public class testMocksTest {
    
    static testMethod void testMocks(){
        Test.setMock(HttpCalloutMock.class, new testMocks());
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ec/trimestral');
        
        testMocks test= new testMocks();
        test.respond(request);
        
        request.setEndpoint(url + 'api/ec/portada');
        test.respond(request);
        
        request.setEndpoint(url + 'api/ec/mensual');
        test.respond(request);
        
        request.setEndpoint(url + 'api/ec/historico');
        test.respond(request);
        
        request.setEndpoint(url + 'api/ec/tasa');
        test.respond(request);
        
        request.setEndpoint(url + 'api/ec/test');
        test.respond(request);
        
        request.setEndpoint(url + 'api/ec/validar');
        test.respond(request);
        
    }

}