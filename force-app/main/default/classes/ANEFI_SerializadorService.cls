public class ANEFI_SerializadorService {    
    
    public static String serializarOportunidad(Opportunity oportunidad){
        String oportunidadSerializada = '';
        ANEFI_ServicesDTO.Oportunidad oportunidadDTO = new ANEFI_ServicesDTO.Oportunidad();
        oportunidadDTO.oportunidadId = oportunidad.Id;
        oportunidadDTO.tipoPersona = ANEFI_Utilitarios.obtenerNombreTipoRegistro(oportunidad.RecordTypeId);
        oportunidadDTO.clienteId = oportunidad.AccountId;
        oportunidadDTO.propietarioId = oportunidad.OwnerId;
        oportunidadDTO.oportunidadNombre = oportunidad.Name;
        oportunidadDTO.codigoPersonaEnGestor = oportunidad.Codigo_persona_en_Gestor__c != null ? Integer.valueOf(oportunidad.Codigo_persona_en_Gestor__c) : null;
        oportunidadDTO.numeroCuentaParticipe = oportunidad.Numero_cuenta_de_participe__c;
        oportunidadDTO.codigoProducto = oportunidad.Producto_de_Interes__c;
        oportunidadDTO.codigoTrader = oportunidad.Trader__c;
        oportunidadDTO.complementarios = oportunidad.Complementarios__c;
        oportunidadDTO.transaccionCooparticipe = oportunidad.Transaccion_cooparticipe__c;
        oportunidadDTO.codigoCuentaContable = ANEFI_Utilitarios.CODIGO_CUENTA_CONTABLE;
        oportunidadDTO.numeroTransaccionAporte = oportunidad.Numero_transaccion_aporte_en_gestor__c;        
        Datetime fechaDateTime = DateTime.newInstance(oportunidad.Fecha_efectiva_primer_aporte__c.year(), oportunidad.Fecha_efectiva_primer_aporte__c.month(), oportunidad.Fecha_efectiva_primer_aporte__c.day());        
        oportunidadDTO.fechaEfectiva = fechaDateTime.format('yyyy-MM-dd');        
        oportunidadDTO.numeroDocumento = oportunidad.Numero_documento_deposito__c;
        oportunidadDTO.codigoTipoFormaPago = oportunidad.Forma_de_Pago__c;
        oportunidadDTO.codigoMoneda = oportunidad.Moneda__c;
        oportunidadDTO.monto = oportunidad.Amount;
        oportunidadDTO.codigoTipoEntidadFondo = oportunidad.Codigo_tipo_entidad_financiera__c != null ? String.valueOf(oportunidad.Codigo_tipo_entidad_financiera__c.intValue()) : null;
        oportunidadDTO.codigoEntidadFondo = oportunidad.Codigo_entidad_financiera__c;
        oportunidadDTO.numeroCuentaFondo = oportunidad.Numero_de_cuenta_fondo__c;
        oportunidadSerializada = JSON.serialize(oportunidadDTO);
        
        return oportunidadSerializada;
    }

	/**Método para obtener el input del servicio de validación en listas negras de una persona jurídica*/
    public static ANEFI_ServicesDTO.ListasNegrasJuridicaInput obtInputListasNegrasPersonaJuridica(Id clienteId){
        List<Account> clientes = [Select Id, Name, Numero_de_identificacion__c From Account Where Id =: clienteId];
        if(clientes.size() > 0){
            ANEFI_ServicesDTO.ListasNegrasJuridicaInput listasNegrasJuridicaInputDTO = new ANEFI_ServicesDTO.ListasNegrasJuridicaInput();
            listasNegrasJuridicaInputDTO.identificacion = clientes.get(0).Numero_de_identificacion__c;
            //14 de Septiembre, se comenta esta línea ya que las personas de ANEFI solicitan que solo se envíe número de identifación también para personas jurídicas
            //listasNegrasJuridicaInputDTO.nombre = clientes.get(0).Name;
            return listasNegrasJuridicaInputDTO;            
        }
        return null;        
    }
    
    /**Método para obtener el input del servicio de validación en listas negras de una persona natural*/
    public static ANEFI_ServicesDTO.ListasNegrasNaturalInput obtInputListasNegrasPersonaNatural(Id clienteId){
        List<Account> clientes = [Select Id, Name, Numero_de_identificacion__c from Account where Id =: clienteId];
        if(clientes.size() > 0){
            ANEFI_ServicesDTO.ListasNegrasNaturalInput listasNegrasNaturalInputDTO = new ANEFI_ServicesDTO.ListasNegrasNaturalInput();
            listasNegrasNaturalInputDTO.identificacion = clientes.get(0).Numero_de_identificacion__c;         
            return listasNegrasNaturalInputDTO; 
            
        }
        //jbarco - 14 de Agosto 2020: Se comenta esta sección de código ya que cambian los datos de entrada del servicio de Gestor
        /*List<Contact> contactos = [Select Id, Numero_de_identificacion__c, LastName,FirstName,MiddleName
                                   From Contact Where AccountId =: clienteId];        
        if(contactos.size() > 0){ //existe un contacto asociado a un cliente de tipo persona natural
            String[] apellidos = null;
            apellidos = contactos.get(0).LastName.Split(' ');
            ANEFI_ServicesDTO.ListasNegrasNaturalInput listasNegrasNaturalInputDTO = new ANEFI_ServicesDTO.ListasNegrasNaturalInput();
            listasNegrasNaturalInputDTO.identificacion = contactos.get(0).Numero_de_identificacion__c;
            listasNegrasNaturalInputDTO.primerNombre = contactos.get(0).FirstName;
            listasNegrasNaturalInputDTO.segundoNombre = contactos.get(0).MiddleName != null ? contactos.get(0).MiddleName : '';
            listasNegrasNaturalInputDTO.primerApellido = apellidos != null ? apellidos[0]: '';
            listasNegrasNaturalInputDTO.segundoApellido = apellidos != null && apellidos.size() > 1 ? apellidos[1] : '';
            return listasNegrasNaturalInputDTO;            
        }
        else{//No existe un contacto asociado a un cliente de tipo persona natural, los datos deben ser tomados del objeto Cuenta
            List<Account> clientes = [Select Id, Name, Numero_de_identificacion__c from Account where Id =: clienteId];
            if(clientes.size() > 0){
                ANEFI_ServicesDTO.ListasNegrasNaturalInput listasNegrasNaturalInputDTO = new ANEFI_ServicesDTO.ListasNegrasNaturalInput();
            	listasNegrasNaturalInputDTO.identificacion = clientes.get(0).Numero_de_identificacion__c;
                String[] nombresApellidos = clientes.get(0).Name.Split(' ');
                ANEFI_ServicesDTO.NombresApellidosClienteNatural nombresApellidosClienteNatural = obtNombresApellidosClienteNatural(nombresApellidos);
                listasNegrasNaturalInputDTO.primerApellido = nombresApellidosClienteNatural.primerApellido;
                listasNegrasNaturalInputDTO.primerNombre = nombresApellidosClienteNatural.primerNombre;
                listasNegrasNaturalInputDTO.segundoApellido = nombresApellidosClienteNatural.segundoApellido;
                listasNegrasNaturalInputDTO.segundoNombre = nombresApellidosClienteNatural.segundoNombre;
                return listasNegrasNaturalInputDTO; 
            }
        }*/
        
        return null;        
    }
    
    /*Método para calcular los nombres y apellidos de una cliente tipo persona natural*/
    public static ANEFI_ServicesDTO.NombresApellidosClienteNatural obtNombresApellidosClienteNatural(String[] nombresApellidos){
        ANEFI_ServicesDTO.NombresApellidosClienteNatural nombresApellidosClienteNatural = new ANEFI_ServicesDTO.NombresApellidosClienteNatural();
        if(nombresApellidos != null){
            Integer arraySize = nombresApellidos.size();
            switch on arraySize{
                when 4,5{
                    nombresApellidosClienteNatural.primerNombre = nombresApellidos[0];
                    nombresApellidosClienteNatural.segundoNombre = nombresApellidos[1];
                    nombresApellidosClienteNatural.primerApellido = nombresApellidos[2];
                    nombresApellidosClienteNatural.segundoApellido = nombresApellidos[3];
                }
                when 3{
                    nombresApellidosClienteNatural.primerNombre = nombresApellidos[0];
                    nombresApellidosClienteNatural.segundoNombre = nombresApellidos[1];
                    nombresApellidosClienteNatural.primerApellido = nombresApellidos[2];
                    nombresApellidosClienteNatural.segundoApellido = ' ';
                }
                when 2{
                    nombresApellidosClienteNatural.primerNombre = nombresApellidos[0];
                    nombresApellidosClienteNatural.segundoNombre = ' ';
                    nombresApellidosClienteNatural.primerApellido = nombresApellidos[1];
                    nombresApellidosClienteNatural.segundoApellido = ' ';
                }
                when 1{
                    nombresApellidosClienteNatural.primerNombre = nombresApellidos[0];
                    nombresApellidosClienteNatural.segundoNombre = ' ';
                    nombresApellidosClienteNatural.primerApellido = ' ';
                    nombresApellidosClienteNatural.segundoApellido = ' ';
                }
                when else{
                    nombresApellidosClienteNatural.primerNombre = nombresApellidos[0];
                    nombresApellidosClienteNatural.segundoNombre = nombresApellidos[1];
                    nombresApellidosClienteNatural.primerApellido = nombresApellidos[2];
                    nombresApellidosClienteNatural.segundoApellido = nombresApellidos[3];
                }
            } 
        }
        return nombresApellidosClienteNatural;
    }

	/*Método para obtener el input del servicio de validación en registros de cliente*/
    public static ANEFI_ServicesDTO.RegistroClienteInput obtInputValidacionRegistroCliente(String clienteId){
        
        List<Account> clientes = [Select Id, Tipo_de_identificacion__c , Numero_de_identificacion__c From Account Where Id =: clienteId];
        if(clientes.size() > 0){
            ANEFI_ServicesDTO.RegistroClienteInput registroClienteInput = new ANEFI_ServicesDTO.RegistroClienteInput();
            registroClienteInput.codigoTipoIdentificacion = clientes.get(0).Tipo_de_identificacion__c;
            registroClienteInput.identificacion = clientes.get(0).Numero_de_identificacion__c;
            return registroClienteInput;
        }
        return null;
    }

	/**Método para obtener el input del servicio de creación de persona Natural*/
    public static ANEFI_ServicesDTO.RegistroPersonaNaturalInput obtInputRegistroPersonaNatural(Id clienteId){
        List<Account> clientes = [Select Id, 
                                  (Select FirstName,MiddleName,LastName,Rol_en_la_empresa__c,Nombre_empresa_donde_trabaja__c 
                                   from contacts ), 
                                  Name, Tipo_de_identificacion__c, Numero_de_identificacion__c, Correo_electronico__c, 
                                  Codigo_pais_nacionalidad__c, Paga_impuestos__c, Telefono_celular__c, 
                                  Codigo_pais_de_nacimiento__c, Codigo_provincia_de_nacimiento__c, 
                                  Secuencia_canton_de_nacimiento__c, Codigo_canton_nacimiento__c, Fecha_de_nacimiento__c, 
                                  Estado_civil__c, Genero__c, Codigo_pais_direccion_domicilio__c, 
                                  Codigo_canton_direccion_domicilio__c, Secuencia_canton_direccion_domicilio__c, 
                                  Codigo_provincia_direccion_domicilio__c, Calle_principal_direccion_domicilio__c, 
                                  Referencia_direccion_domicilio__c, Telefono_domicilio__c, 
                                  Es_direccion_fiscal_direccion_domicilio__c, Tipo_de_empleo__c, 
                                  Codigo_actividad_economica__c, Politicamente_expuesto__c, Phone, Total_activos__c, 
                                  Total_pasivos__c, Total_patrimonio__c, Total_gastos__c, Entidad_financiera__c, 
                                  Entidad_Financiera__r.Tipo_de_entidad__c,Entidad_Financiera__r.Name, 
                                  Numero_de_cuenta_bancaria__c, Tipo_de_cuenta_bancaria__c,
                                  Ingresos_mensuales__c
                                  From Account Where Id =: clienteId];
        
        if(clientes.size() > 0){
            Account cliente = clientes.get(0);
            List<Contact> contactos = cliente.contacts;
            String[] apellidos = null;
            ANEFI_ServicesDTO.NombresApellidosClienteNatural nombresApellidosClienteNatural = new ANEFI_ServicesDTO.NombresApellidosClienteNatural(); 
            if(contactos.size () > 0){ //Existe un contacto asociado al cliente de tipo persona natural
                apellidos = contactos.get(0).LastName.Split(' ');
                nombresApellidosClienteNatural.primerApellido = apellidos != null ? apellidos[0]: '';
                nombresApellidosClienteNatural.primerNombre = contactos.size() > 0 ? contactos.get(0).FirstName : '';
                nombresApellidosClienteNatural.segundoApellido = apellidos != null && apellidos.size() > 1 ? apellidos[1] : ' ';
                nombresApellidosClienteNatural.segundoNombre = contactos.size() > 0 ? contactos.get(0).MiddleName : '';
            }
            else{//No existe un contacto asociado al cliente de tipo persona natural, los datos deben ser tomados del objecto cuenta
                String[] nombresApellidos = cliente.Name.Split(' ');
                nombresApellidosClienteNatural = obtNombresApellidosClienteNatural(nombresApellidos);
            }
             
            ANEFI_ServicesDTO.RegistroPersonaNaturalInput registroPersonaNaturalInput = new ANEFI_ServicesDTO.RegistroPersonaNaturalInput();
            registroPersonaNaturalInput.callePrincipalDireccionDomicilio = cliente.Calle_principal_direccion_domicilio__c;
            registroPersonaNaturalInput.cargo = contactos.size() > 0 ? contactos.get(0).Rol_en_la_empresa__c : null;
            registroPersonaNaturalInput.codigoCantonDireccionDomicilio = cliente.Codigo_canton_direccion_domicilio__c;
            registroPersonaNaturalInput.codigoCantonNacimiento = cliente.Codigo_canton_nacimiento__c;
            registroPersonaNaturalInput.codigoEntidadFinancieraCuentaBancaria = cliente.Entidad_financiera__c != null ? cliente.Entidad_Financiera__r.Name : '';
            registroPersonaNaturalInput.codigoEstadoCivil = cliente.Estado_civil__c;
            registroPersonaNaturalInput.codigoPaisDireccionDomicilio = cliente.Codigo_pais_direccion_domicilio__c;
            registroPersonaNaturalInput.codigoPaisNacimiento = cliente.Codigo_pais_de_nacimiento__c;
            registroPersonaNaturalInput.codigoPaisNacionalidad = cliente.Codigo_pais_nacionalidad__c;
            registroPersonaNaturalInput.codigoProvinciaDireccionDomicilio = cliente.Codigo_provincia_direccion_domicilio__c;
            registroPersonaNaturalInput.codigoProvinciaNacimiento = cliente.Codigo_provincia_de_nacimiento__c;
            registroPersonaNaturalInput.codigoTipoActividadEconomica = cliente.Codigo_actividad_economica__c;
            registroPersonaNaturalInput.codigoTipoCuentaBancaria = cliente.Tipo_de_cuenta_bancaria__c;
            registroPersonaNaturalInput.codigoTipoDireccionDomicilio = 'D'; //Dirección tipo domicilio
            registroPersonaNaturalInput.codigoTipoEmpleo = cliente.Tipo_de_empleo__c;
            registroPersonaNaturalInput.codigoTipoEntidadFinancieraCuentaBancaria = cliente.Entidad_financiera__c != null ? String.valueOf(cliente.Entidad_Financiera__r.Tipo_de_entidad__c) : '';
            registroPersonaNaturalInput.codigoTipoIdentificacion = cliente.Tipo_de_identificacion__c;
            registroPersonaNaturalInput.codigoTipoTelefonoCelular = '3'; //Tipo de teléfono celular
            registroPersonaNaturalInput.codigoTipoTelefonoDomicilio = '1'; //Tipo de teléfono domicilio
            registroPersonaNaturalInput.codigoTipoTelefonoOficina = '2'; //Tipo de teléfono trabajo
            registroPersonaNaturalInput.codigoTotalActivo = '010'; //Valor por defecto para activos
            registroPersonaNaturalInput.codigoTotalPasivo = '011'; //Valor por defecto para pasivos
            registroPersonaNaturalInput.correoElectronico = cliente.Correo_electronico__c;
            registroPersonaNaturalInput.esDireccionFiscalDireccionDomicilio = cliente.Es_direccion_fiscal_direccion_domicilio__c;
            Datetime fechaDateTime = cliente.Fecha_de_nacimiento__c;
            registroPersonaNaturalInput.fechaNacimiento = cliente.Fecha_de_nacimiento__c.Year() + '-' + cliente.Fecha_de_nacimiento__c.Month() + '-' + cliente.Fecha_de_nacimiento__c.Day();//fechaDateTime.format('yyyy-MM-dd');
            registroPersonaNaturalInput.genero = cliente.Genero__c;
            registroPersonaNaturalInput.identificacion = cliente.Numero_de_identificacion__c;
            registroPersonaNaturalInput.lugarTrabajo = contactos.size() > 0 ? contactos.get(0).Nombre_empresa_donde_trabaja__c : null;
            registroPersonaNaturalInput.numeroCuentaBancaria = cliente.Numero_de_cuenta_bancaria__c;
            registroPersonaNaturalInput.primerNombre = nombresApellidosClienteNatural.primerNombre;
            registroPersonaNaturalInput.primerApellido = nombresApellidosClienteNatural.primerApellido;
            registroPersonaNaturalInput.pagaImpuestos = cliente.Paga_impuestos__c;
            registroPersonaNaturalInput.politicamenteExpuesto = cliente.Politicamente_expuesto__c;
            registroPersonaNaturalInput.referenciaDireccionDomicilio = cliente.Referencia_direccion_domicilio__c;
            registroPersonaNaturalInput.segundoNombre = nombresApellidosClienteNatural.segundoNombre;
            registroPersonaNaturalInput.segundoApellido = nombresApellidosClienteNatural.segundoApellido;
            registroPersonaNaturalInput.secuenciaProvinciaNacimiento = 1;//es la secuencia por defecto de las provincias
            registroPersonaNaturalInput.secuenciaCantonNacimiento = Integer.valueOf(cliente.Secuencia_canton_de_nacimiento__c);
            registroPersonaNaturalInput.secuenciaProvinciaDireccionDomicilio = 1;
            registroPersonaNaturalInput.secuenciaCantonDireccionDomicilio = Integer.valueOf(cliente.Secuencia_canton_direccion_domicilio__c);
            registroPersonaNaturalInput.telefonoCelular = cliente.Telefono_celular__c;
            registroPersonaNaturalInput.telefonoDomicilio = cliente.Telefono_domicilio__c;
            registroPersonaNaturalInput.telefonoOficina = cliente.Phone;
            registroPersonaNaturalInput.totalActivos = cliente.Total_activos__c;
            registroPersonaNaturalInput.totalPasivos = cliente.Total_pasivos__c;
            registroPersonaNaturalInput.totalPatrimonio = cliente.Total_patrimonio__c;
            registroPersonaNaturalInput.valorIngresosSueldoMensual = cliente.Ingresos_mensuales__c;
            registroPersonaNaturalInput.valorGastoMensual = cliente.Total_gastos__c;            
            return registroPersonaNaturalInput;            
        }
        return null;        
    }    
    
    /**Método para obtener el input del servicio de actualización de persona Natural*/
    public static ANEFI_ServicesDTO.ActualizarPersonaNaturalInput obtInputActualizacionPersonaNatural(Id clienteId){
        List<Account> clientes = [Select Id, 
                                  (Select FirstName,MiddleName,LastName,Rol_en_la_empresa__c,Nombre_empresa_donde_trabaja__c 
                                   from contacts ), 
                                  PrimerNombre__c, SegundoNombre__c, PrimerApellido__c, SegundoApellido__c,
                                  Name, Tipo_de_identificacion__c, Numero_de_identificacion__c, Correo_electronico__c, 
                                  Codigo_pais_nacionalidad__c, Paga_impuestos__c, Telefono_celular__c, 
                                  Codigo_pais_de_nacimiento__c, Codigo_provincia_de_nacimiento__c, 
                                  Secuencia_canton_de_nacimiento__c, Codigo_canton_nacimiento__c, Fecha_de_nacimiento__c, 
                                  Estado_civil__c, Genero__c, Codigo_pais_direccion_domicilio__c, 
                                  Codigo_canton_direccion_domicilio__c, Secuencia_canton_direccion_domicilio__c, 
                                  Codigo_provincia_direccion_domicilio__c, Calle_principal_direccion_domicilio__c, 
                                  Referencia_direccion_domicilio__c, Telefono_domicilio__c, 
                                  Es_direccion_fiscal_direccion_domicilio__c, Tipo_de_empleo__c, 
                                  Codigo_actividad_economica__c, Politicamente_expuesto__c, Phone, Total_activos__c, 
                                  Total_pasivos__c, Total_patrimonio__c, Total_gastos__c, Entidad_financiera__c, 
                                  Entidad_Financiera__r.Tipo_de_entidad__c,Entidad_Financiera__r.Name, 
                                  Numero_de_cuenta_bancaria__c, Tipo_de_cuenta_bancaria__c,
                                  Ingresos_mensuales__c
                                  From Account Where Id =: clienteId];
        
        if(clientes.size() > 0){
            Account cliente = clientes.get(0);
            List<Contact> contactos = cliente.contacts;
            String[] apellidos = null;
            /*ANEFI_ServicesDTO.NombresApellidosClienteNatural nombresApellidosClienteNatural = new ANEFI_ServicesDTO.NombresApellidosClienteNatural(); 
            if(contactos.size () > 0){ //Existe un contacto asociado al cliente de tipo persona natural
                apellidos = contactos.get(0).LastName.Split(' ');
                nombresApellidosClienteNatural.primerApellido = cliente.PrimerApellido__c != null ? cliente.PrimerApellido__c: '';
                nombresApellidosClienteNatural.primerNombre = cliente.PrimerNombre__c != null ? cliente.PrimerNombre__c: '';
                nombresApellidosClienteNatural.segundoApellido = cliente.SegundoApellido__c != null ? cliente.SegundoApellido__c: '';
                nombresApellidosClienteNatural.segundoNombre = cliente.SegundoNombre__c != null ? cliente.SegundoNombre__c: '';
            }
            else{//No existe un contacto asociado al cliente de tipo persona natural, los datos deben ser tomados del objecto cuenta
                String[] nombresApellidos = cliente.Name.Split(' ');
                nombresApellidosClienteNatural = obtNombresApellidosClienteNatural(nombresApellidos);
            }*/
            
            
            ANEFI_ServicesDTO.NombresApellidosClienteNatural nombresApellidosClienteNatural = new ANEFI_ServicesDTO.NombresApellidosClienteNatural(); 
            nombresApellidosClienteNatural.primerApellido = cliente.PrimerApellido__c != null ? cliente.PrimerApellido__c: '';
            nombresApellidosClienteNatural.primerNombre = cliente.PrimerNombre__c != null ? cliente.PrimerNombre__c: '';
            nombresApellidosClienteNatural.segundoApellido = cliente.SegundoApellido__c != null ? cliente.SegundoApellido__c: '';
            nombresApellidosClienteNatural.segundoNombre = cliente.SegundoNombre__c != null ? cliente.SegundoNombre__c: '';
             
            ANEFI_ServicesDTO.ActualizarPersonaNaturalInput actualizarPersonaNaturalInput = new ANEFI_ServicesDTO.ActualizarPersonaNaturalInput();
            actualizarPersonaNaturalInput.callePrincipalDireccionDomicilio = cliente.Calle_principal_direccion_domicilio__c;
            actualizarPersonaNaturalInput.cargo = contactos.size() > 0 ? contactos.get(0).Rol_en_la_empresa__c : null;
            actualizarPersonaNaturalInput.codigoCantonDireccionDomicilio = cliente.Codigo_canton_direccion_domicilio__c;
            actualizarPersonaNaturalInput.codigoCantonNacimiento = cliente.Codigo_canton_nacimiento__c;
            actualizarPersonaNaturalInput.codigoEntidadFinancieraCuentaBancaria = cliente.Entidad_financiera__c != null ? cliente.Entidad_Financiera__r.Name : '';
            actualizarPersonaNaturalInput.codigoEstadoCivil = cliente.Estado_civil__c;
            actualizarPersonaNaturalInput.codigoPaisDireccionDomicilio = cliente.Codigo_pais_direccion_domicilio__c;
            actualizarPersonaNaturalInput.codigoPaisNacimiento = cliente.Codigo_pais_de_nacimiento__c;
            actualizarPersonaNaturalInput.codigoPaisNacionalidad = cliente.Codigo_pais_nacionalidad__c;
            actualizarPersonaNaturalInput.codigoProvinciaDireccionDomicilio = cliente.Codigo_provincia_direccion_domicilio__c;
            actualizarPersonaNaturalInput.codigoProvinciaNacimiento = cliente.Codigo_provincia_de_nacimiento__c;
            actualizarPersonaNaturalInput.codigoTipoActividadEconomica = cliente.Codigo_actividad_economica__c;
            actualizarPersonaNaturalInput.codigoTipoCuentaBancaria = cliente.Tipo_de_cuenta_bancaria__c;
			actualizarPersonaNaturalInput.codigoTipoDireccionDomicilio = 'D'; //Dirección tipo domicilio            
            actualizarPersonaNaturalInput.codigoTipoEmpleo = cliente.Tipo_de_empleo__c;
            actualizarPersonaNaturalInput.codigoTipoEntidadFinancieraCuentaBancaria = cliente.Entidad_financiera__c != null ? String.valueOf(cliente.Entidad_Financiera__r.Tipo_de_entidad__c) : '';            
            actualizarPersonaNaturalInput.codigoTipoTelefonoDomicilio = '1'; //Tipo de teléfono domicilio
            actualizarPersonaNaturalInput.codigoTipoTelefonoOficina = '2'; //Tipo de teléfono trabajo
            actualizarPersonaNaturalInput.codigoTotalActivo = '010'; //Valor por defecto para activos
            actualizarPersonaNaturalInput.codigoTotalPasivo = '011'; //Valor por defecto para pasivos
            actualizarPersonaNaturalInput.codigoTipoIngresoSueldoMensual = '016'; //Valor por defecto para ingresos
            actualizarPersonaNaturalInput.codigoTipoGastoMensual = '029'; //Valor por defecto para gastos
            actualizarPersonaNaturalInput.esDireccionFiscalDireccionDomicilio = cliente.Es_direccion_fiscal_direccion_domicilio__c;
            Datetime fechaDateTime = cliente.Fecha_de_nacimiento__c;
            actualizarPersonaNaturalInput.fechaNacimiento = cliente.Fecha_de_nacimiento__c != NULL ? cliente.Fecha_de_nacimiento__c.Year() + '-' + cliente.Fecha_de_nacimiento__c.Month() + '-' + cliente.Fecha_de_nacimiento__c.Day() : '';  //fechaDateTime.format('yyyy-MM-dd');
            actualizarPersonaNaturalInput.genero = cliente.Genero__c;
            actualizarPersonaNaturalInput.codigoTipoIdentificacion = cliente.Tipo_de_identificacion__c;
            actualizarPersonaNaturalInput.identificacion = cliente.Numero_de_identificacion__c;
            actualizarPersonaNaturalInput.lugarTrabajo = contactos.size() > 0 ? contactos.get(0).Nombre_empresa_donde_trabaja__c : null;
            actualizarPersonaNaturalInput.numeroCuentaBancaria = cliente.Numero_de_cuenta_bancaria__c;
            actualizarPersonaNaturalInput.primerNombre = nombresApellidosClienteNatural.primerNombre;
            actualizarPersonaNaturalInput.primerApellido = nombresApellidosClienteNatural.primerApellido;
            actualizarPersonaNaturalInput.pagaImpuestos = cliente.Paga_impuestos__c;
            actualizarPersonaNaturalInput.politicamenteExpuesto = cliente.Politicamente_expuesto__c;
            actualizarPersonaNaturalInput.referenciaDireccionDomicilio = cliente.Referencia_direccion_domicilio__c;
            actualizarPersonaNaturalInput.segundoNombre = nombresApellidosClienteNatural.segundoNombre;
            actualizarPersonaNaturalInput.segundoApellido = nombresApellidosClienteNatural.segundoApellido;
            actualizarPersonaNaturalInput.secuenciaProvinciaNacimiento = 1;//es la secuencia por defecto de las provincias
            actualizarPersonaNaturalInput.secuenciaCantonNacimiento = Integer.valueOf(cliente.Secuencia_canton_de_nacimiento__c);
            actualizarPersonaNaturalInput.secuenciaProvinciaDireccionDomicilio = 1;
            actualizarPersonaNaturalInput.secuenciaCantonDireccionDomicilio = Integer.valueOf(cliente.Secuencia_canton_direccion_domicilio__c);
            actualizarPersonaNaturalInput.codigoTipoTelefonoCelular = '3'; //Tipo de teléfono celular
            actualizarPersonaNaturalInput.telefonoCelular = cliente.Telefono_celular__c;
            actualizarPersonaNaturalInput.telefonoDomicilio = cliente.Telefono_domicilio__c;
            actualizarPersonaNaturalInput.telefonoOficina = cliente.Phone;
            actualizarPersonaNaturalInput.totalActivos = cliente.Total_activos__c;
            actualizarPersonaNaturalInput.totalPasivos = cliente.Total_pasivos__c;
            actualizarPersonaNaturalInput.totalPatrimonio = cliente.Total_patrimonio__c;
            actualizarPersonaNaturalInput.valorIngresosSueldoMensual = cliente.Ingresos_mensuales__c;
            actualizarPersonaNaturalInput.valorGastoMensual = cliente.Total_gastos__c;            
            return actualizarPersonaNaturalInput;        
        }
        return null;        
    }    
    
    /**Método para obtener el input del servicio de creación de persona Jurídica*/
    public static ANEFI_ServicesDTO.RegistroPersonaJuridicaInput obtInputRegistroPersonaJuridica(Id clienteId){
        List<Account> clientes = [Select Id, Capital_social__c, Calle_principal_direccion_tributaria__c, 
                                  Calle_principal_direccion_trabajo__c, Cargo_representante_legal__c, 
                                  Codigo_canton_direccion_trabajo__c, Codigo_canton_direccion_tributaria__c, 
                                  Codigo_pais_direccion_tributaria__c, Codigo_pais_direccion_trabajo__c, 
                                  Codigo_pais_nacionalidad__c, Codigo_actividad_economica__c, 
                                  Tipo_de_identificacion__c, Tipo_de_persona_juridica__c, Fecha_de_constitucion__c, 
                                  Numero_de_identificacion__c, Interseccion_direccion_tributaria__c, 
                                  Interseccion_direccion_trabajo__c, Name, Numero_direccion_tributaria__c,
                                  Numero_direccion_trabajo__c, Description, Politicamente_expuesto__c, 
                                  Identificacion_representante_legal__c, Secuencia_canton_direccion_tributaria__c, 
                                  Secuencia_canton_direccion_trabajo__c, Telefono_celular__c, Phone, Total_activos__c, 
                                  Total_pasivos__c, Total_gastos__c, AnnualRevenue,Entidad_financiera__c, 
                                  Entidad_Financiera__r.Tipo_de_entidad__c,Entidad_Financiera__r.Name, 
                                  Numero_de_cuenta_bancaria__c, Tipo_de_cuenta_bancaria__c, Tipo_identificacion_representante_legal__c
                                  From Account Where Id =: clienteId];
        
        if(clientes.size() > 0){
            Account cliente = clientes.get(0);            
             
            ANEFI_ServicesDTO.RegistroPersonaJuridicaInput registroPersonaJuridicaInput = new ANEFI_ServicesDTO.RegistroPersonaJuridicaInput();
            registroPersonaJuridicaInput.callePrincipalDireccionResidenciaTributaria = cliente.Calle_principal_direccion_tributaria__c;
            registroPersonaJuridicaInput.callePrincipalDireccionTrabajo = cliente.Calle_principal_direccion_trabajo__c;
            registroPersonaJuridicaInput.capitalSocial = cliente.Capital_social__c;
            registroPersonaJuridicaInput.cargoRepresentanteLegal = cliente.Cargo_representante_legal__c; //cliente.Cargo_representante_legal__c != null ? cliente.Cargo_representante_legal__c : ' ';
            registroPersonaJuridicaInput.codigoOrgGeoDireccionResidenciaTributaria = cliente.Codigo_canton_direccion_tributaria__c;
            registroPersonaJuridicaInput.codigoOrgGeoDireccionTrabajo = cliente.Codigo_canton_direccion_trabajo__c;
            registroPersonaJuridicaInput.codigoPaisDireccionResidenciaTributaria = cliente.Codigo_pais_direccion_tributaria__c;
            registroPersonaJuridicaInput.codigoPaisDireccionTrabajo = cliente.Codigo_pais_direccion_trabajo__c;
            registroPersonaJuridicaInput.codigoPaisNacionalidad = cliente.Codigo_pais_nacionalidad__c;
            registroPersonaJuridicaInput.codigoTipoActividadEconomica = cliente.Codigo_actividad_economica__c;
            registroPersonaJuridicaInput.codigoTipoIdentificacion = cliente.Tipo_de_identificacion__c;
            registroPersonaJuridicaInput.codigoTipoPersonaJuridica = cliente.Tipo_de_persona_juridica__c;
            Datetime fechaDateTime = cliente.Fecha_de_constitucion__c;            
            registroPersonaJuridicaInput.fechaConstitucion = fechaDateTime != null ? fechaDateTime.format('yyyy-MM-dd') : '';
            registroPersonaJuridicaInput.identificacion = cliente.Numero_de_identificacion__c;
            registroPersonaJuridicaInput.interseccionDireccionResidenciaTributaria = cliente.Interseccion_direccion_tributaria__c;
            registroPersonaJuridicaInput.interseccionDireccionTrabajo = cliente.Interseccion_direccion_trabajo__c;
            registroPersonaJuridicaInput.nombre = cliente.Name;
            registroPersonaJuridicaInput.numeroDireccionResidenciaTributaria = cliente.Numero_direccion_tributaria__c;
            registroPersonaJuridicaInput.numeroDireccionTrabajo = cliente.Numero_direccion_trabajo__c;
            registroPersonaJuridicaInput.observaciones = cliente.Description;
            registroPersonaJuridicaInput.politicamenteExpuesto = cliente.Politicamente_expuesto__c;
            registroPersonaJuridicaInput.razonSocial = cliente.Name;
            registroPersonaJuridicaInput.idRepresentanteLegal = cliente.Identificacion_representante_legal__c;
            registroPersonaJuridicaInput.tipoIdRepresentanteLegal = cliente.Tipo_identificacion_representante_legal__c;
            registroPersonaJuridicaInput.secuenciaOrgGeoDireccionResidenciaTributaria = cliente.Secuencia_canton_direccion_tributaria__c != 0 ? Integer.valueOf(cliente.Secuencia_canton_direccion_tributaria__c) : null;
            registroPersonaJuridicaInput.secuenciaOrgGeoDireccionTrabajo = cliente.Secuencia_canton_direccion_trabajo__c != null ? Integer.valueOf(cliente.Secuencia_canton_direccion_trabajo__c) : null;
            registroPersonaJuridicaInput.telefonoCelular = cliente.Telefono_celular__c;
            registroPersonaJuridicaInput.telefonoConvencional = cliente.Phone;
            registroPersonaJuridicaInput.tipoPersona = 'J'; //siempre se debe enviar este valor
            registroPersonaJuridicaInput.totalActivos = cliente.Total_activos__c;
            registroPersonaJuridicaInput.totalGastos = cliente.Total_gastos__c;
            registroPersonaJuridicaInput.totalIngresos = cliente.AnnualRevenue;
            registroPersonaJuridicaInput.totalPasivos = cliente.Total_pasivos__c;
            registroPersonaJuridicaInput.codigoTipoEntidadFinancieraCuentaBancaria = cliente.Entidad_financiera__c != null ? String.valueOf(cliente.Entidad_Financiera__r.Tipo_de_entidad__c) : '';
            registroPersonaJuridicaInput.codigoEntidadFinancieraCuentaBancaria = cliente.Entidad_financiera__c != null ? cliente.Entidad_Financiera__r.Name : '';
            registroPersonaJuridicaInput.numeroCuentaBancaria = cliente.Numero_de_cuenta_bancaria__c;
            registroPersonaJuridicaInput.codigoTipoCuentaBancaria = cliente.Tipo_de_cuenta_bancaria__c;           
            return RegistroPersonaJuridicaInput;            
        }
        return null;        
    }
    
    /**Método para obtener el input del servicio de actualizacion de persona Jurídica*/
    public static ANEFI_ServicesDTO.ActualizarPersonaJuridicaInput obtInputActualizacionPersonaJuridica(Id clienteId){
        List<Account> clientes = [Select Id, Capital_social__c, Calle_principal_direccion_tributaria__c, 
                                  Calle_principal_direccion_trabajo__c, Cargo_representante_legal__c, 
                                  Codigo_canton_direccion_trabajo__c, Codigo_canton_direccion_tributaria__c, 
                                  Codigo_pais_direccion_tributaria__c, Codigo_pais_direccion_trabajo__c, 
                                  Codigo_pais_nacionalidad__c, Codigo_actividad_economica__c, 
                                  Tipo_de_identificacion__c, Tipo_de_persona_juridica__c, Fecha_de_constitucion__c, 
                                  Numero_de_identificacion__c, Interseccion_direccion_tributaria__c, 
                                  Interseccion_direccion_trabajo__c, Name, Numero_direccion_tributaria__c,
                                  Numero_direccion_trabajo__c, Description, Politicamente_expuesto__c, 
                                  Identificacion_representante_legal__c, Secuencia_canton_direccion_tributaria__c, 
                                  Secuencia_canton_direccion_trabajo__c, Telefono_celular__c, Phone, Total_activos__c, 
                                  Total_pasivos__c, Total_gastos__c, AnnualRevenue,Entidad_financiera__c, 
                                  Entidad_Financiera__r.Tipo_de_entidad__c,Entidad_Financiera__r.Name, 
                                  Numero_de_cuenta_bancaria__c, Tipo_de_cuenta_bancaria__c, Tipo_identificacion_representante_legal__c
                                  From Account Where Id =: clienteId];
        
        if(clientes.size() > 0){
            Account cliente = clientes.get(0);            
             
            ANEFI_ServicesDTO.ActualizarPersonaJuridicaInput actualizarPersonaJuridicaInput = new ANEFI_ServicesDTO.ActualizarPersonaJuridicaInput();
            actualizarPersonaJuridicaInput.callePrincipalDireccionResidenciaTributaria = cliente.Calle_principal_direccion_tributaria__c;
            actualizarPersonaJuridicaInput.callePrincipalDireccionTrabajo = cliente.Calle_principal_direccion_trabajo__c;
            actualizarPersonaJuridicaInput.capitalSocial = cliente.Capital_social__c;
            actualizarPersonaJuridicaInput.cargoRepresentanteLegal = cliente.Cargo_representante_legal__c;
            actualizarPersonaJuridicaInput.codigoOrgGeoDireccionResidenciaTributaria = cliente.Codigo_canton_direccion_tributaria__c;
            actualizarPersonaJuridicaInput.codigoOrgGeoDireccionTrabajo = cliente.Codigo_canton_direccion_trabajo__c;
            actualizarPersonaJuridicaInput.codigoPaisDireccionResidenciaTributaria = cliente.Codigo_pais_direccion_tributaria__c;
            actualizarPersonaJuridicaInput.codigoPaisDireccionTrabajo = cliente.Codigo_pais_direccion_trabajo__c;
            actualizarPersonaJuridicaInput.codigoPaisNacionalidad = cliente.Codigo_pais_nacionalidad__c;
            actualizarPersonaJuridicaInput.codigoTipoActividadEconomica = cliente.Codigo_actividad_economica__c;            
            Datetime fechaDateTime = cliente.Fecha_de_constitucion__c;            
            actualizarPersonaJuridicaInput.fechaConstitucion = fechaDateTime != null ? fechaDateTime.format('yyyy-MM-dd') : '';
            actualizarPersonaJuridicaInput.codigoTipoIdentificacion = cliente.Tipo_de_identificacion__c;
            actualizarPersonaJuridicaInput.identificacion = cliente.Numero_de_identificacion__c;
            actualizarPersonaJuridicaInput.interseccionDireccionResidenciaTributaria = cliente.Interseccion_direccion_tributaria__c;
            actualizarPersonaJuridicaInput.interseccionDireccionTrabajo = cliente.Interseccion_direccion_trabajo__c;
            actualizarPersonaJuridicaInput.nombre = cliente.Name;
            actualizarPersonaJuridicaInput.numeroDireccionResidenciaTributaria = cliente.Numero_direccion_tributaria__c;
            actualizarPersonaJuridicaInput.numeroDireccionTrabajo = cliente.Numero_direccion_trabajo__c;
            actualizarPersonaJuridicaInput.observaciones = cliente.Description;
            actualizarPersonaJuridicaInput.politicamenteExpuesto = cliente.Politicamente_expuesto__c;
            actualizarPersonaJuridicaInput.razonSocial = cliente.Name;
            actualizarPersonaJuridicaInput.idRepresentanteLegal = cliente.Identificacion_representante_legal__c;
            actualizarPersonaJuridicaInput.tipoIdRepresentanteLegal = cliente.Tipo_identificacion_representante_legal__c;
            actualizarPersonaJuridicaInput.secuenciaOrgGeoDireccionResidenciaTributaria = cliente.Secuencia_canton_direccion_tributaria__c != 0 ? Integer.valueOf(cliente.Secuencia_canton_direccion_tributaria__c) : null;
            actualizarPersonaJuridicaInput.secuenciaOrgGeoDireccionTrabajo = cliente.Secuencia_canton_direccion_trabajo__c != null ? Integer.valueOf(cliente.Secuencia_canton_direccion_trabajo__c) : null;
            actualizarPersonaJuridicaInput.telefonoCelular = cliente.Telefono_celular__c;
            actualizarPersonaJuridicaInput.telefonoConvencional = cliente.Phone;            
            actualizarPersonaJuridicaInput.totalActivos = cliente.Total_activos__c;
            actualizarPersonaJuridicaInput.totalGastos = cliente.Total_gastos__c;
            actualizarPersonaJuridicaInput.totalIngresos = cliente.AnnualRevenue;
            actualizarPersonaJuridicaInput.totalPasivos = cliente.Total_pasivos__c;
            actualizarPersonaJuridicaInput.codigoTipoEntidadFinancieraCuentaBancaria = cliente.Entidad_financiera__c != null ? String.valueOf(cliente.Entidad_Financiera__r.Tipo_de_entidad__c) : '';
            actualizarPersonaJuridicaInput.codigoEntidadFinancieraCuentaBancaria = cliente.Entidad_financiera__c != null ? cliente.Entidad_Financiera__r.Name : '';
            actualizarPersonaJuridicaInput.numeroCuentaBancaria = cliente.Numero_de_cuenta_bancaria__c;
            actualizarPersonaJuridicaInput.codigoTipoCuentaBancaria = cliente.Tipo_de_cuenta_bancaria__c;           
            return actualizarPersonaJuridicaInput;             
        }
        return null;        
    }

	/*Método para obtener el input del servicio de creación de cuenta de participe*/
    public static ANEFI_ServicesDTO.RegistroCuentaParticipeInput obtInputRegistroCuentaParticipe(ANEFI_ServicesDTO.Oportunidad oportunidadDTO){
        if(oportunidadDTO != null){
            ANEFI_ServicesDTO.RegistroCuentaParticipeInput registroCuentaParticipeInputDTO = new ANEFI_ServicesDTO.RegistroCuentaParticipeInput();
            registroCuentaParticipeInputDTO.codigoAgencia = '1';
            registroCuentaParticipeInputDTO.codigoCuentaContable = oportunidadDTO.codigoCuentaContable;
            registroCuentaParticipeInputDTO.codigoTrader = oportunidadDTO.codigoTrader;
            registroCuentaParticipeInputDTO.complementarios = oportunidadDTO.complementarios;
            registroCuentaParticipeInputDTO.transaccionCooparticipe = oportunidadDTO.transaccionCooparticipe;
            Datetime fechaDateTime = System.now();            
            registroCuentaParticipeInputDTO.fechaCreacion = fechaDateTime.format('yyyy-MM-dd');
            return registroCuentaParticipeInputDTO;
        }
        return null;
    } 

	/*Método para obtener el input del servicio de creación de primer aporte en Gestor*/
    public static ANEFI_ServicesDTO.RegistroAporteInput obtInputRegistroAporte(ANEFI_ServicesDTO.Oportunidad oportunidadDTO){
        if(oportunidadDTO != null){
            ANEFI_ServicesDTO.RegistroAporteInput registroAporteInputDTO = new ANEFI_ServicesDTO.RegistroAporteInput();
            registroAporteInputDTO.codigoAgencia = '1';
            registroAporteInputDTO.codigoTipoTransaccion = ANEFI_Utilitarios.CODIGO_TRANSACCION_APORTE;
            registroAporteInputDTO.fechaEfectiva = oportunidadDTO.fechaEfectiva;
            registroAporteInputDTO.numeroDocumento = oportunidadDTO.numeroDocumento;
            registroAporteInputDTO.codigoTipoFormaPago = oportunidadDTO.codigoTipoFormaPago;
            registroAporteInputDTO.codigoMoneda = oportunidadDTO.codigoMoneda;
            registroAporteInputDTO.codigoTipoEntidadFondo = oportunidadDTO.codigoTipoEntidadFondo;
            registroAporteInputDTO.codigoEntidadFondo = oportunidadDTO.codigoEntidadFondo;
            registroAporteInputDTO.numeroCuentaFondo = oportunidadDTO.numeroCuentaFondo;
            registroAporteInputDTO.monto = oportunidadDTO.monto;
            return registroAporteInputDTO;
        }
        return null;
    }   
    
    /*Método para obtener el input del servicio de actualización de referencia bancaria*/
    public static ANEFI_ServicesDTO.ActualizacionReferenciaBancariaInput obtInputActualizacionReferenciaBancaria(ANEFI_ServicesDTO.RegistroReferenciaBancariaInput registroReferenciaBancariaInput){
        if(registroReferenciaBancariaInput != null){
        	ANEFI_ServicesDTO.ActualizacionReferenciaBancariaInput actualizacionReferenciaBancariaInput = new ANEFI_ServicesDTO.ActualizacionReferenciaBancariaInput();
            actualizacionReferenciaBancariaInput.codigoEntidadFinanciera = registroReferenciaBancariaInput.codigoEntidadFinanciera;
            actualizacionReferenciaBancariaInput.codigoMoneda = registroReferenciaBancariaInput.codigoMoneda;
            actualizacionReferenciaBancariaInput.codigoTipoCuenta = registroReferenciaBancariaInput.codigoTipoCuenta;
            actualizacionReferenciaBancariaInput.codigoTipoEntidadFinanciera = registroReferenciaBancariaInput.codigoTipoEntidadFinanciera;
            actualizacionReferenciaBancariaInput.estado = registroReferenciaBancariaInput.estado;
            actualizacionReferenciaBancariaInput.fechaIngreso = registroReferenciaBancariaInput.fechaIngreso;
            actualizacionReferenciaBancariaInput.observaciones = registroReferenciaBancariaInput.observaciones;
            actualizacionReferenciaBancariaInput.principal = registroReferenciaBancariaInput.principal;
           	return actualizacionReferenciaBancariaInput;
        }
        return null;       
    }

}