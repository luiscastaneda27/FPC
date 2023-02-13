import { LightningElement,api,track } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

import getBeneficiarios from "@salesforce/apex/ControladorBeneficiarios.getBeneficiarios";
import insertarBeneficiarios from "@salesforce/apex/ControladorBeneficiarios.insertarBeneficiarios";
import Tipo_Gestion__c from '@salesforce/schema/Task.Tipo_Gestion__c';



const columns = [
    //{ label: 'Cuenta', fieldName: 'cuenta', type: 'text' },
    //{ label: 'Beneficiario', fieldName: 'tipoBeneficiario', type: 'text' },
    { label: 'Identificacón', fieldName: 'identificacion', type: 'text' },
    { label: 'Primer Nombre', fieldName: 'primerNombre', type: 'text' },
    { label: 'Primer Apellido', fieldName: 'primerApellido', type: 'text' },
    //{ label: 'Porcentaje', fieldName: 'porcentaje', type: 'text' },
    { label: 'Porcentaje', fieldName: 'porcentaje', type: 'text' },
    { label: 'Sexo', fieldName: 'sexo', type: 'text' },
    { label: 'Fecha de Nacimiento', fieldName: 'fechaNacimiento', type: 'date' },
    { label: 'Parentesco', fieldName: 'parentescoLabel', type: 'text' }
];
const columnsBeneficiarios = [
   // { label: 'Cuenta', fieldName: 'cuenta', type: 'text' },
   // { label: 'Beneficiario', fieldName: 'tipoBeneficiario', type: 'text' },
    { label: 'Primer Nombre', fieldName: 'primerNombre', type: 'text' },
    { label: 'Segundo Nombre', fieldName: 'segundoNombre', type: 'text' },
    { label: 'Primer Apellido', fieldName: 'primerApellido', type: 'text' },
    { label: 'Segundo Apellido', fieldName: 'segundoApellido', type: 'text' },
    { label: 'Porcentaje', fieldName: 'porcentaje', type: 'text' },
    { label: 'Fecha de Nacimiento', fieldName: 'fechaNacimiento', type: 'date' },
    { label: 'Sexo', fieldName: 'sexo', type: 'text' },
    { label: 'Tipo Identificacón', fieldName: 'tipoIdentificacionLabel', type: 'text' },
    { label: 'Identificacón', fieldName: 'identificacion', type: 'text' },
    { label: 'Parentesco', fieldName: 'parentescoLabel', type: 'text' },
    { label: 'Grado', fieldName: 'grado', type: 'text' }
];
const steps = [
    {
      classList: "slds-path__item slds-is-current slds-is-active",
      label: "Actualizar",
      order: 0,
      selected: false,
      status: "current",
      tabIndex: 0,
      value: "paso-1"
    },
    {
      classList: "slds-path__item slds-is-incomplete",
      label: "Confirmar",
      order: 1,
      selected: false,
      status: "incomplete",
      tabIndex: -1,
      value: "paso-2"
    }
  ]

export default class Beneficiarios extends LightningElement {
    @api recordId;
    @track data = {};
    showSpinner = true;
    inputDisabled = false;
    columns = columns; 
    popUpdate = false;
    mostrarBoton = true;
    @track steps = steps;

    connectedCallback() {
        this.init();
    }
    init() {
        this.showSpinner = true;
        getBeneficiarios({
            recordId: this.recordId,
            esCaso: true
        }).then(response => {
           this.data = response;
           this.data.esBeneficiarioDirecto = false;
           if(response.listCuentas.length > 0){
                this.mapPrimeraCuenta();
            }
           if(response.estado != 'Nuevo' && response.estado != 'Devuelto' ){
               this.columns = columnsBeneficiarios;
               this.mostrarBoton = false;
           }
            this.showSpinner = false;
        }).catch(e => {
            this.showSpinner = false;
            this.pushMessage('Error', 'error', 'Ha ocurrido un error, por favor contacte a su admin.');
        });
    }

