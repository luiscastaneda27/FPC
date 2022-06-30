public class ControllerPantallaConsultaRezagos {
    
    public list<clientes> ListRezagos {get;set;}//Guarda los datos de la tabla de rezagos
    Public List<ClaseRezagos> MuestraRezagos {get;set;}//Guarda los datos a mostrar en la VF
    public String ValorCuotaDia {get;set;}
    public String ValorCuotaFondo {get;set;}
    public string p_Mensaje_error {get;set;}
    public string Usuario {get;set;}
    public boolean MensajeErr {get;set;}
    
    public List<ClientesRez> ListClientesRez {get;set;}
    public ClientesRez AplicaRez{get;set;}
    
    public ControllerPantallaConsultaRezagos(){
        try{
            //Usuario =  ApexPages.currentPage().getParameters().get('hytrd');
            List<User> usr = [Select Id, Name From User Where Id=:UserInfo.getUserId() Limit 1];
            System.debug('User: '+usr[0].Name);///////Marcooo
            Usuario = usr[0].Name;
            
            llenartabla();
        }Catch(Exception ex){
            system.debug('Error: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());
            p_Mensaje_error = 'Error al Consultar los Rezagos en el Metodo: ControllerPantallaConsultaRezagos. <br/>Error: ' + ex.getMessage() + '<br/>Linea: ' + ex.getLineNumber();
            MensajeErr = true;
        }
    }
    
    public void Cerrar() {
        p_Mensaje_error = '';
        MensajeErr = false;
    }
    
    public void llenartabla(){
        Try{
            String consulta = null;
            
            InfoRezagos resultado = new InfoRezagos();
            for(InfoRezagos.clientes IRc : ControllerApiRezagos.ConsultaRezagos()){
                resultado.clientes.add(IRc);
            } 
            
            ListRezagos = new List<clientes>();
            List<String> resultado3;
            
            if(resultado.clientes != null && resultado.clientes.size() >= 1){
                for(Integer count=0;count<resultado.clientes.size();count++ ){
                    if(resultado.clientes[count].rezagoSINO!='SI' && resultado.clientes[count].rezagoSINO!='Si'){
                        clientes Rezago = new clientes('',null,'','',null,'','','','','','','','','','',null,'',null,'');
                        
                        Rezago.idRezago = resultado.clientes[count].idRezago;// Agrego el id Rezago
                        
                        Rezago.montoRezago = resultado.clientes[count].montoRezago; // Agrego el Monto
                        
                        Rezago.fondo = resultado.clientes[count].fondo;//Agrego el Fondo
                        
                        Rezago.codReferencia = resultado.clientes[count].codReferencia;//Agrego el codigo de referencia
                        system.debug('Codigo de Referencia: '+Rezago.codReferencia);
                        
                        String rez = resultado.clientes[count].fechaDeposito;
                        system.debug('Dato desde Sysde: '+rez);
                        string datecomplete = dateconvert(rez);
                        
                        try{Rezago.fechaDeposito = DateTime.valueOf(datecomplete);}catch(exception ex){Rezago.fechaDeposito=null;}
                        system.debug('Fecha Deposito: '+Rezago.fechaDeposito);
                        
                        Rezago.codigoMoneda = resultado.clientes[count].codigoMoneda;//Agrego la Moneda
                        
                        Rezago.descripcion = resultado.clientes[count].descripcion;//Agrego la Descripcion
                        
                        Rezago.descripcionNota = resultado.clientes[count].descripcionNota;//Agrego la Descripcion Nota
                        
                        Rezago.usuIngresaRezago = resultado.clientes[count].usuIngresaRezago;//Agrego el usuario que ingresa el rezago
                        system.debug('Usuario que ingresa el rezago: '+Rezago.usuIngresaRezago);
                        
                        Rezago.codBanco = resultado.clientes[count].codBanco;//Agrego el codigo de banco
                        
                        Rezago.agnBanco = resultado.clientes[count].agnBanco;//Agrego la Agencia del Banco
                        
                        Rezago.rezagoSINO = resultado.clientes[count].rezagoSINO;//Agrego Rezago SI / NO
                        
                        Rezago.asesor = resultado.clientes[count].asesor;// Agrego el Asesor
                        
                        Rezago.estado = resultado.clientes[count].estado;//Agrego el Estado
                        
                        Rezago.valorCuotaEntrada = resultado.clientes[count].valorCuotaEntrada;//Agrego la cuota de entrada
                        
                        rez = resultado.clientes[count].fecInclusion;
                        rez = rez.substringBeforeLast('"');
                        rez = rez.substringAfterLast('"');
                        datecomplete = dateconvert(rez);
                        try{Rezago.fecInclusion = Datetime.valueOf(datecomplete);}catch(exception ex){Rezago.fecInclusion=null;}
                        
                        Rezago.incluidoPor = resultado.clientes[count].incluidoPor;//Agrego el Incluido Por
                        
                        rez = resultado.clientes[count].fecModificacion;
                        rez = rez.substringBeforeLast('"');
                        rez = rez.substringAfterLast('"');
                        datecomplete = dateconvert(rez);
                        try{Rezago.fecModificacion = Datetime.valueOf(datecomplete);}catch(exception ex){Rezago.fecModificacion=null;}
                        
                        Rezago.modificadoPor = resultado.clientes[count].modificadoPor;//Agrego el Modificado Por
                        
                        ListRezagos.add(Rezago);
                    }
                }
                mostrardatos();
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tabla Vacia'));
            }
        }Catch(Exception ex){
            system.debug('Error: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());
            p_Mensaje_error = 'Error al Consultar los Rezagos en el Metodo: llenartabla. <br/>Error: ' + ex.getMessage() + '<br/>Linea: ' + ex.getLineNumber();
            MensajeErr = true;
        }        
    }
    
    public string dateconvert(String Datet){
        string dateday = Datet.substringBefore('-');
        string datemonth = Datet.substringBetween('-');
        if(datemonth=='JAN'){datemonth='01';}
        if(datemonth=='ENE'){datemonth='01';}
        if(datemonth=='FEB'){datemonth='02';}
        if(datemonth=='MAR'){datemonth='03';}
        if(datemonth=='APR'){datemonth='04';}
        if(datemonth=='ABR'){datemonth='04';}
        if(datemonth=='MAY'){datemonth='05';}
        if(datemonth=='JUN'){datemonth='06';}
        if(datemonth=='JUL'){datemonth='07';}
        if(datemonth=='AUG'){datemonth='08';}
        if(datemonth=='AGO'){datemonth='08';}
        if(datemonth=='SEP'){datemonth='09';}
        if(datemonth=='OCT'){datemonth='10';}
        if(datemonth=='NOV'){datemonth='11';}
        if(datemonth=='DEC'){datemonth='12';}
        if(datemonth=='DIC'){datemonth='12';}
        string dateyear = Datet.substringAfterLast('-');
        string datecomplete = '20'+dateyear+'-'+datemonth+'-'+dateday+' 06:00:00';
        return datecomplete;
    }
    
    Public class ClaseRezagos{
        
        public String Monto {get;set;}
        public String Fondo {get;set;}
        public String Cod_referencia {get;set;}
        public String FechaDeposito {get;set;}
        public String Moneda {get;set;}
        public String Descripcion {get;set;}
        public String DescripcionNota {get;set;}
        public String Usu_ing_Rezago {get;set;}
        public String Cod_banco {get;set;}
        public String Agn_banco {get;set;}
        public String Asesor {get;set;}
        
        public ClaseRezagos(String Monto, String Fondo,String Cod_referencia, String FechaDeposito, String Moneda,
                            String Descripcion, String DescripcionNota, String Usu_ing_Rezago, String Cod_banco, String Agn_banco,
                            String Asesor){
            this.Monto=Monto;
            this.Fondo=Fondo;
            this.Cod_referencia=Cod_referencia;
            this.FechaDeposito=FechaDeposito;
            this.Moneda=Moneda;
            this.Descripcion=Descripcion;
            this.DescripcionNota=DescripcionNota;
            this.Usu_ing_Rezago=Usu_ing_Rezago;
            this.Cod_banco=Cod_banco;
            this.Agn_banco=Agn_banco;
            this.Asesor=Asesor;
        }
    }
    
    public void mostrardatos(){
        Try{
            MuestraRezagos = new List<ClaseRezagos>();
            for(Integer count=0;count<ListRezagos.size();count++){
                ClaseRezagos dato = new ClaseRezagos('','','','','','','','','','','');
                system.debug('Decimal: '+ListRezagos[count].montoRezago);
                Decimal m=0;
                if(ListRezagos[count].montoRezago!='' && ListRezagos[count].montoRezago!=null){
                    m = Decimal.valueOf(ListRezagos[count].montoRezago);
                    m = m.setScale(2);
                }
                List<String> args = new String[]{'0','number','###,###,##0.00'};
                    String s = String.format(m.format(), args);
                dato.Monto = s ;//OK
                
                dato.Fondo = ListRezagos[count].fondo;//OK
                dato.Cod_referencia = ListRezagos[count].codReferencia;//OK
                
                String fecha='';
                if(ListRezagos[count].fechaDeposito!= null){
                    fecha = ListRezagos[count].fechaDeposito.format('dd-MM-yyyy');
                }else{
                    fecha='';
                }
                
                system.debug('Fecha Deposito: '+fecha);
                dato.FechaDeposito = fecha;//OK
                
                dato.Moneda=ListRezagos[count].codigoMoneda;//OK en VF
                dato.Descripcion=ListRezagos[count].descripcion;
                dato.DescripcionNota=ListRezagos[count].descripcionNota;
                dato.Usu_ing_Rezago=ListRezagos[count].incluidoPor;
                
                string bancostr = ListRezagos[count].codBanco;
                string banca='';
                Schema.DescribeFieldResult fieldResult = Cuentas__c.Banco__c.getDescribe();
                List<Schema.PicklistEntry> values = fieldResult.getPicklistValues();
                for( Schema.PicklistEntry v : values) {
                    if(v.getValue()==bancostr){banca = v.getLabel();}
                }
                dato.Cod_banco = banca;//OK
                
                dato.Agn_banco=ListRezagos[count].agnBanco;
                
                string asesorstr = ListRezagos[count].asesor;
                string asesorstr2='';
                if(asesorstr!='TODOS'){
                    Schema.DescribeFieldResult fieldResult1 = Account.Asesor__c.getDescribe();
                    List<Schema.PicklistEntry> values1 = fieldResult1.getPicklistValues();
                    for( Schema.PicklistEntry v : values1) {
                        if(v.getValue() == asesorstr){asesorstr2 = v.getLabel();}
                    }
                }else{
                    asesorstr2 = 'TODOS';
                }
                if(asesorstr2==''){
                    asesorstr2='TODOS';
                }
                dato.Asesor=asesorstr2;//Traer Asesor
                
                MuestraRezagos.add(dato);
            }
        }Catch(Exception ex){
            system.debug('Error: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());
            p_Mensaje_error = 'Error al Consultar los Rezagos en el Metodo: llenartabla. <br/>Error: ' + ex.getMessage() + '<br/>Linea: ' + ex.getLineNumber();
            MensajeErr = true;
        }
        
    }
    
    public void Aplicar(){
        Boolean correcto=true;
        for(Integer count=0;count<ListRezagos.size();count++){
            classAportes_Conciliacion apor =  new classAportes_Conciliacion();
            apor.Cod_referencia = ListRezagos[count].codReferencia;
            try{
                List<Cuenta_Rezago__mdt> codigo = new List<Cuenta_Rezago__mdt>();
                codigo = [select cuenta__c from Cuenta_Rezago__mdt where fondo__c =: ListRezagos[count].fondo limit 1];
                if(codigo.size()>0){
                    apor.Cuenta = codigo[0].cuenta__c ;//Insertar el codigo de cuenta de FPC Rezagos
                }else{
                    correcto=false;
                    p_Mensaje_error = 'ERROR: Verifique que el fondo '+ListRezagos[count].fondo+' este asociado a una Cuenta. <br/>Revisar Metadatos (Cuenta Rezago) en Salesforce.';
                    MensajeErr = true;
                    system.debug('Break');
                    return;
                }
            }catch(Exception ex){
                system.debug('Error: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());
                p_Mensaje_error = 'Error al Aplicar los Rezagos en el Metodo: Aplicar. <br/>Error: ' + ex.getMessage() + '<br/>Linea: ' + ex.getLineNumber();
                MensajeErr = true;
            }
            
            apor.TipoSaldo = '13';
            Datetime dT = ListRezagos[count].fechaDeposito;
            apor.FechaDepositoAproba = Date.newinstance(dT.year(), dT.month(), dT.day());
            //apor.FechaDepositoAproba = Date.today()
            Date d= Date.today();
            Integer da = Date.today().Day();
            String dayf = String.valueOf(da);
            Integer mo = Date.today().Month();
            String monthf = String.valueOf(mo);
            Integer ye = Date.today().Year();
            String yearf = String.valueOf(ye);
            
            apor.p_periodo_aporte = yearf+monthf+dayf; 
            System.debug('Periodo aporte: '+apor.p_periodo_aporte);
            
            if(ListRezagos[count].codigoMoneda=='HNL'){
                apor.Moneda = '1';
            }else{
             	apor.Moneda = '2';   
            }
            apor.Monto = ListRezagos[count].montoRezago;  
            apor.ComisionSI = 'N';
            apor.rezago = 'S';
            system.debug('ResultadoEnviado: '+apor);
            
            classAportes_Conciliacion resultado = ControllerAPICONCILIACION.guardarAporte(apor);
            
            if(resultado.p_mensaje_error!='OK' && !Test.isRunningTest() ){
                correcto = false;
                p_Mensaje_error = 'Error al realizar el Aporte a la cuenta '+ apor.Cuenta +'. <br/>'+ resultado.p_mensaje_error;
                MensajeErr = true;
                return;
            }
        }
        if(correcto==true){
        	AplicarRezagoSI();
            llenartabla();
            system.debug('Se Aplico el Rezago');
        }
    }
    
    public void AplicarRezagoSI(){
        Try{
            String ValorCuota = ControllerApiRezagos.ConsultaCuotaSal();
            List <String> ValorCuotaStr = new List<String>();
            ValorCuotaStr = ValorCuota.split('},');
            
            ClassClientesRez rezagoEnvio = new ClassClientesRez();
            ListClientesRez = new List<ClientesRez>();
            if(ListRezagos.size()>0){
                for(Integer count=0;count<ListRezagos.size();count++){
                    AplicaRez = new ClientesRez('','','','','','','','','','','','','');
                    AplicaRez.idRezago = ListRezagos[count].idRezago;
                    AplicaRez.montoRezago = ListRezagos[count].montoRezago;
                    AplicaRez.fondo = ListRezagos[count].fondo;
                    AplicaRez.codReferencia = ListRezagos[count].codReferencia;
                    
                    List<Cuenta_Rezago__mdt> codigo = new List<Cuenta_Rezago__mdt>();
                    codigo = [select cuenta__c from Cuenta_Rezago__mdt where fondo__c =: AplicaRez.fondo limit 1];
                    if(codigo.size()>0){
                        AplicaRez.codCuenta = codigo[0].cuenta__c ;//Insertar el codigo de cuenta de FPC Rezagos
                    }
                    
                    AplicaRez.codPlanilla = null;
                    System.debug('Fondo: '+AplicaRez.fondo);
                    for(Integer count1=0;count1<ValorCuotaStr.size();count1++){
                        String rez = ValorCuotaStr[count1];
                        
                        ValorCuotaDia = rez.substringBeforeLast('}');
                        ValorCuotaDia = ValorCuotaDia.substringAfterLast(':');
                        
                        ValorCuotaFondo = rez.substringBeforeLast('",');
                        ValorCuotaFondo = ValorCuotaFondo.substringAfterLast('"');
                        
                        if(AplicaRez.fondo == ValorCuotaFondo){AplicaRez.valorCuotaEntrada=ValorCuotaDia;}                   
                    }
                    system.debug('Aplica a la cuenta: '+AplicaRez.codCuenta);
                    system.debug('Aplica el Valor Cuota: '+AplicaRez.valorCuotaEntrada);
                    
                    AplicaRez.valorCuotaSalida = '';
                    AplicaRez.estado = 'Pendiente';
                    AplicaRez.valAporteCalculado = '';
                    AplicaRez.montoParcialAplicado = '';
                    AplicaRez.montoPendienteAplicar = '';
                    List<User> usr = [Select Id, Name From User Where Id=:UserInfo.getUserId() Limit 1];
                    System.debug('User: '+usr[0].Name);
                    usuario = usr[0].Name;
                    AplicaRez.modificadoPor = usuario;
                    
                    ListClientesRez.add(AplicaRez);
                    ValorCuotaFondo='';
                    ValorCuotaDia='';
                }
                
                rezagoEnvio.clientes = ListClientesRez;
                rezagoEnvio.Tipo = 'AT';
                
                String Resultado = ControllerApiRezagos.AplicaRezagosDia(rezagoEnvio);
                
                if(Resultado == '"OK"'){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Rezagos Aplicados Correctamente. '));
                }else{
                    p_Mensaje_error = 'Error al Actualizar tabla Rezagos en Sysde. <br/>Metodo: AplicarRezagoSI';
                    MensajeErr = true;
                    return;
                }
            }else{
                p_Mensaje_error = 'No Hay Registros a Aplicar.';
                MensajeErr = true;
            }
        }catch(Exception ex){
            system.debug('Error: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());
            p_Mensaje_error = 'Error al Actualizar tabla Rezagos en Sysde <br/>Error: ' + ex.getMessage() + '<br/>Linea: ' + ex.getLineNumber();
            MensajeErr = true;
        }
    }
}