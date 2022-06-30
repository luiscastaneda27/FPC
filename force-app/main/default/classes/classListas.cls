public with sharing class classListas {
    public string numeroId{get;set;}
    public boolean PEP{get;set;}
    public boolean BLACKLIST{get;set;}
    public boolean AML{get;set;}
    public boolean FATCA{get;set;}   
    public boolean FATCANC{get;set;} 
    //agregadas 25-10-2019 walvarado
    public String RTN { get; set; }
    public String pctipoid { get; set; }
    public DateTime pcFechaVencimientoCN { get; set; }
    public String pcprimernombre { get; set; }
    public String pcsegundonombre { get; set; }
    public String pcprimerapellido { get; set; }
    public String pcsegundoapellido { get; set; }
    public DateTime pdfechanacimiento { get; set; }
    public String pdLugarNacimientoCN { get; set; }
    public String pcsexo { get; set; }
    public String pcestadocivil { get; set; }
    public String pcNombreConyuge { get; set; }
    public String pcProfesionOcupacion { get; set; }
    public String pcmail { get; set; }
    public String pcnacionalidad { get; set; }
    public String pcnacionalidad2 { get; set; }
    public String pcnacionalidad3 { get; set; }
    public String pcDependeSI { get; set; }
    public String pcDependeNO { get; set; }
    public String pcTipoIDDependencia { get; set; }
    public String pcNumeroIDDependencia { get; set; }
    public String pcNombreCompletoDependencia { get; set; }
    public String pc_ActuaSI { get; set; }
    public String pcNumeroIDPV { get; set; }
    public String pcNombreCompletoPV { get; set; }
    public String pcEjerce_Cargo_Publico { get; set; }
    public String Cargo_Pulbico { get; set; }
    public String pcAPNFD { get; set; }
    public String PCNumeroAPNFD { get; set; }
    public String PC_NIVEL_RIESGO { get; set; }
    public String PC_DEBIDA_DELIGENCIA { get; set; }
    //Campos from Fatca
    public String ES_Residente { get; set; }
    public String ES_Residente_EfectosMi { get; set; }
    public String PaisResidenciaEfectosFiscales { get; set; }
    public String NumeroID_Fiscal_EEUU { get; set; }
    public String NumeroID_Fiscal_OtroPais { get; set; } 
    public String pcPaisNacimiento { get; set; }
}