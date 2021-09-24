/*********************************************************************************
Project      : Sodimac Salesforce Service Cloud
Created By   : Deloitte
Created Date : 17/05/2021
Description  : Javascript - OTP Validation
History      :
**************************ACRONYM OF AUTHORS************************************
AUTHOR                      ACRONYM
Abdon Tejos O.              ATO
********************************************************************************
VERSION  AUTHOR         DATE            Description
1.0       ATO	     17/05/2021		initial version
********************************************************************************/
import { LightningElement, wire, track, api } from 'lwc';
import getCall from '@salesforce/apex/LP_OnboardingStepTwoController.callToOtpService';
import getCodeValidation from '@salesforce/apex/LP_OnboardingStepTwoController.otpCodeValidation';
import getUpdateObj from '@salesforce/apex/LP_OnboardingStepTwoController.updateObjs';
import getExpBaseValidation from '@salesforce/apex/LP_OnboardingStepTwoController.expressBaseValidation';
import getCustomerAssetLaundering from '@salesforce/apex/LP_OnboardingStepTwoController.customerAssetLaundering';
import getValidateClientEquifax from '@salesforce/apex/LP_OnboardingStepTwoController.validateClientEquifax';
//Import Static Resource
import iCheck from '@salesforce/resourceUrl/LP_IconoCheckOTP';
import iMail from '@salesforce/resourceUrl/LP_IconoCorreoOTP';
import iGreyEdit from '@salesforce/resourceUrl/LP_IconoEdicionGrisOTP';
import iRedEdit from '@salesforce/resourceUrl/LP_IconoEdicionRojoOTP';
import iError from '@salesforce/resourceUrl/LP_IconoErrorOTP';
import iSuccess from '@salesforce/resourceUrl/LP_IconoExitoOTP';
//Import Custom Label
import lStepTitle from '@salesforce/label/c.LP_ValidaEmail';
import lEmailFormat from '@salesforce/label/c.LP_FormatoCorreo';
import lCorrectEmailFormat from '@salesforce/label/c.LP_CorreoUsoFormato';
import lBtnSendReplace from '@salesforce/label/c.LP_OTP_CodigoEnviado';
import lBtnSend from '@salesforce/label/c.LP_OTP_EnviarCodigo';
import lEmail from '@salesforce/label/c.LP_OTP_EtiquetaCorreo';
import lTxtMistake from '@salesforce/label/c.LP_OTP_TextoCantidaDeIntento';
import lTxtEmail from '@salesforce/label/c.LP_OTP_TextoCorreo';
import lTxtTried from '@salesforce/label/c.LP_OTP_TextoIntento';
import lBtnCheckCode from '@salesforce/label/c.LP_OTP_VerificarCodigo';
import lBtnNext from '@salesforce/label/c.LP_Continuar';
import lBtnPrev from '@salesforce/label/c.LP_Regresar';
import lClose from '@salesforce/label/c.LP_OTP_ModalCerrar';
import lUnderstood from '@salesforce/label/c.LP_OTP_ModalEntendido';
import lMsgError from '@salesforce/label/c.LP_OTP_ModalMensaje';
import lSubTitle from '@salesforce/label/c.LP_OTP_ModalSubTitulo';
import lTitle from '@salesforce/label/c.LP_OTP_ModalTitulo';
import step1 from '@salesforce/label/c.LP_OnboardingPaso1';
import lInvalidCode from '@salesforce/label/c.LP_OTP_TextoErrorTituloValidacionCelular';

import GETUTILITY from '@salesforce/resourceUrl/LP_OnboardingUtility';
import { loadScript } from 'lightning/platformResourceLoader';

