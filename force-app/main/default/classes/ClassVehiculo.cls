public class ClassVehiculo {
    
    public List<Vehiculo> listVehiculos {get;set;}
    public Vehiculo vehiculo {get;set;}
     public String vehiculoId {get;set;}
    public Boolean popNV {get;set;}
    
    public ClassVehiculo(){
        vehiculo = new Vehiculo();
        getVehiculos();
        popNV = false;
    }
    
    public void getVehiculos(){
        listVehiculos =  new List<Vehiculo>();
        for(Vehiculo__c item: [Select Name, Marca__c, Precio__c, Modelo__c, Existencia__c, Anio__c from Vehiculo__c]){
            Vehiculo v = new Vehiculo();
            v.id = item.Name;
            v.marca = item.Marca__c;
            v.modelo = item.Modelo__c;
            v.anio = item.Anio__c;
            v.existencia = item.Existencia__c;
            v.precio = item.Precio__c;
            v.idSF = item.id;
            listVehiculos.add(v);
        }
    }
    
     public void popEditar(){
         for(Vehiculo item : listVehiculos){
             if(item.id == vehiculoId){
                  vehiculo = item;
                 popVehiculo();
             }
         }
     }
    
     public void popVehiculo(){
         popNV = !popNV;
     }
    
    public void postVehiculos(){
        Vehiculo__c item = new Vehiculo__c();
        item.Marca__c =  vehiculo.marca;
        item.Modelo__c = vehiculo.modelo;
        item.Anio__c = vehiculo.anio;
        item.Existencia__c = vehiculo.existencia;
        item.Precio__c =  vehiculo.precio;
        insert item;
        vehiculo = new Vehiculo();
        getVehiculos();
        popNV = false;
    }
    
    public void putVehiculos(){
        Vehiculo__c item = new Vehiculo__c();
        item.Marca__c =  vehiculo.marca;
        item.Modelo__c = vehiculo.modelo;
        item.Anio__c = vehiculo.anio;
        item.Existencia__c = vehiculo.existencia;
        item.Precio__c =  vehiculo.precio;
        item.Id =  vehiculo.idSF;
        update item;
        vehiculo = new Vehiculo();
        getVehiculos();
        popNV = false;
    }
    
    public void deleteVehiculos(){
        Vehiculo__c item = new Vehiculo__c();
        item.Id = vehiculoId;
        delete item;
        vehiculo = new Vehiculo();
        getVehiculos();
        popNV = false;
    }
    
    public void getVehiculo(){
        listVehiculos =  new List<Vehiculo>();
        for(Vehiculo__c item: [Select Name, Marca__c, Precio__c, Modelo__c, Existencia__c, Anio__c from Vehiculo__c]){
            Vehiculo v = new Vehiculo();
            v.id = item.Name;
            v.marca = item.Marca__c;
            v.modelo = item.Modelo__c;
            v.anio = item.Anio__c;
            v.existencia = item.Existencia__c;
            v.precio = item.Precio__c;
            listVehiculos.add(v);
        }
    }
    
    public class Vehiculo {
        public String id {get;set;}
        public String idSF {get;set;}
        public String marca {get;set;}
        public String modelo {get;set;}
        public Decimal anio {get;set;}
        public Decimal existencia {get;set;}
        public Decimal precio {get;set;}
    }

}