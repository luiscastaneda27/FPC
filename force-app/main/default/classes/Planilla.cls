public class Planilla {
    public string Num_Identidad{get;set;} 
    public list<cuenta> CuentasAPV{get;set;}
    public list<cuenta> CuentasAEV{get;set;}
    //agregado wp 28-10-2019
    public list<cuenta> CuentasAPE{get;set;}
    public list<cuenta> CuentasAPX{get;set;}
    public list<cuenta> CuentasASV{get;set;}
    //
    public string Primer_Nombre{get;set;}
    public string Segundo_Nombre{get;set;}
    public string Primer_Apellido{get;set;}
    public string Segundo_Apellido{get;set;}
    
    public Decimal Salario{get;set;}
    public Decimal APO{get;set;}
    public Decimal AEO{get;set;}
    public Decimal APV{get;set;}
    public Decimal AEV{get;set;}
    //agregado wp 28-10-2019
    public Decimal APE{get;set;}
    public Decimal APX{get;set;}
    public Decimal ASV{get;set;}
    //
    public Decimal Reserva_Laboral{get;set;}
    public string A{get;set;}
    public string B{get;set;}
    public string C{get;set;}
    public string id_cambiarSalario{get;set;}
    public Decimal Nuevo_Salario{get; set;}
    public Integer bandera{get; set;}
    public string RTN{get; set;}
    public string Num_Patronal{get; set;}
    public string Fecha_Cambio{get; set;}
    public string Fecha_Planilla{get; set;}
    date Fecha_Actual=date.today();
    public Decimal APO1{get;set;}
    public Decimal AEO1{get;set;}
    public Decimal Reserva_Laboral1{get;set;}
    Public date Planilla_Aprobada{get;set;}
    public string ColorAPO{get; set;}
    public string ColorAEO{get; set;}
    public string ColorRL{get; set;}
     public string Num_cuenta{get; set;}
     public string IdSalesforce{get; set;}
    
    //IHSS
     public Planilla(string id,string rtn,string NP,string Ident, string PN, string SN,string PA,string SA, date fecha ,
                     string tipo,Decimal Salario, Decimal APO,  Decimal AEO, Decimal APV,Decimal AEV, 
                     /*agregado wp 28-10-2019 */Decimal APE, Decimal APX,Decimal ASV,/**/ Decimal Reserva_Laboral){
        this.RTN=rtn;
        this.Num_Patronal=NP;                
        this.Num_Identidad=Ident;
        this.Primer_Nombre=PN;
        this.Segundo_Nombre=SN;
        this.Primer_Apellido=PA;
        this.Segundo_Apellido=SA;
        this.Salario=Salario;
        this.Fecha_cambio=string.valueOf(fecha);
        this.A=tipo;
        this.APO=APO;
        THIS.AEO=AEO;
        THIS.APV=APV;
        THIS.AEV=AEV;
        //agregado wp 28-10-2019
        this.APE=APE;
        this.APX=APX;
        this.ASV=ASV;
        //
        THIS.Reserva_Laboral=Reserva_Laboral;                 
         if(date.today().month()<10){
             this.Fecha_Planilla=date.today().year()+'-0'+date.today().month()+'-01';
         }else{
            this.Fecha_Planilla=date.today().year()+'-'+date.today().month()+'-01'; 
         }
         
       this.id_cambiarSalario=id;
                
    }
    
    
    
    public planilla(string identidad, string cuenta, decimal APV, decimal AEV, decimal APE, decimal APX, decimal ASV, string idsalesforce)
    {
        this.Num_identidad=identidad;
        this.Num_cuenta= cuenta;
        this.apv=apv;
        this.aev=aev;
        this.apv=ape;
        this.aev=apx;
        this.apv=asv;
        this.idsalesforce=idsalesforce;
    }
    
    
    
    
    //Principal
    public Planilla(string Ident, string PN, string SN,string PA,string SA, Decimal Salario, Decimal APO,
                    Decimal AEO, Decimal APV,Decimal AEV, /*agregado wp 28-10-2019 */Decimal APE, Decimal APX,Decimal ASV,/**/
                    Decimal Reserva_Laboral, list<cuenta> cuentapatrono, list<cuenta> cuentaempleado, 
                   	//agregado wp 28-10-2019 
                    list<cuenta> cuentaempleadoExtraordinario, list<cuenta> cuentapatronoExtraordinario, list<cuenta> cuentaSeguroVida
                    /**/){
        this.Num_Identidad=Ident;
        this.Primer_Nombre=PN;
        this.Segundo_Nombre=SN;
        this.Primer_Apellido=PA;
        this.Segundo_Apellido=SA;
        this.Salario=Salario;
        this.APO=APO;
        THIS.AEO=AEO;
        THIS.APV=APV;
        THIS.AEV=AEV;
        //agregado wp 28-10-2019
        this.APE=APE;
        this.APX=APX;
        this.ASV=ASV;
        //
        THIS.Reserva_Laboral=Reserva_Laboral;
        this.A='A';
        this.B='B';
        this.C='C';
        CuentasAPV = new list<Cuenta>();
        CuentasAPV = cuentapatrono;
        CuentasAEV = new list<Cuenta>();
        CuentasAEV = cuentaempleado;
        //agregado wp 28-10-2019                
        CuentasAPE = new list<Cuenta>();
        CuentasAPE = cuentaempleadoExtraordinario;
        CuentasAPX = new list<Cuenta>();
        CuentasAPX = cuentapatronoExtraordinario;
        CuentasASV = new list<Cuenta>();
        CuentasASV = cuentaSeguroVida;
        //                 
        
    }
    
    
    
      //Principal
    public Planilla(string Ident, string PN, string SN,string PA,string SA, Decimal Salario, Decimal APO,
                    Decimal AEO, Decimal APV,Decimal AEV, /*agregado wp 28-10-2019 */Decimal APE, Decimal APX,Decimal ASV,/**/
                    Decimal Reserva_Laboral, list<cuenta> cuentapatrono, list<cuenta> cuentaempleado, 
                    //agregado wp 28-10-2019 
                    list<cuenta> cuentaempleadoExtraordinario, list<cuenta> cuentapatronoExtraordinario, list<cuenta> cuentaSeguroVida,
                    /**/string colorapo, string coloraeo, string colorrl){
        this.Num_Identidad=Ident;
        this.Primer_Nombre=PN;
        this.Segundo_Nombre=SN;
        this.Primer_Apellido=PA;
        this.Segundo_Apellido=SA;
        this.Salario=Salario;
        this.APO=APO;
        THIS.AEO=AEO;
        THIS.APV=APV;
        THIS.AEV=AEV;
        //agregado wp 28-10-2019
        this.APE=APE;
        this.APX=APX;
        this.ASV=ASV;
        //
        THIS.Reserva_Laboral=Reserva_Laboral;
        this.A='A';
        this.B='B';
        this.C='C';
        CuentasAPV = new list<Cuenta>();
        CuentasAPV=cuentapatrono;
        CuentasAEV = new list<Cuenta>();
        CuentasAEV = cuentaempleado;
        //agregado wp 28-10-2019 
        CuentasAPE = new list<Cuenta>();
        CuentasAPE = cuentaempleadoExtraordinario;
        CuentasAPX = new list<Cuenta>();
        CuentasAPX = cuentapatronoExtraordinario;
        CuentasASV = new list<Cuenta>();
        CuentasASV = cuentaSeguroVida;
        //
        this.colorAPO=colorapo;
        this.colorAEO=coloraeo;
        this.colorRL=colorRL;
        
    }
    
    
    
    
     //Principal cargar planilla
    public Planilla(string Ident, string PN, string SN,string PA,string SA, Decimal Salario, Decimal APO,
                    Decimal AEO, Decimal APV,Decimal AEV, /*agregado wp 28-10-2019 */Decimal APE, Decimal APX,Decimal ASV,/**/
                    Decimal Reserva_Laboral, string cuenta){
        this.Num_Identidad=Ident;
        this.Primer_Nombre=PN;
        this.Segundo_Nombre=SN;
        this.Primer_Apellido=PA;
        this.Segundo_Apellido=SA;
        this.Salario=Salario;
        this.APO=APO;
        THIS.AEO=AEO;
        THIS.APV=APV;
        THIS.AEV=AEV;
        //agregado wp 28-10-2019
        this.APE=APE;
        this.APX=APX;
        this.ASV=ASV;
        //
        THIS.Reserva_Laboral=Reserva_Laboral;
        this.A=cuenta;
        
        
    }
    
    //Principal cargar planilla
    public Planilla(string Ident, string PN, string SN,string PA,string SA, Decimal Salario, Decimal APO,
                    Decimal AEO, Decimal APV,Decimal AEV, /*agregado wp 28-10-2019 */Decimal APE, Decimal APX,Decimal ASV,/**/
                    Decimal Reserva_Laboral){
        this.Num_Identidad=Ident;
        this.Primer_Nombre=PN;
        this.Segundo_Nombre=SN;
        this.Primer_Apellido=PA;
        this.Segundo_Apellido=SA;
        this.Salario=Salario;
        this.APO=APO;
        THIS.AEO=AEO;
        THIS.APV=APV;
        THIS.AEV=AEV;
        //agregado wp 28-10-2019
        this.APE=APE;
        this.APX=APX;
        this.ASV=ASV;
        //
        THIS.Reserva_Laboral=Reserva_Laboral;
        
    }
   
     //Principal cargar planilla
    public Planilla(string Ident, string PN, string SN,string PA,string SA,Decimal Salario, Decimal APO,
                    Decimal AEO, Decimal APV,Decimal AEV, /*agregado wp 28-10-2019 */Decimal APE, Decimal APX,Decimal ASV,/**/
                    string cuenta, Decimal Reserva_Laboral){
        this.Num_Identidad=Ident;
        this.Primer_Nombre=PN;
        this.Segundo_Nombre=SN;
        this.Primer_Apellido=PA;
        this.Segundo_Apellido=SA;
        this.Salario=Salario;
        this.APO=APO;
        THIS.AEO=AEO;
        THIS.APV=APV;
        THIS.AEV=AEV;
        //agregado wp 28-10-2019
        this.APE=APE;
        this.APX=APX;
        this.ASV=ASV;
        //               
        THIS.Reserva_Laboral=Reserva_Laboral;
        this.a=cuenta;
    }
    
    
    
    
     //calculo de Pilares
    public Planilla(string Ident, string PN, string SN,string PA,string SA, Decimal Salario, Decimal APO,
                    Decimal AEO, Decimal APV,Decimal AEV, /*agregado wp 28-10-2019 */Decimal APE, Decimal APX,Decimal ASV,/**/
                    Decimal Reserva_Laboral,decimal cf,decimal de, decimal fe){
        this.Num_Identidad=Ident;
        this.Primer_Nombre=PN;
        this.Segundo_Nombre=SN;
        this.Primer_Apellido=PA;
        this.Segundo_Apellido=SA;
        this.Salario=Salario;
        this.APO=APO;
        THIS.AEO=AEO;
        THIS.APV=APV;
        THIS.AEV=AEV;
        //agregado wp 28-10-2019
        this.APE=APE;
        this.APX=APX;
        this.ASV=ASV;
        //
        THIS.Reserva_Laboral=Reserva_Laboral;
        this.APO1=cf;
        THIS.AEO1=de;
        THIS.Reserva_Laboral1=fe;
    }
    
     public Planilla(Decimal APO, Decimal AEO, Decimal APV,Decimal AEV, /*agregado wp 28-10-2019 */Decimal APE, Decimal APX,Decimal ASV,/**/ 
                     Decimal Reserva_Laboral){
       
        this.APO=APO;
        THIS.AEO=AEO;
        THIS.APV=APV;
        THIS.AEV=AEV;
        //agregado wp 28-10-2019
        this.APE=APE;
        this.APX=APX;
        this.ASV=ASV;
        //
        THIS.Reserva_Laboral=Reserva_Laboral;
       
        
    }
    
     public Planilla(string Num_Identidad,Decimal APO, Decimal AEO, Decimal APV,Decimal AEV, /*agregado wp 28-10-2019 */Decimal APE, Decimal APX,Decimal ASV,/**/ Decimal Reserva_Laboral){
       
        this.Num_Identidad=Num_Identidad;
        this.APO=APO;
        THIS.AEO=AEO;
        THIS.APV=APV;
        THIS.AEV=AEV;
        //agregado wp 28-10-2019
        this.APE=APE;
        this.APX=APX;
        this.ASV=ASV;
        //
        THIS.Reserva_Laboral=Reserva_Laboral;
       
        
    }
    
    public string rezago{get;set;}
    public string codigoReferencia{get;set;}
    public string Monto_Calculado{get;set;}//Para los Rezagos
    //Planillas Aprobadas
    Public Planilla(string id, string PN, date fecha, string tipo ,Decimal total,string PA,string SA, string moneda, string rezago, string codReferencia, string Monto_Calculado)
    {
        this.id_cambiarSalario=id;
        this.Primer_Nombre=PN;
        this.Planilla_Aprobada=fecha;
        this.segundo_Nombre=tipo;
        this.Salario=total;
        this.Primer_Apellido=PA;
        this.Segundo_Apellido=SA;
        this.a=moneda;
        this.rezago = rezago;
        this.codigoReferencia = codReferencia;
        this.Monto_Calculado = Monto_Calculado;
        this.APO=0.0;
    }
    
     //Cambio de salario
    public Planilla(string id,string Ident, string PN, string SN,string PA,string SA, Decimal Salario, Decimal Nuevo_Salario){
        this.Num_Identidad=Ident;
        this.Primer_Nombre=PN;
        this.Segundo_Nombre=SN;
        this.Primer_Apellido=PA;
        this.Segundo_Apellido=SA;
        this.Salario=Salario;
        this.Nuevo_Salario=Nuevo_Salario;
        this.id_cambiarSalario=id;
        
    }
    
    public planilla(string de, string dee, date fecha, string fr, decimal vf, string cd, string vfc)
    {}
     public Planilla(string Ident, integer u){
        this.Num_Identidad=Ident;
        this.bandera=u;
        
    }
    
    public Planilla(string Ident, integer u, string cuenta){
        this.Num_Identidad=Ident;
        this.bandera=u;
        this.a=cuenta;
        
    }
    
     
    public Planilla(string Ident, integer u, decimal apo1, decimal apo2,decimal apo3,decimal apo4,
                    /*agregado wp 28-10-2019 */Decimal apo6, Decimal apo7,Decimal apo8,/**/
                    decimal apo5)
    {
        this.Num_Identidad=Ident;
        this.bandera=u;
        this.apo=apo1;
        this.aeo=apo2;
        this.apv=apo3;
        this.aev=apo4;
        //agregado wp 28-10-2019
        this.APE=apo6;
        this.APX=apo7;
        this.ASV=apo8;
        //
        this.reserva_laboral=apo5;
        
    }
    
    
}