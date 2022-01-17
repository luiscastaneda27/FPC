public class claseColaboradores {

    
    public string firstname{get;set;}
    public string id{get;set;}
    public string Lastname{get;set;}
    public string Estado_Civil{get;set;}
    public decimal salario{get;set;}
    public string PersonBirthdate{get;set;}
    public string tipo_Identificacion{get;set;}
    public string Identificacion{get;set;}
    public string Mostarfecha{get;set;}
    list<string> fechas;
    public string idcliente{get;set;}
    
    
    public claseColaboradores(string id,string tipoIden, string ident ,string nombres, string apellidos, date fecha, string estado, decimal salario, string cliente)
    {
        try{
            this.id=id;
            this.idcliente=cliente;
            if(tipoIden=='1')
            {
               this.tipo_Identificacion ='CEDULA DE IDENTIDAD'; 
            }
            else if (tipoIden=='2')
             {
               this.tipo_Identificacion ='CARNET DE RESIDENTE'; 
            }   
            else if (tipoIden=='4')
             {
               this.tipo_Identificacion ='PASAPORTE'; 
            }   
            ELSE
            {
              this.tipo_Identificacion  =tipoIden.toUpperCase();
            }
            
            
            
            this.Identificacion = ident;
            this.firstname=nombres;
            this.lastname=apellidos;
            this.PersonBirthdate =string.valueOf(fecha);
            this.Estado_Civil= estado;
            this.salario = salario;
            
            if(estado.toUpperCase()=='S')
            {
                this.Estado_Civil='SOLTERO';
            }
            else if(estado.toUpperCase()=='C')
            {
                this.Estado_Civil='CASADO';
            }
            else if(estado.toUpperCase()=='V')
            {
                this.Estado_Civil='VIUDO';
            }
             else if(estado.toUpperCase()=='D')
            {
                this.Estado_Civil='DIVORCIADO';
            }
            else if(estado.toUpperCase()=='U')
            {
                this.Estado_Civil='UNIÓN LIBRE';
            }
             else 
            {
                this.Estado_Civil=estado.toUpperCase();
            }
            
           if(PersonBirthdate != null && PersonBirthdate.trim() !='' )
            {
                fechas = new list<string>();
                fechas = PersonBirthdate.split('-');
                Mostarfecha=fechas[2]+'/'+fechas[1]+'/'+fechas[0];
            }
            else
            {
               Mostarfecha=''; 
            } 
            
            
            
        } catch(Exception ex)
        {
            Mostarfecha='';
        }
        
    }
    
    
    
}