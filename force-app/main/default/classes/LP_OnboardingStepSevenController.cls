/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 29/06/2021
Description  : Class controller for step 7
History      : PCRM-24
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Fran Oseguera               FO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      FO			29/06/2021		initial version
********************************************************************************/
public without sharing class LP_OnboardingStepSevenController extends LP_OnBoardingUtility{
    
    /**
    *  @Description: Search Account by Rut
    *  @Author:      FO, Deloitte
    *  @Date:        15/07/2021  
    */
    @AuraEnabled(cacheable=true)
    public static Account searchAccountByRUT(String rut) {
        try{
            return new LP_AccountsSelector().selectPersonAccountByRut(rut);
        }catch (Exception e) {
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException(JSON.serialize(ed));
        }
    }


    /**
    *  @Description: Create Customer, service 965
    *  @Author:      FO, Deloitte
    *  @Date:        15/07/2021  
    */
   /*  @AuraEnabled
    public static LP_JSONCustomerCreateResponse customerCreate(Lead objLead) {
        try{
            Map<String, String> auditCode = new Map<String, String>();
            LP_OnBoardingUtility.WrapObject wrap = new LP_OnBoardingUtility.WrapObject(new LP_Onboarding__c());
            wrap.rut = objLead.LP_Rut__c;
            wrap = LP_OnBoardingUtility.getOnboardingObj(wrap);

            auditCode = getAuditDocumentCode(wrap.onb);
            system.debug('wrap.acc: '+wrap.acc);
            system.debug('wrap.onb: '+wrap.onb);
            LP_MAPJSONCustomerCreate objMap = new LP_MAPJSONCustomerCreate(wrap.acc, wrap.onb, auditCode);
            LP_JSONCustomerCreateResponse jsonResponse = (LP_JSONCustomerCreateResponse)JSON.deserialize( objMap.call(), LP_JSONCustomerCreateResponse.class);
            system.debug('jsonResponse: '+jsonResponse);
            return jsonResponse;
        } catch (LP_RestConnectionWithAuth.ServiceException e) {
            if(e.code == 422){
                LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(null, LP_CustomException.PRV_ERR_EXIST_CLIENT, true);
                throw new AuraHandledException(JSON.serialize(ed));
            }else{
                LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, false);
                throw new AuraHandledException (JSON.serialize(data));
            }
        } catch (Exception e) {
            system.debug(e.getMessage());
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException(JSON.serialize(ed));
        }
    } */

    /**
    *  @Description: Get audit code for documents, service 103
    *  @Author:      Eilhert Andrade, Deloitte
    *  @Date:        15/07/2021  
    */
  /*   public static Map<String, String> getAuditDocumentCode(LP_Onboarding__c onb){
        // se genera la lista de codigos de documentos
        Map<String, String> auditCode = new Map<String, String>();
        List<String> codeList = new List<String>();
        
        codeList.add(onb.LP_CodigoContratoApertura__c);
        codeList.add(onb.LP_CodigoAutorizacionEspecial__c);
        codeList.add(onb.LP_CodigoMandato__c);
        codeList.add(onb.LP_CodigoResumenContratoApertura__c);
        codeList.add(onb.LP_CodigoConstanciaSuscripcion__c);

         // se llama al servicio con la lista de codigos
        LP_MAPJSONCustomerGetDocuments objClass = new LP_MAPJSONCustomerGetDocuments();
        List<String> responseList = objClass.multipleCall(codeList);

        // se procesa cada una de las respuestas
        LP_JSONCustomerGetDocumentsResponse response;
        
        for (String eachResponse : responseList) {
            response = LP_JSONCustomerGetDocumentsResponse.parse(eachResponse);
            auditCode.put(response.items.get(0).result.get(0).code, response.items.get(0).result.get(0).signers.get(0).audit); 
        } 
        onb.LP_CodigoAuditContratoApertura__c = auditCode.get(onb.LP_CodigoContratoApertura__c);
        onb.LP_CodigoAuditAutorizacionEspecial__c = auditCode.get(onb.LP_CodigoAutorizacionEspecial__c);
        onb.LP_CodigoAuditMandato__c = auditCode.get(onb.LP_CodigoMandato__c);
        onb.LP_CodigoAuditResumenContrato__c = auditCode.get(onb.LP_CodigoResumenContratoApertura__c);
        onb.LP_CodigoAuditConstanciaSuscrip__c = auditCode.get(onb.LP_CodigoConstanciaSuscripcion__c);

        update onb;

        return auditCode;
    } */
    /**
    *  @Description: Create a account user community
    *  @Author:      FO, Deloitte
    *  @Date:        15/07/2021  
    */
    @AuraEnabled
    public static LP_Response createAccountUser(Account acc, String password, boolean updateAcc){

        LP_Response rp = new LP_Response();
        String rutdv = acc.Vass_Rut__c;
        User user = new User();
        Profile pro = [Select id from Profile where name = 'Customer Community User Sitio Privado'];

        try{      
            if(updateAcc){
                update acc;
            } 	            
            user.FirstName = acc.FirstName;
            user.LastName = acc.LastName + ' ' +  acc.LP_ApellidoMaterno__pc;
            user.IsActive = true;
            if(acc.PersonEmail != null){
                user.Email = acc.PersonEmail;
            }
            else{
                user.Email = 'lapolar@lapolar.com';
            }
            user.Username = user.Email + '.LaPolar2' + rutdv;
            user.CommunityNickname = user.Email +'2' + rutdv;
            user.ProfileId = pro.id;            
            Contact cont = [Select Id, name from Contact where AccountId = :acc.Id];
            user.ContactId = cont.Id;
            user.Phone = acc.PersonMobilePhone;
            user.RUT__c = rutdv;
            user.Alias = 'alias1';
            user.TimeZoneSidKey = 'America/Santiago'; // Required
            user.LocaleSidKey = 'en_US'; // Required
            user.EmailEncodingKey = 'ISO-8859-1'; // Required
            user.LanguageLocaleKey = 'en_US'; // Required
	        Site.createExternalUser(user, acc.Id, password, false);
        }
        catch(Exception e){
            rp.message = 'Error en la insercion de la cuenta';
            rp.message = e.getMessage();
            return rp;
        }
        rp.message = 'Usuario creado con exito';
        rp.loginOK = true;
        System.debug('RP_OK: '+rp);
        return rp;
    }

    /**
    *  @Description: Throw an exception if Customer cannot get LP Card
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        09/06/2021
    */  
    public static void throwException(Boolean showError) {
        if (showError) {
            throw new LP_CustomException('Customer cannot get LP Card');
        }
    }
}