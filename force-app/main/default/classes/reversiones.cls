public class reversiones
    {
        public datetime fecha{get;set;}
        public decimal aporte{get;set;}
        public decimal Saldo_diario_inicial{get;set;}
        public decimal comision_x_aporte{get;set;}
        public decimal comision_x_saldo_diario{get;set;}
        public decimal rendimiento_diario{get;set;}
        public decimal VC{get;set;}
        public decimal crecimidiario_VC{get;set;}
        public decimal saldo_final{get;set;}
        
        public reversiones(datetime fecha, decimal aporte, decimal saldoI, decimal comiApor, decimal comisi ,decimal rendimientod,
                               decimal vc, decimal crecimientovc, decimal saldof)
        {
            this.aporte= aporte;
            this.fecha=fecha;
            this.Saldo_diario_inicial=saldoi;
            this.comision_x_aporte=comiApor;
            this.comision_x_saldo_diario= comisi;
            this.rendimiento_diario = rendimientod;
            this.vc = vc;
            this.crecimidiario_VC = crecimientovc;
            this.saldo_final = saldof;
        }        
        
    }