public class controladorMatematicas {
    
    public integer tablaHasta{get;set;}
    public boolean popTabla{get;set;}
    public list<pregunta> listpreguntas{get;set;}
    
    public controladorMatematicas(){
        popTabla = true;
    }
    
    public void Inicio(){
        cerrar();
        listpreguntas = new list<pregunta>();
        for(integer i=2; i<=tablaHasta; i++){
            for(integer j=2; j<11; j++){
                pregunta p = new pregunta();
                p.textoPregunta = i+'X'+j;
                p.resultado =  i*j;
                listpreguntas.add(p);
            }
             
        }
        for(integer i=3; i<=100; i++){
           Integer randomNumber = Integer.valueof((Math.random() * listpreguntas.size()));
            Integer randomNumber2 = Integer.valueof((Math.random() * listpreguntas.size()));
            pregunta p = new pregunta();
            p = listpreguntas[randomNumber];
            listpreguntas[randomNumber] = listpreguntas[randomNumber2];
            listpreguntas[randomNumber2] = p;
        }
        while(listpreguntas.size() >= 12 ){
            listpreguntas.remove(1);
            
        }
        
        system.debug('listPreguntas '+listpreguntas);
    }
    
    public void cerrar(){
        popTabla = false;
    }
    
    public void revisar(){
        for(pregunta item: listPreguntas){
            if(item.resultadoUsuario == item.resultado){
                item.buena = true;
            }else{
                item.mala = true;
            } 
        }
    }
    
    public void nuevasPreguntas(){
        popTabla = true;
    }
    
    public class pregunta{
        public string textoPregunta {get;set;}
        public integer resultado{get;set;}
        public integer numero1{get;set;}
        public integer numero2{get;set;}
        public integer resultadoUsuario {get;set;}
        public boolean buena {get;set;}
        public boolean mala {get;set;}
        
    }

}