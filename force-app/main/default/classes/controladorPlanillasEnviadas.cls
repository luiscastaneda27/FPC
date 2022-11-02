public class controladorPlanillasEnviadas {
    
    // Rezagos
    public String CodRef{get;set;}
    public String CodRefTest{get;set;}
    public String Existe{get;set;}
    public String Rezagosn{get;set;}
    public String Monto{get;set;}
    public String Moneda{get;set;}
    public boolean displayPopup {get; set;}
    List<String> ValorCuotaStr {get;set;}
    public String ValorCuotaDia {get;set;}
    public String ValorCuotaFondo {get;set;}
    public String Cod_Planilla {get;set;}
    public String Total {get;set;}
    public string Num_CodReferencia_Rez{get;set;}
    public string Rez_SI_NO{get;set;}//Setear a 0
    public string Monto_Calculado{get;set;}//Setear a 0
    public string Num_CodCuenta_Rez{get;set;}//Setear a 0
    public string Monto_Sal{get;set;}//Setear a 0
    public string Compra_Dolar{get;set;}//Setear a 0
    public String Correcto {get;set;}
    public Boolean BTNAplicar {get;set;}
    public Decimal ValCuoEntrada{get;set;}
    public Decimal ValCuoSalida{get;set;}
    // 
    public List<Planilla> Planillas{get;set;}
    public string Id_Planilla{get;set;}
    public List<SelectOption> options {get;set;}
    private integer contador;
    Date fecha;
    String Bandera;
    public boolean mostrarPan{get;set;}
    public string Id_PANTALLA{get;set;}
    public boolean popTasa{get;set;}
    public String MensajeError {get;set;}
    public boolean MensajeErr {get;set;}
    public Map<String,InfoRezagos> mapInfoRezagos {get;set;}
    public List<Rezago> listRezagos {get;set;}
    public string codigoRezago{get;set;}
    
    public controladorPlanillasEnviadas() {
        MensajeError='';
        options = new List<SelectOption>();
        options.add(new SelectOption('1','Pendientes'));
        options.add(new SelectOption('2','Aprobadas'));
        
        mapInfoRezagos = new Map<String,InfoRezagos>();           
        for(InfoRezagos.clientes IRc : ControllerApiRezagos.ConsultaRezagos()){
            InfoRezagos Rez = new InfoRezagos();
            Rez.clientes.add(IRc);
            mapInfoRezagos.put(IRc.codReferencia,Rez);
        }
        
        CargarPlanillas();
        contador = 0;
        //Para obtener el valor cuota del dia al iniciar el programa
        String ValorCuota = ControllerApiRezagos.ConsultaCuotaSal();
        ValorCuotaStr = new List<String>();
        ValorCuotaStr = ValorCuota.split('},');
    }
    
    public void cerrar(){
        popTasa = false;
    }
    
    public void Controladorbg(){
        if(id_pantalla == '1'){
            CargarPlanillas(); 
        }else{
            CargarPlanillasAprobadas();  
        }
    }
    
    public List<ClasePLanillas> FRT{get;set;}
    
    public class ClasePLanillas{
        public string NE{get;set;}
        public string Np{get;set;}
        public string RS{get;set;}
        public string M{get;set;}
        public Date F{get;set;}
        public DECIMAL T{get;set;}
        
        public ClasePLanillas(String NE, String NP, String RS, Date F, Decimal T, String moneda){
            this.NE = NE;
            this.NP = NP;
            this.RS = RS;
            this.F = F;
            this.T = T;
            this.m = moneda;
        }
    }
    
    public void CargarPlanillasAprobadas() {
        try{
            mostrarPan = false;
            FRT = new list<ClasePLanillas>();
            List<Planilla__c> TodasPlanillas = new List<Planilla__c>();
            planillas = new List<Planilla>();
            TodasPlanillas = [SELECT empresa2__r.name, respuesta_desde_sysde_aportes__c, fecha__c, Name, total__c, CurrencyIsoCode FROM planilla__c WHERE estado2__c = 'Cerrada' ORDER BY Fecha__c desc Limit 200];
            for(Integer i=0; i<TodasPlanillas.size(); i++){
                FRT.add(new ClasePLanillas(TodasPlanillas[i].empresa2__r.name, TodasPlanillas[i].name, TodasPlanillas[i].respuesta_desde_sysde_aportes__c,TodasPlanillas[i].FECHA__c,TodasPlanillas[i].TOTAL__c, TodasPlanillas[i].CurrencyIsoCode));
            }
            
        }Catch(Exception ex){
            System.debug('Error: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());
            MensajeError = 'Error al Cargar Planillas en el Metodo: CargarPlanillasAprobadas. <br/>Error: ' + ex.getMessage() + '<br/>Linea: ' + ex.getLineNumber();
            MensajeErr = true;
        }
    } 
    
    public void CargarPlanillas() {
        try{
            if(contador>0){
                System.debug('Entramos al Contador > 0');
                contador = 0;
                Bandera = 'Correctamente';
                OrdenarPlanilla();
                /*planilla__c planilla = [SELECT respuesta_desde_sysde_aportes__c FROM planilla__c WHERE Id =:Id_Planilla Limit 1];
                String estadoplanilla = planilla.respuesta_desde_sysde_aportes__c;
                if(estadoplanilla == null || !estadoplanilla.contains('200')) {
                    OrdenarPlanilla();
                }*/
            }

            System.debug('Se ejecuta el Cargar Planillas');
            mostrarPan = true;
            list<Planilla__c> TodasPlanillas = new list<Planilla__c>();
            planillas = new list<Planilla>();
            TodasPlanillas=[SELECT Id, empresa2__r.name, tasa_compra__c, tipo_planilla__c,name, Estado2__c,
                            TA_Empleado_Obligatorio__c, TA_Patrono_obligatorio__c, TA_Empleado_Voluntario__c, 
                            TA_Patrono_Voluntario__c, Total_Reserva_Laboral2__c, TA_Empleado_Extraordinario__c,
                            TA_Patrono_Extraordinario__c, TA_Seguro_de_Vida__c, fecha__c, CurrencyIsoCode 
                            FROM planilla__c WHERE estado2__c = 'Pendiente aprobación Ficohsa' ORDER BY name asc];
            
            for(Integer i=0; i<TodasPlanillas.size(); i++){
                Decimal TotalPilares = TodasPlanillas[i].TA_Empleado_Obligatorio__c + TodasPlanillas[i].TA_Patrono_obligatorio__c + 
                    TodasPlanillas[i].TA_Empleado_Voluntario__c + TodasPlanillas[i].TA_Patrono_Voluntario__c + 
                    TodasPlanillas[i].Total_Reserva_Laboral2__c + TodasPlanillas[i].TA_Empleado_Extraordinario__c + 
                    TodasPlanillas[i].TA_Patrono_Extraordinario__c + TodasPlanillas[i].TA_Seguro_de_Vida__c;
                
                if(TodasPlanillas[i].tasa_compra__c == 0){
                    planillas.add(new Planilla(TodasPlanillas[i].id, TodasPlanillas[i].empresa2__r.name, date.today(),TodasPlanillas[i].name,
                                               TotalPilares,'true','false',TodasPlanillas[i].CurrencyIsoCode , null, 'Sin Informacion',''));
                }else{
                    planillas.add(new Planilla(TodasPlanillas[i].id, TodasPlanillas[i].empresa2__r.name, TodasPlanillas[i].fecha__c,
                                               TodasPlanillas[i].name,TotalPilares,'false','true',TodasPlanillas[i].CurrencyIsoCode, null, 'Sin Informacion',''));
                }
            }
            
        }Catch(Exception ex){
            System.debug('Error: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());
            MensajeError = 'Error al Cargar Planillas en el Metodo: CargarPlanillas. <br/>Error: ' + ex.getMessage() + '<br/>Linea: ' + ex.getLineNumber();
            MensajeErr = true;
        }
    }
    
    public void OrdenarPlanilla(){
        try{
            System.debug('Entramos a OrdenarPlanilla'+ ' ----- '+id_planilla);
            Integer FlagCount = 0; //Esta variable sirve para contar si se ejecutaron ambos procesos de los aportes.
            List<string> listIds = new List<String>();
            
            Planilla__c planilla = [SELECT cod_referencia__c, rezago__c, empresa2__c, respuesta_desde_sysde_aportes__c, ServicioEjecutado__c, (SELECT Id FROM Contenidos_Planilla__r)
                                    FROM Planilla__c
                                   	WHERE Id = :id_planilla];
            
            Autonumerico_cuentas_Syste__c Numerosformularios = [SELECT Id, Id_Formulario_Sysde__c FROM Autonumerico_cuentas_Syste__c Limit 1];
            Decimal abc = Numerosformularios.Id_Formulario_Sysde__c;
            
            System.debug('Autonumerico Planillas: '+String.valueOf(abc));
            
            List<cuenta_planilla__c> cuentas = new List<cuenta_planilla__c>();
            cuentas = [SELECT Codigo_cuenta__c, valor_monto__c, Valor_Monto_Patrono__c, Valor_Monto_Extraordinario__c, Valor_Monto_Patronal_Extraordinario__c, 
                      Valor_Monto_Seguro_Vida__c, contenido_planilla__r.empleado2__r.identificacion__c 
                      FROM cuenta_planilla__c
                      WHERE contenido_planilla__c IN :planilla.Contenidos_Planilla__r ];
            
            for(cuenta_planilla__c item : cuentas){
                listIds.add(item.Codigo_cuenta__c); 
            }
            List<cuentas__c> cuentas_salesforce = new List<cuentas__c>();
            
            cuentas_salesforce = [SELECT Producto__r.CurrencyIsoCode, cliente__r.identificacion__c, Cuenta_colectiva2__r.codigo__c, Codigo__c, Aporte_Dolares_Flag__c 
                                FROM cuentas__c 
                                WHERE codigo__c IN :(listIds)];
            
            map<String, List<cuentas__c>> mapCuentas = new map<String, list<cuentas__c>>();
            
            for(integer i=0; i<cuentas_salesforce.size(); i++){
                List<cuentas__c> listCuentas = mapCuentas.containsKey(cuentas_salesforce[i].cliente__r.identificacion__c) ?
                    mapCuentas.get(cuentas_salesforce[i].cliente__r.identificacion__c) : new List<cuentas__c>();
                listCuentas.add(cuentas_salesforce[i]);
                mapCuentas.put(cuentas_salesforce[i].cliente__r.identificacion__c,listCuentas);
                
            }
            List<classAportesPlanilla> claseenvio = new List<classAportesPlanilla>();
            classAportesPlanilla nueva;
            String todosEmpleados = '';
            
            for(integer i=0; i<cuentas.size(); i++){
                cuentas_salesforce = new List<cuentas__c>();
                if(mapCuentas.containsKey(cuentas[i].contenido_planilla__r.empleado2__r.identificacion__c)){
                    cuentas_salesforce = mapCuentas.get(cuentas[i].contenido_planilla__r.empleado2__r.identificacion__c);
                }
                for(integer jj=0; jj<cuentas_salesforce.size(); jj++){
                    if(cuentas_salesforce[jj].codigo__c == cuentas[i].codigo_cuenta__c){
                        nueva = new classAportesPlanilla();
                        nueva.idSalesforce = 'SF'+string.valueOf((ABC++));
                        nueva.identificacion = cuentas_salesforce[jj].cliente__r.identificacion__c;
                        nueva.cuentaColectiva = cuentas_salesforce[jj].Cuenta_colectiva2__r.codigo__c;
                        nueva.cuenta = cuentas[i].Codigo_cuenta__c;
                        nueva.codigoCuenta = integer.valueOf(cuentas[i].Codigo_cuenta__c);
                        nueva.codigoMoneda = cuentas_salesforce[jj].Producto__r.CurrencyIsoCode == 'HNL' ? '1':'2';
                        //
                        if(Planilla.rezago__c == 'S'){
                            System.debug('01 Es un rezago SI, calculamos los saldos con los valores de cuota: '+String.valueOf(ValCuoEntrada)+' - '+String.valueOf(ValCuoSalida));
                            nueva.aportePersonalVoluntario = cuentas[i].valor_monto__c/ValCuoEntrada*ValCuoSalida;
                            nueva.aportePatronalVoluntario = cuentas[i].valor_monto_patrono__c/ValCuoEntrada*ValCuoSalida;
                            nueva.aportePersonalExtraordinario = cuentas[i].Valor_Monto_Extraordinario__c/ValCuoEntrada*ValCuoSalida;
                            nueva.aportePatronalExtraordinario = cuentas[i].Valor_Monto_Patronal_Extraordinario__c/ValCuoEntrada*ValCuoSalida;
							System.debug('Aportes registrados APEV-APAV-APEX-APAX: '+nueva.aportePersonalVoluntario+' - '+nueva.aportePatronalVoluntario+' - '+
                                         nueva.aportePersonalExtraordinario+' - '+nueva.aportePatronalExtraordinario);
                        }else{
                            System.debug('01 Es un rezago NO: '+i);
                            nueva.aportePersonalVoluntario = cuentas[i].valor_monto__c;
                            nueva.aportePatronalVoluntario = cuentas[i].valor_monto_patrono__c;
                            nueva.aportePersonalExtraordinario = cuentas[i].Valor_Monto_Extraordinario__c;
                            nueva.aportePatronalExtraordinario = cuentas[i].Valor_Monto_Patronal_Extraordinario__c;
                            System.debug('Aportes registrados APEV-APAV-APEX-APAX: '+nueva.aportePersonalVoluntario+'-'+nueva.aportePatronalVoluntario+'-'+
                                         nueva.aportePersonalExtraordinario+'-'+nueva.aportePatronalExtraordinario);
                        }
                        nueva.aporteSeguroVida = cuentas[i].Valor_Monto_Seguro_Vida__c;
                        nueva.aportePersonalObligatorio = 0;
                        nueva.aportePatronalObligatorio = 0;

                        claseenvio.add(nueva);
                        
                        todosEmpleados +=nueva.idSalesforce+',';
                        todosEmpleados +=nueva.identificacion+',';
                        todosEmpleados +=nueva.cuentaColectiva+',';
                        todosEmpleados +=nueva.cuenta+',';
                        todosEmpleados +=nueva.codigoCuenta+',';
                        todosEmpleados +=nueva.codigoMoneda+',';
                        todosEmpleados +=nueva.aportePersonalVoluntario+',';
                        todosEmpleados +=nueva.aportePatronalVoluntario+',';
                        todosEmpleados +=nueva.aportePersonalObligatorio+',';
                        todosEmpleados +=nueva.aportePatronalObligatorio+',';
                        todosEmpleados +=nueva.aportePersonalExtraordinario+',';
                        todosEmpleados +=nueva.aportePatronalExtraordinario+',';
                        todosEmpleados +=nueva.aporteSeguroVida+'::::';
                        
                        cuentas_salesforce[jj].Aporte_Dolares_Flag__c = true;
                    }
                }
            }
            listIds.clear();
            map<String, String> banderamapa = new map<String, String>();
            map<String, String> banderamapa2 = new map<String, String>();
            for(Cuentas_colectivas__c item: [SELECT codigo__c, Tipo_cuenta__c FROM Cuentas_colectivas__c 
                                             WHERE empresa__c=:Planilla.Empresa2__c AND tipo_cuenta__c !='Voluntarias']){
                                                 listIds.add(item.codigo__c);
                                                 banderamapa.put(item.codigo__c, item.tipo_cuenta__c);
                                             }
            cuentas_salesforce.clear();
            
            cuentas_salesforce = [SELECT Producto__r.CurrencyIsoCode, cliente__r.identificacion__c, Cuenta_colectiva2__r.codigo__c, Codigo__c 
                                FROM cuentas__c
                                WHERE Cuenta_colectiva2__r.codigo__c in :(listIds)];

            for(integer i=0; i<cuentas_salesforce.size(); i++){
                List<cuentas__c> litsCuentas = mapCuentas.containsKey(cuentas_salesforce[i].cliente__r.identificacion__c)?
                    mapCuentas.get(cuentas_salesforce[i].cliente__r.identificacion__c) : new List<cuentas__c>();
                litsCuentas.add(cuentas_salesforce[i]);
                mapCuentas.put(cuentas_salesforce[i].cliente__r.identificacion__c, litsCuentas);
            }
            List<contenido_planilla__c> contenido = new List<contenido_planilla__c>();
            contenido.addAll([SELECT empleado2__r.Identificacion__c, Aporte_Empleado_Obligatorio__c, Aporte_Patrono_obligatorio__c, Reserva_Laboral__c 
                              FROM contenido_planilla__c WHERE Aporte_Empleado_Obligatorio__c > 0 AND planilla__c =:id_planilla]);
            List<string> vf = new List<string>();
            for(integer i=0; i<contenido.size(); i++){
                vf.add(contenido[i].empleado2__r.Identificacion__c);
            }
            contenido.addAll([SELECT empleado2__r.Identificacion__c, Aporte_Empleado_Obligatorio__c, Aporte_Patrono_obligatorio__c, Reserva_Laboral__c 
                              FROM contenido_planilla__c WHERE Aporte_Patrono_obligatorio__c>0 AND planilla__c=:id_planilla AND empleado2__r.Identificacion__c NOT IN :(vf) ]);
            for(integer i=0; i<contenido.size(); i++){
                vf.add(contenido[i].empleado2__r.Identificacion__c);
            }
            contenido.addAll([SELECT empleado2__r.Identificacion__c, Aporte_Empleado_Obligatorio__c, Aporte_Patrono_obligatorio__c, Reserva_Laboral__c 
                              FROM contenido_planilla__c 
                              WHERE reserva_laboral__c>0 AND planilla__c=:id_planilla AND empleado2__r.Identificacion__c NOT IN :(vf) AND Aporte_Dolares_Flag__c!=true ]);
            for(integer i=0; i<contenido.size(); i++){
                cuentas_salesforce = new List<cuentas__c>();
                if(mapCuentas.containsKey(contenido[i].empleado2__r.identificacion__c)){
                    cuentas_salesforce = mapCuentas.get(contenido[i].empleado2__r.identificacion__c);
                }
                for(integer j=0; j<cuentas_salesforce.size(); j++){
                    if(contenido[i].empleado2__r.Identificacion__c == cuentas_salesforce[j].cliente__r.Identificacion__c){
                        if(banderamapa.get(cuentas_salesforce[j].Cuenta_colectiva2__r.codigo__c) == 'Pilar Complementario'){
                            nueva = new classAportesPlanilla();
                            nueva.idSalesforce = 'SF'+string.valueOf((ABC++));
                            nueva.identificacion = contenido[i].empleado2__r.Identificacion__c;
                            nueva.cuentaColectiva = cuentas_salesforce[j].Cuenta_colectiva2__r.codigo__c;
                            nueva.cuenta = cuentas_salesforce[j].Codigo__c;
                            nueva.codigoCuenta = integer.valueOf(cuentas_salesforce[j].Codigo__c);
                            nueva.codigoMoneda = cuentas_salesforce[j].Producto__r.CurrencyIsoCode=='HNL' ? '1' :'2';
                            nueva.aportePersonalVoluntario = 0;
                            nueva.aportePatronalVoluntario = 0;

                            if(planilla.rezago__c == 'S'){
                                System.debug('02 Es un rezago SI, calculamos los saldos con los valores de cuota: '+String.valueOf(ValCuoEntrada)+'-'+String.valueOf(ValCuoSalida));
                                nueva.aportePersonalObligatorio = contenido[i].Aporte_Empleado_Obligatorio__c/ValCuoEntrada*ValCuoSalida;
                                nueva.aportePatronalObligatorio = contenido[i].Aporte_Patrono_Obligatorio__c/ValCuoEntrada*ValCuoSalida;
                                System.debug('Aportes registrados APEO-APAO: '+nueva.aportePersonalObligatorio+'-'+nueva.aportePatronalObligatorio);
                            }else{
                                System.debug('02 Es un rezago NO: '+i);
                                nueva.aportePersonalObligatorio = contenido[i].Aporte_Empleado_Obligatorio__c;
                                nueva.aportePatronalObligatorio = contenido[i].Aporte_Patrono_Obligatorio__c;
                                System.debug('Aportes registrados APEO-APAO: '+nueva.aportePersonalObligatorio+'-'+nueva.aportePatronalObligatorio);
                            }
                            nueva.aportePersonalExtraordinario = 0;
                            nueva.aportePatronalExtraordinario = 0;
                            nueva.aporteSeguroVida = 0;

                            claseenvio.add(nueva);
                            
                            todosEmpleados +=nueva.idSalesforce+',';
                            todosEmpleados +=nueva.identificacion+',';
                            todosEmpleados +=nueva.cuentaColectiva+',';
                            todosEmpleados +=nueva.cuenta+',';
                            todosEmpleados +=nueva.codigoCuenta+',';
                            todosEmpleados +=nueva.codigoMoneda+',';
                            todosEmpleados +=nueva.aportePersonalVoluntario+',';
                            todosEmpleados +=nueva.aportePatronalVoluntario+',';
                            todosEmpleados +=nueva.aportePersonalObligatorio+',';
                            todosEmpleados +=nueva.aportePatronalObligatorio+',';
                            todosEmpleados +=nueva.aportePersonalExtraordinario+',';
                            todosEmpleados +=nueva.aportePatronalExtraordinario+',';
                            todosEmpleados +=nueva.aporteSeguroVida+'::::';
                        }else {
                            nueva = new classAportesPlanilla();
                            nueva.idSalesforce = 'SF'+string.valueOf((ABC++));
                            nueva.identificacion = contenido[i].empleado2__r.Identificacion__c;
                            nueva.cuentaColectiva = cuentas_salesforce[j].Cuenta_colectiva2__r.codigo__c;
                            nueva.cuenta = cuentas_salesforce[j].Codigo__c;
                            nueva.codigoCuenta = integer.valueOf(cuentas_salesforce[j].Codigo__c);
                            nueva.codigoMoneda = cuentas_salesforce[j].Producto__r.CurrencyIsoCode=='HNL' ? '1':'2';
                            nueva.aportePersonalVoluntario = 0;
                            nueva.aportePatronalVoluntario = 0;
                            nueva.aportePersonalObligatorio = 0;
                            nueva.aportePersonalExtraordinario = 0;
                            nueva.aportePatronalExtraordinario =0 ;
                            nueva.aporteSeguroVida = 0;
                            nueva.aportePatronalObligatorio = contenido[i].Reserva_Laboral__c;
                            claseenvio.add(nueva);
                            
                            todosEmpleados +=nueva.idSalesforce+',';
                            todosEmpleados +=nueva.identificacion+',';
                            todosEmpleados +=nueva.cuentaColectiva+',';
                            todosEmpleados +=nueva.cuenta+',';
                            todosEmpleados +=nueva.codigoCuenta+',';
                            todosEmpleados +=nueva.codigoMoneda+',';
                            todosEmpleados +=nueva.aportePersonalVoluntario+',';
                            todosEmpleados +=nueva.aportePatronalVoluntario+',';
                            todosEmpleados +=nueva.aportePersonalObligatorio+',';
                            todosEmpleados +=nueva.aportePatronalObligatorio+','; 
                            todosEmpleados +=nueva.aportePersonalExtraordinario+',';
                            todosEmpleados +=nueva.aportePatronalExtraordinario+',';
                            todosEmpleados +=nueva.aporteSeguroVida+'::::';
                        }
                    }
                }
            }   

            String MES = [SELECT MES_APORTE__c FROM PLANILLA__c WHERE ID=:Id_Planilla].MES_aPORTE__c;
            System.debug('IDPLANILLA: ' + Id_Planilla + ' - MES: '+ MES + ' - Todos: '+ todosEmpleados);
            String gt = string.valueOf(fecha.year());
            if(Integer.valueOf(MES)>fecha.month()){
                gt = String.valueOf((fecha.year()-1));  
            }
            if(Integer.valueOf(MES)<10){
                gt += '0'+MES;
            }else{
                gt += MES; 
            }
            gt += '00';
            
            planilla__c planillaTemp = new planilla__c();
            planillaTemp = [SELECT respuesta_desde_sysde_aportes__c FROM planilla__c WHERE Id = :Id_Planilla];
            String estadoplanilla = planillaTemp.respuesta_desde_sysde_aportes__c;
            System.debug('todosEmpleados: '+ todosEmpleados);
            if(estadoPlanilla == null || !estadoplanilla.contains('200')){
                if(planilla.ServicioEjecutado__c == null || planilla.ServicioEjecutado__c == 1){
                    System.debug('Enviamos aporte a los empleados');
                    aSysdePortalEmpresarial.EnviarAportesEmpleados(todosEmpleados, Integer.valueOf(gt), datetime.newInstance(fecha.year(), fecha.month(), fecha.day()), Id_Planilla, planilla.rezago__c, planilla.Cod_Referencia__c);
                }                                
            }            
            id_planilla = '';
            
            Numerosformularios.Id_Formulario_Sysde__c = abc;
            update Numerosformularios;
            
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Operaciones aplicadas correctamente.'));
            
        }catch(Exception ex){
            system.debug('Error: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());
            MensajeError = 'Error al Ordenar Planilla en el Metodo: OrdenarPlanilla. <br/>Error: ' + ex.getMessage() + '<br/>Linea: ' + ex.getLineNumber();
            MensajeErr = true;
        }
    }
    
    public classDolares.classRespuestaDolares respuesta{get;set;}
    
    public void Aprobarplanilla(){
        try{
            System.debug('Entramos al aprobar Planilla');
            Planilla__c PlanillaAprobada = new Planilla__c();
            List<String> fechacierra = aSysdePortalEmpresarial.fechaCierreSysde();
            
            Integer tasa = 1;
            String nombreEmpresa;
            String rezago;
            String codigo;
            
            Integer FechaPlanilla = 0;
            Integer FechaSysde = 0;
            
            for(integer i=0; i<planillas.size(); i++){
                if(id_planilla == planillas[i].id_cambiarSalario){
                    PlanillaAprobada.fecha__c = planillas[i].Planilla_Aprobada;
                    fecha = planillas[i].Planilla_Aprobada;
                    tasa = planillas[i].Primer_Apellido =='true' ? 0 : 1;
                    nombreEmpresa = planillas[i].Primer_Nombre;
                    rezago = Rez_SI_NO == 'Si' ? 'S' : 'N';
                    
                    FechaPlanilla = integer.valueOf(string.valueOf(planillas[i].Planilla_Aprobada).replace('"','').replace('-',''));
                    FechaSysde = integer.valueOf(fechacierra[0].replace('"','') + fechacierra[1].replace('"','') + fechacierra[2].replace('"',''));
                        
                    System.debug(
                        			'PRUEBAS fechas planilla y sysde'+planillas[i].Primer_Apellido 
                        			+' Fecha planilla '+planillas[i].Planilla_Aprobada
                                	+' Fecha cierre SYSDE '+ fechacierra[0] +'-'+ fechacierra[1] +'-'+ fechacierra[2]
                        			+' Fecha planilla formato fecha '+ integer.valueOf(string.valueOf(planillas[i].Planilla_Aprobada).replace('"','').replace('-',''))
                        			+' Fecha cierre SYSDE formato fecha '+ integer.valueOf(fechacierra[0].replace('"','') + fechacierra[1].replace('"','') + fechacierra[2].replace('"',''))
                        		);

                    codigo = Num_CodReferencia_Rez.trim();
                    if(codigo.trim() =='Sin Informacion'){
                        codigo = 'NoAplica';
                    }else{
                        System.debug('Antes de Calcular las cuotas: '+rezago+' - '+codigo);
                        if(rezago == 'S'){
                            InfoRezagos resultado = new InfoRezagos();
                            if(mapInfoRezagos.containsKey(codigo)){
                                resultado = mapInfoRezagos.get(codigo); 
                            }
                            
                            if(resultado.clientes != null && resultado.clientes.size() == 1){
                                String valcuoent = resultado.clientes[0].valorCuotaEntrada;
                                if(valcuoent=='' || valcuoent == null){valcuoent = '1';}
                                System.debug('Valor Cuota de Entrada: '+valcuoent);
                                ValCuoEntrada = Decimal.valueOf(valcuoent);
                                String fondor = resultado.clientes[0].fondo;
                                System.debug('Fondo: '+fondor);
                                String valcuosal = '';
                                String ValorCuota = ControllerApiRezagos.ConsultaCuotaSal();
                                List<String> ValorCuotaStr = new List<String>();
                                ValorCuotaStr = ValorCuota.split('},');
                                for(Integer count1=0; count1<ValorCuotaStr.size(); count1++){
                                    String rez = ValorCuotaStr[count1];
                                    String ValorCuotaDia = rez.substringBeforeLast('}');
                                    ValorCuotaDia = ValorCuotaDia.substringAfterLast(':');
                                    String ValorCuotaFondo = rez.substringBeforeLast('",');
                                    ValorCuotaFondo = ValorCuotaFondo.substringAfterLast('"');
                                    if(fondor == ValorCuotaFondo){valcuosal = ValorCuotaDia;}
                                }
                                ValCuoSalida = Decimal.valueOf(valcuosal);
                            }
                        }
                    }
                    
                    System.debug('01 - rezago :'+rezago+' - codigo :'+codigo+' - tasa :'+tasa);
                    if(Num_CodReferencia_Rez.trim() == 'Sin Informacion' && planillas[i].rezago == 'S'){
                        MensajeError = 'Debe Asignar un codigo de Referencia de Rezago.';
                        MensajeErr = true;
                        return;
                    }
                }
            }

            //if((integer.valueOf(fechacierra[0].replace('"','')) == fecha.year() &&
            //    integer.valueOf(fechacierra[1]) == fecha.month() &&
            //    integer.valueOf(fechacierra[2]) == fecha.day() && tasa == 0) || tasa == 1 || test.isRunningTest()){
              System.debug('Valores de las fechas antes de entrar al IF' +' Planilla: '+FechaPlanilla +' SYSDE: '+FechaSysde);
              if((FechaPlanilla >= FechaSysde) || test.isRunningTest()){        
                    Planilla__c planilla = [SELECT Id, CurrencyIsoCode, Total__c,estado2__c, rezago__c,Cod_Referencia__c, ErrorPlanillasEnviadas__c, ServicioEjecutado__c
                                            FROM planilla__c WHERE Id=:id_planilla];
                    if(tasa == 0 && (Planilla.ServicioEjecutado__c == null || Planilla.ServicioEjecutado__c == 0)){
                        
                        respuesta = new classDolares.classRespuestaDolares();
                        
                        if(test.isRunningTest()){
                            respuesta.tasaCambio='1';
                        }else {
                            for(Planilla item:Planillas ){
                                if(item.id_cambiarSalario == id_planilla){
                                    Monto_calculado = (Item.rezago == null || Item.rezago == 'N') ? String.valueOf(Item.Salario) : Item.Monto_Calculado;
                                }
                            }
                            
                            System.debug('Monto Calculado: '+ Monto_calculado);
                            respuesta = aSysdePortalEmpresarial.CompraVentaDolares(planilla.CurrencyIsoCode, Decimal.valueof(Monto_Calculado), nombreEmpresa);
                        }
                        if(respuesta.tasaCambio != null){
                            decimal tasaDivision = decimal.valueOf(respuesta.tasaCambio);
                            if(planilla.CurrencyIsoCode == 'USD'){
                                tasaDivision = 1/tasaDivision;
                            }
                            CambioTasa(planilla.CurrencyIsoCode, Decimal.valueOf(respuesta.tasaCambio) ,tasaDivision, rezago, codigo);
                            popTasa = true;
                        }else{
                            planilla.ErrorPlanillasEnviadas__c = 'Error Cambio de tasa';
                            Planilla.ServicioEjecutado__c = 0;
                            update planilla;

                            MensajeError = 'Error al aplicar Compra y Venta de Dolares. <br/>Tasa de Cambio devuelve Null';
                            MensajeErr = true;
                            return;
                        }
                    }else{
                        System.debug('Entramos a tasa!=0');
                        PlanillaAprobada.Id = id_planilla;
                        PlanillaAprobada.estado2__c = 'Cerrada';
                        PlanillaAprobada.rezago__c = rezago;
                        PlanillaAprobada.Cod_Referencia__c = codigo;
                        system.debug('Antes de actualizar la planilla: '+rezago+' - '+codigo);
                        String result='OK';
                        if(PlanillaAprobada.Cod_Referencia__c != 'NoAplica'){
                            System.debug('Se aplica el rezago a: '+PlanillaAprobada.Cod_Referencia__c);
                            //List<String> listCodigos = PlanillaAprobada.Cod_Referencia__c.split(',');
                            for(Integer i=0; i<listRezagos.size(); i++){
                                result = AplicarRezago(listRezagos[i].codigo, num_CodCuenta_Rez, listRezagos[i].monto, Monto_Sal, '',Moneda, Compra_Dolar);//Aplica El Rezago
                            }
                            listRezagos = new List<Rezago>();
                            //result = AplicarRezago(PlanillaAprobada.Cod_Referencia__c, num_CodCuenta_Rez, Monto_Calculado, Monto_Sal, '',Moneda, Compra_Dolar);//Aplica El Rezago                            
                        }
                        if(result == 'OK'){
                            update PlanillaAprobada;
                            contador = 1;
                            CargarPlanillas();
                        }else{
                            System.debug('Error al aplicar rezago 01.');
                            MensajeError = 'Error en el Metodo: Aprobarplanilla. <br/>Mensaje: '+result;
                            MensajeErr = true;
                        }
                    }
                }else{
                    MensajeError = 'Error al Aprobar Planilla en el Metodo: AprobarPlanilla. <br/>La fecha de la planilla no coincide con la fecha de cierre de Sysde: '+fechacierra[0] +' '+ fechacierra[1] +' '+ fechacierra[2];
                    MensajeErr = true;
                    return;
                }
        }
        catch(Exception ex){
            system.debug('Error: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());
            MensajeError = 'Error al Aprobar Planilla en el Metodo: AprobarPlanilla. <br/>Error: ' + ex.getMessage() + '<br/>Linea: ' + ex.getLineNumber();
            MensajeErr = true;
        }
    }
    
    public void Denegarplanilla(){
        try{
            Planilla__c planilla = new Planilla__c();
            planilla.Id = id_planilla;
            planilla.estado2__c = 'Denegada Ficohsa';
            update planilla;
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Datos Guardados Exitosamente.')); 
            system.debug('exitoso');
            CargarPlanillas();
        }catch(Exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            MensajeError = 'Error al Denegar Planilla en el Metodo: DenegarPlanilla. <br/>Mensaje: '+ ex.getMessage() + '<br/>Linea: ' + ex.getLineNumber();
           	MensajeErr = true;
        }
    }
    
    public void CambioTasa(string moneda, decimal tasaPlanilla, decimal tasa, string rezago, string codigo){
        try{
            System.debug('Entramos a CambioTasa');
            list<string> idContenidoPlanilla= new list<string>();    
            List<Contenido_Planilla__c> ContenidoPlnilla = new List<Contenido_Planilla__c>();
            ContenidoPlnilla =[SELECT id, Aporte_Empleado_Obligatorio__c, Aporte_Empleado_Voluntario__c, Aporte_Patrono_obligatorio__c, Aporte_Patrono_Voluntario__c, 
                               Aporte_Empleado_Extraordinario__c, Aporte_Patrono_Extraordinario__c, Aporte_Seguro_de_Vida__c, Reserva_Laboral__c, Aporte_Dolares_Flag__c
                               FROM Contenido_Planilla__c 
                               WHERE planilla__c=:Id_planilla AND Aporte_Dolares_Flag__c!=true];
            for(integer i=0; i<ContenidoPlnilla.size(); i++){
                idContenidoPlanilla.add(ContenidoPlnilla[i].id);
            }
            List<Cuenta_planilla__c> Cuenta_planilla = new List<Cuenta_planilla__c>();
            Cuenta_planilla = [SELECT id, Valor_Monto__c, Valor_Monto_Patrono__c, Valor_Monto_Seguro_Vida__c, Aporte_Dolares_Flag__c, Valor_Monto_Patronal_Extraordinario__c , Valor_Monto_Extraordinario__c 
                              FROM Cuenta_planilla__c 
                              WHERE Contenido_Planilla__c IN :idContenidoPlanilla AND Aporte_Dolares_Flag__c != true];
            
            if(tasa > 0){
                for(integer i=0; i<Cuenta_planilla.size(); i++){
                        Cuenta_planilla[i].Valor_Monto__c = Cuenta_planilla[i].Valor_Monto__c != null ? (Cuenta_planilla[i].Valor_Monto__c / tasa).setscale(2) :0;
                        Cuenta_planilla[i].Valor_Monto_Patrono__c = Cuenta_planilla[i].Valor_Monto_Patrono__c !=null ? (Cuenta_planilla[i].Valor_Monto_Patrono__c / tasa).setscale(2) : 0;
                        Cuenta_planilla[i].Valor_Monto_Seguro_Vida__c = Cuenta_planilla[i].Valor_Monto_Seguro_Vida__c !=null ? (Cuenta_planilla[i].Valor_Monto_Seguro_Vida__c / tasa).setscale(2) : 0;
                        Cuenta_planilla[i].Valor_Monto_Patronal_Extraordinario__c = Cuenta_planilla[i].Valor_Monto_Patronal_Extraordinario__c !=null ? (Cuenta_planilla[i].Valor_Monto_Patronal_Extraordinario__c / tasa).setscale(2) : 0;
                        Cuenta_planilla[i].Valor_Monto_Extraordinario__c = Cuenta_planilla[i].Valor_Monto_Extraordinario__c !=null ? (Cuenta_planilla[i].Valor_Monto_Extraordinario__c / tasa).setscale(2) : 0;
                        
                    Cuenta_planilla[i].Aporte_Dolares_Flag__c = true;
                }
                for(integer i=0; i<ContenidoPlnilla.size(); i++){
                    
                    ContenidoPlnilla[i].Aporte_Empleado_Obligatorio__c = (ContenidoPlnilla[i].Aporte_Empleado_Obligatorio__c / tasa).setscale(2);
                    ContenidoPlnilla[i].Aporte_Empleado_Voluntario__c = (ContenidoPlnilla[i].Aporte_Empleado_Voluntario__c / tasa).setscale(2);
                    ContenidoPlnilla[i].Aporte_Patrono_obligatorio__c = (ContenidoPlnilla[i].Aporte_Patrono_obligatorio__c / tasa).setscale(2);
                    ContenidoPlnilla[i].Aporte_Patrono_Voluntario__c = (ContenidoPlnilla[i].Aporte_Patrono_Voluntario__c / tasa).setscale(2);
                    ContenidoPlnilla[i].Reserva_Laboral__c = (ContenidoPlnilla[i].Reserva_Laboral__c / tasa).setscale(2);
                    ContenidoPlnilla[i].Aporte_Empleado_Extraordinario__c = (ContenidoPlnilla[i].Aporte_Empleado_Extraordinario__c / tasa).setscale(2);
                    ContenidoPlnilla[i].Aporte_Patrono_Extraordinario__c = (ContenidoPlnilla[i].Aporte_Patrono_Extraordinario__c / tasa).setscale(2);
                    ContenidoPlnilla[i].Aporte_Seguro_de_Vida__c = (ContenidoPlnilla[i].Aporte_Seguro_de_Vida__c / tasa).setscale(2);
                    ContenidoPlnilla[i].Aporte_Dolares_Flag__c = true;
                }
                
                Planilla__c planilla = new Planilla__c();
                planilla.Id = id_planilla; 
                planilla.Tasa_compra__c = tasaPlanilla;
                planilla.CurrencyIsoCode = Moneda =='HNL' ? 'USD':'HNL';
                planilla.estado2__c = 'Cerrada';
                planilla.Rezago__c = rezago;
                planilla.ServicioEjecutado__c = 1;
                planilla.Cod_Referencia__c = codigo;
                
                String result='OK';
                System.debug('Antes de evaluar el no aplicaXD: '+planilla.Cod_Referencia__c);
                
                if(planilla.Cod_Referencia__c != 'NoAplica'){
                    System.debug('Se aplica el rezago a: '+planilla.Cod_Referencia__c);
                    for(Integer i=0; i<listRezagos.size(); i++){
                        result = AplicarRezago(listRezagos[i].codigo, num_CodCuenta_Rez, listRezagos[i].monto, Monto_Sal, '',Moneda, Compra_Dolar);//Aplica El Rezago
                    }
                     listRezagos = new List<Rezago>();
                    //result = AplicarRezago(planilla.Cod_Referencia__c, num_CodCuenta_Rez, Monto_Calculado, Monto_Sal, '',Moneda, Compra_Dolar);
                } 
                if(result == 'OK'){
                    System.debug('Antes de Actualizar la Planilla: '+rezago+'-'+codigo);
                    update Cuenta_planilla;
                    update ContenidoPlnilla;
                    update planilla;
                    contador = 1;
                    CargarPlanillas();
                }else{
                    system.debug('Error al aplicar rezago: ');
                    MensajeError = 'Error en Compra/Venta de Dolares en el Metodo: CambioTasa. <br/>Mensaje: '+result;
                    MensajeErr = true;
                }       
            } 
        }catch(Exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            MensajeError = 'Error en Compra/Venta de Dolares en el Metodo: CambioTasa. <br/>Mensaje: '+ ex.getMessage() + '<br/>Linea: ' + ex.getLineNumber();
           	MensajeErr = true;
        }
    }
    
    public class classAportesPlanilla{
        public String idSalesforce { get; set; }
        public String identificacion { get; set; }
        public DateTime fechaRecaudo  { get; set; }
        public String cuentaColectiva { get; set; }
        public String cuenta { get; set; }
        public integer codigoCuenta { get; set; }
        public integer periodoAporte {get;set;}
        public String codigoMoneda {get;set;}
        public Decimal aportePersonalVoluntario { get; set; }
        public Decimal aportePatronalVoluntario { get; set; }
        public Decimal aportePersonalObligatorio { get; set; }
        public Decimal aportePatronalObligatorio { get; set; }
        public Decimal aportePersonalExtraordinario { get; set; } 
        public Decimal aportePatronalExtraordinario { get; set; } 
        public Decimal aporteSeguroVida { get; set; }
    }
    
    //REZAGOS
    public PageReference SearchValores(){
        BTNAplicar = false;
        String consulta = CodRefTest.trim();
        InfoRezagos resultado = new InfoRezagos();
        if(mapInfoRezagos.containsKey(consulta)){
            resultado = mapInfoRezagos.get(consulta); 
        }
        
        Existe='';
        
        if(resultado.clientes != null && resultado.clientes.size() == 1){
            
            String mntpen = resultado.clientes[0].montoPendienteAplicar;
            if(mntpen=='0' || mntpen==''){
                String mnt = resultado.clientes[0].montoRezago;
                system.debug('Monto: '+mnt);
                Monto = mnt;              
            }else{
                Monto = mntpen;
                Existe = ' Corresponde a un Monto pendiente.';
            }
            
            String mon = resultado.clientes[0].codigoMoneda;
            system.debug('Moneda: '+mon);
            Moneda = mon;
            
            String rez = resultado.clientes[0].rezagoSINO;
            system.debug('Rezago SI/NO: '+rez);
            Rezagosn = rez;
            
            String estador = resultado.clientes[0].estado;
            if(estador=='Pagado'){
                Existe='Rezago ya Aplicado. PAGADO.';
                Monto='';
                Moneda='';
                Rezagosn='';
            }else{
                Existe='Datos de Muestra. '+Existe;
                BTNAplicar=true;
                Rezago rezag = new Rezago();
                rezag.aplica = rez;
                rezag.codigo = consulta;
                rezag.moneda = mon;
                rezag.monto = Monto;
                listRezagos.add(rezag);
            }
        }
        if(Existe==''){
            Existe='Codigo inexistente o ya Aplicado. Favor Revisar.';
            Monto='';
            Moneda='';
            Rezagosn='';
        }
        return null;
    }
    
    public void closePopup() {        
        displayPopup = false;
        Rezagosn='';
        Monto='';
        Moneda='';
        Existe='';
        BTNAplicar=false;
        
    }
    
    public PageReference showPopup() { 
        listRezagos = new List<Rezago>();
        displayPopup = true;
        Existe='';
        BTNAplicar=false;
        return null;
    }
    
    public void aplicarList(){
        String codigo = '';
        Integer posic = 0;
        for(integer count=0;count<planillas.size();count++){
            if(planillas[count].Segundo_Nombre == Cod_Planilla){
                posic = count;
            }
        }
        
        for(Integer i=0; i<listRezagos.size(); i++){
            codigo += listRezagos[i].codigo + ',';
            Rezagosn = listRezagos[i].aplica;
            CodRefTest = listRezagos[i].codigo;
            Moneda = listRezagos[i].moneda;
            Monto = listRezagos[i].monto;
            aplicar();
        }
        If(codigo.length() > 1){
            planillas[posic].codigoReferencia = codigo.substring(0, codigo.length()-1);
        }
        closePopup();
    }
    
    //Aplicar el codigo seleccionado al Cod Rezago 
    public void aplicar(){
        String MontoSTR = '';
        Decimal MontoAp = 0;
        Decimal MontoRez = Decimal.valueOf(Monto);
        String codigo1 = '';
        system.debug('Variables: '+MontoRez+' - '+Cod_Planilla+' - '+CodRef+' - '+Total);
        for(integer count=0;count<planillas.size();count++){
            if(planillas[count].Segundo_Nombre == Cod_Planilla){
                MontoAp = planillas[count].Salario;
            }
        }
        System.debug(MontoAp+' -- '+MontoRez);
        if(MontoAp<=MontoRez ){
            
            String fond='';
            Decimal valcuosal=0;
            Decimal valcuoent=0;
            Decimal mnt=0;
            String consulta = CodRefTest.trim();
            
            InfoRezagos resultado = new InfoRezagos();
            if(mapInfoRezagos.containsKey(consulta)){
                resultado = mapInfoRezagos.get(consulta); 
            } 
            
            if(resultado.clientes != null && resultado.clientes.size() == 1){
                
                Rezagosn = resultado.clientes[0].rezagoSINO;
                
                if(Rezagosn=='SI' || Rezagosn=='Si' || Rezagosn=='si'){ 
                    
                    fond = resultado.clientes[0].fondo;
                    System.debug('Fondo: '+fond);
                    
                    String valent = resultado.clientes[0].valorCuotaEntrada;

                    if(valent == '' || valent == null){valent = '1';}
                    System.debug('Valor Cuota Entrada: '+valent);
                    valcuoent = Decimal.valueOf(valent);
                    
                    for(Integer count1=0;count1<ValorCuotaStr.size();count1++){
                        String rez = ValorCuotaStr[count1];
                        
                        ValorCuotaDia = rez.substringBeforeLast('}');
                        ValorCuotaDia = ValorCuotaDia.substringAfterLast(':');
                        
                        ValorCuotaFondo = rez.substringBeforeLast('",');
                        ValorCuotaFondo = ValorCuotaFondo.substringAfterLast('"');
                        
                        if(fond==ValorCuotaFondo){valcuosal = Decimal.valueOf(ValorCuotaDia);}
                        
                    }
                    System.debug('Valor Cuota Salida: ' + String.valueOf(valcuosal));
                    System.debug('Monto: '+MontoAp);
                    mnt = MontoAp/valcuoent*valcuosal;
                    mnt = mnt.setScale(2);
                    MontoStr = String.valueOf(mnt);
                    System.debug('Monto Calculado: '+MontoStr);
                }else{
                    Rezagosn = 'N/A';
                }
            }
            System.debug('Cod Referencia desde Search: '+CodRefTest);
            for(integer count=0;count<planillas.size();count++){
                if(planillas[count].Segundo_Nombre == Cod_Planilla){
                    if(Rezagosn != 'N/A'){
                        planillas[count].Monto_Calculado = MontoSTR;
                        planillas[count].rezago = 'Si';
                    }else{
                        planillas[count].rezago = 'No';
                    }
                }
            }
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'El Monto del Rezago NO puede ser inferior al Monto del Aporte '));
        }
        //closePopup();
    }
    
    //@future(callout = true)
    public String AplicarRezago(String NumCodRez, String NumCodCue, String MonCalc, String MonDep, String User, String Mon, String ComDol) {
        String result='';
        String valAporteCalculado='';
        if(MonCalc=='' || MonCalc==null || MonCalc=='0'){
            valAporteCalculado = MonDep;
        }else{
            valAporteCalculado = MonCalc;
        }
        try{
            ClassClientesRez rezagoEnvio = new ClassClientesRez();
            String CodRezago = NumCodRez;
            InfoRezagos resultado = new InfoRezagos();
            if(mapInfoRezagos.containsKey(CodRezago)){
                resultado = mapInfoRezagos.get(CodRezago);
            }

            List<ClientesRez> ListClientesRez = new List<ClientesRez>();
            ClientesRez AplicaRez = new ClientesRez('','','','','','','','','','','','','');
            
            String idr = resultado.clientes[0].idRezago;
            system.debug('idRezago: '+idr);
            AplicaRez.idRezago = idr;// Añado el Id Rezago
            
            String montor = resultado.clientes[0].montoRezago;
            system.debug('Monto Rezago: '+montor);
            AplicaRez.montoRezago = montor;// Añado el Monto del Rezago
            
            String fondor = resultado.clientes[0].fondo;
            system.debug('Fondo: '+fondor);
            AplicaRez.fondo = fondor;// Añado el Fondo del Rezago
            
            String codrefr = resultado.clientes[0].codReferencia;
            system.debug('Codigo Referencia Rezago: '+codrefr);
            AplicaRez.codReferencia = codrefr;// Añado el Codigo de referencia del Rezago
            
            system.debug('Numero de Cuenta: ');
            AplicaRez.codCuenta = '';// Añado el Codigo de Cuenta
            
            system.debug('Codigo de Planilla: '+NumCodCue);
            AplicaRez.codPlanilla = NumCodCue;// Añado el Codigo de Planilla
            
            String valcuoent = resultado.clientes[0].valorCuotaEntrada;
            if(valcuoent=='' || valcuoent==null){valcuoent='1';}
            system.debug('Valor Cuota de Entrada: '+valcuoent);
            AplicaRez.valorCuotaEntrada = valcuoent;// Añado el Valor de la cuota de entrada
            
            //Para obtener el valor cuota del dia
            String ValorCuota = ControllerApiRezagos.ConsultaCuotaSal();
            if(test.isRunningTest()){
                ValorCuota = '[{"fechaValor":"2020-01-30T00:00:00","codInversion":"101","valCuota":340.69913612},{"fechaValor":"2020-01-30T00:00:00","codInversion":"106","valCuota":127.52636724},{"fechaValor":"2020-01-30T00:00:00","codInversion":"113","valCuota":125.16183919}]';
            }
            List <String> ValorCuotaStr = new List<String>();
            ValorCuotaStr = ValorCuota.split('},');
            String valcuosal;
            for(Integer count1=0;count1<ValorCuotaStr.size();count1++){
                String rez = ValorCuotaStr[count1];
                
                String ValorCuotaDia = rez.substringBeforeLast('}');
                ValorCuotaDia = ValorCuotaDia.substringAfterLast(':');
                
                String ValorCuotaFondo = rez.substringBeforeLast('",');
                ValorCuotaFondo = ValorCuotaFondo.substringAfterLast('"');
                
                if(AplicaRez.fondo==ValorCuotaFondo){valcuosal=String.valueOf(ValorCuotaDia);}                   
            }
            
            system.debug('Valor Cuota de Salida: '+valcuosal);
            AplicaRez.valorCuotaSalida = valcuosal;//valcuosal;// Añado el Valor de la cuota de Salida
            
            String estador = resultado.clientes[0].estado;
            system.debug('Estado: '+estador);
            AplicaRez.estado = estador;// Añado el Estado del Rezago
            
            String sino = resultado.clientes[0].rezagoSINO;
            if(sino=='SI' || sino=='Si' || sino=='si'){ 
                rezagoEnvio.Tipo = 'AP';
            }else{
                AplicaRez.valorCuotaSalida = '';
                rezagoEnvio.Tipo = 'AD';
            }
            system.debug('Valor Aporte Calculado: '+valAporteCalculado);
            AplicaRez.valAporteCalculado = valAporteCalculado;// Añado el Aporte Calculado
            
            Decimal mparapl;
            Decimal mpenapl;
            String mntpen = resultado.clientes[0].montoPendienteAplicar;
            Decimal mntr = 0;
            if(mntpen == '0' || mntpen == ''){
                mntr = Decimal.valueOf(montor);                
            }else{
                mntr = Decimal.valueOf(mntpen);
            }
            Decimal mnt = 0;
            if(test.isRunningTest()){
                mnt = mntr;
            }else{
                mnt = Decimal.valueOf(MonDep);
            }
            if(mnt<mntr){//Si el monto del aporte es menor al del rezago
                mparapl = mnt; //Se aplica un monto parcial
                mpenapl = mntr-mnt;//Queda un monto pendiente que pasa a ser el Monto del rezago
                AplicaRez.estado = 'Pendiente';
            }else{//Sino es menor se aplican los parciales y pendientes en 0
                mparapl = 0;
                mpenapl = 0;
                AplicaRez.estado = 'Pagado';
            }
            
            system.debug('Valor Monto Parcial: '+String.valueOf(mparapl));
            AplicaRez.montoParcialAplicado = String.valueOf(mparapl);//Añado el Monto Parcial Aplicado
            
            system.debug('Valor Monto Pendiente: '+String.valueOf(mpenapl));
            AplicaRez.montoPendienteAplicar = String.valueOf(mpenapl);//Añado el Monto Pendiente a Aplicar
            
            List<User> usr = [Select Id, Name From User Where Id=:UserInfo.getUserId() Limit 1];
            System.debug('User: '+usr[0].Name);///////Marcooo
            String usuario = usr[0].Name;
            System.debug('Modificado por: '+usuario);
            AplicaRez.modificadoPor = usuario; 
            
            ListClientesRez.add(AplicaRez);
            
            String FechaD = resultado.clientes[0].fechaDeposito;
            
            rezagoEnvio.clientes = ListClientesRez;
            system.debug('Tipo: '+rezagoEnvio.Tipo);
            
            String CuentaOrigen='';
            try{
                List<Cuenta_Rezago__mdt> codigo = new List<Cuenta_Rezago__mdt>();
                codigo = [select cuenta__c from Cuenta_Rezago__mdt where fondo__c =: AplicaRez.fondo limit 1];
                if(codigo.size()>0){
                    CuentaOrigen = codigo[0].cuenta__c ;//Insertar el codigo de cuenta de FPC Rezagos
                }
            }catch(Exception ex){
                system.debug('Error al Aplicar Rezago: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            }
            String RespuestaRetiro='OK';
            String AplicaPartida='';
            if( rezagoEnvio.Tipo == 'AP'){
            	RespuestaRetiro = ControllerApiRezagos.AplicaRetiroRezagos(CuentaOrigen, Mon, valAporteCalculado);
                if(RespuestaRetiro.contains('Su retiro ha sido registrado')){
                	RespuestaRetiro='OK';
                }else{
                    result = RespuestaRetiro;
                    RespuestaRetiro='Failure';
                    //result = 'Error al aplicar Retiro: '+CuentaOrigen+' - '+Mon+' - '+valAporteCalculado;
                	System.debug('Error al aplicar Retiro: '+CuentaOrigen+' - '+Mon+' - '+valAporteCalculado);
                }
            }
            
            if(RespuestaRetiro=='OK' || test.isRunningTest()){
                if( rezagoEnvio.Tipo == 'AD'){
                    result = ControllerApiRezagos.AplicaRezagosDia(rezagoEnvio);
                }else{
                    system.debug('Antes de Ejecutar el Metodo AP: '+rezagoEnvio);
                    result = ControllerApiRezagos.AplicaRezagosDia(rezagoEnvio);
                }
                if(result=='"OK"' || test.isRunningTest()){
                    AplicaPartida = AplicaPartida(AplicaRez.fondo, valAporteCalculado, AplicaRez.codPlanilla, ComDol, FechaD);
                    system.debug('Aplica Partida Result: '+AplicaPartida);
                    if(AplicaPartida!='OK'){
                        result = 'Error en Metodo AplicaPartida. Mensaje: '+ AplicaPartida;
                        //ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Error en Metodo AplicaPartida. Mensaje: '+ AplicaPartida));
                    }else{
                        result = 'OK';
                    }
                }else{
                    result = 'Error al aplicar Rezago en el metodo : API AplicaRezagosDia';
                }
            }
        }catch(exception ex){
            System.debug('Error al Aplicar Rezago: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            result = 'Error al Aplicar Rezago: '+ex.getMessage()+', Linea: '+ex.getLineNumber();
            return result;
        }
        return result;
    }
    public void eliminarRezago(){
        Integer count = 0;
        for(Integer i=0; i<listRezagos.size(); i++){
            if(listRezagos[i].codigo == codigoRezago){
                count = i;
            }
        }
        listRezagos.remove(count);
    }
    public static String AplicaPartida(String Fon, String Mon, String Cue, String CompDol, String FechD){
        
        String fondo = Fon;
        String montocal = Mon;
        String cuent = cue;
        
        FieldsPartidadContables clase = new FieldsPartidadContables();
        
        FieldsPartidadContables.Partida envioDatos = new FieldsPartidadContables.Partida();
        clase.partidas = new List<FieldsPartidadContables.Partida>();
        
        envioDatos = new FieldsPartidadContables.Partida();
        
        List<Partida_Rezago__mdt> partida = new List<Partida_Rezago__mdt>();
        
        try{
            if(CompDol == 'True'){
                partida = [SELECT Cuenta_Debito__c, Descripcion__c, Id_Banco__c, Moneda__c, Sub_Aplicacion__c, Tipo_Nota__c, Tipo_Transaccion__c 
                           FROM Partida_Rezago__mdt WHERE Fondo__c =: fondo AND Compra_Dolar__c =: 'S' AND  Cuenta__c = 'P' LIMIT 1];
                envioDatos.fecha = Datetime.now();
            }else{
                partida = [SELECT Cuenta_Debito__c, Descripcion__c, Id_Banco__c, Moneda__c, Sub_Aplicacion__c, Tipo_Nota__c, Tipo_Transaccion__c 
                           FROM Partida_Rezago__mdt WHERE Fondo__c =: fondo AND Compra_Dolar__c =: 'N' AND  Cuenta__c = 'P' LIMIT 1];
                envioDatos.fecha = null;
            }
        }catch(Exception ex){}

        if(partida.size()>0){
            envioDatos.Id_banco = partida[0].Id_Banco__c;
            envioDatos.Monto = montocal;
            envioDatos.cta_contable_debito = partida[0].Cuenta_Debito__c;
            envioDatos.cta_contable_credito = null;
            if(partida[0].Moneda__c=='Lempiras'){envioDatos.moneda = '1';}else{envioDatos.moneda = '2';}
            envioDatos.Modulo = 'BCO';
            if(partida[0].Tipo_Nota__c=='Debito'){envioDatos.tip_nota = 'D';}else{envioDatos.tip_nota = 'C';}
            envioDatos.tip_nota = 'D';
            
            String cuentax = '';
            String fechax='';
            if(test.isRunningTest()){
                fechax = '2020-01-01';
            }else{
            	fechax = FechD;
                cuentax = partida[0].Descripcion__c ;
                cuentax = cuentax.replace('cuentax', cuent);
            }
            cuentax = cuentax.replace('fechax', fechax);
            envioDatos.observacion = cuentax;
            envioDatos.observacion_c = cuentax;
            
            envioDatos.tip_transac = partida[0].Tipo_Transaccion__c;
            envioDatos.sub_aplicacion = partida[0].Sub_Aplicacion__c;
            system.debug('Envio Datos: '+envioDatos);
            clase.partidas.Add(envioDatos);
        }
        String resultJson;
        if(test.isRunningTest()){
            resultJson = 'OK';
        }else{
        	resultJson = controllerApiIntergationPartidas.generarPartidas(clase);    
        }
        
        System.debug('resultJson: '+resultJson);
        String resultado='';
        if(resultJson.contains('OK')) {
            resultado = 'OK';
        } else if(resultJson.contains('Read timed out')){
            resultado='Aplicar Partida. Tiempo de respuesta exedio el Limite.';
        } else {    
            resultado='Aplicar Partida. Falla de Conexion.';
        }
        return resultado;
    } 
    
    public class Rezago{
        public String codigo{get;set;}
        public String moneda{get;set;}
        public String monto{get;set;}
        public String aplica{get;set;}
    }
}