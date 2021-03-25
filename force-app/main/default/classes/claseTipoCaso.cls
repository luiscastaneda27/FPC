public  class claseTipoCaso {
    public boolean estadoCuenta{get;set;}
    public boolean subProducto{get;set;}
    public boolean retiros{get;set;}
    public boolean actInformacion{get;set;}
    public boolean aumDisAporte{get;set;}
    public boolean reversiones{get;set;}
    public boolean constancias{get;set;}
    public boolean reposicionCarnet{get;set;}
    public boolean otros{get;set;}
    
    public claseTipoCaso(String tipoRegistro){
    	estadoCuenta = false;
        subProducto = false;
        retiros = false;
        actInformacion = false;
        aumDisAporte = false;
        reversiones = false;
        constancias = false;
        reposicionCarnet = false;
        otros = false;
        
        if(tipoRegistro == 'Estados_Cuenta'){
            estadoCuenta = true;
        }else if(tipoRegistro == 'Cambio_Subproducto'){
            subProducto = true;
        }else if(tipoRegistro == 'Retiros'){
            retiros = true;
        }else if(tipoRegistro == 'Actualizacion_informacion'){
            actInformacion = true;
        }else if(tipoRegistro == 'Aumento_Disminucion_Aportes'){
            aumDisAporte = true;
        }else if(tipoRegistro == 'Reversiones'){
            reversiones = true;
        }else if(tipoRegistro == 'Constancia'){
            constancias = true;
        }else if(tipoRegistro =='Reposicion_Carnet'){
            reposicionCarnet = true;
        }else if(tipoRegistro =='Otros'){
        	otros = true;
        }       
    }
}