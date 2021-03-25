@istest
public class testesatdodecuenta2 {

     static testmethod void Colavoradore()
    {
        
        test.startTest();
        
        classAportes aporte= new classAportes();
     aporte.Cuenta =''; 
     aporte.NombreCompleto ='';
     aporte.Moneda ='';
     aporte.FechaDeposito=date.today();  
     aporte.Monto='54'; 
    aporte.FormaPago ='';
     aporte.TipoSaldo ='';
    aporte.Cod_referencia =''; /*En esta variable se cargara una imagen*/
     aporte.ComisionSI =''; /*Aplica Comision*/
     aporte.ComisionNO=''; /*No Aplica Comision*/
     aporte.Comprobante =''; /*En esta variable se cargara una imagen*/
   
    
    //Variables nuevas
    aporte.montoDecimal =21;
    aporte.fechaAporteDate=date.today();
    aporte.fechaAporte='date.today()';
    aporte.indice =1;
   test.stopTest();
        
  		
    }
    

}