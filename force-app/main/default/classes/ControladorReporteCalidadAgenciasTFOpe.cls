public class ControladorReporteCalidadAgenciasTFOpe {
    
    
    public list<Reporte_calidad__C> listAfiliaciones{get;set;}
    public Reporte_calidad__C Afiliacion {get;set;}
    string usuario;
    public string idAfiliacion{get;set;}
    
    public ControladorReporteCalidadAgenciasTFOpe(){
        usuario = ApexPages.currentPage().getParameters().get('usuario');
        reinicar();
         
    }
    
    public void reinicar(){
        listAfiliaciones = new list<Reporte_calidad__C>();
        Afiliacion = new Reporte_calidad__C();
        listAfiliaciones = [select Addendum__c, Aplica_CS__c , Aportacion_HNL__c ,Aportacion_USD__c ,
                            Asesor_Comercial__c, Comentarios__c, Codigo_Asesor_Comercial__c,Codigo_Oficial_SAC__c ,
                            Empresa__c , Expediente_Completo__c , FATCA__c , Fecha_Envio_Memo__c, Fecha_Validacion__c ,
                            Fecha_Inicio_Aporte__c , Forma_Pago__c, Formulario_Completo__c, Identificacion__c ,
                            Numero_de_Cliente__c , Numero_de_Contrato__c ,Numero_Cuenta__c ,Oficial_SAC__c ,PEP__c ,
                            Periodicidad__c , name , Procedencia__c , Reporte_Calidad__c,RTN__c ,
                            Documentacion_Recibida__c,Id,ExpedienteFisicoRecibido__c,Estado__c,
                            FirmaExpediente__c,Subproducto__r.Codigo__c,DebidaDiligencia__c,
                            NombreEmpleadoAGN__c,CodigoEmpleadoAGN__c, FechaIngreso__c, NombreAgencia__c,CodigoAGN__c,
                            CurrencyIsoCode,Nacionalidad__c, sexo__C,fecha_nacimiento__C,Fecha_ingreso_empresa__C,
                            profesion__C,estado_civil__C, lugar_nacimiento__C,nombre_conyuge__C,cargo__C,
                            Primer_Apellido__c,Enviar_Sac__C,Tipo_Afiliacion__c,Aprueba_SAC__c ,
                            Subproducto__r.name,Empresa__r.name, Subproducto__r.producto__r.name,Espediente_Completo__C,
                            Segundo_Apellido__c ,Segundo_Nombre__c , Seguro_HNL__c , Seguro_USD__c ,Subproducto__c ,
                            Tiene_Id__c , Tipo_Fondo__c , Tipo_Identificacion__c ,WAIVER__c from Reporte_calidad__C
                            where Tipo_Afiliacion__C = 'TF' and Estado__c = 'F' order by LastModifiedDate desc limit 950];
        if(listAfiliaciones.size() == 0){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'No se han encontrado clientes.'));
        }
        
    }
    
    
    public void editar(){
        for(Reporte_calidad__C item:listAfiliaciones ){
            if(idAfiliacion == item.Id){
                afiliacion = new Reporte_calidad__C ();
                afiliacion = item;
            }
        }
    }
    
    
    public void guardar(){
        try{
            if(Afiliacion.FirmaExpediente__c == 'S' && afiliacion.ExpedienteFisicoRecibido__c == 'S'){
                afiliacion.Estado__c = 'C';
            }
            update afiliacion;
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Datos Guardados exitosamente.'));
            reinicar();
        }catch(exception ex){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.ERROR, 'Ha ocurrido un error, por favor contacte su admin.'));
        }
        
    }
}