trigger NuevosEmpleados on Empresa_X_Empleado__c (after insert) {
     List<Messaging.SingleEmailMessage> MessageList = new List<Messaging.SingleEmailMessage>();
    string nuevosEmpresados='';
    string empresa;
    
     list<string> identidades = new list<string>();
     for(integer i = 0; i < trigger.new.size() ; i++){
            identidades.add(trigger.new[i].empleado2__c);
        }
        
    string nombreEmpresa =[select name from Account where id=:trigger.new[0].empresa2__c].name;
    
    list<Account> empleados = new list<Account>();
    empleados =[select identificacion__c, name from Account where id in :identidades];
    
    for(integer i = 0; i < empleados.size() ; i++){        
         nuevosEmpresados+='Identidad: '+empleados[i].Identificacion__C+' Nombre: '+empleados[i].name+'\n';
       }
       
    list<correos__c> correos = new list<Correos__C>();
    correos =[select correo__c,name from correos__C where cargo__c='Afiliación Clientes Nuevos'];
     for(integer i=0; i<correos.size(); i++)
         {
                
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(new String[] {correos[i].correo__c});
                mail.setSenderDisplayName('FICOHSA PENSIONES Y CESANTíAS');
                mail.setSubject('Portal Empresarial Ficohsa');
                mail.setPlainTextBody('Buen día ' + correos[i].Name +'.\n\n La empresa ' +nombreEmpresa +
                                     ' a afiliado nuevos empleados con estos datos.\n'+nuevosEmpresados+' \n\n Muchas Gracias.' );
                MessageList.add(mail);             
         }
     Messaging.sendEmail(MessageList);
}