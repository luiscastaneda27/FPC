import { LightningElement, wire, track, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getAccount from '@salesforce/apex/LP_OnboardingStepSevenController.searchAccountByRUT';
import createAccountCommunityUser from '@salesforce/apex/LP_OnboardingStepSevenController.createAccountUser';

import lHelpCreatePassword from '@salesforce/label/c.LP_AyudaCreacionClave';
import lSetPassword from '@salesforce/label/c.LP_IngresarClave';
import lConfirmPassword from '@salesforce/label/c.LP_ConfirmarClave';
import lUnmachPassword from '@salesforce/label/c.LP_ClaveNoCoincide';
import lWeakPassword from '@salesforce/label/c.LP_ClaveDebil';
import lIntermediatePassword from '@salesforce/label/c.LP_ClaveIntermedia';
import lStrongPassword from '@salesforce/label/c.LP_ClaveFuerte';
import lCardVisaTitle from '@salesforce/label/c.LP_TarjetaLaPolarVisaTitulo';
import lCardVisaSubTitle from '@salesforce/label/c.LP_TarjetaLaPolarVisaSubTitulo';
import lCardVisaTextDown from '@salesforce/label/c.LP_TarjetaLaPolarVisaBajada';
import lCardVisaBtnNext from '@salesforce/label/c.LP_TarjetaLaPolarVisaTextoBotonContinuar';
import lCardTitle from '@salesforce/label/c.LP_TarjetaLaPolarTitulo';
import lCardSubTitle from '@salesforce/label/c.LP_TarjetaLaPolarSubTitulo';
import lCardTextDown from '@salesforce/label/c.LP_TarjetaLaPolarBajada';
import lCardBtnNext from '@salesforce/label/c.LP_TarjetaLaPolarTextoBotonContinuar';
import urlCard from '@salesforce/label/c.LP_BloqueoTarjeta';
import urlPrivateSite from '@salesforce/label/c.LP_UrlPrivateSite';
import lBtnNext from '@salesforce/label/c.LP_Continuar';
import lBtnPrev from '@salesforce/label/c.LP_Regresar';
//Import Static Resource
import iTarjetaLPVisa from '@salesforce/resourceUrl/LP_TarjetaPolarVisa';
import iTarjetaLP from '@salesforce/resourceUrl/LP_TarjetaPolar';
import iRedEdit from '@salesforce/resourceUrl/LP_iconPreview';
import helpIcon from '@salesforce/resourceUrl/LP_HelpIcon';
import CLIENT_FORM_FACTOR from '@salesforce/client/formFactor';
import step7 from '@salesforce/label/c.LP_OnboardingPaso7';

import GETUTILITY from '@salesforce/resourceUrl/LP_OnboardingUtility';
import { loadScript } from 'lightning/platformResourceLoader';

export default class LP_InternetPassword extends NavigationMixin(LightningElement)  {
    steps = {step7};
    @api recordId;
    @api objLead;
    @track ownerName;
    accountRecord;
    error;
    isPhone = CLIENT_FORM_FACTOR == 'Large' ? false : true;

    password = '';
    repeatPassword = '';
    showErrorPassword = false;
    showPassSecurityMsg = false;

    // static resource to use in the template
    @track labelAndResources = {
        text : {
            lHelpCreatePassword,
            lSetPassword,
            lConfirmPassword,
            lUnmachPassword
        },
        iRedEdit : iRedEdit,
        helpIcon : helpIcon,
        subTitle : lCardVisaSubTitle,
        txtDown : lCardVisaTextDown,
        txtBtnNext : lCardVisaBtnNext,
        passSecurity : lWeakPassword,
        lBtnNext : lBtnNext,
        lBtnPrev : lBtnPrev,
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
    *  @Description: Get Account
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        15/08/2021
    */

    connectedCallback() {
        getAccount({rut: this.objLead.LP_Rut__c})        
        .then(result => {
            this.accountRecord = JSON.stringify(result);
            var stepTitle = lCardVisaTitle;
            var laPolarCard = result;
            this.ownerName = result.FirstName + ' ' + result.LastName;
            this.labelAndResources.image = iTarjetaLPVisa; 
            if(laPolarCard.LP_TipoTarjeta__c == '01'){
                this.labelAndResources.image = iTarjetaLP;
                this.labelAndResources.subTitle = lCardSubTitle;
                this.labelAndResources.txtDown = lCardTextDown;
                this.labelAndResources.txtBtnNext = lCardBtnNext;
                stepTitle = lCardTitle;
            }

            const selectedEvent = new CustomEvent("steptitle", {detail: {title: stepTitle}});
            this.dispatchEvent(selectedEvent);
        }).catch(error => {
           /*  this.error = error;
            var message = JSON.parse(error.body.message);
            console.log('error.message: ' + JSON.stringify(message));
            console.log('message.cause: ' + message.cause);
            const pathEvent = new CustomEvent('setsteplayout', {detail: 
                                                                {step: message.cause,
                                                                param: this.objLead.Email,
                                                                objLead: this.objLead}});
            this.dispatchEvent(pathEvent); */
        });
    }

    /**
    *  @Description: Method that validate Clave
    *  @Autor:       Fran Oseguera, Deloitte
    *  @Date:        29/06/2021
    */
     validatePassword(event){
        this.showErrorPassword = false;
        this.showPassSecurityMsg = false;
        var nextbtn = this.template.querySelector('.next-page-btn'); 
        nextbtn.disabled = true;
        var toolTipBtn = this.template.querySelector('.slds-popover'); 
        toolTipBtn.style.display = 'none';

        //const regex = /(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
        //const strongPassword = /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[^A-Za-z0-9])(?=.{8})/;

        const field = event.target.name;
        if (field === 'passwordName') {
            this.password = event.target.value;
        } else if (field === 'repeatPasswordName') {
            this.repeatPassword = event.target.value;
        }

        var isSecured = false;
        if(this.password != ''){
            this.labelAndResources.passSecurity = lWeakPassword;
            if(window.passwordStrong(this.password) == true){
                this.labelAndResources.passSecurity = lStrongPassword;
                isSecured = true;
            }else if(window.passwordMedium(this.password) == true){
                this.labelAndResources.passSecurity = lIntermediatePassword;
                isSecured = true;
            }
            this.showPassSecurityMsg = true;
        }

        if(this.password != '' && this.repeatPassword != ''){
            //if ((this.password != this.repeatPassword || this.password.length < 8 || regex.test(this.password) == false ) && isSecured == false ){
            //if ((this.password != this.repeatPassword || this.password.length < 6 || window.passwordComplexity(this.password) == false ) || isSecured == false ){
            if (this.password != this.repeatPassword ){
                this.showErrorPassword = true;
            }else{
                if(this.password.length < 6 || isSecured == false){
                    nextbtn.disabled = true;
                }else{
                    nextbtn.disabled = false;
                    toolTipBtn.style.display = '';
                }
            }
        }
    }

    /**
    *  @Description: Method that show Password
    *  @Autor:       Fran Oseguera, Deloitte
    *  @Date:        29/06/2021
    */

    showPassword(){
        this.template.querySelector('input[name="passwordName"]').type = 'text';
        setTimeout(() => {
            this.template.querySelector('input[name="passwordName"]').type = 'password';    
        }, 2000);
    }

    showConfirmPassword(event){
        this.template.querySelector('input[name="repeatPasswordName"]').type = 'text'; 
        setTimeout(() => {
            this.template.querySelector('input[name="repeatPasswordName"]').type = 'password';    
        }, 2000);
    }

     /**
    *  @Description: Method that finish onboarding
    *  @Autor:       Fran Oseguera, Deloitte
    *  @Date:        29/06/2021
    */
      submitData(){
        let acco = JSON.parse(this.accountRecord);
        acco.LP_CreacionClaveInternet__pc = true;
        acco.LP_FechaCreacionClaveINTERNET__pc = new Date();
        acco.LP_RutaOnboarding__pc = this.steps.step7;
        acco.id = this.accountRecord.Id;
        
        createAccountCommunityUser({ acc: acco, password : this.password, updateAcc : true })
        .then(() => {
            this[NavigationMixin.GenerateUrl]({
                type : 'standard__webPage',
                attributes: {
                    url : urlPrivateSite
                },
            }).then(url => { window.open(url, "_self") });
        })
        .catch(error => {
            console.log(error);
        });

    }

    /**
    *  @Description: Go back to the previous step of the path
    *  @Autor:       FO, Deloitte
    *  @Date:        08/06/2021
    */
     prevStep() {
        this[NavigationMixin.GenerateUrl]({
            type : 'standard__webPage',
            attributes: {
                url : urlCard
            },
        }).then(url => { window.open(url, "_self") });
    }

}