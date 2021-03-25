@isTest
public class UploadFileController_TEST {
	@isTest
    public static void metodo1(){
        UploadFileController.saveChunk('2345', 'test', 'gdgundi76556a78d', 'aplication/pdf', '');
        Cuenta_Formularios__c cuf=new  Cuenta_Formularios__c();
        cuf.Cuenta__c='2345';
        insert cuf;
        Test.startTest();
        UploadFileController.saveChunk('2345', 'test', 'gdgundi76556a78d', 'aplication/pdf', '');
        UploadFileController.saveChunk('2345', 'test', 'gdgundi76556a78d', 'aplication/pdf', cuf.Id);
        UploadFileController.initCuenta('1');
        UploadFileController.initCuenta('2345');
        UploadFileController.init('test', '2');
        UploadFileController.init('test', '2345');
        Cuenta_Formularios__c cuf2=new  Cuenta_Formularios__c();
        cuf2.Cuenta__c='8888';
        insert cuf2;
        UploadFileController.init('testw', '2345');
        Test.stopTest();
    }
}