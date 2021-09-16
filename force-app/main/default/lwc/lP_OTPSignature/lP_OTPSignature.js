/*********************************************************************************
Project      : Sodimac Salesforce Service Cloud
Created By   : Deloitte
Created Date : 07/07/2021
Description  : Lightning web component - OTP Signature
History      :
**************************ACRONYM OF AUTHORS************************************
AUTHOR                      ACRONYM
Rodrigo Salinas Oye         RSO
********************************************************************************
VERSION  AUTHOR         DATE            Description
1.0      RSO	        07/07/2021		initial version
********************************************************************************/
import { LightningElement, wire, track, api } from 'lwc';
import getCodeOTP from '@salesforce/apex/LP_OnboardingStepSixController.getOTPCode';
import validateOTPCode from '@salesforce/apex/LP_OnboardingStepSixController.validateOTPCode';
import processDocuments from '@salesforce/apex/LP_OnboardingStepSixController.validateDocuments';
import processCreateCustomer from '@salesforce/apex/LP_OnboardingStepSevenController.customerCreate';
//Import Static Resource
import iCheck from '@salesforce/resourceUrl/LP_IconoCheckOTP';
import iMobilePhone from '@salesforce/resourceUrl/LP_IconoCelularOTP';
import iGreyEdit from '@salesforce/resourceUrl/LP_IconoEdicionGrisOTP';
import iRedEdit from '@salesforce/resourceUrl/LP_IconoEdicionRojoOTP';
import iError from '@salesforce/resourceUrl/LP_IconoErrorOTP';
import iSuccess from '@salesforce/resourceUrl/LP_IconoExitoOTP';
//Import Custom Label
import lBtnSend from '@salesforce/label/c.LP_OTP_EnviarCodigo';
import lBtnSendReplace from '@salesforce/label/c.LP_OTP_CodigoEnviado';
import lBtnCheckCode from '@salesforce/label/c.LP_OTP_VerificarCodigo';
import lBtnNext from '@salesforce/label/c.LP_Continuar';
import lBtnPrev from '@salesforce/label/c.LP_Regresar';
import lBtnClose from '@salesforce/label/c.LP_OTP_ModalCerrar';
import lBtnUnderstood from '@salesforce/label/c.LP_OTP_ModalEntendido';
import lMobilePhone from '@salesforce/label/c.LP_OTP_EtiquetaCelular';
import lTxtDescription from '@salesforce/label/c.LP_OTP_DescripcionPaso6';
import lTxtMistake from '@salesforce/label/c.LP_OTP_TextoCantidaDeIntento';
import lTxtMobilePhone from '@salesforce/label/c.LP_OTP_TextoCelular';
import lTxtTried from '@salesforce/label/c.LP_OTP_TextoIntentoCelular';
import lTxtTituloErrorValidacion from '@salesforce/label/c.LP_OTP_TextoErrorTituloValidacionCelular';
import lTxtMesanjeErrorValidacion from '@salesforce/label/c.LP_OTP_TextoErrorMensajeValidacionCelular';
import lMsgError from '@salesforce/label/c.LP_OTP_ModalCelularMensaje';
import lSubTitle from '@salesforce/label/c.LP_OTP_ModalCelularSubTitulo';
import lTitle from '@salesforce/label/c.LP_OTP_ModalCelularTitulo';
import lMobileformat from '@salesforce/label/c.LP_CelularCon9Digitos';
import lValidateSignDoc from '@salesforce/label/c.LP_ValidaFirmaDocs';
import step1 from '@salesforce/label/c.LP_OnboardingPaso1';
import step5 from '@salesforce/label/c.LP_OnboardingPaso5';
import lInvalidCode from '@salesforce/label/c.LP_OTP_TextoErrorTituloValidacionCelular';

import GETPATHUTILITY from '@salesforce/resourceUrl/LP_OnboardingUtility';
import { loadScript } from 'lightning/platformResourceLoader';

export default class LP_OTPSignature extends LightningElement {
    steps = {step1, step5};
    @api email;

