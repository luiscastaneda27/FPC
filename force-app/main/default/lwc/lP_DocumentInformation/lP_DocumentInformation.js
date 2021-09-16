/*********************************************************************************
Project      : La Polar - Onboarding
Created By   : Deloitte
Created Date : 12/07/2021
Description  : Javascript - Document Information/Step 5
History      :
**************************ACRONYM OF AUTHORS************************************
AUTHOR                      ACRONYM
Abdon Tejos O.              ATO
********************************************************************************
VERSION  AUTHOR         DATE            Description
1.0       ATO	     12/07/2021		    initial version
********************************************************************************/
import { LightningElement, wire, track, api } from 'lwc';
//Import Static Resource
import iTLP from '@salesforce/resourceUrl/LP_TarjetaPolar';
import iTLPVisa from '@salesforce/resourceUrl/LP_TarjetaPolarVisa';
import iPreview from '@salesforce/resourceUrl/LP_IconoPrevDocumentos';
import iDownload from '@salesforce/resourceUrl/LP_IconoDescDocumentos';
//Import Custom Label
import lDocOne from '@salesforce/label/c.LP_AutorizacionEspecial';
import lDocTwo from '@salesforce/label/c.LP_ContratoAperturaCredito';
import lDocThree from '@salesforce/label/c.LP_Mandato';
import lDocFour from '@salesforce/label/c.LP_ResumenContratoApertura';
import lDocTwoVisa from '@salesforce/label/c.LP_ContratoAperturaLineaCredito';
import lAuthorization from '@salesforce/label/c.LP_TituloAutorizacionEspecial';
import lContract from '@salesforce/label/c.LP_TituloContratoApertura';
import lMandate from '@salesforce/label/c.LP_TituloMandato';
import lSummary from '@salesforce/label/c.LP_TituloResumenContrato';
import lStepFive from '@salesforce/label/c.LP_TituloPasoCinco';
import lSubAuthorization from '@salesforce/label/c.LP_SubtituloAutorizacionEspecial';
import lSubcontract from '@salesforce/label/c.LP_SubtituloContratoApertura';
import lSubMandate from '@salesforce/label/c.LP_SubtituloMandato';
import lSubSummary from '@salesforce/label/c.LP_SubtituloResumenContrato';
import lVisaAproved from '@salesforce/label/c.LP_VisaAprobada';
import lVisaAprovedWorld from '@salesforce/label/c.LP_VisaAprobadaMundo';
import lLaPolarAproved from '@salesforce/label/c.LP_LaPolarAprobada';
import lSignDocuments from '@salesforce/label/c.LP_FirmaDocumentos';
import lBtnCancel from '@salesforce/label/c.LP_BtnCancelar';
import lOpenTarget from '@salesforce/label/c.LP_AbrirTarjeta';
import lReadSignDocuments from '@salesforce/label/c.LP_LeerFimarDocumentos';
import lReadSignDocumentsSubTitle from '@salesforce/label/c.LP_LeerFirmarSubTitulo';
import step1 from '@salesforce/label/c.LP_OnboardingPaso1';

//Import Apex Methods
import getSetDocuments from '@salesforce/apex/LP_OnboardingStepFiveController.setDocuments';
import getDocs from '@salesforce/apex/LP_OnboardingStepFiveController.getDocuments';
import getNxtStep from '@salesforce/apex/LP_OnboardingStepFiveController.getNextStep';

import CLIENT_FORM_FACTOR from '@salesforce/client/formFactor';

export default class LP_DocumentInformation extends LightningElement {
    @api objLead;
    @api creditCardType;
    @api typeDoc;
    @api amount;
    steps = {step1}
    hideSpinner = true;
    showDocuments = CLIENT_FORM_FACTOR == 'Large' ? true : false;
    isPhone = CLIENT_FORM_FACTOR != 'Large' ? true : false;
    @track labels = {
        button : {
            lBtnCancel
        },
        text : {
            title : {
                authorization : lAuthorization,
                contract : lContract,
                mandate : lMandate,
                summary : lSummary,
                stepFive : lStepFive,
                lVisaAproved: "",
                lVisaAprovedWorld: "",
                lSignDocuments,
                lOpenTarget : "",
                lReadSignDocuments,
                lReadSignDocumentsSubTitle
            },
            subtitle : {
                authorization : lSubAuthorization,
                contract : lSubcontract,
                mandate : lSubMandate,
                summary : lSubSummary
            }
        },
        doc : {
            one : lDocOne,
            two : lDocTwo,
            three : lDocThree,
            four : lDocFour,
            twoVisa : lDocTwoVisa
        }
    }
    // static resource to use in the template
    icon = {
        iTLP,
        iTLPVisa,
        iPreview,
        iDownload
    }

