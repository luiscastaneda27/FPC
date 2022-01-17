({
    MAX_FILE_SIZE: 4500000, //Max file size 4.5 MB 
    CHUNK_SIZE: 250000,      //Chunk Max size 750Kb 
    
    uploadHelper: function(component, event) {
        console.log("INICIOUPHELPE");
        var fileInput = component.find("fileId").get("v.files");
        var file = fileInput[0];
        var self = this;
        if (file.size > self.MAX_FILE_SIZE) {
            console.log("tamano");
            component.set("v.fileName", 'Alerta : Máximo tamaño de archivo ' + self.MAX_FILE_SIZE + ' bytes.\n' + ' Archivo seleccionado: ' + file.size);
            component.set("v.spiner",false);
            alert("El archivo es demasiado grande");
            return;
        }
        console.log("read");
        var objFileReader = new FileReader(); 
        objFileReader.onload = $A.getCallback(function() {
            var fileContents = objFileReader.result;
            var base64 = 'base64,';
            var dataStart = fileContents.indexOf(base64) + base64.length;            
            fileContents = fileContents.substring(dataStart);
            self.uploadProcess(component, file, fileContents);
        });
        objFileReader.readAsDataURL(file);
    },
    
    uploadProcess: function(component, file, fileContents) {
        console.log("INICIOUPProcess");
        var startPosition = 0;
        var endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
        this.uploadInChunk(component, file, fileContents, startPosition, endPosition, '');
    },
    
    
    uploadInChunk: function(component, file, fileContents, startPosition, endPosition, attachId) {
        console.log("INICIOUPinchun:"+startPosition+',end:'+endPosition);
        
        var getchunk = fileContents.substring(startPosition, endPosition);
        var action = component.get("c.saveChunk");
        action.setParams({
            parentId: component.get("v.numeroCuenta"),
            fileName: component.get("v.titulo"),
            base64Data: encodeURIComponent(getchunk),
            contentType: file.type,
            fileId: attachId
        });
        console.log("callback");
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            console.log("state:"+state);
            if (state == "SUCCESS") {                
                attachId = response.getReturnValue().principal;
                var error=response.getReturnValue().error;
                var errorM=response.getReturnValue().errorMsj;
                console.log("correcto");
                if(error!="fail"){
                    
                    console.log("no fail");
                    startPosition = endPosition;
                    endPosition = Math.min(fileContents.length, startPosition + this.CHUNK_SIZE);
                    if (startPosition < endPosition) {
                        component.set("v.progress",(endPosition*100)/fileContents.length);
                        this.uploadInChunk(component, file, fileContents, startPosition, endPosition, attachId);
                    } else {
                        component.set("v.progress",(endPosition*100)/fileContents.length);
                        component.set("v.spiner",false);
                        alert("Archivo cargado correctamente");
                        //location.reload();
                        helper.inicio(component, event, helper);
                    }
                }else{
                    component.set("v.spiner",false);
                    console.log("fail");
                    alert(errorM);
                }
            } else if(state == "INCOMPLETE"){
                if (startPosition < endPosition) {
                    this.uploadInChunk(component, file, fileContents, startPosition, endPosition, attachId);
                } else {
                    component.set("v.spiner",false);
                    alert("Archivo cargado correctamente");
                    location.reload();
                }
            }else{
                console.log("error"+response.getState());
                alert("error"); 
            }
        });
        $A.enqueueAction(action);
    },
    inicio: function(component, event, helper) {
        var action=component.get("c.init");
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
        $A.enqueueAction(action);
    }
})