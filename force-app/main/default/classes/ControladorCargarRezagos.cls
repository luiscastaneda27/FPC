global class ControladorCargarRezagos {

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

    public ControladorCargarRezagos(){
        Codigo_Unico_Banco = ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
        usuario = ApexPages.currentPage().getParameters().get('loetdncdhjch');
        tipoMoneda = ApexPages.currentPage().getParameters().get('Moneda');
        MostrarGuardar = true;
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
                if(clientes2[count].toUpperCase()=='REFERENCIA'){
                    B=count;
                }
                if(clientes2[count].toUpperCase()=='FECHA DEL DEPOSITO'){
                    C=count;
                }
                if(clientes2[count].toUpperCase()=='MONEDA DEL DEPOSITO'){
                    D=count;
                }
                if(clientes2[count].toUpperCase()=='MONTO DEL DEPOSITO'){
                    E=count;
                }
                if(clientes2[count].toUpperCase()=='DESCRIPCION'){
                    F=count;
                }
                if(clientes2[count].toUpperCase()=='DESCRIPCION NOTA'){
                    G=count;
                }
                if(clientes2[count].toUpperCase()=='BANCO'){
                    H=count;
                }
                if(clientes2[count].toUpperCase()=='AGENCIA ORIGEN'){
                    I=count;
                }
                if(clientes2[count].toUpperCase()=='ASESOR'){
                    J=count;
                }
            }
            //FOR Identificacion de la columna correspondiente END
            //            
            if(A!=15 && B!=15 && C!=15 && D!=15 && E!=15 && F!=15 && G!=15 && H!=15 && I!=15 && J!=15){
                //Creo listas donde se guardaran los valores individualmente
                list<string> fondo = new  list<string>();
                list<string> referencia = new  list<string>();
                list<datetime> fdeposito = new  list<datetime>();
                list<string> moneda = new  list<string>();
                list<string> monto = new  list<string>();//Para mostrar en la VF
                list<string> monto2 = new  list<string>();//Para guardar en el Objeto
                list<string> descripcion = new  list<string>();
                list<string> descnota = new  list<string>();
                list<string> banco = new  list<string>();//Para mostrar en la VF
                list<string> banco2 = new  list<string>();//Para guardar en el Objeto
                list<string> aorigen = new  list<string>();
                list<string> asesor = new  list<string>();//Para mostrar en la VF
                list<string> asesor2 = new  list<string>();//Para guardar en el Objeto
                
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
                                                
                        if(A<clientes2.size() && B<clientes2.size() && C<clientes2.size() && D<clientes2.size() && E<clientes2.size() 
                           && F<clientes2.size() && G<clientes2.size() && H<clientes2.size() && I<clientes2.size() && J<clientes2.size()){
                            if(A!=15 && clientes2[A]!=''){
                                fondo.add('"'+clientes2[A]+'"');
                                system.debug('Paso A: '+clientes2[A]);
                            }
                            if(B!=15 && clientes2[B]!=''){
                                referencia.add(clientes2[B]);//Agrego el Codigo de Referencia
                                system.debug('Paso B: '+clientes2[B]);
                            }
                            if(C!=15 && clientes2[C]!=''){
                                string dateform = clientes2[C].substringAfter('"');
                                dateform = dateform.substringBefore('"');
                                string datemonth = dateform.substringBefore('/');
                                string dateday = dateform.substringBetween('/');
                                string dateyear = dateform.substringAfterLast('/');
                                string datecomplete = '20'+dateyear+'-'+datemonth+'-'+dateday+' 00:00:00';
                                DateTime DTime = DateTime.valueOf(datecomplete);
                                fdeposito.add(DTime);//Agrego la Fecha del Deposito
                                system.debug('Paso C: '+DTime);
                            }
                            if(D!=15 && clientes2[D]!=''){
                                moneda.add(clientes2[D]);//Agrego la Moneda
                                system.debug('Paso D: '+clientes2[D]);
                            }
                            if(E!=15 && clientes2[E]!=''){
                                /*string mont = clientes2[E];
                                mont = mont.replace(' ','');
                                decimal mo = decimal.valueOf(mont);*/
                                if(clientes2[D]=='"USD"'){monto.add('$ '+montostr);}
                                if(clientes2[D]=='"HNL"'){monto.add('L '+montostr);}
                                string mn = montostr.replace(',','');
                                monto2.add(mn);
                                //Agrego el Monto del Deposito
                                system.debug('Paso E: '+montostr);
                            }
                            if(F!=15 && clientes2[F]!=''){
                                descripcion.add(clientes2[F]);// Agrego la Descripcion
                                system.debug('Paso F: '+clientes2[F]);
                            }
                            if(G!=15 && clientes2[G]!=''){
                                descnota.add(clientes2[G]);//Agrego la Descripcion nota
                                system.debug('Paso G: '+clientes2[G]);
                            }
                            if(H!=15 && clientes2[H]!=''){
                                banco2.add(clientes2[H]);
                                string bancostr = clientes2[H].replace('"','');
                                string banca='';
                                Schema.DescribeFieldResult fieldResult = Cuentas__c.Banco__c.getDescribe();
                                List<Schema.PicklistEntry> values = fieldResult.getPicklistValues();
                                for( Schema.PicklistEntry v : values) {
                                    if(v.getValue()==bancostr){banca = v.getLabel();}
                                }
                                banco.add('"'+banca+'"');//Agrego el Banco
                                system.debug('Paso H: '+banca);
                            }
                            if(I!=15 && clientes2[I]!=''){
                                aorigen.add(clientes2[I]);//Agrego la Agencia Origen
                                system.debug('Paso I: '+clientes2[I]);
                            }
                            if(J!=15 && clientes2[J]!=''){
                                asesor2.add(clientes2[J]);
                                string asesorstr = clientes2[J].replace('"','');
                                string asesorstr2='';
                                if(asesorstr!='TODOS'){
                                    Schema.DescribeFieldResult fieldResult = Account.Asesor__c.getDescribe();
                                    List<Schema.PicklistEntry> values = fieldResult.getPicklistValues();
                                    for( Schema.PicklistEntry v : values) {
                                        if(v.getValue() == asesorstr){asesorstr2 = v.getLabel();}
                                    }
                                }else{asesorstr2 = 'TODOS';}
                                asesor.add('"'+asesorstr2+'"');//Agrego el Asesor
                                system.debug('Paso J: '+asesorstr2);
                            }
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
                    listR.Referencia__c = referencia[count].replace('"','');
                    listR.Fecha_del_deposito__c = fdeposito[count];
                    listR.Moneda_del_deposito__c = moneda[count].replace('"','');
                    listR.Monto_del_deposito__c = monto[count].replace('"','');
                    listR.Descripcion__c = descripcion[count].replace('"','');
                    listR.Descripcion_Nota__c = descnota[count].replace('"','');
                    listR.Banco__c = banco[count].replace('"','');
                    listR.Agencia_Origen__c = aorigen[count].replace('"','');
                    listR.Asesor_Rezago__c = asesor[count].replace('"','');
                    Rezlist.add(listR);
                   
                    //Guarda en el Objeto Temporal
                    listR2 = new Rezago__c();
                    listR2.Fondo__c = fondo[count];
                    listR2.Referencia__c = referencia[count];
                    listR2.Fecha_del_deposito__c = fdeposito[count];
                    listR2.Moneda_del_deposito__c = moneda[count];
                    listR2.Monto_del_deposito__c = monto2[count];
                    listR2.Descripcion__c = descripcion[count];
                    listR2.Descripcion_Nota__c = descnota[count];
                    listR2.Banco__c = banco2[count];
                    listR2.Agencia_Origen__c = aorigen[count];
                    listR2.Asesor_Rezago__c = asesor2[count];
                    
                    Rezlist2.add(listR2);
                }
            }            
        }catch(exception ex){
            system.debug(ex.getLineNumber());
            system.debug(ex);
        }
        insert Rezlist2;
        return Rezlist;
    }
    public pageReference Guardar(){
        system.debug('entramos HURRA!');
        try{
            List<Rezago__c> resuelto = new List<Rezago__c>();
                resuelto = [select id,Fondo__c,Referencia__c,Fecha_del_deposito__c,Moneda_del_deposito__c,Monto_del_deposito__c,Descripcion__c,
                        Descripcion_Nota__c, Banco__c,Agencia_Origen__c,Asesor_Rezago__c from Rezago__c];
            system.debug('Por fin tengo los datos: '+resuelto[0]);
            
            /*list<Rezagos> Complete = new list<Rezagos>();
            Rezagos listRez =  new Rezagos();*/
            ListRezagos = new List<clientes>();
            clienteUnico = new clientes(/*null,*/null,'','',null,'','','','','','','','','');

            for(integer count=0; count<resuelto.size(); count++){
                
                //El Id se generara automaticamente ne la base de datos
                /*System.debug('Sumo el idRezago: '+ resuelto[count].Id);
                clienteUnico.idRezago = resuelto[count].Id;*/
                
                System.debug('Sumo el fondo: '+ resuelto[count].Fondo__c);
                clienteUnico.fondo = resuelto[count].Fondo__c.replace('"','');
                
                System.debug('Sumo el codReferencia: '+ resuelto[count].Referencia__c);
                string r = resuelto[count].Referencia__c.replace('"','');
                clienteUnico.codReferencia = resuelto[count].Referencia__c.replace('"','');
                refer.add(r);
                
                System.debug('Sumo la fechaDeposito: '+ resuelto[count].Fecha_del_deposito__c);
                string f = resuelto[count].Fecha_del_deposito__c.format('dd/MM/yyyy');
                clienteUnico.fechaDeposito = resuelto[count].Fecha_del_deposito__c;
                fech.add(f);
                
                System.debug('Sumo el codigoMoneda: '+ resuelto[count].Moneda_del_deposito__c);
                string m = resuelto[count].Moneda_del_deposito__c.replace('"','');
                clienteUnico.codigoMoneda = m;
                mon.add(m);
                
                System.debug('Sumo el montoRezago: '+ resuelto[count].Monto_del_deposito__c);
                string mo = resuelto[count].Monto_del_deposito__c;
                clienteUnico.montoRezago = resuelto[count].Monto_del_deposito__c;
                mont.add(mo);
                
                System.debug('Sumo la descripcion: '+ resuelto[count].Descripcion__c);
                string de;
                if(resuelto[count].Descripcion__c=='""'){
                    clienteUnico.descripcion = '';
                    de='';
                }else{
                        clienteUnico.descripcion = resuelto[count].Descripcion__c.replace('"','');
                    de = resuelto[count].Descripcion__c.replace('"','');
                }
                descrip.add(de);
                
                System.debug('Sumo la descripcionNota: '+ resuelto[count].Descripcion_Nota__c);
                string desn;
                if(resuelto[count].Descripcion_Nota__c=='""'){
                    clienteUnico.descripcionNota = '';
                    desn = '';
                }else{
                    clienteUnico.descripcionNota = resuelto[count].Descripcion_Nota__c;
                    desn = resuelto[count].Descripcion_Nota__c.replace('"','');
                }
                descripnot.add(desn);
                
                System.debug('Sumo el codBanco: '+ resuelto[count].Banco__c);
                clienteUnico.codBanco = resuelto[count].Banco__c;
                
                System.debug('Sumo la agnBanco: '+ resuelto[count].Agencia_Origen__c);
                string ag;
                if(resuelto[count].Agencia_Origen__c=='""'){
                    clienteUnico.agnBanco = '';
                    ag = '';
                }else{
                        clienteUnico.agnBanco = resuelto[count].Agencia_Origen__c;
                    ag = resuelto[count].Agencia_Origen__c.replace('"','');
                }
                agnb.add(ag);
                
                System.debug('Sumo el rezagoSINO: Nada');
                clienteUnico.rezagoSINO = '';
                
                System.debug('Sumo el asesor: '+ resuelto[count].Asesor_Rezago__c);
                String a = resuelto[count].Asesor_Rezago__c.replace('"','');
                clienteUnico.asesor = resuelto[count].Asesor_Rezago__c.replace('"','');
                aseso.add(a);
                
                System.debug('Sumo el estado: Pendiente');
                clienteUnico.estado = 'PENDIENTE';
                
                System.debug('Sumo el incluidoPor: '+usuario);
                if(usuario==null){usuario='System';}
                clienteUnico.incluidoPor = usuario;
                
                ListRezagos.add(clienteUnico);
            }
            system.debug('Por fin tengo los datos Complete: '+ListRezagos);
            Rezagos rezagoEnvio = new Rezagos();
            rezagoEnvio.ListRezagos = ListRezagos;
            string resultado = ControllerApiRezagos.guardarRezago(rezagoEnvio);
            
            ClassConsultaRezago ConRez = new ClassConsultaRezago();
            ConRez.numTransaccion = '';
            
            if(resultado == '"OK"'){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Datos Guardados Exitosamente'));
                SendMails();//Ejecuto el envio de emails
            }else{
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Error al Guardar los datos '+resultado));
            }
        }catch(exception ex){
            system.debug(ex.getLineNumber());
            system.debug(ex);
        }
        return null;
    }
    
    public void SendMails(){
        try{
            for(integer count=0;count<aseso.size();count++){
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                
                String asesorstr2='';
                Schema.DescribeFieldResult fieldResult = Account.Asesor__c.getDescribe();
                List<Schema.PicklistEntry> values = fieldResult.getPicklistValues();
                List<String> mail = new List<String>();
                if(aseso[count]!='TODOS'){    
                    for( Schema.PicklistEntry v : values) {
                        if(v.getValue() == aseso[count]){
                            string asesorstr = v.getLabel();
                            User[] usr = [Select email from user where name =: asesorstr Limit 1];
                            User us = usr[0];
                            system.debug('Cargo Mail Individual: '+us.email);
                            //mail.add(us.email);
                        }
                    }
                }else{
                    /*for( Schema.PicklistEntry v : values) {
                        string asesorstr = v.getLabel();
                        system.debug('Nombre del Asesor: '+ asesorstr);
                        User[] usr = [Select email from user where name =: asesorstr Limit 1];
                        User us = usr[0];
                        system.debug('Cargo Mail TODOS: '+ us.email);
                        //mail.add(us.email);
                    }*/
                }
                mail.add('marco.calderon@intellectsystem.net');
                /*mail.add('jesus.britho@ficohsa.com');
                                mail.add('karen.cortes@ficohsa.com');
                                mail.add('carlos.escoto@ficohsa.com');*/
                message.toAddresses = mail;
                //message.toAddresses = new String[] { 'marco.calderon@intellectsystem.net', 'xyz@gmail.com' };
                message.optOutPolicy = 'FILTER';
                message.subject = 'Depósitos No Identificados';            
                string Body ='<strong>Favor su ayuda con la gestión de los depósitos en detalle:</strong><br/>'+
                '<table border="1">'+
                '<thead>'+
                '<th scope="col">'+
                '       <div class="slds-truncate"><strong>Moneda</strong></div>'+
                '</th>'+
                '<th scope="col">'+
                '       <div class="slds-truncate"><strong>Fecha</strong></div>'+
                '</th>'+
                '<th scope="col">'+
                '       <div class="slds-truncate"><strong>Descripción</strong></div>'+
                '</th>'+
                '<th scope="col">'+
                '       <div class="slds-truncate"><strong>Descripción Nota</strong></div>'+
                '</th>'+
                '<th scope="col">'+
                '       <div class="slds-truncate"><strong>Referencia</strong></div>'+
                '</th>'+
                '<th scope="col">'+
                '       <div class="slds-truncate"><strong>Monto</strong></div>'+
                '</th>'+
                '<th scope="col">'+
                '       <div class="slds-truncate"><strong>Agencia de Origen</strong></div>'+
                '</th>'+
                '</thead>'+
                '<tbody>'+
                '<td><span>'+mon[count]+'</span></td>'+
                '<td><span>'+fech[count]+'</span></td>'+
                '<td><span>'+descrip[count]+'</span></td>'+
                '<td><span>'+descripnot[count]+'</span></td>'+
                '<td><span>'+refer[count]+'</span></td>'+
                '<td><span>'+mont[count]+'</span></td>'+
                '<td><span>'+agnb[count]+'</span></td>'+
                '</tbody>'+
                '</table>';
                message.setHtmlBody(Body);
                Messaging.SingleEmailMessage[] messages = new List<Messaging.SingleEmailMessage> {message};
                Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
                
                if (results[0].success) {
                    System.debug('The email was sent successfully.');
                }else{
                    System.debug('The email failed to send: ' + results[0].errors[0].message);
                }
            }
        }catch(exception ex){
            system.debug(ex.getLineNumber());
            system.debug(ex);
        }
    }
}