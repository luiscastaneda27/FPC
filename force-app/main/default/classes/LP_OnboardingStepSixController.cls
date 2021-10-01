/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 07/07/2021
Description  : OnBoarding - Validations to sign contracts documents
History      : 
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Rodrigo Salinas Oye         RSO
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0      RSO			07/07/2021		initial version
********************************************************************************/

public without sharing class LP_OnboardingStepSixController {

    /**
    *  @Description: Initialization of static variables
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
    public static final String PBC_STR_STATICRESOURCE_IMAGEN;
    public static final String PBC_STR_STATICRESOURCE_TOP_HEADER_VISA;
    public static final String PBC_STR_STATICRESOURCE_TOP_HEADER_TLP;
    public static final String PBC_STR_STATICRESOURCE_HEADER_VISA;
    public static final String PBC_STR_STATICRESOURCE_HEADER_TLP;
    public static final String PBC_STR_STATICRESOURCE_FOOTER_VISA;
    public static final String PBC_STR_STATICRESOURCE_FOOTER_TLP;
    public static final String PBC_STR_TEMPLATE_EMAIL;
    public static final String PBC_STR_ADDRESS_EMAIL;
    public static final String PBC_STR_DOC_ID_8;
    public static final String PBC_STR_DOC_ID_9;
    public static final String PBC_STR_EMAIL_POSITION_1;
    public static final String PBC_STR_EMAIL_POSITION_2;
    public static final String PBC_STR_EMAIL_POSITION_3;
    public static final String PBC_STR_EMAIL_POSITION_4;
    public static final String PBC_STR_EMAIL_POSITION_5;
    public static final String PBC_STR_EMAIL_POSITION_IMAGE;
    public static final String PBC_STR_EMAIL_TOP_HEADER_IMAGE;
    public static final String PBC_STR_EMAIL_HEADER_IMAGE;
    public static final String PBC_STR_EMAIL_FOOTER_IMAGE;
    public static final String PBC_STR_EMAIL_DOC_1;
    public static final String PBC_STR_EMAIL_DOC_2;
    public static final String PBC_STR_EMAIL_DOC_3;
    public static final String PBC_STR_EMAIL_DOC_4;
    public static final String PBC_STR_EMAIL_DOC_5;
    public static final String PBC_STR_EMAIL_NUMAUDIT_1;
    public static final String PBC_STR_EMAIL_NUMAUDIT_2;
    public static final String PBC_STR_EMAIL_NUMAUDIT_3;
    public static final String PBC_STR_EMAIL_NUMAUDIT_4;
    public static final String PBC_STR_EMAIL_NUMAUDIT_5;
    public static final String PBC_STR_EMAIL_NOMBRE;
    public static final String PBC_STR_PHONE_PREFIX;

    /**
    *  @Description: Initialization of static variables
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
    static {
        PBC_STR_STATICRESOURCE_IMAGEN = 'LP_OB_CorreoFirmaDocumentosFelicidades';
        PBC_STR_STATICRESOURCE_TOP_HEADER_VISA = 'LP_OB_CorreoFirmaDocumentosTopHeaderVisa';
        PBC_STR_STATICRESOURCE_TOP_HEADER_TLP = 'LP_OB_CorreoFirmaDocumentosTopHeaderTlp';
        PBC_STR_STATICRESOURCE_HEADER_VISA = 'LP_OB_CorreoFirmaDocumentosHeaderTlpVisa';
        PBC_STR_STATICRESOURCE_HEADER_TLP = 'LP_OB_CorreoFirmaDocumentosHeaderTlp';
        PBC_STR_STATICRESOURCE_FOOTER_VISA = 'LP_OB_CorreoFirmaDocumentosFooterTlpVisa';
        PBC_STR_STATICRESOURCE_FOOTER_TLP = 'LP_OB_CorreoFirmaDocumentosFooterTlp';
        PBC_STR_TEMPLATE_EMAIL = 'LP_OB_FirmaDocumentos';
        PBC_STR_ADDRESS_EMAIL = 'No Reply ONB';
        PBC_STR_DOC_ID_8 = '8';
        PBC_STR_DOC_ID_9 = '9';
        PBC_STR_EMAIL_POSITION_1 = '%%LINK_1%%';
        PBC_STR_EMAIL_POSITION_2 = '%%LINK_2%%';
        PBC_STR_EMAIL_POSITION_3 = '%%LINK_3%%';
        PBC_STR_EMAIL_POSITION_4 = '%%LINK_4%%';
        PBC_STR_EMAIL_POSITION_5 = '%%LINK_5%%';
        PBC_STR_EMAIL_POSITION_IMAGE = '%%IMAGEN_URL%%';
        PBC_STR_EMAIL_TOP_HEADER_IMAGE = '%%TOP_HEADER%%';
        PBC_STR_EMAIL_HEADER_IMAGE = '%%IMAGEN_HEADER%%';
        PBC_STR_EMAIL_FOOTER_IMAGE = '%%IMAGEN_FOOTER%%';
        PBC_STR_EMAIL_DOC_1 = '%%DOC_1%%';
        PBC_STR_EMAIL_DOC_2 = '%%DOC_2%%';
        PBC_STR_EMAIL_DOC_3 = '%%DOC_3%%';
        PBC_STR_EMAIL_DOC_4 = '%%DOC_4%%';
        PBC_STR_EMAIL_DOC_5 = '%%DOC_5%%';
        PBC_STR_EMAIL_NUMAUDIT_1 = '%%AUDIT_1%%';
        PBC_STR_EMAIL_NUMAUDIT_2 = '%%AUDIT_2%%';
        PBC_STR_EMAIL_NUMAUDIT_3 = '%%AUDIT_3%%';
        PBC_STR_EMAIL_NUMAUDIT_4 = '%%AUDIT_4%%';
        PBC_STR_EMAIL_NUMAUDIT_5 = '%%AUDIT_5%%';
        PBC_STR_EMAIL_NOMBRE = '%%NOMBRE%%';
        PBC_STR_PHONE_PREFIX = '+56';
        
    }

    /**
    *  @Description: Wrapper used to consolidate data for documents
    *  @Author:      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    *  @Date:        20/07/2021
    */
    public class WrapDocument {
        public String code {get; set;}
        public String sessionId {get; set;}
        public String url {get; set;}
        public String position {get; set;}

        // cosntructor
        public WrapDocument(String paramCode, String paramPosition) {
            code = paramCode;
            position = paramPosition;
            url = '';
            sessionId = '';
        }

        // metodo para completar la data del documento
        public void completeDocumentData(String paramSessionId, String paramURL) {
            sessionId = paramSessionId;
            url = paramURL;
        }
    }

    /**
    *  @Description: Wrapper used to consolidate data for Account converted
    *  @Author:      Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    *  @Date:        20/07/2021
    */
    public class WrapConvertedAccount {
        public Id accountId {get; set;}
        public Boolean isNew {get; set;}

        // constructor
        public WrapConvertedAccount() {
            isNew = false;
        }

        // define el valor de la cuenta 
        public void setAccount(Id paramAccountId, Boolean paramIsNew) {
            accountId = paramAccountId;
            isNew = paramIsNew;
        }
    }

    /**
    *  @Description: Call to service to get OTP code
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
    @AuraEnabled
    public static String getOTPCode(Lead objLead, String clientPhone) {
        try {
            Boolean isSentByPhone = true;
            String code;
            // se consulta si el telefono es valido y se genera el envío del codigo OTP
            if(isValidPhoneNumber(clientPhone)) {
                objLead.MobilePhone = clientPhone;    
                LP_MAPJSONOTPValidation objMapOTP = new LP_MAPJSONOTPValidation(objLead, isSentByPhone);
                LP_JSONOTPResponse jsonResponse = (LP_JSONOTPResponse)JSON.deserialize( objMapOTP.call().getBody(), LP_JSONOTPResponse.class);
                code = jsonResponse.items?.get(0).data;
            }
            else {
                // en caso que el telefono es invalido (Quemado) se genera excepcion PRV_ERR_NOCARD
                throw new LP_CustomException('Customer Mobile Phone is burned for Onboarding');
            }
            return code;
        } catch (LP_RestConnectionWithAuth.ServiceException e) {
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, false);
            throw new AuraHandledException (JSON.serialize(ed));
        } catch (LP_CustomException e) {
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(null, LP_CustomException.PRV_ERR_NOCARD, false);
            throw new AuraHandledException(JSON.serialize(ed));
        } catch (Exception e) {
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException(JSON.serialize(ed));
        }
    }

    /**
    *  @Description: Determine if the mobile phone number can be used to send an OTP code
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
    private static Boolean isValidPhoneNumber(String clientPhone) {
        Boolean isValid = true;
        try {
            // se consulta por la existencia de algún telefono usado en ONB
            LP_OnboardingSelector onboardingSelector = new LP_OnboardingSelector();
            LP_Onboarding__c onbRecord = onboardingSelector.selectByOnboardingMobilePhoneWithLimit(clientPhone);
            // si el telefono existe, y los documentos estan firmados, entonces NO es valido
            isValid = onbRecord.LP_TelefonoQuemado__c == clientPhone && onbRecord.LP_FirmaContratos__c == true ? false : true;
        } catch(QueryException e) {
            // en caso que se genere excepción por Query Exception, manejamos el error
            // en este caso se verifica que el clientPhone no existe en ONB como "quemado"
            String message = new LP_CustomException.ExceptionDetail().getException(e);
        }
        return isValid;
    }

    /**
    *  @Description: Update Onboarding with OTP and Generate the document Constancia De Suscripción Onboarding
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        19/07/2021
    */
    @AuraEnabled
    public static String validateOTPCode(Lead objLead, String otpCode) {      
        LP_OnBoardingUtility.WrapObject wrapObj;
        List<String> idsDoc = new List<String>();

        try {
            // obtenemos los datos necesarios para generar el documento
            wrapObj = getWrapObject(objLead.LP_Rut__c);

            String creditCardType = wrapObj.existsAcc ? wrapObj.acc.LP_TipoTarjeta__pc : wrapObj.lead.LP_TipoTarjeta__c;

            idsDoc.add(PBC_STR_DOC_ID_8);
            idsDoc.add(PBC_STR_DOC_ID_9);
    
            // actualizamos el objeto Onboarding con el Codigo OTP verificado
            wrapObj.onb.LP_CodigoOTP__c = otpCode;

            // obtenemos los registros de documentos en base a los codigos y tipo de tarjeta
            LP_ConfiguracionDocumentosSelector docSelector = new LP_ConfiguracionDocumentosSelector();

            List<LP_ConfiguracionDocumentos__mdt> docs = docSelector.selectByCreditCardTypeWithLimit(creditCardType, idsDoc);

            // generamos el objeto para ejecutar el servicio y obtener el codigo del documento generado
            LP_MAPJSONCustomerContractCreate mapObj = new LP_MAPJSONCustomerContractCreate(docs, objLead, wrapObj.onb);
            LP_JSONCustomerContractCreateResponse response = LP_JSONCustomerContractCreateResponse.parse(mapObj.call().get(docs?.get(0)?.MasterLabel));
            wrapObj.onb.LP_CodigoConstanciaSuscripcion__c = response?.items.get(0).result?.code;

            update wrapObj.onb;

        } catch(QueryException e) {
            // en caso que se genere una excepción la manejamos, dado que getWrapObject puede generar excepcion
            String message = new LP_CustomException.ExceptionDetail().getException(e);
        } catch (LP_RestConnectionWithAuth.ServiceException e) {
            LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, false);
            throw new AuraHandledException (JSON.serialize(data));
        } catch (Exception e) {
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException(JSON.serialize(ed));
        }
        return wrapObj.onb.LP_CodigoConstanciaSuscripcion__c;
    }

    /**
    *  @Description: Validate documents and update related objects
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
    @AuraEnabled
    public static String validateDocuments(Lead objLead, String otpCode) {
        LP_OnBoardingUtility.WrapObject wrapObj;
        WrapConvertedAccount convertedAccount = new WrapConvertedAccount();
        String stepResult = LP_OnBoardingUtility.PBC_STR_STEPSIX;
        Boolean updOnb = true;
        // se obtiene el objeto wrap con el OB y Lead o Cuenta
        wrapObj = getWrapObject(objLead.LP_Rut__c);
        try {

            // se genera el objeto con los codigos de documentos
            Map<String, WrapDocument> docStructure = getDocumentStructure(wrapObj.onb);
            // se genera url de documentos (servicio 2: generar URL + SessionID)
            docStructure = getDocumentData(docStructure);
            // se firman los documentos
            signDocuments(objLead, docStructure);
            // Obtener el código de auditoria posterior a la firma de cada documento y guardarlo en obj Onb
            Map<String, String> auditCode = getAuditDocumentCode(wrapObj.onb);
            
            // se actualizan los campos correspondientes al onboarding
            wrapObj.onb.LP_CodigoAuditContratoApertura__c = auditCode.get(wrapObj.onb.LP_CodigoContratoApertura__c);
            wrapObj.onb.LP_CodigoAuditAutorizacionEspecial__c = auditCode.get(wrapObj.onb.LP_CodigoAutorizacionEspecial__c);
            wrapObj.onb.LP_CodigoAuditMandato__c = auditCode.get(wrapObj.onb.LP_CodigoMandato__c);
            wrapObj.onb.LP_CodigoAuditResumenContrato__c = auditCode.get(wrapObj.onb.LP_CodigoResumenContratoApertura__c);
            wrapObj.onb.LP_CodigoAuditConstanciaSuscrip__c = auditCode.get(wrapObj.onb.LP_CodigoConstanciaSuscripcion__c);
            wrapObj.onb.LP_FirmaContratos__c = true;
            wrapObj.onb.LP_CodigoOTP__c = otpCode;
        
            LP_MAPJSONCustomerCreate objMap = new LP_MAPJSONCustomerCreate(wrapObj.lead, wrapObj.onb);
            LP_JSONCustomerCreateResponse jsonResponse = (LP_JSONCustomerCreateResponse)JSON.deserialize( objMap.call(), LP_JSONCustomerCreateResponse.class);
            system.debug('jsonResponse: '+jsonResponse);
            if(updOnb){
                update wrapObj.onb;
                updOnb = false;
            }
            
            //si el servicio 965 crea al cliente en los legados continúa, en caso contrario cae en la excepción

            // si existe lead asociado al Onboarding
            if (wrapObj.existsLead) {
                //se actualiza los datos de lead asociado al Onboarding
                updateLead(wrapObj.lead.Id, otpCode);
                // convertir lead en cuenta
                convertedAccount = convertLeadIntoAccount(wrapObj.lead);
            } 
            // si existe account asociado al Onboarding
            if (wrapObj.existsAcc) {
                convertedAccount.setAccount(wrapObj.acc.Id, false);
            }
            // actualizamos el account 
            system.debug('teléfono: '+PBC_STR_PHONE_PREFIX+objLead.MobilePhone);
            updateAccount(convertedAccount, otpCode, PBC_STR_PHONE_PREFIX+objLead.MobilePhone);

            // actualizar ob y quemamos el telefono
            updateOnboarding(wrapObj.onb.id, otpCode, objLead.MobilePhone, convertedAccount);

            // enviar correo con links a documentos
            sendEmailWithSignedDocuments(objLead.Email, docStructure, wrapObj);
            stepResult = LP_OnBoardingUtility.PBC_STR_STEPSEVEN;

        } catch (LP_RestConnectionWithAuth.ServiceException e) {
            System.debug('Error: '+e);
            if(e.code == 422){
                LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(null, LP_CustomException.PRV_ERR_EXIST_CLIENT, true);
                throw new AuraHandledException(JSON.serialize(data));
            }else{
                LP_CustomException.ExceptionDetail data = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, false);
                throw new AuraHandledException (JSON.serialize(data));
            }
        } catch (AuraHandledException e) {
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(null, LP_CustomException.PRV_ERR_NOCARD, false);
            throw new AuraHandledException(JSON.serialize(ed));
        } catch (Exception e) {
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(e, LP_CustomException.PRV_ERR_SYSTEM, true);
            throw new AuraHandledException(JSON.serialize(ed));
        }finally{
            if(updOnb){
                System.debug('onb_antes: '+wrapObj.onb);
                Map<String, String> auditCode = getAuditDocumentCode(wrapObj.onb);
                wrapObj.onb.LP_CodigoAuditContratoApertura__c = auditCode.get(wrapObj.onb.LP_CodigoContratoApertura__c);
                wrapObj.onb.LP_CodigoAuditAutorizacionEspecial__c = auditCode.get(wrapObj.onb.LP_CodigoAutorizacionEspecial__c);
                wrapObj.onb.LP_CodigoAuditMandato__c = auditCode.get(wrapObj.onb.LP_CodigoMandato__c);
                wrapObj.onb.LP_CodigoAuditResumenContrato__c = auditCode.get(wrapObj.onb.LP_CodigoResumenContratoApertura__c);
                wrapObj.onb.LP_CodigoAuditConstanciaSuscrip__c = auditCode.get(wrapObj.onb.LP_CodigoConstanciaSuscripcion__c);
                wrapObj.onb.LP_FirmaContratos__c = true;
                wrapObj.onb.LP_CodigoOTP__c = otpCode;
                update wrapObj.onb;
                System.debug('onb_despues: '+wrapObj.onb);
            }
        }
        return stepResult;
    }

    /**
    *  @Description: Create the structure to handle documents
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        20/07/2021
    */
    private static Map<String, WrapDocument> getDocumentStructure(LP_Onboarding__c onb) {
        Map<String, WrapDocument> docList = new Map<String, WrapDocument>();
        // doc 1: Resumen Contrato
        docList.put(onb.LP_CodigoResumenContratoApertura__c, new WrapDocument(onb.LP_CodigoResumenContratoApertura__c, PBC_STR_EMAIL_POSITION_1));
        // doc 2: Contrato de Apertura
        docList.put(onb.LP_CodigoContratoApertura__c, new WrapDocument(onb.LP_CodigoContratoApertura__c, PBC_STR_EMAIL_POSITION_2));
        // doc 3: Mandato
        docList.put(onb.LP_CodigoMandato__c, new WrapDocument(onb.LP_CodigoMandato__c, PBC_STR_EMAIL_POSITION_3));
        // doc 4: Autorización Especial
        docList.put(onb.LP_CodigoAutorizacionEspecial__c, new WrapDocument(onb.LP_CodigoAutorizacionEspecial__c, PBC_STR_EMAIL_POSITION_4));
        // doc 5: Constancia Suscripción Onboarding
        docList.put(onb.LP_CodigoConstanciaSuscripcion__c, new WrapDocument(onb.LP_CodigoConstanciaSuscripcion__c, PBC_STR_EMAIL_POSITION_5));

        return docList;
    }

    /**
    *  @Description: Get the document link and SessionId for a List of Documents
    *  @Autor:       Rodrigo Salinas, Deloitte, rosalinas@deloitte.com
    *  @Date:        20/07/2021
    */
    private static Map<String, WrapDocument> getDocumentData(Map<String, WrapDocument> docMap) {
        // se genera la lista de codigos de documentos
        List<String> codeList = new List<String>();
        for (LP_OnboardingStepSixController.WrapDocument eachDoc : docMap.values()) {
            codeList.add(eachDoc.code);
        }

        // se llama al servicio con la lista de codigos
        LP_MAPJSONCustomerGetDocuments objClass = new LP_MAPJSONCustomerGetDocuments();
        List<String> responseList = objClass.multipleCall(codeList);

        // se procesa cada una de las respuestas
        LP_JSONCustomerGetDocumentsResponse response;
        WrapDocument doc;
        for (String eachResponse : responseList) {
            response = LP_JSONCustomerGetDocumentsResponse.parse(eachResponse);
            doc = docMap.get(response.items.get(0).result.get(0).code);
            doc.completeDocumentData(response.items.get(0).session_id, response.items.get(0).result.get(0).file_preview);
        }
        
        return docMap;
    }

    /**
    *  @Description: Sign documents
    *  @Author:      Eilhert Andrade, Deloitte, eandradea@deloitte.com
    *  @Date:        20/07/2021
    */
    private static void signDocuments(Lead objLead, Map<String, WrapDocument> docMap){
        try{
            // se genera el listado de parametros por cada documento
            List<Map<String, String>> paramList = new List<Map<String, String>>();
            for (WrapDocument doc : docMap.values()) {
                Map<String, String> parameters = new Map<String, String>(); 
                parameters.put(LP_MAPJSONCustomerSign.PVR_PARAM_NUMERO, doc.code +'pdf');//code+pdf
                parameters.put(LP_MAPJSONCustomerSign.PVR_PARAM_AUDIT,'');
                parameters.put(LP_MAPJSONCustomerSign.PVR_PARAM_CODE, doc.code); //paso-5
                parameters.put(LP_MAPJSONCustomerSign.PVR_PARAM_SESSION, doc.sessionId);//paso-5
                paramList.add(parameters);
            }
     
            // se genera el llamado al servicio
            LP_MAPJSONCustomerSign objClass = new LP_MAPJSONCustomerSign(objLead, paramList);
            List<String> responseList = objClass.call();
     
            // se procesa cada una de las respuestas
            for (String response : responseList) {
                LP_JSONCustomerSignResponse responseSigned = new LP_JSONCustomerSignResponse();
                // no hay definido nada para hacer con la respuesta
                //system.debug('signDocuments response: '+responseSigned?.items?.toString());
            }
        }catch (LP_CustomException e) {
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(null, LP_CustomException.PRV_ERR_NOCARD, false);
            throw new AuraHandledException(JSON.serialize(ed));
        }
    }

    /**
    *  @Description: Get audit code for documents, service 103
    *  @Author:      Eilhert Andrade, Deloitte
    *  @Date:        15/07/2021  
    */
    public static Map<String, String> getAuditDocumentCode(LP_Onboarding__c onb){
        // se genera la lista de codigos de documentos
        Map<String, String> auditCode = new Map<String, String>();
        List<String> codeList = new List<String>();
       
        try{     
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
        }catch (LP_CustomException e) {
            LP_CustomException.ExceptionDetail ed = new LP_CustomException.ExceptionDetail(null, LP_CustomException.PRV_ERR_NOCARD, false);
            throw new AuraHandledException(JSON.serialize(ed));
        }
        return auditCode;
    }

    /**
    *  @Description: Get the object using RUT as parameter
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
    private static LP_OnBoardingUtility.WrapObject getWrapObject(String rutClient) {
        LP_OnBoardingUtility.WrapObject wrap = new LP_OnBoardingUtility.WrapObject(new LP_Onboarding__c());
        wrap.rut = rutClient;
        wrap.type = SObjectType.Account.getName();
        wrap = LP_OnBoardingUtility.getOnboardingObj(wrap);
        if (!wrap.existsAcc) {
            wrap.type = SObjectType.Lead.getName();
            wrap = LP_OnBoardingUtility.getOnboardingObj(wrap);
        }

        return wrap;
    }

    /**
    *  @Description: Update the lead with the info required for Step6
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
    private static void updateLead(Id idLead, String otpCode) {
        Lead leadToUpdate = new Lead();
        leadToUpdate.Id = idLead;
        leadToUpdate.LP_NumeroCelularValidado__c = true;
        leadToUpdate.LP_FirmaContratos__c = true;
        leadToUpdate.LP_CodigoOTP__c = otpCode;
        update leadToUpdate;
    }

    /**
    *  @Description: Update the account with the info required for Step6
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
    private static void updateAccount(WrapConvertedAccount convertedAccount, String otpCode, String mobilePhone) {
        Date signDate = Date.today();
        Account accountToUpdate = new Account();
        accountToUpdate.Id = convertedAccount.accountId;
        accountToUpdate.LP_NumeroCelularValidado__pc = true;
        accountToUpdate.LP_NumeroCelular__c = mobilePhone;
        accountToUpdate.LP_AceptacionContratos__pc = true; 
        accountToUpdate.LP_FechaAceptacionContratos__pc = signDate;
        accountToUpdate.LP_AsignacionPAN__c = true;
        accountToUpdate.LP_FirmaContratos__pc = true;
        accountToUpdate.LP_CodigoOTP__pc = otpCode;
        accountToUpdate.PersonMobilePhone = mobilePhone;
        accountToUpdate.LP_FechaFirmaContratos__pc = signDate;
        accountToUpdate.LP_FechaNumeroCelular__pc = signDate;
        accountToUpdate.LP_FechaCodigoOTP__pc = signDate;
        accountToUpdate.LP_RutaOnboarding__pc = LP_OnBoardingUtility.PBC_STR_STEPSEVEN;
        // se determina si la cuenta es creada por onboarding
        accountToUpdate.LP_CreadoOnboarding__pc = convertedAccount.isNew ? true : false;
        update accountToUpdate;
    }

    /**
    *  @Description: Update the account with the info required for Step6
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
    private static void updateOnboarding(Id idOnboarding, String otpCode, String mobilePhone, WrapConvertedAccount convertedAccount) {
        LP_Onboarding__c obToUpdate = new LP_Onboarding__c();
        obToUpdate.Id = idOnboarding;
        obToUpdate.LP_Cuenta__c = convertedAccount.accountId;            // cuenta asociada al onboarding
        obToUpdate.LP_TelefonoQuemado__c = mobilePhone;                 // telefono quemado
        obToUpdate.LP_AsignacionPAN__c = true;
        obToUpdate.LP_Ruta__c = LP_OnBoardingUtility.PBC_STR_STEPSEVEN;
        obToUpdate.LP_FechaEnvioCorreo__c = Date.today();
        update obToUpdate;
    }

    /**
    *  @Description: Convert the lead into Account
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
    private static WrapConvertedAccount convertLeadIntoAccount(Lead leadToConvert) { 
        Account acc;
        Boolean isNew = false;
    
        try {
            // obtenemos el objeto account, en caso que exista uno asociado al RUT
            LP_AccountsSelector accountSelector = new LP_AccountsSelector();
            acc = accountSelector.selectByRutWithLimit(leadToConvert.LP_Rut__c);
        } catch(QueryException e) {
            // en caso que se genere una excepción la manejamos, dado que no existe cuenta asociada al RUT
            String message = new LP_CustomException.ExceptionDetail().getException(e);
        }

        // se define la conversión del lead
        Database.LeadConvert lc = new Database.LeadConvert();
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setLeadId(leadToConvert.Id);
        lc.setConvertedStatus(convertStatus.MasterLabel);
        lc.setDoNotCreateOpportunity(true);
        // se determina si se utiliza una cuenta existente o se crea una nueva
        if(acc != null) {
            lc.setAccountId(acc.Id);
            isNew = false;
        }
        else {
            isNew = true;
        }
        // se realiza la conversión de lead, de acuerdo a la configuración de conversión de candidatos
        Database.LeadConvertResult lcr = Database.convertLead(lc);  
        WrapConvertedAccount convertedAccount = new WrapConvertedAccount();
        convertedAccount.setAccount(lcr.getAccountId(), isNew);
		return convertedAccount;
    }

    /**
    *  @Description: Send an email to the cleint with the signed documents
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
    private static void sendEmailWithSignedDocuments(String toEmailAddress, Map<String, WrapDocument> docStructure, LP_OnBoardingUtility.WrapObject wrap) {
        //Query email template
        EmailTemplate template= [SELECT Id, body, htmlvalue, subject FROM EmailTemplate where DeveloperName =: PBC_STR_TEMPLATE_EMAIL];
        OrgWideEmailAddress owa = [SELECT Id, DisplayName, Address FROM OrgWideEmailAddress where DisplayName =:  PBC_STR_ADDRESS_EMAIL];
        //get template body
        String plainText = template.Body;
        String htmlText = template.HtmlValue;
        //Replace merged field with user information
        String topheaderTipoTajeta = (wrap.lead.LP_TipoTarjeta__c == '01') ? PBC_STR_STATICRESOURCE_TOP_HEADER_TLP : PBC_STR_STATICRESOURCE_TOP_HEADER_VISA;
        String headerTipoTajeta = (wrap.lead.LP_TipoTarjeta__c == '01') ? PBC_STR_STATICRESOURCE_HEADER_TLP : PBC_STR_STATICRESOURCE_HEADER_VISA;
        String footerTipoTajeta = (wrap.lead.LP_TipoTarjeta__c == '01') ? PBC_STR_STATICRESOURCE_FOOTER_TLP : PBC_STR_STATICRESOURCE_FOOTER_VISA;

        htmlText = htmlText.replace(PBC_STR_EMAIL_TOP_HEADER_IMAGE, getResourceURL(topheaderTipoTajeta));
        htmlText = htmlText.replace(PBC_STR_EMAIL_HEADER_IMAGE, getResourceURL(headerTipoTajeta));
        htmlText = htmlText.replace(PBC_STR_EMAIL_POSITION_IMAGE, getResourceURL(PBC_STR_STATICRESOURCE_IMAGEN));
        htmlText = htmlText.replace(PBC_STR_EMAIL_FOOTER_IMAGE, getResourceURL(footerTipoTajeta));

        for (WrapDocument eachDoc : docStructure.values()) {
            htmlText = htmlText.replace(eachDoc.position, eachDoc.url);
            plainText = plainText.replace(eachDoc.position, eachDoc.url);
        }
        htmlText = updMailHtmlText(htmlText, wrap);
        plainText = updMailPlainText(plainText, wrap);
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new List<String>{toEmailAddress});  
        mail.setSaveAsActivity(false); 
        mail.setHtmlBody(htmlText);
        mail.setPlainTextBody(plainText);
        mail.setSubject(template.Subject);
        mail.setUseSignature(false); 
        mail.setOrgWideEmailAddressId(owa.id);

        Messaging.SendEmailResult [] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});       
    }

    /**
    *  @Description: update parameters values of html email template 
    *  @Author:      Eilhert Andrade, Deloitte
    *  @Date:        21/09/2021
    */
    private static String updMailHtmlText(String strHtmlText, LP_OnBoardingUtility.WrapObject wrap){
        String htmlText = strHtmlText;
        htmlText = htmlText.replace(PBC_STR_EMAIL_DOC_1,wrap.onb.LP_CodigoResumenContratoApertura__c);
        htmlText = htmlText.replace(PBC_STR_EMAIL_NUMAUDIT_1,wrap.onb.LP_CodigoAuditResumenContrato__c);
        htmlText = htmlText.replace(PBC_STR_EMAIL_DOC_2,wrap.onb.LP_CodigoContratoApertura__c);
        htmlText = htmlText.replace(PBC_STR_EMAIL_NUMAUDIT_2,wrap.onb.LP_CodigoAuditContratoApertura__c);
        htmlText = htmlText.replace(PBC_STR_EMAIL_DOC_3,wrap.onb.LP_CodigoMandato__c);
        htmlText = htmlText.replace(PBC_STR_EMAIL_NUMAUDIT_3,wrap.onb.LP_CodigoAuditMandato__c);
        htmlText = htmlText.replace(PBC_STR_EMAIL_DOC_4,wrap.onb.LP_CodigoAutorizacionEspecial__c);
        htmlText = htmlText.replace(PBC_STR_EMAIL_NUMAUDIT_4,wrap.onb.LP_CodigoAuditAutorizacionEspecial__c);
        htmlText = htmlText.replace(PBC_STR_EMAIL_DOC_5,wrap.onb.LP_CodigoConstanciaSuscripcion__c);
        htmlText = htmlText.replace(PBC_STR_EMAIL_NUMAUDIT_5,wrap.onb.LP_CodigoAuditConstanciaSuscrip__c);
        htmlText = htmlText.replace(PBC_STR_EMAIL_NOMBRE,wrap.lead.Name);

        return htmlText;
    }

    /**
    *  @Description: update parameters values of plain text email template 
    *  @Author:      Eilhert Andrade, Deloitte
    *  @Date:        21/09/2021
    */
    private static String updMailPlainText(String strplainText, LP_OnBoardingUtility.WrapObject wrap){
        String plainText = strplainText;

        plainText = plainText.replace(PBC_STR_EMAIL_DOC_1,wrap.onb.LP_CodigoResumenContratoApertura__c);
        plainText = plainText.replace(PBC_STR_EMAIL_NUMAUDIT_1,wrap.onb.LP_CodigoAuditResumenContrato__c);
        plainText = plainText.replace(PBC_STR_EMAIL_DOC_2,wrap.onb.LP_CodigoContratoApertura__c);
        plainText = plainText.replace(PBC_STR_EMAIL_NUMAUDIT_2,wrap.onb.LP_CodigoAuditContratoApertura__c);
        plainText = plainText.replace(PBC_STR_EMAIL_DOC_3,wrap.onb.LP_CodigoMandato__c);
        plainText = plainText.replace(PBC_STR_EMAIL_NUMAUDIT_3,wrap.onb.LP_CodigoAuditMandato__c);
        plainText = plainText.replace(PBC_STR_EMAIL_DOC_4,wrap.onb.LP_CodigoAutorizacionEspecial__c);
        plainText = plainText.replace(PBC_STR_EMAIL_NUMAUDIT_4,wrap.onb.LP_CodigoAuditAutorizacionEspecial__c);
        plainText = plainText.replace(PBC_STR_EMAIL_DOC_5,wrap.onb.LP_CodigoConstanciaSuscripcion__c);
        plainText = plainText.replace(PBC_STR_EMAIL_NUMAUDIT_5,wrap.onb.LP_CodigoAuditConstanciaSuscrip__c);
        plainText = plainText.replace(PBC_STR_EMAIL_NOMBRE,wrap.lead.Name);

        return plainText;
    }

    /**
    *  @Description: Generate the URL of a static resources
    *  @Author:      Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
    private static String getResourceURL(String resourceName)
    {
        String result = '';
        //Fetching the resource
        LP_StaticResourcesSelector srObj = new LP_StaticResourcesSelector();
        StaticResource resourceList = srObj.selectByStaticResourceNameWithLimit(resourceName);

        //Checking if the result is returned or not
        if(resourceList != null)
        {
            //Getting namespace
            String namespace = resourceList.NamespacePrefix;

            //Resource URL
            result = URL.getOrgDomainUrl().toExternalForm() + '/resource/' + resourceList.SystemModStamp.getTime() + '/' + (namespace != null && namespace != '' ? namespace + '__' : '') + resourceName; 
            result = result.replace('.my.sales', '--c.visual');
            System.debug(result);
        }
        return result;
    }
}