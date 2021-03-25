public class socios {
    public decimal idGuardar {get;set;}
    public string AI_ID_EXTERNO {get;set;}
    public string pcnumeroidsoc{get;set;}
    public string nombresocio{get;set;} 
    public string tipo_persona{get;set;}
    public string nacionalidad{get;set;}
    public string NIVEL{get;set;}
    public double POR_PART_DIRECT{get;set;}
    public double POR_PART_INDIRECT{get;set;}
    public string NUMERO_ID_EMPRESA{get;set;}
    public string COT_BOLSA{get;set;}
    public string TIC_SYMBOL{get;set;}
   
    public socios(decimal idGuardar, string pcnumeroidsoc, string nombresocio, string tipo_persona, string nacionalidad, 
                  string NIVEL, double POR_PART_DIRECT, double POR_PART_INDIRECT, string NUMERO_ID_EMPRESA, 
                  string COT_BOLSA, string TIC_SYMBOL)
    {
        this.idGuardar = idGuardar;
        this.pcnumeroidsoc=pcnumeroidsoc;
        this.nombresocio=nombresocio;
        this.tipo_persona=tipo_persona;
        this.nacionalidad=nacionalidad;
        this.NIVEL=NIVEL;
        this.POR_PART_DIRECT=POR_PART_DIRECT;
        this.POR_PART_INDIRECT=POR_PART_INDIRECT;
        this.NUMERO_ID_EMPRESA=NUMERO_ID_EMPRESA;
        this.COT_BOLSA=COT_BOLSA;
        this.TIC_SYMBOL=TIC_SYMBOL;
    }


}