public class classPagoInteresesFPC {
    /*Variables en USO*/
    public string Cuenta { get; set; }		//1
    public string NombreCompleto {get;set;} //2
    public string Identidad { get; set; }	//3
    public string TipoFondo { get; set; }	//4
    public string CausaDescripcion{get;set;}//5
    public string EstadoCuenta { get; set; }//6
    
    public string Codigocausa { get; set; }//17
    
    public String Tipodepago { get; set; }	//7
    //public Double Montodepago { get; set; }	//8
    public string Montodepago { get; set; }	//8
    public String Ajuste { get; set; }		//9
    //public String Ajustes { get; set; }	
    public String Diadepago { get; set; }	//10
    public String Formadepago { get; set; }	//11
    public String Bancos { get; set; }		//12
    public String NoCuenta { get; set; }	//13
    public String TipodeCuenta { get; set; }//14
    public String EstadoAprobacion { get; set; }//15
    public string tocarcapital {get;set;}
    public string cheque {get;set;}
    public string tsp {get;set;}
    public string ach {get;set;} 
    
    public decimal pagocheque { get; set; }
    public decimal pagotsp {get;set;}
    public decimal pagoach {get;set;}
    
    public String TotalFondo { get; set; }
    public String CantidadPignorada { get; set; }
    public String Moneda { get; set; }
    public DateTime Fec_inclusion { get; set; }//16
    public DateTime fechaHasta { get; set; }
    public DateTime FechInicioPago { get; set;}  // Agregado 10072019
    //AGREGADO PARA CORREO
    public string idbitacora { get; set; }
    public string actividades { get; set; }
    public string eventos { get; set; }
    public date Fechapago { get; set; }
    public string accion { get; set; }
    public string valor { get; set; }
    public string codidocu { get; set; }
    public string usuarioregis { get; set; }
    public string usuariodenegacion { get; set; }
    public string paso { get; set; }
    
    public string LEE_ERRORES { get; set; }
    public string P_ERROR { get; set; }
    
    //COMPROBANTE
    public string pc_Imagen { get; set; }
    
}