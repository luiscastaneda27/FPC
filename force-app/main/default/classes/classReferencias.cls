public with sharing class classReferencias {

//*******************************Informacion de referencias**********************************************************************
                public string primerNomRef {get;set;}                
                public string segundoNomRef {get;set;}
                public string primerApeRef {get;set;}
                public string segundoApeRef {get;set;}                
                public string telefonoRef {get;set;}
    			
    			public string primerNomRef2 {get;set;}                
                public string segundoNomRef2 {get;set;}
                public string primerApeRef2 {get;set;}
                public string segundoApeRef2 {get;set;}                
                public string telefonoRef2 {get;set;}
 //************************Completacion de informacion de empleado*******************************************************************
                public string cargo {get;set;}
                public string lugarNacimiento {get;set;}
                public string nomConyuge {get;set;}
    			public string usuario {get;set;}


    
    public classReferencias (String primerNomRef, String segundoNomRef, String primerApeRef, 
                                  String segundoApeRef, String telefonoRef,String primerNomRef2, 
                                  String segundoNomRef2, String primerApeRef2, 
                                  String segundoApeRef2, String telefonoRef2, String cargo, 
                                  String lugarNacimiento, String nomConyuge,string usuario){
        		this.primerNomRef = primerNomRef;                
                this.segundoNomRef = segundoNomRef;
                this.primerApeRef = primerApeRef;
                this.segundoApeRef = segundoApeRef;                
                this.telefonoRef = telefonoRef;
                this.primerNomRef2 = primerNomRef2;                
                this.segundoNomRef2 = segundoNomRef2;
                this.primerApeRef2 = primerApeRef2;
                this.segundoApeRef2 = segundoApeRef2;                
                this.telefonoRef2 = telefonoRef2;
                this.cargo = cargo;
                this.lugarNacimiento = lugarNacimiento;
                this.nomConyuge = nomConyuge;
                this.usuario = usuario;
    }    
                                    			
}