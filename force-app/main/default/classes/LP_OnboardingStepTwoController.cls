/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 17/05/2021
Description  : OnBoarding - Validations to get La Polar Card
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Abdon Tejos Oliva			ATO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      ATO			17/05/2021		initial version
********************************************************************************/
public without sharing class LP_OnboardingStepTwoController extends LP_OnBoardingUtility{

    private static LP_BasesExpressSelector baseExpressSelector;
    private static LP_NacionalidadesSelector countrySelector;

    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        10/09/2021
    */
    private static final String PVR_STR_INITVECTOR;
    private static final String PVR_STR_KEY;
    private static final String PVR_B64_INITVECTOR;

    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        10/09/2021
    */
    static {
        PVR_STR_INITVECTOR = LP_CryptoClassUtility.setCacheValues().values()[0];
        PVR_STR_KEY = (new List<String>(LP_CryptoClassUtility.setCacheValues().keySet()))[0];
        PVR_B64_INITVECTOR = EncodingUtil.base64Encode(Blob.valueOf(PVR_STR_INITVECTOR));
    }

    /**
    *  @Description: Call to service to get OTP code
    *  @Author:      Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        17/05/2021
    */
    @AuraEnabled
    public static String callToOtpService(Lead objLead, String userEmail) {

        try {
            objLead.Email = userEmail;
            LP_MAPJSONOTPValidation objMapClass = new LP_MAPJSONOTPValidation(objLead);
            String rsp = objMapClass.call().getBody();
            LP_JSONOTPResponse otp = (LP_JSONOTPResponse)JSON.deserialize(rsp, LP_JSONOTPResponse.class);
            String code = otp.items?.get(0).data;
            code = LP_CryptoClassUtility.encrypt(code, PVR_STR_KEY, PVR_STR_INITVECTOR);
            return code;
        } catch (Exception e) {
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data));
        }
    }

    /**
    *  @Description: OTP code validation
    *  @Author:      Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        10/09/2021
    */
    @AuraEnabled
    public static Boolean otpCodeValidation(String inputCode, String cipherCode) {
        Boolean isValid = false;
        try {
            String decryptCode = LP_CryptoClassUtility.decrypt(cipherCode, PVR_STR_KEY, PVR_B64_INITVECTOR);
            if (inputCode == decryptCode) {
                isValid = true;
            } else {
                throw new LP_CustomException('Invalid OTP Code');
            }
            return isValid;
        } catch (Exception e) {
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, false);
            throw new AuraHandledException (JSON.serialize(data));
        }
    }    

    /**
    *  @Description: Update lead and onboading objects with otp validation
    *  @Author:      Abdón Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        17/05/2021
    */  
    @AuraEnabled
    public static Boolean updateObjs(Lead objLead, String userEmail, String otpCode) {
        try {
            objLead.Email = userEmail;
            WrapObject wrap = new WrapObject(new LP_Onboarding__c());
            wrap.rut = objLead.LP_Rut__c;
            wrap = getOnboardingObj(wrap);
            if (!wrap.existsAcc) {
                wrap.type = SObjectType.Lead.getName();
                wrap = getOnboardingObj(wrap);
                wrap.lead.Email = objLead.Email;
                update wrap.lead;
            } else {
                wrap.acc.PersonEmail = objLead.Email;
                update wrap.acc;
            }
            wrap.onb.LP_CorreoValidado__c = true;
            wrap.onb.LP_CodigoOTPEmail__c = LP_CryptoClassUtility.decrypt(otpCode, PVR_STR_KEY, PVR_B64_INITVECTOR);
            wrap.onb.LP_CorreoElectronico__c = objLead.Email;
            update wrap.onb;
            return true;
        } catch (Exception e) {
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data));
        }
    }

    /*
    *  @Description: Check if the user exists in Base Express
    *  @Autor:       Alan Sanhueza, Deloitte
    *  @Date:        12/05/2021
    */
    @AuraEnabled
    public static String expressBaseValidation(Lead objLead) {
        // Method refactoring by Abdon Tejos 03/06/2021
        try {
            baseExpressSelector = new LP_BasesExpressSelector();
            WrapObject wrap = new WrapObject(new LP_Onboarding__c());
            wrap.rut = objLead.LP_Rut__c;
            Boolean xpressValidation = false;
            try {
                LP_Base_Express__c bsexp = baseExpressSelector.selectByRutWithLimit(objLead.LP_Rut__c);
                xpressValidation = true;
            } catch (QueryException e) {
                xpressValidation = false;
            }
            wrap = getOnboardingObj(wrap);
            if (!wrap.existsAcc) {
                wrap.type = SObjectType.Lead.getName();
                wrap = getOnboardingObj(wrap);
            }
            LP_Onboarding__c onbUpdate = wrap.onb;
            onbUpdate.LP_BaseExpressValidado__c = xpressValidation;
            update onbUpdate;

            List<Object> sObjList = new List<Object>();
            sObjList.add(objLead);
            sObjList.add(onbUpdate);
            return LP_CryptoClassUtility.encrypt(JSON.serialize(sObjList), PVR_STR_KEY, PVR_STR_INITVECTOR);
        } catch (Exception e) {
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data));
        }
    }

    /**
    *  @Description: Verify Customer Asset Laundering
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        14/05/2021
    */
    @AuraEnabled
    public static String customerAssetLaundering(String sObjList) {
        // Method refactoring by Abdon Tejos 03/06/2021
        List<Object> sObjListRtn = new List<Object>();
        try {
            String jsonDecrypt = LP_CryptoClassUtility.decrypt(sObjList, PVR_STR_KEY, PVR_B64_INITVECTOR);
            List<Object> listObj = (List<Object>)JSON.deserializeUntyped(jsonDecrypt);
            countrySelector = new LP_NacionalidadesSelector();
            WrapObject wrap = new WrapObject(new LP_Onboarding__c());
            Lead leadObj = (Lead)JSON.deserialize(JSON.serialize(listObj[0]), Lead.class);
            wrap.rut = leadObj.LP_Rut__c;
            LP_Onboarding__c onb = (LP_Onboarding__c)JSON.deserialize(JSON.serialize(listObj[1]), LP_Onboarding__c.class);
            listObj.clear();
            String cntCode;
            wrap = getOnboardingObj(wrap);
            if (!wrap.existsAcc) {
                wrap.type = SObjectType.Lead.getName();
                wrap = getOnboardingObj(wrap);
                cntCode = countrySelector.selectByIdWithLimit(wrap.lead.LP_Nacionalidad__c).LP_Pais__c;
            } else {                
                cntCode = countrySelector.selectByIdWithLimit(wrap.acc.LP_Nacionalidad__pc).LP_Pais__c;
            }  
          
            if(onb.LP_BaseExpressValidado__c == true){
                LP_MAPJSONAssetLaundValidation objClass = new LP_MAPJSONAssetLaundValidation(leadObj, cntCode.touppercase());
                LP_JSONAssetLaundResponse response = (LP_JSONAssetLaundResponse)JSON.deserialize(objClass.call(), LP_JSONAssetLaundResponse.class);
                onb.LP_IdentificacionLavadoActivos__c = String.valueOf(response.items[0].estatus);
                onb.LP_LavadoActivosValidado__c = (response.items[0].estatus == 0) ? true : false;
                update onb;
            }            
            sObjListRtn.add(leadObj);
            sObjListRtn.add(onb);
        } catch (Exception e) {
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data));
        }
        return LP_CryptoClassUtility.encrypt(JSON.serialize(sObjListRtn), PVR_STR_KEY, PVR_STR_INITVECTOR);
    }

    /**
    *  @Description: Verify Customer Asset Laundering
    *  @Autor:       Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        14/05/2021
    */
    @AuraEnabled
    public static String validateClientEquifax(String sObjList) {
        // Method refactoring by Abdon Tejos 03/06/2021        
        try {
            String jsonDecrypt = LP_CryptoClassUtility.decrypt(sObjList, PVR_STR_KEY, PVR_B64_INITVECTOR);
            List<Object> listObj = (List<Object>)JSON.deserializeUntyped(jsonDecrypt);
            Lead leadObj = (Lead)JSON.deserialize(JSON.serialize(listObj[0]), Lead.class);
            LP_Onboarding__c onb = (LP_Onboarding__c)JSON.deserialize(JSON.serialize(listObj[1]), LP_Onboarding__c.class);
            listObj.clear();
            LP_MAPJSONEquifaxValidation objClass = new LP_MAPJSONEquifaxValidation(leadObj);
            LP_JSONEquifaxResponse response = (LP_JSONEquifaxResponse)JSON.deserialize(objClass.call(), LP_JSONEquifaxResponse.class);
            if(onb.LP_BaseExpressValidado__c == true){
                onb.LP_InformesComercialesValidado__c = (response.items[0].unpaidTotalNumber == '0' && Integer.valueOf(response.items[0].score) >= 500) ? true : false;
                onb.LP_Score__c = Integer.valueOf(response.items[0].score);
            }

            Boolean showError = !onb.LP_BaseExpressValidado__c || !onb.LP_LavadoActivosValidado__c || !onb.LP_InformesComercialesValidado__c ? true : false;

            onb.LP_Ruta__c = showError ? LP_OnBoardingUtility.PBC_STR_STEPTWO : LP_OnBoardingUtility.PBC_STR_STEPTHREE;
            update onb;
            LP_OnBoardingUtility.updateClientPath(onb);     //PCRM-401
            return (showError)? 'error' : onb.LP_Ruta__c;

        } catch (Exception e) {
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data));
        }
    }
    
}