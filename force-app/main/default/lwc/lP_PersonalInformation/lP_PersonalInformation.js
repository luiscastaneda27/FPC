import { LightningElement, track, wire, api} from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import getExpBaseValidation from '@salesforce/apex/LP_OnboardingStepTwoController.expressBaseValidation';
import getCustomerAssetLaundering from '@salesforce/apex/LP_OnboardingStepTwoController.customerAssetLaundering';
import getValidateClientEquifax from '@salesforce/apex/LP_OnboardingStepTwoController.validateClientEquifax';
import leadObject from '@salesforce/schema/Lead';
import generoField from '@salesforce/schema/Lead.LP_Genero__c';
import getInitClass from '@salesforce/apex/LP_OnboardingStepOneController.initClass';
import createLeadRecord from '@salesforce/apex/LP_OnboardingStepOneController.insertRecord';
import checkClient from '@salesforce/apex/LP_OnboardingStepOneController.checkClientExist';

import lRequestCard from '@salesforce/label/c.LP_SolicitaTarjeta';
import lWrite3Letters from '@salesforce/label/c.LP_Escribe3Letras';
import lGender from '@salesforce/label/c.LP_SeleccionaGenero';
import lEmailFormat from '@salesforce/label/c.LP_FormatoCorreo';
import lPhoneFormat from '@salesforce/label/c.LP_FormatoCelular';
import lAcceptTerms from '@salesforce/label/c.LP_AceptarTerminos';
import lRequestCardTwo from '@salesforce/label/c.LP_SolicitaTarjeta2';
import lContinueRequest from '@salesforce/label/c.LP_ContinuarSolicitud';
import lValidEmail from '@salesforce/label/c.LP_EmailValidado';
import lCorrectEmail from '@salesforce/label/c.LP_EmailConfirmado';
import lUnderstood from '@salesforce/label/c.LP_Entendido';
import lValidName from '@salesforce/label/c.LP_NombreValido';
import lValidLastName from '@salesforce/label/c.LP_ApellidoValido';
import lValidRUT from '@salesforce/label/c.LP_RutValido';
import lValidRUTFormat from '@salesforce/label/c.LP_RutSinPuntosGuiones';
import lCorrectEmailFormat from '@salesforce/label/c.LP_CorreoUsoFormato';
import lSetEmail from '@salesforce/label/c.LP_IngresaCorreo';
import lSet9Digits from '@salesforce/label/c.LP_Ingresa9Digitos';
import lPhoneIntegerNumber from '@salesforce/label/c.LP_CelularNumeroEntero';
import lPhoneWith9Digits from '@salesforce/label/c.LP_CelularCon9Digitos';
import lBegingPhone from '@salesforce/label/c.LP_CelularComienzo';
import step3 from '@salesforce/label/c.LP_OnboardingPaso3';

import GETUTILITY from '@salesforce/resourceUrl/LP_OnboardingUtility';
import { loadScript } from 'lightning/platformResourceLoader';