    changeCuentaMap(){
        var benefWrap = this.data.mapBeneficiarios[this.data.cuentaSelecionada];
        this.data.listBeneficiariosDirec = benefWrap.listBeneficiariosDirec;
        this.data.listBeneficiariosCont = benefWrap.listBeneficiariosCont;
        this.data.tituloDirec = 'Beneficiarios Directos (' + this.data.listBeneficiariosDirec.length + ')';
        this.data.tituloCont = 'Beneficiarios de Contingencia (' + this.data.listBeneficiariosCont.length + ')';
    }

    onclickActualizar(){
        this.popUpdate = true;
        this.inputDisabled = false;
        this.primerPasoRuta();
        this.data.esBeneficiarioDirecto = true;
        this.data.tituloPop = 'Actualización de Beneficiarios Directos - ' + this.data.cuentaSelecionadaLabel;
        this.data.listBeneficiarios = this.data.listBeneficiariosDirec;
        this.data.titulo = 'Beneficiarios Directos ('+this.data.listBeneficiarios.length+')';
    }
    onclickActualizarCont(){
        this.popUpdate = true;
        this.inputDisabled = false;
        this.primerPasoRuta();
        this.data.esBeneficiarioDirecto = false;
        this.data.tituloPop = 'Actualización de Beneficiarios de Contingencia - ' + this.data.cuentaSelecionadaLabel;
        this.data.listBeneficiarios = this.data.listBeneficiariosCont;
        this.data.titulo = 'Beneficiarios de Contingencia ('+this.data.listBeneficiarios.length+')';
    }
    handleChangeCuenta(event){
        this.data.cuentaSelecionada = event.target.value;
        for(let i=0; i<this.data.listCuentas.length; i++){
            if(this.data.listCuentas[i].value == this.data.cuentaSelecionada){
                this.data.cuentaSelecionadaLabel =  this.data.listCuentas[i].label;
            }
        }
        this.changeCuentaMap();

    }
    handleChangePrimerN(event){
        const rowId = event.target.name;
        const valor = event.target.value;
        let posicion = this.buscarBeneficiario(rowId);
        this.data.listBeneficiarios[posicion].primerNombre = valor.trim() != '' ? valor.trim() : null;
    }
    handleChangeSegundoN(event){
        const rowId = event.target.name;
        const valor = event.target.value;
        let posicion = this.buscarBeneficiario(rowId);
        this.data.listBeneficiarios[posicion].segundoNombre = valor.trim() != '' ? valor.trim() : null;
    }
    handleChangePrimerA(event){
        const rowId = event.target.name;
        const valor = event.target.value;
        let posicion = this.buscarBeneficiario(rowId);
        this.data.listBeneficiarios[posicion].primerApellido = valor.trim() != '' ? valor.trim() : null;
    }
    handleChangeSegundoA(event){
        const rowId = event.target.name;
        const valor = event.target.value;
        let posicion = this.buscarBeneficiario(rowId);
        this.data.listBeneficiarios[posicion].segundoApellido = valor.trim() != '' ? valor.trim() : null;
    }
    handleChangePorcentaje(event){
        const rowId = event.target.name;
        const valor = event.target.value;
        let posicion = this.buscarBeneficiario(rowId);
        this.data.listBeneficiarios[posicion].porcentaje = valor.trim() != '' ? valor : 0;
    }
    handleChangeFechaNacimiento(event){
        const rowId = event.target.name;
        const valor = event.target.value;
        let posicion = this.buscarBeneficiario(rowId);
        this.data.listBeneficiarios[posicion].fechaNacimiento = valor;
    }
    handleChangeSexo(event){
        const rowId = event.target.name;
        const valor = event.target.value;
        let posicion = this.buscarBeneficiario(rowId);
        this.data.listBeneficiarios[posicion].sexo = valor;
    }

