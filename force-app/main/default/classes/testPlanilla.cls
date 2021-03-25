@isTest
public class testPlanilla {
    static testmethod void Planilla(){
        test.startTest(); 
        list<planilla> planil=new list<Planilla>(); 
        planil.add(new planilla('','','','','','','','',date.today(),'',7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7));
        planil.add(new planilla('','',7.7,7.7,7.7,7.7,7.7,''));
        list<cuenta> vf= new list<cuenta>();
        vf.add(new cuenta('',54.54));
       // planil.add(new planilla('','','','','',7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,vf,vf));
        //planil.add(new planilla('','','','','',7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,vf,vf,'','',''));
        planil.add(new planilla('','','','','',7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,''));
        planil.add(new planilla('','','','','',7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7));
        planil.add(new planilla('',1));
        planil.add(new planilla('',1,''));
        planil.add(new planilla('',7.7,7.7,7.7,7.7,7.7,7.7,7.7,7.7));
        planil.add(new planilla('','',date.today(),'',9.0,'',''));
        planil.add(new planilla('','','','','','',7.7,7.7));
        planil.add(new planilla('','','','','',7.7,7.7,7.7,7.7,7.7,7.7,7.7,8.7,'',9.9));
        planil.add(new planilla('', 1, 1.1, 1.1,1.1,1.1,1.1, 1.1,1.1,1.1));
        planil.add(new planilla('', '', date.today(), '' ,21.12,'','', '', '', '', ''));
        planil.add(new Planilla('', '', '','','', 32.32, 32.232, 32.32, 543.43,43.3,32.2, 32.4,43.3,/**/
                    43.43, vf, vf, vf, vf, vf));
        
        planil.add(new planilla('', '', '','','', 1.1, 1.1, 3.3, 2.2,43.3, 43.43, 43.3,43.43,43.43, vf, vf,  vf, vf, vf, /**/'', '', ''));
        planil.add(new Planilla('', '', '','','', 32.32, 32.32,32.32, 32.32,32.32, 32.32, 32.32,32.32, 32.32,32.32,32.32, 32.32));
        
        test.stopTest();
    }

}