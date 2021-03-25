public with sharing class classPlanilla {
    public String codigo { get; set; }
    public String tipo { get; set; }
    public String empresa { get; set; }
    public DateTime fecha { get; set; }
    public Decimal tasaCompra { get; set; }
    public String tipoMoneda { get; set; }
    public String estado { get; set; }
    public Decimal aportePatronalObligatorio { get; set; }
    public Decimal aportePatronalVoluntario { get; set; }
    public Decimal aportePersonalObligatorio { get; set; }
    public Decimal aportePersonalVoluntario { get; set; }
    //
    public Decimal aportePersonalExtraordinario { get; set; }
    public Decimal aportePatronalExtraordinario { get; set; }
    public Decimal aporteSeguroVida { get; set; }
    //
    public Decimal reservaLaboral { get; set; }
    public Decimal total { get; set; }
    public Integer numeroEmpleados { get; set; }
    public List<classContenidoPlanilla> contenido { get; set; } 
    

    public class classContenidoPlanilla
    {
        public String codigoContenido { get; set; }
        public String identificacion { get; set; }
        public Decimal pilarComplementarioPatronal { get; set; }
        public Decimal pilarComplementarioPersonal { get; set; }
        public Decimal pilarVoluntarioPatronal { get; set; }
        public Decimal pilarVoluntarioPersonal { get; set; }
        //
        public Decimal pilarVoluntarioPersonalExt { get; set; }
        public Decimal pilarVoluntarioPatronalExt { get; set; }
        public Decimal pilarVoluntarioSeguroVida { get; set; }
        //
        public Decimal reservaLaboral { get; set; }
        public Decimal salario { get; set; }
        public List<classCuentaPlanilla> cuentas { get; set; }
    }
    
    public class classCuentaPlanilla
    {
        public String tipoDeduccion { get; set; }
        public String cuenta { get; set; }
        public Decimal montoPatronal { get; set; }
        public Decimal montoPersonal { get; set; } 
    }
}