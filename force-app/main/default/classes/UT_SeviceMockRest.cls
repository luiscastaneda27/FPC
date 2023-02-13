@isTest
public with sharing class UT_SeviceMockRest implements HttpCalloutMock {
    public String body {get;set;}
    public integer code {get;set;}
    public UT_SeviceMockRest(String b, integer c) {
        this.body = b;
        this.code = c;
    }
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse(); 
        res.setBody(this.body); 
        res.setStatusCode(this.code); 
        return res; 
    }
}