export default class LP_PersonalInformation extends LightningElement { 
    steps = {step3};
    @track objLead = { 'sobjectType': 'Lead' };
    @api objLeadIn = { 'sobjectType': 'Lead' };
    @api LP_Ruta;
    @track fields;
    @track siteKey;
    @track blackList;
    @track inputError;
    @track labels = {
        lRequestCard, 
        lWrite3Letters, 
        lGender,
        lEmailFormat, 
        lPhoneFormat, 
        lAcceptTerms,
        lRequestCardTwo, 
        lContinueRequest,
        lValidEmail, 
        lCorrectEmail, 
        lUnderstood, 
        lValidName, 
        lValidLastName,
        lValidRUT, 
        lValidRUTFormat, 
        lCorrectEmailFormat, 
        lSetEmail,
        lSet9Digits,
        lPhoneIntegerNumber, 
        lPhoneWith9Digits, 
        lBegingPhone   
    }
    @track msg = {
            text : {
                firstName : 'Escribe tu nombre',
                lastName : 'Escribe tu primer apellido',
                secName : 'Escribe tu segundo apellido',
                celPhone : this.labels.lSet9Digits,
                rut : this.labels.lValidRUTFormat,
                email : this.labels.lSetEmail
            }
    }
    @api disabledSubmit = false;
    @api reCaptchaCounter = 0;
    @api reCaptchaToken;
    @api validTermCond=false;
    @api showErrTermCond=false;
    @api nameB = false;
    @api apePB = false;
    @api apeMB = false;
    @api rutB = false;
    @api rutD = false;
    @api rutC = false;
    @api nacB = false;
    @api sexB = false;
    @api mailB = false;
    @api celB = false;
    @api validateError = false;
    @api clientExist;
    //@api expRegAlpha = /^[a-zA-Z ñÑ]+$/;
    @api expRegAlpha = /^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð '-]+$/u
    @api expRegMail = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
    @api expRegNumber = /^[0-9]+$/;
    @api recordId;
    @api leadRecord;
    @api marcaTerCond = 'false';
    @api formValidEmail = false;
    @api step;
    @wire(getObjectInfo, { objectApiName: leadObject })
    objectInfo;
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: generoField})
    generoPicklistValues;
    captchaVerified = false;
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

    @wire(getInitClass)
    labels({data, error}) {
        if (data) {
            this.fields = JSON.parse(data.labels);
            this.siteKey = data.siteKey;
            this.blackList = JSON.parse(JSON.stringify(data.objMapBlackList));
            //this.inputError = JSON.parse(JSON.stringify(data.fillMapInputError));

            this.objLead.FirstName = this.objLeadIn.FirstName == undefined ? '' : this.objLeadIn.FirstName;
            this.objLead.LastName = this.objLeadIn.LastName == undefined ? '' : this.objLeadIn.LastName;
            this.objLead.LP_ApellidoMaterno__c = this.objLeadIn.LP_ApellidoMaterno__c == undefined ? '' : this.objLeadIn.LP_ApellidoMaterno__c;
            this.objLead.LP_Rut__c = this.objLeadIn.LP_Rut__c == undefined ? '' : this.objLeadIn.LP_Rut__c;
            this.objLead.LP_Nacionalidad__c = this.objLeadIn.LP_Nacionalidad__c == undefined ? '' : this.objLeadIn.LP_Nacionalidad__c;
            this.objLead.LP_Genero__c = this.objLeadIn.LP_Genero__c == undefined ? '' : this.objLeadIn.LP_Genero__c;
            this.objLead.Email = this.objLeadIn.Email == undefined ? '' : this.objLeadIn.Email;
            this.objLead.MobilePhone = this.objLeadIn.MobilePhone == undefined ? '' : this.objLeadIn.MobilePhone;

            if (this.objLeadIn.FirstName != undefined){  
                this.validTermCond = true;
                this.marcaTerCond = 'true';
            }
        }
        else if (error) {
            window.console.log('error => '+JSON.stringify(error));
        }
    }
    /**
    *  @Description: Method that validate Nombre
    *  @Autor:       Nelson Lepiqueo, Deloitte, nlepiqueol@deloitte.com
    *  @Date:        12/05/2021
    */
    validateName(event){
        this.msg.text.firstName =  'Escribe tu nombre';
        this.objLead.FirstName = event.target.value;
        
        this.nameB = (this.objLead.FirstName == '') ? true : false;
        if (this.objLead.FirstName != ''){
            console.log('this.msg.text.firstName '+window.expRegAlpha(this.objLead.FirstName));
            this.msg.text.firstName = window.expRegAlpha(this.objLead.FirstName) ? this.msg.text.firstName : this.labels.lValidName;
            this.nameB = window.expRegAlpha(this.objLead.FirstName)  ? false : true;
            console.log('this.msg.text.firstName: '+this.msg.text.firstName);
            console.log('this.nameB: '+this.nameB);
        }
    }
    /**
    *  @Description: Method that validate Apellido Paterno
    *  @Autor:       Nelson Lepiqueo, Deloitte, nlepiqueol@deloitte.com
    *  @Date:        12/05/2021 
    */
    validateLastName(event){
        this.msg.text.lastName = 'Escribe tu primer apellido';
        this.objLead.LastName = event.target.value.trim();
        this.apePB = (this.objLead.LastName == '') ? true : false;

        if (this.objLead.LastName != ''){
            this.msg.text.lastName = window.expRegAlpha(this.objLead.LastName) ? this.msg.text.lastName : this.labels.lValidLastName;
            this.apePB = window.expRegAlpha(this.objLead.LastName) ? false : true;
        }
    }
    
    /**
    *  @Description: Method that validate Apellido Materno
    *  @Autor:       Nelson Lepiqueo, Deloitte, nlepiqueol@deloitte.com
    *  @Date:        12/05/2021
    */
    validateApellidoMaterno(event){
        this.msg.text.secName = 'Escribe tu segundo apellido';
        this.objLead.LP_ApellidoMaterno__c = event.target.value.trim();
        this.apeMB = (this.objLead.LP_ApellidoMaterno__c == '') ? true : false;

        if (this.objLead.LP_ApellidoMaterno__c != ''){
            this.msg.text.secName = window.expRegAlpha(this.objLead.LP_ApellidoMaterno__c) ? this.msg.text.secName : this.labels.lValidLastName;
            this.apeMB = window.expRegAlpha(this.objLead.LP_ApellidoMaterno__c) ? false : true;
        }
    }
    
    /**
    *  @Description: Method that validate RUT
    *  @Autor:       Nelson Lepiqueo, Deloitte, nlepiqueol@deloitte.com
    *  @Date:        12/05/2021
    */
    validateRut(event){
        this.msg.text.rut = this.labels.lValidRUTFormat;
        this.objLead.LP_Rut__c = event.target.value.trim();
        this.rutB = (this.objLead.LP_Rut__c == '') ? true : false;

        if (this.objLead.LP_Rut__c != ''){
            if(this.objLead.LP_Rut__c.length < 9 || this.blackList[this.objLead.LP_Rut__c] || !this.chekRut(this.objLead.LP_Rut__c)){
                this.rutB = true;
                this.msg.text.rut = this.labels.lValidRUT;
            }
        }
    }

    /**
    *  @Description: Method that validate of Rut (code)
    *  @Autor:       Nelson Lepiqueo, Deloitte, nlepiqueol@deloitte.com
    *  @Date:        13/05/2021
    */
    chekRut(rut) {
        let retornValidate = false;
        if (rut.toString().trim() != '' && rut.toString().indexOf('-') > 0) {
            let caracteres = new Array();
            let serie = new Array(2, 3, 4, 5, 6, 7);
            let dig = rut.toString().substr(rut.toString().length - 1, 1);
            rut = rut.toString().substr(0, rut.toString().length - 2);
    
            for (let i = 0; i < rut.length; i++) {
                caracteres[i] = parseInt(rut.charAt((rut.length - (i + 1))));
            }
    
            let sumatoria = 0;
            let k = 0;
            let resto = 0;
    
            for (let j = 0; j < caracteres.length; j++) {
                k = (k == 6) ? 0 : k;
                sumatoria += parseInt(caracteres[j]) * parseInt(serie[k]);
                k++;
            }
    
            resto = sumatoria % 11;
            let dv = 11 - resto;

            dv = (dv == 10) ? "k" : dv;
            dv = (dv == 11) ? 0 : dv;
    
            retornValidate = (dv.toString().trim().toUpperCase() == dig.toString().trim().toUpperCase()) ? true : false;
        }
        return retornValidate;
    }


    /**
    *  @Description: Method that validate Nacionalidad
    *  @Autor:       Nelson Lepiqueo, Deloitte, nlepiqueol@deloitte.com
    *  @Date:        12/05/2021
    */
    validateCountry(event){
        this.objLead.LP_Nacionalidad__c = event.target.value.trim();
        this.nacB = (this.objLead.LP_Nacionalidad__c == '') ? true : false;
    }
    /**
    *  @Description: Method that validate Genero
    *  @Autor:       Nelson Lepiqueo, Deloitte, nlepiqueol@deloitte.com
    *  @Date:        12/05/2021
    */
    validateSex(event){
        this.objLead.LP_Genero__c = event.target.value.trim();
        this.sexB = (this.objLead.LP_Genero__c == '') ? true : false;
    }
    /**
    *  @Description: Method that validate Email
    *  @Autor:       Nelson Lepiqueo, Deloitte, nlepiqueol@deloitte.com
    *  @Date:        12/05/2021
    */
    validateEmail(event){
        this.msg.text.email = this.labels.lSetEmail;
        this.objLead.Email = event.target.value.trim();
        this.mailB = (this.objLead.Email == '') ? true : false;

        if (this.objLead.Email != ''){
            this.msg.text.email = window.emailValidation(this.objLead.Email) ? this.msg.text.email : this.labels.lCorrectEmailFormat;
            this.mailB = window.emailValidation(this.objLead.Email) ? false : true;
        }
    }
    /**
    *  @Description: Method that validate Celular
    *  @Autor:       Nelson Lepiqueo, Deloitte, nlepiqueol@deloitte.com
    *  @Date:        12/05/2021
    */
    validateCelPhone(event){
        // '+56'+ cargar al final en el submit

        this.msg.text.celPhone = this.labels.lSet9Digits;
        this.objLead.MobilePhone = (event.target.value.trim() != '') ? event.target.value.trim() : '';
        
        this.celB = (this.objLead.MobilePhone == '') ? true : false;
        
        if (this.objLead.MobilePhone != ''){
            this.msg.text.celPhone = window.phoneFormat(this.objLead.MobilePhone) ? this.msg.text.celPhone : this.labels.lPhoneIntegerNumber;;
            this.celB = window.phoneFormat(this.objLead.MobilePhone) ? false : true;

            if (this.objLead.MobilePhone.length < 9 ){
                this.msg.text.celPhone = (this.objLead.MobilePhone.length < 9 ) ? this.labels.lPhoneWith9Digits : this.msg.text.celPhone;
                this.celB = true;
            }

            else if (this.objLead.MobilePhone.substring(0, 1) != '9'){
                this.msg.text.celPhone = this.objLead.MobilePhone.substring(0, 1) != '9' ? this.labels.lBegingPhone : this.msg.text.celPhone; 
                this.celB = true;
            }
        }
    }
     
    /**
    *  @Description: Method that show error for empty input 
    *  @Autor:       Nelson Lepiqueo, Deloitte, nlepiqueol@deloitte.com
    *  @Date:        12/05/2021
    */
    validateInput(){
        // show message error for Terms Conditions
        this.showErrTermCond = (!this.validTermCond) ? true : false;

        this.nameB = this.nameB ? true : (this.objLead.FirstName == '' ? true : false);
        this.apePB = this.apePB ? true : (this.objLead.LastName == '' ? true : false);
        this.apeMB = this.apeMB ? true : (this.objLead.LP_ApellidoMaterno__c == '' ? true : false);
        this.rutB = this.rutB ? true : (this.objLead.LP_Rut__c == '' ? true : false);
        this.nacB = this.nacB ? true : (this.objLead.LP_Nacionalidad__c == '' ? true : false);
        this.sexB = this.sexB ? true : (this.objLead.LP_Genero__c == '' ? true : false);
        this.mailB = this.mailB ? true : (this.objLead.Email == '' ? true : false);
        this.celB = this.celB ? true : (this.objLead.MobilePhone == '' ? true : false);
        
        if (!this.showErrTermCond && !this.nameB && !this.apePB && !this.apeMB && !this.rutB && !this.nacB && !this.sexB && !this.mailB && !this.celB){
            this.validateError = true;
        }
    }

    
    async submitData(event) {
        this.disabledSubmit = true;
        this.validateInput();
        const client = await checkClient({rut: this.objLead.LP_Rut__c})
            .then( (result) => {
                this.clientExist = result;
            })
            .catch( (error) => {
                this.disabledSubmit = false;
                this.clientExist = true;
                this.error = error;
                var message = JSON.parse(error.body.message);
                const pathEvent = new CustomEvent('setsteplayout', {detail: 
                                                                    {step: message.cause,
                                                                    param: this.objLead.Email,
                                                                    objLead: this.objLead}});
                this.dispatchEvent(pathEvent);
            });
            
        if (this.validateError && this.clientExist == null){
            
            const resetCaptchaEvent = new Event("grecaptchaReset");
            createLeadRecord({record: this.objLead, recaptchaResponse: this.reCaptchaToken})
                .then(result => {
                    this.LP_Ruta = result;
                    let detail = result;
                    document.dispatchEvent(resetCaptchaEvent);
                    if(detail.substring(detail.length-1,detail.length) > 2 ) {
                        this.formValidEmail = true;
                        this.step = detail;
                    }
                    else {
                        const pathEvent = new CustomEvent('setsteplayout', {detail: 
                        {step: detail,
                        param: this.objLead.Email,
                        objLead: this.objLead}});
                        this.dispatchEvent(pathEvent);
                    } 
                })
                .catch(error => {
                    this.disabledSubmit = false;
                    this.error = error;
                    document.dispatchEvent(resetCaptchaEvent);
                    var message = JSON.parse(error.body.message)
                    console.log('error.message: ' + JSON.stringify(message));
                    console.log('message.cause: ' + message.cause);
                    const pathEvent = new CustomEvent('setsteplayout', {detail: 
                                                                        {step: message.cause,
                                                                        param: this.objLead.Email,
                                                                        objLead: this.objLead}});
                    this.dispatchEvent(pathEvent);
                });
        }
    }
    /**
    *  @Description: Method that take event of check Terms Condition
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        04/05/2021
    */
    passToParentTermCond(event){
        this.validTermCond = event.detail;
        this.showErrTermCond = false;
        this.disabledSubmit = true;
        if(this.validTermCond && this.reCaptchaToken != null){
            this.disabledSubmit = false;
        }
    }

    closeModal(event){
        this.formValidEmail = false;
    }


    /** ReCaptcha v2 */
    /**
    *  @Description: Method that adds the listener for grecaptchaVerified and grecaptchaExpired events
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        04/05/2021
    */
    connectedCallback() {
        //When the page is loaded the submit button is deactivated
        this.disabledSubmit = true;
        //The listener is added to the grecaptchaVerified event to receive the captcha token
        document.addEventListener("grecaptchaVerified", (e) => { // Arrow function takes the scope of the entire component
            this.reCaptchaCounter++;
            //The number of attempts for the captcha is validated
            if (this.reCaptchaCounter > 3) {
                this.disabledSubmit = true;
                alert('Ha superado el número máximo de intentos para verificar que es un humano');
            } else { //If the number of attempts is less than 3, the button is disabled for the customer to request their card
                this.reCaptchaToken = e.detail.response;
                this.disabledSubmit = this.validTermCond ? false : true;
            }
        });
        //when the grecaptchaExpired event is fired, the submit button is deactivated again
        document.addEventListener("grecaptchaExpired", () => { // Arrow function takes the scope of the entire component
            this.disabledSubmit = true;
            this.reCaptchaToken = null;
        }); 
    }

    /**
    *  @Description: Method that triggers the grecaptchaRender event and send the element where the captcha will be render
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        04/05/2021
    */
     renderedCallback() {
        //Get the element where the captcha will be render
        var divElement = this.template.querySelector('div.recaptchaCheckbox');
        var payload = {element: divElement};
        var key = {element: this.siteKey};
        //Triggers the grecaptchaRender event and send the element
        document.dispatchEvent(new CustomEvent("grecaptchaRender", {"detail": payload}));
        //Triggers the grecaptchaSiteKey event and send the element with the sitekey
        document.dispatchEvent(new CustomEvent("grecaptchaSiteKey", {"detail": key}));
    }
    /** End ReCaptcha v2 */ 
    
    async nextStep(){
        try{

            //validate again Lavado de Activos, Base Express and Equifax.
            const result1 = await getExpBaseValidation({
                objLead: this.objLead
            });

            const result2 = await getCustomerAssetLaundering({
                sObjList: result1
            });

            const result3 = await getValidateClientEquifax({
                sObjList: result2
            });
    
            const pathEvent = new CustomEvent('setsteplayout', {detail: 
                {step: this.steps.step3,
                param: this.objLead.Email,
                objLead: this.objLead}});
                this.dispatchEvent(pathEvent);
        }catch(error){
            console.log('objLead: '+this.objLead);
            var message = JSON.parse(error.body.message);
            console.log('error.message: ' + JSON.stringify(message));
            console.log('message.cause: ' + message.cause);
            const pathEvent = new CustomEvent('setsteplayout', {detail: 
                                                                {step: message.cause,
                                                                param: this.objLead.Email,
                                                                objLead: this.objLead}});
            this.dispatchEvent(pathEvent);
        }
    }
}