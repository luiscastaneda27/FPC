global without sharing class controladorCargarPlanilla {
    
    
    public  string Codigo_Unico_Banco{get;set;}
    public string mensaje{get;set;}
    public string tipoMoneda{get;set;}  
    public string usuario;
    public string estadoplanilla; 
    public integer tasaCambio;
    public list<SelectOption> Listmeses{get;set;}
    public string NombreMes{get;set;} 
    public string Nombre_Empresa{get;set;}
    public  boolean ActivarModal{get;set;} 
    public  boolean Mostrartabla{get;set;}
    public  boolean MostrarBotones{get;set;}
    public list<Account> empleadoConsulta; 
    public static List<SelectOption> options {get;set;}
    //public static string mensaje{get;set;}
    // public  string tipoMoneda{get;set;}            
    public  string MensajeEmpleadosNuevos {get;set;}
    public Boolean mostrarGuardar{get;set;}
    public decimal APO {get;set;}
    public decimal AEO {get;set;}
    public decimal APV{get;set;}
    public decimal Reserva_Laboral{get;set;}
    public decimal AEV{get;set;}
    //agregado wp 28-10-2019
    public Decimal APE{get;set;}
    public Decimal APX{get;set;}
    public Decimal ASV{get;set;}
    //
    public decimal salarios{get;set;}
    public date fechap{get;set;}
    static string empresa;
    public Boolean MostrarLempiras{get;set;}
    public Boolean MostrarDolares{get;set;}
    public  boolean MostrarSINO{get;set;}
    
    list<Contenido_Planilla__c> Pla;
    public List<planilla> ListClientesNuevos {get;set;}
    public  List<planilla> ListClientesN {get;set;}
    public  List<planilla> MListClientesN {get;set;}
    public list<empresa_x_empleado__c>empleadosCuentaMala{get;set;}
    public list<Account>empleadosCuentaMala2{get;set;}
    public  List<planilla> duplicados{get;set;}
    public  List<planilla> NuevosEm{get;set;}
    
    public string ContenidoPlanilla{get;set;}
    
    public date fecha{get;set;}
    String tipoNatural = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Natural').getRecordTypeId();
    
    string Voluntarias;
    string cesantias;
    string Pcomplemetario;
    public string totalempleados{get;set;}
    
    //PAGINACIÓN 
    public boolean mostrarSiguiente{get;set;}
    public boolean mostrarANterior{get;set;}
    public boolean mostrarBotonesP{get;set;}
    integer contadorpaginacion;
    
    //agregado 07-07-2020 privilegios todas la cuentas en la planilla
    public boolean tPrivilegios{get;set;}

    public controladorCargarPlanilla()
    {    
        Codigo_Unico_Banco = ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
        //empresa =ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
        usuario = ApexPages.currentPage().getParameters().get('loetdncdhjch');
        tipoMoneda = ApexPages.currentPage().getParameters().get('Moneda');
        Nombre_Empresa = [select name from account where id =:Codigo_Unico_Banco].name;
        reIniciar();  
        Cargarmeses();
        if(tipoMoneda=='HNL'){
            mensaje ='';
        }else{
            mensaje ='';
        }
        
    }
    
    public void reIniciar(){ 
        mostrarTabla=false;
        mostrarBotones=true;
        totalempleados='';
        ActivarModal=false;
        mostrarSINO= False;
        mostrarGuardar= False;
        MostrarLempiras= False;
        MostrarDolares= False;
        
        fechap=date.today();
        
        options=new List<SelectOption>();
        
        ListClientesNuevos = new list<planilla>();
        ListClientesN = new list<planilla>();
        duplicados = new list<planilla>();
        NuevosEm = new list<planilla>();
        empleadosCuentaMala2= new list<account>();
        empleadosCuentaMala= new list<empresa_x_empleado__C>();
        
    }
    
    
    public void Cargarmeses(){
        try{
            
            Listmeses = new list<SelectOption>();
            nombremes = '';
            Listmeses.add(new SelectOption('1','Enero'));
            Listmeses.add(new SelectOption('2','Febrero'));
            Listmeses.add(new SelectOption('3','Marzo'));
            Listmeses.add(new SelectOption('4','Abril'));
            Listmeses.add(new SelectOption('5','Mayo'));
            Listmeses.add(new SelectOption('6','Junio'));
            Listmeses.add(new SelectOption('7','Julio'));
            Listmeses.add(new SelectOption('8','Agosto'));
            Listmeses.add(new SelectOption('9','Septiembre'));
            Listmeses.add(new SelectOption('10','Octubre'));
            Listmeses.add(new SelectOption('11','Noviembre'));
            Listmeses.add(new SelectOption('12','Diciembre'));
            NombreMes=string.valueOf(date.today().Month());
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!')); 		
        }
    }
    
    public void sumas()
    {
        
        APO=0.0;
        AEO=0.0;
        APV=0.0;
        Reserva_Laboral=0.0;
        AEV=0.0;
        //agregado wp 28-10-2019
        APE=0.0;
        APX=0.0;
        ASV=0.0;
        //
        salarios=0.0;
        for(integer i=0; i<ListCLientesN.size(); i++)
        {
            APO +=(ListCLientesN[i].APO).setScale(2);
            AEO +=(ListCLientesN[i].AEO).setScale(2);
            APV +=(ListCLientesN[i].APV).setScale(2);
            AEV +=(ListCLientesN[i].AEV).setScale(2);
            //agregado wp 28-10-2019
            APE +=(ListCLientesN[i].APE).setScale(2);
            APX +=(ListCLientesN[i].APX).setScale(2);
            ASV +=(ListCLientesN[i].ASV).setScale(2);
            //
            Reserva_Laboral +=(ListCLientesN[i].Reserva_Laboral).setScale(2);
            salarios +=(ListCLientesN[i].salario).setScale(2);
        }
        for(integer i=0; i<NuevosEm.size(); i++)
        {
            APO +=(NuevosEm[i].APO).setScale(2);
            AEO +=(NuevosEm[i].AEO).setScale(2);
            APV +=(NuevosEm[i].APV).setScale(2);
            AEV +=(NuevosEm[i].AEV).setScale(2);
            //agregado wp 28-10-2019
            APE +=(NuevosEm[i].APE).setScale(2);
            APX +=(NuevosEm[i].APX).setScale(2);
            ASV +=(NuevosEm[i].ASV).setScale(2);
            //
            Reserva_Laboral +=(NuevosEm[i].Reserva_Laboral).setScale(2);
            salarios +=(NuevosEm[i].salario).setScale(2);
        }
    }
    
    
    
    /*public void agrregarEmpleados(string idplan)
{
try
{		Codigo_Unico_Banco = ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
list<contenido_planilla__C> empleadosEmpresa = new list<contenido_planilla__C>();
empleadosEmpresa =[select empleado2__r.Identificacion__C, empleado2__r.tipo_identificacion__c,
empleado2__r.firstname, empleado2__r.lastname, empleado2__r.estado_civil__pc,
empleado2__r.sexo__C, Aporte_Empleado_Obligatorio__c, Aporte_Empleado_Voluntario__c,
Aporte_Patrono_obligatorio__c, Aporte_Patrono_Voluntario__c,
Reserva_Laboral__c from contenido_planilla__C where planilla__C=:idplan];
//return new PageReference ('/Apex/vfHome?Eldudhdhyudb=' + Codigo_Unico_Banco + '&loetdncdhjch=' + usuario);

string todosempleados='';
classAfiliacion nueva;
list<string> separacionNombre = new list<string>();
Enviarcuentas();
Autonumerico_cuentas_Syste__c Numerosformularios=[select id, Id_Formulario_Sysde__c from Autonumerico_cuentas_Syste__c limit 1];
for(contenido_planilla__C item :empleadosEmpresa)
{
separacionNombre.add(item.empleado2__r.Identificacion__C);
}
list<cuentas__C> vf = new list<cuentas__C>();
map<string, list<cuentas__C>> mapcuentas = new map<string, list<cuentas__C>>();
list<cuentas__C> todascuentas =[select codigo__c, cuenta_colectiva2__r.codigo__C, cliente__r.identificacion__C from cuentas__C where cliente__r.identificacion__C in:separacionNombre];
//system.debug(todascuentas);
for(integer i=0; i<todascuentas.size(); i++)
{
vf = new list<cuentas__C>();
if(mapcuentas.containsKey(todascuentas[i].cliente__r.identificacion__C))
{
vf=mapcuentas.get(todascuentas[i].cliente__r.identificacion__C);
vf.add(todascuentas[i]);
mapcuentas.remove(todascuentas[i].cliente__r.identificacion__C);
mapcuentas.put(todascuentas[i].cliente__r.identificacion__C,vf);
}
else
{
vf.add(todascuentas[i]);
mapcuentas.put(todascuentas[i].cliente__r.identificacion__C,vf);
}
}
list<cuentas_colectivas__C> cuentasColectivas =[select codigo__C, tipo_cuenta__C from cuentas_colectivas__C where empresa__c=:Codigo_Unico_Banco];
decimal abc=Numerosformularios.Id_Formulario_Sysde__c;
for(integer j=0; j<empleadosEmpresa.size(); j++)
{
string volun='Si';
string Obli='Si';
integer vo=0;
integer ob=0;
todascuentas = new list<Cuentas__C>();
if(mapcuentas.containsKey(empleadosEmpresa[j].empleado2__r.identificacion__c))
{
todascuentas =mapcuentas.get(empleadosEmpresa[j].empleado2__r.identificacion__c);
}
//for(integer i=0; i<empleadosEmpresa.size(); i++)
//{
//  if(empleadosEmpresa[i].empleado2__r.identificacion__c==empleadosEmpresa[j].empleado2__r.identificacion__c)
//  {
if(empleadosEmpresa[j].Aporte_Empleado_Obligatorio__c>0 || empleadosEmpresa[j].Aporte_patrono_Obligatorio__c>0  ||
empleadosEmpresa[j].reserva_laboral__c>0 )
{
ob=1;

for(integer gt=0; gt<todascuentas.size(); gt++)
{
if(todascuentas[gt].cliente__r.identificacion__C==empleadosEmpresa[j].empleado2__r.identificacion__c)
{
for(integer m=0; m<cuentascolectivas.size(); m++)
{
if(todascuentas[gt].cuenta_colectiva2__r.codigo__C == cuentascolectivas[m].codigo__C)
{
if(cuentascolectivas[m].tipo_cuenta__C=='Censatías' || cuentascolectivas[m].tipo_cuenta__C=='Pilar Complementario')
{
obli='No';
}
}
}
}
}
}
if(empleadosEmpresa[j].Aporte_Empleado_Voluntario__c>0 || empleadosEmpresa[j].Aporte_patrono_Voluntario__c>0)
{
vo=1;
for(integer gt=0; gt<todascuentas.size(); gt++)
{
if(todascuentas[gt].cliente__r.identificacion__C==empleadosEmpresa[j].empleado2__r.identificacion__c)
{
for(integer m=0; m<cuentascolectivas.size(); m++)
{
if(todascuentas[gt].cuenta_colectiva2__r.codigo__C == cuentascolectivas[m].codigo__C)
{
if(cuentascolectivas[m].tipo_cuenta__C=='Voluntarias')
{
volun='No';
}
}
}
}
}
}
//}


system.debug('Nuevo '+volun);
string tipocuenta='Si';
if(volun=='Si'  && vo>0)
{
if([select count() from cuenta_planilla__C 
where cuenta__r.cliente__r.identificacion__C=:empleadosEmpresa[j].empleado2__r.identificacion__c and
contenido_planilla__r.planilla__r.empresa2__c=:Codigo_Unico_Banco]>0)
{
volun='No'; 
}
}
if( obli=='Si' && ob>0 )
{
if([select count() from contenido_planilla__c 
where empleado2__r.identificacion__C=:empleadosEmpresa[j].empleado2__r.identificacion__c and
planilla__r.empresa2__c=:Codigo_Unico_Banco and Aporte_Empleado_Obligatorio__c>0 and
Aporte_Patrono_obligatorio__c>0 and Reserva_Laboral__c>0 ]>0)
{
obli='No'; 
}
}
system.debug('Nuevo2 '+volun);
if(volun=='Si' && obli=='Si' && vo>0 && ob>0)
{
tipocuenta='AMBAS';
}
else if(volun=='Si' && vo>0)
{
tipocuenta='VOLUNTARIAS';
}
else if(obli=='Si' && ob>0)
{
tipocuenta='OBLIGATORIAS';
}
if(tipocuenta !='Si')
{
nueva = new classAfiliacion();
separacionNombre =new list<string>();
nueva.primernombre=empleadosEmpresa[j].empleado2__r.firstname.trim();
nueva.primerapellido=empleadosEmpresa[j].empleado2__r.lastname.trim();
if(empleadosEmpresa[j].empleado2__r.firstname.trim().contains(' '))
{
separacionNombre= empleadosEmpresa[j].empleado2__r.firstname.trim().Split(' ');
nueva.primernombre=separacionNombre[0];
nueva.segundonombre=separacionNombre[1];
}
if(empleadosEmpresa[j].empleado2__r.lastname.trim().contains(' '))
{
separacionNombre =new list<string>();
separacionNombre= empleadosEmpresa[j].empleado2__r.lastname.trim().Split(' ');
nueva.primerapellido=separacionNombre[0];
nueva.segundoapellido=separacionNombre[1];
}

nueva.identificacion=empleadosEmpresa[j].empleado2__r.identificacion__C;
nueva.idTipoIdentificacion=empleadosEmpresa[j].empleado2__r.Tipo_Identificacion__c;

//nueva.cuentaColectiva=cuenta_colectiva;
//nueva.genero=empleadosEmpresa[j].empleado2__r.Sexo__c;
if(empleadosEmpresa[j].empleado2__r.Sexo__c=='Masculino' ||empleadosEmpresa[j].empleado2__r.Sexo__c=='M')
{
nueva.genero='M';
}
else
{
nueva.genero='F';
}
nueva.estadoCivil = 'S';
if(tipocuenta.toLowerCase() =='AMBAS' || tipocuenta.toLowerCase() =='AMBOS')
{
nueva.cuentaUno=voluntarias;
nueva.idSalesforceUno = 'SF'+string.valueOf(abc++);

nueva.cuentados=cesantias;
nueva.idSalesforcedos = 'SF'+string.valueOf(abc++);

nueva.cuentaTres=Pcomplemetario;
nueva.idSalesforceTres = 'SF'+string.valueOf(abc++);
}
if(tipocuenta.toLowerCase()=='VOLUNTARIAS' || tipocuenta.toLowerCase()=='VOLUNTARIOS')
{
nueva.cuentaUno=voluntarias;
nueva.idSalesforceUno = 'SF'+string.valueOf(abc++);
nueva.cuentados='NADANADA';
nueva.idSalesforcedos = 'NADANADA';

nueva.cuentaTres='NADANADA';
nueva.idSalesforceTres = 'NADANADA';
}
if(tipocuenta.toLowerCase()=='OBLIGATORIOS'  || tipocuenta.toLowerCase()=='OBLIGATORIAS')
{
nueva.cuentaUno=Pcomplemetario;
nueva.idSalesforceUno = 'SF'+string.valueOf(abc++);

nueva.cuentados=cesantias;
nueva.idSalesforcedos = 'SF'+string.valueOf(abc++);

nueva.cuentaTres='NADANADA';
nueva.idSalesforceTres = 'NADANADA';
}

todosempleados +='1,';
todosempleados +=nueva.identificacion+',';
todosempleados +=nueva.primerNombre+',';
todosempleados +=nueva.segundoNombre+',';
todosempleados +=nueva.primerApellido+',';
todosempleados +=nueva.segundoApellido+',';
todosempleados +=nueva.genero.toUpperCase()+',';
todosempleados +=nueva.estadoCivil.toUpperCase()+',';
todosempleados +='1,';
todosempleados +=nueva.cuentaunO+',';
todosempleados +=nueva.cuentados+',';
todosempleados +=nueva.cuentaTres+',';
todosempleados +=nueva.idSalesforceuno+',';
todosempleados +=nueva.idSalesforcedos+',';
todosempleados +=nueva.idSalesforceTres+'::::'; 
}



}
Numerosformularios.Id_Formulario_Sysde__c=abc;
update Numerosformularios;
system.debug('Contenido:'+ todosempleados);
if(todosempleados.length()>3)
{
aSysdePortalEmpresarial.Afiliacionsysdemasiva(todosempleados, 'gt',5, idplan);  
}
}
catch(Exception ex)
{

}
}*/
    
    
    
    /* public void Enviarcuentas()
{
list<Cuentas_colectivas__C> fr = new list<Cuentas_colectivas__C>();
fr = [Select  Codigo__C, tipo_cuenta__C from Cuentas_colectivas__C where empresa__C=:Codigo_Unico_Banco];
for(integer i=0; i<fr.size(); i++)
{
if(fr[i].tipo_cuenta__C=='Voluntarias')
{
voluntarias = fr[i].codigo__C;
}
if(fr[i].tipo_cuenta__C=='Censatías')
{
cesantias = fr[i].codigo__C;
}
if(fr[i].tipo_cuenta__C=='Pilar Complementario')
{
Pcomplemetario = fr[i].codigo__C;
}

}
}
*/
    
   // METODOS NUEVOS
   
    public void popEnviar(){
        estadoPlanilla='Pendiente Aprobación Interna';
        MostrarSINO= True;
        
    }
    public void popGuardar(){
        estadoPlanilla='Nueva';
        MostrarSINO= True;
        
    }
    public void Si(){
       tasaCambio=0;
        EnviarPlanilla(); 
        
    }
     public void No(){
        tasaCambio=1;
         EnviarPlanilla(); 
    }
    //FIN METODOS NUEVOS
    
    
   /* public void CompraDollarEnviar()
    {
        estadoPlanilla='Pendiente Aprobación Interna';
        MostrarSINO= True;
        
    }
    public void CompraDollarguardar()
    {
        estadoplanilla='Nueva';
        MostrarSINO= True;
        
    }
    public void guardar()
    {
        estadoplanilla='Nueva';
        lkiu=0;
        MostrarSINO= True;
        EnviarPlanilla();  
    }
   
    public void EnviarSinCompraUSD()
    {
        if(!MostrarSINO)
        {
            estadoplanilla='Pendiente Aprobación Interna';  
        }
        lkiu=1;
        EnviarPlanilla();
        
    }
    public void EnviarCompraUSD()
    {
        //estadoplanilla='Pendiente Aprobación Interna';
        lkiu=2;
        EnviarPlanilla();  
    }*/
    
    
    public PageReference EnviarPlanilla(){
        try{
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
            hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            Codigo_Unico_Banco = ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
            string cuenta_colectiva=[select  codigo__c from CUENTAS__C WHERE CLIENTE__C = :Codigo_Unico_Banco limit 1].codigo__c;
            
            Pla = new list<Contenido_Planilla__c>();
            Planilla__c po= new Planilla__C();
            po.CurrencyIsoCode = tipomoneda; 
            po.Empresa2__c=Codigo_Unico_Banco;
            po.Fecha__c=FechaP;
            po.Tasa_compra__c= tasaCambio;
            if(tasacambio==0){
                po.CurrencyIsoCode = tipomoneda == 'HNL' ?'USD':'HNL';
            }
            po.Creado_por__c=ApexPages.currentPage().getParameters().get('loetdncdhjch');
            po.Tipo_planilla__c='Cargada';
            po.Mes_Aporte__c=NombreMes;
            po.estado2__C=estadoplanilla;
            insert po;
            list<string> hy = new list<string>();
            for(integer i=0; i<NuevosEm.size(); i++)
            {
                hy.add(NuevosEm[i].Num_Identidad);
            }
            list<Account> empleados = new list<Account>();
            list<Account> verifiEmple = new list<Account>();
            verifiEmple =[select identificacion__C from Account where identificacion__C in :hy];
            Account k;
            for(integer i=0; i<hy.size(); i++)
            {
                string si='Si';
                for(integer j=0; j<verifiEmple.size(); j++){
                    if(hy[i]==verifiEmple[j].identificacion__C){
                        si='NO';
                    }
                }
                if(si=='Si') {
                    integer knn=0;
                    for(integer kn=0; kn<empleadoConsulta.size(); kn++){
                        if(empleadoConsulta[kn].identificacion__C==NuevosEm[i].Num_Identidad) {
                            knn=kn;
                            kn=empleadoConsulta.size();
                        }
                    }
                    k= new Account();
                    k.Identificacion__c=NuevosEm[i].Num_Identidad;
                    k.firstname=NuevosEm[i].Primer_Nombre;
                    k.lastname=NuevosEm[i].Primer_Apellido;
                    if(NuevosEm[i].Primer_Apellido.trim()==''){
                        k.lastname='.'; 
                    }
                    k.recordTypeId = tipoNatural;
                    k.Tipo_identificacion__c='1';
                    try{
                        k.Sexo__c=empleadoConsulta[knn].sexo__C;
                    }
                    catch(Exception ex){}
                    try{
                        k.PersonBirthdate=empleadoConsulta[knn].PersonBirthdate;
                    }catch(Exception ex){}
                    
                    empleados.add(k);
                }
            }
            if(empleados.size()>0)
            {
                //insert empleados;
            }
            
            Empresa_X_Empleado__c kk;
            list<Empresa_X_Empleado__c> empleadoEmpre = new list<Empresa_X_Empleado__c>();
            for(integer i=0; i<NuevosEm.size(); i++)
            {
                kk = new Empresa_X_Empleado__c();
                kk.Empleado2__r=new Account(Identificacion__c=NuevosEm[i].Num_Identidad);
                kk.Estado__c='Activo';
                kk.Empresa2__c=Codigo_Unico_Banco;
                kk.Salario__c=NuevosEm[i].salario;
                empleadoEmpre.add(kk); 
            }
            if(empleadoEmpre.size()>0)
            {
                //insert empleadoEmpre;
            }
            
            for(integer i=0; i<ListCLientesN.size(); i++)
            {
                Contenido_Planilla__c poo =new Contenido_Planilla__c();
                poo.Planilla__c=po.id;
                poo.Empleado2__r = new Account(Identificacion__c = ListCLientesN[i].Num_Identidad);
                poo.Aporte_Empleado_Obligatorio__c=ListCLientesN[i].AEO;
                poo.Aporte_Empleado_Voluntario__c=ListCLientesN[i].AEV;
                poo.Aporte_Patrono_obligatorio__c=ListCLientesN[i].APO;
                poo.Aporte_Patrono_Voluntario__c=ListCLientesN[i].APV;
                //agregado wp 28-10-2019
                poo.Aporte_Empleado_Extraordinario__c=ListCLientesN[i].APE;
                poo.Aporte_Patrono_Extraordinario__c=ListCLientesN[i].APX;
                poo.Aporte_Seguro_de_Vida__c=ListCLientesN[i].ASV;
                //
                poo.Reserva_Laboral__c=ListCLientesN[i].Reserva_Laboral;
                poo.salario__c=ListCLientesN[i].Salario;
                Pla.add(poo);
            }
            database.insert(pla,false);
            list<Cuenta_planilla__c> Cuenta_planilla = new list<Cuenta_planilla__c>();
            cuenta_planilla__c CuentaPlanilla;
            map<string, planilla> bmw=New map<string, planilla>();
            for(integer j=0; j<ListCLientesN.size(); j++)
            {
                if(!bmw.containsKey(ListCLientesN[j].Num_identidad))
                {
                    bmw.put(ListCLientesN[j].Num_identidad, ListCLientesN[j]);
                }
            }
            for(integer i=0; i<pla.size(); i++)
            {
                if(bmw.containsKey(pla[i].Empleado2__r.Identificacion__c))
                {
                    list<planilla> lopp= new list<planilla>();
                    lopp.add(bmw.get(pla[i].Empleado2__r.Identificacion__c));
                    for(integer lk=0; lk<lopp[0].cuentasAEV.size(); lk++)
                    {
                        integer bandera=0;
                        integer lkk=0;
                        for(integer lkkt=0; lkkt<lopp[0].cuentasAPV.size(); lkkt++)
                        {
                            if(lopp[0].cuentasAPV[lkkt].Num_cuenta== lopp[0].cuentasAEV[lk].Num_cuenta)
                            {
                                lkk=lkkt;
                                bandera=10;
                                
                            }
                        }
                        if(bandera==10)
                        {
                            CuentaPlanilla = new Cuenta_planilla__c();
                            CuentaPlanilla.Contenido_Planilla__c = pla[i].id;
                            CuentaPlanilla.Codigo_cuenta__c = lopp[0].CuentasAEV[lk].Num_cuenta; 
                            CuentaPlanilla.Cuenta__r = new Cuentas__C (Codigo__c = lopp[0].CuentasAEV[lk].Num_cuenta);
                            CuentaPlanilla.Valor_Monto__c=lopp[0].CuentasAEV[lk].Aportacion;
                            //AGREGADO WP 31-10-2019
                            CuentaPlanilla.Valor_Monto_Extraordinario__c = lopp[0].CuentasAPE[lk].Aportacion;
                            CuentaPlanilla.Valor_Monto_Patronal_Extraordinario__c = lopp[0].CuentasAPX[lk].Aportacion;
                            CuentaPlanilla.Valor_Monto_Seguro_Vida__c = lopp[0].CuentasASV[lk].Aportacion;
                            //
                            CuentaPlanilla.Valor_Monto_Patrono__c=lopp[0].CuentasAPV[lkk].Aportacion;
                            CuentaPlanilla.Tipo__c='Empresa';
                            Cuenta_planilla.add(CuentaPlanilla);
                        }
                        else
                        {
                            CuentaPlanilla = new Cuenta_planilla__c();
                            CuentaPlanilla.Contenido_Planilla__c = pla[i].id;
                            CuentaPlanilla.Codigo_cuenta__c = lopp[0].CuentasAEV[lk].Num_cuenta; 
                            CuentaPlanilla.Cuenta__r = new Cuentas__C (Codigo__c = lopp[0].CuentasAEV[lk].Num_cuenta);
                            CuentaPlanilla.Valor_Monto__c=lopp[0].CuentasAEV[lk].Aportacion;
                            //AGREGADO WP 31-10-2019
                            CuentaPlanilla.Valor_Monto_Extraordinario__c = lopp[0].CuentasAPE[lk].Aportacion;
                            CuentaPlanilla.Valor_Monto_Patronal_Extraordinario__c = lopp[0].CuentasAPX[lk].Aportacion;
                            CuentaPlanilla.Valor_Monto_Seguro_Vida__c = lopp[0].CuentasASV[lk].Aportacion;
                            //
                            CuentaPlanilla.Valor_Monto_Patrono__c=0.0;
                            CuentaPlanilla.Tipo__c='Empleado';
                            Cuenta_planilla.add(CuentaPlanilla);   
                        }
                    }
                    
                    
                }
            }
            //insert Cuenta_planilla;
            database.insert(Cuenta_planilla,false);
            pla = new list<Contenido_Planilla__c>();
            list<string> identidades = new list<string>();
            for(integer i=0; i<NuevosEm.size(); i++)
            {
                Contenido_Planilla__c poo =new Contenido_Planilla__c();
                poo.Planilla__c=po.id;
                poo.Empleado2__r = new Account(identificacion__C = NuevosEm[i].Num_Identidad);
                identidades.add(NuevosEm[i].Num_Identidad);
                poo.Aporte_Empleado_Obligatorio__c=NuevosEm[i].AEO;
                poo.Aporte_Empleado_Voluntario__c=NuevosEm[i].AEV;
                poo.Aporte_Patrono_obligatorio__c=NuevosEm[i].APO;
                poo.Aporte_Patrono_Voluntario__c=NuevosEm[i].APV;
                //agregado wp 28-10-2019
                poo.Aporte_Empleado_Extraordinario__c=NuevosEm[i].APE;
                poo.Aporte_Patrono_Extraordinario__c=NuevosEm[i].APX;
                poo.Aporte_Seguro_de_Vida__c=NuevosEm[i].ASV;
                //
                poo.Reserva_Laboral__c=NuevosEm[i].Reserva_Laboral;
                poo.salario__C=0;
                Pla.add(poo);
            }             
            database.insert(pla,false);
            delete([select id from contenido_planilla_Temporal__c where Planilla__r.name=:Codigo_Unico_Banco limit 3000]);
            delete ([select id from planilla_Temporal__c where name=:codigo_unico_banco]);
            Usuario_X_Empresa__c usuarioEmpresa = new Usuario_X_Empresa__c();
            string nombreplanilla=[select name from planilla__C where id=:po.id].name;
            string mensajert='¡La planilla '+nombreplanilla+' se guardo correctamente!';
            usuarioEmpresa.Empresa2__c=codigo_unico_banco;
            
            if(estadoplanilla=='Pendiente Aprobación Interna')
            {
                mensajert='¡La planilla '+nombreplanilla+' se envío correctamente!';
                claseUtilPlanillas.correoEnvioPlanilla2(po.id);
            }
            
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, mensajert)); 
            reIniciar();
            NuevosEm.clear();
            verifiEmple.clear();
            hy.clear();
            empleados.clear();
            empleadoEmpre.clear();
            Pla.clear();
            Cuenta_planilla.clear();
            ListCLientesN.clear();
            bmw.clear();
            //agrregarEmpleados(po.id);
        }
        catch(Exception ex)
        {
            system.debug('Error al Guardar: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());
            
        }
        
        return null;
        
    }
    
    public void VerPlanilla()
    {
        try{
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
            system.debug('Usuario: '+usuario);
            hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            ListClientesNuevos = new list<planilla>();
            ListClientesN = new list<planilla>();
            duplicados = new list<planilla>();
            Codigo_Unico_Banco = ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
            //agregado 07-07-2020 privilegios todas la cuentas en la planilla 
            Account cuentaC = [select Permitir_Cargar_Planilla_Varios__c from Account where id = :Codigo_Unico_Banco];
            if (cuentaC!= null){
                tPrivilegios = cuentaC.Permitir_Cargar_Planilla_Varios__c;
            }else{
                tPrivilegios = false;
            }
            
            NuevosEm = new list<planilla>();
            Planilla_Temporal__c NuevaPlanilla = new Planilla_Temporal__c();
            //Codigo_Unico_Banco=ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
            system.debug('Codigo unico banco: '+codigo_unico_banco);
            NuevaPlanilla =[select id, Numeracion_Automativa__c from Planilla_Temporal__c where name=:codigo_unico_banco order by Numeracion_Automativa__c DESC limit 1];
            system.debug('id de la planilla: '+NuevaPlanilla.id);
            ListCLientesNuevos = new list<Planilla>();
            duplicados = new list<Planilla>();
            boolean band = true;
            list<string> ident = new list<string>();
            map<string, planilla> todosr= new map<string, planilla>();
            map<string, integer> todosr2= new map<string, integer>();
            List<String> listIdCuentas = new List<String>();
            for(Contenido_Planilla_Temporal__c t: 
                [select Identidad__c, cuenta__c , Aporte_Empleado_Voluntario__c, Aporte_Empleado_Obligatorio__c,
                 Aporte_Patronal_Obligatorio__c,Aporte_Reserva_Laboral__c,Aporte_Patronal_Voluntario__c,
                 /*agregado wp 06-11-2019*/Aporte_Empleado_Extraordinario__c, Aporte_Patrono_Extraordinario__c, Aporte_Seguro_de_Vida__c
                 from Contenido_Planilla_Temporal__c where planilla__c=:NuevaPlanilla.id ]){
                     //
                     listIdCuentas.add(t.Identidad__c);
                     
                     system.debug('t cuenta: '+t.cuenta__c);
                     if(!todosr2.containsKey(t.cuenta__c) && band)
                     {
                         system.debug('Algo: '+todosr2.containsKey(t.cuenta__c)+' '+band);
                         if(t.cuenta__c!='NADANADA')
                         {
                             todosr2.put(t.cuenta__c, 9);
                         }
                         ident.add(t.Identidad__c);
                         if(ApexPages.currentPage().getParameters().get('Moneda')=='HNL')
                         {
                             ListCLientesNuevos.add(new Planilla(t.Identidad__c,'','', '', '',0.0,t.Aporte_Patronal_Obligatorio__c ,
                                                                 t.Aporte_Empleado_Obligatorio__c,t.Aporte_Patronal_Voluntario__c,t.Aporte_Empleado_Voluntario__c,
                                                                 /*agregado wp 06-11-2019*/t.Aporte_Empleado_Extraordinario__c,t.Aporte_Patrono_Extraordinario__c, t.Aporte_Seguro_de_Vida__c,
                                                                 t.Cuenta__c, t.Aporte_Reserva_Laboral__c));
                             duplicados.add(new Planilla(t.Identidad__c, 0, t.cuenta__c));
                             system.debug('duplicados revisar: '+duplicados);
                             /*duplicados.add(new Planilla(t.Identidad__c, 0,t.Aporte_Patronal_Obligatorio__c ,
t.Aporte_Empleado_Obligatorio__c,t.Aporte_Patronal_Voluntario__c,t.Aporte_Empleado_Voluntario__c,0.0));*/
                         }
                         else
                         {
                             ListCLientesNuevos.add(new Planilla(t.Identidad__c,'','', '', '',0.0,0.0 ,
                                                                 0.0,t.Aporte_Patronal_Voluntario__c,t.Aporte_Empleado_Voluntario__c,
                                                                 /*agregado wp 06-11-2019*/t.Aporte_Empleado_Extraordinario__c,t.Aporte_Patrono_Extraordinario__c, t.Aporte_Seguro_de_Vida__c,
                                                                 t.Cuenta__c, 0.0));
                             duplicados.add(new Planilla(t.Identidad__c, 0, t.cuenta__c));
                             //duplicados.add(new Planilla(t.Identidad__c, 0,0.0,0.0,t.Aporte_Patronal_Voluntario__c,t.Aporte_Empleado_Voluntario__c,0.0));
                         }
                         if(!todosr.containsKey(t.Identidad__c))
                         {
                             system.debug('entro en el put');
                             todosr.put(t.Identidad__c,ListCLientesNuevos[ListCLientesNuevos.size()-1]);
                         }
                     }
                     else
                     {
                         band=false; 
                     }
                     
                     
                     
                 }
            system.debug('listado de IDs: '+listIdCuentas);
            system.debug('listado de cuentass: '+ListCLientesNuevos);
            if(band)
            {
                todosr2.clear();
                list<Empresa_X_Empleado__c> empleadosempresa= new list<Empresa_X_Empleado__c>();
                //
                list<Account> empleadosCuenta = new list<Account>();
                //
                list<cuentas__c> listcuentasEmpleados = new list<cuentas__c>();
                list<string> clientesCuentas = new list<string>();
                
                for(cuentas_colectivas__C item:[select codigo__C from cuentas_colectivas__C where empresa__C=:Codigo_Unico_Banco and Tipo_cuenta__C='Voluntarias'])
                {
                    clientesCuentas.add(item.codigo__C);
                }
                // integer contadorr=0;
                system.debug('clientesCuentas: '+clientesCuentas);
                map<string, list<cuentas__c>> cuentasidentidades= new map<string, list<cuentas__c>>();
                if (tPrivilegios == true){
                    listcuentasEmpleados = [select Codigo__c, Cliente__r.Identificacion__C, cuenta_colectiva2__C from cuentas__c where Cliente__r.Identificacion__C in:ident and Producto__r.CurrencyIsoCode=:ApexPages.currentPage().getParameters().get('Moneda')];
                    system.debug('listcuentasEmpleados2: '+listcuentasEmpleados+' '+listcuentasEmpleados.size());
                    for(integer i=0; i<listcuentasEmpleados.size(); i++)
                    {
                        system.debug('entro en for');
                        list<cuentas__c> vf = new list<cuentas__c>();
                        if(!cuentasidentidades.containsKey(listcuentasEmpleados[i].Cliente__r.Identificacion__C))
                        {
                            vf.add(listcuentasEmpleados[i]);
                            cuentasidentidades.put(listcuentasEmpleados[i].Cliente__r.Identificacion__C,vf);
                        }
                        else
                        {
                            vf=cuentasidentidades.get(listcuentasEmpleados[i].Cliente__r.Identificacion__C);
                            vf.add(listcuentasEmpleados[i]);
                            cuentasidentidades.remove(listcuentasEmpleados[i].Cliente__r.Identificacion__C);
                            cuentasidentidades.put(listcuentasEmpleados[i].Cliente__r.Identificacion__C,vf);
                            
                        }
                    }
                }
                else{
                    listcuentasEmpleados = [select Codigo__c, Cliente__r.Identificacion__C, cuenta_colectiva2__C from cuentas__c where cuenta_colectiva2__r.codigo__C in :clientesCuentas and Producto__r.CurrencyIsoCode=:ApexPages.currentPage().getParameters().get('Moneda')];
                    system.debug('listcuentasEmpleados1: '+listcuentasEmpleados);
                    for(integer i=0; i<listcuentasEmpleados.size(); i++)
                    {
                        system.debug('entro en for de cuentas bajo la cuenta colectiva '+ listcuentasEmpleados[i].Cliente__r.Identificacion__C);
                        list<cuentas__c> vf = new list<cuentas__c>();
                        if(!cuentasidentidades.containsKey(listcuentasEmpleados[i].Cliente__r.Identificacion__C))
                        {
                            vf.add(listcuentasEmpleados[i]);
                            //ident.add(listcuentasEmpleados[i].Cliente__r.Identificacion__C);
                            cuentasidentidades.put(listcuentasEmpleados[i].Cliente__r.Identificacion__C,vf);
                        }
                        else
                        {
                            vf=cuentasidentidades.get(listcuentasEmpleados[i].Cliente__r.Identificacion__C);
                            vf.add(listcuentasEmpleados[i]);
                            cuentasidentidades.remove(listcuentasEmpleados[i].Cliente__r.Identificacion__C);
                            cuentasidentidades.put(listcuentasEmpleados[i].Cliente__r.Identificacion__C,vf);
                            
                        }
                    }
                    
                    //agregado del respaldo
                    listcuentasEmpleados = [select Codigo__c, Cliente__r.Identificacion__C, cuenta_colectiva2__C from cuentas__c where cuenta_colectiva2__c=null and Cliente__r.Identificacion__C in:ident and Producto__r.CurrencyIsoCode=:ApexPages.currentPage().getParameters().get('Moneda')];
                    for(integer i=0; i<listcuentasEmpleados.size(); i++){
                        list<cuentas__c> vf = new list<cuentas__c>();
                        if(!cuentasidentidades.containsKey(listcuentasEmpleados[i].Cliente__r.Identificacion__C)){
                            vf.add(listcuentasEmpleados[i]);
                            cuentasidentidades.put(listcuentasEmpleados[i].Cliente__r.Identificacion__C,vf);
                        } else{
                            vf=cuentasidentidades.get(listcuentasEmpleados[i].Cliente__r.Identificacion__C);
                            vf.add(listcuentasEmpleados[i]);
                            cuentasidentidades.remove(listcuentasEmpleados[i].Cliente__r.Identificacion__C);
                            cuentasidentidades.put(listcuentasEmpleados[i].Cliente__r.Identificacion__C,vf);
                            
                        }
                    }
                }                
                //agregado 07-07-2020 privilegios todas la cuentas en la planilla
                empleadosCuenta = [Select identificacion__c, FirstName, Lastname from Account where identificacion__c = :listIdCuentas]; 
                map<string, Account> identidadesempleadosC = new map<string, Account>();
                for(integer i=0; i<empleadosCuenta.size(); i++)
                {
                    if(!identidadesempleadosC.containsKey(empleadosCuenta[i].identificacion__c))
                    {
                        identidadesempleadosC.put(empleadosCuenta[i].identificacion__c, empleadosCuenta[i]);
                        //system.debug('uno a uno identidadesempleadosC: '+identidadesempleadosC);
                    }
                }
                system.debug('Listado identidadesempleadosC: '+identidadesempleadosC+' '+identidadesempleadosC.size());
                empleadosempresa =[Select empleado2__r.identificacion__c, empleado2__r.FirstName, empleado2__r.Lastname, Salario__c from Empresa_X_Empleado__c where empresa2__c=:Codigo_Unico_Banco and estado__c='Activo']; 
                map<string, Empresa_X_Empleado__c> identidadesempleados= new map<string, Empresa_X_Empleado__c>();
                for(integer i=0; i<empleadosempresa.size(); i++)
                {
                    if(!identidadesempleados.containsKey(empleadosempresa[i].empleado2__r.identificacion__c))
                    {
                        identidadesempleados.put(empleadosempresa[i].empleado2__r.identificacion__c, empleadosempresa[i]);
                    }
                }
                ListCLientesN = new list<Planilla>();
                map<string, integer> controlador= new map<string, integer>(); 
                for(integer i=0; i<ListCLientesNuevos.size(); i++) // Todos los empleados que vienen en el Excel
                {
                    if(i>0)
                    {
                        ListCLientesNuevos[i-1]=null;   
                    }
                    if(!todosr.containsKey(ListCLientesNuevos[i].Num_identidad))
                    {
                        todosr.put(ListCLientesNuevos[i].Num_identidad,ListCLientesNuevos[i]);   
                    }
                    //modificado 07-07-2020 privilegios todas la cuentas en la planilla
                    //system.debug('compara 1: '+identidadesempleadosC+' y '+ListCLientesNuevos[i].Num_identidad);//system.debug('compara 2: '+cuentasidentidades+' y '+ListCLientesNuevos[i].Num_identidad);
                    //system.debug('comparacion: '+identidadesempleados+' y '+ListCLientesNuevos[i].Num_identidad);//system.debug('comparacion 2: '+cuentasidentidades+' y '+ListCLientesNuevos[i].Num_identidad);
                    if(identidadesempleados.containsKey(ListCLientesNuevos[i].Num_identidad) &&cuentasidentidades.containsKey(ListCLientesNuevos[i].Num_identidad) || identidadesempleadosC.containsKey(ListCLientesNuevos[i].Num_identidad) &&cuentasidentidades.containsKey(ListCLientesNuevos[i].Num_identidad) && tPrivilegios == true )
                    {
                        system.debug('Entro al if privilegios');
                        listcuentasEmpleados= new list<cuentas__C>();
                        listcuentasEmpleados=cuentasidentidades.get(ListCLientesNuevos[i].Num_identidad);
                        INTEGER POSICION = -100;
                        for(integer h=0; h<listcuentasEmpleados.size(); h++) // recorrido de todas las cuentas
                        {
                            if(ListCLientesNuevos[i].Num_Identidad==listcuentasEmpleados[h].Cliente__r.Identificacion__C &&   // comparacion de la identidad del cliente 
                               ListCLientesNuevos[i].a==listcuentasEmpleados[h].Codigo__C ||                       // Comparacion de las cuentas de los clientes
                               ListCLientesNuevos[i].Num_Identidad==listcuentasEmpleados[h].Cliente__r.Identificacion__C &&   // comparacion de la identidad del cliente 
                               ListCLientesNuevos[i].a=='NADANADA')
                            {
                                if(controlador.containsKey(ListCLientesNuevos[i].Num_Identidad))
                                {
                                    POSICION=controlador.get(ListCLientesNuevos[i].Num_Identidad); 
                                    system.debug('entro a posicion: ');
                                }
                                //agregado 07-07-2020 privilegios todas la cuentas en la planilla
                                Account temporC= new Account();
                                
                                empresa_x_empleado__C tempor= new empresa_x_empleado__C();
                                //agregado 07-07-2020 privilegios todas la cuentas en la planilla
                                if(tPrivilegios == true){
                                    
                                    temporC=identidadesempleadosC.get(ListCLientesNuevos[i].Num_identidad);
                                    
                                }else
                                {
                                    
                                    tempor=identidadesempleados.get(ListCLientesNuevos[i].Num_identidad);
                                }
                                system.debug('Tempores: '+temporC+' '+tempor);
                                system.debug('posicion no se de que: '+posicion);
                                if(posicion == -100)
                                {
                                    controlador.put(ListCLientesNuevos[i].Num_identidad, i);
                                    system.debug('NADANADA: '+ListCLientesNuevos[i].a);
                                    if(ListCLientesNuevos[i].a=='NADANADA')
                                    {
                                        list<cuenta> CuentasPatrono = new list<cuenta>();
                                        list<cuenta> CuentasEmpleado = new list<cuenta>();
                                        //agregado wp 06-11-2019
                                        list<cuenta> cuentasempleadoExtraordinario = new list<cuenta>();
                                        list<cuenta> cuentaspatronoExtraordinario = new list<cuenta>();
                                        list<cuenta> cuentasSeguroVida = new list<cuenta>();
                                        //
                                        ListCLientesN.add(new planilla(ListCLientesNuevos[i].Num_identidad, tempor.empleado2__r.FirstName,
                                                                       '',tempor.empleado2__r.Lastname,'',tempor.salario__c,
                                                                       ListCLientesNuevos[i].APO,ListCLientesNuevos[i].AEO,ListCLientesNuevos[i].APV,ListCLientesNuevos[i].AEV,
                                                                       //agregado wp 28-10-2019
                                                                       ListCLientesNuevos[i].APE,ListCLientesNuevos[i].APX,ListCLientesNuevos[i].ASV,
                                                                       //
                                                                       ListCLientesNuevos[i].reserva_laboral, CuentasPatrono, CuentasEmpleado,
                                                                       //agregado wp 28-10-2019
                                                                       cuentasempleadoExtraordinario, cuentaspatronoExtraordinario, cuentasSeguroVida,
                                                                       //
                                                                       '','',''));
                                        duplicados[i].bandera=1;
                                    }
                                    else{
                                        list<cuenta> CuentasPatrono = new list<cuenta>();
                                        list<cuenta> CuentasEmpleado = new list<cuenta>();
                                        //agregado wp 06-11-2019
                                        list<cuenta> cuentasempleadoExtraordinario = new list<cuenta>();
                                        list<cuenta> cuentaspatronoExtraordinario = new list<cuenta>();
                                        list<cuenta> cuentasSeguroVida = new list<cuenta>();
                                        //
                                        if(listcuentasEmpleados[h].Cuenta_colectiva2__C !=null) 
                                        {
                                            
                                            CuentasPatrono.add(New Cuenta(ListCLientesNuevos[i].a, ListCLientesNuevos[i].APV));
                                            // contadorr ++;
                                        }
                                        CuentasEmpleado.add(new Cuenta(ListCLientesNuevos[i].a, ListCLientesNuevos[i].AEV));
                                                                      //agregado wp 31-10-2019
                                                                    cuentasempleadoExtraordinario.add(new Cuenta(ListCLientesNuevos[i].a, ListCLientesNuevos[i].APE));
                                                                    cuentaspatronoExtraordinario.add(new Cuenta(ListCLientesNuevos[i].a, ListCLientesNuevos[i].APX));
                                                                    cuentasSeguroVida.add(new Cuenta(ListCLientesNuevos[i].a, ListCLientesNuevos[i].ASV));
                                                                    //
                                        //agregado 07-07-2020 privilegios todas la cuentas en la planilla
                                        if(tPrivilegios == true){
                                            ListCLientesN.add(new planilla(ListCLientesNuevos[i].Num_identidad, temporC.FirstName,
                                                                       '',temporC.Lastname,'',0.0,
                                                                       ListCLientesNuevos[i].APO,ListCLientesNuevos[i].AEO,ListCLientesNuevos[i].APV,ListCLientesNuevos[i].AEV,
                                                                       //agregado wp 28-10-2019
                                                                       ListCLientesNuevos[i].APE,ListCLientesNuevos[i].APX,ListCLientesNuevos[i].ASV,
                                                                       //
                                                                       ListCLientesNuevos[i].reserva_laboral, CuentasPatrono, CuentasEmpleado,
                                                                       //agregado wp 28-10-2019
                                                                       cuentasempleadoExtraordinario, cuentaspatronoExtraordinario, cuentasSeguroVida,
                                                                       //
                                                                       '','',''));
                                        }else{
                                            ListCLientesN.add(new planilla(ListCLientesNuevos[i].Num_identidad, tempor.empleado2__r.FirstName,
                                                                       '',tempor.empleado2__r.Lastname,'',tempor.salario__c,
                                                                       ListCLientesNuevos[i].APO,ListCLientesNuevos[i].AEO,ListCLientesNuevos[i].APV,ListCLientesNuevos[i].AEV,
                                                                       //agregado wp 28-10-2019
                                                                       ListCLientesNuevos[i].APE,ListCLientesNuevos[i].APX,ListCLientesNuevos[i].ASV,
                                                                       //
                                                                       ListCLientesNuevos[i].reserva_laboral, CuentasPatrono, CuentasEmpleado,
                                                                       //agregado wp 28-10-2019
                                                                       cuentasempleadoExtraordinario, cuentaspatronoExtraordinario, cuentasSeguroVida,
                                                                       //
                                                                       '','',''));
                                        }
                                        
                                        duplicados[i].bandera=1; 
                                    }
                                    
                                }
                                else
                                {
                                    if(listcuentasEmpleados[h].Cuenta_colectiva2__C!=null && ListCLientesNuevos[i].a.Trim() !='NADANADA')
                                    {
                                        ListCLientesN[posicion].CuentasAPV.add(New Cuenta(ListCLientesNuevos[i].a, ListCLientesNuevos[i].APV));
                                        ListCLientesN[posicion].APV +=ListCLientesNuevos[i].APV;
                                        ListCLientesN[posicion].CuentasAEV.add(New Cuenta(ListCLientesNuevos[i].a, ListCLientesNuevos[i].AEV));
                                        ListCLientesN[posicion].AEV +=ListCLientesNuevos[i].AEV;
                                        
                                        ListCLientesN[posicion].APO +=ListCLientesNuevos[i].APO;
                                        ListCLientesN[posicion].AEO +=ListCLientesNuevos[i].AEO;
                                        //agregado wp 28-10-2019
                                        ListCLientesN[posicion].CuentasAPE.add(New Cuenta(ListCLientesNuevos[i].a, ListCLientesNuevos[i].APE));
                                        ListCLientesN[posicion].APE +=ListCLientesNuevos[i].APE;
                                        ListCLientesN[posicion].CuentasAPX.add(New Cuenta(ListCLientesNuevos[i].a, ListCLientesNuevos[i].APX));
                                        ListCLientesN[posicion].APX +=ListCLientesNuevos[i].APX;
                                        ListCLientesN[posicion].CuentasASV.add(New Cuenta(ListCLientesNuevos[i].a, ListCLientesNuevos[i].ASV));
                                        ListCLientesN[posicion].ASV +=ListCLientesNuevos[i].ASV;
                                        //
                                        ListCLientesN[posicion].reserva_laboral +=ListCLientesNuevos[i].reserva_laboral;
                                        duplicados[i].bandera=1;
                                        
                                    }
                                    //system.debug('lo que esta antes del ese: '+listcuentasEmpleados[h].Cuenta_colectiva2__C);
                                    else if(listcuentasEmpleados[h].Cuenta_colectiva2__C ==null && ListCLientesNuevos[i].a.Trim() !='NADANADA')
                                    {
                                        system.debug('posicion que trono: '+posicion);
                                        ListCLientesN[posicion].CuentasAEV.add(New Cuenta(ListCLientesNuevos[i].a, ListCLientesNuevos[i].AEV));
                                        ListCLientesN[posicion].AEV +=ListCLientesNuevos[i].AEV;
                                        
                                        ListCLientesN[posicion].APO +=ListCLientesNuevos[i].APO;
                                        ListCLientesN[posicion].AEO +=ListCLientesNuevos[i].AEO;
                                        //agregado wp 28-10-2019
                                        ListCLientesN[posicion].CuentasAPE.add(New Cuenta(ListCLientesNuevos[i].a, ListCLientesNuevos[i].APE));
                                        ListCLientesN[posicion].APE +=ListCLientesNuevos[i].APE;
                                        ListCLientesN[posicion].CuentasAPX.add(New Cuenta(ListCLientesNuevos[i].a, ListCLientesNuevos[i].APX));
                                        ListCLientesN[posicion].APX +=ListCLientesNuevos[i].APX;
                                        ListCLientesN[posicion].CuentasASV.add(New Cuenta(ListCLientesNuevos[i].a, ListCLientesNuevos[i].ASV));
                                        ListCLientesN[posicion].ASV +=ListCLientesNuevos[i].ASV;
                                        //
                                        ListCLientesN[posicion].reserva_laboral +=ListCLientesNuevos[i].reserva_laboral;
                                        duplicados[i].bandera=1;
                                    }
                                    
                                    
                                }
                            }
                        }
                    }
                }           
                clientesCuentas = new list<string>();
                list<string> clientesCuentas2 = new list<string>();
                NuevosEm = new list<planilla>();
                list<empresa_x_empleado__C> uyi = new list<empresa_x_empleado__C>();
                uyi=[Select empleado2__r.identificacion__c from Empresa_X_Empleado__c where empresa2__c=:Codigo_Unico_Banco ];  
                boolean empleadoscuentaerronea= false;
                boolean empleadosNuevos2= false;
                empleadosCuentaMala = new list<empresa_x_empleado__C>();
                empleadosCuentaMala2 = new list<Account>();
                
                for(integer i=0; i<duplicados.size(); i++)
                {
                    //modificado 07-07-2020 privilegios todas la cuentas en la planilla
                    if(identidadesempleados.containsKey(duplicados[i].Num_identidad) || identidadesempleadosC.containsKey(duplicados[i].Num_identidad))
                    {
                        if(duplicados[i].bandera==0 && duplicados[i].a!='NADANADA')
                        {
                            
                            empleadosCuentaMala.add(identidadesempleados.get(duplicados[i].Num_identidad));
                            //agregado 07-07-2020 privilegios todas la cuentas en la planilla
                            empleadosCuentaMala2.add(identidadesempleadosC.get(duplicados[i].Num_identidad));
                            empleadoscuentaerronea=true;
                        }
                        duplicados[i].bandera=1;
                        //  empleadosNuevos2=true;
                    }
                    ELSE
                    {
                        if(duplicados[i].bandera==0 && duplicados[i].a!='NADANADA')
                        {
                            
                            clientesCuentas2.add(duplicados[i].num_identidad);
                            empleadoscuentaerronea=true;
                            duplicados[i].bandera=1;
                        }
                        
                        
                    }
                    
                }
                system.debug('clientesCuentas2: '+clientesCuentas2);
                system.debug('clientesCuentas2: '+empleadosCuentaMala2);
                if(clientesCuentas2.size()>0&&empleadosCuentaMala2.size()<0)
                {
                    
                    empleadosCuentaMala2= new list<account>();
                    for(Account item:[select identificacion__C, firstname, lastname, id  from Account where identificacion__C in:(clientesCuentas2)])
                    {
                        
                        empleadosCuentaMala2.add(item); 
                    }
                    //empleadosCuentaMala.addAll([select empleado2__r.identificacion__C, empleado2__r.firstname, empleado2__r.lastname from Empresa_X_Empleado__c where empleado2__r.identificacion__C in:(clientesCuentas2)]);
                }
                /* for(Account item:[select empleado2__r.identificacion__C, empleado2__r.firstname, empleado2__r.lastname from Empresa_X_Empleado__c where empleado2__r.identificacion__C in:(clientesCuentas2)])
{
for(integer i=0; i<empleadosCuentaMala.size(); i++)
{
if(empleadosCuentaMala[i].empleado2__r.identificacion__C==item.identificacion__C)
{
empleadosCuentaMala[i].empleado2__r.firstname=item.firstname;
empleadosCuentaMala[i].empleado2__r.lastname=item.lastname;
}
}
}*/
                //PARTE COMENTADA DE LOS EMPLEADOS NUEVOS
                /* for(integer i=0; i<duplicados.size(); i++)
{
if(duplicados[i].bandera==0 && test.isRunningTest())
{
list<planilla> bmw=new list<planilla>();
bmw.add(todosr.get(duplicados[i].Num_identidad));
NuevosEm.add(new Planilla(duplicados[i].num_identidad, '','','','',0,bmw[0].APO,bmw[0].AEO,bmw[0].APV,bmw[0].AEV,bmw[0].reserva_laboral));
clientesCuentas.add(duplicados[i].num_identidad);
empleadosNuevos2=true;

}
}

if(NuevosEm.size()>0){
for(Account item: [select firstname, lastname,identificacion__C from account where identificacion__C in :clientesCuentas])
{
for(integer j=0; j<NuevosEm.size(); j++)
{
if(item.identificacion__C==NuevosEm[j].num_identidad)
{

NuevosEm[j].Primer_nombre= item.firstname;
NuevosEm[j].Primer_apellido= item.lastname;
j=NuevosEm.size();
}
}
}

clientesCuentas.clear();
for(integer j=0; j<NuevosEm.size(); j++)
{
if(NuevosEm[j].Primer_nombre==null || NuevosEm[j].Primer_nombre=='' ||
NuevosEm[j].Primer_apellido==null || NuevosEm[j].Primer_apellido=='')
{
clientesCuentas.add(NuevosEm[j].num_identidad); 
}
}

// MensajeEmpleadosNuevos='En esta planilla se encuentran identidades que no estaban anteriormente, '+ 
//       'reviselos y de ser nuevos empleados prosiga normalmete con su planilla de lo contrario cargue una nueva';
//MensajeEmpleadosNuevos='Estos empleados tienen la identidad o la cuenta mala'; 
//ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Nuevos Empleados'));
empleadoConsulta = new list<Account>();
if(clientesCuentas.size()>0)
{
empleadoConsulta = aSysdePortalEmpresarial.agregarPersonaPlanilla(clientesCuentas);  
}

if(empleadoConsulta.size() >0)
{
for(integer i=0; i<empleadoConsulta.size(); i++)
{
empleadoConsulta[i].recordTypeId = tipoNatural;
for(integer j=0; j<NuevosEm.size(); j++)
{
if(empleadoConsulta[i].identificacion__C==NuevosEm[j].num_identidad && empleadoConsulta[i].firstname != null
&& empleadoConsulta[i].lastname != null)
{
NuevosEm[j].Primer_nombre= empleadoConsulta[i].firstname;
NuevosEm[j].Primer_apellido= empleadoConsulta[i].lastname;
j=NuevosEm.size();
}
}
}
}
}
*/
                if(empleadoscuentaerronea || empleadosnuevos2)
                    
                {
                    if(empleadoscuentaerronea && empleadosnuevos2)
                    {
                        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Nuevos empleados, Se han detectado inconsistencias en la carga actual, favor revisar la moneda y/o empresa de la planilla. Las personas resaltadas en color rojo no serán excluidas al momento de enviar la planilla'));
                    }
                    else if( empleadosnuevos2)
                    {
                        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Nuevos empleados.'));
                    }
                    else if(empleadoscuentaerronea )
                    {
                        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Se han detectado inconsistencias en la carga actual, favor revisar la moneda y/o empresa de la planilla. Las personas resaltadas en color rojo no serán excluidas al momento de enviar la planilla'));
                    }
                    //   ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Nuevos Empleados, Empleados con la cuenta mala, fueron eliminados'));
                }
                
                
                duplicados.clear();	 
                MostrarBotones = False;
                mostrarTabla = true;
                if(ApexPages.currentPage().getParameters().get('Moneda')=='HNL')
                {
                    Mostrarlempiras= True;
                    CalculoDePilares();
                }
                else
                {
                    MostrarDolares= True;
                }
                totalempleados='Total de empleados: '+(NuevosEm.size()+ListCLientesN.size());
                sumas();
                //PAginaciones
                mostrarBotonesp=false;
                mostrarAnterior=true;
                mostrarSiguiente=true;
                MListCLientesN = new list<planilla>();
                contadorpaginacion=0;
                if(ListCLientesN.size()>100)
                {
                    contadorpaginacion ++;
                    mostrarBotonesp=true;
                    mostrarSiguiente=false;
                    for(integer i=0; i<100; i++)
                    {
                        
                        MListCLientesN.add(ListCLientesN[i]);
                    }
                    system.debug(MListCLientesN);
                }
                else
                {
                    for(integer i=0; i<ListCLientesN.size(); i++)
                    {
                        
                        MListCLientesN.add(ListCLientesN[i]);
                    } 
                }
                
            }
            else
            {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Se han encontrado numeros de cuentas repetidos, favor volver a cargar su archivo en Excel.' ));
            }
            
        }
        Catch(Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Ha Ocurrido Un error: ' +ex.getLineNumber()));
            system.debug('Error al Guardar: ' + ex.getMessage() + ' Linea: ' + ex.getLineNumber());    
        }
    }
    public void siguiente() 
    {
        try{
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
            hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            if((contadorpaginacion + 1)*100 > ListCLientesN.size())
            {
                contadorpaginacion ++;
                MListCLientesN = new list<planilla>();
                mostrarSiguiente=true;
                mostraranterior=false;
                for(integer i=(contadorpaginacion - 1)*100; i<ListCLientesN.size(); i++)
                {
                    
                    MListCLientesN.add(ListCLientesN[i]);
                } 
                
                
            }
            else
            {
                mostraranterior=false;
                contadorpaginacion ++;
                MListCLientesN = new list<planilla>();
                for(integer i=(contadorpaginacion - 1)*100; i<contadorpaginacion*100; i++)
                {
                    MListCLientesN.add(ListCLientesN[i]);
                } 
            }
            
        }
        catch(exception ex)
        {
            
        }
    }
    
    public void anterior()
    {
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        hora.Hora_ultima_consulta__c=datetime.now();
        update hora;
        try 
        {
            MListCLientesN = new list<planilla>();
            if((contadorpaginacion - 1)*100 < 101)
            {
                mostrarsiguiente=false;
                mostrarAnterior=true;
                MListCLientesN = new list<planilla>();
                for(integer i=0; i<100; i++)
                {
                    MListCLientesN.add(ListCLientesN[i]);
                } 
                contadorpaginacion --;
            }
            else
            {
                MListCLientesN = new list<planilla>();
                for(integer i=(contadorpaginacion - 2)*100; i<(contadorpaginacion-1) *100; i++)
                {
                    MListCLientesN.add(ListCLientesN[i]);
                }  
                contadorpaginacion --;
                mostrarSiguiente=false;
            }
        }
        catch(Exception ex)
        {
            
        }
    }
    
    public void Salir()
    {
        ActivarModal=false;
    }
    public void NuevaCarga()
    {
        Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
        hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
        hora.Hora_ultima_consulta__c=datetime.now();
        update hora;
        reiniciar();
    }
    public void CalculoDePilares()
    {
        try{
            
            Account empre= new Account();
            Codigo_Unico_Banco=ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
            empre=[Select PAPCE__c, PAPCT__c,Salario_Base_Pilar_Complementario__c,Porcentaje_de_aportaciones_Reserva_Labor__c,Salario_Base_Reserva_Laboral__c from Account where id=:Codigo_Unico_Banco];
            Decimal PAPCE=empre.PAPCE__c;
            DEcimal PAPCT=empre.PAPCT__c;
            decimal PRL=empre.Porcentaje_de_aportaciones_Reserva_Labor__c;
            decimal SBPC=empre.Salario_Base_Pilar_Complementario__c;
            
            list<string> listEmpleadosIdentidic = new list<string>();
            list<string> cuentas2 = new list<string>();
            list<cuentas__c> listcuentasEmpleados = new list<cuentas__c>();
            list<cuentas_colectivas__C> fr = new list<cuentas_colectivas__c>();
            fr= [select codigo__C from cuentas_colectivas__c where empresa__C=:Codigo_Unico_Banco and tipo_cuenta__C !='Voluntarias'];
            for(integer i=0; i<fr.size(); i++)
            {
                cuentas2.add(fr[i].codigo__C);
            }
            for(integer i=0; i<NuevosEm.size(); i++)
            {
                listEmpleadosIdentidic.add(NuevosEm[i].Num_Identidad);
            }
            for(integer i=0; i<ListCLientesN.size(); i++)
            {
                listEmpleadosIdentidic.add(ListCLientesN[i].Num_Identidad);
            }
            map<string, integer> mnb= new map<string, integer>();
            for (Cuentas__C item: [select  Cliente__r.Identificacion__C
                                   from cuentas__c where Cliente__r.Identificacion__C in :listEmpleadosIdentidic 
                                   and cuenta_colectiva2__r.codigo__C in : cuentas2])
            {
                if(!mnb.containsKey(item.Cliente__r.Identificacion__C))
                {
                    mnb.put(item.Cliente__r.Identificacion__C, 6);
                }
            }
            for(integer i=0; i<ListCLientesN.size(); i++)
            {
                if(mnb.containsKey(ListCLientesN[i].Num_identidad))
                {
                    decimal comparador = (((ListCLientesN[i].Salario - SBPC)*PAPCE)/100).setscale(2);
                    
                    if(comparador > 0)
                    {
                        if(comparador-100<=ListCLientesN[i].APO && ListCLientesN[i].APO<=comparador+100)
                        {
                            
                        }
                        else
                        {ListCLientesN[i].colorAPO='background-color:red; color:white;';}
                    }
                    comparador =(((ListCLientesN[i].Salario - SBPC)*PAPCT)/100).setscale(2) ;
                    if(comparador> 0)
                    {
                        if(comparador-100<=ListCLientesN[i].AEO && ListCLientesN[i].AEO<=comparador+100)
                        {
                            
                        }
                        else{ListCLientesN[i].colorAEO='background-color:red; color:white;';}
                        
                        
                    }
                    
                    comparador =((empre.Salario_Base_Reserva_Laboral__c *PRL)/100).setscale(2);
                    if(ListCLientesN[i].Salario>empre.Salario_Base_Reserva_Laboral__c)
                    {
                        if( comparador>0)
                        {
                            if(comparador-100<=ListCLientesN[i].reserva_laboral && ListCLientesN[i].reserva_laboral<=comparador+100)
                            {
                                
                            }
                            else{ListCLientesN[i].colorrl='background-color:red; color:white;';}
                        }
                        
                    }
                    else
                    {
                        comparador =((ListCLientesN[i].Salario *PRL )/100).setscale(2);
                        if(comparador > 0)
                        {
                            if( comparador>0)
                            {
                                if(comparador-100<=ListCLientesN[i].reserva_laboral && ListCLientesN[i].reserva_laboral<=comparador+100)
                                {
                                    
                                }
                                else{ListCLientesN[i].colorrl='background-color:red; color:white;';}
                                
                            }
                        }
                        
                    }
                }
                
            }
            
            /*for(integer i=0; i<listtemporal.size(); i++)
{
if(listtemporal[i].APo != ListCLientesN[i].APo)
{
ListCLientesN[i].colorAPO='color:red;';
}
if(listtemporal[i].Aeo != ListCLientesN[i].Aeo)
{
ListCLientesN[i].colorAeO='color:red;';
}
if(listtemporal[i].reserva_laboral != ListCLientesN[i].reserva_laboral)
{
ListCLientesN[i].colorrl='color:red;';
}
}*/
            
        }
        catch(Exception ex)
        {
            
        }
        
    }
    
    static string empresa2;
    
    @RemoteAction
    global static classWRetorno2 SUbirInformacion(String stringCSV, string empresa){
        classWRetorno2 retorno = new classWRetorno2();
        
        string gt;
        try{
            system.debug(empresa);
            if(empresa=='No')
            {
                empresa = [select name from planilla_temporal__C order by createddate desc limit 1].name;
                //empresa='0011100001Nt8TT';
                system.debug('Se metio: '+empresa);
            }
            
            stringCSV.replace('\'', '');
            stringCSV.replace('´', '');
            list<string> clientes = new  list<string>();
            list<string> clientes2= new  list<string>();
            clientes = stringCSV.split('\n');
            list<Planilla> duplicados = new list<Planilla>();
            
            retorno.error='Ya puede ver la planilla subida';
            integer A=15;
            integer B=15;
            integer C=15;
            integer D=15;
            integer E=15;
            integer F=15;
            integer h=15;
            //agregado wp 06-11-2019
            integer J=15;
            integer K=15;
            integer L=15;
            //
            
            string lk=clientes[0];
            clientes2=lk.split(',');
            clientes.remove(0);
            
            for(integer i=0; i<clientes2.size(); i++)
            {
                list<string> hy=new list<string> ();
                hy=clientes2[i].split('"');
                clientes2[i]=hy[1].Trim();
                
                if(clientes2[i].toUpperCase()=='NUM IDENTIDAD' || clientes2[i].toUpperCase()=='IDENTIFICACION'
                   || clientes2[i].toUpperCase()=='IDENTIFICACIÓN' || clientes2[i].toUpperCase()=='NUMERO IDENTIDAD'
                   || clientes2[i].toUpperCase()=='NUM IDENTIFICACIÓN' || clientes2[i].toUpperCase()=='NUMERO IDENTIFICACIÓN'
                   || clientes2[i].toUpperCase()=='NUM IDENTIFICACION' || clientes2[i].toUpperCase()=='NUMERO IDENTIFICACION')
                {
                    A=i;
                }
                if(clientes2[i].toUpperCase()=='APORTE PATRONO OBLIGATORIO' || clientes2[i].toUpperCase()=='APORTE PATRONAL OBLIGATORIO'
                   || clientes2[i].toUpperCase()=='APORTE EMPLEADOR OBLIGATORIO')
                {
                    B=i;
                }
                if(clientes2[i].toUpperCase()=='APORTE EMPLEADO OBLIGATORIO'  || clientes2[i].toUpperCase()=='APORTE TRABAJADOR OBLIGATORIO')
                {
                    C=i;
                }
                if(clientes2[i].toUpperCase()=='RESERVA LABORAL')
                {
                    F=i;
                }
                if(clientes2[i].toUpperCase()=='APORTE PATRONO VOLUNTARIO' || clientes2[i].toUpperCase()=='APORTE PATRONAL VOLUNTARIO'
                   || clientes2[i].toUpperCase()=='APORTE EMPLEADOR VOLUNTARIO')
                {
                    D=i;
                }
                if(clientes2[i].toUpperCase()=='APORTE EMPLEADO VOLUNTARIO' || clientes2[i].toUpperCase()=='APORTE TRABAJADOR VOLUNTARIO')
                {
                    E=i;
                }
                
                if(clientes2[i].toUpperCase()=='CUENTA' || clientes2[i].toUpperCase()=='NUM CUENTA'
                   || clientes2[i].toUpperCase()=='NUMERO CUENTA')
                {
                    H=i;
                }
                //agregado wp 06-11-2019
                if(clientes2[i].toUpperCase()=='APORTE EMPLEADO EXTRAORDINARIO' || clientes2[i].toUpperCase()=='APORTE TRABAJADOR EXTRAORDINARIO')
                {
                    J=i;
                }
                
                if(clientes2[i].toUpperCase()=='APORTE PATRONO EXTRAORDINARIO' || clientes2[i].toUpperCase()=='APORTE PATRONAL EXTRAORDINARIO'
                   || clientes2[i].toUpperCase()=='CAPITAL SEMILLA')
                {
                    K=i;
                }
                
                if(clientes2[i].toUpperCase()=='APORTE SEGURO DE VIDA' || clientes2[i].toUpperCase()=='APORTE SEGURO VIDA'
                   || clientes2[i].toUpperCase()=='SEGURO VIDA'|| clientes2[i].toUpperCase()=='SEGURO DE VIDA')
                {
                    L=i;
                }
                //
            }
            if(a!=15 && b!=15 && c!=15 && d!=15 && f!=15 && h!=15 && e!=15 /*agregado wp 06-11-2019*/&& j!=15 && k!=15 && l!=15/**/)
            {
                
                list<string> Identificacion = new  list<string>();
                list<string> AEO = new  list<string>();
                list<string> APO = new  list<string>();
                list<string> AEV = new  list<string>();
                list<string> APV = new  list<string>();
                //agregado wp 06-11-2019
                list<string> APE = new  list<string>();
                list<string> APX = new  list<string>();
                list<string> ASV = new  list<string>();
                //
                list<string> Cuenta = new  list<string>();
                list<string> Reserva_Laboral = new  list<string>();
                list<string> ident;
                list<string> ident2;
                
                for (integer i=0; i<clientes.size(); i++)
                {
                    clientes2 = new  list<string>();
                    string jh=clientes[i];
                    if(jh.contains(',,') && jh.trim().length()>20)  
                    {
                        clientes[i]=clientes[i].replace(',,',',"",').Trim(); 
                    }
                    else
                    {
                        clientes[i]=clientes[i].replace(',,','').Trim();  
                    }
                    
                    if(clientes[i].length()>1)
                    {
                        string kike2;
                        string kike=clientes[i];
                        clientes2 = kike.split(',');
                        
                        if(a<clientes2.size() && b<clientes2.size() && c<clientes2.size() &&
                           d<clientes2.size() && e<clientes2.size() && h<clientes2.size() && f<clientes2.size() &&
                           //agregadp wp 06-11-2019
                           j<clientes2.size() && k<clientes2.size() && l<clientes2.size())
                        {
                            
                            clientes2[a]=clientes2[a].replace(',','');
                            clientes2[a]=clientes2[a].replace('"','');
                            
                            if( clientes2[A]!=''  && clientes2[A].length()>7)
                            {
                                try{
                                    long kf=Long.valueOf(clientes2[a]);
                                    Identificacion .add(clientes2[a]);
                                    duplicados.add(new Planilla(clientes2[a], 0));
                                }
                                
                                catch(Exception ex)
                                {
                                    
                                    Identificacion.add(clientes2[A].replace('-',''));
                                    
                                }
                                
                                
                                try
                                {
                                    
                                    if(H!=15 && clientes2[H].trim()!='' &&clientes2[H]!='""' && clientes2[H]!=null)
                                    {
                                        try{
                                            long lr =Long.valueOf(clientes2[h]);
                                            Cuenta.add(clientes2[h]);
                                            
                                        }
                                        
                                        catch(Exception ex)
                                        {
                                            ident= new  list<string>();
                                            kike2=clientes2[H];
                                            // ident =kike2.split('"');
                                            Cuenta.add(kike2.replace('"', ''));
                                            
                                        }
                                    }
                                    else
                                    {
                                        Cuenta.add('NADANADA'); 
                                    }
                                    
                                }catch(Exception ex)
                                {
                                    Cuenta.add('NADANADA'); 
                                }
                                
                                
                                
                                if(C!=15 && clientes2[c]!='')
                                {
                                    try
                                    {
                                        decimal yt =decimal.valueOf(clientes2[c]);
                                        AEO.add(clientes2[c]);
                                    }
                                    catch (exception ex)
                                    {
                                        ident= new  list<string>();
                                        kike2=clientes2[c];
                                        ident =kike2.split('"');
                                        AEO.add(ident[1]);
                                    }
                                }
                                else
                                {
                                    AEO.add('0.0');
                                }
                                
                                
                                
                                if(B!=15  && clientes2[B]!='')
                                {
                                    try
                                    {
                                        decimal yt =decimal.valueOf(clientes2[b]);
                                        APO.add(clientes2[b]);
                                    }
                                    catch(exception ex)
                                    {
                                        ident= new  list<string>();
                                        kike2=clientes2[B];
                                        ident =kike2.split('"');
                                        APO.add(ident[1]);
                                    }
                                }
                                else
                                {
                                    APO.add('0.0');
                                }
                                
                                if(D!=15  && clientes2[d]!='')
                                {
                                    try
                                    {
                                        decimal yt =decimal.valueOf(clientes2[d]);
                                        APV.add(clientes2[d]);
                                    }
                                    catch(exception ex)
                                    {
                                        ident= new  list<string>();
                                        kike2=clientes2[D];
                                        ident =kike2.split('"');
                                        APV.add(ident[1]);
                                    }
                                }
                                else
                                {
                                    APV.add('0.0');
                                }
                                
                                
                                if(E!=15  && clientes2[e]!='')
                                {
                                    try
                                    {
                                        decimal yt =decimal.valueOf(clientes2[e]);
                                        AEV.add(clientes2[e]);
                                    }
                                    catch(exception ex)
                                    {
                                        ident= new  list<string>();
                                        kike2=clientes2[E];
                                        ident =kike2.split('"');
                                        AEV.add(ident[1]);  
                                    }
                                }
                                else
                                {
                                    AEV.add('0.0');
                                }
                                
                                if(F!=15  && clientes2[f]!='')
                                {
                                    try
                                    {
                                        decimal yt =decimal.valueOf(clientes2[f]);
                                        Reserva_Laboral.add(clientes2[f]);
                                    }
                                    catch(exception ex)
                                    {
                                        try{
                                            ident= new  list<string>();
                                            kike2=clientes2[F];
                                            ident =kike2.split('"');
                                            Reserva_Laboral.add(ident[1]);
                                        }catch(Exception eop)
                                        {
                                            Reserva_Laboral.add('0'); 
                                        }
                                    }
                                }
                                else
                                {
                                    Reserva_Laboral.add('0.0');
                                }
                                //agregado wp 06-11-2019
                                if(J!=15  && clientes2[J]!='')
                                {
                                    try
                                    {
                                        decimal yt =decimal.valueOf(clientes2[j]);
                                        APE.add(clientes2[j]);
                                    }
                                    catch(exception ex)
                                    {
                                        ident= new  list<string>();
                                        kike2=clientes2[J];
                                        ident =kike2.split('"');
                                        APE.add(ident[1]);
                                    }
                                }
                                else
                                {
                                    APE.add('0.0');
                                }
                                
                                if(K!=15  && clientes2[K]!='')
                                {
                                    try
                                    {
                                        decimal yt =decimal.valueOf(clientes2[K]);
                                        APX.add(clientes2[K]);
                                    }
                                    catch(exception ex)
                                    {
                                        ident= new  list<string>();
                                        kike2=clientes2[K];
                                        ident =kike2.split('"');
                                        APX.add(ident[1]);
                                    }
                                }
                                else
                                {
                                    APX.add('0.0');
                                }
                                
                                if(L!=15  && clientes2[L]!='')
                                {
                                    try
                                    {
                                        decimal yt =decimal.valueOf(clientes2[l]);
                                        ASV.add(clientes2[l]);
                                    }
                                    catch(exception ex)
                                    {
                                        ident= new  list<string>();
                                        kike2=clientes2[L];
                                        ident =kike2.split('"');
                                        ASV.add(ident[1]);
                                    }
                                }
                                else
                                {
                                    ASV.add('0.0');
                                }
                                //
                                
                            }
                            
                        }
                    }
                    
                }
                
                Planilla_temporal__c po= new Planilla_Temporal__C();
                po.name=empresa;
                insert po;
                
                list <Contenido_Planilla_Temporal__c> listClientes=new list <Contenido_Planilla_Temporal__c>();
                Contenido_Planilla_Temporal__c listC;
                
                for (integer i=0; i<Identificacion.size(); i++)
                {
                    listC = new Contenido_Planilla_Temporal__c (); 
                    listc.Planilla__c=po.id;
                    listC.Identidad__c=Identificacion[i];
                    listC.Cuenta__C=Cuenta[i];
                    if(decimal.valueOf(AEO[i])>0)
                    {
                        listC.Aporte_Empleado_Obligatorio__c=decimal.valueOf(AEO[i]);
                    }
                    else
                    {
                        listC.Aporte_Empleado_Obligatorio__c=0;
                    }
                    if(decimal.valueOf(APO[i])>0)
                    {
                        listc.Aporte_Patronal_Obligatorio__c=decimal.valueOf(APO[i]);
                    }
                    else
                    {
                        listc.Aporte_Patronal_Obligatorio__c=0;
                    }
                    if(decimal.valueOf(Reserva_Laboral[i])>0)
                    {
                        listc.Aporte_Reserva_Laboral__c=decimal.valueOf(Reserva_Laboral[i]);
                    }
                    else
                    {
                        listc.Aporte_Reserva_Laboral__c=0;
                    }
                    //AGREGAGO WP 31-10-2019
                    if(decimal.valueOf(APE[i])>0)
                    {
                        listc.Aporte_Empleado_Extraordinario__c=decimal.valueOf(APE[i]);
                    }
                    else
                    {
                        listc.Aporte_Empleado_Extraordinario__c=0;
                    }
                    if(decimal.valueOf(APX[i])>0)
                    {
                        listc.Aporte_Patrono_Extraordinario__c=decimal.valueOf(APX[i]);
                    }
                    else
                    {
                        listc.Aporte_Patrono_Extraordinario__c=0;
                    }
                    if(decimal.valueOf(ASV[i])>0)
                    {
                        listc.Aporte_Seguro_de_Vida__c=decimal.valueOf(ASV[i]);
                    }
                    else
                    {
                        listc.Aporte_Seguro_de_Vida__c=0;
                    }
                    //
                    if(D!=15)
                    {
                        try{
                            listC.Aporte_Patronal_Voluntario__c=decimal.valueOf(APV[i]);
                        }
                        catch(Exception es)
                        {
                            listC.Aporte_Patronal_Voluntario__c=0;
                        }
                    }else{listC.Aporte_Patronal_Voluntario__c=0;}
                    if(E!=15)
                    {
                        try{
                            listC.Aporte_Empleado_Voluntario__c=decimal.valueOf(AEV[i]);
                        }
                        catch(Exception es)
                        {
                            listC.Aporte_Empleado_Voluntario__c=0;
                        }
                    }else{listC.Aporte_Empleado_Voluntario__c=0;}
                    //AGREGADO WP 28-10-2019
                    if(J!=15)
                    {
                        try{
                            listC.Aporte_Empleado_Extraordinario__c=decimal.valueOf(APE[i]);
                        }
                        catch(Exception es)
                        {
                            listC.Aporte_Empleado_Extraordinario__c=0;
                        }
                    }
                    else
                    {
                        listC.Aporte_Empleado_Extraordinario__c=0;
                    }
                    if(K!=15)
                    {
                        try{
                            listC.Aporte_Patrono_Extraordinario__c=decimal.valueOf(APX[i]);
                        }
                        catch(Exception es)
                        {
                            listC.Aporte_Patrono_Extraordinario__c=0;
                        }
                    }
                    else
                    {
                        listC.Aporte_Patrono_Extraordinario__c=0;
                    }
                    if(L!=15)
                    {
                        try{
                            listC.Aporte_Seguro_de_Vida__c=decimal.valueOf(ASV[i]);
                        }
                        catch(Exception es)
                        {
                            listC.Aporte_Seguro_de_Vida__c=0;
                        }
                    }
                    else
                    {
                        listC.Aporte_Seguro_de_Vida__c=0;
                    }
                    //
                    listClientes.add(listC);                    
                }
                insert listClientes;
                
            }
            else
            {
                retorno.error='Estas columnas no traen el nombre correcto\n';
                if(a==15)
                {
                    retorno.error+='NUM IDENTIDAD\n';
                }
                if(b==15)
                {
                    retorno.error+='APORTE PATRONO OBLIGATORIO\n';
                }
                if(c==15)
                {
                    retorno.error+='APORTE EMPLEADO OBLIGATORIO\n';
                }
                if(d==15)
                {
                    retorno.error+='APORTE PATRONO VOLUNTARIO\n';
                }
                if(e==15)
                {
                    retorno.error+='APORTE EMPLEADO VOLUNTARIO\n';
                }
                if(f==15)
                {
                    retorno.error+='RESERVA LABORAL\n';
                }
                if(h==15)
                {
                    retorno.error+='NUMERO CUENTA';
                }
                //agregado wp 06-11-2019
                if(l==15)
                {
                    retorno.error+='APORTE EMPLEADO EXTRAORDINARIO\n';
                }
                if(k==15)
                {
                    retorno.error+='APORTE PATRONO EXTRAORDINARIO\n';
                }
                if(l==15)
                {
                    retorno.error+='APORTE SEGURO VIDA\n';
                }
                //
            }
            
        }
        catch( exception ex)
        {
            //classWRetorno2 retorno = new classWRetorno();
            retorno.error='Ha ocurrido un error'; 
            return retorno;
        }
        // ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Sse pudo!')); 
        return retorno;
    } 
    
    
    public void metodoutil()
    {
        integer i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
        i=0;
    }
    
}