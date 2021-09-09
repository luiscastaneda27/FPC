public class classPagoInteresesReg {
    	public string Cuenta { get; set; }		    //1
        public string NombreCompleto { get; set; }  //2
        public string Identidad { get; set; }	    //3
        public string TipoFondo { get; set; }       //4
        public string CausaDescripcion { get; set; }//5
        public string Cod_Causa { get; set; }       //5.1
        public string EstadoCuenta { get; set; }    //6

        public string Tipodepago { get; set; }	    //7
        public string Montodepago { get; set; } 	//8
        public string Ajuste { get; set; }		    //9
        public string Diadepago { get; set; }	    //10
        public string Formadepago { get; set; } 	//11
        public string Bancos { get; set; }		    //12
        public string NoCuenta { get; set; }	    //13
        public string TipodeCuenta { get; set; }    //14
        public string EstadoAprobacion { get; set; }//15
        public Decimal Id_pagointeres { get; set; } //16

        public string TotalFondo { get; set; }
        public string CantidadPignorada { get; set; }
        public string Moneda { get; set; }
        public DateTime fechadeRegistro { get; set; }
        public DateTime fechadeActivacion { get; set; }
        public DateTime fechaHasta { get; set; }

    	public string Variable { get; set; }
        public string LEE_ERRORES { get; set; }
        public string P_ERROR { get; set; }
    
    public Boolean tieneArchivoSF { get; set; }
 		/*Variables en USO*/

}