import { LightningElement,api,track } from 'lwc';
import getdatos from "@salesforce/apex/ControladorGraficoProyecciones.calculoGrafico";

export default class GraficoProyecciones extends LightningElement {
    @api recordId;
    showSpinner;
    @track allData = {};


    connectedCallback() {
        this.init();
    }
    init() {
        this.showSpinner = true;
        getdatos({
            recordId: this.recordId
        }).then(response => {
            this.allData = response;
            console.log(this.allData.anios);
            this.showSpinner = false;
        }).catch(error => {
            this.showSpinner = false;
        });
    }
}