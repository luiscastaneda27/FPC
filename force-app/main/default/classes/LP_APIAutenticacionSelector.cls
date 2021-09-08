/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 05/08/2021
Description  : Query factory for LP_APIAutenticacion__mdt using "FFLIB – Selector layer"
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			05/08/2021		initial version
********************************************************************************/
public inherited sharing class LP_APIAutenticacionSelector extends fflib_SObjectSelector{
    
    /**
    *  @Description: Defines the type of object handled in the selector
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        05/08/2021
    */
    public Schema.SObjectType getSObjectType() {
        return LP_APIAutenticacion__mdt.sObjectType;
    }

    /**
    *  @Description: Defines the fields that will be queried in a default query
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        05/08/2021
    */
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField> {
            LP_APIAutenticacion__mdt.DeveloperName,
            LP_APIAutenticacion__mdt.Id,
            LP_APIAutenticacion__mdt.Label,
            LP_APIAutenticacion__mdt.Language,
            LP_APIAutenticacion__mdt.LP_Accion__c,
            LP_APIAutenticacion__mdt.LP_Canal__c,
            LP_APIAutenticacion__mdt.LP_Clave__c,
            LP_APIAutenticacion__mdt.LP_Metodo__c,
            LP_APIAutenticacion__mdt.LP_URL__c,
            LP_APIAutenticacion__mdt.LP_Usuario__c,
            LP_APIAutenticacion__mdt.MasterLabel,
            LP_APIAutenticacion__mdt.NamespacePrefix,
            LP_APIAutenticacion__mdt.QualifiedApiName
        };
    }

    /**
    *  @Description: Perform a query with the default fields with the Credit Card Type as a condition
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        05/08/2021
    */
    public LP_APIAutenticacion__mdt selectByDeveloperNameWithLimit(String devName) {
        fflib_QueryFactory query = newQueryFactory();
        query.setCondition('DeveloperName = :devName');
        query.setLimit( 1 );
        return (LP_APIAutenticacion__mdt) Database.query( query.toSOQL() );
    }
}