public class ClassEnviarT24lista {
    
				public  List<classDatosPersonales> ListaDatosPersonales;
    			public  List<classInfoAportSeg> ListaInfogeneral;
    			public  List<classReferencias> ListaFinal;
    			public List<classEnviarBeneficiarioxCliente> BenxCliente {get;set;}
			
    public ClassEnviarT24lista(List<classDatosPersonales> ListaDatosPersonales, List<classInfoAportSeg> ListaInfogeneral,
                               List<classReferencias> ListaFinal,List<classEnviarBeneficiarioxCliente> BenxCliente){
       	this.ListaDatosPersonales= ListaDatosPersonales;
        this.ListaInfogeneral= ListaInfogeneral;
        this.ListaFinal=ListaFinal;	
        this.BenxCliente=BenxCliente;
    }
}