    /**
    *  @Description: Generates the documents and get the codes of each one
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    connectedCallback() {
        getSetDocuments({ lead: this.objLead })
        .then(result => {
            this.hideSpinner = false;
            this.showDocuments = true;
            this.creditCardType = result.leadObj.LP_TipoTarjeta__c;
            this.typeDoc = result.codeDocuments;
            var amountAux = new Intl.NumberFormat('es-CL', {currency: 'CLP', style: 'currency'}).format(result.leadObj.LP_CupoDisponible__c);
            this.amount = amountAux;
            this.template.querySelector(".card_img").src = this.creditCardType == '02' ? this.icon.iTLPVisa : this.icon.iTLP;
            if(this.creditCardType == '01'){
                this.labels.text.title["lVisaAproved"] =  lVisaAproved.replace("VISA ", "");
                this.labels.text.title["lVisaAprovedWorld"] = lLaPolarAproved;
                this.labels.text.title["lOpenTarget"] = lOpenTarget.replace("VISA", "");
                this.labels.text.title["stepFive"] = lVisaAproved.replace("VISA ", "");
            }
            else{
                this.labels.text.title["lVisaAproved"] =  lVisaAproved;
                this.labels.text.title["lVisaAprovedWorld"] = lVisaAprovedWorld;
                this.labels.text.title["lOpenTarget"] = lOpenTarget;
            }
        }).catch(error => {
            this.hideSpinner = false;
            this.showDocuments = true;
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
    *  @Description: Get preview of document one
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    previewDocOne() {
        this.displaySpinner();
        var str;
        str = this.typeDoc[this.labels.doc.one];
        this.callGetDocs(str, false, null);
    }

    /**
    *  @Description: Get preview of document two
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
	previewDocTwo() {
        this.displaySpinner();
        var str;
        str = this.typeDoc[this.creditCardType == '02' ? this.labels.doc.twoVisa : this.labels.doc.two];
        this.callGetDocs(str, false, null);
    }

    /**
    *  @Description: Get preview of document three
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
	previewDocThree() {
        this.displaySpinner();
        var str;
        str = this.typeDoc[this.labels.doc.three];
        this.callGetDocs(str, false, null);
    }

    /**
    *  @Description: Get preview of document four
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
	previewDocFour() {
        this.displaySpinner();
        var str;
        str = this.typeDoc[this.labels.doc.four];
        this.callGetDocs(str, false, null);
    }

    /**
    *  @Description: Redirect to the URL of each document and download each document
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    callGetDocs(str, isDownload, element) {
        getDocs({ code: str })
        .then(result => {
            if (isDownload) {
                this.downloadDocument(result, element);
            } else {
                window.open(result);
            }
            this.hideSpinnerDocumentos();            
        }).catch(error => {
            this.hideSpinnerDocumentos(); 
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
    *  @Description: Get the document from the URL in blob format to download it
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    downloadDocument(url, element) {
        fetch(url).then((response) => {
            return response.blob();
        }).then(blob => {
            let link = element.class;
            link.setAttribute("href", URL.createObjectURL(blob));
            link.setAttribute("download", element.fileName);
            link.click();
        });
    }

    /**
    *  @Description: Download the document one
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
    downloadDocOne() {
        this.displaySpinner();
        var str;
        str = this.typeDoc[this.labels.doc.one];
        var element = { class : this.template.querySelector('.downloadDocOne'), fileName : this.labels.doc.one }
        this.callGetDocs(str, true, element);
    }

    /**
    *  @Description: Download the document two
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
	downloadDocTwo() {
        this.displaySpinner();
        var str;
        var name = this.creditCardType == '02' ? this.labels.doc.twoVisa : this.labels.doc.two;
        str = this.typeDoc[name];
        var element = { class : this.template.querySelector('.downloadDocTwo'), fileName : name }
        this.callGetDocs(str, true, element);
    }

    /**
    *  @Description: Download the document three
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
	downloadDocThree() {
        this.displaySpinner();
        var str;
        str = this.typeDoc[this.labels.doc.three];
        var element = { class : this.template.querySelector('.downloadDocThree'), fileName : this.labels.doc.three }
        this.callGetDocs(str, true, element);
    }

    /**
    *  @Description: Download the document four
    *  @Autor:       Abdon Tejos, Deloitte, atejoso@deloitte.com
    *  @Date:        12/07/2021
    */
	downloadDocFour() {
        this.displaySpinner();
        var str;
        str = this.typeDoc[this.labels.doc.four];
        var element = { class : this.template.querySelector('.downloadDocFour'), fileName : this.labels.doc.four }
        this.callGetDocs(str, true, element);
    }

    /**
    *  @Description: The button is activated if the client agrees to sign the contracts
    *  @Autor:       Abdon Tejos, Deloitte, atejos@deloitte.com
    *  @Date:        12/07/2021
    */
    onCheckbox(event) {
        var check = this.template.querySelector('.btnCheck').checked;
        if(check){
            this.template.querySelector(".btn2").disabled = false;
        }else{
            this.template.querySelector(".btn2").disabled = true;  
        }
    }
    
    /**
    *  @Description: Move on to the next step on the path
    *  @Autor:       Abdon Tejos, Deloitte, atejos@deloitte.com
    *  @Date:        12/07/2021
    */
    nextStep(event) {
        getNxtStep({ lead: this.objLead })
        .then(result => {
            const pathEvent = new CustomEvent('setsteplayout', {detail: {step: result, param: '', objLead: this.objLead}});
            this.dispatchEvent(pathEvent);
        }).catch(error => {
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
    *  @Description: Go back to the previous step of the path
    *  @Autor:       Abdon Tejos, Deloitte, atejos@deloitte.com
    *  @Date:        12/07/2021
    */
    prevStep(event) {
        const pathEvent = new CustomEvent('setsteplayout', {detail: {step: this.steps.step1, param: '', objLead: this.objLead}});
        this.dispatchEvent(pathEvent);
    }

    /**
    *  @Description: Method to display spinner
    *  @Autor:       Luis Castaneda, Deloitte
    *  @Date:        16/09/2021
    */
     displaySpinner() {
        this.hideSpinner = true;
        if(this.isPhone){
            this.showDocuments = false;
        }
    }

    /**
    *  @Description: Method to hide spinner and document section.
    *  @Autor:       Luis Castaneda, Deloitte
    *  @Date:        16/09/2021
    */
     hideSpinnerDocumentos() {
        this.hideSpinner = false;
        this.showDocuments = true;
    }


}