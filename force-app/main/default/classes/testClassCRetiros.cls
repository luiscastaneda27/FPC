@isTest
public class testClassCRetiros {
    static testMethod void classCRetiros()
    {
        classCRetiros h = new classCRetiros();
        test.startTest();
         //cuadreRetiros
        cuadreRetiros g = new cuadreRetiros('', '', '', 1.0, 1.0, 1.0, dateTime.now(), dateTime.now(), 1.0, '', 1.0, '', 1);
        //cuadreRetirosC
        cuadreRetirosC x = new cuadreRetirosC('', '', '', '',1.0, '', 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                          1.0, 1.0, dateTime.now(), dateTime.now(), 1.0, 1.0,
                          '', '', '', '', '', 1);
        //cuadreRetirosP
        cuadreRetirosP y = new cuadreRetirosP('', 1.0, '', '','',1.0, 
                           1.0, 1.0, 1.0, 1.0, 1.0, 1.0,
                           dateTime.now(), '', '', 
                           '', '', '', 1);
        
        cuadreRetirosI z = new cuadreRetirosI('', '', '', '',1.0, '', 
                          1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 
                          dateTime.now(), dateTime.now(), 1.0, 1.0,'', '', 
                          '', '', '', 1);
        test.stopTest();
    }

}