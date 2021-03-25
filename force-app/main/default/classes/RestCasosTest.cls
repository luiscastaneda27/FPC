@isTest
public class RestCasosTest {
    
    static testMethod void TestCasos(){
        String recordType = Schema.SObjectType.Case.getRecordTypeInfosByDevelopername().get('Actualizacion_informacion').getRecordTypeId();
        Account cliente = new Account();
        cliente.Name='Luis Donaire';
        cliente.Identificacion__c='0709199300155';
        insert cliente;
        
        Case caso = new case();
        caso.AccountId = cliente.Id;
        caso.Identificacion__c='0709199300135';
        caso.RecordTypeId = recordType;
        caso.Status = 'Nuevo';
        
        
        SolicitudCaso solicitud = RestCasos.doPost(caso, null, null);
        if(solicitud.solicitudExitosa){
            caso = solicitud.caso;
        }
        caso.Status = 'Cerrado';
        solicitud = RestCasos.doPost(caso, null, null);
        if(solicitud.solicitudExitosa){
            caso = solicitud.caso;
        }
        RestCasos.doPost(null, null, null);
        RestCasos.doGet();
        
        
        
        
    }

}