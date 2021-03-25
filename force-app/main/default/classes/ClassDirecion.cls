public class ClassDirecion {
    public string codDireccion { get; set; }
    public string tipDireccion { get; set; }
    public string detalleDir { get; set; }
    public string paisDir { get; set; }
    public string deptoDir { get; set; }
    public string ciuDir { get; set; }
    public string coloDir { get; set; }
    public string esDefault { get; set; }
    public decimal secuencia { get; set; }
    
    public ClassDirecion(string codDireccion, string tipDireccion, string detalleDir, string paisDir, string deptoDir, string ciuDir, string coloDir,
					     string esDefault, decimal secuencia){
        this.codDireccion =codDireccion;
        this.tipDireccion=tipDireccion;
        this.detalleDir=detalleDir;
        this.paisDir=paisDir;
        this.deptoDir=deptoDir;
        this.ciuDir=ciuDir; 
        this.coloDir=coloDir;
        this.esDefault=esDefault; 
        this.secuencia=secuencia;
                             
    }
}