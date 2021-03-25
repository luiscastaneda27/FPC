public class ControllerPromociones {

 public list<Lead> prospectos {get;set;}
     public Lead candidato {get;Set;}
   
    public boolean pop3 {get;Set;}
    public string nombrePersonaRefiere {get; set;}
    private RecordType natural;
    private map<id, Lead> mapProspectos;
    
    public List<SelectOption> options {get;set;}
    private string usuario;

    public Fantasma_portal__c fantasma{get;Set;}
    
    public ControllerPromociones(){
        candidato = new Lead();
        usuario = Apexpages.currentPage().getParameters().get('usuario');
        natural = [Select id From RecordType Where sObjectType = 'Lead' AND DeveloperName = 'Natural' Limit 1];
        pop3=true;
        candidato.Motivo_Contacto__c = 'Campaña HTML';
        //candidato.Motivo_Contacto__c = apexpages.;
        //[select Motivo_Contacto__c from Motivo_Contacto ];
            //opcionColonia = new list <selectOption>();
    }
     
    public pageReference guardarPop(){
        
        try{
            if(candidato.Phone.length() > 8 ){          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Teléfono Movil excede la cantidad de 8 caracteres permitidos'));
            return null;    
        }
        if(candidato.Telefono_Trabajo__c != null){
            if(candidato.Telefono_Trabajo__c.length() > 8 ){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Teléfono Trabajo excede la cantidad de 8 caracteres permitidos'));
                return null;
            }
        }
            if(candidato.Departamento__c  == 'N/A')
        {          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe Seleccionar un Departamento'));
            return null;
        }
        else   
        { 
            
        candidato.RecordTypeId = natural.id;
        candidato.status = 'En Proceso';
        candidato.Usuario_Referencia__c = usuario;
        candidato.LeadSource='Web';
        //candidato.Motivo_Contacto__c = 'Referido';
        //nombrePersonaRefiere +=' '+candidato.Description; 
        //candidato.Description = nombrePersonaRefiere;
        insert candidato;
        system.debug(candidato);  
        candidato = new Lead();
        pop3 = False;
          ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Datos guardados correctamente')); 
            
        reiniciar(); 
        }
        return null;//new pagereference('/apex/vfReferidos');
           //nombrePersonaRefiere = null; 
            //candidato.Description = null;
        }catch (exception e){
            system.debug(e.getLineNumber()+e.getMessage());
        }
        return null;
        
    }
    
    public void reiniciar()
     {          
    candidato.Motivo_Contacto__c = 'Referido';
    candidato.Departamento__c  = 'N/A';    
        
     }
    
    
}