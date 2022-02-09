import { LightningElement, api, wire, track } from 'lwc';
import { getRecord, getFieldValue, updateRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import consultarCuentasParticipeEnGestor from '@salesforce/apex/ANEFI_ConsultarClienteEnGestorController.consultarCuentasParticipeEnGestor';

import COD_GESTOR from '@salesforce/schema/Account.Codigo_persona_en_Gestor__c';
import productosInversion from '@salesforce/label/c.anefi_ProductosInversion';

const CLIENTE_FIELDS = [COD_GESTOR];
const columns = [
    {label: 'Número cuenta', fieldName: 'numeroCuenta' }, 
    { label: 'Producto', fieldName: 'codigoProducto'},
    { label: 'Trader', fieldName: 'nombreTrader'},    
    {label: 'Fecha apertura', fieldName: 'fechaApertura'},
    {label: 'Estado', fieldName: 'estado' },
    {type: "button", initialWidth: 120, typeAttributes: {  
        label: 'Ver Detalle',  
        name: 'verDetalle',  
        title: 'Detalle',  
        disabled: false,  
        value: 'verDetalle',  
        iconPosition: 'left'
                 
    }},
    {type: "button", initialWidth: 100, typeAttributes: {  
        label: 'Aportes',  
        name: 'aportes',  
        title: 'aportes',  
        disabled: false,  
        value: 'aportes',  
        iconPosition: 'left'  
    }},
    {type: "button", initialWidth: 120, typeAttributes: {  
        label: 'Rescates',  
        name: 'rescastes',  
        title: 'rescates',  
        disabled: false,  
        value: 'rescates',  
        iconPosition: 'left'  
    }},
    {type: "button", initialWidth: 130, typeAttributes: {  
        label: 'Movimientos',  
        name: 'movimientos',  
        title: 'movimientos',  
        disabled: false,  
        value: 'movimientos',  
        iconPosition: 'left'  
    }},
    {type: "button", typeAttributes: {  
        label: 'Crear Aporte',  
        name: 'crearOportunidadAporte',  
        title: 'Crea Aporte',  
        disabled: false,  
        value: 'crearOportunidadAporte',  
        iconPosition: 'left'  
    }}


];
export default class Anefi_consultarCuentasParticipe extends NavigationMixin(LightningElement) {
    @api recordId;
    @track cuentasParticipe;
    @track columns = columns;
    cuentaParticipeSeleccionada;
    clienteCodigoGestor;
    @track mostrarTablaCuentas;
    @track mostrarMensajeSinCuentas;
    @track crearOportunidadAporteVisible = false;
    @track numeroCuentaSeleccionada;
    @track codigoProductoSeleccionado;
    @track nombreTipoRegistroCliente;
    @track tipoProductos = productosInversion;
    

    @wire(getRecord, { recordId: '$recordId', fields: CLIENTE_FIELDS })
    wiredRecord({ error, data }) {
        
        if (data) {
            this.nombreTipoRegistroCliente = data.recordTypeInfo.name;            
            this.clienteCodigoGestor = getFieldValue(data, COD_GESTOR);
            if(this.clienteCodigoGestor){
                //llamar el servicio para obtener cuentas de participe
                consultarCuentasParticipeEnGestor({ clienteId: this.recordId, codigoPersonaEnGestor: this.clienteCodigoGestor })
                .then((data) => {
                    console.log(data);
                    this.cuentasParticipe = data;
                    if( this.cuentasParticipe && this.cuentasParticipe.length > 0){
                        this.mostrarTablaCuentas = true;
                        this.mostrarMensajeSinCuentas = false;
                    }
                    else{
                        this.mostrarTablaCuentas = false;
                        this.mostrarMensajeSinCuentas = true;
                    }                    
                })
                .catch(error => {
                    console.log(error);                    
                });
            }
        }
    }

    callRowAction( event ) {    
        console.log('ingresa al método callRowAction');
        let numeroCuentaSeleccionada = event.detail.row.numeroCuenta;  
        const actionName = event.detail.action.name;
        this.obtenerCuentaParticipeSeleccionada(numeroCuentaSeleccionada);
        console.log('al inicio del método: ' + JSON.stringify(this.cuentaParticipeSeleccionada));
        console.log(this.cuentaParticipeSeleccionada);        
        if(this.cuentaParticipeSeleccionada){
            if ( actionName === 'verDetalle' ) {  
  
                this[NavigationMixin.Navigate]({  
                    type: 'standard__component',  
                    attributes: {  
                        componentName: "c__anefi_redireccionarADetalleCuentaParticipe"
                    },
                    state: {                        
                        c__clienteId: this.recordId,
                        c__codigoProducto : this.cuentaParticipeSeleccionada.codigoProducto,
                        c__nombreProducto : this.cuentaParticipeSeleccionada.nombreProducto,
                        c__codigoAgencia : this.cuentaParticipeSeleccionada.codigoAgencia,
                        c__nombreAgencia: this.cuentaParticipeSeleccionada.nombreAgencia,
                        c__codigoTrader : this.cuentaParticipeSeleccionada.codigoTrader,
                        c__nombreTrader : this.cuentaParticipeSeleccionada.nombreTrader,
                        c__numeroCuenta : this.cuentaParticipeSeleccionada.numeroCuenta,
                        c__codigoTipoCuenta : this.cuentaParticipeSeleccionada.codigoTipoCuenta,
                        c__nombreTipoCuenta : this.cuentaParticipeSeleccionada.nombreTipoCuenta,
                        c__fechaApertura : this.cuentaParticipeSeleccionada.fechaApertura,
                        c__estado : this.cuentaParticipeSeleccionada.estado,
                        c__nombreComponente : "DetalleCuenta"          

                    }  
                })  
      
            } else if ( actionName === 'aportes') {  
      
                this[NavigationMixin.Navigate]({  
                    type: 'standard__component',  
                    attributes: {  
                        componentName: "c__anefi_redireccionarAConsultarAportesCuenta"
                    },
                    state: {                        
                        c__clienteId: this.recordId,
                        c__codigoProducto : this.cuentaParticipeSeleccionada.codigoProducto,                       
                        c__numeroCuenta : this.cuentaParticipeSeleccionada.numeroCuenta,
                        c__clienteCodigoGestor: this.clienteCodigoGestor,
                        c__tipoTransaccion : 'aporte'
                    }  
                })
      
            }  
            else if ( actionName === 'rescastes') {                
                this[NavigationMixin.Navigate]({  
                    type: 'standard__component',  
                    attributes: {  
                        componentName: "c__anefi_redireccionarAConsultarRescatesCuenta"
                    },
                    state: {                        
                        c__clienteId: this.recordId,
                        c__codigoProducto : this.cuentaParticipeSeleccionada.codigoProducto,                       
                        c__numeroCuenta : this.cuentaParticipeSeleccionada.numeroCuenta,
                        c__clienteCodigoGestor: this.clienteCodigoGestor,
                        c__tipoTransaccion : 'rescate'
                    }  
                })  
      
            }
            else if ( actionName === 'movimientos') { 
                console.log('En consultar cuentas el valor es: ' + this.cuentaParticipeSeleccionada.codigoProducto);             
                this[NavigationMixin.Navigate]({  
                    type: 'standard__component',  
                    attributes: {  
                        componentName: "c__anefi_redireccionarAConsultarMovimientosCuenta"
                    },
                    state: {                        
                        c__clienteId: this.recordId,
                        c__codigoProducto : this.cuentaParticipeSeleccionada.codigoProducto,                       
                        c__numeroCuenta : this.cuentaParticipeSeleccionada.numeroCuenta,
                        c__clienteCodigoGestor: this.clienteCodigoGestor,
                        c__tipoTransaccion : '',
                        c__nombreProducto : this.cuentaParticipeSeleccionada.nombreProducto
                    }  
                })  
      
            }
            else if ( actionName === 'crearOportunidadAporte') { 
                this.numeroCuentaSeleccionada = this.cuentaParticipeSeleccionada.numeroCuenta;
                this.codigoProductoSeleccionado = this.cuentaParticipeSeleccionada.codigoProducto ;
                //Si no es un producto de fondos, no permite crear oportunidades
                console.log('this.codigoProductoSeleccionado: '+this.codigoProductoSeleccionado);
                if(this.tipoProductos.includes(this.codigoProductoSeleccionado)){
                    this.crearOportunidadAporteVisible = true;
                }
                else{
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error tipo producto',
                            message: 'No se pueden crear oportunidades de aporte para productos diferentes a fondos de inversión',
                            variant: 'error'
                        })
                    );
                }     
            }
            /*else if ( actionName === 'estadoCuenta') {              
                this[NavigationMixin.Navigate]({  
                    type: 'standard__component',  
                    attributes: {  
                        componentName: "c__pdfViewerExampleComponent"
                    },
                    state: {                        
                        c__clienteId: this.recordId,
                        c__codigoProducto : this.cuentaParticipeSeleccionada.codigoProducto,                       
                        c__numeroCuenta : this.cuentaParticipeSeleccionada.numeroCuenta,
                        c__clienteCodigoGestor: this.clienteCodigoGestor,
                        c__tipoTransaccion : ''
                    }  
                })  
      
            }
            else if ( actionName === 'estadoCuenta') {              
                this[NavigationMixin.Navigate]({  
                    type: 'standard__recordPage',  
                        attributes: {  
                            recordId: '0691h000001MpfUAAS',  
                            objectApiName: 'ContentDocument',  
                            actionName: 'view'  
                        }  
                })  
      
            }*/
            
        }            
  
    }
    
    obtenerCuentaParticipeSeleccionada(numeroCuenta){        
        for(let cuentaParticipe of this.cuentasParticipe){
            let numeroCuentaLocal = cuentaParticipe.numeroCuenta;
            if(numeroCuentaLocal === numeroCuenta){
                this.cuentaParticipeSeleccionada = cuentaParticipe;
                break;
            }

        }
    }

    handleCerrarModalCrearOportunidad(){
        this.crearOportunidadAporteVisible = false;
    }

    handleFinalizarCreacionOportunidad(){
       this.crearOportunidadAporteVisible = false;
    }

}