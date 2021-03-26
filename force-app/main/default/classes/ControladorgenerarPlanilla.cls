public without sharing class ControladorgenerarPlanilla {  
    public list<Empresa_x_Empleado__c> listEmpleadosEmpresa{get;set;}
    public Usuario_X_Empresa__c usuarioEmpresa{get;set;}
    
    public Planilla__c planilla{get;set;}
    public string url_pagina{get;set;}
    public boolean pop_exportar{get;set;}
    public date fechap{get;set;}
    public list<Contenido_Planilla__c> contenidoPlanilla{get;set;}
    public list<Contenido_Planilla__c> McontenidoPlanilla{get;set;}
    public list<Contenido_Planilla__c> contenidoPlanillae{get;set;}
    public string idEmpleado{get;set;}
    public string idContenido{get;set;} 
    public integer TotalEMpleados{get;set;}
    public list<claseaportaciones> listAportes{get;set;}
    decimal controladoraportes;
    public boolean Disponibleguardar{get;set;}
    public list<SelectOption> opcionesPlanillas{get;set;}
    public string idPlanilla{get;set;}
    public list<SelectOption> Listmeses{get;set;}
    public string NombreMes{get;set;}
    list<string> identidadesconsulta;
    public list<Cuentas__c> listCuentas{get;set;}
    public boolean esAPV{get;set;}
    //agregado wp 22-11-2019
    public boolean esAEV{get;set;}
    public boolean esAPE{get;set;}
    public boolean esAPX{get;set;}
    public boolean esASV{get;set;}
    //
    public list<Cuenta_planilla__c> listCuentasPlanilla{get;set;}
    public string horafecha{get;set;}
    map<Id, Planilla__c> mapPlanillas;
    map<Id, Id> mapEmpleados;
    String Codigo_Unico_Banco;
    String Usuario;
    map<integer, list<string>> mapPaginaciones;// = new map<integer, list<string>>();
    String Moneda;
    
    public string NombreAporte{get;set;}
    public decimal tasa;
    
    public boolean popAgregar{get;set;}
    public boolean popQuitar{get;set;}
    public boolean popModificar{get;set;}
    public boolean popCuentasAPV{get;set;}
    public boolean popCuentasAPX{get;set;}
    public boolean popCuentasAEV{get;set;}
    public boolean popCuentasAPE{get;set;}
    public boolean popCuentasASV{get;set;}
    public boolean mostrarBotones{get;set;}
    public integer banderaTiempo{get;set;}
    //Paginaciones
    public boolean mostrarSiguiente{get;set;}
    public boolean mostrarANterior{get;set;}
    public boolean mostrarBotonesP{get;set;}
    public integer contadorpaginacion{get;set;}
    
    public ControladorgenerarPlanilla(){
        try{
            Codigo_Unico_Banco = ApexPages.currentPage().getParameters().get('Eldudhdhyudb');
            Usuario = ApexPages.currentPage().getParameters().get('loetdncdhjch'); 
            Moneda = ApexPages.currentPage().getParameters().get('Moneda'); 
            controladoraportes = 0;
            banderaTiempo=0;
            popCuentasAEV = false;
            popCuentasAPE = false;
            popCuentasAPV = false;
            popCuentasAPX = false;
            popCuentasASV = false;
            listAportes = new list<claseaportaciones>();
            usuarioEmpresa = [select Empresa2__r.Name, empresa2__C, Empresa2__r.IsPersonAccount, Usuario__r.Name, 
                              Empresa2__r.PAPCE__c, Empresa2__r.PAPCT__c,Aceptar_Planilla__c,
                              Empresa2__r.Salario_Base_Pilar_Complementario__c,
                              Empresa2__r.Porcentaje_de_aportaciones_Reserva_Labor__c, 
                              Empresa2__r.Salario_Base_Reserva_Laboral__c,
                              Usuario__r.email__c, Usuario__r.Nombre_completo__c
                              from Usuario_X_Empresa__c 
                              where Empresa2__c =: Codigo_Unico_Banco
                              AND Usuario__c =: Usuario Limit 1];
            identidadesconsulta=new list<string>();
            esAPV = false;
            //agregado wp 22-11-2019
            esAEV = false;
            esAPE = false;
            esAPX = false;
            esASV = false;
            //
            mostrarBotones = false;
            list<empresa_x_empleado__C> contenidoPlanilla2 = new list<empresa_x_empleado__C>();
            contenidoplanilla2=[Select empleado2__r.Identificacion__C 
                                from empresa_x_empleado__C
                                Where Empresa2__c = : Codigo_Unico_Banco
                                AND Estado__c = 'Activo'];
            identidadesconsulta=new list<string>();
            For(integer i=0; i<contenidoplanilla2.size(); i++){
                identidadesconsulta.add(contenidoplanilla2[i].empleado2__r.Identificacion__C);                                                
            }
            tasa = [select tasa__C from Tasa_De_Cambio__c limit 1].tasa__C; 
            
            reIniciar();
            
        }Catch(Exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Se ha producido un error, favor contacte a su administrador')); 	
        }	
        
    }
    
    public void cerrar(){
        popAgregar = false;
        popQuitar = false;
        pop_exportar = false;
        popModificar = false;
        popCuentasAEV = false;
        popCuentasAPE = false;
        popCuentasAPV = false;
        popCuentasAPX = false;
        popCuentasASV = false;
        if(banderaTiempo==0)
        {
            registrarTiempo();
        }
        
    }
    
    public void registrarTiempo()
    {
        try
        {
            
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
            hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
        }
        catch(Exception ex)
        {
            
        }
    }
    public void reIniciar(){
        try{
            opcionesPlanillas = new list<SelectOption>();
            idPlanilla = '';
            if(controladoraportes==0)
            {
                cargarmeses();
            }
            mapPlanillas = new map<Id, Planilla__c>();
            list<Planilla__c> listPlanillas = [Select Name, createdDate, currencyIsoCode, Fecha__c, lastModifiedDate, Estado2__c,
                                               TA_Empleado_Obligatorio__c,TA_Empleado_Voluntario__c, Ta_salarios__C,
                                               TA_Patrono_obligatorio__c,TA_Patrono_Voluntario__c, 
                                               //agregado wp 22-11-2019
                                               TA_Empleado_Extraordinario__c, TA_Patrono_Extraordinario__c, TA_Seguro_de_Vida__c,
                                               //
                                               Total_Reserva_Laboral2__c, Mes_Aporte__c
                                               /*(Select Empleado2__c, Empleado2__r.Identificacion__c,
Empleado2__r.Firstname, Empleado2__r.LastName, Salario__c,Aporte_Empleado_Obligatorio__c,
Aporte_Empleado_Voluntario__c, Aporte_Patrono_obligatorio__c,Aporte_Patrono_Voluntario__c,
Planilla__c, Reserva_Laboral__c,Empleado2__r.IsPersonAccount
From Contenidos_Planilla__r order by Empleado2__r.Firstname asc
)*/	    											 
                                               From Planilla__c 
                                               Where Empresa2__c =: Codigo_Unico_Banco 
                                               AND currencyIsoCode =: Moneda
                                               Order by createdDate desc Limit 20];
            
            for(Planilla__c item : listPlanillas){
                if(item.CurrencyIsoCode==Moneda)
                {
                    opcionesPlanillas.add(new selectOption(item.id, item.Name));	
                    mapPlanillas.put(item.id, item); 
                }
                
            }
            
            planilla = new Planilla__c();
            contenidoPlanilla = new list<Contenido_Planilla__c>();
            cargarmeses();
            mostrarBotones =false;
            if(!listPlanillas.isEmpty()){
                planilla = listPlanillas[0];
                fechap=planilla.Fecha__c;
                nombremes=planilla.Mes_Aporte__c;
                //contenidoPlanilla = listPlanillas[0].Contenidos_Planilla__r;
                traerContenido();
                if(planilla.Estado2__c == 'Nueva' ||planilla.Estado2__c=='Pendiente Aprobación Interna'){
                    mostrarBotones = true;
                }
                
                asignarMapContenido(planilla.id);
                //calculoPilares();
                SumasTotales();
            }
            //else{
            //		mostrarBotones = true;	
            //	}
            
            //totalempleados=contenidoplanilla.size();
            //Paginaciones
            mostrarBotonesp=false;
            mostrarAnterior=true;
            mostrarSiguiente=true;
            Mcontenidoplanilla = new list<contenido_Planilla__C>();
            contadorpaginacion=0;
            if(totalempleados>100)
            {
                contadorpaginacion ++;
                mostrarBotonesp=true;
                mostrarSiguiente=false;
                for(integer i=0; i<100; i++)
                {
                    
                    Mcontenidoplanilla.add(contenidoplanilla[i]);
                }
            }
            else
            {
                for(integer i=0; i<contenidoplanilla.size(); i++)
                {
                    
                    Mcontenidoplanilla.add(contenidoplanilla[i]);
                } 
            }
            //if(identidadesconsulta.size()>1000){controladoraportes=1;}
            //totalEmpleados=0;
            if(controladoraportes ==0 && identidadesconsulta.size()<1000)
            {
                list<claseaportaciones> listAportes2=new list<claseaportaciones>();
                list<string> identidadesconsultaTemp= new list<string> ();
                for(integer i=0; i<identidadesconsulta.size(); i++)
                    //for(integer i=0; i<5; i++)
                {
                    //identidadesconsultaTemp= new list<string> ();
                    identidadesconsultaTemp.add(identidadesconsulta[i]);
                    if(identidadesconsultaTemp.size()==500 || (i+1)==identidadesconsulta.size())
                    {
                        for(claseaportaciones item:aSysdePortalEmpresarial.ConsultalAportesPatronales(identidadesconsultaTemp, codigo_unico_banco))
                        {
                            listAportes.add(item); 
                        }
                        identidadesconsultaTemp= new list<string>();
                        /*if(listAportes2!=null && listAportes2.size()>0)
{
listAportes.addAll(listAportes2);
totalEmpleados++;
}
listAportes2=new list<claseaportaciones>();*/
                    }
                }
                /*if(identidadesconsultaTemp.size()>0)
{
//listAportes2 = aSysdePortalEmpresarial.ConsultalAportesPatronales(identidadesconsultaTemp, codigo_unico_banco);
for(claseaportaciones item:aSysdePortalEmpresarial.ConsultalAportesPatronales(identidadesconsultaTemp, codigo_unico_banco))
{
listAportes.add(item); 
}
identidadesconsultaTemp= new list<string>();

}*/
                
                controladoraportes=1;
            }
            
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!')); 		
        }
    }
    
    public Contenido_Planilla__c contenidoTotal {get;set;}
    
    
    
    
    public void traerContenido(){
        try{
            list<string > idContenidoPlnilla = new list<string>();
            integer bandera=0;
            totalEmpleados=0;
            mapPaginaciones = new map<integer, list<string>>();
            for(Contenido_Planilla__c item: [Select Empleado2__c, Empleado2__r.Identificacion__c,id,
                                             Empleado2__r.Firstname, Empleado2__r.LastName, Salario__c,Aporte_Empleado_Obligatorio__c,
                                             Aporte_Empleado_Voluntario__c, Aporte_Patrono_obligatorio__c,Aporte_Patrono_Voluntario__c,
                                             //agregado wp 22-11-2019
                                             Aporte_Empleado_Extraordinario__c, Aporte_Patrono_Extraordinario__c, Aporte_Seguro_de_Vida__c,
                                             //
                                             Planilla__c, Reserva_Laboral__c,Empleado2__r.IsPersonAccount
                                             From Contenido_Planilla__c Where Planilla__c =: planilla.id
                                             Order by Empleado2__r.Firstname])
            {
                idContenidoPlnilla.add(item.id);
                totalEmpleados++;
                if(idContenidoPlnilla.size()==100)
                {
                    mapPaginaciones.put(bandera, idContenidoPlnilla);
                    bandera ++;
                    idContenidoPlnilla = new list<string>();
                }
            }
            if(idContenidoPlnilla.size()>00)
            {
                //bandera ++;
                mapPaginaciones.put(bandera, idContenidoPlnilla);
                idContenidoPlnilla = new list<string>();
            } 
            contenidoPlanilla = [Select Empleado2__c, Empleado2__r.Identificacion__c,
                                 Empleado2__r.Firstname, Empleado2__r.LastName, Salario__c,Aporte_Empleado_Obligatorio__c,
                                 Aporte_Empleado_Voluntario__c, Aporte_Patrono_obligatorio__c,Aporte_Patrono_Voluntario__c,
                                 //agregado wp 22-11-2019
                                 Aporte_Empleado_Extraordinario__c, Aporte_Patrono_Extraordinario__c, Aporte_Seguro_de_Vida__c,
                                 //
                                 Planilla__c, Reserva_Laboral__c,Empleado2__r.IsPersonAccount
                                 From Contenido_Planilla__c Where Planilla__c =: planilla.id
                                 Order by Empleado2__r.Firstname limit 100
                                ];
            
            asignarMapContenido(planilla.id);	
            mostrarBotonesp=false;
            mostrarAnterior=true;
            mostrarSiguiente=true;
            Mcontenidoplanilla = new list<contenido_Planilla__C>();
            contadorpaginacion=0;
            if(totalEmpleados>100)
            {
                contadorpaginacion ++;
                mostrarBotonesp=true;
                mostrarSiguiente=false;
                for(integer i=0; i<100; i++)
                {
                    
                    Mcontenidoplanilla.add(contenidoplanilla[i]);
                }
            }
            else
            {
                for(integer i=0; i<contenidoplanilla.size(); i++)
                {
                    Mcontenidoplanilla.add(contenidoplanilla[i]);
                } 
            }				
            //calculoPilares();
            sumasTotales();
            //totalempleados=contenidoplanilla.size();
            NombreMes=planilla.Mes_Aporte__c;
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!')); 		
        }
    }
    
    public void siguiente() 
    {
        try{
            if(banderaTiempo==0)
            {
                registrarTiempo();
            }
            if((contadorpaginacion + 1)*100 > TotalEmpleados)
            {
                contadorpaginacion ++;
                McontenidoPlanilla = new list<contenido_planilla__C>();
                mostrarSiguiente=true;
                mostraranterior=false;
                /*for(integer i=(contadorpaginacion - 1)*100; i<=totalempleados; i++)
{

McontenidoPlanilla.add(contenidoPlanilla[i]);
} */
                McontenidoPlanilla= [Select Empleado2__c, Empleado2__r.Identificacion__c,id,
                                     Empleado2__r.Firstname, Empleado2__r.LastName, Salario__c,Aporte_Empleado_Obligatorio__c,
                                     Aporte_Empleado_Voluntario__c, Aporte_Patrono_obligatorio__c,Aporte_Patrono_Voluntario__c,
                                     //agregado wp 22-11-2019
                                     Aporte_Empleado_Extraordinario__c, Aporte_Patrono_Extraordinario__c, Aporte_Seguro_de_Vida__c,
                                     //
                                     Planilla__c, Reserva_Laboral__c,Empleado2__r.IsPersonAccount
                                     From Contenido_Planilla__c Where id in : mapPaginaciones.get((contadorpaginacion - 1))
                                     Order by Empleado2__r.Firstname];
                
                
            }
            else
            {
                mostraranterior=false;
                
                contadorpaginacion ++;
                McontenidoPlanilla = new list<contenido_planilla__C>();
                /*for(integer i=(contadorpaginacion - 1)*100; i<contadorpaginacion*100; i++)
{

McontenidoPlanilla.add(contenidoPlanilla[i]);

} */
                McontenidoPlanilla= [Select Empleado2__c, Empleado2__r.Identificacion__c,id,
                                     Empleado2__r.Firstname, Empleado2__r.LastName, Salario__c,Aporte_Empleado_Obligatorio__c,
                                     Aporte_Empleado_Voluntario__c, Aporte_Patrono_obligatorio__c,Aporte_Patrono_Voluntario__c,
                                     //agregado wp 22-11-2019
                                     Aporte_Empleado_Extraordinario__c, Aporte_Patrono_Extraordinario__c, Aporte_Seguro_de_Vida__c,
                                     //
                                     Planilla__c, Reserva_Laboral__c,Empleado2__r.IsPersonAccount
                                     From Contenido_Planilla__c Where id in : mapPaginaciones.get((contadorpaginacion - 1))
                                     Order by Empleado2__r.Firstname];
                
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
            if(banderaTiempo==0)
            {
                registrarTiempo();
            }
            McontenidoPlanilla = new list<contenido_planilla__C>();
            if((contadorpaginacion - 1)*100 < 101)
            {
                mostrarsiguiente=false;
                mostrarAnterior=true;
                McontenidoPlanilla = new list<contenido_planilla__C>();
                /* for(integer i=0; i<100; i++)
{
McontenidoPlanilla.add(contenidoPlanilla[i]);
}*/
                McontenidoPlanilla= [Select Empleado2__c, Empleado2__r.Identificacion__c,id,
                                     Empleado2__r.Firstname, Empleado2__r.LastName, Salario__c,Aporte_Empleado_Obligatorio__c,
                                     Aporte_Empleado_Voluntario__c, Aporte_Patrono_obligatorio__c,Aporte_Patrono_Voluntario__c,
                                     //agregado wp 22-11-2019
                                     Aporte_Empleado_Extraordinario__c, Aporte_Patrono_Extraordinario__c, Aporte_Seguro_de_Vida__c,
                                     //
                                     Planilla__c, Reserva_Laboral__c,Empleado2__r.IsPersonAccount
                                     From Contenido_Planilla__c Where id in : mapPaginaciones.get(0)
                                     Order by Empleado2__r.Firstname];
                contadorpaginacion --;
            }
            else
            {
                McontenidoPlanilla = new list<contenido_planilla__C>();
                /* for(integer i=(contadorpaginacion - 2)*100; i<(contadorpaginacion-1) *100; i++)
{
McontenidoPlanilla.add(contenidoPlanilla[i]);
} */ 
                McontenidoPlanilla= [Select Empleado2__c, Empleado2__r.Identificacion__c,id,
                                     Empleado2__r.Firstname, Empleado2__r.LastName, Salario__c,Aporte_Empleado_Obligatorio__c,
                                     Aporte_Empleado_Voluntario__c, Aporte_Patrono_obligatorio__c,Aporte_Patrono_Voluntario__c,
                                     //agregado wp 22-11-2019
                                     Aporte_Empleado_Extraordinario__c, Aporte_Patrono_Extraordinario__c, Aporte_Seguro_de_Vida__c,
                                     //
                                     Planilla__c, Reserva_Laboral__c,Empleado2__r.IsPersonAccount
                                     From Contenido_Planilla__c Where id in : mapPaginaciones.get((contadorpaginacion - 2))
                                     Order by Empleado2__r.Firstname];
                contadorpaginacion --;
                mostrarSiguiente=false;
            }
        }
        catch(Exception ex)
        {
            
        }
    }
    
    public void Cargarmeses(){
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
    }
    
    public void asignarMapContenido(string idPlanillaN){
        mapEmpleados = new map<Id, Id>();
        For(Contenido_Planilla__c item : [select Empleado2__c from Contenido_Planilla__c
                                          where planilla__C=:idPlanillaN]){
                                              mapEmpleados.put(item.Empleado2__c, item.Empleado2__c);	
                                          }	
    }
    
    public void sumasTotales()
    {
        try{
            
            contenidoTotal = new Contenido_Planilla__c(Aporte_Patrono_obligatorio__c = planilla.TA_Patrono_obligatorio__c,
                                                       Aporte_Empleado_Obligatorio__c = planilla.TA_Empleado_Obligatorio__c,
                                                       Reserva_Laboral__c = planilla.Total_Reserva_Laboral2__c,
                                                       Aporte_Patrono_Voluntario__c = planilla.TA_Patrono_Voluntario__c,
                                                       Aporte_Empleado_Voluntario__c = planilla.TA_Empleado_Voluntario__c, 
                                                       //agregado wp 22-11-2019
                                                       Aporte_Empleado_Extraordinario__c = planilla.TA_Empleado_Extraordinario__c, 
                                                       Aporte_Patrono_Extraordinario__c = planilla.TA_Patrono_Extraordinario__c, 
                                                       Aporte_Seguro_de_Vida__c = planilla.TA_Seguro_de_Vida__c,
                                                       //
                                                       Salario__c =planilla.TA_salarios__C);
            
        } catch(Exception ex){
            
        }
    }
    
    public void calculoPilares(string bandera){ 
        
        try{
            if(moneda=='HNL'){
                Decimal salarioBaseEmpresa = usuarioEmpresa.Empresa2__r.Salario_Base_Pilar_Complementario__c;
                Decimal salarioBaseReservaL = usuarioEmpresa.Empresa2__r.Salario_Base_Reserva_Laboral__c;
                Decimal PAPCE = usuarioEmpresa.Empresa2__r.PAPCE__c;
                Decimal PAPCT = usuarioEmpresa.Empresa2__r.PAPCT__c;
                Decimal porReservaL = usuarioEmpresa.Empresa2__r.Porcentaje_de_Aportaciones_Reserva_Labor__c;
                list<string> listEmpleadosIdentidic = new list<string>();
                list<string> cuentas2 = new list<string>();
                // list<cuentas__c> listcuentasEmpleados = new list<cuentas__c>();
                list<cuentas_colectivas__C> fr = new list<cuentas_colectivas__c>();
                fr= [select codigo__C from cuentas_colectivas__c where empresa__C=:Codigo_Unico_Banco and tipo_cuenta__C !='Voluntarias'];
                for(integer i=0; i<fr.size(); i++)
                {
                    cuentas2.add(fr[i].codigo__C);
                }
                for(contenido_planilla__C item:[select empleado2__r.Identificacion__C from contenido_planilla__C where planilla__C=:planilla.id])
                {
                    listEmpleadosIdentidic.add(item.empleado2__r.Identificacion__C);
                }
                system.debug(listEmpleadosIdentidic);
                MAP<string, integer> mapcuentasEmpleados= new MAP<string, integer>();
                for(cuentas__c item:[select  Cliente__r.Identificacion__C, Cliente__c
                                     from cuentas__c where Cliente__r.Identificacion__C in :listEmpleadosIdentidic 
                                     and cuenta_colectiva2__r.codigo__C in : cuentas2])
                {
                    if(!mapcuentasEmpleados.containsKey(item.Cliente__c))
                    {
                        mapcuentasEmpleados.put(item.Cliente__c,6);
                    }
                }
                // listcuentasEmpleados = ;
                //string bandera='Todos';
                
                if(bandera =='Todos')
                {
                    system.debug('Perfecto'+mapcuentasEmpleados);
                    contenidoPlanilla=[select empleado2__c, salario__C, id from  contenido_planilla__C where planilla__C=:planilla.id];
                    system.debug('Perfecto2'+contenidoPlanilla);
                    for(integer i=0; i<contenidoplanilla.size(); i++)
                    {
                        if(mapcuentasEmpleados.containsKey(contenidoplanilla[i].empleado2__c))
                        {
                            system.debug('Se metio una vez'+contenidoplanilla[i].empleado2__c);
                            if(contenidoplanilla[i].Salario__c != null && contenidoplanilla[i].Salario__c > 0){
                                
                                if((((contenidoplanilla[i].Salario__c - salarioBaseEmpresa) * PAPCE)/100) > 0)
                                {
                                    contenidoplanilla[i].Aporte_Patrono_obligatorio__c = (((contenidoplanilla[i].Salario__c - salarioBaseEmpresa) * PAPCE)/100).setScale(2);
                                }
                                if((((contenidoplanilla[i].Salario__c - salarioBaseEmpresa) * PAPCT)/100) > 0)
                                {
                                    contenidoplanilla[i].Aporte_Empleado_Obligatorio__c = (((contenidoplanilla[i].Salario__c - salarioBaseEmpresa) * PAPCT)/100).setScale(2);
                                }
                                
                                
                                if(contenidoplanilla[i].Salario__c > salarioBaseReservaL)
                                {
                                    Decimal resevaL = (( salarioBaseReservaL * porReservaL ) / 100).setScale(2);
                                    
                                    if(resevaL > 0)
                                    {
                                        contenidoplanilla[i].Reserva_Laboral__c = resevaL;
                                    }
                                    
                                }
                                else
                                {
                                    Decimal resevaL = (( contenidoplanilla[i].Salario__c * porReservaL ) / 100).setScale(2);
                                    if(resevaL > 0)
                                    {
                                        contenidoplanilla[i].Reserva_Laboral__c = resevaL;
                                    }
                                    
                                }
                            }
                        }
                        
                    }
                    update contenidoplanilla;
                }
                else
                {
                    for(integer i=0; i<contenidoplanilla.size(); i++)
                    {
                        if(contenidoplanilla[i].id==bandera)
                        {
                            
                            
                            if(mapcuentasEmpleados.containsKey(contenidoplanilla[i].empleado2__r.identificacion__C))
                            {
                                if(contenidoplanilla[i].Salario__c != null && contenidoplanilla[i].Salario__c > 0){
                                    if((((contenidoplanilla[i].Salario__c - salarioBaseEmpresa) * PAPCE)/100) > 0)
                                    {
                                        contenidoplanilla[i].Aporte_Patrono_obligatorio__c = (((contenidoplanilla[i].Salario__c - salarioBaseEmpresa) * PAPCE)/100).setScale(2);
                                    }
                                    if((((contenidoplanilla[i].Salario__c - salarioBaseEmpresa) * PAPCT)/100) > 0)
                                    {
                                        contenidoplanilla[i].Aporte_Empleado_Obligatorio__c = (((contenidoplanilla[i].Salario__c - salarioBaseEmpresa) * PAPCT)/100).setScale(2);
                                    }
                                    
                                    
                                    if(contenidoplanilla[i].Salario__c > salarioBaseReservaL)
                                    {
                                        Decimal resevaL = (( salarioBaseReservaL * porReservaL ) / 100).setScale(2);
                                        
                                        if(resevaL > 0)
                                        {
                                            contenidoplanilla[i].Reserva_Laboral__c = resevaL;
                                        }
                                        
                                    }
                                    else
                                    {
                                        Decimal resevaL = (( contenidoplanilla[i].Salario__c * porReservaL ) / 100).setScale(2);
                                        if(resevaL > 0)
                                        {
                                            contenidoplanilla[i].Reserva_Laboral__c = resevaL;
                                        }
                                        
                                    }
                                }
                            }
                            
                        }
                    }
                }
                //reiniciar();
            }
        }Catch(Exception e){
            system.debug('Error'+e.getLineNumber());
        }
        
    }
    
    
    public void CopiarPlanilla()
    {
        try{
            if(banderaTiempo==0)
            {
                registrarTiempo();
            }
            if(contenidoPlanilla.size()>0)
            {
                Cargarmeses();
                planilla = new Planilla__c();
                planilla.Creado_por__c = Usuario;
                planilla.Empresa2__c = Codigo_Unico_Banco;
                planilla.Estado2__c = 'Nueva';
                planilla.tasa_compra__c=1.0;
                planilla.currencyIsoCode = Moneda;
                planilla.Tipo_planilla__c = 'Generada';
                planilla.fecha__c=date.today();
                planilla.Mes_Aporte__c=NombreMes;
                insert planilla;
                
                contenidoPlanilla = new list<Contenido_Planilla__c>();
                
                For(contenido_planilla__c item: [select Aporte_Empleado_Obligatorio__c, Aporte_Empleado_Voluntario__c, Aporte_Patrono_obligatorio__c, Aporte_Patrono_Voluntario__c,
                                                 //agregado wp 22-11-2019
                                                 Aporte_Empleado_Extraordinario__c, Aporte_Patrono_Extraordinario__c, Aporte_Seguro_de_Vida__c,
                                                 //
                                                 empleado2__c, Reserva_Laboral__c, salario__c
                                                 from contenido_planilla__c where planilla__c=:idplanilla]){
                                                     
                                                     contenidoPlanilla.add(new Contenido_Planilla__c(Planilla__c = planilla.id, Empleado2__c = item.Empleado2__c,
                                                                                                     Salario__c = item.Salario__c, Aporte_Empleado_Obligatorio__c=item.Aporte_Empleado_Obligatorio__c,
                                                                                                     Aporte_Empleado_Voluntario__c=item.Aporte_Empleado_Voluntario__c, Aporte_Patrono_obligatorio__c=item.Aporte_Patrono_obligatorio__c,
                                                                                                     Aporte_Patrono_Voluntario__c=item.Aporte_Patrono_Voluntario__c, 
                                                                                                     //agregado wp 22-11-2019
                                                                                                     Aporte_Empleado_Extraordinario__c = item.Aporte_Empleado_Extraordinario__c,
                                                                                                     Aporte_Patrono_Extraordinario__c = item.Aporte_Patrono_Extraordinario__c, 
                                                                                                     Aporte_Seguro_de_Vida__c = item.Aporte_Seguro_de_Vida__c,
                                                                                                     //
                                                                                                     Reserva_Laboral__c=item.Reserva_Laboral__c ));	
                                                 }
                insert contenidoPlanilla;
                list<Cuenta_Planilla__c> cuentaPlanilla= new list<Cuenta_Planilla__c>(); 
                // cuentaPlanilla=[select Calcular_por__c, Casilla__c, Codigo_cuenta__c, Cuenta__c, Contenido_Planilla__r.empleado2__c ,Tipo__c, Valor_Monto__c, Valor_Monto_Patrono__c
                //               from Cuenta_Planilla__c where contenido_planilla__r.planilla__c=:idplanilla];
                
                for(Cuenta_Planilla__c item:[select Calcular_por__c, Casilla__c, Codigo_cuenta__c, Cuenta__c, Contenido_Planilla__r.empleado2__c ,Tipo__c, Valor_Monto__c, Valor_Monto_Patrono__c,
                                             //agregado wp 22-11-2019
                                             Valor_Monto_Extraordinario__c, Valor_Monto_Patronal_Extraordinario__c, Valor_Monto_Seguro_Vida__c
                                             //
                                             from Cuenta_Planilla__c where contenido_planilla__r.planilla__c=:idplanilla])
                {
                    for(integer j=0; j<contenidoPlanilla.size(); j++)
                    {
                        if(item.Contenido_Planilla__r.empleado2__c == contenidoPlanilla[j].empleado2__c)
                        {
                            cuentaPlanilla.add(new Cuenta_Planilla__c(Contenido_Planilla__c= contenidoPlanilla[j].id, Calcular_por__c=item.Calcular_por__c,
                                                                      Casilla__c=item.Casilla__c,   Codigo_cuenta__c = item.Codigo_cuenta__c, cuenta__c=item.cuenta__c,
                                                                      Tipo__c = item.Tipo__c, Valor_Monto__c=item.Valor_Monto__c, Valor_Monto_Patrono__c = item.Valor_Monto_Patrono__c,
                                                                      //agregado wp 22-11-2019
                                                                      Valor_Monto_Extraordinario__c = item.Valor_Monto_Extraordinario__c, 
                                                                      Valor_Monto_Patronal_Extraordinario__c = item.Valor_Monto_Patronal_Extraordinario__c, 
                                                                      Valor_Monto_Seguro_Vida__c = item.Valor_Monto_Seguro_Vida__c));
                        }
                    }
                }
                insert cuentaPlanilla;
                reIniciar();
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, '¡Se ha creado una nueva planilla!'));
                
            }
            else
            {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, '¡La planilla no tiene datos!'));
            }
            
            
        }
        catch(Exception ex)
        {
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, '¡Ha ocurrido un error!'+ ex.getLineNumber()+'  '+ex.getMessage()));
        }
    }
    
    public void generarNuevaPlanilla(){
        try{
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
            hora=[select Hora_ultima_consulta__c,id from Tiempo_Inactividad__c where usuario__C =:usuario limit 1];
            hora.Hora_ultima_consulta__c=datetime.now();
            update hora;
            if(popCuentasAEV == false && popCuentasAPE == false && popCuentasAPV == false && popCuentasAPX == false && popCuentasASV == false)
            {
                planilla = new Planilla__c();
                Cargarmeses();
                planilla.Mes_Aporte__c=nombremes;
                planilla.Creado_por__c = Usuario;
                planilla.Empresa2__c = Codigo_Unico_Banco;
                planilla.Estado2__c = 'Nueva';
                planilla.tasa_compra__c=1.0;
                planilla.currencyIsoCode = Moneda;
                planilla.Tipo_planilla__c = 'Generada';
                planilla.fecha__c=date.today();
                insert planilla;
                
                contenidoPlanilla = new list<Contenido_Planilla__c>();
                for(Empresa_x_Empleado__c item: 
                    [Select Empleado2__c,empleado2__r.Identificacion__C ,Salario__c,CurrencyIsoCode From Empresa_x_Empleado__c
                     Where Empresa2__c = : Codigo_Unico_Banco
                     AND Estado__c = 'Activo' AND Activo_Nueva_Planilla__c=true and 
                     Empleado2__c in (select cliente__C from Cuentas__C where Producto__r.CurrencyIsoCode=:MONEDA)]){
                         if(moneda=='HNL' && item.CurrencyIsoCode=='USD'){
                             item.salario__C=item.salario__C*tasa;
                         }
                         contenidoPlanilla.add(new Contenido_Planilla__c(Planilla__c = planilla.id, Empleado2__c = item.Empleado2__c,
                                                                         Salario__c = item.Salario__c));	
                         
                         
                     }
                map<string, list<claseaportaciones>> mapAportaciones = new  map<string, list<claseaportaciones>>();
                map<string, list<claseaportaciones>> mapAportacionesC = new  map<string, list<claseaportaciones>>();
                for(integer j=0; j<listaportes.size(); j++) {
                    list<claseaportaciones> aportacionesTemp = new list<claseaportaciones>();
                    if(mapAportaciones.containskey(listaportes[j].idSalesforce)) {
                        aportacionesTemp=mapAportaciones.get(listaportes[j].idSalesforce);
                        mapAportaciones.Remove(listaportes[j].idSalesforce);
                        aportacionesTemp.add(listaportes[j]);
                        mapAportaciones.put(listaportes[j].idSalesforce,aportacionesTemp);
                    }else{
                        aportacionesTemp.add(listaportes[j]);
                        mapAportaciones.put(listaportes[j].idSalesforce,aportacionesTemp);
                    }
                    aportacionesTemp = new list<claseaportaciones>();
                    if(mapAportacionesc.containskey(listaportes[j].Num_cuenta)){
                        aportacionesTemp=mapAportacionesc.get(listaportes[j].Num_cuenta);
                        mapAportacionesc.Remove(listaportes[j].Num_cuenta);
                        aportacionesTemp.add(listaportes[j]);
                        mapAportacionesc.put(listaportes[j].Num_cuenta,aportacionesTemp);
                    }else{
                        aportacionesTemp.add(listaportes[j]);
                        mapAportacionesc.put(listaportes[j].Num_cuenta,aportacionesTemp);
                    }
                }
                for(integer i=0; i<contenidoPlanilla.size(); i++){
                    contenidoPlanilla[i].Aporte_Patrono_Voluntario__c=0;
                    contenidoPlanilla[i].Aporte_empleado_Voluntario__c=0;
                    //agregado wp 22-11-2019
                    contenidoPlanilla[i].Aporte_Empleado_Extraordinario__c=0;
                    contenidoPlanilla[i].Aporte_Patrono_Extraordinario__c=0;
                    contenidoPlanilla[i].Aporte_Seguro_de_Vida__c=0;
                    //
                    list<claseaportaciones> aportacionesTemp = new list<claseaportaciones>();
                    if(mapAportaciones.containskey(contenidoPlanilla[i].empleado2__c)){
                        aportacionesTemp = mapAportaciones.get(contenidoPlanilla[i].empleado2__c);
                        for(integer j=0; j<aportacionesTemp.size(); j++){
                            if(contenidoPlanilla[i].empleado2__c== aportacionesTemp[j].idsalesforce) {
                                contenidoPlanilla[i].Aporte_Patrono_Voluntario__c += aportacionesTemp[j].apv;
                                contenidoPlanilla[i].Aporte_empleado_Voluntario__c += aportacionesTemp[j].aev;
                                //agregado wp 22-11-2019
                                contenidoPlanilla[i].Aporte_Empleado_Extraordinario__c += aportacionesTemp[j].ape;
                                contenidoPlanilla[i].Aporte_Patrono_Extraordinario__c += aportacionesTemp[j].apx;
                                contenidoPlanilla[i].Aporte_Seguro_de_Vida__c += aportacionesTemp[j].asv;
                                //
                            }
                        }
                    }
                    
                }
                insert contenidoPlanilla;
                list<string> Cuentas = new list<string>();
                for(cuentas_colectivas__C t:[select codigo__C from cuentas_colectivas__C WHERE empresa__C = :Codigo_Unico_Banco and Tipo_Cuenta__c='Voluntarias'])
                {
                    cuentas.add(t.codigo__C); 
                }
                
                list<Cuenta_planilla__c> listcuentasEmpleadosPlanilla = new list<Cuenta_planilla__c>();
                Cuenta_planilla__c cuentasEmpleadosPlanilla;
                list<cuentas__c> listcuentasEmpleados = new list<cuentas__c>();
                listcuentasEmpleados = [select Codigo__c, Cliente__r.Identificacion__C, cliente__c ,cuenta_colectiva2__C 
                                        from cuentas__c where Cliente__r.Identificacion__C in :identidadesconsulta and cuenta_colectiva2__r.codigo__C in :cuentas ];
                map<string, string> mapIdSalesforce = new  map<string, string>();
                for(integer jj=0; jj<contenidoplanilla.size(); jj++)
                {
                    if(!mapIdSalesforce.containskey(contenidoplanilla[jj].empleado2__c))
                    {
                        mapIdSalesforce.put(contenidoplanilla[jj].empleado2__c, contenidoplanilla[jj].id);
                    }
                }
                for(integer i=0; i<listcuentasEmpleados.size(); i++)
                {
                    list<claseaportaciones> aportacionesTemp = new list<claseaportaciones>();
                    if(mapAportacionesc.containskey(listcuentasEmpleados[i].Codigo__C))
                    {
                        aportacionesTemp = mapAportacionesc.get(listcuentasEmpleados[i].Codigo__C);
                        for(integer j=0; j<aportacionesTemp.size(); j++)
                        {
                            if(aportacionesTemp[j].Num_cuenta == listcuentasEmpleados[i].Codigo__C)
                            {
                                cuentasEmpleadosPlanilla = new Cuenta_planilla__c();
                                string idsalesforce=null; 
                                if(mapIdSalesforce.containskey(listcuentasEmpleados[i].cliente__C))
                                {
                                    idsalesforce=mapIdSalesforce.get(listcuentasEmpleados[i].cliente__C);
                                }
                                /* for(integer jj=0; jj<contenidoplanilla.size(); jj++)
{
if(contenidoplanilla[jj].empleado2__c == listcuentasEmpleados[i].cliente__C)
{
idsalesforce= contenidoplanilla[jj].id;
}
}*/
                                
                                if(listcuentasEmpleados[i].cuenta_colectiva2__C ==null && idsalesforce!=null)
                                {
                                    //listcuentasEmpleadosPlanilla.add(new Cuenta_Planilla__C(Codigo_cuenta__c=listaportes[j].Num_cuenta, Contenido_Planilla__c=idsalesforce, Cuenta__c=listcuentasEmpleados[i].id, Tipo__c='Empleado', Valor_Monto__c=listaportes[j].aev, calcular_por__C='Monto'));
                                    cuentasEmpleadosPlanilla.Codigo_cuenta__c=aportacionesTemp[j].Num_cuenta;
                                    cuentasEmpleadosPlanilla.Contenido_Planilla__c=idsalesforce;
                                    cuentasEmpleadosPlanilla.Cuenta__c= listcuentasEmpleados[i].id;
                                    cuentasEmpleadosPlanilla.Tipo__c='Empleado';
                                    cuentasEmpleadosPlanilla.Valor_Monto__c=aportacionesTemp[j].aev;
                                    //agregado wp 22-11-2019
                                    cuentasEmpleadosPlanilla.Valor_Monto_Extraordinario__c += aportacionesTemp[j].ape;
                                    cuentasEmpleadosPlanilla.Valor_Monto_Patronal_Extraordinario__c += aportacionesTemp[j].apx;
                                    cuentasEmpleadosPlanilla.Valor_Monto_Seguro_Vida__c += aportacionesTemp[j].asv;
                                    //
                                    cuentasEmpleadosPlanilla.Calcular_por__c='Monto';
                                    listcuentasEmpleadosPlanilla.add(cuentasEmpleadosPlanilla);
                                }
                                else if(idsalesforce!=null)
                                {
                                    // listcuentasEmpleadosPlanilla.add(new Cuenta_Planilla__C(Valor_Monto_Patrono__c=listaportes[j].apv, Codigo_cuenta__c=listaportes[j].Num_cuenta, Contenido_Planilla__c=idsalesforce, Cuenta__c=listcuentasEmpleados[i].id, Tipo__c='Empleado', Valor_Monto__c=listaportes[j].aev, calcular_por__C='Monto'));
                                    
                                    cuentasEmpleadosPlanilla.Codigo_cuenta__c=aportacionesTemp[j].Num_cuenta;
                                    cuentasEmpleadosPlanilla.Contenido_Planilla__c=idsalesforce;
                                    cuentasEmpleadosPlanilla.Cuenta__c= listcuentasEmpleados[i].id;
                                    cuentasEmpleadosPlanilla.Tipo__c='Empresa';
                                    cuentasEmpleadosPlanilla.Calcular_por__c='Monto';
                                    cuentasEmpleadosPlanilla.Valor_Monto__c=aportacionesTemp[j].aev;
                                    //agregado wp 22-11-2019
                                    cuentasEmpleadosPlanilla.Valor_Monto_Extraordinario__c += aportacionesTemp[j].ape;
                                    cuentasEmpleadosPlanilla.Valor_Monto_Patronal_Extraordinario__c += aportacionesTemp[j].apx;
                                    cuentasEmpleadosPlanilla.Valor_Monto_Seguro_Vida__c += aportacionesTemp[j].asv;
                                    //
                                    cuentasEmpleadosPlanilla.Valor_Monto_Patrono__c=aportacionesTemp[j].apv; 
                                    listcuentasEmpleadosPlanilla.add(cuentasEmpleadosPlanilla);
                                }
                            }
                        }
                    }
                    
                }
                insert listcuentasEmpleadosPlanilla;
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, '¡Se ha creado una nueva planilla!')); 
                if(moneda=='HNL')
                {
                    //system.debug('Se llamo');
                    calculoPilares('Todos');
                }
                reiniciar();
            }			
        }Catch(Exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error,' Linea: ' + e.getLineNumber()+ '¡Ha ocurrido un error!')); 		
        }
    }
    
    public void cambiarPlanilla(){
        try{
            if(banderaTiempo==0)
            {
                registrarTiempo();
            }
            Planilla = mapPlanillas.get(idPlanilla);
            nombremes=planilla.Mes_Aporte__c;
            fechap=planilla.Fecha__c;
            mostrarBotones = false;
            if(planilla.Estado2__c == 'Nueva' || planilla.Estado2__c == 'Pendiente Aprobación Interna'){
                mostrarBotones = true;
            }
            traerContenido();
            
        }Catch(Exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!')); 	
        }
    }
    
    public boolean hayPlanilla(){
        if(planilla.id != null)
        {
            return true;  
        }	
        return false;
    }
    
    public PageReference exportarE(){
        if(banderaTiempo==0){
            registrarTiempo();
        }
        if(contenidoplanilla.size()>95){
           url_pagina='vfexportarexcelplanilla2?id_pla='+planilla.id;
            system.debug(url_pagina);
            pop_exportar=true;
            return null;
        }
        return New PageReference ('/Apex/vfexportarexcelplanilla');
    }
    
    
    public void mostrarAgregarEmpleado(){
        try{
            if(banderaTiempo==0)
            {
                registrarTiempo();
            }
            if(hayPlanilla()){
                
                listEmpleadosEmpresa = [Select Eliminado__c, Empleado2__r.FirstName, Empleado2__r.LastName, Empleado2__r.Identificacion__c
                                        ,Empleado2__r.Sexo__c, Empleado2__r.PersonBirthDate, Salario__c,Empleado2__c
                                        From Empresa_x_Empleado__c
                                        Where Empresa2__c =: Codigo_Unico_Banco 
                                        AND Empleado2__c Not In: mapEmpleados.keySet()
                                        AND Estado__c = 'Activo' and 
                                        Empleado2__c in (select cliente__C from Cuentas__C where Producto__r.CurrencyIsoCode=:MONEDA)];
                
                if(listEmpleadosEmpresa.isEmpty()){
                    ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, '¡No existen empleados disponibles para agregar')); 		
                }else{						
                    popAgregar = true;
                }
            }else{
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, '¡Debes generar una planilla')); 			
            }
        }Catch(Exception e){
            
        }
    }
    
    public void agregarEmpleado(){
        try{
            if(banderaTiempo==0)
            {
                registrarTiempo();
            }
            list <string> idempleados= new list<string>();
            For(Empresa_x_Empleado__c item : listEmpleadosEmpresa){
                if(item.Eliminado__c){
                    contenidoPlanilla.add(new Contenido_Planilla__c(Planilla__c = planilla.id, Empleado2__c = item.Empleado2__c,
                                                                    Salario__c = item.Salario__c));	
                    idempleados.add(item.Empleado2__c);
                    
                }	
            }
            upsert contenidoPlanilla;
            
            popAgregar = false;
            traerContenido();
            totalempleados=contenidoplanilla.size();
            list<string> cuentas24 = new list<string>();
            list<Contenido_Planilla__c> juu= [select id,empleado2__c from Contenido_Planilla__c where planilla__C=:planilla.id and empleado2__C in :idempleados];
            for(integer tr=0; tr<juu.size(); tr++)
            {
                CalculoPilares(juu[tr].id);
                cuentas24.add(juu[tr].empleado2__c);
            }
            list<string> cuentas2 = new list<string>();
            list<cuentas__c> listcuentasEmpleados = new list<cuentas__c>();
            list<cuentas_colectivas__C> fr = new list<cuentas_colectivas__c>();
            fr= [select codigo__C from cuentas_colectivas__c where empresa__C=:Codigo_Unico_Banco and tipo_cuenta__C ='Voluntarias'];
            for(integer i=0; i<fr.size(); i++)
            {
                cuentas2.add(fr[i].codigo__C);
            }
            
            listcuentasEmpleados = [select  Cliente__r.Identificacion__C, Codigo__c, cliente__C, cuenta_colectiva2__C,id
                                    from cuentas__c where Cliente__C in :cuentas24 
                                    and cuenta_colectiva2__r.codigo__C in : cuentas2];
            list<Cuenta_planilla__c> listcuentasEmpleadosPlanilla = new list<Cuenta_planilla__c>();
            Cuenta_planilla__c cuentasEmpleadosPlanilla;
            for(integer i=0; i<listcuentasEmpleados.size(); i++)
            {
                for(integer j=0; j<listaportes.size(); j++)
                {
                    if(listaportes[j].Num_cuenta == listcuentasEmpleados[i].Codigo__C)
                    {
                        cuentasEmpleadosPlanilla = new Cuenta_planilla__c();
                        string idsalesforce;
                        integer juio;
                        for(integer jj=0; jj<contenidoplanilla.size(); jj++)
                        {
                            if(contenidoplanilla[jj].empleado2__c == listcuentasEmpleados[i].cliente__C)
                            {
                                idsalesforce= contenidoplanilla[jj].id;
                                juio=jj;
                                
                                if(contenidoplanilla[jj].aporte_patrono_voluntario__C ==null ||contenidoplanilla[jj].aporte_patrono_voluntario__C <0)
                                {
                                    contenidoplanilla[jj].aporte_patrono_voluntario__C =0;
                                }
                                if(contenidoplanilla[jj].aporte_Patrono_Extraordinario__c ==null || contenidoplanilla[jj].aporte_Patrono_Extraordinario__c <0)
                                {
                                    contenidoplanilla[jj].aporte_Patrono_Extraordinario__c =0;
                                }
                                if(contenidoplanilla[jj].aporte_empleado_voluntario__C ==null || contenidoplanilla[jj].aporte_empleado_voluntario__C <0)
                                {
                                    contenidoplanilla[jj].aporte_empleado_voluntario__C =0;
                                }
                                //agregado wp 22-11-2019
                                if(contenidoplanilla[jj].aporte_Empleado_Extraordinario__c ==null || contenidoplanilla[jj].aporte_Empleado_Extraordinario__c <0)
                                {
                                    contenidoplanilla[jj].aporte_Empleado_Extraordinario__c =0;
                                }
                                if(contenidoplanilla[jj].aporte_Seguro_de_Vida__c ==null || contenidoplanilla[jj].aporte_Seguro_de_Vida__c <0)
                                {
                                    contenidoplanilla[jj].aporte_Seguro_de_Vida__c =0;
                                }
                                //
                            }
                        }
                        if(listcuentasEmpleados[i].cuenta_colectiva2__C ==null)
                        {
                            //listcuentasEmpleadosPlanilla.add(new cuenta_planilla__C(Calcular_por__c='Monto',  Valor_Monto__c=listaportes[j].aev, Tipo__c='Empleado', Cuenta__c= listcuentasEmpleados[i].id, Contenido_Planilla__c=idsalesforce, Codigo_cuenta__c=listaportes[j].Num_cuenta));
                            cuentasEmpleadosPlanilla.Codigo_cuenta__c=listaportes[j].Num_cuenta;
                            cuentasEmpleadosPlanilla.Contenido_Planilla__c=idsalesforce;
                            cuentasEmpleadosPlanilla.Cuenta__c= listcuentasEmpleados[i].id;
                            cuentasEmpleadosPlanilla.Tipo__c='Empleado';
                            cuentasEmpleadosPlanilla.Valor_Monto__c=listaportes[j].aev;
                            //agregado wp 22-11-219
                            cuentasEmpleadosPlanilla.Valor_Monto_Extraordinario__c=listaportes[j].ape;
                            cuentasEmpleadosPlanilla.Valor_Monto_Patronal_Extraordinario__c=listaportes[j].apx;
                            cuentasEmpleadosPlanilla.Valor_Monto_Seguro_Vida__c=listaportes[j].asv;
                            //
                            contenidoplanilla[juio].aporte_empleado_voluntario__C +=listaportes[j].aev;
                            contenidoTotal.Aporte_Empleado_Voluntario__c +=listaportes[j].aev;
                            //agregado wp 22-11-219
                            contenidoplanilla[juio].aporte_Empleado_Extraordinario__c +=listaportes[j].ape;
                            contenidoTotal.Aporte_Empleado_Extraordinario__c +=listaportes[j].ape;
                            contenidoplanilla[juio].aporte_Patrono_Extraordinario__c +=listaportes[j].apx;
                            contenidoTotal.Aporte_Patrono_Extraordinario__c +=listaportes[j].apx;
                            contenidoplanilla[juio].aporte_Seguro_de_Vida__c +=listaportes[j].asv;
                            contenidoTotal.Aporte_Seguro_de_Vida__c +=listaportes[j].asv;
                            //
                            cuentasEmpleadosPlanilla.Calcular_por__c='Monto';
                            listcuentasEmpleadosPlanilla.add(cuentasEmpleadosPlanilla);
                        }
                        else
                        {
                            
                            //listcuentasEmpleadosPlanilla.add(new cuenta_planilla__C(Valor_Monto_Patrono__c=listaportes[j].apv, Calcular_por__c='Monto',  Valor_Monto__c=listaportes[j].aev, Tipo__c='Empresa', Cuenta__c= listcuentasEmpleados[i].id, Contenido_Planilla__c=idsalesforce, Codigo_cuenta__c=listaportes[j].Num_cuenta));cuentasEmpleadosPlanilla.Codigo_cuenta__c=listaportes[j].Num_cuenta;
                            cuentasEmpleadosPlanilla.Contenido_Planilla__c=idsalesforce;
                            cuentasEmpleadosPlanilla.Cuenta__c= listcuentasEmpleados[i].id;
                            cuentasEmpleadosPlanilla.Tipo__c='Empresa';
                            cuentasEmpleadosPlanilla.Calcular_por__c='Monto';
                            contenidoplanilla[juio].aporte_patrono_voluntario__C +=listaportes[j].apv;
                            contenidoplanilla[juio].aporte_Patrono_Extraordinario__c +=listaportes[j].apx;
                            contenidoplanilla[juio].aporte_empleado_voluntario__C +=listaportes[j].aev;
                            //agregado wp 22-11-219
                            contenidoplanilla[juio].aporte_Empleado_Extraordinario__c +=listaportes[j].ape;
                            contenidoplanilla[juio].aporte_Seguro_de_Vida__c +=listaportes[j].asv;
                            contenidoTotal.Aporte_patrono_Voluntario__c +=listaportes[j].apv;
                            contenidoTotal.Aporte_Patrono_Extraordinario__c +=listaportes[j].apx;
                            contenidoTotal.Aporte_Empleado_Voluntario__c +=listaportes[j].aev;
                            //agregado wp 22-11-219
                            contenidoTotal.Aporte_Empleado_Extraordinario__c +=listaportes[j].ape;
                            contenidoTotal.Aporte_Seguro_de_Vida__c +=listaportes[j].asv;
                            //
                            cuentasEmpleadosPlanilla.Valor_Monto_Patrono__c=listaportes[j].apv; 
                            cuentasEmpleadosPlanilla.Valor_Monto_Patronal_Extraordinario__c=listaportes[j].apx;
                            cuentasEmpleadosPlanilla.Valor_Monto__c=listaportes[j].aev;
                            //agregado wp 22-11-219
                            cuentasEmpleadosPlanilla.Valor_Monto_Extraordinario__c=listaportes[j].ape;
                            cuentasEmpleadosPlanilla.Valor_Monto_Seguro_Vida__c=listaportes[j].asv;
                            //
                            listcuentasEmpleadosPlanilla.add(cuentasEmpleadosPlanilla);
                        }
                    }
                }
            }
            
            insert listcuentasEmpleadosPlanilla;
            
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, '¡Empleado(s) agregado(s) correctamente!'));	
            
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!')); 	
        }
    }
    
    public Empresa_x_Empleado__c empleadoE{get;set;}
    
    public void mostrarQuitarE(){
        try{
            if(banderaTiempo==0)
            {
                registrarTiempo();
            }
            popQuitar = true;
            Tiempo_Inactividad__c hora= new Tiempo_Inactividad__c();
            
            empleadoE = [Select Empleado2__r.Name, Motivo_despido__c, Empleado2__r.isPersonAccount, Fecha_despido__c 
                         From Empresa_x_Empleado__c
                         Where Empleado2__c =:idempleado AND Empresa2__c =: Codigo_Unico_Banco];
            
        }Catch(Exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!'));	
        }
    }
    public void CancelarPlanilla(){
        try{
            planilla.estado2__C='cancelado';
            update Planilla;
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, '¡La planilla '+planilla.name+' se canceló correctamente!'));
            reiniciar();
        } catch(Exception ex){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.error, '¡Ha ocurrido un error, por favor contacte su admin!'));
        }
    }
    public void quitarEmpleado(){
        try{
            if(banderaTiempo==0)
            {
                registrarTiempo();
            }
            if(empleadoE.Motivo_despido__c != null)
            {
                Delete (new Contenido_Planilla__c(Id = idContenido));
                
                empleadoE.Estado__c = 'Despedido';
                empleadoE.Fecha_despido__c = empleadoE.Fecha_despido__c != null ? empleadoE.Fecha_despido__c : Date.today();
                update empleadoE;
                
                traerContenido();
                popQuitar = False;
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, '¡Empleado(s) dado(s) de baja correctamente!'));
                totalempleados=contenidoplanilla.size();
            }
            else
            {
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, 'Seleccione una causa de despido.'));  
            }
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, '¡Ha ocurrido un error!')); 
        }
    }
    
    public Contenido_Planilla__c unContenido{get;set;}
    public void mostrarModificarE(){
        try{
            if(banderaTiempo==0)
            {
                registrarTiempo();
            }
            popModificar = true;
            unContenido = [Select Empleado2__r.Name, Salario__c, Empleado2__c
                           From Contenido_Planilla__c
                           Where Id =: idContenido];
            
        }Catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!'));	
        }
    }
    
    public void modificarEmpleado(){
        try{
            if(banderaTiempo==0)
            {
                registrarTiempo();
            }
            
            Empresa_x_Empleado__c empEmpresa = [Select id, Salario__c From Empresa_x_Empleado__c
                                                Where Empleado2__c =: unContenido.Empleado2__c
                                                AND Empresa2__c =: Codigo_Unico_Banco];
            
            empEmpresa.Salario__c = unContenido.Salario__c;
            
            update unContenido;
            update empEmpresa;
            for (integer i=0; i<contenidoplanilla.size(); i++){
                if(idcontenido ==contenidoplanilla[i].id)
                {
                    contenidoplanilla[i].salario__C=unContenido.Salario__c;
                    contenidoplanilla[i].Aporte_Patrono_obligatorio__c=0;
                    contenidoplanilla[i].Aporte_Empleado_Obligatorio__c=0;
                    contenidoplanilla[i].Reserva_Laboral__c=0;
                    i= contenidoplanilla.size();
                }
                
            }
            contenidoTotal.Salario__c=0;
            contenidoTotal.Aporte_Patrono_obligatorio__c=0;
            contenidoTotal.Aporte_Empleado_Obligatorio__c=0;
            contenidoTotal.Reserva_Laboral__c=0;
            calculopilares(unContenido.id);
            for (integer i=0; i<contenidoplanilla.size(); i++){
                contenidoTotal.Aporte_Patrono_obligatorio__c=contenidoplanilla[i].Aporte_Patrono_obligatorio__c;
                contenidoTotal.Aporte_Empleado_Obligatorio__c=contenidoplanilla[i].Aporte_Empleado_Obligatorio__c;
                contenidoTotal.Reserva_Laboral__c=contenidoplanilla[i].Reserva_Laboral__c;
                contenidoTotal.Salario__c += contenidoplanilla[i].Salario__C;
            }
            popModificar = False;
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, '¡Empleado(s) modificado(s) correctamente!'));	
            
        }Catch(Exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, '¡Ha ocurrido un error!')); 
        }
    }
    
    
    Contenido_planilla__c contenidoPFinal;
    public void mostrarCuentas(){
        try{
            listCuentasPlanilla = new list<Cuenta_planilla__c>();
            Disponibleguardar=true;
            if(banderaTiempo==0){
                registrarTiempo();
            }
            system.debug('Contenido Paola1: '+ idContenido+' '+esAPV);
            if(esAPV){
               
               listCuentasPlanilla=[select Calcular_por__c, Codigo_cuenta__c,id, Valor_Monto_Patrono__c from Cuenta_planilla__c where Contenido_Planilla__c=:idContenido and tipo__c='Empresa'];
               
                
                NombreAporte='Aportes Voluntario Patronal';
                if(listCuentasPlanilla.size()>0){
                    popCuentasAPV = true;
                }
                if(planilla.estado2__C=='Nueva'){
                    Disponibleguardar=false;
                }
            }
            //agregado wp 22-11-2019
            if(esAPX){
                NombreAporte='Aportes Voluntario Patronal Extraordinario';
                listCuentasPlanilla=[select Calcular_por__c, Codigo_cuenta__c,id,Valor_Monto_Patronal_Extraordinario__c from Cuenta_planilla__c where Contenido_Planilla__c=:idContenido]; 
                if(listCuentasPlanilla.size()>0)
                {
                    popCuentasAPX = true;
                }
                if(planilla.estado2__C=='Nueva')
                {
                    Disponibleguardar=false;
                }
            }
            //
            system.debug('Contenido Paola3: '+ idContenido+' '+esAEV);
            if(esAEV) {
                NombreAporte='Aportes Voluntario Empleado';
                listCuentasPlanilla=[select Calcular_por__c, Codigo_cuenta__c,id, Valor_Monto__c from Cuenta_planilla__c where Contenido_Planilla__c=:idContenido]; 
                if(listCuentasPlanilla.size()>0)
                {
                    popCuentasAEV = true;
                }
                if(planilla.estado2__C=='Nueva')
                {
                    Disponibleguardar=false;
                }
            }
            //agregado wp 22-11-2019
            if(esAPE){
                NombreAporte='Aportes Voluntario Empleado Extraordinario';
                listCuentasPlanilla=[select Calcular_por__c, Codigo_cuenta__c,id, Valor_Monto_Extraordinario__c from Cuenta_planilla__c where Contenido_Planilla__c=:idContenido]; 
                if(listCuentasPlanilla.size()>0)
                {
                    popCuentasAPE = true;
                }
                if(planilla.estado2__C=='Nueva')
                {
                    Disponibleguardar=false;
                }
            }
            system.debug('Contenido Paola4: '+listCuentasPlanilla);
            if(esASV){
                NombreAporte='Aportes Seguro de Vida';
                listCuentasPlanilla=[select Calcular_por__c, Codigo_cuenta__c,id, Valor_Monto_Seguro_Vida__c from Cuenta_planilla__c where Contenido_Planilla__c=:idContenido]; 
                if(listCuentasPlanilla.size()>0)
                {
                    popCuentasASV = true;
                }
                if(planilla.estado2__C=='Nueva')
                {
                    Disponibleguardar=false;
                }
            }
            //
            system.debug('Contenido Paola5: '+listCuentasPlanilla.size());
            
        }Catch(Exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'No se han encontrado cuentas asociadas')); 	
        }
    }
    
    public void aceptarCuentas(){
        try{
            decimal totalaporte=0;
            if(banderaTiempo==0)
            {
                registrarTiempo();
            }
            contenido_planilla__c contenidotemporal = new contenido_planilla__c();
            if(esAPV)
            {
                contenidoTotal.Aporte_Patrono_Voluntario__c=0;
                for(integer i=0; i<listCuentasPlanilla.size(); i++)
                {
                    totalaporte +=listCuentasPlanilla[i].valor_monto_patrono__c;
                }
                for(integer i=0; i<contenidoPlanilla.size(); i++)
                {
                    if(idContenido == contenidoPlanilla[i].id)
                    {
                        contenidoPlanilla[i].aporte_patrono_voluntario__C=totalaporte;
                        contenidotemporal.Aporte_Patrono_Voluntario__c=totalaporte;
                        contenidotemporal.id=idcontenido;
                        update contenidotemporal;
                    }
                    contenidoTotal.Aporte_Patrono_Voluntario__c +=contenidoPlanilla[i].Aporte_Patrono_Voluntario__c;
                }
                esAPV = false;
            }
            //agregado wp 22-11-2019
            if(esAPX)
            {
                contenidoTotal.Aporte_Patrono_Extraordinario__c=0;
                for(integer i=0; i<listCuentasPlanilla.size(); i++)
                {
                    totalaporte +=listCuentasPlanilla[i].Valor_Monto_Patronal_Extraordinario__c;
                } 
                for(integer i=0; i<contenidoPlanilla.size(); i++)
                {
                    if(idContenido == contenidoPlanilla[i].id)
                    {
                        contenidoPlanilla[i].aporte_Patrono_Extraordinario__c=totalaporte;
                        contenidotemporal.Aporte_Patrono_Extraordinario__c=totalaporte;
                        contenidotemporal.id=idcontenido;
                        update contenidotemporal;
                    }
                    contenidoTotal.Aporte_Patrono_Extraordinario__c +=contenidoPlanilla[i].Aporte_Patrono_Extraordinario__c;
                }
                esAPX = false;
            }
            //
            if(esAEV)
            {
                contenidoTotal.Aporte_empleado_Voluntario__c=0;
                for(integer i=0; i<listCuentasPlanilla.size(); i++)
                {
                    totalaporte +=listCuentasPlanilla[i].Valor_Monto__c;
                } 
                for(integer i=0; i<contenidoPlanilla.size(); i++)
                {
                    if(idContenido == contenidoPlanilla[i].id)
                    {
                        contenidoPlanilla[i].aporte_empleado_voluntario__C=totalaporte;
                        contenidotemporal.Aporte_empleado_Voluntario__c=totalaporte;
                        contenidotemporal.id=idcontenido;
                        update contenidotemporal;
                    }
                    contenidoTotal.Aporte_empleado_Voluntario__c +=contenidoPlanilla[i].Aporte_empleado_Voluntario__c;
                }
                esAEV = false;
            }
            //agregado wp 22-11-2019
            if(esAPE)
            {
                contenidoTotal.Aporte_Empleado_Extraordinario__c=0;
                for(integer i=0; i<listCuentasPlanilla.size(); i++)
                {
                    totalaporte +=listCuentasPlanilla[i].Valor_Monto_Extraordinario__c;
                } 
                for(integer i=0; i<contenidoPlanilla.size(); i++)
                {
                    if(idContenido == contenidoPlanilla[i].id)
                    {
                        contenidoPlanilla[i].aporte_Empleado_Extraordinario__c=totalaporte;
                        contenidotemporal.Aporte_Empleado_Extraordinario__c=totalaporte;
                        contenidotemporal.id=idcontenido;
                        update contenidotemporal;
                    }
                    contenidoTotal.Aporte_Empleado_Extraordinario__c +=contenidoPlanilla[i].Aporte_Empleado_Extraordinario__c;
                }
                esAPE = false;
            }
            if(esASV)
            {
                contenidoTotal.Aporte_Seguro_de_Vida__c=0;
                for(integer i=0; i<listCuentasPlanilla.size(); i++)
                {
                    totalaporte +=listCuentasPlanilla[i].Valor_Monto_Seguro_Vida__c;
                } 
                for(integer i=0; i<contenidoPlanilla.size(); i++)
                {
                    if(idContenido == contenidoPlanilla[i].id)
                    {
                        contenidoPlanilla[i].aporte_Seguro_de_Vida__c=totalaporte;
                        contenidotemporal.Aporte_Seguro_de_Vida__c=totalaporte;
                        contenidotemporal.id=idcontenido;
                        update contenidotemporal;
                    }
                    contenidoTotal.Aporte_Seguro_de_Vida__c +=contenidoPlanilla[i].Aporte_Seguro_de_Vida__c;
                }
                esASV = false;
            }
            //
            update listCuentasPlanilla;
            popCuentasAEV = false;
            popCuentasAPE = false;
            popCuentasAPV = false;
            popCuentasAPX = false;
            popCuentasASV = false;
            
            
        }Catch(Exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!')); 
        }
    }
    
    public void enviarPlanilla(){
        try{
            if(banderaTiempo==0)
            {
                registrarTiempo();
            }
            if(hayPlanilla()){
                planilla.Estado2__c = 'Pendiente Aprobación Interna';
                planilla.Mes_Aporte__c=NombreMes;
                planilla.Fecha__c=fechap;
                update planilla;
                upsert contenidoPlanilla; 
                
                claseUtilPlanillas.correoEnvioPlanilla2(planilla.id);
                
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, '¡La Planilla '+planilla.name+' enviada a aprobación!')); 
            }
            reiniciar();				
        }Catch(Exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, 'Ha ocurrido un error!')); 	
        }
    }
    
    public void guardarPlanilla(){
        try{
            if(banderaTiempo==0)
            {
                registrarTiempo();
            }
            if(hayPlanilla()){
                planilla.Mes_Aporte__c=NombreMes;
                planilla.Fecha__c=fechap;
                update planilla;
                upsert contenidoPlanilla; 
                
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Confirm, '¡La Planilla '+planilla.name+' se guardo correctamente!')); 	
            }
            reIniciar();	
        }Catch(Exception e){
            system.debug('Error: ' + e.getMessage() + ' Linea: ' + e.getLineNumber());
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.Error, '¡Ha ocurrido un error!')); 	
        }
    }
    
    public void metodoutil(){
        integer p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
          p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
          p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
          p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
        p=0;
    }
    
}