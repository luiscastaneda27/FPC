public class aSysdePortalEmpresarial {
       
     public static classDolares.classRespuestaDolares CompraVentaDolares(string moneda, decimal monto, string cliente){
        classDolares.classRespuestaDolares respuesta = new classDolares.classRespuestaDolares();
        try{
            Compra_Venta_Dolares__mdt dato = new Compra_Venta_Dolares__mdt();
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            String url = claseUtilPlanillas.urlSysde('Test'); 
            request.setEndpoint(url + 'api/dolares');
            request.setMethod('POST');
            request.setTimeout(120000);
            classDolares claseEnvio = new classDolares();
            dato = [select Cuenta_Destino__c ,Cuenta_Origen__c ,
                    Nivel_Cinco__c , Nivel_Cuatro__c , Nivel_Dos__c ,
                    Nivel_Tres__c , Nivel_Uno__c 
                    from Compra_Venta_Dolares__mdt where DeveloperName =:moneda];
            //string body= 'cuentaOrigen='+dato.Cuenta_Origen__c;
            claseEnvio.cuentaOrigen = dato.Cuenta_Origen__c;
            claseEnvio.cuentaDestino = dato.Cuenta_Destino__c;
            claseEnvio.monto=''+monto;
            claseEnvio.moneda=moneda;
            claseEnvio.nivelUno=dato.Nivel_Uno__c;
            claseEnvio.nivelDos = dato.Nivel_Dos__c;
            claseEnvio.nivelTres = dato.Nivel_Tres__c;
            claseEnvio.nivelCuatro = dato.Nivel_Cuatro__c;
            claseEnvio.nivelCinco= dato.Nivel_Cinco__c;
            claseEnvio.detalle = cliente;
            
            classJson envio = new classJson();
            envio.contenido = Json.serialize(claseEnvio);
            string cons = 'Contenido='+envio.contenido;
            HttpResponse response =new HttpResponse();
            request.setBody(cons);
            system.debug('Mandamos: '+cons);
            if(!test.isRunningTest()){
                response = http.send(request); 
            }else{
                response.setBody('{"id":"FT19245XGNBL","monedaOrigen":"HNL","monedaDestino":"USD","montoDebitado":"100.00","montoAcreditado":"4.05","tasaCambio":"24.6945"}');
                response.setStatusCode(200);
            }
            system.debug('Codigo: '+response.getStatusCode());
            system.debug('Respuesta del servicio: '+response.getbody());
            if(response.getStatusCode() == 200){
                respuesta = (classDolares.classRespuestaDolares)System.JSON.deserialize(response.getBody(), classDolares.classRespuestaDolares.class);
                system.debug('Respuesta luego del status 200 Antes de Aplicar Parche: '+respuesta);           
                if(respuesta.montoAcreditado==null && respuesta.tasaCambio!=null && respuesta.montoDebitado!=null){
                    if(respuesta.monedaOrigen=='HNL'){
                        Decimal MontoAcr = Decimal.valueOf(respuesta.montoDebitado)/Decimal.valueOf(respuesta.tasaCambio);
                        respuesta.montoAcreditado = String.valueOf(MontoAcr.setScale(4));
                    }
                    if(respuesta.monedaOrigen=='USD'){
                        Decimal MontoAcr = Decimal.valueOf(respuesta.montoDebitado)*Decimal.valueOf(respuesta.tasaCambio);
                        respuesta.montoAcreditado = String.valueOf(MontoAcr.setScale(4));
                    }
                    
                }
                system.debug('Respuesta luego del status 200 Despues de Aplicar Parche: '+respuesta);
            }
        }catch(Exception ex){
            system.debug('Error ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());	
        }
        return respuesta;
    }
    
    public static list<string> fechaCierreSysde() { 
         Http http = new Http();  
         HttpRequest request = new HttpRequest();  
         String url = claseUtil.urlSysde('Test');   
         request.setEndpoint(url + 'api/cierre'); 
         request.setMethod('GET');  
         request.setHeader('Content-Type', 'application/x-www-form-urlencoded'); 
         request.setTimeout(120000); 
        list<string> fr = new list<string>();
         try{   
             HttpResponse response =new HttpResponse();// http.send(request);  
             if(!test.isRunningTest()){
                 response = http.send(request); 
             }
             else{
                 response.setBody('"2019-12-10T00:00:00"');
             }
              
             //System.debug('Respuesta '+response.getBody()); 
             string resp=string.valueOf(response.getBody());
             system.debug(resp);
             fr=resp.split('T');
             resp=fr[0];
             fr=resp.split('-');
             
         }catch(System.CalloutException e)
         { 
             system.debug(e.getMessage());  
         }    
        return fr;        
     }
    
    public static list<Account> agregarPersonaPlanilla(list<String> identificacionPersona) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtilPlanillas.urlSysde('Test'); 
        request.setEndpoint(url + 'api/personas');
        request.setMethod('POST');
		request.setTimeout(120000);
		list<classPersonas> resultado = new list<classPersonas>();
		list<Account> clientes = new list<Account>();
		
		try{
			list<classCenso> claseEnvio = new list<classCenso>();
			For(String item : identificacionPersona){
				classCenso nueva = new classCenso();
				nueva.identidad = item;
				claseEnvio.add(nueva);	
			}
			
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
			system.debug(cons);
			
			request.setBody(cons);
            
	         HttpResponse response =new HttpResponse();// http.send(request);  
             if(!test.isRunningTest()){
                 response = http.send(request); 
             }
             else{
                 response.setBody('[{"tipoIdentificacion":"0801199411013","sexo":null,"segundoNombre":"Hola","segundoApellido":null,"primerNombre":"cs","primerApellido":null,"identidad":null,"fechaNacimiento":null,"estadoCivil":null}]');
                 response.setStatusCode(200);
             }
	        if (response.getStatusCode() == 200) {
	            resultado = (list<classPersonas>)System.JSON.deserialize(response.getBody(), list<classPersonas>.class);
	            
	            for(classPersonas persona : resultado){
	            		Account empleado = new Account();
                    if(persona.primerNombre !='null' && persona.primerNombre !=null)  {
                        if(persona.segundoNombre != 'null' && persona.segundoNombre !=null){
                        	empleado.FirstName  = persona.primerNombre + ' ' + persona.segundoNombre;
                    	}else{
                            empleado.FirstName  = persona.primerNombre;
                        }
                        if(persona.segundoApellido !='null' && persona.segundoApellido !=null){
                        	 empleado.LastName  = persona.primerApellido + ' ' + persona.segundoApellido;
                    	}else{
                            empleado.lastName  = persona.primerApellido;
                        }
                        empleado.Identificacion__c = persona.identidad;
                        empleado.Tipo_Identificacion__c = persona.tipoIdentificacion;
                        empleado.Sexo__c = persona.sexo;
                        empleado.Estado_Civil__pc = persona.estadoCivil;
                        //empleado.Primer_Apellido__c  = persona.primerApellido;
                        //empleado.Segundo_Apellido__c = persona.segundoApellido;
                        empleado.PersonBirthDate = date.valueOF(persona.fechaNacimiento);
                        clientes.add(empleado); 
                    }
	            }        
	        }
	        system.debug(resultado);
	    
	    }catch(System.CalloutException e){
	    		system.debug('Error al hacer la consulta: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());   
        }Catch(Exception e){
        		system.debug('Error al traer persona: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
        }
         return clientes;
    }
    
    @future(callout=true)
    public static void traertasacambio()
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/tasa/' + datetime.now().month()+'-'+datetime.now().day()+'-'+datetime.now().year());
        request.setMethod('GET');
		request.setTimeout(120000);
        try{
            tasacambio r = new tasacambio();
	        HttpResponse response =new HttpResponse();// http.send(request);  
             if(!test.isRunningTest()){
                 response = http.send(request); 
             }
             else{
                 response.setBody('{"respuesta":{"codigo":200,"mensaje":"Tasa consultada correctamente para la fecha 10/01/2019"},"tasa":27.0}');
                 response.setStatusCode(200);
             }
            system.debug('Respuesta: '+response.getBody());
	        if (response.getStatusCode() == 200) {
	             r= (tasacambio)System.JSON.deserialize(response.getBody(), tasacambio.class);
                Tasa_De_Cambio__c tasac= new Tasa_De_Cambio__c();
                tasac=[select id, tasa__c,fecha__C from Tasa_De_Cambio__c];
                tasac.tasa__c=r.tasa;
                tasac.fecha__C=date.today();
                update tasac;

	        }
	       
        }Catch(Exception e){
        	system.debug('Error: '+e.getMessage());	
        }
    }
    
    // public static integer ConsultalAportesPatronales(list<String> identificacionPersona, string codigo_unico_banco) {
     public static list<claseaportaciones> ConsultalAportesPatronales(list<String> identificacionPersona, string codigo_unico_banco) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtilPlanillas.urlSysde('Test');
        request.setEndpoint(url + 'api/planillas/cuentas');
        request.setMethod('POST');
		request.setTimeout(120000);
		list<classRespuestaAportesCuenta> resultado = new list<classRespuestaAportesCuenta>();
		list<claseaportaciones> clientes = new list<claseaportaciones>();
		
		try{
            //return identificacionPersona.size();
			list<ClassPersona> claseEnvio = new list<ClassPersona>();
			For(String item : identificacionPersona){
				ClassPersona nueva = new ClassPersona();
				nueva.id = item;
				claseEnvio.add(nueva);	
			}
			 list<string> Cuentas = new list<string>();
             for(cuentas__c t:[select  id from CUENTAS__C WHERE CLIENTE__C = :Codigo_Unico_Banco]){
                   cuentas.add(t.id); 
             }
            list<Cuentas__C> listClientes2 = new list<Cuentas__C>();
            listClientes2=[select codigo__C from cuentas__C where Cuenta_colectiva2__c  in :cuentas];
            Cuentas = new list<string>();
            for(Cuentas__C t:listClientes2)
            {
                cuentas.add(t.codigo__C);
            }
            classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseEnvio);
			String cons = 'contenido=' + envio.contenido;
            system.debug(cons);
			request.setBody(cons);
	        HttpResponse response = new HttpResponse();//http.send(request); 
            if(!test.isRunningTest()){
                response = http.send(request);
            }
            else{
                response.setBody('{"respuesta":{"codigo":200,"mensaje":"Se procesaron 1 de 1 personas recibidas."},"aportes":[{"identificacion":"00000000000000","cuentas":[{"cuenta":"51600","aportePersonal":150.0,"aportePatronal":21.0},{"cuenta":"54428","aportePersonal":0.0,"aportePatronal":0.0},{"cuenta":"73932","aportePersonal":0.0,"aportePatronal":0.0},{"cuenta":"73933","aportePersonal":0.0,"aportePatronal":0.0}]}]}');
                response.setStatusCode(200);
            }
            system.debug('Respuesta Sysde '+response.getBody());
            if (response.getStatusCode() == 200) {
                prueba prueba2= new prueba();
                //system.debug('Sysde'+response.getBody());
                prueba2 = (prueba) JSON.deserialize(response.getBody(), prueba.class);
                //system.debug('Cantidad de afiliados que vienen'+prueba2.aportes.size());
               	resultado = prueba2.aportes;
                for(integer i=0; i<resultado.size(); i++){
	            	for(integer k=0; k<resultado[i].cuentas.size(); k++)
                    {
                        for(integer j =0; j<cuentas.size(); j++)
                        {
                            if(resultado[i].cuentas[k].cuenta ==cuentas[j])
                            {
                               clientes.add(new claseaportaciones(resultado[i].identificacion.replace('-', ''), 
                                                                  resultado[i].cuentas[k].cuenta,
                                                        		  resultado[i].cuentas[k].aportepatronal,
                                                                  resultado[i].cuentas[k].aportePersonal,
                                                        		  resultado[i].cuentas[k].aportePersonalEx,
                                                                  resultado[i].cuentas[k].aportePatronalEx,
                                                        		  resultado[i].cuentas[k].aporteSeguroVida,''));
                                
                            }
                        }
                    }
                 
                   
	            }        
	        }
	     list<Account> idsalesforce = new list<Account> ();
         idsalesforce = [select id, identificacion__c from Account where identificacion__c in :(identificacionPersona)]; 
         //system.debug(idsalesforce);
         for(integer i=0; i<clientes.size(); i++)
         {
            system.debug(clientes[i].Num_identidad);
             
              for(integer j=0; j<idsalesforce.size(); j++)
              {
                  if  (idsalesforce[j].identificacion__c == clientes[i].Num_identidad)
                  {
                      clientes[i].idsalesforce=idsalesforce[j].id;
                  }
              }
         }    
	    
	    }catch(System.CalloutException e){
	    		system.debug('Error al hacer la consulta: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());   
        }Catch(Exception e){
        		system.debug('Error al traer persona: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
        }
         system.debug('Mandamos: '+clientes);
         return clientes;
        //return null;
    }
    
    public class tasacambio{
        public string mensaje;
        public decimal tasa;
    }
   
    
    @future(callout=true)
    public static void cerrarPlanilla(set<Id> idPlanilla) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtilPlanillas.urlSysde('Test');
        request.setEndpoint(url + 'api/planillas');
        request.setMethod('POST');
        request.setTimeout(120000);
        
        list<classPlanilla> claseEnvio = new list<classPlanilla>();		
        list<Planilla__c> listPlanillas = new list<Planilla__c>();
        String estadoPlanilla = 'Cerrada';
        String msjSysde = '';
        
        try{
            listPlanillas = [Select Cantidad_empleados__c, Creado_por__c, Empresa2__r.Identificacion__c, Name,
                             Estado2__c, Fecha__c, createdDate, Tasa_compra__c,Tipo_planilla__c,
                             Total__c, TA_Empleado_Obligatorio__c, TA_Empleado_Voluntario__c, currencyIsoCode,
                             TA_Patrono_obligatorio__c, TA_Patrono_Voluntario__c, TA_Empleado_Extraordinario__c, 
                             TA_Patrono_Extraordinario__c, TA_Seguro_de_Vida__c, Total_obligatorios__c, Total_Reserva_Laboral2__c,
                             Total_voluntarios__c	
                             From Planilla__c
                             Where Id IN: idPlanilla];
            
            list<Contenido_Planilla__c> listContenido = [Select Aporte_Empleado_Obligatorio__c, Aporte_Empleado_Voluntario__c,
                                                         Aporte_Patrono_obligatorio__c, Aporte_Patrono_Voluntario__c, 
                                                         Aporte_Empleado_Extraordinario__c, Aporte_Patrono_Extraordinario__c, Aporte_Seguro_de_Vida__c, name,
                                                         Empleado2__r.Identificacion__c, Planilla__c, Planilla__r.Name,
                                                         Reserva_Laboral__c, Salario__c,
                                                         (Select Calcular_por__c, Cuenta__r.Codigo__c,
                                                          Valor_Monto__c,Valor_Monto_Patrono__c
                                                          From Cuentas_planilla__r)
                                                         From Contenido_Planilla__c
                                                         Where Planilla__c IN: idPlanilla];
            
            
            For(Planilla__c item: listPlanillas){
                classPlanilla itemPlanilla = new classPlanilla();
                itemPlanilla.codigo = item.Name;
                itemPlanilla.tipo = item.Tipo_planilla__c;
                itemPlanilla.empresa = item.Empresa2__r.Identificacion__c;
                itemPlanilla.fecha = item.Fecha__c;
                itemPlanilla.tasaCompra = item.Tasa_compra__c;
                itemPlanilla.tipoMoneda = item.currencyIsoCode;
                itemPlanilla.estado = item.Estado2__c;
                itemPlanilla.aportePatronalObligatorio = item.TA_Patrono_obligatorio__c;
                itemPlanilla.aportePatronalVoluntario = item.TA_Patrono_Voluntario__c;
                itemPlanilla.aportePersonalObligatorio = item.TA_Empleado_Obligatorio__c;
                itemPlanilla.aportePersonalVoluntario = item.TA_Empleado_Voluntario__c;
                //
                itemPlanilla.aportePersonalExtraordinario = item.TA_Empleado_Extraordinario__c;
                itemPlanilla.aportePatronalExtraordinario = item.TA_Patrono_Extraordinario__c;
                itemPlanilla.aporteSeguroVida = item.TA_Seguro_de_Vida__c;
                //
                itemPlanilla.reservaLaboral = item.Total_Reserva_Laboral2__c;
                itemPlanilla.total = item.Total__c;
                itemPlanilla.numeroEmpleados = integer.valueOF(item.Cantidad_empleados__c);
                
                list<classPlanilla.classContenidoPlanilla> claseEnvioContenido = new list<classPlanilla.classContenidoPlanilla>();
                For(Contenido_Planilla__c item2 : listContenido){
                    classPlanilla.classContenidoPlanilla itemContenido = new classPlanilla.classContenidoPlanilla();
                    itemContenido.codigoContenido = item2.Name;
                    itemContenido.identificacion = item2.Empleado2__r.Identificacion__c;
                    itemContenido.pilarComplementarioPatronal = item2.Aporte_Patrono_obligatorio__c;
                    itemContenido.pilarComplementarioPersonal = item2.Aporte_Empleado_Obligatorio__c;
                    itemContenido.pilarVoluntarioPatronal = item2.Aporte_Patrono_Voluntario__c;
                    itemContenido.pilarVoluntarioPersonal = item2.Aporte_Empleado_Voluntario__c;
                    //
                    itemContenido.pilarVoluntarioPersonalExt = item2.Aporte_Empleado_Extraordinario__c;
                    itemContenido.pilarVoluntarioPatronalExt = item2.Aporte_Patrono_Extraordinario__c;
                    itemContenido.pilarVoluntarioSeguroVida = item2.Aporte_Seguro_de_Vida__c;
                    //
                    itemContenido.reservaLaboral = item2.Reserva_Laboral__c;
                    itemContenido.salario = item2.Salario__c;
                    
                    list<classPlanilla.classCuentaPlanilla> claseEnvioCuentas = new list<classPlanilla.classCuentaPlanilla>();
                    For(Cuenta_planilla__c item3: item2.Cuentas_planilla__r){
                        classPlanilla.classCuentaPlanilla itemCuenta = new classPlanilla.classCuentaPlanilla();
                        itemCuenta.tipoDeduccion = item3.Calcular_por__c;
                        itemCuenta.cuenta = item3.Cuenta__r.Codigo__c;
                        itemCuenta.montoPatronal = item3.Valor_Monto_Patrono__c;
                        itemCuenta.montoPersonal = item3.Valor_Monto__c;
                        
                        claseEnvioCuentas.add(itemCuenta);	
                    }	
                    itemContenido.cuentas = claseEnvioCuentas;
                    claseEnvioContenido.add(itemContenido);
                }
                
                itemPlanilla.contenido = claseEnvioContenido;
                claseEnvio.add(itemPlanilla);	
            }
            
            
            classJson envio = new classJson();
            envio.contenido = JSON.serialize(claseEnvio);
            String cons = 'contenido=' + envio.contenido;
            system.debug(cons);
            
            request.setBody(cons);
            HttpResponse response = http.send(request);
            
            msjSysde = response.getBody();
            system.debug(msjSysde);
            
        }catch(System.CalloutException e){
            system.debug('Error al hacer la consulta: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            estadoPlanilla = 'Error con Sysde';
            msjSysde = e.getMessage();
            
        }Catch(Exception e){
            system.debug('Error al traer persona: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
            estadoPlanilla = 'Error con Sysde';
            msjSysde = e.getMessage();
        }
        try{
            listPlanillas[0].Respuesta_desde_Sysde__c = msjSysde;
            listPlanillas[0].Estado2__c = estadoPlanilla;
            claseUtil.stopTrigger();
            
            update listPlanillas[0];
        }Catch(Exception e){
            
        }
        
        
    }
    
    @future(callout=true)
    Public static void EnviarAportesEmpleados(string personas, integer periodoAporte, datetime fecha, string idpla, string rezago, string codigo)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtilPlanillas.urlSysde('Test');
        request.setEndpoint(url + 'api/planillas/aportes');
        request.setMethod('POST');
        request.setHeader('Content-Type','application/x-www-form-urlencoded');
		request.setTimeout(120000);
        try
        {
           system.debug('String: '+ personas); 
           list<string> todos= new list<string>();
           list<string> individual; 
            todos=personas.split('::::');
            list<classAportesPlanilla> claseenvio = new list<classAportesPlanilla>();
            classAportesPlanilla nueva;
            for(integer i=0; i<todos.size(); i++)
            {
                individual = new list<string>();
                nueva = new classAportesPlanilla();
                string gt=todos[i];
                individual=gt.split(',');
                nueva = new classAportesPlanilla();
                nueva.idSalesforce = individual[0];
                nueva.identificacion=individual[1];
                nueva.cuentaColectiva =individual[2];
                nueva.rezago= rezago;
                nueva.codigoReferencia = codigo;
                nueva.cuenta=individual[3];
                //nueva.codigoCuenta=integer.valueOf(individual[4]);
                
                nueva.codigoMoneda=individual[5];
                
                boolean bandera = false;
                if(decimal.valueOf(individual[6]) > 0){
                    nueva.aportePersonalVoluntario=decimal.valueOf(individual[6]);
                    bandera = true; 
                }
                if(decimal.valueOf(individual[7]) > 0) {
                    nueva.aportePatronalVoluntario=decimal.valueOf(individual[7]); 
                    bandera = true;
                }
                if(decimal.valueOf(individual[8]) > 0) {
                    nueva.aportePersonalObligatorio=decimal.valueOf(individual[8]);
                    bandera = true;
                }
                if(decimal.valueOf(individual[9]) > 0) {
                    nueva.aportePatronalObligatorio=decimal.valueOf(individual[9]);
                    bandera = true;
                }
                //
                if(decimal.valueOf(individual[10]) > 0) {
                    nueva.aportePersonalExtraordinario=decimal.valueOf(individual[10]);
                    bandera = true;
                }
                if(decimal.valueOf(individual[11]) > 0){
                    nueva.aportePatronalExtraordinario=decimal.valueOf(individual[11]);
                    bandera = true;
                }
                if(decimal.valueOf(individual[12]) > 0){
                    nueva.aporteSeguroVida=decimal.valueOf(individual[12]);
                    bandera = true;
                }
                
                
                nueva.periodoAporte=periodoaporte;
                nueva.fechaRecaudo=fecha;
                if( bandera){
                    claseenvio.add(nueva); 
                }
               
            }
           
            classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseenvio);
            system.debug(claseenvio.size());
			String cons = 'Contenido= ' + envio.contenido;
            system.debug('ENviamos a sysde: '+cons);
			request.setBody(cons);
            HttpResponse response = new HttpResponse();
            if(!test.isRunningTest()){
                 response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('{"respuesta":{"codigo":200,"mensaje":"Fueron procesados 1 de 1 solicitudes recibidas."},"detalle":[{"aporteAplicado":true,"identificacion":"0801-1994-11013","cuentaColectiva":"33101","cuenta":"51600","saldo":0.0,"montoPendiente":397620.7,"numeroMovimiento":"1857448","nombre":"ALVARADO AGUILAR WENDY PAOLA","codigoError":0.0,"mensajeError":"","error":"OK","tipoSaldo":"10","montoAporte":1800.0}]}');
            }
           
            system.debug(response.getBody());
	        if (response.getStatusCode() == 200) {
                planilla__C planilla= new planilla__C();
                planilla.id=idpla;
                classRespuestaAportes prueba2= new classRespuestaAportes();
                prueba2 = (classRespuestaAportes) JSON.deserialize(response.getBody(), classRespuestaAportes.class);
                integer p=0;
                list<Resultado_de_aportes__c> listErrores = new list<Resultado_de_aportes__c>();
                for(integer i=0; i<prueba2.detalle.size(); i++){
                    string k=prueba2.detalle[i].error;
                    if(k.toUpperCase()=='OK'){
                        p++;
                    }else{
                        listErrores.add(new Resultado_de_aportes__c(planilla__C=idpla, Num_identidad__C=prueba2.detalle[i].identificacion,
                                                                    cuenta__C=prueba2.detalle[i].cuenta, error__C=k));      
                    }
                }
                planilla.respuesta_desde_sysde_Aportes__C='Procesadas '+p+' de '+prueba2.detalle.size()+'.  Codigo:200';
                planilla.id=idpla;
                //planilla.Respuesta_desde_Sysde_aportes_completa__c=response.getBody();
                update planilla;
               if(listErrores.size()>0){
                   insert listErrores;
               }
             system.debug('Respuesta de Sysde'+response.getBody());
             }
            
        }Catch(Exception e){
            planilla__C planilla= new planilla__C();
            planilla.id=idpla;
            planilla.respuesta_desde_sysde_Aportes__C='200 Error: '+e.getMessage() + ' Linea: ' + e.getLineNumber(); 
            update planilla;
        	system.debug('Error al traer persona: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
        }
    }
    
    
    
    
    
    
    
    @future(callout=true)
     public static void Afiliacionsysde(String TipoIdentificacion, string identificacion, string pn, string sn, string pa, string sa,
                                        string sexo, string es, decimal salario, string co1, string co2,string co3, string is1, string is2, string is3) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/afiliacion');
        request.setMethod('POST');
        request.setHeader('Content-Type','application/x-www-form-urlencoded');
		request.setTimeout(120000);
		list<classRespuestaAportesCuenta> resultado = new list<classRespuestaAportesCuenta>();
		list<planilla> clientes = new list<planilla>();
		
		try{      
             list<classAfiliacion> claseEnvio = new list<classAfiliacion>();
             classAfiliacion nueva = new classAfiliacion();
             nueva.primernombre= pn;
             nueva.primerapellido= pa;
             nueva.segundoapellido= sa;
             nueva.segundoNombre= sn;
             nueva.identificacion= identificacion;
             nueva.idTipoIdentificacion=TipoIdentificacion;
             nueva.cuentauno=co1;
             nueva.cuentados=co2;
             nueva.cuentatres=co3;
             nueva.genero=sexo;
             nueva.estadoCivil=es;
             nueva.idsalesforceuno=is1;
             nueva.idsalesforcedos=is2;
             nueva.idsalesforcetres=is3;
             nueva.salario= salario;
             claseenvio.add(nueva);
           
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseenvio);
			String cons = 'contenido=' + envio.contenido;
            system.debug('Mandamos ' + cons);
			request.setBody(cons);
            HttpResponse response = new HttpResponse();// http.send(request);
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('{"respuesta":{"mensaje":"","codigo":200},"detalle":[{"identificacion":"0801199411013","formularioUno":"","formularioTres":"","formularioDos":"","cuentaUno":"21","cuentaTres":"211","cuentaDos":"212121","codigoSubProductoUno":"","codigoSubProductoTres":"","codigoSubProductoDos":"","codigoProductoUno":"","codigoProductoTres":"","codigoProductoDos":"","codigoEmpresa":"","afiliado":true}]}');
            }
            system.debug('Respuesta sysde'+response.getBody());
            
            if (response.getStatusCode() == 200) {
                classRespuestaAfiliacion prueba2= new classRespuestaAfiliacion();
                prueba2 = (classRespuestaAfiliacion) JSON.deserialize(response.getBody(), classRespuestaAfiliacion.class);
                list<cuentas__c> listcuentas = new list<Cuentas__C>();
                cuentas__c cuenta;
                for(integer i=0; i<prueba2.detalle.size(); i++) {
                    if(prueba2.detalle[i].afiliado) {
                        integer r;
                        prueba2.detalle[i].identificacion.replace('-', '');
                        for(integer yu=0; yu<claseenvio.size(); yu++){
                            if(claseenvio[yu].identificacion ==prueba2.detalle[i].identificacion){
                                r=yu;
                                yu=claseenvio.size();
                            }
                        }
                        if(prueba2.detalle[i].cuentaUno !=null && prueba2.detalle[i].cuentaUno !='null' && prueba2.detalle[i].cuentaUno.trim() !='')  {
                            cuenta = new Cuentas__C();
                            cuenta.cliente__r= new Account(Identificacion__C = prueba2.detalle[i].identificacion);
                            cuenta.Producto__r= new Producto__C(codigo__c = prueba2.detalle[i].codigoProductoUno);
                            cuenta.Subproducto__r =new subProducto__C(codigo__c = prueba2.detalle[i].codigoSubProductoUno);
                            cuenta.Codigo__c=prueba2.detalle[i].cuentaUno;
                            cuenta.Cuenta_colectiva2__r=new Cuentas__C(codigo__C = claseenvio[r].cuentauno);
                            cuenta.Name=pn+' '+sn+' '+pa+' '+sa;
                            listcuentas.add(cuenta);
                        }
                        if(prueba2.detalle[i].cuentados !=null && prueba2.detalle[i].cuentados !='null' && prueba2.detalle[i].cuentados.trim() !='') {
                            cuenta = new Cuentas__C();
                            cuenta.cliente__r= new Account(Identificacion__C = prueba2.detalle[i].identificacion);
                            cuenta.Producto__r= new Producto__C(codigo__c = prueba2.detalle[i].codigoProductodos);
                            cuenta.Subproducto__r =new subProducto__C(codigo__c = prueba2.detalle[i].codigoSubProductodos);
                            cuenta.Codigo__c=prueba2.detalle[i].cuentados;
                            cuenta.Cuenta_colectiva2__r=new Cuentas__C(codigo__C = claseenvio[r].cuentados);
                            cuenta.Name=pn+' '+sn+' '+pa+' '+sa;
                            listcuentas.add(cuenta);
                        }
                        if(prueba2.detalle[i].cuentatres !=null && prueba2.detalle[i].cuentatres !='null' && prueba2.detalle[i].cuentatres.trim() !='') {
                            cuenta = new Cuentas__C();
                            cuenta.cliente__r= new Account(Identificacion__C = prueba2.detalle[i].identificacion);
                            cuenta.Producto__r= new Producto__C(codigo__c = prueba2.detalle[i].codigoProductotres);
                            cuenta.Subproducto__r =new subProducto__C(codigo__c = prueba2.detalle[i].codigoSubProductotres);
                            cuenta.Codigo__c=prueba2.detalle[i].cuentatres;
                            cuenta.Cuenta_colectiva2__r=new Cuentas__C(codigo__C = claseenvio[r].cuentatres);
                            cuenta.Name=pn+' '+sn+' '+pa+' '+sa;
                            listcuentas.add(cuenta);
                        }
                        
                    }
                    
                }
                insert listcuentas; 
            }
	        
	    
	    }catch(System.CalloutException e){
	    		system.debug('Error al hacer la consulta: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());   
        }Catch(Exception e){
        		system.debug('Error al traer persona: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
        }
        // return clientes;
    }
    
    
    @future(callout=true)
    public static  void VerificacionEmpleados(string cuentascolectivas, string tiponatural){
        /* Http http = new Http();
		HttpRequest request = new HttpRequest();
		String url = claseUtil.urlSysde('Test');
		request.setEndpoint(url + 'api/planillas/personas');
        request.setTimeout(120000);
		request.setMethod('POST');
		request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        try
        {
            list<string> listcuentasColectivas = new list<string>();
            listcuentasColectivas= cuentascolectivas.split(',');
            list<classCuentasColectivas> claseenvio=new list<classCuentasColectivas>();
            classCuentasColectivas envio3;
            for(integer i=0; i<listcuentasColectivas.size(); i++)
            {
                envio3= new classCuentasColectivas();
                envio3.cuentaColectiva=listcuentasColectivas[i];
                claseenvio.add(envio3);
            }
            classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseenvio);
			String cons = 'Contenido= ' + envio.contenido;
            system.debug(cons);
			request.setBody(cons);
            HttpResponse response = http.send(request);
            system.debug('Respuesta'+response.getBody());
	         if (response.getStatusCode() == 200)
             {
                  Person P= new Person();
                 listcuentasColectivas= new list<string>();
                 list<string> cuentas = new list<string>();
            	 p = (Person) JSON.deserialize(response.getBody(), Person.class);
                 for(integer i=0; i<p.personas.size(); i++)
                 {
                     listcuentasColectivas.add(p.personas[i].identidad.replace('-',''));
                     p.personas[i].identidad=p.personas[i].identidad.replace('-','');
                     for(integer j=0; j<p.personas[i].cuentas.size(); j++)
                     {
                         cuentas.add(p.personas[i].cuentas[j].cuenta);
                     }
                     
                 }
                map<string, integer> mapaempleados=new  map<string, integer>();
                map<string, integer> mapaCuentas=new  map<string, integer>();
                for(Account item : [select Identificacion__c from Account where Identificacion__c in :(listcuentasColectivas)])
                {
                    mapaempleados.put(item.identificacion__C, 4);
                }
                for(cuentas__C item : [select codigo__c from cuentas__C where codigo__C in :(cuentas)])
                {
                    mapaCuentas.put(item.codigo__C, 4);
                }
                list<Cuentas__c> cuentainsert = new list<Cuentas__c>();
                Cuentas__c cuentaIndividial; 
                 list<Account> listempleados = new list<Account>();
                 Account empleadoindividual;
                for(integer i=0; i<p.personas.size(); i++)
                 {
                    for(integer j=0; j<p.personas[i].cuentas.size(); j++)
                    {
                        if(!mapacuentas.containsKey(p.personas[i].cuentas[j].cuenta))
                        {
                            cuentaIndividial = new Cuentas__C();
                            cuentaIndividial.Codigo__c=p.personas[i].cuentas[j].cuenta;
                            cuentaIndividial.Producto__r=new Producto__C(codigo__C =p.personas[i].cuentas[j].producto );
                            cuentaIndividial.Subproducto__r = new Subproducto__c(codigo__C =p.personas[i].cuentas[j].subProducto);
                            cuentaIndividial.Cliente__r = new Account (Identificacion__C = p.personas[i].identidad );
                            cuentaIndividial.Name=p.personas[i].primerNombre +' '+p.personas[i].segundoNombre+' '+p.personas[i].primerApellido +' '+p.personas[i].segundoApellido;
                           	cuentaIndividial.Cuenta_colectiva2__r=new cuentas__C(codigo__C = p.personas[i].cuentas[j].cuentaColectiva) ;
                            cuentainsert.add(cuentaIndividial);
                        }
                    }
                     
                    if(!mapaempleados.containsKey(p.personas[i].identidad))
                    {
                    	empleadoindividual = new Account();
                        empleadoindividual.recordtypeid=tipoNatural;
                        empleadoindividual.FirstName=p.personas[i].primerNombre +' '+p.personas[i].segundoNombre;
                        empleadoindividual.LastName=p.personas[i].primerApellido +' '+p.personas[i].segundoApellido;
                        empleadoindividual.Tipo_Identificacion__c=p.personas[i].tipoIdentificacion;
                        if(p.personas[i].tipoIdentificacion=='1')
                        {
                            empleadoindividual.Tipo_Identificacion__c='CEDULA DE IDENTIDAD';
                        }
                        else if(p.personas[i].tipoIdentificacion=='2')
                        {
                            empleadoindividual.Tipo_Identificacion__c='CARNET DE RESIDENTE';
                        }
                        else
                        {
                            empleadoindividual.Tipo_Identificacion__c='PASAPORTE';
                        }
                        empleadoindividual.Sexo__c=p.personas[i].sexo;
                        //empleadoindividual.PersonBirthdate=p.personas[i].fechaNacimiento;
                        empleadoindividual.Identificacion__c=p.personas[i].identidad;
                        if(p.personas[i].estadoCivil=='D')
                        {
                            empleadoindividual.Estado_Civil__pc='Divorciado';
                        }
                        else if(p.personas[i].estadoCivil=='C')
                        {
                            empleadoindividual.Estado_Civil__pc='Casado';
                        }
                        else if(p.personas[i].estadoCivil=='V')
                        {
                            empleadoindividual.Estado_Civil__pc='Viudo';
                        }
                        else if(p.personas[i].estadoCivil=='U')
                        {
                            empleadoindividual.Estado_Civil__pc='Unión Libre';
                        }
                        else
                        {
                             empleadoindividual.Estado_Civil__pc='Soltero';
                        }
                        listempleados.add(empleadoindividual);
                        
                    }
                 }
                 
                 
              if(listempleados.size()>0)
              {
                  //insert listempleados;
              }
              if(cuentainsert.size()>0)
              {
                  //insert cuentainsert;
              }
                 system.debug('Exito');
                 
               
     }

        }
        catch(Exception ex)
        {
            system.debug(ex.getMessage()+'   '+ex.getLineNumber());
        }*/  
    }
    
    
    
    
    
    @future(callout=true)
    public static void Afiliacionsysdemasiva(String Personas, string cot, integer bandera, string idplanilla) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        String url = claseUtil.urlSysde('Test');
        request.setEndpoint(url + 'api/afiliacion');
        request.setMethod('POST');
		request.setTimeout(120000);
		list<classRespuestaAportesCuenta> resultado = new list<classRespuestaAportesCuenta>();
		list<planilla> clientes = new list<planilla>();
		
		try{
            
             list<classAfiliacion> claseEnvio = new list<classAfiliacion>();
            classAfiliacion nueva = new classAfiliacion();
          	list<string> todos= new list<string>();
            list<string> identidades= new list<string>();
            todos= personas.split('::::');
            list<string> individual;
            for(integer i=0; i<todos.size(); i++) {
                individual = new list<string>();
                string h = todos[i];
                individual = h.split(',');
                nueva = new classAfiliacion();
                nueva.idTipoIdentificacion=individual[0];
                nueva.identificacion=individual[1];
                identidades.add(individual[1]);
              	nueva.primernombre=individual[2]; 
               	nueva.segundonombre=individual[3];
              	nueva.primerapellido=individual[4];
              	nueva.segundoapellido=individual[5];
              	nueva.genero=individual[6];
               	nueva.estadoCivil = individual[7];
               	nueva.salario=decimal.valueOf(individual[8]);
                nueva.cuentauno = individual[9];
                if(individual[10] !='NADANADA'){
                    nueva.cuentados=individual[10];
                }
                if(individual[11] !='NADANADA'){
                    nueva.cuentatres=individual[11];   
                }
                nueva.idsalesforceuno = individual[12];
                if(individual[13] !='NADANADA'){
                    nueva.idsalesforcedos = individual[13];
                }
                if(individual[14] !='NADANADA'){
                    nueva.idsalesforcetres = individual[14];  
                }
                
               claseenvio.add(nueva);
               
            }
			classJson envio = new classJson();
			envio.contenido = JSON.serialize(claseenvio);
			String cons = 'Contenido= ' + envio.contenido;
            system.debug(cons);
			request.setBody(cons);
            HttpResponse response = new HttpResponse();
            if(!test.isRunningTest()){
                response = http.send(request);
            }else{
                response.setStatusCode(200);
                response.setBody('{"respuesta":{"mensaje":"","codigo":200},"detalle":[{"identificacion":"0801199411013","formularioUno":"","formularioTres":"","formularioDos":"","cuentaUno":"21","cuentaTres":"211","cuentaDos":"212121","codigoSubProductoUno":"","codigoSubProductoTres":"","codigoSubProductoDos":"","codigoProductoUno":"","codigoProductoTres":"","codigoProductoDos":"","codigoEmpresa":"","afiliado":true}]}');
            }
            system.debug(response.getBody());
	         if (response.getStatusCode() == 200) {
             classRespuestaAfiliacion prueba2= new classRespuestaAfiliacion();
             prueba2 = (classRespuestaAfiliacion) JSON.deserialize(response.getBody(), classRespuestaAfiliacion.class);
             list<cuentas__c> listcuentas = new list<Cuentas__C>();
             cuentas__c cuenta;
             for(integer i=0; i<prueba2.detalle.size(); i++)
                 {
                     string nombrecompleto;
                     integer co;
                     prueba2.detalle[i].identificacion.replace('-','');
                     for(integer j=0; j<claseenvio.size(); j++)
                     {
                         if(prueba2.detalle[i].identificacion == claseenvio[j].identificacion)
                         {
                             nombrecompleto = claseenvio[j].Primernombre+' '+claseenvio[j].segundonombre+' '+
                                              claseenvio[j].Primerapellido+' '+claseenvio[j].segundoapellido;
                             co=j;
                             j=claseenvio.size();
                         }
                     }
                     if(prueba2.detalle[i].afiliado)
                     {
                         if(prueba2.detalle[i].cuentaUno !=null && prueba2.detalle[i].cuentaUno !='null' && prueba2.detalle[i].cuentaUno.trim() !='')
                    	{
                            cuenta = new Cuentas__C();
                             cuenta.cliente__r= new Account(Identificacion__C = claseenvio[co].identificacion);
                             cuenta.Producto__r= new Producto__C(codigo__c = prueba2.detalle[i].codigoProductoUno);
                             cuenta.Subproducto__r =new subProducto__C(codigo__c = prueba2.detalle[i].codigoSubProductoUno);
                             cuenta.Codigo__c=prueba2.detalle[i].cuentaUno;
                             cuenta.Cuenta_colectiva2__r=new Cuentas__C(codigo__C = claseenvio[co].cuentaUno);
                             cuenta.Name=nombreCOmpleto;
                             listcuentas.add(cuenta);
                        }
                         
                        if(prueba2.detalle[i].cuentados !=null && prueba2.detalle[i].cuentados !='null' && prueba2.detalle[i].cuentados.trim() !='')
                    	{
                            cuenta = new Cuentas__C();
                             cuenta.cliente__r= new Account(Identificacion__C = claseenvio[co].identificacion);
                             cuenta.Producto__r= new Producto__C(codigo__c = prueba2.detalle[i].codigoProductodos);
                             cuenta.Subproducto__r =new subProducto__C(codigo__c = prueba2.detalle[i].codigoSubProductodos);
                             cuenta.Codigo__c=prueba2.detalle[i].cuentados;
                             cuenta.Cuenta_colectiva2__r=new Cuentas__C(codigo__C = claseenvio[co].cuentados);
                             cuenta.Name=nombreCOmpleto;
                             listcuentas.add(cuenta);
                        }
                         
                        if(prueba2.detalle[i].cuentatres !=null && prueba2.detalle[i].cuentatres !='null' && prueba2.detalle[i].cuentatres.trim() !='')
                    	{
                            cuenta = new Cuentas__C();
                             cuenta.cliente__r= new Account(Identificacion__C = claseenvio[co].identificacion);
                             cuenta.Producto__r= new Producto__C(codigo__c = prueba2.detalle[i].codigoProductotres);
                             cuenta.Subproducto__r =new subProducto__C(codigo__c = prueba2.detalle[i].codigoSubProductotres);
                             cuenta.Codigo__c=prueba2.detalle[i].cuentatres;
                             cuenta.Cuenta_colectiva2__r=new Cuentas__C(codigo__C = claseenvio[co].cuentatres);
                             cuenta.Name=nombreCOmpleto;
                             listcuentas.add(cuenta);
                        }
                         
                     }
                     
                 }
                 if(!test.isRunningTest()){insert listcuentas;  }
                 
                 
                 if(bandera > 0){
                     list<contenido_planilla__C> po = new list<contenido_planilla__C>();
                     po = [select id, empleado2__r.identificacion__C, aporte_patrono_voluntario__C,
                           aporte_empleado_voluntario__C from contenido_planilla__C where empleado2__r.identificacion__C in :identidades and planilla__C=:idplanilla ];
                     list<cuenta_planilla__c> cuentasplanilla = new list<Cuenta_planilla__c>();
                     cuenta_planilla__c cuen;
                     string codigo_unico_banco=[select empresa2__C from planilla__C where id=:idplanilla].empresa2__C;
                     list<cuentas_colectivas__C> cuentasColectivas =[select codigo__C, tipo_cuenta__C from cuentas_colectivas__C where empresa__c=:Codigo_Unico_Banco and 
                                                                     tipo_cuenta__C=:'Voluntarias'];
                     for(integer m=0; m<po.size(); m++)
                     {
                         for(integer k=0; k<listcuentas.size(); k++)
                         {
                             if(po[m].empleado2__r.identificacion__C ==listcuentas[m].cliente__r.identificacion__C)
                             {
                                 string tt='No';
                                 for(integer n=0; n<cuentasColectivas.size(); n++)
                                 {
                                     if(cuentasColectivas[n].codigo__C ==listcuentas[m].cuenta_colectiva2__r.codigo__C)
                                     {
                                         tt='Si';
                                     }
                                 }
                                 if(tt=='Si')
                                 {
                                     cuen = new cuenta_planilla__c();
                                     cuen.Calcular_por__c='Monto';
                                     cuen.Codigo_cuenta__c=listcuentas[k].codigo__C;
                                     cuen.Contenido_Planilla__c=po[m].id;
                                     cuen.Cuenta__c=listcuentas[k].id;
                                     cuen.Tipo__c='Empresa';
                                     cuen.Valor_Monto__c=po[m].aporte_empleado_voluntario__C;
                                     cuen.Valor_Monto_Patrono__c=po[m].aporte_patrono_voluntario__C;
                                     cuentasplanilla.add(cuen);
                                 }
                             }
                         }
                     }
                     insert cuentasplanilla;
                     system.debug('Un Exito chele');
                 }
                 
             }
	    }catch(System.CalloutException e){
	    		system.debug('Error al hacer la consulta: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());   
        }Catch(Exception e){
        		system.debug('Error al traer persona: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());	
        }
        // return clientes;
    }
    
    
    public static void metodoutil()  {
       
    }
    
    
    public static void metodoutil2(){
  
    }
    
    
    /*-----------------------------------SUB CLASES QUE SE UTILIZAN AQUÍ MISMO----------------------------------------------*/
      
    public class classCuentasColectivas{
        public String cuentaColectiva { get; set; }
	}
    
    public class Person{
        public string mensaje{set;get;}
        public list<classPersonas> personas{set;get;}
    }
     
    public class classRespuestaAportes
    {
        public List<classRespuestaAportePlanilla> detalle { get; set; }
    }

    public class classRespuestaAportePlanilla
    {
        public Boolean aporteAplicado { get; set; }
        public String identificacion { get; set; }
        public String cuentaColectiva { get; set; }
        public String cuenta { get; set; }
        public Decimal saldo { get; set; }//P_SALDO
        public Decimal montoPendiente { get; set; }//P_MONTO_PEN_APLIC 
        public String numeroMovimiento { get; set; }//P_NUM_MOVIM_SYSDE
        public String nombre { get; set; } //P_NOMBRE
        public Decimal codigoError { get; set; } //P_CODIGO_ERROR
        public String mensajeError { get; set; } //P_MENSAJE_ERROR
        public String error { get; set; } //P_ERROR
        public String tipoSaldo { get; set; } //P_TIP_SALDO
        public Decimal montoAporte { get; set; } //P_MONTO_APORTE
    }
    public class classPersonas

    {
		public String identidad { get; set; }
        public String tipoIdentificacion { get; set; }
        public String idCliente { get; set; }
        public String primerNombre { get; set; }
        public String segundoNombre { get; set; }
        public String primerApellido { get; set; }
        public String segundoApellido { get; set; }
        public DateTime fechaNacimiento { get; set; }
        public String sexo { get; set; }
        public String correo { get; set; }
        public String estadoCivil { get; set; }
        public List<classCuenta> cuentas { get; set; }

    }
    
      public class classCuenta{

        public String cliente {get;set;}
        public String cuenta {get;set;}
        public String producto {get;set;}
        public String subProducto {get;set;}
        public String cuentaColectiva {get;set;}
        public String fondo {get;set;}

    }
    
    
    
    
    public class classAportesPlanilla
    {
        public String rezago { get; set; } 
        public String codigoReferencia{ get; set; } 
        public String idSalesforce { get; set; } //P_TIP_ARCHIVO
        public String identificacion { get; set; } //P_NUM_ID
        public DateTime fechaRecaudo  { get; set; } //P_FEC_RECAUDO
        public String cuentaColectiva { get; set; } //P_COD_CTA_COLECTIVA
        public String cuenta { get; set; } //P_CUENTA
        public integer codigoCuenta { get; set; } //p_cod_cuenta
        public integer periodoAporte {get;set;} //P_PERIODO_APORTE
        public String codigoMoneda {get;set;} //P_COD_MONEDA
        public Decimal aportePersonalVoluntario { get; set; } //P_MONTO_APORTE_PERSONAL_VOL
        public Decimal aportePatronalVoluntario { get; set; } //P_MONTO_APORTE_PATRONAL_VOL
        public Decimal aportePersonalObligatorio { get; set; } //P_MONTO_APORTE_PATRONAL_OBL
        public Decimal aportePatronalObligatorio { get; set; } //P_MONTO_APORTE_PERSONAL_OBL
        //agregado wp 19-10-2019
        public Decimal aportePersonalExtraordinario { get; set; } 
        public Decimal aportePatronalExtraordinario { get; set; } 
        public Decimal aporteSeguroVida { get; set; }
        //public String p_num_com_ficohsa { get; set; }//NO VA, ES EL MISMO idSalesforce
    } 
        public class classPersona
     	{
        	public String id{ get; set; }
     	}
    	public class classRespuestaAportesCuenta
    	{
            public String identificacion { get; set; }
            public List<classAportesCuenta> cuentas { get; set; }
        }
        
        public class classAportesCuenta
        {
            public String cuenta { get; set; }
            public Decimal aportePersonal { get; set; }
            public Decimal aportePatronal { get; set; }
            //agregado wp 29-10-2019
            public Decimal aportePersonalEx { get; set; }
            public Decimal aportePatronalEx { get; set; }
            public Decimal aporteSeguroVida { get; set; }
            //
        } 
    
    public class Prueba 
    {
        public List<classRespuestaAportesCuenta> aportes {get; set;}
       
    }
	 public class Prueba01 
    {
        //public string mensaje {get; set;}
        public List<classafiliacion> afiliados {get; set;}
       
    }
    
    public class classRespuestaAfiliacion
    {
        public classRespuesta respuesta { get; set; }
        public List<classDetalleRespuestaAfiliacion> detalle { get; set; } 
    }
	public class classRespuesta
    {
        public INTEGER codigo { get; set; }
        public String mensaje { get; set; }
    }
    public class classDetalleRespuestaAfiliacion
    {
       public Boolean afiliado { get; set; }
        public String identificacion { get; set; }
        public String codigoProductoUno { get; set;}
        public String codigoProductoDos { get; set;}
        public String codigoProductoTres { get; set;}
        public String cuentaUno { get; set; }
        public String cuentaDos { get; set; }
        public String cuentaTres { get; set; }
        public String codigoSubProductoUno { get; set;}
        public String codigoSubProductoDos { get; set;}
        public String codigoSubProductoTres { get; set;}
        public String formularioUno { get; set;}
        public String formularioDos { get; set;}
        public String formularioTres { get; set;}
        public String codigoEmpresa { get; set; }
    }
     public class classCenso{
    		public String identidad { get; set; }
	}
}