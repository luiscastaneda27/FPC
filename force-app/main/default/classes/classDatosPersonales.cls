public with sharing class classDatosPersonales {

//************************************Datos personales****************************************    
				public string NoEmpleado {get;set;}//numero de empleado
    			public date FechIngCuenta {get;set;}//Fecha ingreso a la empresa
    			public string TipoId {get;set;}// tipo de identidad usada
    			public string NumEmpresa {get;set;}//numero de empresa
                public string Identificacion {get;set;}//identidad
				public string pNombre {get;set;}//Primer nombre del empleado
                public string sNombre {get;set;}//Segundo nombre del empleado
    			public string pApellido {get;set;}//Primer apellido del empleado
				public string sApellido {get;set;}//Segundo apellido del empleado
    			public string nacionalidades {get;set;}//Nacionalidad del empleado
    			public dateTime FechNac {get;set;}//Fecha nacimiento del empleado
    			public string sexo {get;set;}//Sexo del empleado
    			public string estadoCivil {get;set;}//estado civil del empleado
    			public string envio {get;set;}//Envio form
//*************************************Domicilio************************************************    
    			public string direccion {get;set;}//Direccion del empleado
    			//public string nroDireccion {get;set;}//codigo de direccion
    			//public string nroEdificio {get;set;}//Numero de edificio
    			public string codPais {get;set;}//Codigo de pais
    			public string codRegion {get;set;}//Codigo de region
    			public string codProvincia {get;set;}//Codigo de provincia
    			public string codCiudad {get;set;}//Codigo de ciudad
    			//public string codSector {get;set;}//Codigo Sector
    			public string telefono {get;set;}//Telefono contacto
    			public string celular {get;set;}
                public string correoEmpleado {get;set;}//Correo Empleado   

    public classDatosPersonales (String NoEmpleado, date FechIngCuenta, String TipoId, String NumEmpresa, String Identificacion,
                                 String pNombre, String sNombre, String pApellido, String sApellido, String nacionalidades,
                                 date FechNac, String sexo, String estadoCivil, String envio, String direccion, //String nroDireccion, 
                                 /*String nroEdificio*/ String codPais, String codRegion,String codProvincia, String codCiudad, 
                                 /*String codSector,*/ String telefono,String celular,String correoEmpleado){
        		this.NoEmpleado= NoEmpleado;
    			this.FechIngCuenta = FechIngCuenta;
    			this.TipoId = TipoId;
    			this.NumEmpresa = NumEmpresa;
                this.Identificacion = Identificacion;
				this.pNombre = pNombre;
                this.sNombre = sNombre;
    			this.pApellido = pApellido;
				this.sApellido = sApellido;
    			this.nacionalidades = nacionalidades;
    			this.FechNac = FechNac;
    			this.sexo =Sexo;
    			this.estadoCivil = estadoCivil;
    			this.envio = envio;
                //************
               this.direccion = direccion;
    		//	this.nroDireccion =nroDireccion;
    		//	this.nroEdificio = nroEdificio;
    			this.codPais = codPais;
    			this.codRegion = codRegion;
    			this.codProvincia = codProvincia;
    			this.codCiudad = codCiudad;
    		//	this.codSector = codSector;
    			this.telefono = telefono;
                this.celular = celular;
                this.correoEmpleado = correoEmpleado;                      
        
    }

    
}