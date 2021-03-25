({
    doInit: function(component, event, helper) {
        helper.inicio(component, event, helper);
        /*var action=component.get("c.init");
        action.setParams({nombre:component.get("v.titulo"),cuenta:component.get("v.numeroCuenta")});
        action.setCallback(this,function(response){
            var state=response.getState();
            if(state=='SUCCESS'){
                var result=response.getReturnValue();
                if(result!='fail'){
                    component.set("v.existe",false);
                    component.set("v.link",result);
                } 
                component.set("v.spiner",false);
            }else{
                console.log("Error init componente");
                component.set("v.spiner",false);
            }
        });
        $A.enqueueAction(action);*/
    },
    handleFilesChange: function(component, event, helper) {
        var fileName = 'No File Selected..';
        if (event.getSource().get("v.files").length > 0) {
            component.set("v.AIMG", false);
            fileName = event.getSource().get("v.files")[0]['name'];
        }
        component.set("v.fileName", fileName);
    },
    doSave: function(component, event, helper) {
        if (component.get("v.fileName")!='Sin archivo seleccionado..') {
            component.set("v.spiner",true);
            helper.uploadHelper(component, event);
        } else {
            alert('Seleccione un archivo');
        }
    },
    actualizar: function(component, event, helper) {
        component.set("v.existe",!component.get("v.existe"));
    }
})