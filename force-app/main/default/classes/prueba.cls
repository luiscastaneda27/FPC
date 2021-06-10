public class prueba {

    public Account cc{get;set;}
    
    public prueba(){
        cc = [Select Id from Account where id = '0015400000MHUAOAA5' limit 1];
    }
    
    
    
}