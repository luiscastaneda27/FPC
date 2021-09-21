/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 03/06/2021
Description  : Class controller for step 3
History      : PCRM-15
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez	EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      EAA			03/06/2021		initial version
1.1      EAA            10/06/2021      Method for AOE-1344 IdentCheck
********************************************************************************/

public without sharing class LP_OnboardingStepThreeController extends LP_OnBoardingUtility{
    
    private static final String PRV_URL_BASEURL;
    private static final String PVR_SRV_AZURIAN;
    private static final String PVR_ACT_JUMIO_INIT;
    private static final String PVR_ACT_JUMIO_REQ;
    private static final String PVR_ACT_AZURIAN_INIT;
    private static final String PVR_ACT_IDENTCHK_APRV;
    private static final String PVR_ACT_IDENTCHK_SIMIL;
    private static final String PVR_STATUS_FAILED;
    
    private static final String PVR_STR_INITVECTOR;
    private static final String PVR_STR_KEY;
    private static final String PVR_B64_INITVECTOR;

    static{
        PRV_URL_BASEURL = 'URL_Base_Integracion';
        PVR_SRV_AZURIAN = 'ValidacionAzurian';
        PVR_ACT_JUMIO_INIT = 'init_jumio';
        PVR_ACT_JUMIO_REQ = 'request_jumio';
        PVR_ACT_AZURIAN_INIT = 'init_azurian';
        PVR_ACT_IDENTCHK_APRV = 'RUT COINCIDE';
        PVR_ACT_IDENTCHK_SIMIL = 'MATCH';
        PVR_STATUS_FAILED = 'FAILED';
        PVR_STR_INITVECTOR = LP_CryptoClassUtility.setCacheValues().values()[0];
        PVR_STR_KEY = (new List<String>(LP_CryptoClassUtility.setCacheValues().keySet()))[0];
        PVR_B64_INITVECTOR = EncodingUtil.base64Encode(Blob.valueOf(PVR_STR_INITVECTOR));
    }

    /**
    *  @Description: Customer Azurian Init validation
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        03/06/2021
    */
    @AuraEnabled
    public static List<String> customerAzurianInit(SObject record, String url) {

        try{
            Lead objLead = (Lead)record; 
            LP_Onboarding__c resOnb = new LP_Onboarding__c();
            LP_OnboardingSelector onbSelector = new LP_OnboardingSelector();
            resOnb = onbSelector.selectByLeadRutWithLimit(objLead.LP_Rut__c);
            resOnb.LP_GUIDIdentCheck__c = LP_RestConnectionUtility.getGUID();
            String identCheckencrypt = LP_CryptoClassUtility.encrypt(resOnb.LP_GUIDIdentCheck__c, PVR_STR_KEY, PVR_STR_INITVECTOR);
            
            Map<String, String> params = new Map<String, String>();
            params.put('action',PVR_ACT_JUMIO_INIT);
            params.put('scanreference',null);
            params.put('guid',resOnb.LP_GUIDIdentCheck__c);
            params.put('url',url);
            system.debug('params: '+params);
            LP_MAPJSONAzurianValidation objClass = new LP_MAPJSONAzurianValidation(record, params);
            LP_JSONAzurianResponse response = new LP_JSONAzurianResponse();
            List<String> result = new List<String>();
            response = response.parse(objClass.call());
            update resOnb;
            system.debug('response: '+response);
            //URL to redirect Biometric validation system
            result.add(response.items[0].transactionReference);
            result.add(response.items[0].redirectUrl);

            return result;

        }catch(Exception e){
            
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data));
        }
    }
    
    /**
    *  @Description: Customer Azurian Consult validation
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        03/06/2021
    */
    @AuraEnabled
    public static String customerAzurianConsult(SObject record, String transRef, String url) {

        try{
            Map<String, String> params = new Map<String, String>(); 
            params.put('action',PVR_ACT_JUMIO_REQ);
            params.put('scanreference',transRef);
            params.put('guid',null);
            params.put('url',url);
            LP_MAPJSONAzurianValidation objClass = new LP_MAPJSONAzurianValidation(record, params);
            LP_JSONAzurianResponse response = new LP_JSONAzurianResponse();
            response = response.parse(objClass.call());
            if(response.items[0].status == PVR_STATUS_FAILED){
                throwException(true);
            }
            return ''+response.items[0].status;
        } catch (LP_CustomException e) {
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(null, LP_CustomException.PRV_ERR_NOCARD, false);
            throw new AuraHandledException (JSON.serialize(data));
        }catch(Exception e){
            
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data));
        }
    }

    /**
    *  @Description: Customer Azurian Validate 
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        04/06/2021
    */
    @AuraEnabled
    public static List<String> customerAzurianValidate(SObject record, String transRef, String url) {
        
        List<String> result = new List<String>();
        try{
            Map<String, String> params = new Map<String, String>(); 
            params.put('action',PVR_ACT_AZURIAN_INIT);
            params.put('scanreference',transRef);
            params.put('guid',null);
            params.put('url',url);
            //System.debug('params: '+params);
            LP_JSONAzurianResponse response = new LP_JSONAzurianResponse();
            LP_MAPJSONAzurianValidation objClass = new LP_MAPJSONAzurianValidation(record, params);
            response = response.parse(objClass.call());
            result.add(response.items[0].contents);
            result.add(response.items[0].token);
            //System.debug('result: '+result);
            return result;
        }catch(Exception e){
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            System.debug('Error_customerAzurianValidate: '+data);
        }
        return result;
    }

    /**
    *  @Description: Customer OnBoarding Biometric Validation Check Success 
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        07/06/2021
    */
    public static void onBoardingBiometricCheckSuccess(LP_Onboarding__c objOnb){
        try{
            objOnb.LP_ValidacionIdentidadCompletadaExitosa__c = true;
            update objOnb;
            LP_OnBoardingUtility.updateClientPath(objOnb);     //PCRM-401
        }catch(Exception e){
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            System.debug('Error_updatingOnboardingData: '+data);
		}
        
    }

    /**
    *  @Description: Customer OnBoarding update record 
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        09/06/2021
    */
    public static String onBoardingUpd(LP_Onboarding__c objOnb, LP_JSONIdentCheckResponse objIdentChk, String leadRut){
        
        try{
            String rut = objIdentChk.items[0].documento.rut;
            objOnb.LP_RutValidacionBiometrica__c = rut.replace(' ','-');
            objOnb.LP_NumeroDocumento__c = Integer.valueOf(objIdentChk.items[0].documento.numero);
            objOnb.LP_NombresValidacionBiometrica__c = objIdentChk.items[0].documento.nombres;
            objOnb.LP_ApellidosValidacionBiometrica__c = objIdentChk.items[0].documento.apellidos;
            objOnb.LP_NacionalidadValidacionBiometrica__c = objIdentChk.items[0].documento.nacionalidad;
            objOnb.LP_FechaVencimientoCedulaIdentidad__c = Date.valueOf(objIdentChk.items[0].documento.fechaExpiracion);
            objOnb.LP_FechaNacimiento__c = Date.valueOf(objIdentChk.items[0].documento.fechaNacimiento);
            objOnb.LP_ValidacionIdentidadCompletada__c = true;
            objOnb.LP_ValidacionIdentidadCompletadaExitosa__c = false;
            System.debug('RutServ: '+rut.replace(' ','-'));
            System.debug('RutLead: '+leadRut);
            if(objIdentChk.items[0].verificacion.coincidencia == PVR_ACT_IDENTCHK_APRV 
            && objIdentChk.items[0].verificacion.similitud == PVR_ACT_IDENTCHK_SIMIL
            && rut.replace(' ','-') == leadRut){
                objOnb.LP_ValidacionIdentidadCompletadaExitosa__c = true;
                update objOnb;
                LP_OnBoardingUtility.updateClientPath(objOnb);     //PCRM-401 Update account
                return objIdentChk.items[0].verificacion.coincidencia;
            }else{
                update objOnb; 
                throwException(true);
            }
        }catch (LP_RestConnectionWithAuth.ServiceException e) {
            if(e.code == 404 || e.code == 500){
                LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
                throw new AuraHandledException (JSON.serialize(data));
            }else{
                LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(null, LP_CustomException.PRV_ERR_NOCARD, false);
                throw new AuraHandledException (JSON.serialize(data));
            }
        }catch(Exception e){
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            System.debug('Error_updatingOnboardingData: '+data);
        }
        return null; 
    }

    /**
    *  @Description: Customer Ident Check validation
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        10/06/2021
    */
    @AuraEnabled
    public static String customerIdentCheck(SObject record, String transRef) {

        try{
            Lead objLead = (Lead)record; 
            LP_Onboarding__c resOnb = new LP_Onboarding__c();
            LP_OnboardingSelector onbSelector = new LP_OnboardingSelector();
            resOnb = onbSelector.selectByLeadRutWithLimit(objLead.LP_Rut__c);

            LP_MAPJSONIdentCheckValidation objClass = new LP_MAPJSONIdentCheckValidation(record, transRef);
            LP_JSONIdentCheckResponse response = new LP_JSONIdentCheckResponse();
            response = response.parse(objClass.call());
            system.debug('customerIdenChk: '+response);
            String identVerify = onBoardingUpd(resOnb, response, objLead.LP_Rut__c);
            if(identVerify == null){
                throwException(true);
            }
            return identVerify;

        }catch (LP_RestConnectionWithAuth.ServiceException e) {
            system.debug('e.code: '+e.code);
            if(e.code == 404 || e.code == 500){
                LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
                throw new AuraHandledException (JSON.serialize(data));
            }else{
                LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(null, LP_CustomException.PRV_ERR_NOCARD, false);
                throw new AuraHandledException (JSON.serialize(data));
            }
        }catch (LP_CustomException e) {
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(null, LP_CustomException.PRV_ERR_NOCARD, false);
            throw new AuraHandledException (JSON.serialize(data));
        }catch(Exception e){
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data));
        }
    
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

    /**
    *  @Description: Get GUID from Onboarding by RUT
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        14/06/2021
    */
    @AuraEnabled
    public static SObject getGUIDOnboardingByRUT(String guid){
        try {
            LP_Onboarding__c resOnb = new LP_Onboarding__c();
            LP_OnboardingSelector onbSelector = new LP_OnboardingSelector();
            Lead resLead = new Lead();
            LP_LeadsSelector leadSelector = new LP_LeadsSelector();
            
            resOnb = onbSelector.selectByGUIDWithLimit(guid);
            resLead = leadSelector.selectByLeadIdWithLimit(resOnb.LP_Candidato__c);
            return resLead;
        } catch (Exception e) {
            return null;
        }
    }
}