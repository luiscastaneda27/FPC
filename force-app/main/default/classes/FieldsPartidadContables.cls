public with sharing class FieldsPartidadContables {
    public List<Partida> partidas {get;set;} 
    public class Partida { 
        public String Id_banco {get;set;}
        public String Monto {get;set;}
        public String cta_contable_debito {get;set;}
        public String cta_contable_credito {get;set;}
        public String moneda {get;set;}
        public String Modulo {get;set;}
        public String tip_nota {get;set;}
        public String observacion {get;set;}
        public String observacion_c {get;set;}
        public String tip_transac {get;set;}
        public String sub_aplicacion {get;set;}
        public DateTime fecha {get;set;}
    }
}