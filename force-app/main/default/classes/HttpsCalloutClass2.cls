public class HttpsCalloutClass2 {
    public static HttpResponse getInfoFromExternalService() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://190.5.68.11:9090/api/ConsultaInfoClienteC/45677876554');
        req.setMethod('GET');
        Http h = new Http();
        HttpResponse res = h.send(req);
        return res;
    }
}