public class controllerAdminConstancias{
    private ApexPages.StandardController controller {get; set;}
    public List<SelectOption> listItemsCamposCaso {set;get;}
    public List<SelectOption> listItemsOtrosCamposCaso {set;get;}
    public List<SelectOption> listItemsRelacionesCaso {set;get;}
    public List<SelectOption> listCamposObjetoRelacionCaso {set;get;}
    public String campoSeleccionado {set;get;}
    public String otroCampoSeleccionado {set;get;}
    public Boolean htmlRequerido {set;get;}
    public String relacionSeleccionada {set;get;}
    public Boolean showModalCampos{set;get;}
    public Boolean mostrarRelaciones{set;get;}
    public List<wItemsTablaCamposRelacion> itemsCamposTabla {set;get;}
    public Integer ordenamientoActual {set;get;}
    public String funcionGenerada {set;get;}    
    private Static Map<String,Schema.SObjectType> gd;
       
    public controllerAdminConstancias(ApexPages.StandardController controller){
        this.controller = controller;
        this.showModalCampos = false;
        gd = Schema.getGlobalDescribe();        
        mostrarRelaciones = false;
        
        listItemsCamposCaso  = controllerAdminConstancias.getCamposCase('Case');        
        htmlRequerido = false;
        listItemsOtrosCamposCaso = controllerAdminConstancias.getOtrosCamposEspecialesCaso(); 
        listItemsRelacionesCaso =  controllerAdminConstancias.getRelacionesCase();        
        
        ordenamientoActual = 1;
    }
   
   public Static List<SelectOption> getCamposCase(String objecto){
         List<SelectOption> fields = new List<SelectOption>();                      
         gd = Schema.getGlobalDescribe();  
         Schema.SObjectType sobjType = gd.get(objecto);           
         Schema.DescribeSObjectResult r = sobjType.getDescribe();  
         Map<String,Schema.SObjectField> M = r.fields.getMap();  
              
         for(String fieldName : M.keyset()){  
               Schema.SObjectField field = M.get(fieldName);                                                      
               Schema.DescribeFieldResult fieldDesc = field.getDescribe(); 
               fields.add(new SelectOption(fieldName.toLowerCase(), M.get(fieldName).getDescribe().getLabel()));  
         }           
         
         fields.sort();
         return fields;  
   }
   //obtiene la lista de los nombres de objetos relacionados con case   
   public Static List<SelectOption> getRelacionesCase(){
       List<SelectOption> items = new List<SelectOption>();     
       Schema.DescribeSObjectResult r = Case.SObjectType.getDescribe();
       List<Schema.ChildRelationship> c = r.getChildRelationships(); 
       
       for(Schema.ChildRelationship rel: c){
           system.debug(rel.getChildSObject());
           if(rel.getRelationshipName() != null){                                            
               items.add(new SelectOption(rel.getChildSObject().getDescribe().getName(), rel.getChildSObject().getDescribe().getLabel()));
           }    
       }       
       
       return items;
   } 
   
   public Static List<Schema.ChildRelationship> relacionesCaso(){
       Schema.DescribeSObjectResult r = Case.SObjectType.getDescribe();
       List<Schema.ChildRelationship> listRelaciones = r.getChildRelationships(); 
       
       return listRelaciones;
   }
   
