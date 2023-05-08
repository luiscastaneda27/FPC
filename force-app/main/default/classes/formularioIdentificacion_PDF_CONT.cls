public class formularioIdentificacion_PDF_CONT {
    public ClienteNaturales info{get;set;}    
   
    public String tel {get;set;}
    public String telD {get;set;}
    public String telRes {get;set;} 
    public string telTrab {get;set;}
    public Decimal extTrab {get;set;}
    public String dir {get;set;}
    public String depto {get;set;}
    public String mun {get;set;}
    public String col {get;set;}
    public String pais {get;set;} 
    public String P {get;set;}
    public string PFis {get;set;}
    public string PFisNacionalidad {get;set;}    
    public String De {get;set;}
    public String Mu {get;set;}
    public String Co {get;set;}
    public string Nac {get;set;}
    public string Nac2 {get;set;}
    public string Nac3 {get;set;}
    public datetime fechaForm {get;set;}
    public string fechanacimientoB{get;set;}
    public String fechanacimientoDiaB{get;set;}
    public String fechanacimientoMesB{get;set;}
    public String fechanacimientoAnioB{get;set;}
    public String checkPEP {get;set;}
    public String V_Cargo_Pulbico {get;set;}
	public String V_periodoPep {get;set;}
	public String V_institucionPep {get;set;}
    
    /*public string pcUsuarioCN {get;set;}
    public string pcAGN {get;set;}
    public string pcUsuNombreCN {get;set;}*/
    
    public String dirEm {get;set;}
    public String deptoEm {get;set;}
    public String munEm {get;set;}
    public String colEm {get;set;}
    public String paisEm {get;set;}
    
    public String fechaVencimiento{get;set;}
    public String fechaVencimientoDia{get;set;}
    public String fechaVencimientoMes{get;set;}
    public String fechaVencimientoAnio{get;set;}
    public String fechanacimiento{get;set;}
    public String fechanacimientoDia{get;set;}
    public String fechanacimientoMes{get;set;}
    public String fechanacimientoAnio{get;set;}
    public String inicioDia{get;set;}
    public String inicioMes{get;set;}
    public String inicioAnio{get;set;}
    public String suscripcionDia{get;set;}
    public String suscripcionMes{get;set;}
    public String suscripcionAnio{get;set;}
    public String cuenta{get;set;}
    public String contra {get;set;}
    public String contraD {get;set;}
    public String contraS {get;set;}
    public String direct {get;set;}
    public Integer nacionalidades{get;set;}
    public CPAWP cpa{get;set;}
    public Decimal comiSaldo {get;set;}
    public Decimal comiAporte {get;set;}
    
    public String anio {get;set;}
    
    public formularioIdentificacion_PDF_CONT(){   
        fechaform= date.today();
        try{
            nacionalidades=0;
            cuenta = ApexPages.currentPage().getParameters().get('codigoCuenta');
            anio = String.valueOf(Date.today().Year()).right(2);
            ClienteNaturales fcsd = controllerApiClienteNatural.ConsultaInfoClienteC(cuenta);
            String JsonString;
            if (!test.isRunningTest()){
                JsonString = JSON.serialize(fcsd);//ApexPages.currentPage().getParameters().get('JSONString');
            }
            else{
                JsonString = ApexPages.currentPage().getParameters().get('JSONString'); 
            }
            String securityToken =ApexPages.currentPage().getParameters().get('securityToken');
            system.debug('securityToken en PDF: '+securityToken);
            if (securityToken != null){
                Afiliacion_Electronica__c JSONStringV = [Select Json_Cliente__c, Info_Cliente__c From Afiliacion_Electronica__c  Where Token__c =:securityToken];
                JsonString = JSONStringV.Info_Cliente__c;
                System.debug('JsonString en PDF del objeto: '+JSONStringV.Info_Cliente__c);
            }
            System.debug('JsonString en PDF: '+JsonString);
            
            JsonString=JsonString.replaceAll('"null"', '" "');
            System.debug('JsonString en PDF: '+JsonString);
            info=(ClienteNaturales)JSON.deserialize(JsonString, ClienteNaturales.class);
            
            V_Cargo_Pulbico = '';
			V_periodoPep = '';
			V_institucionPep = '';
            
            /*Inicio cargo politico**/
            checkPEP = 'N';
                IF ((info.pcPEP =='N' || info.pcEjerce_Cargo_Publico =='N')||info.pcPEP == 'null'||info.pcPEP == null 
                    ||info.pcEjerce_Cargo_Publico == 'null'||info.pcEjerce_Cargo_Publico == null)
                {
                    checkPEP = 'N';
                }
                else
                {
                    checkPEP = 'S';
                    V_Cargo_Pulbico = info.Cargo_Pulbico;
                    V_periodoPep = info.institucionPep;
                    V_institucionPep = info.periodoPep;
                }  
                if (info.Cargo_Pulbico != 'null' && info.Cargo_Pulbico != 'N/A' && info.Cargo_Pulbico != null && info.Cargo_Pulbico != ' ')
                {
                    checkPEP = 'S';
                    V_Cargo_Pulbico = info.Cargo_Pulbico;
                    V_periodoPep = info.institucionPep;
                    V_institucionPep = info.periodoPep;
                }
            /*FIN cargo politico**/
            System.debug('checkPEP FINN: '+checkPEP);
            
            if(!(info.ListBeneficiarios!=null && info.ListBeneficiarios.size()>0)){
                List<beneficiario> ltem=new List<beneficiario>();
                for(Integer i=0;i<info.ListBeneficiarios.size();i++) {
                   ltem.add(new beneficiario(null, ' ', ' ',' ', ' ', ' ',' ',' ', ' ',' ',' ',' ', ' ',null, null, null));    
                                    }
                info.ListBeneficiarios=ltem;
            }
            
           /* for(integer i=0; i<info.ListBeneficiarios.size(); i++)
            {
                if(info.ListBeneficiarios[i].fechaNacimiento !=null){
                    info.ListBeneficiarios[i].fechaNacimiento= info.ListBeneficiarios[i].fechaNacimiento.addHours(6);
                    fechanacimientoB=(info.ListBeneficiarios[i].fechaNacimiento.day()<10 ? '0'+info.ListBeneficiarios[i].fechaNacimiento.day() : info.ListBeneficiarios[i].fechaNacimiento.day()+'')+'-'+(info.ListBeneficiarios[i].fechaNacimiento.month()<10 ? '0'+info.ListBeneficiarios[i].fechaNacimiento.month() : info.ListBeneficiarios[i].fechaNacimiento.month()+'')+'-'+info.ListBeneficiarios[i].fechaNacimiento.year();
                   /* fechanacimientoDiaB=String.valueOf(info.ListBeneficiarios[i].fechaNacimiento.day());
                    fechanacimientoMesB=String.valueOf(info.ListBeneficiarios[i].fechaNacimiento.month());
                    fechanacimientoAnioB=String.valueOf(info.ListBeneficiarios[i].fechaNacimiento.year());
                }
            }*/                 
            system.debug('Beneficiarios' + info.ListBeneficiarios);
            
            if(!(info.ListDebidaDil!=null&&info.ListDebidaDil.size()>0)){
                List<claseDebidaDilContratista> ltem=new List<claseDebidaDilContratista>();
                for(Integer i=0;i<2;i++){
                    ltem.add(new claseDebidaDilContratista(null, ' ', ' ',' ',' ', ' ',' ',' ',null, ' '));
                }
                info.ListDebidaDil=ltem;
                contra = 'N';
                
            }else{
                contra = 'S';
            }
                              
            for(integer i=0; i<info.ListDebidaDil.size(); i++)
            {
                if(info.ListDebidaDil[i].tipoContrDirecto == 'S'||info.ListDebidaDil[i].tipoContrDirecto =='N')
                {
                    ContraD = info.ListDebidaDil[i].tipoContrDirecto;
                    if(info.ListDebidaDil[i].tipoContrSubcontratado == 'S' ||info.ListDebidaDil[i].tipoContrSubcontratado =='N' )
                    {  ContraS = info.ListDebidaDil[i].tipoContrSubcontratado;}
                    //}               
                }
            }
            system.debug('contratistaEstado: ' + contra +' Directo: '+ ContraD +' Sub: '+ ContraS);    
            system.debug('depende no ' + info.pcDependeNO + 'depende si'+ info.pcDependeSI); 
            system.debug('esResidente ' + info.ES_Residente); 
            system.debug('contratista ' + contra);    
            system.debug('depende no' + info.pcDependeNO + 'depende si'+ info.pcDependeSI);    
            
            //AGREGANDO
            if(!(info.ListDirecciones!=null&&info.ListDirecciones.size()>0)){
                List<ClassDirecion> ltem=new List<ClassDirecion>();
                for(Integer i=0;i<3;i++){
                    ltem.add(new ClassDirecion('','','','','','','','',null));
                }
                info.ListDirecciones=ltem;  
            }
            if(!(info.ListTelefonos!=null&&info.ListTelefonos.size()>0)){
                List<ClassTelefono> ltem = new List<ClassTelefono>();
                for(Integer i=0;i<3;i++){
                    ltem.add(new ClassTelefono('',null,'','','',null,''));
                }
                info.ListTelefonos=ltem;
                
            }
            /*if(info.pcUsuarioCN!='//' && !test.isRunningTest())
            {
                pcUsuarioCN = info.pcUsuarioCN.split('/').get(0);
				pcUsuNombreCN = info.pcUsuarioCN.split('/').get(1);
				pcAgn = info.pcUsuarioCN.split('/').get(2);
                pcUsuarioCN = info.pcUsuarioCN.split('/').get(0);
                pcUsuNombreCN = info.pcUsuarioCN.split('/').get(0);
                pcAgn = info.pcUsuarioCN.split('/').get(0);
            }*/            
          
            Map<String,Pais_R__c> mapPais=new Map<String,Pais_R__c>(); 
            //Map<String,String> mapPaFis=new Map<String,String>();
            Map<String,String> mapDepart=new Map<String,String>();
            Map<String,String> mapMuni=new Map<String,String>();
            Map<String,String> mapColo=new Map<String,String>();
            //Map<String,String> mapNac=new Map<String,String>();
            //Map<String,String> mapNaFis=new Map<String,String>();
            
            for(Pais_R__c item:[SELECT Nombre__c, Codigo__c, Nacionalidad__c  from Pais_R__c]){
                mapPais.put(item.codigo__c,item);
            }
            
            for(integer i=0; i<info.ListDirecciones.size(); i++){
                /*for(Pais_R__c item:[SELECT nombre__c, codigo__c  from Pais_R__c where codigo__c =:info.ListDirecciones[i].paisDir limit 1]){
                    mapPa.put(item.codigo__c,item.nombre__c);
                }*/
                P = mapPais.containsKey(info.PaisResidenciaEfectosFiscales) ? mapPais.get(info.ListDirecciones[i].paisDir).Nombre__c : null;  
            
                //PAIS FISCAL
               /* for(Pais_R__c itemFis:[SELECT nombre__c, codigo__c from Pais_R__c where codigo__c =: info.PaisResidenciaEfectosFiscales limit 1]){
                    mapPaFis.put(itemFis.codigo__c,itemFis.nombre__c);                    
                }*/
                PFis = mapPais.containsKey(info.PaisResidenciaEfectosFiscales) ? mapPais.get(info.PaisResidenciaEfectosFiscales).Nombre__c : null; 
                               
                /*for(Pais_R__c itemNAFis:[select nacionalidad__c, codigo__c,nombre__c from Pais_R__c where codigo__c =: info.PaisResidenciaEfectosFiscales limit 1]){
                    mapNaFis.put(itemNAFis.codigo__c,itemNAFis.nacionalidad__c);
                } */              
				PFisNacionalidad = mapPais.containsKey(info.PaisResidenciaEfectosFiscales) ? mapPais.get(info.PaisResidenciaEfectosFiscales ).Nacionalidad__c : null;                  
                //NACIONALIDAD
                
               /* for(Pais_R__c itemNA:[select nacionalidad__c, codigo__c,nombre__c from Pais_R__c where codigo__c =: info.pcnacionalidad limit 1]){
                 nac=   mapNac.put(itemNA.codigo__c,itemNA.nacionalidad__c);
                }
                */
                //info.pcnacionalidad2=mapNaci.get(info.pcnacionalidad2);
                //info.pcnacionalidad3=mapNaci.get(info.pcnacionalidad3);
                /*for(Pais_R__c itemNA:[select nacionalidad__c, codigo__c,nombre__c from Pais_R__c where codigo__c =:info.pcnacionalidad limit 1]){
                    mapNac.put(itemNA.codigo__c,itemNA.nacionalidad__c);
                    
                    //info.pcnacionalidad2 = itemNA.nacionalidad__c;    
                    system.debug('NACIONA'+ nac +itemNA.nacionalidad__c + info.pcnacionalidad + info.pcnacionalidad2 + Nac2);
                }*/
                nac= mapPais.containsKey(info.pcnacionalidad) ? mapPais.get(info.pcnacionalidad).Nacionalidad__c : null;
                //DEPARTAMENTO
                
                for (Departamentos__c itemDe:[SELECT Departamento__c, codigo_departamento__c,codigo_pais__c from Departamentos__c where codigo_pais__c =: info.ListDirecciones[i].paisDir
                                              and codigo_departamento__c =: info.ListDirecciones[i].deptoDir]){
                                                  //mapCol.put(itemD.codigo_departamento__c,itemD.Departamento__c);
                                                  mapDepart.put(itemDe.codigo_pais__c+itemDe.codigo_departamento__c,itemDe.Departamento__c);
                                              }
                De=mapDepart.get(info.ListDirecciones[i].paisDir+info.ListDirecciones[i].deptoDir);  
                
                //MUNICIPIO
                
                for (Municipio__c itemMuni:[select nombre_municipio__c, codigo_municipio__c,codigo_pais__c,codigo_departamento__c from Municipio__c where codigo_pais__c =: info.ListDirecciones[i].paisDir and codigo_departamento__c =: info.ListDirecciones[i].deptoDir
                                            AND codigo_municipio__c =: info.ListDirecciones[i].ciuDir]){
                                                mapMuni.put(itemMuni.codigo_pais__c+itemMuni.codigo_departamento__c+itemMuni.codigo_municipio__c,itemMuni.nombre_municipio__c);                             
                                            }
                Mu=mapMuni.get(info.ListDirecciones[i].paisDir+info.ListDirecciones[i].deptoDir+info.ListDirecciones[i].ciuDir);
                
                //COLONIA
                
                for (Colonias_U__c itemCo:[select nombre_colonia__c, codigo_colonia__c,codigo_pais__c,codigo_departamento__c,codigo_municipio__c from Colonias_U__c where codigo_pais__c =: info.ListDirecciones[i].paisDir and codigo_departamento__c =: info.ListDirecciones[i].deptoDir
                                           AND codigo_municipio__c =: info.ListDirecciones[i].ciuDir and codigo_colonia__c =: info.ListDirecciones[i].coloDir]){
                                               mapColo.put(itemCo.codigo_pais__c+itemCo.codigo_departamento__c+itemCo.codigo_municipio__c+itemCo.codigo_colonia__c, itemCo.nombre_colonia__c);
                                               
                                           }
                Co=mapColo.get(info.ListDirecciones[i].paisDir+info.ListDirecciones[i].deptoDir+info.ListDirecciones[i].ciuDir+info.ListDirecciones[i].coloDir);
                
                
                
                if (info.ListDirecciones[i].esDefault == 'N' && info.ListDirecciones[i].tipDireccion == 'T')
                {
                    // if(info.ListDirecciones[i].tipDireccion == 'T')
                    //{
                    paisEm = P;
                    deptoEm = De;//info.ListDirecciones[i].deptoDir; //dirección departamento
                    munEm = Mu;//info.ListDirecciones[i].ciuDir; //municipio
                    colEm = Co;//info.ListDirecciones[i].coloDir;//colonia
                    dirEm = info.ListDirecciones[i].detalleDir;//'Es TRABAJO SF' ; 
                    // } 
                }      
                
                if(info.ListDirecciones[i].esDefault == 'S' && info.ListDirecciones[i].tipDireccion == 'C')//&& info.ListTelefonos[i].TelUbicacion == 'C')
                {
                    //if(info.ListDirecciones[i].tipDireccion == 'C')
                    //{
                    pais = P;//info.ListDirecciones[i].paisDir;
                    depto = De;//info.ListDirecciones[i].deptoDir; //dirección departamento
                    mun = Mu;//info.ListDirecciones[i].ciuDir; //municipio
                    col = Co;//info.ListDirecciones[i].coloDir;//colonia
                    dir = info.ListDirecciones[i].detalleDir;//'Es TRABAJO SF' ; 
                    
                    //}                    
                }
            }
            
            info.pcPaisNacimiento = mapPais.containsKey(info.pcPaisNacimiento) ? mapPais.get(info.pcPaisNacimiento).Nombre__c : null;
            info.PaisResidenciaEfectosFiscales = mapPais.containsKey(info.PaisResidenciaEfectosFiscales) ? mapPais.get(info.PaisResidenciaEfectosFiscales).Nombre__c : null;
            system.debug('PaisEmpleador ' + paisEm + deptoEm+ munEm+ colEm +dirEm);
            system.debug('PaisEmpleado ' + pais + depto+ mun+ col + dir);
            
            /*  for(integer i=0; i<info.ListDirecciones.size(); i++)
{
if(info.ListDirecciones[i].esDefault == 'N')//&& info.ListTelefonos[i].TelUbicacion == 'C')
{
if(info.ListDirecciones[i].tipDireccion == 'C')
{
pais = P;//info.ListDirecciones[i].paisDir;
depto = De;//info.ListDirecciones[i].deptoDir; //dirección departamento
mun = Mu;//info.ListDirecciones[i].ciuDir; //municipio
col = Co;//info.ListDirecciones[i].coloDir;//colonia
dir = info.ListDirecciones[i].detalleDir;//'Es CASA SF' ;  
}
else if(info.ListDirecciones[i].tipDireccion == 'T')
{
pais = P;
depto = De;//info.ListDirecciones[i].deptoDir; //dirección departamento
mun = Mu;//info.ListDirecciones[i].ciuDir; //municipio
col = Co;//info.ListDirecciones[i].coloDir;//colonia
dir = info.ListDirecciones[i].detalleDir;//'Es TRABAJO SF' ; 
}
}
}  */      
            
            for(integer i=0; i<info.ListTelefonos.size(); i++)
            {
                if(info.ListTelefonos[i].TelUbicacion == 'C' && info.ListTelefonos[i].tipTelefono == 'C')//&& info.ListTelefonos[i].TelUbicacion == 'C')
                {
                    // if(info.ListTelefonos[i].TelUbicacion == 'C' && info.ListTelefonos[i].tipTelefono == 'C')
                    //{
                    tel = info.ListTelefonos[i].numTelefono;//'Es CEL SF' ;  
                    //}               
                }
                else if(info.ListTelefonos[i].esDefault == 'N' && info.ListTelefonos[i].TelUbicacion == 'C' && info.ListTelefonos[i].tipTelefono == 'D')//&& info.ListTelefonos[i].TelUbicacion == 'C')
                {
                    telRes = info.ListTelefonos[i].numTelefono;//'Es Trabajo SF' ;  
                }
                else if(info.ListTelefonos[i].esDefault == 'N' && info.ListTelefonos[i].TelUbicacion == 'T' && info.ListTelefonos[i].tipTelefono == 'D')//&& info.ListTelefonos[i].TelUbicacion == 'C')
                {
                    telTrab = info.ListTelefonos[i].numTelefono;//'Es Trabajo SF' ;  
                    extTrab = info.ListTelefonos[i].extension;//'Es Trabajo SF' ;
                }
            }
            
            if(telRes == null)
            {
              telD=tel;  
            }else{
               telD=telRes; 
            }
            
            
            //fin
            
            
            if(info.pcnacionalidad!=' '){
                nacionalidades++;
            }
            if(info.pcnacionalidad2!=' ' ||test.isRunningTest()){
                nacionalidades++;
            }
            if(info.pcnacionalidad3!=' '||test.isRunningTest()){
                nacionalidades++;
            }
            if(info.pcFechaVencimientoCN!=null){
                info.pcFechaVencimientoCN= info.pcFechaVencimientoCN.addHours(6);
                fechaVencimiento=(info.pcFechaVencimientoCN.day()<10 ? '0'+info.pcFechaVencimientoCN.day() : info.pcFechaVencimientoCN.day()+'')+'-'+(info.pcFechaVencimientoCN.month()<10 ? '0'+info.pcFechaVencimientoCN.month() : info.pcFechaVencimientoCN.month()+'')+'-'+info.pcFechaVencimientoCN.year();
                fechaVencimientoDia=String.valueOf(info.pcFechaVencimientoCN.day());
                fechaVencimientoMes=String.valueOf(info.pcFechaVencimientoCN.month());
                fechaVencimientoAnio=String.valueOf(info.pcFechaVencimientoCN.year());
            }
            List<String> lcod=new List<String>();
            Map<String,String> mapNaci=new Map<String,String>();
            for(Pais_R__c item:[select nacionalidad__c, codigo__c,nombre__c from Pais_R__c where codigo__c =:info.pccodpais limit 1]){
                //mapNaci.put(item.codigo__c,item.nacionalidad__c);
            }
            info.pcPaisEmpleadorCN=info.vccodpais;
            info.pcnacionalidad=mapNaci.get(info.pcnacionalidad);
            info.pcnacionalidad2=mapNaci.get(info.pcnacionalidad2);
            info.pcnacionalidad3=mapNaci.get(info.pcnacionalidad3);
            if(info.pdfechanacimiento!=null){
                info.pdfechanacimiento= info.pdfechanacimiento.addHours(6);
                fechanacimiento=(info.pdfechanacimiento.day()<10 ? '0'+info.pdfechanacimiento.day() : info.pdfechanacimiento.day()+'')+'-'+(info.pdfechanacimiento.month()<10 ? '0'+info.pdfechanacimiento.month() : info.pdfechanacimiento.month()+'')+'-'+info.pdfechanacimiento.year();
                fechanacimientoDia=String.valueOf(info.pdfechanacimiento.day());
                fechanacimientoMes=String.valueOf(info.pdfechanacimiento.month());
                fechanacimientoAnio=String.valueOf(info.pdfechanacimiento.year());
            }
            Map<String,String> mapColonias=new Map<String,String>();
            Map<String,String> mapMun=new Map<String,String>();
            Map<String,String> mapDepto=new Map<String,String>();
            //Map<String,String> mapPais=new Map<String,String>();
            for(Colonias_U__c item:[select nombre_colonia__c, codigo_colonia__c,codigo_pais__c,codigo_departamento__c,codigo_municipio__c  from Colonias_U__c where (codigo_pais__c =: info.pccodpais or codigo_pais__c !=null) and (codigo_departamento__c =: info.pcDeptoCN or codigo_departamento__c =: info.pcDeptoEmpleadorCN)
                                    AND (codigo_municipio__c =: info.pcMunicipioCN or codigo_municipio__c =: info.pcMunicipioEmpleadorCN) and (codigo_colonia__c =: info.pcColoniaCN or codigo_colonia__c =: info.pcColoniaEmpleadorCN)]){
                                        //  mapColonias.put(item.codigo_pais__c+item.codigo_departamento__c+item.codigo_municipio__c+item.codigo_colonia__c, item.nombre_colonia__c);
                                    }
            for(Municipio__c itemM:[select nombre_municipio__c, codigo_municipio__c,codigo_pais__c,codigo_departamento__c from Municipio__c where (codigo_pais__c =: info.pccodpais or codigo_pais__c =: info.pcPaisEmpleadorCN) and (codigo_departamento__c =: info.pcDeptoCN or codigo_departamento__c =: info.pcDeptoEmpleadorCN)
                                    AND (codigo_municipio__c =: info.pcMunicipioCN or codigo_municipio__c =: info.pcMunicipioEmpleadorCN)]){
                                        //mapMun.put(itemM.codigo_pais__c+itemM.codigo_departamento__c+itemM.codigo_municipio__c,itemM.nombre_municipio__c);
                                    }
            for(Departamentos__c itemD:[select Departamento__c, codigo_departamento__c,codigo_pais__c from Departamentos__c where (codigo_pais__c =: info.pccodpais or codigo_pais__c =: info.pcPaisEmpleadorCN)
                                        and (codigo_departamento__c =: info.pcDeptoCN or codigo_departamento__c =: info.pcDeptoEmpleadorCN)]){
                                            //       mapDepto.put(itemD.codigo_pais__c+itemD.codigo_departamento__c,itemD.Departamento__c);  
                                        }
            
            info.pcColoniaCN=mapColonias.get(info.pccodpais+info.pcDeptoCN+info.pcMunicipioCN+info.pcColoniaCN);//item.nombre_colonia__c;
            info.pcMunicipioCN=mapMun.get(info.pccodpais+info.pcDeptoCN+info.pcMunicipioCN);
            info.pcDeptoCN=mapDepto.get(info.pccodpais+info.pcDeptoCN);
            info.pccodpais= mapPais.containsKey(info.pccodpais) ? mapPais.get(info.pccodpais).Nombre__c: null;
            
            
            if(info.pcDependeSI=='S'||info.pcDependeNO=='S'){
                info.pcDependeSI='S';
            }else if(info.pcDependeSI=='N'||info.pcDependeNO=='N'){
                info.pcDependeSI='N';
            }
            Map<String,String> mapaGiro=new Map<String,String>();
            Schema.DescribeFieldResult fieldResult = Account.sector_n__c.getDescribe();   
            list<PicklistEntry> ple = fieldResult.getPicklistValues();
            for(PicklistEntry p: ple){
                mapaGiro.put(p.getValue(),p.getLabel());
            }
            
            
            Map<String,String> mapaOcupacion=new Map<String,String>();
            Schema.DescribeFieldResult fieldResultt = Account.Profesi_n_Ocupaci_n__c.getDescribe();   
            list<PicklistEntry> plee = fieldResultt.getPicklistValues();
            for(PicklistEntry p: plee){
                mapaOcupacion.put(p.getValue(),p.getLabel());
            }
            
            info.pcProfesionOcupacion = mapaOcupacion.get(info.pcProfesionOcupacion);
            info.pcGiroEmpresaEmpCN = mapaGiro.get(info.pcGiroEmpresaEmpCN);
            
            if(info.pdfechainiciolabor != null){
                info.pdfechainiciolabor= info.pdfechainiciolabor.addHours(6);
                inicioDia=String.valueOf(info.pdfechainiciolabor.day());
                inicioMes=String.valueOf(info.pdfechainiciolabor.month());
                inicioAnio=String.valueOf(info.pdfechainiciolabor.year());
            }
            info.pcColoniaEmpleadorCN=mapColonias.get(info.pcPaisEmpleadorCN+info.pcDeptoEmpleadorCN+info.pcMunicipioEmpleadorCN+info.pcColoniaEmpleadorCN);
            info.pcMunicipioEmpleadorCN=mapMun.get(info.pcPaisEmpleadorCN+info.pcDeptoEmpleadorCN+info.pcMunicipioEmpleadorCN);
            info.pcDeptoEmpleadorCN=mapDepto.get(info.pcPaisEmpleadorCN+info.pcDeptoEmpleadorCN);
            info.pcPaisEmpleadorCN= mapPais.containsKey(info.pcPaisEmpleadorCN) ? mapPais.get(info.pcPaisEmpleadorCN).Nombre__c : null;
            if(info.pdfechasuscripcion!=null){
                info.pdfechasuscripcion= info.pdfechasuscripcion.addHours(6);
                suscripcionDia=String.valueOf(info.pdfechasuscripcion.day());
                suscripcionMes=String.valueOf(info.pdfechasuscripcion.month());
                suscripcionAnio=String.valueOf(info.pdfechasuscripcion.year());
            }
            cpa=new CPAWP();
            system.debug('pcformapago: '+info.pcformapago);
            if(info.pcformapago.contains('TA')){
                cpa.TC=true;
                cpa.numT=info.pccuentapago.deleteWhitespace().split('');
            }else if(info.pcformapago.equals('AH')){
                cpa.ahorro=true;
                cpa.debCuenta=true;
                cpa.numCuenta=info.pccuentapago;
            }else if(info.pcformapago=='CK'){
                cpa.cheque=true;
                cpa.debCuenta=true;
                cpa.numCuenta=info.pccuentapago;
            }else if(info.pcformapago=='TL'){
                cpa.talon=true;
            }else if(info.pcformapago=='PL'){
                cpa.deduc=true;
            }
            if(info.pcsubproducto!=null){
                Subproducto__c item = [Select Comisi_n_Sobre_Saldo__c, Comisi_n_por_Aporte__c from Subproducto__c where Codigo__c = :info.pcsubproducto];
                system.debug('lo que trae el subproducto: '+item);
                comiAporte = item.Comisi_n_por_Aporte__c;
                comiSaldo = item.Comisi_n_Sobre_Saldo__c;
                //cpa.numT=info.pccuentapago.deleteWhitespace().split('');
            }
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
    }
    public class CPAWP{
        public boolean ahorro{get;set;}
        public boolean cheque{get;set;}
        public boolean talon{get;set;}
        public boolean deduc{get;set;}
        public boolean debCuenta{get;set;}
        public boolean TC{get;set;}
        public List<String> numT{get;set;}
        public String numCuenta{get;set;}
        public CPAWP(){
            this.ahorro=false;this.cheque=false;this.talon=false;
            this.ahorro=deduc;this.debCuenta=false;this.TC=false;
            this.numT=new List<String>();
            this.numCuenta='';
        }
    }
}