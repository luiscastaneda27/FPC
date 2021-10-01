import { LightningElement, track, wire, api } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import leadObject from '@salesforce/schema/Lead';
import paymentDateField from '@salesforce/schema/Lead.LP_FechaPago__c';
import occupationField from '@salesforce/schema/Lead.LP_Ocupacion__c';
import educationalLevelField from '@salesforce/schema/Lead.LP_NivelEducacional__c';
import lBtnNext from '@salesforce/label/c.LP_Continuar';
import lBtnPrev from '@salesforce/label/c.LP_Regresar';
import msgTextDataPerson from '@salesforce/label/c.LP_PersonalDataText';
import msgAceptStatusMail from '@salesforce/label/c.LP_AceptaEstadoPorCorreos';
import msgAceptStatusMailNO from '@salesforce/label/c.LP_AceptaEstadoPorCorreos_No';
import txtSelectedLevelEducation from '@salesforce/label/c.LP_SelectedLevelEducation';
import txtEnterAddress from '@salesforce/label/c.LP_EnterAddress';
import txtTitleComuna from '@salesforce/label/c.LP_TitleComuna';
import txtTitleProvinState from '@salesforce/label/c.LP_TitleProvinState';
import txtSelectDatePay from '@salesforce/label/c.LP_SelectDatePay';
import txtSelectOcupation from '@salesforce/label/c.LP_SelectOcupation';
import txtTitleStepFourMobile from '@salesforce/label/c.LP_TitleStepFourMobile';
import InfoAtLeast3letter from '@salesforce/label/c.LP_Escribe3Letras';
import getInitClass from '@salesforce/apex/LP_OnboardingStepOneController.initClass';
import getAddressAutoComplete from '@salesforce/apex/LP_OnboardingStepFourController.getAddressAutoComplete';
import getAddressDetails from '@salesforce/apex/LP_OnboardingStepFourController.getAddressDetails';
import updateLeadOrAccount from '@salesforce/apex/LP_OnboardingStepFourController.updateLeadOrAccount';
import updateOnboardingStep from '@salesforce/apex/LP_OnboardingStepFourController.updateOnboardingStep';
import step3 from '@salesforce/label/c.LP_OnboardingPaso3';
import ERR_NOCARD from '@salesforce/label/c.LP_ERR_NOCARD';
import lDeptoCasaFormat from '@salesforce/label/c.LP_FormatoDeptoCasa';

