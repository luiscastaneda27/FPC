/**
*Class Name: SCH_CallCardServiceFicohsa
*Description: Clase Queueable para el batch: BAT_CallCardServiceFicohsa.
*Created Date: 13/02/2023 03:03 PM
*Created By: Cloud Code   
*Last Modified by: Cloud Code 14/02/2023 15:12 PM
*/
global class SCH_CallCardServiceFicohsa implements Queueable {
	global List<Detalle_caso__c> listDTC = new List<Detalle_caso__c>();
    global String tipoGestion;

    global SCH_CallCardServiceFicohsa(List<Detalle_caso__c> lstDetCase, String tipoGestion) {
        this.listDTC = lstDetCase;
        this.tipoGestion = tipoGestion;
    }

    global void execute(QueueableContext qc) {  
        if (!listDTC.isEmpty()) { 
		   Database.executeBatch(new BAT_CallCardServiceFicohsa(listDTC, tipoGestion));
        }
    }
}