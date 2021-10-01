import { LightningElement, api, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
//Import Custom Label
import lLaPolarUrl from '@salesforce/label/c.LP_LaPolar';
import lMiCuentaLaPolarUrl from '@salesforce/label/c.LP_MiCuenta';
import lLaPolarErrorUrl from '@salesforce/label/c.LP_LaPolarTiendasAbiertas';
import lTarjetaLaPolarUrl from '@salesforce/label/c.LP_TarjetaLaPolar';
import lButton from '@salesforce/label/c.LP_ErrorOnbButton';
import lButtonIni from '@salesforce/label/c.LP_ErrorOnbButtonIni';
import lTexto11 from '@salesforce/label/c.LP_ErrorOnb_txt11';
import lTexto12 from '@salesforce/label/c.LP_ErrorOnb_txt12';
import lTextoPhono from '@salesforce/label/c.LP_ErrorOnb_nroPhone';
import lTexto21 from '@salesforce/label/c.LP_ErrorOnb_txt21';
import lTexto22 from '@salesforce/label/c.LP_ErrorOnb_txt22';
import lTextoTienda from '@salesforce/label/c.LP_LinkTiendaLaPolar';
import lTexto31 from '@salesforce/label/c.LP_ErrorOnb_txt31';
import step1 from '@salesforce/label/c.LP_OnboardingPaso1';
import ERR_EXIST_CLIENT from '@salesforce/label/c.LP_ERR_EXIST_CLIENT';
import ERR_NOCARD from '@salesforce/label/c.LP_ERR_NOCARD';
import ERR_SYSTEM from '@salesforce/label/c.LP_ERR_SYSTEM';

//Import Static Resource
import iTarjetaLP from '@salesforce/resourceUrl/LP_IconTarjetaLaPolar';

export default class LP_ErrorOnboarding extends NavigationMixin(LightningElement) {
    // param of parent
    @api getOriginError;
    @api objLead;
    @api showErrClientExist=false;
    @api showErrNoCard=false;
    @api showErrSystem=false;
    @api urlLaPolar = lLaPolarUrl;
    // 15000 milliseconds = 15 seconds. 
    @track progress = 15000;  
    steps = {step1}
    errors = {
        ERR_EXIST_CLIENT,
        ERR_NOCARD,
        ERR_SYSTEM    
    }
    // static resource to use in the template
    iconSM = {
        iTarjetaLP
    }
    // Expose the labels to use in the template.
    label = {
        lLaPolarUrl, lButton, lTexto11, lTexto12, lTextoPhono, lTexto21, lTexto22, lTextoTienda, lButtonIni, lTexto31, lLaPolarErrorUrl
    };

    /**
    *  @Description: Method take type error and show this, after timer go to new site
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        14/05/2021
    */
     connectedCallback() {
        this.showErrClientExist = (this.getOriginError == this.errors.ERR_EXIST_CLIENT) ? true : false;
        this.showErrNoCard = (this.getOriginError == this.errors.ERR_NOCARD) ? true : false;
        this.showErrSystem = (this.getOriginError == this.errors.ERR_SYSTEM) ? true : false;
        if (!this.showErrSystem){
            // after 15 seconds go site oficial for ERR_EXIST_CLIENT & ERR_NOCARD
            this._interval = setInterval(() => {  
                this.progress = this.progress + 5000;  
                this.navigateToTLPSite();
            }, this.progress);
        }
        if (this.showErrClientExist){
            // after 15 seconds go site oficial for ERR_EXIST_CLIENT & ERR_NOCARD
            this._interval = setInterval(() => {  
                this.progress = this.progress + 5000;  
                this.navigateToMyAccount();
            }, this.progress);
        }
    }
    /**
    *  @Description: Method response to parent
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        17/05/2021
    */
     returnInit(){
         console.log('volver al inicio');
        const pathEvent = new CustomEvent('setsteplayout', { detail: {step: this.steps.step1 }});
        this.dispatchEvent(pathEvent);  
    }
      /**
    *  @Description: Method open new page
    *  @Autor:       Leonardo Muñoz, Deloitte, lmunozg@deloitte.com
    *  @Date:        17/05/2021
    */
     navigateToLP() {
        window.location.assign(lLaPolarUrl);
    }

     /**
    *  @Description: Method navigate to LP open stores
    *  @Autor:       Jorge Baeza, Deloitte, jbaezac@deloitte.com
    *  @Date:        22/09/2021
    */
    navigateToLPStores(){
        window.location.assign(lLaPolarErrorUrl);
    }

      /**
    *  @Description: Method navigate to tarjeta LP site
    *  @Autor:       Jorge Baeza, Deloitte, jbaezac@deloitte.com
    *  @Date:        23/09/2021
    */
       navigateToTLPSite(){
        window.location.assign(lTarjetaLaPolarUrl);
    }

     /**
    *  @Description: Method navigate to Mi Cuenta LP site
    *  @Autor:       Brian Burgos, Deloitte
    *  @Date:        27/09/2021
    */
      navigateToMyAccount(){
        window.location.assign(lMiCuentaLaPolarUrl);
    }
}