public class classCuenta {
    public string cliente{get;set;}
    public string cuenta{get;set;}
    public string producto{get;set;}
    public string subProducto{get;set;} 
    public string cuentaColectiva{get;set;}
    public Boolean cuentaActiva { get; set; }
    public string fondo{get;set;}
    public string fondoInversion{get;set;}
    public date fechaApertura{get;set;}
    
    public string tipoComision{get;set;}
    public string matrizComision{get;set;}
    public date fechaAporte{get;set;}
    public string frecuenciaAporte{get;set;}
    public string formaAporte{get;set;}
    public boolean seguroVida{get;set;}
    public string codigoBarra{get;set;}
}