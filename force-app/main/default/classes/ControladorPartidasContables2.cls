global class ControladorPartidasContables2 {

    //Listas para el envio de Emails
    public list<string> aseso = new list<string>();
    public list<string> mon = new list<string>();
    public list<string> fech = new list<string>();
    public list<string> descrip = new list<string>();
    public list<string> descripnot = new list<string>();
    public list<string> refer = new list<string>();
    public list<string> mont = new list<string>();
    public list<string> agnb = new list<string>();
        
    public List<clientes> ListRezagos {get;set;}
    public clientes clienteUnico{get;set;}
    public static list<Rezago__c> Rezlist{get;set;}
    public static list<Rezago__c> Rezlist2{get;set;}
    
    public list<clientes> Recibe{get;set;}
    public boolean MostrarGuardar{get;set;}
    public string Codigo_Unico_Banco{get;set;}
    public string mensaje{get;set;}
    public string tipoMoneda{get;set;}  
    public string usuario;
    
    public static boolean showError {get;set;}
    public static String styleDiv {get;set;}
    public static String styleMessage {get;set;}
    
    public String resultJson {get;set;}

    public ControladorPartidasContables2(){
        Codigo_Unico_Banco = ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
        usuario = ApexPages.currentPage().getParameters().get('loetdncdhjch');
        tipoMoneda = ApexPages.currentPage().getParameters().get('Moneda');
        MostrarGuardar = true;
        showError = false; styleDiv = 'display:none;'; styleMessage = 'display:none;';
    }
    
    @RemoteAction
    global static list<Rezago__c> SUbirInformacion(String stringCSV){
        try{
                List<Rezago__c> SobjLst = [select id from Rezago__c];
                        delete SobjLst;
            stringCSV.replace('\'', '');
            stringCSV.replace('´', '');
            list<string> clientes = new  list<string>();
            list<string> clientes2= new  list<string>();
            clientes = stringCSV.split('\n');
            System.debug(clientes[0]);//Muestra el contenido del archivo excel la fila 0
            
            integer A=15;
            integer B=15;
            integer C=15;
            integer D=15;
            integer E=15;
            integer F=15;
            integer G=15;
            integer H=15;
            integer I=15;
            integer J=15;
            
            string lk=clientes[0];
            clientes2=lk.split(',');
            clientes.remove(0);
            
            //FOR - Identificacion de la columna correspondiente - START
            for(integer count=0; count<clientes2.size(); count++){
                list<string> hy = new list<string> ();
                hy = clientes2[count].split('"');
                clientes2[count] = hy[1].Trim();
                
                if(clientes2[count].toUpperCase()=='FONDO'){
                    A=count;
                }
                if(clientes2[count].toUpperCase()=='FECHA'){
                    B=count;
                }
                if(clientes2[count].toUpperCase()=='DESCRIPCION'){
                    C=count;
                }
                if(clientes2[count].toUpperCase()=='DESCRIPCION_NOTA'){
                    D=count;
                }
                if(clientes2[count].toUpperCase()=='N°_DOC.'){
                    E=count;
                }
                if(clientes2[count].toUpperCase()=='MONEDA'){
                    F=count;
                }
                if(clientes2[count].toUpperCase()=='MONTO'){
                    G=count;
                }
                if(clientes2[count].toUpperCase()=='CODIGO'){
                    H=count;
                }
                if(clientes2[count].toUpperCase()=='DESCRIPCION_DEBITO'){
                    I=count;
                }
                if(clientes2[count].toUpperCase()=='DESCRIPCION_CREDITO'){
                    J=count;
                }
            }
            //FOR Identificacion de la columna correspondiente END
            //            
            if(A!=15 && B!=15 && C!=15 && D!=15 && E!=15 && F!=15 && G!=15 && H!=15 && I!=15 && J!=15){
                //Creo listas donde se guardaran los valores individualmente
                list<string> fondo = new  list<string>();
                list<datetime> fdeposito = new  list<datetime>();
                list<string> descripcion = new  list<string>();
                list<string> descnota = new  list<string>();
                list<string> nDoc = new  list<string>();                
                list<string> moneda = new  list<string>();
                list<string> monto = new  list<string>();//Para mostrar en la VF
                list<string> monto2 = new  list<string>();//Para guardar en el Objeto
                list<string> codigo = new  list<string>();
                list<string> descripcionDebito = new  list<string>();
                list<string> descripcionCredito = new  list<string>();               
                
                for (integer count=0; count<clientes.size(); count++){//Recorro la lista completa de datos
                    clientes2 = new list<string>();
                    
                    string jh=clientes[count];//Guarda la lista de valores en esta variable
                                        //System.debug('1:'+clientes[count]);//Muestra el contenido del archivo excel la fila 0                    
                    if(jh.contains(',,') && jh.trim().length()>20){
                        clientes[count] = clientes[count].replace(',,',',"",').Trim(); 
                    }else{
                        clientes[count] = clientes[count].replace(',,','').Trim();  
                    }
                    //System.debug(clientes[count]);//Muestra el contenido del archivo excel la fila 0
                    if(clientes[count].length()>30){
                        //Le quito la coma y espacios a los montos
                        string kike = clientes[count];
                        string kike1 = kike.substringAfter('" ');    
                        string kike2 = kike.substringBefore('" ');
                        string kike3 = kike1.substringBefore('"');
                        kike3 = kike3.replace(' ','');
                        String montostr = kike3;
                        kike3 = kike3.replace(',','');
                        kike1 = kike.substringAfter(' "');
                        kike = kike2+kike3+kike1;
                        clientes2 = kike.split(',');
                        
                                                System.debug('clientes2: '+clientes2);  
                                                System.debug('clientes2[A]: '+clientes2[A]);                         
                        if(A<clientes2.size() && B<clientes2.size() && C<clientes2.size() && D<clientes2.size() && E<clientes2.size() 
                           && F<clientes2.size() && G<clientes2.size() && H<clientes2.size() && I<clientes2.size() && J<clientes2.size()){
                            if(A!=15 && clientes2[A]!='') {
                                fondo.add('"'+clientes2[A]+'"');
                                system.debug('Paso A: '+clientes2[A]);                                
                            } /*else if(clientes2[A]=='') {
                                system.debug('Error Fondo');  
                                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Error Fondo'));
                                break;
                            }*/
                            if(B!=15 && clientes2[B]!=''){
                                string dateform = clientes2[B].substringAfter('"');
                                dateform = dateform.substringBefore('"');
                                string datemonth = dateform.substringBefore('/');
                                string dateday = dateform.substringBetween('/');
                                string dateyear = dateform.substringAfterLast('/');
                                string datecomplete = '20'+dateyear+'-'+datemonth+'-'+dateday+' 00:00:00';
                                DateTime DTime = DateTime.valueOf(datecomplete);
                                fdeposito.add(DTime);//Agrego la Fecha del Deposito
                                system.debug('Paso B: '+DTime);
                            } /*else if(clientes2[B]=='') {
                                system.debug('Error Fecha');  
                                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'Error Fecha'));
                                break;
                            }*/
                            if(C!=15 && clientes2[C]!=''){
                                descripcion.add(clientes2[C]);// Agrego la Descripcion
                                system.debug('Paso C: '+clientes2[C]);
                            }
                            if(D!=15 && clientes2[D]!=''){
                                descnota.add(clientes2[D]);//Agrego la Descripcion nota
                                system.debug('Paso D: '+clientes2[D]);
                            }
                            if(E!=15 && clientes2[E]!=''){
                                nDoc.add(clientes2[E]);//Agrego el N° Doc.
                                system.debug('Paso E: '+clientes2[E]);
                            }                           
                            if(F!=15 && clientes2[F]!=''){
                                moneda.add(clientes2[F]);//Agrego la Moneda
                                system.debug('Paso F: '+clientes2[F]);
                            } /*else if(clientes2[F]=='') {
                                system.debug('Error Moneda');  
                                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'Error Moneda'));
                                break;
                            }*/
                            if(G!=15 && clientes2[G]!=''){
                                /*if(clientes2[F]=='"USD"'){monto.add('$ '+montostr);}
                                if(clientes2[F]=='"HNL"'){monto.add('L '+montostr);}
                                string mn = montostr.replace(',','');
                                monto2.add(mn);*/
                                //Agrego el Monto del Deposito
                                //system.debug('monto2: '+monto2[G]);
                                monto.add(clientes2[G]);
                                system.debug('Paso G: '+clientes2[G]);
                            } /*else if(clientes2[G]=='') {
                                system.debug('Error Monto');  
                                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'Error Monto'));
                                break;
                            }*/
                            if(H!=15 && clientes2[H]!=''){
                                codigo.add(clientes2[H]);//Agrego el Código
                                system.debug('Paso H: '+clientes2[H]);
                            } /*else if(clientes2[H]=='""') {
                                system.debug('Error Código');  
                                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'Error Código'));
                                break;
                            }*/
                            if(I!=15 && clientes2[I]!=''){
                                descripcionDebito.add(clientes2[I]);//Agrego la Descripción Débito
                                system.debug('Paso I: '+clientes2[I]);
                            } /*else if(clientes2[I]=='') {
                                system.debug('Error Descripción Débito');  
                                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'Error Descripción Débito'));
                                break;
                            }*/
                            if(J!=15 && clientes2[J]!=''){
                                descripcionCredito.add(clientes2[J]);//Agrego la Descripción Crédito
                                system.debug('Paso J: '+clientes2[J]);
                            } /*else if(clientes2[I]=='') {
                                system.debug('Error Descripción Crédito');  
                                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'Error Descripción Crédito'));
                                break;
                            }*/
                        } 
                    }   
                }
                Rezlist = new list<Rezago__c>();
                Rezago__c listR;
                Rezlist2 = new list<Rezago__c>();
                Rezago__c listR2;
                for (integer count=0; count<fondo.size(); count++){
                    //Guarda para Mostrar
                    listR = new Rezago__c();
                    listR.Fondo__c = fondo[count].replace('"','');
                    listR.Fecha_del_deposito__c = fdeposito[count];
                    listR.Descripcion__c = descripcion[count].replace('"','');
                    listR.Descripcion_Nota__c = descnota[count].replace('"','');
                    listR.N_Doc__c = nDoc[count].replace('"','');                  
                    listR.Moneda_del_deposito__c = moneda[count].replace('"','');
                    listR.Moneda_del_deposito__c = moneda[count].replace('"','');
                    listR.Monto_del_deposito__c = monto[count].replace('"','');
                    listR.Codigo__c = codigo[count].replace('"','');
                    listR.Descripcion_Debito__c = descripcionDebito[count].replace('"','');
                    listR.Descripcion_Credito__c = descripcionCredito[count].replace('"','');
                    
                    listR.Referencia__c = '123';
                    listR.Banco__c = 'Banco Ficohsa';
                    listR.Asesor_Rezago__c = 'HN001';
                    
                    Rezlist.add(listR);
                   
                    //Guarda en el Objeto Temporal
                    listR2 = new Rezago__c();
                    listR2.Fondo__c = fondo[count];
                    listR2.Fecha_del_deposito__c = fdeposito[count];
                    listR2.Descripcion__c = descripcion[count];
                    listR2.Descripcion_Nota__c = descnota[count]; 
                    listR2.N_Doc__c = nDoc[count];                  
                    listR2.Moneda_del_deposito__c = moneda[count];
                    listR2.Monto_del_deposito__c = monto[count];
                    listR2.Codigo__c = codigo[count];
                    listR2.Descripcion_Debito__c = descripcionDebito[count];
                    listR2.Descripcion_Credito__c = descripcionCredito[count];  
                    
                    listR2.Referencia__c = '123';
                    listR2.Banco__c = 'Banco Ficohsa';
                    listR2.Asesor_Rezago__c = 'HN001';
                                     
                    Rezlist2.add(listR2);
                }
            }            
        }catch(exception ex){
            system.debug('Error: '+ ex.getMessage() + ' - ' + ex.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Contacte a su Administrador. ' + ex.getMessage() + ' - ' + ex.getLineNumber() ));
        }
        insert Rezlist2;
        //System.debug('Rezlist2: '+Rezlist2);
        return Rezlist;
    }
    public pageReference Guardar(){
        try{
            List<Rezago__c> resultado = new List<Rezago__c>();
            resultado = [select id,Fondo__c,Codigo__c,Banco__c,Cuenta_Debito__c,Cuenta_Credito__c,Modulo__c,Tipo_Transaccion__c,Sub_Aplicacion__c,Tipo_Nota__c,
                         Monto_del_deposito__c,Moneda_del_deposito__c,Descripcion_Debito__c,Descripcion_Credito__c,
                         Fecha_del_deposito__c from Rezago__c];
            system.debug('Resultado: '+resultado[0]);
            List<Partida_contable__mdt> partidas = [Select id,Fondo__c,Codigo__c,Id_Banco_Debito__c,Id_Banco_Credito__c,Moneda__c,Cuenta_Debito__c,Cuenta_Credito__c,Modulo__c,Tipo_Nota__c,Tipo_Transaccion__c,Sub_Aplicacion__c From Partida_contable__mdt];
            system.debug('Partidas: '+partidas.size());
            List<Rezago__c> Updateres = new List<Rezago__c>();
            
            FieldsPartidadContables clase = new FieldsPartidadContables();           
            FieldsPartidadContables.Partida envioDatos = new FieldsPartidadContables.Partida();
            clase.partidas = new List<FieldsPartidadContables.Partida>();
                                          
            for(Rezago__c res : resultado) {
                //System.debug('Fondo: '+res.Fondo__c);
                for(Integer i=0;i<partidas.size();i++) {
                    if(res.Fondo__c == '"'+partidas[i].Fondo__c+'"' && res.Codigo__c == '"'+partidas[i].Codigo__c+'"' && res.Moneda_del_deposito__c == '"'+partidas[i].Moneda__c+'"') {
                        res.Fondo__c = res.Fondo__c.replace( '"' , '' );
                        res.Codigo__c = res.Codigo__c.replace( '"' , '' );
                        res.Descripcion_Debito__c = res.Descripcion_Debito__c.replace( '"' , '' );
                        res.Descripcion_Credito__c = res.Descripcion_Credito__c.replace( '"' , '' );
                        if(res.Moneda_del_deposito__c == '"HNL"') {res.Moneda_del_deposito__c = '1';}
                        if(res.Moneda_del_deposito__c == '"USD"') {res.Moneda_del_deposito__c = '2';} 
                                               
                        if(partidas[i].Tipo_Nota__c == 'Nota debito') {partidas[i].Tipo_Nota__c = 'D'; partidas[i].Id_Banco_Debito__c = partidas[i].Id_Banco_Credito__c; partidas[i].Cuenta_Credito__c = Null;} 
                        else if(partidas[i].Tipo_Nota__c == 'Nota credito' || partidas[i].Tipo_Nota__c == 'Deposito') {
                            partidas[i].Tipo_Nota__c = 'C'; 
                            if(partidas[i].Tipo_Nota__c == 'Bancos') {
                                partidas[i].Cuenta_Debito__c = Null;
                            }    
                        } 
                        else if(partidas[i].Tipo_Nota__c == '' || partidas[i].Tipo_Nota__c == Null) {partidas[i].Id_Banco_Debito__c = Null;} 
                        
                        if(partidas[i].Modulo__c == 'BANCOS') {partidas[i].Modulo__c = 'BCO';} 
                        if(partidas[i].Modulo__c == 'CONTABILIDAD') {partidas[i].Modulo__c = 'CTA';} 
                        res.Cuenta_Debito__c = partidas[i].Cuenta_Debito__c;
                        res.Cuenta_Credito__c = partidas[i].Cuenta_Credito__c;
                        res.Modulo__c = partidas[i].Modulo__c;
                        res.Tipo_Transaccion__c = partidas[i].Tipo_Transaccion__c;
                        res.Sub_Aplicacion__c = partidas[i].Sub_Aplicacion__c;
                        res.Banco__c = partidas[i].Id_Banco_Debito__c;
                        res.Tipo_Nota__c = partidas[i].Tipo_Nota__c;
                                                                     
                        Updateres.add(res);                       
                    }                 
                }
            }
            
            for(Rezago__c res2 : Updateres){
                envioDatos = new FieldsPartidadContables.Partida();
                for(Integer i=0;i<partidas.size();i++) {
                    if(res2.Modulo__c == 'BCO' && res2.Tipo_Nota__c != 'Transferencias entre cuentas' && res2.Fondo__c == partidas[i].Fondo__c && res2.Codigo__c == partidas[i].Codigo__c) {
                        res2.Cuenta_Credito__c = Null;    
                    }
                    if(res2.Tipo_Nota__c == 'Transferencias entre cuentas' && res2.Fondo__c == partidas[i].Fondo__c && res2.Codigo__c == partidas[i].Codigo__c) {
                        res2.Tipo_Nota__c = 'D';
                        res2.Banco__c = partidas[i].Id_Banco_Debito__c;
                        res2.Cuenta_Debito__c = partidas[i].Cuenta_Credito__c;
                        res2.Cuenta_Credito__c = partidas[i].Id_Banco_Credito__c;
                        System.debug(res2); 
                        System.debug(res2.Fondo__c + ','+ res2.Codigo__c + ',0' + res2.Moneda_del_deposito__c);
                        //update res2;
                    } 
                    if(res2.Tipo_Nota__c == 'C' && res2.Fondo__c == partidas[i].Fondo__c && res2.Codigo__c == partidas[i].Codigo__c) {
                        res2.Cuenta_Debito__c = partidas[i].Cuenta_Credito__c;
                        res2.Cuenta_Credito__c = Null;
                    }
                }
                System.debug('Todos: '+res2);
                //Clase con todos los campos
                envioDatos.Id_banco = res2.Banco__c;
                envioDatos.Monto = res2.Monto_del_deposito__c;
                envioDatos.cta_contable_debito = res2.Cuenta_Debito__c;
                envioDatos.cta_contable_credito = res2.Cuenta_Credito__c;
                envioDatos.moneda = res2.Moneda_del_deposito__c;
                envioDatos.Modulo = res2.Modulo__c;
                envioDatos.tip_nota = res2.Tipo_Nota__c;
                envioDatos.observacion = res2.Descripcion_Debito__c;
                envioDatos.observacion_c = res2.Descripcion_Credito__c;
                envioDatos.tip_transac = res2.Tipo_Transaccion__c;
                envioDatos.sub_aplicacion = res2.Sub_Aplicacion__c;
                envioDatos.fecha = res2.Fecha_del_deposito__c;
                      
                clase.partidas.Add(envioDatos);
            }
                        
            System.debug('envioDatos: '+clase);
                                            
            /*String envio = Json.serialize(clase);
            System.debug('envio: '+envio);
                         
            controllerApiIntergationPartidas.calloutGenerarPartidas(envio);*/
            
            String resultJson = controllerApiIntergationPartidas.generarPartidas(clase);
            System.debug('resultJson: '+resultJson);
            
            if(resultJson.contains('OK')) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Partidas contables creadas correctamente.'));
                styleMessage = 'display:flex;'; 
            } else if(resultJson.contains('Read timed out')){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error de conexión a la base de datos: "Read timed out".'));  
                styleMessage = 'display:flex;'; 
            } else {    
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Se produjo un error en el Servicio Web.'));  
                styleMessage = 'display:flex;';     
            }
        }catch(exception ex){
            system.debug(ex.getLineNumber());
            system.debug(ex);
        }
        return null;
    }  
}