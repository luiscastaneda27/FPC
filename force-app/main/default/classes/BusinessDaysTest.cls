@isTest
public class BusinessDaysTest {
    
    @testSetup 
    static void setupMethod() {
        // no necesita insertar registros
    }
    
    static testMethod void BusinessDaysExecute(){
        BusinessDays SAC = new BusinessDays('Horario Oficiales SAC');
        BusinessDays comercial = new BusinessDays();
        Test.startTest();
        SAC.getNoOfBusinessDaysBetweenDates(DateTime.newInstance(2023, 01, 01, 16, 0, 0).addMonths(-3), System.now());
        SAC.addDays(DateTime.newInstance(2023, 01, 01, 16, 0, 0), 2);
        SAC.subtractDays(DateTime.newInstance(2023, 01, 01, 16, 0, 0), 2);
        SAC.getPreviousWorkingDay(DateTime.newInstance(2023, 01, 01, 16, 0, 0));
        SAC.getNextWorkingDay(DateTime.newInstance(2023, 01, 01, 16, 0, 0));
        SAC.isWorkingDay(DateTime.newInstance(2023, 01, 01, 16, 0, 0));
        Test.stopTest();
    }
}