    handleChangeTipoIdentidad(event){
        const rowId = event.target.name;
        const valor = event.target.value;
        let posicion = this.buscarBeneficiario(rowId);
        this.data.listBeneficiarios[posicion].tipoIdentificacion = valor;
    }
    handleChangeIdentidad(event){
        const rowId = event.target.name;
        const valor = event.target.value;
        let posicion = this.buscarBeneficiario(rowId);
        this.data.listBeneficiarios[posicion].identificacion = valor.trim() != '' ? valor.trim() : null;
    }
    handleChangeParentesco(event){
        const rowId = event.target.name;
        const valor = event.target.value;
        let posicion = this.buscarBeneficiario(rowId);
        this.data.listBeneficiarios[posicion].parentesco = valor;
        if(valor == "1" || valor == "2"|| valor == "5"){
            this.data.listBeneficiarios[posicion].grado = "Primero";
        }else if(valor == "6" || valor == "7"|| valor == "14"){
            this.data.listBeneficiarios[posicion].grado = "Segundo";
        }else if(valor == "8" || valor == "9"|| valor == "11"){
            this.data.listBeneficiarios[posicion].grado = "Tercero";
        }else{
            this.data.listBeneficiarios[posicion].grado = "Cuarto";
        }
    }
    onclickNuevoBenef(){
        var beneficiario = {};
        beneficiario.cuenta = this.data.cuentaSelecionadaLabel;
        beneficiario.tipoBeneficiario =  this.data.esBeneficiarioDirecto ? 'Directo' : 'Contingencia';
        beneficiario.cuentaId = this.data.cuentaSelecionada;
        let index = 0;
        if(this.data.listBeneficiarios.length > 0){
            index = this.data.listBeneficiarios[this.data.listBeneficiarios.length - 1].index + 1;
        }
        beneficiario.index = index;
        this.data.listBeneficiarios.push(beneficiario);
        if( this.data.esBeneficiarioDirecto){
            this.data.titulo = 'Beneficiarios Directos ('+this.data.listBeneficiarios.length+')';
        }else{
            this.data.titulo = 'Beneficiarios de Contingencia ('+this.data.listBeneficiarios.length+')';
        }
        //this.data.titulo = 'Beneficiarios ('+this.data.listBeneficiarios.length+')';
    }
    onclickSiguiente(){
        //Validación campos en blacos
        for(let i=0; i<this.data.listBeneficiarios.length; i++){
            if(this.data.listBeneficiarios[i].cuentaId == null || this.data.listBeneficiarios[i].tipoBeneficiario == null ||
                this.data.listBeneficiarios[i].primerNombre == null || this.data.listBeneficiarios[i].primerApellido == null ||
                this.data.listBeneficiarios[i].tipoIdentificacion == null || this.data.listBeneficiarios[i].identificacion == null ||
                this.data.listBeneficiarios[i].sexo == null || this.data.listBeneficiarios[i].fechaNacimiento == null ||
                this.data.listBeneficiarios[i].parentesco == null || this.data.listBeneficiarios[i].porcentaje == null ){
                    this.pushMessage('Error', 'error', 'Campos obligatorios pendientes');
                    return;
            }
        }
        for(let j=0; j<this.data.listPorcentajes.length; j++){
            this.data.listPorcentajes[j].porcentajeDireto = 0;
            this.data.listPorcentajes[j].porcentajeContingencia = 0;
        }
        //Validación porcentajes
        for(let i=0; i<this.data.listBeneficiarios.length; i++){
            for(let j=0; j<this.data.listPorcentajes.length; j++){
                if(this.data.listBeneficiarios[i].cuenta == this.data.listPorcentajes[j].cuenta){
                    if(this.data.esBeneficiarioDirecto){
                        this.data.listPorcentajes[j].porcentajeDireto += parseFloat(this.data.listBeneficiarios[i].porcentaje);
                    }else{
                        this.data.listPorcentajes[j].porcentajeContingencia += parseFloat(this.data.listBeneficiarios[i].porcentaje);
                    }
                }
            }
        }
        for(let j=0; j<this.data.listPorcentajes.length; j++){
            if(this.data.listPorcentajes[j].cuenta == this.data.cuentaSelecionadaLabel && this.data.listPorcentajes[j].porcentajeDireto != 100 && this.data.esBeneficiarioDirecto){
                this.pushMessage('Advertencia', 'warning', 'En la cuenta '+this.data.listPorcentajes[j].cuenta+' el porcentaje de los beneficiarios directos esta en '+this.data.listPorcentajes[j].porcentajeDireto+'%');
                return;
            }else if(this.data.listPorcentajes[j].cuenta == this.data.cuentaSelecionadaLabel && this.data.listPorcentajes[j].porcentajeContingencia != 100 && !this.data.esBeneficiarioDirecto && this.data.listBeneficiarios.length > 0){
                this.pushMessage('Advertencia', 'warning', 'En la cuenta '+this.data.listPorcentajes[j].cuenta+' el porcentaje de los beneficiarios de contingencia esta en '+this.data.listPorcentajes[j].porcentajeContingencia+'%');
                return;
            }
        }
        //this.ordenarBeneficiarios();
        this.steps[1].classList = this.steps[0].classList;
        this.steps[1].status = this.steps[0].status;
        this.steps[0].classList = "slds-path__item slds-is-complete";
        this.steps[0].status = "complete";
        this.inputDisabled = true;
    }

