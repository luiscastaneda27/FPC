public class controllerApiMatrizdeRiesgo {
    public static ClaseNivelDeRiesgo ConsultaNivelDRiesgo(decimal CodRiesgo) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaNivelRiesgo/'+ CodRiesgo);
        ClaseNivelDeRiesgo fcsd= new ClaseNivelDeRiesgo();
        string respuesta = '';
        system.debug('Entro al REST de NIVELRIESGO');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (ClaseNivelDeRiesgo)System.JSON.deserialize(response.getBody(), ClaseNivelDeRiesgo.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }
    
    public static FactorClase ConsultaFactor(string Cod_Riesgo) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaFactor/'+ Cod_Riesgo);
        FactorClase fcsd= new FactorClase();
        string respuesta = '';
        system.debug('Entro al REST de Factores');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (FactorClase)System.JSON.deserialize(response.getBody(), FactorClase.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }
    
    public static ClaseTipoCliente ConsultaTipoCliente(string TipoCliente) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaTipoCliente/'+ TipoCliente);
        ClaseTipoCliente fcsd= new ClaseTipoCliente();
        string respuesta = '';
        system.debug('Entro al REST TIPOCLIENTE');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (ClaseTipoCliente)System.JSON.deserialize(response.getBody(), ClaseTipoCliente.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }
    
    public static ClaseTipoPersona ConsultaTipoPersona(string TipoPersona) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaTipoPersona/'+ TipoPersona);
        ClaseTipoPersona fcsd= new ClaseTipoPersona();
        string respuesta = '';
        system.debug('Entro al REST TIPOPERSONA');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (ClaseTipoPersona)System.JSON.deserialize(response.getBody(), ClaseTipoPersona.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }
    
    public static ClaseFechaNac ConsultaFechaNac(string CodFechaNacimiento) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaFechaNac/'+ CodFechaNacimiento);
        ClaseFechaNac fcsd= new ClaseFechaNac();
        string respuesta = '';
        system.debug('Entro al REST FECHANAC');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (ClaseFechaNac)System.JSON.deserialize(response.getBody(), ClaseFechaNac.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }
    
    public static ClaseFechaAfilia ConsultaFechaAfilia(string CodFechaAfilia) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaFechaAfilia/'+ CodFechaAfilia);
        ClaseFechaAfilia fcsd= new ClaseFechaAfilia();
        string respuesta = '';
        system.debug('Entro al REST FECHAAFILIA');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (ClaseFechaAfilia)System.JSON.deserialize(response.getBody(), ClaseFechaAfilia.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }

    public static ClaseTipDoc ConsultaTipDoc(string TipoDoc) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaTipDoc/'+ TipoDoc);
        ClaseTipDoc fcsd= new ClaseTipDoc();
        string respuesta = '';
        system.debug('Entro al REST TIPODOC');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (ClaseTipDoc)System.JSON.deserialize(response.getBody(), ClaseTipDoc.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }    
    
    public static claseFactoresDeRiesgo ConsultaFactorRiesgo(string TipoCliente) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaFactorRiesgo/'+ TipoCliente);
        claseFactoresDeRiesgo fcsd= new claseFactoresDeRiesgo();
        string respuesta = '';
        system.debug('Entro al REST de NIVELRIESGO');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (claseFactoresDeRiesgo)System.JSON.deserialize(response.getBody(), claseFactoresDeRiesgo.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }    
    
    public static ClaseTrabaja ConsultaTrabaja(string Trabaja) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaTrabaja/'+ Trabaja);
        ClaseTrabaja fcsd= new ClaseTrabaja();
        string respuesta = '';
        system.debug('Entro al REST de TRABAJA');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (ClaseTrabaja)System.JSON.deserialize(response.getBody(), ClaseTrabaja.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }    
    
    public static ClasePep ConsultaPep(string PEP) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaPep/'+ PEP);
        ClasePep fcsd= new ClasePep();
        string respuesta = '';
        system.debug('Entro al REST de PEP');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (ClasePep)System.JSON.deserialize(response.getBody(), ClasePep.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }    
    
    public static ClaseExcepciones ConsultaExcep(string EsExcep) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaExcep/'+ EsExcep);
        ClaseExcepciones fcsd= new ClaseExcepciones();
        string respuesta = '';
        system.debug('Entro al REST de PEP');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (ClaseExcepciones)System.JSON.deserialize(response.getBody(), ClaseExcepciones.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }    
    
    public static ClaseRiesgoProducto ConsultaProducto(string TipoProducto) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaProducto/'+ TipoProducto);
        ClaseRiesgoProducto fcsd= new ClaseRiesgoProducto();
        string respuesta = '';
        system.debug('Entro al REST Producto');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (ClaseRiesgoProducto)System.JSON.deserialize(response.getBody(), ClaseRiesgoProducto.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }    
    
     public static ClaseRiesgoCanal ConsultaCanal(string TipoCanal) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaCanal/'+ TipoCanal);
        ClaseRiesgoCanal fcsd= new ClaseRiesgoCanal();
        string respuesta = '';
        system.debug('Entro al REST Producto');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (ClaseRiesgoCanal)System.JSON.deserialize(response.getBody(), ClaseRiesgoCanal.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }    
    
    public static ClaseRiesgoProfesion ConsultaProfesion(string TipoProfesion) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaProfesion/'+ TipoProfesion);
        ClaseRiesgoProfesion fcsd= new ClaseRiesgoProfesion();
        string respuesta = '';
        system.debug('Entro al REST Profesion');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (ClaseRiesgoProfesion)System.JSON.deserialize(response.getBody(), ClaseRiesgoProfesion.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }    
   
     public static ClaseRiesgoActEcon ConsultaActEcono(string TipoActividad) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaActEcono/'+ TipoActividad);
        ClaseRiesgoActEcon fcsd= new ClaseRiesgoActEcon();
        string respuesta = '';
        system.debug('Entro al REST Actividad');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (ClaseRiesgoActEcon)System.JSON.deserialize(response.getBody(), ClaseRiesgoActEcon.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }    
    
    public static ClaseFechaConsti ConsultaFechaConst(string CodFechaConstitu) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaFechaConst/'+ CodFechaConstitu);
        ClaseFechaConsti fcsd= new ClaseFechaConsti();
        string respuesta = '';
        system.debug('Entro al REST FEcha Const');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (ClaseFechaConsti)System.JSON.deserialize(response.getBody(), ClaseFechaConsti.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }    
    
    public static ClaseRiesgoGeografico ConsultaRiesgoGeo(string CodDepto, string codNacionalidad) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('GET');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaRiesgoGeo/'+CodDepto+ '/' + codNacionalidad);
		ClaseRiesgoGeografico fcsd= new ClaseRiesgoGeografico();
		string respuesta = '';
		system.debug('Entro al REST del EDC');
		try{
HttpResponse response =new HttpResponse();// http.send(request);
			 if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
	    	respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
           {
                
               
	            fcsd = (ClaseRiesgoGeografico)System.JSON.deserialize(response.getBody(), ClaseRiesgoGeografico.class);
               
           }
            
		}catch(System.CalloutException e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());
	
        }Catch(Exception e){
			system.debug(e.getMessage()+'   '+e.getLineNumber());	
		} 
        
        system.debug('debuggAPI' +' '+ fcsd);
		return fcsd;   
    }
    
     public static claseFactoresDeRiesgo ConsultaVariablesFactor(string TipoCliente) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ConsultaVariablesFactor/'+ TipoCliente);
        claseFactoresDeRiesgo fcsd= new claseFactoresDeRiesgo();
        string respuesta = '';
        system.debug('Entro al REST de NIVELRIESGO');
        try{
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            
            //fcsd = respuesta.split(',');
            system.debug('debuggRespuesta' +''+ respuesta); 
            
            if (response.getStatusCode() == 200) 
            {
                
                fcsd = (claseFactoresDeRiesgo)System.JSON.deserialize(response.getBody(), claseFactoresDeRiesgo.class);
                
            }
            
        }catch(System.CalloutException e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());
            
        }Catch(Exception e){
            system.debug(e.getMessage()+'   '+e.getLineNumber());	
        } 
        
        system.debug('debuggAPI' +' '+ fcsd);
        return fcsd;   
    }
    
       
    public static String ActualizaNivelDRiesgo(classActualizaNivelRiesgo claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ActualizaNivelRiesgo');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizarRIESGONIVEL');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  
    
    public static String ActualizaTipoCliente(classActualizaTipoCliente claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ActualizaTipoCliente');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizarRIESGONIVEL');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  
    
    public static String ActualizaTipoPersona(classActualizaTipoPersona claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ActualizaTipoPersona');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizar TIPOPERSONA');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  
    
    public static String ActualizaFechaNac(classActualizaFechaNac claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ActualizaFechaNac');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizar FECHANAC');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  
    
    public static String ActualizaFechaAfilia(classActualizaFechaAfilia claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ActualizaFechaAfilia');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizar FECHAAFILIA');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  
    
    public static String ActualizaTipoDoc(classActualizaTipDoc claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ActualizaTipoDoc');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizar TIPODOC');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  
    
    public static String ActualizaRiesTrabaja(classActualizaTrabaja claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ActualizaTrabaja');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizar TRABAJA');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  

    public static String ActualizaRiesPep(classActualizaPep claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ActualizaPep');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizar PEP');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  
    
    public static String actualizaExcep(classActualizaExcep claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ActualizaExcep');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizar EXCEP');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  
    
    public static String actualizaProducto(classActualizaProducto claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/actualizaProducto');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizar PRODUCTO');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  
    
     public static String actualizaCanal(classActualizaCanal claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/actualizaCanal');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizar CANAL');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  
    
     public static String actualizaProfesion(classActualizaProfesion claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/actualizaProfesion');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizar PROFESION');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  
    
    public static String actualizaActEcon(classActualizaActEcon claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/actualizaActEcon');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizar ACTIVIDAD');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  

    public static String actualizaFechaCons(classActualizaFechaConsti claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/actualizaFechaCons');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizar FechaCons');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  
    
     public static String actualizaGeogra(ClassActualizaRiesgoGeo claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/actualizaGeogra');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizar GEOGRAFICO');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  

    public static String actualizaVariablesFactor(controllerActualizaVarFactor claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/actualizaVariablesFactor');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizar VarFactor');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  
    
    public static String ActualizaFactor(ClassActualizaFactor claseEnvio) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');		
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setTimeout(120000);
        request.setEndpoint(url + 'api/ActualizaFactor');
        
        String respuesta = '';
        system.debug('Entro al REST del EDC actualizar VarFactor');
        try{
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);		
            request.setBody(cons);	
            HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
            respuesta = response.getBody();
            system.debug(respuesta);      
        }catch(System.CalloutException e){
            system.debug(e.getMessage());
            
        }Catch(Exception e){
            system.debug(e.getMessage());	
        } 
        return respuesta;   
    }  
    
    public static String InsertaNivelDRiesgo(ClassInsertaNivelDeRiesgo claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/InsertaNivelRiesgo');
		
		String respuesta = '';
		system.debug('Entro al REST del EDC InsertaRIESGONIVEL');
		try{
						
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
			HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
          	respuesta = response.getBody();
            system.debug(respuesta);      
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return respuesta;   
    }
  
    public static String InsertaFactor(FactorClase claseEnvio) {
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');		
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
		request.setTimeout(120000);
		request.setEndpoint(url + 'api/InsertaFactor');
		
		String respuesta = '';
		system.debug('Entro al REST del EDC InsertaRIESGONIVEL');
		try{
						
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);		
			request.setBody(cons);	
			HttpResponse response =new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('');
            }
          	respuesta = response.getBody();
            system.debug(respuesta);      
		}catch(System.CalloutException e){
			system.debug(e.getMessage());
	
        }Catch(Exception e){
			system.debug(e.getMessage());	
		} 
		return respuesta;   
    }
}