export default class LP_InformationPersonalData extends LightningElement {
    steps = {step3};
    errors = {
        ERR_NOCARD 
    }
    @track objLead = { 'sobjectType': 'Lead' };
    @api objLeadIn = { 'sobjectType': 'Lead' };
    @track fields;
    @track labels = {
        button : {
            prev : lBtnPrev,
            next : lBtnNext
        },
        mnsjOpt : {
            acept : msgAceptStatusMail,
            noAcept : msgAceptStatusMailNO
        },
        lDeptoCasaFormat
    }
    @track msg = {
        text : {
            enterAddress: txtEnterAddress,
            titleComuna: txtTitleComuna,
            titleProvinState: txtTitleProvinState,
            selectDatePay: txtSelectDatePay,
            selectOcupation: txtSelectOcupation,
            selectLevelEduc: txtSelectedLevelEducation,
            titleMobile: txtTitleStepFourMobile,
            InfoAtLeast3letter
        }
    }
    @track combox = {
        ocupation : {
            cssOpenClose : '',
            expanded : true
        },
        education : {
            cssOpenClose : '',
            expanded : true
        },
        paymentDate : {
            cssOpenClose : '',
            expanded : true
        },
        address : {
            cssOpenClose : '',
            expanded : true
        }
    }
    @api transRef;
    @api formDatPerson;
    @api formValidResponse = false;
    @api address = false;
    @api addressValidation = false;
    @api ciuB = false;
    @api addresses = [];
    @api paymentDate = false;
    @api paymentDateValidation = false;
    @api occupation = false;
    @api occupationValidation = false;
    @api educationalLevel = false;
    @api educationalLevelValidation = false;
    @api validateError = false;
    @api disabledSubmit = false;
    @api direccion='';
    @api menssageText='';
    @api LP_FechaPago__c_Label = '';
    @wire(getObjectInfo, { objectApiName: leadObject })
    objectInfo;
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: paymentDateField})
    paymentDatePicklistValues;
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: occupationField})
    occupationPicklistValues;
    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: educationalLevelField})
    educationalLevelPicklistValues;

    @wire(getInitClass)
    labels({data, error}) {

        this.formDatPerson = true;
        this.menssageText = msgTextDataPerson;
        this.disabledSubmit = true;
        
        this.combox.ocupation.cssOpenClose = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click';
        this.combox.ocupation.expanded = false;
        this.combox.education.cssOpenClose = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click';
        this.combox.education.expanded = false;
        this.combox.paymentDate.cssOpenClose = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click';
        this.combox.paymentDate.expanded = false;
        this.combox.address.cssOpenClose = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click';
        this.combox.address.expanded = false;
        
        if (data) {
            this.fields = JSON.parse(data.labels);
            this.siteKey = data.siteKey;
            this.blackList = JSON.parse(JSON.stringify(data.objMapBlackList));

            this.objLead.FirstName = this.objLeadIn.FirstName == undefined ? '' : this.objLeadIn.FirstName;
            this.objLead.LastName = this.objLeadIn.LastName == undefined ? '' : this.objLeadIn.LastName;
            this.objLead.LP_ApellidoMaterno__c = this.objLeadIn.LP_ApellidoMaterno__c == undefined ? '' : this.objLeadIn.LP_ApellidoMaterno__c;
            this.objLead.LP_Rut__c = this.objLeadIn.LP_Rut__c == undefined ? '' : this.objLeadIn.LP_Rut__c;
            this.objLead.LP_Nacionalidad__c = this.objLeadIn.LP_Nacionalidad__c == undefined ? '' : this.objLeadIn.LP_Nacionalidad__c;    
            this.objLead.LP_Genero__c = this.objLeadIn.LP_Genero__c == undefined ? '' : this.objLeadIn.LP_Genero__c;
            this.objLead.Email = this.objLeadIn.Email == undefined ? '' : this.objLeadIn.Email;
            this.objLead.MobilePhone = this.objLeadIn.MobilePhone == undefined ? '' : this.objLeadIn.MobilePhone.replace('+56' , '');
            this.objLead.LP_FechaPago__c = this.objLeadIn.LP_FechaPago__c == undefined ? '' : this.objLeadIn.LP_FechaPago__c;
            this.objLead.LP_Ocupacion__c = this.objLeadIn.LP_Ocupacion__c == undefined ? '' : this.objLeadIn.LP_Ocupacion__c;
            this.objLead.LP_NivelEducacional__c = this.objLeadIn.LP_NivelEducacional__c == undefined ? '' : this.objLeadIn.LP_NivelEducacional__c;
            /* address */
            this.objLead.Street  = this.objLeadIn.Street == undefined ? '' : this.objLeadIn.Street;
            this.objLead.City = this.objLeadIn.City == undefined ? '' : this.objLeadIn.City;
            this.objLead.State = this.objLeadIn.State == undefined ? '' : this.objLeadIn.State;
            this.objLead.Country = this.objLeadIn.Country == undefined ? '' : this.objLeadIn.Country;
            this.objLead.LP_Ciudad__c = this.objLeadIn.LP_Ciudad__c == undefined ? '' : this.objLeadIn.LP_Ciudad__c;
            this.objLead.LP_NumDeptoCasa__c = this.objLeadIn.LP_NumDeptoCasa__c == undefined ? '' : this.objLeadIn.LP_NumDeptoCasa__c;
            this.LP_FechaPago__c_Label = '';
        }
        else if (error) {
            window.console.log('error => '+JSON.stringify(error));
        }
    }
        
    /**
    *  @Description: Method that validate Address
    *  @Autor:       Alan Sanhueza, Deloitte, asanhuezac@deloitte.com
    *  @Date:        01/06/2021
    */
     validateAddress(event){
        this.objLead.Street = event.target.value.trim();
        this.addressValidation = (this.objLead.Street == '') ? true : false;
        this.enableButton(event);
    }

    /**
    *  @Description: Method that validate City
    *  @Autor:       Fran, Deloitte
    *  @Date:        20/07/2021
    */
     validateCity(event){
        this.objLead.LP_Ciudad__c = event.target.value.trim();
        this.ciuB = (this.objLead.LP_Ciudad__c == '') ? true : false;
        this.enableButton(event);
    }
    

    /**
    *  @Description: Method that validate City
    *  @Autor:       Fran, Deloitte
    *  @Date:        20/07/2021
    */
     validateNumDepto(event){
        this.objLead.LP_NumDeptoCasa__c = event.target.value.trim();
        this.enableButton(event);
    }

    /**
    *  @Description: Method that validate Payment Date
    *  @Autor:       Alan Sanhueza, Deloitte, asanhuezac@deloitte.com
    *  @Date:        01/06/2021
    */
     validatePaymentDate(event){
        this.LP_FechaPago__c_Label = (event.currentTarget.dataset.label != undefined) ? event.currentTarget.dataset.label.trim() : this.LP_FechaPago__c_label;
        this.objLead.LP_FechaPago__c = (event.currentTarget.dataset.value != undefined) ? event.currentTarget.dataset.value.trim() : this.objLead.LP_FechaPago__c;
        this.paymentDateValidation = (this.objLead.LP_FechaPago__c == '') ? true : false;   
        this.enableButton(event);
    }
    /**
    *  @Description: Method that validate Occupation
    *  @Autor:       Alan Sanhueza, Deloitte, asanhuezac@deloitte.com
    *  @Date:        01/06/2021
    */
     validateOccupation(event){
        this.objLead.LP_Ocupacion__c = (event.currentTarget.dataset.value != undefined) ? event.currentTarget.dataset.value.trim() : this.objLead.LP_Ocupacion__c;
        this.occupationValidation = (this.objLead.LP_Ocupacion__c == '') ? true : false; 
        this.enableButton(event);
    }
    /**
    *  @Description: Method that validate Educational Level
    *  @Autor:       Alan Sanhueza, Deloitte, asanhuezac@deloitte.com
    *  @Date:        01/06/2021
    */
     validateEducationalLevel(event){
        this.objLead.LP_NivelEducacional__c = (event.currentTarget.dataset.value != undefined) ? event.currentTarget.dataset.value.trim() : this.objLead.LP_NivelEducacional__c;
        this.educationalLevelValidation = (this.objLead.LP_NivelEducacional__c == '') ? true : false; 
        this.enableButton(event);
    }
    /**
    *  @Description: Method that show error for empty input 
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        01/06/2021
    */
     enableButton(event){

        if (this.objLead.Street != '' && this.objLead.Street != null &&
            this.LP_FechaPago__c_Label != '' &&
            this.objLead.LP_Ocupacion__c != '' &&
            this.objLead.LP_NivelEducacional__c != '' &&
            this.objLead.LP_Ciudad__c != '' && 
            this.objLead.LP_NumDeptoCasa__c != ''){

            this.disabledSubmit = false;
        }else {
            this.disabledSubmit = true;
        }
        this.listOcupationClose(event);
        this.listEducationClose(event);
        this.listPaymentDateClose(event);
    }
    /**
    *  @Description: Method that sends form data
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        01/06/2021
    */
    submitData(event) {
        
        this.objLead.LP_EstadoCuentaMail__c = this.template.querySelector('.checkbox').checked; 
      
        updateLeadOrAccount({getRecord: this.objLead})
        .then(result => {
            //console.log('ingresamos ok al video');
            this.LP_Ruta = result.LP_Ruta;
            this.formDatPerson = false;
            this.formValidResponse = true;
        })
        .catch(error => {
            console.log('error en la consulta de updateLeadOrAccount');
            this.error = error;
            var message = JSON.parse(error.body.message)
            console.log('error.message: ' + JSON.stringify(message));
            console.log('message.cause: ' + message.cause);
            this.formDatPerson = true;
            this.formValidResponse = false;
        });
    }
    /**
    *  @Description: Method that search address API Google Maps Details
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        01/06/2021
    */
     selectAddress(event){
        this.objLead.City = '';
        this.objLead.State = '';
        this.objLead.Country = '';

        getAddressDetails({placeId: event.currentTarget.dataset.placeid})
        .then(result => {
            var options = JSON.parse(result);
            var Addressdet = options.result;
            var key = "address_components";
            var o = Addressdet[key];
            for(var prop in o) {
                // provincia
                if (o[prop].types[0] == 'administrative_area_level_1'){
                    this.objLead.State = o[prop].long_name;
                }
                // comuna
                if (o[prop].types[0] == 'administrative_area_level_3'){
                    this.objLead.City = o[prop].long_name;
                }
                if (o[prop].types[0] == 'country'){
                    this.objLead.Country = o[prop].long_name;
                }
            }
            
            this.objLead.Street = Addressdet["name"];
            this.listAddressClose(event);
        })
        .catch(error => {
            this.error = error;
            var message = JSON.parse(error.body.message)
            //console.log('error.message: ' + JSON.stringify(message));
            //console.log('message.cause: ' + message.cause);
        });
        
    }
    /**
    *  @Description: Method that search address API Google Maps Autocomplete
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        01/06/2021
    */
     autoCompleteAddress(event){

        getAddressAutoComplete({input: event.target.value})
        .then(result => {
            var options = JSON.parse(result); 
            var predictions = options.predictions;
            this.addresses = [];
            if (predictions.length > 0) {
                for (var i = 0; i < predictions.length; i++) {
                    this.addresses.push({
                        placeId: predictions[i].place_id,
                        label: predictions[i].description ,
                    });
                }
                this.listAddressOpen(event);
            }
        })
        .catch(error => {
            this.error = error;
            var message = JSON.parse(error.body.message)
            //console.log('error.message: ' + JSON.stringify(message));
            //console.log('message.cause: ' + message.cause);
        });
        this.objLead.Street = event.target.value;
    }

    /**
    *  @Description: update class combobox Ocupation
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        09/06/2021
    */
    listOcupationOpen(event){
        this.combox.ocupation.cssOpenClose = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-is-open';
        this.combox.ocupation.expanded = true;
    }
    listOcupationClose(event){
        this.combox.ocupation.cssOpenClose = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click';
        this.combox.ocupation.expanded = false;
    }
    /**
    *  @Description: update class combobox Level Education
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        09/06/2021
    */
    listEducationOpen(event){
        this.combox.education.cssOpenClose = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-is-open';
        this.combox.education.expanded = true;
    }
    listEducationClose(event){
        this.combox.education.cssOpenClose = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click';
        this.combox.education.expanded = false;
    }
    /**
    *  @Description: update class combobox Level Education
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        09/06/2021
    */
    listPaymentDateOpen(event){
        this.combox.paymentDate.cssOpenClose = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-is-open';
        this.combox.paymentDate.expanded = true;
    }
    listPaymentDateClose(event){
        this.combox.paymentDate.cssOpenClose = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click';
        this.combox.paymentDate.expanded = false;
    }
    /**
    *  @Description: update class combobox Level Education
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        09/06/2021
    */
    listAddressOpen(event){
        this.combox.address.cssOpenClose = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-is-open';
        this.combox.address.expanded = true;
    }
    listAddressClose(event){
        this.combox.address.cssOpenClose = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click';
        this.combox.address.expanded = false;
    }
    /**
    *  @Description: Go back to the previous step of the path
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        08/06/2021
    */
    prevStep(event) {
        const pathEvent = new CustomEvent('setsteplayout', {detail: {step: this.steps.step3, param: '', objLead: this.objLead}});
        this.dispatchEvent(pathEvent);
    }
    /**
    *  @Description: Go next step of the path
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        08/06/2021
    */
     nextStep(event){
        
        if (event.detail == 'ok'){
            updateOnboardingStep({record: this.objLead})
            .then(result => {
                //console.log('se actualiza Onboarding al paso 5');
                this.LP_Ruta = result.LP_Ruta;
                const pathEvent = new CustomEvent('setsteplayout', {detail: {step: this.LP_Ruta, param:'', objLead: this.objLead}});
                this.dispatchEvent(pathEvent);
            })
            .catch(error => {
                console.error('error en la actualización updateOnboardingStep');
                this.error = error;
                var message = JSON.parse(error.body.message)
                console.error('error.message: ' + JSON.stringify(message));
                console.error('message.cause: ' + message.cause);
                const pathEvent = new CustomEvent('setsteplayout', {detail: {step: this.errors.ERR_NOCARD, param:'', objLead: this.objLead}});
                this.dispatchEvent(pathEvent);
            });

        }else{
            const pathEvent = new CustomEvent('setsteplayout', {detail: {step: this.errors.ERR_NOCARD, param:'', objLead: this.objLead}});
            this.dispatchEvent(pathEvent);
        }
    }
}