    ordenarBeneficiarios(){
        var listBeneficiarios = [];
        for(let j=0; j<this.data.listPorcentajes.length; j++){
            for(let i=0; i<this.data.listBeneficiarios.length; i++){
                if(this.data.listBeneficiarios[i].cuenta == this.data.listPorcentajes[j].cuenta && this.data.listBeneficiarios[i].tipoBeneficiario == 'Directo'){
                    listBeneficiarios.push(this.data.listBeneficiarios[i]);
                }
            }
            for(let i=0; i<this.data.listBeneficiarios.length; i++){
                if(this.data.listBeneficiarios[i].cuenta == this.data.listPorcentajes[j].cuenta && this.data.listBeneficiarios[i].tipoBeneficiario == 'Contingencia'){
                    listBeneficiarios.push(this.data.listBeneficiarios[i]);
                }
            }
        }
        this.data.listBeneficiarios = listBeneficiarios;
        this.steps[1].classList = this.steps[0].classList;
        this.steps[1].status = this.steps[0].status;
        this.steps[0].classList = "slds-path__item slds-is-complete";
        this.steps[0].status = "complete";
    }

    buscarBeneficiario(rowId){
        for(let i=0; i<this.data.listBeneficiarios.length; i++){
            if(this.data.listBeneficiarios[i].index == rowId){
                return i;
            }
        }
    }

    cancelar(){
        this.popUpdate = false;
    }
    atras(){
        this.inputDisabled = false;
        this.primerPasoRuta();
    }
    primerPasoRuta(){
        this.steps[0].classList = "slds-path__item slds-is-current slds-is-active";
        this.steps[0].status = "current"
        this.steps[1].classList = "slds-path__item slds-is-incomplete";
        this.steps[1].status = "incomplete";
    }
    eliminar(event){
        const rowId = event.target.name;
        var listBeneficiarios = [];
        for(let j=0; j<this.data.listBeneficiarios.length; j++){
            if(this.data.listBeneficiarios[j].index != rowId){
                listBeneficiarios.push(this.data.listBeneficiarios[j]);
            }
        }
        this.data.listBeneficiarios = listBeneficiarios;
        if(this.data.esBeneficiarioDirecto){
            this.data.titulo = 'Beneficiarios Directos ('+this.data.listBeneficiarios.length+')';
        }else{
            this.data.titulo = 'Beneficiarios de Contingencia ('+this.data.listBeneficiarios.length+')';
        }
    }
    confirmar(){
        if(this.data.esBeneficiarioDirecto){
            this.data.listBeneficiariosDirec = this.data.listBeneficiarios;
            if(this.data.listBeneficiariosCont.length > 0){
                this.data.listBeneficiarios = this.data.listBeneficiariosCont;
                this.data.esBeneficiarioDirecto = false;
                if(this.validationBeneficiario()){
                    this.pushMessage('Advertencia', 'warning', 'Debe Completar la información de los beneficiarios Directos');
                    this.onclickActualizarCont();
                    return;
                }
            }
        }else{
            this.data.listBeneficiariosCont = this.data.listBeneficiarios;
            let msj = 'Debe Completar la información de los beneficiarios Directos';
            if(this.data.listBeneficiariosDirec.length == 0){
                this.pushMessage('Advertencia', 'warning', msj);
                this.onclickActualizar();
                return;
            }else{
                this.data.listBeneficiarios = this.data.listBeneficiariosDirec;
                this.data.esBeneficiarioDirecto = true;
                if(this.validationBeneficiario()){
                    this.pushMessage('Advertencia', 'warning', msj);
                    this.onclickActualizar();
                    return;
                }
            }
        }
        for(let i=0; i<this.data.listBeneficiariosCont.length; i++){
            this.data.listBeneficiariosCont[i].modificado = true;   
        }
        for(let i=0; i<this.data.listBeneficiariosDirec.length; i++){
            this.data.listBeneficiariosDirec[i].modificado = true;   
        }
        this.showSpinner = true;
        this.popUpdate = false;
        insertarBeneficiarios({
            recordId: this.recordId,
            dataBeneficiarios: JSON.stringify(this.data)
        }).then(response => {
           this.data = response;
           this.mapPrimeraCuenta();
           this.showSpinner = false;
           this.popUpdate = false;
           this.pushMessage('Exitoso', 'success', 'Datos guardados exitosamente.');
           setTimeout(() => {
            eval("$A.get('e.force:refreshView').fire();");
            }, 2000);
        }).catch(error => {
            this.showSpinner = false;
            this.pushMessage('Error', 'error', 'Ha ocurrido un error, por favor contacte a su admin.');
        });
    }

