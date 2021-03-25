global class testMocks implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest req) {
        HTTPResponse res = new HTTPResponse();
        res.setHeader('Content-Type', 'application/json'); 
        res.setStatusCode(200);
        res.setStatus('OK');
        
        if(req.getEndpoint().endsWith('trimestral')) {      
            res.setBody('[{"fecha":"2017-10-15","nombreCliente":"Fran Oseguera","identidad":"12345","cuentas":[{"moneda":"HNL","grafico":"400px"}]}]');
            
        }else if(req.getEndpoint().endsWith('portada')) {      
            res.setBody('[{"fechaCierre":"2017-10-15","nombreCliente":"Fran Oseguera","identidad":"12345"}]');
            
        }else if(req.getEndpoint().endsWith('mensual')) {      
            res.setBody('test');
            
        }else if(req.getEndpoint().endsWith('historico')) {      
            res.setBody('[ { "fecha": "31/03/2020", "nombreCliente": "Test", "emailCliente": "test@test.com", "numeroCliente": "221312", "rendimientoLempiras": "5%", "rendimientoDolares": "6%", "movimientos": [ { "moneda": " Dólares", "cuenta": "33178", "totalPersonal": "19,703.17", "totalPatronal": "0.00", "granTotal": "19,703.17", "transacciones": [ { "fecha": "01/01/2020", "descripcionTransaccion": "Saldo Acumulado al 01/01/2020", "aportePersonal": "12,308.25", "aportePatronal": "0.00", "aporteTotal": "12,308.25" } ] } ] } ]');
            
        }else if(req.getEndpoint().endsWith('tasa')) {      
            res.setBody('23.5');
            
        }else if(req.getEndpoint().contains('validar')) {      
            res.setBody('True');
            
        }else{
            res.setBody('[{"emailCliente":"fran@intellect.com","nombreCliente":"Fran Oseguera","identidad":"12345","fpcTrabajo":"100","misAportes":"10","miEmpleador":"10","fechaAcumulado":"1345","saldoAcumulado":"10","grafico":"12341"}]');
        }
            
        system.debug('Cuerpo Mock: ' + res);
        return res;
    }
}