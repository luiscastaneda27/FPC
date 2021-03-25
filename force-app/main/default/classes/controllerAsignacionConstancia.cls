public class controllerAsignacionConstancia {
    public Asignacion_constancia__c Config{get;set;}
       
    public List<Asignacion_constancia__c> asignaciones {get;Set;}  
    private map<string, string> mapAsignacion;
    private integer conteo;
    public integer registroS{get;Set;}
    private List<Asignacion_constancia__c> listEliminar {get;Set;}  
    
    public controllerAsignacionConstancia(){
        config = new Asignacion_constancia__c();
        conteo = 0;
        registroS = 0;
               
        asignaciones = new List<Asignacion_constancia__c>();
        listEliminar = new List<Asignacion_constancia__c>();
        mapAsignacion = new map<string, string>();       
            
        asignaciones = [Select Tipo_registro_Caso__c,Carta__c,Constancia__c From Asignacion_constancia__c ]; 
        For(Asignacion_constancia__c item : asignaciones){
            mapAsignacion.put(item.tipo_registro_caso__c + item.Carta__c, item.Carta__c);
            item.Indice__c = conteo;
            conteo ++;   
        }     
    }
    
    public void agregar(){

            if(!mapAsignacion.containskey(config.Tipo_registro_Caso__c + config.Constancia__c)){
                Asignacion_constancia__c nueva = new Asignacion_constancia__c();   
                nueva.Carta__c = config.Constancia__c;
                nueva.indice__c = conteo;
                nueva.Tipo_registro_Caso__c = config.Tipo_registro_Caso__c;
                asignaciones.add(nueva);
                
                conteo ++;
                mapAsignacion.put(config.Tipo_registro_Caso__c + config.Constancia__c , config.Constancia__c);
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Constancia ya asignada'));
            }        
    }
    
    public void eliminar(){
          Asignacion_constancia__c esta =  asignaciones[registroS];
          if(esta.id != null) 
              listEliminar.add(esta);  
          mapAsignacion.remove(esta.Name); 
          asignaciones.remove(registroS);
    }
    
    public pageReference guardar(){
        try{
            upsert asignaciones;
            if(!listEliminar.isEmpty())
                Delete listEliminar;
                
            listEliminar = new List<Asignacion_constancia__c>();
           
            return new pageReference('/apex/vfConfigConstanciasPDF');
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Ocurrió un error inesperado, contacte con su Administrador'));
            return null;
        }
    }
   
}