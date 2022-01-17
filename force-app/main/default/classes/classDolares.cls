public class classDolares {
    public string cuentaOrigen {get;set;}
    public string cuentaDestino{get;set;}
    public string monto {get;set;}
    public string moneda { get; set;}
    public string detalle {get;set;}
    public string nivelUno {get;set;}
    public string nivelDos {get;set; }
    public string nivelTres {get;set;}
    public string nivelCuatro {get;set;}
    public string nivelCinco {get;set;}        
    
    
    public class classRespuestaDolares{
        public string id {get;set;}
        public string monedaOrigen {get; set;}
        public string monedaDestino {get;set;}
        public string montoDebitado {get;set;}
        public string montoAcreditado {get;set; }
        public string tasaCambio {get;set;}
    }
}