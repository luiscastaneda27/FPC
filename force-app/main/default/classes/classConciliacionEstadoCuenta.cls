public class classConciliacionEstadoCuenta {

     public date   FechaValor{get;set;} 
     public string Descripcion{get;set;} 
     public string Referencia{get;set;} 
     public date FechaPosteo{get;set;} 
     public Decimal Monto{get;set;} 
     public string Usuario_EC{get;set;} 
     public string Narrativa{get;set;} 
     public string TipoPlanilla {get;set;}
    
     public classConciliacionEstadoCuenta(date FechaValor, string Descripcion, string Referencia, date FechaPosteo, Decimal Monto,string Usuario_EC, string Narrativa, string TipoPlanilla)
    {
        this.FechaValor= FechaValor;
        this.Descripcion=Descripcion;
        this.Referencia=Referencia;
        this.FechaPosteo= FechaValor;
        this.Monto=Monto;
        this.Usuario_EC=Usuario_EC;
        this.Narrativa=Narrativa;
        this.TipoPlanilla =  TipoPlanilla;
    }

}