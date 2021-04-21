public class classPagoInteresesFPC {
    /*Variables en USO*/
    public String Cuenta { get; set; }		//1
    public String nombreCompleto {get;set;} //2
    public String identidad { get; set; }	//3
    public String tipoFondo { get; set; }	//4
    public String causaDescripcion{get;set;}//5
    public String estadoCuenta { get; set; }//6
    
    public String codigocausa { get; set; }//17
    
    public String tipodepago { get; set; }	//7
    //public Double Montodepago { get; set; }	//8
    public String montodepago { get; set; }	//8
    public String ajuste { get; set; }		//9
    //public String Ajustes { get; set; }	
    public String Diadepago { get; set; }	//10
    public String Formadepago { get; set; }	//11
    public String Bancos { get; set; }		//12
    public String NoCuenta { get; set; }	//13
    public String TipodeCuenta { get; set; }//14
    public String tocarcapital {get;set;}
    public String cheque {get;set;}
    public String tsp {get;set;}
    public String ach {get;set;} 
    
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
    public String idbitacora { get; set; }
    public String actividades { get; set; }
    public String eventos { get; set; }
    public date Fechapago { get; set; }
    public String accion { get; set; }
    public String valor { get; set; }
    public String codidocu { get; set; }
    public String usuariodenegacion { get; set; }
    public String paso { get; set; }
    
    public String LEE_ERRORES { get; set; }
    public String P_ERROR { get; set; }
    
    //COMPROBANTE
    public String pc_Imagen { get; set; }
    
    //CAMPOS AÑADIDOS POR INTELLECT
    public String estadoAprobacion { get; set; }  
    public String usuarioRegis { get; set; } //El Usuario que ingresó el caso
    public DateTime ultFec_inclusion { get; set; } //Última Fecha de Pago de Intereses
    //public String ultFec_inclusionString { get; set; }
    public String ultPago { get; set; } //Monto del último pago
    public Decimal ultPagoView { get; set; } //Monto del último pago
    public String ultUsuCaso {get; set;}
    
}