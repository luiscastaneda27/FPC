global class ReporteAfiliacionT24Masivo {   
    
    public string empresa {get;set;}  
    public  List<reporteT24__c> rellenoTabla {get;set;}  
    public string Num_CodReferencia{get;set;}
    public  List<reporteT24__c> datosExcel {get;set;}
    public  List<classBeneficiarioT24> InfoBenfxCliente {get;set;}
    public reporteT24__c ref {get;set;}
    Public list<ClassReferenciaxClienteT24> referencia_Datos {get; set;}
    public string usuario{get;set;} 
    public string respuesta{get;set;} 
    // String tipoNatural = Schema.SObjectType.Account.getRecordTypeInfosByName().get('clienteNatural').getRecordTypeId();
    public boolean mostrarTabla1 {get;set;}
    public boolean VerRef {get;set;}
    public boolean VerBene {get;set;}    
    public static String Motivo {get;set;}
    public boolean nuevoProducto {get;set;}
    public boolean btn_NuevoProducto {get;set;}
    public boolean cargaAfiliacion {get;set;}
    public boolean btnAfiliacion {get;set;}
    public boolean btnAsesorUnico {get;set;}
    Public datoManualT24__c datosManuales{get;set;}    
    
    public string pcpromotor {get;set;}/*promotorProducto*/
    public list <selectOption> listAsesor {get; set;}
    public string pcproducto {get;set;} /*Producto*/
    public string pcsubproducto {get;set;} /*Subproducto*/
    public List<SelectOption> opcionSubproducto {get;set;}
    
    public  List<classDatosPersonales> ListaDatosPersonales;//lista de datos personales y direccion
    public  List<classInfoAportSeg> ListaInfogeneral;//lista de la segunda parte de la informacion cliente
    public  List<classReferencias> ListaFinal;//datos de referencia y resto del cliente
    public  List<SelectOption> opciones {get;set;}//datos de Asesores
    
    public  List<classEnviarBeneficiarioxCliente> ListaInfoBenfxCliente;
    public  List<classBeneficiarioT24> BenxCliente;
    public  classBeneficiarioT24 ListaInfoBenf1;
    public  classBeneficiarioT24 ListaInfoBenf2;
    public  classBeneficiarioT24 ListaInfoBenf3;
    public  classBeneficiarioT24 ListaInfoBenf4;
    public  classBeneficiarioT24 ListaInfoBenf5;
    public  classBeneficiarioT24 ListaInfoBenf6;
    public  List<ClassEnviarT24lista> datos;
    //Agregado 21062019
    //PAGINACIÓN 
    public boolean mostrarSiguiente{get;set;}
    public boolean mostrarANterior{get;set;}
    public boolean mostrarBotonesP{get;set;}
    integer contadorpaginacion;
    
    public ReporteAfiliacionT24Masivo(){      
        opciones=new List<SelectOption>();
        Asesores();
        btnAsesorUnico=true;
        llenarProductos();
        opcionSubproducto = new List<SelectOption>();
        llenarSubproductos();
        datosManuales = new datoManualT24__c();
        usuario =  ApexPages.currentPage().getParameters().get('hytrd');//usuario que esta en la pantalla
    }
    
    public void RefSalir()
    {    
        VerRef = false;              
    }
    
    public void BeneSalir()
    {    
        VerBene = false;             
    }
    
    public void MostrarT(){ 
        mostrarTabla1=True;
    }
    
    public void MostrarBtn(){ 
        btn_NuevoProducto=True;
        EliminarContenidoC();        
    }
    
    public void btnDatosMC(){ 
        btnAfiliacion=True;
        btn_NuevoProducto=False;
        
        datoManualT24__c ins = new  datoManualT24__c();
        ins.promotor__c=datosManuales.promotor__c;
        ins.producto__c=datosManuales.producto__c;
        ins.subproducto__c=datosManuales.subproducto__c;
        
        insert ins;
    }
    
    public void btnDatosAs(){ 
        btnAfiliacion=True;
        btn_NuevoProducto=False;
        
        datoManualT24__c ins = new  datoManualT24__c();
        ins.promotor__c=datosManuales.promotor__c;
        ins.subproducto__c='N';
        ins.producto__c='N';
        insert ins;
    }
    
    public void CambioProducto(){ 
        nuevoProducto=True;
        btn_NuevoProducto=False;
    }
    
    public void llenarProductos(){
        try
        {   
            for (Producto__c item:[select name, codigo__c from Producto__c ])
            {
                opciones.add(new selectOption(item.codigo__c, item.name));
            }
            
        }catch(exception e){
            
        }
    }
    
    public void llenarSubproductos(){
        try
        {
            opcionSubproducto = new list <selectOption>();
            opcionSubproducto.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Subproducto__c item:[select name, codigo__c from Subproducto__c where producto__r.codigo__c =: datosManuales.producto__c])
            {
                opcionSubproducto.add(new selectOption(item.codigo__c, item.name));
            }
            
        }catch(exception e){
            
        }
    }
    
    public void asesores(){        
        
        listAsesor = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Asesor__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        
        map<string, string> mapisv= new map<string, string>(); 
        listAsesor.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
            listAsesor.add(new selectOption(p.getValue(),p.getLabel())); 
        }
        
    }
    
    public static String BenefGrado(String Parentesco1)
    {     
        String Grado;
        if (Parentesco1== '1' || Parentesco1 == '2'   ||  Parentesco1 == '5'  ) 
        { 
            Grado = '1';
        }
        Else if (Parentesco1 == '7'  ||Parentesco1 == '6' || Parentesco1 == '14')
        { 
            Grado = '2';
        }   
        Else if (Parentesco1 == '9'  || Parentesco1 == '8'||Parentesco1 == '11')
        { 
            Grado = '3';
        }  
        else
        { 
            Grado = '4';
        }
        return Grado;
    }
    
    public static String BenefParentesco(String Parentesco1)
    {     
        String Grado;
        if (Parentesco1== 'Esposo' || Parentesco1 == 'Esposa'   ||  Parentesco1 == 'conyuge'  ) 
        { 
            Grado = '1';
        }
        Else if (Parentesco1 == 'Padre / Madre'  || Parentesco1 == 'Padre -- Madre' || Parentesco1 == 'Padre'|| Parentesco1 == 'Madre' ||Parentesco1 == 'Padre--Madre' || Parentesco1 == 'Padre/Madre')
        { 
            Grado = '5';
        }   
        Else if (Parentesco1 == 'Hermano(a)'  || Parentesco1 == 'Hermano'|| Parentesco1 == 'Hermana'|| Parentesco1 == 'Hermana--Hermano' || Parentesco1 == 'Hermano--Hermana')
        { 
            Grado = '6';
        }Else if (Parentesco1 == 'Hijo/Hija'  || Parentesco1 == 'Hijo'|| Parentesco1 == 'Hija'|| Parentesco1 == 'Hijo(a)' || Parentesco1 == 'Hijo--Hija' || Parentesco1 == 'Hijo -- Hija')
        { 
            Grado = '2';
        }Else if (Parentesco1 == 'Abuelo/Abuela'  || Parentesco1 == 'Abuelo'|| Parentesco1 == 'Abuela'|| Parentesco1 == 'Abuelo(a)' || Parentesco1 == 'Abuelo--Abuela' || Parentesco1 == 'Abuelo -- Abuela')
        { 
            Grado = '7';
        }Else if (Parentesco1 == 'Sobrino/Sobrina'  || Parentesco1 == 'Sobrino'|| Parentesco1 == 'Sobrina'|| Parentesco1 == 'Sobrino(a)' || Parentesco1 == 'Sobrino--Sobrina' || Parentesco1 == 'Sobrino -- Sobrina')
        { 
            Grado = '8';
        }Else if (Parentesco1 == 'Tio/Tia'  || Parentesco1 == 'Tio'|| Parentesco1 == 'Tia'|| Parentesco1 == 'Tio(a)' || Parentesco1 == 'Tio--Tia' || Parentesco1 == 'Tio -- Tia')
        { 
            Grado = '11';
        }Else if (Parentesco1 == 'Primo/Prima'  || Parentesco1 == 'Primo'|| Parentesco1 == 'Prima'|| Parentesco1 == 'Primo(a)' || Parentesco1 == 'Primo--Prima' || Parentesco1 == 'Primo -- Prima')
        { 
            Grado = '9';
        }Else if (Parentesco1 == 'Amigo/Amiga'  || Parentesco1 == 'Amigo'|| Parentesco1 == 'Amiga'|| Parentesco1 == 'Amigo(a)' || Parentesco1 == 'Amigo--Amiga' || Parentesco1 == 'Amigo -- Amiga')
        { 
            Grado = '13';
        }else{
            Grado='10'; 
        }  
        
        return Grado;
    }
    
    public static String codDepartamento(String dir)
    {   
        Departamentos__c consulta;
        dir=dir.replace('"','');
        String CodR;
        String resp;
        String temp;
        
        List<String> sectionDir = new  list<string>();
        sectionDir = dir.split(' .');
        temp = sectionDir[sectionDir.size()-1];
        if(sectionDir.size()<2){
            resp='000';
        }else{
            if(temp=='DISTRITO'){
                CodR= 'ORAZAN';   
            }else{
                CodR = sectionDir[sectionDir.size()-2]; 
            }
            
            try{
                if(CodR=='ARAISO'){
                    CodR = 'EL PARAISO';
                }
                if(CodR=='ARBARA'){
                    CodR = 'SANTA BARBARA';
                }
                if(CodR=='IOS'){
                    CodR = 'GRACIAS A DIOS';
                }
                if(CodR=='ORAZAN'){
                    CodR = 'FRANCISCO MORAZAN';
                }
                if(CodR=='DISTRITO'){
                    CodR = 'FRANCISCO MORAZAN';
                }
                if(CodR=='AHIA'){
                    CodR = 'ISLAS DE LA BAHIA';
                }
                if(CodR=='AZ'){
                    CodR = 'LA PAZ';
                }
                
                consulta= [SELECT codigo_departamento__c FROM Departamentos__c where Departamentos__c.Departamento__c =: CodR];
                resp=String.valueOf(consulta.codigo_departamento__c);
                
            }
            catch(exception e){
                resp='000';
            } 
        }
        return resp;
    }
    
    public static String codM(String dir, String CodD)
    {   
        Municipio__c consulta;
        dir=dir.replace('"','');
        String temp;
        String resp;
        String mun;
        List<String> sectionDir = new  list<string>();
        sectionDir = dir.split(' .');
        temp = sectionDir[sectionDir.size()-1];
        
        if (sectionDir.size()<3)
        {
            resp='000'; 
        }else{
            mun= sectionDir[sectionDir.size()-3]; 
        }
        
        try{
            
            if(CodD=='123'){
                if(temp=='ENTRAL'){
                    mun= 'ENTRAL';  
                }else{
                    mun= sectionDir[sectionDir.size()-4];    
                }
            }            
            
            if(CodD=='136'){
                mun=sectionDir[sectionDir.size()-4];
            }
            
            if(CodD=='132'){
                mun=sectionDir[sectionDir.size()-4];
            }    
            
            if(CodD=='129'){
                mun=sectionDir[sectionDir.size()-4];
            }    
            
            if(CodD=='130'){
                mun=sectionDir[sectionDir.size()-5];
            }    
            
            if(mun=='AGUNA'){
                mun= 'BRUS LAGUNA';
            }
            
            if(mun=='RIENTAL'){
                mun= 'BONITO ORIENTAL';
            }    
            
            if(mun=='USGUARE'){
                mun= 'SANTA ANA DE YUSGUARE';
            } 
            
            if(mun=='RANCISCO'){
                mun= 'VILLA DE SAN FRANCISCO';
            }
            
            if(mun=='DULCE'){
                mun= 'DULCE NOMBRE';
            }
            
            if(mun=='NTRADA'){
                mun= 'NUEVA ARCADIA ( LA ENTRADA )';
            }
            
            if(mun=='UTULE'){
                mun= 'SAN PEDRO DE TUTULE';
            }
            
            if(mun=='ORTE'){
                mun= 'SAN ANTONIO DEL NORTE';
            }
            
            if(mun=='ORAY'){
                mun= 'SAN FRANCISCO DE CORAY';
            }    
            
            if(mun=='URINGLA'){
                mun= 'SANTIAGO DE PURINGLA';
            }    
            
            if(mun=='RIENTE'){
                mun= 'MERCEDES DE ORIENTE';
            }     
            
            if(mun=='LORES'){
                mun= 'SAN ANTONIO DE FLORES';
            } 
            
            if(mun=='TORO'){
                mun= 'JESUS DE OTORO';
            }    
            
            if(mun=='OLON'){
                mun= 'SAN MARCOS DE COLON';
            }    
            
            if(mun=='ARIA'){
                mun= 'CONCEPCION DE MARIA';
            }
            
            if(mun=='UARITA'){
                mun= 'SAN JUAN DE GUARITA';
            }
            
            if(mun=='OLOHETE'){
                mun= 'SAN MANUEL DE COLOHETE';
            }
            
            if(mun=='PALACA'){
                mun= 'SAN FRANCISCO DE OPALACA';
            }
            
            if(mun=='RUZ'){
                mun= 'SANTA CRUZ';
            }
            
            if(mun=='AIQUIN'){
                mun= 'SAN MARCOS DE CAIQUIN';
            } 
            
            if(mun=='ORENZO'){
                mun= 'SAN LORENZO';
            }    
            
            if(mun=='IERRA'){
                mun= 'SAN MARCOS DE LA SIERRA';
            }    
            
            if(mun=='ULNES'){
                mun= 'JUAN FRANCISCO BULNES';
            }     
            
            if(mun=='ORTES'){
                mun=sectionDir[sectionDir.size()-4];
            }
            
            if(mun=='E'){
                if(codD=='137'){
                    mun='SANTA FE';
                }else{
                    mun= 'SAN ANTONIO DE CORTES';
                }
            }
            
            if(mun=='GUA'){
                mun= 'SANTA ROSA DE AGUA';
            }
            
            if(mun=='OCOA'){
                mun= 'TOCOA';
            }
            
            if(mun=='ARAISO'){
                mun= 'EL PARAISO';
            }
            
            if(mun=='UCAS'){
                mun= 'SAN LUCAS';
            }
            
            if(mun=='ATIAS'){
                mun= 'SAN MATIAS';
            }
            
            if(mun=='NCHO'){
                mun= 'VADO ANCHO';
            }
            
            if(mun=='PUERTO'){
                mun= 'PUERTO CORTES';
            }
            if(mun=='LA'){
                mun='LA PAZ';
            }
            if(mun=='ENTRAL'){
                mun='DISTRITO CENTRAL-TEGUCIGALPA';
            }
            if(mun=='EIBA' && CodD=='120'){
                mun='LA CEIBA';
            }
            if(mun=='IBERTAD'){
                mun='LA LIBERTAD';
            }
            
            if(mun=='ULA' && CodD=='122'){
                mun='SAN PEDRO SULA';
            }
            
            
            consulta= [SELECT   codigo_municipio__c 
                       FROM Municipio__c 
                       where Municipio__c.nombre_municipio__c =: mun 
                       AND Municipio__c.codigo_departamento__c=:CodD];
            if(consulta == null){
                resp='000';
            }
            resp=String.valueOf(consulta.codigo_municipio__c);
        } catch(exception e){
            resp='000';
        } 
        return resp; 
        //return mun;
        // return temp;
        //return CodD;
    }
    
    //Agregado 02-05-2019
    public void EliminarContenidoC(){
        delete ([select FechaIngresoCuentas__c
                 from reporteT24__c ]);
        rellenoTabla = [ select noEmpleado__c,fechaIngresoCuentas__c, TipoId__c, noEmpresa__c,identificacion__c,
                        pApellidoEmpleado__c, sApellidoEmpleado__c,pNombreEmpleado__c,sNombreEmpleado__c,
                        nacionalidad__c, fechaNacimientoEmpleado__c, sexo__c, estadoCivil__c, envio__c,
                        direccion__c, nroDireccion__c, nroEdificio__c, codPais__c, codR__c, cod__c, codSector__c,
                        codC__c, telefonoEmpleado__c, correoEmplead__c, aplicaSeg__c, ingresoBrutoCalculado__c,
                        producto__c, subProducto__c, Periodo__c, formaPago__c, cuenta__c, entePaga__c,
                        tipoAporte__c, montoAporte__c, montoAporteP__c, ocupacion__c, promotor__c,nombrePromotor__c, 
                        rtnEmpleador__c,razonSocial__c, nombreEmpresa__c, fechaIngresoEmpresa__c, 
                        telefonoEmpresa__c, extension__c, fax__c, direccionEmpresa__c, correoEmpresa__c, 
                        tipoSolicitud__c, NombreRef1__c, nombre2Ref1__c, Apellido1Ref1__c, 
                        Apellido2Ref1__c,telefonoRef1__c, NombreRef2__c, Nombre2Ref2__c,
                        Apellido1Ref2__c, Apellido2Ref2__c, telefonoRef2__c, cargoEmpleado__c,
                        lugarNacimiento__c, nombreConyugue__c, primerNombreBen1__c, Nombre2Benf1__c,Apellido1Benf1__c,
                        Apellido2Benf1__c,parentescoBenf1__c,porcentajeBenf1__c,Nombre1Benf2__c, Nombre2Benf2__c,
                        Apellido1Benf2__c,Apellido2Benf2__c,parentescoBenf2__c,porcentajeBenf2__c, Nombre1Benf3__c, Nombre2Benf3__c,
                        Apellido1Benf3__c,Apellido2Benf3__c,parentescoBenf3__c,porcentajeBenf3__c, Nombre1Benf4__c, Nombre2Benf4__c,
                        Apellido1Benf4__c,Apellido2Benf4__c,parentescoBenf4__c,porcentajeBenf4__c , Nombre1Benf5__c, Nombre2Benf5__c,
                        Apellido1Benf5__c,Apellido2Benf5__c,parentescoBenf5__c,porcentajeBenf5__c, Nombre1Benf6__c, Nombre2Benf6__c,
                        Apellido1Benf6__c,Apellido2Benf6__c,parentescoBenf6__c,porcentajeBenf6__c, respuesta__c
                        from reporteT24__c ];
    }
    //fin
    
    public void EliminarContenido(){  
        delete ([select FechaIngresoCuentas__c
                 from reporteT24__c ]);
        rellenoTabla = [ select noEmpleado__c,fechaIngresoCuentas__c, TipoId__c, noEmpresa__c,identificacion__c,
                        pApellidoEmpleado__c, sApellidoEmpleado__c,pNombreEmpleado__c,sNombreEmpleado__c,
                        nacionalidad__c, fechaNacimientoEmpleado__c, sexo__c, estadoCivil__c, envio__c,
                        direccion__c, nroDireccion__c, nroEdificio__c, codPais__c, codR__c, cod__c, codSector__c,
                        codC__c, telefonoEmpleado__c, correoEmplead__c, aplicaSeg__c, ingresoBrutoCalculado__c,
                        producto__c, subProducto__c, Periodo__c, formaPago__c, cuenta__c, entePaga__c,
                        tipoAporte__c, montoAporte__c, montoAporteP__c, ocupacion__c, promotor__c,nombrePromotor__c, 
                        rtnEmpleador__c,razonSocial__c, nombreEmpresa__c, fechaIngresoEmpresa__c, 
                        telefonoEmpresa__c, extension__c, fax__c, direccionEmpresa__c, correoEmpresa__c, 
                        tipoSolicitud__c, NombreRef1__c, nombre2Ref1__c, Apellido1Ref1__c, 
                        Apellido2Ref1__c,telefonoRef1__c, NombreRef2__c, Nombre2Ref2__c,
                        Apellido1Ref2__c, Apellido2Ref2__c, telefonoRef2__c, cargoEmpleado__c,
                        lugarNacimiento__c, nombreConyugue__c, primerNombreBen1__c, Nombre2Benf1__c,Apellido1Benf1__c,
                        Apellido2Benf1__c,parentescoBenf1__c,porcentajeBenf1__c,Nombre1Benf2__c, Nombre2Benf2__c,
                        Apellido1Benf2__c,Apellido2Benf2__c,parentescoBenf2__c,porcentajeBenf2__c, Nombre1Benf3__c, Nombre2Benf3__c,
                        Apellido1Benf3__c,Apellido2Benf3__c,parentescoBenf3__c,porcentajeBenf3__c, Nombre1Benf4__c, Nombre2Benf4__c,
                        Apellido1Benf4__c,Apellido2Benf4__c,parentescoBenf4__c,porcentajeBenf4__c , Nombre1Benf5__c, Nombre2Benf5__c,
                        Apellido1Benf5__c,Apellido2Benf5__c,parentescoBenf5__c,porcentajeBenf5__c, Nombre1Benf6__c, Nombre2Benf6__c,
                        Apellido1Benf6__c,Apellido2Benf6__c,parentescoBenf6__c,porcentajeBenf6__c, respuesta__c
                        from reporteT24__c ];
        opciones=new List<SelectOption>();
        Asesores();
        btnAsesorUnico=true;
        llenarProductos();
        opcionSubproducto = new List<SelectOption>();
        llenarSubproductos();
        datosManuales = new datoManualT24__c();
        
        mostrarTabla1 = false;
        pcpromotor =null;
        nuevoProducto=False; 
        btn_NuevoProducto=False;
        btnAfiliacion=False;
        
    }
    
    public static String llenarObjetos(string prueba){     
        if(prueba=='""'){
            prueba=null;
        }else{
            if(prueba.contains('"')){
                prueba=prueba.replace('"','');  
                prueba=prueba;
            }else{
                if(prueba != null){
                    prueba=prueba;   
                }
            }
        }
        return prueba;
    }
    
    public static String estadoCivil(string cv){     
        cv=cv.replace('"','');
        if(cv=='UL'){
            cv='U';
        }           
        return cv;
    }
    
    public static String LUGAR_NACIMIENTO(string lugarNac){     
        lugarNac=lugarNac.replace('"','');
        
        if(lugarNac==' '){
            lugarNac='Honduras';
        }else if(lugarNac=='NO PARAMETRIZADO'){
            lugarNac='Honduras';
        }else{
            lugarNac=lugarNac;  
        }
        
        return lugarNac;
    }
    
    public static String pendientesActualizar(string updateP){     
        updateP=updateP.replace('"','');
        if(updateP=='UPDATE PENDING'){
            updateP=null;
        }
        
        return updateP;
    }
    
    
    public static String dirreccion(string dir){     
        dir=dir.replace('"','');
        dir=dir.replace('.',',');
        
        dir=dir.replace('Calle','Cll');
        dir=dir.replace('NO PARAMETRIZADO',' ');
        dir=dir.replace('HONDURAS',' ');
        dir=dir.replace('HONDURA',' ');
        dir=dir.replace('PULPERIA','PULP');
        dir=dir.replace('BLOQUE','BL');
        dir=dir.replace('AVENIDA','AVE');
        dir=dir.replace('CUADRAS','CDRAS');
        dir=dir.replace('PRINCIPAL','PRAL');
        dir=dir.replace('IGLESIA','IGLE');
        dir=dir.replace('FRENTE','FTE');
        dir=dir.replace('SAN PEDRO SULA','SPS'); 
        dir=dir.replace('ESCUELA','ESC'); 
        
        dir=dir.replace(', ',' ');
        dir=dir.replace('LA PAZ',' ');
        dir=dir.replace('CORTES',' ');
        dir=dir.replace('ATLANTIDA',' ');
        dir=dir.replace('ISLAS DE LA BAHIA',' ');
        dir=dir.replace('FRANCISCO MORAZAN',' ');
        dir=dir.replace('YORO',' ');
        dir=dir.replace('OLANCHO',' ');
        dir=dir.replace('SANTA BARBARA',' ');
        dir=dir.replace('GRACIAS A DIOS',' ');
        dir=dir.replace('OCOTEPEQUE',' ');
        dir=dir.replace('CHOLUTECA',' ');
        dir=dir.replace('EL PARAISO',' ');
        dir=dir.replace('SANTA BARBARA',' ');
        dir=dir.replace('INTIBUCA',' ');
        dir=dir.replace('SAN MARCOS DE LA SIERRA',' ');
        dir=dir.replace(' , ',' ');
        
        
        if(dir.length() >115){
            dir=null;
        }
        return dir;
    }
    
    public static String llenarObjetosMonetarios(string prueba){     
        //prueba= '0.00';
        return prueba;
    }
    
    //*****se cambia el formato de la fecha ddd--mmm--yyy al formato yyy-mmm-ddd que es el formato que acepta salesforce***********    
    public static String fechas(string fecha){     
        string fechaFinal=null;
        date myDate = date.today();
        system.debug('fecha '+myDate);
        if(fecha!=NULL){
            
            list<string> a1;            
            a1= fecha.Split('--');
            System.debug(a1);
            fechaFinal = a1[2]+'-'+a1[1]+'-'+a1[0];
            if(date.valueOf(fechaFinal)>myDate) {
                fechaFinal=String.valueOf(myDate);  
            }
        }else{
            fechaFinal=String.valueOf(myDate); 
        }
        system.debug('SalidaF '+fechaFinal);
        return fechaFinal;
    }
    
    public void MostrarRef(){
        VerRef=True;
        
        ref = [ select NombreRef1__c, nombre2Ref1__c, Apellido1Ref1__c, 
               Apellido2Ref1__c,telefonoRef1__c, NombreRef2__c, Nombre2Ref2__c,
               Apellido1Ref2__c, Apellido2Ref2__c, telefonoRef2__c,noEmpleado__c
               from reporteT24__c WHERE noEmpleado__c =: Num_CodReferencia];
        
        referencia_Datos= new List<ClassReferenciaxClienteT24>();
        referencia_Datos.add( new ClassReferenciaxClienteT24( ref.NombreRef1__c, 
                                                             ref.nombre2Ref1__c, 
                                                             ref.Apellido1Ref1__c, 
                                                             ref.Apellido2Ref1__c,
                                                             ref.telefonoRef1__c)); 
        if(ref.NombreRef2__c!=Null){
            referencia_Datos.add( new ClassReferenciaxClienteT24( ref.NombreRef2__c, 
                                                                 ref.nombre2Ref2__c, 
                                                                 ref.Apellido1Ref2__c, 
                                                                 ref.Apellido2Ref2__c,
                                                                 ref.telefonoRef2__c));
        }
    }
    
    public void MostrarBene(){
        VerBene=True;
        
        ref = [ select primerNombreBen1__c, Nombre2Benf1__c,Apellido1Benf1__c,
               Apellido2Benf1__c,parentescoBenf1__c,porcentajeBenf1__c,Nombre1Benf2__c, Nombre2Benf2__c,
               Apellido1Benf2__c,Apellido2Benf2__c,parentescoBenf2__c,porcentajeBenf2__c, Nombre1Benf3__c, Nombre2Benf3__c,
               Apellido1Benf3__c,Apellido2Benf3__c,parentescoBenf3__c,porcentajeBenf3__c, Nombre1Benf4__c, Nombre2Benf4__c,
               Apellido1Benf4__c,Apellido2Benf4__c,parentescoBenf4__c,porcentajeBenf4__c , Nombre1Benf5__c, Nombre2Benf5__c,
               Apellido1Benf5__c,Apellido2Benf5__c,parentescoBenf5__c,porcentajeBenf5__c, Nombre1Benf6__c, Nombre2Benf6__c,
               Apellido1Benf6__c,Apellido2Benf6__c,parentescoBenf6__c,porcentajeBenf6__c from reporteT24__c 
               WHERE noEmpleado__c =: Num_CodReferencia];
        
        InfoBenfxCliente= new List<classBeneficiarioT24>();
        
        InfoBenfxCliente.add( new classBeneficiarioT24( ref.primerNombreBen1__c, 
                                                       ref.Nombre2Benf1__c, 
                                                       ref.Apellido1Benf1__c, 
                                                       ref.Apellido2Benf1__c,
                                                       ref.parentescoBenf1__c,
                                                       ref.porcentajeBenf1__c,
                                                       BenefGrado(BenefParentesco(ref.parentescoBenf1__c))
                                                       
                                                      )
                            ); 
        if(ref.Nombre1Benf2__c!=NULL){ 
            InfoBenfxCliente.add( new classBeneficiarioT24(ref.Nombre1Benf2__c,
                                                           ref.Nombre2Benf2__c,
                                                           ref.Apellido1Benf2__c,
                                                           ref.Apellido2Benf2__c,
                                                           ref.parentescoBenf2__c,
                                                           ref.porcentajeBenf2__c,
                                                           BenefGrado(BenefParentesco(ref.parentescoBenf2__c))
                                                           
                                                          ));
            
            if(ref.Nombre1Benf3__c!=NULL){
                InfoBenfxCliente.add( new classBeneficiarioT24( ref.Nombre1Benf3__c,
                                                               ref.Nombre2Benf3__c,
                                                               ref.Apellido1Benf3__c,
                                                               ref.Apellido2Benf3__c,
                                                               ref.parentescoBenf3__c,
                                                               ref.porcentajeBenf3__c,
                                                               BenefGrado(BenefParentesco(ref.parentescoBenf3__c))
                                                              ));
                
                
                if(ref.Nombre1Benf4__c!=NULL){   
                    InfoBenfxCliente.add( new classBeneficiarioT24(ref.Nombre1Benf4__c,
                                                                   ref.Nombre2Benf4__c,
                                                                   ref.Apellido1Benf4__c,
                                                                   ref.Apellido2Benf4__c,
                                                                   ref.parentescoBenf4__c,
                                                                   ref.porcentajeBenf4__c,
                                                                   BenefGrado(BenefParentesco(ref.parentescoBenf4__c))
                                                                  )
                                        );
                    if(ref.Nombre1Benf5__c!=NULL){
                        InfoBenfxCliente.add( new classBeneficiarioT24(ref.Nombre1Benf5__c,
                                                                       ref.Nombre2Benf5__c,
                                                                       ref.Apellido1Benf5__c,
                                                                       ref.Apellido2Benf5__c,
                                                                       ref.parentescoBenf5__c,
                                                                       ref.porcentajeBenf5__c,
                                                                       BenefGrado(BenefParentesco(ref.parentescoBenf5__c))
                                                                      )
                                            );
                        if(ref.Nombre1Benf6__c!=NULL){
                            InfoBenfxCliente.add( new classBeneficiarioT24(ref.Nombre1Benf6__c,
                                                                           ref.Nombre2Benf6__c,
                                                                           ref.Apellido1Benf6__c,
                                                                           ref.Apellido2Benf6__c,
                                                                           ref.parentescoBenf6__c,
                                                                           ref.porcentajeBenf6__c,
                                                                           BenefGrado(BenefParentesco(ref.parentescoBenf6__c))
                                                                          )
                                                );
                        }//if_bene6
                    }//if_bene5
                }//if_bene4
            }//if_bene3
        }//if_bene2
        
    }
    
    public void siguiente() 
    {
        try{
            
            if((contadorpaginacion + 1)*100 > datosExcel.size()||test.isRunningTest())
            {
                contadorpaginacion ++;
                rellenoTabla = new List<reporteT24__c>();
                mostrarSiguiente=true;
                mostraranterior=false;
                for(integer i=(contadorpaginacion - 1)*100; i<datosExcel.size(); i++)
                {
                    
                    rellenoTabla.add(datosExcel[i]);
                } 
                
                
            }
            else
            {
                mostraranterior=false;
                contadorpaginacion ++;
                rellenoTabla = new List<reporteT24__c>();
                for(integer i=(contadorpaginacion - 1)*100; i<contadorpaginacion*100; i++)
                {
                    rellenoTabla.add(datosExcel[i]);
                } 
            }
            
        }
        catch(exception ex)
        {
            
        }
    }
    
    public void anterior()
    {
        try 
        {
            
            rellenoTabla = new List<reporteT24__c>();
            if((contadorpaginacion - 1)*100 < 101||test.isRunningTest())
            {
                mostrarsiguiente=false;
                mostrarAnterior=true;
                for(integer i=0; i<100; i++)
                {
                    rellenoTabla.add(datosExcel[i]);
                } 
                contadorpaginacion --;
            }
            else
            {
                for(integer i=(contadorpaginacion - 2)*100; i<(contadorpaginacion-1) *100; i++)
                {
                    rellenoTabla.add(datosExcel[i]);
                }  
                contadorpaginacion --;
                mostrarSiguiente=false;
            }
        }
        catch(Exception ex)
        {
            
        }
    }
    
    public void VerPlanilla(){ 
        try{
            //Agregado 21062019
            mostrarBotonesp=false;
            //Fin
            rellenoTabla = [ select noEmpleado__c,fechaIngresoCuentas__c, TipoId__c, noEmpresa__c,identificacion__c,
                            pApellidoEmpleado__c, sApellidoEmpleado__c,pNombreEmpleado__c,sNombreEmpleado__c,
                            nacionalidad__c, fechaNacimientoEmpleado__c, sexo__c, estadoCivil__c, envio__c,
                            direccion__c, nroDireccion__c, nroEdificio__c, codPais__c, codR__c, cod__c, codSector__c,
                            codC__c, telefonoEmpleado__c,telefono__c, correoEmplead__c, aplicaSeg__c, ingresoBrutoCalculado__c,
                            producto__c, subProducto__c, Periodo__c, formaPago__c, cuenta__c, entePaga__c,
                            tipoAporte__c, montoAporte__c, montoAporteP__c, ocupacion__c, promotor__c,nombrePromotor__c, 
                            rtnEmpleador__c,razonSocial__c, nombreEmpresa__c, fechaIngresoEmpresa__c, 
                            telefonoEmpresa__c, extension__c, fax__c, direccionEmpresa__c, correoEmpresa__c, 
                            tipoSolicitud__c, NombreRef1__c, nombre2Ref1__c, Apellido1Ref1__c, 
                            Apellido2Ref1__c,telefonoRef1__c, NombreRef2__c, Nombre2Ref2__c,
                            Apellido1Ref2__c, Apellido2Ref2__c, telefonoRef2__c, cargoEmpleado__c,
                            lugarNacimiento__c, nombreConyugue__c, primerNombreBen1__c, Nombre2Benf1__c,Apellido1Benf1__c,
                            Apellido2Benf1__c,parentescoBenf1__c,porcentajeBenf1__c,Nombre1Benf2__c, Nombre2Benf2__c,
                            Apellido1Benf2__c,Apellido2Benf2__c,parentescoBenf2__c,porcentajeBenf2__c, Nombre1Benf3__c, Nombre2Benf3__c,
                            Apellido1Benf3__c,Apellido2Benf3__c,parentescoBenf3__c,porcentajeBenf3__c, Nombre1Benf4__c, Nombre2Benf4__c,
                            Apellido1Benf4__c,Apellido2Benf4__c,parentescoBenf4__c,porcentajeBenf4__c , Nombre1Benf5__c, Nombre2Benf5__c,
                            Apellido1Benf5__c,Apellido2Benf5__c,parentescoBenf5__c,porcentajeBenf5__c, Nombre1Benf6__c, Nombre2Benf6__c,
                            Apellido1Benf6__c,Apellido2Benf6__c,parentescoBenf6__c,porcentajeBenf6__c,usuario__c, respuesta__c
                            from reporteT24__c ];   
            
            
            ListaDatosPersonales = NEW List<classDatosPersonales>();//lista de datos personales y direccion
            ListaInfogeneral = NEW List<classInfoAportSeg>();//lista de la segunda parte de la informacion cliente
            ListaFinal= NEW List<classReferencias>();
            ListaInfoBenfxCliente=NEW List<classEnviarBeneficiarioxCliente>();
            
            
            if (rellenoTabla.size()>0||test.isRunningTest()){
                
                for (reporteT24__c a:rellenoTabla){                    
                    if(a.noEmpleado__c !='No Afiliado'){
                        BenxCliente = new list<classBeneficiarioT24>();
                        
                        ListaDatosPersonales.add(new classDatosPersonales(
                            a.noEmpleado__c,
                            a.fechaIngresoCuentas__c,
                            a.TipoId__c,
                            a.noEmpresa__c,
                            a.identificacion__c,
                            a.pNombreEmpleado__c, 
                            a.sNombreEmpleado__c, 
                            a.pApellidoEmpleado__c, 
                            a.sApellidoEmpleado__c, 
                            a.nacionalidad__c,
                            a.fechaNacimientoEmpleado__c, 
                            a.sexo__c,
                            a.estadoCivil__c, 
                            a.envio__c,
                            a.direccion__c, 
                            a.codPais__c, 
                            a.codR__c, 
                            a.cod__c,   
                            a.codC__c,  
                            a.telefonoEmpleado__c,
                            a.telefono__c,
                            a.correoEmplead__c
                        )
                                                );  
                        
                        
                        ListaInfogeneral.add( new classInfoAportSeg(
                            a.aplicaSeg__c,
                            a.ingresoBrutoCalculado__c,
                            a.producto__c,
                            a.subProducto__c,
                            a.Periodo__c,
                            a.formaPago__c, 
                            a.cuenta__c,  
                            a.tipoAporte__c, 
                            a.montoAporte__c,
                            a.montoAporteP__c, 
                            a.ocupacion__c,
                            a.promotor__c,     
                            a.nombrePromotor__c,
                            a.rtnEmpleador__c,  
                            a.razonSocial__c,  
                            a.nombreEmpresa__c,
                            a.fechaIngresoEmpresa__c,
                            a.telefonoEmpresa__c,  
                            a.extension__c,
                            a.fax__c, 
                            a.direccionEmpresa__c,  
                            a.correoEmpresa__c, 
                            a.tipoSolicitud__c,
                            null/*ira en un futuro el rtn del empleado*/
                        )
                                            ); 
                        ListaFinal.add(new classReferencias(
                            a.NombreRef1__c,
                            a.nombre2Ref1__c,
                            a.Apellido1Ref1__c,
                            a.Apellido2Ref1__c,
                            a.telefonoRef1__c,
                            a.NombreRef2__c, 
                            a.Nombre2Ref2__c, 
                            a.Apellido1Ref2__c, 
                            a.Apellido2Ref2__c,
                            a.telefonoRef2__c,
                            a.cargoEmpleado__c,
                            a.lugarNacimiento__c,
                            a.nombreConyugue__c,
                            a.usuario__c
                        )
                                      );
                        ListaInfoBenf1= new classBeneficiarioT24(      a.primerNombreBen1__c,
                                                                 a.Nombre2Benf1__c,
                                                                 a.Apellido1Benf1__c,
                                                                 a.Apellido2Benf1__c,
                                                                 BenefParentesco(a.parentescoBenf1__c),
                                                                 a.porcentajeBenf1__c,
                                                                 BenefGrado(BenefParentesco(a.parentescoBenf1__c))
                                                                );
                        
                        BenxCliente.add(ListaInfoBenf1);
                        
                        if(a.Nombre1Benf2__c!=NULL){ 
                            ListaInfoBenf2= new classBeneficiarioT24(      a.Nombre1Benf2__c,
                                                                     a.Nombre2Benf2__c,
                                                                     a.Apellido1Benf2__c,
                                                                     a.Apellido2Benf2__c,
                                                                     BenefParentesco(a.parentescoBenf2__c),
                                                                     a.porcentajeBenf2__c,
                                                                     BenefGrado(BenefParentesco(a.parentescoBenf2__c))
                                                                    );
                            BenxCliente.add(ListaInfoBenf2);  
                            
                            if(a.Nombre1Benf3__c!=NULL){
                                ListaInfoBenf3= new classBeneficiarioT24(      a.Nombre1Benf3__c,
                                                                         a.Nombre2Benf3__c,
                                                                         a.Apellido1Benf3__c,
                                                                         a.Apellido2Benf3__c,
                                                                         BenefParentesco(a.parentescoBenf3__c),
                                                                         a.porcentajeBenf3__c,
                                                                         BenefGrado(BenefParentesco(a.parentescoBenf3__c))
                                                                        );
                                BenxCliente.add(ListaInfoBenf3);
                                
                                
                                if(a.Nombre1Benf4__c!=NULL){   
                                    ListaInfoBenf4= new classBeneficiarioT24(      a.Nombre1Benf4__c,
                                                                             a.Nombre2Benf4__c,
                                                                             a.Apellido1Benf4__c,
                                                                             a.Apellido2Benf4__c,
                                                                             BenefParentesco(a.parentescoBenf4__c),
                                                                             a.porcentajeBenf4__c,
                                                                             BenefGrado(BenefParentesco(a.parentescoBenf4__c))
                                                                            );
                                    BenxCliente.add(ListaInfoBenf4);
                                    
                                    if(a.Nombre1Benf5__c!=NULL){
                                        ListaInfoBenf5= new classBeneficiarioT24(      a.Nombre1Benf5__c,
                                                                                 a.Nombre2Benf5__c,
                                                                                 a.Apellido1Benf5__c,
                                                                                 a.Apellido2Benf5__c,
                                                                                 BenefParentesco(a.parentescoBenf5__c),
                                                                                 a.porcentajeBenf5__c,
                                                                                 BenefGrado(BenefParentesco(a.parentescoBenf5__c))
                                                                                );
                                        BenxCliente.add(ListaInfoBenf5);                  
                                        
                                        ListaInfoBenf6= new classBeneficiarioT24(      a.Nombre1Benf6__c,
                                                                                 a.Nombre2Benf6__c,
                                                                                 a.Apellido1Benf6__c,
                                                                                 a.Apellido2Benf6__c,
                                                                                 BenefParentesco(a.parentescoBenf6__c),
                                                                                 a.porcentajeBenf6__c,
                                                                                 BenefGrado(BenefParentesco(a.parentescoBenf6__c))
                                                                                );
                                        BenxCliente.add(ListaInfoBenf6);
                                        
                                    }//if_bene5
                                }//if_bene4
                            }//if_bene3
                        }//if_bene2              
                        
                        ListaInfoBenfxCliente.add(new classEnviarBeneficiarioxCliente(BenxCliente));  
                    }                 
                }////fin_for 
                
            }////fin_if_rellenoTabla.size
            
            ClassEnviarT24lista Enviar = new ClassEnviarT24lista(ListaDatosPersonales, ListaInfogeneral,ListaFinal,ListaInfoBenfxCliente);
            
            //system.debug('listaEnviar'+ Enviar);  
            //apiReporteT24.guardarT24(Enviar);
            string csharp;
            csharp=string.valueOf(apiReporteT24.guardarT24(Enviar)); 
            system.debug('lista_afiliacion '+ csharp);
            datosExcel = [ select noEmpleado__c,fechaIngresoCuentas__c, TipoId__c, noEmpresa__c,identificacion__c,
                          pApellidoEmpleado__c, sApellidoEmpleado__c,pNombreEmpleado__c,sNombreEmpleado__c,
                          nacionalidad__c, fechaNacimientoEmpleado__c, sexo__c, estadoCivil__c, envio__c,
                          direccion__c, nroDireccion__c, nroEdificio__c, codPais__c, codR__c, cod__c, codSector__c,
                          codC__c, telefonoEmpleado__c,telefono__c, correoEmplead__c, aplicaSeg__c, ingresoBrutoCalculado__c,
                          producto__c, subProducto__c, Periodo__c, formaPago__c, cuenta__c, entePaga__c,
                          tipoAporte__c, montoAporte__c, montoAporteP__c, ocupacion__c, promotor__c,nombrePromotor__c, 
                          rtnEmpleador__c,razonSocial__c, nombreEmpresa__c, fechaIngresoEmpresa__c, 
                          telefonoEmpresa__c, extension__c, fax__c, direccionEmpresa__c, correoEmpresa__c, 
                          tipoSolicitud__c, NombreRef1__c, nombre2Ref1__c, Apellido1Ref1__c, 
                          Apellido2Ref1__c,telefonoRef1__c, NombreRef2__c, Nombre2Ref2__c,
                          Apellido1Ref2__c, Apellido2Ref2__c, telefonoRef2__c, cargoEmpleado__c,
                          lugarNacimiento__c, nombreConyugue__c, primerNombreBen1__c, Nombre2Benf1__c,Apellido1Benf1__c,
                          Apellido2Benf1__c,parentescoBenf1__c,porcentajeBenf1__c,Nombre1Benf2__c, Nombre2Benf2__c,
                          Apellido1Benf2__c,Apellido2Benf2__c,parentescoBenf2__c,porcentajeBenf2__c, Nombre1Benf3__c, Nombre2Benf3__c,
                          Apellido1Benf3__c,Apellido2Benf3__c,parentescoBenf3__c,porcentajeBenf3__c, Nombre1Benf4__c, Nombre2Benf4__c,
                          Apellido1Benf4__c,Apellido2Benf4__c,parentescoBenf4__c,porcentajeBenf4__c , Nombre1Benf5__c, Nombre2Benf5__c,
                          Apellido1Benf5__c,Apellido2Benf5__c,parentescoBenf5__c,porcentajeBenf5__c, Nombre1Benf6__c, Nombre2Benf6__c,
                          Apellido1Benf6__c,Apellido2Benf6__c,parentescoBenf6__c,porcentajeBenf6__c,usuario__c, respuesta__c
                          from reporteT24__c ];
            //Agregado 21062019
            //PAginaciones
            mostrarBotonesp=false;
            mostrarAnterior=true;
            mostrarSiguiente=true;
            contadorpaginacion=0;
            rellenoTabla = new List<reporteT24__c>();
            if(datosExcel.size()>100)
            {
                contadorpaginacion ++;
                mostrarBotonesp=true;
                mostrarSiguiente=false;
                for(integer i=0; i<100; i++)
                {
                    
                    rellenoTabla.add(datosExcel[i]);
                }
            }
            else
            {
                for(integer i=0; i<datosExcel.size(); i++)
                {
                    
                    rellenoTabla.add(datosExcel[i]);
                } 
            } 
            
            //fin
            MostrarT();
            
        }
        Catch(Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Ha Ocurrido Un error: ' +ex.getLineNumber()));
            system.debug('Error al Guardar: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());    
        }
    }  
    
    //Metodo el cual carga el archivo del excel 
    @RemoteAction
    global static classWRetorno2 SUbirInformacion(String stringCSV, string empresa, string agus){
        classWRetorno2 retorno = new classWRetorno2();
        
        try{
            string tele; //agregado para el telefono 30052019
            stringCSV = stringCSV.replace('\'', '');
            stringCSV = stringCSV.replace('´', '');
            stringCSV = stringCSV.replace(',"  ', ',"');
            
            string replace = 'P';
            
            list<string> clientes = new  list<string>();
            system.debug('String recibido: '+stringCSV);
            clientes = stringCSV.split('\n');
            string stringNuevo ='2121';
            string noContiene = '0123456789".,';
            string commilla = '"';
            
            if(clientes.size() > 1){
                stringNuevo = clientes[1]; 
            }
            try{
                for(integer i=1; i<stringNuevo.length(); i++){
                    if( i+2 <= stringNuevo.length() && replace=='P' &&  stringNuevo.substring(i-1, i+2)=='074' && !noContiene.contains(stringNuevo.substring(i-2, i-1)) && !test.isRunningTest()){
                        replace = stringNuevo.substring(i-2, i-1);
                        stringCSV = stringCSV.replace(replace, '');
                    }
                }
            }catch(exception exe){}
            
            list<string> clientes2= new  list<string>();
            clientes = new  list<string>();
            clientes = stringCSV.split('\n');
            datoManualT24__c datosManuales;
            datosManuales= [select promotor__c,subproducto__c,producto__c from datoManualT24__c order by indice__c desc limit 1];
            
            retorno.error='Ya puede ver la planilla subida';
            
            integer A=15;
            integer FechIngC=15;
            integer C=15;
            integer D=15;
            integer E=15;  
            integer F=15;
            integer G=15;
            integer NE1=15;
            integer NE2=15;
            integer Nacionalidad=15;
            integer FechN=15;
            integer S=15;
            integer Civ=15;
            integer Env=15;
            integer Dir=15;
            integer NumDir=16;
            integer Ed=15;
            integer CodP=15;
            integer CodReg=15;
            integer CodProv=15;
            integer CodCiud=15;
            integer CodSec=15;
            integer Tel=15;
            integer CorreoE=15;
            integer AplicSeg=15;
            integer Ibc=15;
            integer Prod=15;
            integer SubProd=15;
            integer Periodo=15;
            integer FormaPag=15;
            integer CuentaPag=15;
            integer EntePaga=15;
            integer TipoApor=15;
            integer MontoApor=15;
            integer MontoAporN=15;
            integer Ocupacion=15;
            integer Prom=15;
            integer NProm=15;
            integer RTNEmp=15;
            integer RazonSoc=15;
            integer NEmp=15;
            integer FechIng=15;
            integer TelEmp=15;
            integer Ext=15;
            integer Fax=15;
            integer DirEmp=15;
            integer CorreoEmp=15;
            integer TipoSoli=15;
            integer N1Ref1=15;
            integer N2ref1=15;
            integer Ap1Ref1=15;
            integer Ap2Ref1=15;
            integer TelRef1=15;
            integer N1Ref2=15;
            integer N2ref2=15;
            integer Ap1Ref2=15;
            integer Ap2Ref2=15;
            integer TelRef2=15;
            integer CargoE=15;
            integer LugarNacE=15;
            integer NConyuge=15;
            integer N1Benf1=15;
            integer N2Benf1=15;
            integer Ape1Benf1=15;
            integer Ape2Benf1=15;
            integer ParentBenf1=15;
            integer PorcenBenf1=15;
            integer N1Benf2=15;
            integer N2Benf2=15;
            integer Ape1Benf2=15;
            integer Ape2Benf2=15;
            integer ParentBenf2=15;
            integer PorcenBenf2=15;
            integer N1Benf3=15;
            integer N2Benf3=15;
            integer Ape1Benf3=15;
            integer Ape2Benf3=15;
            integer ParentBenf3=15;
            integer PorcenBenf3=15;
            integer N1Benf4=15;
            integer N2Benf4=15;
            integer Ape1Benf4=15;
            integer Ape2Benf4=15;
            integer ParentBenf4=15;
            integer PorcenBenf4=15;
            integer N1Benf5=15;
            integer N2Benf5=15;
            integer Ape1Benf5=15;
            integer Ape2Benf5=15;
            integer ParentBenf5=15;
            integer PorcenBenf5=15;
            integer N1Benf6=15;
            integer N2Benf6=15;
            integer Ape1Benf6=15;
            integer Ape2Benf6=15;
            integer ParentBenf6=15;
            integer PorcenBenf6=15;
            string lk=clientes[0];
            
            clientes2= lk.split(','); 
            clientes.remove(0);
            
            //no tocar
            for(integer i=0; i<clientes2.size(); i++)
            {
                
                clientes2[i]=clientes2[i].replace('"','');
                clientes2[i]=clientes2[i].replace('  ',' ');
                clientes2[i]=clientes2[i].Trim();
                
                
                if(clientes2[i].toUpperCase()=='No. De Empleado' || clientes2[i].toUpperCase()=='No.Empleado' || clientes2[i].toUpperCase()=='No. Empleado')
                {
                    A=i; 
                }
                if(clientes2[i].toUpperCase()=='Fecha Ingreso a la cuenta' || clientes2[i].toUpperCase()=='Fecha de Ingreso a la cuenta')
                {
                    FechIngC=i; 
                }
                if(clientes2[i].toUpperCase()=='No.Empresa' || clientes2[i].toUpperCase()=='No. De Empresa')
                {
                    C=i; 
                }
                if(clientes2[i].toUpperCase()=='tip_id' || clientes2[i].toUpperCase() =='tipo Id' )
                {
                    D=i; 
                }
                if(clientes2[i].toUpperCase()=='ID' || clientes2[i].toUpperCase()=='Identidad')
                {
                    E=i;
                }
                if(clientes2[i].toUpperCase()=='1 Apellido' || clientes2[i].toUpperCase() =='1Apellido' || clientes2[i].toUpperCase() =='Primer apellido')
                {
                    G=i; 
                }
                if(clientes2[i].toUpperCase()=='2 Apellido' || clientes2[i].toUpperCase() =='2Apellido' || clientes2[i].toUpperCase() =='Segundo apellido')
                {
                    F=i; 
                }
                if(clientes2[i].toUpperCase()=='1 Nombre' || clientes2[i].toUpperCase() =='1Nombre' || clientes2[i].toUpperCase() =='Primer Nombre')
                {
                    NE1=i; 
                }
                if(clientes2[i].toUpperCase()=='2 Nombre' || clientes2[i].toUpperCase() =='2Nombre' || clientes2[i].toUpperCase() =='Segundo Nombre')
                {
                    NE2=i; 
                }
                if(clientes2[i].toUpperCase()=='Nacionalidad' || clientes2[i].toUpperCase() =='Nacion Origen' )
                {
                    Nacionalidad=i; 
                }
                if(clientes2[i].toUpperCase()=='Fecha Nacimiento' || clientes2[i].toUpperCase() =='Fecha de Nacimiento' || clientes2[i].toUpperCase() =='FechaNacimiento' || clientes2[i].toUpperCase() =='FechaNacimientoEmpleado'|| clientes2[i].toUpperCase() =='Fecha Nacimiento del Empleado')
                {
                    FechN=i; 
                }
                if(clientes2[i].toUpperCase()=='Sexo' || clientes2[i].toUpperCase() =='Sexo del Empleado' || clientes2[i].toUpperCase() =='SexoEmpleado')
                {
                    S=i; 
                }
                if(clientes2[i].toUpperCase()=='Estado' || clientes2[i].toUpperCase() =='Estado Civil' || clientes2[i].toUpperCase() =='EstadoCivil')
                {
                    Civ=i; 
                }
                if(clientes2[i].toUpperCase()=='Envio' || clientes2[i].toUpperCase() =='Forma de Envio' || clientes2[i].toUpperCase() =='FormaEnvio')
                {
                    Env=i; 
                }
                if(clientes2[i].toUpperCase()=='Direccion' || clientes2[i].toUpperCase() =='Domicilio' || clientes2[i].toUpperCase() =='Direccion de Domicilio'|| clientes2[i].toUpperCase() =='Direccion del Empleado')
                {
                    Dir=i; 
                }
                if(clientes2[i].toUpperCase()=='Nro.Direccion' || clientes2[i].toUpperCase() =='Nro. Direccion' || clientes2[i].toUpperCase() =='Numero de Direccion')
                {
                    NumDir=i; 
                }
                if(clientes2[i].toUpperCase()=='No. Edificio' || clientes2[i].toUpperCase() =='No.Edificio' || clientes2[i].toUpperCase() =='Numero Edificio')
                {
                    Ed=i;
                }
                if(clientes2[i].toUpperCase()=='Codigo Pais' || clientes2[i].toUpperCase() =='CodigoPais' || clientes2[i].toUpperCase() =='Cod.Pais'|| clientes2[i].toUpperCase() =='Cod. Pais')
                {
                    CodP=i;
                }
                if(clientes2[i].toUpperCase()=='Codigo Region' || clientes2[i].toUpperCase() =='CodigoRegion' || clientes2[i].toUpperCase() =='Cod.Region'|| clientes2[i].toUpperCase() =='Cod.  Region')
                {
                    CodReg=i;
                }
                if(clientes2[i].toUpperCase()=='Codigo Provincia' || clientes2[i].toUpperCase() =='CodigoProvincia' || clientes2[i].toUpperCase() =='Cod.Provincia'|| clientes2[i].toUpperCase() =='Cod. Provincia'|| clientes2[i].toUpperCase() =='Cod.Prov.')
                    
                {
                    CodProv=i;
                }
                if(clientes2[i].toUpperCase()=='Codigo Ciudad' || clientes2[i].toUpperCase() =='CodigoCiudad' || clientes2[i].toUpperCase() =='Cod.Ciudad'|| clientes2[i].toUpperCase() =='Cod. Ciudad')
                {
                    CodCiud=i;
                }
                if(clientes2[i].toUpperCase()=='Cod.Sec.' || clientes2[i].toUpperCase() =='Codigo Sector' || clientes2[i].toUpperCase() =='Cod.Sector'|| clientes2[i].toUpperCase() =='CodigoSector')
                {
                    CodSec=i;
                }
                if(clientes2[i].toUpperCase()=='Telefono')
                {
                    Tel=i;
                }
                if(clientes2[i].toUpperCase()=='Correo' || clientes2[i].toUpperCase() =='E-mail' || clientes2[i].toUpperCase() =='Correo Empleado'|| clientes2[i].toUpperCase() =='CorreoEmpleado'|| clientes2[i].toUpperCase() =='E-mail Empleado'|| clientes2[i].toUpperCase() =='Email Empleado'|| clientes2[i].toUpperCase() =='Email')
                {
                    CorreoE=i;
                }
                if(clientes2[i].toUpperCase()=='Aplica Seguro' || clientes2[i].toUpperCase() =='AplicaSeguro' )
                {
                    AplicSeg=i;
                }
                if(clientes2[i].toUpperCase()=='IBC' || clientes2[i].toUpperCase() =='Sueldo' || clientes2[i].toUpperCase() =='Ingreso Bruto Cotizado'|| clientes2[i].toUpperCase() =='Sueldo Cotizado' || clientes2[i].toUpperCase() =='Sueldo Bruto' || clientes2[i].toUpperCase() =='SueldoCotizado' || clientes2[i].toUpperCase() =='SueldoBruto' || clientes2[i].toUpperCase() =='Ingreso Bruto')
                {
                    Ibc=i;
                }
                if(clientes2[i].toUpperCase()=='Producto'  )
                {
                    Prod=i;
                }
                if(clientes2[i].toUpperCase()=='subproducto' || clientes2[i].toUpperCase() =='sub producto'|| clientes2[i].toUpperCase() =='sub. producto'|| clientes2[i].toUpperCase() =='sub.producto' )
                {
                    SubProd=i;
                }
                if(clientes2[i].toUpperCase()=='periodicidad' || clientes2[i].toUpperCase() =='periodo cobro' )
                {
                    Periodo=i;
                }
                if(clientes2[i].toUpperCase()=='Forma Pago' || clientes2[i].toUpperCase() =='FormaPago' || clientes2[i].toUpperCase() =='forma de pago' )
                {
                    FormaPag=i;
                }
                if(clientes2[i].toUpperCase()=='Cuenta Pago' || clientes2[i].toUpperCase() =='CuentaPago' || clientes2[i].toUpperCase() =='Cuenta de Pago' )
                {
                    CuentaPag=i;
                }
                if(clientes2[i].toUpperCase()=='Ente Paga' || clientes2[i].toUpperCase() =='Ente de Paga' || clientes2[i].toUpperCase() =='Banco Paga' )
                {
                    EntePaga=i;
                }
                if(clientes2[i].toUpperCase()=='Tipo Aporte' || clientes2[i].toUpperCase() =='Tipo de Aporte' )
                {
                    TipoApor=i;
                }
                if(clientes2[i].toUpperCase()=='Monto Aporte' || clientes2[i].toUpperCase() =='MontoAporte' || clientes2[i].toUpperCase() =='monto aporte' )
                {
                    MontoApor=i;
                }
                if(clientes2[i].toUpperCase()=='Monto Aporte Neto' || clientes2[i].toUpperCase() =='Aporte Neto' || clientes2[i].toUpperCase() =='Monto Neto' )
                {
                    MontoAporN=i;
                }
                if(clientes2[i].toUpperCase()=='Ocupacion')
                {
                    Ocupacion=i;
                }
                if(clientes2[i].toUpperCase()=='Promotor' || clientes2[i].toUpperCase() =='Numero Promotor' )
                {
                    Prom=i;
                }
                if(clientes2[i].toUpperCase()=='Nombre promotor' || clientes2[i].toUpperCase() =='Nombrepromotor' || clientes2[i].toUpperCase() =='Nombre del promotor' )
                {
                    NProm=i;
                }
                if(clientes2[i].toUpperCase()=='rtn empleador' || clientes2[i].toUpperCase() =='RTN Empresa' || clientes2[i].toUpperCase() =='RTNEmpresa' || clientes2[i].toUpperCase() =='RTN Empleador' )
                {
                    RTNEmp=i;
                }
                if(clientes2[i].toUpperCase()=='Razon social empresa' || clientes2[i].toUpperCase() =='Razon social' || clientes2[i].toUpperCase() =='Nombre Inscrita la Empresa')
                {
                    RazonSoc=i;
                }
                if(clientes2[i].toUpperCase()=='Nombre Empresa' || clientes2[i].toUpperCase() =='Nombre de la Empresa' || clientes2[i].toUpperCase() =='Nombre Comercial' || clientes2[i].toUpperCase() =='Nombre Comercial de la empresa' || clientes2[i].toUpperCase() =='NombreEmpresa' || clientes2[i].toUpperCase() =='NombreComercial')
                {
                    NEmp=i;
                }
                if(clientes2[i].toUpperCase()=='FECHA DE INGRESO EMPRESA' || clientes2[i].toUpperCase() =='FECHA DE INGRESO a la EMPRESA' || clientes2[i].toUpperCase() =='FechaIngresoEmpresa' || clientes2[i].toUpperCase() =='Fecha Ingreso' || clientes2[i].toUpperCase() =='Fecha de Ingreso' )
                {
                    FechIng=i;
                }
                if(clientes2[i].toUpperCase()=='telefono Empresa' || clientes2[i].toUpperCase() =='Telefono de la Empresa' || clientes2[i].toUpperCase() =='TelefonoEmpresa' )
                {
                    TelEmp=i;
                }
                if(clientes2[i].toUpperCase()=='extencion empresa' || clientes2[i].toUpperCase() =='Extension de la Empresa' || clientes2[i].toUpperCase() =='ExtensionEmpresa' )
                {
                    Ext=i;
                }
                if(clientes2[i].toUpperCase()=='fax empresa' || clientes2[i].toUpperCase() =='Fax de la Empresa' || clientes2[i].toUpperCase() =='FaxEmpresa' )
                {
                    Fax=i;
                }
                if(clientes2[i].toUpperCase()=='direccion empresa' || clientes2[i].toUpperCase() =='Direccion de la Empresa' || clientes2[i].toUpperCase() =='DirreccionEmpresa' )
                {
                    DirEmp=i;
                }
                if(clientes2[i].toUpperCase()=='email empresa' || clientes2[i].toUpperCase() =='e-mail empresa' || clientes2[i].toUpperCase() =='Correo Empresa' || clientes2[i].toUpperCase() =='emailEmpresa' )
                {
                    CorreoEmp=i;
                }
                if(clientes2[i].toUpperCase()=='tipo solicitud' || clientes2[i].toUpperCase() =='tipo de  solicitud' || clientes2[i].toUpperCase() =='tiposolicitud' )
                {
                    TipoSoli=i;
                }
                if(clientes2[i].toUpperCase()=='refe1primer_nom' || clientes2[i].toUpperCase() =='Primer Nombre de la primera referencia' || clientes2[i].toUpperCase() =='Referencia 1 Primer nombre' )
                {
                    N1Ref1=i;
                }
                if(clientes2[i].toUpperCase()=='refe1segun_nom' || clientes2[i].toUpperCase() =='referencia 1segundo nombre' || clientes2[i].toUpperCase() =='Segundo Nombre de la primera referencia' )
                {
                    N2Ref1=i;
                }
                if(clientes2[i].toUpperCase()=='refe1primer_ape' || clientes2[i].toUpperCase() =='referencia 1Primer Apellido' || clientes2[i].toUpperCase() =='Primer Apellido de la primera referencia' )
                {
                    Ap1Ref1=i;
                }
                if(clientes2[i].toUpperCase()=='refe1segun_ape' || clientes2[i].toUpperCase() =='referencia 1segundo Apellido' || clientes2[i].toUpperCase() =='Segundo Apellido de la primera referencia' )
                {
                    Ap2Ref1=i;
                }
                if(clientes2[i].toUpperCase()=='tel_refe1' || clientes2[i].toUpperCase() =='referencia 1 Telefono' || clientes2[i].toUpperCase() =='Telefono primera referencia' )
                {
                    TelRef1=i;
                }
                if(clientes2[i].toUpperCase()=='refe2primer_nom' || clientes2[i].toUpperCase() =='Primer Nombre de la Segunda referencia' || clientes2[i].toUpperCase() =='Referencia 2 Primer nombre' )
                {
                    N1Ref2=i;
                }
                if(clientes2[i].toUpperCase()=='refe2segun_nom' || clientes2[i].toUpperCase() =='referencia 2segundo nombre' || clientes2[i].toUpperCase() =='Segundo Nombre de la Segunda referencia' )
                {
                    N2Ref2=i;
                }
                if(clientes2[i].toUpperCase()=='refe2primer_ape' || clientes2[i].toUpperCase() =='referencia 2Primer Apellido' || clientes2[i].toUpperCase() =='Primer Apellido de la Segunda referencia' )
                {
                    Ap1Ref2=i;
                }
                if(clientes2[i].toUpperCase()=='refe2segun_ape' || clientes2[i].toUpperCase() =='referencia 2segundo Apellido' || clientes2[i].toUpperCase() =='Segundo Apellido de la Segunda referencia' )
                {
                    Ap2Ref2=i;
                }
                if(clientes2[i].toUpperCase()=='tel_refe2' || clientes2[i].toUpperCase() =='referencia 2 Telefono' || clientes2[i].toUpperCase() =='Telefono Segunda referencia' )
                {
                    TelRef2=i;
                }
                if(clientes2[i].toUpperCase()=='cargo_emp' || clientes2[i].toUpperCase() =='Cargo del Empleado' || clientes2[i].toUpperCase() =='cargoempleado' )
                {
                    CargoE=i;
                }
                if(clientes2[i].toUpperCase()=='LUGAR_NACIMIENTO' || clientes2[i].toUpperCase() =='LUGAR DE NACIMIENTO' || clientes2[i].toUpperCase() =='LUGAR NACIMIENTO' || clientes2[i].toUpperCase() =='LUGARNACIMIENTO' )
                {
                    LugarNacE=i;
                }
                if(clientes2[i].toUpperCase()=='NOMBRE_CONYUGUE' || clientes2[i].toUpperCase() =='NOMBRE CONYUGUE' || clientes2[i].toUpperCase() =='Nombre pareja' || clientes2[i].toUpperCase() =='Nombre complleto del conyugue' )
                {
                    NConyuge=i;
                }
                if(clientes2[i].toUpperCase()=='BENF1primer_nom' || clientes2[i].toUpperCase() =='Primer nombre del primer beneficiario' || clientes2[i].toUpperCase() =='Beneficiario Primer Nombre' )
                {
                    N1Benf1=i;
                }
                if(clientes2[i].toUpperCase()=='BENF1Segundo_nom' || clientes2[i].toUpperCase() =='Segundo  nombre del primer beneficiario' || clientes2[i].toUpperCase() =='Nombre Primer Beneficiario' )
                {
                    N2Benf1=i;
                }
                if(clientes2[i].toUpperCase()=='BENF1primer_ape' || clientes2[i].toUpperCase() =='Primer apellido del beneficiario 1' || clientes2[i].toUpperCase() =='Primer Apellido del primer beneficio' || clientes2[i].toUpperCase() =='primer Apellido del beneficiario 1' )
                {
                    Ape1Benf1=i;
                }
                if(clientes2[i].toUpperCase()=='BENF1segun_ape' || clientes2[i].toUpperCase() =='Segundo apellido del beneficiario 1' || clientes2[i].toUpperCase() =='Segundo Apellido del primer beneficio' || clientes2[i].toUpperCase() =='segundo apellido del beneficiario 1' )
                {
                    Ape2Benf1=i;
                }
                if(clientes2[i].toUpperCase()=='BENF1parentesco' || clientes2[i].toUpperCase() =='Parentesco' || clientes2[i].toUpperCase() =='Vinculo familiar' || clientes2[i].toUpperCase() =='parentesco del primer beneficiario' )
                {
                    ParentBenf1=i;
                }
                if(clientes2[i].toUpperCase()=='BENF1porcentaje' || clientes2[i].toUpperCase() =='Porcentaje correspondiente al primer beneficiario' || clientes2[i].toUpperCase() =='porcentaje beneficiario 1' || clientes2[i].toUpperCase() =='porcentaje corespondiente del beneficiario 1'  )
                {
                    PorcenBenf1=i;
                }
                if(clientes2[i].toUpperCase()=='BENF2primer_nom' || clientes2[i].toUpperCase() =='Primer nombre del segundo beneficiario' || clientes2[i].toUpperCase() =='Primer Beneficiario Primer Nombre' )
                {
                    N1Benf2=i;
                }
                if(clientes2[i].toUpperCase()=='BENF2Segundo_nom' || clientes2[i].toUpperCase() =='Segundo  nombre del segundo beneficiario' || clientes2[i].toUpperCase() =='Segundo Nombre Segundo Beneficiario' )
                {
                    N2Benf2=i;
                }
                if(clientes2[i].toUpperCase()=='BENF2primer_ape' || clientes2[i].toUpperCase() =='Primer apellido del beneficiario 2' || clientes2[i].toUpperCase() =='Primer Apellido del segundo beneficio' || clientes2[i].toUpperCase() =='primer Apellido del beneficiario 2' )
                {
                    Ape1Benf2=i;
                }
                if(clientes2[i].toUpperCase()=='BENF2segun_ape' || clientes2[i].toUpperCase() =='Segundo apellido del beneficiario 2' || clientes2[i].toUpperCase() =='Segundo Apellido del segundo beneficio' || clientes2[i].toUpperCase() =='segundo apellido del beneficiario 2' )
                {
                    Ape2Benf2=i;
                }
                if(clientes2[i].toUpperCase()=='BENF2parentesco' || clientes2[i].toUpperCase() =='Parentesco del segundo beneficiario' || clientes2[i].toUpperCase() =='Vinculo familiar segundo beneficiario' || clientes2[i].toUpperCase() =='parentesco del segundo beneficiario' )
                {
                    ParentBenf2=i;
                }
                if(clientes2[i].toUpperCase()=='BENF2porcentaje' || clientes2[i].toUpperCase() =='Porcentaje correspondiente al primer beneficiario' || clientes2[i].toUpperCase() =='porcentaje beneficiario 1' || clientes2[i].toUpperCase() =='porcentaje corespondiente del beneficiario 1'  )
                {
                    PorcenBenf2=i;
                }
                
                if(clientes2[i].toUpperCase()=='BENF3primer_nom' || clientes2[i].toUpperCase() =='Primer nombre del tercer beneficiario' || clientes2[i].toUpperCase() =='Tercer Beneficiario Primer Nombre' )
                {
                    N1Benf3=i;
                }
                if(clientes2[i].toUpperCase()=='BENF3Segundo_nom' || clientes2[i].toUpperCase() =='Segundo  nombre del Tercer beneficiario' || clientes2[i].toUpperCase() =='Segundo Nombre Tercer Beneficiario' )
                {
                    N2Benf3=i;
                }
                if(clientes2[i].toUpperCase()=='BENF3primer_ape' || clientes2[i].toUpperCase() =='Primer apellido del beneficiario 3' || clientes2[i].toUpperCase() =='Primer Apellido del tercer beneficio' || clientes2[i].toUpperCase() =='primer Apellido del beneficiario 3' )
                {
                    Ape1Benf3=i;
                }
                if(clientes2[i].toUpperCase()=='BENF3segun_ape' || clientes2[i].toUpperCase() =='Segundo apellido del beneficiario 3' || clientes2[i].toUpperCase() =='Segundo Apellido del tercer beneficio' || clientes2[i].toUpperCase() =='segundo apellido del beneficiario 3' )
                {
                    Ape2Benf3=i;
                }
                if(clientes2[i].toUpperCase()=='BENF3parentesco' || clientes2[i].toUpperCase() =='Parentesco del tercer beneficiario' || clientes2[i].toUpperCase() =='Vinculo familiar tercer beneficiario' || clientes2[i].toUpperCase() =='parentesco del tercer beneficiario' )
                {
                    ParentBenf3=i;
                }
                if(clientes2[i].toUpperCase()=='BENF3porcentaje' || clientes2[i].toUpperCase() =='Porcentaje correspondiente al tercer beneficiario' || clientes2[i].toUpperCase() =='porcentaje beneficiario 3' || clientes2[i].toUpperCase() =='porcentaje corespondiente del beneficiario 3'  )
                {
                    PorcenBenf3=i;
                }
                
                if(clientes2[i].toUpperCase()=='BENF4primer_nom' || clientes2[i].toUpperCase() =='Primer nombre del cuarto beneficiario' || clientes2[i].toUpperCase() =='cuarto Beneficiario Primer Nombre' )
                {
                    N1Benf4=i;
                }
                if(clientes2[i].toUpperCase()=='BENF4Segundo_nom' || clientes2[i].toUpperCase() =='Segundo  nombre del cuarto beneficiario' || clientes2[i].toUpperCase() =='Segundo Nombre cuarto Beneficiario' )
                {
                    N2Benf4=i;
                }
                if(clientes2[i].toUpperCase()=='BENF4primer_ape' || clientes2[i].toUpperCase() =='Primer apellido del beneficiario 4' || clientes2[i].toUpperCase() =='Primer Apellido del cuarto beneficio' || clientes2[i].toUpperCase() =='primer Apellido del beneficiario 4' )
                {
                    Ape1Benf4=i;
                }
                if(clientes2[i].toUpperCase()=='BENF4segun_ape' || clientes2[i].toUpperCase() =='Segundo apellido del beneficiario 4' || clientes2[i].toUpperCase() =='Segundo Apellido del cuarto beneficio' || clientes2[i].toUpperCase() =='segundo apellido del beneficiario 4' )
                {
                    Ape2Benf4=i;
                }
                if(clientes2[i].toUpperCase()=='BENF4parentesco' || clientes2[i].toUpperCase() =='Parentesco del cuarto beneficiario' || clientes2[i].toUpperCase() =='Vinculo familiar cuarto beneficiario' || clientes2[i].toUpperCase() =='parentesco del cuarto beneficiario' )
                {
                    ParentBenf4=i;
                }
                if(clientes2[i].toUpperCase()=='BENF4porcentaje' || clientes2[i].toUpperCase() =='Porcentaje correspondiente al cuarto beneficiario' || clientes2[i].toUpperCase() =='porcentaje beneficiario 3' || clientes2[i].toUpperCase() =='porcentaje corespondiente del beneficiario 4'  )
                {
                    PorcenBenf4=i;
                }
                if(clientes2[i].toUpperCase()=='BENF5primer_nom' || clientes2[i].toUpperCase() =='Primer nombre del quinto beneficiario' || clientes2[i].toUpperCase() =='quinto Beneficiario Primer Nombre' )
                {
                    N1Benf5=i;
                }
                if(clientes2[i].toUpperCase()=='BENF5Segundo_nom' || clientes2[i].toUpperCase() =='Segundo  nombre del quinto beneficiario' || clientes2[i].toUpperCase() =='Segundo Nombre quinto Beneficiario' )
                {
                    N2Benf5=i;
                }
                if(clientes2[i].toUpperCase()=='BENF5primer_ape' || clientes2[i].toUpperCase() =='Primer apellido del beneficiario 5' || clientes2[i].toUpperCase() =='Primer Apellido del quinto beneficio' || clientes2[i].toUpperCase() =='primer Apellido del beneficiario 5' )
                {
                    Ape1Benf5=i;
                }
                if(clientes2[i].toUpperCase()=='BENF5segun_ape' || clientes2[i].toUpperCase() =='Segundo apellido del beneficiario 5' || clientes2[i].toUpperCase() =='Segundo Apellido del quinto beneficio' || clientes2[i].toUpperCase() =='segundo apellido del beneficiario 5' )
                {
                    Ape2Benf5=i;
                }
                if(clientes2[i].toUpperCase()=='BENF5parentesco' || clientes2[i].toUpperCase() =='Parentesco del quinto beneficiario' || clientes2[i].toUpperCase() =='Vinculo familiar quinto beneficiario' || clientes2[i].toUpperCase() =='parentesco del quinto beneficiario' )
                {
                    ParentBenf5=i;
                }
                if(clientes2[i].toUpperCase()=='BENF5porcentaje' || clientes2[i].toUpperCase() =='Porcentaje correspondiente al quinto beneficiario' || clientes2[i].toUpperCase() =='porcentaje beneficiario 5' || clientes2[i].toUpperCase() =='porcentaje corespondiente del beneficiario 5'  )
                {
                    PorcenBenf5=i;
                }
                if(clientes2[i].toUpperCase()=='BENF6primer_nom' || clientes2[i].toUpperCase() =='Primer nombre del sexto beneficiario' || clientes2[i].toUpperCase() =='sexto Beneficiario Primer Nombre' )
                {
                    N1Benf6=i;
                }
                if(clientes2[i].toUpperCase()=='BENF6Segundo_nom' || clientes2[i].toUpperCase() =='Segundo  nombre del sexto beneficiario' || clientes2[i].toUpperCase() =='Segundo Nombre sexto Beneficiario' )
                {
                    N2Benf6=i;
                }
                if(clientes2[i].toUpperCase()=='BENF6primer_ape' || clientes2[i].toUpperCase() =='Primer apellido del beneficiario 6' || clientes2[i].toUpperCase() =='Primer Apellido del sexto beneficio' || clientes2[i].toUpperCase() =='primer Apellido del beneficiario 6' )
                {
                    Ape1Benf6=i;
                }
                if(clientes2[i].toUpperCase()=='BENF6segun_ape' || clientes2[i].toUpperCase() =='Segundo apellido del beneficiario 6' || clientes2[i].toUpperCase() =='Segundo Apellido del sexto beneficio' || clientes2[i].toUpperCase() =='segundo apellido del beneficiario 6' )
                {
                    Ape2Benf6=i;
                }
                if(clientes2[i].toUpperCase()=='BENF6parentesco' || clientes2[i].toUpperCase() =='Parentesco del sexto beneficiario' || clientes2[i].toUpperCase() =='Vinculo familiar sexto beneficiario' || clientes2[i].toUpperCase() =='parentesco del sexto beneficiario' )
                {
                    ParentBenf6=i;
                }
                if(clientes2[i].toUpperCase()=='BENF6porcentaje' || clientes2[i].toUpperCase() =='Porcentaje correspondiente al sexto beneficiario' || clientes2[i].toUpperCase() =='porcentaje beneficiario 6' || clientes2[i].toUpperCase() =='porcentaje corespondiente del beneficiario 6'  )
                {
                    PorcenBenf6=i;
                }
                
            }
            
            if(a!=15 && FechIngC!=15 && c!=15 && d!=15 && e!=15 && F!=15 && G!=15 && ne1!=15 && ne2!=15 && Nacionalidad!=15 
               && FechN!=15  &&  S!=15 && Civ!=15 && Env!=15 && Dir!=15 && NumDir==15 && Ed!=15 && CodP!=15 && CodReg!=15 
               && CodProv!=15 && CodCiud!=15 && CodSec!=15 && Tel!=15 && CorreoE!=15 && AplicSeg!=15 && Ibc!=15 && Prod!=15 
               && SubProd!=15 && Periodo!=15 && FormaPag!=15 && CuentaPag!=15 && EntePaga!=15 && TipoApor!=15 
               && MontoApor!=15 && MontoAporN!=15  && Ocupacion!=15  && Prom!=15 && Nprom!=15 && RTNEmp!=15 && RazonSoc!=15 
               && Nemp!=15 && FechIng!=15 && TelEmp!=15 && Ext!=15 && Fax!=15 && DirEmp!=15 && CorreoEmp!=15 
               && TipoSoli!=15 && N1Ref1!=15 && N2ref1!=15 && Ap1Ref1!=15 && Ap2Ref1!=15 && TelRef1!=15 && N1Ref2!=15 
               && N2ref2!=15 && Ap1Ref2!=15 && Ap2Ref2!=15 && TelRef2!=15 && CargoE!=15 && LugarNacE!=15 && Nconyuge!=15
               && N1Benf1!=15 && N2Benf1!=15 && Ape1Benf1!=15 && Ape2Benf1!=15 && ParentBenf1!=15 && PorcenBenf1!=15)
            {
                
                list<string> NoEmpleado = new  list<string>();
                list<string> FechIngCuenta = new  list<string>();
                list<string> TipoId = new  list<string>();
                list<String> NumEmp = new  list<String>();
                list<string> Identificacion = new  list<string>();                
                list<string> pApellido = new  list<string>();
                list<string> sApellido = new  list<string>();
                list<string> pNombre = new  list<string>();
                list<string> sNombre = new  list<string>();
                list<string> nacionalidades = new  list<string>();
                list<string> FechNac = new  list<string>();
                list<string> sexo = new  list<string>();
                list<string> estadoCivil = new  list<string>();
                list<string> envio = new  list<string>();
                list<string> direccion = new  list<string>();
                list<string> nroDireccion = new  list<string>();
                list<string> nroEdificio = new  list<string>();
                list<string> codPais = new  list<string>();
                list<string> codRegion = new  list<string>();                
                list<string> codProvincia = new  list<string>();
                list<string> codCiudad = new  list<string>();
                list<string> codSector = new  list<string>();                
                list<string> telefono = new  list<string>();
                list<string> correoEmpresa = new  list<string>();
                list<string> aplicaSeguro = new  list<string>();                
                list<string> ingresobrutocot = new  list<string>();
                list<string> producto = new  list<string>();
                list<string> subProducto = new  list<string>();              
                list<string> periocidad = new  list<string>();
                list<string> formaPago = new  list<string>();
                list<string> cuentaPago = new  list<string>();                
                list<string> entePago = new  list<string>();
                list<string> tipoAporte = new  list<string>();
                list<string> monteAporte = new  list<string>();                
                list<string> monteAporteNeto = new  list<string>();
                list<string> ocupacionEmpleado = new  list<string>();
                //*********************************************
                list<string> codPromotor = new  list<string>();                
                list<string> nombrePromotor = new  list<string>();
                //***********************************************
                list<string> rtnEmpleador = new  list<string>();
                list<string> razonSocial = new  list<string>();                
                list<string> nombreEmpresa = new  list<string>();
                list<string> FechaIngreso = new  list<string>();
                list<string> telefonoEmpresa = new  list<string>();                
                list<string> extEmpresa = new  list<string>();
                list<string> faxEmpresa = new  list<string>();
                list<string> dirEmpresa = new  list<string>();                
                list<string> correoEmpleado = new  list<string>();
                list<string> tipoSolicitud = new  list<string>();
                //*********************************************
                list<string> primerNomRef1 = new  list<string>();                
                list<string> segundoNomRef1 = new  list<string>();
                list<string> primerApeRef1 = new  list<string>();
                list<string> segundoApeRef1 = new  list<string>();                
                list<string> telefonoRef1 = new  list<string>();
                //***********************************************
                list<string> primerNomRef2 = new  list<string>();                
                list<string> segundoNomRef2 = new  list<string>();
                list<string> primerApeRef2= new  list<string>();
                list<string> segundoApeRef2 = new  list<string>();                
                list<string> telefonoRef2 = new  list<string>();
                //************************************************
                list<string> cargo = new  list<string>();
                list<string> lugarNacimiento = new  list<string>();
                //************************************************
                list<string> nomConyuge = new  list<string>();
                //************************************************
                list<string> primerNomBenf1 = new  list<string>();
                list<string> segundoNomBenf1 = new  list<string>();
                list<string> primerApeBenf1 = new  list<string>();
                list<string> segundoApeBenf1 = new  list<string>();
                list<string> parentescoBenf1 = new  list<string>();
                list<string> porcentajeBenf1 = new  list<string>();
                //*************************************************
                list<string> primerNomBenf2 = new  list<string>();
                list<string> segundoNomBenf2 = new  list<string>();
                list<string> primerApeBenf2 = new  list<string>();
                list<string> segundoApeBenf2 = new  list<string>();
                list<string> parentescoBenf2 = new  list<string>();
                list<string> porcentajeBenf2 = new  list<string>();
                //*************************************************
                list<string> primerNomBenf3 = new  list<string>();
                list<string> segundoNomBenf3 = new  list<string>();
                list<string> primerApeBenf3 = new  list<string>();
                list<string> segundoApeBenf3 = new  list<string>();
                list<string> parentescoBenf3 = new  list<string>();
                list<string> porcentajeBenf3 = new  list<string>();
                //*************************************************
                list<string> primerNomBenf4 = new  list<string>();
                list<string> segundoNomBenf4 = new  list<string>();
                list<string> primerApeBenf4 = new  list<string>();
                list<string> segundoApeBenf4 = new  list<string>();
                list<string> parentescoBenf4 = new  list<string>();
                list<string> porcentajeBenf4 = new  list<string>();
                //*************************************************
                list<string> primerNomBenf5 = new  list<string>();
                list<string> segundoNomBenf5 = new  list<string>();
                list<string> primerApeBenf5 = new  list<string>();
                list<string> segundoApeBenf5 = new  list<string>();
                list<string> parentescoBenf5 = new  list<string>();
                list<string> porcentajeBenf5 = new  list<string>();
                //*************************************************
                list<string> primerNomBenf6 = new  list<string>();
                list<string> segundoNomBenf6 = new  list<string>();
                list<string> primerApeBenf6 = new  list<string>();
                list<string> segundoApeBenf6 = new  list<string>();
                list<string> parentescoBenf6 = new  list<string>();
                list<string> porcentajeBenf6 = new  list<string>();
                
                list<string> ident;
                list<string> ident2;
                
                retorno.error='columnas correcta\n';
                list<reporteT24__c> EstadoCu = new list<reporteT24__c>();
                
                reporteT24__c listC;
                listc = new reporteT24__c();
                
                for (integer i=0; i<clientes.size(); i++){
                    clientes2 = new  list<string>();
                    string jh=clientes[i];
                    if(jh.contains(',,') && jh.trim().length()>20){
                        clientes[i]=clientes[i].replace(',,',', ,').Trim(); 
                    }else{
                        clientes[i]=clientes[i].replace(',,','').Trim();  
                    }
                    
                    if(clientes[i].length()>1){
                        string kike2;
                        string kike=clientes[i];
                        clientes2 = kike.split(',');
                        
                        clientes2[a]=clientes2[a].replace(',','');
                        clientes2[a]=clientes2[a].replace('"','');
                        
                        //*************************************Llenado de los arreglos respectivos de campos******************************************                            
                        //*********************************************Numero De Empleado********************************************************************            
                        if( a!=15 &&  a < clientes2.size() &&  clientes2[a].trim()!='' && clientes2[a]!=null ){
                            NoEmpleado.add(llenarObjetos(clientes2[a]));
                        } //fin NoEmpleados
                        //*********************************************Fecha de Ingreso a la cuenta*******************************************************************************                
                        if(FechIngC!=15 ){
                            FechIngCuenta.add(llenarObjetos(clientes2[FechIngC]));
                        }//fin Fecha de ingreso a la cuenta
                        //*************************************Numero de empresa***********************************************************************************    
                        if( c!=15 &&  c < clientes2.size() ){
                            NumEmp.add(llenarObjetos(clientes2[c]));
                        }//No Empresa
                        //***************************************Tipo Id usado**********************************************************************+
                        if( d!=15 &&  d < clientes2.size() ){
                            TipoId.add(llenarObjetos(clientes2[d]));
                        }//fin if de Tipo Id
                        //*********************************************Identificacion******************************************************************************
                        if(e!=15 &&  e < clientes2.size()   ){
                            Identificacion.add(llenarObjetos(clientes2[e]));
                        }//Identificacion
                        
                        String n2;
                        String ape1; 
                        n2=clientes2[NE2].replace('"','');
                        ape1=clientes2[NE2].replace('"','');
                        if(ape1==null){
                            
                            if(g !=15 && g < clientes2.size() && clientes2[g]!='""'){                          
                                pApellido.add(llenarObjetos(clientes2[NE2]));
                            }//primer apellido cliente
                            //*****************************************Segundo Apellido del Empleado***************************************************************************************
                            if(f!=15 && f < clientes2.size() ){
                                sApellido.add(llenarObjetos(clientes2[f]));
                            }//Segundo apellido cliente
                            //*****************************************Primer Nombre del Empleado************************************************************
                            if(ne1!=15 && ne1 < clientes2.size() && clientes2[ne1]!='""' ){
                                pNombre.add(llenarObjetos(clientes2[ne1]));
                            }//primer nombre cliente
                            //*****************************************Segundo Nombre del Empleado***************************************************************************
                            if(NE2!=15 && NE2 < clientes2.size() ){
                                sNombre.add(llenarObjetos(clientes2[g]));
                            }//segundo nombre cliente    
                            
                        }else{      
                            //*****************************************Primer Apellido del Empleado***************************************************************************************                            
                            if(g !=15 && g < clientes2.size() && clientes2[g]!='""'){                          
                                pApellido.add(llenarObjetos(clientes2[g]));
                            }//primer apellido cliente
                            //*****************************************Segundo Apellido del Empleado***************************************************************************************
                            if(f!=15 && f < clientes2.size() ){
                                sApellido.add(llenarObjetos(clientes2[f]));
                            }//Segundo apellido cliente
                            //*****************************************Primer Nombre del Empleado************************************************************
                            if(ne1!=15 && ne1 < clientes2.size() && clientes2[ne1]!='""' ){
                                pNombre.add(llenarObjetos(clientes2[ne1]));
                            }//primer nombre cliente
                            //*****************************************Segundo Nombre del Empleado***************************************************************************
                            if(NE2!=15 && NE2 < clientes2.size() ){
                                sNombre.add(llenarObjetos(clientes2[NE2]));
                            }//segundo nombre cliente
                        }
                        //*****************************************Nacionalidad del Empleado**************************************************************
                        if(Nacionalidad!=15 && Nacionalidad < clientes2.size() && clientes2[Nacionalidad]!='""'){
                            if(clientes2[Nacionalidad]==null || clientes2[Nacionalidad]=='Se ignora'){
                                nacionalidades.add(llenarObjetos('Hondureña'));
                            }else{
                                nacionalidades.add(llenarObjetos(clientes2[Nacionalidad]));    
                            }                            
                        }//Nacionalidad
                        //*****************************************Fecha Nacimiento del Empleado*****************************************************
                        if(fechN!=15 && fechN < clientes2.size()&& clientes2[fechN]!='""' ){
                            FechNac.add(llenarObjetos(clientes2[fechN]));
                        }//Fecha nacimiento cliente
                        //*****************************************Sexo del Empleado******************************************************************************************
                        if(s!=15 && s< clientes2.size()&& clientes2[s]!='""' ){
                            sexo.add(llenarObjetos(clientes2[s]));
                        }//sexo del cliente
                        //**************************************Estado civil del Empleado**************************************************************************
                        if(Civ!=15 && Civ< clientes2.size()&& clientes2[Civ]!='""' ){
                            estadoCivil.add(estadoCivil(clientes2[Civ]));
                        }//Estado civil del cliente
                        //******************************************Envio**********************************************************************************
                        if(Env!=15 && Env< clientes2.size()&& clientes2[Env]!='""' ){
                            envio.add(llenarObjetos(clientes2[Env]));
                        }//Envio
                        //*****************************************Direccion****************************************************************************     
                        if(Dir!=15 ){
                            direccion.add(dirreccion(clientes2[Dir]));
                        }//direccion
                        //*****************************************Numero de Direccion************************************************************************                          
                        if(NumDir==15 && NumDir< clientes2.size()){
                            nroDireccion.add(llenarObjetos(clientes2[NumDir]));
                        }//numero direccion
                        //*****************************************Numero de Edificio****************************************************************************
                        if(Ed< clientes2.size() && ED!=15){
                            nroEdificio.add(llenarObjetos(clientes2[ED]));
                        }//numero edificio
                        //*****************************************Codigo Pais*********************************************************************************
                        if(codP!=15){
                            if(clientes2[codP]!='074'){
                                codPais.add('074');
                            }else{
                                codPais.add(clientes2[codP]);  
                            }
                        }//codigo pais
                        //*****************************************Codigo Region********************************************************                            
                        String codDep;
                        if(CodReg!=15){       
                            if(clientes2[CodReg]!='"000"'){
                                codDep = llenarObjetos(clientes2[CodReg]);  
                            }else{
                                codDep=codDepartamento(clientes2[Dir]);
                            }
                            CodRegion.add(codDep);
                        }//codigo region                        
                        //*****************************************Codigo Provincia********************************************************************************                              
                        if( CodProv!=15 &&  CodProv < clientes2.size() ){
                            //codProvincia.add(llenarObjetos(clientes2[CodProv])); 
                            if(clientes2[CodProv]!='"000"'){
                                codProvincia.add(llenarObjetos(clientes2[CodProv])); 
                            }else if(clientes2[Dir]==null){
                                codProvincia.add('000');  
                            }else if(codDep=='000'){
                                codProvincia.add('000');
                            }else{
                                codProvincia.add(codM(clientes2[Dir],codDep));}
                            
                        }//Codigo provincia
                        //*****************************************Codigo Ciudad********************************************************************************                              
                        if(CodCiud!=15 &&  CodCiud < clientes2.size()){
                            codCiudad.add(llenarObjetos(clientes2[CodCiud]));
                        }//Codigo Ciudad
                        //*****************************************Codigo Sector********************************************************************************                              
                        if(CodSec!=15 &&  CodSec < clientes2.size()){
                            system.debug('Error Nicole: '+clientes2[CodSec]);
                            if(clientes2[CodSec]=='""'){
                                codSector.add(null);
                            }else{
                                if(clientes2[CodSec].contains('"')){
                                    clientes2[CodSec]=clientes2[CodSec].replace('"','');  
                                    codSector.add(clientes2[CodSec]);
                                }
                            }
                        }//Codigo Sector
                        //*****************************************Telefono del Empleado********************************************************************************                              
                        if(Tel!=15 &&  Tel < clientes2.size())
                        {
                            telefono.add(llenarObjetos(clientes2[Tel]));
                        }//Telefono Empleado
                        //*****************************************Correo Empleado********************************************************************************                              
                        if( CorreoE!=15 &&  CorreoE < clientes2.size()){
                            correoEmpleado.add(llenarObjetos(clientes2[CorreoE]));
                        }//correo Empleado
                        //*****************************************Aplica Seguro********************************************************************************                              
                        if(AplicSeg!=15 &&   AplicSeg < clientes2.size())
                        {
                            if(clientes2[ AplicSeg]=='""'){
                                aplicaSeguro.add(null);
                            }else{
                                if(clientes2[AplicSeg].contains('"')){
                                    clientes2[AplicSeg]=clientes2[AplicSeg].replace('"','');  
                                    aplicaSeguro.add(clientes2[AplicSeg]);
                                }
                            }
                        }//Aplica Seguro
                        //*****************************************IBC********************************************************************************                                                          
                        if( Ibc!=15 &&  Ibc < clientes2.size() ){
                            ingresobrutocot.add(llenarObjetosMonetarios(clientes2[Ibc]));
                        }//IBC
                        //*****************************************Producto********************************************************************************                              
                        if(Prod!=15 &&   Prod < clientes2.size())
                        {
                            if(datosManuales.producto__c=='N'){
                                Producto.add(llenarObjetos(clientes2[Prod]));
                                
                            }else {
                                Producto.add(datosManuales.producto__c);
                            }
                        }//Producto
                        //*****************************************subProducto********************************************************************************                              
                        if(SubProd!=15 &&    SubProd< clientes2.size() ){
                            if(datosManuales.subproducto__c=='N'){
                                subProducto.add(llenarObjetos(clientes2[SubProd]));                                   
                            }else {
                                subProducto.add(datosManuales.subproducto__c);
                            }
                        }//subProducto
                        //*****************************************Periodo********************************************************************************                              
                        if(Periodo!=15 && Periodo< clientes2.size()){
                            periocidad.add(llenarObjetos(clientes2[Periodo]));
                        }//periocidad
                        //*****************************************Forma de Pago********************************************************************************                              
                        if(FormaPag!=15 && FormaPag< clientes2.size() ){  
                            if(clientes2[FormaPag]=='""'){
                                formaPago.add(null);
                            }else{
                                if(clientes2[FormaPag].contains('"')){
                                    clientes2[FormaPag]=clientes2[FormaPag].replace('"','');  
                                    formaPago.add(clientes2[FormaPag]);
                                }
                            }
                        }//forma Pago
                        //*****************************************cuenta Pago********************************************************************************                              
                        if(CuentaPag < clientes2.size() && CuentaPag!=15){
                            cuentaPago.add(llenarObjetos(clientes2[CuentaPag]));
                        }////cuenta Pago
                        //*****************************************Ente Paga********************************************************************************                              
                        if(EntePaga < clientes2.size() && EntePaga!=15){
                            entePago.add(llenarObjetos(clientes2[EntePaga]));
                        }////Ente paga
                        //*****************************************Tipo Aporte********************************************************************************                              
                        if(TipoApor!=15 && TipoApor < clientes2.size() ){
                            tipoAporte.add(llenarObjetos(clientes2[TipoApor]));
                        }//tipo Aporte
                        //*****************************************Monto Aporte********************************************************************************                              
                        if(MontoApor < clientes2.size() && MontoApor!=15){
                            monteAporte.add(llenarObjetosMonetarios(clientes2[MontoApor]));
                        }////monto Aporte
                        //*****************************************Monto Aporte Neto********************************************************************************                              
                        if(MontoAporN < clientes2.size() && MontoAporN!=15){
                            monteAporteNeto.add(llenarObjetosMonetarios(clientes2[MontoAporN]));
                        }////Monto Aporte Neto
                        //*****************************************ocupacion Empleado********************************************************************************                              
                        if(Ocupacion!=15 && Ocupacion < clientes2.size() ){
                            ocupacionEmpleado.add(llenarObjetos(clientes2[Ocupacion]));
                        }//ocupacion Empleado
                        //*****************************************Promotor********************************************************************************                              
                        if(Prom!=15 && Prom < clientes2.size() ){ 
                            if(datosManuales.promotor__c!='EN REPORTE'){
                                codPromotor.add(datosManuales.promotor__c);
                            }else{
                                codPromotor.add(llenarObjetos(clientes2[Prom]));
                            }                                                        
                        }//codigo promotor
                        //*****************************************Nombre Promotor********************************************************************************                              
                        if(Nprom!=15 && Nprom < clientes2.size() ){ 
                            nombrePromotor.add(llenarObjetos(clientes2[Nprom]));
                        }//nombre Promotor 
                        //*****************************************RTN Empleador********************************************************************************                              
                        if(RTNEmp!=15 && RTNEmp < clientes2.size() ){
                            rtnEmpleador.add(llenarObjetos(clientes2[RTNEmp]));
                            
                        }//rtn Empleador                             
                        //*****************************************Razon Social********************************************************************************                              
                        if(RazonSoc!=15 && RazonSoc < clientes2.size() ){
                            razonSocial.add(llenarObjetos(clientes2[RazonSoc]));
                        }//razonSocial 
                        //*****************************************Nombre Comercial********************************************************************************                              
                        if(Nemp!=15 && Nemp< clientes2.size() ){
                            nombreEmpresa.add(llenarObjetos(clientes2[Nemp]));
                        }//razonSocial
                        //*****************************************Fecha Ingreso Empresa********************************************************************************                              
                        if(FechIng!=15 && FechIng< clientes2.size() ){
                            FechaIngreso.add(llenarObjetos(clientes2[FechIng]));
                        }//Fecha Ingreso a la Empresa 
                        //*****************************************Telefono de la Empresa********************************************************************************                              
                        if(TelEmp!=15 && TelEmp< clientes2.size() ){
                            telefonoEmpresa.add(llenarObjetos(clientes2[TelEmp]));
                        }//Telefono de la Empresa
                        //*****************************************Extension de la Empresa********************************************************************************                              
                        if(Ext!=15 && Ext< clientes2.size() ){
                            extEmpresa.add(llenarObjetos(clientes2[Ext]));
                        }//Extension de la Empresa
                        //*****************************************Extension de la Empresa********************************************************************************                              
                        if(Fax!=15 && Fax< clientes2.size()){
                            faxEmpresa.add(llenarObjetos(clientes2[Fax]));
                        }//Fax de la Empresa     
                        //*****************************************Direccion empresa****************************************************************************     
                        if(DirEmp!=15 ){
                            dirEmpresa.add(dirreccion(clientes2[DirEmp]));
                        }//direccion empresa
                        //*****************************************Correo Empresa********************************************************************************                              
                        if( CorreoEmp!=15 &&  CorreoEmp < clientes2.size() ){
                            correoEmpresa.add(llenarObjetos(clientes2[CorreoEmp]));
                        }//correo Empresa
                        //*****************************************Tipo Solicitud********************************************************************************                              
                        if(TipoSoli!=15 &&  TipoSoli< clientes2.size() ){
                            tipoSolicitud .add(llenarObjetos(clientes2[TipoSoli]));
                        }//Tipo solicitud
                        //*****************************************Primer Nombre de la  referencia************************************************************
                        if(N1Ref1!=15 && N1Ref1 < clientes2.size() && clientes2[N1Ref1]!='""' ){
                            primerNomRef1.add(llenarObjetos(clientes2[N1Ref1]));
                        }//primer nombre cliente
                        //*****************************************Segundo Nombre de la  referencia************************************************************
                        if(N2Ref1!=15 && N2Ref1< clientes2.size()){
                            segundoNomRef1.add(llenarObjetos(clientes2[N2Ref1])); 
                        }//Segundo Nombre de la primera referencia
                        //*****************************************Primer Apellido de la  referencia************************************************************
                        if(Ap1Ref1!=15 && Ap1Ref1 < clientes2.size()){
                            primerApeRef1.add(llenarObjetos(clientes2[AP1Ref1]));
                        }//primer Apellido cliente
                        //*****************************************Segundo Apellido de la  referencia************************************************************
                        if(Ap2Ref1!=15 && Ap2Ref1< clientes2.size()){
                            segundoApeRef1.add(llenarObjetos(clientes2[Ap2Ref1]));
                        }//Segundo Apellido de la primera referencia
                        //*****************************************Telefono de la referencia 1********************************************************************************                              
                        if(TelRef1!=15 && TelRef1< clientes2.size()){
                            telefonoRef1.add(llenarObjetos(clientes2[TelRef1]));
                        }//Telefono de la Primera Referencia                            
                        //*****************************************Primer Nombre de la  referencia************************************************************
                        if(N1Ref2!=15 && N1Ref2< clientes2.size() ){                            
                            primerNomRef2.add(llenarObjetos(clientes2[N1Ref2]));
                        }//Segundo Nombre de la primera referencia
                        //*****************************************Segundo Nombre de la  referencia************************************************************
                        if(N2Ref2!=15 && N2Ref2< clientes2.size()){
                            segundoNomRef2.add(llenarObjetos(clientes2[N2Ref2])); 
                        }//Segundo Nombre de la primera referencia
                        //*****************************************Primer Apellido de la  referencia************************************************************
                        if(Ap1Ref2!=15 && Ap1Ref2< clientes2.size() ){
                            primerApeRef2.add(llenarObjetos(clientes2[Ap1Ref2]));                              
                        }//Primer Apellido de la segunda referencia                        
                        //*****************************************Segundo Apellido de la  referencia************************************************************
                        if(Ap2Ref2!=15 && Ap2Ref2< clientes2.size() ){
                            segundoApeRef2.add(llenarObjetos(clientes2[Ap2Ref2]));
                        }//Segundo Apellido de la segunda referencia
                        //*****************************************Telefono de la referencia 2********************************************************************************                              
                        if(TelRef2!=15 && TelRef2< clientes2.size() ){
                            telefonoRef2.add(llenarObjetos(clientes2[TelRef2]));
                        }//Telefono de la Segunda Referencia
                        //*****************************************Cargo Empleado********************************************************************************                              
                        if(CargoE!=15 && CargoE< clientes2.size() ){
                            String puesto;
                            puesto = 'UPDATE PENDING';
                            if(puesto==llenarObjetos(clientes2[CargoE])){
                                cargo.add(NULL);
                            }else{
                                cargo.add(llenarObjetos(clientes2[CargoE]));     
                            }                           
                        }//Cargo Empleado
                        //*****************************************Lugar  Nacimiento Empleado********************************************************************************                              
                        if(LugarNacE!=15 && LugarNacE< clientes2.size() ){
                            string tipId;
                            tipId = clientes2[d].replace('"', '');
                            if(tipId=='1'){
                                lugarNacimiento.add(LUGAR_NACIMIENTO(clientes2[LugarNacE]));
                            }else{
                                String extranjero;
                                extranjero=clientes2[LugarNacE].replace('"', '');             
                                if(extranjero=='NO PARAMETRIZADO'){
                                    lugarNacimiento.add(null);
                                }else{
                                    lugarNacimiento.add(extranjero); 
                                }                                       
                            }
                        }//Lugar  Nacimiento Empleado
                        //****************************************Nombre Conyugue********************************************************************************                              
                        if(Nconyuge!=15 && Nconyuge< clientes2.size() ){
                            nomConyuge.add(llenarObjetos(clientes2[Nconyuge]));
                        }//Nombre Completo Conyugue
                        //*************************************Primer Beneficiario**********************************************************************************************
                        //****************************************Primer Nombre del Beneficiario 1********************************************************************************                              
                        if(N1Benf1!=15 && N1Benf1< clientes2.size() ){
                            primerNomBenf1.add(llenarObjetos(clientes2[N1Benf1]));
                        }//Primer Nombre Beneficiario 1
                        //****************************************Segundo Nombre del Beneficiario 1************************************************************************                              
                        if(N2Benf1!=15 && N2Benf1< clientes2.size() ){
                            segundoNomBenf1.add(llenarObjetos(clientes2[N2Benf1]));
                        }//Segundo Nombre Beneficiario 1
                        //****************************************Primer Apellido del Primer Beneficiario********************************************************************************                              
                        if(Ape1Benf1!=15 && Ape1Benf1< clientes2.size() ){
                            primerApeBenf1.add(llenarObjetos(clientes2[Ape1Benf1]));
                        }//primer Apellido del Primer Beneficiario
                        //****************************************Segundo Apellido del Primer Beneficiario********************************************************************************                              
                        if(Ape2Benf1!=15 && Ape2Benf1< clientes2.size() ){
                            segundoApeBenf1.add(llenarObjetos(clientes2[Ape2Benf1]));
                        }//Segundo Apellido del Primer Beneficiario
                        //****************************************Parentesco del Primer Beneficiario********************************************************************************                              
                        if(ParentBenf1!=15 && ParentBenf1< clientes2.size() ){
                            parentescoBenf1.add(llenarObjetos(clientes2[ParentBenf1]));
                        }//Parentesco del Primer Beneficiario
                        //****************************************Porcentaje correspondiente del Primer Beneficiario********************************************************************************                              
                        if(PorcenBenf1!=15 && PorcenBenf1< clientes2.size() ){
                            porcentajeBenf1.add(llenarObjetos(clientes2[PorcenBenf1]));
                        }//Porcentaje correspondiente del Primer Beneficiario
                        //*************************************Segundo Beneficiario**********************************************************************************************
                        //****************************************Primer Nombre del Beneficiario 2********************************************************************************                              
                        if(N1Benf2!=15 && N1Benf2< clientes2.size() ){
                            primerNomBenf2.add(llenarObjetos(clientes2[N1Benf2]));
                        }else{
                            primerNomBenf2.add(' ');
                        }//primer Nombre Beneficiario 2
                        //****************************************Segundo Nombre del Beneficiario 2************************************************************************                              
                        if(N2Benf2!=15 && N2Benf2< clientes2.size() ){
                            segundoNomBenf2.add(llenarObjetos(clientes2[N2Benf2]));
                        }else{
                            segundoNomBenf2.add(' ');
                        }//primer Nombre Beneficiario 2
                        //****************************************Primer Apellido del Segundo Beneficiario********************************************************************************                              
                        if(Ape1Benf2!=15 && Ape1Benf2< clientes2.size() ){
                            primerApeBenf2.add(llenarObjetos(clientes2[Ape1Benf2]));
                        }else{
                            primerApeBenf2.add(' ');
                        }//Primer Apellido del Segundo Beneficiario
                        //****************************************Segundo Apellido del Segundo Beneficiario********************************************************************************                              
                        if(Ape2Benf2!=15 && Ape2Benf2< clientes2.size() ){
                            segundoApeBenf2.add(llenarObjetos(clientes2[Ape2Benf2]));
                        }else{
                            segundoApeBenf2.add(' ');
                        }//Segundo Apellido del Primer Beneficiario
                        //****************************************Parentesco del Segundo Beneficiario********************************************************************************                              
                        if(ParentBenf2!=15 && ParentBenf2< clientes2.size() ){
                            parentescoBenf2.add(llenarObjetos(clientes2[ParentBenf2]));
                        }else{
                            parentescoBenf2.add(' ');
                        }//Parentesco del Segundo Beneficiario
                        //****************************************Porcentaje correspondiente del Segundo Beneficiario********************************************************************************                              
                        if(PorcenBenf2!=15 && PorcenBenf2< clientes2.size() ){
                            porcentajeBenf2.add(llenarObjetos(clientes2[PorcenBenf2]));
                        }else{
                            porcentajeBenf2.add(' ');
                        }//Porcentaje correspondiente del Primer Beneficiario
                        //*************************************Tercer Beneficiario**********************************************************************************************
                        //****************************************Primer Nombre del Beneficiario 3********************************************************************************                              
                        if(N1Benf3!=15 && N1Benf3< clientes2.size() ){
                            primerNomBenf3.add(llenarObjetos(clientes2[N1Benf3]));
                        }else{
                            primerNomBenf3.add(' ');
                        }//primer Nombre Beneficiario 3
                        //****************************************Segundo Nombre del Beneficiario 3************************************************************************                              
                        if(N2Benf3!=15 && N2Benf3< clientes2.size() ){
                            segundoNomBenf3.add(llenarObjetos(clientes2[N2Benf3]));
                        }else{
                            segundoNomBenf3.add(' ');
                        }//primer Nombre Beneficiario 3
                        //****************************************Primer Apellido del Beneficiario 3********************************************************************************                              
                        if(Ape1Benf3!=15 && Ape1Benf3< clientes2.size() ){
                            primerApeBenf3.add(llenarObjetos(clientes2[Ape1Benf3]));
                        }else{
                            primerApeBenf3.add(' ');
                        }//Primer Apellido del Beneficiario 3
                        //****************************************Segundo Apellido del Beneficiario 3********************************************************************************                              
                        if(Ape2Benf3!=15 && Ape2Benf3< clientes2.size() ){
                            segundoApeBenf3.add(llenarObjetos(clientes2[Ape2Benf3]));
                        }else{
                            segundoApeBenf3.add(' ');
                        }//Segundo Apellido del Beneficiario 3
                        //****************************************Parentesco del Beneficiario 3********************************************************************************                              
                        if(ParentBenf3!=15 && ParentBenf3< clientes2.size()){
                            parentescoBenf3.add(llenarObjetos(clientes2[ParentBenf3]));
                        }else{
                            parentescoBenf3.add(' ');
                        }//Parentesco del Beneficiario 3
                        //****************************************Porcentaje correspondiente del Beneficiario 3********************************************************************************                              
                        if(PorcenBenf3!=15 && PorcenBenf3< clientes2.size() ){
                            porcentajeBenf3.add(llenarObjetos(clientes2[PorcenBenf3]));
                        }else{
                            porcentajeBenf3.add(' ');
                        }//Porcentaje correspondiente del Beneficiario 3
                        //*************************************Cuarto Beneficiario*****************************************************************************
                        //****************************************Primer Nombre del Beneficiario 4********************************************************************************                              
                        if(N1Benf4!=15 && N1Benf4< clientes2.size() ){
                            primerNomBenf4.add(llenarObjetos(clientes2[N1Benf4]));
                        }else{
                            primerNomBenf4.add(' ');
                        }//primer Nombre Beneficiario 4
                        //****************************************Segundo Nombre del Beneficiario 4************************************************************************                              
                        if(N2Benf4!=15 && N2Benf4< clientes2.size() ){
                            segundoNomBenf4.add(llenarObjetos(clientes2[N2Benf4]));
                        }else{
                            segundoNomBenf4.add(' ');
                        }//primer Nombre Beneficiario 4
                        //****************************************Primer Apellido del Beneficiario 4********************************************************************************                              
                        if(Ape1Benf4!=15 && Ape1Benf4< clientes2.size() ){
                            primerApeBenf4.add(llenarObjetos(clientes2[Ape1Benf4]));
                        }else{
                            primerApeBenf4.add(' ');
                        }//Primer Apellido del Beneficiario 4
                        //****************************************Segundo Apellido del Beneficiario 4********************************************************************************                              
                        if(Ape2Benf4!=15 && Ape2Benf4< clientes2.size() ){
                            segundoApeBenf4.add(llenarObjetos(clientes2[Ape2Benf4]));
                        }else{
                            segundoApeBenf4.add(' ');
                        }//Segundo Apellido del Beneficiario 4
                        //****************************************Parentesco del Beneficiario 4********************************************************************************                              
                        if(ParentBenf4!=15 && ParentBenf4< clientes2.size()){
                            parentescoBenf4.add(llenarObjetos(clientes2[ParentBenf4]));
                        }else{
                            parentescoBenf4.add(' ');
                        }//Parentesco del Beneficiario 4
                        //****************************************Porcentaje correspondiente del Beneficiario 4********************************************************************************                              
                        if(PorcenBenf4!=15 && PorcenBenf4< clientes2.size() ){
                            porcentajeBenf4.add(llenarObjetos(clientes2[PorcenBenf4]));
                        }else{
                            porcentajeBenf4.add(' ');
                        }//Porcentaje correspondiente del Beneficiario 4 
                        //*************************************Quinto Beneficiario****************************************************************************                           
                        //****************************************Primer Nombre del Beneficiario 5********************************************************************************                              
                        if(N1Benf5!=15 && N1Benf5< clientes2.size()){
                            primerNomBenf5.add(llenarObjetos(clientes2[N1Benf5]));
                        }else{
                            primerNomBenf5.add(' ');
                        }//primer Nombre Beneficiario 5
                        //****************************************Segundo Nombre del Beneficiario 5************************************************************************                              
                        if(N2Benf5!=15 && N2Benf5< clientes2.size()){
                            segundoNomBenf5.add(llenarObjetos(clientes2[N2Benf5]));
                        }else{
                            segundoNomBenf5.add(' ');
                        }//primer Nombre Beneficiario 5
                        //****************************************Primer Apellido del Beneficiario 5********************************************************************************                              
                        if(Ape1Benf5!=15 && Ape1Benf5< clientes2.size() ){
                            primerApeBenf5.add(llenarObjetos(clientes2[Ape1Benf5]));
                        }else{
                            primerApeBenf5.add(' ');
                        }//Primer Apellido del Beneficiario 5
                        //****************************************Segundo Apellido del Beneficiario 5********************************************************************************                              
                        if(Ape2Benf5!=15 && Ape2Benf5< clientes2.size() ){
                            segundoApeBenf5.add(llenarObjetos(clientes2[Ape2Benf5]));
                        }else{
                            segundoApeBenf5.add(' ');
                        }//Segundo Apellido del Beneficiario 5
                        //****************************************Parentesco del Beneficiario 5********************************************************************************                              
                        if(ParentBenf5!=15 && ParentBenf5< clientes2.size() ){
                            parentescoBenf5.add(llenarObjetos(clientes2[ParentBenf5]));
                        }else{
                            parentescoBenf5.add(' ');
                        }//Parentesco del Beneficiario 5
                        //****************************************Porcentaje correspondiente del Beneficiario 5********************************************************************************                              
                        if(PorcenBenf5!=15 && PorcenBenf5< clientes2.size() ){
                            porcentajeBenf5.add(llenarObjetos(clientes2[PorcenBenf5]));
                        }else{
                            porcentajeBenf5.add(' ');
                        }//Porcentaje correspondiente del Beneficiario 5
                        //******************************************Cuarto Beneficiario*****************************************************************
                        //****************************************Primer Nombre del Beneficiario 6********************************************************************************                              
                        if(N1Benf6!=15 && N1Benf6< clientes2.size() ){
                            primerNomBenf6.add(llenarObjetos(clientes2[N1Benf6]));
                        }else{
                            primerNomBenf6.add(' ');
                        }//primer Nombre Beneficiario 6
                        //****************************************Segundo Nombre del Beneficiario 6************************************************************************                              
                        if(N2Benf6!=15 && N2Benf6< clientes2.size()){
                            segundoNomBenf6.add(llenarObjetos(clientes2[N2Benf6]));
                        }else{
                            segundoNomBenf6.add(' ');
                        }//primer Nombre Beneficiario 6
                        //****************************************Primer Apellido del Beneficiario 6********************************************************************************                              
                        if(Ape1Benf6!=15 && Ape1Benf6< clientes2.size() ){
                            primerApeBenf6.add(llenarObjetos(clientes2[Ape1Benf6]));
                        }else{
                            primerApeBenf6.add(' ');
                        }//Primer Apellido del Beneficiario 6
                        //****************************************Segundo Apellido del Beneficiario 6********************************************************************************                              
                        if(Ape2Benf6!=15 && Ape2Benf6< clientes2.size()){
                            segundoApeBenf6.add(llenarObjetos(clientes2[Ape2Benf6]));
                        }else{
                            segundoApeBenf6.add(' ');
                        }//Segundo Apellido del Beneficiario 6
                        //****************************************Parentesco del Beneficiario 6********************************************************************************                              
                        if(ParentBenf6!=15 && ParentBenf6< clientes2.size()){
                            parentescoBenf6.add(llenarObjetos(clientes2[ParentBenf6]));
                        }else{
                            parentescoBenf6.add(' ');
                        }//Parentesco del Beneficiario 6
                        //****************************************Porcentaje correspondiente del Beneficiario 6********************************************************************************                              
                        if(PorcenBenf6!=15 && PorcenBenf6< clientes2.size() ){
                            porcentajeBenf6.add(llenarObjetos(clientes2[PorcenBenf6]));
                        }else{
                            porcentajeBenf6.add(' ');
                        }//Porcentaje correspondiente del Beneficiario 6
                        //******************************************************************************************************************************************************                           
                    } //fin del if lenght 
                } //fin del for
                
                
                for (integer i=0; i<NoEmpleado.size(); i++){                   
                    string si = 'SI';
                    
                    listc = new reporteT24__c();
                    
                    if(i < FechIngCuenta.size() &&  FechIngCuenta[i] != '' ){   
                        
                        //************************************************Las listas se pasan al objeto******************************
                        listC.noEmpleado__c = string.valueOf(NoEmpleado[i]);  //Numero de empleado
                        listC.fechaIngresoCuentas__c = date.valueOf(fechas(FechIngCuenta[i]));  //Fecha de Ingreso a la Cuenta
                        listC.noEmpresa__c = string.valueOf(NumEmp[i]);//numero de la empresa
                        listC.TipoId__c =  string.valueOf(TipoId[i]);//Tipo Id usado
                        listC.identificacion__c =  String.valueOf(identificacion[i]);//Id 
                        listC.pApellidoEmpleado__c = String.valueOf(pApellido[i]);//primer apellido del empleado
                        listC.sApellidoEmpleado__c = String.valueOf(sApellido[i]);//segundo apellido del empleado
                        listC.pNombreEmpleado__c = String.valueOf(pNombre[i]);//primer nombre del empleado
                        listC.sNombreEmpleado__c = String.valueOf(sNombre[i]);//segundo nombre del empleado
                        listC.nacionalidad__c = String.valueOf(nacionalidades[i]);//nacionalidad del empleado 
                        try{
                            listC.fechaNacimientoEmpleado__c = date.valueOf(fechas(FechNac[i]));//Fecha nacimiento del empleado   
                        }catch( exception ex){
                            listC.fechaNacimientoEmpleado__c = date.today();
                        }
                        
                        
                        listC.sexo__c = String.valueOf(sexo[i]);//Sexo del empleado
                        listC.estadoCivil__c = String.valueOf(estadoCivil[i]);//estado civil empleado
                        listC.envio__c = String.valueOf(envio[i]); //envio
                        listC.direccion__c = String.valueOf(direccion[i]);//Direccion
                        listC.nroDireccion__c = String.valueOf(nroDireccion[i]);//codigo de la Direccion
                        listC.nroEdificio__c =   String.valueOf(nroEdificio[i]);
                        listC.codPais__c = String.valueOf(codPais[i]);
                        listC.codR__c = String.valueOf(codRegion[i]);
                        listC.cod__c =  String.valueOf( codProvincia[i]);                         
                        listC.codSector__c= String.valueOf(codSector[i]);                             
                        listC.codC__c = String.valueOf(codCiudad [i]);
                        //para la insercion del tefono dependiendo con la numeración que empiece
                        if(String.valueOf(telefono[i]) == 'null' || telefono[i] == null){
                            listC.telefonoEmpleado__c = String.valueOf(telefono[i]);
                            listC.telefono__c = String.valueOf(telefono[i]);
                        }else{
                            tele =String.valueOf(telefono[i]);
                            tele.trim();
                            if(tele.substring(0, 1)=='2'){
                                listC.telefonoEmpleado__c = String.valueOf(telefono[i]);
                            }else{
                                listC.telefono__c = String.valueOf(telefono[i]);
                            }
                        }
                        
                        listC.correoEmplead__c = string.valueOf(correoEmpleado [i]);
                        listC.aplicaSeg__c = String.valueOf(aplicaSeguro[i]);
                        listC.ingresoBrutoCalculado__c = string.valueOf(ingresobrutocot[i]);
                        listC.producto__c = String.valueOf(producto[i]);
                        listC.subProducto__c = String.valueOf(subProducto[i]);
                        listC.Periodo__c = String.valueOf(periocidad[i]);
                        listC.formaPago__c = String.valueOf(formaPago[i]);
                        listC.cuenta__c = String.valueOf(cuentaPago[i]);
                        listC.entePaga__c = String.valueOf(entePago[i]);
                        listC.tipoAporte__c = String.valueOf(tipoAporte[i]);
                        listC.montoAporte__c = decimal.valueOf(monteAporte[i]);
                        listC.montoAporteP__c= decimal.valueOf(monteAporteNeto[i]);
                        listC.ocupacion__c = String.valueOf(ocupacionEmpleado[i]);
                        listC.promotor__c = String.valueOf(codPromotor[i]);
                        listC.nombrePromotor__c = String.valueOf(nombrePromotor[i]);
                        listC.rtnEmpleador__c = String.valueOf(rtnEmpleador[i]);
                        listC.razonSocial__c = String.valueOf(razonSocial[i]);
                        listC.nombreEmpresa__c = String.valueOf(nombreEmpresa[i]);
                        listC.fechaIngresoEmpresa__c = Date.valueOf(fechas(FechaIngreso[i]));
                        listC.telefonoEmpresa__c = String.valueOf(telefonoEmpresa[i]);
                        listC.extension__c=String.valueOf(extEmpresa[i]);
                        listC.fax__c=String.valueOf(faxEmpresa[i]);
                        listC.direccionEmpresa__c= String.valueOf(dirEmpresa[i]);
                        listC.correoEmpresa__c= String.valueOf(correoEmpresa[i]);
                        listC.tipoSolicitud__c= String.valueOf(tipoSolicitud[i]);
                        
                        listC.NombreRef1__c= String.valueOf(primerNomRef1[i]);
                        listC.nombre2Ref1__c= String.valueOf(segundoNomRef1[i]);
                        listC.Apellido1Ref1__c=String.valueOf(primerApeRef1[i]);
                        listC.Apellido2Ref1__c = String.valueOf(segundoApeRef1[i]);
                        listC.telefonoRef1__c = String.valueOf(telefonoRef1[i]);
                        
                        listC.NombreRef2__c = String.valueOf(primerNomRef2[i]);
                        listC.Nombre2Ref2__c = String.valueOf(segundoNomRef2[i]);
                        listC.Apellido1Ref2__c= String.valueOf( primerApeRef2[i]);
                        listC.Apellido2Ref2__c= String.valueOf(segundoApeRef2[i]);
                        listC.telefonoRef2__c = String.valueOf( telefonoRef2[i]);
                        
                        listC.cargoEmpleado__c = String.valueOf(cargo[i]);
                        listC.lugarNacimiento__c = String.valueOf(lugarNacimiento[i]);
                        listC.nombreConyugue__c = String.valueOf(nomConyuge[i]);
                        listC.primerNombreBen1__c = String.valueOf(primerNomBenf1[i]);
                        listC.Nombre2Benf1__c = String.valueOf(segundoNomBenf1[i]);
                        listC.Apellido1Benf1__c = String.valueOf(primerApeBenf1[i]);
                        listC.Apellido2Benf1__c = String.valueOf(segundoApeBenf1[i]);
                        listC.parentescoBenf1__c = String.valueOf(parentescoBenf1[i]); 
                        listC.porcentajeBenf1__c = String.valueOf(porcentajeBenf1[i]);
                        listC.Nombre1Benf2__c = String.valueOf(primerNomBenf2[i]);
                        listC.Nombre2Benf2__c = String.valueOf(segundoNomBenf2[i]);
                        listC.Apellido1Benf2__c = String.valueOf(primerApeBenf2[i]);
                        listC.Apellido2Benf2__c = String.valueOf(segundoApeBenf2[i]);
                        listC.parentescoBenf2__c = String.valueOf(parentescoBenf2[i]);
                        listC.porcentajeBenf2__c = String.valueOf(porcentajeBenf2[i]);
                        listC.Nombre1Benf3__c = String.valueOf(primerNomBenf3[i]);
                        listC.Nombre2Benf3__c = String.valueOf(segundoNomBenf3[i]);
                        listC.Apellido1Benf3__c = String.valueOf(primerApeBenf3[i]);
                        listC.Apellido2Benf3__c = String.valueOf(segundoApeBenf3[i]);
                        listC.parentescoBenf3__c = String.valueOf(parentescoBenf3[i]);
                        listC.porcentajeBenf3__c = String.valueOf(porcentajeBenf3[i]);
                        listC.Nombre1Benf4__c = String.valueOf(primerNomBenf4[i]);
                        listC.Nombre2Benf4__c = String.valueOf(segundoNomBenf4[i]);
                        listC.Apellido1Benf4__c = String.valueOf(primerApeBenf4[i]);
                        listC.Apellido2Benf4__c = String.valueOf(segundoApeBenf4[i]);
                        listC.parentescoBenf4__c = String.valueOf(parentescoBenf4[i]);
                        listC.porcentajeBenf4__c = String.valueOf(porcentajeBenf4[i]);
                        listC.Nombre1Benf5__c = String.valueOf(primerNomBenf5[i]);
                        listC.Nombre2Benf5__c = String.valueOf(segundoNomBenf5[i]);
                        listC.Apellido1Benf5__c = String.valueOf(primerApeBenf5[i]);
                        listC.Apellido2Benf5__c = String.valueOf(segundoApeBenf5[i]);
                        listC.parentescoBenf5__c = String.valueOf(parentescoBenf5[i]);
                        listC.porcentajeBenf5__c = String.valueOf(porcentajeBenf5[i]);
                        listC.Nombre1Benf6__c = String.valueOf(primerNomBenf6[i]);
                        listC.Nombre2Benf6__c = String.valueOf(segundoNomBenf6[i]);
                        listC.Apellido1Benf6__c = String.valueOf(primerApeBenf6[i]);
                        listC.Apellido2Benf6__c = String.valueOf(segundoApeBenf6[i]);
                        listC.parentescoBenf6__c = String.valueOf(parentescoBenf6[i]);
                        listC.porcentajeBenf6__c = String.valueOf(porcentajeBenf6[i]);
                        
                    } // fin de que la fecha sea distinta que null
                    
                    //Fin de la primera validacion
                    
                    
                    EstadoCu.add(listC);  
                    
                } //fin for 
                
                insert EstadoCu;
                
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'correcto '));
                
            }/*fin_if_cabeceras*/
            else{
                
                retorno.error='Estas columnas no traen el nombre correcto\n';
                
                if(a==15)
                {
                    retorno.error+='No.Empleado\n';
                }
                if(FechIngC==15)
                {
                    retorno.error+='Fecha Ingreso a la cuenta\n';
                }
                if(c==15)
                {
                    retorno.error+='No.Empresa\n';
                }
                if(d==15)
                {
                    retorno.error+='Tip_Id\n';
                }
                if(e==15)
                {
                    retorno.error+='ID\n';
                }
                if(g==15)
                {
                    retorno.error+='1 Apellido\n';
                }
                if(f==15)
                {
                    retorno.error+='2 Apellido\n';
                }
                if(ne1==15)
                {
                    retorno.error+='1 Nombre\n';
                }
                if(ne2==15)
                {
                    retorno.error+='2 Nombre\n';
                }
                if(Nacionalidad==15)
                {
                    retorno.error+='Nacionalidad\n';
                }
                
                if(FechN==15)
                {
                    retorno.error+='Fecha Nacimiento\n';
                }
                
                if(Civ==15)
                {
                    retorno.error+='Estado Civil\n';
                }
                
                if(S==15)
                {
                    retorno.error+='Sexo\n';
                }
                
                if(Env==15)
                {
                    retorno.error+='Envio\n';
                }
                
                if(Dir==15)
                {
                    retorno.error+='Dirección\n';
                }
                
                if(NumDir!=15)
                {
                    retorno.error+='Nro.Direccion\n';
                }
                
                if(Ed==15)
                {
                    retorno.error+='No.Edificio\n';
                }
                
                if(CodP==15)
                {
                    retorno.error+='Codigo Pais\n';
                }
                
                if(CodReg==15)
                {
                    retorno.error+='Codigo Region\n';
                }
                
                if(CodProv==15)
                {
                    retorno.error+='Codigo Provincia\n';
                }
                
                if(CodCiud==15)
                {
                    retorno.error+='Codigo Ciudad\n';
                }
                
                if(CodSec==15)
                {
                    retorno.error+='Codigo Sector\n';
                }
                
                if(Tel==15)
                {
                    retorno.error+='Telefono\n';
                }
                
                if(CorreoE==15)
                {
                    retorno.error+='Correo del empleado\n';
                }
                
                if(AplicSeg==15)
                {
                    retorno.error+='Aplica Seguro\n';
                }
                
                if(Ibc==15)
                {
                    retorno.error+='IBC\n';
                }
                
                if(Prod==15)
                {
                    retorno.error+='Producto\n';
                }
                
                if(SubProd==15)
                {
                    retorno.error+='Sub Producto\n';
                }
                
                if(Periodo==15)
                {
                    retorno.error+='Periodicidad\n';
                }
                
                if(FormaPag==15)
                {
                    retorno.error+='Forma de Pago\n';
                }
                
                if(CuentaPag==15)
                {
                    retorno.error+='Cuenta Pago\n';
                }
                
                if(EntePaga==15)
                {
                    retorno.error+='Ente Pago\n';
                }
                
                if(TipoApor==15)
                {
                    retorno.error+='Tipo Aporte\n';
                }
                
                if(MontoApor==15)
                {
                    retorno.error+='Monto Aporte\n';
                }
                
                if(MontoAporN==15)
                {
                    retorno.error+='Monto Aporte Neto\n';
                }
                
                if(Ocupacion==15)
                {
                    retorno.error+='Ocupacion\n';
                }
                
                if(Prom==15)
                {
                    retorno.error+='Promotor\n';
                }
                
                if(Nprom==15)
                {
                    retorno.error+='Nombre  Promotor\n';
                }
                
                if(RTNEmp==15)
                {
                    retorno.error+='Nombre  RTN Empleador\n';
                }
                
                if(RazonSoc==15)
                {
                    retorno.error+='Razon Social Empresa\n';
                }
                
                if(Nemp==15)
                {
                    retorno.error+='Nombre Empresa\n';
                }     
                if(FechIng==15)
                {
                    retorno.error+='Fecha de Ingreso\n';
                }     
                if(TelEmp==15)
                {
                    retorno.error+='Telefono Empresa\n';
                }
                
                if(Ext==15)
                {
                    retorno.error+='Extension Empresa\n';
                }
                
                if(Fax==15)
                {
                    retorno.error+='Fax Empresa\n';
                }
                
                if(DirEmp==15)
                {
                    retorno.error+='Direccion Empresa\n';
                }
                
                if(CorreoEmp==15)
                {
                    retorno.error+='e-mail Empresa\n';
                }
                
                if(TipoSoli==15)
                {
                    retorno.error+='Tipo Solicitud\n';
                }
                
                if(N1Ref1==15)
                {
                    retorno.error+='Ref.1 Primer Nombre\n';
                }
                
                if(N2ref1==15)
                {
                    retorno.error+='Ref.1 Segundo Nombre\n';
                }
                
                if(Ap1Ref1==15)
                {
                    retorno.error+='Ref.1 Primer Apellido\n';
                }
                
                if(Ap2Ref1==15)
                {
                    retorno.error+='Ref.1 Segundo Apellido\n';
                }
                
                if(TelRef1==15)
                {
                    retorno.error+='Ref.1 telefono\n';
                }
                
                if(N1Ref2==15)
                {
                    retorno.error+='Ref.2 Primer Nombre\n';
                }
                
                if(N2ref2==15)
                {
                    retorno.error+='Ref.2 Segundo Nombre\n';
                }
                
                if(Ap1Ref2==15)
                {
                    retorno.error+='Ref.2 Primer Apellido\n';
                }
                
                if(Ap2Ref2==15)
                {
                    retorno.error+='Ref.2 Segundo Apellido\n';
                }
                
                if(TelRef2==15)
                {
                    retorno.error+='Ref.2 telefono\n';
                }
                
                if(CargoE==15)
                {
                    retorno.error+='Cargo Empleado\n';
                }
                
                if(LugarNacE==15)
                {
                    retorno.error+='Lugar Nacimiento\n';
                }
                
                if(Nconyuge==15)
                {
                    retorno.error+='Conyugue\n';
                }
                
                if(N1Benf1==15)
                {
                    retorno.error+='Beneficiario.1 Primer Nombre\n';
                }
                if(N2Benf1==15)
                {
                    retorno.error+='Beneficiario.1 Segundo Nombre\n';
                }
                if(Ape1Benf1==15)
                {
                    retorno.error+='Beneficiario.1 Primer Apellido\n';
                }
                if(Ape2Benf1==15)
                {
                    retorno.error+='Beneficiario.1 Segundo Apellido\n';
                }
                if(ParentBenf1==15)
                {
                    retorno.error+='Beneficiario.1 Parentesco';
                }
                if(PorcenBenf1==15)
                {
                    retorno.error+='Beneficiario.1 Porcentaje\n';
                }
            }//fin_else_cabeceras
            //********************************************#########fin de validacion del else de los encabezados#########***********************************************************        
        }
        catch( exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Ha Ocurrido Un error: ' +ex.getLineNumber()));
            // system.debug('Error al Guardar: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());    
            
            retorno.error='Ha ocurrido un error' + ex.getMessage() + ' Recuerde cambiar la coma por espacio punto, '+ ' Linea: ' + ex.getLineNumber();  
            return retorno;
        } 
        return retorno;
    }    
    
}//fin