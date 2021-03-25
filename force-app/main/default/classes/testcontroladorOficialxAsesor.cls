@isTest
public class testcontroladorOficialxAsesor {
	@isTest static void executeTest() {
        Test.StartTest();
    		controladorOficialxAsesor controller = new controladorOficialxAsesor();  
        	controller.idAsesor = '123456789';
        	controller.inicio();
        	controller.editar();
        	controller.Guardar();
        	controller.selectAsesor();
        	controller.selectOficial();
        Test.StopTest();
    }
}