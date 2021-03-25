public with sharing class classInfoAportSeg {
//*****************************Informacion de Aporte y seguro*********************************************
                public string aplicaSeguro { get; set;} //Aplica seguro S o N               
                public string ingresobrutocot { get; set;}//Salario o entradas de dinero del empleado
                public string producto { get; set; }//Producto que contrato
                public string subProducto { get; set; }//Especificacion del producto              
                public string periocidad { get; set; }//periodo de la cuota
                public string formaPago { get; set; }//forma de pago
                public string cuentaPago { get; set; }//Cuenta en la que se paga                
               // public string entePago { get; set; }//Ente donde realiza el pago
                public string tipoAporte { get; set; }//tipo de aporte
                public Decimal monteAporte { get; set; }//cantidad de apote                
                public Decimal monteAporteNeto { get; set; }//cantidad total de aporte
                public string ocupacionEmpleado { get; set; }//Ocupacion del empleado
                public string rtnEmpleador { get; set; }//RTN Empleado
                public string RTN { get; set; }//RTN Empleado
                public string razonSocial { get; set; }//Razon Social de la Empresa
                public string nombreEmpresa { get; set; }//Nombre Comercial de la Empresa
                public Date FechaIngreso { get; set; }//Fecha que Ingreso el empeado a la Empresa
                public string telefonoEmpresa { get; set; }//Telefono de la Empresa
                public string extEmpresa { get; set; }//Extension del empleado dentro de la empresa
                public string faxEmpresa { get; set; }//Fax de la empresa
                public string dirEmpresa { get; set; }//Direccion de la empresa
                public string correoEmpresa { get; set; }//Correo de la empresa
                public string tipoSolicitud { get; set; }//Fax de la empresa
                public string codPromotor { get; set; }//Codigo del Asesor
                public string nombrePromotor { get; set; }//Nombre del Asesor
     
public classInfoAportSeg (String aplicaSeguro, String ingresobrutocot, String producto, String subProducto,
                          String periocidad, String formaPago, String cuentaPago, /*String entePago,*/ String tipoAporte,
                          Decimal monteAporte, Decimal monteAporteNeto, String ocupacionEmpleado,String codPromotor, 
                          String nombrePromotor, String rtnEmpleador, String razonSocial,String nombreEmpresa,
                          Date FechaIngreso, String telefonoEmpresa, String extEmpresa,String faxEmpresa, 
                          String dirEmpresa, String correoEmpresa, String tipoSolicitud,String RTN){
                                    
        		this.aplicaSeguro = aplicaSeguro;               
              	this.ingresobrutocot = ingresobrutocot;
               	this.producto = producto;
                this.subProducto = subProducto;              
                this.periocidad = periocidad;
                this.formaPago = formaPago;
                this.cuentaPago = cuentaPago;                
               // this.entePago = entePago;
                this.tipoAporte = tipoAporte;
                this.monteAporte = monteAporte;                
                this.monteAporteNeto = monteAporteNeto;
                this.ocupacionEmpleado = ocupacionEmpleado;
                this.codPromotor = codPromotor;                
                this.nombrePromotor = nombrePromotor;
                this.rtnEmpleador = rtnEmpleador;
               	this.razonSocial = razonSocial;                
          	    this.nombreEmpresa = nombreEmpresa;
                this.FechaIngreso = FechaIngreso;
                this.telefonoEmpresa = telefonoEmpresa;                
                this.extEmpresa = extEmpresa;
                this.faxEmpresa = faxEmpresa;
                this.dirEmpresa = dirEmpresa;                
              	this.correoEmpresa=correoEmpresa;
                this.tipoSolicitud = tipoSolicitud;
                this.RTN = RTN;

    }
}