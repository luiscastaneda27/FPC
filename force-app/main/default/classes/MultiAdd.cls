public class MultiAdd {

    public boolean flag{get;set;}
    
    public MultiAdd() {
        flag = false;
    }
    
    
    public MultiAdd(ApexPages.StandardController ctlr){
    
    
    }
    
    public void changeFlag(){
        //flag = boolean.valueOf(ApexPages.currentPage().getParameters().get('flagValue'));
    }

}