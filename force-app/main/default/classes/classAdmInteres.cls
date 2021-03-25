public class classAdmInteres {
/*	public date fecha_retiro {get;set;}
    public datetime fechaSysdeRetiros {get;set;}
*/
    public date fec_inclusion {get;set;}
    public string v_dia { get; set; }
    public List<classPagoInteresesReg> ListIntRegistrados {get;set;}
    public List<classPagoInteresesRegA> ListIntAprobados {get;set;}
    
    public classAdmInteres(){
    	ListIntRegistrados =new List<classPagoInteresesReg>(); 
        ListIntAprobados =new List<classPagoInteresesRegA>(); 
    }

}