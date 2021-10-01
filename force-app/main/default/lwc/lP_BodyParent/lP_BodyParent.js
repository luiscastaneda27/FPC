/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 23/04/2021
Description  : Javascript - Body Parent
History      :
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Nelson Lepiqueo 			   NL
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0       NL		  23/04/2021		initial version
********************************************************************************/
import { LightningElement, wire, track, api } from 'lwc';
import { CurrentPageReference } from "lightning/navigation";
import lTitleCliExist from '@salesforce/label/c.LP_ErrorOnbTitle_Exist';
import lTitleCliNoCard from '@salesforce/label/c.LP_ErrorOnbTitle_NoCard';
import lTitleSystem from '@salesforce/label/c.LP_ErrorOnbTitle_System';
import lTitleSolicCard from '@salesforce/label/c.LP_TitleSolicCard';
import lSubTitle from '@salesforce/label/c.LP_InicioPideTarjeta';
import lTitleValidatingIdentity from '@salesforce/label/c.LP_TitleValidatingIdentity';
import getGUIDOnboardingByRUT from '@salesforce/apex/LP_OnboardingStepThreeController.getGUIDOnboardingByRUT';
import getResourceURL from '@salesforce/apex/LP_OnboardingStepOneController.getResourceURL';
import backgroundColor from '@salesforce/label/c.LP_BodyParentBGColor';
import lStepSixTitle from '@salesforce/label/c.LP_ValidaFirmaDocStepSix';

//Steps 
import step1 from '@salesforce/label/c.LP_OnboardingPaso1';
import step2 from '@salesforce/label/c.LP_OnboardingPaso2';
import step3 from '@salesforce/label/c.LP_OnboardingPaso3';
import step4 from '@salesforce/label/c.LP_OnboardingPaso4';
import step5 from '@salesforce/label/c.LP_OnboardingPaso5';
import step6 from '@salesforce/label/c.LP_OnboardingPaso6';
import step7 from '@salesforce/label/c.LP_OnboardingPaso7';
import ERR_EXIST_CLIENT from '@salesforce/label/c.LP_ERR_EXIST_CLIENT';
import ERR_NOCARD from '@salesforce/label/c.LP_ERR_NOCARD';
import ERR_SYSTEM from '@salesforce/label/c.LP_ERR_SYSTEM';
import SystemModstamp from '@salesforce/schema/Account.SystemModstamp';
import MailingPostalCode from '@salesforce/schema/Contact.MailingPostalCode';


export default class LP_BodyParent extends LightningElement {
    @api paramchildError;
    @track objLead = { 'sobjectType': 'Lead' };
    @api mail;
    @api paramNextStep;
    @api isParam=false;
    @api stepForParam;
    @api step;
    @api title;
    @track stepLayout = {
        showPath : true,
        step1 : true,
        step2 : false,
        step3 : false,
        step4 : false,
        step5 : false,
        step6 : false,
        step7 : false,
        error : false,
        title : lTitleSolicCard,
        lSubTitle
    }
    @track steps= {
        step1,
        step2,
        step3,
        step4,
        step5,
        step6,
        step7
    }
    errors = {
        ERR_EXIST_CLIENT,
        ERR_NOCARD,
        ERR_SYSTEM    
    }
    @track titles = {
        validatingIdentity : lTitleValidatingIdentity,
        existClient : lTitleCliExist,
        ClientNoCard : lTitleCliNoCard,
        systemError : lTitleSystem,
        stepSixTitle : lStepSixTitle
    }

