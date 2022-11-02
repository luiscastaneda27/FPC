public class ControladorProyeccionConsolidado {
    
    public Proyeccion__c proyeccion {get;set;}
    public List<ProyeccionConsolidado> listProyeccionCons {get;set;}
    public List<ProyeccionDetallado> listProyeccionDetall {get;set;}
    public String piePaginaIzquierdo{get;set;}
    public String medidaWith{get;set;}
    public DatoGrafico grafico{get;set;}
    
    
    
    public List<ProyeccionDetalladoMostrar> listDetalladoShow {get;set;}
    
    
    public ControladorProyeccionConsolidado(ApexPages.StandardController controller) {
        try{
            proyeccion = [Select Id, AporteInicial__c, AporteMensual__c, ComisionAporte__c, ComisionSaldo__c, 
                          CurrencyIsoCode, Rendimiento__c,anios__C, EsComisionPorAporte__c 
                          from Proyeccion__c Where Id=:controller.getId()];
            grafico = new DatoGrafico();
            piePaginaIzquierdo = system.now().addHours(0).format() +' || '+userInfo.getName();
            medidaWith = proyeccion.Anios__c == '5' ? '100' : proyeccion.Anios__c == '10' ? '170' : proyeccion.Anios__c == '15' ? '240' : proyeccion.Anios__c == '20' ? '310' : '380';
            datetime l;
            listProyeccionCons = new List<ProyeccionConsolidado>();
            listProyeccionDetall = new List<ProyeccionDetallado>();
            listDetalladoShow = new List<ProyeccionDetalladoMostrar>();
            
            Date fecha = Date.today().addMonths(1);
            Map<Integer, Decimal> mapInteres = new Map<Integer, Decimal>();
            Map<Integer, Decimal> mapComision = new Map<Integer, Decimal>();
            Decimal interesAcum = 0;
            Decimal comisionAcum = 0;
            Integer redondeo = 4;
             List<ProyeccionDetallado> listTemporal = new List<ProyeccionDetallado>();
            for(Integer i=1; i<= Integer.valueOf(proyeccion.anios__C) * 12; i++){
                ProyeccionDetallado proyecc = new ProyeccionDetallado();
                
                
                proyecc.mes = mesLetras(fecha.month()) + '-'+mesLetras(mapInteres.size() + 1);
                proyecc.num = i;
                
                proyecc.aporteOrdinario = proyeccion.AporteMensual__c.setsCale(redondeo);
                proyecc.comisionAporteOrdinario = (proyeccion.AporteMensual__c  * proyeccion.ComisionAporte__c / 100).setscale(redondeo);
                proyecc.aporteExtraordinario = 0;
                proyecc.comisionAporteExtraordinario = 0;
                if(i == 1){
                    proyecc.aporteExtraordinario = proyeccion.AporteInicial__c.setsCale(redondeo);
                    proyecc.comisionAporteExtraordinario = (proyeccion.AporteInicial__c  * proyeccion.ComisionAporte__c / 100).setscale(redondeo);
                }
                proyecc.comisionPorSaldo = 0.00;
                if(!Proyeccion.EsComisionPorAporte__c){
                    if(i > 1){
                        proyecc.comisionPorSaldo = ((listProyeccionDetall[i-2].saldo + proyecc.aporteExtraordinario + proyecc.aporteOrdinario - proyecc.comisionAporteExtraordinario - proyecc.comisionAporteOrdinario) * proyeccion.ComisionSaldo__c / 1200).setscale(redondeo);
                    }else{
                        proyecc.comisionPorSaldo = (((proyecc.aporteExtraordinario + proyecc.aporteOrdinario - proyecc.comisionAporteExtraordinario - proyecc.comisionAporteOrdinario) * proyeccion.ComisionSaldo__c) / 1200).setscale(redondeo);
                    }
                    comisionAcum += proyecc.comisionPorSaldo; 
                }
                proyecc.gastoTotal = (proyecc.comisionAporteExtraordinario + proyecc.comisionAporteOrdinario + proyecc.comisionPorSaldo).setscale(redondeo);
                proyecc.ACIC = (proyecc.aporteOrdinario + proyecc.aporteExtraordinario - proyecc.gastoTotal).setscale(redondeo);
                
                proyecc.interesReal = (proyecc.ACIC * proyeccion.Rendimiento__c / 1200).setscale(redondeo) ;
                proyecc.saldo = (proyecc.interesReal + proyecc.ACIC).setscale(redondeo);
                proyecc.rentabilidad = (proyecc.interesReal - proyecc.gastoTotal).setscale(redondeo);
                if(i > 1){
                    proyecc.interesReal = ((proyecc.ACIC + listProyeccionDetall[i-2].saldo) * proyeccion.Rendimiento__c / 1200).setscale(redondeo) ;
                    proyecc.saldo = (proyecc.interesReal + proyecc.ACIC + listProyeccionDetall[i-2].saldo).setscale(redondeo);
                    proyecc.rentabilidad = (proyecc.interesReal - proyecc.gastoTotal + listProyeccionDetall[i-2].rentabilidad).setscale(redondeo);
                }
                interesAcum += proyecc.interesReal;
                proyecc.flujos = -(proyecc.aporteExtraordinario + proyecc.aporteOrdinario).setscale(redondeo);
                
                proyecc.comisionAcumulada = (proyecc.gastoTotal).setscale(redondeo);
                proyecc.aporteAcumulado = (proyecc.aporteExtraordinario + proyecc.aporteOrdinario).setscale(redondeo);
                proyecc.interesAcumulado = (proyecc.interesReal).setscale(redondeo);
                if(i > 1){
                    proyecc.comisionAcumulada += (listProyeccionDetall[i-2].comisionAcumulada).setscale(redondeo);
                    proyecc.aporteAcumulado += (listProyeccionDetall[i-2].aporteAcumulado).setscale(redondeo);
                    proyecc.interesAcumulado += (listProyeccionDetall[i-2].interesAcumulado).setscale(redondeo);
                }
                
                
                proyecc.mAporteOrdinario = formatoNumero((proyecc.aporteOrdinario).setscale(2));
                proyecc.mComisionAporteOrdinario = formatoNumero((proyecc.comisionAporteOrdinario).setscale(2));
                proyecc.mAporteExtraordinario = formatoNumero((proyecc.aporteExtraordinario).setscale(2));
                proyecc.mComisionAporteExtraordinario = formatoNumero((proyecc.comisionAporteExtraordinario).setscale(2));
                proyecc.mComisionPorSaldo = formatoNumero((proyecc.comisionPorSaldo).setscale(2));
                proyecc.mGastoTotal = formatoNumero((proyecc.gastoTotal).setscale(2));
                proyecc.MACIC = formatoNumero((proyecc.ACIC).setscale(2));
                proyecc.mInteresReal = formatoNumero((proyecc.interesReal).setscale(2));
                proyecc.mSaldo = formatoNumero((proyecc.saldo).setscale(2));
                proyecc.mRentabilidad = formatoNumero((proyecc.rentabilidad).setscale(2));
                proyecc.mFlujos = formatoNumero((proyecc.flujos).setscale(2));
                proyecc.mComisionAcumulada = formatoNumero((proyecc.comisionAcumulada).setscale(2));
                proyecc.mAporteAcumulado = formatoNumero((proyecc.aporteAcumulado).setscale(2));
                proyecc.mInteresAcumulado = formatoNumero((proyecc.interesAcumulado).setscale(2));
                
                listProyeccionDetall.add(proyecc);
                listTemporal.add(proyecc);
                fecha = fecha.addMonths(1);
                if(math.mod(i, 12) == 0){
                    mapInteres.put((Integer)(i/12) , interesAcum.setScale(2) );
                    mapComision.put((Integer)(i/12) , ComisionAcum.setScale(2) );
                }
                if((listTemporal.size() == 35 && listDetalladoShow.size() == 0) ||
                   math.mod(listTemporal.size(), 47) == 0 ||
                   (Integer.valueOf(proyeccion.anios__C) * 12) == i){
                       ProyeccionDetalladoMostrar v = new ProyeccionDetalladoMostrar();
                       v.listProyDetallado = listTemporal;
                       v.cortePagina = 'page-break-after:always;';
                       listDetalladoShow.add(v);
                       listTemporal = new List<ProyeccionDetallado>();
                       if(Integer.valueOf(proyeccion.anios__C) * 12 == i){
                           listDetalladoShow[listDetalladoShow.size() - 1].cortePagina = '';
                       }
                   }
                
            }
            //Decimal comision = Proyeccion.EsComisionPorAporte__c ? proyeccion.ComisionAporte__c : proyeccion.ComisionSaldo__c;
            for(Integer i=1; i<= Integer.valueOf(proyeccion.anios__C); i++){
                ProyeccionConsolidado proyecc = new ProyeccionConsolidado();
                proyecc.anio = i;
                proyecc.aporte = (proyeccion.AporteInicial__c + (i * proyeccion.AporteMensual__c * 12)).setscale(2);
                
                if(Proyeccion.EsComisionPorAporte__c){
                    proyecc.comision = (proyecc.aporte  * proyeccion.ComisionAporte__c / 100).setscale(2);
                }else{
                    proyecc.comision =   mapComision.get(i).setscale(2);
                }
                
                
                proyecc.interes = mapInteres.get(i).setscale(2);
                if( i > 1){
                    //proyecc.interes += mapInteres.get(i-1).setscale(2);
                }
                proyecc.saldo = (proyecc.aporte - proyecc.comision + proyecc.interes).setscale(2);
                proyecc.capitaizacion = (proyecc.saldo / proyecc.aporte).setscale(2);
                
                if(Proyeccion.EsComisionPorAporte__c && proyeccion.AporteMensual__c == 0 && i > 1){
                    proyecc.Maporte = formatoNumero(0);
                    proyecc.Mcomisison = formatoNumero(0);
                }else{
                    proyecc.Maporte = proyecc.Maporte = formatoNumero(proyecc.aporte);
                    proyecc.Mcomisison = formatoNumero(proyecc.comision);
                }
                
                proyecc.Minteres = formatoNumero(proyecc.interes);
                proyecc.Msaldo = formatoNumero(proyecc.saldo);
                proyecc.Mcapitaizacion = formatoNumero(proyecc.capitaizacion);
                
                listProyeccionCons.add(proyecc);
            }
            calculoGrafico();
        }catch(Exception ex){
            System.debug('Error:'+ex.getMessage()+ ', Linea: '+ex.getLineNumber());
        }
    }
    
    
     public void calculoGrafico(){
        try{
            
            //List<String> anios = new List<String>();
            List<String> aniosPuntoEqui = new List<String>();
            List<Decimal> aportes = new List<Decimal>();
            List<Decimal> intereses = new List<Decimal>();
            List<Decimal> interesesPuntoEqui = new List<Decimal>();
            List<Decimal> comisiones = new List<Decimal>();
            
            aniosPuntoEqui.add('0');
            comisiones.add(0);
            interesesPuntoEqui.add(0);
            
            
            String aporte = 't:';
            String rendimiento = '';
            String coma = '';
            grafico.anios = '';

            
            for(Integer i=4; i<listProyeccionCons.size(); i= i+ 5){
                aporte += coma+String.valueOf(listProyeccionCons[i].aporte);
                rendimiento += coma+ String.valueOf(listProyeccionCons[i].interes);
                grafico.anios += '|'+(i + 1);
                coma = ',';
                grafico.maximoGrafico1 = String.valueOf(listProyeccionCons[i].saldo * 1.1);
            }
            grafico.datosGrafico1 = aporte + '|'+rendimiento;
            
            grafico.meses = '|0';
            
            String interes = '0,';
            String comision = listProyeccionDetall[0].comisionAcumulada.setsCale(2)+',';
             
            coma = '';
            
            for(Integer i=1; i<37; i++){
                
                if( listProyeccionDetall[i].comisionAcumulada > listProyeccionDetall[i].interesAcumulado 
                   && listProyeccionDetall[i+1].comisionAcumulada < listProyeccionDetall[i+1].interesAcumulado ){
                       Decimal interesDiario = (listProyeccionDetall[i + 1].interesAcumulado - listProyeccionDetall[i].interesAcumulado) / 30;
                       Decimal comisionDiaria = (listProyeccionDetall[i + 1].comisionAcumulada - listProyeccionDetall[i].comisionAcumulada) / 30;
                       Decimal diaReal = 0;
                       for(Integer j = 1; j<=30; j++){
                           if((listProyeccionDetall[i].interesAcumulado + (interesDiario * j)) > (listProyeccionDetall[i].comisionAcumulada + (comisionDiaria * j))){
                               diaReal = (j * 3.33) / 100;
                               break;
                           }
                       }
                       
                       grafico.puntoy = String.valueOf((listProyeccionDetall[i].interesAcumulado / (listProyeccionDetall[33].interesAcumulado * 1.05)).setsCale(3));
                       grafico.puntox = String.valueOf(((Decimal.valueOf(listProyeccionDetall[i].num) + diaReal) / 36.0).setsCale(3));
                       grafico.datosPunto = '&chm=@o,095aab,0,' + grafico.puntox + ':' + grafico.puntoy + ',8';
                   }
                
                if(Math.mod(i, 2) > 0){
                    interesesPuntoEqui.add(listProyeccionDetall[i].interesAcumulado.setsCale(2));
                    comisiones.add(listProyeccionDetall[i].comisionAcumulada.setsCale(2));
                    aniosPuntoEqui.add(String.valueOf(i + 1));
                    
                    
                    interes +=coma+String.valueOf(listProyeccionDetall[i].interesAcumulado.setsCale(2));
                    comision +=coma+String.valueOf(listProyeccionDetall[i].comisionAcumulada.setsCale(2));
                    grafico.meses +='|'+(i+1);
                    coma = ',';
                    if(listProyeccionDetall[i].interesAcumulado > listProyeccionDetall[i].comisionAcumulada){
                        grafico.maximoGrafico2 = String.valueOf((listProyeccionDetall[i].interesAcumulado )*1.0);
                    }else{
                        grafico.maximoGrafico2 = String.valueOf((listProyeccionDetall[i].comisionAcumulada)*1.0);
                    }
                }
                
            }
            grafico.datosGrafico2 = comision + '|'+interes;
        }catch(Exception ex){
            System.debug('----Error:'+ex.getMessage()+ ', Linea: '+ex.getLineNumber());
        }
    }
    
    
    
    public static string formatoNumero (decimal numero) {
        numero = numero !=null ? numero :0;
        string respuesta='0';
        string numerodecimal='.00';
        try {
            numero = numero.setScale(2);
            respuesta='';
            integer numeroEntero = (integer) numero;
            respuesta = numeroEntero.format();
            if(numeroEntero < numero){
                decimal a = (integer)((numero - numeroEntero)*100);
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
    
    
    public static string mesLetras (Integer numeroMes) {
        string mes = String.valueOf(numeroMes).leftPad(2, '0');
            /*
        if(numeroMes == 1){
            mes = 'Ene';
        }else if(numeroMes == 2){
            mes = 'Feb'; 
        }else if(numeroMes == 3){
            mes = 'Mar'; 
        }else if(numeroMes == 4){
            mes = 'Abr'; 
        }else if(numeroMes == 5){
            mes = 'May'; 
        }else if(numeroMes == 6){
            mes = 'Jun'; 
        }else if(numeroMes == 7){
            mes = 'Jul'; 
        }else if(numeroMes == 8){
            mes = 'Ago'; 
        }else if(numeroMes == 9){
            mes = 'Sep'; 
        }else if(numeroMes == 10){
            mes = 'Oct'; 
        }else if(numeroMes == 11){
            mes = 'Nov'; 
        }else if(numeroMes == 12){
            mes = 'Dic'; 
        }*/
        return mes;
    }
    
    public class ProyeccionConsolidado{
        Public Integer anio {get;set;}
        Public Decimal aporte {get;set;}
        Public Decimal comision {get;set;}
        Public Decimal saldo {get;set;}
        Public Decimal interes {get;set;}
        Public Decimal capitaizacion {get;set;}
        
        Public String Maporte {get;set;}
        Public String Mcomisison {get;set;}
        Public String Msaldo {get;set;}
        Public String Minteres {get;set;}
        Public String Mcapitaizacion {get;set;}
    }
    
    public class ProyeccionDetalladoMostrar{
        public List<ProyeccionDetallado> listProyDetallado{get;set;}
        public String cortePagina{get;set;}
    }
    
    public class ProyeccionDetallado{
        Public String mes {get;set;}
        Public Integer num {get;set;}
        Public Decimal aporteOrdinario {get;set;}
        Public Decimal aporteExtraordinario {get;set;}
        Public Decimal comisionAporteOrdinario {get;set;}
        Public Decimal comisionAporteExtraordinario {get;set;}
        Public Decimal comisionPorSaldo {get;set;}
        Public Decimal gastoTotal {get;set;}
        Public Decimal ACIC {get;set;}
        Public Decimal interesReal {get;set;}
        Public Decimal saldo {get;set;}
        Public Decimal rentabilidad {get;set;}
        Public Decimal flujos {get;set;}
        Public Decimal comisionAcumulada {get;set;}
        Public Decimal aporteAcumulado {get;set;}
        Public Decimal interesAcumulado {get;set;}
        
        
        Public String mAporteOrdinario {get;set;}
        Public String mAporteExtraordinario {get;set;}
        Public String mComisionAporteOrdinario {get;set;}
        Public String mComisionAporteExtraordinario {get;set;}
        Public String mComisionPorSaldo {get;set;}
        Public String mGastoTotal {get;set;}
        Public String MACIC {get;set;}
        Public String mInteresReal {get;set;}
        Public String mSaldo {get;set;}
        Public String mRentabilidad {get;set;}
        Public String mFlujos {get;set;}
        Public String mComisionAcumulada {get;set;}
        Public String mAporteAcumulado {get;set;}
        Public String mInteresAcumulado {get;set;}
        
    }
    
    
    public class DatoGrafico{
        public String datosGrafico1{get;set;}
        public String anios{get;set;}
        public String maximoGrafico1{get;set;}
        
        public String datosGrafico2{get;set;}
        public String meses{get;set;}
        public String maximoGrafico2{get;set;}
        public String puntoX{get;set;}
        public String puntoY{get;set;}
        public String datosPunto{get;set;}
    }
    
}