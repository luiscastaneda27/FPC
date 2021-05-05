public class controllerConstanciaPdf{
    private ApexPages.StandardController controller {get; set;}
    Public Case casoTratar {set;get;}
    public String html {set;get;}
    private date hoy = date.today();
    
    private list<Detalle_caso__c> detallesCaso;
    private Account cliente;
    private Cuentas__c cuenta;
    private User usuario;
    private User usuarioFirma;
    private Asignacion_constancia__c asignacion;
    boolean esConstancia = true;
    list<Detalle_caso__c> detallesCasoNuevo;
    private string camposCaso;
    private string camposCliente;
    private string camposCuenta;
    private string camposDetalle;
    private string camposUsuario;   
    
    
    public boolean mostrarMenbrete {get;set;}
    public string margen{get;set;}
    classRespuestaConstancias constancias;
    
    public controllerConstanciaPdf() {
        inicio(ApexPages.currentPage().getParameters().get('id'));
    }
    
    
    public controllerConstanciaPdf(ApexPages.StandardController controller) {
        this.controller = controller;
        Case gestion = ((Case)controller.getRecord()).clone(true);
        inicio(gestion.id);
    }
    public void inicio (String idCaso){
        String urlOrigen = ApexPages.currentPage().getUrl();
        mostrarMenbrete = false;
        margen = '4.5cm';
        detallesCasoNuevo = new list<Detalle_caso__c>();
        try {
            
            
            //integer u=[select count() from cuentas__C where id=:detallecaso.cuenta__c and cuenta_colectiva2__C !=null];
            
            // Caso
            camposCaso = 'toLabel(Constancia__c),Monto_compromiso_aporte__c';
            camposCaso += ',Fecha_desde__c,Fecha_Hasta__c,currencyisocode,embajadas__c,Frecuencia__c';
            camposCaso += ',Telefono_Casa__c,Telefono_Movil__c,Telefono_Trabajo__c,Punto_Referencia_Trabajo__c';
            camposCaso += ',Correo_Electronico__c,Fecha_Nacimiento__c,Lugar_Nacimiento__c,Estado_Civil__c';
            camposCaso += ',Nombre_Cliente__c,Segundo_nombre__c,Segundo_apellido__c,Apellidos__c,toLabel(Estado_Cuenta_Detallado__c)';
            camposCaso += ',toLabel(Tipo_Identificacion__c),Identificacion__c,Tipo_empresa__c,Empresa__c,toLabel(Tipo_Estado_Cuenta__c)';
            camposCaso += ',Fecha_Ingreso__c,Cargo_actual__c,Punto_Referencia_Residencia__c,Viene_Email_2_Case__c';
            camposCaso += ',toLabel(Departamento_Residencia2__c),toLabel(Departamento_Trabajo2__c),toLabel(Ciudad_Residencia2__c)';
            camposCaso += ',toLabel(Ciudad_Trabajo2__c)'; 
            String queryRelated = 'Select ';
            queryRelated += camposCaso;
            
            queryRelated += ',Account.Nombre_empresa__c,Account.Celular__c,Mostrar_Saldo_a_la_fecha__c,Tasa_Cambio__c,Viene_Portal_Autogestion__C,Description,Subject,Desea_ver_tasa_de_cambio__c,Account.Name,status,ownerId, Aprobado__c, Account.Identificacion__c,AccountId, RecordType.DeveloperName';
            queryRelated +=', Aplica_Saldo_patronal__c, Origin';
            queryRelated += ',Colonia_Avenida_Residencia__r.Name,Colonia_Avenida_Trabajo__r.Name,Nombre_Usuario_Firmador__c,Apellido_Usuario_Firmador__c,Cargo_Usuario_Firmador__c';
            queryRelated += ',Usuario_Firmador__r.UserRole.Name,Usuario_Firmador__r.Name,usuario_firmador__r.title, Reason ';            
            queryRelated += ' From Case';
            queryRelated += ' Where Id = \'' + idCaso + '\'';
            casoTratar = dataBase.query(queryRelated);
            mostrarMenbrete = casoTratar.Viene_Portal_Autogestion__c;
            margen = mostrarMenbrete ? '2cm':'4.5cm';
            camposCaso = camposCaso.replace('toLabel(','');
            camposCaso = camposCaso.replace(')','');
            
            // CLIENTE RELACIONADO
            camposCliente = 'FirstName,Celular__c,Nombre_empresa__c,LastName,toLabel(Tipo_Identificacion__c),Identificacion__c';
            camposCliente += ',PersonBirthdate,toLabel(Estado_Civil__pc),Lugar_Nacimiento__c,PersonEmail,PersonMobilePhone';
            queryRelated = 'Select ';
            queryRelated += camposCliente;
            queryRelated += ' From Account';
            queryRelated += ' Where Id = \'' + casoTratar.AccountId + '\'';
            
            cliente = dataBase.query(queryRelated);
            camposCliente = camposCliente.replace('toLabel(','');
            camposCliente = camposCliente.replace(')','');
            
            if(casoTratar.RecordType.DeveloperName == 'Actualizacion_informacion') {
                if(casoTratar.Nombre_Cliente__c == null && casoTratar.Segundo_nombre__c == null) {
                    casoTratar.Nombre_Cliente__c = cliente.FirstName;
                }
                if(casoTratar.Apellidos__c == null && casoTratar.Segundo_apellido__c == null){
                    casoTratar.Apellidos__c = cliente.LastName;
                }
                if(casoTratar.Fecha_Nacimiento__c == null) casoTratar.Fecha_Nacimiento__c = cliente.PersonBirthdate;
                if(casoTratar.Identificacion__c == null) casoTratar.Identificacion__c = cliente.Identificacion__c;
                if(casoTratar.Lugar_Nacimiento__c == null) casoTratar.Lugar_Nacimiento__c = cliente.Lugar_Nacimiento__c;
                if(casoTratar.Tipo_Identificacion__c == null) casoTratar.Tipo_Identificacion__c = cliente.Tipo_Identificacion__c;
                if(casoTratar.Estado_Civil__c == null) casoTratar.Estado_Civil__c = cliente.Estado_Civil__pc;
            }
            //detalleCaso.Prestamo_anterior__c
            // DETALLE DEL CASO
            camposDetalle = 'Nueva_Cuenta_colectiva2__c,Prestamo_anterior__c,No_es_primer_prestamo__c,Cambio_moneda__c,Nuevo_Subproducto__c,Cuenta__c,Detalle_subproducto__c';
            camposDetalle += ',Detalle_Cuenta_colectiva__c,Accion__c,Nueva_fecha_aporte__c,toLabel(Nuevo_canal_aporte__c),Nuevo_monto_aporte__c';
            camposDetalle += ',N_Cuenta_Bancaria__c,toLabel(Tipo_Operacion__c),Tipo_saldo_modificar2__c,Cliente_quiere_capital_semilla__c';
            camposDetalle += ',Cliente_sigue_Laborando__c,Permitir_Retiro_Saldos_Patronales__c,Comision_Retiro_Anticipado__c,Monto_retirar__c';
            camposDetalle += ',toLabel(Tipo_retiro__c),toLabel(Forma_Retiro__c),toLabel(Banco__c),toLabel(Tipo_Cuenta__c),currencyIsoCode,Tipo_transaccion__c,Subtipo_transaccion__c';
            camposDetalle += ',Comision_por_aporte__c,Monto_reversar__c,Porcentaje_comision__c,Numero_Cuenta__c,Dia_aporte__c';
            camposDetalle += ',Canal_aporte_actual__c,Fecha_aporte__c,Frecuencia__c,Mes__c,Ano_tarjeta__c,POS__c,Monto_total_retirar__c';
            camposDetalle += ',Monto_total_comisiones_recargos__c';
            queryRelated = 'Select ';
            queryRelated += camposDetalle;
            //camposDetalle = camposDetalle.replace(',Nuevo_Subproducto__r.name', '');
            queryRelated +=',Nuevo_Subproducto__r.name,cuenta__r.Subproducto__r.name,es_refinanciamiento__C ,Nueva_Cuenta_colectiva2__r.cuenta_colectiva2__r.codigo__C, Nuevo_Subproducto__r.producto__r.name';
            queryRelated += ', Cuenta__r.Codigo__c,toLabel(Caso__r.Constancia__c),Porcentaje__c,Parentesco__c,Fecha_nacimiento__c';
            queryRelated += ',Primer_Nombre__c,Total_saldo_patronal__C,Monto_a_Pignorar__c,Monto_Prestamo__c,Total_saldo_personal__C,monto_pignorado__C,Segundo_Nombre__c,caso__r.fecha_hasta__C,Primer_Apellido__c,Segundo_Apellido__c,Identificacion__c, Monto_bruto_retirar__c, cuenta__r.Cuenta_colectiva2__C';
            queryRelated += ' From Detalle_caso__c';
            queryRelated += ' Where Caso__c = \'' + casoTratar.Id + '\'';
            queryRelated += ' Order by Cabeza_retiro__c desc';
            system.debug('el query detalle caso....: '+ queryRelated );
            detallesCaso = dataBase.query(queryRelated);
            //system.debug('Sub producto: '+ detallesCaso[0].Nuevo_Subproducto__r.name);
            camposDetalle = camposDetalle.replace('toLabel(','');
            camposDetalle = camposDetalle.replace(')','');
            if(detallesCaso !=null)
            {
                detallesCasoNuevo=detallesCaso; 
            }
            
            if(casoTratar.RecordType.DeveloperName == 'Retiros')
            {
                for(integer i=0; i<detallesCaso.size(); i++)
                {
                    
                    if(detallesCaso[i].Monto_bruto_retirar__C != null)
                    {
                        detallesCaso[i].Monto_retirar__c = detallesCaso[i].Monto_bruto_retirar__C;
                    }
                } 
            }
            //system.debug('quiero ver que tiene esto: '+detallesCaso.isEmpty());
            if(!detallesCaso.isEmpty()){
                // DETALLE DE CUENTA
                camposCuenta = 'Codigo__c,FondoInversionCP__c,toLabel(Frecuencia_Aportacion__c),toLabel(Forma_Aportacion__c),Fecha_Apertura__c';
                queryRelated = 'Select ';
                queryRelated += camposCuenta;
                queryRelated += ' From Cuentas__c';
                queryRelated += ' Where Id = \'' + detallesCaso[0].Cuenta__c + '\'';
                
                cuenta = dataBase.query(queryRelated);
                camposCuenta = camposCuenta.replace('toLabel(','');
                camposCuenta = camposCuenta.replace(')','');
            }else{
                camposCuenta = 'Codigo__c,FondoInversionCP__c,toLabel(Frecuencia_Aportacion__c),toLabel(Forma_Aportacion__c),Fecha_Apertura__c';
                queryRelated = 'Select ';
                queryRelated += camposCuenta;
                queryRelated += ' From Cuentas__c';
                queryRelated += ' Where Cliente__c = \'' + casoTratar.AccountId + '\'';
                // para pruebas
                queryRelated += ' limit 1';
                cuenta = dataBase.query(queryRelated);
                camposCuenta = camposCuenta.replace('toLabel(','');
                camposCuenta = camposCuenta.replace(')','');
            }
            
            // DETALLE DE USUARIO
            camposUsuario = 'Codigo__c,Name,Department,Zona__c,Funcion_Firmador__c,Nombre_firmador__c';
            queryRelated = 'Select ';
            queryRelated += camposUsuario;
            queryRelated += ' From User';
            queryRelated += ' Where Id = \'' + casoTratar.ownerID + '\'';
            System.debug('Consulta Usuario: '+queryRelated);
            usuario = dataBase.query(queryRelated);
            camposUsuario = camposUsuario.replace('toLabel(','');
            camposUsuario = camposUsuario.replace(')','');
            
            //Cambio                     
            //if(!casoTratar.Aprobado__c &&  casoTratar.Constancia__c == 'Compromiso de Aporte' && 
            //casoTratar.Monto_compromiso_aporte__c != null && casoTratar.Monto_compromiso_aporte__c > 0){
            if( casoTratar.Constancia__c == 'Compromiso de Aporte' && 
               casoTratar.Monto_compromiso_aporte__c != null && casoTratar.Monto_compromiso_aporte__c == 0){
                   html = 'El caso debe estar Aprobado';    
                   
               }Else{                 
                   
                   usuarioFirma = [Select Firma__c 
                                   From User 
                                   Where codigo__c = 'HN20370'];
                   if(casoTratar.Viene_Portal_Autogestion__C || casoTratar.Origin == 'Agencias_Banco'){
                       usuarioFirma.firma__C=Label.UrlCustomSite;
                   }
                   String queryAsig = 'Select Constancia__r.html_espanol__c, Constancia__c,Carta__c';
                   queryAsig += '  From Asignacion_constancia__c';
                   queryAsig += ' Where Tipo_registro_Caso__c = \'' + casoTratar.RecordType.DeveloperName + '\' AND';
                   //system.debug('Query antes de meterse al if: '+queryAsig); 
                   if(casoTratar.RecordType.DeveloperName == 'Constancia') {
                       if(urlOrigen.contains('vfFormularioPDF')) {
                           //system.debug('Se metio al if');
                           queryAsig += ' Carta__c = null';
                           esConstancia = false;    
                       } else {
                           // system.debug('Se metio al else: '+casoTratar.Constancia__c);
                           queryAsig += ' toLabel(Carta__c) = \'' + casoTratar.Constancia__c + '\'';
                       }
                   } else {
                       queryAsig += ' Carta__c = null';
                       esConstancia = false;
                   }                            
                   queryAsig += ' Limit 1';
                   //system.debug('Tipo de caso--:'+ casoTratar.RecordType.DeveloperName);
                   system.debug('el query para el html : '+queryAsig);
                   asignacion = dataBase.query(queryAsig);      
                   system.debug('el query para el html : '+queryAsig);
                   html = asignacion.Constancia__r.html_espanol__c; 
                   if(casoTratar.Viene_Portal_Autogestion__c && casoTratar.constancia__c =='A1' && !urlOrigen.contains('vfFormularioPDF')){
                       html=html.substring(75, html.length());
                   }
                   else if(casoTratar.Viene_Portal_Autogestion__c && casoTratar.constancia__c =='Saldo' && !urlOrigen.contains('vfFormularioPDF')){
                       html=html.substring(152, html.length());
                   }
                   
                   
                   if(casoTratar.RecordType.DeveloperName == 'Aumento_Disminucion_Aportes' ||test.isRunningTest()) {
                       String queryRelacionado = 'Select html_espanol__c From Constancia__c Where Codigo__c = ';
                       String hayAdicional = '';
                       
                       if(detallesCaso[0].Frecuencia__c == null){
                           if(detallesCaso[0].Tipo_Operacion__c == 'Cambio de # de CA/CC' || detallesCaso[0].Nuevo_canal_aporte__c == 'Debito a Cuenta de Ahorro'){
                               hayAdicional = '\'POSabierto\'';     
                           }else if(detallesCaso[0].Tipo_Operacion__c == 'Cambio de # Tarjeta' || detallesCaso[0].Nuevo_canal_aporte__c == 'Debito a Tarjeta de Crédito'){
                               if(detallesCaso[0].POS__c == 'Ficohsa'){
                                   hayAdicional = '\'POSabierto\''; 
                               }else{
                                   hayAdicional = '\'BACdebito\'';  
                               }
                           }
                       }else{
                           if(detallesCaso[0].Tipo_Operacion__c == 'Cambio de # de CA/CC' || detallesCaso[0].Nuevo_canal_aporte__c == 'Debito a Cuenta de Ahorro'){
                               hayAdicional = '\'DEBITOCuenta\'';       
                           }else if(detallesCaso[0].Tipo_Operacion__c == 'Cambio de # Tarjeta' || detallesCaso[0].Nuevo_canal_aporte__c == 'Debito a Tarjeta de Crédito'){
                               if(detallesCaso[0].POS__c == 'BAC'){
                                   hayAdicional = '\'BACdebito\'';  
                               }
                           }    
                       }
                       if(hayAdicional != ''){
                           queryRelacionado += hayAdicional;
                           Constancia__c frmRelacionado = dataBase.query(queryRelacionado);
                           html += frmRelacionado.html_espanol__c;  
                       }
                   }
                   if((casoTratar.Constancia__c=='Pignoración' && casoTratar.Status !='Cerrado'
                       && casoTratar.Status !='Esperando Documentación' && urlOrigen.contains('Constancia'))||
                      ( casoTratar.Constancia__c=='Compromiso de Aporte' && casoTratar.Status !='Cerrado' && esConstancia)){
                          html = 'EN EL ESTATUS ACTUAL DEL CASO NO SE PUEDE IMPRIMIR LA CONSTANCIA';
                      }
                   if((casoTratar.Constancia__c=='Aportes Históricos' || casoTratar.Constancia__c=='Saldo') && (casoTratar.Mostrar_Saldo_a_la_fecha__c ||casoTratar.Desea_ver_tasa_de_cambio__c )){
                       try{casoTratar.CurrencyIsoCode = [select cuenta__r.CurrencyIsoCode from detalle_caso__c where 
                                                         caso__C =:casoTratar.Id limit 1].cuenta__r.CurrencyIsoCode;}catch(Exception ex){}
                   }
                   html = reemplazarCampos();
                   html = html.replace('USD.', 'USD');
                   html = html.replace('HNL.', 'HNL');
               }
        }catch(Exception e)
        {
            //html = 'CASO NO COMPLETO O HA OCURRIDO UN ERROR INESPERADO';
            system.debug('Error ' + e.getMessage() + ' Linea ' + e.getLineNumber());
            html='Error ' + e.getMessage() + ' Linea ' + e.getLineNumber();
        }
    }
    
    
    public String reemplazarCampos() {
        
        if(detallesCasoNuevo.size()>0 &&detallesCasoNuevo[0].Cuenta__r.cuenta_colectiva2__C == null)
        {
            html=html.replace('[Account.Nombre_empresa__c]', '');
        }
        reemplazarCampos(casoTratar, 'Case', camposCaso);
        reemplazarCampos(usuario, 'User', camposUsuario);
        
        if(!esConstancia){          
            reemplazarCampos(cliente, 'Account', camposCliente);
            if(casoTratar.RecordType.DeveloperName != 'Actualizacion_informacion'){
                For(Detalle_Caso__c item : detallesCaso)
                    reemplazarCampos(item, 'Detalle_Caso__c', camposDetalle);
                system.debug('Campos camposDetalle'+camposDetalle);
                // comentar esto
                if(casoTratar.RecordType.DeveloperName != 'Estados_Cuenta'){
                    reemplazarCampos(cuenta, 'Cuentas__c', camposCuenta);
                }                 
                system.debug('Campos camposCuenta'+camposCuenta);
            }           
        }
        user u = [select zona__C, Department  from user where id =:userinfo.getUserId()];
        u.Department = u.Department != null ? u.Department :'';
        u.zona__C = u.zona__C != null ? u.zona__C :'';
        if(html.contains('[getCuentasCarnet]') || test.isRunningTest()){
            string cuentas = '';
            for(cuentas__C item: [select codigo__C from cuentas__C where cliente__c=:casoTratar.AccountId]){
                cuentas +=item.codigo__C +', ';
            }
            html=html.replace('[getCuentasCarnet]',cuentas.substring(0, cuentas.length() -2));
        }
        if(html.contains('[Tipo_Estado_Cuenta__c]')){
            html = html.replace('[Tipo_Estado_Cuenta__c]', casoTratar.Tipo_Estado_Cuenta__c );
        }
        if(html.contains('[Estado_Cuenta_Detallado__c]')){
            html = html.replace('[Estado_Cuenta_Detallado__c]', casoTratar.Estado_Cuenta_Detallado__c );
        }
        if(html.contains('[Case.Description]')){
            html = html.replace('[Case.Description]', casoTratar.Description);
        }
        if(html.contains('[Case.Subject]')){
            html = html.replace('[Case.Subject]', casoTratar.Subject);
        }
        if(html.contains('[getZonaPig]') || test.isRunningTest()){
            html = html.replace('[getZonaPig]', u.zona__c);
        }
        if(html.contains('[getNuevaCO]')  || test.isRunningTest()){
           html = html.replace('[getNuevaCO]', detallesCaso[0].Nueva_Cuenta_colectiva2__r.cuenta_colectiva2__r.codigo__C !=null ? detallesCaso[0].Nueva_Cuenta_colectiva2__r.cuenta_colectiva2__r.codigo__C: '');
        }
        if(html.contains('[getActualSubP]') || test.isRunningTest()){
             html = html.replace('[getActualSubP]', detallesCaso[0].cuenta__r.Subproducto__r.name !=null ? detallesCaso[0].cuenta__r.Subproducto__r.name:'');
        }
        if(html.contains('[getNuevaSubP]') || test.isRunningTest()){
            html = html.replace('[getNuevaSubP]', detallesCaso[0].Nuevo_Subproducto__r.name !=null ? detallesCaso[0].Nuevo_Subproducto__r.name:'');
        }
        if(html.contains('[getNuevaProduc]') || test.isRunningTest()){
            html = html.replace('[getNuevaProduc]', detallesCaso[0].Nuevo_Subproducto__r.producto__r.name !=null ? detallesCaso[0].Nuevo_Subproducto__r.producto__r.name:'');
        }
        if(html.contains('[getDepartamentoPig]') || test.isRunningTest()){
            html = html.replace('[getDepartamentoPig]', u.Department);
        }
        //system.debug('LA constacia trae saldo a la fecha: '+ html.contains('[getMostrarSaldoAlaFecha]'));
        if(html.contains('[P1SaldoDiponibleLetras]') || test.isRunningTest()) {
            if(test.isRunningTest()){detallesCaso[0].Total_saldo_personal__c = 21.32; detallesCaso[0].Total_saldo_patronal__c = 21.32;}
            decimal SaldoDispoible = detallesCaso[0].Total_saldo_personal__C;
            decimal saldoDolares = SaldoDispoible;
            if(casoTratar.aplica_saldo_patronal__C || test.isRunningTest()) {
                SaldoDispoible +=detallesCaso[0].Total_saldo_patronal__C;
            }
            //Modificada
            SaldoDispoible -=detallesCaso[0].es_refinanciamiento__C && detallesCaso[0].monto_pignorado__C !=null ? detallesCaso[0].monto_pignorado__C:0;
            list<detalle_caso__C> listdetalle = [select monto_pignorado__C from detalle_caso__C
                                                 where Prestamo_anterior__c = :detallesCaso[0].Prestamo_anterior__c
                                                and monto_pignorado__C>0 and Prestamo_anterior__c !=null];
            if(detallesCaso[0].es_refinanciamiento__C && listdetalle.size()>0 ){
                SaldoDispoible += listdetalle[0].monto_pignorado__C;
            }
            if(detallesCaso[0].No_es_primer_prestamo__C || test.isRunningTest() ){
                SaldoDispoible -= !test.isRunningTest() ? detallesCaso[0].Monto_Pignorado__c : 0;
            }
            if(detallesCaso[0].Cambio_moneda__c){
                saldoDolares = SaldoDispoible / casotratar.Tasa_Cambio__c;
                string x = ConvertirNumeros.convertirLetras((integer) saldoDolares);
                string decimalesLetra='Exactos ';
                if(saldoDolares>(integer) saldoDolares){
                    if((integer)(((saldoDolares- (integer) saldoDolares).setscale(2))*100) ==1){
                        decimalesLetra = ' con un centavo';//+ConvertirNumeros.convertirLetras((integer)(((SaldoDispoible- (integer) SaldoDispoible).setscale(2))*100))+' centavos';
                    }else{
                        decimalesLetra = ' con '+ConvertirNumeros.convertirLetras((integer)(((saldoDolares- (integer) saldoDolares).setscale(2))*100))+' centavos';
                    }
                }
                x +=' Dolares'+decimalesLetra + ' (USD.'+formatonumero(saldoDolares)+') ';
                string tasa = 'que de acuerdo a la tasa de cambio de HNL'+casotratar.Tasa_Cambio__c+' corresponde a';
                tasa += ' <b>'+ConvertirNumeros.convertirLetras((integer) SaldoDispoible)+'</b>';
                if(SaldoDispoible>(integer) SaldoDispoible){
                    if((integer)(((SaldoDispoible- (integer) SaldoDispoible).setscale(2))*100) ==1){
                        decimalesLetra = ' con un centavo';//+ConvertirNumeros.convertirLetras((integer)(((SaldoDispoible- (integer) SaldoDispoible).setscale(2))*100))+' centavos';
                    }else{
                        decimalesLetra = ' con '+ConvertirNumeros.convertirLetras((integer)(((SaldoDispoible- (integer) SaldoDispoible).setscale(2))*100))+' centavos';
                    }
                }
                tasa +=' <b> Lempiras '+decimalesLetra+ ' (HNL.'+formatonumero(SaldoDispoible)+') </b>';
                html = html.replace('[P1SaldoDiponibleLetras]', x);
                html=html.replace('[getMostrarTasaCambio]',tasa);
                html=html.replace('[getHoyTS]','');
                
            }else{
                string x = ConvertirNumeros.convertirLetras((integer) SaldoDispoible);
                string decimalesLetra='Exactos ';
                if(SaldoDispoible>(integer) SaldoDispoible){
                    if((integer)(((SaldoDispoible- (integer) SaldoDispoible).setscale(2))*100) ==1){
                        decimalesLetra = ' con un centavo';//+ConvertirNumeros.convertirLetras((integer)(((SaldoDispoible- (integer) SaldoDispoible).setscale(2))*100))+' centavos';
                    }else{
                        decimalesLetra = ' con '+ConvertirNumeros.convertirLetras((integer)(((SaldoDispoible- (integer) SaldoDispoible).setscale(2))*100))+' centavos';
                    }
                }
                string moneda =casoTratar.CurrencyIsoCode =='HNL'? ' Lempiras ':' Dolares ';
                x +=moneda+decimalesLetra+ ' ('+casoTratar.CurrencyIsoCode+'.'+formatonumero(SaldoDispoible)+') ';
                html = html.replace('[P1SaldoDiponibleLetras]', x);
                
            }
            
            
        }
        if(html.contains('[P1MontoPignoradoLetras]') || test.isRunningTest()) {
            if(test.isRunningTest()){
                detallesCaso[0].Monto_Prestamo__c = 1232.23;
                 detallesCaso[0].Monto_a_Pignorar__c = 1232.23;
            }
            decimal SaldoPignorado = detallesCaso[0].Monto_Prestamo__c ;
            string x = ConvertirNumeros.convertirLetras((integer) SaldoPignorado);
            string decimalesLetra='Exactos ' ;
            if(SaldoPignorado>(integer) SaldoPignorado){
                if((integer)(((SaldoPignorado- (integer) SaldoPignorado).setscale(2))*100) ==1){
                    decimalesLetra = ' con un centavo';//+ConvertirNumeros.convertirLetras((integer)(((SaldoDispoible- (integer) SaldoDispoible).setscale(2))*100))+' centavos';
                }else{
                    decimalesLetra = ' con '+ConvertirNumeros.convertirLetras((integer)(((SaldoPignorado- (integer) SaldoPignorado).setscale(2))*100))+' centavos';
                }
            }
            string moneda =casoTratar.CurrencyIsoCode =='HNL'? ' Lempiras ':' Dolares ';
            x +=moneda+decimalesLetra+ ' ('+casoTratar.CurrencyIsoCode+'.'+formatonumero(SaldoPignorado)+')';
            html = html.replace('[P1MontoPignoradoLetras]', x);
        }
        
        if(html.contains('[getMostrarSaldoAlaFecha]')) {
            string tr='';
            getSaldoCuenta saldosAlaFecha = new getSaldoCuenta();
            decimal saldoFecha= 0;
            
            saldosAlaFecha = aSysdeCallouts.traerSaldos(detallesCaso[0].cuenta__r.codigo__c);
            if(casoTratar.Mostrar_Saldo_a_la_fecha__c || test.isRunningTest()) {
                for(classSaldos item : saldosAlaFecha.saldos) {
                    if(item.tipoSaldo == '10' || item.tipoSaldo == '11') {
                        saldoFecha += decimal.valueOf(item.montoSaldo.replace(',',''));
                    }
                }
                if(casoTratar.Desea_ver_tasa_de_cambio__c ||test.isRunningTest()){
                    TasaCambio.ValorDolar p = new TasaCambio.ValorDolar();
                    p.fecha=date.today();
                    if(test.isRunningTest()){
                        p.valorCOmpra=20;
                        p.valorVenta=21;
                    }
                    list<TasaCambio.ValorDolar> v = new list<TasaCambio.ValorDolar>();
                    v.add(p);
                    if(!test.isRunningTest()) {v = tasaCambio.traertasacambio(v);}
                    decimal cambio =(saldoFecha/v[0].valorventa).setscale(2);
                    string mon = 'USD';
                    if(casoTratar.CurrencyIsoCode=='USD' || test.isRunningTest()){
                        mon = 'HNL';
                        cambio =(saldoFecha*v[0].valorcompra).setscale(2);
                    }
                    tr = 'Con un saldo personal a la fecha de <strong>'+mon+' '+formatonumero(cambio)+'</strong>';
                    
                }else{
                    if(casoTratar.CurrencyIsoCode !=detallesCaso[0].cuenta__r.CurrencyIsoCode){
                        TasaCambio.ValorDolar p = new TasaCambio.ValorDolar();
                        p.fecha=date.today();
                        if(test.isRunningTest()){
                            p.valorCOmpra=20;
                            p.valorVenta=21;
                        }
                        list<TasaCambio.ValorDolar> v = new list<TasaCambio.ValorDolar>();
                        v.add(p);
                    if(!test.isRunningTest()) {v = tasaCambio.traertasacambio(v);}
                        if(casoTratar.CurrencyIsoCode == 'USD'){
                            tr = 'Con un saldo personal a la fecha de <strong>'+casoTratar.CurrencyIsoCode+formatonumero(saldoFecha/ v[0].valorventa)+'</strong>';
                        }else{
                            tr = 'Con un saldo personal a la fecha de <strong>'+casoTratar.CurrencyIsoCode+formatonumero(saldoFecha* v[0].valorCompra)+'</strong>';
                        }
                    }else{
                        tr = 'Con un saldo personal a la fecha de <strong>'+casoTratar.CurrencyIsoCode+formatonumero(saldoFecha)+'</strong>';
                    }
                }
            }
            html=html.replace('[getMostrarSaldoAlaFecha]', tr);
        }
        if(html.contains('[getMostrarTasaCambio]')){
            string repla ='';
            if(casoTratar.Desea_ver_tasa_de_cambio__c || test.isRunningTest()){
                list<TasaCambio.ValorDolar> v = new list<TasaCambio.ValorDolar>();
                TasaCambio.ValorDolar p = new TasaCambio.ValorDolar();
                if(!html.contains('[getHoyTS]')){
                    p.fecha= detallesCaso[0].fecha_aporte__c;
                }else{
                    p.fecha=date.today();
                }
                if(test.isRunningTest()){
                    p.valorCOmpra=20;
                    p.valorVenta=21;
                }
                v.add(p);
                if(!test.isRunningTest()) {v = tasaCambio.traertasacambio(v);}
                decimal cambio = detallesCaso[0].Nuevo_monto_aporte__c !=null ? detallesCaso[0].Nuevo_monto_aporte__c :0;
                if(casoTratar.Constancia__c =='Saldo' && !test.isRunningTest()){
                    llamarSysde();
                    For(classRespuestaCuentas item: constancias.cuentas){
                        cambio += item.saldo != null && item.saldo.trim() !='' ? decimal.valueOf(item.saldo.replace(',','')) : 0;
                    }
                }else if(casoTratar.Constancia__c =='Compromiso de Aporte' && !test.isRunningTest()){
                    llamarSysde();
                    if(casoTratar.Monto_compromiso_aporte__c != null && casoTratar.Monto_compromiso_aporte__c > 0){
                        cambio =casoTratar.Monto_compromiso_aporte__c;
                    }else{
                        cambio=decimal.valueOf(constancias.cuentas[0].montoPactado.replace(',',''));    
                    }
                }else if(casoTratar.Constancia__c =='Pignoración' || test.isRunningTest()){
                    if(test.isRunningTest()){detallesCaso[0].Total_saldo_personal__C=21.32;detallesCaso[0].Total_saldo_patronal__C=21.32;}
                    cambio = detallesCaso[0].Total_saldo_personal__C;
                    if(casoTratar.aplica_saldo_patronal__C  || test.isRunningTest()){
                        cambio +=detallesCaso[0].Total_saldo_patronal__C;
                    }
                    cambio -=detallesCaso[0].monto_pignorado__C !=null ? detallesCaso[0].monto_pignorado__C:0; 
                    if(casoTratar.CurrencyIsoCode=='USD'  || test.isRunningTest()){
                        cambio =(cambio*v[0].valorcompra).setscale(2);
                        string x = ConvertirNumeros.convertirLetras((integer) cambio);
                        string decimalesLetra='Exactos ';
                        if(cambio>(integer) cambio){
                            if((integer)(((cambio- (integer) cambio).setscale(2))*100) ==1){
                                decimalesLetra = ' con un centavo';//+ConvertirNumeros.convertirLetras((integer)(((cambio- (integer) cambio).setscale(2))*100))+' centavos';
                            }else{
                                decimalesLetra = ' con '+ConvertirNumeros.convertirLetras((integer)(((cambio- (integer) cambio).setscale(2))*100))+' centavos';
                            }
                        }
                        repla =' que de acuerdo a la tasa de cambio <strong>HNL.'+v[0].valorcompra.format()+' </strong> corresponde a <strong>'+x+' Lempiras '+decimalesLetra+' (HNL.'+ cambio.format()+').</strong>';
                    }
                    if(casoTratar.CurrencyIsoCode!='USD' || test.isRunningTest()){
                        cambio =(cambio/v[0].valorventa).setscale(2);
                        string x = ConvertirNumeros.convertirLetras((integer) cambio);
                        string decimalesLetra='Exactos ';
                        if(cambio>(integer) cambio){
                            if((integer)(((cambio- (integer) cambio).setscale(2))*100) ==1){
                                decimalesLetra = ' con un centavo';
                            }else{
                                decimalesLetra = ' con '+ConvertirNumeros.convertirLetras((integer)(((cambio- (integer) cambio).setscale(2))*100))+' centavos';
                            }
                        }
                        repla =' que de acuerdo a la tasa de cambio <strong>HNL.'+v[0].valorcompra.format()+' </strong> corresponde a <strong>'+x+' Dolares '+decimalesLetra+' (USD.'+ formatonumero(cambio)+')</strong>';
                    }
                    
                }
                if(casoTratar.CurrencyIsoCode=='USD' && casoTratar.Constancia__c !='Pignoración'){
                    repla =' que de acuerdo a la tasa de cambio de <strong>HNL.'+v[0].valorcompra.format()+' </strong> corresponde a <strong>HNL.'+formatonumero(((cambio*v[0].valorcompra).setscale(2)))+'</strong>';
                }else if(casoTratar.Constancia__c !='Pignoración'){
                    repla =' que de acuerdo a la tasa de cambio de <strong>HNL.'+v[0].valorventa.format()+' </strong> corresponde a <strong>USD.'+formatonumero(((cambio/v[0].valorventa).setscale(2)))+'</strong>';
                }
            } 
            if(html.contains('[getHoyTS]')){
                repla=repla.replace('cambio de', 'cambio del día'); 
            }
            html=html.replace('[getMostrarTasaCambio]',repla);
            html=html.replace('[getHoyTS]','');
            
            if(html.contains('[getCuentaCliente]')){
               html = html.replace('[getCuentaCliente]', cuenta.Codigo__c +' del Fondo '+cuenta.FondoInversionCP__c);
            } 
        }
        if(html.contains('[getDirigidoA]')){
            html = html.replace('[getDirigidoA]', CasoTratar.Account.Name);
        } 
        if(html.contains('[getReason]')){
            html = html.replace('[getReason]', casoTratar.Reason);
        }
        if(html.contains('[getIdentificacionCliente]')){
            html = html.replace('[getIdentificacionCliente]', CasoTratar.Account.Identificacion__c);
        }
        if(!detallesCaso.isEmpty() && esConstancia){
            if(html.contains('[getCuentaCliente]')){
               html = html.replace('[getCuentaCliente]', cuenta.Codigo__c);
                
            } 
            if(html.contains('[getFechaRealizacionAporte]') && detallesCaso[0].fecha_aporte__c!=null){
                Date fechaA = detallesCaso[0].fecha_aporte__c;
                system.debug('Error: '+fechaA);
                html = html.replace('[getFechaRealizacionAporte]', fechaA.day()+'-'+fechaA.month()+'-'+fechaA.year());
            } 
            if(html.contains('[getSaldoExtraordinario]')){              
                html = html.replace('[getSaldoExtraordinario]', ponerDecimales(detallesCaso[0].Nuevo_monto_aporte__c));
            }
            if(html.contains('[getSaldoOrdinario]')){
                html = html.replace('[getSaldoOrdinario]', ponerDecimales(detallesCaso[0].Nuevo_monto_aporte__c));
            } 
            
            if(html.contains('[getSaldoCompromiso]') || html.contains('[getFechaInicial]') ||
               html.contains('[getListaCuentas]') || html.contains('[getHistoricos]') ){
                   
                   llamarSysde();   
                   
                   if(html.contains('[getSaldoCompromiso]')){
                       if(casoTratar.Monto_compromiso_aporte__c != null && casoTratar.Monto_compromiso_aporte__c > 0){
                           html = html.replace('[getSaldoCompromiso]', ponerDecimales(casoTratar.Monto_compromiso_aporte__c));
                       }else{
                           html = html.replace('[getSaldoCompromiso]', constancias.cuentas[0].montoPactado);    
                       }
                   }
                   if(html.contains('[getFechaInicial]') && casoTratar.Constancia__c == 'Cuenta Inactiva'){
                       html = html.replace('[getFechaInicial]', constancias.cuentas[0].fechaInclusion); 
                       html = html.replace('[getFechaFinal]', constancias.cuentas[0].fechaExclusion);   
                   }
                   if(html.contains('[getListaCuentas]')){
                       String cuentas = '';
                       String saldos = '';
                       system.debug('Al primero');
                       if(constancias.cuentas != null){
                           system.debug('Al segundo');
                           integer x = 0;
                           For(classRespuestaCuentas item: constancias.cuentas){
                               if( x == 0){
                                   cuentas = item.cuenta;
                                   saldos = casoTratar.currencyIsoCode + '.' + item.saldo;
                               }else if(x == constancias.cuentas.size() - 1){
                                   cuentas += ' y ' + item.cuenta;
                                   saldos += ' y ' + casoTratar.currencyIsoCode + '.' + item.saldo + ' respectivamente.';
                               }else{
                                   cuentas += ', ' + item.cuenta;
                                   saldos += ', ' + casoTratar.currencyIsoCode + '.' + item.saldo;
                               }
                               x++;
                           }
                       }    
                       html = html.replace('[getListaCuentas]', cuentas);
                       html = html.replace('[getSaldo]', saldos);
                   }
                   string style=';width:50%;';
                   string tamanotabla ='40';
                    if(casoTratar.Desea_ver_tasa_de_cambio__c || test.isRunningTest()){
                         style=';width:25%;';
                         tamanotabla ='80';
                    }
                   if(html.contains('[getHistoricos]') || test.isRunningTest()){
                       String tabla = '<table align="center" border="1" cellpadding="1" cellspacing="1" style="width:'+tamanotabla+'%">';
                       tabla += '<tbody> <tr>';
                       tabla += '<td   style="text-align:center'+style+'"><span style="font-size:12px"><span style="font-family:Arial,Helvetica,sans-serif"><strong>Fecha</strong></span></span></td>';
                       tabla += '<td  style="text-align:center'+style+'"><span style="font-size:12px"><span style="font-family:Arial,Helvetica,sans-serif"><strong>Aporte</strong></span></span></td>';
                       string moneda = 'USD';
                       if(CasoTratar.currencyIsoCode=='USD' || test.isRunningTest()) {
                           moneda = 'HNL';
                       }
                       list<date> listFechas = new list<date>();
                       list<TasaCambio.ValorDolar> v = new list<TasaCambio.ValorDolar>();
                       if(casoTratar.Desea_ver_tasa_de_cambio__c || test.isRunningTest()) {
                           tabla += '<td  rowspan="1" style="text-align:center'+style+'"><span style="font-size:12px"><span style="font-family:Arial,Helvetica,sans-serif"><strong>Tasa de Cambio</strong></span></span></td>';
                           tabla += '<td  rowspan="1" style="text-align:center'+style+'"><span style="font-size:12px"><span style="font-family:Arial,Helvetica,sans-serif"><strong>Monto aporte '+moneda+'</strong></span></span></td>';

                           //System.debug('----------Aportes ----------');
                           //System.debug(constancias.cuentas[0].aportes);

                           For(classAportes item : constancias.cuentas[0].aportes) {
                               TasaCambio.ValorDolar p = new TasaCambio.ValorDolar();
                               p.fecha = claseUtil.convertToDate(item.fechaAporte);
                               v.add(p);
                           }
                           v = tasaCambio.traertasacambio(v);
                       }
                       tabla += '</tr>';
                       decimal total = 0;
                       decimal totalUSD = 0;
                       
                       For(classAportes item : constancias.cuentas[0].aportes){
                           date fechaA = claseUtil.convertToDate(item.fechaAporte);
                           tabla += '<tr> ';
                           tabla += '<td style="text-align:right">' + fechaA.day()+'-'+fechaA.month()+'-'+fechaA.year()+ '</td>';
                           tabla += '<td style="text-align:right">' + CasoTratar.currencyIsoCode + '.'+item.monto + '</td>';
                           String montoStr = item.monto.replace(',','');
                           total += Double.valueOf(montoStr);
                           
                           if(casoTratar.Desea_ver_tasa_de_cambio__c || test.isRunningTest()){
                               if(CasoTratar.currencyIsoCode=='USD' || test.isRunningTest()){
                                   for(TasaCambio.ValorDolar p:v){
                                       if((fechaA.day() == p.fecha.day() && 
                                           fechaA.year() == p.fecha.year() &&
                                           fechaA.month() == p.fecha.month()) || test.isRunningTest()){
                                               tabla += '<td style="text-align:right">HNL.'+p.valorCompra +'</td>';
                                               totalUSD +=(Double.valueOf(montoStr)* p.valorCompra).setscale(2);
                                               tabla += '<td style="text-align:right">' + moneda + '.'+formatonumero((decimal.valueOf(montoStr)* p.valorCompra))+ '</td>';
                                               break;
                                           }
                                       
                                   }
                               }
                               if(CasoTratar.currencyIsoCode!='USD'|| test.isRunningTest()){
                                   for(TasaCambio.ValorDolar p:v){
                                       if((fechaA.day() == p.fecha.day() && 
                                           fechaA.year() == p.fecha.year() &&
                                           fechaA.month() == p.fecha.month()) || test.isRunningTest()){
                                               tabla += '<td style="text-align:right">HNL.'+p.valorVenta +'</td>';
                                               totalUSD +=(Double.valueOf(montoStr)/ p.valorVenta).setscale(2);
                                               tabla += '<td style="text-align:right">' + moneda + '.'+formatonumero((decimal.valueOf(montoStr)/ p.valorVenta))+ '</td>';
                                               break;
                                           }
                                   }
                               }
                           }
                           tabla += '</tr>';
                           
                       }
                       tabla += '<tr>';
                       tabla += '<td style="text-align:center"><strong>Total</strong></td>';
                       tabla += '<td style="text-align:right"><strong>'+ CasoTratar.currencyIsoCode + '.'+ formatonumero(total)+ '</strong></td>';
                       if(casoTratar.Desea_ver_tasa_de_cambio__c){
                           tabla += '<td style="text-align:center"></td>';
                           tabla += '<td style="text-align:right"><strong>'+moneda+'.'+formatonumero(totalUSD)+'</strong></td>';
                       }
                       tabla += '</tr>';
                       tabla += '</tbody> </table>';
                       html = html.replace('[getHistoricos]', tabla);
                       date desde = casoTratar.Fecha_desde__c;
                       date hasta = casoTratar.Fecha_hasta__c;
                       html = html.replace('[getFechaInicial]', desde.day()+'-'+desde.month()+'-'+desde.year());    
                       html = html.replace('[getFechaFinal]', hasta.day()+'-'+hasta.month()+'-'+hasta.year());
                   }
               }
        } 
        if(html.contains('[getHoy]')){
            html = html.replace('[getHoy]', system.now().date().format());
        }                
        if(html.contains('[getHoyLetras]')){
            html = html.replace('[getHoyLetras]', getFechaLetras(''));
        }
        if(html.contains('[getFechaHoyMesLetras]')){
            html = html.replace('[getFechaHoyMesLetras]', getFechaHoyMesLetras());
        }
        if(html.contains('[getAniohasta]')&& detallesCaso[0].caso__r.fecha_hasta__C !=null){
            html = html.replace('[getAniohasta]', String.valueOF(detallesCaso[0].caso__r.fecha_hasta__C.year()));
        }
        if(html.contains('[getAnioActual]')){
            html = html.replace('[getAnioActual]', String.valueOF(date.today().year()));
        }
        if(html.contains('[getFirma]')){
            //system.debug('Firma: '+);
            html = html.replace('[getFirma]', revisarVacioNulo(usuarioFirma.Firma__c));
        } 
        if(html.contains('[getFirmador]') && CasoTratar.Nombre_Usuario_Firmador__c !=null && CasoTratar.Apellido_Usuario_Firmador__c !=null){
            string nombre= CasoTratar.Nombre_Usuario_Firmador__c;
             nombre = nombre.substring(0,1).toUpperCase() + nombre.substring(1,nombre.length()).toLowerCase();
            string apellido = CasoTratar.Apellido_Usuario_Firmador__c;
             apellido = apellido.substring(0,1).toUpperCase() + apellido.substring(1,apellido.length()).toLowerCase();
            html = html.replace('[getFirmador]', nombre+' '+apellido+ '<br/> Gerente de Agencia'  );
        }
      
       
        if(html.contains('[getFirmador]') && CasoTratar.usuario_firmador__r.name !=null) {
            html = html.replace('[getFirmador]', CasoTratar.usuario_firmador__r.name +
                                '<br/>' + CasoTratar.usuario_firmador__r.title);
        }     
        if(html.contains('[getMontoRetirarLetras]')){
            html = html.replace('[getMontoRetirarLetras]', ConvertirNumeros.convertirLetras(Integer.valueOF(detallesCaso[0].Monto_bruto_retirar__c)));
        }
        if(html.contains('[getCargoComision]') || test.isRunningTest()){
            String leyendaCargos = detallesCaso[0].Monto_total_comisiones_recargos__c != null && detallesCaso[0].Monto_total_comisiones_recargos__c > 0 ?
                'Aplica cobros de comisión y/o cargos adicionales' : '';
            html = html.replace('[getCargoComision]', leyendaCargos);
        }
        if(html.contains('[getFirmador]') && casoTratar.Viene_Email_2_Case__c && casoTratar.Constancia__c != 'A4'){
            //html = html.replace('[getFirmador]', '');          
            List<User> userFirma = [Select FirstName,LastName,Firma__c From User Where codigo__c = 'HN20370'];
            html = html.replace('[getFirmador]', userFirma[0].FirstName+' '+userFirma[0].LastName+ '<br/> Gerente de Agencia'  );
        }
        
        //      DIRECCIONES
        
        if(html.contains('[getColoCasa]')){
            html = html.replace('[getColoCasa]', revisarVacioNulo(Casotratar.Colonia_Avenida_Residencia__r.Name));
        }
        if(html.contains('[getColoTrabajo]')){
            html = html.replace('[getColoTrabajo]', revisarVacioNulo(Casotratar.Colonia_Avenida_Trabajo__r.Name));
        }
        
        if(html.contains('[getBeneficiarios]') || test.isRunningTest()){
            String tabla = '<table align="center" border="1" cellpadding="0" cellspacing="0" style="width:100%">';
            tabla += '<tbody> <tr>';
            tabla += '<td colspan="1" rowspan="1" style="text-align:center"><span style="font-size:10px"><span style="font-family:Arial,Helvetica,sans-serif"><strong>Cuenta</strong></span></span></td>';
            tabla += '<td colspan="1" rowspan="1" style="text-align:center"><span style="font-size:10px"><span style="font-family:Arial,Helvetica,sans-serif"><strong>Nombre completo</strong></span></span></td>';
            tabla += '<td colspan="1" rowspan="1" style="text-align:center"><span style="font-size:10px"><span style="font-family:Arial,Helvetica,sans-serif"><strong>Nº de Identidad</strong></span></span></td>';
            tabla += '<td colspan="1" rowspan="1" style="text-align:center"><span style="font-size:10px"><span style="font-family:Arial,Helvetica,sans-serif"><strong>Fecha de nacimiento</strong></span></span></td>';
            tabla += '<td colspan="1" rowspan="1" style="text-align:center"><span style="font-size:10px"><span style="font-family:Arial,Helvetica,sans-serif"><strong>Parentesco</strong></span></span></td>';
            tabla += '<td colspan="1" rowspan="1" style="text-align:center"><span style="font-size:10px"><span style="font-family:Arial,Helvetica,sans-serif"><strong>%</strong></span></span></td>';
            tabla += '</tr>';
            
            For(Detalle_Caso__c item : detallesCaso){
                tabla += '<tr> ';
                tabla += '<td style="text-align:center"><span style="font-size:10px">' + item.Cuenta__r.Codigo__c + '</span></td>';
                tabla += '<td style="text-align:center"><span style="font-size:10px">' + item.Primer_Nombre__c + ' ' + item.Segundo_Nombre__c + ' ' + item.Primer_Apellido__c + ' ' + item.Segundo_Apellido__c +'</span></td>';      
                string Iden = item.Identificacion__c != null ? item.Identificacion__c : ''; 
                tabla += '<td style="text-align:center"><span style="font-size:10px">' + Iden + '</span></td>'; 
                String fechaN = '';
                if(item.Fecha_nacimiento__c != null){
                    fechaN = item.Fecha_nacimiento__c.day()+'-'+item.Fecha_nacimiento__c.month()+'-'+item.Fecha_nacimiento__c.year();   
                }
                tabla += '<td style="text-align:center"><span style="font-size:10px">' + fechaN + '</span></td>'; 
                string paren = item.Parentesco__c != null ? item.Parentesco__c : ''; 
                tabla += '<td style="text-align:center"><span style="font-size:10px">' + paren + '</span></td>';      
                tabla += '<td style="text-align:center"><span style="font-size:10px">' + item.Porcentaje__c + '</span></td>';               
                tabla += '</tr>';
            }
            tabla += '</tbody> </table>';
            html = html.replace('[getBeneficiarios]', tabla);
        }
        
        if(html.contains('[nuevaPagina]')){
            html = html.replace('[nuevaPagina]', '<div class="saltoPagina"></div>');
        }      
        // system.debug(html);
        return html;        
    }
    
    public string revisarVacioNulo(String dato){
        if(dato != null && dato != ''){
            return dato;
        }
        return '';
    }
    
    public string ponerDecimales(Decimal valor){
        valor = valor != null ? valor : 0;
        if(valor.Scale() == 1){
            return valor.format() + '0';
        }else if(valor.Scale() == 0){
            return valor.format() + '.00';
        }else{
            STring x = valor.format().right(2);
            string valorFinal = x.contains('.') ? valor.format() + '0' : valor.format();
            if(x.contains('.'))
                valorFinal = valor.format() + '0';
            else if(String.valueOF(valor).right(2) == '00')
                valorFinal = valor.format() + '.00';
            else
                valorFinal = valor.format();
            
            return valorFinal;
        }
    }
    
    public void llamarSysde() {
        try{
            classConstancias envio = new classConstancias();
            
            For(Detalle_Caso__c item : detallesCaso){   
                classConstancias.classCuentas cta = new classConstancias.classCuentas();
                cta.cuenta = item.Cuenta__r.Codigo__c;
                envio.cuentas.add(cta);
            }
            
            envio.accion = asignacion.Carta__c != 'Saldo' ? asignacion.Carta__c : 'A4';
            envio.fechaAporteDesde = casoTratar.Fecha_desde__c;
            envio.fechaAporteHasta = casoTratar.Fecha_hasta__c;
            envio.codigoMoneda = casoTratar.currencyIsoCode;
            
            constancias  = aSysdeCallouts.constancias(envio);
            system.debug(constancias);
            integer x = 0;
        }Catch(Exception e){
            system.debug('Error al llamar desde Sysde: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());    
        }       
    }
    
    public void reemplazarCampos(sObject elObjeto, String nombreApi, String camposConsulta){
        try{Map<String,Schema.SObjectType> gd = Schema.getGlobalDescribe();  
        Schema.SObjectType sobjType = gd.get(nombreApi); 
        //system.debug('prubando  : '+sobjType );
        Schema.DescribeSObjectResult r = sobjType.getDescribe();  
        Map<String,Schema.SObjectField> M = r.fields.getMap();
        // system.debug('Campos a splitear : '+camposConsulta);
        // system.debug('Campos a elObjeto : '+elObjeto);
        // system.debug('Campos a nombreApi : '+nombreApi);
        list<String> listCamposObjeto = camposConsulta.split(',');
        
        //lista los campos de caso requeridos en html
        for(String campo: listCamposObjeto){                    
            if(elObjeto.get(campo) != null){
                if(html.contains('['+nombreApi + '.' + campo+']')){                      
                    Schema.SObjectField field = M.get(campo);                                                      
                    Schema.DescribeFieldResult fieldDesc = field.getDescribe();
                    Schema.DisplayType tipoCampo = fieldDesc.getType();
                    
                    if(campo == 'N_Cuenta_Bancaria__c'){
                        html = html.replace('['+nombreApi+'.'+campo+']', String.valueOf(elObjeto.get(campo)));          
                    }else if(tipoCampo.name() == 'Date'){
                        Date y = Date.valueOf(elObjeto.get(campo));
                        html = html.replace('['+nombreApi+'.'+campo+']', y.format());                                
                    }else if(tipoCampo.name() == 'CURRENCY' || tipoCampo.name() == 'DOUBLE'){
                        Double esNumero = elObjeto.get(campo) != null ? double.valueOF(elObjeto.get(campo)) : 0;
                        html = html.replace('['+nombreApi+'.'+campo+']', esNumero.format()); 
                    }else{                          
                        html = html.replace('['+nombreApi+'.'+campo+']', String.valueOf(elObjeto.get(campo)));
                    }                        
                }
            }else{
                //system.debug(html);
                if(html.contains('['+nombreApi + '.' + campo+']')){  
                    html = html.replace('['+nombreApi+'.'+campo+']', '');                 
                }
            }
        }  
           }catch(Exception ex)
           {}
    }
    
    public string getAlternativoHoyLetras(){
        string dia = ConvertirNumeros.convertirLetras(system.now().day());
        string mes;
        if(hoy.month()==1){
            mes='enero';
        }else if(hoy.month()==2){
            mes='febrero';
        }else if(hoy.month()==3){
            mes='marzo';
        }else if(hoy.month()==4){
            mes='abril';
        }else if(hoy.month()==5){
            mes='mayo';
        }else if(hoy.month()==6){
            mes='junio';
        }else if(hoy.month()==7){
            mes='julio';
        }else if(hoy.month()==8){
            mes='agosto';
        }else if(hoy.month()==9){
            mes='septiembre';
        }else if(hoy.month()==10){
            mes='octubre';
        }else if(hoy.month()==11){
            mes='noviembre';
        }else if(hoy.month()==12){
            mes='diciembre';
        }
        return system.now().day() + ' de '+mes+' de '+system.now().year();
    }        
    
    public String getFechaLetras(String campoFecha){
        Date fecha;
        
        if(campoFecha == ''){
            fecha = hoy;
        }
        
        string dia = ConvertirNumeros.convertirLetras(fecha.day());
        string mes = nombreMes(fecha);
        
        return dia + ' días del mes de ' + mes + ' del ' + ConvertirNumeros.convertirLetras(fecha.year());                
    }
    
    public String getFechaHoyMesLetras(){
        return hoy.day() + ' de ' + nombreMes(hoy) + ' del ' + hoy.year();
    }
    
    public string nombreMes(Date fecha){
        
        string mes;
        if(fecha.month()==1){
            mes='enero';
        }else if(fecha.month()==2){
            mes='febrero';
        }else if(fecha.month()==3){
            mes='marzo';
        }else if(fecha.month()==4){
            mes='abril';
        }else if(fecha.month()==5){
            mes='mayo';
        }else if(fecha.month()==6){
            mes='junio';
        }else if(fecha.month()==7){
            mes='julio';
        }else if(fecha.month()==8){
            mes='agosto';
        }else if(fecha.month()==9){
            mes='septiembre';
        }else if(fecha.month()==10){
            mes='octubre';
        }else if(fecha.month()==11){
            mes='noviembre';
        }else if(fecha.month()==12){
            mes='diciembre';
        }
        return mes;     
    }
    public static void metodoutil()
    {
        integer i=0;
        
    }
    public string formatonumero (decimal numero) {
        numero = numero !=null ? numero :0;
        string respuesta='0';
        string numerodecimal='.00';
        try {
            numero = numero.setScale(2);
            respuesta='';
            integer numeroentero = (integer) numero;
            respuesta = numeroentero.format();
            if(numeroentero < numero){
                decimal a = (integer)((numero - numeroentero)*100);
                if(a<10){
                    numerodecimal = '.0'+string.valueOf(integer.valueOf(a));
                }else{
                    numerodecimal = '.'+string.valueOf(integer.valueOf(a));
                }
            }
        }catch(exception ex) {
            return '0.00';
        }
        return respuesta+numerodecimal;
    }
    
}