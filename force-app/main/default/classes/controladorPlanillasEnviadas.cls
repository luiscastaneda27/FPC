public class controladorPlanillasEnviadas {
    
    Public list<Planilla> Planillas{get;set;}
    Public string Id_Planilla{get;set;}
    public List<SelectOption> options {get;set;}
    private integer contador;
    date fecha;
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
            mostrarPan=true;
            list<Planilla__C> TodasPlanillas=new list<Planilla__C>();
            planillas = new list<Planilla>();
            TodasPlanillas=[select id,empresa2__r.name,tasa_compra__C, tipo_planilla__c,name, Estado2__c,
                            TA_Empleado_Obligatorio__c, TA_Patrono_obligatorio__c, TA_Empleado_Voluntario__c, 
                            TA_Patrono_Voluntario__c, Total_Reserva_Laboral2__c, TA_Empleado_Extraordinario__c,
                            TA_Patrono_Extraordinario__c, TA_Seguro_de_Vida__c, fecha__C, CurrencyIsoCode 
                            from planilla__c where estado2__c='Pendiente aprobación Ficohsa' order by name asc];
            for(integer i=0; i<TodasPlanillas.size(); i++){
                decimal TotalPilares =TodasPlanillas[i].TA_Empleado_Obligatorio__c + TodasPlanillas[i].TA_Patrono_obligatorio__c + TodasPlanillas[i].TA_Empleado_Voluntario__c + TodasPlanillas[i].TA_Patrono_Voluntario__c + TodasPlanillas[i].Total_Reserva_Laboral2__c + TodasPlanillas[i].TA_Empleado_Extraordinario__c + TodasPlanillas[i].TA_Patrono_Extraordinario__c + TodasPlanillas[i].TA_Seguro_de_Vida__c;
                if(TodasPlanillas[i].tasa_compra__C==0){
                    planillas.add(new Planilla(TodasPlanillas[i].id, TodasPlanillas[i].empresa2__r.name, date.today(),TodasPlanillas[i].name,TotalPilares,'true','false',TodasPlanillas[i].CurrencyIsoCode , null, null));
                }else{
                    planillas.add(new Planilla(TodasPlanillas[i].id, TodasPlanillas[i].empresa2__r.name, TodasPlanillas[i].fecha__C,TodasPlanillas[i].name,TotalPilares,'false','true',TodasPlanillas[i].CurrencyIsoCode, null, null));
                }
            }
            if(contador>0){
                contador=0;
                Bandera='Correctamente';
                planilla__c planilla=new planilla__C();
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
        try
        {
            list<string> idcontenido = new list<string>();
            string empresa;
            string rezago;
            string codigo;
            for(Contenido_planilla__C item:
                [select id, planilla__r.cod_referencia__C,planilla__r.rezago__C, planilla__r.empresa2__C,planilla__r.respuesta_desde_sysde_aportes__C 
                 from contenido_planilla__C where planilla__C=:id_planilla]){
                     idcontenido.add(item.id);
                     empresa=item.planilla__r.empresa2__C;
                     rezago=item.planilla__r.rezago__C;
                     codigo=item.planilla__r.cod_referencia__C;
                 }
            
            Autonumerico_cuentas_Syste__c Numerosformularios=[select id, Id_Formulario_Sysde__c from Autonumerico_cuentas_Syste__c limit 1];
            decimal abc=Numerosformularios.Id_Formulario_Sysde__c;
            list<cuenta_planilla__C> cuentas = New list<cuenta_planilla__C>();
            cuentas =[select  Codigo_cuenta__c, valor_monto__C, Valor_Monto_Patrono__c, Valor_Monto_Extraordinario__c, Valor_Monto_Patronal_Extraordinario__c, Valor_Monto_Seguro_Vida__c, contenido_planilla__r.empleado2__r.identificacion__C from cuenta_planilla__C
                      where contenido_planilla__C in :(idcontenido)];
            idcontenido.clear();
            for(cuenta_planilla__C item : cuentas){
                idcontenido.add(item.Codigo_cuenta__c); 
            }
            list<cuentas__C> cuentas_salesforce =new list<cuentas__C>();
            cuentas_salesforce=[select Producto__r.CurrencyIsoCode, cliente__r.identificacion__C,
                                Cuenta_colectiva2__r.codigo__C, Codigo__c from cuentas__C
                                where codigo__C in :(idcontenido)];
            map<string, list<cuentas__C>> mapCuentas= new map<string, list<cuentas__C>>();
            for(integer i=0; i<cuentas_salesforce.size(); i++){
                list<cuentas__C> listCuentas = new list<cuentas__C>();
                if(mapCuentas.containsKey(cuentas_salesforce[i].cliente__r.identificacion__C)){
                    listCuentas=mapCuentas.get(cuentas_salesforce[i].cliente__r.identificacion__C);
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
                    if(cuentas_salesforce[jj].codigo__C==cuentas[i].codigo_cuenta__C){
                        nueva = new classAportesPlanilla();
                        nueva.idSalesforce ='SF'+string.valueOf((ABC++));
                        nueva.identificacion=cuentas_salesforce[jj].cliente__r.identificacion__C;
                        nueva.cuentaColectiva =cuentas_salesforce[jj].Cuenta_colectiva2__r.codigo__C;
                        nueva.cuenta=cuentas[i].Codigo_cuenta__c;
                        nueva.codigoCuenta=integer.valueOf(cuentas[i].Codigo_cuenta__c);
                        nueva.codigoMoneda = cuentas_salesforce[jj].Producto__r.CurrencyIsoCode=='HNL' ? '1':'2';
                        nueva.aportePersonalVoluntario=cuentas[i].valor_monto__C;
                        nueva.aportePatronalVoluntario=cuentas[i].valor_monto_patrono__C;
                        //
                        nueva.aportePersonalExtraordinario=cuentas[i].Valor_Monto_Extraordinario__c;
                        nueva.aportePatronalExtraordinario=cuentas[i].Valor_Monto_Patronal_Extraordinario__c;
                        nueva.aporteSeguroVida=cuentas[i].Valor_Monto_Seguro_Vida__c;
                        //
                        nueva.aportePersonalObligatorio=0;
                        nueva.aportePatronalObligatorio=0;
                       // nueva.rezago = rezago;
                        //nueva.codigoReferencia = codigo;
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
                        //todosEmpleados +=nueva.rezago+',';
                        //todosEmpleados +=nueva.codigoReferencia+'::::';
                        
                    }
                }
                
            }
            idcontenido.clear();
            map<string, string> banderamapa = new map<string, string>();
            map<string, string> banderamapa2 = new map<string, string>();
            for(Cuentas_colectivas__C item: [select codigo__C, Tipo_cuenta__C from Cuentas_colectivas__C where empresa__c=:empresa
                                             and tipo_cuenta__C !='Voluntarias']){
                                                 idcontenido.add(item.codigo__C);
                                                 banderamapa.put(item.codigo__C, item.tipo_cuenta__C);
                                             }
            cuentas_salesforce.clear();
            
            cuentas_salesforce=[select Producto__r.CurrencyIsoCode, cliente__r.identificacion__C,
                                Cuenta_colectiva2__r.codigo__C, Codigo__c from cuentas__C
                                where Cuenta_colectiva2__r.codigo__C in :(idcontenido)];
            mapCuentas.clear();
            for(integer i=0; i<cuentas_salesforce.size(); i++){
                list<cuentas__C> litsCuentas = new list<cuentas__C>();
                if(mapCuentas.containsKey(cuentas_salesforce[i].cliente__r.identificacion__C)) {
                    litsCuentas=mapCuentas.get(cuentas_salesforce[i].cliente__r.identificacion__C);
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
                    if(contenido[i].empleado2__r.Identificacion__C==cuentas_salesforce[j].cliente__r.Identificacion__C){
                        if(banderamapa.get(cuentas_salesforce[j].Cuenta_colectiva2__r.codigo__C)== 'Pilar Complementario'){
                            nueva = new classAportesPlanilla();
                            nueva.idSalesforce ='SF'+string.valueOf((ABC++));
                            nueva.identificacion=contenido[i].empleado2__r.Identificacion__C;
                            nueva.cuentaColectiva =cuentas_salesforce[j].Cuenta_colectiva2__r.codigo__C;
                            nueva.cuenta=cuentas_salesforce[j].Codigo__c;
                            nueva.codigoCuenta=integer.valueOf(cuentas_salesforce[j].Codigo__c);
                            nueva.codigoMoneda = cuentas_salesforce[j].Producto__r.CurrencyIsoCode=='HNL' ? '1' :'2';
                            nueva.aportePersonalVoluntario=0;
                            nueva.aportePatronalVoluntario=0;
                            nueva.aportePersonalObligatorio=contenido[i].Aporte_Empleado_Obligatorio__c;
                            nueva.aportePatronalObligatorio=contenido[i].Aporte_Patrono_Obligatorio__c;
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
                            //todosEmpleados +=rezago+',';
                            //todosEmpleados +=codigo+'::::';
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
                            //todosEmpleados +=rezago+',';
                            //todosEmpleados +=codigo+'::::';
                        }
                    }
                }
            }   
            
            
            Numerosformularios.Id_Formulario_Sysde__c=abc;
            update Numerosformularios;
            STRING MES=[SELECT MES_APORTE__c FROM PLANILLA__c WHERE ID=:Id_Planilla].MES_aPORTE__c;
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
            system.debug('Si lo llama P: '+ todosEmpleados);
            if(estadoPlanilla==null || !estadoplanilla.contains('200')){
                aSysdePortalEmpresarial.EnviarAportesEmpleados(todosEmpleados, integer.valueOf(gt), datetime.newInstance(fecha.year(), fecha.month(), fecha.day()), Id_Planilla, rezago, codigo);
            }
            id_planilla='';
            
        }catch(Exception ex){
            system.debug('error en si lo llama: '+ ex.getLineNumber() + ex.getMessage());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Ha ocurrido un Error'));
        }
    }
    public classDolares.classRespuestaDolares respuesta{get;set;}
    public void Aprobarplanilla(){
        try{
            Planilla__c PlanillaAprobada = new Planilla__C();
            date fcsd =aSysdePortalEmpresarial.fechaCierreSysde();
            integer tasa = 1;
            string nombreEmpresa;
            string rezago;
            string codigo;
            for(integer i=0; i<planillas.size(); i++){
                if(id_planilla==planillas[i].id_cambiarSalario){
                    PlanillaAprobada.fecha__C = planillas[i].Planilla_Aprobada;
                    fecha=planillas[i].Planilla_Aprobada;
                    tasa = planillas[i].Primer_Apellido =='true' ? 0 :1;
                    nombreEmpresa = planillas[i].Primer_Nombre;
                    //id_planilla.toUpperCase()
                    rezago= planillas[i].rezago;
                    codigo = planillas[i].codigoReferencia;
                    if( (planillas[i].codigoReferencia == null || planillas[i].codigoReferencia.trim() =='') &&  planillas[i].rezago == 'S' ){
                         ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Favor llenar escribir la referencia'));
                        return;
                    }
                }
            }
            //PlanillaAprobada.fecha__C = date.valueOf('2019-05-23');
            system.debug('fecha SYSDE: '+fcsd+' '+fecha);
            if(fcsd == fecha || tasa ==0 || test.isRunningTest()){
                    if(tasa == 0){
                        Planilla__C planilla = [select CurrencyIsoCode, total__C from planilla__C where id=:id_planilla];
                        respuesta = new classDolares.classRespuestaDolares ();
                        respuesta = aSysdePortalEmpresarial.CompraVentaDolares(planilla.CurrencyIsoCode, planilla.total__C, nombreEmpresa);
                        if(respuesta.tasaCambio !=null){
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
                        PlanillaAprobada.Id=id_planilla;
                        PlanillaAprobada.estado2__c='Cerrada';
                        PlanillaAprobada.rezago__c = rezago;
                        update PlanillaAprobada;
                        contador=1;
                        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Datos Guardados con Exito'));
                        CargarPlanillas();
                    }
                }else{
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'La fecha de la planilla no coinside con la fecha de cierre de Sysde'));
                }
        }
        catch(Exception ex)
        {
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
            list<string> idContenidoPlanilla= new list<string>();    
            List<Contenido_Planilla__C> ContenidoPlnilla = new List<Contenido_Planilla__C>();
            ContenidoPlnilla =[select id, Aporte_Empleado_Obligatorio__c, Aporte_Empleado_Voluntario__c, Aporte_Patrono_obligatorio__c, Aporte_Patrono_Voluntario__c, Aporte_Empleado_Extraordinario__c, Aporte_Patrono_Extraordinario__c, Aporte_Seguro_de_Vida__c, Reserva_Laboral__c from Contenido_Planilla__C where planilla__c=:Id_planilla];
            for(integer i=0; i<ContenidoPlnilla.size(); i++){
                idContenidoPlanilla.add(ContenidoPlnilla[i].id);
            }
            List<Cuenta_planilla__C> Cuenta_planilla = new List<Cuenta_planilla__C>();
            Cuenta_planilla =[select id, Valor_Monto__c, Valor_Monto_Patrono__c, Valor_Monto_Seguro_Vida__c, 
                              Valor_Monto_Patronal_Extraordinario__c , Valor_Monto_Extraordinario__c from Cuenta_planilla__C where Contenido_Planilla__c in :idContenidoPlanilla];
            if(tasa > 0){
                for(integer i=0; i<Cuenta_planilla.size(); i++){
                    Cuenta_planilla[i].Valor_Monto__c = Cuenta_planilla[i].Valor_Monto__c !=null ? (Cuenta_planilla[i].Valor_Monto__c / tasa).setscale(2) :0;
                    Cuenta_planilla[i].Valor_Monto_Patrono__c  =Cuenta_planilla[i].Valor_Monto_Patrono__c !=null ? (Cuenta_planilla[i].Valor_Monto_Patrono__c / tasa).setscale(2) : 0;
                    //VARIABLES AGREGADAS POR WP 10/11/19
                    Cuenta_planilla[i].Valor_Monto_Seguro_Vida__c  =Cuenta_planilla[i].Valor_Monto_Seguro_Vida__c !=null ? (Cuenta_planilla[i].Valor_Monto_Seguro_Vida__c / tasa).setscale(2) : 0;
                    Cuenta_planilla[i].Valor_Monto_Patronal_Extraordinario__c  =Cuenta_planilla[i].Valor_Monto_Patronal_Extraordinario__c !=null ? (Cuenta_planilla[i].Valor_Monto_Patronal_Extraordinario__c / tasa).setscale(2) : 0;
                    Cuenta_planilla[i].Valor_Monto_Extraordinario__c  =Cuenta_planilla[i].Valor_Monto_Extraordinario__c !=null ? (Cuenta_planilla[i].Valor_Monto_Extraordinario__c / tasa).setscale(2) : 0;
                    //
                }
                for(integer i=0; i<ContenidoPlnilla.size(); i++){
                    ContenidoPlnilla[i].Aporte_Empleado_Obligatorio__c = (ContenidoPlnilla[i].Aporte_Empleado_Obligatorio__c / tasa).setscale(2);
                    ContenidoPlnilla[i].Aporte_Empleado_Voluntario__c  = (ContenidoPlnilla[i].Aporte_Empleado_Voluntario__c / tasa).setscale(2);
                    ContenidoPlnilla[i].Aporte_Patrono_obligatorio__c  = (ContenidoPlnilla[i].Aporte_Patrono_obligatorio__c / tasa).setscale(2);
                    ContenidoPlnilla[i].Aporte_Patrono_Voluntario__c  = (ContenidoPlnilla[i].Aporte_Patrono_Voluntario__c / tasa).setscale(2);
                    ContenidoPlnilla[i].Reserva_Laboral__c  = (ContenidoPlnilla[i].Reserva_Laboral__c / tasa).setscale(2);
                    
                    // VARIABLE AGREGADAS EL 10/11/19 POR WP
                    
                    ContenidoPlnilla[i].Aporte_Empleado_Extraordinario__c  = (ContenidoPlnilla[i].Aporte_Empleado_Extraordinario__c / tasa).setscale(2);
                    ContenidoPlnilla[i].Aporte_Patrono_Extraordinario__c  = (ContenidoPlnilla[i].Aporte_Patrono_Extraordinario__c / tasa).setscale(2);
                    ContenidoPlnilla[i].Aporte_Seguro_de_Vida__c  = (ContenidoPlnilla[i].Aporte_Seguro_de_Vida__c / tasa).setscale(2);
                    //
                }
                update Cuenta_planilla;
                update ContenidoPlnilla;
                Planilla__c planilla = new Planilla__C();
                planilla.Id=id_planilla; 
                planilla.Tasa_compra__c=tasaPlanilla;
                planilla.CurrencyIsoCode=Moneda =='HNL' ? 'USD':'HNL';
                planilla.estado2__c='Cerrada';
                planilla.Rezago__c = rezago;
                planilla.Cod_Referencia__c = codigo;
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
    
    
}