   public Static List<SelectOption> getCamposRelacionesCase(String descripcioncampoRelacion){
       List<SelectOption> lista;
       
       if(descripcioncampoRelacion != null){           
           if(descripcioncampoRelacion.contains('__r')){
               descripcioncampoRelacion = descripcioncampoRelacion.replace('__r', '__c');               
               system.debug(descripcioncampoRelacion);
           }
           lista = controllerAdminConstancias.getCamposCase(descripcioncampoRelacion);           
           return lista;    
       }else{
           ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,'Ocurrio un error inesperado');
           ApexPages.addMessage(msg);          
           return null;
       }     
   }
   
   public static List<SelectOption> getOtrosCamposEspecialesCaso(){
        List<SelectOption> camposEspeciales = new List<SelectOption>();                    
        camposEspeciales.add(new SelectOption('getDirigidoA', 'Dirigido A:'));
        camposEspeciales.add(new SelectOption('getIdentificacionCliente', 'Identificación cliente:'));
        camposEspeciales.add(new SelectOption('getCuentaCliente', 'Cuenta cliente:')); 
        camposEspeciales.add(new SelectOption('getFechaRealizacionAporte', 'Fecha realización aporte:')); 
        camposEspeciales.add(new SelectOption('getSaldoExtraordinario', 'Saldo extraordinario:')); 
        camposEspeciales.add(new SelectOption('getSaldoOrdinario', 'Saldo Ordinario:'));
        camposEspeciales.add(new SelectOption('getSaldoCompromiso', 'Saldo de compromiso:'));
        camposEspeciales.add(new SelectOption('getPeriodoActividad', 'Periodo de actividad de cuenta:'));
        camposEspeciales.add(new SelectOption('getAportaciones', 'Aportaciones:'));
        camposEspeciales.add(new SelectOption('getListaCuentas', 'Lista de cuentas:'));
        camposEspeciales.add(new SelectOption('getSaldo', 'Saldo general:'));
        camposEspeciales.add(new SelectOption('getFirma', 'Firma SAC:')); 
        camposEspeciales.add(new SelectOption('getHoyLetras', 'Fecha de Hoy en Letras (Ej: 1 de Enero de 2012)'));  
        camposEspeciales.add(new SelectOption('getHoy', 'Fecha de Hoy(Ej: 1/10/2012)'));      
        camposEspeciales.add(new SelectOption('getNombreGenerador', 'Usuario Generador'));  
        return camposEspeciales ;
    }       
    
   public void onchangeCampoRelacionSelecionado(){
       if(relacionSeleccionada != null ){
           system.debug(relacionSeleccionada);
           listCamposObjetoRelacionCaso = controllerAdminConstancias.getCamposRelacionesCase(relacionSeleccionada);//itemsCamposTabla
           itemsCamposTabla = new List<wItemsTablaCamposRelacion>();
           for(SelectOption option: listCamposObjetoRelacionCaso){
               itemsCamposTabla.add(new wItemsTablaCamposRelacion(option)); 
           }
           showModalCamposObjeto();
       }
   }
   
   public void showModalCamposObjeto(){
        showModalCampos = true;   
   }
   
   public void aceptarCamposSeleccionado(){
       itemsCamposTabla = ordenarLista(itemsCamposTabla);
       ordenamientoActual = 0;
       crearFuncion();
       showModalCampos = false;
       
   }  
   
   public void cancelarCamposSeleccionado(){
       showModalCampos = false;
   }
   
   public void actualizarOrdenamiento(){
       
       system.debug(ordenamientoCampo);
       for(wItemsTablaCamposRelacion item: itemsCamposTabla){
           if(item.Id.getValue() == ordenamientoCampo){   
               if(item.seleccionado){
                   item.ordenamiento = ordenamientoActual;
                   ordenamientoActual += 1;
               }else if(item.ordenamiento != -1){
                   ordenamientoActual = ordenamientoActual - 1;
                   item.ordenamiento = -1;
               }       
           }           
       }       
   }
   
   public String ordenamientoCampo{
        get;
        
        set{
           ordenamientoCampo=value;
        
        }
   }
    
   public List<wItemsTablaCamposRelacion> ordenarLista(List<wItemsTablaCamposRelacion> lista){
         wItemsTablaCamposRelacion temp;
                  
         for(Integer i=0; i < lista.size() ; i++){
             for(Integer j=i+1; j < lista.size(); j++){
                  if(lista[j].ordenamiento < lista[i].ordenamiento){
                      temp = lista[j];
                      lista[j] = lista[i];    
                      lista[i] = temp;
                  }   
             }
         }  
         
         return lista;
   } 
   
   public void crearFuncion(){
       funcionGenerada = 'Funcion_' + relacionSeleccionada + '(';
       Integer count = 1;
       for(wItemsTablaCamposRelacion item: itemsCamposTabla){
           count += 1;
           if(item.seleccionado){
               if(count <= itemsCamposTabla.size()){
                   funcionGenerada += item.Id.getValue() + ',';               
               }else{
                   funcionGenerada += item.Id.getValue();               
               }               
           }
       }  
       
                   
       funcionGenerada += ');';
       
   }
   
   public class wItemsTablaCamposRelacion{
       public Boolean seleccionado {set;get;}
       public SelectOption Id {set;get;}
       public Integer ordenamiento {set;get;}
       
       public wItemsTablaCamposRelacion(SelectOption Id){
           this.seleccionado = false;
           this.Id = Id;
           this.ordenamiento = -1;
       }
   }
  
}