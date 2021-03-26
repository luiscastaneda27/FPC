public class ControllerPantallaConsultaRezagos {
    
    public list<clientes> ListRezagos {get;set;}//Guarda los datos de la tabla de rezagos
    Public List<ClaseRezagos> MuestraRezagos {get;set;}//Guarda los datos a mostrar en la VF
    public String ValorCuotaDia {get;set;}
    public String ValorCuotaFondo {get;set;}
    
    public string Usuario {get;set;}
    public Integer Total {get;set;}
    
    public List<ClientesRez> ListClientesRez {get;set;}
    public ClientesRez AplicaRez{get;set;}
    
    public ControllerPantallaConsultaRezagos(){
		Usuario =  ApexPages.currentPage().getParameters().get('hytrd');
        llenartabla();
    }
    
    public void llenartabla(){
        String consulta = null;
        String resultado = ControllerApiRezagos.ConsultaRezagos(consulta);
        if(test.isRunningTest()){
            resultado='{"clientes":[{"idRezago":"SF-135","montoRezago":"40","fondo":"106","codReferencia":"FT20prueba4","fechaDeposito":"27-SEP-20","codigoMoneda":"USD","descripcion":"Transferencia entre Cuentas","descripcionNota":"Transferencia de la cuenta XX4156 de CRISTINA BANEGAS ZEITUN    100110 VENTA $","usuIngresaRezago":"HN02913","codBanco":"28","agnBanco":"AGN PRINCIPAL TGU","rezagoSINO":"NO","asesor":"HN23213","estado":"Pendiente","valorCuotaEntrada":"127.52636724","fecInclusion":"01-OCT-20","incluidoPor":"System","fecModificacion":"08-OCT-20","modificadoPor":"HN02913","montoPendienteAplicar":""}]}';
        }
        List<String> resultado2 = resultado.split('},');
        ListRezagos = new List<clientes>();
		List<String> resultado3;
        if(resultado2.size()>=1 && resultado!='{"clientes":[]}'){
            for(Integer count=0;count<resultado2.size();count++ ){
                resultado3 = resultado2[count].split(',');
                clientes Rezago = new clientes('',null,'','',null,'','','','','','','','','','',null,'',null,'');
                String rez='';
                rez = resultado3[0].substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                Rezago.idRezago = rez;// Agrego el id Rezago
                
                rez = resultado3[1].substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                Rezago.montoRezago = rez;// Agrego el Monto
                
                rez = resultado3[2].substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                Rezago.fondo = rez;//Agrego el Fondo
                
                rez = resultado3[3].substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                Rezago.codReferencia = rez;//Agrego el codigo de referencia
                system.debug('Codigo de Referencia: '+Rezago.codReferencia);
                
                rez = resultado3[4];
                system.debug('Dato desde Sysde: '+rez);
                rez = rez.substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                rez = rez.replace('-', '/');
                string datecomplete = dateconvert(rez);
                
                try{Rezago.fechaDeposito = DateTime.valueOf(datecomplete);}catch(exception ex){Rezago.fechaDeposito=null;}
                system.debug('Fecha Deposito: '+Rezago.fechaDeposito);
                
                rez = resultado3[5].substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                Rezago.codigoMoneda = rez;//Agrego la Moneda
                
                rez = resultado3[6].substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                Rezago.descripcion = rez;//Agrego la Descripcion
                
                rez = resultado3[7].substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                Rezago.descripcionNota = rez;//Agrego la Descripcion Nota
                
                rez = resultado3[8].substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                Rezago.usuIngresaRezago = rez;//Agrego el usuario que ingresa el rezago
                
                rez = resultado3[9].substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                Rezago.codBanco = rez;//Agrego el codigo de banco
                
                rez = resultado3[10].substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                Rezago.agnBanco = rez;//Agrego la Agencia del Banco
                
                rez = resultado3[11].substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                Rezago.rezagoSINO = rez;//Agrego Rezago SI / NO
                
                rez = resultado3[12].substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                Rezago.asesor = rez;// Agrego el Asesor
                
                rez = resultado3[13].substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                Rezago.estado = rez;//Agrego el Estado
                
                rez = resultado3[14].substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                Rezago.valorCuotaEntrada = rez;//Agrego la cuota de entrada
                
                rez = resultado3[15];
                rez = rez.substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                datecomplete = dateconvert(rez);
                try{Rezago.fecInclusion = Datetime.valueOf(datecomplete);}catch(exception ex){Rezago.fecInclusion=null;}
                
                rez = resultado3[16].substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                Rezago.incluidoPor = rez;//Agrego el Incluido Por
                
                rez = resultado3[17];
                rez = rez.substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                datecomplete = dateconvert(rez);
                try{Rezago.fecModificacion = Datetime.valueOf(datecomplete);}catch(exception ex){Rezago.fecModificacion=null;}
                
                rez = resultado3[18].substringBeforeLast('"');
                rez = rez.substringAfterLast('"');
                Rezago.modificadoPor = rez;//Agrego el Modificado Por
                if(Rezago.rezagoSINO!='SI' && Rezago.rezagoSINO!='Si'){
                	ListRezagos.add(Rezago);
                }
            }
            Total=listRezagos.size();
            mostrardatos();
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Tabla Vacia'));
        }        
    }
    
    public string dateconvert(String Datet){
        string dateday = Datet.substringBefore('/');
        string datemonth = Datet.substringBetween('/');
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
        string dateyear = Datet.substringAfterLast('/');
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
            
            dato.Fondo=ListRezagos[count].fondo;//OK
            dato.Cod_referencia=ListRezagos[count].codReferencia;//OK
            
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
            dato.Usu_ing_Rezago=ListRezagos[count].usuIngresaRezago;
            
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
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'ERROR   :   Verifique que el fondo '+ListRezagos[count].fondo+
                                                               ' este asociado a una Cuenta (REVISAR: Metadatos en Salesforce).'));
                    correcto=false;
                    system.debug('Break');
                    break;
                }
            }catch(Exception ex){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Verifique que el fondo este asociado a una Cuenta. :'+
                                                           ListRezagos[count].fondo+' - '+ListRezagos[count].codReferencia));
            }
            
            apor.TipoSaldo = '13';
            Datetime dT = ListRezagos[count].fechaDeposito;
            apor.FechaDepositoAproba = Date.newinstance(dT.year(), dT.month(), dT.day());
            //apor.FechaDepositoAproba = Date.today();
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
            //System.debug(count);
        }
        if(correcto==true){
        	AplicarRezagoSI();
            llenartabla();
            system.debug('Se Aplico Rezago');
        }
    }
    
    public void AplicarRezagoSI(){
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
                AplicaRez.modificadoPor = Usuario;
                
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
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Ha ocurrido un ERROR. :'+Resultado));
            }
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Hay Registros a Aplicar. '));
        }
    }
}