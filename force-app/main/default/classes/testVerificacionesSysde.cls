@isTest(SeeAllData=True)
public class testVerificacionesSysde {
    static testMethod void verificar(){
        Test.setMock(HttpCalloutMock.class, new testMocks());
        test.startTest();
            String CRON_EXP = '20 30 8 10 2 ?';
            String jobId = System.schedule('testTipoCambio', CRON_EXP, new verificarTipoCambioMoneda());
            
            jobId = System.schedule('testFechaCierre', CRON_EXP, new verificarFechaCierreSysde());
            
        test.stopTest();
    }
}