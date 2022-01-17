@RestResource(urlMapping='/Account/*')
global with sharing class restClientes {
    
    @HttpPost
    global static String sincronizarClientes() {
        try{ 
            String body = System.RestContext.request.requestBody.toString();  
            system.debug('El body que viene: ' + body);
                      
            List<classClientes> clientes = (List<classClientes>)JSON.deserialize(body,List<classClientes>.class);
            system.debug('La clase clientes: ' + clientes);
            
            list<string> codigosClientes = new list<string>();   
            string numeroAfiliado = '';                                         
            For(classClientes item : clientes){
                numeroAfiliado = item.identificacion;
                numeroAfiliado = numeroAfiliado.replace('-','');
                numeroAfiliado = numeroAfiliado.replace(' ','');
                codigosClientes.add(numeroAfiliado);
            }
            
            list<Account> clientesSF = [Select id,Identificacion__c
                            From Account 
                            Where Identificacion__c in: codigosClientes];
            
            //map<string, string> mapAsesores= new map<string, string>();
            for(Account item: clientesSF)
            {
                //if(!mapAsesores.containsKey(item.Identificacion__C) && item.Ownerid !=null)
                //{
                  // mapAsesores.put(item.Identificacion__C, item.Ownerid); 
                //}
            }
            map<string, account> mapClientes = new map<string, account>();            
            For(Account item : clientesSF){
                mapClientes.put(item.Identificacion__c, item);
            }
            
            
            list<Account> clientesFinal = new list<Account>();
            list<Cuentas__c> cuentasFinal = new list< Cuentas__c >();
            list<Beneficiario__c> beneFinal = new list<Beneficiario__c>();
            list<sObject> objetosFinales = new list<sObject>();
                
            For(classClientes item : clientes){
                Account nuevo = new Account();
                if(mapClientes.containsKey(item.identificacion)){
                    nuevo = mapClientes.get(item.identificacion);
                }else{
                    nuevo.Identificacion__c = item.identificacion;
                }
                
                string idTipoRegistro = Schema.SObjectType.Account.getRecordTypeInfosByName().get(item.tipoRegistro).getRecordTypeId();
                nuevo.recordTypeId = idTipoRegistro;
                nuevo.Activo__c = item.activo;
                
                if(item.tipoRegistro == 'Natural'){      
                     nuevo.FirstName = item.nombreCliente;
                     nuevo.LastName = item.apellidoCliente;  
                     nuevo.Tipo_Identificacion__c = item.tipoIdentidad ;
                     nuevo.Identificacion__c = item.identificacion; 
                     nuevo.Sexo__c = item.sexo ;
                     nuevo.Estado_Civil__pc = item.estadoCivil ;
                     nuevo.Nombre_Conyugue__pc = item.nombreConyugue ;
                     nuevo.Phone = item.telefonoDomicilio; 
                     nuevo.Celular__c = item.telefonoCelular ;
                     nuevo.PersonEmail = item.correoElectronico; 
                     nuevo.Nacionalidad__pc = item.nacionalidad ;
                     nuevo.Lugar_Nacimiento__c = item.lugarNacimiento ;
                     nuevo.Numero_Dependientes__c = item.numeroDependientes ;
                     nuevo.Profesion_Ocupacion__pc = item.profesionOcupacionOficio; 
                     nuevo.PersonBirthdate = item.fechaNacimiento != null ? date.valueOF(item.fechaNacimiento) : null;
                     nuevo.Notificar_Correo__c = item.notificarCorreo; 
                     //nuevo.AccountNumber = item.numeroCliente ;
                     nuevo.Cliente_Unico_Banco__c = item.numeroCliente;
                     nuevo.owner = new User(Codigo__c = item.asesorCliente); 
                     nuevo.Antiguedad_del__pc = item.antiguedad ;
                     nuevo.Colonia_Avenida_Residencia__r = item.coloniaBarrioResidencia != null ? new Colonia__c(Codigo_Municipio_Colonia__c  = item.coloniaBarrioResidencia) : null; 
                     nuevo.Calle_Residencia__c = item.calleAvenidaResidencia; 
                     nuevo.Numero_Casa_Residencia__c = item.numeroCasaResidencia ;
                     nuevo.Punto_Referencia_Residencia__c = item.puntoReferenciaResidencia; 
                     nuevo.Ciudad_Residencia2__c = item.ciudadResidencia;// != null ? new Municipio__c(Codigo_Departamento_Municipio__c = item.ciudadResidencia) : null; 
                     nuevo.Pais_Residencia__c = item.paisResidencia ;
                     nuevo.Calle_Trabajo__c = item.coloniaBarrioTrabajo; 
                     nuevo.Colonia_Avenida_Trabajo__r = item.calleAvenidaTrabajo != null ? new Colonia__c(Codigo_Municipio_Colonia__c = item.calleAvenidaTrabajo ) : null; 
                     nuevo.Numero_Casa_Trabajo__c = item.numeroCasaTrabajo ;
                     nuevo.Punto_Referencia_Trabajo__c = item.puntoReferenciaTrabajo; 
                     nuevo.Ciudad_Trabajo2__c = item.ciudadTrabajo;// != null ? new Municipio__c(Codigo_Departamento_Municipio__c = item.ciudadTrabajo) : null;
                     nuevo.Pais_Trabajo__c = item.paisTrabajo ;
                     nuevo.Tipo_trabajador__c = item.tipoTrabajador; 
                     nuevo.Tipo_Empresa__c = item.tipoEmpresa ;
                     nuevo.Industry = item.giroEmpresa ;
                     nuevo.Cargo_desempena__pc = item.cargoActual ;
                     //nuevo.Fecha_ingreso_Empresa__pc = item.fechaIngresoEmpresa != null ? date.valueOF(item.fechaIngresoEmpresa) : null; 
                     nuevo.Rango_Ingresos_Mensual__c = item.rangoSalarial ;
                     nuevo.Telefono_Oficina__c = item.telefonoOficina ;
                     nuevo.Extension_Oficina__c = item.extensionOficina ;
                     nuevo.Correo_Electronico_Oficina__c = item.correoElectronicoOficina; 
                     nuevo.Nombre1__c = item.r1NombreCompleto; 
                     nuevo.Telefono1__c = item.r1Telefono ;
                     nuevo.Nombre2__c = item.r2NombreCompleto; 
                     nuevo.Telefono2__c = item.r2Telefono; 
                     nuevo.PEP__c = item.pep ;
                     nuevo.FATCA__c = item.fatca ;
                     //nuevo.Direccion1__c = campana ;
                     nuevo.Carnet__c = item.Carnet ;
                     nuevo.Promocionales_1__c = item.promocional1 ;
                     nuevo.Promocionales_2__c = item.promocional2 ;
                     nuevo.Promocionales_3__c = item.promocional3; 
                     nuevo.Description = item.descripcion; 
                    
                }Else{
                     nuevo.Nombre_Comercial__c = item.nombreComercial ;
                     nuevo.Identificacion_Empleador__c = item.rtn; 
                     nuevo.Name = item.razonSocial ;
                     nuevo.phone = item.telefono; 
                     nuevo.Industry = item.giroNegocio;
                     nuevo.NumberOfEmployees = item.numeroEmpleados ;
                     //nuevo.Numero_Dependientes__c = item.estatusCuentaEmpresarial;
                     nuevo.Primer_Aporte__c = item.primerAporte; 
                     nuevo.Nombre_Representante__c = item.nombreRepresentanteLegal;
                     nuevo.Cargo_del_Representante__c = item.cargoEmpresa; 
                     nuevo.Poder_Sobre_Empresa__c = item.poderEmpresa ;
                     //nuevo.Fecha_nacimiento_representante__c = date.valueOF(item.rlFechaNacimiento);
                     nuevo.Correo_Electronico_Representante__c = item.rlCorreoElectronico ;
                     nuevo.Telefono_Celular_Representante__c = item.rlTelefono; 
                     nuevo.Nombre_Completo_Contacto_1__c = item.c1NombreCompleto; 
                     //nuevo.Numero_Casa_Residencia__c = item.c1CargoEmpresa ;
                     //nuevo.Punto_Referencia_Residencia__c = item.c1FechaNacimiento; 
                     //nuevo.Ciudad_Residencia__c = item.c1CorreoElectronico; 
                     //nuevo.Pais_Residencia__c = item.c1Telefono ;
                     nuevo.Nombre_Completo_Contacto_2__c = item.c2NombreCompleto; 
                     //nuevo.Colonia_Avenida_Trabajo__c = item.c2CargoEmpresa
                     //nuevo.Numero_Casa_Trabajo__c = item.c2FechaNacimiento ;
                     //nuevo.Punto_Referencia_Trabajo__c = item.c2CorreoElectronico; 
                     //nuevo.Ciudad_Trabajo__c = item.c2Telefono;
                     nuevo.Nombre_Completo_Contacto_3__c = item.c3NombreCompleto ;
                     //nuevo.Tipo_trabajador__c = item.c3CargoEmpresa; 
                     //nuevo.Tipo_Empresa__c = item.c3FechaNacimiento ;
                     //nuevo.Tipo_Empresa__c = item.c3CorreoElectronico ;
                     //nuevo.Cargo_desempena__pc = item.c3Telefono ;
                     nuevo.Numero_de_Charlas_Brindadas__c = item.numeroCharlasBrindadas;
                     nuevo.Cantidad_de_Personas_que_Asistieron__c = item.cantidadPersonasAsistieron ;
                     nuevo.Total_Afiliados__c = item.totalAfiliados ;
                     nuevo.Total_Afiliados_que_Aportan__c = item.totalAfiliadosAportan ;
                     nuevo.Total_Monto_de_Aporte_en_L__c = item.totalMontoAporteL; 
                     nuevo.Total_Monto_de_Aporte_en_D__c = item.totalMontoAporteD;
                }
                /*if(mapasesores.containsKey(nuevo.identificacion__C))
                {
                    
                    nuevo.OwnerID=mapasesores.get(nuevo.identificacion__C);
                }*/
                clientesFinal.add(nuevo);               
                Account cliente = new Account(Identificacion__c = item.identificacion);
                  
                if(item.cuentas != null && item.cuentas.size() > 0){
	                For(classClientes.classCuentas itemCu : item.cuentas){
	                    Cuentas__c nueva = new Cuentas__c(Activo__c = itemCu.cuentaActiva,
		                            Fecha_Apertura__c = Date.valueOF(itemCu.fechaApertura), Fondo_Inversion__c = itemCu.fondoInversion,
		                            Tipo_Fondo__c = itemCu.fondo, Dia_aporte__c = itemCu.fechaAporte,
		                            Frecuencia_Aportacion__c = itemCu.frecuenciaAporte, Forma_Aportacion__c = itemCu.formaAporte,
		                            Seguro_Vida__c = itemCu.seguroVida, Tipo_Comision__c = itemCu.tipoComision,
		                            Matriz_Comision__c = itemCu.matrizComision);
	                    nueva.put('Name',itemCu.cuenta);
	                    nueva.put('Codigo__c',itemCu.cuenta);
	                    nueva.Codigo_Barra__c = itemCu.codigoBarra;
	                    if(itemCu.cuentaColectiva != null && itemCu.cuentaColectiva != ''){ 
	                    		system.debug('Entro a relacionar la cuenta colectiva');
	                    		Cuentas__c cColectiva = new Cuentas__c(Codigo__c = itemCu.cuentaColectiva);
	                    		nueva.Cuenta_colectiva2__r = cColectiva;
	                    }
	                    
	                    nueva.Cliente__r = cliente;
	                    nueva.Producto__r = new producto__c(Codigo__c = itemCu.Producto);
	                    nueva.Subproducto__r =  new Subproducto__c(Codigo__c = itemCu.subProducto);
	                    
	                    cuentasFinal.add(nueva);
	                     
	                    if(itemCu.beneficiarios !=  null && itemCu.beneficiarios.size() > 0){
		                    For(classClientes.classBeneficiarios itemBe : itemCu.beneficiarios){		                    	
		                        Beneficiario__c nuevaBe = new Beneficiario__c(Primer_Nombre__c = itemBe.primerNombre,
		                            Segundo_Nombre__c = itemBe.segundoNombre, Primer_Apellido__c = itemBe.primerApellido,
		                            Segundo_Apellido__c = itemBe.segundoApellido, Identidad__c = itemBe.identidad,
		                            Sexo__c = itemBe.Sexo,
		                            porcentaje__c = itemBe.porcentaje, Telefono__c = itemBe.telefono, Direccion__c = itemBe.direccion,
		                            Id_Externo__c = Decimal.valueOf(itemBe.idExterno));
		                        system.debug('Fecha mala: ' + itemBe.fechaNacimiento);
		                        if(String.valueOF(itemBe.fechaNacimiento) != '0001-01-02 12:00:00' || itemBe.fechaNacimiento != null){
		                        		nuevaBe.Fecha_Nacimiento__c = date.valueOF(itemBe.fechaNacimiento);
		                    		}
		                        nuevaBe.Cuenta__r = new Cuentas__c(Codigo__c = itemBe.cuenta);
		                        nuevaBe.Cliente__r = cliente;
		                        beneFinal.add(nuevaBe); 
		                    }
	                    }
	                }
                }
            }
            for(integer i=0; i<clientesFinal.size(); i++)
            {
                //if(mapasesores.containsKey(clientesFinal[i].identificacion__C))
                //{
                    //clientesFinal[i].Ownerid=mapasesores.get(clientesFinal[i].identificacion__C);
                //}
            }
            system.debug('Clientes: ' + clientesFinal);
            Database.upsertResult[] srList = dataBase.upsert(clientesFinal, false);			
            system.debug('Cuentas: '+ cuentasFinal);
            Schema.SObjectField codigo = Cuentas__c.Fields.Codigo__c;
            Database.upsertResult[] srList2 = dataBase.upsert(cuentasFinal, codigo, false );  
            system.debug('Benes: '+ beneFinal);
            Schema.SObjectField idExterno  = Beneficiario__c.Fields.Id_Externo__c ;
            Database.upsertResult[] srList3 = dataBase.upsert(beneFinal, idExterno, false );  
            
            Integer total = 0;
            Integer buenos = 0;
            Integer malos = 0;
            String error = '';
            for (Database.upsertResult  sr : srList) {
                if (sr.isSuccess()) {
                    // Operation was successful, so get the ID of the record that was processed
                    //System.debug('Successfully inserted account. Account ID: ' + sr.getId());
                    buenos++;
                }
                else {
                    // Operation failed, so get all errors               
                    for(Database.Error err : sr.getErrors()) { 
                        error += err.getMessage() + ' Campos: ' + err.getFields() + ' , ';
                        System.debug('Error: ' + err.getMessage() + ' Campos: ' + err.getFields());
                        //System.debug('Account fields that affected this error: ' + err.getFields());
                    }
                    malos ++;
                }
                total++;
			}
			String respuesta = 'Clientes en total: ' + total + ' Buenos: ' + buenos + ' Malos: ' + malos + ' Errores: '+ error;
            
            total = 0;
            buenos = 0;
            malos = 0;
            error = '';
            for (Database.upsertResult  sr : srList2) {
                if (sr.isSuccess()) {
                    buenos++;
                }
                else {               
                    for(Database.Error err : sr.getErrors()) { 
                        error += err.getMessage() + ' Campos: ' + err.getFields() + ' , ';
                        System.debug('Error: ' + err.getMessage() + ' Campos: ' + err.getFields());
                        //System.debug('Account fields that affected this error: ' + err.getFields());
                    }
                    malos ++;
                }
                total++;
			}
            respuesta += ' Cuentas en total: ' + total + ' Buenos: ' + buenos + ' Malos: ' + malos + ' Errores: '+ error;
            
            total = 0;
            buenos = 0;
            malos = 0;
            error = '';
            for (Database.upsertResult  sr : srList3) {
                if (sr.isSuccess()) {
                    buenos++;
                }
                else {              
                    for(Database.Error err : sr.getErrors()) { 
                        error += err.getMessage() + ' Campos: ' + err.getFields() + ' , ';
                        System.debug('Error: ' + err.getMessage() + ' Campos: ' + err.getFields());
                        //System.debug('Account fields that affected this error: ' + err.getFields());
                    }
                    malos ++;
                }
                total++;
			}
            respuesta += ' Benef en total: ' + total + ' Buenos: ' + buenos + ' Malos: ' + malos + ' Errores: '+ error;
			
            system.debug(respuesta);
            return respuesta;
            
        }Catch(JSONException e){
            string error = 'ERROR json: ' + e.getMessage() + ' CAUSA = ' + e.getCause() + ' LINEA = ' + e.getLineNumber();
            system.debug(error);
            return error;
        }Catch(System.DmlException e){
            string error = 'ERROR: ' + e.getMessage() + ' CAUSA = ' + e.getCause() + ' LINEA = ' + e.getLineNumber();
            for (Integer i = 0; i < e.getNumDml(); i++) {
                system.debug('Error: ' + e.getDmlMessage(i) + ' Linea: ' + e.getLineNumber());
        	}       	
            return error;
          
        }Catch(Exception e){
            string error = 'ERROR: ' + e.getMessage() + ' CAUSA = ' + e.getCause() + ' LINEA = ' + e.getLineNumber();
            system.debug(error);
            return error;
        }        
    }
}