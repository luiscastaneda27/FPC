public class controladorENtregaKitSac {
    
    public list<Reporte_calidad__C> listAfiliaciones{get;set;}
    public Reporte_calidad__C Afiliacion {get;set;}
    public producto__C producto {get;set;}
    string usuario;
    public string idAfiliacion {get;set;}
    
    
    public controladorENtregaKitSac(){
        usuario = ApexPages.currentPage().getParameters().get('usuario');
        reiniciar();
    }
    
    
    
    
    public void reiniciar(){
        listAfiliaciones = new list<Reporte_calidad__C>();
        Afiliacion = new Reporte_calidad__C();
        listAfiliaciones = [select Addendum__c, Aplica_CS__c , Aportacion_HNL__c ,Aportacion_USD__c ,
                            Asesor_Comercial__c, Comentarios__c, Codigo_Asesor_Comercial__c,Codigo_Oficial_SAC__c ,
                            Empresa__c , Expediente_Completo__c , FATCA__c , Fecha_Envio_Memo__c, Fecha_Validacion__c ,
                            Fecha_Inicio_Aporte__c , Forma_Pago__c, Formulario_Completo__c, Identificacion__c ,
                            Numero_de_Cliente__c , Numero_de_Contrato__c ,Numero_Cuenta__c ,Oficial_SAC__c ,PEP__c ,
                            Periodicidad__c , name , Procedencia__c , Reporte_Calidad__c,RTN__c ,id,
                            Documentacion_Recibida__c,Entrega_KIT__C,Fecha_Entrega_Kit__c ,Fecha_Entrega_Kit_SAC__c,
                            CurrencyIsoCode,Nacionalidad__c, sexo__C,fecha_nacimiento__C,Fecha_ingreso_empresa__C,
                            profesion__C,estado_civil__C, lugar_nacimiento__C,nombre_conyuge__C,cargo__C,
                            Primer_Apellido__c,Enviar_Sac__C,Tipo_Afiliacion__c,Aprueba_SAC__c ,
                            Subproducto__r.name,Empresa__r.name, Subproducto__r.producto__r.name,Espediente_Completo__C,
                            Segundo_Apellido__c ,Segundo_Nombre__c , Seguro_HNL__c , Seguro_USD__c ,Subproducto__c ,
                            Tiene_Id__c , Tipo_Fondo__c , Tipo_Identificacion__c ,WAIVER__c from Reporte_calidad__C
                            where Codigo_Oficial_SAC__c =:Usuario  and Espediente_Completo__c = 'S' and Entrega_KIT__C != 'S'
                            order by name asc];
        
    }
    
    
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
    
    
    
    
    
    public void guardar(){
        update afiliacion;
        reiniciar();
        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Datos Guardados Exitosamente.'));
        
    }
    
    
    
    public void ValidacionIdentidad(){
        string iden = afiliacion.Identificacion__c;
        afiliacion = new Reporte_calidad__C();
        for(Reporte_calidad__C item: 
            [select Asesor_Comercial__c, Comentarios__c, Codigo_Asesor_Comercial__c,Codigo_Oficial_SAC__c ,
             Empresa__c , Expediente_Completo__c , FATCA__c , Fecha_Envio_Memo__c, Fecha_Validacion__c ,
             Fecha_Inicio_Aporte__c , Forma_Pago__c, Formulario_Completo__c, Identificacion__c ,
             Numero_de_Cliente__c , Numero_de_Contrato__c ,Numero_Cuenta__c ,Oficial_SAC__c ,PEP__c ,
             Periodicidad__c , name , Procedencia__c , Reporte_Calidad__c,RTN__c ,id,
             Documentacion_Recibida__c,Entrega_KIT__C,Fecha_Entrega_Kit__c ,
             CurrencyIsoCode,Nacionalidad__c, sexo__C,fecha_nacimiento__C,Fecha_ingreso_empresa__C,
             profesion__C,estado_civil__C, lugar_nacimiento__C,nombre_conyuge__C,cargo__C,
             Primer_Apellido__c,Enviar_Sac__C,Tipo_Afiliacion__c,Aprueba_SAC__c ,
             Subproducto__r.name,Empresa__r.name, Subproducto__r.producto__r.name,Espediente_Completo__C,
             Segundo_Apellido__c ,Segundo_Nombre__c , Seguro_HNL__c , Seguro_USD__c ,Subproducto__c ,
             Tiene_Id__c , Tipo_Fondo__c , Tipo_Identificacion__c ,WAIVER__c from Reporte_calidad__C
             where Codigo_Oficial_SAC__c =:Usuario  and Espediente_Completo__c = 'S' 
             and Entrega_KIT__C != 'S' and identificacion__C =: iden and identificacion__C !=null
             order by name asc]){
                 afiliacion = item;
             }
    }
    
    
}