    @api mobilePhone;
    @api showError;
    @api showAttemps;
    @api objLead;
    /* = {
        LP_Rut__c : '16449021-1',
        mobilePhone : '983403479',
        Email : 'rsalinao@gmail.com',
        FirstName : 'Charles',
        LastName : 'Aránguiz'
    };*/
    @track objList;
    @track otpCode;
    @track labels = {
        button : {
            send : lBtnSend,
            sendReplace : lBtnSendReplace,
            checkCode : lBtnCheckCode,
            prev : lBtnPrev,
            next : lBtnNext,
            close : lBtnClose,
            understood : lBtnUnderstood
        },
        text : {
            mobilePhone1 : lTxtMobilePhone.split('#')[0],
            mobilePhone2 : lTxtMobilePhone.split('#')[1],
            mistake : lTxtMistake.split('#')[0],
            mistake2 : lTxtMistake.split('#')[1],
            tried1 : lTxtTried.split('#')[0],
            tried2 : lTxtTried.split('#')[1],
            validationTitleError: lTxtTituloErrorValidacion,
            validationMessageError1: lTxtMesanjeErrorValidacion.split('#')[0],
            validationMessageError2: lTxtMesanjeErrorValidacion.split('#')[1],
            validationMessageError3: lTxtMesanjeErrorValidacion.split('#')[2],
            numberAttempts : 3,
            description: lTxtDescription,
            msgError1 : lMsgError.split('#')[0],
            msgError2 : lMsgError.split('#')[1],
            msgError3 : lMsgError.split('#')[2],
            msgError4 : lMsgError.split('#')[3],
            modalSubTitle : lSubTitle,
            modalTitle : lTitle
        },
        label : {
            mobilePhone : lMobilePhone,
            lMobileformat,
            lValidateSignDoc,
			lInvalidCode
        }
    }
    // static resource to use in the template
    iconOTP = {
        iCheck,
        iMobilePhone,
        iGreyEdit,
        iRedEdit,
        iError,
        iSuccess
    }

    /**
    *  @Description: load static resource with constant variables
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        26/04/2021
    */
     renderedCallback() {
        loadScript(this, GETPATHUTILITY)
        .then(() => console.log('Loaded GETPATHUTILITY'))
        .catch(error => console.log('error: ' + JSON.stringify(error)));
    }
    
    /**
    *  @Description: Method init connectedCallback
    *  @Autor:       Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
    connectedCallback(){
        //console.log('connectedCallback');
        this.mobilePhone = this.objLead.MobilePhone;
        this.showAttemps = true;

        //console.log('connectedCallback this.mobilePhone: ' + this.mobilePhone);
        //console.log('connectedCallback this.objLead: ' + JSON.stringify(this.objLead));
    }

    /**
    *  @Description: Validates if the code is alphanumeric
    *  @Autor:       Eilhert Andrade, Deloitte, enadradea@deloitte.com
    *  @Date:        02/09/2021
    */
    numericValidation(event) {
        //^ : start of string
        //[ : beginning of character group
        //0-9 : any digit
        //_ : underscore
        //] : end of character group
        //* : zero or more of the given characters
        //$ : end of string
        var inputCmp = event.target;
        var value = inputCmp.value;
        const regex = "^[0-9]*$";
        var isValid = value.match(regex);
        //var isValid = window.phoneFormat(value);
        // is input valid code?
        if(isValid){
            let maxlenght = parseInt(inputCmp.maxLength, 10);
            if(inputCmp.value.length == maxlenght) {
                let next = inputCmp.nextElementSibling;
                if (next != null) {
                    next.focus();
                }
            }
            else if(inputCmp.value.length == 0) {
                let previous = inputCmp.previousElementSibling;
                if (previous != null) {
                    previous.focus();
                }
            }
            inputCmp.setCustomValidity(""); // if there was a custom error before, reset it
        } else {
            inputCmp.value = '';
            inputCmp.setCustomValidity("Debe ser numérico");
        }
        inputCmp.reportValidity(); // Tells lightning-input to show the error right away without needing interaction
    }
    
