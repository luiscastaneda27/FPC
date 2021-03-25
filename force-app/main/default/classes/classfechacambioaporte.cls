public with sharing class classfechacambioaporte {
    public string codCuenta {get;set;}
    public double nummov {get;set;}
    public string tSaldo {get;set;}
    public double montoPago {get;set;}
    public string SubProducto {get;set;}
    public string descrip {get;set;}
    public date nuevafecha {get; set;}
    public string nombre {get; set;}
    public string codProd {get; set;}
    public string num_doc {get; set;}
    public string observaciones {get; set;}
    public string referencia {get;set;}
    public Blob referenciaImg {get;set;}
    public  List<classfechacambioaporte> ListFechaAct {get;set;}

    public classfechacambioaporte ()  {
        
        ListFechaAct  = new List <classfechacambioaporte> ();
    }  
    //public classfechacambioaporte (string codCuenta ,date fechaporte){
       // this.codCuenta=codCuenta;
         //this.numovimto=numovimto;
        // this.tipsaldo=tipsaldo;
      //  this.fechaporte=fechaporte;
       // this.montopago=montopago;
        //this.subproduct=subproduct;
        //his.numdoc=numdoc;

        //list<classfechacambioaporte>listfechaporte  = new List<classfechacambioaporte>();
    
   // }
   
}