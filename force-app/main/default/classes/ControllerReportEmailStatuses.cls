public without sharing class ControllerReportEmailStatuses {
    
	public Date dateStart {get;set;}
    public Date dateEnd {get;set;}
    
    public void GenerarReporte(){
        datetime.newInstance(dateStart.year(), dateStart.month(), dateStart.day(), 5, 0, 0);
        BatchDatosInformeEDC l = new BatchDatosInformeEDC( Datetime.newInstance(dateStart.year(), dateStart.month(), dateStart.day(), 5, 0, 0),
                                                          Datetime.newInstance(dateEnd.year(), dateEnd.month(), dateEnd.day(), 6, 0, 0));
        Id batchprocessid = Database.executeBatch(l, Integer.valueOf(Label.BatchSize));
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.confirm, 'Espere un momento para poder ejecutar el informe.'));
        
    }
        
}