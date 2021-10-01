/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 09/06/2021
Description  : OnBoarding - Validations to get La Polar Card
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			09/06/2021		initial version
********************************************************************************/
public without sharing class LP_OnboardingStepOneController extends LP_OnBoardingUtility{

    @AuraEnabled public List<LP_Utility.PathWrapper> pathList {get;set;}
    @AuraEnabled public String siteKey {get; private set;}
    @AuraEnabled public String labels {get; private set;}
    @AuraEnabled public Map<String, LP_ListaNegraRut__mdt> objMapBlackList {get;set;}
    @AuraEnabled public Map<String, LP_OnboardingValidacionFormulario__mdt> objInputError {get;set;}

    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        26/04/2021
    */
    private static final String PRV_OBJ_LPONBOARDING;
    private static final String PRV_OBJ_LEAD;
    private static final String PRV_OBJ_PATH;
    private static final String PRV_URL_RCAPTCHA;
    private static final String PRV_SRV_RCVERIFY;
    private static final LP_ServicioIntegracion__mdt PRV_OBJ_RCAPTCHA;
    private static final String PRV_STR_COD_COUNTRY;
    private static final String PRV_STR_SUCCESS;
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        26/04/2021
    */
    static {
        PRV_OBJ_LPONBOARDING = Schema.SObjectType.LP_OnBoarding__c.getName();
        PRV_OBJ_LEAD = Schema.SObjectType.Lead.getName();
        PRV_OBJ_PATH = Schema.SObjectType.LP_OnBoarding__c.fields.LP_Ruta__c.getName();
        PRV_URL_RCAPTCHA = 'reCaptchaV2';
        PRV_SRV_RCVERIFY = 'VerificacionReCaptcha';
        PRV_OBJ_RCAPTCHA = LP_RestConnectionUtility.PVR_MAP_SERVICE.get(PRV_URL_RCAPTCHA);
        PRV_STR_COD_COUNTRY = '+56';
        PRV_STR_SUCCESS = 'success';
    }

    /**
    *  @Description: Initialize all variables in lightning component
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        26/04/2021
    */
    @AuraEnabled(cacheable=true)
    public static LP_OnboardingStepOneController initClass() {
        try{
            LP_OnboardingStepOneController obj = new LP_OnboardingStepOneController();
            obj.labels = LP_Utility.getDescribedObjects(new List<String>{PRV_OBJ_LEAD});
            obj.siteKey = PRV_OBJ_RCAPTCHA.LP_ClaveDeSitio__c;
            obj.objMapBlackList = fillMapBlackList();
            obj.objInputError = fillMapInputError();
            return obj;
        }catch (Exception e) {
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException(JSON.serialize(ed));
        }
    }

    /**
    *  @Description: Initialize all variables in lightning component
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        26/04/2021
    */
    @AuraEnabled(cacheable=true)
    public static List<LP_Utility.PathWrapper> getPath() {
        List<LP_Utility.PathWrapper> pathList = LP_Utility.getPickListValuesIntoPath(PRV_OBJ_LPONBOARDING, PRV_OBJ_PATH);
        return pathList;        
    }

    /**
    *  @Description: Orchestrate record insertion based on use case
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        09/06/2021
    */
    public static String recordInsertion(SObject record) {
        Lead lead = (Lead)record;
        WrapObject wrap = new WrapObject(new LP_Onboarding__c());
        wrap.rut = lead.LP_Rut__c;
        lead.MobilePhone = PRV_STR_COD_COUNTRY + lead.MobilePhone;
        // It is verified if the onboarding register exists with a related Account
        wrap = getOnboardingObj(wrap);
        if (!wrap.existsAcc) {
            wrap.type = SObjectType.Lead.getName();
            // It is verified if the onboarding register exists with a related Lead
            wrap = getOnboardingObj(wrap);
            // If the lead exists, update it if not create
            wrap = upsertLead(wrap, lead);            
        } else if (wrap.existsAcc) {
            // If the account exists, update it
            wrap = updateAccount(wrap, lead);
        }
        // If the onboarding record exists, it updates it if it does not create it.
        wrap = upsertOnboarding(wrap, lead);
        return wrap.onb.LP_Ruta__c;
    }

    /**
    *  @Description: Upsert Lead
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        09/06/2021
    */   
    public static WrapObject upsertLead(WrapObject wrap, Lead objLead) {
        if (wrap.existsLead) {
            wrap.lead.Email = objLead.Email;
            wrap.lead.FirstName = objLead.FirstName;
            wrap.lead.LastName = objLead.LastName;
            wrap.lead.LP_ApellidoMaterno__c = objLead.LP_ApellidoMaterno__c;
            wrap.lead.LP_Genero__c = objLead.LP_Genero__c;
            wrap.lead.LP_Nacionalidad__c = objLead.LP_Nacionalidad__c;
            wrap.lead.MobilePhone = objLead.MobilePhone;
            wrap.lead.LP_EstadoCuentaMail__c = false;
            update wrap.lead;
        } else {
            objLead.LP_CreadoOnboarding__c = true;   // PCRM-401
            objLead.LP_EstadoCuentaMail__c = false;
            insert objLead;
            wrap.lead = objLead;
        }
        return wrap;
    }

    /**
    *  @Description: Upsert LP_Onboarding__c
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        09/06/2021
    */  
    public static WrapObject upsertOnboarding(WrapObject wrap, Lead objLead) {
        String step = LP_OnBoardingUtility.PBC_STR_STEPTWO;
        wrap.onb.LP_Ruta__c = ((wrap.existsOnb && (wrap.onb.LP_CorreoElectronico__c != objLead.email)) || !wrap.existsOnb) ? step : wrap.onb.LP_Ruta__c;
        if (wrap.existsAcc) {
            wrap.onb.LP_Cuenta__c = wrap.acc.Id;
        } else {
            wrap.onb.LP_Candidato__c = !wrap.existsLead ? wrap.lead.Id : wrap.onb.LP_Candidato__c;
        }
        if( wrap.onb.LP_CorreoElectronico__c != objLead.email ){
            wrap.onb.LP_CorreoValidado__c = false;
            wrap.onb.LP_CodigoOTPEmail__c = '';
        }else if(wrap.onb.LP_CorreoElectronico__c == objLead.email && wrap.onb.LP_CorreoValidado__c){
            wrap.onb.LP_Ruta__c = LP_OnBoardingUtility.PBC_STR_STEPTHREE;
        }
        
        wrap.onb.LP_AceptacionTerminosCondiciones__c = true;
        wrap.onb.LP_CorreoElectronico__c = wrap.existsAcc ? wrap.acc.PersonEmail : wrap.lead.email;        
        upsert wrap.onb;
        LP_OnBoardingUtility.updateClientPath(wrap.onb);  // PCRM-401
        return wrap;
    }

    /**
    *  @Description: Update Account
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        09/06/2021
    */  
    public static WrapObject updateAccount(WrapObject wrap, Lead objLead) {
        wrap.acc.PersonEmail = objLead.Email;
        wrap.acc.FirstName = objLead.FirstName;
        wrap.acc.LastName = objLead.LastName;
        wrap.acc.LP_ApellidoMaterno__pc = objLead.LP_ApellidoMaterno__c;
        wrap.acc.LP_Genero__pc = objLead.LP_Genero__c;
        wrap.acc.LP_Nacionalidad__pc = objLead.LP_Nacionalidad__c;
        wrap.acc.PersonMobilePhone = objLead.MobilePhone;
        update wrap.acc;
        return wrap;
    }

    /**
    *  @Description: Throw an exception if Customer already exists
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        09/06/2021
    */  
    public static void throwException(WrapObject wrap) {
        if (wrap.existsOnb  && wrap.onb.LP_Ruta__c == LP_OnBoardingUtility.PBC_STR_STEPSEVEN) {
            throw new LP_CustomException('Customer already exists');
        }
    }

    /**
    *  @Description: Verify Recaptcha and insert record
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        26/04/2021
    */
    @AuraEnabled
    public static String insertRecord(SObject record, String recaptchaResponse) {
        String step = LP_OnBoardingUtility.PBC_STR_STEPONE;
        try {
            LP_RestConnectionWithAuth objClass = new LP_RestConnectionWithAuth(PRV_URL_RCAPTCHA, PRV_SRV_RCVERIFY);
            String body = 'secret=' + PRV_OBJ_RCAPTCHA.LP_ClaveSecreta__c + '&response=' + recaptchaResponse;
            String rsp = objClass.callService(new Map<String, Map<String, String>>(), body).getBody();
            Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(rsp);
            if (result.containsKey(PRV_STR_SUCCESS) && result.get(PRV_STR_SUCCESS) == true) {
                step = recordInsertion(record);                
            }
        } catch (LP_RestConnectionWithAuth.ServiceException e) {
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, false);
            throw new AuraHandledException (JSON.serialize(data));
        } catch (LP_CustomException e) {
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(null, LP_CustomException.PRV_ERR_EXIST_CLIENT, true);
            throw new AuraHandledException(JSON.serialize(ed));
        } catch (Exception e) {
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException(JSON.serialize(ed));
        }
        return step;
    }

    /**
    *  @Description: Verify client exist in legacy
    *  @Autor:       Eilhert Andrade, Deloitte
    *  @Date:        13/09/2021
    */
    @AuraEnabled
    public static String checkClientExist(String rut){
        String res;
        try{
            
            LP_MAPJSONCustomerGet objClient = new LP_MAPJSONCustomerGet(rut);
            LP_JSONCustomerGetResponse response = (LP_JSONCustomerGetResponse)JSON.deserialize(objClient.call(), LP_JSONCustomerGetResponse.class);

            if(response.Items[0].clienteRut == Integer.valueOf(rut.split('-')[0])){
                throw new LP_CustomException('Customer already exists');
            }
        }catch (LP_CustomException e) {
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(null, LP_CustomException.PRV_ERR_EXIST_CLIENT, true);
            throw new AuraHandledException(JSON.serialize(ed));
        }catch(LP_RestConnectionWithAuth.ServiceException e){
            if(e.code == 422){
                res = null;
            }else{
                system.debug('Exception: '+e);
                LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, false);
                throw new AuraHandledException (JSON.serialize(ed));
            }
        }
        return res;
    }
    /**
    *  @Description: Fill map service, service used in the integration
    *  @Autor:       Abdon Tejos, atejoso@deloitte.com
    *  @Date:        07/05/2021
    */  
    @TestVisible  
    private static Map<String, LP_ListaNegraRut__mdt> fillMapBlackList() {
        Map<String, LP_ListaNegraRut__mdt> objMap = new Map<String, LP_ListaNegraRut__mdt>();
        for (LP_ListaNegraRut__mdt blackList : [SELECT LP_Valor__c, DeveloperName FROM LP_ListaNegraRut__mdt LIMIT 100]) {
            objMap.put(blackList.LP_Valor__c, blackList);
        }
        return objMap;
    }
        
    /**
    *  @Description: Fill map service for input error, service used in the integration
    *  @Autor:       Nelson Lepiqueo
    *  @Date:        17/05/2021
    */  
    @TestVisible  
    private static Map<String, LP_OnboardingValidacionFormulario__mdt> fillMapInputError() {
        Map<String, LP_OnboardingValidacionFormulario__mdt> objMap = new Map<String, LP_OnboardingValidacionFormulario__mdt>();
        for (LP_OnboardingValidacionFormulario__mdt inputErrorList : [SELECT DeveloperName, LP_MensajeError__c, LP_ValidacionVariable__c, LP_MostrarMensaje__c FROM LP_OnboardingValidacionFormulario__mdt LIMIT 100]) {
            objMap.put(inputErrorList.DeveloperName, inputErrorList);
        }
        return objMap;
    }

    @AuraEnabled
    public static String getResourceURL(String resourceName)
    {
        String result = '';
        //Fetching the resource
        LP_StaticResourcesSelector srObj = new LP_StaticResourcesSelector();
        StaticResource resourceList = srObj.selectByStaticResourceNameWithLimit('LP_FaviconOnb');

        //Checking if the result is returned or not
        if(resourceList != null)
        {
            //Getting namespace
            String namespace = resourceList.NamespacePrefix;

            //Resource URL
            result = URL.getOrgDomainUrl().toExternalForm() + '/resource/' + resourceList.SystemModStamp.getTime() + '/' + (namespace != null && namespace != '' ? namespace + '__' : '') + resourceName; 
            result = result.replace('.my.sales', '--c.visual');
        }
        return result;
    }
}