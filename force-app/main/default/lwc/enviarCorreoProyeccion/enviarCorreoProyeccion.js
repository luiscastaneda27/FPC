import { LightningElement,api,track,wire } from 'lwc';
import correo from '@salesforce/schema/Proyeccion__c.Correo__c';
import { getRecord } from 'lightning/uiRecordApi';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import envioCorreo from "@salesforce/apex/ControladorGraficoProyecciones.envioCorreo";
import { CloseActionScreenEvent } from 'lightning/actions';

export default class EnviarCorreoProyeccion extends LightningElement {
    @api recordId;
    showSpinner = true;
    @track allData = {
        disabledBoton: true,
        proyeccion: null,
        correo: null
    };

    @wire(getRecord, { recordId: '$recordId', fields: [correo] })
    wiredAccount({data, error}) {
        if (data) {
            this.allData.correo = data.fields.Correo__c.value;
            this.showSpinner = false;
        }
    }


    handleChange(event){
        const field = event.target.name;
        const valor = event.target.value;
        if(field == 'correo'){
            this.allData.correo = valor.trim() != '' ? valor.trim() : null;
        }else if(field == 'proyeccion'){
            this.allData.proyeccion = valor.trim() != '' ? valor : null;
        }
        this.validaBoton();
    }
    validaBoton(){
        this.allData.disabledBoton = true;;
        if(this.allData.proyeccion != null && this.allData.correo != null){
            this.allData.disabledBoton = false;
        }
    }
    enviarCorreo(){
        this.showSpinner = true;
        envioCorreo({
            recordId: this.recordId,
            correo: this.allData.correo,
            tipoProyeccion: this.allData.proyeccion
        }).then(response => {
            if(response != 'Exitoso'){
                this.pushMessage('Advertencia', 'warning', response);
            }else{
                this.pushMessage('Exitoso', 'success', 'Coreo enviado exitosamente.');
            }
            this.showSpinner = false;
            this.closeQuickAction();
        }).catch(error => {
            this.showSpinner = false;
            this.pushMessage('Error', 'error', 'Ha ocurrido un error, por favor contacte a su admin.');
        });

    }
    closeQuickAction() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }
    pushMessage(title,variant,msj){
        const message = new ShowToastEvent({
            "title": title,
            "variant": variant,
            "message": msj
            });
            this.dispatchEvent(message);
    }

    get options() {
        return [
            { label: 'Consolidado', value: 'Consolidado' },
            { label: 'Detallado', value: 'Detallado' },
            { label: 'Ambas', value: 'Ambas' },
        ];
    }

}