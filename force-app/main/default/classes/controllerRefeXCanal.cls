public class controllerRefeXCanal {
	public list<Lead> prospectos {get;set;}
    public Lead candidato {get;Set;}
   	public boolean bloquearAgencia;
    public boolean pop3 {get;Set;}
    public boolean bloq2 {get;Set;}
    public string nombrePersonaRefiere {get; set;}
    public string canalr {get; set;}
    public string agenciar {get; set;}
    
    private RecordType natural;
    private map<id, Lead> mapProspectos;
    
    
    private string usuario;
    
    public Fantasma_portal__c fantasma{get;Set;}
    
    public controllerRefeXCanal(){
        candidato = new Lead();
        usuario = Apexpages.currentPage().getParameters().get('usuario');
        natural = [Select id From RecordType Where sObjectType = 'Lead' AND DeveloperName = 'Natural' Limit 1];
        pop3=true;
        candidato.Motivo_Contacto__c = 'Referido';
        canal();
        agencia();
        bloq2=true;
    }
    
    
 
    public pageReference guardarPop(){
        
        try{
        	if (candidato.FirstName == null || candidato.FirstName == '')
         	{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe indicar los nombres del Referido'));
                return null;
            }
            
            if (candidato.LastName == null || candidato.LastName == '')
         	{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe indicar los apellidos del Referido'));
                return null;
            }
            
            if (candidato.Phone == null)
         	{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe indicar un Teléfono Movil'));
                return null;
            }
            
            if (candidato.Phone != null)
            {
               if(candidato.Phone.length() > 8)
                 {          
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Teléfono Movil excede la cantidad de 8 caracteres permitidos'));
                    return null;  
                 }
                 else if(candidato.Phone.length() < 8){
                     ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Teléfono Movil no debe ser menor de 8 caracteres'));
                    return null;  
                 } 
            }
            if(candidato.Telefono_Trabajo__c != null)
            {
                if(candidato.Telefono_Trabajo__c.length() > 8 )
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Teléfono Trabajo excede la cantidad de 8 caracteres permitidos'));
                    return null;
                }
                else if(candidato.Telefono_Trabajo__c.length() < 8)
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Teléfono Trabajo no debe ser menor de 8 caracteres'));
                    //return null;  
                }
            }
        
            if(candidato.Departamento__c  == 'N/A')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe Seleccionar un Departamento'));
                return null;
            }
            
            if(canalr  == '--Ninguno--' || canalr  == ' --Ninguno-- ')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe Seleccionar un Canal que Refiere'));
                return null;
            }
            
            if(canalr  == 'Agencias')
            {     
                if (agenciar  == ' --Ninguno-- ' || agenciar  == '--Ninguno--')
                {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe Seleccionar una Agencia que Refiere'));
                	return null;
                } 
            }
            
            if(candidato.Description == null || candidato.Description == '')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe indicar código de Empleado que Refiere'));
                return null;
            }
            
            if(candidato.Referido_por__c == null||candidato.Referido_por__c == '')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe indicar Nombre de Empleado que Refiere'));
                return null;
            }
            
            if(candidato.Correo_Empleado_Ficohsa__c == null||candidato.Correo_Empleado_Ficohsa__c == '')
            {          
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Debe indicar correo de Empleado que Refiere'));
                return null;
            }
            
        else   
        {    
            candidato.RecordTypeId = natural.id;
            candidato.Canal_que_Refiere__c = canalr;
            if (canalr != 'Agencias')
            {
                candidato.LeadSource='Web';
                candidato.Agencia_Refiere__c = null;
            }
            else
            {
                candidato.LeadSource='Agencias Banco';
                candidato.Agencia_Refiere__c = agenciar;
            }
            candidato.status = 'En Proceso';
            
            candidato.Usuario_Referencia__c = usuario;
            
            candidato.Motivo_Contacto__c = 'Referido';
            //nombrePersonaRefiere +=' '+candidato.Description; 
            //candidato.Description = nombrePersonaRefiere;
            insert candidato;
            system.debug(candidato);  
            candidato = new Lead();
            pop3 = False;
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Datos guardados correctamente'));      
            //return null;//new pagereference('/apex/vfReferidos');
            reiniciar(); 
         }
           //nombrePersonaRefiere = null; 
            //candidato.Description = null;
            //
           
        }catch (exception e){
            system.debug(e.getLineNumber()+e.getMessage());
        }
        return null;
    }
    
    public list <selectOption> listCanal {get; set;}
    public void canal(){
		listCanal = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Lead.Canal_que_Refiere__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>(); 
        listCanal.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
     		listCanal.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    
    public list <selectOption> listAgencia {get; set;}
    public void agencia(){
		listAgencia = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Lead.Agencia_Refiere__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        //system.debug(fieldResult.getPicklistValues());
        map<string, string> mapisv= new map<string, string>(); 
        listAgencia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
     		listAgencia.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }

    
    public void reiniciar()
     {      
         
    candidato.Motivo_Contacto__c = 'Referido';
    candidato.Departamento__c  = 'N/A';    
         canalr = '--Ninguno--';
         agenciar = '--Ninguno--';
         bloq2 = true;
        
     }
    
    public void DesbAgen() 
    {
        bloquearAgencia=false;
        
    }
 
	public void BloqAgen()
    {
		if (canalr == 'Agencias')
        {
			bloq2=false;
               
        }
        else 
        {   
        	bloq2=true;
            agenciar = '--Ninguno--';
             //pcNombreConyuge = ''; 
        }    
	}
         

}