    currentPageReference;
    // Injects the page reference that describes the current page
    @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        this.currentPageReference = currentPageReference;
        /*if (this.connected) {
            // We need to have the currentPageReference, and to be connected before
            // we can use NavigationMixin
            this.generateUrls();
        } else {
            // NavigationMixin doesn't work before connectedCallback, so if we have 
            // the currentPageReference, but haven't connected yet, queue it up
            this.generateUrlOnConnected = true;
        }*/
    }

    /**
    *  @Description: Get the layout corresponding to the path step
    *  @Autor:       Abdon Tejos, Deloitte, atejos@deloitte.com
    *  @Date:        17/05/2021
    */
    getCaseLayoutSteps(event) {

        this.step = event.detail.step;
        var param = event.detail.param == null ? '' : event.detail.param;
        this.objLead = event.detail.objLead == null ? this.objLead : event.detail.objLead;
        this.cleanStepLayout();
        this.stepLayout.showPath = true;        
        this.paramchildError = this.step;
        this.stepForParam = this.step;
        switch (this.step) {
            case this.steps.step1 :
                this.stepLayout.step1 = true;
                break;
            case this.steps.step2 :
                this.stepLayout.step2 = true;
                this.mail = param;
                break;
            case this.steps.step3 :
                this.stepLayout.step3 = true;
                break;
            case this.steps.step4 :
                this.paramNextStep = param;
                this.stepLayout.step4 = true;
                this.stepLayout.title = this.titles.validatingIdentity;
                break;
            case this.steps.step5 : 
                this.param =false;
                this.stepLayout.step5 = true;
                break;
            case this.steps.step6 :
                this.stepLayout.step6 = true;
                this.stepLayout.title = this.titles.stepSixTitle;
                break;
            case this.steps.step7 :
                this.stepLayout.step7 = true;
                //this.stepLayout.title = this.titles.youGetACard;
                break;
            case this.errors.ERR_EXIST_CLIENT : //HUOB07
                this.stepLayout.error = true;
                this.stepLayout.title = this.titles.existClient;
                this.stepLayout.showPath = false;
                break;
            case this.errors.ERR_NOCARD : //HUOB11A
                this.stepLayout.error = true;
                this.stepLayout.title = this.titles.ClientNoCard;
                this.stepLayout.showPath = false;
                break;
            case this.errors.ERR_SYSTEM : //HUOB11B
                this.stepLayout.error = true;
                this.stepLayout.title = this.titles.systemError;
                this.stepLayout.showPath = false;
                break;
        }
        //firing an child method
        this.template.querySelector("c-l-p_-credit-card-path").onStepSelected(this.step);
    }

    getStep5Title(event){
        console.log(event);
        this.title = event.detail;
        this.stepLayout.title = this.title;
    }

    getSteps7Title(event) {
        this.title = event.detail.title;
        this.stepLayout.title = this.title;
    }

    /**
    *  @Description: Clear the values ​​of the layout steps
    *  @Autor:       Abdon Tejos, Deloitte, atejos@deloitte.com
    *  @Date:        17/05/2021
    */
    cleanStepLayout(){
        this.stepLayout.step1 = false;
        this.stepLayout.step2 = false;
        this.stepLayout.step3 = false;
        this.stepLayout.step4 = false;
        this.stepLayout.step5 = false;
        this.stepLayout.step6 = false;
        this.stepLayout.step7 = false;
        this.stepLayout.error = false;
        this.stepLayout.title = lTitleSolicCard;
    }
    /**
    *  @Description: Go to next steps
    *  @Autor:       Eilhert Andrade, Deloitte
    *  @Date:        15/06/2021
    */
     renderedCallback(){
        if (this.isParam){
            this.template.querySelector("c-l-p_-credit-card-path").onStepSelected(this.step);
            this.param =false;
        }
    }
    /**
    *  @Description: Get parameters of Azurian
    *  @Autor:       Eilhert Andrade, Deloitte
    *  @Date:        15/06/2021
    */
     connectedCallback() {
        this.isParam =false;
        var showErrorParam = false;
        var favIconUrl;
        this.setBackgroundColor();
        getResourceURL({resourceName: 'LP_FaviconOnb'}).then(result =>
            {
                document.dispatchEvent(new CustomEvent("getFaviconUrl", {"detail": result}));
                console.log(result);
            }
        );
        
        if(this.currentPageReference.state.accessToken != undefined){
            this.cleanStepLayout();
            if (this.currentPageReference.state.accessToken != 'error'){

                getGUIDOnboardingByRUT({token: this.currentPageReference.state.accessToken})
                .then(result => {
                    this.objLead = result;
                     if ( this.objLead.LP_Rut__c != null ){
                        this.paramNextStep = this.currentPageReference.state.transactionReference; 
                        this.stepLayout.step4 = true;
                        this.stepLayout.title = this.titles.validatingIdentity;
                        this.isParam =true;
                        this.step = this.steps.step4;
                    }else{
                        showErrorParam = true;
                     }
                })
                .catch(error => {
                    this.error = error;
                    var message = JSON.parse(error.body.message);
                    console.log('error.message: ' + JSON.stringify(message));
                    console.log('message.cause: ' + message.cause);
                    this.showError();
                });
            }else{
                showErrorParam = true;
            }
            console.log('showErrorParam: ' + showErrorParam);
            if (showErrorParam){
                this.showError();
                this.step = this.steps.step4;
            }
        }
    }

    /**
    *  @Description: Show error
    *  @Autor:       Abdon Tejos, Deloitte
    *  @Date:        28/09/2021
    */
    showError() {
        this.paramchildError = this.errors.ERR_NOCARD;
        this.stepLayout.error = true;
        this.stepLayout.title = this.titles.ClientNoCard;
        this.stepLayout.showPath = false;
    }

    /**
    *  @Description: Read and formated parameters of Azurian
    *  @Autor:       Eilhert Andrade, Deloitte
    *  @Date:        15/06/2021
    */
         getQueryParameters() {
            var params = {};
            var search = location.search.substring(1);
            if (search) {
                params = JSON.parse('{"' + search.replace(/&/g, '","').replace(/=/g, '":"') + '"}', (key, value) => {
                    return key === "" ? value : decodeURIComponent(value)
                });
            }
            return params;
        }

    /**
    *  @Description: Sets the background color in the css
    *  @Autor:       Johan Ortiz, Deloitte
    *  @Date:        28/09/2021
    */
    setBackgroundColor() {
        document.documentElement.style.setProperty('--backgroundColor', backgroundColor);
    }
}