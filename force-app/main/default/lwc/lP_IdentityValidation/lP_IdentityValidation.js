/*********************************************************************************
Project      : LA POLAR Salesforce - Onboarding
Created By   : Deloitte
Created Date : 09/06/2021
Description  : Javascript - Identity Validation
History      : PCRM-15
--------------------------ACRONYM OF AUTHORS-------------------------------------
AUTHOR                      ACRONYM
Eilhert Andrade Alviárez       EAA
---------------------------------------------------------------------------------
VERSION  AUTHOR         DATE            Description
1.0       EAA		  09/06/2021		initial version
********************************************************************************/
import { LightningElement, track, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
//Import Custom Label
import lStepTitle from '@salesforce/label/c.LP_ValidacionIdentidad';
import lTexto1 from '@salesforce/label/c.LP_IdentityValidation_Txt1';
import lTexto2 from '@salesforce/label/c.LP_IdentityValidation_Txt2';
import lButtonIni from '@salesforce/label/c.LP_Regresar';
import lButtonCompIdent from '@salesforce/label/c.LP_ComprobarIdentidad';
import customerAzurianInit from '@salesforce/apex/LP_OnboardingStepThreeController.customerAzurianInit';
import step1 from '@salesforce/label/c.LP_OnboardingPaso1';

//Import Static Resource
import iTarjetaLP from '@salesforce/resourceUrl/LP_IconTarjetaLaPolar';

export default class LP_IdentityValidation extends NavigationMixin(LightningElement) {
    @api objLead = { 'sobjectType': 'Lead' };
    @api redirectUrl = '';
    @api disabledSubmit = false;
    @api sfdcBaseURL;
    @api renderFlag = false;
    steps = {step1}
    // static resource to use in the template
    iconSM = {
        iTarjetaLP
    }    
    // Expose the labels to use in the template.
    label = {
        text:{
            lStepTitle,
            lTexto1, 
            lTexto2
        },
        button:{
            lButtonIni, 
            lButtonCompIdent
        }
    };

    renderedCallback(event){
        if(!this.renderFlag){
            this.renderFlag = true;
            this.disabledSubmit = true;
            this.sfdcBaseURL = window.location.origin;
            customerAzurianInit({record: this.objLead, url: this.sfdcBaseURL })
            .then(result => {
            this.transRef = result[0];
            this.redirectUrl = result[1]; 
            this.disabledSubmit = false;
            })
            .catch(error => { 
            // console.log("Error: "+ JSON.stringify(error.body.message));
            // this.error = error;
            // var message = JSON.parse(error.body.message);
            // console.log('error.message: ' + JSON.stringify(message));
            // console.log('message.cause: ' + message.cause);
            // const pathEvent = new CustomEvent('setsteplayout', {detail: 
            //                                                     {step: message.cause,
            //                                                     param: '',
            //                                                     objLead: this.objLead}});
            // this.dispatchEvent(pathEvent);
            });
        }

    }
    returnInit(){
        const pathEvent = new CustomEvent('setsteplayout', { detail: {step: this.steps.step1 }});
        this.dispatchEvent(pathEvent);  
   }
   IdentityValidation(){
        this.disabledSubmit = true;
        window.open(this.redirectUrl,'_parent');
    }
}