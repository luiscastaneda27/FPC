public class controlTransacciones {
    public string numeroAfiliado{get;set;}
    public string nombreAfiliado{get;set;}
    public Transaccion__c nTransaccion{get;set;}
    
    public boolean noEncontrado {get;set;}
    
    public string paso1Cabeza{get;set;}
    public string paso1Cuerpo{get;set;}
    
    public string paso2Cabeza{get;set;}    
    public string paso2Cuerpo{get;set;}
    
    public controlTransacciones(){                       
        iniciar();
    }
    
    public void iniciar(){
        numeroAfiliado = '';
        nombreAfiliado = '';
        nTransaccion = new Transaccion__c();
        nTransaccion.Monto__c = 0;
            
        paso1Cabeza = 'slds-is-current';
        paso1Cuerpo = 'slds-show';
        
        paso2Cabeza = 'slds-is-incomplete';
        paso2Cuerpo = 'slds-hide';
        
        noEncontrado = false; 
        
    }
    
    public string buscarAfiliado(){
        try{
            noEncontrado = false;
            numeroAfiliado = numeroAfiliado.replace('-','');
            numeroAfiliado = numeroAfiliado.replace(' ','');
                      
            Account cliente = [Select Id,Name, Activo__c From Account 
                                    Where Identificacion__c =: numeroAfiliado OR Codigo_de_Barra__c =: numeroAfiliado Limit 1];
            
            if(cliente.Activo__c){                        
	            nombreAfiliado = cliente.Name;
	            
	            nTransaccion.Cliente__c = cliente.Id;
	            nTransaccion.Comercio_Afiliado__c = ApexPages.currentPage().getParameters().get('IdComercio');
	            nTransaccion.Fecha_hora_Transaccion__c = system.now();
	            nTransaccion.currencyIsoCode = 'HNL';
	            nTransaccion.Descuento__c = ApexPages.currentPage().getParameters().get('idDescuento');
	            nTransaccion.Usuario_portal__c = ApexPages.currentPage().getParameters().get('idUsuario');
	            
	            paso1Cabeza = 'slds-is-complete';
	            paso1Cuerpo = 'slds-hide';
	            
	            paso2Cabeza = 'slds-is-current';
	            paso2Cuerpo = 'slds-show';
	            
            }else{
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no Activo'));	
            }
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no encontrado'));
        }
        return null;
    }
    
    public void cerrar(){
        noEncontrado = false;
    }
    
    public void guardar(){
        try{
            insert nTransaccion;
            noEncontrado = true;
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'Transacción guardada correctamente!'));
        }catch(System.DmlException e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getDmlMessage(0)));
        }
    
    }   
}