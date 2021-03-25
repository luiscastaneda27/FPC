global class controlTransaccionesMasivas {
    Private Static List<configTransacciones__c> listFieldsConfig;    
    Private Static List<Transaccion__c> listPagoInsert{set;get;}
    
    @RemoteAction
    global static classWRetorno processFile(String stringCSV, String idComercio, String idDescuento, string idUsuario){
        system.debug(stringCSV);
        listFieldsConfig = getConfiguration();
        classWRetorno retorno = new classWRetorno();
        
        if(stringCSV != null && stringCSV != ''){
            List<String> listRowsExcel = stringCSV.split('\n');             
            if(listRowsExcel.size() > 0 ){
                if(validateHeaders(listRowsExcel[0])== 'OK'){                    
                    String json = '[\n';
                    for(Integer j=1; j < listRowsExcel.size(); j++){
                        List<String> listColumns =  getColumns(listRowsExcel[j]);                
                        //asociar el valor con las columnas preconfiguradas
                        json += '{\n';
                        if(listColumns.size() == listFieldsConfig.size()){                            
                            for(Integer i = 0; i < listFieldsConfig.size(); i++){                                  
                                listColumns[i] = listColumns[i].replace('"', '');                          
                           
                                if(validarDato(listFieldsConfig[i], listColumns[i])){//valida los tipos de dato existente fecha, numero, texto y si es obligatorio                                                                    
                                    if((i+1) == listFieldsConfig.size()){                                        
                                        if(listFieldsConfig[i].Es_Texto__c){
                                            json += '\t"' + listFieldsConfig[i].Nombre_API_Campo__c + '" : "' + listColumns[i] + '"';
                                            
                                        }else if(listFieldsConfig[i].Es_Numerico__c){
                                            json += '\t"' + listFieldsConfig[i].Nombre_API_Campo__c + '" : "' + listColumns[i] + '"';
                                            
                                        }/*else if(listFieldsConfig[i].Es_Fecha__c){
                                            DateTime fecha = claseUtil.convertToDate(listColumns[i]);
                                            json += '\t"' + listFieldsConfig[i].Nombre_API_Campo__c + '" : ' + System.JSON.serialize(fecha.Date());
                                            
                                        }*/else if(listFieldsConfig[i].Es_Fecha_Hora__c){                                         
                                            DateTime fecha = claseUtil.convertToDateTime(listColumns[i]);
                                            system.debug(fecha);
                                            json += '\t"' + listFieldsConfig[i].Nombre_API_Campo__c + '" : ' + System.JSON.serialize(fecha);
                                            
                                        }/*else if(listFieldsConfig[i].Es_Booleano__c){
                                            if(listColumns[i] == 'si' || listColumns[i] == 'Si' || listColumns[i] == 'SI'){
                                                json += '\t"' + listFieldsConfig[i].Nombre_API_Campo__c + '" : "Yes"';
                                            }else if(listColumns[i] == 'no' || listColumns[i] == 'No' || listColumns[i] == 'NO'){
                                                json += '\t"' + listFieldsConfig[i].Nombre_API_Campo__c + '" : "No"';
                                            }else{
                                                retorno.listError.add('El valor ' + listColumns[i] + ' en la fila: ' + i + ' columna: ' + listFieldsConfig[i].Name + ' no es valido: se esperaba un si o un no');
                                            }
                                        }*/                                        
                                    }else{                                            
                                            if(listFieldsConfig[i].Es_Texto__c){
                                                json += '\t"' + listFieldsConfig[i].Nombre_API_Campo__c + '" : "' + listColumns[i] + '",';
                                                
                                            }else if(listFieldsConfig[i].Es_Numerico__c){
                                                json += '\t"' + listFieldsConfig[i].Nombre_API_Campo__c + '" : "' + listColumns[i] + '",';
                                                
                                            }/*else if(listFieldsConfig[i].Es_Fecha__c){
                                                DateTime fecha = claseUtil.convertToDate(listColumns[i]);
                                                json += '\t"' + listFieldsConfig[i].Nombre_API_Campo__c + '" : ' + System.JSON.serialize(fecha.Date()) + ',';
                                                
                                            }*/else if(listFieldsConfig[i].Es_Fecha_Hora__c){
                                                DateTime fecha = claseUtil.convertToDateTime(listColumns[i]);
                                                json += '\t"' + listFieldsConfig[i].Nombre_API_Campo__c + '" : ' + System.JSON.serialize(fecha) + ',';
                                                system.debug(fecha);
                                            }/*else if(listFieldsConfig[i].Es_Booleano__c){
                                                if(listColumns[i] == 'si' || listColumns[i] == 'Si' || listColumns[i] == 'SI'){
                                                    json += '\t"' + listFieldsConfig[i].Nombre_API_Campo__c + '" : "Yes",';
                                                }else if(listColumns[i] == 'no' || listColumns[i] == 'No' || listColumns[i] == 'NO'){
                                                    json += '\t"' + listFieldsConfig[i].Nombre_API_Campo__c + '" : "No",';
                                                }else{
                                                  retorno.listError.add('El valor ' + listColumns[i] + ' en la fila: ' + i + ' columna: ' + listFieldsConfig[i].Name + ' no es valido: se esperaba un si o un no');
                                                }
                                            }*/ 
                                    }                                    
                                }else{
                                    retorno.listError.add('Error en el tipo de dato para la Fila: ' + j + ' Columna: ' + listFieldsConfig[i].Name + '; El Registro no será insertado');                                 
                                }
                            }
                            if((j+1)==listRowsExcel.size()){
                                json += '\n}';    
                            }else{
                                json += '\n},';
                            }
                            
                        }                  
                        
                    }   
                    json += '\n]';    
                    system.debug(json);
                    listPagoInsert = (List<Transaccion__c>)System.JSON.deserialize(json, List<Transaccion__c>.class);
                    //contiene las transacciones con error 
                    if(retorno.listError != null){
                        if(retorno.listError.size() > 0){                           
                            retorno.ERROR += 'Se encontraron Transacciones con error\n';
                        }
                     }                  
                     if(listPagoInsert != null && listPagoInsert.size() > 0){                                                                                       
                        try{ 
                            list<string> clientes = new list<string>();
                            String codigoCliente = '';
                            
                            For(Transaccion__c item : listPagoInsert){
                            	codigoCliente = item.Cliente__c;
                            	codigoCliente = codigoCliente.replace('-','');
                            	codigoCliente = codigoCliente.replace(' ','');
                            	//system.debug(codigoCliente);
                                clientes.add(codigoCliente);
                            }
                            //system.debug(clientes);
                            map<string, Account> mapClientes = new map<string, Account>();
                            For(Account item : [Select Identificacion__c, Activo__c From Account 
                                                Where Identificacion__c In: clientes OR Codigo_de_Barra__c In: clientes]){
                                                    
                                mapClientes.put(item.Identificacion__c, item);
                            }
                            
                            List<Transaccion__c> transaccionFinal = new list<Transaccion__c>();
                            List<Transaccion__c> transaccionError = new list<Transaccion__c>();
                            list<string> errores = new list<string>();
                                                                                
                            For(Transaccion__c item : listPagoInsert){
                            	codigoCliente = item.Cliente__c;
                            	codigoCliente = codigoCliente.replace('-','');
                            	codigoCliente = codigoCliente.replace(' ','');
                            	
                                if(mapClientes.containsKey(codigoCliente)){
                                	if(mapClientes.get(codigoCliente).Activo__c){
	                                    if(item.Monto__c != null && item.Monto__c > 0){
	                                        item.Comercio_Afiliado__c = idComercio;
	                                        item.Cliente__c = mapClientes.get(codigoCliente).id;
	                                        item.Descuento__c = idDescuento;
	                                        item.currencyIsoCode = 'HNL';
	                                        item.Usuario_portal__c = idUsuario;
	                                        transaccionFinal.add(item);
	                                    }else{
	                                        errores.add('Monto no puede estar vacio y tiene que ser mayor que 0');
	                                        transaccionError.add(item);    
	                                    }
                                	}else{
                                		errores.add('Cliente no Activo');
                                        transaccionError.add(item);	
                                	}
                                }else{
                                    errores.add('Cliente no encontrado');
                                    transaccionError.add(item);
                                }
                            }
                            insert transaccionFinal; 
                               
                            retorno.ERROR += 'Se Insertaron ' + transaccionFinal.size() + ' registros de ' + (listRowsExcel.size()-1) + ' en total \n\n';
                            
                            if(!transaccionError.isEmpty()){
                                retorno.ERROR += ' Errores: \n ';
                                Integer x = 0;
                                For(Transaccion__c item : transaccionError){
                                    retorno.ERROR += 'Cliente = ' + item.Cliente__c + ' - Monto__c = ' + item.Monto__c + ' - Fecha hora = ' + item.Fecha_hora_Transaccion__c;
                                    retorno.ERROR += ' - ERROR = ' + errores[x] + '\n';
                                    x++;
                                    //retorno.listError.add(sError);                                  
                                }
                            }
                            
                        }catch(system.DmlException e){
                            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ocurrió un error al realizar la carga: Contacte al administrador\n'));  
                            retorno.ERROR += 'Ocurrión un error al realizar el upsert de datos\n';  
                            retorno.ERROR += String.valueOf(e.getDmlMessage(0));
                            system.debug(e.getMessage() + ' Linea ' + e.getLineNumber());
                        }                               
                    }else{
                      retorno.ERROR += 'Error en el tipo de archivo, es posible que no corresponda a este tipo de carga';
                    }
                }else if(validateHeaders(listRowsExcel[0])== 'E1'){
                    retorno.ERROR += 'No hay una configuración para la carga del archivo\n';
                }else if(validateHeaders(listRowsExcel[0])== 'E2'){
                    retorno.ERROR += 'El número de columnas en el archivo es incorrecto\n';
                }else if(validateHeaders(listRowsExcel[0])== 'E3'){
                    retorno.ERROR += 'Hay columnas no configuradas en el archivo favor verifique la configuración del mismo\n';
                }   
            }else{
                retorno.ERROR = 'El archivo se encuentra vacio\n';
            }
        }else{
            retorno.ERROR = 'No se Cargó ningún archivo\n';
        } 
        System.debug('Esta es la lista: '+ listPagoInsert);   
        return retorno;           
    }      

    
    private static boolean validarDato(configTransacciones__c config, String dato){
        Boolean bandera = true;//indica dato correcto
        
        if(config.Es_Obligatorio__c){    
            if(dato == null || dato == ''){
                bandera = false;
            }
        }
        
        if(config.Es_Fecha_Hora__c){
            /*Pattern datePattern = Pattern.compile('((([1])([0-2])|(([0])([1-9])))(\\u003A)(([0-5])([0-9]))(\\s)(([AP])([M])))');
            matcher dateMatcher = datePattern.matcher(dato);
            
            if(!dateMatcher.find()){                
                bandera = false;
            }*/          
            bandera = true;
        }/*else if(config.Es_Fecha__c){
            Pattern datePattern = Pattern.compile('^[0-9]{1,2}[/-][0-9]{1,2}[/-][0-9]{2,4}$');
            matcher dateMatcher = datePattern.matcher(dato);
            
            if(!dateMatcher.find()){                
                bandera = false;
            }
        }*/else if(config.Es_Numerico__c){
            Pattern numberPattern = Pattern.compile('[0-9]+');
            matcher numberMatcher = numberPattern.matcher(dato);
            
            if(!numberMatcher.find()){
                bandera = false;
            }           
        }else if(config.Es_Texto__c){
            Pattern textPattern = Pattern.compile('.+');
            matcher textMatcher = textPattern.matcher(dato);
            
            if(!textMatcher.find()){
                bandera = false;
            }   
        }/*else if(config.Es_Booleano__c){
            Pattern boolPattern = Pattern.compile('[si|no]|[SI|NO]|[Si|No]');
            matcher boolMatcher = boolPattern.matcher(dato);
            
            if(!boolMatcher.find()){
                bandera = false;
            }
        }*/        
        return bandera;
    }

    
    private static List<String> getColumns(String fila){
        List<String> listColums = fila.split(',');       
        return listColums;
    }
    
    private static String validateHeaders(String headers){
        String bandera = '';        
        List<String> listColumnsExcel = headers.split(',');
        if(listFieldsConfig != null && listColumnsExcel != null){
            if(listFieldsConfig.size() > 0 && listColumnsExcel.size() > 0){
                if(listFieldsConfig.size() == listColumnsExcel.size()){
                    Integer countColumnsOk = 0;
                    
                   
                    for(Integer i=0; i < listFieldsConfig.size(); i++){                        
                        listColumnsExcel[i] = listColumnsExcel[i].replace('"','');
                        if(listColumnsExcel[i] == listFieldsConfig[i].Name){
                            countColumnsOk++;
                        }
                    }                    
                    
                    if((countColumnsOk == listFieldsConfig.size()) && (listColumnsExcel.size() == countColumnsOk)){
                        bandera = 'OK';
                    }else{
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Hay columnas no configuradas en el archivo favor verifique la configuración del mismo'));    
                        bandera = 'E3';
                    }                  
                }else{
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El número de columnas en el archivo es incorrecto'));    
                    bandera = 'E2';
                }
            }
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No hay una configuración para la carga del archivo'));
            bandera = 'E1';
        }
        
        return bandera;
    }   
        
    private static List<configTransacciones__c> getConfiguration(){
        listFieldsConfig = [SELECT Name, Es_Fecha__c, 
                                   Es_Numerico__c, Es_Texto__c,
                                   Nombre_API_Campo__c, Es_Obligatorio__c, 
                                   Es_Booleano__c, Es_Fecha_Hora__c  
                                   FROM configTransacciones__c ORDER BY Orden__c ASC];
                                   
         return listFieldsConfig;                                                            
    } 
    
    global class classWRetorno{
        public List<String> listError{set;get;}
        public String ERROR{set;get;}
        
        public classWRetorno(){
            listError = new List<String>();
            ERROR = '';           
        }
    }
}