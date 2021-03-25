public class extensionImpresonCarnet {
    public list<ClassPersona> listPersonas {get;set;}
    public boolean esMasivo {get;set;}
    public boolean esPersonal {get;set;}
    
    public extensionImpresonCarnet(){
        inicio(ApexPages.currentPage().getParameters().get('id'));
    }
    
    public extensionImpresonCarnet(ApexPages.StandardController controller){
        inicio(controller.getId());
    }
    
    
    Public void inicio(String idCaso){
         try{
            esMasivo =false;
    		esPersonal =false;
            list<string> listIdentidades = new list<string>();
            for(Carnet_masivo__c item : [select id, identificacion__C from Carnet_masivo__c]){
                listIdentidades.add(item.identificacion__C);
            }
           case Caso  = new case();
            if(idCaso!=null){
                listIdentidades = new list<string>();
                Caso  = [select Account.lastname, status, Account.firstname, account.id, Account.identificacion__C,
                         id from case where id=:idCaso];
               if(caso.Status=='Cerrado'){
                     listIdentidades.add(caso.Account.identificacion__C);
                    esPersonal =true;
                }
            }else{
                esMasivo =true;
            }
            list<account> listClientes = [select identificacion__C, firstname, lastname from account where  identificacion__C in :listIdentidades];
            list<Cuentas__C> listcuentasSF = [select Cliente__r.identificacion__C, codigo__C from cuentas__C where Cliente__r.identificacion__C in :listIdentidades];
            list<string> listCuentas = new list<string>();
            classCuentas cuenta = new classCuentas();
            listPersonas = new list<ClassPersona> ();
            list<classCuentas> listCuentasCliente = new list<classCuentas>();
            for(Account cliente : listClientes){
                listCuentas = new list<string>();
                listCuentasCliente = new list<classCuentas>();
                for(Cuentas__C item: listcuentasSF){
                    if(item.Cliente__r.identificacion__C == cliente.identificacion__C){
                        listCuentas.add(item.codigo__C);
                    }
                }
                cuenta = new classCuentas();
                listCuentasCliente.add(cuenta);
                cuenta = new classCuentas();
                listCuentasCliente.add(cuenta);
                cuenta = new classCuentas();
                listCuentasCliente.add(cuenta);
                if(listCuentas.size()>=1){
                    listCuentasCliente[0].p1= listCuentas[0];
                }
                if(listCuentas.size()>=2){
                    listCuentasCliente[1].p1 = listCuentas[1];
                }
                if(listCuentas.size()>=3){
                    listCuentasCliente[2].p1 = listCuentas[2];
                }
                if(listCuentas.size()>=4){
                    listCuentasCliente[0].p2 = listCuentas[3];                    
                }
                if(listCuentas.size()>=5){
                    listCuentasCliente[1].p2 = listCuentas[4];
                }
                if(listCuentas.size()>=6){
                    listCuentasCliente[2].p2 = listCuentas[5];
                }
                if(listCuentas.size()>=7){
                    listCuentasCliente[0].p3 = listCuentas[6];
                }
                if(listCuentas.size()>=8){
                    listCuentasCliente[1].p3 = listCuentas[7];
                }
                if(listCuentas.size()>=9){
                    listCuentasCliente[2].p3 = listCuentas[8];
                }
                ClassPersona persona = new ClassPersona();
                persona.nombre = cliente.firstname.toUpperCase();
                persona.apellido = cliente.lastname.toUpperCase();
                persona.listcuentas = listCuentasCliente;
                persona.saltoPagina ='page-break-after: always';
                listPersonas.add(persona);
               
            }
            listPersonas[listPersonas.size()-1].saltoPagina = '';
           system.debug('Corrio exitoso');
        }catch(exception ex){
            system.debug('Error: '+ex.getMessage()+', Linea: '+ex.getLineNumber());
        }
    }
    public class ClassPersona{
        public string nombre{get;set;}
        public string apellido{get;set;}
        public string saltoPagina{get;set;}
        public list<classCuentas> listCuentas{get;set;}
    }
    
    public class classCuentas{
        public string P1{get;set;}
        public string  p2{get;set;}
        public string  p3{get;set;}
        
    }
    
}