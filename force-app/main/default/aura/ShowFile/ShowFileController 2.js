({
    init: function(component, event, helper) {
        var action = component.get("c.getResultWrapper");
        action.setParams({
            recordId : component.get("v.recordId")
        });
        
        action.setCallback(this, function(response) {
            var object = response.getReturnValue();
            if(object != null){
                component.set("v.listFiles",  JSON.parse(object));
                let countFile = 0;
                let files = JSON.parse(object);
                for(let i = 0; i < files.length; i++){
                    countFile++
                    if(files[i].idFile2 != null){
                        countFile++
                    }
                }
                component.set("v.countFiles",  countFile);
            }
        });
        $A.enqueueAction(action);
        
    }
    
})