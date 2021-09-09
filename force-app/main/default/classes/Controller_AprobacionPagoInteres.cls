public class Controller_AprobacionPagoInteres {
    public boolean mostrarRegistrados{get;Set;}
    public boolean mostrarBtnAPROBAR{get;Set;}
    //  public string paso1Cabeza{get;set;}
    // public string paso1Cuerpo{get;set;}
    //public string paso2Cabeza{get;set;}    
    //public string paso2Cuerpo{get;set;}
    public static string interes {get;set;}
    public string pagina{get;set;}
    public string Cuentaun {get;set;}
    //public string FechaActual {get;set;}
    public string Identidad {get;set;}
    public string NombreCompleto {get;set;}
    public string TipoFondo {get;set;}
    public string CausaDescripcion {get;set;}
    public string EstadoCuenta {get;set;}
    public string Codigocausa {get;set;}
    public string Moneda {get;set;}
    public string Mostrar_Moneda {get;set;}
    public string Tipo_Pago{get;set;}
    public double Monto {get;set;}
    public string Ajuste {get;set;}
    public string Cuenta_Banco {get;set;}
    public string Forma_Pago{get;set;}
    public string TipSaldo {get;set;} 
    public string Nombre_Banco {get;set;}
    public string Tipo_Cuenta {get;set;}
    public string DiadePagos {get;set;}
    public string CalculoSobre {get;set;} 
    public String EstadoAprobacion {get;set;}
    public string pagopension {get;set;}
    
    public string Total_Fondo {get;set;}
    public string Fondo_pignorado {get;set;}
    
    public string NombreCompl {get;set;}
    
    public string tocarcapital {get;set;}
    public string cobrartsp {get;set;}
    public string cobrarach {get;set;}
    public string cobrarcheque {get;set;}
    
    /*variables booleanas de control de CHECKBOX*/
    public boolean FIJO_SI {get;set;} /*CUOTA FIJA*/
    public boolean CALCULADO_SI {get;set;} /*CUOTA CALCULADA*/
    public boolean BloqueaFIJO {get;set;} 
    public boolean BloqueaCALCULADO {get;set;}
    public boolean ActivaGuardar {get;set;}
    public boolean ActivaModificar {get;set;}
    
    /*CONTROL DE CAMPOS */
    public boolean ActivarMonto{get;set;}
    public boolean ActivaAjuste{get;set;}  
    public Boolean ActivaDiadePago{get;set;}
    public Boolean ActivaCalculoSobre{get;set;}
    public Boolean ActivaDiaMes{get;set;}
    
    /*Otras Variables*/
    public double Monto_pago {get;set;}
    public double Fondo {get;set;}
    public double Ingresar_Fondo {get;set;}
    public datetime FechaActual {get;set;}
    /**/
    public Boolean ActivaTipoSaldo {get; set; }
    /**/
    public Boolean ActivaFormadePago {get; set; }
    public Boolean ActivaBanco {get; set; }
    public Boolean ActivaCuentaBanco {get; set; }
    public Boolean ActivaTipoCuenta {get; set; }
    public Boolean ActivaAlertas {get; set; }
    //public Boolean DenegarVentana {get; set; }
    
    public Boolean ActivarRegistro {get; set; }
    public Boolean ActivarDenegados {get; set; }
    
    
    public list <selectOption> ListDiaMes {get; set;}
    //public list <selectOption> ListFormPag {get; set;}
    //public string Usuario {get;set;}
    //public string fecha {get;set;}
    
    
    public list<Pago_Interes__c> ListaAprobados {get;set;}
    public list<Pago_Interes__c> ListaRegistrados {get;set;}
    public list<Pago_Interes__c> ListRegRepetidos {get;set;}
    public list<Pago_Interes__c> ListDenegados {get;set;}
    
    
    public List<classPagoInteresesReg> ListIntRegistrados {get;set;}
    public List<classPagoInteresesRegA> listS {get;set;}
    
    public string ID_Referencia {get;set;}
    public string Cuentas {get;set;}
    public string Identid {get;set;}
    public string Num_CodReferenciaDenegado {get;set;}
    public string codcliente {get;set;}
    public string Motivo {get;set;}
    public string fecha {get;set;}
    public string usuario {get;set;}
    public integer Control {get;set;}
    
    public boolean DenegarImagen  {get;set;}
    public boolean DenegarVentana  {get;set;}
    public boolean denegarventanauno {get;set;}
    public boolean popDenegarSalir  {get;set;}
    
    public blob DesconvertirImagen {get;set;}   
    public string Ver_Imagen {get;set;}
    public boolean ActivaFechPago {get;set;}
    public date FechInicioPago {get;set;}
    /*
public date fecha_retiro {get;set;}
public datetime fechaSysdeRetiros {get;set;}
public boolean mostrarTablaRetiros {get;Set;}
public boolean mostrarTablaRetirosC {get;Set;}
public List<cuadreRetiros> ListPagos {get;set;}
public List<cuadreRetirosC> ListPagosC {get;set;}
public string fecha {get;set;}
public string Num_CodReferencia {get;set;}
public List<Retiro_Aprobacion__c> ListPagosConciliados {get;set;}
public List<Retiro_Aprobacion__c> ListEnvioTotal {get;set;}
public List<Retiro_Aprobacion__c> ListEnvioRepetidos {get;set;}
public List<string> ListaEnvioRefere {get;set;}

public date fecha2{get;set;} 
public date fecha3{get;set;} */
    
    public Controller_AprobacionPagoInteres(){
        Usuario =  ApexPages.currentPage().getParameters().get('hytrd');
        MuestraRegistrados();
        
    }
    /*
public void enviarPagPro()
{   

paso1Cabeza = 'slds-is-complete';
paso1Cuerpo = 'slds-hide';

paso2Cabeza = 'slds-is-current';
paso2Cuerpo = 'slds-show';

}*/
    /*
    public pageReference MostarPantalla()
    {
        
        return new pageReference('/apex/vfIntereses_Administrativa_2');  
        
    } */
    
    
    public void MuestraRegistrados(){
        //-----------------------------------------------------------------------
        try{	
            
            classAdmInteres claseRecibida = new classAdmInteres();
            classAdmInteres AdmInteres = controllerAPIinteresAprobados.TraerRegistrados();
            list<String> listIds = new list<String>();
            ListIntRegistrados = AdmInteres.ListIntRegistrados;
            
            for(integer i=0; i<ListIntRegistrados.size(); i++){
                DateTime dT = ListIntRegistrados[i].fechadeRegistro;
                fecha = string.valueOf(string.valueOf(dT.year())+'-'+string.valueOf(dT.month())+'-'+string.valueOf(dT.day()));
                ListIntRegistrados[i].LEE_ERRORES = fecha;
                listIds.add(String.valueOf(Integer.valueOf( ListIntRegistrados[i].Id_pagointeres )));
            }
            Map<String, String> mapObjectFiles = new Map<String, String>();
            List<String> ListObjct = new List<String>();
            for(ObjectoReferenciaArchivos__c item: [Select Id, Name From ObjectoReferenciaArchivos__c Where Name in :listIds]){
                mapObjectFiles.put(item.Name, item.Id);
                ListObjct.add(item.Id);
            }
            Map<String, String> mapFiles = new Map<String, String>();
            for(ContentDocumentLink item :  [Select Id,LinkedEntityId From ContentDocumentLink Where LinkedEntityId in :ListObjct ]){
                mapFiles.put(item.LinkedEntityId, item.LinkedEntityId);
            }
            for(integer i=0; i<ListIntRegistrados.size(); i++){
                String idPagoInteres = String.valueOf(Integer.valueOf( ListIntRegistrados[i].Id_pagointeres ));
                ListIntRegistrados[i].tieneArchivoSF = mapFiles.ContainsKey(mapObjectFiles.get(idPagoInteres));
            }
            Control = ListIntRegistrados.size();
            if(Control>0){ mostrarRegistrados = true;
                         }else{
                             ApexPages.addMessage(
                                 new ApexPages.Message(
                                     ApexPages.Severity.ERROR,'NO HAY REGISTRADOS: ')); } 
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
        }
    }//
    public string CuentaAprobadoD {get;set;}
    public string IdPagoInteresesFIle {get;set;}
    public void Aprobar(){
        try{
            classAdmInteres_2 EnvioInteres = new classAdmInteres_2 ();
            
            listS = new List<classPagoInteresesRegA>();
            String cuenta;
            for(integer i=0; i<ListIntRegistrados.size(); i++){
                if(ListIntRegistrados[i].Id_pagointeres == Decimal.valueOf(ID_Referencia)){
                    classPagoInteresesRegA RA = new classPagoInteresesRegA();
                    RA = Cambio_de_clase(ListIntRegistrados[i]);
                    RA.EstadoAprobacion = 'A';
                    RA.fechadeActivacion = datetime.now();
                    CuentaAprobadoD = RA.Cuenta;
                    cuenta = RA.Cuenta;
                    listS.add(RA);
                    Bitacora(RA);
                   
                    
                }
            }
            
            EnvioInteres.ListIntAprobados = listS;
            system.debug('debug de EnvioInteres: '+ EnvioInteres);
            String resultado = controllerAPIinteresAprobados.pagaInteres(EnvioInteres);
            MuestraRegistrados();
            EnvioCorreoAprobado();
            delete([Select Id From ObjectoReferenciaArchivos__c Where Cuenta__c = :cuenta ]);
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, 'PAGO DE INTERESES APROBADO'));
        }catch(Exception e){ 
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
    }//final envioAprobacion
		
    public void EnvioCorreoAprobado(){
        string correoEmpleado;
        string NombreUsuario;
        /*string ApellidoUsuario;*/
        Usuarios_de_Pantallas__c InfoUsuario = new Usuarios_de_Pantallas__c ();
        try{
            
            classPagoInteresesFPC claseEnvio = new classPagoInteresesFPC();
        	classPagoInteresesFPC fcsd = ControllerAPIPagoIntereses.BuscarCuenta2(CuentaAprobadoD);
            
           InfoUsuario = [select Name, Apellido__c, Email__c from Usuarios_de_Pantallas__c where Usuario__c =: fcsd.usuarioregis];
			correoEmpleado = InfoUsuario.Email__c;
            NombreUsuario = InfoUsuario.Name + ' ' + InfoUsuario.Apellido__c;
            
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
						Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setHtmlBody( 'Buenas ' + NombreUsuario + ', su pago de intereses al cliente ' + fcsd.NombreCompleto + 
                                        ' ha sido APROBADO.');
                        mail.setSubject('Pago de intereses a ' + fcsd.NombreCompleto + ', APROBADO ');
                        mail.setToAddresses(new String[] {correoEmpleado});
						mail.setOrgWideEmailAddressId(owea.get(0).Id);
                        mail.setSaveAsActivity(true);
                        listCorreo.add(mail);
                        Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
    }
    public void Denegar(){
        try{
            classAdmInteres_2 EnvioInteres = new classAdmInteres_2 ();
            
            listS = new List<classPagoInteresesRegA>();
            
            for(integer i=0; i<ListIntRegistrados.size(); i++){ if(ListIntRegistrados[i].Id_pagointeres == Decimal.valueOf(ID_Referencia)){
                    classPagoInteresesRegA RA = new classPagoInteresesRegA();
                    RA = Cambio_de_clase(ListIntRegistrados[i]);
                    RA.EstadoAprobacion = 'D';
                    RA.fechadeActivacion = datetime.now();
                	CuentaAprobadoD = RA.Cuenta;
                    listS.add(RA);
                    Bitacora(RA); 
                    
                }
            }
            
            EnvioInteres.ListIntAprobados = listS;
            system.debug('debug de EnvioInteres: '+ EnvioInteres);
            String resultado = controllerAPIinteresAprobados.pagaInteres(EnvioInteres);
            MuestraRegistrados();
            EnvioCorreoDenegado();
                        
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm, 'PAGO DE INTERESES DENEGADO'));

            popDenegarSalir(); 
        }
        catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
    }//
    
    public void EnvioCorreoDenegado(){
        try{
        string correoEmpleado;
        string NombreUsuario;
        /*string ApellidoUsuario;*/
        Usuarios_de_Pantallas__c InfoUsuario = new Usuarios_de_Pantallas__c ();
        //try{
            
            classPagoInteresesFPC claseEnvio = new classPagoInteresesFPC();
        	classPagoInteresesFPC fcsd = ControllerAPIPagoIntereses.BuscarCuenta2(CuentaAprobadoD);
            
           InfoUsuario = [select Name, Apellido__c, Email__c from Usuarios_de_Pantallas__c where Usuario__c =: fcsd.usuarioregis];
			correoEmpleado = InfoUsuario.Email__c;
            NombreUsuario = InfoUsuario.Name + ' ' + InfoUsuario.Apellido__c;
            
            OrgWideEmailAddress[] owea = [select Id from OrgWideEmailAddress where Address = 'ficohsapensiones@ficohsa.com'];
						Messaging.SingleEmailMessage[] listCorreo = new List<Messaging.SingleEmailMessage>();
                        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                        mail.setHtmlBody( 'Buenas ' + NombreUsuario + ', su pago de intereses al cliente ' + fcsd.NombreCompleto + 
                                        ' ha sido DENEGADO por el siguiente motivo; ' + Motivo + '.');
                        mail.setSubject('Pago de intereses a ' + fcsd.NombreCompleto + ', DENEGADO');
                        mail.setToAddresses(new String[] {correoEmpleado});
						mail.setOrgWideEmailAddressId(owea.get(0).Id);
                        mail.setSaveAsActivity(true);
                        listCorreo.add(mail);
                        Messaging.SendEmailResult[] results = Messaging.sendEmail(listCorreo, false);
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
    }
    
    public void MostrarVentanaDenegacion(){
        DenegarVentana = true;
        Num_CodReferenciaDenegado = ID_Referencia;
        
    }
    
    public list <selectOption> ListBancos {get; set;}
    public void TiposdeBancos(){
        
        ListBancos = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Detalle_caso__c.Banco__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        map<string, string> mapisv= new map<string, string>(); 
        ListBancos.add(new selectOption('--Ninguno--', '--Ninguno--'));
        for(Schema.PicklistEntry p : ple){          
            ListBancos.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    public list <selectOption> ListFormPag {get; set;}
    public void FormPagoList(){
        
        ListFormPag = new list <selectOption>();
        Schema.DescribeFieldResult fieldResult = Detalle_caso__c.Forma_Retiro__c.getDescribe();   
        list<PicklistEntry> ple = fieldResult.getPicklistValues();   
        map<string, string> mapisv= new map<string, string>(); 
        ListFormPag.add(new selectOption('--Ninguno--', '--Ninguno--'));
        for(Schema.PicklistEntry p : ple){          
            ListFormPag.add(new selectOption(p.getValue(),p.getLabel())); 
        }
    }
    
    public void MostrarVentanaDenegacionu()
    {
        try{
        ActivaFechPago = true;
        denegarventanauno = true; 
        ActivaBanco = true;
        ActivaFormadePago= true;
        Cuentaun=Cuentas;  
        TiposdeBancos();
        FormPagoList();
        string temporal=Cuentas;
        classPagoInteresesFPC claseEnvio = new classPagoInteresesFPC();
        classPagoInteresesFPC fcsd = ControllerAPIPagoIntereses.BuscarCuenta2(Cuentas);
        NombreCompleto = fcsd.NombreCompleto;
        Identidad = fcsd.Identidad;
        TipoFondo = fcsd.TipoFondo;
        EstadoCuenta = fcsd.EstadoCuenta;
        CausaDescripcion = fcsd.CausaDescripcion;
        Codigocausa = fcsd.Codigocausa;
        Moneda = fcsd.Moneda;
        
        if(fcsd.Moneda == '01' || fcsd.Moneda == '03'){ Mostrar_Moneda = 'Lempiras';
        }else if(fcsd.Moneda == '02' || fcsd.Moneda == '04'){ Mostrar_Moneda = 'Dolares';
        }else if(fcsd.Moneda == '05'){Mostrar_Moneda = 'Euros';}else{Mostrar_Moneda = null;}
        EstadoAprobacion = fcsd.EstadoAprobacion;
        Forma_Pago = fcsd.Formadepago;
        if(fcsd.Montodepago == 'null' || fcsd.Montodepago == null){
				Monto_pago = null;            
        } else{
            Monto_pago = decimal.valueOf(fcsd.Montodepago);
        }
        //Tipo_Pago = fcsd.Tipodepago;
        Diadepagos = fcsd.Diadepago;
        Nombre_Banco = fcsd.Bancos;
        Cuenta_Banco = fcsd.NoCuenta;
        Tipo_Cuenta = fcsd.TipodeCuenta;
        pagopension=fcsd.Tipodepago;
        FechaActual=fcsd.Fec_inclusion ;
        Ajuste=fcsd.Ajuste;
        Total_Fondo=fcsd.TotalFondo;
        Fondo_pignorado=fcsd.CantidadPignorada;
        
        if (fcsd.ach == 'Si'){ cobrarach='Si';
        }else
        {
            cobrarach='No';
        }
        
        if (fcsd.cheque == 'Si' ){ cobrarcheque ='Si';
        }else{
            cobrarcheque ='No';
        }
        
        if (fcsd.tsp == 'Si'){ cobrartsp ='Si';
        }else{
            cobrartsp ='No';
        }
        
        if (fcsd.tocarcapital == 'Si' ){ tocarcapital ='Si';
        }else{
            tocarcapital ='No';
        }
        FechInicioPago = date.valueof(fcsd.FechInicioPago).addDays(1);
        }
        catch(Exception e){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));
        }
    }
    
    public void popDenegarSalir(){    
        DenegarVentana = false;
        Motivo = null;
        
    }
    
    public void popsalir(){    
        denegarventanauno = false;
        // Motivo = null;
        
    }
    
    
    public void AprobarPago(){
        try{
            classAdmInteres_2 EnvioInteres = new classAdmInteres_2 ();
            
            listS = new List<classPagoInteresesRegA>();
            List<String> listIds = new List<String>();
            for(integer i=0; i<ListIntRegistrados.size(); i++){ 
                classPagoInteresesRegA RA = new classPagoInteresesRegA();
                RA = Cambio_de_clase(ListIntRegistrados[i]);
                listIds.add(ListIntRegistrados[i].Cuenta);                                           
                RA.EstadoAprobacion = 'A';
                RA.fechadeActivacion = datetime.now();
                listS.add(RA);
                Bitacora(RA);                
            }            
            EnvioInteres.ListIntAprobados = listS;
            system.debug('debug de EnvioInteres: '+ EnvioInteres);
            String resultado = controllerAPIinteresAprobados.pagaInteres(EnvioInteres);
            
            MuestraRegistrados(); 
            delete([Select Id From ObjectoReferenciaArchivos__c Where Cuenta__c in :listIds ]);
        }catch(Exception e){ ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Errro: ' + e.getMessage()+' LINEA '+E.getLineNumber()));    
        }
    }
    
    public void Bitacora(classPagoInteresesRegA Interes){
        classBitacora bitacora = new classBitacora();
        string actividad;
        if(Interes.EstadoAprobacion == 'D'){    actividad = 'Denegación de cliente con ID: '+Interes.Id_pagointeres+', con # de cuenta '+Interes.Cuenta+', tipo de pago '+Interes.Tipodepago + ' Motivo:'+Motivo;
        }else{
            actividad = 'Aprobación de cliente con ID: '+Interes.Id_pagointeres+', para pago de interes, con # de cuenta '+Interes.Cuenta+', tipo de pago '+Interes.Tipodepago;
        }
        
        //  ,'INSERT',FECHA_INCLUSION
        bitacora.nombreCaso = actividad;//Actividad
        bitacora.numeroCaso = 'UPDATE';
        bitacora.fechaCaso = datetime.now();
        bitacora.usuarioCaso = 'Pantalla Aprobación de intereses: VF_AprobacionPagoInteres.vfp';
        bitacora.valorNuevo = Interes.EstadoAprobacion;
        bitacora.valorAnterior = Interes.Cuenta;
        bitacora.usuarioAprueba = 'SEVILLA';
        
        String resultado2 = ControllerAPIPagoIntereses.INSERTA_BITACORA(bitacora);
        system.debug('Bitacora--' + bitacora); 
        
    }
    Public String pngId {get;set;}
    public PageReference MostrarImagen(){    
        try{  
            pngId = null;
            if(IdPagoInteresesFIle != null){
                Integer p = Integer.valueOf(IdPagoInteresesFIle);
                list<String> listIdAcc = new list<String>();
                Integer count = 0;
                for(ObjectoReferenciaArchivos__c item: [Select Id From ObjectoReferenciaArchivos__c Where Name = :String.valueOf(p)]){
                    listIdAcc.add(item.Id);
                    
                }
                String nameFile;
                String IdFile;
                for(ContentDocumentLink item :  [Select Id,ContentDocumentId,ContentDocument.Title From ContentDocumentLink Where LinkedEntityId in :listIdAcc  ]){
                    count++;
                    IdFile = item.ContentDocumentId;
                    nameFile = item.ContentDocument.Title;
                    
                }
                if(count == 1 && nameFile.toUpperCase().contains('PNG')){
                    pngId = nameFile;
                }else if(count > 1){
                    return new PageReference('/'+listIdAcc[0]);
                }
            }  
            DenegarImagen = true; 
            ControllerAPIPagoIntereses.classRespuestaImagen wer =  new ControllerAPIPagoIntereses.classRespuestaImagen();
            wer = ControllerAPIPagoIntereses.TraerImagenBD(ID_Referencia); 
            Ver_Imagen = wer.imagen;
            system.debug('Imagen ' + Ver_Imagen);
        } catch(exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber()+' ---- '+IdPagoInteresesFIle);
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!'+ e.getMessage() + ' Linea: ' + e.getLineNumber()));
        }      
        return null;
    } 
    public void popSalirImagen(){DenegarImagen = false;}
    public classPagoInteresesRegA Cambio_de_clase(classPagoInteresesReg ListIntRegistrado){
        classPagoInteresesRegA RA = new classPagoInteresesRegA();
        RA.Ajuste = ListIntRegistrado.Ajuste;
        RA.Bancos = ListIntRegistrado.Bancos;
        RA.CantidadPignorada = ListIntRegistrado.CantidadPignorada;
        RA.CausaDescripcion = ListIntRegistrado.CausaDescripcion;
        RA.Cod_Causa = ListIntRegistrado.Cod_Causa;
        RA.Cuenta = ListIntRegistrado.Cuenta;
        RA.Diadepago = ListIntRegistrado.Diadepago;
        RA.EstadoAprobacion = ListIntRegistrado.EstadoAprobacion;
        RA.EstadoCuenta = ListIntRegistrado.EstadoCuenta;
        RA.fechadeActivacion = ListIntRegistrado.fechadeActivacion;
        RA.fechadeRegistro = ListIntRegistrado.fechadeRegistro;
        RA.fechaHasta = ListIntRegistrado.fechaHasta;
        RA.Formadepago = ListIntRegistrado.Formadepago;
        RA.Id_pagointeres = ListIntRegistrado.Id_pagointeres;
        RA.Identidad = ListIntRegistrado.Identidad;
        RA.LEE_ERRORES = ListIntRegistrado.LEE_ERRORES;
        RA.Moneda = ListIntRegistrado.Moneda;
        RA.Montodepago = ListIntRegistrado.Montodepago;
        RA.NoCuenta = ListIntRegistrado.NoCuenta;
        RA.NombreCompleto = ListIntRegistrado.NombreCompleto;
        RA.P_ERROR = ListIntRegistrado.P_ERROR;
        RA.TipodeCuenta = ListIntRegistrado.TipodeCuenta;
        RA.Tipodepago = ListIntRegistrado.Tipodepago;
        RA.TipoFondo = ListIntRegistrado.TipoFondo;
        RA.TotalFondo = ListIntRegistrado.TotalFondo;
        
        
        return RA;
    }
    
    public Pago_Interes__c Cambio_de_clase_Objeto(classPagoInteresesReg ListIntRegistrado){
        Pago_Interes__c pi = new Pago_Interes__c();
        
        pi.Ajuste__c = ListIntRegistrado.Ajuste;
        pi.Banco__c = ListIntRegistrado.Bancos;
        pi.CantidadPignorada__c = ListIntRegistrado.CantidadPignorada;
        pi.CausaDescripcion__c = ListIntRegistrado.CausaDescripcion;
        //pi.Cod_Causa__c = ListIntRegistrados.Cod_Causa;
        pi.Cuenta__c = ListIntRegistrado.Cuenta;
        pi.Diadepago__c = ListIntRegistrado.Diadepago;
        pi.EstadoAprobacion__c = ListIntRegistrado.EstadoAprobacion;
        pi.EstadoCuenta__c = ListIntRegistrado.EstadoCuenta;
        pi.Fecha_Modificacion__c = ListIntRegistrado.fechadeActivacion;
        pi.fechadeRegistro__c = ListIntRegistrado.fechadeRegistro;
        //pi.fe = ListIntRegistrados.fechaHasta;
        pi.Formadepago__c = ListIntRegistrado.Formadepago;
        pi.Id_pagointeres__c = string.valueOf(ListIntRegistrado.Id_pagointeres);
        pi.Identidad__c = ListIntRegistrado.Identidad;
        //pi.LEE_ERRORES__c = ListIntRegistrados.LEE_ERRORES;
        pi.Moneda__c = ListIntRegistrado.Moneda;
        pi.Montodepago__c = ListIntRegistrado.Montodepago;
        pi.NoCuenta__c = ListIntRegistrado.NoCuenta;
        pi.NombreCompleto__c = ListIntRegistrado.NombreCompleto;
        //pi.P_ERROR__c = ListIntRegistrados.P_ERROR;
        pi.TipodeCuenta__c = ListIntRegistrado.TipodeCuenta;
        pi.Tipodepago__c = ListIntRegistrado.Tipodepago;
        pi.TipoFondo__c = ListIntRegistrado.TipoFondo;
        pi.TotalFondo__c = ListIntRegistrado.TotalFondo;
        
        
        return pi;
    }
    
}