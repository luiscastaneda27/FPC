/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 17/05/2021
Description  : OnBoarding - Information Data Personal and used make google api callouts and get the response Controllet
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Leonardo Muñoz				LMG
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      LMG			28/05/2021		initial version
********************************************************************************/
public without sharing class LP_OnboardingStepFourController {
    
    @AuraEnabled public List<String> objImgList {get;set;}
    @AuraEnabled public List<String> objVideoList {get;set;}
    
    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        01/05/2021
    */
    private static final String PRV_URL_APIGOOGLE;
    private static final String PRV_SRV_API_GOOGLE_AUTOCOMPLETE;
    private static final String PRV_SRV_API_GOOGLE_DETAIL;
    private static final LP_ServicioIntegracion__mdt PRV_OBJ_APIGOOGLE;
    private static final LP_RutaIntegracion__mdt PRV_OBJ_API_GOOGLE_AUTOCOMPLETE;
    private static final LP_RutaIntegracion__mdt PRV_OBJ_API_GOOGLE_DETAIL;
    private static final String PVR_OBJ_STATIC_RESOURCE_IMG;
    private static final String PVR_OBJ_STATIC_RESOURCE_VIDEO;
    private static String PRV_ERR_SYSTEM_exception;
    private static final String BECLEVER_DESCRIPTION;
    private static final String BECLEVER_VALUE;
    private static final String BECLEVER_CRED_LIMIT;
    private static final String BECLEVER_CIVIL_STATE;
    private static final String PRV_SRV_CARDTYPE_TLP;
    private static final String PRV_SRV_CARDTYPE_TLPVISA;
    private static final String DEFAULT_CIVIL_STATE;

    /**
    *  @Description: Initialization of static variables
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        01/05/2021
    */
    static {
        PRV_URL_APIGOOGLE = 'Google_Maps';
        PRV_SRV_API_GOOGLE_AUTOCOMPLETE ='GoogleMapsAutoComplete';
        PRV_SRV_API_GOOGLE_DETAIL ='GoogleMapsAutoDetail';
        PRV_OBJ_APIGOOGLE = LP_RestConnectionUtility.PVR_MAP_SERVICE.get(PRV_URL_APIGOOGLE);
        PRV_OBJ_API_GOOGLE_AUTOCOMPLETE = LP_RestConnectionUtility.PVR_MAP_PATH.get(PRV_SRV_API_GOOGLE_AUTOCOMPLETE);
        PRV_OBJ_API_GOOGLE_DETAIL = LP_RestConnectionUtility.PVR_MAP_PATH.get(PRV_SRV_API_GOOGLE_DETAIL);
        PVR_OBJ_STATIC_RESOURCE_IMG = 'imagen';
        PVR_OBJ_STATIC_RESOURCE_VIDEO = 'video';
        PRV_ERR_SYSTEM_exception = '';
        BECLEVER_DESCRIPTION ='BestResolutionCode';
        BECLEVER_CRED_LIMIT = 'BestCreditLimit';
        BECLEVER_CIVIL_STATE = 'Estado civil';
        BECLEVER_VALUE ='APR';
        PRV_SRV_CARDTYPE_TLP = '01'; // Cambiado por FRAN 07-19-21 antes era TLP
        PRV_SRV_CARDTYPE_TLPVISA = '02'; // Cambiado por FRAN 07-19-21 antes era TLP Visa
        DEFAULT_CIVIL_STATE = 'Soltero(a)';
    }

    /**
    *  @Description: Get address of autocomplete google Api 
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        01/05/2021
    */
    @TestVisible
    @AuraEnabled
    public static string getAddressAutoComplete(String input) {
        String returnStr = '';
        try{
            String url = PRV_OBJ_APIGOOGLE.LP_URLBase__c + PRV_OBJ_API_GOOGLE_AUTOCOMPLETE.LP_RutaURL__c
            + EncodingUtil.urlEncode(input, 'UTF-8')
            + '&key=' + PRV_OBJ_APIGOOGLE.LP_ClaveSecreta__c;
            returnStr = getHttp(url);
        }
        catch(Exception e){
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, '', true);
            throw new AuraHandledException (JSON.serialize(data));
        }
        return returnStr;
    }

    /**
    *  @Description: Get detail address google Api 
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        01/05/2021
    */
    @TestVisible
    @AuraEnabled
    public static string getAddressDetails(String placeId) {
        String returnStr = '';
        try{
        String url = PRV_OBJ_APIGOOGLE.LP_URLBase__c + PRV_OBJ_API_GOOGLE_DETAIL.LP_RutaURL__c 
            +placeId+'&key='+ PRV_OBJ_APIGOOGLE.LP_ClaveSecreta__c;
            returnStr = getHttp(url);
        } catch(Exception e){
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, '', true);
            throw new AuraHandledException (JSON.serialize(data));    
        }
        return returnStr;
    }
    /**
    *  @Description: connect google Api 
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        01/05/2021
    */
    @TestVisible
    private static string getHttp(String url){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        //system.debug('response API google: ' + response.getBody());
        return response.getBody();        
    } 
    /**
    *  @Description: update data lead or account 
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        08/05/2021
    */
    @TestVisible
    @AuraEnabled
    public static Map<String,String> updateLeadOrAccount(SObject getRecord) {
        Map<String ,String> outputMap = new Map<String, String>();
        WrapObject wrp = new WrapObject(new Account(), new Lead());
        Lead leadInsert = (Lead)getRecord;
        wrp.rut = leadInsert.LP_Rut__c;
		try{
            wrp.typeObj = 'Account';
            wrp = getObjectOnb(wrp);

            if(wrp.existsAcc){
                Account acc = new Account();
                acc = wrp.acc;
                acc.PersonMailingStreet = leadInsert.Street;
                acc.PersonMailingCity = leadInsert.City;
                acc.PersonMailingState = leadInsert.State;
                acc.PersonMailingCountry = leadInsert.Country;
                acc.LP_FechaPago__pc = leadInsert.LP_FechaPago__c;
                acc.LP_Ocupacion__pc = leadInsert.LP_Ocupacion__c;
                acc.LP_NivelEducacional__pc = leadInsert.LP_NivelEducacional__c;
                acc.LP_Ciudad__pc = leadInsert.LP_Ciudad__c;
                acc.LP_NumDeptoCasa__pc = leadInsert.LP_NumDeptoCasa__c;
                acc.LP_EstadoCuentaMail__pc = leadInsert.LP_EstadoCuentaMail__c;
                update acc;
            } 
            else {
                wrp.typeObj = 'Lead';
                wrp = getObjectOnb(wrp);        
                if(wrp.existsLead){
                    Lead lead = new Lead();
                    lead = wrp.lead;
                    lead.Street = leadInsert.Street;
                    lead.City = leadInsert.City;
                    lead.State = leadInsert.State;
                    lead.Country = leadInsert.Country;
                    lead.LP_FechaPago__c = leadInsert.LP_FechaPago__c;
                    lead.LP_Ocupacion__c = leadInsert.LP_Ocupacion__c;
                    lead.LP_NivelEducacional__c = leadInsert.LP_NivelEducacional__c;
                    lead.LP_Ciudad__c = leadInsert.LP_Ciudad__c;
                    lead.LP_NumDeptoCasa__c = leadInsert.LP_NumDeptoCasa__c;
                    lead.LP_EstadoCuentaMail__c = leadInsert.LP_EstadoCuentaMail__c;
                    update lead;
                }
            }
            
            LP_OnBoardingUtility.WrapObject wrap = new LP_OnBoardingUtility.WrapObject(new LP_Onboarding__c());
            wrap.rut = wrp.rut;
            wrap.type = wrp.typeObj;
            wrap = LP_OnBoardingUtility.getOnboardingObj(wrap);
            wrap.onb.LP_DatosPersonalesCompletados__c = true;    // PCRM-401
            wrap.onb.LP_Ruta__c = LP_OnBoardingUtility.PBC_STR_STEPFOUR;
            upsert wrap.onb;

            outputMap.put('LP_Ruta', LP_OnBoardingUtility.PBC_STR_STEPFOUR);
            outputMap.put('Message', '' );
            Return outputMap;

        } catch(System.DMLException e){
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException(JSON.serialize(ed));
        } catch(Exception e){
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException(JSON.serialize(ed));
        }
    }
    /**
    *  @Description: update onboarding step when the lwc button is clicked
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        08/05/2021
    */
    @TestVisible
    @AuraEnabled
    public static Map<String,String> updateOnboardingStep(SObject record) {
        Map<String ,String> outputMap = new Map<String, String>();
        WrapObject wrp = new WrapObject(new Account(), new Lead());
        Lead leadInsert = (Lead)record;
        wrp.rut = leadInsert.LP_Rut__c;
        try {
            wrp.typeObj = 'Account';
            wrp = getObjectOnb(wrp);

            if(!wrp.existsAcc){ 
                wrp.typeObj = 'Lead';
                wrp = getObjectOnb(wrp);        
            }

            LP_OnBoardingUtility.WrapObject wrap = new LP_OnBoardingUtility.WrapObject(new LP_Onboarding__c());
            wrap.rut = wrp.rut;
            wrap.type = wrp.typeObj;
            wrap = LP_OnBoardingUtility.getOnboardingObj(wrap);
            wrap.onb.LP_Ruta__c = LP_OnBoardingUtility.PBC_STR_STEPFIVE;
            upsert wrap.onb;
            LP_OnBoardingUtility.updateClientPath(wrap.onb);    // PCRM-401

            outputMap.put('LP_Ruta', wrap.onb.LP_Ruta__c);
            outputMap.put('Message', '' );
            Return outputMap;

        } catch(System.DMLException e){
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException(JSON.serialize(ed));
        } catch(Exception e){
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException(JSON.serialize(ed));
        }
    }

    /**
    *  @Description: Get objects Account and Lead
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        08/06/2021
    */
    @TestVisible
    private static WrapObject getObjectOnb(WrapObject wrp) {
        try{
            if(wrp.typeObj == 'Account'){
                LP_AccountsSelector onAccountSelector = new LP_AccountsSelector();
                wrp.acc = onAccountSelector.selectPersonAccountByRut(wrp.rut);
                wrp.existsAcc = true;
            } else 
            if(wrp.typeObj == 'Lead'){
                LP_LeadsSelector onLeadSelector = new LP_LeadsSelector();
                wrp.lead = onLeadSelector.selectByRutWithLimit(wrp.rut);
                wrp.existsLead = true;
            }
        }
        catch(Exception e){
           system.debug('Error getObjectOnb:'+ e.getMessage());
        }
        return wrp;
    }

    /**
    *  @Description: Get extension static resource
    *  @Autor:       Nelson Lepiqueo, Deloitte
    *  @Date:        11/06/2021
    */
    @TestVisible 
    @AuraEnabled
    public static String getStaticResource(String nameStatic) {
       
        StaticResource multimedia = new StaticResource();
        try{
            
            multimedia = [SELECT Id, Name, ContentType 
                         FROM StaticResource 
                         WHERE Name =: nameStatic 
                         LIMIT 1];
            
        }
        catch(Exception e){
           system.debug('Error getObjectOnb:'+ e.getMessage());
        }
        return ''+multimedia.ContentType;
    }

     /**
    *  @Description: get extension img
    *  @Autor:       Nelson Lepiqueo
    *  @Date:        14/06/2021
    */  
    @TestVisible  
    @AuraEnabled
    public static LP_OnboardingStepFourController extStaticResource() {
        LP_OnboardingStepFourController obj = new LP_OnboardingStepFourController();
        List<String> imgList = new List<String>();
        List<String> videoList = new List<String>();

        try{
        for (LP_StaticResourceExt__mdt imgExtenList:  [SELECT LP_Valor__c, LP_Tipo__c 
                                                        FROM LP_StaticResourceExt__mdt 
                                                        WHERE LP_Tipo__c =: PVR_OBJ_STATIC_RESOURCE_IMG
                                                        LIMIT 100]){
			imgList.add(imgExtenList.LP_Valor__c);                                                            
        }

        for (LP_StaticResourceExt__mdt videoExtList : [SELECT LP_Valor__c, LP_Tipo__c 
                                                        FROM LP_StaticResourceExt__mdt
                                                        WHERE LP_Tipo__c =: PVR_OBJ_STATIC_RESOURCE_VIDEO 
                                                        LIMIT 100]){
            videoList.add(videoExtList.LP_Valor__c);
        }
        obj.objImgList = imgList;
        obj.objVideoList = videoList;
        }
        catch(Exception e){
           system.debug('Error extStaticResource:'+ e.getMessage());
        }
        return obj;
    }
	
    /*
	*  @Description: Check user record in BeClever
	*  @Autor:       Alan Sanhueza, Deloitte
	*  @Date:        09/06/2021
	*/
    @TestVisible
    @AuraEnabled
    public static String validateClientBeClever(SObject record, String transRef, String url) {

        String rut = String.valueOf(record.get(Lead.LP_Rut__c));
        String resp = '';
		String azurianToken = '';
        String civilState = '';

        try{

            List<String> azurianValidate = LP_OnboardingStepThreeController.customerAzurianValidate(record, transRef, url);
            /* System.debug('record: '+record);
            System.debug('transRef: '+transRef);
            System.debug('url: '+url); */
            LP_MAPJSONBeCleverValidation objClass = new LP_MAPJSONBeCleverValidation(record, azurianValidate[1]);
            LP_JSONBeCleverResponse response = new LP_JSONBeCleverResponse();
            LP_Base_Express__c obj = new LP_Base_Express__c();
            LP_BasesExpressSelector objSelector = new LP_BasesExpressSelector();
            response = response.parse(objClass.call());
            system.debug('BeCleaver_Response: '+response);
            obj = objSelector.selectByRutWithLimit(rut);
            String cupoDisp = '';
            LP_LeadsSelector onLeadSelector = new LP_LeadsSelector();
            Lead objLead = onLeadSelector.selectByRutWithLimit(rut);

            for(Integer i=0;i<response.items[0].VariablesSalida.size();i++){
                
                if(response.items[0].VariablesSalida[i].Descripcion == BECLEVER_CRED_LIMIT){
                    cupoDisp = response.items[0].VariablesSalida[i].Valor;
                    objLead.LP_CupoDisponible__c = Integer.valueOf(cupoDisp);
                    //System.debug('cupoDisp: '+cupoDisp);
                }
                if (response.items[0].VariablesSalida[i].Descripcion == BECLEVER_DESCRIPTION && 
                    response.items[0].VariablesSalida[i].Valor == BECLEVER_VALUE){
                    //System.debug('Entró al IF');
                    objLead.LP_TipoTarjeta__c = (obj.LP_OfertaTarjeta__c == '0') ? PRV_SRV_CARDTYPE_TLP : PRV_SRV_CARDTYPE_TLPVISA;
                    resp = 'APROB';

                }
                if(response.items[0].VariablesSalida[i].Descripcion == BECLEVER_CIVIL_STATE){
                    civilState = response.items[0].VariablesSalida[i].Valor != '' ? response.items[0].VariablesSalida[i].Valor : DEFAULT_CIVIL_STATE;
                    objLead.LP_EstadoCivil__c = getCivilStateValue(civilState);
                    system.debug('LP_EstadoCivil__c: '+objLead.LP_EstadoCivil__c);
                }

                if(cupoDisp != '' && resp == 'APROB' && civilState != ''){
                    break;
                }
            }
            //if client not aprove then throw exception NO CARD
            if(resp == ''){
                throwException(true);
            }
            if(resp != 'APROB'){
                objLead.LP_CupoDisponible__c = null;
            }
            update objLead;
        }catch (LP_CustomException e) {
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(null, LP_CustomException.PRV_ERR_NOCARD, false);
            throw new AuraHandledException (JSON.serialize(data));
        }catch(Exception e){
            PRV_ERR_SYSTEM_exception = e.getMessage()+' - '+e.getLineNumber() + ' - '+e.getCause();
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException (JSON.serialize(data));
        }
        return resp;
    }
    
    /**
    *  @Description: Get Civil State Value
    *  @Autor:       Eilhert Andrade
    *  @Date:        08/09/2021
    */
    public static String getCivilStateValue(String edoCivil){
        Map<String, String> civilState = new Map<String, String>();
        civilState.put('SOLTERO','Soltero(a)');
        civilState.put('CASADO','Casado(a)');
        civilState.put('DIVORCIADO','Divorciado(a)');
        civilState.put('VIUDO','Viudo(a)');
        String res = (civilState.get(edoCivil.toUppercase()) != null) ? civilState.get(edoCivil.toUppercase()) : 'Soltero(a)';

        return res;
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
    *  @Description: Wrapper used to find out if a customer exists or not
    *  @Author:      Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        08/06/2021
    */
    @TestVisible
    public class WrapObject {
        @AuraEnabled public Account acc {get; set;}
        @AuraEnabled public Lead lead {get; set;}
        @AuraEnabled public Boolean existsAcc {get; set;}
        @AuraEnabled public Boolean existsLead {get; set;}
        @AuraEnabled public String rut {get; set;}
        @AuraEnabled public String typeObj {get; set;}
        @AuraEnabled public Boolean errorSystem {get; set;}
        
        //Constructor used when instantiating an account. The exists value indicates whether or not the record exists in the SFCD DB
        public WrapObject(Account a, Lead l) {
            acc = a;
            lead = l;
            existsAcc = false;
            existsLead = false;
            rut = '';
            typeObj = '';
            errorSystem = false;
        }
    }
    
}