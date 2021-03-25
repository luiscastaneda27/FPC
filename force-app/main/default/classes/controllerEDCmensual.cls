public class controllerEDCmensual {
	public list<classECMensual> datos{get;set;}
	
    public controllerEDCmensual() {
    		try{
                varurl urlDecode= new varurl();
                string url2 =ApexPages.currentPage().getParameters().get('zyx');
                string idCliente;
                if(url2 !=null && url2 !='')
                {
                    Blob d = EncodingUtil.base64Decode(url2);
                    urlDecode= (varurl)System.JSON.deserialize(d.tostring(), varurl.class);
                    
                    
                }
            idCliente=urlDecode.idcli;
	    	list<classClientesEC> claseEnvio = new list<classClientesEC>();
	        classClientesEC nueva = new classClientesEC();
			nueva.idCliente = idCliente;
			String fDesde = urlDecode.desde;
			if(fDesde != null && fDesde != 'null')
				nueva.Desde = date.valueOF(fDesde);
				
			String fHasta = urlDecode.hasta;
			if(fHasta != null && fHasta != 'null')
				nueva.hasta = date.valueOF(fHasta);
			claseEnvio.add(nueva);
						        
	        datos = EstadosDeCuenta.estadoCuentaMensual(claseEnvio);  
	        
	        list<Document> listDocumentos = [Select id,DeveloperName From Document 
													Where DeveloperName = 'EDCman' OR DeveloperName = 'EDCwoman'];
													
	        String urlPichingo = URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/servlet.ImageServer?id=';
			if(Datos[0].sexo == 'F'){
				urlPichingo += listDocumentos[1].id; 
			}else{
				urlPichingo += listDocumentos[0].id; 
			}
			urlPichingo += '&oid=' + UserInfo.getOrganizationId();
			
			
			Datos[0].urlPichingo = urlPichingo;	 
    		}Catch(Exception e){
    			Datos.add(new classECMensual());
    		}   
    }
    public class VarURL
    {
        public string idcli{get;set;}
        public string desde{get;set;}
        public string hasta{get;set;}
        
    }
}