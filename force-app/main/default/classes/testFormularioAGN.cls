@isTest
public class testFormularioAGN {
	@isTest
    public static void metodo1(){
        String js='{"vccodpais":"074","V_fo_cuenta":null,"v_des_procedfds":"SALARIO","RTN":"null","pnnrocertificado":"999665232888","pnmontoaporte12":0,"pnmontoaporte":0,"pdLugarNacimientoCN":"VALLE","pdfechasuscripcion":"2018-05-29T00:00:00.000Z","pdfechanacimiento":"1994-05-05T00:00:00.000Z","pdfechainiciolabor":"2005-05-05T00:00:00.000Z","pcUsuarioCN":"null","pctiposolicitud":null,"pcTipoMoneda":"1","pcTipoIDDependencia":"null","pctipoid":"1","pcTipoFondo":"P","pcTipoEmpresaEmpCN":"N","pcTIpoEmpleado":"1","pcTipoAporte":"null","pctelempl":"22568941","pcTelefonoCN":"98563210","pcTelefono_ReferidoReferi2":"89562310","pcTelefono_Referido1Referi1":"56897412","pcSumaAsegurada":"null","pcsubproducto":"FI010","pcsexo":"M","pcSegundoNombreReferi2":"null","pcSegundoNombreReferi1":"null","pcsegundonombre":"2","pcSegundoApellidoReferi2":"null","pcSegundoApellidoReferi1":"null","pcsegundoapellido":"null","pcSalarioP":"500","pcrncempl":"08019015715256","pcrazonsocialempl":null,"pcpromotor":"HN19963","pcProfesionOcupacion":"null","pcproducto":"01","pcPrimerNombreReferi2":"LOLA","pcPrimerNombreReferi1":"CAMIL","pcprimernombre":"PRUEBA","pcPrimerApellidoReferi2":"VISNMOKE","pcPrimerApellidoReferi1":"PRUEBA","pcprimerapellido":"PRUEBA","pcPrimaAsegurada":"null","pcperiodicidad":"M","pcPEP":"null","pcPaisEmpleadorCN":null,"pcNUMUSU":"5401","pcNumeroIDPV":"null","pcNumeroIDDependencia":"null","PCNumeroAPNFD":"null","pcnroid":"0501199400026","pcNombreempl":"ADMINISTRADORA DE FONDOS DE PENSION FICOHSA","pcNombreConyuge":"null","pcNombreCompletoPV":"null","pcNombreCompletoDependencia":"null","pcNivelIngreso":"null","pcnacionalidad3":"null","pcnacionalidad2":"null","pcnacionalidad":"074","pcMunicipioEmpleadorCN":"04","pcMunicipioCN":"04","pcmailempl":"JABRITHO@GRUPOFICOHSA.HN","pcmail":"arprueba@hotmail.com","pcGiroEmpresaEmpCN":"1","pcformapago":"CK","pcFechaVencimientoCN":null,"pcFechaValidacionCN":null,"pcFATCA":"null","pcextempl":"null","pcestadocivil":"S","pcEst_cuenta":"I","pcenvio":"E","pcempresa":null,"pcEjerce_Cargo_Publico":"null","pcdirempl":"PAYAQUIL","pcDiaAportacion":"1","pcDeptoEmpleadorCN":"120","pcDeptoCN":"120","pcDependeSI":"N","pcDependeNO":"null","pccuentapago":"null","pccontratocolectivo":"33101","pcColoniaEmpleadorCN":"0012","pcColoniaCN":"0012","pccodpais":"074","pcCod_Causa":"03","pcCelularCN":"null","pcCargoEmpresaEmpCN":"OFTEC","pcCargoEjercido":null,"pcCalleDetalleCN":"BARRIOAZUL","pcAPNFD":"N","pcaplicaseguro":"N","pcagencia":null,"PC_NIVEL_RIESGO":"2","PC_DEBIDA_DELIGENCIA":"2","pc_codCuenta":null,"pc_ActuaSItercera":null,"pc_ActuaSI":"null","pc_ActuaNumID":null,"pc_ActuaNombreCompleto":null,"PaisResidenciaEfectosFiscales":"null","OcultaCarSI":null,"NumeroID_Fiscal_OtroPais":"null","NumeroID_Fiscal_EEUU":"null","ListBeneficiarios":[],"ListDirecciones":[],"ListTelefonos":[],"fechaVencimiento":null,"fechaValida":null,"fechasuscripcion":null,"fechaNacimiento":null,"fechaLabor":null,"ES_Residente_EfectosMi":"null","ES_Residente":"null","Cargo_Pulbico":"null","BLACKLIST":null,"AplicaSeguroNO":null,"AML":null}';
        PageReference vf = new PageReference('/apex/ormularioIdentificacion_PDF');
        Test.setCurrentPage(vf);
        ApexPages.currentPage().getParameters().put('JSONString',js);
        ApexPages.currentPage().getParameters().put('codigoCuenta','23');
        new formularioIdentificacion_PDF_CONT();
         
        formularioIdentificacion_PDF_CONT p = new formularioIdentificacion_PDF_CONT();
        p.tel = '';
        p.telRes = '';
        p.dir = '';
        p.depto = '';
        p.mun = '';
        p.col = '';
        p.pais = '';
        p.P = '';
        p.De = '';
        p.Mu = '';
        p.Co = '';
        p.fechaVencimiento='';
        p.direct='';
        p.Nac='';
        /*Pais_R__c paisr = new Pais_R__c(codigo__C = '074', nombre__C = 'Test', name = 'Test');
        insert paisr;
        
        Departamentos__c depart = new Departamentos__c (codigo_departamento__c = '074',codigo_pais__c='074', Departamento__c = 'FM');
        insert depart;
        
        Municipio__c muni =new Municipio__c (nombre_municipio__c ='test',Codigo_Departamento_Municipio__c='323', codigo_municipio__c = '074', codigo_pais__c = '074', codigo_departamento__c='074');
        insert muni;
        
        Colonias_U__c colo = new Colonias_U__c(nombre_colonia__C = 'Colonia', codigo_colonia__c = '074', codigo_municipio__c = '074', codigo_pais__c = '074', codigo_departamento__c='074');
        insert colo;
        list<Direcciones> di = new list<Direcciones>(); 
        ClassDirecion clasedire = new ClassDirecion('1','1','1','1','1','1','1','1',1.0);
        Direcciones clasedirec = new Direcciones('', '', '', '', '', '');*/
    }
}