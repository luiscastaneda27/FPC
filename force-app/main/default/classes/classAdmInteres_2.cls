public class classAdmInteres_2 {
/*	public date fecha_retiro {get;set;}
    public datetime fechaSysdeRetiros {get;set;}
*/
    public date fec_inclusion {get;set;}
    public List<classPagoInteresesRegA> ListIntRegistrados {get;set;}
    public List<classPagoInteresesRegA> ListIntAprobados {get;set;}
    
    public classAdmInteres_2(){
    	ListIntRegistrados =new List<classPagoInteresesRegA>(); 
        ListIntAprobados =new List<classPagoInteresesRegA>(); 
    }

}