@isTest
public class testAprobarClientesPEP {
    static testMethod void testAprobarClientesPEP(){
        test.startTest(); 
        controllerAprobarClientesPEP pep = new controllerAprobarClientesPEP();
        pep.mostrarLista();
        pep.AprobarPEP();
        pep.DenegarPEP();
        
        classAprobarClientesPEP classPEP = new classAprobarClientesPEP('','','','','','','');
        //classPEP.cargo = '';
         
    }

}