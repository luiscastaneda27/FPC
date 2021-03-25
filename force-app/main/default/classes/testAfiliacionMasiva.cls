@isTest
public class testAfiliacionMasiva {
    static testMethod void ReporteAfiliacionT24Masivo()
    {     
        reporteT24__c archivo= new reporteT24__c (noEmpleado__c='20125',fechaIngresoCuentas__c=date.today() , TipoId__c='1', noEmpresa__c= ' ',identificacion__c='0801-1995-22369' ,
                                                pApellidoEmpleado__c='FIGUEROA' , sApellidoEmpleado__c= ' ' ,pNombreEmpleado__c='SERGIO' ,sNombreEmpleado__c= ' ' ,
                                                nacionalidad__c='074' , fechaNacimientoEmpleado__c=date.today() , sexo__c='M' , estadoCivil__c='S' , envio__c='O' ,
                                                direccion__c='h' , nroDireccion__c= ' ' , nroEdificio__c= ' ' , codPais__c='074' , codR__c='123' , cod__c= ' ', codSector__c= ' ',
                                                codC__c= ' ', telefonoEmpleado__c='32658596' , correoEmplead__c= ' ' , aplicaSeg__c='N' , ingresoBrutoCalculado__c= ' ',
                                                producto__c='03' , subProducto__c='FPC25' , Periodo__c='M' , formaPago__c= ' ' , cuenta__c= ' ' , entePaga__c= ' ',
                                                tipoAporte__c= ' ' , montoAporte__c= 1 , montoAporteP__c = 2 , ocupacion__c='30' , promotor__c='HN22578' ,nombrePromotor__c= ' ' , 
                                                rtnEmpleador__c='023056874' ,razonSocial__c= 'PATITO' , nombreEmpresa__c='PATITO' , fechaIngresoEmpresa__c=date.today() , 
                                                telefonoEmpresa__c='65465468' , extension__c= ' ', fax__c= ' ', direccionEmpresa__c='hjjhg' , correoEmpresa__c='hbjhb' , 
                                                tipoSolicitud__c= ' ' , NombreRef1__c='PAUL' , nombre2Ref1__c= ' ', Apellido1Ref1__c='VALLADARES' , 
                                                Apellido2Ref1__c= ' ' ,telefonoRef1__c= ' ' , NombreRef2__c='FERNANDO' , Nombre2Ref2__c= ' ',
                                                Apellido1Ref2__c='SALGADO' , Apellido2Ref2__c= ' ', telefonoRef2__c='3265987421' , cargoEmpleado__c='DOCTOR(A)' ,
                                                lugarNacimiento__c='TEGUCIGALPA' , nombreConyugue__c= ' ' , primerNombreBen1__c='SOLTER' , Nombre2Benf1__c= ' ' ,Apellido1Benf1__c='CARBALO' ,
                                                Apellido2Benf1__c= ' ',parentescoBenf1__c='PADRE' ,porcentajeBenf1__c='100' ,Nombre1Benf2__c= ' ', Nombre2Benf2__c= ' ',
                                                Apellido1Benf2__c= ' ',Apellido2Benf2__c= ' ',parentescoBenf2__c= ' ',porcentajeBenf2__c= ' ', Nombre1Benf3__c= ' ', Nombre2Benf3__c= ' ',
                                                Apellido1Benf3__c= ' ',Apellido2Benf3__c= ' ',parentescoBenf3__c= ' ',porcentajeBenf3__c= ' ', Nombre1Benf4__c= ' ', Nombre2Benf4__c= ' ',
                                                Apellido1Benf4__c= ' ',Apellido2Benf4__c= ' ',parentescoBenf4__c= ' ',porcentajeBenf4__c= ' ' , Nombre1Benf5__c= ' ', Nombre2Benf5__c= ' ',
                                                Apellido1Benf5__c= ' ',Apellido2Benf5__c= ' ',parentescoBenf5__c= ' ',porcentajeBenf5__c= ' ', Nombre1Benf6__c= ' ', Nombre2Benf6__c= ' ',
                                                Apellido1Benf6__c= ' ',Apellido2Benf6__c= ' ',parentescoBenf6__c= ' ',porcentajeBenf6__c= ' ',usuario__c= ' ', respuesta__c= ' ');
        insert archivo;
        
        
        datoManualT24__c datos= new datoManualT24__c (promotor__c = ' ', subproducto__c = ' ', producto__c=' ');
        insert datos;
        test.startTest();
        
        ReporteAfiliacionT24Masivo p = new ReporteAfiliacionT24Masivo();
        p.asesores();
        p.empresa = '2';
        
        p.respuesta = '';
                
        String grado;
        grado=ReporteAfiliacionT24Masivo.BenefGrado('Amigo');
        grado=ReporteAfiliacionT24Masivo.BenefGrado('1');
        grado=ReporteAfiliacionT24Masivo.BenefGrado('7');
        grado=ReporteAfiliacionT24Masivo.BenefGrado('9');
		
        String Parentesco;
        Parentesco=ReporteAfiliacionT24Masivo.BenefParentesco('Amigo');
        Parentesco=ReporteAfiliacionT24Masivo.BenefParentesco('Esposo');
        Parentesco=ReporteAfiliacionT24Masivo.BenefParentesco('Tio');
        Parentesco=ReporteAfiliacionT24Masivo.BenefParentesco('Primo');
        Parentesco=ReporteAfiliacionT24Masivo.BenefParentesco('Padre');
        Parentesco=ReporteAfiliacionT24Masivo.BenefParentesco('Hijo');
        Parentesco=ReporteAfiliacionT24Masivo.BenefParentesco('Abuelo');
        Parentesco=ReporteAfiliacionT24Masivo.BenefParentesco('Sobrino');
        Parentesco=ReporteAfiliacionT24Masivo.BenefParentesco('Padrasto');
        Parentesco=ReporteAfiliacionT24Masivo.BenefParentesco('Hermano');
		        
        String codDep;
        String dir='BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .SAN PEDRO SULA .CORTES .HONDURAS';
        String dir2='BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .VILLA DE SAN FRANCISCO .Francisco Morazan .HONDURAS';
        codDep=ReporteAfiliacionT24Masivo.codDepartamento('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .DANLI .EL PARAISO .HONDURAS');
        codDep=ReporteAfiliacionT24Masivo.codDepartamento('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .DANLI .ISLAS DE LA BAHIA .HONDURAS');
        codDep=ReporteAfiliacionT24Masivo.codDepartamento(dir);
        codDep=ReporteAfiliacionT24Masivo.codDepartamento(dir2);
        codDep=ReporteAfiliacionT24Masivo.codDepartamento('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .VILLA DE SAN FRANCISCO .GRACIAS A DIOS .HONDURAS');
        codDep=ReporteAfiliacionT24Masivo.codDepartamento('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .DISTRITO CENTRAL');
        codDep=ReporteAfiliacionT24Masivo.codDepartamento('BRISAS');
        codDep=ReporteAfiliacionT24Masivo.codDepartamento('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .AZACUALPA .SANTA BARBARA .HONDURAS');
        codDep=ReporteAfiliacionT24Masivo.codDepartamento('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .LA PAZ .LA PAZ .HONDURAS');
        
        String codMun;       
        codMun=ReporteAfiliacionT24Masivo.codM(dir, '122');
        codMun=ReporteAfiliacionT24Masivo.codM(dir2, '123');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .BRUS LAGUNA .GRACIAS A DIOS .HONDURAS', '130');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .PUERTO LEMPIRA .GRACIAS A DIOS .HONDURAS', '130');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .JUAN FRANCISCO BULNES .GRACIAS A DIOS .HONDURAS', '130');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .VILLEDA MORALES .GRACIAS A DIOS .HONDURAS', '130');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .EL PARAISO .EL PARAISO .HONDURAS', '136');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .MERCEDES DE ORIENTE .LA PAZ .HONDURAS', '132');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .SANTIAGO DE PURINGLA .LA PAZ .HONDURAS', '132');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .SAN PEDRO DE TUTULE .LA PAZ .HONDURAS', '132');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .SAN ANTONIO DEL NORTE .LA PAZ .HONDURAS', '132');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .DULCE NOMBRE .COPAN .HONDURAS', '129');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .SANTA FE .COLON .HONDURAS', '137');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .BONITO ORIENTAL .COLON .HONDURAS', '137');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .OCOA .COLON .HONDURAS', '137');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .LA PAZ .LA PAZ .HONDURAS', '132');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .SANTA ANA DE YUSGUARE .CHOLUTECA .HONDURAS', '135');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .NUEVA ARCADIA ( LA ENTRADA ) .COPAN .HONDURAS', '129');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .SAN ANTONIO DE FLORES .CHOLUTECA .HONDURAS', '135');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .SAN FRANCISCO DE CORAY .VALLE .HONDURAS', '134');        
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .JESUS DE OTORO .INTIBUCA .HONDURAS', '133');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .CONCEPCION DE MARIA .VALLE .HONDURAS', '134');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .SAN FRANCISCO DE OPALACA .INTIBUCA .HONDURAS', '133');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .SANTA CRUZ .CHOLUTECA .HONDURAS', '135');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .SAN MARCOS DE CAIQUIN .LEMPIRA .HONDURAS', '131');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .SAN LORENZO .VALLE .HONDURAS', '134');        
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .SAN MARCOS DE LA SIERRA .INTIBUCA .HONDURAS', '133');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .SAN LUCAS .EL PARAISO .HONDURAS', '136');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .SAN MATIAS .EL PARAISO .HONDURAS', '136');
        codMun=ReporteAfiliacionT24Masivo.codM('BRISAS DE CEMCOL .HAY UNA PULPERIA EN EL PASAJE .VADO ANCHO .EL PARAISO .HONDURAS', '136');
        
        String objeto;       
        objeto=ReporteAfiliacionT24Masivo.llenarObjetos('"prueba"');
        objeto=ReporteAfiliacionT24Masivo.llenarObjetos('""');
        objeto=ReporteAfiliacionT24Masivo.llenarObjetos('prueba');
        objeto=ReporteAfiliacionT24Masivo.llenarObjetosMonetarios('prueba');
        
        String direccion;       
        direccion=ReporteAfiliacionT24Masivo.dirreccion(dir);
        
        String fecha;       
        fecha=ReporteAfiliacionT24Masivo.fechas('20--09--2017');     
        fecha=ReporteAfiliacionT24Masivo.fechas('20--09--2020');
        fecha=ReporteAfiliacionT24Masivo.fechas(NULL);
        
        String EstCivil;       
        EstCivil=ReporteAfiliacionT24Masivo.estadoCivil('"UL"');
        
        String PActualizar;       
        PActualizar=ReporteAfiliacionT24Masivo.pendientesActualizar('"UPDATE PENDING"');
        
        String Nac;       
        Nac=ReporteAfiliacionT24Masivo.LUGAR_NACIMIENTO('"NO PARAMETRIZADO"');
		Nac=ReporteAfiliacionT24Masivo.LUGAR_NACIMIENTO(' ');   
        
        string ags=''; 
	    string encabezado='"No. De Empleado","Fecha Ingreso a la cuenta","No. De Empresa","tip_id","ID",';
        string encabezado2='"1 APELLIDO","2 APELLIDO","1 NOMBRE","2 NOMBRE","NACIONALIDAD","FECHA NACIMIENTO","SEXO","ESTADO CIVIL",';
        string encabezado3= '"ENVIO","DIRECCION","Nro. Direccion","No. Edificio","Codigo Pais","Codigo Region","Codigo Provincia","Codigo Ciudad",';
        string encabezado4='"Codigo Sector","TELEFONO","CORREO","aplica seguro","ibc","producto","subproducto","periodicidad","forma de pago",';
        string encabezado5='"cuenta pago","ente paga","tipo aporte","monto aporte","monto aporte neto","ocupacion","promotor","Nombre promotor",';
        string encabezado6='"rtn empleador","Razon social empresa","Nombre empresa","FECHA DE INGRESO EMPRESA","telefono Empresa","extencion empresa",';
        string encabezado7='"fax empresa","direccion empresa","email empresa","tipo solicitud","refe1primer_nom","refe1segun_nom","refe1primer_ape","refe1segun_ape",';
        string encabezado8='"tel_refe1","refe2primer_nom","refe2segun_nom","refe2primer_ape","refe2segun_ape","tel_refe2","cargo_emp","LUGAR_NACIMIENTO",';
        string encabezado9='"NOMBRE_CONYUGUE","BENF1primer_nom","BENF1Segundo_nom","BENF1primer_ape","BENF1segun_ape","BENF1parentesco","BENF1porcentaje",';
        string encabezado10='"BENF2primer_nom","BENF2Segundo_nom","BENF2primer_ape","BENF2segun_ape","BENF2parentesco","BENF2porcentaje","BENF3primer_nom","BENF3Segundo_nom","BENF3primer_ape","BENF3segun_ape","BENF3parentesco","BENF3porcentaje","BENF4primer_nom","BENF4Segundo_nom","BENF4primer_ape","BENF4segun_ape","BENF4parentesco","BENF4porcentaje","BENF5primer_nom","BENF5Segundo_nom","BENF5primer_ape","BENF5segun_ape","BENF5parentesco","BENF5porcentaje","BENF6primer_nom","BENF6Segundo_nom","BENF6primer_ape","BENF6segun_ape","BENF6parentesco","BENF6porcentaje"';
        string cuerpo='"0156579110PR5","11--10--2018","","1","0207-1999-00088","PALMA","MURILLO","MERY","YADIRA","Hondureña","20--07--1998","F","S","O","LOS CASTANOS . CASA COLOR VERDE .SAN PEDRO SULA","","","074","122","09","000","000","95992744","","N","","01","FPC06","M","PL","","","B","","","30","HN19334","RIVERA MORENO KENIA CAROLINA","05019013617710","GENESIS APPAREL S DE RL DE CV","GENESIS APPAREL S DE RL DE CV","01--10--2018","26695157","","","ZIP CHOLOMA . COSTADO NO COMPLEJO ZIP TEX","CHUY@ELCATEX.COM","I","CARLA","","PALMA","","96395819","","","","","","OPERARIO (A)","SANTA ROSA DE AGUAN","","CARLA","PALMA","","","Padre / Madre","50","JUAN","PALMA","","","Hermano(a)","50",,,,,,,,,,,,,,,,,,,,,,,,';
        string stringCSV= encabezado+encabezado2+encabezado3+encabezado4+encabezado5+encabezado6+encabezado7+encabezado8+encabezado9+encabezado10 +'\n'+ cuerpo;
        classWRetorno2 error = new classWRetorno2();
        error = ReporteAfiliacionT24Masivo.SUbirInformacion(stringCSV, 'UserPru' ,ags);
         
        
        String prueba;
        String prueba2;
        String pruebaCSV;
        prueba='"No. De Empleado","Fecha Ingreso a la cuenta","No. De Empresa","tip_id","ID","1 APELLIDO","2 APELLIDO","1 NOMBRE","2 NOMBRE","NACIONALIDAD","FECHA NACIMIENTO","SEXO","ESTADO CIVIL","ENVIO","DIRECCION","Nro. Direccion","No. Edificio","Codigo Pais","Codigo Region","Codigo Provincia","Codigo Ciudad","Codigo Sector","TELEFONO","CORREO","aplica seguro","ibc","producto","subproducto","periodicidad","forma de pago","cuenta pago","ente paga","tipo aporte","monto aporte","monto aporte neto","ocupacion","promotor","Nombre promotor","rtn empleador","Razon social empresa","Nombre empresa","FECHA DE INGRESO EMPRESA","telefono Empresa","extencion empresa","fax empresa","direccion empresa","email empresa","tipo solicitud","refe1primer_nom","refe1segun_nom","refe1primer_ape","refe1segun_ape","tel_refe1","refe2primer_nom","refe2segun_nom","refe2primer_ape","refe2segun_ape","tel_refe2","cargo_emp","LUGAR_NACIMIENTO","NOMBRE_CONYUGUE","BENF1primer_nom","BENF1Segundo_nom","BENF1primer_ape","BENF1segun_ape","BENF1parentesco","BENF1porcentaje","BENF2primer_nom","BENF2Segundo_nom","BENF2primer_ape","BENF2segun_ape","BENF2parentesco","BENF2porcentaje","BENF3primer_nom","BENF3Segundo_nom","BENF3primer_ape","BENF3segun_ape","BENF3parentesco","BENF3porcentaje","BENF4primer_nom","BENF4Segundo_nom","BENF4primer_ape","BENF4segun_ape","BENF4parentesco","BENF4porcentaje","BENF5primer_nom","BENF5Segundo_nom","BENF5primer_ape","BENF5segun_ape","BENF5parentesco","BENF5porcentaje","BENF6primer_nom","BENF6Segundo_nom","BENF6primer_ape","BENF6segun_ape","BENF6parentesco","BENF6porcentaje"\n';
        prueba2='"PR13","11--10--2018","","1","0207-1999-00088","PALMA","MURILLO","MERY","YADIRA","Hondureña","20--07--1998","F","S","O","LOS CASTANOS . CASA COLOR VERDE .SAN PEDRO SULA","","","074","122","09","000","000","95992744","","N","","01","FPC06","M","PL","","","B","","","30","HN19334","RIVERA MORENO KENIA CAROLINA","05019013617710","GENESIS APPAREL S DE RL DE CV","GENESIS APPAREL S DE RL DE CV","01--10--2018","26695157","","","ZIP CHOLOMA . COSTADO NO COMPLEJO ZIP TEX","CHUY@ELCATEX.COM","I","CARLA","","PALMA","","96395819","","","","","","OPERARIO (A)","SANTA ROSA DE AGUAN","","CARLA","PALMA","","","Padre / Madre","50","JUAN","PALMA","","","Hermano(a)","50",,,,,,,,,,,,,,,,,,,,,,,,';
        pruebaCSV=prueba+prueba2;
        error = ReporteAfiliacionT24Masivo.SUbirInformacion(pruebaCSV, 'UserPru' ,ags);
        
        String prueba3;
        String prueba4;
        String pruebaCSV1;
        prueba='"No. De Emplead","Fecha Ingreso a l cuenta","No. De Empres","tip_i","ID","1 APELLID","2 APELLID","1 NOMBR","2 NOMBR","NACIONALIDA","FECHA NACIMIENT","SEX","ESTADO CIVI","ENVI","DIRECCIO","Nro. Direccio","N. Edificio","Codigo Pai","Codig Region","Codig Provincia","Codigo Ciuda","Codig Sector","TELEFON","CORRE","aplic seguro","ib","product","subproduct","periodicida","forma d pago","cuenta pag","ente pag","tip aport","mont aport","mont aporte neto","ocupacio","promoto","Nombr promotor","rtn empleado","Raon social empresa","Nombre emprea","FECHA DE IGRESO EMPRESA","telefono mpresa","extencion empesa","fax empres","direccion epresa","email empres","tipo slicitud","refe1prier_nom","refe1seun_nom","refe1prier_ape","refe1egun_ape","te_refe1","refe2prmer_nom","rfe2segun_nom","refeprimer_ape","refe2egun_ape","tel_rfe2","cargo_em","LUGR_NACIMIENTO","NOMBRE_CNYUGUE","BENFprimer_nom","BEN1Segundo_nom","BEN1primer_ape","BEN1segun_ape","BEF1parentesco","BENF1orcentaje","BENF2prime nom","BENFSegundo_nom","BENF2rimer_ape","BENF2seun_ape","BENF2paretesco","BENF2porcenaje","BENF3prime_nom","BENF3Segndo_nom","BENFprimer_ape","BEN3segun_ape","BENFparentesco","BENFporcentaje","BENFprimer_nom","BENF4Seundo_nom","BENF4rimer_ape","BENF4sgun_ape","BEF4parentesco","BEF4porcentaje","BENF5prmer_nom","BENF5Segudo_nom","BEN5primer_ape","BEF5segun_ape","BENFparentesco","BENFporcentaje","BENFprimer_nom","BEN6Segundo_nom","BENF6pimer_ape","BEF6segun_ape","BENF6paentesco","BENF6porentaje"\n';
        prueba2='"PR13","11--10--2018","","1","0207-1999-00088","PALMA","MURILLO","MERY","YADIRA","Hondureña","20--07--1998","F","S","O","LOS CASTANOS . CASA COLOR VERDE .SAN PEDRO SULA","","","074","122","09","000","000","95992744","","N","","01","FPC06","M","PL","","","B","","","30","HN19334","RIVERA MORENO KENIA CAROLINA","05019013617710","GENESIS APPAREL S DE RL DE CV","GENESIS APPAREL S DE RL DE CV","01--10--2018","26695157","","","ZIP CHOLOMA . COSTADO NO COMPLEJO ZIP TEX","CHUY@ELCATEX.COM","I","CARLA","","PALMA","","96395819","","","","","","OPERARIO (A)","SANTA ROSA DE AGUAN","","CARLA","PALMA","","","Padre / Madre","50","JUAN","PALMA","","","Hermano(a)","50",,,,,,,,,,,,,,,,,,,,,,,,';
        pruebaCSV1=prueba3+prueba4;
        error = ReporteAfiliacionT24Masivo.SUbirInformacion(pruebaCSV1, 'UserPru' ,ags);
        
        p.pcproducto = '01';
        p.nuevoProducto=True;
        p.EliminarContenido();
        p.pcsubproducto='FPC25';
        p.cargaAfiliacion=true;
        list<reporteT24__c> rellenoTabla = new list<reporteT24__c>();
       // p.MostrarRef();
        //p.MostrarBene();
        p.siguiente();
        p.anterior();
        p.VerPlanilla();
        list<reporteT24__c> datosExcel = rellenoTabla;
        list<classBeneficiarioT24> InfoBenfxCliente = new list<classBeneficiarioT24>();        
        classBeneficiarioT24 bene;
        classBeneficiarioT24 r;
        bene= p.ListaInfoBenf1=new classBeneficiarioT24('Alex','Mauricio','Corrales','Alcantara','Hermano(a)','100','1');
        classEnviarBeneficiarioxCliente benClientes= new classEnviarBeneficiarioxCliente(InfoBenfxCliente);
        classDatosPersonales DatosPersonal= new classDatosPersonales( 'NoEmpleado', date.today(), 'TipoId', 'NumEmpresa', 'Identificacion',
                                 'pNombre', 'sNombre', 'pApellido', 'sApellido', 'nacionalidades',
                                 date.today(), 'sexo', 'estadoCivil', 'envio', 'direccion',  
                                  'codPais', 'codRegion','codProvincia', 'codCiudad', 
                                  'telefono', 'celular','correoEmpleado');
        classInfoAportSeg info= new classInfoAportSeg ('aplicaSeguro', 'ingresobrutocot', 'producto', 'subProducto',
                          'periocidad', 'formaPago', 'cuentaPago', 'tipoAporte',
                          1, 1, 'ocupacionEmpleado','codPromotor', 
                          'nombrePromotor', 'rtnEmpleador', 'razonSocial','nombreEmpresa',
                          date.today(), 'telefonoEmpresa', 'extEmpresa','faxEmpresa', 
                          'dirEmpresa', 'correoEmpresa', 'tipoSolicitud','RTN');
        InfoBenfxCliente.add(bene);
        List<classDatosPersonales> ListaDatosPersonales= new list<classDatosPersonales>();
        List<classEnviarBeneficiarioxCliente> classEnviarBeneficiarioxCliente= new list<classEnviarBeneficiarioxCliente>();
         p.ListaFinal= NEW List<classReferencias>();
        List<classInfoAportSeg> classInfoAportSeg= new list<classInfoAportSeg>();
        p.ref = new reporteT24__c();
        p.BeneSalir();
        p.Num_CodReferencia='20125';
        p.CambioProducto();  
        p.VerBene=true;
        p.MostrarBtn();
        p.btnDatosMC();
        p.btnDatosAs();     
       // p.MostrarBene();
        p.VerRef=true;
        p.RefSalir();
        //p.referencia_Datos=new List<ClassReferenciaxClienteT24>(); 
        ClassReferenciaxClienteT24 rf = new ClassReferenciaxClienteT24 ('primerNomRef', 'segundoNomRef', 'primerApeRef', 'segundoApeRef', 'telefonoRef');
        ClassReferenciaxClienteT24 rff = new ClassReferenciaxClienteT24 ('primerNomRef2', 'segundoNomRef2', 'primerApeRef2','segundoApeRef2', 'telefonoRef2');
        
        //classReferencias rfs= new
        p.cargaAfiliacion=true;
        p.datosManuales= [select promotor__c,subproducto__c,producto__c from datoManualT24__c order by indice__c desc limit 1];
        apiReporteT24 apii = new apiReporteT24();
        
        apiReporteT24.classRespuestaT24 A= new apiReporteT24.classRespuestaT24();
        A.Certificado='325';
        A.Mensaje='325'; 
        A.ModificarEstado = [select respuesta__c,  noEmpleado__c                                
                                   from reporteT24__c ];
         
        A.sizeResu = 1;
        A.sizeModi = 1;
        
        ClassEnviarT24lista env = new ClassEnviarT24lista(ListaDatosPersonales, classInfoAportSeg, p.ListaFinal,classEnviarBeneficiarioxCliente);  
        apiReporteT24.guardarT24(env);
       
       classReferencias referencia88= new classReferencias( 'primerNomRef',  'segundoNomRef',  'primerApeRef','segundoApeRef', 'telefonoRef', 'primerNomRef2', 'segundoNomRef2', 'primerApeRef2','segundoApeRef2', 'telefonoRef2', 'cargo', 'lugarNacimiento', 'nomConyuge', 'usuario');
 
        test.stopTest();
        
    }
    
      

}