export default class LP_OTPValidation extends LightningElement {
    steps = {step1}
    @api email;
    @api showError;
    @api objLead;
    @api inputOtp;
    @track objList;
    @track otpValidation;
	otpInvalidCode = false;
    @track labels = {
        button : {
            send : lBtnSend,
            sendReplace : lBtnSendReplace,
            checkCode : lBtnCheckCode,
            prev : lBtnPrev,
            next : lBtnNext,
            close : lClose,
            understood : lUnderstood
        },
        text : {
            email : lTxtEmail,
            tried : lTxtTried.split('#')[0],
            tried2 : lTxtTried.split('#')[1],
            mistake : lTxtMistake.split('#')[0],
            mistake2 : lTxtMistake.split('#')[1],
            numberAttempts : 3,
            msgError : lMsgError,
            modalSubTitle : lSubTitle,
            modalTitle : lTitle

        },
        label : {
            email : lEmail,
            lStepTitle,
            lEmailFormat,
            lCorrectEmailFormat,
			lInvalidCode
        }
    }
    // static resource to use in the template
    iconOTP = {
        iCheck,
        iMail,
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
        loadScript(this, GETUTILITY)
        .then(() => console.log('Loaded GETUTILITY'))
        .catch(error => console.log('error: ' + JSON.stringify(error)));
    }

    /**
    *  @Description: Consume the service to send the otp code
    *  @Autor:       Abdon Tejos, Deloitte, atejos@deloitte.com
    *  @Date:        17/05/2021
    */
    handleSearch() {
        this.template.querySelector(".active-button2").style.display = "none";
        this.template.querySelector(".button2").disabled = true; // Disable send button
        getCall({objLead: this.objLead, userEmail: this.email})
            .then((result) => {
                this.otpValidation = result;
                this.labels.button.send = this.labels.button.sendReplace;
                this.template.querySelector(".active-button2").style.display = "block";
                this.template.querySelector(".active-button2").src = this.iconOTP.iCheck; // Load the check icon in the send button
                this.template.querySelector(".button1").disabled = true; // Disable email button
                this.template.querySelector(".active-button").src = this.iconOTP.iGreyEdit; // Load the gray edit icon in the edit email button
                this.template.querySelector(".button3").disabled = false; // Enable the verify code button
                this.template.querySelector(".button3").style.display = "block";
                this.template.querySelector(".active-button3").style.display = "none";
                this.template.querySelector(".input-space").disabled = true; // Disable email input
            })
            .catch((error) => {
                this.template.querySelector(".active-button2").style.display = "block";
                this.template.querySelector(".button2").disabled = false; // Enable send button
                this.error = error;
                var message = JSON.parse(error.body.message);
                console.log('error.message: ' + JSON.stringify(message));
                console.log('message.cause: ' + message.cause);
                const pathEvent = new CustomEvent('setsteplayout', {detail: 
                                                                    {step: message.cause,
                                                                    param: this.objLead.Email,
                                                                    objLead: this.objLead}});
                this.dispatchEvent(pathEvent);
            });
    }

    /**
    *  @Description: Validate the otp code, if it is valid update the objects
    *  @Autor:       Abdon Tejos, Deloitte, atejos@deloitte.com
    *  @Date:        17/05/2021
    */
    getOtpValidation(event) {
        var activebtn3 = this.template.querySelector(".active-button3");
        var nextbtn = this.template.querySelector(".next-page-btn");
        var btn3 = this.template.querySelector(".button3");
        var textMistake = this.template.querySelector(".text-mistake");
        var input = '';
        this.template.querySelectorAll('.code-input').forEach(element => {
            input+= element.value;
        });
        this.inputOtp = input;
        console.log('this.inputOtp: ' + this.inputOtp);
        console.log('cipherCode: ' + this.otpValidation);
        getCodeValidation({inputCode: this.inputOtp, cipherCode: this.otpValidation})
            .then((result) => {
                activebtn3.style.display = "block";
                activebtn3.src = this.iconOTP.iSuccess;
                btn3.style.display = "none";
                textMistake.style.display = "none";            
                nextbtn.disabled = false;
                this.otpInvalidCode = false;
                this.setUpdate(event);
            })
            .catch((error) => {
                this.error = error;
                var message = JSON.parse(error.body.message);
                console.log('error.message: ' + JSON.stringify(message));
                console.log('message.cause: ' + message.cause);
                this.template.querySelectorAll('.code-input').forEach(element => {
                    element.value = '';
                });
                this.template.querySelector(".button2").disabled = false;
                this.labels.button.send = lBtnSend;
                this.template.querySelector(".active-button2").src = '';
                this.labels.text.numberAttempts = this.labels.text.numberAttempts - 1;
                this.showError = this.labels.text.numberAttempts == 0 ? true : false;           
                this.otpInvalidCode = true;
                activebtn3.src = this.iconOTP.iError;
                activebtn3.style.display = "block";
                btn3.style.display = "none";
                textMistake.style.display = "block";
                nextbtn.disabled = true;
            });
    }

