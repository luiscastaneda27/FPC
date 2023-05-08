/**
*Class Name: TG_Case
*Description: Trigger para el objeto Caso.
*Created Date: 11/01/2023 10:19 AM
*Created By: Cloud Code   
*Last Modified by: Cloud Code 13/02/2023 15:41 PM
*/
trigger TG_Case on Case (before insert, after insert, before update, after update) { 
    new TG_CaseHandler().run();
}