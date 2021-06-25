public class ControllerUsuarioJuridico {
    public string CuentaMostrar {get;set;}
    public string pc_codCuenta {get;set;}
    public string Activo {get;set;}
    public string Causa {get;set;}
    public string tipoUsuarioJuridico{get;set;} 
    public boolean PEP{get;set;}
    public boolean FATCA{get;set;}
    public boolean despN {get;Set;}
    public string tipoId {get;set;} 
    public string numeroId {get;set;} 
    public string nombreRazon{get;set;}
    public string telefono{get;set;}
    public string pais{get;set;} 
    Public string codProducto{get;set;}
    public string codSubproducto{get;set;} 
    public string colonia{get;set;}
    public string idFormulario {get;set;}
    public string departamento{get;set;}  
    public string municipio{get;set;} 
    public string calle{get;set;}
    public string procedenciaFondo{get;set;}  
    public string sector{get;set;}  
    public string periodicidad{get;set;}  
    public string formaPago {get; set;}
    public string codPromotor{get;set;} 
    public string estatal{get;set;}
    public string lucrativa {get; set;}
    public string claseSociedad {get; set;}
    public string IdRepresentanteLegal{get;set;}  
    public string calificacionRiesgo{get;set;} 
    public string diligenciaAplicada{get;set;}
    public string primerNombreR {get;set;}
    public string segundoNombreR {get;set;}
    public string primerApellidoR {get;set;} 
    public string segundoApellidoR {get;set;}  
    public string usuarioJuridicoSelec{get;set;}
    public Account Cliente25{get;set;}
    public Cuentas__c Cuenta20 {get; set;}
    public boolean dispep{get;set;}
    public boolean actPop{get;set;}
    public boolean disbot{get;set;}
    public boolean desCheckb{get;set;}
    public boolean Prob1{get;set;}
    public boolean validar1{get;set;}
    public boolean validar2{get;set;}
    public boolean OcultarCuenta1 {get;Set;}
    public List<SelectOption> options {get;set;}
    public List<SelectOption> opciones {get;set;}
    public List<SelectOption> opcionesEstado {get;set;}
    public List<SelectOption> opcionesCausa {get;set;}
    public List<SelectOption> opcionSubproducto {get;set;}
    public List<SelectOption> opcionPais {get;set;}
    public List<SelectOption> opcionDepartamento {get;set;}
    public List<SelectOption> opcionMunicipio {get;set;}
    public List<SelectOption> opcionColonia {get;set;}
    public list<Colonias_U__c> listColonias{get;set;}
    integer paginacion;
    public boolean mostrarBoton{get;set;}
    public boolean mostrarSiguiente{get;set;}
    public boolean mostrarAnterior{get;set;}      
    public boolean ActivarModal {get;set;}
    public boolean MostarGuardar {get;set;}
    public boolean MostarActualizar {get;set;}
    public boolean BuscarCuentas {get;set;} 
    public boolean BloquearBtnID {get;set;}
    public boolean BloquearBtnCu {get;set;}
    public string mensaje3{get;set;} 
    public string lugarConstitucion {get; set;} 
    public list <string> Id; 
    
    public ControllerUsuarioJuridico() {
        MostarGuardar=false;
        MostarActualizar=false;
        mensaje3='none';
        Cliente25 = new Account();
        Cuenta20 = new Cuentas__c();
        options=new List<SelectOption>();
        calificacionRiesgo = '1';
        diligenciaAplicada = '2';
        opciones=new List<SelectOption>();
        opcionSubproducto=new List<SelectOption>();
        llenarSubproductos();
        llenarProductos();
        opcionPais=new List<SelectOption>();
        opcionDepartamento=new List<SelectOption>();
        opcionesEstado=new List<SelectOption>();
        llenarPais();
        llenarDepartamento();
        llenarMunicipio();
        llenarColonia();
        llenarDeligencia(); 
        llenarIDEmp();
        llenaro();
        llenarNivelRiesgo();
        llenarInstitucionFinanciera();
        asesores();
        despN = false;   
        disbot = true; 
    }
    
    public void BusCuentas()
    {
        BuscarCuentas=true;
    }
    
    public void salirCuenta()
    {
        BuscarCuentas=false;
    }
    
    public pageReference desUn()
    {
        despN = true;
        return null; 
    }
    
    public void BloqBotonCU()
    {
        BloquearBtnCu = true;
        //BloquearBtnID = false; 
        //MostrarCUENTT = '';
    }
    /*public void BloqBotonID(){
        
        BloquearBtnID = true; 
        BloquearBtnCu = false;
        NumIDBuscar = '';
    } */
    public list <selectOption> listAsesor {get; set;}
    public void asesores()
    {
        listAsesor = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Account.Asesor__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();
        map<string, string> mapisv= new map<string, string>(); 
        listAsesor.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
        for(Schema.PicklistEntry p : ple){          
            listAsesor.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    
    public void llenarSubproductos()
    {
        try
        {
            opcionSubproducto = new list <selectOption>();
            opcionSubproducto.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Subproducto__c item:[select name, codigo__c from Subproducto__c where producto__r.codigo__c =: codProducto])
            {
                opcionSubproducto.add(new selectOption(item.codigo__c, item.name));
            }
        }catch(exception e){
            
        }
    }
    
    public void llenarProductos()
    {
        try
        {   opciones.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
         for (Producto__c item:[select name, codigo__c from Producto__c])
         {
             opciones.add(new selectOption(item.codigo__c, item.name));
         }
        }catch(exception e){
            
        }
    }
    public void llenarEstado()
    {
        try
        {   
            opcionesEstado = new list <selectOption>();
            opcionesEstado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Estado_Cuenta__c item:[select name, CodigoEstado__c from Estado_Cuenta__c ])
            {
                opcionesEstado.add(new selectOption(item.CodigoEstado__c, item.name));
            }
            
        }catch(exception e){
            
        }
    }
    
    public void llenarCausas()
    {
        try
        {   
            opcionesCausa = new list <selectOption>();
            opcionesCausa.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Causa_Cuenta__c item:[select name, codigo__c from Causa_Cuenta__c where Estado_Cuenta__r.CodigoEstado__c =: Activo])
            {
                opcionesCausa.add(new selectOption(item.codigo__c, item.name));
            }
            
        }catch(exception e){
            
        }
    }
    public void llenarColonia()
    {
        try
        {
            paginacion = 0;
            listColonias = new list <Colonias_U__c>();
            listColonias = [select nombre_colonia__c, codigo_colonia__c from Colonias_U__c where codigo_pais__c =: pais 
                            and codigo_departamento__c =: departamento and codigo_municipio__c =: municipio order by nombre_colonia__c asc];
            opcionColonia = new list <selectOption>();
            opcionColonia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            if(listColonias.size()>999)
            {
                paginacion++;
                mostrarBoton =  true;
                mostrarSiguiente = false;
                mostrarAnterior = true;
                for (integer i=0; i< 999; i++)
                {
                    opcionColonia.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                }                
            }
            else
            {
                opcionColonia = new list <selectOption>();
                opcionColonia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Colonias_U__c item:[select nombre_colonia__c, codigo_colonia__c from Colonias_U__c where codigo_pais__c =: pais 
                                         and codigo_departamento__c =: departamento and codigo_municipio__c =: municipio order by nombre_colonia__c asc])
                {
                    opcionColonia.add(new selectOption(item.codigo_colonia__c, item.nombre_colonia__c));
                }
            }
            
            
        }catch(exception e){
            
        }
    }
    
    public void siguiente()
    {
        try{
            if (listColonias.size()> ((paginacion + 1)*1000) )
            {
                opcionColonia = new list <selectOption>();
                opcionColonia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (integer i=1000; i< 1999; i++)
                {
                    opcionColonia.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                }    
            }
            else
            {
                opcionColonia = new list <selectOption>();
                mostrarSiguiente=true;
                mostrarAnterior = false;
                opcionColonia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (integer i=1000; i< listColonias.size(); i++)
                {
                    opcionColonia.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                }    
            }
            
        }
        catch(exception e){
            
        }
    }
    
    public void anterior()
    {
        try 
        {
            
            if((paginacion - 1)*1000 < 1000)
            {
                mostrarsiguiente=false;
                mostrarAnterior=true;
                opcionColonia = new list<selectOption>();
                for(integer i=0; i<1000; i++)
                {
                    opcionColonia.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                } 
                paginacion --;
            }
            else
            {
                opcionColonia = new list<selectOption>();
                for(integer i=(paginacion - 2)*100; i<(paginacion-1) *100; i++)
                {
                    opcionColonia.add(new selectOption(listColonias[i].codigo_colonia__c, listColonias[i].nombre_colonia__c));
                }  
                paginacion --;
                mostrarSiguiente=false;
            }
        }
        catch(Exception ex)
        {
            
        }
    }
    
    public void llenarMunicipio()
    {
        try
        {
            opcionMunicipio = new list <selectOption>();
            opcionMunicipio.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Municipio__c item:[select nombre_municipio__c, codigo_municipio__c from Municipio__c where codigo_pais__c =: pais and 	codigo_departamento__c =: departamento])
            {
                opcionMunicipio.add(new selectOption(item.codigo_municipio__c, item.nombre_municipio__c));
            }
        }catch(exception e){
            
        }
    }
    
    public void llenarDepartamento()
    {
        try
        {
            opcionDepartamento = new list <selectOption>();
            opcionDepartamento.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
            for (Departamentos__c item:[select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: pais])
            {
                opcionDepartamento.add(new selectOption(item.codigo_departamento__c, item.Departamento__c));
            }
        }catch(exception e){
            
        }
    }
    
    public void llenarPais()
    {
        try
        {   opcionPais.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
         for (Pais_R__c item:[select nombre__c, codigo__c from Pais_R__c])
         {
             opcionPais.add(new selectOption(item.codigo__c, item.nombre__c));
         }
        }catch(exception e){
            
        }
    }
    
    public void despModal()
    {
        Prob1 = true; 
    }
    public void cerModal()
    {
        Prob1 = false; 
    }
    
    public void cleanRiesgo()
    {
        desCheckb = null; 
        PEP = null; 
        FATCA = null; 
        validar1 = null; 
        validar2 = null; 
    }
    
    public pageReference contrUn()
    {
        despN = false;
        return null; 
    }
    
    public void mostPop(){
        actPop = true; 
    }
    /*boton*/
    public void desBtn(){
        cleanRiesgo();
        disbot = true; 
    }    
    public void hidePop(){
        limpiar(); 
        actPop = false; 
    }
    
    //*********************¿Es una Entidad o Institución Financiera?***********************************
    public void llenarInstitucionFinanciera(){
        String[] InstitucionFinanciera = new String[]{'NINGUNO','SI','NO'};
            this.InstitucionFinancieraOptions = new SelectOption[]{};
                for (String c: InstitucionFinanciera) {
                    this.InstitucionFinancieraOptions.add(new SelectOption(c,c));
                }     
    }
    
    public void bloqPep(){
        dispep = true; 
        calificacionRiesgo = '4'; 
        diligenciaAplicada = '3'; 
    }
    public void unblock(){
        dispep = false; 
        calificacionRiesgo = '1'; 
        diligenciaAplicada = '2'; 
    }
    
    public SelectOption[] InstitucionFinancieraOptions
    { 
        public get;
        private set;
    }
    
    //RTN
    public void llenarIDEmp(){
        this.idOption = new SelectOption[]{};
            this.idOption.add(new SelectOption('0','RTN')); 
    }
    
    public SelectOption[] idOption
    { 
        public get;
        private set;
    }
    
    //*********************Deligencia ***********************************
    public void llenarDeligencia(){
        this.DeligenciaOptions = new SelectOption[]{};
            this.DeligenciaOptions.add(new SelectOption('0','NINGUNA'));                                                                       
        this.DeligenciaOptions.add(new SelectOption('1','SIMPLIFICADA'));
        this.DeligenciaOptions.add(new SelectOption('2','NORMAL'));
        this.DeligenciaOptions.add(new SelectOption('3','INCREMENTADA'));
    }
    
    public SelectOption[] DeligenciaOptions
    { 
        public get;
        private set;
    }
    
    
    public void mostrarModal()
    {
        despN=true;
    }
    
    public void limpiar(){
        tipoUsuarioJuridico = null;
        PEP = null;
        FATCA = null;
        tipoId = null;
        numeroId = null;
        nombreRazon = null;
        telefono = null;
        pais = null;
        procedenciaFondo = null;  
        calificacionRiesgo = null; 
        diligenciaAplicada = null;
        departamento = null;
        municipio = null;
        colonia = null;
        calle = null;
        CuentaMostrar = null;
        Activo = null;
        Causa = null;
        idFormulario = null;
        codPromotor = null;
        codProducto = null;
        codSubproducto = null; 
        Cliente25.Tipo_admon__c = null;
        Cliente25.Sector__c = null;
        sector = null; 
        Cliente25.TipoSociedad__c = null;
        claseSociedad = null;
        Cliente25.Lucrativa__c = null;
        lucrativa = null;
        Cuenta20.Forma_Aportacion__c = null;
        Cuenta20.Frecuencia_Aportacion__c = null;
        periodicidad = null;
        estatal = null;
        IdRepresentanteLegal = null;
        primerNombreR = null;
        segundoNombreR = null;
        primerApellidoR = null; 
        segundoApellidoR = null; 
    }
    
    public void guardar(){
        try{
            
            classUsuarioJuridico claseEnvio = new classUsuarioJuridico();

            claseEnvio.tipoUsuarioJuridico = tipoUsuarioJuridico;
            if(PEP == true)
            {
                claseEnvio.PEP = 'S';
            }
            else
            {
                claseEnvio.PEP = 'N';
            }
            
            if(FATCA == true)
            {
                claseEnvio.FATCA = 'S';
            }
            else
            {
                claseEnvio.FATCA = 'N';
            }
            claseEnvio.tipoId = '5';
            claseEnvio.numeroId = numeroId;
            claseEnvio.nombreRazon = nombreRazon;
            claseEnvio.telefono = telefono;
            claseEnvio.pConstitucion=lugarConstitucion;
            claseEnvio.procedenciaFondo = procedenciaFondo;
            claseEnvio.calificacionRiesgo = calificacionRiesgo;
            claseEnvio.diligenciaAplicada = diligenciaAplicada; 
            claseEnvio.pais = pais;
            claseEnvio.departamento = departamento;
            claseEnvio.municipio = municipio;
            claseEnvio.colonia = colonia;
            claseEnvio.calle=calle;
            claseEnvio.idFormulario=idFormulario;
            claseEnvio.codPromotor= codPromotor;
            claseEnvio.codProducto = codProducto;
            claseEnvio.codSubproducto = codSubproducto;
            claseEnvio.estatal = Cliente25.Tipo_admon__c;
            claseEnvio.sector = Cliente25.Sector__c; 
            claseEnvio.claseSociedad = Cliente25.TipoSociedad__c;
            claseEnvio.lucrativa = Cliente25.Lucrativa__c;
            claseEnvio.formaPago = Cuenta20.Forma_Aportacion__c;
            claseEnvio.periodicidad = Cuenta20.Frecuencia_Aportacion__c;
            claseEnvio.IdRepresentanteLegal=IdRepresentanteLegal;
            claseEnvio.primerNombreR = primerNombreR;
            claseEnvio.segundoNombreR = segundoNombreR;
            claseEnvio.primerApellidoR = primerApellidoR;
            claseEnvio.segundoApellidoR= segundoApellidoR;
            limpiar();
            
            
            String resultado = controllerApiUsuarioJuridico.insertaUsuarioJuridico(claseEnvio);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
            
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));	    
        }
    }
    
    public void buscarInfoCuentaC()
    {
        try{	
            string temporal = pc_codCuenta;
            classUsuarioJuridico claseEnvio = new classUsuarioJuridico();
            classUsuarioJuridico fcsd = controllerApiUsuarioJuridico.BuscarUsuarioJuridicoC(pc_codCuenta);
            
            system.debug('Respuestaaaaaaa: '+fcsd);
            
            if (fcsd.nombreRazon != 'null')
            {
                CuentaMostrar = pc_codCuenta;
                if (fcsd.tipoUsuarioJuridico != 'null')
                {
                    tipoUsuarioJuridico = fcsd.tipoUsuarioJuridico;
                }
                IF (fcsd.PEP =='N' || fcsd.PEP == 'null')
                {
                    PEP = false;
                }
                else 
                {
                    PEP = true; 
                }    
                IF (fcsd.FATCA =='N' || fcsd.FATCA == 'null')
                {
                    FATCA = false;
                }
                else 
                {
                    FATCA = true;
                }
                opcionesEstado = new list <selectOption>();
                opcionesEstado.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Estado_Cuenta__c item:[select name, CodigoEstado__c from Estado_Cuenta__c ])
                {
                    opcionesEstado.add(new selectOption(item.CodigoEstado__c, item.name));
                }
                if (fcsd.Activo != 'null')
                {
                    Activo = fcsd.Activo;
                }
                opcionesCausa = new list <selectOption>();
                opcionesCausa.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Causa_Cuenta__c item:[select name, codigo__c from Causa_Cuenta__c where Estado_Cuenta__r.CodigoEstado__c =: Activo])
                {
                    opcionesCausa.add(new selectOption(item.codigo__c, item.name));
                }  
                Causa = fcsd.Causa;
                if (fcsd.tipoId != 'null')
                {
                    tipoId = fcsd.tipoId;
                }
                if (fcsd.numeroId != 'null')
                {
                    numeroId = fcsd.numeroId;
                }  
                if (fcsd.nombreRazon != 'null')
                {
                    nombreRazon = fcsd.nombreRazon;
                }
                if (fcsd.telefono != 'null')
                {
                    telefono = fcsd.telefono; 
                }
                if (fcsd.pConstitucion != 'null')
                {
                    lugarConstitucion = fcsd.pConstitucion; 
                }
                if (fcsd.procedenciaFondo != 'null')
                {
                    procedenciaFondo = fcsd.procedenciaFondo; 
                }
                if (fcsd.calificacionRiesgo != 'null')
                {
                    calificacionRiesgo = fcsd.calificacionRiesgo; 
                }
                if (fcsd.diligenciaAplicada != 'null')
                {
                    diligenciaAplicada = fcsd.diligenciaAplicada; 
                }
                if (fcsd.pais != 'null')
                {
                    pais = fcsd.pais;
                }
                opcionDepartamento = new list <selectOption>();
                opcionDepartamento.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Departamentos__c item:[select Departamento__c, codigo_departamento__c from Departamentos__c where codigo_pais__c =: fcsd.pais
                                            and codigo_departamento__c =: fcsd.departamento])
                {
                    opcionDepartamento.add(new selectOption(item.codigo_departamento__c, item.Departamento__c));
                }
                if (fcsd.departamento != 'null')
                {
                    departamento = fcsd.departamento;
                }
                opcionMunicipio = new list <selectOption>();
                opcionMunicipio.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Municipio__c item:[select nombre_municipio__c, codigo_municipio__c from Municipio__c where codigo_pais__c =: fcsd.pais and codigo_departamento__c =: fcsd.departamento
                                        AND codigo_municipio__c =: fcsd.municipio ])
                {
                    opcionMunicipio.add(new selectOption(item.codigo_municipio__c, item.nombre_municipio__c));
                }
                if (fcsd.municipio != 'null')
                {
                    municipio = fcsd.municipio;
                }
                opcionColonia = new list <selectOption>();
                opcionColonia.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Colonias_U__c item:[select nombre_colonia__c, codigo_colonia__c from Colonias_U__c where codigo_pais__c =: fcsd.pais and codigo_departamento__c =: fcsd.departamento
                                         AND codigo_municipio__c =: fcsd.municipio and codigo_colonia__c =: fcsd.colonia]) 
                {
                    opcionColonia.add(new selectOption(item.codigo_colonia__c, item.nombre_colonia__c));
                }       
                if (fcsd.colonia != 'null')
                {
                    colonia = fcsd.colonia;
                }
                if (fcsd.calle != 'null')
                {
                    calle = fcsd.calle;
                }
                if (fcsd.idFormulario != 'null'||fcsd.idFormulario != 'NULL')
                {
                    idFormulario = fcsd.idFormulario;
                }
                if (fcsd.codPromotor != 'null')
                {
                    codPromotor = fcsd.codPromotor;
                }
                if (fcsd.codProducto != 'null')
                {
                    codProducto = fcsd.codProducto;
                }
                opcionSubproducto = new list <selectOption>();
                opcionSubproducto.add(new selectOption(' --Ninguno-- ', ' --Ninguno-- '));
                for (Subproducto__c item:[select name, codigo__c from Subproducto__c where producto__r.codigo__c =: fcsd.codProducto])
                {
                    opcionSubproducto.add(new selectOption(item.codigo__c, item.name));
                }
                codSubproducto = fcsd.codSubproducto;                
                if (fcsd.estatal != 'null')
                {
                    Cliente25.Tipo_admon__c = fcsd.estatal;
                }
                if (fcsd.sector != 'null')
                {
                    Cliente25.Sector__c = fcsd.sector; 
                }
                if (fcsd.claseSociedad != 'null')
                {
                    Cliente25.TipoSociedad__c = fcsd.claseSociedad;
                }
                if (fcsd.lucrativa != 'null')
                {
                    Cliente25.Lucrativa__c = fcsd.lucrativa;
                }
                if (fcsd.formaPago != 'null')
                {
                    Cuenta20.Forma_Aportacion__c = fcsd.formaPago;
                }
                if (fcsd.periodicidad != 'null')
                {
                    Cuenta20.Frecuencia_Aportacion__c = fcsd.periodicidad;
                }
                if (fcsd.IdRepresentanteLegal != 'null')
                {
                    IdRepresentanteLegal = fcsd.IdRepresentanteLegal;
                }
                if (fcsd.primerNombreR != 'null')
                {
                    primerNombreR = fcsd.primerNombreR;
                }
                if (fcsd.segundoNombreR != 'null')
                {
                    segundoNombreR = fcsd.segundoNombreR;
                }
                if (fcsd.primerApellidoR != 'null')
                {
                    primerApellidoR = fcsd.primerApellidoR;
                }
                
                if (fcsd.segundoApellidoR != 'null')
                {
                    segundoApellidoR = fcsd.segundoApellidoR;
                } 
                OcultarCuenta1 = true;
                despModal();
            }else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Cliente no encontrado'));	    
            }  
            salirCuenta();
            
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getLineNumber() + e.getMessage()));	    
        }
    }
    
    public void actualizar(){
        try{
            
            classUsuarioJuridico claseEnvio = new classUsuarioJuridico();

            claseEnvio.tipoUsuarioJuridico = tipoUsuarioJuridico;
            if(PEP == true)
            {
                claseEnvio.PEP = 'S';
            }
            else
            {
                claseEnvio.PEP = 'N';
            }
            
            if(FATCA == true)
            {
                claseEnvio.FATCA = 'S';
            }
            else
            {
                claseEnvio.FATCA = 'N';
            }
            claseEnvio.CuentaMostrar = CuentaMostrar;
            claseEnvio.activo = activo;
            claseEnvio.causa = causa;
            claseEnvio.tipoId = '5';
            claseEnvio.numeroId = numeroId;
            claseEnvio.nombreRazon = nombreRazon;
            claseEnvio.telefono = telefono;
            claseEnvio.pConstitucion=lugarConstitucion;
            claseEnvio.procedenciaFondo = procedenciaFondo;
            claseEnvio.calificacionRiesgo = calificacionRiesgo;
            claseEnvio.diligenciaAplicada = diligenciaAplicada; 
            claseEnvio.pais = pais;
            claseEnvio.departamento = departamento;
            claseEnvio.municipio = municipio;
            claseEnvio.colonia = colonia;
            claseEnvio.calle=calle;
            claseEnvio.idFormulario=idFormulario;
            claseEnvio.codPromotor= codPromotor;
            claseEnvio.codProducto = codProducto;
            claseEnvio.codSubproducto = codSubproducto;
            claseEnvio.estatal = Cliente25.Tipo_admon__c;
            claseEnvio.sector = Cliente25.Sector__c; 
            claseEnvio.claseSociedad = Cliente25.TipoSociedad__c;
            claseEnvio.lucrativa = Cliente25.Lucrativa__c;
            claseEnvio.formaPago = Cuenta20.Forma_Aportacion__c;
            claseEnvio.periodicidad = Cuenta20.Frecuencia_Aportacion__c;
            claseEnvio.IdRepresentanteLegal=IdRepresentanteLegal;
            claseEnvio.primerNombreR = primerNombreR;
            claseEnvio.segundoNombreR = segundoNombreR;
            claseEnvio.primerApellidoR = primerApellidoR;
            claseEnvio.segundoApellidoR= segundoApellidoR;
            limpiar();
            
            String resultado = controllerApiUsuarioJuridico.actualizaJuridico(claseEnvio);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, resultado));	
            
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
    }
    
    public void validarRepLegal(){
        if(IdRepresentanteLegal==''){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'ID Rep Legal Vacio'));  
        }else{
            classListas claseEnvio = new classListas();
            classListas fcsde = controllerApiUsuarioJuridico.consultaListas(IdRepresentanteLegal);
            if(PEP == false){
                PEP = fcsde.PEP;
            }
            if(FATCA == false){
                FATCA = fcsde.FATCA;
            }
            
            if(fcsde.PEP == true || fcsde.AML == true ||fcsde.FATCA == true){
                desCheckb = true; 
            }
            validar2 = true; 
            
            if(validar1 == true && validar2 == true){
                disbot = false; 
            }
        }
    }
    
    public void validar(){
        try{
            
            classListas claseEnvio = new classListas();
            classListas fcsd = controllerApiUsuarioNatural.consultaListas(numeroId);
            
            if(numeroId==''){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Nro ID Vacio'));	
            }else{
                if(PEP == false){
                    PEP = fcsd.PEP;
                }
                //AML = fcsd.AML;
                if(FATCA == false){
                    FATCA = fcsd.FATCA;
                }
                //PEP = fcsde.PEP;
                //AML = fcsd.AML;
                //FATCA = fcsde.FATCA;
                
                if(fcsd.PEP == true || fcsd.AML == true ||fcsd.FATCA == true){
                    desCheckb = true; 
                }
                
                //if(fcsd.FATCA == true){
                //  despN = true;   
                //}
                if(fcsd.PEP == true){
                    dispep = true;   
                }
                
                // if(fcsd.AML == true){
                //  actPop = true; 
                //}
                validar1 = true; 
                if(validar1 == true && validar2 == true){
                    disbot = false; 
                }
            }
            //String resultado = controllerApiUsuarioNatural.BuscarUsuarioNatural(claseEnvio);
            //ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,resultado));
            
        }Catch(Exception e){
            system.debug('Error al buscar: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No se encontró Cliente'));	    
        }
    }
    
    public void cancelar(){
        limpiar();
    }
    
    //*********************Llenar Nivel de Riesgo ***********************************
    public void llenarNivelRiesgo(){
        
        this.NivelRiesgoOptions = new SelectOption[]{};
        //this.NivelRiesgoOptions.add(new SelectOption('','NINGUNO'));
        this.NivelRiesgoOptions.add(new SelectOption('1','BAJO'));
        this.NivelRiesgoOptions.add(new SelectOption('2','MODERADO'));
        this.NivelRiesgoOptions.add(new SelectOption('3','MEDIO'));
        this.NivelRiesgoOptions.add(new SelectOption('4','ALTO'));
    }
    
    public SelectOption[] NivelRiesgoOptions
    { 
        public get;
        private set;
    }
    
    //*********************Llenar Nivel de Riesgo***********************************
    public void llenaro(){
        this.NiveloOptions = new SelectOption[]{};
            this.NiveloOptions.add(new SelectOption('','NINGUNO'));
        this.NiveloOptions.add(new SelectOption('1','NO CONTRIBUTIVO'));             
    }
    
    public SelectOption[] NiveloOptions
    {
        public get;
        private set;
    }
}