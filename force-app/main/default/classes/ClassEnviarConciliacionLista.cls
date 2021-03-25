public class ClassEnviarConciliacionLista {
    
     public date   FechaValor{get;set;} 
     public string Descripcion{get;set;} 
     public string Referencia{get;set;} 
     public date FechaPosteo{get;set;} 
     public Decimal Monto{get;set;} 
     public string Narrativa{get;set;}  
    
    
   //Lista para mostrar los datos de beneficiarios
    public List<classConciliacionEstadoCuenta> ListEC {get;set;}

    public ClassEnviarConciliacionLista()
     {
        ListEC =new List<classConciliacionEstadoCuenta>(); 
      
     }

   //Lista para crear las partidas contables
   
  
  
    
}