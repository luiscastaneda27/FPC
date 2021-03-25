@isTest
public class UploadFileController_TESTAGN {
	@isTest
    public static void metodo1(){
        UploadFileControllerAGN.saveChunk('2345', 'test', 'gdgundi76556a78d', 'aplication/pdf', '');
        Cuenta_Formularios__c cuf=new  Cuenta_Formularios__c();
        cuf.Cuenta__c='2345';
        insert cuf;
        Test.startTest();
        UploadFileControllerAGN.saveChunk('2345', 'test', 'gdgundi76556a78d', 'aplication/pdf', '');
        UploadFileControllerAGN.saveChunk('2345', 'test', 'gdgundi76556a78d', 'aplication/pdf', cuf.Id);
        UploadFileControllerAGN.initCuenta('1');
        UploadFileControllerAGN.initCuenta('2345');
        UploadFileControllerAGN.init('test', '2');
        UploadFileControllerAGN.init('test', '2345');
        Cuenta_Formularios__c cuf2=new  Cuenta_Formularios__c();
        cuf2.Cuenta__c='8888';
        insert cuf2;
        UploadFileControllerAGN.init('testw', '2345');
        Test.stopTest();
    }
}