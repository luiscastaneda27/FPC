public with sharing class classPagoInteresesRegA {
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

        public string LEE_ERRORES { get; set; }
        public string P_ERROR { get; set; }
 		/*Variables en USO

        public classPagoInteresesRegA(
            string Cuenta,string NombreCompleto,string Identidad,string TipoFondo,string CausaDescripcion,string EstadoCuenta, 
            string Tipodepago,string Montodepago,string Ajuste,String Diadepago,String Formadepago,String Bancos, 
            String NoCuenta, String TipodeCuenta, String EstadoAprobacion, DateTime fechadeRegistro,decimal Id_pagointeres)
        {
    	this.Cuenta = Cuenta; 
            this.NombreCompleto = NombreCompleto; 
            this.Identidad = Identidad; 
            this.TipoFondo = TipoFondo;
            this.CausaDescripcion = CausaDescripcion;
            this.EstadoCuenta = EstadoCuenta; 
            this.Tipodepago = Tipodepago; 
            this.Montodepago = Montodepago;
            this.Ajuste = Ajuste;
            this.Diadepago = Diadepago; 
            this.Formadepago = Formadepago; 
            this.Bancos = Bancos; 
            this.NoCuenta = NoCuenta; 
            this.TipodeCuenta = TipodeCuenta; 
            this.EstadoAprobacion = EstadoAprobacion; 
            this.fechadeRegistro = fechadeRegistro;
            this.Id_pagointeres = Id_pagointeres;
    }*/
}