    /**
    *  @Description: Call the server to update the lead and onboarding object
    *  @Autor:       Abdon Tejos, Deloitte, atejos@deloitte.com
    *  @Date:        19/05/2021
    */
    setUpdate(event) {
        getUpdateObj({objLead: this.objLead, userEmail: this.email, otpCode: this.otpValidation})
            .then(result => {
                //console.log('result: ' + JSON.stringify(result));
            })
            .catch(error => {
                console.log(error);
                this.error = error;
            });
    }

    /**
    *  @Description: Method that validate Email
    *  @Autor:       Abdon Tejos, Deloitte, atejos@deloitte.com
    *  @Date:        17/05/2021
    */
    validateEmail(event) {
        var element = this.template.querySelector(".input-space");
        this.email = element.value;
        //const regex = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
        if (window.emailValidation(this.email)) {
            this.template.querySelector(".error-message").style.display = "none"; // Hide the error message
            this.template.querySelector(".button2").disabled = false;
        } else {
            this.template.querySelector(".error-message").style.display = "block"; // Show the error message
            this.template.querySelector(".button2").disabled = true; // Disable send button
        }
    }    
    /**
    *  @Description: Validates if the code is alphanumeric
    *  @Autor:       Abdon Tejos, Deloitte, atejos@deloitte.com
    *  @Date:        17/05/2021
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
            var maxlenght = parseInt(inputCmp.maxLength, 10);
            if(inputCmp.value.length == maxlenght) {
                var next = inputCmp.nextElementSibling;
                if (next != null) {
                    next.focus();
                }
            }
            else if(inputCmp.value.length == 0) {
                var previous = inputCmp.previousElementSibling;
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
    *  @Description: Move on to the next step on the path
    *  @Autor:       Abdon Tejos, Deloitte, atejos@deloitte.com
    *  @Date:        19/05/2021
    */
    async nextStep(event) {
        var nextbtn = this.template.querySelector(".next-page-btn");
        try {            
            if(this.showError){
                const pathEvent = new CustomEvent('setsteplayout', {detail: {step: this.steps.step1, param: '', objLead: this.objLead}});
                this.dispatchEvent(pathEvent);
            }else{
                console.log('LEAD: '+JSON.stringify(this.objLead));
                nextbtn.disabled = true;
                const prevResult = await getCodeValidation({
                    inputCode: this.inputOtp, cipherCode: this.otpValidation
                });
                const result1 = await getExpBaseValidation({
                    objLead: this.objLead
                });
                console.log('getExpBaseValidation result: ' + JSON.stringify(result1));
                const result2 = await getCustomerAssetLaundering({
                    sObjList: result1
                });
                console.log('getCustomerAssetLaundering result: ' + JSON.stringify(result2));
                const result3 = await getValidateClientEquifax({
                    sObjList: result2
                });
                if(result3 == 'error'){
                    const pathEvent = new CustomEvent('setsteplayout', {detail: 
                        {step: 'ERR_NOCARD',
                        param: this.objLead.Email,
                        objLead: this.objLead}});
                    this.dispatchEvent(pathEvent);
                }else{
                    console.log('getValidateClientEquifax result: ' + JSON.stringify(result3));
                    const pathEvent = new CustomEvent('setsteplayout', {detail: {step: result3, param: '', objLead: this.objLead}});
                    this.dispatchEvent(pathEvent);
                }
            }
        } catch (error) {
            this.error = error;
            var message = JSON.parse(error.body.message);
            console.log('error.message: ' + JSON.stringify(message));
            console.log('message.cause: ' + message.cause);
            const pathEvent = new CustomEvent('setsteplayout', {detail: 
                                                                {step: message.cause,
                                                                param: this.objLead.Email,
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
    *  @Autor:       Abdon Tejos, Deloitte, atejos@deloitte.com
    *  @Date:        19/05/2021
    */
    prevStep(event) {
        const pathEvent = new CustomEvent('setsteplayout', {detail: {step: this.steps.step1, param: '', objLead: this.objLead}});
        this.dispatchEvent(pathEvent);
    }

}