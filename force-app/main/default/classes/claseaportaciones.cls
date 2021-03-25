public class claseaportaciones {
 
    public string Num_identidad{set;get;}
    public string Num_cuenta{set;get;}
    public decimal apv{set;get;}
    public decimal aev{set;get;}
    //
    public decimal ape{set;get;}
    public decimal apx{set;get;}
    public decimal asv{set;get;}
    //
    public string idsalesforce{set;get;}
    
     public claseaportaciones(string identidad, string cuenta, decimal APV, decimal AEV, decimal APE, decimal APX, decimal ASV, string idsalesforce)
    {
        this.Num_identidad=identidad;
        this.Num_cuenta= cuenta;
        this.apv=apv;
        this.aev=aev;
        //
        this.ape=ape;
        this.apx=apx;
        this.asv=asv;
        //
        this.idsalesforce=idsalesforce;
    }
    
    
}