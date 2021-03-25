({
	doInit : function(component, event, helper) {
        var action=component.get("c.initCuenta");
        action.setParams({cuenta:component.get("v.numeroCuenta")});
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state=='SUCCESS'){
                var result=response.getReturnValue();
                if(result=='correcto'){
                    var lista=[];
                    lista.push({titulo:"COPIA ID PARTE FRONTAL"});
                    lista.push({titulo:"COPIA ID PARTE POSTERIOR"});
                    lista.push({titulo:"SELFIE CON ID"});
                    component.set("v.listArchivos",lista);
                }else{
                    component.set("v.verC",false);
                }
            }else{
                console.log("Error");
            }
        });
        $A.enqueueAction(action);
	},
    mostrarOc : function(component, event, helper) {
        if(component.get("v.icono")=='utility:right'){
            component.set("v.icono","utility:down");
            component.set("v.texto","Ocultar");
            component.set("v.ver",true);
        }else{
            component.set("v.icono","utility:right");
            component.set("v.texto","Mostrar");
            component.set("v.ver",false);
        }        
	}
})