    /**
    *  @Description: Method that validate Mobile Phone
    *  @Autor:       Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
     validatePhone(event) {
        let element = this.template.querySelector(".number-input");
        this.mobilePhone = element.value;
        //const regex = /^([0-9]{9})+$/;
        if (window.phoneFormat(this.mobilePhone)) {
            this.template.querySelector(".error-message").style.display = "none"; // Hide the error message
            this.template.querySelector(".button2").disabled = false;
        } else {
            this.template.querySelector(".error-message").style.display = "block"; // Show the error message
            this.template.querySelector(".button2").disabled = true; // Disable send button
        }
    }    

    /**
    *  @Description: Consume the service to send the otp code
    *  @Autor:       Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
     handleSendOTP() {
        this.template.querySelector(".active-button2").style.display = "none";
        this.template.querySelector(".button2").disabled = true; // Disable send button
        //console.log('handleSendOTP: mobilephone = ' + this.mobilePhone);
        this.showAttemps = true;                                // show the attemps message
        getCodeOTP({objLead: this.objLead, clientPhone: this.mobilePhone})
            .then((result) => {
                //console.log('handleSendOTP: result = ' + result);
                this.otpCode = result;
                console.log("Resultado: "+this.otpCode);
                // si el codigo es 0, el numero esta quemado
                if(this.otpCode == 0) {
                    this.showError = true;
                    //console.log('numero quemado!!!');
                    return;
                }
                this.labels.button.send = this.labels.button.sendReplace;
                this.template.querySelector(".active-button2").style.display = "block";
                this.template.querySelector(".active-button2").src = this.iconOTP.iCheck; // Load the check icon in the send button
                //this.template.querySelector(".button1").disabled = true; // Disable email button
                //this.template.querySelector(".active-button").src = this.iconOTP.iGreyEdit; // Load the gray edit icon in the edit email button
                this.template.querySelector(".button3").disabled = false; // Enable the verify code button
                this.template.querySelector(".button3").style.display = "block";
                this.template.querySelector(".active-button3").style.display = "none";
                this.template.querySelector(".number-input").disabled = true; // Disable phone input
            })
            .catch((error) => {
                this.template.querySelector(".active-button2").style.display = "block";
                this.template.querySelector(".button2").disabled = false; // Enable send button
                this.error = error;
                let message = JSON.parse(error.body.message);
                console.error('error.message: ' + JSON.stringify(message));
                console.error('message.cause: ' + message.cause);
                const pathEvent = new CustomEvent('setsteplayout', {detail: 
                                                                    {step: message.cause,
                                                                    param: '',
                                                                    objLead: this.objLead}});
                this.dispatchEvent(pathEvent);
            });
    }

    /**
    *  @Description: Validate the otp code, if it is valid update the objects
    *  @Autor:       Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
    validateOTPCode(event) {
        let activebtn3 = this.template.querySelector(".active-button3");
        let nextbtn = this.template.querySelector(".next-page-btn");
        let btn3 = this.template.querySelector(".button3");
        let textMistake = this.template.querySelector(".text-mistake");
        let input = '';
        this.template.querySelectorAll('.code-input').forEach(element => {
            input+= element.value;
        });
        if (input === this.otpCode) {
            // se valida el codigo OTP y se crea el doc
            validateOTPCode({objLead: this.objLead, otpCode: this.otpCode})
            .then((result) => {
                //console.log('validateOTPCode: doc code = ' + result);
                activebtn3.style.display = "block";
                activebtn3.src = this.iconOTP.iSuccess;
                btn3.style.display = "none";
                textMistake.style.display = "none";            
                nextbtn.disabled = false;
            })
            .catch((error) => {
                this.error = error;
                let message = JSON.parse(error.body.message);
                console.error('error.message: ' + JSON.stringify(message));
                console.error('message.cause: ' + message.cause);
                const pathEvent = new CustomEvent('setsteplayout', {detail: 
                                                                    {step: message.cause,
                                                                    param: '',
                                                                    objLead: this.objLead}});
                this.dispatchEvent(pathEvent);
            });
        } else {
            this.showAttemps = false;                                // show the validation error message
            this.template.querySelector(".button2").disabled = false;
            this.labels.button.send = lBtnSend;
            this.template.querySelector(".active-button2").src = '';
            this.labels.text.numberAttempts = this.labels.text.numberAttempts - 1;
            this.showError = this.labels.text.numberAttempts == 0 ? true : false;           
            activebtn3.src = this.iconOTP.iError;
            activebtn3.style.display = "block";
            btn3.style.display = "none";
            textMistake.style.display = "block";
            nextbtn.disabled = true;
            this.template.querySelectorAll('.code-input').forEach(element => {
                element.value = "";
            });
        }
    }

    /**
    *  @Description: Move on to the next step on the path
    *  @Autor:       Abdon Tejos, Deloitte, atejos@deloitte.com
    *  @Date:        19/05/2021
    */
    async nextStep(event) {
        let nextbtn = this.template.querySelector(".next-page-btn");
        try {
            if(this.showError){
                const pathEvent = new CustomEvent('setsteplayout', {detail: {step: this.steps.step1, param: '', objLead: this.objLead}});
                this.dispatchEvent(pathEvent);
            }else{
                nextbtn.disabled = true;
                const result1 =  await processDocuments({objLead: this.objLead, otpCode: this.otpCode});
                //console.log('processDocuments result: ' + JSON.stringify(result1));

                const result2 = await processCreateCustomer({objLead: this.objLead});
                //console.log('processDocuments result: ' + JSON.stringify(result2));

                const pathEvent = new CustomEvent('setsteplayout', {detail: {step: result1, objLead: this.objLead}});
                this.dispatchEvent(pathEvent);
            }
        } catch (error) {
            this.error = error;
            let message = JSON.parse(error.body.message);
            console.error('error.message: ' + JSON.stringify(message));
            console.error('message.cause: ' + message.cause);
            const pathEvent = new CustomEvent('setsteplayout', {detail: 
                                                                {step: message.cause,
                                                                param: '',
                                                                objLead: this.objLead}});
            this.dispatchEvent(pathEvent);
        } finally {
            if(!this.showError) {
                nextbtn.disabled = false;
            }
        }
    }

    /**
    *  @Description: Go back to the previous step of the path
    *  @Autor:       Rodrigo Salinas Oye, Deloitte, rosalinas@deloitte.com
    *  @Date:        07/07/2021
    */
    prevStep(event) {
        const pathEvent = new CustomEvent('setsteplayout', {detail: {step: this.steps.step5, param: '', objLead: this.objLead}});
        this.dispatchEvent(pathEvent);
    }

}