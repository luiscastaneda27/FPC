@isTest(seeAllData = true)
public class testcontrollerPortalFPC{
    static testMethod void  portalFPC() {
      //  try{
        Account cliente = new Account();
        cliente.Name = 'Prueba test';
        cliente.Identificacion__c = '6124568789540';
        insert cliente;
        Lead candid = new lead();
        candid.FirstName='Hola';
        candid.LastName='fghj';
        candid.Identificacion__c='0811';
        insert candid;
        
      //  Lead candid = [Select Identificacion__c From Lead Where Identificacion__c != null Limit 1 ];
        
        test.startTest();
            controllerPortalFPC control = new controllerPortalFPC();
        
            List<SelectOption> selOpts = control.getPaises();
            List<SelectOption> selOpts2 = control.getDepart();
        
            control.llenarPais();
            control.llenarDepartamento();
        
            controllerPortalFPC controller = new controllerPortalFPC();
               
            control.identidad = '';
            control.buscar();
            control.identidad = cliente.Identificacion__c;
            control.buscar();
            control.identidad = '6667778889990';
            control.buscar();
            //control.cliente = control.cuentas[0];           
            control.ver();
            control.identidad = '532453253425324535';
            control.buscar();
            control.identidad = candid.Identificacion__c;
            control.buscar();
            control.verimprimir2();
            control.candidato.Motivo_Contacto__c = 'Asesoría Producto Individual';
            control.imprimir();
            control.candidato.Motivo_Contacto__c = 'Asesoría Producto Empresarial';
            control.imprimir();
            control.verDoc = true;
            control.documentos();
            control.verDoc = false;
            control.documentos();
            control.ver();
            control.crear();
            control.candidato.Telefono_Trabajo__c = '7889455612';
            control.candidato.Phone = '33899237';
            control.guardarPop();
            control.candidato.Telefono_Trabajo__c = '33091530';
            control.guardarPop();
            control.registrarLlamada();
            control.fantasma.Telefono_actual__c = '123456789';
            control.guardarLlamada();
            control.fantasma.Telefono_actual__c = '99990294';
            control.guardarLlamada();
            control.cerrar();
            
            control.identidad = '6667778889990';
            control.buscar();
            //control.cliente = control.cuentas[0];
            control.buscarCasos();
            //control.nuevoCaso();
            control.verCaso();
            
        test.stopTest();
          /*  }catch(exception ex){
            
        }*/
    }
    
    
}