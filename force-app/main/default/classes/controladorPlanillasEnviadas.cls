public class controladorPlanillasEnviadas {
    
    // Rezagos
    public String CodRef{get;set;}
    public String CodRefTest{get;set;}
    public String Existe{get;set;}
    public String Rezagosn{get;set;}
    public String Monto{get;set;}
    public String Moneda{get;set;}
    public boolean displayPopup {get; set;}
    List <String> ValorCuotaStr {get;set;}
    public String ValorCuotaDia {get;set;}
    public String ValorCuotaFondo {get;set;}
    Public String Cod_Planilla {get;set;}
    Public String Total {get;set;}
    public string Num_CodReferencia_Rez{get;set;}
    //public List<ClientesRez> ListClientesRez {get;set;}    
    //public ClientesRez AplicaRez{get;set;}
    public string Rez_SI_NO{get;set;}//Setear a 0
    public string Monto_Calculado{get;set;}//Setear a 0
    public string Num_CodCuenta_Rez{get;set;}//Setear a 0
    public string Monto_Sal{get;set;}//Setear a 0
    public string Compra_Dolar{get;set;}//Setear a 0
    public String Correcto {get;set;}
    Public Boolean BTNAplicar {get;set;}
    Public Decimal ValCuoEntrada{get;set;}
    Public Decimal ValCuoSalida{get;set;}
    // 
    Public List<Planilla> Planillas{get;set;}
    Public string Id_Planilla{get;set;}
    public List<SelectOption> options {get;set;}
    private integer contador;
    Date fecha;
    string Bandera;
    Public boolean mostrarPan{get;set;}
    Public string Id_PANTALLA{get;set;}
    public boolean popTasa{get;set;}
    
    public controladorPlanillasEnviadas() {
        options=new List<SelectOption>();
        options.add(new SelectOption('1','Pendientes'));
        options.add(new SelectOption('2','Aprobadas'));
        CargarPlanillas();
        contador=0;
        //Para obtener el valor cuota del dia al iniciar el programa
        String ValorCuota = ControllerApiRezagos.ConsultaCuotaSal();
        ValorCuotaStr = new List<String>();
        ValorCuotaStr = ValorCuota.split('},');
    }
    
    public void cerrar(){
        popTasa = false;
    }
    
    public void Controladorbg(){
        if(id_pantalla=='1'){
            CargarPlanillas(); 
        }else{
            CargarPlanillasAprobadas();  
        }
    }
    
    public  list<ClasePLanillas> FRT{get;set;}
    
    public class ClasePLanillas{
        public string NE{get;set;}
        public string Np{get;set;}
        public string RS{get;set;}
        public string M{get;set;}
        public daTE F{get;set;}
        public DECIMAL T{get;set;}
        
        PUBLIC ClasePLanillas(STRING NE, STRING NP, STRING RS, DATE F, DECIMAL T, string moneda){
            THIS.NE=NE;
            THIS.NP=NP;
            THIS.RS=RS;
            THIS.F=F;
            THIS.T=T;
            this.m=moneda;
        }
    }
    
    Public void CargarPlanillasAprobadas() {
        try{
            mostrarPan=false;
            FRT= new list<ClasePLanillas>();
            list<Planilla__C> TodasPlanillas=new list<Planilla__C>();
            planillas = new list<Planilla>();
            TodasPlanillas=[select empresa2__r.name,respuesta_desde_sysde_aportes__C, fecha__C, name, total__C,CurrencyIsoCode  from planilla__c where estado2__c='Cerrada' order by Fecha__c desc limit 200];
            for(integer i=0; i<TodasPlanillas.size(); i++){
                FRT.add(new ClasePLanillas(TodasPlanillas[i].empresa2__r.name, TodasPlanillas[i].name, TodasPlanillas[i].respuesta_desde_sysde_aportes__C,TodasPlanillas[i].FECHA__c,TodasPlanillas[i].TOTAL__c, TodasPlanillas[i].CurrencyIsoCode));
            }
            
        }Catch(Exception ex){
            system.debug('Error'+ex.getLineNumber());
        }
    } 
    
    Public void CargarPlanillas() {
        try{
            System.debug('Se ejecuta el Cargar Planillas');
            mostrarPan=true;
            list<Planilla__C> TodasPlanillas=new list<Planilla__C>();
            planillas = new list<Planilla>();
            TodasPlanillas=[select id,empresa2__r.name, tasa_compra__C, tipo_planilla__c,name, Estado2__c,
                            TA_Empleado_Obligatorio__c, TA_Patrono_obligatorio__c, TA_Empleado_Voluntario__c, 
                            TA_Patrono_Voluntario__c, Total_Reserva_Laboral2__c, TA_Empleado_Extraordinario__c,
                            TA_Patrono_Extraordinario__c, TA_Seguro_de_Vida__c, fecha__C, CurrencyIsoCode 
                            from planilla__c where estado2__c='Pendiente aprobación Ficohsa' order by name asc];
            
            for(integer i=0; i<TodasPlanillas.size(); i++){
                decimal TotalPilares = TodasPlanillas[i].TA_Empleado_Obligatorio__c + TodasPlanillas[i].TA_Patrono_obligatorio__c + 
                    TodasPlanillas[i].TA_Empleado_Voluntario__c + TodasPlanillas[i].TA_Patrono_Voluntario__c + 
                    TodasPlanillas[i].Total_Reserva_Laboral2__c + TodasPlanillas[i].TA_Empleado_Extraordinario__c + 
                    TodasPlanillas[i].TA_Patrono_Extraordinario__c + TodasPlanillas[i].TA_Seguro_de_Vida__c;
                
                if(TodasPlanillas[i].tasa_compra__C==0){
                    planillas.add(new Planilla(TodasPlanillas[i].id, TodasPlanillas[i].empresa2__r.name, date.today(),TodasPlanillas[i].name,
                                               TotalPilares,'true','false',TodasPlanillas[i].CurrencyIsoCode , null, 'Sin Informacion',''));
                }else{
                    planillas.add(new Planilla(TodasPlanillas[i].id, TodasPlanillas[i].empresa2__r.name, TodasPlanillas[i].fecha__C,
                                               TodasPlanillas[i].name,TotalPilares,'false','true',TodasPlanillas[i].CurrencyIsoCode, null, 'Sin Informacion',''));
                }
            }
            
            if(contador>0){
                System.debug('Entramos al Contador>0');
                contador=0;
                Bandera='Correctamente';
                planilla__c planilla = new planilla__C();
                planilla=[select respuesta_desde_sysde_aportes__C from planilla__C where id=:Id_Planilla];
                string estadoplanilla=planilla.respuesta_desde_sysde_aportes__C;
                if(estadoplanilla==null || !estadoplanilla.contains('200')) {
                    OrdenarPlanilla(); 
                }
            }
        }Catch(Exception ex){
            system.debug('Error en llamar metodo'+ex.getLineNumber()+ex.getMessage());
        }
    }
    
    public  void OrdenarPlanilla(){
        try{
            System.debug('Entramos a OrdenarPlanilla');
            Integer FlagCount = 0; //Esta variable sirve para contar si se ejecutaron ambos procesos de los aportes.
            list<string> idcontenido = new list<string>();
            string empresa;
            string rezago;
            string codigo;
            for(Contenido_planilla__C item:[select id, planilla__r.cod_referencia__C,planilla__r.rezago__C, planilla__r.empresa2__C,planilla__r.respuesta_desde_sysde_aportes__C 
                                            from contenido_planilla__C 
                                            where planilla__C=:id_planilla]){
                                                
                                                idcontenido.add(item.id);
                                                empresa=item.planilla__r.empresa2__C;
                                                rezago=item.planilla__r.rezago__C;
                                                codigo=item.planilla__r.cod_referencia__C;
                                                System.debug('rezago: '+rezago+' - codigo: '+codigo+' - empresa: '+empresa);
                                            }
            
            Autonumerico_cuentas_Syste__c Numerosformularios=[select id, Id_Formulario_Sysde__c from Autonumerico_cuentas_Syste__c limit 1];
            decimal abc = Numerosformularios.Id_Formulario_Sysde__c;
            
            System.debug('Autonumerico Planillas: '+String.valueOf(abc));
            
            list<cuenta_planilla__C> cuentas = New list<cuenta_planilla__C>();
            cuentas =[select Codigo_cuenta__c, valor_monto__C, Valor_Monto_Patrono__c, Valor_Monto_Extraordinario__c, Valor_Monto_Patronal_Extraordinario__c, 
                      Valor_Monto_Seguro_Vida__c, contenido_planilla__r.empleado2__r.identificacion__C 
                      from cuenta_planilla__C
                      where contenido_planilla__C in :(idcontenido)];
            idcontenido.clear();
            
            for(cuenta_planilla__C item : cuentas){
                idcontenido.add(item.Codigo_cuenta__c); 
            }
            list<cuentas__C> cuentas_salesforce = new list<cuentas__C>();
            
            cuentas_salesforce=[select Producto__r.CurrencyIsoCode, cliente__r.identificacion__C, Cuenta_colectiva2__r.codigo__C, Codigo__c, Aporte_Dolares_Flag__c 
                                from cuentas__C 
                                where codigo__C in :(idcontenido)];
            
            map<string, list<cuentas__C>> mapCuentas= new map<string, list<cuentas__C>>();
            
            for(integer i=0; i<cuentas_salesforce.size(); i++){
                list<cuentas__C> listCuentas = new list<cuentas__C>();
                
                if(mapCuentas.containsKey(cuentas_salesforce[i].cliente__r.identificacion__C)){
                    
                    listCuentas = mapCuentas.get(cuentas_salesforce[i].cliente__r.identificacion__C);
                    listCuentas.add(cuentas_salesforce[i]);
                    mapCuentas.remove(cuentas_salesforce[i].cliente__r.identificacion__c);
                    mapCuentas.put(cuentas_salesforce[i].cliente__r.identificacion__C,listCuentas);
                    
                }else{
                    listCuentas.add(cuentas_salesforce[i]);
                    mapCuentas.remove(cuentas_salesforce[i].cliente__r.identificacion__c);
                    mapCuentas.put(cuentas_salesforce[i].cliente__r.identificacion__C,listCuentas);
                }
            }
            list<classAportesPlanilla> claseenvio = new list<classAportesPlanilla>();
            classAportesPlanilla nueva;
            string todosEmpleados='';
            
            for(integer i=0; i<cuentas.size(); i++){
                cuentas_salesforce =new list<cuentas__C>();
                if(mapCuentas.containsKey(cuentas[i].contenido_planilla__r.empleado2__r.identificacion__C)){
                    cuentas_salesforce=mapCuentas.get(cuentas[i].contenido_planilla__r.empleado2__r.identificacion__C);
                }
                for(integer jj=0; jj<cuentas_salesforce.size(); jj++){
                    if(cuentas_salesforce[jj].codigo__C==cuentas[i].codigo_cuenta__C && cuentas_salesforce[jj].Aporte_Dolares_Flag__c != true){
                        nueva = new classAportesPlanilla();
                        nueva.idSalesforce ='SF'+string.valueOf((ABC++));
                        nueva.identificacion=cuentas_salesforce[jj].cliente__r.identificacion__C;
                        nueva.cuentaColectiva =cuentas_salesforce[jj].Cuenta_colectiva2__r.codigo__C;
                        nueva.cuenta=cuentas[i].Codigo_cuenta__c;
                        nueva.codigoCuenta=integer.valueOf(cuentas[i].Codigo_cuenta__c);
                        nueva.codigoMoneda = cuentas_salesforce[jj].Producto__r.CurrencyIsoCode=='HNL' ? '1':'2';
                        //
                        if(rezago=='S'){
                            System.debug('01 Es un rezago SI, calculamos los saldos con los valores de cuota: '+String.valueOf(ValCuoEntrada)+'-'+String.valueOf(ValCuoSalida));
                            nueva.aportePersonalVoluntario=cuentas[i].valor_monto__C/ValCuoEntrada*ValCuoSalida;
                            nueva.aportePatronalVoluntario=cuentas[i].valor_monto_patrono__C/ValCuoEntrada*ValCuoSalida;
                            nueva.aportePersonalExtraordinario=cuentas[i].Valor_Monto_Extraordinario__c/ValCuoEntrada*ValCuoSalida;
                            nueva.aportePatronalExtraordinario=cuentas[i].Valor_Monto_Patronal_Extraordinario__c/ValCuoEntrada*ValCuoSalida;
							System.debug('Aportes registrados APEV-APAV-APEX-APAX: '+nueva.aportePersonalVoluntario+'-'+nueva.aportePatronalVoluntario+'-'+
                                         nueva.aportePersonalExtraordinario+'-'+nueva.aportePatronalExtraordinario);
                        }else{
                            System.debug('01 Es un rezago NO: '+i);
                            nueva.aportePersonalVoluntario=cuentas[i].valor_monto__C;
                            nueva.aportePatronalVoluntario=cuentas[i].valor_monto_patrono__C;
                            nueva.aportePersonalExtraordinario=cuentas[i].Valor_Monto_Extraordinario__c;
                            nueva.aportePatronalExtraordinario=cuentas[i].Valor_Monto_Patronal_Extraordinario__c;
                            System.debug('Aportes registrados APEV-APAV-APEX-APAX: '+nueva.aportePersonalVoluntario+'-'+nueva.aportePatronalVoluntario+'-'+
                                         nueva.aportePersonalExtraordinario+'-'+nueva.aportePatronalExtraordinario);
                        }
                        //
                        nueva.aporteSeguroVida=cuentas[i].Valor_Monto_Seguro_Vida__c;
                        //
                        nueva.aportePersonalObligatorio=0;
                        nueva.aportePatronalObligatorio=0;

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
                //update cuentas_salesforce;
            }
            idcontenido.clear();
            map<string, string> banderamapa = new map<string, string>();
            map<string, string> banderamapa2 = new map<string, string>();
            for(Cuentas_colectivas__C item: [select codigo__C, Tipo_cuenta__C 
                                             from Cuentas_colectivas__C 
                                             where empresa__c=:empresa and tipo_cuenta__C !='Voluntarias']){
                                                 
                                                 idcontenido.add(item.codigo__C);
                                                 banderamapa.put(item.codigo__C, item.tipo_cuenta__C);
                                             }
            cuentas_salesforce.clear();
            
            cuentas_salesforce=[select Producto__r.CurrencyIsoCode, cliente__r.identificacion__C,
                                Cuenta_colectiva2__r.codigo__C, Codigo__c 
                                from cuentas__C
                                where Cuenta_colectiva2__r.codigo__C in :(idcontenido)];
            mapCuentas.clear();
            for(integer i=0; i<cuentas_salesforce.size(); i++){
                list<cuentas__C> litsCuentas = new list<cuentas__C>();
                if(mapCuentas.containsKey(cuentas_salesforce[i].cliente__r.identificacion__C)) {
                    litsCuentas = mapCuentas.get(cuentas_salesforce[i].cliente__r.identificacion__C);
                    litsCuentas.add(cuentas_salesforce[i]);
                    mapCuentas.remove(cuentas_salesforce[i].cliente__r.identificacion__c);
                    mapCuentas.put(cuentas_salesforce[i].cliente__r.identificacion__C,litsCuentas);
                    
                }else{
                    litsCuentas.add(cuentas_salesforce[i]);
                    mapCuentas.remove(cuentas_salesforce[i].cliente__r.identificacion__c);
                    mapCuentas.put(cuentas_salesforce[i].cliente__r.identificacion__C,litsCuentas);
                }
            }
            list<contenido_planilla__C> contenido= new list<contenido_planilla__C>();
            contenido.addAll([select empleado2__r.Identificacion__C, Aporte_Empleado_Obligatorio__c, Aporte_Patrono_obligatorio__c,
                              Reserva_Laboral__c from contenido_planilla__C where Aporte_Empleado_Obligatorio__c>0 and planilla__C=:id_planilla
                             ]);
            list<string> vf= new List<string>();
            for(integer i=0; i<contenido.size(); i++){
                vf.add(contenido[i].empleado2__r.Identificacion__C);
            }
            contenido.addAll([select empleado2__r.Identificacion__C, Aporte_Empleado_Obligatorio__c, Aporte_Patrono_obligatorio__c,
                              Reserva_Laboral__c from contenido_planilla__C where Aporte_Patrono_obligatorio__c>0 and planilla__C=:id_planilla
                              and empleado2__r.Identificacion__C not in :(vf)]);
            for(integer i=0; i<contenido.size(); i++){
                vf.add(contenido[i].empleado2__r.Identificacion__C);
            }
            contenido.addAll([select empleado2__r.Identificacion__C, Aporte_Empleado_Obligatorio__c, Aporte_Patrono_obligatorio__c,
                              Reserva_Laboral__c from contenido_planilla__C where reserva_laboral__c>0 and planilla__C=:id_planilla
                              and empleado2__r.Identificacion__C not in :(vf)]);
            for(integer i=0; i<contenido.size(); i++){
                cuentas_salesforce =new list<cuentas__C>();
                if(mapCuentas.containsKey(contenido[i].empleado2__r.identificacion__C)){
                    cuentas_salesforce=mapCuentas.get(contenido[i].empleado2__r.identificacion__C);
                }
                for(integer j=0; j<cuentas_salesforce.size(); j++){
                    if(contenido[i].empleado2__r.Identificacion__C==cuentas_salesforce[j].cliente__r.Identificacion__C && cuentas_salesforce[j].Aporte_Dolares_Flag__c != true){
                        if(banderamapa.get(cuentas_salesforce[j].Cuenta_colectiva2__r.codigo__C)== 'Pilar Complementario'){
                            nueva = new classAportesPlanilla();
                            nueva.idSalesforce ='SF'+string.valueOf((ABC++));
                            nueva.identificacion=contenido[i].empleado2__r.Identificacion__C;
                            nueva.cuentaColectiva =cuentas_salesforce[j].Cuenta_colectiva2__r.codigo__C;
                            nueva.cuenta=cuentas_salesforce[j].Codigo__c;
                            nueva.codigoCuenta=integer.valueOf(cuentas_salesforce[j].Codigo__c);
                            nueva.codigoMoneda = cuentas_salesforce[j].Producto__r.CurrencyIsoCode=='HNL' ? '1' :'2';
                            //
                            nueva.aportePersonalVoluntario=0;
                            nueva.aportePatronalVoluntario=0;
                            //
                            if(rezago=='S'){
                                System.debug('02 Es un rezago SI, calculamos los saldos con los valores de cuota: '+String.valueOf(ValCuoEntrada)+'-'+String.valueOf(ValCuoSalida));
                                nueva.aportePersonalObligatorio=contenido[i].Aporte_Empleado_Obligatorio__c/ValCuoEntrada*ValCuoSalida;
                                nueva.aportePatronalObligatorio=contenido[i].Aporte_Patrono_Obligatorio__c/ValCuoEntrada*ValCuoSalida;
                                System.debug('Aportes registrados APEO-APAO: '+nueva.aportePersonalObligatorio+'-'+nueva.aportePatronalObligatorio);
                            }else{
                                System.debug('02 Es un rezago NO: '+i);
                                nueva.aportePersonalObligatorio=contenido[i].Aporte_Empleado_Obligatorio__c;
                                nueva.aportePatronalObligatorio=contenido[i].Aporte_Patrono_Obligatorio__c;
                                System.debug('Aportes registrados APEO-APAO: '+nueva.aportePersonalObligatorio+'-'+nueva.aportePatronalObligatorio);
                            }
                            //
                            nueva.aportePersonalExtraordinario=0;
                            nueva.aportePatronalExtraordinario=0;
                            nueva.aporteSeguroVida=0;
                            //
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
                            nueva.idSalesforce ='SF'+string.valueOf((ABC++));
                            nueva.identificacion=contenido[i].empleado2__r.Identificacion__C;
                            nueva.cuentaColectiva =cuentas_salesforce[j].Cuenta_colectiva2__r.codigo__C;
                            nueva.cuenta=cuentas_salesforce[j].Codigo__c;
                            nueva.codigoCuenta=integer.valueOf(cuentas_salesforce[j].Codigo__c);
                            nueva.codigoMoneda = cuentas_salesforce[j].Producto__r.CurrencyIsoCode=='HNL' ? '1':'2';
                            nueva.aportePersonalVoluntario = 0;
                            nueva.aportePatronalVoluntario = 0;
                            nueva.aportePersonalObligatorio = 0;
                            nueva.aportePersonalExtraordinario = 0;
                            nueva.aportePatronalExtraordinario =0 ;
                            nueva.aporteSeguroVida = 0;
                            nueva.aportePatronalObligatorio=contenido[i].Reserva_Laboral__c;
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
                        
                        cuentas_salesforce[j].Aporte_Dolares_Flag__c = true;
                    }
                }
                //update cuentas_salesforce;
            }   

            Numerosformularios.Id_Formulario_Sysde__c = abc;
            update Numerosformularios;
            STRING MES=[SELECT MES_APORTE__c FROM PLANILLA__c WHERE ID=:Id_Planilla].MES_aPORTE__c;
            system.debug('IDPLANILLA: ' + Id_Planilla + 'MES: '+ MES + 'todos: '+ todosEmpleados);
            string gt =string.valueOf(fecha.year());
            if(INTEGER.valueOf(MES)>fecha.month()){
                gt =string.valueOf((fecha.year()-1));  
            }
            if(INTEGER.valueOf(MES)<10){
                gt +='0'+MES;
            }else{
                gt +=MES; 
            }
            gt +='00';
            //string estadoPlanilla='fr'; 
            planilla__c planillaTemp=new planilla__C();
            planillaTemp=[select respuesta_desde_sysde_aportes__C from planilla__C where id=:Id_Planilla];
            string estadoplanilla=planillaTemp.respuesta_desde_sysde_aportes__C;
            //system.debug('Si lo llama P: '+ todosEmpleados);
            if(estadoPlanilla==null || !estadoplanilla.contains('200')){
                aSysdePortalEmpresarial.EnviarAportesEmpleados(todosEmpleados, integer.valueOf(gt), datetime.newInstance(fecha.year(), fecha.month(), fecha.day()), Id_Planilla, rezago, codigo);
                                        
                System.debug('Antes de aplicar el rezago: '+codigo+'-'+num_CodCuenta_Rez+'-'+Monto_Calculado+'-'+Monto_Sal+'-'+Moneda+'-'+Compra_Dolar);
                if(codigo!='NoAplica'){
                    System.debug('Se aplica el rezago a: '+codigo);
                    AplicarRezago(codigo, num_CodCuenta_Rez, Monto_Calculado, Monto_Sal, '',Moneda, Compra_Dolar);//Aplica El Rezago
                }            
            }            
            id_planilla='';
            
        }catch(Exception ex){
            system.debug('Error en OrdenarPlanilla: '+ ex.getLineNumber() +' - '+ ex.getMessage());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Ha ocurrido un Error'));
        }
    }
    
    public classDolares.classRespuestaDolares respuesta{get;set;}
    
    public void Aprobarplanilla(){
        try{
            System.debug('Entramos al aprobar Planilla');
            Planilla__c PlanillaAprobada = new Planilla__C();
            list<string> fechacierra = aSysdePortalEmpresarial.fechaCierreSysde();
            integer tasa = 1;
            string nombreEmpresa;
            string rezago;
            string codigo;
            
            for(integer i=0; i<planillas.size(); i++){
                if(id_planilla==planillas[i].id_cambiarSalario){
                    PlanillaAprobada.fecha__C = planillas[i].Planilla_Aprobada;
                    fecha = planillas[i].Planilla_Aprobada;
                    tasa = planillas[i].Primer_Apellido =='true' ? 0 :1;
                    nombreEmpresa = planillas[i].Primer_Nombre;
                    
                    //rezago = planillas[i].rezago;//Set Rezagos desde VF
                    rezago = Rez_SI_NO;
                    if(rezago=='Si'){
                        rezago='S';
                    }else{
                        rezago='N';
                    }
                    codigo = Num_CodReferencia_Rez.trim();
                    if(codigo.trim() =='Sin Informacion'){
                        codigo = 'NoAplica';//Set codigo de Referencia desde VF
                    }else{
                        System.debug('Antes de Calcular las cuotas: '+rezago+'-'+codigo);
                        if(rezago=='S'){
                            String resultado = ControllerApiRezagos.ConsultaRezagos(codigo);
                            List<String> SearchRes = resultado.split(',');
                            
                            //Obtengo el valor cuota de entrada
                            String valcuoent = SearchRes[14].substringBeforeLast('"');
                            valcuoent = valcuoent.substringAfterLast('"');
                            if(valcuoent=='' || valcuoent==null){valcuoent='1';}
                            system.debug('Valor Cuota de Entrada: '+valcuoent);
                            ValCuoEntrada= Decimal.valueOf(valcuoent);
                            
                            //Para obtener el valor cuota de salida, primero obtengo el fondo
                            String fondor = SearchRes[2].substringBeforeLast('"');
                            fondor = fondor.substringAfterLast('"');
                            system.debug('Fondo: '+fondor);
                            //Ahora busco el valor cuota salida
                            String valcuosal='';
                            String ValorCuota = ControllerApiRezagos.ConsultaCuotaSal();
                            List <String> ValorCuotaStr = new List<String>();
                            ValorCuotaStr = ValorCuota.split('},');
                            for(Integer count1=0;count1<ValorCuotaStr.size();count1++){
                                String rez = ValorCuotaStr[count1];
                                String ValorCuotaDia = rez.substringBeforeLast('}');
                                ValorCuotaDia = ValorCuotaDia.substringAfterLast(':');
                                String ValorCuotaFondo = rez.substringBeforeLast('",');
                                ValorCuotaFondo = ValorCuotaFondo.substringAfterLast('"');
                                if(fondor==ValorCuotaFondo){valcuosal = ValorCuotaDia;}
                            }
                            ValCuoSalida = Decimal.valueOf(valcuosal);
                        }
                    }
                    
                    System.debug('01 - rezago - codigo - tasa: '+rezago+' - '+codigo+' - '+tasa);
                    if( Num_CodReferencia_Rez.trim()=='Sin Informacion' && planillas[i].rezago == 'S'){
                           ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Favor asignar un codigo de referencia.'));
                           return;
                       }
                }
            }
            if((integer.valueOf(fechacierra[0].replace('"',''))==fecha.year() &&
                integer.valueOf(fechacierra[1])==fecha.month() &&
                integer.valueOf(fechacierra[2])==fecha.day()) || tasa ==0 || test.isRunningTest()){
                    if(tasa == 0){//Cuando es compra de dolar tasa es igual a 0
                        System.debug('Entramos a Tasa 0');
                        Planilla__C planilla = [select CurrencyIsoCode, total__C from planilla__C where id=:id_planilla];

                        respuesta = new classDolares.classRespuestaDolares ();

                        if(test.isRunningTest()){
                            respuesta.tasaCambio='1';
                        }else{
                            for(Planilla item:Planillas ){
                                if(item.id_cambiarSalario==id_planilla){
                                    Monto_calculado = (Item.rezago == null || Item.rezago == 'N') ? String.valueOf(Item.Salario) : Item.Monto_Calculado;
                                }
                            }
                            
                            system.debug('Monto Calculado: '+ Monto_calculado);
                            respuesta = aSysdePortalEmpresarial.CompraVentaDolares(planilla.CurrencyIsoCode, Decimal.valueof(Monto_Calculado), nombreEmpresa);
                        }
                        if(respuesta.tasaCambio != null){
                            decimal tasaDivision = decimal.valueOf(respuesta.tasaCambio);
                            if(planilla.CurrencyIsoCode=='USD'){
                                tasaDivision = 1/tasaDivision;
                            }
                            CambioTasa(planilla.CurrencyIsoCode, decimal.valueOf(respuesta.tasaCambio) ,tasaDivision, rezago, codigo);
                            
                            popTasa = true;
                        }else{
                            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Ha ocurrido un error en la compra venta de la dolares, por favor intente mas tarde.'));
                        }
                    }else{
                        System.debug('Entramos a tasa!=0');
                        PlanillaAprobada.Id=id_planilla;
                        PlanillaAprobada.estado2__c = 'Cerrada';
                        PlanillaAprobada.rezago__c = rezago;
                        PlanillaAprobada.Cod_Referencia__c = codigo;
                        system.debug('Antes de actualizar la planilla: '+rezago+'-'+codigo);
                        
                        update PlanillaAprobada;
                        contador=1;
                        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Datos Guardados con Exito'));
                        CargarPlanillas();
                    }
                }else{
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'La fecha de la planilla no coinside con la fecha de cierre de Sysde'));
                }
        }
        catch(Exception ex){
            system.debug('Error Aprobar Planilla: '+ ex.getLineNumber() +' - '+ ex.getMessage());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Ha ocurrido un error'));
        }
    }
    
    public void Denegarplanilla(){
        try{
            Planilla__c planilla = new Planilla__C();
            planilla.Id=id_planilla;
            planilla.estado2__c='Denegada Ficohsa';
            update planilla;
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Datos Guardados Exitosamente.')); 
            system.debug('exitoso');
            CargarPlanillas();
        }catch(Exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ocurrio un error, intente nuevamente')); 
        }
    }
    
    public void CambioTasa(string moneda, decimal tasaPlanilla, decimal tasa, string rezago, string codigo){
        try{
            //decimal tasa=tasaDivision;
            System.debug('Entramos a CambioTasa');
            list<string> idContenidoPlanilla= new list<string>();    
            List<Contenido_Planilla__C> ContenidoPlnilla = new List<Contenido_Planilla__C>();
            ContenidoPlnilla =[select id, Aporte_Empleado_Obligatorio__c, Aporte_Empleado_Voluntario__c, Aporte_Patrono_obligatorio__c, Aporte_Patrono_Voluntario__c, 
                               Aporte_Empleado_Extraordinario__c, Aporte_Patrono_Extraordinario__c, Aporte_Seguro_de_Vida__c, Reserva_Laboral__c, Aporte_Dolares_Flag__c
                               from Contenido_Planilla__C 
                               where planilla__c=:Id_planilla];
            for(integer i=0; i<ContenidoPlnilla.size(); i++){
                idContenidoPlanilla.add(ContenidoPlnilla[i].id);
            }
            List<Cuenta_planilla__C> Cuenta_planilla = new List<Cuenta_planilla__C>();
            Cuenta_planilla =[select id, Valor_Monto__c, Valor_Monto_Patrono__c, Valor_Monto_Seguro_Vida__c, Aporte_Dolares_Flag__c,
                              Valor_Monto_Patronal_Extraordinario__c , Valor_Monto_Extraordinario__c 
                              from Cuenta_planilla__C 
                              where Contenido_Planilla__c in :idContenidoPlanilla];
            
            if(tasa > 0){
                for(integer i=0; i<Cuenta_planilla.size(); i++){
                    if(Cuenta_planilla[i].Aporte_Dolares_Flag__c == null || Cuenta_planilla[i].Aporte_Dolares_Flag__c == false){
                        Cuenta_planilla[i].Valor_Monto__c = Cuenta_planilla[i].Valor_Monto__c != null ? (Cuenta_planilla[i].Valor_Monto__c / tasa).setscale(2) :0;
                        Cuenta_planilla[i].Valor_Monto_Patrono__c  =Cuenta_planilla[i].Valor_Monto_Patrono__c !=null ? (Cuenta_planilla[i].Valor_Monto_Patrono__c / tasa).setscale(2) : 0;
                        //VARIABLES AGREGADAS POR WP 10/11/19
                        Cuenta_planilla[i].Valor_Monto_Seguro_Vida__c = Cuenta_planilla[i].Valor_Monto_Seguro_Vida__c !=null ? (Cuenta_planilla[i].Valor_Monto_Seguro_Vida__c / tasa).setscale(2) : 0;
                        Cuenta_planilla[i].Valor_Monto_Patronal_Extraordinario__c = Cuenta_planilla[i].Valor_Monto_Patronal_Extraordinario__c !=null ? (Cuenta_planilla[i].Valor_Monto_Patronal_Extraordinario__c / tasa).setscale(2) : 0;
                        Cuenta_planilla[i].Valor_Monto_Extraordinario__c = Cuenta_planilla[i].Valor_Monto_Extraordinario__c !=null ? (Cuenta_planilla[i].Valor_Monto_Extraordinario__c / tasa).setscale(2) : 0;
                        Cuenta_planilla[i].Aporte_Dolares_Flag__c = true;
                    }
                }
                for(integer i=0; i<ContenidoPlnilla.size(); i++){
                    if(ContenidoPlnilla[i].Aporte_Dolares_Flag__c == null || ContenidoPlnilla[i].Aporte_Dolares_Flag__c == false){
                        ContenidoPlnilla[i].Aporte_Empleado_Obligatorio__c = (ContenidoPlnilla[i].Aporte_Empleado_Obligatorio__c / tasa).setscale(2);
                        ContenidoPlnilla[i].Aporte_Empleado_Voluntario__c  = (ContenidoPlnilla[i].Aporte_Empleado_Voluntario__c / tasa).setscale(2);
                        ContenidoPlnilla[i].Aporte_Patrono_obligatorio__c  = (ContenidoPlnilla[i].Aporte_Patrono_obligatorio__c / tasa).setscale(2);
                        ContenidoPlnilla[i].Aporte_Patrono_Voluntario__c  = (ContenidoPlnilla[i].Aporte_Patrono_Voluntario__c / tasa).setscale(2);
                        ContenidoPlnilla[i].Reserva_Laboral__c  = (ContenidoPlnilla[i].Reserva_Laboral__c / tasa).setscale(2);
                        
                        // VARIABLE AGREGADAS EL 10/11/19 POR WP
                        ContenidoPlnilla[i].Aporte_Empleado_Extraordinario__c  = (ContenidoPlnilla[i].Aporte_Empleado_Extraordinario__c / tasa).setscale(2);
                        ContenidoPlnilla[i].Aporte_Patrono_Extraordinario__c  = (ContenidoPlnilla[i].Aporte_Patrono_Extraordinario__c / tasa).setscale(2);
                        ContenidoPlnilla[i].Aporte_Seguro_de_Vida__c  = (ContenidoPlnilla[i].Aporte_Seguro_de_Vida__c / tasa).setscale(2);//no se debe reajustar
                        //
                        ContenidoPlnilla[i].Aporte_Dolares_Flag__c = true;
                    }
                }
                update Cuenta_planilla;
                update ContenidoPlnilla;
                Planilla__c planilla = new Planilla__C();
                planilla.Id = id_planilla; 
                planilla.Tasa_compra__c = tasaPlanilla;
                planilla.CurrencyIsoCode = Moneda =='HNL' ? 'USD':'HNL';
                planilla.estado2__c = 'Cerrada';
                planilla.Rezago__c = rezago;
                planilla.Cod_Referencia__c = codigo;
                System.debug('Antes de Actualizar la Planilla: '+rezago+'-'+codigo);
                update planilla;
                contador=1;
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Datos Guardados con Exito'));
                CargarPlanillas();
            } 
        }catch(Exception ex){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Ha ocurrido un error, '+ex.getMessage()+', Linea: '+ex.getLineNumber()));
        }
    }
    
    public class classAportesPlanilla{
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
        
        public Decimal aportePersonalExtraordinario { get; set; } 
        
        public Decimal aportePatronalExtraordinario { get; set; } 
        public Decimal aporteSeguroVida { get; set; }
    }
    
    //REZAGOS
    public PageReference SearchValores(){
        BTNAplicar=false;
        String consulta = CodRefTest.trim();
        string resultado = ControllerApiRezagos.ConsultaRezagos(consulta.trim());
        if(test.isRunningTest()){
            resultado='{"clientes":[{"idRezago":"SF-135","montoRezago":"40000","fondo":"106","codReferencia":"FT20prueba4","fechaDeposito":"27-SEP-20","codigoMoneda":"USD","descripcion":"Transferencia entre Cuentas","descripcionNota":"Transferencia de la cuenta XX4156 de CRISTINA BANEGAS ZEITUN    100110 VENTA $","usuIngresaRezago":"HN02913","codBanco":"28","agnBanco":"AGN PRINCIPAL TGU","rezagoSINO":"SI","asesor":"HN23213","estado":"Pendiente","valorCuotaEntrada":"127.52636724","fecInclusion":"01-OCT-20","incluidoPor":"System","fecModificacion":"08-OCT-20","modificadoPor":"HN02913","montoPendienteAplicar":""}]}';
        }
        Existe='';
        List<String> SearchRes1 = resultado.split('},');
        system.debug('Tamaño del Search: '+SearchRes1.size());
        
        if(SearchRes1.size()==1){

            List<String> SearchRes = resultado.split(',');
            system.debug('19: '+SearchRes[19]);
            String mntpen = SearchRes[19].substringBeforeLast('"');
            mntpen = mntpen.substringAfterLast('"');
            if(mntpen=='0' || mntpen==''){
                String mnt = SearchRes[1];
                mnt = mnt.substringBeforeLast('"');
                mnt = mnt.substringAfterLast('"');
                system.debug('Monto: '+mnt);
                Monto = mnt;              
            }else{
                Monto = mntpen;
                Existe = ' Corresponde a un Monto pendiente.';
            }
            
            String mon = SearchRes[5];
            mon = mon.substringBeforeLast('"');
            mon = mon.substringAfterLast('"');
            system.debug('Moneda: '+mon);
            Moneda = mon;
            
            String rez = SearchRes[11];
            rez = rez.substringBeforeLast('"');
            rez = rez.substringAfterLast('"');
            system.debug('Rezago SI/NO: '+rez);
            Rezagosn = rez;
            
            String estador = SearchRes[13].substringBeforeLast('"');
            estador = estador.substringAfterLast('"');
            if(estador=='Pagado'){
                Existe='Rezago ya Aplicado. PAGADO.';
                Monto='';
                Moneda='';
                Rezagosn='';
            }else{
                Existe='Datos de Muestra. '+Existe;
                BTNAplicar=true;
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
        displayPopup = true;
        Existe='';
        BTNAplicar=false;
        return null;
    }
    
    //Aplicar el codigo seleccionado al Cod Rezago 
    public void aplicar(){
        String MontoSTR='';
        Decimal MontoAp=0;
        Decimal MontoRez=Decimal.valueOf(Monto);
        system.debug('Variables: '+MontoRez+' - '+Cod_Planilla+' - '+CodRef+' - '+Total);
        for(integer count=0;count<planillas.size();count++){
            system.debug('Segundo Nombre: '+planillas[count].Segundo_Nombre+' - Salario: '+planillas[count].Salario);
            if(planillas[count].Segundo_Nombre == Cod_Planilla){
                MontoAp = planillas[count].Salario;
            }
        }
        
        if(MontoAp<=MontoRez){
            
            String fond='';
            Decimal valcuosal=0;
            Decimal valcuoent=0;
            Decimal mnt=0;
            String consulta = CodRefTest.trim();
            String resultado = ControllerApiRezagos.ConsultaRezagos(consulta.trim()); 
            if(test.isRunningTest()){
                resultado='{"clientes":[{"idRezago":"SF-135","montoRezago":"40000","fondo":"106","codReferencia":"FT20prueba4","fechaDeposito":"27-SEP-20","codigoMoneda":"USD","descripcion":"Transferencia entre Cuentas","descripcionNota":"Transferencia de la cuenta XX4156 de CRISTINA BANEGAS ZEITUN    100110 VENTA $","usuIngresaRezago":"HN02913","codBanco":"28","agnBanco":"AGN PRINCIPAL TGU","rezagoSINO":"SI","asesor":"HN23213","estado":"Pendiente","valorCuotaEntrada":"127.52636724","fecInclusion":"01-OCT-20","incluidoPor":"System","fecModificacion":"08-OCT-20","modificadoPor":"HN02913","montoPendienteAplicar":""}]}';
            }
            List<String> SearchRes1 = resultado.split('},');
            List<String> SearchRes = resultado.split(',');
            if(SearchRes1.size()==1){
                Rezagosn = SearchRes[11].substringBeforeLast('"');
                Rezagosn = Rezagosn.substringAfterLast('"');
                if(Rezagosn=='SI' || Rezagosn=='Si' || Rezagosn=='si'){ 
                    
                    fond = SearchRes[2].substringBeforeLast('"');
                    fond = fond.substringAfterLast('"');
                    System.debug('Fondo: '+fond);
                    
                    String valent = SearchRes[14].substringBeforeLast('"');
                    valent = valent.substringAfterLast('"');
                    if(valent=='' || valent==null){valent='1';}
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
                    planillas[count].codigoReferencia=CodRefTest;
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
        closePopup();
    }
    
    @future(callout = true)
    public static void AplicarRezago(String NumCodRez, String NumCodCue, String MonCalc, String MonDep, String User, String Mon, String ComDol) {
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
            String resultado = ControllerApiRezagos.ConsultaRezagos(CodRezago);
            if(test.isRunningTest()){
                resultado='{"clientes":[{"idRezago":"SF-135","montoRezago":"40001","fondo":"106","codReferencia":"FT20prueba4","fechaDeposito":"27-SEP-20","codigoMoneda":"USD","descripcion":"Transferencia entre Cuentas","descripcionNota":"Transferencia de la cuenta XX4156 de CRISTINA BANEGAS ZEITUN    100110 VENTA $","usuIngresaRezago":"HN02913","codBanco":"28","agnBanco":"AGN PRINCIPAL TGU","rezagoSINO":"SI","asesor":"HN23213","estado":"Pendiente","valorCuotaEntrada":"127.52636724","fecInclusion":"01-OCT-20","incluidoPor":"System","fecModificacion":"08-OCT-20","modificadoPor":"HN02913","montoPendienteAplicar":""}]}';
            }
            List<String> SearchRes = resultado.split(',');
            List<ClientesRez> ListClientesRez = new List<ClientesRez>();
            ClientesRez AplicaRez = new ClientesRez('','','','','','','','','','','','','');
            
            String idr = SearchRes[0].substringBeforeLast('"');
            idr = idr.substringAfterLast('"');
            system.debug('idRezago: '+idr);
            AplicaRez.idRezago = idr;// Añado el Id Rezago
            
            String montor = SearchRes[1].substringBeforeLast('"');
            montor = montor.substringAfterLast('"');
            system.debug('Monto Rezago: '+montor);
            AplicaRez.montoRezago = montor;// Añado el Monto del Rezago
            
            String fondor = SearchRes[2].substringBeforeLast('"');
            fondor = fondor.substringAfterLast('"');
            system.debug('Fondo: '+fondor);
            AplicaRez.fondo = fondor;// Añado el Fondo del Rezago
            
            String codrefr = SearchRes[3].substringBeforeLast('"');
            codrefr = codrefr.substringAfterLast('"');
            system.debug('Codigo Referencia Rezago: '+codrefr);
            AplicaRez.codReferencia = codrefr;// Añado el Codigo de referencia del Rezago
            
            system.debug('Numero de Cuenta: ');
            AplicaRez.codCuenta = '';// Añado el Codigo de Cuenta
            
            system.debug('Codigo de Planilla: '+NumCodCue);
            AplicaRez.codPlanilla = NumCodCue;// Añado el Codigo de Planilla
            
            String valcuoent = SearchRes[14].substringBeforeLast('"');
            valcuoent = valcuoent.substringAfterLast('"');
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
            
            String estador = SearchRes[13].substringBeforeLast('"');
            estador = estador.substringAfterLast('"');
            system.debug('Estado: '+estador);
            AplicaRez.estado = estador;// Añado el Estado del Rezago
            
            String sino = SearchRes[11].substringBeforeLast('"');
            sino = sino.substringAfterLast('"');
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
            String mntpen = SearchRes[19].substringBeforeLast('"');
            mntpen = mntpen.substringAfterLast('"');
            Decimal mntr=0;
            if(mntpen=='0' || mntpen==''){
                mntr = Decimal.valueOf(montor);                
            }else{
                mntr = Decimal.valueOf(mntpen);
            }
            Decimal mnt = 0;
            if(test.isRunningTest()){
                mnt=mntr;
            }else{
                mnt = Decimal.valueOf(MonDep);
            }
            if(mnt<mntr){//Si el monto del aporte es menor al del rezago
                mparapl = mnt; //Se aplica un monto parcial
                mpenapl = mntr-mnt;//Queda un monto pendiente que pasa a ser el Monto del rezago
                AplicaRez.estado = 'Pendiente';
            }else{//Sino es menor se aplican los parciales y pendientes en 0
                mparapl=0;
                mpenapl=0;
                AplicaRez.estado = 'Pagado';
            }
            
            system.debug('Valor Monto Parcial: '+String.valueOf(mparapl));
            AplicaRez.montoParcialAplicado = String.valueOf(mparapl);//Añado el Monto Parcial Aplicado
            
            system.debug('Valor Monto Pendiente: '+String.valueOf(mpenapl));
            AplicaRez.montoPendienteAplicar = String.valueOf(mpenapl);//Añado el Monto Pendiente a Aplicar
            
            AplicaRez.modificadoPor = ''; //Cambiar al Usuario que corresponda
            
            ListClientesRez.add(AplicaRez);
            
            String FechaD = SearchRes[4].substringBeforeLast('"');
            FechaD = FechaD.substringAfterLast('"');
            
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
                //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Verifique que el fondo este asociado a una Cuenta. :'+AplicaRez.fondo));
            }
            String RespuestaRetiro='OK';
            String AplicaPartida='';
            if( rezagoEnvio.Tipo == 'AP'){
            	RespuestaRetiro = ControllerApiRezagos.AplicaRetiroRezagos(CuentaOrigen, Mon, valAporteCalculado);
                if(RespuestaRetiro.contains('Su retiro ha sido registrado')){
                	RespuestaRetiro='OK';
                }else{
                    RespuestaRetiro='Failure';
                	System.debug('Error al aplicar Retiro: '+CuentaOrigen+' - '+Mon+' - '+valAporteCalculado);
                }
            }
            
            if(RespuestaRetiro=='OK' || test.isRunningTest()){
                if( rezagoEnvio.Tipo == 'AD'){
                    result = ControllerApiRezagos.AplicaRezagosDia(rezagoEnvio);
                }else{
                    //Cargar metodo para enviar el rezago en caso que sea un rezago SI.-
                    system.debug('Antes de Ejecutar el Metodo AP: '+rezagoEnvio);
                    result = ControllerApiRezagos.AplicaRezagosDia(rezagoEnvio);
                }
                if(result=='"OK"' || test.isRunningTest()){
                    //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Rezago aplicado correctamente.'));
                    AplicaPartida = AplicaPartida(AplicaRez.fondo, valAporteCalculado, AplicaRez.codPlanilla, ComDol, FechaD);
                    system.debug('Aplica Partida Result: '+AplicaPartida);
                }
            }
        }catch(exception ex){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ha Ocurrido un error: '+result+' '+ex));
        }
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
            if(CompDol=='True'){
                partida = [SELECT Cuenta_Debito__c, Descripcion__c, Id_Banco__c, Moneda__c, Sub_Aplicacion__c, Tipo_Nota__c, Tipo_Transaccion__c 
                           FROM Partida_Rezago__mdt WHERE Fondo__c =: fondo AND Compra_Dolar__c =: 'S' AND  Cuenta__c = 'P' LIMIT 1];
            }else{
                partida = [SELECT Cuenta_Debito__c, Descripcion__c, Id_Banco__c, Moneda__c, Sub_Aplicacion__c, Tipo_Nota__c, Tipo_Transaccion__c 
                           FROM Partida_Rezago__mdt WHERE Fondo__c =: fondo AND Compra_Dolar__c =: 'N' AND  Cuenta__c = 'P' LIMIT 1];
            }
        }catch(Exception ex){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Verifique que el fondo este asociado a una Partida. :'+fondo));
        }
        if(partida.size()>0){
            //Clase con todos los campos
            envioDatos.Id_banco = partida[0].Id_Banco__c;
            envioDatos.Monto = montocal;
            envioDatos.cta_contable_debito = partida[0].Cuenta_Debito__c;
            envioDatos.cta_contable_credito = NULL;
            if(partida[0].Moneda__c=='Lempiras'){envioDatos.moneda = '1';}else{envioDatos.moneda = '2';}
            envioDatos.Modulo = 'BCO';
            if(partida[0].Tipo_Nota__c=='Debito'){envioDatos.tip_nota = 'D';}else{envioDatos.tip_nota = 'C';}
            envioDatos.tip_nota = 'D';
            
            String cuentax = '';//Busca la cuenta de FPC Rezagos
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
            if(CompDol=='True'){
                envioDatos.fecha = Datetime.now();
            }else{
                envioDatos.fecha = NULL;
            }
            //envioDatos.fecha = null;
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
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Partida contable creada correctamente.  '));
            resultado='OK';
        } else if(resultJson.contains('Read timed out')){
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error de conexión a la base de datos: "Read timed out".  '));
            resultado='Fail';
        } else {    
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se produjo un error en el Servicio Web.  '));
            resultado='Fail';
        }
        return resultado;
    } 
}