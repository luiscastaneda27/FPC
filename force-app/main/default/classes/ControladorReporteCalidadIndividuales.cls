public class ControladorReporteCalidadIndividuales {
 
    public list<Reporte_calidad__C> listAfiliaciones{get;set;}
    public list<selectOption> listSubProductos{get;set;}
    public Reporte_calidad__C Afiliacion {get;set;}
    string Usuario;
    public producto__C producto {get;set;}
    public string NombreProducto{get;set;}
    public boolean popAfiliacion{get;set;}
    public string URLPagina {get;set;}
    
    
    public ControladorReporteCalidadIndividuales(){
        try{
            usuario = ApexPages.currentPage().getParameters().get('usuario');
            reinicar();
        }catch(exception ex){
              ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Usted no tiene oficiales Sac asignados, por favor contacto su admin.'));
        }
         
    }
    
   
    
    public void cerrar(){
        popAfiliacion = false;
        URLPagina = null;
    }
    public void reinicar(){
        listAfiliaciones = new list<Reporte_calidad__C>();
        Afiliacion = new Reporte_calidad__C();
        listAfiliaciones = [select Addendum__c, Aplica_CS__c , Aportacion_HNL__c ,Aportacion_USD__c ,
                            Asesor_Comercial__c, Comentarios__c, Codigo_Asesor_Comercial__c,Codigo_Oficial_SAC__c ,
                            Empresa__c , Expediente_Completo__c , FATCA__c , Fecha_Envio_Memo__c, Fecha_Validacion__c ,
                            Fecha_Inicio_Aporte__c , Forma_Pago__c, Formulario_Completo__c, Identificacion__c ,
                            Numero_de_Cliente__c , Numero_de_Contrato__c ,Numero_Cuenta__c ,Oficial_SAC__c ,PEP__c ,
                            Periodicidad__c , name , Procedencia__c , Reporte_Calidad__c,RTN__c ,Estado__c,
                            Primer_Apellido__c,Enviar_Sac__C,Tipo_Afiliacion__c,Aprueba_SAC__c ,ExpedienteFisicoRecibido__C,
                            Subproducto__r.name,Empresa__r.name, Subproducto__r.producto__r.name,Espediente_Completo__C,
                            Segundo_Apellido__c ,Segundo_Nombre__c , Seguro_HNL__c , Seguro_USD__c ,Subproducto__c ,
                            Tiene_Id__c , Tipo_Fondo__c , Tipo_Identificacion__c ,WAIVER__c from Reporte_calidad__C
                            where Codigo_Oficial_SAC__c =:Usuario and Enviar_Sac__C =true and Espediente_Completo__c != 'S'
                            and Tipo_Afiliacion__c  ='I'];
        
       // agregarAfiliacion();
    }
    
    public string idAfiliacion{get;set;}
    public void editar(){
         producto =new producto__C();
         afiliacion = new Reporte_calidad__C();
        for(Reporte_calidad__C item:listAfiliaciones ){
            if(idAfiliacion == item.Id){
                afiliacion = item;
                producto.name = item.Subproducto__r.producto__r.name;
            }
        }
    }

    public void ValidacionIdentidad(){
        if(afiliacion.Identificacion__c !=null){
            list<Cuentas__C> listCuentas = [select id, cliente__r.name, codigo__C from Cuentas__C where cliente__r.identificacion__C = :afiliacion.Identificacion__c limit 1];
            if(listCuentas.size() > 0){ ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.WARNING, ' Esta persona ya esta afiliado, con este nuemero de cuenta '+listCuentas[0].codigo__C));
            }
        }
    }
    public PageReference guardar(){
        if(Afiliacion.Espediente_Completo__c == 'N'){
            Afiliacion.Enviar_Sac__c = false;
            update afiliacion;
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Datos Guardados Exitosamente.'));
            reinicar();
        }else if( afiliacion.name == null  || afiliacion.Primer_Apellido__c == null || afiliacion.Tipo_Identificacion__c == null || afiliacion.Identificacion__c == null || afiliacion.Tiene_Id__c == null || afiliacion.RTN__c == null || afiliacion.FATCA__c == null || afiliacion.WAIVER__c == null || afiliacion.PEP__c == null || afiliacion.Procedencia__c == null || afiliacion.Addendum__c == null ){
                ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'Por favor Completar todos los campos.'));
            }else if(afiliacion.Espediente_Completo__c == 'S'){
                afiliacion.Espediente_Completo__c = null;
                afiliacion.Fecha_Validacion__c  = date.today();
                update afiliacion;
                afiliacion.Espediente_Completo__c = 'S';
                URLPagina =claseUtil.urlSysde('Site_pantallas')+'vfpantallaclienteProducto?idAfiliacion='+afiliacion.id+'&hytrd='+usuario;
                reinicar();
                return new PageReference (URLPagina);
                
                
            }
        return null;
       
    }
    
    
    
    public void accionVacia(){
        
    }
   

}