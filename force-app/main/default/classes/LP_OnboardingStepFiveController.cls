/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 06/07/2021
Description  : Onboarding - Step 6 of the Path
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			06/07/2021		initial version
********************************************************************************/
public without sharing class LP_OnboardingStepFiveController extends LP_OnBoardingUtility{

    private static LP_ConfiguracionDocumentosSelector setupDocumentsSelector;
    private static LP_BasesExpressSelector baseExpressSelector;
    @AuraEnabled public Map<String, String> codeDocuments {get; private set;}
    @AuraEnabled public Lead leadObj {get; private set;}

    /**
    *  @Description: Set the documents for the card type
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        08/07/2021
    */
    @AuraEnabled
    public static LP_OnboardingStepFiveController setDocuments(Lead lead) {
        LP_OnboardingStepFiveController initObj = new LP_OnboardingStepFiveController();
        initObj.codeDocuments = new Map<String, String>();
        initObj.leadObj = new Lead();
        WrapObject wrap = new WrapObject(new LP_Onboarding__c());
        setupDocumentsSelector = new LP_ConfiguracionDocumentosSelector();
        baseExpressSelector = new LP_BasesExpressSelector();
        Map<String, String> mapDocuments = new Map<String, String>(); 
        try {
            wrap.rut = lead.LP_Rut__c;
            // It is verified if the onboarding register exists with a related Account
            wrap = getOnboardingObj(wrap);
            
            if (!wrap.existsAcc) {
                wrap.type = SObjectType.Lead.getName();
                // It is verified if the onboarding register exists with a related Lead
                wrap = getOnboardingObj(wrap);
                lead.LP_TipoTarjeta__c = wrap.lead.LP_TipoTarjeta__c;
                lead.LP_CupoDisponible__c =  wrap.lead.LP_CupoDisponible__c;
            } else if (wrap.existsAcc) {
                // Customer already exists
                lead.LP_TipoTarjeta__c = wrap.acc.LP_TipoTarjeta__pc;
                lead.LP_CupoDisponible__c = wrap.acc.LP_CupoDisponible__pc;
            }
            List<LP_ConfiguracionDocumentos__mdt> docs = setupDocumentsSelector.selectByCreditCardTypeWithLimit(lead.LP_TipoTarjeta__c, LP_OnBoardingUtility.PBC_MAP_DOCBYTYPECARD.get(lead.LP_TipoTarjeta__c));
            LP_MAPJSONCustomerContractCreate objClass = new LP_MAPJSONCustomerContractCreate(docs, lead, wrap.onb);
            mapDocuments = objClass.call();
            String keyDocTwo = objClass.isVisa ? LP_OnBoardingUtility.PBC_STR_NAMEDOCTWOVISA : LP_OnBoardingUtility.PBC_STR_NAMEDOCTWO;
            LP_JSONCustomerContractCreateResponse docOne = (LP_JSONCustomerContractCreateResponse)JSON.deserialize(mapDocuments.get(LP_OnBoardingUtility.PBC_STR_NAMEDOCONE), LP_JSONCustomerContractCreateResponse.class);
            LP_JSONCustomerContractCreateResponse docTwo = (LP_JSONCustomerContractCreateResponse)JSON.deserialize(mapDocuments.get(keyDocTwo), LP_JSONCustomerContractCreateResponse.class);
            LP_JSONCustomerContractCreateResponse docThree = (LP_JSONCustomerContractCreateResponse)JSON.deserialize(mapDocuments.get(LP_OnBoardingUtility.PBC_STR_NAMEDOCTHREE), LP_JSONCustomerContractCreateResponse.class);
            LP_JSONCustomerContractCreateResponse docFour = (LP_JSONCustomerContractCreateResponse)JSON.deserialize(mapDocuments.get(LP_OnBoardingUtility.PBC_STR_NAMEDOCFOUR), LP_JSONCustomerContractCreateResponse.class);
            wrap.onb.LP_CodigoAutorizacionEspecial__c = docOne?.items[0]?.result?.code;
            wrap.onb.LP_CodigoContratoApertura__c = docTwo?.items[0]?.result?.code;
            wrap.onb.LP_CodigoMandato__c = docThree?.items[0]?.result?.code;
            wrap.onb.LP_CodigoResumenContratoApertura__c = docFour?.items[0]?.result?.code;
            initObj.codeDocuments.put(LP_OnBoardingUtility.PBC_STR_NAMEDOCONE, docOne?.items[0]?.result?.code);
            initObj.codeDocuments.put(keyDocTwo, docTwo?.items[0]?.result?.code);
            initObj.codeDocuments.put(LP_OnBoardingUtility.PBC_STR_NAMEDOCTHREE, docThree?.items[0]?.result?.code);
            initObj.codeDocuments.put(LP_OnBoardingUtility.PBC_STR_NAMEDOCFOUR, docFour?.items[0]?.result?.code);
            update wrap.onb;
        } catch (LP_RestConnectionWithAuth.ServiceException e) {
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, false);
            throw new AuraHandledException (JSON.serialize(data));
        } catch (Exception e) {
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException(JSON.serialize(ed));
        }
        initObj.leadObj = lead;
        return initObj;
    }

    /**
    *  @Description: Get the document link
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        08/07/2021
    */
    @AuraEnabled
    public static String getDocuments(String code) {
        String link;
        try {
            LP_MAPJSONCustomerGetDocuments objClass = new LP_MAPJSONCustomerGetDocuments(code);
            LP_JSONCustomerGetDocumentsResponse response = (LP_JSONCustomerGetDocumentsResponse)JSON.deserialize(objClass.call(), LP_JSONCustomerGetDocumentsResponse.class);
            link = response?.items[0]?.result[0]?.file_preview;
        } catch (LP_RestConnectionWithAuth.ServiceException e) {
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, false);
            throw new AuraHandledException (JSON.serialize(data));
        } catch (Exception e) {
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException(JSON.serialize(ed));
        }
        return link;
    }

    /**
    *  @Description: Update to step 6 of the Path
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        08/07/2021
    */
    @AuraEnabled
    public static String getNextStep(Lead lead) {
        WrapObject wrap = new WrapObject(new LP_Onboarding__c());
        try {
            wrap.rut = lead.LP_Rut__c;
            // It is verified if the onboarding register exists with a related Account
            wrap = getOnboardingObj(wrap);
            if (!wrap.existsAcc) {
                wrap.type = SObjectType.Lead.getName();
                // It is verified if the onboarding register exists with a related Lead
                wrap = getOnboardingObj(wrap);
                wrap.lead.LP_AceptacionContratos__c = true;
                update wrap.lead;
            } else if (wrap.existsAcc) {
                wrap.acc.LP_AceptacionContratos__pc = true;
                update wrap.acc;
            }
            wrap.onb.LP_AceptacionContratos__c = true;
            wrap.onb.LP_Ruta__c = LP_OnBoardingUtility.PBC_STR_STEPSIX;
            update wrap.onb;
            system.debug('obn'+wrap.onb);
        } catch (Exception e) {
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException(JSON.serialize(ed));
        }
        return wrap.onb.LP_Ruta__c;
    }

}