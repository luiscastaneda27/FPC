public class aSysdeSincronizador {
    
    public static final String URL = claseUtilPlanillas.urlSysde('Test');
    //public static final String URL = 'http://190.5.68.49:9090/';;
    
    @future(callout=true)
    public static void actializarClientes (string idCliente) {
        system.debug('llamo el metodo');
        Bitacora_Sync__c  bitacora = new Bitacora_Sync__c ();
        bitacora.fecha__C = system.now();
        bitacora.Clientes__c = 0;
        bitacora.Cuentas__c = 0;
        bitacora.Beneficiarios__c = 0 ;
        bitacora.Beneficiarios_Correctos__c = 0 ;
        bitacora.Clientes_Correctos__c = 0;
        bitacora.Cuentas_Correctas__c = 0;
        Http http = new Http();
        list<Beneficiario__c> listBeneficiarios = new list<Beneficiario__c>();
        list<account> listClientes = new list<account>();
        list<cuentas__C> listCuentas = new list<cuentas__C>();
        try{
            HttpRequest request = new HttpRequest();
            request.setEndpoint(URL + 'api/sync');
            request.setMethod('POST');
            request.setTimeout(120000); 
            map<string, string> mapUsuario = new map<string, string> ();
            map<string, string> mapPais = new map<string, string> ();
            map<string, string> mapNacionalidad = new map<string, string> ();
            map<string, string> mapCuentasCo = new map<string, string> ();
            for(user item: [select id, codigo__C from user where isActive = true and codigo__C!=null]){
                mapUsuario.put(item.codigo__C, item.id);
            }
            for(pais_r__C item : [select codigo__C, name, nacionalidad__c,id from pais_r__C]){
                mapPais.put(item.Codigo__c, item.name);
                mapNacionalidad.put(item.Codigo__c, item.nacionalidad__c);
                mapNacionalidad.put(item.nacionalidad__c, item.nacionalidad__c);
            }
            for(Cuentas__C item : [select codigo__C, name from cuentas__C where Colectiva__c = true]){
                mapCuentasCo.put(item.Codigo__c, item.name);
            }
            //integer resta = (datetime.now().hour() == 21 || datetime.now().hour() == 23) ? -2 : datetime.now().hour() == 7 ? -8 : -1;
            datetime hora = datetime.now();
            
            String cons;
            if(idCliente == null){
                cons = 'contenido={"hasta":"anio-mes-dia","desde":"anio-mes-dia","accion":"A"}';
                cons = cons.replace('anio', ''+hora.year());
                cons = cons.replace('mes', hora.month() < 10 ? '0'+hora.month() : ''+hora.month());
                cons = cons.replace('dia', hora.day() < 10 ? '0'+hora.day() : ''+hora.day());
            }else{
                cons = 'contenido={"accion":"I", "idCliente":"'+idCliente+'"}';
            }
            
            system.debug('Mandamos:'+cons);
            request.setBody(cons);
            HttpResponse response = new HttpResponse();
            
            if(!test.isRunningTest() /*&& false*/){
                response = http.send(request); 
            }else{
                response.setBody('{"codigo":200,"mensaje":"Se han encontrado 3 clientes naturales.","clientes": [{"numeroClienteBanco":271875,"nombres":"ZOE GERALDINE","apeliidos":"ULLOA MARADIAGA","estadoCivil":"S","nombreConyugue":null,"sexo":"F","lugarNacimiento":"tegucigalpa","nacionalidad":"074","fechaNacimiento":"03-OCT-94","profesion":"33","nivelIngreso":null,"nombreReferenciaUno":"CARLOS  ESCOTO","telefonoReferenciaUno":"99999999","nombreReferenciaDos":"MARIELL  SIERRA","telefonoReferenciaDos":"89898989","tipoIdentificacion":"1","identificacion":"0801-1994-11017","correo":"wendy.alvarado@ficohsa.com","telefonoDomicilio":null,"telefonoCelular":null,"fechaIngresoFPC":"01-ENE-16","tipoTrabajador":"1","nombreEmpresa":"ADMINISTRADORA DE FONDOS DE PENSIONES FICOHSA S.A.","tipoEmpresa":"N","identificacionEmpresa":"08019015715256","cargoEmpresa":"OFTEC","giroNegocio":"15","paisResidencia":"1","departamentoResidencia":null,"ciudadResidencia":null,"coloniaResidencia":null,"puntoReferenciaResidencia":"(Sin Direccion)","paisTrabajo":"074","departamentoTrabajo":null,"ciudadTrabajo":null,"coloniaTrabajo":null,"puntoReferenciaTrabajo":"(Sin Direccion)","cuentas":[{"sCuenta":"104527","asesor":"HN22258","cuentaActiva":"A","fondo":"P","producto":"01","formaAporte":"TL","fechaApertura":"10-FEB-20","subProducto":"FI010","cuentaColectiva":"33101","causa":"01","fondoInversion":"101","frecuenciaAporte":"M","montoAporte":"0","divisa":"01","codigoBarra":"FPC20200210","seguroVida":"N","beneficiarios":[{"primerNombre":null,"segundoNombre":null,"primerApellido":null,"segundoApellido":null,"tipoId":null,"identidad":null,"idExterno":null,"sexo":null,"porcentaje":null,"fechaNacimiento":null,"gradoParentesco":null,"parentesco":null}]}]}]}');
                response.setStatusCode(200);
            }
            system.debug('Respuesta Clientes: '+response.getBody()+'-----');
            if(response.getStatusCode() == 200 && response.getBody() != null && response.getBody().trim() !='') {
                string contenido = response.getBody().trim();
                contenido = contenido.replace(' "', '"');
                contenido = contenido.replace('" ', '"');
                contenido = contenido.replace('""', 'null');
                response.setBody(contenido);
                RespuestaSync respuesta = (RespuestaSync)System.JSON.deserialize(response.getBody(), RespuestaSync.class);
                list<clientes> listClientesSysde =respuesta.Clientes;// (list<clientes>)System.JSON.deserialize(response.getBody(), list<clientes>.class);
                string tipoRegistro = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
                map<string, string> mapMunicipios= new map<string, string>(); 
                map<string, string> mapEstadoCivil= new map<string, string>(); 
                Schema.DescribeFieldResult fieldResult = account.Ciudad_Trabajo2__c.getDescribe();   
                for(Schema.PicklistEntry p : fieldResult.getPicklistValues()){          
                    mapMunicipios.put(p.getvalue(), p.getLabel());  
                }
                fieldResult = account.estado_civil__pc.getDescribe();   
                for(Schema.PicklistEntry p : fieldResult.getPicklistValues()){          
                    mapEstadoCivil.put(p.getvalue().substring(0, 1), p.getLabel());  
                }
                if(listClientesSysde !=null){
                    for(Clientes item : listClientesSysde){
                        //system.debug(item.numeroClienteBanco);
                        if(item.correo != null){
                            item.correo = item.correo.replace(' ', '@');
                            item.correo = !item.correo.contains('@.') ? item.correo : 'notiene@ejemplo.hn';
                            
                        }
                        item.nacionalidad = item.nacionalidad != null ? item.nacionalidad.toUpperCase() : null;
                        listClientes.add(new account(
                            firstname = item.nombres, lastName = item.apeliidos, Cliente_Unico_Banco__c= item.numeroClienteBanco,
                            activo__C =true, RecordTypeId=tipoRegistro, tipo_identificacion__C = item.tipoIdentificacion,
                            identificacion__C = item.identificacion.replace('-',''), sexo__C = item.sexo, estado_civil__pc =item.estadoCivil != null && mapEstadoCivil.containsKey(item.estadoCivil) ? mapEstadoCivil.get(item.estadoCivil) : null ,
                            PersonEmail  = item.correo, Nombre_Conyugue__pc  = item.nombreConyugue, Nacionalidad__pc =mapNacionalidad.containsKey(item.nacionalidad) ? mapNacionalidad.get(item.nacionalidad) : null,
                            Celular__c = item.telefonoCelular, Phone =item.telefonoDomicilio, Lugar_Nacimiento__c =item.lugarNacimiento,
                            Profesi_n_Ocupaci_n__c  = item.profesion,   
                            Pais_Trabajo__c = mapPais.containsKey(item.paisTrabajo) ? mapPais.get(item.paisTrabajo) : null , Departamento_Trabajo2__c =item.departamentoTrabajo,
                            Ciudad_Trabajo2__c = item.departamentoTrabajo !=null && item.ciudadTrabajo !=null && mapMunicipios.containsKey((item.departamentoTrabajo+'-'+item.ciudadTrabajo))  ? (item.departamentoTrabajo+'-'+item.ciudadTrabajo) : '000', 
                            Punto_Referencia_Trabajo__c  = item.puntoReferenciaTrabajo, Pais_Residencia__c  = mapPais.containsKey(item.paisResidencia) ? mapPais.get(item.paisResidencia) : null,
                            Departamento_Residencia2__c =item.departamentoResidencia, 
                            Ciudad_Residencia2__c =item.departamentoResidencia !=null && item.ciudadResidencia !=null && item.departamentoResidencia != '000' && item.ciudadResidencia != '000' ? (item.departamentoResidencia+'-'+item.ciudadResidencia) : '000',
                            Punto_Referencia_Residencia__c =item.puntoReferenciaResidencia, Nombre1__c =item.nombreReferenciaUno,
                            Telefono1__c = item.telefonoReferenciaUno, Nombre2__c = item.nombreReferenciaDos, Telefono2__c= item.telefonoReferenciaDos,
                            Tipo_trabajador__c  = item.tipoTrabajador !=null ? item.tipoTrabajador.replace('.0','') : null, Nombre_empresa__c  = item.nombreEmpresa, Tipo_Empresa__c =item.tipoEmpresa,
                            RTN_Empresa__c = item.identificacionEmpresa,
                            Cargo_desempena__pc = item.cargoEmpresa, Nivel_Ingreso__c  = item.nivelIngreso, sector_n__C = item.giroNegocio,
                            Fecha_ingreso_Empresa__pc  = convertStringDate(item.fechaIngresoFPC) ));
                        if(item.fechaNacimiento !=null){
                            listClientes[listClientes.size() -1].PersonBirthdate = convertStringDate(item.fechaNacimiento);
                        }
                        if(item.asesor !=null && mapUsuario.containskey(item.asesor)){
                            listClientes[listClientes.size() -1].ownerid = mapUsuario.get(item.asesor);
                        }
                        
                        if(item.departamentoTrabajo !=null && item.ciudadTrabajo !=null && item.coloniaTrabajo !=null){
                            listClientes[listClientes.size() -1].Colonia_Avenida_Trabajo__r  =new Colonia__C(Codigo_Municipio_Colonia__c = item.departamentoTrabajo+'-'+item.ciudadTrabajo+'-'+item.coloniaTrabajo);
                        }
                        
                        if(item.departamentoResidencia !=null  && item.ciudadResidencia !=null && item.coloniaResidencia !=null){
                            listClientes[listClientes.size() -1].Colonia_Avenida_Residencia__r  =new Colonia__C(Codigo_Municipio_Colonia__c = item.departamentoResidencia+'-'+item.ciudadResidencia+'-'+item.coloniaResidencia); 
                            
                        }
                        
                        if(item.cuentas != null){
                            for(Cuentas itemCuentas : item.cuentas){
                                listCuentas.add(new cuentas__C(
                                    cliente__r = new Account(cliente_unico_banco__C = item.numeroClienteBanco) , name = itemCuentas.Scuenta, codigo__C =itemCuentas.scuenta,
                                    producto__r = new producto__C (codigo__C = itemCuentas.producto), subproducto__r = new subproducto__C(codigo__C = itemCuentas.subProducto),
                                    activo__C = itemCuentas.cuentaActiva != 'I' ? true : false,
                                    tipo_fondo__C = itemCuentas.fondo == null || itemCuentas.fondo.trim() =='' ? 'I' : itemCuentas.fondo  , Fondo_Inversion__c = itemCuentas.fondoInversion, causa__C = itemCuentas.causa, 
                                    fecha_apertura__C = convertStringDate(itemCuentas.fechaApertura),
                                    Frecuencia_Aportacion__c  = itemCuentas.frecuenciaAporte,
                                    Monto_aporte__c = convertStringDecimal(itemCuentas.montoAporte), forma_aportacion__C = itemCuentas.formaAporte, Seguro_Vida__c = itemCuentas.seguroVida == 'S' ? true : false,
                                    Codigo_Barra__c = itemCuentas.codigoBarra,// tipo_comision__C = itemCuentas.tipoComision, //*Matriz_Comision__c = itemCuentas.matrizComision,
                                    CurrencyIsoCode = (itemCuentas.producto == '01' || itemCuentas.producto == '03') ? 'HNL' : 'USD' ));
                                if(itemCuentas.cuentaColectiva !=null && mapCuentasCo.containsKey(itemCuentas.cuentaColectiva)){
                                    listCuentas[listCuentas.size() -1].cuenta_colectiva2__r = new cuentas__C(codigo__C = itemCuentas.cuentaColectiva);
                                }
                                if(itemCuentas.asesor !=null && mapUsuario.containskey(itemCuentas.asesor)){
                                    listClientes[listClientes.size() -1].ownerid = mapUsuario.get(itemCuentas.asesor);
                                }
                                
                                if(itemCuentas.Beneficiarios !=null){
                                    for(Beneficiarios Bene : itemCuentas.Beneficiarios){
                                        if(convertStringDecimal(Bene.idExterno) != null){
                                            listBeneficiarios.add(new Beneficiario__c(
                                                Cuenta__r = new cuentas__C(codigo__C = itemCuentas.sCuenta),Id_Externo__c  = convertStringDecimal(Bene.idExterno),
                                                Primer_Nombre__c  = Bene.primerNombre, Segundo_Nombre__c = Bene.segundoNombre, Primer_Apellido__c  = Bene.primerApellido,
                                                Segundo_Apellido__c = Bene.segundoApellido, Fecha_Nacimiento__c =convertStringDate( Bene.fechaNacimiento),
                                                parentesco__C = Bene.parentesco, Grado_Parentesco__C = Bene.gradoParentesco, porcentaje__C= convertStringDecimal(Bene.porcentaje),
                                                sexo__C = Bene.sexo != 'F' ? 'Masculino' : 'Femenino', Identidad__c  =Bene.identidad, Tipo_de_Identificaci_n__c =Bene.tipoId//,
                                            ));
                                        }
                                        
                                        
                                    }
                                } 
                                
                            }
                        }
                        
                        
                    }
                }
                
                
            }
            if(idCliente == null){
                request = new HttpRequest();
                request.setEndpoint(url + 'api/sync');
                request.setMethod('POST');
                request.setTimeout(120000);
                cons = cons.replace(':"A"', ':"J"');
                request.setBody(cons);
                response = new HttpResponse();
                if(!test.isRunningTest()){
                    response = http.send(request); 
                }else{
                    response.setBody('{"codigo":200,"mensaje":"Se han encontrado 1 clientes juridicos.","clientes": [{"numeroClienteBanco":"159751","nombreComercial":"ELEMENTS CENTRO S. DE R.L. DE C.V.","tipoIdentificacion":"5","rtn":"08019000231913","razonSocial":"ADMINISTRATIVO COMO GERENTE","telefono":"22353583","correo":"TEGUS@ELEMENTSHN.COM","giroNegocio":"231","tipoAdmin":"S","numeroEmpleados":"47","nombreRepresentanteLegal":"ANA MARIA HANDAL BENDECK","cargoEmpresa":"GERENTE GENERAL","poderEmpresa":"ADMINISTRATIVO COMO GERENTE","rlTelefono":"0","paisResidencia":"074","departamentoResidencia":"123","ciudadResidencia":"25","coloniaResidencia":"0706","puntoReferenciaResidencia":"COL. LOMAS DEL GUIJARRO AVE. DOMINICANA, CASA 3653, FRENTE A OFICINAS DE BCO. DAVIVIENDA","cuentas":[{"sCuenta":"43127","asesor":"HN21892","cuentaActiva":"A","fondo":"N","producto":"01","formaAporte":"PL","fechaApertura":"20-APR-16","subProducto":"FPC06","cuentaColectiva":null,"causa":"01","fondoInversion":"101","frecuenciaAporte":"M","montoAporte":"0","divisa":"01","codigoBarra":"FPCE0107"},{"sCuenta":"43191","asesor":"HN21892","cuentaActiva":"A","fondo":"N","producto":"02","formaAporte":"PL","fechaApertura":"21-APR-16","subProducto":"FPC16","cuentaColectiva":null,"causa":"01","fondoInversion":"106","frecuenciaAporte":"M","montoAporte":"0","divisa":"02","codigoBarra":"FPCE0108"},{"sCuenta":"33204","asesor":"HN21892","cuentaActiva":"A","fondo":"C","producto":"03","formaAporte":"AH","fechaApertura":"02-JUN-15","subProducto":"FPC21","cuentaColectiva":null,"causa":"01","fondoInversion":"101","frecuenciaAporte":"M","montoAporte":"10000","divisa":"03","codigoBarra":"FPCE02"}]}]}}');
                    response.setStatusCode(200);
                }
                if(response.getStatusCode() == 200 && response.getBody() != null && response.getBody().trim() !=''){
                    string contenido = response.getBody();
                    contenido = contenido.replace(' "', '"');
                    contenido = contenido.replace('""', 'null');
                    response.setBody(contenido);
                    RespuestaSync respuesta = (RespuestaSync)System.JSON.deserialize(response.getBody(), RespuestaSync.class);
                    system.debug('Respuesta Clientes Jurídicos: '+response.getBody());
                    list<clientes> listClientesSysde =respuesta.Clientes;// (list<clientes>)System.JSON.deserialize(response.getBody(), list<clientes>.class);
                    string tipoRegistro = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Juridico').getRecordTypeId();
                    if(listClientesSysde !=null){
                        for(Clientes item : listClientesSysde){
                            if(item.correo != null){
                                item.correo = item.correo.replace(' ', '@');
                                item.correo = !item.correo.contains('@.') ? item.correo : 'notiene@ejemplo.hn';
                                
                            }
                            account nuevo = new account();
                            nuevo.Tipo_Identificacion__c = item.tipoIdentificacion;
                            nuevo.Cliente_Unico_Banco__c = item.numeroClienteBanco;
                            nuevo.Identificacion__c = item.rtn;
                            
                            //Campos Nuevos
                            nuevo.Pais_Residencia__c  = mapPais.containsKey(item.paisResidencia) ? mapPais.get(item.paisResidencia) : null;
                            nuevo.Departamento_Residencia2__c =item.departamentoResidencia; 
                            nuevo.Ciudad_Residencia2__c =item.departamentoResidencia !=null && item.ciudadResidencia !=null && item.departamentoResidencia != '000' && item.ciudadResidencia != '000' ? (item.departamentoResidencia+'-'+item.ciudadResidencia) : '000';
                            nuevo.Punto_Referencia_Residencia__c =item.puntoReferenciaResidencia;
                            nuevo.sector__C = item.giroNegocio;
                            nuevo.Nombre_Representante__c = item.nombreRepresentanteLegal;
                            nuevo.Correo_Empresarial__C  = item.correo;
                            
                            if(item.departamentoResidencia !=null  && item.ciudadResidencia !=null && item.coloniaResidencia !=null){
                                nuevo.Colonia_Avenida_Residencia__r  =new Colonia__C(Codigo_Municipio_Colonia__c = item.departamentoResidencia+'-'+item.ciudadResidencia+'-'+item.coloniaResidencia); 
                                
                            }
                            
                            //FIn campos nuevos
                            
                            nuevo.recordTypeId = tipoRegistro;
                            nuevo.Activo__c = true;
                            nuevo.Nombre_Comercial__c = item.nombreComercial ;
                            nuevo.Identificacion_Empleador__c = item.rtn; 
                            nuevo.Name = item.nombreComercial ; // item.razonSocial
                            nuevo.phone = item.telefono; 
                            //nuevo.Razon_Social__C = item.razonSocial;
                            nuevo.Tipo_Empresa__c = item.tipoAdmin != 'N' ? 'S' : 'N';
                            nuevo.NumberOfEmployees = item.numeroEmpleados ;
                            nuevo.Primer_Aporte__c = convertStringDecimal(item.primerAporte); 
                            nuevo.Cargo_del_Representante__c = item.cargoEmpresa; 
                            nuevo.Poder_Sobre_Empresa__c = item.poderEmpresa ;
                            nuevo.Correo_Electronico_Representante__c = item.rlCorreoElectronico ;
                            nuevo.Telefono_Celular_Representante__c = item.rlTelefono; 
                            nuevo.Nombre_Completo_Contacto_1__c = item.c1NombreCompleto; 
                            nuevo.Nombre_Completo_Contacto_2__c = item.c2NombreCompleto; 
                            nuevo.Nombre_Completo_Contacto_3__c = item.c3NombreCompleto ;
                            nuevo.Numero_de_Charlas_Brindadas__c = item.numeroCharlasBrindadas;
                            nuevo.Cantidad_de_Personas_que_Asistieron__c = item.cantidadPersonasAsistieron ;
                            nuevo.Total_Afiliados__c = item.totalAfiliados ;
                            nuevo.Total_Afiliados_que_Aportan__c = item.totalAfiliadosAportan ;
                            nuevo.Total_Monto_de_Aporte_en_L__c = convertStringDecimal(item.totalMontoAporteL); 
                            nuevo.Total_Monto_de_Aporte_en_D__c = convertStringDecimal(item.totalMontoAporteD);
                            
                            listClientes.add(nuevo);                        
                            if(item.cuentas != null){
                                for(Cuentas itemCuentas : item.cuentas){
                                    // if(itemCuentas.cliente !='46'){
                                    list<string> separador = new list<string>();
                                    date fecha = null;
                                    if(itemCuentas.fechaApertura != null){
                                        separador = itemCuentas.fechaApertura.split('-');
                                        if(separador.size()>2){
                                            fecha = date.valueOf(dateTime.newInstance(integer.valueOf(separador[2])+2000, MesLetras(separador[1]), integer.valueOf(separador[0])));
                                        }
                                    }
                                    
                                    
                                    listCuentas.add(new cuentas__C(
                                        cliente__r = new Account(cliente_unico_banco__C = item.numeroClienteBanco)  ,name = itemCuentas.Scuenta+' - ' +item.nombreComercial, codigo__C =itemCuentas.scuenta,
                                        producto__r = new producto__C (codigo__C = itemCuentas.producto), subproducto__r = new subproducto__C(codigo__C = itemCuentas.subProducto),
                                        activo__C = itemCuentas.cuentaActiva != 'I' ? true : false,
                                        tipo_fondo__C = itemCuentas.fondo, Fondo_Inversion__c = itemCuentas.fondoInversion, causa__C = itemCuentas.causa, 
                                        fecha_apertura__C = fecha,
                                        Frecuencia_Aportacion__c  = itemCuentas.frecuenciaAporte,
                                        Monto_aporte__c = convertStringDecimal(itemCuentas.montoAporte), forma_aportacion__C = itemCuentas.formaAporte, Seguro_Vida__c = itemCuentas.seguroVida == 'S' ? true : false,
                                        Codigo_Barra__c = itemCuentas.codigoBarra,// tipo_comision__C = itemCuentas.tipoComision, //*Matriz_Comision__c = itemCuentas.matrizComision,
                                        CurrencyIsoCode = (itemCuentas.producto == '01' || itemCuentas.producto == '03') ? 'HNL' : 'USD' ));
                                    if(itemCuentas.asesor !=null && mapUsuario.containskey(itemCuentas.asesor)){
                                        listClientes[listClientes.size() -1].ownerid = mapUsuario.get(itemCuentas.asesor);
                                    }
                                    //}
                                    
                                }
                            }
                            
                            
                        }
                    }
                    
                    
                }
                
            }
            system.debug('--------UPSERT CLIENTES--------');
            //asysdeCallouts.fechaCierreSysde(date.today());
            //database.upsert(listClientes, account.cliente_unico_banco__c, true);
            database.UpsertResult[] result = database.upsert(listClientes, account.cliente_unico_banco__c, false);
            list<account> listClientesIden = new list<account>();
            for(account item :listClientes){
                if(item.id == null){
                    listClientesIden.add(item);
                }
            }
            
            integer i = 0;
            for(database.UpsertResult item : result){
                if(item.isSuccess()){
                    i++;
                }else{
                    system.debug('Error Cliente: '+item.getErrors());
                }
            }
            result = database.upsert(listClientesIden, account.identificacion__C, false);
            for(database.UpsertResult item : result){
                if(item.isSuccess()){
                    i++;
                }else{
                    system.debug('Error Cliente: '+item.getErrors());
                }
            }
            bitacora.Clientes_Correctos__C = i ;
            bitacora.Clientes__c = listClientes.size();
            //system.debug(' tamano'+listCuentas.size());
            list<cuentas__C> listCuentasUpse = new list<cuentas__C>();
            for(cuentas__C item: listCuentas){
                cuentas__C v = new cuentas__C();
                date fecha = item.Fecha_Apertura__c != null ? date.valueOf(item.Fecha_Apertura__c.year()+'-'+item.Fecha_Apertura__c.month()+'-'+item.Fecha_Apertura__c.day()) : null;
                if(fecha!=null){
                    v.Fecha_Apertura__c=fecha;
                }
                v.Name=item.name;
                v.cliente__r = new Account(cliente_unico_banco__C = item.cliente__r.cliente_unico_banco__C);
                v.Producto__r = new producto__C(codigo__C = item.Producto__r.codigo__C);
                v.Subproducto__r = new Subproducto__C(codigo__C = item.Subproducto__r.codigo__C);
                v.Codigo__c=item.Codigo__c;
                v.Activo__c=item.Activo__c;
                v.Tipo_Fondo__c=item.Tipo_Fondo__c;
                v.Fondo_Inversion__c=item.Fondo_Inversion__c;
                v.Causa__c=item.Causa__c;
                if(item.cuenta_colectiva2__r.codigo__C !=null){
                    v.cuenta_colectiva2__r = new cuentas__C(codigo__C = item.cuenta_colectiva2__r.codigo__C);
                }
                v.Frecuencia_Aportacion__c=item.Frecuencia_Aportacion__c;
                v.Monto_aporte__c=item.Monto_aporte__c;
                v.Forma_Aportacion__c=item.Forma_Aportacion__c;
                v.Seguro_Vida__c=item.Seguro_Vida__c;
                v.Codigo_Barra__c=item.Codigo_Barra__c;
                v.tipo_comision__C = item.tipo_comision__C;
                v.Matriz_Comision__c = item.Matriz_Comision__c;
                v.CurrencyIsoCode = item.CurrencyIsoCode;
                //v.Fecha_ingreso_Empresa__pc = item.Fecha_ingreso_Empresa__pc;
                listCuentasUpse.add(v);
            }
            system.debug('--------UPSERT CUENTAS--------');
            result =   database.upsert(listCuentasUpse, cuentas__c.codigo__C, false);
            i = 0;
            for(database.UpsertResult item : result){
                if(item.isSuccess()){
                    i++;
                }else{
                    system.debug('Error cuentas: '+item.getErrors());
                }
            }
            bitacora.Cuentas_Correctas__C = i;
            bitacora.Cuentas__c = listCuentasUpse.size();
            system.debug('--------UPSERT BENEFICIARIOS--------');
            result =   database.upsert(listBeneficiarios, Beneficiario__c.Id_externo__C, false);
            i = 0;
            for(database.UpsertResult item : result){
                if(item.isSuccess()){
                    i++;
                }else{
                    system.debug('Error Beneficiarios: '+item.getErrors());
                }
            }
            bitacora.Beneficiarios__c = listBeneficiarios.size();
            bitacora.Beneficiarios_Correctos__C = i;
            // system.debug('Wendy esto es un exito');
            bitacora.resultado__C = 'Éxitoso';
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+ ', Linea: '+ex.getLineNumber());
            bitacora.resultado__C = 'Error: '+ex.getMessage()+ ', Linea: '+ex.getLineNumber();
            database.UpsertResult[] result =  database.upsert(listClientes, account.cliente_unico_banco__C, false);
            integer i = 0;
            for(database.UpsertResult item : result){
                if(item.isSuccess()){
                    i++;
                }
            }
            bitacora.Clientes_Correctos__C = i ;
            bitacora.Clientes__c = listClientes.size();
        }
        
        if(idCliente == null){
            insert bitacora;
            for(CronTrigger item : [SELECT id FROM CronTrigger where CronJobDetail.Name = 'JobSync']){
                System.abortJob(item.id);
            }
            Datetime fecha = Datetime.now();
            fecha = fecha.minute() > 3 ? fecha.addMinutes(57) :fecha.addHours(1);
            String acron = fecha.second()+' '+fecha.minute()+' '+fecha.hour()+' '+fecha.day()+' '+fecha.month()+' ? '+fecha.year();
            System.schedule('JobSync', acron, new JobSync());
        }
        if(datetime.now().hour() == 23){
            EstadosDeCuenta.InsertarCorreos();
        }
        
    }
    
    public static void actializarClienteIndividual (string idCliente) {
        system.debug('llamo el metodo desde Act Info');
        Bitacora_Sync__c  bitacora = new Bitacora_Sync__c ();
        bitacora.fecha__C = system.now();
        bitacora.Clientes__c = 0;
        bitacora.Cuentas__c = 0;
        bitacora.Beneficiarios__c = 0 ;
        bitacora.Beneficiarios_Correctos__c = 0 ;
        bitacora.Clientes_Correctos__c = 0;
        bitacora.Cuentas_Correctas__c = 0;
        Http http = new Http();
        list<Beneficiario__c> listBeneficiarios = new list<Beneficiario__c>();
        list<account> listClientes = new list<account>();
        list<cuentas__C> listCuentas = new list<cuentas__C>();
        try{
            HttpRequest request = new HttpRequest();
            request.setEndpoint(URL + 'api/sync');
            request.setMethod('POST');
            request.setTimeout(120000); 
            map<string, string> mapUsuario = new map<string, string> ();
            map<string, string> mapPais = new map<string, string> ();
            map<string, string> mapNacionalidad = new map<string, string> ();
            map<string, string> mapCuentasCo = new map<string, string> ();
            for(user item: [select id, codigo__C from user where isActive = true and codigo__C!=null]){
                mapUsuario.put(item.codigo__C, item.id);
            }
            for(pais_r__C item : [select codigo__C, name, nacionalidad__c,id from pais_r__C]){
                mapPais.put(item.Codigo__c, item.name);
                mapNacionalidad.put(item.Codigo__c, item.nacionalidad__c);
                mapNacionalidad.put(item.nacionalidad__c, item.nacionalidad__c);
            }
            for(Cuentas__C item : [select codigo__C, name from cuentas__C where Colectiva__c = true]){
                mapCuentasCo.put(item.Codigo__c, item.name);
            }
            //integer resta = (datetime.now().hour() == 21 || datetime.now().hour() == 23) ? -2 : datetime.now().hour() == 7 ? -8 : -1;
            datetime hora = datetime.now();
            
            String cons;
            cons = 'contenido={"accion":"I", "idCliente":"'+idCliente+'"}';
            
            
            system.debug('Mandamos:'+cons);
            request.setBody(cons);
            HttpResponse response = new HttpResponse();
            
            if(!test.isRunningTest()){
                response = http.send(request); 
            }else{
                response.setBody('{"codigo":200,"mensaje":"Se han encontrado 3 clientes naturales.","clientes": [{"numeroClienteBanco":271875,"nombres":"ZOE GERALDINE","apeliidos":"ULLOA MARADIAGA","estadoCivil":"S","nombreConyugue":null,"sexo":"F","lugarNacimiento":"tegucigalpa","nacionalidad":"074","fechaNacimiento":"03-OCT-94","profesion":"33","nivelIngreso":null,"nombreReferenciaUno":"CARLOS  ESCOTO","telefonoReferenciaUno":"99999999","nombreReferenciaDos":"MARIELL  SIERRA","telefonoReferenciaDos":"89898989","tipoIdentificacion":"1","identificacion":"0801-1994-11017","correo":"wendy.alvarado@ficohsa.com","telefonoDomicilio":null,"telefonoCelular":null,"fechaIngresoFPC":"01-ENE-16","tipoTrabajador":"1","nombreEmpresa":"ADMINISTRADORA DE FONDOS DE PENSIONES FICOHSA S.A.","tipoEmpresa":"N","identificacionEmpresa":"08019015715256","cargoEmpresa":"OFTEC","giroNegocio":"15","paisResidencia":"1","departamentoResidencia":null,"ciudadResidencia":null,"coloniaResidencia":null,"puntoReferenciaResidencia":"(Sin Direccion)","paisTrabajo":"074","departamentoTrabajo":null,"ciudadTrabajo":null,"coloniaTrabajo":null,"puntoReferenciaTrabajo":"(Sin Direccion)","cuentas":[{"sCuenta":"104527","asesor":"HN22258","cuentaActiva":"A","fondo":"P","producto":"01","formaAporte":"TL","fechaApertura":"10-FEB-20","subProducto":"FI010","cuentaColectiva":"33101","causa":"01","fondoInversion":"101","frecuenciaAporte":"M","montoAporte":"0","divisa":"01","codigoBarra":"FPC20200210","seguroVida":"N","beneficiarios":[{"primerNombre":null,"segundoNombre":null,"primerApellido":null,"segundoApellido":null,"tipoId":null,"identidad":null,"idExterno":null,"sexo":null,"porcentaje":null,"fechaNacimiento":null,"gradoParentesco":null,"parentesco":null}]}]}]}');
                response.setStatusCode(200);
            }
            system.debug('Respuesta Clientes: '+response.getBody()+'-----');
            if(response.getStatusCode() == 200 && response.getBody() != null && response.getBody().trim() !='') {
                string contenido = response.getBody().trim();
                contenido = contenido.replace(' "', '"');
                contenido = contenido.replace('" ', '"');
                contenido = contenido.replace('""', 'null');
                response.setBody(contenido);
                RespuestaSync respuesta = (RespuestaSync)System.JSON.deserialize(response.getBody(), RespuestaSync.class);
                list<clientes> listClientesSysde =respuesta.Clientes;// (list<clientes>)System.JSON.deserialize(response.getBody(), list<clientes>.class);
                string tipoRegistro = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
                map<string, string> mapMunicipios= new map<string, string>(); 
                map<string, string> mapEstadoCivil= new map<string, string>(); 
                Schema.DescribeFieldResult fieldResult = account.Ciudad_Trabajo2__c.getDescribe();   
                for(Schema.PicklistEntry p : fieldResult.getPicklistValues()){          
                    mapMunicipios.put(p.getvalue(), p.getLabel());  
                }
                fieldResult = account.estado_civil__pc.getDescribe();   
                for(Schema.PicklistEntry p : fieldResult.getPicklistValues()){          
                    mapEstadoCivil.put(p.getvalue().substring(0, 1), p.getLabel());  
                }
                if(listClientesSysde !=null){
                    for(Clientes item : listClientesSysde){
                        //system.debug(item.numeroClienteBanco);
                        if(item.correo != null){
                            item.correo = item.correo.replace(' ', '@');
                            item.correo = !item.correo.contains('@.') ? item.correo : 'notiene@ejemplo.hn';
                            
                        }
                        item.nacionalidad = item.nacionalidad != null ? item.nacionalidad.toUpperCase() : null;
                        listClientes.add(new account(
                            firstname = item.nombres, lastName = item.apeliidos, Cliente_Unico_Banco__c= item.numeroClienteBanco,
                            activo__C =true, RecordTypeId=tipoRegistro, tipo_identificacion__C = item.tipoIdentificacion,
                            identificacion__C = item.identificacion.replace('-',''), sexo__C = item.sexo, estado_civil__pc =item.estadoCivil != null && mapEstadoCivil.containsKey(item.estadoCivil) ? mapEstadoCivil.get(item.estadoCivil) : null ,
                            PersonEmail  = item.correo, Nombre_Conyugue__pc  = item.nombreConyugue, Nacionalidad__pc =mapNacionalidad.containsKey(item.nacionalidad) ? mapNacionalidad.get(item.nacionalidad) : null,
                            Celular__c = item.telefonoCelular, Phone =item.telefonoDomicilio, Lugar_Nacimiento__c =item.lugarNacimiento,
                            Profesi_n_Ocupaci_n__c  = item.profesion,   
                             Pais_Trabajo__c = mapPais.containsKey(item.paisTrabajo) ? mapPais.get(item.paisTrabajo) : null , Departamento_Trabajo2__c =item.departamentoTrabajo,
                            Ciudad_Trabajo2__c = item.departamentoTrabajo !=null && item.ciudadTrabajo !=null && mapMunicipios.containsKey((item.departamentoTrabajo+'-'+item.ciudadTrabajo))  ? (item.departamentoTrabajo+'-'+item.ciudadTrabajo) : '000', 
                            Punto_Referencia_Trabajo__c  = item.puntoReferenciaTrabajo, Pais_Residencia__c  = mapPais.containsKey(item.paisResidencia) ? mapPais.get(item.paisResidencia) : null,
                            Departamento_Residencia2__c =item.departamentoResidencia, 
                            Ciudad_Residencia2__c =item.departamentoResidencia !=null && item.ciudadResidencia !=null && item.departamentoResidencia != '000' && item.ciudadResidencia != '000' ? (item.departamentoResidencia+'-'+item.ciudadResidencia) : '000',
                            Punto_Referencia_Residencia__c =item.puntoReferenciaResidencia, Nombre1__c =item.nombreReferenciaUno,
                            Telefono1__c = item.telefonoReferenciaUno, Nombre2__c = item.nombreReferenciaDos, Telefono2__c= item.telefonoReferenciaDos,
                            Tipo_trabajador__c  = item.tipoTrabajador !=null ? item.tipoTrabajador.replace('.0','') : null, Nombre_empresa__c  = item.nombreEmpresa, Tipo_Empresa__c =item.tipoEmpresa,
                            RTN_Empresa__c = item.identificacionEmpresa,
                            Cargo_desempena__pc = item.cargoEmpresa, Nivel_Ingreso__c  = item.nivelIngreso, sector_n__C = item.giroNegocio,
                            Fecha_ingreso_Empresa__pc  = convertStringDate(item.fechaIngresoFPC) ));
                        if(item.fechaNacimiento !=null){
                            listClientes[listClientes.size() -1].PersonBirthdate = convertStringDate(item.fechaNacimiento);
                        }
                        if(item.asesor !=null && mapUsuario.containskey(item.asesor)){
                            listClientes[listClientes.size() -1].ownerid = mapUsuario.get(item.asesor);
                        }
                        
                        if(item.departamentoTrabajo !=null && item.ciudadTrabajo !=null && item.coloniaTrabajo !=null){
                            listClientes[listClientes.size() -1].Colonia_Avenida_Trabajo__r  =new Colonia__C(Codigo_Municipio_Colonia__c = item.departamentoTrabajo+'-'+item.ciudadTrabajo+'-'+item.coloniaTrabajo);
                        }
                        
                       if(item.departamentoResidencia !=null  && item.ciudadResidencia !=null && item.coloniaResidencia !=null){
                            listClientes[listClientes.size() -1].Colonia_Avenida_Residencia__r  =new Colonia__C(Codigo_Municipio_Colonia__c = item.departamentoResidencia+'-'+item.ciudadResidencia+'-'+item.coloniaResidencia); 
                            
                        }
                        
                        if(item.cuentas != null){
                            for(Cuentas itemCuentas : item.cuentas){
                                 listCuentas.add(new cuentas__C(
                                        cliente__r = new Account(cliente_unico_banco__C = item.numeroClienteBanco) , name = itemCuentas.Scuenta, codigo__C =itemCuentas.scuenta,
                                        producto__r = new producto__C (codigo__C = itemCuentas.producto), subproducto__r = new subproducto__C(codigo__C = itemCuentas.subProducto),
                                        activo__C = itemCuentas.cuentaActiva != 'I' ? true : false,
                                        tipo_fondo__C = itemCuentas.fondo == null || itemCuentas.fondo.trim() =='' ? 'I' : itemCuentas.fondo  , Fondo_Inversion__c = itemCuentas.fondoInversion, causa__C = itemCuentas.causa, 
                                        fecha_apertura__C = convertStringDate(itemCuentas.fechaApertura),
                                        Frecuencia_Aportacion__c  = itemCuentas.frecuenciaAporte,
                                        Monto_aporte__c = convertStringDecimal(itemCuentas.montoAporte), forma_aportacion__C = itemCuentas.formaAporte, Seguro_Vida__c = itemCuentas.seguroVida == 'S' ? true : false,
                                        Codigo_Barra__c = itemCuentas.codigoBarra,// tipo_comision__C = itemCuentas.tipoComision, //*Matriz_Comision__c = itemCuentas.matrizComision,
                                        CurrencyIsoCode = (itemCuentas.producto == '01' || itemCuentas.producto == '03') ? 'HNL' : 'USD' ));
                                    if(itemCuentas.cuentaColectiva !=null && mapCuentasCo.containsKey(itemCuentas.cuentaColectiva)){
                                        listCuentas[listCuentas.size() -1].cuenta_colectiva2__r = new cuentas__C(codigo__C = itemCuentas.cuentaColectiva);
                                    }
                                    if(itemCuentas.asesor !=null && mapUsuario.containskey(itemCuentas.asesor)){
                                        listClientes[listClientes.size() -1].ownerid = mapUsuario.get(itemCuentas.asesor);
                                    }
                                
                                if(itemCuentas.Beneficiarios !=null){
                                    for(Beneficiarios Bene : itemCuentas.Beneficiarios){
                                        if(convertStringDecimal(Bene.idExterno) != null){
                                            listBeneficiarios.add(new Beneficiario__c(
                                                Cuenta__r = new cuentas__C(codigo__C = itemCuentas.sCuenta),Id_Externo__c  = convertStringDecimal(Bene.idExterno),
                                                Primer_Nombre__c  = Bene.primerNombre, Segundo_Nombre__c = Bene.segundoNombre, Primer_Apellido__c  = Bene.primerApellido,
                                                Segundo_Apellido__c = Bene.segundoApellido, Fecha_Nacimiento__c =convertStringDate( Bene.fechaNacimiento),
                                                parentesco__C = Bene.parentesco, Grado_Parentesco__C = Bene.gradoParentesco, porcentaje__C= convertStringDecimal(Bene.porcentaje),
                                                sexo__C = Bene.sexo != 'F' ? 'Masculino' : 'Femenino', Identidad__c  =Bene.identidad, Tipo_de_Identificaci_n__c =Bene.tipoId//,
                                            ));
                                        }
                                        
                                        
                                    }
                                } 
                                
                            }
                        }
                        
                        
                    }
                }
                
                
            }
            system.debug('--------UPSERT CLIENTES--------');
            //asysdeCallouts.fechaCierreSysde(date.today());
            //database.upsert(listClientes, account.cliente_unico_banco__c, true);
            database.UpsertResult[] result = database.upsert(listClientes, account.cliente_unico_banco__c, false);
            list<account> listClientesIden = new list<account>();
            for(account item :listClientes){
                if(item.id == null){
                    listClientesIden.add(item);
                }
            }
            
            integer i = 0;
            for(database.UpsertResult item : result){
                if(item.isSuccess()){
                    i++;
                }else{
                    system.debug('Error Cliente: '+item.getErrors());
                }
            }
            result = database.upsert(listClientesIden, account.identificacion__C, false);
            for(database.UpsertResult item : result){
                if(item.isSuccess()){
                    i++;
                }else{
                    system.debug('Error Cliente: '+item.getErrors());
                }
            }
            bitacora.Clientes_Correctos__C = i ;
            bitacora.Clientes__c = listClientes.size();
            //system.debug(' tamano'+listCuentas.size());
            list<cuentas__C> listCuentasUpse = new list<cuentas__C>();
            for(cuentas__C item: listCuentas){
                cuentas__C v = new cuentas__C();
                date fecha = item.Fecha_Apertura__c != null ? date.valueOf(item.Fecha_Apertura__c.year()+'-'+item.Fecha_Apertura__c.month()+'-'+item.Fecha_Apertura__c.day()) : null;
                if(fecha!=null){
                    v.Fecha_Apertura__c=fecha;
                }
                v.Name=item.name;
                v.cliente__r = new Account(cliente_unico_banco__C = item.cliente__r.cliente_unico_banco__C);
                v.Producto__r = new producto__C(codigo__C = item.Producto__r.codigo__C);
                v.Subproducto__r = new Subproducto__C(codigo__C = item.Subproducto__r.codigo__C);
                v.Codigo__c=item.Codigo__c;
                v.Activo__c=item.Activo__c;
                v.Tipo_Fondo__c=item.Tipo_Fondo__c;
                v.Fondo_Inversion__c=item.Fondo_Inversion__c;
                v.Causa__c=item.Causa__c;
                if(item.cuenta_colectiva2__r.codigo__C !=null){
                    v.cuenta_colectiva2__r = new cuentas__C(codigo__C = item.cuenta_colectiva2__r.codigo__C);
                }
                v.Frecuencia_Aportacion__c=item.Frecuencia_Aportacion__c;
                v.Monto_aporte__c=item.Monto_aporte__c;
                v.Forma_Aportacion__c=item.Forma_Aportacion__c;
                v.Seguro_Vida__c=item.Seguro_Vida__c;
                v.Codigo_Barra__c=item.Codigo_Barra__c;
                v.tipo_comision__C = item.tipo_comision__C;
                v.Matriz_Comision__c = item.Matriz_Comision__c;
                v.CurrencyIsoCode = item.CurrencyIsoCode;
                //v.Fecha_ingreso_Empresa__pc = item.Fecha_ingreso_Empresa__pc;
                listCuentasUpse.add(v);
            }
            system.debug('--------UPSERT CUENTAS--------');
            result =   database.upsert(listCuentasUpse, cuentas__c.codigo__C, false);
            i = 0;
            for(database.UpsertResult item : result){
                if(item.isSuccess()){
                    i++;
                }else{
                    system.debug('Error cuentas: '+item.getErrors());
                }
            }
            bitacora.Cuentas_Correctas__C = i;
            bitacora.Cuentas__c = listCuentasUpse.size();
             system.debug('--------UPSERT BENEFICIARIOS--------');
            result =   database.upsert(listBeneficiarios, Beneficiario__c.Id_externo__C, false);
            i = 0;
            for(database.UpsertResult item : result){
                if(item.isSuccess()){
                    i++;
                }else{
                    system.debug('Error Beneficiarios: '+item.getErrors());
                }
            }
            bitacora.Beneficiarios__c = listBeneficiarios.size();
            bitacora.Beneficiarios_Correctos__C = i;
            // system.debug('Wendy esto es un exito');
            bitacora.resultado__C = 'Éxitoso';
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+ ', Linea: '+ex.getLineNumber());
            bitacora.resultado__C = 'Error: '+ex.getMessage()+ ', Linea: '+ex.getLineNumber();
            database.UpsertResult[] result =  database.upsert(listClientes, account.cliente_unico_banco__C, false);
            integer i = 0;
            for(database.UpsertResult item : result){
                if(item.isSuccess()){
                    i++;
                }
            }
            bitacora.Clientes_Correctos__C = i ;
            bitacora.Clientes__c = listClientes.size();
        }
        
        
    }
   
    public static Date convertStringDate(String stringDate){
        try{
            list<String> separador = stringDate.split('-');
            Date fecha = date.valueOf(dateTime.newInstance(integer.valueOf(separador[2])+ (integer.valueOf(separador[2]) > (date.today().year() - 2000) ? 1900 :2000), MesLetras(separador[1]), integer.valueOf(separador[0])));
            return fecha;
        }catch(Exception ex){
            return convertStringDateOther(stringDate);
        }
        
    }
    public static Date convertStringDateOther(String stringDate){
        try{
            list<String> separador = stringDate.split('/');
            Date fecha = date.valueOf(dateTime.newInstance(integer.valueOf(separador[2])+ (integer.valueOf(separador[2]) > (date.today().year() - 2000) ? 1900 :2000),integer.valueOf(separador[1]) , integer.valueOf(separador[0])));
            return fecha;
        }catch(Exception ex){
            return null;
        }
        
    }
    public static Decimal convertStringDecimal(String stringNumber){
        try{
            if(stringNumber != null){
                return decimal.valueOf(StringNumber);
            }
        }catch(Exception ex){
            return convertStringDecimalOther(stringNumber);
        }
        return 1.1;
    }
    
    public static Decimal convertStringDecimalOther(String stringNumber){
        try{
            return decimal.valueOf(stringNumber.replace(',', '.'));
        }catch(Exception ex){
            return null;
        }
        
    }
    
    public static integer MesLetras (string mes){
        integer respuesta ;
        try{
            if(mes=='JAN' || mes=='ENE'){respuesta = 1;}
            if(mes=='FEB'){respuesta = 2;}
            if(mes=='MAR'){respuesta = 3;}
            if(mes=='APR' || mes=='ABR'){respuesta = 4;}
            if(mes=='MAY' ){respuesta = 5;}
            if(mes=='JUN' ){respuesta = 6;}
            if(mes=='JUL' ){respuesta = 7;}
            if(mes=='AUG' || mes=='AGO'){respuesta = 8;}
            if(mes=='SEP' ){respuesta = 9;}
            if(mes=='OCT' ){respuesta = 10;}
            if(mes=='NOV' ){respuesta = 11;}
            if(mes=='DEC' || mes=='DIC'){respuesta = 12;}
            
        }catch(exception ex){
            system.debug('error: '+ex.getMessage()+ 'Error: '+ex.getLineNumber()+', parametro: '+mes);
        }
        return respuesta;
    }
    
    
    
    
    public class RespuestaSync{
        public integer codigo { get; set; }
        public string mensaje { get; set; }
        public List<Clientes> clientes { get; set; }
    }
    
    public class Clientes{
        list<Cuentas> Cuentas{set;get;}
        public string nombres { get; set; }
        public string apeliidos { get; set; }
        public string numeroClienteBanco { get; set; }
        // public string activo { get; set; }
        public string tipoRegistro { get; set; }
        public string tipoIdentificacion { get; set; }
        public string identificacion { get; set; }
        public string sexo { get; set; }
        public string estadoCivil { get; set; }
        public string correo { get; set; }
        public string nombreConyugue { get; set; }
        public string nacionalidad { get; set; }
        public string telefonoCelular { get; set; }
        public string telefonoDomicilio { get; set; }
        public string lugarNacimiento { get; set; }
        public string profesion { get; set; }
        public string fechaNacimiento { get; set; }
        public string fechaIngresoFPC { get; set; }
        //public string numeroFormulario { get; set; }
        public string paisTrabajo { get; set; }
        public string departamentoTrabajo { get; set; }
        public string ciudadTrabajo { get; set; }
        public string coloniaTrabajo { get; set; }
        public string puntoReferenciaTrabajo { get; set; }
        public string paisResidencia { get; set; }
        public string departamentoResidencia { get; set; }
        public string ciudadResidencia { get; set; }
        public string coloniaResidencia { get; set; }
        public string puntoReferenciaResidencia { get; set; }
        public string nombreReferenciaUno { get; set; }
        public string telefonoReferenciaUno { get; set; }
        public string nombreReferenciaDos { get; set; }
        public string telefonoReferenciaDos { get; set; }
        public string tipoTrabajador { get; set; }
        public string nombreEmpresa { get; set; }
        public string tipoEmpresa { get; set; }
        public string identificacionEmpresa { get; set; }
        //public string fechaIngresoEmpresa { get; set; }
        public string cargoEmpresa { get; set; }
        public string nivelIngreso { get; set; }
        public string asesor { get; set; }
        
        
        
        //Campos para Personas Juridicas
        public string nombreComercial {get;set;}
        public string  rtn {get;set;} 
        public string  razonSocial {get;set;}
        public string  telefono {get;set;}
        public string  giroNegocio {get;set;}
        public integer  numeroEmpleados {get;set;}
        public string primerAporte {get;set;}
        public string nombreRepresentanteLegal {get;set;}
        //public string cargoEmpresa {get;set;} 
        public string poderEmpresa {get;set;}
        public string rlCorreoElectronico {get;set;}
        public string rlTelefono {get;set;}
        public string c1NombreCompleto {get;set;}
        public string c2NombreCompleto {get;set;}
        public string c3NombreCompleto {get;set;}
        public integer numeroCharlasBrindadas {get;set;}
        public integer cantidadPersonasAsistieron {get;set;}
        public integer totalAfiliados {get;set;}
        public integer totalAfiliadosAportan {get;set;}
        public string totalMontoAporteL {get;set;}
        public string totalMontoAporteD {get;set;}
        public string tipoAdmin {get;set;}
        
        
    }
    
    public class Cuentas{
        public string cliente { get; set; }
        public string sCuenta { get; set; }
        public string producto { get; set; }
        public string subProducto { get; set; }
        public string cuentaColectiva { get; set; }
        public string cuentaActiva { get; set; }
        public string fondo { get; set; }
        public string fondoInversion { get; set; } 
        public string causa { get; set; }
        public string fechaApertura { get; set; }
        //public string fechaAporte { get; set; }
        public string frecuenciaAporte { get; set; }
        public string montoAporte { get; set; }
        public string formaAporte { get; set; }
        public string seguroVida { get; set; } 
        public string codigoBarra { get; set; }
        //public string tipoComision { get; set; } // No sabe Wendy
        //public string matrizComision { get; set; } // No sabe Wendy
        public string divisa { get; set; }
        public string asesor { get; set; }
        list<Beneficiarios> Beneficiarios{get;set;}
    }
    
    public class Beneficiarios{
        //public string cuenta { get; set; }
        public String idExterno { get; set; }
        public String primerNombre { get; set; }
        public String segundoNombre { get; set; }
        public String primerApellido { get; set; }
        public String segundoApellido { get; set; }
        public String fechaNacimiento { get; set; }
        public String parentesco { get; set; }
        public String gradoParentesco { get; set; }
        public String porcentaje { get; set; }
        public String sexo { get; set; }
        public String identidad { get; set; }
        public String tipoId { get; set; }
        // public string telefono { get; set; }
        // public string direccion { get; set; } // No tiene 
    }
}