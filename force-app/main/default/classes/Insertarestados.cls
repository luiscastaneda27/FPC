public class Insertarestados {
    
    	@future(callout=true)
		public static void Inserttar()
        {
            try{
                
             list<account> todosclientes = new list<account>();
            list<account> clientes = new list<account>();
            list<string> idclientes= new list<string>();
            for(Correo_estado_cuenta__c item :[select cliente__C from Correo_estado_cuenta__c])
            {
                idclientes.add(item.cliente__C);
            }
            list<Correo_estado_cuenta__c> todoscorreos = new list<Correo_estado_cuenta__c>();
            //map<integer, list<account>> correosOrdenados = new map<integer, list<account>>();
            string correo1='notiene@ejemplo.hn';
            string correo2='notiene@example.com';
            decimal contador=0;
            if([select count() from Correo_estado_cuenta__c]>0)
            {
               contador = [select grupo__C from Correo_estado_cuenta__c order by grupo__C desc limit 1].grupo__C;
            }
            
            todosclientes = [Select id, identificacion__C From Account Where PersonEmail != null 
                             and PersonEmail !=:correo1 and PersonEmail != :correo2 and id not in :idclientes
                             and identificacion__C !=null limit 10000];
           
            integer numeroclientesGrupo=[select count() from Correo_estado_cuenta__c where grupo__C=:contador];
            for(integer i=0; i<todosclientes.size(); i++)
            {
                  clientes.add(todosclientes[i]); 
                if(clientes.size()==500 || i ==todosclientes.size()-1)
                {
                       contador++; 
                   
                  for(integer j=0; j<clientes.size(); j++)
                  {
                     todoscorreos.add(new Correo_estado_cuenta__c(cliente__C=clientes[j].id, grupo__C=contador, enviado__C=false)); 
                  }
                
                    clientes.Clear();
                }
            }
            //Database.BatchableContext BC; 
            database.insert(todoscorreos,false);
                system.debug('Exito'+ todoscorreos.size());
          }catch(Exception ex)
		{
                system.debug('Error: '+ex.getMessage()+' Linea: '+ex.getLineNumber());
        }
   }
		
}