    validationBeneficiario(){
        for(let i=0; i<this.data.listBeneficiarios.length; i++){
            if(this.data.listBeneficiarios[i].cuentaId == null || this.data.listBeneficiarios[i].tipoBeneficiario == null ||
                this.data.listBeneficiarios[i].primerNombre == null || this.data.listBeneficiarios[i].primerApellido == null ||
                this.data.listBeneficiarios[i].tipoIdentificacion == null || this.data.listBeneficiarios[i].identificacion == null ||
                this.data.listBeneficiarios[i].sexo == null || this.data.listBeneficiarios[i].fechaNacimiento == null ||
                this.data.listBeneficiarios[i].parentesco == null || this.data.listBeneficiarios[i].porcentaje == null ){
                    return true;
            }
        }
        for(let j=0; j<this.data.listPorcentajes.length; j++){
            this.data.listPorcentajes[j].porcentajeDireto = 0;
            this.data.listPorcentajes[j].porcentajeContingencia = 0;
        }
        //Validación porcentajes
        for(let i=0; i<this.data.listBeneficiarios.length; i++){
            for(let j=0; j<this.data.listPorcentajes.length; j++){
                if(this.data.listBeneficiarios[i].cuenta == this.data.listPorcentajes[j].cuenta){
                    if(this.data.esBeneficiarioDirecto){
                        this.data.listPorcentajes[j].porcentajeDireto += parseFloat(this.data.listBeneficiarios[i].porcentaje);
                    }else{
                        this.data.listPorcentajes[j].porcentajeContingencia += parseFloat(this.data.listBeneficiarios[i].porcentaje);
                    }
                }
            }
        }
        for(let j=0; j<this.data.listPorcentajes.length; j++){
            if(this.data.listPorcentajes[j].cuenta == this.data.cuentaSelecionadaLabel && this.data.listPorcentajes[j].porcentajeDireto != 100 && this.data.esBeneficiarioDirecto){
                this.pushMessage('Advertencia', 'warning', 'En la cuenta '+this.data.listPorcentajes[j].cuenta+' el porcentaje de los beneficiarios directos esta en '+this.data.listPorcentajes[j].porcentajeDireto+'%');
                return;
            }else if(this.data.listPorcentajes[j].cuenta == this.data.cuentaSelecionadaLabel && this.data.listPorcentajes[j].porcentajeContingencia != 100 && !this.data.esBeneficiarioDirecto){
                return true;
            }
        }
        return false;
    }

    mapPrimeraCuenta(){
        if(this.data.cuentaSelecionada == null){
            this.data.cuentaSelecionada = this.data.listCuentas[0].value;
            this.data.cuentaSelecionadaLabel =  this.data.listCuentas[0].label;
        }
        this.changeCuentaMap();
    }

    pushMessage(title,variant,msj){
        const message = new ShowToastEvent({
            "title": title,
            "variant": variant,
            "message": msj
            });
            this.dispatchEvent(message);
    }
}