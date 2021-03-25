@isTest
public class testcontroladorOficialxEmpresa {
	@isTest static void executeTest() {
    	Test.StartTest();
        	controladorOficialxEmpresa controller = new controladorOficialxEmpresa();
        	controller.idAsesor = '123456789';
        	controller.inicio();
        	controller.editar();
        	controller.Guardar();
        	controller.selectAsesor();
        	controller.selectOficial();
        Test.StopTest();
    }
}