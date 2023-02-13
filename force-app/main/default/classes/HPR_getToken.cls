/**
*Class Name: HPR_getToken
*Description: Clase paa obtener token de seguridad del servicio de Salesforce regional.
*Created Date: 19/01/2023 03:27 PM
*Created By: Cloud Code   
*Last Modified by: Cloud Code 30/01/2023 16:17 PM
*/
public class HPR_getToken {
    
    public static String getToken(String endPoint, String user, String pass) {
        
        String token;
        
        http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endPoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'text/xml');
        request.setHeader('SOAPAction','action');
        request.setTimeout(120000);
                       
        String SOAPXML = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:partner.soap.sforce.com">\n';       
        SOAPXML += '<soapenv:Body>\n';
        SOAPXML += '<urn:login>\n';
        SOAPXML += '<urn:username>'+user+'</urn:username>\n';
        SOAPXML += '<urn:password>'+pass+'</urn:password>\n';
        SOAPXML += '</urn:login>\n';
        SOAPXML += '</soapenv:Body>\n';
        SOAPXML += '</soapenv:Envelope>';
            
        System.debug('SOAPXML: '+SOAPXML);
           
        request.setBody(SOAPXML);
        HttpResponse response = http.send(request);
        
        System.debug('Respuestas: '+response.getBody());
                               
        String bodyXML = response.getBody(); //grab the body of the response
        XmlStreamReader reader = new XmlStreamReader(bodyXML); //construct an XmlStreamReader object
        while(reader.hasNext()) { //while there are more XML events
            if (reader.getEventType() == XmlTag.START_ELEMENT) { //if this is the opening tag
            	if ('sessionId' == reader.getLocalName()) { //if the tag is Afiliacion
                	while(reader.hasNext()) { //while there are more XML events
                    	if (reader.getEventType() == XmlTag.END_ELEMENT) { //if this is the closing tag
                        	break; //exist the loop
                       	} else if (reader.getEventType() == XmlTag.CHARACTERS) { //if this is the content between the tags
                        	token = reader.getText(); //grab the content
                        }
                        reader.next(); //advance to the next XML event
                    }
                }
            }
            reader.next(); //advance to the next XML event   
        }
        
        System.debug('El Token es: '+token);
        return token;
    
    }
    
}