public class ControlorReporteCalidadPenFisSac {
    
    public list<Reporte_calidad__C> listAfiliaciones{get;set;}
    string Usuario;
    string perfil;
    
    
    public ControlorReporteCalidadPenFisSac(){
        usuario = ApexPages.currentPage().getParameters().get('usuario');
        perfil = ApexPages.currentPage().getParameters().get('perfil');
        inicar();
    }
    
    public void inicar(){
        listAfiliaciones = new list<Reporte_calidad__C>();
        String query = 'select Addendum__c, Aplica_CS__c , Aportacion_HNL__c ,Aportacion_USD__c , '+
            'Asesor_Comercial__c, Comentarios__c, Codigo_Asesor_Comercial__c,Codigo_Oficial_SAC__c ,'+
            'Empresa__c , Expediente_Completo__c , FATCA__c , Fecha_Envio_Memo__c, Fecha_Validacion__c ,'+
            'Fecha_Inicio_Aporte__c , Forma_Pago__c,estado__C, Formulario_Completo__c, Identificacion__c ,'+
            'Numero_de_Cliente__c , Numero_de_Contrato__c ,Numero_Cuenta__c ,Oficial_SAC__c ,PEP__c ,'+
            'Periodicidad__c , name , Procedencia__c , Reporte_Calidad__c,RTN__c ,id,Cuentas_Colectivas__c,'+
            'Primer_Apellido__c,Enviar_Sac__C,Tipo_Afiliacion__c,CurrencyIsoCode,DebidaDiligencia__c ,'+
            'Subproducto__r.name,Empresa__r.name, Subproducto__r.producto__r.name,SubEstadoRCSF__c,'+
            'Segundo_Apellido__c ,Segundo_Nombre__c , Seguro_HNL__c , Seguro_USD__c ,Subproducto__c ,'+
            'Tiene_Id__c , Tipo_Fondo__c , Tipo_Identificacion__c ,WAIVER__c from Reporte_calidad__C '+
            'Where SubEstadoRCSF__c = \'PF\' ';
        query += perfil == 'SAC' ? 'and Codigo_Oficial_SAC__c = \'' + usuario + '\' ' : 'and Codigo_Asesor_Comercial__c = \'' + usuario + '\' ';
        query += 'order by LastModifiedDate desc limit 950';
        for(Reporte_calidad__c item: DataBase.query(query)){
            item.Enviar_Sac__c = false;
            listAfiliaciones.add(item);
        }
        if(listAfiliaciones.size() == 0){
            ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.warning, 'No se han encontrado coincidencias.'));
        }
    }
    
    public void Enviar(){
        for(Reporte_calidad__C item:listAfiliaciones ){
            if(item.Enviar_Sac__c){
                item.estado__C = 'V'; 
                item.SubEstadoRCSF__c = 'VF';
            }
        }
        update listAfiliaciones;
        inicar();
        ApexPages.addMessage(new ApexPages.Message( ApexPages.Severity.confirm, 'Datos guardados exitosamente.'));
    }
}