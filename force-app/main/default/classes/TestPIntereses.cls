@isTest
public class TestPIntereses {
    static testMethod void ControlerPIntereses(){
        ControlerPIntereses pi = new ControlerPIntereses();
        pi.error = '';
        pi.Usuario = '';
        pi.enviado = '';
        pi.Fechapintereses = null;
        pi.mostrarTablaIntereses = false;
        pi.ListPagosIntereses = null;
        pi.tama = 0;
        pi.Guardar();
        pi.BuscarIntereses();

		ControlerPIntereses pi2 = new ControlerPIntereses(); 
        pi2.Fechapintereses = date.valueOf(dateTime.now());
        pi2.Guardar();
        
        ControlerPIntereses pi3 = new ControlerPIntereses(); 
        pi3.error = null;
        pi3.Guardar();
		
        ClassConsultaInteres consul = new ClassConsultaInteres();
        consul.Cuenta = '36272';
        consul.Diapago = '23';
        consul.Identidad = '73927378289';
        consul.Nombre = 'norman';
        consul.TipoPago ='ACH';
        ClassConsultaInteres fcsdd = ControllerAPIPagaInteres.BuscaPerIntereses(date.valueof(Datetime.now()));
        ClassPagarIntereses bitacora2 = new ClassPagarIntereses();
        String resultado4 = ControllerAPIPagaInteres.guardarfecha(bitacora2);


    }
}