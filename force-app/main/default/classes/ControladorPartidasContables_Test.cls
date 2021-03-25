@IsTest
public class ControladorPartidasContables_Test {
    
    public static string str; 
	
    static testMethod void Execute(){
        try{
            str = '"FONDO","FECHA","DESCRIPCION","DESCRIPCION_NOTA","N°_DOC.","MONEDA","MONTO","CODIGO","DESCRIPCION_DEBITO","DESCRIPCION_CREDITO"'+'\n'+
                  '101,"6/2/20","Transferencia entre Cuentas","Transferencia de la cuenta XXXXXXXX9182 de ADMINISTRADORA DE FONDOS DE PENSION a la cuenta 8493502 de ADMINISTRADORA DE FONDOS DE la cantidad de 404.00 HNL por motivo de Tralado de puntos futura pend","FT201546BRJ4","HNL",404152.56,"CM","Lorem ipsum","Lorem ipsum"';  
                
            //Inicio Metadatos
            List<Partida_contable__mdt> partidas = [Select id,Fondo__c,Codigo__c,Id_Banco_Debito__c,Id_Banco_Credito__c,Moneda__c,Cuenta_Debito__c,Cuenta_Credito__c,Modulo__c,Tipo_Nota__c,Tipo_Transaccion__c,Sub_Aplicacion__c From Partida_contable__mdt];
            System.debug('partidas: '+partidas);
            //Fin Metadatos
                    
            List<Rezago__c> rezDel = [SELECT Id FROM Rezago__c ];
            Delete rezDel;
            
            List<Rezago__c> rezList = new List<Rezago__c>();
            Rezago__c rez = new Rezago__c(Name = 'Test', Fondo__c ='113', Codigo__c = '123', Banco__c = 'Banco Ficohsa', Cuenta_Debito__c = '111121010001', Cuenta_Credito__c = '111121020001', Modulo__c = 'Bancos', Tipo_Transaccion__c = '55', Sub_Aplicacion__c = '65', Tipo_Nota__c = 'C', Monto_del_deposito__c = '307105.31', Moneda_del_deposito__c = 'HNL', Descripcion_Debito__c = 'Test', Descripcion_Credito__c = 'Test', Fecha_del_deposito__c = System.today(), Descripcion__c = 'Test', Descripcion_Nota__c  = 'Test', N_Doc__c = '123', Referencia__c = '123', Asesor_Rezago__c = 'HN001');
            rezList.add(rez);
            insert rezList;
            System.debug('rezList: '+rezList);    
            
            Test.StartTest();
            ControladorPartidasContables c = new ControladorPartidasContables();
            ControladorPartidasContables.SUbirInformacion(str);
            c.Guardar();
            Test.StopTest();
        } catch(DmlException ex) {
        	System.debug('Error: '+ex.getMessage() + '-' + ex.getLineNumber());    
        }    
    }
}