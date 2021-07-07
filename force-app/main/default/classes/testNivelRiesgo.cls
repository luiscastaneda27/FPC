@isTest
public class testNivelRiesgo {
    static testMethod void ControllerSeveridadRiesgo(){ 
        test.startTest();
        
        ControllerSeveridadRiesgo nv = new ControllerSeveridadRiesgo();
        nv.NivelRiesgo = '';
        nv.CodRiesgo = null;
        nv.Porcentaje_Inicial =null;
        nv.Porcentaje_Final =null; 
        nv.RiesgoPonderacion = null;
        nv.RiesgoTipoCliente = NULL;
        nv.RiesgoTipoPersona = NULL;
        nv.RiesgoTipoDocumento = NULL;
        nv.RiesgoFechaAfiliacion = NULL;
        nv.RiesgoFechaNacimiento = NULL;
        nv.RiesgoTrabaja = NULL;
        nv.RiesgoOcupacion = NULL;
        nv.RiesgoListaExcepciones = NULL;
        nv.RiesgoListaPep = NULL;
        nv.Riesgoproducto = NULL;
        nv.Riesgocanal = NULL;
        nv.RiesgoMunicipalidad = NULL;
        nv.RiesgoNacionalidad = NULL;
        //JR
        nv.RiesgoFechaConstitucion = NULL;
        nv.RiesgoGiroEmpresa = NULL;
        nv.RiesgoUbicacionEmpresa = NULL;
        
        //Total
        nv.TotalRiesgoCliente = NULL;
        nv.TotalRiesgoRamo = NULL;
        nv.TotalRiesgoCanal = NULL;
        nv.TotalRiesgoGeografico = NULL;
        nv.NivelRiesgoTotal = NULL;
        
        //VARIABLES PARA EL PORCENTAJE DE RIESGO
        nv.ValorRiesgoTipoCliente = NULL;
        nv.ValorRiesgoTipoPersona = NULL;
        nv.ValorRiesgoTipoDocumento = NULL;
        nv.ValorRiesgoFechaAfiliacion = NULL;
        nv.ValorRiesgoFechaNacimiento = NULL;
        nv.ValorRiesgoTrabaja = NULL;
        nv.ValorRiesgoOcupacion = NULL;
        nv.ValorRiesgoListaExcepciones = NULL;
        nv.ValorRiesgoListaPep = NULL; 
        //public Integer RiesgocuentaCliente = NULL;   
        nv.ValorRiesgoproducto = NULL;
        //public Integer Riesgocomercializacion = NULL;
        nv.ValorRiesgocanal = NULL;
        nv.ValorRiesgoMunicipalidad = NULL;
        nv.ValorRiesgoNacionalidad = NULL;
        
        //JR
        nv.ValorRiesgoFechaConstitucion = NULL;
        nv.ValorRiesgoGiroEmpresa = NULL;
        nv.ValorRiesgoUbicacionEmpresa = NULL;
        
        //Tipo de cliente
        nv.TipoClienteNJ = NULL;
        
        //TIPO CLIENTE
        nv.TipoCliente = NULL; 
        nv.NivelRiesgoCliente = NULL;  
        
        //TIPO PERSONA
        nv.TipoPersona = NULL; 
        nv.RiesgoPersona = NULL;  
        
        //FECHA NACIMIENTO
        nv.CodFechaNacimiento = NULL; 
        nv.RiesgoFechaNac = NULL; 
        
        //FECHA AFILIA
        nv.CodFechaAfilia = NULL; 
        nv.RiesgoFechaAfilia = NULL; 
        
        //TIPO_DOC
        nv.TipoDoc = NULL; 
        nv.Descripcion_TD = '';
        nv.RiesgoTD = NULL;  
        
        //TRABAJA
        nv.Trabaja = NULL; 
        nv.RiesgoTra = NULL;  
        
        //PEP
        nv.PEP = NULL; 
        nv.RiesgoPep = NULL;        
        
        //EXCEP
        nv.EsExcep = NULL; 
        nv.RiesgoExcep = NULL;        
        
        //PRODUCTO
        nv.TipoProducto = NULL; 
        nv.RieProducto = NULL;     
        nv.RieProducto1 = NULL;     
        //nv.DescripcionProducto = NULL;     
        
        //CANAL
        nv.TipoCanal = NULL; 
        nv.RieCanal = NULL;   
        
        //PROFESION
        nv.TipoProfesion = NULL; 
        nv.RieProfesion = NULL;   
        
        //ACt
        nv.TipoActividad = NULL; 
        nv.RieActividad = NULL;  
        
        //Fecha Constitución
        nv.CodFechaConstitu = NULL; 
        nv.RieConstitucion = NULL;   
        
        //GEOGRAFICO
        nv.CodDepto = NULL; 
        nv.codNacionalidad = NULL;   
        nv.RiesDepto = NULL; 
        nv.RiesNacionalidad = NULL;   
        
        nv.Cod_Riesgo = NULL; 
        nv.Factor = NULL; 
        nv.Descrip_Factor = NULL; 
        nv.Pond_Nat = NULL; 
        nv.Pond_Jur = NULL; 
        nv.Val_Nat = NULL; 
        nv.Val_Jur = NULL; 
        
        nv.BuscaRiesgo();
        nv.BuscaFactor();
        nv.BuscaTipCl();
        nv.BuscaTipPer();
        nv.BuscaFecNac();
        nv.BuscaFecAfilia();
        nv.BuscaTipDoc();
        nv.BuscaTrabaja();
        nv.BuscaPep();
        nv.BuscaExc();
        nv.BuscaProdNat();
        nv.BuscaProdJur();
        nv.BuscaCanal();
        nv.BuscaProfesion();
        nv.BuscaActEco();
        nv.BuscaFechConst();
        nv.BuscaGeograf();
        nv.BuscaGeograNac();
        
        nv.actualizarRiesgo();
        nv.actualizaFactor();
        nv.actualizarRiesgoCliente();
        nv.actualizarRiesgoPersona();
        nv.actualizarFechaNac();
        nv.actualizarFechaAfilia();
        nv.actualizarTipDoc();
        nv.actualizarRiesgoTrabaja();
        nv.actualizarRiesgoPep();
        nv.actualizarRiesgoExcep();
        nv.actualizarRiesgoProdN();
        nv.actualizarRiesgoProdJ();
        nv.actualizarRiesgoCanal();
        nv.actualizarRiesgoProfesion();
        nv.actualizarRiesgoActEcon();
        nv.actualizarFechaCosnt();
        nv.actualizaRiesgoDepto();
        nv.actualizaRiesgoNac();
        nv.actualizarFactorRiesgo();
        nv.actualizaVariablesFactor();
        nv.EnviaMR();
        nv.EnviaFactor();
        nv.limpiar();
        nv.limpiar1();
        
        Matriz_Riesgo__c ec= new Matriz_Riesgo__c( NivelRiesgo__c = '1');
        insert ec;
        
        
        ClaseNivelDeRiesgo ClaseNder = new ClaseNivelDeRiesgo();//(1.0,'1',1.0,1.0,1.0);
        ClaseNder.CodRiesgo = null;
        ClaseNder.NivelRiesgo = '';
        ClaseNder.Porcentaje_Final = null;
        ClaseNder.Porcentaje_Inicial = null;
        ClaseNder.RiesgoPonderacion = null;
        
        ClaseRiesgoActEcon ClaAE = new ClaseRiesgoActEcon();
        ClaAE.TipoActividad = '';
        ClaAE.RieActividad = '';
        
        ClaseTrabaja ClasTR = new ClaseTrabaja();
        ClasTR.Trabaja = ''; 
        ClasTR.RiesgoTra = '';
        
        ClaseRiesgoCanal ClasCa = new ClaseRiesgoCanal();
        ClasCa.RieCanal = '';
        ClasCa.TipoCanal = '';
        
        ClaseExcepciones ClasEx = new ClaseExcepciones();
        ClasEx.EsExcep = '';
        ClasEx.RiesgoExcep = '';
        
        ClaseRiesgoProfesion ClasP = new ClaseRiesgoProfesion();
        ClasP.RieProfesion = '';
        ClasP.TipoProfesion = '';
        
        ClaseTipoPersona ClasTp = new ClaseTipoPersona();
        ClasTp.RiesgoPersona = '';
        ClasTp.TipoPersona = '';
        
        ClasePep ClasPe = new ClasePep();
        ClasPe.PEP = '';
        ClasPe.RiesgoPep = '';
        
        ClaseFechaConsti ClaFC = new ClaseFechaConsti();
        ClaFC.CodFechaConstitu = '';
        ClaFC.RieConstitucion = '';
        
        ClaseFechaAfilia ClaFA = new ClaseFechaAfilia();
        ClaFA.CodFechaAfilia = '';
        ClaFA.RiesgoFechaAfilia = '';
        
        ClaseTipoCliente ClaTP = new ClaseTipoCliente();
        ClaTP.Descripcion_TC = '';
        ClaTP.NivelRiesgoCliente = '';
        ClaTP.TipoCliente = '';
        
        ClaseRiesgoProducto ClaPR = new ClaseRiesgoProducto();
        ClaPR.RieProducto = '';
        ClaPR.TipoProducto = '';
        
        ClaseTipDoc ClaTD = new ClaseTipDoc();
        ClaTD.Descripcion_TD = '';
        ClaTD.TipoDoc = '';
        ClaTD.RiesgoTD = '';
        
        ClaseFechaNac ClaFN = new ClaseFechaNac();
        ClaFN.CodFechaNacimiento = '';
        ClaFN.RiesgoFechaNac = '';        
        
        ClassActualizaFactor ActlasFac = new ClassActualizaFactor();
        classActualizaFechaConsti ActFechC = new classActualizaFechaConsti();
        classActualizaTipDoc ActTD = new classActualizaTipDoc();
        classActualizaProducto ActPr = new classActualizaProducto();
        classActualizaTipoCliente ActTcly = new classActualizaTipoCliente();
        classActualizaExcep ActExc = new classActualizaExcep();
        classActualizaNivelRiesgo ActR = new classActualizaNivelRiesgo();
        ActR.NivelRiesgo = '';
        ActR.Porcentaje_Inicial = null;
        ActR.Porcentaje_Final = null;
        ActR.RiesgoPonderacion = null;
        ActR.usuarioM = 'prueba';
        claseFactoresDeRiesgo factor = new claseFactoresDeRiesgo();
        factor.TipoCliente = '';
        factor.RiesgoTipoCliente = '';
        factor.RiesgoTipoPersona = '';
        factor.RiesgoTipoDocumento = '';
        factor.RiesgoFechaAfiliacion = '';
        factor.RiesgoFechaNacimiento = '';
        factor.RiesgoTrabaja = '';
        factor.RiesgoOcupacion = '';
        factor.RiesgoListaExcepciones = '';
        factor.RiesgoListaPep = '';
        factor.Riesgoproducto = '';
        factor.Riesgocanal = '';
        factor.RiesgoMunicipalidad = '';
        factor.RiesgoNacionalidad = '';
        //JR
        factor.RiesgoFechaConstitucion = '';
        factor.RiesgoGiroEmpresa = '';
        factor.RiesgoUbicacionEmpresa = '';
        
        //VARIABLES PARA EL PORCENTAJE DE RIESGO
        factor.ValorRiesgoTipoCliente = '';
        factor.ValorRiesgoTipoPersona = '';
        factor.ValorRiesgoTipoDocumento = '';
        factor.ValorRiesgoFechaAfiliacion = '';
        factor.ValorRiesgoFechaNacimiento = '';
        factor.ValorRiesgoTrabaja = '';
        factor.ValorRiesgoOcupacion = '';
        factor.ValorRiesgoListaExcepciones = '';
        factor.ValorRiesgoListaPep = '';  
        factor.ValorRiesgoproducto = '';
        factor.ValorRiesgocanal = '';
        factor.ValorRiesgoMunicipalidad = '';
        factor.ValorRiesgoNacionalidad = '';
        //JR
        factor.ValorRiesgoFechaConstitucion = '';
        factor.ValorRiesgoGiroEmpresa = '';
        factor.ValorRiesgoUbicacionEmpresa = '';
        
       /* classAcualizaFechaAporte fa = new classAcualizaFechaAporte(); 
       fa.numDocumento ='';
       fa.nuevafecha = '';*/
    
        
        //  controllerApiClienteNatural apii = new controllerApiClienteNatural();
        controllerApiMatrizdeRiesgo.ConsultaNivelDRiesgo(null); //= new controllerApiMatrizdeRiesgo();
        controllerApiMatrizdeRiesgo.ConsultaFactor(null);
        controllerApiMatrizdeRiesgo.ConsultaTipoCliente(null);
        controllerApiMatrizdeRiesgo.ConsultaTipoPersona(null);
        controllerApiMatrizdeRiesgo.ConsultaFechaNac(null);
        controllerApiMatrizdeRiesgo.ConsultaFechaAfilia(null);
        controllerApiMatrizdeRiesgo.ConsultaTipDoc(null);
        controllerApiMatrizdeRiesgo.ConsultaTrabaja(null);
        controllerApiMatrizdeRiesgo.ConsultaPep(null);
        controllerApiMatrizdeRiesgo.ConsultaExcep(null);
        controllerApiMatrizdeRiesgo.ConsultaProducto(null);
        controllerApiMatrizdeRiesgo.ConsultaCanal(null);
        controllerApiMatrizdeRiesgo.ConsultaProfesion(null);
        controllerApiMatrizdeRiesgo.ConsultaActEcono(null);
        controllerApiMatrizdeRiesgo.ConsultaFechaConst(null);
        controllerApiMatrizdeRiesgo.ConsultaRiesgoGeo(null, null);
        controllerApiMatrizdeRiesgo.ConsultaVariablesFactor(null);
        controllerApiMatrizdeRiesgo.ActualizaNivelDRiesgo(null);  
        
        controllerApiMatrizdeRiesgo.ActualizaTipoCliente(null); 
        controllerApiMatrizdeRiesgo.ActualizaTipoPersona(null);
        controllerApiMatrizdeRiesgo.ActualizaFechaNac(null);
        controllerApiMatrizdeRiesgo.ActualizaFechaAfilia(null);
        controllerApiMatrizdeRiesgo.ActualizaTipoDoc(null);
        controllerApiMatrizdeRiesgo.ActualizaRiesTrabaja(null);
        controllerApiMatrizdeRiesgo.ActualizaRiesPep(null);
        controllerApiMatrizdeRiesgo.actualizaExcep(null);
        controllerApiMatrizdeRiesgo.actualizaProducto(null);
        controllerApiMatrizdeRiesgo.actualizaCanal(null);
        controllerApiMatrizdeRiesgo.actualizaProfesion(null);
        controllerApiMatrizdeRiesgo.actualizaActEcon(null);
        controllerApiMatrizdeRiesgo.actualizaFechaCons(null);
        controllerApiMatrizdeRiesgo.actualizaGeogra(null);
        controllerApiMatrizdeRiesgo.ActualizaFactor(null);
        controllerApiMatrizdeRiesgo.InsertaNivelDRiesgo(null);
        controllerApiMatrizdeRiesgo.InsertaFactor(null);
        
        
    }
}